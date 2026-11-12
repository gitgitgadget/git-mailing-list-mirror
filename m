Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482219;
	b=5YrnyncxBedn3UBEZibgQN2LhdU0jp/dlAwRVMjANbnBYH5VXqjp4tRJDZ3vrOekIAlu
	 p9st38G2lOV//8lipjZGMu0JrmBtksE8Q3e4mbdn2D3WRif9Tm6xyEUovv5LPadyigYUc
	 zCrwiJtI0DLc6uMmzJNFCETkF86sEH/4x3n2rO+GnwYfULrOprWA9MCJlr45qzPILo0U3
	 KbOiAH7GVkvX2KwJRQ8xE+2Mkv/x6uid17vW/fVoG44Re8u8DtdnxNj1HHUcI8kXgIm84
	 7Sv5xt6sFF67loQM1OqLsQOgddOax9unp0Zwm90UJWDXLfDilBV+fuGOKcuMBere6Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dDVSm+MUVKoI1j9rfsOJfxwv3WqeyTkWIzvZFCMXYUo=;
	b=LVv9p3Sr453vrgkH5wrNaQ6dCZPuOz0IkGl/3I/XSEB4Ywqt7UXFk8i8LF3Xp2ofLNhq
	 MJ+ST6wW+OfKnKHiL+8GgQBhZbA1F6UtLmGNQgzMcp0uGKZ8ZbuGhoH0Rj5VfdQw4+K9p
	 ZrDMrTB16YFRiW92Y6GYFSq+Qv4B72cq63eYoJDgx/awCJc9DZyyKvObsZM7E5lOQ5BB+
	 d8M0iNnPyTauPXkoOJboOvUR6nLTnQyEu09S6Ey/tHmSaWOA0BshLaoz/NhqVcxO4x0+S
	 DPMBQOyzH1HHJVPy11riiZJGKFOYV8cDV3NDRGsJKyVZHsP+xLOKzg16RNXErQ2EyEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/KIy28D";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374D606A89F
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7374D606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/KIy28D
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so2486584f8f.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 03:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794482218; x=1795087018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDVSm+MUVKoI1j9rfsOJfxwv3WqeyTkWIzvZFCMXYUo=;
        b=I/KIy28DKwrk5nGm+Rp72kQiNUuOjwLPVLT7vE9hiU4FPwaCiOz67cgcJh60gUY79h
         u/Cbfwi2yB/0W4NOkT5H3JaINdmqfCGKfr/7Bmbhzpz0PwYfQ27nqRYw0OEQZf2HWGfe
         vNH52GebaKVa1xInLF4h2hWUo4A+695XbmtnFuLuF+3sLAY07zvLGRWaDjPVPHdAuP82
         0maYJ+CH9NeUK4u62P8dioQWrYfp9sQrkSeVNNMDbilfG4BiVY+KRsHGdhWCEqBup/Gh
         GTlu2+yCgEEAU88VjjwFSHaoRqfOW5kzJV6xyzcl0LPX0HtIQx/Tyg4lrU4KCKqmYqlo
         pAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482218; x=1795087018;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDVSm+MUVKoI1j9rfsOJfxwv3WqeyTkWIzvZFCMXYUo=;
        b=qjb0iiMCsnfuPUXi9OlfA9kXjXEQM11Zi4SNZHyQMjugmurJBLufn/WcGh/6enbOx6
         7HSSICFSJC9qIs4gsbE8dhvFhoE66h3k7kSrtRnpj4yikzaHyW86MBUm7jDcoNucN/yk
         AygPFmHcfHbf/cJY8n7fpxNfne/yPnJP0k61nNBwn+VomDb15ZYaSbhlJFQ27cCELI1n
         p/TcNPTeZa67OFQvg/uNUnSeHf3UEoARnDXa1/kjTLW1BgNbH3STsuSXoEB1gGDgT8he
         PMQdauO0PmRmevSWDIfY49/L82enmhRWy7lJvpUKvgV9zWsBOmnBR9ZzJgcsQC+Liu10
         9/AA==
X-Forwarded-Encrypted: i=1; AL+hErFyfXisVblkU6lpt9dTiu9QW0ZAlMpI2t+qh76D5uyS7+zYGzoMrafnzXpxOxMyRcexO/M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ix/u0m2gd/bCeh/HN1AjaYR10L8vZQr0crEAck+FBUzud8tFX
	O43glZTccqmTZ/Gt/X76IonHsOO4BXGHalQ9YmF/aJUsSxth0Df58k9+
