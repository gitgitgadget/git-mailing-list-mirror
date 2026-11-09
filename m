Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794219125;
	b=HbwT0Y8+X4Nrl+BUC8n8NwknNHKccniQ+INyhmwSlrivFXVObWok/jbCHte1Hnr23T0a
	 HlSrxt9Lp70THKTScwYsE1NZI3Ev+JZaGZq/YRCqQZTuzbp187TlZrGyqjSacqzNqj0om
	 Dxb32D0TGZP4nR2Lol+3cMcB2SxPtf+6+CAuBmoHRlJ0iOZY8eyWrnNsD2Y2F85N4zGB0
	 eifl64o1U3nRCDpsfS3SpE1HggD3qlN3NAbwdD/yAEDLPFixhzUi5ZOeppRsAp1z9uZ48
	 zV4WEidRfxNXjrkZAnH4cNAippH0pOm7l5/Xe3qeAgFsLLt7kUoffkYONGFZ9re8Ahg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=zrv9M3aVu8hdtenw96t5AuPttQc5xkjW1EbbGHpI+AU=;
	b=G0xw2XQ2WzK2FHRNJFmPFGEg8qsXQ6QNZkq10VHD5Xl49ZlW0DorZoD5t/sj/iQ7M02+
	 hJZqhezw0eJB08AU28ikmzbBAh5kgFoqWP7AAakUDDaT5IkIevs3i3Rqp6NvaxaBtO0Ze
	 dvggao3+1b4VCsgCzeFEbaDoKuEKTQM3DkDsjI9kI7o7oI5bWQNRg4YnF7bUvudPlLMES
	 Yqu/MiJTYyTaPc8iPocXYf5skwtPwcaBkHlWIJ329U06OsxGPVQ18OaTqMW9/p/nzjv9R
	 UtA2lsvCjVsva931SlVxh6lZ1kw9WpUSEYU6/OWHF6wuwKx1JXcRTVgu0pdaY/atagA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nz39uWl2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748BF606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 748BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nz39uWl2
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679334baa1fso754321d50.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 02:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794219124; cv=none;
        d=google.com; s=arc-20260327;
        b=lhtxTN/yIoDlKWCD+k6vCfL6xnx5LDVy28mLiH0JoWFKIp1X3iSPCFiyH+7fX8YnpS
         kj/A04MAy4x5LbC1GLtZWB42PYt7WCaSUYl5BiJAt1LwsKF8WE+gMIXWj/ZPz4Mbb/He
         OQCLhlyqE4q+ga8P+IKADJbo8qGUVfjCi2i5koOPObsV7AGqdycrrDiMKn8gJ/lAUGim
         SO53RsUEHATb5cnJLah3aBnKxM0TFYbpE0LZotghF4E5mZTHFZzLQem//dVOi85So5ot
         PdMAmwf/WcU8f34sUxHZtspUnUrQw4xIm/jBpikeLPVciGmXKK3TJ3onTkyLxKY0DDzc
         FIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zrv9M3aVu8hdtenw96t5AuPttQc5xkjW1EbbGHpI+AU=;
        fh=u2HXvIO3dn789rE2mqcm4j8Y11yJaHQ3Ds9eIxaXqaU=;
        b=jFMvR2caKYdj1kbxktd55kdFv4uuoq4d1y1KY4EMz+KLEI+r+3ZH5RbC1K6VYc4HR9
         kW44ZSejTbYVhYawMrFUKhn36AZzbnsy5GZe9TcWJu8hI+ee+QaH+yH1b4bqLNp3U7Te
         yxlr35M9n1geF5Q+cLD2ZmVZY9TLJ79Iws63ZPR+F2vTlf90buCJVTs1wBLvlcJBbdln
         ZaShTuCIxZhMNo1nW58l50hXswwl+O7njBUBlPeGB/TQFpgm6hemQV4IIQ6hlvsMFJdh
         p0yGHhoh4F4y/DKSCTPG+JUyhyDET0nk0MiPx4ksukGuVZagDJ8e4IEdOhYjNNg+rmtF
         tyjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794219124; x=1794823924; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrv9M3aVu8hdtenw96t5AuPttQc5xkjW1EbbGHpI+AU=;
        b=nz39uWl2WcbrGisX/FLErUEbGh3F07lMmt/GXbvjUv79PK7BykZDNOPre9y8TPm+fe
         0gywmjs6f0myx8z8COrjFwVJjqOWlVQrCpaQ5nBPDFoOc6lyqoMR03iM1is5PPD3e7e5
         LThqyoLXjmzJDcB/jyxO1Y2PB7a34CTJYCjHfY7UUnUr3qqk96VePL/x/QEe4SdTXD87
         60gsDFj/TSOmo3XCAp2B3CvYPFAT+KSm2HoHyEBujPGQo4Csy+h/1d3taxRQ2fdYGu/S
         Ik4eDSJyTJlWcX8K+rMsrlE45Sy0+jUxAhQeM1qRpAaH3balS8sLGPkQOpwWjBjPBoOV
         X7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219124; x=1794823924;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zrv9M3aVu8hdtenw96t5AuPttQc5xkjW1EbbGHpI+AU=;
        b=o9rz+K3MXTujqvXf+pzvuf0f+mk36OWxES466a3gGmUeqkN3Bzc3Jq0aFb36tCXvRq
         4CJ/gz7FH5oNSWp1inyUEeq75D/Quor8M316Onj79O6G9bWD+i18D+Evglk1V0o9KUEJ
         ECgRGnepH8QIhQm/2fMo5Oy2goyAXxwdtGOACq1bLzJknzqRrNBkkUmnDN3rXdD8mLTm
         YsVpa9+MztMT63QIBxYOIh74fkJl0uEnGRTExcq6tlHG+JVJb+DvOLlDz8c5G5nIj/5E
         v3pv192kLEUCb0az7/bhQfr9jToDAHx5a4amU+U3dJVi32Ch2W6b5P5YzAfM08PvT+Ld
         U2Dg==
