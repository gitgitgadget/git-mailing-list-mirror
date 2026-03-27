Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2922D4DC
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627673; cv=pass; b=h9X2Z7m9ATC/VBs5u/fuie4nTQXfMCNsCOry4Y/7ZdjOpY8LGlkpNoNNmF948ypQfUeaB/erzj3m6NFo++9kdoRJyBG21UpGmOP2uMBqori/dIAgnfYuqr6HjyjolGOolxkYLCIslN/hbfJLclhxVPbOUalhOyFyOY6y2LZUQg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627673; c=relaxed/simple;
	bh=oJMZAYZ1Krta5Vxx2e/sUFcykFwanBQi6OUJVLiFo5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhWZMgxd+kCx841xo082v0MErnl3zjyMYLpH07mM9luM5xgFK6BNxk37Tugw2tEPFf99Cm9k+qMdpWmXPiDbPn6ytgEtB79VdKL3shJFxIObQo3OscDsEhgL+2E7oUKudJCZM7a744NG/9/mlWuwfHyg3FVu02/h/Kdhqig+QIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW5/too9; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW5/too9"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65006c99d38so35823d50.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 09:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774627671; cv=none;
        d=google.com; s=arc-20240605;
        b=gehPNEzwksyyTmrbgq5aPEiWmN03KyOz4TXFuRlxiw/136kNhamFjewX+/FFd1/0D4
         HDXcpwxUvBHVRWpjUt4svY2cUm+ZloQZmriZzQsZN5KqTBrvv9rzTf+qDpPCP+kmqT4o
         rAjU1foeWydQj7TVSWsXuqqqI7Tdx8xxEs1cxrPg05GnzQ12i7LTK098QdcphJGmSS9b
         H1ASOw/mp5ImhT1rWiRTOBOqpLTNmhw+ne+p7sly6AH7AEMKLLADSBADLHSUNUH4jMbD
         /TPKtiNuP/o9eWXwCXi62+aHICEaZTz4cQGHktoGmPSnGMvZ2INMjrxg1i9aP9kq57Wb
         QHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TShzBxfQWXo0WQq01J2UUTkAHgucWT2xdR/DVdcif0Q=;
        fh=EIe78UnJA+VVudPSM3+lTK73m4Wlx/m2JXEaQC4dc1k=;
        b=hbjsBJ9SACCtq97qPnySRAyLL+wbVC+gogc9Aw321i+XQyf7s5irT7oGkB3lvdcCNH
         XeUs5qHyj52KzFuUQSPJNfdYq+wB4n8AmaYtQwDdDyawcX4101yiiZjZF+rO3efZuxN4
         DnSJY7xlxbbno7bv8vQtIftKohk8HONqYsnwiLfu9izavcVBOkvw3FoG+msu+zfq4jJe
         b6TFokzCcM3+OA+3yMHkujavkjnZxgoh2gI5CL/3EaORLXC0mOUIASiN9QqBa5vi+uyO
         OwK4UH1HaShQN50FVI5lH/2hUdFZVGQsrOzK+Zb5/9kzVHgljNDoLh1XhnHoUK2R1vAR
         T8sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774627671; x=1775232471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TShzBxfQWXo0WQq01J2UUTkAHgucWT2xdR/DVdcif0Q=;
        b=HW5/too9w1I+jytrBarSeeXwpc131oIkr1ugTr3EMIpuDX7Z3fXKT/k33UwXGjwnxa
         EpgiO15PixtVJ+d17vHjLrf1KW3SBQvFUW0NLTGfFlo9lSVdxMcSNpWnCX/J3BDdtWKj
         8T2ZGBi6RBwzxdtQg+pp2TcNRMm1LtSt8X8DrEjHit87T6GthtN4+9clXoW+8O8dB4sg
         pbYCwVzZXhRgcOMocrwePHdOykFHc62RxIbpAwSf21KtjVULTTyCId4qkI8MvAmXuPUB
         7d8NOYSmFfyV+/0TndoVxTZqvmRJrfXObEumy3NQUrQvFx56JH2OTIC4XGhhz4Qnfm09
         p8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627671; x=1775232471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TShzBxfQWXo0WQq01J2UUTkAHgucWT2xdR/DVdcif0Q=;
        b=Nq1pFsMxV0gzFWgFUpXE0OfCqQq4V/H5gbXaG0W1zB0T0bXzMz5tixpe50LnZH6++P
         HsaLbk6Y44GH0gYSkaksYjHZns61R4oXFq6RcsS59JXOGiHEmODhv+MBGO6lSz87w7jJ
         YZb7p67h6tgxHEejBcl09gboK4K1b9SxMkfYZU5HdBe2IqKJUUh22gOlXz2TRSfU7cuV
         VCamdG+aOhbPolX3TWRVI6atXIH3Nipx5Jz8vo/DVyAo+k98W/qW/tf6tBIlgiRXy7ZK
         PxildhxSOLA4iS5SP7tKqGYU2hsE7RfeI8Lf97WR4E6hgSGHd8WBSJhodiRkY7sfnj1M
         Rk6A==
