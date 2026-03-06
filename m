Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3930AACD
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806500; cv=pass; b=TB1Blj08j3MqNzGkj7T+QYAzbznDavTh0HeOjkyVoSEFqulTWHtpZHtNyiUzaJ/9i7MUCwAXlStJoDWrZrooHiSfgOoZHV858JoHPCAfdpjos4BQp1eHarmX5Tb+QqFJ2Nzt2WU9h7M4NcsYXtCAoDjMmJM/tN1mXbkIoZzSgcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806500; c=relaxed/simple;
	bh=NISYn57yyhbbEcnymbjxM36eO+6vW1n4rTvLIpbJjOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tUpUwdJhGgyZ4a/dPigXBNRl40PV0Mpn2h5kx0IxroyENyJVezqCttiIoow/KArd/c0tzOeh2kcMAYsHnA+4afdiAzv2N3H3othWp2uIH53YmsvCrn3nbgNHZBuBVd1WIe8WoAQCHCwGCM8cx3TfQxqOw4Bj57zPkXD3hdV3IFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elKwkRfj; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elKwkRfj"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso2717360a12.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:14:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772806498; cv=none;
        d=google.com; s=arc-20240605;
        b=PuHH4GM/ed6iItwroQJv6OV0i6CbwzhZaPdJXzaJvqee9McA/6P2rI1zup/lCFYuZt
         jdaVk0Byyb9Kkf7cO8aZDkL+H+pZ8NrqcuupiE5ia/D9er1/2b4MPeIpzmG+RLuTJ2kg
         +YGvKVK0d8j3iiQqyB+jrjc719gcC/lShxrm3umY6qnxWJ/i/r9LuqaqfnKjhRj2m2xH
         aNuXyHepy5AJD/3KfqO0fAQCoFa8O2xYA7V8Gro7d3v+eQbAI97RAENkG8gvtHXO1UBq
         Wp7RBcCV884geCQQOloqVx6b0Y7NL5WJ2y/S8vcxXbrGNSKpCbQqhLiIxAWlRrQ51g68
         sabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=NISYn57yyhbbEcnymbjxM36eO+6vW1n4rTvLIpbJjOc=;
        fh=a2KKAHqy5td1kuLpL7y/Wz3YyvqkG49qzYb7IBgj+M4=;
        b=HCJOXHCz3z65/hJZtokHSeLKRPwVIOVRn1KYc7i44nhUyH2qnsiP0uqhksasrTQBs/
         ZxNbQzpfrA5MLqT2wAX8lWWOS/4Afset0PVZ3EnpxH5NjjfmdtLzUBbbmxMX8Th/OsZe
         1IoQcF9JKDqAqG4B8gGbWMJgff8dHsYvQA6xEnExvLf6/+VgS4hNcqvlmHu4wZSr2YFS
         HaHMJmfTsLsVqejUO8/XTlLE4aEUIpE5T4l0xtu7bL0H7OKDQMsGQFPilrOGi8RUxVC4
         VqjrHDnDcIxBsF5WSnd+r1diGoi8SVViEWSA57kC675oI/NbAXXbcmhxXY0lgJ7rcvmi
         kmOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772806498; x=1773411298; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NISYn57yyhbbEcnymbjxM36eO+6vW1n4rTvLIpbJjOc=;
        b=elKwkRfj9zZ2bhv2xG/uaF++aSFMzsPCPIUPBxZXvaaY+27sDN7MbD1jQMUWFrxL7y
         yhTyPhRdwUGEIcJEQUw9doW1KSuGrDNmeirYf0HSI4lk3+qm4eqYGyHuex0POlEid0u/
         DXKieLierfMf5YBvHfbwRUj2nGzg4bbCxhKf0bSIfw4tUAXW4R6zoBM9H3gyiNheyL0N
         2eLyrdDRlhVoTkkmWVG/iB6q0wtQqziw6QWshPEu1zhykL1kZLQ3m3Mr2sHY986GhqeC
         5RWnThBAgyX0PlvOBfN8ANmmv2HruiH41s9EpfSayBvYx8r3FaQDyeKXGHUSFh70B76D
         IinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772806498; x=1773411298;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NISYn57yyhbbEcnymbjxM36eO+6vW1n4rTvLIpbJjOc=;
        b=mHBtl/fSinXzr/72VoNqiRkaFUbgOxjJzK2sKS1/Zh2W0EjEZleDJrGPmQ6OUSIuYx
         3KD0F2K3HO/oPChH5k5pfaeVakPv2jteNHu1YtLMb6zPhpeHJS79T4oRWH+BRhq6Tc0c
         5HfAh3BAHlKrzne4q/Zm63Gqq3eejstIBqMR9PUmn9L+sw/RXF5HCHuhB+RneazsB0G2
         hBvTJ1zrZnwhB7gX04gPI7mUrDxQWJosvO6srPQX6PnLNdv7lbQSCbsvf7gY6pL5hWST
         8vWKLoWE4/tJEulJ+kNWdgY0Mhf+Ed3bMQXSYP9nV4JBt+NcxOR5Z/wT1gSb+T39TWkZ
         hrjg==
