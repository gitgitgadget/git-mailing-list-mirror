From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Feb 2009 14:06:50 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902061357520.19665@iabervon.org>
References: <loom.20090206T035001-370@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joi Ellis <gyles19@visi.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVW3n-0001Jb-Pz
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 20:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbZBFTGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 14:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZBFTGw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 14:06:52 -0500
Received: from iabervon.org ([66.92.72.58]:54141 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580AbZBFTGv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 14:06:51 -0500
Received: (qmail 2062 invoked by uid 1000); 6 Feb 2009 19:06:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2009 19:06:50 -0000
In-Reply-To: <loom.20090206T035001-370@post.gmane.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108770>

On Fri, 6 Feb 2009, Joi Ellis wrote:

> I have an elderly laptop.  I can build and install git using a tarball.  I 
> original installed git 1.6.0.  This evening I noticed 1.6.1 was availble, and I 
> decided to try building from the git repository using 'git clone' as described 
> in the git home page.   And to jump ahead of myself, I want to point out that 
> 1.6.1 will build from the tarball.  However...
> 
> The workspace I get using 'git clone' does not provide a configure file.  And 
> because my laptop isn't running a bleeding edge distribution, my build tools 
> are older than you'd expect, so...
> 
> "make all" fails becuase my libaries are old:
> 
>     LINK git-fast-import
> fast-import.o: In function `store_object':
> /usr/local/src/git/git/fast-import.c:1086: undefined reference to `deflateBound'
> /usr/local/src/git/git/fast-import.c:1109: undefined reference to `deflateBound'

What zlib version do you have? If your libraries are old enough, git's 
cache.h header file should effectively enable NO_DEFLATE_BOUND. Maybe you 
have skew between your header files and the libraries the linker finds by 
default? Or maybe we should consider any zlib without a version in the 
header file old enough not to have deflateBound()?

	-Daniel
*This .sig left intentionally blank*
