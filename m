Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF13ACEE6
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764088; cv=none; b=Uzh+L/2YXMK0ubgVlZ3er7DIdiPrqyu+ZKjbPPn5ZrQ0y6sXpvZ+78bR0vWyrzr/uQyDYMia1yiZPxh3Bk+q4tcZrhQ5Kgxo7mbaRx5mUo/5pAamvsDeCkpW65ODQce+/XLHOwvNh4JTG11OkWlZ0ZCGZT9WKyOhoPcUWqzv6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764088; c=relaxed/simple;
	bh=ohiHiKaVE12UunI2Q/Y/sL618IUC6/vjaNpvPbBOHmg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xn2RzGWTyDKTz8oG00u6iV9egwiQVacR0HQ0T/UXa+uNnTC5kVOuxZIBtXd2M+Svgft2UrAq1kVAuRVMhwZQyEdHPJMimhOZZarumWI66FpkFoL9+cnsI+i/kYSyP0p5oSgWTQmpED1YK3N+2Va0ULoD1VyKOf+J4g/1up3p7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSt/zng9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSt/zng9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso24218585e9.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776764083; x=1777368883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kb7e9fTl8N8gg8PjdxZhQO9yTQNKfAnK/4yVZfdSEc=;
        b=XSt/zng9lg7RHbPYilTLiAZOrITKU3gxmzfQ7QpSmET5ksO7NeHC/Sw3i6u1/U6vOo
         s8SjnfTmJqM7o5VoBblQhtXYou3kEGP+Qaot5xap8zlNoY66L3OzcSEqImir9dEsjS/U
         4sOVILW/IuHUFMTCsySd8J2IG8xsWPwD8sBw3KsnjqNdHifwUotif1b5Zc4nbC0Sdmxw
         Fjis05ukdq3XLolcTdPprg51s6KINHA+fIPIDsw77NpXxzK262lGL4MqN+kfgHR/XV5T
         ZIXUc+VrDHeBU9TbMU/b45JvgHD8hXuuZzjhybPnRJ1FIPElBp1pu4BzB10c8gx0WxAS
         BkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776764083; x=1777368883;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kb7e9fTl8N8gg8PjdxZhQO9yTQNKfAnK/4yVZfdSEc=;
        b=GNurpUwcybhYCHmf/c4OIw4JcKSf9GkdnmF9nwuWBp5XqYTF7sQ9+cPUBzD7Testhz
         ddYnAEGw2c0js+TitkUgGPrq6HVMM3Ok+zzxz5nZLweFANN79p84kGVXQ8E4E0wE2dTL
         qnIARf8+BcZTUCJXpqT7SUtfNnj1MhdIsX20ZBly6JioXUsnZ6Oftx/6qxjfO27eLPhj
         0StoQiwkisRQiKuuONGw/sUoe2yj8ef0STpcF9lnAKMd7BvpHePfBjWT1SjZtJYsaIWE
         Dume/A0afiA4+/a4XXGI1HMKImZJgT4MNV4RyUamTUFEabzEZk/+pos/tjPFudc6XJb7
         b8FQ==
X-Forwarded-Encrypted: i=1; AFNElJ+a1hO2qMrgJoiUBh2V5UhHV8hCycFC6pXqlLWHbcx4VOgA7OBWk/PkntTBBP5j/I6cxGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRoQvgqrFQbKjj0p9XfbXJAL5rW+XV0lVM6mS1OFIOt1VR4xn
	WFh/K5hbIdvfOUCuTV0WGO89fkzFognQzu4AgMadSc9P0PcKiW+ILmbi6Hr0rQ==
X-Gm-Gg: AeBDievyIjE8BlzQe3Z0iKT39gkK60IZWvhU4JFFJtck5yQTaktlejor7r/VADVTAdl
	bZw5axljaq7fKpB54r8utoGuXWc8ZddAw0TuYDhZsCdK2KMR+OMBa1iUpvPZdGH1C6BWV30snRx
	O1sznfd0BYt4DYfqM+UPWsvJMp/NhCfeDw9Z+bzMrgVdEVs3Lcm4ju/UUYfuz5Pgg0HmrD2Navg
	A39v7OSA6YfMKL6HhmXNhOs0uT+SV+JYuxNYWWWHHmYnQuCFNi13rzZMUBmzg3k1dLvkDdDth8n
	WrS7AAFjN4UF0UOINB65yZIDyUG8eLuCKeJfcglh3miwnv8jCtkVfsugQkmbrsZ0LWbJPCF78QG
	ds3KtTWQmRJGgTVR00csc61k3ijdNZXGC4o7GkzlwlljDiG1Lak6V6T2EC34CM2IazjnrYGwLDd
	NUsueKx4oycy2lI/voT43z1Eo0rn6jMYqOgNKc798RW+rFTZ9vWtpsJHlX1wQXJ1xH8KmgqVpSv
	4bJiCQvq/3RLG2taUDvKz7S
X-Received: by 2002:a05:600c:4fd1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488fb78ede0mr247548165e9.29.1776764082924;
        Tue, 21 Apr 2026 02:34:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm81180165e9.6.2026.04.21.02.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 02:34:42 -0700 (PDT)
Message-ID: <09d1390e-8334-49e6-a0b5-42d298db4caa@gmail.com>
Date: Tue, 21 Apr 2026 10:34:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
To: Harald Nordgren <haraldnordgren@gmail.com>, gitgitgadget@gmail.com
Cc: chris.torek@gmail.com, git@vger.kernel.org, peff@peff.net
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
 <20260421075300.49672-1-haraldnordgren@gmail.com>
Content-Language: en-US
In-Reply-To: <20260421075300.49672-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/04/2026 08:53, Harald Nordgren wrote:
> Hi Phillip, did you have a chance to look at the latest changes?

Not yet, I should get round to it later this week. Junio is offline for 
at least the next week, I'll make sure I've reviewed them by the time he 
returns.

Thanks

Phillip

> 
> Harald

