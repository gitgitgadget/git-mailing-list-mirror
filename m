Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6714265
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478909; cv=none; b=ODnZqCUGURYoF7J5FKBmi+voDYkGh2W1GztPvF+A8U2wFKV9BqCKsS8XKpEf2jFi5cr0gt84YeJvqtJj9S2IVFv9dH5rQxaQpHAJhwQod4ML1R93bIYMkYCvgfmonzjIei22f4R81H3jHtCzeLhoMznXrbP3pQb9Y2MO1OSsQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478909; c=relaxed/simple;
	bh=owBjF/6ngXjOuPWVSHWoQnKw9ROPtJc3+yZfXdSOHAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZiooMtX59W99tTueKaaMzS8TPbfXwskqNtbEXpeiWcZFku8BX75YiE0SIQsx7n2Jc20OwNoX/VDsO9c9avnG0W+w6sr4aBzVkwmrvebH6N+3hol4zY46/ZU733yLRjUvhp7q0w3EuzpyStYuDRX538ifrkj5PA3v9l+Vd1rUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOX3vQNT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOX3vQNT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4149134390cso2803915e9.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478906; x=1712083706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZnc+Tu7V8QSQKT6w0YgO5BBAuDnHYwXPJBbXfW8MRU=;
        b=DOX3vQNTwm7taRuVUSfSjyMLBFhcwKJQXu/XUaRom/9MvLFAPpcs2gvQdzHOVOqAX0
         YlMu0+B0ndOR0cI+aAz9Xi2lNmsCATzFSHwl1Jx6NjoPJVL+8i1Bj9wDRoLYG6R52SUN
         idqiDFMFOePnRSdGikXkrxRm6BAMa90LIuYA/+WXRjulx/P/0cNPffwPbNckgMsCgitS
         6SvSHN+oTvneJrcFtcF8Z7PdcVa79dnEFvp4ajCq3+kxBnADcszkXONGuLYRCfTRhFVe
         6SHcO4H9jtUCpY9jYBPOABnRkKPcwtMaSh1Z++77Wygwhs+rugiDRAOPh8/yQAJuvk9Y
         Q7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478906; x=1712083706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZnc+Tu7V8QSQKT6w0YgO5BBAuDnHYwXPJBbXfW8MRU=;
        b=YDNDs+GoEPy9D76gSKdLpa+Mve14Qb1ff9qfMmUzWNAGRVLs2N4chNALqb9jEVdRHA
         kzLNusD1jpTlD0FYQUH2XTu1+vNmg1dMF0poq5yoliSxE2Q0I5YJJkPo/RaEc8vUZt5W
         EvTO2VPud9hiqf7uimEfdQ9d3fEKSm9d3/zaZEMMS02RFn0DrzIxxuHWqr4EG+iSqdj7
         zRcVnYaqZO+ulnZNEQSUMPlEQfQL/0g6zpGsFzhPSuW7bNx4zC/L/oRomjwvzCv/Fsv6
         Lv6odsuXZ4Fxa0PYCPD2c6oFVuniYR+HB/a9SjR4bFg2OYKo6oIt7cBhsXGqARSQ6rIc
         R3VA==
X-Gm-Message-State: AOJu0YxLazzobgwZPdIMrUt7i5nT3U+3TFTd6fpSlGSyEPpfI2Tsx2nU
	aiScJJkoCOKI3EBqazyPDTNDjen8KHEE4v64IHQcwJ7EjMCzgxE1
X-Google-Smtp-Source: AGHT+IEsUq8pIwHVRasiwORCgJm8sTXJPcbEBBcMn/JISYWSlA3gWKp2yaPSwndRmvKE5IHQBVdE/w==
X-Received: by 2002:a05:600c:4f83:b0:413:2852:2835 with SMTP id n3-20020a05600c4f8300b0041328522835mr1514278wmq.17.1711478906281;
        Tue, 26 Mar 2024 11:48:26 -0700 (PDT)
Received: from gmail.com (156.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.156])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b0041490467febsm1836410wmb.38.2024.03.26.11.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 11:48:25 -0700 (PDT)
Message-ID: <eabf30e0-091e-475a-b59f-16b1091763ed@gmail.com>
Date: Tue, 26 Mar 2024 19:48:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] improve interactive-patch
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com> <xmqq5xx9dn6q.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq5xx9dn6q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 26, 2024 at 08:31:41AM -0700, Junio C Hamano wrote:

> 'r'edisplay may work well (and I wonder "r | less" or
> piping the hunk display to anything in general would be a useful
> future enhancement).

Yeah.  That's a very good enhancement.

However, I'm not sure how.  Perhaps with the help of git-diff-files(1)?

Thanks.
