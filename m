Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FC17592
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481363; cv=none; b=ttxvaJtZVkov5ZSltyLWNe+fYULhlvi1YwlTw7btwvmSDuud/1WrsxTQhercqiqqcLojEXPanXxqsVb8FTS9W+7WSJ80JDUDUe/nj8I5TMKXm5D1SEny7eG+KGns8+IZSU98iMcyP2lXBs8ybbv1RvpcqaJIAlCPqZnrZlUPn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481363; c=relaxed/simple;
	bh=Oj2GGuVgkCX9HSICsgtqLCt1J7ud29b3WQU+FjEeKec=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hq1eo09nGKk0TPy4XSxmD6c085CNJY26FQnV0P78/FpynP4QjFsvkkkxAThmZjJTvWBeQRtSOYkY1q7YT1kBhLKaa9vNcbmOUx0oeJnR02sJVmLimaG2IFZqAKOpaLyl7o3VNfAeVtY0/R0xbXSnOl/N8xXwmPUDdVCuHw2GRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMpKNuN3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMpKNuN3"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c86560e96eso1134823b6e.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481360; x=1715086160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LVdHhEd3K/2ZlJkvb2hgav2m42BxIJ3PkUDk+smov8=;
        b=UMpKNuN3XVqbOL/7VG+GGsj0Vtv/mGRu+2hztDYyhpwVfTHtvlEUKjH6AH3rDaXcYR
         5n4vyALngmGwyMev8ZTPNKYYI8M+vIIW5rhZxe1rcSVsK5uIfW/Oyxw/coPiHe80HIEq
         kBhKo10AHUkqCGQMmfMJvsL5ycl9iSadiOHXk8TYJDF6QBEl4lO4syEp32Y8txc+DPzP
         cny9gVczk4C8DPfdSd+9ZIlc79LVoftmGS+30dMxG8pCsVWGQPOCGiP0jUBHI7GPICS0
         HjkK7N13znnqhn6avrJl6dLw16ArTyxeBKwPJSp/FxK1A9rqA/79mYAEtHuHcx7GgRBh
         Yfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481360; x=1715086160;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LVdHhEd3K/2ZlJkvb2hgav2m42BxIJ3PkUDk+smov8=;
        b=JWoQEG8b+XlHA9Iz9UZqdA/QZJME4yzlCRkIjzTwB6dL0W0Q5B6nTXoYzQ+/QBXN6e
         sMgWy4kFWA3tva+CeSRQz0XbvOXmKfakJnpH/ZsJFG3hSHhFdlK9Q9Xq6pMUgAcRXCTj
         uOauNqhbGkF5YXmzqDRxMtk657UD7tnNG8Yn6ca5AGzqDKttPAZVWpIdHv8lC4hhIyWs
         oQ8WrQYpj5zdivpSzfFV3dcDXET6OuaT4OLFIjPamAB/DzdIUyWXogK36kAEMVhANmaX
         f9eX7Lf/TIyeAqz1DsA2AnDLns1AaNsK4pn8mgJfiz4jSr0YB704GRUvlMQlaQG2D9oY
         mkvg==
X-Forwarded-Encrypted: i=1; AJvYcCXvNCpSoYRMpeLvs9d6bJ2ZfMj9pZoTmPbzZ+/jpbd5Nxb0wpfe/xNMDd6wim1AGxGlHFrHSNvF6EOmgwh/dlhSPgmC
X-Gm-Message-State: AOJu0Yw0Mvz754DgG5J2GD8n5TtxhXIx1HXu2yzoC0UvH6Ue65FU+ABo
	KaJrsWifsGMQXMu9ZWJvLXcMImZ2oToJLIZAoAZoX31MuFMnduBBkzsX37nyxmc81vLF9b9PUXe
	qe2/muhSWBrOOmtNXNv+OFw+4bGQ=
