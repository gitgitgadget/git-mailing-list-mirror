Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792526260;
	b=sqNnwqtewGQtL2/FQs5wekNYnUlktBTe83aKuVEhdtxcjwfrVZfbiinMC4n29DOOAOKe
	 90YJFlc7+RRFcuw5ndGuQPi8TsTQdLciMWy62TgTGyRCbL50FxODyPVoaybbHM33/4pap
	 1jT/oRvFntP4ubZb13Vj8F6eA2WMKA73hksk2h2jJcc0kUYUM1AzjEZom1fRoVoIIwBZm
	 0tTjTnmUYSMzzbsKKRmi0rdvIW6vLAT2NPNV6h7qDDVRLeffRLhTODc32V1PZooBsaKcv
	 UvcRAiYOnY5UQlALgdX66rD6Rp8fJ0UVJ49wStMMS2U7zoKLo1rFcNQjZ3bcWFunJIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dRq0iH1lWFgJpg0bUlcqbRssTT5qqC5wAcKryn/IKG8=;
	b=4rcBqoOdpMBNxN7pu2TAzRbfSFwBQ/00wJMfMmXyjmUWUewx0KwMqOuUTUAopBf551o7
	 RI5Zo5D5bix4iy1XRRpFLiAxu5ftmLsH/o0NrFV/VzzlpZwU2nbuJ17vDa/nRwo4R/Fa+
	 ZDhE+G69uVg8DNVbE1itbBoNuCUD1Gn4JHIIbPq42McPwC3u2r5NBZz2VWiQVhgYp0GIM
	 PhmNKfWayCDeRhVYeatppOd5vSfJIeBFK9eAabM4VLBYIx+HCwvm7/XPn/tOsshB64LE5
	 UKmf2e2vJhIVBgnGexdUYl32H3Q2Qb5O9aiECk1QHvomhgvmRwpBNTfXtF/IL480fSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d6kIH0f+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC842606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC842606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d6kIH0f+
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c434376dbebso4216266b.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792526258; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9rM+gAbl3OQ9cVvz/ARm6YqGr1lleEb8HedSJnZ2l4M2aUFVgiP7u7Vwp4dImdc02
         tfZ6gCKTDFCG5IBa6XY038RiNzRc/VEaEssdV9vqGYHVMpDR8bxMcTkHan6sRmIbUNMl
         Z9oJSXCiFuUBig7JrjDYBZi5EktB3WywMmDEsuK89LiTjTHR2RzPKbLkbDE6jJtXw6NK
         Q7Bc5i1DQDW7rU7M9aEPl5P8LU+posh8Wq0FePkMVSSP73iyV8xO0/pvJqXziRJTwubV
         x02c6ZEifY3FO/vCX1p83F+pQd+wsAdWQlYyw4jBKpeujHRS6601x+uAnDWrBByz1zts
         Ss/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dRq0iH1lWFgJpg0bUlcqbRssTT5qqC5wAcKryn/IKG8=;
        fh=/tqX+oBZlwK82t+RLcSnI6gsF+e5YRIcViAWd0/TzB8=;
        b=risu8Cf7XoDyQnVF3YbeNWJ17IBURy3wcfMjoTLAVu8xroGAQ/SBAKSZ13qpP5ZEcn
         LA+DuXgmJs9ib1zJ1EjpL4l6H4YFHIZWpRVXUAarc3VzPAS1JUZ0kdDAuiTlV5jL3XX9
         dZ71t2Fs8vmDdQMbGtpve2ESJuZlrWYEVB/zYMo3AI20oW2530P5jdEV9SZ/WqVCYf/q
         9IV0WSxlpU9I7IW9CBFBVtSUPE8X1lUZTWYGPP32UamEKBtGvmBwDsLmo56eCh8HJlD5
         6sKAgQFxhEQXzXe1EtljyltzCm7MIwi1vOYpQOBhxT1+0Mfldmh9AfORbrVB2qXbs+eO
         ZfsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792526258; x=1793131058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dRq0iH1lWFgJpg0bUlcqbRssTT5qqC5wAcKryn/IKG8=;
        b=d6kIH0f+E15w2EhDtvdFiKWMExhPihhtN8v3jKYiGll8A5LseQ8WWZwBqj59TfxdmG
         PXjVs34bQ7WSqRzghC0FB1w1Y/182hUU3XIgZ8KQtOBih1MNYNiUdVckrqDEIB62jn7y
         0IzcTKNJRM66Ymr8KqV5kKBVMuD9wO6FqFrLKQ6QBK/sTJTVv4YK1NXHOqPox2eNrgcf
         za72OiOrf5Pq1L9a2zBZ1hzOVwIcbdn9XoMajpvDPVQhcFHZsdM409jffZ+uYhQgzU8x
         WG4iARRn7bC86JJBlOfJlMLlTtZaotGhdiuQBpFSqQG24Lu+ESyIDL06f7aJuLOQnGw+
         +yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526258; x=1793131058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRq0iH1lWFgJpg0bUlcqbRssTT5qqC5wAcKryn/IKG8=;
        b=rnurnq+Pl95FouP6T718j6xQeY+1i3cGGNFeMAuZ6DaupgwwdxRJPOe6kEObESsjYd
         Up7eQEHOSBvnTByQGfe/9meJNYH3U31fO2CWLIBY8PkdfJfncJrd8Dapj99lKQvL5KBb
         ae+bON+P/6Bh6gATmnoDmDA69CgZoMLwgFoE9I1Tqux2Yq/oV7cdSJDzQNYWFalAR2aL
         Kh26hLIE7kBk8hAgSTYMctOGXF0+eUn+myULFKz/8oI2KzSv/593ojv6kx6bjLS7SaGb
         hOGkUrrOB2Psk+dMG5Ez92u4trAV66uu1R3YliirDK3MiMecKrUGyHuCjQTBZ1tnMj98
         /pyw==
