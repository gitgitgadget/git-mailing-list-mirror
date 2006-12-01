X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 15:09:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de>
 <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> <200612012306.41410.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <4570AF8F.1000801@stephan-feder.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 23:10:27 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4570AF8F.1000801@stephan-feder.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32983>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqHWS-0001yp-AO for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161179AbWLAXKV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162160AbWLAXKV
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:10:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43461 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1161179AbWLAXKV (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 18:10:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB1N9fjQ014709
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 15:09:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB1N9e9R031120; Fri, 1 Dec
 2006 15:09:41 -0800
To: sf <sf-gmane@stephan-feder.de>
Sender: git-owner@vger.kernel.org



On Fri, 1 Dec 2006, sf wrote:
> Linus Torvalds wrote:
> ...
> > In contrast, a submodule that we don't fetch is an all-or-nothing 
> > situation: we simply don't have the data at all, and it's really a matter 
> > of simply not recursing into that submodule at all - much more like not 
> > checking out a particular part of the tree.
> 
> If you do not want to fetch all of the supermodule then do not fetch the
> supermodule.

So why do you want to limit it? There's absolutely no cost to saying "I 
want to see all the common shared infrastructure, but I'm actually only 
interested in this one submodule that I work with".

Also, anybody who works on just the build infrastructure simply may not 
care about all the submodules. The submodules may add up to hundreds of 
gigs of stuff. Not everybody wants them. But you may still want to get the 
common build infrastructure.

In other words, your "all or nothing" approach is
 (a) not friendly
and
 (b) has no real advantages anyway, since modules have to be independent 
     enough that you _can_ split them off for other reasons anyway.

So forcing that "you have to take everything" mentality onyl has 
negatives, and no positives. Why do it?

