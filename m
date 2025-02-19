Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032E24E4B4
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998509; cv=none; b=X8j7JZTcKRIj12zXWPD4Mc+Byn7+novPgro6H88EjmlJk4dN4jB8R9FgIJuFS1icyiYlGkcnIUnJ1//ca4VCxpz/wP2wSnoutKLY2XMLBl+BGl5TICI/hauIAh+w0zUXbbWkWQsBPgwxS78s253ZfF1XUnUXyzjVOxTH0ODERRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998509; c=relaxed/simple;
	bh=xP1uLKYsnLdxSxRjbqquixuPhact/fWamgjWIDqMyus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahBKPnmOXfW3qd6U7LMnx6sQ53UBzrwdS6xm4qUV+bSPglXWqz1acFcriu/hBnn6mCygk7woFxae+gjTf+7jqRp6ZLP3QeXwzQ+9IwDTpE3PUQ3XYPVUlEZm5DXpS86QFkN7qwEFYQIvLvHetnfCC+NNA19iz/qxSgWN46F3gvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk4toQyf; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk4toQyf"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72736498817so116739a34.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739998507; x=1740603307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOCC9uaee8UoUhlHGkh2stri4VlvmQiy/zzYDXewrRs=;
        b=Gk4toQyfhsqOEn3O57ES88j1cGToJMLRK+QrWq+fiWYVvB3liK2cr42slYCddsNlT8
         MaGbuOSrmud87fsY1JV9CUa4Ln1PN8sah/6zdnapgMFelcPc3UW0cwDrkpInoFUlOrBl
         TdTrUAl/fS0SCy3Zjf4qoF+P3ctNzOqR3ibNZNVdK0PcvuGJYZsoqRdGKBW6GTSY3ryu
         chi/k7+TllKr2oqFbDEd2QLAPSvZeaeRYyr7AqypGlumWOF7ZASVFPJdltKjdFDoiTFU
         mb9zB0aa2ogTRSvrJbto6rt1LAPvuRS78iXesj0Ztg/GeLIy4mn3ZRdaBXWy/zoJefUt
         Ce1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998507; x=1740603307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOCC9uaee8UoUhlHGkh2stri4VlvmQiy/zzYDXewrRs=;
        b=qpYuziPkZpa/f4Bfo1Asx5YlNapWd8pUOTA/5FX1GnPXunlSstkQR9/0ieE0JlQL74
         Atmo70LJGwTb7gGjzy7uaILuIX/OYFHGT0ONd65d6QhwU6y/LufsNaN/gAXWk1bwBWd8
         /dLuu6O3sppNd/MvBGk5JQPBBWnDjFJB1uKlzwx6znk4bw8XJolv70gg0AK0b1NwiXrF
         XTjuDAmtpOeTVmDHVDts7fsJTrncptmvO4+OXsg6GYczpRli16Ei+2fhrPditJSzt3Q1
         xj/Ga8RBtNu3C9UaCLPduYYd5het2iBjfENGm2NPJ4YJuc6ks1Tl4d0oJhdXBC5Jqlr4
         FkEg==
X-Gm-Message-State: AOJu0YwX1cPxwSEzok4LB718fsSYalymfPv5XQjPjRwt43zmS4UFr75b
	wF/LLSMCPji9dV9Tzi1g1/exVklhgpRIz7SUZKgspZB4O07HAzfy11ExheZH
X-Gm-Gg: ASbGncugdPxJXkOCVowYQ+FC2Amv77FxHVdlMjHEgjwn/IEk8VNPXZ3hMwPHg1PXIIR
	WmfvCWVSN5sZumsrcm0PK17o6yukAsFvv4YfBhI8XdKb1lOr4ikYQnxEcgC8USD12lTpVEAhc++
	L15wODlWX80vT1jy9ZVTVBmMgqnb1YcS/LFSd1XjERG7vggzXQMlVSz0imv5/dt3+PfD8KXIpaE
	cLjvM+Pah/9cmW8pcka84v1GHwTsdt+g1kjQ83bPtxh0swecybYZuxwRlgkGZmHjd78R0Uah7cG
	AfJwo+6H
X-Google-Smtp-Source: AGHT+IExlBcGVdv7jzNbc+1Qd7blcqalrcJ/X/WIBL3txJjk+HIbeZZGkA71yhfQNdez7elQJEzTPQ==
X-Received: by 2002:a05:6808:158f:b0:3f4:cb8:cf46 with SMTP id 5614622812f47-3f40cb8d2acmr5566303b6e.36.1739998506735;
        Wed, 19 Feb 2025 12:55:06 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72737f960dasm763833a34.39.2025.02.19.12.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:55:06 -0800 (PST)
