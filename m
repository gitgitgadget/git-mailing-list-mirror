Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A5270ED0
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721739; cv=none; b=rABTFdZYozqXbV5nwuOcJfkzs277Dtu0VEze9esY1yecR7FIGl0uZj9li2AAc/ZoOVJQMx5R7AmeV/S8U+GzN8BjRNfo3/bYbgDC+tEYHsxGJYbjA5kKFt5QsOzWTtP5Zbk7nujCzsYikKeOUfdK3k7afQSV/vjAB2FXtkmEeZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721739; c=relaxed/simple;
	bh=y24xhxxcjcDfJUR7KhbBHmQJOZ3O+GHASBIRJAG2bCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0CW9Vy/L9UiosTf6sd1/hmTq1gX08VCLP1U+t2aRLn0ocj5y2+GpQ0p3zJ8RU0JftorEVPxy6RqUjt+GGg14WAYu0GthMha5AnN79tjsRym1QShBcLQT+nuWTzOT/wiIGKuU15F/K25NDeae1W7yDQopIDigA6NuJ8Ttk9A8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncEqHEqu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncEqHEqu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441ab63a415so12329875e9.3
        for <git@vger.kernel.org>; Thu, 08 May 2025 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746721736; x=1747326536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSo7bE9gTbviipY9jhaEuxGSjF0ccTV7acBSJyJi4kA=;
        b=ncEqHEqusS7dlbhS+m0bEs3IKVf5L/kmopR5LDZ6ukPVFSlyu8AiEq6Dx42UaMcoNw
         mx5XX9I5jpRRqaT1xxUCiRnfLizcDGjsuknyYkoofLabUkA6BrKdF3mJeKa1kmQ3oZ1Y
         XR7ge5/9EXbtzoOn1jKXmfTFMdYw0h1JbyRvcxuxA8Ted8GHFTcHNisJPeASzz3psb1V
         4qOv7CB+AgrU+R5S0DYt/jjsQzkxyA9vx9Cb3xh3aBM2ECFC1cAg1RvBWBLWme423M85
         VnA2d529yXFs0zoOdZb49eChA+Icu4U1N1UenDqt1jJs01oMdMaaBKR1tHquWpm0h/7w
         U5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746721736; x=1747326536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSo7bE9gTbviipY9jhaEuxGSjF0ccTV7acBSJyJi4kA=;
        b=lhdeCtQGb64wI2iudv8YHEAsh5w/jpMJChqcom4dEzpTAd4Z7nvlo6KCyNVzHSOwIu
         airPApFq4XK1QPaJsEo2DdzJabV8UuLLp3pDNJ3ZowhuEjbM/Cx4EdSjNYYGTlqxbQrR
         anoSEypon2rGOIgPx2WDd4Ml4erypbWO48wbL+UK/gnEliRlHpVENmEYuYJiziDkdkG4
         Vi1nKZDHNSVwojta56iA5ORd18whtJf/AMy6p6IdOHePmdxek9+yKo8zhN6N1iSmcOE/
         LWZQgh8ZUha+N86hpQjNxLSo8uw20OF65Eghe4WdgBuGwQdM7O3i9PBa4eZmbrkLrcXw
         eR7A==
X-Gm-Message-State: AOJu0Yw51djH2yKzWYouOaToqoUfVohEi97OYtmN27cr0Kk/cuAPgeQf
	PW3yz9m7wUEmnR/h8GN04bw0aZQ5oSprAkO1eITpKQdILM/LdvLZ
X-Gm-Gg: ASbGncslNP6uD85x/eRYKyc9WvuOrufzXF9RRjleOzCwzr+ZamOJ7UU/JsRm8bK2a6E
	dFATcsgLOGfnL4d2rsIbCNQ6zk/+l8MdHW/LsQeWlqEAG3XPMpanoM+43wCLvwiHDdvKx7Ae/sJ
	v9ZlftUucYNPNcVETZu1lCiX6Q9DtViFLkbQo22tpWZ4yLJjqRG5Lt0xxN3FFLWqO81kX86bruR
	eRwTmIRvme+HKiCiDuYzjLf2b5GsP61PaNQyJjjhHAIpCBiBCTEjcVTGx7XJ9wQqKIcpPAvJBKw
	M0oZ5BNth9li4JiP4USl+7yEWB/8fyEOZ7wsvFfSaweo9A0ROMqT3w45tb4cG8n3VWyp1PQrdoI
	jOh9NQbF3RiAVo1M7ekAt3FCon6qsvDaj9g==
X-Google-Smtp-Source: AGHT+IEAvbyt7bKaTVtnF9rvKPhir66jl56E0fInOvFdpiKqKzyCWllWbNO6nbEPAt9H9A+WyZStyQ==
X-Received: by 2002:a05:600c:4454:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-441d44c36efmr63281065e9.11.1746721735652;
        Thu, 08 May 2025 09:28:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:3cd0:e939:e6b:f95c? ([2a0a:ef40:700:a501:3cd0:e939:e6b:f95c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aeccdsm41830215e9.32.2025.05.08.09.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:28:55 -0700 (PDT)
Message-ID: <98415c84-a5ab-4bf0-b361-dd60ff3e7dd2@gmail.com>
Date: Thu, 8 May 2025 17:29:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5ad7fff.c587c495188189.5980390754046003962@linux.beauty>
 <951d3343-fe97-4e7e-bb73-1c569ff10ee6@gmail.com>
 <196b09c1324.fba686d21234508.1995945025408421751@linux.beauty>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <196b09c1324.fba686d21234508.1995945025408421751@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 08/05/2025 16:55, Li Chen wrote:
>   ---- On Thu, 08 May 2025 22:17:17 +0800  Phillip Wood <phillip.wood123@gmail.com> wrote ---
> 
>   > I've left some comments on the changes to builtin/rebase.c and the
>   > tests, I've skipped the changes to sequencer.c for now as they'll have
>   > to be updated to avoid forking "git interpret-trailers"
> 
> Thanks for all your great reviews!
> 
> I'll address all your reviews in next version.

I forgot to say earlier that if you have any questions or queries about 
my review or the trailer code do feel free to ask.

Best Wishes

Phillip


