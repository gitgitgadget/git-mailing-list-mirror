From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: n-heads and patch dependency chains
Date: Wed, 05 Apr 2006 09:59:48 +0200
Organization: At home
Message-ID: <e0vtdl$e3k$1@sea.gmane.org>
References: <4430D352.4010707@vilain.net>	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>	<4431B60E.3030008@vilain.net> <7vhd596ua0.fsf@assigned-by-dhcp.cox.net> <443364F5.2040504@vilain.net> <e0vqjk$5dr$1@sea.gmane.org> <4433723E.1080705@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 05 10:00:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR2vw-00006h-CB
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 10:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWDEIAE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 04:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDEIAE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 04:00:04 -0400
Received: from main.gmane.org ([80.91.229.2]:21145 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751159AbWDEIAD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 04:00:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FR2vn-00004r-1s
	for git@vger.kernel.org; Wed, 05 Apr 2006 09:59:59 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 09:59:59 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 09:59:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18423>

Sam Vilain wrote:

> Jakub Narebski wrote:

>>Third, would using *directory* with for a N-HEAD (containing all the
>>subheads, subprojects, chains, branches, fibers, whatever) instead of an
>>ordinary file for HEAD be a good idea? For hydra if we want it to be
>>easily interweaved with ordinary commit I think we would also need the
>>link for bottom, hydra shoulder, hydra tail i.e. common commit being
>>starting point for all the chains, or subprojects (for subprojects it can
>>be empty tree commit).
> 
> This was similar to the original suggestion, of heads that have multiple
> heads, or hydra. I think the basic rejection for this is that nothing is
> then tracking the progression of the merged tree - unless you keep a
> "cherry picked" tree for the combined work. And of course it is a
> backwards incompatible change.

I thought about keeping N-HEAD and HEAD and updating them simultaneously.
With extra fields in commit (however they would be named) use them, without
extra fields use ordinary branches, creating histories like in your example
in first post in the thread.

I.e. when doing [hydra] commit, add commit to ordinary history (recording
the time sequence of changes inside branch) advancing HEAD, and add commit
to appropriate chain/subhead/fiber in the N-HEAD and "advance N-HEAD". This
would make change backwards compatibile.

The problem would be to keep N-HEAD and HEAD to get out of sync, e.g. when
somebody updates only HEAD with an older git... well, we can always advance
N-HEAD to HEAD using commits from the time they were in sync to the current
head state.

-- 
Jakub Narebski
ShadeHawk on #git
Warsaw, Poland
