Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F92F8E9D
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277696; cv=pass; b=ZgWdkokJdtuav8DhU1azZ2Fad1YDjp+AVP+v/9cgyJYk6IB5xRiIr1a1fh4+V0Z0ymJ60frB8/R19LVu3v+RSULI5YdwrbGq3TaclbKeaRCC46K92DGNVIbV4bN2jY7/kXVl+fxpgMCClCF0EacExIVQyrYnYPwefYPmiM1iGss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277696; c=relaxed/simple;
	bh=Vv6zSoUFNKZBiuiZuVrHJTUclyptA7J00YQSifFso4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClhSp/AXpEAIAkqsp+PtITdGSc5oDGH3RG4/MlEL3Eb24NvlrnphP4bT4sRF0q8xs3651Gve7bLNLoui2MMlX3prXxJVKA3kiFelSIFK6XEpuURXptjPckkGrN3ZYrX1m9YJg4LWKkqcMzvSr3r+c9utk8kAdqji4DPmgB79Q7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=DTq4zfBy; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="DTq4zfBy"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e2cb01a974so12871197b3.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 08:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781277694; cv=none;
        d=google.com; s=arc-20240605;
        b=YXdxFtVFUhi3aYQYuX2mbJ88HlZDk4ARYhkswT9thl9s8q24bs52ybGI0qjfnySzF7
         3pezLLKYTHF8c/TSAn8ynbPep1VcDaZy6osTepkdSc4HWlcG24Ebl8ShUW9GfBCVCl83
         r4q2TrzIYzNc890tKCoJc+6Yoo7ZxxlC+bBY0ersYqxZDfWKR+AoczEPdFcQu0KsS9Eq
         o6tH1f/aVoJiHdr4phUfzJaMsGtwaH1Rq7/jG+uad7lre58k3mCpZx9x8EVa2RUmFHuz
         zz0j8tVL8GCbuT0a9XuD9+180HQ2EZ2lkkS7rpH+xwhcW5HPtku3EnlEY2k6v4HVUVWA
         J9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C9PjMMyCfpQ7WkUmSa5slsDEK0ALZvxoJV7UcoEhwRA=;
        fh=2qQh3Twk/9BXP2JN1YJEg5XG37bzhSBn4OXZs4ZhyG4=;
        b=KACIT8//I+pIqrcllm0Lg2ctVY2sIBuikGmMWqpY9GtwLy7CLKWlYO+lh5xMSTVaZ/
         1c9ug8EJ/eP6ssLjwwnNibdhOOAK4zVezIciDrDTNB+mGcTv/YLUxzysErSud/ikaT10
         2ZRZjfJ5c7AFEHJcbXKk07IMmkWI/DtVTTpsPilxgY7Xg0EuLWK1458OUVoISap6MBzN
         bePMXVOV5FjTGjv1DIxZsRtm2WSud1yGFnbeJbhYH75IgrqTAFrMgPmDf9aLm05hidB+
         hc4LsKBN/MqGBp3u8Ao/4FJD4/eyxfqKsqYtKNhLgxzTOfqD0C091+x+TxPfIY7HPiW8
         alsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781277694; x=1781882494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9PjMMyCfpQ7WkUmSa5slsDEK0ALZvxoJV7UcoEhwRA=;
        b=DTq4zfBysXaIfIW2ZcykP8FCi+2vGilN/Xnp14FQFr3c0IS0WRIV4XMzh44iFrxYVT
         tgrnZsTV3fXJxtP6GkBl/1JXnaadIvk7yXjeWbbDt0bRvQRH88dvrEqJKXZ4BjCtLX2q
         3PYJkJTrTda7UDGANOm3zgp8zcRX1Vly4Qv0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277694; x=1781882494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9PjMMyCfpQ7WkUmSa5slsDEK0ALZvxoJV7UcoEhwRA=;
        b=m2wV+Bphd1SrXWreV5ZoRS2f+wkBk659uHf/n7VCDo+OapCz2AfIIRj5IgGqWA6hHw
         ljOTNZvLar3FbSKsZdarD7Y8Uf5m61YFupeHcxyOByIZExehRghg6Smh3bnM75c2wR+I
         HISdUBSEURvHqZWpfZ/4q283LFMtMHi0JqGZHWV5iCJ1chrfv2jjV0z7QCEX+PUjcPzi
         sn2o6xcI0Iu7DvyixsERcz1zDCb2UuG0kU6HKv9hIuAHPm0Znvo6ISCMYjIOZod+XMqo
         KObBMh5aQ+vmcLYSh44az48bDu2RgQ8Iz7XFxssjCm5LaOv8lWKDPxJjS6JtpqjapfO2
         mV0g==
