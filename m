Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16730EF94
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346825; cv=none; b=pw+2XfY4IVwHFyVm9+D/FuVC1U9+jWr9CsZDJPwHXwPVyp5daOnk9s3xN9NTV2TPmKtNK0c4mYwmPTc5a1xwRgkoCm4shyph/f93OrGDrZoLmaN0wWW3SJOIuo6tWUH4a7p0YgH2kC5jl2aO3WQqj2JOn8VdT8Q+4pzPNPmo7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346825; c=relaxed/simple;
	bh=t+ScLtgSS4CHSsyBcwPsY2FZHhHap6yKImLEIrPoVUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wqs/4SU7AefDPfUVKKSw7OLuPud1RcoPhkFPtyrVdwfJt3xQf1p4zyQ4UrZm1wXyjQ81ATbfFelMKdTFbmLUiCG8jtQUSeLwr8cPJfBUZf1mILGzYwYsHao0TwYP5jfmp2Waul3jYP6wh1jPgjsVRLGZaCc8u8S5EXlm5MYIPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szi0MVYY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szi0MVYY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b7612475so28743595e9.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783346821; x=1783951621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t3BxDlSYmtgLJdkyDo2yD7RQRWVKsH7UD8S7cOCvfLA=;
        b=szi0MVYYlUWBvxTVSMsy0+/C7pfRWD4xc45aG5ata7qPXbWDEj2oWkVTKgcrmdu7iE
         F1JDG1RJBobCAqvPUoWxU4FOGUxPrk8c2wSvGrdnx0vjGkJR80Pbmxzd3UwTUZYbpVYt
         ZmbV+zT+6Kr/SqimgExhAd4z0YYV1GnfduZ0b8HZmc8+IWc/77GLPxsDNHatfRmNkhPE
         L4cf3knZ0B+PSLuYgDpKXQvphNEMGxpMDNmCrzr5GTxS0zvh4ID3ime+vMncdShGXzdF
         5xdLtflm4+GkRjoCktTRJzKrvWS4ztJehz/3g99lN4WsWDl4H385U9M8BDIQQwm8zPXe
         yC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346821; x=1783951621;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3BxDlSYmtgLJdkyDo2yD7RQRWVKsH7UD8S7cOCvfLA=;
        b=EhKHue7FZhT5Ag+xUlq/w4HRSSsv+4xZfpU9ORdD2Lbuea9OpKIFJj9WWdXEBePqLG
         jg5CjkYuPVrnLRGv+UfC31j2KO6B92p8+3WZg8M5qUGVpQscRjSl/xZ2yrDQOoHgz6Of
         AcHO6d8HpQAady9oakYmP46AjOf1XZq+PgVrmu7ZgGNcGIaV/TneCfBkoMkG7WmStBNz
         Z5h4x3iRTapAO1DsYSkaaSWxqukLNimRRuS5nFNRmLfiklrGuWR5frZgTDKbWm/d/cck
         kG9tObU+28LItSgEXlDYbPCI1E6rkJwpjNwb1WAyH8IKpr07bAysWNztgkcFM7BtDO8u
         3i5w==
X-Forwarded-Encrypted: i=1; AHgh+RpY6VpA3q4V+ammoyuBpI+7roTxIUYfXye7zifSAWDQH0DhIVn2ZBDm84ys/LvjuvvnqMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHtIKms85qhsroGH5WYVWtTsv4uX4X6Xaq5/yafym+0FIsaEBj
	WPDt4JOb6aJ/7411RuaodVCead21N33qnJ/UjAo6pZyX6iTqbkSDjnpr
