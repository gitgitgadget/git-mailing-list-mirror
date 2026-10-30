Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361118;
	b=iu2+m1VusZxZ/CAufzh7ZBPf6TbBAVhKwA1y8+Y54S16t8Ef6zrIbJYVXVokkWg4U7ET
	 Vpyh+UR2qp/nnawVnJwxx7i+0nFD/vScvVuhKxVHGHh9iVDD7m8OTVho+Oeyfs/KSPrNY
	 FAnjeHmTF6XLguMhHGiPkUL7OqrEvXDX5qHuUS/5pFurRU2b4AkCr8RrFw/TjDZGOKKqO
	 5EgwbWt+vdyCOWNCxvmsyM+jtygLV/mNHalH0oAyIugmPue5AlOt2vy2SUCj35Uo4fyZU
	 MnWzHCbeo3+MUIDlSSYs7e6+kpSvJ0JJjWOp+9G0rzd+q6Q4LE2vhDUa7GG7NBvPxWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=nleg3v3ss/35EwFO4a0CSmM5kNqGJPHNF9IV/Gtdvec=;
	b=OzETUtC07yG2Ot822iwKOXHUxlTRFR/+IXOFn9L0ZTK1AUHBeZQ5aV34nHP0SU4+ZFT2
	 r0rUW6RTx6mJbwk5L97jsLekyj0cwrJzCJ2poBBDuu6Ldq1QS45lW3uwsXcSiyhPVo0Ri
	 zesm4E9+67NLESqONwyLj3U3TEYoStC3HWKZRBaQbEgwPkKMCJPBJ67WU6uayacLd/V+H
	 kKX70iUlnISge4xqJgdZc0hnTw+z1J8NrhdmVl9f4ceQRsnBoCXEGX1VCW6W2L2Y1a+hP
	 iTxtoAL+1FO89WZK5kxexMO457wdNVz6GV/Oq1A+0hPFD9HFNMo9C3Qj6l7ZTt3dNlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b="eu/FGqVW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C63606A322
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 11:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C63606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=eu/FGqVW
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c434376dbebso127688766b.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 04:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793361115; cv=none;
        d=google.com; s=arc-20260327;
        b=NtIzvRwTbts3y5xv0XGaW07w7Nhj6NZuA6vjjjU4GCpRvbdWZ21cguJkAcMdVlBKZ9
         zEKMvhuw2yOv1/VYD64k7rZS8lJaN5lwxI9pyCJ74ecwdmPoQaE4epsRzSPkdoqdvBge
         f7ZSzEtTCbTq3Iam3dXgNI+CDoazoqZNFuD8hX3ECJlQl+rIYNGOvJ7URF3ZzUTk7ixz
         jv6VdTQ6Yv08yb43jlwAhWJl687noQnDxEXF9qWYa9czYgQVJzGoPGpz/3NRChMUZrGa
         fGuWApQOm46gnFVkQ4G7/lcJF/gisFAtJpwNEwutoxKVInNlwpX8VBQWxUwK9FR4rVq5
         5LfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nleg3v3ss/35EwFO4a0CSmM5kNqGJPHNF9IV/Gtdvec=;
        fh=xAjaA82MGe8lpMWFU8KQCMypkU8bW2wRAkznxMRXU/w=;
        b=JsYQWbALVZqr7XHzMxnLG46ZhKqbTC/1b8k5EnVkZQiviBLRe9nv4JOJGaMbvWvkDH
         TDXRerZPnofRujK/b/OCdSsyHUbqO0QTu+BRbxKRuXu5hCms2wzygjy0uE5HttU1k06h
         knQQJxPLH4DDQKLzHlxcLviyOz5fs3kOAsMWaz8o0xOFdda2GgTKzoyidhMVQZDYm+iN
         Y9TBJG1GFiIJI2gVxMdQiJ07+wDh/3F9V6AMafZgrLdli17WSXyRWEYj83+s2AQCCkGy
         AwC1MPz/zS+vwTQC14LCY7W1F8Zd5xBbmf/wWobxGnl8VWOy/GE9P9Gqz+eKk1jMicA5
         uoVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793361115; x=1793965915; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nleg3v3ss/35EwFO4a0CSmM5kNqGJPHNF9IV/Gtdvec=;
        b=eu/FGqVWvTunL+Fu/ri4gHq+aggO+JwHHKIOk8Lm4ICzXFOlS8kzrdHgek0noYSE0u
         nrQZOG6NmtDPrz/oDRdwqDmtvKvsuVb1klRrSssAgJGEp8fQDLkR0N3HXkfnFZSKDh9Z
         ZaekPSObq+nivN13adOTcJfgylF/1wBu4DjZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361115; x=1793965915;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nleg3v3ss/35EwFO4a0CSmM5kNqGJPHNF9IV/Gtdvec=;
        b=u8KbHgxKDRfD/J1zddUBfWLXJlaD6WH/xCJ+Y6im7IlKPEJYImQIfFnC0vBeRCEdVp
         NhoRkBN49KODpbD5qtEOsI1CzGYANE/awgNE7H2Jn8q6yCh7O94p59q0dLcmYrl8ZjIl
         uMTrREDWOfH4E6QYkHkHOIHfDHIx5NafooBUWJvkg9/nLGy0IIs/FdViQpZ5K8LRDDZX
         5VJAb2a0Gkqx86Cy+8VtDv3hEUeWJP9d3Dbvp0DQ7RTR7tGhQ0p9QLwnTivO46d5O8jh
         srFwvaFJrmNFO+mGuuk3q2iR9anGIMLkFBTFXO8tXZgqWfFOTrJjBhT/6VWsUTKQJdir
         0tRw==
