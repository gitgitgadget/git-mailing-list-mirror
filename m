From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Sat, 9 Jul 2005 22:11:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507092206480.17536@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
 <7vy88ica8e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
 <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 07:11:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrU6K-0004qT-GL
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 07:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVGJFLR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 01:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGJFLR
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 01:11:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261846AbVGJFLO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 01:11:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6A5B8jA010198
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Jul 2005 22:11:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6A5B7bF000332;
	Sat, 9 Jul 2005 22:11:07 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 9 Jul 2005, Eric W. Biederman wrote:
> 
> I assume the problem with the mirror it model was simply there were
> to many objects?

Yes.

> > And then you really can use just rsync or wget or ncftpget or anything
> > else that has a "fetch recursively, optimizing existing objects" mode.
> 
> Sane.  But with an intelligent fetcher and a little extra information a
> dumb server should still be able to not fetch branches we care nothing
> about.  I think that extra information is simply commit object graph and
> which packs those commit objects are in.  I assume the commit graph
> information will be fairly modest.

Well, what I'd hope for is actually that eventually "webgit" will have 
some machine-parseable sub-tree, and then you can have this kind of thing 
generated automatically.

But a _truly_ dumb server (ie one with no CGI at all, just "raw data", you
really end up with just effectively rsyncing it. Yes, you could create a
new "commit index file" every time you push, and maybe it's worth it, but 
on the other hand, what's wrong with just rsyncing it all and parsing it 
locally instead?

People who use it for major development would all try to get the smart 
client, even if it's "just" some webgit extension thing..

Dumb servers work, they just won't do any selective stuff. Big deal. 
That's why they are dumb.

		Linus
