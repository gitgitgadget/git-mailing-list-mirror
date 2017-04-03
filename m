Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A231A2096C
	for <e@80x24.org>; Mon,  3 Apr 2017 16:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbdDCQ0w (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 12:26:52 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35014 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdDCQ0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 12:26:51 -0400
Received: by mail-pg0-f44.google.com with SMTP id 81so125308989pgh.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i2PmMgyweGrb2eQPFCuPWO51ENKa9YxcnT738o4NEJc=;
        b=oR4FKoNNTivEBJsGHbLVEJNh8JFyykDfspZ6DWH2bXq1y1rOadvXwuNE/5dqtDuNna
         T2Y2hF6tlDaRiHJzn50TkHQ/qgPRSYHebVjmO9CBUVtV/hIkkVJTW65f9mxy93OfUAVM
         insw3HjiRMNV/T9sNiI22tmxQ3UQCQ8kK4MX+cN+wwUOO5Mz7BfhmF3iaO2wAzY00NM8
         mnomCJ4tRq+YG+VHyJaL+ZyjkQEIsjPgmUINT1QQwVOrNh6F8ywbMSMqzNO3RGCoZwcR
         f09J6Rla5x7rSwTEDWVT2BOvedriznEGmQzCxerhsxjJSwvaa3lN0zn+TqqoG5tiJPlL
         PS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i2PmMgyweGrb2eQPFCuPWO51ENKa9YxcnT738o4NEJc=;
        b=PMQyMteIBp/ai0Rh96Y07zKe0NwnDt8ySOemuf6C3+Y4sJg9qrmVi6hipWyQPxgxaQ
         hiSETaAVsIgf3YHd1Ehm9pY4jaTI0R4caiXmXVjPmRUz/gxdqUN/mrK/Qq0Z4kEee+xl
         lDtxNfUYt3Dn+dCMRPLhqKH7qG8f4zkGKK5V3HhaIW/3fAgC4lqpsaGOZbsmJv2gvf6D
         MkEnhKdcJp2TZWPiEqyekrGF5dl5wLSC9ZTT6CnA/D6gTqHKFniYz+JrXow/KRjO4nhC
         17yJkc4/C85sTmdmBlZTuevTLQoDtdtoImD4OZj/Xgohby+niZI6aO8cqQFZwpIqoR8n
         vbjw==
X-Gm-Message-State: AFeK/H3Fh8hQ0dPiS8Jx8qmoOv6svLage1VBUe2j1SJYAoBNES3pObzZRGdpQjl7Y6oQakLM
X-Received: by 10.84.128.75 with SMTP id 69mr22784576pla.111.1491236810326;
        Mon, 03 Apr 2017 09:26:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:144b:fae7:978a:983f])
        by smtp.gmail.com with ESMTPSA id z25sm26912900pfi.28.2017.04.03.09.26.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Apr 2017 09:26:49 -0700 (PDT)
Date:   Mon, 3 Apr 2017 09:26:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: always honor `PATHSPEC_PREFIX_ORIGIN` flag
Message-ID: <20170403162648.GA166794@google.com>
References: <1556910880cfce391bdca2d8f0cbcb8c71371691.1491206540.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556910880cfce391bdca2d8f0cbcb8c71371691.1491206540.git.ps@pks.im>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/03, Patrick Steinhardt wrote:
> Previous to commit 5d8f084a5 (pathspec: simpler logic to prefix original
> pathspec elements, 2017-01-04), we were always using the computed
> `match` variable to perform pathspec matching whenever
> `PATHSPEC_PREFIX_ORIGIN` is set. This is for example useful when passing
> the parsed pathspecs to other commands, as the computed `match` may
> contain a pathspec relative to the repository root. The commit changed
> this logic to only do so when we do have an actual prefix and when
> literal pathspecs are deactivated.
> 
> But this change may actually break some commands which expect passed
> pathspecs to be relative to the repository root. One such case is `git
> add --patch`, which now fails when using relative paths from a
> subdirectory. For example if executing "git add -p ../foo.c" in a
> subdirectory, the `git-add--interactive` command will directly pass
> "../foo.c" to `git-ls-files`. As ls-files is executed at the
> repository's root, the command will notice that "../foo.c" is outside
> the repository and fail.
> 
> Fix the issue by again using the computed `match` variable whenever
> `PATHSPEC_PREFIX_ORIGIN` is set. This restores behavior previous to
> 5d8f084a5 and fixes interactive add.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pathspec.c                 |  6 +++---
>  t/t3701-add-interactive.sh | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 303efda83..3193e45a6 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -504,12 +504,12 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
>  	 * Prefix the pathspec (keep all magic) and assign to
>  	 * original. Useful for passing to another command.
>  	 */
> -	if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
> -	    prefixlen && !get_literal_global()) {
> +	if (flags & PATHSPEC_PREFIX_ORIGIN) {
>  		struct strbuf sb = STRBUF_INIT;
>  
>  		/* Preserve the actual prefix length of each pattern */
> -		prefix_magic(&sb, prefixlen, element_magic);
> +		if (prefixlen && !get_literal_global())
> +			prefix_magic(&sb, prefixlen, element_magic);
>  
>  		strbuf_addstr(&sb, match);
>  		item->original = strbuf_detach(&sb, NULL);

Would it just make sense to drop the requirement that prefixlen be
non-zero?  My problem with this change currently is the ability to get
an original string with is empty (ie "\0") which would cause git to
throw some warnings about not allowing empty strings as pathspecs if
they were then passed on to other processes.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index f9528fa00..640088dd6 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -436,6 +436,26 @@ test_expect_success 'add -p handles globs' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'add -p handles relative paths' '
> +	git reset --hard &&
> +
> +	echo base >root.c &&
> +	git add "*.c" &&
> +	git commit -m base &&
> +
> +	echo change >root.c &&
> +	mkdir -p subdir &&
> +	git -C subdir add -p "../root.c" <<-\EOF &&
> +	y
> +	EOF
> +
> +	cat >expect <<-\EOF &&
> +	root.c
> +	EOF
> +	git diff --cached --name-only >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'add -p does not expand argument lists' '
>  	git reset --hard &&
>  
> -- 
> 2.12.2
> 

-- 
Brandon Williams