X-Google-Smtp-Source: AGHT+IHCORAHN9eXxbAeVM2xRMo9nu+XOPnuM0obciIeuzFAMCzXKcgm2D6L9PULKAT0aincywF0ulsPxCvcjTJoC2o=
X-Received: by 2002:a05:6808:3c9:b0:3c8:2d2c:13a2 with SMTP id
 o9-20020a05680803c900b003c82d2c13a2mr13081813oie.4.1714481360472; Tue, 30 Apr
 2024 05:49:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 08:49:19 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <2489bb558543d66592fb0f3eb4d4696ba8e31fea.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im> <cover.1714479928.git.ps@pks.im> <2489bb558543d66592fb0f3eb4d4696ba8e31fea.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Apr 2024 08:49:19 -0400
Message-ID: <CAOLa=ZRLrLc6ZyEFSmkfg7zMKVXfngCDqpP3FDt-qA7dHR10Ww@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Documentation/glossary: redefine pseudorefs as
 special refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000772b1d06174fccd0"

--000000000000772b1d06174fccd0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Nowadays, Git knows about three different kinds of refs. As defined in
> gitglossary(7):
>
>   - Regular refs that start with "refs/", like "refs/heads/main".
>
>   - Pseudorefs, which live in the root directory. These must have
>     all-caps names and must be a file that start with an object hash.
>     Consequently, symbolic refs are not pseudorefs because they do not
>     start with an object hash.
>
>   - Special refs, of which we only have "FETCH_HEAD" and "MERGE_HEAD".
>

Nit: but since you go into explaining what the _old_ pseudoref is,
perhaps you should also add a line about why "FETCH_HEAD" and
"MERGE_HEAD" were called special refs.

> This state is extremely confusing, and I would claim that most folks
> don't fully understand what is what here. The current definitions also
> have several problems:
>
>   - Where does "HEAD" fit in? It's not a pseudoref because it can be
>     a symbolic ref. It's not a regular ref because it does not start
>     with "refs/". And it's not a special ref, either.
>
>   - There is a strong overlap between pseudorefs and special refs. The
>     pseudoref section for example mentions "MERGE_HEAD", even though it
>     is a special ref. Is it thus both a pseudoref and a special ref?
>
>   - Why do we even need to distinguish refs that live in the root from
>     other refs when they behave just like a regular ref anyway?
>
> In other words, the current state is quite a mess and leads to wild
> inconsistencies without much of a good reason.
>
> The original reason why pseudorefs were introduced is that there are
> some refs that sometimes behave like a ref, even though they aren't a
> ref. And we really only have two of these nowadads, namely "MERGE_HEAD"
> and "FETCH_HEAD". Those files are never written via the ref backends,
> but are instead written by git-fetch(1), git-pull(1) and git-merge(1).
> They contain additional metadata that hihlights where a ref has been

s/hihlights/highlights

> fetched from or the list of commits that have been merged.

This is good detail and I guess you can skip my earlier suggestion.

