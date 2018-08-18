Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4801F954
	for <e@80x24.org>; Sat, 18 Aug 2018 07:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeHRKIa (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 06:08:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43352 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeHRKIa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 06:08:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so8779449wrv.10
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C36Zy6R38CLzKn8n9uJm6K2IvpkVemCjrSWRqYch6eA=;
        b=t5Lvz/aBY9l+DcRvSdhrfsOvKL4OYe8lQDr3vNNuTUXdJpdx9RUAP8wSBeWfXakwC8
         mvaNM5IJJsz5e5naFAWFrHZPtsEm8ixf/MuNht6BsSaoAb1TGbndm2Vl5dBbLCyaZnQm
         PZqWTAO0oCAPR/atApSpYn/v5v72b0pTJ2++C/sA6PDguQy7e4WO/qe94mCsK2QFIkJe
         Xb2uuKUQAmJ2tpMQlTPQA6/lIAndtOchGV7S6QmZeiK/eH9oqW113kGWOzgeIejQtMlm
         42MS0JaVBO8DSlmXW8JjvUlStlgQ2/G8b5G5wOyQXp2KNHS3vXZQ7HqW4j5Uw0rMqsYc
         iN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C36Zy6R38CLzKn8n9uJm6K2IvpkVemCjrSWRqYch6eA=;
        b=sHwTFigExDz08lyBkeTsymrY5Oj6v88/jtBcXBecCF6PSvQw1Phl2nmjDcYlmvNlFn
         U5F55FLWJQXYAmb0kndxmkJLD6ilpmt6QOfSU+gD25nPoktH3kvmjy9p+nOQTRjZlgtZ
         vcLmi7unIcY8G/50N6rqrvA+5kNbTvcw2iwCa5H5E4fyBu06eGALWbHy1/cat5qQZxqs
         gSQ1rpZ0PBscIMUR8kFzXGbI2vRYoivZTRkPemVA0GsnlflXgGZHzPqaarLp1GyR6qSF
         NfJ7+HgTvqme5rSzMRJbX5RrWum/CJi/FPFPWBzUDvJFG4fseFeXbl2MreDUXy6TDAyB
         qiEg==
X-Gm-Message-State: AOUpUlFFOp+Fu3qi3KyEqjhVUez0el/7EKy5gk7NAGJJ5JHTLqh0ZKrN
        CxFT3InH6pu7+Ff8/fWFSeEqvM1HZoE=
X-Google-Smtp-Source: AA+uWPyBCs3WHOUonMs09ptgj5NfYu3xBXv61f8ioub+nxKZzqPbHrWryLgsS+mCbaXvyA74wsHvgw==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr23803478wrp.161.1534575710150;
        Sat, 18 Aug 2018 00:01:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w204-v6sm7024849wmw.5.2018.08.18.00.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 00:01:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, CB Bailey <cb@hashpling.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t2024: mark test using "checkout -p" with PERL prerequisite
Date:   Sat, 18 Aug 2018 07:01:47 +0000
Message-Id: <20180818070147.14026-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180818044310.14446-1-cb@hashpling.org>
References: <20180818044310.14446-1-cb@hashpling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checkout with the -p switch uses the "add interactive" framework which
is written in Perl.

One test added in 8d7b558bae ("checkout & worktree: introduce
checkout.defaultRemote", 2018-06-05) didn't declare the PERL
prerequisite, breaking the test when built with NO_PERL.

Reported-by: CB Bailey <cb@hashpling.org>
Signed-off-by: CB Bailey <cb@hashpling.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, Aug 18, 2018 at 6:43 AM, CB Bailey <cb@hashpling.org> wrote:
> checkout with the -p switch uses the "add interactive" framework which
> is written in Perl. Add a PERL prerequisite to skip this test when built
> with NO_PERL.

Thanks, and sorry about my buggy code. I didn't consider the
interaction between -p and NO_PERL.

Your patch works, but I think just splitting the test up is better, so
we're not skipping things unrelated to "checkout -p" under NO_PERL.

I added your SOB since I stole significant parts of your commit
message.

Junio: We'd want one patch or the other before 2.19 so that release
doesn't break tests under NO_PERL.

 t/t2024-checkout-dwim.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index f79dfbbdd6..69b6774d10 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -86,8 +86,13 @@ test_expect_success 'checkout of branch from multiple remotes fails with advice'
 		checkout foo 2>stderr &&
 	test_branch master &&
 	status_uno_is_clean &&
-	test_i18ngrep ! "^hint: " stderr &&
-	# Make sure the likes of checkout -p do not print this hint
+	test_i18ngrep ! "^hint: " stderr
+'
+
+test_expect_success PERL 'checkout -p with multiple remotes does not print advice' '
+	git checkout -B master &&
+	test_might_fail git branch -D foo &&
+
 	git checkout -p foo 2>stderr &&
 	test_i18ngrep ! "^hint: " stderr &&
 	status_uno_is_clean
-- 
2.18.0.865.gffc8e1a3cd6

