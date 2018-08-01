Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C5B1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbeHAQ4v (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 12:56:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54664 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389585AbeHAQ4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 12:56:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so7386476wmb.4
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rbINUhlNtVEF2O1QEDwwFup7Jany4+VIvWKzvFh2qFU=;
        b=paOYvENI/XEXJYZ87lIawQW8rGJVUzEAAE23CnJ6PaH2onQtJ0sdXbzex0fJV9Qbzn
         q5AQvWC4AB3GYYOcrg/QpMLMKobOlzSXfFFc2WDVGildbyZ3fJRlcUhafKo8y8VjaKus
         H+CHH3AFlhCgauDb2zm0+1bLufvKytuUA67PH5q+i+ZPJe1xkxgoQHDNFaEfXkTxijS7
         AnJRZOrZ2RGSBF9KPuYWUqVxlkf+UKQ79bVHsdS39l+enLDtwyvz51sgGJymGbQlaEIE
         Xxpykxp98qsY/+Qlj9xp6j3z25JpQ2Py+wosV02OKZTTBL06Qs+/SLOqZ9GiUG2ek1u3
         LXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rbINUhlNtVEF2O1QEDwwFup7Jany4+VIvWKzvFh2qFU=;
        b=ANkvoNbvN5BsFghUaY/+HVSwh9GJtLGnwQ5irJsPLXcDnMfDpvgeVKuu5XcWasYjqi
         74rJ7vc9xOTUpWYZ5KH0N30wB39d8Ud3OC3q61noWmBiqxmBbcRVXjPqolCH9NL1989B
         DXYxHrA3h5aC7alyGy4sGY2lWbmnUcauAb0p2HFbumestH3XRn5aSDnBTXPV3Lk6QlqM
         Hn88WKX+wcigOwbzm+A698qXr03SuypE0fWMloF7lfzFfkXui8Y3EwWfcqQzzcbT31to
         bB9FMPn6h3s6Lk8e3GYYrhaWmpKzjFQm/IfyNmjBbNlsa/vLa86YjGpDQuEqgocTc/LQ
         ULhw==
X-Gm-Message-State: AOUpUlEBK6iOEBPlNWSl3/XDt0pQJsdbj4CVxyfMeQBiwLR9tiALl8nr
        dqnVYPVQyTn0+8NuT6b1//Y=
X-Google-Smtp-Source: AAOMgpemOSoO1p3hQ/z4JPt4RErrpYC304yfrbY8jAOF5gLeQfoJudbAFgNPAtLKyOQQ4D/q+IpX0A==
X-Received: by 2002:a1c:1943:: with SMTP id 64-v6mr2938256wmz.89.1533136239587;
        Wed, 01 Aug 2018 08:10:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i205-v6sm6627785wmf.30.2018.08.01.08.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:10:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     chen bin <chenbin.sh@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com>
        <20180727112222.19061-1-chenbin.sh@gmail.com>
        <20180731084638.18793-1-szeder.dev@gmail.com>
        <CAE5ih7_jh55mLVBhiu12gmc0j3mGkm4s0VU2Stx5iGf1tK6yzA@mail.gmail.com>
        <xmqqh8kfeae3.fsf@gitster-ct.c.googlers.com>
        <CAE5ih7-pLAW8xrY_F2z6gDxaMuA4w+nuUQHeLvGdSyn0GXebWA@mail.gmail.com>
        <CAAE-R+8UA5S3Y4iWw=njtVVn8cu+7s8E7L9fS6UY=Q_a5-JwwQ@mail.gmail.com>
Date:   Wed, 01 Aug 2018 08:10:38 -0700
In-Reply-To: <CAAE-R+8UA5S3Y4iWw=njtVVn8cu+7s8E7L9fS6UY=Q_a5-JwwQ@mail.gmail.com>
        (chen bin's message of "Thu, 2 Aug 2018 00:57:19 +1000")
Message-ID: <xmqqmuu686mp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

chen bin <chenbin.sh@gmail.com> writes:

> I updated the patch. But for some reason the test keep failing at this line,
> `test_must_fail git p4 submit --dry-run >errs 2>&1 &&`.
>
> If I change this line to `test_must_fail git-p4 submit --dry-run >errs
> 2>&1 &&` the test will pass.

Hmph.  I somehow suspect that the test also will pass if you changed
it like this:

	test_must_fail false >errs 2>&1 &&

IOW, my suspicion is that the shell fails to find "git-p4" [*1*] and
that is why your `test_must_fail git-p4 whatever` lets your test
pass, which is different from the way you _want_ your test_must_fail
succeed, i.e. "git p4 submit" is run with the "--dry-run" option and
exit with non-zero status.

Of course, if the shell cannot find "git-p4", `errs` would not have
the string "Would apply" in it, so the next test also would pass.

>>>> On 31 July 2018 at 10:46, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>>>>> +             test_must_fail git-p4 submit --dry-run >errs 2>&1 &&>
>>>>>> +             ! grep "Would apply" err



[Footnote]

 *1* As I do not use (nor install) p4, I cannot test "'git p4' works
     but 'git-p4' should not work" myself, but by running t0001 with
     a trial patch like the following, you can see that we do not
     find the dashed form `git-init` on $PATH and the test indeed
     fails.

 t/t0001-init.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0681300707..8c598a0d84 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -31,7 +31,7 @@ check_config () {
 }
 
 test_expect_success 'plain' '
-	git init plain &&
+	git-init plain &&
 	check_config plain/.git false unset
 '
 
