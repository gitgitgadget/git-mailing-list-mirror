Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F4199947
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222836; cv=none; b=Xju7zp19+DxEtRrxTpBTrgJXTZ2/xvwTPyKdgQYR/7fleQgun6paNp1Umw6qxjnYRew9mc4/nD0JQVGbcW/RJrtN7/LG5l+YCKnThtAA05NIMrAtrayAkARYCGqXZGoM/tO1BYdaEiUlQney8jh28EZRbAOUBDLSAsMdbBb8oxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222836; c=relaxed/simple;
	bh=nfAvw39GWB08DIMPHldpiZtSFBQ9fJDLiun13eU0fX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T22nkoeGXFV3HGp42Buc+jWTTWY84akg71EFGCJHZREyAJY+f3k2IJ5sOW0AV0Br9gYHfgwwRQ8Td9WakkRyxZnd2lyhML6J+jUSsgskXji1PrUkDlcvr3AJkFDWZ2A/+n7WqCCt1+GPzWGo3x5WcIpyyVRQn0Zf/n0NQCr0Pv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NV2WW0cI; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NV2WW0cI"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e30d212b6b1so55050276.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730222833; x=1730827633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ARvFVN00cNhI+ZGzvBMdXB/QELK9CEOL/0qmdx8dbEc=;
        b=NV2WW0cIyRJfdsRnGDwGIyoieq/7x59K636bAuXufY4xmQjasA0W7YMw03nurfX3U3
         fY512CPHY//J6DiK/nsTty1ssbKK9/vaTDw+S9ov2yp5725b1bsjO0aCZw620dCZdHOt
         XegX4gPT3V0zkPwv9NMkjWHR/U25/RfnuS322X0tfmk0TPkqo9uENLzshmLOGptf2kM1
         +49xkzdCxVwBJpyXHeQ/PShE2irfo0Ow7JdGRAxCcL+xamkRSkF1M9Rr8HJVYblk0qr+
         MJpWlXEerfxUPnr2gCCRxITa/glzrA36Lb3VLFxZNruSfkywoOkIBd2Fk/x2ddrZzOuC
         mVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730222833; x=1730827633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARvFVN00cNhI+ZGzvBMdXB/QELK9CEOL/0qmdx8dbEc=;
        b=PMdjz/Ia6C1V5p9S1bJ7Of8YeQ/VNGxm+m5iUom8+43yYZ82rQq11fbYRXgpYagtsA
         7PM96o+Zuke0rI9cxAJGzf1yyWrKIcmFJ590JAZbD9MY3E/11yzldv3n6BwUdBPb64bU
         NvUydYjlBXO6Cl5TtWw9wnsy4SyiPSyQAWMDbOrHVJHZ87OGvlMr31kNaripghZFWWbF
         1hDXXtmjqgbjYdNyKrU/KVbiKsdRTnjesfT9FRtEXezlyLa6XzPEz4bYZMwxJsRvOWys
         8rFmDQOi3Vt0crcxxry7705VmzOzGlOzXbCL3DlDV30mh+e873IXUufB7d/SdmB+ES5/
         UbTg==
X-Gm-Message-State: AOJu0YzOKs6+xTqlBbBPVAtynsfo5oAW9ZDkFH42L6obGzDWk1Avmvmr
	N+rI925Gs3tz0zg00Mb5ZxQKvDjb2mov1Sn7YQgNT3N95m8GwpYeMB+vG/CqIZGCW3uluUPagMV
	yjw8=
X-Google-Smtp-Source: AGHT+IEnYcS4rmZv3Egq5AUHX4yLaFf4bd/XkJ1CTUZfQ5yWfVB5j4agCx9wTEoOXCJXeEzEg5Jjfg==
X-Received: by 2002:a05:6902:2b86:b0:e28:e4bd:13f6 with SMTP id 3f1490d57ef6-e3087b84dc7mr10349996276.33.1730222833051;
        Tue, 29 Oct 2024 10:27:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d54861sm1969316276.3.2024.10.29.10.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:27:12 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:27:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/8] packfile: add repository to struct `packed_git`
