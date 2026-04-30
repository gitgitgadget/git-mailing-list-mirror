Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46823E1200
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534516; cv=none; b=CccM98xnM4NPZYyrLdxAiRBGBYIXgUjSwRDDzLrabQIgdW3Jz6PgWLsgNVWOrk0wvcAYm8mX53klbpRZgzbijXhg0KFeGxLzKhOQEuwNQhIz4uh+VRWgUVAwwGa47AtuBE60+lrOoked5sH589Ch99o7MEDw8rjyMA4qoZ/2RkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534516; c=relaxed/simple;
	bh=xxU+JUF678Pz6oONy4mJFecLq/ydqBtKIS0ntKkkmv8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aaBrkjJI/Ue7EOil+Wlw0/QipZDZ37bXFE8e7G6EMvu72tr7RDZjdxtXEaELEL2TmFb/fj/8MpsZvqwdCWFwj+bhqHT1edg8rGkiDtDelcILWpOsJts48wXtZFO9MPD+U+4ScsnTBwqr+WTSmstDAjz2JKhkclI+Ti/Ii6fjUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIssItow; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIssItow"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50fb1932b62so4012741cf.2
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777534504; x=1778139304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgFWpsdsCkPHmL0PFlslVbVTKr38GMgkPX9sT8GUvtE=;
        b=qIssItowMNcgWZ/OFJB/0aYOBDvZJplZLo7xnHfIYFOKULCQ0ttJq5CAD75AJqz7xD
         BvYzpLezIacTYjjClTUc3av4WPhgFTr6JsdqhdywwLqUgVOxfSp7k+GD89EU0llrEiJl
         /kHb4HXrEZ9zPs3PlKnEwvVyFddr5vk7NeEL6T1Ew9uc+E5nJjKES/gmfdJieFJja44x
         vqzXr8tgqPVmZG6qJcM817MZ1Zh/e2TbnvJEN+jP/yXDlm/C3mrSXKQgf8JqOXqEzZbj
         duqsbqm8BlXKH6u3Bo582IJjTstBw3gvFSE0f22L2r1S3s0EgYFJeNpYb5C9LITHUIkk
         Y4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534504; x=1778139304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgFWpsdsCkPHmL0PFlslVbVTKr38GMgkPX9sT8GUvtE=;
        b=SfQiedYwWGFrLO2UsuECK/126LglPRtT+50SmQR6r7KU5mcW1iLuFP2B1ls3XJDk6h
         DlR0kxQ480QVlSkFJg1LEGAQ8Lv+I6sgVnbO4eCEIiEj1VF/wWoi1/+x3uPK3zi1vOpS
         gNb1uhPNjR4GUleoWdCkYI3Hmfq9FzvkRF1ozE9GE3aYL8ND+I76SkhYHLJtDRq34oy+
         snckNqOZgkOa/dX450Svr02+pZmTGbujCD/8mZ3Lq2pu1xJo8bNIacSGvr0q55BOnbmD
         aZaubvGE5/+vfHbPRgpwPNtvjwshLEAtGm24qRBDbrOqPJYLeeMCqfAo373JEFZiNB2E
         UN7Q==
X-Gm-Message-State: AOJu0Yx1VW95DH3SLdv/92V3sQXlp8mBWcfmRKdCisq99AI+C0591HJs
	x2lroREe/Xs1LtQNneIo2F6ZKjoanYe8yCCiwW6rMDquO+bCI+q39bm9kOZxcw==
X-Gm-Gg: AeBDietxcejEbthEwb8aewV2+2kkdxPXLXk9sCCQy2f+H/Dy0NzTMvp2g27kVsym3V9
	SIuKF4lyPuoJgYTG4MRIgRcAQRd7Szo+vJATk+xf9LUP+EM1NDzLGSeLKtNEd5jZTLqmnxgFEz4
	nw0y+SDNEdaxE5iTa9K1LnNSYXBtZuKzHc35H6bpmYaAlVSu+oDAjtS1xLB63h35DV8mTvix0cB
	qJVAVp9nBQdoU7LZnDQ/bAFq/6IdzUNe8/j89jLtX7ZdvTMbTKYN+UzLaOcBs8J81dc7DDJlpub
	M4jodXbxO0HzDKT1m5hTNGpvsg5MfMERddf8BfUwZm+I8HP4trU6wCpXT3rT2YGpfjyJao+k7zq
	CRAbSbBGX5sgUDX9s3zmOqf//bBJ4bc9YXLm/1Id3sN7axoGJUDr7E4SxHCUy3b+MVZ5kb4lJGE
	MPQ75nEgFdnmHB81EMSpqxlj5y5B7x+cN8zKLW
X-Received: by 2002:a05:622a:a17:b0:509:44c3:5ffa with SMTP id d75a77b69052e-5102afc08afmr21830221cf.52.1777534504214;
        Thu, 30 Apr 2026 00:35:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae8771asm37199431cf.23.2026.04.30.00.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:35:02 -0700 (PDT)
Message-Id: <0d2fdc1cf4c5d7273addedc442a222f0c3485efd.1777534500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
References: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
	<pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 07:34:55 +0000
Subject: [PATCH v3 1/6] ci: bump microsoft/setup-msbuild from v2 to v3
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

