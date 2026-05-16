Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530AF280A58
	for <git@vger.kernel.org>; Sat, 16 May 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778941291; cv=none; b=K9yDWM65UZondS7/1QLO+5xWDXq3y3xjiWUUPunxfv8frwKPqhucB2+UDq40iGlDYBwmjQtGFZy/67j7J/JYn+AVMaLrJYbYEgEiAkKG2+OrqrTlJrCGDjCKylyrmq919ETDlWbbdb/4svlfH8LwVC3ixnxouYNYB4+QJOnQixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778941291; c=relaxed/simple;
	bh=NW4lBPjQ7oLFOLSClA6Ah68rXnjOL01PP0kGgyqk09Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gy36guxI78x9Cb8NPlLoHWJmaSYhaCIW582gNuXwlw3ru58SIGMjm/OEljuizObjWpGJauTzHEtDnB8iAxIlLPgGVxtIa7Xc2I9roOBl7HS1m3SIW504QAO4+yiuUKPNN3JvpfSHI5TfRMqJ8SO7seoVE5Qe69oADgDboMu0T50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFYh+Fmw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFYh+Fmw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9125d2a4d36so55732885a.3
        for <git@vger.kernel.org>; Sat, 16 May 2026 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778941289; x=1779546089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NW4lBPjQ7oLFOLSClA6Ah68rXnjOL01PP0kGgyqk09Q=;
        b=aFYh+FmwMkj4B2nWfZOlAdOLYGBu07CVsWvZ+bXOUoEkerECN3AGY1FGMNnbZGEIIE
         J/DrU6DPz80rDwsCkNmyXDKewYy5B1NWehCJXDcpAKDwBP+B/knpgEsKEM0wkSigWicI
         eU87Sox9CfFddUgsnX3j/0ATzBggI/OkY/koiJgi6Fwhva1GUO1bnADxUCKSB2GCPKRQ
         7qnKatJ6d+SWqogdRhWxpXPQbZABGkZEt6QhgOcv4eXVFGkWhBFfkWD2T+HVlYKnab23
         cDaVR299iAI2EpEROO3B3vdsQ5lt9UTf9mivqdgypZxUW2VvKSmV0/YHsDOYNuPp1w3M
         Y6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778941289; x=1779546089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NW4lBPjQ7oLFOLSClA6Ah68rXnjOL01PP0kGgyqk09Q=;
        b=ZKIkgFyL3G6JxHGKWdPUOxqRgvZ7w+vDJS20es7lQWO83ReR63WRAHNQXM7GtU9qK1
         A/wbC8SEfeooTDP3mDdIaHPx1zKnXyW+EHyfsiB7WbCtq7Ihu+FPMselZnCXdNbbneve
         wJHHGJBKHcqou3vt+BVbN6U2eFmOz5f3b+NgC2xASfTFIYVr+KFUJEd8DDE3xx81nsr0
         VrwMRKqNX25qfR0a2HDCr0mdDRgLimGScGcLXUFECKP3u2g0ItXcQLtw7tF7ctAqEcrp
         41rGUkRsFwdUBeNzRo43hxkkgz8tiiUMa1KsJ0J5dHz1L66+N46xXYAHdxvDNzqzDQDV
         XGkA==
X-Forwarded-Encrypted: i=1; AFNElJ/Hz8lLPPzcF1YQWdbEKkuCGx71rNQlHXWbOIxtFaSUIsfaNsTzrkgsbLKiFXRtxPtembE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevRVOA0p9m/MrNhx0VA9WjPcP2pdaOy+8mFnjtau3y0oQxDKS
	7WiUOml/6kIPW0q0jH3dovyxEu0QhWd/mB5RvrOt1OXO7zqw12s8WpOkl2yMBJkf
X-Gm-Gg: Acq92OHOlwuTQsGGfAqpYVVrIwqSxgSKQ1VvN75fG79udnzdkYn1QWY5XftNdCHs9oL
	WolX9RUAaHxp+ecdcmP6aXnlRJRk5SePiD/gj+OdJ/sQfhajsl9QN6DTNeOWOzlIwX0KqWlo4km
	EvD7/PzaCzflb8fznW4D0+Mx7F7rAv/h6E97cO+XhYrdKDglqku7MgQIqQgy/MVH7oRqkGMGncA
	q9CbMEHzzuFB5FYBJvQphdiWxd5X9/3ADPzPxIMmLMGWpTF6ymXNRp4BsBD5HGRyE/10YnXDW7Q
	ZFRULRDaMODmeE2iEbXUw+YPXYhaKTwoowJCP+fMSRkGuVyNh/zi1NyvgbDqHDNmRHir/hsDcwT
	dLPeC5Wh+KgPRnJqVAh2NPfzptoI20kZLX4s1FGJaB/uQQ3QH4BqdeqZa06+cgSHFSvBTJ/StaM
	bzjgIeM1hTEkpvwpyVcwNtAnDD4m0aP6s/4MAWEmcuJjUaTD8kzujpzMjrPnD8ElpWo2Dw9NEWw
	3iSDCEjMA==
X-Received: by 2002:a05:620a:2546:b0:90b:584f:7f1a with SMTP id af79cd13be357-911cf9dd375mr1347821585a.45.1778941289194;
        Sat, 16 May 2026 07:21:29 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd6243b3sm880001585a.44.2026.05.16.07.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 07:21:28 -0700 (PDT)
Message-ID: <465bcbef-bec9-4f7c-b55f-ed60f23cbcb2@gmail.com>
Date: Sat, 16 May 2026 10:21:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] git-gui: refactor browser / blame argument
 parsing
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-3-mlevedahl@gmail.com>
 <cb3012ab-1a97-4197-bc57-34eb3fa472a2@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <cb3012ab-1a97-4197-bc57-34eb3fa472a2@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 11:56 AM, Johannes Sixt wrote:
snip...
> The check for the existence of files is actually necessary to
> disambiguate the meaning of the argument. If a file "maint" exists, then
> the argument is to be interpreted as path, not as the ref "maint", even
> if that exists, too.
>
> I suggest to protect the "file exists" calls with ($_gitworktree ne {}
> && ...) or (![is_bare] && ...) to handle being invoked from a bare
> repository. That is, in a bare repository we treat arguments the same as
> files that do not exist in the currently checked-out branch.

Let me start over, addressing only the use-case in a bare repository.

Mark

