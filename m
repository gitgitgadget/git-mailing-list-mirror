From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch: Add output for the not fast forward case
Date: Thu, 28 Sep 2006 19:29:00 -0700
Message-ID: <7v1wpvquc3.fsf@assigned-by-dhcp.cox.net>
References: <873babbptl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 04:29:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT87s-0006bt-Q8
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 04:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWI2C3I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 28 Sep 2006 22:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWI2C3H
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 22:29:07 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64698 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030385AbWI2C3C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 22:29:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929022901.IFJQ16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 22:29:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id U2V31V00b1kojtg0000000
	Thu, 28 Sep 2006 22:29:04 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28085>

Santi B=E9jar <sbejar@gmail.com> writes:

> This patch follows the notation of the other mail, but for the
> not-fast-forward case I think it makes more sense to use the '...'
> notation.

Again, justification for three-dots not two as others is needed
in the commit log part, not the commentary part.

I tend to agree with you that A...B is nice in this case, _if_
we use A..B for others.  Using A..B for others (I am guessing
that you are doing this for Cut & Paste reasons to grab the
whole range as one word) means that we assume users are a lot
more likely to be interested in grabbing A..B as a range than
grabbing only A or B as a point.

I will not discuss if that assumption is correct here, but if we
assume it is, using A...B makes a lot of sense for this case.
After grabbing A..B in other cases, the user can give that to
"git log" to see what the changes between old and new are.  In
this non-fast-forward case, if we used three-dots A...B to talk
about the two heads, the user can give it to "git log" to see
how the two non-fast-forward heads have diverged.

So the choice of .. and ... are internally consistent and very
sensible.

The question is if people more often want to grab both as a
range than they want to grab either end point alone.  I am
inclined to think your assumption is correct, but am not
absolutely sure.
