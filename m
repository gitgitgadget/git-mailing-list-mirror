Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563318;
	b=s/hZJVAKOft4LmJZjqXrdT3vZcdL48dT5gbIlFFeam3Esr0VTkiD91qo0Ja+kvWwsbQA
	 L72Hv9qaY4TC3yNdaOusDlSaRl+FBOWZkxJmKFc06Ql778MWgYf2kEVDozLpyroW8CyDJ
	 GlsNAqBHXpBN+vZF1cYkzll38e59K/BdW11COiGAlqbtLCGqLToOtQ8r2VUG3I6/rvIla
	 XJYKZoDQMQz542DH/X3VX0IPAeMmLS29fSIMEYotD79rpciDgUkgj4RWbCztPvWHTZajk
	 nAiMqN07fuuxgc2uWeVy85p0gMm7dfrEEAptghW0dcUsnstZpISr00JPpjjEeWsgprA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ojs2D4KKFZr7/uPmQEMQt9ixXOWW/qKGA55rZE7bqmY=;
	b=kq4P1YWzhzMFMD2S2HmpBGc7du5FoVgSKkiRJUv4rCXyS8POeR0HZ4ceLQfmGQdl3PrC
	 qxHBzG/cuarUP3KZSuxR8ca2hsXE4WxqACxkjTKCuU8h1KaxCJUe9kFXii7jSsOPTQgNv
	 2seaej4nJmD9vMYuOcO8iroK89Zvyvmn9kLYhXtQ016MGZlJ+VPMdm9FErSsMhBM0Nww7
	 PNFFFu2roEV3WcMOewdSLHXc3YllHEHz5CAxEAXdAsGHm7V5lt45054/mJmRWa6bVYZJ7
	 DqBjil93ewjdmBzqgmxoOhwFJB+tU7HsZOrcPcbFztrxpCUdwfvXhVET0SrnnFu4ocA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MkwIOKXE;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939F606A339
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 09:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B939F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MkwIOKXE
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so4919345e9.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563316; x=1795168116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ojs2D4KKFZr7/uPmQEMQt9ixXOWW/qKGA55rZE7bqmY=;
        b=MkwIOKXEIjki31rkPWwCWbMvgM2B3C9MzcILN/X81wqKniYH38IhJu8nJqQQf8KXgK
         w+E3X6qqgooSKUhAw71bpUf0cLQb7wM5DQW35enaeo1QG7jG0foXLfYrZ7dlcRN4oYNu
         yql39WK3SeeUrCYhT9RdiOarxMnM6Ol6zf9TU5lGDM9FzzvnF8w76RP0a0wrvOo/yoEz
         RDxrM8/gfytYkT7l4eFwWfy0oi7adfcsSqJf6thQSj/tgK19usWHW3pzjHrEEeahfIZQ
         WVr9E+LAF1Uu+VkSJ6iIHdQnUhuISbkYMgbZ7nWILdDICxrMYW4VR/03JKXwEGrvabpL
         trjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563316; x=1795168116;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ojs2D4KKFZr7/uPmQEMQt9ixXOWW/qKGA55rZE7bqmY=;
        b=OTMs5iEX4J6J6zoojFb0QZLPek9BRWf/YUiOOoqLvYFsukCCYCnWbvSJrvn+CL3EXZ
         PJ2TckNsDWQQRgPJlzgqtNZENszGxahc+KQJVOSqH+wlKN/qu2GISBEArr+9NGthWrp8
         mOSZ0gfyvocZOnaPdes6rb9w/o9UczxPg/VHkoWcxEmPzV28iGteP7UipsO1UrDj2hT8
         lvcjEfldzenEAkijuNpH4UHp6wOw5BIzzsybaAbd1V3LPZJtudmWGIwePMFnISH2xwQt
         tozY1YqIqNxKuzC8j1F/4WFqOKpVXOJMQTb6sgXvPHzEg7i6zDcy1dJDZ1lPDJ/pXVUc
         oBow==
X-Forwarded-Encrypted: i=1; AL+hErGTu7Z8HrbaniyYUbMkV/zr89nJ0TJz8etWp8bP81uqavvh47iFeP0x6NWW/cBABB4W22A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9X0CK9PElfV8HN58jR511TJR2tT6Wc96p9x/I4PQGcMhIx1eqW
	8c8KGNZfc1Wy6TQW0JnA81Wzs/WNcbVUQUJtVMlvaTzOLlTfprfc5srT
