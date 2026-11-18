Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795044785;
	b=UAEBBiV24OiuhinV8oIH1yRfIDNXocXFzpbu6Me0WUi6k4NJoaXwUxa1FRBlaOumEuVc
	 OR06vsd3yvR8EOW+vuEV/n+oO34ksxa3XK6D6VkKDLADnrlhSYzJs6la21uM7lRREImCA
	 jrvfOrv/bvYygoLSwmj3/53hrS4iyukIxOstrjXe5ZIrlALJ26S0HV5DWNtuKU9S8ZiY4
	 7W7QLaQ8hEmEGxhmGCHlEhEn25zI5YsQbWtLlwE99bZwO+iV/yC4LfC6jPwO50xpG0PSF
	 Wv3xQhgWFKq7KDR/M4vOhmoCUdBcWMpj2YJqt6Bi1Xlm76QvYIIbLt/Od1lg+F118fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=I/BqA7DA3KBgxwSbn72+kbqnq8uTfWIvT8RcsoD+YGc=;
	b=QVd0kRK7KNUXEz3r8Eoiex446y9+JlX58h8o/U/oI6ubgq7yBU0BZC1i7UJbsLy5kV/Z
	 2O3wqh/pYkRErWS5FLSaIjTFecaYQ/ofS2GEBrjQ7lu5smGgWgT8t862ZUAA5Z06psD7G
	 53dC+uQiYGxzHjzZk1bZKc/5MhzNbKTOxnfW2TPHX6R0kZ54YNELuKiGbrdPvwXB/fm6+
	 Wm9wVF5oL9uZURcUQwSOU4ZLfhL8got2W6ipLh9RuT62E5lTiH/OgHdWATnAxHWvmPTSf
	 g7C7WdyQMSzxaB2jYqTNyi9r5N/7jeiclCq9zwdSJLUQuIYGYrx0EkHgLWjQBYoZLHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmcSbxgg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96C606A330
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 23:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB96C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmcSbxgg
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-843b6f8e2c7so1685273a34.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:33:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795044784; cv=none;
        d=google.com; s=arc-20260327;
        b=lZnlKwri/h/czHcrujCHPBIFAlAXXGX1CthMfNcQBJTOHwCCQoVTnYphIB/NioCAko
         k/kQnywtA21ZkRCXolpx1lFqs2vYQ4xdnU92POMWPlCWJPlJhkMMpPJKuQZqqX8NJyiM
         N2pIrSToXd3oBrVFOlHKpjBWqO8tNN+LmN8aYmQcPdXBU1lSSBW/xdrYfXQrnZWsiH2r
         fEh/+f9HliDNQaMc1x7YbTo6/Lf66N0OTePvTMisK3zt5ZxRQq151E065zmEhfHN+3lt
         clJTBDI5XgLwQP3D53Cs/F2sOUuAlD3y54269dyJqeqtlr2AGw5eMTIlyJozIM7FTuUV
         l5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I/BqA7DA3KBgxwSbn72+kbqnq8uTfWIvT8RcsoD+YGc=;
        fh=DDRQTb+wnbVU9XewO3U5V3gIkTzYR5f2/P6jJ9Y5lRc=;
        b=I+c/AeP10wo8B9wLicGO0WAe7Fphhu6ScH5ThdfwUYwzzrzNedVknv+6EnDlZsu3SU
         /cSTKKt2PNbXCZhv6SkgHgsbrWmM+oN66EnMOOYT2+4H87Z1+KZ+kT5EuxSVG+E4FbtV
         tbd9bBwdwVYoaHf5/dvJLlXhK+8xRKO7BL4kSPwW7fPI743wBkkFXHOs150YV789TIrp
         gyPeEBkpXN7fcF9ivk2PqQfK2p3pgWw0xiO121WrvLPQ+pbyAEztig19vQeZo1YRsJU2
         uzB1BWTPBcqxk8iom9WJXyIZjR4OKXSGBYudNuciufH269ZfOIm9oxDFiZIQlkw4ygan
         Vqhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795044784; x=1795649584; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/BqA7DA3KBgxwSbn72+kbqnq8uTfWIvT8RcsoD+YGc=;
        b=AmcSbxggLwpQpRamYinXtAMDCuvlwOWWpFQNq0y2DzdJUsGXU6h1sZfTZgdj6vV8PZ
         qLE26dI6BqUfrlaXqf0dbHF4SuZR5NMQ2gsnPD0CwlEDC4oOEug8JnKLUW7oSRyK4b9q
         aj+LHU5B6xF5jsmgx1DRwp1/QX7dNxXp7OI+bZ9c+y9HpW5FTRZK9SXdBs7uNah+yRAY
         v02OJqmIA+nYaFNDbZOQeZWDt4P3WwUFSjfruJ7CI631aPDYBvrCc590a8zZrnOyNfQV
         FrgtGekvmnxqk0SgFxWA/KiaupRo0qN0vKocHgvoohGqm2GIcrmGYvkhiVDFJIVLpm4O
         5oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795044784; x=1795649584;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I/BqA7DA3KBgxwSbn72+kbqnq8uTfWIvT8RcsoD+YGc=;
        b=iZUh3OCkAc6r8aizhXo5W3E7YUeHIeUWByPDIb40bi1GdBdWRN/Tk4ffu45b5EerHQ
         67T/flK6PmQfJ8aQMFJU+nwREik18kc9ETIcXizRhqZm3uQozbxWGxdeCPA+4dd6xjT3
         9aGY2xkKcUFxOZ+bIvPzNlEe4A8uEPJa9aY1xumIpQsUBrEtPtpBeIUT2Ubk8fVq/72J
         IqxCPW7pDRKNMw25fU512DvuvxoL0X5uRIOu/1y/Jb7KiUJ4POZp4NYzFw1G6dFriAXv
         HqcICqnlPWQg5LhOrwt3e6XdsFQhzyY429/oQvmc8+SuPxvgUWJxITCTjJKpnP8d7zPi
         +fkA==
