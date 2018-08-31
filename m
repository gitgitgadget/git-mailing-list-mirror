Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501FA1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeIAAT2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42858 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeIAAT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so12258957wrr.9
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5/vRCmjBeBSmFcS9HvRP/U8lwC1Grh7+YwMG3Clby0=;
        b=FoBPDkkrdeDToztCHSK368i+X5mVOlr1B+uWic6O1LN3DsmaYIgDX32+koJ4tVVIlt
         ctHOUsl99QXhqyYfotEfVhl5hK49tDgHvPFqOG7RP+RQLbsmo5Iz5kQqvW0/Gq3FhmV6
         Dreq6zZJOnxz+Krg3gy9P2lDlcbymFfqeTZjuzaEJpJYBOx4NH/9dwC9lwoBNxqtA6pX
         PZLUSmgPzVq/wQZvaPTAwrUMRhVCSDNaeB7rUuuAocxIOsdQ8wMwItC+zY4HJJUJD9Mj
         hYFruoOy1+1uboaMlMw+Ybqqs1eNqi5EIAztyl+/nH6HD2N+Sniwyu9BaQbCs4G4ojbW
         u8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5/vRCmjBeBSmFcS9HvRP/U8lwC1Grh7+YwMG3Clby0=;
        b=oTsxDVOoB7x7zBSmJt8Y4bKhB1+G5RfgjSCvCBsVamU6k/N+va+mwryPdsBoxvxMlu
         vxX3EOP6hST808P7+aEAnJzTQ7SrkSBE8FZU9MgiZgId2ADfmi4sNYg9BNGEO9pm+wFO
         hPp6N3TO5YpsRkVtbTCNn1Tgr2XZfQa1D5ntBv0e5bZSXlsTb0kpIV7MK1VSnO0qpMNC
         5cUkJ1Fxv4vh4YXX0an5Ngw3MUcqx+ckQzpPlSv/mCvAfm5QdQhHrqT7KdzsmwX0Pado
         J6hKNaOFFa3jX2HoMKp1NZ/t+DM9FeZHaXb1logCYDSdhyiC5mPgN9mnkqGLzI8HVITU
         BIqg==
X-Gm-Message-State: APzg51BqkMsqyVGPV1cCPlbVAH1J3RLqM9zsKr+C+uY/txckVsLFM1DC
        ABCu+JXHOh5FOhEsGH6mlM9TZZKcils=
X-Google-Smtp-Source: ANB0VdaW0LsgkZflX2ab+HzVaTOFYuIkYplnl4IFhbB4OBIiSrCD5TDCD8HZy1ZFTkrW0gcekjMrEw==
X-Received: by 2002:a5d:6604:: with SMTP id n4-v6mr1221354wru.281.1535746223628;
        Fri, 31 Aug 2018 13:10:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:22 -0700 (PDT)
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
        Marc Branchaud <marcnarc@xiplink.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/9] fetch tests: add a test for clobbering tag behavior
Date:   Fri, 31 Aug 2018 20:09:59 +0000
Message-Id: <20180831201004.12087-5-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180830201244.25759-1-avarab@gmail.com>
References: <20180830201244.25759-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite only incidentally (and unintentionally) tested for the
current behavior of eager tag clobbering on "fetch". This is a
followup to 380efb65df ("push tests: assert re-pushing annotated
tags", 2018-07-31) which tests for it explicitly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8b67f08265..7f3d4c4965 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1011,6 +1011,30 @@ test_force_push_tag () {
 test_force_push_tag "lightweight tag" "-f"
 test_force_push_tag "annotated tag" "-f -a -m'tag message'"
 
+test_force_fetch_tag () {
+	tag_type_description=$1
+	tag_args=$2
+
+	test_expect_success "fetch will clobber an existing $tag_type_description" "
+		mk_test testrepo heads/master &&
+		mk_child testrepo child1 &&
+		mk_child testrepo child2 &&
+		(
+			cd testrepo &&
+			git tag testTag &&
+			git -C ../child1 fetch origin tag testTag &&
+			>file1 &&
+			git add file1 &&
+			git commit -m 'file1' &&
+			git tag $tag_args testTag &&
+			git -C ../child1 fetch origin tag testTag
+		)
+	"
+}
+
+test_force_fetch_tag "lightweight tag" "-f"
+test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
+
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-- 
2.19.0.rc1.350.ge57e33dbd1

