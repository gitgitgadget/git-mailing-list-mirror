Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B73AA500
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485099; cv=none; b=RtNIF3HvrfdlskIQKfJ1nCBjgNYiPutxatn4nvsEfBr3wttexLOAY+1S6GZZs0xTfaCWZ8Y3XWsb95akyf39igNdQxLZpN4XWaRoPUWlgXvoCj1nMj/o0EujqFKT4V3IHLG3O58OHE4A50XpHhdrNP1A/bI8cJnvEllBOOP8t8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485099; c=relaxed/simple;
	bh=RrutHIW7X3zwarboUO7/ag/XMfzt44UlxI5lJTkgrqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HG5iZFOTk5ApQLEM1Hzvg1HbMpweoZerqQkuSnEvw458/1dmeQNiVEqe9Fz2ztvztQUP3ogs/fnBTTQVNECwU4gEb5w3BK1hdSnxKThcxUYhbHKFzcerkYFtJZnfCf3+rxtbfFQPD/zJQOsk8QZoeUIe7ibctmZQfNfj3nxBgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFwuXcXW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFwuXcXW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423efd76c8so2240429b3a.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780485097; x=1781089897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/KTnMAnh/QvBHkM2lRCKdG7KXSCpDVnRwszeN4NDPQ=;
        b=TFwuXcXWlQWrYm8lEsuFtKs3fYQdF348Uz+CWF2zfxsMaFAZLsx9ccX6f24EyTIfKh
         xLydMxj+1tODA2fhjwrX4IABNzhmO+64ta8RrubEpH1AyKOCLfPHKozrApHceaZC9juW
         F3E/XleINJlMEY3HWz/Api5YIO1j/94QsVG9TWYHvErDbOH0RzsMl4Aur42We3roWhKJ
         ISGOXfSbpHPHLnrW+aojE6gTXPoZkgL1c5Cp8g7HaX9Orppx8877U2LWM7qzWVTu2jrN
         vQNGIBv/7/GaGrbMuyIHDHop7IflUEtY+mIML8MYtAKPosMdES07XoYEKEGkcZa44ebo
         +6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485097; x=1781089897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/KTnMAnh/QvBHkM2lRCKdG7KXSCpDVnRwszeN4NDPQ=;
        b=lNg1iPVzHfZY5HhWwr7i3ZJysYVQbSxHk141o4li6CRNOCQxBPNG07nIkLhac4/F6U
         y8BhK1w/USaJb2+6TLHGSIVop9xyzqbfX0jR+LC+iXHqosJ4Tbq9D0/kQGXJ2Wdg7/Qo
         Cm5FhAZGRaxZUxo6YlihYkOccZbz/bGFzQRhV3W8HlCMvcIdBfO7HhPVlCjss1lmIjSS
         Tkhn5r3f8pgktv1yyhlGteJOryDCbql2xlhDsGRpAvsPb3K9GoD7VfzF1bkW+F8sH+B6
         8qmd6L1FT3USEp1I+V8DQkHFmKQCiZ+bFH+z0vk5ZKeCRlH6OHO5C+4bQ4TtkWER2u6y
         +b6w==
X-Gm-Message-State: AOJu0YxKQFAHezOonpDp+RrsX8N5/7I/7SHDzez2+xN+byhRM3D2bR9L
	/w4fN0k49NQZFlFOhsXOaN+Xu582pfTlCmItpuP9N1EQdit9HS69HBWmC9gLaA==
X-Gm-Gg: Acq92OEcbV5jA1wBGHce+7avZHaA0PByzg9z7HWvpdjL6ng65moLaYqzGCnBqvnGSY4
	ZoAxEIt5tDsytTe8fezQSKQ6OAJCqNTT9ItGlzxmc6mCxokmN0qtGkKqkHokuRMgMFBHPJMGzIr
	e7ONnAHyF8HF8Q8pgpOHRdQfmMvtENNf+GjORGllSO/IAnIGJAaXYSB6ux2/HChXAEsL1crY6ic
	3u1NrnEWfTEbqV3CPHitrcTyzwzMDrBwJ0fDv91AFThwv5evqLsKVNnxyPjQk+Cbvuo0tepXVcc
	ZMwNjcN8Gby3FLj/Gv5tLqlI2weE7PmnMLGGOse1j4vwoY0QN4dfxgb9d/eP2EqoefPBqt3J62k
	yAqpTqF5uy/gBASWv7LQ+O/7F4Udh4UlnIGsiHKAlGOruQH9MQUruvyBoHDg2I0gM1lbD8bU2b3
	U9+ADm9xteuf4t0eSUAGDjVciuCwGIFCiX7PaHFEA6pyTGwiObtljTRkvvBw6Wr77MLEKQdfqhA
	Jb/JNrzkjhkJSqd72cxbHQJkBG1+t3m5Bt5ulyBwe/f4aBI0/R12NWS6/XIxvKMAuWqdtM=
X-Received: by 2002:a05:6a00:21d6:b0:842:4387:34b7 with SMTP id d2e1a72fcca58-84284d5abbamr2737400b3a.10.1780485097477;
        Wed, 03 Jun 2026 04:11:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fa:8837:5c6c:ee92:51c2:81c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372502sm2972578b3a.16.2026.06.03.04.11.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 04:11:37 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	toon@iotcl.com,
	jn.avila@free.fr,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH 1/2] parse-options: introduce die_for_required_opt()
Date: Wed,  3 Jun 2026 16:40:43 +0530
Message-ID: <20260603111044.39116-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
References: <20260603111044.39116-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new helper function die_for_required_opt() to check if a
given option is present without its required prerequisite option.

This provides a centralized API for handling simple option dependencies
(i.e., X requires Y), matching the style of the existing mutual-exclusion
helpers like die_for_incompatible_opt{2,3,4}().

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 parse-options.c | 7 +++++++
 parse-options.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index a676da86f5..e100f9a0c1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1558,3 +1558,10 @@ void die_for_incompatible_opt4(int opt1, const char *opt1_name,
 		break;
 	}
 }
+
+void die_for_required_opt(int opt1, const char *opt1_name,
+			  int opt2, const char *opt2_name)
+{
+	if (opt1 && !opt2)
+		die(_("the option '%s' requires '%s'"), opt1_name, opt2_name);
+}
diff --git a/parse-options.h b/parse-options.h
index 0d1f738f8d..99dc53325d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -460,6 +460,9 @@ static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
 				  0, "");
 }
 
+void die_for_required_opt(int opt1, const char *opt1_name,
+			  int opt2, const char *opt2_name);
+
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
-- 
2.54.0

