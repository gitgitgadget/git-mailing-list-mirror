Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3591F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbeI1EW6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:22:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34824 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeI1EW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:22:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so309399wmc.0
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=p6UECZFDcIgTZ/YyZZ/n5FlprboXHgFHmA+tMXl3RWI=;
        b=BtaW829jcu9DfLV9Bo0SThvVjn7DqjB+84j2L96R4Qc3eJrYR/bGucqLHkw4HZs78f
         3xjTOnFUJWOQ/9MuttnhvDAzGmLnQrl8yqcYfWdpxXSDX1P7Vuo0wLGGgQv8AEGACp/v
         4oSgRPxYuVcQWoMAjGv7CT0bnBgZ7LEqIXuZGfLkOZvh2/odaWA+BUFBSkUvSs37OJif
         BFEVEzouG/nscgOaopsMl4oKIoLMmakNqOGeH6PYExNzowyRgLTz1AuO6csq7m+sE7SG
         FMOG6notBG2/NCwcXcLgqIRiCQOkb3Nhl5k7cJQw+jHC3gafDGAiBYde0RM1PkikU3AD
         juQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=p6UECZFDcIgTZ/YyZZ/n5FlprboXHgFHmA+tMXl3RWI=;
        b=TXY2r8GRtKsRrAS9v9ADKwNWC4k7a/ckQn4QRY2/vSl4QjGVUnao8fwvvutbtasRxU
         i37mjG4kQaF8uD48jQ11vnEJ5bSevRwvzMHHClaoUyfBknNWrBrm1UMKJPzzTxcr35H4
         OoAiP+joIzaHwSKlGkg90vl5YdRTmse68ln3NPWQ0YdzOHXddmofOrXtSgix/HvsB/+n
         zgye6m5opJ7YtcDly1Hd4Vcbr2y0jCt3aUXl6TNkDwjpcLH7LHCziO+WFD2oXISi6sb9
         AyavF8d8H8Fyi7Q56eyDIt/0+TLQY6ESO0NxweWA70eShdSUZ55KkdM9A/Ekg/3b6uDZ
         uRjw==
X-Gm-Message-State: ABuFfoidDAyiwv/7IrUYADH2+OBC1JOCTwY1qUB4+Gozs2LX3l8fiff6
        cY4RnJTEpO5fvbD8xlH7bjA=
X-Google-Smtp-Source: ACcGV60fqYjL3La0y6QkmJWccoCylEMBeiumkLn8NifSPkYXdD3km1wC65Ntu/vB1WC1yYfc25Xi3w==
X-Received: by 2002:a1c:d712:: with SMTP id o18-v6mr353870wmg.54.1538085750621;
        Thu, 27 Sep 2018 15:02:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 11-v6sm4512125wrb.95.2018.09.27.15.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:02:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sam McKelvie <sammck@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: Alllow staged changes for get_superproject_working_tree
References: <20180927181054.25802-1-sammck@gmail.com>
Date:   Thu, 27 Sep 2018 15:02:29 -0700
In-Reply-To: <20180927181054.25802-1-sammck@gmail.com> (Sam McKelvie's message
        of "Thu, 27 Sep 2018 11:10:54 -0700")
Message-ID: <xmqqbm8ifvka.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam McKelvie <sammck@gmail.com> writes:

> Subject: Re: [PATCH] submodule: Alllow staged changes for get_superproject_working_tree

s/Alllow/allow/;

> Invoking 'git rev-parse --show-superproject-working-tree' exits with
>
>     "fatal: BUG: returned path string doesn't match cwd?"
>
> when the superproject has an unmerged entry for the current submodule,
> instead of displaying the superproject's working tree.
>
> The problem is due to the fact that when a merge of the submodule reference
> is in progress, "git ls-files --stage —full-name <submodule-relative-path>”
> returns three seperate entries for the submodule (one for each stage) rather
> than a single entry; e.g.,
>
> $ git ls-files --stage --full-name submodule-child-test
> 160000 dbbd2766fa330fa741ea59bb38689fcc2d283ac5 1       submodule-child-test
> 160000 f174d1dbfe863a59692c3bdae730a36f2a788c51 2       submodule-child-test
> 160000 e6178f3a58b958543952e12824aa2106d560f21d 3       submodule-child-test
>
> The code in get_superproject_working_tree() expected exactly one entry to
> be returned; this patch makes it use the first entry if multiple entries
> are returned.
>
> Test t1500-rev-parse is extended to cover this case.
>
> Signed-off-by: Sam McKelvie <sammck@gmail.com>
> ---
>  submodule.c          |  2 +-
>  t/t1500-rev-parse.sh | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 33de6ee5f..5b9d5ad7e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1885,7 +1885,7 @@ const char *get_superproject_working_tree(void)
>  		 * We're only interested in the name after the tab.
>  		 */
>  		super_sub = strchr(sb.buf, '\t') + 1;
> -		super_sub_len = sb.buf + sb.len - super_sub - 1;
> +		super_sub_len = strlen(super_sub);

As we are reading from "ls-files -z -s", we know that the name is
terminated with NUL, so we can just use strlen().  Good.
>  
>  		if (super_sub_len > cwd_len ||
>  		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 5c715fe2c..b774cafc5 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -134,7 +134,6 @@ test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
>  test_expect_success 'showing the superproject correctly' '
>  	git rev-parse --show-superproject-working-tree >out &&
>  	test_must_be_empty out &&
> -

I have a feeling that this break made the series of tests in this
block easier to follow.  Shouldn't we be moving in the other
direction, namely ...

>  	test_create_repo super &&
>  	test_commit -C super test_commit &&
>  	test_create_repo sub &&
> @@ -142,6 +141,22 @@ test_expect_success 'showing the superproject correctly' '
>  	git -C super submodule add ../sub dir/sub &&
>  	echo $(pwd)/super >expect  &&
>  	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
> +	test_cmp expect out &&

Here is an end of one subtest, deserves to have a break like the above.

> +	test_commit -C super submodule_add &&
> +	git -C super checkout -b branch1 &&
> +	git -C super/dir/sub checkout -b branch1 &&
> +	test_commit -C super/dir/sub branch1_commit &&
> +	git -C super add dir/sub &&
> +	test_commit -C super branch1_commit &&
> +	git -C super checkout master &&
> +	git -C super checkout -b branch2 &&
> +	git -C super/dir/sub checkout master &&
> +	git -C super/dir/sub checkout -b branch2 &&
> +	test_commit -C super/dir/sub branch2_commit &&
> +	git -C super add dir/sub &&
> +	test_commit -C super branch2_commit &&
> +	test_must_fail git -C super merge branch1 &&

and all of the above is just a set-up for another subtest, so a
solid block of text like we see in the above is good.

	Side note: there are a few of

		git -C $there checkout $onebranch &&
		git -C $there checkout -b $anotherbranch &&

	as recurring pattern.  Shouldn't they be more like a single
	liner

		git -C $there checkout -b $anotherbranch $onebranch &&

	?  It wasn't clear if the split was an attempt to hide some
	breakage (e.g. "checkout -b B A" did not work but "checkout
	A && checkout -b B" did) or just being verbose because the
	author is not used to "checkout -b B A" form.

> +	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
>  	test_cmp expect out
>  '

Thanks.
