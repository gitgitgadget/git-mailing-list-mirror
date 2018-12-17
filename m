Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94AA1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbeLQWlM (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:41:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41221 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeLQWlL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 17:41:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so13941834wrs.8
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 14:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+eI8+5x2DQP1nlfXq0Fwxy4352wgwMrXkHFjxfInBo=;
        b=npTt3k9VM/BCNBFDD9xjlmsBDaDBcS1SqBYe+3p9y+zQp++BmEhRs4vzKDm9aJjTlx
         /QWtJWKObHmZRvzql9N2uoQnv9UJaR2TUbOlz/DBp/4c6Drr5SfLd6CR0+k2pVNTf3Fc
         i8hH162jyZ3ZL5QhYh1xFB7CtQ+NzfKA0yW7GPrV5X1WJYc5UiX6iVGL8+91HaDIfwKW
         Zrp39XTQf5MqiaUZiQ34gMP9FpwP3nwcL0aYG/Axs8LAZCxewnaHKxLBrzWhs3gNqlVj
         Ww9ZBjNVTMiQRGwLFoBc3qok3gBwHRWpjbK0/+1fovuoJR1SXHksSuDMR/XdpHpmGJy8
         JlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+eI8+5x2DQP1nlfXq0Fwxy4352wgwMrXkHFjxfInBo=;
        b=mPQaspD0QCrcI8SBKeQzSzJxz7D9m+1tkE5+2bOb+X2STEnveiVNj4LLVt9D+f8CAB
         OTcmJpPXvCRK39EdLSydSrw2vaNULwO3JBaZKbFXMLouuP/aOnHm0QXPBnxBk1Vqb3vT
         K0EKu8a4R0NtSDyBUxy1fY8B9JLzSEO1sZCo9IKnDpyy1GmuweLNMtng9C6DspTlfaE1
         vlK+obWXmuX6EkEQJIMnfGCMwXk9kBjfrUU/WIO+cpZQBgSKxdvSPVNOKWr4ejRsMqLF
         rBlhwD2giuFH2AhSaZa7p76Tg7D5Zrr8Tnb9z6YpBIL9w4IfgdZgB6t4QO31e3RiiDpT
         SBHQ==
X-Gm-Message-State: AA+aEWYBIiTbrqFVKtgh9wR2lu/4GhS2g/i2plqEP4Zgz2C7xRfsUCFe
        qmQKCV4PIol4/Rd4gzocnqVVc8VIPLo=
X-Google-Smtp-Source: AFSGD/Wu1n42uaXTllCHLsmiHu0O3x9udi+CsD3Toa/XmozvvhdxfDkYBW8wAMvEcdhZyxDRgS5zpA==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr12384905wrq.265.1545086468855;
        Mon, 17 Dec 2018 14:41:08 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm2208199wre.64.2018.12.17.14.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 14:41:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] upload-pack: support hidden refs with protocol v2
Date:   Mon, 17 Dec 2018 23:40:53 +0100
Message-Id: <20181217224054.4376-4-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181213155817.27666-1-avarab@gmail.com>
References: <20181213155817.27666-1-avarab@gmail.com>
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
index e8e31475f06..8a8143338b4 100644
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
index 32e722db2ed..ca69636fd52 100755
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

