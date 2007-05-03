From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Fri, 04 May 2007 01:36:27 +0200
Organization: At home
Message-ID: <f1drdk$7uj$1@sea.gmane.org>
References: <200705012346.14997.jnareb@gmail.com> <87lkg61j99.fsf@mid.deneb.enyo.de> <Pine.LNX.4.64.0705031131410.4015@racer.site> <200705031216.19817.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 01:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjkmg-0005a9-Ky
	for gcvg-git@gmane.org; Fri, 04 May 2007 01:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbXECXcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 19:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbXECXcX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 19:32:23 -0400
Received: from main.gmane.org ([80.91.229.2]:60876 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbXECXcW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 19:32:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjkmU-0004K4-JS
	for git@vger.kernel.org; Fri, 04 May 2007 01:32:14 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 01:32:14 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 01:32:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46120>

Robin Rosenberg wrote:
> torsdag 03 maj 2007 skrev Johannes Schindelin:
>> On Thu, 3 May 2007, Florian Weimer wrote:
>>> * Jakub Narebski:
>>> 
>>>> What I'm really concerned about is branch switch and merging branches, 
>>>> when one of the branches is an old one (e.g. unxsplash branch), which 
>>>> takes 3min (!) according to the benchmark. 13-25sec for commit is also 
>>>> bit long, but BRANCH SWITCHING which takes 3 MINUTES!?
>>> 
>>> IIRC, GIT accesses every file in the tree, not just the ones that need
>>> updating.  How many files were actually updated when you changed
>>> branches in your experiment?
>> 
>> No. Git does not access every file, but rather all stats. That is a huge 
>> difference. And it should not take _that_ long for ~64000 files. Granted, 
>> it will cause a substantial delay, but not in the range of minutes.
> 
> It's worse... On my laptop the switch took ~ten minutes, not three. 
> A diff --stat takes over six minutes!! For reference, dd:in the pack 
> file with my disk takes ~50 seconds.
> 
> The reason is simple. I have a lousy one gigabyte RAM only, while 
> git wants 1.7GB virtual to do the diff-stat, and 800 MB resident.
> The swap is having a party, 

That is nice to know where the culprit is: 197000 files and 24000
directories (132 projects), i.e. huge tree and not enogh memory.
This is yet another reason for splitting OOo repository into subprojects.
I do wonder if git can be more conservative in memory usage...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
