Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40F1A76BC
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325605; cv=none; b=Bot2CI57bqazy5+uuvZB6+OB7XSzokAjzBL2C6xwEHDMH4NoRwJOwuKxY8VsLL8c/h+n4TPDbeq846WkHPwOYNsgRnJxVa/dv1cPmWaI7LH9RKlTm2UrF8dhTZ6+0isMv1s2Z7Fq57O/+l5jdR7honQ/0ajbGiY0GcHnv5+SFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325605; c=relaxed/simple;
	bh=xKBaOO++5UQTTE/E/FSRPHtdS7QYzthcYEw7AK607VA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNrF44jUD6JuSCs+vpCF3o5YTuxUl7yjNCDWUwtPSG8x/HIZr6RioyL2tuZncPXnqWgGEZKcsoZIFqB206xUz7Idnac0hxOAgXLB3yg+3+XKhp+msIuf6CDIoIW9Fs0y10Zg4Dxdn9MvKIAcCAJBgQ+Y25E8esnxFQ+d2XkGmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb8Satcz; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb8Satcz"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5188c6f260cso5299494e0c.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 00:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736325602; x=1736930402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKBaOO++5UQTTE/E/FSRPHtdS7QYzthcYEw7AK607VA=;
        b=gb8SatczLeDXWPNPs7a6+5wXIXqQuQgSOFusDa/81ltPWyo5BaE36PMPJ621CWHtaJ
         IOJQfn0aIhvtKtc4RLt6U0R1kITS0gfVlgt36523FpLp2S/i4onf7r5rPiz//s5csfFF
         ssGHzdMkDL8lqvi9iK43soD8Yr95RmHckCJNnXmeqqeUYlTT7d96AVM3oIrspZK2js+d
         FN4ZzNYWex8m/0WP23IzPaINhdLmiL+Q2405/traMtrM8nkW6CuKsYwpxqjqiFGHhnr3
         PcvNHrME31IRgbIeXJVvbqksLNRNUZlPgzf8nv8bOneS16ZJv87DgWi20griHyKSUkMB
         LFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736325602; x=1736930402;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKBaOO++5UQTTE/E/FSRPHtdS7QYzthcYEw7AK607VA=;
        b=g/k3U46KMqP4rGBcNuiL+IiGNK/9E/vLUq+PCOCBeReJ8DPb+xgWU+2E3Momlun5ml
         bdqeoyGuT/ytYHLkJeFyX3Q2CHTFlY8DYYUyyCojYQ/XRrgDBPgEOp/vXuXFAgH3OLFT
         sh28f+SA/+4HQT6DeqZeghCN0Hzoe9eCQ6jEL25OJYv83jrUPYxccCWXP5pPeUUiRfjN
         OHynB4qPbA0QB94qKIejZtrRy7kq+mLjMk4Kq7Yla0d9KH3b/KWAahCo7EiJEG0CdueH
         WYCZNL0J6xofcFzLgrJkaD7QDWCMG0U91NHhLSVl1qGlB2DdLaztrRy4UofNiQmLGDxr
         MhVQ==
X-Gm-Message-State: AOJu0YySsTZIZboAiizsYkrJ6dM7KNgpHQVaUdoOYDspxe+R/0vhCJPy
	KylM4rm/D6IlPUJ85TZmzHuHSE1ACVRU9sljagfYiP8Iz7KQ3P+pcVd1M2cCMdYDPPgIkThDGhv
	Dr0ghfrDWL6q2iRRsdaxGyllycfI349PF
X-Gm-Gg: ASbGnctWc2oq6NPV0pC/nKELl9oqcpiJ6vcuT32ecjuV3EGwJ79FwxTVJ3iC1Yy8SHc
	AA8Du7vwSoWhfyMBeBY1iISfOJxcNJhiMMBoYyao=
X-Google-Smtp-Source: AGHT+IE/8hHHWQ1bhlwq4Yysip857+NQK7qTjCBwLryHC/GonAG5gTqUeY5W7Bp0WfkG1HoTMVtAhuI562IFs0/66jg=
X-Received: by 2002:a05:6102:3e20:b0:4af:e5fd:77fc with SMTP id
 ada2fe7eead31-4b3d0d75fcfmr1630337137.3.1736325602451; Wed, 08 Jan 2025
 00:40:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jan 2025 00:40:01 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z31Xj6sZk1th2mRQ@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux> <Z3qN30z1NCXa3AX-@ArchLinux>
 <CAOLa=ZQ6J9GLQjJihKxbDwH6SmHbmVq4sHrKh0ZtMqyEt3hsiw@mail.gmail.com> <Z31Xj6sZk1th2mRQ@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jan 2025 00:40:01 -0800
X-Gm-Features: AbW1kvaf4nNzcKNjGO4xbK6zmJ9ulJsHk8a_gbu_qDcGQvdpi4m99476b1qoPdo
Message-ID: <CAOLa=ZS461s=GxjQ_ifO_FCbDen9WeP6Gogz7nx=zx-jMkiipg@mail.gmail.com>
Subject: Re: [PATCH 02/10] builtin/refs.h: get worktrees without reading head info
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="000000000000bfc497062b2dce5f"

