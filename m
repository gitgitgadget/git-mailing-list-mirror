Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FD61FDF
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733565002; cv=none; b=PyNUs+J98g9Lw+mcUmQQsO5LMvh/FaArfHug3p3Gwvv2BOA0xn9QZZXgT1AfW8/nVYMzG39qTZUddpFMXAo2mtuN26gypCpGLfXr/ef5zSkkpPjEsh1gVxoIH7BjzdiwvTHLwy/cGto/6ZurS++C9nC+R7776SZf9BCi1wd86E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733565002; c=relaxed/simple;
	bh=cUAvxwH+KSlutt4GPj8jaTnUTso/rq2WVDNByfwk9jw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM1GdaSUiRjZE0Wgb3w1GsG2CyGtLtEU7y19+e00Mygk7eBK1UA7NHgGcb4rZr9/N+EfHSCJRm/yImY3/AXDStXGfAHl0QmE302netlRWlDTRAQvw+peTeg1Yk1r7YHnm99CEilc++tZN3HPHRoxF2na4D0SS27sz8AZ6Ok1IYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzLTGEED; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzLTGEED"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-515d5204eaeso761658e0c.0
        for <git@vger.kernel.org>; Sat, 07 Dec 2024 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733564999; x=1734169799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcY9397zlv1S4siLGNfIhSdWjQpF91CpCrQ1W/we2Vw=;
        b=jzLTGEEDvUoAm797MoP6XwDWAvQQSXuaL32sQFFLhOiblxCRR1/czDQ6QrgcfOfG+y
         gvYoiEXYSGznBHUV2qqP3U4hfkGRCL1aXkEIpA4WjXi76VNr1JyhNO6f20ey9ooO2RwO
         JDR9LToBPjBcVfClt50hyGm6AEej4kB3Lg9DWB15EI18ZQCH6fSMkTLPbKL/+DsclPnU
         TtyneP6KHwSeMK21tHmZ2isoViIcFBXQGgIR3iHBh4RHBaZEGd1gZDMkjnWSe6vO7JMH
         TXsphRanyAer0RQkSbYDJTusNHw4mMs/1/pAJV/bE7Vx7uTNAbIxXudvD/tcoi+6Hj6F
         BhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733564999; x=1734169799;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcY9397zlv1S4siLGNfIhSdWjQpF91CpCrQ1W/we2Vw=;
        b=g8dEfblyUVjsJDjm/f9Ebk+/nPj+JurZNpRPRtvXy0Zc4yD8Uo2epxwhPv2UQdDQBS
         0E2pBn40wMMl0uNkxupipOmSV7GT/Do6RODedRBBPiINf49WjIvHvPd+gZN8Xihi+Nuk
         Iy31DbExBiXevy/GM8vqVU1i/KCfMqSOH4w8E251MsZmiYUgjt0UYiwtvULE1mdEQoci
         z0jEueDoFFnm/mC181GShzj1mvW3/elX5+Lkfosy9ALCKaXRIE1wg/An4uXTajLPV1qS
         0srSFl/N1dRe+Ayim8gRMK8RSp/CQV65iwmS6UmUXtm5rs77duuA/c7ZhrLuUcYKSmnE
         Jf5g==
X-Gm-Message-State: AOJu0Yxynq7KAT2YbMQ4GfxetanT6kRnUmH1s4lRIF2t8tOiNcZml1Gw
	2kh66wAbH3gAGKaQCmQ9ssw//16RO2ALJDK0fWgLdB4G8WNU0TWxe6ybyNaO+WRpkQ/j6r/2T0W
	Xyze4ZdTVp489RnUSo8DsB+3sY+vnGN4D
X-Gm-Gg: ASbGncs9dTw7N8P1kcYYWuXwdacd+ZpJiDAR6jAHB+z/ec83cJZBpr9VP97fsTwygR6
	wSwC6dXZQu2c3Wk6QRbVx2jG2TDQLqpRFLENebrx6MAldnOuxLu6f91/PC2W8ojDT
