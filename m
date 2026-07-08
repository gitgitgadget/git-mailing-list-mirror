Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E7423A63
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512265; cv=none; b=YYltUkgkI1Bm0517fR32/e77IhzBQW/A3k3w49H1ReOCY3JygTunWr8CEuJ6uXdk3yzgZzw3FWKcek/9ZpWQe+S9zcRJJx9+PkkPtkds79rSzNZqc40c3N75tIVXqLrdZ1LEuzfgPkFIOUqN+/PwM4hliTbTMrcv1zQvCW2sves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512265; c=relaxed/simple;
	bh=4R8MBVEDgRvbULrspC+ZzMgZYO/DeV5PaRnAMPnmGwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nm1F5sRBNw0sLubyXn7XDhyoCrWPn7mMZhqiQ62evXT/2aaJJ7WuptymLgTVEVI4LCiGD2VeUai5kDprCabbgF2623F3imc5kQjl45e+KGtirGe+r0gdB9d9eQ5tL6BaGUp/FnKZF20ueh8Pq7QlsGt/PEh60L5YRks9yJ4EaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fPocEqui; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fPocEqui"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783512258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MT3sx25T3MRwqMMvw5N80HMpqOJkTXFGGXxqtPmUJlc=;
	b=fPocEquiLspoI8Kjudi1qeZ8GIRWzcG9TafZ9EUOV7kpjhILbgpq5BF9hGQNLgpTK4alGl
	xPJHaBOkJYSW6xCA3ZNQEZyf+MK57tIYd1p4YrNxxaynRM0qBlqAbqbPm77aIQb2uuMp/X
	imhdy+BLczXRD9RXEfQUPgY5FONyb+s=
From: Toon Claes <toon@iotcl.com>
To: kristofferhaugsbakk@fastmail.com, Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Siddharth Asthana
 <siddharthasthana31@gmail.com>, git@vger.kernel.org, Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 2/4] doc: replay: improve config description
In-Reply-To: <V3_doc_replay_improve_config.782@msgid.xyz>
References: <V2_CV_doc_replay_config.767@msgid.xyz>
 <V3_CV_doc_replay_config.780@msgid.xyz>
 <V3_doc_replay_improve_config.782@msgid.xyz>
Date: Wed, 08 Jul 2026 14:04:00 +0200
Message-ID: <87cxwxofgv.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> First of all, this unordered list for `replay.refAction` introduces
> a term with a colon. This is exactly what a description list is,
> structurally. Let=E2=80=99s be stylistically consistent and use the desc.
> list markup construct. Let=E2=80=99s also drop the harmless but unneeded
> indentation.
>
> We can reuse the `::` delimiter since we use an open block.
> But for consistency use the typical nested description list
> delimiter, namely `;;`.

Yeah, looking at some other docs (for example
Documenation/config/branch.adoc) it makes sense to do it like this.

> Second, let=E2=80=99s replace the inline-verbatim `git replay` with a link
> to git-replay(1), since we are naming the command. But make that
> conditional so that we avoid a self-link inside git-replay(1).[1]
>
> =E2=80=A0 1: See e.g. e7b3a768 (doc: git-init: rework config item
>      init.templateDir, 2024-03-10) for another example of
>      avoiding self-linking
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v3:
>     =E2=80=A2 Msg:[1] typo, fix to =E2=80=9Cstylistically=E2=80=9D
>     =E2=80=A2 Msg: Move the paragraph about delimiters (;;) from the *nex=
t*
>       patch over here instead. This is the first place we do it. In the
>       next patch we can just say that we are doing the same trans-
>       formation as here.
>     =E2=80=A2 Msg: Remove double-space to separate two sentences. That=E2=
=80=99s
>       inconsitent for me. I moved away from that because two-space
>       separation takes up too much space when linewrapping is set to 72.
>     =E2=80=A2 Msg: This isn=E2=80=99t the option, it is `replay.refAction`
>       =E2=80=A2 Copy=E2=80=93paste mistake? We don=E2=80=99t have to ask
>     =E2=80=A2 Msg: ... and it=E2=80=99s better to call it an unordered li=
st rather than
>       bullet points
>=20=20=20=20=20
>     =E2=80=A0 1: Commit message
>=20=20=20=20=20
>     ---
>=20=20=20=20=20
>     v2:
>     =E2=80=A2 Keep the description list for `replay.refAction` (Junio)
>     =E2=80=A2 Now rewrite the description list like in patch 1/3 (it=E2=
=80=99s
>       technically an unordered list)
>     =E2=80=A2 Msg: mention a previous commit which also avoided self-link=
ing.
>       This helps establish a bit more context for why we do this.
>
>  Documentation/config/replay.adoc | 16 ++++++++++------
>  Documentation/git-replay.adoc    |  1 +
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config/replay.adoc b/Documentation/config/repl=
ay.adoc
> index 7d549d2f0e5..7328da9537d 100644
> --- a/Documentation/config/replay.adoc
> +++ b/Documentation/config/replay.adoc
> @@ -1,11 +1,15 @@
>  replay.refAction::
> -	Specifies the default mode for handling reference updates in
> -	`git replay`. The value can be:
> +	Specifies the default mode for handling reference updates.
> +	The value can be:
>  +
>  --
> -	* `update`: Update refs directly using an atomic transaction (default b=
ehavior).
> -	* `print`: Output update-ref commands for pipeline use.
> +`update`;; Update refs directly using an atomic transaction (default beh=
avior).
> +`print`;; Output update-ref commands for pipeline use.
>  --
>  +
> -This setting can be overridden with the `--ref-action` command-line opti=
on.
> -When not configured, `git replay` defaults to `update` mode.
> +ifdef::git-replay[]
> +See `--ref-action`.
> +endif::git-replay[]
> +ifndef::git-replay[]
> +See `--ref-action` for linkgit:git-replay[1] for details.

I'm not sure about using "for" twice, how about:

    See `--ref-action` in linkgit:git-replay[1] for details.

> +endif::git-replay[]
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index f9ca2db2833..4de85088d6c 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
>=20=20
>  CONFIGURATION
>  -------------
> +:git-replay: 1
>  include::config/replay.adoc[]
>=20=20
>  GIT
> --=20
> 2.54.0.22.g9e26862b904
>
>

--=20
Cheers,
Toon
