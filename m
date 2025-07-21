Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE427FB22
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098930; cv=none; b=GiuNAPgtkzrb4ObLPOE6GwcP5zCBnkJLqhcPBjbhjLwMz4bLEq77rqWO1V//ZtnAgTMff4fL1fiqW5GXQTuLLfXLzerjiFJp+LJog0R0Imx+t7F9REYABoo7cDpcUNOyTNeQgLa42U8UW4GbWTqVDfOsUBMMl619+TwGbHNYFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098930; c=relaxed/simple;
	bh=G29U+opAEDQHY0KMDxDDxq86osSxjlPABpCqUTVagSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntmx/HzmR81RfEDvuMATtkALQPWFfhSNTtnml0t9pdXxnjFqG3zVT+dpcltNsYKnI9bGsPEcHbpFaM5SW3/LuVSQgj8LQVnfPGj3igkqx9Z9cSIesMvvpC2I1DxD85O2pKKTT7GKv03IQyYCV3WYVlpkv/z0j9tqOqb3uQ4FO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee5TEcCM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee5TEcCM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b54af901bso2683339b3a.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753098928; x=1753703728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD4Vx97hvk05x5XihyhkXUHLyuiJgTrDUx4jkzo66us=;
        b=Ee5TEcCMxkGPMgk62TYe/s7A8lbT712b0FFonQFID4XoCAZ2aqDA5m3q7G+2bxF0nf
         4/TKulBh+mFE5szaI2oMCJ172KVFjK495Gbp7q3yIy9W9ynx6XEdfLvpwrkxIlelOUXE
         hRqkYU1A1t8dbMS2bhy3M3CcfByb/wIFbBmYdPhfFh09J6UhobUZZLfI9gR02+TKTsOz
         DvpWx7Jn0tcmOV+j0VrpgrAZeGcD3JrziIMj0bfANXrYS1AMYowun8PyOYx2BjVZmrx6
         G3KyKD3h4HZgtC1Y9/Fb/ZkUd2yNpss3nsorT98LcaMfbkHw/FsDqGBG0j+OV+WPCTjX
         Lw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098928; x=1753703728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD4Vx97hvk05x5XihyhkXUHLyuiJgTrDUx4jkzo66us=;
        b=GzivGgzxB8GFqdrHFHQy4WB+DTEG/ofgPDtLqnqTAT1Qw6gAtRDSsbC8th2lSAWabs
         yiyofp5K/7xf6m0RiBwa1UplP6dIq1/CSjhZoOPF5kF+d44izBoJqV65XTJDiHHaNozL
         8/+NoRy7gnm3IDnQMp3Bp99zchpeD+Tewd/Y4JRNQAvIUZpnv9CRWP4PHoOr/sbnrzW4
         bh81aXSrMKTuUmutxWzU5fwZpQQm5Fn9faeN5GH6xPzJP+K2EfR414/p81Jv7fi+B6bZ
         PmOeRM4UQ9IvW4OjCduFu2sVNjhAtpClJn1TVkddjDVY+iwiLAFVGwb1lY3jjtuHqwTk
         mapw==
X-Gm-Message-State: AOJu0Ywk8Jlf26irqwqtD8QjxSzpaAu5NKCDvkFKq4rVfVTPofvkh87g
	/ypZKoiZ072aLE/cHF//fB7QGMBjEKei/uLe1SM15oKfqJ5vOKU7xeT+FDyfzqBAncs=
X-Gm-Gg: ASbGncvvX5KR3JPmbOXCUS8IZPM0OFBRaGqYp9LQIyHCwUmZ5kkZqxfQwDnGCeDx3ny
	wRB/smhhNW084AbW0zcqXgMP+D87m76pCkBD0u73Q8CUSjIeEla1rLsPvVdMWfEPd2Q969vq6O4
	gD4P0G0d+gWrGOxtqrtB32lspT9iVEtKT16fLhN0LwlD2fN21c0N1F7RsHUKkiPl/2REZWKsYAi
	oOc3x/FeQ5jNswMcscE7+l8iGDlLOExjXYqkMVfjbk0pY5TvBP7jarfKdn5zt+hjEJLz8UOqorB
	Hv1OC45w35WCR8uQm4PCyJ1xcyy8lewr2+PV2Kw/genTqhpgVzggK2yjQXNCq4AI34GXtC2bkI7
	mFWk9Tf14tiVGN07lbHyggWK0QrElMeYR6kBcA/1X/kx2lQc=
X-Google-Smtp-Source: AGHT+IEdfqbFbGkU3xPA2pqVYLiA/UcU6lcPSIHHpXmjg7PPfEIMFFIbo+50XTyzCrEzkzG4+otSsQ==
X-Received: by 2002:a05:6a21:1709:b0:232:4a42:dfd1 with SMTP id adf61e73a8af0-237d866f981mr32178646637.36.1753098928380;
        Mon, 21 Jul 2025 04:55:28 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ffbce6esm5135940a12.72.2025.07.21.04.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:55:28 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com
Subject: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
Date: Mon, 21 Jul 2025 17:25:18 +0530
Message-ID: <20250721115519.140361-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
References: <xmqqcya63cqx.fsf@gitster.g>
 <20250721115519.140361-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual `-h` tests with a loop over all subcommands using
`git --list-cmds=main`. This ensures consistent coverage of `-h`
behavior outside a repo and future-proofs the test by covering
new commands automatically.

Known exceptions are skipped or marked as expected failures.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 6824581317..9fcebb7d94 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -110,8 +110,29 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 test_expect_success 'update-server-info does not crash with -h' '
 	test_expect_code 129 git update-server-info -h >usage &&
 	test_grep "[Uu]sage: git update-server-info " usage &&
-	test_expect_code 129 nongit git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage
 '
 
+for cmd in $(git --list-cmds=main)
+do
+	cmd=${cmd%.*} # strip .sh, .perl, etc.
+	case "$cmd" in
+	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
+	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
+	http-backend | http-fetch | http-push | init-db | instaweb.sh | \
+	merge-octopus | merge-one-file | merge-resolve | mergetool | \
+	mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
+	remote-http | remote-https | replay | request-pull | send-email | \
+	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
+	upload-archive--writer | upload-pack | web--browse | whatchanged)
+		expect_outcome=expect_failure ;;
+	*)
+		expect_outcome=expect_success ;;
+	esac
+	test_$expect_outcome "'git $cmd -h' outside a repository" '
+		test_expect_code 129 nongit git $cmd -h >usage &&
+		echo "Hello" &&
+		test_grep "[Uu]sage: git $cmd " usage
+	'
+done
+
 test_done
-- 
2.50.0

