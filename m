Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D11DB95E
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769366857; cv=pass; b=WinWxpTI99/MC4N7pJsNX0r/uqjPjf9h40SjlFRi/lh2UfKf2Rl/AsX8ImkwZPNM+0d2XaB0qNLUpVpHIyNUOPRCt9GkeDFf/8STEamKxfTFJSfxFWmwda+jdyoH7XS+bDIYnRUoZhwB/eVLNL9jk2VrnJEp5cOvvvKG648/BhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769366857; c=relaxed/simple;
	bh=xabue5m/j+48XSSgtMZTG/evhFMRxWSKiwFDrdbIWgo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktECv9zlnAXhkKkz0/UT+Aw3iam+a9g8VYRGp/r1i8Zp9X888dRBicsaY9ghT9Kc4Xmb9G2LvM+d+Oohe5SfH9qkSVrYvc5Le6PSts4iZt39zAjOvVYBHjdyTwBY7jULS2cunRzu3GMnzvAPoxUOmkXJpXkKI/uqZJZOGq+o3h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1f/nQN8; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1f/nQN8"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94124140e02so3291186241.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 10:47:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769366855; cv=none;
        d=google.com; s=arc-20240605;
        b=KydDuptQ0PvgHk+5rXbRhhEiMrXtLDVehNTFS0z5EOMNX6oNwD0zgBgNa45J42t1iH
         LiKCLthlwJXcFr1IjzRb5GSfQoBdbVJG0u3IwkYQlEAGwkPxPbU7gp3w+iqgC+2qEZgT
         cp/md3/AR5GzP30mNVlB6aT47ry+EW/msfhcQZrLJ36NN68Q/tj8Mi6aznpmRgxJBh3V
         Dqzl9Po5U60M62paqc2LIAHUBJvwB3KGh3bXLo/xGGN2UZXarNv3K1hHZzzckG1Wyx5Q
         rYJCxY7pP5wXYOCBvLX0ypTboHfj2awJLki/EzV1NjGIaWsXEmfXjqQuY/V7FHRu/+sD
         kUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FjWpObzefiWiAstJo6zQD7NTN+DkKdlGdZbmFdki7BA=;
        fh=LrV0gm1y5AUAMOc6gVEyY+U3tdxxtrFOSNFgmZR9U/M=;
        b=j1kj374YmsNyEELAxJ0YgtJz7CtTW2+cR15h8bemOlPojFyP/7Q5PPFe/CJYu66zlm
         acgnAPHWxiYGSVgE896KFpA8dbPi0WFHltoESvY358YmsAw7RrdIPeVaXRgGtngUWl85
         znn+HI++kDu4wE9SJXWteKK+2ZNqu6ZLf+qsKuYmWZZRzk+y1tQyX5mHXURsQ+nfQsNn
         Kz3EHUVriAUvyA9GH43jc07sNFiHYik5LaSASYIYfkU25tbRuMPsEJSwsJONiIGqaW1t
         cZu12n3RN7H+MbaIXbYCI+2TlrFbRLPYD7Y6p8N1AYh5eKQaIaLPThz5H0ZDwtI5oVUL
         xN0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769366855; x=1769971655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjWpObzefiWiAstJo6zQD7NTN+DkKdlGdZbmFdki7BA=;
        b=c1f/nQN8b4WB9YW7beXVyKSUni32bvJG/Tlg9WJvSlUcAXpUgZlmNjcFBQKVo+DzFH
         Ww9eg3jvo2vduOvEWlh+j2pLItGnMGYlR0GzRQCxVya5JFpAxY5WfdQ2DfOuEWq8Tr2M
         I5/StUIvpmnJaODCWqVL09O1NkbK1cBGrT4enMsoN9InMy9vLukwJGZjaLWL2KDXWBAL
         TT4TjHIfUmtv68tvXjdjuPR6DNvi29JQuZYugwr8bcJ9s48MpOzt1RMzQv/kfm7u5upo
         7itSVdoYWmYCZS5eRIu6f0Q8pIHQK5f/LUSASx+L7cXxuOtkQNXsk6NYHjnX2mw/cheq
         ZZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769366855; x=1769971655;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjWpObzefiWiAstJo6zQD7NTN+DkKdlGdZbmFdki7BA=;
        b=dlqn6mWmNH4LPokJS1NsuPgfmT+p1mQSjol7+6Hxq1bZB58i4w7vrZa4ARh0nZSwPU
         AM8DFCdlkmBk0lKJXdPTc0/0VcdnVBrHM9tZQ2ByNbbGLBXZ729xISBrP/O2NOeLLSrT
         j1JaxEkpwvCuUp/UG/kbyBAGYUphTDj8BZMXmHeVvpFYj0LZ9L+s1xofdteN4xbG5+48
         V8mK5tmV/Avd9v3WOZKn4HZNMzFQSVNHlLus3Zjc39HR4uY8F4bncJNvMZ9BhEO5jKEI
         kQnpvUAllsVAXoYLtVgJ3RPBKvw0RB1N3C2JHgAPsY9WMnIGscQpfef/nfFaaSkDqSYJ
         9y8A==
X-Gm-Message-State: AOJu0Ywh8GrJt2ynte1gopLCg369O9DTAIhjLCVY+qb/yRXAeeS6odf0
	yUmzxXGPhOJhmmabixbMmrUth11y+e12qGr/Z/8DmSlrOUB7MyRL5htQenzNDyAhZygY+jeIpTM
	BuCD+95tN6oEPBXz211p/esPnGev7bc8=
