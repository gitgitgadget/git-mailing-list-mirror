Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550E3E1205
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140431; cv=none; b=hy+OYGtdSU3O1uMBTt6BqjdbvCtAZyOLQwzSOV0gV0SJrZ0LeTDRC4B17T6XeYMkczrj6uLPTFHOlvmlMIZLh4FzVCF9ouV04cNk3JAy/aowxQy232kit7nIYysrFucqU9hGNnzFKLB6cxacptnwrQ8T9r554TvJ1JEZs2kSASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140431; c=relaxed/simple;
	bh=+63aRGSBqz6HSHQnvcWjwwdpN4bQol9v+qtK6YXJxOQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a8OY8vMiTULfJYoNlkEiyvrm9tEAT4v5BV17tRc/QkxKJjoDtc3RvHSAPRfrDVtFrCZYMZfEnDaTdLf0hBOTXfxP3mAtLlzRnzg86H9hMvmPQGxriGnCCe9Ie2lc9l4MVA6hyUyHxN+YwrvZKffVt82+qt+BavHv5Kd4hJnWR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpAm61AG; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpAm61AG"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b2b289925so8012721cf.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140429; x=1775745229; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o17+zJH8tRbAy3ykVGAlCqOKUyYVdHJLKN4nvYlOTAc=;
        b=JpAm61AGcEzcAzjafzodtZs/sqkcFE8nKfT3rNrkZx8l6ahimSkOsbqWJ5HJxWuJj0
         1UoVCCwro71ld3imWM6LhDEfo+wCkNdDQmLRV/JA41uyQKL5F83sDUg8Flv55WEUkekS
         5tgvuNx3004uRY1kWbPC+Ir5qFNapV3n7THkX+1boDhxCictHlzzxN5IcdZDPaxicJ6s
         PiFvBlzZTM1RYA0fSNDZF1KAdGLAcx6vXo/jLytabc502Ohqwi+wuEL2sV9cbwTD93qc
         7Y63LFoi8H0SHjQYd+xHziELtcP2DX5WTToqENtXCL5K9zI0dlSBCLPf5VH6k3ezSnin
         cIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140429; x=1775745229;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o17+zJH8tRbAy3ykVGAlCqOKUyYVdHJLKN4nvYlOTAc=;
        b=Ky1/n4Xdmomx0F/DkYnXYbKGbrbNr3E0Q89ojH0+A+CI/Ax67nL1y4iP2f5ZHdzTDu
         Gf1vkt8vh6WdDzhxPrWQlU8BVK+a64k06VfhliDNklcdlczRx3R+IO63lX+WE0yCcUt3
         /NUB48pnhmRTjaHMUHPQkmCUqeXkiDXYrsygZrVRPQnrLsQkzB1WxRjCVj/jB0Vr19XI
         c5grLd9Ts99wZd/EwK9w/eE3YOlO8t4/kD+d7tryPaALiUr8C42qTnpNX87fZ2eU11eV
         pSkeCj1gMtcOaZzsmZKUaCLD9uUcYqpPzr6VP6Q6wgabL2mgzdEo8PO3N2H9nfBQr4hx
         SnQg==
X-Gm-Message-State: AOJu0Yyh1o4VEL2uHeYe/Mru5VXIYy40oRkOqSlZdBKa+JuMNnA2USXN
	kBIUC98nMeMU+2oxAMfheCLOG3nyM5rU0bJiN8c+fq/Zan95Lsfr6euYqgaOhA==
X-Gm-Gg: ATEYQzxr/SYnXSxupS2tFJF0ks2NkGUjLcgOJKZ5jq6QavbZDG99rpRQKs4CDLybpmX
	vM40aDzXgeOD19U1XG3+FcDpkvzWEzgBTIXRQeYF4gt1wlHNrJan2g6OP7tef9lOLpVrBCs8qvO
	F++q9gyxafG4X9gBWs5DjbofNgor+RPBOVPmSCySRQ+GenWax82bAxwyTeFHL5Xr6S+nG0XdkEf
	zQw9z13rTbOnFiJx9Fu1d1NauFne0RuBYmnpJuiJiH8dYsw8QX0Yz1WNUzMLOB+FEsF48miR8Zh
	pW6uB3O60YaDJO8ozLsvUqxtLUP+Cqf3LDlJPiX48nGYuQD3W5Q4e2+/5DVQTyqzDvQyZl9PXKi
	Qg2tiQnjfOqLK5mV5BdIlQLTEKYXM5qmDjoO3y5UfVmKcOAkjOW87TvmHV83I3lDFuzdiEJgik+
	Rkp7eXaIs5ylKasn/zOfkTq0mBx0c=
X-Received: by 2002:a05:622a:4acc:b0:50b:3fbe:a0de with SMTP id d75a77b69052e-50d4c023574mr57627891cf.32.1775140428564;
        Thu, 02 Apr 2026 07:33:48 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf51b6sm30059726d6.17.2026.04.02.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:48 -0700 (PDT)
Message-Id: <1f1668a6f4ded1647242d652929abe91a4877816.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:22 +0000
Subject: [PATCH 16/17] t9700: stop relying on implicit bare repo discovery
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently, the "alternate bare repo" test case relies on Git
discovering non-bare and bare repositories alike. However, the automatic
discovery of bare repository represents a weakness that leaves Git
users vulnerable. To that end, the `safe.bareRepository` config was
introduced, but out of backwards-compatibility concerns, the default is
not yet secure.

To prepare for that default to switch to the secure one, where bare
repositories are never discovered automatically but instead must be
specified explicitly, let's do exactly that in this test case: specify
it explicitly, via setting the environment variable `GIT_DIR`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9700/test.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index f83e6169e2..99b712b626 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -153,9 +153,12 @@ unlink $tmpfile3;
 chdir($abs_repo_dir);
 
 # open alternate bare repo
-my $r4 = Git->repository(Directory => "$abs_repo_dir/bare.git");
-is($r4->command_oneline(qw(log --format=%s)), "bare commit",
-	"log of bare repo works");
+{
+	local $ENV{GIT_DIR} = "$abs_repo_dir/bare.git";
+	my $r4 = Git->repository(Directory => "$abs_repo_dir/bare.git");
+	is($r4->command_oneline(qw(log --format=%s)), "bare commit",
+		"log of bare repo works");
+}
 
 # unquoting paths
 is(Git::unquote_path('abc'), 'abc', 'unquote unquoted path');
-- 
gitgitgadget

