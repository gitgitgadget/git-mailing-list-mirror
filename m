Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04C3947AA
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777114726; cv=none; b=O1cxpXumkgIRQ9YsTFJURu7QcEKOvm2aknhHcsEXS/8cQVSBh+aiQjq9RaZAshGaw7MIxRrR4wsnfRKf3kA87H96iM+7J7gUbZe/7k2eMwEnSdPO61/XH8q5JOwD1vQrWN+OaWHZCgrIXRJCBCzERd86J4RSrCf8+hmaYjS+AtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777114726; c=relaxed/simple;
	bh=xxU+JUF678Pz6oONy4mJFecLq/ydqBtKIS0ntKkkmv8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ouvs6ykzv98uurS4M1SA+4NJ6e1oVlHiMAITReGZZbWf+dFbaHbSgnXKojywjCdI+YpZA7B9rdELSb8FLb7KJsnCKrEoXR/cml9iVX7JdiexhAc2C7yC6dOYVuXArxKirrp6oqnKuBlIjL/6Ah3RR1eWBt40zKAljt7zPBP1s4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4pjcoPz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4pjcoPz"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8aca4e14411so106514926d6.3
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 03:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777114724; x=1777719524; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgFWpsdsCkPHmL0PFlslVbVTKr38GMgkPX9sT8GUvtE=;
        b=p4pjcoPz6eFglYkkz2zgNYNBIC1o/ARhN81y7wnAxslgO+ffA2PDqZvFDCzh1BYoBg
         Rkmg3Ttng9XSCcAjlHC3plZVk3M4sNlSxemvMzjNeW3bw7Y0rJk1yWDdFVBJbttW9JH5
         cGWehC67M0XJ0ELDK9ZRnBMFfsHSJ/Sf48qY3vFTI8GZRuIGo83zqVcTK7QUr3B0lluH
         hQf57rr8JfiNs07tLQH1OhSRxZHnGAIOwoiqs2lHWI1rXysxZmUxMI0YwuaaAVtJ0HyJ
         7tiNlV3eU59P4CSRq4LsZp1fRYVhdVG3gaS4tZfFflO32LGK23bcVGzsn0kuTDLYEDGa
         fPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777114724; x=1777719524;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgFWpsdsCkPHmL0PFlslVbVTKr38GMgkPX9sT8GUvtE=;
        b=EVHTjqM7CKuNJ4EFrmn80+JC+N45WR+zJpnxYPVffnIUaG4MOSiXOZ8983KlFXp++H
         Pj5sMf5lBvaesfVfdZvLL0sli00zjw38roOL/iDSONq7DZwNCtJyVGdqBPC0FQxDC2Dj
         SqUfrlSyHYuFvSvbn1dOfL8m6q4xdEHw2DwZmMTW8LemyZdPjGWo9JnUtcSfARnn9xKP
         KjJFrPDXKDiWs4dfTHCz/yEBG8OkMBAxHeoa9wAqxknIRlYGsb5S71MIPorm48Lpcx72
         1nLZkcgx3Vcz6sbCpnZFu19NgnzJa8zT4d9AsNvQaF+NHwRkjrFWtU7t8yYfIH4aCZSP
         DeVA==
X-Gm-Message-State: AOJu0YwRga4jzlL55qP1mZK+eT8qjLTYD6PAYie/qXi73yBntCXVGtgJ
	Uo377T0AAynNLScdHH2b49hjqZcCCJmwi5Z8kKEnajE2hQPIVPY4PcjMFr1i+g==
X-Gm-Gg: AeBDietJCNuyQr7ONgh/O+oQw57HH6IIS4u3bLIYzqxUI4dR73CwzydCkVF4FcUAP4s
	p6vSPnbm1EXs+QEfocIT689gLl60R9KoFnIqkocxRqCcj13h+fC1r444RyyPZO7OeHdNno46i+y
	mDp4nLgONm98JeiZ2FzLOzHr1jlM+tMxxQk559nTH/Z/gfaUf0EW4rPt7Amhk34uchSj9DhQ83u
	l+vR9NQK9sieZWN+DjzJGCJBZBtDoPuNE2ka314stX0hWxw+TQwp9iN57ABrHPtaWNREvYOsX3e
	oy/+3lWK4hV2OtSQy/A6JwH72m0nKzrH96XWE8wzKqDy7uY0mAgdscVk8VKwKvfMjUSn2iO2qOY
	2QRMULnmsdwV40sfV5ZTpOcvCqvCzvJ9Yc00OAOM3anIEaMUFiyiDTiU1LwvWG5Dd42wzhIdMVA
	kTtQSXerXund8Bi17CFWTCjT37ZbKejh3Vd282eVwn24Wki0dB
X-Received: by 2002:a05:6214:459d:b0:899:f0b1:7332 with SMTP id 6a1803df08f44-8b0280d6c96mr163957926d6.32.1777114723994;
        Sat, 25 Apr 2026 03:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aeb04e0sm202418006d6.46.2026.04.25.03.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 03:58:43 -0700 (PDT)
Message-Id: <0d2fdc1cf4c5d7273addedc442a222f0c3485efd.1777114720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
References: <pull.2097.git.1776775319.gitgitgadget@gmail.com>
	<pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 10:58:36 +0000
Subject: [PATCH v2 1/5] ci: bump microsoft/setup-msbuild from v2 to v3
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
Cc: Christoph =?UTF-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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

