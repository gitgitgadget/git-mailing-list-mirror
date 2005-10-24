From: Junio C Hamano <junkio@cox.net>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Sun, 23 Oct 2005 18:48:03 -0700
Message-ID: <7vy84jsn1o.fsf@assigned-by-dhcp.cox.net>
References: <4352F4C9.1040703@catalyst.net.nz>
	<20051021005145.GB30889@pasky.or.cz>
	<200510202137.22311.dtor_core@ameritech.net>
	<4358597A.6000306@catalyst.net.nz>
	<7vu0f7u3xc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510231804430.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 03:49:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETrRc-0005Ab-FA
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 03:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVJXBsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 21:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVJXBsI
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 21:48:08 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35013 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750895AbVJXBsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 21:48:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024014752.EUKG16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 21:47:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510231804430.10477@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 23 Oct 2005 18:35:43 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10523>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 23 Oct 2005, Junio C Hamano wrote:
>> 
>> Even if we did that, we are still doing 3-way merge; git-merge
>> framework may not mesh very well when we want to use something
>> like codeville merge which is not based on 3-way.
>
> Oh, the git merge is about a million times better than any silly weave 
> merge with extra BonusPoints and MagicCapitalizedNames.
>
> Why? Because if you want to be slow and careful, you can always just 
> create the weave after-the-fact and do a weave merge.

Yes, I know that as the one who did the convention between
git-merge and merge strategy backends.  The convention feeds two
(or more) heads and the common ancestors git-merge already
figured out to the strategy backends.

The current callers only feed commits for "$heads" parameters,
so the merge strategy backends are free to figure out the common
ancestor or even generate weave on the fly, but an unwritten
rule was that strategy backends are expected to do something
sensible even when the "common ancestors" and "heads" fed to
them are tree objects, which was my comment about 3-way was
about.
