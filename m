Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008469;
	b=Iw+5H5dq80hDcOtsHrCH6Xvtb0oDwSZTVCK9o8xiao2SW0/3gUQB0L3rTJSyJg1YQl93
	 DtN3Iw4Qa7G0Iu903ZBBT5/IW9ERETDTZwHL0LSIxylhdtfTihbS5Vu5MmDPPrAfwFQF2
	 2gk+ACFs2wjCgxeVsoR+SSOny0PtXiNr6gD8TANv6w+T3G/zLdeD5zAmVvifEPUSspBE4
	 FjD2ZjVWChNOlYuGhXmnU2pTpuGCCBRj7iQfbC7tpQkqFlcb8G4/b6nQL8iE4czeJPRPI
	 fYA/OYkm8xF2bidetgvpMB0MnszIxJxbMa57M31jETETdeaaJh88O5/tzJqdjRE76xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=RtmzIoz80j0Rt3VFWxOwNWoDMMjLGba8hCAyAzu0lJc=;
	b=H0D8Ff3dLQ692MFNm+dk2xJ8ZBQpEbKOhpcgHUqtDdOY4MPEU7giCQsgaRBWT8aQFMXQ
	 P50J8PXIPjOI7zTb2QCDy4fJlspSHOXTkVDeV3ck6iIU0m1/QOhganxP41JoyL8Ie5D8u
	 air6h6+/G7wxmJ0aIzgdN+jo8r8ZxBBvvv7+/+N0e2e2e7u0W/oW5LaYQBbWWvTlFhOA2
	 3XsKDWhrrPhVPaTXmz5/vpW/sKaQbprsm3mi8dLVy26kosYzAE5QVqJH60cHK2iJvorso
	 kUf2NpwpQmtpvXtaJ7gq4P5TlDqjrnK0B+gkJLm7rfLfPtotFjxE2mXED8p5eS+0WEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DBQKY8Nt;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617B60A2602
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B617B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DBQKY8Nt
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so4787769c88.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008468; x=1793613268; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RtmzIoz80j0Rt3VFWxOwNWoDMMjLGba8hCAyAzu0lJc=;
        b=DBQKY8NtHZyzMud+/RwkIVOn+9j1RWI0sGX02d3D6DBkeEXtBMDK4RG0I4+PBeADeJ
         4XUY1k7UuMODPoDPzWePEk8OGKRBF/zeCGDxtEuvYaF15TYuUk8/vicQ0w9mGMVmJbzp
         ML0m/udEdQiU7Raa3S/KPbrSZNUVU8hBLu7a6teAUJLmK768L7YFIqkzjUoyJ7K2PDy/
         XWJWkx2bzhmugtBbrEWa0NUk6CmwoboxqNNs1bFYYsaf3S00vZNmbqZUzKSu+RGhp5b1
         6zOMXlGrqS7EDKnJwjdIM/hp6UNuH9tyQz+pugBZLsGt9E0yoytaIlAcX4XQDQN5K6uV
         jPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008468; x=1793613268;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtmzIoz80j0Rt3VFWxOwNWoDMMjLGba8hCAyAzu0lJc=;
        b=uXi0bIp3IgRE2jfoU9QIp4ko45adk1dF1cy25LMA2y98HpYxcjgGXx/3JH1UrfN2zN
         LvQf4c8KDUd66PpPhfRNsc/XvGgcKCU7j3r0iqqLQ8FecV7Xmr3Yri+aDRxbHfjklDhd
         U0YmdLz0DYF3Ci0Pf1A3uKSIR0pvK89Uk4RwoOQ5sLataFIWjIaifr8fdSuKTq8VFPm/
         lo5q9aCkOWK6uteGyiHxwOOoClZyGeO8XmxHh9x+tF6rklg6CsRmuOFq1Xv1/2wC1WAX
         qpl3XNkzPEpeb4mIAqVmQjr5lDijcL+S75jcXj9NGHqgKhkRxkSKMNex+cdbXQkfbW+3
         hfBA==
X-Gm-Message-State: AFq9FYLyFFSk2aHYJMyEbYU4UA38hyPZDnwePnnzthAZMkepb5ebAfFS
	feHOjMOlHO2SkljnzNHfGdXSSN+ig+78JpXqkIz7OsO3wpiXOQKPRQ4cr7Fz+WAdeQ4=
X-Gm-Gg: AYBFou1F18PyKzWwGMeQW5lsZoSCoduYWjf2RwkeQzwQWts86OZbh52yLFEIdQn45oV
	NAk1RLvvsawZBoKweBKm7K7BGuRFMJNuO+7YdZbW72nRQ1oZrJip527VzssGzCKW9+oTD95L75m
	irNLJG3/oJv/f8zdtvJB/6tzYjplYTUismuIjTtzJ8sugNNeN6Xu3cmo5X4mJYQSpW69fHZd+Zv
	4giairORG8fT3lZ/lSvu3zkP5RpjJqH9vGlKANKiMCQ1D8Qbcv/qTbIfqQUv4khiiVLqE41l/5F
	mZ7NF5oAORnQ5dM/MwOpxDM45XNrLMRH1vOBbfFTx1XMHzc3o9J9ALiVJrbKtXChKd9z8yFVMMh
	ncwfj/ad96ZIbXrYpib6WJjstmvhvoCAzdVzwWOniuAXxENDr+8lp8U9/FzXmSDM8x6gQ2Tl8Tz
	xiXi3DihTlPqR08NrHATYzuisXzC+ne6I+hF0hY7hAtNE9kH3M8PM7hZI39xhfqJX9TpEjyl8Vb
	xWsJ52Ov+j4fBzDPqTwy22jKXDz5cIRZcudRzlVdaKRzLiMjacQ7UUK
X-Received: by 2002:a05:701b:420d:10b0:169:bef5:f445 with SMTP id a92af1059eb24-19928f14c3emr10157490c88.4.1793008467864;
        Mon, 26 Oct 2026 02:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.98.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm23379926c88.15.2026.10.26.02.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:54:27 -0700 (PDT)
Message-Id: <e85ce85d921f5c847c4a370a5c56c98f2f20cee2.1793008465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
	<pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 09:54:24 +0000
Subject: [PATCH v3 1/2] ci: drop quarantine removal for macos perforce
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

A file downloaded with wget never gets com.apple.quarantine set,
only Safari, Finder, and AirDrop apply that attribute through the
LaunchServices quarantine API.

5ed9fc3fc8 (ci: prevent `perforce` from being quarantined,
2020-02-27) added this to stop p4d -V from hanging on a GUI
confirmation dialog that never comes on a CI box, back when perforce
was installed via Homebrew's --no-quarantine cask flag. When
49af448197 (ci: reintroduce prevention from perforce being
quarantined in macOS, 2022-05-12) replaced that with a plain wget and
tar download, it kept an xattr -d call as a precaution while noting
that call already does nothing on GitHub Actions. It has been a
silent no-op ever since.

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

