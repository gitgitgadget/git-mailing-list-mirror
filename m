Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF98188CBC
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139488; cv=none; b=qkct5N8O3fTUbRV4Jt17uhcFo/NxkUd5XWtreLITcDPUeeW8MsZOlfoOzMdylDHZNHRMZQpmS0iqXuV3HThOdaSLbL/oV9a4tFDWsPje0X5rTOsnpTl0m6nbENL6T9U9v+UkicwpSW5K0QuoPevHMlOk9k6iRQd8NVTNxzdua/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139488; c=relaxed/simple;
	bh=J3129aBC0ZDbnVKQmoy3Midp+id4OcIGgrd2tbsPn7I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=gjt6Eo2bGmUIkHI5nLp2Dl9rAmTrfopcY4PfxnBGh8siTQwxPaaPnMw8NVf4bs4G6OaXVtAyNUVllIVyIOOVyx5H4BgJEC6tvQ8OSbSrU3QL3Gdxcxy6Oj332PDfiTPemECRP4RmTnI6N+o4XK7+JYMqmkFWpm1JsvtAiT89ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtwaI7/6; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtwaI7/6"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093705c708so4738165a34.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724139486; x=1724744286; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+EDk+Z2aMmTHR5aVQNigvGrNlmwvsT4+FKoC7xtzFE=;
        b=MtwaI7/6Bw5hdAB0+A9fotc5QRLMMlcmab1+DyhtKCI6knHR6T1JK9X8OEdROEsPQx
         NxUvVNi/QGl2C0vlPtT6cnfSDVAneIkWVNZHgbDYB3/mblE0xz4u/DCGpboEUCzF4xgS
         zer9Jbw99SBPPjBgcrtu8kxPglzHNHEbIo48ikRifXP+0xXJKaZ/p1QLarnMp4oq3w0e
         f0oZce4uV66/OQ6GawKZ/wSAyOJVs8217Z98eIjISTMB1D3aSxvrdR9RCEKSTcz7Nnn+
         WWLONZJDWK423ngmELo3LtIfL1lNWwdLNo1xpgiS3R0Stvsu3WUTvrIMm4KLxoUAD6YB
         BTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724139486; x=1724744286;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+EDk+Z2aMmTHR5aVQNigvGrNlmwvsT4+FKoC7xtzFE=;
        b=Grppa/DdDE7UugZfoOCHl2csKA2HM7Os3f8P5xZ/CKbAGVNOlIDB0i31Dgw2FDaPHC
         J7VWosX3jLGahEfutfbRbipZfJV1rn1yGmAg9xUw5/7T2dUFJW51NNxiGxIafrRLN+Tw
         3xY7aBzbO9RL6drDg1kY2cUv5CUVYKZTcpGQy3f4ZRpO89D2iSQI4r1ynySma1DN4oX/
         LcE2+kg9WniRTPFEDXg927dBiX0B90auRIQMM6/mG7fzGGgj4yyHvRx229a4hK/rorRg
         Oik8tL/D0OOXUcdIePwbAsFCeGv/U0Y+jbnG7+ZHhKvJI4g+rPot83xY45tbBjefQdFA
         4AJA==
X-Forwarded-Encrypted: i=1; AJvYcCVRn7kwq6GrxS52JqNpkxKD9owPI01ohiX/u1+MM+GLgCHGiqS4h8edicZf4l21AOlge9Ib779Jh6O0A9Xe4Z+Glt0e
X-Gm-Message-State: AOJu0Yy6vLGkSV7l5RKmwHKx7Ln1q1rp3xRGew82qmPo1dGJLx+8wj+X
	pkAkxPcpccXgfiGYKbeMBSVHFtt/UrsKPCYALxWgD+DYDgNX0P5Y6Iqjvm1DAiP6FWyKqBrsKNw
	qw1WZvwDC7NWjMstK+I6UW9ODRRicwQ==
X-Google-Smtp-Source: AGHT+IGjiPYl2zVH9Zh+7BdIrSsIygOi7wQsmUaXx1Y0vJz91B4UfCGTuomeKLjyFVlgvhbtJut5fX6mBShtiddxnLg=
X-Received: by 2002:a05:6871:723:b0:25e:fb:af8c with SMTP id
 586e51a60fabf-2708136ae73mr1645435fac.18.1724139486180; Tue, 20 Aug 2024
 00:38:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 03:38:05 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Aug 2024 03:38:05 -0400
Message-ID: <CAOLa=ZRBzKnVOhpgdWcwY3pJqR8ozSdVuUCC66sFw_H-LPrz2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] reftable: drop generic `reftable_table` interface
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009e1bba0620188197"

--0000000000009e1bba0620188197
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that gets rid of the
> generic `reftable_table` interface. It made it way harder to understand
> the reftable code base and is not really required nowadays anymore where
> we have generic re-seekable reftable iterators.
>
> Changes compared to v1:
>
>   - Fix some commit message typos.
>
>   - Remove some braces while at it.
>
>   - Drop the "-c" switch from the test-tool's help output.
>
>   - Restore printing-related functionality, but move all of it into the
>     test-helper. It has no reason to exist in the reftable library.
>
> Thanks!
>
> Patrick
>

This version looks inline with the review I did on the previous
version. It looks great to me. Thanks

[snip]

--0000000000009e1bba0620188197
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3eeecb6034070232_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iRVI5c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnlrQy85RitCWldaT1l2YXcwWU5yRWNrTDJ5dXkzRApKNDhIazFWVG5j
amhZdGRvODhrT2JZc25lMUcrT1ZLOXdsSmlkbWlqQzZkUXIrMTI0MUdvSGtDWTFCSWFPRzY0Cmw3
TzVZYjYwK3FUVk0vNFdPWFErTjdEUUN4VHNrU01hUUtvb1I2MjJkVGd0czEyMlNQRlNtaktZQ0Rl
RFdnZWwKckt1dUlJc0E3c0JyQTdNYXRVQ1pzTWlOVER0QTdOUEhUTWpVSDhISG5PemhnSk9ZMVIv
Slo5U3RrY1cvUWNoUwpEVm9hb0E0ak15bGJTZm9wL0JwQlh3UDVzK1dDTWc3RnBKU29lTlpFWkdU
eHBBUXZyeWs3Q1V0R3pXN0t0LzMyCmJyRkdrZ2piQU9QUCtQODB6L28xNEc3ak5kZklRNnBwSlQx
elNhNStWMUNtbGZCSytDd3BTbEx1Tk9kKzlPdU0KT0dVbEFHYVBCRGRJY2xHN2ZtOVJzTEZRUkEx
ZmFCT1owcmd3UVA5dUhxVU94aXFId0xXeWY0dXFkUWVvNUlydApnTHhZelhzWHd2alp2VHR5VGdU
Z0tJNUdnMVVDVlE3WVMxRFJ1LzhJQTdWZHpyRE5ianFkbjR6TWF0b1M5WkpyCmtyUzF5VGpYMzIr
TTZhdVF1VU5vWnZ5S3lsemk4bW9EQ1VONjkxQT0KPVVlNUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009e1bba0620188197--
