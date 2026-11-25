Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630775;
	b=rgoA6YdYiPKD15nluBxKqSImbM7bBhty/GhMCt6qcDBRyvZy22K92RSEEPrKB+hs+HsT
	 0OsBKJYFUTxJU+6Rag4DCb94x/92O9QTw0OMALQfqWGkW0kFNZYPsA8QU+evUj3py7n3T
	 Q8ktySECu3N6N1lW6hfIZGu/+YSjdcGmcFfq5UIbPxTPFyWL4SkjSoH8UUhn/3GmF9f7F
	 d0MrwLwR3KTYUVr+VejIeGYQGl3zHvazzhDa+5piAaCClLnRyF73a141unQsbT7Xsi2HA
	 GRNEOa9bG0qTW3hoQAenlfUbIwcGOX7izIOmXHBVQFjhA32b952ZxLO8Fq8eWEx6ooA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=CvpKDk1oIfNh+3Hor/NyOWb2vmmNd4KClskDT53RdoE=;
	b=dx02HXBUuvdQoC2eGA6KsZCGhu+PI7K0EsBxxe3gKS2ZBEp6h+xBhpZdwInlHLUwOy/i
	 qOXSk/q/mGFzqEUs4D8Gi4yFfc1o3YNO6pWuQcTOpJuQ2F48BaZPYNPporwZ1BwP8sphf
	 sv272vRiXmkDYs6TtXphgyqIA1eq/UJUgLdGxEqIiwSJt6ma8rp01zOsCaO5fCcELCSWf
	 eLBdXcbOPo8SgAx1onkpf5lV3Lk99MTRcXEdsKiPxDh+KZARI/HSYcEKL1jTIV9UoLMXS
	 b66W+V0yCzBpG2H1Vc6mXXsSJzQX9HEshiLzQHwp1nqwBnLgcBfUJTLUNpJSnaqRzjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwpeytUd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E128606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E128606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwpeytUd
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b4fb5d96b3so95115987b3.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 10:19:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795630774; cv=none;
        d=google.com; s=arc-20260327;
        b=Uaa98EsTJk1zRX8FAqie4zjJkb1TDs/h1+o72djUfkDB0I+Z1rnENPZzn3koB120VP
         ecrYsp7OWoF8erIzqSXtqB41JdSFQPJSI9EKSM7BoqsmJ91/RsrHYUFciVxWuJU9/saE
         ANZDvrxnpOI6QpifA56EHtrF/9zCCnFV9BDn4gi4oT6mVI+aL7l3gRyPYeOLmLtMDTa7
         jkzSNrv8Gn8Ew6LlwEou2aSq4eyx8n/xaChK0Zuwwe2/KKqfaNasK+h2HxaukvKg22yL
         6++3kgws3dzldYAWu+x20uDEtRrHIcNJ3CfGRf223Yr/Re+XIMmxMLt+kZ3eq0O6pc9g
         5hNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CvpKDk1oIfNh+3Hor/NyOWb2vmmNd4KClskDT53RdoE=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=gg7xDJl0g3hssx5UA8oFdxcAy8ZvA2ag1UXWETL+krE84G7G3cuAGzvFUHxwlBeuBH
         tEt32ng1LoC4fJ7EA4hgO5wKskY3rnmTRSS2HmJP5+WT85jO37wb148PRbT16pKFCTQJ
         5woYPKFR2RpeScsmOVb+Eg5nN3XeDx7t4FBrMQq3ymQseO495EDwVl+WVFe/3MfbeBW4
         stQx4atSwIWG1fWuptg/qYJP6aYihNCFf7HNBrnIR6OHFX8a8Qi4Rj9HV22Mh91sPLFI
         8zFIeGY+RIJQTegeTYVnWFEcChXKkemvykL3jerdTeQciix06Qy/0Hg+SPR3kmDsHmrn
         dvyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795630774; x=1796235574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CvpKDk1oIfNh+3Hor/NyOWb2vmmNd4KClskDT53RdoE=;
        b=iwpeytUdCY4izxS3ufzAqgYGkG0EzmQDZzvi+RXpZ8C9dd40RXjXOyULwFHcYYjKTS
         /cLN58YrO18W/PmgLMb0qdiFf2XUyY6mB9GBkXGXYTwAmkjVezAMp9Tv9mQUYfHDoxrW
         MyJG0LoARaWKpgEDa+ReRsMq/dT8y2SFtlcBbuGCFC1fJWM74MaYpE5Mx+vprvyZ/4/e
         PXUqtXxG/E8OFRwKks75Ovz6hrEu7k0KAS6aqZu5qsIOjCdnmMkrL+bu93B5KoNY1JlY
         P92Br7RUxI0jEh5klm5+3OtJWirvSIisuSOANEGSnYx24LsEEAVjP3Q/XX50sKcMlWZo
         QboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630774; x=1796235574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvpKDk1oIfNh+3Hor/NyOWb2vmmNd4KClskDT53RdoE=;
        b=JlkRdAKVtYUx/iTK90KgSB/k310RRfogQPfONbK/R+/x449wnGgPw7RPxoGtQS71JC
         jG4h40fSqqI0DHlolDwr7H9rzMdX0x30bCKPbgrifqO+97J4yIMT3tR5HIucsWYHQlvZ
         Vs27k1FxkXZ3XILlvNTTTX4XdtcVUQx3vLEC0Zha6L2w/GnALbTD3WeD40/22DVJIJFD
         67ifyhrV+AgAHzxtlVNUj/LoQg/mnc1vvdTFnI2yPo0wV4q3Br7xQROHywLsb5SmrnKJ
         l6xtW4xR614T/zRIxYGhzEyXM7t3ck1BrGt/lou+DOfmXabr7Pc3nSXCpDIMs85S9T9q
         9tEw==
