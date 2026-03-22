Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268635A397
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774159709; cv=none; b=QbMfNu+dQgccGI2oq5ojoPlM6v6RouRDt6BKKtCumxnECooFN2z3jZ3tTCBEfZaEOHViDGzr60JOYnnf+MwCDv7DHQDGsZUt6Ux5OxqR8YZWwIJNG3shv+IWDGH3aC6qd9BCw9Mx2vj5TrzvJIOKZtMGpN2GnidrXF5LkLA1soU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774159709; c=relaxed/simple;
	bh=oCvjvBCns4p9WsS0MCMsHOZp5HTEKX3+7F+zesvJFOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVu/RveAI1LkBNanrABvcpVb6W1mPXTjgkgGAiWw8UdBwDQdSkz6tRpDeOQvz5ebgmvzmxtGsrPpZLeR2nw88Jeyd4AhIjSXYLRo9r4rxXnJGymy4XX5btSDrb3fB4f4aj+BtJvdS/Gk63uY19lN875y1nF/TRzvnXiau8Vkmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4DEFFOT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4DEFFOT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0484a6de4so13645785ad.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774159707; x=1774764507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8bFIKPSZyoCw7ObGIlh0NwMplHjLABgKrUImtNKOs8=;
        b=Z4DEFFOTPtvME62cOuQ9yJVJ1ZXn1rZmH0yTx4YC0iY5BppiFpWtn29KdLLiRE5yDJ
         kox4459ycnWmpzMuHBAVKZQ+S6FfOnEMur+O9ZXW/tpCWhPHzcqRuZ8pGlubcmR2Bd2Y
         tVYX9fVm9z2zbdMPahWOC6n7yJgAIkcWG2N5cxu83pXlmnTLloBsOMRRkyiAdd/fJe6R
         cLvVrXfBfVOmT28Vw9fYHhoOuUv8K+tOvctJoMnOOF/OCtyH54d8FzhRhJWWhv9ET4T2
         AaM40mmyVi8mm3sxF+8NiVf5tgAPaa6+m6lqL6+z4tAlvLc+E8g4nm9YghOkkNTLUlkJ
         ELjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774159707; x=1774764507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8bFIKPSZyoCw7ObGIlh0NwMplHjLABgKrUImtNKOs8=;
        b=GOlw5G+AyFrIVNBoGQNS8BjdOC18QEJ/QCb5QpBfQTTcEk8Gyn+Rh+Pb/6R4nVAL8g
         7ftgdJFZahDwUmchkXIXnpRTvwKpFuTplXLA5txiLY6Jr5GSxzybuKxtocKkrMWxooGh
         GCgNcMoZXXHes5hCtzleupMp9A7BUE//r+ltLE9wDXS4Nmw/k+nuI+Zte8sEg5waEcDD
         fBi0w0j5JvfUS10Ej3i9mcaNlcyXatKRLiiVwQGgfqFWEUVoqu/4vm+tlSrRgmn4j5gl
         s9T+w93VN4YAq0iHEw8xO64Kd2CV+GWq6CHF4O0XzhWqZsbDVUGSF+OzRO23ClV7Y3SS
         DExg==
X-Gm-Message-State: AOJu0YzwjloFeH19ZQLu8ypm9kz1oXQuFLK2qjBZ9r8D253pXNYeSDe+
	LKm4XhL6fQ/mE18c/DuUHIPnllyT0lvxkT9obZOTBNs6hvrI8fowWSTODlv/IQ==
X-Gm-Gg: ATEYQzwNS6ILiFVAlTE7KBmqCCQVsK96RIsBlaCgsJw000iNbAzI0+2DHzUpr9WJmCM
	T18ZMtnXb2BLgTMdpFbmfTojLK2mofvnhzhY+cbGsDk76xwVrqcmyZjsHWtGGhJvWqBnIJwBJbB
	lepDr0limZSzhIfRiRxiU+uWpGvVEQnrcu9OPskH4nhtrWvjlMhLwQq6QWoGN0Os/AYWB7udWBe
	rxjVcUTjbjk5B9981zuiXdfMcA2qOjH5cgL6w95LGQtnUJo186VteF5AV/Iqvsan7xXr13tXCzt
	rZveHtdes6UDVk+7OGBwmwXCQkvv1DB5SIS8ghdqY31LYLUKevQcfpwm2dANrw2tcNnZ8h9CrHy
	yRuZY7jvXnedhzkK8mXJ63CT6bRzzUJ2giP7KbaggyX0sUah1K0lajAn/1CwbMBOyjg9fEvV0u+
	SeHOMGP7JtNh6LbzpaTOIHCmyYoEmz6AYZ/v1i8yRnOTyhW0k40YL9a4mmzl9OqIjPPMVgpEP1f
	Pi4acTSwcyPT7oQ9Gej97DP0AVcq5HjXdHsGSkwtYVX
X-Received: by 2002:a17:902:e5c9:b0:2ae:3e73:2b43 with SMTP id d9443c01a7336-2b0827868ecmr76930015ad.22.1774159706956;
        Sat, 21 Mar 2026 23:08:26 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08369e41csm70662135ad.74.2026.03.21.23.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 23:08:26 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH v2] branch: reject --show-current with -v
Date: Sun, 22 Mar 2026 11:37:05 +0530
Message-ID: <20260322060705.53491-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --show-current option doesn't know how to handle verbose
logic. In such a case, we want the program to die when both flags
are used together.

Acked-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
I only changed the title of the commit message.
The previous one (i.e remove unnecessary verbose flag) sounded
like we are nuking the whole verbose flag.

The acked by tag exists here because this was supposed to be queued,
I am resending this to remind.
The originial discussion however is here:
https://lore.kernel.org/git/20251226032804.596058-1-jayatheerthkulkarni2005@gmail.com/T/#u

 builtin/branch.c  | 2 ++
 t/t3200-branch.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index a1a43380d0..cab22e1538 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -861,6 +861,8 @@ int cmd_branch(int argc,
 		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
 		goto out;
 	} else if (show_current) {
+		if (filter.verbose)
+			die(_("options '%s' and '%s' cannot be used together"), "--show-current", "-v");
 		print_current_branch_name();
 		ret = 0;
 		goto out;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c58e505c43..5bb49de9c2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1716,4 +1716,8 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --show-current rejects -v' '
+	test_must_fail git branch --show-current -v
+'
+
 test_done
-- 
2.53.0

