From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Last mile for 1.0
Date: Mon, 6 Jun 2005 00:03:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506052358330.1876@ppc970.osdl.org>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
 <20050606054356.GB3669@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org> <7vis0sugp7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:58:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfBYa-00089K-7e
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVFFHBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 03:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFFHBX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 03:01:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:25777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbVFFHBS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 03:01:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j56716jA031265
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Jun 2005 00:01:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j56714l6012126;
	Mon, 6 Jun 2005 00:01:05 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis0sugp7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 5 Jun 2005, Junio C Hamano wrote:
> 
> Is test 44 in t1000 (the first one in t1000 after the lib-
> read-tree-m-3way prepares the test trees) good enough?  Or do
> you want more specific tests to make sure the logic catches
> individual cases right?

I was more thinking of all the individual cases, and also the 2-way merge
issue (which _should_ be a lot easier, but hey, I had tons of bugs there
too).

For example, what should happen if you do a merge and you have a file in
the index that isn't mentioned by any of the trees involved. I consider 
that a failure, since the merge will remove the file, and since it wasn't 
committed, it's now a "data lost" issue. But did I actually get it right? 
I have no idea.

			Linus
