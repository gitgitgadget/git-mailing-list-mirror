Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97D3EC2E1
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938895; cv=pass; b=OyLRa1iOTQSSoStUqJc5/7FAuSuaWV6deFoNd6d0k2LECKdXAxhcEk2Q1Cth36D31lj9t1DGTaSo3C8rXLJNyAq1KESP6xFIag6bnXUlMjRrZOmVw9V7bi3PxLr5ejijzk79dxyhwuvuwXDdbdeZmwW1n0advxEWIhU4ctEe6K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938895; c=relaxed/simple;
	bh=2i97Q3/GmiBPZv+yVLMM55oEyJT2IjEB07/myL1Ck7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOIJsiIGynhxQ+Nkn0gdagE6HTVq7XN6Qry3AImOAxk+kKHAim771j2qDazpAzxhLT2ScScibzH5Vy1kDAbFPzI3ymELAipLPxDeoDFQDLKbJI5erpAUmFHRwQWILqyRdeCeVzK9KZ/hzTSt60fvMK4fO6fee+/3nAWNkoNuUCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWidYCuT; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWidYCuT"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829ac4670c4so712064b3a.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773938890; cv=none;
        d=google.com; s=arc-20240605;
        b=idhzEPyucfBc1bYlGkPo3Gr2Q95VNWEIkt7HPb0qWQe/Q/DRG+lcCET9YyKycs/lAf
         rhmdvzI9pFCEbIEJOKERGwDlwBuz+t+PENT6LhIZ/aYG8WrCHYFPJkjoyBHmXR50w6jd
         aUvm6s1KvzQDV54Ue+YCodI3BCemqVyYlyYPN3alOzEUNVadUWpLL2bOeAOi5eX6UUaC
         g1H8LAvCguzOB8+2pWsCB0kn6qSCyUHI2vtHrXIePwz4YCBPHqv9xfHgCLe2X/HyANYD
         +NFMHEXj6JvtZS43W2xLz5LfKWxAUe48iMRnKOEtwyPK9tvC4lLbZM6D874IJFj3eC2R
         PA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2i97Q3/GmiBPZv+yVLMM55oEyJT2IjEB07/myL1Ck7g=;
        fh=SOrxS0uk3y4vqhq2pYlPccplHLquJGfpJNhEiped8C0=;
        b=WfYCU8OexbDWLzkLJ6589Tr8sajQ4w2FWyb1BSxPEVlomylOoU8tiluu4umknHr5m9
         R3d66xEC7Wm42oMnIyFupIdFsoqz0y3cywAstcQ1hzcpWXBrvP0eLcB5AIOcfIpVe55d
         Qk6xYQSJpgLbO+qbhEwViVOYPwLnk+d8fPXfDT7ReHPDbeNNw0YX5Xg5H2+j+kFr45U1
         F18wnjBSE170l1nW/bLgqBblj0Hw9G5bNKTPdLLZqvnZ5BYkLb6EZKgxZsIG8DVdpVDM
         zi/MLAYKJ4g7ZWkwEE5HuKokwVlljj7z98FM/slGqpjGOAC/h/u0MLuACHK0Ir+GRyic
         Gawg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938890; x=1774543690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i97Q3/GmiBPZv+yVLMM55oEyJT2IjEB07/myL1Ck7g=;
        b=LWidYCuTbviwhf7YBuYhbrY7uo/o9aNuM4MRrVfbRxbvuGDWLr0bw2sfUihGI0ntQn
         5OJns2c5192hjq7vxHc0WNbDaunDWsRkB0cf3wuORI88cqgI5efPVWBU+Zmcgkhuj5yT
         CGD2lVJNnThmB9WUDlY03zf4CfDH4Zu+QUnjNT227wRM8abRDm8kP5nhW8at6htGs20G
         bOKodmgEnkNF8fVWb9kQ6eeD203OQc8NjkFzeM8LXqABNwdyqV3tRxnrZ1g8LK2ajd1i
         HV0rjmdkImmv9ELhIxmPawBz63UF6GmsuPUupzcsnucdMBiS79E6zdbkKG6yx0PyBqAD
         rIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938890; x=1774543690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2i97Q3/GmiBPZv+yVLMM55oEyJT2IjEB07/myL1Ck7g=;
        b=YXSDOzsvwqXkcx1jswhJ67L6bbIDk/4ePTTPq8pNyLR1oGcXxgPkArfCfF/ZOMbQPZ
         +AQRQB49A1K6D2FOU9tZ5664RRlPgX+n8jjGoWzGT7K//qq9ls9KBhUzKbEZ7qr9g2/m
         UZ+iSmjVMN3CHMCjQnGLBLMlH3trhrCVfouKUSHrOrLyuthBHcMayrRcN/v1SMqZhGvO
         icsOUY6bpTyc1FoajjLLAAiL46FhCNzzaSzb2U+Tfn0WlgLbW83Dm6oAy0LN1mD2nkiR
         mWrJocKSU8YjhYyNf9777/uigzavrEa7bIa3OXvYlXDLTVUR7mEWm8OMwQl2HnU21NOA
         o14Q==
