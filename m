Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06EF1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 05:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJWN34 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 09:29:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJWN34 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 09:29:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so111773wrn.0
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 22:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MxVBVdgqxFNcs3+DLx7ltPEPHG9lI+dEQDxcEc1Beqc=;
        b=lqBdVPOl/14zecbzcqiOTVwbMYkPZZ7A65N99xV9qfJylWnrLhPLyBQQQaLryszw6m
         c3h3/tBxqSC6q0mqehdFdz1Ao2d/VelIhQZLWgpGNy7+dPpN43ZbPMAwuxJsCdD8IRny
         6eKdvjpL9lMqONRWXYK7RiCCk/ac+f6dvvedi5eG0w+NuzLF327QJFH5Dg1t6OgfQuiK
         X/sPrKMXgWTEJRP66KB37Ahj7NJ9zkrc6gcKCYe45lQ81+wc05U3j3MDGXXp7cNIFS/k
         WXTTaI6x+IOMiLeCHhoMlm0bgIcCb3G+C9TVMlojFK6kZ+xIB6nXvBHbEXBtP8Lq39Me
         itag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MxVBVdgqxFNcs3+DLx7ltPEPHG9lI+dEQDxcEc1Beqc=;
        b=mVgfN3sFo1Qe0yq2IPHSKxg0rDK4hPNLeqFJe66IMk27GJ/xrtDenbhWjvmgcWDVpg
         2IdBXx1j93XamwI1BmdQGE6F9t1ZbFAmKpXvC84S0K9pNI2m6vXVHIAAwJfpjlQDiw7m
         5jEmf/eo0ywiVYJLSTznaKhPzutWD25EdZuLTS0P2RmKGAN4bWXu5m6KhZNJCKPe3E0R
         vJE+SPn+EpUw7GLtyjMbGnxCMmDa6+dAgH7mQKa8QhRjPPfqyfmjXMxmPkAqRkVHUwj+
         6W7O0Xk8qPCfKcdrm05OlAGmfwQtHBX/nobrI+bdGliMnjvSg/o/VjlF5thseN4v1NSU
         +mcg==
X-Gm-Message-State: ABuFfojo5gH+ltiSHE3q2pZAJ5mCglePdV6SpPeTdlThf7ER+FHRxZxQ
        BBHVB5LeaYlw6D4FEPj16g4=
X-Google-Smtp-Source: ACcGV62IYOVSPFz7RwXhTyB9td3LmsD+lgLRisVao5Xnpn56kBGiJrV48383Cl2FLqC37lOB3zRHbw==
X-Received: by 2002:adf:9f0f:: with SMTP id l15-v6mr49041295wrf.206.1540271292438;
        Mon, 22 Oct 2018 22:08:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y65-v6sm338831wmg.40.2018.10.22.22.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 22:08:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, peff@peff.net,
        jonathantanmy@google.com, jeffhost@microsoft.com,
        matvore@comcast.net
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is allowed
References: <cover.1540256910.git.matvore@google.com>
        <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
Date:   Tue, 23 Oct 2018 14:08:10 +0900
In-Reply-To: <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
        (Matthew DeVore's message of "Mon, 22 Oct 2018 18:13:42 -0700")
Message-ID: <xmqqin1ts11h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

>  t/t4202-log.sh         | 4 ++++
>  t/t8002-blame.sh       | 4 ++++
>  7 files changed, 14 insertions(+), 1 deletion(-)
> ...
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 153a506151..819c24d10e 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1703,4 +1703,8 @@ test_expect_success 'log --source paints symmetric ranges' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--exclude-promisor-objects does not BUG-crash' '
> +	test_must_fail git log --exclude-promisor-objects source-a
> +'
> +
>  test_done
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index 380e1c1054..eea048e52c 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -118,4 +118,8 @@ test_expect_success '--no-abbrev works like --abbrev=40' '
>  	check_abbrev 40 --no-abbrev
>  '
>  
> +test_expect_success '--exclude-promisor-objects does not BUG-crash' '
> +	test_must_fail git blame --exclude-promisor-objects one
> +'
> +
>  test_done

OK.  We used to be hitting BUG() which is an abort() in disguise, so
must-fail would have caught it without the fix in this patch.  Now
we would see a more controlled failure.

    ... goes and makes sure that is the case ...

Not really.  We were already doing a controlled failure via die(),
so these two tests would not have caught the problem in the code
before the fix in this patch.

But nevertheless this is a good change; I do not think it is worth
grepping for "unrecognized option" to differentiate the two cases.

Thanks.
