Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D02F8EA5
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727452; cv=pass; b=VM0SucA+VwAJwa11wKiE3V2JdX5dCJAoz0LzgVIBydrJFylkFt3jAS0vOWyNLVIlz4I/O818yTAwZxqZ5TvyDt4giw7vp269pzGUYg84QyBbiCymz4/ZQLuwj35D47K+PpkrnIyk1918UHS0H7Ex7ArRa6GkqoqTJFZytQmisYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727452; c=relaxed/simple;
	bh=G6+q2MK3atiGurB3PFmhbM+gX1sk6ASKETZioNN+gQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2YBqOD/J3Vyp0a4wH5iVfcri+Fpa13/dRcBflIj+n4FI5vqArkkwYFL053BRq0zMwWsJx9yd4Uz7G2u7u59yTou6pm8/LGaoQYFPeKk6ljjZcewYASRC+bGYzLeiSoSwc/qOBIyKwmx4mVryIz7idPtoNUa6FUQS3gm0bN9enU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc/HzG5e; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc/HzG5e"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c197e7e4e94so85003866b.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 23:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787727450; cv=none;
        d=google.com; s=arc-20260327;
        b=X1vZC0GZr56DQjngwxbVkJUInXIdmIRtwWDHkEK4ruDPsPKfFtkezCMGgksIz2+vAp
         YxjafRYkVtV0iwRksCoF6/YRC/WkhKR8kJTJwujNf2OwwvxOnxYHSbaMhbiMau50Q87f
         O63yPKDEPTQeKD5taS1+HfWRAs+DFK2E3H9Btui+4zKQQ5Q8asQMmgAodgfMVuDPagFV
         n0tbb3kq/2G56iFSpLo4OIBzDrj/ekP9XlDMWe5oI2YT0+uJ7lxZ+ARPdy29fzNTHA79
         gc2TM72IIhKUA9p5umhGhkrIYjYMMI07NJj6R31xRe7Z3TjSbpiopoWqk9jw9DXjZ/rE
         q42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G6+q2MK3atiGurB3PFmhbM+gX1sk6ASKETZioNN+gQE=;
        fh=HfN12E73m37gfFT465JJbkbtDR0p4Z/kpsGwJWvW20I=;
        b=G+ri2AzHqy7tBQVX6hrUZt68/mMxaw/vGjPldg0nE2nzeAkGaP+WUuC80Op23tbKjQ
         92flx3TjvBQVPVS/0+o9S5I/0ACbACooakhLNvncoRaZGuPB3U9FM5mRtmsSLpFj8nVx
         5Y0Kkg6/xmV2pMrTHyaIZI4iSNSgHFj2L5DZIkcIn8jPxbV66Xe1u0L6IjI7C/Unkydf
         tRFb5K+dZIG3UuMAcjwdjaJGF0hJIWVEpIVW3IC8mcyPIUvixOiaOMzgQ9ajpr+XGGCj
         uz7O6Q6dBsdCorbMxmxXNPhquZrawoE2eZLLAP15otIshrsEuyDzk3hIgUnr1dg1kAJl
         HqWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787727450; x=1788332250; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G6+q2MK3atiGurB3PFmhbM+gX1sk6ASKETZioNN+gQE=;
        b=Wc/HzG5eHs/qwX5R36BUKxfk77gZlIOhwR/RKApQrIgUdTkAnv9uhvvxuNiVXFwCT0
         cqP9YqtFFm9OlAK8aVPaIIMH2yfNpHp1TwF2lUsYtOvztTwd+C1lIdiXlck5quJDKj/D
         20SN/XueVSSiSfIjeodWEqr+S2e+OYsgSM0jUaE0HJ+Ll1gHZO8ycL9lnYvp6tj3B1Nu
         N5nJw8liVGwI3Gbf9PJ9uSMwgXNdoyZJ5vO/EtKWOsY+vXIOkxoTHyBN8LNAkqZefrYb
         kRD2Im0j8Kx4xgJasX2RRu1EEQjoGvBkQd1fNT0WemK1Q7MbxkYwZ3xQfRgMabwH85O+
         0LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787727450; x=1788332250;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G6+q2MK3atiGurB3PFmhbM+gX1sk6ASKETZioNN+gQE=;
        b=eLTaFpvlVTka4E0pL4Fv2RcoYyS2WloTHgS2CmRhf9t7jXcEMxcSUE9WOIWRsS+fT8
         r6MoFqRoMDGIffzSx51W4/x0Kgd4TIQAAkPhhSEi3+FVdVmN105JM5YoTs8Rdu+N/9A6
         3AjXEhS4kf2t26wFgecTDIidnsnoqsGKWp3lkzAmn2y7G3fqeG/tz+BrLubAz/v5XXHe
         WAztebvFF/3Soc1ReRQp4KrqBz3jt4SOA6SMGvgfRFPLfuqsmmng0a4Pi631Qd3VlEE4
         7yXsf7/5Nur8ZJ2f0+GcWZ191jqBozxpKjajWXbLh2gp0Fd7EQjk3yV8zSZKPGyXWXrI
         4ulw==