X-Google-Smtp-Source: AGHT+IE0wngiACo9UFkcGk+TUeUvfGbmG74eW3yrDH825ivABciB9QplWwd+hp1xBL7NqxJS7QF4VuA6eaUxsimzdeY=
X-Received: by 2002:a05:6122:6b01:b0:516:18cd:c828 with SMTP id
 71dfb90a1353d-51618cdcc78mr918490e0c.7.1733564999302; Sat, 07 Dec 2024
 01:49:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Dec 2024 01:49:58 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z1Ln2492OCTwbII1@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
 <20241206-pks-ci-section-fixes-v1-1-7ab1b69e3648@pks.im> <CAOLa=ZRUZC9KDj9F6iLWWU+CBHz_DWKA_8znM=7RVSCVGSeD9w@mail.gmail.com>
 <Z1Ln2492OCTwbII1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 7 Dec 2024 01:49:58 -0800
Message-ID: <CAOLa=ZSExxSOna9Py+5Gx_dpLgom-fX48TGvcsi71f4xBXyoTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] gitlab-ci: update macOS images to Sonoma
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fa9a9a0628ab0d42"

--000000000000fa9a9a0628ab0d42
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Dec 06, 2024 at 06:39:59AM -0500, karthik nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > The macOS Ventura images we use for GitLab CI runners have been
>> > deprecated. Update them to macOS 14, aka Sonoma.
>> >
>> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> > ---
>> >  .gitlab-ci.yml | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> > index 526ecfe030a43e0a5a83ddd35cb7c96d46ab2485..61c56ccac8fdc940075d91dd4cb0b54ee33d5199 100644
>> > --- a/.gitlab-ci.yml
>> > +++ b/.gitlab-ci.yml
>> > @@ -99,10 +99,10 @@ test:osx:
>> >    parallel:
>> >      matrix:
>> >        - jobname: osx-clang
>> > -        image: macos-13-xcode-14
>> > +        image: macos-14-xcode-15
>> >          CC: clang
>> >        - jobname: osx-reftable
>> > -        image: macos-13-xcode-14
>> > +        image: macos-14-xcode-15
>> >          CC: clang
>> >    artifacts:
>> >      paths:
>>
>> The changes look good, the documentation also states that if no image is
>> mentioned, it'll use `macos-14-xcode-15` [1]. I wonder if this means
>> that if the image is unspecified, it will always use the first
>> non-deprecated version. That'd allow us to not have to keep updating
>> this.
>>
>> [1]: https://docs.gitlab.com/ee/ci/runners/hosted_runners/macos.html#supported-macos-images
>
> It does, but at the cost of potential breakage whenever GitLab decides
> to update these images. It shouldn't happen all that frequently, but
> when we notice that it does become annoying we can iterate in the past
> and experiment with setting no image at all.
>

Yeah, I get that. All good then!

Karthik

--000000000000fa9a9a0628ab0d42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1b147fd1bc770216_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kVUdrQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3U3Qy85Y0FXZmpZMDFxTGhvanV1ZFoxNmYyYTEwUQpSWmRZZ2hEUlBy
ZkVTTm1YbjFyY2FYY0hqY25ISGN0ZjYwOVdZQmxxMDdodWovS1VZd2VrTmxiZWh4R1g5dnBXCmwv
OWdmYUgwc2hoWFZ0SDVXY3F4dWszMjJ2cFJvaEQ2SXhOSmp2cFpZbTlEaUw1cEJFNnU4Si9Da01j
ZS9QcU4KUjNXMEZTbUQzMWVTWTdtcW82Vm9na2FPQVI4QjJ6KzFVNStUZEpOU1IySDgybGk4NzIx
eTdhT0E1dmpYV3hwcQpDWG50Uzl0UzZhWjBZK1RVRkQ0NEttOUhGSnY2MGFFR2pybU5SaDFqc09q
ZHF0UjBXTVBSQkZCWEJXU3BKWFNiCjhxWVVydXROYjVZVXRvTGxTcjFDWmhCU2gvUlk2cysxSG5q
MTFjZWxkSjRoa2VkOHV1Q2dxN1lsd0pLMndIYnUKSVFKMUJoa0hKeEV1Q3o2L2x1WUdJVXB5ZHNX
aWhLdXFLOHVCWDJOK3hSVzVOd1pnVlNUZ0xlY3NUWjNLbGNRRQovaTZkZTRkdGEvdGZKNEl3eHBw
NXNjN00vczR2VDgzdElESytLTDBJZm5WU2ZlaERHd1NiamN1ampDZThFNXh3CnNOUjNoMkVXLzN2
Nm9mYzNHWUZ2MysxZTZ0YnAyMjFlT0pMRTlHbz0KPXJXUHIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa9a9a0628ab0d42--