X-Gm-Message-State: AOJu0YysawnT2wcYb1kw55Jo/LNLPJT8nA9c2bDguqnsvyrh5+krmRWH
	9ZEI8QZ0L+LStHTJTNMqX48ahxWTwUgi3vBLtMOMktJm6FqiddIJylNamEXY1rUi9C+yHsglWbT
	U0yGYat9F0LU0hmn410SYv5GS0a94KKo=
X-Gm-Gg: ATEYQzwVYRFvpbmANCKBgbUZyBt6ESEWWEjlaC1fpt50THn64R/oZhzFsRmd/9WlFaC
	fZJZ9d5ZgUL4gIrdvUQ/+ysyUimZd6X1EF0XbNGokD94S7CZWyc1EO8MuI+wt/ditpNF3iCI82L
	HJJ4gmcjAnHlcbuk7Rmw/PVvKXmiUs4Fzg7FNw7yaEXcSOTVEPMZhYHJmbxK7XTbdsrg8VMZzYX
	GfPNNmCcJf8AR4pZ6jWKQqIc/ffvirH5Hd97BhTiSsmV/rP3Pw1TE1y3JAaDPx84TxnpREuXbTL
	u4bJDFEdV0xI64WG2dC9se8R3iiKvLMjKMTlAuuBsVgwhrHSfzaqeO6aycGL2+qEgSbF+m2+uwQ
	RVg2hFv71xVjYhpIhHazj5GM=
X-Received: by 2002:a05:690c:101:b0:796:3917:729a with SMTP id
 00721157ae682-79bde06ba42mr27782717b3.53.1774627671277; Fri, 27 Mar 2026
 09:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <20260325174401.217577-1-pabloosabaterr@gmail.com> <20260325174401.217577-2-pabloosabaterr@gmail.com>
 <xmqqh5q3sgnm.fsf@gitster.g> <CAN5EUNSyBjpZHHAAd1YGVRjkLwzgGzpafhBJVTTcHJCLKNU2gQ@mail.gmail.com>
In-Reply-To: <CAN5EUNSyBjpZHHAAd1YGVRjkLwzgGzpafhBJVTTcHJCLKNU2gQ@mail.gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Fri, 27 Mar 2026 17:07:34 +0100
X-Gm-Features: AQROBzAgSfpE7aJjEaizvF7B0nlsrsx9EZ9xrP0F1WCk65M7dGe4iyGPkakNWA0
Message-ID: <CAN5EUNSuVNPfC5bChw7ocBJD5_ObsAvVv9Q=jaD6v_go4e9nyg@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 1/2] graph: add --graph-lane-limit option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, j6t@kdbg.org, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"

Pablo (<pabloosabaterr@gmail.com>) writes:

> > > +                     graph_line_addstr(line, "~ ");
> > > +                     break;
> > > +             }
> > > +
> > >               graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
> > >       }
> > >
> >
> > > +     if (graph->num_parents > 1) {
> > > +             if (!graph_needs_truncation(graph, graph->commit_index)) {
> > > +                     graph_update_state(graph, GRAPH_POST_MERGE);
> > > +             } else {
> > > +                     struct commit_list *first_parent = first_interesting_parent(graph);
> > > +                     int first_parent_col = graph_find_new_column_by_commit(graph, first_parent->item);
> >
> > Are we sure that first_interesting_parent() will always give us a
> > non-NULL pointer?
>
> my bad, first_interestign_parent() can be a NULL, will add a check for that

Actually, I've been looking and first_interesting_parent() can't
return NULL here because: num_parents is counted using
first_interesting_parent()/next_interesting_parent() so if num_parents
> 1 it guarantees that first_interesting_parent() is non-NULL. I'll
add a BUG() to have it reflected on the code.

Pablo
