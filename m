Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829733BBFAE
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833365; cv=none; b=Q+Y4xhfedIfr55YuU0r4tWFpQLbQS62Dyh+rFvmXtSpTp4gc+SxLO22eXkxoZxdvdkBMe6rsWKHBNc1GJl+jQlXpxVgYdEYnafP8PyUVdf99U6r54b/viuvXTuECTmLzyPeSiEIWcf1XaPsLirJkKhFxKs66JYYNKMP+7qz3h6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833365; c=relaxed/simple;
	bh=WckH0j2WaajshgvwYWShDWv1Aj/D0Hut7rHhcOtrv10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjPlBBnHzb/C5rpp0sdnRtWkMOA4tX/0ZQVne1pcoFIF8ncwNSA/AJM+6SBNuFLsQIRWOMHVc4BuYejWLGN5Q1t0CmiidOs2LipJN5yy/MaalR0OA6qSXsWGSwwqmxK4wIRQ1c7EPy+Nzt8aNnPXMR9ENyIIdGa7j0RTgJzL3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI29unwG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI29unwG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-46e4764ca48so4286628f8f.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833359; x=1783438159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QzpqQQOQfmtU+4Lqnvf0hLr8i+BkC66dAaimCvldFDk=;
        b=AI29unwGCSEEVsgOO+zHtfAdlOGYQFEhZfxEs3hrV6tay9A06HEZCoFRa7ldrBUHlX
         CjwJ4yf0l5+uvoPFhfnCmJNnWyevhilGjbYv/K3FcvQc4ZWRuR1F2YeYtKVTii3Xb6MR
         A/ZP8t+hnWi3j8R+n5pFcVFFjt05bDYw39NnGaTr21Fm/B+QwKbd6D6tmZc/CyNKcMjs
         39sCyOBO7c1g12/ZNEyvj06nH+f3UPW6lcnzNBQt2hctU7RkannVSdabTtcB7cyr8uli
         dSU/al7jqimYn0VLgXCuNQOk1/jIQqRIRUURkDK9xnw2Y0trDJK515X8l+KaKqyg3qM7
         yyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833359; x=1783438159;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzpqQQOQfmtU+4Lqnvf0hLr8i+BkC66dAaimCvldFDk=;
        b=joMaHCaqsZhBbdvIQwqhe7V8BSnXAezWvmuvejQxjSBsX2w66vp4YnYA9VNo7LCoRB
         wXiLHny13O2SAlDSapD2CbZx+B4Ql7t7hMtiuwZvGEXgNDM/iXU6tUtjQREw4bSJp4gL
         P184rDUNW4hZ+dirJXm/3VrrsGqsETDGGdwTMH+asR72biyjHwpLAQw1GlGB27jfQs3S
         GCdoqPJVMaugJMm95tdJFG04pyyxpGBl+KttVH4aClTaFQBbzP7tB2S51wtsXoONX84U
         r2S/a6/v5iJwf5PxbqszA9Z2+cQ5DNdPn3gzJRIKXyvtx/OLDcj6to+/fWMI35/5ayrl
         q7Yw==
X-Gm-Message-State: AOJu0YyaOjsy2+5ZrVCUY6lnugE/06gi9Ggg695/8MYZAINjuKNCFQO8
	H491FFW8RlFS7S6UrE8bMr8/55HGPbwFuJKkhEc0J2SdiV9v7fUdsourHzDXVw==
X-Gm-Gg: AfdE7cmbidqIlz1I9r9h53TvKLSDuCBW8Ip1XAT1x1YgRwe4srKbitl2sSPB6k/uaNS
	BnkrAB39WjhJKrMZTj/rHLAmylSjUVC08zl0dUMzjrHl1DJSyiL0HxlpbmfT1jtJRtU5jegSMYV
	pK9OdLh1cudV9DkE0/7zKAu5uxZwlrB+yYhb/yRbGdjnHmjLYSmM+hJrFsFPP0bWbSGUhceuP7q
	jrJoJGh8SVUPcIYydoARBRBkcZ5pGd3/VyCNKzmI2vFM+ruHW6/PZ+SGuUwWV3IAeruJHNEngPj
	fP9+JyQv1TVX6/+bTrwrrvpT2/JXxfH4S8PMgek1MBQEC0BpMFzB/XWOVv/L4leRGI/Tql+3Ie5
	YVNty6zJq+NcEIFsSuOWC/NP3/Qf3evFJeZDqaUOp48YC868PZU4Rk8gxb5EYruKhv+WOyxVF7n
	iICRlZJJzT6MTIVR8V
X-Received: by 2002:a05:6000:22c9:b0:475:a4ae:e630 with SMTP id ffacd0b85a97d-475a4aee803mr4329972f8f.37.1782833359435;
        Tue, 30 Jun 2026 08:29:19 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:19 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 05/11] sequencer: remove unnecessary "or" in pick_one_commit()
Date: Tue, 30 Jun 2026 16:28:55 +0100
Message-ID: <cb286ac70d77cdcbb644a34b2fa89663b3c443b9.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If error_with_patch(..., res, ...) succeeds then it returns "res", if
it fails then it returns -1. This means that or-ing the return value
with "res" is pointless the result is the same as the return value.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d7e439b1feb..39cbb7b6e3e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5007,9 +5007,8 @@ static int pick_one_commit(struct repository *r,
 		      oideq(&opts->squash_onto, &oid))))
 			to_amend = 1;
 
-		return res | error_with_patch(r, item->commit,
-					      arg, item->arg_len, opts,
-					      res, to_amend);
+		return error_with_patch(r, item->commit, arg, item->arg_len,
+					opts, res, to_amend);
 	}
 	return res;
 }
-- 
2.54.0.200.gfd8d68259e3