X-Gm-Gg: AfdE7cnhNaeD5OS+JDinCXgd0CHu1k0ZjVNS7L7NX2VaVSskPy7sKWDKtv0UQhMzIvC
	qjpOYJKNfgI2F36zoU6e2KR3uUNRY8fKdWrkH5PyNOiVklvDjMTTMTow8+zkmo/hYYY7zrfcLLK
	Kq++rIm8vt8WGmTdlGli9EmU9q+/6xBHevlP/Q4gs890tznDBYXJXlls/PtE0JP3f2Ozb7Tby0R
	r9EgBpphpHus6NDXkVbOOgM/WcZqSGqSWuU2Y6iUuf2t67DyYp7ExmMXcicJyQmN7LiqDMd0OXc
	vfCwEIQLeyMJ0hZKx7CTtipbBLPxgeUPH4m4nFLFKWxUOUGn2crF+kIpDN1bnC/asxYTvRyx/DQ
	PNrk9OYM+H576St92UTDF/yXQXjBehzKNpUZgQov1ijcT+v8jjbGNUP2FHmfOpbI2HzeukLYtEO
	jt6sgJTYXIPfNpT9b2n+7YwVNiEb7nvbLYLKcKXVG2gTsHaEYeSo9xznLnaBUTH8UkYWQ=
X-Received: by 2002:a05:600c:e549:10b0:493:cbdc:7cd6 with SMTP id 5b1f17b1804b1-493df0b6aa6mr5424035e9.7.1783346821089;
        Mon, 06 Jul 2026 07:07:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm635882505e9.0.2026.07.06.07.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 07:07:00 -0700 (PDT)
Message-ID: <5a5dbfae-4525-4b00-9e44-936be606ee85@gmail.com>
Date: Mon, 6 Jul 2026 15:06:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 0/5] history: add squash subcommand to fold a range
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Matt Hunter <m@lfurio.us>
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
 <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 06/07/2026 09:50, Harald Nordgren via GitGitGadget wrote:
> Adds git history squash <revision-range> to fold a range of commits.
> 
> Changes in v7:
> 
>   * --reedit-message

There was some discussion [1] about making that the default and renaming 
it - was that overlooked? If not it would be helpful to comment on those 
discussions to explain why you don't think it is a good idea.

>     now builds the same editor template git rebase -i shows
>     for a squash (a combination of N commits banner with each folded message
>     under its own header) and follows autosquash for markers: a fixup!
>     message falls out (commented under a will be skipped header), while a
>     squash! or amend! keeps its body with only the marker subject commented
>     so its remark can be reworded in. Only the message text is affected,
>     every commit's changes are always folded in.

Rebase re-orders commits so that fixups immediately follow their target 
- do you do that here? I think that is very relevant because here we may 
be dealing with several different commits each being targeted by a set 
of fixups and presenting them mixed together will be confusing. When 
rebase sees an "amend!" commit it comments out the message that is being 
replaced - it is not clear from this description whether that happens here.

As I've said before I think we would be better off with a summary of the 
commits that are being squashed and a more compact template message that 
only contains the messages we want to keep [2]. What are the advantages 
of having lots of commented lines (or redundant messages if you don't 
comment out the original when there is an amend! commit) in the middle 
of the template message?

>   * Reuse git rebase -i's squash-message code: a preparatory sequencer:
>     commit extracts the banner, header and marker-comment helpers so both
>     rebase and git history squash build the identical template from one
>     source.
>   * Refuse a range whose oldest commit is a fixup!, squash! or amend!, since
>     the marker's target cannot be inside the range.

I think it should allow squashing a bunch of fixups together though. I 
thought there was a plan [3] to refuse to squash a fixup unless the 
range included its target.

The range-diff does not show any input sanitization - what happens when 
the user passes "--reverse" for example? As I said in [4] we should copy 
what "git replay" does to sanity check the rev-list options, otherwise 
we've got no idea whether the parent of the first commit returned by 
get_revision() is the commit we want to use as the parent of the 
squashed commit.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/3c35bd17-e884-432d-a400-36a89964ed89@gmail.com/
[2] 
https://lore.kernel.org/git/4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com
[3] 
https://lore.kernel.org/git/CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com/
[4] 
https://lore.kernel.org/git/f3fe7ff2-3ce9-4e90-95e7-8c620de5628a@gmail.com/

