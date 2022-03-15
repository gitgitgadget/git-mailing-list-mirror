Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCEC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351979AbiCOVcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351795AbiCOVcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:32:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAEE5BE42
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso361567wmr.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uH9KeiJNcsWuHeLIMulApi4ZYs+kLt8o7kPraRKdbBo=;
        b=DYHqBzxvJP+vUf1Jp/eSbsRq6+ipFXpGp3nfKEYIVIGu4MkchPVlMEpF1B0Krrsk9f
         qad4gxJ6gykYV0tz46ngLX0A8oqVngXd/ChHoQbjF3aMto+0kVqWhY5wnL53MIQyzO53
         vOEpHyJKL4v+oNMVqIwGwlyUeXQHb+afvuVVWWskoooQoFn7p6d3csGoeaxwp9SLSyi0
         Dtjn0RjLHwwviT+EA3ID+VTmr7NuLr9yBmolJfXxp7wd1y1sj1JCVWLxhD/nFa+s+9lI
         /roHENQMiYLnqU8lXVwDA3fHvmzCaDGIToDYTceuwN/qmzCSCRdj0PfiDHhJc0VBLYHX
         rJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uH9KeiJNcsWuHeLIMulApi4ZYs+kLt8o7kPraRKdbBo=;
        b=RhQh9vOYawztS5MB6L+F9jFstrzCH7U26Rn1fGHGQ0zVinDOuptMydWQ85AqjBRDIz
         2nuoHTWNgXMSAlfPBlI49hHmWjIyt5RsIUbdwfmztgGaleqTqyk/RS/+tIO6bFbjaIOg
         eDJGQMU+gTKruPv4aG9OSH/YLr7oLk1M2wrIn6jpVAy0RCDirldsr7zWE8Fq/y3mBZWB
         2f6QozNTEdDagvFJUyHdqIFktD2sTniwRv1IqcI8GWHwGmxUrht+KDicuAl5OEMyFD8k
         +ZMM13km7DEGE6+LdMGlR24WJ8ZXbv1VTZFge4f4rPMhERmEwImz+uJ+bB1VjJd3u+jI
         9PYg==
X-Gm-Message-State: AOAM530bSFH0M4tklJ5R/QUwq6NdbKd2ctd3VU9utrfg43xUXQ+t5zRb
        7yMKRdsGg38AaligrySJeIXgexMbISs=
X-Google-Smtp-Source: ABdhPJxoT0oVlf24tZ11PT6ezBIdqXJe1Dgga/vMPfBhkUxCRdgbVP4JM6DFOFaxYBRe5say0Tcgnw==
X-Received: by 2002:a05:600c:4a12:b0:389:d7f7:fbcf with SMTP id c18-20020a05600c4a1200b00389d7f7fbcfmr5039600wmp.158.1647379864278;
        Tue, 15 Mar 2022 14:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11-20020adfe80b000000b00203dda2388dsm101183wrm.30.2022.03.15.14.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:31:03 -0700 (PDT)
Message-Id: <99e3a61b9191e4102529c8b90b36e0f96f2b23bf.1647379859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 21:30:56 +0000
Subject: [PATCH 4/7] unpack-objects: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, "Neeraj K. Singh" <neerajsi@microsoft.com>,
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

