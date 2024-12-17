Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DE1FC7CC
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456731; cv=none; b=oHmuCyo5D6rFYHVPJKEvfvCLgtEcxYhCPWR5Ox4y4Lv+USLB/2OrciDS5p9PuQHOzijr8DxldifvNa9WRcACzYJTKHhwHCXZsb9tI2S9wdfjzMBeDQO1yoNiCR95zVqFG62cobQ8XWiwPLz75O5hxSpPbgOOjQOjfkmIzvkZH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456731; c=relaxed/simple;
	bh=EbqOnR0WeSPPHuqqC9iUc+FhZRPjT7a0fCItxCrwnDk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=asR2J/ZoGM+Wga7tE5NbGMlTRHMoeZ24nuJ6Y1hVSX5vFRtmApICapjqWVL0rByymXNvF2WEGtUejuz6ltYrk1Xr3aPFI7Qn+kT8OOOfYnwkEWBkyQIClRABMq3Q2z9RpH3C8CgCECMWxyhdEa1zUYYKRmJamIt0TfrN5eYOLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi8X25PA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi8X25PA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43621d27adeso39289725e9.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456727; x=1735061527; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7QqL+BMAPchUH65wWTiYb1YjOcN45jjN13iy41PKfU=;
        b=Xi8X25PArVlbVAYiB7cAiv3CGhQD02HzgbRcTssTw0++MegJgKn6TJz86kpeokb8Z6
         bi+iS0u7SAXQ4QA2KewzrigHwRZI0NuQt48eiPeWPIlqR+6op54FAWKoXPpqwvvSzXRU
         LcYanSCcuJ5F6Cs3NR90AytMHPyDt2Bxx8+5enpWW5gpeAo14DgErq9fyyrKiZugA4CY
         IX47Gi3kVvFzaBneBXrXxn8dCEg50cJkW/Q4wDaJ0Z8YDpXUayhyc3xnoffp6KV/cm1G
         hhaY+G998Po0sNy9rD7FaCBtp5+SWG9whN0IIRDPDymNDcIUm5NCsIAXX82omC2E61FG
         J1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456727; x=1735061527;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7QqL+BMAPchUH65wWTiYb1YjOcN45jjN13iy41PKfU=;
        b=hGiL8OgXByv4MAe/ju5QJyWxRQPpTCIPgyD2kyA3gPQonvTKrPkkfqgeBpm7FFrHhN
         GGgG9xR9BxJGK5x15Be/1SCctP1DcYgVtqHXUwMl7EQvEGmVvqrwj7Yyvxgdz5ilO+Me
         frlD6o2+4/1IUhR7isgUzs9qfaQ7A0ih9CdgcNwKCwDDMHFPdDAdB4Xo5qvcDVz0ZhgL
         vtMnGpUs7lRqVYBS1OGQbemSXagc5rQe7q8t98nvCfOGnLK+yHrulWliruD+Bd9Xox3N
         nOisrR37jrtX6ce/M5EVzInVFh8wcOKKZsHr3vb5TdIXlEmPUDnf/jXBypidVImwybZ9
         hokQ==
X-Gm-Message-State: AOJu0YxbTBB9CvzEMtugrdeyeGcEv97XEbTbw4xEEqr1oE0YnExwSzxX
	+O7dAr+Tm/Cnuu9I/4oR3l1tF5O4KFvqZ9/emeOO4SJHoUlEe83qNuyx9w==
X-Gm-Gg: ASbGnct+TEef0AylEAIjiPYpvXeFXPAAJ91VAW9pVH0vnl99wQBxBEtCDCPR4nFHxA7
	s/VCcGyuUQy26bkcsEfvaZSSU0CTJqBuEYUG+CJchug6jXVO2uGS+FgtMBlIATxtdoo6FJlIjos
	0ortKQGRWAmbHDUJgea7+bPBhgr+owUy5ZTNCcwLM2SGO7z+51jEyjMYwRFVV+z9F6tBgnv6bxM
	nXKNIJkeat+l0I7zJjgdMyz8NvTiM4c0XWS4i2oLkOMgKfbXLVtHKiyJg==
X-Google-Smtp-Source: AGHT+IGl6nAAKeGVffPqnbmeCKMpgkV9X5EfU2laWFpA3OSEoVa+Y5fOcn9lP+tHCZKoUi1d5pYYnA==
X-Received: by 2002:a05:600c:4f4f:b0:436:346a:fa9b with SMTP id 5b1f17b1804b1-436346afda1mr119690705e9.20.1734456727240;
        Tue, 17 Dec 2024 09:32:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80120e8sm11906141f8f.6.2024.12.17.09.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:32:06 -0800 (PST)
Message-Id: <c539b5200a72a512c800012660ca997b35232083.1734456721.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
References: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:32:01 +0000
Subject: [PATCH 5/5] cmake/vcxproj: stop special-casing `remote-ext`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When the `vcxproj` target was introduced in `config.mak.uname` to allow
building Git with the Visual C toolchain, the `git remote-ext` command
was always executed in its dashed form. Therefore, it was impossible to
pass the test suite unless that command existed in its dashed form, and
we had to special-case this.

Later, when the `vcxproj` target got out of fashion because Visual
Studio gained native support for CMake builds, this special-casing was
copied without questioning it.

But as of 675df192c5f (transport-helper: do not run git-remote-ext etc.
in dashed form, 2020-08-26), the reason for this special-casing no
longer exists. So let's just drop it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname                    | 4 ----
 contrib/buildsystems/CMakeLists.txt | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index d5112168a4c..b12d4e168ae 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -819,10 +819,6 @@ vcxproj:
 	sed -i 's|\(git\)-\([-a-z]*\)\.exe"|\1.exe" \2|g' \
 		bin-wrappers/git-{receive-pack,upload-archive}
 	git add -f $(test_bindir_programs)
-	# remote-ext is a builtin, but invoked as if it were external
-	sed 's|receive-pack|remote-ext|g' \
-		<bin-wrappers/git-receive-pack >bin-wrappers/git-remote-ext
-	git add -f bin-wrappers/git-remote-ext
 
 	# Add templates
 	$(MAKE) -C templates
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 36f18ab2dd1..802445c1eb0 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1082,7 +1082,7 @@ endif()
 
 #wrapper scripts
 set(wrapper_scripts
-	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext scalar)
+	git git-upload-pack git-receive-pack git-upload-archive git-shell scalar)
 
 set(wrapper_test_scripts
 	test-fake-ssh test-tool)
-- 
gitgitgadget
