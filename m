Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97B3F4129
	for <git@vger.kernel.org>; Wed, 13 May 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686945; cv=pass; b=pgewm041XWS3etU1l0vTLZdbbFH/bKYmbetxrGe8VmovhQ5d0LbuqaqmF5YQVB5kT8j0qa3OqCTQxtoIepTdT0K1MjtKpJpor+IIBB+VfHdTXZfw4hGsuYEXSk1mX2zvHy1UNNy37cIgUZY5kCwwBVcZYGV9Z4GESqAqk35C3sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686945; c=relaxed/simple;
	bh=yncWKZbUvUrZ9A35wc57dTi3JJRlKIOmA6nQb78mu6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQx2HwQkXZgGCiS9Ji0DvzWlgTyg/igONsA0FwjxHbdeOxE73Z1p1+avho0zvnDXnakGhFSKfRrlp8EMVYrO9FdyQUA8RGIVYaKH6rw6rqjSWdtsPWJv96YsRyUOTN1hSjt04YnmDukoUKHkk5TSAulnVVxIHl7uqNQuu5Z9Cc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MugBhz4b; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MugBhz4b"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b4583f0a1aso46024755ad.3
        for <git@vger.kernel.org>; Wed, 13 May 2026 08:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778686944; cv=none;
        d=google.com; s=arc-20240605;
        b=AHgBKgIlKX81Y7aG67TdPPTkF/rKVgveih2Zb7F5ngQ/zv42HreyaGIFrAd85lFH0E
         3fO9jf4wuI8opDdGeMxXlao9I57InDnPCpgiluGyTTFjpcuv9BOAgNygpxxx97SXMyl3
         XS4KjAVbKC1kuLoM15QwknbWyRGxdHzOcZSUlCydtw7ZsdwY/YPJrXIa16ivu2l9XhzV
         kUswo1sLkdELzVDXwWt3KEJOc2/nQM8+FtDJmERbYrBmIneZXTzx9zoFJk7J61RkKCMM
         6uucZrXtjCyewGd8v70mmCy8/z/UuGyNrmeno632Yazu3dvQeNOaGnQFL95l2D+KdnwW
         Vmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yncWKZbUvUrZ9A35wc57dTi3JJRlKIOmA6nQb78mu6Q=;
        fh=8bqVk9Exzs8uQKQKM8FbfRSpuEc4wrSgnvbFIs15Ssg=;
        b=j/yxUjzEdNtfdIU8Asj7Az8iwd0WCM4IpLhzucsN4HvKp+dXWk7zZUYtS078h9BOji
         JB1Ph4qXjwWrSspNyVyU1PmJgA4tRYvT9uQY4LIb6IDJbLYxboFvEVH8hd+CYwwdUFxe
         xZppBwxukc8/uw2E8Vit22al3dnYY4eZjGrmdlGY4IYefSvbQym8k0DCZsmCBXJ1gcb5
         cgF6RbWLv/O6Uvl3jE7vVb3yp6W0fzA+FNPLBpPQyONdl25X0qRrf23PVUFBpOA4S2EZ
         hESda7G0wQ8pOZ6PnY5/pHRDO/LQtDH5ap7BqgtnJgvXY3Uu1MkJ1NTdQdEAbjTQ7OZL
         LuTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686944; x=1779291744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yncWKZbUvUrZ9A35wc57dTi3JJRlKIOmA6nQb78mu6Q=;
        b=MugBhz4bB/j3FbZQ/yko3Rvr1bY/LFPDQ9fpxVB3ecNvt6MSVAaV0dAPh4VmO1Exo4
         bP4M+LNzsVYOFryfFkYmJ+1h6XWe2vfmdVYp04y6VL8SuQ8fuO5pGA6OYfthXBQtmHh4
         ILVZxzcDRw0CgaseX8KQG9sdNw9/OZkhIE8cBtCQBtlC6GZBj5EOhauTsYGsmy4jZ1+z
         muKTprdGvBBLgqraGr3s3dnNDVpj+xLQ6fDs7Bum9VHUcsjHvu89fDR4YOudCrsoQaIu
         kgb4ZYCyTfAg0maORTgC+tZfHpJQasS+6Oc9gW5gpmaa/d/7cqGTYsC4TF4jVgAG9Pi3
         F7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686944; x=1779291744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yncWKZbUvUrZ9A35wc57dTi3JJRlKIOmA6nQb78mu6Q=;
        b=TB7XLTyEF4+985Gx4AjBwLMIG5RccOTwZF6wg5UKyH57U9RgdsLiOOoCGJ4dDglGka
         XxyNDOmhgHEeF/iZdo/FNsl2CKqvpLxu2dggzTe+YInDgcxIZkA8e6xLD7jTHm1ww0bT
         YZVVepz4xgsbS4umcZElcj249uqWQhB3sOb4u2HbUAv1gesZ7F714PqIIysM2gm6tKN7
         k12sjlPlKvznSuA7WM5eSz/pxzWptof7kurtIfRQImpyWhhQaaUvEpsA7TDD05HBJNLn
         w3nY0T77f+tvsDWG9/zPYGjxOwysqKt0lnzRjNcmHwvYXexnJEKFSaeYaa2tqeWJsWDs
         Jqkw==
