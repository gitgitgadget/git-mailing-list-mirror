Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8607241139
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499742; cv=none; b=CtHmalu4iVxGN3fQTKkbquoAAAmUhO4FqojdhAG2V8mV5hCmm9wjFu4Hi38RlCiVM/oyP9k1/PgF6mDdM7BmxY+ip1a4TG5JXqjHm3ClIs+MIy6e/jhRfLUz/uSKSwQgnwVCuipze0yM42YyKjP/g/dgC537D7WDMyoWSlRG7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499742; c=relaxed/simple;
	bh=pu6gQRR0ItPQSeBu9sERkS3FrO27szm4WJhbeMkEsRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/m990C51sxlshLlugcKlsnP2TvAXu2JMh/o8pKfpNRbHislmQr69lwEO2Ott8uOqm7WfCe5PocfDJybNDWWQb1rfy1UcIg6HoMAMJg/MX+bduf5oJsAOQpJKUwHZ6qrCPrxhuwqNMkzyS20+E9K7PE+Moe1T/NVQ25tJ0nXMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir+I+uqY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir+I+uqY"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37b99da107cso49747341fa.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 06:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766499739; x=1767104539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu6gQRR0ItPQSeBu9sERkS3FrO27szm4WJhbeMkEsRw=;
        b=Ir+I+uqYD9f10sJbJBQttZ0hY525N4NUl4Q6328s9C8EvnWPNep6NIgjrHfxvloeyr
         ZBka/WIvOjPpE1aYrW3NnTpbRvri4DnlEP/wHb0mVbMmPnNOYNR0YY8DaIsaT84eLOt0
         m5TdzEkK4S37lv4lUKrv5WgWfwJpB7xpqoqCxPj4FLE+ULVzzSqyAhsxvBPvs2xRtMVD
         He5lVpCE6bpuMGZ3BK2NYZsW0ejPNBe9Hd0XN5Hs88VOCU2JWYC7Jz2Trg3tT0YPyuNg
         sNknXiqtTvtxwkv8stjZ6gJQYGaxTkj6DmwnQkDe2ZsWYESR1R755Ko7rwceXyOdEvLX
         F7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766499739; x=1767104539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pu6gQRR0ItPQSeBu9sERkS3FrO27szm4WJhbeMkEsRw=;
        b=mjJHXn5RhDIWc0swrSErLEOAvj2DoKlFzaUSVWvltMVKnTXi+aeLsBp0chJZwkVYXv
         TBaL/UpmJTZ5yJ9P+irCRk+41P6bYKtQj5ZWDN6YdcqlySWpw1WP8RXb0ZCBh9it7Jzd
         Ydvz4C951tcfoaYyB0Y3bCkZhVEo2BAqeMpPVE/hXGWe8Tj9W9x5cyaiHton06q6kuaZ
         mujIZAWrmFJzqe7W0OehW2CcDd0aJCAjUJbxpgMJus1jO5WOBjgJz4ZGpnQAM+Q5s1hd
         75B/aNVkkS/rosnz+LTxu/drcFXBtAh1ow0Q/Ar5aQxD8VAp+ZlFk4fB2xacfZWGKo4a
         3G7w==
X-Gm-Message-State: AOJu0YwW49w2ISn6WI7O/8Xq8a29St8AckcW7voXFTzIG/E9nHlTfE5k
	lv82xofpmVYmXdf0wcC0Mys78rcbx5ZjmisAcvNht3Ix2QoS2U48NPISND4MaPm3ETdyy/Abc3l
	qy8wDw25TjUcFFlKw4Pr7PgdOOhiz7iNFwg==
X-Gm-Gg: AY/fxX7ntYMNn1lF/6ccplNxn4PJVZBrvd8iEvF7V/RzxuB5xRgRJ3bDoQSFgW5OH4B
	MnZmxLaV9t5DeEerGZfeDGutvuyrfXgpvrrd4CNKt5mzvFib3x1reUSM68Jqhjvuo9qrltCgs48
	14HlewdpPGBlOq8SLesaJY+9w57jY75sImyNPxRv27mHZCNK+bWE0GZ4vOmTIyuD9m1Smi3JVc6
	bGE1yAflMcDsFQe5BIOXEZyKFDGKGcZ47YOfD3+XQTXHgMerJuK99zDvFmysrlslxR89sba
X-Google-Smtp-Source: AGHT+IFO20YTgeIzIfVIcL91/wod364n0G/kExvVmmJvAZ7seXlH+4/ugEVNp43i7fo1cI64T8Jn2UrRnftInyP6Cw8=
X-Received: by 2002:a2e:a991:0:b0:37f:8447:68d7 with SMTP id
 38308e7fff4ca-3812164263fmr50020591fa.27.1766499738488; Tue, 23 Dec 2025
 06:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPx1GvfrQNao78WYfadttM=B8iyXKfxYaxTyX5w_MLZt2_bU4w@mail.gmail.com>
 <20251223141857.70087-1-haraldnordgren@gmail.com>
In-Reply-To: <20251223141857.70087-1-haraldnordgren@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 23 Dec 2025 06:22:06 -0800
X-Gm-Features: AQt7F2o9YTAxC8TaHj3ntI-NWdAOSMmDNeXWeIQ6hzJqIbBe5-D6aMhdR0a1OwU
Message-ID: <CAPx1Gvesh8dsw39GV5ejVP_mvdFRYGTV3GZqf=fE4rwbasLhZA@mail.gmail.com>
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 6:18=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> I played around with pushRemote and I'm not getting it to do something
> that's useful for me here. Granted I'm not an expert there so happy to ta=
ke
> some hints on how to use it more specifically.

I've never actually used it myself. You do have to set it manually
(with `git config` for instance).

I've never been completely convinced that Git's triangular workflow
setups are The Right Way, or even a Good Way. I've always just
done everything manually. But they're documented, so they ought
to work.

Chris
