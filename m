From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 15:16:15 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803231509060.19665@iabervon.org>
References: <47E69044.3000207@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:17:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdVgi-00070a-UK
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbYCWTQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYCWTQU
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:16:20 -0400
Received: from iabervon.org ([66.92.72.58]:33996 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbYCWTQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:16:20 -0400
Received: (qmail 19386 invoked by uid 1000); 23 Mar 2008 19:16:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Mar 2008 19:16:15 -0000
In-Reply-To: <47E69044.3000207@zytor.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77948>

On Sun, 23 Mar 2008, H. Peter Anvin wrote:

> This much later, there are a few minor things I still miss from Cogito.  I
> believe fixing either would be quite trivial, so I thought I'd post a note.
> 
> 1. The ability to clone into the current directory
> 
>    cg-clone had a -c option, which allowed cloning into the current
>    directory.  This is particularly useful, since I keep my common
>    dot files in a git repository, so all I need to do to set up a new
>    machine is to clone that git repository over my empty home directory.
> 
>    Native git doesn't have any equivalent, other than:
> 
>    git clone -n .... tmp
>    mv tmp/.git .
>    rm -rf tmp
>    git checkout HEAD

Maybe "git --work-tree=. clone <remote>"? It currently complains about the 
directory existing, but we could have a flag to override that. And this 
ends up with a sort of neat arrangement where your home directory is "Not 
a git repository", but if you go into the subdirectory that has the repo 
files, you can do all the usual stuff. This helps to avoid the case where 
you forget to do "git init" in a new project and accidentally check things 
into your dotfiles.

	-Daniel
*This .sig left intentionally blank*
