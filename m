From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH] mingw: do not crash on open(NULL, ...)
Date: Thu, 23 Sep 2010 22:08:56 +0200
Message-ID: <201009232208.56916.j6t@kdbg.org>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: "Erik Faye-Lund" <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:09:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oys6L-0003vp-JF
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab0IWUI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 16:08:59 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:53501 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756437Ab0IWUI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 16:08:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B674DA7EDB;
	Thu, 23 Sep 2010 22:08:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 046DF19F5C9;
	Thu, 23 Sep 2010 22:08:57 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156900>

On Donnerstag, 23. September 2010, Erik Faye-Lund wrote:
> @@ -297,7 +297,7 @@ int mingw_open (const char *filename, int oflags, ...)
>  	mode = va_arg(args, int);
>  	va_end(args);
>
> -	if (!strcmp(filename, "/dev/null"))
> +	if (filename && !strcmp(filename, "/dev/null"))
>  		filename = "nul";
>
>  	fd = open(filename, oflags, mode);

Good catch, thank you!

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
