Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C2AD2C
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670542; cv=none; b=Lxpg4iyznZafI4O6DBVHzHnli+u18foo2FLgfkO4B44j8VRnYp/Ydazy9sQJNVsOluaAW9/jLr2pGaqZit6GJHDrApeU72wT81fWUlmSfCl8SB1VksePLSGsYgh2Z6KQCB1vapmby/s5esJa8xroMh1a79wkJqhsfmbY2Dx00U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670542; c=relaxed/simple;
	bh=yLGuHQGhAGWhyQ/E1v6affNeTK03ulMy1Jh4PAtLBSk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=d+DbLNRY/wJMWVqv2hmnesraHGfg9baZ3r3jfNvIKTC7XZdrIxO8InQVYUfsWfMiU9CtwOREscQ/VqJOOQ+Cl1jUwNUVYaGYIHdMXiNWWohglT/2zK6BvKfwtYtEqH3JbHzGec6CL7YE8JyS8tyXJUBZzVjfNyGQ0NW4V6QWNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdRUMV2n; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdRUMV2n"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a60975dc5so591247b3.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773670540; x=1774275340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B5AWo6205Ijh7vQumNwgvunH4o1nKxk9JUexina4DDw=;
        b=NdRUMV2nTW53f+bm5e30BaHGMbivgi2UIcExKLLuSWkq8wqed1T98EeN4WZret4/iB
         z41dnz8D+1PhVteTNGXejeOD99tLMpra7e1EfIpKsSWKqi0x3/diD+j1PL5QOspIh8w+
         +qNx9fOLenhaXJCSZvEqq4X5Z8u1mQFiqsGDOzhDCRAsAgajefHQ8DDVlyKdpFXxiFIA
         v77L4X03Mj9rgdbsgZ9k7YZr4BKEjXeLW+s+Fhj9tKWsrMT6926biJW7YhOq9ySUBqup
         KqS3fhY5fmWvmaayxGXTNNC61IngZjTKvgy4wa0XsYePPx6hzFOK4vROyETGPX4dFMDn
         xInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773670540; x=1774275340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5AWo6205Ijh7vQumNwgvunH4o1nKxk9JUexina4DDw=;
        b=IQdVoUdnbyQ0MWaJjVGWHz1r1Ibw/u4tevtDYJTvlNaQoGddrvo8Fn4j5kt4SLyNUd
         lD3s1BsuWhJ7hGGKbHZhGHwuYKnucMm3VYPrVtfbIQV1pQj4IwUXnt/tnenENSS/BkFD
         /SQBgtEP3wO9L2GtESGFJEsFXs6ufhXY/e0QSMrXNaJbAvttLS196XmtgOpYTXeDX5Tm
         xTIBxb+BVl/NtMQv5HXAnagyBWRYLXn+1YEwUCd7RvxC3ZCO9ymttET8+m+JLlhC0d+t
         f3qNX2enp+x6k8cLk1d2fR1IR6snJL2zV1jCX2bfo93h08Dk9epgXn9Bbe8JxbNFY64G
         OKiA==
X-Gm-Message-State: AOJu0Yz7D1JdCkwwd+Do671+GyNFoBm8NjFcku7D3VssHDmXURWhKGzY
	B/StJyr4PSj+EXFUFsj5AeGevPNgEnOZUEfPFgQesBJgPVlno5AEuWVfYa+VJQ==
X-Gm-Gg: ATEYQzwSuTW83KJ14S3C13bVQ89HpFVaAYGNZO0ffgBjSTOIQOyKq15COXqTlLPJEku
	e+vy93dZGojrNtqtQMa3/p5875Lku7CttvAq0XWmrF/TUkMvyabmH8lNlKREZpH58LNt5EoZm1k
	6BfrvfLZLNk3fAakf7l9BtUgIYSuIBKQLzL3/fTQPsaPCsoO78SwyVOi8lhx/WWrAzZ0F1Q0s9y
	uu8WxhMWhsbPCFnCq2lvHX/yOEFt5zYvpYJd80bDM1Cut73BNixL33jxn++Pv+F7vMP/BpcOUeo
	Phxmw9YgJO6mjw6VxogDEDe0cveWj8HYSIXbPSS0thn6YLqNenu4Kl6y84DLyZq6y15NNI6FLQO
	W/dbgOwLjuzIRl3f0kFHkpsmSZwrPvBtrkGOcvm0rXmcxEi0PVkasms27y1uEZyVrNvHdRCcwjF
	2VvnSH65Dz0+v5+rYFNHaktlNIig==
X-Received: by 2002:a05:690c:3612:b0:794:f3dc:a977 with SMTP id 00721157ae682-79a1c1d8f75mr127120737b3.46.1773670539489;
        Mon, 16 Mar 2026 07:15:39 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.34])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a2de73263sm39893957b3.43.2026.03.16.07.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:15:38 -0700 (PDT)
Message-Id: <pull.2069.git.1773670536808.gitgitgadget@gmail.com>
From: "Guillaume Jacob via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Mar 2026 14:15:36 +0000
Subject: [PATCH] doc: fix git grep args order in Quick Reference
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
Cc: Guillaume Jacob <guillaume@absolut-sensing.com>,
    Guillaume Jacob <guillaume@absolut-sensing.com>

From: Guillaume Jacob <guillaume@absolut-sensing.com>

The example provided has its arguments in the wrong order. The revision
should follow the pattern, and not the other way around.

Signed-off-by: Guillaume Jacob <guillaume@absolut-sensing.com>
---
    doc: fix git grep args order in Quick Reference

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2069%2Fguillaume-jcb%2Fdoc-fix-args-order-in-quick-ref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2069/guillaume-jcb/doc-fix-args-order-in-quick-ref-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2069

 Documentation/user-manual.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index 7696987117..64009baf37 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -4466,7 +4466,7 @@ $ git show		    # most recent commit
 $ git diff v2.6.15..v2.6.16 # diff between two tagged versions
 $ git diff v2.6.15..HEAD    # diff with current head
 $ git grep "foo()"	    # search working directory for "foo()"
-$ git grep v2.6.15 "foo()"  # search old tree for "foo()"
+$ git grep "foo()" v2.6.15  # search old tree for "foo()"
 $ git show v2.6.15:a.txt    # look at old version of a.txt
 -----------------------------------------------
 

base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
-- 
gitgitgadget
