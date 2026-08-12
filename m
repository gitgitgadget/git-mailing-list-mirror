Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D248CD72
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570082; cv=pass; b=cs3gcS+FsbB9B3GJp2TjGTNGsXs9VcbHnBmwYqqLUY0+65/grWLPeEnA/OP+Yv9YzKGO9vMvO/E/TIM3V7H8uU0CJxU9MVTFdGaS+Wic/Iz5cg9AOVN7ts09YUb1uTz7733Kl167UYyGJhnhIz+NxSJ8zjKgxFm28TuSj2omysQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570082; c=relaxed/simple;
	bh=CFyq6PLyhyd+5qkHiHNezSKjQ+znV+DMc+amhpc/+Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0CjvMCRdnFy9tjdEmo19M6R9o3uCvmvoOz/7wl8QSgbwNr0esj2ET9H5QbfXtMXmv/0xcMLxE6x2lD78VWIzF5I3qFo1SE4ew8AE1aFYjtYGCOozBFPLDmBeE+lgVYp3EPXevVOj0TvRHpuoI1PzGxhX/yjMLeHNgO7TiX/KVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZlGSoBZ; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZlGSoBZ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4a456e44e01so769630b6e.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 14:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786570075; cv=none;
        d=google.com; s=arc-20260327;
        b=iq97EuSMDA2WhFS68Z4ii5V6FsD3plgeIa24o6og5iQKdlZQYQHpG9Nw7oLbOVp934
         pVG69IdiyG8z9CKuf2hL3XEN0yyHCU1yO406UBXNBtrOreOOp0VRe/o1Kp/DkZVdMf6z
         tE4XRePe3CXNNlv5SqwjkDVLyNwMpVsjnUR4no3grd2FE+/mLpUVKrk0yB0t4y7RDcw+
         fVNMf9KpZZbTOiwuf7gFxWcfaTTKaKIOOJPTEGIX0FsC5qGRVIG3wg97u4Czh1P4C/dU
         f6s/PDG128SjxOQ4VBdml0EDbXfTeMiVDwWUzj9IMiFJXDNn0cyjBwsQBVcNkX7WBOFp
         d75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0qPM2QrdrNH6erKebJdcbtHiO2Zc1utPk9BjxtJb1A=;
        fh=Thg1mHIMl5FQ6smb4c7xBS4po88CjOWo6rqpPVbkx8Y=;
        b=CjqY4IrklOCYnuVFQu5RXadipZm1JjoSsSjCfhDkmDM4H49mXtAOui1eKlOC1Nh7eN
         QXZ2QkQdRfkGAME+0XaObrv0j415hWAafM0eJe4IDy4yqZh31m6c/6GF87oQObhR4hGB
         NDEo0mtgLOFIjBipaUqNpnwLAzNoEVI0KjV0c2RWlxPZhlMWRdHI6PqpdVWst1elLsRa
         1X6P1yjhOY8Ch93NRfSGOzWNtbNTxZezondPx5iMJlc3ukKdpXTNzkCsGIO458NACJx7
         HxqPvnnFmQklZDbi/QZkvKRQdK+VhuHzElTMqNvq5FPEGZsSK40QZHMiks/eE9zSRJD5
         xD2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786570075; x=1787174875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/0qPM2QrdrNH6erKebJdcbtHiO2Zc1utPk9BjxtJb1A=;
        b=XZlGSoBZjtTlfZXSWLQtrlHhA4Y7ZQhKdclOFJoo3O3nOcclY5LPOlDEbgUuNKx4gr
         xm1KjNbAz+Y0AbQP5OKv9zvEIBUwzN3a3p/3ggvKjTdGJrIVpD/W7R2umeLatLhKMZXQ
         X6wO7Ly1EhKQQChD0cvaR1soSiwxfu3GHO3AKc97hewAQ1/vcH9Wgmq1/e+MbrYBQM6U
         c6l7KpStTcqyaucky3DH1J2VeKjwE47QSTY9fjpLQNSPz1/kTgckM1exJQcqS57HHumy
         Ah1xlXRGCcZOVODSzTSPZwky5EMlnQhrizr9NFB8og1n8BA6nUDMkJnctiozRWEp4wvJ
         UGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570075; x=1787174875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0qPM2QrdrNH6erKebJdcbtHiO2Zc1utPk9BjxtJb1A=;
        b=fwix0sCGj91wnRdYpX/vCuktqrQLLq4ucEmT0WpbRGi70FOGzFJ6N5rrOaXdK5qu9K
         yki3QfHSiLl+rH9PuAfKB5EUiIxuPsMwq5UMoKsemMpw0FZh3uPz2oNtA9rDms54054e
         POuYWqDBPWYeP8pjL5Uugoz9PeR2S3TW+eGmaYcCReyBDPHG65BfCiV600kxkszX5tcM
         jP9B0jORzY6uwBm9tdk9tAke1w2mQHAa5NLDW+HeYH2HDeQPrLdETtNFARXu6oHysfuH
         QXqYCCk5qW74NMCsEipqQh2ye+W9RuZIGo6pFBDx+ix1SWTOOWkDLDyaNBcMQBE+k1GR
         c/kg==
