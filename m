From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] wt-status.*: better advices for git status added
Date: Tue, 29 May 2012 12:22:56 -0700
Message-ID: <7v4nqy4wrz.fsf@alter.siamese.dyndns.org>
References: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue May 29 21:23:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZS0Y-0001Zj-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 21:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab2E2TXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 15:23:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab2E2TW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 15:22:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 209788C71;
	Tue, 29 May 2012 15:22:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mCSr0XYbEmtOdHzRD12A3h2P1R4=; b=fjH/ds
	GgWHWj01CCrYsMRM2szlGsl9jSGwoJtfwDQBTNKutDnGOotNmija0ZGCFvcq1aKV
	uS4GNZ9BE7rZCHkz6QOwjJX0/AzgT22t0eW8r1YjrMYSILPvjd9hbb0fKdG6ZvBm
	B+VcECM2v6383CLcR0GZaAucsN3eaLcQF5oQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X5i62XHkSeAM02/5g8RTATf1w7NhPyaT
	l06juJR+0mHWedkVgENhegao8v9AUHdn7xxIdU1HGwBC5qDihSgxR4bSfISAE5fj
	CMg2CBkzX9kZC/06cnf0Ai4V0Niofv7qxU90PEKRHkE088gEXf+qLAg8a9N5sHsE
	lDL+qBuvnD4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D4C8C70;
	Tue, 29 May 2012 15:22:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CEC88C6E; Tue, 29 May 2012
 15:22:58 -0400 (EDT)
In-Reply-To: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Mon, 28 May 2012 19:36:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2E50E7C-A9C3-11E1-865E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198754>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> This patch provides new warning messages in the display of
> 'git status' (at the top) during conflicts, rebase, am
> and bisect process. These messages can be shortened by setting
> the new advice.* config key called advice.statushelp to false.
>
> Thus, information about the new advice.* key are added in
> Documentation/config.txt
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
> The new messages are not shown when using options such as
> -s or --porcelain.It figures the current state by finding 
> the files generated in .git in each case (during an am, 
> a rebase, a bisect etc.). The messages about the current
> situation of the user are always displayed but the advices 
> on what the user needs to do in order to resume a rebase/bisect
> /am/ commit after resolving conflicts can be hidden by setting advice.statushelp to 'false' in the config file.

Don't some of the above explanatory sentences deserve to be in the
commit log message proper, not hidden behind the three-dash lines?


>  Documentation/config.txt |    4 ++
>  advice.c                 |    2 +
>  advice.h                 |    1 +
>  t/t7060-wtstatus.sh      |    2 +
>  wt-status.c              |  106 ++++++++++++++++++++++++++++++++++++++++++++++
>  wt-status.h              |    1 +
>  6 files changed, 116 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 915cb5a..6504371 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -176,6 +176,10 @@ advice.*::
>  		Advice shown when you used linkgit:git-checkout[1] to
>  		move to the detach HEAD state, to instruct how to create
>  		a local branch after the fact.
> +	statusHelp::
> +		Directions on how to end the current process shown
> +		in the output of linkgit:git-status[1].
> +
>  --

Have you read the existing entries in the same section you are
touching to see if the patch result as a whole makes sense and the
new entry fits well in the context?

It strikes me odd that this is not listed next to statusHints, and
it also makes me wonder if we even need to invent a new one, or it
is better to just make the output more verbose when statusHints is
not being declined.

> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index b8cb490..d9a1e18 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -30,6 +30,8 @@ test_expect_success 'Report new path with conflict' '
>  
>  cat >expect <<EOF
>  # On branch side
> +# You have unmerged paths: fix conflicts and then commit the result.
> +#
>  # Unmerged paths:
>  #   (use "git add/rm <file>..." as appropriate to mark resolution)
>  #
> diff --git a/wt-status.c b/wt-status.c
> index dd6d8c4..093a352 100644
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
> @@ -728,6 +729,109 @@ static void wt_status_print_tracking(struct wt_status *s)
>  	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
>  }
>  
> +static void wt_status_print_in_progress(struct wt_status *s)
> +{
> +	int i;
> +	const char *c = color(WT_STATUS_IN_PROGRESS, s);
> +	struct stat st;

> +	int merge_in_progress = 0;
> +	int rebase_state = 0;
> +	int rebase_interactive_state = 0;
> +	int am_state = 0;
> +	int am_wrong_format_state = 0;
> +	int bisect_state = 0;

merge_in_progress is very descriptive, but compared to that, none of
the foo_state is.

> +	int unmerged_present = 0;



> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		d = s->change.items[i].util;
> +		if (d->stagemask) {
> +			unmerged_present = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!stat(git_path("MERGE_HEAD"), &st))
> +		merge_in_progress = 1;
> +	else {
> +		if (!stat(git_path("rebase-apply"), &st)) {
> +			if (!stat(git_path("rebase-apply/applying"), &st))
> +				am_state = 1;
> +				if (!stat(git_path("rebase-apply/patch"), &st) && !(st.st_size))
> +					am_wrong_format_state = 1;

Isn't nesting screwed-up around here?  Your indentation suggests you
need opening "{" after "if (applying)" and closing "}" before "else"
on the next line.

> +			else
> +				rebase_state = 1;
> +		}
> +		else {
> +			if (!stat(git_path("rebase-merge"), &st)) {
> +				if (!stat(git_path("rebase-merge/interactive"), &st))
> +					rebase_interactive_state = 1;
> +				else
> +					rebase_state = 1;
> +			}
> +		}
> +	}

Whenever you write "else {" that is immediately followed by "if",
re-read what you wrote and think if you can make it "else if () {"
to reduce the indentation level.  If you still need five levels of
indentation, the function you are writing is too complex and is a
sign that you can use a helper function.

In this case, I think you could structure it like this:

	if (merge_head) {
        	merge_in_progress++;
	} else if (rebase-apply) {
		if (applying) {
			am_in_progress++;
                        if (patch is empty)
                                ...
		} else {			
			rebase_in_progress++;
		}
	} else if (rebase-merge) {
		if (interactive)
			rebase_i_in_progress++;
		else
			rebase_in_progress++;
	}


> +	if (!stat(git_path("BISECT_LOG"), &st))
> +		bisect_state = 1;
> +
> +	if(merge_in_progress) {

s/if/if /;  Didn't I say this already in my previous message?

> +		if (unmerged_present)
> +			status_printf_ln(s, c, _("You have unmerged paths: fix conflicts and then commit the result."));
> +		else
> +			status_printf_ln(s, c, _("You are still merging, run \"git commit\" to conclude merge."));
> +		wt_status_print_trailer(s);
> +	}
> +	else {
> +		if(am_state) {

The same comments on the "else if" cascading and on the missing SP
after keyword apply here.

> +			status_printf_ln(s, c, _("You are currently in am progress:"));

-ECANTPARSE.

> +			if(am_wrong_format_state)
> +				status_printf_ln(s, c, _("One of the patches is empty or corrupted !"));

You never checked corrupted; you only detected an empty file.

> +			if (advice_status_help) {
> +				status_printf_ln(s, c, _("When you have resolved this problem run \"git am --resolved\"."));
> +				status_printf_ln(s, c, _("If you would prefer to skip this patch, instead run \"git am --skip\"."));
> +				status_printf_ln(s, c, _("To restore the original branch and stop patching run \"git am --abort\"."));
> +			}
> +			wt_status_print_trailer(s);
> +		}
> +
> +		else if (rebase_state || rebase_interactive_state) {
> +			if (unmerged_present) {
> +				status_printf_ln(s, c, _("You are currently rebasing%s"),
> +				advice_status_help
> +				? _(": fix conflicts and then run \"git rebase -- continue\".") : ".");

s/-- /--/;

> +				if (advice_status_help) {
> +					status_printf_ln(s, c, _("If you would prefer to skip this patch, instead run \"git rebase --skip\"."));
> +					status_printf_ln(s, c, _("To check out  the original branch and stop rebasing run \"git rebase --abort\"."));
> +				}
> +			}
> +			else {
> +				if (rebase_state)
> +					status_printf_ln(s, c, _("You are currently rebasing: all conflicts fixed%s"),
> +					advice_status_help
> +					? _(": run \"git rebase --continue\".") : ".");
> +				else {
> +					status_printf_ln(s, c, _("You are currently editing a commit during a rebase."));
> +					if (advice_status_help) {
> +						status_printf_ln(s, c, _("You can amend the commit with"));
> +						status_printf_ln(s, c, _("	git commit --amend"));
> +						status_printf_ln(s, c, _("Once you are satisfied with your changes, run"));
> +						status_printf_ln(s, c, _("	git rebase --continue"));
> +					}
> +				}
> +			}
> +			wt_status_print_trailer(s);
> +		}
> +	}
> +
> +	if(bisect_state) {
> +		status_printf_ln(s, c, _("You are currently bisecting."));
> +		if (advice_status_help)
> +		status_printf_ln(s, c, _("To get back to the original branch run \"git bisect reset\""));
> +		wt_status_print_trailer(s);
> +	}
> +}
> +
>  void wt_status_print(struct wt_status *s)
>  {
>  	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
> @@ -750,6 +854,8 @@ void wt_status_print(struct wt_status *s)
>  			wt_status_print_tracking(s);
>  	}
>  
> +	wt_status_print_in_progress(s);
> +
>  	if (s->is_initial) {
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
> diff --git a/wt-status.h b/wt-status.h
> index 14aa9f7..0556669 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -15,6 +15,7 @@ enum color_wt_status {
>  	WT_STATUS_LOCAL_BRANCH,
>  	WT_STATUS_REMOTE_BRANCH,
>  	WT_STATUS_ONBRANCH,
> +	WT_STATUS_IN_PROGRESS,
>  	WT_STATUS_MAXSLOT
>  };
