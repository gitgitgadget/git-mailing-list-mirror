Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C41CF83
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dJHaNzMc"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F026DF
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:25:38 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a86b6391e9so46595927b3.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698697537; x=1699302337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+l447u0n6Tgi6orltG6V7ynepR9zCXhbuCoc1LoNPQ=;
        b=dJHaNzMccHAN4Ag83BnmZn5cbKlxxPk+mbwOYzrUgn3GvHcIeCu9dQN6UTcodFjrTN
         K9dxUkDL11v4mSVr69ZTyhO+2eWTG3rwiXZUst54gifIQfM9wYQjqk1t0oQD0t8s7i1l
         Nv3y0ftNVeByBgrVEwPFNIhTXAutSZlr0TVtfcZuHQz/Cy1S76dP9yl+G1v/a3VcdB6Z
         e3I2NRQMW4tweSZZUfeJpwol6act8VbPiV/9dhWljlezj37rslKa+F/SXCLGG/W6pqHR
         lVopgP2rFvXzU7eGVVkcrIA8+CbiALmYelJ7kiwZmH8DgjUZpP7ynDB5zQXXoGoIdoaC
         xneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697537; x=1699302337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+l447u0n6Tgi6orltG6V7ynepR9zCXhbuCoc1LoNPQ=;
        b=ZdsTDslIMFg/9VjSSKN0fHe+tnDAj9qLSHRwEzDWDIWmgetWomMdb0BKILFGv6F8SM
         4Kutee0examg9wwzweSI2C8/ETDq04yFyj8+S/bbUSXBfCOAw6I4rlc5cJgNOC5+TF7+
         Bggr4tfnoNMJ8+3j1oQIWJTK2E1s+Yi6CTl3unwSKjWbf/vQG+pj4Ha5UcENjLktYlPU
         IviaplhbM33OrNS9WXu3DuGHLF142YSP2FPebAtVTx78oqVvL0YuTTFz066xbP2T2mkJ
         XmCxtekIITq2exfS3hvKxeaNntnXYSBI/l3g39HU1uTlquDrPvYXdmk0w4dI6v34aE8b
         OCOw==
X-Gm-Message-State: AOJu0Yykl3JIctIcf7cjqGI84JeztmA8de7H1XrKMCaOfJUc9hXnblna
	vBgRs6b0vG4WN1VBxr0K+7FKNg==
X-Google-Smtp-Source: AGHT+IGr29WHl57rfsR7/HQmUAxMLlXBBU0aXfpErTlU7lZ1yR6Yv5P5p7h+KZv0cEnYmIoX/R16zg==
X-Received: by 2002:a81:b242:0:b0:5a7:bf2b:dc27 with SMTP id q63-20020a81b242000000b005a7bf2bdc27mr10751466ywh.14.1698697537303;
        Mon, 30 Oct 2023 13:25:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g137-20020a0ddd8f000000b005a7bf2aff15sm104685ywe.95.2023.10.30.13.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:25:37 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:25:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2] upload-pack: add tracing for fetches
Message-ID: <ZUARP/OhnENlIw4C@nand.local>
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
 <pull.1598.v2.git.1697577168128.gitgitgadget@gmail.com>
 <20231023185555.GD1537181@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023185555.GD1537181@coredump.intra.peff.net>

On Mon, Oct 23, 2023 at 02:55:55PM -0400, Jeff King wrote:
> On Tue, Oct 17, 2023 at 09:12:47PM +0000, Robert Coup via GitGitGadget wrote:
>
> > Information on how users are accessing hosted repositories can be
> > helpful to server operators. For example, being able to broadly
> > differentiate between fetches and initial clones; the use of shallow
> > repository features; or partial clone filters.
> >
> > a29263c (fetch-pack: add tracing for negotiation rounds, 2022-08-02)
> > added some information on have counts to fetch-pack itself to help
> > diagnose negotiation; but from a git-upload-pack (server) perspective,
> > there's no means of accessing such information without using
> > GIT_TRACE_PACKET to examine the protocol packets.
> >
> > Improve this by emitting a Trace2 JSON event from upload-pack with
> > summary information on the contents of a fetch request.
> >
> > * haves, wants, and want-ref counts can help determine (broadly) between
> >   fetches and clones, and the use of single-branch, etc.
> > * shallow clone depth, tip counts, and deepening options.
> > * any partial clone filter type.
> >
> > Signed-off-by: Robert Coup <robert@coup.net.nz>
> > ---
> >     upload-pack: add tracing for fetches
> >
> >
> >     Changes since V1
> >     ================
> >
> >      * Don't generate the JSON event unless Trace2 is active.
> >      * Code style fix.
>
> Thanks, the first bullet point there addressed my only concern.

Agreed, this looks great.

Thanks,
Taylor