X-Gm-Message-State: AOJu0YzP4JsU7/+qXkb+BbqdVm7zd6FGhrYpvdB/v6TrN0OaGBxoHmp6
	sOg7pHomd/F9Z/qZ6llUD9EFSY3U6GcORq/iFTwwXpfr6j5+Y3sMFiKYcWlVdDTTEJqYPiteQkV
	+XuV0gdoPoan6rpaaLyc/oG0E7FxoSF4=
X-Gm-Gg: AR+sD10TmmKvOFLsVzMsq0AuKK2P8HxirURJiMPbe7epnsA4Lp/SZ49guSFu8uWAy+E
	SZYRC/nZ+rvk8uVETe/xKvYtNNR5eiJlEhX1UwplIkCcH0z+MBUK0tfNc9vFSL8RAbSEsYmEDpI
	jqbqqjdHmN0KoyxC5nX0h52lP3GAA9fx/FuqNTtYB/IqP2fFkp5V8/f++TaRo/PtxotVOJGICuI
	G2OHMArOEDguds2wngBpRaM4/sSdD6SIfQ0ljiMmw141QaYB2SqmgxvQWXQOlE/+oo2fxkBoR5T
	DuVH+Gfu+I5AVfTw0vrr62Aa8VsD2eg9A3t7wq+xFNcdpg9bhAWNeG0KpNou4E5nHJeUti+luvS
	yjYLGhdsIlFJxiC54tm0VESgQH4buCVSxU7GY5koXfAzt5WqKbvQNwZ1iljcWsMI=
X-Received: by 2002:a05:6820:2906:b0:6a3:1e40:6329 with SMTP id
 006d021491bc7-6b0c4220db4mr1485504eaf.13.1786570074795; Wed, 12 Aug 2026
 14:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2199.git.1786516783909.gitgitgadget@gmail.com>
In-Reply-To: <pull.2199.git.1786516783909.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Aug 2026 14:27:43 -0700
X-Gm-Features: AUfX_mz2uEdFSked7SZ3FJxl75p7EbILR-bF-W0RV0qUz8QTM8VsVNdF5KWcPW0
Message-ID: <CABPp-BGKfojr8wbQdkSegm_bL5r0t51_+qc7k74JMoKp4MDw3g@mail.gmail.com>
Subject: Re: [PATCH] serve: reject valueless promisor-remote capability
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:39=E2=80=AFPM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> d460267613da (Add 'promisor-remote' capability to protocol v2,
> 2025-02-18) added a receive callback which passes the capability value
> directly to mark_promisor_remotes_as_accepted(). However, a client can
> send the capability name without an '=3D' or value, in which case
> get_capability() supplies NULL and strbuf_split_str() dereferences it.

Oops, I previously forgot to CC Christian as the author of
d460267613da.  Doing that now.
