Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA4DC433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 07:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbiCTHRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244957AbiCTHRa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 03:17:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B43C3374
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q20so6939295wmq.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uH9KeiJNcsWuHeLIMulApi4ZYs+kLt8o7kPraRKdbBo=;
        b=gDt2LhPlaNcmukbUF6qoVkK987x1Bn7wKXqYksdxyn2Chp2jePJmQeCuI3SHZmHNIs
         cnPY2bwAHyyQ119wYKmDyWIg8gZBkE4XU94nd7wQk8yZB2TGLk+0qpu3/i1tpINVavpA
         yQPMtmSyFWwF4NauZpuoiJJ0vOF0iIzToG4sukTkehbeL3spUX26MgjInfvoEk31SvuQ
         BP2noCFb6l8sk6+D6GNsBCFHl1+BpIf/QJTFf0Em2OeLysKd+nMK0YPPwYZ38UsmsB7B
         osYDRY2Y36TvS8GXa4ww0dygjq5SBl9EXaw5+6sRJpApRAZ+w7RNDAqQ5I9XbjXEsB3i
         HgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uH9KeiJNcsWuHeLIMulApi4ZYs+kLt8o7kPraRKdbBo=;
        b=ApKwQ+T2Kh3X38bXGkW9HkmzuPAjvM/5s68FtRkVFLmrGwrzLNu2Yn26U+drLlH5e+
         EBW8AmK2Rc/p99fEq3ajSNrrZFIQjcGB62nOgaLNJAUjS6xOXtEYRaraOairpIY5eMqS
         wEN1cnDyNn7a+YcHCFtB3DSdV2v2fPyjWYGtF0dZ3y378DbLf6FbtvtjjpU+1wYDlsoC
         cRof5o11ufE/dLhr4Zb3a8HibjCWPpIwWEiT5kXw3lI7G1MSE5Q8fury0VH8r8NLGsiR
         JimBn8dwW6V0AIopuX77bgk7ABXSdcSvW1mZgSUaieZ2dEAn1OUkUf58JtwQZaKqTYVs
         nqgg==
X-Gm-Message-State: AOAM530RbfoPbj+atAFR2QuSoKLNyEOatEpCCTqK08Qu6hMnL96lVN5t
        U7x9hzKPwtlF5rF4CCV6nWd2GnKh/QE=
X-Google-Smtp-Source: ABdhPJx6jcmFWydKLZE6rEROGpUEffteQ00I2WCcyYnTum2k0oc/L+dpFIY7ruquTU1CdYKp9n/8Hg==
X-Received: by 2002:a7b:cc12:0:b0:37c:1ae:100a with SMTP id f18-20020a7bcc12000000b0037c01ae100amr22197581wmh.54.1647760566538;
        Sun, 20 Mar 2022 00:16:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b00203f51aa12asm5638966wrq.55.2022.03.20.00.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 00:16:06 -0700 (PDT)
Message-Id: <6662e2dae0f5d65c158fba785d186885f9671073.1647760561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 07:15:57 +0000
Subject: [PATCH v2 4/7] unpack-objects: use the bulk-checkin infrastructure
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

By enabling bulk-checkin when unpacking objects, we can take advantage
of batched fsyncs.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/unpack-objects.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dbeb0680a58..c55b6616aed 100644
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
+	plug_bulk_checkin();
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
+	unplug_bulk_checkin();
 	stop_progress(&progress);
 
 	if (delta_list)
-- 
gitgitgadget

