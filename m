Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792504113;
	b=QBEWKl8oYcXGQ9Dqth5GbvyWOeYSmoN7jbfhEuIJESn3kzyk9YorHf+7DOGlMmxKhSQG
	 NzNsrLui9f0hTztHcuCUp+Qn0rio406bDGnltHKU1CzhLjDT96hKx/uW35IWAWbtGiFQ4
	 sVXRU/JGNGPNruz+wm/suYDrdlRWuL6YSQkb8R3LjbU8ItS89kB0NiYov/GcCytfkOyOJ
	 IMvMwUExf/L0dZShDGJjbSFE3wVJG5aaTukhot+2M7IpJEbLASuty9yVvifW0BGxbUwgT
	 QJ6QTb/Qbfx8F433euvPP0Aie+q3G0nwJZsEMg7plRsYRq0Obw0G3O+txP8NOsWZITA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Vas1Os7Ta6gwKcNxA3fkwRYxHKB01NQwi/+4xbzrUXI=;
	b=K7kHnr8gb1TjCXEApn3P8UgdSi9SwunUkb2kJlULCTEValqpbs4Md7cGd7IkTykZxqoS
	 zAOZ8oDLEI48NPZJqPlzVs1rQMeacksLKn0hF5xwRSfJYZszQncoRSEmb/0+yn5mAdRw6
	 mTISTh+asQqrlcrYkWCl/nP5ftcfH2Ulp9p5V2JHm5dQXJ5F+VYyP8oMfXp0AN0j9EP1g
	 /Rv7bxwwyWFiFbZq88S1bWnLlzmNZnht13pDWMP+LSG6zzV9syAdWb7uABzzVbDAmr4Au
	 d0Afx36hVQevA1cQBFiWQnIVcmfaikRk/RgoUOuMMUZpdm2AbMs+vsxaVy8EOaTIAZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UC+bmMzs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28E606A321
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B28E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UC+bmMzs
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e5fb79ce82so17223715ad.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792504113; cv=none;
        d=google.com; s=arc-20260327;
        b=e/pZjEx/kIApZqhOaJNi737dYjJ8oL3n9jT5xHT2cTtqEYfhPa8nPoKyovnyJneIHt
         9ZWYy0znUFGW5kewL7z9wFH7Hob+7lUw6ZyWx8uc1UxBfgaa6vFhIaIXQwCQtnZW9WYz
         Wut+kNhm0x4paZcInSN0XhcvhfXweVh1jCp4cNyJT6lon6UGA8aEnj+qQp8TqZpJ861g
         haBCa0tmwonl9gsXNVe+T5vuEY9OTLy0F+8PXDpaMDj0aMpEwrtkP8tp0/FszCzh7D8B
         qwg+KglN9QPjYRSiu0FxBJj+s0hiYO6T1+QGH7BFVbwkDx/2OdZXF22ucIUaWwigCR6g
         FlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vas1Os7Ta6gwKcNxA3fkwRYxHKB01NQwi/+4xbzrUXI=;
        fh=48WNa9zDz0QV5Qus1DGL+Tmin12GsynwYaZRfzcxOEU=;
        b=BAThNMjEKlBzMqv4vwEn+24iEduFZ/zMOQfAs2PxvnKTHNLh6+cummSBQsHcJsmKlk
         +uLbFGMPylrqxjSZoMTZi/DvhRXFposMyz+qO0kxHzb04spQf4qDmR7WQNJJNzZb1Lcx
         S3dk6mdZ9WMIIrskFsVvm60TGIR9yp7edK2kMB5gNSRfUleft/ECev9iY78hs10voCUX
         981O2xN6V9pORJNqY1hpLtAG5y7M4VjuKKPZOtdbu8RpDQNRXR4Z+7Tdq9K1WwbkSWSn
         ovEhXRp3iKMHcKAZ+aETB+rReRlk2YE2nzpqrJRd9gs4tnV4HGXyMswTy8GgFPLvMoEL
         xBWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504112; x=1793108912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vas1Os7Ta6gwKcNxA3fkwRYxHKB01NQwi/+4xbzrUXI=;
        b=UC+bmMzsnbTOI+nedc+QAgZ8lWeL05PEarFjzhIA5X42uOBAVeC89UO4gpEzXfqUPk
         VyEJ/u8f6xvArpvCjlX3HaYzwd8g64FlkIWdaOFTv4UQn5xGl31ct8IHwBXCq8ENiSOb
         9R5zdUdXdORZADOdCpVGQUOASuERxWqdYm5+vGaE6ehwkPBYeGCKh98rqOsQUnxjfCsC
         LwU6bGQfngLCBww27yYgBA20aHtT3QfarE/Jl/rz2IfO4ZmGvuEpdtZYXIfLjfrpDfH4
         Nj4EvKl6D38DOmASQUlVFAD4QQAvZGY7XWM2iozv5Ylcx/8KN9sMKTDOKzd0z12sXm1B
         Ooxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504112; x=1793108912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vas1Os7Ta6gwKcNxA3fkwRYxHKB01NQwi/+4xbzrUXI=;
        b=0O3MPea+N//ltL6aBNMqqL4QWGbHKcuCVIhHeJbwgxF3ICQNfTbtS6zqoe+CsPg1WZ
         +seq3TvoUwRzApxjM3iGUKRPTWUBzg+nMWx8DeKEzLHgqLT0t5ZM5HgoSiya2wRLCzgt
         7JSIm4uu2D0Ca0WA55pr3aNJs5VRTGqSsODLzS2Oee/Q4on600QdsvYpkX3a4YBc0fV6
         niRtP63UeWY29DVknS5hok0ncpdTLS6zcuYflTboFX4A9en4wUyOQSUEakJv3Scx8A9Q
         IqzaCKZhbNmWAM1C3lrDs2Cn/Q7bGyUWViQE4/DGQGw+ipfQCOwaoHlG71QeUu1JdGX7
         wEJw==
