Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201061;
	b=X/bTtroGYYJGcJYVIGnOYEC2taYzdNFjkL3eub8kIFoDsVHj6DLrh4oNWGlrQRw1wl5U
	 8Y9tC69bpP0hR3Dk0/Z8eCqNrHIXmZo4ttfm0d0s7mQKR43PsFk3xCS6o5jHBRjKmjygw
	 U++fOOF7fUhmXdePRTsOBMrX5IzQNex3aIKmPwvSISl8eY/kP0tnCEvH2PvtlF8Vr1gEc
	 OENnDTSybIAE/QNSDx23gfG0B88kzVAd897Wb8Ozc67f+mqMd6S/6ZphLEyC84wAVxM54
	 z3uzp+Y4LxWqsSTWcwGg8cbVltk0GFF/Z2ofQk3esXc5LzfuavOP2EzpKoBQA3T9S4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+/57p3kdpd+DOBeG99d9eHlUM7znyRZGoMRcGpK9fHY=;
	b=lXIyLQhbKPAaDj3qDWKNdjJwbRzDPcdBvGI9q+DYDf5xTXpes/ZPA3jYWE47lQTzY3y0
	 bZRFbRMx3h/7M/qR4l7asvZSNI3SvaPWsKwyTgI/Cwn67kVPEmHioemekD9sjtaQSD+G/
	 TPPibyYRZ9NdwzQKo1Qp6UyiT8sVyr6LUWfiZul8wHYQu+kQuKpKlBUl3MZawuUhvE2ub
	 4O+Z5RdxLYdQ46l7+bLSsIs8nOfPFi3cL7w7ahJnXF3m90Z8iOTuf35usRHe5AUbfqna4
	 tgSZkJOQcjK3xcIhUjl12lIWiqBCrHKMxnSxQjN/oibs0BdZDpNvi0/dHr4C7VjwsTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IZd7D6H0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o+dAlmm4;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAD60A2613
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 18:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6CAD60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IZd7D6H0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o+dAlmm4
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C93BFEC08B9
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 13:57:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 20 Nov 2026 13:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795201049; x=1795287449; bh=+/57p3kdpd
	+DOBeG99d9eHlUM7znyRZGoMRcGpK9fHY=; b=IZd7D6H0jvQWo0dcYTgk83jPKI
	K5oGBysBlWoo0yyM7syfl1fO1n2FANlwDRDd2eRz7jkmV5GcwuhkL+nEuj2WDgS7
	90qfZaZSQ5EsExGRO8GG1LnHcmQWI8TVjQH2+Dai97OT4ynSKJkl6wgKdTyg7Fv5
	R0en7W8GDrGy38vRgSI9HY1TxF9FAArufHYzUy89b5R73TMaCMI2bCNyL1vYIKX7
	oXTP7YBu67BUwBnhTMc0aXGc95qpohIs/ZjNbxF4dSX+GHZivlUF/z6ifEqAsgUW
	7qSYjlXU8VuWqLDZI8le4ZNtN8Rap+jH/gBr+q8C8TSOby8Qfmnu2TEqndiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795201049; x=1795287449; bh=+/57p3kdpd+DOBeG99d9eHlUM7znyRZGoMR
	cGpK9fHY=; b=o+dAlmm4FqKLf6JDsMaom8rt/w9xoE29hV54I/VLdW9hRW6USWV
	+dvT+7wyePbRHZ1TgLbBIJMdcrBrtOawTradceM/zlZ5KQID6clUFR+6mT9nJ6FJ
	zapN49khbZy3RPZKZPYfYQluNsiX+Dtl+driDE7bBkFFd4zW7GrLu0TKvivUGuY+
	jTuarMppL42e1bb65noDUUfrS1uy2TDyvhuCkifugUxwwKi1nn7FFrJtp0+Vpl/i
	Vs3DjOru3TgAvn+GAR6d/grve3i3SxD+VOfrsb3Yn3OLr8m4mBLzW2xM78DftZsM
	8ukGKtIEmFpHlS92v3lDlAogVErH5ibPBow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795201049; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ifNrqs+i4Ya1rfnH7q8csjU04zUIcuv+x1JOz89AUL6ok3h
	g2wMOuwLyN1kGNfE5jwEpXM35szUtivCZUm+nmFO4A9orB0+dnilv7lxw4ur8n7v
	jFMNlKxrGLAQmoslNUKefBUmFufgJnQtoo1Av19gvT1EZhAO1n4BJeY//SyxWnpJ
	N2zogBeNU4hMDcWoCr/rJweQQ9cYeE0nFhl4PQZRc4QShpZcHGbfgACwRsKCqSuO
	SaKNGmozJCKAmbBJrU7zeW4iqNAwG7BxosWvmOBpCCf3ZRNwr5RcKPfR2YAQ9S2r
	0FzYyDKeOH9gEQItSSzBNL973WwrSOVsQcaZL6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:n6rFCo98JI/lSrz3Td93FlR4ISCCDhCQ+q1mzNoBKRk=:G5BusBMRUJ9qVX0DKJvMHLw7HsRBfRq0vy233Ufrg9I=;
X-ME-Sender: <xms:GZgAayHlZRgiAmo_Bjl6WjlR77fgg5rpNHTL0sNHX8aM96IJssAioA>
    <xme:GZgAa14VXvoejfAgwU1ZaK9HuxZE5DNzuQhN7IehHrSJxdPFvmXJaqiLQaYAyuSVp
    uEkNnR5tYXV7pEZQKTQ7R2vhxCpRvVh_QaLjBCmRWgWcjjBjpbQeyY>
