Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57B1F8EF8
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456728; cv=none; b=A7Q+mYf9LMWwyp4kbf/QwqranXNwK7JEDz0eC2BZQ+SJjpGv52gFBsoZpJGVLkbQuFl8xA3PltxE1RmwpoACNDADofVshA3rqqW7hzE/1ydbCvrXR66Dm0YAV5mqOINHn+d/bLVNrtgU6gJWDK3oW/UjEge6o+EvW7Xwlp1bPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456728; c=relaxed/simple;
	bh=P6FA2brIU34vW7hhp1bnEEGgTpm5cTf03OWRiJtK4bk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oAoazMcz+mID/py+bY1mEtr19b3l3ksAV3gLxLXeoWEXoR826AEcRgRkTOP9qtByItxi+bw9qk3q816frOvrOZX6JyoHRQaSTq3sOYfSYBUEtdRqG/7Ruhdki64EGetTzXjHzdg6a19ankszTaXt66KBecncHi8P2UKjO7c+okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck3i6ESL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck3i6ESL"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4363ae65100so32632015e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456725; x=1735061525; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UakZ+hvIcUvU724qRc20K/pSWwgLYi23Yx4m+v6xfWk=;
        b=ck3i6ESLWoonDGI1HQUlAgkdhTkt3xqTuj/rilPFaIHHe/3fsUHig2xmIS7434lhCC
         ZaUHIdIqPdAIzfX82AeIwW+c0XtuDAE0MigiqAnkwhI89JlTiNtQEfDhF6aWp+uprqzq
         WoZTQ13FkO6QNFncf8m/N+LtqAHR74VKfOqiiEksNCKcL5E1I1M4HENISSMYmOoYvbZG
         Ig+pE9tT/cM2Kjrqi8/JhSG5F7QYJz+DNuxh7zoVD2SxypTqyTgqfGxmP3T+u7+bZpVX
         RKe5dajr3ahMvwpDNu33XKlsn+YGyunS6Rlp+taxcw4vKD3QsiGErKMhIs8QOdtEfN55
         9JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456725; x=1735061525;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UakZ+hvIcUvU724qRc20K/pSWwgLYi23Yx4m+v6xfWk=;
        b=OnFFJP1wTvd0w0SlGD48VpF4hrG5B8tCLHz4CPm8LzIhsO7xfGhRP2TNNcun4HNGZf
         krzyGQLsa62LJKXXGK9I8DzMJO8ShqAOVxeauEm5672zSTBYe2PluNhWgaizAt2Kzt+W
         MFsufCpCcCIabP8J3UQ6IOGOlNilpMnIUO1rfZ/icE7nl9eg70DUH8JAxytgOEZETF7U
         ZhIM9RpEU5BUjOVGhIOls/nHtqsxYBfD7d2Wpvi1JbKId0meL2PgAsgiKErBaLpuwZ5i
         yQJTC0DMIijaL6hsh+sSRWMw1S15BbB8OTcTNkjVlGRIj6jJgSstsp4KKXvgcJ0/SLBy
         6nKA==
X-Gm-Message-State: AOJu0Yx5toYHFZ18WY1TijvY9xcC3kAVZbwmSO52U6WJWg6hvRtSX9t6
	ADDEzKcHx3AWnv/ifgi+gnU6ccKUlWuPZHVfGxCMn78VWoV4Aj6RTGB54g==
X-Gm-Gg: ASbGncuZ51Oj+Wrd0MvuGUUIzanpHnJO7k8MRTcydlQWQ2pbdl+ChzATrukr9DyQ4HN
	eZT/8boJIcyVZrdUDHJBTfOP21kCYkoiiqwijgATN96764DY1ujSF8Qh6seVkXTdE5nn+6k0Jv3
	/UCgfNrQ6edavETCqLekSGn/VlDlriZkS/CsJKuVfC0ZiMH/9uUIHMBlOjjFihW1bgmGMOQTpuX
	yHiIXbAjYEs0t8VD2BkZRlPeCiT5V5/cKMyN4K5hMcknotpH12GUORS0g==
X-Google-Smtp-Source: AGHT+IFE8MsGfSqJBXm9SJVQvzdffG0uQywC0BTKSsEh7rAQ/nnQZTW3Bl0mdyQRkKQqPaqktl47WA==
X-Received: by 2002:a05:600c:8518:b0:434:a04d:1670 with SMTP id 5b1f17b1804b1-4362a987aecmr185065525e9.0.1734456724534;
        Tue, 17 Dec 2024 09:32:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363601574bsm123057005e9.7.2024.12.17.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:32:03 -0800 (PST)
Message-Id: <1170b6d01f1a9aadd403a833650b16f9f3378e53.1734456721.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
References: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:31:58 +0000
Subject: [PATCH 2/5] cmake(mergetools): better support for out-of-tree builds
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

In 7e0730c8baa (t: better support for out-of-tree builds, 2024-12-06)
the strategy was changed from letting `t7609-mergetool--lib.sh`
hard-code the directory where it expects to find the merge tools to
hard-coding that value in the placeholder `@GIT_TEST_MERGE_TOOLS_DIR@`
that is replaced during the build.

However, likely due to a copy/paste mistake (and reviewers missed this,
too), the CMake-based build was adjusted incorrectly, replacing that
placeholder not with the path to the merge tools, but with a Boolean
indicating whether to use a runtime-generated path prefix or not.

Let's fix that, addressing this CMake-build's symptom:

  Initialized empty Git repository in D:/a/git/git/t/trash directory.t7609-mergetool--lib/.git/
  ++ . true/vimdiff
  ./test-lib.sh: line 1021: true/vimdiff: No such file or directory

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 926f0d7b86c..3dd6b3a130e 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1195,7 +1195,7 @@ string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "'${CMAKE_BINARY_DIR}/po/build/locale'
 string(REPLACE "@GIT_TEST_POPATH@" "'${CMAKE_BINARY_DIR}/po'" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_TEST_GITPERLLIB@" "'${CMAKE_BINARY_DIR}/perl/build/lib'" git_build_options "${git_build_options}")
-string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
+string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "'${CMAKE_BINARY_DIR}/mergetools'" git_build_options "${git_build_options}")
 string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
 string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
 string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
-- 
gitgitgadget

