Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913C315D33
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225716; cv=none; b=EB07uJxU1/ID+S5M/ilnzqKBN2MYzAtb2oq0xouvK+NvcR2qJ/z7fjR+/NdJGz9UgOT/bmSHjgRI6COqJDo1lUeArKXBlllk4Ry90YAMLEa0dsIwUotwwbC7UhNfIEkv9hmGM7gwBk+vLOsoaEqg+R3TCnVPRpHs1WJuroVllZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225716; c=relaxed/simple;
	bh=muFf9vyXFphL8Qg0DIQv+CmReGMnP1yZEUjpimfp7vY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=WgXgoGHbT/eXyWjvIvt2wz64qA5uaocF3EnJQ47GPQmzLyuRAUBjs3xXii8nTVt/Msc3A8UXNw1pyIMEBigB1JAlnTXXf4s5hHXPDKKbTrNqQnPUUUpHYcbYJdf+7vq2YKZ/PcmZd9FnlCjItka6289pq/GXPdgkqo+wH4mbOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyaJJmQI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyaJJmQI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47117e75258so6338275e9.2
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761225712; x=1761830512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgW8T+N88PxYt7ugG5jX3bR+U2id1mbAa4pnyTx1HlY=;
        b=FyaJJmQIMoWE70vmTdEEFrMml6ihSqstM2EkMZuLSxjHWwB8lI7vjWqwl16Y46UpGt
         aN8ie+oKhEj/6iWetJVhNy7862KGksmUlIR9+wBBBMG0dx9RnwhptelqjMaaXzD5YEFL
         +Z1B/6ROYSjUcg6gZgq8BND5Sdcwbbkb2mUKdx2TGofTQQEUJdImdaK8tImRP8bnMwBt
         NJWl37VPHTT/Xgkrn9leauwqyA0PVqRtvPvFBkGPqhfd4bOwT4XTGKhQ2CSNNs2h2qSD
         u8So36Gl/bN9NclkuOXR9hyTtqdGW39VkmjjLiAhvNZJ3q9RWJe5vXrtnMKl0m3yg0zB
         msgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225712; x=1761830512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgW8T+N88PxYt7ugG5jX3bR+U2id1mbAa4pnyTx1HlY=;
        b=drnKS/qtckm0ervtZFIxECaujUaN/AYnUBxEgxWY89H9gDJwxk27bXIwYVHk4d5iqs
         f7h3e5McjPrrD4ghuU/XK+Fdo15AePbZEnkpEK+6cB+/ml5BdpFBPV5rpQ1UAwGhDEZ3
         E3cFDE5y7cLQPPjISU77MV/Yi2aws6CMrewC1nC41vIZffTrfK6yysm76DD8ePFQxmZU
         HCq8lvJR3vsWb3vRSPjj4EVvCHCrtGxHMfMy7HKimIUqSXzQTla255qLOZAvccp43lDR
         njm7Yk8nc1F9jYNBj3NkYpSRU79rxlmJ0pQdE1CjoWAeAFmxKgUdOKyELtLn8HF0MQFv
         hLKw==
X-Forwarded-Encrypted: i=1; AJvYcCVuv4FXQ965NjhODoTSh93Cq7XhNWjEAMn8V/qeKo+UC9wWDZHKFYMNOeH0JXJA0l0u/nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3fdOLlOjllnejv7jUZu8usVxTpFKanE4AJRPiNpCjWfuKuHJs
	qFUNECi4XDbeJd1pJmwp6jDB2Z1p+VWKAl9QKjxYv6RRnKuJto79z1CE
