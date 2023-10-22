Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92717A4D
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mcclimon.org header.i=@mcclimon.org header.b="Nd8L3qTT"
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54575DA
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 19:28:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id 6a1803df08f44-66d4453ba38so14010106d6.0
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 19:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcclimon.org; s=gw; t=1697941695; x=1698546495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZxzU+Y2RGRpa17om0vDhiHo3cLzipx0my2boZJmrIE=;
        b=Nd8L3qTTPE5rkxx51i/TikaT6g8+QJpXtS9Xl6j2StmeFQb73rBg8WuzMnkppt+Mwp
         I6JOy+AfL8NkoBmCVmZcaKdcAseImwl/wEwRNj44iBCmMnWpdnekOdOVAjCDmBoisszd
         n77EK4o1uZROwNzJQLzWGM6MnkqUnYqYdbLgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697941695; x=1698546495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZxzU+Y2RGRpa17om0vDhiHo3cLzipx0my2boZJmrIE=;
        b=JtWBwBFsSBiZuNtrMDhdVp6R+9HYNE4FHX1wEcZ+ViyqOBRsezem8/twY9sn4ASUTr
         rvnHuJfGPTVv60DiRXDEjtbh98GdnzIIneuUolvuV2CAlMPROEPa/M5n5JVykm1rDO3K
         IsZ50h57zNttarDjxwS4w66PvE1kGRK/B537snrUqb1TZzflTkzaaO3umtJR+M/n0ElB
         4xybm87rV/T2zcOPwbCrkEkzs+g/us9xGKlFxPNQRDhxRSzQ0E7UFStZpZXc91G+M2mq
         cempM1R3qk2N8Xb/CRnpiQjngt1Ns/G2UDfHT1tsawSr7hAJsZtITXkQ7fDU8/wmyPBa
         lZfQ==
X-Gm-Message-State: AOJu0YzaK9knNDBeWZUFWzOqMqCF7UHvDCSjN+M8is/G+26pc8IWimKv
	x84wnhFlPWWeo3rPcR1e2dJgc+vWIWGS4gT49DDU3p4h
X-Google-Smtp-Source: AGHT+IHlAFYKQUHMh1rEqftzS1mW2PWKP9ZkB0LLwXrKvaBq8j5So/H3ciAjmfGCmd/c1UKA83ydfQ==
X-Received: by 2002:a05:6214:c83:b0:66d:50a6:da73 with SMTP id r3-20020a0562140c8300b0066d50a6da73mr7681771qvr.22.1697941695488;
        Sat, 21 Oct 2023 19:28:15 -0700 (PDT)
Received: from localhost ([2600:4040:7ee9:4100:1908:ac84:cbae:dea2])
        by smtp.gmail.com with ESMTPSA id po15-20020a05620a384f00b007776c520488sm1740332qkn.9.2023.10.21.19.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 19:28:15 -0700 (PDT)
From: Michael McClimon <michael@mcclimon.org>
To: git@vger.kernel.org
Cc: Michael McClimon <michael@mcclimon.org>
Subject: [RFC PATCH 2/2] pretty: add 'I' placeholder for patch-id
Date: Sat, 21 Oct 2023 22:28:00 -0400
Message-ID: <20231022022800.69219-3-michael@mcclimon.org>
X-Mailer: git-send-email 2.42.0.424.gceadf0f3
In-Reply-To: <20231022022800.69219-1-michael@mcclimon.org>
References: <20231022022800.69219-1-michael@mcclimon.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This doesn't actually work yet, and the test is probably in the wrong
place, but I think it's sort of close enough to send an RFC patch to ask
some questions.

Signed-off-by: Michael McClimon <michael@mcclimon.org>
---
 pretty.c                      | 11 +++++++++++
 t/t4205-log-pretty-formats.sh |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/pretty.c b/pretty.c
index cf964b06..47e2e6e9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -19,6 +19,7 @@
 #include "trailer.h"
 #include "run-command.h"
 #include "object-name.h"
+#include "patch-ids.h"
 
 /*
  * The limit for formatting directives, which enable the caller to append
@@ -1571,6 +1572,16 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 						 c->pretty_ctx->abbrev);
 		}
 		return 1;
+	case 'I':
+		{
+			struct diff_options diffopt;
+			struct object_id patch_id;
+			repo_diff_setup(the_repository, &diffopt);
+			if (commit_patch_id(commit, &diffopt, &patch_id, 0))
+				die(_("cannot get patch id"));
+			strbuf_addstr(sb, oid_to_hex(&patch_id));
+			return 1;
+		}
 	case 'm':		/* left/right/bottom */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e3d655e6..1e9fdcfe 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -38,6 +38,13 @@ test_expect_success 'set up basic repos' '
 	git config --unset i18n.commitEncoding
 '
 
+# %I placeholder
+test_expect_success '%I placeholder is a patch-id' '
+	git diff-tree --patch-with-raw HEAD | git patch-id >expected &&
+	git show -s --pretty="%I %H" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'alias builtin format' '
 	git log --pretty=oneline >expected &&
 	git config pretty.test-alias oneline &&
-- 
2.42.0.424.gceadf0f3