X-ME-Received: <xmr:GZgAa_xhB9-OgQnEgu5lpgWJ6eJznvoRoKODQ0FGPh1i0f0yqGWpQmwEl1vfV1PSpJVgKe1UQOjApqeWnD1Wqz-OvWtlz2Uf24j5>
X-ME-Proxy-Cause: dmFkZTF8N1JPw4w8l3aMDUpC6UC+r47orKtSLoQeYUtLAQGfTdBzJxWEwX71AUA8gt9mdS
    N1Uu4+MVDSYQoSXjneZSD66QUcFxIwnHSB+v8iAuslMqntdhTHDpUM1XNnBeJNnqfJkYIw
    ihrbMH1TZiBlHdaVT8JWRG8tr+9LRY9d/oKU8MzYyQhF1ruQeqC3oxbHPuHLqai9uHo7bS
    wUpzxi6e6YJv4AufAswMQmTD9We5GhZl8ctwhAduOA6biFtLvA+Vgy9b+ncaBeBiyFoxAH
    9QMN9MJvFElC03i3R6lSzRFoIl3d0ck1Q6bcIAPgbNOfOoUv9WRLflmuwf1ZjExk9RQUNo
    MDUQKXCaptMo39ydJV0AvF3TG2e9YwFxq1E86AXza9yGtgxUHaMi2mq2yhdYu9GlEMOC87
    k+cQ6FtMzu5GD1rdZM8wBJBaJLQTHBzZPQW9i/lKdQMA2sU+HeFURGCCh0gVBrWOID5rbY
    9Fhn+EirZTEOAmNnTaRfloM0MtBrZUD5VzmM7YkOOhIVEe4IlHNMnuZG+siqluuTGC64/T
    A4KRh/JIt2dyV7ZEE+4lJw7O1o/iBpxhxf7ujIkj9DQKbVMLSr/VDirIh7uOwvTe1RGdk5
    jpNAH1DYmSphx8JQTwz/RRo7DsOBFLiv1LijBemLGc8ZVYS5NIv+GzoU2xSg
X-ME-Proxy: <xmx:GZgAa8PVCYIq7rXs3cRZzQbkGupqTC7CqxP_xwyar3kYLlafhZlQSQ>
    <xmx:GZgAa9llgd8kRIeQ340P67HcjRMHVEgU62pAYjeX-YS5FDvWAF87Mg>
    <xmx:GZgAa5QJR4_ldLr0Iwzbb-EvHrkRsL1nMZxMCoDpHQvvZYZeShae4g>
    <xmx:GZgAa0UIUcl57NcCLyocCA5HcVl2qCofqE8qbHPriuxK5ahQRyr7Yg>
    <xmx:GZgAaxurPeOwzTiJqUAlEQALKJx-lcSU4uIsHRZ62o9CMB9ebXSBvA1c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 13:57:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 1/4] branch: move the deleteMerged opt-out check into
 a helper
In-Reply-To: <37ef7636e069ce528728c43cd79f678293e0d035.1795184664.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 20 Nov 2026
	14:24:21 +0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
	<37ef7636e069ce528728c43cd79f678293e0d035.1795184664.git.gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 10:57:28 -0800
Message-ID: <xmqqy0anpbzb.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A later commit adds "git branch --delete-integrated", which deletes
> branches whose tips are not reachable from their upstream. Those must
> honor branch.<name>.deleteMerged=false as well. Move the check into a
> helper so it can be used in both places.
>
> No change in behavior.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/branch.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index b536b619bb..2c1a8b8395 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -824,6 +824,23 @@ static int branch_pushes_to_upstream(struct branch *branch,
>  	return ret;
>  }
>  
> +static bool branch_opted_out(struct strbuf *key, const char *branch_name,
> +			     unsigned int flags)

I am afraid that this is a somewhat selfish choice of a name that we
would regret later, as it assumes that "delete once it is merged
elsewhere" will continue to be the only destructive operation that
people may want to exempt some branches from.  The configuration key
is named very specifically for that destructive operation (i.e.,
setting branch.<name>.deleteMerged to false is a way to say "no,
even if it is merged, do not delete it"), so there is an impedance
mismatch.

Either

 (1) naming this function to make it clear that this is about
     opting out of the deleteMerged operation, or

 (2) naming this function to make it clear that this is about opting
     out of ANY destructive operation, and renaming the
     configuration key to something less specific than deleteMerged
     so that the user will be saved from any new destructive
     operation we may add in the future, e.g., "force update to what
     upstream says", by setting the same configuration variable to
     opt out of it (e.g., branch.<name>.noClobber=true)

would work better, perhaps?

> +{
> +	int opt_out;
> +
> +	strbuf_reset(key);
> +	strbuf_addf(key, "branch.%s.deletemerged", branch_name);
> +	if (repo_config_get_bool(the_repository, key->buf, &opt_out) ||
> +	    opt_out)
> +		return false;

The lack of a key, or the key explicitly set to true, will cause
this function to say "no, this branch is not opted out", which
smells like a risky default to me.

Putting the devil's advocate hat on (because I understand why the
inventor of a feature wants it to apply as widely as possible),
shouldn't this be the other way around?  If the user does not
explicitly say "I am fine losing this once we are done", shouldn't
we be treating it as precious?
