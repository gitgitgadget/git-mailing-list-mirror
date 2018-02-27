Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B511F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeB0UQV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:16:21 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40502 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB0UQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:16:20 -0500
Received: by mail-wr0-f196.google.com with SMTP id o76so81602wrb.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CJg3beJQ+7n+5dLuF4GPJumG3DkvkHNcM0JT7/9L1FE=;
        b=J8kXKrjgIRhM0ZHCkphKo9OjKS5a4gzPvVAk/EDMRVW02kR9TtWnKOBSfw6MSmCUar
         fEFOKY0TcijKRNBpfPkpNIJ3ZpgteRihjKg/rFH6TlpagZbtnkj/9RJc8b35UZFTgWQ+
         sYsmdKRcjLlYr3MtJ+Wz7EeGPXkOFYGTLZmPdMaT+uonyj1RuduebTnN1fIHqlkcQGlJ
         aN1gyGcZi18uWgva2A6FKqZ55Q7vIhPzIpS3QmcIHoNHN6P4zjCk9/OCJJMmhcgyx+Nh
         dI3DHZlY/nB8FAGCf9cILM1ZDLX+5qomzXGE7csO3t9OS7+WVzZQdohPEvuwTdAnFl5Y
         0MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CJg3beJQ+7n+5dLuF4GPJumG3DkvkHNcM0JT7/9L1FE=;
        b=aWgBGkPetDT+43UV3KrGMPRdOI1QpfqGoO1kKofUx3msU0WL5/DIvwLKhmTkgxKRlS
         NEsZq/s2wngmRBBZOZl2VcNHLgYQ6e5mLhASFsYdguKgQWrt9AAXKj6RPAYScFMOUlnA
         12etq2h+Vzt0Bjj91EsOV6KPGpPI3xtP9m+WZ3d659Rgn7YURgbEsxB5WE65ETDoFtWQ
         NOXNkdHncMdkLmM1U7tM6KUgdLCZYBKwKBh4fIjwjTC0M+/E8FQPvXsAWI6OGrjMz5GA
         no7dKtXrbzaNTkcM/ryud8WDSFLFC/NqdTtF20Lf6VDDqLZ3ejiWmITNjzJcI1Gu6EdY
         Av6g==
X-Gm-Message-State: APf1xPDbtBvMcWTRXnPwM9V/dN+G/eXaUZKviPragbmyCojY5CYsCdIm
        5QdGc7S3nILlOnjRtH4VAmXQdM6B
X-Google-Smtp-Source: AG47ELs46mcZrZ/9HmdItwW6dCChdz+2coKrBG5sgMHrPlSFVQOZSKPEnVjVKEtMnvcGMozhDQ3XEA==
X-Received: by 10.223.200.140 with SMTP id k12mr13739017wrh.191.1519762578932;
        Tue, 27 Feb 2018 12:16:18 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s125sm409331wmf.4.2018.02.27.12.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 12:16:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
        <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
        <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
        <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
        <20180213100437.15685-1-szeder.dev@gmail.com>
        <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com>
        <20180213172603.GA10062@sigill.intra.peff.net>
        <xmqqeflorc9m.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 27 Feb 2018 12:16:17 -0800
In-Reply-To: <xmqqeflorc9m.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 13 Feb 2018 10:10:45 -0800")
Message-ID: <xmqq371mqjce.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> If I understand Gábor's patch correctly, it is using test_i18ngrep for
>> the specific lines we care about so that we don't have to worry about
>> other cruft lines that may or may not appear (including the hangup one).
>>
>> The downside is that we would not notice if a _new_ error message
>> (beyond the ones we expect and the one we were explicitly ignoring)
>> appeared. IMHO that's probably fine.
>
> Ah, OK, I didn't notice how the multi-line one was handled.  Unable
> to notice new error messages and undisturbed by possible "hung up"
> messages are the sides of the same coin---I myself am unsure if it
> is a good trade-off, but I'm inclined to defer to judgment of two
> people ;-)

OK, somehow I had the version from Ramsay on a topic branch that was
not merged to 'pu'.  Here is the replacement for 2/2 I'd be queuing.

We'd need SZEDER to sign it off (optionally correcting mistakes in
the log message) if we are going with this solution.

Thanks.

-- >8 --
From: SZEDER Gábor <szeder.dev@gmail.com>
Date: Tue, 13 Feb 2018 11:04:37 +0100
Subject: [PATCH] t5536: simplify checks for fetch error verification

The verify_stderr helper had this construct

	test_i18ngrep ...  error | grep -v ... >actual | sort &&
	...

in which 'sort' was clearly doing nothing (other than hiding the
exit status of the "grep -v" from &&-chain).  It obviously is a
botched attempt to make sure "actual" can be compared with expected
output without having to worry about the order of errors and
warnings in the input file, i.e.

	test_i18ngrep ...  error | grep -v ... | sort >actual &&
	...

Instead of grabbing all errors and warnings from the command and
seeing if they match what is expected after sorted, look for
specific errors and warnings each test cares about and eliminate
this buggy helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5536-fetch-conflicts.sh | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2e42cf3316..91f28c2f78 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -18,14 +18,6 @@ setup_repository () {
 	)
 }
 
-verify_stderr () {
-	cat >expected &&
-	# We're not interested in the error
-	# "fatal: The remote end hung up unexpectedly":
-	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
-	test_i18ncmp expected actual
-}
-
 test_expect_success 'setup' '
 	git commit --allow-empty -m "Initial" &&
 	git branch branch1 &&
@@ -48,9 +40,7 @@ test_expect_success 'fetch conflict: config vs. config' '
 		"+refs/heads/branch2:refs/remotes/origin/branch1" && (
 		cd ccc &&
 		test_must_fail git fetch origin 2>error &&
-		verify_stderr <<-\EOF
-		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
-		EOF
+		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1" error
 	)
 '
 
@@ -77,9 +67,7 @@ test_expect_success 'fetch conflict: arg vs. arg' '
 		test_must_fail git fetch origin \
 			refs/heads/*:refs/remotes/origin/* \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
-		verify_stderr <<-\EOF
-		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
-		EOF
+		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1" error
 	)
 '
 
@@ -90,10 +78,8 @@ test_expect_success 'fetch conflict: criss-cross args' '
 		git fetch origin \
 			refs/heads/branch1:refs/remotes/origin/branch2 \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
-		verify_stderr <<-\EOF
-		warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2
-		warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1
-		EOF
+		test_i18ngrep "warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2" error &&
+		test_i18ngrep "warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1" error
 	)
 '
 
-- 
2.16.2-264-ge3a80781f5

