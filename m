Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BF25DAEA
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828191; cv=none; b=I8ks5SL54xtuSnmQREWOZyRUhN01zWjeM8r77uQ9gSp4r6xZ0AoNEBU4rNAPokXYyDx96ejUlqMtDBFP7UkbYp0rwHN9jBJZpbk2JJ0Hu6g2Kc+D1j1vxoXqMGQEhgYkA7ecWRle5eWqXUxgi23khSh9SgJEtdc30C/+VzJcGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828191; c=relaxed/simple;
	bh=dQ4FhtsWDz8jrkZqEmSQGXfLS2yL6lNlMAI/mdaASWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLZeB/TSdM6Y8toyqJ7z2aW/wmthCRjSHE29zCpr3FZsdgjW4gmMVR2UaTBq05DyG8OchrxG8lHH4Fc18g/KkJt9Ieb6fVD37eIOf51zL/xPNGYQ/9g2mTVog2pShTvznXToaNPO7wl/4u57Avo/hfWP3PB4eRBuzgYOQ8zN/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtV3VdQP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtV3VdQP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aae38670daso1200975ad.3
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 08:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770828190; x=1771432990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzrchGxeO3pv2wxTsrTO4HWuZtAbhAyD7ecBxJapukA=;
        b=GtV3VdQPN9jBmACy5bANKdF+EKhai/K2158zWa+ufZ11TbhtP36kvP9YSnAB46bOLT
         CX6GqHC49HZNA6IGlcNvYfYOYJjwGhWHOc1SfipdZP1G0qeCtBN+zhBzNYx5YbG/sOc/
         M7Wkt5DZ5GQglzXEcg3m5HLL4sBFOZzFP+MtyHp84UEQPuRqmqlfl/cgtjvYHi+AHh7X
         GeqT0YUGxz8qizj31cf03NgoOzdn3dgbAm9lUmrUOa1MVcZUEKUK96Ee45U3JhBgWZ1q
         L7nu8BsNbx7TXHNm4Au0zS0Pq/qxBzpc/rmeCDOX49e5AANloVznADEkOimnrgYWj3Jb
         Uwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770828190; x=1771432990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzrchGxeO3pv2wxTsrTO4HWuZtAbhAyD7ecBxJapukA=;
        b=SsdQ8ZVrQPe/q5zinh4yZOU+8Yd0om5DbsNocRzn4jgjFLGHwQCw1nRU3jVarsXVPz
         OIeJtIiXF9ZrNmK6o/BaxSMgYxj8pN9bJ6iSTfRDjIdIoRQyvK2YLJg7wtKVUphvemC0
         LLGM3huFpkprpFokU6MFVdOaZfCgh0CD0K7a2KXqgFqJpUS3cgfk9yDLQaBHDszdVmYA
         BaEOnCZtDZOARlWIY2RJLNpat2ztpv2F0YWiv4YJO6olXwSADGMVjKLJ0zzhwa0uIaiT
         4fAmRVOveIxcDfz9PLS9tvPIMoDYuZK2LOU+z2509GHVppM29PF0t6U2U/f6MaRoAc5Z
         RZ+A==
X-Forwarded-Encrypted: i=1; AJvYcCULYcC2qvxvb86lC1VgEFXdfK+jQLxJsppNC+59Av9uIdzcRfNk6OXghrxHFW+Lsz9/HBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgJXQpLGcuspvuoFSr7uhJ1YtZnPBDBSOBFgBqdrWs9nzOI8M
	Zsnjl2orpkRaAdkT33pBD41N1lKKaJmsnxbOnydiuyHPjbhg5Hfkp9LI
X-Gm-Gg: AZuq6aJ0+oG+o/KPDUXumU8bxyTOth9SdN/fcZzteSVTLUPLWUb61CkKIZtVmnsRoN/
	n6SSPekbe9zhlWb4+Eq5qB8Hye7xhFDbtc79f5iWTefViFMXDIfgVijFygmFNuiv6hTItYp050G
	iTzHuM4CItX3BMdktGfvgso8zaogj9zlsRBVvLMsybE4b5DE60V8ibVH8wJjHxpScjF9fdpoRIm
	FzYw7jBykR6ofd26MiHZ6Dx08UZDrd6iXHNK5LJcyDrHuDVxmy+TUl0fjqTKB3WA/o7J1jrutaV
	qFo61HY5I3sZ5Un2CGWETaWjiDD8Wk0hjRdm+ProRKsEXlR8XTcPjY78LyES+Abkrk0pH0DPz8q
	8fFuNw03hFIUiQBjjiEhnTkn4hT+xMOCUb8SYFf3wtW6B5tMdfHnfDh6U+T1q5LCVryEak+blfn
	7PU4v85fQcWaSKFMbcjz41u6gJIwA=
X-Received: by 2002:a17:903:2cb:b0:2aa:d5fe:6d27 with SMTP id d9443c01a7336-2ab2ab65cf5mr18089005ad.2.1770828189909;
        Wed, 11 Feb 2026 08:43:09 -0800 (PST)
Received: from [192.168.0.107] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ab2fsm25452145ad.17.2026.02.11.08.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 08:43:08 -0800 (PST)
Message-ID: <83365a16-68c2-4429-926e-3071df3b9bfb@gmail.com>
Date: Thu, 12 Feb 2026 00:43:03 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in
 read_attr
To: Junio C Hamano <gitster@pobox.com>
Cc: Ayush Jha <kumarayushjha123@gmail.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
References: <20260207114007.40-1-kumarayushjha123@gmail.com>
 <96329bc6-0490-454b-a21b-babb85c98bc9@gmail.com> <xmqqqzqsw4og.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqqzqsw4og.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/11/26 07:37, Junio C Hamano wrote:
> Tian Yuchen<a3205153416@gmail.com> writes:
> 
>> Junio C Hamano<gitster@pobox.com> writes:
>>
>>   >The codepath read_attr() is in is usually not that hot but it is not
>>   >cheap.
>>
>> I'm a bit curious—under what circumstances would calling this method
>> result in significant performance regression?
> Significant?  I dunno.
> 
> And quite honestly, I do not care about significance very much in a
> case like this.  Doing things that do not make sense, like checking
> the same configuration variable again and again when you_know_ that
> you never switched to a different repository since you last checked,
> is simply wrong.  It burdens the readers with unnecessary cognitive
> load by making them wonder why you do such a nonsensical thing.
> 
> The read_attr() is called during an attr stack construction, which
> traverses the directory hierarchy of a single repositry's working
> tree (we do not traverse across submodule boundaries), and the same
> istate (i.e., index contents) structure is passed around throughout
> the callchain.  The repository instance at istate->repo may be a
> good place to store "am I bare?" bit that is computed just once and
> reused whenever we need to know, like in the funcion under
> discussion.

Hi Junio,

I completely agree that computing it once and storing it in 
'istate->repo' is the right fix. Optimizing for logical clarity and 
reducing load is indeed more important than micro-benchmarking here.

Thanks for the insight!

Regards,

Yuchen
