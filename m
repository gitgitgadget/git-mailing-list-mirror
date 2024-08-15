Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090B52F70
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747037; cv=none; b=ORB527XfO4hOqEz/QaQZcdLmOc//lSJo174wjmwb7czstGq/R3rz9Cb3sWUbtxqNS1xS/u0c7Hx2Fk3Uaqve5L8B0t8aoRqsbgfVJ39jh96TeTJVTy2NdEgXcgKwVqtF0BNJ2UO+DH2e9iyH9Kc/PZI+Kz8xuqHBmpSxNTeC0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747037; c=relaxed/simple;
	bh=v985rrtMHEvQ+yQ9guOsR3O3c7Z7oyk0T5n2d2pwE18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdFHpjyna+azzQspiTGvdn403gPjMyQD63utmycOnkY3Yqpg0W4w8INQG5uteq3V0zmofZHeSGcvraAglhkGqxR2tc5J8XYoRAOCG+nSw1tulPBYKkJQJkmuMzNw0kyIjv3CUyYqPiBWb1tQNjuD+D3iLdQCcKHwizwumCAZRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je9LF7up; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je9LF7up"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8374e6a6fbso163358766b.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723747034; x=1724351834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3v4s2cEnHx2CRKITDw8x/4JKFdizdHS/QVcDwLIFsM=;
        b=Je9LF7upS2KMAuqbMjmg0RIY/5hEid57Te3lzMjKBiRoFADBwCZof8OalENxv9T0Um
         LzZ25F770bFvE41Mu3cw9qRBH0p4rg6gxVm9jsVIP93zt+4kIqObTw51ddW/ziNCBwli
         kCRgmY4FkKz5qc1R15cj/102tjUz5vtGCn6iG4R/6RmbRe8X0q1xkzxnsDqszLj3UJXC
         FEu7ImVNdOtIqm2nYTfk9N6P6Jae9P9vsmrkmyrxEcQ+oXfuDsbKzjt6VCYsBOqCci9+
         D478V3gc/oAktC+Ytuqcl6E4QFDS+aFBc54knR9ZIgthG4DP0r2SlZz2/rFzlnpMGDv+
         t3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747034; x=1724351834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3v4s2cEnHx2CRKITDw8x/4JKFdizdHS/QVcDwLIFsM=;
        b=NBuD0usYNHnZ0e6mWoJNRCy466+NOZOSwXQ+7ih5xpedt36I5fxAcjESRjg5YEcVJs
         /Il/QngsKK0q1Nz83loSp1wUHR4SgLaBu63fpy7PBC9rzwK4e4ukZopsB9UmWiQFENym
         crSetd2FA+S0s7ADZetndJ1NddkUs8DBtqNENhFnQAuELQD5d2SmKybFDFMJ/TU1Yl8P
         6gZzw98dBwL+Fw3xpGkYmt2mEqnhl2sQVWK0yozF5HJJD5wgokh7pCNDzAxMJN/QY9nr
         ZEc6UrwcshkTaJgqaSlbdlBK74EypqCzdTk2MI7GZJcx4mnJk/csKgzCEbd3YOQtwnNS
         dtqg==
X-Gm-Message-State: AOJu0Yza6q4lyPhZrTlKBtHQ7QfApHWFKIQcK8GFqEdYgo1rHKvVEvJs
	fEtfutK4qGkmPmPotJoz27tzwU3rt5nMWa58zS2Sd5Mt0yZkGHN0jIZXfIr/jyyefQM38RT6Wco
	wTV9zJ4xuizUB4fv+OyhX13xEMiE=
X-Google-Smtp-Source: AGHT+IFwitVkVBcJfhg1A4N4qDmkBU65Ep8KKvxwCH5QdZxgsFGP4d6uTb3tj5v9rjajBmlSfkYMHDGAR/VxbyCbNCs=
X-Received: by 2002:a17:907:e28a:b0:a7a:c256:3ce with SMTP id
 a640c23a62f3a-a839292f6dcmr34033466b.21.1723747033863; Thu, 15 Aug 2024
 11:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-9-chandrapratap3519@gmail.com> <Zr3NMOQWYDOufHXg@tanuki>
In-Reply-To: <Zr3NMOQWYDOufHXg@tanuki>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Fri, 16 Aug 2024 00:06:47 +0530
Message-ID: <CA+J6zkSOF-RtrBvgunMsTdL4Qd8H10zUHesXYtYG8DW+kJht-w@mail.gmail.com>
Subject: Re: [PATCH 08/10] t-reftable-block: add tests for log blocks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 15:11, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Aug 14, 2024 at 05:33:16PM +0530, Chandra Pratap wrote:
> > @@ -101,9 +101,95 @@ static void t_block_read_write(void)
> >               reftable_record_release(&recs[i]);
> >  }
> >
> > +static void t_log_block_read_write(void)
> > +{
> > +     const int header_off = 21;
> > +     struct reftable_record recs[30];
> > +     const size_t N = ARRAY_SIZE(recs);
> > +     const size_t block_size = 2048;
> > +     struct reftable_block block = { 0 };
> > +     struct block_writer bw = {
> > +             .last_key = STRBUF_INIT,
> > +     };
> > +     struct reftable_record rec = {
> > +             .type = BLOCK_TYPE_LOG,
> > +     };
> > +     size_t i = 0;
> > +     int n;
> > +     struct block_reader br = { 0 };
> > +     struct block_iter it = BLOCK_ITER_INIT;
> > +     struct strbuf want = STRBUF_INIT;
> > +
> > +     REFTABLE_CALLOC_ARRAY(block.data, block_size);
> > +     block.len = block_size;
> > +     block.source = malloc_block_source();
> > +     block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
> > +                       header_off, hash_size(GIT_SHA1_FORMAT_ID));
> > +
> > +     for (i = 0; i < N; i++) {
> > +             rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
> > +             rec.u.log.update_index = i;
> > +             rec.u.log.value_type = REFTABLE_LOG_UPDATE;
> > +
> > +             recs[i] = rec;
> > +             n = block_writer_add(&bw, &rec);
> > +             rec.u.log.refname = NULL;
> > +             rec.u.log.value_type = REFTABLE_LOG_DELETION;
> > +             check_int(n, ==, 0);
> > +     }
> > +
> > +     n = block_writer_finish(&bw);
> > +     check_int(n, >, 0);
>
> Do we maybe want to rename `n` to `ret`? That's way more customary in
> our codebase.

Sure thing, but then I would want to change the existing test (which gets
renamed as t_ref_block_read_write) and I'm unsure of which patch would
be the most suitable for that change. Would it be fine to include that
change as a part of this patch?

> > +     block_writer_release(&bw);
> > +
> > +     block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
> > +
> > +     block_iter_seek_start(&it, &br);
> > +
> > +     for (i = 0; ; i++) {
> > +             int r = block_iter_next(&it, &rec);
> > +             check_int(r, >=, 0);
> > +             if (r > 0)
> > +                     break;
>
> We can also reuse `n` (or `ret`) here, right?
>
> > +             check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
> > +     }
>
> One thing that this loop doesn't verify is whether we actually got the
> expected number of log records. It could be that the first iteration
> already returns `r > 0`, which is not our expectation. So we should
> likely add a check for `i == N` after the loop.

What about something like
if (r > 0) {
    check_int(i, ==, N);
    break;
}
That should achieve the same results if I'm not wrong.
