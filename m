X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:18:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <200611151858.51833.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 19:19:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611151858.51833.andyparkins@gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31475>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQHf-0000Rs-2a for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030915AbWKOTSv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030922AbWKOTSu
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:18:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58813 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030915AbWKOTSt (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:18:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAFJIeoZ020717
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 11:18:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAFJIaKU025962; Wed, 15 Nov
 2006 11:18:38 -0800
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org



On Wed, 15 Nov 2006, Andy Parkins wrote:
>
> On the one hand you're arguing that git syntax is easy to learn, and on the 
> other that no one will be able to learn a new syntax just as easily.

I'm saying that people who are new to git will _have_ to learn new 
concepts ANYWAY.

I don't think the naming is the hard part. 

The fact is, git is one of the very few (essentially _only_) SCM's that 
make it very clear that all real operations are local and that if you want 
to work with other repositories, you have to "fetch" those into local 
branches first. The fact that "pull" exists at all is really just 
shorthand.

If people have trouble explaining this to others, and have trouble 
grasping "pull", then I will bet that the _real_ issue has nothing at all 
to do with naming at all, and the real issue is that people are being 
_taught_ the concepts in the wrong order.

Before you learn "pull", you should learn "fetch". Don't even _mention_ 
"pull" until the person got what "fetch" means. Because the fact is, 
"fetch" is really the much more fundamental operation, and once you 
really understand what "fetch" does, "pull" is obvious.

So I'll argue that the problem isn't naming, the "problem" is really that 
git has a few fundamnetal concepts that people aren't used to. The most 
fundamnetal of those is the notion of the local branch-space. EVERY other 
(broken) SCM has branches as being some kind of totally idiotic separate 
subdirectories, or doesn't really support branches at all (ie neither BK 
nor CVS really support "branches" - even if a concept of that name exists 
in CVS, it has nothing at all in common with the git model of branches).

But once you understand branches, and understand "fetch" (and it really 
isn't _that_ complicated: fetch really does exactly what the name says, so 
if you understand local branches, you will understand "fetch"), then it's 
a much smaller step to explain "pull = fetch + merge".

But I bet people don't teach it that way. They _start_ by teaching "pull". 
Right?

