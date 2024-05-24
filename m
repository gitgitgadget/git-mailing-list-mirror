Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B112BF38
	for <git@vger.kernel.org>; Fri, 24 May 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559706; cv=none; b=oWoB6ZsK3z6RNYtcOate/9JbkGDQLL/Bxl5aFGAC4Zs6JssKXlmgsz/TVzeWMmxQRBH3n/lyPVBgmSIlS/85M0Jw/0JO+HCiBK8KTvWy5GpsyTI742fF2LpGmRyxtosePQrDHePLb7qKZwFwFmlrHm4TfHqhYB94P+fWNHZsQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559706; c=relaxed/simple;
	bh=zwNjUrvDzTAbVwStx/pthZ8DdTyyLhFdA46PHFrswUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOs7oJJa5J4Mg5GWzh6wEsfbKIoj6gNBVkzgwQG05soJd3p4PqCu2JRYNo43V5t+18hciV1rZqynVfCp2W64XGgv97aBKuGakgN2bcULmb+/NCkpD444TjUfVbMsVkvB4ftQAEUU8QweLfpPuPyqyejED6r+AJZHAgXiyfAKxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxRPG6Zl; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxRPG6Zl"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57857e0f464so792948a12.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716559702; x=1717164502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrNKplpU3LO2hURXve7LsR/xVttbFZNkq5xDKU6502c=;
        b=ZxRPG6ZlA211JePH1Wf8LXt92+0Ms81B79DbOCgBQSIK/QJwsleGJCSO+35BPbNzCu
         ktFUIIJBJu7nb9/odllnRwm2LwgmuKCXbuxup6I1wJQfUs21Qh5dQqt3RUanz0BC09P6
         OhdfXfZRO9P9H+/bQmc/oZObxvxTMehPBovlbOyW7+/YRAEyqt36QxJIzqvOzhdlQ87c
         sYUA0Qu0+j0aGVznmWGFVD7dixwQpnFKH4nhsztXuGpyuqqOzxp18B9PPDmJF6FnweYz
         jnEbyHHMucau6jBiTjBqOkKy9EWqYnvKeoU4CmUrCWqI3oTI1TIF3TNKZDvxyZherZ4z
         qPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559702; x=1717164502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrNKplpU3LO2hURXve7LsR/xVttbFZNkq5xDKU6502c=;
        b=sNgITxyapCMSvUef+kax8mKG1F77jtfBnkzyZE0lgIhMw+hcK9XQk8jTwSDMf3yxm/
         8qeKdSEphI4CypswqiWdf4l1Nzthzlkq55izqFcT8Q5VFQ6isklcpXQhHvtYt03eal5j
         IPemgLINfduo3OkQKE6yS/AuH+yesOQ9AP21cst/sRbFHMfofmmxgWM5vdz02dZ7R0ev
         COW/lXyY18A9BUVprk5VPQJcntnTtyIizIgBVUomEMsqMPjAddtcSKlCNpur9F23Aluw
         etjSMF3yrvf5VKVuQcjy3gkyWNPhfnJ9QcuxPOmlZOmNxhnX7IXvoqtfLoDqZpRvT+RE
         BtxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHuiDdtKGLEy39eyQb7xq6a20Inpr84iBsPeuW8xLIhyQjLA2XBtl+bwumndOEUgLgO2ATBpb2ToN2ikqC0U1hO5Jw
X-Gm-Message-State: AOJu0YwAPltwYj/EIEnogKdkeLL0t1VGKochhDL/dAYa+ywlxXOmvquq
	FKsfjV2vWABuLlxEUSOjOgGO0WzR0Ix9lY/0E4V6svmEoNp4SZuVncEg3LK3Cc8qGPZ/M80MRvJ
	f9oEmnAIZXoP/jA62QkBoFyf2+mM=
X-Google-Smtp-Source: AGHT+IGi9UIOYA9axoGIKLTthJhrcHEJLtm9VGwEBjnE2Ls1+6yG7G4NJSns0Oy1MmVUjVGpXIy/bZr/nxLuWaHmkpc=
X-Received: by 2002:a17:906:3d72:b0:a62:e4d:8666 with SMTP id
 a640c23a62f3a-a62642ec2f3mr160308566b.28.1716559702165; Fri, 24 May 2024
 07:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229054004.3807-1-ach.lumap@gmail.com> <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240523235945.26833-3-shyamthakkar001@gmail.com> <ZlCWcpcUkgUMWJYz@tanuki>
