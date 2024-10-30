Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94142199FB1
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320580; cv=none; b=MH+nLFlK5Uo4ZhlAv6zJltvHhUbx3lwJv7fU/1/Eco5pFrSt+UpqXkyZqBHJ0ywz9PsW4IeAa2hbxNj9VKDIClY/QBt1YiR+RwwvuNSyaXE1mOGlUD77l3fdGbCHXuf5B9Y5N40VD+2o5XYPVzP1Dp9M0iSuaADXKQyLSvKn2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320580; c=relaxed/simple;
	bh=DT4MA3L6wW4j3d+05ZtBWY+rz5GrgmzIP/nWTsavIDo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/nB6DVnOBF620y45ocXaEpt+Ayb5p/thfevyEW0nsbz8+KOi3VhrgL+CHQwTy/11BzEl2JT8/VZpN4MdIDcB0noLN96QfPzLqh4gFtybvOC5+MCzs+3zegOQ1JO8jQQDWbjfRJaPyga80TvsYqU9qTYm6N7WGRDvYMoYlS/lr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ya1Sn1FM; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ya1Sn1FM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730320569; x=1730579769;
	bh=DT4MA3L6wW4j3d+05ZtBWY+rz5GrgmzIP/nWTsavIDo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ya1Sn1FMC31+ZJzpBrLRXLUAQJEAWcKV5RQRgcIVURYeVjhjnl5po/6irTCa+mkyL
	 v5B4UP6+tBwcqzjo5ZeB8rwEaPTM/FsKbm9cw6AiSUn6cvQMCALJHT5D9OI1E8x3iU
	 9PYiSgYGaclxyy2Afm7ZqH8D4rWFxFOp1S1dGG47ZE4yWPT2B50pyfu61W0J651Vjd
	 15K178lbVddfFCka/7oKQCW5VUoq586EY8pxlsRPo6LnQAeEx5sMxz+8ZIlwWDKY4T
	 GLyWLuzaJlfsxsYXvAyrNOeq7ItkaQJqrmllREmoGCQbx+Q3dzGJ/rCb5KMTaa6ugQ
	 ONhv9WhOlgrnQ==
Date: Wed, 30 Oct 2024 20:36:03 +0000
To: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] worktree: add CLI/config options for relative path linking
Message-ID: <D59FG357FL61.909ECKSHV9MM@pm.me>
In-Reply-To: <0f91514a-f1cb-40da-a398-56d0fe37600e@gmail.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me> <0bea06b8-11d0-497f-88e1-153cb61eb06d@gmail.com> <D58W4HPIF8VX.2TWFTU2A2VSYY@pm.me> <ZyKUEbXedFuzY9Oz@nand.local> <D59F4X1I5COT.1QECM7J128ZIG@pm.me> <0f91514a-f1cb-40da-a398-56d0fe37600e@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 80b12f6f08101ce4ef5fa5a56cf8bdfddd2e2d83
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Oct 30, 2024 at 3:30 PM CDT, phillip.wood123 wrote:
> On 30/10/2024 20:21, Caleb White wrote:
>> If I created a getter/setter then the variable would no longer be
>> extern'd.
>>
>> To be clear, you're advocating that I change the function signature
>> for all of the functions listed above to include the new parameter? That
>> seems like a lot of parameter bloat
>
> It's a bit of a pain to have to change the function signatures and pass
> the parameter down but it's not difficult to do.
>
>> when I could just set the variable
>> in this compilation unit and access it directly in the
>> `write_worktree_linking_files()` function.
>
> The problem with that is that the variable is still effectively global.
> The aim of the libification work is to be able to work on more than one
> repository from a single process while respecting each repository's
> config settings.
>

I see your point. I'll make the changes you've suggested. Thanks for the
feedback.

Best,
Caleb