X-Gm-Gg: AYBFou3ilSwhXSo/a0TJkJzeYslghuP8R3p7S5s/6kXr2vdlakZQAokl+kvkHeT1JnH
	nQBTuDVogb2dtOvBLUqIBrR5oVIlbEJjDtJ3eTbmN8SP4mipTyvdwp14rwK5PvbVR/ksXX+DncS
	rDWU5HbgToMn05xIQNuiZpxFW0+s6/H/SdDWbRezIn/kTn03zwGf4cmZQhzqLyNltMe1tPrj8g8
	Q7SCmk6jKfZY4kAuzDpndPrA7vY2IMIakcHL6dpTwNpFbnevz4PYhw1RlYaxYRFuO68BwO2+nj5
	GF6Rq5BhOonNKUmha/25tiys+MEKJJd/8ch9u5P5YY/IsdBGwf9SXc6l5WFNhs/vY0FB53nZDv4
	1iuxCk9mj73fL5zAcws6Wzp4AZDmOnWw3JmN5Xd9prwGSfdEcqGkxOnoKoECTRfQ1sKGitLA9j9
	iF1gydmUKuGBmIgHxx8zOD67utlSKOezxo+ySMeZyUCmtAq79PaQKHb+8gWFB9d0LtYf1qnuVGP
	Q/jhKjyWkD4TYkUhT0xb3BXPrcKInuZu2edyIUdS6VaUH5fE+kXh2SDgSn23MhXDira2ODgQ5uN
	l8QRSIuVcWmB+wq7+iCoF/sa8XxSUhnxq3T3peh/9yOY9oUfLwf7xooLwEXaUVm2h5b7LeAmm+A
	Uw9mfhcNk37ENMIrBD6x3PgXO4pAu
X-Received: by 2002:a05:6000:230a:b0:48c:6cdd:ba89 with SMTP id ffacd0b85a97d-499c7369076mr9797042f8f.36.1794482217788;
        Thu, 12 Nov 2026 03:16:57 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a4238sm16986468f8f.54.2026.11.12.03.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:16:57 -0800 (PST)
Message-ID: <5566b994-1070-41d3-807b-5fac9ddaa3d8@gmail.com>
Date: Thu, 12 Nov 2026 11:16:54 +0000
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
Subject: Re: [PATCH v13 0/6] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
 <CAHwyqnVJ3eUQ9tkQE3rhQ8jFZjaD0tFUv41unE-NQ1WRiyfjBA@mail.gmail.com>
 <b64387b3-294e-49da-b40a-0e757956bafd@gmail.com> <xmqqcxsbnub5.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqcxsbnub5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2026 17:37, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 11/11/2026 08:31, Harald Nordgren wrote:
>>> Hi, could I get some (hopefully final) reviews here?
>>
>> The diffstat for this series is
>>
>> 12 files changed, 593 insertions(+), 33 deletions(-)
>>
>> which will take a considerable amount of time to review properly. Yet
>> the cover letter which should explain the problem being solved, how it
>> is solved (i.e. the design and any trade-offs that entails, alternatives
>> that were discarded etc.) and anything notable in the implementation is just
>>
>> Avoid fetching every branch of a new remote in a shallow repo.
>>
>> I've no idea from that how these patches relate to the discussion on
>> separating "which refs to fetch" from "where to store those refs" or
>> anything else. If you want people to volunteer their time to review your
>> patches you need to make a effort to explain what those patches do.
> 
> I would say that it is a fair comment.
> 
> I understand what the first three wants to do.
> 
>   1. We have had for a long time "git fetch --refmap=from:to remote refs..."
>      given on the command line to decide how refs fetched are stored
>      separately from what refs are fetched.  This allows a configuration
>      to allow you to pretend that you give it all the time.
> 
>   2. Preliminary refactoring of a helper that will gain second
>      callsite in the next step.
> 
>   3. This allows "git fetch --refmap=from:to remote" that does not
>      specify what to fetch (contrast it with 1. above) to default to
>      fetch refs that our local branches build on.  The net effect
>      with configured remote.<remote>.fetchRefmap is that "git fetch
>      remote" would only fetch and store selected refs from them, only
>      the ones that we "care about" (aka "build on").

Thanks for the summary. I'm still not keen on patch 3 as I said in [1] I 
think it is a mistake to use the same variable for both "what to fetch" 
and "where to store it". After patch 1 we have the 
remote.<name>.fetchRefmap for "where to store it" and can use use 
remote.<name>.fetch for "what to fetch" (though I am concerned about the 
doubling up that happens when "fetchRefmap" is set and "fetch" is a 
refspec). We don't need a special case for when there are no refspecs on 
the command line - we can use the default values of those config 
settings instead and the user can configure the behavior that they want.

> I do not have strong opinion on the other 3 patches.  4. and 5. may
> help ergonomics by allowing to set up refmap from the command line
> option, but from my point of view it looks more like icing on the
> cake.

I think having a way to set up fetching a limited set of branches is 
worthwhile, but it does not need to be part of the same series.

> When we are working with only a subset of their branches, the first
> thing that comes to my mind is a "matching push" that does not need
> any fancy @{push} support.  Because of that, I am not interested in
> 6. very much.

I've not looked at what that patch does

> In any case, this topic one is keeping a topic by another author
> waiting to settle, so we have stronger incentive to see it move past
> the finish line.

What topic is that? - I can't see anything marked as depending on this 
in the latest "what's cooking" email. Would merging the first part of 
this series unblock the other one?

Thanks

Phillip
