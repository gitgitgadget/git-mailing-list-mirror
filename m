Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC791F936
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792356847; cv=none; b=Ha3cKHjvobX4vRc4BYlWOFZOhdOn6hSeJDJ6Ob0o4/mKNWHQ2SsxwsOnawoP1oRUXDWb09zCARwla0FqP4aeO63x97ehSdWvyR6JBDMgey/x7q0wo0oWcK2rt6xFJuylG3KnxpqoBB4mRiK9y3m2Q4rS46AsnvLlsuj+qr3z5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792356847; c=relaxed/simple;
	bh=1L5WD0yRYDpOphRrI+NMk0xV3rCSmpcybPXzHF14h4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tER4Yr9COkJWBtwtG8SfbFEHvSmMp5kRT96Uk5TDWUaLPTqz2sSveZ6daXBqieeUVCxo0HgZIoKCt9OfouYM+z7SdWUC9v5VUb/i4fUnfiQcSiGPrNKTF3Dl0oO1AIBrFOXauxb+NKxwnWymYDbhN2VRMq6lfffP0b8hD2g04nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgchhBlb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgchhBlb"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48de6a62a4cso1166782f8f.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792356845; x=1792961645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbP1YHnHGTUB7EW/lrkiKh9NTAr9/QOqfqhhsSwQh7w=;
        b=CgchhBlbtx4UimK4ABM3ozPexzMQP18foe5/iHCSvA6DdOzCmb1YzAQYtUDWfukwmD
         b13rVoMiBwAt88absOpOLW2G3ug5vUn2HvoP5MtFNQdirfJHoCGGPX6/3CmYvfnD7QSz
         BqjLLa7VLhL5LVK8aWMa+1v1uL0G+nhjlwXJ1bvGmI4GFu+yhP/OClAFYMNI8ANjij0q
         jH9PCIvmZAWdETl9T8Beljvvznqax565RsvF+BpsV0TxeHmLasXW1ODR961aL1try/Gi
         JL340SU9QyFp0+Z/fnwHE9s9V6kvZJN9/y5MguQwDtvD7IMs97Sti8rpYnw6IkGFoAEd
         y9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792356845; x=1792961645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbP1YHnHGTUB7EW/lrkiKh9NTAr9/QOqfqhhsSwQh7w=;
        b=ZA/msxBd22voQbLwX5aPT/L9BOunwqWrDTuy473jS4Q3+oV99ARqvCmvfyGAowrW7H
         hwNevFFdz4W3LuF3ukMNU/9C8ItUccpmPg5XbWfiSNNp1NhmV8XNgDbZyPnbomtL79qs
         j6+ffPzRMOe/i+tiUKsdU/R4mu05UVP3PRzgYeLpSLz2hVRfAATC/J4xm+oE6ES21SQA
         BSvJv1jrFJuB2dCWDmNlTbXOJmKHE+RcWRB5KN5ULUfxWBEbp0tj++zhR4bb/waYqnVd
         dkot05K8EIBzj2ADO1VqEqua0c+/lKY1eoClAcDix+mdfE5izcuKHQJC3EKCZikLuBsL
         LIrA==
X-Gm-Message-State: AFq9FYJjfbdCcrTylvvYPjOkI0Yb6NJHRQCK6O3+fC9QizgimIeuvehN
	2h5oyv17EDxeLDz15Vw+AB20h3XGmxtiLPDW+Ud4xHTH14BlZ4RO8lxsh3SRye8W
X-Gm-Gg: AYBFou2DMSjYNmLSy9y4r7Nt9BEPUNvkNQVaVyzaEAJVW7ABdIG765aw85qAfDLsh64
	gldJ62PLY1uIOp7WU1zM82fJVdTW0yCZkfap825Fpk4e56t2YzL/Z0FniAjC6fLKVgk9fj+QnTC
	SwmDBiXBS3MdtVSWa3+JSXWjbdc56mmWtBvZj8V9qW2G33GGaXW6gq/LmbwhhLOHhttTmNHZQ0f
	p9WJcZObJlayujjTqPH6ow6KzcV6V6X/UqEiSss8E9W8tULtUz3YkLcqYOPV1KFNdW0E89YWK2e
	ZVHZar2fmrm5DJDXgRYavRQdCg9N3re22p9SC+F/5wijE52jEcNo5qhMLFxSnmEkiPZXkqRHnDC
	Ckq+I4yioaYYZW0V+VeoVctgOUWteuCpTTUi0mR/dQCcWAGoAYqxul2jMThGn44YGDe/9m00bCs
	9iP1psG3y7UB/f+gJZ6sNca8m5GZWRMWMD2BJydgSGDcMhnucDCdk1FJmyT1CW0PokIve6Gev1y
	H3o2lypOqzE2h/PtnjoabtKUTIWVtWNAjH0SyV2rtYRUTDUvcb85mF2cbtAgN43P4roY56voQoW
	pXj50bvqm02DXBZEMbEfrcWjy0MPSlpD1KULdgLm7le2S5r1
X-Received: by 2002:adf:e6c7:0:b0:48d:f72a:338c with SMTP id ffacd0b85a97d-48e07fad8cfmr7293066f8f.55.1792356844351;
        Sun, 18 Oct 2026 13:54:04 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4edea3sm19607233f8f.28.2026.10.18.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:54:03 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Patrick=20Steinhardt=20=C2=A0?= <ps@pks.im>,
	=?UTF-8?q?brian=20m=20=2E=20carlson=20=C2=A0?= <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Shardul=20Natu=20=C2=A0?= <snatu@google.com>,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] Makefile: pin cargo --target-dir to ./target
Date: Sun, 18 Oct 2026 21:53:05 +0100
Message-ID: <20261018205305.2634339-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile assumes that cargo places build artifacts under ./target.
That assumption breaks if the user has a custom target dir setting, e.g.
in their ~/.cargo/config.toml file or in the CARGO_TARGET_DIR env var.
This results in a link error due to failing to find the gitcore library
built with cargo.

To fix this, pass '--target-dir target' to the cargo commands that build
gitcore. Add it directly to the recipes rather than to CARGO_ARGS, so
that it isn't lost if CARGO_ARGS is overridden.

Leave the contrib/libgit-{sys,rs} targets alone, as nothing depends on
the location of their build output.

The Meson build of gitcore already passes --target-dir explicitly.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c649c93c51..aea99a3639 100644
--- a/Makefile
+++ b/Makefile
@@ -3039,7 +3039,7 @@ $(LIB_FILE): $(LIB_OBJS)
 ifndef NO_RUST
 ifeq ($(RUST_TARGETS),)
 $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
-	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target-dir target
 else
 ifneq ($(words $(RUST_TARGETS)),1)
 ifneq ($(uname_S),Darwin)
@@ -3049,7 +3049,7 @@ endif
 
 RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
 $(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
-	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
+	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target-dir target --target $*
 
 $(RUST_LIB): $(RUST_MEMBER_LIBS)
 	$(call mkdir_p_parent_template)
-- 
2.56.0

