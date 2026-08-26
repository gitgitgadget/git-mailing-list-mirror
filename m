Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913F381E8A
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733356; cv=pass; b=P/bdsxAQkcSTsUJXIK5HGgqAC7srVPNqYTnY28WK5Z9M7Dc8f7HdlpW5a3hO6LAZPNqH4GfkCBaDkNMGt0X0FTdCC0XDXrDYQpTmETzBjzz1h6Q0ePyW/ruc9opvsADrkqkJyNKdOoRNhQ5mQgM+YdHfyqGErTyMv5xsbzTmOhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733356; c=relaxed/simple;
	bh=9zQg5WW80hwQB7HNLI8/IJCf3h+uKz/NaMVLS7v6K7I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARTe+Oxh6Cjh+VGXErE72SqL7VHo3aGBYLj012Y43N2/MUgLpB6Orr8gvsd5c4PaIxBG80k1d3DSbqRKyJN8aN/plprfiNDxjvNOEwjCGODpEqEkRqzVKSQ4hBUV6mSsM7o7lNkIptQ5lntybVqdzv8VOIY4F/rC19lSnO8GCHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd4l8+yB; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd4l8+yB"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7564b7a9490so1287700137.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 01:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787733354; cv=none;
        d=google.com; s=arc-20260327;
        b=lNAy4ougkGTHezFR/iMQr5le19Z7qwAKpfmKbTYejKw69iqaO+bM0hNr8TZrW1JIGw
         Am0zrpZfPjCGqCM8a1GdOMROqA5GLa8J9LqQDjvrividjmZGnfnpby6Tb760V4fC5Sui
         UFRa3ULm4A9HcoPZOhg8uvGpATa9rBvTHzX6LsqoIVXO5IuzaMEuDFZA7HYgFmmpta5S
         mhfXHUvXy6DehureHi+RcNpZp3qDRIIJ2bvJaw1KHuTJGslTOcnjKHbpbJ5ooT7jSWaq
         WZQu6HZTsTBcJeXBst/txKcb3WLf87435TbYThT3d9MylrjYOGsq4blrmFP33lg7rTXu
         IFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yJXKX1UqxuPLfklWfYp9x+d6aT7z41iOXWsG/4MT8/Q=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=iUe7aXkW/tmJKq1wC3JCBDtbPTP+CrmtHZG3dc+3w/0KHTCl6XwuYxoS0EmUxluOvP
         84+Pd2LXq2B73lUrqUYobHGtIikSCiWJKT8YMQNBgERcTFDtG+nJDXwTcL3Q4qP0H5gq
         jajWP+baheohjewuVtl38DfEOdzv/790yZhginlAvctTc0hM9L3eT7PlKHq7y/0+MoKo
         oKoqtqP9Rt5TyJHFR03+6AG1HXF94RdlSKc/OwrV1wvwpMwkj/k5VkacaoZ/jMNxc0fT
         IiZirooUWhpiTUkOx0Tn03XuKHiCZHE5AIxxJ40J7jF8sIrtg3VuYL5xoVjrxvkAxu4X
         9fOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787733354; x=1788338154; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJXKX1UqxuPLfklWfYp9x+d6aT7z41iOXWsG/4MT8/Q=;
        b=Sd4l8+yBzihDJqWejb601LeY9k4GJsMdasW4KF0oZFxzMoR2nAYmeWANi/CTfF3dym
         Si/4OWQ76KimL+51aIh52Ck5O0LqEHNyoqwRiJepFvtWkBV4pcFPmDgV4KJ29Hxv+mqC
         4ZO8lybYRtE/zAfousRrY2y1494R5ESAhLXBp3MTUvU3Kmr2iBuvoGEc1LRAHiFO0Urb
         7KicBslEu0e0UEJdBtSOR3mVjwRNajI6aROCESbSaMnl+e+YS5NRERmiei39w7qOIXsj
         qCiCTKFxUd0ekk+yulLbBrnBgIEmzOmLRBl2MR1rc+WKCdBMzKPAWEtGwZCTqpWhwb8j
         eOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787733354; x=1788338154;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJXKX1UqxuPLfklWfYp9x+d6aT7z41iOXWsG/4MT8/Q=;
        b=cSl4SLIhZOMC/VRJNZXnZAgK2Q1gHb8fI2iolv5eeeG/xFirCXKWDTc5bmInQJ2IN4
         AiPwJ08YzLbOMNe/Q8perEHltvKQjRlqi6qsmMqMfLLzK3iFIOyDSEnZZZ9h7CupmN17
         XxYriS0lUJjuzs4FPBoI8Bs9o8H9/8Z02hHNkCNbTmhbrTe0WW0qaOHteAllcKMvu4N2
         Rc2pbFqXkvdwquB0R/Una9CMfqjbC6oxrAcUPWTNZNns4RrI+lwQ71f3jme1HVFnj5sU
         BoBtz6z7R1tUwwQTz9y8VrlH7O37vmxbame6j+1MgLiT5lh6XehwbsMXKFXPCiUeoY7J
         X88Q==
