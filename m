Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7CF3D96F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dWGqI5Po"
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E921D5A
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 14:34:45 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce344fa7e4so3128204a34.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 14:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699914884; x=1700519684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLSMeMY6v5MMuOpw9gMD6mDRQV5iJt7OQjHcVqTH2Fw=;
        b=dWGqI5Po91/aH8B9X2eteS4HWitxP+5Ev0jYrX27olcPrJM2UG2jUF0h6cmT6Eind4
         g2GLF9AjZBug3ZmGi5xz2fKQJNIkZHodkv7U3Ffm3JkRfJOahAA3ZfvfcKmMoc5uExg9
         /xRlFtYpmpo7Zfh0yyJOjPAEYzNAnQ2bRa8ENnkhediukDWLAHu3HMRpNuomf7tPIEcb
         sSOkfEI4e4448kRB0n9NHMPtInEh0Ive+IDFtF1bK5yE8xKEZou+BvdzzYy8amOIqkJf
         QR65S+UjNlO+viMCBq2lMKhq1+n2g45Xxdf6S4vugrk+M1SIqfQncS44lXQ7jrYwolGy
         8PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699914884; x=1700519684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLSMeMY6v5MMuOpw9gMD6mDRQV5iJt7OQjHcVqTH2Fw=;
        b=NoTAGuKqiu119NxAAAXq4Ty7vusVVF1queWtMyJ00rl4ekbMtfAy3wEn8AnUd/6c8R
         byAsCB5EHn7EcUoGLNrDsbolp4pwbBovcAN4WtR8FFNYSj4M1P2Cgxm7IndA5DXGyga8
         j+tlfk8/hKgZUK0yuqJT9IwTm4nx3kqiPZ9J+WQVUESV00gHSorafWQ8jbxYnt27UEIJ
         iWZHEulgWvWRD6X5va2wpsWe4pLFAAw5qhrKoM9nou9cA4y++8Wc9/2g+QfFd+aMjQx4
         apC4F6GqFvMO1inXGRFZbGnWX/aFn+ss1hxYH/utfg/9lwOsWGQ+RzmS8NthqtI8CUQm
         gg5w==
X-Gm-Message-State: AOJu0YwieY33tKG4h1prLBY0bc+EZyMu9V+xJlk361TxT/mzDjeaSy1s
	RXb4z0QSwJW1XpdLuAoX73pODA==
X-Google-Smtp-Source: AGHT+IFzwtph2nSjYIECpZFGHVWKSAYW7lkSHyhgeMAvE7ly9LzJ7s1Te5KGqoyQaXtHjo/RLPTTww==
X-Received: by 2002:a05:6870:7986:b0:1e9:907b:1642 with SMTP id he6-20020a056870798600b001e9907b1642mr10457609oab.16.1699914883972;
        Mon, 13 Nov 2023 14:34:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85643000000b0041b9b6eb309sm2245840qtt.93.2023.11.13.14.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 14:34:43 -0800 (PST)
Date: Mon, 13 Nov 2023 17:34:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZVKkgpiFaOwwDcdw@nand.local>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <20231113220254.GA2065691@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113220254.GA2065691@coredump.intra.peff.net>

On Mon, Nov 13, 2023 at 05:02:54PM -0500, Jeff King wrote:
> On Fri, Nov 10, 2023 at 03:51:18PM -0800, Elijah Newren wrote:
>
> > This is unsafe; the object may need to be read later within the same
> > merge. [...]
> >
> > I think (untested) that you could fix this by creating two packs
> > instead of just one.  In particular, add a call to
> > flush_odb_transcation() after the "redo_after_renames" block in
> > merge_ort_nonrecursive_internal().
>
> It might not be too hard to just let in-process callers access the
> objects we've written. A quick and dirty patch is below, which works
> with the test you suggested (the test still fails because it finds a
> conflict, but it gets past the "woah, I can't find that sha1" part).

That's a very slick idea, and I think that this series has some legs to
stand on now as a result.

There are a few of interesting conclusions we can draw here:

  1. This solves the recursive merge problem that Elijah mentioned
     earlier where we could generate up to 2^N packs (where N is the
     maximum depth of the recursive merge).

  2. This also solves the case where the merge-ort code needs to read an
     object that it wrote earlier on in the same process without having
     to flush out intermediate packs. So in the best case we need only a
     single pack (instead of two).

  3. This also solves the 'replay' issue, *and* allows us to avoid the
     tmp-objdir thing there entirely, since we can simulate object reads
     in the bulk-checkin pack.

So I think that this is a direction worth pursuing.

In terms of making those lookups faster, I think that what you'd want is
an oidmap. The overhead is slightly unfortunate, but I think that any
other solution which requires keeping the written array in sorted order
would in practice be more expensive as you have to constantly reallocate
and copy portions of the array around to maintain its invariant.

> I don't know if that is sufficient, though. Would other spawned
> processes (hooks, external merge drivers, and so on) need to be able to
> see these objects, too?

Interesting point. In theory those processes could ask about newly
created objects, and if they were spawned before the bulk-checkin pack
was flushed, those lookups would fail.

But that requires that, e.g. for hooks, that we know a-priori the object
ID of some newly-written objects. If you wanted to make those lookups
succeed, I think there are a couple of options:

  - teach child-processes about the bulk-checkin pack, and let them
    perform the same fake lookup

  - flush (but do not close) the bulk-checkin transaction

In any event, I think that this is a sufficiently rare and niche case
that we'd be OK to declare that you should not expect the above
scenarios to work when using `--write-pack`. If someone does ask for
that feature in the future, we could implement it relatively painlessly
using one of the above options.

Thanks,
Taylor
