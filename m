Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C3299949
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158215; cv=none; b=nI4nI/qwQkjyUdIgPnQv0XV5JJMyCLCSJBsAQDzAV9jPABmjqJhilKKvYhHuNyGWZnggX+QfA5oVu+g1kTgjBMQqVOMj2lKJX1TLzn+ftfOuuOp78Zu1p2vSU6ph05Xh5Fg8d0+gY/ugSi2HRKCeBuhyYAJqJZbndNr9fy0qBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158215; c=relaxed/simple;
	bh=zo5oaaPFGN5OjzGCNNe7FIIdUHJQ1GquEO96zBN4xVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQmubd69B9HSA5CF84OwriAnBIxavtx4ieqHzDCuahib9V1VieVL8kYLCmnWKXKpz5+0qRHWFYhyVTKqCLd0h2W0SrVFhWYLuMGnGKqnk/hbmGjv05OAUk1QtR1deE31hjpgbWn6HzSe57shzjX950X+GozUF0/mtKoOtERjm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpRZdGy8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpRZdGy8"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b297962b20so46869851cf.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756158213; x=1756763013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3l7geW8Q4xvCEqypsHnbyJkCD1HIS6djsO6xLZ/mncc=;
        b=gpRZdGy8bEQOuQcIT7fV3RP9gk3b/+Klr+MiUqA7Fdub3DNFx5bVsHpgRn40SekB+0
         d+65hLcKXLUaAJF+/RG77J5JLhmrkpCW29mm7DLBOXDgucp5XpJfZ4xDziEo4FUdCQ2+
         S4P+TuOqMgLCcy2Pd4MeUIH4pyEY7fXE+il2dGkNlujQ+v+U8YfQPHYUu4GL0LGCJo/O
         1R5igCs6E3RudYKuzRdbB8RaCJcY8hOtJuSJmnRaevyuQnWlpD3TGVYTH8cpkUQu0yvE
         bSDavzdzziVNcMBSP1GsGnD6jPNOZvrEhAXUcv0hR1NrlTbiz09vajZTDYOd2hySY1F4
         BbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756158213; x=1756763013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3l7geW8Q4xvCEqypsHnbyJkCD1HIS6djsO6xLZ/mncc=;
        b=lA4wvLjrg7C6ApbHZN/M2AdJzmuW8vn1J8oqe4dWrBhS3zMwVWTyZcTGhKhH8/bZ2k
         1AblHv+1UzY2vnge/VmByvAnTJ/HkTWOrHQSPDHHM+ibKzgTMIfn/6MgPLml8XDfdzf3
         nmQ2RYg8w3DnaAjPJ4yA4qXi/C+Og2HahdV9GxJ3hAeb7XvMDbjJyLGMPwfJv1zBq95H
         FH4L5UivC+Q47PeqY5fnTSmmujOma9GOeMvFfbqU5rsjvgH0AazflfeqjpLv8yFsfydi
         0BLq3p4nsCAdcfD/4GBp5ykug91erQ7cBRPhWnQMchY4b8DZH5JuCBxyDcXqVB8Xp/sm
         ESjw==
X-Gm-Message-State: AOJu0Yz5YaXgkGeq+eZlA6e/yERsTOgASBtIn/hAAvQZQZPNpHlX/47b
	5D5IDV/P7iu6oYmKSDGu7tV/yRtP4AHAJNNvhQvPGQbGJxsj06oh3UBv
X-Gm-Gg: ASbGncty8FJp+CAD0+36RTmf+cqdcHfhKgsgyk793UjpUmT0YqZSdBkldd8FAW72h3n
	X810FB1n8vRaHGdyP6j26FHMuHuBm6uExLsIcCqR5BaYD1Df+SxH4BeOWZ/hj/ABnD0zWkIVA5l
	OjOSvDbkKkBuLhpEyT4li9bYXdtXpubx1O2vn2m+I+HukGQeGNa8oGJjj+Ut2zp9g3i13Qr3l34
	SpMdeDUXrZU4dxrfmWkYStf8h4SjuL9q2rruI8C5xv5wDKFxfdNRdG3yWEjen/hvx0dHyoLH/iD
	Kft0jqeVbUDHAuo76s9NWlk04CcNQr9E3Ma/0lLOn/LR2P57f1Np6OlelJYIlPdTB7yl4P5ATRu
	/Ge9+sxrB1cLQr642nOiq1mNm0PDjvmPgZEE=
X-Google-Smtp-Source: AGHT+IGJb6bzF96PzRqyaVVg0+BRD91S5fq6nzfHY4aixDv8MzYTKZ4rt1laf7CTvHic+iIcOjH6Jw==
X-Received: by 2002:ac8:7fc6:0:b0:4ae:cc29:82a2 with SMTP id d75a77b69052e-4b2aab5b78cmr141495281cf.59.1756158212599;
        Mon, 25 Aug 2025 14:43:32 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c631b8sm61120141cf.3.2025.08.25.14.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:43:32 -0700 (PDT)
Message-ID: <f98f3db4-cd36-4a24-903f-7aebf6af3d51@gmail.com>
Date: Mon, 25 Aug 2025 17:43:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] line-log: simplify condition checking for merge
 commits
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
 <20250824190644.2573279-5-szeder.dev@gmail.com> <xmqq4itvp19r.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq4itvp19r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/2025 4:57 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> In process_ranges_arbitrary_commit() the condition deciding whether
>> the given commit is not a merge, i.e. that it doesn't have more than
>> one parent, is head-scratchingly backwards, flip it.
> 
> Hmph, the condition is about "is it a root commit?  or is it a
> single-parent commit?", which does not sound overly complicated to
> me.

It is something that one can interpret carefully by thinking about
it, but the negation and OR condition made me need to pause and
think about it, while the positive of "does it have a parent and
a second parent?" was something that flowed naturally when I read
it.

Definitely a taste thing, so I could see you wanting to skip this
one on a pure "don't touch what's not broken" policy.

Thanks,
-Stolee

