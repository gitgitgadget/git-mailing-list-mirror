Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25572AD03
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326672; cv=none; b=m1H8ZzBr46/sn6wwYSA/L7MiJnBoFVcJOAnYdCZtkq5YWEpQQxXQQHNfm3CFwQfPcAxxf4cZBZECFFQC8HP+smFoFoEiht8hG3v/U4pzt/NasZZjCbycPIIGmJwD0prb/qIiFPyBHZQp1nUKucUTEdpizZr/AfN8yhJPyFyh6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326672; c=relaxed/simple;
	bh=lk1lDUarZailUi2NthTvfiATMVC9KYiqHH/KfhoPitM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=OayelDj2nY1JIRzMjciGATTWWG6+BoX+8dRY+QjqEncpAYsKRg106uvBQkKqQ9U2CGsunLVmYHajWs0PUQ3r7ER5Y4O3oHuYYA3YIhAKgwiP7ys4ys9NBsf+Qfn3d4ML8PgUE68vaOcgOR0FasbxE7SZzIFvLHt2AEQOTPGg0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItItTH+q; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItItTH+q"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93a1118fbb8so100733885a.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789326670; x=1789931470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SD+gj3+pNE14j+roAhwloPdQ1CnMPdigWG6yfJs3wu4=;
        b=ItItTH+qwQQRIcI/KOMEqZq7S03MqnygEG4TAyKeFw8NIqf/t+TCYOlpkkJsk8f4wq
         Le6cyOv2ul1i3Fi43uP0FzrY6U8r3zLYTNvWrwUbBrgfGsxhN8UsB6vx4bDhLOInMnqQ
         7Z6snW1Ptfm73m27Z5W/q6utZj2+TNHqysgeMdZoW+oSufj/9idqwHGPbiLt3zbHk2OK
         CUBH7kCiHSmazsYO3h3Svw7keqCTk7RSduG8du1fOCTOo1LtDINjNcW9Sq6WYZq9xQrm
         R/ad2bFrZI1sUX2NVHZQashVPubG+ZHW6phBnZsaJzNFfSSVUkBqeWKqWlbyhp4efV6a
         sdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326670; x=1789931470;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SD+gj3+pNE14j+roAhwloPdQ1CnMPdigWG6yfJs3wu4=;
        b=otGAZh2nCGbZ8zwXYJ2Y9VHZ+eyzDdnBBrrgJo/w7lxU2Mui9huabejkuE4yjp/SFj
         W+O9n5DEFLmZrDH0CmJ6pm8f2fP7SV6H95TEDn+im80rH0d9ERfZXdN8iYJXbDeIGMwf
         c9oslc0ibandl6E+Gszp3djCWUpTpbI/J/fKD3v4TNPUlhQpcamy2gIyNnKaW5udwX9C
         K/HwPQYKR7/eWl0LMB2OZhrUyuiy8qPcabihy28JRXenLf+1XfeAlHcj0LaZaLl8hVYk
         dMQ4+6nx/Y9LregG0n86Ihx/K3juXuU3+OdMM1UORoI7bThnUsf+7sUJjngZmPeFXWgT
         u/9A==
X-Gm-Message-State: AFuF++mosija0MlCMp7cjYYZNZ4nb+zbAWC/jhVxSl+K+c+yIGLr9xRZ
	6ZraSmJEsnf/Iz55/eRlc4lznluj7W6fU8vXvMdFXeqrWE7pVHxrczZxCAoT2g==
X-Gm-Gg: AYBFou138VZiV1R1n1RkpXCDL44nvmHiBq+/3LOt4qB3Tl3Fe9IQ9ztNandQNazUVQ4
	tF0AxaHil1SZ7dVH0U6cSxN0HevRtLuy4wy6owqnkHAxpPJyMjA0ratDiBOTwCKi4ef6CwqDopi
	nrMtihkWZJaOpg1bbnpqwq6pqt/oG+ci39np+7IqMBXet5DUS0qXxluE2A3FIn8hEzhUNqRKvXf
	EiyIN1aK/XEDcKRgzDmoeDIzKIjLmCo2wM7JJWkWTHIYgXkrhKgSeHOVsKMGJdifDslf6zNeCKj
	OkjLx7zb7dG27MpPP/4F8u+ikU2N1AN8wgXd+/M92ol+zQs4DzrzPMts7WpXoBJylGlS34F6E60
	S6VTWaWqFjhH5R3bJi/0PhJPKpy7THlalx3F+lRfpR7XFNYUhUrst16LaKvefjt8M822m1UJKcV
	un6fkq0AcCY3a7+DCnEowatPow/BbI91mFrdNMw4T54/EacLDl1kW/9pbah1R5l2KDHD4WlaXU8
	ko=
X-Received: by 2002:a05:620a:19a4:b0:939:6dea:4f1a with SMTP id af79cd13be357-939ea2af38amr1839450985a.48.1789326669808;
        Sun, 13 Sep 2026 12:11:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bc225sm787373385a.36.2026.09.13.12.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:11:08 -0700 (PDT)
Message-Id: <pull.2227.git.1789326667.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 19:11:05 +0000
Subject: [PATCH 0/2] mingw: fix perl related test failures
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

For performance reasons (and also because we retired support for git svn in
Git for Windows), Perl-related tests are skipped from the CI builds. As can
be expected, this caused some bit-rot.

While this is not exactly -rc1 material, in preparing for Git for Windows
v2.56.0-rc0 I did run the entire test suite on Windows/ARM64 and these were
the only two bugs that needed fixing.

Johannes Schindelin (2):
  t9700: accommodate for MSYS2 Perl reporting as `cygwin`
  t9129: skip UTF-8 tests on Windows

 t/t9129-git-svn-i18n-commitencoding.sh | 4 ++--
 t/t9700/test.pl                        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: b8242b093d9e941a34460d715e3ce616a34ac3fe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2227%2Fdscho%2Ffix-perl-related-test-failures-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2227/dscho/fix-perl-related-test-failures-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2227
-- 
gitgitgadget
