Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C0C20248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfCOQAT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:19 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37023 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfCOQAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:17 -0400
Received: by mail-wm1-f41.google.com with SMTP id x10so6541914wmg.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVDmBL8A1keR5cUjodPXRbcLV0Y5DAksOI6dDmLUqkI=;
        b=bdQm1RXqbiMPHpz8BhN6d1Bcn48gAo39r4Bkq0u7Q++VEpT6kXoKeuRxlg99cdMEjO
         HgGgsCvWw10qq0atgF2kNer3WewNV7UhnCRUQWI15SLtkSfQySQamm4X2PkfTv4aP6A4
         2MFUaHSQiRDDqjR8aH7yXgSia5x3QUVm4Oamr0ejTB8UvL5C8EwFvaqQaLRZawVfCLiQ
         IFBQ76IDKyywzFA+EwqM2cZf5GjdKBaYY2xfMhRzm1w+kbmBAAitpH/worM9uN4fcxCF
         6bfO1QgkH/awmjWIyrQ6O23a+cbsKfuJminVRLDNvvChgXzuEsQ/6M8c/6LAKBQfAXfe
         VoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVDmBL8A1keR5cUjodPXRbcLV0Y5DAksOI6dDmLUqkI=;
        b=ffL/U+bWy4NuhbLkpfvjoNvs1CvCHCEBCT060MJBGGWMlA8Bl6nRHx9OcQ9gn0ZeE/
         3rCFlt5qTkHWsM4iFojNQL3LtBcFQ5+zjA72wbLVCH9kauxUtW0QM9xQ1zSoo+8g+Kz4
         AoYbD5qXxA/q58dCd+27RB/HN67DxLPQ/Ey4wR7mUZY+VJhACzXvlLo4jJl7k0zr0gS2
         mw6pZ76iHBZFYVxVK2hy6RnsYb8qZdMH117mrSsX4jyfG1C0PRhO8j2J4CJ1sDQvwKFe
         3IfLmkUXoyoavROOk57Hbc93oCQ+jxk6cHJU1aFhPNhhXToWAuwTTmSjGP/FaeqiSRYe
         U8YA==
X-Gm-Message-State: APjAAAWLxuO+MllhtceTh7Rt8Nvb9qhOF2gv9eEO6Zx81y7x0NvGgw8M
        gu9qG23niQJdV6uFY9ZnlXOYgUw0+QA=
X-Google-Smtp-Source: APXvYqwWOrvWVIVsDw/IDNpbqSVPNWkCFit0WFQVI31H7TXnL2grn2eQvX4mbYgx77YW16YlDnA/Dw==
X-Received: by 2002:a1c:2dc9:: with SMTP id t192mr2555025wmt.119.1552665615015;
        Fri, 15 Mar 2019 09:00:15 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/8] gc: refactor a "call me once" pattern
Date:   Fri, 15 Mar 2019 16:59:54 +0100
Message-Id: <20190315155959.12390-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an idiom we're using to ensure that gc_before_repack() only
does work once (see 62aad1849f ("gc --auto: do not lock refs in the
background", 2014-05-25)) to be more obvious.

Nothing except this function cares about the "pack_refs" and
"prune_reflogs" variables, so let's not leave the reader wondering if
they're being zero'd out for later use somewhere else.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 733bd7bdf46..ae716a00d4a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -489,14 +489,20 @@ static int report_last_gc_error(void)
 
 static void gc_before_repack(void)
 {
+	/*
+	 * We may be called twice, as both the pre- and
+	 * post-daemonized phases will call us, but running these
+	 * commands more than once is pointless and wasteful.
+	 */
+	static int done = 0;
+	if (done++)
+		return;
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, pack_refs_cmd.argv[0]);
 
 	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, reflog.argv[0]);
-
-	pack_refs = 0;
-	prune_reflogs = 0;
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
-- 
2.21.0.360.g471c308f928

