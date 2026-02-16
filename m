Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A61330B2C
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258742; cv=none; b=M2AYxa1YFL9Um5+bENx+nZFMzIqwjWDZ9JkzDY1qg6cV+NQbbUUBa40nJmLUaX9w1XoBuIZkmWpVPsPMDL2+843wYb/hfhL+iUXKTJ/qcEEl0KhipaMqioyC3eBaWAa1iGrN6WI9NlldtnLJHoMYP5DEtTexETnqjPazLJ+9zqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258742; c=relaxed/simple;
	bh=ZpTb5h6NjemebaqVyzxUsprDaQd1++uSFBwcBy3HWgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eidiHhV7DioWDkqYK57mZjw/4FnmA68kSTQVKW/e5SSUsLNLeUOWAlwTwwpqV38vsuqY4bJsx3aAeFUDix+T9dC83JUxbAralr0ZuO4MHXSm18RBAbG+vIaee5h+wDXsyApq/yhkuLvfX9r7ke97WsHDWJoKamM3lQtLdCRX6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNmgJ8FV; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNmgJ8FV"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b883787268fso403310966b.3
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771258740; x=1771863540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IZm8GXnuf7cuWCGO949Pmi8nVevRFMMhUJykFpqqweg=;
        b=jNmgJ8FV80dC7/zzUjtXWg04azFZE89bvU3KVvsvYbOzDWdl8NTqFoO/sKBq/UhyvH
         silGBNwQaxduUTsklz7hcJnDChQC3srnd1noQGE7ir9gJyFmQeeIcoo9LRKNSguWz3b+
         56MzAgQz7+dKVXJXka5AoqteOAPCc3w9VWCoYQs2PKVJljErHA3ghBvLIzi/T0PgsyQP
         E/RtUF66qFHCu9LIj/mabkkzXhiVKf2BSOw/OABC0ravQz8m22GDyOo7UoKdaPEvVgUo
         yDouW6FpMIdoJ3S5/lSkrJTyeraALHiJScQNYTwRhYvxOeT0w5THYt2pomHFxN6aiQhW
         EsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771258740; x=1771863540;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZm8GXnuf7cuWCGO949Pmi8nVevRFMMhUJykFpqqweg=;
        b=EpC1CWUL2k3Co4Fwg0/YIcaXwUnLIsh78lnigFL8gF5F3BbR8UCl3rNeBDeNavIrMF
         ZJnHkzHsbH5ZYIlNus8KpCprDNxV5DnfBbV/rUqisGcw9cdKkw9TTi6HjNRqmoqU6fnT
         v/bxL/C1VkJxWu+VX2bTfw/R0A35FFPTzFTuReM/rH1wyMtAkTvgvYDbP3e5ajEsBoKN
         7OU2wzogZQ6il83hLzEjnMhqYXedIZ3W9r4UnPycafXOdcgcCX9dx4ITjR6+jlenYfic
         m3MOtcD2eECDdvxpSTggKDcPwKp3qmMVjJIfUBg1oYqmmRMTcOMANIO4y98T4cpxFfzr
         d7fg==
X-Forwarded-Encrypted: i=1; AJvYcCXHLDVwhh4LwwtGK7Vq8Hoc/3N7zciYo6ZlMKxQ0qqzXoxGm4aTjix2C2udVLnqOEBLlIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwMOnaUK6dgk+T2C1FkdLEAKqzMsgdV7UhVoDpor2N5XR1K4L
	LeQmJ248PGzsJKqVwlnENPh1Tv+dVmU5dPIFibrPiGNG1RicSXFOnHItkqwL0EeV
X-Gm-Gg: AZuq6aLkz9Ocwt8/nIc3w4KvGqN7jlAya/f2IuA+mlmx0Hl7TZ77ESjosJnCls2y27O
	ilrp53lP61wkYxMFBMLWkH0G9gBU+d6F8Uu3NK8BpItMosHt1wVRDWjt2Bsyoirl0YhAuY/M7YZ
	xaSfEUekK5hBM4UDu4RKOGH+k82mKAuBQ9EH7YGx+0Q2yyQe3nw2GUkH82Skc2yaAzHsSo4Ms3i
	5Y1Cn8zDqIpPNBP5soOwt9GIPKKTL0e4WVBiTveUTMgNwETyRYIwQKyarRGN2QgTRgV4kP7AllE
	8GosEzlyCKX0M4xNMbGU9xVLY2vUN1EqYZ/wN+J4WKIhrtPDAJDvFUjzf3kgzaRdQvOTXma9lFV
	Lx08aCqF3+dTyrycjVUda+Bv8aiuXfReY/LiiB0Mf3gyBwRPR/1Bz4UziwxiX3CW9yeKdkLntK3
	+G19Cn02umN6lLBOB+WDlrIHyCVeCk8tvNvNuaquRgfto/tCaor3mtPA8Fg/SfocBse4K0lLb3m
	2DZOA==