X-Gm-Message-State: AFq9FYJVHUjgMUj5Ijrs3HsBsgSwG8WvF7QCmP2OT0wk6/u3wH+c4Hm/
	zDBjxdv4K7AeDt+fssSNW6/8wmFTdsrgOx3XxIalYgMZjo6G9VaAyHeGjl7B7ecTczYm0z/DYzm
	2HyHQ47upc4rGiF5mm1bLQnASugn2b3k=
X-Gm-Gg: AYBFou1JGVBIRYf9yCrXIOiuupkVSpyJ5hygdfIun+I0i0UffTOFunEFuaoLK3ZHaE7
	WMzcPiMbP0qY1FW4kClD55n9rIriH8q4eFCOSWEdUO3fxBNlJ2W/+T/uoVuH6yVhXP3lipFqiWK
	9syV6wyxam4mfwbVJpV+ZvDW+xOzdkQJbtWvl9YaeRHm1eoxkelItAqdCgizRzc/S5nsNTsVJwP
	F2e/fWqUKmRavi21XVjATK8GrPoeSIYXJlHZBWdqbnSrzFWAw0dyY2nh4A9RjUHkTaP2dyLA/yr
	OuhCxuzimPwCOyqq+GRqQMELu2yFpJQEittlWvIMDc4KMqusdO0RIwd20Zt12BVz4IJiILp7NJW
	pjkv02XPUyiiqA+nwUAADgKli50FQ0SWdqB8IkbLXdMIVh2+owqPPvSEo6mmaT3r0X2q8kmoIYV
	xx2VlqhlelXbnL6ZhHs2C+W3PgVd4xytadd31SRea1JxsV62xynHBlPzEAndQiGxUh8ShPkfMyd
	QDY9AbeNAHEiZ4=
X-Received: by 2002:a17:902:f54a:b0:2df:35f1:8771 with SMTP id
 d9443c01a7336-2e9a6c24bccmr94018275ad.54.1792504112547; Tue, 20 Oct 2026
 06:48:32 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz> <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
 <612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
In-Reply-To: <612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 20 Oct 2026 09:48:20 -0400
X-Gm-Features: AclHuK9FnfKa737JETdZoThIxzbCrHzmJYO05oGe0711loTqPxRCQpIRLqDCHvc
Message-ID: <CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:41=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Oct 8, 2026, at 21:27, kristofferhaugsbakk@fastmail.com wrote:
> > From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >
> > Topic name: kh/doc-gitbreaking-changes7
> >
> > Topic summary: Move BreakingChanges document to a manpage for easier
> > visibility.
> >
> >[snip]
>
> Is there any interest in continuing this series?

For myself, I favor making more of Git's documentation accessible to folks.

I haven't reviewed the series, and I know there was some conversation
on how to handle links, but I'm in favor of the direction.

--=20
D. Ben Knoble
