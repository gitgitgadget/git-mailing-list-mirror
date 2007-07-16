From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: finding the right remote branch for a commit
Date: Mon, 16 Jul 2007 11:14:15 +0200
Message-ID: <20070716091415.GA31186@moooo.ath.cx>
References: <20070710144907.GA324@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707112226170.4516@racer.site> <20070715223341.GA3797@moooo.ath.cx> <Pine.LNX.4.64.0707160036160.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 11:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAMev-0001sg-Kr
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 11:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbXGPJOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 05:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755377AbXGPJOV
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 05:14:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:35276 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755550AbXGPJOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 05:14:20 -0400
Received: (qmail invoked by alias); 16 Jul 2007 09:14:18 -0000
Received: from pD9EBB6D1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.182.209]
  by mail.gmx.net (mp035) with SMTP; 16 Jul 2007 11:14:18 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19Xi9JcUdNXXyL3nG2Jcltpy6oh+05fh6HlNkOiYj
	Yw4zw3q26i/ZXS
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707160036160.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52652>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 16 Jul 2007, Matthias Lederhofer wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Use
> > 
> >     $ git --work-tree "$HOME" --git-dir . init
> > 
> > instead.
> 
> Why _should_ that be necessary at all?  I _already_ told git that the 
> working tree is somewhere else.  It makes _no sense at all_ to treat the 
> cwd as anything else than the GIT_DIR, when --work-tree but no --git-dir 
> were specified.
>
> > IMHO the --bare flag did not make much sense before the introduction
> > of GIT_WORK_TREE and doesn't after, at least not with the meaning it
> > has: why should 'git --bare' mean to use the repository from cwd?
> 
> To the contrary, it makes tons of sense.  If you want to initialise a bare 
> repository, what _more_ natural way than to say "git init --bare"?  And 
> what _more_ natural place to pick for GIT_DIR than the cwd, when you did 
> not specify --git-dir?

Ah, for git init it makes sense to have the --bare flag and also to
use the cwd as GIT_DIR when GIT_WORK_TREE is specified.

> > > [descriptions of bugs, that have been largely ignored]

The last paragraphs were for the second and fourth one (git status/add
from outside the working tree): it should be possible to fix this but
it might be a bit complicated.  And if it is done for a few commands
probably all commands should support this.

For the third one (git picks up another git repository even if it is
inside a 'detached working tree') I have no idea how to fix this.  The
working tree cannot be recognized in any way.  Maybe you can/should
use a symlink to the real repository named .git in this case?  But
this only works as long as you checkout only one repository in the
directory.

> > Up to now you are supposed to be in the working tree all the time when 
> > using it.  Therefore I'd call these feature requests rather than bugs :)
> 
> Feature requests? WTF? What reason is there for the _requirement_ to 
> specify a working tree, when git does not make use of it?  Hmm?

Sorry, I don't understand what you mean yet.  Where does git require
you to specify a working tree?
