Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461112FD698
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422216; cv=pass; b=SST8+ez5eTCFYZL76/1yR0u8oE6cVk8ctn9VI2oTuwuGNt7h291hS27w7a2MDr3rbSc4BMuQmsjwbexNh8z6KV5fphkeEPtQ9ydM74YfA6OYswoINXEzTwwabeHbYh5G/PMncwvjmavN/YZLhFtye7n5lolLchM/Dqb9q5HBqS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422216; c=relaxed/simple;
	bh=y65E3nKamWL1ezUdr09Oyp3DqaFuLYarm5i03WDFnRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX4Rn64IRvd1R2jYlxjwK7TkKltbZjL6SvY46t8A+Fs7iZpLzsmC1UGIW1mbJkLo+zHWcRX9Q4GFwVRlPzHvCWO5TjafWzzMi4SYHc51wxNNDMv/zuJOq22m58wo+dV7mDnUS1Jw2hQtSabftP1C46kBhVq+RFq8zqPgCajk+dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=iUHopuSQ; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="iUHopuSQ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38710d7d8baso45292041fa.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 05:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771422213; cv=none;
        d=google.com; s=arc-20240605;
        b=BBzxfVSP1w1oc0D64tYJqWd++dQM24EudQJaxfAPyQzIgDXb3AzKRW0fpAS2IH81+7
         oAlRkfpNQbbT+ASg3plCX8DsanqrfQTp2Eq7OiZi7LbnpnhCA+bSa+WKOI5eDjr8uIdK
         Lax7JpEYzxsRASA2aAECrrllm9fyFDFsb9FAcWm2ZG8APM9vGPzazuyuGOCCvZsbUJAR
         FSAPVRUKlYL7r0eRU1S2bUrjsSBi7BgLm04abLzREiBzoG2uGCEceBoczYB17ANpQTOo
         W4oRuTueUnBhmGey+w599AQTflHB+JU9ZMVRBPBreSWhfB+oa5QhBhLNksbSKNBComgc
         yUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ap8rJNNjBneSpSoExvrNfK2r5fv08D0Krj4eojyoOss=;
        fh=7xIVwiaAKFTjRTZ9eBQFbrMz2EpU3Nwgi7bv3OHIobY=;
        b=FImdOGR1dDs1sDu3ckPto05vAT5BDF5dqOhzVsSIikWYCgRhAO9x+ED8FAqBr1Ohq1
         UCSC3xXp5pQ5ndYPmibBpoc0fhk5FMFmgHpXUteQHrapvvlqr3d/5Ln/Q4zN/Kly0iW9
         Jc1vyE5Mr01E42AEsZ3VVnzp2gty2ygL27sLztW3XtPa9NoaGOCXGmqy4SqaMJJcGE5J
         KUqOmJ6Q+CySbTkEmoxjSzVQMQepSAsym5jWrze7VEeD3qDl9BMSJ2qc83AX9pYMn8Jk
         W8OOmk6ESmIn6c/8SGBPAL9Z+EGboza2JRTlc2dIedH6fp9ilHfMfjJ9HRwmRrd2alke
         T2nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1771422213; x=1772027013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap8rJNNjBneSpSoExvrNfK2r5fv08D0Krj4eojyoOss=;
        b=iUHopuSQ4CktEt6FL9nyKG6Rd+plpcnlZrnUIiGet9aToebP0ZRD4RyL47ivSGVzp+
         1GW7b4xZnR18jRNP+jGB+bODeKodWYpIn+O11FL5ajd84QTCb2Sn3v/atGUMIsDBOIGS
         V+pzbbzYXpGCTuYTzv8NqHPP0hJTs66JcZ8P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771422213; x=1772027013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ap8rJNNjBneSpSoExvrNfK2r5fv08D0Krj4eojyoOss=;
        b=L8ysnhLUw8CK+jgP6cs0o9LqWS9OJoFYM6Tl4dXPOk6w4NNDCjX9TXI/07v7QaQjz4
         366QkQN4Tve2WZZkwWNJfowfblpAbZLmi2TckFE5eXVHw7XGgGn6NOFqpX6K0UbF8IhJ
         /bwqyBPGPOQ9gbtFym9MypuZ5Qp8+ThzZZTzoAZl3+pXqXBxkrmlIyRUz19uNgK+y4Ul
         gezSfWUHi6/8fDfhdaHcb/yxkDsnTnc74bYmFA+IeormnkpIBGK090pfcdVwZ24rcUCq
         qm0KPhXmXY4uEXwfeFuUm8uX6jcKmW04JvxnCq2nu4UZxr+FCfF1z6LkUNXM5n5rbuDx
         +sqA==
X-Forwarded-Encrypted: i=1; AJvYcCWFNIvdeIHG0CD0sMNpMhV2NoW2pdBpQekaAclQcn6C1hyU4FFNugo3dnMWvwhgyS/WcGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVw1I28EX8mBZeW/UdJm8WWG6BLzk3MuruzK7BOxOnI5LEYB7h
	fmswUqGpKIe9myLN6oFZivVRM8Le16lYGzxdafmY2EMjSWXTD0MFip16iSu1Du57qrVqsU0C611
	qdvz61hsR2M4MWQhJTkSAphsM2F7/AdPkwkpg0iW8JgXek0w8zvdFAPM=
