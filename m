Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BD1D5CD1
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430798; cv=none; b=Hr8jeKt2f1XO8lh40lsDar2o/PtQLspvdqDSeSDuN7G7BvKP+s4wXYODhWdcZvlcRS9g+W9k+Opxa4iDWSDCETnXhaiX31aQmLHAHQgT0dO8Sh3dYxUQ90BABbyw4AnHdFQbU/H3Y4p7TN6uOp4Qh6dqxY5CFXEuwZjs61u227M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430798; c=relaxed/simple;
	bh=QUsr+DZPW8rMY4bAXDeALQkmhyPl/cAgYNwEygN15SM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=erIGlBMICexxz9MujGOERbA3XzCafls7PRJyNxvwuz2Wd2lB+xW5EqniDTK8Tz0GnEooqrJGhTsXNqtGQn08JLVwx+/xxlAy0DdXwZQUAZuZW2aI+KrfG2Z3HDCNNJWkIkcZdTsb47hAicHxnqZL6ViJ6iZakEUh5i8ZpV7+uGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMoN5wII; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMoN5wII"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso24245535e9.3
        for <git@vger.kernel.org>; Mon, 05 May 2025 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746430795; x=1747035595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKgmnRV0VhLeKOXCJQqawxknA0daZdT/B8ar8Ic818E=;
        b=RMoN5wII4VTZdW4fPgYHNjN0Sw1t8uA0NVHJnDiaMN0RMKQPvLSndqddMfxSauP33K
         Du04n+w9WRCWu1uaTDjAXFPCIeHURzJSJ9WoTrwGYeH0LAnWPdL3MGZdN9hX/ewStswo
         UCMQJIhLVO605YAvRoE1GlECJAHGJY6+6nE14KKwmRyKWPDohAw9yO2zYsRRdd/XcknW
         Mq3J6r+7Tfb7dv+GAevUdcHtNT69cDwe85UqVqw92Rm6Zz1P+Lvc2SJQPovWE+1taW8O
         Qm+jyI9IVZlRQsaD+9v2MCJeKy6KdUubn+Xb+nleJ3tnEI71HjgvwwxXJdp6ibhYq4y6
         DtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746430795; x=1747035595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKgmnRV0VhLeKOXCJQqawxknA0daZdT/B8ar8Ic818E=;
        b=TYJZHq6jyBa3wY2Xul/ZSlJppHO94nxocuRFHAgIWoh7Sf9Umfd7/ruIMQc0w7P8jB
         LHmSNEeAKT1CX4kN3YZ7RAndXZu2A1NzMp40Lm0RrMtT47dR8lWr/dBFe7CkMiDCge2A
         cbrj6RIdftwysL+CD2dVkqfWfZ/Z/Ga5nOhzzY9BEXZ+Wr7y2VGRMEZWpIKr2srRTBEs
         jBZ3al7ZByGiPmF2NrwOBGHt+73W0EePHEb0YbsVrq2IkE23Vfxlv5nY225Kndd+IxoY
         sCAvkdxk5ApmXE9ibJGkMRHJN6X+UbgJ2WkNPeGGk94G5yw8raSgpMhAaveS4A4Xw6nI
         QKmA==
X-Gm-Message-State: AOJu0YxvvYmDHSH2YrPB5+CLWfuAASA9G6uhh3l05ETS2Rpny+sQOGhs
	QqS01H3ZfvvNjuF0ZzL0b4BPgKBNQIGktXdoVWuyKJz1Y8Clz9gbc97wpA==
X-Gm-Gg: ASbGncuJCBMSF02m8OtShmlGblEuwN8oIjk/sqqdA/QE4rMxnEyDbIxSnYRuEGhS025
	wY+7et9z8t15Y4L3wy22CF5iyq0FXf60emahzIKRL02AVHyO6wqWvQQsXhvwQFxGZ4E74jNyecI
	B2ZDLZ+vY7dQYH6zGOLZCkxcpEnwoe2spf9Xfd7dq23fDTCHAlra6ShVq47LofKqtspSOQPK/Sc
	213RhWsaJRB7IWQlG2JjZwhCP+LOd0B1/db+ybLxf/CTrHKXAGmJm/YFhNVoLPevn3l/nSkgg9o
	d3TszdpbYXpvpnpN5TLuxqbMYxptUxXIQO1UcvcmnkSAOefXsVNW
