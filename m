From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/4] wt-status.*: better advices for git status added
Date: Sun, 03 Jun 2012 14:06:19 -0700
Message-ID: <7v7gvoyuk4.fsf@alter.siamese.dyndns.org>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 03 23:06:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbI0L-0007TT-8c
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 23:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab2FCVGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 17:06:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab2FCVGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 17:06:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7E168B41;
	Sun,  3 Jun 2012 17:06:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y2+z54NDwFLTtTapT6XdoPKnOxQ=; b=pXKsuM
	fvxrAvhH3WXzTUAOmt9cmor7xCzmkZmvPrKfipIZOsEQ72vgIGimjCoSorcql+KQ
	D1VDuEaxNqWKF9vm1Gjs7fS2BRbhM4MYyEn3o5BEXIAi66CZ0ngP6jmx+Y6Gkndd
	Pgn3B5Cw1wE552df/fC9vmT4sEMVxz38H4zEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WBCZs9eBZl1QhPLzA0CSsfH9AlgIBnRo
	e8s2jOmtgkdHY2UTyGW0++eup1DZg8UiPXduFU1ulzr9ZBiRDVTdaHqYpFIlPUdS
	q2Py84JwFA33tZhrSCnmciyP9ReJuu0Pxem2w1pZmsFV6f0L3Hxpm890XJJ5FG5H
	JYrbXlESdqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE8628B40;
	Sun,  3 Jun 2012 17:06:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F13DB8B3F; Sun,  3 Jun 2012
 17:06:20 -0400 (EDT)
In-Reply-To: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Sun, 3 Jun 2012 20:30:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8136C82-ADBF-11E1-9978-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199101>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 915cb5a..670945d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -162,6 +162,10 @@ advice.*::
>  		Directions on how to stage/unstage/add shown in the
>  		output of linkgit:git-status[1] and the template shown
>  		when writing commit messages.
> +		Show directions on how to proceed from the current
> +		state in the output of linkgit:git-status[1] and in
> +		the template shown when writing commit messages in
> +		linkgit:git-commit[1].

I meant these four lines to _replace_, not _add_.

Reading the three lines we can see in the context before this hunk,
don't you agree that they are now unnecessary because what they say
is merely a subset of the four lines you added say?

> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index b8cb490..61d1f38 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -118,4 +121,68 @@ test_expect_success 'git diff-index --cached -C shows 2 copies + 1 unmerged' '
> ...
> +test_expect_success 'status when conflicts with add and rm advice (both deleted)' '
> +	git init git &&
> +	cd git &&
> +	test_commit init main.txt init &&

Please do not chdir around outside a subshell.

"This is the last test in this script" is not an excuse, as that
will forbid others from improving the script by adding new ones
later.

