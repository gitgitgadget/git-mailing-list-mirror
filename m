Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC8333442
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294931; cv=pass; b=ZXrdh4Bue5FP2cKllRrSCLBP3mau5vO6sn49jJvzjG3g/agTRtQyT5efZGl4gbkAS2cAGusHo542VMLfEjVmYVFOLhSZOpOiY2XQaAcVTaPOvn/k814okuqVmb3pfGPf/67EhntT9QpXysZGPe7hjj6PFCQ9jnZVv7ceJTj/7mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294931; c=relaxed/simple;
	bh=iHoA955OXkIByIQfGJd1HK5WmbwxLRUmfGKX83qVWTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsUab2OGpXM8rcjMp/ezVaqd3RxcGEM9QHLLkkwkb/yUXHpS4gLuAYhAZ1BYedjbqwz3TFJhG4rHt1hXSCt29aEftfcT1IOqo/e9dVcSU+iFuJj00MIymUpJ/QMZLz6ipcCtE4627S6prpqCkWedBr6hD09SpMACkP5C27cZPlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=iS6nkLTL; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="iS6nkLTL"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e0743942f8so15337327b3.3
        for <git@vger.kernel.org>; Sun, 31 May 2026 23:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780294928; cv=none;
        d=google.com; s=arc-20240605;
        b=U1cVktgrtBWZbOaGaAGcSIc8Wx4GyZ7CsvcbKfcmJx+PwPAmQZ3pn6DcQhdGE7BLn4
         fNLf2j38Di+ljM50SJqRDE99WjmbUNY8oK5VzkZYSbKiPgy5q4bIQIScTFHTU1QaYhI9
         D3vgWeccNtWMbNcflm/GA3ztejVQI9d8zkwWyqaGWE5F0uLCqUxxOeYslkA+TLcRx6+L
         P7xVb0liJppfv4rjwGw4VPqpZ73FwBsn9lPleNUFbyxqVpyqTSCGe70QMgVsKIVhGCWq
         7M22TOqrvHYOuDtIxyZQSXF//apFAoG7kmwfnYQKetmTydlwTAGN23e8SRAuinK+Z03e
         UUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LEhDTKt55baA3xXzMcwuC5gkMpkVMVG1jzqtdunYRSM=;
        fh=TwUH4qqgl302VFr4cdaVc5BFXxUUsZGNnufZ99y2WJQ=;
        b=id+cy8HccEjhU4ROJ/UoJiVaMb3X9ST5DLiJ9YxXzDMifYPpteBVT3lYEVdTSV0PFh
         RP6W2khdHiZMudyFvjoOx/p4voI5GU1tPSojkzBBEJ8dKxkPOAydBX/VrxoNeTR/arlk
         m3yNs8crNBUtfn/gebEMpH4lNuuNRL/pNPxbUqAQbn9bUTvfbgRY3+EZy30lK9Kugq71
         GNjLeObJ5VYDpITDky86X/ceWrjbxW43RVRd5nlaDwI/QRoNLNBjkmBaXK9H9JJPZm/B
         BVcAtO2l4Gg2U337fAsgIowp8fNc1DT//lz4tagZ6IIqiEksQw2OOsapZNW8E/6cK2Q4
         DtDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1780294928; x=1780899728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LEhDTKt55baA3xXzMcwuC5gkMpkVMVG1jzqtdunYRSM=;
        b=iS6nkLTL20Sjm/ujpka0q9TTrjeP3sP1+kU+yFzeula2hJM2BXTZaSmxtaJP/3nXcD
         t59CqYVmE1XccLYGDmAEfz+wEBkL2ychlIejTqn7JbSdpAel1uzn0MVfDk0mstHiWi/F
         cIprAUaRu8lvAjxtbvN+drmpfyk2xtNAV2jV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294928; x=1780899728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEhDTKt55baA3xXzMcwuC5gkMpkVMVG1jzqtdunYRSM=;
        b=eUqHjk00wMKN3dahgl43pCbgvFfFhc8YOcERkNy4JLwkLRmJKAJy9f8PvQ/ykWwBMG
         l3v2h5ZtIFA8wHziFWEAqWS5yQZglAk/E5PQlQVDLWRgfhRcRtvGKIP96AfQpT9zEit7
         ft7eJSzkZUbHtv5MW9yWva2SU8Sji7ge2lec0W8JNHi1x+9z3XH/fGT4sfXMO4bTVu8U
         HJ7GzJ8QKJF26lXQFtrjMgZTYk74uShmtsFwOhKIBZQigQsg15PYBlrPoWuKxB+X7QWy
         6v6h8EzkhxLLmqf+Cb0+XH1TErziBKfECWRXewNG6sdFGnLdDB05WIpZXkFzMxpUpQte
         xExw==
X-Forwarded-Encrypted: i=1; AFNElJ8/Fq+IFhEQFRjnXukI86wdxznujMPfqBgaeIZm4AhTB+GMjQshxktCSEOcCeEDhEn1wpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SlnJSn3AyiAiB/MDd6oHiMScn/IlFE5LQrVZcFnYANCSfcmf
	SFH8Jcque1B1hlAoKOK8vo237tcP2vgxG+/M+rrr+4zdwxJ822QIYiO8Knj5eyaUqYv9aPZ3Wdj
	dsQlMkDqsjLCEK8loEm7qNi4HmmucOCnBoYGslWYywpU4JpGIH+gtnBAx9w==
