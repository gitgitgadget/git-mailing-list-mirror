Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09011F597
	for <e@80x24.org>; Sat, 21 Jul 2018 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeGUImH (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 04:42:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37227 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeGUImH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 04:42:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so12899458ljk.4
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QTQS1/xJmyOG7NXcZLitZPO0MeR4mYgjMQ6pgKo00U=;
        b=uXnMtDdBCspZA7UxlczIkCT5boACkWv9oxnqNSp6YV9RQRhfg/a2Kg26qfkQO6PnlB
         DDtE9iluuIVTux6QHXwYTUD1m35PLGR5/D71H3VYPDYKGtACgTdiq0KsSrd6en+XdwU0
         +u/QgsVP56APNGMDdiPuBqj4NW9FX1ovSSDsq4druzJ1WYmb/UClTqKvv3v6Cm3RsdGv
         gGp2fVIfjpqFPFWdrBiAhZyumMlPOwGOLg/H4oHHvCtkewBHhvchQfKytBy4oqfeVYZ1
         sCmpJN2Tb9+YnhVZSj/ReMDMU0/BrU2HVlwJ87BYMIGqo+KYNycZ2xluKdlfJMPTlLTH
         hYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QTQS1/xJmyOG7NXcZLitZPO0MeR4mYgjMQ6pgKo00U=;
        b=Ng7lum7OqEec3iAosytQYwGAbuGDX7k0x3gUYWDHxNbxiOxeDn4RWxSwytQ+p/qT8d
         1R7ccoIxS5T0Jhin7kVHMMB8iyCjWUEOQUSBQq+6jibAQ16TFU8lSsfR5fzVfltnveLp
         Ko6qbIkba1fC2gfhOks/cWgtckMb5TrWxBYEu4w5xHE/fxVZrWB3ZfR24maSfCc6LL3a
         esR9v1Zp8VySsKb5RR02tJpa5KALSrrY2xF/MnEKz4t0wIN1WQZd0uM/Z/QYhM2CILix
         gbZtWvRvrS6hJs5u+kI0VrcEEcDQfYcgbsmwQtkrx31T2bxMN6f2k9YM5Rspcz/KCgdH
         QbrQ==
X-Gm-Message-State: AOUpUlEAxhABmqqRuyJ7aRZuxLVgw0eOKkMp1Vyz0cMOjUWe3ZHGfn5x
        lla10fX88ipOvXkr3C4oBSzYzIWh
X-Google-Smtp-Source: AAOMgpdZRA9EW3srZSEl73ip5QurkK2XVjndvQf0f8HEUX70TgSBeVZNyNj3T7bE6NKjFw+cY/oDDw==
X-Received: by 2002:a2e:2b0e:: with SMTP id q14-v6mr3491012lje.147.1532159416930;
        Sat, 21 Jul 2018 00:50:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm759898lji.96.2018.07.21.00.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 00:50:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        stolee@gmail.com
Subject: [PATCH v3 20/23] sequencer.c: mark more strings for translation
Date:   Sat, 21 Jul 2018 09:49:38 +0200
Message-Id: <20180721074941.14632-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180721074941.14632-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
 <20180721074941.14632-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6b6162d194..f7c2f2422d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -716,7 +716,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	/* dequote values and construct ident line in-place */
 	for (in = out = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
 		if (!skip_prefix(in, keys[i], (const char **)&in)) {
-			warning("could not parse '%s' (looking for '%s'",
+			warning(_("could not parse '%s' (looking for '%s'"),
 				rebase_path_author_script(), keys[i]);
 			return NULL;
 		}
@@ -738,7 +738,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	}
 
 	if (i < 3) {
-		warning("could not parse '%s' (looking for '%s')",
+		warning(_("could not parse '%s' (looking for '%s')"),
 			rebase_path_author_script(), keys[i]);
 		return NULL;
 	}
@@ -1444,7 +1444,7 @@ static const char *command_to_string(const enum todo_command command)
 {
 	if (command < TODO_COMMENT)
 		return todo_command_info[command].str;
-	die("unknown command: %d", command);
+	die(_("unknown command: %d"), command);
 }
 
 static char command_to_char(const enum todo_command command)
@@ -2600,15 +2600,17 @@ static int error_with_patch(struct commit *commit,
 		if (intend_to_amend())
 			return -1;
 
-		fprintf(stderr, "You can amend the commit now, with\n"
-			"\n"
-			"  git commit --amend %s\n"
-			"\n"
-			"Once you are satisfied with your changes, run\n"
-			"\n"
-			"  git rebase --continue\n", gpg_sign_opt_quoted(opts));
+		fprintf(stderr,
+			_("You can amend the commit now, with\n"
+			  "\n"
+			  "  git commit --amend %s\n"
+			  "\n"
+			  "Once you are satisfied with your changes, run\n"
+			  "\n"
+			  "  git rebase --continue\n"),
+			gpg_sign_opt_quoted(opts));
 	} else if (exit_code)
-		fprintf_ln(stderr, "Could not apply %s... %.*s",
+		fprintf_ln(stderr, _("Could not apply %s... %.*s"),
 			short_commit_name(commit), subject_len, subject);
 
 	return exit_code;
@@ -2719,7 +2721,7 @@ static int do_label(const char *name, int len)
 	struct object_id head_oid;
 
 	if (len == 1 && *name == '#')
-		return error("illegal label name: '%.*s'", len, name);
+		return error(_("illegal label name: '%.*s'"), len, name);
 
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
-- 
2.18.0.656.gda699b98b3