X-Gm-Gg: AZuq6aLGLE06NLmDsNporB6nVkmukvUCvn5RGD76EkdyEyquPi2CwQw0+6RiMtVG7sb
	Z4bqS07lNbCkkorC5mnDqWZ6vq1ESROsonU0DcycM2rbmIj1HvK+pykqU89euPBKQ8UwTEikYiU
	CUpcMiyIFhO2JtDlsJ0YldzeYU/WpbSLzocOdgRsZnUTh7kp7NBSAEpqN39hTyahSIopgB8Z7ql
	REUQgrz9mAZO3abhJWiEmQTaG58jYxCLjd/YEXTTgCjfpaZ5hqlXu1nS8SqDMv8zBByz3DyyIBV
	n1NdSH4neBLSVX9/Sri7AsLe70P+Q/GF25LwLN6B
X-Received: by 2002:a05:6102:3908:b0:5db:e2c2:81a1 with SMTP id
 ada2fe7eead31-5f576322594mr793026137.14.1769366855281; Sun, 25 Jan 2026
 10:47:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 25 Jan 2026 12:47:34 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 25 Jan 2026 12:47:34 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqjyx8gqkg.fsf@gitster.g>
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
 <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-6-2ddba0832440@gmail.com>
 <xmqqldhpmmrw.fsf@gitster.g> <CAOLa=ZSLPasvFrCgKzVOq7mDXiqX9SxoOf0MZdzBXOLn73okMQ@mail.gmail.com>
 <xmqqjyx8gqkg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 25 Jan 2026 12:47:34 -0600
X-Gm-Features: AZwV_Qj9gAiMx9UDvT0N_rOq9zsePV1YLHpbyMkKlAdFRyno9vTO4vb4-5I9cy0
Message-ID: <CAOLa=ZTusX-JuvJAZXNRf=Ex+YUQnW++Xj9zOb7YcpWrdizLfw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fetch: delay user information post committing of transaction
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net, newren@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000e3132c06493ad24d"

--000000000000e3132c06493ad24d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> +static void ref_update_display_info_free(struct ref_update_display_info *info)
>>>> +{
>>>> +	free((char *)info->summary);
>>>> +	free((char *)info->success_detail);
>>>> +	free((char *)info->fail_detail);
>>>> +	free((char *)info->remote);
>>>> +	free((char *)info->ref);
>>>> +}
>>>
>>> This answers "no" to my previous question.  These are not borrowed,
>>> but are owned by this structure.
>>>
>>
>> Yup, cannot be borrowed, since those go out of scope much earlier.
>
> And the reason why they are marked "const char *" which typically
> signals that they are borrowed is?  After all, that is where these
> casts inside free() comes from.
>
> There are two schools of thought.  One (which I originally was in)
> marks resources we own with "const", if these members will not
> change once we initialize them and we want to avoid accidentally
> muck with the contents of these pieces of memory during the course
> of the program.  Those of us in the school often have to cast away
> constness in their calls to free() like the above.
>

That's my thought process too, to use 'const' to indicate that the value
will not be modified post assignment.

> But I saw many of our developers squarely fall into the other camp,
> where they always use a non-const pointer to point at the resource
> the structure owns.
>
> The latter school of thought opens us up to bugs caused by mistaken
> code that modifies these memory regions that those of us in the
> former school would use "const" to avoid, but it makes it easier to
> reason about memory ownership models by signalling if the enclosing
> structure owns or borrows the resources.
>
> I'd say the latter school are majority of our developer base, and a
> lot of existing structures follow that rule.  I was hinting that we
> may want to follow suit in this new structure.
>
> Thanks.

That was what you were implying. Yeah, I've seen that, but it hasn't
been generally how I used to reason with using 'const'.

It does open up for modification bugs though. It's unfortunate that we
have one axis to denote both Mutability and Ownership. To stay
consistent, I'll make the change,

Karthik

--000000000000e3132c06493ad24d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b0fdb1fdc5824039_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sMlpUOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWxOQy85U1A2eTJCR215ZU9mOTIrNEhTWnZKUGtBdgpWakkxdHlIcWZr
VVZ5OXVMeFNVdkVzRVQwSjVlOVFUNnc2VHBLd2F1ZW01bkdraEVkMG9jcTg5TkZJZ2RYWTc5CjNq
QUJJYUR3cGZpTHJIejhReEUyN3ZaZEh4RlBFdXQyOXA0QXlPaFNrRGNrOFozRkV2enR1THNJeENI
TG4waUwKQlRUMndWcXdrb3JGNUlUcm4zSHBQd2kyV3ZZVEFGcmFybmdlMWxWTDhReWFZRUFPTC9D
bW15TFlsOFdWZ2VEcgpQeWR3NHliVVU1SHRiSDN0Snlpdlp0eDlkUktvTk9zeWVPYk52cnVpTDJS
SlpaYnpRTy9OR0dQSUNsS3VEOHQrCkRWOWcyZU9HbmNRVnJNUExpL3kvY1hLem1NWllIS3NTNEdy
ZHNkcEVYOGROVmdqaXhjS0FINlF2cURQZ29EeWMKRzROMHk1SjY0VUpDZkJHZk9sYW9oUEZYamZh
cC9lYnZXL3c4NFhkandhem1rTXhoVyt4Q2kva2dsRWMvMjZjYgozbjhVcVplZzU4Y0FWcjc4azF1
Q3I4V216a3pTMzg4eDBKYXZ2Nmw2Zm5kQUtZUURLQUVXeUZUNUpTTVM3SElQCkRObStwK0NleFB0
MVJVaDdPeWYyT29ldFVLbGV0NVBQMGJENFNYbz0KPTR3OFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e3132c06493ad24d--
