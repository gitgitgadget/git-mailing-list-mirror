Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630203;
	b=yRGWlA+65S2sPC+vraDMPHxlmZhSsOla3sLxnk5LrkP0chgDksK9KsnkKkMovlK2BULk
	 I8vdsijA4p/Bl0ulSUE8CQW89nDpEOaAWvb9xghnj/45qMyq4BujKNNPvNMbXwxEA3f8r
	 uE4iYdsUsE+Bv9AHdbAXsewG0ZoZAwyvSYlLbJNjwvxv9FGxxRFlHLWdjvC2M1FLX31PX
	 vafmcmbZDyRQYNDLH/YTbZJAjq2O0CfcFFuNyykBO+gtFB5WkvrBuW4laFZUTyXKR8+zj
	 FuBV6/+gZTjaUYpBCw7oswjeuck2H5A8f/f/zJG6kStYumeId+VDBgkhyUDM7zY97Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cLU9iZKtCxzeDYGjGqrnpkc256KVLM8Dt1yI8/Ngmh8=;
	b=mplekIclNpMAns4Y0YgLeap95+ym/AYDsFcIspVSaGr5dy1Vh3azY5d4Namu0BBlChNv
	 L7PyQS/IssKs2MEO1GKebCzGTEEOlqusb+x6MwYQDz13u29gIaNpkHE0a5uh7giNhcTm2
	 FDrfietQIC42aAGhdUN6QynJP/3akich0+I9HcVnxir+q+UfdtNv/5HNaThcjvVTqX6v7
	 62kWgQwXSDU60R6gYDL/GdFNzwYVegRoSkiZ1Ps/jqkTWZ8BzjaMVQfPEEt943Hdl5ktQ
	 a+r0K02Oow1XSj9Zt/wi72S19A4QYEvoa1GKZimiMoZLF6b9HrXe5e1Df4ow0kOnVmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjjmh5X1;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F328606A336
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F328606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rjjmh5X1
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e46e449e8so1904152f8f.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630201; x=1794235001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cLU9iZKtCxzeDYGjGqrnpkc256KVLM8Dt1yI8/Ngmh8=;
        b=rjjmh5X1N73zmPUjnn4SXre63eV18EB6nkGS3ElhfbQyO1BTS8gJtyWGIIzgxuTaEo
         zjmGRM4qKVIonTVSJdf6uD4vw13hJtlKPq5H7L56cDuuEAVWR4c5Pd+jO5WTuBvI6eY4
         U8DA3B9Pswdq4W5Z7EPjXT2V98jkFmzGcDwihGeS4bPeVHsjz/HnJ5YnxAfoDJBhiKKG
         NIz0WW754hORDy17mqO2YjA2tRnsd+0dh9/uyESm+xkNnduTdeK81qP5D+FUinE0CF29
         P1XgogQFUqzUMcpOLOfnR9JcEFK5Do60f1w0YZS+7Kz4eNPfcTRZhrI7/NXW9/N6od5d
         rfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630201; x=1794235001;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cLU9iZKtCxzeDYGjGqrnpkc256KVLM8Dt1yI8/Ngmh8=;
        b=YsMmKvmqvdQ80wonKhdyfKGshojUnJx274yjg5v3uVRfjj/xJtFFSQXWcQfgvMPtMt
         54wPZTWDVxxnlgdvgZFQMxQ3mhVEyLypLHrAWIPzwAoR1sqpU5RDaplEtFkyjPTRUQDk
         NEHDsaQD+F6WHgBORFm97yU0OTY7SeOlLaYzYnmZ3phNWXIMmyzZVa4KxL96ETnB0Qz8
         i/Rq8mRnX3/voqg6pB53YAvF98fsbzG9Qo1Jhqi159rH66m0i72pZHI/hWo3H+C9G7Gd
         PuHScYNxWDE1knXlintAG48HghY65eRvYld6SFWM6yCTA0BznUpnfb962M1QRZtVJw8D
         lEwg==
X-Forwarded-Encrypted: i=1; AKwUvBxA0f+E7Tdc+2RvzQLMVyMLkdfCGqAVLnrnk9Zo6+oTwKdWmvHMxw09vLTC51vhezZAHhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z80Qd4XSq9B0DoQzjsyNU7Wsbx7/z35RGHhsWyn0Ckft9LiNq+Y
	STrNJ/b878DoGNKw3g47U80vkC9aUzC4Uc14LXz56aMYHaUepqBVmVYF
