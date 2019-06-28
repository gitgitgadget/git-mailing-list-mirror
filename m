Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338901F461
	for <e@80x24.org>; Fri, 28 Jun 2019 18:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfF1Sol (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 14:44:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38843 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfF1Sol (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 14:44:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so11985725edo.5
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dorRYqM/B38oe0qLR7N3RysNq6cgkVbnUhpPqCDbRwE=;
        b=WoMMCAj50nw3WGHwnBUj8ydFLZdTFu4ERWqnQpekKsHZwrYaHyfcJIR1gdMR+8/hsY
         zBDz2imsuobIhADGRoCgaL39JEcyrAD61qFDehZ56Zm+zs1F0XFFpP3o3tNs4YgGOqzW
         Dc/GmBXBIZec4KVmOEV5K6FPHr23V7DBclfC54Yo3vF3YEetjIYy0Br5e24/f1VQAwgl
         vDQR/oO2FsY1T7xNeH2GN6LV/5SQjl0dABeeD7C1D4IW2SC0UOcwL4A1Ipf6aCFmyF+i
         NPBHDhhBYG6s3UQCUFAC6H2x7TH6yMpu0NmqyWVeXvSU7rtnH1s6g9mFSdEJ2etkJzDg
         ImXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dorRYqM/B38oe0qLR7N3RysNq6cgkVbnUhpPqCDbRwE=;
        b=stWqvxTcST3DMyDO9eUj2dz6Gu4Y4Hg427r6FtVEmy+pTNb67TmLUy1NSbfaYNsvoC
         xqe1iKjA6nMdy5nuqaP+H0P1aHq5XFAOQSUQ7dML6Ml3zSzbBo9NKoEeXRSzIH6tedj2
         5Q5Jbi16tzxN/f5/L8qyx14jPk/KKPEbEjXt5Xtp8leQxfdx63VbZAWctsSTTF+IiKdR
         6dblIJ7+OKU0uJtgvUERgKFcmvf7hvT9qZh+1/W/WLyUHWbA4u6oypGodEL8vPyDh6Zk
         iaHv1rk0x/xd1iEV2zCyw2UvL/sb+mDG09mcPEZPHeE78mbNXx/ppvKt63D+U/moHmbQ
         f8Ng==
X-Gm-Message-State: APjAAAX3Y/MmNt9/pAK7rl+5hfsAPbSXSgN9BD2GckFjtfXdiahOPIWJ
        h2ySffE6sxmSuPQB6swL52w=
X-Google-Smtp-Source: APXvYqxWTu9QaoYb27aNDq/KzKQViHH1I3W4GCwGduZTNi2yahh0rzsBZs/FzI5s/Kmky8VUilLQjw==
X-Received: by 2002:a50:b566:: with SMTP id z35mr13504345edd.129.1561747479730;
        Fri, 28 Jun 2019 11:44:39 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id w14sm943018eda.69.2019.06.28.11.44.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 11:44:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
References: <20190628093751.GA3569@sigill.intra.peff.net> <20190628093911.GA27329@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190628093911.GA27329@sigill.intra.peff.net>
Date:   Fri, 28 Jun 2019 20:44:38 +0200
Message-ID: <87woh57dnt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 28 2019, Jeff King wrote:

> Some tests need to create a string of commits. Doing this with
> test_commit is very heavy-weight, as it needs at least one process per
> commit (and in fact, uses several).
>
> For bulk creation, we can do much better by using fast-import, but it's
> often a pain to generate the input. Let's provide a helper to do so.
>
> We'll use t5310 as a guinea pig, as it has three 10-commit loops. Here
> are hyperfine results before and after:
>
>   [before]
>   Benchmark #1: ./t5310-pack-bitmaps.sh --root=3D/var/ram/git-tests
>     Time (mean =C2=B1 =CF=83):      2.846 s =C2=B1  0.305 s    [User: 3.0=
42 s, System: 0.919 s]
>     Range (min =E2=80=A6 max):    2.250 s =E2=80=A6  3.210 s    10 runs
>
>   [after]
>   Benchmark #1: ./t5310-pack-bitmaps.sh --root=3D/var/ram/git-tests
>     Time (mean =C2=B1 =CF=83):      2.210 s =C2=B1  0.174 s    [User: 2.5=
70 s, System: 0.604 s]
>     Range (min =E2=80=A6 max):    1.999 s =E2=80=A6  2.590 s    10 runs
>
> So we're over 20% faster, while making the callers slightly shorter. We
> added a lot more lines in test-lib-function.sh, of course, and the
> helper is way more featureful than we need here. But my hope is that it
> will be flexible enough to use in more places.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5310-pack-bitmaps.sh |  15 +----
>  t/test-lib-functions.sh | 131 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+), 12 deletions(-)
>
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index a26c8ba9a2..3aab7024ca 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -21,15 +21,9 @@ has_any () {
>  }
>
>  test_expect_success 'setup repo with moderate-sized history' '
> -	for i in $(test_seq 1 10)
> -	do
> -		test_commit $i
> -	done &&
> +	test_commit_bulk --id=3Dfile 10 &&
>  	git checkout -b other HEAD~5 &&
> -	for i in $(test_seq 1 10)
> -	do
> -		test_commit side-$i
> -	done &&
> +	test_commit_bulk --id=3Dside 10 &&
>  	git checkout master &&
>  	bitmaptip=3D$(git rev-parse master) &&
>  	blob=3D$(echo tagged-blob | git hash-object -w --stdin) &&
> @@ -106,10 +100,7 @@ test_expect_success 'clone from bitmapped repository=
' '
>  '
>
>  test_expect_success 'setup further non-bitmapped commits' '
> -	for i in $(test_seq 1 10)
> -	do
> -		test_commit further-$i
> -	done
> +	test_commit_bulk --id=3Dfurther 10
>  '
>
>  rev_list_tests 'partial bitmap'
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 0367cec5fd..32a1db81a3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -233,6 +233,137 @@ test_merge () {
>  	git tag "$1"
>  }
>
> +# Similar to test_commit, but efficiently create <nr> commits, each with=
 a
> +# unique number $n (from 1 to <nr> by default) in the commit message.

Is it intentional not to follow test_commit's convention of creating a
tag as well? If so it would be helpful to note that difference here, or
rather, move this documentation to t/README where test_commit and
friends are documented.
