Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655531487D8
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310943; cv=none; b=mFDRtnOWhGz+NjoUaeOg0pZ7Df7ZLNNQV8I4YyZ1RGE5kgnAqtFSMaB+rGoad15IxwyhFk0BovBb9gxXcZjbhktCqLyj4ALvOu+sHaVIVNZayliYrtAFPAyxdt3rk+0wsMi72zNqZciveVDOJjl2VcfoUWmyackG74WmnmylJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310943; c=relaxed/simple;
	bh=Q2+fiFKnn4N0gvo17JzEkvcTLaTNFfyFF/zDAQz8qEc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tqy8Jdh9zl1UpPJKyBTXqILv8yHuFjWjYJBNGra6kHYTQkvcZST9wvsq5iVmtT6nwXpkbfVTYgVOcmfH5+O2HGWPUXGfth4HsgscrIqkwDTxAny1TeIt1y8QFwX44dvL+lleeFsM23zZImRMx0qYKsDJ7fPF2ONpUXDGSXC8p1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou6CVFPT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou6CVFPT"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so66204011fa.2
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 20:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722310939; x=1722915739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGUXLPav7XHJCAQN9grQGZZFqiKFzMs5cDAyApVC04Q=;
        b=Ou6CVFPThbEUZWLfWgJT9iNmltKpRZUL8BwqQuFBTCgJDcECU0f/roGh2xFm5+JRuL
         RSdJm4gUI8vRyUnlEFqAsJ5+su9w8z0tJw6jRWSwT9Eq+FCzxTR6AqMS/oo34wxc6NSQ
         /oW3HPqMtzabFcgaSI0W1E8TDbmtl+RLNxbpItbPycOh/ckl0abhxbAxo92bNXjuYOYN
         m8ENRwWzwMh35TMbwu5fS1f9saECYxD+g98zLdd9YadFxvcw0XzTtCROd7U/bqPYG4P6
         6GSsMYjI35wYe2ivCVz89+I6bgxoSb/7cK6HUmaIfMIxN8rdhszgnkOOdbbYq/2lIAuB
         5m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722310939; x=1722915739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGUXLPav7XHJCAQN9grQGZZFqiKFzMs5cDAyApVC04Q=;
        b=qs8XN87TURuTIwjQjoE5JWTpN2h5SNOocQKn9gXsj0noEPgEilVo+lmKCG4HeirPf+
         c0VWVcUizqTakZfiosDA9KAop4tNBKOBuNLmb2RdPEjzY4JTvp4ZQsRipySmSsfZKQ1i
         GqJ80H81rgG6gGjsLrkOss9GM3dk9y1ogJH/v1ab98TjYRwYsqNsEvc5xNOH0AyRbbgc
         HqFmiWkM3thYJ7Qabbqr2LMeYqbaDVovhnfeWWumaFk/i7MmHhyrh7/j71s4hquYxrMj
         aGebyn4OgkOcJap/0N34WghKwhpXBqCFU0Ql0ni5h+04B10f9W4yvsOk7RdiD39gKPla
         0PgQ==
X-Gm-Message-State: AOJu0YyTtCC0WGTQUj5qCSq61NNhYlirWM+ZGLttqaVAE98c7dPCMF0d
	kduA32E1yqalUpcl1DZTDth28za+a/WBRwVl+FQB2C3rub51qXQ+LFj4jA==
X-Google-Smtp-Source: AGHT+IF3D7n+HTa1deXmTG3lgc60Evj6ThLJenhVXyrntZo5lKerzBCd0wqa8y7Jvk0kAdnInATJZQ==
X-Received: by 2002:a2e:8911:0:b0:2ec:6639:120a with SMTP id 38308e7fff4ca-2f12ebcb021mr59694271fa.10.1722310938706;
        Mon, 29 Jul 2024 20:42:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b04e1sm6604165a12.12.2024.07.29.20.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 20:42:17 -0700 (PDT)
Message-Id: <pull.1744.v5.git.git.1722310937061.gitgitgadget@gmail.com>
In-Reply-To: <pull.1744.v4.git.git.1722002432630.gitgitgadget@gmail.com>
References: <pull.1744.v4.git.git.1722002432630.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Jul 2024 03:42:16 +0000
Subject: [PATCH v5] convert: return early when not tracing
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1744%2FHarithaIBM%2FmemFootprintFix-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1744/HarithaIBM/memFootprintFix-v5
Pull-Request: https://github.com/git/git/pull/1744

Range-diff vs v4:

 1:  50758a4fb94 ! 1:  e2518b28f1c convert: avoid high memory footprint
     @@ Metadata
      Author: D Harithamma <harithamma.d@ibm.com>
      
       ## Commit message ##
     -    convert: avoid high memory footprint
     +    convert: return early when not tracing
      
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
