Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789B39099A
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116908; cv=pass; b=kWMGzVv+atyG9rG337puZnaG4Jpn68A1CRgUD/I+M61QVMmegf4d4N+FqwMBehBgU1MvZhFjgX91MJ7KWJM+QDwByn7emizYstosWCmZJJOYBAFRC1l3zb1RQSgrX+S0Xl6zmtxQpDyY4HqTicIyFtNhagxtdgoOYbhmncD2qCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116908; c=relaxed/simple;
	bh=YujmwRxWWqeDxf89ITfgDhtq/tzqsOqEHp2jok2EsrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3WKwCrlwh+VpbqUeL8ycKcBA16KxIY3aBv2kHR//s4+sWqtqi9BtonmU/F/W8CTV2KmTxxs8a2J5XaAIkfqY8s8peoSfOwLqAc/vbjN9M+i3nglzPWmtR32CGo7YZTD9fbqB9nIjYXWHfS+xTa7qTJQrH7SUPRDy6O/zfwBov4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=c2F7O0AV; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="c2F7O0AV"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7dd5a8dc8a2so28950377b3.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 01:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782116902; cv=none;
        d=google.com; s=arc-20240605;
        b=A44f4LVAgdFBfc3aQuGm3ir3w7RPQfK7tqYNDdz12ymR4TnKVScPQKMb/DSwDzOHWW
         eEJhJosyEz6iafnnSTl8BDM6oOa/FDMJeB0L9MAA7R6k99QAvezR2No5iYrNCyHebxNs
         v5Wdbg6h+LAzUM7fJxKOBQrPEkDwkdWEhJUC8vUmA2thXUj6W7QprpM0Ku4tPpE/YwiV
         fuLtNN+gKvToyCt9xbWRjURszmZ5tbo8b07Y0DrT8NXI+JxSSL4Lm65tg7ir+FV1aYwu
         jKz/5/NDCO15GtoOXdb+hLV5fN3gI6n0XOqQjp4ALO3ssiGiF2Q9TTlwYV06q11Gv9cB
         VY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MMeoxNlm25Nl9IJOtYr7rCTjWDfDpjhp1MDWPw4G79s=;
        fh=nuyRHzHN6fCAiJG0nMbGOwwc7QFrNnAoCEUCeaODPUM=;
        b=kbxzEMVni+pKR0oc4ZKb8gJvoykw2IwrYlO2hpss59mxhmOT9MOFKJQDa+7SiGcC9o
         /J2diXP5zd+9+5+Pxpi35AVEomFn77zEtFDmUjv5jmDXAW1AJRoEHAtkmldRBLV5272w
         UXQcyfvwA06nL96Eq/0vAygEAc7UVHsXD9MANH6g3TJEfgMt1GDK16zAzjhdN72Jzp2z
         mm5R8KDh/B0CdTcSNApiPZlOm1QhuXVIfbBxVajqwu/tp61Ji2VFNIIXpefiN1MoBCrY
         PLhWenfzWEL0Z6ElWzi+YMyU7ZvFPZy+VGuDdMOiaxnWy0TV55BsCKFtvRjiF1JpHrDH
         Y6+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782116902; x=1782721702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MMeoxNlm25Nl9IJOtYr7rCTjWDfDpjhp1MDWPw4G79s=;
        b=c2F7O0AVMYCuBKEVCCntu5CGPIBRLoxnopsa/u/Q/ZgfylhkX0aboATad72vqiPntV
         UaZRgSH9ZE8DnHbEdYxp7safEBjgNt2HcwyTHibathdDZaVAVfBllnv08MO9U3dndoZj
         AXN7oj4B6qYEOdMVcJJZPBzZDAFNVwLQybSAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116902; x=1782721702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMeoxNlm25Nl9IJOtYr7rCTjWDfDpjhp1MDWPw4G79s=;
        b=dWJKby+A0ZPW6snIOvSyZXqFhoEsVoOTB7E+BmzQLIhzlyU4oWI5XBaYFHjBgdqj1S
         Uv3+8GpyeGY7TaXYtANqECRmNsNlN3j+nNHdsBgeEH3cDSLEebVuPLL3AIzu2d65Sc6L
         TKnkBQQ2ZV7W4dL410TD1RPcofqd1pjYmjriB1ODsHfs+6760ar91d+pZdwy7lKImXg9
         acDsOItyO12pC4elwNNCNpB20r31MGbRK0+ItEmdwXWQQN5Aq8ts5N+fDmG4qp7/O9Ru
         tm7CYfZoR6p1GjzvJPKO8fAOeB29nEa6VNIv3ReEn6J24umRFBbtslsnRcjlUzlaAf9q
         jztQ==
