Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359A3BFAE2
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519134; cv=pass; b=lIwFe0AfBrFHtPY2FZvQSPWA3jaG6PjIKtS11lgZEmIUhkFF2yAMRqw48KFUldPQDseQ9LayhopADp3T22NcokcoXRSA1N5eRPSp17fgCZKFi12ko8yHta5E3FhndZaTs+x8eOLxE9P30y83pu0Bq/xoAIGvMm7W7/8fgj0BQcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519134; c=relaxed/simple;
	bh=o7AbM5r05d6zGGcQ9wmdw5YzprF4n9K0gSa0Tyw5EIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGajDZqQ9uhJTEKx2rzpA0nmXi6hWEoGCYJkuEvN84zqJU2TgSnStumT3buCs7U3xq+iA1OJohUNB9wF5wRrGRfSADKTbYiVRonb5Cd99LijsOYqqj/rG+DUtmX4xSWjU5ZyeVzlFQmncSzItg7bTFFR/ReMdEpUic6nuqQFI7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ4LrPXb; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ4LrPXb"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1c9879395so752333a12.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 03:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788519132; cv=none;
        d=google.com; s=arc-20260327;
        b=jnv1MPOh7+85HYBmITjAjAzvN56YeEzw8gIXk86yWAIN+RFIAwiW4vonqHNdCjQbhU
         +qS7mE9H8fi6OAIuc4FojPaQ2fP42YECggYyemik655ablp+5xAhLRSueSyEs67EVSaN
         Wrbk0ki9qSMHJgoHRrdY6OM2g7Bfz4ZdIl9J/WqdCmFHqD8ZjVJcv6RbwNNI2YQRK97W
         ZTKAMOedVqCSQUtOY4Vn8R+3v+G8doBS84ElI6Mw1p7FKohOR6a3CZw7Lgj2plrVjAbd
         IbVsQTMzbGX8RRJWRy8LIp8d7/MRPfTi7mbnCvAhxtqcUXNViPZyQ1X9rFAX14LBuv/K
         5b/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9rjyix+IVuCAxkVw3d8mzfwtf1WpY2d1Te8aiDzECX4=;
        fh=Q6DVfnlQTNM7ojy2bWQ8BjMeFtwIaL7bO4hgxDyn09g=;
        b=pTsu1FVaqmYP4+dW3VMtjnXc0dhMYtXBV6QalAWJ+dt+Xqn1IfdHYQwyNrhqCbJ14/
         BndGOzigtcH6xZPf4MBpGBhPdvXoAeJgCxLdJDHoGSM12F3ftLHl1lGVIYK7xLThvaI/
         TLl2bew13eJazErL2zp3dLR45IPU75WAKx68c6BFXW0INI29qBWHaZUM5zMlTYa3PiPk
         E6GZX8QyWXJosH08UFGRm7Orc12abQ+GGZOxJHFNyEWo1hHDOilUMBpfFFvKT6Eg8dFL
         v4HoFRgKV2748/jQVxYw6/BDpxfv41glOa3z1MJIY0N0BDHhK4lhZ2fIQyQSPtD8uWyp
         dwaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519132; x=1789123932; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rjyix+IVuCAxkVw3d8mzfwtf1WpY2d1Te8aiDzECX4=;
        b=FJ4LrPXbYiQwscrCysDRAzTtTUZd+/c3vgvW0IfAaOrmuRiAiPs2I8oHSVlMj7T5Lg
         3wJkw+mIeLsh4EZrQtmpchQYIMNydkYiRDRNBHuUlDL48DaG8yT1Oz3jaHXWYtq5+Xr1
         iz6teYH1VWCOZUJWJRR5uAvitGOiArpRv9ch2UQanbdc2BXDMTE1A8jKFVAnpiyOM75L
         wq1Y29Tyyml2o7GUdCnatR8JOiO1MRzDxNo8E9YCe9jrLIa5wd7oCsAyBQtx8MT38Nst
         m2oxHnDbOmPWth7WKdYFvVVnK4wT4BwkReI5IpSN1r5ZdCCK7tNvX6hi1nEejAFzjdna
         vhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519132; x=1789123932;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9rjyix+IVuCAxkVw3d8mzfwtf1WpY2d1Te8aiDzECX4=;
        b=oyKmbUQ91ngq2FOdKDEw/DoekTxGxsAOmZJHwXimA3nDeRJCtq22aK1BJ92Ylobfy6
         UiuJOuBpTl53ZrIkJRr842eMVVTXrUeYaL7hvRICAYUe9h3AlgNmvyoHSbUWzbMgJu1S
         q+jzk2oPnRkfZ+Rv7V8fZT4h9+nHAaQVaiQC+0Hs62lo0FmTzXQ/zgjrqpdLtoq8Nxyx
         m5iTbzs5eMe0MbiZV/DwbWfJaMTgnxzZfwoSFMSy9BFQ3RvTm2LOR4CFOz8jzlVQLid7
         Jlwp3ROaX0t0M2r76Wyp6+oEMBEd3Qqjtc2JVsmIlxasO+EMZs8+lqX5HsnM9qvQf1cb
         9sEw==
