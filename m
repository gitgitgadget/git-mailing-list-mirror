Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185870818
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157256; cv=none; b=tKbeEKgoKVELHkUG/ht1MtQC1rzt9C4kXqHkE8jYWytG1OlxOKuwZqJtOYhQqDfrlnkcjjIRkzLPqChmUjt2To6g+vIg/8QoY4waUPmGlKlXa2DsvM0PQ7pOLhYC85AHHRkKSms9UD0FjeODcW8ERbfCZVFGKcXWm8+0qREgI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157256; c=relaxed/simple;
	bh=fTLNctA+j01HuTgOlm1AJdcetlCpz6eLvtWJBjYL1Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3c2S9cVoMVwSGQywScMyymTzKA+juOw/T6uAkJq/OteZd3eJ8xptKbH0aYomba5YDichNqFmkh3IMaPI2YpVPnyZvrDPyX9eRQtAZJUyZSk0yde2+bPHpxE0/jKSq2LIvvvfl2TzhOQvMBvz7Uu/AenzyWADbgzBNxIt/TVx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF9cOpJs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF9cOpJs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso789263a91.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775157254; x=1775762054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15KQV5AbJmqPa+AtK76osvVpzLQxDoCFnNd1nHC6Gxs=;
        b=UF9cOpJstLg2FGgo+JkSSfr7aw98tZnXbgx4FtRpsw1a/VpdljczZ1cbps1Wylhaiw
         +Rs2lm/Y3VJJPr1lWrU0F6e7twvFyitAlRL17K31D7PpHtKKQZlskCy8gu/WrWdWmXpM
         oCkODKoX/O674l92VzaY5ZJ+3U4lVEAwvKpuJU40iMl/+ep2y1OkQP+Fexli5yjMvyTV
         aUkCpTO4gCKjoSolaRm2GJi+OwwUsdijHe8ibNt41ykkVv5R1hWFY6PqtooN9Jx7YzF9
         rAZUAgAEz1u56aZYXyU2lhMjMYaikX3kSB/kzJffAbo4yDjpvDwVsFuyGnJON0mWmQGX
         r1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157254; x=1775762054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15KQV5AbJmqPa+AtK76osvVpzLQxDoCFnNd1nHC6Gxs=;
        b=Ya6exZwto++56txV2cIp4kCH2/znum2VvxbxsBrz1wwk2lChRwZ8BjPjycKARZyVEP
         mQZBIPdrCs3sGBl4a3VVP7FDnhAFXpbjmVgrKiRGzlwnTT6XgK8ChZG4Eys6CB5kdrAl
         z0svlohWI/8eJnHGH1ey6W5LryGBW0cgVXSMur7Oo8T+LRTieEv96jbNYxm1q71Apcsy
         Yhw/mTRFzDBUastOoNeDGBEtJMDwH5oh4oqnSFnsNMU4zH58VsSeT+Elek0n4HRAK5my
         93j2pC1FaXAI7wz7YVCr33gO69h6JaOD5c5B32ErTlNxSxv7OF0k8Re/JWbVg+D9HXhP
         gr/A==
X-Gm-Message-State: AOJu0YzKGlhY3n6eBgoKrgPi6QkQaIubMjH218Y5OkRLs6F121e6E2Ji
	xNT8inGh2p7PK2pDYG1wxeCf6OfxIsJZuAbFfIwk4+tIC0OrFoHV/ep75oWs54E4+/I=
X-Gm-Gg: AeBDieuP0M9GyK7HA0XcDzb1dzMI0dLJtMcncMt/DOutaiJnXdH53tiaPk+do2Vzzpu
	896N2tmsFFbtZM/RSfILQpOzZgyD2aeIrcAB9z84e4wNwUFfvgvH7y+AodrvYnrsCcnB7WhDenT
	u+2m7Wc8rI3QlGmfKnsluqJgbkiwc9dbroUHiSzHl/BJfOQkNgodEebeURmN+OeaWXe97yIuzIW
	wa2Q4SKYx/So6snVaZHxZNSN2zCXxAEhCWY0ASnaMT6iyD5b21po3Ge3aQ+ranbAbwCDes517nF
	3TjjZlLxInviXDI9epJbh9gEx9umZaLM9d+IQLTUs8tF5CbCgLppwnbxkHNPHNVbafv2lgyB+Ef
	l8lLvXsxSPo1ZxvnwG1MNOWfyAXPmtoPDRhzfweBobctDrI5vF5/VaQGEmAq2Vw38WplqOzQX5z
	EaBd919jn8TEGLX2wEdizo3Umgwi55CaWSMCN55LwmzlBw
X-Received: by 2002:a17:90b:394a:b0:35b:929f:7e8d with SMTP id 98e67ed59e1d1-35de696f281mr75429a91.14.1775157253971;
        Thu, 02 Apr 2026 12:14:13 -0700 (PDT)
Received: from localhost.localdomain ([42.118.191.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de674a87dsm17404a91.3.2026.04.02.12.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:14:13 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH v2] backfill: error out when HEAD cannot be parsed
Date: Fri,  3 Apr 2026 02:13:58 +0700
Message-ID: <20260402191359.11304-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trieu Huynh <vikingtc4@gmail.com>

handle_revision_arg() returns non-zero on failure, but do_backfill()
ignores the return value. On an empty repo with no commits, HEAD is
unborn and handle_revision_arg() fails, but backfill silently
continues with an empty revision walk and exists with a zero return
code.

Check the return value and propagate the error, consistent with
how builtin/pack-objects.c handles handle_revision_arg() failures.

Add a test to verify that backfill on an empty repository fails
with a clear error message.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
Changes in v2:
- Update commit msg (Point out by Karthik Nayak <karthik.188@gmail.com>)
- Use test_grep instead of grep (Point out by Tian Yuchen <cat@malon.dev>)

 builtin/backfill.c  | 3 ++-
 t/t5620-backfill.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e9a33e81be..ca49e188df 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -92,7 +92,8 @@ static int do_backfill(struct backfill_context *ctx)
 	}
 
 	repo_init_revisions(ctx->repo, &revs, "");
-	handle_revision_arg("HEAD", &revs, 0, 0);
+	if (handle_revision_arg("HEAD", &revs, 0, 0))
+		return error(_("unable to parse HEAD revision"));
 
 	info.blobs = 1;
 	info.tags = info.commits = info.trees = 0;
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 58c81556e7..066ee17d39 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -77,6 +77,12 @@ test_expect_success 'do partial clone 2, backfill min batch size' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success 'backfill on empty repo fails gracefully' '
+	git init empty-repo &&
+	test_must_fail git -C empty-repo backfill 2>err &&
+	test_grep "unable to parse HEAD" err
+'
+
 test_expect_success 'backfill --sparse without sparse-checkout fails' '
 	git init not-sparse &&
 	test_must_fail git -C not-sparse backfill --sparse 2>err &&
-- 
2.43.0

