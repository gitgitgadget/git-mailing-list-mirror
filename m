Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF385224F6
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413406; cv=none; b=EBSnhwEMrAIs0DXFTElauycmnjYkUnmfEqePoEiJASoJibgKFRuOw6n9QAMOe1O4R2xN04B3yUp656FuM81E1tElFhMhYguQmRrCZDSHTq6qmWV+co4j6VDO2m2Muk0nMYIVvB0RzuYUFo6/zicJdXcKh3bYTBQGkE9ZoZM5Wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413406; c=relaxed/simple;
	bh=1hoYKqgUtYriHz/5MSbZp+ZJC+yvuixgIeR+7aSdSJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NM3vwN9TiHBZ/aVdTZMTKknKCYT9O7A+jC0pbgdk8PE5QL8NtS+DetQnDYg1RSkCLzNXid7vL6dKYDNoThGMC8avFafBojKryYf5R8I08aVwJGVpQgdCwG7IX64r19PARdagkwc9CDpT2H7RqIeC3r90CziYqOprlZPYjS0JRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiijtRT2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiijtRT2"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7387d4a336so2110810276.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747413404; x=1748018204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLlJxEjyNk5FK3pOmWcwjdXyclj2pWnedRzAkSnCph8=;
        b=TiijtRT2xdWGAnPYLWHlez/BzYe6SDF59X2xaL/Ck4ZJo/Fb4/qYTUl09ceOC9k3WH
         DhEu/v9mPDXar9yIEb8gRplbHyjnpT4rPW2ReVb8LoUEwFt1kWDSL/L4nmd7WEFgBA1o
         nzXyjwCB3UVqFw56ZClxzDPLkPdps59Z6zoTPpkbsIFnj9gcQrSO3H4O5CEKS81tAWiV
         klhZFg5QGJVX+PBCJNa/oSReyPnMkM9UJua7FoFx/ViPTFu1hpjyQftYl0vVljYOuMWa
         iOglagngv/eqAV22AmxH2DhxZST2t8vHsrdlMsHrxSqXkCsDkry2ZdMxRCmOEovLN7kl
         FG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747413404; x=1748018204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLlJxEjyNk5FK3pOmWcwjdXyclj2pWnedRzAkSnCph8=;
        b=SGmPg8aPArdqEHfrXYT2rj1UgLy6RwEPfwjhIMHarI5PpD6wT6v/Iv/+StZyNN5IHx
         Qo8ZI0SgwpikG4I6KuJbHmYGc6QwgPdav6mcSRbglcWIznb3F8cZs424SVOA702CcMOG
         zHDyG8KcGYcaBCpNeXMH89tvZ9I9N25diKZAIzb2nClRrc2dXJxa1E8gVDIGXkV2fRGU
         xVekQwotGG0T2fJFX2FUVIlke7EYj/LuMWlbxgXepz3wZ5GICuCIMXmAjfcoVdA829zN
         7/I8FixYylJFY9b9fVxAX/bgxmLRtViANcT7PoM20dsGyu7qNGny1VVZbn6cHY1yavUE
         O2iA==
X-Forwarded-Encrypted: i=1; AJvYcCVVkZojBd4ETeA7Kk0uFk+t7jgiXh1KFJepzLWBaBOQQctC5AS9fTQTOF5ropj/0MYL01A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/L1wNHMGDhMDbTzLf8eJdvC23DeBQPpUh4w7uARO5fmhEw0N
	7b46WdFtBJwLkO2qg4gQIhB6ZoGBWBBrfO2713Eds5pVKTSfKLsWHM2u
X-Gm-Gg: ASbGncsYehUOGfAjm6NEsrO7XbRhVg23m88Xk4/GPZhFqQgfRgEcU2nFP0wiFbERBKi
	qDMg/o8njoLw1kJJRSs7yu+HtfbR/pB5Z1LRLgNUe9ertPqq6ylVVI0nzdCkTsayjmGWgzpaWnX
	ETGAq5GoxdgcZlYvD11UphU3aYkEir4GmA5N0f3cYXFBjrf5E+LcDh4mKQENR6z7PDfZI/j8Nyd
	PpGenAC3jtosZh/sLXOuYD25P+NGwBKR8tgUyBfsc1Ujk4oJAPoYKwDJpWfAfBe6HezzfOt4jiY
	VUt5/iv18aPTUHxTb7u2qU6fzIyFcgSsA9aOSAIXIfQo+OPryniBJB87BEHhTCuoq4zKxO1LIaX
	ia3qiw8Tz/cJbm3ogou9CNy0NPX89Yv1RZYZR47k=
X-Google-Smtp-Source: AGHT+IELKOXozah671jRSmn02/TJZkwjnZYkKDmXxqTVA1aKT97vzBdshlhEcRBGA6WSet7nFiOTmA==
X-Received: by 2002:a05:6902:1a45:b0:e73:19b7:f1a3 with SMTP id 3f1490d57ef6-e7b6d3bbc0bmr4681594276.6.1747413403595;
        Fri, 16 May 2025 09:36:43 -0700 (PDT)
Received: from [192.168.1.237] (70-237-88-18.lightspeed.rlghnc.sbcglobal.net. [70.237.88.18])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6acb0afcsm654598276.27.2025.05.16.09.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 09:36:43 -0700 (PDT)
Message-ID: <93a96453-88b6-461d-a50e-d88ef87784c8@gmail.com>
Date: Fri, 16 May 2025 12:36:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/4] scalar reconfigure: improve --maintenance docs
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, johannes.schindelin@gmx.de,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
 <pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
 <7534cfc7-751c-488c-9a98-6f422e5d0a81@gmail.com> <xmqqikm27s9o.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqikm27s9o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/2025 6:16 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Adding this extra patch on top to improve the docs. I could resend
>> as a full v4 if needed.
> 
> Nah, the other four patches have been beaten to death, I think.
> Please double check the result when I push it out later today, as
> I've got the following when running "git am".
> 
>     warning: Patch sent with format=flowed; space at the end of lines might be lost.
>     Applying: scalar reconfigure: improve --maintenance docs

Thank you for fixing up this whitespace issue.

I'm happy with your copy of ds/scalar-no-maintenance.

Thanks,
-Stolee

