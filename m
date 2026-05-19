Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6234DCD6
	for <git@vger.kernel.org>; Tue, 19 May 2026 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170402; cv=pass; b=NbAOHtism+0m0p2m5gpFbxsK9iU4UIWkp3PKCVwNM3/wIKvbWIFeEBt+rhpe3sFY6nMKpPjo+XzI+x3NGzfAJ9uz5Y0+dNafES6taIq/SUGG/edhjSppAcnABTrVU3vIf5AY0an6IqxQvTv75X3NxWjY9U0fICXC/n3BDJEhpc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170402; c=relaxed/simple;
	bh=o5r6rIUaDzW9xVzPUw4wVUQsnC+bC9ZSJrwdlxyGQOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyegCOdPPhgzPJYDF12vQJ0dxpZMzGq/FaUxRvosD19zVM2gf7S73Rj5zMp0fLMNvtDgIJdErDg4UyrPJeG40azvqsY74IpfijPy6tOjKucSs3aYtg9hZp6OCoU/xKq80G1zMTkMy5QxNCkFn6l/ofi5lSrQgFAQ6F9sMxEnIGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNJNKZt7; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNJNKZt7"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bf14e33f5bso25916127b3.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 23:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779170400; cv=none;
        d=google.com; s=arc-20240605;
        b=GKdvqFZcb0ckEwMMZi9cZYL3pTY+MJX4PwAOfMf51DdorpR0N7kYzSnIezOsCR2W/g
         RV65c+Xr7baDBjd61omhq6HHwbGzdlhtQVJrmFzl/u29EEu0QqUKk5IRuiTM/Tju963A
         dsiExn/q2sPQblbCsT3W05lzwrOI1Q1hdEh5KBScvUszUQcE8IEQNvCFsPwOM17m633/
         toOukFVk6TMUpOp6TV68yVVw8mrfWoD9J7AnvziNWbjwu7wZsW58XQMqbOaJfvit/KSL
         8joKW5FVWxqJjIB4vQ/HIAP/6+sqDJbf5ZdTMHtmNtn/K8CJ3LCPUFd7XYQJPKSJjN8c
         flVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K8tOWIqjfCwq98U+LLTmwGdSYPrNMG12Ua5g47zFLKo=;
        fh=zBnTKckBWgXjsgzh6r1tKsaPxhL7mqfawWgyQSWFZA0=;
        b=JGkf5vO8nUiSQyvA7WsL9fx8rCgRWSyRbU1KGPbBiEIh5XDcF/x3SSxDA9yiQMC0Mt
         6jVxpE21PbwT9uxnLPeetMLodiSbg/E9Q46e7YxfsnT2FFXAZglgDz6i9+BhIqo9mnJl
         vOZzl5C53dnNmn5sOlkSfem0dZvgMHNiWJSr3QnGB7SG1INRzA3rXi0rx6GmDNAP1nxI
         Hoh5X8+SfrCbTNRFmEL5TfXjbl0H32yJ44IgTGi67HGFc5FtmxEA81Zx7EjP1N5yUCg2
         dSJqQs3Yov7mNnVfskoQuIDkCWQ0kFBunKxNlWc2gLH1duB0m+owVNwYopRqlxec2NnE
         PbEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779170400; x=1779775200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8tOWIqjfCwq98U+LLTmwGdSYPrNMG12Ua5g47zFLKo=;
        b=PNJNKZt7M2uzffuIe1tBg8AvP245boBdt3Qfd6epjGQNzXTPPjN/WQ5y7z/HEGiSCJ
         +QQS3fYfSwYPqMmpGiQpSB5WMmsD2AI3rA4TCevLVsKdUO71Gq/7PdDBwQHqOGjbzMjY
         oJN8hBicfmhUImNtarDQueu8d3N0KXcx2RtP0Nlsds4jBcrMLpNTxdlPyBu5/WNpo1sp
         mI8zGn59xZhf80u6dTmAJMdsPuyzpqaQTLgdB+zpK3OonbEFp98Xv+zjyzz5LYdTYhCh
         lZ1S5wq/Ar0nMkkg1WPUHRB+4R9DpGsgOiTLu/6Q9GEy6olunJQ5D3dQo3IDNb+9Gf61
         iVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779170400; x=1779775200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8tOWIqjfCwq98U+LLTmwGdSYPrNMG12Ua5g47zFLKo=;
        b=ljzi0UnBfiOLXN/O0kLYlD7lpahyWcZDnqNToEfWWVAgPq8O7ph+Td/FuifW8NxJGL
         z1M/TLAk7yAoF1q3hiyWyxPYPnl4AnggeRRqiMdwHNcUoPR+rSouW4FGv9DScn6IWmsh
         SVDeuElE7ArNlRa1LjnCTG+j1OqpF9AxBefqKVUCl3n2iJMKp9FrLXnBp8/00Y6AG4PA
         KsTGnuauTAly2JYjSmMF71uBeZujPcEBQMlmo/8DAfZvYIDxv4Z7bbV98i5ZZEwIu9Nq
         eIZegh0p+rHhVd/ILeLpWdW4eXKbxFnSPzDJZF82M9IJgAngoYrso5wgTqxqZMBYev1q
         UWkA==
