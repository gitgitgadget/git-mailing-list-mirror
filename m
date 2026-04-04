Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C71B532F
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775321942; cv=pass; b=JoSlDzf7rVvjbcCEbWPjf2mPE6x0V1fHwuiI92BjLtR/QbN00knWx3A9HZ40Vl/6/Vd3I26/QBwHX6uO9NRiKJmiWJohvfh6IzedB60HI+JPICZT5z4RBuC11LoHPqfKnrH18wTn3ndyq87yJLRJ5cRCapViHKa7o+dk9o9M5aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775321942; c=relaxed/simple;
	bh=BJTY26xINEeVly/2NPUEd2zVgvczzQ4p0E8URA4XjEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJsVsT1G2efsnfEINqywrdJzQ/+jW7lKmUeNWvVcI9f8ACOFnVmlT9mF3Olaa42BaNyT3Q2KFnlRzYFfGev1ahuOLnRqO5fIqZyqiANZRv3k5up8bPsjsanaL8RgjPuW8UyKUk3C5Y9l/DHKOMTMO1Rqa7Bl4wQiNqFi0jv9Teo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXocyB3W; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXocyB3W"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b258576d8cso17501825ad.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 09:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775321941; cv=none;
        d=google.com; s=arc-20240605;
        b=ZtqoQ8azhZupJZdI3AM1sbPsPvYyrGCNVizI+i72IL0DhOSqL35gDnnqN6EsA2KkdZ
         z8DqeNFLRJPElFGTn4UfbbJh2EPpQauLUuxD7qFaEVK3UhSztvSgTb3TtKFCnmdsm2QM
         njZr85Ng6KuA607GQO2nambo8RzHzl0dy6co/+y75L2Z1RGdfvWVGSWdV9cPQtmAjGDo
         3VnroaQ13+Ze5I70XPx94luj56qlUreVGanCOJ757Zmij88GjTDE48EfjTrqY4rA+qHT
         959AfodZXP0GtTl/V4qS1asxIN0tBgZ/YQzuxrbCGghsmTf5lek5c20OtRYnAzF0ZdFd
         hgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BJTY26xINEeVly/2NPUEd2zVgvczzQ4p0E8URA4XjEw=;
        fh=+zbdEbVLutUf+SfexfSkjqFutMS4FMUhiWVk3N7Cdx0=;
        b=CnlY3AJStKdUS5RewKvIB0BnNLck5JR2/PNIkKU7Y9Xjw0igNfSRNLX6N8ZFuiYwPj
         FMnZaEFE+onOG+MAmSJNfNj+WayR93yL92oz1czeODv91VrrxHfZHLjkLlmnI2z6Q5Fw
         CXx3FkMljm1Wq1/3m7g4OWQO3dMsa4HUWHDhDtaoNtyZQ8e3a8qN951BMv013xtgnygo
         piEWrkDFL3g5/bh2wqk1D9HZ6Fo5QHjPYWnFpqvsxnu0TP51ywOBguUmccaIhxkqRfE2
         mbkvr/ABKnoilKfDRCwwuYyQfFrCRnyLFn+IDmYu+HqXssr4pQgz4s0bW0hMGtiY4lyi
         YCzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775321941; x=1775926741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJTY26xINEeVly/2NPUEd2zVgvczzQ4p0E8URA4XjEw=;
        b=eXocyB3WrQSY/dsokKv9xRb1/JJwYvYv1/+GDWSRUCG9Esp+iUSrjhozS55U5oFDMN
         YfmM2mph6cKsjNUXyaiNq1Hx7foNSby2NMl/BrtvK8GTf1n3928AKEy3YKnsSA2QuRAC
         UwDB9vljXfww8Bp2kIlzErWWLC7dRMNbPUjYKq4JNhn1FMz4xWs9I2O/SMkPDUh4BWK0
         LXsMxuvYknbvWfWtVF6Up9AflLmwNMVw/5KFShFrDHF+LPCf9TQfAPtgTPLtyqDpsH5A
         0zwovroFzQPZv0I3OLyTnQPX5HuqMj8V81vPI6mSauVQAssV8cLK9UT5H/W14Z+FBnxc
         mNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775321941; x=1775926741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJTY26xINEeVly/2NPUEd2zVgvczzQ4p0E8URA4XjEw=;
        b=bQc/WwuDf6MbmEmYnZGhgkKvXYZ27Yw177TjQ4nQYu7UsP69hBOaRK26f8qFSd4VHR
         zCkLOFoEfnj8wMgTdoIkQ9tclcE9UnO3B+xNKXDhxt/74Hg71Xj2EMXJ2Hy0CR8PyBuX
         +NdLUFxQWxnvbU4xXCLoUIRMdksaJuQoKFoiKwM/5qJjI7240ySEJCjMg5k1ae0A379B
         C3etsmecpw1jO/m4fM19SKLrQ62deeYxEkc7aHhD7i04tL6lgD7LMklAv7Y7ufCdB4LO
         xRuPbmhantrY0ucFVZG3MaUSEmkJ/dOdoDbhfobiyO/5hLPClhWSXeZgo14NgagTiIEe
         nqdw==
