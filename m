Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD61D61AA
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972636; cv=none; b=OQBQQGlv3eWr4VUZPRxq1/NUh1hoqt77aL2et76P0MpLx6gIUxgf/s+OcjYPT6XqIiiwcWf3rHbff1aB6UDO+iuekYyxSm3p838EWoL06r/xusthnbDfZ8TIbMiskZUpCqeMDc+l+1RChCW6rvxe3Hw6aDaSxEJFmYD2IvoiMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972636; c=relaxed/simple;
	bh=9kSrgu7AibgYBpB8rXYG4+d7CmN1e5r0LBFoLeexmUk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=t+fpqlwn/DvMlR7lMZghSE80os95dw/X/JghZ9cvzw6km6um08axaYXcbUnkwxXIklRDrstGAsIU8XJcWDc9i+N9+xiGEqdYwmmexynn0ovh5bexx1/LPQKUwpPHGGLN3C0WqKRC2OJwiCmO0g00XRvTdpvN4nMfNAENyenAObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPu4Esvr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPu4Esvr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so1246015e9.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972632; x=1737577432; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw3Zg/upD1GF2TTxaqBOYGHuedyS5wJfBxjZ8c/mhHA=;
        b=DPu4EsvrccmTUhK90/OppByurdg9x5rbBWdWhAO5UbNsFe2WiialcyrkQ0PME0OuWc
         /hVcJnVx/ZWWBK3ThyYr62VbdMYqvNJXPBo7Bqy5iMclvKLvDL1b1yEOeU0/19QIKPHu
         tWKJdeplcfHMD+1CiacPrvevbDArwdCPFNLS6goZB0k/wxyU3ENWSd3k6J5/21xAVfd9
         fnh5mpqWw+VH0bKdwcrrKiFeLNoD5RemCGrgaU/jU3GblZwF8hIPWEoPL5cJg/8QvevM
         gDpiHHB+yipdoSYwhGSG1Bun4dv6sdXIiua3BOjcLw0OeZ0HiNTJTI374qaA91wRqLR8
         5RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972632; x=1737577432;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw3Zg/upD1GF2TTxaqBOYGHuedyS5wJfBxjZ8c/mhHA=;
        b=eL++vwuqfwnhd4eWGIH+kEqnVj4S4Zos11Zazgy6QUq41cBXkNffmFd4l983xNCzoy
         kglDELagm+DrtZCPgqYjQ+slfW60UT0leZesqdZ/XvaTVRaayGRNidhj5UczSsre08uN
         qBAKJq3ChF3swECTo6apzcEypt3w/gBcZ0LqgJruasL5FnMzfnwttvEZexOk39joR0Va
         B7N6ofzu0/c9/cA/Nm9dxOPRglreNYt4I5QTP9VdA3DBRyV0sjEDbC/OWKv6EYmIxubs
         UdxsY2vH++usmrtMlxH8+mWyZbSiGCe67QQkuv0+fswS4jxeSZV/VWcY4BLCaJbt8cMv
         2Jeg==
X-Gm-Message-State: AOJu0YwBB7uKjiIsjjhtR5JMXDIThEyqXSfJ7l6mh+tNorCoRomiMyM8
	iVGDGLEQE9z4JphTYdk2vIdfqLBZNFCM161ZJG8Otw2i6Dc0vihqJ4pNIQ==
X-Gm-Gg: ASbGnctygzqfITT7rSFuqVSrR8fXTzgP/SUAQX4XG56vHI8yCNWd0VEm1kerOUGM7Qk
	aTVD3OR55/ATy5bs+C7ahwjpHWL3ryhlwcNImjCnKYLTHqdVXVEIykxNSfZcVYGdyx7QW3A5udl
	bFABg2yUKe/OQYT8l1Kgb8F/qYLZ1bszmaWzetRxjxQQtPDhnFiF1xdSW3aT2OvPJaUrOpTIpfo
	YnBVf86NgZ/KUx5WmKdWBTZEvqq8Qb9mRSMtVjcc0xl0akBcvoqCFUL5g==
X-Google-Smtp-Source: AGHT+IGIV9m5jF2ZlgToVN8MgsP3B7ds55KtUs03bOxmIvxxHHgW5Xqsus5wqIDEVbBrTn8OiQqAAg==
X-Received: by 2002:a05:600c:4f09:b0:434:a5d1:9905 with SMTP id 5b1f17b1804b1-436e27070bcmr247879195e9.26.1736972631901;
        Wed, 15 Jan 2025 12:23:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c73e370fsm35338135e9.0.2025.01.15.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:23:51 -0800 (PST)
Message-Id: <d58526a9b39571dc2dd2703f62082d20b7a82446.1736972628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
	<pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 20:23:45 +0000
Subject: [PATCH v2 2/5] doc: the mode param of -u of git commit is optional
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Fix the synopsis to reflect the option description.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-commit.txt | 2 +-
 builtin/commit.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e37c4a4987e..f5d702205d2 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [synopsis]
-git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
+git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
 	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
diff --git a/builtin/commit.c b/builtin/commit.c
index ef5e622c077..a7315ed67cc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -44,7 +44,7 @@
 #include "trailer.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
+	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]\n"
 	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
 	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
 	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
-- 
gitgitgadget

