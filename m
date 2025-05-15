Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B436298CA1
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313148; cv=none; b=m73zf2VUmgvwhLl1P1OuaM5gnmd/R6BhkBlGmMxse9joiYb9xqNOABHmFCTTQWHPnd4JCvXT8uqjKTwwtcEpcNRjoOmBex9q0TVgWSPonvpdAfYUn9MhBkNgQ+Ex3/QZFAdWkUfJwRBhpXWLMO4ri1Kb/xO/HZpiLFyk6FklI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313148; c=relaxed/simple;
	bh=t1cI2MqWAWbnmwEnpVFQjkLi33jlkwVYfOrkWuiTZRs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cM35DuyEGmWi9dcJHh8lZIt637EnqHji1L5mKJMIbCrSWMJzHEKePqDQIAgGdzZEEXw53tU65sCXH8Jdbz7kFJd/wN7S2GuB/uBEAelLEsLeOO/wYuE09SPQHZX2QUKVZRkqz7jJDJSEnWGqyUpGObfWkbm35+j5lxERC3STXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is1o2L96; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is1o2L96"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso498215f8f.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313144; x=1747917944; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO+J+bpzOY49+bwHQory82gpi4EeeBo/s041MZT2xQI=;
        b=Is1o2L96vPLRvzV4KiDboG95ZpfU/Gi4tcV+FAvgOEptrLIYe1SVtYxTCnvPp4QTnc
         XX7zR9kWRTnQnXBc/C0STe7Gbsw3VIuha8udg6AnfnZA8mQReZB0omZTQ6+3W1D27IuX
         h0KT4bzYQ6ub8PRv/SlmT9TX0FiAZwINl/+/ODOjj5FWQ98pRfXGpAPh8ECsNexNuaVK
         1tIIxyLw8GtYOwBD0Jds2ypJbqH0oFKP/CDnmSsVSCNT7PNXw6/rmE6CP9hlihll7pZm
         QCaFEpUXdVYqTiPrvtrNGh/U0A0yfl+xu4OmZnQwBhvTq97uokqbwsOb3JeJ8PkXj4ga
         Y2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313144; x=1747917944;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZO+J+bpzOY49+bwHQory82gpi4EeeBo/s041MZT2xQI=;
        b=ayPfyzT+SaEfd4wxAa8MI8hn0xKp971oUP6UrnnTU+TWVLjCs1YjMWJe5E8h2eRki8
         7xzsbTHcBwmLzaMvlssc6xasll3coRTH4N9FzlJSZdj5DFOqwRvD1UnJtdtX8OdBprbE
         oGLxWU4cjlccJ1QBIrsGJ1NM9b379BL8IUDc+xPnwJGwTi5/p+RxOQi3STqhL5paEtJz
         dtqOO10++LLPlB5/cjlaJWYQ0y28w/KG5ruUSQL9oXJ6wj/8xtHOa769Iku0nFT7Lmzq
         c8Pd63Z4e4mFHZSZgNz8Df49Qx8lliUct1qKjsjIX2XlcT9YlyxiygC33lXt3azBp0kV
         t03g==
X-Gm-Message-State: AOJu0YwXm09U5rRS8kfhfcniGVSIhhOjW4uPdVatn7QqzownInr8R+Q9
	UiwrdZaH6ROFcN6nuUV3qw3P2b+x6LOjCCSwsauY+NfaZ1oW8lO5oyERZg==
X-Gm-Gg: ASbGncs2rBVj4MmY14ye8Ravcn/wLuUwOTdhZyMmS54IdPr9MwJWY9/bEAkPsb8Y52M
	1S/5ZMtqs81lJfZBes7cD5NO9fwJg3Agsr03H2Gll4kmsNKXOp4LsrOSUSDInRTqTN9Lkio4y1p
	w546mIqOE/t7KUiIwVcCErnOePFRx7hnqWrQo0YkhGsm83s6DLK/szy6f2cgBnPgyiq9D86T88h
	InZ00ZzjVuBIe4LdtJvtdMynN93bxko1PgRXVXS38v1+2g32psPG2n1YlcbzGwn5LhreIGA6vCv
	5J5LZwfHy352GYat9lGjq8wfKQxDEMlItAN+9nU9vWGJIr/P9UWm
X-Google-Smtp-Source: AGHT+IFFpNsh32AJbWEBWsVYIjrPWhbHbSwBRxwIR8/Dep40iHduvIBwJblSi9S89VSlODnjevEOHQ==
X-Received: by 2002:a05:6000:1789:b0:391:2e6a:30fe with SMTP id ffacd0b85a97d-3a3537aac5amr2414493f8f.39.1747313144142;
        Thu, 15 May 2025 05:45:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfc9sm22396709f8f.5.2025.05.15.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:43 -0700 (PDT)
Message-Id: <9cafbd36817aabbe18197938c409edaddf7dcab2.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:28 +0000
Subject: [PATCH 03/14] fetch-pack: defensive programming
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CodeQL points out that `parse_object()` can return NULL values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1ed5e11dd568..4cbcb0c14c48 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -155,7 +155,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 			struct tag *tag = (struct tag *)
 				parse_object(the_repository, oid);
 
-			if (!tag->tagged)
+			if (!tag || !tag->tagged)
 				return NULL;
 			if (mark_tags_complete_and_check_obj_db)
 				tag->object.flags |= COMPLETE;
-- 
gitgitgadget

