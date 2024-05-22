Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFF7E583
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364774; cv=none; b=B9lM0x1QWBZ69gk34G7c6DFY3eTYxLC+ytLqGy+7GbvOS/7YA7ogViTSO0L/KTRqGTUiAneGoWv0lrKhcsDbuN/3M5a/IhB/+DqhtTxgPPj/f6z+CzDFRV1zMH8QOnQ4YHmv0sMDJNYwhWho5RBCk9x4vZKdSeYtild7j2vt1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364774; c=relaxed/simple;
	bh=hHXYnBlge62pF85gVDw4jzI5ASBOzpgVBXlgjGoU6YQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dD5/fXlq586I15aeH0APv2CEIHoaGNFZoEmPOB4spQbEi/ukuiqekxx5+QsN8As6Zz0DBj6bYM1bYNikpQOnNYjri6Nxl6v08NOhcXVa1hvkaIViyyddxktmaQaid//k6jngoZe+NbSF8A2unCRMRhcRHhLqmDxK3ZzgO/2l7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdIP9huq; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdIP9huq"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23d477a1a4fso3205698fac.3
        for <git@vger.kernel.org>; Wed, 22 May 2024 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716364771; x=1716969571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+pdFjx9PKbvvQF8ysMoDQRFys7PlTnTY+zBzddpFC0=;
        b=MdIP9huqNaO8mGcJk1lsjxXTUrFJV46Ls8bL75Fq4aNjz+WOlDmFXFYHMgTS20wzyr
         uqcl+VAXbD7l80CDurAkZbMkedsH2zpAySDPEcsAc4N9nJb0Va5Rod71Qr3fyIJYx0hj
         hhQNId2lWCkPo98B/duiQVrV13cdM1QdyASlzfIxVGoXIIcYF+7+8fC7EqLQ+eNNAcSM
         bUkRh2Tk6ifIn2ja1Cg9vJ0ICcSm+6jj1UIGY9qhSwkK2rEZAQBbKJqJ/xyInjcut614
         ESySE8imncdzIKObopT07eAdqHnaARNcXcDkFUrbfcF76yCvNT4hW1g6QHez9Gh6Yp5p
         RsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716364771; x=1716969571;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+pdFjx9PKbvvQF8ysMoDQRFys7PlTnTY+zBzddpFC0=;
        b=SIBUyv2MhvIZyOu4zT9z6xwBOYQczHNnnhGioxp95cY4T/Bb7IIUugHAsZ8/V5tVtH
         EZsXN+CrqCrro+viYoLpdMOwbEFgs/Z6HpS35iz7aIEshHUPJMRkSazSp6INkaZsAKwF
         ol0K2H0MyTH/yN6OHJJoL3HfM/Osp9czbfzrMGbD2RXUVAK5i88rWeDEy6ySnBpfupAK
         QkYji+1ngXephW9+B19slFp2MbSgbwY664hF9uv1FKCSYGhfOu2mRsnk4vpN/zpk5JFs
         rftb4Wt61D1GueRSwdaUVqg/1saKlTzyS9C6xl1TTE9Slaus8Fxq6zoGNC9fOsCOmAy3
         90hw==
X-Gm-Message-State: AOJu0YwFWUyQ9irJ7dr5/HjxoLzsK8HX1VjqkEcdpRC2SJO7Di6SymPR
	YgFaA88QmAzJrNYiBuwOO3GchGvTvVIPxIB5sxD2IsRADZTMQWhkB7lo1T3rYDU1jtCik5DRX/b
	CGGuFp7uoGOH8LLKe15sZcbWfDSw=
X-Google-Smtp-Source: AGHT+IESEXzGZ1flt8Bdykym8X1Nr+RXhDcGaSzCbN1y6Xld2xuH+84fmYiPtT29H7oMuZ48x9RgbytPVEbk6QG3qBk=
X-Received: by 2002:a05:6870:218d:b0:23b:ed9:1f53 with SMTP id
 586e51a60fabf-24c68d841e7mr1918341fac.53.1716364771232; Wed, 22 May 2024
 00:59:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 May 2024 07:59:30 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240514124411.1037019-7-knayak@gitlab.com>
 <ZkXpcvF6dxGr6qmj@tanuki> <CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 May 2024 07:59:30 +0000
