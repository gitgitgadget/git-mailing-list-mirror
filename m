From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: Re: [PATCH v2 2/5] git-add.txt: document 'interactive.singlekey'
Date: Tue, 3 May 2011 17:38:57 +0200
Message-ID: <20110503153857.GC2211@kudu.in-berlin.de>
References: <20110501045140.GA13387@sigill.intra.peff.net> <1304343872-1654-3-git-send-email-valentin.haenel@gmx.de> <7v1v0hngs9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 17:47:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHHpG-0003TO-2M
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 17:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab1ECPro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 11:47:44 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:42695 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1ECPrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 11:47:43 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 May 2011 11:47:43 EDT
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p43FcwBx016571;
	Tue, 3 May 2011 17:38:59 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p43Fcv3U016570;
	Tue, 3 May 2011 17:38:57 +0200
X-Authentication-Warning: kudu.in-berlin.de: esc set sender to valentin.haenel@gmx.de using -f
Content-Disposition: inline
In-Reply-To: <7v1v0hngs9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172663>

Hi,

thanks for the feedback. I have some remaining questions, see below.

* Junio C Hamano <gitster@pobox.com> [110502]:
> Valentin Haenel <valentin.haenel@gmx.de> writes:
> 
> > Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
> > Helped-by: Jeff King <peff@peff.net>
> > ---
> >  Documentation/git-add.txt |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> > index 7eebbef..c172989 100644
> > --- a/Documentation/git-add.txt
> > +++ b/Documentation/git-add.txt
> > @@ -86,6 +86,9 @@ OPTIONS
> >  This effectively runs `add --interactive`, but bypasses the
> >  initial command menu and directly jumps to the `patch` subcommand.
> >  See ``Interactive mode'' for details.
> > ++
> > +The configuration `interactive.singlekey` allows the user to provide
> > +one-letter input with a single key in this mode (i.e., without hitting enter).
> 
> I do not think this belongs here.  For one thing, as the text in the
> pre-context in your patch says, this also applies to "-i".  Since they
> both refer to the "Interactive mode" section for further details, I think
> that would be more appropriate place to mention the variable, which after
> all is a tiny part of the detail (think: if somebody does not know how to
> operate the interactive mode, "singlekey does not require enter" is not
> very helpful).

I agree that details should go into the section "Interactive Mode". 

However, it would seem that the configuration influences only the
patch mode of the interactive mode (unless i am missing something).
I just tried to naviagte the menu i get with 'git add -i' and typing the
enter was required. (Using 1.7.5) This would affect the positioning of
the addition, see below.

> Not all the configuration variables "git-add" pays attention to are
> mentioned in this manual page (e.g. color.interactive.<slot> and
> add.ignoreerrors are not mentioned).  I also do not think duplicating
> everything "git add" pays attention to in this manual page is necessarily
> a good thing.  I'd prefer to mention only the important ones (e.g. the
> ones that give default values for their corresponding command line
> options) in the main part of the documentation.
> 
> For the other commands that internally invoke "add -p", the text before
> your patch is unhelpful to people who have not seen "git add -p" in
> action.  Some of them do not even mention where the interactive mode is
> explained.  The result of your patch does not help the situation, and
> abruptly start talking about interactive.singlekey, still without teaching
> how to operate the interactive mode at all.

Yeah, I agree.

> I think the end result of the series should look something like this patch,
> after applying your [PATCH 1/5], but discarding 2 thru 5.
> 
> 
>  Documentation/git-add.txt      |    5 ++++-
>  Documentation/git-checkout.txt |    4 +++-
>  Documentation/git-reset.txt    |    4 +++-
>  Documentation/git-stash.txt    |    4 +++-
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 7eebbef..27e0160 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -134,6 +134,8 @@ subdirectories.
>  	If some files could not be added because of errors indexing
>  	them, do not abort the operation, but continue adding the
>  	others. The command shall still exit with non-zero status.
> +	The configuration variable `add.ignoreErrors` can be set to
> +	true to make this the default behaviour.

Its unrelated to 'interactive.singlekey', can i 'stuff' it into the
series too, or better make a seperate one?

>  
>  --ignore-missing::
>  	This option can only be used together with --dry-run. By using
> @@ -189,7 +191,8 @@ interactive command loop.
>  The command loop shows the list of subcommands available, and
>  gives a prompt "What now> ".  In general, when the prompt ends
>  with a single '>', you can pick only one of the choices given
> -and type return, like this:
> +and type return (the configuration variable `interactive.singlekey`
> +can be set to true to omit hitting return, by the way), like this:

If what i wrote above is correct, this should go into the section about
the patch mode, rather than here?

>  ------------
>      *** Commands ***
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 1063f69..7c58028 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -179,7 +179,9 @@ the conflicted merge in the specified paths.
>  --patch::
>  	Interactively select hunks in the difference between the
>  	<tree-ish> (or the index, if unspecified) and the working
> -	tree.  The chosen hunks are then applied in reverse to the
> +	tree (see the ``Interactive Mode`` section of gitlink:git-add[1]
> +	to learn how to operate the interactive mode).  The chosen
> +	hunks are then applied in reverse to the
>  	working tree (and if a <tree-ish> was specified, the index).
>  +
>  This means that you can use `git checkout -p` to selectively discard
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 8481f9d..37f487e 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -36,7 +36,9 @@ working tree in one go.
>  
>  'git reset' --patch|-p [<commit>] [--] [<paths>...]::
>  	Interactively select hunks in the difference between the index
> -	and <commit> (defaults to HEAD).  The chosen hunks are applied
> +	and <commit> (see the ``Interactive Mode``
> +	section of gitlink:git-add[1] to learn how to operate the interactive
> +	mode).  Missing <commit> defaults to HEAD.  The chosen hunks are applied
>  	in reverse to the index.
>  +
>  This means that `git reset -p` is the opposite of `git add -p` (see
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 79abc38..281bd35 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -55,7 +55,9 @@ If the `--keep-index` option is used, all changes already added to the
>  index are left intact.
>  +
>  With `--patch`, you can interactively select hunks from in the diff
> -between HEAD and the working tree to be stashed.  The stash entry is
> +between HEAD and the working tree to be stashed (see the ``Interactive Mode``
> +section of gitlink:git-add[1] to learn how to operate the interactive
> +mode).  The stash entry is
>  constructed such that its index state is the same as the index state
>  of your repository, and its worktree contains only the changes you
>  selected interactively.  The selected changes are then rolled back