X-Google-Smtp-Source: AGHT+IHX6SwYdpiAfgdg3oIhCvMgYR5WaY05OxLXHNENDkTv/QCBBlJMWtdRPmVLZ00k6lwLzpXXLg==
X-Received: by 2002:a05:600c:8012:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-441c48b069emr51180805e9.5.1746430794643;
        Mon, 05 May 2025 00:39:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b20a70sm171159675e9.31.2025.05.05.00.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 00:39:54 -0700 (PDT)
Message-Id: <225eec050ebfa234a570ca00181e58aa7cb9a78d.1746430791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
References: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 07:39:50 +0000
Subject: [PATCH 3/3] config.mak.uname: drop the `vcxproj` target
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

Now that we dropped `contrib/buildsystems/generate` to generate Visual
Studio Solution files, it is time to also drop the `vcxproj` Makefile
target that depended on that script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 76 ------------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index db22a8fb3113..524a7faa3098 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -766,79 +766,3 @@ ifeq ($(uname_S),QNX)
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 endif
-
-vcxproj:
-	# Require clean work tree
-	git update-index -q --refresh && \
-	git diff-files --quiet && \
-	git diff-index --cached --quiet HEAD --
-
-	# Make .vcxproj files and add them
-	perl contrib/buildsystems/generate -g Vcxproj
-	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
-
-	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
-	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
-	 echo '  <Target Name="CopyBuiltins_AfterBuild" AfterTargets="AfterBuild">' && \
-	 for name in $(BUILT_INS);\
-	 do \
-	   echo '    <Copy SourceFiles="$$(OutDir)\git.exe" DestinationFiles="$$(OutDir)\'"$$name"'" SkipUnchangedFiles="true" UseHardlinksIfPossible="true" />'; \
-	 done && \
-	 echo '  </Target>' && \
-	 echo '</Project>') >git/LinkOrCopyBuiltins.targets
-	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
-	 echo '  <Target Name="CopyBuiltins_AfterBuild" AfterTargets="AfterBuild">' && \
-	 for name in $(REMOTE_CURL_ALIASES); \
-	 do \
-	   echo '    <Copy SourceFiles="$$(OutDir)\'"$(REMOTE_CURL_PRIMARY)"'" DestinationFiles="$$(OutDir)\'"$$name"'" SkipUnchangedFiles="true" UseHardlinksIfPossible="true" />'; \
-	 done && \
-	 echo '  </Target>' && \
-	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
-	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
-
-	# Add generated headers
-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(GENERATED_H)
-	git add -f $(GENERATED_H)
-
-	# Add scripts
-	rm -f perl/perl.mak
-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(SCRIPT_LIB) $(SCRIPTS)
-	# Strip out the sane tool path, needed only for building
-	sed -i '/^git_broken_path_fix ".*/d' git-sh-setup
-	git add -f $(SCRIPT_LIB) $(SCRIPTS)
-
-	# Add Perl module
-	$(MAKE) $(LIB_PERL_GEN)
-	git add -f perl/build
-
-	# Add bin-wrappers, for testing
-	rm -rf bin-wrappers/
-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(test_bindir_programs)
-	# Ensure that the GIT_EXEC_PATH is a Unix-y one, and that the absolute
-	# path of the repository is not hard-coded (GIT_EXEC_PATH will be set
-	# by test-lib.sh according to the current setup)
-	sed -i -e 's/^\(GIT_EXEC_PATH\)=.*/test -n "$${\1##*:*}" ||\
-			\1="$$(cygpath -u "$$\1")"/' \
-		-e "s|'$$(pwd)|\"\$$GIT_EXEC_PATH\"'|g" bin-wrappers/*
-	# Ensure that test-* helpers find the .dll files copied to top-level
-	sed -i 's|^PATH=.*|&:"$$GIT_EXEC_PATH"|' bin-wrappers/test-*
-	# We do not want to force hard-linking builtins
-	sed -i 's|\(git\)-\([-a-z]*\)\.exe"|\1.exe" \2|g' \
-		bin-wrappers/git-{receive-pack,upload-archive}
-	git add -f $(test_bindir_programs)
-
-	# Add templates
-	$(MAKE) -C templates
-	git add -f templates/boilerplates.made templates/blt/
-
-	# Add the translated messages
-	make MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(MOFILES)
-	git add -f $(MOFILES)
-
-	# Add build options
-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 GIT-BUILD-OPTIONS
-	git add -f GIT-BUILD-OPTIONS
-
-	# Commit the whole shebang
-	git commit -m "Generate Visual Studio solution" \
-		-m "Auto-generated by \`$(MAKE)$(MAKEFLAGS) $@\`"
-- 
gitgitgadget
