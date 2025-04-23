Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F2292912
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396146; cv=none; b=B2jtCeAyzSa/ltOODCdx2UJtklQ5X2DlWN2NXd+YPgcgYFJDalHifu43qgK4gU7e8knf53ykiwHNPtYUdo+l5BUnLa+LI3iwChzuAy6Ft6sNTdIgwIVMMWVBJmR5ItVIKzGq6jsDdAq4dSOdydsTBB0qV7bDOwxi76rk/HXxtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396146; c=relaxed/simple;
	bh=lrZqNc1QLtqUIR4Xr6/O5hrKpuok7FJV2PGfvA8Ps+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4wdBIwEiA1Avniu+r05rFbMH8ZRgTLaymVunluPHT9UQ8CJ8I86aaInir61LlWz31+umPMSoRadsZdhQSfZb9TuSjZsDMdlciOYWCBIUhQrmN/3kWdeTI8COPSVWfG9TMzbHjkjmVJ5lbcX92va1+3OYzJl2XDFLOo9zIvm0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkecnDvc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkecnDvc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso8498503a12.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745396142; x=1746000942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8d/rvobSxrEBCxOzGynFUGn89qkisbDrSssK3sbDwc=;
        b=jkecnDvcdpZlSg/Be+AuySO2cjF/+bHJXaS5F+T8PB51Us6YQhoItDXz6lKTBVNNx/
         4DVAiKZEtVwncvrdKmxkrzG6eaeRE5SpHgiSys+E0ImS+/lL03jIXPJ/9X1kekapb2rA
         ISb1c5jBbyRECi4jFOQ4FkcS6Uh07l3wMT4Kv5QhQ+7+i5zxacvnTxO2r0PYD0H6PuGV
         IOf7vJXHdEBUjFdXgp3EgkrHt0S2CSU8rWm0GY8kNrS0DB3sKUtz5diNkLSvCoJkddTk
         0Ke0uT1ExE2TwpX5qBT4UR7F9T4fGdtx3hYYGoyjwe8nYc2CCAUBIOvserjjEz8VADLo
         eBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396142; x=1746000942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8d/rvobSxrEBCxOzGynFUGn89qkisbDrSssK3sbDwc=;
        b=PvSAeMtylREITPyIghxIG94+K+5qDUcKCC4oEikQBq9np2NBxQNPPXJAAnYjs6Jk9j
         7V+Hn0/Vfr9KZ9py2eRtD3BIJoADpsK7uVhPmu/I4M29Y8UpS7XTVXpVry/cRgC70pbL
         R9YXvYyY/ZPVs8GWJB1LtVYuU22o4gnsgXEVnl4QQetm0mXvC13bvoFCz8bfoJjJeK11
         C+i6xHm1vjIc7rgfbmS8TyGsg27M5Qx9sGQPIkMzc4I10Wtph1aBkqP3t+UdxULcfL5O
         2iPWVaBfTO2j9aCps6C2/chIKUQf+ODPZ63j/dJIm1c8+ePqdKDzNng9qQ1rdzZiMh9X
         Woww==
X-Gm-Message-State: AOJu0YzeybvOwmEMs7OZDO29fe7dfbLE3PkbN3vEwdykyxc13N6hUezC
	KiXIimYQ2/JRV0+pQ9fzWeu4rxfupmQ/dmcW4hCr+bKwf069ZFTd
X-Gm-Gg: ASbGncvrcy+VsfQOUaTRMxqJpo+KkjGdUlQSHmzV1xq1QedfkXcLf4/hv62nOgHlH88
	1aSxj+tjaAyaoGaF4KQd+bZAB6ayv9hknCG6kQIitAIvVBg3UnK4hrF5YblD7vbfiD5xLvhBteI
	gNKlNBL+Ov3FKnMUMa7+/NoJ16x3ZyFVmKrzQsYX0Y6NaoaKjMdQpRoVu+BzVEYRlsf93j9jeue
	0EJptg3HPTF0XHIjiM19x/7qSYK3dK1l7KIg/ut4Hh3B0g4CttPeQ1Bbcwlx9aJIKd3n17l4pa3
	883hbQMBrBB9AyngL26GYv/WRmpD7dh7PDDdSG5dKPKK2FI=