X-Gm-Message-State: AFuF++n+pVzadfAHwBTePilKXy3rjGqNHdNl7xi7kDYYEE7uxHrRNDD9
	jQlay6NdUpVgPYqNGHcR7nGq3OjXD1uYzX1T3quJAI3ydczWoQqE3eTG8l1OsXYuuqMaKxDEsHQ
	B6PCS2qeMlRHYEnFF0L783/4lLJG6Ka0=
X-Gm-Gg: AR+sD103GWDzqRkOixcqjE3DZDmMM6tIZI6jhqEmJNaDrI9W45GeOvnOwUCJWvIWCOT
	Vt5KZFQcjQrnENH7vfO5DU/km1qipMVPHRedgYe3k7X10Gdkc2sBpyUC2sEtvVbm8P/1ASZlmc4
	Uiu/pWn4qODgTydmH6g8VSzf+HJ0Rwor3IL8ejBpyKz3pg03SncPZmDQeQZM9rpg9+0+2P9uEgm
	RgE6ffMcsO1kpQ6VJEZjiWfI6GxnxNynFgbYPkxjh2dKVwR26Lv3jfD/BlqZ0pUyr2wFUcTk2ri
	U8aO2bA/YA4SiAMouzN+X91nL5MzhtpcZE+k1WgeW9IGAye3XfoUGIoU8QoY8CtYTBtHN40Jt3I
	1pus/1nhqeiJfnQa0JJIh1GZUYTyX5O04WvQ=
X-Received: by 2002:a05:6102:faa:b0:780:8618:9772 with SMTP id
 ada2fe7eead31-782bbb2d78fmr1217853137.1.1787733354108; Wed, 26 Aug 2026
 01:35:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 03:35:53 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 03:35:53 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv78zr0pa.fsf@gitster.g>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com> <xmqqv78zr0pa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 03:35:53 -0500
X-Gm-Features: AcwNN1UsrO0Icjdk_qkJbD-psWmlNOGoUb9F0ke-MIkkidVcqr5ayE4oAzfhfoQ
Message-ID: <CAOLa=ZTN_95gsySKqA6Tm2daaKYNcM+V-sPeBLup3vDr1BznYw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] hook: introduce the report hook for git-receive-pack(1)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="0000000000008680320659ef1b0e"

--0000000000008680320659ef1b0e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> ---
>> Changes in v3:
>> - Move out addition of proc-receive hook doc to 'git-receive-pack.adoc'
>>   into a new commit.
>> - Add a new commit to move out the response generation in receive-pack
>>   to a new function.
>> - Instead of die-ing on non-zero exit code, we modify each reference to
>>   indicate that the hook failed.
>> - Instead of correctly listing out the protocol, link to
>>   linkgit:gitprotocol-pack[5], as the protocol also differs between v1
>>   and v2.
>> - Link to v2: https://patch.msgid.link/20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com
>
> This has some interaction with Justin's pluggable writes series.
> Please help sanity check the conflict resolution I did near the tip
> of 'seen' when I push the integration results out later today.
>
> Thanks.

I had a look at the merge and it looks good! Thanks

--0000000000008680320659ef1b0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3e86321d5968655c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xT3BXVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmlwQy85VnBLeXh5NXJiaENZeGhlSHRCbEdIaVhvYgo2d3JZbzBKUnEz
RVZydXA5M0NIb2RqVC9jWEw0VzU3UE55YmsyMEErQldGZm1kR0tnbVdzMndvREpkZCtUUndLCjZ5
eHk2eTZYMllzc2xyb3pwQkVsdzRkWHFyZUV5OGZsemtIc1JseUxvWXlzcVlxdDZGVDliZHByMmZj
bzFxYTIKbXAwOUMvaC9VWFJYa2pkNVE4YkhPTVVvd0hkMEtSMUZmVDlPU0psZ2dQbjhsakhUcC9P
bWQ2QWIwKzRCOGwxeQpsZVNEWmdCUjhQOHQ1MVZzU1VRY1BVdXkvRVJxV0h0dUFxTi9HMEFIbTNz
YVRZanNFSkQxbzJjbHlFUWl4eExLCjFvWnFvU3BRRXVWWWVxVHVZY1ozcDMyNFAvNit5c1dRWnVa
ZCs1bW9PeWIxWmd3NlBPd29LU1pHNHp4ZkhPSDkKVzVrYzAzdDVpK2JDWDUzTC9WN1QzOVYrcDZh
ODBWWnBIWVJKTnBpRTZNNGJUanRFcmM5SHFzMi9aQzRXUzFnawpjYVNESld5TExVbUp3M21xb3dk
Y2JFQU51bTA3L0R0UVhKUmNGSWI1Mmd0aXJVZTB1bEN0VzF1c1hlbUQ5eUx2ClVsNlR6Skc5K3py
ZFRKdDhQZUQ5cXdSQVlpYmtIdStweUcrZ05pST0KPTZMU3gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008680320659ef1b0e--