X-Gm-Gg: ASbGncu812YQI9+MwyqCh41MLSzwPZne1eKRgPokV2wsaHUyRurtEQA19J4IIOyNDfD
	OaKukIaBjYy8HmZzDfiwdcxytPkqvexy3f6iK6LtF4ij2xHn5vJF8x4jpDMBTmxwUz3rj80JKZz
	5vqdRN8avnpEC50h5DesrevUqJuk2u40RskjTVmTHntb+67tAWnt/FkdkC/YuxMDrsKWxR55HbG
	sKttKgNHsVO+ihgKXCi1PgWci93SWAmsE3rsNjnMksOW4wR/MI2BOuQxgNSY8qVI8w8i8+nBLvB
	uNJsOo4U3vmGZO7X+jVP6eB4V0QDg07e0QaSlJlnDPJVE2Bc/Zfv3oHKRwWMKJnBGROJ3jGMEwM
	yiqM2txOprI5oqdC5uTjOjwcF+qnFz1z2xWYGj49s2EbhQqyPSYMoSezAEm5DSFsu3/L5NAGONp
	z2MnahxFrDKmoKM8qJPpY59IXl3Wq3RGsxP+sX65DyUCpIcYTqVV7I
X-Google-Smtp-Source: AGHT+IGFT1JyJ/ubA0CXrWDNX+DJYT++iLjisl9e2i3VAB6l3wWNBlGdeNhxTPJbNFLYCpKSsQlR8A==
X-Received: by 2002:a05:600c:4e45:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-475cb02faa5mr16854095e9.22.1761225711775;
        Thu, 23 Oct 2025 06:21:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add8bsm3811578f8f.23.2025.10.23.06.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:21:51 -0700 (PDT)
Message-ID: <66ff7ada-b584-4a0b-99af-9e7d234b75ed@gmail.com>
Date: Thu, 23 Oct 2025 14:21:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 09/29] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20251022053951.602605-1-me@linux.beauty>
 <20251022053951.602605-10-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20251022053951.602605-10-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chen

The code here seems to be largely unchanged from v3. I see there are 
some later patches in response to my review. They should be squashed 
into this patch as Kristoffer has previously explained.

Thanks

Phillip

