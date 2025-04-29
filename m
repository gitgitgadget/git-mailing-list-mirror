Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5329DB99
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926685; cv=none; b=vE816IbsuIIR6dOzqm9dh/WSP/OwV2/IF+Yb3UmsJWCwkvHxzZOwxOMVrjVsGpuh8aGHop4YfaBJUQePqAwPIGjRb9k6CG5qy3k7WPQXkPu+qnhbOrnmKdUZvw9Ys8+OwCb7180JF9GRuPfk2VT2JsEZ9UFfp//yYBTPO8im9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926685; c=relaxed/simple;
	bh=7nZ6d7ogkjAGGQp1M5Jbu12vVn0OpGw3saGqFJCyFGA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rS0L/j4hHDILFCMGuwUbThMzZtW5k/6BEg+JHwZAO6Twj+sCER4JUFmsoZqURCvtrnPNeGK3Y67m9seDdjfsn5n//HEhHbm6+dmyEScAvO+lm4w0vx6T//fsukApgAVSpMqUHOK9XIhFhOxnfkYikLX2FyO5yRn0iWyn5XvsteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpDsC7j0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpDsC7j0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ede096d73so39879075e9.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745926681; x=1746531481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvHvwCr1h+3qbSnmK1qvOg6IJ9rWVgKE+wqMfHCKKA0=;
        b=TpDsC7j0GhRTVaRCPrVUjS4ZSigM0cZpUsC7kvE/J/doyjABIKI272vFbAZqpDmNgy
         pSaD7qghZMufDD2xbV+AUjJTkN+A/wkmR4d7pr5jrLWX6WiaeHbHHvA/Hi0uKC2tnu8M
         S9gEmkQiu+si1FywKJc4mXFerKi2lku5133PbgQUhJgkUDlxANqwGOsdX1TcBQblNI6m
         oilONKX9kRcBgQEEfi6/Ncwf9KdHeqtoJSCPN5A8NdhBzbwyUDkdTMMEqGGZq4QynanT
         iBwGs+aVI5ilqJaAvabMr4g3f9clEi/U0U4ZSmLjaH6yP6Cm89+PKEmubb1XDhza45Bm
         w2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745926681; x=1746531481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvHvwCr1h+3qbSnmK1qvOg6IJ9rWVgKE+wqMfHCKKA0=;
        b=HAEYpopjN/JiRIdlsTp4hqpNv/ubRbY0boOnbFwaXf8j6lzdfoLGDdQwGp+2QVYHz7
         FYHSUbSg9dNeXJjUhqfJRsUNnKFAmzm1DgbZ9ZE7CCzjUD3SE2mnVyMsiADb1lMm29yX
         y9AR6nf7l6iyg74ocnOfSlwZdNV8t3qoamPtzM0XbJuHiHCE4m6Nd99vkvkLl+5ezXD5
         /41YBHVKUm10YZCwjKwuEm5PcEdoLFufqcJC+Knw0vTwSrSv+Zh2ND4f0vzedepWYWTS
         AAq+T6BHZFe4gvvT/CeKh2kMjasZiyPZ684b5JSwqVDmslpgtO7YAFNmgi18C1K2xNCr
         dWGg==
X-Gm-Message-State: AOJu0YzdFf8wO64F4cWuNq7Qkl4ixf6aE9wqsxXDi6zpuTMOUJG2Jh9C
	sRlxWnWxjkg9bi+z1fW4YKstSHzqlYa/A0BhRdZQptE9hH9vyZEH0wuzVw==
X-Gm-Gg: ASbGncs7lpgkCm2mg23zqDlB3Xs2ebMVrXUuGri2x/afh2Thou+1NkxMfWHMkDoB+Fd
	Xe9otxUbb5S6fmQ21oJgk/6Ey0RrqhhPAKlZS9pRnz6UVatXtjoa993bmzSNSFCmJ6RxhnJhL2D
	iyNtafq1kKuxJ9sxJl7atdb0y439gp/cBdFhx6EeZ7aZmKyZ6jjdKo5S+wQdI22ypH+YjEX1u9A
	bOHDPh1f/NlqBRtZtF/siFWmT8vtXHm9dHkhnBwhIDigTPYPcj5TAzAgI8iqmhFkxIFakGsvwEK
	yH2xxmSVAMbQAmN6W8a/rFbdpPr6Y7uVob00OxQSOw==
