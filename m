Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29B41BBBD5
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663841; cv=none; b=o0ZdArBx9Zo/g9i8V5zaFmiRIiZiYzGdKJZowEhroATiUy1ETEefhlTEZOAWe3fVVkPoQsbLEerNFGvkAwtMnuKabkXJAPoHscqn7jJ2hryeyEPsN3yOnmCRg5IvhN3hx3FbYjyaSROR4D25nSp7nWcg74zhAh1UlnbqCDOtZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663841; c=relaxed/simple;
	bh=ta0KTBY6n6iP383DkMMfjIi7qyh25GZg0YMSYlKzCpo=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bYrKo0SrnXHAH6JpdGaEoIy27hqOJHPauZ7H1E4EWPNV6mrIdxn90IpB9dPsCN6ApdOiKyEZw07WzaaiSMA45POIWxGJn+xAU/4R+iSlBm4MczLLaGUGpynkuVy/VvOhbZfNBdC9i/jPUoJnGvGQobiBsmqIMra0hIesjq8/xT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkBEkkn1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkBEkkn1"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad9ffa0d77so5654867b3.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723663838; x=1724268638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PYPe8Kxwuq7zFN8jKrJut7aisuzXMNazdnvHy3mVk7A=;
        b=rkBEkkn1+JYZmsRi1T9CFa8eamjGnFzYiOxsr5E39/S3KqGNmbIEb1yTdT8HVVs2xi
         ubNarmz4NTRsARd3bXopy1rVIetpQmRBbdhwnKZjEnqNZcRSs2bxtVyNQIScTEOrQCjD
         5Bsd1y1sM/ZaZeTfZbGsULDT1igBEaYHga3+2UvL55m1dEXHo+SBlIoQcXuYu1OqCPyt
         5qwOewwtPLot+LfTLmCVKqbeiEMzFbrMnJ8OjksjyxoweMS4opyv/cLB/4SJn4UFSGaf
         C2r8sA+ZKcM56XH+mnFDpTSvgfI7guJWivFYlE7ZPooOYXD12X20UDNw4X7gIn+gK/6W
         cLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723663838; x=1724268638;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYPe8Kxwuq7zFN8jKrJut7aisuzXMNazdnvHy3mVk7A=;
        b=HNm9xOvPPRjzX6myHwFx9bUhrkly9puI9fBRVZHplw5jRkdyh+Eymc9lkD7Z7pLu+g
         v1al9cnyPppjCLDDsJ6qNt2ie1Uv/7mSLC1URuUyzh5n0s+h3JdmqQRAF6HW9f4cXO7Y
         pFyduwdPUKxpN3kV5sJMjtyqz5FnmhT3Ev2j7UQnaz9xbz6gfSDxm8hEfv95sr4ZzurR
         am8vJrDY1azYwQ/RxmnC3DMgnMhu24aJPRM54lEH1xE4K5MOWrsWWhXpOB4l9aFV/sfr
         q+3VTq2u1Hch/1WNwOwdcatFym3C34NycSGOnqwvUGPfLsGdV60xsOK6stTIlvahtvvL
         QlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9TaGpe/j29ytWVRUwgrAdbFbke5SlpnYeL7l6xNMBi3Xjoe6RTBhbJ85S34DtgAtS9q3bC269WSXA4dXi3yiTwWf5
X-Gm-Message-State: AOJu0YxdJrIpB5rRs08rhd+DtOTJPucvVU58E62Rx43IWlxv4DvuAtyo
	OGJOmAd+Oc5MFcHUxuXFSEj4+iF8qO5B0Wr0pWPxsSJfX4T/aikdGj7pRIF9OUKiMlq4qkOJfJy
	WvngBoff+03KgikFtNXOB5/wXGkFZUg==
X-Google-Smtp-Source: AGHT+IH0GbVn7OVO2L0IslrOqpNkvU/SKloXDMHixcd40GN3AC9TaDHnao7MIV9DB46Ls1x91U6G+wXi2QukBnjPCy02
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:bd77:996c:4e7e:b0e3])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c584:0:b0:e0b:a2a7:df77 with
 SMTP id 3f1490d57ef6-e1155a42e03mr13166276.2.1723663838483; Wed, 14 Aug 2024
 12:30:38 -0700 (PDT)
Date: Wed, 14 Aug 2024 12:30:36 -0700
In-Reply-To: <xmqqsev73ftc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814193036.3918771-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/1] revision: fix reachable objects being gc'ed in no
 blob clone repo
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Han Young <hanyang.tony@bytedance.com>, 
	git@vger.kernel.org, xingxin.xx@bytedance.com, jeffhostetler@github.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Jonathan Tan <jonathantanmy@google.com> writes:
> >> Solutions I can think of:
> >
> > One more thing that I just thought of regarding the solution in this
> > patch. It seems to be to have a different separation of packs: all
> > objects currently in promisor packs and all objects currently not
> > in promisor packs. And the way it is done is to only exclude (in
> > this patch, mark UNINTERESTING, although it might be better to have
> > a separate flag for it) objects in promisor packs, but not their
> > ancestors.
> 
> You're right to mention two separate bits, especially because you do
> not want the "I am in a promisor pack" bit to propagate down to the
> ancestry chain like UNINTERESTING bit does.  But isn't the approach
> to enumerate all objects in promisor packs in an oidset and give a
> quick way for is_promisor_object() to answer if an object is or is
> not in promisor pack sufficient to replace the need to use _any_
> object flag bits to manage objects in promisor packs?

Ah...yes, you're right. But if someone is intending to go this route,
note that you can't use the oidset in is_promisor_object() directly,
as it contains both objects in promisor packs and objects that they
directly reference. You'll need to adapt it.
