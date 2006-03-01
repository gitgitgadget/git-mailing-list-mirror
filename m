From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Wed, 1 Mar 2006 15:43:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603011538580.22647@g5.osdl.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
 <4405C6BE.2000706@op5.se> <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
 <200603011814.43573.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0603010935201.22647@g5.osdl.org>
 <7virqyf094.fsf@assigned-by-dhcp.cox.net> <46a038f90603011340k23327f11s6e3d9d69585a5188@mail.gmail.com>
 <87zmk9zr42.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Andreas Ericsson <ae@op5.se>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 00:44:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEazT-0005a8-I7
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 00:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWCAXoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 18:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWCAXoQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 18:44:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750854AbWCAXoP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 18:44:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21NhuDZ003403
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 15:43:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21NhbqV027090;
	Wed, 1 Mar 2006 15:43:45 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87zmk9zr42.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17031>



On Wed, 1 Mar 2006, Carl Worth wrote:

> Meanwhile, as I've been teaching new git users, I've had to carefully
> teach:
> 
> 1) Never commit to a branch name that appears on the right side of ':'
>    in a Pull: refspec.
> 
> 2) BTW, that ':' might be only implicit. A refspec of "branch" is
>    equivalent to "branch:branch" so don't commit to those either.
> 
> That's pretty painful, so I really think these remote-tracking refs
> belong outside of refs/heads.

In the same vein, I think the refs/remotes/<remotename>/<branchname> 
naming will make it possible for people who track multiple remotes to 
sanely work with the fact that they might track 10 separate branches from 
Jeff, one branch from me, and a couple of branches from Greg in the same 
tree, without just going crazy.

I agree that we could solve the "don't touch that branch" issue another 
way, by just making them read-only. But the reason I like the separate 
namespace is that it just seems to organize the branches really well, and 
in an unambiguous - and logical - manner.

I too find myself looking at "git branch" output, and a lot of it is stuff 
I don't really care about - much of it is just the branches I got for just 
tracking Junio's git repo.

		Linus
