Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237026;
	b=NBX39WyXoVSHcFnJQF4uG1C1N7NTw9X9gd3c9h4q6Q1ETNfoLscCy30N2BJYSJNBAeh8
	 FfKYDluPOjYhVkzZYn+cualrvBhkoIytek3LVuc70a2rsc21JIQAxTy+ekIo4JKOPNz91
	 KnYbuDc55fo1/L/fFXxlKD2TcdvbEqwt7PUb16tVj+1uWCfalWFRAR7uMXlLL8Dy8pB9h
	 cjbSIvWy2EUpLJwm7x56oMHxzSB+WIX3o1RnfisAXdEidp+3qA1MHU5ZE9hCEG5iiEKZE
	 7x6sEIwLo+z6+WcKgFBE3qemKB4Kj98Txj9qqx71G7ESxYi9AWmxnnjnOctvjKOnfkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AayIHd7AQ/NyA99rv55CkOu4+HrkNHIa9jN6EX8W3g0=;
	b=f+iQfda1TLVkzdeo56oR2rkPUR/UqvtzN6ZxkMetixgC+7tIIfRk10ZUSyGu6rAmkvy5
	 Yqh0K7V/QfQeGShi5BZxjGngr3WZFdTE+R8sAs4ivNw2XmFKJHfjgIJh+OPBv0kBk3cdr
	 mphM9ZMt5Blorxj7xB8B+Rk7Sq5fSeWCSdYkVvXCT38qkSzmF/P0XUBVpjBQZIDe/kD2/
	 N8151zZqRPWmF36pkyEPtMI3u1F5LsHjIuvB5Sf9oVbpzVGRlXJZ53p8TwlO6nbT3BShR
	 xXjYdso8Uyd0JX0InduhqYD7Ihvwg9D+0PCZjuzMdi/IZtgOIvNiejnoQBPOvLBH4+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UFbhOq5s;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F52606A325
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F52606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UFbhOq5s
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4322d310e7so136044366b.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237024; x=1794841824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AayIHd7AQ/NyA99rv55CkOu4+HrkNHIa9jN6EX8W3g0=;
        b=UFbhOq5sDvragUbOYgtoZCO0RoSID2GQ0kyOFk/ZD75joDkE4qx+yMzQ/QWoagAG4c
         heg5Z06Fq8Af0e7Xt560Z7eY8wCFS2ztlj0B5SYFxel9rM+mYiw4QW5y2C4/fVNUg3xw
         akKuZFwPkWYMt/tNd2TBy7X8DGJq/5S8PCWftpK+bkJJy2MXQx54sozQZszib771/pyl
         qmdYiMqFKYp4FnoMcKhYI6dv9SMfulS/Msba3vRWkjq3V9M2aflaxKE/yI8GV70n0Ejp
         ztQnWz4LuulAoL7kVUFeg2NhfO/dCefFhWJqnPzYVCcIbRH7JxzK2KldUlEYseinhzTg
         c58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237024; x=1794841824;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AayIHd7AQ/NyA99rv55CkOu4+HrkNHIa9jN6EX8W3g0=;
        b=mprz4z7Dq0v6bqxQbu4EQ/azDa1WirGXD2pehp6D1sDg5eeldrb1tab36nJYkFwLnu
         Fr9S1lmKExTF0u+mvDBjLOu4/B+wgMc+5g5wiF1o/e2Sm74XgctvdLWNSaPIiNbyo6m7
         uLITVkzviDvJ1sN2kXUqG/dsJy4WnPnr3aV4ry3tu1u7GAD+1+SGWImz/O4eTcAB71uR
         Tofk8GWFrDSWU9WkJy46aZaufAMY54R7JF+vyyIcaVsNcmb7LlFlHHXAF7g8vtnzDH6p
         vAdrnYRoR1B6a15olzOoMp7h9UyXtZuOCknQ2D3IWdvUWVHVZ+eDI+Epk9O1tbTHnp3D
         wjiA==
X-Gm-Message-State: APuU4Z9YWUXU9ZvZyFALRNHwTRHvM4flfCEFrjtdyewPXBIszHBr886z
	R0uGSjNLyiEkqakDtxgyPOr6j8RSwT/F+J9DlLdZyjbUxFZtF1Do577P
