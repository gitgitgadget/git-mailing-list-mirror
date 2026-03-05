Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE72D3A6A
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750075; cv=pass; b=DgkEeySot06EF+r0E+4E8GardNmiJeREjWPhz4MDt1MUSUbHmor7LC265feItBRBwzQn6v6SDPpbPTY3yNWhBU+6nG54U7TLXhhXWyolDGJnh0ol/kwxAOE0ppaPlmBISC7jzT+NjreYTWgRHo5cV+1cID2wNyKGb/Awb4xyylU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750075; c=relaxed/simple;
	bh=klMB5c+oce0bk49VE6NDZCAyDimAdRSNL/PYSHG/DGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0PiqWKC9OCR1hoX59UUOHDzEDF7TN0BqlgZvSbFhs6IUvKNqXzpXHznRbP1IcmPHFnzzFEn4ZeCcJx3HsIjMJBqFZAhR47BP9OBQyc3gAqMKrt7SyIWcN1MN+6pj85Iril5LFmok1L31ZpL5TeomqWpmpowvxZw//SnwvwHrfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be0f64a05bso233271eec.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 14:34:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772750074; cv=none;
        d=google.com; s=arc-20240605;
        b=bwiqeQeiRJhI21FzKOGYXJ7Uhn1J87bmu/+xrxCQGbAkvwJRkVWX+BdTp+KED3wZes
         tUVbZ/yFbovbXdH7RDWmYfFnWBFSUYSY15oVQiWDWuBxrDlgheU1/CnXHKqlm3qHZkGX
         rmw6OacKPQYGpEXJs/f16YYb7gk8tNIY5HI27w0t8UzHSoeUWzJ0QDvbhwsbYkP/wSqD
         XSfDtnukQGqP1mXriCeAe666SEYmPxwxJiWGBoLOdZL/TSQro1t9hKbBdaICpCsHlEFa
         S2490WN6PMPifmbbsxqRb643zc/s0ZhMU/BPocOC6kJjE9O+Ao0sN3it42DkYHEp+Zrn
         iDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sAu8T5p8WDfWtESN2SuAXbcvt2PHmHeZluh474Yddqs=;
        fh=f0pn/pZIMDEUCEI0mNvVqHckkzAN7lMlxW8C3MJmxPs=;
        b=kld/1Q7JhVoaQGwPrhzRQ1QWlmhU+Fx33EqGeg3858ltEwnxubmK8aa6lvji1b2jd/
         OCZVK8ESsr5mwiOMtR6WjEwJr+QrOrNVT+HA+6w4ezMWsS/4FzofxvSPfEnYgh8n4L4O
         uOysCYFOD2JgyQfPw7rpbLHc8tzxATkyWebgHBwRWEQg7rglFDby5aAen7t3Zz8tIo89
         OtaPfi2icE2ODicdlq3k2lc4bfXqLAvpfMueS19qSYYuXm9wsMofyqRQYGAVcWhNZr3k
         /C+0SOdp0JUk5krPObkibBQK1H561KMsYSJIH8i9ZOr4Tv2HVLz8ReGQ+L4a1nQEBZq3
         P03w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750074; x=1773354874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sAu8T5p8WDfWtESN2SuAXbcvt2PHmHeZluh474Yddqs=;
        b=BJUlfCiXbnvKBh646pvpUOEtuhSGs4wQxnLf8drGW/mS5dpCE05X9+XvtuRPPV/X3j
         2/XjRKnwWyBOeN3HbLpMQ2t0kLzxRhNg0tgqVXwppVnVuQ5Ek71QhfFqM79tNCjPvh/e
         S7+j2Uaa4hIWkUHcY5jixAU1HuIc0dceV5FeGuRCfXTf/NvZmNOxcrvYVbokp60W/5g+
         5WacUTbsnM9vpSIXXn2Yhl7TlogKjukoD23oljb220PEsWMVCgHHrwbhAfAwHq81onDy
         OEBjOvAZDB0BeNyZi1Gh9YMbZahu74RHfyhNDKlMg3jvk0kDfN/AgmB/gcibwMiPnxEL
         WDpw==
