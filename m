Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257731;
	b=S6ft9yDy717/akiJRpTiALSR1tz63l0GDzuIEKEy2kd6zYEzXC7kaAeuexrtWpDltiEs
	 NMUe/gwMwwUY/s+tUeAjlAuSTjWHW4U6Irza1KXBB1JLI9Aosxs+wLYCyt19GXuoXPjGP
	 JjmQe+p6Up8IAlnCcL6QHumMV6N2igrvH3oqr6I5MhImktyZZ6VPuGNjAxFDxUYxdjI4n
	 HpLZrEJ3h+ohuTk+WyJtp90JFZNLozBlIQDnzBXHrG3NZkEZdOe2Zw1euBKVpkAXcBvlG
	 XfImtl2R+P5fl20iRqaFP50CLSnhmPCt8iss39csinYj+vbx2BMFhO0OP3ySx8ETBbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=8U+4bj7jfCKFBW81CzAAe4bBdfmu/353Cf7S/pwvB/g=;
	b=h4nBxGvF6fNeuKfIrN1vP7V+ohAXIskfBx6Hw5A7qsL3wvHcUXA2JCpi8AVSnZtKBSRm
	 5qBmdNYhuGxlLUAwzI7SDsxeGookcDbaY1Fg8cyDaQEnOu2F74X8noDwsevAKZKghNMQ3
	 aid+LsGFKWFX+W0WMGCnXULl1PR+i2Aw+YvRi+LtlsOiB+Z8GNjNe2PGK49G5Jb58R2/5
	 54MmvGyUb5KiCO/P26oNwhBtlPnJ/d0ruQ1L7mqaf/MBSbHfVjlKbHQ8cdR2ITDVVF9c2
	 x5kRfb6+XmznseTkHrUdcTTxjPgFztg2xXbdSF04XZp0aAcyqd1am42FKGDWw1X52SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bz/uuyil";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953BE606A335
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 953BE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bz/uuyil
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4adba7b3399so534348fac.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 12:55:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257729; cv=none;
        d=google.com; s=arc-20260327;
        b=fauoEcAUTAll8yL2zFwi5ZXdF1cbo6vafX/v729crDVSMhsjaFUX1QF2o6YBMX3xZs
         cJEgFYSDFa8tK8sjx7Uyz2KefnFBg0dPpEbAEdBN86iR6RUp7PiiGLB2d2rF52JC0efU
         xVsvP4U9MvYdgAfmspziIARSgv7b69TRckBqutcCY1zmR+JyOn5enjo/284r+DybsR1X
         wyn/5WBMYqKdT1Lq/57iFmYYuu1GBQj7XwC/NCL0WIXGRl0w5cU+WQjvqkMHYJ/R+KEh
         WyWrs6Ed57hoAaZP3vnS22hnensPFhm9WilLTiqGBf23hL0eU5ywebBTxI5yxnjYfo3T
         udLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8U+4bj7jfCKFBW81CzAAe4bBdfmu/353Cf7S/pwvB/g=;
        fh=cjbW3SH7o/dwg/y6kqpWD0l++1enyM58I2wH5n1Cris=;
        b=C1d2SgsBa+Mu/4xz0SJnW/zP+3kVMLuE/32tysoFrjl2SevL+rnqFZxPObhFqrc+fM
         53bCPyLqoGhCD2f8UX8K9kIPiBOdgsqwn4SVkUVdAH9AbA2U9rnpNoVOPIBR2Gf3JvC0
         jnbpcvQms4rbdnSSdaKjV9dugU8JxW1BjgSGjdDAs3b/v+Zi4yocDpW8tJ6ZqMq+ogQZ
         kYQFF1MoY++zVwf8PgHjzmmoH4bfZq6clPUXfi4oRQAwLGrHFaHV+utXUnXmljIp2Mxz
         9AJQfQDIU/uqccZfvz2Opcvx0oi9SVt2afYFUHF5CBjqt2VMsbi39crHxnq+mIfrF+vc
         44tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794257729; x=1794862529; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8U+4bj7jfCKFBW81CzAAe4bBdfmu/353Cf7S/pwvB/g=;
        b=bz/uuyile9JByhv/o/lovGFgXev7JvFhE8psRZUhVvXynlyLG14qkpQF7zusIG6lO0
         GLCeV/s5JNi26h/TrfLwMxbFiemsAq/iI50Kqb8eKsFuXArs2dN/yaiHB1aRYdSZCJUo
         pXUFXiI9ODKB2PagiB54deGiAwPsPPgK47bMg4oHyL2jpTC0lD2GqNL8gCnZzOHyIO41
         hanjuoKZqfq3O3tkRi0RTSkbheAhLYq47Y+c2iv4eilxbGbF7Ecqks3LqXfK2NFNRkE6
         GvqPYcurmXGSNcx9fMrKxe0CmeuBPwhCnrmeuRdANQ1nguDlp6lMWWRJeK7q8znRM+WN
         FSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257729; x=1794862529;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8U+4bj7jfCKFBW81CzAAe4bBdfmu/353Cf7S/pwvB/g=;
        b=Odm7AJbrCeWQSnrAjldzQY8sAOSMl2jtIfHzGau0j8mkvYLALX22HMV6I2zmVVFgjA
         5OhzwZTHDFWYVWVO2GnKIL3EZgmIJS4Vi5GWTCH/dhrP2MkXnBCHVHslHldY8XXgQpaB
         vG2TsOhU+M0HJVHa/dQsFM1r1OxANQarvPSqhtbEWOJa75ZMx7slAQcfmUdmuWqDlOp1
         C+Ut3QfO6AyZFqdPge68kSCzsgNOQqhEtsfzAKwLjCF7mIbLIeYwL5d4MbX+ZBdRXG9V
         u6ar96ek2HdJrjZpRgXcX73LqEpE0kHz3zM+uoWPlZn3U/Dx/pVpFk+8CnIwmCd9Ihsk
         LDiw==
