Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D185204C1B
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375451; cv=none; b=l5ojSwEFMFZV4iENe8JzqobR4fMSk4JLmNTqe3gEQujnd0WaC7hH/QLjifKgtYcMwRU9/+RMEKOiPictvFuKShcCFvqfcDYLqVNA+Sg5ZduXiJwdHs51C7yguXar9e3K/OZ+D51sY2lqSMx5anJ8dRiGFpygi7YBejgcQuEb2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375451; c=relaxed/simple;
	bh=oMGEyderOL/cx1gZdAl7J2hojbPRqLoy55p56QHQtoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPZihi29VbVMOB9wLFIpvxhAdjAg+1Wa3EH89vACZT8cA8DMvPa5nc0raO+C8TezPAhwLtWKhy2VB5a6GX5PZPPIOv9XMbrXz4iSp6g8RIsny0dcOgS7BBSB7QxqObNGu9LYwFpo9WNObruCejAvUelK07fCbbFMcL2Y6k7xlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYPTW4oD; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYPTW4oD"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f2da12248fso658094eaf.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736375449; x=1736980249; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HvQ1tgg8qn4/VnmDsFFkk69akwFhsrHq3GDzecEO7fo=;
        b=RYPTW4oD4fHYZWbFJdH4SuPd6hm75zL16NNs0DtGiNrdkJMr3chnbI4iR2GVW98nNM
         xdPkYdQQhNFv+N3UFyiwbhiRXuSSaPZ357NvsBADf5H6PrEmvezLZUz1KyrROhFSWSoX
         MAYoElDe4tIoXlV1YJ0gFswifV4JvD9qwefBFG0CKgIUShMaFoTfs2MooFk68GdbHPxu
         lfPiQTRy0veUCVnn9WKz9m9Z308zwQCFHOf3dbXH2NBeRyoNDc9CJY5+awt9wOPH9+Cl
         TtJ5A5IzAT+h7V4livOrksG62c+ROsP77DAuihLFMsh4dn81/WtV13VXRiUsSL/KhrYM
         B57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736375449; x=1736980249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvQ1tgg8qn4/VnmDsFFkk69akwFhsrHq3GDzecEO7fo=;
        b=wxdEjd1rR9WWFKUci5jdV+XfFLNy6uOPs6Yc2aP2tfJPeepbpVp/cfNv1CCKURBmmC
         UJCqyknf1nBdFpGXlunb15clrtRf8EsRg2rM8or4OxF7iQK63XVLbph9PSu+s6Q14IoM
         MrERTFRGGk4eGIqcw9dMR+8wUQr8gcb4qVtOGx/ltqsryP5oQSydoWd2KGpchAvPcR4k
         AgM3HLiOO3a+lBqlmEgTjdvmVFciqAXWJG1Vf1+2NBAUwGrYXU9D/ra7BoqHKYGqdozX
         P23qVlhZKf3KPfNqxdWp9sYYrb3OJVfEk7DumIjYhGcZjfqb0Fl1olh3jvyDWXszWe1H
         RvQA==
X-Gm-Message-State: AOJu0Yz7EWp4FsFo24CzP1Hds2P9WdaRiEKAm6ZF/OPCtAce0Bo0t35F
	3f9nTWSjg8gw6Dac4SJaTe6wC5chseESakFUY0+/wSFuqFxWxnRF
X-Gm-Gg: ASbGncsgb9uqCGT0VaWfIMOWpvnizVGx4vzER/yY7FkAU8cw+AK0CQ0dqlkTR7yiLgy
	8yHSMwWG9RkEsOm6LSXWmCzV+gXsa1JbBjRitJPGWJ3qY9yPzPMD5uchM0zVtwPBdzHHdyDNLAp
	IaPkk1QrFbzq3NKamux1LXY9kX9eix1d+DhLu1j2v8V8g1Wpqds+aqrhOcJl14bTkkABs2vpCH4
	Cp3rb+NhznS1bzWBpFzuaXxhMHcpRVfxIQSSHbzgzu7RY85vA==
