Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993439;
	b=OJTxUQ9XIRIGy18lHqnpNTolW0n9m3N9gq5wbUo5ruXbbpiCfPkhcDvCbaaqE2yPQ9cL
	 yULCQkTPBScYG6VNR5HKwlMhDbvfOk2Rsg7W8s6iwword1zlvaLoHtCCeYZmO+eW3Gw/g
	 Ahs0vcoYZZQJ8ISx0D2ephzjesZioccQ2v9iYrZi2OpI0EWAxRJLHrnyIqQZREX7gLXye
	 4B2U3nwXlzKTvar9OXfz4EvRCt9OY98RswLlr/1awGwcveLl7G003X5ZGaTLFTnfYqUOk
	 pt+rMr2D+tVRYWJWZM4f3TBitvdPXXfmEZ/FcYNpBrDBScn9rZg4YJu1fsDc4jg7V3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=vlkKVINx1OLdyl+QZkpbYAZ5q+c9q1fwIfzKGF9493o=;
	b=GTGL2vLQhs7CyBSqD4ckhJ54iTX4rnVyIVKVsqs5kFh+Xii6+tkzPnmEMQvDxmAj5gFD
	 GJd+1I13pLSUPcYepVfhnTmj69ksm5nky8zCa5Lk1kSoSXgAb8ci6RNydEZ1NtfESy+Ns
	 rqPUuFu6K/WIKMc29shwXzvKEdUCdxdzbR6XOwaAMvs835dUXF3GM2mbjnHPWbn6/e1IJ
	 7lVyyIzXcp7OfB/NxMHBHicAAal6qCcWO3purF6BncSYhI/ucM8FkPvUJ3XExXKDgph6A
	 PCFrIU1AtLDQpyNV9w/baXvYTGR0LuQ9VqlCTOKtkAUwXXgEPRXF3ci3oa47P9kbnDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vsx8eDWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0591606A331
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0591606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vsx8eDWE
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3b4944abeso645129c88.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 01:17:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794993438; cv=none;
        d=google.com; s=arc-20260327;
        b=TGNAGjdcydU5rgH2D/DESGZykdwqi52oaawSWB0zwSctyXGx7mCMoV6sp+pLEgkfXc
         cw7oI5pUouojXL/TmfSxIZHTAbEP3WOEZ8MyT6SEz9QZUTbnypHdjLakxxwdbAXoKG/5
         ya7JdpIqppgaof0QkZ41fa0rNzCpGroOmQYuCJwoizBS66U9i+pfOKWbro7UTnMq+aru
         7bql0h1PCeDNHfnTXLvIsfjfKw4/lWzc0r3ZiBWF8MPVDk7fedkkhy8q4akyg85EbjhU
         v3rDn6bbYumA9TvjdA/Yt7pLBbZc5KHi7HjK3Ml5hKz7XZKXrQ6U+Tc7Hohq1X57KetW
         IElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vlkKVINx1OLdyl+QZkpbYAZ5q+c9q1fwIfzKGF9493o=;
        fh=SIOQ8kTsF5hsnUPUu7cz/6Hml5sUs4WJ7Z7wWwJK8EU=;
        b=WUOGBhFsLKzNLu1qnz2tUp5s4Qjhxk4CmkzMeygjWZIZjvn9XakFXiE10h0j5Mf+CX
         Xn0E03YebvHqO6uMuy8ZUrBGsaS+ri7k2sMzzgr7Sj3+EnFhJWllC3k2fg3uZbE3dQqN
         +P7HUhjYFd7c3VA/Rj3yXZSrQjwNH6MEb09zN2LZwaWQn2NR7PsDu4hBWHlRPValVAyR
         INQsf3uhbaFXM/Z9rW4LgNf0jFyB3v2HFIcSdkp5JJmmxJA5S+E8bO7IuPLQP8tXbuXe
         C0TK2td/XBcR+CCjZCBFOpgljh5pHteTsS2zg9gh6YpbzexiADFWMSvGziCRAth2Q/qa
         Ue8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794993438; x=1795598238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vlkKVINx1OLdyl+QZkpbYAZ5q+c9q1fwIfzKGF9493o=;
        b=vsx8eDWEJunupW/bBu14naihUAwpDKWVp2EOagWweBdvEE0tW7OlOV/irZf+qeMEbd
         wSaugCb+YNz0nbJyA6cIjTcnFxxcz3o97CKI1ISFZyQ7vqSxit91X0yxE0ZFUJT0juBD
         ZuzwoBR0HUHncbPZxEfCc9nIeAgV621VsQcyJNe976mV8CiGvqVPKu8JVrKkbSHebaDQ
         KFwF5EliJBEPiVdM8p5/eK5KN4+uSDSweAyHE7N3lvVXbaDSJ6OPO/lVLJCgi0gOKN5+
         /A6t0cfQztqT/yzX0izLZ/d7Nt3mkMrPFNeyGBqD5ScVWriPBffy82qhrBbgoiynz6SZ
         ooqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993438; x=1795598238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlkKVINx1OLdyl+QZkpbYAZ5q+c9q1fwIfzKGF9493o=;
        b=TFkddfC/WbXsAMbAx8/UpxKsTtvXQGvn/OG+erF0Xfc4W0nh7m2dQAge8cEW+KKe/r
         5DIcpHhhZEduDbWEdvoLAyXGirp3/Ij1rYYbJbWd+Nj3bNoQ5FyQK4V4MFxh4Z9TGkra
         AJEdBrcn7EVG/8YB7JYiz5aCsNCAuIRSHZd1kS/ww6CISFPB5ch/xvNvT0w6xgIrHwyg
         4iYKVMyLpINJUPPf0qVnSqZPHjk6VHYQhtFtxhwr+Nr+uQca53c93AuG1rsnDp4YM74J
         5yN1251X3ZvbtRuCcWOUHRlakXFus1cfrR/nqpQivLgfbLc0fIidD/pae7XyP3lkq+bU
         JIvg==
