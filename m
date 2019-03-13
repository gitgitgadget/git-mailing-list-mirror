Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1759620248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCMS0f (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:26:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39289 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMS0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:26:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id p8so3108039wrq.6
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=VwjKlSV3/G0fHg0KZYlVmB2nJwMSxMM6ub4qZPLmgns=;
        b=ARAjSusPdtOHYQvMyiYZe4Chbhr/DbRK46+J+YNqt11CIGr7AfsnepbLMlpP+Vt5sU
         CILOqKlE8FWLUSRYHuCkLZve3lnNizZf9qANvObz/6U+yYYkq3KvX0wAGL6HsNV/8VAY
         cGHJR0R3O6/hiQ7Zi2omeP/QTILn5mplbOJOlte//WkuhoAP86YUThze6UGPVDxW9VS4
         GjMHFMTvJ5EILRj9YtFiBOCqCjad86UGCX7F9Vg8zgiAxCaTIxFlM8VZ/V8KBOe/z4Fk
         YnBIk6chpy96N8o/vsC2r00zxCDxx4c9M+YI9LDzJEJafgWAFb9xoYxIu+YnTXBMKQ7N
         aYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=VwjKlSV3/G0fHg0KZYlVmB2nJwMSxMM6ub4qZPLmgns=;
        b=VU/SXh/2NbDaSOTWIXZGX3wCkoT25Nzzmm2RUuTDhu5ceXF+7H53J5Pl6F85gqZmzE
         GRKxH4uGkz3Uc4x2y0MNZ2eYOfgmY4YgA+ParI2smUJsnveU9DzJSQuhltzoYxSZ+Hzc
         RY/XZtuj01zUT4TAc5m7IcXWMdNlZ0YesPhQ6VYhfjKwAlHQbe2zTASeXUCI+Pqj1M91
         KBj6BWu278P4l50ySNydfQVpVa9LQW86950IymMjlBGw8hTXtyrPalaAh6vIx6PnimXJ
         b/Asg0RWaFVuUQFQtVhy/ga9tImSCTvXo2vE5Mfii3rsC3g0iGQ2lyUfMLIdSTM/MWFI
         kkFg==
X-Gm-Message-State: APjAAAXM62Dz1Jy6/uWLFu9mFV4kwnKA8GQpaeu8K+uwFDg25PH+BITX
        LTOr1ikPmUa+COaoP1MW0qQxsWPsnDeY/w==
X-Google-Smtp-Source: APXvYqwzEezNWk6S3dz2XquNQe55rSmyYy42pzaOodGUeZQ9OVh+qN7m/uyO4E9LgFDgR220pWVZxQ==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr30991082wrq.149.1552501593154;
        Wed, 13 Mar 2019 11:26:33 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id i62sm2753807wmg.17.2019.03.13.11.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:26:32 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/3] sequencer: break some long lines
Date:   Wed, 13 Mar 2019 18:26:13 +0000
Message-Id: <20190313182615.7351-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

reformat save_opts() to remove excessively long lines.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0db410d590..5e19b22f8f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2700,36 +2700,45 @@ static int save_opts(struct replay_opts *opts)
 	int res = 0;
 
 	if (opts->no_commit)
-		res |= git_config_set_in_file_gently(opts_file, "options.no-commit", "true");
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.no-commit", "true");
 	if (opts->edit)
-		res |= git_config_set_in_file_gently(opts_file, "options.edit", "true");
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.edit", "true");
 	if (opts->signoff)
-		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.signoff", "true");
 	if (opts->record_origin)
-		res |= git_config_set_in_file_gently(opts_file, "options.record-origin", "true");
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.record-origin", "true");
 	if (opts->allow_ff)
-		res |= git_config_set_in_file_gently(opts_file, "options.allow-ff", "true");
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.allow-ff", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
-		res |= git_config_set_in_file_gently(opts_file, "options.mainline", buf.buf);
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.mainline", buf.buf);
 		strbuf_release(&buf);
 	}
 	if (opts->strategy)
-		res |= git_config_set_in_file_gently(opts_file, "options.strategy", opts->strategy);
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.strategy", opts->strategy);
 	if (opts->gpg_sign)
-		res |= git_config_set_in_file_gently(opts_file, "options.gpg-sign", opts->gpg_sign);
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.gpg-sign", opts->gpg_sign);
 	if (opts->xopts) {
 		int i;
 		for (i = 0; i < opts->xopts_nr; i++)
 			res |= git_config_set_multivar_in_file_gently(opts_file,
-							"options.strategy-option",
-							opts->xopts[i], "^$", 0);
+					"options.strategy-option",
+					opts->xopts[i], "^$", 0);
 	}
 	if (opts->allow_rerere_auto)
-		res |= git_config_set_in_file_gently(opts_file, "options.allow-rerere-auto",
-						     opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
-						     "true" : "false");
+		res |= git_config_set_in_file_gently(opts_file,
+				"options.allow-rerere-auto",
+				opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
+				"true" : "false");
 	return res;
 }
 
-- 
2.21.0

