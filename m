From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] clean: add --null option
Date: Sat, 14 Apr 2012 21:38:35 +0200
Message-ID: <20120414193833.GA29999@ecki>
References: <1334426158-13607-1-git-send-email-rosslagerwall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 21:40:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ8pA-00068q-Ph
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 21:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab2DNTjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 15:39:51 -0400
Received: from smtpout12.highway.telekom.at ([195.3.96.74]:6443 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754857Ab2DNTjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 15:39:51 -0400
Received: (qmail 13420 invoked from network); 14 Apr 2012 19:39:48 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL607.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub83.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <rosslagerwall@gmail.com>; 14 Apr 2012 19:39:47 -0000
Content-Disposition: inline
In-Reply-To: <1334426158-13607-1-git-send-email-rosslagerwall@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195511>

On Sat, Apr 14, 2012 at 07:55:58PM +0200, Ross Lagerwall wrote:
>
> Add a --null (-z) option to git-clean which prints out the files
> and directories separated with a NUL character rather than '\n'.
> This makes it useful in conjunction with xargs -0.

Thanks. Looks sensible to me.

> -					printf(_("Removing %s\n"), qname);
> +					print_path(_("Removing %s\n"), qname,
> +						   use_nul);

Although exceeding the 80 column boundary, I think this would be more
readable without line break. If we want to stay within 80 columns, I
don't think you can use 5 levels of indentation at the same time.

You could also make use_nul a static global, although it probably does
not improve the situation much.
