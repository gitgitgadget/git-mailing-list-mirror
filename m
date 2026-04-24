Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC31AA7A6
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042919; cv=none; b=jTaGlC5CL8vqU45rYQdZuJiy7zYWH/rN79g+cT/Eq4u0RBDbxqxOh3gfkFxsLXw0z8742tOKEsL1Z2ynUWxpx2YcIqkS1ooEgU7q9tCrS7B3WeUWpaiXT5tytcBD5GpUUJ85PZMSCJ2uX4/fbL4ZKp0ywIQfx/3t1ArmN8lqJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042919; c=relaxed/simple;
	bh=Cg8gOdl4iXD8K3iBHzhZ1+M0TqHiSvFtXYaaDhAXIhI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J2X4lLaKzrBxey6bdHLH/2moFjjlaXnU+FWBkXNVQAA+sQ86fnCDhcHHnN4G4Tp+zeNdmw60LVLasGCPhZb1A6TmfXXgchyhg8/gkevUpN8yf2YHFu3zM2ASpnVksURLkeFq60x4sOmjMRxwIRuY1I3NRk8MnW4cQ9PmaSdRh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYeMRYUk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYeMRYUk"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50335b926c2so61882111cf.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042917; x=1777647717; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpT3gsty+J5evlOS4DEDjPoZhDOu8/4vtCbpLo7aTY4=;
        b=MYeMRYUkfTvzaUzkIi+a0Yht08jNFDYPBWxzhRtJdLyMye4H1tJbf/iX2T/3Q92/xa
         Ln4D8MmdgndRyL9/wLaAGC44eq1RGBliy9+gHObt7/vUSfDwc3RUc4cpUtRwf30QZMAq
         0Nq4RDlSDmbYjVUDTKzd0vOG0vktNTf8ayhRKiMBP9L6G+wxe7uYGbOnAkhDdhy8ClI6
         wbMnijEqU1+i5SGE9tFUlrH+o/WS4PTBFXJuCrcX81Eqm4ApJX+dXTUQMAknGCI889Cp
         7UC273Yui2VE6Jqg+UJn3gZUiGQrmGirK665Uqxqr3jyh5DcbLAp7BZGyWV39NfwU3ib
         WO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042917; x=1777647717;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IpT3gsty+J5evlOS4DEDjPoZhDOu8/4vtCbpLo7aTY4=;
        b=COOrNNxXh+a3KFdMKQhO5Nh15jUA3dVLdN49yUn8QXpeyeqhD0/CIrgUVpyB4pzZhp
         damO5QUAXPVnrkavURkA7qfsSqJ8u9WHF0pLO8xz0YYuxiLTFOt2VqgQx33DxnN5CQwB
         QnpqcZI15+Tf42cFkTVH21L74D+LOHbjsJ64f+4ggv3UbguDgnaapTFqtGy9JTrC6uPG
         oi/NMHVmo0OrGNoXDLAnorzKIlQgBzdMcV2or3kji79pFnCPPbzX4F/CTAtnHBGD9UBh
         +al7UCqrRXa+znw+gcv+Qh2Wd+E+uoF27VEohaQeoe5rGKfrFDfjc/7pMasCQrMuWehn
         jXgw==
X-Gm-Message-State: AOJu0YxRTkcO2nn3+GkrzLko3ydNO2dkwfIB0fRvf5y9AQo7C9JPamQO
	M4QIPdFgzW20CevOoctLTPalEkTEM5PlvxGVl6zCPGx9/yr7PCkVRJRp2C3DWA==
X-Gm-Gg: AeBDiev8RLK2JNTcSJjxTK9wmgXPt8rt/RB/Xw4O9q+nNmAUz2z8bnu7rW4G5cFXwbF
	9qqOdWS4qwSGgt7Kh1sX1DLqBO98ZZZVcHidicTpIoeBeqzS1jL2+MvIUNnTqKxpNSFC2JYEN3Y
	tSAor3w1WyaP4aydJtRJAmoEjqJu6EjSTXTORLPfeDdFs4A+cVqWhCJOHLFg/seHj95oZSI/IXC
	w6BfJlg1gPMXmq4NLlnrehtpjIPzoyYOB8OlNdGe1vg/FAELPXE+g9w5TpW/VkHc4a2p7D65KMX
	RjEekVIGNfqADXbVi7O/JjtL7SuMeIiwv6TvZIFCu2UmZqJ+7VOYiqDaz9HZeLCmnHOcdo9O+4k
	LnhwOSOgipMjdIKlQC9B54RFKx8ddEiEpYDgM6EqUT2yGKHKtmP9yg2DWDmr9qFwCCG1Fqz3zma
	odAsOq/3GhlXHiah+HB993gnj8DXjbs9lkpGrU7w==
X-Received: by 2002:a05:622a:1189:b0:50d:84a7:72d0 with SMTP id d75a77b69052e-50e36e9c0c7mr479750931cf.36.1777042884063;
        Fri, 24 Apr 2026 08:01:24 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392e351esm186475761cf.7.2026.04.24.08.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:01:23 -0700 (PDT)
Message-Id: <092ec11621ce698e3f3af7bd5024d338440ffce7.1777042877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 15:01:13 +0000
Subject: [PATCH 4/8] t1305: use `--git-dir=.` for bare repo in include cycle
 test
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

Earlier tests in t1305 overwrite `$HOME/.gitconfig` with their own
content as part of testing config includes. This clobbers the
`safe.bareRepository=all` entry that test-lib.sh writes when
`WITH_BREAKING_CHANGES` is in effect, causing `git -C cycle config`
to fail with "not in a git directory" when it tries to access the
bare repository created by `git init --bare cycle`.

Use `--git-dir=.` to access the bare repo explicitly, avoiding the
dependency on global config for repository discovery.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1305-config-include.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 6e51f892f3..f3892578e4 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -350,9 +350,9 @@ test_expect_success 'conditional include, onbranch, implicit /** for /' '
 
 test_expect_success 'include cycles are detected' '
 	git init --bare cycle &&
-	git -C cycle config include.path cycle &&
+	git -C cycle --git-dir=. config include.path cycle &&
 	git config -f cycle/cycle include.path config &&
-	test_must_fail git -C cycle config --get-all test.value 2>stderr &&
+	test_must_fail git -C cycle --git-dir=. config --get-all test.value 2>stderr &&
 	grep "exceeded maximum include depth" stderr
 '
 
-- 
gitgitgadget

