Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92592C3256
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905670; cv=none; b=ChLH1nUavriq+nGUqb4TgDtpEWhG2yr8b+4EqNxgiy0z80wZKDuC+QaHKh7A0VOiBA9UjS5e12png+ZC78SSXz2FXgpM8RaYBc3DmvjmL5ObU111A+8VIda4kko42UKUVskpaQiLuv4Nng02OQCGQ5wyH+11I5neFviwadD060o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905670; c=relaxed/simple;
	bh=KxFjnNms0M4oThQgXyqKhKK17U/PP5I0uJlfJMj9hFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=miXxUKgLvgFrHSeWDD3B8am4/b6IbCcoDUC2/GRDQYSW3q9HGRNPy6CMncFg7rigUehzFG66ANkWI391rLJo9+zMV40JBpgmpKBr+baZYhytrSYGWSoY2imuddFCefYyyBsjx2npZhAKwP+wNhbVDtxB5rDQXzOK9zLzAWzulKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhFnN62Q; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhFnN62Q"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4806bf39419so14469055e9.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770905667; x=1771510467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZkO/HejhWlZ+b9BUtrFjOvLtaEjrnWHvHT+0b/LWpo=;
        b=RhFnN62QBlaQSGdGNmaTNvahAFvf4eJOYh5oNQdBwDT2FG7qd0cqiGB5qLMkxt0i3n
         QgRcVc0qzwTRTL4uW72oFWlNsjlkDHkWEFJ0Z66P91bvO/4EDmRApOfwlE6X+20IvEHz
         R0RB1TXnQneOfDsLkFWTbyiF8SXBJDYrc8JogyerU3OMmgopO9FQF7Z4F2vW1hC/XAxT
         fO1piT/bwHMF39icf1wx43BGLeL+6Lg2UeXn9DtyOYX6B1kS3G4EsjCVEIs776R/utcB
         GoJZXLxxug9lBeA6kaXVeopMNoN5rB23LNVDWYpz84wJkOOXsbDVLBgj1hiC1n0czCPG
         bbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905667; x=1771510467;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZkO/HejhWlZ+b9BUtrFjOvLtaEjrnWHvHT+0b/LWpo=;
        b=h2polFwIWkF/hQx5s5s1mV0MvkYNfUOjSOJtFoKpuka4DQM+cdaucm4o7O0/rCeAt6
         zfDqHmsOkLpmqEKfOw+qNDbWdnYQ97Slv1nal+1cN8fLA6FkA/jWeqW2ZPab4aOJRcWo
         hN0dcnFs3NbwCAFm72bYnn/JkaUrvTKGRtngq++J+jZM+ffFgZHr8/EN6B52hO9AasuO
         ICzlfr5AxUXTH5ysiuvZx+2Y/rWXzsYf50jlRcGOOS9CTOBnVqcpjs7YltAeq0QwCOj0
         dnZXIXsYJhVy0Ybbp/Ue/eOBbSLBkvpDyj3+d9BtQJ1U7oaQoKuTo6GC7DoHboTbWfKS
         i51Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnZ8ppX1A+qUMCQcpoL9iTzoz0KovaAkO8rzRVUzOOBJdMpasgNScqSke87fJtSfecXB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwewoyvVD47a4gMoeU03szOSSX2Ph6f5Tp3hdNqOGdk8RbJwoKJ
	VwD4A5jT0Z87x7PoWBdF9vzb4C+Lq61gwwVXY81GUD0GB5vup4wQnA8L
X-Gm-Gg: AZuq6aJBgkEwl3ioDVd/Ppc0gsywJLZ2pxZ3nwg353B8jR0jgN9+KJXUbxe79IEsPgh
	zOFM0Vaghb2xKHafJZdTVBhISTWlyyNUdv+4Z8fyXw77b5peiRY6NICUKVxM97BC3n+n1TZrh/6
	fdDYIVVz7SGaqR480Oaa54SFCS79XxFbM7Z4mol9nE6eg1J2xuInoX4Qou9wueChLTU3s04jzZd
	ctNZlMDYr67QAgnqEdRkUcTptA8b+rvvXl/4iDeKkRisrqLZEVNtQPSV4ntCV6n5UjcO1LBMbo5
	4CvszyVN8xlWNtkxVrNSXvsOuTR+oOUVhKyAue49JaTmd6etMnQUdNwvaERK39nTeFXUUsNkSLP
	RDrHDTf9dnankl538vm7YwtLasudS4JeN3h2ZEJSxYc226CWwlcVCNXMO6WHHxdizciwLwE7uGc
	vJoS91SxGZf0zqvNNqIssVqgwUmupA/YXebGL/hpby6lL0en/6W95OAYkNSSj9Zkioj+YbiD34P
	CMc6w==
X-Received: by 2002:a05:600c:1d99:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-4836603adfdmr43387735e9.16.1770905666645;
        Thu, 12 Feb 2026 06:14:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835ba3df7asm61739105e9.4.2026.02.12.06.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 06:14:25 -0800 (PST)
Message-ID: <0ff07837-643b-41ac-b1d6-f49f6668c202@gmail.com>
Date: Thu, 12 Feb 2026 14:14:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] meson: regenerate config-list.h when Documentation
 changes
From: Phillip Wood <phillip.wood123@gmail.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Evan Martin <evan.martin@gmail.com>
References: <c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>
 <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
 <19d86fb2-cbbe-4753-831c-a6ed49722103@gmail.com>
Content-Language: en-US
In-Reply-To: <19d86fb2-cbbe-4753-831c-a6ed49722103@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2026 10:29, Phillip Wood wrote:
> 
>      printf '%s\n' ... | sed "s/[# ]/\\&/g; s|^|$OUTPUT|" >"$DEPFILE"

Sorry that's missing ": " after $OUTPUT

Thanks

Phillip

