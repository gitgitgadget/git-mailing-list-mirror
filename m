Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391BE38C
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713696200; cv=none; b=AKWs2TVz/N/xAkCusfP3Qv+fgw6nNgcSl+rAfyjedokkh+iPlufJNeWGe3d+EOXXTJ9woJNcRHAvG+yiUKXyBgLsZjTFGFzMlU/3piZ2hwt9KNxMrflW5cq0adCbWjnwBJD6hA+syCDms7sKAHo4b1NY+NVyppL1F+h44comwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713696200; c=relaxed/simple;
	bh=7cpyuyDvhZ93JvYV3CZnbcWkww+V5RqnB565DwDumMI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/exAU7nu9v+w/PbVoB4O38ozEW+ifBFqHq5/mxrm+uC9Tq7k0ruVAAWDHd5xa25U3gEKesVXqTyWEUU691J/hqjTVgwQzgnKUzPAoEdVOptg+NG9RCI9R5pUsVgiMc7HwwiipgSITfkgyVGaMpn26OPm+oyO6A9Wx/KJkg8DhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqnJmBFn; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqnJmBFn"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22f01274622so1650969fac.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713696198; x=1714300998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UhxsnBKkDmvzlJuDlehr3VuhreK0w1EYNloUR5br99Y=;
        b=UqnJmBFnu0IY3vzRk69RnGSV8FdXLTVOxFi+Mocm3ychnfCu8EfE/Mji/RkcEf0UDy
         HZ6wqe41A2APp0AgaVI4iAhy0EDPS85bPNi9REn5vGAWD71pdHjARD7vMgfvWFHL9m0m
         PySbwrVm/DmJmPZjyiKgft/llqY6d8/+P7waGX2DUpmvHPVMwEzRIiPeTZslVXgAyWDf
         rOAI2fJ+MjrEBq1WE8hkZ19a0XmvAcn5fTPTngXnjhOSFVrc1z51G5oZFQjI5SssEmgG
         dnvW557acx0+SgeUEGR+uUrjIs5PIivgJYnTF3n1im+jO++jj1C96e0mnq6bDt2ZOPun
         dEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713696198; x=1714300998;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhxsnBKkDmvzlJuDlehr3VuhreK0w1EYNloUR5br99Y=;
        b=AVxtPzhL/ksECOk0b8sSbp8UdfUF1QFY5cCLR3/23GV7hocw/vLNZQdTb0H0qcmx56
         PJlAZFBfaGybFxJSKpzcu8ZEHxGFrG9YNX8lwXZb8GkZhqYGi1sS52m85lLN7H1EXd94
         QpM/ojbsaGE7khAESG3srta3HuknVEWdjK8xKXOb6G8E4kDSj+MzTIeR52IxB3dgXtlj
         Y7p/t75VNXhJ5xUURVuUqeJOy4CbhyaL5oJjqL0+AZ01xThaIJeHWT4TCoa0J1QKx6jW
         d3Y7JwUdAKdbkLvp164rYMKwIzU3/vRElhatEVZ0d3f57gsAqO64icdbipBrpd6qv0YC
         Erig==
X-Forwarded-Encrypted: i=1; AJvYcCWFBDxtfzFlKw+7pILhcB/V2xbb+uGiHlyc8b2Cpz0KoAvS0WSCXWsM6bYEGdDXf8CDjFSewce/WUMfskuoKROQr0YD
X-Gm-Message-State: AOJu0YxJoECKCcpN/ajmWZ4LEHWl+Dit9+SPAWrno5FdT8lvPnLqAdCu
	Y1hqq6on/DVlKJvM8425MqVubpnRhtMTmdeiyWutPqCrnJO3uZRegyuwWUNW2AarQpdtVCboA5y
	0tEJIS5xcuxD3t/VtqQOn0X2s3Hg=
X-Google-Smtp-Source: AGHT+IEoHZnx7cuVVH+eCioSIPyS9v+x8dh/u+4Rk8ZWLX98NZo1M0QRpbfmCrGnwgCIBq7u/RYkWR6PazGlX3rvf2c=
X-Received: by 2002:a05:6871:79a3:b0:21e:e476:9170 with SMTP id
 pb35-20020a05687179a300b0021ee4769170mr8679364oac.43.1713696198240; Sun, 21
 Apr 2024 03:43:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Apr 2024 06:43:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD1Fwq4exKKz3kyJiwcgtOe4TjQ938C=sAbdWOTsw6241A@mail.gmail.com>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-4-knayak@gitlab.com> <CAP8UFD1Fwq4exKKz3kyJiwcgtOe4TjQ938C=sAbdWOTsw6241A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Apr 2024 06:43:17 -0400
