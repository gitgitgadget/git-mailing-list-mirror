Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795649964;
	b=hwDereCpCwAx0QtX/k0i+xSJoBJed0ZbIAsX54ZIHysxD5czlSORXcJBswhdoT5MOwpz
	 /Jzg30yPdZU/mS6mfGBNCM3FEBnIxMA8ghZ7hg728SU3HdShs7/gXz4SKM+aWb6ZlrP9D
	 DJphLRpcKiUi7QKHRuW1kuqT6c7TEQIZO0N8CQ3JCa+14yZ4e/pMC28Tsfu/gJCrzxmo1
	 jzQ6MGBRX/ssnpZs5U/Nyh6iMe0YKmw+lRWNEJnN49uXQbx7sX70JY71cbR8Z6grFAdwj
	 ZyOhTV/khYcDeF1T6sIblWUTB5GadKouDKplK+NwatjUfZBFtFGNdwHqo3o9lDyHEvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=nrOUrX2EqezQt0k40NGBh/ngOHMPc+B8b+D0ZAvtJTU=;
	b=z0eH+tG5l89n10KHoMSAP2AOiRTayBQJzUKW5UkyijOgy4HQ9a0x0SaoiJlgy4kpM3Fn
	 TsfPQlV3J/PtXCOvsF1Zl29rMjznGdAyoHLQ3wi2kFzvt3o5jlnZiFG7x4XEGHsvfic5i
	 yF8KxSAD2UWrNSQfxgz6RevDi+qfm42xHjI9PhEi8/vbok214iSgYsVGSDB7RDxah6VUj
	 bVx+za6pFooEPYDpxXI2wTictJ9b/hMcV7gTWpdtvBKKeTwE0nXzTLGkh4r+xpgmWaPGX
	 Ujn/mlXZ9lkzRGfWfcHO5aTt9+du6HuWJpbhUrzbDC9jHX8eOxpD/6YJchnlvaeeUnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vv7QumiE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09192606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 23:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09192606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vv7QumiE
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-70b875f6f13so4836215eaf.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:39:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795649963; cv=none;
        d=google.com; s=arc-20260327;
        b=NtvnW8MmC56SPAPjXQAzKwTgb+uMXCqppdkJAk4CsYfuB2c1C7q1gRXF4kRpNtAKBo
         gM5+9SGIiWU4rlzF9d3kxQ3FgHTWgB8NtMez5EddIQxra3K79cRFzWhhdmOCwMT/qDz3
         T6s+dTymHEEUMsI9Aa5NWhPuxk8DcxdVoJlbP3a+zwBsCNrnxKSZudWBqE0PPWZJJoSR
         PlhKJYtsTqV7BHiNRB64ie2+laT8jc1kAxz/SovXboNX97o0mjW+OXSOxVscWrsK5d5t
         D6/Jkr1bbM2q5PdLlxJJE7Zz3oJAyFiiHULdUNuptDl7X+81icxEFcg8kloAdboZAMsK
         hwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nrOUrX2EqezQt0k40NGBh/ngOHMPc+B8b+D0ZAvtJTU=;
        fh=DDRQTb+wnbVU9XewO3U5V3gIkTzYR5f2/P6jJ9Y5lRc=;
        b=KXm/HNB9YdPzyb3jPDehgus0w1NMUYVNs92JXTVu+O9oJ0CCxV1j5PAJkAbUIea9m+
         /rG7sttewzq5rPiRTUVhC/SCwlaWR7KnQvH/7Pm82jFw5KrqV6RnfDK6hXTFlzs/lXk6
         ko8pTNeHyfYWhaF8yrjUD+udz7L9IuVus7eS93z2ajFIk7geVYAmlPGcrbuqAH9MCFF5
         WrQMbHXGj2VSAIq2GdPziNOcZCOu0hk8gdbGUQDT6ip4PhJvkiUXf5qYbQPng/Di2GbB
         Iu7pI7c7w9yZYl2fKXhIEWDk43DdOXUT8fzAlnGpPd/ETPLyY6+bwGmLVJ1Eppa0+X/L
         2MtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795649963; x=1796254763; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrOUrX2EqezQt0k40NGBh/ngOHMPc+B8b+D0ZAvtJTU=;
        b=vv7QumiEPASuRkD0oDDdR3xiLxGOndBcEUnsmpdNtBBdz6C0OrDwxHQu2Uz/N69rg6
         4bZJK2pcr/FMcITBaPmkSOEorXzjKeo5m06fJO8dE+J0m6n10NNIGWNg9gbBl/W8OT9q
         SepJWLq8ok7PTN5aaemUsrFkOvd0HMfi54fj5cFPZiN3ILY9kIF8chRjfOzlMuvm9/Qz
         evjk2r2GntkzvJVHg1wEVB9S176ognPoguASN+reL8bAbt5LTzt5rx0egvZcQZ7lFsfr
         AkAnbzMAGI9hD5u2k9tkxAh7bvicrgiF4r/Ain4P2yPeLnWmfP58pa2nGa9G6I9XAh0g
         hBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795649963; x=1796254763;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nrOUrX2EqezQt0k40NGBh/ngOHMPc+B8b+D0ZAvtJTU=;
        b=j9XbsGtmqbDyTTByZvQ2oVj0Rr2WcfZ1kF08Tf1LlgmHbmotcRFvLK07v2ofFFHJkV
         Cj0UAMeUPJJe2hIVqlP7xboIGdvbgUPZaJcX4QQbvh5h0PyYUB0h4BbUy6tPa7Cql2oD
         g9PNRPPVUcY+Efi65UC4gwF6j2ChwQb4Ekj7MNYtI0uI1x7N6pkWMgMTBF9gIyCIyhld
         HE8MKFqkGrdH965yA/2mwULa7cjABHHHVrwqDwR4ymNUMmitlG042OljdaymnMgMZND9
         k+vMa9tht8rrHp5Ollbl5RKd+umIsHhSd2cXcrkahFf1SQTH/QT6FRVKcQDjxO6cJ5El
         pDbg==
