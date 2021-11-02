Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6539C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E5460F70
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhKBPsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbhKBPsu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD671C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d27so16040371wrb.6
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C7FXMXvdgKpKIQ79mjqFgY4VI91Yh5GAcfct/8ErWpk=;
        b=ITmDOIsVr//KZ15rjWSt+MwpzatB0jOvESFGB2gq+yoeDzuqmLMBRIPioG1mGT19ct
         e0nLIJLomTgUp27KGEVbHk/k26TtVevRnP38wbZh00eCaoU1q1fsEGolVslyu6+HL9P+
         lbtUn6a4ZK1koH+Diwv/V9pPZvXiILY4o1SZ3Hyoyr4NifkqOYMUFHrlfFlz4H3uztQM
         9ng3s7+0qoGJwNkNdTWaDVmd7c89K8nSWr22xgUV5d0btap/JU5Uyb5AfLTEw3Kbg2i8
         DmAqEZSB2Fm5dqbMLykpneE5BaCrD7O4mUo6C2BKwHWSFQlO+VSpo79wYRmhD32Txet9
         awgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C7FXMXvdgKpKIQ79mjqFgY4VI91Yh5GAcfct/8ErWpk=;
        b=Nncxxdh3MQcSQZ/e07hmTVkAVWPTw773CV/00bCoWflltJDrki6+vAga8I/Sc9CwI6
         CBI5YL/nQHchJSoWJXWNVaeTAuxpWRQwaEQdjIaD3fz8gPUZwUyKJV6pIHS5B6ImmN7H
         9+jy8z7VGIhppjyw6FY9UeAb2F/p3cKPBf/KOmC8rtQIMNiXP0d5ZAzzqZXhM4sj9EIO
         42ZjQiRB2n0aUXF30y7kcDoHWP3/oJXQ2DZqX77UnEc86GeloqHUt6mgPRsrlR6+qktS
         AtY1bwdaDjpHelImRWc+7NQsAfwmGxa5+W99Vd0+0ZboAbu6PSyL6WmNb7irmdhfr3Dc
         YdPA==
X-Gm-Message-State: AOAM531gZdtD4l3xAxlcPckHQ1YpZxpU/yyvA4sRSEUYt8mTnreneanR
        fzwoKv40K06xn7RHcUhne3ZMoFnJ7A8=
X-Google-Smtp-Source: ABdhPJzQEEuyO1bnESXWSwrQF6ABLvKj/7pYEVHUsASKhuqSApDDoAj2CgTo0Vy+31e+8cLxmTiiCw==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr45175506wrr.385.1635867974200;
        Tue, 02 Nov 2021 08:46:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h22sm1609605wmq.14.2021.11.02.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:13 -0700 (PDT)
Message-Id: <052197200141c321118b7766f5615a61f951e59f.1635867971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:05 +0000
Subject: [PATCH v4 2/8] test-tool genzeros: generate large amounts of data
 more efficiently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In this developer's tests, producing one gigabyte worth of NULs in a
busy loop that writes out individual bytes, unbuffered, took ~27sec.
Writing chunked 256kB buffers instead only took ~0.6sec

This matters because we are about to introduce a pair of test cases that
want to be able to produce 5GB of NULs, and we cannot use `/dev/zero`
because of the HP NonStop platform's lack of support for that device.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-genzeros.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index b1197e91a89..8ca988d6216 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -3,7 +3,10 @@
 
 int cmd__genzeros(int argc, const char **argv)
 {
+	/* static, so that it is NUL-initialized */
+	static const char zeros[256 * 1024];
 	intmax_t count;
+	ssize_t n;
 
 	if (argc > 2) {
 		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
@@ -12,9 +15,19 @@ int cmd__genzeros(int argc, const char **argv)
 
 	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
 
-	while (count < 0 || count--) {
-		if (putchar(0) == EOF)
+	/* Writing out individual NUL bytes is slow... */
+	while (count < 0)
+		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
 			return -1;
+
+	while (count > 0) {
+		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
+			  count : ARRAY_SIZE(zeros));
+
+		if (n < 0)
+			return -1;
+
+		count -= n;
 	}
 
 	return 0;
-- 
gitgitgadget

