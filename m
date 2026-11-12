Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519357;
	b=Z9i5j50nX8xmmYPzNCqDP9D2yx7GCOAWkNeu6DqJ1NOG+6wh8TxRdt9zInZgAM9XFU6q
	 sp30C74i8967+MsSWCSu/G1OapGE3ld9Oa0jPbnZGjLACtcFEAMD3zxgjMJVCZCKGuIum
	 5pSlpPd32jMZ9IR5emcdrjeIUgzLQPlgYPIF/yptkFG5Iun2yUnkPlt8bmVyneA8z/Rha
	 eyT+jEuXvOfABppsAjfZDbwemNTEVvXr3mEWLR/KTl6SEklB/WRe5VktD5+unDXsUA2lR
	 YicqQIPZabEcdoUcN+BOCu/cSyQD9U+jB1rYt/za4KkOTAQWx/A9sx1/6euWFnqVwzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rfaNV2cBo8Xgmu/ykBSJp8NpbL4ypTYmJs87Vbyu9eM=;
	b=sR0Tbp7x5zMFCcv4lhGV9kbr7WEU9cfhiC8QkivQ/gJMDFe6FOjMtKqNnndWLA8I4kkX
	 C5bk75+YzssN5Ggz28ZdyaiQpimfYX25WZJDHkLA78FBF988U1ei6XSM9Mchl6fblXvvy
	 wPupP/p+D2PjgeixTWelO8dIZ6JAdmVPwQfFia1fi57Mg4PRF1fUFEd+RWPbZAsBdDfUm
	 PdVBhYaPO4AqDOOweQY9huBkuKDIFC/ACtRZbP4YV99TafjGQMHYKW/5TduqwyqQBMSQK
	 zjgKR7r6IrrlUiza8GgFbwfYaRWtb9bo8F4fuJ29eTLzWGqVSzkTw8F6/OpBH7C8pSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=IRhRaO9a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812D606A33D
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 21:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1812D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=IRhRaO9a
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67d8221074dso293136d50.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:35:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794519355; cv=none;
        d=google.com; s=arc-20260327;
        b=C+jfTPEAHjKit+A3cEp5D4LWoI+1czSoKtgX98QMvpwALuRzxoJNJvbbaCVoJhf+tM
         YE93/HxcVQjwZ2gOk3SGZsvGTEpb1SsuJNNirrHjYLdGI+ytlaUhnyE5UHWFkcWX+us/
         6RhOf0h/8CztOBVpZcTKDfiddOmsV88h93++gd8bWTppHjm3nByIKhxxvRJzH0JrpaUB
         ILV5Yyq3igjYLFNihqAislqEVd5IhLVdmh68ZnTWF1BcxqiuzyGbAMvVdKK1tNuUBOVH
         IvmI7zf46KlQhJTPtnkpUOCg/glFq781ez9f+PsFxS4iivR3aKRgF+p1LGurxQQm/k78
         e9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rfaNV2cBo8Xgmu/ykBSJp8NpbL4ypTYmJs87Vbyu9eM=;
        fh=E6Ck511nbwlXRi8zhvqSV7fAijApqnj11CY7+rwdzPo=;
        b=fbqEz1cs8QnglUFat24p0J6e/vTz4qF6DmqFkXLUQRLjBHj+QxOd6xN79w0Pjuxbze
         ho5LINLnN8hNBjfbgIAK92hXkorX2F2GfISaclqTliLI64MH2u1gPEUcKVxQgGDjjzmW
         sdRjhNl0HaR24FTV3GsMS18SFgrtSYov7yhKxP3VyCW5vUcce7lySzis2nawXD9CZeZV
         cVadxxEKz3nR9wiFNM/G/DheYRukPUD3SlN6hEbT7OpvD+sxmeuqhznRrqkEtMUi5ryS
         QlyFUomrfquJAedMHV04JCFVUBFIZLPljYi2Qs2/sbnKPnx/VI9QnuxHVbXo5u97PX+T
         cFQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794519355; x=1795124155; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rfaNV2cBo8Xgmu/ykBSJp8NpbL4ypTYmJs87Vbyu9eM=;
        b=IRhRaO9a/CcoH9rYR/YG2jByDFF5GCzWf4erYuAIpLbzg1AdM6z3UiYdfC4nLPdMYu
         yVmwtMZTMe+k884L1qOy+u1eJ9qxhb5HqsDWyjh805ksMjpoRBa4+K0iHF2LYWx7cAH0
         DG/g0WQcMZcHXbCIfJDzeLyfdgiy34nfLoZs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794519355; x=1795124155;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rfaNV2cBo8Xgmu/ykBSJp8NpbL4ypTYmJs87Vbyu9eM=;
        b=ohsxZ7+7a48B4VErdVpfJHcv9o0u/Zzl71FrNhJ7EUBJR5gQqbqxI4MvmpyYHWKvZP
         1AUEAhpBCv3cOgDO6ZSpkXO9GS6USKTuGHmM5NB0minLvPMoYxbofP48uN/WETWA21+M
         gVhwwbA0rmZYMkI+h8Whg4PuFwlOt3R85R8G14zfru4p40G1s7sYNS36HrO9QsPvF714
         rMbDhFtO1pnykyO1mjZXsvg74Yff6rYeRDt260AK7/k4iP8R8D580Dr7IilScfcudeT/
         f8+BxC5DfBsDn5c/7Tw5sZCNzGjF2LRaDzCeYuRS3zMWzaVMNVXrzAAga4XM+NO9XFw4
         p4YA==
