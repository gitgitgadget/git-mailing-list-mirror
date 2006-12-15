X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 09:52:57 +0100
Message-ID: <45826269.1060405@op5.se>
References: <200612132200.41420.andyparkins@gmail.com> <200612142000.54409.arekm@maven.pl> <4581CB38.8050401@op5.se> <200612142313.27741.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 08:53:11 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200612142313.27741.arekm@maven.pl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34479>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv8oV-0001fc-Cn for gcvg-git@gmane.org; Fri, 15 Dec
 2006 09:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751301AbWLOIxE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 03:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWLOIxE
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 03:53:04 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48417 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751301AbWLOIxD (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 03:53:03 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 2E7886BCC9; Fri, 15 Dec 2006 09:52:59 +0100 (CET)
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Sender: git-owner@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> On Thursday 14 December 2006 23:07, Andreas Ericsson wrote:
> 
>>> ps. I'm blind or there is no documentation about what utilities are
>>> needed to get git fully working? (like sed, coreutils, grep, rcs package
>>> (merge tool afaik needed)...).
>> perl and the standard coreutils, which afaik are required to be present
>> on all unix systems. 
> That's not all. sed and grep is also used. There may be some others hidden 
> deep in git and it would be good to have that docummented (I've hit the 
> problem already with missing some tool when preparing chroot for git).
> 

sed and grep are, along with awk, part of the tools that are required to 
be present on all unix systems. Sorry for the confusion with coreutils 
(the package / software project).

When you set up a chroot environment, you want to at least copy /bin, 
/lib and /sbin to the new root and then remove whatever you *know* you 
don't need from them. Those directories should hold all programs the 
system needs to properly boot up.

>> We no longer require external merge tools. 
> Starting from which version?
> 

Latest only. It was added 2006-12-06 and the dependency on external 
merge program was removed in a commit created 2006-12-13. Junio merged 
the merge-code into master one hour later. It is not in the maint 
branch, so I don't know if any distributions ship git with the new 
xdl_merge() thing. It's *very* good though. Kudos to Johannes Schindelin 
for really making things right.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
