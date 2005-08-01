From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git diffs
Date: Mon, 1 Aug 2005 08:51:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508010849390.14342@g5.osdl.org>
References: <20050731172256.73f91a20.akpm@osdl.org>
 <Pine.LNX.4.58.0507311725590.14342@g5.osdl.org> <pan.2005.08.01.07.55.40.43904@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 17:56:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dzce0-0004Qo-NM
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 17:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVHAPzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 11:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVHAPx2
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 11:53:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262234AbVHAPvl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2005 11:51:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j71FpEjA023916
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 1 Aug 2005 08:51:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j71FpD1U016239;
	Mon, 1 Aug 2005 08:51:14 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.08.01.07.55.40.43904@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 1 Aug 2005, Matthias Urlichs wrote:
>
> Hi, Linus Torvalds wrote:
> 
> > 	git checkout -f master
> > 	git-rev-parse master > .git/refs/heads/merge-branch
> > 
> > 	#
> > 	# Switch to it, always leaving "master" untouched
> > 	#
> > 	git checkout -f merge-branch
> 
> Isn't that equivalent to (but slower than)
> 
>     git checkout -f -b merge-branch master

No.

If you had a previous merge-branch (because something went wrong last 
time, and you just re-start the whole thing), you really want to _first_ 
force the branch to "master", and then create the new merge-branch.

Also, the last "git checkout -f merge-branch" will be pretty much zero
time, because the stuff is already at the right point, so it will
basically end up just re-doing the symlink.

So I did it that strange way for a reason.

		Linus
