Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818F946F
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841242; cv=none; b=jQthVi18WzuPHElbXm7dhLqFZGt3G5pX+ONeR7Ee2fFZJpvlMl58iqtOnA11TPXS539EyQ7HU9Uc0tZHVG63X/QSG3uMLRUGUmedi4YrF+480UOffOYc+rGFzxbJF/Fs4TRaartCJEuOBeViPa7a1vCvAUMb/8ixzULU4MFi7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841242; c=relaxed/simple;
	bh=6pLUsVjUjXxfOHV4V/tVSQJy6suAwbhh25MZOEo3N2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKwZYYi8Jrt0Lyo4MNTEap6KcYWHRsULfQAinyZkjs71uxEUy5kVADEwmTOGjTGbqW0OIJMVPHaJz2oa9ptTGWsf4u5iADAvixalUcYb9tCzUqaNnT5eOUEJcwAyDisKP0vHdHaeYHQLLTaKwafWFb4A2MqZG5BwaSYFGD2WvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0irxNdem; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0irxNdem"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c560c55bc1so9233585a.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744841237; x=1745446037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJTlx5Un3oqJhXs9oBIvbFiElkGQDQyWYukH3OTQ/g8=;
        b=0irxNdemn0ZP1re82wEorGGDnjHI1665Vb33utXH4qww5M/JpK3HG6EtibZZEHiUWX
         WkDiRGlPWAXMT7ezDq5lWK4FO3L6XJfdnzznAnWuTPZjASSX/s1LZfDDH8tBPjl532Yn
         BRE7Arle5HJppvxPrZMuwSrW/UBZ0U0oCKZImsof692UsErVztDuv2vfIa3W/u33e9aW
         izPbOoQ38eVQGx6tzm0K59i0M30Y+BZ1YdJIl7LgUXa08emwjP4sOriuWkGhbZWcGkcu
         kz7ItqunnEgQwEe2wgqhAtwXvq+rMFx2dKPACKQrPPcm/ExlzcGKccLd3mwuI9AogBuT
         3V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841237; x=1745446037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJTlx5Un3oqJhXs9oBIvbFiElkGQDQyWYukH3OTQ/g8=;
        b=Mc40VsK9+TRl3zZUfaNPA9N/G7ysXUkILxuoa1kUSyTog9/K6W4TZ6AJrlM7jo55G/
         2Q3bVDpDqR4jQFuGtoaNkzq2BmHwDZCyac6CvBM+cepJxE9GistZe9Onq7iv3QK5LxPM
         iwGiQdyEdCBwEc5YknwqFSWI997zGgwUcV1zYAg2kR6pkEw4DvJJs/lj7Ied2NsMaxe0
         73ow59Ip5WjdV/z5yn2aXGlst4mU+ApTz5uMo3YcQmBKUN75wYpBgP4Yi1QQuQBD3P1q
         QUW/Xz8qPc6OFkej61ZJbPXqQosKGuL05twoHeyk+rYJyEg8zelJ0upftD578OtyrkhP
         K65g==
X-Gm-Message-State: AOJu0YwimygPi9wyU8ygztiEFUpopYd7b7VmJbEAYn1RmNRyMurxgA89
	5XhPqcLLH3RqUersmW6pDs1DDcIGoEWsXYvvQQscYRhRUdylYSdeYwaqOkJW0O0=
X-Gm-Gg: ASbGncvKVfga0o2HuoS7VSeVop0Px/0PZfpZeRROwprGOAyzwBvfBYICYh1RcuKrgOB
	JrHc8hdZppsUGiojRlObrrWFfNym708W7Sy3avZc+KwSpdWejlv6nydnTXKGYURyAPeVjfuFaOv
	gj2TIIYU07psVAzV2Dhx2Zl6Joi2MYOYZb2QawK5aOORo9XNcPwTOf+yc0zVuQb74Le0vo6jGFu
	fnWwetKSunmYXZRmQceWtYwdHUCanSXhV09vhqZ6BTBy3LAn+DfhKFwggtSJgsyPydk9fEKfgYJ
	dmfBxOHGbqWaJIEWBIzq4kG6EU1uhitrsZpLf7Z/4xY8vcyBSbZOILR2NLKSyB/T8lgf28OMEHY
	JaWEAwHzlqVsrDwssOeD10Z8=
X-Google-Smtp-Source: AGHT+IEISTrzAs1ge2MaGtxwb8R9hgJhSpYdHioNyffApr4oDhWpEC76mtw0A9n/yp5afNuf7D4zgw==
X-Received: by 2002:a05:620a:4045:b0:7c8:c97:627f with SMTP id af79cd13be357-7c91906167fmr532461085a.46.1744841237091;
        Wed, 16 Apr 2025 15:07:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a896a6fbsm1102856585a.55.2025.04.16.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:07:16 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:07:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/9] pack-objects: limit scope in
 'add_object_entry_from_pack()'
Message-ID: <aAAqE2NK3eQ8c6r1@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
 <986bef29b5f33d32fd366aa9370d439175a9b605.1744757204.git.me@ttaylorr.com>
 <xmqqtt6okjm8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtt6okjm8.fsf@gitster.g>

On Tue, Apr 15, 2025 at 05:58:23PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In add_object_entry_from_pack() we declare 'revs' (given to us through
> > the miscellaneous context argument) earlier in the "if (p)" conditional
> > than is necessary.  Move it down as far as it can go to reduce its
> > scope.
>
> That makes sense, but ...
>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  builtin/pack-objects.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 20dd870bbf..4ab695a3aa 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -3490,14 +3490,14 @@ static int add_object_entry_from_pack(const struct object_id *oid,
> >  		return 0;
> >
> >  	if (p) {
> > -		struct rev_info *revs = _data;
> >  		struct object_info oi = OBJECT_INFO_INIT;
> > -
> >  		oi.typep = &type;
> > +
>
> Isn't this change about spacing around oi's decl and the first
> statement in the block strictly worsening the code?  At least it is
> an unrelated change.

Yeah, this is cruft that I thought I had expunged while rebasing. Here's
a better version of the patch, but I'm happy to send a new round of the
series if it would be more convenient for you:

--- 8< ---

Subject: [PATCH] pack-objects: limit scope in 'add_object_entry_from_pack()'

In add_object_entry_from_pack() we declare 'revs' (given to us through
the miscellaneous context argument) earlier in the "if (p)" conditional
than is necessary.  Move it down as far as it can go to reduce its
scope.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 20dd870bbf..682e80be40 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3490,7 +3490,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;

 	if (p) {
-		struct rev_info *revs = _data;
 		struct object_info oi = OBJECT_INFO_INIT;

 		oi.typep = &type;
@@ -3498,6 +3497,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
+			struct rev_info *revs = _data;
 			/*
 			 * commits in included packs are used as starting points for the
 			 * subsequent revision walk
--
2.49.0.230.ga662d77f78

Thanks,
Taylor