X-Forwarded-Encrypted: i=1; AHgh+RohZf/RVPeH7CPlUsXQwLs4KOu3Ndppq8OyfqaXVAdsm7vueIIzHTUCVfl8aza0fsDXhZA=@vger.kernel.org
X-Gm-Message-State: AFuF++miZtR9G5THFB6KrvIRhD3a+Nj6PCUpaLeuOmgqXanONn1V49rT
	Yv0xqB0elC+WhLM9NLsQqz7YX4tHnVL1MbMps76UVjw8aXQCkueDGt0bK+BCMz7jCpqDZ7d9Zla
	+voVnM/WPYSFI6bRhL/Rsu+EZqhy2K6s=
X-Gm-Gg: AR+sD12xI7yc/UkWlgenMDd2SSsAClArjfnuHaRIGNnhDGG3FqIwEy606piRtU4oZcH
	wpTJOlJXzgnMaFvarTfsZmS4aq+8uUJ68izRH56dYbpsSCK4ebq9suXwsSE3SH/RnlYK3zGkkoz
	wD9Mlw/uIt9K9QWZp7x9f/hbBowMrfe8hgbCi9FlA5gSarJD6xJTNo11IfIKuD6dhNn6Q06nlOs
	skBPbt2PqnChvD/Aeb0BlAaQ2eGdD645PSKMXE1en+qnSYxKhzU64QA5aq4TaxmHnHgSeTAFbEl
	3mUrrxb72ukWfWl9koAWQVg47YGl9MLhJvC2ud+ik7P3
X-Received: by 2002:a17:907:1b24:b0:c20:7cb1:9046 with SMTP id
 a640c23a62f3a-c250bbce005mr536647266b.8.1787727449625; Tue, 25 Aug 2026
 23:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2365.git.git.1787693117.gitgitgadget@gmail.com>
 <d3d7a06e3d6f0c7adf9739ca496ed4012e261ac1.1787693117.git.gitgitgadget@gmail.com>
 <xmqq33w1lv4j.fsf@gitster.g>
In-Reply-To: <xmqq33w1lv4j.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 26 Aug 2026 08:56:51 +0200
X-Gm-Features: AcwNN1XkcNrGuhO_ZXAva6aup29o0DQnlkrfu4_ioTWP_12JFlTY-KsH_Ca_8bI
Message-ID: <CAHwyqnXjO6Cv50BVjJjW939A06-bQtcA2uf0Cwk+xuoc2Gh_LA@mail.gmail.com>
Subject: Re: [PATCH 2/2] branch: protect local upstreams from -d
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hmm, it makes sense what you are saying, but I could have sworn that
you asked for this (likely some very different version from this) when
I was working on delete-merged, i.e. to extend branch protections to
'-d' as well. Phillip brought it up recently as well. Maybe I
misunderstood.


Harald
