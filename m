Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CF42A7B0
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788229; cv=none; b=mdjQoClKnf87ST4TWbARZsmFUULXguqpKz/3lQp5KRVhxcN0aivKN2Ix0shsptyR3q024R2F+ScquIZVgDmCvhD0g6yu8hyKMN2NxWeLvSO0BWRRM0QOsWCzNMdEHyHojD/emWNmATjkwjg6y0i7vIQBtPTcl+N6t4TbKein5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788229; c=relaxed/simple;
	bh=GdgPmxuvEidHrijSe4m7GqZuGdpUnKmnePqPV1oAp54=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=R+auceWrN3BtxPaohMKbuieYsiAjq6f0zq7sai9s3AAVdMFYR7hZdlZFrGu+SbzQi1iGG0xa2wC2GTAdfJRYnDl+6HOsmQ9FEz7LD3EV/uW7iBLGCFXJMh8LKoUnmH2DfRINEM8uXZtzx1N1yCbAikkXC+YOM7fyuRWKGh2alfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFZd8WOO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFZd8WOO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so29924605e9.3
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788788226; x=1789393026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MitenmP1V75dVdVrBl5b+aHGovf6x4K5jXuFZvV0xVE=;
        b=IFZd8WOOyV21wWwj6HuURzRk8y2kWidYvP7J6lR7xiPIpFu9MSXKtEj8o214Jfc5N0
         oDY/zqTt+Oh5iBoob0QcVeUdGbv0ylMgR5hI/ALV49STeuTGTjECd+gmaMuuRagIB658
         jkpkiSPt7IywCnNmkivOdXHBizzrwSmN9RU+G3sSjMKNhEPljhCeGXiI2JdPFnxQDNWp
         ro7RSU1lLSTR7byB7CIn9PTNEfN3J0vTfoqfYaALHT/rny84OuOyI0txcWIJkQP8MnSV
         MzkSIO/BYNSpD9osPU0XojNe3O9k14n9UXVBUG1Cg9FBj5RIHaICju55zYi9xzGfN4C2
         wj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788226; x=1789393026;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MitenmP1V75dVdVrBl5b+aHGovf6x4K5jXuFZvV0xVE=;
        b=C78NPXovZL0Zf/OWwp3ZqPjfcWlBWgM5ntQQSoxsUvRxSmNC/8GV2bT/WmVp0kRx9N
         F0mQDsak64lp6GfnMJtQhO8+PRqA/cmHi+bz+YK8tRqovTszxQV2Ro9p1xsrCukZxW8e
         2hG8YA0tUfl3xJ60Rs4G6+y8aICtkH3bnc9HqpQBmRtmyGlywzxS2pdPkYTHrqSrRkKc
         zIEPlcL3I2r4RmWcggtiZqRkjCAc9hwb5s/Y8ntZE5EY6gS9o3jr3Tbzm/sd1unIIwvz
         Gr9z/thX39c2cTTtUBUPf+Z9uyZT7h0kqGACT3ZpUV7gSCb23r9wVayOuyNxhj0brTU7
         1lfw==
X-Forwarded-Encrypted: i=1; AKwUvBwHFUsGB9IyvWKRXRuwoGQBiT4UP+Nd/g75Ksjaxmotf7zceVKj3654Y1DmzK7qFBlUy6Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kbSBnGmt8YAJjEDQdbgDh6jCctlfTKq4mmsgFFW1aGiz2Zp4lJ
	lLj7BsTdpftAlnbVuFcv7Og0fZcJv005YOgT3OkALD++3yFwigliN1trgliW0w==
