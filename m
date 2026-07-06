Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B973F5BE4
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331403; cv=pass; b=p9dyAh5UrjDYvlxigF1s8fYZasi5QRuqTv80953CFdVlR3ZNjHWKPADef1bjNJcX/WB/LeH7YZ2p4Y+oFUbycpG4HQWRgHuxY+CZQSjntS56TTfTYYPjnqJrQe+9cqzKJ0jl+kO9IA93f5v64EELYuFouYvHY3ARsW+WXCip+zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331403; c=relaxed/simple;
	bh=LivgLi0wUmj8Vvhpx0utCHKrvSip4schWTQKxDgZAa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqTPHzluTP9BGyEqGkbk38ad2fwCdC5mG5WCauqng3DIWVvQ2ZNfSAaGecadoGzMsBiRfQ/7uydRdCKBRAFoYpSF2NKbwwT3PtqMAoD0wBMCfBA6DQgRPeYhNpxEr+x+zVNjeBp5Bb7xTUCDy5BP4Pgl9yMKGLDEdK5+684Wt2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdGPdumo; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdGPdumo"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso3456747a12.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 02:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783331397; cv=none;
        d=google.com; s=arc-20260327;
        b=M7UnIjEQBeIvDHQEWAkjDrJ86RUnHdPjAh9ZweGaNcRwZgmn8ABnFlbjDQsJ9AEuuo
         t4paw1OII2vVVEPpNDCCv6Fo4r5pfaK00VkB/P7yoah83J8xAnJfzv0RDOGNMKHhurbL
         uIdXSUEOet11S9ROfUGwOX8A7va2zH+R6+SKVWFlI67C5EfUqE63pIvbzwJKKSABOBo5
         faR3PJF8Y6MkoxYYwBf88xBOCiyKvbY8EcWLG0oMpVY62xUmYOZq2amvDeYvHCvqO0pb
         YwhjgEt+FpJ6ZLe4i6YQENI0WrqpKT7a2w45erno8+7yQbf7kLj/7JPkmbDsjDuy3gxt
         /2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6WzBvGIFzObn82lXysx4G5BBtt/3RKpY+O2JrBw7r5A=;
        fh=yV8IZXb85bzDVjuLmU51Ff1zSYMZwIrignbbvNfYfPY=;
        b=c5XdRrm0Vo+/Athmg2c0bgVmuN/XHev6vHjtZ7q8Qg8ArizLjTWUJon4G23TtDvrma
         ITpDb9kcfX7mpzFKl8EZ2wtTaZHg6btjKh+aaj4czV0SQwDlWJmxnddN2XN7i3ivfdFZ
         sgoL0iellJJXcdBOJ7TBfYIt8bNt2LbGpYptj55ukM+Ju0ijTngZvkuv7t4HEKHKt8dU
         g+YPrBJlvZc90e/Jg6NW1V+xTXD6ldKfvU61tlS0+nB80booTTpt9iNeNWTjFKm8/9mE
         BcCZTlsAu0Gfq6yy3ZdJgGQdQzKqterx8f5s8w9SuWtXzpFmQMrWnvsJuL1DgiPzu/yp
         oN/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783331397; x=1783936197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6WzBvGIFzObn82lXysx4G5BBtt/3RKpY+O2JrBw7r5A=;
        b=BdGPdumorZNwfxenpigGclZP4NyGPwU3ojZ9V3Id/j1jrIPcj+lJ2/CQyibGV6SmYO
         WpuHtMZz1Hi4F5T5a2ASITSGIaT5eWCDOaiiYExL3aq7dnK2DZECRe849zPDb0EsgoQh
         fuez4PmVBEmCoXVyErvpNNYIOeWhLYDlUKNj1F1qE/GjfmNXiF6wNDgryVyyphmUAlVk
         4aFigZSuILgcXmqbYBhdf7BzNc4sd5CMHeC3bzEFf50IGqZBRUNyg3RjIVetuPYyfo5h
         kZAYf1MjqxiVSXg1Hs2mu/gcQM9DQxYsxmDCH6VgrwWjrF7XLVSIte+NeYtvBQO0QGOb
         6cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783331397; x=1783936197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WzBvGIFzObn82lXysx4G5BBtt/3RKpY+O2JrBw7r5A=;
        b=DoRSiMEdPu3awnaiNmJfgk1AdG6T4+B0BcUnQpJwjK7e8xW/sge68WYgDtQovyPv9t
         Jic50ZeS7nGi51qABV2p0NJlxt0mTbtUUqUfT/KT0ppp10Ij+/mudnYhyYT78fH04xiU
         3FRni5cBgXisv7/mnu+3YY6JTxaAlW5cZWqj9CIgF4VpHSBJ4fwzx49cT1baS4zI1wbu
         ir4L2hTrA3d6cQP+7qLVIB0WzRvds7cVoY3TiynQ82yNBruaeWyWC+Vb5Ttdu70bWa4D
         D493VJJfJMxJCZhcCN5qox3YW5gGEAPIqs+vUaEnNEvR5bX2x8rMkLeYe7/ouRToyE7L
         PfVA==
X-Gm-Message-State: AOJu0YyfLdUxVeE2xThvfLmiJKOYTM0cuu2IkCMUeA4tM65Ku2O+r2Dk
	vSAqe6MnRs5wFO0Z4lCPkf00qur7pcdB3NXXGcyY7XbXJR/mFr2DhHNlAkSDg2PllX51nPZSwSs
	IhU/UKbagLld3HHCUcxhTuiYfIFRqhqBXAyRuRlY=
