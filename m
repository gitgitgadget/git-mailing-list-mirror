Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437368;
	b=ogZUQWNl0Tbkb0QNZ91ELR7PQuPCUVmc7FDt92lh9bSoyxTs0a6PqYTaFZ2MeFBneKoO
	 AMd0KMiRj7T5BEfi8gHQ5pq1HZRiWZxooDk5ug31GgkintE33UHFUL2TITJPRbnhLod/l
	 wL42F8qgvfc1DYnNY46u+PpqhYZso7oP0GVUIw8Aa3EYztswowAa3pjpkGEoEq5QPJ2uY
	 JHMHIcojlmkWMeWNX8KEj4TBgIndZ5s7YOlwTI9gmvtD5Diu8M8GRKJ1GR4HiYC0nxd6s
	 vMEaBGi3sz/uAicdJJPTEuO+YPKZv33SQdV9qthCtUnaIr/sLKDQlugM/jYbD8F92ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
	b=EQcGhCSJWgiU6v11+oR2ghq9+eh6e2QEQvrunFWVKaV+RF3w1NlNwjToNAE4J55LsLVD
	 nLz3T/ow9qLVAAH6B7KfF+8naZtaUG1QTfqbgYZ+gbAQVlWaMS8UklPr2+nsJk8lTji+s
	 M9BbuRXC0TWNaQjBcanC/3unqA9VRrUn5c8oaExrxQ3OI2koB0DFl5GhVvjTxvvS8nQeB
	 W7FKGB3bbntcBDnYjSA9ZZDZffxvBYzQbloa0HJaegg00QdkIczJ4WKL0bqc0YOv1nSYX
	 nUiGeTSLi3WEWsKYluIH+mmCmQ+UnutpeaIRSWS9elqdFZHff/Gv0CLQEW8kMFYHw4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0F82dt5;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E4606B005
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475E4606B005
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0F82dt5
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-843b6f8e2c7so3817291a34.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437367; x=1795042167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
        b=j0F82dt5SoyGeqyLIKdCTQD+f8rb8cUDwbPCfKTtqz6I+UvE02oMNDPqqQiov7CIdg
         mWwo9hqrzNddeVSDjbfnjXXnGFJ0YOAg2R92WeVt+luBVT8SxxGBFxu0+HGUqXWBMq1w
         pTWNt2TeQJXEshYK1CX8eLqssUSE4C8WJLmIr+4xBZiQKDsQuhDYp2SNFX6ypRbnweMF
         IzMDC/kKaZjUgF/Q4EMCTh1GdB/KCRd/AMsBv72XxQZ/DslkELXi9sYToKRps+lCrpwL
         lJQSEfwQo3PtyKjKtspBRfYgF3iXH/Ksjvox9Bp9fOML3EHXOz4H7sTgoYxUL/5Ptah5
         FnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437367; x=1795042167;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
        b=q0/MFC2gfsJHBc8B1Tzq8GfQK2/5tRGzGWAd9wBy7LZdVeiTnSimtn6sNn/3ZH/jK1
         zUzIES5gMrrkqnoj9stOPcWFCoAZbkrEEtYE/qIFgs5cSAc7D2eHpsXDDlznyqfnjv1Z
         dOCIKUTfjHmwHPaXH6zbHCAtmZTC2fubaZYVr6KifTd4zchMiC3Q8zJA8kc6YNq5k9VU
         y88iHi5JRcA3JsZCKr6q5j+i3ojhaxN82A/KYKeYz5mdzjiIQrVhNR0apU7X3sc+DXDu
         Df9tFpzPSs0GCmsCFEg1DWM9aescOPOSuit2H3Qa2ke8deDEL8PbGDfigLhQ5IU6XmwS
         ajxw==
X-Gm-Message-State: APuU4Z+yrjXpyyIZmMM6HSPvDxLmvZbVydK5isY9pJ3tIHE6eGdjgnPv
	w6LIsetmWuFteCwr7VwnoAsYOoTSd1YqeqgFAftlhwKtG1b85WmYUQThljVZa4lV
X-Gm-Gg: AYBFou3BoO5bfPFfVCAEQabqQgdGELu/9ppDBN7kZWFZLNHK2H9/1TwGUqOvpPYf3HE
	cbJm0FcsEUAsVdC3vlsMkNnkSmIcScHI5A/6bZTisTGvHgzJTBwvaYYfBT9/vu6X4wxCdggaFXc
	GqKNXWGTaEY441P/VqINd9dM7en5J5mLAKl0lJstTNIvyUNqoWnwOHaaSCv7UPFoNsi1JAbMASE
	vAwkIaMSf7eMPHdm0EAWewsxOrdnfYkZGjYaG2xXlTZb/k5PbgFVSsbO96bdLIDRDvLmG816Pw2
	ys90YEJdZ4KqJAkAsT/XvSH3ZbKtDoVzTE0hRzN8DZfke/zmlxXrkOYaB+K1dGeJIx08bUUt5Jk
	udssHHWJnHvH46wMbgvP+OEKOPrJ2sZKmYdcrRcZbI0ZumMEeOTKaln5OOzgemy4MA27vW0fhWB
	EmEkvi3ZMdnQIGMdyecXac6PzICmID68RZsGk1fNfRqhI7rqUgwazcRUcBYGOi2F30tTeKKyudx
	aNrtm8j39OMQnNgaKljGR99Ii58J5nkgId4IiWm7Vk3icY164VmvhwkJeyD9JL34/ot8GAW7G9s
	O0aoIWkalqOWDR9bD4BkeZoH8vst94zkCJg=
X-Received: by 2002:a05:6808:c177:b0:523:dee6:7ae0 with SMTP id 5614622812f47-56b985282b3mr3401343b6e.58.1794437367161;
        Wed, 11 Nov 2026 14:49:27 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905d3bab2sm6197297b6e.12.2026.11.11.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:25 -0800 (PST)
Message-Id: <123f03f024ce442a82a1900e03d21951e06d0cd7.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:05 +0000
Subject: [PATCH v3 05/15] grep: handle NULL value for grep.patternType
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A grep.patternType without a value makes "git grep", "git log" and
"git show" segfault: grep_config(), which all three use, passes the
NULL value to parse_pattern_type_arg(), which hands it to strcmp().

Reject a missing value with config_error_nonbool(), as grep_config()
already does for the color.grep.* slots.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 grep.c          | 2 ++
 t/t7810-grep.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/grep.c b/grep.c
index 1d75d31421..ab082f963e 100644
--- a/grep.c
+++ b/grep.c
@@ -71,6 +71,8 @@ int grep_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "grep.patterntype")) {
+		if (!value)
+			return config_error_nonbool(var);
 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
 		return 0;
 	}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index ac7ea9cf8d..d323927e54 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1551,6 +1551,11 @@ test_expect_success PCRE 'grep invalidpattern properly dies with grep.patternTyp
 	test_must_fail git -c grep.patterntype=perl grep "a["
 '
 
+test_expect_success 'grep.patternType without a value is rejected' '
+	test_must_fail git -c grep.patternType grep "a" 2>err &&
+	test_grep "missing value for .grep.patterntype." err
+'
+
 test_expect_success 'grep -G -E -F pattern' '
 	echo "ab:a+b*c" >expected &&
 	git grep -G -E -F "a+b*c" ab >actual &&
-- 
gitgitgadget

