From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add -r flag to show-diff for diff-cache/diff-tree like
 output.
Date: Tue, 26 Apr 2005 16:44:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261639420.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
 <7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
 <7vd5shm94l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQZcV-0002Vl-L0
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 01:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVDZXmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVDZXmq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:42:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:31626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261847AbVDZXmo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 19:42:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QNgds4006722
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 16:42:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QNgc3G018135;
	Tue, 26 Apr 2005 16:42:39 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5shm94l.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Junio C Hamano wrote:
>
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> Why not just make this the default? Who really cares about
> LT> show-diff?
> 
> Me, to care enough about it to send patches in ;-).

Well, I actually care abotu "show-diff" too, in the sense that I actually 
use it all the time.

The thing is, I just care about the format. To me, a "diff-tree" like
format is actually _better_ than the full diff, 99% of the time, since
what I really want to know "what state is my repository in", I don't
usually care about the details within the files.

Ie I want to know exactly the same thing that most scripts would want to 
know: which files are dirty and need to be checked in, which ones are 
still unmerged etc.

> Later I'll add -p flag to diff-cache and diff-tree, so the usage
> of these three commands match.

I don't know why you're so dead set on creating the diff directly, when 
you _don't_ actually create the diff directly anyway (ie you call out to a 
helper process - "diff", regardless).

The thing is, "-p" is strictly weaker than doing the UNIX pipe way, since 
the latter trivially does the same time (add a simple script if you don't 
want to type it), but can also do things like "grep the filenames going 
past" or similar.

But hey, as long as the source code is clean, I don't care _that_ much. 

		Linus