X-Forwarded-Encrypted: i=1; AJvYcCXX2c7LzViEpWuvxXzaMl7duSs37kIBtu61+6QOAyLT9iycfT43wh+opA92PN9Bd1RfK8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3LRR6ZH4lQTRUIjEo6wGQ5ga+UkRyVcN1F6V95V6c4icWkq8
	kyVdcy1oK3t3JicVR16Xxn6/RX8bDGuY3ikqi6dIE3yGxBfkDQl0snxkc42lfgA8EsYFhComzHc
	0WwAmMdJAh2WUO75xeyVhVaq7JEI5b+M=
X-Gm-Gg: ATEYQzzsddFNOrz+54xCahvPmM7OVWohKsXJWffYyvtchSIlhEKiX9CMSc77Ziut7Ua
	3tC2zFQMIfE3t7XvYviT1dF0wizfbE211K8ad5pXxvrQLzVnbwbs8OQBkp1xbonjYsqxF2VFEfn
	hCH/BzcQFKCIKgt0IYjV3evA4jgtNkOQqkSW6svapqKO9qOEaMG/qW02uIX623KGxiW0sM4cZNS
	L53Bbacs1leNQCq5I0HNmouHb4i21jK4dsUooS2AND8oboQmR5fbqfUVZKZ6ee0kgpgO5GWozIH
	ZxbBIej2hnh1+dl3uNr6UdoS0oqRiOgqCqEsWbo44FUFB8GTbFnYAYEOYhJvwTatsdrID7V817z
	Oy8qh/Vbufd4VfwUJ8Wisik31
X-Received: by 2002:a17:906:f588:b0:b93:86d4:c8f3 with SMTP id
 a640c23a62f3a-b942e174844mr116268566b.59.1772806497705; Fri, 06 Mar 2026
 06:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
 <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net> <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
 <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net> <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>
 <20260306043821.GA3465674@coredump.intra.peff.net>
In-Reply-To: <20260306043821.GA3465674@coredump.intra.peff.net>
From: Ivan Ivanov <qmastery16@gmail.com>
Date: Fri, 6 Mar 2026 17:14:45 +0300
X-Gm-Features: AaiRm51Na3QRUZ-JI47Ims-uSVjJfmaftikOOHHec4ep9mW8iGRsRdDXmV34za0
Message-ID: <CAAaskFD7wmtqppatb5T5GMTviieR0Ttk9y4+c3khuF3bZBfE=g@mail.gmail.com>
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
To: Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Friends, thank you so much for your kind help! Indeed: it turned out
that if /dev/shm is mounted with noexec then "--root=/dev/shm" is
failing. If you would like to ensure that the git tests are succeeding
regardless of what are the mount flags on some system or what some
distro's packagers are doing (more portability), maybe it is possible
to modify the git test system - to make it so that "askpass" always
gets launched from a native original directory, instead of being
copied to some "root" place where it could fail?

By the way I have completed a git packaging build: just these 12
mentioned tests are failing, everything else is fine. So for me atm
the possible workarounds are either GIT_SKIP_TESTS='t0300 t0301 t0302
t5003 t5411 t5540 t5541 t5550 t5551 t5559 t5563 t5564', or "mkdir -p
/tmp/git-test" then GIT_TEST_OPTS="--root=/tmp/git-test --verbose-log"
instead of a /dev/shm/git-test
