Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390222;
	b=bjWI8vHDBK67YMxKI4W7F5HeW0cJYZW+Lg+jq29z3rkFP9pmHuHP+ZXVA5tJE6scJwX5
	 yRdLIwt0HQmHFXzh4O0wTsbIciMgcrEU+pgKIqNPkGqJgS5p5sOw8gCFHs7vXT09W9jsO
	 d5BASg0sRgElonfPFfy9X8DHaHaEuE65a4zoXK4yKaVg1Ds3nf2hEZra585KaZilR9a+8
	 78zdzlnFNoG+DkSHUoXpocnX3eujvaRlKxQmcnkuqDmflrl1CWj1BXMTO8J1ao4wKcfy+
	 vlrN4JJj81sQQ6CosxDB7jYAI/A664vb+3Ed33blLiUGnnyDrxT/0wu6qd2A/yRh6CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=j+UYd6zLc+XveCeS3Q9V2e2r3mpxpqJD7iW/b55f4GY=;
	b=Hn3TkWovrx6jHmsP40CXQyZ8+mhdx58yXjHGtQqBjdmM4cCz3CCoL4GpsHxxF9prO2gS
	 Gv+wCGzmK6KMcrY03dxeW/oGf2phqnwh8biE5tJIu38f4Wz1sp3jY+cbiAWCEuMtT6yh/
	 iyCCWATia2ySPm04Ks1DojPRBfpc0Z3E8hdRNF0jDHEXLcl3d249RKRvgQvUms1kxoOuR
	 VYEJeysiMlGH8/bWz5I0TkleEb4iVNY9e6Eux5JJGwf3Iv8+ovU5LwWVdsg+OC4LKNK23
	 tnhQ5zNhslae+Xi3PuiCgZN81Z6avWEwQxxAuDaesE1U399Z0WqelKh95Pg+g60zYtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9CA2qT5;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CD606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 19:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C8CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9CA2qT5
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1931ff67a29so86318c88.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793390221; x=1793995021; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j+UYd6zLc+XveCeS3Q9V2e2r3mpxpqJD7iW/b55f4GY=;
        b=D9CA2qT5zvQdjjpEFQYXG5c0jM1X2xcQvCiG9DfCM2QLEPB3za7awa/DVHmPXN9IwR
         +qTrfVPZ8lF2bEccKjrs66XfdO7vpLHNEIgo3UyCTZvqU4rb3wgTAs1pfLO8zvxYxaa7
         niBYi8ZDtvdeBnVt2tvDdsnV0zB3GFJuZeGeUqiZZQ5ZYpnuOGvn9whED8cgJPeucx+k
         WqT2TFaTPFQXQlCMq3hQ3cV6N/jswlIF1Evlywvl+LXAZmo2vzc4L1zJVvGHQdEjaIxW
         RvAeZ4a16ZkhlwE0yXBJyGpFypavyWIxCCF++N09EHtkrsarQn9nGS4NJaJRJeqqVHoR
         ZIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390221; x=1793995021;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+UYd6zLc+XveCeS3Q9V2e2r3mpxpqJD7iW/b55f4GY=;
        b=1vY8SVpC4pFscnAFgPJ1bKYn3sbPjuXhqLr4cmA+eIRh0E0DmT5qJCsSBRhH0gsbC/
         ghm7Ms2acdSRhlHJTcHQ14EKIzzNguUd39LuQv7XwkHmd6mxFHI2xmnmLN/NarFV6r51
         VqEAMZbZONt33RmF/mpMM66MIEoYq+EraWCxnGChIVNYgDv+M4hhdINuZdZOCRhgoKL+
         WMLHzup766KKqlb3RzMm5w5Qqcg01InwbrZYoUg1cbhnrmpxsAiPFs0xMd4qvQugXLr2
         EgUaXcuTmACBnNjRvaAAgLBfmlwu85c8B4CfIJDjjWrVqmSAzN81V5MhqyI0ThKynfCx
         ETpA==
X-Gm-Message-State: AFq9FYKbfwI0U7v0r/j1dOYW3lwu1zR16KudSN0FRTYmL+GkqlsnzKRB
	70IStrq3LAeU4mS4KqQLUgYWcCGBFF6ctWNN/NM4eWgUA+9hcjSPAloPXngwUsJQ
