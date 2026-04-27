Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75731195C
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298353; cv=pass; b=nyldxMGYeUUY99ko2ZpzoOzX4JL+n4iPPScuTabTbcFDxitKIU9qagsP+7SJnMh+AMNk0RJAo1ppxdEzA/ckRNZ8poCjse9kQ1RShm3e7HQgGaAT1sS7C/IFpwRO+qFMnMDKrZMUF7/oKV50GgpqgV0fca5YzeVtnfAdPHd6h54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298353; c=relaxed/simple;
	bh=lqfY/65iN4KWWwEaoQnlILqvjbrHZBiX/YNLGh+Acgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9d6a0WFkS/xqWZ8NLidBisksUsGU5p0pptSRHQ8aQ/Nb34FnQeghy49MyRZ7xiCDWZA0Yi54a0iexURvLd78PkHUtCQ7pmU6hztj3baK638iAvhaZ5E3+KroMygzc42dWomuITuGFrJAf/b5Nn91KN008P++y2dNixTyObrPgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGtza+bl; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGtza+bl"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e9653b580so113405511fa.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 06:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777298349; cv=none;
        d=google.com; s=arc-20240605;
        b=LyYToibDQFtat2l3GLzYghWDyG/jTryllJRS992kqekzVg0QR9Z7QJxVmw8NeXGeYF
         yGSO9G7i5cR+10em+hUzDUsl29/QxWZlc4JWpt0Rpe9gdycAKaYA8scn2UU0A8X3zTDD
         VZHNX0Ij/MjSIEI1LUSzdaHykUu/nyvHPaQiSu9OYqMsNHfgI9tOAQWTy728n//8qWSQ
         sCzeUWIjn20j/HFMAkLqkHGwFj2NWvBAu+1LnNTD/7eaRdB+o6+YTBKE0XB4w6/ahjuj
         vvqwJ9i9C/LbhhFYC5UO9fvw2RaCRp+hxzOMWxc3DbeX2SBN+6YKXIKHItLNHyWln3EI
         QRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lqfY/65iN4KWWwEaoQnlILqvjbrHZBiX/YNLGh+Acgo=;
        fh=439TAajVyIx600SZu5PY7FeOPM5KB28236wdVQZA0e4=;
        b=lWTW70JRTVKeIwmSC0huRoJ/eL5AwSU6u9GRwVHHDFEzyaIg6aQLJy8wahypwl/Ixg
         qiguyjle6mOPkOkaYwNM5rCBjjSlv6qAYhGsHXNPP6aJSYgeiDwo10sgXNlUuE89GkQU
         2O3HgofcONTxalhs+jjaWkLdUlug1uORzWondKEZ3O3wVzbamsJz6USAzYeX8Fib3qIl
         j/SphJ7BWA4C75E0iESIfZf6QXCOsDyg8KiZemzj5NQHttSB1rF7+Iu8e6jWIyW+C9cP
         XL8DtB7xmICU1W6Ii+e3aVskuIACXowFj3/btKLbmkyJleF7wIhmLgqVD0f6b6InEDQo
         Q2sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777298349; x=1777903149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lqfY/65iN4KWWwEaoQnlILqvjbrHZBiX/YNLGh+Acgo=;
        b=mGtza+bljHC1/koTOXEQTVpaH4QytY8CAygqRF+UK8FlmL7gcI1QYivTx33yLgSmqD
         1fiQyzRdlTGmikGA5pxAH9ovzbKZ/8peTczHQDUY5wln4JGeua+MNWH9oCzI97+WQoIP
         CyiknexIfvq7oBJseF0Ncf8UkkdiFshgEGJN8RezOCud0QifEuAvso3kUIWNL58eCbpH
         aTuQjDpkWI3ESUgA8IbNfW8Wari0VgwAeLEajYcNPk8Xoiq11awuYtyKGQJ87jGccp9Q
         zUsoZHzrabiBoC3IItp8k52GbC+4QxrokhQGLkM9QTDq2NNX4NoESuL8Z/K76dOdvmDX
         7sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298349; x=1777903149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqfY/65iN4KWWwEaoQnlILqvjbrHZBiX/YNLGh+Acgo=;
        b=BLUNvk3P1K49hbnpJr/caK0xYQZ4aMan3cNFkZ7Lh+COywBrVu+dodab3Bi1qpIust
         4sJ0cufx8ssFuGU+Qmi7CbsLoAHJ+kY1uC1JqH2i43m4usYBzLqdrO0xI457Kh40JOBb
         JTom9zvrjKQjEoxESoPMcpotLwugO/x2VxP/Dy8yfH/bv4GYwvEH9s6AbPWALU1ImMYJ
         4jU/dySVCf3KTBM1RDSLVDv7ZHmWYpcrtpWQUOBmfqa0tBZBMNYMZ67uHbyAfnqnByFa
         EKlaFFSUV69TyVRJ+tlq2ojAHQtxl4s/uUaGO5Zmb4bHkE0kqqC29r3iHUckMWNoNyBy
         7i+w==
X-Forwarded-Encrypted: i=1; AFNElJ+H3MFDO1xRJOux/YJG6DMm2wPkuM1EjtKsFdlp6MyQufTF4upQmNaYJiHA5CuHZrECk68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XkLJgr7U6BTiQarFI5tfOIcnPvbC40yIMpkEHweNKKUgv+NQ
	u58EKWQW5uib0iYwVT1NEAR1KMaSAoJ7VAofp3HRx12Wxa9iLJ37Noktv/pM2wW0rJBiciBh37w
	e3ADivqOCUxcCEyL6w88n6sARGPeVs58=
