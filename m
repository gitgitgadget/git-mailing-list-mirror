From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] diff-tree/diff-cache helper
Date: Mon, 25 Apr 2005 18:38:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 03:32:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQEvW-0007pW-Sy
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 03:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDZBgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 21:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDZBgd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 21:36:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:37261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261196AbVDZBgP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 21:36:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q1a6s4021939
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 18:36:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q1a5h5019376;
	Mon, 25 Apr 2005 18:36:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, Junio C Hamano wrote:
>
> I use a set of small scripts [*1*] directly on top of the core
> git, which needed to make patches out of diff-tree and
> diff-cache output.  Its output is compatible with what show-diff
> produces.

Good, applied.

This also makes me think that we should just make "show-diff" show the
same format, at which point show-diff actually matches all the other
tools, and it is likely to make show-diff more useful to boot.

The thing I personally use "show-diff" for these days is actually just to
check whether I have anything dirty in my tree, and then it would actually
be preferable to just get the filenaname printout (in the same old
"diff-cache" format) rather than the full diff.

Maybe rename the "show-diff" command to be "cache-diff", and if somebody
wants the old "show-diff" thing, just have a script that does

	#!/bin/sh
	cache-diff | diff-tree-helper

and nothing more.

Talking about renaming, at some point we really should prepend "git-" to 
all the git commands. I didn't want to do the extra typing when I started 
out and was unsure about the name, but hey, by now we really should.

Junio, what do you think?

		Linus
