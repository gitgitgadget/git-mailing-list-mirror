From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] Fix single quotes, AsciiDoc escaping, and other formatting issues
Date: Mon, 18 Nov 2013 13:33:42 -0800
Message-ID: <xmqqa9h1bdjd.fsf@gitster.dls.corp.google.com>
References: <1384479242-21144-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Mon Nov 18 22:33:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViWS9-0007Ai-C4
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 22:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab3KRVdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 16:33:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab3KRVds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 16:33:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C40652DB4;
	Mon, 18 Nov 2013 16:33:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rpUGuWLyLtA2avzCRC+8J3XLX1E=; b=VPksc4
	PQLY8y9lBiKVqFk8MDyAAHG7aUB+SDmr0f2x7cATE7Sk3rq8u2ltE7zqBBdFarr0
	NCfoSdHuy6mgddu41RryrJouKUuIkVavJ6xQ39rbOvKzYz1p6wuXVPZx5noao59g
	F7hWgy/kP4CRRx15p18drZ8kZe4DVXX9u9qBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R7C0agEX2H5pAovmeC03ageM6tWOUo80
	ZQEwCJl353wUHnQYxSq3vGeU+A/0jyEyAM1wE4EMKPrN5+WdqtgYx/ap9OF4SwLZ
	36rohK8MjebOfkgWv2A+15CAtQYTgTVeG+TfvsC3p+HkUaeUfjERc8ZzIJqd7gd8
	Hj3G45C9c24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC32152DB3;
	Mon, 18 Nov 2013 16:33:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA2E052DB2;
	Mon, 18 Nov 2013 16:33:45 -0500 (EST)
In-Reply-To: <1384479242-21144-1-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Thu, 14 Nov 2013 20:34:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1AA3731E-5099-11E3-8DB9-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238015>

"Jason St. John" <jstjohn@purdue.edu> writes:

> rev-list-options.txt:
> -- Remove blank lines after some options subheadings to fix syntax
>      highlighting in Vim
> -- Typeset literal options, commands, and path names in monospace
> -- Remove AsciiDoc escapes with literal
> -- Replace some double quotes with proper AsciiDoc quotes (e.g. ``foo'')
>
> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
> ---
> This is a resubmit of a previous patch:
> http://marc.info/?l=git&m=138431995913311&w=2
>
> I decided to remove the blank lines after option subheadings because the syntax
> highlighting in Vim actually looks better with them removed. I'm not sure how this
> affects line-rewrapping of the body text in Emacs.

If I wasn't clear, it makes things very bad in Emacs when M-q
(fill-paragraph) is used.

In any way, consistency is good, so let's queue this version while
waiting to hear from those who regularly help updating our docs. 

> I split the previous patch into two. This patch deals strictly with formatting
> issues and backticks/literals. The second patch contains the grammatical and typo
> fixes.

Thanks.

