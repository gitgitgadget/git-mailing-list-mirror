Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252401F404
	for <e@80x24.org>; Thu, 30 Aug 2018 22:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeHaCMG (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 22:12:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36974 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeHaCMG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 22:12:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so9392518wrr.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 15:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jsjxOPJ5xzogzxIMThzBZuUFA+UkVKpOJqfgjd4o568=;
        b=n8ubRjqp0Noq9WsFyePlTyA51y3Z+mNPRqli33NUn4raS+u44eTQ3jUab4BQPd7GDD
         2QaIvmC6BWDN91MCgWt5YtkW6M7lU1A78qGnhj9MSIAVpoFDbQLtYzt/Enl7Kdj1alUI
         RSiaaK5oCWgmBtdzO+gnA8oSi7bXI0PIy2ee9hN4z8uBgi4Kzzkv6P+hrtccIUlDCyL7
         qYpdBc/BAc5ztk1SsV6ih6xTV9syLZ8LbrdJVhNjDXGWC/c1RR8ii+G+CJlcBsEhUwcD
         xRf5dq7/wc8pumtlTsja4EAYf1B6gjiGuDTHujsm0Kw57E5v5OzL0zr6d3J2HkXl/ip1
         9iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jsjxOPJ5xzogzxIMThzBZuUFA+UkVKpOJqfgjd4o568=;
        b=eIKREx/GLeo82JxrwwimUVSi0mk+04SVqOCwq8x2clf37u8KeHpWdQaqTMmGzqrBjY
         r5VAxZGej+QLJ8S7vNAkRBNQ+ItCzDg31IepxeDi64NKEahpra7bxuSPdQUZihXOfiUi
         CONV98prRqZ5ayRND9DROB68dpcAGSJIHZTf9btDLFlthJvDwu8Pd5YL7CphevxHLCwa
         hGGghjPtlzXmbAyPO0hfhqpVCkn6ebltbQrVGCjWJWvU4qgM1O3N+rAyDOEofxoUdL1k
         PleDa4+XP8FxRPzmvPVS8iFVqEquzwsjiOvfrd6r+mv0grBmDocIUwEirw4ecz318VGF
         azWA==
X-Gm-Message-State: APzg51AiF0tuM630Sd4mjUw4435y0W9XFXb1Xefv3zmSp2DhSg+vqhmC
        78tQ1VJAj3cykPXCAJjU3ic=
X-Google-Smtp-Source: ANB0VdZgeqcraa8ofaDI8kyJS90nllSBFyfq8ffEinsk+RH1Ig0Mfatw8tcMWff5NCbuW4zp2NPJ7A==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10-v6mr8822508wrt.48.1535666866516;
        Thu, 30 Aug 2018 15:07:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g2-v6sm18422900wrd.71.2018.08.30.15.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 15:07:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 05/20] stash: add tests for `git stash show` config
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
        <65603caf56cfaeb1dff92546b7efe38dccb2d071.1535665109.git.ungureanupaulsebastian@gmail.com>
Date:   Thu, 30 Aug 2018 15:07:43 -0700
In-Reply-To: <65603caf56cfaeb1dff92546b7efe38dccb2d071.1535665109.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Fri, 31 Aug 2018 00:40:35
        +0300")
Message-ID: <xmqqpnxz33v4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> This commit introduces tests for `git stash show`
> config. It tests all the cases where `stash.showStat`
> and `stash.showPatch` are unset or set to true / false.
>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  t/t3907-stash-show-config.sh | 81 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100755 t/t3907-stash-show-config.sh
>
> diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
> new file mode 100755
> index 0000000000..8fe369c1a1
> --- /dev/null
> +++ b/t/t3907-stash-show-config.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +
> +test_description='Test git stash show configuration.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit file
> +'
> +
> +# takes three parameters:
> +# 1. the stash.showStat value (or "<unset>")
> +# 2. the stash.showPatch value (or "<unset>")
> +# 3. the diff options of the expected output (or nothing for no output)
> +test_stat_and_patch () {
> +	if test "<unset>" = "$1"
> +	then
> +		test_might_fail git config --unset stash.showStat
> +	else
> +		test_config stash.showStat "$1"
> +	fi &&
> +
> +	if test "<unset>" = "$2"
> +	then
> +		test_might_fail git config --unset stash.showPatch

I think you are trying to protect yourself from an error triggered
by unsetting what is not set, but for that, test_unconfig is
probably a better choice, as it still catches errors of other types
and ignores only that "unset a variable that is not set" error.

> +	else
> +		test_config stash.showPatch "$2"
> +	fi &&
> +
> +	shift &&
> +	shift &&

You can use "shift 2 &&" here (not worth a reroll).

> +	echo 2 >file.t &&

> +	git diff "$@" >expect &&

When the caller does not give $3 to this function, it does not look
at 'expect'.  I think it is clearer if you did

	if test $# != 0
	then
		git diff "$@" >expect
	fi &&

here, and ...

> +	git stash &&
> +	git stash show >actual &&
> +
> +	if test -z "$1"

... wrote this as

	if test $# = 0

The only difference between '-z "$1"' and '$# = 0' is when he caller
passes an empty string to the function as $3, which you never do, so
the distinction is theoretical, but using $# makes your intention
clear that you do not mean to treat an empty string any specially.

> +	then
> +		test_must_be_empty actual
> +	else
> +		test_cmp expect actual
> +	fi
> +}
> +
> +test_expect_success 'showStat unset showPatch unset' '
> +	test_stat_and_patch "<unset>" "<unset>" --stat
> +'
> +
> +test_expect_success 'showStat unset showPatch false' '
> +	test_stat_and_patch "<unset>" false --stat
> +'
> +
> +test_expect_success 'showStat unset showPatch true' '
> +	test_stat_and_patch "<unset>" true --stat -p
> +'
> +
> +test_expect_success 'showStat false showPatch unset' '
> +	test_stat_and_patch false "<unset>"
> +'
> +
> +test_expect_success 'showStat false showPatch false' '
> +	test_stat_and_patch false false
> +'
> +
> +test_expect_success 'showStat false showPatch true' '
> +	test_stat_and_patch false true -p
> +'
> +
> +test_expect_success 'showStat true showPatch unset' '
> +	test_stat_and_patch true "<unset>" --stat
> +'
> +
> +test_expect_success 'showStat true showPatch false' '
> +	test_stat_and_patch true false --stat
> +'
> +
> +test_expect_success 'showStat true showPatch true' '
> +	test_stat_and_patch true true --stat -p
> +'
> +
> +test_done
