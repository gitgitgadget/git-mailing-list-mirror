From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Fri, 09 Nov 2007 19:37:58 +0100
Organization: At home
Message-ID: <fh29e4$i6v$1@ger.gmane.org>
References: <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> <Pine.LNX.4.64.0711072309380.4362@racer.site> <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> <Pine.LNX.4.64.0711080003080.4362@racer.site> <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com> <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org> <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com> <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org> <20071109182248.GD28800@xp.machine.xx> <7vd4ujtgh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 19:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYkv-0002F4-Me
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbXKISiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756022AbXKISiQ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:38:16 -0500
Received: from main.gmane.org ([80.91.229.2]:51296 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbXKISiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:38:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IqYk3-0006n6-3q
	for git@vger.kernel.org; Fri, 09 Nov 2007 18:38:07 +0000
Received: from abvp178.neoplus.adsl.tpnet.pl ([83.8.213.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 18:38:07 +0000
Received: from jnareb by abvp178.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 18:38:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvp178.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64246>

Junio C Hamano wrote:

> Peter Baumann <waste.manager@gmx.de> writes:
> 
>> Hm. I tried to run your 'git log' and 'git log .' example and a diff
>> revealed that the output of those two isn't the same, contrary to what I
>> thought.
>>
>> In the 'git-log .' case, there should be done a history simplification,
>> but then only commits which don't change anything are pruned and AFAIR
>> 'git commit' doesn't allow this. Using core git, one could create commits
>> with the same tree as their parent, but I don't think that all the commits
>> which get removed in the '.' case where produced that way. There has to be
>> another case I can't figure out.
> 
> The answer is "merges".
> 
> If a merge does not change the tree from one of the ancestors,
> the side branches are pruned out, to give you _one_ explanation
> of how you got there.  And by pruning such side branches, you
> get the simpler explanation.
> 
> Linus gave the example of "log origin/pu ."; there is at least
> one merge I am aware of that did not change any path (it is the
> one that merges "jc/maint-format-patch-encoding" topic).  With
> the path limiter, the merge commit and the two commits that
> leads to it on the side branch are hidden away.

Does it mean that "git log" and "git log --full-history ." produce
the same output?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
