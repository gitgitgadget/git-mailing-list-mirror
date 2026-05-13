Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC03AFB19
	for <git@vger.kernel.org>; Wed, 13 May 2026 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700114; cv=pass; b=NkFLrUFxFtZXN448YOgz0TRz4SY379nCdU0n58RZ6tmbGCf2J1g19U/cFBgwXrtbnftvSiAa9RNHg9Xrr/PPUW/ZSSOMAZ2Ytsu9y3InqIz8dmnf6qtQ9mVEaaBGkao0q8ct62uMZ5XJxQopr7pNZmW1wod9DPlNh6Pi/zqTr2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700114; c=relaxed/simple;
	bh=/ms1ZDiQIFKbbHvmxcGGTsm21uCxOlDEBfGoQGLs8iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llb8P6gBUPk3nbJTpBrMvESPH7C/RU9kRixJFJTyLq53F378t5fWUIDKYQwJtzwVxdAkar1cxBCVduBhd52zmE2vxHPu3JXltCYI079SnDfsUhS703cu8RVoyDP8LqmCmYajm2fFgu9RhQgPwTs2TKmfKh0RzfFZQj4l9iXkwZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJuzoEbW; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJuzoEbW"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69b2eea8f1fso2475951eaf.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 12:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778700112; cv=none;
        d=google.com; s=arc-20240605;
        b=dJD0A/b2F3MZY6k7exQ/98DFSHkHBbN3txpv4Y8bnQuqf5d2qFAMviAdCfxPCN/Mql
         PXAfeqXZOjC62UcKgxEU9q09RiDZTngknE2Pf5pQfXGcey520n7uN+JJkQAv7OQO8Z0t
         +42UhK1V2rAcybS90BeqhQxHPGK0XOV41C5wAH7kEqNX9oZEnuJYlUBocEi2VUMx5+Cq
         5KnaDdAnF/U9EZ+0PJDPxg0LK4YCGuROt8wjAHR1HeqhG+KsVfXPebzsXsnZBXz1V6/h
         Vcw6A3poAPbQRvTOyrIQhTZ79YQPeZeEg3lsbpPbO3Bz9xSlPb7p0rfbEAsiV3LY6KPR
         +w/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tOJWAbVQCwh1g7Hy/QqK4Dd6PfpUk712uGEjWR0AgMI=;
        fh=lNVfz0X8bxuB+5W11qnDkDIClkXAHENJvNtVhgJ8TDc=;
        b=HH1NlbUUmwqHar1Kh3UiW7SFLqx4/9J3VGuo6Zf0/M7MmEcjup3q3GW9cIJsT2m7sv
         pSE4++zv+IGAj9W8UOIb5fPUZXTlEQL2r0VmY/YSP3EQN4eY+a/+ywhpWatrQJOolYRf
         zn0vPE2yE1z7OyXHHq4IC6MbdIANLYvIcvWn4aCDUNoqi/dL3vBJ265Rt+wkiWnjS1Pq
         +qHXyaMHLicseoFyqdPwvuIhgXoB8pDjbAIO8JxTY73kro5LLDB0NCqu312F43qKJIK8
         xOZE0SHONt82luWfIatrVwQNw4UATr06Je16x0i6kpkMRkOI0mRf7KgEmod+CobIo4Ib
         xNVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700112; x=1779304912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOJWAbVQCwh1g7Hy/QqK4Dd6PfpUk712uGEjWR0AgMI=;
        b=rJuzoEbWzTre52L6SwewIgmyo+IZgBuOA2qRITHGEX1HyrvuU9vg5vWLGV3u8coJF7
         tFbUxLBtm1eHUguHQQwjuC1Q8JjStrsw/DMA9F/z/8SK3VkPNVG7sm0IrKJj02uu5VAz
         p7/r7aCNzGR4KqLIfaagielAU5KVOHD5Kba/TEmORwbdrqAKrTRfPYFGWchR6s9h/ly5
         +K6FSe9ARo2buXTb8VfUyuqP3hNFIKIhBkzplTunt0KTAMNgTv9nxt+q6ZCI7ABvYckj
         ciXIUPnq1O7F3I3nRi3n40cpOYtczzbY6KZlNEJr0YIKlMNIbQqYBxJ0ywt8lgjVfSSt
         Mt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700112; x=1779304912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOJWAbVQCwh1g7Hy/QqK4Dd6PfpUk712uGEjWR0AgMI=;
        b=fPZHAfAUmxN5we1P+n7gtwjhf8zKcBag9qbP1kvEvMzo6SjAX2rFXZsBWEYSqHe52A
         BM8vB9t035+W+0Cj0GabmNATbyd7P3y5QLLkquqzKN6cfNDH61eRk5az93nIYrUEe6/d
         gG56uPlMHf3slNl/MIcs0zenPOOUEhzGm3T27CaBWG+327j9UDmi3STSq7n524Hv6RBc
         Lbm5/dw3ocezUoKcVkjd2zd5cXHnM7XppfnE4/lGS1eL2iTBn+WcJjtv+60/bqRWtcUD
         a+VpW/ToRKc9+lAtiowM9MO457tIIdgG9qd0yXZGJ7PZdviJ4nMvCGw6282VYRrGtWBV
         dDig==
