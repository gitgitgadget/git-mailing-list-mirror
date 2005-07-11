From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 10:06:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
 <m1eka574c8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 19:19:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds1vO-000458-VZ
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 19:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVGKRK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 13:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVGKRIn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 13:08:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44237 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262067AbVGKRGJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 13:06:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BH67jA001656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 10:06:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BH66ub017908;
	Mon, 11 Jul 2005 10:06:06 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1eka574c8.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Eric W. Biederman wrote:
> 
> A couple of pieces.  The dist target has assumes git-tar-tree is in the
> path.  Making it so you have to have git installed to build the rpm.

Yes. Maybe we could relax that requirement by using "./git-tar-tree" or 
something? That still requires that you have _built_ git to do the rpm, 
but at least you won't have had to install it.

Does that fit the rpm build process? Or does an rpm build make something 
like that really inconvenient? I don't know, patches welcome.

> The man pages are not built. The build dependencies do not call out
> the tools necessary to build the man pages.

Most people don't have asciidoc, and I'm not sure we want to require it. 
Maybe we could have a separate "make man-rpm" target for that?

> And it does not pass my torture test of building rpm's on debian,
> but that is not a huge problem.

Ok, why is debian problematic? Is there some missing dependency or 
something? I really haven't ever done an rpm, and the git rpm target was 
all done by Chris Wright, so I don't have any clue at all. Again, patches 
welcome.

> Are you still up for a patch that records who and when made a tag?
> I sent one but it seems to have been lost.

I'd really actually prefer for the code to be shared with the commit code, 
so that the user info (name, email, date) would not just be exactly the 
same, but would share the same code so that we don't end up having them 
ever get out of sync. 

That would imply moving parts of "git-tag-script" into mktag.c.

		Linus
