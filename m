Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136418C08
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VeR03oqz"
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5730107
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:54:16 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2d9ac9926so3008126b6e.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698681256; x=1699286056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iAzP4CegO8XKR4aKGdX9wlyZbEiWV/cduetMraI5VXM=;
        b=VeR03oqzjyHYlko0Y5jk3Twk3yg1uuE7yrXRrzBLqaPDQ63PP9bq89mDZCwFxa04YS
         0UuqgdBA2076JA7ZD71PiLubkOzMYdcpX7LyWxVQDi1kfFLzfVFnBXkp51TP81m2wwvE
         FKGrvIbOuM+fAM6+u+EpAA3sjNApvjc9Rr5lc0hffx/52Mr3daF0JinVd8mxQC0JuD1G
         WijvjbgnWtdJPqlcHjOoCqxmSVHSSdp1RSBJMPSad8oARoJtXs6d71Et1iaRn2ikWMB+
         5/43OXitODZ1pkn3mocscs7FLAwYOft3gZzMHujcceF9+s3PVKcMZWO76br45rTSan9C
         3baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681256; x=1699286056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAzP4CegO8XKR4aKGdX9wlyZbEiWV/cduetMraI5VXM=;
        b=BcyNMGcqefl0e0+OjdkrAfPdZceIdTky2kumDiZfdJ6dVNR6GYWtdVCV5Ch+6XB66v
         gbR/TqjQyktiQx0PdxZFlQOHyz6r3e1ZjwBqDQ/AgShv1eiTRe+TdiGyaVjmxjALPpat
         P956x12EQEW7mJcSEWEskIjHsgcgOgV/8pKBNETcZGPX7iR/GTLV9/Xu9BM26KQ1eRzn
         iCbnRadJDi3CTXu+Zyd1xULD95H0bkS2AMt/gB2FFjNQmuIJqWlW7yQUrxOlLM3xZ/aG
         h29ojXpLa2Ch0QHgQDA/G7DiM3Op0brKdkaddhqpNxKeJYOdvFy7kdhSjPv12RyJBEwF
         Mh7A==
X-Gm-Message-State: AOJu0Ywjf5CbRdqQFU22g0tApeL6hHlJ5/SSgfozUNLawud6Xv8J1AON
	0pGWhUAvsddLdHaxkFCEsdtKnQ==
X-Google-Smtp-Source: AGHT+IHpDb7JOv+OQJL+o2Msu64oSnqXR19O2KUMAvM+TfORjEgOhXeOkrRbsagK4IyjNioC3VSmuw==
X-Received: by 2002:a05:6808:210d:b0:3ac:aae1:6d64 with SMTP id r13-20020a056808210d00b003acaae16d64mr12304286oiw.2.1698681255742;
        Mon, 30 Oct 2023 08:54:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c13-20020a05620a200d00b00773fe8971bbsm3431404qka.90.2023.10.30.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:54:15 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:54:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 0/1] Object ID support for git merge-file
Message-ID: <ZT/RpqvfQyx+uzxa@nand.local>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <CABPp-BFJn5NsSaaxEMpicqND_-8CBw370kyBQuKHGOX-3PRyMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFJn5NsSaaxEMpicqND_-8CBw370kyBQuKHGOX-3PRyMw@mail.gmail.com>

On Sat, Oct 28, 2023 at 11:24:06PM -0700, Elijah Newren wrote:
> On Tue, Oct 24, 2023 at 12:58 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > This series introduces an --object-id option to git merge-file such
> > that, instead of reading and writing from files on the system, it reads
> > from and writes to the object store using blobs.
>
> This seems like a reasonable capability to want from such a plumbing command.

Agreed.

> > This is in use at
> > GitHub to produce conflict diffs when a merge fails, and it seems
> > generally useful, so I'm sending it here.
>
> But...wouldn't you already have the conflicts generated when doing the
> merge and learning that it fails?  Why would you need to generate them
> again?

brian would know better than I do, but I believe the reason is because
the "attempt this merge" RPC is handled separately from the "show me the
merge conflict(s) at xyz path". Those probably could be combined
(obviating the need for this patch), but doing so is probably rather
complicated.

Since this feature is generally useful for callers that haven't already
completed a tree-level merge and really just care about the result of
merging a single path, I don't have any objections here.

Thanks,
Taylor
