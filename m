Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2342765D4
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776380003; cv=pass; b=HU9oV3ago3Ll1qYSBU5BRfjIhH/fhWFEfpaulqkxy94Cx88irFFe5P0gHyRAdyJbzqFy/0XdbSrzRDt23dHTYkcoYAkxe2bJk9FRa/vpWYGrHLtroRaICPzaerXtDU+Un+hhAkQXNRttzAfhl+BINvfYXKdqLHST5htbmnUO7Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776380003; c=relaxed/simple;
	bh=uTvoDmDzd1Mkp79oPXsS9in6C1ykFcLOyKawAQ+4pJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azpeVT3Z16UrkpqQ+6TWOMpc7OD/cHeR899y0Anl79BRyZiWodLdnZDPfUbmXV3nB0+YCr5bLkWFSTXLQa2Nzt3pU0G8nJdBvs71ABZ5XzRY+bjtp0Q/Qx2S9xf0ErNNV9UJaK3Trfo32MWO3Vlx7YYGJUbpFFxzD0jNXownQbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi7s2aW0; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi7s2aW0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad9a9be502so220835ad.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 15:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776380002; cv=none;
        d=google.com; s=arc-20240605;
        b=O3X6dmxOYQCQ3S+voYT2X1E8d8Dwf+faDK0a+SuNbGLMQ/5ILYFKe+Gy/rQyz8ZpTL
         iIJ2bVhHyGviW546dGChl6VUeVcfY3u6DwPJrghOAMj5El/MFw3dfqaUp8uoLy0xiO/t
         PcGSK7S5ip0dYajmP2dl2lUCLCjwGMp768m37bvTGZSNvoOXrDd6Pljt+XYY3o09wdJp
         XSaEFIoeKk/pJI8OHFJGDwUcfvDGjDrlArZYrimF/ulQwXH44Amaito8OnbDF8GqgOWo
         4kxAgkFmrQ7c3+Bx9ws4aSTM9XATAOsHKpP8SvG12Rve1DmHlVXzlNpDWJmtDgFMo6Jc
         NY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAfWCJPMxsv5S5V2q8DUl3LA81u8a97VSW7cPlMlIFg=;
        fh=fDra5E97jdgrddDfDvRTGbshnji+3XysukvVq5At42I=;
        b=Y+aPt8f0vE8V0o1IUkzeZT3CCzNHJiAS+kZ4OnrjLbySBfuPls2dlyQCYF9qk54VIG
         jap/Iaz2apbutDdqzemnFxptLJZL9OZYANmMbmyyGFZDy+Uk4ngER70gkonboS3WaEh8
         Q0MxCMG8KkV0j2M/n3CW6AwKx07vkOQWA13SElRba5UoZgEIrNOPIc5gMA0KpIUHIB48
         v+WG1tguAwq1y2PTqujXKIUmDbT39qr0g05H6Hgf62I26iDy8F+or5kvi0OoXyXu+ENn
         Tk19NvHk22b2n8rD+Ra3zEBRlm/IJKn/tjodj85Mzt3cbyvUr+wP6qJ4UYo4Nn6qbyXz
         Y9EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776380002; x=1776984802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAfWCJPMxsv5S5V2q8DUl3LA81u8a97VSW7cPlMlIFg=;
        b=Hi7s2aW0cHG4rBYCL11uLgHvqdmvGXRtcwubkQLGELb0ISZFgVNtAP+nQxyYDHZ7ve
         jfIxHob2KrmkXjKJ+K2v/IEuTxBPf3IKA5FySZlFAwhpirc137zdFqVkdVkKHbeTeZbl
         Y1WcqJZKn1FNIu9Av5pTNn5tGD+YOr6KqKTY7K+edbBWnQYmotLuH+o0WRu2OhymWb26
         HaHGvhCePRg2MdOnXpX6pNCCW+xQeWnPsHy4RncrRtYfxN2pz7cHFdPsY4Ni7b1cutl6
         4QUO4EY/1YiIh8flGXYjypr02pLmUr4sSPHbqo/HeBwvaKDpA4QOIoB+zcf0Eb4qSPSF
         c1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776380002; x=1776984802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAfWCJPMxsv5S5V2q8DUl3LA81u8a97VSW7cPlMlIFg=;
        b=avgK2HoUqm4y9h332WRDOOjxqvvxUXwplp8Rj3+fCOo9pcxd2gUD5XewWM00b+733C
         lbMPfdbvJkCTArfg2fGeJqi962oRutHbIh4VrpwHe3ef5InkN+Bn8zhTAb7OcO9C2f/R
         TFr3JfDqKyiTXcw7ejaT+1joqaqrAuZWhCQqjhBzPpq8nbbjDTlZaxESQ+bhBdYiZH3r
         S1LkMgTJrITLWFj3whlKH4kAhLKuZTkXqHWnTtDbncvmQggBi1QL9BFuLTRgwznXtqpq
         rstQlptsSoceWScBET8rC6NWDcLuM32Emn/gW7+vnpovSh0Cxdy/pU+sVPapGIFCYh2R
         aSEQ==
