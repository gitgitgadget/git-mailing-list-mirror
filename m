Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AB3FA5EC
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169223; cv=none; b=VkEG2U01wIKFTDHtrFIRdrbDRsoc1ot+Jcy9BMSJjqkArCZHKaLn+A+wZfx6vyqyuQeYs7aH6dYhBo4Z3oJ6sYEVDvyqHxbMe8WJRuN0FLSTUpZog32CfHpSxBOeZMzs7/lZPgEBem1LD2mc6npHGIHm6rMDdnP2LagreQbrIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169223; c=relaxed/simple;
	bh=EibXEsKnxHZSldUVYEfUvEiCf8iQowGeAa+uPuE08AE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=M54nAo4Y10UsqPL0Px5T8w0hy9FI6w0aLgxzzQpJeUjsx9C3Ll6mrdO/OgxW5NGpJ8ZJXtp9q72V37583u0qhpaCmEqmfuIGYDt1hrBv6mu9uyuAH0p+xHD3HWtGjV3y/ZsEbtAS1p/IXdbN+pTqjRXAho1WYyXdr8+J9tQ1d8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pE/M6Dv4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE/M6Dv4"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1939762a91.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169222; x=1785774022; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qxcju96DCXVj+j89ImO09oCv8w/RCrlvwFwnb/jQeeo=;
        b=pE/M6Dv4atCyIo4Lvh7N/WF95Y4XeYcdzb8nA241oEKZtGGcosKlwYuhcFZH2fbVbA
         BYKMVrORono4KK9NxI3JayUl1Z3lX/BG9guHP26e62FeS3TtGl+tLUUwQ1Ns555/KWEn
         wt3CnvWNmz2XNTC5Fcy1blmQ9ieyVr2CqIVTOhgeWdnVR+sfFXdf4yOHND913ik2//N5
         Cb4ooVLn/8iA8kTr33EukgCJfZCyYZHP2oi1+HkRYWJpnZdi7YuHHh4oO8uya4COQCgs
         GhQ2+iYrnxbK+YN3k/YOo00EEUERRh0pxkRB37dzrPN9JoqieTprsNAPM13qW+J2Oq3s
         us0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169222; x=1785774022;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qxcju96DCXVj+j89ImO09oCv8w/RCrlvwFwnb/jQeeo=;
        b=hgKb6QBZddZa1TsrBM5Y9IgVGhBO6dmRWaC1baWduguGNnF3ZO6aPokwo2qHlTC0jw
         HocPwAP6KkIkHT9gsF+Fokhyb+Epy7grkmu585Txt15tZkhBKy7J/WHiz44bUdQxo/fS
         hP59t4ChAasOk6WktoC49yXJ2hanQZGuqn4UpdtqnlAAVg3S+5F4tFgVLcyBPGFFsZmJ
         eY8AletOVHflxPBkEQ2qTqxNJH+HHWpxTYh3aP1S6HRlIKuHjaA5abSGKSOlyY3x7My6
         2Telam/87Z4uhcLQ+M4VwGlA8y0xf0xGrm+r/cruhF6C65grQQ6VVGi7kF+WA1UX9j/r
         RYSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUNxVNlcercjYEUIy4aatpMLvnzstpQEFQiNEiw2nffU1Ig8AsD2dsZ5Fs0WuKaJYMcOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5ddQphIsgbG9KuXo+0rs0vEOlClHchye8lJUFKNhZ54O+ai/
	d55wtbosvoV84DYQLbGk2AICYWHO8gXwnCWL0uTVAcN6EREXYStBy+nm
X-Gm-Gg: AR+sD10BDOp81xdgnA+5O88C/gRllDntM59IS1IQu8iqFS/VzswJn0JqwKuMkMjD6gL
	OW8jAJDijHpwzBxPFznzxmI/m12tCgkntJBqpYXf+Ej0qyEp33XOF91VG7OqezacUT16OYxl48k
	j32cSbLqnPQqFecs72rCtQ9cRwrSjONfziGk8o01vZpZo7GKARexDz13Tg8NM3vOa7+GDF03Fb6
	Fnr60zshpVUc63CZf0pzrtHrzArjQRcuT1OZPiHwU3eN8BLjD0h9ZWAd8q14svhffhhBfT+oNOs
	zD2HRueVMiZ0nsdLpMvwxT9qo3fbC1rA3sQw16DtPGJcmH4xuP9eBZLtjMP6rsWNj/CUzDdTO+Y
	h/yuTXbc+LQAz1+BvbGBruVH56qN0HfVc29pYv0wVNXWWf2GTR20xCaGHw04T1D3sPK6pzfQhZu
	M=
X-Received: by 2002:a05:6a21:139a:b0:3c3:9cf4:a993 with SMTP id adf61e73a8af0-3c6c7ff5377mr259676637.70.1785169221985;
        Mon, 27 Jul 2026 09:20:21 -0700 (PDT)
Received: from localhost ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc288a79sm33683201eec.0.2026.07.27.09.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 21:50:14 +0530
Message-Id: <DK9HO7JD6QT3.1ATJX1OLR8YBJ@gmail.com>
Subject: Re: [PATCH v3] utf8: make utf8_strwidth() and utf8_strnwidth()
 return size_t
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>
Cc: "Hardik Kumar" <hardikxk@gmail.com>, <git@vger.kernel.org>, "Patrick
 Steinhardt" <ps@pks.im>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726123427.173877-1-hardikxk@gmail.com>
 <20260727065917.469738-1-hardikxk@gmail.com>
 <e971400e-6d23-463f-ae9c-a21d3c5a3563@gmail.com>
 <xmqq4ihkpjn3.fsf@gitster.g>
In-Reply-To: <xmqq4ihkpjn3.fsf@gitster.g>

On Mon Jul 27, 2026 at 8:25 PM IST, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> I think it would be much better to remove the TODO comment as Junio=20
>> previously suggested and instead add some documentation to the function=
=20
>> explaining (a) why it is appropriate for it to return an int; (b) why we=
=20
>> must use the cast_size_t_to_int() helper to prevent overflows (see the=
=20
>> commit that added that comment).
>
> Thanks, especially for (b) above.  That needs to be stressed if we
> are to go in that direction.

Should this be documented in a new adoc file in the technical
documentation directory?

Thanks,
Hardik
