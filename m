Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793218749;
	b=c+juEPlWsRQHj3VP7dLCyB6iHw2eqVS1mNE8MvsnR59SZHngJT8f/JPGKTtt0TfCJ085
	 uz4WgnkQ4hl9O/m9EgjRM0/d7gXmo/zlSxzPeBRBK3Prtl8dT5/h1SVY8dWsjtQWRbwgd
	 wVV4MKVA20U5xqwHKM+vppAsPXDe/LBSZmVN4CS4bzUlA0uib74sQpKVhZLYk/XaXv7mQ
	 27HPo6M/xA8uVtwG6rsoR8hxYUAj8I4qEvD8fQojJ6+KXNO8FKPaRUV0EfG8zLx6FHaNC
	 j9kPb/bGeLmnWUWfcemSN7dF1fJ3UDabYJXqul41i9fRzG8H3AWyS1a6Oau7syFPlMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=8RGUR7mgygXjvcgGXiFcsrbK4VwawjaLnBE7EIN0vfQ=;
	b=38h2Vn2bE95ERJJhaS9vX+oGhzKMxx2DdFk1WqMuFvzTMFIeQ9NqqVvUqE0FPhhQP/yw
	 1MShWLgTmioKgGwSQtDDlPgo4PwxsjMKN/2rIZ4BQl/+h++j9NN5XC8e0tUz6sYhmPg0Q
	 WDTibBFbG2XmscCBujKZNUUZbiz2il4CI9ohPU2RUKhjWf0RkEhA3BW/usPuF3HmmAjkV
	 f1Fx9/HZLcHYmbBFruYjV+ZR0STQAxOqwXh4oxWWG1e0xL7wlQak+uOsxLmPFK+PtJKGr
	 3EJ5F6ztQiS1on/qKoSSqt3ISJZAXiQCPPK3ec5ozoAVq0L6L4Wr3YkmcHFbDTp7Btw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0XCMCKR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFB606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69CFB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0XCMCKR
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9905d61449cso496995241.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793218748; cv=none;
        d=google.com; s=arc-20260327;
        b=m3Uw6960X/8YrogINMppzqbwiyXT8Y34nC8DBmq3HPHZhmLJK0hytBHKo2H8zscQlE
         AhUus61/aoIRCRNcTgTCubEvoXnC6LEcm40XqN2QOkIOmwFb3JzlDg9zDP/YMIg2IwbN
         jcAbXHMDCKQLFD/5KJ9oAxWyNPfqKtYx0jEF7pF+PgQFO4x3bWRNaoGitEGgxOR1ll9+
         Dc8wZW1bCEWLTI/+jmgGOYyhviJGcaI20cRCEUw8q7CV+Eck4a5fzXprLKUV+nV4eVam
         swsL0prVYOCm7a5OLvtll/3QKhkVNXtNfbrUFnsG7C4fxy1qcTsRKyqBtGJRlliCNivx
         P1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8RGUR7mgygXjvcgGXiFcsrbK4VwawjaLnBE7EIN0vfQ=;
        fh=GGWEzrIIQ6cHJJb0qSNwyEDctpXMUll4R1Dn3XJ2gys=;
        b=QxuEfCNXVPodBuxUKn6YeDgZPFahBrgI0wgwmYLDF47KBFsWbAYNa2TGnEpNhOOBRT
         xL7hpBVmC+W0LYAuE4bDwdYhRGZXGEO5965BezKh4ah6TqcqA6DR1AqzKk/EFTisLuMp
         MmBWHhpOE8aTpsg+DqkpjEplkyDe+6khoZ2S/qBQQ05CklCuyMI8pAxhnwiIPs1GpuPH
         x1w91GoQ1s2jgBYMEmUqRiUyFzQAWjfwIBT7Gh3qpXJ5YVFcQupvUepLBM74+geU0TXu
         bdQ7qsNwpt39J15Lg38m4GllexBp52aKXLemwJ1BQ5cyA8E2FxlupYQjhmj6Pz4TZy9/
         NkgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218748; x=1793823548; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RGUR7mgygXjvcgGXiFcsrbK4VwawjaLnBE7EIN0vfQ=;
        b=g0XCMCKRYu0wOK/lDV3ypNQQN3GTNAnKDwt/UzPYlixwUbeB1itzlwntiFGTU4AuP9
         pdwav4MtmgFB7+bfm8Sw3wjQkcpYS3NyJVl518qA5fJqU2ESof4wcoopoftRK5GCn9yK
         R8DqNf1LxvAoHsLhhoYx+/DQ+iUlsxGcVoyiCQ8pvR5K9GSby+jeHS+XfJOqgbTNXJo9
         CqDEPcecmiQjKG3E1P0nxgwkdd8e5sM0lE2tyDhJ6WF7Q5jJRiiIWXzmfbmz4mGjEdOH
         xmg6ho8ekzCAc0uVAbFaZ6fteJ/LuX/KCthhmD6Pj3YlfPxbCIFjo1f/Iwux/QqF7tVu
         PEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218748; x=1793823548;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RGUR7mgygXjvcgGXiFcsrbK4VwawjaLnBE7EIN0vfQ=;
        b=hWeFDebHC11LkfhpmOkBUi9Gz1FaxQmFUilt81NG5H5ifR3zEP5mRaGQRzKVkTsut6
         sel4ADZyQI5oLX2X/jcDjbpAv7Jiu1rfh+JVVFfEvpAAgFwO38qFcvh5gNAdzuxmWRiM
         XGFn3fR0DYbVyYaffUtXmV0HwwROwQJdrL5k3l2wtUFtXfNd5F/Od5B+W57vPdHjeJdK
         K75XhI2S42Yu4aUOB8CotEKhprN5LrbL6Lizq+DLUgD7T9P+ZrNavv65l2jUGkrM5Dx3
         TFhVOy/Yg0EYRolsFL7wPVCB81GNVBsYA+Bxk2NLrLRWYPDfjqqBJeXjwK9gHpmy6Wwa
         lkBA==