>
>
>  Documentation/rev-list-options.txt | 226 +++++++++++++------------------------
>  1 file changed, 78 insertions(+), 148 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index ec86d09..eb4b6bf 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -18,33 +18,27 @@ ordering and formatting options, such as `--reverse`.
>  -<number>::
>  -n <number>::
>  --max-count=<number>::
> -
>  	Limit the number of commits to output.
>  
>  --skip=<number>::
> -
>  	Skip 'number' commits before starting to show the commit output.
>  
>  --since=<date>::
>  --after=<date>::
> -
>  	Show commits more recent than a specific date.
>  
>  --until=<date>::
>  --before=<date>::
> -
>  	Show commits older than a specific date.
>  
>  ifdef::git-rev-list[]
>  --max-age=<timestamp>::
>  --min-age=<timestamp>::
> -
>  	Limit the commits output to specified time range.
>  endif::git-rev-list[]
>  
>  --author=<pattern>::
>  --committer=<pattern>::
> -
>  	Limit the commits output to ones with author/committer
>  	header lines that match the specified pattern (regular
>  	expression).  With more than one `--author=<pattern>`,
> @@ -52,7 +46,6 @@ endif::git-rev-list[]
>  	chosen (similarly for multiple `--committer=<pattern>`).
>  
>  --grep-reflog=<pattern>::
> -
>  	Limit the commits output to ones with reflog entries that
>  	match the specified pattern (regular expression). With
>  	more than one `--grep-reflog`, commits whose reflog message
> @@ -60,7 +53,6 @@ endif::git-rev-list[]
>  	error to use this option unless `--walk-reflogs` is in use.
>  
>  --grep=<pattern>::
> -
>  	Limit the commits output to ones with log message that
>  	matches the specified pattern (regular expression).  With
>  	more than one `--grep=<pattern>`, commits whose message
> @@ -71,46 +63,38 @@ When `--show-notes` is in effect, the message from the notes as
>  if it is part of the log message.
>  
>  --all-match::
> -	Limit the commits output to ones that match all given --grep,
> +	Limit the commits output to ones that match all given `--grep`,
>  	instead of ones that match at least one.
>  
>  -i::
>  --regexp-ignore-case::
> -
>  	Match the regexp limiting patterns without regard to letters case.
>  
>  --basic-regexp::
> -
>  	Consider the limiting patterns to be basic regular expressions;
>  	this is the default.
>  
>  -E::
>  --extended-regexp::
> -
>  	Consider the limiting patterns to be extended regular expressions
>  	instead of the default basic regular expressions.
>  
>  -F::
>  --fixed-strings::
> -
>  	Consider the limiting patterns to be fixed strings (don't interpret
>  	pattern as a regular expression).
>  
>  --perl-regexp::
> -
>  	Consider the limiting patterns to be Perl-compatible regexp.
>  	Requires libpcre to be compiled in.
>  
>  --remove-empty::
> -
>  	Stop when a given path disappears from the tree.
>  
>  --merges::
> -
>  	Print only merge commits. This is exactly the same as `--min-parents=2`.
>  
>  --no-merges::
> -
>  	Do not print commits with more than one parent. This is
>  	exactly the same as `--max-parents=1`.
>  
> @@ -118,7 +102,6 @@ if it is part of the log message.
>  --max-parents=<number>::
>  --no-min-parents::
>  --no-max-parents::
> -
>  	Show only commits which have at least (or at most) that many parent
>  	commits. In particular, `--max-parents=1` is the same as `--no-merges`,
>  	`--min-parents=2` is the same as `--merges`.  `--max-parents=0`
> @@ -138,31 +121,26 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
>  	brought in to your history by such a merge.
>  
>  --not::
> -
>  	Reverses the meaning of the '{caret}' prefix (or lack thereof)
> -	for all following revision specifiers, up to the next '--not'.
> +	for all following revision specifiers, up to the next `--not`.
>  
>  --all::
> -
>  	Pretend as if all the refs in `refs/` are listed on the
>  	command line as '<commit>'.
>  
>  --branches[=<pattern>]::
> -
>  	Pretend as if all the refs in `refs/heads` are listed
>  	on the command line as '<commit>'. If '<pattern>' is given, limit
>  	branches to ones matching given shell glob. If pattern lacks '?',
>  	'{asterisk}', or '[', '/{asterisk}' at the end is implied.
>  
>  --tags[=<pattern>]::
> -
>  	Pretend as if all the refs in `refs/tags` are listed
>  	on the command line as '<commit>'. If '<pattern>' is given, limit
>  	tags to ones matching given shell glob. If pattern lacks '?', '{asterisk}',
>  	or '[', '/{asterisk}' at the end is implied.
>  
>  --remotes[=<pattern>]::
> -
>  	Pretend as if all the refs in `refs/remotes` are listed
>  	on the command line as '<commit>'. If '<pattern>' is given, limit
>  	remote-tracking branches to ones matching given shell glob.
> @@ -175,13 +153,11 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
>  	or '[', '/{asterisk}' at the end is implied.
>  
>  --ignore-missing::
> -
>  	Upon seeing an invalid object name in the input, pretend as if
>  	the bad input was not given.
>  
>  ifndef::git-rev-list[]
>  --bisect::
> -
>  	Pretend as if the bad bisection ref `refs/bisect/bad`
>  	was listed and as if it was followed by `--not` and the good
>  	bisection refs `refs/bisect/good-*` on the command
> @@ -189,7 +165,6 @@ ifndef::git-rev-list[]
>  endif::git-rev-list[]
>  
>  --stdin::
> -
>  	In addition to the '<commit>' listed on the command
>  	line, read them from the standard input. If a '--' separator is
>  	seen, stop reading commits and start reading paths to limit the
> @@ -197,36 +172,32 @@ endif::git-rev-list[]
>  
>  ifdef::git-rev-list[]
>  --quiet::
> -
>  	Don't print anything to standard output.  This form
>  	is primarily meant to allow the caller to
>  	test the exit status to see if a range of objects is fully
>  	connected (or not).  It is faster than redirecting stdout
> -	to /dev/null as the output does not have to be formatted.
> +	to `/dev/null` as the output does not have to be formatted.
>  endif::git-rev-list[]
>  
>  --cherry-mark::
> -
>  	Like `--cherry-pick` (see below) but mark equivalent commits
>  	with `=` rather than omitting them, and inequivalent ones with `+`.
>  
>  --cherry-pick::
> -
>  	Omit any commit that introduces the same change as
> -	another commit on the "other side" when the set of
> +	another commit on the ``other side'' when the set of
>  	commits are limited with symmetric difference.
>  +
>  For example, if you have two branches, `A` and `B`, a usual way
>  to list all commits on only one side of them is with
>  `--left-right` (see the example below in the description of
>  the `--left-right` option).  It however shows the commits that were cherry-picked
> -from the other branch (for example, "3rd on b" may be cherry-picked
> +from the other branch (for example, ``3rd on b'' may be cherry-picked
>  from branch A).  With this option, such pairs of commits are
>  excluded from the output.
>  
>  --left-only::
>  --right-only::
> -
>  	List only commits on the respective side of a symmetric range,
>  	i.e. only those which would be marked `<` resp. `>` by
>  	`--left-right`.
> @@ -238,7 +209,6 @@ More precisely, `--cherry-pick --right-only --no-merges` gives the exact
>  list.
>  
>  --cherry::
> -
>  	A synonym for `--right-only --cherry-mark --no-merges`; useful to
>  	limit the output to the commits on our side and mark those that
>  	have been applied to the other side of a forked history with
> @@ -247,30 +217,27 @@ list.
>  
>  -g::
>  --walk-reflogs::
> -
>  	Instead of walking the commit ancestry chain, walk
>  	reflog entries from the most recent one to older ones.
>  	When this option is used you cannot specify commits to
>  	exclude (that is, '{caret}commit', 'commit1..commit2',
>  	nor 'commit1\...commit2' notations cannot be used).
>  +
> -With '\--pretty' format other than oneline (for obvious reasons),
> +With `--pretty` format other than `oneline` (for obvious reasons),
>  this causes the output to have two extra lines of information
>  taken from the reflog.  By default, 'commit@\{Nth}' notation is
>  used in the output.  When the starting commit is specified as
>  'commit@\{now}', output also uses 'commit@\{timestamp}' notation
> -instead.  Under '\--pretty=oneline', the commit message is
> +instead.  Under `--pretty=oneline`, the commit message is
>  prefixed with this information on the same line.
> -This option cannot be combined with '\--reverse'.
> +This option cannot be combined with `--reverse`.
>  See also linkgit:git-reflog[1].
>  
>  --merge::
> -
>  	After a failed merge, show refs that touch files having a
>  	conflict and don't exist on all heads to merge.
>  
>  --boundary::
> -
>  	Output excluded boundary commits. Boundary commits are
>  	prefixed with `-`.
>  
> @@ -287,11 +254,9 @@ is how to do it, as there are various strategies to simplify the history.
>  The following options select the commits to be shown:
>  
>  <paths>::
> -
>  	Commits modifying the given <paths> are selected.
>  
>  --simplify-by-decoration::
> -
>  	Commits that are referred by some branch or tag are selected.
>  
>  Note that extra commits can be shown to give a meaningful history.
> @@ -299,33 +264,27 @@ Note that extra commits can be shown to give a meaningful history.
>  The following options affect the way the simplification is performed:
>  
>  Default mode::
> -
>  	Simplifies the history to the simplest history explaining the
>  	final state of the tree. Simplest because it prunes some side
>  	branches if the end result is the same (i.e. merging branches
>  	with the same content)
>  
>  --full-history::
> -
>  	Same as the default mode, but does not prune some history.
>  
>  --dense::
> -
>  	Only the selected commits are shown, plus some to have a
>  	meaningful history.
>  
>  --sparse::
> -
>  	All commits in the simplified history are shown.
>  
>  --simplify-merges::
> -
> -	Additional option to '--full-history' to remove some needless
> +	Additional option to `--full-history` to remove some needless
>  	merges from the resulting history, as there are no selected
>  	commits contributing to this merge.
>  
>  --ancestry-path::
> -
>  	When given a range of commits to display (e.g. 'commit1..commit2'
>  	or 'commit2 {caret}commit1'), only display commits that exist
>  	directly on the ancestry chain between the 'commit1' and
> @@ -352,36 +311,35 @@ The horizontal line of history A---Q is taken to be the first parent of
>  each merge.  The commits are:
>  
>  * `I` is the initial commit, in which `foo` exists with contents
> -  "asdf", and a file `quux` exists with contents "quux".  Initial
> +  ``asdf'', and a file `quux` exists with contents ``quux''. Initial
>    commits are compared to an empty tree, so `I` is !TREESAME.
>  
> -* In `A`, `foo` contains just "foo".
> +* In `A`, `foo` contains just ``foo''.
>  
>  * `B` contains the same change as `A`.  Its merge `M` is trivial and
>    hence TREESAME to all parents.
>  
> -* `C` does not change `foo`, but its merge `N` changes it to "foobar",
> +* `C` does not change `foo`, but its merge `N` changes it to ``foobar'',
>    so it is not TREESAME to any parent.
>  
> -* `D` sets `foo` to "baz".  Its merge `O` combines the strings from
> -  `N` and `D` to "foobarbaz"; i.e., it is not TREESAME to any parent.
> +* `D` sets `foo` to ``baz''. Its merge `O` combines the strings from
> +  `N` and `D` to ``foobarbaz''; i.e., it is not TREESAME to any parent.
>  
> -* `E` changes `quux` to "xyzzy", and its merge `P` combines the
> -  strings to "quux xyzzy".  `P` is TREESAME to `O`, but not to `E`.
> +* `E` changes `quux` to ``xyzzy'', and its merge `P` combines the
> +  strings to ``quux xyzzy''. `P` is TREESAME to `O`, but not to `E`.
>  
>  * `X` is an independent root commit that added a new file `side`, and `Y`
>    modified it. `Y` is TREESAME to `X`. Its merge `Q` added `side` to `P`, and
>    `Q` is TREESAME to `P`, but not to `Y`.
>  
> -'rev-list' walks backwards through history, including or excluding
> -commits based on whether '\--full-history' and/or parent rewriting
> -(via '\--parents' or '\--children') are used.  The following settings
> +`rev-list` walks backwards through history, including or excluding
> +commits based on whether `--full-history` and/or parent rewriting
> +(via `--parents` or `--children`) are used. The following settings
>  are available.
>  
>  Default mode::
> -
>  	Commits are included if they are not TREESAME to any parent
> -	(though this can be changed, see '\--sparse' below).  If the
> +	(though this can be changed, see `--sparse` below).  If the
>  	commit was a merge, and it was TREESAME to one parent, follow
>  	only that parent.  (Even if there are several TREESAME
>  	parents, follow only one of them.)  Otherwise, follow all
> @@ -400,12 +358,11 @@ available, removed `B` from consideration entirely.  `C` was
>  considered via `N`, but is TREESAME.  Root commits are compared to an
>  empty tree, so `I` is !TREESAME.
>  +
> -Parent/child relations are only visible with --parents, but that does
> +Parent/child relations are only visible with `--parents`, but that does
>  not affect the commits selected in default mode, so we have shown the
>  parent lines.
>  
>  --full-history without parent rewriting::
> -
>  	This mode differs from the default in one point: always follow
>  	all parents of a merge, even if it is TREESAME to one of them.
>  	Even if more than one side of the merge has commits that are
> @@ -425,9 +382,8 @@ about the parent/child relationships between the commits, so we show
>  them disconnected.
>  
>  --full-history with parent rewriting::
> -
>  	Ordinary commits are only included if they are !TREESAME
> -	(though this can be changed, see '\--sparse' below).
> +	(though this can be changed, see `--sparse` below).
>  +
>  Merges are always included.  However, their parent list is rewritten:
>  Along each parent, prune away commits that are not included
> @@ -441,7 +397,7 @@ themselves.  This results in
>  	  `-------------'
>  -----------------------------------------------------------------------
>  +
> -Compare to '\--full-history' without rewriting above.  Note that `E`
> +Compare to `--full-history` without rewriting above.  Note that `E`
>  was pruned away because it is TREESAME, but the parent list of P was
>  rewritten to contain `E`'s parent `I`.  The same happened for `C` and
>  `N`, and `X`, `Y` and `Q`.
> @@ -450,22 +406,19 @@ In addition to the above settings, you can change whether TREESAME
>  affects inclusion:
>  
>  --dense::
> -
>  	Commits that are walked are included if they are not TREESAME
>  	to any parent.
>  
>  --sparse::
> -
>  	All commits that are walked are included.
>  +
> -Note that without '\--full-history', this still simplifies merges: if
> +Note that without `--full-history`, this still simplifies merges: if
>  one of the parents is TREESAME, we follow only that one, so the other
>  sides of the merge are never walked.
>  
>  --simplify-merges::
> -
>  	First, build a history graph in the same way that
> -	'\--full-history' with parent rewriting does (see above).
> +	`--full-history` with parent rewriting does (see above).
>  +
>  Then simplify each commit `C` to its replacement `C'` in the final
>  history according to the following rules:
> @@ -484,7 +437,7 @@ history according to the following rules:
>  --
>  +
>  The effect of this is best shown by way of comparing to
> -'\--full-history' with parent rewriting.  The example turns into:
> +`--full-history` with parent rewriting.  The example turns into:
>  +
>  -----------------------------------------------------------------------
>  	  .-A---M---N---O
> @@ -494,7 +447,7 @@ The effect of this is best shown by way of comparing to
>  	  `---------'
>  -----------------------------------------------------------------------
>  +
> -Note the major differences in `N`, `P` and `Q` over '--full-history':
> +Note the major differences in `N`, `P` and `Q` over `--full-history`:
>  +
>  --
>  * `N`'s parent list had `I` removed, because it is an ancestor of the
> @@ -511,11 +464,10 @@ Note the major differences in `N`, `P` and `Q` over '--full-history':
>  Finally, there is a fifth simplification mode available:
>  
>  --ancestry-path::
> -
>  	Limit the displayed commits to those directly on the ancestry
> -	chain between the "from" and "to" commits in the given commit
> -	range. I.e. only display commits that are ancestor of the "to"
> -	commit, and descendants of the "from" commit.
> +	chain between the ``from'' and ``to'' commits in the given commit
> +	range. I.e. only display commits that are ancestor of the ``to''
> +	commit, and descendants of the ``from'' commit.
>  +
>  As an example use case, consider the following commit history:
>  +
> @@ -530,14 +482,14 @@ As an example use case, consider the following commit history:
>  A regular 'D..M' computes the set of commits that are ancestors of `M`,
>  but excludes the ones that are ancestors of `D`. This is useful to see
>  what happened to the history leading to `M` since `D`, in the sense
> -that "what does `M` have that did not exist in `D`". The result in this
> +that ``what does `M` have that did not exist in `D`''. The result in this
>  example would be all the commits, except `A` and `B` (and `D` itself,
>  of course).
>  +
>  When we want to find out what commits in `M` are contaminated with the
>  bug introduced by `D` and need fixing, however, we might want to view
>  only the subset of 'D..M' that are actually descendants of `D`, i.e.
> -excluding `C` and `K`. This is exactly what the '--ancestry-path'
> +excluding `C` and `K`. This is exactly what the `--ancestry-path`
>  option does. Applied to the 'D..M' range, it results in:
>  +
>  -----------------------------------------------------------------------
> @@ -548,7 +500,7 @@ option does. Applied to the 'D..M' range, it results in:
>  				L--M
>  -----------------------------------------------------------------------
>  
> -The '\--simplify-by-decoration' option allows you to view only the
> +The `--simplify-by-decoration` option allows you to view only the
>  big picture of the topology of the history, by omitting commits
>  that are not referenced by tags.  Commits are marked as !TREESAME
>  (in other words, kept after history simplification rules described
> @@ -561,50 +513,47 @@ Bisection Helpers
>  ~~~~~~~~~~~~~~~~~
>  
>  --bisect::
> -
> -Limit output to the one commit object which is roughly halfway between
> -included and excluded commits. Note that the bad bisection ref
> -`refs/bisect/bad` is added to the included commits (if it
> -exists) and the good bisection refs `refs/bisect/good-*` are
> -added to the excluded commits (if they exist). Thus, supposing there
> -are no refs in `refs/bisect/`, if
> -
> +	Limit output to the one commit object which is roughly halfway between
> +	included and excluded commits. Note that the bad bisection ref
> +	`refs/bisect/bad` is added to the included commits (if it
> +	exists) and the good bisection refs `refs/bisect/good-*` are
> +	added to the excluded commits (if they exist). Thus, supposing there
> +	are no refs in `refs/bisect/`, if
> ++
>  -----------------------------------------------------------------------
>  	$ git rev-list --bisect foo ^bar ^baz
>  -----------------------------------------------------------------------
> -
> ++
>  outputs 'midpoint', the output of the two commands
> -
> ++
>  -----------------------------------------------------------------------
>  	$ git rev-list foo ^midpoint
>  	$ git rev-list midpoint ^bar ^baz
>  -----------------------------------------------------------------------
> -
> ++
>  would be of roughly the same length.  Finding the change which
>  introduces a regression is thus reduced to a binary search: repeatedly
>  generate and test new 'midpoint's until the commit chain is of length
>  one.
>  
>  --bisect-vars::
> -
> -This calculates the same as `--bisect`, except that refs in
> -`refs/bisect/` are not used, and except that this outputs
> -text ready to be eval'ed by the shell. These lines will assign the
> -name of the midpoint revision to the variable `bisect_rev`, and the
> -expected number of commits to be tested after `bisect_rev` is tested
> -to `bisect_nr`, the expected number of commits to be tested if
> -`bisect_rev` turns out to be good to `bisect_good`, the expected
> -number of commits to be tested if `bisect_rev` turns out to be bad to
> -`bisect_bad`, and the number of commits we are bisecting right now to
> -`bisect_all`.
> +	This calculates the same as `--bisect`, except that refs in
> +	`refs/bisect/` are not used, and except that this outputs
> +	text ready to be eval'ed by the shell. These lines will assign the
> +	name of the midpoint revision to the variable `bisect_rev`, and the
> +	expected number of commits to be tested after `bisect_rev` is tested
> +	to `bisect_nr`, the expected number of commits to be tested if
> +	`bisect_rev` turns out to be good to `bisect_good`, the expected
> +	number of commits to be tested if `bisect_rev` turns out to be bad to
> +	`bisect_bad`, and the number of commits we are bisecting right now to
> +	`bisect_all`.
>  
>  --bisect-all::
> -
> -This outputs all the commit objects between the included and excluded
> -commits, ordered by their distance to the included and excluded
> -commits. Refs in `refs/bisect/` are not used. The farthest
> -from them is displayed first. (This is the only one displayed by
> -`--bisect`.)
> +	This outputs all the commit objects between the included and excluded
> +	commits, ordered by their distance to the included and excluded
> +	commits. Refs in `refs/bisect/` are not used. The farthest
> +	from them is displayed first. (This is the only one displayed by
> +	`--bisect`.)
>  +
>  This is useful because it makes it easy to choose a good commit to
>  test when you want to avoid to test some of them for some reason (they
> @@ -654,9 +603,8 @@ avoid showing the commits from two parallel development track mixed
>  together.
>  
>  --reverse::
> -
>  	Output the commits in reverse order.
> -	Cannot be combined with '\--walk-reflogs'.
> +	Cannot be combined with `--walk-reflogs`.
>  
>  Object Traversal
>  ~~~~~~~~~~~~~~~~
> @@ -664,37 +612,32 @@ Object Traversal
>  These options are mostly targeted for packing of Git repositories.
>  
>  --objects::
> -
>  	Print the object IDs of any object referenced by the listed
> -	commits.  '--objects foo ^bar' thus means "send me
> +	commits.  `--objects foo ^bar` thus means ``send me
>  	all object IDs which I need to download if I have the commit
> -	object 'bar', but not 'foo'".
> +	object _bar_ but not _foo_''.
>  
>  --objects-edge::
> -
> -	Similar to '--objects', but also print the IDs of excluded
> -	commits prefixed with a "-" character.  This is used by
> -	linkgit:git-pack-objects[1] to build "thin" pack, which records
> +	Similar to `--objects`, but also print the IDs of excluded
> +	commits prefixed with a ``-'' character.  This is used by
> +	linkgit:git-pack-objects[1] to build ``thin'' pack, which records
>  	objects in deltified form based on objects contained in these
>  	excluded commits to reduce network traffic.
>  
>  --unpacked::
> -
> -	Only useful with '--objects'; print the object IDs that are not
> +	Only useful with `--objects`; print the object IDs that are not
>  	in packs.
>  
>  --no-walk[=(sorted|unsorted)]::
> -
>  	Only show the given commits, but do not traverse their ancestors.
>  	This has no effect if a range is specified. If the argument
> -	"unsorted" is given, the commits are show in the order they were
> -	given on the command line. Otherwise (if "sorted" or no argument
> +	`unsorted` is given, the commits are show in the order they were
> +	given on the command line. Otherwise (if `sorted` or no argument
>  	was given), the commits are show in reverse chronological order
>  	by commit time.
>  
>  --do-walk::
> -
> -	Overrides a previous --no-walk.
> +	Overrides a previous `--no-walk`.
>  
>  Commit Formatting
>  ~~~~~~~~~~~~~~~~~
> @@ -708,17 +651,15 @@ endif::git-rev-list[]
>  include::pretty-options.txt[]
>  
>  --relative-date::
> -
>  	Synonym for `--date=relative`.
>  
>  --date=(relative|local|default|iso|rfc|short|raw)::
> -
>  	Only takes effect for dates shown in human-readable format, such
> -	as when using "--pretty". `log.date` config variable sets a default
> -	value for log command's --date option.
> +	as when using `--pretty`. `log.date` config variable sets a default
> +	value for log command's `--date` option.
>  +
>  `--date=relative` shows dates relative to the current time,
> -e.g. "2 hours ago".
> +e.g. ``2 hours ago''.
>  +
>  `--date=local` shows timestamps in user's local time zone.
>  +
> @@ -736,18 +677,15 @@ format, often found in E-mail messages.
>  
>  ifdef::git-rev-list[]
>  --header::
> -
>  	Print the contents of the commit in raw-format; each record is
>  	separated with a NUL character.
>  endif::git-rev-list[]
>  
>  --parents::
> -
>  	Print also the parents of the commit (in the form "commit parent...").
>  	Also enables parent rewriting, see 'History Simplification' below.
>  
>  --children::
> -
>  	Print also the children of the commit (in the form "commit child...").
>  	Also enables parent rewriting, see 'History Simplification' below.
>  
> @@ -757,7 +695,6 @@ ifdef::git-rev-list[]
>  endif::git-rev-list[]
>  
>  --left-right::
> -
>  	Mark which side of a symmetric diff a commit is reachable from.
>  	Commits from the left side are prefixed with `<` and those from
>  	the right with `>`.  If combined with `--boundary`, those
> @@ -787,7 +724,6 @@ you would get an output like this:
>  -----------------------------------------------------------------------
>  
>  --graph::
> -
>  	Draw a text-based graphical representation of the commit history
>  	on the left hand side of the output.  This may cause extra lines
>  	to be printed in between commits, in order for the graph history
> @@ -795,21 +731,20 @@ you would get an output like this:
>  +
>  This enables parent rewriting, see 'History Simplification' below.
>  +
> -This implies the '--topo-order' option by default, but the
> -'--date-order' option may also be specified.
> +This implies the `--topo-order` option by default, but the
> +`--date-order` option may also be specified.
>  
>  ifdef::git-rev-list[]
>  --count::
>  	Print a number stating how many commits would have been
>  	listed, and suppress all other output.  When used together
> -	with '--left-right', instead print the counts for left and
> +	with `--left-right`, instead print the counts for left and
>  	right commits, separated by a tab. When used together with
> -	'--cherry-mark', omit patch equivalent commits from these
> +	`--cherry-mark`, omit patch equivalent commits from these
>  	counts and print the count for equivalent commits separated
>  	by a tab.
>  endif::git-rev-list[]
>  
> -
>  ifndef::git-rev-list[]
>  Diff Formatting
>  ~~~~~~~~~~~~~~~
> @@ -819,7 +754,6 @@ Some of them are specific to linkgit:git-rev-list[1], however other diff
>  options may be given. See linkgit:git-diff-files[1] for more options.
>  
>  -c::
> -
>  	With this option, diff output for a merge commit
>  	shows the differences from each of the parents to the merge result
>  	simultaneously instead of showing pairwise diff between a parent
> @@ -827,26 +761,22 @@ options may be given. See linkgit:git-diff-files[1] for more options.
>  	which were modified from all parents.
>  
>  --cc::
> -
> -	This flag implies the '-c' option and further compresses the
> +	This flag implies the `-c` option and further compresses the
>  	patch output by omitting uninteresting hunks whose contents in
>  	the parents have only two variants and the merge result picks
>  	one of them without modification.
>  
>  -m::
> -
>  	This flag makes the merge commits show the full diff like
>  	regular commits; for each merge parent, a separate log entry
>  	and diff is generated. An exception is that only diff against
> -	the first parent is shown when '--first-parent' option is given;
> +	the first parent is shown when `--first-parent` option is given;
>  	in that case, the output represents the changes the merge
>  	brought _into_ the then-current branch.
>  
>  -r::
> -
>  	Show recursive diffs.
>  
>  -t::
> -
> -	Show the tree objects in the diff output. This implies '-r'.
> +	Show the tree objects in the diff output. This implies `-r`.
>  endif::git-rev-list[]
