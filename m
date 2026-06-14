Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C91E8320
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781406999; cv=pass; b=O6Y8e5FHnZQ8q6p8ZyLtO/Q0w6jAiO1NSGNjAa6ZqS1WqhFiFfRE+e7ZS/q9fqIoAJ7695cwnUArnweybIPfwYXDW5LikAw3xxbe1U0brGrxbl7siYOis5KxgSEMIbnyybkOhwM/jUKV094/TLxeeP8TArInHaebAet9bhFe0bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781406999; c=relaxed/simple;
	bh=lvf20+YYBz0kS3gUbLtEDseAzrgmBeHwET5rLB7IPnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0KVeRqQjSzNUUxIzcikYnRCuU+HXJLkUTN205Q8lreuQ73TZ/auunNE138NNKOSzDRbgqH7QRHhmLwW/neLCc1H0zZ0O+Vo1ZwRTAo3s+u+Trqd6xiPqQEcSyJOZlH131KFG4bcrUIwYTTZXIeoKTW2lQiEDNiSBSYX0ApUczc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXPaEYX1; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXPaEYX1"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-48650c78e09so767969b6e.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 20:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781406996; cv=none;
        d=google.com; s=arc-20240605;
        b=LhFFvcTlTUoojdAM+1yfHNgY2qZKYKVhj+ClsrzReSzu7sRtEWgYOuun3QMQVmwB1B
         nJRojDwEvSj/wf6/Esa2OoamVRPLezOjFjZ+YmfJcwSgfJujH6JhLKzx1G1SXXsiIgjp
         KG13kSu7gjfi/GF7Eoj/3DpbH23fDu+xfp/3nMixbvCPS+JqDyp1RCFZYXBWDFqWDwrK
         rm575t43NUumlfHXpC12dxEfQJ6A6OktfMkEQm3J/2GRdqHKxe1brWfLrC24P2f3ku3x
         A+8FuQQaJ99/cLwWnHERyp/DWvZ4fv/p/UA+vnL1tmQ7bK8VxVytK/blECg7kWnrlALr
         O/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bVoouD5bvOfKnDyA8OZ9M454R6z/DzHUTMu0bjtICYs=;
        fh=S42HY7KEnfWP6+r5LiikF40sPvIRq3Rk8/bcpy/oTvw=;
        b=b0+HQmuEQe0atO12IUIfIvV4ZI7MVYRyGEIY3xhdR4kvzE3264eZ0gYNhi53DKnb6C
         /kSZVuOYv63r/HFAFzExawWRS1iDRjKj+w8WZujKHGnYviIsUraO9bY3zQzYOK9og54Q
         OMin7tUmD6lBEHVFhIR13U88Cbeu6hY8FaodDppUlBcPcbqRidmwqpznABtI46qkfi4p
         ZZEei4fYSgEqlwdE3+t1XdhvxGMsJsHP/Vyr2x2VmFlWsrePswtYzafaGefp9PEgSHZx
         0wn4W+ZEX5dvkianXYsH3obY2ZWH2QO0AwTJASmHz8dx4TbaGVHzRiNe8sWuum0vx3xT
         Npag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781406996; x=1782011796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVoouD5bvOfKnDyA8OZ9M454R6z/DzHUTMu0bjtICYs=;
        b=XXPaEYX11JZYb0p5sRIUnunnEGiUXLUP/yPFB+y6LHWOYFewe26RcYQH18loKdP9Cg
         22tUkLBxSsmmUrXZ0pWcSE2T+edeWGXNikVK3ruF+iCWO9MrHXKopStv1prLhKOg06w7
         gM3AjjkWen0Wlpovim82kJJPetsdNpL3USwPJoY8xq7jk2C/th6a+7QgQFG+/lG2tDZq
         EXNCwmZKRVwYc4rZf0fpA/LCevW+aE1ir8O730FruwJXSKMJF04fvcVhM7Iu9zl5bz5Q
         RWzku2esZ7M4Gat4tKJJODJCpwOdLbh3Wx6k3aayrgpi/vAGDyDg+9k1419p+GEiu903
         JUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781406996; x=1782011796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVoouD5bvOfKnDyA8OZ9M454R6z/DzHUTMu0bjtICYs=;
        b=XHGZ4PL0Zzzjk7wzrm0O/6gYTHWzSGHdcmWcDbWpqqDL4S7nrQZaQJCem5CwjLoDIG
         7QFSiutB5F2FdQIU6l3j30EuqU7BJu5ABQV4E1Ma6rT9nlZ3gnu6XjOX+KcGhUhc85Yz
         6rk71VSrUqVueIguN1ry61YJtKZbL+8WzP4M+/R8LbUMR/g5PqgmFdkvJmj5nuI3AAQC
         QWgijMAfh84EE6yVANhGVcnVe1U5MMfgFC6fs1xR540XtTMvD3qXZqQPkKOU1C8gdthd
         FcmAEdB+BP0zcaF1KyPxcEiKQAynfobtJ1mT9tmkZZue3pQgJPSI2ceCoPXlibfO7GdJ
         U+7g==
