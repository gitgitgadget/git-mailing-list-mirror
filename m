Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103357;
	b=dAWB5nGRKpOMMIu77xo0WImE9Bn1XhSoffoOTo58R5PnMGFCGPyPIqKBorXGWNwXx0Fn
	 wI4Zp/IctXXU+KI0Cbzp9QLlkEZHrcr2DQpPXLaA4FwtU+3knPvY3kte02L4Tmy4Byhls
	 tBYgKpnzFPXOAedUvApUbvBYJwBEHwNxdUgL8H33mqrwFbuiml7KR2dxj/cRMCpC72cC7
	 Zw52NPXTz/krd7IRAAW4h61oe4TwzhHvz3b/Ob8k2rrLbNemA7gjy24v2bB6fxSCaT4Rr
	 LBnJ/uSw75kFZNeDA/Yjpt/qqn/mjgDI7JYdbgBzX+T1YSDBbc0GASQxRKExp8UZ8Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:From:In-Reply-To:Cc:
	 Date:Message-Id:References:To:X-Mailer;
	bh=uRAnE7tQlh2PFmzhSqfnC0bDMr1CUsBvmmZI/mI2ZS0=;
	b=pQeogrD1CXQ10ZYLckf1ATp6VUWiWMd6bwcLYPjyxsWpjCsBX0wBwmYx1ibV1u00yV0W
	 ZJnG6nocCU4tcAIF3KPjT4zXAT8b/kxCZY2N6eKrULlWhTU+X1HWDk+40Ig8giNSq8Y20
	 0jSGyJsLEUw2yHVwmZl7MTAtsVfASXooeCIjOuFsT6/sy7qWKGhI20fx4hxXLIGzYa+MU
	 TRLuFOI+gvmmT384v/lXdci3K5ldrbeyw/vrapxDTvKijnxvDTIAEN3KITTxHaH8yPHCQ
	 Qrtyj8pxBdGi8jOlFwLCWL/ttyJ0MRRN1IAJJQgNkyNOO4Ng7XXkpIbVV2Ym3Lq8SXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="E6/R6Yub";
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A42606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E6/R6Yub
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5365d26ccbdso47467171cf.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103356; x=1793708156; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uRAnE7tQlh2PFmzhSqfnC0bDMr1CUsBvmmZI/mI2ZS0=;
        b=E6/R6YubkTEnqidUHjLcb8sz6BGMTAn6pgHg669lJ5IkX0f4aG4Hsez0dcIl0AMe4D
         Uz11Afu3TbRLwJWJqMi9oRvHcdojccL46aRk63TrDI1zno3qVtb/MaB5wzyHm6/LETkA
         6MAhI3nymewTew6vnmTY5aDIo/L3ncmOAWxlSSvB6TRJKrzKEYk4OpoPnAYLFUlOn19M
         l5qknHT5Zn5iVWIMfGpbdauP9s4GyEfmbj5YXnTtP4fUhjmecmSJWNrr7yJV2MBcfIfx
         TrdlOXyZYNYeKLcwCsOqSymnPPkYawc2Qp41lMrQQ2OMvS01dbmSiIA9mY9MGbr78x7o
         MVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103356; x=1793708156;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRAnE7tQlh2PFmzhSqfnC0bDMr1CUsBvmmZI/mI2ZS0=;
        b=W+uOOCc1M3a4pjWPDbEsTnp84nObEHrOVGthMmynDZZvCHX1zYPuygEft1CCLP1uGX
         X0BKafLMcBEcl854aX/b2rOfurkmA/v3AU3ngWfhvynsVPaSyy+pLdDHj9px462IVN9i
         0ZEDWpPAnZoxVie2oYJauvBeiE4K8/O+llhtuCHGFe+4OehUxtgbtSnwAihna/BcIkHN
         s+t0y5UIi1nml7nGZaFzdj5WxZ24gG7lXWzPoKy/idkZu4mQpkqnRYeXJNv5V2TtT8bw
         Pg5Z2HrDR8CdlcYcOBwGLAZcjpRuyo+iR6FTs3SlsDG21qSLvNONjOHRKhNuVhXmxpp8
         tB6Q==
X-Gm-Message-State: AFq9FYJptj/DS836/Dm0JWocUUJTHShEigxB4EIBxE76uMndMInsqQX5
	NEPsNooWyVqCtps7swwDPdYYsMTlzNyEZsgp21K1exALLR/Rntf1v4TBJP6B5A==
