Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A327EFFE
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263345; cv=none; b=Bu0S0dO0Eik7PzS5CDUuhAO7VfYUesK/lAK50JElUU4KBPqy498OS5X7//ykteqeJv/Myyz5Fb4Tnsu1NCnkZnZ8VwxxzABazKy1rMSIKHuqmZ4AgFO8yfkO7+fA4EoLF0Syx+cN2X5Ljy203QVj/rEUFdzfcvB6PrdOMtpHulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263345; c=relaxed/simple;
	bh=uHneG8SU9CSwG460rg5rxedDgUGF0LSXEspM57MhRy8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MajYYmUJ4ipUuFCJpMBe+5iKtVMt7S0cGjFWPHxKb4KUgyX50eErV/EELwDHNB2bo6oEW4dgZfotzjjK2pgLFP4zm9Q9PCD952AwRIVP3g3KR58A+MuRq4bkuekIgsAu+tywMG26HSHeYYGTizdCSyJnzs43n4NKq1Mp76WkpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox9ydoKO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox9ydoKO"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77281ea2dc7so2851574b3a.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263343; x=1757868143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdScjvK+AfDQ14y9gFCV/+ytiitPCEKUvlcKkziaSgs=;
        b=Ox9ydoKOfbRMkB+9KzKiWBLMW664vcutOME79wvRmqZSg3W6OQXAxHrWOJwQoc+idB
         Dp9xNd191WPLZuE2vnHjJL7SZd6lWOAilyynZz+5+QGnBatJsfxE5i2AUil/WGod+DYE
         itXfasQa7ULj2heekA4KZ3MVTCFBKSWSg2kD3Hr+cuvO+kgdARSHbqjXy/28H5glOtH8
         oII4Zm6sITpIg628Rhfcex4jLQWc+mB+vnl0zWWRB6HMpuXleDShf6q1vsmntReWqvg/
         f3fiBsQbOi6SANa/x1lk84CekFSPaRf/y+bYLxJtlivMlCGhE7AaCbFQxQZE5mgSQwAP
         wHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263343; x=1757868143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdScjvK+AfDQ14y9gFCV/+ytiitPCEKUvlcKkziaSgs=;
        b=ZuA8woUp0IxovQ4hxE44sJzC527eEKwBUJ4jjrq4PIfBuTMy+n/ueWxsxmCkzslYV+
         /wLrZs8lqHfLqdOKvByVWtWyZ+hBKKnIHcRlcWi8pSxYoeYVPDCYCTCOmcmY9eg5+OZ4
         Het7zyBBBTfemYgYarcw8HmIxMfo/qy7WsQ6G/i4qqca2DO4bZkgOWSYaoRZJx5OGtGL
         3sr3avcNJa3Yu5swxblOso8Gwh68a8O02kF07eeMvRRsDsPkvXAveBwDLr1TJI4Z7LzA
         V3Ih6sCIVLkhlOSvLcLKxu36IQTscZLkdjoRl5flibZ+R8xONlqfAEB4S0HwDOdhAeuF
         ViMg==
X-Gm-Message-State: AOJu0YwpV6P3vruslO8v8To86TlFEjlTb7rwkMqUfaOh5sgc4XrF6GQa
	42qX9z6EePgp4ZNIRAI9JSZDgb65txh7ezWrNG//oKTY9DZ+tXHKcbJFv5JGTM9p
X-Gm-Gg: ASbGncve7akugk+EgFHxrC36HoE7XiM6ND6doFstg3ZnCza97cGQ98ByBBpN8bwp6s+
	xEEfTl5lsmEPwLBxfTHHK2K/KKB4u8BfS6fo4Nwr7ud0dYtSf3s+UoLK6LdA3vO95+zfB8FMuUO
	1cnnXaZjAW+VPUlOUUY0xnbv3d56IrwvRrLZKJ17eHaXPDS4cwkzT2dTHoiTKsVbpO/IIEqY5fo
	hwvP/7CFRAD+8zVGetNVU+B2jzmb+wKMAJK+0qwUp/Bn9GUHvI/3yLitnPJ/kT83PF8yR6Pqgc+
	21xLQLIZ2WbS2V8oY1ERxT4e/daImwlTvgzaPTy5D+o71kJyaqZqJTAIbcSwZCXMKkmr5JoybQg
	sFXw37PoiUwN3zP82lw==
X-Google-Smtp-Source: AGHT+IGeGV0TWpen0sedXDBXxUg15gfF1yfEZH3XC9cQC/2tPv6mHAdo7n+DW/N0FouRCR0r9Uk9Zg==
X-Received: by 2002:a05:6a00:b44:b0:772:5b16:1081 with SMTP id d2e1a72fcca58-7742de393a4mr6286300b3a.28.1757263342685;
        Sun, 07 Sep 2025 09:42:22 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-774208f2a1fsm7046631b3a.51.2025.09.07.09.42.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:42:21 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:42:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 1/4] string-list: allow passing NULL for `get_entry_index`
Message-ID: <aL217NTO73Xn9dJD@ArchLinux>
References: <aL21cEM0OcnrKtBW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL21cEM0OcnrKtBW@ArchLinux>

Callers of `get_entry_index()` are required to pass a non-NULL
`exact_match` parameter to receive information about whether an exact
match is found. However, in some cases, callers only need the index
position.

Let's allow callers to pass NULL for the `exact_match` parameter
when they don't need this information, reducing unnecessary variable
declarations in calling code.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 string-list.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 343cf1ca90..bf358d1a5c 100644
--- a/string-list.c
+++ b/string-list.c
@@ -29,12 +29,14 @@ static size_t get_entry_index(const struct string_list *list, const char *string
 		else if (compare > 0)
 			left = middle + 1;
 		else {
-			*exact_match = 1;
+			if (exact_match)
+				*exact_match = 1;
 			return middle;
 		}
 	}
 
-	*exact_match = 0;
+	if (exact_match)
+		*exact_match = 0;
 	return right;
 }
 
-- 
2.51.0

