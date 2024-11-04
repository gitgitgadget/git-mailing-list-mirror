Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5E1E3DCF
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753445; cv=none; b=g1PNIlOLfTibCgRwktmBrHIRS0y3yVKKvHDt2zfs9m/j0z1Rspv4ZTbfbcj+OK2OV9PBv6AQL0dTQzhWMX+UjuPPfAdf+CwVt+Ub/fLQaySDS9JVyxofIkMySOAU9eoxPLfRKLXVWxySYj/BBsFkOK+4m7BvGjn7Amv1sGTvvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753445; c=relaxed/simple;
	bh=ZrT58cD18otwyvELfRkEstlA5irtWF8sWq8WiaagogU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPTxEHxsFuAvxXCRrc6J2/NxaQIi295bfH0IyMEeYgZsTnhbf1fhnBig9EL/Hh/NBATFjIRdEg+/qPxTmMa2fMdkvNt8yhjPsxln3xj1SiGG49OHEsHXSgJgA6Jqz4WB+gMjAWcudN6epHnAG+hjuXyk2uHO/0yQdkrIgUl2g5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jHhepgFQ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jHhepgFQ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea7c26e195so26779387b3.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730753443; x=1731358243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrT58cD18otwyvELfRkEstlA5irtWF8sWq8WiaagogU=;
        b=jHhepgFQ2xxsXqkge06w/JEcHOyJ3rAnQ+fcsdgK09tl9msJVwfAWWqGg6WV/xe/aV
         Og2C/pmLLi6KGZjHI2XXTeE/iAH7UfNgsipHYtJnBXv4PwvE0tcYqUJYwH90e6bUoCb2
         wjy6S/zo0SqOZHs6ASci51RHpRA/JfiRqJZUv3G2FrcHtsI7yF1GK1TM7TafNBQpmSr2
         4+BdGwGib5eX7C38J+Tu3evxMEBRxCzZLnkcNHEG5TMpuoJzGI4KP1G3OSyLB8znhrYc
         B/TANbYxv5sv4mzOQw/gfVNF9WtuOmJZ7e8NhuIN8H99f8mVwZs/c/yHmb4qT/8RZPBt
         IZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730753443; x=1731358243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrT58cD18otwyvELfRkEstlA5irtWF8sWq8WiaagogU=;
        b=RRY5QMZHRUeKrrhAe/R/4UzkAVvBQn4/jUQ2J/Y4EKTpkU2AuXEAyXpxahIz6KrQ1C
         6U+n4ctGr53wvxS1eHEZOVMmt8Vjm04irV562MYJAZmTZ0br/rk8X0IXRTKFXojbuHdN
         Ekd2Bclvakpx3UoP7XbGf8r/JdAYYMrKF92CxqCu4gUuu9DHtXZN9Vo6DZjx6STwCpxL
         ZvE538iDrqHa72R6C446zuQnVkly14OaYGEfOJY4qcH4Fd7WxYfR0joUCygcUQczi4al
         4p56zV3nAy8w5BVQYmc03WVXgz3NvjBIivgTg0i64oBxSZNXyxGbiJfgzCFjwZMxUCCI
         igpg==
X-Gm-Message-State: AOJu0YzVuGWBDEPQ3IITZrUXdBXhtu98Tlhh52rxRuHDMskTwCrpJ+KT
	J2bQGsPC82BfFjK2EOKPpl9zG1JvWsga7t+rV1zI8LgYzbB1eMy2R+NW7a6BXOABkaDvT0BcwCb
	DV4U=
X-Google-Smtp-Source: AGHT+IEzx7qj37dCw4JUw23wiyLq2GSSsskMSjamlx2/2wDufZbcyHi0PdyCDUWzbIy3cqm9yt5JoQ==
X-Received: by 2002:a05:690c:c8e:b0:6e3:2be1:a2dc with SMTP id 00721157ae682-6ea52374db0mr167892657b3.11.1730753442977;
        Mon, 04 Nov 2024 12:50:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b107b8sm19557907b3.34.2024.11.04.12.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:50:42 -0800 (PST)
Date: Mon, 4 Nov 2024 15:50:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 08/11] t5332: enable OFS_DELTAs via
 test_pack_objects_reused
Message-ID: <Zykzobmfaun/Ojz0@nand.local>
References: <cover.1728505840.git.me@ttaylorr.com>
 <9d81d890402f94f4126aedef0845d615d10455bc.1728505840.git.me@ttaylorr.com>
 <20241011081939.GF18010@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011081939.GF18010@coredump.intra.peff.net>

On Fri, Oct 11, 2024 at 04:19:39AM -0400, Jeff King wrote:
> On Wed, Oct 09, 2024 at 04:31:24PM -0400, Taylor Blau wrote:
>
> > Back when test_pack_objects_reused was introduced via commit
> > 7c01878eeb (t5332-multi-pack-reuse.sh: extract pack-objects helper
> > functions, 2024-02-05), we converted bare pack-objects invocations
> > into one of two wrapped variants, either test_pack_objects_reused or
> > test_pack_objects_reused_all.
> >
> > The latter passes `--delta-base-offset`, allowing pack-objects to
> > generate OFS_DELTAs in its output pack. But the former does not, for
> > no good reason.
> >
> > As we do not want to convert OFS_DELTAs to REF_DELTAs unnecessarily,
> > let's unify these two and pass `--delta-base-offset` to both.
>
> I think that matches what happens in the real world. I am puzzled that
> your BUG() instrumenting turns up some conversion cases. Why are we
> still converting in those cases?

These are cases where we're calling pack-objects directly without
passing the --delta-base-offset flag, so all deltas get converted into
REF_DELTAs.

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 0fc0680b402..0f1b22b8674 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
>
> You need to indent or otherwise comment-out this diff. Otherwise "git
> am" will pick it up as the start of the actual diff, adding the bogus
> BUG() call to the applied patch (and dropping the rest of your commit
> message).

Oops, of course. Thanks for spotting again.

Thanks,
Taylor