X-Forwarded-Encrypted: i=1; AKwUvBx9s5cvhAzI13X0ZueVnAvBuCLUsvezxWwvP4xUpVONyveygAeHD/Yf51RyHo5RDDm2PrQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV9onbaZ3LU9kb/RaSeCzbQJJao8vL64o/vNstmoL4hDY76E8g
	jfkwgdgZRWlE9sHwjZVGqfW6dXj2NfB0GpYBLbfwXBUKHAZlPX0mofWE4vwqQdXtKGVxBuXhm7o
	8g/KB/g7yl4CiBh1GhgfEPvtZVNMrKls=
X-Gm-Gg: AYBFou3R3qKCrX70gDRJCZqYDExv/6rXENsx8/0tBPjJomivVdLNFJ4+P1SIvukLtja
	pq36x+ghtBsjOiK/i//LlbHqetQahNBOsIOeCEnUwvRw8zR7vGzZqXpQ1PepWN2tUZ4mhEPhNaY
	zCK75v2LFSJ7jTMfeDXXHodiviWesuX+Y8xCDeLJ3pchrFYRtNyy08d8Y2SAEQm0Ng7FFdhsn1d
	k32SR+hQRnVX0QXCmJxzDGEUgiRTuQSbSEigSJmJQJVTbJYGig+Bw8yTf9t+iFt5CckVFrUYDWe
	qTO8ydp+yQAufiKF3r4BXCYkDaAo3H4AwW1Oy0lUR1Q7qQGs5rwIVSS4CtykCPTDrp/X/0/wXj9
	S2KDXQu+d0GGqHHm5m4Q2rdxCW6C+sLeuM+n8B/soR6sNnZcF/oehKJnzk5IQo/yr8TsbFV07pX
	tV8isLyUyT5aWOYr0=
X-Received: by 2002:a17:907:1987:b0:c42:f25b:de41 with SMTP id
 a640c23a62f3a-c4679793334mr17145566b.20.1792526257927; Tue, 20 Oct 2026
 12:57:37 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKA8Uu1oLhdhNC9hGwMvQSC1+jzJqXnnWPGHLZUm5ZBdPkEM0A@mail.gmail.com>
 <CAPSxiM_5J-LzAx6pkMrH1L08QX2hP5KgqWbmc6b1Oa2thboZBw@mail.gmail.com> <CAKA8Uu1P0Mtbf8GciaqN3g-9ttyKn7Gh-3Aa8F2hV1PCbGrvWA@mail.gmail.com>
In-Reply-To: <CAKA8Uu1P0Mtbf8GciaqN3g-9ttyKn7Gh-3Aa8F2hV1PCbGrvWA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 20 Oct 2026 20:57:26 +0100
X-Gm-Features: AclHuK_WAlacAzr0bbYQrmDvH5dORY-X2S5Ul305sOUrC6lEjcZeqQ7e3ngqMMk
Message-ID: <CAPSxiM_GysceRRyEukVkUNhzvhsXcCKYsQXYmOyqa9kZO7kx-Q@mail.gmail.com>
Subject: Re: Outreachy: request for a focused global-state migration task
To: Joy <cryptocurrencydiva@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Quick question about microprojects
>
> Hi Usman,
Hello,
>
> Thanks again for your earlier guidance.
>
> I=E2=80=99ve submitted my patch to move pack.packsizelimit into the repos=
itory configuration as part of my work on the global-state project.
I cannot find such a patch in the mailing list.
>
> I wanted to check whether this would count towards the microproject requi=
rement, or if you=E2=80=99d recommend taking on a separate microproject as =
well.
>
> If a separate task would be helpful, I noticed a couple of file and direc=
tory checks in t/t0200-gettext-basic.sh that might be worth converting to G=
it=E2=80=99s test helpers. I haven=E2=80=99t made any changes yet, so I=E2=
=80=99d appreciate your thoughts on whether that would be a good task to pu=
rsue.

Generally, one microproject is what we requested for. But, previous
successful applicants
do send more patches after their microproject. Git is an opensource
project, you can always send
your patch.

>
> Thanks for your time!
>
Thanks.
> Best,
> Joy
>
