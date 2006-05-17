From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 09:24:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605170919290.10823@g5.osdl.org>
References: <4973.1147836384@lotus.CS.Berkeley.EDU> 
 <Pine.LNX.4.64.0605162047380.10823@g5.osdl.org> 
 <f3d7535d0605170105j2a6942cfh5a5a8a0d6153046f@mail.gmail.com> 
 <Pine.LNX.4.64.0605170728520.10823@g5.osdl.org>
 <f3d7535d0605170808l21d9f6d0gff1afaa10db17af9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 17 18:25:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgOol-0007Qk-D5
	for gcvg-git@gmane.org; Wed, 17 May 2006 18:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWEQQYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWEQQYI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 12:24:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750726AbWEQQYG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 12:24:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HGO2tH029784
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 09:24:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HGO1sx018308;
	Wed, 17 May 2006 09:24:02 -0700
To: Stefan Pfetzing <stefan.pfetzing@gmail.com>
In-Reply-To: <f3d7535d0605170808l21d9f6d0gff1afaa10db17af9@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20211>



On Wed, 17 May 2006, Stefan Pfetzing wrote:
> 
> Ok, if I would do so, my prefix would be /usr/pkg, and the bindir would be
> /usr/pkg/bin. So I would need to have an xargs and so on symlink in
> /usr/pkg/bin.
> But this is simply not acceptable, because it breaks other NetBSD
> pkgsrc scripts.

DON'T USE /usr/pkg then.

Use /usr/pkg/git-core/share/ or something that is normally not on your 
path.

And then install _just_ the "git" binary in /usr/pkg/bin.

That must be allowable by whatever solaris packaging rules: it's not like 
other projects don't have their own internal library files.

Then you install the GNU symlinks under that same

	/usr/pkg/git-core/share/bin

and you're all set. The only binary you can _see_ is "git", and when that 
executes any scripts or other git binaries, it will set up the path to 
include that magic hidden directory.

> Besides that, installing git to a different location is not an option
> for me, because I want to have git packaged by pkgsrc.

Now, I'm told pkgsrc is horrible, but it can't be so horrid as to not 
allow private directories?

		Linus
