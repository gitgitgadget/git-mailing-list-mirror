Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D83090FF
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155477; cv=pass; b=XXKy/r3yXvKWAFt7SRUC/qu09Uvxw37+O/OWE3sL21Ai/1v7KXmXiF7FT9w3TRblN9tPjLM3SL+mgVQPKXMu/TOshlKWtTHPxir5abKe7zJnZy1OQFLBu1gtYojcf/jm8/ecsg9+oJONMWaon6OoMqC2Tz0PbPGCcpZ6nvimPmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155477; c=relaxed/simple;
	bh=X76JeiGaQvxq2tuDSOTbr7qhpc9qtPFZGN/3Y+U+8DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDyfRFI8AojrxL3V3006CHrJTrLFFGX1tIzOIGMfaK3EtfVRHf5kGpPkllO/WOAWY+MuaIeWpQKiCMG5qhtg0G3ttvuuW3QGBp5/OcvjumiRxPZ7PuDIml9/2So4spXLhGgV+oIyRdmcl9qiEgeyVwQMnOAnGn5TTIMa70j3Nck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf9w7D7T; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf9w7D7T"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56b1f4ddf83so2078024e0c.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773155475; cv=none;
        d=google.com; s=arc-20240605;
        b=FrCZ2/a2xwVWK2+uscf5yIntlQL3SG8z8PPtCfpWjWeo2Mk/Jw7qj+CCpwNPkPGiIF
         np/bR7cgVSYinIbs0q/IPQik5HTF7K+oCmoSI9gfVoKEaqhJsReMYN97ZrqnxVV1sbCu
         GT6Ms+JFToZRL1CeAO42OgbPVmBisff2oFMalf5jcwmVpGjGPTd/NED2rklahjnMB/w4
         nvmlldEOhyoTI+aanYk8sMXjyBytgGADszq77Ak2HGRQFpF+ob1pM8EC+XuX27FLkZsB
         NBTNZhw4eeE4cfOPIHK7hMNpCej9HnwSoEDeTGBI8uTbT6T6SVLKfQ/+TIz68ik0xFq+
         4g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X76JeiGaQvxq2tuDSOTbr7qhpc9qtPFZGN/3Y+U+8DA=;
        fh=/gGcX06DeFgoFEwRIaFTrJCIQtIJsBTv+VxT9QcwE7I=;
        b=i7XgexO+u73SZXep4QOIoLwTKpN498IYj25mim66qxV6JU8BVfk/BV+28ohOAb4831
         dcGi4AaJx9KqJ2uX8NPAhlQOCAjVqL0SBM9Zo0qDUi0MvyBpD0HQ4nwHbXBJT5BAYaH7
         /zcXWO2fhbI+6eITrk3eckYhwmPPBxn6b7G2rrz03JewHttu86mdAIccGzqGNwcVcK9l
         vDjORNpBuTQLSAMtTYFtEaoNSsXThGrcJWdJJujRM6wkuPr6b9yffdg3n8DUkBQmd8kr
         DpqMhR6JVdEFCLUfiA+pLbTcIaS473sNih8Nl6TpHn7SAhBMoCm1AP6Be1bz32j0CPOW
         cjyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773155475; x=1773760275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X76JeiGaQvxq2tuDSOTbr7qhpc9qtPFZGN/3Y+U+8DA=;
        b=kf9w7D7TC7T5awxe6/NQawD2jt7RNzcblABZ7bH9oVk/50tH9wBVPJe/m2ilQrqdUe
         dzSesgKUwVuo/WDsA6cHuVxDqMBMOvmf0DL+AJPlSKSjH/bYdbDlEnxmmrsA7kaaqB6K
         Fxlf6Vx+cCtwb1yiNDSQHhqieVMkSuDEmi5B/X2qLKpPRMzLtt4DvSJjTFFdA52h3x0Z
         qMnpaV+kiNNNgl5Dhu5AwJ4ctT0CSueobe2ABcXAbMTtU5fmGJXkqvCPtWE+ruApGd9D
         0NsSuZqQjU6dpTRyru7fupAZUmF/C5aoq+/E0Ons+NJoS6GigOgKa83Xdm8EHRCGmLbr
         ixsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155475; x=1773760275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X76JeiGaQvxq2tuDSOTbr7qhpc9qtPFZGN/3Y+U+8DA=;
        b=H9hTe1gO3bz3Jd9tikFbGOja7xsc9XCEyi7vEtGdsIv5aoIJQPLXdDXwnn5wQzBDKg
         ApcRMousvJ1FoGRAfWJ+k/2zUZixnC7pmRiHp5N3yDfjQm+Yoxg2z2fm8bxDpWm2q4e2
         PQCqWwXvvJgXTvPNNASzhtqTc1b9kxWHh3I0CK8fhAZuyzMRyPJs+CSZH/I+RReO7O4g
         5J2P3MyFVVToT11CGquityMeeByUpJEQcmzleZzru7oOX+PyViyskpjSvXMeceF4IrSh
         5vQrQsVPnER7WnA6tciw79ngdh44VtzPlVdnuGO6w1+t/sBFHRfkNMAVT4J5SIFw17KZ
         Rdrw==
