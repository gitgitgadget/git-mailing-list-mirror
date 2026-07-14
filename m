Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03A25CC57
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069456; cv=none; b=EDSA+etx4SaWVkFW387c0izNrmd1xaYZ8gUj6TJG/K/fKUMs8cY3hsWT10qBUoL04mVQihmkYdSnTSlrip0L/9CatPYqzrD2zByUlmp7VPOueTd/8C+s4ZekAXB0AM7A7bdvaJOCHu4NL0qRj8EHeO8zZqBp77qlT6HcQ8VXfMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069456; c=relaxed/simple;
	bh=35bqttjp6C6R6kCvBs9wEUccC1ypYlrbW5tflQJzKXg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qzD0npbBbdY9YZ8oYWEh1+hN5JIzC4WX7d05OEBWTluPFfpexM0DCvvmiphGXtqLo+oA28Gr5GThvhnV16oj7bDsyb5diuNHp5SP0iC+oGBzVfIckK/WHlLoC7bDs+z+sTgSDXnQzpayQ4UhzSax17UvTFAwSn/WJFgvvtXVLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcowI2vY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcowI2vY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso2386715f8f.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069453; x=1784674253; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pJejCFl8LZp0n3SAHwEGmp8QyI4QLZDzTxSUXUJIHxo=;
        b=DcowI2vYwSk7vdnehJxli1mLRebsz1MQlYMVnkq0XUvy8hCb6utTqq4wuRGfxHC4gS
         t01ON+Ully2DQfvotUfSPgOFknaGguBlavocSEDdQdWL44Ellkks52xT9pUWwd/BdDY2
         ub+H44pjsHC90ga0py3hHOQxhvUvL0kQ59jo+VIFKIBKGC5b02ZEYL4UoWC+uHG0h5Vc
         Up5xy/1HJPH/LYQYaBv+MQydK33tH6uCNgDf88mzG4l4gb4c/RvODTU/Jagn8NwTPqa+
         7jvIOaJNwDtS+8p4TnH4lPfT0/TUEpl3omSlhQ2FBEWaZpo0wXdCvig5AO7g54xlfnFS
         C11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069453; x=1784674253;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJejCFl8LZp0n3SAHwEGmp8QyI4QLZDzTxSUXUJIHxo=;
        b=GcS96EdQ3WvQ6Flnsvq6QmyFNJuYWXWofL6jgVkKGHwKoUevB3RWJBM9J2Uk4U21Fc
         xBjjpwrwGuCiTNcGY1b/yewrskUvRDL523tNs7wdbDVCSQf6H2pQs+iOlzJ1h7iJueDO
         FMSSwSPbYc+wheR/o9FaFmRHV0B5tOD7io9iyOt4xQ4gCp++hh7jx5aWE7fY1TXfRknr
         BXTmlaOTbuimfj6Hwcy7BTmlo0g3Ms4FN/h4hghZiAzd/DWfWHhWvFq5VvnNJ86f10dI
         HjvBCz/IF4ZG2Tj+ETu/myM4UaE5pucmFOOdHUDFFC+27s9wc+H6oZetSWtdBRWWYOur
         irZg==
X-Forwarded-Encrypted: i=1; AHgh+RrgWsCRpDIxTrnC3qgCZoicND4eXq8H4XAR1Ew5T1abjH0OlvkHtTaVqXBKJI/8cbex4Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+HUL/YPmEzCpDzV8jAKc4srAZO4Q9vVIw0jNmCGGkpVzVnkA
	Y6HdnAFCQkdotbBhvhhzBS7Jsa/LK1gW3yQleAfmQj4tXO75UdNSVLgA
X-Gm-Gg: AfdE7ckbxAAsRK+ySaVXLEaS38KKUZfX1UfBBua9GpMrgkBur2C9HZYKWmrh+wd7XBc
	TAPAzSMa09wYZ0hOMQ4sSYY5qrrh/+1jfd1wW4+OzehZ3I/pS2COsKGocK3wMCNyOnUGeSi2WP4
	o+YEUkKV/7Arab3jw8s4wZVMAUJv2hnBBmHmIYkwHWtmIKD3M+KrJwRi1sg83K02PmgKDS+4cjK
	PaDd1AnbMFwYECuuR0kx/Liuqne40vyOjYPtYfTxF0xA0D44w4LQ2RRhtOjxC2P1TzDK3NzyZrh
	uEnKdGVvJWO1rS8HI8vHD0R+4GjW6PzES9DvIBoIIYypJcFSuMDiGYZdSQLeohpJQfPJzPBcvPr
	Niuc8kgiAoBpVvwFr03LrzuzbmlSXQzjFIT83/RxBqHW9slAV7CZz6pwVDwaQjPnnD4W555m4SB
	2NPgHeIuTzMwkBRn7qaR+FOwDR+behs3H43l7Vc/opqdOvP8ydya7M/pQ5MksrWUudf96/bmvxz
	srNnW0m+UHAXGZc7pcwQ2TINQo9XopotrzTqpXoYA+d98JkYbz1B+2X5LvWXL2Ew8riTZ85niis
	JTqjOx8uIrlFL5DO1OLYy75WaVB4TWj/KigvjLkiiDu9q36PjwFMGtxr54GWxnS5P8jbqg==
X-Received: by 2002:a05:6000:230c:b0:47d:fa32:c895 with SMTP id ffacd0b85a97d-47f488aca25mr5124882f8f.50.1784069453242;
        Tue, 14 Jul 2026 15:50:53 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a63esm12053832f8f.9.2026.07.14.15.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 15:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 00:50:51 +0200
Message-Id: <DJYNU7D4A7C8.3Q2Q4DX27RXC0@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <chriscool@tuxfamily.org>,
 <eric.peijian@gmail.com>, <git@vger.kernel.org>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>, <toon@iotcl.com>
Subject: Re: [PATCH GSoC v17 00/13] cat-file: add remote-object-info to
 batch-command
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <xmqq8q7dto8d.fsf@gitster.g>
In-Reply-To: <xmqq8q7dto8d.fsf@gitster.g>

On Tue Jul 14, 2026 at 8:33 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> This patch series is a continuation of Eric Ju's
>> (eric.peijian@gmail.com) and Calvin Wan's (calvinwan@google.com) patch
>> series [1] and [2] respectively.
>
> Yuck.  I thought we had this marked as "Will merge to 'next'?" for
> some time and this morning I pushed out a merge to 'next' of v16.
> I'll revert the merge and replace.

Hi!

Sorry, I'm confused about the last line about 'next' and the replace.

You gave me feedback for v17 10th commit:

https://lore.kernel.org/git/xmqqik6htpv4.fsf@gitster.g/

Should I send a v18 or a new patch on top of 'next'?

The fix is simple and I already have it on my local, I just want to do
whatever is better.

Regards,
Pablo.
