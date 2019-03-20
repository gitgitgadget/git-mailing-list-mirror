Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0A620248
	for <e@80x24.org>; Wed, 20 Mar 2019 23:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCTXJq (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 19:09:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37639 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 19:09:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so2997159pfr.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RwP2MYnur0hG3kfHaVleQYeg3YDBmzJ/yYJ1c50vMmo=;
        b=ohrCV8HfyXEgLfkEahLmEEnpaJx2xeza3mlF7YwOEblcLIK29z8ya6vkaOd3ArctTQ
         QQPJA6o83yybYOwBWBKmbt1/cfMlBAgr1DZQQHooQ+cn4zxjOeTimoS2oM3x0HvyBUEj
         Lo5Heo8yL7NExLv6Dq1s09IEHhLvDcltp0q/WXpa6tboknViJDVwLnnRS2R4i1pVwxql
         N4wwrmkWnIxVaeiauCs/Pjoswf0XH54KORmSzSykC13RzkG+4P/j19EgQlCE7NAeAcpO
         W9VN9syPP5cjEaVVY9+CkWB/pxTBaRPh7Sxwh7jncQ99TkvHNz06ZzxhmaE0jeCSYpYl
         a8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RwP2MYnur0hG3kfHaVleQYeg3YDBmzJ/yYJ1c50vMmo=;
        b=R+fhF+y+Y6WjAhnGZmhmx658w2GJwCRCpjN0zdfbjdSM/NH6QNzL+ieY2beUAlSFi2
         3X5XHhV8qpslhiQ6adatQOmdlmye954yd0TksB8pOXWs6qvJ5qZ7MJA3os7SLoL+lS4W
         bG74sHCbQ94ISDe0zrfkDxo2BBdKZxbTKtv10WTiSmq5bDEQyEYBdc5a3zWrP/+dpDBF
         5v85evzdG9tj5oBYHtWaDb0EFi8kdtD7RHd8GSaRlc/Iq7IUl5THq/AIeHPO5NsZrdCO
         4MQxMHZ2D3A06JtATR5JDfJ6j8G2+FzDh3OQrbp+wQLcSohLEfQs4n0M8jj9Y26X/t+i
         d8pw==
X-Gm-Message-State: APjAAAVGkPkLIrEiul8bbvv0meFYKxGU5JdPSnEfrFvjyP8vQSeNTXlR
        LmwTi9/ZDTFYWRW+iC8s8lI=
X-Google-Smtp-Source: APXvYqyc3i38CFB8ypdRC6jKk84I2uSITvzFToaFl6BnF+YS6aFXjIQjYpUQ+otZhDfo64wSDqH7Dg==
X-Received: by 2002:a65:4348:: with SMTP id k8mr453612pgq.289.1553123385079;
        Wed, 20 Mar 2019 16:09:45 -0700 (PDT)
Received: from dev-l ([4.16.198.204])
        by smtp.gmail.com with ESMTPSA id b16sm5665828pff.44.2019.03.20.16.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 16:09:44 -0700 (PDT)
Date:   Wed, 20 Mar 2019 16:09:42 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] stash: setup default diff output format if necessary
Message-ID: <20190320230942.GA28455@dev-l>
References: <20190319190503.GA10066@dev-l>
 <20190319231826.GB32487@hank.intra.tgummerer.com>
 <20190320224955.GE32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320224955.GE32487@hank.intra.tgummerer.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 10:49:55PM +0000, Thomas Gummerer wrote:
> In the scripted 'git stash show' when no arguments are passed, we just
> pass '--stat' to 'git diff'.  When any argument is passed to 'stash
> show', we no longer pass '--stat' to 'git diff', and pass whatever
> flags are passed directly through to 'git diff'.
> 
> By default 'git diff' shows the patch output.  So when we a user uses
> 'git stash show --patience', they would be shown the diff as expected,
> using the patience algorithm.  '--patience' in this case only changes
> the diff algorithm, but does not cause 'git diff' to show the diff by
> itself.  The diff is shown because that's the default behaviour of
> 'git diff'.
> 
> In the C version of 'git stash show', we try to emulate that behaviour
> using the internal diff API.  However we forgot to set up the default
> output format, in case it wasn't set by any of the flags that were
> passed through.  So 'git stash show --patience' in the builtin version
> of stash would be completely silent, while it would show the diff in
> the scripted version.
> 
> The same thing would happen for other flags that only affect the way a
> patch is displayed, rather than switching to a different output format
> than the default one.
> 
> Fix this by setting up the default output format for 'git diff'.
> 
> Reported-by: Denton Liu <liu.denton@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> 
> Thanks Peff and Junio for your comments on the previous round.
> 
> Compared to v1, this uses the --patience flags for the tests now, and
> mentions only the --patience flag in the commit message.  While the
> original report was about -v, I do agree that --patience is more
> relevant here.
> 
> I think this also deserves some explanation of what didn't change,
> especially after what I said in [*1*].  We're still not using the
> 'diff_opt_parse()' option parser, as it doesn't understand '-v' for
> example.  'setup_revisions()' understands that, but 'diff_opt_parse()'
> doesn't, so we'd still have a change in behaviour at least there.
> After discovering that I gave up on that approach.
> 
> The other thing that was pointed out is the 'diff_setup_done()' call
> here.  'diff_setup_done()' is already called inside of
> 'setup_revisions()', so we don't need to do it again, unless we change
> the output format, which is what we are doing here.  In fact this is
> the same way it's implemented in 'builtin/diff.c'.
> 
> *1*: <20190320214504.GC32487@hank.intra.tgummerer.com>
> 
>  builtin/stash.c  |  4 ++++
>  t/t3903-stash.sh | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 51df092633..012662ce68 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -761,6 +761,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
>  		free_stash_info(&info);
>  		usage_with_options(git_stash_show_usage, options);
>  	}
> +	if (!rev.diffopt.output_format) {
> +		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
> +		diff_setup_done(&rev.diffopt);
> +	}
>  
>  	rev.diffopt.flags.recursive = 1;
>  	setup_diff_pager(&rev.diffopt);
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 97cc71fbaf..83926ab55b 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -612,6 +612,24 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'stash show -v shows diff' '

s/-v/--patience/

Missed this in my last email, my bad!

> +	git reset --hard &&
> +	echo foo >>file &&
> +	STASH_ID=$(git stash create) &&
> +	git reset --hard &&
> +	cat >expected <<-EOF &&
> +	diff --git a/file b/file
> +	index 7601807..71b52c4 100644
> +	--- a/file
> +	+++ b/file
> +	@@ -1 +1,2 @@
> +	 baz
> +	+foo
> +	EOF
> +	git stash show --patience ${STASH_ID} >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'drop: fail early if specified stash is not a stash ref' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD && git stash clear" &&
> -- 
> 2.21.0.226.g764ec437b0.dirty
> 
