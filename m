Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291222;
	b=c0gSFphup1mBgoDkWSBrZ7g7shQxtSMift1+KBd8o4Bks1OvAFb5DI5Lwxd1XPcXJfzv
	 glRu24z7mc9gASfaFARhuhZ4JpFjvlWmjORcUnHbjT4xNf0gxwef/ppN0XBFlBAK4fWmv
	 NuZEZ6s6rjewZiZjw/ukXmZpsb10YUAGCLrVFCpIGd8cF0Y0qYxDAGtxhC3g6+uoSu7ET
	 1ewgts9XzUqe9V0Kfuzda+ct9MQnwMeC1sdapbkQEPNFHyXGjHEERZLx5H/4yVoWkBUN8
	 InnmeApRyaL1ztzBM/z6CLPlZ/PnS73gJm1LCYRSZu0J121Xg2jvEfDPwI0Sb1QAirA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=X53BX4OWaDm1TO+EVzecrukOLbQtcjtTlNO6s/+SClc=;
	b=0ecxKluSrIjeH9cec3+FwfN9wqeYaIKZQaR5EjMgFfWrBdvjxpNii7PJdVuthUNjV0OY
	 R/+oGLAaVrGUcHjuvIjkaGbp2ViYEENQbVJBeAr3JwIrz6w5t/M70pVL3zTnJcyP2DzF8
	 NcuXabObvi4ieDC0w0lpf/7UUIg7gJC1fCi/p5Os3oVBq+zDhSEWsMbYBZgcdS4D7/L19
	 OPqmDrflINXT1qPiFSz351N1odHAgkiZDgB+q0aCRtNQAdyze+M0NyHaV54LDWcFkDiw5
	 /bBExOASpwfRuTYVmQjk32MRo7CGJK/bPoaieVDfJenkSg4L2cJXjp7f6IyHMnh3pKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Awz+e3tX;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8E606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59D8E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Awz+e3tX
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso18412455e9.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291221; x=1793896021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X53BX4OWaDm1TO+EVzecrukOLbQtcjtTlNO6s/+SClc=;
        b=Awz+e3tXksQ/JRZS1LqmLUBzuQA3pYTx8PUpHCERTrom5oblXTwxqqqDqnR3zMN/1n
         Ya+wivjjblLYfhVeypAEBKSZj+WcRje1TWF9pI1wIj0PZ0OTP1RUFAmq2+f5vjjTfW5B
         YQt6j+P+pD/YGp/iZSBLKnpB/eubmoZahB37Fc+PMACVnNAFXkaVN9+l1ztRIlICFNlg
         f/S+k4O5pcK/qmpYO0QWGvA2pfm0mGrkUqSBqWEc2srVODExInYAdZ2sbDgBbDrPEh0V
         9KUK513pcPPbcZx5WHt+RXXImkBm3E+9sQIFNhCLUuVtygKWSRmk5QWL3Fx0d0WqllzO
         UEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291221; x=1793896021;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X53BX4OWaDm1TO+EVzecrukOLbQtcjtTlNO6s/+SClc=;
        b=QLT1nkKoLibos8/Qh6PDm1X0L0z34rX7iXs0G3AhkCJVpeDNVrX7egNtBFFmtKa84G
         X5sMi3jUnymkMOPr9gBEpQyl2JawvZIZHIizEIOPcU9+YCNjSuwf6JTxK8xZY8xJfYAS
         pbjqH6rkaSar77JDr7YEaVT5pqekhjvjl75OfBXBRufcG+th9oNsrl1VF6QfYx5j6VJb
         40TWxzZLUA7w5zz4bxifHQPaw+Z9u2IK+V69uruILy61ASA7Lt6BmZBvLbdiaiTvEr51
         CAhdCHQehdNlt30qKbMUeu60dixezO7EKey5bZjGCTRHw+sYGczjkK8oqwmSj2G2eWY1
         tE1Q==
X-Forwarded-Encrypted: i=1; AKwUvByACzB320dl4ez8deUTZUhptYj7ZuIzaaVtCbkgxxbp6+qn1HyQ/O5EApKoYBP3k1fgf7w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZrDdDMtoEvDaIetIM5lFz1Y+3GNv3fgiVBL3E0qAZhixU8jtO
	SrF5EDTxQ4497bOb4YhJwKgQpDqmZeydpSdgAp+yfvRK1i1wDuwfKZal
