Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2B378812
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653202; cv=pass; b=digg4eK4MiXOqohDoAbratnHLj85YZz9TMgSrt5qcscpJhZXww99Hqy8HrAAk4XYTd1u6c/fLb0yiylcHCCTMawv5ZqueFWwf1skKJ2kovtnJA7aolGIrBxdQT8D6gsYF3fNJgN1XDIU8lpBBOJdShUxMTqhp75lD+uoHA4o0F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653202; c=relaxed/simple;
	bh=cJocQryK/uFOg9VIpDUIxp5tH8t2MwjVhqmNEVKgf+M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=omEIxUjGlAf0Le7Vz6WvVXFztbx2ppY8TKBwFzK7sxKreq4wQsQ6YrQ0LC9TUTDKcI6Bn0GP5SKt3+j81IbCfJgFESYmF7kB7JqVM0G4rEVN42z0ZvUkkBhuJEND9/rUM/wxul02QIGhn+OqQR++8MRIlXqUEh36xwIBFg1LQNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/JVqOyr; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/JVqOyr"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899fc265126so51980046d6.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 02:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773653201; cv=none;
        d=google.com; s=arc-20240605;
        b=VNZ2L9X9E6HBFGQT3aQ0DX7gKCSyufi9uzS6GoBLiFuQGAZovOG2Sd58EdAug97iwG
         TlpoDQGi/uHwU5qa5/6XOSKzPq5L1aTXox8iV+TI0Uns0CbFA+1RmeJ3MnO/BWD1A97a
         qCfib1xwbXTZM9gHZHBM2sEQux18W5f6eW94Q9g/BuBVIzm+ewf/rskFW2NiTpGSDASD
         hB+0HTkIjLoaL1DtlQpoCw/upmxxztubo/RtcmwrZQjyCSitC7haeleTJxEwr4bjPszn
         toEmfxyRSwW8KMiouOfFiS+MrW+y9s3g7jtGso7DvZgUG3lIfPh6Zz38TaltBlvgceIP
         Gtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cJocQryK/uFOg9VIpDUIxp5tH8t2MwjVhqmNEVKgf+M=;
        fh=ixSammk6oXejNnHAPgOTdyBsFR4Ppk8ixV/FT1QvsoA=;
        b=MWg+0Y6fvFshdaAsgTe7XxcJ/fHcAN9mBaQjlHxeOm2tgWmFTW0yiZIbjy+kttZh6H
         k56wr1VFdcizTNYtBtdNEPtkKHV95ZE58o8ut8W4LRR6LkofSTPpNv26qmBsKlo1mcH7
         mIxXSZWyUDvdcY3rU/A6S3K10JEMDPdRWbX4LVYGizpBYRpesb2yNQv6cThPH7K/ENHI
         BN650/tjdUxKZVMLAQyeZMHO7g8FCeEm29y4gw6OvJ1T+D9pPPiE1kJ3VhKN/iInjHHX
         X/VU0FCCtgKbFEmfRf+94frqrne03Zz04NP3rDDi2gcy6YiRrAGuoecGiLRYmA48UjHg
         YNuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773653201; x=1774258001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJocQryK/uFOg9VIpDUIxp5tH8t2MwjVhqmNEVKgf+M=;
        b=H/JVqOyrO6payNMDXTtWC5nXvLdKlBPeC/nsJZoKU8Bk8czrjDcGcQEeq8igojYH8q
         AFXhb+CMJqp4uqUAkrgfZNc3+6z4Q8cZG9XJAbd3ju0FrrmQzZ8UK61nar33JAiRVyxl
         qXIxoW0ifi1dGorSq9egi6q7ew47o5L9GEXbaO+xHtdCgeshYiv5o0tuemZWSqJXdIZa
         YOBVWrHbg0WpOu01Va+VtoHKLpz+RSMY5kEiuXBFMm2cCn4b/OFq4bI94m71qx8hHspj
         rYRSsEOebCGVs8I01YUVNiJWWARnMOa2vgsHshRS6agvKgW4J9Nx2O1Zodi/49INlTHa
         CWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653201; x=1774258001;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJocQryK/uFOg9VIpDUIxp5tH8t2MwjVhqmNEVKgf+M=;
        b=i7KCpKYcIWD1is58+BtVT15gj/qKRa9q4QPUbDQIqI4jCjYgQCIUThd7suvEVEzUb2
         t+j+5HT9itc0JiElC8iqQlgY7EDTbNRJBj9Nu4eIU4BvhNXxZlwaTIIfgx+VRkJ+kBWZ
         HVuZKWsl7Njhqd+2QntqGF9TPC2O4kH7+qMBYCDXGm8AmfXPPtCzRosRPp1lAzGgo2+D
         SfG6Nd/fOIOL57hrJXLfZeavLzO4sgwYgBlAzCNa9rMi3O/LfkyEkOGzZs9klnZVqxAo
         NvCAuQfOuNg7cVFWVQQle2gPgqZ0M4ovY7CJjTH5Ss6TVGQc81sOe6g4lSAWF7W30+k5
         RN1A==
