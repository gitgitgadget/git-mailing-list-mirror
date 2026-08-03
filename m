Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FA347512
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792636; cv=none; b=MYAmWdfeXo0v4tfKsb1zJ1o975vpUXCqNHtxeDbhHvazRYgj2/r4YRhEv771Z7efn0tmu8gXiF4M6VsAAvJRu2HJDAsQnGHhQ/yZty5prNjaiJFPXV8I3nTVBrjuUQPM8yY2JJO3J5VbkXeNzCp806Mja2raUn3WhsI0PSw/GEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792636; c=relaxed/simple;
	bh=ecq55b03bGL3u97WOEOds3SQ4DbBvIoF6v8KctHiSVs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fkzRsHxQw3Z3JsmIlwVeQefMTkwjByi0JBwfGJczCgxujUQuLi8nG8IZUMERzDnLFN3fSWUwfDCxyybm3lyJ69pE23gIcv0pV/02O4MnNHskYjxX1fv6OfiAallY+AKJ72qYinRkEesuCgvtst28RVCjapIGLfzhclEwL8DPh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+lkM6Br; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+lkM6Br"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49800c6a846so22942905e9.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785792633; x=1786397433; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2orodzBrQmPJSe5NB560Tk0J5An7EMXd5a37So0iTc0=;
        b=n+lkM6Br9W81/6Ka2829xU+WVfP0nB2AK93RWJ91wiMf/K78MpXZIN2ml9jzx80OGE
         slG0XdTsMVrM/vMmzHBl8aPF+IETXGQdxXRPXtaKd1OHzBIsXIbGjcBa+dNaVv3c3uv+
         ytbDJA82V/7nm055hKkLtBlSqpFmfN/CEDDVPvPSrkV0E5+Lt0hb94pvELv+a5wsibny
         3gkDmO/uKQfF0JjZ1FSjwSnJsgIs/VfmwTKaQcI6a1tahWuKV7StuCmY9o2grF4O6RZw
         j+A5PgG+UMLPRWfXweHXe/KdQq9YC7DW56Q996JFm2M3B2cbaxXHcLLJbqNB84laJ5Gh
         EJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785792633; x=1786397433;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2orodzBrQmPJSe5NB560Tk0J5An7EMXd5a37So0iTc0=;
        b=pgqqOovhhKmYNn5CAXqMXkcVLvy3ymB0d7OLmL3xK/gdjQBkD91FzykWxqWIkDtS3j
         wYrban2lpUjXEgpI/S1uUFlGshZDrcK+msJ5MLojumKd2GDqsSmx1j/1HQ6cJt8t5wnW
         mai389pbBwvHuqdEQl9jXN4bGW0/mrhdZki7tTNT/8dPWCC7mVM7dhPNnHg8wBQ0dYwd
         hwpgyCbwSw+XRlB5mgd5apjtyDhDnmYecNWcvEZTyC1M76ETKfH7C0Vc2hBK72j5TGcn
         0hN3ZdGqY9Qi+cNHUwpvFlfiShUafLuH4V7jOPuk/5iihsn0krOubMHWyeC1VxQk/zOp
         II6A==
X-Gm-Message-State: AOJu0YysA6N0capEyQyh+H8EQWA/+FFGFZfGxhGHapnETvhfpSQ61Aei
	6aq+VqF9e4hRvJr87/xbDkJ6cOQMM2CXuYESbA/5o/9+sRlYWdHPbEYOJnp4cQqM
X-Gm-Gg: AR+sD10NX+bdZLMJMYZ3byqR7z8LH9et22lWBYzFnbWFALqBgNIP6dFxYF582uGBzN8
	Qn73pX47zACLSFlJ2gHpnq0/B2+M3PmjnNyYckxawCEEYYv/vAiUsOKZYJhPC+CQief0BTNdpQi
	Vg/iCYvncpD7OsIdtnHZTVTBGkL8aexxuOw1/HD2V4KBD1rQh3Z3jGMFSkZQl6xtXjWSyswtpUK
	6oYYoUbpJDdKDEG5a5e2ttB0UKMEojuE4ygkpNJAcbIJfGF9NAW6dT7lCyLNLOOJWDZra6+uf3u
	o3/nMUZohpAJC+EYOrqem3ET3aWnChXdOuRCTgrQiV8nqpx6hC3vkk6Aim09r8mufQTgvzY6KFc
	BBUn4DTG0s6tGFmRFwHooe2nSr+LFHhHbA4fyzrteM9L/L/B29GOxCios6VAkdNJLm++/Eiy3iE
	n5cGyt9qIZmvtsQXbux2ZVwa4evFR4ICVj41IF3WJovr14QBYPW7kOWsVnEa8yL3vmoTz36XB98
	deblSoCNnb/412RQS+eoh256gE5fw4UHjXc2kw9ZvahHYs4Ztu498tO8DivTaASb52YssWvt1QP
	xr/Hl6UezdVkcypNsgWBYYGhEky9Fa9PdpFOirTM1YyxxSnyIS+/uVqOVcwYDPPrPNpw8WFJy0Q
	=
X-Received: by 2002:a05:600c:524a:b0:498:28b:1025 with SMTP id 5b1f17b1804b1-4980c66c838mr244533685e9.5.1785792632702;
        Mon, 03 Aug 2026 14:30:32 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fd4c33sm22244065e9.8.2026.08.03.14.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 14:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 23:30:31 +0200
Message-Id: <DKFMNL9K3H7K.1G0N5EDW71VHQ@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>
Subject: Re: [PATCH GSoC v3 2/8] fetch-object-info: detect truncated server
 responses
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
 <20260803-objecttype-support-v3-2-7176fecf7950@gmail.com>
 <xmqq7bm7yso6.fsf@gitster.g>
In-Reply-To: <xmqq7bm7yso6.fsf@gitster.g>

On Mon Aug 3, 2026 at 8:18 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> The loop reading the object-info response stops as soon as the reader
>> returns something other than PACKET_READ_NORMAL. A server that somehow
>> answers with fewer objects leaves the end of the result arrays empty.
>>
>> The caller trusts that every requested object will be filled in.
>>
>> die() if the loop doesn't reach the number of oids expected.
>
> This tightening is obviously a good thing to do.
>
> The above description makes me wonder what happens if the other side
> sends responses for more objects than we requested.  We allocate for
> N objects and loop for up to N iterations, so we will not read more
> than N.  But do we detect that we are out of sync when we read the
> response to our next request, or before we shut down the connection
> if we do not have any further requests?

As it is now we would only notice in the stateless case. The loop will
only go for N lines and then leave the rest unread, then
check_stateless_delimiter() reads the next packet and dies because it is
a normal packet. If it isn't stateless it will early return and we
won't notice.

There is nothing to get out of sync though. The connection is started
and finished for each remote-object-info command line. So a later
remote-object-info starts fresh.

But even if it is harmless (I think) it's not ideal and I didn't think
about this case. The fix should be easy, check the next packet for a
flush after iterating, otherwise die().

[snip]

Thanks,
Pablo
