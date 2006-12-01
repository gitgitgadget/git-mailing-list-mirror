X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 23:10:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611302306120.3695@woody.osdl.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
 <Pine.LNX.4.64.0611301431420.3513@woody.osdl.org> <Pine.LNX.4.64.0611301749450.20138@iabervon.org>
 <20061201045727.GA22622@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 07:11:14 +0000 (UTC)
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061201045727.GA22622@thunk.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32857>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq2Y7-0003Wc-Q2 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933390AbWLAHLE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933577AbWLAHLE
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:11:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:63662 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S933390AbWLAHLC (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 02:11:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB17AbjQ008574
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 23:10:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB17AaRb004360; Thu, 30 Nov
 2006 23:10:37 -0800
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Theodore Tso wrote:
>
> By the way, after thinking about this for a while, part of the problem
> is that the name "index" really sucks.

Hey, it was originally called "cache".

I don't care _what_ it's called, I just want people knowing about it, 
because hiding it will just cripple git (ie at the very least, when you 
hit a merge conflict, you really do want to to understand it if you ever 
want to go the the "next level").

If people are more comfortable just calling it the "staging area", and 
talking about it in those terms, I'll be happy.

> Put another way, the reason why I think people are liking the whole
> "git add" and "git rm" suggestion is that it's a nice middle ground
> between the "hide the index" and the "shove the index in the user's
> face" approaches.  It's not that we are hiding the fact that there is
> this thing with the horribly chosen name "index", but instead we talk
> about this concept of a staging area and we don't dwell on things like
> the fact that it is a binary file which stores an efficient
> representation of a virtual directory.... blah blah blah.

Yes.

And even "git diff" isn't really a problem once you understand the staging 
area. If people feel worried, let them use "git diff HEAD". You won't need 
to use git for _that_ long until you realize that since the staging area 
is going to match the HEAD under normal circumstances (and when it 
doesn't, you actually tend to prefer to get the diff against the staging 
area _anyway_), you'll find people just starting to use "git diff" and not 
worry about it.

