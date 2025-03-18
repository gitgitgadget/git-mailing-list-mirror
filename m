Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC820B7F7
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299173; cv=none; b=PuALm2mh9G1fy+IsfzMkVFV5qAMVlZvC2PgP7CsHlcBXNjVQWpDp05aol3vLRRzhM2czttGHTNcJYgJc+5UVb3bzvMEd1d8mJkTIc12F2U77+NVF75D+juzGX2nwWPjw+5gX0AG+LtUf8Nb6EvVdnXshi+rRyX/QNcNaf5Mrd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299173; c=relaxed/simple;
	bh=6u2NuRnQfBqAIwfT9N+W2cLbTA8vrQV39JvWlFebs8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbD0pNmmlQqHq6OalXZKxXhwiNc7nTXkmGr6N4yTeyPX53bzCHnVh14d7k5X1T26Yf8o3XdRagsU7QYyg6peh+R1wYc8F9S4AIJoQy00+GWhzyHuR/4i54Twv7DJTZkh1P5f4Dhh0h/k8hOdsIYsu6wWdXaqVpoZBVYPCiT5jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5u+Ib8f; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5u+Ib8f"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225477548e1so94645755ad.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299171; x=1742903971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rb3yS0CVOISQIr4Ol2n4ARfJ+e3EEivkK8XxzJZZK4=;
        b=f5u+Ib8fzDp/5Sby4o5yJSFVfWEM/xfCCbzTet2Mi23M+r1kMjAX53StXyfvMJOLIB
         pJUhCMR7N3Aao/mh8ub7aPWCpWN67jzfN1HCLeurqLZ8/3xUE6UdjazvHjuuoJnOhBUJ
         nc2CZvm0dXBE1IpM1Ac/kW8RFeH0iEa5CeVGlVTU/PD0jtewuHvx6Haj8HntrW7CTtZp
         5+cBEfqCtwKiKo8Ocd4t8jUlTc9WAkIduC+MNfSbRGal5EjE9IbIw91OeUi3okOmFY/J
         4I65HjnkHf5dLBO2JgP9snUY55scfIr7v3Xb9vRbzjhtFzSDLOFqmg7wdziCpoBXWaFg
         R/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299171; x=1742903971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rb3yS0CVOISQIr4Ol2n4ARfJ+e3EEivkK8XxzJZZK4=;
        b=uE0AtXfyRMuiLaOReifUPOW52fPCslxC7jgV8TKUjBQ26QjYO6JkQH9ZTTmB8ybNEE
         nv6bLGpmOAmLEDQIsaI8HJdHLqR9JSmx53VRDa3tGwwvSdooMZ2M1oJST6lWRRb+242A
         tDSzkmUokGj/UMeIj6TvkDEa4OTCCUWD2WdSChrwbP/f8gwMhqrs9ji+FU4UTaj+0x3h
         DEmwbOEP0Z0ujUMv4Kzhe1WQOUzlzWT3qlJJNi2tPfTuGBJyEHWOvRFFM7rIpOhWllU4
         ORAEFLMR+gXw517d3pqXc2I9GLhVsC8UQtdcsRpSU5AlAQxXZmX37Qaz6WyR8t71gjd9
         O6IA==
X-Gm-Message-State: AOJu0YwEqnvKDEia98tlAJtaL5+9Hkl2M+2GxEasbWPQ3I3BgOqw4YJs
	balxQJv6eplnHnlUQc2BSjPBzkWiaXKCbEXlYonQP0Q0gCAhILCfwr3KCkOc
X-Gm-Gg: ASbGncuywlqf1ua1w6rbE24qZIk4xYVX9aiffJbv2CEoFpc1zasDOXIUOc2+UVZf2Po
	E7jY6zMLWwiGVNfcpwrvQzcY7ancDQeEMJsU7XaG4lft3WguPFAhug2bGvBSD8I8mN7zr75y7L4
	HFMYMPi7NRTr55MbkGwp+xL/ET+qYXBGdPMxrpoP6jdDIsQke2V35o9udO431u+7ypjTcTAB/Yc
	oLLzp568rK0nvgos5jjGyiEmMVGYft9JoIK6a3FeHiCUxJ+oTHYcnNNi3v3wn9ojnyr8bhd4Mdn
	J4k63jSfWYxw0H4Ff0D9TJSYdChx50mBd/So42fZ7Dgbb3THwthw5iMTnK4fb+VK5wHzYA==
X-Google-Smtp-Source: AGHT+IHBbCHbeKdO4qTeP0G4U0Iqroy+53TKFO8uYL/2qOdJmVD9k19D3emlcAMJX+zWBjsroSYcsQ==
X-Received: by 2002:a17:902:f684:b0:220:c4e8:3b9d with SMTP id d9443c01a7336-225e0af5b7emr180362325ad.37.1742299171227;
        Tue, 18 Mar 2025 04:59:31 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:30 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/9] builtin/send-pack: stop using `the_repository`
Date: Tue, 18 Mar 2025 17:28:56 +0530
Message-ID: <20250318115912.2978992-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
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