X-Gm-Gg: AYBFou22SOS0AlOIu5aCFfieL+3mIgHIpBT7e9trYtAUT1zd55Zs7JyNaN+jUdcxW5b
	stsxjOZFKdAMinSrI66cBMjyUT2kzcO6YrGttIuAQrXzdYXYqe9aeoclZlUJ69ic2DQcRJabqab
	nC+dEMvomKNZGLxjgMC0acS4L+PvK0pjwEiwrXxaS8Zh2By/xA+pE5VJT3PiD90sPHDcjHUCYeO
	pMvGPGDOstLbsbAeCJh1pEaOM/MJj2hChUoSa4g3CD8+3X+x71anbK8BM9V1u8WZoE5oTa6+khW
	QIJEjbnIZLbA1sOKSAHqp1uVuB7PQwkc0vO/rUuuDEH6+XwXav32NxnUdiSEVoFi+7vg4vXe5LA
	olDdH0ugLKwkTrEVZoLswOzLIBf+x5H03jkIyPrKQ64hcOe8C2lQBJR348ZPlkMI+x0Ek0LV3SE
	p1zM2KtbbbGlOIbfD9CM7MLWInTn9/swKoF43wtX+YYKbTX9CxLN48bxUsn9wcvwcW0sH0LHTPH
	cVKzNfwBRbS4k2LMMD8+B0wF1C556kbpvj3Ypgp+3wW5LcmrL+vhL4GkmC+EiTLeHFmJYC7olKA
	/q2Ao3jWbZ3JfgC4YTi4zKx2kr3YaV8SdDVFPfUmkvpwjgejfRfCZlP6sCdlwnynGWGR+EwvTu3
	eCG4kGCaStS6D9i6pMeWhwLn01o6mpQ==
X-Received: by 2002:ac8:5a0f:0:b0:530:1b1:72be with SMTP id d75a77b69052e-5383b6838c2mr158356941cf.40.1793103355330;
        Tue, 27 Oct 2026 05:15:55 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b03e:6cb9:e8f7:7afe:bb4c:405d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c38easm77079411cf.7.2026.10.27.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:15:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Julia Evans <julia@jvns.ca>
Date: Tue, 27 Oct 2026 08:15:42 -0400
Message-Id: <E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com>
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 26 oct. 2026 =C3=A0 09:13, Julia Evans via GitGitGadget <gitgitgadget@g=
mail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Julia Evans <julia@jvns.ca>
>=20
> Currently in the glossary "object name" is used as the canonical term to
> refer to an object's SHA-1 (or SHA-256) identifier. However, in several
> places in the documentation, "object name" is used with a different
> meaning, for example:
>=20
> from git-rev-parse.adoc:
>   Usually the object names are output in SHA-1 form (with possible
>   ^ prefix); this option makes them output in a form as close to the
>   original input as possible.
>=20
> from gitrevisions.adoc:
>   Here are various ways to spell object names.
>   (lists <refname>, HEAD, etc)

Perhaps =C2=AB notation =C2=BB
would be the better word here, if one is needed.

[Let me just use =C2=AB 40 =C2=BB as a magic number for the below,
even though we know there might be other lengths.]

I think Junio misunderstood your comment on this? Or perhaps
the intent is overly-pedantic: =C2=AB spell an object name =C2=BB might
mean =C2=AB these things all represent the 40-digit object ID and
are thus interchangeable =C2=BB, but I do think I find that interpretation c=
onfusing.

I read you as saying that our docs say an object name is=20
the 40-digit string, but some places use it to mean all the possible=20
notations.

It does seem simpler to have one word (ID) for the 40 digits, and
another for all the various ways to write down something that
resolves to those digits.

>=20
> from git-describe.adoc:
>   `<commit-ish>...`::
>     Commit-ish object names to describe. Defaults to `HEAD`
>     if omitted.
>=20
> Especially in the `git-rev-parse.adoc` usage, it's clear that "master"
> is considered to be an object name, which is not what the glossary entry
> says.
>=20
> It's important for the documentation to be precise, and it's useful to
> have a way to unambiguously refer to an object's SHA-1 identifier.
> For example, the term "object ID" is used many places in the
> documentation already, and there are places which say "object name" and
> mean "object ID", for example:

I love ID, btw! Ever since the datamodel patches I=E2=80=99ve caught
myself being more precise in my own writing, using ID when I mean
the 40-digit string :)