X-Forwarded-Encrypted: i=1; AKwUvBwgbUFGtPumGZRWzOVsIhicJeB9XdqRXIeKmkvhuze5gYXmMSy4p6J7Mh+YqM2TlKnFoWw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBBHd4GFMfuKmagKtgzkcvvaauhAEp5l7hKRPoEdh6RnxOLAfx
	iuYk9AwpiDfZcpIsypqFTSTM6Lz8sGd9obRC2svQMM+y8Im68/bkxeI9J5Jjeh7EsZpAPtyNBzS
	CcaGk5fI7U5i3SDv58GyOXQBEA2yp8XxPeQatEhZdSw==
X-Gm-Gg: AYBFou0gjNhT0Z8akT9rJovGNHrd+Zrnbtmz+9fOt4PnrMWwzXIMl79RVkXgObqb0KG
	lppf+cOuII9u/kHPnFYvf6Gjcd/CoAiIBKoOJo6lresnBe2gmb4Z4Yp2H/2OswmT5xggK0m8aB8
	/Suk9J+isDK3VcrTXjUL9VvMyXQ+HVfGzhT2dJFuDcIg1hIekK54tQoX/OqiLJfTOw41zB2ZQTW
	AegHWlwsMz4lSm2y5SBM95UhfkW0/GptkfhbbO0fT3pZQTzQA4ovOUZdzlhZwfQKjJnpVhO5yk6
	lUXgwIRUNQC2ILmzOFEPyUy0EkC3wvezrK75xardqahSNExy1mkHrW9uOCjvrXJnsHZuBeFJnYu
	qdDgmIYD5D4bUZF7Tea10/wV+LOu0KoLfii+soQ==
X-Received: by 2002:a17:907:3e06:b0:c2e:7fe7:2898 with SMTP id
 a640c23a62f3a-c4ca7a6aa23mr191982266b.12.1793361115631; Fri, 30 Oct 2026
 04:51:55 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com> <xmqqfqxo4dy1.fsf@gitster.g>
In-Reply-To: <xmqqfqxo4dy1.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 30 Oct 2026 12:51:43 +0100
X-Gm-Features: AclHuK8qfsq-VEYvD3n14dNN-T5VMLsCIJEjjvQX8hzuTtzC2n4q-k7c6bL18ek
Message-ID: <CAL71e4PXZ8-T3RgLQQLtL2ASQMLbRrChfV6wAqxFSd_Tw7-2Sg@mail.gmail.com>
Subject: Re: [PATCH] odb: do not list our own refs as alternate refs in the quarantine
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 18:24, Junio C Hamano <gitster@pobox.com> wrote:
>
> In other words, if we tell our quarantine child where our real
> object directory is, say, via the 'GIT_QUARANTINE_OBJECT_DIRECTORY'
> environment variable, can the child notice the variable and identify
> which of the passed alternates is the real object directory, so that
> it knows not to use the refs associated with it?
>
> It is a bit of a shame that tmp_objdir_create() exports the same
> value as DB_ENVIRONMENT in GIT_QUARANTINE_ENVIRONMENT, as the only
> existing use of the latter is to check if the variable is exported
> or not---in other words, to carry a single bit of information ("are
> we in quarantine or not").  I wonder if we can change its value to
> name the parent process's real object directory instead?  Then we
> would not need to export yet another variable to carry the
> information we need.

Agreed, I think that is a reasonable way forward to a concrete fix.

I started working on a v2 based on your suggestion there.
First I tried tweaking GIT_QUARANTINE_PATH to
point to the real object dir, but I realized that might be
unsafe since some hooks may depend on the semantics of
that env variable, so it would be a breaking change.

Then I started adding a second env variable.  That worked
and it was not _too_ messy though I realized it was a bit
redundant.  We can simply deduce the real object directory
from the quarantine directory -- it's the parent, based on
how tmp_objdir_create() works today -- so I built my preliminary
v2 on that.

It feels like a slightly icky assumption to make, but it
feels safe since I added tests to cover it, and does not seem
possible to override outside of git itself.

That said, if you think this is over-simplifying it, I can
pivot back to introducing a new environment variable instead.

Thanks!
Kristofer
