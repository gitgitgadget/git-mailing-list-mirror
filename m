Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3879C1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 20:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKEUOG (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 15:14:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32902 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKEUOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 15:14:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id 6so698195wmf.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=shklRYtrSFwAz9K9n1tPV+Iw67Su3G4pK+oWmNOd6zY=;
        b=p56qzY+jWPzCBkRpUXQ/d+JY8Usia0+wNxpKpv6maw9dwQ3fOsRCigXQM006lrrFR3
         SVBehUc7+rXgt3I1Qk9qf6FkNNakbH/BE3L3ElqIYVgNMMOBnLX7Xxk5KjEdpppDjsEV
         uoezvY7zwltwcszZQw6F4HcfAkIFjVAulcl3Ma2GReofAB9fqD5C88+8yCWHKl98Uqn4
         6dbFRoJpmyhRCu8yOX8Ky3tRMOUbiZa9XP76WYNXBtT98cXT3MF3ohF4LPccIPHLWfn/
         u6GT1j6rtPLwZ4RYPAxsrhrAl3971Z2OLlRAC/3lDE6byu34HCHIBF9Rcz9td4Z8PjCO
         314w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=shklRYtrSFwAz9K9n1tPV+Iw67Su3G4pK+oWmNOd6zY=;
        b=RfpsdMKSu/ILFPvNp7h36cK05ezxO9OWefI//XObys1upt1L99jeUZV9CIR4275aEz
         0cktURK7jYhaqrrUIFVSdzfSqIjTR4NpbaM+Xn6q7VXjEtl4EiLWMPE58wJy0Ca2a3rc
         oMscfH5NSQvNUTFHkJ0YCDXjiSRK7Dm2RI0LIU36cElwQ78WL2ks4TpI+Evp6M13NHSG
         dP2Hh+k+95mR6B8IWVeuCur1uRSAsaCLfp4b3yOolMZh+QMroALvn9nVT6diTxJodhp5
         cA9pUMZt8UI9JJWhKScIGblZKiMxWNL2qQZqq2muXmLDNHlrbeRDyUT6yMFP4j4YnZpq
         fq0g==
X-Gm-Message-State: APjAAAXhE5ZU47OsbEt1P40hUXWOvP0yUWh6q8FWhHp21AT1EbJ77Sa7
        XymlTYqCe2HafH1CiJKaR5QSZ9RQ
X-Google-Smtp-Source: APXvYqySFIV4cFJOOMtNd7URAFuSmeWsRfXf6svOZ/Zuj2e3vBUC/WH3FoN98Lc7yxfg8iNQ07XxYQ==
X-Received: by 2002:a1c:2342:: with SMTP id j63mr681763wmj.56.1572984844010;
        Tue, 05 Nov 2019 12:14:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4sm366656wml.33.2019.11.05.12.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 12:14:03 -0800 (PST)
Message-Id: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.git.1572969955.gitgitgadget@gmail.com>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 20:14:01 +0000
Subject: [PATCH v2 0/1] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rynus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Ryenus, for reporting this problem.

Derrick Stolee (1):
  commit-graph: use start_delayed_progress()

 commit-graph.c          |  2 +-
 t/t5318-commit-graph.sh |  6 ------
 t/t6500-gc.sh           | 14 --------------
 3 files changed, 1 insertion(+), 21 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-450%2Fderrickstolee%2Fcommit-graph-progress-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-450/derrickstolee/commit-graph-progress-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/450

Range-diff vs v1:

 1:  174c05bf29 ! 1:  78bd6bc2c0 commit-graph: use start_delayed_progress()
     @@ -11,6 +11,10 @@
          previous step. But, this is showing up for all users no matter how few
          commits are being added.
      
     +    Now that we changed this method, very fast commands show no progess at
     +    all. This means we need to stop testing for seeing these progress lines
     +    in the test suite.
     +
          Reported-by: ryenus <ryenus@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -26,3 +30,45 @@
       					_("Computing commit graph generation numbers"),
       					ctx->commits.nr);
       	for (i = 0; i < ctx->commits.nr; i++) {
     +
     + diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
     + --- a/t/t5318-commit-graph.sh
     + +++ b/t/t5318-commit-graph.sh
     +@@
     + 	test_line_count = 0 err
     + '
     + 
     +-test_expect_success 'commit-graph write force progress on for stderr' '
     +-	cd "$TRASH_DIRECTORY/full" &&
     +-	git commit-graph write --progress 2>err &&
     +-	test_file_not_empty err
     +-'
     +-
     + test_expect_success 'commit-graph write with the --no-progress option' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	git commit-graph write --no-progress 2>err &&
     +
     + diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
     + --- a/t/t6500-gc.sh
     + +++ b/t/t6500-gc.sh
     +@@
     + 	test_line_count = 2 new # There is one new pack and its .idx
     + '
     + 
     +-test_expect_success 'gc --no-quiet' '
     +-	git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
     +-	test_must_be_empty stdout &&
     +-	test_line_count = 1 stderr &&
     +-	test_i18ngrep "Computing commit graph generation numbers" stderr
     +-'
     +-
     +-test_expect_success TTY 'with TTY: gc --no-quiet' '
     +-	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
     +-	test_must_be_empty stdout &&
     +-	test_i18ngrep "Enumerating objects" stderr &&
     +-	test_i18ngrep "Computing commit graph generation numbers" stderr
     +-'
     +-
     + test_expect_success 'gc --quiet' '
     + 	git -c gc.writeCommitGraph=true gc --quiet >stdout 2>stderr &&
     + 	test_must_be_empty stdout &&

-- 
gitgitgadget
