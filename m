From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git://oss.sgi.com broke
Date: Mon, 6 Oct 2008 13:58:02 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810061353140.19665@iabervon.org>
References: <20081003121903.6c9a7ebc.akpm@linux-foundation.org> <alpine.LFD.2.00.0810061005540.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, xfs-masters@oss.sgi.com,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 19:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmuMX-0002u9-F5
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbYJFR6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 13:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYJFR6F
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 13:58:05 -0400
Received: from iabervon.org ([66.92.72.58]:45169 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531AbYJFR6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 13:58:04 -0400
Received: (qmail 16232 invoked by uid 1000); 6 Oct 2008 17:58:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Oct 2008 17:58:02 -0000
In-Reply-To: <alpine.LFD.2.00.0810061005540.3208@nehalem.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97616>

On Mon, 6 Oct 2008, Linus Torvalds wrote:

> On Fri, 3 Oct 2008, Andrew Morton wrote:
> >
> > y:/usr/src/git26> git --version
> > git version 1.5.6.rc0
> > 
> > y:/usr/src/git26> cat .git/branches/git-xfs
> > git://oss.sgi.com:8090/xfs/xfs-2.6.git#master
> 
> Hmm. That's the really old and deprecated branch format.
> 
> I'm getting a "Connection refused" from oss.sgi.com, and I think there's 
> possibly something broken there, but quite independently of that, maybe we 
> can try to teach you another way to set up remote branches?
> 
> In your .git/config file, use
> 
> 	[remote "git-xfs"]
> 		url = git://oss.sgi.com:8090/xfs/xfs-2.6.git
> 		fetch = master
> 
> because the whole .git/branches/<branch-name> thing is fairly deprecated, 
> and cannot handle some things that the .git/config file format can (like 
> saying where to fetch into, or how to push back etc).

I think Andrew convinced us to undeprecate that format, because he wants 
to be able to configure each branch with one line in a separate file. In 
any case, remote.c takes care of these things seemlessly.

	-Daniel
*This .sig left intentionally blank*
