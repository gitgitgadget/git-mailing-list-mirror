Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8026056A
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958334; cv=none; b=L2kNTKaRjV2zsWiqi2n2nSYBafaugtdakwf0fMPCxoSnzekWxw9q1KCOIL2zm5a2Gi5EmRtBoYF9aL5v6tSikRE5hZ7j1TD1pu32kp+CwLbsChSUFDu//spydLYBKoDiCDMkaB8PQdPklp8y/bdq6Mc98FiT4K1QjC4OJ36wLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958334; c=relaxed/simple;
	bh=NGneyTXCyN4cbDZaXA5JFIzRu7Hbe+zrisV4Xk3sKhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaNL8N7dH3gww3xKCgsJb3d63RE1NmDu5n9AQqckcGVydTVzkZENxNXqyn2KhqA50oqbb5bXUn9n5uFMJ9AbS8Uxy5wpnpK3vvsrKYtTJMrBVa0jAtfXSSW5I4538bUWDKcLeOe+m1Ji8oye2/xHsB/WxYueadUPHCtQNbXCoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7ICoLps; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7ICoLps"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2681660d604so3457105ad.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759958332; x=1760563132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BnHGozBHQh9z4K4NmeL0QTNzkhpB4a1fkDDECjLOcA=;
        b=M7ICoLpsu7YppdK51N9UQ3NyvMWlf1mEf8nG3Zk65U+8I5DXhojbXwRa+JtHG9DS9A
         T3hIW6gpwCNShu1CAvBgKJsAXotv+1rdS+mmm6AKXBfjutrFLCEgoI6orULj3A7sV4yJ
         NncuU+dR9Aq8Fz8hAqDplAke+Uz1q5vQO6/6bLWRs2zVmRqivnfOnDao09+iwPp7dNqI
         pAp+ysB0AHUru9YLdmrBQ6JjRRY3AJuWQzxJQVRlUQcBqCq3teZ6Nl1ME8VqPTkPvU1Z
         bjYS5MvL+OX4YY2FGzWzqI1hTYyO1rqrY+w7nzBueYSG7NCibGBT3Kjvl6hLtOYWeH9c
         dipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958332; x=1760563132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BnHGozBHQh9z4K4NmeL0QTNzkhpB4a1fkDDECjLOcA=;
        b=UyCgEd89smjF7PrhEsSCyO/3HxGfcWzzM9qE8AsTLlONaFGnJvM6kFnOADL90ogRle
         p7m21BR1oPfKpT8p/6fdNzyBr8B48fHSJ0FUEwG1qXA8ZDSFwyywGS7b0FefmsKhitJX
         abiNIm6rku0345oo2RAj+ORu1AhW6alnkcirkF6CmJD5lTr5gQbjAdyXSl4vQqccakGt
         6fjd4NNU0rawO/Y7DYyix1YsPQXS5rrwgOdVStjbEzG4ff/LN0hVdUZr5mevyzgDADpY
         bH4iepR3d9PnlZpMRF9+yiLPydEwzv87YgNR5bdt2VN9VNa+YJrn2yJrSXVgVpkuE1Ek
         vE0g==
X-Forwarded-Encrypted: i=1; AJvYcCWvgi9TbCE4WNI36cgi29DD0IU0eCd1t70TffGW/YHAZeBiOQm2b45gXooENfmDpTiicCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLP6/VF0x8Tz7n5647FwudGZuQaqbGiW3MWirQ9VY4E0Fn2lrQ
	ebZdIfiPB5Dx0AQAEzBM6pc0Oidmo5GBx1VkQmdJbnVVmkS3s3FqNroA
X-Gm-Gg: ASbGncstX7ceV/mNAnMldv/mPk0h5vlxyGc7JwHs9kF4sWqKg9bR3PPgHaTsx4mnIQa
	Xy+DyHmU17tnTJ8awNcBPF+nzZJk1tlUcMCzGtQw0C8v0f9j3Uwlav4aiqwKeEOn7KAStGMmn4O
	ezVko4Nu6VNOPdwNBMWBOlVc7xRHbMV/tCMJC2UFv5B0gCIcaZZJuO87zl9OwG805mhF9oTbBtV
	FUekO8wV2Nt2SKnAEBSf2AbsSoxyuy+YIFN/LxhTECnuZpMjZidBh+l68jVLw1YjNoyiKtKHgn3
	ucquHCaGkaxrJBHSdJ80Q2aHjhNY62g2Ac23a4gP0D2qOTKM4Wv/DE6Tz0tqwWkce4pxEMT/zXj
	3f2dn+bC0JZawTTP1MKHMbu/VfkBlMVnEXD1PgoXowiR/r4w05X/ePyXIxpjlr99Bti+PJsLOwH
	O7aO474dGqeCQ1t0tQ5eUYs3vlbDZFKXDfGj7UU9Rb6kNyaVtGWceUB9N7rrVKCD2A/KFBBQAPy
	dkMb7m86IbRJwuj/mcKAQDhBtxJfW7wdw==