> This original intent in fact matches the definition of special refs that
> we have recently introduced in 8df4c5d205 (Documentation: add "special
> refs" to the glossary, 2024-01-19). Due to the introduction of the new
> reftable backend we were forced to distinguish those refs more clearly
> such that we don't ever try to read or write them via the reftable
> backend. In the same series, we also addressed all the other cases where
> we used to write those special refs via the filesystem directly, thus
> circumventing the ref backend, to instead write them via the backends.
> Consequently, there are no other refs left anymore which are special.
>
> Let's address this mess and return the pseudoref terminology back to its
> original intent: a ref that sometimes behave like a ref, but which isn't
> really a ref because it gets written to the filesystem directly. Or in
> other words, let's redefine pseudorefs to match the current definition
> of special refs. As special refs and pseudorefs are now the same per
> definition, we can drop the "special refs" term again. It's not exposed
> to our users and thus they wouldn't ever encounter that term anyway.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/glossary-content.txt | 42 +++++++++---------------------
>  1 file changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index d71b199955..f5c0f49150 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -496,21 +496,19 @@ exclude;;
>  	that start with `refs/bisect/`, but might later include other
>  	unusual refs.
>
> -[[def_pseudoref]]pseudoref::
> -	Pseudorefs are a class of files under `$GIT_DIR` which behave
> -	like refs for the purposes of rev-parse, but which are treated
> -	specially by git.  Pseudorefs both have names that are all-caps,
> -	and always start with a line consisting of a
> -	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
> -	pseudoref, because it is sometimes a symbolic ref.  They might
> -	optionally contain some additional data.  `MERGE_HEAD` and
> -	`CHERRY_PICK_HEAD` are examples.  Unlike
> -	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
> -	be symbolic refs, and never have reflogs.  They also cannot be
> -	updated through the normal ref update machinery.  Instead,
> -	they are updated by directly writing to the files.  However,
> -	they can be read as if they were refs, so `git rev-parse
> -	MERGE_HEAD` will work.
> +[[def_pseudoref]]pseudoref ref::

shouldn't this just be 'pseudoref'?

> +	A ref that has different semantics than normal refs. These refs can be
> +	accessed via normal Git commands but may not behave the same as a
> +	normal ref in some cases.
> ++
> +The following pseudorefs are known to Git:
> +
> + - "`FETCH_HEAD`" is written by linkgit:git-fetch[1] or linkgit:git-pull[1]. It
> +   may refer to multiple object IDs. Each object ID is annotated with metadata
> +   indicating where it was fetched from and its fetch status.
> +
> + - "`MERGE_HEAD`" is written by linkgit:git-merge[1] when resolving merge
> +   conflicts. It contains all commit IDs which are being merged.
>
>  [[def_pull]]pull::
>  	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
> @@ -638,20 +636,6 @@ The most notable example is `HEAD`.
>  	An <<def_object,object>> used to temporarily store the contents of a
>  	<<def_dirty,dirty>> working directory and the index for future reuse.
>
> -[[def_special_ref]]special ref::
> -	A ref that has different semantics than normal refs. These refs can be
> -	accessed via normal Git commands but may not behave the same as a
> -	normal ref in some cases.
> -+
> -The following special refs are known to Git:
> -
> - - "`FETCH_HEAD`" is written by linkgit:git-fetch[1] or linkgit:git-pull[1]. It
> -   may refer to multiple object IDs. Each object ID is annotated with metadata
> -   indicating where it was fetched from and its fetch status.
> -
> - - "`MERGE_HEAD`" is written by linkgit:git-merge[1] when resolving merge
> -   conflicts. It contains all commit IDs which are being merged.
> -
>  [[def_submodule]]submodule::
>  	A <<def_repository,repository>> that holds the history of a
>  	separate project inside another repository (the latter of
> --
> 2.45.0

--000000000000772b1d06174fccd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 659d6bc8f7fb0cf4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdzZNMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHVGQy85L0Z1SkRVdU0xdWtTbkdqQlFsTkMvUkViNApwT1cxOHdhZ2h0
SC8wdFlHeWNFMWZhUk43cER1L3VsTzllaFNhQnhmU2d6dytuRmQwdUZLU21tblFwRFdjdi9tCksx
NzA0ODhlR3lBcVFPa3ZWTTJUUklkOERIbDRxemE4Sy9tMzFNM3FvTUNRT1Z5MGI1ZGE2Y0JqaFdi
Mjl6WXMKRUhWbENSY0oyajVwcVR2aHN2YnpKQm90L3VYanZzUFpwS3FvOC82dlZTWUdJVEcrYVdY
K0t1MGFIeVAwL1JYNgpnbFpuM3pjbFQzNnlZSWgrbkdVYVo5d3hJeEpvd3QvTzc4Y1liWXU3OWJD
bnR5OUgreldoU3VlOWlsRys4b0ZzCm9GeW9IemkyVktONFMvV24rbTFwdTQ0Q2hIYnhRcVlQSi94
b05zKzFmWUZmWDFBQWVjbWhCenphYTFyY2lJeU8KNG5IU2dpV2kyY2xLaTQ4V293MzJ2ZS84elpx
ZmFOMVEvOVBraW1iRWNaZzZEY01kZFJVUDVNU05jeWVuWElLSQpwd0l2MHQ5cE9TT0IwalJYMUZP
VlA2aGFYM2lWTllxT0pweWRtakQzQ0xKRFJXcGxIOGhpb2d2emFHTWk1L0RHCnllUGdtdTBWSGJs
dThoNzRaQUlWUUV0TG9NZWZJS1ozcU1PWHNlaz0KPXJza1kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000772b1d06174fccd0--
