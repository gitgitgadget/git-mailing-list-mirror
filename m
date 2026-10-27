Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793121125;
	b=HltlHCysnbjbcdDyO0oOzHJ+TeNgTHvlWZibASVa0AIfQrIR+4gYGXpXpDEjUTfamwXs
	 +seoCnvetFOq4ktE1HFra89H96blAkkfYogQyhl9IZkNfo80ySmrKycog0m1JwF1gsUEu
	 +XtI/YSz2RSoiWK+cSd6SDMYn6sXCbpul+1qO+lqQtHON2r4sQucAZmbwJo4paFGKBvzi
	 0WqkTe167SuNKDO4cvL33FYukPj3Qfu9E63mGweiF9L7pCvIlQ4cosl1EQziT9WrdMhHd
	 72voWpoMqvKAdh/TX6uYNZO3GVSlm9xJ/bRSoL591VIxADaqyvfOp+gomyizAjx0Klg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=s/2+1bVte04RXooxi6fnw+jNZY7KZScvaWxOMklXmt8=;
	b=CXyVEjNZIO3kz/jt13GdHYRS2IqziRGxJnuY0q/J/M623MsKTXqL6eyQLI8wlE8ZtGVw
	 +I82CMxOOwC6ov8LntcVH1AuUKm8JnKcDBEhL/rrWeCVUKNikKqx5LyE3UfEw5F8hMxaG
	 nbS8sM5OQysqdOFuOyW/jZsHilECcOsYalFA90HX33w2vyoAPKnaCcEhwXEcLNRY/hypT
	 IlgJesa7eiziduHKcTqC+Jt1YJ8kGmKPqmPa08Wup7dumsbA2U9Z/xdrOKeSOwO/avx6A
	 XQ0a/BbLdi8pvPaPy1XAYZiKJdduZsgtU+MUEe3pUWNfdSdNcMwiS7OtKNrDujKmrYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uk04Qerk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6851606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6851606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uk04Qerk
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7ccb2ffe333so5965137.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793121123; cv=none;
        d=google.com; s=arc-20260327;
        b=d+Am/Y4E2r02MAl738Am3BHOR0Bwr3+R0rJ6jGFxdc2DdJr37Lx1FCw31ejFNM1+ix
         4ogOq2PehglLk1M4+d92RTJk0d13boPUpEJorCvsjmvDN5HUASiGelD0ZYHM6klBTEQm
         w/4fICkw4TAu2M3m+XbkVG62atJQNT45UIpZ2hZJpKg/FsEuAbmYYsEVqrMeDW6IvY+R
         XG3hXWMqhgXlG9oTfBA1W9CWJpCMvQPBrPsaxuCzRomMF64TXud+CJbbugXdHO01hsGb
         //IT8c8aN1lwsAhtKkEuS+1Ut1YN46n8fnfXGNheuIUDEDcwLGKfL41Y9pIFRhwBZGhz
         XLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s/2+1bVte04RXooxi6fnw+jNZY7KZScvaWxOMklXmt8=;
        fh=XemRgl4bAhzqxNNl5hXvd9NfNTlUp+23/exmNbm2odQ=;
        b=iliOz0Yf1kKE6bJ3l+mYmbm85UTF9ksL6sW3w41zpe8BY8vLyCOMpi089LHPkunlfA
         /fg7+03nCHsDugduwZVLkTxWZ5ga6InBImsQnyYwlaF2eU0+sRx3QSKi5Nw6PCGLQ1i/
         pewnLbkj6m+ZCt8dIcucS8kawjYdvndDSqnP4ZWFK+LE5bzeBVaOp3TwWyW7LjKSpWAv
         bjZnQ+CfrJHpOtWQmsVMdZdd/lTrwhS0mcY1uyRA2AObwXrkIO1QBpbzj5MX9JFmk+Tx
         9GQBco7xe9eiIqM5YMwQsIs7hvFQ2QE0qBmwK8qyKzzT9+Ty0yygH4eIjyhw5sAZKf6r
         cqtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793121123; x=1793725923; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/2+1bVte04RXooxi6fnw+jNZY7KZScvaWxOMklXmt8=;
        b=Uk04Qerk4wVh3phgwpxa8ZYrLtVGXHta1B3KGVFI9Kjxp8dei8v5l/gsr+Hc4HoBXD
         Yrsg9UuFvHQu0rrrk+sT6Hb8ah2UxJdkBVnGMwHcm0Yy8EAgdBpF+3kemkYmfdzcQ3QL
         mWbcsLP8a8TiWoh/3owkAlnedG1w6WPO+RYtq2sUtQVOob3KabY7cnw1y1d3lN5po5L8
         xW/Lfs0aIOaT3vgRSXoA/zMLzyudZER9Sahl6ujDuLPMe2vN2GdelYoH8IFns7j3TGku
         OBG0WoiONYMqLiwaKGe+SVPJsQ1RKrEcWuuVCVtcdWuCXRWB+Nofq5GY8AnDlCn8UXE8
         SM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121123; x=1793725923;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s/2+1bVte04RXooxi6fnw+jNZY7KZScvaWxOMklXmt8=;
        b=pCrtNCr2F5DSD1MgDwH3xw8KFfH4ny9RKLyfGdP/WpDSypkxKrnNdw6WItbgqShwNv
         UpfL1nGaLYDSCynfjnNU/1dZA2AQBNYh/rLT0n017X7muGEkdcDULVRYhXdVpfKCBInN
         s8HMkgQG2DaG33C2yIu05/MShJazZXUuYU0LwTrMPqFfOoDAyKldxUX5BA09kyhytGCH
         WLPr2bVCx24lQaZDyIF7/XV/6IbjL/FWUCI8Sfb9Lom6+WRVWvksa3I2TWpGCxO/G1HI
         JbHpeCCbPiWNr0TEf+FcqX9aVMmb7wFLo3rGoU+pvTOrfBIh6zaXBszxO2zjm646iwFM
         rWMA==
