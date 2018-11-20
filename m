Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63F91F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 11:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeKTWLD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 17:11:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38582 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbeKTWLD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 17:11:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id k198so1887407wmd.3
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wuw3wHzbnCed9g69z/xdy3WdxdlYAoYhwKriW/Shzwc=;
        b=vBoU6k6x+WP7dEGpe4quxeSxPqKuOB8x674dnsIOEeDb6rQxwEr498LvB4RWXPsUWH
         3/Oz5HirNtdzJuLKmOZBLTFarGe3REAoQFnTpvfoqz95ye/MGG+TG1xNuMhx50j4gIuY
         0Cpp4Ttzb10rAyRV2KaOD7dKRGv7AuSAt5A41ZheqHRuXTtAvFM8IT+D5jDO1Ni2RQ7+
         lZgwr2APs6ZAIvQpYRt0jVWl2iMn/aAhmj1PGk3FkiG5NQGdKSAIdFh11AjLqWHa81aI
         WR1fMHlqq22Vtht4y73NuJY3+Fa357Rdy6focikQdhEhUl3GOBZ0S3YOGkJyiVfEkBH8
         DFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wuw3wHzbnCed9g69z/xdy3WdxdlYAoYhwKriW/Shzwc=;
        b=IkL+y97pnyUfoI4e4quOd2nmfqcoldhpIoFDXjgysCCfXzFNp2Sfyq7si85UBs8Feg
         jHrlRbN40Jup+sKZImRu0aC6dCvVZED4LiRDQSnbMw8/7TKynDTEeODq9g+XsHdGHmbW
         d2zzLsTxH6siFcVm7nV2ZuSUXvdVTLN0M3938JJbgkSY6ovLYj2TLCNtW9ksSFCc8ewi
         nFtk40HB0gW47KBkJgqcEv1mLllx58jhznp3h+e8K9GO++Hh3Vp5rQWcDjz1q6dLy2Zh
         iLNid+Qu92V4IvRcQPNvNGViYk/OIMzWi/3mj75C295nmvVKA7D96Sp5ehS2VLdeSnxo
         Snig==
X-Gm-Message-State: AA+aEWYamgGPnYSu/kwhdVIXZepynHV3TYf6++JCiDIpGONKGC/4Rn53
        Zz+aUfslqd4WIkuekgcZKKjLYGR0nY0=
X-Google-Smtp-Source: AFSGD/U1NnEKl/1KXdkD400v1YfebWfhYtoF2w0Eyb5jUthyB4OSrvCEwde3yjUP7tXtJ3ZABHHmAQ==
X-Received: by 2002:a7b:c044:: with SMTP id u4mr1840039wmc.50.1542714137357;
        Tue, 20 Nov 2018 03:42:17 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v133sm6406126wmd.4.2018.11.20.03.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 03:42:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] rebase: mark a test as failing with rebase.useBuiltin=false
Date:   Tue, 20 Nov 2018 11:42:08 +0000
Message-Id: <20181120114208.14251-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <nycvar.QRO.7.76.6.1811201157170.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1811201157170.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark a test added in 04519d7201 ("rebase: validate -C<n> and
--whitespace=<mode> parameters early", 2018-11-14) as only succeeding
with the builtin version of rebase. It would be nice if the
shellscript version had the same fix, but it's on its way out, and the
author is not interested in fixing it[1].

This makes the entire test suite pass again with the
GIT_TEST_REBASE_USE_BUILTIN=false mode added in my 62c23938fa ("tests:
add a special setup where rebase.useBuiltin is off", 2018-11-14).

1. https://public-inbox.org/git/nycvar.QRO.7.76.6.1811201157170.41@tvgsbejvaqbjf.bet/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, Nov 20 2018, Johannes Schindelin wrote:

> [...]
> Maybe you can concoct a prereq for this test? Something like
>
> test_lazy_prereq BUILTIN_REBASE '
>       test true = "${GIT_TEST_REBASE_USE_BUILTIN:-true}"
> '

It's better to just mark the test as needing the prereq turned
off. E.g. this is what we do for the split index tests & now for the
gettext tests. That way we always run the test, but just indicate that
it relies on GIT_TEST_REBASE_USE_BUILTIN being unset.

 t/t3406-rebase-message.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 38bd876cab..77e5bbb3d5 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -84,7 +84,8 @@ test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_i18ngrep "invalid-ref" err
 '
 
-test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
+test_expect_success 'builtin rebase: error out early upon -C<n> or --whitespace=<bad>' '
+	sane_unset GIT_TEST_REBASE_USE_BUILTIN &&
 	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
 	test_i18ngrep "numerical value" err &&
 	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
-- 
2.20.0.rc0.387.gc7a69e6b6c

