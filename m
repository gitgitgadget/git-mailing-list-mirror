Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D4E201A7
	for <e@80x24.org>; Fri, 12 May 2017 04:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756604AbdELEsa (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 00:48:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33707 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756470AbdELEs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 00:48:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id a23so5651084pfe.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 21:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=llRqoJYiCtqkqgH7y9fbrjf3z5ZzqP7EudcPMsSEgEA=;
        b=QqI+cWsCq6U3wDWe6y+jBo5RdqaeiCKy5bZqXNYWYjcIqrR7Tw1K+I9uIAc+pz9jd6
         2kgMOiETnKWuorVkGmCwv8LN/Mzu5zAubPs/Qvi7LwQP8XQiJwEciJ8EvrKlOhLiVeNj
         b2rCaBzc8T+aJZO/jsjFXCQgy5TIRnpAnSv15b1Pt4KRZFlMABJ8vuaFpZGS3pe+w5IB
         UlDR3JYFHXnbQYg7fpGQoAZ6fTXH2HeVjoUt+EFO8fAga6+qPhRXB7t8XjLeNGc1gkT5
         z1tKoNxSkFX8eQx+bQSPuzeJweU9+cEIf0DcPsWsrEqQblc1UrmySfCEILSvSl8Pbudm
         DyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=llRqoJYiCtqkqgH7y9fbrjf3z5ZzqP7EudcPMsSEgEA=;
        b=f+MxmsFC0IRlVjK8avPMfGDL8TIYb/vDijz6W3qvOg6Yf55RPKmFRvCKRATF2OhjSz
         S3yHNWHZJkL3hcyY6mDj490aym7iEgwgo2ZnpPPDe/mqJOHwwYF4Z4tCue277PMpwKi4
         5j6RJFA/9hNljnLHYQaefJtVoFBLzxtXlsBKCf1DxHcqXyqoP2DLs7+pzw39NuJ4cXdM
         lKs0H7BAHI7B3gzzsN252CbrW53ybfFoEfHMiErns+Xz/Xp9XnhJ15lm836qBzvn3Wg3
         O/dGADckbVmYUXQftRN9C7chtdy513RyzApwC5N6cc/VmUSmphIjrVxk4Mykp7XZsZhV
         /z2g==
X-Gm-Message-State: AODbwcC/deNvlh20QR2Yf65lDvi0RjSxD63KIGx3oze6hq6wE/8xIifO
        r3tjAfNrgpfTIw==
X-Received: by 10.84.236.12 with SMTP id q12mr3006404plk.123.1494564507425;
        Thu, 11 May 2017 21:48:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id n65sm3323584pga.8.2017.05.11.21.48.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 21:48:25 -0700 (PDT)
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
Subject: Re: [PATCH 04/29] log: add exhaustive tests for pattern style options & config
References: <20170511091829.5634-1-avarab@gmail.com>
        <20170511091829.5634-5-avarab@gmail.com>
Date:   Fri, 12 May 2017 13:48:24 +0900
In-Reply-To: <20170511091829.5634-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 11 May 2017 09:18:04 +0000")
Message-ID: <xmqqwp9m7k9z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add exhaustive tests for how the different grep.patternType options &
> the corresponding command-line options affect git-log.
> ...
> The patterns being passed to fixed/basic/extended/PCRE are carefully
> crafted to return the wrong thing if the grep engine were to pick any
> other matching method than the one it's told to use.

That is good; it may be even more helpful to the readers if they are
given a brief in-code comment.  I had to scratch head while reading
them.

>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4202-log.sh | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index f577990716..6d1411abea 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -262,7 +262,23 @@ test_expect_success 'log --grep -i' '
>  
>  test_expect_success 'log -F -E --grep=<ere> uses ere' '
>  	echo second >expect &&
> -	git log -1 --pretty="tformat:%s" -F -E --grep=s.c.nd >actual &&
	# BRE would need \(s\) to do the same.
> +	git log -1 --pretty="tformat:%s" -F -E --grep="(s).c.nd" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success PCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
> +	test_when_finished "rm -rf num_commits" &&
> +	git init num_commits &&
> +	(
> +		cd num_commits &&
> +		test_commit 1d &&
> +		test_commit 2e
> +	) &&
> +	echo 2e >expect &&
	# In PCRE \d in [\d] is like saying "0-9", and match '2' in 2e
> +	git -C num_commits log -1 --pretty="tformat:%s" -F -E --perl-regexp --grep="[\d]" >actual &&
> +	test_cmp expect actual &&
> +	echo 1d >expect &&
	# In ERE [\d] is bs or letter 'd' and would not match '2' in '2e'
	# but does match 'd' in '1d'
> +	git -C num_commits log -1 --pretty="tformat:%s" -F -E --grep="[\d]" >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -280,6 +296,65 @@ test_expect_success 'log with grep.patternType configuration and command line' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log with various grep.patternType configurations & command-lines' '
> +	git init pattern-type &&
> +	(
> +		cd pattern-type &&
> +		test_commit 1 file A &&
> +		test_commit "(1|2)" file B &&
> +
> +		echo "(1|2)" >expect.fixed &&
> +		cp expect.fixed expect.basic &&
> +		cp expect.fixed expect.extended &&
> +		cp expect.fixed expect.perl &&
> +
		# Fixed finds these literally
> +		git -c grep.patternType=fixed log --pretty=tformat:%s \
> +			--grep="(1|2)" >actual.fixed &&
		# BRE matches (, |, and ) literally
> +		git -c grep.patternType=basic log --pretty=tformat:%s \
> +			--grep="(.|.)" >actual.basic &&
		# ERE needs | quoted with bs to match | literally
> +		git -c grep.patternType=extended log --pretty=tformat:%s \
> +			--grep="\|2" >actual.extended &&

If we use BRE by mistake, wouldn't this pattern actually find
"(1|2)" anyway, without skipping it and show "1 file A" instead?

> +		if test_have_prereq PCRE
> +		then
> +			git -c grep.patternType=perl log --pretty=tformat:%s \
> +				--grep="[\d]\|" >actual.perl
			# Only PCRE would match [\d]\| with "(1|2)" due to [\d]
> +		fi &&
> +		test_cmp expect.fixed actual.fixed &&
> +		test_cmp expect.basic actual.basic &&
> +		test_cmp expect.extended actual.extended &&
> +		if test_have_prereq PCRE
> +		then
> +			test_cmp expect.perl actual.perl
> +		fi &&

It could be just a style thing, but I would actually find it easier
to follow if the above two "only with PCRE" tests, i.e. running test
and taking its output in actual.perl and comparing it with
expect.perl, were inside a single "if test_have_prereq PCRE" block.
