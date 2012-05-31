From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Thu, 31 May 2012 14:36:07 -0700
Message-ID: <7vmx4o58zc.fsf@alter.siamese.dyndns.org>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 31 23:36:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaD2Y-0003OE-30
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 23:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab2EaVgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 17:36:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab2EaVgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 17:36:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10C7188C9;
	Thu, 31 May 2012 17:36:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YYDLLNBlxZqqk32j39z3DAfHsLY=; b=BjshSF
	PmnXM4u+pEgI7B5hQn2C4GjKo9+POS3MpnaWE3NNs4I1zWE7cbfpHhnLNXm2A0i2
	dzETAgGghxtiokVtPzniJjAm7ihWlsHdznCEXNiIFaKMrwK4ZU+fJYm0cOpj6Ozw
	s5IfQdX2g+JNPuSvdjNptO77KN9v9PwyhMZ+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OcsizUjdr9lFgRMF//JnpKkfdV/Ms5kB
	WT+pNmusnvYQeoOUlWKPjk0hOzGT4OKsVDqeqF4P33sJup5UhNhU0hghR7FDskRV
	i38Kqboz2Y29E4Bj35+0vIxBmS3zyKDGZeqCXbjOxQ3Ot3YoYu7sSWzbyDOflOpv
	HjzHEhVHGic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0382988C8;
	Thu, 31 May 2012 17:36:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED33888C7; Thu, 31 May 2012
 17:36:08 -0400 (EDT)
In-Reply-To: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Kong Lucien's message of "Thu, 31 May 2012 17:15:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A28BB11A-AB68-11E1-9F9E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198949>

Kong Lucien <Lucien.Kong@ensimag.imag.fr> writes:

> This patch provides new informative help messages in the display of
> 'git status' (at the top) during conflicts, rebase, am, bisect or
> cherry-pick process.
>
> The new messages are not shown when using options such as -s or
> --porcelain. The messages about the current situation of the user are
> always displayed but the advices on what the user needs to do in order
> to resume a rebase/bisect /am/ commit after resolving conflicts can be

Is there a reason why there is a SP after bisect here?

> hidden by setting advice.statushints to 'false' in the config file.
>
> Thus, information about the updated advice.statushints key are added
> in Documentation/config.txt.
>
> Also, the test t7060-wt-status.sh is now working with the new help
> messages. Tests about suggestions of "git rm" are also added.

Looks much better and getting ready for being at least on 'pu' if
not 'next', it seems.

> Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Nguyen Huynh Khoi Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>

How is your development process work, by the way?  Does everybody on
this list have code in this patch?  Or are you just listing people
who are in the same class taught by Matthieu who reviewed and
commented on this patch?

>  Documentation/config.txt |    2 +
>  t/t7060-wtstatus.sh      |   71 +++++++++++++++++++++
>  wt-status.c              |  154 ++++++++++++++++++++++++++++++++++++++++++++++
>  wt-status.h              |   11 +++
>  4 files changed, 238 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 915cb5a..52f5009 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -162,6 +162,8 @@ advice.*::
>  		Directions on how to stage/unstage/add shown in the
>  		output of linkgit:git-status[1] and the template shown
>  		when writing commit messages.
> +		Directions on how to end the current process shown
> +		in the output of linkgit:git-status[1].

I kind of find this hard to read.  Perhaps it shouldn't be a
separate sentence, but instead should just enhance the existing
limited "stage/unstage/add" set?  The list of updated, modified and
untracked paths with instructions given by the current code is an
incomplete description of the current state, and I view this patch
as filling the missing bits to it to make the output more complete.

So from that point of view, perhaps more like this?

-	Directions on how to stage/unstage/add shown in the
-	output of linkgit:git-status[1] and the template shown
-	when writing commit messages.
+	Show directions on how to proceed from the current state
+	in the output of linkgit:git-status[1] and in the template
+	shown when writing commit messages in linkgit:git-commit[1].

> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index b8cb490..8a6d68a 100755
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
> @@ -118,4 +120,73 @@ test_expect_success 'git diff-index --cached -C shows 2 copies + 1 unmerged' '
>  	test_cmp expected actual
>  '

Note what filenames are used to store the expected output and grab
the actual output out of the command.

> +
> +test_expect_success 'status when conflicts with add and rm advice (deleted by them)' '
> +	git init git &&
> +	cd git &&
> +	test_when_finished "cd ../ && rm -rf git" &&

This is a tangent, but this sequence is wrong.  If "git init"
succeeds but "cd git" fails for some reason, you wouldn't clean the
new test repository, and worse, you go up and try to remove a random
"git" that is different from what you created here.

Perhaps I am being a bit superstitous, but I would feel a lot safer
to see if this were written like this:

        git init git &&
        (
		cd git &&
                ... the rest of this test ...
	) &&
        rm -fr git

to avoid mistakes.  For example, if you add any "cd somewhere-else"
in the remainder of the test, your test_when_finished to go to a
relative "cd ../" wouldn't do you any good.

