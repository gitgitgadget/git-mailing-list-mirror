Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006498;
	b=CmSNYOH+zopa6ZvggW1GIY8THCzQdUTtv6M/dYZESp+5AZwkEG3oGW2b+OLthNZP6Bo4
	 HttEZ7jXcrpqkhUqYNC+3qtenLDW3DvB1E4ZfboXAirporN5XJSnwnk0u/OaSjSNM9kRb
	 oQlV9K2bUQmmbh7jWV9gC+EtjsluLwCaBZziODTm/czG6rkHlIL/xM+gnz7VC79ECkex/
	 HHkaRkebkqrH17f++VFwkXOK0qiEV1WwI88Xq/bk91XzXUtjH69TJOQavCdTK2lr/9lws
	 qBgdjDsFX/NbwyAWH1l5NnDS3Eb+U0OVml/W9gTvsMAQRno/5mUM9rU+kbRYiLx0lPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006498;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jwcbVzsGJQVaPvZZE/0hrvvDKXRKuseaROPAhM5k2nA=;
	b=bgLr/iiDrWOOF0uhTI8Ua8Nw7qthxT3b/lwk+e19v63zucypt8fXer2k6wZBDeDayS29
	 EkIyUjiWN/3lmLxA7qezTnugPaWvuYCgTGgwtl9/PlFcXwIx+yWUhiAFzvRcyn7ulS7Xp
	 XszeEKOiYICVSQAIWAwJuNxVtun2iW5o6WUE1MSoLCOAazVh/MM2IhcyAR4xsuf1SW7a4
	 I4SlTpw6r3Lms2GsaaXULK6nRuJOEG6UdvbBIxNPe4GbDxhlw3iUNbCtaycoLLqT2PLRn
	 4K4SVqDt8ASx1VKLgbhMeMMOyiDwQ+8XQTHClSATtFTMquIgie6+zglKwkiEr1yVoow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Usr8SlTy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MSaI0gk8;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF3606A32F
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 23:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DF3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Usr8SlTy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MSaI0gk8
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 40EADEC011F
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:08:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 06 Nov 2026 18:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794006497; x=1794092897; bh=jwcbVzsGJQ
	VaPvZZE/0hrvvDKXRKuseaROPAhM5k2nA=; b=Usr8SlTyEfG/aaNlN79Z+dyd/x
	zVZcdrS/eBohvGm6OR1bZ9McrhNGxc9DTnbZ0Vgc7ixvdk0SktfbkvAvHWGSXeZn
	r65EnPyASJ1eex9O7Dszne8T/krLqvGGUWDp0mvWE6rkeF4iolUWIfV7GMnZCd0k
	Slskjjn322lqNZeSJ7wfJVjFjiNxVIrbqVFht0f66k0/faJwwh6HhoaWSuuxVb4v
	KnU5iA35pbBe6L0X+zR4ASHN3KNau3HdmCKmNCcX4UX2kduWNi5bk4YBPMobKB7J
	5JHMsel978fFPV0vWgBkmto0JmnaXQzrOOiRGjxi23GmgIR/z5/x+JPL0Lng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794006497; x=1794092897; bh=jwcbVzsGJQVaPvZZE/0hrvvDKXRKuseaROP
	AhM5k2nA=; b=MSaI0gk8nasdLTXh2ezczyuUWjTKf5jP8ZDzcrbaKpZOfxaKyLL
	NiG1pidft0x3HHZDv23qa6LTs0lmNwtd36BEwj6+rR8Kdt6y/dBFNKALqf2mpc+h
	gIXeFJqul9ej+l6IrxkuOTCpk+FxKr9DpuU4J/2y/hMjRNFehozsQeXHk2kLm3pb
	4FVpd2QjxdT8dUIt5ZJQQsQy3IQTfWqCwZ/lFuJo+1lF6CA7rn1GgKn92Hk/x8pC
	z3vnq/bfsJYbYdV+CF0JOvRhFgh5KsTYFMBtM15FlTpvqkNNqoW8DNAXuwqMoHR1
	xL+md2MqDYu9PF+G6vDtGJ4sbPFlLob5AsQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794006497; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Q4qDHsKWR6Zy68m4/JGtGBoqYdP8cAPdyxXm4KGr/vFwqA8
	+hsfX4bgVKNnSyz8EIqPcEGUU97Lex2sUeXBFmbowVcgbTRjRyr+6U77SGlJEDPe
	iv69Q34rTCHJgUJeDc6sfmIspBjHnHJLGnoHCMunLeHtW7wyDARd0Ir8TzjUEzk9
	58N2ZRnSNEm6GJ6RkPXekYy02Mt6t/Zf7/kdoMDz+SbKEUOISnEDNdQHLSrnVpKb
	EjFH1oaSxXD4CCe18IkBgSoGsDcT/eKNDJCkRT/bEbKuga2pUtuLO/zy8B34CU87
	yrZPhkRzcS5YsV6alTXRN3e0nOpIh9W6z/S2VLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2YWkj/PGPlCMsdcYod1GqDDJSlXROr6YvQ2NC1yWock=:lwKfP7exXJOxo5IzuAk2yxhupuPSbLmpMsYimoD3v6I=;
