X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Fri, 15 Dec 2006 11:35:58 +0100
Organization: At home
Message-ID: <elttlo$h4s$2@sea.gmane.org>
References: <200612141519.44294.andyparkins@gmail.com> <200612142123.16291.andyparkins@gmail.com> <7virge17yh.fsf@assigned-by-dhcp.cox.net> <200612142137.54505.andyparkins@gmail.com> <20061214215725.GA26202@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 10:34:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34492>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvAO1-0004iF-W0 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 11:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751776AbWLOKdt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 05:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWLOKdt
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 05:33:49 -0500
Received: from main.gmane.org ([80.91.229.2]:51273 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751776AbWLOKds
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 05:33:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvANs-0007l4-Up for git@vger.kernel.org; Fri, 15 Dec 2006 11:33:45 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 11:33:44 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 11:33:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> Andy Parkins <andyparkins@gmail.com> wrote:
>> On Thursday 2006, December 14 21:30, Junio C Hamano wrote:
>> 
>> > I guess that question indicates that the part of my message you
>> > did not quote was not written cleanly enough.
>> 
>> It was; I'm just stupid.
>> 
>> Let's make the special case "linux-master" and then Linus gets what he wants 
>> and consistency is restored.
>> 
>> No?  Okay, I give up then. :-)
> 
> What about we do instead:
> 
>       [branch]
>               mergeMessageTemplate = "Merge '%(remoteref)' from '%(remoteurl)' into '%(localref)'
> %(summary)"
>       [branch "master"]
>               mergeMessageTemplate = "Merge '%(remoteref)' from '%(remoteurl)'
> %(summary)"

I disagree about '%(summary)' part, as it is controlled by merge.summary
configuration variable. If you want per branch configuration, why not
branch.<branchname>.mergesummary?

By the way, the above ignores the fact, that besides having hardcoded
that we don't say "into master", we have _two_ merge subject templates:
one for merging from remote, one for merging from local. We might not
have %(remoteurl), then what?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

