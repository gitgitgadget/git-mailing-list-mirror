From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-patch: Support --attach
Date: Sat, 20 May 2006 11:00:11 -0700
Message-ID: <7vu07k1sr8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605201537290.17869@wbgn013.biozentrum.uni-wuerzburg.de>
	<e4n8b3$ari$1@sea.gmane.org>
	<Pine.LNX.4.63.0605201904320.31887@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pzk3831.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0605201945110.32590@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 20:00:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhVkQ-0003OF-JC
	for gcvg-git@gmane.org; Sat, 20 May 2006 20:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWETSAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 14:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWETSAP
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 14:00:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:29908 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932350AbWETSAN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 14:00:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060520180012.BLHX15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 May 2006 14:00:12 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605201945110.32590@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 20 May 2006 19:51:26 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20390>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 20 May 2006, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> There are two options missing: --signoff and --check.
>
> --signoff is my fault: it is probably a good thing to drop it from 
> format-patch, and only leave it in applymbox.

I think that is fine.  format-patch only formats existing
commits, and if you are signing off something you could already
have done that when you made the commits anyway, so that flag
was redundant.

> As for --check: how about having yet another diff "format": 
> DIFF_FORMAT_CHECK? Instead of showing the diff, it only shows the line(s) 
> which are offending.

Never thought of that but I think it makes sense.  

I liked the way Sean did the --summary; I am wondering if we
could clean up the --with-* stuff in a similar way.  We
currently do "if DIFF_FORMAT_XYZ or with_xyz then do this" which
is quite honestly disgusting (my fault).
