Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE881A3029
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093637; cv=pass; b=tinyW9K6+mvQBN7zeMo54TOrSUeWWZv9ZAVdS7FKmjwU5HMkzytgaN1dwsmie+wJ13wCpxB5++Iit35X6IMNtkECoI4bSHUc4SG0+gVsiWADULGQonD8S5Ouw4nr5vu25bmmsk3BFzsIK/oxQhfMz3ouw9ybDSNu1x1IIALeZJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093637; c=relaxed/simple;
	bh=5p3gnyvqVM2u70HCOQqS0ooXyDN2Ug6ByHzHXq4LlZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njAHq8nkdTJwQTuMHmKUqMscgnnUqzpiy9dAoOO/4Zqmd+2I8m3EHFrXT0pfoVXSqtEBFU5F3v8hkzH4GYHX/41WzL/ueYmKFYFyJWdpO4BcdgprNaZ7WCWPHsxVnZLMLfhkESwkO9CzSt+ITqwWeZUQoejA5xuvMzogIydCt04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW5ZBjA0; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW5ZBjA0"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84864086bfeso2584354b3a.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 02:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786093636; cv=none;
        d=google.com; s=arc-20260327;
        b=QeU6mulpcTceTccNkX5YZGEvscaKKBIs6CXtxCg6Wt4wyIwLjFK714QqLMwilSOApn
         2PIh6lEas7Q1rq2/eG+xaEnw9CBctOQkFxLpOEssqTvXVz4MDqmAnXe9rALiMnyOHBkU
         kzBPffELB68vR6Y5JpyYST2KK8tiYJoZl9GZGrHT7Y2HzxHfKaB1uJSvC771QlCOiR7Q
         0Aut58zKATaOFjqC8WBUdfncuFAebmgUpCNKDXrEHpUQlUlXDVXUHGqH/8CobGS3/LV6
         rPl9D4DmGQW9XitSFkoamhcwC8O+Cz5qbsT6z19+6CPjcqjT7LhFiilArSa3I7s5bePZ
         vvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qIt9UZwibw9lanjOg52/eAmMPB+yAxXizsWj9uTW5vI=;
        fh=HlHiiRPQ4xmXAzlgUsido7M6L2x0NwnIflVn+FLZwEk=;
        b=SDdSVKyggEtvpZO+qqsnOrqkGmR9xK83gnqNNnUkPzqQ7znxYKlMrrVVoNmoFCB9f9
         fjUDu3U7sFGIHCQHtA+YzwE1EMoj4n9xlzXjWWBQ14f/D+5Ji6d+aoquYB2qpn+1LmI7
         vHxk+vlxrs0pxfTL+nHVBeCF8AApR1jYNqZr0lj8UZyc1YwsRgjmG+poiaTVVg1Ow/Dc
         YxG70bZA9p4C79SpczJDdT/qgEzfN0c1PukHdUSXMHVHP8sUE8RkUslaDW2BZl46ljdK
         dkkhXhEC/neYaV/rqoLzkd8V1s7NbplkQSlD4MDIqIiVbfRk/WQRTCQXLL6BOIEClZgj
         ti8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786093636; x=1786698436; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIt9UZwibw9lanjOg52/eAmMPB+yAxXizsWj9uTW5vI=;
        b=BW5ZBjA0N8l95bNCNY/dlWNm+ZaCSlQrs2VCHTZ3HIQV99TWjd6iEn9RSmk/mvYIuf
         w2y0bi/nA93U+lijljSrG1u2lWBPnb8BKlHVCG3TY9TtX2U5cL+230lJoalmJLakj0gR
         WMwX9PiryftRo8Gd6zppc8cnOaAlE6pzUFhFRb54NiQdtU7F7DolRQkk9RgRqjfiAEQ/
         esY/v59Z78R+6da/ENLW+z+EJXVENnTc7HUjBHX6STrZEf4OWDHxQbvw4KXr6Hli7ybG
         Fb/FnsYfzJIelLQ/jAMIEXslc6bcngcrMe3R48Wl6m7zRAVioNDjiHnT6af8ojiwFYXG
         noww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786093636; x=1786698436;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qIt9UZwibw9lanjOg52/eAmMPB+yAxXizsWj9uTW5vI=;
        b=Ju4cwyG2ioCHMASXojngvWcUWehGHMU0LPk/FV8BprhxSmqaHsz7e2hpri25b+dXk6
         Wa1nQIIkYDE8R9VlOawKkZPJMYBNgfc7hZiX2wv2YIuRcZpBdOOpETH4RIupQhWTWYZN
         bNs/MPt/wPMq4CXGe3LeDj2nXkaa1krRbbKh0t+pcClgf75NhQ8/A0eqaXQC1i9sEzzO
         4U+sVczmztpsbO4Dk5rx5eAk+VepGgr6vyMjuJY5ljOvdGpPSacPzuc/IzOe1/uuR7CD
         qHCkoECzrRgB+kwJe2ljId23YkB3NptNUgnUk3eLdUovo9/Z9qGcNdEnJ1KoNe70WJ1h
         C/nQ==
