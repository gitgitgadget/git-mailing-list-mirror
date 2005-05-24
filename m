From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 15:11:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241502160.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
 <20050524202846.GC25606@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241345280.2307@ppc970.osdl.org>
 <20050524215238.GG25606@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 00:09:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DahZJ-0005rN-OO
	for gcvg-git@gmane.org; Wed, 25 May 2005 00:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVEXWJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 18:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVEXWJl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 18:09:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:38281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262207AbVEXWJg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 18:09:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OM9SjA028009
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 15:09:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OM9QAL020823;
	Tue, 24 May 2005 15:09:27 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050524215238.GG25606@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Thomas Glanzmann wrote:
> 
> I did one sampling and though it would be representative which it isn't.
> What I don't understand why noone ever fixed this? cvs has its own rcs
> implementation anyway to speed things up, hasn't it?

CVS has so many warts, that people can't even be bothered to fix things
like this. It's file-based, and that's that.

Using "-z 1" with cvsps doesn't seem to work well for me, but "-z 5" seems
ok, and together with the new git that allows .cvsignore, it doesn't
generate any warnings, nor any unreachable blobs. It does generate 300 new
changesets, and how many of those are required, I dunno. Clearly 102 of
them were, to disambiguate those changelog things.

Maybe "-z 10" would have generated a better thing with fewer changes yet
still unique changesets without dup files.

That's a bit irritating, that there's this magic tweakable that generates
different trees. Oh, well.

Anyway, what worries me more is that cvsps might have re-ordered other 
changesets than just the first two. It probably doesn't _matter_, but 
still...

		Linus
