From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 11:04:54 +0200
Organization: At home
Message-ID: <ee38ri$pp8$2@sea.gmane.org>
References: <20060910190332.17667.qmail@science.horizon.com> <Pine.LNX.4.64.0609101254590.27779@g5.osdl.org> <17668.38032.20688.991295@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0609101949580.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 11 11:05:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMhj6-0003Aj-9r
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 11:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWIKJFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 05:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWIKJFH
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 05:05:07 -0400
Received: from main.gmane.org ([80.91.229.2]:12203 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751286AbWIKJFG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 05:05:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMhiu-00037L-Gk
	for git@vger.kernel.org; Mon, 11 Sep 2006 11:05:00 +0200
Received: from host-81-190-17-209.torun.mm.pl ([81.190.17.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 11:05:00 +0200
Received: from jnareb by host-81-190-17-209.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 11:05:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26845>

Linus Torvalds wrote:

> On Mon, 11 Sep 2006, Paul Mackerras wrote:
>> 
>> Do you think there is any way to speed up the cold-cache case for
>> git-ls-remote and git-rev-parse with thousands of heads and tags?
> 
> Nothing obvious comes to mind.
> 
> If we did the same pack-file approach that we do for objects, the problem 
> ends up being that _updating_ things is really hard. What we could do (and 
> might work) is that a "git repack" would create a "packed representation 
> of the heads too".

Because usually there is reasonable number of heads, and that is the tags
that might be problem, because the number of tags likes to grow with the
history, perhaps we could pack only tags heads into the pack? This has
additional advantage that tags, especially annotated tags (i.e. true tags
objects) changes rarely.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
