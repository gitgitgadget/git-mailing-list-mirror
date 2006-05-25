From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation/Makefile: remove extra /
Date: Thu, 25 May 2006 13:45:55 -0700
Message-ID: <7v3bexu930.fsf@assigned-by-dhcp.cox.net>
References: <20060525123746.GA14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 22:46:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjMiW-0000Mz-1w
	for gcvg-git@gmane.org; Thu, 25 May 2006 22:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWEYUp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 16:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWEYUp5
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 16:45:57 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27350 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030408AbWEYUp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 16:45:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525204556.DFZF19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 16:45:56 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060525123746.GA14325@admingilde.org> (Martin Waitz's message
	of "Thu, 25 May 2006 14:37:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20762>

Martin Waitz <tali@admingilde.org> writes:

> As both DESTDIR and the prefix are supposed to be absolute pathnames
> they can simply be concatenated without an extra / (like in the main Makefile).
> The extra slash may even break installation on Windows.
>
> Signed-off-by: Martin Waitz <tali@admingilde.org>
> ---
>  Documentation/Makefile |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2a08f59..2b0efe7 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -52,9 +52,9 @@ man1: $(DOC_MAN1)
>  man7: $(DOC_MAN7)
>  
>  install: man
> -	$(INSTALL) -d -m755 $(DESTDIR)/$(man1) $(DESTDIR)/$(man7)
> -	$(INSTALL) $(DOC_MAN1) $(DESTDIR)/$(man1)
> -	$(INSTALL) $(DOC_MAN7) $(DESTDIR)/$(man7)
> +	$(INSTALL) -d -m755 $(DESTDIR)$(man1) $(DESTDIR)$(man7)
> +	$(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1)
> +	$(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7)

This unfortunately breaks a workaround I did in the main
Makefile for dist-doc target, but I agree it is a good change.
