Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1053F3265
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715986; cv=none; b=o8a2MPSj+oVN7IHn5Riqrg/bjihIQwG5oJOfM0Cw8RpCqIBatQLc19DMKaEZu12PFo+ZOfpDHpT2E9W7JfaOL99/OiUvwx2HQ0wm0B6QqnSRaLAtsNzF2ihqr/sWp6LxVPRWDac6oBPQV30nFitw+zcyD622bh3wZzGL0jge58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715986; c=relaxed/simple;
	bh=ygHE/HilrPlLHbrZWNjmAelY0RY2Qgnd1JXlAtRLDaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4aqHg6duAmgodo/86OOvjvbmWEyS/QiMbatiT+wXCVMOsb2ppqi1G6wUQN7vOQb+WUgNuj/s3hZnV3DAe1OvbP1SUBtwVI2B6AH//3lWmJQCffCZGnCmLXzSkekuFCRCB43eZ6GuZzdT/qNYfF6/9hgEglPmaJoJVg+zt9UZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+DAxa8K; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+DAxa8K"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so1484176f8f.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790715981; x=1791320781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGAQR4BUvHBanRo0wIppkH0dXNttMyXlqe+JM4Qsz+M=;
        b=E+DAxa8KU7qCSpFeZkHmOsMLQunNEdGPHy9J9lukFo2jz3mXPVa02JGpjROMKqZFwl
         w6xCGsSp66aRvzRe9CxvXSzGXgbO8VZfHa6XdjDkLhlzrq+1Hs6ZJS1mCy2snY2rNmrz
         IAPwshkC67UT6Nk1SMX445bH2B6n6DqzhBTDHC5DtaHxMCzApbk5AOyLR1aFoOuGmYmr
         dpgUuqND2PP24gNUMBFrWrYnv9ggE1LLaDGIS1ddjdwnwQ5K3MzF3b7ae8P/hbmv2Olf
         RDczb5botZj/mcIGOwGW1cnotOAuJNO+lsXy7goHRzFFjfiVt157RT8l1OjNvXGdFpjv
         JyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790715981; x=1791320781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGAQR4BUvHBanRo0wIppkH0dXNttMyXlqe+JM4Qsz+M=;
        b=kcQdzPc8HG7GUELGdXA3UuOsuIBCJyXGryD287EHeQvD+zgqqd8Bq/FmYQDz2ltc9c
         GLGcaD6hHtcGiuPvz8q0U6o+8A2oCqYP2jna1IhR6uUOilLXP0ibFHtZl8WUrUP36Tuj
         Hy6jwHgVsAW8mFyZgeY0zELrLI4fNKPZ4Shg2Y0J5TX4xpQAa4Q1kuIar2s5jODyydvU
         4qJ6e2cBbOJgZpi6IDa6/+hurUHRjhDrTro28c+oBVvEe3jlYGyVTwFsLN5vEsExJApX
         DHj0TgPM4jltdg8x2UfNOJcC2D/Ru+MfVufylnHBC7R/eSNSZl/F7HW4fG3XcL9C99ab
         Oa1w==
X-Gm-Message-State: AFuF++nqan5dms5A1stFEQ88NBSR9w8qPecATzexxtwAANE3df0mOnqH
	BxEHClrCqbk6C4Ymm0pfIJfm061viUJIW23rIV+ayjXZhQ1ol8bdjOwo
X-Gm-Gg: AYBFou1FwlxRDaiCPkCqa7m2AlQ7szbW7A/Y97HlyO3PMBw/HRpjovDoGPe3zMZ3g7M
	QfQlbox++0Qz4lFE9EkNDV0P36dsPV4K7lMh00Ue2sezuEdPkfQuAHKgYdd9Gg02aKhdxX5iTE+
	4M+vgAh+/B+sV6eBcCfB3+dgXVxf4vOKobs20sc57ydy9LtrvWLFfcLkM3tMtnSo7P73yCespHS
	IeXy306fhCcK2Q+isAPie1rQzFbTPxNxx8U8KoT9sCE/1BL1/n6KWGnrc2hZf5fMgPiFjCXl73A
	S0qVCXIn9WshlrSgJVCacoaSYozq5PJkTL2XUGg1Mb1YmFmDFES5th0WyyffIZTMiPOVfdWEBno
	dQxLG2ItpIJmRy1UX1LeLqTMpdsTSZJVnGBh44E//DY9wdkk/JnUUjlV72ZLWuHMjFTlqQ+Z7T5
	ReeCIxVrkuofUwoiv7/h58M3cwEX/ftfX5err3pyotZhyvL98=
X-Received: by 2002:a05:600c:4454:b0:49d:1f32:c911 with SMTP id 5b1f17b1804b1-4a014fcfae6mr5492045e9.3.1790715980865;
        Tue, 29 Sep 2026 14:06:20 -0700 (PDT)
Received: from DESKTOP-OI0N70R ([146.158.109.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a014ed6482sm10666665e9.0.2026.09.29.14.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:06:20 -0700 (PDT)
From: Khan Zimov <kaliugov@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: [PATCH v4] doc: remove unnecessary commas in git-add and git-rm documentation
Date: Wed, 30 Sep 2026 01:05:04 +0400
Message-ID: <20260929210618.147-1-kaliugov@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <xmqqh5je4o45.fsf@gitster.g>
References: <xmqqh5je4o45.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Khan Zimov <kaliugov@gmail.com>
---
Changes since v3:
 - Add changes description.

Changes since v2:
 - Use real name in Signed-off-by (sorry, handle before).

Changes since v1:
 - Also fix the same text in git-add.adoc, so that both files
   stay in sync.

 Documentation/git-add.adoc | 2 +-
 Documentation/git-rm.adoc  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 16b06e38e1..3fc2513a2d 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -223,7 +223,7 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 
 `--`::
 	This option can be used to separate command-line options from
-	the list of files, (useful when filenames might be mistaken
+	the list of files (useful when filenames might be mistaken
 	for command-line options).
 
 
diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
index b5ead86796..67061e961f 100644
--- a/Documentation/git-rm.adoc
+++ b/Documentation/git-rm.adoc
@@ -61,7 +61,7 @@ For more details, see the _<pathspec>_ entry in linkgit:gitglossary[7].
 
 `--`::
 	This option can be used to separate command-line options from
-	the list of files, (useful when filenames might be mistaken
+	the list of files (useful when filenames might be mistaken
 	for command-line options).
 
 `--cached`::
-- 
2.52.0.windows.1

