Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB622DC767
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773630580; cv=pass; b=DquzYbSkgp4xf1EDOu84KfGEbD08HdQbx6UKIJNY582t9BCgAsbH3WI+FInFs+ZpfvrDaeO9KkAq+2C7+hDNRJ1+170pTYQqMY/QjQrUI845y2CGkVCRzdouan324yJv3YFgQI8FaryHhvB+Nlz2ywdvO2JzaMX/mWGM5s5TqTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773630580; c=relaxed/simple;
	bh=ll6kGzKKDW2Wb5TpQkB0Kmfnt8pRRoKBf+uiAiKSr9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KikoIAptLk3ZTPVrIYZMgPk7pbdbuEUf1TyWDfDWik/bcThln8bK6zw3GtrFqksOCmA3+l/PR/bs+o74Ns/ELy3YuGxa8b5GJJucgccKo9fYI/9YMvl4Fv8Cuhmq+YAC7+8qnVI0KDenr+m+bSy4/MmkjfjGWzRK5176ojanKGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoRUUmWR; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoRUUmWR"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso4231638d50.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 20:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773630578; cv=none;
        d=google.com; s=arc-20240605;
        b=gSUWI+3ZT2SfevncsOWQ6zKzmMlR7IuJGKWvoYYUtIxnYtdVUt174w1I6CnCfgKJGh
         CoB3WUawEE4EYCYpvu24wlsihEWQdwcCQ9+gdwd99lRCHC7lVWWpegy4VtrJMkvMmb2M
         gs0LCYF2t2AXXTAqbL1V/JxZkRLX2TdmLT7em4N0D1dGjzR9t61XDiWRYKz7Zm4mQMEc
         2YcMqadsXAqMGiwkjS8Y6euNukJp3Klu4Q6XobZSMFTkDWxLLbACZcQCmu5KQ+tg770f
         9VhE6rsufcatxF0o14ZfJ5lkac/3j+5iqzYq3Sek5LXOMpQjNClxqH3hu++nGgMlHlbZ
         Y2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpO+Ywi0EfeY9eEjH/EKxtUItEPhJtEbka+8E7mMCJw=;
        fh=piuf1G4Sxnq/1l/ELqdoCIdJ8elQtIJ5Z2laCnSd2wU=;
        b=VoPcYS/+PjoH/v7YkUG8Oxc4K06QonfI207RytqmJBIgM02Lk2G9JOO5aUNvK0BJkT
         EKuAM2K+rIhO0ussXxzd/Qh5dhY/xq2rt+w6UmKEsupHX2FY4LfoCsbCW12RH8ztx2eB
         6BXdzzo0zJo8vgKoyfScjnEUcGh7uZCyzeQRqCDnEii/Gmw9GhAEcKlNUV3iUsjmqBn5
         MTAJFsG7HPgLnO7KcCluIvTXGbxG+K/MyMebwv/MzQRIJulcyJUxXTOz/ifFbNN3nF2Q
         gMCtXLzZltZglBB96HC29do8vLfNNSNfGgawCFChey3AB0dLT6mKYysLPR9FINzvYPJg
         Q0rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773630578; x=1774235378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpO+Ywi0EfeY9eEjH/EKxtUItEPhJtEbka+8E7mMCJw=;
        b=AoRUUmWRLiP0xLEXzs188kOStRJH33TkpmIxfi7itb+LLSR4N+pShRtk/sDaM8AjVq
         ZZctDXCCSPxE8u3aPx8lDolTy+eqdhTB9slz49iUk+sfRUJiy1yJsnVz3OvTJsK/Rfdp
         ng4GOnYAVzSsC9q00t4Mz9v8DZW1dg3GTSyJZQtVATyRLgA/CZdcD6lVhHW4zEusiZfH
         KROKzIVZVmKNiDWbPVc2ACeUuwgwkAX5kwBwGOGz5zcufmLepM/LQwRG5jzo0OWp35M7
         0rgK8g+QJRMR1ccH/WGHwZDAIegHXNCHIN9qfIwB5XRz4Ioaou3ocGnyBQ0fueWdlA1G
         MOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773630578; x=1774235378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MpO+Ywi0EfeY9eEjH/EKxtUItEPhJtEbka+8E7mMCJw=;
        b=EWXie9JZbhs1QZwulbX95ZYgyUt5tmtt74rDsf5zzZgmcQsuGBBjYXb4aQdAxemZ5D
         92kS0CXauzVXrYHd3p7hsEz4XyWnxvia3vPxp2LdMY9Ui4vNLSARCRjmIgeUqtYBLEiu
         +CY1DpJ7Zm+KVybYliSrzeA2+WU9j6W5ezYqCBQ/b1bw1fJuTes7axE2kJj1ZnRyQAWM
         +/eBmMoaN47sA72Q0XRgTbVlwnFYm/7f6ZkEmHyX55eVhsthP6fVHxhF1btmq5s5XBzR
         ixQMJ/qCv+KWJIAwmyGFSCVS+Q2pHjvXIqElz9ZEHINpxkrcxAjwOF9+TeB4T1w62Ry3
         70OQ==
X-Gm-Message-State: AOJu0Yy9gLpYvVlmR9aMTo0Y+7uDOpanxtAywagUIyEvtKtO8EU/8LVX
	LY/GmZ7atahZSVO5w1pwY3y2yXXztDmHMDThAx/zfPYI5OWJ4eg2qMkQvmL05e3bihCZlYy9RNF
	Pe/13cmpCumt0OHKGOggCGReFRUrRvCs=
