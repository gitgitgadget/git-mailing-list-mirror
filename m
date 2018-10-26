Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075511F453
	for <e@80x24.org>; Fri, 26 Oct 2018 23:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeJ0Hqt (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 03:46:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41443 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeJ0Hqt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 03:46:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so2809221wrw.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dhyh0a5Q4ZaOv+jNYAXOVcm28D6ttv4dilrANYN3DFU=;
        b=nqJcBpVbjCI4nTheZ+nrAwUzJ6Njbqnk7A3EwD2WeK65DJHJkw1gaIaZ9TCMKXs1My
         w0fhOgvzJLQL4Ye7Jr2SHb9ITPd/pB+1ZuHhF0DMnRah4yBINAbqx4fHScnK7i+Qkp38
         8UwzEGbLIQT3bg0ekrbyX/xp5JYOqBTt9ggGHX3LNQOwD1hCamAxiHRlPJudp9gQRyV7
         H/Pr8ney5A305W1v9iPV9rAkZZKUL4D6Xl8XJBpuDDaI5ZIDocOLylwcwAK8kE0oUEnb
         cvqjMjzbbHiWju1h8tprAVvmaNDsQWWetvx07Pdh/OZQd4lrJENmWhg8cVPjTAwgaGmf
         3xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dhyh0a5Q4ZaOv+jNYAXOVcm28D6ttv4dilrANYN3DFU=;
        b=FSaJ20UJs2S2VJRRyNAwvJzIh12AF0C+y1yD4d6XQm3YIUJQm8uV4iT2FHCwaG6slw
         ITHkygp1HwRsa96Q2mjethUyxYnH8mV+IjGztXUUPkAt8HPVT0jcCMR0yP1cj/9CcooC
         OUa2924t6M5Llg3JC3hQwlUaxVorzAbVqfwf/s7VKQjJPRCoRpnCdsJui+ER8glZ+Bw7
         /fbfeE3XK2mGNWA/kj0HdLUb7D6ldnY4hkO6jnhfoHeReedn4q0o0UvDb6/gxK3V6bxk
         k5viYn+JzbOqkMyDZVr0xI+xvO1LYkHN0YiT7SSLBYJVbVqUk4UZazh8n47EMLSykI3b
         9ZDQ==
X-Gm-Message-State: AGRZ1gKPNdO29uSUr4NTdKDKX0pAJ4XrNEEzRceg4qs/FP4cC24/Grgv
        Vhc9k96F7Cj16Xv780ZAmizxZ7duzpA=
X-Google-Smtp-Source: AJdET5cGxlaAluiBGNCGkPaKGxw4qMtgKCr9aHGwkmvTr6zISoc14NRHsVSfSdHCL3cdUQ90O34i0g==
X-Received: by 2002:adf:e28d:: with SMTP id v13-v6mr6712263wri.139.1540595271217;
        Fri, 26 Oct 2018 16:07:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5632830wmt.16.2018.10.26.16.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:07:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/8] remote.c: add braces in anticipation of a follow-up change
Date:   Fri, 26 Oct 2018 23:07:34 +0000
Message-Id: <20181026230741.23321-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181026192734.9609-1-avarab@gmail.com>
References: <20181026192734.9609-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The CodingGuidelines say "When there are multiple arms to a
conditional and some of them require braces, enclose even a single
line block in braces for consistency.". Fix the code in
match_explicit() to conform.

While I'm at it change the if/else if/else in guess_ref() to use
braces. This is not currently needed, but a follow-up change will add
a new multi-line condition to that logic.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 81f4f01b00..18cae48daa 100644
--- a/remote.c
+++ b/remote.c
@@ -968,12 +968,13 @@ static char *guess_ref(const char *name, struct ref *peer)
 	if (!r)
 		return NULL;
 
-	if (starts_with(r, "refs/heads/"))
+	if (starts_with(r, "refs/heads/")) {
 		strbuf_addstr(&buf, "refs/heads/");
-	else if (starts_with(r, "refs/tags/"))
+	} else if (starts_with(r, "refs/tags/")) {
 		strbuf_addstr(&buf, "refs/tags/");
-	else
+	} else {
 		return NULL;
+	}
 
 	strbuf_addstr(&buf, name);
 	return strbuf_detach(&buf, NULL);
@@ -1038,21 +1039,22 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 1:
 		break;
 	case 0:
-		if (starts_with(dst_value, "refs/"))
+		if (starts_with(dst_value, "refs/")) {
 			matched_dst = make_linked_ref(dst_value, dst_tail);
-		else if (is_null_oid(&matched_src->new_oid))
+		} else if (is_null_oid(&matched_src->new_oid)) {
 			error("unable to delete '%s': remote ref does not exist",
 			      dst_value);
-		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
+		} else if ((dst_guess = guess_ref(dst_value, matched_src))) {
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
-		} else
+		} else {
 			error("unable to push to unqualified destination: %s\n"
 			      "The destination refspec neither matches an "
 			      "existing ref on the remote nor\n"
 			      "begins with refs/, and we are unable to "
 			      "guess a prefix based on the source ref.",
 			      dst_value);
+		}
 		break;
 	default:
 		matched_dst = NULL;
-- 
2.19.1.759.g500967bb5e