X-Gm-Message-State: APuU4Z+BEZ0tCnVb0TVeooTXORLe0HyWa+mXvT/2V775gM+Zy17N39pk
	JetTMyIIZOdEArqXb+ojkSox0UpdmGLzfNXIAL8dZp+Iad/qQyfwtz5JHnOE9u34nv/qqgXPqfk
	9GEWOwHUiaqh/Jc8NEUQT8i1YiqeikWHJzIaZy6k=
X-Gm-Gg: AYBFou0JIbv+uSQpQiX05bWTKc15wkGEGasVO+Vk4zMq5904eXDDfPntXnWiMTh3rMA
	6lbdsYwB4J03rxshw5ZiSLXgMC1nU71ExX6dXFI7w/6E3tzf7FIdsHwJPNfn30GwZ3vXPAxAB1h
	1kGcG0LvfwuL1tond5H8UaX2+l79wMlhDa8d+FPBcWpr1sajgLZiRMpYfgavmt0tiJ3IIfALTis
	5iunQXX+Yo4jqwv7M/lR6LrTE2B92gczeoHrhVQw5MRmpYg74rBwceqt/qqg/61H6t7yUTny77d
	9dvUP7P1JpbF3HkpnqT5Anwtzdz5VvKOvDbyWFhOfFKQkeDi7umlVc525ZHNW081tNV0OSuwZS2
	kWUk1SEvsWcjjHnjsOOBk0NKWMFD+anKWyfpAzmNS452TOVx6rJM0nhihGXaUBigUOlwWMZWo7o
	uBQIzELKxSpHBTeA+p8Fl7hBmsp7sVsSAOfdYYItM7PYAZ0tq9XCGfsA==
X-Received: by 2002:a05:6808:13c7:b0:4c4:d8a0:2773 with SMTP id
 5614622812f47-5773d92c722mr4857724b6e.32.1795044783710; Wed, 18 Nov 2026
 15:33:03 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114012055.127905-1-tangajoris@gmail.com> <20261117004348.806694-1-tangajoris@gmail.com>
 <20261117004348.806694-2-tangajoris@gmail.com> <xmqqh5hd50e2.fsf@gitster.g>
In-Reply-To: <xmqqh5hd50e2.fsf@gitster.g>
From: Tanga Joris <tangajoris@gmail.com>
Date: Thu, 19 Nov 2026 02:32:26 +0300
X-Gm-Features: AclHuK9VFPhEji_IS5nyAcRe6Bj22n_zSZdgdLx1_hJTVBG5Qi4rb354sWKS3fI
Message-ID: <CAKrRMNoB-4==1EPLAAXE4M1J6bUwuWj=p32CedDvOTi3tzO7=A@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/3] apply: free the old def_name in parse_git_diff_header()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, siddharthasthana31@gmail.com, 
	phillip.wood@dunelm.org.uk, jackrawlings2011@gmail.com, 
	christian.couder@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Junio,

Thanks for catching this.

On Wed, 18 Nov 2026 at 23:51, Junio C Hamano <gitster@pobox.com> wrote:
> The test below only "passes" because the bogus "diff --git a/g b/g"
> line names the same file "g" used for the next one, I suspect.  If
> you replace 'g' with 'f' on the bogus "diff --git" line, you will
> see an "inconsistent old filename" error, so this change is not
> making us ignore the bogus "diff --git" line, either.  Not that I
> think it is a good idea to ignore such a corrupt patch input.

You're right, with 'f' I get the "inconsistent old filename" error
too.

> I do not think we should ignore such a bogus "diff --git" line;
> shouldn't we diagnose it as a corrupt patch input?  I do not think
> we are there yet without making find_header() do more work when
> punting, though.

I agree. I think find_header() should just stop and report it as a
corrupt patch when a "diff --git" line has nothing after it, instead
of going on to the next line. That would make 1/3 unnecessary, and
2/3 a lot simpler.

As far as I can tell, Git doesn't write such a line anymore. I tried
a few things like "git diff -w" on a whitespace-only change, renames
and merges, and every "diff --git" line had header lines after it.
The apply and am tests also still pass with the change, apart from
my own test in 1/3.

Is that what you had in mind? If so, I'll send v4 with it.

Thanks,
Tanga
