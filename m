Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEFA75810
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399300; cv=none; b=hz2N/mh7O7hRjM72ePh/FAxMlAB52e7pgyxa39FtAWiEvwH/qbDLfg/6KIYZijHvUOK+oFJ2xgsr3ehjw4kP8HIBVQ+1BvB5Op1JP0ABCLnXlPrlYt+2cpAasvYj+YFKDSu/4uxwgys4CrraD4LJz0yJW9EgRAvIW3zSEDpbzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399300; c=relaxed/simple;
	bh=6abAiO4enpy7KvI6tSeAIkXLRDL/v4PfD2zasOMrvRE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY4VhNxDzOmayq2vAk74xqhjOG+YR4IhkdyspJw91TpO4kTCr0uc3TXedLRP+1YLm5nta2qlFsGcRLkI2Act2cD9JPhy1S01SI4VAMVPv63OMDJKY1eWWZuX2gKZ5C3GeRdTw3y+0Il5wYnK2v6VrTyPUM2v630auslb6U9LTTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0cRJnbe; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0cRJnbe"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dd041acff1so51588791fa.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714399297; x=1715004097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=twcKXdtBpe4RlJOL2mbeeJpvfewxqaj4xqF5T6voxI0=;
        b=N0cRJnbe+UBxAoWAE2CITodIgdZuqEw01g8SUFGYtmY8LppMXzqOGmLuCRYVoGR7K1
         xj+wmsVK53L67mQBbUTD5hU6ocQaWwqahIaNxNMrn+sgWHyAm605rvo+0pT+lQ6Wd3bc
         uMIu5Yd10vZK3gPz9thoqh/DxPjclT206tRznkoN2y+y1mAwCQG+7Al/AE3Ckpn0nPZM
         lDAGE44TSmO+Im1SoWWFY8M4TeVJgb92fumqFjO4xs5KmkDxBS010ngFE/Rx9rl7NdGz
         Sk4PbJnaccXQD8lN8PSU/9HledVQwpXkBOv7AFZ00Z9lG0pHngVpfWPhxI2XdovX6GTt
         Qo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399297; x=1715004097;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twcKXdtBpe4RlJOL2mbeeJpvfewxqaj4xqF5T6voxI0=;
        b=pZsp+S9BIbu8m9hdhgB/7O8A3ElXDqwwrjrCiv2r2bqzF2LVi6sITVFj48z+iqexDE
         3guarEfgjfuKyyniV217JpahwFKOHRjMOTLVfN6TIk1Z6nmxEhNr+Yzf+No6W53NokR3
         vE8Vfm2hngfBYgvm7fbEezFpc6Fm33sDFfJ3zEFre9OoDCsMo8UOzenf0/sV7Vl8r0EN
         ZUGBUwLSk1/9218TUIbN6QSWrQ1bCGkI1Kj74/l6KKsEOcvMj0aAVkiulh1hDgbz+ZY7
         tCAO1I8ufMQbVmcfqZdyUG4s/WkmnRLdsTtbs8zTtUt9cGj2fryofUyYBPG5WFwstvdW
         hYnA==
X-Forwarded-Encrypted: i=1; AJvYcCV081EwXmE6f4sscYAcyd0unj+2UNDnPMUZJ7ARY6CL1rIpg7n2fUfuC8PeoPdYg+RU5oh1+C1AtTautpQaKkyhi69/
X-Gm-Message-State: AOJu0Yw6PsIYDD2Cc1bBZiVTLZGTd8xDCBTbDrYwu7vG+3ifDGFQAbZ5
	d376dJaH8aVAihkhYEzKQs9vu8jCOW/+TQ4Dj0IJwuLjBLR85hjLuqpiCjM7ZG+reWTVQ9mN/xk
	e/EDU+Wqvi449FSsd+a45WMKhwpg=
X-Google-Smtp-Source: AGHT+IG1n4W4/BtmsbXCGpw9sHnuVAg3MTxEEehdJZ7iFaG/wdiLGSuPeyJIE9RTLuSpdXctP9lu5BgA96GzwWWjGvg=
X-Received: by 2002:a2e:98d4:0:b0:2da:6f19:d359 with SMTP id
 s20-20020a2e98d4000000b002da6f19d359mr6052762ljj.2.1714399295975; Mon, 29 Apr
 2024 07:01:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 10:01:33 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <73632d75-b82d-4853-93fe-3460fdda3325@gmail.com>
