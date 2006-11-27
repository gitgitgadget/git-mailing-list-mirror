X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Sun, 26 Nov 2006 18:52:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611261836250.30076@woody.osdl.org>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org> <7vac2dr6ua.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 02:53:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vac2dr6ua.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32381>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoWcn-00013F-0A for gcvg-git@gmane.org; Mon, 27 Nov
 2006 03:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756297AbWK0Cx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 21:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756298AbWK0Cx0
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 21:53:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:31208 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1756296AbWK0Cx0 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 21:53:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAR2qvix025964
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 26
 Nov 2006 18:53:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAR2qvNd017901; Sun, 26 Nov
 2006 18:52:57 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sun, 26 Nov 2006, Junio C Hamano wrote:
> 
> I think I should have used the word "topic branch" instead of
> "topic".  In other words, I was not interested in sifting the
> various totally unrelated linear commits into groups that deal
> with distinct problems.

Well, I think you're grown slightly jaded by the fact that git has very 
active "normal" development, that is actually done by you on the main 
branch, and you do basically zero rebasing along the side branches.

I think that's actually likely the exception rather than the rule. It's 
much more likely that people have almost _all_ active development done on 
side branches, and that - together with rebasing of the side branches - 
inevitably means that the "main branch" ends up not having such a clean 
set of "topic branch" merges.

In addition, on a more mature tree, a lot (probably _most_) of the commits 
aren't really "topics" at all, but "maintenance", which exacerbates the 
problem: you don't have a "line of development of this feature", you tend 
to have much more of a random "fix this general area", where the only 
common theme may be the fact that things are _related_ to some common 
subsystem, but not that they are a "topic branch" in the _development_ 
sense.

Put another way: bugs get fixed one by one, not in a nice linear fashion 
by "topic".

So I'm coming at it from a totally different project - where "topic 
branches" simply aren't delineated as much, and even when they are, they 
tend to be merged in multiple steps (and they pull both ways when they 
aren't re-based).

So that's why I don't think the pure branch topology is as interesting. A 
single line of development ends up being useful for you, and we'll 
certainly see _some_ of that, but in the kernel, I pretty much guarantee 
that you probably get better "topic clustering" by going simply by author, 
like the old standard "git shortlog" does. Because that will tend to get 
the clustering at a finer granularity (ie not just "networking", but 
things like "packet filtering" etc).

So the "sort by people" actually works fairly well, but it's kind of an 
"incidental" thing, and it _would_ be potentially useful to have other 
ways of grouping things.

See? It's not about "superior intelligence", it's about simply a totally 
different development phase (and a less strictly defined problem space).

