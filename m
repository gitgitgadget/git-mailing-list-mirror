From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: bogus merges
Date: Sun, 11 Sep 2005 14:08:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509111256300.23242@iabervon.org>
References: <59a6e58305090507387d412b3d@mail.gmail.com>
 <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org> <Pine.LNX.4.63.0509061409180.23242@iabervon.org>
 <20050911120140.A8236@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wsc9tt@gmail.com>,
	git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Sep 11 20:04:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWBa-0003pA-DK
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVIKSEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVIKSEM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:04:12 -0400
Received: from iabervon.org ([66.92.72.58]:6925 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965033AbVIKSEL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 14:04:11 -0400
Received: (qmail 12172 invoked by uid 1000); 11 Sep 2005 14:08:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Sep 2005 14:08:14 -0400
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050911120140.A8236@flint.arm.linux.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8310>

On Sun, 11 Sep 2005, Russell King wrote:

> Look closer at the two heads (I've cut out the author info):
> 
> commit b129a8ccd53f74c43e4c83c8e0031a4990040830
> tree 4c40afd836be87166d6d014380262f1baa19694f
> parent 6b39374a27eb4be7e9d82145ae270ba02ea90dc8
> parent 194d0710e1a7fe92dcf860ddd31fded8c3103b7a
> committer Russell King <rmk+kernel@arm.linux.org.uk> Wed, 31 Aug 2005 10:12:14 +0100
>     [SERIAL] Clean up and fix tty transmission start/stoping
> 
> which was apparantly (but not really) a merge between:
> 
> commit 6b39374a27eb4be7e9d82145ae270ba02ea90dc8
> tree 09933113cf28f253db1dd539463bdab741d67139
> parent 62c592edead3c3a045662595f7ade3c12f133373
> parent ed735ccbefaf7e5e3ef61418f7e209b8c59308a7
> committer Linus Torvalds <torvalds@g5.osdl.org> Tue, 30 Aug 2005 11:16:30 -0700
>     Merge refs/heads/upstream from master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> 
> commit 194d0710e1a7fe92dcf860ddd31fded8c3103b7a
> tree da03b56fa4dee221c53af5770492d391f0d09459
> parent a68d2ebc1581a3aec57bd032651e013fa609f530
> parent 9bbd03758945858c9303f3258b418b94c4ffd735
> committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 03 Aug 2005 13:09:43 -0700
>     Merge master.kernel.org:/home/rmk/linux-2.6-arm
> 
> However, the serial tree (which commit b129a8ccd53f74c43e4c83c8e0031a4990040830
> was created in) was last pulled in commit 975f957dc408925805dd8f5aa4217b7eeea2d005.
> Following the commit trail, you'll end up at commit
> 6b39374a27eb4be7e9d82145ae270ba02ea90dc8 above.
> 
> commit 975f957dc408925805dd8f5aa4217b7eeea2d005
> tree 2198bb72323a016d93c7440c9240bac94a5c0016
> parent 2321fbd2b87539edc1fbfc2e186528a1ef93835f
> parent 661299d9d0437a0ff72240f3d60016ac3a361a6e
> committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 29 Aug 2005 10:34:59 -0700
>     Merge HEAD from master.kernel.org:/home/rmk/linux-2.6-serial.git
> 
> which was the result of the following merge between the head of the
> serial tree and Linus' tree:
> 
> commit 661299d9d0437a0ff72240f3d60016ac3a361a6e
> tree 765512576314fc3612b503f182b9ae4e60fcf849
> parent 05caac585f8abd6c0113856bc8858e3ef214d8a6
> parent 41c018b7ecb60b1c2c4d5dee0cd37d32a94c45af
> committer Russell King <rmk+kernel@arm.linux.org.uk> Thu, 28 Jul 2005 09:30:20 +0100
>     Merge with Linus' 2.6 tree
> 
> This was at the head of the serial tree at the time:
> 
> commit 05caac585f8abd6c0113856bc8858e3ef214d8a6
> tree ac9f8f2cc032281af09200da514257d120510906
> parent 241fc4367b3ca5d407b043599ed980304a70b91f
> committer Russell King <rmk+kernel@arm.linux.org.uk> Wed, 27 Jul 2005 11:41:18 +0100
>     [SERIAL] Convert parport_serial to use new 8250_pci interfaces
> 
> You might be right except for one small detail.  I don't "switch tasks"
> with a single git tree.

I think I was right, but "switching tasks" has to be interpretted as 
switching from a merge you don't care to complete to doing further 
development on that tree, and the "switch" is done by a fast-forward (to 
the result of someone else completing the merge).

>  I have a set of individual git trees, one per
> "task".  They always remain in a clean state due to the way I work:
> 
> 	- update tree to Linus if Linus tree is a superset of the tree
> 	- apply changes in patch form to tree and commit each in turn
> 	- send linus a request to merge
> 
> However, occasionally, I update the tree when Linus' tree is not a
> superset, as was the case in 661299d9d0437a0ff72240f3d60016ac3a361a6e
> above.

Ah, okay. So I think the chain of events is:

 28 Jul: You merge with Linus, when he hasn't pulled your tree. This goes 
         fine.
 03 Aug: You pull from Linus again, but decide that you don't actually 
         care about tracking mainline in this tree so tightly. This leaves
         194d... in .git/merging, because Cogito doesn't realize you're 
         not actually planning to complete the merge.
 29 Aug: Linus pulls from you. This goes fine.
 30 Aug: You update the tree again from Linus. This is a fast-forward and 
         goes fine, and doesn't touch .git/merging because it completes
         the process without requiring input or a commit.
 31 Aug: You make a different change and commit. This is the first time 
         you committed there since 03 Aug, and it thinks that you're still 
         merging your current head (now from 30 Aug) with 194d..., which 
         it marked down explicitly to track this when you started the 
         merge on the 3rd, and you don't get sufficient information to 
         realize that it's messed up.

I think that the fundamental bug is that tree_timewrap() doesn't clear 
.git/merging, which means that it can still think you're doing a merge 
when you've started doing something else (such as doing further 
development after updating to someone else's merge of your tree).

But I still think that it would be worth checking for the parents in merge 
commits making sense, because the fact that stale data is likely to be 
from abandoned operations on ancestors.

	-Daniel
*This .sig left intentionally blank*