X-Gm-Message-State: AOJu0YzQfbfMfxrmX/mZmi/gW1T7UkpUMMS3vRedo0KfledNo5iIhxQT
	KKj/UqvXhZr112bAt6NZLh0BojvDdOOXouQLLfp8Di8lmc20L3H5IMPFSiI4Hgmva3/TEP9ynyP
	JroRJmkslLedl5iQbIBZSl96TKk7UIt4=
X-Gm-Gg: AR+sD11x1bouaI0/G2jqj7lIjt/FYXzg55m8lIXBQ/UnzCf+s2zRUoL0r7kLAUTckst
	amr/hZpA1zHIWPhhhz/ai5LoQPaxqb9I4kAsBSmUvhbrWBqljpLLr1qah95zZaI2GWWoJ5CDsy7
	C40Aw0vR6tXjQyTqSb7QfLfQ0EnQA4spK0jRKxxJtMZ/qxNwJYmXYZG15i8RHdL3nZZsIj686YU
	SsUKMpG3EgzF9sflCBB7n8vUwmME+EYd5DXoz3FCIy8B5ezd/b65FJVQVg67oIGahWv3dRdjWLo
	AGQtsx4qPVcT5jSLVSNu59LDf4rIqOyicCdC86KyI50O08W43lfQbwsnWe9cunCOnxgRTrYTiSS
	MSPmX4uTvXmQqGNkB5nSPNn4egKdPNG/d
X-Received: by 2002:a05:6a00:1388:b0:82f:3a1e:5618 with SMTP id
 d2e1a72fcca58-84f2e017478mr23142896b3a.22.1786093635403; Fri, 07 Aug 2026
 02:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com> <xmqqpkzuhoyr.fsf@gitster.g>
In-Reply-To: <xmqqpkzuhoyr.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Fri, 7 Aug 2026 14:36:39 +0530
X-Gm-Features: AUfX_mwLSgNalDAHQwVBiSC3ImMzg2y497uE4VQCQJD_X75mcMEynWqTylleC0Y
Message-ID: <CAGWgyh9sDrHb2nXw+mmgQg4-x_H-_mLcwtpAt7QFYHydWNDg+w@mail.gmail.com>
Subject: Re: [GSoC PATCH v3 0/7] repack: add --drop-filtered to reclaim space
 in partial clones
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, ttaylorr@openai.com, me@ttaylorr.com, ps@pks.im, 
	johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 03:49, Junio C Hamano <gitster@pobox.com> wrote:
> Have these patches been reviewed and tested?  Is this a new breakage
> in v3?
>
> I think the accumulated fixes so far I have are as follows, but I
> suspect they need to be split and squashed into multiple patches (I
> didn't check).
sorry for the trouble, these are my mistakes: i ran t7706 but not the full
test suite, so i missed the t0450 SYNOPSIS check and the lint errors.
The -h usage string wasnt updated to match the new .adoc synopsis,
and i left a bare grep in the test. I'll fix all three, before sending a v4

thanks for catching these, and for the fixups.

Thanks,
Siddharth Shrimali
