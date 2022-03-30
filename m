Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE9C4332F
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbiC3FHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbiC3FHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC4D66C81
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so27527331wrg.12
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ebJFCI4F0cWCTTRJ8U340O4g9iVrZ+6k6F3XALLE/c=;
        b=bGyhwMSlcIM3pgO/RPkKirETu2KgJ5/z7bLsZlG9CQQ2EK360HFD8rWPV+jzH4u41q
         nPpHInkp0MAhLxpJXTVofWXLN4+G6VwDUs9F6oHlp/O+AlKAz5edaH3+UWVR0vfk+PG0
         +FKCEwzRQXZSVkSu9l0VpQvXEaGfrACl2J5SpIi9jSW3ijayoxq4sfhVd2/DkiJuzZz2
         yrQvgKLfQFJ04Izrrlx3Rwkn+CBxlztgrJhT49MCzuEKzim1Kh8tqan6LDV8Su4/vqtD
         NR6yE3UxptYUW0hmQXmRkOeoNoLikv5LoQhPdWTSVSQtvPBd7MLRUV7xlc0d25+M+x2u
         zivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ebJFCI4F0cWCTTRJ8U340O4g9iVrZ+6k6F3XALLE/c=;
        b=YGEqks31K8rD7T67RV6P4PktTCuCievB71gj9qgoCuTe5o8FGvmwJJ8WP8Yr7BYL4o
         Oa3yzuTzfePE1OJYkFy9THpvhmScVVDuAJGHwf4Pr8eGTd3whdaERKjA0hhmPHIdveqw
         +7KpbOaidwq+5DjHnyocTpVvBNIrXdU3PkSN2rfHkB5LOq36jSkKPKDhvqXyEKJeydLS
         tAMuhMfmh+IcbKG6wm8FhBlvXZoexZLwLDJAICqmrjiPxSYr7zypFlIHdpPYuP6/t6N6
         LQ3VvTtEW4Q77v9WtKTva/TmdOJGiyZdYVoc3CY6iwEOzAfB18L9g5XE3Yute6jrxxEd
         njSg==
X-Gm-Message-State: AOAM530d1IQtm1V3dwEiWRx3Z5e83HjeK3Da4LTd5HmjWD3OyKOi3r2Z
        v0JJTziSl0QeC9+4FS6CVmvoHh6C+34=
X-Google-Smtp-Source: ABdhPJw7UZMOQbSoNIWLMDPk6MyyLjgRrWHJx5ch4NkqhP9GO/kbZV3kCBTHiAfjBDU9K3yrRzxcPg==
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id n4-20020a056000170400b00203d857aa7amr33449963wrc.513.1648616743983;
        Tue, 29 Mar 2022 22:05:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b00205aa05fa03sm12166221wrr.58.2022.03.29.22.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:43 -0700 (PDT)
Message-Id: <523e5fbd63ef85035131bd4cec7565707c290e84.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:26 +0000
Subject: [PATCH v5 08/14] unpack-objects: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
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

