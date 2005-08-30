From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Mon, 29 Aug 2005 18:34:44 -0700
Message-ID: <7vbr3g5hsb.fsf@assigned-by-dhcp.cox.net>
References: <11252426672473-git-send-email-robfitz@273k.net>
	<7vslwtein3.fsf@assigned-by-dhcp.cox.net>
	<20050829235823.GA19351@localhost>
	<Pine.LNX.4.58.0508291744400.3243@g5.osdl.org>
	<7vacj06xi6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508291821010.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 03:36:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9v1h-0006Mx-7l
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 03:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVH3Beq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 21:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVH3Beq
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 21:34:46 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63660 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750766AbVH3Beq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 21:34:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050830013446.JBJI7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 Aug 2005 21:34:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508291821010.3243@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 29 Aug 2005 18:24:40 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7938>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 29 Aug 2005, Junio C Hamano wrote:
>> 
>> I, however, am not 100% convinced --ignore-applied is too
>> dangerous to be useful in any conceivable use cases, at least
>> not yet.  For example, you might be cherry-picking a change from
>> a foreign branch with 'git-diff-tree -p other~45 | git apply',
>> where the current branch may have already aquired part of the
>> changes that foreign branch contains since 45 generations ago.
>
> .. and that's why we use a three-way merge, and not diffs, to merge two 
> branches. 

.. and that's why I recently rewrote revert, cherry-pick and
rebase to use three-way merge as well ;-).

The code is simple enough and I see some beauty in it, but I
honor your veto, at least for now.
