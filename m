Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0085643
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963062; cv=none; b=Tbza4bqMOc+qhIoWd3G+ZVIyiMk14HEPfnWksLhwk3FYDNkwFzXmGNlG1SLeX2ZwDTNmoL96VO/hJzsKKR86YmYbK3os2I5x8/knxSwdqcy9vM7Wq+aQwVMfAbQdBSgVvG6f8TZII14Ih7PnkuqRIh0W4KonLvoBFgDWyA08DaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963062; c=relaxed/simple;
	bh=6yMyGEruA7+xa92amlZBHkbYGB5sxX7EnoClQSV/a9c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+gjwuc8W2on8GoS6fqZPHXb2cH4D0xZc3BqQ9eU7OhKVHmITv3qvTm+ZS4jkyGVbHDABCVGYji3nXMahvSg6un5IA9ZhfKpVw73hmUVbA+kH78J9VW7LhGV1F9QNQrR83slr2L0Rl3x6cRvEq81uIfpXtY70YDcRComCNYn4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnGsIpZg; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnGsIpZg"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-221a9e5484aso208641fac.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963059; x=1711567859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnMY0u2dfNUwHWvmT5X075Ch+kgs9DMKj+lxxrRZIOQ=;
        b=JnGsIpZgLeCWGWwkzphgZQjSizFJNyrplMDjZ9AS1GgqQKOeXh2KL61IilPDXLLJkG
         Q3i3z2KG+z3xUesGAyB3W+oOsP8S3kDpI/IPPbTUU77uaEi7qkycqlAVU2aQsJHzcyVS
         eXoKp/VjoVEEnkvYTBDhEzn5pXn1oE2g8pgPAW6ddXYHWpkNDP9SOmCy6qmkHcKmAl31
         Y2yj00HjV104amRfga3qiVIAEF8jxzC5jFDaVO9RFi6k1paaSmKyjE0qzElTJH+Eacio
         i6A+xif6Wwc/3L+G6obAOUhy+VhY9baXmaAnuiyg/L8MD8b7r4liz3gwYbANjEgl8OJf
         xQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963059; x=1711567859;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnMY0u2dfNUwHWvmT5X075Ch+kgs9DMKj+lxxrRZIOQ=;
        b=YoUxzYQe5xIt0y3GSrf3Vgpu8Hwy8W6c3BTVN1z7F0ktS3z+Uw399LHkvYGQZ7URyu
         GaeClp2ILNmyucQgh5c7dBqGqBKoMNm/t6hWKcc+BgBvQYfbRa/joLwT8F7XHDlsdcKF
         InAKPuHp9u5153jKmwLqyTuFHNkxA1wEQkaKT2k8cFqTe7aE5f6+pRqupQyCQpyRQPfN
         /hV4RZkx4Nqiz6NMlfpFTjKcItr7p8ipRTk2BiN/G1UWqBCKBF/o8cOyct46n4iQUBKK
         +nHc1QbNNcYaMjoOF36cfMfNhmHhPh8NeE9OIZGFiMSCyVr35P0ZSadVPL1UPIAL9e/9
         +CxA==
X-Forwarded-Encrypted: i=1; AJvYcCUxVw1oSsKHRNepFz24by4MNijXUm2NHP5pK1+KYbLfxIvv25hae4zhxpq/Z+V7b7hDsnCc74eOE3rMkFTFMvnykx6D
X-Gm-Message-State: AOJu0YzzEDhoW/IJPElURSQ3W6qm4NHSYazUpUkUsUZPZ1PWKVZAFakg
	8VoFTtAHNCMQI6kecDSHXF3i4TGhnfPu62NmrQljzNYW5AlNWfhfDq6Wm82o5qs9QBkdhVQHL5K
	U8+3llgI9HU2khBAwJwY40NsjNec=
X-Google-Smtp-Source: AGHT+IE+KmkpvxuQTn7WM2kWFu6rcYwk3h5zu22dGJ196UzkXLNtm+lRzl5pANSlKvN0stgZ4Lc6HK4BiEntyh46taU=
X-Received: by 2002:a05:6870:28d:b0:221:c9ef:3e with SMTP id
 q13-20020a056870028d00b00221c9ef003emr40514oaf.13.1710963059389; Wed, 20 Mar
 2024 12:30:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Mar 2024 12:30:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Mar 2024 12:30:58 -0700
Message-ID: <CAOLa=ZTgJj=moQC2Ve40KzSinmNGFwTSx_RcKaiCEQArcg8NoQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] refs: introduce `--auto` to pack refs as needed
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000610f6d06141ca1a0"

--000000000000610f6d06141ca1a0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
> The `PACK_REFS_AUTO` flag is exposed via a new `git pack-refs --auto`
> flag. It is wired up in both `git gc --auto` and `git maintenance run
> --auto`.
>

Wondering if this is also exposed as a config option.

> The series is structured as follows:
>
>     - Patches 1 - 5: Bugfixes and improvements for the reftable-specific
>       compaction code. These are issues that I've found while working on
>       this series.
>
>     - Patches 6 - 8: Refactorings to drop the `PACK_REFS_ALL` flag,
>       which isn't actually used by the ref backends anymore and confused
>       me multiple times.
>
>     - Patches 9 - 15: Handling of `PACK_REFS_ALL` in git-pack-refs(1),
>       git-gc(1) and git-maintenance(1).
>

I'm assuming this means `PACK_REFS_AUTO` in the last sentence.

--000000000000610f6d06141ca1a0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fb7fb8c41a124b15_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YN09Xa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menkyREFDZStCQVdjcGdPZ0R3L2NETDhLc3ZCWDdaaQpiczIwSi83OUh5
NFRpejJUNklJT1RyWGxkNW1sRGNpbFgzc2FQWnVlUHpmWDNHYnJac0F1enlnMmlaSGFQMDlaCndD
VU1BbFpyNWlwbG4wQzYxWjkwRXplNmtqemRrU2d1Mnp4TVdpVGI5UllsMEpMb0hBZ2daWkhkUkRj
QVhMeGkKMkQ3TmR3cnFGTit2OEpiQUFnZE5xQzlSTUxGRDU3b0tmM1JWc25qbC9xUDZPQ1VLWGpL
K01KM0dFZVNQNmZwaAo3bWxHeUR1amhEeklsNEtIdWpqa25iNHkwNVJ5TWFKdm1wbnN1RlVQQW9s
eHJSMXE4ZC96SnBMakIydFU3ZUxPCmY4bnNVK3dPUitlbksrWlB5Wko0cjJUT052KzVtaHFjYnFE
bE1BSXlDVGVKZC9LTVVJVWxmZEFlbGt6aU5nK1IKcWJVZ1I5M005RHB4S3BqdXUzWlBIS202STVj
Uk4xdGZBOTFBVmp4cFo4UFpjVXBmaTRzYW9qWTR5YWlEUm5tagpPLzc3Lzh4a0ZKN3FhQjRsYmxB
aFhTc2RJVHgxaHpZUEpJRHo4R2VRdkdFZnlGUnR4SHZGWTVZaHFOVVRhM3dYCnhaVHNuYmcwd3NI
MWQ4dGVMSXlYUE5LWWNQTjVHbnZZMzY1OC9XOD0KPTRqdGUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000610f6d06141ca1a0--
