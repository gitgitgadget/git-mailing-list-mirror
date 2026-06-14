Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524B20DD51
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781458116; cv=none; b=lVh6ORp0kCA/jxy0RMthSaQpkqJkrb6QsRMp8xUXaeGHKEMt/d/gwdlOMdAAnbpiiyoF6ctPKfFp3iNXYqJpFZLcZqiHjFoaJsmX9HPL582vaTgqJufNFisK/qS6PSLr31QNGe9o1MyxRwGHiILLyA7V0XbEb39AHoiPB8Eo7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781458116; c=relaxed/simple;
	bh=8REVVbJ/32MiL7GuuL3S2dyPfb3npDK2F8ligPjDDUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KupjWR3GZ0ui9raP3xDUrSFtX+ALjYt76MPaJOOSeLs2sSHDh8wsOFEhKTi4xxVbIixl2g8uqXOxIx4OD/V05uf9XhMDnFdUiD+JfOWFSWgHRHKfOfP596W5PZL2PvbTKSBQXx9jtoGtyOnzBynzSR/cXRh6cCIziRQ51I+cwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE0KZxkg; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE0KZxkg"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7fb5059e9a0so1472617b3.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781458114; x=1782062914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2wMogoU6uwsP7b33bZirFj5iojsVXhqDlcCAPPE78p0=;
        b=ZE0KZxkg/QvdAaJNhbIQ5NBaIwtDpkdmIj0fGR0XMNov91tXz4UHY9JyvdiOenUkj3
         csiCoWCiab78TS9boFR6sq9TQnf5geIyENhFJhPAJMa0HAeFi5R1elZpCBS3/vNvuFun
         bP3pJ+nWQXqX/ubeajxO77vUEFh0IZkIju1QLfv3dyxhkJa5X/dvKu8XDEbIo2Ovd9ox
         /qMV/vecRBOvuEjClwPCMb80pWowcyRiWoPMBAUFH53pCln3qjG4w/aiVRptUJJEBbFW
         rOLorJOCparq/j7hhQJ6DYycHRFi11sSZRCzFDQ8UALWBktr0vu2oqIOVdHBrEHX3xTI
         iUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781458114; x=1782062914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wMogoU6uwsP7b33bZirFj5iojsVXhqDlcCAPPE78p0=;
        b=G8IRaggjdTEN+me+s+p/kOLzaEJPmR5NtYohYFFPkXJRbCtJqiDS6P0bS32StbHMOa
         Z6tg+FqUVpdYP1oWgrSi4zeo4U7T95234dIsIOQxVexmyKcJgfrEz1Cn2JzqW/FP8D5I
         OTnhZuSAzPvpTErwDYiWRTjFN35NI4v2i/8Drh5kvCdqYD0VpVAaQkOnlacTcMLxxHBq
         a7RPlH+kaCsuyPl5Tx/JV+wRZHUw7ILP9PwiRQ6qGtZ97S2lQkrwpKpkAcn1MNTA3+DY
         JTJsCtNFS/g75LUfFbanT0kHFpagrZQJQ2a0+N1aEZFH2XozyeqfInp1knlBkiSvB3Hs
         7kyQ==
X-Gm-Message-State: AOJu0YwECnyhPq8Th1vTcGOG6SC5rNd4FILypEkueCcaGUDEBYnWF+rM
	krE5dKjze9sFqGzcqcSipKFY3eGVWeUQEqY8GJHtOO7WyUljQC/bFMoJ3SEYLEc5
X-Gm-Gg: Acq92OGtTE/AXSOCMzLeNPMrHDcFR4nOcdB3tfM2qPtIu2cbYAKlKDzGMROA3UgRiVw
	CCJJtkklELFmq1S1aPuJebcb69LQ0UBrzO7fWK4vDQCVf93PyGR56iLA2RtWvm2OWsh8fyUQ1v9
	ludSqCW5edUFmdw4TcHxdc09JGi4zC3/6ezanayWGFhs06OnyV2Q80KNaoZE2ULn/qVYhU3hjej
	CxxCcoU56Zq6cU2n3rZ2rRPggNXFXlgq55Uf+nYIW/zNxs7cUrlXauBbt9y037UpZH2L0KB4TBF
	yuhJxCVxoAun51+wqU6fwv27ETDwIbCukdZuNWfjh9pAjwtv8k7FvQ2zHN3oa6jBdwCgb4ekZQT
	XrAu6N4mnHaWdkRYDullcwaM1V6/LDjx72I21tLoU68bnCy20HATItfZpM1kKcGIhe2z+qWfJk/
	EpqjX0LLTHO10+eVdq/wwijWh7dQeDUNgv4oww3GGhtA0JbWzE/SazyYjuVvq6FlvxFO1KNi+XJ
	ORteN95qeFx4yjHsZngTMlCC93mlDTvBkAo2A61SFW5F09ccQ==
X-Received: by 2002:a05:690c:250a:b0:7d1:eb6c:99bc with SMTP id 00721157ae682-7f7b6142094mr106023687b3.11.1781458114357;
        Sun, 14 Jun 2026 10:28:34 -0700 (PDT)
Received: from macaroon.lan ([2605:a601:90fb:c300:c85b:222e:1a13:992f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f8583f3a49sm27650667b3.47.2026.06.14.10.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 10:28:33 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH] doc: fix a small, old release notes typo
Date: Sun, 14 Jun 2026 13:28:31 -0400
Message-ID: <645638cd87d6d919af6d4310be8176d49fba326e.1781456960.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
No harm done if you choose not to keep this, I think. Stumbled upon it when
trying to understand Elijah's message [1] about timestamp_t overflowing in 2106
(I though 32-bit time_t overflowed in 2038, but timestamp_t is something
different… except maybe when it's not? Anyway…)

[1]: <pull.2148.git.1781420271100.gitgitgadget@gmail.com>

 Documentation/RelNotes/2.14.0.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.14.0.adoc b/Documentation/RelNotes/2.14.0.adoc
index 2711a2529d..182fbe6179 100644
--- a/Documentation/RelNotes/2.14.0.adoc
+++ b/Documentation/RelNotes/2.14.0.adoc
@@ -142,7 +142,7 @@ Performance, Internal Implementation, Development Support etc.
    historical use of ulong for timestamp would mean they cannot
    represent some timestamp that the platform allows.  Invent a
    separate and dedicated timestamp_t (so that we can distinguish
-   timestamps and a vanilla ulongs, which along is already a good
+   timestamps and a vanilla ulongs, which alone is already a good
    move), and then declare uintmax_t is the type to be used as the
    timestamp_t.
 

base-commit: 0c8ab3ebcc76981376809c8fe632d0fe18e93347
-- 
2.54.0.1136.gdb2ca164c4.dirty

