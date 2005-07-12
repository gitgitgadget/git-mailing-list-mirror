From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 20:09:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
 <20050712021004.GA27576@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 05:12:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsBCS-0001OS-Mr
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 05:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVGLDM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 23:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVGLDJv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 23:09:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261984AbVGLDJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 23:09:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C399jA016541
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 20:09:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C39809018286;
	Mon, 11 Jul 2005 20:09:09 -0700
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050712021004.GA27576@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Marc Singer wrote:
> 
> From my POV, what I want is a branch with the tag v2.6.12 as the basis
> of the branch.  I'm guessing that -b means "make me a branch and call
> it this".

Yup. That would be the interface.

>  # git checkout -b BRANCH_NAME [TAG]
> 
> If the TAG is omitted, the branch is made from the current HEAD or
> some other reasonable point defined by the current working directory.

That would be the most natural thing that would fall out of this kind of 
interface.

> Are uncommitted changes present in the working directory maintained?
> Discarded?  I wont't care since I'll never be doing that.  At least,
> not on purpose.

They'd be maintained. If they clash with the target being checked out (ie
the checked-out tag would have changes to those files) it would error out
with a "I can't do that, Dave".

Unless you give the "-f" flag, in which case they're all thrown out, and
"git checkout" will force the new state and throw away any old state
entirely.

			Linus
