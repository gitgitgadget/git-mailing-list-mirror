Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054AA20323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbdCPWUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:20:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34514 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbdCPWUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:20:05 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so7088132pfb.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnwPv5whmRNQHEvCnLQrloNwVwkE+wQ2fvB7a2IxP5M=;
        b=Ux6XgND6cyZuXXPsR+4oLahlRzn+z76ydf+iklGRRI1Ag2QD7rR5096Zs3SjDclYyz
         iNaDVFrOHpAYFWT2nNgV3LSJdTsQMIbaKXxs3X03D+W+W+N2cOUAV1JruA0ADTkM0fC+
         NtU8Xsi16uscBDZkUfviMbi3hHwwkiHWJX6G/2FTC0MQjtZSxwzQSD1MFNViyVhc6Pm+
         UkuDq9aYWFFuVuMQ64dbjDDVklhh5e1XE8Ur7hh6ijd8+Ko4QI5tvx/ypZX06LmSn7/V
         DDJ0vMvPs6B7Rg2MiEiXuBiKt602aTSxFQHwxga84TamSk9bL9FdsIeoe1F6nZHBG/aP
         RhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnwPv5whmRNQHEvCnLQrloNwVwkE+wQ2fvB7a2IxP5M=;
        b=ZSjTuc3BDhnNIO+wGb28NoWxD0Ete39g+yg3dOifh4ndTH6Q3iw3Nrj7/0dtF6R+hg
         eQsxnNpXM8riFhfHBwYMKznmSA+fK+ugZV1er/sOYvuMURB3IpYlNAYnEYijd7jYuZ0/
         /6a+f2Byjp1yBb43k5oamUiliDOuPRWCCZYvi1sd+rtORVaz8fsrlD0ifyg6MEZ7KXVn
         JmXfS8c9cZv8PbroTiRkybB9tg/hjD1+pO9uD06eJv/5KJ2a+aMR9VQZFCAUPlWUjgbS
         /sE4MYlqKPlY2fMpVUR/CGMDuZx6s522JIuWlwUDgaXbzT1JxKvL/DS8YZ83rAgsfkMt
         /m2A==
X-Gm-Message-State: AFeK/H1KEWYEOhN4F9880F2O3VDUfGeCDa+2bzd5N5m7CObYQBSNPHYud2LJ3IjnbJwf2g==
X-Received: by 10.84.179.165 with SMTP id b34mr15119562plc.147.1489702774600;
        Thu, 16 Mar 2017 15:19:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:61c9:f866:d5e4:4761])
        by smtp.gmail.com with ESMTPSA id z26sm12500891pgc.57.2017.03.16.15.19.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:19:33 -0700 (PDT)
Date:   Thu, 16 Mar 2017 15:19:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v2] short status: improve reporting for submodule changes
Message-ID: <20170316221907.GA9135@aiede.mtv.corp.google.com>
References: <CAGZ79kZ7rWw=q6a2AomTw20DsU1h+7ou4i8A14a2bcg+asRwLA@mail.gmail.com>
 <20170316204644.11616-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316204644.11616-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Yay, I like the change this makes.  So I'll nitpick in the hope that
that makes the patch more likely to stick.

Stefan Beller wrote:

> While we already have a porcelain2 layer for git-status, that is accurate
> for submodules, users still like the way they are are used to of
> 'status -s'.

I had to read this a few times to understand it.  Maybe explaining it
from the user's point of view would work:

	If I add an untracked file to a submodule or modify a tracked file,
	currently "git status --short" treats the change in the same way as
	changes to the current HEAD of the submodule:

		$ git clone --quiet --recurse-submodules https://gerrit.googlesource.com/gerrit
		$ echo hello >gerrit/plugins/replication/stray-file
		$ sed -i -e 's/.*//' gerrit/plugins/replication/.mailmap
		$ git -C gerrit status --short
		 M plugins/replication

	This is by analogy with ordinary files, where "M" represents a change
	that has not been added yet to the index.  But this change cannot be
	added to the index without entering the submodule, "git add"-ing it,
	and running "git commit", so the analogy is counterproductive.

> As a submodule has more state than a file potentially, we need more letters
> indicating these states, we'll go with lower 'm' and single '?' for now.
>
> When there the recorded commit doesn't differ from the submodule HEAD
> (which we still want to treat as "M", because that can be dealt with
> in the superproject), we can have different types of change in the
> submodule. The lower case 'm' indicates that there are changes to tracked
> files in the submodule. It signals that the --recurse-submodules option
> is needed for e.g. adding or committing these changes. The " ?" also
> differentiates an untracked file in the submodule from a regular
> untracked file.

