From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 17:59:15 -0700
Message-ID: <7vhd1weujg.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com>
	<7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 05 02:59:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxvjc-0001Xj-J4
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 02:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWGEA7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 20:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWGEA7S
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 20:59:18 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:1962 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932398AbWGEA7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 20:59:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060705005916.DOOF27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 20:59:16 -0400
To: git@vger.kernel.org
In-Reply-To: <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 04 Jul 2006 00:45:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23334>

Junio C Hamano <junkio@cox.net> writes:

> It may be interesting to run tests on real merges (I believe the
> kernel repository has a handful merges that have more than one
> merge bases) to see how effective the current clean-up pass is.
> It may turn out to be ineffective in practice, in which case we
> could kill it off.

So I counted.

There are 23 commits in the kernel history that have more than
one merge-bases.  The current merge-base code tells us that all
of them have two merge-bases.

None of them suffers from the horizon effect; the two bases
are not ancestor/descendant of each other.

A good news is that get_merge_bases() gives the same answer
without the clean-up pass mark_reachable_commits().

d0e5f39f1ee2e55d140064bb6d74c8bad25d71d0
361ea93cbff0e42cbc6a0f3c7a8238db9ed15648
4b2d9cf00962d0a0e697f887f3ecaa155cbde555
ba9b28d19a3251bb1dfe6a6f8cc89b96fb85f683
db21e578e551421d76641d72cb3f8296ed3f9e61
b425c8c5922562c562dc55a636c3c8d758ed6d17
2e9ff56efbc005ab2b92b68df65940c7459446c6
75e47b36004d136edff68295420424cba3a5ccd0
c45ae87ec9d03c9adfc466a6b560cb38b154813a
09e4f9029da1b53e835555c353a89c36b71233b0
0b310f36d7d96e27f6941ec0f9b95e15142f1e78
db9ace7083dbdcc3d02bdd6a1d26132c80b5b726
80c7af4074cbb4cb6be5d35c443ea6d5e8838a84
701db69d6647f61e4660c9102d7f2fd5dffc203d
5e3c2b95dd560baa41b08c8f5f00bbd6fbeebdcb
c7fb577e2a6cb04732541f2dc402bd46747f7558
ba9b543d5bec0a7605952e2ba501fb8b0f3b6407
84ffa747520edd4556b136bdfc9df9eb1673ce12
da28c12089dfcfb8695b6b555cdb8e03dda2b690
3190186362466658f01b2e354e639378ce07e1a9
0c168775709faa74c1b87f1e61046e0c51ade7f3
0e396ee43e445cb7c215a98da4e76d0ce354d9d7
467ca22d3371f132ee225a5591a1ed0cd518cb3d
