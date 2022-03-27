Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC189C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 11:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiC0LZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiC0LY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 07:24:59 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C665F4F
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 04:23:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F25FD5C00E3;
        Sun, 27 Mar 2022 07:23:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 27 Mar 2022 07:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=NiCsvDdZ4JUHay3PaZ68UWP117gbx3
        SwmlpZSLcEUGk=; b=J6y7bdDWDlPt4XPsPD9mlNxcPvR+VacIm8XBmEvrSNjN63
        na/SwWmg7HufvSg70U++ttgua2SdojqCIFvb1D7gopp8GFV3aEc7xrgjJecIG743
        NdJ80f3KApUS0rojnaRY01Leng4wvRvO+HjUt3apHR4XASHcdkzAwnyLy1NsJz2i
        NBysO4xGb5zeCrTykQXFj5CKRXtVc15cCwXq8+bEdvNsrxjTWsO5pRNwqmXObNkg
        VMQAudxewu+FX/8ekzvjCU65x4ZqnlF1jPCYY2BCClDPAdHuTk6SdJLRDRIihO08
        tCTbR9rN+u1C+yoZZNvxCASDlaRkG/pmPj4DCn0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NiCsvD
        dZ4JUHay3PaZ68UWP117gbx3SwmlpZSLcEUGk=; b=Z32SnIrE6iy4rugvUtlGbx
        y6G8HwDsXNCcIHW0HBebPgxuqRLhJWwnH60qZKV32Mt6/3FBGGTySPg1gREqmv8w
        tXzeZB9MVAghQI03TNxjvqwdSpEFyAwQvIUiC6nmDJBA/HmDSjkxvk3Geolk7Eob
        eGsoTJmtckMUJUald+wjGXk3tg4KmtEoolvD7LIWOhskXlOq4O32nMBKzvr1UYij
        g63UuFyZHykffVY03d7iRq/g92Grs+UzVvk9DVnyF/SswipFq3AG8DqadYe9gkDi
        OYWOajHay8xdJu+r9ZcP7REI4ZkiR4pA0kYLf43FgoSDiij3OHG+zbvpU0Ox8jKg
        ==
X-ME-Sender: <xms:JUlAYs5iNP3d4Os8EsGLW9H7iRWD3Ovr15C8Of36Z5F-VYtiTYInrw>
    <xme:JUlAYt5B8eFiFMGl2fPhMkdhnfbRkfzB2Vc0c0A2rmDRTkq-u8xJN5RpZS27VYGKS
    dx47SRW-wXFcrUzBQ>
X-ME-Received: <xmr:JUlAYrfX7ihOrjk0rLWcLRnT_IGyssqcdtacD0nPR159-KuQdrejSZGddgmz8H2cB8Pxj8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehhedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:JUlAYhKvF9c9Hrj9WHgR1tlK1OQ81X8l6d2C3jT1FPo-87KRSuITww>
    <xmx:JUlAYgJ7OxkxYL8rBQBk9zMUIWVgKTVclk9WvrX0Au6gj0Z213EdWw>
    <xmx:JUlAYizIldFLncGaEqq1jPxv_ooR9So-V9MjtXxi5A7HLhmOMl5h-A>
    <xmx:JUlAYqiTTp9sOUXI9QCMTifTOAaZS2xlGDzOyn0GmNfVD7jZzaYIoA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Mar 2022 07:23:15 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v6 2/3] vimdiff: integrate layout tests in the unit tests framework ('t' folder)
Date:   Sun, 27 Mar 2022 13:23:06 +0200
Message-Id: <20220327112307.151044-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327112307.151044-1-greenfoo@u92.eu>
References: <20220327112307.151044-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new test case file for the different available merge tools.
Right now it only tests the 'mergetool.vimdiff.layout' option. Other
merge tools might be interested in adding their own tests here too.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 t/t7609-mergetool--lib.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100755 t/t7609-mergetool--lib.sh

diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
new file mode 100755
index 0000000000..8cfc22e27c
--- /dev/null
+++ b/t/t7609-mergetool--lib.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description='git mergetool
+
+Testing basic merge tools options'
+
+. ./test-lib.sh
+
+test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
+	. $GIT_BUILD_DIR/mergetools/vimdiff && 
+	run_unit_tests
+'
+
+test_done
+
-- 
2.35.1

