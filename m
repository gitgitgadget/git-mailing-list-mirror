Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D69175A69
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776638475; cv=none; b=WUgqOMNtWzZDGRg9kheL8q4wB/LGEXdlJtXQ4qD0ec8NEYF1gKEn/D5jkRQk0H4xNNeMWaKhTfWMbNHdvCGKpLIBTDa03+SjzC2RfqQalSXhZIStauZXZSd4h24DBms/ZvtxMX0vCwpD3fu2syVxMpQxvKjiHIYrsOXl3aRnsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776638475; c=relaxed/simple;
	bh=IWYGU0/c7E1Gyi+IMcbkl+5PDhpRlevIZQgBeiWo9+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrWa2CwWz4phPxYM+0w573idueZIQM+PHDow9RaWYrV/tYoJmnzGLfW3JDYTCfAM86ZvpOG1bSOtrYNm88N1i9vFha37qqs1YjSmmfybe7bgm5AFfnWdcOeGc17KsCtuZQW4vmr4O/t/v78A4NyU3yEcy3qhY7rKnuuVEBSydiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHOVO5cY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHOVO5cY"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d876329bbso32015461cf.2
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776638473; x=1777243273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUUbL5JTP/SyFXFzgqloda4BrNbz31QMcyVskF3YWko=;
        b=nHOVO5cYPc6kXe36Wh1qgYuCpc0HWh2pYses4F5YPg3G4+BFcv0bOoLD3Xe/2T2tWh
         zd+x32k6pKwEXWTf8aM485Ua+wJ1dXQqn//LCN8yU0OYDkgEV8jqovGH/N+hDrgVRfPz
         lrGTHhAkQN64vl6H5dEl2tQPCHYPWpJwMV8mD5rUsAZmR4CZJcjqv+gpf4SvLlQmlG5c
         gHs+MpU4wK/ryWmkDaLQ1llV0V0BwfEQRIxOUYEsBHv6Om7ou9eB4rHLc5dx/Iu5ojeP
         BDmWND1otvyW0X7m1ykLlLvYrSemsltrE0BQBFpA3ykC0GNi6w19eTwSpGtZJzoEYEw8
         +Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776638473; x=1777243273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUUbL5JTP/SyFXFzgqloda4BrNbz31QMcyVskF3YWko=;
        b=Zq11HbUSJIQOct4PdpQGqNPAS9HLbLrx9p69TzKHkffVDfVXh5PV5fxlyS/6eqE3EN
         KArviKZ6enJB4s5kWGRpbWun6odgeiv2rIuK+VLKH2nCmldMLBmknafIKz6uIRzW1k0R
         nm25S6tjaVffzDt0PPrc7NYQRwlNQrI1D42TYReNRp4hFeVF7BJdgT2m/Qy6/xpdEohF
         TsA3waqFoWrSOBVS5G2YzHzZOTkhfD3yqYNPftXdKlJ5+GLpbYh2kw8aujAnj3Yt0aO7
         azC43IGWTwbgLjRrbcE5LMcDF4hqH6oyrxB+0ZlWN0LgkgFCY0tib8c4c+ZrgzB9qwMX
         6grA==
X-Forwarded-Encrypted: i=1; AFNElJ/X0Ud9Q2nEigElLbhvmPWqTAy/kS14JOlznuD8aEcG/arrMXzSYUxZVcVNc/aS/fURUgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Qnt5oJojiqASVuSLrEIa7wxEYX8K7FnVuJWNloiuNuMX/9ex
	rOEZ4tWVVN+2wmRWLXa+dRo8xWHDg0vQNei2v2p2YuiBllRKPmFG6zFz
X-Gm-Gg: AeBDieu5HsJydaEItaGBHEjTmmpr+erUUqsAlom1qTgE8GOAJV9vA5oeZgBWlQ1rJxX
	u5j7fWY0cRnagL9c4rZs2OUfDBimOJN+hZ3h0XmzE17VbOhosnQylZ2rPp5r0ph3oXtCDNB4EFr
	59pU8HwQ6qbWa7+fJ1LIsxToiAk6YWGZNLQFsuPstAN8Zo9UqE47b38e1uknclN7GRNQgm6qKfJ
	6Ral60FqCqEQQvuiCB/f//gk6rdKYEg7n8NehTfUGCkuagfZmMV4wU3Qujg1LC8HVlODuy++RwT
	YIXxYlu9MpU0pu5ordF5iJTo2CGwRDCvhZpRf+5l/wIO3AyppMxcoe9F9By20+OUm9v7sZg0xr+
	z4YqWCG5lqd3UAFz15yLjoa1AsGKLVAQGGfj7HuSKUogzqF1xOBZJBvswJ6Vux2ePmV9f2dAzI0
	co+9ZDKzjIMUF/MgffIQSSR1mc4ubksuHbeUgFxEbJH3e/qWKpt0HW89lEcdVjtmo8NPMDE9GVo
	K0nrTUA4orFtLbM+g28Gn94xzSkHmRfe8cBTuExaM3OsT7WaMdRBeVt
X-Received: by 2002:a05:622a:4245:b0:50d:8e6b:96ac with SMTP id d75a77b69052e-50e36ec5cc2mr159627221cf.58.1776638473089;
        Sun, 19 Apr 2026 15:41:13 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:84d:e5ce:d94:dc76? ([2605:a601:9b88:8300:84d:e5ce:d94:dc76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3949c94fsm68224721cf.28.2026.04.19.15.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 15:41:12 -0700 (PDT)
Message-ID: <24a970c5-0d01-4f1d-b6ea-50be646351b3@gmail.com>
Date: Sun, 19 Apr 2026 18:41:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de> <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com> <xmqqik9q3n15.fsf@gitster.g>
 <aeFGumIlw+vcOt2a@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aeFGumIlw+vcOt2a@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/26 4:29 PM, Taylor Blau wrote:
> On Thu, Apr 16, 2026 at 09:09:10AM -0700, Junio C Hamano wrote:
>>> The part that is striking about Johannes' report is that this happens
>>> on a fetch, so it is being written automatically by normal maintenance
>>> activities in that case. Without downgrading the default version back
>>> to a compatible version, deleting the multi-pack-index(es) will not
>>> keep the repo in a good state.
>>
>> I am not sure what you mean by "deleting will not keep the
>> repository in a good state".  Isn't multi-pack-index totall
>> optional?
> 
> I am also having trouble following this.

My wording was bad, but I just meant that in this scenario the
maintenance was generating a new multi-pack-index without the
user directly requesting it. If the two Git versions are still
interacting (or Git 2.25.0 and libgit2 or similar) such that
the multi-pack-index continues regenerating with version 2,
then the deletion doesn't fix it _forever_.

Thanks,
-Stolee