X-ME-Sender: <xms:4V3uatTO_a9jqfrFZFx241lMxhpuJyB4jPbKuItl7Uxr5L4pGG3DNg>
    <xme:4V3uaqfJxHEk_MLyE--IiIYKc2e4URu0-EmmYz3Z-DSK6nZRJzE5kmnUoRp4lOpQP
    v7D3athklLNr8y4d1MF0joCRAFVSQSKnnIy2kY-QiLR8C3UotCyQVLq>
X-ME-Received: <xmr:4V3uaspArT7-dOcJsNHExyY8wZNIpLm2MI2g0eLuERdbWEXfiDeFq5Xp7rP5n6Z8QFRE9Ii8oQ9RAR2QExDr4ZN1TnXJ-2xxFEcJ>
X-ME-Proxy-Cause: dmFkZTGfOIJDOvw8EXrgDU1kantyufttpOxIwsphMVloSaFTNfBkViFCJQJG7L2z18/pbl
    JdZzw7ENU1f/leBdkfnVJR+WdMMeWEpl+pTD0442QmC+OP7t0iVqwlAE2aD29wnN259SdF
    qlMe1XvnfPglUlXzRrGX+MoqvEVjz+gUL99Jg2z3T6Ty13GvEr7JUDFdyUVeKQpXV2EyB6
    Oy1SUzRuxXj08OvnGWpfdZRggVwc3uudJxkqByjKpHc2YERXEfCDuFNFgK56GzfMGVBHa6
    VipaKm0arcdSVlMWnOVNOnykv2+PJm260pU0KPSW8oHzqa1nE2HGpOqJLW4CpLSM8i+HdA
    vuti9Krb+6gI0N/efgUYesLghq3SWA5CbOKlpxg0oPBhhQt0obUpcHEQPEzi7n5uTY0+5D
    +5sn0RZ89LZhLTuEyLmJhXr9zPeCHjbq2sAv9kdAW0h0dvydWTEIypOwrbbno8Tw8eSAQd
    tmmC88CmRh8PbwzRUpSgonS2ICwr/iXVedO5qmbusfXe8tnZPikIC/fDdTbKMxKzjTlRKf
    nGpzLdf5Z51G439zgNJ/XUfueClT8Oc/Fc4szx2OA6Sc1fPsoDpCQNfMShwZFK9CjvQW3m
    haN4OCBoW/42h2F6hAhf0K5m4qqhqrzgfTvw+OBeIdBFir68Kr3q+mZwTUUg
X-ME-Proxy: <xmx:4V3uar-BHyJbuwFikVxyq0JhzJueREoWmkssWPc8Y4RWGwHvPtKa6w>
    <xmx:4V3uaoenhXqtlQJvS0VVFdnpOJLK8LIPbsRNO_TS-CxfQ4XBx8v_8w>
    <xmx:4V3ualK9D1HjcXlxgtZIRyEZasQIz-pPR7vQVqDU4UPVZsJVARHxkw>
    <xmx:4V3uaoi-a1lNS5IjjagMaUYCp1cQWFVxPblsaIUk6vr8BUzftvdu6Q>
    <xmx:4V3uagDMDbgG6xKfN8I70gt2UhGF97Vpx9Je4zM05IFERjDPLx9P05Po>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 18:08:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 3/5] doc: stop calling root refs pseudorefs
