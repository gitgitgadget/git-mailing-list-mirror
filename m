Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051B5396
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924251; cv=none; b=hVucbCSxmIFsKhBXi4Bd+m3LO9U71FkTFYFRQFvjSJSbaJlpL/JJPPodlDrUJmGIeWwpqF6G8hJOT7cu4EnApWvrfsQomtjv4kT4XdE8CQpGkAP0/SpaG6NB9Jd81+bLuA8C/PVa35M1UWgVSiSW4GSvQN2diYAGV3klFn9uh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924251; c=relaxed/simple;
	bh=0xTiR+unbRBJ2hTET9kiaEU28TQ3+yEIXNlJ4W5zk4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kT1i1MGNRUQa4SNkr1ndMQ3fIRePX2/580yCZs0XTn2iML6MoHRCyRYpboLpuLbsKBO5azWFHSCOcBASxi7GbgD4ykWKRUG2c0dDkLjCcnhVxbmdUglSTBAn39Zc+wx/AQANYvVqJj+rmeK4lXb5/Y+c6mt7ULuO7ZsxpKEnmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBzZpZgG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBzZpZgG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6dde04e1c79so2529245b3a.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 17:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706924249; x=1707529049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhfGF/4oO6YWRU05JyromzFAhDR9xSfDn7L9Yp1Hibk=;
        b=aBzZpZgGdzK5XkdoyNcQW3h36orO/Kk6M3SOpvSVpkbfUmyTccmA5h9Kp2Mklm1rip
         qeyMfJddgteoxGSeAp1OrG+Hhy65iHQ3qfkGM8KdT8c7F0ehWA1VYfZEslvECGq+c+pk
         sDfG/3o27Mk4AT2sSx/ICyoqpVFecpprK6AtnuXC1xCrZcs7S/9whobrb8Ju7Pv3KTc4
         rRJpx1xj0p5sLnyEzDCa5ltEJTw3yh9PwZy2A2UhFnItb4PJdNKtMTBcghxPjXpbkotA
         4t3MgVJ/zkduTbX6gHuDaYuVRyI7Vk8jm9pqCyoyfY1gxbgxmjMxZfSPUSE1Jp9y3LDn
         +WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706924249; x=1707529049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhfGF/4oO6YWRU05JyromzFAhDR9xSfDn7L9Yp1Hibk=;
        b=TKuLXkMHEk4kZIQxNQF5IEYP3RnxFpGDRx4zxVc3QnCL0vCpnAH0wGC2p6YNYt1vcR
         2mZpvv7sHN0ajv/okQO3A4meSXOz+LA59k1BDinkFl0IPwrWywQskzloOyUXvpYi0rSn
         yx383idoUcjFj4of4TqnMna0aW6Gqb6BBIHLj+6FdF/dDgHet/e5r70YeVNenEYMSNEa
         UPr/dWVZK9hZUEWdVepG1FDuHowp7xmeskqwc6IVR9PWHyfiEIhXx5zNSrn5mHYJMkrI
         NSVVq/279STlR+qOfXjQ3u+RJwp4uKzSOtAWCiarLMdyRiSmbC3MD3TWussKSvhCC0n7
         IGqw==
X-Gm-Message-State: AOJu0Ywnzeic9PvfN0UA9nHq9qGIHFOED7pUMkXECzn4bQxLjhoUQZ+X
	FlQdUzsk4cVcOXN0IhV9tLEkq7BSz/37wus3HopIucGXEbN1DPf95artKhUJ3idcdeGQg/UjxAu
	bTQ==
X-Google-Smtp-Source: AGHT+IF4S3eDunDgoftoy8WUdY6C2rS6U5kah0Ja8zAkyzYhUL+YeU9BnshwL/5alExhO9i8tyQpIuzOQb8=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:1d14:b0:6df:dd47:ff44 with SMTP id
 a20-20020a056a001d1400b006dfdd47ff44mr275801pfx.6.1706924248945; Fri, 02 Feb
 2024 17:37:28 -0800 (PST)
Date: Fri, 02 Feb 2024 17:37:27 -0800
In-Reply-To: <xmqqil38ypuk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <0a9a7438c3ff39f1434087bf3ed6a9865758c803.1706664145.git.gitgitgadget@gmail.com>
 <xmqqil38ypuk.fsf@gitster.g>
Message-ID: <owly8r421g6g.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 06/10] trailer: spread usage of "trailer_block" language
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Deprecate the "trailer_info" struct name and replace it with
>> "trailer_block". The main reason is to help readability, because
>> "trailer_info" on the surface sounds like it's about a single trailer
>> when in reality it is a collection of contiguous lines, at least 25% of
>> which are trailers.
>
> Yup, "info" is usually a fairly meaningless word.  At least "block"
> may imply it is a collection of trailers.
>
> The naming would not matter as much to the API users, if the thing
> is now opaque, though.

You make an interesting point (and I agree).

If we were to provide additional private structs named "trailer_<foo>"
at that point we should think about how these <foo> parts "interact"
with each other (if you will) in terms of names. For example we probably
would never want to name a struct "trailer_block_parser" if it has no
relationship to the existing "trailer_block" struct. More elaborate APIs
might design a particular naming scheme (with some rules about certain
suffixes, perhaps, for opaque pointers that all behave a certain way).

But such naming considerations would naturally come into view
independent of this public vs public struct discussion, so I think the
above paragraph is moot.
