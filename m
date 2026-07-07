Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6F70808
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417702; cv=none; b=PyaUC9BzOrISN4VyFQb89KqOTWoJhPZiGT0j6bm9xsoBfNwpPYZ5VVf9x3Li04PuYEtSaVu/rcbCgTT+kRFrmBh4Z7XmVVyL1kouCH343Jxof4+EE9jmF1o21I8VrIQ4vM8O8VRoK+SQxZD9fua9NUDTvcK89/G2MFD2aumHK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417702; c=relaxed/simple;
	bh=AwRi0vIMeNow8sgjUpqY0miEFfbQKXqXaDWjVrz0qNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIuz7MRu06OPBEw7t++TXr5rBwpineGqjcIRsfby7Qbij80FdmkiN1NELmb1SBnk3dALqDmb3zAPFQp6vbSTzQoOLxMbiDm/coBrk5WoBI5s/vvrVK9zyI+Y6K/TTbQa8mxIPqLWodoE36yzUvtc6Qse7tGu70UdvFFPHCtxGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o97s/EJ0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o97s/EJ0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15b1da6b82so40777266b.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783417699; x=1784022499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1FSg+q6ZcQo/uao2qA/ANfhGUfVriUyxgJ8XtDGVE6k=;
        b=o97s/EJ0FA36vick0ZNUJ8sKFPDm9AfOHyInudvTpj2lQAkOYrxvejSvxS8hFL/cLY
         dTMdMkl3L/6JwJreWnfQqFa+UcRMN27PBEzguNwTRR8se0P9xh+aYTW40tvrVdDnXJ06
         G/UHRELY1UYquEy6Ul13WEfRWyx2e2gGXYMt9shbtcSPVH3MOKdclJ/xHO6iqiNxVmNw
         gTskMnoq7AyHs7krWmTEjcKjLdCKm22AIx8mU5Ndbtm8MKu77wtTsNEK+1WrfOVD1EUT
         KIiYBPfBUajqEndiZb7hCbZdLIEYxhxH6TiFItTN7IgKiXVgicmAQJ2LCOrnwntPBkjU
         aCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417699; x=1784022499;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1FSg+q6ZcQo/uao2qA/ANfhGUfVriUyxgJ8XtDGVE6k=;
        b=FaDl5aL00zd2+/ab7Gs4wFzeDjVJs85VlDgbkyU/KGVtQzCVq99Te/wRoRSk5yWErD
         qROnCsARWnYmmRPlrvvE7aYItFwx/APHVJEoldIuc0uuA4k+BRZyuV4ErrL0BmQ+9Eqr
         cs56eCbTPwjTqLVF48Rk/P9oATSI0CuUrvRNV4dCtVsrMPuRRVgDwS362S9Ms8p8IZm8
         7/8dsVWDilZPsgTXAV6IU++Db9blGRh5E4ejBI4DnJ6AnFccLD+OugWnwzKnU3emPjpG
         cR00Jaax5duJdyw7xDbyUHWDz1/eo62uSJ4IL4NG75WHIsETo6rjXUl4wJhFlyfTJM4F
         B24A==
X-Forwarded-Encrypted: i=1; AHgh+Rp+aEFk97m+jJ/ykMaIEFUt53HgKp1dazVagEY0NTahWTwVg1k5eIugJ6qT1WQxnb9an18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8wnDEdrOAulprXJceXt18Us7lOVuqgQe6e4+XFjQriUcNN7a
	LjrSuix625dA6EMKgV2r3Ev6wPUQ69aVgWoyfDGbDI8l0VQheNsxrZoV
