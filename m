From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 05 May 2006 21:39:56 +0200
Organization: At home
Message-ID: <e3g9m6$8i0$1@sea.gmane.org>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505181540.GB27689@pasky.or.cz> <Pine.LNX.4.64.0605051123420.3622@g5.osdl.org> <20060505185445.GD27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 05 21:40:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc6A2-0006Xv-SE
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWEETkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWEETkT
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:40:19 -0400
Received: from main.gmane.org ([80.91.229.2]:46515 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751532AbWEETkS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 15:40:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fc69l-0006Ue-7g
	for git@vger.kernel.org; Fri, 05 May 2006 21:40:05 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 21:40:05 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 21:40:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19635>

Petr Baudis wrote:

> Dear diary, on Fri, May 05, 2006 at 08:31:06PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...

> I prefer making this [rename detection] data dependable to having to
> resort to guessing on dependable less amount of data.
> 
>> There's another reason why encoding movement information in the commit is
>> totally broken, namely the fact that a lot of the actions DO NOT WALK THE
>> COMMIT CHAIN!
>> 
>> Try doing
>> 
>> git diff v1.3.0..
>> 
>> and think about what that actually _means_. Think about the fact that it
>> doesn't actually walk the commit chain at all: it diffs the trees between
>> v1.3.0 and the current one. What if the rename happened in a commit in
>> the middle?
> 
> Then the automated renames detection will miss it given that the other
> accumulated differences are large enough, and the suggested workarounds
> _are_ precisely walking the commit chain.
> 
> If you use persistent file ids, you never miss it _AND_ you DO NOT WALK
> THE COMMIT CHAIN! You still just match file ids in the two trees.

Let not jump to the one of the possible solution. The detecting and noting
renames and content moving (with user interaction) at commit is nice...
unless does something which cannot allow interactiveness (like applying
patchbomb), but even then detecting and saving info at commit would be good
idea.

What we need is to for two given linked revisions (with a path between them)
to easily extract information about renames (content moving). Perhaps using
additional structure... best if we could do this without walking the chain.
The rest is details... ;-P

-- 
Jakub Narebski
Warsaw, Poland
