Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4012C15B4
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370675; cv=none; b=OV2o4QD3GMCvx1ewM+ksTnbpmP71SCw9xLpXUlZcGtOJ9eFc5chQWkh2nBjW7T6BkGqmyxBCdKuGxqPwGqzh+YaWL5vFgdXgwx1suiTF3FYaRjhFxMT78fCiRi4RAVNKspTcaErxGNZuhCOjYAMPeP+hDxDXRcOGME+K3ewclZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370675; c=relaxed/simple;
	bh=YF07ItxR4qZwPKdyhiZTEqscKWANWc4/SmNqzqft52w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdXr3u7DnsX2ijwUi1ltkv3bl52vSyzRANTisyUMYQ2DOtdTggJoQQK9IOZUlSXDTJpr10hweYkfX/+aix+FbCfMscTCgok2mNwvSDouZRkx0l4GmzpsUtqIQe+uC3iWvLeKb1Qg9niklei9ERoiej08Q9XkRONjEGykG/hirbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khOkDVxz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khOkDVxz"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so1139176b3a.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753370673; x=1753975473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHfHFUUJ63c+FUHgBtLdx7ZI4pgIu9wR2+Xm0pRW6Wg=;
        b=khOkDVxzgnmluYeNozHpMx4KBvvAmxq1C7XdkXqAa7CHnSTGB9s0J1EwuqiiW2yOPX
         +6gl5ZFgWab7A6EcvSDUtYe5Y91rY4N3l2myScSdxVcVmAbHPD9tVysd/L2anzj1Cha9
         Wf5WiSv1doRP79Z4HExspJQLXxT72C8x0ugcVrh59vwjGHM5a1NyI5LV2W+VI2fZ+irt
         dIPiz/KBzFzeHk+DoPw7Sb1jx5SAtDeeINQ1cq8WDPXjgetimMelEWB+WV3FR0okHkTa
         PWDdC47SvXt0lG9rKTjiiEvUvgb245mBgma5BK6yhVxUliPTdgoer6v2wybqnxL8XGOG
         OZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753370673; x=1753975473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHfHFUUJ63c+FUHgBtLdx7ZI4pgIu9wR2+Xm0pRW6Wg=;
        b=v9SLd3jI15g36tV/afFfr9O/seNBpazy5GxevAk39CJq0kK5Az0ACq9Tomd8NM0UL5
         XAsNXh3wYj2RahJL2h0i/pejHN7dFtofKmm+b6qs4ObNv6qv3HkyNnFuuzNizie1Bgqg
         s3YPt/Hk0KXJ7kiW2Z7Eu21iFZcndKZtTyusykDma6V6ZczLE6Ka/ZEYfsSKLtYfJ77n
         +ZfvTx4k0IU4bbIDNFXdd3Za/9OAEkYWl2Ke2nLE4cqrjEq9ENv4cw2pIRaS0ujOMIxF
         SJs5VjAR3CJZ8SL81wkkPkfjHWAFeZr35wCEYG9xKk9jWCiRsqWAQnK0FKozTFQRHTr2
         HcGg==
X-Gm-Message-State: AOJu0Yy6DHgoP17J5/89eaf0bqPQrPTPNFcUa8+gB09GyiWM0mNaUStG
	C1sEZlKMtwnE+K9LPlr6Gf9p9d7bTd2m5tm8P3TGxpxcrfgR8ZTVd1Ol0r6mDg==
X-Gm-Gg: ASbGnctNCAe1H8vFBCagrSSZXyjV1mn0rY/LZLih0rsbVWYb3hSX7Kwr4ryEpaYBJDL
	j1Fs1OCOtTY0+iFeguRLSPHi2DbUUCJTd/qQWmbgzvSJIUgMQCGWGrrEijFJ9VjgrcNMRxS+Myp
	9Ahl5UFBr91H1OfHnmfu+Obn3U8W4Av86UMaw+CEnwbFax2yCTruMFIXMSk5fYzQ2Fdce3EFkpI
	TOcT5uGv7xSh8C31CP9ys3LqIOntYDyyPCmYvDvH0fRHLLdSdQU35OccZPHy0FE6Zd41FM7P9/A
	S+RMyQXmPNQV30/sjyF/eSkfg6nMJrxkYbOEcaHXWMiAbWLS/HzpV6O4xoAmZqIhE/y5qlb0S33
	0351sjH+P04R1m9iJ3g0xAthnS25zyGyGKPw=
X-Google-Smtp-Source: AGHT+IEZGO8GxyQmnZ15W7+ZwDpch+lpdw9GZAJCvIPr3oC0wfPKYxcjkBxTuCzzqnH/Qnqw6kf0BQ==
X-Received: by 2002:a05:6a00:179f:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-761eee342eemr3979318b3a.4.1753370672629;
        Thu, 24 Jul 2025 08:24:32 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae63df65sm1917849b3a.63.2025.07.24.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 08:24:32 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH 0/2] Avoid submodule overwritten and skip redundant active entries
Date: Thu, 24 Jul 2025 20:54:16 +0530
Message-ID: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.50.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes:

1. Readded the comment so the patch now shows no added lines at the comments it's 
just the previous one (As clean as I could do it).            
/*
 * If the submodule being added isn't already covered by the
 * current configured pathspec, set the submodule's active flag
*/

2. Instead of ! git config I now use test_must_fail

3. For --force used the same logic the incremental logic.

4. I also updated the docs for --force.

5. Removed the white spaces from the lines.

K Jayatheerth (2):
  submodule: prevent overwriting .gitmodules on path reuse
  submodule: skip redundant active entries when pattern covers path

 Documentation/git-submodule.adoc |  7 +++++
 builtin/submodule--helper.c      | 52 ++++++++++++++++++++++++++++----
 t/t7400-submodule-basic.sh       | 22 ++++++++++++++
 t/t7413-submodule-is-active.sh   | 15 +++++++++
 4 files changed, 90 insertions(+), 6 deletions(-)

-- 
2.50.GIT

