Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792835554;
	b=uh5YD4ExR83mhLicJ1EewDQA7o50TPi+dVIfoCTJjaPEc2+BdTMnVoTe09BOzXOHObQl
	 XQVr71Z5J87JPRBrW77X6Nvedi9muvQ8nXBnAdAM51GA1WdW8RPlip51+gnZlF0kY7s2T
	 9rEF3grh6f/UC583FJCuR3jyI1iiXKvMPwjcOuaJgyZl2qQfvK7fOKl5pG0wVwPNE0KBz
	 uG+h+60nv8BfR2WBCBJWTJdCMP5/ep+eUEblIXNIPnvKoX1d7JN61sh3Emjupfhy1XnMh
	 5w680Iy/m6XqGJr8qp/ea80tFGbUx44/IfJ6RbxHzu7OjGUcH3hCprDi30neZZf+kIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=s7HzJp+eNdanH5fcG0UlardPFGBWAk1NUgafEwk3MdI=;
	b=fuVLm9lDevD5btIWB3W/1Sz6Jumarm3hmhFiY/3EsttweBIFGxJCtiLty6bvoq7ti8xq
	 7cuBOd7BtpbEQMkGzb8NasHOIXOdp0QxSIqaYokdH97lfRxOVrU+iQu/0QgWhW/fJjzVP
	 S+lhfz2Q9Rr20F35e7I/1j46yEFdom2CjgOBLfgQqFTgCM7MTWVbY5s8pDp6gex5KNK1R
	 4i+IFmbpyvaf2rhBE32NKy/Dm6qtMHKCIpoqgaHqcHiO5oApxhfGdGFtcil++6F1nJh+N
	 +PdwvNSeaqIDJY9G1n8AGIBLR+BrY3gEMFswX4jTwlC70nEFpYmgcL5n14/RazVemNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="MR/cql33";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD9606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 09:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CCD9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MR/cql33
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so8869035e9.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792835552; x=1793440352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s7HzJp+eNdanH5fcG0UlardPFGBWAk1NUgafEwk3MdI=;
        b=MR/cql33W9uf2bW76oy4bCZyV0EnkRrLketR8mqA6HDZtvjCcdxegq4o5qrWxOHThN
         KuCeTS7iRgy/u8PZgeNQjdYKBZ/u9gaeb3RMB9ME1bbX0vCAQPEEBYNXgwKsLJXBHl0W
         o+QSQmAWAFt5tzFAq9R2dLy01zZ+1IwMkgJsQ3V8AJOR9FfWzPK14vzHY2BCjR7SnEg7
         XGUK7jLdDqgnGeXLWiJIZrMkk2sXgdaj76taXol6OC0MtxdpYZ434vhhD7lEn3ClBHx1
         t1TDxssYZkvZUTWNOEuQtx2AoaRkQWUGbillns968g8hH8bt+U8LaYLQdQdb2ZzUxhX1
         rJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792835552; x=1793440352;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s7HzJp+eNdanH5fcG0UlardPFGBWAk1NUgafEwk3MdI=;
        b=PTZ+CvUwxa9ZQVo6lj3LfyPXMdP+okX2IW1jshr9gIK8V+BsD5bwKY8FGXm0M7igrs
         UysxtYa91Ix8iRGyQri2mJmZ1J3nWywYrCwqAFw2/XMBa+8Q5CCohO/b3YjIDMAuEbJm
         W7IcS1Z7yFXa4/ewtjI4PFYXC9gZ7RSAkJhduCbvnGswV9yB/Bjh/ikuKYrQc15iGpUf
         azI4vHyQ0sFgbrcFiCkar0KICWdCvewupztX9nsB78xTM5nDEnChRLMm16kJScZtleDo
         6tLtwqvuZ/bMGcPaaUoo/l5AZ0szVckHWw2mGiLz7xoKPodrDIc5kgbldzUcvfZclVs4
         /vXg==
X-Gm-Message-State: AFq9FYLowBWrxjWBDYht92CGNqZo490hl/lYVtgjphbCwmPHyIo7rJ95
	VdjnVDSKLkXBZ0qf5ZK4duvTS7dMCNgSjixzYfx/EKg3liPm+/kvleKw
X-Gm-Gg: AYBFou15XiPFsNF3KghX9kSjdFVcai809hmG3ITqkw2zdnA4uERHCPzlePAnRgE0q0U
	ifTpm90UXGRcdDIqpZZpr10WYZjolsayiYUIzSTqeGgzrV2W4FiJwqWRqKl8/5TRgbrYAR/RK1o
	nfNb8aIp38+TFuuvFeB2qOFCXUNnTbN7fCjcvpplNzQ96ctAE7Av13xtrPx+udsuwFg5/XyTKzo
	CsGRf3aNxtWEAWUXy1oA0vI4+uxQnoRkAg/4Iyckmi7gMIDUi3wDde3X4sn7fBDzg5gb0ACb4mK
	oysm02ocoqcMOusljPqvh2BuMqn+RjBaxK0L/dfyI5Zj0moYk5ZCpNwSHr3wvlaKdUVj6TeTj84
	Si/jPaHwES6pAddclQ0fGpQ1cJ373oMW/ARB9nn2+p4VzP/MdRnRHITR6adRKdTNtNK4LZ13+3R
	sVY40dFNJgksX9AEL8nrr+SqBqLhA5b3efcX7zglnW+U+hJ6c1ncvQRFzciH1R9SXaOdcEH2SCT
	GU2sxLGc06gf0WT3/ZxQcZVWMDXoLkpRsOq03xrkmsiD7K9EJ1Cjp8JOcZboHpjY/MZOOpANiSH
	Q9g6gfiXVV4IZShl5CR8nqyWPJFwFcY8qUI=
X-Received: by 2002:a05:600c:6388:b0:4a1:e9c2:6c84 with SMTP id 5b1f17b1804b1-4a35acaed66mr20147635e9.18.1792835552388;
        Sat, 24 Oct 2026 02:52:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bb112sm47140165e9.8.2026.10.24.02.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 02:52:31 -0700 (PDT)
Message-ID: <bd00b525-6e05-4c17-91ef-3d9c80ff2784@gmail.com>
Date: Sat, 24 Oct 2026 10:52:29 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] Question about check-ref-format test coverage
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Fien Dora <fiendora5@gmail.com>
Cc: git@vger.kernel.org
References: <CACWAS-X4BqnMa8iJKTakF5E=zYkkyr=qsQ-=c3bxoAJ+Kpcfiw@mail.gmail.com>
 <CAHwyqnXEC7cFijGWATqfA+fBcn09UoNPBDA17GYEY4P8mS0fWA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnXEC7cFijGWATqfA+fBcn09UoNPBDA17GYEY4P8mS0fWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/2026 16:53, Harald Nordgren wrote:
>>
>> ./git check-ref-format --allow-onelevel foo
>>
>> ./git check-ref-format --allow-onelevel --no-allow-onelevel foo
>>
>> it returned with an exit code of 0 and 1 respectively.
> 
> `--allow-onelevel´ and ´--no-allow-onelevel´ are contradictory
> options, and shouldn't be run together, so that's likely why it failed
> with exit code 1.
>
> This is true for any `--xyz´ and ´--no-xyz´ options.

Our commands allow "--no-xyz" to override "--xyz" which is useful when 
an alias includes "--xyz" and you want to use the alias without that 
option. The second command above exits 1 because "foo" is a one-level 
ref and we've passed "--no-allow-onelevel" which overrides the earlier 
"--allow-onelevel"

Thanks

Phillip

