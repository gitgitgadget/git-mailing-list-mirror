Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DA326D4B
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449613; cv=none; b=DFwpPyZdWI+KwbSjnnS+kFSNluCNZM/hGjidpp2Om7H5DYC/gsrF4KXX1ZjVhIWfXXD29hz5C01sOIWxZOIMH0VAQtR6NRCQY7z/hqdM+h55vEwueft6AQ04yTVGHow0tS5SW8UcdOVQ0jzFC1Q6x+DBgfra9hlJoITbO+cYls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449613; c=relaxed/simple;
	bh=VwXn94Inui7JD0HuhLToIRT4y7BXDqkw26L9epAIE3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi8gFpd18pDvbFbGdkVmlYPf7fs9VN6ClKlTm/EGhM3ICz+uUuk8RshidTwEizD0knr8s2VyFUJ5HCIUdfQv5Av7yktZruDpf4ornEWiW85kBTFthZloAbI9JovlvQ1ZNxBGKdzAzrmhxAhp0ZfTZQa7sPUDRObZgUKnqvzVe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkBn66dq; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkBn66dq"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so799621241.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449611; x=1772054411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stmOIs91mzJ9z3kpV4IR831k/l+kBAwTn+uqcqS+3JQ=;
        b=WkBn66dqxablpnA6PbPxR7yy/ToUsT5K+aRrm9mISRIfMr/FMpbxJScQabR6+cUxUz
         UFfifLKGTOBiwhiLNcmjXCH1TT4GvT0mQlmPd1OM5JSNQmVTC+JcFarTn0D035mQP/8N
         DEVklimtEvU9hqsnTq04f3xY7iddbLHLAtGcyxVIar7+sAL8bPMLA6CaLdmSvkZrXTQA
         pn/xN2jYdsHJqaOdSFbnHT87TEEhhiPTC7kJolsfx+VfEHGNJawU0vbceyEltE778UqR
         50baZUhlmJnNGyT5d06T5lYTOAJmknlrdOjrAMi58aOUuTDEHz/5b/aIvsqKV7mupLK3
         qeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449611; x=1772054411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=stmOIs91mzJ9z3kpV4IR831k/l+kBAwTn+uqcqS+3JQ=;
        b=R5iWRCCiwOmiBmcUbjhoaV+riIMVR4Nhg49yob6wjomLZXdSfgHhHxzFDiUgazuQP2
         IAPosVaObLjXI+PdtWD7tJ3Nu77gsKhjXxjEvX3eHjCTNMy72CKm0d3xAu9G+sYwvTN+
         SnL2RzpDUi7Ahp94hXKTMZmPmq+EgaN5efZh2Ga/3cjzQkWHF1jOzn5ADYOM1XvSkWX6
         14pcwjCPdquz+ATOL3/c/PiI4PUzZPTGg6sX6hjn6iY6+TeTTaCOPLKWHXJ8fc6aE1Jc
         rUuOhTsjNH5ETV5pAB6oEFOS1mud9HlilaWlbEztmLBdobz9qou1XlJk22jnp/zsXmWu
         dn+Q==
X-Gm-Message-State: AOJu0YxI/MzbeMQxE6e+Ft/XfFYi25TrK4ewm7CYT30CaoNwxtcRIjrn
	JvFHvQ/pF7mvmaLMl1dahspWcnvF2iEnuflxlAnguNcEHANMZ+58mGkYthghnA==
X-Gm-Gg: AZuq6aIP+O3fCig1a9YhD2kwJ9xH1pi6aY97HDc4bfFxe+lE6CC2awdy0TmLcTaYuYp
	domVNS5MMu6zaQEa6fpYfepL3wJ8W4/hmRF4C53H17MYgMtsvF2NQ/KD33XVIjx+yWDxzLIEkYf
	NIPqtoVoTce1+pzod5MrTZM8BgwV6AvZGkDNYCd9sRr2TNAkVBZv9YTcXowmI5O/NBeb+XXS++R
	Ueu277ARegfYaqU7sh/lGRqKn9Dl6vsfDQGzw8h9DbCW4a+nj3jzuufwHxAsCvgBj6eA49BycBx
	WF2kPUwIFFkLRBhodABJYrNF7FnPPWmCfqBCxkOUX8E9602bh2/igQwt0WoCSR18YET/m18drgA
	BZshM/bjOtFAUxRsxe8LO/nxUjT1mXg98Pt8zi/lq/eE+Kn1xuzwqQWCz17Y1CdYtyhrXqntWRn
	euQlrxJjH/yWNtQIm1ZL12BP5u7iG8FBMIkoDkY9BhYW/GR74oH+FAdmO7bxkbTN43xA==
X-Received: by 2002:a05:6102:4423:b0:5f5:259b:66e1 with SMTP id ada2fe7eead31-5fe7f157a3fmr1721379137.3.1771449610822;
        Wed, 18 Feb 2026 13:20:10 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.20.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:20:10 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 5/8] t1900: rename t1900-repo to t1900-repo-info
Date: Wed, 18 Feb 2026 18:08:41 -0300
Message-ID: <20260218211845.96009-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the commit bbb2b93348 (builtin/repo: introduce structure subcommand,
2025-10-21), t1901 specifically tests git-repo-structure. Rename
t1900-repo to t1900-repo-info to clarify that it focus solely on
git-repo-info subcommand.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 t/meson.build                           | 2 +-
 t/{t1900-repo.sh => t1900-repo-info.sh} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename t/{t1900-repo.sh => t1900-repo-info.sh} (100%)

diff --git a/t/meson.build b/t/meson.build
index f80e366cff..9867762bac 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -240,7 +240,7 @@ integration_tests = [
   't1700-split-index.sh',
   't1701-racy-split-index.sh',
   't1800-hook.sh',
-  't1900-repo.sh',
+  't1900-repo-info.sh',
   't1901-repo-structure.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
diff --git a/t/t1900-repo.sh b/t/t1900-repo-info.sh
similarity index 100%
rename from t/t1900-repo.sh
rename to t/t1900-repo-info.sh
-- 
2.50.1 (Apple Git-155)

