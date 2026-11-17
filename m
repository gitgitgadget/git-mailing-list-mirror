Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932927;
	b=R5etmx/ViKK+B4GFCSOsY46kImIn685ep2trFzVBWiHqUyLoW5CgZ3DA2+A0pjUHQNCl
	 92y0BW/VJ0l7y2CfrYIzJuxjfwY3z+hiFAUDmpYzYjA3hIe6/gO5oWQ9VhsvUx5Nq5VDR
	 1I5BwondBoo4B6pVY3iPIyLuhyfnLlFUu8mjC4UUXhGZSpFPO11A2PuDs9Y7q/eZQPLar
	 2nkXFrptE03axEIM97AZCf7j0SY1DpkQaMmj10vf7dYBW2l7fdeLgp8XzTNe0jF5QBj9y
	 7r19Fla4hf4yaopjSwtrNqhbh4PauO1uJ7HPRhnw/iR8mJQayTHWdQ0TTEhr4Q5bTeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TCQC5+jFs18+I4H45qmxnSPXqzQr8FtF02LtB5IiD6c=;
	b=4Kpn7unoXlF4WbxsSX6SRCBKJjNvNIdttcVb4azTcR1KqLO/WBoMXEwUzv171djUbiDN
	 pRnWl9HMXHJlFgDqX6RXFiFjqN3MNDAqKVUhfFONk44QnctXg6ml/i1i6xstTRdNRPXuz
	 2iRmckCgElgQrX4uLvGb0FhdJ5LstKNKM+zLc/vHdOwM7DbHlyP504vwaGi6a3IVBiFES
	 4VTlohG7b9v6ZO2cczO7AVA76v61H9gix8y/vJg8kHEMxD4nc52k/RE6RF14xQ1WtLJKy
	 OfhxBYBlOCOhDmWjfwuWPa4bpvSGq9Srp/j+wUQPxBel4atT/A4xcnJljcCN77sAfpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLy2hVZk;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750BD606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 16:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 750BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLy2hVZk
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b001cd92bso3226902f8f.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794932926; x=1795537726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TCQC5+jFs18+I4H45qmxnSPXqzQr8FtF02LtB5IiD6c=;
        b=GLy2hVZkvWJNlBZdYKgP/8YlDF4VW6HBK07QC9TN5t80VU+R585GsHErqS3HACqKlO
         DG8jBeJquYpARLtnlX0s7Z3+zfii842fzSDcNwwEdDtVVrjEEVuHIs1z3O4EXr2sh1ty
         0BunoeAv1+Ue0Q6eutXwuPzg6kSwoNTEG1qMxKyyIPWmyd3JzZKcYGSw0imp69xBMWOv
         Iwg2S7oCZrnDCR8HZn3BxXFH2img5YifYgH6YjAWh9roIm70cdVNr+7j0QUuSsG0S1va
         y2kbKShTdLbACAHhycIJsEJf5wIfA37yMO8a5zDibPQDJEm7St1syH73Oq7d6/zik48X
         ITHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932926; x=1795537726;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TCQC5+jFs18+I4H45qmxnSPXqzQr8FtF02LtB5IiD6c=;
        b=ZBjLtngYSrocj1dNnV6LR1Fa+7pG2AyXV834QIfY/WDNpIf/UenPKzdS8s77RS/EyB
         p73RKcSIOIRawtlpOHxTXugYXeZdtDxWMPyW1rIB/tHA1qKbu47Yn0Ao2FdbuyWQFRQm
         5BMD8tQYv+8e1CEPecejrDinVNLbpzNRx6ZBxEusEIxH0J++25SEJ0ygAB5HpzImM0qD
         KuAnAIlZLGDRVBhX8E2b5zPBl3vYdtBWOQnrzjmIEtj9s9278FRHQn4eJ9VSpZXWgC4/
         I1BqVQpbGfmdAHNNn6RKja7epX9rnDhEhyqc598lmgj9+mAayW6H8l/zuIcokbVPdW32
         TjIg==
X-Forwarded-Encrypted: i=1; AL+hErFeohhJN54rf6TJEMV2CABmLQVHGR2xMtXOjC7/AwteW9m9emI9AQhJ6yBUEq38c8o9hUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LHFsfQridphKNuKcs14qp0qQaZNhj7WVAujNkWYTvWgvHQ6S4
	EtDtGHlyzdZeO8DpnIkMF4yA1YIK4TjeSdZFLZguPmcREh/AC4TsIMlFmA5NIw==
