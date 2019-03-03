Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C800320248
	for <e@80x24.org>; Sun,  3 Mar 2019 09:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfCCJzI (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 04:55:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53604 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfCCJzI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 04:55:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id e74so1886416wmg.3
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=Euk9GwH6iGiDxYgVu3VnCa0htb8FrP/Hf2Op6zgetlI=;
        b=mV+RFZQJTItUBoOvaZauEJf74PI9ikzBmBubjKXlOT4RXbdPhnWnn2YkwNfRs5A9EX
         b5zyXCkQp4k3bKMol+U2y5JI8HOmZgug+g2tN7a5wJare+kKkktj8M94vqwHaaiY1r9X
         fP9V4FmAVSd9YzAnKtAJ213Kp6+lpXiJPvBCMs0SaA0IYazOM8UZxx9TwIIn+NGqq3wu
         4I5WDomNdHbn2PK5+/dXl7wNLvYV4OOJtcBtVJaYYc9Lt5IxdcjK+M7UahnjJIVu+Y7+
         cOtWlKSZpSGSermF9YuXdYGGsNfTPWEsAunKNAytXDnKvKhXQC6ki112qRg1NNdYQKo/
         Unpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=Euk9GwH6iGiDxYgVu3VnCa0htb8FrP/Hf2Op6zgetlI=;
        b=Qus6LzWy7rp8B9rk3MrGTD4KqmFAP7iRx8hcTci9LMAyRyhxH/7ErW6j5REn5EeRSx
         pDWbWf6jF/YAT9E56l5jSOIKjZ2IOyxDFxmHrX/klx2UJsvxNH0VC6AMY8j6S/SAOqfy
         pOpeXGc05ImIsbvgTYdVjlkGJfZ6sHjGLTukMLfEQXPH3yB0YHriDyeoyCwhUy4FKv2Q
         PQOCu7OnYfOpdUS71cwTNQp++EGjATuxMPSFdFRGrsMhbHUuSYRRDMvoE4JvRbaYkvfk
         doMqKcAFGYrM1JYN+7AtYcgzdmm7En1Zre4y26AEuBDGEzT7AtK8i7VfIe/NCAu1tXYG
         OpEw==
X-Gm-Message-State: AHQUAubeuD6yGPdOhs8Vrm/updf7kKiWdW5X0Kt7MvJ6HFhdP6u/UkpC
        xsCFlV23NQzmoQgt1iR+PAM=
X-Google-Smtp-Source: AHgI3IYy/amr1GNs8jC6IfEcOH30oqTMgYG2mc9wJi16H81q1CG2/hC2FnD/k9iA74pc1hBvyxO/KA==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr7621687wmb.48.1551606905849;
        Sun, 03 Mar 2019 01:55:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z8sm2409677wmi.28.2019.03.03.01.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 01:55:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tests: introduce --stress-jobs=<N>
References: <pull.155.git.gitgitgadget@gmail.com>
        <281d3f1d19d1c93e8d1e66ae16fe3fb286554c0a.1551561582.git.gitgitgadget@gmail.com>
Date:   Sun, 03 Mar 2019 18:55:05 +0900
Message-ID: <xmqqh8ck1dvq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The --stress option currently accepts an argument, but it is confusing
> to at least this user that the argument does not define the maximal
> number of stress iterations, but instead the number of jobs to run in
> parallel per stress iteration.

Yeah, when there are multiple knobs that can take integral value,
and especially when the knobs are of equal usefulness, the users
would happen pick the right one 50% of the time by accident, which
is not a happy state.

> Let's introduce a separate option for that, whose name makes it more
> obvious what it is about, and let --stress=<N> error out with a helpful
> suggestion about the two options tha could possibly have been meant.

Good.  

Making --stress=<value> error out (instead of deprecating with a
transition plan) is probably OK given its audience.  It is a good
trade-off to save our braincycles by not having to worry about
transition and forcing everybody to adjust (I am assuming that
nobody has a wrapper script to run tXXXX-title.sh scripts that
passes the --stress=<value> thing).

t/README must be updated as --stress=<N> is documented to specify
the degree of parallelism, though.

I'll queue in the meantime, to reduce the risk of forgetting the
topic.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ab7f27ec6a..6e557982a2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -142,10 +142,16 @@ do
>  	--stress)
>  		stress=t ;;
>  	--stress=*)
> +		echo "error: --stress does not accept an argument: '$opt'" >&2
> +		echo "did you mean --stress-jobs=${opt#*=} or --stress-limit=${opt#*=}?" >&2
> +		exit 1
> +		;;
> +	--stress-jobs=*)
> +		stress=t;
>  		stress=${opt#--*=}
>  		case "$stress" in
>  		*[!0-9]*|0*|"")
> -			echo "error: --stress=<N> requires the number of jobs to run" >&2
> +			echo "error: --stress-jobs=<N> requires the number of jobs to run" >&2
>  			exit 1
>  			;;
>  		*)	# Good.
