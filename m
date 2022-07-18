Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7FEC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 08:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiGRI4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiGRI4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 04:56:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBDAE4F
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:56:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso6906319wms.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nrcacq+l3FkWlUuxOxQkOjl46KYNtYfrLG9ZTmefnf4=;
        b=YhXYA/bvDZ/0HvevZfBljBp+Pl9Ak53ndjgz33jk6pV+08iU9mV3VIAoZ9PK7D36wv
         Y3d6bLcpQQK3LLbbd8uZSGhiMctkOfplHBExgBQDPm5No5dx1VOKAEDNZh1IipydQVK9
         E02OVS/Y6Y/VTBkv0MDnM5j0QcQzFCQ83185ipC03IX0cSa3R6OAlTqn4lZl7RRJ3Q7e
         beG5ut7BZ02Gb9h/9FJmTxIspLvFw6qNh/P436pvNLEkBH88OkZp5YfoX7OiUSy0afgd
         /Wd/Fo6+VXqrnXQhDiDjxgx3f1GU4H9w1WKbK8CX4wEJ4ANZTg5ACBqQrObjTj4WdiQl
         LzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nrcacq+l3FkWlUuxOxQkOjl46KYNtYfrLG9ZTmefnf4=;
        b=gbj1qapNeSPaOGHK225xjSJh8gFLO6Lp6EF+TqxMrDYNs0jfLxf3+M/sGvQ/2DiQR+
         W6DSNWCpYWdVRCqPoNFKuFV4F/Mvy4LsjBkspJxSQ0VvsNyuM9eHUJTHGOmSgwRC6DPm
         bPYL07+v3srO3MoqvzdHR2k+aFzd5FYI9N+f0yO9FLkTsMElLZprwh0S0269cp17TSCy
         OrOIYxAPcah43NzIMNfY0S4WcC5jyxBUOEUTYtYg8OQ+kHJFfhVVWDD5LWdhAMo9cSGy
         oMBrLuDnQaV0R9sIkN6DFXqCpDtKsYSCKH4re9mSWdeu2AvXZgCIWJYrDILBsuhbRwfA
         lEiQ==
X-Gm-Message-State: AJIora9p8uBqWtxHFO19Fn31Triz4bJllYd+pybzrnhOCioitKprwLAz
        QftyRlHiST+e0Pc2KI132LaoUL0cOs8=
X-Google-Smtp-Source: AGRyM1tspN8NDZPMjrIi8JrDWqRYs3/9ZKJcM61OX7TPi+he9Zd5enydfHA/z7y97ccsfkSnxqxMoQ==
X-Received: by 2002:a05:600c:1908:b0:3a3:f85:702a with SMTP id j8-20020a05600c190800b003a30f85702amr13085822wmq.157.1658134607869;
        Mon, 18 Jul 2022 01:56:47 -0700 (PDT)
Received: from localhost (92-249-246-211.pool.digikabel.hu. [92.249.246.211])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bc8d4000000b003a2e42ae9a4sm1134762wml.14.2022.07.18.01.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:56:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] index-format.txt: remove outdated list of supported extensions
Date:   Mon, 18 Jul 2022 10:56:40 +0200
Message-Id: <20220718085640.7395-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.527.g8ff01757f9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first section of 'Documentation/technical/index-format.txt'
mentions that "Git currently supports cache tree and resolve undo
extensions", but then goes on, and in the "Extensions" section
describes not only these two, but six other extensions [1].

Remove this sentence, as it's misleading about the status of all those
other extensions.

Alternatively we could keep that sentence and update the list of
extensions, but that might well lead to a recurring issue, because
apparently this list is never updated when a new index extension is
added.

[1] Split index, untracked cache, FS monitor cache, end of index
    entry, index entry offset table and sparse directory entries.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/index-format.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 65da0daaa5..f691c20ab0 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -26,8 +26,6 @@ Git index format
      Extensions are identified by signature. Optional extensions can
      be ignored if Git does not understand them.
 
-     Git currently supports cache tree and resolve undo extensions.
-
      4-byte extension signature. If the first byte is 'A'..'Z' the
      extension is optional and can be ignored.
 
-- 
2.37.1.527.g8ff01757f9

