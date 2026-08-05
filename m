Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CD47ECDF
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946492; cv=none; b=r5l/Kf0X4LGPjWiP2IMe2ponAXziVq0N0r+o2j1F6YBd1Aq61qta1OH7Bh6v2VNzJeYw0u/+43L2f+sRYuNkF0cph7455m14hkSoGlM3L1CY6N3KtQ3dhhbvxeovDRcvq5ZN9veu48i6tdFSH4+T5+5B4agZSLFuBlbgyfA/1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946492; c=relaxed/simple;
	bh=konrPPYOT4brJInfRsJr75zeZ7egIbcXdTQ9pqVj90c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CbtcJzk71195hB/DZaIZCEn0byovGUcGvop+7Do6VtwKr42ADwtlvoM1BUDBYjEJa9+1kZNzEqxB89PdhY7W5U2Pjfqm5Pu8tL7d03jnEG1MY66oONQL60pj6QSDuKvXOsh3n0GZb9ZPv6bdic1RgT5olMlNgrAIDnH/5C1anWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQsJQ/vB; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQsJQ/vB"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb4d532e65so603642a34.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946484; x=1786551284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D/gQTFCkTLGi5bHlHRcI005NqLz1LHcSzKymkzQTM8Q=;
        b=qQsJQ/vBEcfhj+P6o/LgwYgAV5G+omTo0B3qRZHrnIeCwrxh2oETLsRuu3XkWaKuG1
         KrA38U9fWwYgxL1CXugOCg4VbR7S0hs2eaRSIS7F9RKMhe6rrk96CLd9CUIQOhQ3XK6D
         CXa/4l60q70258p97kUaA/EIop+EvENb3CcTj+ADQhHlmfohs3wovdr6UYh/bL0bGXph
         AbGwxCBu6feRQfiuO9rMZKTinp2BwyHo/XVj+1gyPhugXoVNDQqX2BD83VY+fBCirbBp
         pDzjeLnzN7F1MAnqKxw3WnIGEO+cstwRcEY1AmkkW4M4EBPbZDJLNazpgaj2b1sySA6K
         QzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946484; x=1786551284;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/gQTFCkTLGi5bHlHRcI005NqLz1LHcSzKymkzQTM8Q=;
        b=A1pf6MEzSQdrls0/j1radJQxSYGUIz/zToFIDobjv9cI+7ToYDWRByGqOcr3ITaP5+
         ya94oJcep//bfq9xOqDn7gbLaZsLlMOVti5ur11PdoW2gMpZqXxJohRVwJj7sWPp8Itf
         VVykUM5ZNImIBV+h4R+2xwuVc+oR56tN7A9N0vrnwo3gGwWC63F37QzcL8ilOoMDs2ba
         UtTpqb7cpGAzs1CQd72vu2Z+6vEFgX030st4kXWGJoY/EA8ebQPQXZWL9hjcGtsFBM27
         lLW2vA3fY+oIeU+QL73INZXZQtJmZVk4TL/jvhN2QustOYIz7/PLdeZMugj7Ii1soHX+
         mCTA==
X-Gm-Message-State: AOJu0Yw3uUSeZ1JMRVwS1kKr9xriOCym6PwCRtSWzK/bo2S480R4vn7I
	c3TIhIAw7F/E0553GNrqXzNXOeSHcBo8AgpDfryccdCjt+36gV2mgFoGJb4xcAmP
X-Gm-Gg: AR+sD11rk220Kmc93q3fonCn0i21pG+yFzLHtV4GuqH2TOHoYbcMLvv1nSopr2GID1R
	VgHl9BvYqHIUEMMKuZH2ec110hDzDwpBpjPkjLgX+JTkzBgS9zUcgxJMx7qZvJZplc2tMqiq1jQ
	YEbNTHhLR2tW2lXB86KYJV3CVlqu8pdw/PYKdeMj+R/PbFsbQLBF+M8tHkILtfb4JqzZjqv5ZdC
	TLwtNhhOTD7l51LetkS0N6ob2GWjD81Bt4T7R9b74cUArzd9jkYxIgtKQqtNPWIuHzV5rUqcfRJ
	tBv2YXi7JAnaPKctOvtbkdmb838MDNf6nYWnCZoLw394oEnBrE0pUZWxgfZe/xfZnj+Ur6a58L3
	ABxmfwO5goDOagSyQDkM9DANteshCwdJO3E1SAIdWxxXKeLDZzdagdVrLvBKZsAMy/WXZSiYB9m
	5fcmQ1VdOZrLNiL9ZWjp4IDupaZpsbu8oD22OUV3smis11aV8EXCyBKWJdfpDzW5irxQ==
X-Received: by 2002:a05:6830:838e:b0:7eb:9464:ac2e with SMTP id 46e09a7af769-7f1e5e321camr4761473a34.11.1785946484035;
        Wed, 05 Aug 2026 09:14:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df5a4f9bsm3041753a34.23.2026.08.05.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:43 -0700 (PDT)
Message-Id: <75500c5abbaf5356869f6e465925f2c397c66626.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:29 +0000
Subject: [PATCH v2 02/12] delta: widen `create_delta_index()` parameter to
 `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The sole caller (`try_delta()` in builtin/pack-objects.c) passes an
`unsigned long`, which promotes safely, so no caller fixups are needed.
Splitting it out keeps the `diff_delta()`/`create_delta()` widening,
which does ripple to several callers, in its own commit.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h      | 2 +-
 diff-delta.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/delta.h b/delta.h
index ab0279168c..12075c54c5 100644
--- a/delta.h
+++ b/delta.h
@@ -14,7 +14,7 @@ struct delta_index;
  * using free_delta_index().
  */
 struct delta_index *
-create_delta_index(const void *buf, unsigned long bufsize);
+create_delta_index(const void *buf, size_t bufsize);
 
 /*
  * free_delta_index: free the index created by create_delta_index()
diff --git a/diff-delta.c b/diff-delta.c
index 9e1f9e6f95..bcc331af3e 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -132,7 +132,7 @@ struct delta_index {
 	struct index_entry *hash[FLEX_ARRAY];
 };
 
-struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
+struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 {
 	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
 	const unsigned char *data, *buffer = buf;
-- 
gitgitgadget

