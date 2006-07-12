From: Junio C Hamano <junkio@cox.net>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Wed, 12 Jul 2006 09:24:32 -0700
Message-ID: <7v1wsqzt8f.fsf@assigned-by-dhcp.cox.net>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
	<44B37893.5090501@innova-card.com>
	<7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
	<44B4A6CA.3020206@innova-card.com>
	<Pine.LNX.4.64.0607120834200.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 12 18:26:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0hW5-00039m-4W
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 18:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWGLQYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWGLQYq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 12:24:46 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61315 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750788AbWGLQYp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 12:24:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712162440.FSUQ12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 12:24:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607120834200.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Jul 2006 08:43:02 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23789>

Linus Torvalds <torvalds@osdl.org> writes:

> Yes. However, I think the sign-off detection is a bit broken (quite 
> independently of your patch).
>
> A number of people end up capitalizing the sign-off differently, so you 
> have lines like "Signed-Off-By: Xy Zzy <xyzzy@example.org>".
>
> Also, at least for the kernel, we often have alternative formats, like
>
> 	Acked-by: Elliot Xavier Ample <example@dummy.org>
>
> and for that case, adding the extra newline is actually bad.
>
> So I would suggest a totally different approach: instead of using 
> "strstr(comments, signed_off_by)", it would probably be much better to 
> just look for the last non-empty line, and see if it matches the format
>
> 	"^[nonspace]*: .*@.*$"

Documentation/SubmittingPatches (the kernel one) does not show
the ugly Camel-Case-With-Hyphen spelling, and I've been wondring
why people do that.  A hidden agenda by me was to migrate people
away from that practice, but that is an independent issue ;-).

I like your "detect lines that looks like a RFC2822 header that
has some e-mail address" approach quite a lot.
