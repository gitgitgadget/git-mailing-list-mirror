Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E2154C11
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851617; cv=none; b=o2mp1kQDYK+dDLAV2bOjqA7jqO3HfLx2mw8zHZyZGxcdrCubXU+LmUrA86Gc74Q4ba1Yxy0n1EVJwm3Qe1ip/pTmgjOJ2j4cWE7cMhtuNo1597vkK04VUPVdbNfHnM7WE0Bx6ctBZti5/rFsQwhaHUUxLPyIQ1AX4BOmfFzd6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851617; c=relaxed/simple;
	bh=2QCg20QrNOghkHNL5TcFIAJhLh7x2tK0sgMnGV4Xj7w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CCTtKPErVKoiAc5Ah5fxGkgLCK2hF5xO0/M2mA3WnjSgDMrr+60aVXybe294iXHucBmncOcmtCpTMKo2jN0w3XbRRPwU4pHT2vdy9MjiTOUoEA5S6Epkjeu7ojMK5E9oFHEjisMxHhJAhuOUugnq/ADVIWJUCrc8CEpD0VsUp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqNPjxLG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqNPjxLG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso18604695e9.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722851614; x=1723456414; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jhNfVHGCiYVxDwhFfxI60/spft26Zy+Kurv04qtNrY=;
        b=BqNPjxLGFRlJv2iJ/pAQUBeaAvmflTBdUQfVzopzw64Pos8ES2eJ5ynwo/i8BlT0pj
         X0i6SNK0C7g38C4j+hgExRj7m7wcS/2ILZ+9aiNi60JVqWcGmoc8yC36FmLSv9dWEiFt
         ovVCoXraefCWMAzP6KQqr8mGV9GwjcNRplEeZ3OWD754mu9UcVnu+nPg48T07eE/jHwq
         nZLMZ7rdpeK7NRZpLDcaj05D2Nr2QVnrZ6pIE21h5VFwieGcsv2+Pg8zwnfYlielZMXY
         Rp/Iv2+HmtZZTAkGot/+JXT9kUnSJeMMuP5BmASk7o8rAsT3YmOtODTSU8ENhJ4NdHmX
         fIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722851614; x=1723456414;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jhNfVHGCiYVxDwhFfxI60/spft26Zy+Kurv04qtNrY=;
        b=vfBKv5dIfAOgQ6/eogouISjRY8dV0Jau7vXAsKOfAU5bFdU/MRSMxmbhEmaiFLOYN+
         yYtmUpW7rZkPrT+Mw4wC7lp7GcoP6ZUyEkjd66RBsZg/HA5jd1gPRFHmThEa3enKeRV1
         AADx7JhCWTkCFJugz+Lp+j4/mhhHU0kW8++wBJ+6FsdWRrvSQ/b8mexCXeINIfIEa6tX
         ERYx971NPk0UMqRwGEMT/JS6smtDS7lSeyxEYkYBHDuiTmUtpDs++2uzcfx6lgQwV1n1
         utHO4MlKOOxSDGerSFg/srlNnkFmQb/x5VLWOrS0MxYaFoxolcpEjikzcT9vi64lV/Yz
         5uXA==
X-Gm-Message-State: AOJu0YytnP6RJ5eLcM1mbfOaAMSyjci/RhL4HVFPmEkoroNXlUD32piL
	Wf/znxH0zgujivKCdFQDreO7wM8T+Gq6JCsbbSsIaqr1rCzJ0ZeYXPooSA==
X-Google-Smtp-Source: AGHT+IH6S3TdvnFzsePzZHKYCIT2aSddL/3cnz+8MaRz6ij2xZgTMMu7PZjjy4vv6FU0CpY/AZMt0A==
X-Received: by 2002:a05:600c:1d10:b0:427:dac4:d36 with SMTP id 5b1f17b1804b1-428e6aea187mr73756865e9.7.1722851613710;
        Mon, 05 Aug 2024 02:53:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428240b3041sm173518885e9.0.2024.08.05.02.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:53:33 -0700 (PDT)
Message-Id: <pull.1757.v2.git.git.1722851612505.gitgitgadget@gmail.com>
In-Reply-To: <pull.1757.git.git.1722681471550.gitgitgadget@gmail.com>
References: <pull.1757.git.git.1722681471550.gitgitgadget@gmail.com>
From: "Sven Strickroth via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Aug 2024 09:53:32 +0000
Subject: [PATCH v2] refs/files: prevent memory leak by freeing
 packed_ref_store
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
    Sven Strickroth <email@cs-ware.de>,
    Sven Strickroth <email@cs-ware.de>

From: Sven Strickroth <email@cs-ware.de>

This complements 64a6dd8ffc (refs: implement removal of ref storages,
2024-06-06).

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
    refs/files: prevent memory leak by freeing packed_ref_store
    
    This complements "refs: implement removal of ref storages"
    (64a6dd8ffc2f).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1757%2Fcsware%2Frefs-files-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1757/csware/refs-files-v2
Pull-Request: https://github.com/git/git/pull/1757

Range-diff vs v1:

 1:  c68d0de3d58 ! 1:  96018e7257c refs/files: prevent memory leak by freeing packed_ref_store
     @@ Metadata
       ## Commit message ##
          refs/files: prevent memory leak by freeing packed_ref_store
      
     -    This complements "refs: implement removal of ref storages" (64a6dd8ffc2f).
     +    This complements 64a6dd8ffc (refs: implement removal of ref storages,
     +    2024-06-06).
      
          Signed-off-by: Sven Strickroth <email@cs-ware.de>
      


 refs/files-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa52d9be7c7..11551de8f84 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -157,6 +157,7 @@ static void files_ref_store_release(struct ref_store *ref_store)
 	free_ref_cache(refs->loose);
 	free(refs->gitcommondir);
 	ref_store_release(refs->packed_ref_store);
+	free(refs->packed_ref_store);
 }
 
 static void files_reflog_path(struct files_ref_store *refs,

base-commit: e559c4bf1a306cf5814418d318cc0fea070da3c7
-- 
gitgitgadget
