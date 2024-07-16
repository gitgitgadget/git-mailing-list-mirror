Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8742AB9
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117045; cv=none; b=HLpsEnDaw7G/KtSPbIlk+y1trqxZ7ncglMYbT/o5IHtXDAYJacAid3GBDssrhQMWO89Fp/XtZ1QfxpmnS+B4eKgt7WriSXgzyYTU7RvVSrMhuQAFsEqjscx89GXgLu9/H7CoyqpU5nZF8Gh3yw6leqIPFd8suYcOGpOmJhMEnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117045; c=relaxed/simple;
	bh=a+QSKlYjZUY5GEo+QlCuYrxo6PIlKZFnjPbq1HiuA+4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FRD07ZoClPAnGqT4fK9mm3g8agR6o+RcG8w4HfRN7w3eLPivHspq0rj1ePLvoMmmQ0us0jk+c1FVcCjUC8VmoQgKzN67FATw0lDmsG4EHIfHWF7ILSfl86ugrn5n1cKjmsaVXtNZedljg7kqhiHyTbduziMWOjRWkhwLa2ZYlg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV4uUniz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV4uUniz"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e99060b41so5322745e87.2
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721117041; x=1721721841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5P7w3U/fCA2xgzZvLat+EoMLcMIWimRze864J0pQpGw=;
        b=MV4uUnizZGqCUE+stiMuPzSRTFtfn3nWZ/v+LJmMUstTpE4SUij5vRPDshOlAynD9x
         tupKWc4RNB/wtVrz+tlXUWW7vH1SBhuOUSj3afIkNCk/WsV0aLdbBk0ax3JVnPxQKmq1
         VbnUD0i3IP3DW4sTKBD77NewYQWxsQe9ARbFYEj5MUkL7vAcQk8unloVJ96P6z6gcGH6
         qy82/IMCNsG4z4EVACwO7m7acszqFZLfLblrM4nB28i1eXm9OoQ2YZ281mhKzHioUhP3
         /jCdetJ+bitrcKvPss5VczgNV973OX0qenp7ewIYq2PNERd2M1VBvOlHVhnQOgsNGFtv
         0vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721117041; x=1721721841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5P7w3U/fCA2xgzZvLat+EoMLcMIWimRze864J0pQpGw=;
        b=iTgnJkjchokyMRi5E9sl/g56E7sX3nbCSrU91ePdImUJjzCg896hWjhCqB4tVjepAX
         H9HkCheZGeHEJtzA+9AXmXn/uLbvpXnU1FRBpdf0e5YVGnjJW/7ckmvNkTiMY5laWxm6
         1ztQSkT6Qnugmo7HNxlu+Un8BFAcjuf/GpYQruY4306dxMyvc4vQgGWdkuQoTMh3v88f
         37vwnGb5VgvFqKStDITf+ZxNlxaHjjSIh/zyw0irdL/Q4ykZXmdx1vH6Vk8iezXaLCzt
         Jbx1aDISrKrKRzO96bqpW1owlbYT6y3U4UgN0dv3c+UTwhQVAd8tEL3mLvkse0DSA0/D
         11Mg==
X-Gm-Message-State: AOJu0YzwIVDm0+5iif7rciR7vEVm6bVQVC7tDWa8BDEdl65NUB7RNGWX
	wm0x2eXuvBMvuzpOsGMMDnoplQ06cTyFyr/0hSNXVDlo2fjfx5zn51jKjQ==
X-Google-Smtp-Source: AGHT+IHy/LkPx2ikFbMcEb7d35w4KNwJ6JF8YSyrSsZ48N8Mr9HOpf4vvPP6nPwzfrSoErs1o3W3wg==
X-Received: by 2002:a05:6512:110b:b0:52b:c0cd:7312 with SMTP id 2adb3069b0e04-52edf02ca52mr815161e87.49.1721117040844;
        Tue, 16 Jul 2024 01:04:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59eaaee1c97sm933784a12.28.2024.07.16.01.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:04:00 -0700 (PDT)
Message-Id: <pull.1744.git.git.1721117039874.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Jul 2024 08:03:59 +0000
Subject: [PATCH] Fix to avoid high memory footprint
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
Cc: Haritha  <harithamma.d@ibm.com>,
    D Harithamma <harithamma.d@ibm.com>

From: D Harithamma <harithamma.d@ibm.com>

This fix avoids high memory footprint when
adding files that require conversion.
Git has a trace_encoding routine that prints trace
output when GIT_TRACE_WORKING_TREE_ENCODING=1 is
set. This environment variable is used to debug
the encoding contents.
When a 40MB file is added, it requests close to
1.8GB of storage from xrealloc which can lead
to out of memory errors.
However, the check for
GIT_TRACE_WORKING_TREE_ENCODING is done after
the string is allocated. This resolves high
memory footprints even when
GIT_TRACE_WORKING_TREE_ENCODING is not active.
This fix adds an early exit to avoid the
unnecessary memory allocation.

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
    Fix to avoid high memory footprint
    
    This fix avoids high memory footprint when adding files that require
    conversion
    
    Git has a trace_encoding routine that prints trace output when
    GIT_TRACE_WORKING_TREE_ENCODING=1 is set. This environment variable is
    used to debug the encoding contents. When a 40MB file is added, it
    requests close to 1.8GB of storage from xrealloc which can lead to out
    of memory errors. However, the check for GIT_TRACE_WORKING_TREE_ENCODING
    is done after the string is allocated. This resolves high memory
    footprints even when GIT_TRACE_WORKING_TREE_ENCODING is not active. This
    fix adds an early exit to avoid the unnecessary memory allocation.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1744%2FHarithaIBM%2FmemFootprintFix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1744/HarithaIBM/memFootprintFix-v1
Pull-Request: https://github.com/git/git/pull/1744

 convert.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/convert.c b/convert.c
index d8737fe0f2d..e765bcd53d6 100644
--- a/convert.c
+++ b/convert.c
@@ -324,6 +324,11 @@ static void trace_encoding(const char *context, const char *path,
 	struct strbuf trace = STRBUF_INIT;
 	int i;
 
+	// If tracing is not on, exit early to avoid high memory footprint
+	if (!trace_pass_fl(&coe)) {
+		return;
+	}
+
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
 		strbuf_addf(

base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
-- 
gitgitgadget