X-Gm-Message-State: AOJu0Yyera+QoIRYsu3ztWj1oSH34w6T/Cry6w1OTvHjd0XHECxwOwRw
	d27tkETHDt2KG2PF7K5eFNAKpTpnMkt+O9lcH2Vu31jkIypvoS22Rfi7YP5hE9f2JhqqYkTRyvl
	+o2SZpUlvflM6GjvyfQYv5i8C6PStHLA=
X-Gm-Gg: AeBDiev90KRjCfiQL2qZHvElbS6vvQzHueSlOL6tmakWNpBZN5Fv8VtsqP0l51bxuP/
	+XepxSy8g+ym+xlPqNLEpddstmbRggmuS5bnkT9mj7UkNaRZUBZCvSCPCQk130BcVCY6U5vLVYF
	W6WNXJjfUz07r5ri5vhS2uFk9p/MysB62ygzoXSCEC+9FmG9K+O7BmnqQQk4lBlI7I7wAXb+RaJ
	vFDPacgPLLuQ5a4GdZmtK01+mghKTuY4/XaEO0YRBszfzKKPb46t8sGR8fCcj04eTTJG+MY7YBT
	r7wMQbDzkbCYICTgj4PHuzB2ePHh30JsfmCtlis/QQvZfF8zPsgvxnp7GKcg6H+okNW2TclhAiP
	DpxnDz/vm8fdKLz4DrXZ5T6OZcBQUu7EtH2/V
X-Received: by 2002:a17:902:b182:b0:2b2:4f43:b498 with SMTP id
 d9443c01a7336-2b5f9e94b72mr2265365ad.13.1776380002129; Thu, 16 Apr 2026
 15:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774820449.git.me@ttaylorr.com> <8d5aa3d6fa70d408fc02561f2203ae1a48186c91.1774820449.git.me@ttaylorr.com>
In-Reply-To: <8d5aa3d6fa70d408fc02561f2203ae1a48186c91.1774820449.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 16 Apr 2026 15:53:10 -0700
X-Gm-Features: AQROBzDACYh3slQGYfAauT98m09v09LCHQt1YzSRSSOf9llTUyK0aQsIijoyUxk
Message-ID: <CABPp-BHuj8UKG3Mh9opniHMrgNkKiWLKv7pqVAex3PeAX1+Ydw@mail.gmail.com>
Subject: Re: [PATCH 14/16] repack: implement incremental MIDX repacking
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 2:41=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> At present, this functionality is exposed behind a new enum value,
> `REPACK_WRITE_MIDX_INCREMENTAL`, but has no external callers. A
> subsequent commit will expose this mode via `git repack
> --write-midx=3Dincremental`.

Noted, although...

> +       /*
> +        * Compact additional MIDX layers into this proposed one until
> +        * the merging condition is violated.
> +        */
> +       while (m) {
> +               uint32_t preferred_pack_idx;
> +
> +               trace2_data_string("repack", opts->existing->repo,
> +                                  "candidate", midx_get_checksum_hex(m))=
;
> +
> +               if (step.objects_nr < m->num_objects / opts->midx_split_f=
actor) {

Here the new value is used...

> +                       if (proposed_objects_nr < next->base_midx->num_ob=
jects / opts->midx_split_factor) {

...and here...

>  struct repack_write_midx_opts {
> @@ -148,6 +149,8 @@ struct repack_write_midx_opts {
>         int show_progress;
>         int write_bitmaps;
>         int midx_must_contain_cruft;
> +       int midx_split_factor;
> +       int midx_new_layer_threshold;
>         enum repack_write_midx_mode mode;
>  };

...and here it is defined.  There is also another new value defined
here (midx_new_layer_threshold) that isn't used anywhere in this patch
yet, but I'll focus on midx_split_factor.

Although, midx_split_factor is defined here, it isn't explicitly
initialized anywhere.  As far as I can tell, it's only initialized
through a designated initializer in builtin/repack.c with
midx_split_factor not appearing as one of the designated fields and
thus getting a value of 0.  That would result in a divide by
zero...although, as you noted in the commit message, this code isn't
yet active.

Still, would it make sense to initialize opts.midx_split_factor in
builtin/repack.c to something non-zero as part of this patch?
