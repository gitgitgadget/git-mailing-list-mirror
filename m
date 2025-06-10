Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D528BA85
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548528; cv=none; b=GOXZfoskl0Ixn8t9o9tUze3aaqO3/flXGHqRpc7SGTE5c8VB3M5SnVj539VnOpKG0G1d9afcQZnzTlt3cPjA9Tx2dqRjYzyMmFV+NrkSjnJpePDVNHqU2TRFbpcZV4f0VRG653ky3uGWKQRTdr+gsYF0I2g7OaIQWOjsnDwIWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548528; c=relaxed/simple;
	bh=Tgsw9+KvAbpzH4zggHu6+/fbQzonKenagYmJdmQThYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKcxmgnk/MfatDKieFdHXUxTZm2EOulKZ9MudHAvRKRbC/eeUaJbv5TBexiXlqh9aXkjKikFkJxR1g53ikEXuUqJ6bm1xchIDZIE9b8l52WmEGmib/szDLTHjfjKklTZAPeytU0x1si21kY+7hmqsY/k0AJ5K3k8iS9PCDIUa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3TmkMUb; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3TmkMUb"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4058312a12.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749548526; x=1750153326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g80cWLSJJcyFIzDzTpxikfG2ca1DeaM14YDOSq8lWMo=;
        b=O3TmkMUb1J+z/kgBM/qUQLgNjGxXP9Q2Wwojk93ihoF2PXOP5k4DrRlPd9kka2wRVG
         T6iQcJ45Nr2S230qyzRtlt73ri1t1BKdOYCxtvAvs6TB5AyHaGuTcNpqfQDHAvAfz3vb
         zqzhrC78wLsBrn6o2cxHOipdz+hLbUHVDt7tkBq3lg38qvOoOsqtrr/n0Q4g0pIaeMKU
         ixEoPMF5QaWx7dRoFL02fYYOBVslPsbrrZoOWTbQSlpFwCNKOUrCOB7c06sI8fES5Uy2
         xBJa/cRz2l7Fzv/m2gKuC0oxUeBZnagF36kcWJfGZiyW0u7l79B/dDOWINGCaHPktNlq
         bgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749548526; x=1750153326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g80cWLSJJcyFIzDzTpxikfG2ca1DeaM14YDOSq8lWMo=;
        b=so/kjKUHnoBEsj5NwiR37615QEadHKTdAYf/AuXlyn1oJy/XCqYc6qiZh5KdTv+eqn
         UT20SXw0xRqATy/zg+nxg8e02/N0cXOQtpN2rKfsLpRC/V0JoJc+15/nbtDjTBVDH/IV
         wR/pDx4dHkiRNJBx+5iTTQiswIHHjpgT0wXHyd30na+UffRWKIdcBIU2gNsbkVxssp5C
         7LeAYDaU1JLoNo0YBzRlbEADP4wlDxF0nxdM7qSpu+dQMtOZzM8rNUEGSD78YUNmxLBH
         KL832cjtbkzoThsxA0qLR/GOivHBHzUKznXWcQDZgTJVZAr9Da7HVeaAZwYQWhWpvGh2
         XGhw==
X-Forwarded-Encrypted: i=1; AJvYcCUisqQte66hfcnEATm4dOzEL6UMN5RDRqKQvnQuk17J9oIL192PptaDidLVeOSNdM27k38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97XEnY6t233+RJFaIEm5y6lnmynTPQ/6JzPtEpSBNm8upRIHo
	jnALmFHi1yIh/FMcM2/FfAandCzWmRSS4x0NfauyNMA5vkxI7sTtyR9Sef66i+J1PYzPPQvPvm4
	MiKTxPf+aICBXCxblQGKqOegLJFB9yDkZJvYm
X-Gm-Gg: ASbGncvJleU70sslU8T2H6efFch3zbgANIBe3fxAdW7X65zRYgXoOCSbLPLalaPGsws
	09fuKUNplwR1HUk5tYOGyGLKZaYi/0JzbIC1YLc0erLf+5apcWp3hcTSGnXftYqOxav58bs3Qwd
	/b4e6AMNvZ3hAGJynAFBi3aaGcNQk3fYSp9dGp4Sd89+Nj
X-Google-Smtp-Source: AGHT+IH6U70LRr6RS5rzXZ8N8fjHb7BSqLT8WSW0UtoHfFAXqLVj8ew6BCIg3GOjEkRwoGQRnMXh/BpuZEV4ZrBhcJ4=
X-Received: by 2002:a17:90b:4d0d:b0:311:be51:bdf8 with SMTP id
 98e67ed59e1d1-313a155c4aamr2473156a91.3.1749548525626; Tue, 10 Jun 2025
 02:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM0=yCcOAGsUE8tX-o8ioihr+oWrORD6Tz=WH1OnmhpO+uqrA@mail.gmail.com>
 <e790367c-6777-4b4b-97f1-3b3a2cbdb177@gmail.com> <xmqq34ciupll.fsf@gitster.g>
