Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795278451;
	b=BCrDZ74A/dtP5YYtDKiTcD1Y3tOchuYqW1bgQ7JcmptNubQzjonf2HTsDgkIUjykA340
	 cTDElO95O70TcFS7mrfUdqTkXqNw7V9GVJ9HxzolurQV8zrGdjurBQHAHpC5VbLaWd4v5
	 LyUp77E4Dfd3hUckWwn89ua8nfCUCMWqXx9NJX6r9eVrmUqv6uXfFW57DQ2lUkOpF2xgU
	 7U09oxb4hIRoD8yPw7AyBRAXaxq3U9PrNV+a8VXj2uq3CA1taErLFFHrNumMKLxGcLhDr
	 W4Y7igvvnOn1whJNJ/nbN2PaTTDwbRTaqa9xA8H5K1p5w1eGAPz0plRL4McrAaeMMiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795278451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=q3xsNtlX30HtgM25Hkr/qGC9XoPMkdp/S85t64i0Tic=;
	b=CDSijUeLRJ8QrLEDm2extOA/PkMsLGb8bdu5kQjfXVGcWHxcEMM8ZvM0y0u/rw4+2Lf0
	 SEK0jFFALtMUrRNajBu8wlJQ6rPubL1/1ZkJ4P28Je1kxidGII74akTjD6cX0gcL34Yne
	 VpwOwZtFzpMoxjMor3XTsISTov53uQBGhyY+e1BsQbf44iezJozRoRh6/ArCuzYnd/K1j
	 UAxk7nLr1KTQjW4rhJHNBlp3/jZpd40FxiNBDbt5YpVqioAzXiq7c4GAn01O5dTcsu51S
	 19zZ8fV3ebLu7mYQAzzj96/4zTJonuxXn2QX6DmZrVa2rS79C6s4PB1GqIyY/bpLtuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vARX64pA;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25104606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 16:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25104606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vARX64pA
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5365d26ccbdso25050041cf.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795278450; x=1795883250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q3xsNtlX30HtgM25Hkr/qGC9XoPMkdp/S85t64i0Tic=;
        b=vARX64pAoT8EbKQg/LreWY0fa7zdIrIh4YJy0C6ND6tw6+wPa4O9+HeBqMGMgRlw88
         FPwgVa0q0fg5tAkvygjAdkAeh1xtv0yiUCQZ3ZrsTWkb3l+y77HC6YSe+JjKwU2ymO5c
         NDuAu06OTHTE8BhbwfEgqNxsvD+wenyN0cGDRHV/f04aYIQhzOMQfhdghCuPTQa+Pz04
         u4KdCJrpOyaJ3WSqnv9gDgQx+18ibELEib+ca+SokOLsZzUtBeh7ofTI7KvB44kktjJu
         ZjYTHcwVd26mc/WxLeA0KkTOX+dgUYKTRfV/6RXuu0TFAU0zbxz/Gfc70xOlzb3J6qOW
         0Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795278450; x=1795883250;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q3xsNtlX30HtgM25Hkr/qGC9XoPMkdp/S85t64i0Tic=;
        b=Qh3faV2zvwx0PQqkDEpSOyZxqbDFld5HpiRqaiGdEvU4jt9m+qVRU/1qXB3ARmIrAT
         gYhg1zaceDR+m7xb6WbPqG2y8QFJXI0uiFOMjw60G+uvejhrrtjcyPmAcFfFILGkMIQB
         yLVZFrKPqeFZHN9UQJQb9MbOyAFFUP0lPMYN0KuY6+ZBvufzFBxaklmcTnfhkA3Yxrzu
         dCwmGXXk74zG1BcTBH+//AumoggNHlRBZv+i0eWuxBbb74u35QASr6k/nniEwmhRc8lP
         X4OGfq+oLaDGCWMa4OEKtbOE5nqJQ1g7um6TGpzIBWA3KoRYkwpN+SOpZqP7Tp8xuujd
         lryA==
X-Gm-Message-State: APuU4Z+UOxstlS2vWIXm3ydwNU726qcc9ntI8z9UFwrMX+E2piHGRfI+
	QFmdH+uzPzrRB2PR+yVD274wDH7iiwgZ3lnt148dqeRCbhzrhRJLTsazLfpRiA==
X-Gm-Gg: AZFdTZcqGl5GC6WKvqydk/1LYopL4eDWRTiqdcya/z3OA11TAIUNGXsQfGFq23rD+Kp
	G7G96bgzQuQOANBbFv9jRYm2VRVUSMmK2yDiOqcvsGiHdxAUxu6YmnE2LvHILEOJsPLaYBRvdvX
	WENivUf0hUOmCMcYddnOXcSryHgOxH9I2vbsYvVixrXN2OgrhbYY3C4i4Vv/qNOG4E/QmiE0jJn
	EjyBt0Utp6Kz8+Mbg/F56/xBk8kIgVlypOuBroGREXpV8Q1txsVdY9iSicjvUpKPmCoE6nSH/NE
	DvOl2uSkmgPW3SNHEyaJMC7c/HWFLKM/Z8co0KtzohOLVlTGgFiW9dfDM8hGuC0+nisJvL9c0Mt
	RloSlD7c/m9RJPowH60FNTxkPUhGeRiW8rAM8W0Of4w4afAdMyeKsZbCmAP8zvDbl8Y0zZky3s7
	TKkl+5yUvYrPN1P5KLHY59pya957JOninCyI2GrRJs/rQUv7e2L/x3Tn9CqR71WLNHH3m9onmxf
	iH9ou4I2MWvvtFXLPcQ4KbULx4uJcIe6G4l5fA5l8ewWvzNRdwlJFboL8HKuPjvVaVMsjiviAVo
	Sx3nE6rwO9ojHayxQNtGTp1vQ81c5+DPftU=
X-Received: by 2002:a05:622a:4d47:b0:55c:3b4b:45 with SMTP id d75a77b69052e-55d769eabe6mr118557121cf.24.1795278450050;
        Sat, 21 Nov 2026 08:27:30 -0800 (PST)
Received: from [127.0.0.1] ([48.211.212.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm52250641cf.17.2026.11.21.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 08:27:29 -0800 (PST)
Message-Id: <pull.2498.git.git.1795278449118.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 16:27:29 +0000
Subject: [PATCH] git-gui: fix typo in comment
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

Fix a typo in the comment in line 112 of git-gui/git-gui.sh. Change
it from occurence to occurance.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    git-gui: fix typo in comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2498%2FOphirBleicher%2Fgit-gui-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2498/OphirBleicher/git-gui-typo-v1
Pull-Request: https://github.com/git/git/pull/2498

 git-gui/git-gui.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 15dd2b3a84..1deaa5edd3 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -109,7 +109,7 @@ foreach p [split $env(PATH) $_path_sep] {
 	if {[file pathtype $p] ne {absolute}} {
 		continue
 	}
-	# Keep only the first occurence of any duplicates.
+	# Keep only the first occurance of any duplicates.
 	set norm_p [file normalize $p]
 	dict set _path_seen $norm_p 1
 }

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
