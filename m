Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D2535C4
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711215420; cv=none; b=ThKqsw8SL7bnNaSKreyZ0V9bT4oFtZEpI3D879Y9oOwa8Ji2pHGcljEtmBdz/gMyKKT2Tv+k86wEr7LMdu2HyLkSXBqf0bWUcyPHCF1KE3VxGMF3rG0xy12rxISuGMevzMTSGSgvBYq/37FdOuogietOnG2PaGx9LWR349LLvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711215420; c=relaxed/simple;
	bh=YcC99lOgRL5yf1ZDWQbjsmxqGy42OaBEikb6plazQ8I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=gosAxmXB1HNYM0H64NHHp2PttWOrWjYBUFQ33L0xi9uNtRQ0qixahmhI2sC8oc79SK+ZbBdg7+Jfb9VGZ+wlhLmCJlpPc0FZewPuGYeroZRiAuivxZyZU4TYI717xdYH3lt9PmINldaBFbcMGvRSTLbMW5KwIp2pFXJOCKLqBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpDj+hVP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpDj+hVP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ecb04e018so2029639f8f.1
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711215417; x=1711820217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IneL7ycCxg5rabSPhRr5UcFzUBhPE59XhcTWAN/83k=;
        b=QpDj+hVPw4BbP/eaXr1MWGHmCLUu+tZdD08lKMI+7rQscw5EAOPcpeI7gKxzS3JmKw
         PuWp9v2ZytEbk+d22btM6hS3bpKNaw5cy9MezH9YqQZ3pS4bOmbH61jqmLK+zVWd7yv9
         Ihk7QOtCaQve/PEYz7XBrnVUSeT4w7sJ7Ulmprk7G4HqQDdZledbY8pFPXrKTqUoUQUl
         vPswScx3WQ0UUmZHBWQq5YRKh/HyKsSn2cQIcpSwxgLM5YzrtM4e6cX2QCRWf9QU6lHv
         c1Re3O3IiBAjqWgbJ4KR/GNJE1TQ/OL8MIlcNHv9Cn34Ff+oREZi/GYQXGUe3ZbVCdRM
         883Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711215417; x=1711820217;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IneL7ycCxg5rabSPhRr5UcFzUBhPE59XhcTWAN/83k=;
        b=FPJPEnzV7qxAVoC49UBTZ2bwJ+Q2Ld7G6y1xxUwJYCTkbl2Bwwi0Z6FAGn/hRQ9Q8K
         aLf1H02sAvpr6RNjD2KbgEsDWaKBvyH5op2rlkhD/emjYG7WpRF65YsneT3BCmxZY+5o
         QhbWMR3puDndUCDKFh6WvPhBdY6rIEObVaBtqdavemEBZ2T2lOOc/i+jGtOtTLGmV1Nb
         3pMLKGyoAwUsxvtpZKa9ZRaSv8zNimwfUQhNta6KQl9SsS3H9094G+bleOEA9biD5xKN
         w65yUu/UpdLAy7mLlHg1sEdL/0HJCNrqRxEF5U1sp/kIk8VjDbnGIXJKc4BugLsSVTlV
         nBBA==
X-Gm-Message-State: AOJu0Yxi0/865Z0PxNatnXsg8T6bNhghTcp9FWk4/xKwNP2rYq2YLUKl
	yEtBJeLC9BiQ+a3WJGrwyDZsNESIhUfV1iOPuM8/NHlQ89l5IpJcEZteSUTE
X-Google-Smtp-Source: AGHT+IGdW08Lc4/naUgXHufG5zgsM1FzfiG1FHnn+ATldfk8NpwDwCjU+rrss76jKfETjmuo0rw1CA==
X-Received: by 2002:a5d:5287:0:b0:33e:acd8:1422 with SMTP id c7-20020a5d5287000000b0033eacd81422mr1841965wrv.18.1711215416957;
        Sat, 23 Mar 2024 10:36:56 -0700 (PDT)
Received: from gmail.com (181.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.181])
        by smtp.gmail.com with ESMTPSA id bx10-20020a5d5b0a000000b00341c3071c93sm1446083wrb.73.2024.03.23.10.36.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 10:36:56 -0700 (PDT)
Message-ID: <1117b5b1-fb9e-49b8-b1c3-47b985adce35@gmail.com>
Date: Sat, 23 Mar 2024 18:36:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] bugreport: add a mark to each proposed questions
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
In-Reply-To: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Include a mark in the questions we provide, to enhance the readability
of the reports we receive.

Of course, the user has the flexibility to choose a different format or
rewrite the report entirely.  However, including these marks in the
template may suggest that we value some structure in the message.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/bugreport.c  | 8 ++++----
 t/t0091-bugreport.sh | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 01b72163b9..d60ec483fa 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -76,13 +76,13 @@ static int get_bug_template(struct strbuf *template)
 "Thank you for filling out a Git bug report!\n"
 "Please answer the following questions to help us understand your issue.\n"
 "\n"
-"What did you do before the bug happened? (Steps to reproduce your issue)\n"
+"== What did you do before the bug happened? (Steps to reproduce your issue)\n"
 "\n\n"
-"What did you expect to happen? (Expected behavior)\n"
+"== What did you expect to happen? (Expected behavior)\n"
 "\n\n"
-"What happened instead? (Actual behavior)\n"
+"== What happened instead? (Actual behavior)\n"
 "\n\n"
-"What's different between what you expected and what actually happened?\n"
+"== What's different between what you expected and what actually happened?\n"
 "\n\n"
 "Anything else you want to add:\n"
 "\n"
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index f9c1ff9cb2..9b3a2b0cd2 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -16,16 +16,16 @@ test_expect_success 'report contains wanted template (before first section)' '
 	Thank you for filling out a Git bug report!
 	Please answer the following questions to help us understand your issue.
 
-	What did you do before the bug happened? (Steps to reproduce your issue)
+	== What did you do before the bug happened? (Steps to reproduce your issue)
 
 
-	What did you expect to happen? (Expected behavior)
+	== What did you expect to happen? (Expected behavior)
 
 
-	What happened instead? (Actual behavior)
+	== What happened instead? (Actual behavior)
 
 
-	What'\''s different between what you expected and what actually happened?
+	== What'\''s different between what you expected and what actually happened?
 
 
 	Anything else you want to add:
-- 
2.44.0.494.g7a0daf3e0d
