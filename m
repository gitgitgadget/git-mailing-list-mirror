Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16368F77
	for <git@vger.kernel.org>; Fri,  9 May 2025 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746756268; cv=none; b=KutDEEB9s19b40JkQemIu79J92bZazyE37m2B9SSKRutnfCtprCvwAibsyhXa4nsLo63qm1vt9j/oBEdlgK9VljtNKNWbQSV3ykMOnkQdjnOeuj/hOJ+QHls8UTUojRImG2Mu/LGQBkv0DPc94q0JXUiUuGYQmthoAFkirtl/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746756268; c=relaxed/simple;
	bh=TyBm9Bff4VORNHKf5odmVTlJYhW/cr+OdbHufk9/+Hc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k12dPf4kBB+nHP+W2Iy4ZWYoTXt+PrZyBmQP/4NmrdLFjSR8UyqmANI0c4z6G3u+FjuEY1PYxqiun5ohKqK3hTBINQoa3XDG6xCJHvO5vAbL4rKJuK53enihUj41LseLX0IMHdWb3nkjeIU+BjAygl60ulyQC4FyvSprpjSxQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtP/vBSg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtP/vBSg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b308856fso1056730f8f.2
        for <git@vger.kernel.org>; Thu, 08 May 2025 19:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746756264; x=1747361064; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKLZk7a5JwSfGeU8Zv9y5oN/I+fblcgG9tuszjwzSXI=;
        b=NtP/vBSgkGffmi+cl38v/70wx8Fy9070wyWVq2MTU+AdKCX3bq6ynvW5/7cK3ugTz/
         PPGf8xz16LfL1zR4EMZkWRiiUSrbr9IP/kpZ1Ij+tNp3HVjx0+k1HK8aOK1ROngjGfFE
         2dk2M/7dv3dFqga7B0/++XJU2/OuRs8YNzlMspWiLRVWzWCwoNZF+/0bGnAgNo19fs8f
         qahn7ambVJ0PhQBUc/iLiJ3zcQE6KZV7nKKYX2ek1dwH/+PF5p1li7aqpcGcHHLOYMvf
         jU4lFNdbcSV7USOQx0VMfxZuikHQyYe5+MQmNcA9/nELBLzzaXLRyO1u/wqXl11yrzNY
         J6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746756264; x=1747361064;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKLZk7a5JwSfGeU8Zv9y5oN/I+fblcgG9tuszjwzSXI=;
        b=a7matQjWQbWuAKAsZoV+1VYBokiY5alAJdqPgoc9qhtODkgh308YpTNwPtzFa6SE/u
         NgucNYpUp3osSe9p1gPLUrPMTkQGzU+Ck9BmRViF8rySKzxRYM6gs46BkKTG/QhxtkX0
         p/nVMvxxGx5B3wfgH+e7ud54SLwYTDZr7H581/7KGD3cje89pqpC/j0OOXZC7ClPcif7
         DjHPDJNlbhFHNR+HKy1wNbr5UqHjU0C4kVv4MlMnnYOCdYVse1u/7h/bvewEPs0pzFCd
         1ZdwkbGHa9bR3deMxzpTiSsfiEf2x576LZSlDJlnGie4A5gOSxUeaNF9BwT7k4aSgQm5
         p3PA==
X-Gm-Message-State: AOJu0YzEu186krd9uqZ+DMJqTrO7EGihbjmUVz9aMcUesT6K/XzH0FpZ
	eZImE5npbPtxau8XQdqbJ/rpPtjb7TlitQcst8UjQF+E6ZjrdFaym5gGyw==
X-Gm-Gg: ASbGncuQaqPYn9vGj5ESXvZSNWHTAkjdwpDPnBIKjsewPU4tnGArOcvO5hGvlp2ajqO
	agj8KzRafpyE5Y/dQrLX4dTQ0180RAYoQYVa/ZiWw3EaMS27sPWZtYZTnFwlc/DiEZVywD8HwF/
	uXayFTdo/9ino3jJC0PuZLOOJN470CQcEtEgrXYuuGV6L0rPOwzn329GNyif1NNruJ/MAmb/ghE
	JIdA2ueBqR/D7KL1kFOq7UJlh1hWvG8ZmMU6DqTbRYra509pte7yfpSCXCw46hBFj6z7NL2IOTO
	Jhbi/Ipl4oQqnSHWxGsh+CoZOjkijhrZq2y+mpsqRQ==
