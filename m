Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4E8F5C
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695380; cv=none; b=u3XvAdoTFCK07klUCTbR5WOy7YZ+t2MbQOo6dk0Z//uDmePHoyDYSfbCiME4chxePFZoHuhjf6BmQlhd7NsY8gCjqkwGmHfDyWg6RItZ2dnN0jadVo5TMxuMmtrV67VDjAULYd1pywTazLqeg0uRDxhWMZEi0eHpkZrEh21YlOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695380; c=relaxed/simple;
	bh=GEUaIDHOVzGt0C9TbphyuEFMt69LPQaZ43NA+x3OO20=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hec22KCDXQq9KL/QYqloxtYXvqLmy7Be7xHqT7WTFJ+EICZASMC73XktlZpZV1zliu5OpmLeC2EIAfrQs55sp0PiP59YRgeOTJIk8YlfdapvAeZmcIgcytydWaY6vVtsqwg66lDfH6C4y7miEnpU/lA8b9LLxOMuVivUC3DiRgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0yuYqIq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0yuYqIq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so32566405e9.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721695377; x=1722300177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6Qsb0UIzLI4AN+k9KCBX0fD7DtlXjbwiDUZ+loGjVI=;
        b=b0yuYqIqzkyD0Myfl2M+iOPBDMCATgU++yAD+TPItRd26M8Ly6Exbem7accmFGMJGI
         XPH5fq+UxGFFZth/O60hKzSQGDfDxP2Wfco6HgwiD7u/IOcYCQ0+RboCrmL+Go/CH3aG
         jVvmQmn2KdD43ZyJiQ723lml3as9Yh1DwObTeEOD0v0bNSC+mn9tNimtyE5IET4qIS4F
         zhLN9UNRS6UFhj2FxP4XDzHj4dF6ZRMGoSYEupClQh0AO1zxRbsvPPBF3tNzjBim3qGd
         WLdy+7UHahKX57U2iJrUyAcKfan9iVC51rGPmI1vC6/+WNL7X3hEPaW0GLAlA8c+9+nh
         2u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721695377; x=1722300177;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6Qsb0UIzLI4AN+k9KCBX0fD7DtlXjbwiDUZ+loGjVI=;
        b=OQ0tDYM8x1rTRw/yS7PNxNuptrvbaTM6W4YM21MLnKqx4ac++DDJj6SZIQYEj66/1H
         uS08bqjw0VjfAWFMHdefNE9UJ6sd3KoGf3EHOaEnb04YHlT7yW7e0ZSfTEhT1zLs/wmp
         rKXFhQwg3lqaULRCzHo2zAhgZaHP22M6SKiN+IJInkX+yu53foCbCd7HUUzGrdNDKEj0
         +b6gTcNMVCJwC4wLvxd5FHaqhD+XL0odllK/Efx55C80y61XK22Fyj90pm5h+6fN2psW
         85XYUpZEvofgYCGDwg2qgdzfiz5xbL6chQ31QXphqs53TFbSnE5oiUKOW0eHM4ypVBae
         wNtg==
X-Gm-Message-State: AOJu0Yx0VKvmWF8bKFpul0FzFs4bxNHybK9JvmG1oBXlpsUDYhyrjGhz
	RajhOPq13wwBLPep/Ze2v4X0eSeUdUnX3PaCQD2nfIkv4EtgkMQP
X-Google-Smtp-Source: AGHT+IE4tdSMHErHhQ04lTiHhrGGLTVnSrlEnkBtejDyQ45xGkOREHsSuUevyCXvZbLr5wD/gj/fQw==
X-Received: by 2002:a05:6000:156e:b0:367:8f81:fa09 with SMTP id ffacd0b85a97d-369bb2a256dmr5566857f8f.47.1721695376968;
        Mon, 22 Jul 2024 17:42:56 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ced33sm9922225f8f.86.2024.07.22.17.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 17:42:56 -0700 (PDT)
Message-ID: <a2d6169f-61ee-4a3f-9f8a-f791229c25a2@gmail.com>
Date: Tue, 23 Jul 2024 02:42:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] pager: make wait_for_pager a no-op for "cat"
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
Reply-To: 43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
Content-Language: en-US
In-Reply-To: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we find that the configured pager is an empty string [*1*] or simply
"cat" [*2*], then we return from `setup_pager()` silently without doing
anything, allowing the output to go directly to the normal stdout.

If `setup_pager()` avoids forking a pager, then when the client calls
the corresponding `wait_for_pager()`, we might fail trying to terminate
a process that wasn't started.

One solution to avoid this problem could be to make the caller aware
that `setup_pager()` did nothing, so it could avoid calling
`wait_for_pager()`.

However, let's avoid shifting that responsibility to the caller and
instead treat the call to `wait_for_pager()` as a no-op when we know we
haven't forked a pager.

   1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
                   2006-04-16)

   2.- caef71a535 (Do not fork PAGER=cat, 2006-04-16)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pager.c b/pager.c
index bea4345f6f..896f40fcd2 100644
--- a/pager.c
+++ b/pager.c
@@ -46,6 +46,9 @@ static void wait_for_pager_atexit(void)
 
 void wait_for_pager(void)
 {
+	if (old_fd1 == -1)
+		return;
+
 	finish_pager();
 	sigchain_pop_common();
 	unsetenv("GIT_PAGER_IN_USE");
-- 
2.45.1
