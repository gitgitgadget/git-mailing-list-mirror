Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03821A29F
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pJ2Ch86D"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7815c5b69e1so484456485a.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2024 07:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704296751; x=1704901551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/X1rTYgJpaa6jZo192S5jJ5wn5P1BNEyXpg5GVdkGM=;
        b=pJ2Ch86D6OPqCcvwQ4FnT4IYRDg3OBC72k/f4pXxvlWUTr09fO2CZrTzEUPSpKUgDb
         z2FTHzPc5+B8HTpF3VS0Y/WyTrC5gsO1lfW8bfDrD9TH4DGOSy7SlS1cQqDejmZgZA/n
         v/6HfTAaBWtHnzOMe2k35rwgPpzRerchJvxj/o1LhsGF3cV1J/X8QJAUs7Vla92otggg
         JsY+6jYjB7hXe8A44TyFPbMb9kNx8i+LybWUw91eJ85S5R+b472qjmFWf8XMKM/XuYrU
         LHYjWpChfMPBpFtp43qdI9KVPiLdSCCNt2w2FnXuwrEsa5WEqXVPhZ7MUNR5I8xa1wov
         pe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296751; x=1704901551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/X1rTYgJpaa6jZo192S5jJ5wn5P1BNEyXpg5GVdkGM=;
        b=oEENDrAMQ1qhBt7bgybYdQzWcccsxJ9DNLsWCfV7KKXlf4rUTRmztg/Owt+oJ0ybx8
         SPqiashxjDVShj0ADqR6ewSLk0saWaGHr0KnKWTseSUTh425eHcdHv6FZjRklQig/kPq
         VrE16l4UPQ2iCuiOXZi3+I8LlTSC2oUsZophMGN55x5XnjsvlraimYbiV9VZwkfWtETl
         6daQU5ayCKK0shG9doTl21RqHs8dGz6EUACfY4ghx9Cb3qTa6+qYCTCtoCjSp7qkEO/b
         UFArJKw01H8ni/CgUDI2lWdBsJTpitJbNv4mUPqbXPfmzbdcEbFQ3h41JirUTCX9J9Xq
         8uHw==
X-Gm-Message-State: AOJu0YyfUo6ZZ6jMoctTlfBUiUwx2LDROioh1wLOB012VyFjEFudodpC
	QYgvpJcGVfokhIH2SUMRvdnT5AytR1sHU2TCzmN9TMs839UIYQ==
X-Google-Smtp-Source: AGHT+IEc9wXWwBLLkXvcihIjfVl91RMgrHIXDbg9f/KOodqwzjVoTdGBgTKqfub1jozq0AOAsl0WiA==
X-Received: by 2002:a05:620a:15b0:b0:781:7848:1b93 with SMTP id f16-20020a05620a15b000b0078178481b93mr10382362qkk.90.1704296751544;
        Wed, 03 Jan 2024 07:45:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bk2-20020a05620a1a0200b0077d7cfde46csm10295128qkb.106.2024.01.03.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 07:45:50 -0800 (PST)
Date: Wed, 3 Jan 2024 10:45:49 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZWBLafB3pIlZqpw@nand.local>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com>
 <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
 <xmqqsf3oj3u8.fsf@gitster.g>
 <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
 <ZZRaOhK869S1Sg1h@nand.local>
 <ZZUgUUlB8A-rhep5@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZUgUUlB8A-rhep5@tanuki>

On Wed, Jan 03, 2024 at 09:52:33AM +0100, Patrick Steinhardt wrote:
> > I tend to agree that the special empty pattern would be a good shorthand
> > for listing all references underneath refs/, including any top-level
> > psuedo-refs.
> >
> > But I don't think that I quite follow what Karthik is saying here.
> > for-each-ref returns the union of references that match the given
> > pattern(s), not their intersection. So if you wanted to list just the
> > psudo-refs ending in '_HEAD', you'd do:
> >
> >   $ git for-each-ref "*_HEAD"
> >
> > I think if you wanted to list all pseudo-refs, calling the option
> > `--pseudo-refs` seems reasonable. But if you want to list some subset of
> > psueod-refs matching a given pattern, you should specify that pattern
> > directly.
>
> Where I think this proposal falls short is if you have refs outside of
> the "refs/" hierarchy. Granted, this is nothing that should usually
> happen nowadays. But I think we should safeguard us for the future:

Hmm. Maybe I misspoke, but I was thinking that `--pseudo-refs` would
imply that we list all references (regardless of whether they appear in
the top-level refs/ hierarchy). But perhaps I'm misunderstanding what
you're trying to accomplish here.

Thanks,
Taylor
