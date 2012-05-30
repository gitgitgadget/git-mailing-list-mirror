From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/3] wt-status.*: better advices for git status added
Date: Wed, 30 May 2012 11:26:25 -0700
Message-ID: <7vmx4pzfse.fsf@alter.siamese.dyndns.org>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed May 30 20:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZnbP-0005UG-4j
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 20:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280Ab2E3S03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 14:26:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755949Ab2E3S02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 14:26:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F14D8DA1;
	Wed, 30 May 2012 14:26:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+uPA1VFrjLZsqeb+DEZQYNAKI1c=; b=k2rIX0
	OlhslaeTfZBN7mOrzoSms4iOyKy8WZeDxqPHlX/LG3oZIDtP8nYI3YK9KtWAPuYV
	KgJ7DnPBLt1KwMa6VxTbBNNMZ1/y0MVco0bG5kfn0CZcYubqxiN2xS5Wd415Vp8k
	9I6FVdKbYH5XVTLjR2jc8Og40EysYu4TINlXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rOTD9awjmU/sJ8lmvpEwWxdeobGl9M17
	ZcQ/GOw/iD01za8SN2xPBGQTqnr0eAiuH8IL3TCD3SLZFHcC9fhKjqGugUQNdNzZ
	CLkgmRwquiu/6k3xzkqzsHTCyvazpwzUQ0zxh0VsA988PwokuLEGYbw+zbEVHOge
	4Nl/qO9YjrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64CA58DA0;
	Wed, 30 May 2012 14:26:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8972C8D9F; Wed, 30 May 2012
 14:26:26 -0400 (EDT)
In-Reply-To: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Wed, 30 May 2012 15:23:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7B30F4C-AA84-11E1-8E39-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198829>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> This patch provides new warning messages in the display of
> 'git status' (at the top) during conflicts, rebase, am,
> bisect or cherry-pick process.

I hate to see these called "warnings", as there is nothing for the
end user to be alarmed about.  The user wanted to know what status
the working tree is in, and we are reporting what the user wanted to
know.  They are informative help messages.

> The new messages are not shown when using options such as
> -s or --porcelain.The messages about the current
> situation of the user are always displayed but the advices
> on what the user needs to do in order to resume a rebase/bisect
> /am/ commit after resolving conflicts can be hidden by setting
> advice.statushelp to 'false' in the config file.

Notice the spaces are sprinkled in the above paragraph in a funny
way?  You might want to get in the habit of proofreading what you
wrote before sending.

