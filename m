Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0D33BBC6
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813975; cv=none; b=LA4utTYIcBVS2yaSGo/OdmzzK+RFp9EetEjC4tVqeyXjtTU1owzJvIzELfomP8gcvefjtb9wNg8EWryRFTLVQvei5Tl39ZOE1hta/gWa5YTaJjkEODul8jbNCf0pcPdKgjlMCjab5veRjiCx/FCYYcIG+jVqufoPO4aD6H0FjlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813975; c=relaxed/simple;
	bh=cODpEUb1dagdXtjhicJOyECmHU8gDMbymByKFSB8XAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kL1BnX+1T87Cp/9r8w8hJ0Fat+ypURGZNnlURZi0ftRpSW8WP7xcizCUzQghmlueqQcAQO10tn8tAkUxJZgoRkHRqwoYCDu9BbC+QCUNHWwnadUmXcaA1PN1/QhlCc+g9AT5dSVX9EYXRPIVR6rXV9Vr1CE0VJfLA89VB6kCKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0Y56S1W; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Y56S1W"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3598da781d1so678578a91.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 08:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772813973; x=1773418773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Dcf8osTMdJth2taNWV76i9mIHmjYh++Fd7r0ImBZXM=;
        b=h0Y56S1Wcg6qirj/PiVcAxOJvxjYZZXSOmiW7rYpR4SEr+tTUTchLhvlAAQA1a2cVG
         QqgP6J7v+MQQwgYHa1XRqniQjAafd5+70/rRmTF1tTJ2z0UIyndJ5PxgNn0sdlQUPWVi
         Mvxk2oFZr+0bMiLWMVh1/VppfHdpvT6wnKkJFOhYByRoI5Th/ikdMGGLSAhUonWcQUC0
         a+4tV5uTmrSPQ1eAn62IyHDIJ1/7ULbOpuP0OGd5pGKxhYq7Lvdx2ayvhsgY+4jx4lpl
         qTM936YNXbtpuOgMuxpyAbXWxEA0E9l94XY5FzLlPsnIXqo2NGVwD0mwADzuVrOWCGxR
         e7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772813973; x=1773418773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Dcf8osTMdJth2taNWV76i9mIHmjYh++Fd7r0ImBZXM=;
        b=SQW8D5/tRsQk9FC625vAvRiq+V5rTIH+uqwdtsbH4hdPazr+O4/JKBeRK3M8voExDS
         Cpj59SE4btdA8FwqHOGsjC8GSXd20AyTGOEY0iEBN36+8Kcy7SciSqYCyrsgGAcMxenY
         /fVifWx4i3hn0qi8MC7udhVnBdsTxI2vUf6D9/zfsUSvj7EkCCJNDXWDXPRSLdGVhKOy
         1pBpbPwI3lghJ092umBkk2EePrnzzItg9l8RyDrzds4K8wwk6cHlrvaxo92VFnQEboDO
         XkvxZ3RwjD2EJxjlpRYrlGCdq6Tt2yPttcHAQQG43AoMlc+ddoSTRAfaCNcfzhp706DQ
         GdRg==
X-Gm-Message-State: AOJu0YxV9rYdMsQ8Mc02zyrih/83GQAzD6sD6tmUwZQZ4mclqCwNc6cX
	V+EibUjOMZm8Jb1whYfzG9p2RznsVsuq9yZglXiJLf7cHSisLS6POdI1kBRn4A==
X-Gm-Gg: ATEYQzwMFVR3F8odlYr5bPMYbV6biskKbSHjwqvXLHOdgBsQPZImCQs0EVKi4owRYoR
	5JTUMB6V2ELnUmGN/kpZQqtCAY7E+4w2fcD+p3KxfplItDTZnKKtI7avzjc4AbSosrX3MVi9JMg
	41+/ZkaqRl025JmXyZm8zhI+1iMm9XjhVdKMTQLTaeCMcSEPyV4lnNzZwZtBArgUTLoq9hhJPPk
	ztDhDY8SP83dZuBNFgmDlupu0DRXmfIeWxUdmAfZxxd1cRkMGIFSHiSJ5iXUxijAWJMQteRWmNW
	WfG/z6U4bMT+X1lwljxCiwWN9Y38PD+ye8s1u+REvIF5a6a/KWyfN0+VwpAj4d1vgroLc/lAw/6
	8/3yj1gFSB6MCcr39nc3QOO5XprZSd7SCb44fZWzHLus1ARMl5rAchMf+67rlGa7raKiqKDnj68
	NpcglilrS5OwBAR98yTeMhQL64XHHNojXrqaFsZHX6+x9VCZh2dUAkl9sUKP3DEdrIKKtvvVl/4
	sK4tewOxg==
X-Received: by 2002:a17:90b:3e4d:b0:354:9b9b:54db with SMTP id 98e67ed59e1d1-359be30252bmr2011827a91.3.1772813973082;
        Fri, 06 Mar 2026 08:19:33 -0800 (PST)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de7b8dsm7865985a91.12.2026.03.06.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 08:19:32 -0800 (PST)
From: jayesh0104 <jayeshdaga99@gmail.com>
To: git@vger.kernel.org
Cc: jayesh0104 <jayeshdaga99@gmail.com>
Subject: [PATCH] repo-info: add paths.git_dir field
Date: Fri,  6 Mar 2026 16:18:22 +0000
Message-ID: <20260306161822.328127-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the repository's Git directory path through `git repo info`.

This value is currently available via:

    git rev-parse --git-dir

Adding it to `git repo info` allows scripts to retrieve it
through a structured interface.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
 builtin/repo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index f943be7451..7535192878 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -61,12 +61,17 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 		      ref_storage_format_to_name(repo->ref_storage_format));
 	return 0;
 }
-
+static int get_paths_git_dir(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, repo_get_git_dir(repo));
+	return 0;
+}
 /* repo_info_field keys must be in lexicographical order */
 static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "paths.git_dir", get_paths_git_dir },
 	{ "references.format", get_references_format },
 };
 
-- 
2.43.0

