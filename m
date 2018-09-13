Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02291F42B
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeIMXND (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:13:03 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:36387 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbeIMXND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:13:03 -0400
Received: by mail-pl1-f169.google.com with SMTP id p5-v6so2949121plk.3
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7pOMN3l/b4ziuxVezIX6mLt4cpjx8qscyj3hQtH8GgY=;
        b=egY0RfxXm2H94Oog+KMDSILoJFRGFR1qaLjFbVScdUcQCexOIc35nzmQyTYiLM3diz
         +dvHXETHA7Uf0DzFNtqkR3kkTnlqoZHwtieMLVkxyLIksR9iXHfMOWpRurihE6EVjynt
         RnjNT719mMW2AzMaD397G55DV0MIL8U2dsStfOUCq2bm+EPiTpIcBScP+Rxwl7eRyk1S
         Z/u0OmIYcyrTs/CQ74wbNKv8zc0Sko1M1YPjdYBwzZug1IVBYxFFBew6g1serWLGWHJq
         +La6OgC138K1n3LYBKWQ7hOd/Klr48JFgnP1JhT+Kktq2nRVv1R7ZR0uHKx+fPYeLXdB
         YFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7pOMN3l/b4ziuxVezIX6mLt4cpjx8qscyj3hQtH8GgY=;
        b=pgr0/H/qoGCJJdzT3rNXSbHce44ODcCGHMwwPf6m6uZ59PLJbfSNySgV14GE0ei9mR
         QI3w+4+F58cQOLBDuNTDoaXoVNkNfO6s06ydklLZB3aSiEHbGQKbGpnwwI1k7Fxr2ROA
         lIojWK5OvUafXgFvoHFynw3TetJsGlZkrwZ20Suzh6RTL7XWj5jCWIpzYMNLAI9WfCRV
         j7hNIaa3evED8h+TRG4zhAdehbz1IPxgbgvprQO8BQXLm13rdUcYY66SQ06mAzEbY2BZ
         Ld++i033lragPcLPjtCvUqjgTHmqCEuaqOye9maYzuZXz17hNkkpGThUvyqlMgHsmvoX
         xEXA==
X-Gm-Message-State: APzg51Bvj7pbTqYr10bmiEEXWmKtHIW4P2B82hEPSUfPZ3oEBuZfpg7B
        wAjypOD5BjkW9M8KioAg0xWY6OcX
X-Google-Smtp-Source: ANB0VdYJ4OO+Jclms+S9MRhXX2QbjTfIlkyd9fK1/5tvxsClFHD/biyyUb5VbX6Gvc6Br3UTihxHow==
X-Received: by 2002:a17:902:3a2:: with SMTP id d31-v6mr8281986pld.287.1536861748717;
        Thu, 13 Sep 2018 11:02:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id a2-v6sm4755627pgc.68.2018.09.13.11.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:27 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:27 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:10 GMT
Message-Id: <406c88b456c06bc42a9bb23bda48b6b3be461435.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/11] fsck: verify multi-pack-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When core.multiPackIndex is true, we may have a multi-pack-index
in our object directory. Add calls to 'git multi-pack-index verify'
at the end of 'git fsck' if so.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fsck.c              | 18 ++++++++++++++++++
 t/t5319-multi-pack-index.sh | 13 ++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 63c8578cc1..06eb421720 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -848,5 +848,23 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (!git_config_get_bool("core.multipackindex", &i) && i) {
+		struct child_process midx_verify = CHILD_PROCESS_INIT;
+		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };
+
+		midx_verify.argv = midx_argv;
+		midx_verify.git_cmd = 1;
+		if (run_command(&midx_verify))
+			errors_found |= ERROR_COMMIT_GRAPH;
+
+		prepare_alt_odb(the_repository);
+		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+			midx_argv[2] = "--object-dir";
+			midx_argv[3] = alt->path;
+			if (run_command(&midx_verify))
+				errors_found |= ERROR_COMMIT_GRAPH;
+		}
+	}
+
 	return errors_found;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 828c240389..bd8e841b81 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -160,12 +160,17 @@ corrupt_midx_and_verify() {
 	DATA="${2:-\0}" &&
 	OBJDIR=$3 &&
 	GREPSTR="$4" &&
+	COMMAND="$5" &&
+	if test -z "$COMMAND"
+	then
+		COMMAND="git multi-pack-index verify --object-dir=$OBJDIR"
+	fi &&
 	FILE=$OBJDIR/pack/multi-pack-index &&
 	chmod a+w $FILE &&
 	test_when_finished mv midx-backup $FILE &&
 	cp $FILE midx-backup &&
 	printf "$DATA" | dd of="$FILE" bs=1 seek="$POS" conv=notrunc &&
-	test_must_fail git multi-pack-index verify --object-dir=$OBJDIR 2>test_err &&
+	test_must_fail $COMMAND 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$GREPSTR" err
 }
@@ -258,6 +263,12 @@ test_expect_success 'verify incorrect offset' '
 		"incorrect object offset"
 '
 
+test_expect_success 'git-fsck incorrect offset' '
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\07" $objdir \
+		"incorrect object offset" \
+		"git -c core.multipackindex=true fsck"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget
