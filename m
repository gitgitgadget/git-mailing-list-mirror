Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792445415;
	b=F4Q/4V9Tl4JXee+QYuLQMoWpRJd/yAwlIl09U51DWCv+qrC3preu9Kz2A4e2aR7vs7Kw
	 HSL9On2+wwVj1Zh6ZmQ13x8uihf9muAdynV4sB/9VflE53P9nK03RAmeMMcqeM1054y3I
	 l3ivexNeMQzhN0/FrQ7+Nj/Rt2RBI/pLBSU41tHS+Qf5/sPHctgcoL5pSslZLgoXJmCtq
	 btFH95uvrMqA7TOMAfw8QvEBgV8z0uk9RyVnIcN5/xM2BlYzes26F2Kmn8hAT+wIuL/y/
	 TNgr0fHGhreTTwe5+rJOCuw22oYZwi7GGYseFXNjNqfX7PHtsQxp4xfuWM3hiEVrNgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=heiu4vZgbrKpTKU1I3rmxaSRHN7QobZOUW7xYNQMOHg=;
	b=Wsy650PBQC+8RpIe5MFK+THDDc+qXP41VsyzHLDhoeNB0wPOlaPoqLOT0GmQOt3fOwJp
	 dca8sFIpaUEV5/YUkSNi54f3Jp6ZnKqGlPIG5GdD3+Z0bvhMqp0ffFzmzMTjEjnIg7Eqw
	 4mBu0vLjCUqTEbkLUJgsP3/XP6+x9scQdp+iAPBefc2Z6BBtSRTZ4Qq6UvCGkw5QQVDPZ
	 ytY3cfOetTWxFFnhLObyiHxOlvWGsJG2LJUQ7FFgIMWqZ5hsUMAtUPnn/ZYZTPcvz62UR
	 7bIzNAWkAjno9Bf7VxEHHAAtYF3dkHXOD7jlRQZdB8gtCm+YR9Qr6FPDWtf1WiN1KJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="IN6IYm4/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EB0606A31E
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35EB0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IN6IYm4/
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-48e94879f02so811077fac.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792445414; cv=none;
        d=google.com; s=arc-20260327;
        b=Ri/IuJOXfEYzIy3EoMDL84PiI4EiACAvXLqRZLUmsNpjHrcqaWL66db8lfkSnWF6XN
         zjz0dw+x2o2Htl8BS/MiyUQBM4gZlXcPWQuIjnsYdKlEs4T8Zop8DmJ8Tj07M5k+nGJV
         /M5UDacAgHkN6zomDkS0TtkvsE25AZASdO3dvYzAy08zQoHTF020WPHPrExTaXINXQaY
         K2LSCKZIiEB6Mfk8Pa6kyUiHlW+Fiwie7FnNdDPxb1FtQXr4JYp2EH6sGYFF8q/kLIek
         C27GzenSn0/cUQzKkTFbXl98FsbGUsnxjRhng4kWNB3bvV/ihuUKr80eSLHbGwzRD1Ke
         oQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=heiu4vZgbrKpTKU1I3rmxaSRHN7QobZOUW7xYNQMOHg=;
        fh=bswrDJ6e8OFhFa13me+D92R8oUP5EQSucCtRZpsS1gY=;
        b=gxJc9DX5YQ2aAPBhKnivvFg/Okyc0tpKeUGTCV+KPirjiKtr8PphbMhwX2mqf5TYo9
         EassxPRKwc3V9YNwYGEQMI/QJXLy0vMvlfLMLQHAzAANRj1EODBwnbLGt6VRimTxt9Yz
         H6mUQYX+F0cjiXkYhoZbMryYDxLhHKTGFlQqZOGYhAQfeAvlhcKaAmGU2HFfTVikTqDQ
         sAmwE5pZEeTZbxb4FYvaQPUBsWXBt2Y+D4kFYLMkpFqXwMAPi3kNw9huS5uKLt4H5PtC
         QF34odj7ea3tVJFNacr7vhmOZs+EBTnmZz/YwQ9DksttmaMwx5HlfvktFecLUjv988qc
         qNHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445414; x=1793050214; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heiu4vZgbrKpTKU1I3rmxaSRHN7QobZOUW7xYNQMOHg=;
        b=IN6IYm4/O+ltM9p1ZlZt9rxojxm/w5PQ2lEKzFKQrgapF9lGCNfBpsXiI9IT8nYrKz
         1bfCVre2xr59JLs1evwBAh/a/8aEQAgZ5orugc4lOU4/XKvqIE+m6rh3i1HngL2/Oltd
         FgvgFGJfNgVPxWkXUZJ5LdFAqHu/2HZqVmlJxEHFdEeOVzQR81Xp31Lmre/rTZYbS7EA
         /zrG2cp3LkYfOxjWmBud82Z3Wk0w0O+PUzPpSMlHGzc4ABwt3VL42c0U5ouGaREQaDSq
         jZEGZAz766jw8vZJUcH2DxKVRWRthfgvuEn6MG+nntD/gg6Hg2/9HcMCdeSyRvSWVapz
         3N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445414; x=1793050214;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=heiu4vZgbrKpTKU1I3rmxaSRHN7QobZOUW7xYNQMOHg=;
        b=muVr4jJa9gkK8RjPyWy7ta7uGs7t37yyMvSzt+QKEIuVO4rFcK7x7gF6cLweQOZIE0
         NTjlF6ntsEGQK/HJxkC1uCt8u5x8h/0AypVmUMVj0Uya8V9m1u2Pfr7NCySUKAwsgeij
         g07/gk9qiLN658VJOXibwE4jaEwb3zftrzBbyV/VjXeTYHJvDM4Ng0rTvK8Ti6qcnBef
         wROU87wlcCSY8SXmiU5RmM8tVIHBRHcpSSzbQmRgCGCty9GWukaO/eeAdhjAKRfU8Soj
         HWFNHstvfmCcDBbc90SJq8f7TghIfUuVVjM1f0Zfokel7402qz00Ea6OXF1HCf2B+F3J
         d+JA==
