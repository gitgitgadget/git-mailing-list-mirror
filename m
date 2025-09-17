Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CBD34BA3C
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134130; cv=none; b=KM80n+xq6uMQ94jSLi2GcmvNSGV+y0jO/BTK7isJcOsFbIId+t/kfhkRUywqnmoMvrL9iwbdHVPUuErPiNfyFytUz53m5bbkWBBmdlY154WevlFjXx/+o3lvDSogyE2SI+xwhSXoJv6UcDT629O3VM6SY5thXRn8ZzygGGJJY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134130; c=relaxed/simple;
	bh=ipd9i0S3zabWcJDrnOc6fh8nd6PsQTrTd2lp89lsCrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scrHUGVAFpH5D427PBbWtb+T+qmj9J3pLnlsHhsAh9xij2h8/JEBi9EOoOk4J00SLBsuD7P93vR9pEfiykjtMdwRQ7QbHrF/n8GQE7bpnlLBOEZYGA7qOUAvCQQgUFXKAq6LxLiQPv61V462TNOdb3kJ+Ds2DgZASlZMxWQwE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=D7/BDY9t; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="D7/BDY9t"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id ywwuuatnwuTGqywwvu51nO; Wed, 17 Sep 2025 19:32:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758133937; bh=XYizE6Kw3GFKQ7Gjmd0Gq5hk/mhvPZ8vYumZ69NEuK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D7/BDY9tg16E9lBfkYkOhGwOS9i71Xv4r+5a4sxr68wWzIAovvhjvkTMON10wSS43
	 p+aAansCTLWycVB2MWRRHy3uBfX8wcKUrUVgEAxwnq++Q1S+u/vHQuh34jXke7p54s
	 I+LmGAojAnxEpvTX9q5RZVggeDWgZg+P2QpJ/V5D2KeEcpAf64X0z/dbhK45rUmau2
	 N5mmK6IAjYXWwAbipFSkl0C4jE+jHw5LqsuSap9YKnpVIIKtI8iIGY+gNAqVr7Psp6
	 0tio5Tr31ZkduEHaQvD+WNleFbbk8MEh4zARwsV54smUkbH5gM2heSIQsEyYovWuRX
	 0pk9d2sGbjrlA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=A8/PPLWG c=1 sm=1 tr=0 ts=68cafeb1
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=LRWT3Zq2-oL8y0yVgfUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <20044de2-3a72-4888-a380-fa35e5a224c4@ramsayjones.plus.com>
Date: Wed, 17 Sep 2025 19:32:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Introduce Rust and announce that it will become
 mandatory
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <CAH=ZcbB0Qv=b-hdB2EVW-D-dob4NnzyWDYGEThYZm94S0V7OGg@mail.gmail.com>
 <1feb8bd5-ef47-4cf4-b306-e38c5edac601@ramsayjones.plus.com>
 <CAH=ZcbA47pzMu9VsrTC2Ni9_RN6iPKmaaDNNxSvx1dtroza+Mg@mail.gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <CAH=ZcbA47pzMu9VsrTC2Ni9_RN6iPKmaaDNNxSvx1dtroza+Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK6JqyZ0p0nQdVKJIvZTNfYEJ1Qb6RCUN03V+XIH+LjtfqH8zUT02gGEuT7zCPATcSTICgedx4Gx1s3s1hyPeHpAFwuxYimqfaSFlxfz0XCNCmP3bj1o
 NKR33PL9nP0bMY0akQosTcJvcRayi9QlMXr+ZJOfjCm5eNr5/R4lB8FHLDx5CzVAjp4jbWB4Na2ehHBF+E9B+qBpqI22xxg8kb4=



On 17/09/2025 00:38, Ezekiel Newren wrote:
> On Tue, Sep 16, 2025 at 5:05 PM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> I meant to mention during the initial 'xdiff series' that running
>> the build_rust.sh script failed for me on Linux Mint 22.2, because:
>>
>>   $ rustc --version
>>   rustc 1.75.0 (82e1608df 2023-12-21) (built from a source tarball)
>>   $ cargo --version
>>   cargo 1.75.0
>>   $ rustup --version
>>   Command 'rustup' not found, but can be installed with:
>>   sudo apt install rustup
>>   $
>>
>> [if you try to install rustup, it offers to remove rustc and cargo!]
> 
> The parts of my CI code that use rustup should not be interpreted as
> the right or wrong way to acquire rustc + cargo. So long as the
> distribution you're using has an appropriate rustc and cargo version
> then it doesn't matter. The reason why I used rustup in the github
> workflows is because rustup makes it easy to install different
> toolchains. rustc and cargo are released in lockstep so it's confusing
> when they're not both part of the same package in a distro.

Ah, sorry, I was not very clear. The 'build_rust.sh' script unconditionally
uses the rustup command, assuming that every developer has it installed, but
not all devs _will_ have it installed (relying on their distro's packages for
rustc and cargo).

If memory serves (and it may not), rustup was only used to determine if the
current platform was windows (so that it could set the library file extension
to '*.a' or '*.lib'). It should not be too difficult to find some other means
to determine that. (famous last words!)

> 
>> Also:
>>
>>   $ cbindgen --version
>>   Command 'cbindgen' not found, but can be installed with:
>>   sudo apt install cbindgen
>>   $
>>
>> [I haven't tried installing cbindgen, so I don't know if it would uninstall
>> rustc and cargo :) ]
> 
> Again this is confusing because cbindgen is a crate that can be
> installed via 'cargo install cbindgen` and then run as `cbindgen`. I
> think it would be worthwhile to go over some Rust terminology:

So, is the (I guess debian) cbindgen package an executable or a crate?
(can you execute a crate?). BTW the package version is 0.26.0-3.


ATB,
Ramsay Jones


