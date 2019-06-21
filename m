Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBAA81F461
	for <e@80x24.org>; Fri, 21 Jun 2019 10:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfFUKSc (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:18:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33459 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFUKSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:18:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so6066144wru.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpzDRG0kZJ9YtaYBUv3fvBA5IBhs5BLuVYzXtQLF3yY=;
        b=TEAjjrkN48bgHtaSmSs4AkLqmReXY0MFc3iWxyfRWAOP/MSDWvSa0K5faCIGyKGfB1
         edmOGkuOmBBIZ/Yoo7Cgq2OrfZ4CxgLvsKEPtNCPv/fFpVrNbvnc7dPNm1zCT3ynvS6H
         OyKc70wjqa9r2HmaI1T0klp2W3RH4InxvvkEifPYdNTiQupD3hLXzkzcFdKLzAvTQ7j0
         Pg3y3wwyEJYhQFjpqnUx7vas3dZEgsomLlvR0H/TDFCkzd3yrZmLrpMSGcBL3Lf0EteE
         J0zlDXeFCJ72mbcrguIuHpZEXQbfvuvrDtrvIlQR9K6dhwCHe3TiYx17Yyp8wUYeBr1l
         Q3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpzDRG0kZJ9YtaYBUv3fvBA5IBhs5BLuVYzXtQLF3yY=;
        b=lgiQblq/LbLltS7CodDEpAgNTDUVjO34XF6TQzhCXrD20kTMjDj/QmNUawv8ES92p/
         s4PAPlIxeC7m3gaXOl3YUSlatgMv8RFoh+WfaZCSKSzfuFw20AU1rl3dpH1BBgLa2GxN
         asItYo7K/Ise3Gx330uMgUZOSwTb0egsaD1L8GmKElUk3yBSYgIOSxVSJEohl76olGII
         cYBMRaH0mHWe0sATYlR5kEu1N9sIktCNCsgOeTgYqveEGCRxXjPpMQfr4A0oAZ7TisMh
         H37UtQhk50d/Z2XVFK3+9X4SzLhwqmA1JLV+4FShB0c2YElUz8Zf2VUe9c29s42rxaqP
         Vr4Q==
X-Gm-Message-State: APjAAAWvmoE6blX70IIMonytjguMXft8K8cwxIA+qvUqqoy136nz3Yaj
        ga/g8r+SgcNkXas2BJ+lqIVv3NKs3WE=
X-Google-Smtp-Source: APXvYqxVuT7fTrkZgenX/CPa+14xolBD6f9kwsCFSSV/aE3F/oRsPFxcdsMvaeME7PclxVS7rCH7GA==
X-Received: by 2002:adf:f050:: with SMTP id t16mr76814725wro.99.1561112309140;
        Fri, 21 Jun 2019 03:18:29 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y184sm1878193wmg.14.2019.06.21.03.18.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:18:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/8] config.c: refactor die_bad_number() to not call gettext() early
Date:   Fri, 21 Jun 2019 12:18:07 +0200
Message-Id: <20190621101812.27300-4-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190620210915.11297-1-avarab@gmail.com>
References: <20190620210915.11297-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prepare die_bad_number() for a change to specially handle
GIT_TEST_GETTEXT_POISON calling git_env_bool() by making
die_bad_number() not call gettext() early, which would in turn call
git_env_bool().

There's no meaningful change here yet, just a re-arrangement of the
current code to make that subsequent change easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/config.c b/config.c
index 296a6d9cc4..374cb33005 100644
--- a/config.c
+++ b/config.c
@@ -949,34 +949,35 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
-	const char * error_type = (errno == ERANGE)? _("out of range"):_("invalid unit");
+	const char *error_type = (errno == ERANGE) ?
+		N_("out of range") : N_("invalid unit");
+	const char *bad_numeric = N_("bad numeric config value '%s' for '%s': %s");
 
 	if (!value)
 		value = "";
 
 	if (!(cf && cf->name))
-		die(_("bad numeric config value '%s' for '%s': %s"),
-		    value, name, error_type);
+		die(_(bad_numeric), value, name, _(error_type));
 
 	switch (cf->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
-		    value, name, cf->name, error_type);
+		    value, name, cf->name, _(error_type));
 	case CONFIG_ORIGIN_FILE:
 		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
-		    value, name, cf->name, error_type);
+		    value, name, cf->name, _(error_type));
 	case CONFIG_ORIGIN_STDIN:
 		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
-		    value, name, error_type);
+		    value, name, _(error_type));
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
-		    value, name, cf->name, error_type);
+		    value, name, cf->name, _(error_type));
 	case CONFIG_ORIGIN_CMDLINE:
 		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
-		    value, name, cf->name, error_type);
+		    value, name, cf->name, _(error_type));
 	default:
 		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, cf->name, error_type);
+		    value, name, cf->name, _(error_type));
 	}
 }
 
-- 
2.22.0.455.g172b71a6c5