X-Gm-Message-State: AFq9FYIF220b6BtDlkgNWaJSkc/fKltARTz4IJtK0fGitseRbqP3Mb4y
	csJuVvV9PAMcwqKhWfjOxmhvHptS/B9RtFMGgLngYnaTGM0G3sMF2KfixCwGDgee0P2kdZwap2x
	kbeOnH+2cF+N+xbhxNQpD3H4Ad2J1k7k=
X-Gm-Gg: AYBFou2W1mr530tjpymjpkpWUmFqArgIgwE2KAAAOYc+lXQFn4iFEqKczXcf3LiBYyV
	Jmau0FWaJ+Rdpht4qx8aMo4RNMbt6XL0GfKKaQCeEG/E5jwFeqGpHl+ZHqdapporEck/TQZGo2i
	D/iozQ7397S/iopniex2Fne/cUndXmKRMFTftqUrQBETqkzCXTqUGNTS9irxvt1JTOtQlLr2sPm
	w638Gh3sk04KE01uk47pa1FzuspFQyQEDLI0p4d6TleteB4LlPq2bMQky4sUX1ObJ9gODM7C5ud
	CyItFkp+0b6Jpq4nQKaz4+9QuCmzc+JeH3ofuz9dhhNsPkIJ1AlzK3kxOzQPkpIX
X-Received: by 2002:a05:6870:8112:b0:4a2:4d67:5977 with SMTP id
 586e51a60fabf-4a7578ad1a5mr6873605fac.18.1792445414038; Mon, 19 Oct 2026
 14:30:14 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
 <20261017200405.2332914-1-andy.koppe@gmail.com> <atWxNvZn3CYTBuFp@pks.im>
In-Reply-To: <atWxNvZn3CYTBuFp@pks.im>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Mon, 19 Oct 2026 22:30:01 +0100
X-Gm-Features: AclHuK960bChsL4DKTg-w15C3wg1YsldAYIykQAOCQU_rJlCZ8uZq0_wmcYZbg4
Message-ID: <CAHWeT-azx6pHvUGy=-Jp+gjbErsJvJ3StTms4twLvoM50+a=zQ@mail.gmail.com>
Subject: Re: [PATCH v2] refs/files: keep root refs out of loose ref cache
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 06:57, Patrick Steinhardt wrote:
> On Sat, Oct 17, 2026 at 09:04:00PM +0100, Andy Koppe wrote:
> > Changes since v1:
> > - Move create_root_ref_cache() below get_loose_ref_cache() for a smaller
> >   diff, and tweak its comment.
> > - Correct the documentation, help text and refs.h comment for
> >   `--include-root-refs`, which claimed that it lists pseudorefs.
> > - Consider alternative approaches in the log message.
>
> It would help to also get a range-diff relative to v1 so that a reviewer
> can see what exxactly has changed between the two versions.

Done with v3, relative to v1.

> > diff --git a/Documentation/for-each-ref-options.adoc b/Documentation/for-each-ref-options.adoc
> > index 54e2fa95c2..b93ffbd74d 100644
> > --- a/Documentation/for-each-ref-options.adoc
> > +++ b/Documentation/for-each-ref-options.adoc
> > @@ -73,7 +73,8 @@ TAB %(refname)`.
> >       using the same rules as _<pattern>_ above.
> >
> >  `--include-root-refs`::
> > -     List root refs (`HEAD` and pseudorefs) apart from regular refs.
> > +     List root refs such as `HEAD` and `ORIG_HEAD` in addition to regular
> > +     refs. (The pseudorefs `FETCH_HEAD` and `MERGE_HEAD` are not included.)
> >
> >  `--start-after=<marker>`::
> >      Allows paginating the output by skipping references up to and including the
>
> These changes make sense, but they are unrelated to the fix. They should
> thus go into a separate commit.

Dropped from v3. I'll put them into a separate patch, along with other
fixes for outdated uses of "pseudoref".

Andy
