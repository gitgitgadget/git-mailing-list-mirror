Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032F2BEC28
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205847; cv=none; b=Tqfy9gvtuAaAbXIX8hDTtYWZruCHJa/Yu8BNV4npgS+6QK0umfUk90ZGjjwXPb9eqEHmx94SEU1VIcWqsA9LSHxCzxwaBMIbHgqjTKot1CbIWI+Qn/9hOmEMdKNTa86v1A0LoQY6/H+NS/T0PluKHovgInvIKguL6c2gBq+Vdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205847; c=relaxed/simple;
	bh=KKHqPAWuWgq9Vhoc4BJDk32DrsC/tGQiUf3XmVHFwDA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fW1koilobsG7YhjVvsLYJJU5YF4cnKtStN6HJOtinmNNOgMaYF236bkvzjbker21HulbIl3Bj3Rz0kzgioT8aF7Xc3QhgSB99fb3vCoLWytBL+8IWLSwmwEcyLvtyfjMfZqd+ydd3uWDYtMIHCdfoafBE5FUuCspCG+6CqBqmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8yx52N9; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8yx52N9"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-433791d45f5so2025685ab.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205845; x=1764810645; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9VvtgYYGh6xBFKf7+LGneVxmYgR3mCYMPJw68VLazI=;
        b=k8yx52N9AR7BqjQlbhN6OVl0/gac7mzdv5L2vtrEe44iKKIZfcoyvHcx9hQeuI69TY
         D9sn0oRcV8PxpmKq7vnn5rq0rutUgbyCCWD2A+GZyR/Z/8uY5OMGXnpXLG4WsuOobEKu
         /OWlA7EEKZUaMpMmpxczuS3AO2cvaTQyz5N5pGdnUIVd6T1O0OkQgZCAIsd106ub+Ev5
         zyH/NKQH105dWevN/od1Ca15IUho5WdWAC8mqpK52wQhOp4PHDM/zmaGkGc8EKpvc2mi
         eWJcrGfaLp1K2qcsoPg+LKRrdC3w6FSlo5Jd/4sjxhm7R6soQ55HwC6y09jIQtyUf7wu
         J7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205845; x=1764810645;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9VvtgYYGh6xBFKf7+LGneVxmYgR3mCYMPJw68VLazI=;
        b=Nl2z2SXtxB1Og7gAVWeVO2vnoQ8UOOvcXn5kKiXaSenkkj2PAKmLJM84RFW09uMB7n
         1zJ8O0Sc0OXVZAxr/oPsyZ+ar4gut/dJk0QPmbENZuoWiuo7VyTDwRRkYhx23nNyg64B
         xHYljGCLlJhTIWA342Achk7wvMyATYQJGHA0mMhUKvuVXK6DASYdkWxyNGudqpCXSXQj
         9iKiVhOfZBIfFG7Bqpdai8bn6Uz5rsTjCcDkaz3VzC7sjelAB6swX7gi5lgxjSbJJXDd
         mkx3opYOPcBrjSI0vzkBtj0h2XomJ5hmvIA9iihouKQFZ/vyWotMZ+Aljal5WDq61xYM
         S+LA==
X-Gm-Message-State: AOJu0YzGKPikSTqPZvwCM2t7vfsIOowgOfRkzJFuyiX8MyitGJO8YL/L
	J9m3Zxe95YGZB8eSxIEkojUkXobmI6S5E69i3ujGPpdQUHvjLcGV4Ycx587iSg==
X-Gm-Gg: ASbGncvbNTienIJ5HfQJ6kgTwTmKMi94yvkn0nmTQvNkZFPrSLmYm5WsyKEEdo/0+ke
	UaPDXCxiPYVmb87XKk00Hc0Tzl+tkOzjs0NmJGIq/ufgA5eTNnzWzU8ZSuGq/kfGvA4/sf+FT7r
	XdLDUT/z6ziKvYr/Y/1zBp3gAAkWykrNmjpaPmbal2iMNarzIef7hJo/bA7sc8DRFE9J9XVtH1K
	SBfY+lvmVV/eZCafSWha8NI4bvCmreFMRX588In2bCVnNveadi224rlo10xXOS26zuH48vGDL68
	ATuhjbF5WIPmF//7K/WY9eng8QN6DVo89JfiOXHI7zeflAtNRmu1Uh65dW8qWzDhATTgISg/wqz
	giT2jFbo9hZPVGIugoPeUV6CKMmkhubElrfOJZ/7KvvZ5L8G9CnstwykxUQsgHG/DOLVXlTwbmn
	+MeKGIqCzg1zr83Q==
X-Google-Smtp-Source: AGHT+IGzeaETbHBdFaVkM5NTt6sI6N+PckpDS1zVyiVHaRJHLgt0gTjvt0VOmpj2iqaV6H7aYV0jNA==
X-Received: by 2002:a05:6e02:12e7:b0:434:798e:ce08 with SMTP id e9e14a558f8ab-435b9845e60mr158781045ab.1.1764205844779;
        Wed, 26 Nov 2025 17:10:44 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48efcsm8895041173.47.2025.11.26.17.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:44 -0800 (PST)
Message-Id: <66648e01e486f2c74202cb15618b95e87e6aea18.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:27 +0000
Subject: [PATCH 05/13] .gitignore: ignore /generated/
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .gitignore | 1 +
 Makefile   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 78a45cb5be..5df42eee5a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -258,3 +258,4 @@ Release/
 /contrib/buildsystems/out
 /contrib/libgit-rs/target
 /contrib/libgit-sys/target
+/generated/
diff --git a/Makefile b/Makefile
index 0aa6b3ae73..8a73afca16 100644
--- a/Makefile
+++ b/Makefile
@@ -953,7 +953,7 @@ rust-compile:
 	done
 
 rust-clean:
-	$(RM) $(RUST_LIBS) Cargo.lock
+	$(RM) $(RUST_LIBS) Cargo.lock generated/
 	cargo clean
 
 $(GIT_BUILD_DIR)/lib%.a:
-- 
gitgitgadget

