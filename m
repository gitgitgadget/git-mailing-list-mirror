Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC433E7
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871812; cv=none; b=E5B6r8J5WTZ7sy29iwea0aFJpIgQwPd0WisMPdOIi9JQT7P7kakZ54VOi3bnKjw+GrA032v54Lt2bg/gvqtT+wvxA8HZKeuPOF72Z2HSijgUT2Q3fG8C79EjagaIxVAxzhEygfIMFxou7hUo5fIxKnbYMKQl69iMZiyNVtJ6dBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871812; c=relaxed/simple;
	bh=xSGGNRB38KSR5rWl4EOvsCShDdsVZqRUL9IIMFdCZ9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzzXV5QDITNP6Ez0kO7od1CZl2e3XnDlyBEb1LfGHuNUp+89iTgK8XQJp1L3z15tU/FHCXgajehMLy+l1IxHaHU8CjBIp6ANif5dPAXxh0Z3YjEslVN46GDFKrkmTLmaVZCRqARN2TliDXDquBej5AMpP0eVnhi260vOV4t08A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaQi8Dgq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaQi8Dgq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24af8cd99ddso24935655ad.0
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 20:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756871810; x=1757476610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A30f6H/af2/oPub7TBMh6rRZFwkpnFZbkzYAUao4gIM=;
        b=aaQi8DgqWhbwQEYDXvTHGSG2v5+EdcEEHnhgCBb87qXkv1xlMyMvZtV0Jx7/UyRzrz
         1zk6lu6PyBYynGmW7bbDMtEy4xesiRQJej0f9yY3BQog/4umOEiqkdOxxCuWogMALD7n
         OlFzJENWY3NBr4JRVWEIKqhBdwyR5hxR8sTWwlrT5X+MmxD/Jsq1Nwzi/uWmtC8RDAIK
         4ZcGEbcqFdt+2Y0WAduMkElJhhibN6P6MUKqeqWnK/oheiozFEUfct6IbBtIQGwj8O33
         /EbNj5ScYxr365fShhjwyL761sewWAvpkP9va00Mpx4V1vmFSkadwAbMnyGgj9umTQdl
         tmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756871810; x=1757476610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A30f6H/af2/oPub7TBMh6rRZFwkpnFZbkzYAUao4gIM=;
        b=Ycm9X7rt6jLcEVZ/k4f0Zl1WY7JDNFCO1AdBdkwiI70F9MH/ZEPAfQX0KrkGWOO5GP
         zFCNCvI9evH52lsfGuYLlI0DWzQFU6uNWrayAMbm7buDdZQjWR2TJA/XNzNorhmDBnE8
         U585cSDwecYB2P2Hy9nOFUI1505hbRvD44TBrttPTP/4R7dlyxyUfnxEF4N/6F/OyaUa
         QQbBaJAm8FIXNRnEGVoeEo+yndIDP5j8KjuoJdywleSABW2dXV9C3SIL/Ujesn9Q+lsl
         oTUDYN4ZLNhBtU8ooWMcouBSKvX2nfA0umiBBb9gpPNSf00l44uS5BaDFvmkHnm+RVyV
         fqDQ==
X-Gm-Message-State: AOJu0YwPQX6YrF7YhxfAvi0aD592+7lrmhJOgrS7W/rsWfoJ8B6BxN9x
	77cURXtig3MIlqxgauTiZVIZK7Bg387akjIOjL5HsMJHhqUTArDxQ5GoNl7TD/Vt3YlMN+Uc169
	Jp02EfJ6KMI5sMyXGcxOuemqGSwZf4Gc=
X-Gm-Gg: ASbGnctM3Ua8I21LT26hk3tf+zNsbTxhNX+L/yyafpiUN2e/YU8015We8/kYrhZpZjF
	xoymOcHFsajowSp3VshHOPGrX2tEkkxH7QkOB4W8lMFujOOK/PbJbeFZ7I2MScisr0AA1CXWWcF
	/Ab+MX/GqmgVkKbN1q5dnuZjwcyCgZzMsfbzsI9ozXzl4fmZ9JtyG9Vw83+Y3q8y9cgrn3sCOqi
	jvHsXRlxAqnmem/xik=
