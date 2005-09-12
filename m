From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Mon, 12 Sep 2005 14:42:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121438150.3266@g5.osdl.org>
References: <20050912181101.GA22221@vrfy.org> <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org>
 <20050912195947.GA28502@vrfy.org> <Pine.LNX.4.58.0509121316030.3266@g5.osdl.org>
 <20050912210006.GA32211@vrfy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 23:43:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEw4H-0001ef-2C
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVILVmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVILVmW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:42:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932276AbVILVmV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 17:42:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CLgJBo023232
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 14:42:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CLgHaL021862;
	Mon, 12 Sep 2005 14:42:18 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050912210006.GA32211@vrfy.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8439>



On Mon, 12 Sep 2005, Kay Sievers wrote:
> 
> Everthing that walk from one commit to another, uses git-rev-list, sure.
> But in the commit view, and the commitdiff the "parent" link and the parent
> that is passed to diff is read from the commit itself.
> 
> > (So instead of trying to parse the parent info from the header of the 
> > commit, just do "git-rev-list --pretty --parents" and parse that).
> 
> I need only one parent:
>   git-rev-list --parents --max-count=1 <id>

Who don't you use that to show the comments too? 

So instead of doing

	git-cat-file commit <id>

(or whatever you do), just do

	git-rev-list --parents --pretty=raw --max-count=1 <id>

That way you don't get any extra fork/exec overhead - you get everything 
with one program.

		Linus
