Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DE1E494
	for <git@vger.kernel.org>; Thu,  2 May 2024 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629051; cv=none; b=eSGG8Ot64lBii90/Wk+98Wm3FlkM3twgz4boSEDJ1NxRIkQX1jPMf8jHDJx6B1vE4IKcZ7OIMenX8ha8vom+YV9d2MCimwPthwssKxOAb79QDPzmPvaIivdtOx/m72Th/xWTN/nhExH1AJftuyeKG0NuW3WSsCjublH/yJ/Vkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629051; c=relaxed/simple;
	bh=D6W7fZdt6sz7vlSZuMO5xNfkL6BpF7cyLu1fz6rQvGk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQy5wWG08WYIbajEwusy7O+9hVFD8qi/OEFT1S1Rb8wezxSHM2aNY7UbUTJhtV6lxSKivEktAjh16PeXELDalPguVbUwRTE8KKU5RUytsstz9Su4W9/hwJya/mKjYScLeKKz9YDLWtk9WyiXf3s61eGpBBNpFX9bRJLS4V06h34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8txYIdb; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8txYIdb"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6eb86b69e65so4418665a34.3
        for <git@vger.kernel.org>; Wed, 01 May 2024 22:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714629048; x=1715233848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi1YoIO20lZfI3P03MeGlqmMPgbcDb8GllYor4Tbssg=;
        b=i8txYIdbsDO+o1z5GInNHl4fLMoLhVmvG+w3SjSWBGdgruJc2E3eSz5K9jwHYtuUtZ
         jdVUC2nrle9AmQIxMOo8xQhN2t3sXc7bXcARPzuwc1pEdd30C/ca0mEmWXz0Fmcn53HS
         WJorxsv7sRvmyDfvmZDzF3t7An+V8okTA7SWJB5fCr3KcXLKG0495JiktzKYzt2/RQBg
         ZfkYgHXJ75oZAShfhqUcKU3cWO0qyeaAcxoErqBq1xTa3ILtG+WMcnHCFDWIg/SSDzpG
         WnLwTelkVYKqqNT5M52z0DcI123oDNa7hiL/fMTThF5tZ7OPntU6YV8KPmpNQzeUmGCl
         svWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714629048; x=1715233848;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi1YoIO20lZfI3P03MeGlqmMPgbcDb8GllYor4Tbssg=;
        b=k8/Uv6M0nqDhadu7na5c+BTjfsJBP88fuu5N23VQOrSQRr43rDg2KUq8QBGoDHVFfo
         fRlrBbEGHgAQmWan3qJqWHSkktswrd7+94QSVY6ZY+j6jJCPnFlcX4WBUMcHf35ZTN/E
         Q7RuMj6yOjZIU3B4JwVBcpLKB9yYuPA2IQN2oxU0KQb9O+KWEIx6gL0uunL+cR5yGuJT
         vFT0GC7CzvWQRK8WXNBmjNRdrE+SuNrI8HyxvDBg0oeZs2YrfPRFCNB1vtTBvb0lxvuW
         nH42I4Vsj8kCCvhg2KP3omwLeVbfTfxxNLAgWRQgytcv312r82KAA7+4JiNIVyOaH4xK
         FOGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJA8f4ZIXpHSTr4YlNLauzSaRghPbspXRGVtPuv0CKqLSno4g/cndm86wk2QfGh6QNoA3mvSOoL3BwNt4anOCeL8N9
X-Gm-Message-State: AOJu0YxnvxAM36YPw0hxx6pa1Wn/ZDxKUpr1Aq6dwvHoBy/6xLuu9z4J
	nikWXPTgObAIcsM/lfXHGXDeiYdQD8NX27YgEALutDPBsQyjYMtLoYbQSWI/60qOaD56EMtXxuh
	8q7+vqWNvB+8AbypUB0QBLfA5aBM=
X-Google-Smtp-Source: AGHT+IGl7U0scKejbWSc2Rln9fxwhLCusVNli8qxOC2KaRCONj1TgGtdzjRBP6crtY7/aTzfLF0dnkrf/Eeshpd0DJs=
X-Received: by 2002:a05:6871:5226:b0:23d:ebc3:f18e with SMTP id
 ht38-20020a056871522600b0023debc3f18emr1179738oac.0.1714629048377; Wed, 01
 May 2024 22:50:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 May 2024 05:50:47 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbk5pgke0.fsf@gitster.g>
References: <20240426152449.228860-1-knayak@gitlab.com> <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-5-knayak@gitlab.com> <xmqqbk5pgke0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 May 2024 05:50:47 +0000
Message-ID: <CAOLa=ZQkTM26wmGgj3=Pz9p7-nFAWQdxCA=RjaJVSm2m8zn7jQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] refs: add support for transactional symref updates
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000059c79a0617722fc0"

--00000000000059c79a0617722fc0
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The reference backends currently support transactional reference
>> updates. While this is exposed to users via 'git-update-ref' and its
>> '--stdin' mode, it is also used internally within various commands.
>>
>> However, we never supported transactional updates of symrefs. Let's add
>> support for symrefs in both the 'files' and the 'reftable' backend.
>>
>> Here, we add and use `ref_update_is_null_new_value()`, a helper function
>> which is used to check if there is a new_value in a reference update.
>
> I know you want to express a condition where you answer yes to "Is
> the new value specified in this ref update NULL?", but "is" at that
> position in the name somehow sounds awkward.  Any of
>
> 	ref_update_has_null_new_value
>         ref_update_with_no_new_value
>         ref_update_without_new_value
>
> might be nicer to ears.
>

Yes, thanks with this, I do agree that `ref_update_has_null_new_value`
sounds better.

