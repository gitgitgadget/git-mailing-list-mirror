Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B711DC994
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239156; cv=none; b=hnvEpD/3mf3/u7ir8mzwfZvACVTYLrnSVwDVv9lzcKVLJupo9ti+oy3Kb0mbJ9Ly1hpk51RNsv+R7ZiADyPjFaRBqjv4IDWie7BDBMi+37DRepptFhQtCfrMSqKgoOmkjXDPFzcAcrddO6ADXWolab3ulgQGWVDxJjzQyy1lwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239156; c=relaxed/simple;
	bh=sTs4kOwkKbzUA6iMhfksaZjlX/a4lp0VqmYwnoOFmCw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nx90Bfegrl0TJHyXVpRTod+t02jsWNDMJZEtCM0+SXscSdeaKDJszH+6A44axmEtilqsSGcXB2RIcy6Wd4rDLIxYg3jxQscrpas6r5zdFKZVoE/UjIpZoh2S58v3J5KJ/wg04WPI4vPTsKE/H5a7gxMXYU/Y5QAYvFCTUrK0H78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5fgACSJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5fgACSJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39ac9aea656so5007638f8f.3
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239152; x=1745843952; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA49juF+s0FpDp0EVxWh4LgqWdP7t03stnxoTZ8SwxY=;
        b=h5fgACSJK8q7X1IJjK/apaA+12s67AinbSiVCU8zbXQyDlmw2Uh0bXsBLJaNO7wlKF
         gN2w5xAca90Q6hYn2crjtwoDUYPjpvvDu685uyRcRw9VupcmMZ6NWaAWYdBPonMK3+VJ
         lFfzoye9CGUInd4V+OozalCoff2aUpi7Ap2iHJbJcHVJizQrMUhziC69v9EfMLUkX/Xc
         gPLa4DsX4ZYp/O4Mg8l+77+eZqi2ilqPFNXK9YeHRuxHwm/HgFufPjU3Wh5Gg1vF/JP5
         /Seo5R6fzD6YuzLmNNtTjvn0725AmdrnFohKpXbJOyEpd6TUGTZdbK7G+koZxrIXjaOR
         I13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239152; x=1745843952;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA49juF+s0FpDp0EVxWh4LgqWdP7t03stnxoTZ8SwxY=;
        b=CqAGJH+fi1tmwltKiBzpHphCUCb6GYejWza7O/5QzU4EyAdSMHNy9GAuCXzSHuuOAE
         RMiaBZipeGEVlMYaSo2BIP63boQhdDfopOzL6DevexxEIsIZ2njLzkRRu0irytk919kJ
         o2STOrUhQKH8QOBoCtNAv32lQN7YRTfkyV2AdAB7fS0xFyWWQALuavGjTQHZWzZkwNTY
         +b4NmmYqC3spEQ5v5vZQLNJWSdC9AUXIEFGFemcoqvmg2SlLxKOnAozMYnelFhnqYiHu
         b+aGqabXV4cP3MY2osYruzOV+qBRbnqGa9M5FbHOFNgAVQsolZJ0wtRacgovOoJkflkK
         7ikQ==
X-Gm-Message-State: AOJu0YxFv46Hy5aX3gyBvcCoOwlY/9bVT0kSatCDPxx7Jv37+ymdJo1B
	6b/P2M8IUp3eRvFKtZi8SmdwYSTxn5VvRnjaq0dHmYtnKs6N8IgRtFbzSw==
X-Gm-Gg: ASbGncuXKpW1qURKyoOY0yZqm1GwSeiSbfum6rhwPcTCeIHXIYuVU7m8dOqz6WVqY4E
	JCB6X7vxh0qC1o6UHliEwOYZvWbBAkdj1tHOOvp+1cQqh9ypw8z7Fnx13HV30WtxviRR8ahrIUZ
	Kog49DuiUfijQeiC+TfxZg1u21joUIYu4M65V+gtbFGwnP1Xcvwxbo58UAGDRBwL0wCBLYQy/OZ
	DZKXLaCjvbYOWuxjvnzrWezQdoV0eR13BZKkX+SeXB3yd7j59guwT7EE3c0yqyAS3Oz0ItR6sUI
	JBFfKh1Zelks43qnGdfrI4v+oYlkeshtWzX+pFNK8g==
X-Google-Smtp-Source: AGHT+IE+fidqi3noic+PYfDolREWnzDj7bdctufLG7sXGLkBE+/yGcAt9X7n6V2eTENZxXunaabMbQ==
X-Received: by 2002:a5d:64e7:0:b0:399:6d26:7752 with SMTP id ffacd0b85a97d-39efbad3304mr9132320f8f.38.1745239152468;
        Mon, 21 Apr 2025 05:39:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d6cd2sm131537285e9.33.2025.04.21.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:39:12 -0700 (PDT)
Message-Id: <b89f39cbac6abb23ce1f6a987dc864181af2f395.1745239150.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
From: "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 12:39:05 +0000
Subject: [PATCH 1/6] bswap.h: add support for built-in bswap functions
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Dennis Ameling <dennis@dennisameling.com>

From: Dennis Ameling <dennis@dennisameling.com>

Newer compiler versions, like GCC 10 and Clang 12, have built-in
functions for bswap32 and bswap64. This comes in handy, for example,
when targeting CLANGARM64 on Windows, which would not be supported
without this logic.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
---
 compat/bswap.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index b34054f2bd7..9e0f98e00b9 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -35,7 +35,19 @@ static inline uint64_t default_bswap64(uint64_t val)
 #undef bswap32
 #undef bswap64
 
-#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
+/**
+ * __has_builtin is available since Clang 10 and GCC 10.
+ * Below is a fallback for older compilers.
+ */
+#ifndef __has_builtin
+	#define __has_builtin(x) 0
+#endif
+
+#if __has_builtin(__builtin_bswap32) && __has_builtin(__builtin_bswap64)
+#define bswap32(x) __builtin_bswap32((x))
+#define bswap64(x) __builtin_bswap64((x))
+
+#elif defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
 
 #define bswap32 git_bswap32
 static inline uint32_t git_bswap32(uint32_t x)
-- 
gitgitgadget