X-Forwarded-Encrypted: i=1; AJvYcCViMStGtQ+yue/25bsXdv0mQ/QIfQ3ksjTdI1JBAyYF1Tv+QZ4c1WvaNIFjiwkwArZZFug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMUoWGRqfn9k7vNWJBWOJq4Xq/cE6Lm/0H82wu76OfQw+qcnb
	0rYLhftQ0SfpNnrf3CWb37vcdlxhBq/3PQfxBTQ/pn3XPpP3RJze4UXYJJXCmOd6w7fJfQcF3Sj
	1WqGAzu/HrsFFBbYrjtTu7yRrmrQeXnZnuA==
X-Gm-Gg: ATEYQzwRkVa77toDKjfxJ0E2NUMiCklBNWUbHiiOAmdJ/4lKbGObPk/aHyLNQwRg9Rp
	c9ln7S4SwCY5tsAWXUV4g6TgerxLNzUIjaSvovv8DlW2ea9bawenPWvNR/HPiLt9w9B3JNKy1Jx
	rAiuW8K6jwzeBjwiHE2hZlCxAiDwIXXkG72U+rR4LepQLmbBE3LVW4vTjMEJYKWAT8+1g0s7Ru8
	IrDTdbWypzk3M6fcZZU1AUtgipifS+X8WsFkc25yX8O9ZkNcpOvk67EwTs+nwfQ589Fu4tfe90Q
	wj9+uxT2DkN8oq7rcilkEXJVOJBtFALHF8uY/1M5TymiaNicOmBm5p+V1juWcsVwC7yULr9Jqa0
	2LACzZf3t9nGne3c23hAW5PKxaPc=
X-Received: by 2002:a05:6a00:3313:b0:82a:1044:3563 with SMTP id
 d2e1a72fcca58-82a8c247c49mr19751b3a.23.1773938889911; Thu, 19 Mar 2026
 09:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319155148.1145135-1-jim.cromie@gmail.com> <14840d8a-a1cb-4499-ba78-295c778e90d1@app.fastmail.com>
In-Reply-To: <14840d8a-a1cb-4499-ba78-295c778e90d1@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 19 Mar 2026 12:47:58 -0400
X-Gm-Features: AaiRm520WI3ZDV-G6FmtwU_ICXzIpRbJCdmXfjhh19TsZ8o3pbV75EYkv0QphEs
Message-ID: <CALnO6CAZqAacTPgwTzAyF-ryyQxaWahXmpfCt9R_+vLS0o5uAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-send-email.perl: support executable scripts for
 recipient options
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Jim Cromie <jim.cromie@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 12:13=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Mar 19, 2026, at 16:51, Jim Cromie wrote:
> > Enhance git-send-email to recognize executable scripts passed to --to,
> > --cc, or --bcc. When a recipient argument is an executable file, run it
> > in a subshell and use its output as the recipient list.
> >
> > This allows users to automate recipient selection using scripts like
> > get_maintainer.pl in the Linux kernel. The script is called with the
> > corresponding flag (--to, --cc, or --bcc) and all remaining command-lin=
e
> > arguments (typically the patches being sent).
> >
> > Modify execute_cmd() to support multiple arguments safely using
> > quotemeta. Add test cases to verify the new functionality and ensure
> > arguments are correctly passed to the scripts.
> >
> > Co-developed-by: Gemini CLI <gemini-cli@google.com>
>
> These are for people who can be emailed.
>
> But you=E2=80=99ve CCd them as well. Or was that git-send-email(1)=E2=80=
=99s action?
>
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >[snip]
>
> What=E2=80=99s the difference between this and `--cc-cmd` and similar? I
> wouldn=E2=80=99t know, I don=E2=80=99t use these `--*cmd` options.

The only difference I can think of is that we have --cc-cmd, --to-cmd,
but not --bcc-cmd.

(I use --cc-cmd via config set to git-contacts for git.git so that
patches mostly CC the right folks, but I typically have to manually
track and add discussion participants, which is a bit of a pain.)

--=20
D. Ben Knoble