X-Google-Smtp-Source: AGHT+IFaEo9wRIvwq2GpMVNJUUD6lt6EIj4dbqtkFx2PvZ2YmOhAFgkb2BkaYbs0xdC5kMChFVpDNTgz6Gy5nT6m6Mc=
X-Received: by 2002:a17:902:fc84:b0:246:f13b:1b92 with SMTP id
 d9443c01a7336-24944b758c8mr178264215ad.55.1756871809963; Tue, 02 Sep 2025
 20:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-2-meetsoni3017@gmail.com> <aLbEWSHUotkmSiCq@pks.im>
In-Reply-To: <aLbEWSHUotkmSiCq@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 3 Sep 2025 09:26:37 +0530
X-Gm-Features: Ac12FXxF6cIOQ-I0Jy6ur53ReAtzgPqgQ0BvR-hyix0YjXe2FOFCNqWB63ppY1E
Message-ID: <CAPhwyn1qm3CmYmupEdCzisdAC_uteWeBN05oZk0dqdPCty34yw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/5] builtin/pack-refs: factor out core logic into a helper
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 15:48, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Aug 26, 2025 at 01:06:41PM +0530, Meet Soni wrote:
> > The implementation of `git pack-refs` is monolithic within
> > `cmd_pack_refs()`, making it impossible to share its logic with other
> > commands. To enable code reuse for the upcoming `git refs optimize`
> > subcommand, refactor the core logic into a shared helper function.
> >
> > Introduce a new `pack-refs.h` header to define the public interface
> > for this shared logic. It contains the declaration for a new helper
> > function, `pack_refs_core()`, and a macro for the common usage
> > options.
> >
> > Move the option parsing and packing logic from `cmd_pack_refs()` into a
> > new helper function named `pack_refs_core()`. This helper is made
> > generic by accepting the command's usage string as a parameter.
> >
> > The original `cmd_pack_refs()` is simplified to a thin wrapper that
> > is only responsible for defining its specific usage array and calling
> > the shared helper.
> >
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: shejialuo <shejialuo@gmail.com>
> > Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> > ---
> >  builtin/pack-refs.c | 31 ++++++++++++++++++++-----------
> >  pack-refs.h         | 22 ++++++++++++++++++++++
> >  2 files changed, 42 insertions(+), 11 deletions(-)
> >  create mode 100644 pack-refs.h
>
> Shouldn't that header live in "builtin/pack-refs.h"? Makes it way more
> obvious that it exposes functions from "builtin/pack-refs.c".
>
I couldn't find any header files in the builtin/ directory. Also, since we
placed the for-each-ref.h file in the root directory in our previous series, I
decided to do the same here.

> > diff --git a/pack-refs.h b/pack-refs.h
> > new file mode 100644
> > index 0000000000..ba51d154e3
> > --- /dev/null
> > +++ b/pack-refs.h
> > @@ -0,0 +1,22 @@
> > +#ifndef PACK_REFS_H
> > +#define PACK_REFS_H
> > +
> > +struct repository;
>
> Let's add a newline here.
>
> > +/*
> > + * Shared usage string for options common to git-pack-refs(1)
> > + * and git-refs-optimize(1). The command-specific part (e.g., "git refs optimize ")
> > + * must be prepended by the caller.
> > + */
> > +#define PACK_REFS_OPTS \
> > +     "[--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]"
> > +
> > +/*
> > + * The core logic for pack-refs and its clones
>
> And a dot after to terminate the sentence.
>
> > + */
> > +int pack_refs_core(int argc,
> > +                const char **argv,
> > +                const char *prefix,
> > +                struct repository *repo,
> > +                const char * const *usage_opts);
> > +
> > +#endif /* PACK_REFS_H */
>
> Patrick

Thanks
Meet
