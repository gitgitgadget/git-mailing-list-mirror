Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3831F507
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773115448; cv=none; b=iJC+WCFMVmrXXSqEWo1rS98KnEp07jQlsjc45yHvD6Lzjn1brQ/rx8iWMhM9z/ZcFoHMveaAtnPt6FywXPSHxU6es39XYxQ0FFGweTfkHwrxcyWaauTc56+LpCPO4tMzbJvtU5qhrZfqePxo3ap9VbA4QRSfSssLa5R+o5RbwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773115448; c=relaxed/simple;
	bh=vzp79LQFyxxvoNLQGI+pNx+L5ebTW8ll5n5mtwlMOSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L5FK/9W64xk5WGP2N4zh9A/eg0kfmefVGX8YXHEa8Jh863XpbGFscSodZoQMTwQAo/sms5WkloBABUuqnVRJ/PHq4a6l1L4Ouc6uQm2mmgorK9u7Q0kWX+LGeOOW5RanIkrHe5+EGKw/8CpTvvl0hg3bX7AITcJBXfdeGnCFxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7lr3PHs; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7lr3PHs"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be26842fd5so4022688eec.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 21:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773115446; x=1773720246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oH2AkXjL2duoQg4bE6ci15UugospicNQWFpvJ/AsPA8=;
        b=e7lr3PHsoE6EsQhsuhHFnwB/pwsFiBIRg1nHXYsQ4qlcjRIeWpzcChBEItgXSxEuZN
         t64rx+zr20UnxXYGDG0sGpZ9B4MJO3xRfkqD3GTD14zr3CRx+yPt3fGNDJWC02I6gG5O
         C5gj3XZdYihYOemMJqzxs6YLSRVHKPTj6sP2+NtfCWCus5QVUE+W7X28G9KpyCxePn+7
         Sqevz4MBfF9whAOgRBgaiscNb2FdIYUxixmVAIb7NbYaX0Q9CAqUonS36ofwq+DzjHlT
         7nRV/VY1aI5gfyzkxq4g5nqexd6VqLu1wKJe00QtnFeV1fYinzxei2dB0EIBd8Ny5PtF
         msAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773115446; x=1773720246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH2AkXjL2duoQg4bE6ci15UugospicNQWFpvJ/AsPA8=;
        b=b0xnLtOKhh0xEPx4eoOj30JKMqbQPObCuZI8kaJ+9w6itCfNjWFQl0w1le1LlZ2kor
         cXfxovjkeeKwdOELwHJE1fSuBk3NvH8Hw9s7A5N8zqBnTmPXwgWU+sCr/v11C2sjbIje
         z8TRMC0xTBC8CFR9hIhQmYVkIDApGMkDky99ZkO/8MgFVO5LbYftWEcYyiYFiEqw7pbV
         ZpJAUz/Xs2mDs+HXXMN3vMdWjKzkLNh8j74e+mMtEKLbYhaFzdXBLoXsKJecxjrQJJEV
         FnugarWeFPLIlTcFcr//XoNKqHN0w8IGo/h+xSZ8IApHIa8Jmg2kgjaKwtQB2IHIjfUJ
         b9Zw==
X-Gm-Message-State: AOJu0YzDxNRmsm4EB0CwECziEpQ+3VxnoTBJZ2ks8Ln2tc1QXraBIc5W
	hM9MEgvBlz8PT8Fh13dX2WHFlpt6pdKQ1H5D3Fi53mmLJGk5BzHOCKOCCj2iiw==
X-Gm-Gg: ATEYQzx+ONnkXWbEAoFkTzsjdChVQTcVjCV5Gb/javMVBO3s+EBAEkINTmncs8U+u4t
	xxZyh10OBh9Mln03osEDDnoWGgnmWGGOXOJ6y1SbRLsxwVRzq0jB9nofBkmRO+c7Zj+k15jo7Dm
	KSa+72RlHYDbu/k3q47JH/7mXItOKd85LSV2wJ4pwYwiCAk1pSgDz2FQjjVQ8u32jXbkaoUiZke
	msGW7VkZ4INEnXlClPSGt5vV660lufIxP180GvkwzIFNFb9Gw4b+LDcV8RH0s4+0pAcERgmekmY
	H3doUA3s2JheDTv9kRu4xTmgNY1P+hLhttucwv2hXGZ35QUKrtygvJjtdDXY6ta4ZPY5PGAY94A
	GDmya1z4+NZe0EHaxR/wED7mmBFTkWs9vUDaRYxMRJHYXscvhsEPGTgtRowsssWYyO6oKEWM4EH
	VYkQwO0xdB2nWD3vPDnSnXWCg/
X-Received: by 2002:a05:693c:2c0b:b0:2be:1a8e:10bb with SMTP id 5a478bee46e88-2be7a11ac43mr848451eec.12.1773115445621;
        Mon, 09 Mar 2026 21:04:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8081:3770::36e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be7cdfc6c9sm1309885eec.23.2026.03.09.21.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 21:04:05 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] convert: constify some variables in ident_to_worktree()
Date: Mon,  9 Mar 2026 21:03:40 -0700
Message-ID: <d3447c19d83c37bf2db84ae0bf75801ef7a36cea.1773115420.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building with glibc-2.43 there is the following warnings:

    convert.c: In function ‘ident_to_worktree’:
    convert.c:1189:24: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
     1189 |                 dollar = memchr(src, '$', len);
          |                        ^
    convert.c:1212:32: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
     1212 |                         dollar = memchr(src + 3, '$', len - 3);
          |                                ^
    convert.c:1223:29: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
     1223 |                         spc = memchr(src + 4, ' ', dollar - src - 4);
          |                             ^

The "dollar" and "space" pointers are used to iterate over the const
string "src". Since they are never written to we can make them const
too.

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 convert.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index a34ec6ecdc..eae36c8a59 100644
--- a/convert.c
+++ b/convert.c
@@ -1168,7 +1168,8 @@ static int ident_to_worktree(const char *src, size_t len,
 			     struct strbuf *buf, int ident)
 {
 	struct object_id oid;
-	char *to_free = NULL, *dollar, *spc;
+	char *to_free = NULL;
+	const char *dollar, *spc;
 	int cnt;
 
 	if (!ident)
-- 
2.53.0

