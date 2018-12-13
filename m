Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2633620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeLMP6e (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33985 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMP6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so2563552wrw.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jy4T3ZHPFqxt+jxySEedfbsUnzrKYoqatp8zUKLH4dY=;
        b=OzsaqBp8w1r4jSf1dDGZfbdThc3ELTSTuZ2y3vJO2HcMEoRKh5TQ5ePvVwmTHkqATB
         tYc1AIJa8YBMOr6cygDU+ixrccTXrkmHFvXPDrGI+UWIK0UgIBqNg36poHPz7grzBBES
         qTniW5k8+za973HpRfk/5p2Mzd4yfTivOq1f9TlAdfLSpKMCSpQZMDeXtKu4/HrSY7FQ
         c5YHNamstLt2B1E1wSZzFt5mf8+ucvmkeh1mXP4YkoQYCye/viIIS3/GSn6y3FGnSyqN
         CZy427tM9724rpuHa28A1UYfeFX1MhNbB2DpoMRn7PhUMPtA9hTV4EnEWk93CDHfo2sJ
         7zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jy4T3ZHPFqxt+jxySEedfbsUnzrKYoqatp8zUKLH4dY=;
        b=Rrqm6s3wIEPDXL/v8ddPSoKSLeRRym0uAxQ4iK/2htXCuQe8sFJxu0BnDqMorajbgE
         lXmT+DwfKJtwOhW9pmtRTDayAelfdohRXQnyKVDblZlOxwxbE2FsnUdMrU1FdwCWIVBZ
         Z8+szuwXdfdjyaiMpGXA1rQ+P38GrM26B94DEjVp59VbH8DA5MQodnl5/RmevpBj5Bzk
         XfSDgYPKYU9eDeSt338K4wyaHaWh80j/7LlKld4JgXRRTBhvXHmV9gq4AssSQBZLCW3i
         Q4sOyN47uiGAZrr3DZ8uycKVop1M7PjehwPVPx6pLyjB+xH71EJKXoFgVJPM1wlPOQyN
         Yy9A==
X-Gm-Message-State: AA+aEWZkPRlk3RTDo+hOD07cTZInoDIlh/erNaKH7li9Y825K7UpzeQ+
        yj7gTxTFoLWijY7HIr54wTcpzlrm
X-Google-Smtp-Source: AFSGD/Xcqt9yhxYBaZH8x6ZngY4d3Zk5MG+qO6K9fsYQ6hNF7Xt+3shNCgGy3pknKLQcW+gkyC9xbQ==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr21579048wrq.225.1544716711931;
        Thu, 13 Dec 2018 07:58:31 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] upload-pack: support hidden refs with protocol v2
Date:   Thu, 13 Dec 2018 16:58:12 +0100
Message-Id: <20181213155817.27666-4-avarab@gmail.com>
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

From: Jeff King <peff@peff.net>

In the v2 protocol, upload-pack's advertisement has been moved to the
"ls-refs" command. That command does not respect hidden-ref config (like
transfer.hiderefs) at all, and advertises everything.

While there are some features that are not supported in v2 (e.g., v2
always allows fetching any sha1 without respect to advertisements), the
lack of this feature is not documented and is likely just a bug. Let's
make it work, as otherwise upgrading a server to a v2-capable git will
start exposing these refs that the repository admin has asked to remain
hidden.

Note that we depend on the config_context from the caller here to
realize that we should respect uploadpack.hiderefs. When run from the
"git-serve" tool, we won't have that context and will only respect
transfer.hiderefs. This should be OK, as git-serve is not actually used
for normal protocol operations.

Note also that we don't need to worry about the "An attempt to update
or delete a hidden ref by git push is rejected" feature of
receive.hideRefs, see git-config(1). This is because there's no v2
push protocol yet.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ls-refs.c            | 12 ++++++++++++
 t/t5512-ls-remote.sh |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/ls-refs.c b/ls-refs.c
index e8e31475f0..8a8143338b 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -5,6 +5,7 @@
 #include "argv-array.h"
 #include "ls-refs.h"
 #include "pkt-line.h"
+#include "config.h"
 
 /*
  * Check if one of the prefixes is a prefix of the ref.
@@ -40,6 +41,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	const char *refname_nons = strip_namespace(refname);
 	struct strbuf refline = STRBUF_INIT;
 
+	if (ref_is_hidden(refname_nons, refname))
+		return 0;
+
 	if (!ref_match(&data->prefixes, refname))
 		return 0;
 
@@ -69,6 +73,12 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int ls_refs_config(const char *var, const char *value,
+			  void *config_context)
+{
+	return parse_hide_refs_config(var, value, config_context);
+}
+
 int ls_refs(struct repository *r,
 	    const char *config_section,
 	    struct argv_array *keys,
@@ -78,6 +88,8 @@ int ls_refs(struct repository *r,
 
 	memset(&data, 0, sizeof(data));
 
+	git_config(ls_refs_config, (void *)config_section);
+
 	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
 		const char *arg = request->line;
 		const char *out;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 32e722db2e..ca69636fd5 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -204,6 +204,12 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
+test_expect_success 'protocol v2 supports hiderefs' '
+	test_config uploadpack.hiderefs refs/tags &&
+	git -c protocol.version=2 ls-remote . >actual &&
+	! grep refs/tags actual
+'
+
 test_expect_success 'ls-remote --symref' '
 	git fetch origin &&
 	cat >expect <<-EOF &&
-- 
2.20.0.405.gbc1bbc6f85

