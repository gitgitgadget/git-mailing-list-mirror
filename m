Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A453D1715
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775328; cv=none; b=mdvapJ0gJLdx7L0FfnnJOox6liPGRnNWBkuL8yvDFpN6kxV39QheAO0G8dHuiXlfhHpiuoJbzAgT7OiYP0MubAWLaBMqSYa03ZYScBGs2njTpeHOunpFs0d8yP5zaNx5WioRruk1SuD9oclZXCPlSAveteSop9Sy0w7e4Eb4XEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775328; c=relaxed/simple;
	bh=xxU+JUF678Pz6oONy4mJFecLq/ydqBtKIS0ntKkkmv8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fPpZLKungkZ2QrzVkq6UC1UrfaN273Z+80dw/Y00/cnKzQubK7lJYRzkVsR3hGk65Ub4WQpBuHDADWhOUKRQlfgU2TdSHVlA8mpK3iAbOFhjc/f59CnxkC4hDpBeeVDW6EGiuBWjM+n+5XxwWfYdTRDYRpbRJbURnxmJOn3Ev0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+27oxvM; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+27oxvM"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c565476d7so9319156c88.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775325; x=1777380125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgFWpsdsCkPHmL0PFlslVbVTKr38GMgkPX9sT8GUvtE=;
        b=S+27oxvMa7yGxy1Y8d+DudtsACNRJimRmivQmfBShuhGAIzDVh0c91j/OyoQBIhiWe
         L7iVPdHcL9pcjHf9mtB/sl6aD2ELvPYxNZBf99ijhpReg2dWvAwuxcAu46F14ho3bHvT
         uYf9GgvRAREqmDFAaIsGImpmw4KjbEsuaSW22Tg3hw2IEKG0Zh6Lv6PBOYObVA1ZzRys
         I5Sie2BXTn9C+KX1bAx8XHZPdmXPAiOe9bMKE4AqlHTDNjWA9oid+HitscgkscZTBsWt
         fMSiVFm5jQIWHK5l1OYheiHzMM8a4pFej5Ax7JDKA6/PyzbW4hwEHnxUFVSj+gPCqILQ
         pxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775325; x=1777380125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgFWpsdsCkPHmL0PFlslVbVTKr38GMgkPX9sT8GUvtE=;
        b=IA680DdkPmDKLV0Og6YVzrot7PHnce5z3ZOZS4/pdMgPWDvO0qHrMCfQ4pvaqfU4cy
         zkyxhUZ9583bX2P3kc3NU9N5gd2jAN9jl4b3O6izdP4ATz+pPbQGD8UT1kfg+dDnAqvG
         rwlcnCyCDztXK1nDTe9MAdkrrZE9mJ482dDZ6QJI45ShHvt7dlzerpxOvCjtNFrs39iS
         USAdWwWyaecLQ8ccBlSwYGoJbwRoMzNSy8YyPCGN0mASVXkXhB1M2gty/WM5GnMwfQsR
         +FE677pmvAe+AgGQQg0BXi12lxLGoY+3CKSBdT5bFEH8hibhAz7Ny3z9lPZ8NO0gDLNa
         ngGw==
X-Gm-Message-State: AOJu0YxYT+aJ7HKllMZASlUIgZ8aqsAAcZq5TYfxfOuGfSL17D884M/T
	aAd4cDQfctejwG05CVN4IQMW09ksVrUSm8MKFwUJLl/EmgElbveU7qfmGrLrog==
X-Gm-Gg: AeBDietRc65/kR3MI0pQMbxgoSRwAlnVcQw9LncAZFNRzYKGts4Eh849tGMlq/G4KNJ
	CRDllEGI2Ijam3a0rUKoHOleWWz5CvK4O7ojICU4f7+xbz3RTmB1r2f+mucs6jnace+DEwGhzGS
	It1V+1YX1kTP2N7uu3+g3ufuK58rDk2l6lNXTKH7CuRbRTiCCNwFr6U1o9GDDfXO2jmNArIQiIs
	L5ycHbelo9QVEE96D9BY6ZC/TRNtdU7KJWIuVQmu8m+hbE/apjD6ZLSgOg3gxYNGxxCCJ3bekcp
	fpjQ0ErxsdF2RZS1tu28j+993vQ10JfO1LPNPegMSP/hPOpWlg65W5miHwf2oHx1UgBnKmxakwg
	mjmf0HxfEJS1HrN52HveIxxsmjzxU1YiYIZrgf2gY+txv6Ur+x4ZeeEUdfaorGwK8KLxO6C8nSZ
	lRORcMQO4likoZ3Wu8RpvfZFE91PsHcjuDCl4=
X-Received: by 2002:a05:7300:148c:b0:2c7:287:6740 with SMTP id 5a478bee46e88-2e47930948emr10914520eec.28.1776775324640;
        Tue, 21 Apr 2026 05:42:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.55.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm23413751eec.8.2026.04.21.05.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:42:02 -0700 (PDT)
Message-Id: <0d2fdc1cf4c5d7273addedc442a222f0c3485efd.1776775319.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 12:41:56 +0000
Subject: [PATCH 1/4] ci: bump microsoft/setup-msbuild from v2 to v3
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

The v2 of `microsoft/setup-msbuild` runs on Node.js 20, which GitHub
is phasing out of the Actions runners. v3 is a minimal release whose
only substantive change is moving the action's runtime to Node.js 24,
so that our Visual Studio build jobs keep working once Node.js 20 is
removed from the runners.

The risk of this bump is very low: v3 contains no functional changes
to the action itself -- it merely adds `msbuild.exe` to `PATH`, with
no change to command-line flags, inputs, outputs, or default tool
resolution. The only precondition is a recent-enough Actions Runner,
which the github.com-hosted runners already satisfy.

See also:

- Release notes: https://github.com/microsoft/setup-msbuild/releases
- Compare: https://github.com/microsoft/setup-msbuild/compare/v2...v3

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6f3d94e3a6..0d3e0e42a4 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -186,7 +186,7 @@ jobs:
         repository: git/git
         definitionId: 9
     - name: add msbuild to PATH
-      uses: microsoft/setup-msbuild@v2
+      uses: microsoft/setup-msbuild@v3
     - name: copy dlls to root
       shell: cmd
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
-- 
gitgitgadget