X-Gm-Gg: AYBFou1I0hZDXQgxlWPf0icXkoSOQej+GY6HuPRpcpiz/xqBvsZcAhMgvietsPKCA31
	Pr+qr/38ZHygZ5/UxZc4vzN1Mg/qPtxjRjWcuETdNqqiC7Pnh+3eLoUSx6mLatTti8W56OZ9i7G
	ZgIOe3V4Xe3HZRjDeYODlpLHKwuQf5vtRSXgh7j+/DFRdmv2aPwZI6mmR5cIb4i4NmFpF7tdVO9
	n6jV267G9SQAEyvgxEWHMZaWYpaK5QpwT7PqvDPi/bDpqsbXg4QK2Lu+JobgrlCJz9Fbe5ShzCz
	F8b4iTP0THzptSTmNqD+2Blnw9IP2l1eYK7DKuzF1Rlsn5rOoVyoYzKUj+4GruvTK1Hawo1Z3Df
	0LuG/1/78xFS+CEWE6M7aEEHWjaDX8IDQ+IMVg83tjxTciyr1/LduKqo//xtFIgRdRFDrQJoCoC
	W6n6wOk5zzWUdbwr5apcOEllc/2twMmHHLnYxqutnYlp59Jgcry8Jy/M0lg0lSy1B0eFzRXMk6n
	pfGPOnB514mL/Ul+t/y9zJEyhzK9dDD5NXlHwAo8KOf2eY0QefyKEFFQsQNPpqoDLeUTnPzYXQx
	I0828z6e9eIcIvp/WCB7k+KYpCbTBeBSoMrnsMsMT+4FVtx0pZH0w+2Gbn6AuE3iq62Ccet9+YS
	756Fa/6Ee
X-Received: by 2002:a05:600c:1c18:b0:4a7:9044:a87 with SMTP id 5b1f17b1804b1-4bb55ac0e34mr38745355e9.27.1794563315813;
        Fri, 13 Nov 2026 01:48:35 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55afb6absm51977275e9.15.2026.11.13.01.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:48:35 -0800 (PST)
Message-ID: <5125fcec-7764-416c-ab78-58cc22cd415d@gmail.com>
Date: Fri, 13 Nov 2026 09:48:34 +0000
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
Subject: Re: [PATCH v13 1/6] fetch: add remote.<name>.fetchRefmap
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
 <07081828d1d65373bee4b2ef5e1916e65a217db6.1793357550.git.gitgitgadget@gmail.com>
 <01a799bc-5493-4984-8b83-7f2aef698f85@gmail.com> <xmqqv761hltu.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqv761hltu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2026 19:49, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> When remote.<name>.fetch is also configured, it still decides what to
>>> fetch, and the refmap maps what it fetches. This lets a remote name
>>> only a few branches and store them all through one refmap:
>>>
>>>       [remote "cabal"]
>>>           fetch = master
>>>           fetch = next
>>>           fetch = seen
>>>           fetchRefmap = +refs/heads/*:refs/remotes/cabal/*
>>
> 
>      If .fetch is a refspec with a right hand side that stores the
>      result somewhere, and that somewhere is different from what the
>      .fetchRefmap suggests should happen, what happens?
> 
> I think we tried earlier and saw that we store them twice [*], even
> without this series (i.e., specifying both refspec and refmap from
> the commmand line).  As it is a long-standing behavior since the
> --refmap feature was introduced, and I do not see huge problem with
> that behavior, I am not sure if it is worth tweaking.

If we want to be able to use "remote.<name>.fetchRefmap" to specify how 
to map the names of fetched refs without specifying the default set of 
refs to fetch then I don't think we want

     git -c 'remote.cabal.fetchRefmap=refs/heads/*:refs/remotes/cabal/*' 
master feature:wip/feature

to update "refs/remotes/cabal/feature" when we gave a destination for 
"feature" on the command line. The existing behavior is long-standing 
but I wonder how often people specify a destination in the commandline 
refspec when they pass --refmap, so would anyone really notice if we 
changed it?

>  But if it is
> wroth tweaking, we probably should do so as a preliminary clean-up
> before all of this, since .fetchRefmap is merely a way to allow you
> to avoid having to specify --refmap from the command line all the
> time, and this series does not change its semantics until step
> [3/6].

I agree with having a separate patch to handle the cleanup, though as I 
said elsewhere I think we should drop patch 3 and use the combination of 
".fetchRefmap" and ".fetch" to set the default behavior when there are 
no refspecs on the commandline.

Thanks

Phillip

> [Reference]
> 
>   * https://lore.kernel.org/git/xmqqld7hafhy.fsf@gitster.g/