X-Gm-Gg: AfdE7cnwx2Q3heEz2H5cqBthCRFWqT9U/b3SfI5aTnXzTyAt1QW7GG3VVrzdcMv6wUb
	Dnhwnq7TskdcTY6VuhuDl1Q9q7VH3OeyXwK81MJX0w3Ll7ZdgVtYMOVHVfmV01ZiHBei2QDvOEX
	sG2CNVhlFhqfpYV7CHjYya+sEz6dNqMvVDH+J4TgTK1AZyLMvaiAzS+Jh+hZcKxEKUnWQhtZRyg
	OKoDaa5PV1aBqDj3K0Pd7AHGnrwyzh/kSzk1bbiCyfdtgH7c0MqIKBkJzG2gK+3M095pLcjxziD
	OL8IsMeZV00rWy62FmhEfWKuOBFD9fpUo0PgilBRzPaKz8/Q7iKyCUKLKy8OaTldiEmduDKd22l
	1+mwmCFe5eqRECHzbKurCgRnWu3zuxf3IT8l2MDPxfyxRLNyjuIGv+l3nkhaqEW56y/HIta+4td
	NvpQjR5q7sMqM45LtFwq0/ZAEp3AkJ2GcnAVFMew+7fD2D3MI2s5TnxTMCRYICZC/QuP4=
X-Received: by 2002:a17:907:3cc2:b0:c15:b48d:caa4 with SMTP id a640c23a62f3a-c15b48dfd33mr77867266b.39.1783417698806;
        Tue, 07 Jul 2026 02:48:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad882289sm96074766b.26.2026.07.07.02.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 02:48:18 -0700 (PDT)
Message-ID: <40add226-d986-409d-9d9e-d14a56e62f27@gmail.com>
Date: Tue, 7 Jul 2026 10:48:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 0/5] history: add squash subcommand to fold a range
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, Matt Hunter <m@lfurio.us>
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
 <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
 <5a5dbfae-4525-4b00-9e44-936be606ee85@gmail.com>
 <CAHwyqnVxa34iGmFvL4Ujrc2dTbmtF+7j7b=q5v95y=-pzUf0NA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnVxa34iGmFvL4Ujrc2dTbmtF+7j7b=q5v95y=-pzUf0NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 07/07/2026 08:51, Harald Nordgren wrote:
>> There was some discussion [1] about making that the default and renaming
>> it - was that overlooked? If not it would be helpful to comment on those
>> discussions to explain why you don't think it is a good idea.
> 
> Not overlooked, but I side-stepped it because the discussion died
> down, and yes I don't agree that it needs to be the default. I could
> have mentioned my thinking in the cover letter.
> 
>>>      now builds the same editor template git rebase -i shows
>>>      for a squash (a combination of N commits banner with each folded message
>>>      under its own header) and follows autosquash for markers: a fixup!
>>>      message falls out (commented under a will be skipped header), while a
>>>      squash! or amend! keeps its body with only the marker subject commented
>>>      so its remark can be reworded in. Only the message text is affected,
>>>      every commit's changes are always folded in.
>>
>> Rebase re-orders commits so that fixups immediately follow their target
>> - do you do that here? I think that is very relevant because here we may
>> be dealing with several different commits each being targeted by a set
>> of fixups and presenting them mixed together will be confusing.
> 
> No, I'm not doing that now, but I can take a look at that.

That's great, it is fine to punt things like this which require quite a 
bit of work to implement to a later re-roll but please be clear in the 
cover letter so reviewers know what to expect.

>> I think it should allow squashing a bunch of fixups together though. I
>> thought there was a plan [3] to refuse to squash a fixup unless the
>> range included its target.
> 
> I attempted this with reject_fixupish_oldest(), assuming only the
> first commit needs to be checked as not being a fixup/squash/amend.
> 
> But now I realize that maybe we need to check all of the commits, and
> also check if the target is in the range or not. It just makes the
> logic a lot bigger.

Yes it is a bit more involved. If the first commit is a fixup! then we 
should allow the user to squash other fixups with the same target and 
take the message from the last "amend!" commit if we see one. If there 
are other commits it the range then we should refuse to squash as you do 
here.

If the first target is not a fixup then we should refuse fixup commits 
whose target we have not seen. As well as exact subject matches "git 
rebase" accepts prefix matches and "fixup! $objectid". I think it is 
fine to skip the prefix matches to start with here. The $objectid 
matches shouldn't be too much extra work and I think they are worth 
supporting because if I remember correctly git-gui creates them. Another 
gotcha is that fixuping up a fixup prepends a "fixup!" to the subject 
line so you need to be able to handle things like

	fixup! fixup! the real target
	fixup! amend! the real target
	squash! fixup! the real target

etc. Hopefully looking at the code that handles fixups in the sequencer 
will help

Thanks

Phillip

