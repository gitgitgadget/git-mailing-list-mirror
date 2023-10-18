Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796032F531
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DIbpBd1L"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A7D6D
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:37:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d332f23e4so33254876d6.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697650634; x=1698255434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM6gaLXauqp2F/QkgSiShUYKsf6uGwB3zKK8f1W0OuA=;
        b=DIbpBd1L+GuAk043TiiCUhaKrohkTUYxqoxKePdCvnutl4oM82iL1st2CNzxlX7c+g
         /tPJF9FN2nzfee+gfJiwV19YniaO7sN5PF6OYfvxBRbG+LTy0R/SNkX/x3rlGPODaAcT
         t1QA8sTvGfO3WiT5YL4pfre2ihsDW3JESo714FBkuFy6mgiqREt0JqzkAu+ERXMbCD+r
         gjGdYwY/vU5zKdsgg/dYSwfJypChV03dkKbFK42bMREwLKOa6d22la0aIfNpImf47yEN
         oYeFvRjY8z3R7Szn/m0sdJsIrZ25By9XuZ+pBnaQ00WYOuGUfUvdNzjGSAXtuK4sKNrP
         iL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650634; x=1698255434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM6gaLXauqp2F/QkgSiShUYKsf6uGwB3zKK8f1W0OuA=;
        b=cxAavbuP9yZqeJPqHtwb107+Zuabhv1UQlx2HGngre3DSXTS+1XfzK/F/uiE9lRoAT
         028NyumAg+oZhn3z6RtoAiUkozr3SrfNaFS/zb3UQLO+zCCnXdKZxrACbivpF5WH/l19
         jkr/wuUVk9CSDuPJibwum7K4AGJWSV0yuKsaaatHbFS4tt7Qbhy58XbHOQw6CnH0ckkL
         dk/olYZWkW832O4P6WTmRZh7vuQignpW1YrkxNNu8qZAZG26+Uf6pYddCQFcY+HoeDhl
         bmrSwaDL75qoq7ULiOJtZDRdQAeQ5+WWCuRxy9qhPFxOQ4I7ZKp3vDU65QxPPmKeZ9HM
         Ad2g==
X-Gm-Message-State: AOJu0Yy7HVZwTsGnCA7cPNN4JjUlQX3z4dUxM9EZjhm/nT2NTGBKiljQ
	t8oFumrHW3Czd1w+X7b0/pDmWw==
X-Google-Smtp-Source: AGHT+IHUA7lLtVOp158p3Er9UMhvDyf73upjwZMKMyUx3lN5HRCXradUa7Lw+oDfJmUkcnYvboWw3g==
X-Received: by 2002:a05:6214:628:b0:66d:15de:329c with SMTP id a8-20020a056214062800b0066d15de329cmr7238984qvx.43.1697650634171;
        Wed, 18 Oct 2023 10:37:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fe4-20020a05622a4d4400b00417b9f5b883sm118625qtb.2.2023.10.18.10.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:37:13 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:37:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 05/17] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
Message-ID: <ZTAXyMWeQLRWcpuu@nand.local>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <94552abf455c6d341a0811333ae4edb4a8cea259.1696969994.git.me@ttaylorr.com>
 <ZS5JnkybxvetTUzu@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZS5JnkybxvetTUzu@tanuki>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 10:45:18AM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 10, 2023 at 04:33:33PM -0400, Taylor Blau wrote:
> > Prepare for the 'read-graph' test helper to perform other tasks besides
> > dumping high-level information about the commit-graph by extracting its
> > main routine into a separate function.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
> Nit: your signoff is duplicated here. This is also still the case for
> some of the other commits.

Yeah, this is an artifact of having tossed these patches back and forth
(originally Jonathan sent some of these, then I sent another round, then
Jonathan, now me again). It's a little verbose, but accurately tracks
the DCO across multiple rounds.

Thanks,
Taylor
