Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325A2135C2
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076397; cv=none; b=Rex3QYQB+xDszGGL8rrOpLPHjJE/lRijUMKoM3MREjDdfsK+v7D61Ht13tffVmTNSCyIyHyW1BSf6dOG0j5JVzXm5WHGBRm4nQmQGDTl5m5Igf8Izu+cUBDE6/hGNUNKkZY670ysxNA6l39BAbs+Z/JwnUyOU7JgKGhe4C7Gov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076397; c=relaxed/simple;
	bh=B1aAW99oK/+QbWJSRLqAHPTmfitQ/3plbQCVJRbZEN4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wr6Ur8r23Wl5V3DYve1htaR9IyEwr3SoSK/V4gQNcD8mEihtL4uUNI/pUETBnWIGtCZtSOTya9MvGgnMUaE7sJdF9vprh1b189QXbVlNkwKKQdwsmft8gHbvguJLGdhHQR28P4PM1TPzbyYLpmWkMjhiwTHvm56YTuBbtk7WEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLUGnGCR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLUGnGCR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso437873f8f.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076393; x=1743681193; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79EVsAsxPVq6Nu/hugWyos5gjVUF50gp8D4TtH5AJ2o=;
        b=mLUGnGCRZMxSwApe3gbqW5Yfsa5rHxNbCmZsuWwPuNNROfPjdzzc1VXRGiPeSEMnsy
         yn/L4XfsvyFg3CaZtt5FN0yCkVEcx2E1vCvhGr7bs+QtG0wFu5nsTgMhVba8wMRquNzQ
         4aTgEybOqnPUEOkFEzLkb1Zt/dVUd29Uf/NYcaKkDd42/7/rSInqYrNZJPIPKZ8PN0vf
         YZoUQ31meDIMa5K9de+yzex+2w5VbZxYGH22C3zdsvGkkfTIKHev2kglJc1JhEWGdGmx
         YWo7hzfH2XzB+T8VKCiJyAmfdLbmRe2ygNpBVEaEVD6OH239FTDidU47RabRbqzrUtxE
         oY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076393; x=1743681193;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79EVsAsxPVq6Nu/hugWyos5gjVUF50gp8D4TtH5AJ2o=;
        b=VowOfMoxl18pCHpWSkS6kXMEtEYqWYEbgEJPpqW/gHynd7I7neDzSodKaESkplWBXM
         aWSrB1nFjqr3tTjN96+Ksh6Fc5o7rlZ2GP4hkIMshH176tKwOLGqY9GwXcMJB7ETYVK/
         jpzT+JWqwWcTsCE7qbyz1MCaFUdUaVIpgMjsfHDyOUUV3OhN6Um/zaTysuZe9emCoRlL
         K21coHpNDepgvH18jY0siFKsDhO41aVLxV6QdjWGzavOibwIUt25UulT6XGJdQG9ovhg
         3jf+yNpmGXKyR3/An7ekc8ngjOBQ0Agn0c+3cgkXVDqHxOgt+wDd/eKfXwA7TbQHmMqf
         fFiA==
X-Gm-Message-State: AOJu0YyOGuC7hMRcdkWxfVJdyzKwEy0LmtBJe2x5839aHyYFUZZC7xlx
	VvVb0P5dd4AkaoV2T28zMPuR9Pk50pONYTlzr2qLiN9q/3ZbrfoXFSXPrg==
X-Gm-Gg: ASbGncueZ68MxpOFkSx+WHq19iJTjCeqpnFFlFM2O2m3bWFFzJdjx4gsUT0TpttQdkr
	7le0GUo5sR/2tyFurmoAqeQnI/C1BD5qrV1N6IpsslxWUp5/A8CNV4S5rYUUUkTof6wjZ8K/v92
	uYhbktjG44VhFuZ7pMWs5VIizXtRt59TdjR4DdBU5hvbth2LRvXO2NjDXyhl19nKOHCUFh1sv4O
	qoklrre5LKbHxuMwA+bevso7YMbCcpQxZ02yVtS0XJo2+R9Fn70E4Iw8USXEZvcphUixHBOgfo8
	UPLNnC3h8LOc+3xNGh65fz5Ws9wdXO8i4KsrOQ8QUB0p+cU00TkdNdtS
X-Google-Smtp-Source: AGHT+IGR83arbPhkxTPszOw0QmUjKBqFftrFGzkz/37OEgwIXCn/wV+VehuS+uf21fpnsQyFuyqqPg==
X-Received: by 2002:a05:6000:2ae:b0:390:f738:246b with SMTP id ffacd0b85a97d-39ad1746641mr2425530f8f.15.1743076393306;
        Thu, 27 Mar 2025 04:53:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efeb11sm35362325e9.22.2025.03.27.04.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:13 -0700 (PDT)
Message-Id: <1d0ce59cb684c2878f1a0db9daeae23ef4abb763.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:53:00 +0000
Subject: [PATCH v3 07/10] wildmatch: avoid using of the comma operator
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

In this instance, the usage is intentional because it allows storing the
value of the current character as `prev_ch` before making the next
character the current one, all of which happens in the loop condition
that lets the loop stop at a closing bracket.

However, it is hard to read.

The chosen alternative to using the comma operator is to move those
assignments from the condition into the loop body; In this particular
case that requires special care because the loop body contains a
`continue` for the case where a character class is found that starts
with `[:` but does not end in `:]` (and the assignments should occur
even when that code path is taken), which needs to be turned into a
`goto`.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wildmatch.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 8ea29141bd7..69a2ae7000d 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -223,7 +223,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 						p_ch = '[';
 						if (t_ch == p_ch)
 							matched = 1;
-						continue;
+						goto next;
 					}
 					if (CC_EQ(s,i, "alnum")) {
 						if (ISALNUM(t_ch))
@@ -268,7 +268,10 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					p_ch = 0; /* This makes "prev_ch" get set to 0. */
 				} else if (t_ch == p_ch)
 					matched = 1;
-			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
+next:
+				prev_ch = p_ch;
+				p_ch = *++p;
+			} while (p_ch != ']');
 			if (matched == negated ||
 			    ((flags & WM_PATHNAME) && t_ch == '/'))
 				return WM_NOMATCH;
-- 
gitgitgadget

