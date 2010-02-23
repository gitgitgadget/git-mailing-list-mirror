From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [msysGit] [PATCH] submodules: ensure clean environment
	when operating  in a submodule
Date: Tue, 23 Feb 2010 22:07:53 +0100
Message-ID: <20100223210751.GA10932@book.hvoigt.net>
References: <20100218203726.GD12660@book.hvoigt.net> <1266877015-7943-1-git-send-email-giuseppe.bilotta@gmail.com> <alpine.DEB.1.00.1002230103160.3609@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:08:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1zC-0004Ii-FV
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab0BWVIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:08:00 -0500
Received: from darksea.de ([83.133.111.250]:41958 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752562Ab0BWVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:07:59 -0500
Received: (qmail 17172 invoked from network); 23 Feb 2010 22:07:55 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Feb 2010 22:07:55 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1002230103160.3609@intel-tinevez-2-302>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140838>

On Tue, Feb 23, 2010 at 01:04:00AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 22 Feb 2010, Giuseppe Bilotta wrote:
> 
> > git-submodule takes care of clearing GIT_DIR whenever it operates
> > on a submodule index or configuration, but forgot to unset GIT_WORK_TREE
> > before operating on the submodule worktree, which would lead to failures
> > when GIT_WORK_TREE was set.
> > 
> > This only happened in very unusual contexts such as operating on the
> > main worktree from outside of it, but since "git-gui: set GIT_DIR and
> > GIT_WORK_TREE after setup" (a9fa11fe5bd5978bb) such failures could also
> > be provoked by invoking an external tool such as "git submodule update"
> > from the Git GUI in a standard setup.
> > 
> > Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> > ---
> 
> Heiko, would you say that this patch is an elegant solution to the problem 
> you reported? If so, would you please pull it to 4msysgit.git's devel?

I would like to leave the patch cooking a little more. For example see
the objection of Jens[1]. Just to be sure that we do not pull in other
issues with this. Sorry I do not have the time for extensive testing
currently. So my suggestion would be to leave msysgit in the current
state as I did not discover any downsides with just the revert with my
current users tests.

As far as I understand the patch fixes issues when submodules itself
contain submodules and it seems that not many users are doing this
currently. Once everybody is happy (and tried) the patches I do not have
any objections to pushing it into devel.

What do you think?

cheers Heiko

[1] http://groups.google.com/group/msysgit/msg/481e252ba4f49ede
