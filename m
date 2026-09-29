Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399233B6F1
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715777; cv=none; b=mUuPonDxXWMiEiyhqP68DkBRgk79hhb4V2FJmI5ZXeQSey4hAL0tpL81uCjFiTjA0Vv/IMEg/vPFDM+ht6Gf8Y3EsJJSWKMd1Yk9sWDTRrpETB9tDagFCAHFwoRVw2ZXa6gC8tvozDGbbSQo27+CN6dEdayHIL+Q6L7kI2gTFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715777; c=relaxed/simple;
	bh=aNoUKPBcU6ESSvB/OueX7M0LIHIdH6TUbZYhFlDN2y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU1CDZiy2Yue4YAJBWGtEtnx1ULNoKn0o85NSAzKd0PpC6dwQUyV8g8+Jx6z34iud7dsGS61Xz+FD07Kr3pcprrIQEYeRZMHaGhtz+rnGzTD+MfrxkQahBoikpIQIfkIfcxvkz/YUp+ogVrMqNjPdNfCTYpGV+f8r8MFg1jeHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/WfqJgh; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/WfqJgh"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a0025d3f2bso8543845e9.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790715774; x=1791320574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z2+bIywJZGyBvqgyVFa94H4PL5L6tojhRoyxchyLRB8=;
        b=o/WfqJghZw3hUw4HBRA1lzytGY+3J3EMaSe/mbllsRSuLsrWjluNXUwAX1RyX5M0g3
         zmLkaRw7vNYMBFshVutkUN5ZB60s36e9thcydSFZgjpo88hRpdAn5UM+KIS51EGD3DPN
         P9VjIixqULH9smUk97+Vq3sSILQ+8ITgkB6yVDgIA+gDkB+kudllIATZbNORRpuz6UVL
         cOh4UHE4LiDKtkPBWEQ1VbgfVTOCcA3zfcsX+KBuaeyfOBFUoV/oWqHGuA3uXPDCuOCW
         98CwM6NaY3dwXuam382MKUFkxmtxs6mDSD0Ix/KRtQfgv+6mxMFXOoB6SuwYXeuE3BaI
         SJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790715774; x=1791320574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z2+bIywJZGyBvqgyVFa94H4PL5L6tojhRoyxchyLRB8=;
        b=Ir/UtshFECIqQR7G23COffR/BV8gNGsY18tHiV4qoH/YardR9UzBA8QSTLMadQgOmv
         Hju1QY2AcWGh4EYQxAgum4PYRpdXjd3wAXXXwuPQolFVGYgrWQ0RJkGl5YrzdhQ/8+T/
         mqZcNpSQmGAYF9BNPVsZDfqkHslH5iLzyjGe7yyqFLEXJW85qCzTSfl2JbCLRGe/UWXs
         vqlg1ht1Rt61r0Pl/IZiifJeHq3tnrBZFWcubqwnDmgH1ZAZSqP5cBmbOk1ST2/HldlG
         tc97GDSQbRnO8VZOFaKqPuTc1QisqFkoOD4+RLsCIR2VJUGVTg67XhAZZET8eahiXNY+
         p4Ew==
X-Gm-Message-State: AFuF++lOB6LPzICMHDT8iE/XrgwY17Z2nUiTkafQ8BmxbPUm6YWBJ8Ll
	c8CLy+GkR9iWnW4z4cszMU1fqLJGV/OC7VgSjvhxHj8iO8Sb3aX4COjL
X-Gm-Gg: AYBFou1GbE6YoH8L50s2+z3yyynHHJ7xIN2B0Z/AdcK5mrvUVJhNSBA+dBN1eLMuI0q
	nJR/xo0KSW88vtOk6/VjrwnMN1xIrjilyuAl27CmD6KHViqBh50uwGtqzKzDgHq++/m1vnqABx4
	4qsumtkEhDH+/kWNuZnO02uqW9wHV1zK42JXI7oE99QCfPhfuRMwO4kiFsgtTpxDVNkK35w7XP6
	pPfWnSiNCDXFZdqNC6uOQPpPDFCFV7teeLZxSmm5bSiGEB7GAo0On3fXT+8WtXQJkYpQgdL4w+D
	5ZD+CbPs5HGK8RtdfJs0eesNnol1r3R9mjG4yPX+gu1SsDw+NTOfkIdS+ddnGtjAKsdkstKMqRb
	HV1vc0NfXLgxWjySlYxHmlr5cD2CS3WixpbnPvd5os3fWw5lK3LsP/hrvBjRqtQHhp7VtKM6kbj
	YdO07Z1IY4XUDZwkySJ9l4xNiNhL3h/YQAGhSFPUSeZ1OTmRE=
X-Received: by 2002:a05:600c:1c19:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-4a014fd2689mr7491275e9.1.1790715773787;
        Tue, 29 Sep 2026 14:02:53 -0700 (PDT)
Received: from DESKTOP-OI0N70R ([146.158.109.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015a1a854sm720445e9.0.2026.09.29.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:02:53 -0700 (PDT)
From: Khan Zimov <kaliugov@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: [PATCH v3] doc: remove unnecessary commas in git-add and git-rm documentation
Date: Wed, 30 Sep 2026 01:02:49 +0400
Message-ID: <20260929210249.1024-1-kaliugov@gmail.com>
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

