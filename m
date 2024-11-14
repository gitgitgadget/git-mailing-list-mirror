Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49101F76A4
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574688; cv=none; b=seUB09QbUOQbH3C+D1ZTCZS8yARDMW9fonn8SuyaRcPcB8FqE3Rs9cOt/o/0ySLf+fm6NyNpOS5+gghlcDjTy/3U0e3E2DSDF/730/EZCUvd6NTXgmy4hjnhHN5po9eWslLfSyg4UOg/i9shJlXLas7A99A2HeRrqTqn08rVzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574688; c=relaxed/simple;
	bh=PPiGJAFELaBhxG7LOkjncEb6SF+IJng9w5PyiXOCQeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3wW9Qft6Mrt1OKU8+USsXg0KkWK8k7K/0Uzo4Fpr3l5vRtwQed8gC71vn4QAtiZsjbkneEQHVSnB/D0f52PnEhMWPCbmmIw7ZENp6urjJ7q4ZfVrIf/V3dsfx65dvA22YR6v3Osn3ALq5G4V1qCRaeNFzMSYbsJ63LWd4JX+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFk5iPBL; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFk5iPBL"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ea15a72087so3758657b3.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731574686; x=1732179486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzrhH3pQ3UKeHzvxnZ3DbveMjsvOcIBx0m6ElfjeRA0=;
        b=bFk5iPBLZq1sco4C4eNAxkk+7scvs/ImHBrcESXCFt9HVJpLuDBnf6aFPPVuUFUauB
         zhAV82OLaLN9PYssL8MFxBLWsRUF3Z5bYG3yD83Q+3XCxb1a8u+QLq+pW0zfySVNhv0L
         7vrH/a1UsOsLT+XwKvkZhu1cB7JGaFu+dn/TBvy3Zi8UvrHU8hfVoc4Hq7fQALfCs7QJ
         Ns06UffE82BBShA85DTRRJ/zri7cdxmEFg0ta1CBrfG/MSUuL5ViVBqvnl6YbbIStW7l
         nM7pvLWR6hrpc6hcGYEGEUIgG5M3A8gT/y6E/d3J/Am7cFuPNeun/9B0MDIH5himcT4S
         ScgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574686; x=1732179486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzrhH3pQ3UKeHzvxnZ3DbveMjsvOcIBx0m6ElfjeRA0=;
        b=AkB7FWdI8h2dGXuxhJpaiDI7HvIm6Bgb9mKsE6/ALhNHodr5DA9/Vr9HwkNzxZ42PG
         RewyoKeklm/TDbs7KbkWfnXWWnJOyGLW1gm0K5SPBSMwJgN7FNeXCCmVkNJJ2iIwMOz2
         GPy4EZtHDRey56eKjjzv0D0wGrbtAeCVrKZMpZSIYVB62fK2Ejf12ea5bieYpbgSO1i7
         HxFxP4qQSE4dQbn20PHx2g8ZXVP8ZQiVUKUHZbwSSA4j7bZq0bvU4E0V70HqzhXTiZSg
         Dnd/AIu/VlJMzTjlldb4LO0ihqPH64PAKf6Y+TeMonuvcbEtE52ThXhQ5BbEVJm4hogG
         WNjQ==
X-Gm-Message-State: AOJu0YxXalSL7+ctrtYecBRqlCnhwShzx05VlJpt/SO78r0jcSoD81nm
	TADymZ/Lc94sI1ie76M5IMMclLygxR61P0YVkZY8liu0nNERWW1xu93dgzGreu273gfJ94qWLRg
	Mj9L263x5JxRZnvBz7cHlwYsIWbI=
X-Google-Smtp-Source: AGHT+IFxwUuz5aeuHZ9eGaJnnEaZGaqtHOLAjpeHGOlY9X6VhRfy04WrvsVEWncfPsI53KNIqRtw8ZVQXRfs3ZTlKdk=
X-Received: by 2002:a05:690c:5981:b0:6ee:367c:3993 with SMTP id
 00721157ae682-6ee367c3d4fmr27175067b3.11.1731574685944; Thu, 14 Nov 2024
 00:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
 <20241113-pks-push-atomic-respect-exit-code-v1-2-7965f01e7f4e@pks.im>
In-Reply-To: <20241113-pks-push-atomic-respect-exit-code-v1-2-7965f01e7f4e@pks.im>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 14 Nov 2024 16:57:55 +0800
Message-ID: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] transport: don't ignore git-receive-pack(1) exit code
 on atomic push
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
	"Larry D'Anna" <larry@elder-gods.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 7:25=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> When executing git-push(1) with the "--porcelain" flag, then we will
> print updated references in a machine-readable format that looks like
> this:
>
>     To destination
>     =3D   refs/heads/noop:refs/heads/noop [up to date]
>     !   refs/heads/rejected:refs/heads/rejected [rejected] (atomic push f=
ailed)
>     !   refs/heads/noff:refs/heads/(off (non-fast-forward)
>     Done
>
> The final "Done" stanza was introduced via 77555854be (git-push: make
> git push --porcelain print "Done", 2010-02-26), where it was printed
> "unless any errors have occurred". This behaviour was later changed via
> 7dcbeaa0df (send-pack: fix inconsistent porcelain output, 2020-04-17)
> such that the stanza will also be printed when there was an error with
> atomic pushes, which was previously inconsistent with non-atomic pushes.
> The fixup commit has introduced a new issue though. During atomic pushes
> it is expected that git-receive-pack(1) may exit early, and that causes
> us to receive an error on the client-side. We (seemingly) still want to
> print the "Done" stanza, but given that we only do so when the push has
> been successful we started to ignore the error code by the child process
> completely when doing an atomic push.

I introduced the commit 7dcbeaa0df (send-pack: fix inconsistent porcelain
output, 2020-04-17), because the porcelain output for git push over local
file protocol and HTTP protocol are different and was hard to write the
some test cases to work for both protocols. I acknowledge the patch was
not perfect.

I read the commit 77555854be (git-push: make git push --porcelain
print "Done", 2010-02-26) and the code path of git push over two
protocols a second time, and find something:

The code snippet from 77555854be:

> -    ret =3D transport->push_refs(transport, remote_refs, flags);
> +    push_ret =3D transport->push_refs(transport, remote_refs, flags);
>      err =3D push_had_errors(remote_refs);
> -
> -    ret |=3D err;
> +    ret =3D push_ret | err;
>

The return code "push_ret" of push_refs() from different transport
vtable is not consist. For HTTP protocol, "push_ret" is zero if no
connection error or no protocol errors. So we should consider
=E2=80=9Cpush_ret" as a protocol error rather than a reference update error=
.

If we want to print "Done" in porcelain mode when there are no
errors. (In dry run mode, ref-update-errors should not be
considered as errors, but the opposite should be regarded as errors).

Instead of using the following code,

> +    if (porcelain && !push_ret)
> +         puts("Done");

We can use like this ("pretend" is the flag for dry-run mode):

+    ret =3D pretend ? push_ret : (push_ret | err);
+    if (porcelain && !ret)
+         puts("Done");

I will send patches follow this patch series.

--
Jiang Xin
