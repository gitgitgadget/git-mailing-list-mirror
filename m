Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343120;
	b=JfDyq+pe8v376rnE2Raa2O5mIFdCtaNyP4lof3xtaq3IbJSjH5bTqwQy2xqHFO0OrKfC
	 IzNbKP0AJSyVrmiIzu80Ns+OOjEKPcZH151uWEL+jIIB6JHdcCYZcVVjKNXwegUWbZUmx
	 OuKoYPMBaHEzmsJP0GaG3JcG8Kq8gR/nyNUeb2z+Z5/cXfPddukDMOsIKXKLdO4usjkmc
	 /81rPDIYScwxi+ofRK6z/oF3meeftM1lJj+TJ9hUx19F5CgyMU7knX4odBpvOVktxFKNH
	 fIaPMzIH6ul/GT6tyB7dH3vP593xr7HFBWa4Z7uLiiCokVX37wQnpGSpxQbQXngDohQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wYvYEQuaccq3Z2mg68nUfMAhluRzkVvIQr5jInnaqQk=;
	b=YhYeVh8l3aJaIUfQe2DuJyAsX2kOo0pzg+F2JwRVSf4WRnx5jCTl/1jX9bswZhIm71lo
	 tFWl134teRzZdyPF4Hg2KWbuKO527/CS8l5c9zZX8WlvgBqu8tSgw3LjEilTZxotaZldk
	 jIWDWC9vN3fz8wnxAR5EIDKr7IIeAJ3GmjLWC1HGCBHAIO9KDyzIH0enaqRmWNtUkFlF9
	 GUL0zrAt076PpXe3z7KutyYKwZA3tB9Kse4+go67s/ZMNxsFQzk9YcKnpOWKtRBNfmXAu
	 LpPvgBIQCsBvGgdL8tEkahRZ69IuhOvC+Gn70f3YjvZc5X+Ljr3pICm0RAsYs46ZFVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=thomasbachem.com;
	spf=pass smtp.mailfrom=thomasbachem.com;
	dkim=pass header.d=thomasbachem.com header.i=@thomasbachem.com header.a=rsa-sha256 header.s=google header.b=Hn55P945;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425360A260E
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2425360A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thomasbachem.com header.i=@thomasbachem.com header.a=rsa-sha256 header.s=google header.b=Hn55P945
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67c0ffaae1dso2701807d50.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 12:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794343118; cv=none;
        d=google.com; s=arc-20260327;
        b=GOc8kZnJGQaFSxFLYVwy9LFqF516KZNJJZ7a7nkmKGn0a2k6oJ/OGPfjxCxDU8bAnR
         E6HK2jA4489qUv5B1um1n0TO/+MHsvtf/aGMDOrUTL/rkJpFuKdO/00K9IHo1P488dJz
         BGXYi9v4Jxu6rm0KszbiB4fOZJ200LbaG4VnUDItWYcneWMR6V6cb8x0HNGETe3vBjRD
         TL88Ap19OUBqUx6V6oCpJGo2U5OdzT2HQMPpB1J8LcQnzfuJEXadh5zu2trRC8f1fTcJ
         Tccnazqciw+1wZ81FdQMBefqyUQA6Fe9afOIhLHmjOgcUsrCtW4igXVtzTtl4L9wA1eW
         RekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wYvYEQuaccq3Z2mg68nUfMAhluRzkVvIQr5jInnaqQk=;
        fh=jGpZ+yZEIl1cCKmH2DHLWsSMW5RP6EwtAVCYxMsz3qg=;
        b=VbYMEk97OvznkgqAYYDo9N4TX4TkaSc21MYz0hq+4njSB1rKze4m7nHkpoJRvF7k95
         HQPXx6OZZpusIY6Za3XkWTRylzbCmUIJ2hsUsY88Xk1SfCujq74uvqDtL8wwoJ34vBTI
         1GNWAnmrgYUbN/R89n+SR7iUqfH+KUjja1n68sKkqmSWlotj8r3262y20vXgotcXKSe3
         bXRR9Jqae1U5ELHpwWQV68cMyhEVJSmvjRT7DsYsYzgjXCC2vMSHHVgbYA+WwsCquThH
         d8WNwP7ififyiVrGI2sXeCXDyuEQRuO3hYZg+muI1z9zMlRo3tPLlwnjccemrlZA+eAy
         jDgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1794343118; x=1794947918; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wYvYEQuaccq3Z2mg68nUfMAhluRzkVvIQr5jInnaqQk=;
        b=Hn55P945fW0NjMrPiiYL8MvlXYn0Jah4x/4kQ/CmOubPACcBb2t4bsTEADUG2pC6Cm
         Bxv4Lcg27E/FgsLjLJP3sBiOQwMTQCbaxqTGSwg+llDh+Jo5uoiimTjkn2uSQw6ukOkM
         +Pbc5AFkMehSf2Mc/SobXkbU1+oH0R1ZjwxfB/hqy99BJ9GP7RnS77fD0CUPYiVlaY/u
         PyUgPvG/C96GWwNRryr528pl9Xt9DxOCnRRbGBOl0FsozCRMCmOO88O4eKqmJzeZFPpt
         cFL0qUP2242MIfU/b7BMsDkgmqcSi/NVbgmbJlUWhcphZKJs6kGXvjiH/M9cQZ6IC2J8
         OFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794343118; x=1794947918;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wYvYEQuaccq3Z2mg68nUfMAhluRzkVvIQr5jInnaqQk=;
        b=pPSHGyFRJ7cd5pq5AFKCtdTPDpjDKhylDNz83Wu3kSW5GUSokVUOCVJHbPjvoT3oIo
         YCw/0XkEdtP4hrXHm7kZYRqvzQyiHuWCLTx5LiJRdhM793eAVCOvgcGvCRzPJVFhGOtO
         Sy+B6wtYsznqERYjd5YIHr/wWdDJlsz0BlojSUuHnlK9W9DPEjL5TCUk/vask+UQ1eJr
         B2xJ1u+Sk8tzu1bE4H3XjIsy/UERKDRvvmaqgyDy+e9hGh4QvuQfqaJzO1vAGFVdpZWR
         Csc7zycewzbcWaCO/30q94eksa6UUZ/itc+gkRASBYgjTG0kgcw32G9k4duj05vygL7x
         OujA==
