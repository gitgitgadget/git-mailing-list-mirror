From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-cache/tree compatible output for show-diff (take
 2).
Date: Tue, 26 Apr 2005 17:29:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261725470.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
 <7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
 <7vd5shm94l.fsf@assigned-by-dhcp.cox.net> <7vy8b5ksqi.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504261719230.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 02:22:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQaJZ-0006Tw-1Y
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 02:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVD0A1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 20:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVD0A1U
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 20:27:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:36499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261863AbVD0A1S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 20:27:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3R0RDs4009691
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 17:27:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3R0RChr020150;
	Tue, 26 Apr 2005 17:27:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0504261719230.18901@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Linus Torvalds wrote:
>
> [ "U" for "unmerged" ]
> 
> Btw, diff-cache definitely _can_ output this form, so we probably should 
> make diff-cache do so too, to match, no?

Actually, we should decide on what diff-tree-helper does before that. 
Right now it always either calls out to the external diff program, or it 
says "cannot parse".

It's possible that an external "diff" program might actually want to know
about unmerged files (maybe people don't actually do "diff", but something
else altogether), so one approach might be to just make that an option.

The other approach is to just have something like "<pathname> is unmerged"
as output from diff-tree-helper. That isn't quite as flexible, but it sure 
is simpler..

		Linus