X-Gm-Message-State: AOJu0YzzbrObREI67kpyjPMNscbmdbJycQTf1f3otnE9Sy3/e1XsnkL9
	3ETcyhw7X8HqRWyiDqHT7T+xQ1Pu0lXI9BGptkF23nHfttPTarr2NaNufkUSg9Wpb5SqD+l9m2D
	lE8cmsU6/Hd7U2BkuwO7HbMtwD1KXiwQbwA==
X-Gm-Gg: AeBDietDWF6/LOTpv1byokW//t/rjCeHNztlW92rGfIxxgwm5ZunvKeFeP1b7KlWdP1
	rVNS7DZ7MVOuNhR0PCpq2Jkvisff7X4gCzd0Hs0QaKzdJtqe3eByuFKR3jugvNOP8UpVtXBJnO8
	l22SuVblqoQ/2qbDO9TE0I4+eM8CGX+q9z55INVHrx27TZe9muiAYSzbROXx43HSKO8+s3E97Be
	s7GHecA91IcURxqEF3Wrhu4o3tuok96S9sRGNUC4/Q0x9J9zSgvkis+KMINX5CAjwwSLwPsHR9U
	z/GJ8QpMXhFzjL2WsWEzsu4gkxaQgLRH9sLagU4pbDkaERi3GvKu2boafb8U94wuNj6+/PQv+xT
	GQfYWLvRtk9AVhiviJpsHikD00A==
X-Received: by 2002:a17:903:32cd:b0:2b0:41bf:ca83 with SMTP id
 d9443c01a7336-2b2818b40b8mr68511695ad.23.1775321940923; Sat, 04 Apr 2026
 09:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
In-Reply-To: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 4 Apr 2026 12:58:48 -0400
X-Gm-Features: AQROBzCcjrBGa_47KOjgibvxUfQStUpO1713jkA2NGWvpF1S2H1v6_t5gRB49jE
Message-ID: <CALnO6CA2_MjKENu3CK-zCfoG=edEuMm6rohBtJ_8JC9WgMudEw@mail.gmail.com>
Subject: Re: [RFC PATCH] switch: provide configurable detach
To: Thibaud CANALE <thican@thican.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 10:36=E2=80=AFAM Thibaud CANALE <thican@thican.net> =
wrote:
>
> Its purpose is to provide for git-switch(1) same detach behavior on
> commit it than git-checkout(1) through configuration option
> `checkout.switchDetach`.

I considered contributing something similar at one point, though I
would call it "switch.detach" ("<command>.<option>").

I think I eventually decided against sending a patch because I was
concerned that such an option might make using git-switch in scripts
more of a headache. If I'm using it intentionally because it will fail
in some circumstances without --detach, now I've got to also do "-c
switch.detach=3Dfalse" or something to control for the new
configuration.

On the one hand, I think that argument applies mostly to plumbing
rather than porcelain commands. On the other, a command for switching
branches whose behavior is reliable enough for scripts seems
worthwhile. So, idk :)

--=20
D. Ben Knoble
