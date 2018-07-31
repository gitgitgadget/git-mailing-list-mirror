Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326FA1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeGaOsA (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:48:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44606 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732188AbeGaOsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:48:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so16573586wrt.11
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zlqt0uWKUYKNqDLyYY4X6TczHz6cUQdZ0ox8oxjEcJo=;
        b=J9rpm/rXY4fD8Ry3bZzpR9NgYx3P5jYkZsrjli5FsRlpo5jhXmRcj5O8r3L4iDNHsa
         5I2Ugu2k/VXrvr1cC32I8Nsta7US4fCjFpdA8l0oLw7mMeu6RssUhgbeKpAP5BBKiyWM
         SaRtFQMgN2KiW2OwXz0aDsNJSl0TSre65TUUn7UktYQxbNEK7FxS9hnLSRqRsr1mdIbD
         226n+8sE5kda7qJ5COd7GtcaB2vDzmgw/5FStHfttvUBFKkf2DZQUmU9Uvv7WpF8vlcc
         ywl2unP77/Jmbp5DL7/gzowvuj6cP1A9LrfkQpumN4tM+NC6rVqnEGJVpU9Xv0YdYQ4r
         L3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zlqt0uWKUYKNqDLyYY4X6TczHz6cUQdZ0ox8oxjEcJo=;
        b=hVap4/kr4FXrk65UFO9ROClKmQCdTgnxdvbbDT1yi45QT5JuLHitOGtXjPED0YsQ7G
         NT87zQBmrx8J4a7QtzecNRyHPYpo/+vtiHd6v6xE7iDVEu+h0Jt+zQG0ka0ceTBKIglx
         W5bj3ZqvzC2XqEsnbDWtzTYt0ZZ3xqUuAWoaz5FRJDyDu+UQi9BuDcbrsGOeYP+nG0Uz
         2tyd+LItmtpH5pOx73H2ZhBtlw8s4pFunzcTRfM8nTsthN9Nh1cWKu04OO6gDvK7oV4O
         Rw6sCLQCUdw0P/ghv/me0zbLf00wVcpC/ND9dXNn//sdJW5gu2Q9FDJS5S3lG323xT8J
         2mwA==
X-Gm-Message-State: AOUpUlE66fRJrGKQAOcJQ5NDTVrThNQWpcIn1B8prFV0tvOCCwtQN0Zs
        ZeI+Rcl57uX+5GM13BzqRa1fp69w0cs=
X-Google-Smtp-Source: AAOMgpfCUiVQbimmOqEQ/lKlZtj7chkEB+agbWkl3SL5oxLUd75RIL9wrwFnPQxmsX6Erzbx6Ksz6Q==
X-Received: by 2002:a5d:6892:: with SMTP id h18-v6mr20909966wru.108.1533042462874;
        Tue, 31 Jul 2018 06:07:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] push tests: assert re-pushing annotated tags
Date:   Tue, 31 Jul 2018 13:07:13 +0000
Message-Id: <20180731130718.25222-6-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test that asserts that lightweight tags can only be
clobbered by a force-push to check do the same tests for annotated
tags.

There used to be less exhaustive tests for this with the code added in
40eff17999 ("push: require force for annotated tags", 2012-11-29), but
Junio removed them in 256b9d70a4 ("push: fix "refs/tags/ hierarchy
cannot be updated without --force"", 2013-01-16) while fixing some of
the behavior around tag pushing.

That change left us without any coverage asserting that pushing and
clobbering annotated tags worked as intended.  There was no reason to
suspect that the receive machinery wouldn't behave the same way with
annotated tags, but now we know for sure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 82 ++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4bd533dd48..1331a8de08 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -965,43 +965,51 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
-test_expect_success 'force pushing required to update lightweight tag' '
-	mk_test testrepo heads/master &&
-	mk_child testrepo child1 &&
-	mk_child testrepo child2 &&
-	(
-		cd child1 &&
-		git tag testTag &&
-		git push ../child2 testTag &&
-		>file1 &&
-		git add file1 &&
-		git commit -m "file1" &&
-		git tag -f testTag &&
-		test_must_fail git push ../child2 testTag &&
-		git push --force ../child2 testTag &&
-		git tag -f testTag HEAD~ &&
-		test_must_fail git push ../child2 testTag &&
-		git push --force ../child2 testTag &&
-
-		# Clobbering without + in refspec needs --force
-		git tag -f testTag &&
-		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
-		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
-
-		# Clobbering with + in refspec does not need --force
-		git tag -f testTag HEAD~ &&
-		git push ../child2 "+refs/tags/*:refs/tags/*" &&
-
-		# Clobbering with --no-force still obeys + in refspec
-		git tag -f testTag &&
-		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
-
-		# Clobbering with/without --force and "tag <name>" format
-		git tag -f testTag HEAD~ &&
-		test_must_fail git push ../child2 tag testTag &&
-		git push --force ../child2 tag testTag
-	)
-'
+test_force_push_tag () {
+	tag_type_description=$1
+	tag_args=$2
+
+	test_expect_success 'force pushing required to update lightweight tag' "
+		mk_test testrepo heads/master &&
+		mk_child testrepo child1 &&
+		mk_child testrepo child2 &&
+		(
+			cd child1 &&
+			git tag testTag &&
+			git push ../child2 testTag &&
+			>file1 &&
+			git add file1 &&
+			git commit -m 'file1' &&
+			git tag $tag_args testTag &&
+			test_must_fail git push ../child2 testTag &&
+			git push --force ../child2 testTag &&
+			git tag $tag_args testTag HEAD~ &&
+			test_must_fail git push ../child2 testTag &&
+			git push --force ../child2 testTag &&
+
+			# Clobbering without + in refspec needs --force
+			git tag -f testTag &&
+			test_must_fail git push ../child2 'refs/tags/*:refs/tags/*' &&
+			git push --force ../child2 'refs/tags/*:refs/tags/*' &&
+
+			# Clobbering with + in refspec does not need --force
+			git tag -f testTag HEAD~ &&
+			git push ../child2 '+refs/tags/*:refs/tags/*' &&
+
+			# Clobbering with --no-force still obeys + in refspec
+			git tag -f testTag &&
+			git push --no-force ../child2 '+refs/tags/*:refs/tags/*' &&
+
+			# Clobbering with/without --force and 'tag <name>' format
+			git tag -f testTag HEAD~ &&
+			test_must_fail git push ../child2 tag testTag &&
+			git push --force ../child2 tag testTag
+		)
+	"
+}
+
+test_force_push_tag "lightweight tag" "-f"
+test_force_push_tag "annotated tag" "-f -a -m'msg'"
 
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
-- 
2.18.0.345.g5c9ce644c3

