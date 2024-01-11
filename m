Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8115AE4
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak6zdMdQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e5f615a32so5304385e9.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 04:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704976824; x=1705581624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvAHPJaSBVMlgL812RGFH7y/iLztixZiA6FtzghUFlY=;
        b=ak6zdMdQJStSY28Kwj/BDcW3fSkN8vomA/VDM4jbP7t0AluMBq2/bdDNHQbf64Wbbn
         oUeL5xpPaPOYyzM2L03k+Fq4OoQaLEpKjT6HUX40550jSRquFQz9aZ8EQHrCm4QBSSld
         6KrJAdTUyMv0ZBCc/jp6LOeZrfDTbIL71xZCVYsROzzxRDCac1PK9FkuB6KCKVkgzRCl
         ovAi4EURs/ZiIJsI6h75ovzDKvHzEVZFCiy1h1OnBviAO6u/7RyDh3Kr8tPuo0q93fLK
         aZ0g7usdAwivk43RYtvCsuRQJ/sO5to9RSqLTQo69KZ8h48hhZhbmM0Ytgk6O2C/Fza3
         rKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976824; x=1705581624;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvAHPJaSBVMlgL812RGFH7y/iLztixZiA6FtzghUFlY=;
        b=tJFOuNVvDUse5G3pW+/od1oaeQDHt237UoFwha4D72hns0Z3LT5JfH33LKHyhm0BnO
         s3Wz6tIAFdP8vObAxaXryw9y0ERZ+9FmiSpu0ZAB0o87J2+pU1gfSPjZzA3s4g76YHNy
         SK9MJ0KcKtJKlGXvCwLkiaUXZPdUt8jlujaLG0YTwGGAVKZfykCxgKB+mrzyStvbVRgP
         OH0Omm5b9o8rA63qgz7gxfr41hpBJHNUPyYQ8nEgXY1DSLHKd9OrFPqD4R5enJ6SAfJN
         4Mw9OY04Jiha0TpzbbOBd5N1yRzJ4/RpG0m6x8BzC0C0G//bLoG2ZZ+R7VmFYCj1wL82
         21kQ==
X-Gm-Message-State: AOJu0YxxyYRnAU2I09LpgxI55xX4pBcfW9uiJJLhWtp+1VjKE8mxG2+z
	wG9cf3T6Ft6jfA2bNk48DnrrUWeyAik=
X-Google-Smtp-Source: AGHT+IHMqwKJB4amz3XX7TQY4/TCaV/TEUBkE6FAB/CUx8y+HjhEgfPU621f1mfXzcVHZ20xh/c1DA==
X-Received: by 2002:a05:600c:5191:b0:40e:6286:2a8a with SMTP id fa17-20020a05600c519100b0040e62862a8amr33120wmb.321.1704976824559;
        Thu, 11 Jan 2024 04:40:24 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id fm23-20020a05600c0c1700b0040e612aa673sm1575390wmb.17.2024.01.11.04.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 04:40:24 -0800 (PST)
Message-ID: <d5fbdb05-d16a-4390-946e-22a5a7a1b56a@gmail.com>
Date: Thu, 11 Jan 2024 13:40:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/3] advice: fix an unexpected leading space
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
 <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
In-Reply-To: <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This space was introduced, presumably unintentionally, in b3b18d1621
(advice: revamp advise API, 2020-03-02)

I notice this space due to confuse diff outputs while doing some
changes to enum advice_type.

As a reference, a recent change we have to that enum is:

    $ git show 35f0383

[ ... ]
diff --git a/advice.h b/advice.h
index 0f584163f5..2affbe1426 100644
--- a/advice.h
+++ b/advice.h
@@ -49,6 +49,7 @@ struct string_list;
        ADVICE_UPDATE_SPARSE_PATH,
        ADVICE_WAITING_FOR_EDITOR,
        ADVICE_SKIPPED_CHERRY_PICKS,
+       ADVICE_WORKTREE_ADD_ORPHAN,
 };

Note the hunk header, instead of a much more expected:

@@ -49,6 +49,7 @@ enum advice_type

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 advice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.h b/advice.h
index 9396bcdcf1..74d44d1156 100644
--- a/advice.h
+++ b/advice.h
@@ -10,7 +10,7 @@ struct string_list;
  * Add the new config variable to Documentation/config/advice.txt.
  * Call advise_if_enabled to print your advice.
  */
- enum advice_type {
+enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
-- 
2.42.0
