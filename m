Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C70E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 14:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeGaQVR (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 12:21:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41074 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbeGaQVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 12:21:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so16956748wrr.8
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pRC7v9l0clvPK0gO8k4fDnhhnfEEEiL2b12/HcBoDo8=;
        b=WaVcgQHOB5Qqe/bSiOcNak79XfwgRuk+ZcAF7zWtCaBVY0SrROlZtVjDz9/bFrFMc9
         diNj01+xMbVAfCfoXHW12KI2PZNKOuLzph5DWu+mgLEaeLatmjlEweqRZPJETGlPiH4Y
         +xVWbMaDFN5u+wMsYe5P99ECGWtIlZ8B3AriJe++LKBbVEfXUtcDmSJhpyb98z1mSfZ5
         YMS1JCNuQqbWrcW06MqZWNFowWaBkQwbOnRgD8b3egZr02Ipk5gr/55Fzr9PUteGVVOO
         jKYTH8II8beypz/Nh7/FGFyQ+7YH3KOmkN8mRkG7SQDWuOrEAkHtv5BHshZl09JJwl2Y
         2iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pRC7v9l0clvPK0gO8k4fDnhhnfEEEiL2b12/HcBoDo8=;
        b=DUJxZ0YlylqhQPBE3WvkNA8kx4rzUx461QwZ1BPSVknPw2LB7fQeUVxn7GvTr2AuMi
         RHkltRKBKZKBUnkIJECqdcKYDMA4IXmaZypFXED8uRm1mHN0NBEd+qD8E8oAhHL/ggrM
         7b8Mt/uBU8gjHRsTGlkUNJXzAS+g2Zt7YCBAxXYkJaRhty1n+LMl5FtZ2+nJKxwuchgm
         UpRJJ0IdqKPBt2FIRkLnWJOuxB6dTevbtURytDjQW9ly9WPaXyrjKtVdmXUcH9SZ/ndv
         tiKAnMyXNsDBUK4OfjyoT6H2Q55lVfDrQAAC3+WhX97K+zzHg8aLKoWgZcUKPvcxgYNV
         PX/Q==
X-Gm-Message-State: AOUpUlGWdCoxCpCkpbU3m44STRuBfCE926LQfUDdpmHc6JFuqlsOR5zo
        xcmDIaxQ22MishgX/R8YMcutk/B+
X-Google-Smtp-Source: AAOMgpdyWxa9NxenrQ+v9bcKNJj5zlOpcUBxwrZNLYI5rJM4Ai0hEY2WUuShHbEUW8uFzyjetof/GQ==
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr22153000wrt.265.1533048037990;
        Tue, 31 Jul 2018 07:40:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z141-v6sm3309159wmc.3.2018.07.31.07.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 07:40:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com>
        <20180727112222.19061-1-chenbin.sh@gmail.com>
        <20180731084638.18793-1-szeder.dev@gmail.com>
        <CAE5ih7_jh55mLVBhiu12gmc0j3mGkm4s0VU2Stx5iGf1tK6yzA@mail.gmail.com>
Date:   Tue, 31 Jul 2018 07:40:36 -0700
In-Reply-To: <CAE5ih7_jh55mLVBhiu12gmc0j3mGkm4s0VU2Stx5iGf1tK6yzA@mail.gmail.com>
        (Luke Diamand's message of "Tue, 31 Jul 2018 15:40:05 +0200")
Message-ID: <xmqqh8kfeae3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> I think there is an error in the test harness.
>
> On 31 July 2018 at 10:46, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>> +             test_must_fail git-p4 submit --dry-run >errs 2>&1 &&>
>>> +             ! grep "Would apply" err
>
> It writes to the file "errs" but then looks for the message in "err".
>
> Luke

Sigh. Thanks for spotting, both of you.

Here is what I'd locally squash in.  If there is anything else, I'd
rather see a refreshed final one sent by the author.

Thanks.

 t/t9800-git-p4-basic.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 2b7baa95d2..729cd25770 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -274,19 +274,19 @@ test_expect_success 'run hook p4-pre-submit before submit' '
 		git add hello.txt &&
 		git commit -m "add hello.txt" &&
 		git config git-p4.skipSubmitEdit true &&
-		git-p4 submit --dry-run >out &&
+		git p4 submit --dry-run >out &&
 		grep "Would apply" out &&
 		mkdir -p .git/hooks &&
 		write_script .git/hooks/p4-pre-submit <<-\EOF &&
 		exit 0
 		EOF
-		git-p4 submit --dry-run >out &&
+		git p4 submit --dry-run >out &&
 		grep "Would apply" out &&
 		write_script .git/hooks/p4-pre-submit <<-\EOF &&
 		exit 1
 		EOF
-		test_must_fail git-p4 submit --dry-run >errs 2>&1 &&
-		! grep "Would apply" err
+		test_must_fail git p4 submit --dry-run >errs 2>&1 &&
+		! grep "Would apply" errs
 	)
 '
 
