Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFF32C6A
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="LViAeTr3"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F761FEB
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 10:02:58 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c320a821c4so6378557b3a.2
        for <git@vger.kernel.org>; Wed, 08 Nov 2023 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1699466577; x=1700071377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xd5A+Y/YiWlqLsHXgQHUhJcimhHhJR+alFtFPn/YVJc=;
        b=LViAeTr3YSMXAe5+duAPVcpDjOVlHlEQxcQCfBKdTEb4C7fALb5PskqQR4Y2oBJ71U
         n0DG0QXqMEaVKp1IcdjFYSEetlBA7Zo67ig2tnQKM5x+9MOiNJybHXoezSWN2VhBleIg
         L8rVsyqx+1TRFkgnCnRwMuJJRlbIhlb+UL5RXloGDczISCqzSjmVNfCh7UfwhqtKewum
         OT2ilv8nM0hm0C6y/OdmhsQQm16nORdaxO/SjqMmOWr1Fiexg0Qc+kA/7LcRmIpW7qUa
         JqWsBRu1nqhLFsB0ZX02aYV2t6oUy83nmwIEO5H0nwu13kpL0MgCBG8RmrNRoDwc2rAj
         S+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699466577; x=1700071377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xd5A+Y/YiWlqLsHXgQHUhJcimhHhJR+alFtFPn/YVJc=;
        b=NwGO8bHuxuoZLQrb10XNFpHko1LchxufNncduElOSfGekuYcXPRIT7N303w5KuNI2e
         jGcYdVnYkqXQKr1gI9RpPZyZzHyDgVbyvY9rCsAYo4gqN/6s7KoHsiy38vEYg85WfnDz
         Z2izdmOaWuOujmhAMuwnqYm1gJWtIo8/sSvWWM6dzIlE3AOTGDGuyrObMGCdIf9zvmRB
         vry/JU+va3FmA+N4vXpMMLQuDmAiOsGsLb5fPKuYJWRHOnD9AFFoRFGZR/TbAnXDmvYX
         7K8+EleySNHkJSK/3+5tz9gpqu5qa1mkYB7dz7MkYWZ5+cZP+4Rkz0q1IdFfNQb1dVni
         8psA==
X-Gm-Message-State: AOJu0YyvHIKT7p/0HJRBzJbC1osF7mQyVIc3P5EaftzFfal8Xg05wMlZ
	dnAsZMZDOAo87wAha2MQw1P/adYL+otrg0X7iA==
X-Google-Smtp-Source: AGHT+IG4Ctf+nZrOGie1mfewG1oNuNiKsQr6tDKHV9JqN0AjheoDbOgX957MtUuTyVP9X6AfKv0zow==
X-Received: by 2002:a05:6a00:1249:b0:6be:4228:698b with SMTP id u9-20020a056a00124900b006be4228698bmr2685309pfi.20.1699466577535;
        Wed, 08 Nov 2023 10:02:57 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id j16-20020a056a00175000b006933b69f7afsm9290185pfc.42.2023.11.08.10.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 10:02:57 -0800 (PST)
Message-ID: <898d3850-b0ca-485e-9489-320eee3121e4@github.com>
Date: Wed, 8 Nov 2023 10:02:55 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] for-each-ref: add option to fully dereference tags
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
 <ZUoWWo7IEKsiSx-C@tanuki> <cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com>
 <xmqq4jhx7x8l.fsf@gitster.g>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq4jhx7x8l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> I think `^{}fieldname` would be a good candidate, but it's *extremely*
> 
> Gaah.  Why?  fieldname^{} I may understand, but in the prefix form?

'fieldname^{}' seemed like more of a misuse of "^{}" than the prefixed form,
since we're not peeling "fieldname" but instead getting the value of
"fieldname" from the peeled tag. But then we're not dereferencing
"fieldname" in '*fieldname' either, so 'fieldname^{}' is no worse than what
already exists.

> 
> In any case, has anybody considered that we may be better off to
> declare that "*field" peeling a tag only once is a longstanding bug?
> 
> IOW, can we not add "fully peel" command line option or a new syntax
> and instead just "fix" the bug to fully peel when "*field" is asked
> for?

I'd certainly prefer that from a technical standpoint; it simplifies this
patch if I can just replace 'get_tagged_oid' with 'peel_iterated_oid'. The
two things that make me hesitate are:

1. There isn't a straightforward 1:1 substitute available for getting info
   on the immediate target of a list of tags. 
2. The performance of a recursive peel can be worse than that of a single
   tag dereference, since (unless the formatting is done in a ref_iterator
   iteration *and* the tag is a packed ref) the dereferenced object needs to
   be resolved to determine whether it's another tag or not.

#1 may not be an issue in practice, but I don't have enough information on
how applications use that formatting atom to say for sure. #2 is a bigger
issue, IMO, since one of the goals of this series was to improve performance
for some cases of 'for-each-ref' without hurting it in others.

> An application that cares about handling a chain of annotatetd tags
> would want to be able to say "this is the outermost tag's
> information; one level down, the tag was signed by this person;
> another level down, the tag was signed by this person, etc."  which
> would mean either
> 
>  * we have a syntax that shows the information from all levels
>    (e.g., "**taggername" may say "Victoria\nPatrick\nGitster")
> 
>  * we have a syntax that allows to specify how many levels to peel,
>    (e.g., "*0*taggername" may be the same as "taggername",
>    "*1*taggername" may be the same as "*taggername") plus some
>    programming construct like variables and loops.
> 
> but the repertoire being proposed that consists only of "peel only
> once" and "peel all levels" is way too insufficient.
> 
> Note that I do not advocate for allowing inspection of each levels
> separately.  Quite the contrary.  I would say that --format=<>
> placeholder should not be a programming language to satisify such a
> niche need.  And my conclusion from that stance is "peel once" plus
> "peel all" are already one level too many, and "peel once" was a
> very flawed implementation from day one, when 9f613ddd (Add
> git-for-each-ref: helper for language bindings, 2006-09-15)
> introduced it.

I can (and would like to) deprecate the "peel once" behavior and replace it
with "peel all", but with how long it's been around and the potential
performance impact, such a change should probably be clearly communicated.
How that happens depends on how aggressively we want to cut over. We could:

1. Change the behavior of '*' from single dereference to recursive
   dereference, make a note of it in the documentation.
2. Same as #1, but also add an option like '--no-recursive-dereference' or
   something to use the old behavior. Remove the option after 1-2 release
   cycles?
3. Add a new format specifier '^{}', note that '*' is deprecated in the
   docs.
4. Same as #3, but also show a warning/advice if '*' is used.
5. Same as #3, but die() if '*' is used.

I'm open to other options, those were just the first few I could think of. 