X-Google-Smtp-Source: AGHT+IFU7qhGa4QLb0pW9fZQIUTRNvm/8CUgyCY7A3ZBXSNL5WFJhCA4cM9j5/7nxKkGaJ+Ss06aMg==
X-Received: by 2002:a05:600c:348b:b0:43d:54a:221c with SMTP id 5b1f17b1804b1-441ac861d66mr31889875e9.18.1745926681045;
        Tue, 29 Apr 2025 04:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a2386sm190069015e9.14.2025.04.29.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:38:00 -0700 (PDT)
Message-Id: <pull.1887.v3.git.1745926679028.gitgitgadget@gmail.com>
In-Reply-To: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
References: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Apr 2025 11:37:58 +0000
Subject: [PATCH v3] diff: check range before dereferencing an array element
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Before accessing an array element at a given index, it should be
verified that the index is within the desired bounds, not afterwards,
otherwise it may not make sense to even access the array element in the
first place. This is the point of CodeQL's
`cpp/offset-use-before-range-check` rule.

This CodeQL rule unfortunately is also triggered by the
`fill_es_indent_data()` code, even though the condition `off < len - 1`
does not even need to guarantee that the offset is in bounds (`s` points
to a NUL-terminated string, for which `s[off] == '\r'` would fail before
running out of bounds).

Let's work around this rare false positive to help us use an otherwise
mostly useful tool is a worthy thing to do.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Range-check array index before access
    
    If we want to check the range of an array index, it makes much more
    sense to do it before accessing the corresponding array element, not
    afterwards.
    
    There are two more instances of this in the clar code, fixes for which I
    offer in https://github.com/clar-test/clar/pull/115.
    
    Changes since v2:
    
     * Rebased on top of js/range-check-codeql-workaround.
     * Rephrased the commit message.
    
    Changes since v1:
    
     * Clarified in the commit message of the second patch that this
       range-check technically was already right before the array access it
       wants to guard, but that it still makes sense to move that
       range-check to the beginning of the loop condition.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1887%2Fdscho%2Frange-check-array-index-before-access-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1887/dscho/range-check-array-index-before-access-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1887

Range-diff vs v2:

 1:  ddfb44ed924 ! 1:  3c6e2647863 diff: check range before dereferencing an array element
     @@ Metadata
       ## Commit message ##
          diff: check range before dereferencing an array element
      
     -    Before accessing an array element at a given index, we should make sure
     -    that the index is within the desired bounds, not afterwards, otherwise
     -    it may not make sense to even access the array element in the first
     -    place.
     +    Before accessing an array element at a given index, it should be
     +    verified that the index is within the desired bounds, not afterwards,
     +    otherwise it may not make sense to even access the array element in the
     +    first place. This is the point of CodeQL's
     +    `cpp/offset-use-before-range-check` rule.
      
     -    Pointed out by CodeQL's `cpp/offset-use-before-range-check` rule.
     +    This CodeQL rule unfortunately is also triggered by the
     +    `fill_es_indent_data()` code, even though the condition `off < len - 1`
     +    does not even need to guarantee that the offset is in bounds (`s` points
     +    to a NUL-terminated string, for which `s[off] == '\r'` would fail before
     +    running out of bounds).
     +
     +    Let's work around this rare false positive to help us use an otherwise
     +    mostly useful tool is a worthy thing to do.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 2:  73cae301293 < -:  ----------- read-cache: check range before dereferencing an array element


 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index c89c15d98e0..18ba3060460 100644
--- a/diff.c
+++ b/diff.c
@@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
 
 	/* skip any \v \f \r at start of indentation */
 	while (s[off] == '\f' || s[off] == '\v' ||
-	       (s[off] == '\r' && off < len - 1))
+	       (off < len - 1 && s[off] == '\r'))
 		off++;
 
 	/* calculate the visual width of indentation */

base-commit: 0f558141ed3b93b393151367b9569446cd24caab
-- 
gitgitgadget
