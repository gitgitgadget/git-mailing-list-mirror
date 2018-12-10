Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CD2B20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 19:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbeLJTFC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 14:05:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45006 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbeLJTFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 14:05:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so5383404pgr.11
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 11:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9SzZNIk/Cn/fmaBtZfyKZBsp3rAoqSrzsZE84O5W3yo=;
        b=KwEfdPJdkDcKvx43k5KxEIdKSFvka61+YHPsHRZzhzGutt+kHBp4z7x88RyfUQWlfQ
         aqnsALh2P2aSM37ttpOPFYmEzO4qXlwyTqOR7m5tcYjamWz8p5dTjwSUGDOhFPKjRACt
         CEgYutqXvJ0w5YvzxsWUyYFIeCOqmlgGXReT/NqzGrnJXA3EwmY6bQmjXuCBjS/9IEWZ
         MCdi6JFWXMztt9fEoDCf9PsoJo5zlhESHxaxHQfiNEKNZE0LXLnWs1p1BKxnSQMsgrVr
         lzAgJ5v6O+nDQWEcEw/0L1Wfe0nAff+raQn6a4y3Jdh/caP6x+l6gLrvZQKrJEN22J2R
         4k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9SzZNIk/Cn/fmaBtZfyKZBsp3rAoqSrzsZE84O5W3yo=;
        b=frVNihSo5dhRqipy19XYnAiNABXYLvFYDB02AfnTvCPhmJxIC9ATM/TFngYZRqpFoZ
         Zs2wHbngBwwLZK9BzIz/NiST7khjroM+us+nAIj346vdIJ8r1QzTVcFf5Kje9pKZFfWI
         22/AAycb6ED7jh4xn7joOg0NBvVRWRupWN2tVru5eSoZy7DfkRL82haEO4omsrOaCwpl
         q2723/PUi0ohteCGZe+ouqu2nBj/sY7viKAkV30IcuIiZ9UaPN0mexsas1d5ibPiHwVG
         9geGIAtLMCuiW8bt0S7qE0z6mOfvT3HzQ5RitQ1NY6tQvw+2RLlzlX2+f1yBBhoz9uC4
         RkEA==
X-Gm-Message-State: AA+aEWZyPURCK2J0ARHWg0LJz7dQe8w/q0iNjN/dMGGcKN3Fcwhl8Hsh
        D9EQCFYv1b8OqjAysZ3Qiyyu6QIJ
X-Google-Smtp-Source: AFSGD/Wlz9N4ua1QxpMF5nVX2KUNO3fqizP4QwK3v36EebrXW1loTNpy9QK+LGcSSB5XxUkb2GfV5w==
X-Received: by 2002:a62:28c9:: with SMTP id o192mr13668069pfo.57.1544468700721;
        Mon, 10 Dec 2018 11:05:00 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id f64sm23381023pfh.0.2018.12.10.11.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 11:04:59 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:04:59 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 19:04:54 GMT
Message-Id: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.90.git.gitgitgadget@gmail.com>
References: <pull.90.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] rebase: add a config option to default to
 --reschedule-failed-exec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It would be cumbersome to type out that option all the time, so let's
offer the convenience of a config setting: rebase.rescheduleFailedExec.

Besides, this opens the door to changing the default in a future version
of Git: it does make some sense to reschedule failed `exec` commands by
default (and if we could go back in time when the `exec` command was
invented, we probably would change that default right from the start).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/rebase.txt | 5 +++++
 builtin/rebase.c                | 5 +++++
 git-legacy-rebase.sh            | 2 ++
 t/t3418-rebase-continue.sh      | 7 ++++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index f079bf6b7e..331d250e04 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -64,3 +64,8 @@ instead of:
 -------------------------------------------
 +
 Defaults to false.
+
+rebase.rescheduleFailedExec::
+	Automatically reschedule `exec` commands that failed. This only makes
+	sense in interactive mode (or when an `--exec` option was provided).
+	This is the same as specifying the `--reschedule-failed-exec` option.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6d556fc6c8..06e450b537 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -677,6 +677,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.reschedulefailedexec")) {
+		opts->reschedule_failed_exec = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, data);
 }
 
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index 5f0f0c5ab8..1b268a5fcc 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -99,6 +99,8 @@ case "$(git config --bool commit.gpgsign)" in
 true)	gpg_sign_opt=-S ;;
 *)	gpg_sign_opt= ;;
 esac
+test "$(git config --bool rebase.reschedulefailedexec)" = "true" &&
+reschedule_failed_exec=--reschedule-failed-exec
 . git-rebase--common
 
 read_basic_state () {
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 54b26a9284..bdaa511bb0 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -257,7 +257,12 @@ test_expect_success 'the todo command "break" works' '
 test_expect_success '--reschedule-failed-exec' '
 	test_when_finished "git rebase --abort" &&
 	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
-	grep "^exec false" .git/rebase-merge/git-rebase-todo
+	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
+	git rebase --abort &&
+	test_must_fail git -c rebase.rescheduleFailedExec=true \
+		rebase -x false HEAD^ 2>err &&
+	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
+	test_i18ngrep "has been rescheduled" err
 '
 
 test_done
-- 
gitgitgadget

