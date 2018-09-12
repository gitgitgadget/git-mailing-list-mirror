Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22E81F404
	for <e@80x24.org>; Wed, 12 Sep 2018 14:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeILTfu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 15:35:50 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45379 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILTft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 15:35:49 -0400
Received: by mail-pl1-f176.google.com with SMTP id j8-v6so1055035pll.12
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KQ+JCn6U/Hslel3wngm1WZYZVW61JpF1t4nk/+JiZoo=;
        b=Yag472hr/S+1/z2BJVuaPQxxFuKnnSzIGHUbqW2S5vDk1Ao1euWTMbAGR8jBbnxVJF
         zfHCYWCqxXH6ZkO+wUHmIfyIVjtY/u+mynIx1Mr+6iG1Rq0tMxpwUjGVg91DX6lE2WKE
         A99NGzYi51+ZAlOrk+tnA9+GBxHcC6HYHEdHfZNRSQr3hU60NPrWgjvGFRXBXtqdHTaq
         mQB7U8CbPk8zVN2S+uDdZEigP4WUgup6KtFSdJCNTd1xs6jeZOmWCaB4XymVT3ZI07e2
         9XUiPGweOSXHg5kyUJE4u0XXCZtlUM/7dqfM3uRSFUVW60sQ/YtC3gj84utnf/Xd8wbU
         s9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KQ+JCn6U/Hslel3wngm1WZYZVW61JpF1t4nk/+JiZoo=;
        b=rWhaDgCs1AxtnatCxVq/UaiGPGPpKeiiaRf9uNZUKnAnuczIMKFAubPn1I74RBdsbB
         aQbcOtVsgT6VBhGfvc2EebrBqX8wu5TIkpTc8ZczLeWeVKkVLqQJLjulYo78u6reiQuD
         q/wv/Et0w1BKWURws3dgj2JMTKH3fn9Cupjr13ndMELXSJ2vl5i9zbvW5s6kEzPYUUHl
         dvdy3DGV7P7xuUu2ADlj55O6Y8Yp7qSPpNFaL84f0YvSX3NMMlHi1TUUQl7YWnX6vciY
         nNVuob1txT11CfhMbEfNyoOPFyfbgLIqPE0+s3Ig/kcjznywLmta+b1MhfC9XKZNm97S
         gVcA==
X-Gm-Message-State: APzg51Au413+6GvGaM+xwaBc6K9cMQ8TLb0FsJUxXnccKgSRXPRZcoFM
        89hr+Op9DueR1Twt4xEqpqzIXK5a
X-Google-Smtp-Source: ANB0VdaPU9w7qeJIula6YF724U2yKmg0oAE6UvxYEUDL8xqN19D6q7zPTalzDvufv8N6uVVeUNndLQ==
X-Received: by 2002:a17:902:7606:: with SMTP id k6-v6mr2578337pll.300.1536762663302;
        Wed, 12 Sep 2018 07:31:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 16-v6sm2075694pfp.6.2018.09.12.07.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:31:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 07:31:02 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Sep 2018 14:30:59 GMT
Message-Id: <pull.37.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.37.git.gitgitgadget@gmail.com>
References: <pull.37.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Add coverage for 'git format-patch --range-diff' single-patch case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In es/format-patch-rangediff, we added a '--range-diff' option to
git-format-patch to automatically add a range-diff. We also added an option
to write the diff as commentary to a single patch submission. However, this
check was not tested.

I discovered this test gap by running 'make coverage-test coverage-report'
on 'next' and then comparing the uncovered lines with those in the diff
between 'master' and 'next'. I have a script that automates this process,
and I'm still working on polishing it. You can see an earlier version at
[1].

Based on es/format-patch-rangediff

Cc: sunshine@sunshine.co

Cc: peff@peff.net

[1] 
https://github.com/derrickstolee/git/blob/coverage/contrib/coverage-diff.shA
bash script to report uncovered lines that were added in a diff.

Derrick Stolee (1):
  t3206-range-diff.sh: cover single-patch case

 t/t3206-range-diff.sh | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 40ce41604daf200cdc85abded0133d40faafc2f8
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-37%2Fderrickstolee%2Frange-diff-test-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-37/derrickstolee/range-diff-test-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/37

Range-diff vs v1:

 1:  58347a9624 ! 1:  277a4d2bd8 t3206-range-diff.sh: cover single-patch case
     @@ -22,7 +22,7 @@
       
      +test_expect_success 'format-patch --range-diff as commentary' '
      +	git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
     -+	grep -A 1 -e "\-\-\-" actual | grep "Range-diff:"
     ++	test_i18ngrep "^Range-diff:$" actual
      +'
      +
       test_done

-- 
gitgitgadget