X-Gm-Message-State: APuU4Z+hQTmo4riTRh1V8+BFEqilQcaR3H3Kh+keTAbJY0pbCiUVZ7Zp
	v1PPljuQ6aRsX1vw+P3w+8CLSSIc7pyVc6M5sYRB+5zNYyLJ5fslwIGkc1aPFVj9nHzpjoBy9OR
	Qva+1MNg+61dTjjQVLLXIe+gz5mei6C4=
X-Gm-Gg: AZFdTZcjv1t5pzkCCVowfAmNjiql4eCsnkWzBpE3LEI2dUKLaOi+ianEhgoDDX2mpL/
	aTrOIoilrrGyLDjDxrTX32outIOvpTdsfh2HYeJ3KD1OwgcSTSHrcfdnalzaWbx3Alfg7h8Qy7o
	Mj/GCU9UaUsyx2xqC6p0bF/2TTsza8kgZeojQNYn0aOiYc1Cd8FdBmIdge+o30379EjyFuFNWOv
	PsPO0mZ1Cqx20NZ5Mulo5moCCq1FAWb/kjIOr+txdkb0R8cjTHdp8p3wwuAaDPpvymhlZb9HPJw
	ZmU6IN0RPGK/MuK2FMnEctyw6n5f/WYHA0HIeb7mUs6VH9LPjFqgSOS/b07VGL2hKd2fXsabb9K
	/QLzdXo405O4afvJBC3PO/apttURHKNuRhtwrAllQo+MZUdaJYKMDoHbFu6hsXKIVZ4550s+dIQ
	UEuBsAqQlZne8QViamDLQP6saCAJFIVC1k72PXJ1VxJ3zZVvRtzqx2XJUY6jog9yawghuHgwn44
	FjPuKdzwSk7qVIWzz5d5c+c/shxYfxth8qzNA==
X-Received: by 2002:a05:690c:698a:b0:8b5:35a6:7c33 with SMTP id
 00721157ae682-8b535a68299mr52911817b3.12.1795630773952; Wed, 25 Nov 2026
 10:19:33 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <20261124172146.18330-3-okhuomonajayi54@gmail.com>
 <xmqqtsl5g28h.fsf@gitster.g> <CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
 <xmqqqzg86brs.fsf@gitster.g>
In-Reply-To: <xmqqqzg86brs.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 19:19:23 +0100
X-Gm-Features: Aa3M54pjvYmbt9nP0ruSFJkvgR3yznUW-Y17wy42zZ03Scqv1CAhap5ZwisBEb4
Message-ID: <CAFpMFfD3byGXPMT4BdDX_bvdVa3CKWRbhoMT=yKXVE76EoUJ4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] notes: use the tree's repository when reading notes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2026 at 1:54 AM Junio C Hamano <gitster@pobox.com> wrote:
> So copy_notes() in [3/5] is the only unsafe conversion we need to
> rework in the next iteration, I guess?

Yes, that's right. copy_note() in 3/5 is the only unsafe one. I'll add
the NULL guard there in v5; the rest of the series stays as it is.

Okhuomon

On Wed, Nov 25, 2026 at 6:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > On Mon, Nov 24, 2026 at 1:34 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >> But others? note_tree_find() calls note_tree_search() which by itself
> >> does not touch 't' at all [...] The conversion in this step would caus=
e
> >> them to dereference t->repo without checking if t is not NULL or
> >> t->initialized [...]
> >
> > note_tree_find() has a single caller, get_note(). It replaces a NULL 't=
'
> > with &default_notes_tree and asserts t->initialized before passing
> > t->root down, so 't' is already non-NULL and initialized by the time we
> > read t->repo. note_tree_search() not touching 't' doesn't matter here,
> > since get_note() has already dereferenced it.
>
> OK, I missed the guarantees that these limited number of callers give
> these functions being modified.
>
> So copy_notes() in [3/5] is the only unsafe conversion we need to
> rework in the next iteration, I guess?
>
> Thanks.