X-Google-Smtp-Source: AGHT+IHt46LjO5HtvOghEnX9NyidfuPxMLwDepu1+ZtNPg39vRG2+Uw/FBTf8xzl4IKIypNVj0EOhg==
X-Received: by 2002:a05:6871:3a97:b0:297:554:c660 with SMTP id 586e51a60fabf-2aae5a9e5camr634025fac.9.1736375448974;
        Wed, 08 Jan 2025 14:30:48 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74bb9fcsm13601318fac.12.2025.01.08.14.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:30:48 -0800 (PST)
Date: Wed, 8 Jan 2025 16:28:14 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH] rev-list: print missing object type with
 --missing=print-type
Message-ID: <u5bchsjfjnr2wm2vfxgtugesh5t26oxe7weajqopemlrfmaaio@wispfrii67gb>
References: <20250108034012.211043-1-jltobler@gmail.com>
 <CAP8UFD1Q0C22TH7V7K9QZAJmLFDp+DPus1uB1O0oiAvJnWQgig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1Q0C22TH7V7K9QZAJmLFDp+DPus1uB1O0oiAvJnWQgig@mail.gmail.com>

On 25/01/08 11:08AM, Christian Couder wrote:
> On Wed, Jan 8, 2025 at 4:43 AM Justin Tobler <jltobler@gmail.com> wrote:
> >
> > Handling of missing objects encounted by git-rev-list(1) can be
> > configured with the `--missing=<action>` option and specifying the
> > desired action. Of the available missing actions, none provide a way to
> > print additional information about the missing object such as its type.
> 
> What kind of additional information could we also print except for the type?

In [1], Junio suggested path information as another option.

> 
> > Add a new missing action called `print-type`. Similar to `print`, this
> > action prints a list of missing objects but also includes the object
> > type if available in the form: `?<oid> [type]`.
> >
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> > Instead of adding an additional missing action type for the explicit
> > purpose of printing type info, I also considered a separate option
> > (something like `--object-types`, or maybe a `--missing-format`) that
> > could be used in combination with the `--missing=print` option to
> > achieve the same result. The main intent is for the missing object type
> > and I wasn't sure if type info would be useful in the general case so I
> > opted to choose the former approach.
> 
> If there are many other kinds of information we could also print, then
> maybe a `--missing-format=<format>` option would make more sense
> rather than adding `print-X`, `print-Y`, `print-X-Y`, etc. Otherwise,
> yeah, I would say that `print-type` makes sense.

Since there is some other information that we may also want to print, I
think it makes sense to follow a more generic approach now. I'm
currently thinking could continue to use `--missing=print`, but add a
`--missing-attr` option to specify additional information we want to
print. Something like:

  $ git rev-list --objects --missing=print \
  --missing-attr=type --missing-attr=type