X-Gm-Message-State: AFq9FYJQvTfvJnG5RlOVXbQpDfZHSarys/7VEOaCC4boot/mNX7E1YzW
	D6Et6lVLaGpw5lJlrtmL54HRv9cDz93Jj+VqS3+4B+q5uH20EvNnvESOaqm8/ClTK+KyD3ctyNm
	MmsyUVNgfaC3KGJBUdf6Q+mVghHG16v4mUw==
X-Gm-Gg: AYBFou0xKR672p2917ug+cxh3IWA8Ud1fNxqteEkokxhZWJQmzX1aaAa7cCq/1nlEg2
	8cYhM9mdVNHk9NbYvHwrgKFcOpbQT7cJOkXSxJoMOEeYgs64mFmO8W2Qwm84Cx0w4o0RF6lNp6O
	EX3UDPoB4Dtgy3aO7RWrdVIkD1JlGgKnZLlE2Rdur5NEsk0C4Fb26E0Er4bGVjom9x71UpVN6Ow
	sFoY0B0T5tzSjFjEIIicTh0H6ub2iFFRLJYjUHjv4jEjta2HSrHpPBtg9RxOYsQ0QKp6b2bGnKt
	ZDmHWD1mKYNbVuqWqBCGgnNLSAhvcQJubrETs/K1KPWRs9OOwlOrQWFWEV0RKsZukSr4mrAV9BL
	ykeY4rO9VnwHZkKXfuvvNlbUkcR6L6+QCeh1ZqSUHpDhPMWvdydIrCzFPMP6XPVPqzFZQsQ02Pi
	oT3Rkwbl4F5A/JOlQvei49i6UgQUc=
X-Received: by 2002:a05:6102:418d:b0:7cc:1a41:20e7 with SMTP id
 ada2fe7eead31-7d03a504abdmr1449973137.7.1793218748220; Wed, 28 Oct 2026
 13:19:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 16:19:07 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 16:19:07 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <auHfoVfHQJ-dRwkM@pks.im>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
 <20261028-799-shallow-fetch-with-tags-v5-3-7c43cc9ae810@gmail.com> <auHfoVfHQJ-dRwkM@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 16:19:07 -0400
X-Gm-Features: AclHuK9ZtR7pIwMFWsbQN2itET3k0SsBpKjCHlh1iugRFbHJJ-twex3NreDRgCY
Message-ID: <CAOLa=ZRksy4QCRDGsx7L6m-zxcj73TrQHaHAJ6rKhHXkrksWXg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] t5510: cover upstream info update on fetch failure
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000007e31da065eec4664"

--0000000000007e31da065eec4664
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 28, 2026 at 10:48:01AM +0100, Karthik Nayak wrote:
>> git-fetch(1) performs reference updates in a single batched transaction,
>> so individual updates can be rejected while the rest succeed. Even in
>> that partial-failure case the command still performs the remainder of
>> its work, such as writing the upstream tracking configuration and
>> backfilling tags.
>>
>> We have no test asserting that the upstream tracking information is
>> written when one of the reference updates is rejected. Add one.
>
> Very pedantic nit: I would have ordered this commit before the preceding
> one to demonstrate that this already worked beforehand.
>
> Patrick

Fair. Seeing that both comments are nits and minor, I'll make the
changes locally and not re-roll unless there are other comments.

--0000000000007e31da065eec4664
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 34bd6c638af2618d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yaVdMa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM082Qy80aEY2NWIySG5PZjNUKy85bHpoK0FZbTZBLwp6UGpTR2RhV1g4
Z2ZzYUhvd1RIYS9PY1NOZWpGZXRLbGJPbGlKYjQ2bk9wTUxxNnNCRzJQRVVKSVBFMFBIenpUCjB0
TUYvOVNGd2JRNjlNbDBEMlZZRVVSVWUvdURmaksybjdhck5mVG1WRzJ1eGpaM0hTUituU1EvMk0y
YnBmUlgKRmE0akdRTFNEQXNCR2xIV0x0eWNyU25odUM5VW5tMStjWWxiYk9PeFVjaVA5M2x3aXIv
UFc0UTNEczZsL1RJTwpuS2FGTUtXTXdkQ3hyZG1DT1lPRW45TTFBK0tYOWZlNHdLcElGV1pMa0x4
RkxIazNJSG92OTJObjFybUI4WkNECis4cjBvRkxJbm52WDRQNHVpL0xwcEIrMUo5KzRqNHRXdXJF
bTJYTDVYU29hRnhpREFXM1l6RXIwbkI3NDVoeXIKcmthb0FuQ1hrWVBscnExNlRMSyszREE2RVZr
a0tBMVdvVmNuUlZsbFAwRDRFbC9RT2hiWThjWjFFKzdJUnBoKwpLTEdTZUd6QUk5and2MnFJU1ZO
b3lEWXRuZ25vZzEvZ0FWVS83Y3UzYWxrQXBpY2pDbytHWkxrVERxeml0L1N5CmF5eWVTRmlmWU1z
SWZlaDRjbFJhaUZTL3diTURveXd1NDF5aCtGbz0KPUhBVTMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007e31da065eec4664--