X-Google-Smtp-Source: AGHT+IHrQCa1JIOyoMr2+0oaljizOrwHjPTfrdLr5FbAUs8WiblMhXtZMZMxbVw8ZhhBxbrAqESY5Q==
X-Received: by 2002:a17:903:2c06:b0:27e:dc53:d239 with SMTP id d9443c01a7336-290272b547bmr58403755ad.35.1759958332217;
        Wed, 08 Oct 2025 14:18:52 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:dc83:454e:4cd8:e34b:b52a? ([2406:7400:56:dc83:454e:4cd8:e34b:b52a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20479sm6908855ad.47.2025.10.08.14.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 14:18:51 -0700 (PDT)
Message-ID: <c49fa739-9007-47f9-9914-9403937a47b4@gmail.com>
Date: Thu, 9 Oct 2025 02:48:46 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt
 <ps@pks.im>, Andrei Rybak <rybak.a.v@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <f0abdc27-6850-4b9d-b4eb-a1c92f731142@app.fastmail.com>
 <61107972-5755-49b9-a126-9442418ddff0@gmail.com>
 <6d19a0c4-f000-43f5-b2e1-f84f341063a9@app.fastmail.com>
 <38742a2f-5c5b-48f8-a9fd-acea47b7ce71@gmail.com>
 <CABPp-BFHiwTwNmk3DHSQsXocYYbcaQV8TfVs052v9xFE2NYjWA@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BFHiwTwNmk3DHSQsXocYYbcaQV8TfVs052v9xFE2NYjWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/10/25 02:26, Elijah Newren wrote:
> On Wed, Oct 8, 2025 at 1:02 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> On 04/10/25 00:35, Kristoffer Haugsbakk wrote:
>>> Good evening Siddharth
>>>
> [...]
>>> I have been using git-rebase(1) for a while with a post-rewrite script.
>>> This is used for interactive rebases but also just keeping up with
>>> upstream, i.e. a regular rebase.  Then I was idly thinking that
>>> git-replay(1) would be faster for the plain rebase case—but it doesn’t
>>> support that hook directly.  Okay, but I can get around that: I can
>>> parse the output, yank the commit OIDs, and run git-rev-list(1) on both
>>> of them to get the mapping I want.  But it would be really nice to just
>>> declare the correct post-rewrite format and be done, without having to
>>> parse anything. :)
>>
>> Ah, that's a concrete use case! You are using post-rewrite hooks with
>> rebase and want git replay to support that workflow without needing to
>> parse output.
>>
>> That makes sense for the client-side evolution of the command. Right now
>> the focus is server-side where hooks aren't typically needed, but as this
>> moves toward replacing interactive rebase, proper hook support (including
>> post-rewrite) will be essential.
>>
>> I think --format with atoms would work well for that - you could get
>> exactly the format post-rewrite expects without parsing. For now I'll keep
>> the simple update-ref format, but this is good motivation for adding
>> --format support when we tackle the client-side features.
>>
>> Thanks for the concrete example!
> Let's be *very* careful before we add any hooks to replay.
> pre-rebase, for example, forced the assumption of only one ref being
> involved.  The early implementation of rebase as a shell script on top
> of other commands forced assumptions that it played with pre-commit,
> post-commit, and post-checkout, and forces us today to continue to
> check out every intermediate commit to the working copy even when the
> rebase could otherwise be done entirely in-memory without touching the
> index or working copy.  post-rewrite seems more sane than most other
> hooks, but I still want to avoid painting ourselves into a corner, and
> hooks are very much about defined and established APIs through which
> we communicate to other processes, which means it's exactly the kind
> of thing that could paint us into a corner.  We'll probably want that
> kind of extensibility eventually, but it's way too early right now.


That's a really important point. I wasn't thinking about how hooks lock
in API decisions.

For this series, I will stay completely away from hooks. The --format
discussion with Kristoffer is interesting for future work, but you are
right that it's way too early. We need to understand the client-side use
cases much better before committing to any hook interfaces.

I will keep the focus narrow: just making ref updates the default with a
clean way to get the old behavior.

