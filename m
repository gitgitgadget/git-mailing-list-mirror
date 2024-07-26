Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C7EC5
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002437; cv=none; b=uKPD6JIbSYfmYlUYqgRCbOVtfwkCzUjdwXJ+aCrWn323iDAaOSzuPE/SmH/xhaarV8cSIlbT8/YfgU/4PFb0TQ8f14jkrAO6qO0O0r3Owmj+VKBigRB7mIm+VXZ0EDw8fYaLDwIe4fN6CYZO1NUxKksr+uGLhC5mrTPq/nFmjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002437; c=relaxed/simple;
	bh=7dk12XI0Xh2hfSU8bCylooAucDb3hcZvX3O6Rsuf4pA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A4k96LECDaWE7Tkj8rZDVLxXEl5yeuZJ7gBJjQptEuHph9RU87PEQQDwh4c0emK5dTNKdiqr8IMqL5u4ZjIEY6Q2z7JZZXTB3h/IqPq20IFTs3Qv6jg902cn6ezVGTN7JukenkOXs3BKiw3zbkIlAzWGnvKGg/EVNOGWzHQ7wH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8z15ryj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8z15ryj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427db004e36so15937405e9.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722002434; x=1722607234; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkZ9lAHpH5zWaVMHVK0LOTynp4GJfGkRxabAto6usGA=;
        b=c8z15ryjFPz0V2rkV7gQrpRj+OfcQLwqbX5LB9LAUKzranF6qUQMlGht11ExsxD8bO
         UWak6ogpfk/VI8539HH3U63TPteghm3XVkRJgomc6xuM6bn/H8YGoji9jcBmf09wx+dj
         KG7NAQhQMMbcK9X//yEs7wja2FNjIGvVdaTYBBORlCkOW4z9HzJEtxbVqQROfKv77XYT
         yOXyr0895UXb+2VPjsHU0aexR6X1PQavf53xc2ZGOm3q8xCk0nPGH7pwj3RuYWVVxcg8
         ydoqbYLNXLWHftoHwvquHQZD2+pBk0QJGhf8WcYMebNFa7kBsm0tVPR23GkPg9L1VU/6
         W9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722002434; x=1722607234;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkZ9lAHpH5zWaVMHVK0LOTynp4GJfGkRxabAto6usGA=;
        b=JxYpYvb34X/1Tf33NV1QRyMIKP2DM8J1rcshf7pvKIMdSu0SrjgxrsKmSmw8IXt8wl
         vok0u6GAH9jZXx3K9d2VLy73Il8HsZnYTSJtFOOCgbmgt6kiP6l/hEpI5nOB3ZNzIv6u
         31Ahhl/Ia1GraxlfiR0MHi51M5DXZ1+zAaqDpCcmghCfL8KgVuTkYxPr4+oN9M4z4dPv
         I37LN9tb1kMHjcMQxjUjCGVxqM+77+ecP5HejQGj5LfPjfZKT6/VW1/4rFGqa2iTtKaS
         BBbvFTvH8fjOfrkN999YMLKY1m3JPcxrzPLG1dEO0tym3RQ2anwOkfii1VIf8zjJi5P2
         BPFg==
X-Gm-Message-State: AOJu0YxrSIyQ6bMRGR4Ao2iWOvGvFIOCNepnU5rEZ9/1WlA/tWIFLbGB
	K9RYHwogh6Xdvx5g9mIABVz6m1qJku4+M0wvs4P7hZ/JGn+REDt7PA/52g==
X-Google-Smtp-Source: AGHT+IFlTtVlsfLNXB0gcGstThh2LZWrp+xisgNbH8ykC/2AKPAn5kFSdn4SriS7aTzOSW1RrNp4Pw==
X-Received: by 2002:a05:600c:4ecc:b0:426:6000:565a with SMTP id 5b1f17b1804b1-428054a023fmr35546645e9.16.1722002433699;
        Fri, 26 Jul 2024 07:00:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730e5dsm80407995e9.2.2024.07.26.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:00:33 -0700 (PDT)
Message-Id: <pull.1744.v4.git.git.1722002432630.gitgitgadget@gmail.com>
In-Reply-To: <pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
References: <pull.1744.v3.git.git.1721975234873.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jul 2024 14:00:32 +0000
Subject: [PATCH v4] convert: avoid high memory footprint
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
Cc: Jeff King <peff@peff.net>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Haritha  <harithamma.d@ibm.com>,
    D Harithamma <harithamma.d@ibm.com>

From: D Harithamma <harithamma.d@ibm.com>

When Git adds a file requiring encoding conversion and tracing of encoding
conversion is not requested via the GIT_TRACE_WORKING_TREE_ENCODING
environment variable, the `trace_encoding()` function still allocates &
prepares "human readable" copies of the file contents before and after
conversion to show in the trace. This results in a high memory footprint
and increased runtime without providing any user-visible benefit.

This fix introduces an early exit from the `trace_encoding()` function
when tracing is not requested, preventing unnecessary memory allocation
and processing.

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1744%2FHarithaIBM%2FmemFootprintFix-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1744/HarithaIBM/memFootprintFix-v4
Pull-Request: https://github.com/git/git/pull/1744

Range-diff vs v3:

 1:  d864de64380 ! 1:  50758a4fb94 Fix to avoid high memory footprint
     @@ Metadata
      Author: D Harithamma <harithamma.d@ibm.com>
      
       ## Commit message ##
     -    Fix to avoid high memory footprint
     +    convert: avoid high memory footprint
      
          When Git adds a file requiring encoding conversion and tracing of encoding
          conversion is not requested via the GIT_TRACE_WORKING_TREE_ENCODING


 convert.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/convert.c b/convert.c
index d8737fe0f2d..c4ddc4de81b 100644
--- a/convert.c
+++ b/convert.c
@@ -324,6 +324,9 @@ static void trace_encoding(const char *context, const char *path,
 	struct strbuf trace = STRBUF_INIT;
 	int i;
 
+	if (!trace_want(&coe))
+		return;
+
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
 		strbuf_addf(

base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
-- 
gitgitgadget
