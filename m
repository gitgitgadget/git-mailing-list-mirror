From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: git://oss.sgi.com broke
Date: Tue, 7 Oct 2008 10:32:08 -0700
Message-ID: <20081007103208.6fb4f0a6.akpm@linux-foundation.org>
References: <20081003121903.6c9a7ebc.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0810061005540.3208@nehalem.linux-foundation.org>
	<alpine.LNX.1.00.0810061353140.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	xfs-masters@oss.sgi.com, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 19:34:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnGR4-0000Ik-EM
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 19:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbYJGRcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 13:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbYJGRcP
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 13:32:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59798 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752936AbYJGRcO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2008 13:32:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m97HW9fN002052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Oct 2008 10:32:10 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m97HW8Tk022511;
	Tue, 7 Oct 2008 10:32:08 -0700
In-Reply-To: <alpine.LNX.1.00.0810061353140.19665@iabervon.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.325 required=5 tests=AWL,BAYES_00,WEIRD_PORT
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97734>

On Mon, 6 Oct 2008 13:58:02 -0400 (EDT) Daniel Barkalow <barkalow@iabervon.org> wrote:

> On Mon, 6 Oct 2008, Linus Torvalds wrote:
> 
> > On Fri, 3 Oct 2008, Andrew Morton wrote:
> > >
> > > y:/usr/src/git26> git --version
> > > git version 1.5.6.rc0
> > > 
> > > y:/usr/src/git26> cat .git/branches/git-xfs
> > > git://oss.sgi.com:8090/xfs/xfs-2.6.git#master
> > 
> > Hmm. That's the really old and deprecated branch format.
> > 
> > I'm getting a "Connection refused" from oss.sgi.com, and I think there's 
> > possibly something broken there, but quite independently of that, maybe we 
> > can try to teach you another way to set up remote branches?
> > 
> > In your .git/config file, use
> > 
> > 	[remote "git-xfs"]
> > 		url = git://oss.sgi.com:8090/xfs/xfs-2.6.git
> > 		fetch = master
> > 
> > because the whole .git/branches/<branch-name> thing is fairly deprecated, 
> > and cannot handle some things that the .git/config file format can (like 
> > saying where to fetch into, or how to push back etc).
> 
> I think Andrew convinced us to undeprecate that format, because he wants 
> to be able to configure each branch with one line in a separate file. In 
> any case, remote.c takes care of these things seemlessly.
> 

Well I was kinda attached to the old format but my world wouldn't end
if it went away.

Judging from the Next/Trees contents, I suspect that Stephen uses the old
convenient/compact/one-per-file form too.
