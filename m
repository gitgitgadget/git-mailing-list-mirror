Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765E17565
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664079; cv=none; b=i/on9uVR35Xn40WDNDow7KqTcpLfrzXwvefPrboJTXu5mYIC4njLKeBJOf7i2V77Khy/UQ/SRRqkUHmt35EBhGxpnGdPQoJRWvml2mG0DemN5g1/S2Tso7U/jR1w3bG0lmYRDkOJ8+DiajA1CGSgCnQRkeUWwlt7AkoOxwi/3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664079; c=relaxed/simple;
	bh=ZJW4ckpEtXwL5ndPFJAm+ZWcpO5Qo+W42l1rQSxdmSU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xx/ZLUMe62VohyUTHZk5dh6IxkrbUXMcKdj2eIV5R8Zl9a4MieApBqolLGJwtQNt3BYT0zcWU9Is5jWQxhgO8iSIrvrAqT1S9iye1+OY2Q5pGw6wiNycLtQvYvpQMi8cMjV4loc6r+0P5kE8dLSwCeAXgSqeBo7y7sSWyIzBZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmPyIc0s; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmPyIc0s"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d476d7972aso49062111fa.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710664074; x=1711268874; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eufq1offvT1akpbn4D9+S9xIbLPmbP148jAz21uXcJk=;
        b=nmPyIc0s7XFNYH2d3qspTxHT7DCnbEDXSo1PoegZK2v/V13dnhW04dJhE6gyMuYgBB
         iZnZJO0Vsm64D4oXepT3sfkc2vDpMdA59ZJeznCbRoxCdfQSdUAUgbmSuY9eJhLskld/
         hof9R4qPikdprsyKad1Rnnd6+4P0VTSzBfCmJ/ZaBQhxkn6DySaSnzHufp0JMFy9evci
         +NFmc0QAjX1ydQJzG0Pon+ta6zAVbnoawFfrcFXk8+3WRlMdlMS78m2/P9EFl8Ywftyh
         ipojLeywQDD9lnEZMijlRbe2M9TgGsc7djfakTyd/wnanRCE5jVwV2ijmiGWNv2R+BQE
         Yqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710664074; x=1711268874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eufq1offvT1akpbn4D9+S9xIbLPmbP148jAz21uXcJk=;
        b=rTxUb6cy4V/BQtLF3pAcCv7pKkIOnhbRLmpbWcYOtuyBwyUVcddemcNpmkmAk0ERRx
         6dGHcpIewZXfVYWAghqMcByAWNKtVl/vLumWcmbYdWmMgIG7W/dOF/5YcedzFDk7sIjn
         AYGiC86ZWokkeYf+gyjLCu6c96hKSRPcfgNZvgsOmXqFrW0JXhvIZdJKWKNL07AsYA9d
         OyXtaszipceAPJ7WQSz+qDgfhVxCcrMJIYYsWePFYv0kPI/Rc9uDOTZ7O3FYO9yFUX9c
         EyD3U3IH3wZEMBjCyDNWE6RXunTBE2rdc3BrhrejFAd9gZli+vaMWuJ8dFHkjn1rJQCF
         k1yA==
X-Gm-Message-State: AOJu0YyBXtbrRJL1TCEP/3NmrXkxt0JdGk+e0LarsF3b9HTB6e2QNHZ+
	HCYTZknyRXC2WY1CoYKS369/37eGALGxA23wgASQPwR8y2YAris6IYldUup6
X-Google-Smtp-Source: AGHT+IE+iCjAqnI/ADl+zWl7oyZM6sYVmqA6BAJ3VqVWwz+cDyVA5RW4pUXOmarIBBcJHWEx2RrPXw==
X-Received: by 2002:ac2:4c15:0:b0:513:b8a5:50c5 with SMTP id t21-20020ac24c15000000b00513b8a550c5mr6679836lfq.62.1710664074244;
        Sun, 17 Mar 2024 01:27:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020adff206000000b0033cf5094fcesm7038512wro.36.2024.03.17.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 01:27:53 -0700 (PDT)
Message-ID: <615481efd70fbd7e8950bea3edca12e43a024cd8.1710664071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1690.git.1710664071.gitgitgadget@gmail.com>
References: <pull.1690.git.1710664071.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 17 Mar 2024 08:27:51 +0000
Subject: [PATCH 2/2] utf8: make utf8_strnwidth & utf8_strwidth return size_t
 instead of int
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe@proton.me>

From: Mohit Marathe <mohitmarathe@proton.me>

This patch addresses the TODO comment of changing the return types
of these functions from int to size_t.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 utf8.c | 10 +++-------
 utf8.h |  4 ++--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/utf8.c b/utf8.c
index 8ccdf684e07..050fc8b3cdf 100644
--- a/utf8.c
+++ b/utf8.c
@@ -206,7 +206,7 @@ int utf8_width(const char **start, size_t *remainder_p)
  * string, assuming that the string is utf8.  Returns strlen() instead
  * if the string does not look like a valid utf8 string.
  */
-int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
+size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 {
 	const char *orig = string;
 	size_t width = 0;
@@ -224,14 +224,10 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 			width += glyph_width;
 	}
 
-	/*
-	 * TODO: fix the interface of this function and `utf8_strwidth()` to
-	 * return `size_t` instead of `int`.
-	 */
-	return cast_size_t_to_int(string ? width : len);
+	return string ? width : len;
 }
 
-int utf8_strwidth(const char *string)
+size_t utf8_strwidth(const char *string)
 {
 	return utf8_strnwidth(string, strlen(string), 0);
 }
diff --git a/utf8.h b/utf8.h
index 35df76086a6..cae10d5ac1f 100644
--- a/utf8.h
+++ b/utf8.h
@@ -7,8 +7,8 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 size_t display_mode_esc_sequence_len(const char *s);
 int utf8_width(const char **start, size_t *remainder_p);
-int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
-int utf8_strwidth(const char *string);
+size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi);
+size_t utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 int same_encoding(const char *, const char *);
-- 
gitgitgadget