X-Gm-Message-State: AOJu0YxRpxFrmtbaBRrfSLzyb1PP6lWSmSqQPqBgkUE/66FE8rxkjXOE
	VoBAUWIoZ5r8OcTn2+/v+ApiqJGm1Xzu6Jo2YjzDZv65HIKktg2+F3Af3WXpVlJ78aAcvnjteOY
	d0IdLQGm6Am0jVvcV9HrQvH4L3OSuqVvYq0TGT50=
X-Gm-Gg: Acq92OHbC05OuZzQ2S5y6kbw/8oGcXaqDSiW/LN+e01I1v3Tku3xpaeCI/97fOlDdo+
	sgol3oF9RzOnC4FxMirfCNchU/+FDUAD69Yj6bVzY96u9pH4N0O5ZVDrrni5I52voAdUfwOMcAm
	DtdzrXq2HPAKn2a/yTQ9Mfxhz2hkddu00YQmcN1awKBp24DbQjlVNCdsv3DINGGvqlpUtjXKwHO
	HJI3ci11ZVGqNK3w8xa3BIzi8g5AJCbFe7yTfRdW4bMwTOoDP1RyOvb/6e3xW2MZKZlgTDuybyy
	o4j6tEXvzHyuli+7I9xTt9mtDrX81nkTVSQiLohp5M4fwXXY9CUNXgpQcpLggpwqA61dppqgPgI
	nqe3k
X-Received: by 2002:a17:903:384f:b0:2b2:be01:5532 with SMTP id
 d9443c01a7336-2bd2771252dmr43408845ad.35.1778686943676; Wed, 13 May 2026
 08:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <95BE8E60-1684-4E0A-9E46-E61E81D06CE1@alexandersandstrom.se>
In-Reply-To: <95BE8E60-1684-4E0A-9E46-E61E81D06CE1@alexandersandstrom.se>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 13 May 2026 11:42:12 -0400
X-Gm-Features: AVHnY4JDY8ysX2J-AYoQi_lVpapjyGbjuuhY6DNcqRNVG7OYPuubdvRiENf_9GY
Message-ID: <CALnO6CAZ+Z_ZzkqXHu45A3cwZTZD4=MEz-vx0PEoD05bJ=0bzw@mail.gmail.com>
Subject: Re: Bug: lowercase "head" resolves to wrong commit in linked
 worktrees on case-insensitive filesystems
To: =?UTF-8?Q?Alexander_Sandstr=C3=B6m?= <mail@alexandersandstrom.se>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 4:27=E2=80=AFAM Alexander Sandstr=C3=B6m
<mail@alexandersandstrom.se> wrote:
>
> Hello everyone,
>
> I ran into a bug that took me a while to figure out.
>
> I'm sadly not a good enough C programmer to submit a proper patch,
> but perhaps this bug report will at least be indexed by search engines
> and help others that might have this issue to understand the cause.
>
> My guess is that it will happen much more frequently now that
> worktrees are more popular.
>
> **Report**
>
> On case-insensitive filesystems (macOS APFS/HFS+), `git rev-parse head`
> (lowercase) in a linked worktree resolves to the main worktree's HEAD
> rather than the current worktree's HEAD. This causes commands like
> `git reset --soft head~1` to silently operate on the wrong commit.

See also https://lore.kernel.org/git/20240701033145.GB610406@coredump.intra=
.peff.net/
and https://lore.kernel.org/git/8BABB6F0-517F-4AA0-9FF9-92AF8C33CD0E@strong=
estfamilies.com/

In short, it's a known issue (that I don't think we're going to solve
in the ref store where refs are just named files). Using reftables
ought to make the papercuts go away.

--=20
D. Ben Knoble
