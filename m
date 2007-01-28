From: Theodore Tso <tytso@mit.edu>
Subject: Re: Rebasing stgit stacks
Date: Sat, 27 Jan 2007 23:33:12 -0500
Message-ID: <20070128043312.GG9897@thunk.org>
References: <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com> <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net> <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com> <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 28 05:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB1jf-00021P-5K
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 05:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbXA1Ed3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 23:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbXA1Ed3
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 23:33:29 -0500
Received: from THUNK.ORG ([69.25.196.29]:48615 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932416AbXA1Ed2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 23:33:28 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HB1o5-0004Eq-IV; Sat, 27 Jan 2007 23:38:23 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HB1j6-00039N-Pd; Sat, 27 Jan 2007 23:33:12 -0500
Content-Disposition: inline
In-Reply-To: <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38018>

On Mon, Jan 22, 2007 at 10:58:41PM +0000, Catalin Marinas wrote:
> StGIT stacks are a series of volatile commits (commits) at the top of
> a branch. The idea when I started writing this tool was that a series
> of applied patches would lead to the head of the current branch. The
> branch and stack are tightly coupled and you cannot simply change the
> parent branch the stack is based on (not from a technical point but
> rather from conception one).

Well, a typical use case for me is:

	stg branch master
	git pull .
	stg branch 2.6.20-rc5
	stg export -d /tmp/temp-stack
	stg branch master
	stg branch -C 2.6.20-rc6
	stg import -s /tmp/temp-stack/series 

That's because I want to keep the original patch series for
2.6.20-rc5, but I also want rebase the patch set to 2.6.20-rc6.  Is
there a better way of doing this?  

						- Ted