In-Reply-To: <ac3ed53867d868c36a91f4c5c6be1fe2d874651d.1794000450.git.andy.koppe@gmail.com>
	(Andy Koppe's message of "Fri, 6 Nov 2026 21:31:06 +0000")
References: <20261022212903.177261-1-andy.koppe@gmail.com>
	<cover.1794000450.git.andy.koppe@gmail.com>
	<ac3ed53867d868c36a91f4c5c6be1fe2d874651d.1794000450.git.andy.koppe@gmail.com>
Date: Fri, 06 Nov 2026 15:08:15 -0800
Message-ID: <xmqqzevld0dc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Andy Koppe <andy.koppe@gmail.com> writes:

> Several manual pages still use "pseudoref" in its old sense of any ref
> outside of "refs/", which the glossary now calls a root ref. Pseudorefs
> have since been restricted to FETCH_HEAD and MERGE_HEAD, which are not
> considered root refs.
>
> Replace "pseudoref" with "root ref" in those pages, giving HEAD and
> ORIG_HEAD as examples. In git-worktree(1), say that both root refs and
> pseudorefs are per-worktree, and drop the description of them as being
> directly under $GIT_DIR, because that does not apply to the reftable
> backend.

Thanks.  Clarification of this kind is very very much appreciated.

> diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
> index bdc74d291c..8f8fe36a58 100644
> --- a/Documentation/config/core.adoc
> +++ b/Documentation/config/core.adoc
> @@ -376,7 +376,7 @@ core.logAllRefUpdates::
>  	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
>  	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
>  	If it is set to `always`, then a missing reflog is automatically
> -	created for any ref under `refs/`.
> +	created for any ref, including root refs such as `ORIG_HEAD`.

We are witnessing a grave mistake getting corrected here.  Nice.

>  `--include-root-refs`::
> -	List root refs (`HEAD` and pseudorefs) apart from regular refs.
> +	Also list root refs, such as `HEAD` or `ORIG_HEAD`.

Good.

> diff --git a/Documentation/git-ls-remote.adoc b/Documentation/git-ls-remote.adoc
> index d71c4ab3e2..7ce7df3149 100644
> --- a/Documentation/git-ls-remote.adoc
> +++ b/Documentation/git-ls-remote.adoc
> @@ -35,7 +35,7 @@ OPTIONS
>  	with other git subcommands.
>  
>  --refs::
> -	Do not show peeled tags or pseudorefs like `HEAD` in the output.
> +	Do not show peeled tags or refs outside `refs/`.

Hmph, is there a reason for saying "refs outside `refs/`" (as
opposed to "root refs") here?

I _think_ (correct me if I am not remembering right) by default
ls-remote shows everything under refs/ (with peeled tags) and HEAD.
It is not even "normal refs including root refs", i.e. ORIG_HEAD is
not shown.  With "--refs", of course ORIG_HEAD is still not shown,
but it stops HEAD from getting shown.  So "do not show root refs" or
"do not show refs outside refs/" are equally slightly broader than
needed (meaning: with or without this option restricting further,
any root ref other than HEAD, like ORIG_HEAD, are not shown anyway).

Do we even say what are normally shown in this manual page?  Perhaps
we would want to update the description to say something like

    DESCRIPTION
    -----------
    Displays references available in a remote repository along with
    the associated commit IDs.  By default, all normal refs under
    `refs/` and `HEAD` are shown.  For each tag object, the tag
    itself and the object it tags (colloquially called `peeled`) are
    shown.

upfront, before going to the OPTIONS section to tell the users how
to tweak that default?

> @@ -118,7 +118,7 @@ line shows the name of the object the tag points at.
>  EXAMPLES
>  --------
>  
> -* List all references (including symbolics and pseudorefs), peeling
> +* List all references (including `HEAD` and symbolic refs), peeling
>    tags:

Here, mentioning symbolic refs as if they are anything special is
misleading, no?  Symbolic or non-symbolic, refs are refs.

On the other hand, "all references" should logically include
(normal) refs under `refs/` hierarchy plus "root refs", so "List all
references" is technically incorrect.  Perhaps give it a bit more
correction, e.g.,

    List all refs under `refs/` and `HEAD`, peeling tags.

which would make it in line with the updated DESCRIPTION suggested
above.

> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
> index 37a5019a8b..c775334230 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -163,13 +163,12 @@ still see a subset of the modifications.
>  
>  LOGGING UPDATES
>  ---------------
> -If config parameter "core.logAllRefUpdates" is true and the ref is one
> -under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
> -like HEAD or ORIG_HEAD; or the file "$GIT_DIR/logs/<ref>" exists then
> -`git update-ref` will append a line to the log file
> -"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
> -the log name) describing the change in ref value.  Log lines are
> -formatted as:
> +If config parameter "core.logAllRefUpdates" is true and the ref is
> +HEAD or one under "refs/heads/", "refs/remotes/" or "refs/notes/", or
> +if the file "$GIT_DIR/logs/<ref>" exists, then `git update-ref` will
> +append a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
> +symbolic refs before creating the log name) describing the change in
> +ref value.  Log lines are formatted as:

