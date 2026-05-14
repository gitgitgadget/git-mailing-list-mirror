Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B1410D37
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769251; cv=none; b=gnP6egLg6FRNwwGblCaTK4fAdjTh1WPU/8xgca1rJR4+fqmRohhqfTNecg82dr+4E8HzPJH4BZz58DILdZfIvaMLq43VKK1K+4jfseOzZwgXAWPjts1YxryBMEzqmzpleNtrsuc7TZEch8WCIVstp3ySUPCdnv/oc/eHgXgkOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769251; c=relaxed/simple;
	bh=HW8ml/dbF/Mav3Fa5Mzk1QNl2SY0HE0MHDOosWmkjOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D54cfU5VGfD2J0efpxyiCAxCGWECJy5ra6paYRhv6laM6nDzErI/vKrWQtgcX/LaoIYNiq9G8fAtEP6XQqwGevN/t5Pj33UX00aiC77k8fgRXLbSdNCSHObqsnr4MYUYpudZkLCQrBnDErtJtta8Burq4e1p3Ps5JLrvsmh1lbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qkhxu8em; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkhxu8em"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90d2acb9936so338014785a.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769248; x=1779374048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT/VGgYw2hO8W9YiNvUKSB6Xp7leDXqN2iKNdS+Q9eM=;
        b=Qkhxu8empLn37CypiBUEEmZsHh4kqcsBoSkmDkpBSMyzpwmvItMyUYgK2Zz0/1bYQW
         kB7CIZk6jNK+EdeYv+Z2SCADiO3IaANzrByLxjtUgcg7PXVJsaftJVv7SBhvD1uKF6Zb
         Ys7v34+S4pr5Z1FLW1KyW4aCxd9B3ZhS2v2VxgKrWctICWEpc4dqL41t9JFnrkPlk5tQ
         TBZ9OT5ZuZIEomoxnLH0HiiPirWIqPITkh2WfTyUZwSCgttRHLzXzKj13Ylf7m62dvCp
         eutK73D9AD9oploC8jvNrsAZ3uNjGRy+MnFFyywlNTj5ViMZI6MLznupyKclbFHP+30D
         Liyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769248; x=1779374048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lT/VGgYw2hO8W9YiNvUKSB6Xp7leDXqN2iKNdS+Q9eM=;
        b=gBum2Rpb2/6i/vAY6ZRCbQKcEBpHFGi27l1AY8q03Hh/6UtsnZQ3YFvbFENfKaLTmt
         E4ubk0ECACjPPOajP+3rtCsQATfoPwTR/5jzgimKiQgmZA5gXlDezDewooTYU/7gVg+U
         RBDIy+LvdppLh3kivawoyZxc1nLGPlO5ncWZ9ndOOPgYD9UxcTKMhxX864/SHCrOhIUl
         kqIFC6nbRxTs2LX+vTy34YqV6wQWYAg2So7EfChMXc0aVCpBlb38cpszfRMqZXc6L7r9
         fRPRTJChMQ7YCs7geDonOjEOrxXUZ7YhCIJpfatmaYevKtRknAelLYwR4J3Flj5dSfGt
         nITQ==
X-Gm-Message-State: AOJu0Ywa35bla2CAPFWRGaFORupGVYY67maMHtC1z1Y6fsexoblW+3EZ
	6SmjOv6fKSGrkTX5/ktXf9WYVyCb0mioR99CSG1MPlahbE1h3xTmxMkXxPep8WhN
X-Gm-Gg: Acq92OFxzQAvITVX+NFlwmS1zdDd4ClCY69oK4t4ZsfO7r5gXj6x9yfvuDXpRMkkxKk
	i5Nm2Pr2+7Fnp9gpU3WNFFC1+xTArFauF9FnqtFY+2pd60JYLjhZ4vvlMOtRa2HNTDAg3HwSZae
	vHn1+liGf7EgizYoLYrAUPKt/fe5CDkg4yNC1HofKDaiFMQCM7FeudcHkT3Rd1cSUCWzBIXFrZg
	BMZkd/cwLLaL2RgWK0UVq8UAMkUMarySImF0QUdIBHXJicR0FvBwQAHBr/ZKJ7OtwZ6rYT3xtAm
	F28XZilCcM6VgV4dDMfG1xPhnubRCu+eft9wdhzQyRKYwD0aN3Y/sHR9rp9Qd4pBXN8CRROaBej
	meSjeAmqYQ2gLKcOK3FZT/xwb5HBwZcXMw/Z04298geEJKqHrrvezdbIQBSH2MfLlXrLh0KsHbo
	/1SPYc8oI=
X-Received: by 2002:a05:620a:1a1a:b0:8ca:123e:819b with SMTP id af79cd13be357-90fab222473mr1131583285a.13.1778769248504;
        Thu, 14 May 2026 07:34:08 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:08 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 06/11] git gui: GIT_DIR / GIT_WORK_TREE make any discovery error fatal
Date: Thu, 14 May 2026 10:33:17 -0400
Message-ID: <20260514143322.865587-7-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git accepts any combination of GIT_DIR and GIT_WORK_TREE to override the
normal repository and worktree discovery process.  git-gui should accept
any such valid configuration, but overriding the discovery process means
the user has assured that the combination of current directory, GIT_DIR,
and GIT_WORK_TREE will lead to the correct repository and worktree. As
such, an error found during discovery where either or both of GIT_DIR
and GIT_WORK_TREE are set is a fatal error, no further exploration
should be tried.

Provide a common proc to support displaying an error message and exiting
if GIT_DIR or GIT_WORK_TREE are in the environment.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index c2cf5f1..2e2ddc0 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1122,6 +1122,24 @@ unset argv0dir
 ##
 ## repository setup
 
+proc is_gitvars_error {err} {
+	set havevars 0
+	set GIT_DIR {}
+	set GIT_WORK_TREE {}
+	catch {set GIT_DIR $::env(GIT_DIR); set havevars 1}
+	catch {set GIT_WORK_TREE $::env(GIT_WORK_TREE) ; set havevars 1}
+
+	if {$havevars} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Invalid configuration:"] \
+		   "\n" "GIT_DIR: " $GIT_DIR \
+		   "\n" "GIT_WORK_TREE: " $GIT_WORK_TREE \
+			"\n\n$err"]
+		return 1
+	}
+	return 0
+}
+
 proc set_gitdir_vars {} {
 	global _gitdir _gitworktree env
 	if {$_gitdir ne {}} {
-- 
2.54.0.99.14