X-Google-Smtp-Source: AGHT+IFl5DATt5iVTWZw6SI0PUkwoJwG9JKtmLfr1PM7CrrOAVkYySEBjLYD0Xyd57noVEFsy3/3XA==
X-Received: by 2002:a05:6000:18ae:b0:3a0:831d:267c with SMTP id ffacd0b85a97d-3a1f6433a0bmr1382172f8f.18.1746756264251;
        Thu, 08 May 2025 19:04:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecb46sm1671837f8f.30.2025.05.08.19.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 19:04:23 -0700 (PDT)
Message-Id: <pull.1955.v2.git.git.1746756263207.gitgitgadget@gmail.com>
In-Reply-To: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
References: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 02:04:22 +0000
Subject: [PATCH v2] REFTABLE_REALLOC_ARRAY: remove this unsafe yet unused
 macro
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

REFTABLE_REALLOC_ARRAY will cause memory leak if realloc failed.
Since it is unused, remove this unsafe macro.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    REFTABLE_REALLOC_ARRAY: fix potential memory leak if realloc failed
    
    REFTABLE_REALLOC_ARRAY doesn't free origin pointer when reftable_realloc
    failed. This leak can be fixed by add a free(x) before set x to NULL.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1955%2Fbrandb97%2Ffix-REFTABLE-REALLOC-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1955/brandb97/fix-REFTABLE-REALLOC-leak-v2
Pull-Request: https://github.com/git/git/pull/1955

Range-diff vs v1:

 1:  4d786a0ec17 ! 1:  6cc191f9db8 REFTABLE_REALLOC_ARRAY: fix potential memory leak if realloc failed
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    REFTABLE_REALLOC_ARRAY: fix potential memory leak if realloc failed
     +    REFTABLE_REALLOC_ARRAY: remove this unsafe yet unused macro
      
     -    REFTABLE_REALLOC_ARRAY doesn't free origin pointer when reftable_realloc
     -    failed. This leak can be fixed by add a free(x) before set x to NULL.
     +    REFTABLE_REALLOC_ARRAY will cause memory leak if realloc failed.
     +    Since it is unused, remove this unsafe macro.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## reftable/basics.h ##
      @@ reftable/basics.h: static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
     + 			(x) = reftable_malloc(alloc_size); \
       		} \
       	} while (0)
     - #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
     +-#define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
      -#define REFTABLE_REALLOC_ARRAY(x, alloc) do { \
      -		size_t alloc_size; \
      -		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
     @@ reftable/basics.h: static inline int reftable_alloc_size(size_t nelem, size_t el
      -		} else { \
      -			(x) = reftable_realloc((x), alloc_size); \
      -		} \
     -+#define REFTABLE_REALLOC_ARRAY(x, alloc)                                      \
     -+	do {                                                                  \
     -+		size_t alloc_size;                                            \
     -+		void *new_p;                                                  \
     -+		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < \
     -+		    0) {                                                      \
     -+			goto cleanup;                                         \
     -+		} else {                                                      \
     -+			new_p = reftable_realloc((x), alloc_size);            \
     -+			if (!new_p) {                                         \
     -+				goto cleanup;                                 \
     -+			}                                                     \
     -+			(x) = new_p;                                          \
     -+		}                                                             \
     -+		break;                                                        \
     -+	cleanup:                                                              \
     -+		if (x)                                                        \
     -+			free(x);                                              \
     -+		errno = ENOMEM;                                               \
     -+		(x) = NULL;                                                   \
     - 	} while (0)
     +-	} while (0)
     ++#define REFTABLE_CALLOC_ARRAY(x, alloc) \
     ++	(x) = reftable_calloc((alloc), sizeof(*(x)))
       
       static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
     + 					size_t *allocp)


 reftable/basics.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index d8888c12629..667feffd935 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -199,16 +199,8 @@ static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
 			(x) = reftable_malloc(alloc_size); \
 		} \
 	} while (0)
-#define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
-#define REFTABLE_REALLOC_ARRAY(x, alloc) do { \
-		size_t alloc_size; \
-		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
-			errno = ENOMEM; \
-			(x) = NULL; \
-		} else { \
-			(x) = reftable_realloc((x), alloc_size); \
-		} \
-	} while (0)
+#define REFTABLE_CALLOC_ARRAY(x, alloc) \
+	(x) = reftable_calloc((alloc), sizeof(*(x)))
 
 static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 					size_t *allocp)

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
