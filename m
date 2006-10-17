From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 12:06:26 +0200
Organization: At home
Message-ID: <eh29u4$8r1$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <200610170119.09066.jnareb@gmail.com> <1161077866.9020.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Tue Oct 17 12:06:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZlq0-0004JC-HU
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWJQKGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWJQKGS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:06:18 -0400
Received: from main.gmane.org ([80.91.229.2]:4758 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161070AbWJQKGR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 06:06:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZlpm-0004HF-Ve
	for git@vger.kernel.org; Tue, 17 Oct 2006 12:06:07 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 12:06:06 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 12:06:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29047>

Robert Collins wrote:

> On Tue, 2006-10-17 at 01:19 +0200, Jakub Narebski wrote:
>> 
>> I wonder if any SCM other than git has easy way to "rebase" a branch,
>> i.e. cut branch at branching point, and transplant it to the tip
>> of other branch. For example you work on 'xx/topic' topic branch,
>> and want to have changes in those branch but applied to current work,
>> not to the version some time ago when you have started working on
>> said feature. 
> 
> Precisely how does this rebase operate in git ? 
> Does it preserve revision ids for the existing work, or do they all
> change?

Revision ids (commit ids) change of course. Therefore rebasing published
branches is not recommended, as it is in fact rewriting history.

It is however recommended before sending _series_ of patches (work on that
series should be done using topic branch) to rebase topic branch they sit
on for the patches to apply cleanly on top of current work. Or use StGit or
other Quilt (patch management) equivalent.

> bzr has a graft plugin which walks one branch applying all its changes
> to another preserving the users metadata but changing the uuids for
> revisions. 

This looks like "bzr graft" is the same as "git rebase". It can deal with
conflict, cannot it?


P.S. It looks like we have yet another terminology conflict. In git "graft"
means "history graft" i.e. file which changes parents of some commits. For
example if we have historical repositoy and current repositoy we can join
together using grafts (otherwise we would need to rewrite history, as sha1
which serves as commit id includes parents information), e.g.

   x--*--*--*--*....x--*--*--*--*

    historical         current

where 'x' is 'root' (parentless) commit, '--' denotes parentship, and '....'
denotes "history graft".      
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
