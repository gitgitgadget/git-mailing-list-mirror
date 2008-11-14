From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: use proper data type in call to sizeof()
	within xrealloc
Date: Fri, 14 Nov 2008 01:24:34 -0500
Message-ID: <20081114062434.GA11907@coredump.intra.peff.net>
References: <2NXgsahhUCpkej6JukLNJjebzyoAQgZ4ptQMMrR2j_iWS5yEqKYn0kxHsUBpiY6bkpfbTjxlSn0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 14 07:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0s7q-0001IO-QS
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 07:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbYKNGYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 01:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYKNGYi
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 01:24:38 -0500
Received: from peff.net ([208.65.91.99]:1681 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbYKNGYh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 01:24:37 -0500
Received: (qmail 31677 invoked by uid 111); 14 Nov 2008 06:24:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Nov 2008 01:24:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2008 01:24:34 -0500
Content-Disposition: inline
In-Reply-To: <2NXgsahhUCpkej6JukLNJjebzyoAQgZ4ptQMMrR2j_iWS5yEqKYn0kxHsUBpiY6bkpfbTjxlSn0@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100952>

On Thu, Nov 13, 2008 at 02:20:37PM -0600, Brandon Casey wrote:

>  	int num = ++revs->num_ignore_packed;
>  
>  	revs->ignore_packed = xrealloc(revs->ignore_packed,
> -				       sizeof(const char **) * (num + 1));
> +				       sizeof(const char *) * (num + 1));

Maybe it would be even nicer as "sizeof(*revs->ignore_packed)"?

-Peff
