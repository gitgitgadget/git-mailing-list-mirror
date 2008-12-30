From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git clone - failing on cygwin with git:// but not with ssh://
Date: Tue, 30 Dec 2008 18:52:59 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812301845390.19665@iabervon.org>
References: <ud4fdxn08.fsf@terrapin.northbound-train.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joe Casadonte <jcasadonte@northbound-train.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 00:54:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHoPn-0006r8-Qo
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 00:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYL3XxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 18:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbYL3XxB
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 18:53:01 -0500
Received: from iabervon.org ([66.92.72.58]:39984 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbYL3XxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 18:53:00 -0500
Received: (qmail 19014 invoked by uid 1000); 30 Dec 2008 23:52:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Dec 2008 23:52:59 -0000
In-Reply-To: <ud4fdxn08.fsf@terrapin.northbound-train.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104227>

On Sat, 27 Dec 2008, Joe Casadonte wrote:

> Hi,
> 
> I'm new to git, so my apologies if I'm missing something pretty
> basic.  Here's my setup:
> 
> "Public" server
> ---------------
> OS: RedHat clone, 2.6.9 kernel
> git version: self-compiled, 1.6.0.6
> 
> Test client #1 (works)
> ----------------------
> OS: RedHat clone, 2.6.9 kernel
> git version: self-compiled, 1.6.0.6
> 
> Test client #2 (fails)
> ----------------------
> OS: Win XP Pro
> git version: cygwin compiled, 1.6.0.4

I'd try the msysgit version...

> 
> I have a new repository on the "public" server, and have cloned it on
> test client #1 with:
> 
> $ git clone git://foobar/myproj.git
> Initialized empty Git repository in /opt/myproj/.git/
> remote: Counting objects: 104, done.
> remote: Compressing objects: 100% (72/72), done.
> remote: Total 104 (delta 22), reused 104 (delta 22)
> Receiving objects: 100% (104/104), 76.97 KiB, done.
> Resolving deltas: 100% (22/22), done.
> 
> 
> I try the same thing on test box #2 and receive:
> 
> 
> D:\temp>git clone git://foobar/otminfmyproj.git
> Initialized empty Git repository in /cygdrive/d/temp/foobar/.git/
> fatal: read error (Socket operation on non-socket)
> fatal: early EOF
> fatal: index-pack failed

As Junio said, this smells like the build you have of git or of cygwin 
aren't dealing correctly with Windows' non-POSIX-ness. The msysgit version 
is more self-contained, and doesn't expect the system to be POSIX at all.

	-Daniel
*This .sig left intentionally blank*