In-Reply-To: <xmqq34ciupll.fsf@gitster.g>
From: Piotr Siupa <piotrsiupa@gmail.com>
Date: Tue, 10 Jun 2025 11:41:49 +0200
X-Gm-Features: AX0GCFslAlWXKikMfVsvJEj0dMaJCuk_nFJCbC7TSb-O8vOW_NSZ3tSJmnVVxr4
Message-ID: <CAPM0=yCScvtJ=v=xZeH6ZqGtnuGeQbHn+Dj6OCiP4Ci=z_Hf+g@mail.gmail.com>
Subject: Re: [BUG]: Non-matching exclude pathspec causes an error in empty
 repository when the flag "--update" is present
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 5:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> I have to disagree here.  The "did not match" error is telling you
> this:
>
>     You tried to tell me that you wanted to add something, but you
>     didn't enumerate what to add in concrete terms.  You instead
>     gave me pathspec, so I tried to see if there are paths that
>     match these patterns.  This pattern did not produce any match
>     so out of this pattern came no additions (even though other
>     patterns may have contributed to other additions).
>
> I think the "'.' did not match any file(s)" in the first example
> makes perfect sense, but complaining about negative patterns that
> did not match does not make much sense to me. [...]

That would be my interpretation too.

I mostly use the negative patterns for scripting.
In scripts, unmatched negative patterns are more the rule than an
exception, since you have to take into account all possible
exclusions, without the foreknowledge of what will actually be present
in the repository. From my experience, a failing command is never what
you want in such situations. (For now, I added "--ignore-errors" to
the script I'm writing and I hope this won't cause any bugs related to
positive patterns.)

Another thing to consider is that if the behavior of non-matching
exclude patterns was changed now, it would break a lot of existing
scripts that rely on the current behavior.
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"
class=3D"gmail_attr">On Mon, Jun 2, 2025 at 5:31=E2=80=AFPM Junio C Hamano
&lt;gitster@pobox.com&gt; wrote:<br></div><blockquote
class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px
solid rgb(204, 204, 204); padding-left: 1ex;">Phillip Wood &lt;<a
href=3D"mailto:phillip.wood123@gmail.com"
target=3D"_blank">phillip.wood123@gmail.com</a>&gt; writes:<br>
<br>
&gt;&gt; git add --update -- ':(exclude)foo'<br>
&gt;&gt; This results in:<br>
&gt;&gt; error: pathspec ':(exclude)foo' did not match any file(s)
known to git<br>
&gt;&gt; error: pathspec '.' did not match any file(s) known to git<br>
&gt; ...<br>
&gt; git add -u builtin ':(exclude)*.[ch]'<br>
&gt;<br>
&gt; which will never add any files (the builtin directory only contains<br=
>
&gt; '.c' and '.h' files). So I think maybe the bug is that we don't print<=
br>
&gt; an error when there are tracked files and an exclude pattern matches<b=
r>
&gt; everything<br>
<br>
I have to disagree here.&nbsp; The "did not match" error is telling you<br>
this:<br>
<br>
&nbsp; &nbsp; You tried to tell me that you wanted to add something, but yo=
u<br>
&nbsp; &nbsp; didn't enumerate what to add in concrete terms.&nbsp;
You instead<br>
&nbsp; &nbsp; gave me pathspec, so I tried to see if there are paths that<b=
r>
&nbsp; &nbsp; match these patterns.&nbsp; This pattern did not produce
any match<br>
&nbsp; &nbsp; so out of this pattern came no additions (even though other<b=
r>
&nbsp; &nbsp; patterns may have contributed to other additions).<br>
<br>
I think the "'.' did not match any file(s)" in the first example<br>
makes perfect sense, but complaining about negative patterns that<br>
did not match does not make much sense to me.&nbsp; If I said<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; git add -- \*.c ':!auto-generated.c'<br>
<br>
and there is no auto-generated.c file (yet) in this working tree,<br>
that is a happy outcome.&nbsp; I didn't want to add it, even if it<br>
existed, and it turned out to be missing.&nbsp; It would become annoying<br=
>
pretty quickly if we started complaining a pattern in .gitignore<br>
that did not match anything, and complaining against "you gave me an<br>
exclude pathspec pattern that matched nothing" feels pretty similar<br>
to me.<br>
<br>
Thanks.<br>
<br>
</blockquote></div>
