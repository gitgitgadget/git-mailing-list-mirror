From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 16:25:39 -0700
Message-ID: <20081031232539.GB14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <490B9262.5070905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Santos <nayart3@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:26:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3OH-00089s-R5
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbYJaXZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYJaXZl
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:25:41 -0400
Received: from george.spearce.org ([209.20.77.23]:40483 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYJaXZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:25:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E28D93835F; Fri, 31 Oct 2008 23:25:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <490B9262.5070905@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99677>

Bruno Santos <nayart3@gmail.com> wrote:
> Shawn O. Pearce wrote:
> > During the GitTogether we were kicking around the idea of a ground-up
> > implementation of a Git library.
> 
> We should take the opportunity a make it more portable. Instead of using
> the posix api directly we should warp it in "git_" APIs. And be carefull
> with certain APIs like fork or fork+exec [...]
> 
> Here's an example, for the 'read' API, on how we can simply do this
> without worries for the posix crowd:
> 
> ssize_t git_read(git_fildes_t fildes, void* buf, size_t bufsize);
> 
> Were git_fildes_t would be an int for posix and an HANDLE for win32.
...

Yes, already on my mind.  _IF_ this carries further I'll be involved
with its development, and I'll make certain its reasonably portable
like you are asking.

There are only a handful of things we really need to from the OS
and I think we can wrap most of them up into little inline stubs
on POSIX (so POSIX folks have no impact) and on Win32 we can have
small stubs (or again inline) so its pretty native on Win32.

Yes, I have considered say NPR or APR; I'm not going there.
Both are nice packages but there's also downsides to bringing them
into libgit2.  IMHO its just easier to wrap the handful of things
we really need.

-- 
Shawn.
