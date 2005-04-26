From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add -r flag to show-diff for diff-cache/diff-tree like
 output.
Date: Tue, 26 Apr 2005 15:40:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
 <7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:34:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYcT-0004Ik-PK
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVDZWio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVDZWio
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:38:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:4828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261826AbVDZWin (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 18:38:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QMccs4001047
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 15:38:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QMcba5014912;
	Tue, 26 Apr 2005 15:38:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Junio C Hamano wrote:
>
> This adds a new option -r (rational) to show-diff command, to
> produce diff-cache/diff-tree compatible output.

Why not just make this the default? Who really cares about show-diff? I 
see that "cg-merge" uses it, but does so with the "s" flag, just to see 
whether there are any changes at all.

So why not just make "rational" the standard format, and then make 
"diff-tree-helper" warn about unmerged ("U") files?

As far as I can tell, that is really what _everybody_ wants.

And calling "-r" "rational", when it means "recursive" for diff-tree and 
diff-cache doesn't sound rational to me. It _is_ rational to just silently 
accept it as "recursive", the same way diff-cache does.

		Linus
