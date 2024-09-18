Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FF1CB301
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692391; cv=none; b=twXGgXF/ktwZbc477r67MKlTObr3yV+kB953ZDlD8P4bQF8wU7squE56st3Bky1AhS4JvndXGwYBCYhSkepv9D7ecO/TOlZZahhDuo9HlQJ6OR1CxDGXDDeLHNLHc5uyBgISZX/zpds4GbCl0H2D55x21I9j2/k72j1KeHofphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692391; c=relaxed/simple;
	bh=ZTdGffGQw/6yzjEDsa+fFvN7dJNRjvQoaeBIrQ5Uxag=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=romVk6iU5lkUauwUGcHOX/wQkYwgYT86tdGmXbDfOuC5//mvosCeqlHNGgK887liAuMTMpPmYkbcKjDV0YsdKfsRSVv+6tUiTpkeoFzr+SgUa4xNwGOUvFasEbjqmHe4oqjZbHXrPQMKUbngDoRU/ix6wHVhObFS/6M25fGSwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yae5328E; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yae5328E"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso25051766b.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726692388; x=1727297188; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzsVBni1hzwxIPcF8nKjotNk3XdDVEZ5QFNKwj56i64=;
        b=Yae5328EwqBY9vhcSiAojp+mhFuUs2xld0MqboRuHvURjqd1O0UGf+xPaUPmoK5xC1
         ojJ+fEvU7c8s86Iwla8pPhHprJsfxP4e7jkr/DP/n0Np34qti70p9FBlT98w8eDwDLzi
         KPRCslpHQ1JYSxh/1SSd7vfHe8qhA103vr/iRUid4CCY6hU5/p1fIQa30hIKB5fSqHHi
         2bvjNmRZ5oOHGnfNE8F8N7ESNMLtl1uYuye9Lqh4om4iNLQ7K1eQRr7RCH7n888OjJL9
         7voxg0QF6XiHlJzYfvx5FjNSL7iKQGbC3A4MsSpB44VcO+3hKnHlUwb7Mm2pLHhpGi80
         I4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692388; x=1727297188;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzsVBni1hzwxIPcF8nKjotNk3XdDVEZ5QFNKwj56i64=;
        b=LiGUVXmO0yuWppMM1OY1mzwzrKEBcli5TzQjlU/G+6+16VDl3w+8FfiLM9KqUz8aMr
         4AcgebTXsNKexNNEauVazDL8cWXMqQj4FKL7qBrW6Ek/T7eWWYCrNw1sH4WxIisswKgq
         gMepmm/J9lKHMThADXryxQALY2/R1c73uJlEVg+L9CY09oW7Se6UXPIIan98eXxQqLLW
         sUDvByeEp1Jc4A+zoxTtgixKMLHjyph0JFedPYXTWBLs/hTmko7k/aZK1wZRAUo7fdwV
         xZWGMStlqwAt0adQkRXGDeeYsoqiTNXdikS410uIK4h6RsD2lFlV+3+xwnL7emdpsztj
         zVIA==
X-Gm-Message-State: AOJu0Yyjk9yTKB3U8XJ9effISgdm17MOQ6kwt1/DSoCNN2Zpv0EBpXKO
	IjDVN8zv6GPAXO70m5uR5hp6x6fHDMiyoosbnV05TJa3mSziskcdHa3vRA==
X-Google-Smtp-Source: AGHT+IFIBU+ej2UCByIVH1wIDCQdFg8hcpek/0EvKNHOmFyO8iE6Xy5RA4H6Q2y+IQcVCzAFoJmI+A==
X-Received: by 2002:a17:907:7ea3:b0:a8d:4e69:4030 with SMTP id a640c23a62f3a-a90c1cfb99bmr86988366b.19.1726692387823;
        Wed, 18 Sep 2024 13:46:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906111aa91sm632218666b.97.2024.09.18.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:46:26 -0700 (PDT)
Message-Id: <c58271261200779918d3329f31e4c4ffe59d6ec8.1726692381.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 20:46:19 +0000
Subject: [PATCH v2 4/6] git-repack: update usage to match docs
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This also adds the '--full-name-hash' option introduced in the previous
change and adds newlines to the synopsis.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.txt | 4 +++-
 builtin/repack.c             | 4 +++-
 t/t0450/txt-help-mismatches  | 1 -
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c902512a9e8..457a793fa89 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,9 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
+	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+	[--write-midx] [--full-name-hash]
 
 DESCRIPTION
 -----------
diff --git a/builtin/repack.c b/builtin/repack.c
index 87d0cd4d2f2..4fa2c25246d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -38,7 +38,9 @@ static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 
 static const char *const git_repack_usage[] = {
-	N_("git repack [<options>]"),
+	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
+	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
+	   "[--write-midx] [--full-name-hash]"),
 	NULL
 };
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 28003f18c92..c4a15fd0cb8 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -45,7 +45,6 @@ rebase
 remote
 remote-ext
 remote-fd
-repack
 reset
 restore
 rev-parse
-- 
gitgitgadget

