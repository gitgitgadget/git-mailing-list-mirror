From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Wed, 24 Jan 2007 03:22:29 +0100
Organization: At home
Message-ID: <ep6fre$2i2$1@sea.gmane.org>
References: <200701231259.27719.andyparkins@gmail.com> <45B6076F.5060503@op5.se> <200701231314.53361.andyparkins@gmail.com> <7v1wllo2p6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701231649520.3011@xanadu.home> <7vbqkpkxhk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701232103290.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jan 24 03:22:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Xlz-0007Nf-3s
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 03:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965620AbXAXCWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 21:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965622AbXAXCWA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 21:22:00 -0500
Received: from main.gmane.org ([80.91.229.2]:45788 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965620AbXAXCV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 21:21:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9Xlm-0006iv-O1
	for git@vger.kernel.org; Wed, 24 Jan 2007 03:21:50 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 03:21:50 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 03:21:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37598>

Nicolas Pitre wrote:

> On Tue, 23 Jan 2007, Junio C Hamano wrote:
> 
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>>> On Tue, 23 Jan 2007, Junio C Hamano wrote:
>>>
>>>> And we might want to allow reflogs on detached HEAD someday,
>>>> although I personally think it goes against what detached HEAD
>>>> is -- it is of a very temporary nature.
>>>
>>> Didn't we agree already that reflog with detached head was simply 
>>> insane?
>> 
>> Perhaps, perhaps not.
>> 
>>      $ git checkout v2.6.14
>>      $ git checkout v2.6.15
>>      $ git checkout v2.6.16
>> 
>> Ah, which one did I check-out the last time?
>> 
>>      $ git describe HEAD@{1}
> 
> And what does HEAD@{1} means if not detached?
> 
> If there is a reflog for HEAD independently of what branch HEAD is 
> attached to then it could make sense.  Meaning that if you're on branch 
> "master" and perform a commit, then both reflogs for "master" and "HEAD" 
> are updated at the same time.  If you then checkout branch "next" then 
> only the "HEAD" reflog is updated since no changes to any branch did 
> occur but just HEAD changed.
> 
> Then moving around and/or committing with a detached head would just 
> update the "HEAD reflog.

I think it would be best to maintain mixed approach. When we are on some
branch, the HEAD@{1} would mean <current branch>@{1}. When HEAD is detached
(is not symlink or symref), HEAD@{1} means it's latest state. Detaching
a head creates reflog, de-detaching deletes it...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
