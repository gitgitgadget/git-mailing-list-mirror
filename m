Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDD163A97
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450424; cv=none; b=h83nYPC1nYliIVSF9z2NParuag8OC2F8lT8v8qD1HIc2/1iZh8LjwureQwsJlwptdzqlttm1BgsFCHDYYuY9pBriXHVpJuzomcnPAu/xxYLwVKo4lWXbh3cmkNfsCHqN9ef4+NfFcrumy4A7jtW29yCCDxMPhm6wyzFLENwgTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450424; c=relaxed/simple;
	bh=ujFqNooTWtIaXNc+OmVMbiSViTMXBFmxf4/DLWPXO9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9wJ37GejuGSsSdJgHCTt1CHU4vTVx3I1bqifoKz6AFX6zjWryzbLqpXuXupvs4yLsyb2DyVEZJ+s8adlzc2RHAI7/ddrZaehwZ5pcalSl2iyubpIWjLpn3sj+vZObpEHYIg1Fpfi9ZkXa4NtqtFqiT9/8CSTN6+f0A57PYpGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2EG7yw9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2EG7yw9"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso1047482a12.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713450421; x=1714055221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxU/EcCQFb0UmmRM0Ki8VZ0gh/wv+yHeY3vyzRGw1gY=;
        b=l2EG7yw9hAI8NvJqcNSuV/+Gw9X2X630cLKURLgwnrw5rK6Vwwe8AuJlb3WcyrzJsQ
         3NJpVyRUaG1ed2huhiBwlMiLaLo9EvSK7UD+Myw2VfI4Mp5kCIcI2ZnfWfjkeljBz8mJ
         mNDk14xn2tc/+m4yZd5IXWtQgDESo9PuKbeN62U6QQTiw39N+42PsBYoI6ta3jpiijjt
         x0/op/fra3X7X9zZ8HRE1Jhzw2nbK/ob6gJaXPpDLRC8Ur5FmiTqNbicjyo0Wp3czTmd
         npQMLeaVdgagitdBhwgfsbOKT0O7hbGiyd/REuncwTfBG021zTFGI1dQtu5CARzaQH1V
         CJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450421; x=1714055221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxU/EcCQFb0UmmRM0Ki8VZ0gh/wv+yHeY3vyzRGw1gY=;
        b=jXtHx+XAFBAAWES2IyRIen5H6n4KPh1PA5h2zJFKNyzuKsY9ZAZViyTjuqBn60CT+B
         kvrAUbKbGP3tUy3CT7nU47c0GjuSnOyIojAPVwP6gkeqSzEFma/rGKkRdIy4fWCVgUQ9
         ZAy3GL1omEWqj64PYaSRGTpPgAuSCOR58wBAeHiGgDWbkqAMbcgEjqwjKLPJLug/b480
         fQtPvzNcU9PK/5dhx06JTqMHNu54KxB9KRwKKH+f/ZQcda8cy9VDYuclvScQ0znho9th
         Zxj9ozlLIna1XvxETkw1xzKkVBeQhS8a0xP3gSJ9osutPAx7eep8Nj3cb7TeMIrdjwAN
         VdAw==
X-Forwarded-Encrypted: i=1; AJvYcCVO3XwMJ9778O3Ipz4Sjme70jh2gWa+60CEifqGMEEUaM5cCzwMAr0HJ/+3pzyn3H6YmOrEQU3D7j7FRTc5p+snHIAt
X-Gm-Message-State: AOJu0Yw4/e1KFnIIgdAkql7iSd2mF+bBRplYvw9J79C56YUJ9XESsQ20
	qgJTHQd7G62orrDJo+TJNpbsERQ/eU22PRjS9pz+hwGtrUXdt3y/Sd8iL57cWCOvX+4ZI236Q1D
	xv+WVsnXqHB5bf4nJjSpx6LR3A/k=
X-Google-Smtp-Source: AGHT+IHrg4luf9HJCvilXfo369lBqMy77xy6LdAq7qkXe+/Mk/W41SsBeaWgj5jcW7S9xllSiRFEVcugDG4UNhvgWEI=
X-Received: by 2002:a50:d582:0:b0:56e:33fe:5e88 with SMTP id
 v2-20020a50d582000000b0056e33fe5e88mr1783534edi.34.1713450421364; Thu, 18 Apr
 2024 07:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-3-knayak@gitlab.com>
