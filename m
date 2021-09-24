Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA6FC433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DC26125F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbhIXXzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 19:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbhIXXzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 19:55:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB7DC0614ED
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d6so31935818wrc.11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=bDcdRT/gXz5c864Jhg09hYknmkBjA2X5VKTssYJzYp6nmEiTWCI8OfAsniP2pDUWK7
         WJggUsdixyN6dDiclkCWINPmAWGQQdySp3N3rxHmLktoOMj1O4djxsPcucuPDr4Uvf93
         SjRaGVoUkDV7445NWA4GlYM8WEP6tpRkwSK+a1VyqFC7W4HqL/AD8czSpEUsyd+HClvx
         8PQLS0P3jg9vY6TZLbTqLkrUBgz+3/JTL617YhmfcT9CVTV5P5ibrUDBf4XdjuOaNISy
         5psbpzxY6morA8uWksxy05hckS4ziCbueullRTlYxxbYmXgPAu9pW5dxvY3QcNL2fkIW
         s0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=Kc1aAMaVc03fCf/Bw6te632dm4OLbQemxd7wH2HMwR4bf1rtKkh51PDj4To89d/nRL
         QrSMQF8gZXybY8wX/Q4zCiugNUXhvY9/kpinSqIhGP51LqSlIM/D5+dxBzfPFnOr2BPq
         2AVk4syGq/CNCNND6XxaGCqM1qTQUtFuSruMf6LAPKDePbxsFXr+MX6HJMcoKIp1Eubo
         5VW92xtMZJx8SA+VP9jB9TxXK/KK73eNqzYG4wljVBFlZmGYzcFXQ+9ayJjO/iETHd4Q
         RaWmR3D9aUNZfDEDzgArW8OEyuX5yLU54VWlMXNNVCozjIMSdkhsBwW1lcAZMAjRL6Mr
         23Ug==
X-Gm-Message-State: AOAM530NqoAtSF/Q2Wtb/uskjU3m+BCTb2NcOvRCEk/LEwiDsy4WwJK/
        gm9W/hajW3bawAkGx5h10oYuiHYk0Cg=
X-Google-Smtp-Source: ABdhPJyqDzEdqXe8tP0ZlXoihOsKGwYCWlZL4iXBvxLQ9Rz654ianflZrnAonwSPsWNQ4OGLJmPxJQ==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr13779371wri.391.1632527613677;
        Fri, 24 Sep 2021 16:53:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 135sm14561510wma.32.2021.09.24.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 16:53:33 -0700 (PDT)
Message-Id: <e3c5a11f2252e0045801b3b5cd4e78e1b279e7c7.1632527609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
        <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 23:53:27 +0000
Subject: [PATCH v6 6/8] unpack-objects: use the bulk-checkin infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index 4a9466295ba..51eb4f7b531 100644
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

