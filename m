From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [MERGE] Combine git-tools repository into example-tools/
 subdirectory of git
Date: Sat, 16 Jul 2005 10:19:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507161015230.19183@g5.osdl.org>
References: <20050716075553.GI20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 19:20:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtqKr-00014E-7M
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 19:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVGPRUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 13:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGPRUK
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 13:20:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261230AbVGPRUI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2005 13:20:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6GHK1jA005432
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Jul 2005 10:20:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6GHJr0M012755;
	Sat, 16 Jul 2005 10:19:58 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050716075553.GI20369@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Jul 2005, Ryan Anderson wrote:
> 
> Linus, it seems, well, odd to me that you maintain two different git
> trees.

Yes.

> So I used your example of the gittk merge to move git-tools into the
> main git-repository.

Fair enough. I was ready to pull your work, but it turns out that the old 
git-tools repository had things like directory entries with file mode 
100775, so git-fsck-cache complains about it. I've already suppressed 
git-fsck-cache on mode 100664 (which exists in both the kernel and git 
archives), so I could have just added the other case, but I preferred to 
just make git-convert-cache convert it, and then pull in a _converted_ 
tools archive instead.

[ Side note: I'm actually happy by how git-convert-cache was still 100%
  functional.  I haven't touched it in a long time, and it's very intimate
  with the objects, so the fact that it still worked means that we haven't 
  screwed anything up in the object format ;]

I did mostly the same things you did, except I also dropped "stripspace",
since I'd already copied it over to git (and it's now installed as
"git-stripspace") earlier. And I just called the subdirectory "tools".

		Linus
