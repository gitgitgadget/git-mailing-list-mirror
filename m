Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC00436354
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307516; cv=none; b=MfDo0sEivc6n6nJO7ubDpfg9F/YW2yTtNa7MxaZ+by9jqLYg4lAZbWkzl/U9AxNU1z+YyPGyHth+WWTe2SQJGYAB7HZm5uf2VF9vqX5f5sFTAXLbKgCI+OLaOuaaEs5rHN2MCS6dCFMfVJgJEr9iDgFrUecrANUkP6BnECP+MCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307516; c=relaxed/simple;
	bh=rkMqX46HmLM1K1QwuNFM+4Un7gCvbyV4dyM7nPMzkNs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TyfoN7+mI3KVndizIaE6O+cPFteG9IgSgG8Uuiit9UM8F97kOBiZZaytdk26CUeaNzteUp58odqv3JJpRkEZRlNCtAuIJobi0sjPAd1+JuQJ0wu5r7RK0j4GwZWdq3CMZFxUuiK7Y7h1S/eNJ9w3YUGsZS0/YjQjMnPbPw/eRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/4bYr2t; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/4bYr2t"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b71320f501so1777903eec.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307515; x=1770912315; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy6jw949WTjHztk/H8m+HjX5Cvsqwr9+IhQISrYmkck=;
        b=e/4bYr2tOZjtEJ1RFyrgufVdU30tVkagfuFn/CmIX1Yb+7v3z39VF8aGpMXV4bODUD
         xgSOwWn3MRXpR2EJXHvXdDMMxn+BBSn7lZ88HwYtdP8ERbZEXBrylV69Ig6iVxtW1PJW
         BbaQGijh9r/KAYrqKCrh3tYtK5A1drY4NVHiVCa+sAsfVSiILdI/RLLetbuCJdF+UMVU
         XFoHp+ctKk3i1NAE8r///Kdty4TqwwyZ5uUtGauNHOQp7bAC3XX94Mx843eW3/Dkmubd
         U0VrbU6u2ciql2lspOmyc6XwnsElm/zRpM0EMWqUBp7ZjDYE4pdU3KD/emfILtRGrIi/
         Kn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307515; x=1770912315;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hy6jw949WTjHztk/H8m+HjX5Cvsqwr9+IhQISrYmkck=;
        b=bgnl/0EIt0K31gF79HYCY2IYbE9fVyZvuLKYVky6QmWnNQZCQoQL1VSvF81+4Sc9jV
         yII3NcGOS+nEIxZ1Ooy7NoAaZp1XcWcTHhE4EnjZAztcY3BilEOpnJuyIsDrPhhidY8O
         k8a6IJ0F/GLhbOSZKs6YEOMT+MnDxC+vdOUMcTfhp1ofYdiqyUQXPqdGomzwTXp8Q+9m
         jKWss12Rm1aNCnscfC5+HyxINysw3v/KxXpSR7hyJnvmg0TdC2ueNCBwFwLtNyrvP8lx
         z8411s4DspexHD1Nlkd4yAQvozPwFGdQskqH6WmIV0yfxNmKWEKOdxQExWewW7LfWzzs
         UERg==
X-Gm-Message-State: AOJu0YyErhSKV8fNPOcRitmBR9YC33JFhXn5pNRcwRZElOz4Ixs83MjJ
	3loesh8IGvhcJDtgsckt1NjZ2Z/Eul9uREEE2LcD0YkdYRt15UvziXQUUnsNqQ==
X-Gm-Gg: AZuq6aICXR4mNffVR1MC6wKgxZ+GGXbVRUFXX0x8w6IzN8AGKMXd2rfIWvHOU2KCqo0
	ROgChh7SvUT1IMbV1JnXH1SOvw+CZaC9aZE6tRhu8EE/3EMPDrmF3kVMPIyA41vZ5M4Fr4IhhGO
	E354CLWB48Io3hiUHZPNtpw2Ld3JbA/tRUU8pfTmFa6omTfrQ47aL/9yJueb9D0T6pc+PFCoyF4
	z58CAWlRMc2VtyhZ3UO27rm77YQCzb99Q0FtSJYrlmqKtR3qxohsSgXgHOBzeGGl7OdyjbInCer
	yiKIh8Y1m0jD0o4HoblszN/GyKFVAGn6Q7FieygX0kiRJD10m+yNjUtk2mOu93XyO+eo1mTjrMD
	jU2yxoEqM+qokXQjt+5inO978N0yCELE6+dv9s7AVroy+U8oY4PrCD+ZV++1KUK83cwoPA0Cyar
	9XDmvF8uQ5oM6n2Pw=
X-Received: by 2002:a05:7301:9bc2:b0:2ae:57be:86ef with SMTP id 5a478bee46e88-2b83296f244mr3461235eec.4.1770307515150;
        Thu, 05 Feb 2026 08:05:15 -0800 (PST)
Received: from [127.0.0.1] ([172.182.194.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832fd7ae9sm3351282eec.31.2026.02.05.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 08:05:14 -0800 (PST)
Message-Id: <c786a038f31f0d3b5f612e9124e3dfb23e56a027.1770307510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Feb 2026 16:05:08 +0000
Subject: [PATCH 2/4] build: include procinfo.c impl for macOS
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

Include an implementation of trace2_collect_process_info for macOS.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 config.mak.uname                    | 2 ++
 contrib/buildsystems/CMakeLists.txt | 2 ++
 meson.build                         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..baa5018461 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -148,6 +148,8 @@ ifeq ($(uname_S),Darwin)
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
 	CSPRNG_METHOD = arc4random
 	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS = YesPlease
+	HAVE_PLATFORM_PROCINFO = YesPlease
+	COMPAT_OBJS += compat/darwin/procinfo.o
 
 	# Workaround for `gettext` being keg-only and not even being linked via
 	# `brew link --force gettext`, should be obsolete as of
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index edb0fc04ad..d489f0cada 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -274,6 +274,8 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
 	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
+elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
+	list(APPEND compat_SOURCES compat/darwin/procinfo.c)
 endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
diff --git a/meson.build b/meson.build
index 1f95a06edb..32d470e4f7 100644
--- a/meson.build
+++ b/meson.build
@@ -1292,6 +1292,8 @@ if host_machine.system() == 'linux'
   libgit_sources += 'compat/linux/procinfo.c'
 elif host_machine.system() == 'windows'
   libgit_sources += 'compat/win32/trace2_win32_process_info.c'
+elif host_machine.system() == 'darwin'
+  libgit_sources += 'compat/darwin/procinfo.c'
 else
   libgit_sources += 'compat/stub/procinfo.c'
 endif
-- 
gitgitgadget