X-Gm-Message-State: AOJu0Yyau0sDfxhmtnOVZcMg0kzjF2HjMCVR/FkMeWGq/VfSObweEPpE
	vwQIp0Bc82cblLebwnq2kybO7RuJWjh2fFg0ie0jZQh1984cDf6pSt6FgDgX/iqP4zOTvlOyaQJ
	8L/5Ji+T/w61pk+ItDGTrFkp11lB+uFQ=
X-Gm-Gg: ATEYQzyLkPiqn958Fu5Mw0u9YGEfTvTdjQAVEgEEVSH/BqdDBzg/06jQpYZXqUXa23P
	jxZREsRNElnalQBWZqSBE9nT+TUie018V3zIRVlIvN3A8bc/G3we5Oqwk6Mzx1SLwjQOC1vwbjq
	3xSyMznU4LBAc2bh4JL18zQuDN43lGFRkgsKjjKyMj+cPRjlQ+Nlz1kFLvbi2W25xpUMU3f8MFd
	RclaeS5BNY//leq1r/rq/k6hzNf0vc9X9UwvBbFmOhdwpZ4L81puK8dFeLZ+ByqWfiSAZcx7m0J
	mSo7ewrXo6fbN9oHE9M=
X-Received: by 2002:a05:6122:65a0:b0:56a:ef51:4cae with SMTP id
 71dfb90a1353d-56b07d3fdcfmr5825357e0c.4.1773155475182; Tue, 10 Mar 2026
 08:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local> <CAP8UFD1kzuP8sYKzTJkvf08OazrMzESQ+qZNW8=Qss3DDw=OeA@mail.gmail.com>
In-Reply-To: <CAP8UFD1kzuP8sYKzTJkvf08OazrMzESQ+qZNW8=Qss3DDw=OeA@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 10 Mar 2026 16:11:15 +0100
X-Gm-Features: AaiRm53w8YhC_WE5fYKLdoYGl-QDNU00uv3flgSLfV2uRzRZFCRak4_jRInUe0s
Message-ID: <CADYq+fbDVWNfomJ-UEU0QsEAmHoS9pa03aW5wOjBTyQfD2ojHQ@mail.gmail.com>
Subject: Re: [GSoC] [Proposal]: Implement promisor remote fetch ordering
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 10:27=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Sun, Mar 1, 2026 at 12:27=E2=80=AFAM Abraham Samuel Adekunle
> <abrahamadekunle50@gmail.com> wrote:
> >
> > Hello,
> > This is my proposal for the project
> > "Implement promisor remote fetch ordering" for the 2026 GSoC programme.
>
> Thanks for being interested in Git and this project in particular.
>

Hello Christian.
Thank you for taking out time to review my proposal.
I have made your recommended changes and sent a v2.

Thanks
Abraham
