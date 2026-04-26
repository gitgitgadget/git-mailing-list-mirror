Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1483366072
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214324; cv=none; b=LQUxlXlvJqkdo9lHn4yNCNM0iFCVfceUQnPwKrIXIGATDfn6b2Z6tYKDlDBno79YpTc7gCHpV6auwZ4omKU/uPeQDDgcRjNRgtguEv4WXJfp3oHwzQSSe4lXxObs115bSZsOfmYtR4Wbg6aAEdL9z1jikdioOZnRIcbXL5eW39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214324; c=relaxed/simple;
	bh=yX82TyB7MQCLvtauiAHheQkTi7xfhOxhE69AGWdjxiw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tXo3Xqpc6s0YogcflyRpQhP6/0uHDG8nDJUzRlbBUWprFOqi6wZabdwXdbsNN39YUcqLfpCjyDoLyDU9WqLVPlbK3TEJ2iVgsq0Jxrp8fMilEIAdEgjyU6Li/t1uGA86AwbvLBAOxwCjmb4VfCAxDrggsyumuNFmpWPl9MMJXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cuw2mtD1; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cuw2mtD1"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ef2118b478so563379785a.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214321; x=1777819121; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJisFIYmu999F7p9DhPuR13C32V5G82pAGkfuc9Jdyc=;
        b=Cuw2mtD1w/PRumPjjuLnXcekWNOmKvl4SdrwlSv3DDLQV3CuxYP4cvYnHEKOxHWE+W
         AX1bN+wlSo4Bl1ePStlI0zQwExoi5epqISbaUetGEkaMZL21ORGXPYlFso0b8lyDKq1Z
         rHvRda1SmoKyoBCA7wEbggEq9yoAI3P3bN4vtkdXsh+3XHtUeIXRWsotMTUlVp+ikqoV
         eWTLIANAYmAkuIbJe3D85/rkKGvWyRyUOwmT4DkG1MiDNgLooKsnC/BqKukbkLVRbfYL
         EVPYQ0pg0MLOfR9QDT7/mQ+EM0k4OqFXYdcHKPoSuU4L0y8Q74sYPI/U6D9cFBuDM5cF
         n49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214321; x=1777819121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJisFIYmu999F7p9DhPuR13C32V5G82pAGkfuc9Jdyc=;
        b=RRce81m1nc/fr8RGuJVTnv75gON+6OSHELVAVYQubmtm5OYGhpRtgl2KZQwGeyO8db
         TbFb2breugPNB8L9r0HFo/ZbDqFFkzmpxMLzC+vMU8N4QkvfvV8rccAkyxnoikQ/ii26
         zVOTDWpqWy7/RrAkOHZ9VLZpoPUVJJW2yUepFh3Bw3yWccFmz06j40dPh6PE9dP+8Sc6
         kiGKF2UWUubX5iIMb5UZu63UB2hu4dT7daXDLUEdygVyg7gnljJFYqRFz7GrOQLsFjk7
         qlZJpv+FEeV65lbbIhqA7uJfOMZWT9vUi5SWcDUGT5xdpazw6dNBNZGmtwRYyk++iiLN
         hq5w==
X-Gm-Message-State: AOJu0Yw3DmOAY+9ODJ9xxVmf7htmVi+yB4asNiZVyx22l+HgMRu3ncmT
	udKD+uoBNUZIaxI9wgwX7+c7RhnnkWtu2QBt7s/y2ER1HjQ5Tlvl8A+is7qpUUQV