X-Gm-Gg: AfdE7cn/2SvH/+uRao2QV7FORzIlk/sfEkke0Dg/Mjx5bR/Cod/BCX2YKMc51sGQtRf
	FZZeX4Z1YDKoSZ62HlVoJP0TiYj3LfmDhAO/V+j40Uf3dWQd/cQa+eNPz3PKvRL+dqgp/i7Nplv
	Z+sgkT1kX9pKJeE6/D49FO2VjOVRmGWJNZRrgC32LGDSO+cxevNkpqiToClKUd+ILqj86DkihVf
	5OwYvUMK7t6X66nq60xe9jjFp2Gy0zvHisI9wb2MeIUYB95/4Vvlnv4pHw5delBk7lDXabPXz3c
	xREZrViYRYkTdktxJxSjyC4r/gIpzy9kTwxTqonmQtibqhFLQdKDgj/bUcpGgK80UVVvKNwBOIl
	2aX+K7OraLx8=
X-Received: by 2002:a05:6402:4444:b0:697:decc:7f9a with SMTP id
 4fb4d7f45d1cf-69a1a26059emr3361262a12.9.1783331396969; Mon, 06 Jul 2026
 02:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
 <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com> <20260704-ps-pre-commit-indent-v7-2-a94706cc8376@gmail.com>
In-Reply-To: <20260704-ps-pre-commit-indent-v7-2-a94706cc8376@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 6 Jul 2026 15:19:31 +0530
X-Gm-Features: AVVi8CczGqA10sKJfiuRwwvH2NiC43Zr8uvyI6YrK2XOggJ6S5g3UPVo0C8HWfY
Message-ID: <CA+J6zkQFsTA3QfU5VVjQ=KhJCg_pCrTgW9zinAUC4D9YwsyOkQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] graph: add a 2 commit buffer for lookahead
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, christian.couder@gmail.com, 
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com, 
	krka@spotify.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 Jul 2026 at 14:24, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> In a subsequent commit the graph renderer needs to know if the next
> commit is a visual root or if it is the last commit to be shown. This
> requires peeking 2 commits ahead.
>
> Commits are pre-fetched at get_revision_internal() where they are also
> marked as SHOWN.
>
> Update graph_is_interesting() so it considers commits inside the
> lookahead as interesting as well.

Nit: lookahead -> lookahead buffer.

> Helped-by: Kristofer Karlsson <krka@spotify.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  graph.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  graph.h    | 17 +++++++++++++++++
>  revision.c | 17 ++++++++++++++++-
>  3 files changed, 80 insertions(+), 1 deletion(-)
>
> diff --git a/graph.c b/graph.c
> index 842282685f..300ae67669 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -315,6 +315,14 @@ struct git_graph {
>          * diff_output_prefix_callback().
>          */
>         struct strbuf prefix_buf;
> +
> +       /*
> +        * Lookahead buffer: up to 2 pre-fetched commits that will be shown.
> +        * Populated by get_revision() so graph_peek_next_visible() can use
> +        * actual walk results instead of peeking at rev_info internals.
> +        */
> +       struct commit *lookahead[2];
> +       int lookahead_nr;
>  };
>
>  static inline int graph_needs_truncation(struct git_graph *graph, int lane)
> @@ -388,6 +396,9 @@ struct git_graph *graph_init(struct rev_info *opt)
>         graph->num_columns = 0;
>         graph->num_new_columns = 0;
>         graph->mapping_size = 0;
> +       graph->lookahead[0] = NULL;
> +       graph->lookahead[1] = NULL;

Style: Manually NULLing out each entry doesn't look quite right to me.
Maybe do something like this instead?

memset(graph->lookahead, 0, sizeof(graph->lookahead));

Although for an array of only two elements, manually NULLing is still quite
readable and avoids the minor function-call overhead of memset().

Feel free to ignore this if you want.

> +       graph->lookahead_nr = 0;
>         /*
>          * Start the column color at the maximum value, since we'll
>          * always increment it for the first commit we output.
> @@ -456,6 +467,15 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
>   */
>  static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
>  {
> +       /*
> +        * Commits in the lookahead buffer have been pre-fetched by
> +        * get_revision() and will be shown in the future. They already
> +        * have the SHOWN flag set by get_revision_internal(), but the
> +        * graph still needs to treat them as interesting parents.
> +        */
> +       for (int i = 0; i < graph->lookahead_nr; i++)
> +               if (graph->lookahead[i] == commit)
> +                       return 1;
>         /*
>          * If revs->boundary is set, commits whose children have
>          * been shown are always interesting, even if they have the
> @@ -763,6 +783,33 @@ static int graph_needs_pre_commit_line(struct git_graph *graph)
>                graph->expansion_row < graph_num_expansion_rows(graph);
>  }
>
> +struct commit *graph_pop_lookahead(struct git_graph *graph)
> +{
> +       struct commit *c;
> +
> +       if (!graph->lookahead_nr)
> +               return NULL;
> +
> +       c = graph->lookahead[0];
> +       graph->lookahead[0] = graph->lookahead[1];
> +       graph->lookahead[1] = NULL;

Do we need to NULL out the retrieved buffer entries? If so, it is
worthwhile asserting that the entire buffer is NULLed out in the
!graph->lookahead_nr check above.

> +       graph->lookahead_nr--;
> +       return c;
> +}

Not the best engineering practice, but I guess it is fine to constrain
the logic to _only_ a 2-entry buffer since that's what we'll always
deal with anyway.

> +
> +int graph_get_lookahead_room(struct git_graph *graph)
> +{
> +       return 2 - graph->lookahead_nr;

We should use ARRAY_SIZE(graph->lookahead) instead of hardcoding
the value 2.
[snip]