> from diff-generate-patch.adoc:
>   The index line includes the blob object names before and
>   after the change.
>=20
> from gitformat-pack.adoc:
>   The base object name or offset is not included in the size
>   computation.
>=20
> Update the glossary to use "object ID" to refer to the ID, and warn
> readers that "object name" does not always have the same meaning. If we
> ever reach a point where the term is used consistently, we can remove
> the warning.
>=20
> This leaves us without an obvious term to use to refer to "a name for
> an object", but since that's already the case it's better to at least
> clearly acknowledge the issue.
>=20
> As a bonus, this aligns Git's documentation better with how the terms
> "ID" and "name" are normally used in the broader industry, where an "ID"
> is normally understood to be something that's interpreted by computers,
> and a "name" is for humans.
>=20
> This is similar to a patch Junio suggested in 2020:
> https://lore.kernel.org/git/xmqqft4zn2f7.fsf@gitster.c.googlers.com/
>=20
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>   glossary: use "object ID" as the canonical term
>=20
>   If folks have a different preference for how to word the definition of
>   "object name" I'm happy to change it.
>=20
>   The only really important thing IMO is that we make it clear to readers
>   that "object name" doesn't always have the same meaning.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2282%2Fj=
vns%2Fobject-name-id-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2282/jvns/o=
bject-name-id-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2282
>=20
> Documentation/glossary-content.adoc | 18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-=
content.adoc
> index 52301a56dd..b1c216893a 100644
> --- a/Documentation/glossary-content.adoc
> +++ b/Documentation/glossary-content.adoc
> @@ -217,7 +217,7 @@ transferring objects between repositories; see linkgit=
:git-replace[1]
> for a more flexible and robust system to do the same thing.
>=20
> [[def_hash]]hash::
> -    In Git's context, synonym for <<def_object_name,object name>>.
> +    In Git's context, synonym for <<def_object_identifier,object ID>>.
>=20
> [[def_head]]head::
>   A <<def_ref,named reference>> to the <<def_commit,commit>> at the tip of=
 a
> @@ -296,17 +296,20 @@ This commit is referred to as a "merge commit", or s=
ometimes just a
>=20
> [[def_object_database]]object database::
>   Stores a set of "objects", and an individual <<def_object,object>> is
> -    identified by its <<def_object_name,object name>>. The objects usuall=
y
> +    identified by its <<def_object_identifier,object ID>>. The objects us=
ually
>   live in `$GIT_DIR/objects/`.
>=20
> [[def_object_identifier]]object identifier, object ID, oid::
> -    Synonyms for <<def_object_name,object name>>.
> -
> -[[def_object_name]]object name::
>   The unique identifier of an <<def_object,object>>.  The
>   object name is usually represented by a 40 character

Should this now say =C2=AB object ID =C2=BB? And, while at it, should we=20
mention SHA-256/other lengths?

>   hexadecimal string.  Also colloquially called <<def_SHA1,SHA-1>>.
>=20
> +[[def_object_name]]object name::
> +    Depending on the context, either an <<def_object_identifier,object ID=
>>,
> +    or a name used to refer to an object, like a branch name or other ref=
erence.
> +    The meaning of this term has changed over time so it's not always use=
d
> +    in a consistent way.
> +

I wonder if we the use of name is consistent enough to define=20
object name as an ID or =C2=AB any of the notations in gitrevisions(1)
that [would] resolve to an object ID =C2=BB ?

> [[def_object_type]]object type::
>   One of the identifiers "<<def_commit_object,commit>>",
>   "<<def_tree_object,tree>>", "<<def_tag_object,tag>>" or
> @@ -553,7 +556,7 @@ The following pseudorefs are known to Git:
>   to the result.
>=20
> [[def_ref]]ref::
> -    A name that points to an <<def_object_name,object name>> or
> +    A name that points to an <<def_object_identifier,object ID>> or
>   another ref (the latter is called a <<def_symref,symbolic ref>>).
>   For convenience, a ref can sometimes be abbreviated when used
>   as an argument to a Git command; see linkgit:gitrevisions[7]
> @@ -645,7 +648,8 @@ format. See linkgit:git-reflog[1] for details.
>=20
> [[def_SHA1]]SHA-1::
>   "Secure Hash Algorithm 1"; a cryptographic hash function.
> -    In the context of Git used as a synonym for <<def_object_name,object n=
ame>>.
> +    In the context of Git used as a synonym for
> +    <<def_object_identifier,object ID>>.
>=20
> [[def_shallow_clone]]shallow clone::
>   Mostly a synonym to <<def_shallow_repository,shallow repository>>
>=20
> base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
> --
> gitgitgadget
