Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761971DDA24
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917202; cv=none; b=F/09c+irXWR/bnfPRaehkBX6gdrH0DZ90prZSx7dL4ZBCLfM4QUN5gpcG6SYNvJGcQCQs6R4f680n/KXl+UezVTu5IRMbloDITgoZyQdr7vyaYRVAr/N2V/hGQy64YlH/4bAsKvRwDIuXm5J39G41TWbMz09+iW/7mNkcCqO5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917202; c=relaxed/simple;
	bh=X8v+bevu0y4UcATt+vGhcqjF7VbfpgUlAjgGxciSzF0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=XvLdCZTELVDVeYV9WrOLU5Xqz9cpQ9CUMUZuhG5YYRb/5GMpoZnwbk35JRAv073UWPidP9Gnn766puzWb1RaK0+UdG5MFs7ZY8aVXc7IH+5rOAypaB8edZgkpurrgZKONlurmEq4t/py55mSmaVwxgfvj+O40QiYzDiKk1zBcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNhknU2O; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNhknU2O"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89048f76ec2so240330585a.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761917199; x=1762521999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ILCMQIhX6z9V/0/Mekkevtk7ophFdJZu8S2HLHRvUKk=;
        b=BNhknU2Or1Qk7oTNluyCRtY5eJuOaW7ZIOXeG7bz6DWdieaQ2F3yE77TdWNdlKxHuR
         ghZuVLhDhBlF3G7II9c1D1wJh1niSdJ4Gt3AwP+4QWhYwIOQPZsgdnaawdM8fCRkJvmg
         iK/hYA4vDC4OamW3BH4oWWxvTQJfA2qYVj+bYCVPU4/mYzzOLQSpE8lYw7aX82srL8xH
         OsC+lvXpaGB6mXkVXZcC4Vrx8SUEdA1fY52/deHGMUtY+B4Xopwa9bm5asf6IhcrSbzf
         BeDrF2cIrkGDULQlElIdZAsOfgpFw2aP7vv4Vib4ivfB0VEWDLa8kPP2AEbEg385v/5I
         +32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761917199; x=1762521999;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILCMQIhX6z9V/0/Mekkevtk7ophFdJZu8S2HLHRvUKk=;
        b=HqomZMo5zKPJu78wtj4GcmCtntjDldZ3ptroDDb7vqqkHiDz5CuZc6ksGeAbHdn2KS
         cXvi6Tgck1PFByoouiiuNZwYSlY914I8sCNltX8up8BM6mGx2RgxFJJg8hmwzpm2mGCE
         ZOpKzhXz33bqOQqUBn4+xAbEhqJKURan/o8a80g4lEN5ITAfKrtX4FfDGg1haKUuy7/w
         zDdz33cWkDdpJrNuvQqEMWjHMGb6Ud8Ke7+Cbm9bkGMP9CU7I4KJia/HuyUn56Phhb1Y
         z21ToKn9r2Zev5VjyZC1luSKSY/nHMAjsCTZ70+y3jkAeYqnYZu+Riem6xqMYS4n4182
         TGMw==
X-Gm-Message-State: AOJu0YxROcL2y9B+sbhdk/klECnp6IlcxsWNbCuPWnVyKli75XJy0egA
	OogkOQ8P94Un7Xy8Gc7ZLxiEAMPs8UbDygPPnnQ1r39hHSRZncflPKc9wNbXGA1/
X-Gm-Gg: ASbGncu4qyTzVA4/uG8dM5s/KYXE+mBdmr4trQUn+kROZYpyWIFmlkSuB6vqOvJJIUD
	mqtZsyI8wd6Ya5V8FGbnMcU0UMb9XOeIqpLfN1h9M4xO6omRo3kpvW7oSOXRvKrLGTISDP+N9+5
	alx9uYxHNJAJo308HlKUpwTJn3g9WIEXoF2Kx5Nt2s9CWZasrAKPgoqJ8+EFuu20HRMIvETq4y+
	PB9RbgMVolTd0Cr/Ugi2QWh1FWxCKDappwgk/fGleLLd/Ix/ukzLG6zLmmi12YWh8TGP+myZhhQ
	9ISmPIWcol1DG0qZo/4FCUuuEd6qS+3Yrbk8PuZZdfjpYM+H0r3hSAOUCOwg5LJiuZIzz4MDq5R
	tPumvNRCXllST93pT9ALilJsA2gOPm1LJJt6/G593bE02RIlrm0fBT61TLdbhlZOhAmHFe5Hoq5
	qMaZRn2RJfjdmE
X-Google-Smtp-Source: AGHT+IGf/5mu10chhUBC9OH+L+cvAtCxihMsJUQNyYZFFReaTidzFJEzds9RTJN8u2JUTR+LAhNbpw==
X-Received: by 2002:a05:620a:4013:b0:84a:7191:6d11 with SMTP id af79cd13be357-8ab9a534446mr304741785a.52.1761917198753;
        Fri, 31 Oct 2025 06:26:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac03d63ae5sm106319085a.54.2025.10.31.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:26:38 -0700 (PDT)
Message-Id: <pull.2091.git.git.1761917197824.gitgitgadget@gmail.com>
From: "Pavel Dydyshko via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 31 Oct 2025 13:26:37 +0000
Subject: [PATCH] svn: add multi-line support for ignore-paths and
 include-paths
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
Cc: Pavel Dydyshko <paul.dydyshko@gmail.com>,
    Pavel Dydyshka <paul.dydyshko@gmail.com>

From: Pavel Dydyshka <paul.dydyshko@gmail.com>

Allow multiple ignore-paths and include-paths entries in config. Instead
of reading single entry and storing it as is editor now concatenates all
values through a '|'

Signed-off-by: Pavel Dydyshka <paul.dydyshko@gmail.com>
---
    svn: add multi-line support for ignore-paths and include-paths

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2091%2Fpddshk%2Fsvn-multi-line-ignore-include-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2091/pddshk/svn-multi-line-ignore-include-v1
Pull-Request: https://github.com/git/git/pull/2091

 perl/Git/SVN/Fetcher.pm | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 968309e6d6..b2991480e1 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -31,15 +31,15 @@ sub new {
 	# override options set in an [svn-remote "..."] section
 	$repo_id = $git_svn->{repo_id};
 	my $k = "svn-remote.$repo_id.ignore-paths";
-	my $v = eval { command_oneline('config', '--get', $k) };
-	$self->{ignore_regex} = $v;
+	my @ignores = eval { command('config', '--get-all', $k) };
+	$self->{ignore_regex} = join('|', @ignores) if @ignores;
 
 	$k = "svn-remote.$repo_id.include-paths";
-	$v = eval { command_oneline('config', '--get', $k) };
-	$self->{include_regex} = $v;
+	my @includes = eval { command('config', '--get-all', $k) };
+	$self->{include_regex} = join('|', @includes) if @includes;
 
 	$k = "svn-remote.$repo_id.preserve-empty-dirs";
-	$v = eval { command_oneline('config', '--get', '--bool', $k) };
+	my $v = eval { command_oneline('config', '--get', '--bool', $k) };
 	if ($v && $v eq 'true') {
 		$_preserve_empty_dirs = 1;
 		$k = "svn-remote.$repo_id.placeholder-filename";

base-commit: 419c72cb8ada252b260efc38ff91fe201de7c8c3
-- 
gitgitgadget