X-Forwarded-Encrypted: i=1; AFNElJ+Hku/pj7w5Ze1gOrs2ka4MgDJ/uk3d4ospoHvJSME2lnZUMnTHecG+3vo7qszHLrzwYHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8bF90K3/IIgoQTby3QNGkeYCyDT6Dhyiqm+V37xs7GgxmrOD7
	L3o4umEPOXLbjrY/nG1O4Lnf3qsii0LOEGLlZC7VmuKsiruFMb7q58qvwCaGUNqn4+YaXI5Re84
	/InBO2sT/N/0nW6HRBDSUEVcKXkupkB/2Vw==
X-Gm-Gg: Acq92OEjpFFStz4hZhC2IH9/y2RozpZnJLFFml7zkOMZSToFln20H6TKMmP08q149u5
	af1xgvnvjIzLrKOJwl/m91/Bk64ZC5LEXO8rjpSdSMd9XvcOUlqY1cg1mSvtkpkLdpu5cdad/78
	f/pdh7WZ2A5DTXgOR/tJ4brsLUhAPf7QtbE+WHY7MiXdcWSR2gmplI5lXc1AJ9+RggLZzpv5zSH
	x8SwDAGa30+K7UlgW+QJcXQkJU4L95EUewLpbu/J8scTEbfZEZvkRdgiJuW5hOEbJyABegCA+Hz
	MkMMQOFEKBb3bLtRe+zp2a3ycntMVqDBV+uUNx2041UQIcxQkMYHqF2uAkCKRM4QnyyFVC/4KQx
	EUF0FmV4WtT1CYIBGCJpd+7JYrg==
X-Received: by 2002:a05:6820:3087:b0:699:96b4:719c with SMTP id
 006d021491bc7-69b78dc0740mr2693228eaf.25.1778700112298; Wed, 13 May 2026
 12:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com> <8fbfe69bc4d0c6166967986f24861ffa393ed7cf.1776472347.git.gitgitgadget@gmail.com>
 <31763514-2602-4d8e-ac25-70590f090947@gmail.com>
In-Reply-To: <31763514-2602-4d8e-ac25-70590f090947@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 13 May 2026 12:21:39 -0700
X-Gm-Features: AVHnY4IBh9cvj39ZPIJRn7gBJSk48RZBV_phWvGZzBrB9h7ihhJGVCI2_gnQmc8
Message-ID: <CABPp-BHq=rRQSxtiVE1s9jiQQAqqAi_k+fH0OHCVjmfzq07hiA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] grep: prefetch necessary blobs
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 5:59=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 4/17/2026 8:32 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > In partial clones, `git grep` fetches necessary blobs on-demand one
> > at a time, which can be very slow.  In partial clones, add an extra
> > preliminary walk over the tree similar to grep_tree() which collects
> > the blobs of interest, and then prefetches them.
>
> A log of the code is about walking trees to find blobs matching
> the input pathspec, with this being the core method:
>
> > +static void collect_blob_oids_for_tree(struct repository *repo,
> > +                                    const struct pathspec *pathspec,
> > +                                    struct tree_desc *tree,
> > +                                    struct strbuf *base,
> > +                                    int tn_len,
> > +                                    struct oidset *blob_oids)
>
> And in your test, you set up a repo to have three blobs with
> matches in two of the files:
>
> > +test_expect_success 'grep of revision in partial clone does bulk prefe=
tch' '
> > +     test_when_finished "rm -rf grep-partial-src grep-partial" &&
> > +
> > +     git init grep-partial-src &&
> > +     (
> > +             cd grep-partial-src &&
> > +             git config uploadpack.allowfilter 1 &&
> > +             git config uploadpack.allowanysha1inwant 1 &&
> > +             echo "needle in haystack" >searchme &&
> > +             echo "no match here" >other &&
> > +             mkdir subdir &&
> > +             echo "needle again" >subdir/deep &&
> > +             git add . &&
> > +             git commit -m "initial"
> > +     ) &&
>
> But then the command downloads all of the blobs, not using a
> pathspec:
>
> > +     # grep HEAD should batch-prefetch all blobs in one request.
> > +     GIT_TRACE2_EVENT=3D"$(pwd)/grep-trace" \
> > +             git -C grep-partial grep -c "needle" HEAD >result &&
> > +
> > +     # Should find matches in two files.
> > +     test_line_count =3D 2 result &&
> > +
> > +     # Should have prefetched all 3 objects at once
> > +     test_trace2_data promisor fetch_count 3 <grep-trace
> > +'
> I think your code is correct, but I'd like to see a test
> here that demonstrates a pathspec filter on the 'grep'
> command to help filter out a blob that has a matching string.
>
> Perhaps something like:
>
> * matches.txt (has needle)
> * nomatch.txt (does not have needle)
> * matches.md (has needle)
>
> and then 'git grep -c "needle" HEAD -- *.txt' would
> download two blobs and find one match. A second run without
> the pathspec would download one blob and find two matches.
>
> Does that make sense as a test?

Yes, absolutely.  And thanks for suggesting it; although I was
handling pathspecs correctly, I discovered that I was unconditionally
requesting to download whatever objects matched the pathspecs (or all
blobs in the commit if no pathspec given), even if the blobs were
already local.  I'll send an updated test in v2, along with the fix.
