Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688A27CB0A
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100375; cv=none; b=NTDGaeikItOt6FbdIwd+ErGUapvth5eGCS5MFdln5C3FjKUdoxHnBXGdJU1mYtxBDZtL4DDqEs19GD7BBM4UgoaLDcwxbKvoYCWlKVIaZ2qEQWlj3wytY5++6vgksY7W65uy2eU+V9jhsvZCE4U0yr3kv2EkiLFEWMlq2wAfii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100375; c=relaxed/simple;
	bh=6/vQXhjG6L6fJuOFwTKvmT1Kirr4i8371zrlRqs3llA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMn5Ku82jkPCa8/nxn+JCRk+jWkKGOdwqUC7rD29nWH6/J2Gg9oaM1zN6qok4DQvliZ1m/PxmPZSOzq+jhSCF2h1Uo8krs8Z6Qeqwln/v4qugG+d4qYKarNkLfnVXdAU1C9AReNZwH24bFCV1uqFMJk6IMi15JLiEnQx5VhErGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrN53DMs; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrN53DMs"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78e7ba9fc29so11018267b3.2
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766100372; x=1766705172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uH50fM0Ty63I6x5uJrZCD6DukQSUyeOzAEYjUgPLFv4=;
        b=WrN53DMslk98HREyl5reYQKgsovCpq4LBELE6dbpOF35LbJYpAD+q263mVFqxDx0KL
         aXCVVbtf3+/qdTosREZPYSsJ8DgomEfF7mgD0FTginHo8kGMMXfMx1/we/b9tbnAk3+G
         o1+vccaGz5wRdFikPasJdifN8q123B50LLK9gy8XONJQfSj61EL4zWVdx7d9nzsLK7zk
         u7yshGtAMiCYD/D2eyb6fPYFfPDnx0epT4bZ+vjbW5cnoe9dT70PoABLjyt+xvlPAt1z
         8rmpRF+x0dMjsVy3g/PZ9PE9Vsm4PRjRlifp0UZ4JjmL7q6oW42i26u7m1P5fp6Jdtp/
         YvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766100372; x=1766705172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH50fM0Ty63I6x5uJrZCD6DukQSUyeOzAEYjUgPLFv4=;
        b=gyKkV9r0OUJq5sEhE5gXNosmY/X11RjM5HGk4bpnL0d3J8Bs/1tNbHKgOvibYk4fTh
         zYVtvIiFBMLd1q9W0s3CLsPjEBe5B+5RbDv9+Nga3AxZIuxwKvPKkX5rqvR3AQGc2l+x
         DNG2SLr8e15TVzp5LwvOTcYMwTc/+rHRRB4rnsAtGyz2R16P2wjCsa/vDzd59Ek9vVnX
         SARFe0NPPW87kiG/D7LaNnkVhiX0R37ZTd1JmRmBjG+gH9rebQTRl/zriSqQXZNEY0Ph
         DuFaDnKdzw9Id/ti6WKtyJ0CND0dTzojl5czQ4mUHFBwID3zCqKLcrs4fxRO1MsqdUDk
         0f4Q==
X-Gm-Message-State: AOJu0YzEBf+ovaPv4IfxgrHDLI7khQGEylksIg0+PIw0Bt+Qo0FEafxo
	+IXGP8v/Ls0wRuja2o6KN8w9yZxKhm25TOgXtdl2xaFDoxiEizxTr2Kwgurv8A==
X-Gm-Gg: AY/fxX4DFkDsvB4GunfpVyYmbExoeYifiWPPoYkl1CbAwz9a8kDnlNMuZ1fgHO245wU
	GaV+khb8eOLjjMabnUwVigmS2w7fz8rebtIfpelizIpr2wYagJmnOe5Zgaa2XASO5CVoG0HpW0O
	nRb7RsdHUNDAd9N2Z6O4Onhp/kAq/Xg8J3W3PNlHe8tsiN9Hv1f5OTbYOfbHRD7XXM/2eHSoaPI
	+4uZbypRaaFXQf8sOI4vCbB+SPapkLMdwEpGaqbJklKmu9+J9+fUjLbyg/QW6aLoM0HXnmrlFFS
	9AZp7hTiEAeFSX6zHeTdbCbtWv0zXEOeojSRsN01eZoaQGJnuOB6bpxIg0QRQ3B7cvKjOSP889C
	z+i2uyw5RZCtwnL4RI166HQz4Lzm1LzV3VN/q9RzAfPCJA2MmCbGCAzNOBtSS35MxL8Q/7Xd+Z5
	y4PpUzawPm49vOzL1BsAd9cMqEDA==
X-Google-Smtp-Source: AGHT+IGrcqyjVNJdxAoIpecCexL/BFrr6xWEZzSRJAoyYwFdC4pSlaOWVOCP4HUnaORUWF7xEd92oQ==
X-Received: by 2002:a05:690c:6084:b0:78c:57e6:6e59 with SMTP id 00721157ae682-78fb3ecfd54mr9209947b3.11.1766100372459;
        Thu, 18 Dec 2025 15:26:12 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4377f5csm3287837b3.2.2025.12.18.15.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 15:26:11 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rust: build correctly without GNU sed
Date: Thu, 18 Dec 2025 18:25:44 -0500
Message-ID: <a33f4e5118938300bcd5b2991feeee855a1c8f86.1766100330.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.365.g9bf09b728d.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From e509b5b8be (rust: support for Windows, 2025-10-15), we check
cargo's information to decide which library to build. However, that
check mistakenly used "sed -s" ("consider files as separate rather than
as a single, continuous long stream"), which is a GNU extension. The
build thus fails on macOS with "meson -Drust=enabled", which comes with
BSD-derived sed.

Instead, use the intended "sed -n" and print the matching section of the
output. This failure mode likely went unnoticed on systems with GNU sed
(common for developer machines and CI) because, in those instances, the
output being matched by case is the full cargo output (which either
contains the string "-windows-" or doesn't).

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 src/cargo-meson.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 3998db0435..38728a3711 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -26,7 +26,7 @@
 	exit $RET
 fi
 
-case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
+case "$(cargo -vV | sed -n 's/^host: \(.*\)$/\1/p')" in
 	*-windows-*)
 		LIBNAME=gitcore.lib;;
 	*)
-- 
2.52.0.rc0.365.g9bf09b728d.dirty