X-Gm-Message-State: AOJu0Yx5ct6TA8TruBYwjsRgPhS8q+RChbfvqzd6ZEcK/S9issuhS4/y
	CfEWPJ5WRjJ02cpCoAtVDdepNNAUVUcnQ+85l0Uk2nk8rOn9icDctfHptFE/jM/iuB/CbTjCZ9F
	EEV2I87gHL7jHsf6PMK88rjKULdh8Jd1rxqXJOuo=
X-Gm-Gg: ATEYQzwA3yiue5yYjS5DbY/rmFMq5Sj8jlYio5A5RZvwCkAXukx9k2ygPdZp9gdCVNz
	F/pnjRbxLG8qLjcaNzQk7jeMqAr9lmpn/bsF+l7yXDF3Fn8rO8vcwvub72vMyj5CwGhX1hHWrxz
	NB4Y4uwJx6QBfzFhwp4T7Zeot6PupFMgTUqfTtaQdx8bXsUNtz+IyiDfrwIzmVcmMnWk/FLwVU1
	az/sD+so7GVla4wuO39yDIxGxMaslCO7wVLaCmN8hvUzSKtytPb/MJzjnhEjNCkitPnXKgns7Va
	+LIskJRHsQgM/1eXMNpzqopjc9aQu3LssNydS6TBAhTPRx5eWZU1iu4B0B0uN6accOxBRgykERr
	BUOomHIs95PEgWgR0cd2Zu+gg4w==
X-Received: by 2002:a05:6214:1c82:b0:89a:d41:b1c3 with SMTP id
 6a1803df08f44-89a81fe3f04mr171840606d6.50.1773653200592; Mon, 16 Mar 2026
 02:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 16 Mar 2026 14:56:29 +0530
X-Gm-Features: AaiRm52HLjrXPGCW_rjUKFZitgLAKgkxJ964VqoQ6qbqdAqPDqPcU9CLjoh5zJA
Message-ID: <CA+rGoLd0_gc36EBv_DieVqtjLn1FL39vtT5ib1fEbk-+OvPP6A@mail.gmail.com>
Subject: [Question] Ascii histograms for repo structure
To: Justin Tobler <jltobler@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi Justin,

I was catching up on the recent patch series
builtin/repo: include largest object information
_cc'ing everyone in the discussion_

The discussion with Patrick and Junio about
adding object size and entry distributions (histograms)
to the git repo structure output was interesting to me.

I noticed you mentioned planning to explore this in a follow-up series.
I am currently finalizing my GSoC 2026 proposal to improve the git repo command,
and I wanted to include implementing these streaming buckets
and ASCII bar charts as one of my core project goals.

Before I officially commit to it in my proposal,
I wanted to check in and see if you have already started working on
this locally,
or if you would be open to me picking it up as part of my GSoC
project? I certainly
don't want to step on your toes or duplicate any effort if you already
have patches in flight.

Regards,
- K Jayatheerth
