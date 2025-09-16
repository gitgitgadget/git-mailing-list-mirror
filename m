Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB4299A8F
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015375; cv=none; b=SuaUNBoseCTmXDyJvvES523hSnlPj7+iDWXoA0ddWmqFHozcJIZdGdq3CPWfEZbCe5ymUxzDaVIaqcQtx81EjMlMik7zVVrt/hrUdJ379EhG7QnduVT1mZyVe42kHjiMPbMg3ylMZ2cl+O9/pWMumgL/rz6ZgoHMfHtMybPfXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015375; c=relaxed/simple;
	bh=1UgIRox4/ma6XuB7XADYb7BChOldpy/YQM0bn0roB0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TE7WjLMwikqhAyEKRwaTvZeE7Tqz4LbWu7um3CrNm1UOSIwLQz+h7dQSX4SG6AwqtUQYqN+X8s9c4r9U7K5bPoIBT2hzvdaC7kr0mrso+FcCwlT9r2BBLG4UkUYxLqHFxPowllTOizKghRduzEY9T8HWZwjFDHudW0GHrybnb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4uLUiZC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4uLUiZC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so36881295e9.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015372; x=1758620172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p+2pASg8H1Kxej2F8ZKZfLGFwRvGDzcftacpztYrhb0=;
        b=C4uLUiZCR2M5+AjWoh+rLu7y4T4gsSVKeno9H0Yi+W5DuDjlyg+Ro9FEAn9NOrldel
         98wHAS7fhQO+PFeZ/4Ox1bRklCnX6dC1LVgulg4jzD2C1X5axGjww/couStgXuJi4nGq
         Di186I3e4pI8DgBI14zXmJ5imu1V9nSSolBrXjIs3e+BOwqeNnCh9XnfloVubu7ihAmW
         LkFGgaA0uTwoUUhpmZt7OKDr09gnzH2Mqmh9Q+Wt4Fb/+gqmAItmcLZz5Ri65DkFe4Uv
         IhtrFUDA7UEd9OE6aAOEDZ4d1IIQ+p5CBNojxwzPGp654QfrWMdv4pwGPbToLtbfXBNI
         0wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015372; x=1758620172;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+2pASg8H1Kxej2F8ZKZfLGFwRvGDzcftacpztYrhb0=;
        b=emMHTGjsGd7zoKrYcAMdtP/+39AksXi6uwuKNKN5Dp9myKaAc8HtE9GBabBdmiYUXp
         jbGZC9PcbZb9DYQGo1jK/RAD5ykFVmdqRNhh+xb+7M6i6NdopobFTRRs6nKth2d3NpEg
         WuPGb95af73P/Aj65jeK2CnXAdg08azJkFzyicqUDfwDiyUojv7UMpgtQuW18yLCx+wW
         bi8FrnkwZlwnVwXboyR+jX0CvMECS772My4jrOfNAmcVUC2QJ3Yl1B8o1cOQlxKP5d9t
         rNcr9OmwK/vQwjyN65cYqXdg8AASQ/hm3Z0y9UhQSe3zbBWlxdoDDfsDuahWAyUIcNg7
         W23g==
X-Gm-Message-State: AOJu0YwSR3bOiFVN08GGlC2EcyGgCOMzrr8xmT4TfY67dYxXsamqHkOw
	bbKgpnrojTSwLwpw5kHja3RFD3a5TIV0cj1f/JkP59xW2QmZakvlUCCK+bq4DA==
