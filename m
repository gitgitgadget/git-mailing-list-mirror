Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C61C5F38
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738445604; cv=none; b=UEDkCl+4r8j4Mfs2g9cRsYYcVG7zVGb7NUsykQmCcs3y+Zmx3Kg6T0D/48rQ84RNdt3PVp+VAbqbzdVpvJ3cUFIIgvd6QfzUzgiQlg9EbZgZBiisOqyuz/G4uq+V43icDZ8I2v77RNh1ZgGHXnCxKjme4Syzom99Ojq+CPdyxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738445604; c=relaxed/simple;
	bh=msL2mXrmHsUfjPSOU4gGVVmAtTK76Xw6kiY7Yv6gAYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRry74bQleATEczQA4pTfh/swQH0vvEu4N/FRsVI2utrf5SqydmtE39ifP5AjQm2BKpI7HDAgDTfhJcj4kJ+aN4Lm7ocFUt2fSVJAkCP1GIvVwfFkEW3uERfT/Xflsb9bLDsGS+euZy59BevRtTp8RgyCCCfLOvbIEksZ5glQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6nDdN7k; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6nDdN7k"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21c2f1b610dso72409165ad.0
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 13:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738445602; x=1739050402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HApIVssl5zdVi/CxLtWS9esQorbQt0pSW3zwNOhGd0=;
        b=C6nDdN7k1Nam3zNLxXxp2DEZu2RZRYTMOacCY60qKDpK82OU2MBzKOVkYPnKHFgn2S
         BA8/GVNjSwlP15FWHk1D4tVEJPcKKao9mcrAeIKJG6lZYWppNSgNdl0wVWQWsdnu98Fc
         paHxwefm7V0qB+Hct5+cg4tYxGEc15zY4SvoYnW9zwGuyKtmW5L5PRAevwyoJZenZmUH
         cAyT2IefdZtzlT59Mggw6Pt5l9oZMdS+R1eWyGeR9oX7CD4fC6l/c75JOxGWZ42j1rXo
         RfaSPQ8ymei4zKVMDvoZXgy72fA3cRKDfSsKrbNi8OiWgKJ4Xh6lx8TVgs+IwGn5MyrA
         agyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738445602; x=1739050402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HApIVssl5zdVi/CxLtWS9esQorbQt0pSW3zwNOhGd0=;
        b=ZPc4NR9QmQZplFq9aLIj0QvXTzunWVosGMvJpJGnebi67xY8YmgeweWgo0xvvRqjqf
         lB4JObDO1kvGZcJ2m14zgAvlp4Yxf9/61N3vshFNCZKNFi/OXZuLTUcsNGExWFofSGTX
         mkAGf5XIPuntRpO6YiMqbh5fXJSgzOA0GfTjcTgjt/QpKwpiqUbUAR1vxM0tHygtYM74
         jJuy3eclWrEsOPiBETVFVgEpy9N6aimaVPjDYzs3QuRXRf4JXmxmz6rKlc+nvsdpb1Ys
         WTsBGxz/YvmDn9SbQJCogMF2H6b1UyRp7tDQn6+tEn0sH1NTXtROvPZqfL+3I23CUrBl
         iVyw==
X-Gm-Message-State: AOJu0Yx8EBopLRCgjdbSZ7dIJ3TPsr7hxMUC7YF7LaRacOm5sP7ZwpBU
	2mt9nhuhLrny6GaXcOHFWcdQ6GtdFuPSevnitoKsMbud/87ffNT6OzNLVg==
X-Gm-Gg: ASbGncugQtZsjf2k53z2Aydrf9n8avLXSLOKytl+sOdUSIs/d4b7Vqr+sLdAiLbAlv6
	2u7J3ZCD63S3ENUUwcTOv5jH6g2ur9JjZ7ZEtGnQfkOBJq3BUd+FRg5OLjR6d7gCzAGbDvwPt0d
	XEmrWxoClOQ8+N9W1dzmANxgP1I0z7NpnuchL58ceKE+vxJrNwGpOmyKElxIVmvtyseB4xojbL6
	Ov/Y/LOah9u643+mt+r4Swji1zSDFyHOTyoZQ7x88/+J/V6Fp5gr7uFIG2iRHqVsC+qwB4lX8oF
	In8p6S6dizAl1kE+d3KxbIRc55w=
