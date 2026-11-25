Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640162;
	b=u++cI2TGdWJXDHQcAPGx2zm0rRzgVn5HK9hogg/ejvFdXTIADblFRde2ZunNGiw49Fil
	 AnSFZCBNIIEJM9SE6UtQUQzE4EifsTrO2oYUMegxx1akoo8cpglWdlRNq9AlXbz0wX0Hi
	 2ZGfAE1MhP1sE2LEVMth+3Rf33XQsH0RUpWypydGS6UJTtWcPkL55cVN1MzNStp2qyiPV
	 aqP+/WPxdkS+DRVG9sEkRNYhgum5zn+c6wt84qE+1hIf4uq9oB8qMh054jjPFICr8Xtjv
	 YhnDo218qbxIndUK7KntH6YnOkEvEourLc3Mmk4fH777ziNnllMCUKF1wURantpJ8jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=1Is1VTM85vqozbHTBqZAVD+fDbUf7ZpvyIwdXIMaXF8=;
	b=teevWULnPpJSBw1Mpqm2Y5G4M0o6c8YrY9ni4hKwo7Vqm+qslDaTbzIAK/VbemnxvAdd
	 aUfQnFapdBUxz0GUaM09zeSgX37sH6lJpzOP1UiPLYIrvlBeldR5BogBXFj7rkwKicxaS
	 EuEfIpPNJLJSGmFbgigpVSnClmKsdsVZr2MMP9aKBleA1F4Hpq0KEMh4RycgqHN96iVwL
	 kPeWHEcoFtLD5Su4yqOQGhA8qOKqvSqSo03PDerNUteFmI3WB8sb4Vq0REEyKFOpxs7Cp
	 LACLgmjetazejaynRn60XKfwFngzqbMq2MHSqEJfLUzRJ1z7n61LGXgvagHjgHJ/7/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AXoHfpR+;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B3606A33F
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 147B3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AXoHfpR+
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-571888655f1so2134149b6e.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795640158; x=1796244958; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1Is1VTM85vqozbHTBqZAVD+fDbUf7ZpvyIwdXIMaXF8=;
        b=AXoHfpR+nbMozsRYsUCrJMYAjJYHX9OOTRIL8LRYSAAiyweSnoGcPsyoHLddl49us6
         PEGqqiQFx3TafgjqG6HWMcisTiKrYV+joYk/M3U7xZByqPANXL7o+U+8y0XF+S1GX7Lk
         Az7Z9iGrOX+c2K0Rcm9lp6bxVlD2yy/ngplhBpXoLm74xhR3/jJD9P/i34eXRmdNK5o9
         vRGRGCbYnxP0AwacqW4/ElbNr5y/JjpVxX5wLeuv/p0trNdPnrwVqVbXJkQsHlZvGbp/
         r1TbSTFvVeGsG/1RyCKxWgXVrmuSSPqkq28vVCe+4dgjZrc5eSQzxRiaQVmRGJIIwVaA
         54/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640158; x=1796244958;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Is1VTM85vqozbHTBqZAVD+fDbUf7ZpvyIwdXIMaXF8=;
        b=ljkpeOpsaV5cDt7VHIAM/YhwwWdFTIRJpJsgnkG0A/s1Csci3Wy0yHtmcHiWvm5cS6
         6y/5QeMDCIX8Y1uHeGlqeDKUbITogn9Cj+Ka8fWT4+mPWarsavmhkHy6A9GfZFincfZF
         pxC2xqWuLZf5yeEPibxx6tg76iLvqd2ONTrGUKZLrvaIxttfGFEYgGxDYXIqcRUw1L02
         0xBJlIisW3sDlJA8M0UefINldepPIWYJze2urfYGtDqJ8RnFlpSrolCeK8Vo31XrVtbT
         JojLIR0iEp5YuV5qMjrAhgP18UlT5YRXsu0QvDy4t3PSvMN5uRA111VPmw8uvItUWUPv
         GYJQ==
X-Gm-Message-State: APuU4Z885KDxzfQBM3ZUqedaPPm+U2gQrAASv4h/bjfMM8DeGNnGDbou
	2DRjO7BjiLjVCTL8sdlt52LvEo/sXYU+vhqvdm6Id9wt5klXtw1WeE8AE3hSK2Z1
X-Gm-Gg: AZFdTZeeZZ3tAAw/IKUwFkT6ngOIX5eIUWN4SQTsPTFypUv7GLEABimVk/ke21yVkMS
	Cuy8ddldXsqDYMdoczdlXWCOPqTBAdZ62FaxwobCyeQtHC+W1Zih3X9DMPDKFASC0W9ifx56H6s
	z+7XuzdkBdAgbipu9BPzcDYET56D+I2GqMU1KLbdBEQ0TpyrCxY/a8qUCT5QODi9cPbRcYHbEu9
	DKolDXE+pImv7yBRNKyfuf4Cb57QxJf/4lUcM65bRsepHzMqVIjSC3NdOc+ehGFtBLk2joIYsiu
	engOpnMWEuZwb+FtWzKOHCCNz4AJzl7EE0+iRcrm3WDmQSlbgfcKe7RGznO6zm1Kgsgva33MMpg
	4xOvJrdJNO6HOBmqth3AZ2gvwqHO5sm7DQTwPEnzyAbq2Z8aarJuhjb8U2kaWbY9XQDu3/2Ej4d
	0ztgUeney1wM+XSZKVxHfx/ZxzNgCRvdGWmR6qbI8uV0R3YQX0KpLZPK5+FAPju4cHB4GkgYwrr
	q8GHA0+CJCebJtD7UHk4H3DqhBSxcNFDy1ynu7yPXOuKXx/FxQdG5Rmr/nGD+xgKA10VLPbUbUB
	jQZtfZ2NfvLFfXz2F01pTLD35IKL0hkk
X-Received: by 2002:a05:6808:50ac:b0:53b:f634:83b2 with SMTP id 5614622812f47-57a025f405emr20390515b6e.0.1795640158056;
        Wed, 25 Nov 2026 12:55:58 -0800 (PST)
Received: from [127.0.0.1] ([132.196.38.97])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3575f5bfsm14967667b6e.14.2026.11.25.12.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:55:56 -0800 (PST)
Message-Id: <aa2d3961b2ddff329be122c88f8ec754b5c934d0.1795640149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 20:55:46 +0000
Subject: [PATCH v3 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Simon Richter <Simon.Richter@hogyros.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `fwrite_sha1_file()` function tracks the number of bytes written
during a single invocation in an `int` variable (`posn`), even though
the buffer length `size = eltsize * nmemb` has type `size_t`. If a
caller or callback ever passed more than `INT_MAX` bytes in a single
call, `posn` could overflow and wrap negative, causing `(char *)ptr +
posn` to under-read the buffer. While curl delivers data in small
chunks in practice, matching the variable type to `size` avoids the
defect.

Pointed out by Coverity.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Assisted-by: GPT-6 Luna
Assisted-by: Claude Opus 4.6 and GPT-6.1 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index d79678d01f..2879eb3874 100644
--- a/http.c
+++ b/http.c
@@ -2848,7 +2848,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 {
 	unsigned char expn[4096];
 	size_t size = eltsize * nmemb;
-	int posn = 0;
+	size_t posn = 0;
 	struct http_object_request *freq = data;
 	struct active_request_slot *slot = freq->slot;
 
-- 
gitgitgadget