X-Gm-Gg: ASbGnctnDYFQCH/IjQZRz5chwTXcguQ7gEzaBNcf1pRM2RbtzzoXUrGdEzp83FKjBy6
	Bf83VtR43DgllXGA/1+USTK7rtHm11QP+gZTJKt7BcBlHwrdnP1LusC3QP18HCOJY/HFqanjBZP
	wHjzpK+2ifr8ntkxQb0CbUa6JAIWfkknCfQyezRYZN+3HXXEgG2GRDQ1I/3nkeuL2YTfjIKAHWd
	kNFoBnH51bz8G66LTLCGFngnf6Q1yPibMR4VEudBLiFADUycLeF+xeG9lYuihaMkZC3tsdkW4n8
	uuRqMGM3q2eVNtEPgKNYKVJ5o3IiYrxTHKJ2RyKBJ/QgROrMH9yrp8wW28PX+4wAOgXKfUyxAzl
	L+GmB3bPm2lZHY6VKmIQ/0uRe27QNQCkYh+21b6EuRqMb7ZlnojkLelYUYPz1Lkkc0zcL5M+Ns/
	0=
X-Google-Smtp-Source: AGHT+IHuUDPiFDRQ5H1j1iUPOnbMz5FPvqXqTIuU8beAw6FfDtLURGZQ47HArGHD6xNwdxAhMO/t1g==
X-Received: by 2002:a05:600c:314e:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45f2121ab89mr158181495e9.24.1758015371641;
        Tue, 16 Sep 2025 02:36:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e84de17f9bsm14384387f8f.49.2025.09.16.02.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 02:36:10 -0700 (PDT)
Message-ID: <cc2a8fa7-be27-48a6-8699-c500d894404b@gmail.com>
Date: Tue, 16 Sep 2025 10:36:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] add -p: mark split hunks as undecided
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
 <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
 <3e2ec7b37f1935c5b091fc4b47b6209beb384d3a.1757950144.git.gitgitgadget@gmail.com>
 <xmqqbjnbhapy.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqbjnbhapy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 15/09/2025 18:44, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When a hunk is split, each of the new hunks inherits whether it is
>> selected or not from the original hunk. If a selected hunk is split
>> all of the new hunks are marked as "selected" and the user is only
>> prompted with the first of the split hunks. The user is not asked
>> whether or not they wish to select the rest of the new hunks. This
>> means that if they wish to deselect any of the new hunks apart from
>> the first one they have to navigate back to the hunk they want to
>> deselect before they can deselect it. This is unfortunate as the user
>> is presumably splitting the original hunk because they only want to
>> select some sub-set of it.
>>
>> Instead mark all the new hunks as "undecided" so that the user is
>> prompted whether they wish to select each one in turn. In the case
>> where the user only wants to change the selection of the first of
>> the split hunks they will now have to do more work re-selecting the
>> remaining split hunks. However, changing the selection of any of the
>> other newly created hunks is now much simpler as the user no-longer has
>> to navigate back to them in order to change their selected state.
> 
> That is great, but ...
> 
>> Due
>> to concerns that users may be relying on the current behaviour [1]
>> this change is guarded by WITH_BREAKING_CHANGES.
> 
> ... this does not really sound like a good candidate for "before
> version X we used to do this, but after X we no longer do so".
> 
> Unless it is a mere bugfix, in which case such a change does not
> deserve a huge-version-bump switchover like this.

To me, the current behavior is strange enough to be considered a bug but 
when we discussed this before you were not so sure and said [1]

     Given our user base has grown quite a bit over the years, it
     almost is a given that any change to existing behaviour is a
     regression to somebody.  Certainly a safe material for Git 3.0
     but I do not know if it is safe enough for 2.50 for example.
     The strategy to leave it longer in 'next' did not work well
     to catch potential issues for another topic during this cycle,
     but we could try it out again.

So I re-rolled using WITH_BREAKING_CHANGES. If you're happy just to 
change the behavior unconditionally I can go back to V1

> On the other hand, assuming it is not a bugfix but introducing a
> different behaviour, where both the original and the new ones are
> useful depending on the situation, wouldn't it be better to give
> users choices at runtime instead, with a configuration variable at
> least, but possibly with a interactive command to choose which
> behaviour is used on demand?

I'm not really convinced the current behavior is that useful and it is 
such an esoteric use of 'add -p' that I'm not sure it makes sense to add 
a config setting for it.

Thanks

Phillip

[1] https://lore.kernel.org/git/xmqqjz9b6xr1.fsf@gitster.g/

