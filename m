Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1952720954
	for <e@80x24.org>; Tue, 28 Nov 2017 21:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbdK1Vcd (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 16:32:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36180 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdK1Vcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 16:32:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so2234801wmg.1
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 13:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eu6fEjgiRk2679JIFiBxIWKlmTdE/2Aoruzsd1gev74=;
        b=C8hc+7RAPxv7KaVCD5GCh1nswxzrDmLpbvj6pQ6nwiqa5DQNiULxQPVeZ1TGZUBu4C
         NkdlETTanoMTDZrGwaDaL+qJ1TgtxxTqsM1dYk9XTH+N5FE6oHcH5p9naNpG4hc2rsM7
         z3yImM1rZkxxL6wjuLVfrWt8JppB1w+zikCHApPy9GqnaVhnTAHmgPyCHheXyrVScIXY
         y1aljLYMGT0DjAsRp0/4JXtYpzVu1rZBJynjsNgDTX376V5g4E4coC1R1voP61X9KvzN
         SNE5sLUb0ftBvbffSmiz9DSY5wnlJrzB++4NmGPytEc+I/ofAXqv5FX0KIRqSHCy4AHh
         CqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eu6fEjgiRk2679JIFiBxIWKlmTdE/2Aoruzsd1gev74=;
        b=BdCTX8Oq79o2vGjTgWgWvnf/MAi0xxgjyERiZUsc7YotsCvtMQswI20cJwRWimNHiU
         JliglyJDm+KN7d9JeOSz3Pae/nuxZ/aNupe2OvjS2BQAWx9OPlhmF4A54eO7Dts2LBl+
         kSQn+2p4Svj34hL1D2wdP10ZWmhLWEj52o9AHgMx5NGXd/88olu8U7xgY6FDdrBNeLHk
         Sx/DWVWRbBNCA/Bww7JYDkjDQTVQI40cqgX1jRswcvaaR8L6mtwwhjjX4394J1dZUX3p
         UDXvLpeTha6RCTSxd2btK/gVgCqetDItJBwOx8sezxJRaB6XU9FNr6yyQFORoN/92ngi
         GfCw==
X-Gm-Message-State: AJaThX5VfRiittbDFl/AIRWPD3vgilbuE8GTfTxsYWR9vakm5bSnvdLa
        /9UmDwZyw9jCPo5vBW2KMGuZfuXm
X-Google-Smtp-Source: AGs4zMbq5wN2A+WWmhSx9tWUVMd/qiJ0Fz4UWOTDCTGKqmoc77vTK+xpopI9v+aUoTQ6Fkd5LZjITQ==
X-Received: by 10.28.137.80 with SMTP id l77mr773235wmd.24.1511904749207;
        Tue, 28 Nov 2017 13:32:29 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d18sm147361wrd.54.2017.11.28.13.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 13:32:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
Date:   Tue, 28 Nov 2017 21:32:12 +0000
Message-Id: <20171128213214.12477-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
In-Reply-To: <20171128213214.12477-1-avarab@gmail.com>
References: <20171128213214.12477-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent change will change the semantics of DC_SHA1_SUBMODULE in
a way that would require moving these checks around, so start by
moving them around without any functional changes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1dc_git.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1dc_git.h b/sha1dc_git.h
index a8c2729278..41e1c3fd3f 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -1,9 +1,9 @@
 /* Plumbing with collition-detecting SHA1 code */
 
-#ifdef DC_SHA1_SUBMODULE
-#include "sha1collisiondetection/lib/sha1.h"
-#elif defined(DC_SHA1_EXTERNAL)
+#ifdef DC_SHA1_EXTERNAL
 #include <sha1dc/sha1.h>
+#elif defined(DC_SHA1_SUBMODULE)
+#include "sha1collisiondetection/lib/sha1.h"
 #else
 #include "sha1dc/sha1.h"
 #endif
-- 
2.15.0.403.gc27cc4dac6