X-Gm-Gg: AeBDiev5CRflodw96bVQNCZbPhNshyr/CFdKw9ec8nq0Cio4bEQzcBmbAYxR4cDyqap
	Gz8qkhnezAoNVgGJz2ZU50Zo67bVT2RIMQCzPGWvswJeSUatybcbn0kSrZW5eQhHJhYMnBcI4LK
	i0g/Q0MQofwzBd6GFnhWsL4wqoqm95uzsBvYQyftRuZbGkX5dSn7Vn60xCqppq7eb6e2wuOGqQW
	zQhGkN4JGYsOW9norWnUncpbecbXfoJ3BBBWjbqwlZoEJWtoWJbcj/c9PAlGGedylMNEtexq3z2
	OlGQgPUE77dSiON7qAk=
X-Received: by 2002:a2e:2e09:0:b0:38e:94e3:206e with SMTP id
 38308e7fff4ca-38ec7af74a5mr104170811fa.26.1777298348941; Mon, 27 Apr 2026
 06:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776984666.git.mroik@delayed.space> <cover.1777249165.git.mroik@delayed.space>
 <4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
 <xmqq8qa852b5.fsf@gitster.g> <971f19db-eb10-4c88-8d5d-3f4f7f92db73@kdbg.org> <xmqq1pg04mbt.fsf@gitster.g>
In-Reply-To: <xmqq1pg04mbt.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 27 Apr 2026 06:58:55 -0700
X-Gm-Features: AVHnY4Kf2v7k6w1AU9C7Ri3uQwHp3Z25O-xqWJuF8bVonLd7Tb1MORU40Ipx4Cw
Message-ID: <CAPx1GvcU8b7CfGrXxzZa10Ys2YScGq_2B4M9jkhs2SwywRP3AQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] revision.c: implement --reverse=before for walks
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, Ben Knoble <ben.knoble@gmail.com>, 
	Mirko Faina <mroik@delayed.space>
Content-Type: text/plain; charset="UTF-8"

This topic has been rattling around in my head for a while, and I need
to get it out now. :-)

First, a few notes:

 * I'm going to delete most of the context because I want to go back
to first principles here. Instead, I'll list what I think are the real
issues.

 * I have always had a suspicion that `--max-count` / `-n` was "done
wrong" in the first place, it's just that it's generally invisibly
wrong.

 * While all the revision-walking machinery normally shows commits
"newest first", there are several fundamental issues with defining
"newest" anyway. A lot of Git newcomers find this terribly confusing
-- usually a few weeks or months into use of Git, really.

It's important to note that the rev-walk machinery uses a priority
queue, and that this is necessary because commits are in a directed
graph, which cannot be presented linearly unless you're willing to:
(a) add additional information (graph drawing, parent list, whatever),
or (b) discard information. The `git log` and `git rev-list`
documentation skimp a bit on this.

There is of course nothing wrong with discarding information when it's
irrelevant. In fact, that's the whole point of abstraction, to toss
out irrelevancies so that one can concentrate only on the relevant.
And that's what all the limiting options for revision walking are for!

Sorting options affect the order in which items go into the priority
queue. Limiting options affect which items go in, and sometimes, how
many items come out. Display options affect what we see when the items
come out, and this includes the sorting options since they come out in
the order they're in there.

Thus, `--reverse` is a *display* option (part of sorting), while
`--max-count` is a *limiting* option. It's just that, well, there's a
special case when they're combined.

Junio noted:

> That makes two of us to suspect that this is more about --max-count than --reverse.

And that's really the case here. Because `--max-count` was "done
wrong" initially, we have a slight problem. Had it been done as a
"window of items in the priority queue", we would always have gotten
the limited-to-N items remaining in the queue after the selection
process, displayed according to the display process. But when the
display is going to be "in the order of items in the queue" and the
limiting count is N items *and* the display doesn't reverse the queue,
it suffices to display the first N items and then quit entirely. This
is of course a nice space-and-time optimization.

As it turns out, the only display option that causes this optimization
to be invalid is (or might be) `--reverse`.

Unfortunately, fixing the problem by simply defeating the "keep N
items in the queue and only stop early (and maybe display as we go as
well) if we're allowed" optimization -- the one that was applied
prematurely, as it were -- will change the existing behavior of `git
log -n 10 --reverse` in any repository with more than 10 commits in
it. Had the over-optimization not been done, and someone wanted to add
a "gather only N into the queue and then stop traversing, and then
display" option, we could perhaps use `--stop-walk-(after|at)=n` as a
new option.

As far as I can tell, the gripe that this exposes the priority queue
mechanism is valid, but at best trivial, because knowing about the
priority queue is crucial anyway. Beginners can skip it for a little
while, but as soon as they find out that commits have two separate
date stamps, and learn about `--date-order`, `--author-date-order`,
and `--topo-order`, they need to learn about the queue.

If it's deemed acceptable to change the historic behavior of
`--max-count` combined with `--reverse`, I'd suggest simply adding
`--stop-walk-after` (perhaps with a slightly different name) to take
over the historic behavior of `--max-count`, and make `--max-count`
not over-optimize. If not, I'd suggest a new option, with a note in
the documentation that `--max-count` has this odd behavior when
combined with `--reverse`. Perhaps the new option could be called
`--prio-queue-size=n`. The implementation can still optimize this
(using the same code as before) when `--reverse` isn't in effect,
since the effect is only visible with `--reverse`.

Chris