X-Google-Smtp-Source: AGHT+IHef4gSROs/5oxPCgaZAjfVz6FwX9ZCLyt+k0/gTsQinpEuQyutnXnZ05mwxzL5vfKtjZROKg==
X-Received: by 2002:a05:6a20:ce4f:b0:1e1:ae9a:6311 with SMTP id adf61e73a8af0-1ed7a5c4601mr26388196637.4.1738445601893;
        Sat, 01 Feb 2025 13:33:21 -0800 (PST)
Received: from localhost.localdomain ([172.56.122.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72ffde3d977sm2453292b3a.177.2025.02.01.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 13:33:21 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yongmin <yewon@revi.email>,
	Jeff King <peff@peff.net>
Subject: [PATCH 1/2] help: show the suggested command when help.autocorrect is false
Date: Sat,  1 Feb 2025 13:33:18 -0800
Message-ID: <20250201213319.153109-1-davvid@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>
References: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the handling of false boolean values for help.autocorrect
consistent with the handling of value 0 by showing the suggested
commands but not running them.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is based on the sc/help-autocorrect-one patches from this thread
and is in response to the open question from "What's coooking in git.git":

> On Fri, 31 Jan 2025 18:51:33 -0800 Junio C Hamano <gitster@pobox.com> wrote:
> Looking good except for "should 0 and false be 'tell it without doing it'?".

source: <xmqq5xlu4bt6.fsf@gitster.g>

This is what it would look like if the answer were to be, "yes".

 Documentation/config/help.txt |  4 ++--
 help.c                        |  6 ++++--
 t/t9003-help-autocorrect.sh   | 17 ++++++++++-------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index a4c6079af8..676ba3a55f 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -11,12 +11,12 @@ help.autoCorrect::
 	If git detects typos and can identify exactly one valid command similar
 	to the error, git will try to suggest the correct command or even
 	run the suggestion automatically. Possible config values are:
-	 - 0: show the suggested command (default).
+	 - 0, "false", "off", "no": show the suggested command (default).
 	 - 1, "true", "on", "yes", "immediate": run the suggested command
 immediately.
 	 - positive number > 1: run the suggested command after specified
 deciseconds (0.1 sec).
-	 - "false", "off", "no", "never": don't run or show any suggested command.
+	 - "never": don't run or show any suggested command.
 	 - "prompt": show the suggestion and prompt for confirmation to run
 the command.
 
diff --git a/help.c b/help.c
index 7148963e46..55425c0d97 100644
--- a/help.c
+++ b/help.c
@@ -552,6 +552,7 @@ struct help_unknown_cmd_config {
 	struct cmdnames aliases;
 };
 
+#define AUTOCORRECT_SHOW (-4)
 #define AUTOCORRECT_PROMPT (-3)
 #define AUTOCORRECT_NEVER (-2)
 #define AUTOCORRECT_IMMEDIATELY (-1)
@@ -562,7 +563,7 @@ static int parse_autocorrect(const char *value)
 		case 1:
 			return AUTOCORRECT_IMMEDIATELY;
 		case 0:
-			return AUTOCORRECT_NEVER;
+			return AUTOCORRECT_SHOW;
 		default: /* other random text */
 			break;
 	}
@@ -713,7 +714,8 @@ char *help_unknown_cmd(const char *cmd)
 		     n++)
 			; /* still counting */
 	}
-	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
+	if (cfg.autocorrect && cfg.autocorrect != AUTOCORRECT_SHOW && n == 1 &&
+	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
 		fprintf_ln(stderr,
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 85a5074b5e..5ebfc00f52 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -28,15 +28,18 @@ test_expect_success 'setup' '
 	test_cmp expect actual
 '
 
-test_expect_success 'autocorrect showing candidates' '
-	git config help.autocorrect 0 &&
+for show in false no off 0
+do
+	test_expect_success 'autocorrect showing candidates' '
+		git config help.autocorrect $show &&
 
-	test_must_fail git lfg 2>actual &&
-	grep "^	lgf" actual &&
+		test_must_fail git lfg 2>actual &&
+		grep "^	lgf" actual &&
 
-	test_must_fail git distimdist 2>actual &&
-	grep "^	distimdistim" actual
-'
+		test_must_fail git distimdist 2>actual &&
+		grep "^	distimdistim" actual
+	'
+done
 
 for immediate in -1 immediate
 do
-- 
2.48.0.rc2.34.gefa3f50b25