>> We do not add reflog for dangling symref updates, because currently
>> 'git-symbolic-ref' doesn't add reflog for dangling symref updates and it
>> would be best to keep this behavior consistent as we would move it to
>> start using transaction based updates in the following commit.
>
> If we are not changing the behaviour, does it deserve a four-line
> paragraph?  It is not like we describe every no changes (i.e. "we
> could break the behaviour by introducing this and that bugs, but we
> did not" is not something we usually say in proposed log messages).
>
> At most, if you want to highlight that behaviour, I would expect a
> brief mention like:
>
>     Note that a dangling symref update does not record a new reflog
>     entry, which is unchanged before and after this commit.
>
> As a reflog entry records name of the object that is pointed by the
> ref (either directly or indirectly) before and after an operation,
> an operation that involve a dangling reflog that does not point at
> any object cannot be expressed in a reflog, no?  It is way too late
> to change this, but it would have been interesting if the design of
> reflog had a room to log the change of symbolic ref target as well
> as object names.  It would have allowed us to say "HEAD at time T
> pointed at refs/heads/main (which did not exist)", "HEAD at time T+1
> directly pointed at commit X (detached)", "HEAD at time T+2 pointed
> at refs/heads/next", etc. and allowed us to much more cleanly
> support "previous branch".
>

While I agree that four lines may seem excessive, I think it is indeed
an important point to note. Mostly because this shows that when doing
dangling symref updates, there is no record of this update. The best
situation would be like you mentioned, to record the symref target
changes. But even with the current design, it would have been nice to at
least acknowledge that there was some update done to the symref. By
having zero-oid for the new and old value in the reflog. But seems like
we can't do that either.

>> @@ -1247,10 +1249,15 @@ struct ref_update *ref_transaction_add_update(
>>
>>  	update->flags = flags;
>>
>> -	if (flags & REF_HAVE_NEW)
>> +	if (new_target)
>> +		update->new_target = xstrdup(new_target);
>> +	if (old_target)
>> +		update->old_target = xstrdup(old_target);
>
> "Is the assumption that *update is 0-initialized?" was the first
> question that came to my mind.
>
> Doing an unconditional
>
> 	update->new_target = xstrdup_or_null(new_target);
> 	update->old_target = xstrdup_or_null(old_target);
>
> would convey the intention much more clearly without having readers
> guess the answer to the above question.
>

Right, I didn't catch the nuance last time, thanks for the explanation.

>> +	if (new_oid && flags & REF_HAVE_NEW)
>
> Even though syntactically not required,
>
> 	if (new_oid && (flags & REF_HAVE_NEW))
>
> or better yet
>
> 	if ((flags & REF_HAVE_NEW) && new_oid)
>
> would be easier to see.
>
>>  		oidcpy(&update->new_oid, new_oid);
>
> Again is the expectation that update->new_oid is initialized to
> all-0?  I am wondering if we want an else clause, i.e.
>
> 	if (!(flags & REF_HAVE_NEW))
> 		oidcpy(&update->new_oid, null_oid());
> 	else
> 		oidcpy(&update->new_oid, new_oid ? new_oid : null_oid());
>
> to clarify the intention of the code, since the way you wrote the
> consumer of thes two members and REF_HAVE_NEW bit in the previous
> step implied that the new_oid member gets used even when REF_HAVE_*
> bit is off, only for its null_oid() value.
>

Yes I understand what you're saying, but since we're doing a
`FLEX_ALLOC_MEM` right above this code, I thought the fact that the
'update' struct is 0 initialized is known. With this, and the fact that
here `update->new_oid` is a static variable, while `new_oid` is a
pointer. I think being too verbose is not required.

> I'll stop here for now.
>
> Thanks.
>

Thanks Junio for taking the time to review.

--00000000000059c79a0617722fc0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bb538a104a6a93d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZektiWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMndEREFDQnJ6eDlrUkZsS3E1UDBEUkp1OUlhUUlabApXS2RZR29BakZQ
NGpxYmhtUzlQcTBuRFY5aEYrMEdiTktQMk05OEJtTldPK0ViWVV1VzFZY3gxRU5qOWZuV1FjCjhG
MnVxM2ZZS245cXYxQ1VLcXJERFBtNXFRQ0ZnZGo1d2poTTBjTWpDUzJNL2dZZzVEM0I4cU13ZHp2
NW9YbkIKemhKaUtpcGFlS3YwZWNBc014d1BpeVllM3UvU0NGZlEvZmxiZEl5UGl6WXc1VUtCUm5l
VEtwajhVYVlUMXV3OApOT1g3UnFGV3dsTlhKUDN4cTRySCtsNkhRcGJwQXFxaDFWNVBtaUdHSktw
SWloWmZjVkpvY0t2d0ZsbENsQ2x1CjFpRHJVR01OVkNQVnRPTExYdlI5OTFaQk10YlBIcEpRdmJW
VHNyc3krekpGYjJ1Y1BqWVlEMkJibkQ2Y1gzUDEKYzF5YWIvTTdBVlU2bjEvVnN3M1NCWW1ndzVj
VkVFY1RJWUNSTWd4eWFseEkxK25WdlMvTlRrMlBMTmwxc0pKOApKR0Zxc2diaUpmVmFNQUN1ZFZ1
M05rS2p6N3N5cU5sdkZtZWJxSnZEN0VqU1NFMU5QSzdGMjg4L3RtZVRGSVdzCmo5aXl1bFRES1RW
NTQ4Yis5ZW1iUW5nSGxUMDM4WmQ3dEh3UVRhMD0KPXVtSVgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000059c79a0617722fc0--
