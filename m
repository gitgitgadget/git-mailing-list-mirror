Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5C420A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeLMP6d (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38686 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbeLMP6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so2924435wml.3
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaKxaf2tGfDJdn4Nhfutom5XIpCxc2Kl9ALPF0K9hAU=;
        b=DFLa1St/FcJ7ZxNB53yhFkYPXo1TKQqGrUgTVzOKcCSOQJfMUXRLVbYToDrb1v0wT2
         E9YkHV037M2nvRPGlaiHfsZuaa4RS1ExzXlDRn7nV+1Yw33s7YUiNn2J411PCYSIpuAa
         ifLMB5xSaiDLlhwPPaI/bO40qCsAXrDNFPWAtsvT3gy+PwduFbfDWLrPF7ktD+aV2V70
         3dX78xxGgW++AofEUXIaKlFIL6F8MhBryyMtT5q0wXbljCONheIlfEKHk00EFYjnD4P0
         X/g0wwcXpCgPCPTknBcUkZsQoa7HStlq1bx5/3yvh9knFhbYkMsq1HXMpQlRjxbnCSeY
         zrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaKxaf2tGfDJdn4Nhfutom5XIpCxc2Kl9ALPF0K9hAU=;
        b=HgMzrXHN38Y025Fof6TVDuFV6UFHl3Ci38q9v5gBJc1cynv72qcUlz1Km888HrfL9A
         CFlzIQSoxSb0giXO1dHbzSmPzlXW1LGzP/cb9a7+NfMvnVDoRqOexquuJRtkd11bw5Rr
         bK2gbDpGInUlHgq0KRS+t9V4oSfMjX+iXPdpQxDRpzzVBOwPBZ4V+tQX5hlSb7UdaqxY
         2KURiuwVOpy0ST8ogxYGI+cUyq0AY46tB7VzLF3KoJx0uQFtU/3g4W7WaI9h8JBbUBE/
         +1hgKwYvyXK8CVVw/dG7CSTHcVn4A/b6D3YmWKnyc45I9vXpT4wdc+p6dAAmuG9Xo7Xm
         mquw==
X-Gm-Message-State: AA+aEWYx3JyvGo9ZF47DWEB9c58n9ggbJNroavt2OEQgn3r6pidNWRBD
        4UZ+JETyo1Mze0R/MlvbF7P4kfYw
X-Google-Smtp-Source: AFSGD/Vgd1XmiRvzaDbhP/1pAbXvhnF6zq8NLcUtihSa4T5/am0m1fv+H9lAPxnURug6duBeouY6TQ==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr10613277wmc.50.1544716710420;
        Thu, 13 Dec 2018 07:58:30 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] parse_hide_refs_config: handle NULL section
Date:   Thu, 13 Dec 2018 16:58:11 +0100
Message-Id: <20181213155817.27666-3-avarab@gmail.com>
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

This helper function looks for config in two places: transfer.hiderefs,
or $section.hiderefs, where $section is passed in by the caller (and is
"uploadpack" or "receive", depending on the context).

In preparation for callers which do not even have that context (namely
the "git-serve" command), let's handle a NULL by looking only at
transfer.hiderefs (as opposed to segfaulting).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f9936355cd..099e91d9cc 100644
--- a/refs.c
+++ b/refs.c
@@ -1267,7 +1267,8 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 {
 	const char *key;
 	if (!strcmp("transfer.hiderefs", var) ||
-	    (!parse_config_key(var, section, NULL, NULL, &key) &&
+	    (section &&
+	     !parse_config_key(var, section, NULL, NULL, &key) &&
 	     !strcmp(key, "hiderefs"))) {
 		char *ref;
 		int len;
-- 
2.20.0.405.gbc1bbc6f85

