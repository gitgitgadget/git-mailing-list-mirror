Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7D51F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeHaAQy (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:16:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaAQy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:16:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so9191562wre.2
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=935uXarO7z5ov9r7Ov+dQ7wpQIMpyiEeYXDcUBX496g=;
        b=uhs1DBp1NX1XnH7AwE8k3eRqBN+LWgKY/r8BA2tHDt7y1TLXt1xtqXMr5UR5OiaJrK
         IH3HQVE3r1ajNFC3O3hDWAoqn7Ax/aynp4LXSd1Q9qgOh4ZSPlBPnoPRsWmMMQ8fLq1S
         NXmxX/WcTzzATHUlj7g1fd6x7Ke4V3sxDPw11o+W1dYqRol8dRcf1Ek/314CHrzRbVTr
         9CkgOJMWNh4nbdfz4pM0YUiZyiscaDXe9Y2gHf+mXLZFE2Kx2NZBCpVUrNH4r4ZzvGF2
         ycQnZQCgUytcrgKp3qdeKTNFY4kCXGzzKbcpX7dCxVJ6Tli0ZX95PA+ibgm12BjO0PrB
         tL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=935uXarO7z5ov9r7Ov+dQ7wpQIMpyiEeYXDcUBX496g=;
        b=e9e6MMK+A4LTc/xxxsuW/T9XTLB7aIGrTp40Btac7q31NXmPeAFFgylXPsTtvOL2kv
         MWOiOPqZ7GhwfPwBZXG5knAw5eNYH2CDvoTNEqBW+0zFqGdGa9DbcXtff5OoErg5QSDR
         fHvlt8WnYuagmGdV7qTHzfWcQ9hndkKs9wm3wFJ85AOT6ZxWeV9BHWF+Hj2+HL3LIO/C
         rAkcQ2XyvvVm4/koBMavtHVVQehsGeq/t2ufiMAUSuzJM+oR5BY+gbARrnoWNRxuaAol
         EF6NxCA2UbuX6hLo21EGr0oocyypIXDfj10+C40Uq2ljjFKzRUFb/8R5Qf6JUx/eOeNu
         cWBA==
X-Gm-Message-State: APzg51BQGadSFZzwvOPsgwPfInJiAKYhYr/bA3o8dzk1J3J8pX71jrf1
        4RqCRl2OZMN6x1TWG8UHkk4Dus5z
X-Google-Smtp-Source: ANB0Vdbg6Janes0M+7jGnbLRYaesJghlYgnHwXl9Msr813iXqeoXh7lsVl7eMKmKFcmHO0furfIwPw==
X-Received: by 2002:adf:f906:: with SMTP id b6-v6mr8282237wrr.28.1535659980463;
        Thu, 30 Aug 2018 13:13:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm4903639wrr.88.2018.08.30.13.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:12:59 -0700 (PDT)
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
        =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/6] fetch tests: add a test for clobbering tag behavior
Date:   Thu, 30 Aug 2018 20:12:41 +0000
Message-Id: <20180830201244.25759-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180813192249.27585-1-avarab@gmail.com>
References: <20180813192249.27585-1-avarab@gmail.com>
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
index 69f7c9bfe6..3cde72ae47 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1011,6 +1011,30 @@ test_force_push_tag () {
 test_force_push_tag "lightweight tag" "-f"
 test_force_push_tag "annotated tag" "-f -a -mtag.message"
 
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
+test_force_fetch_tag "annotated tag" "-f -a -mtag.message"
+
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-- 
2.19.0.rc1.350.ge57e33dbd1

