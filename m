From: Junio C Hamano <junkio@cox.net>
Subject: Re: Is cogito really this inefficient
Date: Thu, 14 Jul 2005 19:10:28 -0700
Message-ID: <7vll48250r.fsf@assigned-by-dhcp.cox.net>
References: <20050713135052.C6791@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0507131325170.17536@g5.osdl.org>
	<20050714083700.A26322@flint.arm.linux.org.uk>
	<tnxu0ixoiuo.fsf@arm.com>
	<20050714105938.A31383@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0507140832490.19183@g5.osdl.org>
	<Pine.LNX.4.58.0507141725280.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 04:11:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtFg0-0001Vu-HS
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 04:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbVGOCLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 22:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbVGOCLG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 22:11:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21214 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S263117AbVGOCKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 22:10:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050715021025.IRXI19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Jul 2005 22:10:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 14 Jul 2005, Linus Torvalds wrote:
>>
>> I'll look into making diff-cache be more efficient. I normally don't use
>> it myself, so I didn't bother (I use git-diff-files, which is way more
>> efficient, but doesn't show the difference against the _tree_, it shows
>> the difference against the index. Since cogito tries to hide the index
>> from you, cogito can't very well use that).
>
> Ok, done.

Wonderful.

> Junio - I think this makes gitcore-pathspec pretty pointless, but I didn't
> actually remove it. I guess "git-diff-helper" still uses it.

And probably it shouldn't; diff-helper should be raw-to-patch
converter, nothing more.

Usually I'd volunteer to clean up the remaining mess (which was
originally my mess anyway) myself, but since I'd already asked
smurf to help cleaning up the diff option parsing, and recently
I've suddenly got quite busy in the day job, so ...