X-Gm-Message-State: APuU4Z8Xhb9Z5akCIcLMxHzA5arqNqddXrUN96WEa0w87AerCU2QF4vH
	B1C+LCa4WZi/zsc9p6ufrAeDOdravZ6UHptysr8EyKuc9CwjAe6ExdYg4mZpLxMspceeMIAp5/X
	wM4WaKn4dCC5MVxG2JhzNI1o1OGY0u5Q=
X-Gm-Gg: AYBFou2LqAfAnOqcCWSk6BSSV9lYK/4Lk+TgaNS+H9ipXSHC+sFs1t80pC8LCoot7Uf
	t7dyo04VC6onULTwgZhhdpTM73pJ51bLPMydxcB7J2pD0J3T0OWhK/MX+TjxsT8fonPiiTZpBH+
	AfXCIIx/sHyzZx3TMrhVqgPgyJ3MW4D81ftpfqJqy6xs8DsBP/xEVSE3XWM9NRzs0Edqogk4KM6
	MlZ1HtLlCoP/8HmGAtN0dffMyc1YZ/szLiAN42PF+4asN8XVVR8mXp5p1K6N4XaUypNP8xk/hsj
	KJeoudqHmwmjfpJkYNwH2jZScj+Xk/TyEjqKgi3bXtne1xBxc78mxtpG769cIPNRY5fyAQmenXt
	W0fymBppYiegQ1T1MQdZ1vPPlq9zxx7wN7ujYmMj5SC8Tn+HSEsnPt5psPeBIgkVG80+8dLnEL4
	Zxlw2kBgYWkvMaK04NHeA/L+LvqPLzrfPKttZ6bpUu7c0sIMiWUh+PSg==
X-Received: by 2002:a05:6871:88e:b0:4ad:8124:9240 with SMTP id
 586e51a60fabf-4ae2273915bmr227556fac.32.1794257729351; Mon, 09 Nov 2026
 12:55:29 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
 <20261107195429.96842-1-tangajoris@gmail.com> <7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com>
 <CAKrRMNr5VJmvws0asHgmDxCNxo19ctGTpM2eoTMT3iQ5v2cagQ@mail.gmail.com> <d5bb8fe0-7706-4e3d-b471-ad004411a9ed@gmail.com>
In-Reply-To: <d5bb8fe0-7706-4e3d-b471-ad004411a9ed@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Mon, 9 Nov 2026 23:54:51 +0300
X-Gm-Features: AclHuK8Y7kxAwtnLYzwKjkfFE_IXMaylF2eV4eD7RmGRza4JpKEgyno8ml9htR0
Message-ID: <CAKrRMNrwEgv6JsWcd+UorLrKcsBgHV=UUvfH316hedM2TYGWqA@mail.gmail.com>
Subject: Re: [Outreachy PATCH 1/2] apply: do not keep names from an unused
 "diff --git" line
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, jackrawlings2011@gmail.com, 
	christian.couder@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hey Phillip,

Thanks, and sorry for trimming too much context last time.

On Mon, 9 Nov 2026 at 17:31, Phillip Wood <phillip.wood123@gmail.com> wrote:
>  >>> diff --git a/f b/f
>  >>> diff --git a/g b/g
>
> >> This is the only one that I think it is reasonable to accept - we have
> >> an empty patch for "f" followed by a valid patch for "g"
> >
> > Alright, I will keep accepting this one.
>
> Do we accept that now, or only with your patch?

Only with my patch. On master your example fails with "error: git
apply: bad git-diff - inconsistent old filename", because the names
from the empty "diff --git" line are kept. A new or deleted file
after it fails in a similar way. It does work on master when the next
section names the same file, or is a rename.

Junio wrote in reply to your first mail:

> We shouldn't accept anything that "git format-patch" (or "git diff")
> would not produce, I would have to say.

So I plan to drop this part and leave this case as it is on master.
The next version will only turn the corrupt patches into an error.

One thing I noticed while checking this. "git format-patch" can
produce a "diff --git" line with nothing after it, when a line in the
body of the commit message looks like "diff --git a/x b/x". On
master, "git apply" fails on that patch with the same "inconsistent
old filename" error, unless the line names the same file as the real
patch. This is not new, so I would leave it out of this series,
unless you or Junio think otherwise.

> Oh, so
>
> diff --git a/f b/f
>
> index 573541a..d00491f 100644
> --- a/f
> +++ b/f
> @@ -1 +1 @@
> -0
> +1
>
> applies. That looks like a corrupt patch as well to me and if we're
> ignoring the mode headers I'd say it is definitely a bug and rejecting
> it is the right thing to do.

Yes, it applies on master. Alright, I will reject this one too in the
next version, along with the blank line and the indented "new file
mode" cases.

Thanks,
Tanga