X-Gm-Gg: AYBFou1hAp5KtSgKkekBG5KwSq4Um60SNaYnCzlGv5EpOLTiquW5nhUQrBmSxaVKcCd
	r5p0KXvJ3SiW6eNfwRfLP/x5RabPk/NPDeVREMgNqaWNwJT7LNlcgaZsOEWAQ4eDIezl+fXu7ZW
	hB7LG8OvL6e2TJs4YaG8/cI40VzXwMroCFWV7oshi4iCkn9dlDAanBOksVYz7msVqgS8NARhmv/
	yizfAu95PON2xnDZp83ca9bqptTF8R4yH5dbuBN1COmdDMoU0aHxdAGOdPwXeGDCbXDnvCJFti8
	HgprAE2rYAf3rgZtR/gP22bjSJW85flse9aLBwWMb4+1X1svCiEvsvmxGiTW0F2pooXMPwwKPJf
	BtHzZXNr4QY4EPq5Afx3/5SNq2J1u4JQZXrXFxs+9MQgGNfobyd1uAByJK8vYPkUCezEa75Vg7E
	NaLf35QvOY0B8bbnXA4rDuz6PobensdNtpvdq71q9uX//N3tQG0Ajnb+CS9jf6khQ7qIputzi/P
	2VwXr3rHJzEn4g0zS4VjtOVqRW7zRy1/eWeY7PcTogbW150pQUjjTqzg8GdS2CAnlTcRL+lFr6D
	NxPyLnSQmcN8xFBFauLxDml1GBDj+GaTMPNA6eHFPCCXokaabaz+7Dn7rO1M4nbgBCSC8ghAAV3
	+GiALobI=
X-Received: by 2002:a05:600c:3b1e:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4a966774f22mr154204645e9.16.1793291220414;
        Thu, 29 Oct 2026 09:27:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6dfaa4ccsm148823f8f.39.2026.10.29.09.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:26:59 -0700 (PDT)
Message-ID: <5a1fc2ca-0ef9-41d2-a02a-a6023cbe09dd@gmail.com>
Date: Thu, 29 Oct 2026 16:26:56 +0000
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
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
 <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
 <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
 <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
 <xmqq33ttxw9h.fsf@gitster.g>
 <CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
 <xmqqcxswtqd0.fsf@gitster.g> <7438f8e3-4969-49a9-a0b0-41520ee35aa3@gmail.com>
 <xmqqbj8fm54y.fsf@gitster.g> <241e7bbc-7144-4ebf-af76-84a06a982574@gmail.com>
 <xmqqld7hafhy.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqld7hafhy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 17:42, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>
>> That makes sense. What should we do if "remote.cabal.refmap" exists and
>> "remote.cabal.fetch" contains a colon? We could just ignore that entry
>> but it might be better to error out.
> 
> Possible alternatives include
> 
>   - giving fetch with dst take precedence over refmap
>   - storing the result in two locations
>   - error out not knowing what is the right thing to do
> 
> I think the command line version, i.e.
> 
>      $ git fetch $URL --refmap='refs/heads/*:refs/remotes/alt/*' \
> 		refs/heads/master:refs/remotes/origin/master \
> 		next
> 
> stores 'master' as alt/master and origin/master, and 'next' as
> alt/next, i.e., takes the second option.

That's surprising, I'd naively assumed a refspec on the command line 
would override the refmap. It feels problematic if we cannot override 
the fetchRefmap config with a refspec on the command line, but need to 
use "--refmap" instead.

I think there are at least a couple of ways of thinking about the 
interaction of "remote.<name>.fetchRefmap" and "remote.<name>.fetch". 
The first is to consider that the "fetchRefmap" config is for "where to 
store the fetched refs" and the "fetch" config is for "what to fetch". 
In that case we'd reject values containing colons in the "fetch" config 
as any mapping should be done by the "fetchRefmap" config. The other way 
is to consider that the "fetchRefmap" config holds the default argument 
for "--refmap" and "fetch" holds the default command line refspecs to 
use when the user doesn't specify any. In that case we should accept 
"fetch" values containing colons and behave as if those values had been 
given as command line arguments. I'm leaning towards the latter, but if 
we do decide to do that, I think we should make sure

   git -c remote.cabal.fetchRefmap='refs/heads/*:refs/remotes/cabal/*' \
     fetch cabal refs/heads/master:refs/remotes/origin/master

only updates origin/master and not cabal/master.

Thanks

Phillip