This mention of files and lines may be obsolete in the world with
reftable, but I am perfectly fine to leave the correction on that
front to another series, and concentrate only on "what is a ref?
what is a root ref?  and what is a pseudoref?" clarification and
nothing else.  And for that purpose, the updated text is a perfect
fit.

> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> ...
> +In general, all root refs and pseudorefs are per-worktree and all refs
> +starting with `refs/` are shared, except for refs with the following prefixes:
> +
> + - `refs/bisect/`
> +
> + - `refs/rewritten/`
> +
> + - `refs/worktree/`

Good; the same comment on "are these frozen?" applies.

> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
> index 8d9be02036..2e44cc5003 100644
> --- a/Documentation/gitdatamodel.adoc
> +++ b/Documentation/gitdatamodel.adoc
> @@ -211,15 +211,28 @@ remote-tracking branches: `refs/remotes/<remote>/<branch>`::
>  default branch. This is the branch that `git clone` checks out by default.
>  
>  [[other-refs]]
> -Other references::
> +other references::

Nice attention to the detail.

>      Git tools may create references anywhere under `refs/`.
>      For example, linkgit:git-stash[1], linkgit:git-bisect[1],
>      and linkgit:git-notes[1] all create their own references
>      in `refs/stash`, `refs/bisect`, etc.
>      Third-party Git tools may also create their own references.
> -+
> -Git may also create references other than `HEAD` at the base of the
> -hierarchy, like `ORIG_HEAD`.

Good to get rid of this and adding a separate entry for root refs.

> +
> +[[root-refs]]
> +root refs::
> +    Git may create references other than `HEAD` at the root of the hierarchy,
> +    for example `ORIG_HEAD` or `REBASE_HEAD`.

Is this a good place to talk about their naming conventions?  At
least we want to have a reference to where we talk about it, I
think, just like you did one for pseudorefs below.

> +[[pseudorefs]]
> +pseudorefs::
> +    linkgit:git-fetch[1], linkgit:git-merge[1] and linkgit:git-pull[1]
> +    create the so-called pseudorefs `FETCH_HEAD` and `MERGE_HEAD`.
> +    They are not references as such, because they are not stored by the
> +    ref backend, but they can nevertheless be used to refer to objects in
> +    commands such as linkgit:git-log[1] and linkgit:git-diff[1].
> +
> +See linkgit:gitglossary[7] for further details on root refs and
> +pseudorefs.

Great.  I do not see a need for so-called here.  As technical term,
pseudorefs, references, and root refs, all are officially sanctioned
words, and there is nothing so-called about them.

> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index bd9f345690..822604278a 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -350,8 +350,8 @@ Under `--pretty=reference`, this information will not be shown at all.
>  
>  `--merge`::
>  	Show commits touching conflicted paths in the range `HEAD...<other>`,
> -	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
> -	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
> +	where `<other>` is the first of `MERGE_HEAD`, `CHERRY_PICK_HEAD`,
> +	`REVERT_HEAD` or `REBASE_HEAD` that exists. Only works

Phrasing "existing pseudoref" in the original was wrong, but the
updated text feels a bit incomplete.  "... where <other> is the
first ref among X, Y, ... Z that exist" or something like that?

Overall, very welcome clarificaiton.
