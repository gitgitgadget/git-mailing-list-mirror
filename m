Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368D381B7
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhFvAuNm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e63cceae2so5351955e9.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 23:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705043197; x=1705647997; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OmqikqL7/lEb7iNe1mJCkDwBwaMy2FkHzS/0npkSyBw=;
        b=jhFvAuNmt52IUnOKI4vJ8auBEG5Bt4/PSBIarSPY1vYijUTPzvxmp9ymXesq5JEflz
         QjKuH+h0iWc9ghOry+g0s49/uGYMgfM/UYk/XzQraygOZMjd6AGQHtUHGbuXD/FFvSfo
         vc5ZbCIqeKe/k2IpLSud4IpJ/C86oc+goxkoLEhNajB9tOqKo4AfV80kM9D6B+fZIpWY
         1mhNU6Y/TxFGT1UOqG4AZ8Zypw4pH8Q00xvQi/95xdIstoaI/tB7KPqMPbNGEm+YLMl/
         DTPJL2k3jOW82O5NG7J8lOfI4G0r3CYuDXEVl7RiEx0gsAZ3rtJX+pwoMvyLKSmqYzei
         kqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705043197; x=1705647997;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmqikqL7/lEb7iNe1mJCkDwBwaMy2FkHzS/0npkSyBw=;
        b=ZsQvUR8IbRnysXYTgpLpjL0/04mjOeof6WRMewZ7noWhooPjWyL4+7EfVAj9tBKtN4
         /OMI12RQhzq74JbCuvLfUOLnUuN1eBIet1CWRfUzMNVYP7ZIzqRzB8mJbwYdS5E+HA66
         bGLoQX3Imvw9YdTGw4B97DFXscayM+Wle1jyg/plYFe4AINQTU+miqhNE46q7EH1o6wO
         rhzIjRU8MMuARH2sMlWpFdzJnM4O3QJqNLtye6hRcMjPzEfvLtKupupc2dDkf+bdm0cD
         QChYXxPBZzOFyzTRXoVxpj+f2GOv/e2695SC12hIcZg2+rEKk/hsnAdCYj1Kyob3NdrM
         keLw==
X-Gm-Message-State: AOJu0Yxbd3ncEGWSuJ9Ro/xNwYrEaZMaq6f5ZAkm6qnrHs0GEg7rke/v
	KwavEU+k4tgEUpsoWTsn6w41ViZ+4DY=
X-Google-Smtp-Source: AGHT+IHZW73OX1jCTBFMLQVvQqmFuTytuG+JBJDEqF6hSvY8+bju7sAEQ8SGr7/bNgzybM6FA0GFfQ==
X-Received: by 2002:a05:600c:2315:b0:40e:5600:2133 with SMTP id 21-20020a05600c231500b0040e56002133mr431035wmo.72.1705043196933;
        Thu, 11 Jan 2024 23:06:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b0040c6d559490sm4610443wmq.3.2024.01.11.23.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 23:06:36 -0800 (PST)
Message-ID: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Jan 2024 07:06:35 +0000
Subject: [PATCH] strvec: use correct member name in comments
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
Cc: Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

In d70a9eb611 (strvec: rename struct fields, 2020-07-28), we renamed the
"argv" member to "v". In the same patch we also did the following rename
in strvec.c:

    -void strvec_pushv(struct strvec *array, const char **argv)
    +void strvec_pushv(struct strvec *array, const char **items)

and it appears that this s/argv/items operation was erroneously applied
to strvec.h.

Rename "items" to "v".

Signed-off-by: Linus Arver <linusa@google.com>
---
    strvec: use correct member name in comments

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1640%2Flistx%2Ffix-strvec-typos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1640/listx/fix-strvec-typos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1640

 strvec.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/strvec.h b/strvec.h
index 9f55c8766ba..4715d3e51f8 100644
--- a/strvec.h
+++ b/strvec.h
@@ -4,8 +4,8 @@
 /**
  * The strvec API allows one to dynamically build and store
  * NULL-terminated arrays of strings. A strvec maintains the invariant that the
- * `items` member always points to a non-NULL array, and that the array is
- * always NULL-terminated at the element pointed to by `items[nr]`. This
+ * `v` member always points to a non-NULL array, and that the array is
+ * always NULL-terminated at the element pointed to by `v[nr]`. This
  * makes the result suitable for passing to functions expecting to receive
  * argv from main().
  *
@@ -22,7 +22,7 @@ extern const char *empty_strvec[];
 
 /**
  * A single array. This should be initialized by assignment from
- * `STRVEC_INIT`, or by calling `strvec_init`. The `items`
+ * `STRVEC_INIT`, or by calling `strvec_init`. The `v`
  * member contains the actual array; the `nr` member contains the
  * number of elements in the array, not including the terminating
  * NULL.
@@ -80,7 +80,7 @@ void strvec_split(struct strvec *, const char *);
 void strvec_clear(struct strvec *);
 
 /**
- * Disconnect the `items` member from the `strvec` struct and
+ * Disconnect the `v` member from the `strvec` struct and
  * return it. The caller is responsible for freeing the memory used
  * by the array, and by the strings it references. After detaching,
  * the `strvec` is in a reinitialized state and can be pushed

base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
-- 
gitgitgadget
