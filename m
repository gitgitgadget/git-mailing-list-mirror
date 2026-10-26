Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011981;
	b=pY0yKdnKkxbmSYHS4V4a3GTaT8KRure3JqrDONLh8yeI/a3MdM9QQz2TZt+caMtVo2fS
	 dpZZ8gr90N9hsleGz2ci1YIwH5mPkFLKrRrGqVZ/O0Hm6ecGJMwOXHMCntcAAsAtFaVb/
	 FPOhh4z6l1oDz10e/dEZnvHMrkbGDBZDtZGCNYIXEi5jmHmXdzN2xbhxxT7YptXoLmdHz
	 YKQvyeMqJGssH1lVi4tfctJtM9Ct4v0IKMK7NmkL8LQYAdMng0bExnnHoJGDKzgVpmZVn
	 LO7Z3ou3V2hpvOqiLVYxUqIPv19ulc1FeULmR5bS0ReqbVBA0T+GdbqmYMZ1WoTGkFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IVTT2ChRkuyhWh5V2Jote5XpIDcdCQ8XCSju13IfWSM=;
	b=a/G7rgpLoEsWcO7zX/1yydcDQclApv8jmM+C8RFm0pAy3CR2W2oL8q2GHUiMUOFV1y/9
	 jCurEjejLgICuUwHDErMxNxLvgtBIVJ+YHXtZzMTMcbywGDHLWzsHSlwwgSRWzxgsfw1f
	 dU1DqX3GnytleNs1jZySwcJi3zgY49JWshg/xNcwLxu63F8lfo3st3Tki2ryjkzzRrv8M
	 S0v4JIIwzK2a24iLi0zhgxGrW7Mwi6qp1OPlRxeK9cEe1ckvgwCjKbelFFtSrO+QeGOJL
	 vSYuaiTZo9V1Pqxp2t/9wDuHR4QdcnXK1BSyidWpgSI122gdL+5GrEypW9izP226W7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SXJp1z0I;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C4606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D8C4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SXJp1z0I
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so17157985e9.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011980; x=1793616780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IVTT2ChRkuyhWh5V2Jote5XpIDcdCQ8XCSju13IfWSM=;
        b=SXJp1z0IuvVlEknG/Wcc5GM/55mLnTNyK/oIOaFORmAyGkJYjiP7kvJSjA29uqtYEp
         tDsR3qFojJKYdUA6tp4CPguc6lQ33zlWoO9eWK0ZehN8/GXHl5lcCBhJmylD6JqeEw9/
         baTzL0sJ9JS00AyBXaUBTME8gPhrpvUkdogTRXfNH7M45gKFDhXEj5tdOHd85ZE3RuVt
         hnYFGBRqdECX+KsZ2dVBdbfuWiUA4aFdsw7ZNcBTN+uLhlwgHQ5fC91OV6VN+TtPOeqg
         T2eYqznzBCbyIOoXvjvxuxfWlvnzPSaabvVocw8JmjOuzmH9HgYiqmqz+pZsxvcaT+J9
         RwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011980; x=1793616780;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVTT2ChRkuyhWh5V2Jote5XpIDcdCQ8XCSju13IfWSM=;
        b=rig3Jz5jmZmtgzrF1ZES30DOKAbPav9ece7pglHpUB2JMruu1jByLs2syTQ7+BNTqG
         nSHujjE4ls7t2N/D1TogDbtSoNDeqqCfPS1H7w3Cz+4J/mK/QprzMxQeZVdhXkMcPj2j
         pm5wJxfyKW9QaPGUG/SST+bVFudzweHOcsu8qwxa1/WtgvBSiLsnuYhGkSc9vRPmyKGo
         iOyqc9LvemgAJ0Bug3m7W/HVMSyJDSonla8rXSSHZ7zwppeV2zf+Za2Xt0TzynLUcS2K
         bO1UBE3G5iNQ8TzG/tOKd/ms/eFluy886xcrTVV8uGl/JEdWnzZnCDgpRwErIbP7Kja2
         VejA==
