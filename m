Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69893523D
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="Kjyw0D01"
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92968E8
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:43:22 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1dcdfeb7e44so2191312fac.0
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697341401; x=1697946201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY9+4TGZSEExMsw+da3TTbVRyFdWkcNxrGnfhd7UkDM=;
        b=Kjyw0D0186VyhLXZWLWwQXflKd1UgMzdanC0IZX1cI5l5j6v+9C2lPD9M5jgZaFkRQ
         UGmD/cZu7iXW+yj9Zodn84JYfc6VO+shptZyUHBhkywj0rPsTH5X5PLdpiRevawxBzrB
         nf2fvVUvJT/QdhILmczE03oNe8vbPu8mvESdLeaXmI6cVwX/DO/Zc+rSu8BmmYmMRBSa
         yhjsGIGu2C+Wlh7iYEJa7Wh1Kyyf2K/8e//l9rRD3c/dTnaOHIiGsGIfpu0AURYgEEuT
         t8Y9822M4SyJmtXkS5ey9UuRRA+bgyicoLIipQ4lQplc8Hgdi/E6DY/vbddPbRZX8QHm
         e/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697341401; x=1697946201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY9+4TGZSEExMsw+da3TTbVRyFdWkcNxrGnfhd7UkDM=;
        b=XPFbDL9ysfQa0GM0xbJxao0yleVw5VLV8/G8F2+Q9hP0/q9SavPl+m9r5PdlTNWNHr
         N3om5hmd0dM+ivV2UkdJxpjEmFy4CfcDt0HGcYbFvQuEppSCu1VnreszeRESXdd3f2p+
         2635GqXmGxGaFRaBdNA1RnmdNPplIkiZFv8gXZg1OkzoLJMHydm6vHiniAejqPTkn/up
         Bx+faxh0apOqSsCCdXtr1Bxh63g6Xycn7mjSoq3EavdqUitgHLQhidcHXFvVcQXyEvc9
         svc9et1FoVvDWoYydLNugrtw9F+qTmb+oc7x6qlu2xVtjiJsJLrtMQPPAv+GptaLbbZR
         1Jzg==
X-Gm-Message-State: AOJu0YyAt3HfmbeCiLZSHwaPdO7bgofz8U3nfnLY14hHZL4mehC3K4tO
	4e88S4tXu7eMZNsLJpbyu0GG0ICaVrIM1yGbMRM=
X-Google-Smtp-Source: AGHT+IHq+xIARV5jNif2wFvb/YnQ1pY/cufpdWL0Irg8E6E8pU7cFNDHEEDS/TwYim7b49l9LOSpWg==
X-Received: by 2002:a05:6871:610d:b0:1e9:bd5c:ae38 with SMTP id ra13-20020a056871610d00b001e9bd5cae38mr10657458oab.2.1697341401285;
        Sat, 14 Oct 2023 20:43:21 -0700 (PDT)
Received: from localhost.localdomain (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id bq10-20020a056a02044a00b0059ce3d1def5sm510777pgb.45.2023.10.14.20.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 20:43:20 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH v2 2/3] bugreport: match diagnostics filename with report
Date: Sat, 14 Oct 2023 20:42:36 -0700
Message-ID: <20231015034238.100675-3-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.298.gd89efca819.dirty
In-Reply-To: <20231015034238.100675-1-jacob@initialcommit.io>
References: <20231014040101.8333-1-jacob@initialcommit.io>
 <20231015034238.100675-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When using the --diagnose flag, match the diagnostics zip filename with
the bugreport filename in the scenario where '+i' syntax is used.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 builtin/bugreport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 71ee7d7f4b..573d270677 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -112,6 +112,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	char *prefixed_filename;
 	size_t output_path_len;
 	int ret;
+	int i = 1;
 
 	const struct option bugreport_options[] = {
 		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
@@ -142,7 +143,6 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	strbuf_addstr(&report_path, ".txt");
 
 	if (strbuf_cmp(&option_suffix, &default_option_suffix) == 0) {
-		int i = 1;
 		int pos = report_path.len - 4;
 		while (file_exists(report_path.buf) && i < 10) {
 			if (i > 1)
@@ -167,6 +167,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		strbuf_add(&zip_path, report_path.buf, output_path_len);
 		strbuf_addstr(&zip_path, "git-diagnostics-");
 		strbuf_addftime(&zip_path, option_suffix.buf, localtime_r(&now, &tm), 0, 0);
+		if (i > 1) strbuf_addf(&zip_path, "+%d", i-1);
 		strbuf_addstr(&zip_path, ".zip");
 
 		if (create_diagnostics_archive(&zip_path, diagnose))
-- 
2.42.0.298.gd89efca819.dirty