In-Reply-To: <ZlCWcpcUkgUMWJYz@tanuki>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 May 2024 16:08:09 +0200
Message-ID: <CAP8UFD1=yjZEZWvMYKq1RyY8fMSHze4XcLbCZMSFhCLBheaM+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] t/: port helper/test-sha1.c to unit-tests/t-hash.c
To: Patrick Steinhardt <ps@pks.im>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, ach.lumap@gmail.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, gitster@pobox.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 3:30=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, May 24, 2024 at 05:29:44AM +0530, Ghanshyam Thakkar wrote:
> > t/helper/test-sha1 and t/t0015-hash.sh test the hash implementation of
> > SHA-1 in Git with basic SHA-1 hash values. Migrate them to the new unit
> > testing framework for better debugging and runtime performance.
> >
> > The sha1 subcommand from test-tool is still not removed because it is
> > relied upon by t0013-sha1dc (which requires 'test-tool sha1' dying
> > when it is used on a file created to contain the known sha1 attack)
> > and pack_trailer():lib-pack.sh.
>
> Can we refactor this test to stop doing that? E.g., would it work if we
> used git-hash-object(1) to check that SHA1DC does its thing? Then we
> could get rid of the helper altogether, as far as I understand.

It could perhaps work if we used git-hash-object(1) instead of
`test-tool sha1` in t0013-sha1dc to check that SHA1DC does its thing,
but we could do that in a separate patch or patch series.

> > diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
> > new file mode 100644
> > index 0000000000..89dfea9cc1
> > --- /dev/null
> > +++ b/t/unit-tests/t-hash.c
> > @@ -0,0 +1,54 @@
> > +#include "test-lib.h"
> > +#include "hash-ll.h"
> > +#include "hex.h"
> > +#include "strbuf.h"
> > +
> > +static void check_hash_data(const void *data, size_t data_length,
> > +                         const char *expected, int algo)
> > +{
> > +     git_hash_ctx ctx;
> > +     unsigned char hash[GIT_MAX_HEXSZ];
> > +     const struct git_hash_algo *algop =3D &hash_algos[algo];
> > +
> > +     if (!check(!!data)) {
>
> Is this double negation needed? Can't we just `if (!check(data))`?

As far as I remember it is needed as check() is expecting an 'int'
while 'data' is a 'void *'.

> > +             test_msg("Error: No data provided when expecting: %s", ex=
pected);
>
> This error message is a bit atypical compared to the other callers of
> this function. We could say something like "BUG: test has no data",
> which would match something we have in "t/unit-tests/test-lib.c".

Actually I think something like "BUG: Null data pointer provided"
would be even better.

> > +             return;
> > +     }
> > +
> > +     algop->init_fn(&ctx);
> > +     algop->update_fn(&ctx, data, data_length);
> > +     algop->final_fn(hash, &ctx);
> > +
> > +     check_str(hash_to_hex_algop(hash, algop), expected);
> > +}
> > +
> > +/* Works with a NUL terminated string. Doesn't work if it should conta=
in a NUL character. */
> > +#define TEST_SHA1_STR(data, expected) \
> > +     TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA1)=
, \
> > +          "SHA1 (%s) works", #data)
> > +
> > +/* Only works with a literal string, useful when it contains a NUL cha=
racter. */
> > +#define TEST_SHA1_LITERAL(literal, expected) \
> > +     TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GI=
T_HASH_SHA1), \
> > +          "SHA1 (%s) works", #literal)
> >
>
> This macro also works for `TEST_SHA1_STR()`, right?

No, it uses 'sizeof(literal)' which works only for string literals.

> Is there a
> partiuclar reason why we don't unify them?

The comments above them try to explain that the first one doesn't work
when the data contains a NUL char as it uses strlen() while the second
one works only for string literals including those which contain NUL
characters.

Thanks for your review.