X-Gm-Message-State: AOJu0Yxtumn5T82vVub8GH+BqKeDRMHytmok/GTHKcbLZY2GEqIV2qMH
	ENGx512TbKW4FU6IlGHQXJ7ZD9ItpiCU8U86iCJ8X3xPiJihsPdTjwkmFzITxy27hswEfTtIBDM
	Da7ddLCiz8wsHL/UINlrYaQJMDGCOJzOfEgYIJxFHFA==
X-Gm-Gg: AfdE7cnosZg1kr8m0WYzzMZ0uLRzXDw6YOX4gc6XLSxouR4ZnTMlcdiH6ZiWzffxy+q
	uYtAT2AR30bfiUnBzo34zbGn8WRaXdl/YEy7sreqaHt3Sqy88u+C0Ycqw6p1sCJDtC7oNmhs56h
	MKMYCEQM0R5jynL9LuQ7VVz0ITeHvCog9IIcWXQ9wXgQtlmZfJCwrSh60pesenGzXsJSAcI9EhP
	cd7ZY3oyZdmrhK06dAc84DNClfX+DrtI4KIsArlKh67wYU8tlhh8eV35kqx9z0LVf/uAJ3aLA==
X-Received: by 2002:a05:690e:1905:b0:65d:bbff:41c8 with SMTP id
 956f58d0204a3-662ffc56de0mr11034012d50.4.1782116901900; Mon, 22 Jun 2026
 01:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com> <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
In-Reply-To: <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 22 Jun 2026 10:28:11 +0200
X-Gm-Features: AVVi8CcFwBmGLHE3yYl_L6shNaaSKNK7Ri6ueWJg8Uypc9MbLxk720KZg6dZHLY
Message-ID: <CAL71e4OQ_kGb+UwHgikHG236-8BVtc7P9OdpV4i4UzYRCoPczw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] revision: add peek functions for lookahead
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, chandrapratap3519@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com, Kristofer Karlsson <stoansen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> On Sat, 21 Jun 2026, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
> The graph code in a subsequent commit needs to be able to look ahead in
> order to set indentation-related flags.
>
> Using revs->commits is brittle and the data structure that holds the
> pending commits might change in the future.
>
> Add two functions that abstract this for the graph.

The abstraction is a step in the right direction, but I think
there is a deeper issue with the peek-based approach. I tried
to understand the problem and ended up with an alternative that
I think is simpler and also fixes the three test_expect_failure
cases in t4218.

> +struct commit *revision_peek_next_commit (struct rev_info *revs)

> +int revision_has_commits_after (struct rev_info *revs, int n)
> +{
> +               for (size_t i = 0; i < info->topo_queue.nr && visible < n; i++) {
> +                       struct commit *c = info->topo_queue.array[i].data;
> +                       if (get_commit_action(revs, c) == commit_show)
> +                               visible++;

Scanning the pending queue does not work, because it may not contain
all relevant entries yet. Processing the first entry in the queue may
affect the second entry.

There is also a second problem: commits in the queue have not
been through simplify_commit() yet, so their parent lists are
still the raw ones. graph_is_visual_root_candidate() checks
"parents == NULL", but with a pathspec filter a commit's
TREESAME parent might get removed by simplification, turning
the commit into a visual root. Peeking at the raw queue misses
this, which is the cause of the t4218 test_expect_failure cases.

The solution is to skip peeking entirely and instead call
get_revision_internal() to populate a small lookahead buffer -
it only needs two slots.

    struct git_graph {
        // ...
        struct commit *lookahead[2];
        int lookahead_nr;
    }

    while (revs->graph->lookahead_nr < 2) {
        struct commit *next = get_revision_internal(revs);
        if (!next)
            break;
        graph_push_lookahead(revs->graph, next);
    }

After prototyping this locally, the three test_expect_failure
cases in t4218 went away (though I had to do some minor tweaks
to ensure it become fully deterministic by ticking the commit
timestamps.

One subtlety worth mentioning: get_revision_internal() sets
SHOWN on commits, so lookahead commits are marked SHOWN before
graph_update() processes them. This makes graph_is_interesting()
think they are already displayed. The fix is a small check in
graph_is_interesting() that recognizes commits in the lookahead
buffer as interesting regardless of their SHOWN flag.

    for (i = 0; i < graph->lookahead_nr; i++)
        if (graph->lookahead[i] == commit)
            return 1;
    // other checks after this ...

This approach ultimately removes the need for
revision_peek_next_commit() and revision_has_commits_after()
entirely - the graph code no longer needs to peek
at rev_info internals.

Kristofer
