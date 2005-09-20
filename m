From: Pavel Roskin <proski@gnu.org>
Subject: Re: Joining cg-*-id
Date: Mon, 19 Sep 2005 20:19:50 -0400
Message-ID: <1127175590.31115.10.camel@dv>
References: <1127166049.26772.26.camel@dv>
	 <20050919215608.GA13845@pasky.or.cz> <1127169021.26772.58.camel@dv>
	 <20050919225838.GH18320@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 02:21:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVrb-0006q5-0M
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbVITAT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVITAT4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:19:56 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:9894 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932724AbVITATz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 20:19:55 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHVrV-0004NN-Kz
	for git@vger.kernel.org; Mon, 19 Sep 2005 20:19:53 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHVrT-00087C-2q; Mon, 19 Sep 2005 20:19:51 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050919225838.GH18320@pasky.or.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8932>

On Tue, 2005-09-20 at 00:58 +0200, Petr Baudis wrote:
> Dear diary, on Tue, Sep 20, 2005 at 12:30:21AM CEST, I got a letter
> where Pavel Roskin <proski@gnu.org> told me that...
> > The value is having one command, one manpage and one place to fix little
> > bugs and add more functionality.  Potentially, cg-Xnormid could be
> > incorporated into that script, so bash wouldn't have to open one more
> > file.
> 
> Well, cg-Xnormid is basically pointless if it's not going to be a common
> backend for multiple other commands. So I'd say either supersede it with
> git-rev-parse or just merge it with cg-object-id.

Agreed.

> > Please don't apply my patch yet - I forgot to document the optional
> > argument.  I'll try to make cg-object-id now.
> 
> Which patch?

The one that adds USAGE.  Never mind - I see it's fixed already.

As for merging, I see that the existing *-id scripts are a mess.  For
instance, cg-parent returns parents separated by spaces, but cg-diff
used "head -1" on its output to get the first parent, i.e it assumes
newline separated output.

Another thing that is broken is "cg-commit-id origin^" - apparently the
"^" parsing is only designed for cg-parent-id.

I think I'll start a local branch for fixing this, and then I'll send
separate patches.

-- 
Regards,
Pavel Roskin
