Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794759436;
	b=cWGbVVjzssoqk2CyirqnsFeI2lwmcjNY9akULKM39qXdyZRoHPgvB8oLW1o85htXkrDS
	 XEiFaeTvzznyk8dTo0XUiKkU9dz3lgbEljLneevsYn7ICOOsz+JzNe6fwQYbOvctH9gLd
	 /844mh2JBptWpHYAo1EoHmE9D8HM0f4Hpbk4OIc2oLPEDel+5S2ToWdQ2ktlZYeG5cCa9
	 +0hIaZkgYn2pEieALn5rJg0ryCOAOaOBgVi5nEU9wtVVuhoFCVFcMhvr0b4Qkf8KgUcFO
	 VoCuc8BP6J4dAiFxmscxkQprCk76KSwP14/eY5HDfae19RgUVWmuYpxOroS/+su/z3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794759436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3UQP7TXmGMhJ1k6SqQklAUXwve0ajo0QxZ+biGnBWcA=;
	b=JvggNTGLjM8TNSa/GUksvPKf3Pnt8EZlh0S3F34Xkhh2Q1j/i/SnoNdR/lELXjg9sQCj
	 yog/NxjPeHYvc76g5pZetn40U7gwYnA9ZF7/NSQ5KE6QcsKJ/u4niZQGd4LpnQVNNA81a
	 4yys5IJqIejvQmivxrp57+RjbJVdHHQC0CvLjM3JywKi0k8vtwPjVFFcmibsmkXmt2q2/
	 syJH/iLLTt7bCbPoGEW077YrspNnus2LdrV9dFq6J7VpDZ3zvdU7B98K8mahJZI6l9tV/
	 +mC92r2yZj+9gySJNEIxKIbDEgMmZfITP/eJvTqZ9hct91UaDYy5moRuMCtk0ovwcJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVqsPXrf;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034B606A31D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 16:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E034B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YVqsPXrf
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49d64a88222so939379f8f.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 08:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794759434; x=1795364234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3UQP7TXmGMhJ1k6SqQklAUXwve0ajo0QxZ+biGnBWcA=;
        b=YVqsPXrfLY4HS3+cNDwVYYQX9kuB/tylAE29egtjMZZ8IGhUbI14YUopjELwXqFpmF
         aaMUInimI0380Qa35Fb34bipjzfEZp7Nn0JJuzdvh8TTx8Gh58QCo1dBckenRM5Wx0x4
         qKyP+jVcCGvo8ngksIUTHWVz3iyKch5IlXqaLMSauSOUvTIT1SaKujimHjFLgsoQ8Ykv
         7W8LKJVOYTuSXYg0kMrCHbuuGT2zmzLfpgVfQogI+HtnvkuZtBNVIL6L3kd2gSziEuW0
         NI2/GReyNGCGXzj416s/DRUk6YW32HgDzUlzXdFQYuw3YOui0z5MCjxZpXz83zz4GqqK
         GObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794759434; x=1795364234;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3UQP7TXmGMhJ1k6SqQklAUXwve0ajo0QxZ+biGnBWcA=;
        b=vCL/dcoLNaZKCLcC6g8KhboqvxE/rdVWDtt8fbvDFuyqbIuW4H8coYL5yHJCkxWwi9
         fKRA1EqYWHGcQJEgT4jQ4mE04hFSX0bIkcKtnuctl1kWmt8kJ6LSEgXaG4arCygjiIlC
         yCOmNOavHCTEYdnsYqF6Ys52H+ifGIXugrM3WZnJEfhfc2VHorel3WZl1OHqG/LEnl9w
         6Dc1rh5aB2Vb4X8OY6Lzpsnd3EQRJmPUSwO/i+ALginNve9TNCGbyyHXFyA5d7ag1qg1
         LukK9tSbw5xgvJZrDb+6DGXmAZDzXLCJruw90aJU6YdLjg66pRjbI9xw6WlbRUcvBRg6
         0TNQ==
X-Gm-Message-State: APuU4Z9lWB3xHXsyJc6vniAaO05lCMQDEB/2PXYzE66jiBoQHfqJk0k3
	7AfdSjwvnXpWD0vF06EqzP2uBfXS61LLJW/Xe+eYPuI9C8Xk4/JWbbid
