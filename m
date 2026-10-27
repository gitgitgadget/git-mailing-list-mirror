Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089943;
	b=ytFbfBBMZSgx1l59/CuNB5VefatLTfpHqzEOHisFFL74jFcx2Xu0UFS4FgHr2M07b0+i
	 wFp2Oia974Hugv9NieT+c9wMSzcUML4GSvKxI4QH6KWknxr2d4Mfj/888hNG9cSJ2YBPG
	 x0GTAfUlT/ybLpiVJd26o6kBW/uPcB2GTMIJptDXuHpSZ4iBYTVbNVHwQdNgR4ca55Fec
	 C+eLjXYuZCt3T31Ubnp0nMXbcdDBi36Lm6/BP18yS1jxIZFRsWwFTuPtJSTqa8Chf2OBz
	 lXkA+m2wbt1nOvNm85n5KKFTGNTuFVwudC+wUN3ycVNYc7ibYC7qnpxTFBAtmmBFB6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=9BRahpIOhyZFWIXHDoXt6fpXAp5W2/B1Jp2UCw5UonY=;
	b=fcueQ2ZUwJnJdYL7TNym2/pVBm5/JXsoglWk8uFSiCyKSGFzPk+xYk4S0YaQ1pnTx4Gb
	 IJh5w23Gk6WNFtEI+Y3NkSqYV4Bj2siqfivTJEFghO2P2BbS5uWDv6bRErQ+BJ1EkFbJA
	 IWZWPkybPDZ/q9Gyk5v6Inr9USYERDA7L3e4sUzeSTlyJLDQYJIKbxO90rJzIGGj8JsDe
	 tcYI9JJqByJ4dZ9avLOCScYzvA7C1HHfPEAw1lt8yG8rR0nY4WktlNEPv/ACfOGJ+WdS3
	 00CisSeURIudQu1Dr6bnTG7CT5Nnh/JdF1dXXldM695KxtjT71dYzmBaNTClrvyilcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HgzBiKQt;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B90606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B90606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HgzBiKQt
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8470d7d430fso1516008a34.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089942; x=1793694742; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9BRahpIOhyZFWIXHDoXt6fpXAp5W2/B1Jp2UCw5UonY=;
        b=HgzBiKQth8THo1r174X9m8osDlW6u/dhz9Wl6u+yCT7l08PmYerg8sKD3L8uAtr3Mw
         74/+HA/Hl+7jo9dO9jY96SIvw1CrFwwMZMI/Olw5ugnEYc6q4Y6wLUXl0tAfDmG1nrsp
         ECals6cMcPAAtrfe64uaekWNPmhbOjlqwUfaYhMEfgXvrJHFLl3Cdny2XM2v1JVEsk4G
         jf00Y4EwZbNvFGPPFHnGYYCig6Q6xfoh9NixJFtXONvsByClrMAg1QdAA3ngMwG3rpzv
         rPNUBKF+JhTddOusOo1t8LVOL6QPEQzVEdmLOlTxOnqwjudqgj6+ylhGVCfqNGGnUHlf
         6E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089942; x=1793694742;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BRahpIOhyZFWIXHDoXt6fpXAp5W2/B1Jp2UCw5UonY=;
        b=SWHWOsZLl+WcZeEZrLTvUf7BGUwfx9WRJGcJ/Mu2ThVxsSpMF732Xo3Aia3UyKt/Yc
         6I581/U6wJp2TkDzKBfaDFGi54ve0xMNZkuRHE3ak7M8a8T2txeQLa9ZRcv4DSUHi7UI
         UYfNWKYULN6pmzAzHjcLC1Ec4ko2p6g8FNfYJO+RbU0Nd/DO+XMHQfjix8TxuuFTnx98
         VGtf2AMiuZkWI5C1SFFB63P9xbWs5HH4boDOKeG8L+pBQzzDHy+XOMl8EOKMNCJpF43m
         SDSawl+me6X1Zemm5CGarIFEROxIzHj/XAW7kgqCaQU/W63hSmKkciMYtSA0quYZ3OhU
         nEOQ==
X-Gm-Message-State: AFq9FYJ+Nd1C4ogDRo3ALW4S28db/x1/xSpsloPDwcgKIoQ5NXvEYuwO
	bPPZwgprzb6KQF5HcZaKrzEtudpjZsJCm1BMGj4TceIUhJgSMvvuq1IhnBPzWi64
X-Gm-Gg: AYBFou1titdIBByj5jIvxX1gVj/aNiLEifsSiWwTQQwUztsZKgSJiugVyq3OlRxdxRb
	XkWAWeCIMTyb+kxoUDJiRWvbbErIFYjxC9G8PPtW73FUj85x9FThpiMDekRVVHoe5EcS5hn8MOk
	CmSqG+3jcNC3YmE+dbGLeP1Zp4cjolIZVpin9JHdS1nUujUwmm+z0Y/rhrigZno3DGGYslFIkgc
	pss7bRAd/lmiVgs3PU2ifz8S4Z2iDHhTdQ/0l7M88Us6zjjU5kXfBcoj8mbhc4Y259oCPcUFR8L
	oVqca258sXxGkN08EwkKhYmqfp83c1Dly3ZdoVsBUkWKSeJlHKj7S/552+Vy+1slxT0qxXl+joE
	SGBCCUfTxD8JnWQigPDxwmI6FACSgswm/mRUJmuGOzKGpRPDORDtRK8Z8vHh7tZootnRQZEnaG9
	KhUy8S2DHi40eHe0qP6mdyGm8XbFpzd98EtnfKOSpV+BHPaQpvZgQfZra2M3nfJ3LMBNAv1q4w8
	DeBYgSlumCTJgz+xhSRDzPKjArhjsVd12T17u/p6RA4gllLpPaonXJXykg=
X-Received: by 2002:a05:6830:34a6:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-850fd56d125mr7964387a34.12.1793089941782;
        Tue, 27 Oct 2026 01:32:21 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fa99bd35sm10083078a34.8.2026.10.27.01.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:32:20 -0700 (PDT)
Message-Id: <c1ee3fcb7dbba1e1ae599d30a2144fcd498d8932.1793089936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2403.v4.git.git.1793089936.gitgitgadget@gmail.com>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
	<pull.2403.v4.git.git.1793089936.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:32:15 +0000
Subject: [PATCH v4 1/2] ci: drop quarantine removal for macos perforce
 binaries
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The xattr -d call that strips com.apple.quarantine from the macOS
perforce binaries has been doing nothing for years, and can simply
go.

5ed9fc3fc8 (ci: prevent `perforce` from being quarantined,
2020-02-27) added that call to stop p4d -V from hanging on a GUI
confirmation dialog that never comes on a CI box, back when perforce
was installed via Homebrew's --no-quarantine cask flag. When
49af448197 (ci: reintroduce prevention from perforce being
quarantined in macOS, 2022-05-12) replaced that with a plain wget
and tar download, it kept the xattr -d call as a precaution, while
noting that it already does nothing on GitHub Actions.

A file downloaded with wget never gets com.apple.quarantine set in
the first place, only Safari, Finder, and AirDrop apply that
attribute through the LaunchServices quarantine API. The same holds
on GitLab CI's macOS runners, so the call has been a silent no-op
everywhere since 2022.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 ci/install-dependencies.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d57dce5663..203e8401cf 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -122,7 +122,6 @@ macos-*)
 	mkdir -p "$CUSTOM_PATH"
 	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
 	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
-	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
 	rm helix-core-server.tgz
 
 	case "$jobname" in
-- 
gitgitgadget