X-Gm-Gg: AYBFou0lqBPoEMa8WW5G4MPlwvNmM3lEd6Fgp7i6JxpaO3GccRTkUMe4116zvnXDHMU
	cO2rdHrRR9GX91OXRRgcc1YtlN/bYj3VJ6TQJEUVhY7FxlC9zv3hk1kpK8CrDuJO0Qz5YqdRiTe
	bhWqgVyQPhjYDYELGyw/3xsCyl8mstYQxygRfy9r4lJOkDueajHw6dWhoobNqjz+ZKH/6XD3iKy
	FfFq7Ry/ADVdHnvkY0zN3AGPoUcC2pvYVw4cEsLpP8yEQZJ6eSHUvAGOtz6NTwD/uit3a3BvKhR
	GnhucusgwnaIDoFgjlA9ovbZhK17J1tgSPzhqc2blHP/4e8NZwbiNabPgYtqO6XKX0K+SNaFw0H
	6wbtFTKEKLs7wGlf8cgqvbPu+PCRZcHlH4L003Cg+wA/zz5xf7v53hwxXegBaHhICNgPEZOU8Wi
	CzbaYB+8kjVQHoIFR7zvl2qtIE5/OeNVB2Rc3O7p12XEpHfT7WQLn/kG6ogK5kLQHfsG0OKSATk
	o3UBwUljS1Pr+Sd1b4f5FCIDzogdolxx5A0ZBmemAaMmVoc8O90dg==
X-Received: by 2002:a05:600c:4687:b0:49c:ff8a:44cd with SMTP id 5b1f17b1804b1-49cff8a4cfbmr180248765e9.12.1788788225442;
        Mon, 07 Sep 2026 06:37:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5952560sm368206255e9.3.2026.09.07.06.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:37:04 -0700 (PDT)
Message-ID: <9fb6317d-ce64-4f53-bce2-81cb2dc12056@gmail.com>
Date: Mon, 7 Sep 2026 14:37:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in breaking
 changes mode
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-7-sandals@crustytoothpaste.net>
 <d6940aa6-9336-481b-8ee5-5e3d9f3d3a50@gmail.com>
 <ao4K44RP66mjnpd7@fruit.crustytoothpaste.net>
Content-Language: en-US
In-Reply-To: <ao4K44RP66mjnpd7@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

Thanks for the examples, sorry it has taken so long for me to respond

On 25/08/2026 22:36, brian m. carlson wrote:
> On 2026-08-25 at 09:04:36, Phillip Wood wrote:
>> Hi brian
>>
>> On 30/07/2026 00:32, brian m. carlson wrote:
>>> Git has historically allowed either lowercase or uppercase hex for
>>> object IDs, but it has always emitted only lowercase.  This has caused
>>> people to expect only lowercase and not handle uppercase.
>>>
>>> As an example, Git's own example hooks look for "[0-9a-f]" in several
>>> places, but there are many other Git-adjacent pieces of software,
>>> including Gitolite, which make the assumption that object IDs are always
>>> lowercase.  This is not to criticize the authors of these projects, but
>>> rather to point out how common this assumption is.  In fact, it's so
>>> common that we have only one test in our codebase that fails when we
>>> reject uppercase object IDs.
>>>
>>> More critically, it leads people to make security-based assumptions that
>>> an object ID either does not contain uppercase characters or that an
>>> object ID can be expressed uniquely in hex form, neither of which are
>>> currently true.  Git itself normally uses binary object IDs, which
>>> avoids many of these problems, but most other projects deal primarily in
>>> hex object IDs, so they are more affected.
>>
>> Can you say a bit more about the security problems please - I'm trying to
>> understand why ABCDEF is a security risk when abcdef^0 isn't.
> 
> There's two cases I've seen.  The first is that people assume an object
> ID is unique in hex form.  So if we have some policy to enforce, say,
> that we can't allow certain objects, people will check against the
> lowercase version when they may get the uppercase version somewhere
> (say, user input or a specially crafted protocol message), which
> bypasses the check.

I'm a bit unclear how upper case hex can defeat that policy but ref 
names dont. If the input is not being checked to ensure it is a hex 
object id wont a ref pointing to a commit we're trying to restrict 
access to also defeat the check?

> The other case is where we try to distinguish between an object ID and a
> ref, branch, or tag.  If our regexp has `[0-9a-f]{40}` or `[0-9a-f]{64}`
> and we assume that if it matches it's an object ID and if it's not it's
> a ref, that's not correct here.  We'd need to match the uppercase
> version as well, but experience shows that people overwhelmingly do not
> do that.

That makes more sense to me. It also makes me wonder if we should forbid 
refnames where the last component looks like an object id.

Thanks

Phillip