X-Gm-Gg: AYBFou0XvykC53jxEdzKoTzT0FUd6W7Gic15OErx5W5m+I5MAc3WDhnyTAOPTFG1PYo
	O7vlc6yPXmnGgelPV6dWYbO4sk9sTEl5PWLBrdcrWDe9atAI00d4YiDZl/SK7GdktOuX0scsUXX
	3ovOG7lSrQ7T95qqNbsl/mmQjvG6sxphvWbpZTXkPctFnU3/2zVy9CrlXu2Ad5tLfUSWcWaFjlQ
	GxVXkuCGdTN0G62Ukyyc9gU1hNQ6yO6cKYPuQ2KHiLk04Hje08lwWEJ1Tl9GmrDOWb5OhOXHxlL
	hyRijzvIse++9HRdQPq2diqMwyeQ2gf8tOmRlc72ARuAyQTucAinpy6AmhmVr2vBHS72SGhGEqf
	kQC6dBfx5HrqXqslOor9Fl+I0JABuQZFFrXgPCpPNdadZgFBcDrWG41IClJ7Xkrsurls8J+i/1z
	JWU+AE0YuN+Q+kwTeQ4kgCk6ATBuH+LtwzD1enxiDQg3aw+s2p7PeYAkDKVq0P4B3ByOcbK/ayd
	8tmsb+tPZBWpdkOiJ7a1UjkA9M+ZbwEJy8BfGtsmCVJI6m69FpJsUHfeEIA2YXbcVdEa3a9leIn
	qWkab0ymDBCEryOuMFNbx/n0ki9eXNBEfCq9ixbmxvlt7AmUyJaPZ4RkATyNvPcsS3jdHjg58Wn
	DqicM/w==
X-Received: by 2002:a05:6000:2884:b0:48e:6eb1:3d02 with SMTP id ffacd0b85a97d-48e6eb13d20mr21151068f8f.0.1793630201340;
        Mon, 02 Nov 2026 06:36:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d425sm20863696f8f.1.2026.11.02.06.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:36:40 -0800 (PST)
Message-ID: <50c6229a-336e-4488-9289-183f5ffc47cd@gmail.com>
Date: Mon, 2 Nov 2026 14:36:39 +0000
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
To: Patrick Steinhardt <ps@pks.im>, Harald Nordgren <haraldnordgren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, GGG <gitgitgadget@gmail.com>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g>
 <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
 <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
 <auiBFhXI_xiBTPbg@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <auiBFhXI_xiBTPbg@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/11/2026 12:24, Patrick Steinhardt wrote:
> On Mon, Nov 02, 2026 at 12:07:29PM +0100, Harald Nordgren wrote:
>> 
>> We can loosen the requirements on perfect code, as long as it does
>> what it's supposed to and doesn't have security backdoors.
>>
>> Many things like tests,

The CI checks that the tests pass. It does not tell is if there is a 
sensible amount of test coverage for the change that's being made. 
Stolee used to run a coverage report which was helpful to highlight any 
glaring holes in our coverage but I think he stopped running it because 
it was quite time consuming to maintain. Even having that doesn't tell 
us if someone has added a million pointless tests that slow the test 
suite down - that still requires someone to read and understand them.

> leaks and linting are already handled
>> automatically by GitHub CI. It's a good time investment to automate
>> more, because it frees up resources long-term.

Having automated checks for common errors is certainly a good idea

> Even if we automate more of it, that would still not fix our bottleneck.
> I do no trust automated reviews enough to just merge patches without a
> human review, as part of the review is also the conceptual direction
> that we are moving towards. And that can only really be reviewed by
> someone who is familiar with the project overall.

Agreed - it is no good having a "perfect" patch if it implements a bad idea.

> Now automation could of course still help us. For example, if
> contributors started to self-review their patch series before sending
> them out, 

That would be really helpful. Once someone has submitted a few patches 
they should know what issues reviewers are likely to bring up and be 
able to preempt that by at least trying to fix those issues before the 
submitting their patches. I don't mind spending time helping new 
contributors get used to the process, but after a few series they really 
should have got the hang of writing a cover letter and thinking about 
how their changes affect other users.

A while ago Junio floated the idea of requiring review contributions 
from contributors who submit patches. I wonder it would help to say 
something like "for every three patch series you submit you should 
provide an in-depth review of one series from another contributor". I'm 
not sure how well that would work (I seem to remember reading PostgreSQL 
tried something similar and ended up abandoning it) but it might be 
worth a try.

Thanks

Phillip
  > or if we had a tool like Sashiko [1]. If so, the human review
> would happen on a patch series that is in a better shape already, and
> that would likely require less of a time investment overall.
> 
> Granted, at times we err too much on the side of polishing the last tiny
> nits. But quite often that's also us trying to train newcomers to write
> proper commit histories in the first place.
> 
> What I would very much like to avoid is reducing our standards just
> because "carving in to AI is inevitable". I've heard that argument way
> too often by now, and I don't think that it's a reasonable stance to
> have. It is very much not "inevitable" that a project must move faster.
> 
> Patrick
> 
> [1]: https://sashiko.dev/