X-Received: by 2002:a17:907:2dac:b0:b8f:ad62:edc1 with SMTP id a640c23a62f3a-b8fc38f90f5mr437001766b.7.1771258739513;
        Mon, 16 Feb 2026 08:18:59 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735d66esm263375266b.4.2026.02.16.08.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 08:18:59 -0800 (PST)
Message-ID: <66b0f03a-36ab-4305-814e-6d964f5d33c4@gmail.com>
Date: Mon, 16 Feb 2026 16:18:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: sunshine@sunshineco.com, gitster@pobox.com, karthik.188@gmail.com
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
 <20260215090815.46544-1-shreyanshpaliwalcmsmn@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260215090815.46544-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/02/2026 08:56, Shreyansh Paliwal wrote:
>> I've cc'd Eric for a second opinion
>>
>> On 13/02/2026 22:29, Junio C Hamano wrote:
>>> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>>>
>>>> diff --git a/path.c b/path.c
>>>> index d726537622..4ac86e1e58 100644
>>>> --- a/path.c
>>>> +++ b/path.c
>>>> @@ -408,9 +408,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
>>>>    				   const struct repository *repo,
>>>>    				   const struct worktree *wt)
>>>>    {
>>>> -	if (!wt)
>>>> -		strbuf_addstr(buf, repo->gitdir);
>>>> -	else if (!wt->id)
>>>> +	if (is_main_worktree(wt))
>>>>    		strbuf_addstr(buf, repo->commondir);
>>>>    	else
>>>>    		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
>>>
>>> This is curious.
>>>
>>> We used to treat "wt==NULL" and "wt->id==NULL" differently.  Now we
>>> use repo->commondir for both.  For the primary worktree, it ought to
>>> be the same as repo->gitdir, so it should not matter, but makes me
>>> wonder what the reason behind this difference in the original.
>>>
>>> We have been assuming that wt==NULL and wt->id==NULL both meant the
>>> same thing: "we are talking about the primary worktree".  But the
>>> code around here before this patch seems to behave differently.  Is
>>> our assumption incorrect and are we making a mistake by conflating
>>> these two conditions into one?
>>
>> My understanding is that wt==NULL means "use the current worktree" and
>> wt->id==NULL means "this is the main worktree". That would explain why
>> we use repo->gitdir above when wt==NULL and repo->commondir when
>> wt->id==NULL, as repo->gitdir is the gitdir of the current worktree and
>> repo->commondir will be the gitdir of the main worktree. If we look at
>> the code in wt-status.c that's passing a NULL worktree it wants to know
>> about the status of the current worktree, not the main worktree.
>>
>> I think that we should add a new function
>>
>> struct worktree *get_current_worktree(struct repository*);
>>
>> to worktree.c that constructs a struct worktree using repo->gitdir etc.
>> The worktree id is the last path component of repo->gitdir when the
>> repo->gitdir and repo->commondir differ, otherwise it is NULL. Then we
>> can use that function to get the current worktree rather than passing
>> NULL when we call wt_status_check_{rebase,bisect} from
>> wt_status_get_state(). We should also think about whether we should
>> change wt_status_get_state() to take a "struct worktree*" rather than a
>> "struct repository*" instead (I've not looked at the callers to see if
>> that's sensible).
>>
>> With that, we can gradually clean up uses of wt==NULL in the rest of the
>> codebase overtime and eventually remove support for it from worktree.c
>> rather than having a big flag-day patch. I don't think we need to change
>> uses of wt-id==NULL.
> 
> Thanks a lot for clarifying. This helps solve the doubt regarding the
> different usage of !wt and !wt->id in strbuf_worktree_gitdir(). I realize
> we have been under the wrong assumption about what wt == NULL represents.
> 
> But I still have a few points where I’m a bit confused,
> 
> If wt == NULL is meant to represent the current worktree, then what role
> wt->is_current plays in the present implementation, and if they both
> represent the same thing then wt->is_current wouldn't make sense if wt is
> already NULL in the case of a current worktree.

wt == NULL is a shorthand that callers can use if they don't have a 
struct worktree to pass, it does not replace wt->is_current when listing 
all worktrees with get_worktrees() which returns a NULL terminated list.

> Beyond representation, I’m not quite understanding on how call sites are
> logically differentiating on whether the intent is to 'operate on the
> worktree we are in' or 'operate on the primary one'.

We're nearly always interested in the current one. The primary worktree 
is special in that it cannot be moved or deleted with "git worktree" but 
git commands generally operate on the current worktree and occasionally 
check the state of other worktrees (for example to avoid checking out 
the same branch in two different worktrees).

> And I think if we included both in struct repository (r->main_wt, r->current_wt)
> so accessing either of them would be a whole lot easier and also would
> prevent confusion in the future.

It might be worth adding the current worktree (or probably the worktree 
that the struct repository refers to) to struct repository in the future 
but I think that is outside the scope of cleaning up wt-status.c

Thanks

Phillip

> Let me know what you think.
> 
> Best,
> Shreyansh
> 

