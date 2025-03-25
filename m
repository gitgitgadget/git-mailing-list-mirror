Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3791269D17
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945546; cv=none; b=U6wGw7vzYsNKFUd8faY7BA3Vw1A8gMIpWsQkt+WtsweovtaYsizDpch6ZAUDenkYrK124nFwbFdRYxkN3ocBBLgfUDySthQXftlBRio4wuslY03zOq09ps94tu/pZzw70ghBBSkJDb71QBq/pDgeDyQuSh3ABiQgrx6fc6+w+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945546; c=relaxed/simple;
	bh=CDKvEKQ72ZvfRX4UpUcQ61D9cSY/Mz66iuGBG+Kn29E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WBdLp/WcOGulx98Dtm3uuP1LPK3fBxr5ZgVENtPxiVlxP83YipdQgFSfAHBM9H85N9ZjbdZVtTe3IG6GzJY7KOy03wl3boFZnGjjD9iLSucSYOE4JU6kU4i0ms4GstqeZv1othtPd53G0GNj64VyzJTJUMGDNo8HQ/JHKLDR+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmlKBZ1H; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmlKBZ1H"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso64734165e9.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945543; x=1743550343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91Ofi4EEKua14rkw4vA93jknHfMel2rpm0w1atB5pM0=;
        b=OmlKBZ1Hl7tHt0zJzO0EvayVHuJx4xaW0yGTh9p2EgUYi9eV2mRHk+LkOP+5NboIXx
         4+KfFoFm54Vy+w5g9Gv8yBDfKEyvM2eH9Ha/Wvh7Gy78yZlb5SicSD6TO6pKNyqpVHhs
         SPTWnvojo0TeHjRCFNq7lMGOOQpkxcY6cL6wB2JmKnRadSGN6v5NGrBM0MPyt6wAgmGz
         2CNLzIVX/3XwkqUl03GgfPt/T6FSvdEAHyv6810X8dYZie6xFG9KyQZwqwCowsqnm4Mm
         87WmWmdTtZ4owwXaqX7JKevv4fcA06ySSEVqVYL0L3XwlYP9X7aOH7x/gvSBk0uOGhQA
         6rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945543; x=1743550343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91Ofi4EEKua14rkw4vA93jknHfMel2rpm0w1atB5pM0=;
        b=tSjnekqLag9UuklEOKRnGy1//Lc5ub24KYIQ6kvrZa1n76p29gCCoBa5LU6oa9Wn8E
         M1pmJRtjge1fXsDXXLzftIeh3WMYdT3lwScBIpOtImI5UudEysC0L5ZzOSaeknkQf4UQ
         U6oJ0oeZPcFw6GBt+g8EnvfHElm3LRvQXu+5buQFC8stv4+fm7I4jl42zBqhUZe9AQIH
         resKg6n7Xav3Dbt3yaH8+sETtNY8a9/zu0yiUJbgzr1BKd4VAXj77NBL5iaFL0vaJaid
         1bniWXLQk3mSJWt4u0t8I7EQExmCe60QCo3tDLOVXiGMGnshLtowUrs44XNBoFAMcwmm
         i2Ww==
X-Gm-Message-State: AOJu0Yx0i8TkHhUP06mw5gubFxQv51hVNoCvW3cl8cMCo2DkqSSCNimt
	H0btzxnvR4F5k1KZmwA5nNcoxYN/gd/6PMYkygaui3SSxM5Y2H7fHFqgZw==
X-Gm-Gg: ASbGncvKaILHrFOlK66PI3C95YQ5x7pYSJzzLE/IyM9CHZhAIhdk8N7eroUO1/N3XqS
	8bi34bKdw8S0oF8TTb/SeF4tYcb4QHBkyyIFXZbZt3VGvOPk/tkmfr4DvR/tOIjctiqetC2CrR4
	/tZCC1GCclFfF80T0KPWCf2DLdfSFdSOSftXaqMz5G9TsxMTBP3MGOTMk53Z9YT7vIhT7KllC/y
	4Q16TnFhzCguvdAVOvcdgavI3/IEOA9tSMFmosZ1H8I8V7G1x/KjbvEfVy9q0xG5GYwsFbu4Vez
	X3B/rYPJaLrodSIOyjynuqEKQwQhCSeAoekTfTimIMMHVw==
X-Google-Smtp-Source: AGHT+IG0AztcULwieNvpj5AVNzX1hYTJ6WXuRvd8iBsZe0duCU6sqxOaCcbfw2L9jtCBnQRZdXlNXg==
X-Received: by 2002:a05:600c:a00d:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-43d50a3444fmr163908165e9.25.1742945542461;
        Tue, 25 Mar 2025 16:32:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f556afsm213262665e9.19.2025.03.25.16.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:21 -0700 (PDT)
Message-Id: <9a6de12b8076266fb0c88f6b658c20d37409ce13.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:11 +0000
Subject: [PATCH v2 07/10] wildmatch: explicitly mark intentional use of the
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. That is why the
`-Wcomma` option of clang was introduced: To identify unintentional uses
of the comma operator.

To mark such a usage as intentional, the value needs to be cast to
`void`, which we do here.

In this instance, the usage is intentional because it allows storing the
value of the current character as `prev_ch` before making the next
character the current one, all of which happens in the loop condition
that lets the loop stop at a closing bracket.

The alternative to using the comma operator would be to move those
assignments from the condition into the loop body; In this particular
case that would require the assignments to either be duplicated or to
introduce and use a `goto` target before the assignments, though,
because the loop body contains a `continue` for the case where a
character class is found that starts with `[:` but does not end in `:]`
(and the assignments should occur even when that code path is taken).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wildmatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wildmatch.c b/wildmatch.c
index 8ea29141bd7..ce8108a6d57 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -268,7 +268,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					p_ch = 0; /* This makes "prev_ch" get set to 0. */
 				} else if (t_ch == p_ch)
 					matched = 1;
-			} while (prev_ch = p_ch, (p_ch = *++p) != ']');
+			} while ((void)(prev_ch = p_ch), (p_ch = *++p) != ']');
 			if (matched == negated ||
 			    ((flags & WM_PATHNAME) && t_ch == '/'))
 				return WM_NOMATCH;
-- 
gitgitgadget

