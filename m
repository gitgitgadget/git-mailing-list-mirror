Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989D158DD9
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271810; cv=none; b=kn6MseLKhbUTa/VfRbH8VZb1XrvcKcvuOZcrjR5li37ILnHawqc2tzmuVcTeNQaE9C4c5jkvI8OXD1QRmpfu3cCGRhEx04JRyNC7hqamMJOxkiPACMZIpnhq2bVUbsCtCXth8Nj2Xu9mQWGXPMKxNYVxM7b066mUbDgM3+J/LNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271810; c=relaxed/simple;
	bh=6u2NuRnQfBqAIwfT9N+W2cLbTA8vrQV39JvWlFebs8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtZqyGjtQUI/mho1Ka0CJw3ENjhrkJs2TA/ovRJOMbvu1wqtUQHg/PGUNm3nuZ+zxPrdDWZlNbpmOt8U1NGYIXa3c66WT0SvStmG6H4rFfqoZ8K8sdaULOad/DPxBaCH4Hal/hhurcahYFl2VLsvABaBbf0971i06dpwrZzhFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyDssLun; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyDssLun"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso1290346a91.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271808; x=1741876608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rb3yS0CVOISQIr4Ol2n4ARfJ+e3EEivkK8XxzJZZK4=;
        b=UyDssLunzsV4gWSbXywODohY7H6cVDpGLBeHOEUnCFHcPGX8LC/aiBMhOHo6QIIJNy
         elXAhrmksFcuEUAaOG+u+VpKNhgfcTOK2bCJQ5SuALnC0J0zmyvF23fDfVEEIQZUW0pO
         ok90cHpJ3dyHKVV43RDT0c15fwZc4I0ujl19tDVw23n2mljwi7inB9NNJbkf5otxz9p+
         2+UuklNRmAsxlWK0qKfzDq+ESKMBEnJ7/q6p0ZnkayyUvsJjQ7p6nxwFrSjprOIhfdI/
         zhdW+D5xjd2MGHNYRmcBdA7ePiUC3RtTDDywcb7XoZr4AVngsu6R7ky1Ubn9X2lmc02s
         Bw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271808; x=1741876608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rb3yS0CVOISQIr4Ol2n4ARfJ+e3EEivkK8XxzJZZK4=;
        b=BgcM1bhfXJphbTBNwAacecaYU1Zq/qrn45Yp6k0RhdyHOER8gL5hoTsW7SmHBgs0sw
         ncapQcvhjbNA73ZPEx3kFXciscKEFjScLskO4D+HuwaeRuzlJvb96VdhlEXyI4N51p2T
         YdXv6/0KtGaW/av/YRT3KqqCUcdhV7AyUUFC6PVtjQhF2VeUcEJG6IzFDLILaDQ7ROsu
         GPg+OqjaY+iGyhOVUyJZalG+AlD6cCoZsjZIOXNKU20LVgMqKVLewJ+aHadtrpGDh03e
         fDQk4yKUKU9hPL637EiZuAIF0QLb4TCSkLiXNlarPVANMXbQJLW/PAcBebge+gnbjgAR
         23BQ==
X-Gm-Message-State: AOJu0YxBDRkuyuZ4R9ZqA6MxAxvO2SlctPlzwKDRw1tuJTMj/NHf3xSe
	UpFZflxgxAAnzQKYdpDtygowTPPf57hxJBcHtNuiPL4arMuQQj+1PSYjuWU0
X-Gm-Gg: ASbGncuCJfv4C/rZvRq6cAkXthvdmSDM2RACuDnzZrXbbiGYJZUwe4srlGlvDJ+ENSB
	269sEDdx8QwvzNunajUu3n70cGWvnfj8BxUfkwh6vzh4iRlDl9dmBt0Hc0OQPOIORGDtw87Zjl3
	WcbPjRS3qG7E4gUipHtGVN7skS3MCA/xVZwVHrJ6gCvL38Px1lXi9eybz+e71fVzFWmrTRaWqlU
	dK7L+zgKXMaGUvMCi05rpbFZKUuCmHOfXOg/qx51TOBQ0+yUFKZOuJw942YRQ9lVg8S785+gXa5
	x2B9hDnTGDgCvGkW7j/9990+N5RtOkyF7wO4t2jPJwxEAEzJZxltQNyCVbquGz7Np165fw==
X-Google-Smtp-Source: AGHT+IGUONZ/5fiKo5pZpyv1VR43o3tPwWA6XlecsrFtOytVMPoegDoPqPljE/WUyod/rqUUPGZ/Ew==
X-Received: by 2002:a17:90b:3ec5:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2ff617b5145mr5482979a91.15.1741271808173;
        Thu, 06 Mar 2025 06:36:48 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:36:47 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/8] builtin/send-pack: stop using `the_repository`
Date: Thu,  6 Mar 2025 20:05:48 +0530
Message-ID: <20250306143629.1267358-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/send-pack.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_send_pack()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/send-pack.c  | 7 +++----
 t/t5400-send-pack.sh | 7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8d461008e2..c6e0e9d051 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
@@ -151,7 +150,7 @@ static int send_pack_config(const char *k, const char *v,
 int cmd_send_pack(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	const char *remote_name = NULL;
@@ -212,7 +211,7 @@ int cmd_send_pack(int argc,
 		OPT_END()
 	};
 
-	git_config(send_pack_config, NULL);
+	repo_config(repo, send_pack_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
 	if (argc > 0) {
 		dest = argv[0];
@@ -317,7 +316,7 @@ int cmd_send_pack(int argc,
 	set_ref_status_for_push(remote_refs, args.send_mirror,
 		args.force_update);
 
-	ret = send_pack(the_repository, &args, fd, conn, remote_refs, &extra_have);
+	ret = send_pack(repo, &args, fd, conn, remote_refs, &extra_have);
 
 	if (helper_status)
 		print_helper_status(remote_refs);
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3f81f16e13..8f018d2f23 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -55,6 +55,13 @@ test_expect_success setup '
 	echo Rebase &&
 	git log'
 
+test_expect_success 'send-pack does not crash with -h' '
+	test_expect_code 129 git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage &&
+	test_expect_code 129 nongit git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage
+'
+
 test_expect_success 'pack the source repository' '
 	git repack -a -d &&
 	git prune
-- 
2.48.1