X-Forwarded-Encrypted: i=1; AL+hErEmxvr+8pJin66UvFz8CXDr1hy7wX5uRVjn7lR/a/UIXQ0mv1YD5dYQFat035mLN0ZEyOc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MuBajWf26i9lgCSMC+apZYyeR0d91qL/N3qDGRSuk3VxtTNz+
	EpiB3PQGbNtOXEF1V6LbfsYDUMFIPW28qqiFQYpzLAH1B8Mkdo1QSgPqFk8ViOTxtuEmJBILcOe
	EdNH56YR6OL+zXNUFT2PkCAVwCN+5MdyQirxJDpTbDg==
X-Gm-Gg: AYBFou1rUlGnSFFzT1f7mCucSuupdMANF5CsqbcFflSc9BoGlfb6G4ud96rxQIuwnYy
	db+Sf2DvyPtfEc5COM3Ipu7hSB4zznUNxDAcMF4JQ1hYJQT09IAKYMY2sztfE08EBbRir/vuX1/
	quSJlnBFmf7f7uriKh8i/2MUB4pm8ZaL/uOb9tK1D6/9BC0eBHr4jkrTfll37jwGA59qp9+LQKu
	mSo//M/jSvY5YabVHOlLc1cOohwLISZyPeMPZ+PrnluE9Zj/JDbUA7eAc2GG6QS+dwhyPC1PyQ4
	NiWeqgvly2gmfNhPZZf5d5EheesZB7t0xiadkKfIQzx4e93UJFEBjgm0OHWxg2ZVP6Ks3v1DK0e
	KcRS57zSw8gdN/X7LyCrSJkpoQJDDXo3Xshk5e0m1RlJN9kY/kdvxIDM26OEV
X-Received: by 2002:a05:690e:140f:b0:67c:191a:b1b6 with SMTP id
 956f58d0204a3-67d8975b822mr442029d50.92.1794519354906; Thu, 12 Nov 2026
 13:35:54 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com> <xmqqpkw9j1ng.fsf@gitster.g>