X-Gm-Gg: ATEYQzwleTZb23F3GeCUBVS0PGdS3Jy1gWSTTEuMS3iHXNaXkllBRyNixbqmzB2Dg6w
	FAZOuhEAZTAX/zKNfIN6OHHkucxrWfHKCRwVHPk2zjD2mfjRFvPvQ7BFoVNraSR5ZcT7eDQagDI
	mFi7QOWNIzRugfXMbAlNbzcCbv1/rlC+d5djeFaKaMdV1UY84AgPaDOn0pgoV+bw81+Ug4OWIl5
	OTMgV71D61V+DM0y1hXBzoL6wgY3mrQAi+ItTtuw1fJGIVRJcpzlHJJh+mYZyzK5MnHZMrnbfHG
	iMKV6g==
X-Received: by 2002:a05:690c:660e:b0:799:23b7:5669 with SMTP id
 00721157ae682-79a1c1bf314mr115522007b3.43.1773630578005; Sun, 15 Mar 2026
 20:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313193537.62827-1-eric.peijian@gmail.com>
 <20260313193537.62827-2-eric.peijian@gmail.com> <xmqqpl572zq2.fsf@gitster.g>
In-Reply-To: <xmqqpl572zq2.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Sun, 15 Mar 2026 23:09:27 -0400
X-Gm-Features: AaiRm52xAymvTyDgI3h4n-EH03mAt9Z2XzHXisX3MI2juZm6QbzUutJFH95Muhk
Message-ID: <CAN2LT1D+_JRz4uknimQw0Fw559gxAwSJvhjfqGNZbZCwG6oNkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add preparing state to reference-transaction hook
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 5:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> eric.peijian@gmail.com writes:
>
> > From: Eric Ju <eric.peijian@gmail.com>
> >
> > From: Eric Ju <eju@gitlab.com>
>
> This is curious.  The former matches the sign-off, but I somehow
> suspect that the @gitlab.com identity may be what you want to use
> for both of them, if this is a company sponsored work by an
> employee?  I dunno.
>

Thank you for pointing this out. During internal review, I used eju@gitlab.=
com,
but I intended to use eric.peijian@gmail.com for the mailing list submissio=
n.
The two `From:` lines got out of sync as a result. Fixed.

> Also the commit title deviates from the established "<area>: <what
> is done>" format.
>
>     Subject: [PATCH] refs: add 'preparing" phase to the transaction hook
>
> or something?
>

Thank you. Fixed.

> Other than that, both the cover letter and the proposed log message
> very well explain the motivation behind the new feature.  I wish
> everybody wrote their log messages as clearly as this one.
>

Thank you. Much of the credit goes to Patrick (ps@pks.im), who helped
shape the log message.

> > The "reference-transaction" hook is invoked multiple times during a ref
> > transaction. Each invocation corresponds to a different phase:
> >
> > - The "prepared" phase indicates that references have been locked.
> > - The "commit" phase indicates that all updates have been written to di=
sk.
> > - The "abort" phase indicates that the transaction has been aborted and=
 that
> >   all changes have been rolled back.
>
> "commit" -> "committed" and "abort" -> "aborted", if the existing
> documentation is to be trusted.
>

Thank you. Fixed.

> > This hook can be used to learn about the updates that Git wants to perf=
orm.
> > For example, forges use it to coordinate reference updates across multi=
ple
> > nodes.
> >
> > However, the phases are insufficient for some specific use cases. The e=
arliest
> > observable phase in the "reference-transaction" hook is "prepared", at =
which
> > point Git has already taken exclusive locks on every affected reference=
. This
> > makes it suitable for last-chance validation, but not for serialization=
. So by
> > the time a hook sees the "prepared" phase, it has no way to defer locki=
ng, and
> > thus it cannot rearrange multiple concurrent ref transactions relative =
to one
> > another.
>
> I cannot quite picture how "rearrangement" would happen, though.
>
> Would the hook notice "ah there is a preparing hook invocation
> incoming", stall the caller by not immediately returning and instead
> wait for a different Git process to invoke the same ref-transaction
> hook "preparing" invocation, and somehow decide to let the latter go
> first before releasing the former?
>

Thank you for asking, happy to clarify. The intended use case is
serializing concurrent write calls in Gitaly/Praefect.
When the hook fires in the "preparing" state, the hook handler
contacts Praefect asking "can I proceed with these ref updates?"
Praefect coordinates across multiple concurrent hook callbacks and
uses this window to determine ordering:
if all callers vote for the same write, they are allowed to proceed;
other write requests are held or aborted until the current one
completes.

> > Introduce a new "preparing" phase that runs before the "prepared" phase=
, that
> > is before Git acquires any reference lock on disk. This gives callers a
> > well-defined window to perform validation, enable higher-level ordering=
 of
> > concurrent transactions, or reject the transaction entirely, all withou=
t
> > interfering with the locking state.
> >
> > This change is strictly speaking not backwards compatible. Existing hoo=
k
> > scripts that do not know to handle unknown phases handle the "preparing=
" state
>
> "know to handle unknown phrases handle"?
>

Fixed.

> > string will encounter an unknown phase, and that might cause them to re=
turn an
> > error now. But the hook is considered to expose internal implementation=
 details
> > of how Git works, and as such we have been a bit more lenient with chan=
ging its
> > exact semantics, like for example in a8ae923f85 (refs: support symrefs =
in
> > 'reference-transaction' hook, 2024-05-07).
> >
> > An alternative would be to introduce a "reference-transaction-v2" hook =
that
> > knows about the new phase. This feels like a rather heavy-weight option=
 though,
> > and was thus discarded.
>
> And documenting the design alternatives and decision like these two
> paragraphs is very much appreciated.
>
> The insertion of a new hook invocation itself is at a very much
> expected place in the code path.  Well written.
>
> Will queue.  Thanks.

Thank you.

- Eric