X-Gm-Gg: AZuq6aKuepBcYI2kXNPmmMb8ReQdIPMNnpHnR2dwfBrI9PqyKxt7DXBvd+3fGjh3cCx
	vxU9yV7ZhphF+8/Yq+5E7yR4DtQsoAtXL2GHJeqqQqvm+hqgCLj3cElVl9OUzjTj26ynqY6LcJj
	qnb2fzUbTcssFRxGSifBBn0Rc74gPkLNZ7xIw638rnLuo4tsP25ap0XzPQwLtj9ZZXT98kxdKAW
	7ylMnbPo6u9tH31BAwqJ+MGsMaPWiiqnC+gzSFVhhy0lj6QAjKKW5QQZR4J2Onex+KOqh+4zMj+
	HSE=
X-Received: by 2002:a2e:be29:0:b0:387:bf2:dca with SMTP id 38308e7fff4ca-3881b95e7a6mr44323041fa.39.1771422213113;
 Wed, 18 Feb 2026 05:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
 <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com> <821043c664e41d8e395e944df3ada8f697a69d0b.1771326521.git.gitgitgadget@gmail.com>
 <xmqqseaz9jrd.fsf@gitster.g>
In-Reply-To: <xmqqseaz9jrd.fsf@gitster.g>
From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Date: Wed, 18 Feb 2026 15:43:22 +0200
X-Gm-Features: AaiRm50M1xq8bk8SF1n4uPMoSFbxfI2IIxgVq3myKKms_tR3LBN8zQO6gxJVsFY
Message-ID: <CAGjQmDODbvzRMO+V4MC_acCAbJh0=A-6ZWswbQCe+tK7ejRGoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] strbuf: fix incorrect alloc size in strbuf_reencode()
To: Junio C Hamano <gitster@pobox.com>
Cc: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 10:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
> >
> > The strbuf_reencode() function incorrectly passes the string length
> > as the allocation size to strbuf_attach(), when it should pass
> > length + 1 to account for the null terminator.
> >
> > The reencode_string_len() function allocates len + 1 bytes (including
> > the null terminator) and returns the string length (excluding the null
> > terminator) via the len parameter. However, strbuf_reencode() then
> > calls strbuf_attach() with this length value as both the len and alloc
> > parameters:
> >
> >     strbuf_attach(sb, out, len, len);
> >
> > This is incorrect because strbuf_attach()'s alloc parameter should
> > reflect the actual allocated buffer size, which includes space for the
> > null terminator. This could lead to incorrect memory management in code
> > that relies on sb->alloc being accurate.
>
> I do agree that setting the correct number to .alloc member is a
> good thing to do, but I am afraid that the above characterization of
> a potential problem is incorrect.
>
> If we were to extend the resulting strbuf further (by e.g.,
> appending to it), we might end up reallocating the buffer a bit
> prematurely by one byte before it actually fills up, but the
> reallocation would be done by giving the piece of memory pointed at
> by "out" here to realloc(3), so the wrong value of "alloc" would not
> lead to incorrect memory management at all.
>
> Upon further inspection, we see something else interesting.  The
> strbuf_attach() function, immediately after initializing sb with the
> new values of buf/len/alloc, calls strbuf_grow(sb, 0) and triggers
> the ALLOC_GROW() growth thanks to this under specification.  By the
> time the control returns to the caller, the sb->alloc would be
> (((len)+16)*3/2), not (len+1), and it records the actual allocation
> size.  So there is no "could lead to incorrect memory management" at
> all, but this incorrect number forces us to always reallocate
> immediately after the strbuf_attach() call, which is a waste when we
> are not going to further extend the strbuf returned by this function.
>
> And that is a very good reason to make this fix worth doing.

I agree that this is incorrect characterization. What about something like =
this:

    strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()

    reencode_string_len() allocates len+1 bytes (including the NUL) and
    returns the string length in len. strbuf_reencode() was calling
    strbuf_attach(sb, out, len, len), so alloc was one byte too small.

    strbuf_attach() then calls strbuf_grow(sb, 0). With alloc < len+1,
    ALLOC_GROW always reallocates, so we reallocated immediately after
    attach even when the strbuf was not extended further. Pass len+1 as
    the alloc argument so the existing buffer is reused and the
    reallocation is avoided.


> > Fix by passing len + 1 as the alloc parameter:
> >
> >     strbuf_attach(sb, out, len, len + 1);
>
> I wonder how widespread this off-by-one error is.  Shouldn't
> strbuf_attach() be doing some sanity checking of its parameters?
>
>         void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size=
_t alloc)
>         {
>
>                 strbuf_release(sb);
>                 sb->buf   =3D buf;
>                 sb->len   =3D len;
>                 sb->alloc =3D alloc;
>                 strbuf_grow(sb, 0);
>                 sb->buf[sb->len] =3D '\0';
>         }
>
> Given the above code, it is clear that alloc must be at least as big
> as (len + 1), and the strbuf_grow(sb, 0) in between is papering over
> problems (at least it is doing so here for the caller you corrected).
>
> Perhaps we want to replace the call to strbuf_grow(sb, 0) with
> something like
>
>                 if (alloc <=3D len)
>                         BUG("alloc must be larger than len");
>
> instead?  The log message of 917c9a71 (New strbuf APIs: splice and
> attach., 2007-09-15) is worth reading, but it is an iffy logic that
> depends too much (at least for my taste) on what strbuf_grow(sb, 0)
> actually does ;-).

I'll send patches, one to clean up call sites (there aren't too many - 7 pl=
aces)
and another to add BUG() check to enforce the contract.

Thanks, Junio, for the review!

>
> > Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
> > ---
> >  strbuf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/strbuf.c b/strbuf.c
> > index 3939863cf3..3e04addc22 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -168,7 +168,7 @@ int strbuf_reencode(struct strbuf *sb, const char *=
from, const char *to)
> >       if (!out)
> >               return -1;
> >
> > -     strbuf_attach(sb, out, len, len);
> > +     strbuf_attach(sb, out, len, len + 1);
> >       return 0;
> >  }
