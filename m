Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95755C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiC2Aoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiC2AoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B780239330
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d7so22599392wrb.7
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ebJFCI4F0cWCTTRJ8U340O4g9iVrZ+6k6F3XALLE/c=;
        b=i1BleUB6ONiRQiBa1SRXsILZa7NnQ1OiufvFSSKaDn5qsGJiHuQUAF4PRs97WYujzK
         g+8O4MwGn+Lt1BwrpnqIi2ztteYz9AYz95raYwCey3k5DhuLkOpBrl/v/Or7SkvEfimq
         4j2MXyg/0PUNddQQiTvWd73h2RkBIVTJeDjFxLlbRMKFvDKbOVuI18oLS9PMYg5giI3L
         mFJpG+9pEvTcsZID7Jzg6ZzyCeRUR6wC7fmEAz/g3EfwFkKndum7CDKHDzBB0V9j1WYx
         geUtaP2+YJGI4foOhuPznoVoW5BW+3qcllGdb5khmiycTYD6fkNfwW9StidJ//MdNF5R
         FTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ebJFCI4F0cWCTTRJ8U340O4g9iVrZ+6k6F3XALLE/c=;
        b=H0I8vZeSqELegtv6KGGtBFQG/p26l+XKDQzXzju0KQ/MBlW7iLCGUB22Xq2HyboEiy
         nYQpq0y0aNYHfJY3BY5v7Xaey9gDuhpyzhXp5LKTix/MXv4uZ8XG4XPWBEx89uePia/P
         XG+lm3jLyLxG1fuxZQCIa3R83Kj8TYSkQch+4N8qjmxR7itB/01Jsbbv3Lbpw5p9HaFk
         U8/+9164QquEsPcqu9dox73XSx3eb7QNq8zqxIfBiUc3lAhdYcEbZMdguatz5UitbrDh
         YjnE4o30Bl8SioXvai/74jUttSs9OED9SwZfCib45VMSWamR3xFAZtO2cfMIf8kF/Hxl
         58zg==
X-Gm-Message-State: AOAM533bBYdenn5DhjDLeWsSnS4iTyc8UnMgq7m3BvH/ubiX9XzGib8Y
        4A/JNBgjKS4O4LTw3ny1Ib13HAhhbVQ=
X-Google-Smtp-Source: ABdhPJy4uO/bnGMdt6HVGBhpW29aTK2w3BwmCuhGVYUJu3bObJXvy+zxpL5MRDA8dQXRyHt4QMBdCA==
X-Received: by 2002:adf:e241:0:b0:203:f56e:51e3 with SMTP id bl1-20020adfe241000000b00203f56e51e3mr27592548wrb.473.1648514560873;
        Mon, 28 Mar 2022 17:42:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14-20020adf828e000000b00205b0fc825csm7955880wrc.65.2022.03.28.17.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:40 -0700 (PDT)
Message-Id: <d85013f7d2cff17f279fa2d13569a65f42eebf60.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:24 +0000
Subject: [PATCH v4 07/13] unpack-objects: use the bulk-checkin infrastructure
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

