From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add test for cloning with "--reference" repo being a
 subset of source repo
Date: Mon, 3 Mar 2008 11:36:50 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803031130090.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <alpine.LSU.1.00.0803020743170.22527@racer.site> <alpine.LNX.1.00.0803021128510.19665@iabervon.org> <200803031004.16568.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 17:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWDfU-0005SV-Ia
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 17:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbYCCQg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 11:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbYCCQg5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 11:36:57 -0500
Received: from iabervon.org ([66.92.72.58]:51230 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202AbYCCQg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 11:36:56 -0500
Received: (qmail 5486 invoked by uid 1000); 3 Mar 2008 16:36:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Mar 2008 16:36:50 -0000
In-Reply-To: <200803031004.16568.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75941>

On Mon, 3 Mar 2008, Johan Herland wrote:

> However, we should also test the case where the "--reference" repo is a
> _subset_ of the source repo (e.g. "git clone -l -s --reference A B C"),
> i.e. some objects are not available in the "--reference" repo, and will
> have to be found in the source repo.
> 
> However, this added test currently fails for me with the following output:
> 
> repo is /home/johan/git/git/t/trash/B/.git
> dir is E
> Initialize E/.git
> Initialized empty Git repository in E/.git/
> Okay
> Wrote /home/johan/git/git/t/trash/A/.git/objects
>  to E/.git/objects/info/alternates
> Wrote /home/johan/git/git/t/trash/B/.git/objects
>  to E/.git/objects/info/alternates
> Get for /home/johan/git/git/t/trash/B/.git
> error: Trying to write ref refs/remotes/origin/master with nonexistant object 276cf9e94287a7c4e6f79b2724460e9650fa4871
> fatal: Cannot update the ref 'refs/remotes/origin/master'.
> Remove junk E/.git
> Remove junk E
> 
> The same test work well with git-clone.sh.
> Not sure what's going on here, yet, but I thought I'd give you a heads up.

Thanks for the report; I haven't really gone through the local clone 
stuff, and I've altered the use of chdir at various points, so it's quite 
possible that it's not right at all for some cases.

	-Daniel
*This .sig left intentionally blank*