> Thus, information about the new advice.* key are added in
> Documentation/config.txt.
>
> Also, the test t7060-wt-status.sh is now working with the
> new warning messages.
>
> Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Nguyen Huynh Khoi Nguyen Lucien <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> ---
> The code figures the current state by finding the files generated
> in .git in each cases (during an am, a rebase, a bisect, etc.).
>
> The function wt_status_print_in_progress is now splitted into
> several smaller functions in order to avoid too many indentations.
>
>  Documentation/config.txt |    4 +
>  advice.c                 |    2 +
>  advice.h                 |    1 +
>  t/t7060-wtstatus.sh      |    2 +
>  wt-status.c              |  161 ++++++++++++++++++++++++++++++++++++++++++++++
>  wt-status.h              |   11 +++
>  6 files changed, 181 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 915cb5a..ab1c455 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -162,6 +162,9 @@ advice.*::
>  		Directions on how to stage/unstage/add shown in the
>  		output of linkgit:git-status[1] and the template shown
>  		when writing commit messages.
> +	statusHelp::
> +		Directions on how to end the current process shown
> +		in the output of linkgit:git-status[1].
>  	commitBeforeMerge::
>  		Advice shown when linkgit:git-merge[1] refuses to
>  		merge to avoid overwriting local changes.
> @@ -176,6 +179,7 @@ advice.*::
>  		Advice shown when you used linkgit:git-checkout[1] to
>  		move to the detach HEAD state, to instruct how to create
>  		a local branch after the fact.
> +
>  --
>  
>  core.fileMode::
> diff --git a/advice.c b/advice.c
> index a492eea..31deb31 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -9,6 +9,7 @@ int advice_commit_before_merge = 1;
>  int advice_resolve_conflict = 1;
>  int advice_implicit_identity = 1;
>  int advice_detached_head = 1;
> +int advice_status_help = 1;
>  
>  static struct {
>  	const char *name;
> @@ -23,6 +24,7 @@ static struct {
>  	{ "resolveconflict", &advice_resolve_conflict },
>  	{ "implicitidentity", &advice_implicit_identity },
>  	{ "detachedhead", &advice_detached_head },
> +	{ "statushelp", &advice_status_help },
>  };
>  
>  void advise(const char *advice, ...)
> diff --git a/advice.h b/advice.h
> index f3cdbbf..5fd3cce 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -12,6 +12,7 @@ extern int advice_commit_before_merge;
>  extern int advice_resolve_conflict;
>  extern int advice_implicit_identity;
>  extern int advice_detached_head;
> +extern int advice_status_help;
>  
>  int git_default_advice_config(const char *var, const char *value);
>  void advise(const char *advice, ...);
> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index b8cb490..d0fbcc7 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -30,6 +30,8 @@ test_expect_success 'Report new path with conflict' '
>  
>  cat >expect <<EOF
>  # On branch side
> +# You have unmerged paths; fix conflicts and run "git commit".
> +#
>  # Unmerged paths:
>  #   (use "git add/rm <file>..." as appropriate to mark resolution)
>  #
> diff --git a/wt-status.c b/wt-status.c
> index dd6d8c4..4dd294f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -23,6 +23,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
>  	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
>  	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
> +	GIT_COLOR_NORMAL, /* WT_STATUS_IN_PROGRESS */
>  };
>  
>  static const char *color(int slot, struct wt_status *s)
> @@ -728,10 +729,149 @@ static void wt_status_print_tracking(struct wt_status *s)
>  	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
>  }
>  
> +static int wt_status_unmerged_present (struct wt_status *s)

Please drop needless extra SP between function name and its
parameter list (I won't repeat this but the same breakage is
everywhere in this patch).

Is it worth giving this file-local helper function a long name like
that?  A short-and-sweet has_unmerged() would work just as well and
probably easier to read.

> +{
> +	int i;
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		d = s->change.items[i].util;
> +		if (d->stagemask) {
> +			return 1;
> +		}

Please drop needless {} around a single statement block (I won't
repeat this but the same breakage is everywhere in this patch).

> +	}
> +	return 0;
> +}
> +
> +static void wt_status_evaluate_state (struct wt_status_state *state)
> +{
> +	struct stat st;
> +
> +	state->merge_in_progress = 0;
> +	state->am_in_progress = 0;
> +	state->am_empty_patch = 0;
> +	state->rebase_in_progress = 0;
> +	state->rebase_interactive_in_progress = 0;
> +	state->cherry_pick_in_progress = 0;
> +	state->bisect_in_progress = 0;
> +
> +	if (!stat(git_path("MERGE_HEAD"), &st))
> +		state->merge_in_progress = 1;
> +	else if (!stat(git_path("rebase-apply"), &st)) {
> +		if (!stat(git_path("rebase-apply/applying"), &st)) {
> +			state->am_in_progress = 1;
> +			if (!stat(git_path("rebase-apply/patch"), &st) && !(st.st_size))

Please drop needless () around st.st_size.

> +				state->am_empty_patch = 1;
> +		}
> +		else
> +			state->rebase_in_progress = 1;

Two points on style (also appear elsewhere in this patch):

	if (!"applying") {
 		...
	} else {
		state->rebase_in_progress = 1;
	}

 - "else" comes on the same line as closing "}" of its "if" block;

 - if one of if/else if/else chain has multiple statement block, use {}
   even for a single statement block in the chain.

> +	}
> +	else if (!stat(git_path("rebase-merge"), &st)) {
> +		if (!stat(git_path("rebase-merge/interactive"), &st))
> +			state->rebase_interactive_in_progress = 1;
> +		else
> +			state->rebase_in_progress = 1;
> +	}
> +	else if (!stat(git_path("CHERRY_PICK_HEAD"), &st))
> +		state->cherry_pick_in_progress = 1;
> +	if (!stat(git_path("BISECT_LOG"), &st))
> +		state->bisect_in_progress = 1;
> +}
> +
> +static void wt_status_merge_in_progress (struct wt_status *s,
> +					struct wt_status_state *state,
> +					const char *color)

