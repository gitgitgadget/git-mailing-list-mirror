Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636881;
	b=S2hf4IJIuSOec84BprGm1sScj4xXE3lcQl0gAfh6gexF6uTmi1AYtD1SaWvnoswY58S4
	 R1PlJ7pllEL6s4y2vBBZUZRnihmq0S1vw8+mO1VFJH3/fJ34gUxHuPgBPIF6sW7ncARx8
	 SG56fYHTjPKh2jtf+aK4kf6svWy5J9KGvBDI90xQ+b643VQqFMfkmX5yQVx1/7bg5LGgQ
	 TMBbklkt9fWktgBHRmJPqqJjqkI6mIAQ03MQzNWQTPv/SI9JZJu8ckNWbdYWX/w9gtxVc
	 AbKO/FI8DoqH3Aq0NSrPkjWFcdKFbF/XGXHLEL2EBT5uOcN8IvPALJKSrr3EkebUNcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=mIHxsxcuJ+8iMqu1GkRYB0162/LVSjQDIXZ4tYuaDnI=;
	b=MTAG3Gk1tIdJ6W4yl83cmQvgC06fv9t9oSxyDmtsY/9dpLXh+C3w+r9R1W6aYGPeai+J
	 oex4yxJ2FnifLwiRGOL0qPGbTP/4Mp/EtLJfPnj1pea67kVsB7CMsqR9j+behU+a0DZTn
	 n5+kzTJZVkVHR2MgDhh/nQSDibnvVDx86NaasUTcSFg+nTrr3fYYnB3k3nbCDyZYT7yPt
	 1Fmx1ecOiaI13Z9L3N6ElZXLtwjoSUwVm294lpkbduLalCrACHk1KfNqARixTfgnLSEFY
	 Fcwn2sxesduWBUUXKI239TgvIApToKlM9b8kBlgVoxF8CtnzNSwaYk7ZCBcXoZ2pAfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EmxJ+6Bo;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB3606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6EB3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EmxJ+6Bo
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so4213954a91.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795636880; x=1796241680; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mIHxsxcuJ+8iMqu1GkRYB0162/LVSjQDIXZ4tYuaDnI=;
        b=EmxJ+6Bol655jx94M09Vmgwyq0iOr4nl/BcNTIsoH08iOvtJ363zlSFh/X6De5/bBh
         GJcsIoELwg8IL9HrjxjTl65IURbmiryhTa2kNANvT0ort//STnfv8MjqJ5ryV/fYcg/5
         zHWmt0NZ98alOmrhSpTaybjvKOzqTWomHlr4JZTc0qhr9Hpo2w9E3gRwLQwHdyytQ9xp
         vST24aiHl/3MeF2PJ5z+rBDjveVP4raj/LDD05dwSAySq6WWxGa5ayO5rO+XN485oEA5
         sdsIX6z5cNgvkCG9m3JUr54mCWSAP2yRTWw5FOve9kisSdHL8KIrMcoS6ZyPMB3LAFda
         6h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636880; x=1796241680;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mIHxsxcuJ+8iMqu1GkRYB0162/LVSjQDIXZ4tYuaDnI=;
        b=XTLLGBQ9IMGgZCiZ2OsVdo+m9OtupQUO8SaoYSQJ9bONR1EiFW1UdzJDil6x1HWb8Z
         EIVMyG6MgCDN+s644i/FwULtPIEfMCNi4AlIPSgkhUbEqv1d8b5ROeYR3dbdlKh3ufcZ
         b1XoMj9fOlVcoN0qG94H6nzzbxMzUVzTe/iamm8l2sYTHPxIceSYo8I6R1qNnUsfnWaZ
         n3DlAasOUUYj6kO6Qx6mogq+IECz5sO+ASt10RGgqxkNpY1+X+88Qh8dshZGJLsM7i2x
         4HIcPGhiTQhU4Pkwiohdqyyk4lXQjtWPjaLuLqbwJQFkuZUv1NX/sSP9ln1LX29T2JgZ
         cf1Q==
X-Gm-Message-State: APuU4Z80jsmcUpA/6cKh5BJkvUxm/Py+Ywc/LVX6j5LONN6TAq2COJl/
	HDMjoW4uuu+iI7bYBp7HbQw0EojWp0tqTgIoow1FcmPbuR9aE2273tIwqWSAtg==
X-Gm-Gg: AZFdTZdfoo3pNPC/A0n9A7sdG66fmKeeKsIFPMa1P52jc3HsPdaqidFI00a6LikUjdU
	ekjj9+h+MVkPNhjuEeuYFE+sHjMa6J9W8wukHCd2eK8WQkKTK5m8VsOXPhD/jP7bIkpMOwJQpS6
	nvH5NXzUizCfEabiQ+vSNcSz0wB/g9cLkbreHWCpse8IFL/HwdK2BSiiu/ZoLlreFNibYAmx4+i
	Uz4X3Th5+e9SB//myURwfJICA+yhbDRxGvDF/z2l2mRZVg9SCSvQuaYOu16WPSLRPNgtsBuf2Mn
	3EvXO7i8B2sDaZ9NH5ccX6Qn/x80XckaQoG4bGy3WtsDMOQRC4Itq0Gz8fDoFSEoQmvcXJhoUyM
	qv5wSZ6HoekeZBSgM9tO7/8WlOLsGTRW5Fbjx8BGjuCl0MubXjxxk+G3LrbpW/ZWvXdgMc8l9br
	CG4LrhEGsAjLSCJEo474HOdUu92AfcnoabdbBenAUP1xzvPnGucNRHvs5L7EDj8ip3NWWRPYpd9
	WEYzB0JNS0K4TEgKByayG7Pfpj+74Hp6hGoIUoK78d5H9EV9Negev2FlZjKAajgJ4S4Td/6Gjjt
	9l2yrKgPeLP9g6ETciM46UKBNnWKUvs=
X-Received: by 2002:a17:90b:1c08:b0:3b0:9deb:d990 with SMTP id 98e67ed59e1d1-3b41cafd549mr17650837a91.39.1795636879974;
        Wed, 25 Nov 2026 12:01:19 -0800 (PST)
Received: from [127.0.0.1] ([20.168.124.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm32297980a91.2.2026.11.25.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:01:19 -0800 (PST)
Message-Id: <pull.2334.git.1795636878793.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 20:01:18 +0000
Subject: [PATCH] doc: mention the tutorial in 'man git'
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Previously the tutorial was outdated, so we deleted it from git.adoc
in e2e5e9f740 (doc: use `man git` to teach users how to
navigate the docs, 2026-10-16).

Now that we have a new tutorial, bring it and 'gitdatamodel' back,
using the same language as before.

Don't bring back the other documents, which are outdated.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: mention the tutorial in man git
    
    ccing Kristoffer who I think is the most recent person to edit this.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2334%2Fjvns%2Fmention-tutorial-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2334/jvns/mention-tutorial-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2334

 Documentation/git.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 1aa0608bae..13be4cdcd6 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -22,6 +22,9 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
+See linkgit:gittutorial[7] to get started with Git. See linkgit:gitdatamodel[7]
+if you want to learn about the data model and important terminology.
+
 There are two ways to get help with any Git subcommand (replace "push"
 with the command you want help with):
 

base-commit: 77904e546de3bd940621092ecec47a88d0cede5d
-- 
gitgitgadget