X-Gm-Message-State: AOJu0YxS1RcVrE0pvbh37a66zyWX2XdyE/zTZl21stHBHhFPXnLsWm/n
	pzqz/m+7taUKe1qN0C0WMkTDScQEzD37kGgRi3oPrSe3D18CQ3ObRSxNNhdfbKrgB/wT/YMfNFz
	7lmimDqGp7e/ien+h1cJDHmPUwUkzoA1rr9MD0WkqRZcac+MpuZ5Cgws=
X-Gm-Gg: Acq92OFzp+OM+pthjQ6Mxe9/batYrJnAPLVCB/5p7DBmLAdC7NSaCsEGhw5TD5v7oy6
	jEQPHLGkNcJr2XUWNu3E73zUjE4xbX6h3T9h5JKps3vfZSady11e6BA46B76WwvIkIguh6rUU2C
	orYfT1EGmdxr9HiCuKzMcaGwx4vSMJxyvy2R1pre2NTxqh9GP8EVaMHWnNhkIzxY4qhkXdAVlx1
	Zq5X/IZqp7Cf4rIUhYx8uLlt0O0IzSgpZPDkrrjGmW5ptYvAHOAsHz1cg2PierA+LP2RIfUgmz4
	TYE2yJs=
X-Received: by 2002:a05:690c:6203:b0:7c5:4c4e:a8a5 with SMTP id
 00721157ae682-7f7b991262dmr31776957b3.46.1781277693659; Fri, 12 Jun 2026
 08:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
 <0b3f7429-a4fb-4f7a-bf7b-5a0edeb1db52@gmail.com> <CAL71e4OmPzpCXh-zZ8NsT6L4zVKnXV1gqiFZ2w0XgMJhD=LArQ@mail.gmail.com>
 <8d0902ca-98b7-44a4-a23b-51de44ab6daa@gmail.com>
In-Reply-To: <8d0902ca-98b7-44a4-a23b-51de44ab6daa@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 12 Jun 2026 17:21:20 +0200
X-Gm-Features: AVVi8Cc194BpBh70zgTQ6o4s1TlRgLVOTgUWY9c34RxHv_2ac3m-sKcZeaNeqOg
Message-ID: <CAL71e4MFb3UUKBr1P4ZwtK3o1gvUHMs+siCpLTXKkW6Vx=BxRg@mail.gmail.com>
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jun 2026 at 17:04, Derrick Stolee <stolee@gmail.com> wrote:
> > So the actual halt condition would be:
> >
> >     no non-stale P1|P2 candidates in the queue
> >     AND (no pure-P1 OR no pure-P2)
>
> And since STALE is added only after both P1 and P2 bits, the two
> conditions are identical to how queue_has_nonstale() terminates the
> loop.

No, I think this part is different. I can demonstrate with an example queue
state: [P1, stale, P1, stale, stale]
With the old code, the non-stale tracker would consider this to be non-stale
since it still has two P1 commits to process.
My new approach would instead consider that a valid halt state - we
can't find any new merge-bases at that point.

> > If this reasoning is correct, then the walk only terminates after
> > merge-base candidates have either been processed or marked STALE,
> > and the counterexample should produce [B] rather than [B, C].
> That's the correct distinction: we need the set [B] and not [B,C]
> but we need to discover that B can reach C to remove it from the
> result set.

Yes, and I think that part works since we visit them in generational order,
so B can invalidate C before C is reached.

> I think there is potential merit in "switching walk modes" to DFS
> when all queued commits have both P1 and P2, but it comes with a
> lot of complications. So tread carefully if you go down this road.
>

On the DFS point: I may be misunderstanding the suggestion, but my current
approach depends quite heavily on generation ordering. The reason the
STALE propagation is safe is that, in the finite-generation region,
descendants are processed before ancestors. If we switch to DFS, I think we
would lose that ordering property unless the DFS is constrained in some
additional way.

So I think I may not fully understand the DFS idea, and I am not sure if
that type of optimization would be orthogonal to tweaking the halt condition
or not.

Thanks,
Kristofer