X-Forwarded-Encrypted: i=1; AFNElJ9p13fhb9PsYPmunnK9os/VW1cQjMu+f6Pj8i0zqw5S6MDXuLh6Bhxzf5YMabcOXDy8S4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UGu+Yl0tbcbzIx6updnrLNYmWJu93000TteR524v3wbPtL1T
	ihp2pIPxN9Hen4w3OwCNTou9K8b0mr2gC77o4AOMiVwA5y42vAmETQNG8w5dTjwxkXMEsijS1Y6
	i9jee9iLtd1wEf6yk0LlQGRoZGgWfNFQ=
X-Gm-Gg: Acq92OHhnPA196wQ3o7x2ZgQBMBfFh4KiH2/AD0YDxXsoKDusHnS5e66F5iPG/CEmrn
	n4IqRDQPji0sTXao7JVCir+vaDuGWfePLfzlQMTxF/aUld2wPLOammYz0XuFjp7ensswGDsV0Jy
	PVtcLV1Owxj5QFfTLGYKaTeNzrRKe+908UF8CIELQI37/NNfAqP294aRE2gvVmp6rTvDu58uV1a
	8E4GfOsbRgATMMr7aTEd521RbRaOvGCNoq+kxxmBmdDlnlvL8XL717JnlZaDYLeeM0H3b0CUwQy
	fMVJ4p8oGkTqlBOwlXPeBPO1zLmqS/h1DHiVz7DqhCP0nC/9UI/Hv1qdKTBhV5UA1pqgd5gGJyI
	15Xo1aQFePHPlsRkrpsC12iBFY3Eohje7gdz41a3p0Rysahhh9mbaj1clwevrvd66m53Hpm29Rj
	xF9uIWWgduOnI0rWOu
X-Received: by 2002:a05:690c:64c8:b0:7bd:5b06:b35e with SMTP id
 00721157ae682-7c95c9ede3fmr189920667b3.47.1779170399980; Mon, 18 May 2026
 22:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
 <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com> <CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
 <2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com> <CA+J6zkTGgeNuH0eusTy+t8LO3bjygSz4svJB=K4R5ASmBdd0uQ@mail.gmail.com>
 <CAN5EUNQoKRqt3FGLmzRGpPU1nO5jCAogP8Wm9gBZXuPbMNbQAw@mail.gmail.com> <xmqq8q9gb704.fsf@gitster.g>
In-Reply-To: <xmqq8q9gb704.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 19 May 2026 07:59:43 +0200
X-Gm-Features: AVHnY4JnC77IAjcHlLJUAqSwSvio_dom8OcIaEpeBpgf7PjVhWO3YyD7SIBPQxE
Message-ID: <CAN5EUNSFBC0+aoW1ceGjEiKWBRjzuzUEUjg8Xys5O9rDsJdkjg@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 19 may 2026 a las 2:03, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > By having is_parentless as a flag in 'git_graph' that every stage can
> > access we could modify the rendering and maybe completely drop the
> > commit placeholders, working on it for v4 but currently renders like
> > this
> >
> >     * A parentless
> >       * B parentless
> >         * C parentless
> >   * D1 child
> >   * D parentless
> >
> > (A has indentation when it could not have, but that would require a
> > lookahead if the next commit is also parentless)
> > But definitely a step forward.
> >
> > Do we want cascading or just a fixed indentation?
> >
> >     * A parentless
> >     * B parentless
> >     * C parentless
> >   * D1 child
> >   * D parentless
>
> I am late to the party, but I cannot get how the latter is viable.
> If "A" had parent "B" whose parent was "C" that is root, wouldn't we
> see the same output?  Or are we adding " parentless" at the end of
> the one-liner log message?

We wouldn't see the same output because A and B wouldn't get padded in
that case. Vertical adjacency between indented commits doesn't imply
relation because indentation means that they are "parentless",
ambiguity happens when there's no indentation, you can't know whether
they are related or not, but knowing that every indented commit is a
"parentless" eliminates the ambiguity.

* A child
* B child
 \
  * C parentless
* D1 child
* D parentless

Some different cases:

A child
 \
  B parentless
C parentless

  A parentless
  B parentless
C parentless

C has no indentation because if there's nothing to render below,
indentation is disabled.

  A parentless
B child
C parentless

Anyways, having more than 2 "parentless" commits one after the other
is strange. Cascading is just having a depth counter and printing the
padding depth times, so I'll keep it as it is more intuitive.
>
> The former, with the understanding that "two '*' commit marks
> vertically adjacent have parent-child relationship, otherwise we
> draw line between '*' to connect them if they have parent-child
> relationship", does not have such a problem.