X-Forwarded-Encrypted: i=1; AFNElJ+V+BUh66QQqDl9kLrNxuS7iqs1wuPqZWUFyHEaj9W0C4CWiWXlKLH/h/3cWOlFWzi1yoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+TebV89i1Xe9jkoIYofcgLTBvPoaBDwVobDAPTX2bBNak15W
	BUEjadR4bmMbX4I2AagKbYNwxtiDc1CpG0QMZA22UC7kp3QAdHQMvFYgbR7psAY7dO8CDO4Hxeb
	/rYN0JAem8Jly2asDfoJo7RRNjZbbOpeBEw==
X-Gm-Gg: Acq92OGcy8rlAmKhRYVIDrGHHpZN+54+dESbVCIeASrxXYFJE+sd+hHbsPIgb2wyaqc
	NmLTWEfL67sp0tksQaMT/bIjeSqBTVWlSdpspNNS9UbQy8bWHir/7hK0a0z8xb2BN7bgfyvmOMG
	SWZq+U8UC/9PD7LFOACR1Y+P3XRY1LGNiu6SIMc/g/O0236icmRpMEJhpDRwSh6V18+nwmbBQjr
	SOh1CVmZNudNVY9LMbrQr8s2fPLAIuyKXjQcUEKRCHaPIHMBe671YKMqxGWHGRPn39ZyDAg0Krb
	w/86tG1txH4ru2TS6t/BMzp2tZgn/5kfOtNMnZGtDFODyfV7II6gj3xtcLc2utba1rR8z1a5mHE
	FZaHZalKstX/qTsXEd+9uS7jmbA==
X-Received: by 2002:a05:6808:300f:b0:487:5f5e:71b9 with SMTP id
 5614622812f47-4875f5e82ccmr588895b6e.10.1781406996435; Sat, 13 Jun 2026
 20:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
 <282f906d1b4767d95e2a66072c280c2294a93a9f.1776731171.git.gitgitgadget@gmail.com>
 <xmqq33z65ui1.fsf@gitster.g>
In-Reply-To: <xmqq33z65ui1.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 13 Jun 2026 20:16:23 -0700
X-Gm-Features: AVVi8Cd8K9pucw1Ex2akeBPvz-TSDHeERtHoBev-PHDJtRqtPXu45D1__ImeyTI
Message-ID: <CABPp-BEGvmes=mH=XKf0YYRLB-S2bAd_LB4hqaQOxp9xBCF3Bw@mail.gmail.com>
Subject: Re: [PATCH 1/5] merge-ort: propagate callback errors from traverse_trees_wrapper()
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply...

On Mon, Jun 1, 2026 at 5:13=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > traverse_trees_wrapper() saves entries from a first pass through
> > traverse_trees() and then replays them through the real callback
> > (collect_merge_info_callback).  However, the replay loop silently
> > discards the callback return value.  This means any error reported by
> > the callback during replay -- including a future check for malformed
> > trees -- would be ignored, allowing the merge to proceed with corrupt
> > state.
> >
> > Capture the return value, stop the loop on negative (error) returns,
> > and propagate the error to the caller.  Note that the callback returns
> > a positive mask value on success, so we normalize non-negative returns
> > to 0 for the caller.
>
> All makes perfect sense.
>
> How would the externally visible behaviour change at this step?

There's almost no change at this point.  There is only one callpath
that can result in a negative return value, from near the top of
traverse_trees():
    if (traverse_trees_cur_depth > r->settings.max_allowed_tree_depth)
        return error("exceeded maximum allowed tree depth");
All other paths return non-negative values currently, so this patch is
mostly preparatory for later patches in this series.

> Upon an error from the callback, we used to keep going and processed
> other callback data in the renames structure.  We now leave the rest
> unprocessed.
>
> The caller of this helper would never have seen a failure, but now
> they will.  Both callers, collect_merge_info_callback() and
> handle_deferred_entries(), are reacting to a negative "error" return
> well (perhaps because they sometimes call traverse_trees() in the
> same control flow, which does return an error already), so
> presumably there is no downside caused by aborting the innermost
> process upon the first error return.

I'd state it a bit differently: not only is there no downwise to
aborting upon the first error, there IS a clear downside from ignoring
the errors and attempting to proceed anyway.  This code wasn't a
deferred error kind of thing; it was an ignored error.  For the
maximum allowed tree depth issue, we'd just prune the trees below that
depth and pretend that was the correct merge.  And our lack of
detecting duplicate tree entries essentially means that we have a
"last one wins" (are we sure that's really the correct rule?) with the
added wrinkle that the first one can toggle various state flags that
can further tweak the merge and maybe even trip some assertions.

I'll add some of this info to the commit message.
