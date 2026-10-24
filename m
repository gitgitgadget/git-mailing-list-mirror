Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792813700;
	b=PGOc4ZUG+JhdAys05pmeYXiqV3EaEC+0kOiCjDycSdCdaEYsV1etwoj/uF5+iisAWtIY
	 sD//UZnlBupcvAisV5JabjZt3CZ5ZbzBTvRmzmHPsim8VRLJzYqq8zqgTZFNFDm7gLQ1a
	 iatfrx8EhtUIsLCSZntOgX91DlHnGw4Y+sAChXoqinPwWw+VAvA1WMoLtAEbeXQT7MAYT
	 dX5JM8xXfKZMJ8e14UDiHseAJ4qhz84n1PEKhhvGpodj8GgUHzlziKY6c/XqTmOFM0SE+
	 XRofd+KPui/k/sCtOUa4N58fE8Y+Ls2hI7aROIuWGTXp91uawIPfZcpcPg4trmw+3MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792813700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2Tifw6UI96Z+F/LR2F4yF9+bcVE+fI3+pwOXgxSswI4=;
	b=s58lvhAuYe5LNZ7aESIEh+/dtBD/NKkU6yGTfhw4nryWN/OlnltzEELGsR+67NZvft+w
	 y4IYayd80Iy9IDWF2WNJ7gpQ081r5d1kjX+hcOG0Wz1Vmx/B7Qc3VfjtG2FpGTAaopWp5
	 30rtgciy0PXBfzGCpvxXor3cYvW8pOeBLESxmOjho1pcJqS9Verbme1XPELpP0Gw6cGSy
	 6/ZlPJz4EMrWmN0Ukxb2DdWClD8PWm0apU2mMPSfr78mAKvC4hsSSDbz38I2TKKCDLTb0
	 B7mEYfj0H+bz5bKFLIKCApDoS4afGvvp5n8uUFVdnB9Uu0VWdplA91ygjB46QoXvnJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S3QNDp7P;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486ED606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 03:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 486ED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S3QNDp7P
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14fc585291cso568515c88.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792813699; x=1793418499; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2Tifw6UI96Z+F/LR2F4yF9+bcVE+fI3+pwOXgxSswI4=;
        b=S3QNDp7PICU4+8FjCMw5Ot5Y9EnANyNzEYJtVrpO0sGTNLAPtxNl2jn4Pf5+vBUmZw
         pU4820Vp/SaTxHzUu8flnksX/2JDgUAHCrZfcMKOcYGsUUy7QspnQyVSNwAnmRP9I1LH
         iS4YPhVtNPaPGxuaT4LtOa8/pFm+fgGwG7lhDOgYtfzN8Kt/F1sCnY9wEm47P+YpPilR
         KbUMYPeUmHRBMcRlkqcCVpKCrxzYoBcQr/ta3BrGi9r2yz5V3HddkHxoTuiaFV1jBqb5
         XwFAo4C7yH0jc9U62LO/h4Mok/0G7IQkRGWTO0AAflmIerh4Q/9lUaw1evbHJ418FQvS
         GdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792813699; x=1793418499;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Tifw6UI96Z+F/LR2F4yF9+bcVE+fI3+pwOXgxSswI4=;
        b=kaEiWpeT7bxNKPJC64j3saUEy5wlRJg6/Cu1r0nqZ8X0MvxrlbrPvYhX6kUjaY0ROe
         Is7aOJT+d7UAgRFQxGVMkFJT6ntwvOmmELfuiNMLFz/6ko6HSSlSiX/CETiU9zBg4+37
         wjz6ciX4lBfAfx2jDCsVx+HxCrJihYBAu/ob6o7zjbnxwy9iS6RjBF0wjnqmitJKlpNe
         TaoRT7sM/oTftzxc9lEEfM/a4MYvAKxVIPIeYnSAgJdzMYaC7EZe23qESmLaAvofom70
         SHR2jlHJ1vWV8uOsFKW7lXsG6Kv98NGnANvJElmDEOE0I5sRPFlc91384wIRCyknEP3q
         7bKQ==
X-Gm-Message-State: AFq9FYLJJO0+AYBpJk76aMtfduXvqnY/AfC5pwEU2rmmZnLC4Qi/ar19
	6xMClO8nq4ohxzaKsGXvfOSy9hyUFZfnjwBn+OXLra+1Lh4OvRzHJ6n3fCMR66Eb
