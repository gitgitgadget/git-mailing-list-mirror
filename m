Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563812135D1
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076399; cv=none; b=jWs7jJ2kAPPAx4kqsSEI+ynqHX7KGVnxD1Uj/J4DQNACYeqUsn/ufEn6hqzU6Qct+LTaxFZKtKrWBP3v1gYcqXg8f6qi6GZ7W12xV4Im9a8YSYmSkt/mhCVz1JsUZ8CZbdNIbWLsmFUSGfpUAzdH84DndA+E+bXVXGfUi0KB+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076399; c=relaxed/simple;
	bh=R1WItkH9YVM0E9Rd58nw07oh6q375nC7W+DKQjablS4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I/J+LQuwOg1DP7IBnqcAl0M4sIegPOlPhX1sSGG4pPQO8n51J0dlh2/41Dc3j4eDXMP3o2lGOTrwmGRTF/WSrcnzZ2l5h4mfjRJGJDkN4Ax9LpSkLEJKWX8t9DT5/SHeRzEJn/aWZ5Q2YltIp5ThYwpURvpgK6ABs1GgLxKU80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlqSu++Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlqSu++Z"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso6666225e9.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076395; x=1743681195; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfx1HB663QNdlmffEE8nbgk+xaZqujqLJQELnwnrWrg=;
        b=ZlqSu++ZSXCGIZ7yjsJkwflTgQy3gLJUGJgneV5X2EeHGlqflVivdjLQogu/6tR9JZ
         CVdYaZUqgVjYGAQCimn6oCIEjvSx5sxvDvLyuWrkMTNeXL624RKm/0D3ByJZnAxVhcv5
         t7Qq9clT15bjlEf5VBaIf1az6VuaZ8N/KlIR/SZvzAMod9+vNrCrDJXa54FCLjyt7Ury
         wxW9Y1zRznI0rbcCeTEcAoMuaphF9KNtESgbjFPAvFdghXnXjCDxPRidlcR2Ir5uIoGO
         U1RbkKckV9zNn9vpkyNrp9X5NuWm6wqdf86T9y6ClGruG/HtA/HLo+371tmo4vIBtFJV
         gaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076395; x=1743681195;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfx1HB663QNdlmffEE8nbgk+xaZqujqLJQELnwnrWrg=;
        b=qg5Zb50/4tVGgVWYMGB/8rFDNuII12rKqmHghg4C06t364hWPIw7/cwq84qPxoYUoY
         c8U0c425VaK1hNFV0B7N+FWX0CpRi911JCRhiF6wcwml0mZ5LakI/CkKgcEu5fI3E5lc
         /0gbotVm9vV+GD1ClUmpcoCrTx3Bp2P4OHlbNF1u836EgRrBCrVT30HB6+DvLy5kmpWs
         105WmmlcAohwM7Fq64ElzN0TxxET9sAvBV1R6JSFoHKhsayozHBeoV7EVXsM7HEjPtO1
         CwONM0Zsq54kTpR+D28G2mYVaszYPspuumhisPHnK490lcoy4xpAcxUjR/KeCDhRVtCJ
         ZY+g==
X-Gm-Message-State: AOJu0YzUuutzYzUEIAw/Dw6S/IRmY44oGdh400RLo2F13USiTMDnrXee
	9P0DU20XqBnf3J5STj2FXhtgE/ongPFtjx3Piy7cZqCR3mLxC6SMczOWzQ==
X-Gm-Gg: ASbGncsuBhbER/xdy3FEzNlp5D4Ymt7KDkg/VxWviLg+9DnLZFiiXq1c9f8a0TZUT8D
	83Sg32AxMfj6XsIy1uW1jKTKRzi8iBiBxAwdZ8aGVSu1brrdOaFyzmXtr9X7LZaOTPCZbsSUvOP
	q6Q4NMqkLzv5LPMYAc+8nSEplk4JfYAmn+M0pkuuH+txSCMbdfP4EHpwensuE2ZAq3zRd56RET0
	qbriK9+FyOipSOfmAGnAomb7iNruHH7kiwxCeGoGsBZNs1kchlm6Ld6aH3NU5hhfAw5/x87e7m2
	Pzkn/0QtjzVi2c9apfN7fYe6tgGW1k1rwKtViyOAIIDrNy1M3bys7wCJ
X-Google-Smtp-Source: AGHT+IHvj3uYwHRrJDeLQcUrkxjeLD58BwkrLJLx4x2bJvHjzdXin5qwgPwD/kXSj09mf5Xrea41uw==
X-Received: by 2002:a5d:6489:0:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-39ad177aedfmr3015579f8f.42.1743076394935;
        Thu, 27 Mar 2025 04:53:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efe851sm35187245e9.18.2025.03.27.04.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:13 -0700 (PDT)
Message-Id: <b8405f3d23734b860bd222705d498bde63136432.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:53:01 +0000
Subject: [PATCH v3 08/10] compat/regex: explicitly mark intentional use of the
 comma operator
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. That is why the
`-Wcomma` option of clang was introduced: To identify unintentional uses
of the comma operator.

In the `compat/regex/` code, the comma operator is used twice, once to
avoid surrounding two conditional statements with curly brackets, the
other one to increment two counters simultaneously in a `do ... while`
condition.

The first one is replaced with a proper conditional block, surrounded by
curly brackets.

The second one would be harder to replace because the loop contains two
`continue`s. Therefore, the second one is marked as intentional by
casting the value-to-discard to `void`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/regex/regex_internal.c | 5 ++++-
 compat/regex/regexec.c        | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index ec5cc5d2dd1..4a4f849629a 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1232,7 +1232,10 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
        is = src->nelem - 1, id = dest->nelem - 1; is >= 0 && id >= 0; )
     {
       if (dest->elems[id] == src->elems[is])
-	is--, id--;
+	{
+	  is--;
+	  id--;
+	}
       else if (dest->elems[id] < src->elems[is])
 	dest->elems[--sbase] = src->elems[is--];
       else /* if (dest->elems[id] > src->elems[is]) */
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 2eeec82f407..c08f1bbe1f5 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -2210,7 +2210,7 @@ sift_states_bkref (const re_match_context_t *mctx, re_sift_context_t *sctx,
 	  /* mctx->bkref_ents may have changed, reload the pointer.  */
 	  entry = mctx->bkref_ents + enabled_idx;
 	}
-      while (enabled_idx++, entry++->more);
+      while ((void)enabled_idx++, entry++->more);
     }
   err = REG_NOERROR;
  free_return:
-- 
gitgitgadget

