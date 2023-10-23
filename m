Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2D1BDCF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL1EuQDv"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA226B3
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:22:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so51900851fa.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698092559; x=1698697359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQoPs78PaEnDUMooQ9FI7ybOE+3TTlNSgyEnGZlabAQ=;
        b=HL1EuQDvyNKLbuzK7uRVyNHjMembYL2bsBcUPX0143tLt8KZsDwHtR1oecgFUKFrL3
         Wb8b0Xd1venXK12bfLyplBhTpGl8kJjQYkMmPT1S/XbIp+c2eFtmvTpcdgcVxYVsXY+V
         kYzORS1SaCBlsndeaPyNcxb6UPi53ha+W6bIuGh+svc5I34aeAijp6CRTfwZeRRs99/Z
         1zE5UnrQDHqRMVI6mCHwPb03WhXSD5pt0ccFOWpebvtqqj+SpYB1LicYmKeeIMxJhLFU
         3Z5BI6kIwhlvVUMNSHdOKi5H1PspHJng6J9r/Sw5mdk3mld4yh2hh8Ytd2u6iQK5OkTM
         DYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092559; x=1698697359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQoPs78PaEnDUMooQ9FI7ybOE+3TTlNSgyEnGZlabAQ=;
        b=IWtiwcFMgq03gl4KLXU1REXsFpfD5HLN/361v2+8Ed/6s+n9lFJThiB+B9g1jdiAMm
         /p+xIolg6ScWIWSIASwbGFYGjiIcJyL3y8AotVXGa/IJGYPR/dg6J1AT5YaEJX3lCjVp
         XOZPtFvzZyERsnH/AgoP6WDkH20xwlRDfUKboaVGrAj3CjDm0ZY7YKKM0MM1ywx40OkV
         NW7tA/wrRV9IANp1Ucp0MfXnTTRZt/w5gMY1jBHXEkA8eHf88xx0jdURRdveIsocTKI7
         T8Ef0iefeg37lmel9Ly66zPN/A+eiPzUtuB7GRa8VQgcG2i8eZ0YmeVJ3G4OjzXIrOn7
         Dgug==
X-Gm-Message-State: AOJu0YzAyWEtNX85AFjvF2c2xnJZPSlEjthEBswi4qEEq4ul32fSs9+k
	hWsRAs6uS5CoQwJ5+yJ/7Xo=
X-Google-Smtp-Source: AGHT+IGoRi7CIAc+7NCxlAsTRM89KlneIPluCb1KeNvSxaTSju4RRhSi+Y8IdcXv9nBBHsbPVi1n8A==
X-Received: by 2002:a2e:9cd4:0:b0:2c5:2df8:d321 with SMTP id g20-20020a2e9cd4000000b002c52df8d321mr6995721ljj.36.1698092558371;
        Mon, 23 Oct 2023 13:22:38 -0700 (PDT)
Received: from localhost (78-131-17-202.pool.digikabel.hu. [78.131.17.202])
        by smtp.gmail.com with ESMTPSA id x7-20020aa7d6c7000000b0053ebafe7a60sm6886518edr.59.2023.10.23.13.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 13:22:37 -0700 (PDT)
Date: Mon, 23 Oct 2023 22:22:12 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 00/17] bloom: changed-path Bloom filters v2 (&
 sundries)
Message-ID: <20231023202212.GA5470@szeder.dev>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
 <xmqq34y71phj.fsf@gitster.g>
 <ZTK4ZKESDVghzSH8@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTK4ZKESDVghzSH8@nand.local>

On Fri, Oct 20, 2023 at 01:27:00PM -0400, Taylor Blau wrote:
> On Wed, Oct 18, 2023 at 04:26:48PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > (Rebased onto the tip of 'master', which is 3a06386e31 (The fifteenth
> > > batch, 2023-10-04), at the time of writing).
> >
> > Judging from 17/17 that has a free_commit_graph() call in
> > close_commit_graph(), that was merged in the eighteenth batch,
> > the above is probably untrue.  I'll apply to the current master and
> > see how it goes instead.
> 
> Worse than that, I sent this `--in-reply-to` the wrong thread :-<.
> 
> Sorry about that, and indeed you are right that the correct base for
> this round should be a9ecda2788 (The eighteenth batch, 2023-10-13).
> 
> I'm optimistic that with the amount of careful review that this topic
> has already received, that this round should do the trick.

Unfortunately, I can't share this optimism.  This series still lacks
tests exercising the interaction of different versions of Bloom
filters and split commit graphs, and the one such test that I sent a
while ago demonstrates that it's still broken.  And it's getting
worse: back then I didn't send the related test that merged
commit-graph layers containing different Bloom filter versions,
because happened to succeed even back then; but, alas, with this
series even that test fails.