Message-ID: <ZyEa61qMRWZTS3Lt@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com>
 <26d2461cc349c14b05d2713ee411bb058251f45f.1730122499.git.karthik.188@gmail.com>
 <Zx+2YRqoIOwE0ysU@nand.local>
 <CAOLa=ZRbQPbuUk+CMk12Sj5VQCqrbDRR9E4S8OA_cCuiZZiWXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRbQPbuUk+CMk12Sj5VQCqrbDRR9E4S8OA_cCuiZZiWXA@mail.gmail.com>

On Tue, Oct 29, 2024 at 07:46:35AM -0400, karthik nayak wrote:
> >> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> >> index 76d5c20f14..ffee7d3abd 100644
> >> --- a/builtin/fast-import.c
> >> +++ b/builtin/fast-import.c
> >> @@ -765,6 +765,7 @@ static void start_packfile(void)
> >>
> >>  	p->pack_fd = pack_fd;
> >>  	p->do_not_close = 1;
> >> +	p->repo = the_repository;
> >
> > Makes sense. Here we are crafting the packfile by hand, so initializing
> > ->repo directly makes sense here.
> >
> > It would be nice if we could rewrite this in terms of
> > packfile.c:alloc_packed_git(), but that is a static function. Exposing
> > it as non-static is probably showing too much of the internals, so I
> > think leaving this as-is makes sense.
>
> Yes, I did consider that too, but dropped it for the same reasons you
> stated.

Makes sense, and yeah, I think that was a reasonable choice here. I
probably would have done the same thing :-).

> > Hmm. Do we need to include all of repository.h here? I don't think we
> > do, because we never peek into any of the fields of that structure from
> > within this header. So I think you could do something like:
> >
> > --- 8< ---
> > diff --git a/object-store-ll.h b/object-store-ll.h
> > index 6f9f4276e6..bcfae2e1bf 100644
> > --- a/object-store-ll.h
> > +++ b/object-store-ll.h
> > @@ -4,13 +4,13 @@
> >  #include "hashmap.h"
> >  #include "object.h"
> >  #include "list.h"
> > -#include "repository.h"
> >  #include "thread-utils.h"
> >  #include "oidset.h"
> >
> >  struct oidmap;
> >  struct oidtree;
> >  struct strbuf;
> > +struct repository;
> >
> >  struct object_directory {
> >  	struct object_directory *next;
> > --- >8 ---
> >
> > instead of #include-ing the whole thing, which would be preferable.
> >
>
> This is much better, I will patch it in.

Great, thanks.

> I agree, by now you know I prefer readability over fewer characters, so
> it more of an intentional choice. But here, I think it can be '*r'
> though, since it is sort of obvious what 'r' refers to in most cases.
>
> I will change this in all commits in the next version.

;-).

> >>  {
> >>  	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
> >>  	memset(p, 0, sizeof(*p));
> >
> > Not at all the fault of this patch, but it feels like a bit of a
> > foot-gun to allocate a bounds-checked version of 'sizeof(*p)+extra',
> > while only zero'ing the first 'sizeof(*p)' bytes. I think in all cases
> > where it actually matters via add_packed_git() we fill out that extra
> > space anyway, but it might be nice cleanup to do something like:
> >
> >     struct packed_git *p;
> >     size_t sz = sizeof(*p) + extra;
> >
> >     p = xcalloc(1, sz);
> >
> > , or something. But that can be dealt with later and/or as #leftoverbits.
> >
>
> Like you stated, there is bunch of refactoring we could do here, I mostly
> don't want to digress and create too much noise, so I will turn a blind
> eye in some cases and leave it for later.

Yeah; to be clear I don't think that we have to address in detail all of
these potential refactorings as a prerequisite to merging this series. I
just wanted to mention them on the list to have some record of having
thought about it, and to avoid the risk that searching for #leftoverbits
returns no results ;-).

Thanks,
Taylor
