Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9145D1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbdBPVPc (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:15:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34829 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933077AbdBPVPb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:15:31 -0500
Received: by mail-pg0-f65.google.com with SMTP id y6so1825041pgy.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s5RgOh78LTf1+JQZ8Qrr1eBs34UNTdDy91NYlADCPcU=;
        b=KbL2Z/CodAubvYM+Yvv7pap7EegINzg04Ri4OISbPBngio70GDNB/4EiP+NCDq/wHV
         B3Y0C847wARLhmwG8dxlogbz57FuUw+Vx5rmK3sb3BA1qtqmEJQsUJGf1BeQtajvNj3D
         f3kCzvqwk3nDV9j0oScxJ3biitoQJrLK4aszNiGppfQQYqdAJwIHHdW38gBO3m0UzNYD
         cCnsgOLB9NghH+v+hwCXLIU6qgi0tcgjF5iRuEN2xHRXLcTySyQcptsmx0qTsu39zGZK
         sofUdt6LLvFFRULRAypKiPrcqDN/xh4tU93BMrG0UY1KK1JSDWx/RdyuBLFfztvzR5jZ
         /aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s5RgOh78LTf1+JQZ8Qrr1eBs34UNTdDy91NYlADCPcU=;
        b=gY3x38sfw2iUX7lp+Yro5AAkLIQW3hkw1dgG66uw51SVpxJard5GeA5NysHUzZ5S/I
         GErCu5R5XhFr6sywVF+MCIxQVBgafWWDwF2CB8SFOTcptug2NrzgSlEkSPTsBuI4H36g
         eaa4CnkYD82hyaN0wTbK2V4lBhJYNQG9MQ7WA7R5J0GcgqAkn3K0Am/caT6DyGDzBqLn
         Ci9fk92ump5qKDmTjxoA5fYFze0okwBwT4rpiT9Q7Oyjmnmt2tABXnX+Gn4UC2NKd3mt
         ieYXPLoJI/RAhinuxJSS0NKu40DWdGNu6FYasw1vyz8Ue/yoNYP1b2J2ZlNzsQhiEJmT
         x2zQ==
X-Gm-Message-State: AMke39n61sKkX7kdwvkbAQO6LzLSD55ZqfhBWN/HnvavugrdvOVyRT2fMTe2gNkqqklqvA==
X-Received: by 10.99.140.28 with SMTP id m28mr5588105pgd.174.1487279730860;
        Thu, 16 Feb 2017 13:15:30 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id y6sm15497666pgc.1.2017.02.16.13.15.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 13:15:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 10/15] update submodules: add submodule_go_from_to
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
        <20170216003811.18273-11-sbeller@google.com>
Date:   Thu, 16 Feb 2017 13:15:29 -0800
In-Reply-To: <20170216003811.18273-11-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Feb 2017 16:38:06 -0800")
Message-ID: <xmqq7f4px2fi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

[administrivia: I've been seeing "unlisted-recipients:; (no To-header on input)"
for all of your recent patches.  Can it be corrected on your end, please?]

> In later patches we introduce the options and flag for commands
> that modify the working directory, e.g. git-checkout.
>
> This piece of code will be used universally for
> all these working tree modifications as it
> * supports dry run to answer the question:
>   "Is it safe to change the submodule to this new state?"
>   e.g. is it overwriting untracked files or are there local
>   changes that would be overwritten?
> * supports a force flag that can be used for resetting
>   the tree.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  submodule.h |   5 ++
>  2 files changed, 156 insertions(+)
>
> diff --git a/submodule.c b/submodule.c
> index b262c5b0ad..84cc62f3bb 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1250,6 +1250,157 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  	return ret;
>  }
>  
> +static int submodule_has_dirty_index(const struct submodule *sub)
> +{
> +	ssize_t len;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret = 0;
> +
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "diff-index", "--cached", "HEAD", NULL);

We'd want to use the QUICK optimization here, I suspect.  This
caller does not need to (or want to) learn which exact paths are
modified, right?

> +void submodule_clean_index(const char *path)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +
> +	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
> +	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
> +
> +	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
> +
> +	if (run_command(&cp))
> +		die("could not clean submodule index");
> +}

Do s/clean/reset/ everywhere above.

> +/**
> + * Moves a submodule at a given path from a given head to another new head.
> + * For edge cases (a submodule coming into existence or removing a submodule)
> + * pass NULL for old or new respectively.
> + *
> + * TODO: move dryrun and forced to flags.

The reason why this seeingly trivial thing is left as TODO is...???

> + */
> +int submodule_go_from_to(const char *path,
> +			 const char *old,
> +			 const char *new,
> +			 int dry_run,
> +			 int force)
> +{

go-from-to does not tell me what it does, but my cursory read of the
body of the function tells me that this is doing a checkout of a
branch in the submodule?  The operation in builtin/checkout.c that
conceptually correspond to this is called switch_branches(), I
think, so perhaps submodule_switch_branches() is a better name?

> +	int ret = 0;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const struct submodule *sub;
> +
> +	sub = submodule_from_path(null_sha1, path);
> +
> +	if (!sub)
> +		die("BUG: could not get submodule information for '%s'", path);
> +
> +	if (!dry_run) {
> +		if (old) {
> +			if (!submodule_uses_gitfile(path))
> +				absorb_git_dir_into_superproject("", path,
> +					ABSORB_GITDIR_RECURSE_SUBMODULES);
> +		} else {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_addf(&sb, "%s/modules/%s",
> +				    get_git_common_dir(), sub->name);
> +			connect_work_tree_and_git_dir(path, sb.buf);
> +			strbuf_release(&sb);
> +
> +			/* make sure the index is clean as well */
> +			submodule_clean_index(path);
> +		}
> +	}
> +
> +	if (old && !force) {
> +		/* Check if the submodule has a dirty index. */
> +		if (submodule_has_dirty_index(sub)) {
> +			/* print a thing here? */
> +			return -1;
> +		}

Isn't it too late to do this here?  You already reset the index
in the submodule, no?

Is the idea that changes that are only in the submodule's working
tree are noticed by later "read-tree -u -m" down there?  Not
complaining but trying to understand.

> +	}
> +
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +
> +	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
> +	argv_array_pushl(&cp.args, "read-tree", NULL);
> +
> +	if (dry_run)
> +		argv_array_push(&cp.args, "-n");
> +	else
> +		argv_array_push(&cp.args, "-u");
> +
> +	if (force)
> +		argv_array_push(&cp.args, "--reset");
> +	else
> +		argv_array_push(&cp.args, "-m");
> +
> +	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
> +	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
> +
> +	if (run_command(&cp)) {
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	if (!dry_run) {
> +		if (new) {
> +			struct child_process cp1 = CHILD_PROCESS_INIT;
> +			/* also set the HEAD accordingly */
> +			cp1.git_cmd = 1;
> +			cp1.no_stdin = 1;
> +			cp1.dir = path;
> +
> +			argv_array_pushl(&cp1.args, "update-ref", "HEAD",
> +					 new ? new : EMPTY_TREE_SHA1_HEX, NULL);
> +
> +			if (run_command(&cp1)) {
> +				ret = -1;
> +				goto out;
> ...
