Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB637205D
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069341; cv=none; b=N5+4TDEmb7GOlgYyaBzVkQDUowXkju8fdpqLw8mR/uNa01e02a9M+B3sPcLlGVOcisnD2wCniqxdcos4KE1OVCnfkBTMCDDZJ4TsQjcTutkmdD189yPpDV0y8IeonZUMVuKJIuwk2Bx45Qr3TzxPqTPOQud8n7tjcnOrFLFjUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069341; c=relaxed/simple;
	bh=My6xMcWiSQRC21O7e03KbFzyG+Lek3st4bEshLposLE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fDXHMFsIcpTBvStnXxW3bwOGSny6/BSWsu6peT19Bdi9sllZHRZYdXYS+dwS27Pqg/q4swZsPtVKgYgZ9hDBgyi563OXc/lZ8yIfOSWhFFPJhwaFez8TAAMFnrX8NP0m0xNbCj0xG3icZ0FdsmHjRc6D0ILEnJ4vOBQFgE21Itk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD/64pkH; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD/64pkH"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4864ebb6268so2165090b6e.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069339; x=1784674139; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=czqKAQJUC/S5g5U+hEUPK7DNG0qtNEtNKLR4YJglJmY=;
        b=ZD/64pkH+wd2IC9PLLNEz4OcrrVzR6cFO4Zpcy1tw7REIHbcc2J3EG84Ljx5N50kcI
         oL5w4FzJ07i2PlsxtUhvj+PSdDaveRzjJv7CgmJ1nWkrVvt3pyYVOndiMseQitrwS+wz
         pHN+h7iu5avULQcRWsi4n1vj3LfmGMmecAHq7P1iZAYMkKxlSzliQqIQCfpuOCb+Pj3g
         k8/sndSclzRkNn9ebVlFTG3tePaWg+5RQZK7Ckf3bTyf9gGoF1PiOEv8XkSNeXZkVLhV
         mnZ1yRSfOnoF4OVzYp48qS2rGbXGNAkA5eJDyUIMRa0oBBMIfwzoCbyituAsZoGxgtEY
         EvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069339; x=1784674139;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czqKAQJUC/S5g5U+hEUPK7DNG0qtNEtNKLR4YJglJmY=;
        b=q1vK7bN/j/Kt6GX4kLRfDqJ5o134UCs5y/5m9AnkumTFys9xYU5P0W+8fhi7wblOM0
         Da0UJk+96c1Me2cDKVX1zekOL60AmCBlTDUXsOMqLyTTx2+dtrvKDDLtoVRl8DOlg9qr
         LYLD48QyXBGdITaM3cMmmV+dFw7dhd2Evr/SLMZT9kB3umgVWfz/rL+HiPkIiwDsnEvl
         8z8wM2Gm4IQftEKNXSyc4HTd0h3VSwkIHkfxuyEIq3klA0wQmmlV1H+CAGFR9zBbSwoi
         52en0z/2ZcwlG4u084fr22AyIAJnrgCKSXAH5Q8+lwkDUOME6YTxocEQ8FdUAo2UL8HP
         BYaw==
X-Gm-Message-State: AOJu0YyTJ+wQNgI8BNUAET/exMIuIOQp3/AYB8o0yZE6mrKSIFECXYdO
	4lh8BoipbbTiIKOLVZKGhKR0R9pyvrLaJqUkHI4F4Ny3B5mssj+V0Lc2taIUhQ==
X-Gm-Gg: AfdE7clEOL1xHW7dvr46L99GyrgHcbz3rRvMRxt5P5Aq8mKLmBoiDXPXFXX+bKHBQpV
	31Csl2y94Pj/ThzD9OukERpyGFPCPt9ULdIbdWGKAkiDacSTMIMWm9SZrYy7MOt37BCGCnc6H65
	yPBfq436V4HiJ7Ng31MTnp6Ds1s6H3/DAbqsQZgKRvNN1OF6ndX9z1MHSMQmDnSsXvxQD6NSnkI
	+ncavRQEJN2EZcT5IiD4XzpDMDiPPsZ3LXYsuqrAYyy8aTbWzmhPleP7H+aE4vOLhy3AY+sdf6H
	Slm8TN3mIt5ib7rNDm6uZyZbpBCYF2pXNbMd5elkfhdSb8e19neajuFDmNc2vDZNWS9WR0KgF9/
	Ma5L+Qi8N5EhlUBVd1lRgbdF0A6viTS8CgAxA+qoiYpnAKCoV4rYo8rE83VDIPnLC3oSCpKDSWx
	w6HrJJreD8XqA2S6Ue
X-Received: by 2002:a05:6808:c14a:b0:486:8a11:6e8b with SMTP id 5614622812f47-4a47a40d3abmr2455766b6e.2.1784069338902;
        Tue, 14 Jul 2026 15:48:58 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451916f31d4sm18231424fac.16.2026.07.14.15.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:48:57 -0700 (PDT)
Message-Id: <b31e0326e7c4f97753c80077c8f0927504f40370.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:39 +0000
Subject: [PATCH 06/11] compat/pread: check initial lseek for errors
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

git_pread() saves the current file offset via lseek(fd, 0,
SEEK_CUR) and later restores it. If the initial lseek fails
(e.g., the fd is a pipe or otherwise non-seekable),
current_offset is -1. This negative value is later passed to
lseek(fd, -1, SEEK_SET) at line 16, which sets the file position
to an unintended location (or fails with EINVAL on some
platforms).

Check the initial lseek return value and return -1 immediately
if it fails, consistent with the error handling for the other
lseek calls in the same function.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/pread.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/pread.c b/compat/pread.c
index 484e6d4c71..ac7d058cb8 100644
--- a/compat/pread.c
+++ b/compat/pread.c
@@ -7,6 +7,8 @@ ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
         ssize_t rc;
 
         current_offset = lseek(fd, 0, SEEK_CUR);
+	if (current_offset < 0)
+		return -1;
 
         if (lseek(fd, offset, SEEK_SET) < 0)
                 return -1;
-- 
gitgitgadget