X-Forwarded-Encrypted: i=1; AJvYcCV4tPb0GXuKoYE2uqZ+QQ5qfXGlZRfS0kmwoZVO2iRwtP+5JQbdTAcbMZWEObwPHzHtrc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvHcK6uIv0fgLkT0AlclNAnPBrUuBx2Hq7LF4VBgLPOrzUzIZ
	vHmBgR/0YOd1VIIVlyyLgL+GVX0KVvwHMEHQj3dAqPS8ZtQVrZugsah6tla9H0Ne+HanhAYN3Iu
	/Bg6j8mOzMOE+F3eJznQEPpXYo8fwuEdsWQ==
X-Gm-Gg: ATEYQzwlp9kW08CT2t/RzOGYbwepkK609S33zHIfGIwT99u0B2Lc/6HR3sSNpyaoM3c
	HHe4dts0UCYvwcdLNPkU7ZLmDYvhJhFJLw+E7a8LAcPWxN9o90IY42XCPPV13NjwTvPylTLMf+9
	xDi9z/Mfw6nU4D1aQ3gzSngvT4MKXyYjE9xqKKEdhMTWxCtMK9r6+QQJdZ6nGRnmLdBg5xlTTly
	p2l1BWZUbFhxcpJVSlWbjSH/mtgiO3exdDkTtgEP4DYjnBmRTV+S1pM+L/tTBr5ibqqZrNO2vOl
	ehzPqmord1iDnZzeebEfpMW4x+dx+2Du2rCIrOkS
X-Received: by 2002:a05:7300:af06:b0:2b7:e929:856b with SMTP id
 5a478bee46e88-2be4e0f0d27mr9129eec.5.1772750073521; Thu, 05 Mar 2026 14:34:33
 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
 <20260305090602.22436-1-francescopaparatto@gmail.com> <xmqq5x7a3x9w.fsf@gitster.g>
In-Reply-To: <xmqq5x7a3x9w.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 5 Mar 2026 17:34:21 -0500
X-Gm-Features: AaiRm524bTFBmE1vyAqt9sfXpb3i8_uithspb4pQSLFCAp9SbVgyD9C66IvqXY4
Message-ID: <CAPig+cTsYWVg0nrU7kMakOKQaqFSo=i_nZ=_YuCJK_hq5gdZPQ@mail.gmail.com>
Subject: Re: [PATCH v2] t3310: avoid hiding failures from rev-parse in command substitutions
To: Junio C Hamano <gitster@pobox.com>
Cc: Francesco Paparatto <francescopaparatto@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 2:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> > Running `git` commands inside command substitutions like
> >
> >       test "$(git rev-parse A)" =3D "$(git rev-parse B)"
> >
> > can hide failures from the `git` invocations and provide little
> > diagnostic information when `test` fails.
> >
> > Use `test_cmp` when comparing against a stored expected value so
> > mismatches show both expected and actual output. Use `test_cmp_rev`
> > when comparing two revisions. These helpers produce clearer failure
> > output, making it easier to understand what went wrong.
> >
> > Suggested-by: Junio C Hamano <gitster@pobox.com>
>
> Hmph, did I suggest this?  I know Eric had comments on a previous
> round, and the improvements in this patch seems to be influenced a
> lot stronger by his input than whatever I may have said.

Indeed. The use of test_cmp and test_cmp_rev makes this version much
more developer-friendly than v1. Nice.

> >  t/t3310-notes-merge-manual-resolve.sh | 60 ++++++++++++---------------
> >  1 file changed, 27 insertions(+), 33 deletions(-)
> >
> > diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merg=
e-manual-resolve.sh
> > index 92a5951331..64c0a753ff 100755
>
> On top of what commit is this patch designed to apply?

What Junio probably means is that you appear to have based v2 atop v1,
but instead you should squash v1 and v2 into a single patch, and send
that as v3 so that when the patch is finally accepted into his tree,
it will appear to have been perfect from the start (because v1 and v2
will only exist in the mailing list archive, not in the Git project
history).