X-Forwarded-Encrypted: i=1; AKwUvBxaRn4kvH2Se8UnNZoKgHsn6hVW2jW67676Ojb7ArKoYqTq9fZ4dGACIqa8vTPQCrJ4sz4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJW/KwfH2hWw9TIR1cED3qDE8bQhag9oneRlDXHKQ5zXRcpCD80
	cW9AXg3tk64+KlHdfDFYTK8/eYhzJmyGY10qi8V0AbbXr6cr984gAyjv
X-Gm-Gg: AYBFou3WaymyNFtJrSbFgHPqpMnkpeJTu7a6tLDQg0pqK1Wx74D8KkndHUb1QUyM03k
	hPQQg03Cj6yik+1pfI2/1PyEyyp7TMffa02tpOc054gs2RpECPlMbQiAgtHPdMkKJMbRXdskMDh
	ePnF3+qz2F0vqg76pToKym9Tvvg6/QaqwmtYRiNkuJFGOZyfF39/uHtozZ3iw9BFGhnSDfCfVAI
	EzH+UNEOOOZebNJYI4/BmaPkftRvswINtoozL92ZFcbQmmxUb0FGYo+Lyf/Guhvv0p1NB52/TEM
	OHMEytJZjXEMUAwChiwNXN1G8iOkubRmb2fKtJW+VUK6QNK4gswjt0FUO5WcqVFem/nqKWYZ3bd
	qWq9RVvFN1EO5B7VJZ+TEVnFes9gQRop5nlcBCSr1Ewy2i49SEJFMISaVofTmMrrXupUKu7+YOX
	dWjDXjTXo+PRHbjlzrgUg23bcrk1veGibDgJ2H6qo+u5aa/j+bwkJ6GjJJUnS8lmbn0w5a/vIbZ
	p4M6mE9J57V1Bv4zsJq0NsBRZB5xiN8w2yI7Pr2U+a+MmJg5gWyqtOkDmCYtRyeUu4hob3XUs+Z
	3k9d5fQfnKjyDPDVXgq4DvPpGImthtPRfQ==
X-Received: by 2002:a05:600c:a04:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a7555d89c5mr8935405e9.12.1793011979822;
        Mon, 26 Oct 2026 03:52:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a56992dsm177316835e9.6.2026.10.26.03.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:52:59 -0700 (PDT)
Message-ID: <1bc5a05e-3d3b-4f56-8b11-2e276cef48ca@gmail.com>
Date: Mon, 26 Oct 2026 10:52:57 +0000
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
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
 <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com> <xmqq5wyr128q.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq5wyr128q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2026 17:40, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I'm rather skeptical of this in its current form. Not all commands that
>> modify the working tree update the reflog and some commands such as "git
>> cherry-pick A B C" create multiple reflog entires that are
>> indistinguishable from multiple invocations of a single command.
> 
> I like the direction to make the default 'git reflog' output on a
> single branch easier to understand without needing any extra
> filtering in this series.
> 
> 'git rebase' doing its work on a detached HEAD was likely the
> first, and we may want to convert more multi-step commands to do
> so, including the multiple 'git cherry-pick' you mention. 

It would certainly be nice to avoid creating lots of entries in the 
branch reflog when cherry-picking. I'm not sure what users would make of 
us switching to a detached HEAD as some people seem to find it 
confusing; if we do decide to do that we should make sure we update "git 
status" to explain what's happening. I'm more relaxed about changing 
"git am", but like you I normally detach HEAD first so maybe I'm not the 
best person to ask about that.

> By the way, I too was annoyed that 'git reflog' defaults to the log
> of HEAD a long time ago, but the irritation soon waned once I made
> it a habit to always provide @{now} or @{0} to the command, as that
> notation refers to the current branch.
Oh, I hadn't realized that - thanks for the tip

Phillip
