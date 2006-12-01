X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Resolving conflicts
Date: Thu, 30 Nov 2006 23:53:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611302348370.3695@woody.osdl.org>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 07:53:34 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32863>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3D8-0000pi-Pl for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936039AbWLAHx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936067AbWLAHx2
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:53:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:17593 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S936039AbWLAHx1 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 02:53:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB17rMjQ010813
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 23:53:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB17rLN5005432; Thu, 30 Nov
 2006 23:53:21 -0800
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Linus Torvalds wrote:
> 
> So my guess is that there wasn't actually a conflict at all, but the 
> "merge" program (usually in /usr/bin/merge) returned an error for some 
> reason. What does "which merge" and "rpm -qf /usr/bin/merge" say?

Side note: the historically more common failure was to not have a merge 
program at all, but exactly because that was common, we check for that and 
complain about it. So that's not it for you - you do have a 'merge' 
program somewhere that git found.

But if it returns the wrong error code, or doesn't do anything at all (ie 
you have "merge", but it's not the 3-way merge we expect, or it doesn't 
take the "-L" argument we use, or it's simply buggy) then that might 
explain the behaviour you report.

Or it might be something totally different. This is just a wild theory.