X-Gm-Gg: AYBFou24bUJcwciZhXjculhUFNNi5aCJ36NWApFtucSx5JodHnEBgbjJ+uWS3ptQ5tw
	A/DVQt4BPwhFgruK8OaiCq4fxSJJIdTiKY44Iu2ZGxaI6M2Olcke7xF7FFR7oGuBiMqBSXRAASR
	gHcx0gQmFnF1pHGv49WBMBzrUkbLKsdYkyIX2wpuNWUSUNWi+Z8HMu/uuleYelYU7QseCwz0jwu
	9FZ2JO+b1LaZ3kUtb9qqS2w6ZyWCZQA/NfLFA6FZpDti6Eh+77Ii5wj23nKFrQ+3ONhLjcLeHnn
	JoFrEwE0JKRksr89g4u/6G47hYfcmEdGk8pnbP9w2QDkVQaRlPhiLnPYtP61VowoO+lnpHv6Xu0
	//bou8pvaSQ1ggfmO9lE9lCLfZygvVI/UXCF/aZ3pXg9qwm7uoumYuYtq/YkdUl9+L+oOhZc0ge
	p43Pe+3RcSXKmHSF9+xxdThpSyBSTp/yW+5wKwZAz0BEaPCbdAfgMudiuf98NBr2DeQW8c4D26a
	qpDRt2zoyRO8xvg/kJvKavc3HNVMF4bokegsYqcW4w1MI4IoxPfCriMbHvjOu04tDZYOZsBiFTU
	Igiiow89bfvlHaFNP6+VufVwL8EW1jNNoVmpb0qEZpxfzx1HiYhS5cJoeDNN2ECcuxIgNqFAmh/
	MwKsPuA==
X-Received: by 2002:a17:907:c1f:b0:c43:bf29:1517 with SMTP id a640c23a62f3a-c4d6d4a202fmr290177266b.12.1794237024257;
        Mon, 09 Nov 2026 07:10:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d52c49sm185320166b.12.2026.11.09.07.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:10:23 -0800 (PST)
Message-ID: <3b97401f-5579-456e-ba62-c7a0fdb88d23@gmail.com>
Date: Mon, 9 Nov 2026 15:10:17 +0000
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
Subject: Re: [PATCH v4 2/4] doc: for-each-ref: say how to read %(worktreepath)
 safely
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
 kristofferhaugsbakk@fastmail.com, haraldnordgren@gmail.com
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
 <20261102182930.3511-3-me@jaspermayone.com>
 <CALnO6CAjWNsj=X4fp5rst+yCTo2FNVH6g=xt4V=b+pwG68gVXg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CAjWNsj=X4fp5rst+yCTo2FNVH6g=xt4V=b+pwG68gVXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 09/11/2026 12:36, D. Ben Knoble wrote:
> On Mon, Nov 2, 2026 at 1:29 PM Jasper Mayone <me@jaspermayone.com> wrote:
>>
>> The path that %(worktreepath) gives can contain a newline, which
>> breaks a script that reads one record per line. Say how to avoid
>> that: use a quoting option, or end the atom with %00 and look for the
>> NUL before the LF that ends the record.
>>
>> Also say that only one worktree is shown when a branch is checked out
>> in more than one worktree.
> 
> I was under the impression a branch could not be checked out in
> multiple worktrees due to possible races from each worktree performing
> updates; or at least, that the porcelain would refuse to create such
> worktrees.
> 
> Has that limitation been lifted recently?

No, it is not encouraged, but it is possible to checkout the same branch 
in more than one worktree with "git worktree add --force", or "git 
checkout --ignore-other-worktrees". Those options have existed for some 
time. It's also possible to bypass the checks by using "git symbolic-ref".

Thanks

Phillip

>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>> Signed-off-by: Jasper Mayone <me@jaspermayone.com>
>> ---
>>   Documentation/git-for-each-ref.adoc | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
>> index a7b31e8aaf..9247737aa7 100644
>> --- a/Documentation/git-for-each-ref.adoc
>> +++ b/Documentation/git-for-each-ref.adoc
>> @@ -183,7 +183,12 @@ but if used together the last option is selected.
>>   `worktreepath`::
>>          The absolute path to the worktree in which the ref is checked
>>          out, if it is checked out in any linked worktree. Empty string
>> -       otherwise.
>> +       otherwise. If the ref is checked out in more than one worktree,
>> +       only one of them is shown. The path can contain a newline, so
>> +       use one of the quoting options such as `--shell`, or follow
>> +       `%(worktreepath)` with `%00` and parse the output by looking for
>> +       the `NUL` after the path and then for the `LF` that ends each
>> +       record.
>>
>>   `ahead-behind:<commit-ish>`::
>>          Two integers, separated by a space, demonstrating the number of
>> --
>> 2.56.0
>>
> 
> 

