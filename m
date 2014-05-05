From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] contrib/subtree/Makefile: clean rule cleanup
Date: Mon, 5 May 2014 01:09:39 -0400
Message-ID: <20140505050938.GB6569@sigill.intra.peff.net>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-2-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-3-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-4-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-5-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-6-git-send-email-nod.helm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, greend@obbligato.org, apenwarr@gmail.com,
	gpmcgee@gmail.com, mmogilvi_git@miniinfo.net
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhsr-0005Yp-IK
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbaEEFJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 01:09:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:45073 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754409AbaEEFJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 01:09:40 -0400
Received: (qmail 19713 invoked by uid 102); 5 May 2014 05:09:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 00:09:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 01:09:39 -0400
Content-Disposition: inline
In-Reply-To: <1399121375-14727-6-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248129>

On Sat, May 03, 2014 at 10:49:35PM +1000, James Denholm wrote:

> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index f3834b5..4f96a24 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -11,8 +11,9 @@ man1dir ?= $(mandir)/man1
>  
>  -include ../../GIT-VERSION-FILE
>  
> -# this should be set to a 'standard' bsd-type install program
> -INSTALL ?= install
> +# These should be set to 'standard' bsd-type programs
> +INSTALL  ?= install
> +RM       ?= rm -f

I do not think BSD-ism matters for "rm", as it works pretty much the
same everywhere. "install", on the other hand, is a bit weirder between
systems. So you might want to leave that comment as-is.

OTOH, we do not even bother with such a comment in the main Makefile.

-Peff