X-Gm-Gg: AYBFou1pBENK/b+YTGlIlzsU5FD27OjEi6wpMh01magWI3lMm3jrngGNg9CjSqyDuPI
	jquTyF5fAJlHdenjxIDwghZlIrYoSG2XWKPMV0wsGgnPuyFu896y2aQpg1+5fs1Q/f9GvEzDfXp
	nWDCVHBn+BGlEB7hYI6XDL+c1HF8h2eFZE5JPGnYjmBrbPhcdjnpxs5kgHqFpxi7ksp1FjPVb1R
	FbPCRfAhNrY7vOsYwcbb72KmSx9JA5EUQlB1HHACqDnEYRlI16MPYJ8K5hJFvYDrr0hmAl14Tzf
	lxHC+Dvy6yQJaJi6KAJqtKTCPyq7r5XDFYjRzGtuhPTd0vTTmJqy78QLF+17xDx3yryzS1Xo5Of
	Ei2E8oa44KBLBV+SGxEdOAfulolnfY6DtgTluTXyLumRA6fzOQlbK1PFyHq6cMnRSQVayb4GxfX
	Ce4YU8zbjOLo8UL/g/yCfn02VBsYCqHHmxHVK5qC5aSBUXTSFg+e4SGdzeDbED2RVx7WMqVlw3A
	qcCbj1WIy6Y7uQS5vE7BLiw/PfhGMFg6S6D64vPkfugHSpZdRyZISQqxFfihH1PUQfyQD0PgxYh
	skvvr+HlFVpcR//+2xmq2KFgAUcYLgWG
X-Received: by 2002:a05:701b:2910:b0:184:5f2e:aa52 with SMTP id a92af1059eb24-1ac5a0b4358mr4190230c88.16.1793390221004;
        Fri, 30 Oct 2026 12:57:01 -0700 (PDT)
Received: from localhost ([50.168.54.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm12468124c88.6.2026.10.30.12.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 12:56:59 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 12:56:58 -0700
Message-Id: <DMIFRWWLOTMP.3HVH81PKHBTKK@gmail.com>
Cc: <git@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH] notes: do not drop notes written by a concurrent
 process
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>, "Farid
 Zakaria" <farid.m.zakaria@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.22.0
References: <20261028-fz-notes-concurrent-write-v1-1-3d513e1fdbb7@gmail.com>
 <3c4f3793-07d4-47c7-b503-13a6ae567147@app.fastmail.com>
 <xmqqbj8c2wk8.fsf@gitster.g> <DMHMEOZ1ZXRI.TDMEKTJ9W325@gmail.com>
 <34b5c9c8-74d6-4d49-93cf-1d1909d56e9b@app.fastmail.com>
In-Reply-To: <34b5c9c8-74d6-4d49-93cf-1d1909d56e9b@app.fastmail.com>

On Fri Oct 30, 2026 at 2:21 AM PDT, Kristoffer Haugsbakk wrote:
> On Thu, Oct 29, 2026, at 21:56, Farid Zakaria wrote:
>> On Thu Oct 29, 2026 at 11:25 AM PDT, Junio C Hamano wrote:
>>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>>>[snip]
>>>
>>> Or possibly
>>>
>>>[snip]
>>
>> Your proposals for retries when possible make sense but I may leave that
>> to you to implement.
>>
>> I felt confident reviewing the current patch at it's current state
>> (AI-assisted) and I do concur that it's a net-positive change in the
>> interim.
>
> Use of GenAI should be disclosed up front.
> Documentation/SubmittingPatches, [[ai]].
>

Please consider the thread my disclosure.

FWIW I did read https://git-scm.com/docs/SubmittingPatches as of today
and I don't see any specific mention of disclosure. It might be a good
idea to make that explicit.

I see no mention of special trailer or mention to disclosure although it
does mention rejecting anything that looks like "slop" which I hope this
is not -- I went through the patch and the failure.

If I was looking at the wrong document, please point me to the right
one.
>>
>> (I guess I could try to implement the retry logic - AI
>> assisted if you like)
>>
>> Would it be OK if I also suggested the other two bugs (+small fixes)
>> I found on the mailing list (with the same tool)?
>>
>> They are:
>> * Similar race-type bug for credential-cache leaving a stale daemon+cred=
ential
>> * fsmonitor daemon keeps running after its worktree is deleted or moved
>>
>> Both patches are of similar size and complexity to this one, with a test
>> case.


