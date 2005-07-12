From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Mon, 11 Jul 2005 18:14:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111810380.17536@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
 <7vy88ica8e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
 <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507101517370.17536@g5.osdl.org>
 <m1irzh74m0.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110928070.17536@g5.osdl.org>
 <m13bqk26pp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 03:19:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds9Qy-0008Vh-Jr
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 03:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVGLBTC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 21:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVGLBRB
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 21:17:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261839AbVGLBOz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 21:14:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C1EljA008761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 18:14:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C1Ekue013556;
	Mon, 11 Jul 2005 18:14:46 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m13bqk26pp.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Eric W. Biederman wrote:
>
> Ok.  Only the dumb methods are allowed.

Well, no, you can actually do git-clone-pack by hand in that git archive,
and it will use the smart packing to get the other end, even if it is
totally unrelated to the current project.

But you have to do it by "hand" in the sense that none of the nice helper
scripts will help you to do this. Merging two unrelated projects really is
a very special operation. I've done it once (gitk into git), and I don't
think we'll see it done very many times again.

> > So if you only get one branch, it will leave the objects that are specific 
> > to other branches alone.
> 
> Hmm.  As I recall reading the code it grabs everything that is
> in .git/refs/*.

Only by default.

If you specify a branch (or five) git-clone-pack will grab only that
branch.

However, I don't think "git clone" (the script) even exposes that, so
right now you'd not even see it - "git clone" only exposes the "get all
the branches by default" behaviour.

		Linus