In-Reply-To: <xmqqpkw9j1ng.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 12 Nov 2026 22:35:42 +0100
X-Gm-Features: AclHuK_Oz6OJiXSezl4FxhLixLDeSv88ZSu8k32iDJM_52Xda-0KPbjJgOgY0SU
Message-ID: <CAL71e4OS8MKZMY88C1SMs7ufSZ98-DNHNBc94cESdKpuXKbs7w@mail.gmail.com>
Subject: Re: [PATCH] commit: remove padding from struct commit
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 20:22, Junio C Hamano <gitster@pobox.com> wrote:
>
> The comment before this structure says ...
>
> > diff --git a/commit.h b/commit.h
> > index 1061ed791b..66a5d245f2 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -26,6 +26,7 @@ struct commit_list {
> >   */
>
> /*
>  * The size of this struct matters in full repo walk operations like
>  * 'git clone' or 'git gc'. Consider using commit-slab to attach data
>  * to a commit instead of adding new fields here.
>  */
>
> but apparently it did not have much effect to prevent this from
> happening.

That does indeed appear to be true.  I looked into the history of
changes here for my related test prototype and found that the
layout had changed several times.  These are all measured from
x86_64 builds of the respective commits, using gdb's "ptype /o":

                  size  padding
  2018              72        8
  2018 25f859fdf4   64        0   move "index" next to "graph_pos"
  2018 9d2c97016f   56        0   remove "util"
  2018 83073cc994   64        4   add "generation"
  2018 b45424181e   72        8   FLAG_BITS 27 -> 29
  2019 13eeedb5d1   80        4   SHA-256 grows object_id
  2020 c49c82aa4c   72        4   graph_pos/generation to a slab
  2020 23c4319f0d   72        8   FLAG_BITS 29 -> 28
  2021 cf0983213c   72        4   object_id gains "algo"
  2026 b4e8f60a3c   80        8   FLAG_BITS 28 -> 29
  now               72        0   this patch

While each individual change was good, I think it shows that at the
very least, it's hard to reason about the total size.  Adding a field
may either reuse existing padding and thus come for free, or create
additional padding and thus cost double.

> I would think it is an effective way to force people to think struct
> size bloat of important and populous structure to always measure and
> warn.  There may be better ways to achieve the same that others may
> think of, but I very much appreciate your bringing it up, even only
> as a discussion starter.

I can send a test as a separate follow-up, so people can weigh in
on the approach independently of this patch.  One thing that couples
them a bit is that the expected padding is more complex to express
without this patch, since it depends on the alignment rules of each
platform.

Another option I have tried is -Wpadded scoped to the struct via
a pair of macros:

  BEGIN_NO_PADDING
  struct commit {
struct object object;
unsigned int index;
...
  };
  END_NO_PADDING

The macros would live in git-compat-util.h next to
DISABLE_WARNING(), and expand to nothing on other compilers, which
is fine, since we only need to catch it once in the CI builds.

This works with gcc and clang and is lighter than a unit test, but
can only enforce zero padding, so it would not work for "struct
object", which has unavoidable padding with the current FLAG_BITS.
If "struct commit" ever ends up with padding we cannot avoid, we
would have to drop the macros, but that would only lose the extra
protection.

> Obviously, ordering members based on size, not their logical
> relationships, has its downside.  The "object" being at offset 0 is
> an integral part of our in-core object design (fake inheritance in
> C), but the updated layout gives a false sense that somehow "index"
> may have a more important meaning than say "date" or "parents".

I agree that ordering fields for alignment rather than logical
relationships makes the structure harder to read.  Ideally the
compiler could arrange them for us, if we could tell it that only
"object" needs to come first.

It is also somewhat fiddly: growing "struct object" by 4 bytes can
change the padding in "struct commit" without touching commit.h at
all, which is what happened with b4e8f60a3c above.

Still, given how many instances of this structure we allocate, it
may be worth optimizing the layout.  The history above suggests that
a comment alone may not be enough to catch accidental regressions.

> We may want to have some comments next to "index" (which is a unique
> number given to all in-core commits while they are held in memory,
> to allow the commit slab subsystem to use it as an index into flat
> array of things) and "date" (which is the committer date taken from
> the underlying commit object, without any adjustment), which are two
> of these members whose meanings are not immediately obvious.

I can add short comments on "index" and "date" for a v2, along
with a note that only "object" needs to come first.

Thanks for the review!
Kristofer