> diff --git a/wt-status.c b/wt-status.c
> index dd6d8c4..2460e20 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -728,6 +729,169 @@ static void wt_status_print_tracking(struct wt_status *s)
> ...
> +static void show_merge_in_progress(struct wt_status *s,
> +				struct wt_status_state *state,
> +				const char *color)
> +{
> +	if (has_unmerged(s)) {
> +		status_printf_ln(s, color, _("You have unmerged paths."));
> +		if (advice_status_hints)
> +			status_printf_ln(s, color,
> +				_("  (fix conflicts and run \"git commit\")"));
> +	} else {
> +		status_printf_ln(s, color,
> +			_("All conflicts fixed but you are still merging."));

Thanks for rephrasing; this reads much easier.

> +static void show_am_in_progress(struct wt_status *s,
> +				struct wt_status_state *state,
> +				const char *color)
> +{
> +	status_printf_ln(s, color,
> +		_("You are in the middle of an am session."));
> +	if (state->am_empty_patch) {
> +		status_printf_ln(s, color,
> +			_("The current patch is empty; run \"git am --skip\" to skip it."));

Isn't everything after "; " an advice?

> +		if (advice_status_hints)
> +			status_printf_ln(s, color,
> +				_("  (use \"git am --abort\" to restore the original branch)"));
> +	} else if (advice_status_hints) {
> +		status_printf_ln(s, color,
> +			_("  (when you have fixed this problem run \"git am --resolved\")"));
> +		status_printf_ln(s, color,
> +			_("  (use \"git am --skip\" to skip this patch)"));
> +		status_printf_ln(s, color,
> +			_("  (use \"git am --abort\" to restore the original branch)"));
> +	}

I think the structure can simply be:

	if (am_empty_patch)
		"The current patch is empty.";
	if (advice_status_hints) {
		"  (use --abort to restore)";
		"  (use --skip to skip)";
                if (!am_empty_patch)
			"  (use --resolved after you are done)";
	}

Note that I am not suggesting to change the wording of the message
in the above; just showing the flow-structure.

Also when you are in the middle of "git am -3", there may be
unmerged entries in the index; do we want to suggest "add/rm" to
resolve to fill in the missing detail of "fix" in your "when you
have fixed this problem" message?

We may want to decide how detailed we want to make the help texts;
the same fuzziness exists in "fix conflicts and then" at the
beginning of show_rebase_in_progress().

> +static void show_rebase_in_progress(struct wt_status *s,
> +				struct wt_status_state *state,
> +				const char *color)
> +{
> +	if (has_unmerged(s)) {
> +		status_printf_ln(s, color, _("You are currently rebasing."));
> +		if (advice_status_hints) {
> +			status_printf_ln(s, color,
> +				_("  (fix conflicts and then run \"git rebase --continue\")"));

> +			status_printf_ln(s, color,
> +				_("  (use \"git rebase --skip\" to skip this patch)"));
> +			status_printf_ln(s, color,
> +				_("  (use \"git rebase --abort\" to check out the original branch)"));
> +		}
> +	} else if (state->rebase_in_progress) {
> +		status_printf_ln(s, color, _("You are currently rebasing."));
> +		if (advice_status_hints)
> +			status_printf_ln(s, color,
> +				_("  (all conflicts fixed: run \"git rebase --continue\")"));
> +	} else {
> +		status_printf_ln(s, color, _("You are currently editing a commit during a rebase."));
> +		if (advice_status_hints && !s->amend) {
> +			status_printf_ln(s, color,
> +				_("  (use \"git commit --amend\" to amend the current commit)"));
> +			status_printf_ln(s, color,
> +				_("  (use \"git rebase --continue\" once you are satisfied with your changes)"));
> +		}

This last "else" block is taken when running "rebase -i" and there
is no longer any unmerged index entry.  I wonder if the message from
the first printf_ln needs to be clarified further depending on the
context.

Specifically, in this sequence:

	- the user marked a commit as "pick";
        - replaying of that commit resulted in conflicts;
        - the user edited files and used add/rm to resolve conflicts;
        - the user did one of these:
	  1. "git status"
          2. "git commit" without "--amend"
          3. "git commit --amend"

can this message come up?

In such a case, "You are currently editing a commit" is actively
wrong.  The user has finished resolving the conflict and are about
to record the result.  Also, "git status" and "git commit" without
"--amend" are both sensible commands in this situation, but running
"git commit --amend" is likely to be a mistake, no?

	Side note: I am not absolutely sure if "--amend" is always a
	mistake in this situation; I'd very much appreciate users
	who creatively use "rebase -i" in real life to offer valid
	uses of "commit --amend" in this scenario.

> +static void show_cherry_pick_in_progress(struct wt_status *s,
> +					struct wt_status_state *state,
> +					const char *color)
> +{
> +	if (has_unmerged(s)) {
> +		status_printf_ln(s, color, _("You are currently cherry-picking."));
> +		if (advice_status_hints)
> +			status_printf_ln(s, color,
> +				_("  (fix conflicts and run \"git commit\")"));
> +	} else {
> +		status_printf_ln(s, color, _("You are currently cherry-picking."));
> +		if (advice_status_hints)
> +			status_printf_ln(s, color,
> +				_("  (all conflicts fixed: run \"git commit\")"));
> +	}

The current status is the same in either arm of if/else; shouldn't
they be lifted outside, i.e.

	"You are currently cherry-picking";
        if (advice_status_hints) {
        	if (has_unmerged(s))
			"  (fix conflicts ...)";
		else
                	"  (all fixed, run ...)";
	}

The rest of this patch I did not quote looked all very much
sensible.

Thanks.