The earlier "evaluate-state" was a well-named function, but this is
not. "merge_in_progress" what? It is not about asking "is a merge in
progress?", but is about showing message when it is the case.
Please have "print" or "show" or something that tells what it _does_
somewhere in its name (same applies to other functions in this patch).

> +{
> +	if (wt_status_unmerged_present(s))
> +		status_printf_ln(s, color,
> +			_("You have unmerged paths; fix conflicts and run \"git commit\"."));
> +	else
> +		status_printf_ln(s, color,
> +			_("You are still merging, run \"git commit\" to conclude merge."));
> +	wt_status_print_trailer(s);
> +}
> +
> +static void wt_status_am_in_progress (struct wt_status *s,
> +				struct wt_status_state *state,
> +				const char *color)
> +{
> +	status_printf_ln(s, color,
> +		_("You are currently in am progress:"));

Is it just me, or is the above -ECANTPARSE?  "You are currently in
commit/merge/meal/commute progress?"

Perhaps	"You are in the middle of an am session" or something?

> +	if (state->am_empty_patch)
> +		status_printf_ln(s, color,
> +			_("One of the patches is empty!"));

Can we state this better?  It is not like you have 4 patches, you
are processing its third one, and you found that the first patch you
have already skipped was empty and keep nagging the user about "one
of them" being empty.  As far as I can tell, you observed that
"current one" that is being processed is empty in evaluate-state, so
I think it makes more sense to tell the user the current one is
empty instead of being vague like the above.

> +	if (advice_status_help) {
> +		status_printf_ln(s, color,
> +			_("  When you have resolved this problem run \"git am --resolved\"."));
> +		status_printf_ln(s, color,
> +			_("  If you would prefer to skip this patch, instead run \"git am --skip\"."));
> +		status_printf_ln(s, color,
> +			_("  To restore the original branch and stop patching run \"git am --abort\"."));
> +	}

I doubt it makes much sense to hide only these messages behind "if
(advice_status_help)".  Look at how you give your "what to do"
advices in wt-status-merge-in-progress function.

Probably it is a good idea to show this unconditionally *if* the
caller decides to call this function, and other "print/show" kind of
functions, this patch adds.


> +	wt_status_print_trailer(s);
> +}
> +
> +static void wt_status_rebase_in_progress (struct wt_status *s,
> +					struct wt_status_state *state,
> +					const char *color)
> +{
> +	if (wt_status_unmerged_present(s)) {
> +		status_printf_ln(s, color, _("You are currently rebasing%s"),
> +			advice_status_help
> +			? _(": fix conflicts and then run \"git rebase --continue\".") : ".");

Likewise.

> +		if (advice_status_help) {
> +			status_printf_ln(s, color,
> +				_("  If you would prefer to skip this patch, instead run \"git rebase --skip\"."));
> +			status_printf_ln(s, color,
> +				_("  To check out  the original branch and stop rebasing run \"git rebase --abort\"."));
> +		}
> +	}
> +	else if (state->rebase_in_progress)
> +		status_printf_ln(s, color, _("You are currently rebasing: all conflicts fixed%s"),
> +			advice_status_help
> +			? _(": run \"git rebase --continue\".") : ".");
> +	else {
> +		status_printf_ln(s, color, _("You are currently editing a commit during a rebase."));
> +		if (advice_status_help) {
> +			status_printf_ln(s, color, _("  You can amend the commit with"));
> +			status_printf_ln(s, color, _("	git commit --amend"));
> +			status_printf_ln(s, color, _("  Once you are satisfied with your changes, run"));
> +			status_printf_ln(s, color, _("	git rebase --continue"));
> +		}
> +	}
> +	wt_status_print_trailer(s);
> +}
> +
> +static void wt_status_cherry_pick_in_progress (struct wt_status *s,
> +					struct wt_status_state *state,
> +					const char *color)
> +{
> +	if (wt_status_unmerged_present(s))
> +		status_printf_ln(s, color,
> +			_("You are currently cherry-picking: fix conflicts and run \"git commit\"."));
> +	else
> +		status_printf_ln(s, color,
> +			_("You are currently cherry-picking: all conflicts fixed: run \"git commit\"."));
> +	wt_status_print_trailer(s);
> +}
> +
> +static void wt_status_bisect_in_progress (struct wt_status *s,
> +					struct wt_status_state *state,
> +					const char *color)
> +{
> +	status_printf_ln(s, color, _("You are currently bisecting."));
> +	if (advice_status_help)
> +		status_printf_ln(s, color,
> +			_("  To get back to the original branch run \"git bisect reset\""));
> +	wt_status_print_trailer(s);
> +}
> +
>  void wt_status_print(struct wt_status *s)
>  {
>  	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
>  	const char *branch_status_color = color(WT_STATUS_HEADER, s);
> +	const char *state_color = color(WT_STATUS_IN_PROGRESS, s);
> +	struct wt_status_state *state = calloc(1, sizeof(*state));
>  
>  	if (s->branch) {
>  		const char *on_what = _("On branch ");
> @@ -750,6 +890,27 @@ void wt_status_print(struct wt_status *s)
>  			wt_status_print_tracking(s);
>  	}
>  
> +	wt_status_evaluate_state(state);
> +
> +	if (state->merge_in_progress) {
> +		wt_status_merge_in_progress(s, state, state_color);
> +	}
> +	else if (state->am_in_progress) {
> +		wt_status_am_in_progress(s, state, state_color);
> +	}
> +
> +	else if (state->rebase_in_progress || state->rebase_interactive_in_progress) {
> +		wt_status_rebase_in_progress(s, state, state_color);
> +	}
> +
> +	else if (state->cherry_pick_in_progress) {
> +		wt_status_cherry_pick_in_progress(s, state, state_color);
> +	}
> +
> +	if (state->bisect_in_progress) {
> +		wt_status_bisect_in_progress(s, state, state_color);
> +	}
> +

And instead, hide the above new lines behind advice.statusHints,
without introducing advice.statusHelp.  As to the global code
structure, it probably would make more sense to:

  - rename wt_status_evaluate_state() to wt_status_print_state();

  - rename the various "print help information for this state" functions
    that are called in the above if/else/... cascade to merge_in_progress_show()
    etc.

  - move the above if/else/... cascade to the end of
    wt_status_print_state(), which would make the above part more
    like:

	 wt_status_print()
         {
		if (s->branch) {
                	...
		}
	+	wt_status_print_state(s);
		if (s->is_initial) {
			...

  - at the beginning of wt_status_print_state(), check advice.statusHints
    and return without doing anything if the user does not want hints.

Otherwise, overall the patch is getting better looking.

Thanks for a pleasant read.

>  	if (s->is_initial) {
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
> diff --git a/wt-status.h b/wt-status.h
> index 14aa9f7..c1066a0 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -15,6 +15,7 @@ enum color_wt_status {
>  	WT_STATUS_LOCAL_BRANCH,
>  	WT_STATUS_REMOTE_BRANCH,
>  	WT_STATUS_ONBRANCH,
> +	WT_STATUS_IN_PROGRESS,
>  	WT_STATUS_MAXSLOT
>  };
>  
> @@ -71,6 +72,16 @@ struct wt_status {
>  	struct string_list ignored;
>  };
>  
> +struct wt_status_state {
> +	int merge_in_progress;
> +	int am_in_progress;
> +	int am_empty_patch;
> +	int rebase_in_progress;
> +	int rebase_interactive_in_progress;
> +	int cherry_pick_in_progress;
> +	int bisect_in_progress;
> +};
> +
>  void wt_status_prepare(struct wt_status *s);
>  void wt_status_print(struct wt_status *s);
>  void wt_status_collect(struct wt_status *s);
