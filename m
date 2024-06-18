Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2DD299
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725690; cv=none; b=MZhYXsj+A9ZDEp/d3ksc99baISVUmi+yULHacPiG86lXjxbbZnrW7LIFbBrM/qKeemLvu7NGAqtfnLauOfNX+tb0rGP7NzHtATL+mgr7Im1IoYVbgTJgOjtwFulwB0lDLeM106L/Rw5Q/Jd0eL3XVMbP5QodMfNf4wzVUOKj9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725690; c=relaxed/simple;
	bh=osoNdpZNrYXP6s/HtUAjO40DM0u5KPV7HuQ4LNbiUMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVEeAj812/cmUGsm+05HSXNiVHs+cx9Vgvc8dQq64BmeXe5fP+5LZ88okSRR00QVwbfEBkL+XzvEy9rtUaQToxT4L3uAXdli5ni3i4MS/1tq1L5ncaAEaUSZjB5rggNVxN9HGzyxWj2MccyCJgXcJc4fYjchUySu42Llej7asAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY95iweV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY95iweV"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c508ea0cc5so2154420a91.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718725689; x=1719330489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QgvM7jUmvTE8MF+c8QeyXzpjrTk/XLE4urAoR/beGkM=;
        b=QY95iweVubnA4R46Kg7B6TynyyLPBfs2KcXxTqraUCxnTsHD9R/YZ9/YAb+wiVKm8H
         hnNi2k8RTdl5iOF0Wreaq+H3xrSPXwXs6UBQ8wpF/huQEJh0pq1IdLo8u7PRMLl8NQ/y
         uU2E3tlx2qyEVjCD4noDe7x6cLGkBZkONRaGTmZq1kiVBbqFl1GEKo93di71gHj3musx
         iuPOhbIQhzwVW2NyXxJQJPOsexTroLg/NeASdHBOmn1rshqnK0lUOZRAnJQ6c/afrDQr
         7xSkREAsgbWzZEEszrOsHwsPwbdGS3jqmoSrXSjTDdomPNiGCY6qcrjSJQUaXcihoLR6
         bZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725689; x=1719330489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgvM7jUmvTE8MF+c8QeyXzpjrTk/XLE4urAoR/beGkM=;
        b=YZd+uVuS628WApDnILg/+yRwR0H9+hkhP/2+03zg2Dl7u1qJQWbpfNSYAcq2HcJ7Lb
         SEJAewSZIkT/IzsBytfOCKDhZEjoqtVYQhAGzmiK0DdarRDqXRmObe7pkPnlk9o+Psxp
         hMYMx/t/MeeXFjsyOwDffb20n3YWc9ccWzDJmhfXycksrtNEXERYyKry4Yx9N/ZuJmrd
         L1E8u+j2sbeKRmIUFMcTzSWbBujYo6BDDsvZBssUW4odpbwzCp7+2lIaavv01llLqeLT
         u/UH5PgijTNVMbyhSlOHNrqWD00p3Ik5/acQ5vlo9HCrQtYB4h++09Vk9sJtvrXbYSMr
         GWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+yiyPF2g5unTYLd2Sbk5k9V8d0pGmlkS6zV59YQYSGuzv6D0/SiM9KMYyYVvb+gCmR5DntkD8/Eg7FTR6sgsiAt4K
X-Gm-Message-State: AOJu0YzTY/mx8PopEMJ2bMIdPO672lueqH/5BAzneH9AOdBGDGCDPF6P
	CbakXoiW1UmP4ArUhDTIdjJz5mY17Yt9q5nBhHJ5V0GvzzyTaC5y/+sc01/oUYMvtRWUglPX6j6
	ZnFPCDWVmhUOLasLbQk1ejBhUbyY=
X-Google-Smtp-Source: AGHT+IFF0wyEcdVwmP85qxVQPpaXmnrs8i9eyUTIFXyXKfRwr5wUUrOYF9duTiOkXcp+MUa6YKitH/g+GqGXK/c7qdE=
X-Received: by 2002:a17:90b:8c4:b0:2c5:2da3:7e1b with SMTP id
 98e67ed59e1d1-2c7b5af2b6emr96260a91.1.1718725688703; Tue, 18 Jun 2024
 08:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnFCEYypdAyXMMlg@ArchLinux> <CAOLa=ZS57EsZk+7xOW9imbA4oWANKf0b+HxBZ8hGFaQQkCsvcQ@mail.gmail.com>
 <ZnFJTdHQcHVagflt@ArchLinux> <xmqqfrta2ryp.fsf@gitster.g>
In-Reply-To: <xmqqfrta2ryp.fsf@gitster.g>
From: jialuo she <shejialuo@gmail.com>
Date: Tue, 18 Jun 2024 23:47:55 +0800
Message-ID: <CAH-kW5cxQQFpr30FV9uB3HcyuSgoCYRs8UxiStd9v5P1cXjK7w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 1/7] fsck: add refs check interfaces to interface
 with fsck error levels
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
>
> shejialuo <shejialuo@gmail.com> writes:
>
> > On Tue, Jun 18, 2024 at 04:38:07AM -0400, Karthik Nayak wrote:
> >> shejialuo <shejialuo@gmail.com> writes:
> >>
> >> [snip]
> >>
> >> >  struct fsck_options {
> >> > +  /*
> >> > +   * Reorder the fields to allow `fsck_ref_options` to use
> >> > +   * the interfaces using `struct fsck_options`.
> >> > +   */
> >>
> >> Why is this added? It makes sense to have it in the commit message
> >> because it talks about the change, but why make it persistent in the
> >> code?
> >>
> >
> > I explicitly add this comments due to the following reasons:
> >
> > 1. If someone needs to change the `fsck_options`, without this comment,
> > he might be just add some new fields at top. Although the change will
> > fail the tests here, I think we should mention this in code.
>
> Do you mean you plan to take advantage of the fact that early
> members of two structures are the same?  IOW, if there is a function
> that takes a pointer to smaller fsck_refs_options, you plan to pass
> a pointer to fsck_options from some callers, e.g.
>
>     extern void func(struct fsck_refs_options *);
>     void a_caller(struct fsck_options *o)
>     {
>         func((struct fsck_options *)o);
>         ...
>

I do not want to convert "struct fsck_options*" to "struct fsck_refs_options*".
Instead, I want to convert "struct fsck_refs_options*" to "struct fsck_options*"
to reuse the functions which use the "struct fsck_options*" parameter.

Like the commit message said:

  Move the "msg_type" and "strict" member to the top of the "fsck_options"
  which allows us to convert "fsck_refs_options *" to "fsck_options *" to
  reuse the interfaces provided by "fsck.h" without changing the original
  code.

It may seem we should add some fields into `fsck_options`, but I don't think
it's a good idea. I will elaborate my design here:

The git-fsck(1) is highly relevant with the object database. I don't want to add
some new fields into "fsck_options" due to the following reason:

The fields in fsck_options are all related to objects except "fsck_msg_type"
and "strict". Adding some ref-related fields into "fsck_options" will break the
semantics.

Actually, it may be perfect that I may abstract some interfaces here, however,
it would be too complicated for this patch, many functions use "fsck_options *"
as the parameter. I think we may do this later.