X-Gm-Message-State: AFuF++mM9xTBDhqkbS0UAnB1zd0Aco6RRKBYvFCEPvZXBR/HVr4Qf4Md
	B6dIg8Drt79lREBZL/ghQVUQMzwbdXxOZse7IVYUNsrPfzq/d4nTY2ZrNBPyNHt8F6WzPhaLOek
	g0YEgbZyWko2lfT+t6HLEmPK1Xzj/ypo=
X-Gm-Gg: AYBFou1L9U8UEbxXw47F6zAurHUgtfTnZ9Qr1rt2V0bh/WIqRYWswvkPqpRSeWbQpHq
	IQRj+wmauGOTefhUpweLQfUi9XieQfWPuJbrCQPvB+1y4Hlou8AwXBU4ubTAxuFLd9/AOVIE50L
	D1L6ZaJju0RyRq3U1HWqcO/wAYBPLuwMhQLZ1/f8HOuI73IWiRlkHcdlXf+1SFVFrILRoAhZYCr
	jUPayPqsVJ3ufU50TUnktK00VwkuWmOSzV/0ahotOLlnEfoJ9nNeV6hZikXAXjHsJ4r/TqAuz+I
	3FU9Mm2l1JrPL8UM+QZoj3BV364JP7UGNMc+dclZdl9gBabvRfIqwA+5XENnhL4JvualeXjlK1U
	PvtgYfmW9hDQCObUE7auFWtakCueO9Kb9
X-Received: by 2002:a05:6a00:2d91:b0:846:8b22:4933 with SMTP id
 d2e1a72fcca58-8616bd5c57amr6992595b3a.17.1788519132169; Fri, 04 Sep 2026
 03:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
 <20260813200830.84348-1-r.siddharth.shrimali@gmail.com> <20260813200830.84348-7-r.siddharth.shrimali@gmail.com>
 <s0vqzjavw8p.fsf@gmail.com>
In-Reply-To: <s0vqzjavw8p.fsf@gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Fri, 4 Sep 2026 16:21:33 +0530
X-Gm-Features: AcwNN1XOcW9dZjCQMoIAF1B263-tCGUix82UUD_Pz6iUen4rVZmhxk51FM0jxI0
Message-ID: <CAGWgyh9B=re06aofii9VFB1xOwEeTtxYE=7T14m9WFAx1ORpMg@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 6/6] builtin/repack: add guards for --drop-filtered
To: Samuel Bronson <naesten@gmail.com>, Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, ttaylorr@openai.com, ps@pks.im, 
	johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

Hi Samuel,
Thanks for the review and your RFC!

I have a few suggestions:

On Fri, 4 Sept 2026 at 03:24, Samuel Bronson <naesten@gmail.com> wrote:
> > +                     for (i = 0; i < istate->cache_nr; i++) {
> > +                             const struct cache_entry *ce = istate->cache[i];
> > +
> > +                             if (oidset_contains(&drop_oids, &ce->oid))
> > +                                     die(_("cannot drop '%s' (%s): it is referenced by the current index"),
> > +                                             ce->name, oid_to_hex(&ce->oid));
>
> The bad news: dying at this time is *not* convenient, especially after
> we've finished that *entire* enumerate_promisor_blobs(), (which is kind
> of slow for a step with no progress output, btw).
>

Thats actually a very good point :)
I agree with this: aborting the whole operation because a single blob
is referenced by the index is a poor trade-off, since it happens only
after the full enumerate_promisor_blobs() walk has already
run.

> While I do want to keep the index blobs, I do *not* want to cancel the
> whole operation over them.

one caveat: oidset_remove() mutates drop_oids in place, and the
--dry-run printer iterates drop_oids afterwards. So with this change,
--dry-run would stop listing the index-referenced blobs, when it should
still report them as candidates it would skip. Instead, we can collect the index
OIDs into a separate 'skip-set' and have both the dry-run output and the
real drop consult that, rather than removing from drop_oids directly.

As a follow-up note, the planned drop-log work will need to account
for this: a blob skipped here was never dropped, so it must not be
recorded there.

> The following seems much more convenient:
>
> -- >8 --
> Subject: [RFC] builtin/repack: just don't --drop-filtered index blobs
>
> Instead of dying when we would drop a blob referenced by the index, just
> ... don't drop it. (Retain the explanatory message as a warning.)
>
> This allows `git repack -a --filter=blob:limit=0 --drop-filtered` to
> work in non-bare repositories that have non-trivial files around.
>
> Not done:
>
>   - Fixing the tests to match
>
>   - Allowing `--filter=blob:none`

Thanks,
Siddharth Shrimali
