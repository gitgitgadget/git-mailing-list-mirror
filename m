Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623E920A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbeLMP6m (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52419 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbeLMP6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so2884495wml.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EpzIcC4gmhmYqL5ckoFLkikS8r+/HeNlLvhyavD1tF4=;
        b=qEobOcO0SoqTGnc0gotoYG8op2dWr6bHF2cxK8OhoivCdZ8fDRFoJAudXIoAP+SMRU
         YUio723TBcTXolSSVYDQNxdmyXdbbTecvrO4m5Na+pLQmVEwblX7/FuPrwIJ13/yT/uM
         PgVWV1x5DbXsBp9UQMV2jAd985FuoqcIZLH3xs3lPxYuv3T68eIVVf+2TMx6/RyUthiE
         ORszgZnhpoijr+uxTwPpLhBmwvvMH3iz5FIOZsPQeW2hOMCWaADaZ72Uhnkqp0NhtP5Q
         5L/dDekwb83azcbrjGkrIgYxjPqBz3gHnHzcOG8PiVPqnDVMEvEEbXFbpFTLTXFTw/Kl
         1UPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EpzIcC4gmhmYqL5ckoFLkikS8r+/HeNlLvhyavD1tF4=;
        b=Bt/hUPVpWCWIBRsrDr8L6abIqiAUjjLStaGMOcNU8xFqWIWbKpRsG8CgTjKqkd/EPp
         RpIGk90NbiRn8OdNVCyk2KIGwgXuyiJyt5vVlxWZCGGh++OT0L1ZGyfBJixmhDumAwsr
         Z5EkOk2B2BaHRRWdKyYYhrrd0cSS8pJYM1PY5jbEAsSDPFtsocRZ/gX0RCpQgkgx7by6
         5GUz2zMTzt8QPZxwrFqWlvi36BLc9frMXG9s+MqXbzzhp8M/248n8gAsip28DLZnZZ+o
         lnCb1CUFPPGEJ25pEXIbHL60MmzkD6EKyFntgfOSSzjEB9JLltk5VtAz8fsK2H46u8Fh
         UcqQ==
X-Gm-Message-State: AA+aEWbVa7KPze9VXx9NHNtJIjijf5IalILOWHYhYgp8Rz+OFQDYAKkj
        FT+y0UZaSLLUFoJ7vS7pxU/24q9w1Oo=
X-Google-Smtp-Source: AFSGD/VdgsXha5rCpzN41ZfOMBbVvCV1hfcdcmlU0tfnO1kmwJ/0ftbQ5ubYxGJRfy4qd/LTNCc20Q==
X-Received: by 2002:a1c:90d5:: with SMTP id s204mr10724153wmd.148.1544716719203;
        Thu, 13 Dec 2018 07:58:39 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] builtin/fetch-pack: support protocol version 2
Date:   Thu, 13 Dec 2018 16:58:16 +0100
Message-Id: <20181213155817.27666-8-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Currently, if support for running Git's entire test suite with protocol
v2 were added, some tests would fail because the fetch-pack CLI command
dies if it encounters protocol v2. To avoid this, teach fetch-pack
support for protocol v2.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch-pack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 63e69a5801..f6a513495e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -55,6 +55,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	struct packet_reader reader;
+	enum protocol_version version;
 
 	fetch_if_missing = 0;
 
@@ -219,9 +220,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
 
-	switch (discover_version(&reader)) {
+	version = discover_version(&reader);
+	switch (version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL);
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
@@ -231,7 +234,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
-			 &shallow, pack_lockfile_ptr, protocol_v0);
+			 &shallow, pack_lockfile_ptr, version);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
-- 
2.20.0.405.gbc1bbc6f85

