Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531123308B
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5PIoP83"
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64818E
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:00 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50906f941so98291111fa.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058838; x=1700663638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOdlaTs26TqwmEEb3Dw5BafzxV1HRx4XSvhePv1jFvQ=;
        b=k5PIoP83IyzDaoJ4+hdMG3R7I9T5vY1gEQ+cQ5cDIKF1hAvF/pkTu1XCVg7A+MVGaw
         3o7cJfozaaNrurQ0Mwx+Mykvozy3w5zWpTFqw2ErlX+PB6/JuL++mBHr1NKSk81qfRBp
         7ICiR8XO8K7PcTuVBZb5sBLKHbOhuTJ/qeuniRyN28xkn7N39Ts1SJogKZ4y8esX2t7j
         OHdFeCvz5Sbzp+tMTa/rwe9mmAeFMQ5kXoMn1YBWXRPqPs00DgVYeoIY5FRPBQ2DYeHZ
         w30FgH4uFpMWB68dfN8IRPs3g2VZN26P0PRapCHjdUG6wIc9DGyeCB4hJzvMN50SdIHP
         Chow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058838; x=1700663638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOdlaTs26TqwmEEb3Dw5BafzxV1HRx4XSvhePv1jFvQ=;
        b=LxuBPD57Zt/UB91eO1eVspu0F91UqSDAIv0ymEaIpzHlMHbLPmoRUqjrhNwB/SMAD8
         Cw2LDcWh0kXhH9qRRk501yaDt62adeB0itj90tuwQyTwxEl6d6kOB5YXdJX6gYwVtb+m
         Br4mn+JE0d/CX9IliEJE1kt5L/DBAObnFjLMt86hyF6LqsnpFqW9cxXKwnT3BZXKksNn
         Kj5EsUnu+nAf0yYTjw0mvWKnJJYLl4w2vTvuEqz45G3HYfParupCCcu3/5jxoyh4Fv04
         k+kxji9elAyid/nkr8HqaFxuQeYDcB04uVWv/fTUHzyKjdGEGqUSqNgsOix8r3BgBMo/
         DRsg==
X-Gm-Message-State: AOJu0Yw2MbI1ZqlMdNYedmtgEQYzCkgtDVNxoMxbcy4VeHTZ8Rgn6MiZ
	1a9yVWjMz03TKTXU7QiSVKIJjBHOSxI=
X-Google-Smtp-Source: AGHT+IH4Zaq9ipn1KEV0MCMdAPf4a9civ1BEbeO8gRGJOaJiboJdaCRbsuA5auasHQGzP2JsfH4Q4A==
X-Received: by 2002:a2e:8810:0:b0:2c5:13e8:e6dc with SMTP id x16-20020a2e8810000000b002c513e8e6dcmr4205421ljh.31.1700058838292;
        Wed, 15 Nov 2023 06:33:58 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:57 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 09/14] replay: remove HEAD related sanity check
Date: Wed, 15 Nov 2023 15:33:22 +0100
Message-ID: <20231115143327.2441397-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

We want replay to be a command that can be used on the server side on
any branch, not just the current one, so we are going to stop updating
HEAD in a future commit.

A "sanity check" that makes sure we are replaying the current branch
doesn't make sense anymore. Let's remove it.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c         | 8 +-------
 t/t3650-replay-basics.sh | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 1035435705..30292d219d 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -123,7 +123,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto;
 	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
-	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
 	struct strvec rev_walk_args = STRVEC_INIT;
 	struct rev_info revs;
@@ -162,11 +161,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	onto = peel_committish(onto_name);
 	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
-	/* Sanity check */
-	if (repo_get_oid(the_repository, "HEAD", &head))
-		die(_("Cannot read HEAD"));
-	assert(oideq(&onto->object.oid, &head));
-
 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
@@ -275,7 +269,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
 			       &last_commit->object.oid,
-			       &head,
+			       &onto->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 			error(_("could not update %s"), argv[2]);
 			die("Failed to update %s", argv[2]);
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 36c1b5082a..b5b9f9ade2 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -48,8 +48,6 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git switch main &&
-
 	git replay --onto main topic1 topic2 >result &&
 
 	git log --format=%s $(cut -f 3 -d " " result) >actual &&
-- 
2.43.0.rc1.15.g29556bcc86

