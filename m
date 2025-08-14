Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB43002D8
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179892; cv=none; b=ON+wsI4/iZMoUdbkTD1Esgct4U002PYdtT07RGhFZbxeA+eyUvzBjq0Yi0RoZbmE2AjDR0rciYSgQgpbFc9XhzgbH75nCsBC77XaV5tkezEpPOYBj8N7scbRrH7dt4Q2WdhH5MOlajbEY7QD/ddPJJVeEJ816kgKJp6nHwVrH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179892; c=relaxed/simple;
	bh=y9/IkfsuRPEPgtoXQaOVTG3wPhYryQpFznTqY77vOb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLpRz1Jayojjqe0t8C25i4GDFYL2h1T/FLw2OVy9ReVF7EK5nQ1z+6OrDevhJDF/ScsMGNVSwR+4HtxjGCa3vVJdqVyfbjuj3nMYZpBkOI+Aicgcp+yyaMZe+QQpmpxG49JKoQnmky9WCVMcjKIUk0uPZkFmpPqudvRTVn/moM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeQ7gOWo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeQ7gOWo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so4671565e9.0
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755179889; x=1755784689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1nAGSbOAM/ZpP0EA0DhNBJtg931WaQD84SUar+OCuqw=;
        b=VeQ7gOWoygbb7e39umN6u+uhrXhO6hccBr+yZZgAlaBgwGoWlUO+Mv2rHXWgMeahjB
         6L2xZY5HeipuSixklLqNRUFzccGhfgrBPfF6W/Q5+nenkrt6ULWNqeR4KHSS5qXo4rLz
         lw5mjZp4dFoKOK4hGHxSodugmMkyhgT1Qq6ypGOUhB9BqVDS/UokhDbImRtx9CtiJ+Jq
         vi/IXHgWpP/1uYSDsdUU8Kz989JH/AURnrO6tss0t6SMXeipf5YTVAW8sEpJT7x0RaSD
         +KmfGAvT9YjjjBFOJ0V+sX3IXu75e5Vy6i9f9psCx9AVj0d+2IAWK/R/uS8rv5dqDfOQ
         3b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179889; x=1755784689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nAGSbOAM/ZpP0EA0DhNBJtg931WaQD84SUar+OCuqw=;
        b=bClNc/4Bs04fxmdTnNacEzZoWlL+FIsHRtE4Ibg/DO8wrJR9kHkow0Pp6V3mHe+Rl0
         9z7V2cV4vnOPaloES9+I/s7LS004kwuokORZN/SZi/2J3jZ2AZhbiBw2B6zD2uiDNxjg
         RvDQUnBETJGuTsTFiqwSqZPy8Q/XE5QZCECgkrOoxWjOVdamgjNlvi5N5WS/VKrKbXLi
         MsNUBk8nfOvmaCFULJ3Q/3dPphdJGAVEUba2cn6gMrU93r6eprvUUfHfSB1o/ouMAlw3
         sWaP3aF7FSNbKSvBfEqmYyt7D+6WPFrvg6DvUx8rG+sspqAC+liELxPjH/bKjCKKHQSI
         iR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWLh9XTMKIDTtJxMNLogjwnxYtHU/9GfeUe4kfoJtzy/RwZXZLe1vNpXAu5KpQ0KkxOdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOj1cKAA4s4vYEBZUrPkfA4vopUNfdjzcgFX16UC/ffiRCgzy
	utYaPqHi+9qhE59T0uLWOPLR5DRqtG5Yk5rXGb5PG3Umaa118D6Ypdqj
X-Gm-Gg: ASbGnct/dV5XMILzuj4PGSN0nJZaRaduC8Nq4+9rfQ0iPizazlg+Hv/tBqiYPUi7RfE
	nBKMHjy/ngvrHEmQYPLn36YxwPGnJ8BRdiBOno63oX1YRYL6YizmYIvi88TzPzl/N9Hi3lEsyMT
	0P1MRfJFnq4yEq5HnJeGP4Mg+cyMhCtKDHiKcZzli5aqMYs1C+exqDsLlbM+LIzz0NUyVS89Zhk
	aayom7ADUKHyf4vDdvdsZhMePs0NryFyhUXB00IeTa7SwZhBRFc0QJ1IzWywOE0EwHnL2vR/BVd
	EQ+1YRg8bsY0volVpYF4hMtX7ETfymPTcjRy2YP2aAi+M5e+6KDrfNWv9v8ZeLtM4F4tRGlBG2d
	n6vCwFtcTdGuGW2y1HoYN7+8XTponNmLIC7pAOxy5dIvZnzQP2//E+oiGiH7ski/wVotxzGtZjd
	u0
X-Google-Smtp-Source: AGHT+IHBFs3HkeCaf4Hz+p6MvKG0Kj2wv0NlGSMzNbAummbJBa1t1goDcGtIo/33yvpD+Cql1vOTFw==
X-Received: by 2002:a05:600c:3b9f:b0:459:df07:6db7 with SMTP id 5b1f17b1804b1-45a1b602dfdmr24695205e9.6.1755179888479;
        Thu, 14 Aug 2025 06:58:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c61a66esm22173025e9.0.2025.08.14.06.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 06:58:07 -0700 (PDT)
Message-ID: <6731afaf-7036-4c8b-9479-80b6e2afa7e7@gmail.com>
Date: Thu, 14 Aug 2025 14:58:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC PATCH v9 2/5] repo: add the field references.format
To: Eric Sunshine <sunshine@sunshineco.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
 oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com,
 ben.knoble@gmail.com, gitster@pobox.com, jltobler@gmail.com, jn.avila@free.fr
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-3-lucasseikioshiro@gmail.com>
 <f97b712f-95a4-480b-8ed0-174e4f45ff81@gmail.com>
 <8A30D2A7-3290-4E7C-BBF5-A51AE5AD19F0@gmail.com>
 <CAPig+cQUuXxz2gMMA200D39dqWi6wpu6z43Wkr_trbCwuvTKSA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cQUuXxz2gMMA200D39dqWi6wpu6z43Wkr_trbCwuvTKSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2025 22:46, Eric Sunshine wrote:
> On Wed, Aug 13, 2025 at 5:18 PM Lucas Seiki Oshiro
> <lucasseikioshiro@gmail.com> wrote:
> 
> I don't think that Phillip was suggesting dropping only the reordering
> while keeping the deduplication; he was merely giving an example of an
> alternative implementation which would accomplish the deduplication
> goal, so he wasn't asking to over-engineer. Instead, (according to my
> reading), he is suggesting dropping both deduplication and reordering.

Exactly
>> If I follow
>> this path of returning the values in the same order they were in the
>> command line, I think it would be better to just allow duplicated keys
>> and multiple "key not found" errors for the same unknown key instead
>> of increasing the complexity of this command.
>>
>> What do you think?
> 
> I think that's exactly what Phillip was suggesting: present output in
> order requested, no deduplication
> 
> I had suggested the same back in [*], but I also said that I could
> formulate arguments in favor of either behavior, so I didn't have a
> strong opinion. However, Phillip has presented a good reason to prefer
> "output in order requested, no deduplication", and I do find his
> argument compelling.

If this command was producing output primarily for human consumption 
then I think the argument for sorting and de-duplicating the output 
would be much stronger. However, as this command is intended to replace 
some uses of "git rev-parse" in scripts, I think that "output in order 
requested, no de-duplication" is more convenient.

Thanks

Phillip

