From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Do not show empty diff in diff-cache uncached.
Date: Sun, 29 May 2005 22:34:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505292231580.10545@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
 <7vsm091887.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
 <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> <7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
 <7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
 <7vis11n69l.fsf@assigned-by-dhcp.cox.net> <7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 07:31:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DccrL-0000LL-1D
	for gcvg-git@gmane.org; Mon, 30 May 2005 07:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVE3FdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 01:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVE3FdE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 01:33:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:30876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261518AbVE3FdA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 01:33:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4U5WsjA025726
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 29 May 2005 22:32:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4U5WrsX016475;
	Sun, 29 May 2005 22:32:54 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 29 May 2005, Junio C Hamano wrote:
> 
> Please disregard the patches you have already discarded so far;
> this request-to-discard includes -O and -B enhancements.

I actually like -B, it's just that that patch depended on -O and also came 
with a separate patch that was the reason I liked -B in the first place..

IO, if we have

	/* start out with files "a" and "b" */
	mv b c
	mv a b
	git-update-cache --add --remove a b c
	git-diff-cache -B HEAD

then I htink you're 100% right that it should show up as two renames in
a diffs, and "-B" would catch it. I think that's a great thing.

		Linus