Date: Wed, 19 Feb 2025 14:51:57 -0600
From: Justin Tobler <jltobler@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, peff@peff.net, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
Message-ID: <wv5ziveuff7iellcmjcki372m5vp6nmltyls43e4wzslcqymog@gwczuaucpkke>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
 <d6d4230e-7b80-4eec-b218-37717ae2e298@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d4230e-7b80-4eec-b218-37717ae2e298@gmail.com>

On 25/02/17 02:38PM, Phillip Wood wrote:
> Hi Justin
> 
> On 12/02/2025 04:18, Justin Tobler wrote:
> > Through git-diff(1), a single diff can be generated from a pair of blob
> > revisions directly. Unfortunately, there is not a mechanism to compute
> > batches of specific file pair diffs in a single process. Such a feature
> > is particularly useful on the server-side where diffing between a large
> > set of changes is not feasible all at once due to timeout concerns.
> > 
> > To facilitate this, introduce git-diff-pairs(1) which takes the
> > null-terminated raw diff format as input on stdin and produces diffs in
> > other formats. As the raw diff format already contains the necessary
> > metadata, it becomes possible to progressively generate batches of diffs
> > without having to recompute rename detection or retrieve object context.
> > Something like the following:
> > 
> > 	git diff-tree -r -z -M $old $new |
> > 	git diff-pairs -p
> > 
> > should generate the same output as `git diff-tree -p -M`. Furthermore,
> > each line of raw diff formatted input can also be individually fed to a
> > separate git-diff-pairs(1) process and still produce the same output.
> 
> I like the idea of this, I've left a few comments mainly around the UI.
> 
> > +Here's an incomplete list of things that `diff-pairs` could do, but
> > +doesn't (mostly in the name of simplicity):
> > +
> > + - Only `-z` input is accepted, not normal `--raw` input.
> 
> I think only accepting NUL terminated input is fine, but if we want to
> accept other formats we should  have a plan for how to do that in a
> backwards compatible way as we cannot use `-z` to distinguish between input
> formats.

If in the future we want to support the normal format, we could introduce
an `--input-format=normal` option or something along those lines. 

> > +	const char * const usage[] = {
> > +		N_("git diff-pairs [diff-options]"),
> 
> Normally the option summary printed by "git foo -h" is generated by the
> option parser. In this case we don't define any options and use
> setup_revisions() instead so we need to provide the option summary
> ourselves. Looking at diff-files.c we can add
> 
> 	"\n"
> 	COMMON_DIFF_OPTIONS_HELP;
> 
> to do that.

Would this be preferable even if git-diff-pairs doesn't support all of
the common diff options?

> > +	argc = setup_revisions(argc, argv, &revs, NULL);
> 
> I think we should check that there are no options left on the commandline
> after setup_revisions() returns

Good call, will do in the next version.

> > +	/* Don't allow pathspecs at all. */
> > +	if (revs.prune_data.nr)
> > +		usage_with_options(usage, options);
> 
> It is not just pathspecs that we want to reject but all revision related
> options. Looking at diff-files.c we can do
> 
> 	if (rev.pending.nr ||
> 	    rev.min_age != -1 || rev.max_age != -1 ||
> 	    rev.max_count != -1)
> 		usage_with_option(usage, options);
> 
> To catch some of that but it still accepts things like "--first-parent",
> "--merges" and "--ancestry-path". We may just have to live with that as I
> don't think it is worth expanding a huge amount of effort to prevent them.

Yes, we should also reject revision as well as pathspec arguments. Will
update.

> > +	if (!revs.diffopt.output_format)
> > +		revs.diffopt.output_format = DIFF_FORMAT_RAW;
> 
> This matches the other diff plumbing commands but I'm not sure it is the
> most helpful default for a command that is supposed to transform raw diffs
> into another format. Maybe we should default to DIFF_FORMAT_PATCH?

As you mentioned, defaulting to DIFF_FORMAT_RAW isn't the most useful
behavior. I agree that it makes more sense to use DIFF_FORMAT_PATCH as
the default. Will update in the next version.

> > +test_expect_success 'split input across multiple diff-pairs' '
> 
> This needs a PERL prerequisite I think. I'm a bit unsure what this test adds
> compared to the others.

This test demonstrates that the raw diff input can be split across
separate git-diff-pairs(1) processes and still produce equivilant
output which is one of the main usecases for the command. That being
said, this test isn't really exercising different behavior of
git-diff-pairs(1) itself, so maybe it would be best to drop it.

Thanks for the review :)

-Justin