> +	test_commit init main.txt init &&
> +	git checkout -b second_branch &&
> +	git rm main.txt &&
> +	git commit -m "main.txt deleted on second_branch" &&
> +	test_commit second conflict.txt second &&
> +	git checkout master &&
> +	test_commit on_second main.txt on_second &&
> +	test_commit master conflict.txt master &&
> +	test_must_fail git merge second_branch &&
> +	cat >expect <<-\EOF &&
> +	# On branch master
> +	# You have unmerged paths; fix conflicts and run "git commit".
> +	#
> +	# Unmerged paths:
> +	#   (use "git add/rm <file>..." as appropriate to mark resolution)
> +	#
> +	#	both added:         conflict.txt
> +	#	deleted by them:    main.txt
> +	#
> +	# Untracked files:
> +	#   (use "git add <file>..." to include in what will be committed)
> +	#
> +	#	expect
> +	#	output
> +	no changes added to commit (use "git add" and/or "git commit -a")
> +	EOF
> +	git status >output &&
> +	test_cmp expect output
> +'

And rename "output" to "actual" to match the existing practice
(unless there is a compelling reason not to).

> diff --git a/wt-status.c b/wt-status.c
> index dd6d8c4..f4ba021 100644
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
> @@ -728,6 +729,158 @@ static void wt_status_print_tracking(struct wt_status *s)
>  	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
>  }
>  
> +static int has_unmerged(struct wt_status *s)
> +{
> +	int i;
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		d = s->change.items[i].util;
> +		if (d->stagemask)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static void merge_in_progress_show(struct wt_status *s,
> +				struct wt_status_state *state,
> +				const char *color)

Minor nit: perhaps "show-merge-in-progress" would read more
naturally (same for all other helpers).

> +{
> +	if (has_unmerged(s))
> +		status_printf_ln(s, color, _("You have unmerged paths%s"),
> +			advice_status_hints
> +			? _("; fix conflicts and run \"git commit\".") : ".");
> +	else
> +		status_printf_ln(s, color, _("You are still merging%s"),
> +			advice_status_hints
> +			? _(", run \"git commit\" to conclude merge.") : ".");

The former uses ';' while the latter uses ','.  There is a use of
':' in the rebase-in-progress helper.  Be consistent (if I were
writing this code, I would pick ';').

Would this qualify as a "language lego" i18n/l10n people loathe?
IOW would it be better to have four independent messages?

        "You have unmerged paths."
        "You are still merging."
        "You have unmerged paths; fix conflicts and..."
	"You are still merging; fun \"git commit\" to conclude..."

This is not a rhetorical question.  There is the same issue in the
rebase-in-progress helper.

> +static void am_in_progress_show(struct wt_status *s,
> +				struct wt_status_state *state,
> +				const char *color)
> +{
> +	status_printf_ln(s, color,
> +		_("You are in the middle of an am session:"));
> +	if (state->am_empty_patch)
> +		status_printf_ln(s, color,
> +			_("The current patch is empty!"));

This situation may deserve a "; run 'am --skip' to skip it." advice.

> +static void rebase_in_progress_show(struct wt_status *s,
> +				struct wt_status_state *state,
> +				const char *color)
> +{
> +	if (has_unmerged(s)) {
> +		status_printf_ln(s, color, _("You are currently rebasing%s"),
> +			advice_status_hints
> +			? _(": fix conflicts and then run \"git rebase --continue\".") : ".");
> +		if (advice_status_hints) {
> +			status_printf_ln(s, color,
> +				_("  If you would prefer to skip this patch, instead run \"git rebase --skip\"."));
> +			status_printf_ln(s, color,
> +				_("  To check out  the original branch and stop rebasing run \"git rebase --abort\"."));

Double-space in the middle intended?

This line looks overly long.  Does it fit (with the # prefix) on
typical 80-column terminals?

> +		}
> +	} else if (state->rebase_in_progress) {
> +		status_printf_ln(s, color, _("You are currently rebasing%s"),
> +			advice_status_hints
> +			? _(": all conflicts fixed: run \"git rebase --continue\".") : ".");

The above will show this:

# You are currently rebasing: all conflicts fixed: run "git rebase --continue.

That's 78 cols, which is pushing the right edge too closely,
especially considering that translations tend to make messages
longer.

Aside from questionable use of ':' (I think ';' is better for the
first one, and '.' is better for the latter; and s/run/Run/ to begin
a new sentence), I think this is nicer than the merge-in-progress
message after the user has already marked all paths resolved, which
says "You are still merging" without saying "you have resolved
everything".  Perhaps you meant to hint that by saying "still" (as
opposed to "currently"), but the distinction feels a bit too subtle.


> +	} else {
> +		status_printf_ln(s, color, _("You are currently editing a commit during a rebase."));
> +		if (advice_status_hints) {
> +			status_printf_ln(s, color, _("  You can amend the commit with"));
> +			status_printf_ln(s, color, _("	git commit --amend"));
> +			status_printf_ln(s, color, _("  Once you are satisfied with your changes, run"));
> +			status_printf_ln(s, color, _("	git rebase --continue"));

For an advice in "git status" output, the above may be appropriate,
but would the user see this in "git commit" template, and if so,
isn't it because the user typed "git commit --amend"?  Does it make
sense to suggest to run "git commit --amend" in that context?

The same comment applies to all new advice messages added by this
patch.

Thanks.
