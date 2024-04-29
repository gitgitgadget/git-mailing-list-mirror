Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567686136
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410317; cv=none; b=YPBv7XdzrJ4kS8XYtMb7vSMzAZIfxLifhDPKZL7U6LL+RG5mbZerrI7RFVaIMgD7LuZKYbn2/VFp+HY0QqX93QCRb6SsiRd2/KC29k+VZd3/Sz9H2wFD8zV55I3Mu3POOTKdyf/gkUTflVj/yEuRrtJMfmLPXFPgXKAdaGH/qQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410317; c=relaxed/simple;
	bh=CDz5XpcOYfDDf26vU6oZAg1RGS0LdTsuLkiSXKbGSmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qdEMh9anaPdThQ/1QyvbVLMSpv9Lk7zRZ/8qOeLy2mUPaqiHOcTDf+S3GbFxGwIwILT55VWLCP8k7pscIBR3nKqfjS5A3NQuZb+yL0Iyz3jYf8yKegjnYNltNxOK7LTA9HJ1CduViBLVEupFDWv4C7uZ4hf8KOJtEhvKjgXxupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqdb/pJR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqdb/pJR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b79451153so25347225e9.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410314; x=1715015114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/Xe5i932tZxV3jz+wwS9W/b89KZt8jb2oKcv429bAA=;
        b=mqdb/pJR/lZvJPve5ItNcV/Y8EDAZCli5pMlNPsdE/HDaST6mghK+VdNx4kP52QprV
         BvQMXz39ALPYE7/+k1tlCiQEv3ze8evIDylv3FAvsTGgoCPyGfoNbEULC+khpQ2xB1gi
         iPGlwyrknbQH60BmNK98bIdhJKLhZiocAzm1l5BC22arsE0ehQTsR11VLw5vN9ZD8rF/
         KVBv0yatrfaKeOP15nZAQoZCk+nnm22JA0kz5gIIqTHmO/RYngjnGpco21OLqWrV4rrc
         wp3leOPzgqeDRMj9QAXXJIrA5FvuLkyOgL+CYkDWkooXN59gRmcE7qFZT+fOluXGFsfe
         e2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410314; x=1715015114;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/Xe5i932tZxV3jz+wwS9W/b89KZt8jb2oKcv429bAA=;
        b=XrALyTB1pyG/aprDwjT+j5CfAjafXxIiNFShl1XuGQZHCEvh/WehQCL+uOawgi3VAB
         OK2IwwFwV8aHnRXZoxH1aSgqlzYskxzlYo6/siin/ei/S7mQ7KFygKnyCPDMmmVYKEW3
         A0FI6B1OU8tWsRck/RUf+WT4Suc8efCwxIFYGfpY2A3JnPWKoN2hKLMaSsEm969rYaBe
         FdWC61oCTxNKR09Ac8lY7rNAIZSd/q0nFKS8Ma2QARV8cnXdZ5jys14RVZMXRVPAwTXu
         wYfbvQztbjOyKgnDisyywMa+SHmqgrgXf+8Xc7B/Dunle5WLgy586CKKL1eiCQ3s3Pis
         zy0w==
X-Forwarded-Encrypted: i=1; AJvYcCUGmj21jWAzeQPiK+jjS/S/Rw71w60sPVu8s1yggriUNm3D8ub299dooQOg940WqyOVnJTUp6lvRjbxR/Tb+87SQ726
X-Gm-Message-State: AOJu0YxW++fIPM+jfUO9r4EiWj5dnAYXYry41DkGSWbwJgzPS2L86gX4
	wHBqqbNDHnlz3R7bgyUdwFMwFOYev0su+u2ZmkWx9tl8S+Z1mh0A318jFw==
X-Google-Smtp-Source: AGHT+IGWIQJn7Vlx19jE4twEIpUHAWJf+47bwLcw+qPBD7J3jN4ZqEZ0BNP84Jqr7jrOojT4mZX6ow==
X-Received: by 2002:a05:600c:45cd:b0:41a:b56c:2929 with SMTP id s13-20020a05600c45cd00b0041ab56c2929mr7990768wmo.34.1714410313903;
        Mon, 29 Apr 2024 10:05:13 -0700 (PDT)
Received: from gmail.com (111.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.111])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b0041496734318sm46198903wms.24.2024.04.29.10.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 10:05:13 -0700 (PDT)
Message-ID: <57b6c818-343a-450a-8183-2802abf1c62f@gmail.com>
Date: Mon, 29 Apr 2024 19:05:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
To: James Liu <james@jamesliu.io>, git@vger.kernel.org
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240429010925.93205-2-james@jamesliu.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Apr 29, 2024 at 11:09:25AM +1000, James Liu wrote:

>  int advice_enabled(enum advice_type type)
>  {
> -	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
> +	int enabled;
> +
> +	if (getenv(GIT_NO_ADVICE))
> +		return 0;
> +
> +	enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
>  

All hints are set to a default visibility value: "none", which means
implicitly enabled.  Maybe we can get this "no-advice" knob by making
this default value configurable:

diff --git a/advice.c b/advice.c
index 75111191ad..bc67b99ba7 100644
--- a/advice.c
+++ b/advice.c
@@ -39,6 +39,8 @@ enum advice_level {
        ADVICE_LEVEL_ENABLED,
 };
 
+static enum advice_level advice_default_level;
+
 static struct {
        const char *key;
        enum advice_level level;
@@ -126,7 +128,19 @@ void advise(const char *advice, ...)
 
 int advice_enabled(enum advice_type type)
 {
-       int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
+       static int once = 0;
+       int enabled;
+
+       if (!once++) {
+               const char* level = getenv("GIT_ADVICE_LEVEL");
+
+               if (level && !strcmp(level, "disable"))
+                       advice_default_level = ADVICE_LEVEL_DISABLED;
+       }
+
+       enabled = (advice_setting[type].level
+                  ? advice_setting[type].level
+                  : advice_default_level) != ADVICE_LEVEL_DISABLED;
 
        if (type == ADVICE_PUSH_UPDATE_REJECTED)
                return enabled &&