X-Gm-Gg: Acq92OF7wld30KN1uZDlTFRbgwRYuGyfGaEIFyp13F8enTAS6oXrxjtEpbYgfK2Nrqn
	FiPbHZL7KNIcNsh3tlEaAYIX/pcZ3MN8QM3HotfMCU7uZGs5JV3K2hxIiw9MLWhS/ZlKSn40dhC
	ZcMIG9fPzC66/6T0XRuvtIT/8BbrIQe5dx1hV9GOhQyMnetCXd77WyfRT9GrWhEgCgsKJgGiXCc
	Om2TR6FSN1YhCymRsfzro2nuTYG2yaEo8btPiqLPi1nOl19rKfEqKLiiO/9eiY7syXcHL02JyI6
	whBN1o0zqGnhdHTXhA==
X-Received: by 2002:a05:690c:6c04:b0:7dd:26df:54e0 with SMTP id
 00721157ae682-7e0586662bcmr80436117b3.6.1780294928287; Sun, 31 May 2026
 23:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com> <xmqq5x42aipu.fsf@gitster.g>
In-Reply-To: <xmqq5x42aipu.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 1 Jun 2026 08:21:57 +0200
X-Gm-Features: AVHnY4L1Gyb4j-I3HNb13FbzA3NWROcWcFc7ROOvjl8jw97DW_3UbkHAE9WLd3Y
Message-ID: <CAL71e4PjZz-BLpRzXd9MXnoWzHHGHzTYyGw0xM9ntg+iRATN2Q@mail.gmail.com>
Subject: Re: [PATCH] prio-queue: use cascade-down sift for faster extract-min
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the quick and very valid feedback! I already started
investigating - I think I was too quick (and wrong) when I reasoned
about the replace operation.I will rework it a bit and come back with
a patch version 2 soon that ensures that neither get and replace have
regressed in any way.

- Kristofer

On Mon, 1 Jun 2026 at 08:16, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/prio-queue.c b/prio-queue.c
> > index 9748528ce6..18005c43c4 100644
> > --- a/prio-queue.c
> > +++ b/prio-queue.c
> > @@ -62,17 +62,21 @@ static void sift_down_root(struct prio_queue *queue)
> >  {
> >       size_t ix, child;
> >
> > -     /* Push down the one at the root */
> > -     for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
> > -             child = ix * 2 + 1; /* left */
> > +     for (ix = 0; (child = ix * 2 + 1) < queue->nr; ix = child) {
> >               if (child + 1 < queue->nr &&
> >                   compare(queue, child, child + 1) >= 0)
> >                       child++; /* use right child */
> > +             queue->array[ix] = queue->array[child];
> > +     }
> >
> > -             if (compare(queue, ix, child) <= 0)
> > +     /* Place queue->array[queue->nr] (left by caller) and sift up. */
> > +     queue->array[ix] = queue->array[queue->nr];
>
> Here we always sift/bubble up the last element.
>
> I am wondering if it makes sense to teach sift_down_root to take an
> extra argument, "struct prio_queue_entry entry" (passed by value)
> and sift/bubble it up, not always queue->array[queue->nr], and ...
>
> > +     while (ix) {
> > +             size_t parent = (ix - 1) / 2;
> > +             if (compare(queue, parent, ix) <= 0)
> >                       break;
> > -
> > -             swap(queue, child, ix);
> > +             swap(queue, parent, ix);
> > +             ix = parent;
> >       }
> >  }
> >
> > @@ -89,7 +93,6 @@ void *prio_queue_get(struct prio_queue *queue)
> >       if (!--queue->nr)
> >               return result;
> >
> > -     queue->array[0] = queue->array[queue->nr];
> >       sift_down_root(queue);
> >       return result;
> >  }
> > @@ -111,8 +114,7 @@ void prio_queue_replace(struct prio_queue *queue, void *thing)
> >               queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
> >               queue->array[queue->nr - 1].data = thing;
> >       } else {
> > -             queue->array[0].ctr = queue->insertion_ctr++;
> > -             queue->array[0].data = thing;
> > -             sift_down_root(queue);
> > +             prio_queue_get(queue);
> > +             prio_queue_put(queue, thing);
>
> ... update this part in the else clause to do something like
>
>                 struct prio_queue_entry entry;
>                 entry.ctr = queue->insertion_ctr++;
>                 entry.data = thing;
>                 sift_down_root(queue, entry);
>
> to retain the optimization?  It would perform a single cascade-down
> sift, followed by a single sift-up, so it would save a comparison, a
> copy, and a swap in the worset case compared to the get+put sequence?
>
> Of course, the original sift_down_root() caller (i.e. prio_queue_get())
> needs to pass queue->array[queue->nr] as the second parameter to match.
>
> >       }
> >  }
> >
> > base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
