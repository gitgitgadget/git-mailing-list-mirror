Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65B5CBE
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr9Jhhl+"
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2CB3
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 06:53:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso38274431fa.1
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697291613; x=1697896413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p3Y1WJedsuidLRkxbqNlUC1sJLWiuCfLIbnalBWsZQ=;
        b=hr9Jhhl+SzjVUDSO2xosBQQagTs6VpVF1wcMhUKu5YVzEN4wY9zJdridX+8Vzh45jQ
         2CzQKmleJ7/h75qE0Y2FBE2adpx6Qah64Gj5fTzWFU7Z9jfvNFyv6gT+qabwH+mS2/0p
         51ccF5r/7GZRjitLErPbz6d2lR0SmnU0AJcV/P5ha8Jzc5gv3skshXbEwz/ZxEIvLTrP
         n1cJqhFOm1wYF4BoZ7anvkMgJ6UFlvOrPaoVqjekNFHc2WJwLuaGx21+NRBpDu/CXRhA
         oliIHG5OGnFl6Xl2ouMCkQPTqAEeRVV7B8f6wDAZFfk+k0OT9P4lOLcrA/pojB8Xkycn
         RRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697291613; x=1697896413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p3Y1WJedsuidLRkxbqNlUC1sJLWiuCfLIbnalBWsZQ=;
        b=Ly4TjjU1iSQhyXTdm3k+riyA6/MW4olqdPU+Lg+A0bacfMFP/3GlrbGyk5cqVGEpDl
         0uYvj7t1mURYp2xOIczz5QqPyFfT4L8cHFy8pqMbg4QmLEbXKMIZbftXqAqrGn8FEqgs
         IajjGA55+KejS3bkSBA7CAf4eS0h6K74wCF1o49nJWcg69Ru5+yPAuA4DDlE6I6c0Nzj
         qbir+98v7LJ/38YzFvkak9VNksHyiCvvbdyB8tyFJYjWBHIt2IP9mEF42qjQbgnaUOgH
         ognOBcWj45FrNXROl24cNvopiWrHH/vHAxi95S6YbaOmnfZN1/Q3EiYLkyzYJeDRP6Iz
         wqVA==
X-Gm-Message-State: AOJu0YwogIYDEHNG+Jk7gWaQdLv3lE6xCfn952te8tHgAoTTFzDm0TWW
	BSO9ihS833ikjKIR742ANM0=
X-Google-Smtp-Source: AGHT+IERfvvA2nC1W8zSfvjnqTp2pHewKgH4jvflp6qp/4SV/WiNtDmfNnhxMt9PXJ8tlHwuYhGNdg==
X-Received: by 2002:a2e:830c:0:b0:2bc:b9c7:7ba8 with SMTP id a12-20020a2e830c000000b002bcb9c77ba8mr23225070ljh.43.1697291613029;
        Sat, 14 Oct 2023 06:53:33 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id r22-20020a2e8e36000000b002c51077cba1sm370116ljk.105.2023.10.14.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 06:53:31 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: ks1322 ks1322 <ks1322@gmail.com>
Cc: git@vger.kernel.org,
	Victoria Dye <vdye@github.com>
Subject: [PATCH] diagnose: require repository
Date: Sat, 14 Oct 2023 15:53:01 +0200
Message-ID: <20231014135302.13095-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.42.0.399.g85a82e71e0
In-Reply-To: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
References: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When `git diagnose` is run from outside a repo, it begins collecting
various information before eventually hitting a segmentation fault,
leaving an incomplete zip file behind.

Switch from the gentle setup to requiring a git directory. Without a git
repo, there isn't really much to diagnose.

We could possibly do a best-effort collection of information about the
machine and then give up. That would roughly be today's behavior but
with a controlled exit rather than a segfault. However, the purpose of
this tool is largely to create a zip archive. Rather than creating an
empty zip file or no zip file at all, and having to explain that
behavior, it seems more helpful to bail out clearly and early with a
succinct error message.

Reported-by: ks1322 ks1322 <ks1322@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Thanks for the report. This could be one way of fixing this.

 I haven't found anything in the original submission [1] discussing this
 "_GENTLY". I didn't see anything in the implementation or the tests
 suggesting that it was intentional to run outside a git repo.

 [1] https://lore.kernel.org/git/xmqqzgg1nz6v.fsf@gitster.g/t/#mc66904caab6bc79e57eaf5063df268b2725b6fcc

 t/t0092-diagnose.sh | 5 +++++
 git.c               | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t0092-diagnose.sh b/t/t0092-diagnose.sh
index 133e5747d6..49671d35a2 100755
--- a/t/t0092-diagnose.sh
+++ b/t/t0092-diagnose.sh
@@ -5,6 +5,11 @@ test_description='git diagnose'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+test_expect_success 'nothing to diagnose without repo' '
+	nongit test_must_fail git diagnose 2>err &&
+	grep "not a git repository" err
+'
+
 test_expect_success UNZIP 'creates diagnostics zip archive' '
 	test_when_finished rm -rf report &&
 
diff --git a/git.c b/git.c
index c67e44dd82..ff04a74bbd 100644
--- a/git.c
+++ b/git.c
@@ -525,7 +525,7 @@ static struct cmd_struct commands[] = {
 	{ "credential-cache--daemon", cmd_credential_cache_daemon },
 	{ "credential-store", cmd_credential_store },
 	{ "describe", cmd_describe, RUN_SETUP },
-	{ "diagnose", cmd_diagnose, RUN_SETUP_GENTLY },
+	{ "diagnose", cmd_diagnose, RUN_SETUP },
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
-- 
2.42.0.399.g85a82e71e0