X-Google-Smtp-Source: AGHT+IGL1l/nuYm2H4ozvAPlrnDmTxNWMaQH9pvCiLeuXOaJt7AJC9ANa0E7nqpCwepFhhxb1amVfg==
X-Received: by 2002:a17:906:15d4:b0:ace:3105:afcd with SMTP id a640c23a62f3a-ace3105b6damr390395966b.4.1745396141810;
        Wed, 23 Apr 2025 01:15:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8764:66c7:f630:d3a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec13a5bsm766577266b.27.2025.04.23.01.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:15:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 23 Apr 2025 10:15:37 +0200
Subject: [PATCH v5 4/6] meson: rename 'third_party_sources' to
 'third_party_excludes'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-505-wire-up-sparse-via-meson-v5-4-d1e2be4b2078@gmail.com>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=lrZqNc1QLtqUIR4Xr6/O5hrKpuok7FJV2PGfvA8Ps+I=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgIoalzIJMkxe3R9FvL/R9GwsoLVpx4JL06x
 8svjDMt9s9oAokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoCKGpAAoJED7VnySO
 Rox/HfgMAIYPdiS9cOAU9Qefl/gsjSZSmxmVX3TcpMGNjQmo/fjd7izNEySxdPkaGi76ZNRIX3b
 D8Igq3LyMswEBQEvqZGO9mmiuTMmvQkpz5GTaDKAXx+JcjzoLwJZmEsBTspoiahICicxwxDCoOv
 71AW3pZ9S3h4f1innIWVFM4+vNqksrqbXWxGQEkMHPwDYNKK4YQiZ1DGuLpFuFjH2ZKmnaai0pR
 GoGx7DAnzvAAMRUDDA/OzTHddBsaJ+BZ1EglpCwqWysIOmI8GMoA6D3lTilJR0gdgy2pRKn8eUA
 vYui/kgA1jJrF/enxp6SxeKvYK3IJStTHA6mrIdmodgxapwT17x1qjG77l6YhJHSnaadWVgk7BU
 AohJGyS+gxOvjvktzNpUcU6kuKUip3Sxndf/GSDJsRs777O5LkgDFerF8hmOGvACd87aQrACVJC
 H8vbgbfqaHBnZMFfjIArhXcz/tdg9V3/NZBnbzDsebBSGlHM7X1YJW0OafE8rN8q479wFm2x465
 9I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'third_party_sources' variable was moved to the root 'meson.build'
file in the previous commit. The variable is actually used to exclude
third party sources, so rename it accordingly to 'third_party_excludes'
to avoid confusion. While here, remove a duplicate from the list.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 2 +-
 meson.build                    | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index 4f07824402..dc3f73c2e7 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -41,7 +41,7 @@ concatenated_rules = custom_target(
 )
 
 coccinelle_sources = []
-foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_sources, check: true).stdout().split()
+foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_excludes, check: true).stdout().split()
   coccinelle_sources += source
 endforeach
 
diff --git a/meson.build b/meson.build
index e147ddff28..4618804c7a 100644
--- a/meson.build
+++ b/meson.build
@@ -633,7 +633,7 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
-third_party_sources = [
+third_party_excludes = [
   ':!contrib',
   ':!compat/inet_ntop.c',
   ':!compat/inet_pton.c',
@@ -644,13 +644,12 @@ third_party_sources = [
   ':!sha1collisiondetection',
   ':!sha1dc',
   ':!t/unit-tests/clar',
-  ':!t/unit-tests/clar',
   ':!t/t[0-9][0-9][0-9][0-9]*',
 ]
 
 headers_to_check = []
 if git.found() and fs.exists(meson.project_source_root() / '.git')
-  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
     headers_to_check += header
   endforeach
 endif

-- 
2.48.1