On 22/10/2025 06:39, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> Implement a new `--trailer <text>` option for `git rebase`
> (support merge backend only now), which appends arbitrary
> trailer lines to each rebased commit message.
> 
> Reject it if the user passes an option that requires the
> apply backend (git am) since it lacks message‑filter/trailer
> hook. otherwise we can just use the merge backend.
> 
> Automatically set REBASE_FORCE when any trailer is supplied.
> 
> And reject invalid input before user edits the interactive file.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>   Documentation/git-rebase.adoc |  9 +++-
>   builtin/rebase.c              | 89 +++++++++++++++++++++++++++++++++
>   sequencer.c                   | 13 +++++
>   sequencer.h                   |  4 +-
>   t/meson.build                 |  1 +
>   t/t3440-rebase-trailer.sh     | 94 +++++++++++++++++++++++++++++++++++
>   6 files changed, 208 insertions(+), 2 deletions(-)
>   create mode 100755 t/t3440-rebase-trailer.sh
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 005caf6164..4d2fe4be6e 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -487,9 +487,16 @@ See also INCOMPATIBLE OPTIONS below.
>   	Add a `Signed-off-by` trailer to all the rebased commits. Note
>   	that if `--interactive` is given then only commits marked to be
>   	picked, edited or reworded will have the trailer added.
> -+
> +
>   See also INCOMPATIBLE OPTIONS below.
>   
> +--trailer=<trailer>::
> +       Append the given trailer line(s) to every rebased commit
> +       message, processed via linkgit:git-interpret-trailers[1].
> +       When this option is present *rebase automatically implies*
> +       `--force-rebase` so that fast‑forwarded commits are also
> +       rewritten.
> +
>   -i::
>   --interactive::
>   	Make a list of the commits which are about to be rebased.  Let the
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index c468828189..3db1439b52 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -36,6 +36,7 @@
>   #include "reset.h"
>   #include "trace2.h"
>   #include "hook.h"
> +#include "trailer.h"
>   
>   static char const * const builtin_rebase_usage[] = {
>   	N_("git rebase [-i] [options] [--exec <cmd>] "
> @@ -113,6 +114,7 @@ struct rebase_options {
>   	enum action action;
>   	char *reflog_action;
>   	int signoff;
> +	struct strvec trailer_args;
>   	int allow_rerere_autoupdate;
>   	int keep_empty;
>   	int autosquash;
> @@ -143,6 +145,7 @@ struct rebase_options {
>   		.flags = REBASE_NO_QUIET, 		\
>   		.git_am_opts = STRVEC_INIT,		\
>   		.exec = STRING_LIST_INIT_NODUP,		\
> +		.trailer_args = STRVEC_INIT,  \
>   		.git_format_patch_opt = STRBUF_INIT,	\
>   		.fork_point = -1,			\
>   		.reapply_cherry_picks = -1,             \
> @@ -166,6 +169,7 @@ static void rebase_options_release(struct rebase_options *opts)
>   	free(opts->strategy);
>   	string_list_clear(&opts->strategy_opts, 0);
>   	strbuf_release(&opts->git_format_patch_opt);
> +	strvec_clear(&opts->trailer_args);
>   }
>   
>   static struct replay_opts get_replay_opts(const struct rebase_options *opts)
> @@ -177,6 +181,10 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   	sequencer_init_config(&replay);
>   
>   	replay.signoff = opts->signoff;
> +
> +	for (size_t i = 0; i < opts->trailer_args.nr; i++)
> +		strvec_push(&replay.trailer_args, opts->trailer_args.v[i]);
> +
>   	replay.allow_ff = !(opts->flags & REBASE_FORCE);
>   	if (opts->allow_rerere_autoupdate)
>   		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
> @@ -434,6 +442,8 @@ static int read_basic_state(struct rebase_options *opts)
>   	struct strbuf head_name = STRBUF_INIT;
>   	struct strbuf buf = STRBUF_INIT;
>   	struct object_id oid;
> +	const char trailer_state_name[] = "trailer";
> +	const char *path = state_dir_path(trailer_state_name, opts);
>   
>   	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
>   			   READ_ONELINER_WARN_MISSING) ||
> @@ -502,11 +512,31 @@ static int read_basic_state(struct rebase_options *opts)
>   
>   	strbuf_release(&buf);
>   
> +	if (strbuf_read_file(&buf, path, 0) >= 0) {
> +		const char *p = buf.buf, *end = buf.buf + buf.len;
> +
> +		while (p < end) {
> +			char *nl = memchr(p, '\n', end - p);
> +			if (!nl)
> +				die("nl shouldn't be NULL");
> +			*nl = '\0';
> +
> +			if (*p)
> +				strvec_push(&opts->trailer_args, p);
> +
> +			p = nl + 1;
> +		}
> +		strbuf_release(&buf);
> +	}
> +	strbuf_release(&buf);
> +
>   	return 0;
>   }
>   
>   static int rebase_write_basic_state(struct rebase_options *opts)
>   {
> +	const char trailer_state_name[] = "trailer";
> +
>   	write_file(state_dir_path("head-name", opts), "%s",
>   		   opts->head_name ? opts->head_name : "detached HEAD");
>   	write_file(state_dir_path("onto", opts), "%s",
> @@ -528,6 +558,21 @@ static int rebase_write_basic_state(struct rebase_options *opts)
>   	if (opts->signoff)
>   		write_file(state_dir_path("signoff", opts), "--signoff");
>   
> +	/*
> +	 * save opts->trailer_args into state_dir/trailer
> +	 */
> +	if (opts->trailer_args.nr) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		for (size_t i = 0; i < opts->trailer_args.nr; i++) {
> +				strbuf_addstr(&buf, opts->trailer_args.v[i]);
> +				strbuf_addch(&buf, '\n');
> +		}
> +		write_file(state_dir_path(trailer_state_name, opts),
> +				   "%s", buf.buf);
> +		strbuf_release(&buf);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1084,6 +1129,35 @@ static int check_exec_cmd(const char *cmd)
>   	return 0;
>   }
>   
> +static int validate_trailer_args_after_config(const struct strvec *cli_args,
> +					      struct strbuf *err)
> +{
> +	for (size_t i = 0; i < cli_args->nr; i++) {
> +		const char *raw = cli_args->v[i];
> +		const char *txt; // Key[:=]Val
> +		const char *sep;
> +
> +		if (!skip_prefix(raw, "--trailer=", &txt))
> +			txt = raw;
> +
> +		if (!*txt) {
> +			strbuf_addstr(err, _("empty --trailer argument"));
> +			return -1;
> +		}
> +
> +		sep = strpbrk(txt, ":=");
> +
> +		/* there must be key bfore seperator */
> +		if (sep && sep == txt) {
> +			strbuf_addf(err,
> +				    _("invalid trailer '%s': missing key before separator"),
> +				    txt);
> +			return -1;
> +		}
> +	}
> +	return 0;
> +}
> +
>   int cmd_rebase(int argc,
>   	       const char **argv,
>   	       const char *prefix,
> @@ -1132,6 +1206,8 @@ int cmd_rebase(int argc,
>   			.flags = PARSE_OPT_NOARG,
>   			.defval = REBASE_DIFFSTAT,
>   		},
> +		OPT_STRVEC(0, "trailer", &options.trailer_args, N_("trailer"),
> +				N_("add custom trailer(s)")),
>   		OPT_BOOL(0, "signoff", &options.signoff,
>   			 N_("add a Signed-off-by trailer to each commit")),
>   		OPT_BOOL(0, "committer-date-is-author-date",
> @@ -1285,6 +1361,16 @@ int cmd_rebase(int argc,
>   			     builtin_rebase_options,
>   			     builtin_rebase_usage, 0);
>   
> +	if (options.trailer_args.nr) {
> +		struct strbuf err = STRBUF_INIT;
> +
> +		if (validate_trailer_args_after_config(&options.trailer_args, &err))
> +			die("%s", err.buf);
> +
> +		options.flags |= REBASE_FORCE;
> +		strbuf_release(&err);
> +	}
> +
>   	if (preserve_merges_selected)
>   		die(_("--preserve-merges was replaced by --rebase-merges\n"
>   			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
> @@ -1542,6 +1628,9 @@ int cmd_rebase(int argc,
>   	if (options.root && !options.onto_name)
>   		imply_merge(&options, "--root without --onto");
>   
> +	if (options.trailer_args.nr)
> +		imply_merge(&options, "--trailer");
> +
>   	if (isatty(2) && options.flags & REBASE_NO_QUIET)
>   		strbuf_addstr(&options.git_format_patch_opt, " --progress");
>   
> diff --git a/sequencer.c b/sequencer.c
> index 5476d39ba9..5103ae786c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -420,6 +420,7 @@ void replay_opts_release(struct replay_opts *opts)
>   	if (opts->revs)
>   		release_revisions(opts->revs);
>   	free(opts->revs);
> +	strvec_clear(&opts->trailer_args);
>   	replay_ctx_release(ctx);
>   	free(opts->ctx);
>   }
> @@ -2517,6 +2518,18 @@ static int do_pick_commit(struct repository *r,
>   			_("dropping %s %s -- patch contents already upstream\n"),
>   			oid_to_hex(&commit->object.oid), msg.subject);
>   	} /* else allow == 0 and there's nothing special to do */
> +
> +	if (!res && opts->trailer_args.nr && !drop_commit) {
> +		const char *trailer_file =
> +			msg_file ? msg_file : git_path_merge_msg(r);
> +
> +		if (amend_file_with_trailers(trailer_file,
> +						&opts->trailer_args)) {
> +			res = error(_("unable to add trailers to commit message"));
> +			goto leave;
> +		}
> +	}
> +
>   	if (!opts->no_commit && !drop_commit) {
>   		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
>   			res = do_commit(r, msg_file, author, reflog_action,
> diff --git a/sequencer.h b/sequencer.h
> index 719684c8a9..e21835c5a0 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -44,6 +44,7 @@ struct replay_opts {
>   	int record_origin;
>   	int no_commit;
>   	int signoff;
> +	struct strvec trailer_args;
>   	int allow_ff;
>   	int allow_rerere_auto;
>   	int allow_empty;
> @@ -82,8 +83,9 @@ struct replay_opts {
>   	struct replay_ctx *ctx;
>   };
>   #define REPLAY_OPTS_INIT {			\
> -	.edit = -1,				\
>   	.action = -1,				\
> +	.edit = -1,				\
> +	.trailer_args = STRVEC_INIT, \
>   	.xopts = STRVEC_INIT,			\
>   	.ctx = replay_ctx_new(),		\
>   }
> diff --git a/t/meson.build b/t/meson.build
> index 401b24e50e..990e8ad4be 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -384,6 +384,7 @@ integration_tests = [
>     't3436-rebase-more-options.sh',
>     't3437-rebase-fixup-options.sh',
>     't3438-rebase-broken-files.sh',
> +  't3440-rebase-trailer.sh',
>     't3500-cherry.sh',
>     't3501-revert-cherry-pick.sh',
>     't3502-cherry-pick-merge.sh',
> diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
> new file mode 100755
> index 0000000000..b1c7b03330
> --- /dev/null
> +++ b/t/t3440-rebase-trailer.sh
> @@ -0,0 +1,94 @@
> +#!/bin/sh
> +#
> +
> +test_description='git rebase --trailer integration tests
> +We verify that --trailer works with the merge backend,
> +and that it is rejected early when the apply backend is requested.'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
> +
> +create_expect() {
> +	cat >"$1" <<-EOF
> +	$2
> +
> +	Reviewed-by: Dev <dev@example.com>
> +	EOF
> +}
> +
> +test_expect_success 'setup repo with a small history' '
> +	git commit --allow-empty -m "Initial empty commit" &&
> +	test_commit first file a &&
> +	test_commit second file &&
> +	git checkout -b conflict-branch first &&
> +	test_commit file-2 file-2 &&
> +	test_commit conflict file &&
> +	test_commit third file &&
> +	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
> +	create_expect initial-signed  "Initial empty commit" &&
> +	create_expect first-signed    "first"                 &&
> +	create_expect second-signed   "second"                &&
> +	create_expect file2-signed    "file-2"                &&
> +	create_expect third-signed    "third"                 &&
> +	create_expect conflict-signed "conflict"
> +'
> +
> +test_expect_success 'apply backend is rejected with --trailer' '
> +	head_before=$(git rev-parse HEAD) &&
> +	test_expect_code 128 \
> +	git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
> +				HEAD^ 2>err &&
> +	test_grep "requires the merge backend" err &&
> +	test_cmp_rev HEAD $head_before
> +'
> +
> +test_expect_success 'reject empty --trailer argument' '
> +	git reset --hard third &&
> +	test_expect_code 128 git rebase -m --trailer "" HEAD^ 2>err &&
> +	test_grep "empty --trailer" err
> +'
> +
> +test_expect_success 'reject trailer with missing key before separator' '
> +	git reset --hard third &&
> +	test_expect_code 128 git rebase -m --trailer ": no-key" HEAD^ 2>err &&
> +	test_grep "missing key before separator" err
> +'
> +
> +test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
> +	git reset --hard third &&
> +	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 &&
> +	git cat-file commit HEAD | grep "^Bug: 456" &&
> +	git cat-file commit HEAD | grep -v "^Bug: 123"
> +'
> +
> +test_expect_success 'multiple Signed-off-by trailers all preserved' '
> +	git reset --hard third &&
> +	git rebase -m \
> +		--trailer "Signed-off-by: Dev A <a@ex.com>" \
> +		--trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&
> +	git cat-file commit HEAD | grep -c "^Signed-off-by:" >count &&
> +	test "$(cat count)" = 2   # two new commits
> +'
> +
> +test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
> +	git reset --hard third &&
> +	test_must_fail git rebase -m \
> +		--trailer "Reviewed-by: Dev <dev@example.com>" \
> +		second third &&
> +	git checkout --theirs file &&
> +	git add file &&
> +	git rebase --continue &&
> +	test_commit_message HEAD~2 file2-signed
> +'
> +
> +test_expect_success 'rebase --root --trailer updates every commit' '
> +	git checkout first &&
> +	git rebase --root --keep-empty \
> +		--trailer "Reviewed-by: Dev <dev@example.com>" &&
> +	test_commit_message HEAD   first-signed &&
> +	test_commit_message HEAD^  initial-signed
> +'
> +test_done

