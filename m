Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B14176B
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAdd22Da"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d22d3e751so7445515e9.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 13:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703107320; x=1703712120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oP7x+H9x3oyb7+ok2dqohR9K0bPNC1MU+08YR6zlanU=;
        b=DAdd22DaDy/5ZUKO6wqd+SGHPJ4tAB0ApcraLoLh9PpaQfGffLa1SG7I8FnSEScv1t
         VTrjR4qqFz2rvCJsj2Br+zrVd6S9yjSgVvq/IVSnLpElEjA2XcLoPZI+23n9b82tVbiZ
         Gcxe6KKQjUln+sdGHbYYQbg+AeA68ESUNiWbNUb3BGZ49bLwXRvxvuyXS2dgpY71AKV3
         DixRJWTyXmbDjD5rFyOaDEDW8kDoesF/DVpcGcr5rZl72tDJiKlGTow/UecXb4JYDK3w
         vNmQ2SfiZX4mly0qQkINNikhHM9epA9B6IFTXCHnh5Mt4pTvduCbHgPknGywHOjl00xL
         lc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107320; x=1703712120;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP7x+H9x3oyb7+ok2dqohR9K0bPNC1MU+08YR6zlanU=;
        b=mj1W4f5Y/jpWtdr/P67nc6YhFEdlMCYxavFhOA1Y1xcwAEzgVhZ+1TrXk6DbjmBfSF
         4WyD8lGGCkbD1XNhH6qYXcgU9hOMZglF5/opOj+NX8Fecccth5eMIR3M78O+dsXDEBaG
         gvhUPJefE4H7i35DC4IcqnnJIp/A4t5Kh2ekilsrL5KS7wHS/HoHbaq6+/Kb+CAJmEJv
         ISGRirmNcLrfsO/VcRJ1eIoNh+ODJ2XOMwvRfgZ/RKGUC3G6QMinTwfQ+o/nligOPYrl
         P3QRqkzcFwMhc/XlnWZiVLHxm7j79AYaPRhvGFyebaVwZWNvUqiEpa8xVq63JywRAxeG
         oLEw==
X-Gm-Message-State: AOJu0YyGA2YaUsyXjc2CpXJqFtZhr5P7/2YxpmoidX41uzd2HOe77Bcl
	wb+yVEpsjOIqCP7pKVwu3kD5ic90RHM=
X-Google-Smtp-Source: AGHT+IEXJwJ5EXEBMFpHCvwHyUoiTJwA6adZnYNxQ+cyVzOJnGL2Ob+IFcDAXXWWj+YJzho9ZS2oVg==
X-Received: by 2002:a05:600c:3113:b0:40c:5578:d14e with SMTP id g19-20020a05600c311300b0040c5578d14emr142314wmo.20.1703107320016;
        Wed, 20 Dec 2023 13:22:00 -0800 (PST)
Received: from gmail.com (171.red-88-14-40.dynamicip.rima-tde.net. [88.14.40.171])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b004094d4292aesm811278wmq.18.2023.12.20.13.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 13:21:59 -0800 (PST)
Message-ID: <8a3b5a71-0207-4129-87b3-e4e3eb7c797b@gmail.com>
Date: Wed, 20 Dec 2023 22:21:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] orphan/unborn: fix use of 'orphan' in end-user facing
 messages
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbkbj97a9.fsf@gitster.g> <xmqq4jhb977x.fsf@gitster.g>
 <xmqqa5q4skwg.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqa5q4skwg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20-dic-2023 12:01:51, Junio C Hamano wrote:
> The two-patch series, whose second part is the message I am
> responding to, did not see much reaction, but since it came
> during an end-user puzzlement and was written to make the docs less
> puzzling, I am tempted to merge it down to 'next'.
> 
> Thanks.
> 

If you need some positive feedback;  I've read your series and it looks
good to me and going in a good direction.

I think "unborn branch" is a more accurate term than "orphaned branch".
It's not perfect, but I don't have a better one to offer.

A nit in 1/2, which of course is not worth a re-roll, is a double blank
line near the end;  which I suspect is unintentional.

Just in case anyone else is looking for the thread where the puzzlement
was reported:

https://lore.kernel.org/git/FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com/

Thank you.