In-Reply-To: <20240412095908.1134387-3-knayak@gitlab.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 18 Apr 2024 16:26:49 +0200
Message-ID: <CAP8UFD2bqdMujHgS9oPn4Xqzu=EhGMPms7ftOB7uf-AHke79AQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] update-ref: add support for symref-verify
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>
> From: Karthik Nayak <karthik.188@gmail.com>
>
> In the previous commit, we added the required base for adding symref
> support in transactions provided by the 'git-update-ref(1)'. This commit

s/by the 'git-update-ref(1)'/by 'git-update-ref(1)'/

> introduces the 'symref-verify' command which is similar to the existing
> 'verify' command for regular refs.
>
> The 'symref-verify' command allows users to verify if a provided <ref>
> contains the provided <old-ref> without changing the <ref>.

What if <old-ref> looks like an oid? Will it work if <ref> is a
regular ref that actually contains this oid?

> If <old-ref>
> is not provided, the command will verify that the <ref> doesn't exist.
> Since we're checking for symbolic refs,

So if <ref> isn't a symbolic ref, it will fail? I guess the answer is
yes, but I think it would be better to be clear about this.

> this command will only work with
> the 'no-deref' mode. This is because any dereferenced symbolic ref will
> point to an object and not a ref and the regular 'verify' command can be
> used in such situations.
>
> This commit adds all required helper functions required to also
> introduce the other symref commands, namely create, delete, and update.

Are these helper functions actually used in this commit? If yes, it
would be nice to say it explicitly. If not, why is it a good idea to
add them now?

Also I think we prefer imperative wordings like "Add all required..."
over wordings like "This commit adds all required..."

> We also add tests to test the command in both the regular stdin mode and
> also with the '-z' flag.

> When the user doesn't provide a <old-ref> we need to check that the
> provided <ref> doesn't exist.

That the provided <ref> doesn't exist or that it isn't a symref?

> And to do this, we take over the existing
> understanding that <old-oid> when set to its zero value, it refers to
> the ref not existing. While this seems like a mix of contexts between
> using <*-ref> and <*-oid>, this actually works really well, especially
> considering the fact that we want to eventually also introduce
>
>     symref-update SP <ref> SP <new-ref> [SP (<old-oid> | <old-rev>)] LF
>
> and here, we'd allow the user to update a regular <ref> to a symref and
> use <old-oid> to check the <ref>'s oid.

This means that the ref actually exists but isn't a symref.

So if I understand correctly, for now it will work only if the ref
doesn't exist, but in the future we can make it work also if the ref
exists but isn't a symref.

> This can be extrapolated to the
> user using this to create a symref when provided a zero <old-oid>. Which
> will work given how we're setting it up.
>
> We also disable the reference-transaction hook for symref-updates which
> will be tackled in its own commit.

Why do we need to disable it?

> Add required tests for 'symref-verify' while also adding reflog checks fo=
r
> the pre-existing 'verify' tests.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

> +symref-verify::
> +       Verify symbolic <ref> against <old-ref> but do not change it.
> +       If <old-ref> is missing, the ref must not exist.

"must not exist" means that we will need to change this when we make
it work if the ref exists but isn't a symref. Ok.

>  Can only be
> +       used in `no-deref` mode.
> +


> +       /*
> +        * old_ref is optional, but we want to differentiate between
> +        * a NULL and zero value.
> +        */
> +       old_ref =3D parse_next_refname(&next);
> +       if (!old_ref)
> +               old_oid =3D *null_oid();

So for now we always overwrite old_oid when old_ref is not provided.
So the ref should not exist and the command will fail if it exists as
a regular ref. Ok.

> +       else if (read_ref(old_ref, NULL))
> +               die("symref-verify %s: invalid <old-ref>", refname);

So I guess we die() if old_ref is the empty string.

It's kind of strange as in the previous patch there was:

> +        * If (type & REF_SYMREF_UPDATE), check that the reference
> +        * previously had this value (or didn't previously exist,
> +        * if `old_ref` is an empty string).

So it said the empty string meant the old_ref didn't previously exist,
but now it's actually NULL that means the old_ref didn't previously
exist.

> +       if (*next !=3D line_termination)
> +               die("symref-verify %s: extra input: %s", refname, next);
> +
> +       if (ref_transaction_verify(transaction, refname, old_ref ? NULL :=
 &old_oid,
> +                                  old_ref, update_flags | REF_SYMREF_UPD=
ATE, &err))
>                 die("%s", err.buf);
>
>         update_flags =3D default_flags;
>         free(refname);
> +       free(old_ref);
>         strbuf_release(&err);
>  }
