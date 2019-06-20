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
	by dcvr.yhbt.net (Postfix) with ESMTP id 543FC1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfFTVJd (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:09:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34792 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFTVJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:09:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so4465265wrl.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpzDRG0kZJ9YtaYBUv3fvBA5IBhs5BLuVYzXtQLF3yY=;
        b=IkiemmhroU3B4yZvHcj9cUFJWtk20KM4cZXb471yIdaxiNfdWQlYJrSedH2kI1vtzU
         7R5EB629Fsx5m68kuNLoDS/P2FcbhuanyDqdcUhs0QU/voEkSr+OZidbs1EpSwgS1zZg
         viD6Pma8PsnfxXVZkS1EKYAV8WjnPOXq3zrbzWPOFneyo5nYMdq/vtk+p9yY5eYfzZ/b
         mvNAGlDg8Jt6CeY0jCaP/7wOtoxuFWAinw0Jy1jSOII+Q2oNuqXY2eaWym/2v/67DD3u
         g4AaKKPi8tTciGAAHJl6pUm3EDw4P/8YnAKlcb3SUtq3hi0PtEmhTqWjRcC36hl/5eXx
         qu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpzDRG0kZJ9YtaYBUv3fvBA5IBhs5BLuVYzXtQLF3yY=;
        b=iRPdCfE9i+OyKhK50HPO57Mb+MictZ2yrIsxj3om4yu16LrMtSuzcg2hiUzKAcrW50
         0SyCGuptauQ0I4no5VS1ErCz+5HhO0ur2ku0fPbftmRdVINMg/bUvLSB+5trH7tDaoY7
         ONOhQaXwKl/41yuygvUhgpJsLrzUvP8kQI22YxQJJqIKEfdWF4WoMXJjzXyp5xnXzfOD
         qsp6LIqW4kec4kBK/RWp8OAkhbJMrg0sDb0FY0R9PxdQSQvR4zYFmoFUZy0Uq8ma5IBb
         vCBJlbM3fA4wTmTFDlDoF/YBjrWjoFw3+ZXrseFd/0fJpW7hyVot8l9BVAoTelj0zfWi
         rwQQ==
X-Gm-Message-State: APjAAAWT06t9bfXgiMIAZcskVqxPku4VG3STrMYvpACWWthB6n31K8Qt
        mkWNUrw9XNDzkYOtOfbyVVjpZsUAyOc=
X-Google-Smtp-Source: APXvYqx66NCShRR6oH+5fl3aMDVEOqmaeqxDSuIVfS4ZIXnhb5Fd0oek9hoS/0isUD6jBCj1lXWFLg==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr6937658wrt.227.1561064970413;
        Thu, 20 Jun 2019 14:09:30 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm1295781wre.73.2019.06.20.14.09.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:09:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] config.c: refactor die_bad_number() to not call gettext() early
Date:   Thu, 20 Jun 2019 23:09:10 +0200
Message-Id: <20190620210915.11297-4-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com>
References: <20190619233046.27503-1-avarab@gmail.com>
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