> > @@ -103,6 +109,8 @@ static off_t get_object_disk_usage(struct object *obj)
> >
> >  static inline void finish_object__ma(struct object *obj)
> >  {
> > +       struct missing_objects_map_entry *entry, *old;
> > +
> >         /*
> >          * Whether or not we try to dynamically fetch missing objects
> >          * from the server, we currently DO NOT have the object.  We
> > @@ -119,7 +127,12 @@ static inline void finish_object__ma(struct object *obj)
> >                 return;
> >
> >         case MA_PRINT:
> > -               oidset_insert(&missing_objects, &obj->oid);
> > +       case MA_PRINT_TYPE:
> > +               CALLOC_ARRAY(entry, 1);
> > +               entry->entry.oid = obj->oid;
> > +               entry->type = obj->type;
> > +               old = oidmap_put(&missing_objects, entry);
> > +               free(old);
> >                 return;
> 
> Maybe a function like:
> 
> static void add_missing_object_entry(struct object_id *oid, unsigned int type)
> {
>     struct missing_objects_map_entry *entry, *old;
> 
>     CALLOC_ARRAY(entry, 1);
>     entry->entry.oid = *oid;
>     entry->type = type;
>     old = oidmap_put(&missing_objects, entry);
>     free(old);
> }
> 
> and then:
> 
>     case MA_PRINT:
>     case MA_PRINT_TYPE:
>         add_missing_object_entry(&obj->oid, obj->type);
>         return;
> 
> could help keep finish_object__ma() (which is inlined) short and also
> avoid some code duplication in the code below.

Good idea, I'll factor this out in the next version.

> 
> >         case MA_ALLOW_PROMISOR:
> > @@ -414,6 +427,12 @@ static inline int parse_missing_action_value(const char *value)
> >                 return 1;
> >         }
> >
> > +       if (!strcmp(value, "print-type")) {
> > +               arg_missing_action = MA_PRINT_TYPE;
> > +               fetch_if_missing = 0;
> > +               return 1;
> > +       }
> > +
> >         if (!strcmp(value, "allow-promisor")) {
> >                 arg_missing_action = MA_ALLOW_PROMISOR;
> >                 fetch_if_missing = 0;
> > @@ -781,10 +800,26 @@ int cmd_rev_list(int argc,
> >
> >         if (arg_print_omitted)
> >                 oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
> > -       if (arg_missing_action == MA_PRINT) {
> > -               oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
> > -               /* Add missing tips */
> > -               oidset_insert_from_set(&missing_objects, &revs.missing_commits);
> > +       if (arg_missing_action == MA_PRINT ||
> > +           arg_missing_action == MA_PRINT_TYPE) {
> > +               struct oidset_iter iter;
> > +               struct object_id *oid;
> > +
> > +               oidmap_init(&missing_objects, DEFAULT_OIDSET_SIZE);
> > +               oidset_iter_init(&revs.missing_commits, &iter);
> > +
> > +               /*
> > +                * Revisions pointing to missing objects lack the context
> > +                * required to determine object type.
> > +                */
> > +               while ((oid = oidset_iter_next(&iter))) {
> > +                       struct missing_objects_map_entry *entry;
> > +
> > +                       CALLOC_ARRAY(entry, 1);
> > +                       oidcpy(&entry->entry.oid, oid);
> > +                       oidmap_put(&missing_objects, entry);
> > +               }
> 
> Using the function suggested above this could be:
> 
>         /*
>          * Revisions pointing to missing objects lack the context
>          * required to determine object type.
>          */
>         while ((oid = oidset_iter_next(&iter)))
>             add_missing_object_entry(oid, 0);
> 
> > +
> >                 oidset_clear(&revs.missing_commits);
> >         }
> >
> > @@ -801,12 +836,27 @@ int cmd_rev_list(int argc,
> >                 oidset_clear(&omitted_objects);
> >         }
> >         if (arg_missing_action == MA_PRINT) {
> > -               struct oidset_iter iter;
> > -               struct object_id *oid;
> > -               oidset_iter_init(&missing_objects, &iter);
> > -               while ((oid = oidset_iter_next(&iter)))
> > -                       printf("?%s\n", oid_to_hex(oid));
> > -               oidset_clear(&missing_objects);
> > +               struct missing_objects_map_entry *entry;
> > +               struct oidmap_iter iter;
> > +
> > +               oidmap_iter_init(&missing_objects, &iter);
> > +
> > +               while ((entry = oidmap_iter_next(&iter)))
> > +                       printf("?%s\n", oid_to_hex(&entry->entry.oid));
> > +
> > +               oidmap_free(&missing_objects, true);
> > +       }
> > +       if (arg_missing_action == MA_PRINT_TYPE) {
> > +               struct missing_objects_map_entry *entry;
> > +               struct oidmap_iter iter;
> > +
> > +               oidmap_iter_init(&missing_objects, &iter);
> > +
> > +               while ((entry = oidmap_iter_next(&iter)))
> > +                       printf("?%s %s\n", oid_to_hex(&entry->entry.oid),
> > +                              entry->type ? type_name(entry->type) : "");
> > +
> > +               oidmap_free(&missing_objects, true);
> >         }
> 
> Maybe a function like:
> 
> static void print_missing_objects(unsigned int with_type)
> {
>     struct missing_objects_map_entry *entry;
>     struct oidmap_iter iter;
> 
>     oidmap_iter_init(&missing_objects, &iter);
> 
>     while ((entry = oidmap_iter_next(&iter)))
>         if (with_type && entry->type)
>             printf("?%s %s\n", oid_to_hex(&entry->entry.oid),
>                    type_name(entry->type));
>         else
>             printf("?%s\n", oid_to_hex(&entry->entry.oid));
> 
>     oidmap_free(&missing_objects, true);
> }
> 
> could avoid some code duplication. It could also make the output a bit
> cleaner as when there is no type, there would be no space after the
> oid in the output.

I agree with this suggestion and will also factor this out in the next
version. Thanks!

-Justin