X-Gm-Gg: AZFdTZczh8MfH5Lu+N1M+WQu7oalAbNJAcbe14GQtvut3OSZhGPnCOjGz1xLbaGkXN5
	pMAMCeGW8EfrRoD6eGuOyQRExHcuYPuseaN9sdtk7YuwXK9eAQlRNd0RffpdGsHUoiyWAImJr0T
	/ST5/m4ZtBjEbnQuWNe7W3w9FyZSavMjkc98ws8/L6CvNuBSSYXfbDf6srgbzuVT5CrgrL5cHhA
	V6k1koctf8YL3/dMvuYA6XsjtkmDLP1SRINS9yaq2dzHBfLrKsWb10RJePVP9TDDBVV7QJ9bK3P
	W91NB/ohhfNwuo6r08lvMm7o0sbGhJfmXcMXngPS7qJF4HQ6q7pLH6aGtwTrY/O7Y4R3XKs9L/t
	E5uLuxuIhdZdiSa6CSl0L0WthHEYKStoq6kCKCyWiii6GhaDmrrZhRuLTQchfq9HyIN/C4rUhE5
	/ju2UGoeaqwrh+ODTV4TmJ0yYKUYU2qbw6tBLHpCbdB1DMVTKVQY3hquATGiUopuDIW0N2H1BTY
	+6voDcQCgjkQfuP9B6ocpf4aDOkUlA+7X5uDje96zRKNBniWLHALpnYH9LStyq9tNnf1rBq74ku
	82SBm0xWjNwf7iXR9UT/M20mXIXjRCmoqo+KlvXN3/pS+D7/3sKdjBMSkhnOFwRRkFWuxQVznuJ
	CUAmb4MhAs+9f7lybZDu2mrNuc4NY
X-Received: by 2002:a05:6000:310a:b0:48e:69ff:ba36 with SMTP id ffacd0b85a97d-49c70823864mr31867323f8f.28.1794932925528;
        Tue, 17 Nov 2026 08:28:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a3e5a6f8bbsm5051813f8f.51.2026.11.17.08.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:28:44 -0800 (PST)
Message-ID: <c40477c7-e1d8-4af1-859b-b739dac4bc86@gmail.com>
Date: Tue, 17 Nov 2026 16:28:42 +0000
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
Subject: Re: [PATCH v14 1/5] fetch: add remote.<name>.fetchRefmap
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Matt Hunter <m@lfurio.us>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
 <c63699b40228b1d47368778d7397b1ddc6ba2a36.1794681496.git.gitgitgadget@gmail.com>
 <5a1a9f6b-48c8-4daa-9059-bf9459587a17@gmail.com> <xmqq7bibh3f5.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq7bibh3f5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/11/2026 15:40, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> However, I think it becomes confusing if we store the ref in two
>> places when the user configures ".fetchRefmap" and then passes "src:dst"
>> on the commandline because users are used to a commandline "src:dst"
>> overriding the ".fetch" config, not adding to it.
> 
> True, but the src:dst on the command line in your example is still
> overriding the .fetch configuration.  Wouldn't it make it confusing
> if it overrode .fetchRefmap configuration, since src:dst on the
> command line is what .fetch configuration gives the defaults for
> (and .fetchRefmap configuration gives the defaults for --refmap, not
> the refspec like src:dst).  It may be just as confusing as if, say, a
> command line --refmap suddenly started overriding .fetch
> configuration, I am afraid.

I think it depends on whether users already know how --refmap works. My 
contention is that they don't and are used to src:dst on the commandline 
overriding their config and will therefore be confused when it does not 
override .fetchRefmap. If one took the view that users are already 
familiar with what happens when they pass --refmap and src:dst then I 
agree changing the behavior would be confusing, but I don't think most 
users even know --refmap exists let alone what it does in this 
particular corner case. I had a look to see if the current behavior of 
--refmap combined with src:dst is documented, all I could see was

     When  git  fetch  is run with explicit branches and/or tags
     to fetch on the command line, e.g.  git fetch origin master,
     the <refspec>s given on the command line determine what are to
     be fetched (e.g.  master in the example, which is a short-hand
     for master:, which in turn means "fetch the master branch but I
     do not explicitly say what remote-tracking branch to update with
     it from the command line"), and the example command  will  fetch
     only the  master  branch.  The remote.<repository>.fetch values
     determine which remote-tracking branch, if any, is updated. When
     used in this way, the remote.<repository>.fetch values do not
     have any effect in deciding what gets fetched (i.e. the values
     are not used as refspecs when the command-line lists refspecs);
     they are only used to decide where the refs that are fetched are
     stored by acting as a mapping.

     The latter use of the remote.<repository>.fetch values can be
     overridden by giving the --refmap=<refspec> parameter(s) on the
     command line.

Which reads to me that --refmap overrides remote.<repository>.fetch when 
remote.<repository>.fetch is used as a mapping. As 
remote.<repository>.fetch is not used as a mapping when there is a 
explicit destination on the commandline, it is not clear to me that the 
current behavior of --refmap combined with src:dst on the commandline 
matches the documentation.

> I can buy it if the suggestion was to allow passing --no-refmap from
> the command line (or would --refmap="" work?) to ignore .fetchRefmap
> configuration, though.

I think --refmap="" might work as --refmap overrides the config and 
--refmap="" is the documented way to ignore the ".fetch" config.

Thanks

Phillip

