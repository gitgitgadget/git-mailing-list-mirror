Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589857;
	b=yiZ6sKJ/Sc4WO3I1qXCxzeo0g0+Y01LebhayzDfDagx1dm5EKJzPUmLndgCMzyfbyvbq
	 piOfliVPFGqBHV/Qb2jGjTDC/FoA0R5qHQvSyS/70yWNeCIoYC3Uqy9JvwP4Zj1clBQX+
	 SRtzsGcz+5eY+wgMkfLHtJyZdENjheyMwypZiYBePMB1UAmd/O66FtjIl9vPkmRGMsihp
	 C3m0l3mW/6JAztrR+MokYzcHp76vmr1aSokuQ4aUGZ+8gSXufmcFwVgOMXRdaa7c+Ca6M
	 grRDqjF+YCMDyf+tB5I6n/G+z0iBUPa3jwSxvCTbnIwt+hO4KDkHLCUIOGlKu9n5F3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JrNkN+nGXPtA4lqwvQ/PUGNqezeK+ndi0KwtkoWBvQE=;
	b=pCRg8ylWGQCXQpRc48h/JzA/7JSV9lLGjRiZSqHe6Z5KFZyT6xPr9AsvdGxxqm9DYtuQ
	 7pXXpjV7T0qpq4YIhbd6RsVwybGrRxCtTxqmVOdfCXstDZuygJYzx5efP17qEiOp/4cnX
	 s18QQNYiezhdzZLR7npS80cWi27SalWSehWPozuZsOL9gwcKMl0SG+KVfVZCweJ7IsMvf
	 R64wQ+SpZ3x26qpv+FDCJZBUI3/4mzosq5UCfLkqioLGmcN9wWRNbHbBwLHo9ms/l9UOR
	 0Rq/TV4eLPEqGAsjBJPV05kHCi2iTAAgxi1s5qJgo7BBhHLlnBmftChMwFgNXVhOA/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UrWeILKt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312E606A339
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A312E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UrWeILKt
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so1609034c88.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 09:10:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589856; cv=none;
        d=google.com; s=arc-20260327;
        b=ZemF0JGpFaw9WbSJ0oR5QlJFh7oXx2ampuKH4Wg3DlSVYVQ6rGPN7MUvXj0eY+dmkQ
         +V417Y41eaDmUJFLimD6f2ceyr6nw6xAMX4UWkHGzcvZ4KX7+4XPGXxrdYM/fKf1GB+J
         r3g6oE1JbQKaW9vCZcecwsjyvJVcZRxUGUsarz2GHnHyCLnxu6XB4DOnCaTygT6Ux5Lq
         glC11/OCHzj3TU0x5AARniHjQpu9IeZAbM4as7JLIR3OzWdwiYppWXTbdy3A4d0YV/so
         meIqzYe3sxau11IAcHIGzwTLdCra/5+B4hOK/lXdNKVs8dZkSDm10UI3ZHl+s2YOzj5/
         wukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JrNkN+nGXPtA4lqwvQ/PUGNqezeK+ndi0KwtkoWBvQE=;
        fh=PpMmFLp4I59KN5v1pZAJkcsMZYHcNxJntAL62KlD4Hc=;
        b=lku0ovOcVxLOZEQb+WOcHWZgD06udxPWxini4viBZnkfGPaQDCaZZmZo9N0IHtku1v
         W7LI9zuy5FjiTJ4ceUVuc4Kw3sZLedWPvNKxdZTeDXH3DRhd5TERHtMHK3cTCpfheBar
         3ZVSzDxS8YacYN5eCGGJgpVGXE23zgpbea1KZx4yecU7HNSpUg0EiQK9mlFziAekipTS
         2K/QHHv2wMmh2aeJTST756u0xYySlip1NcfmjAzouInI3OWNBTfN2NaGhu1db5SsPtS1
         OVZJT5/Nqvx5h9Podhnw5nwYezpchpLS1zEe9/zzfrULUkZklzxoYCcdG9nl/lLvTzwH
         jOeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589856; x=1795194656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JrNkN+nGXPtA4lqwvQ/PUGNqezeK+ndi0KwtkoWBvQE=;
        b=UrWeILKtMkILFdMBrs7UkmBiJKPka/ja2XnGFipaCILNvrSwhyVYWZJS45+TMWZrPC
         rwDNyKykMp3AZD6QL+pL5ZedT4UFb3hW0/9QlF8c4wfkueD5ADYn9uXp2RcTq2zQZ/Yi
         zRilCRXs0eQVkCpiWqd5WF6z9lR3WL9HXuCujZolbVxUfT4Nhvwh01YgK8BdbLzq2Kz0
         2xjKgdKhHQLbjyqLYEowOCw7w5L8r2hMUZ0qe9QlgNKA1IjLUbxt+4clx8bRszxcXu+o
         BUm0LPYzIkNMJKl8I6tAzwxY45eI4HQYk3ZlM0XQRJyEK3wz2I8YJb9TRL/oDUXsmejk
         SQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589856; x=1795194656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrNkN+nGXPtA4lqwvQ/PUGNqezeK+ndi0KwtkoWBvQE=;
        b=FceDq49bTONDhRyKeyqq1hyCkJ5Kit87KLGxgVdYuF9hHOdDPXrEL9+3zuCpXPZ6Uv
         JeGips+DGK3WT4MWFa3A6RZHkAzGNniZDmTxKiN7Z3hyVoTxKGRug902fm9gRszYYExm
         aJgMKRK7+sgrwLieUXo8Rp5VlGXF0S0Ys0F/4OD8zPGoN6De7Fa5QBpCTtSF1oXnWrSk
         pPi64nkGKmlpoqW5RqGPuwod82R3pOBrowQNSTPbUj/+bOoW76WJUDTJea67vWLYk238
         KXPR56B7X1CiS23bFLXv0sWdFEVl2zuRiOfyvhyon06xs0FYlo15ZbhWaND2xAZhM5rn
         LehQ==
