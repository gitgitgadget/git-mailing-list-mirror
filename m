Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A6DC433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiCXFAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbiCXFAK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115C2A715
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so6512651wme.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ebJFCI4F0cWCTTRJ8U340O4g9iVrZ+6k6F3XALLE/c=;
        b=jZPpODWadMEqA6kN+VmIWir2miYSpIScwNR2tDRUH1ZcAhR4s4LzCR7btq6sHpLBDr
         Qhl7ZmyCZZweZsQOTYXCg5S1orA+WrM8Ni9hngPWZYnKxwzHDBeXsxIOLbahqYAcqB5A
         /cixAlTuekhXPV44QgDWieCJGAtoukx4DbnwmDRiijGCCTxREG6+UGhH+S37ryCzrdLX
         IGGXsnHZtdx2Z7PWwcw1qCTJFSvXtGO8ErcCc+NvSd7aTmojQEu112ks7ftUT366OyY6
         6FSCoLxUKSHz/HhCk+xPIEi3N27KaFThih5AhxLzvpRLnGJ9vWpP6dhf0oMnusfFUg8z
         iDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ebJFCI4F0cWCTTRJ8U340O4g9iVrZ+6k6F3XALLE/c=;
        b=wCL5LkAk9xkpsNWnUaaBzJ64UXTf2SNNINkcCHhlUOdPZkbwawhuiaA8SCd011bQ0O
         dbb1L7qTebkGr7o8WHGIYakUY2aTMrcZmvDyNB4GJz/zcVuBQMkZXJOl9YRRsu/RX5Wu
         AIUTdAaLJQDO3h949s2rDjEr4GaRTNPEu0qJu2lw7KZF4oS9s49izZnUcTx2zjCn3Y9l
         4tzlAmfMNQ6wFFDvxvpcH653VGl7ltoIc/rBUIDASACNvAW74wz6Wx7vsLfQ50SwhRQn
         78TfUTMcz/QDs/qEJaQYClgU3YF03w7pCV5cgg5v2CPJk9ueoO8HioBfb9NN8iXeJeZy
         XQeQ==
X-Gm-Message-State: AOAM533BwrAgCOHonoYL27ZMwV21STwo75YtRQarb/YlmbvLxXGhhyqE
        g4jdfBiVs5aayEZc4u6KfgzAQUybHxA=
X-Google-Smtp-Source: ABdhPJy2QmpgfmNTeyPq4fAHN7koOu9cvWk9UWQFBHWtw08BIfdAMjj1bKEqX5+RgiUbzDMrCUJ4MA==
X-Received: by 2002:a05:600c:4f15:b0:38c:b729:4838 with SMTP id l21-20020a05600c4f1500b0038cb7294838mr2986582wmq.132.1648097917083;
        Wed, 23 Mar 2022 21:58:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d63c5000000b002040822b680sm2300831wrw.81.2022.03.23.21.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:36 -0700 (PDT)
Message-Id: <84fd144ef1889aaf4f88040a60cb8b156522e1b4.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:21 +0000
Subject: [PATCH v3 06/11] unpack-objects: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The unpack-objects functionality is used by fetch, push, and fast-import
to turn the transfered data into object database entries when there are
fewer objects than the 'unpacklimit' setting.

By enabling an odb-transaction when unpacking objects, we can take advantage
of batched fsyncs.

Here are some performance numbers to justify batch mode for
unpack-objects, collected on a WSL2 Ubuntu VM.

Fsync Mode | Time for 90 objects (ms)
-------------------------------------
       Off | 170
  On,fsync | 760
  On,batch | 230

Note that the default unpackLimit is 100 objects, so there's a 3x
benefit in the worst case. The non-batch mode fsync scales linearly
with the number of objects, so there are significant benefits even with
smaller numbers of objects.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/unpack-objects.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dbeb0680a58..56d05e2725d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "object-store.h"
 #include "object.h"
@@ -503,10 +504,12 @@ static void unpack_all(void)
 	if (!quiet)
 		progress = start_progress(_("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
+	begin_odb_transaction();
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
+	end_odb_transaction();
 	stop_progress(&progress);
 
 	if (delta_list)
-- 
gitgitgadget