References: <20240423212818.574123-1-knayak@gitlab.com> <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com> <73632d75-b82d-4853-93fe-3460fdda3325@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Apr 2024 10:01:33 -0400
Message-ID: <CAOLa=ZQ1HTRqsCrhw=PRYaAY0-d_w2Ufxf-ucBCz4P2ws9hFcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] refs: accept symref values in `ref_transaction[_add]_update`
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000000a4ee206173cb19f"

--0000000000000a4ee206173cb19f
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 26/04/2024 16:24, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The `ref_transaction[_add]_update` functions obtain ref information and
>> flags to create a `ref_update` and add it to the transaction at hand.
>>
>> To extend symref support in transactions, we need to also accept the
>> old and new ref targets and process it.
>
> s/it/them/
>
>> In this commit, let's add the
>
> This commit adds?
>

Thanks, will add both the above.

>> required parameters to the function and modify all call sites.
>>
>> The two parameters added are `new_target` and `old_target`. The
>> `new_target` is used to denote what the reference should point to when
>> the transaction is applied.
>>
>> The `old_target` denotes the value the reference must have before the
>> update. Some functions allow this parameter to be NULL, meaning that the
>> old value of the reference is not checked.
>>
>> The handling logic of these parameters will be added in consequent
>> commits as we add symref commands to the '--stdin' mode of
>> 'git-update-ref'.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
> Thanks for updating the documentation, I've left a couple of comments below
>

Thanks for the review.

>> diff --git a/refs.h b/refs.h
>> index d278775e08..c792e13a64 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -648,6 +648,15 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>>    *         before the update. A copy of this value is made in the
>>    *         transaction.
>>    *
>> + *     new_target -- the target reference that the reference will be
>> + *         update to point to.
>
> s/update/updated/
>
>> This takes precedence over new_oid when set.
>
> I thought it was a bug to set both new_oid and new_target.
>

Yup. fixed both of these.

>
>> If the reference is a regular reference, it will be
>> + *         converted to a symbolic reference.
>  > + *
>> + *     old_target -- the reference that the reference must be pointing to.
>> + *         Will only be taken into account when the reference is a symbolic
>> + *         reference.
>
> Does this last sentence mean it is not possible to assert that it is
> currently a symbolic reference? I thought the point of being able to
> specify the old value of a ref when updating was to ensure it hadn't
> changed since it was read. This contradicts the documentation in the
> next hunk and the description in the commit message.
>

I see how this is vague, I was trying to imply that the old_target is
used to check a symref's old_value. But actually, if this is set and the
ref is a regular ref, we do fail the check. So this is wrong. Let me
just strip the last time.

--0000000000000a4ee206173cb19f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5fac22b5bbee7e57_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdnFEd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXkxQy85MUwyZmJ2ajc4QmJ1YlhiUU1aRXIyczNsZApXMWNhWlBPaTNE
VFNlRDJxVHQ0TWpyUVhvRXFrWG9zTGNxcHlLTVVLZWtDSmtHeDJxaVNkYXBFMXNUS3pIYzJtCjFv
LzVWRlFncHdZTkY1RkNEeTVsYlhmQTBGNE53Q2hScmMzcWV4d0ttdTJGNXdFU1VkVml4QkpqZ1o4
dUFkUFUKZGxBNERQL0dMVjhTaWZoNmI5NGYzWHVvS0ZoYXZydWN3MGFqMUpTWVlpaEVqN0pzRWtn
NVh1TklpWkMvRVUrbgo4RlRGekMzZnNRYUlLM3l3V0FtSjIrNlpWYlNlM2JnYWNMMmswdEVMMG43
NlJOVFFzYVFUL0NDaXB3cURwRXp1ClRGR2x3bzI5VVJ0V1RwVmltVnNhWWpreDZjNUhMOVliZEha
OHY1Nno1UC9GWHI4QStORGxKZ0hNOVIyb2RacFcKUWQvbHJKRUFxWFE5dEcvYk5ObW4zV0dxYmc4
V2FzK2paVWkzUFh2dG1xYXNURlZuOHFKOFdLOEpLSlBqR01wRQpUQ3RsR3Q3eE1Hblp2ZTJqTHdj
TzZWc0tCTnBBV0ZxNEVweFFjTmZCSldiMENYVXZvckpCdU9wSGZsY08yVlc5CmZjdjljcXZsUFVB
bnhnRmN1TVdacXBwWDhXaC9weFRZeUdGMUV1UT0KPWFVSHYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000a4ee206173cb19f--