Message-ID: <CAOLa=ZRATdwogJfWH4y0htOzEK1SzKfK+CWXHjBny7waoodkNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] update-ref: add support for symref-delete
To: Christian Couder <christian.couder@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000026481c061698fd89"

--00000000000026481c061698fd89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 12, 2024 at 11:59=E2=80=AFAM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Similar to the previous commit, add 'symref-delete' to allow deletions
>> of symbolic refs in a transaction via the 'git-update-ref' command. The
>> 'symref-delete' command can when given with an <old-ref>, deletes the
>> provided <ref> only when it points to <old-ref>.
>
> I have a similar question as with the previous patch about what
> happens if <old-ref> looks like an oid and <ref> is a regular ref
> pointing to it.
>

We parse refs passed as <old-ref> and this would fail.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
>> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update=
-ref.txt
>> index 749aaa7892..ef22a1a2f4 100644
>> --- a/Documentation/git-update-ref.txt
>> +++ b/Documentation/git-update-ref.txt
>> @@ -65,6 +65,7 @@ performs all modifications together.  Specify commands=
 of the form:
>>         create SP <ref> SP <new-oid> LF
>>         delete SP <ref> [SP <old-oid>] LF
>>         verify SP <ref> [SP <old-oid>] LF
>> +       symref-delete SP <ref> [SP <old-ref>] LF
>>         symref-verify SP <ref> [SP <old-ref>] LF
>>         option SP <opt> LF
>>         start LF
>> @@ -87,6 +88,7 @@ quoting:
>>         create SP <ref> NUL <new-oid> NUL
>>         delete SP <ref> NUL [<old-oid>] NUL
>>         verify SP <ref> NUL [<old-oid>] NUL
>> +       symref-delete SP <ref> [NUL <old-ref>] NUL
>>         symref-verify SP <ref> [NUL <old-ref>] NUL
>>         option SP <opt> NUL
>>         start NUL
>
> Also I wonder if there is a test where <old-ref> is an empty string, so w=
here:
>
>     symref-delete SP <ref> SP LF
>
> or:
>
>     symref-delete SP <ref> NUL NUL
>
> are used?

I didn't add such tests, will add.

--00000000000026481c061698fd89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2f88bf041fdd199b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZazdjSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFhEQy85SWpoMnlKR2JHL3BuUDdFeXhESnUyNk1IMApnNXZ4SVJyUWdE
TVVkK2haaFFKN05ncjZZbUFqNnc5RmVEMUdEeWRBSGx2V0VuLytDZ1FUZXI3RmdaUmFyR2s5CkV0
YXpuS1lzVFIzaE5UNHVoaDlhK1JhR2w3ZmlIY1ZEZ1hQblRYbEtWaS9mVkJrUHE4Ry9GOU9GUlQv
NUpRSlEKUDhVMHorKzFVZUlDMzF2eFA1K0tIVWRMYkpXQ29MeVRjLzJabUFhVUc2TVdhMXJPYzFH
WG05N3FLUWxUYlJSUgpYdmw0TkJibVYxTzk0WEJ2VjY1V3ZLMjg5MHVicXNZcW0zaGR3bWw2ckl1
OHBKYlFacUtRVWxhdTJ6ZC9NOGZpCnFUUy9pMFlPTS9GK0ZPbXdBV29ma2dNQUlPL29VbHpaQlM5
bCtxbDdUbTB6QmxNYmtXWGF3QUQzYTJpZHc2eXUKV3NpdUNXdG1jVVRBbGxFVlBMRG1jVktINmlS
RVkxYzh2aVBQTzNKYXEyejJCZHE5MkRUdCtibzFhYXFGd1l1bgo3R3J0M3dUeU9FT3VDYmxpTWgz
RDdnWlVSb3VGbEQ2UlQ0S1RIVmVlYnQweXcxOCtyVmRTclZ5bTRPalc2cFJNCldkZ2JFYk4wNGo4
SzBqSlBHOU5lYnFKUDRBRHNaalQyeEhmNEd2ST0KPURRcXYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000026481c061698fd89--
