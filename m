From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] remove vim syntax highlighting in favor of upstream
Date: Tue, 30 Sep 2008 10:29:37 +0200
Message-ID: <48E1E371.30804@drmicha.warpmail.net>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de>	<20080924155745.GA3908@coredump.intra.peff.net>	<20080924170154.GA6816@neumann>	<20080924175315.GA10337@coredump.intra.peff.net>	<20080924195658.GB6816@neumann>	<20080929145542.GA18340@spearce.org> <20080929200814.GA19840@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	vim@tpope.info, git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 30 10:31:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkadB-0000vf-5G
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 10:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYI3I3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Sep 2008 04:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbYI3I3m
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 04:29:42 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38952 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752139AbYI3I3l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2008 04:29:41 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 994FF170DC2;
	Tue, 30 Sep 2008 04:29:40 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 30 Sep 2008 04:29:40 -0400
X-Sasl-enc: 6QN6enw9NxPGmRTDdYfMXInab3uQSRokovMrjvjQCSzW 1222763380
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5DF17134AD;
	Tue, 30 Sep 2008 04:29:39 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <20080929200814.GA19840@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97080>

SZEDER G=E1bor venit, vidit, dixit 29.09.2008 22:08:
> As of version 7.2, vim ships with its own syntax
> highlighting for git commit messages, which is:
>=20
>   1. more comprehensive in splitting up the various
>      components of the file
>=20
>   2. in accordance with the usual vim behavior for syntax
>      highlighting (e.g., respecting b:current_syntax)
>=20
>   3. presumably better maintained (I have not been using
>      what's in git's contrib/ directory for some time in
>      favor of the upstream version)
>=20
> Furthermore, vim upsream also provides syntax highlighting
> for other git filetypes (gitconfig, rebase, send-email).
>=20
> This patch gets rid of our local version and just points
> interested parties to the upstream version.
>=20
> The code for auto-detecting filetypes is taken from vim's
> runtime/filetype.vim.
>=20
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
> ---
>=20
> On Mon, Sep 29, 2008 at 07:55:42AM -0700, Shawn O. Pearce wrote:
>> Missing SBO line?
> Here it is.  Since significant parts of the patch and the commit
> message are from Jeff, maybe he should sign off, too?
>=20
> Note, that this patch is slightly different from the previous one, as
> it proposes writing the auto-detect commands into ~/.vim/filetype.vim
> instead of ~/.vimrc.  It's not quite clear to me why, but it seems to
> resolve the filetype confusion I mentioned in my previous email.
>=20
>=20
>  contrib/vim/README               |   38 ++++++++++++++++++++++++++++=
++--------
>  contrib/vim/syntax/gitcommit.vim |   18 ------------------
>  2 files changed, 30 insertions(+), 26 deletions(-)
>  delete mode 100644 contrib/vim/syntax/gitcommit.vim
>=20
> diff --git a/contrib/vim/README b/contrib/vim/README
> index 9e7881f..c487346 100644
> --- a/contrib/vim/README
> +++ b/contrib/vim/README
> @@ -1,8 +1,30 @@
> -To syntax highlight git's commit messages, you need to:
> -  1. Copy syntax/gitcommit.vim to vim's syntax directory:
> -     $ mkdir -p $HOME/.vim/syntax
> -     $ cp syntax/gitcommit.vim $HOME/.vim/syntax
> -  2. Auto-detect the editing of git commit files:
> -     $ cat >>$HOME/.vimrc <<'EOF'
> -     autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=3Dgitcom=
mit
> -     EOF
> +Syntax highlighting for git commit messages, config files, etc. is
> +included with the vim distribution as of vim 7.2, and should work
> +automatically.
> +
> +If you have an older version of vim, you can get the latest syntax
> +files from the vim project:
> +
> +  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/git=
=2Evim
> +  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/git=
commit.vim
> +  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/git=
config.vim
> +  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/git=
rebase.vim
> +  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/git=
sendemail.vim
> +
> +To install:
> +
> +  1. Copy these files to vim's syntax directory $HOME/.vim/syntax
> +  2. To auto-detect the editing of various git-related filetypes:
> +	$ cat >>$HOME/.vim/filetype.vim <<'EOF'
> +	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcommit
> +	autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitconfig
> +	autocmd BufNewFile,BufRead git-rebase-todo         setf gitrebase
> +	autocmd BufNewFile,BufRead .msg.[0-9]*
> +		\ if getline(1) =3D~ '^From.*# This line is ignored.$' |
> +		\   setf gitsendemail |
> +		\ endif
> +	autocmd BufNewFile,BufRead *.git/**
> +		\ if getline(1) =3D~ '^\x\{40\}\>\|^ref: ' |
> +		\   setf git |
> +		\ endif
> +	EOF

Works as described with vim 7.1.

How about creating a syntax file for editing the files generated by
format-patch, especially 0000-cover-letter.patch? Should be mostly a
combination of "git.vim" and "gitsendemail.vim", but I didn't find any
syntax defs for the diffstat.

Michael

P.S.: What? Git doc linking to an svn repo? Someone needs to set up a
git mirror ;)
