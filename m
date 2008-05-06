From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 21:46:37 -0400
Message-ID: <20080506014636.GM29038@spearce.org>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org> <32541b130805051838k367c44bau715774b46f7894cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 03:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtCHI-0002A2-Fv
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 03:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbYEFBqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 21:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbYEFBqs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 21:46:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44230 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbYEFBqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 21:46:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JtCGC-0003jw-A3; Mon, 05 May 2008 21:46:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7D07320FBAE; Mon,  5 May 2008 21:46:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <32541b130805051838k367c44bau715774b46f7894cb@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81320>

Avery Pennarun <apenwarr@gmail.com> wrote:
> 
> I have a branch called 'mylib' with my library project in its root
> directory.  What I wanted was to maintain my library in the 'mylib'
> branch, then merge my library into the "libs/mylib" directory of my
> application, which is in the 'myapp' branch. [...]
> 
> This actually works like magic in git - except when you create a file
> in the 'mylib' branch, in which case it gets merged to the wrong path
> every single time.  It seems to me like it should be very easy to put
> it in the right place instead, making one more interesting use case
> possible.
> 
> I realize git-submodule is the way you're supposed to do something
> like this, but git-submodule doesn't really do what I want (yet) for
> reasons discussed in other threads.

`git pull -s subtree mylib` ?

This is how git-gui and gitk are merged into git.git, and it avoids
this case by looking for a subdirectory rename, more specifically
a rename of "/" to "mylib/".

It also can go the other way, that is rename "mylib/" to "/", but
this path is never used as far as I know as git-gui and gitk don't
ever merge in the git.git history.

-- 
Shawn.
