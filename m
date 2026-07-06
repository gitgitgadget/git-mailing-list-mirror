Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329B3D75AA
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378346; cv=none; b=MQFFY+KaD5n/MCs6IS1HCjnRn49ldNNGe6unpliaUkg6/GnmAUKl/Xm9wqEnK5/v6fvtIxlnnZkykBgRJdUz1EUpznr1H4AoYHcqzKMj6Q886D7t6OXAXKxeSA2VAtEJMMzPM417JFZCMOaaXVLR4fAqvCXbQvFOPTpyeE8hrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378346; c=relaxed/simple;
	bh=ejsA3K630jU1vrDZ/tgbCdIHh/lWaMB4C/dr3EIf4mA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ljsJrVHbQv6ehqgf369s4cSdhp+fjIpCxoNE/eNROVMxTIi/ZbeiDf8jzbT6/rVBArWKD6IsPDFD99SBSGjjzIlOitfgQ5yINKYpcR5dzxC6864qBvIMoX8x5ZOn98RMXV2aDpmaViRvUlMIJ6iNMrqL7gCmdQdfIYVS0n/mP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+fOFCQi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+fOFCQi"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5c9211d2so281435285a.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783378343; x=1783983143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RtHDyHd0jyoGXTQPjfTXUb5KOvKmmqc4WKzRo+LrwIc=;
        b=I+fOFCQifaHig0KLhJDyiQV/tnds6/Q8Z5AT38yQaVcoVPU14QRX6akMeECYv4lp5k
         boV1ac15s+x0ZcG42xIC5Uj5I2xjTT72TNhhb/Z+g9CLUjoDb3+eY6cC0v0wZ26ZEJq7
         fReuOiknBaASzcGv4tMsZR+y4P3WjtgZCdSFppIGJ/wmid5B7llkxeIHwVX0ZO7ouk3s
         bRtd1NSn1srfwcnClxgFTSynbJvTg69EKSZi40OMaH44Vc2AXhH5f7yt2VMxHISduR+2
         jcJIAcJQqeCzYITFphUARFvNXLGlqX/mebPnUtV/klpFsDtY51cPgS1PFVw6h7GIxkL5
         IyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378343; x=1783983143;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtHDyHd0jyoGXTQPjfTXUb5KOvKmmqc4WKzRo+LrwIc=;
        b=Q/u1tQismHrMfkuPmvdhzqGEZm20vaQMtJf2gGk+u8eWmIzDdP/KT8XS6XO85Bq47Y
         QDssBm5MEacAmvhNDZuun7h7aEjPpCIK1oYulpRouLWIA1cutetsTqlXt9q7RxxaTIlR
         OUQBOfSImfZLTS3S5JXMSxygEqemHxm7sjG8UQ7HCHFkbuDorebV2Q0yLU7cUg1hg76D
         o3l38x7ATYxT92UwD06eJRJNnKXtL8R0/LqpuO08FS2Tw7fqEnIJ4vn3fdnpwbiexwI1
         XaKgPeEv3dv8uStDGxU6eCsivQ7DBYs1svhkKM9woj+rOyfVnOSE+CZGez5REpMOIeO/
         2lHQ==
X-Gm-Message-State: AOJu0YxTZl/89rr6xuETVKxmJlN93o9SfXISyOnaX89C3GbpolOPpFlQ
	DgJEMyOLSsxOhIVOJXUAxx77NjRSQcPkv1mCLda/7Foy+rWA0+MBYI8ZUwYqmC2b
X-Gm-Gg: AfdE7cltixII9IoV+d6gn8UXa4CTANdNh6oV37UO9UHR6lV7Myh6oVRp3h8MmKVYi2D
	69CNyESemYfjncicFfsnTNnclEL5Cl35VdL2zlV5MznIW2H5EumuOWy2fhO2EfStPluGsX1XmGW
	5k70BvJK2BOe1PMqoGXeFboweUKnD1UrrdL7UOr9b6yWOtucdFeeNhU37FGpyh0L46CN9ZT3Oo8
	cfj9f3c8H7CA7pVMIZU8kHhKk3PgFB4YeTxzD5VDic6V9WJsvfjQJwU+JMHiaZ17w3c5AjGpx/3
	jZ7L+duiDl48AnwSllPS29wotChSLK5gHoIdn2yT0iXh7w46RReWanIbVTTWn0QAGyIxQneURs0
	VhzUzYfexLfp1e2cOxe24G+kWuFzzCQ/0EAC3P6tlAnWeWZhJsDUpxO48bynxGXtiSmZUPeez7T
	4OPRQGv+HRQ2oyKLyEHaU5bmAKxg==
X-Received: by 2002:a05:620a:408e:b0:92e:c118:18ad with SMTP id af79cd13be357-92ec118290fmr15731985a.76.1783378343549;
        Mon, 06 Jul 2026 15:52:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.72.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800ccsm1041509085a.8.2026.07.06.15.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:52:22 -0700 (PDT)
Message-Id: <8455e449f388486c4468dfd528d7d96e90fe2c59.1783378333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
References: <pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
	<pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 22:52:13 +0000
Subject: [PATCH v6 3/3] contrib: wire up osxkeychain in contrib/Makefile on
 macOS
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Shardul Natu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

When running "make test" with TEST_CONTRIB_TOO=yes (which is default in
macOS CI workflows), $(MAKE) -C contrib/ test is invoked. However,
contrib/Makefile only invoked tests for diff-highlight and subtree,
meaning git-credential-osxkeychain was never built or verified during
standard CI test runs.

Add a "test" target to contrib/credential/osxkeychain/Makefile that
depends on building git-credential-osxkeychain. Additionally, wire up
credential/osxkeychain in contrib/Makefile under "all", "test", and
"clean" whenever running on macOS (Darwin).

This ensures that running "make test" or "make all" in contrib on macOS
automatically builds and links git-credential-osxkeychain, preventing
future build or symbol linking regressions from slipping through CI.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 contrib/Makefile                        | 10 ++++++++++
 contrib/credential/osxkeychain/Makefile |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/Makefile b/contrib/Makefile
index 787cd07f52..7962a9ff12 100644
--- a/contrib/Makefile
+++ b/contrib/Makefile
@@ -1,10 +1,20 @@
+-include ../config.mak.autogen
+-include ../config.mak
+
+ifeq ($(uname_S),Darwin)
+OS_CONTRIB += credential/osxkeychain
+endif
+
 all::
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
 
 test::
 	$(MAKE) -C diff-highlight $@
 	$(MAKE) -C subtree $@
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
 
 clean::
 	$(MAKE) -C contacts $@
 	$(MAKE) -C diff-highlight $@
 	$(MAKE) -C subtree $@
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 219b0d7f49..d9fba07e8d 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -10,4 +10,6 @@ install:
 clean:
 	$(MAKE) -C ../../.. clean-git-credential-osxkeychain
 
-.PHONY: all git-credential-osxkeychain install clean
+test: git-credential-osxkeychain
+
+.PHONY: all git-credential-osxkeychain install clean test
-- 
gitgitgadget
