From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 14:08:27 +0100
Organization: At home
Message-ID: <epcue5$vrv$3@sea.gmane.org>
References: <45B8E61E.C9C5E6C6@eudaptics.com> <7vireu7lj0.fsf@assigned-by-dhcp.cox.net> <45B9B80E.E2534F97@eudaptics.com> <7vr6ti183o.fsf@assigned-by-dhcp.cox.net> <45B9C836.728F31EC@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 14:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAQoV-0004zT-9U
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 14:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965660AbXAZNHn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 08:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965655AbXAZNHn
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 08:07:43 -0500
Received: from main.gmane.org ([80.91.229.2]:39011 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965660AbXAZNHm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 08:07:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAQnl-0000WM-22
	for git@vger.kernel.org; Fri, 26 Jan 2007 14:07:33 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:07:33 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:07:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37852>

[Cc: git@vger.kernel.org]

Johannes Sixt wrote:

> Junio C Hamano wrote:
>> Graft is a local matter, but that does not mean it should
>> introduce inconsistencies.  It is a way to _locally_ change the
>> world view, and to give the consistent world view locally, not
>> only the commands you listed (fsck, prune, pack-objects) but
>> also log, rev-list and friends all should take grafts into
>> account, which is why losing B is the right thing to do if you
>> repack or prune.  In your altered world, B is not part of any
>> remaining history.
> 
> Here's my stance on it. Grafts should be a local matter. And they alter
> the world view, with a pronounciation on *view*. That's why I proposed
> that only log familiy of commands obey them[*]. And probably rev-list so
> that gitk et.al. have a way to obey them. And also the ref parser (so
> that master~20 is what it looks it is). Everything else should disregard
> grafts: repack, prune, fetch, <transfer>-pack, push etc. No nasty side
> effects anymore. No transfer of the grafts file needed. No clash when
> someone else has a different *view* of the world.

If I remember correctly there was some time ago discussion about this
topic, namely should connectivity (including prune, repack, etc.) take
only true parents, only grafts (local view), or both. IIRC there were
no conclusion (besides perhaps that the option to choose should be
configurable), and no code.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