>   * Reorder the squash usage so dashed options come before <revision-range>,
>     and spell out HEAD instead of @ in the documentation and examples.
>   * Expand the squash commit message and documentation with this overview,
>     and scope the merge limitation so it no longer contradicts squash folding
>     a single-base interior merge.
> 
> Changes in v6:
> 
>   * git history squash now accepts multiple revision arguments, read like the
>     arguments to git-rev-list, so a compound range such as @~3.. ^topic
>     works.
>   * The base to reparent onto is now the oldest in-range commit's parent; a
>     boundary other than that base means the range has more than one base and
>     is rejected. This also fixes the earlier overly-restrictive handling of
>     merges and side branches.
>   * A single-commit range (e.g. @^!) is rejected with "nothing to squash"
>     (this also covers the @^!-style example that previously succeeded
>     silently).
>   * Commit messages reworded: the squash commit now gives an overview of
>     fixup!/squash!/amend! handling, rewording, merge-parent and ref behavior.
> 
> Changes in v5:
> 
>   * The range walk now uses --ancestry-path, so only commits descended from
>     the base are folded; a single revision such as HEAD or HEAD~1 is now
>     rejected as "not a <base>..<tip> range" rather than treated as a squash
>     down to the root.
>   * This adopts the --ancestry-path suggestion; the multi-base rejection is
>     unchanged, so a side branch that forked before the base and merged in is
>     still refused.
>   * Added tests covering more merge topologies: two interior merges, a nested
>     merge, an octopus merge, an octopus arm forked before the base, a merge
>     among the descendants replayed above the range, and a ref pointing at an
>     interior merge commit.
> 
> Changes in v4:
> 
>   * git history squash now detects when another ref points at a commit inside
>     the range being folded and refuses, with an advice.historyUpdateRefs hint
>     to use --update-refs=head.
>   * A merge inside the range is folded fine as long as the range has a single
>     base; a range with merge commit at the tip or base also folds correctly.
>     Only a range with more than one base is rejected.
> 
> Changes in v3:
> 
>   * Moved the feature out of git rebase and into a new git history squash
>     <revision-range> subcommand, per the list discussion. git rebase --squash
>     is dropped.
>   * Takes an arbitrary range (git history squash @~3.., git history squash
>     @~5..@~2), folding it into the oldest commit and replaying any
>     descendants on top.
>   * Implemented as a single tree operation rather than picking each commit,
>     so there are no repeated conflict stops (addresses Phillip's efficiency
>     point).
>   * A merge inside the range is folded fine, only a range with more than one
>     base is rejected.
>   * --reedit-message seeds the editor with every folded-in message, not just
>     the oldest.
> 
> Harald Nordgren (5):
>    history: extract helper for a commit's parent tree
>    history: give commit_tree_ext a message template
>    history: add squash subcommand to fold a range
>    sequencer: extract helpers for the squash message markers
>    history: re-edit a squash with every message
> 
>   Documentation/config/advice.adoc |   4 +
>   Documentation/git-history.adoc   |  49 ++-
>   advice.c                         |   1 +
>   advice.h                         |   1 +
>   builtin/history.c                | 390 +++++++++++++++++--
>   sequencer.c                      |  64 ++--
>   sequencer.h                      |  23 ++
>   t/meson.build                    |   1 +
>   t/t3455-history-squash.sh        | 632 +++++++++++++++++++++++++++++++
>   9 files changed, 1099 insertions(+), 66 deletions(-)
>   create mode 100755 t/t3455-history-squash.sh
> 
> 
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v7
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v7
> Pull-Request: https://github.com/git/git/pull/2337
> 
> Range-diff vs v6:
> 
>   1:  fea6b79e60 = 1:  56ed8fadbb history: extract helper for a commit's parent tree
>   2:  e2674e0bc4 = 2:  212e9c228f history: give commit_tree_ext a message template
>   3:  811e393ab4 ! 3:  cf3346a1cd history: add squash subcommand to fold a range
>       @@ Commit message
>            Add "git history squash <revision-range>" to do this directly. It folds
>            every commit in the range into the oldest one, keeping that commit's
>            message and authorship and taking the tree of the newest commit, then
>       -    replays the commits above the range on top. fixup!, squash! and amend!
>       -    commits are folded like any other and are not interpreted, so the
>       -    squashed message comes from the oldest commit, or from an editor with
>       -    --reedit-message.
>       +    replays the commits above the range on top. The squashed message comes
>       +    from the oldest commit, or from an editor with --reedit-message. As that
>       +    message is reused, a range whose oldest commit is a fixup!, squash! or
>       +    amend! is refused, since the marker's target cannot be in the range.
>        
>            The range is read like the arguments to "git rev-list", so several
>       -    arguments such as "@~3.. ^topic" are allowed. A merge inside the range
>       -    is folded when its other parent is reachable from the base, otherwise
>       -    the range has more than one base and is rejected. By default the command
>       -    also refuses when a ref points at a commit that the fold would discard.
>       -    Use --update-refs=head to rewrite only the current branch instead.
>       +    arguments such as "HEAD~3..HEAD ^topic" are allowed. A merge inside the
>       +    range is folded when its other parent is reachable from the base,
>       +    otherwise the range has more than one base and is rejected. By default
>       +    the command also refuses when a ref points at a commit that the fold
>       +    would discard. Use --update-refs=head to rewrite only the current branch
>       +    instead.
>        
>            Inspired-by: Sergey Chernov <serega.morph@gmail.com>
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>       @@ Documentation/git-history.adoc: SYNOPSIS
>         git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
>         git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
>         git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
>       -+git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]
>       ++git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>
>         
>         DESCRIPTION
>         -----------
>       +@@ Documentation/git-history.adoc: at once.
>       + LIMITATIONS
>       + -----------
>       +
>       +-This command does not (yet) work with histories that contain merges. You
>       +-should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
>       ++This command does not (yet) replay merge commits onto the rewritten
>       ++history: if a commit that would be replayed is a merge, the operation is
>       ++rejected, and you should use linkgit:git-rebase[1] with the
>       ++`--rebase-merges` flag instead. The `squash` subcommand can still fold a
>       ++merge that lies inside the range, as long as the range has a single base.
>       +
>       + Furthermore, the command does not support operations that can result in merge
>       + conflicts. This limitation is by design as history rewrites are not intended to
>        @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
>         It is invalid to select either all or no hunks, as that would lead to
>         one of the commits becoming empty.
>       @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
>        ++
>        +The range is given in the usual `<base>..<tip>` form, where _<base>_ is
>        +the commit just below the oldest commit to squash. For example, `git
>       -+history squash @~3..` folds the three most recent commits into one, and
>       -+`git history squash @~5..@~2` squashes an interior range while leaving
>       -+the two newest commits in place. _<revision-range>_ is read like the
>       -+arguments to linkgit:git-rev-list[1], so several arguments may be given,
>       -+for example `@~3.. ^topic` to additionally exclude what is already on
>       -+`topic`.
>       ++history squash HEAD~3..HEAD` folds the three most recent commits into
>       ++one, and `git history squash HEAD~5..HEAD~2` squashes an interior range
>       ++while leaving the two newest commits in place. _<revision-range>_ is read
>       ++like the arguments to linkgit:git-rev-list[1], so several arguments may be
>       ++given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
>       ++already on `topic`.
>        ++
>        +The oldest commit's message and authorship are preserved by default,
>        +unless you specify `--reedit-message`. A merge commit inside the range is
>       @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
>        +that reaches more than one entry point (for example a side branch that
>        +forked before the range and was later merged into it) is rejected.
>        ++
>       -+The folded commits disappear from the history, so with the default
>       -+`--update-refs=branches` the command refuses when another ref points at
>       -+one of them. Rerun with `--update-refs=head` to rewrite only the current
>       -+branch and leave those refs pointing at the old commits.
>       ++Because the oldest commit's message is reused, the range may not begin
>       ++with a `fixup!`, `squash!`, or `amend!` commit, whose target is
>       ++necessarily outside the range.
>       +++
>       ++A branch or tag that points at a commit inside the range would be left
>       ++dangling once those commits are folded away, so with the default
>       ++`--update-refs=branches` the command refuses. Rerun with
>       ++`--update-refs=head` to rewrite only the current branch and leave such
>       ++refs pointing at the old commits.
>        +
>         OPTIONS
>         -------
>         
>       +@@ Documentation/git-history.adoc: OPTIONS
>       + 	ref updates is generally safe.
>       +
>       + `--reedit-message`::
>       +-	Open an editor to modify the target commit's message.
>       ++	Open an editor to modify the rewritten commit's message. For `squash`
>       ++	the editor is pre-filled with the messages of all the folded commits.
>       +
>       + `--empty=(drop|keep|abort)`::
>       + 	Control what happens when a commit becomes empty as a result of the
>        
>         ## advice.c ##
>        @@ advice.c: static struct {
>       @@ builtin/history.c
>         #define GIT_HISTORY_SPLIT_USAGE \
>         	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
>        +#define GIT_HISTORY_SQUASH_USAGE \
>       -+	N_("git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]")
>       ++	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>")
>         
>         static void change_data_free(void *util, const char *str UNUSED)
>         {
>       @@ builtin/history.c: out:
>        +	return ret;
>        +}
>        +
>       ++static int reject_fixupish_oldest(struct repository *repo,
>       ++				  struct commit *oldest)
>       ++{
>       ++	const char *message, *subject;
>       ++	int ret = 0;
>       ++
>       ++	message = repo_logmsg_reencode(repo, oldest, NULL, NULL);
>       ++	find_commit_subject(message, &subject);
>       ++	if (starts_with(subject, "fixup! ") ||
>       ++	    starts_with(subject, "squash! ") ||
>       ++	    starts_with(subject, "amend! "))
>       ++		ret = error(_("the range begins with a fixup!, squash! or amend! "
>       ++			      "commit whose target is not in the range"));
>       ++	repo_unuse_commit_buffer(repo, oldest, message);
>       ++	return ret;
>       ++}
>       ++
>        +struct interior_ref_cb {
>        +	const struct oidset *interior;
>        +	const char *name;
>       @@ builtin/history.c: out:
>        +	if (ret < 0)
>        +		goto out;
>        +
>       ++	ret = reject_fixupish_oldest(repo, oldest);
>       ++	if (ret < 0)
>       ++		goto out;
>       ++
>        +	if (action == REF_ACTION_BRANCHES) {
>        +		struct interior_ref_cb cb = { .interior = &interior };
>        +
>       @@ t/t3455-history-squash.sh (new)
>        +
>        +test_expect_success 'squashes a range into a single commit without changing the tree' '
>        +	git reset --hard three &&
>       ++	head_before=$(git rev-parse HEAD) &&
>        +	tip_tree=$(git rev-parse HEAD^{tree}) &&
>        +
>       ++	git history squash --dry-run start.. >out &&
>       ++	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
>       ++	test_cmp_rev "$head_before" HEAD &&
>       ++
>        +	git history squash start.. &&
>        +
>       ++	test "$predicted" = "$(git rev-parse HEAD)" &&
>        +	git rev-list --count start..HEAD >count &&
>        +	echo 1 >expect &&
>        +	test_cmp expect count &&
>       @@ t/t3455-history-squash.sh (new)
>        +	test_cmp expect actual
>        +'
>        +
>       -+test_expect_success 'keeps the oldest message even if it is a fixup!' '
>       ++test_expect_success 'refuses a range whose oldest commit is a fixup!' '
>        +	git reset --hard start &&
>        +	test_commit --no-tag "fixup! something" file b &&
>       -+	test_commit tail file c &&
>       ++	test_commit --no-tag tail file c &&
>       ++	head_before=$(git rev-parse HEAD) &&
>       ++
>       ++	test_must_fail git history squash start.. 2>err &&
>       ++	test_grep "target is not in the range" err &&
>       ++	test_cmp_rev "$head_before" HEAD
>       ++'
>       ++
>       ++test_expect_success 'does not interpret squash! or amend! markers' '
>       ++	git reset --hard start &&
>       ++	test_commit --no-tag marker-oldest file b &&
>       ++	git commit --allow-empty -m "squash! marker-oldest" &&
>       ++	git commit --allow-empty -m "amend! marker-oldest" &&
>       ++	test_commit --no-tag marker-newest file c &&
>        +
>        +	git history squash start.. &&
>        +
>       ++	git rev-list --count start..HEAD >count &&
>       ++	echo 1 >expect &&
>       ++	test_cmp expect count &&
>        +	git log --format="%s" -1 >actual &&
>       -+	echo "fixup! something" >expect &&
>       ++	echo marker-oldest >expect &&
>        +	test_cmp expect actual
>        +'
>        +
>       @@ t/t3455-history-squash.sh (new)
>        +	test_cmp expect actual
>        +'
>        +
>       -+test_expect_success '--dry-run predicts the rewrite without performing it' '
>       -+	git reset --hard three &&
>       -+	head_before=$(git rev-parse HEAD) &&
>       -+	tip_tree=$(git rev-parse HEAD^{tree}) &&
>       -+
>       -+	git history squash --dry-run start.. >out &&
>       -+	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
>       -+	test_cmp_rev "$head_before" HEAD &&
>       -+
>       -+	git history squash start.. &&
>       -+	test "$predicted" = "$(git rev-parse HEAD)" &&
>       -+	git rev-list --count start..HEAD >count &&
>       -+	echo 1 >expect &&
>       -+	test_cmp expect count &&
>       -+	test_cmp_rev start HEAD^ &&
>       -+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
>       -+'
>       -+
>        +test_expect_success '--update-refs=head only moves HEAD' '
>        +	git reset --hard three &&
>        +	git branch -f other HEAD &&
>   -:  ---------- > 4:  001356db93 sequencer: extract helpers for the squash message markers
>   4:  4edf012b77 ! 5:  615fe4dd3f history: re-edit a squash with every message
>       @@ Commit message
>            When --reedit-message is given it only reopened that one message, so the
>            messages of the folded-in commits were lost.
>        
>       -    Gather the messages of every commit in the range, oldest first, and use
>       -    them as the editor template when re-editing, mirroring how "git rebase
>       -    -i" presents a squash.
>       +    Gather the messages of every commit in the range, oldest first, and build
>       +    the same editor template that "git rebase -i" shows for a squash, using
>       +    add_squash_combination_header(), add_squash_message_header() and
>       +    squash_subject_comment_len(). Only the message text differs, the changes
>       +    are always folded in. Following autosquash, a fixup!'s message is
>       +    commented out in full under a "will be skipped" header, while a squash! or
>       +    amend! keeps its body with only the marker subject commented.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>         ## Documentation/git-history.adoc ##
>       -@@ Documentation/git-history.adoc: arguments to linkgit:git-rev-list[1], so several arguments may be given,
>       - for example `@~3.. ^topic` to additionally exclude what is already on
>       - `topic`.
>       +@@ Documentation/git-history.adoc: like the arguments to linkgit:git-rev-list[1], so several arguments may be
>       + given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
>       + already on `topic`.
>         +
>        -The oldest commit's message and authorship are preserved by default,
>        -unless you specify `--reedit-message`. A merge commit inside the range is
>       @@ Documentation/git-history.adoc: arguments to linkgit:git-rev-list[1], so several
>         folded like any other, but the range must have a single base, so a range
>         that reaches more than one entry point (for example a side branch that
>         forked before the range and was later merged into it) is rejected.
>       + +
>       + Because the oldest commit's message is reused, the range may not begin
>       + with a `fixup!`, `squash!`, or `amend!` commit, whose target is
>       +-necessarily outside the range.
>       ++necessarily outside the range. The changes from every commit in the range
>       ++are always folded in. Only the message text differs. With
>       ++`--reedit-message` the template mirrors `git rebase -i`: the message of a
>       ++`fixup!` elsewhere in the range is commented out in full, while a
>       ++`squash!` or `amend!` keeps its message body with only the marker subject
>       ++commented, so you can fold the remark into the result.
>       + +
>       + A branch or tag that points at a commit inside the range would be left
>       + dangling once those commits are folded away, so with the default
>        
>         ## builtin/history.c ##
>        @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, void *cb_data)
>       @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, voi
>        +				struct commit *tip,
>        +				struct strbuf *out)
>        +{
>       ++	struct commit_list *commits = NULL, **tail = &commits, *c;
>        +	struct rev_info revs;
>        +	struct commit *commit;
>        +	struct strvec args = STRVEC_INIT;
>       -+	int n = 0, ret;
>       ++	int n = 0, total, ret;
>        +
>        +	repo_init_revisions(repo, &revs, NULL);
>        +	strvec_push(&args, "ignored");
>       @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, voi
>        +		goto out;
>        +	}
>        +
>       -+	while ((commit = get_revision(&revs))) {
>       ++	while ((commit = get_revision(&revs)))
>       ++		tail = &commit_list_insert(commit, tail)->next;
>       ++	total = commit_list_count(commits);
>       ++
>       ++	for (c = commits; c; c = c->next) {
>        +		const char *message, *body;
>       -+		struct strbuf one = STRBUF_INIT;
>       ++		size_t commented_len;
>       ++		int skip;
>        +
>       -+		message = repo_logmsg_reencode(repo, commit, NULL, NULL);
>       ++		message = repo_logmsg_reencode(repo, c->item, NULL, NULL);
>        +		find_commit_subject(message, &body);
>       -+		strbuf_addstr(&one, body);
>       -+		strbuf_trim_trailing_newline(&one);
>        +
>       -+		if (n++)
>       -+			strbuf_addch(out, '\n');
>       -+		strbuf_addbuf(out, &one);
>       ++		skip = starts_with(body, "fixup! ");
>       ++		commented_len = skip ? strlen(body) :
>       ++			squash_subject_comment_len(body, 1);
>       ++
>       ++		if (!n)
>       ++			add_squash_combination_header(out, total);
>        +		strbuf_addch(out, '\n');
>       ++		add_squash_message_header(out, ++n, skip);
>       ++		strbuf_addstr(out, "\n\n");
>       ++		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
>       ++		strbuf_addstr(out, body + commented_len);
>       ++		strbuf_complete_line(out);
>        +
>       -+		strbuf_release(&one);
>       -+		repo_unuse_commit_buffer(repo, commit, message);
>       ++		repo_unuse_commit_buffer(repo, c->item, message);
>        +	}
>        +
>        +	ret = 0;
>        +
>        +out:
>       ++	commit_list_free(commits);
>        +	reset_revision_walk();
>        +	release_revisions(&revs);
>        +	strvec_clear(&args);
>       @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
>        +	test_commit re-three file d &&
>        +
>        +	write_script editor <<-\EOF &&
>       -+	cp "$1" buffer &&
>       ++	cat "$1" >edited &&
>        +	echo combined >"$1"
>        +	EOF
>        +	test_set_editor "$(pwd)/editor" &&
>        +	git history squash --reedit-message start.. &&
>        +
>       -+	test_grep "re-one subject" buffer &&
>       -+	test_grep "re-one body line" buffer &&
>       -+	test_grep re-two buffer &&
>       -+	test_grep re-three buffer &&
>       -+	git log --format="%s" -1 >actual &&
>       ++	cat >expect <<-EOF &&
>       ++	# This is a combination of 3 commits.
>       ++	# This is the 1st commit message:
>       ++
>       ++	re-one subject
>       ++
>       ++	re-one body line
>       ++
>       ++	# This is the commit message #2:
>       ++
>       ++	re-two
>       ++
>       ++	# This is the commit message #3:
>       ++
>       ++	re-three
>       ++
>       ++	# Please enter the commit message for the squash changes. Lines starting
>       ++	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
>       ++	# Changes to be committed:
>       ++	#	modified:   file
>       ++	#
>       ++	EOF
>       ++	test_cmp expect edited &&
>        +	echo combined >expect &&
>       ++	git log --format="%s" -1 >actual &&
>        +	test_cmp expect actual
>        +'
>        +
>       ++test_expect_success '--reedit-message handles fixup!, squash! and amend! like rebase' '
>       ++	git reset --hard start &&
>       ++	test_commit --no-tag mark-base file b &&
>       ++	printf "fixup! mark-base\n\nfixup body\n" >msg &&
>       ++	echo c >file &&
>       ++	git add file &&
>       ++	git commit -qF msg &&
>       ++	printf "squash! mark-base\n\nsquash remark\n" >msg &&
>       ++	echo d >file &&
>       ++	git add file &&
>       ++	git commit -qF msg &&
>       ++	printf "amend! mark-base\n\namended message\n" >msg &&
>       ++	echo e >file &&
>       ++	git add file &&
>       ++	git commit -qF msg &&
>       ++
>       ++	write_script editor <<-\EOF &&
>       ++	cat "$1" >edited
>       ++	EOF
>       ++	test_set_editor "$(pwd)/editor" &&
>       ++	git history squash --reedit-message start.. &&
>       ++
>       ++	cat >expect <<-EOF &&
>       ++	# This is a combination of 4 commits.
>       ++	# This is the 1st commit message:
>       ++
>       ++	mark-base
>       ++
>       ++	# The commit message #2 will be skipped:
>       ++
>       ++	# fixup! mark-base
>       ++	#
>       ++	# fixup body
>       ++
>       ++	# This is the commit message #3:
>       ++
>       ++	# squash! mark-base
>       ++
>       ++	squash remark
>       ++
>       ++	# This is the commit message #4:
>       ++
>       ++	# amend! mark-base
>       ++
>       ++	amended message
>       ++
>       ++	# Please enter the commit message for the squash changes. Lines starting
>       ++	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
>       ++	# Changes to be committed:
>       ++	#	modified:   file
>       ++	#
>       ++	EOF
>       ++	test_cmp expect edited &&
>       ++	git log -1 --format="%B" >final &&
>       ++	test_grep ! "fixup body" final &&
>       ++	test_grep "squash remark" final &&
>       ++	test_grep "amended message" final
>       ++'
>       ++
>        +test_expect_success '--reedit-message aborts on an empty message' '
>        +	git reset --hard three &&
>        +	head_before=$(git rev-parse HEAD) &&
>       @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
>        +	test_cmp_rev "$head_before" HEAD
>        +'
>        +
>       - test_expect_success '--dry-run predicts the rewrite without performing it' '
>       + test_expect_success '--update-refs=head only moves HEAD' '
>         	git reset --hard three &&
>       - 	head_before=$(git rev-parse HEAD) &&
>       + 	git branch -f other HEAD &&
> 

