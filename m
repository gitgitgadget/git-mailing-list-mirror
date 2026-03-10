Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D53AD53A
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149346; cv=none; b=Jcrc0dPW++Xu5ENIym6ykN09iqROWzkpj0tVBHscgdIM9SFAqqYYi9lG1DLB7Fmr4Cv8Xc5VyHWmqg2avSlsf8gb4ugzF4p2mUYf8xjjw5bLx/hP+np6rjd0a/R1KVplSjEvo0Tp7Xagrjlp70KIGgIaRihiZsbq3VFaqcHmanY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149346; c=relaxed/simple;
	bh=QaSjG5wlQGvCiy3XQPvBK8ULKqCVyPO6Bhg5M0nV9QU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NSucnTIJB2qqtsMVHhLULgfWZ0iKT89Lt69hkBgJxK2j3fMQR/rpikvBY4adkPOxB+QnB8msD+mYgFjjfmXSmhJzI9393dX78qcuqLu8Is3zixJrAQepIzwzhKNjXcbcD/AH9DC9t2YMgMZ6SPSKh4oMY79X1Uur0a3hsI8qFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMSHXtfa; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMSHXtfa"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128d2e3082eso647823c88.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149344; x=1773754144; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRc7mbu5XmqgvaDQuOR1X/J9MYqgqeoPrHMAK1oJUv0=;
        b=bMSHXtfagwaE3GK5IF53xZ3pEYXdWkXw5gQX71Wj9nP59dCRXY4Y97FI6VZfG/fgVJ
         HQo0w148qmxofrvfaPbsNj0PgawO3jShSqZoGJCkpNQiE6pOruKOJw8wgmXvzntF5ajT
         kUPE0zjFl/HNLVWDpvDFWbpGl49bLUDb4NGf1ouMI50NNsXWVLY+RMCUCyGwUB8wleCu
         V8+nX15dvZ6IU6X3LI2aLT95M58xNgTfprQWMRV1G9X7LbWK6dPBOJl7wjqVj2F3LbJD
         hGkVmCyXS3zajdBhdlkrqdhfSwGwjUUmGq/BGseg4LXXZ/+JmOcul24gVhE3PH6g3skJ
         YV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149344; x=1773754144;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRc7mbu5XmqgvaDQuOR1X/J9MYqgqeoPrHMAK1oJUv0=;
        b=MTxpHuC+OpiyaKqUbJHy9c/pB4jZ0U/GUtmWJujybSuTWx4+FbJXan6cJG5PJrEuw9
         w7l+Td9ijry9934bOSuHqjA0EC0Trd3Dfyu+LX5wkp/h9rhRyTsWMh4tDgPqHUH7ss+A
         uSJHa8lDnIFZaevtKQttVy49kz6HF0CU9kSwFxmYIaXgRnkf2a02wuLGWXDmxonMHXAF
         +kc8zEOpp0efpo/A1jAs4DEF8OFFnfFayoKvuy7fJXYPe+G52FbQMSPBPE7MvO3Fjx8l
         kkHuNhgQjMNS+HGSVHdzVRvd2IrZ6+gXcIqdT7r87M1zQ4FO+eCY+fq8ZtNnGbhudRYc
         dOfA==
X-Gm-Message-State: AOJu0YyReKxecNJ+koBtXz+p8CCjjKlADPp8HgGRW3rrHGIDlfiaAL7s
	H109SI3SgrK6vG4Kjlph8viGjk7Po9BoslPwvC7hcoLzq0w4ToGKtIC+be5M7A==
X-Gm-Gg: ATEYQzw4f9cLbWXQMA2CvE8jzAeJFf4hsSLscZE96xWUXRQsvHYcH0wb8OHxnckBqic
	S1fJRuI14sdWILmcABbngWCVfHRW9Vydx8nLYUy2u1jn1bZZzgoFR7tGNY+ZtV0P17JJiWOHAYd
	r4gHMYV+ehvj4LC0CdGImMNpG8GhJzXS05T+vQ5MVXJ5sbBtSmxqZskNKcv72u5shQvc2KR+alw
	xpHJwQ8VSlDquuvLYLljab6Z28bMRl3MDpu3V9SIGusz0wUCcLqiqW9nXSCO9mmI2Jl+hMaBB1q
	/DkyCfq/Qs/X/h7fxrhNlnPLcOiOwUS7hCRPmNpypxN14j+BI1jdSDkrG8ykJtWKqvFyCvOf6gG
	BOWBoBApSKLO1oLbNmRTmbLu54lgHUiy9WPexnvTylVj0UZRApy3XrgcyFTRP+D9EA62T/AAMeT
	CY+kQM3hS0slkoE6r6qKsG4pgkhlQ=
X-Received: by 2002:a05:7022:6182:b0:128:d51a:5143 with SMTP id a92af1059eb24-128d51a55f3mr3702110c88.31.1773149342579;
        Tue, 10 Mar 2026 06:29:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128dd22196fsm4900658c88.15.2026.03.10.06.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:29:02 -0700 (PDT)
Message-Id: <e88c85170147a7c5d44640cba0c48aa686e23f17.1773149337.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
References: <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
	<pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 13:28:57 +0000
Subject: [PATCH v3 2/2] advice: add stashBeforeCheckout advice for dirty
 branch switches [GSOC]
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
when they attempt to switch branches with local modifications that
would be overwritten by the operation.

The advice suggests using "git checkout -m" to carry local changes
over to the new branch in a single step.

The advice can be silenced with:

  git config set advice.stashBeforeCheckout false

Changes:
- advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value
- advice.c: add "stashBeforeCheckout" to advice_setting[] and implement
  advise_on_checkout_dirty_files() function
- Documentation/config/advice.adoc: document the new advice key

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 advice.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/advice.c b/advice.c
index e1264f525c..ba290d3760 100644
--- a/advice.c
+++ b/advice.c
@@ -327,15 +327,8 @@ void advise_on_checkout_dirty_files(struct string_list *file_list)
 	fprintf(stderr, "\t%s\n", item->string);
 
     advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
-		      _("You can save your local changes before switching by running:\n"
+		      _("To carry your local changes over to the new branch, use:\n"
 			"\n"
-			"\tgit stash push\n"
-			"\n"
-			"Then restore them after switching with:\n"
-			"\n"
-			"\tgit stash pop\n"
-			"\n"
-			"Or to discard your local changes, use:\n"
-			"\n"
-			"\tgit checkout -- <file>"));
+			"\tgit checkout -m <branch>\n"
+			));
 }
-- 
gitgitgadget