X-Forwarded-Encrypted: i=1; AL+hErFiLh4Edta996/ZO/jT53LCzoVO1sFadxl94+0tTHoVzjmjW393WdycaTWwRqrThuuYwQg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/B3RyawT42HcRl+kEYX0D+hCdz16JAE7Mf0V3dmgKtTQvqNzfV
	x432F6juJpf8LT4KjaYbkdEWGBikrgfJRS3k0YQzVetBA9QSPBqSxrIIiLKB+oLWhd/o9iK3kNr
	YMxPah99DkRWr4baNZZFXY5id55+Meka3/qAN+4Z+xw==
X-Gm-Gg: AYBFou1H2ndz2dDP500Tcai/ELdx468h2SBx24J6HmQbFZAXfvZXBvroetTa2LTMpA6
	Mq1ovQWH3N1WxJLb0HEpa2J5UVba3mMDvTZvzFJq4dAdZDiMs3gPsOSIdFlzMsnvIP22eFE4tIj
	d2q5QrN7WSvA0RrLeTczELXczqhLxqf3AXw0MP74yv7s6odiss0W7HEX1wndejvjYoo4n7xjEIi
	/kcWw8NAiS4Dj+HGL9L7OnkIIGda0fAPGfr6P5uAhnkCjbrqvokbOjY2gbvc8JKvGXRTleO3moi
	LLGUFcB7b6oN4DBdvVp4rHWlspcP7WW9RZjzfsh2aNuJ9FrFL5abC5V7xClt8mW3GTXdFPed+dd
	AdzYKFixRZ9SR8Y7u0DeXcZIRAczkb9+/i+xn+zf263470kWFUnwpp4bVLztixgrJweboniy5H6
	HFqdcgqyOA5k5ByME94cV1Qn/flPRT
X-Received: by 2002:a05:690e:801:20b0:67c:1fba:b449 with SMTP id
 956f58d0204a3-67c67ea605bmr227457d50.13.1794343117888; Tue, 10 Nov 2026
 12:38:37 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com> <b68da114-ec84-402d-90ff-bdd1740d5338@gmail.com>
In-Reply-To: <b68da114-ec84-402d-90ff-bdd1740d5338@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Tue, 10 Nov 2026 21:38:25 +0100
X-Gm-Features: AclHuK-0oD2NooTGYKg8gBCURU5_RksSdoBWQHQE5er2-2Vu9TwHykscjKD_4UI
Message-ID: <CAA0xjtqx6qf0-zkeaM8+PJA34Obtj4H9073MTXryib=EvRVNKQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Fix segfaults on settings given without a value
To: phillip.wood@dunelm.org.uk
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, peff@peff.net, 
	me@ttaylorr.com, stolee@gmail.com, ps@pks.im, colinlewishinton@gmail.com, 
	m@lfurio.us, Johannes.Schindelin@gmx.de, usmanakinyemi202@gmail.com, 
	vmiklos@collabora.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:
> There are several places where we now treat a NULL value as an error,
> but we ignore empty or invalid values.

Thanks for reading the rest of the series too. Four of those places
reject a missing value while an invalid one is ignored, and they are
the only ones in the series. In v3, two of them will warn about a
missing value and then ignore it, as patch 1 now does:

 - remote.<name>.tagOpt (patch 6)
 - color.blame.repeatedLines (patch 7)

The other two, heuristic and creationToken in a bundle list
(patch 14), keep the error. Stolee would rather make the bundle URI
code stricter about malformed lists than more lenient.

Two more keep the error, as an invalid value there dies already:
color.blame.highlightRecent in parse_color_fields(), and
branch.<name>.mergeOptions on bad quoting or an unknown option.
Junio has already explained why a missing mergeOptions shouldn't
act like an empty one.

v3 also takes both of your suggestions for the test in patch 1.

Thomas
