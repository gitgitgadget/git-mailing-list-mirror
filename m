Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC9B201A4
	for <e@80x24.org>; Fri, 12 May 2017 05:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbdELFGG (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 01:06:06 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36687 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdELFGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 01:06:04 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so1444784pge.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 22:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=B5PJuvBF1C1KCpIF+Pr2F7Ir5e/5Yr/pK0L6rrsxsII=;
        b=QweQLWn3hgp33Y7gKXoohlu/RCDXtwUpZZWtU8PwGT9bnqb5ZR5yY6pBs8Uh+eks9U
         SOL0iGXZG8WG0SbjNJD9wMDkk9f27t8tWZn6DYu2GwBOGPzzPjqaE+EMVAV7Z6ea2r9C
         2DJLYepaDoqkzCXu63SaM614fiDSzNDAA09ppXHIKsL8z0H58EDpwVKAdbpKhC8e7VFL
         FmpWghXHaOuXHGN4G5rQHAzTK4Hwh+GQD8jTCWH1wnn9IsanmOgpr4BtmpF6S6siLZkn
         tqJxXNb7YS2S4CCwub4OQMbtRquvTxRgss6RzzD/4ESTV/k5F/nllWe9zM2mOGu7hcMk
         oDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=B5PJuvBF1C1KCpIF+Pr2F7Ir5e/5Yr/pK0L6rrsxsII=;
        b=kIDGVR/XZZVWOAEf5irEuBc7mK+unuXMQkdLAeNhJeGaZoVbedpTZNgbo3WENgq3pN
         kROBo3ON2ZuomWLL3YDtgx6JShJCrz0QPPokzW+r1TVPeYqFDmo9eOso8GzVBZfK8Jnd
         kcbOC+HVYDZWzYadlyN/kmikkWv3RagHTgqV9LniO5CiJwM7FzlyzB4MSNPEOxAhuOC5
         8F92xd3AgHTn4lfM8tKTmqYgqCCrcu1nCQXFOQLI4ZRgiyvAIDigSaGbM07sTnNvxQDR
         rvKIrKVrgK1YwnYd2V6OkJzVTEogaF4I8ojSCVGB2F9RfM7EGJAHl3WpPgbOeAwx+RD8
         qKwQ==
X-Gm-Message-State: AODbwcB557udPK9LZkstAampMoESLYQGIfVZsO1ORQqZV9V6lsTjAFfB
        F2Jj+Eq5Ol4ndQ==
X-Received: by 10.99.115.71 with SMTP id d7mr2364827pgn.153.1494565564144;
        Thu, 11 May 2017 22:06:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id o76sm3051215pfi.119.2017.05.11.22.06.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 22:06:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 11/29] grep: add a test helper function for less verbose -f \0 tests
References: <20170511091829.5634-1-avarab@gmail.com>
        <20170511091829.5634-12-avarab@gmail.com>
Date:   Fri, 12 May 2017 14:06:02 +0900
In-Reply-To: <20170511091829.5634-12-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 11 May 2017 09:18:11 +0000")
Message-ID: <xmqqlgq27jgl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add a helper function to make the tests which check for patterns with
> \0 in them more succinct. Right now this isn't a big win, but
> subsequent commits will add a lot more of these tests.
>
> The helper is based on the match() function in t3070-wildmatch.sh.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t7008-grep-binary.sh | 58 +++++++++++++++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
> index 9c9c378119..6c1952eafa 100755
> --- a/t/t7008-grep-binary.sh
> +++ b/t/t7008-grep-binary.sh
> @@ -4,6 +4,29 @@ test_description='git grep in binary files'
>  
>  . ./test-lib.sh
>  
> +nul_match() {

Micronit: "nul_match () {"

> +	status=$1
> +	flags=$2
> +	pattern=$3
> +	pattern_human=$(echo $pattern | sed 's/Q/<NUL>/g')

Double quote around "$pattern"?

> +
> +	if test $status = "1"

Double quote around "$status" and drop double quote around "1"
(which is clearly a literal string without any funnies) instead?

> +	then
> +		test_expect_success "git grep -f f $flags '$pattern_human' a" "
> +			printf '$pattern' | q_to_nul >f &&
> +			git grep -f f $flags a
> +		"
> +	elif test $status = "0"
> +	then
> +		test_expect_success "git grep -f f $flags '$pattern_human' a" "
> +			printf '$pattern' | q_to_nul >f &&
> +			test_must_fail git grep -f f $flags a
> +		"

It somehow was unintuitive that 0 expected failure and 1 expected
success, but it probably was just me.