Message-ID: <CAOLa=ZRNNBOzsw+EzEJVnAU0ZsJ-bcTpciExdsQz2iDatYkqNQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] update-ref: add support for 'symref-update' command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="0000000000007ea54606190650bd"

--0000000000007ea54606190650bd
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Tue, May 14, 2024 at 02:44:11PM +0200, Karthik Nayak wrote:
>>> From: Karthik Nayak <karthik.188@gmail.com>
>>>
>>> Add 'symref-update' command to the '--stdin' mode of 'git-update-ref' to
>>> allow updates of symbolic refs. The 'symref-update' command takes in a
>>> <new-target>, which the <ref> will be updated to. If the <ref> doesn't
>>> exist it will be created.
>>>
>>> It also optionally takes either an `ref <old-target>` or `oid
>>> <old-oid>`. If the <old-target> is provided, it checks to see if the
>>> <ref> targets the <old-target> before the update. If <old-oid> is provided
>>> it checks <ref> to ensure that it is a regular ref and <old-oid> is the
>>> OID before the update. This by extension also means that this when a
>>> zero <old-oid> is provided, it ensures that the ref didn't exist before.
>>
>> It's somewhat unfortunate that the syntax diverges from the "update"
>> command. "update" also has essentially the same issue now, that we
>> cannot verify that its old value is a symref, right? Can we fix that in
>> a backwards compatible way?
>>
>
> I think Peff mentioned [1] of a way. So we convert the existing
>
>     update SP <ref> SP <newvalue> [SP <oldvalue>] LF
>     update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL // -z
>
> to
>
>     update SP <ref> SP <newvalue> [SP (<oldvalue> | ref <old_target>)] LF
>     update SP <ref> NUL <newvalue> NUL [(<oldvalue> | ref NUL <old_target>)] NUL // -z
>
> this should work, I think. I will play around this and add it in. Please
> let me know if you can think of a scenario where this breaks.

Thinking about this more, I'll actually do this in a follow up series. I
want to cleanup the existing tests already to move them to the loop that
I introduced in this series. That would make it easier to test and
ensure that we can port the existing 'update' command to also support
`old_target`.

[snip]

--0000000000007ea54606190650bd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 395a362757c9044d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aTnBkOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXRzQy80ckFKK1BvOVBzMXFqK2ZYb1Y3RWE4ZDFkYQpSVDNUTEVobi9s
NWtkdDFqYk5BQkdQZS9YZTdIeWoxQnIxUW9FMHFyWWVIZ01zSkwvRFB6WmRSR3dKMkU3c0pYCjNI
ejJ6Tkd6eWRZcVJ6a1Bhb01lNFJvdndXQkZkeVF1ZnkzdFRQQTNlNUVrSnFGYkwrUHJId3pOYWVG
T0xDRjkKVmJRK0k2UlRSdm5tLzIrcFQzbytFd01pRkNOUndEWGN0Nmx2MG5nKy9aZHlLUTg0QkRX
cjkvSk01eWcrNmNMagpNWlhGV3hpVXZaUi9zTldENG43andhNWcyTnVrdUM2NGh5dEVIZmZuSGNW
MWh1NEZEWUxnSURLWWxKNmJqRDFKCnpNV1NHM3pjeUJtdjVoRHpJK3lJTVZMN2NQeGhoWllrNlNi
V2hBU3ZiU2R3djY0NFhFTTBpaVpQbGtxQ0dLY1AKUG82NElCdEs0cDJWazRLdUhSdGdsemRSelZT
TklETjd0amRvdHp6a2ZHeEQyR01oYkZ3M0dCcGhvQWEzU1NZVApCR0NVR2xJODBBMlNqOEpPN1JT
SXhBc0M0R0d2R3A0aFZIZEY4K0R6aGMwWlZsT1FLTGRXZUJLMjk2MXdYc202CnRHY2NONFlPTkxZ
YUZ1Wis5SSsyYW5kWUVEblRBWm9oVTZMZTJxZz0KPTY1dFQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007ea54606190650bd--