X-Gm-Message-State: APuU4Z9ZHqwaNZrtEBdQ0nw3/XFZh0kSQ+ceDVPB0UnDNcuKj0BP5FlF
	bvtYGA6k/0TVFmejv6ENDS7lcAdYzQAxst4tuK8nyXsnLE09IDY+hY8LqVzQJx8U93KmK7O9x5O
	rgkgXEU76L78kMezh4XylZlxcKRwnJ8M=
X-Gm-Gg: AZFdTZcwOzs2wHWi1uf7BuGZzUuM5Vfghrr+oBfZP42kd6kiKtRYpBZP/T/5dwcDA1q
	m/4awSDL/jg8f4kjCjIhc65IEJDAyvQ9HEDqbckZ8T+8s0M3pHGtjQM3Fsz8+IQz3D6YdAjLDK7
	lm7NRRzFeSHnfyl79Q8TnnhuNZXz8viyOthQ08CEBd0LsNvQxH1rlx26kSrbKZGaka9aLU3iNEv
	9PE8+0LFSZee0yaovI0+tZwS7B98BZx4lrA4h+TQSbk5yO/2Sx+Jqc5YMcmIY8BDEHSlrsUfyU2
	J+dBsWULM3L+Yywe/fWl0o84A1a5dFYcmgSKtrTqcnvUiCiaLbhWTVi/RsoaeFSqYXV4DTpvU9v
	fXv90esqISLetuM9cINM/NAv2EWGnSD1hUZrcSIx6WqBzfONqilQulXcntOyhjUy5RWkdrTPjO1
	A2QqmndLxbLjpDYoljCjX6PwvekEtwIekvYpmQcKqKcrIy1p4C6uR8
X-Received: by 2002:a05:6820:f02b:b0:71b:8238:4e2a with SMTP id
 006d021491bc7-71b82385497mr2194945eaf.6.1795649963009; Wed, 25 Nov 2026
 15:39:23 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117004348.806694-1-tangajoris@gmail.com> <20261125011002.589285-1-tangajoris@gmail.com>
 <20261125011002.589285-2-tangajoris@gmail.com> <xmqqo6bc7red.fsf@gitster.g>
In-Reply-To: <xmqqo6bc7red.fsf@gitster.g>
From: Tanga Joris <tangajoris@gmail.com>
Date: Thu, 26 Nov 2026 02:38:46 +0300
X-Gm-Features: Aa3M54p8XMp_T1GLTd4xzi1ea1WIx4ToE3z_qsqcZ3uJHH2k7lmtzy2Y-QhBodI
Message-ID: <CAKrRMNp3TZbejSgiJYo81=sgHK=xZzr2bu2jut4Mq5wZbrr+3w@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 1/2] apply: reject an empty "diff --git" header
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, siddharthasthana31@gmail.com, 
	phillip.wood@dunelm.org.uk, jackrawlings2011@gmail.com, 
	christian.couder@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Junio,

On Wed, 25 Nov 2026 at 20:27, Junio C Hamano <gitster@pobox.com> wrote:
> One small pre-existing edge case worth noting is that the earlier "if
> (size < len + 6) break;" check in find_header() still runs before the
> "diff --git " check, so a trailing bare "diff --git" line at EOF with
> fewer than six bytes after it will still hit EOF without this error.
>
> Not something this patch necessarily needs to fix #leftoverbits.

Thanks for the review. I'll send a separate patch for it on top of
this series, so this one can stay as it is.

Thanks,
Tanga