X-Gm-Gg: AYBFou2kayAra65yO7/pUQpvFHP9od/1obfCL772mtML6tB36hx0RCOvbQ7Uba5n0Ei
	GlxfVKMdXJg/6R6uHkxD6Dn/bu8mGxvTHjg2xGt+BYuNdU3/NP1EM64xCfXeWb/Hgd7XeQKGOZ7
	p66bkPcO8QZ9LV2bdZ3wIzQWOEETz1wS+sbG1Vl9TavP3EB5JLDe6sUgSxt/dOxynQUtA+i8QwC
	bQNHoMDI3yj/dceeNK2VL8EAp19PAGM8zH62dkDhZ6Z1CvFVwxpeDXTVommtWm5cvM6oCzHkHwg
	x8HgIV0pXa7rHZkdIBuYxhHWBcuIiPwSkvPmyjYAXN7O2cJNo6wz7IGKF3vOUfUEYcLkOdnKFEY
	f6ZEPBOEw/wsojAIbQGbBrrRQ9Hblbs/OQ0emuK/abRtqo0bY3p9OR/1IKnum22sDPVdzFpBuP9
	DS2GiyZn+EWSHZ/NyYAJJzzJB69pm8k1XQCLfh0FahYHBVvzVX2Wm29M96sOHQyJDNJWq2Ny1az
	c91cSwLwCbpCWXKhi8W3blB3atwKa0tSYH4orhliir3OZVl+oPEZL6OU72F
X-Received: by 2002:a05:701a:ca07:b0:144:fd7c:84fe with SMTP id a92af1059eb24-19937307669mr1539389c88.35.1792813699093;
        Fri, 23 Oct 2026 20:48:19 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.224.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm2982306c88.14.2026.10.23.20.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:48:18 -0700 (PDT)
Message-Id: <pull.2276.v3.git.1792813697888.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 24 Oct 2026 03:48:17 +0000
Subject: [PATCH v3] diff-delta: use safe integer arithmetic
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
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Replace manual multiplication and addition in create_delta_index()
with safe integer helpers (st_mult, st_add, st_add3) to prevent potential
overflows when computing memory allocation sizes.

On 32-bit platforms, struct alignment padding could cause the total
allocation size calculation to exceed 2^32, making safe integer arithmetic
necessary. Note that hsize + 1 inside st_add3() is safe from overflow
because hsize is capped at 2^26 early in the function.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

Range-diff vs v2:

 1:  14ffd630ca ! 1:  d288bfe9e3 diff-delta: use safe integer arithmetic
     @@ Commit message
          diff-delta: use safe integer arithmetic
      
          Replace manual multiplication and addition in create_delta_index()
     -    with safe integer helpers (st_mult, st_add, st_add3) to prevent
     -    overflows.
     +    with safe integer helpers (st_mult, st_add, st_add3) to prevent potential
     +    overflows when computing memory allocation sizes.
     +
     +    On 32-bit platforms, struct alignment padding could cause the total
     +    allocation size calculation to exceed 2^32, making safe integer arithmetic
     +    necessary. Note that hsize + 1 inside st_add3() is safe from overflow
     +    because hsize is capped at 2^26 early in the function.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      
     @@ diff-delta.c: struct delta_index * create_delta_index(const void *buf, size_t bu
      -	memsize = sizeof(*hash) * hsize +
      -		  sizeof(*entry) * entries;
      +	memsize = st_add(st_mult(sizeof(*hash), hsize),
     -+				st_mult(sizeof(*entry), entries));
     ++			 st_mult(sizeof(*entry), entries));
       	mem = malloc(memsize);
       	if (!mem)
       		return NULL;
     @@ diff-delta.c: struct delta_index * create_delta_index(const void *buf, size_t bu
      -		+ sizeof(*packed_hash) * (hsize+1)
      -		+ sizeof(*packed_entry) * entries;
      +	memsize = st_add3(sizeof(*index),
     -+			st_mult(sizeof(*packed_hash), hsize + 1),
     -+			st_mult(sizeof(*packed_entry), entries));
     ++			  st_mult(sizeof(*packed_hash), hsize + 1),
     ++			  st_mult(sizeof(*packed_entry), entries));
       	mem = malloc(memsize);
       	if (!mem) {
       		free(hash);


 diff-delta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7cbedeb507..efebce3aca 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*hash) * hsize +
-		  sizeof(*entry) * entries;
+	memsize = st_add(st_mult(sizeof(*hash), hsize),
+			 st_mult(sizeof(*entry), entries));
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
@@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	 * Now create the packed index in array form
 	 * rather than linked lists.
 	 */
-	memsize = sizeof(*index)
-		+ sizeof(*packed_hash) * (hsize+1)
-		+ sizeof(*packed_entry) * entries;
+	memsize = st_add3(sizeof(*index),
+			  st_mult(sizeof(*packed_hash), hsize + 1),
+			  st_mult(sizeof(*packed_entry), entries));
 	mem = malloc(memsize);
 	if (!mem) {
 		free(hash);

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
