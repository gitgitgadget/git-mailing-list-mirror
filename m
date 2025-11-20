Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453C19992C
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622103; cv=none; b=iwODx1v9HvczU/dEBiB3X2bUUDdh9RQyua2u1ao4qE7eKtvRSpLLoKBWkaTsweYB/Y/aLSTt4YTeiGlw739+fBmLLdjv5jrA07CqhjYERblJk57be9b22gB2jBquRkrpWpqZc2N/8t5IahSqosBWKkDYeQxB3l49ZkcBCV1j5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622103; c=relaxed/simple;
	bh=jqKWj8pyS9N+VEEY4O8KfmQnl3VXiPfzbXIVUFTOtlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCm/nH8MpvhCyNRuJAa4BQqbQnkthNW2yZoeZL5sAZSAVXmvcEaYa6qm7QpUOafyFfBB+/e591U2+g4qvl2aUyY6AJZbeTClryWeyIHGkT173t17BmoHtk6xwluhTfUtoH6bfnYZDKgfUJoYFXrQynHB/qssrjPmDz7r2uultNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFiRKAIt; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFiRKAIt"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-948e1ec34afso20751039f.3
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622100; x=1764226900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lum72f4wlGOF+XANM7Lu8hDqov+0oSNY8Y3hKHWfx6E=;
        b=iFiRKAItUJGU2MWHovD97/4aiRStFxgQfTSb235oG4I8hk9RHzGQ1+muwmT5P8Spnm
         xZPlH+yOcn68Ry2DsTyGGLwyTO3HYDz0wmW5ia4IDhbD4ae1NR5jPYFVy4Xh7Kok6x+2
         8R7GwGVGUGKc/l0CPST527TlVooE1ICoNbklmRZmWFevRTxdeXW5soc23QuMInRxhQHE
         D23zPxaU3h/qN7LT35ZJ5CoiZOeqP2xsnKKfo5XklcSrNxC5oHnBnD1K78RCuga6ILxn
         smxpL8Um0fgES29iy+vznoV1PzUVKW6fK8VA4G6OiZaI5/sW19NEDsw1uLDoRRjh3DQE
         ZpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622100; x=1764226900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lum72f4wlGOF+XANM7Lu8hDqov+0oSNY8Y3hKHWfx6E=;
        b=wEDQeV6YMpTzdNs354Sr/jKcIahajAtNu2R0ckPHxFpb8P+w1YIwkCrDnkbanuqF7v
         0Eydrgrv5lOkRjNjmgPoDTBxR1YPrMcGP/RxOc4X8ZE20uZivZfx+d9gyobv+ZQnEOQG
         U/rT33728v4GohTk1Cq29+98N7htmYGNfLe5/PRtqnQ++RZfDZRwZ1XvtypQ85T9kQUL
         jK6FFKOEN6lCOZsMa+DQzCJm1eOs4DW8KvknUtjaRMel1Fp+O6fyeALz1e+pgg3b183p
         c+JMq5hvDlhYvxojFC6orZ+34L1YvqYK1v6m0KKKCmpAfVZqgjb6B3a89tAlgqCTpa9n
         przA==
X-Gm-Message-State: AOJu0YzEQyazQ3Ox9gS/bU/SMjSoputkcKntcwCfXnyoeAwVrWEfYLeb
	V9Bc7atpa1i0z2ug7wPNWH210BxXaXV88iT2pTK0mi3jTxaUoTzyFOSlMmQaubUrqGzNoDEOESn
	BnvTA6Zr5GK8eIxfToJevIX3gelLqCx4=
X-Gm-Gg: ASbGnctlrb0mkzeiELzf33lqV1A/DWJ7KIYrlRmMJe4lWxqATublc9qV1tcymxcu7BG
	XWAbvooM1TxW+DKRHC28HgBU7cWNwOKIUdON7+i6PHARcd4CEXRA+T0CJf3WQutFDVkuNaIBUSb
	cq+v1h2bAHr2eok+eOhttQQwrJwCPSNMtHSWQhOtt64Ty+9LbCxRclHueXVJeG/uZ33eAYJbM7X
	tV0UU7MTCx01G10FLmaXDq4SosYnS5JDg6d6ewaeS5H/Z2XK7aEgwhSR2MByyxLBOJFw+kyEGA1
	ukoYQPvoWKnecw6RAD0jC8m88jG0
X-Google-Smtp-Source: AGHT+IGrdFUQocMcJuwPKSKPd4MuZ5j7Vip/qHbXA0yHxXspzkAStfZOII9ilgG3yn4R+JX4l/dAYsDMF3ttl6kDVPs=
X-Received: by 2002:a02:cc87:0:b0:5ab:c42b:fb9f with SMTP id
 8926c6da1cb9f-5b95419512bmr1586918173.19.1763622100441; Wed, 19 Nov 2025
 23:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-3-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-3-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:01:29 -0800
X-Gm-Features: AWmQ_bkU1NoEWZegL_P5f2ac8a6ViOLCT8hcrpkQ6nu4YRfWjkF5zeHNLo6VGAA
Message-ID: <CABPp-BH7E1Bh2g0vR3T4NEsv34DvFQPzMuJSsqtOAaWY-fFCxg@mail.gmail.com>
Subject: Re: [PATCH v6 03/11] replay: stop using `the_repository`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> In `create_commit()` we're using `the_repository` even though we already
> have a repository passed to use as an argument. Fix this.

I feel like I've fixed this multiple times, but it keeps coming back.
In fact, I have this same fix locally in my replay-edit work.  Thanks
for fixing it.

>
> Note that we still cannot get rid of `USE_THE_REPOSITORY_VARIABLE`. This
> is because we use `DEFAULT_ABBREV and `get_commit_output_encoding()`,
> both of which are stored as global variables that can be modified via
> the Git configuration.

Indeed.

Going on a tangent for a second...I feel like I've had to remove
"the_repository" from builtin/replay.c multiple times.  In my local
replay-edit work, I actually added a "#define the_repository
DO_NOT_USE_THE_REPOSITORY" in builtin/replay.c, after all the header
includes, because the_repository isn't what builtin/replay.c is using,
it's these other two things that are also only included if
USE_THE_REPOSITORY_VARIABALE is defined.  That obviously doesn't need
to be part of your series, but what would you think if I were to
submit that?  Is it too ugly/weird of a way to avoid the_repository
being added back to builtin/replay.c so we can stop having to remove
it again?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  replay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/replay.c b/replay.c
> index 98be33b854..58fdc20140 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -62,7 +62,7 @@ struct commit *replay_create_commit(struct repository *=
repo,
>         obj =3D parse_object(repo, &ret);
>
>  out:
> -       repo_unuse_commit_buffer(the_repository, based_on, message);
> +       repo_unuse_commit_buffer(repo, based_on, message);
>         free_commit_extra_headers(extra);
>         free_commit_list(parents);
>         strbuf_release(&msg);
>
> --
> 2.51.1.930.gacf6e81ea2.dirty

Patch looks good.