X-Gm-Gg: AeBDieviFm1UWqkdBmHDFWZSL/gujs2PGrbKXQh/NRrFiIld2POti0vqpf/1S6WwQi0
	rrJn+kkIyEbHokMK5g12mfWMLf+VhixDP8GVI6fEZXI6jVCBoBztcaRYMUsFOE6ync9IATO7FOc
	t/XxMaT1o7r3C7oqHlQOMZnG+aPcPTUzxiUBHLNTTkyJASMqxRHiFvv8IIfxOZJwFnqklM256jx
	ARiXXOIdvS0QgfHQiO9+t+gGzqOoUC4zr/g67LqmuI/IeoC/Oynct9/eYqk4wdtrqrQ/WIjiM2e
	cTYsqM1N9JOGjd571Td2sJ2+4z/MgZwpLx60syvXbMGfzB8sb48wkOhy0NEzqySreS1M4A1qI6r
	FuJhC5AG9bu7OxrqpSHIVcSkCWXrsi7LW6w5V9eLBZZgyiJEtBfxIzns6yzT8xcUKaNufr3kViC
	9sRoqzj8kt05g2nU0LTVEfIIbSd2/qbKE2Wg==
X-Received: by 2002:a05:620a:46a9:b0:8db:de3:92a1 with SMTP id af79cd13be357-8e79208594dmr5668847285a.48.1777214321392;
        Sun, 26 Apr 2026 07:38:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ebde788c01sm1755792285a.10.2026.04.26.07.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:40 -0700 (PDT)
Message-Id: <4dc5151e59f289da2195f88c1f8bddfdf71343c6.1777214316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:30 +0000
Subject: [PATCH v2 2/8] t7900: do not let `$HOME/.gitconfig` interfere with
 XDG tests
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

The XDG config tests for `git maintenance register/unregister`
create a fresh `$XDG_CONFIG_HOME/git/config` and expect git to use
that location. However, if `$HOME/.gitconfig` exists (which may
happen when test-lib.sh writes global config, e.g. to set
`safe.bareRepository`), git prefers `$HOME/.gitconfig` over the XDG
location, and the `maintenance.repo` entry ends up in the wrong
file.

This is an inherent consequence of setting global config in
test-lib.sh rather than adjusting individual tests: writing any
entry to `$HOME/.gitconfig` has side effects beyond the intended
setting, because the mere existence of that file changes which
global config location git prefers for all subsequent writes.
Individual per-test adjustments would not have this interaction.

Fix this by overriding `HOME` to a non-existent directory inside the
subshells that test XDG behavior. Since these subshells already
override `XDG_CONFIG_HOME`, they do not need `$HOME/.gitconfig` at
all, and the subshell scoping ensures the original `HOME` is
restored automatically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7900-maintenance.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4700beacc1..4358df0424 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -101,8 +101,12 @@ test_expect_success "maintenance.autoDetach overrides gc.autoDetach" '
 test_expect_success 'register uses XDG_CONFIG_HOME config if it exists' '
 	test_when_finished rm -r .config/git/config &&
 	(
+		# Override HOME so that .gitconfig (which test-lib.sh may
+		# have created, e.g. to set safe.bareRepository) does not
+		# take precedence over the XDG location.
+		HOME=$PWD/must-not-exist &&
 		XDG_CONFIG_HOME=.config &&
-		export XDG_CONFIG_HOME &&
+		export HOME XDG_CONFIG_HOME &&
 		mkdir -p $XDG_CONFIG_HOME/git &&
 		>$XDG_CONFIG_HOME/git/config &&
 		git maintenance register &&
@@ -124,8 +128,12 @@ test_expect_success 'register does not need XDG_CONFIG_HOME config to exist' '
 test_expect_success 'unregister uses XDG_CONFIG_HOME config if it exists' '
 	test_when_finished rm -r .config/git/config &&
 	(
+		# Override HOME so that .gitconfig (which test-lib.sh may
+		# have created, e.g. to set safe.bareRepository) does not
+		# take precedence over the XDG location.
+		HOME=$PWD/must-not-exist &&
 		XDG_CONFIG_HOME=.config &&
-		export XDG_CONFIG_HOME &&
+		export HOME XDG_CONFIG_HOME &&
 		mkdir -p $XDG_CONFIG_HOME/git &&
 		>$XDG_CONFIG_HOME/git/config &&
 		git maintenance register &&
-- 
gitgitgadget