X-Forwarded-Encrypted: i=1; AL+hErGPPI7h0swWrtOd6pXTHchmZbP4YyOnTeoVpMbcp/oLmI+ZBhkWaHGYXE8m/I3rSuxoKd4=@vger.kernel.org
X-Gm-Message-State: APuU4Z99uaRBIGKWeLy+X7frWcXdQghrnoD+kYyn3EswMzhX//0xVPth
	kNSWBZtxXDuVVD0qDSZNuG8dXdjs+vwYiIrnavAj1ppTRzuHBPjXcCq/ruSKsu4KGcVg2tL2kkW
	a20dAVOeVbHuzJvCsf7Rfoi62HUlsBhNqRt2K10a68w==
X-Gm-Gg: AYBFou1nAEPv0sRda19dovlgxdF39aT6x7kt/OO6qr++hEkLJ8R+gDSDU5Tvxn3FA15
	0JVGTKQWRINSD8xdDSMdQLfyVTfB/GMALqeFh43YWjXRKBdn76HBCNNfgDJYWuzwJJ6yUUIlAe0
	2iqqZaakiNeT/WTFiZUHUp1DjClj9tukp1gxIT/ijUVWjc5XupW4lcIlNkLyhR1/CW9rRpz2L61
	JUMjYiwRXyy4WlXGjEtdg2SnFXS80fvj7TWI/SgZ7WGCnAfhpRhG11nbxEA169ofcsx7GHOFMUx
	qdVBWfipLqokhJv1nYg+LfzD1ncloP2iC12QejxqNSWQeF4nIj7UGw0k0xWh76Ap3obbTaZFJTl
	U+KtavuM1D1z7QKKmbzOJ0dq9q4bHoQHdu3HBa7NjKCNEaUkQpcglTokQLZo+AxWKky4T7vRHWd
	RdIla1u3YmoBgdHGjw3WxZHP/WYUXc7PaCjLIEZ10+k6vdwbyKW7dAAKzWrefP0XArw1yAQVzk1
	EjZFbbGu0KTCA8+2pkVhAKc6rXa
X-Received: by 2002:a05:7022:140e:b0:141:5281:8a41 with SMTP id
 a92af1059eb24-1b503098225mr2628305c88.9.1794589855612; Fri, 13 Nov 2026
 09:10:55 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104172434.691381-1-yopatatchou@gmail.com>
 <20261105225223.1163975-1-yopatatchou@gmail.com> <xmqq8q36q3il.fsf@gitster.g>
In-Reply-To: <xmqq8q36q3il.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 13 Nov 2026 18:10:43 +0100
X-Gm-Features: AclHuK9Oo4yKc80XIZk1DbLSzUsEaHnG330qUDqRX3zv-7UI2QfVGiGzlJKOIfc
Message-ID: <CAP8UFD0zMp-e3Fp5SjXuHiu25718=vf+qetzwpRZmBPMJ8Vb0Q@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v2] promisor-remote: honor promisor.fetchOrder
 when trying remotes
To: Junio C Hamano <gitster@pobox.com>
Cc: Yopa Nelly <yopatatchou@gmail.com>, git@vger.kernel.org, tangajoris@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 12:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian, I thought you are the go-to person for promisor remote,
> and if I am not mistaken, you worked on letting the server side tell
> the clients which promisors to use first?  How would this mesh well
> with that?

Sorry, for the late reply. I didn't have much time this week.

First in https://git.github.io/General-Microproject-Information/ we
have a "Don=E2=80=99t work on a proposed project right away" section, but
unfortunately this patch is addressing the main issue of a project we
are proposing.

In general I think that there should be a design doc or a long
discussion before we start implementing something, because the problem
could be complex. When you are fetching from different remotes, remote
A might want the client to get some objects from a set of promisor
remotes, like A1 and A2, while remote B, might advertise others like
B1, B2 and B3. Also after a few regular fetches from let's say A and
B, the client might need to lazy fetch some objects. Then it's not
clear which order would be best. A single order might not work well.
The best order might depend on the remote from which related objects
were fetched.
