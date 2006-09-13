From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/vim: add syntax highlighting file for commits
Date: Wed, 13 Sep 2006 02:25:57 -0400
Message-ID: <20060913062557.GA4783@coredump.intra.peff.net>
References: <20060911232249.GB29736@coredump.intra.peff.net> <20060912020813.GD26332@socrates.priv> <20060912023256.GA6596@coredump.intra.peff.net> <7vy7so9txj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Wed Sep 13 08:26:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNOCT-000245-Mr
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 08:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWIMG0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 02:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWIMG0A
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 02:26:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:47779 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751572AbWIMGZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 02:25:59 -0400
Received: (qmail 19302 invoked from network); 13 Sep 2006 02:25:09 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 13 Sep 2006 02:25:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2006 02:25:57 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7so9txj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26904>

On Tue, Sep 12, 2006 at 11:12:08PM -0700, Junio C Hamano wrote:

> I am not a vim user, but my reading of Tom's comment is that he
> thinks it would have been nicer if the file the patch adds were
> named gitcommit.vim, not commit-syntax.vim.  As you seem to
> agree that the preferred name for this file when deployed is
> gitcommit.vim, how about something like this on top of your
> patch perhaps?

My point was that there may be many files named gitcommit.vim; the
directory they appear in under your .vim directory has significance. If
we add another such file, they will conflict in the flattened namespace
of contrib/vim.  See below (which also adds the necessary mkdir
command):

-- >8 --
contrib/vim: give commit-syntax a more sensible name

diff --git a/contrib/vim/README b/contrib/vim/README
index bad0a05..9e7881f 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -1,6 +1,7 @@
 To syntax highlight git's commit messages, you need to:
-  1. Copy commit-syntax.vim to vim's syntax directory:
-     $ cp commit-syntax.vim $HOME/.vim/syntax/gitcommit.vim
+  1. Copy syntax/gitcommit.vim to vim's syntax directory:
+     $ mkdir -p $HOME/.vim/syntax
+     $ cp syntax/gitcommit.vim $HOME/.vim/syntax
   2. Auto-detect the editing of git commit files:
      $ cat >>$HOME/.vimrc <<'EOF'
      autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
diff --git a/contrib/vim/commit-syntax.vim b/contrib/vim/syntax/gitcommit.vim
similarity index 100%
rename from contrib/vim/commit-syntax.vim
rename to contrib/vim/syntax/gitcommit.vim