X-Gm-Message-State: APuU4Z+2aOvWMjYN3XjEKNKjo7O8e1XiLTKC87AOVTQ/LBJda8vc4EW0
	gmLxcKZN2cQxI4i2T4RSAZOnNfx1KJ5neCzlu+ygJYHU1BKq2wZmeBC9f9O4ovpKxPc6RITuIPp
	8u3cfbAmDOM7wUlK6TwhvOEKKiN1NHUM=
X-Gm-Gg: AYBFou1PWzMm8zlVHml9ZSJleTFOs3nUGstpzKArHeXMxcL45E7RI28+YvUTb5SV1pW
	SHDPTvNaKkctzKO1HA5eR2lm/Sa/k/wmUAm/Yb8kCj7n7Bs4diGIrrYBMNccjxh/P4+jfQgSBAP
	0nuXdfAzv3Fu9EMY+Ydao/vhDnRzDgkE8emlIqcTvCsh/WgZkJwyu3RiYNIIkYc/x9yChoY7FgO
	XZdZYRzeA/rF7JpeM3e2RYUXkz9d79Ljwi6Ar7m/EWOmiIoVWceiTjD5Gwf6aRyHW1Jlbve0V6z
	z4GA2eM0eCpAS/9kpzVGPtuI87P2f0Lx4iAGxBi2SiDsmJiRsnY9DWUmU4t7HzJbPrOTm8If+zU
	+2dHzL66QyeMZ1DQlZ+bfjaDWuFUtQw/kGSZFQqaOqsyZ9uL2qmms2IyCl3riS9XZ8q5LDCVN4D
	W8MxK/RCnE/JkiRVAo4+WmewWUSSia5JWL1i+hYUIl5aBTMxNi7+e8rSV1kIp/k3bmJsjcLRagA
	1difih790rgI1lNEGQ031acrPJMN68DNJ8Ia4Y=
X-Received: by 2002:a53:b1a1:0:b0:676:8c05:8426 with SMTP id
 956f58d0204a3-67c3da6a954mr1257479d50.130.1794219124195; Mon, 09 Nov 2026
 02:12:04 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqq1p8zw49g.fsf@gitster.g> <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-6-okhuomonajayi54@gmail.com> <avGP6txIm0tK377H@pks.im>
In-Reply-To: <avGP6txIm0tK377H@pks.im>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 9 Nov 2026 11:11:53 +0100
X-Gm-Features: AclHuK88OaU-SrBrb4YEiVZ0nSFoOUnkQKr8zCPBRJWai00oyOaI24OTS0WeAW0
Message-ID: <CAFpMFfBA-O+BqXzCo3sG28hh63G-N4HpSr0zv7tfUhBAN_57+w@mail.gmail.com>
Subject: Re: [Outreachy PATCH 5/6] notes: pass the repository to the
 combine_notes callbacks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com, gitster@pobox.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hmm. I was hoping that at the end of this series we'd also get rid of
> `USE_THE_REPOSITORY_VARIABLE` in "notes.c". Any reason why you decided
> to not go all the way?

I limited the series to code that already has a notes tree. The
rest needs more than that, the display notes code keeps its state
in globals, and log, format-patch, diff-tree and format-rev are
given a repository but do not pass it on. format_note() falls
back to the global default_notes_tree, where I wasn't sure which
direction to take, and expand_loose_notes_ref() only takes a
strbuf. The hash-size helpers are simpler, I just left them on
the global.

Thanks,

Okhuomon