X-Gm-Gg: AYBFou1k2/X114HPsDwtMMNBPGjVeTgjkcZkJh5o+y6lvtEAF6MCuyAquUKjHu+H6Xf
	uK9qkhASOgA01cRJthKuR0V0gwMQA19+0YMoUOInTkXFiz5fvX2esELsuQM5w0aog5CVZaKCKzE
	YDFlqnp92W6vaztL5dQOBUGANtCI3vjMDyq3yPHvm0SB900YBB6wO4QwmlPTvpn7fzGGL27FW+i
	ixp0JvUzmc2yIOB1O0Kffj2rI7JUYvt6xcM0h49IADAYscuxzut/Wv/cKsVQdevNrHcdAFb/0R+
	vx3ye/IWdbTPzWGG+1DTaHMins5GXuMuN9L0inzdMqotvcqcIa/nYoF536jAYOuL6PImA3UXoUz
	A+G2Ltoe6LG3mA3tbKN2PL3qgKr+DinAQcgwuvJqXBrWUaKdoIGuJP5uC/ZCSRBrkzFAZLrkb3g
	qioA0USAJiDbVKVadZdsaBrU4UvTZHrFfGxhNIyBd2FZ9iBmveOdB0OFU8AgVfwgg/GIkf1HexC
	n0ZvajZHJunHt7pR39qku5Jo9idemesIU+nW+s4o/+ILsaCnfCx/Yxx/00sjTMGqfPUiZwV8PMF
	edbpJ7fbq6rCu7Z22vRxNQ6utux7ThiLuBOwqK9c8rDniKjqn4/mSzlvUHFxtWxDjfDUheEWtMo
	kbR67ygWowzGP50sOmhvc/IzHYkF8
X-Received: by 2002:a05:6000:490e:b0:492:bd2f:bdeb with SMTP id ffacd0b85a97d-49b022b3bb0mr24872162f8f.17.1794759434018;
        Sun, 15 Nov 2026 08:17:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm16607116f8f.38.2026.11.15.08.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 08:17:13 -0800 (PST)
Message-ID: <7e5188f8-ab49-495a-bddd-7ba8921c11e0@gmail.com>
Date: Sun, 15 Nov 2026 16:17:11 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC Patch v9 0/5] repo: add path keys to repo info
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com,
 gitster@pobox.com
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
 <89511e61-4646-45df-b5ac-b52c9424072e@gmail.com>
 <CA+rGoLfJyuT7+W_eVPap_KSqy4EFG4Avp2=rL=hsLu0uXxem4w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+rGoLfJyuT7+W_eVPap_KSqy4EFG4Avp2=rL=hsLu0uXxem4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/11/2026 11:03, K Jayatheerth wrote:
> On Sun, Nov 15, 2026 at 4:03 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 14/11/2026 16:37, K Jayatheerth wrote:
>>>
>>> Changes since v8:
>>>     - Dropped `path.hooks` and `path.cdup`.
>>>     - Renamed `path.toplevel.*` to `path.workingtree.*` to align with the
>>>       standard "working tree" glossary term while avoiding hyphens in
>>>       configuration variable names.
>>>     - Renamed `path.superproject-root.*` to `path.superprojectworkingtree.*`
>>>       to provide a descriptive name for scripts while avoiding hyphens.
>>>     - Renamed `path.git-prefix` to `path.prefix` to shorten it and avoid
>>>       hyphens.
>>
>> The range-diff looks good. It is a shame we're still creating a new
>> repository for each test when the majority of the tests could happily
>> run in the repository that the test framework creates for us. No one
>> else seems to mind that, even though it makes our test suite slower than
>> it needs to be, so I'd be happy if this is merged as-is.
>>
> Whoops, apologies for missing that, I made a checklist for this
> reroll, read your
> note about the tests, and completely forgot to add it to the list :)

Not to worry, it is easily done

> Also there are some newly arised questions about this in my mind:
> 
> - I am currently writing a follow-up series to consolidate the overlapping logic
> between `repo` and `rev-parse`, and I plan to combine and clean up the tests
> there as well.
> - Three `path.*` keys were already merged in an earlier round, so updating those
> tests would require a separate commit anyway.
> 
> That said, I'm open to feedback and happy to switch the tests in this
> series to run in
> a single repository if you think it's worth doing now.
If you're planning some test cleanups anyway then I'm happy for the 
tests here to be cleaned up by a future series. I'd do whatever you 
think is easiest for you.

Thanks

Phillip
