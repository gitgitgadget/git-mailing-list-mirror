Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2241B413D
	for <git@vger.kernel.org>; Sat, 24 May 2025 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748072197; cv=none; b=KrLqK0oMLV6KX3QZG+jIQUCdkNY1z/7P4+tyhzZIIZcGFHX1GPe4tuTrGK7gNo6ttLxRo4OsxsDp4+vcBmWg02Wgf2AjsJreuybpdLz3dLRlLw9u5WqcZ5tCI6CWCO4gtqx6zNMQuL3MbkkOr1urxUAEmdlTBx6Cgm4nDuU9GJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748072197; c=relaxed/simple;
	bh=EU5nX4fol8HBvCisIurgyjyfDr7CjPCa/UhiigkV5js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S2LfJZNDJdfXQz5k1oqe3LPjCML3z9GX7WHS3j4fAVUJv7MBxr4TPfDXrZt2vtTiHWLGqYPX9sLodkjUSP7lpBnUHfs2Otqrp07sJgCWZc8JbiOjlToHrJvrvbljnrLPUvHUgIcaU9Cet4UAI/gkzlzZWbfepZ7aX7PwCLcsj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQGw6UXK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQGw6UXK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2322bace4ceso4670125ad.2
        for <git@vger.kernel.org>; Sat, 24 May 2025 00:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748072194; x=1748676994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrfrzKtD5gsKlXUi70ClvCHH2SoG/JFeZRe6F0BaAmw=;
        b=IQGw6UXK2HRpW4592qwHSeMu3xOjFeenzNuzILOmsqE55sI39QUD52fzLNrxLe/x3r
         eLYz1i16pnvyGc+evI+2OMuqYdlWxV3G/2Hxb8gUphS0r7Pp4M1+bAshECu4Zh2Rh2Il
         pcvKp4OSyY2xYvvjLD3/khc8UGmBswGiuWvbfNgSUT26kPgx1nbsSpsvitebNyNbMY8v
         f19ylkMmVzS+pItcGExm0Na8IV3ZuDLPbB5VdgLpYJbTLNdh1Os1/WGtfgqDyNbMdi3e
         NLW00uK2F4EWLDcJeZx328TIHiAIgU9c3dG82FC11PI6kdM4iaHcMIYjQ+IbUyLs229s
         VAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748072194; x=1748676994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrfrzKtD5gsKlXUi70ClvCHH2SoG/JFeZRe6F0BaAmw=;
        b=CA2IOFYQoMBl+qzl8aysJqURc06UEdKn+zCthUZZhXmgiiCUXNFEAfudkrLaQ8c9Rj
         7dSWyVsXqvhwX6gPH0aAA9/XbJWhiziI9Ja3NcROv45+qmkzjAzh7kgoccZtPePisXrg
         CZkg6OPf8akU0bN7mBt3vLP3YVymK9TcYP8nHVxEEi+XCz7otNowbYiRhGdRFbWgtXQe
         SIkAFZ7xq2J5XRZ+wTEKEIhuxPeAuRJ/CvmT5BCShUzWajkHT0P4f1wXQnnlpq2tDj5O
         x4vtKM3BS3EtwGmhAHYTJX4yzNe+/zk+Sfl+uiI8HLHIzWps3u+PHInwEiABke5FNJ5b
         rlsA==
X-Gm-Message-State: AOJu0YzZF9Gsn/cK2Ayj2VnnBbEhF9CzzPRQpa8uXhMmb/ZaSrrmNvE2
	yuafmd6zG4N+vQ6Cv6+XMtIKAubZoCST3qSXX12nMBdBvGDN66NmP8pLf5Gs9NJp
X-Gm-Gg: ASbGncvwOyVLPr4W+DuuXVTpP1hBQjbvv21UB4stnyvR//Pw0O5wKuzMvFozrokmmti
	3AGDH9qHdDkNqwosvI5iFdmrHiATFOGo9AhfVSrv4+xQTK+MsI8SV0Acr32oaSLoMMySiu7NE8b
	nxcvNaHBUsgCBvyR7GTwDah8lmu9r6qBWEIoW+uyPgU8IOp9Z1N2FzoAty1BiriADGhYVtuwdD5
	0xiplNlVyaQnHKMydsEle3yhoWPug4Qr+sIQt5SlcYAMIvcanu1BF9eVUVsRRiHcVaNIyrB39hk
	duqGI82ivD2oK5QdYvDQT728AfyVEraT4d9Gyhf4D6xKh9xeuXoKQDmc58n25kMRJ88=
X-Google-Smtp-Source: AGHT+IGRH0WYkORIjxmhDH+4ijQrE13+yAyRHgvB+oQ5d83B+KSaMclcC2BvtkjWviZwZUk9t3Rvkg==
X-Received: by 2002:a17:903:46ce:b0:22e:72fe:5f9c with SMTP id d9443c01a7336-23414fc85f8mr31830335ad.42.1748072194550;
        Sat, 24 May 2025 00:36:34 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231e2118b07sm131949475ad.43.2025.05.24.00.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 00:36:34 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH v7 0/2] Avoid submodule overwritten and skip redundant active entries
Date: Sat, 24 May 2025 13:06:26 +0530
Message-ID: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series of patch covers mainly two areas

1. The bug report where after submodule was moved and the path remained same
   when a new submodule was added then it directly was overwriting the 
   moved submodule as the present submodule since the path matched.

2. The configure_added_submodule was writing submodule.<name>.active
   entry, even when the new path is already matched by submodule.active
   patterns.

Below is a helper function and 2 new tests with fixes of the above problem.


K Jayatheerth (2):
  submodule: prevent overwriting .gitmodules entry on path reuse
  submodule: skip redundant active entries when pattern covers path

 builtin/submodule--helper.c    | 60 +++++++++++++++++++++++++++-------
 t/t7400-submodule-basic.sh     | 23 +++++++++++++
 t/t7413-submodule-is-active.sh | 15 +++++++++
 3 files changed, 87 insertions(+), 11 deletions(-)

-- 
2.49.GIT