X-Forwarded-Encrypted: i=1; AKwUvBxw5ZITwgWUFIp2s9YS9ic9v/8aZYzmGMwvcgc43bFs7qLOKS4iJ9urDEfCUkeBRvO0YIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWXboXyH5L7PY1HO9huxSyPB4b/djnAnHZFk2+bh/gYQcyqTUG
	BFPLdynGAaH5BnSeUflP/M8dOiUaMoK8/B4cK7W+Ntj36c5KcnOtlipM3aGwdYSzhAqqOc1fBUd
	GI6VpcHWgLinV9PoC8oNKfe7RZTHMrbOdPUxrL7vS0Q==
X-Gm-Gg: AYBFou2VuymQMXtMFX/NvZPKycAvVXOVUuKMXl4Wp2M4jJi9OXKq+Qnjr9uxmIp0PRI
	fRpSoB+TLjwl0uSjzXfF+McitbW7Dw8r4GQVOjHzSoIsxMFyPev8G5l2FJ3TmIlPdPCBn/nN6Il
	6CjqLLdvaAQJ5iZKsDaN8trfr+bAK345Y34jFEDakuI/rji4jRYfn3nq+tij234BS8ZSEXRYPgS
	+pW3MOpit0Z7S064Y9yxiu9vrBkg33X5zLs1tOyNKjgnxJGEsJAjzc5ojCBGvIJl4faJFGG6NNI
	EX8WTzb7JgvLRshd2FIU5u3hFneTpeDrFWmFZDrD88mWCiG7lQz8idCJ1010v3yNe/uKba/rF8j
	GM15TlR7O1mF3YrjSbNOfNxQecA6kJnI2qHGZNCk=
X-Received: by 2002:a05:6102:689b:b0:7a6:b18e:6d24 with SMTP id
 ada2fe7eead31-7ce5cd0ce2fmr3899486137.23.1793121123601; Tue, 27 Oct 2026
 10:12:03 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
 <pull.2266.v3.git.1792833741913.gitgitgadget@gmail.com> <at8RfoXGrC6s3km_@pks.im>
In-Reply-To: <at8RfoXGrC6s3km_@pks.im>
From: Shashank S <shashu8660@gmail.com>
Date: Tue, 27 Oct 2026 22:41:52 +0530
X-Gm-Features: AclHuK_tjz6C9NsV0S38RTof3vDMSBkoKHPXRDlEzNuttPP1cGxocXR6c_5LgYw
Message-ID: <CANHmUQQ+MsNeJa4+SfufwVKB5cofZ1RkuQdHZh1aqpxybSgLTw@mail.gmail.com>
Subject: Re: [PATCH v3] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
To: Patrick Steinhardt <ps@pks.im>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 14:08, Patrick Steinhardt <ps@pks.im> wrote:
> >      +    call to parse_options() will give the short help and exit before the
> >      +    dereference occurs.
>
> This still doesn't quite put the finger on what's important. What you
> need to verify is that there is nothing between the `cmd_foobar()`
> entrypoint and the call to `parse_options()` that may dereference the
> NULL pointer. How abouT this:
>
>     Update the builtins that call this function to pass their local
>     `repo` parameters. As all of those builtins are declared with
>     `RUN_SETUP` we know that they won't execute outside a repository
>     and thus the repository parameter will be set. Unless the command
>     was invoked with "-h" to print help, but all new uses of the `repo`
>     variable are after a call to `parse_options()` which knows to exit
>     early in case it sees "-h".
Thank you i have update this into the v4 patch
>

> > -     if (opts & PRUNE_PACKED_VERBOSE)
> > -             progress = start_delayed_progress(the_repository,
> > -                                               _("Removing duplicate objects"), 256);
> > +    struct prune_data cb_data = {
> > +     .r = r,
> > +     .opts = opts
> > +    };
>
> Indentation is wrong here now, even though it was correct in v2.
Sorry, I have done the correction in v4 patch .
>
> > +    if (opts & PRUNE_PACKED_VERBOSE)
> > +     progress = start_delayed_progress(r,
> > +                       _("Removing duplicate objects"), 256);
> >
> > -     for_each_loose_file_in_source(the_repository->objects->source,
> > -                                   prune_object, NULL, prune_subdir, &opts);
> > +    for_each_loose_file_in_source(r->objects->source,
>
> Likewise, this is using spaces for indentation now.
>
> > +                   prune_object, NULL, prune_subdir, &cb_data);
> >
> > -     /* Ensure we show 100% before finishing progress */
> > -     display_progress(progress, 256);
> > -     stop_progress(&progress);
> > +    /* Ensure we show 100% before finishing progress */
> > +    display_progress(progress, 256);
> > +    stop_progress(&progress);
>
> Same here.
>
> Patrick

Thanks again for taking the time to explain all the mistakes .

Shashank S Mogaveera