This could say

	Introduce new status letters " ?" and " m" for this.  These are similar
	to the existing "??" and " M" but mean that the submodule (not the
	parent project) has new untracked files and modified files, respectively.
	The user can use "git add" and "git commit" from within the submodule to
	add them.

	Changes to the submodule's HEAD commit can be recorded in the index with
	a plain "git add -u" and are shown with " M", like today.

	To avoid excessive clutter, show at most one of " ?", " m", and " M" for
	the submodule.  They represent increasing levels of change --- the last
	one that applies is shown (e.g., " m" if there are both modified files
	and untracked files in the submodule, or " M" if the submodule's HEAD
	has been modified and it has untracked files).

> While making these changes, we need to make sure to not break porcelain
> level 1, which uses the same code as the short printing function.

	While making these changes, we need to make sure to not break porcelain
	level 1, which shares code with "status --short".  We only change
	"git status --short".

	Non-short "git status" and "git status --porcelain=2" already handle
	these cases by showing more detail:

		$ git -C gerrit status --porcelain=2
		1 .M S.MU 160000 160000 160000 305c864db28eb0c77c8499bc04c87de3f849cf3c 305c864db28eb0c77c8499bc04c87de3f849cf3c plugins/replication
		$ git -C gerrit status
	[...]
	        modified:   plugins/replication (modified content, untracked content)
	
	Scripts caring about these distinctions should use --porcelain=2.

> Signed-off-by: Stefan Beller <sbeller@google.com>

Having written that, a few questions:

Is it important to avoid clutter by showing the submodule only once?
What would you think of showing whatever subset of those three
statuses apply to a given submodule as separate lines instead, to
match the information that long-form "git status" shows?

How should a new untracked file in a submodule of a submodule be
shown?

[...]
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -181,6 +181,12 @@ in which case `XY` are `!!`.
>      !           !    ignored
>      -------------------------------------------------
>  
> +Submodules have more state to it, such that it reports instead:

Language nits: s/ to it//; s/, such that it reports instead/ and instead report/

> +		M    the submodule has a different HEAD than recorded

than recorded in the index?

> +		m    the submodule has modified content
> +		?    the submodule has untracked files
[...]
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh

\o/

> @@ -50,6 +50,15 @@ test_expect_success 'status with modified file in submodule (porcelain)' '
>  	EOF
>  '
>  
> +test_expect_success 'status with modified file in submodule (short)' '
> +	(cd sub && git reset --hard) &&

not about this patch: this could use "git -C sub" and avoid a
subshell.  But what you have here matches the existing style, so I
wouldn't suggest changing it here.

> +	echo "changed" >sub/foo &&
> +	git status --short >output &&
> +	diff output - <<-\EOF

similarly, this could use test_cmp, but that seems out of scope for
this change.

[...]
> +test_expect_success 'status with added file in submodule (short)' '
[...]
> +test_expect_success 'status with untracked file in submodule (short)' '

Test wishlist:
* --porcelain output for these cases
* behavior with nested submodules

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1664,9 +1664,19 @@ static void wt_shortstatus_status(struct string_list_item *it,
>  		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
>  	else
>  		putchar(' ');
> -	if (d->worktree_status)
> +	if (d->worktree_status) {
> +		if (!s->submodule_porcelain1 &&

Isn't this 's->status_format != STATUS_FORMAT_PORCELAIN'?

[...]
> +		    (d->dirty_submodule || d->new_submodule_commits)) {
> +			/* It is a submodule, and we're not in plumbing mode. */
> +			if (d->new_submodule_commits)
> +				d->worktree_status = 'M';
> +			else if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> +				d->worktree_status = 'm';
> +			else if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> +				d->worktree_status = '?';
> +		}

Is this the right place to do this?  Could wt_status_collect_changed_cb set
worktree_status to the right value in the first place based on whether
'status_format == STATUS_FORMAT_SHORT' or would that have undesirable
knock-on effects elsewhere?

[...]
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -70,6 +70,7 @@ struct wt_status {
>  	int display_comment_prefix;
>  	int relative_paths;
>  	int submodule_summary;
> +	int submodule_porcelain1;

As described above, this shouldn't be needed since status_format
already has this information.

Thanks for this --- I like it.

Sincerely,
Jonathan