X-Gm-Message-State: APuU4Z+MOJBFtq8WQODS+K2OVq8WTdEGNGjZEKO4h6RZAkjUDqQwav47
	Lx9nQvZ7CMpV6oGAlihMTDiinTe15Enff2oYNBsK3I+4Sp4SZJUKSpiksBlM0Qcny7aWn8WwRX8
	2vNcrAkxjSCMuifFWqfV/TIaKz9jbLok=
X-Gm-Gg: AYBFou21AX0r4hEW746nPNEBM9lirIamlEoVngZLCtgJbSmlHZFcrbwF39RmZCUUmqc
	O9ixggwTdQZnuP6UAU93Z4TVjSSefy+kvRKk/VgWObhhEIlaRKfsX2ovHecAmka8BfeYGwnS//v
	HT982LDa7ltU26tw+v/VG7f7Kmu/KE3jSSqI+mVfFpHaGDnxFq7sTRxguvS1G6peJDhvbD7GvaE
	PFxJ+WIZLu19woyKxyFc0HhvQfXMZopaRrhOKYm0+EYXlLDdcl1D6HrLHMuepbYHNmzlItIfxOx
	2/8WoLG9j+uwpc0ISxZq5jGsAHqJR0Zuw/8klAzpFIgYyiBG/arjwCn8CdziL9bOSazNQEUBOtZ
	OE1CcHVLBWtUVQg4lUlyGwQETcGnyuYm94M9S/dxov1qvkjLLSy47rNFdC/GjuOvD9xlmx655kV
	mSEcxtsi6kVFu/Jb6JjeJvrujI1CFa7QwebCyqR/qPMILvkusihCIe0nrWTMzDmoP2v1fuBpn8L
	lS2KN2pQV2liaMfQEDSi/gm
X-Received: by 2002:a05:7022:370b:b0:1a3:dfb6:e593 with SMTP id
 a92af1059eb24-1b543d001a2mr1814060c88.27.1794993437741; Wed, 18 Nov 2026
 01:17:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117174353.1158905-5-christian.couder@gmail.com>
 <20261117174353.1158905-7-christian.couder@gmail.com> <av1g7VQnCAcs5J1W@pks.im>
In-Reply-To: <av1g7VQnCAcs5J1W@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 18 Nov 2026 10:17:04 +0100
X-Gm-Features: AclHuK_koCYO1n8wi_HAY9icDs-9G1Nzi3TuYKYRDIHTw-tjTHlgd5-A2-wWVOk
Message-ID: <CAP8UFD2CLGe_ip1EPWvq+Es51ROzupiFZgJFuNVpLHrFQSUK+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] odb: widen odb_write_object() length to size_t
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Elia Pinto <gitter.spiros@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 9:25=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Huh, I thought that we already had patches recently that converted this
> function to use `size_t`... oh, yes, this is overlapping with Elia's
> patch series [1]. I think it would make sense to rebase your patch
> series on top of his patches.
>
> [1]: <20261021101640.329990-1-gitter.spiros@gmail.com>

Yeah, I overlooked that series. I will rebase on top of it.

Thanks.