--000000000000bfc497062b2dce5f
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Jan 07, 2025 at 06:57:08AM -0800, Karthik Nayak wrote:
>> shejialuo <shejialuo@gmail.com> writes:
>>
>> > In "packed-backend.c", there are some functions such as "create_snapshot"
>> > and "next_record" which would check the correctness of the content of
>> > the "packed-ref" file. When anything is bad, the program will die.
>>
>> So you're saying, `create_snapshot()` and `next_record()` exit the
>> program on any error. Okay that seems to be valid.
>>
>> > It may seem that we have nothing relevant to above feature, because we
>> > are going to read and parse the raw "packed-ref" file without creating
>> > the snapshot and using the ref iterator to check the consistency.
>> >
>> > However, when using "get_worktrees" in "builtin/refs", we will parse the
>> > head information. If the referent of the "HEAD" is inside the
>> > "packed-ref", we will call "create_snapshot" and "next_record" functions
>> > to parse the "packed-ref" to get the head information. And if there are
>> > something wrong, the program will die.
>> >
>> > Although this behavior has no harm for the program, it will
>> > short-circuit the program. When the users execute "git refs verify" or
>> > "git fsck", we don't want to simply die the program but rather show the
>> > warnings or errors as many as possible to info the users. So, we should
>> > avoiding reading the head info.
>> >
>>
>> This is a bit tricky here. If the information for the `HEAD` ref is
>> incorrect in the packed-refs, git would exit early. Which is what we're
>> trying to avoid in this patch, by using the `get_worktrees_internal()`
>> function.
>>
>
> I think my commit message may confuse you here. The information of the
> "HEAD" ref will never be stored in the "packed-refs", but if we need to
> read the head information, we need to parse the "packed-refs" via
> "create_snapshot" method. Even though the corresponding referent is
> correct (and even if it is not correct, it won't let the program die),
> "create_snapshot" will call "verify_buffer_safe" to check whether there
> is a newline in the last line of the file. If not, it will die.
>
> However, this is a bad thing. For example, if the HEAD points to
> "refs/heads/main", now we need to use the code path from packed-backend,
> we have to call "create_snapshot", the program will die. And we cannot
> tell the user the other faults.
>
> ```packed-refs
> <good_oid> refs/heads/main\n
> <bad_oid> <bad_refname>\n
> <oid> refs/heads/a
> ```
>
> So, the motivation here is that we should not read HEAD at all when we
> are doing consistency checking to make the code totally independent of
> the "create_snapshot" and "next_record".
>

Thanks for clarifying. I understand better the point now.

>> However, I would question if this is the right approach. Shouldn't
>> `get_worktree()` failing indicate that the repository is invalid? In
>> that case does it really make sense to allow the user to even run `git
>> refs verify`? Isn't the prerequisite for running the `git-refs(1)`
>> command a valid repository?
>>
>
> As I have talked about above, even though the referent of "HEAD" is
> good, "get_worktree()" will still fail because of some fatal errors in
> "packed-refs" file. I don't think that the repository is invalid in this
> situation.
>
> Put it further more, in what situations, the users want to execute "git
> refs verify" or "git-fsck". From my intuitive thinking, the users will
> execute these check commands when something fails. They want to know
> why. So we should execute these commands when the repository is invalid
> to tell the user what may be wrong. And this is the value of these two
> commands.
>

I agree with your inference here, we should try and figure out as much
as we can and report it, so clients can make informed decisions on how
to fix their refdb/repo. Thanks for explaining.

>
> Thanks,
> Jialuo

--000000000000bfc497062b2dce5f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8920b2fe0a652fef_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kK09kOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2RMREFDa2NLYTA2cWRQdEJBMzVBS00weEVmU3U5YQo0TW9aYmZEdVJt
OGczVlY2VWF1OENWdWlBVTl0UTVNZUZCR3A2SmNKM3o1SHp2bERlUkVXQ3hSSGZMOWtPdnNDCjk2
M0xZRFlIT0o4VDBhaittc2trYS82RDZJYTUyT1FkdmErS3d2Nmx4WWpPTGNDeEhrancwRjVKRnhv
RTNMc2YKbnRuQjN5U2dRSGkyV0MwM2tOWUNra0Q1MmRPTkcxTWxHTkd5cC9HZnk4TVNjdG83Wkl0
Y25oYkdtZk5ZSDFsZwpzN3RaaGEzb1A3RGJVNVNkYXlvTzQrYzI1OUtPem1KRjhrZHJmOWlURkVU
L3h0Y3lDNmRFY0dwOTBvRFdVWEh6CnltQ2JhbEYzMHo0NkQ5ZVFabjBHWldnMWZYQnBwV0ZGbVFv
RTZuT0t4LzdHcG01MnZaOHlNT2tabzhxRDNHcEgKVk54Rk5uVU9wQXJLQ3RWdFJRdWZtU2RhQ3E3
TEpTMWRuMkJRak1lSUVuSE9sMDZpTzhNWEZoT2E5cFVOdEMrVQpwUVJ3S0VhVUVmME1zMXBjL1Ni
ZS9sVXR3aTJVQmlqaWhrV3dtMFhwR2ZFOTNvVlRGK1FCQmUrMFY2UC8xeHI1CjRTRW9ELzBBQWJX
T096MmRBcnlqZjg1S1VFR3pQZ0pTcjl2WW92ST0KPU5pM3kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bfc497062b2dce5f--
