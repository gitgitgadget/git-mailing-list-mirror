Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6831211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 13:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeL0NUh (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 08:20:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43977 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeL0NUh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 08:20:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so20052932qtj.10
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 05:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZfLW69ESe5vDDyuvrusbcSwwci+x+RqyoPN8+6aSbsY=;
        b=RXwTpz+V8YjisqPa5s0k5a1yYdjlvYHOkgeGtaJrdBwZL/ywc+AwSveTwaIZOLCiPa
         9cOcYFjWo4vNvrMMc6r4Myu19OuAXBFHDD6UQgYmHAiRqspG/EnVWBKna7lM72E7lR3C
         ds0WKVY9tKfDsbH6l0Fzo0u7L7c9k0n9GIPa15L1KDexMLNCV4OOxQxMbspmhhAyuX0v
         o8w5Gd/zTpNlhN9ZQZNCZ1un3/Yp/XhcpB0rIoaqUSv8dVAMi73fPj+x7qJY1JpAzwZ5
         tlNEU26D19t46tnBniJFmXXJaBtw6ioWzvYUCJBdkRUD7MFbjAkNkqCLKHO05xMg2GJY
         R5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZfLW69ESe5vDDyuvrusbcSwwci+x+RqyoPN8+6aSbsY=;
        b=AgCHC2lVXffFLt4IZhW9CYag/zhXLtsYVaq60VzjpA3Ky1UAUG807vpi2wC4bqgXTC
         Q03H0p0hC54Stq99M++JqPo6v7eiN+XxIoLiia9QZ7zrpf8CHLFkSoGRB4fZk6xaYuvy
         CPly8DvVXXtcyKjfY3DMZzBtnXFVNYGsibADmHbjl0NmlWx9CwrCQuMumtDChfk1uY/G
         1qvCxlZXcFmHUCWASqNMrFJsXIYDo9ID4jCc6RlS3OOLleh4Um6cdz0zkKQ2FcIwHM+d
         WbifGGAMO75/OrF7v8uixhlUhAGcv/WZox4sKPqqM6L7dAKdzlDBoL7+2DuQCyrZwmlU
         boFQ==
X-Gm-Message-State: AA+aEWZz/NAFld9RDygUbM4pMTIgL34he97Qs2n9MYwxUVlL43ctpgkB
        qhUl/CkGIUk7L6dKwfWwb2MZjqTF
X-Google-Smtp-Source: AFSGD/W7iWVNN5FPplmJog9cvobK7OZBtv6kIAeCDd2yGU2a4crjSv8bk6pqCDg3+HRus99wnwAM/w==
X-Received: by 2002:ac8:46c6:: with SMTP id h6mr22289770qto.315.1545916834481;
        Thu, 27 Dec 2018 05:20:34 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id o42sm17559086qtc.90.2018.12.27.05.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 05:20:33 -0800 (PST)
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     issac.trotts@gmail.com, git@vger.kernel.org
Cc:     noemi@sourcegraph.com, Issac Trotts <issactrotts@google.com>
References: <20181219083305.2500-1-issac.trotts@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5dfd92d1-2e87-3006-1630-a33794b6066b@gmail.com>
Date:   Thu, 27 Dec 2018 08:20:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181219083305.2500-1-issac.trotts@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/2018 3:33 AM, issac.trotts@gmail.com wrote:
> From: Issac Trotts <issac.trotts@gmail.com>
>
> Make it possible to write for example
>
>          git log --format="%H,%S"
>
> where the %S at the end is a new placeholder that prints out the ref
> (tag/branch) for each commit.
>
> Using %d might seem like an alternative but it only shows the ref for the last
> commit in the branch.
>
> Signed-off-by: Issac Trotts <issactrotts@google.com>
>
> ---
>
> This change is based on a question from Stack Overflow:
> https://stackoverflow.com/questions/12712775/git-get-source-information-in-format
> ---
>   Documentation/pretty-formats.txt |  2 ++
>   builtin/log.c                    |  2 +-
>   log-tree.c                       |  1 +
>   pretty.c                         | 15 ++++++++++
>   pretty.h                         |  1 +
>   t/t4205-log-pretty-formats.sh    | 50 ++++++++++++++++++++++++++++++++
>   6 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 417b638cd..de6953108 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -134,6 +134,8 @@ The placeholders are:
>   - '%cI': committer date, strict ISO 8601 format
>   - '%d': ref names, like the --decorate option of linkgit:git-log[1]
>   - '%D': ref names without the " (", ")" wrapping.
> +- '%S': ref name given on the command line by which the commit was reached
> +  (like `git log --source`), only works with `git log`

This "only works with `git log`" made me think about what would happen 
with `git rev-list --pretty=format:"%h %S"` and the answer (on my 
machine) was a segfault.

>   - '%e': encoding
>   - '%s': subject
>   - '%f': sanitized subject line, suitable for a filename
> diff --git a/builtin/log.c b/builtin/log.c
> index e8e51068b..be3025657 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>   	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
>   		rev->always_show_header = 0;
>   
> -	if (source) {
> +	if (source || (rev->pretty_given && (rev->commit_format == CMIT_FMT_USERFORMAT) && w.source)) {
>   		init_revision_sources(&revision_sources);
>   		rev->sources = &revision_sources;
>   	}

Likely, you'll want to duplicate this initialization in the revision 
machinery. Keep this one in builtin/log.c as it was before, but add 
something like this initialization to setup_revisions(). Add a test for 
rev-list.

[snip]

> @@ -1194,6 +1195,17 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>   		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
>   		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
>   		return 1;
> +	case 'S':		/* tag/branch like --source */
> +		if (c->pretty_ctx->rev->sources == NULL) {
Use "if (!c->pretty_ctx->rev->sources".
> +			return 0;
> +		}
> +		slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
> +		if (slot && *slot) {
I'm not sure this check for 'slot' being non-null is necessary, as we 
would already get a failure in the commit-slab code (for 
revision_sources_at()) if the slab is not initialized.
> +			strbuf_addstr(sb, *slot);
> +			return 1;
> +		} else {
> +			die(_("failed to get info for %%S"));

Here, you die() when you fail to get a slot but above you return 0 when 
the sources are not initialized.

I don't see another use of die() in this method. Is that the right way 
to handle failure here? (I'm legitimately asking because I have 
over-used 'die()' in the past and am still unclear on when it is 
appropriate.)

>   '
>   
> +test_expect_success 'set up %S tests' '
> +	git checkout --orphan source-a &&
> +	test_commit one &&
> +	test_commit two &&
> +	git checkout -b source-b HEAD^ &&
> +	test_commit three
> +'
> +
> +test_expect_success 'log --format=%S paints branch names' '
> +	cat >expect <<-\EOF &&
> +	source-b
> +	source-a
> +	source-b
> +	EOF
> +	git log --format=%S source-a source-b >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --format=%S paints tag names' '
> +	git tag -m tagged source-tag &&
> +	cat >expect <<-\EOF &&
> +	source-tag
> +	source-a
> +	source-tag
> +	EOF
> +	git log --format=%S source-tag source-a >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'log --format=%S paints symmetric ranges' '
> +	cat >expect <<-\EOF &&
> +	source-b
> +	source-a
> +	EOF
> +	git log --format=%S source-a...source-b >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '%S in git log --format works with other placeholders (part 1)' '
> +	git log --format="source-b %h" source-b >expect &&
> +	git log --format="%S %h" source-b >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '%S in git log --format works with other placeholders (part 2)' '
> +	git log --format="%h source-b" source-b >expect &&
> +	git log --format="%h %S" source-b >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done

Please also add a simple test to t6006-rev-list-format.sh.

Thanks,

-Stolee

