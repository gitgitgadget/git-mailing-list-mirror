Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F5620248
	for <e@80x24.org>; Mon,  4 Mar 2019 12:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCDMIm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 07:08:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39902 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfCDMIm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 07:08:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id h8so2979842pgp.6
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JVA+GkzWdsJGlcTGekmDcMcJaLx93SLrrzyO/DPvW6s=;
        b=RmEz/JtQlvZpZsByDaPHqIG9QkV7IkxU4MmAr1AuSTpesG+ef4axk+Qm2szA1gwoK+
         rHJWLw1Tuk3xvCYtKdfkmAcFiH/djtv40jF1Hpu5+CzYuw/jfFZU3Gvs5KEvHZWdHj/T
         ipdyIDiW53ZN8kF0/PtW1ZFvGaYAIazhzFxzgpjLiN+uPBXElSA1vtVE4eiWUfdujKh1
         dKb5jnpdRA71bH8k3YV8OTjaW+rb5NOltUSzI62EFjU7qzNjP7Sk8bFXlNlC15kZLudy
         uldR11OdSu75niQRPBUykmImQ0XNWaCjQyf501m0/61pYh609Y1qpatV/tUgQoQcjA60
         hFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JVA+GkzWdsJGlcTGekmDcMcJaLx93SLrrzyO/DPvW6s=;
        b=c5o1DiBqwrHLKn1cYfx11nEfCxw2m8ZnaZDVq4/Zv45v2vu0N+2uTu/xvBwooxkNFn
         AqRGrVbk/FOl404V5eMsnLXnRkZdg+prdrRX2Hjl4I3JR81EbrJosWvcUm1dc8NYMSYk
         mo/jsZSYbvfWekBn11nnPjykLvTTgUrYwSXH1EePHnTR63GRWra0pt08pm3verWBYlx0
         8UjGycwpHWUj2Ta4uJAEeEUhnWXRp+o+/h+XcJr7Qfn0EFxD7QhI+7lE4a5BS9r8ZCBC
         uT8V/VvHi0B4OIFr88RGpCyg7LOgT+OyNdcrN+7R8Mn9yjMZcfzKXcGet5gyl2SwVp5E
         woUQ==
X-Gm-Message-State: APjAAAWXyl+LxZbA/D7uUnFDp9POu9RdgPja1DsQ5r2POTv6daRzCpCT
        rScoEADDU5qQUv+iVoqbVgI=
X-Google-Smtp-Source: APXvYqzESPNCAqgOtJsXpQ5OgwbiZpGHgxwaRslQZQwfPnmOujt+vRohAsRWziLQaSnmUNWoFn4Rng==
X-Received: by 2002:a65:5c01:: with SMTP id u1mr18205250pgr.197.1551701321500;
        Mon, 04 Mar 2019 04:08:41 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id b138sm18791686pfb.48.2019.03.04.04.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 04:08:40 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v3 1/3] test functions: add function `test_file_not_empty`
Date:   Mon,  4 Mar 2019 17:37:59 +0530
Message-Id: <20190304120801.28763-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper function to ensure that a given path is a non-empty file,
and give an error message when it is not.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/test-lib-functions.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80402a428f..681c41ba32 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -593,6 +593,15 @@ test_dir_is_empty () {
 	fi
 }
 
+# Check if the file exists and has a size greater than zero
+test_file_not_empty () {
+	if ! test -s "$1"
+	then
+		echo "'$1' is not a non-empty file."
+		false
+	fi
+}
+
 test_path_is_missing () {
 	if test -e "$1"
 	then
-- 
Rohit
