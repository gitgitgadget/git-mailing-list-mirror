Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485338886F
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314784; cv=none; b=cnksg3feSCF0XHn724aaNODrzlHCrueNljNTus4mcWj95VEKTsTt6GZcmlnemYcrdCmbMiy0AfSzYQmTKkkRDccHvT3kvLnxTAb4eevXJNMAvw8Q8nbwovHJRe4Nd3cS1NMi/1ZH5NeuQXAinvA2eVQiKuLvg/6fiTTK0OCXH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314784; c=relaxed/simple;
	bh=AOpkgYvVJFwDfsZxaGPbR0eGjsN/dR6H4SASaZFciXA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SaT+DdmMgrL6n6SxhRXbXUh7ClmnfMZokK2yJrkNlZifQpLXxlKjAFI8srTI8Y+T2exhb0+6fCnoOYUskE7XJn//IKQ/05qQZxZ2rCVwPec4G9dEDErGsjN0Uj6KNKPpsqHJVqj53xpOg+I6xjZmBvminDj63u7KDMflzFVb98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd4SmXEh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd4SmXEh"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ce9e56f68cso12948386d6.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781314782; x=1781919582; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dxleiy3ZUIlOGfs6Quxx1gp2z+RTU5mqPzQWBIoMZMs=;
        b=Gd4SmXEhl4Cru1gfs3R1hjeqdhFeWS+09M1ZgrHXEO3tsnlkpfDIMJshO476Iakw9X
         R6qlEqcRUHxDIIKH3hOZ245lqHUgx8ii0TSWLqqG4ooIxvxQdUAgZldYYyU+0UI71u4q
         rEBNjHViEHDTiZalNhpOq8W2ptNDFm13o9+tLRCIWorqaovmYoN1YGt7pc/oghftbueu
         wOUvutQz9wJsadk2udeHGzGnMS+OcYhtLuC+7lJFTN0jO0f0UPVIih1XcuBMt37dwkWt
         oyGk/tZPAj0jqjCzPqr30Ae7OSJl7dyrbZrQwlMXoI2KIB9oEq9DTda7LVC30U4s0xeA
         YFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781314782; x=1781919582;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxleiy3ZUIlOGfs6Quxx1gp2z+RTU5mqPzQWBIoMZMs=;
        b=TZwAnkan8UCEbUOKflnXwG6rHiO75waW61MP982kASijWaMoGVIy3g/ekP4kuZD8ux
         j2iCjf99zK5KHeEM5JX0DeGbQlF4tvRKugMiqNhMtK36QJ/3+GkkP1sHUstXNNL5ZAme
         Yz9T+/UvUdkkTjQz6wwnN0YYqGxAOSYUwHl4lI8Z2wJuRrxfMked1nf3QnFsmMqb/WCy
         Bk05Ql7HuVa/YfRMxKK6zPWsUbMWOPNxh1N9SsrYfWreYXhbeHsi1W/EClGpdSQWAxLC
         8bNRTZ4vLa4XcMmLF8WZq8XKauTkjhcIuiY8WKGssW+iHfd3HMCpPaQKTOKsUNQK4Q+N
         Q5og==
X-Gm-Message-State: AOJu0YzrKQ3SghWm8Xh+D7m7C4IrtzWhMZSZ0RLys4zrJo5nPH68xcAV
	4AmLILT6/tmsqitT+vOKz4j58FdzLjFS/DM/z5foc+r+huTzM5YS5UUotMjz7A==
X-Gm-Gg: Acq92OGSOQi4AcG/UoUty/BQMgGlXALGKOWO6LN2Rx1gp+67wC4nqKWkRYrNjFSGLwB
	B6NsNbpgKO/9uIfO1f/ptLoxWodF03pNlk2w/HVniRRI7B2l8a/K52JD2s9OptYNn+jnCbaKeig
	lc+pjLDnkEHg2OQcwamFrNZbLFYlp0HIs2fA1NpHZsuzjV8vYDwGGtM27wVTJE3dWKb3jqF+ksW
	1lVrq2Gx3yYNwqmmZEyj3yxkDiOmWqLnrBFdtd9dIeo9EgvxFhdLQ0oGQdLY+oGYKwqfG2m+IuG
	L3v4hopftMS2rY6F/peF4uQ+jh1e/Zxu6MbMIYbF6LrNaz5e4w0N9ZzBX/PlbQ2AgpigGzFyjcA
	1gcuL1drJCMQLHIMBnm1+hScDbS3JQlq/Vfx1WHAVmh7SwYr/N9DadeyIqUQ3Q8FC37Cm7nnae0
	jp6CIp/wvj7xpttWkOmJJo7z6RgA==
X-Received: by 2002:a05:6214:2f05:b0:8ca:1d2d:4a3b with SMTP id 6a1803df08f44-8d32c5e0d33mr99781876d6.19.1781314781790;
        Fri, 12 Jun 2026 18:39:41 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.116.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304b5f833sm38616766d6.38.2026.06.12.18.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 18:39:41 -0700 (PDT)
Message-Id: <pull.2333.git.git.1781314780645.gitgitgadget@gmail.com>
From: "h8d13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 01:39:40 +0000
Subject: [PATCH] clone: accept DEPTH env var as fallback for --depth
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: h8d13 <hadean-eon-dev@proton.me>,
    h8d13 <hadean-eon-dev@proton.me>

From: h8d13 <hadean-eon-dev@proton.me>

When git clone is run by a tool the user does not control directly
(CI runners, package build scripts such as makepkg, or any wrapper
that spawns nested clones), there is no way to request a shallow
clone: --depth only exists as a command-line option on the process
that invokes git clone, and unlike url.*.insteadOf there is no
configuration key that could be injected via GIT_CONFIG_* to achieve
the same effect.

Teach git clone to read a DEPTH environment variable when --depth is
not given on the command line. Since environment variables propagate
to child processes, exporting DEPTH=1 once makes every nested clone
underneath shallow, which is useful in CI pipelines and recursive
build tools. An explicit --depth on the command line still takes
precedence, and the value goes through the existing validation, so a
non-positive DEPTH dies with the same error as a non-positive
--depth.

Signed-off-by: h8d13 <hadean-eon-dev@proton.me>
---
    clone: accept DEPTH env var as fallback for --depth

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2333%2Fh8d13%2Fdepth-env-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2333/h8d13/depth-env-v1
Pull-Request: https://github.com/git/git/pull/2333

 builtin/clone.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index d60d1b60bc..549506f672 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1022,6 +1022,12 @@ int cmd_clone(int argc,
 		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
 
+	if (!option_depth) {
+		const char *env_depth = getenv("DEPTH");
+		if (env_depth && *env_depth)
+			option_depth = xstrdup(env_depth);
+	}
+
 	if (option_depth || option_since || option_not.nr)
 		deepen = 1;
 	if (option_single_branch == -1)

base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0
-- 
gitgitgadget
