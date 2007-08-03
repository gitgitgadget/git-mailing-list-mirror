From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Fri, 03 Aug 2007 02:13:25 -0700
Message-ID: <7vvebxm156.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
	<7v1wemxnkk.fsf@assigned-by-dhcp.cox.net>
	<vpqzm1a2l72.fsf@bauges.imag.fr>
	<7vy7gtvhgc.fsf@assigned-by-dhcp.cox.net>
	<20070803070407.GA17287@coredump.intra.peff.net>
	<7vr6mlnj4g.fsf@assigned-by-dhcp.cox.net>
	<20070803084010.GM20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 11:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGtDu-0004KO-Fa
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 11:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbXHCJN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 05:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755565AbXHCJN1
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 05:13:27 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35279 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625AbXHCJN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 05:13:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803091327.KXWC23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 3 Aug 2007 05:13:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XMDS1X0021kojtg0000000; Fri, 03 Aug 2007 05:13:26 -0400
In-Reply-To: <20070803084010.GM20052@spearce.org> (Shawn O. Pearce's message
	of "Fri, 3 Aug 2007 04:40:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54698>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> I do not make partial commits myself, so
>> distinction between staged and unstaged are not something I am
>> usually interested in.
>
> I never used to either.  Then git-gui got really useful at showing
> the distinction and I started using the index for a staging ground.

I guess we are saying the same thing.  I do use index for
staging large-ish changes.  I simply do not care about the
staged/not-staged distinction in the sense that "I still haven't
staged these, that's good because these do not belong to the
commit I am going to make next".

Output from "git diff" being truly empty is the cue that such a
large-ish worktree change is ready to be committed, and the
final "git diff --cached" would give me the full picture.  A
small-ish change won't make "git diff" in the middle empty, but
checking the final "git diff --cached" before committing is the
same.
