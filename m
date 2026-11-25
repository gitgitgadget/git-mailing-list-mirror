Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616046;
	b=qrGqhZkDVgrAtjoqExVmyJZVOhKxqmM3ZJJpvlKZfYbEoN+wCm+nNzmYy4iSEjpqmXez
	 npUJaHtvnnX/hZLhZqT6v1DUW0nd9mzFnWe4KqaZRy06cnXTgoXBXpCJJZc4XsXJEudn3
	 CdJSoxr4lL/vAGEuJqQc55kB/BCkUWAeBTniDuNs1wqVwNbuFsVSmHmH8Q0yb8wg23/v2
	 nhAosWGp4ZYnR5mp0wlVtrGtmio4g1ssvURUs3gTsDkM1Czy3SD7kPTrNsC67nnF3iCBv
	 3vTWUsjwarvxXa90WoxnQBC/eYsz1IbVZep/1eGewlpa3cs9jKtFGao2J4IvoDHHBvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616046;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X1YrV3fobBcn13CCZj4BD7Ce+t5DrkqCyoyOUVdKvGE=;
	b=J3hjBEzu7rbeTvBHF8ST60y5L8JGDLt4TO+L5i2tI6GGhGgh5XULmipMDWKDBcgnn+zi
	 yW0vGuddrr+MtPjrQD+ZGD38UabME60XYZpWDv6HNBJMXhs4IwL/NC2jW//5LU5RJOukQ
	 8nW8v+BtkgE8VwMzjC7liTIgguZD9Gtdi+CknRayavJj315vyDKNjFboY40C/bczDI4EL
	 cyZwzNh/lOFPa8J3W37haDHbuJDvXDA3llgLZftN0ggCsHzrUrxiQ3PV7fPV/zjLZgKw1
	 9WGcYwja9TRPlY0kHGiQGMcP4s98ILrWygKyX3mPf2zzinKwBP9Ns4xrbVyamod1eQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="IaS/9PTf";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gQHFH7A5;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620B606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7620B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IaS/9PTf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gQHFH7A5
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FEEE14003D8
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 09:14:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 25 Nov 2026 09:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795616044;
	 x=1795702444; bh=X1YrV3fobBcn13CCZj4BD7Ce+t5DrkqCyoyOUVdKvGE=; b=
	IaS/9PTfrw5ap4HNzQasq1Kx4ptFoQS7iGRAw2B+SuKBqN/1sUgnsBnaYYlMH/iw
	sDh/qamkFLYmmy+URIPQRPXgZK44Zu3z6S9D+ylxSZcX+R+g0H+kkbMCddbCtVla
	EXq/OVUxt1J6M9havdHe1JeUttys0hajaS1p58J3WZIyOQfNTEDe+dvPiKaxZ0eS
	cdctZy/tTNVhI15197djdN26+m/c6/PQolorCz8nvwNTB5xFqnIlCQaDuG8L8ifH
	yK0peoF2edj7CXb14Um290mdBMm2gkibPa6bDRgCQe+y9lwpQSWHeO4nS8HuKF6w
	qQLzk8GTPO1RPumr7snxkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795616044; x=
	1795702444; bh=X1YrV3fobBcn13CCZj4BD7Ce+t5DrkqCyoyOUVdKvGE=; b=g
	QHFH7A5TbTE4xyT0r+MjKH4aCid1ydLx7kwbmL8wUzjxrklrovpJ8nGVxIMJ8sOj
	N0NYyYn++3bqawNdnaDrqI0nqZJZge7n2vkm1Kj8sqCo4sR46ZJzv/4CzTTVIvJl
	3OQAvNJpXEFDA4ytJQz0OCgzH9cmKzOI+V/5D6tkwAUtNcX+caggnkRJ3xUIpmeg
	AUrVizZI3iVnBxzd17P1kkh1FOI6grfoWVi3Q3kp9EvxT06rcvgoXKTTyIkibuce
	8Pl+WAGR0uoB6MeabNbrbNTiD1jkV8fwjyAC4aZyLCpx53OcnJCw4wV2cGuf6Zet
	Bm13eXlM3h0ffNmM3cgcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795616044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k65nUB7FVoKb4r9XGgCbytQhrApzBXjD+N8nfNfsdQSS0tL
	97OtURfokfX5T2E9CryW3TJwvpbCDpQ68czjlH3gqGhAHKOLDFPU3mXT/ZbEpJBG
	vFw4OPwhzJoioROiEUFmi0Ml30TF6Jn1HKQ15E1W4uHzmZkwEiQ3cSMrugBgfAXi
	10qUR3EN+WDldG8lQCMhTBGDB5uuw6uYuH+f2vtl0r0Kp2hNqRxlUHXXbSl5YfNI
	7eVKUE5S6ps5O4DNtzJRp8xDKo3ZcgdEoMTHENjL1NJUQjIfcS+jZkWuPvk2qS3g
	vk0uRW4avt3X1VFdf1lXoajy4tSI6NPnZBezBug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:kO2wW0H+nn22Xmuwj3xoA7pmpD4L6uKqgloVsbTnNzc=:jsAgBpd9tcc7Q7XbQmu5USm+Fj8yqtbTS56cc35MGjM=;
X-ME-Sender: <xms:LO0Ga954aX5tJDW8hjYxDCJXnxTgpTLq5ifgHUPGQkmxLDit2TYv7w>
    <xme:LO0Gax6rVumjBKckuEv94umbfRQODG-zr-BfMhTGjPPf4uoW2xmasCbfZQkWOHYUn
    GIWhwpQ5tYJPFcA7qYwde24rp-rNVPC_JmmUYTaLBJJy2_wzjn0Og>
X-ME-Received: <xmr:LO0Ga5fdNWlYF9oUe5NREBStr4-PrZ10dZPrU33k3j80VtwvdTbbnE_L-aV4Qd2F82k0GlmqF0_VWL9SL4LnqXxQdhJMJ_FASGpWxcQ>
X-ME-Proxy-Cause: dmFkZTE6Kt+g9xa0ym83ut+/FXOXzLSBX572VIN5yhH4+L9cNevFkquSGsZPABsctkCvkr
    YA/f5vAauUEgTMAfYW6AYDXv0hAU11IfCS4y5IZRrfMDEuxqAN8SXcwr6fxf7/AnQ130+o
    r4AhkgEVkONcZL1VJENWlG8ZkOPSY6wIU/ecyWHEQX/UMhafYS6wa6r/Mn5jlWk0qdzAFS
    1ePj7jDPzTZTKROJymPTy72ibhcPuuFUDXupw8sL0t5bWt8cWNgm2f8pp4j3ym0WZzdtTF
    151LIkzC9yE7yfO3qS0mXJ2kiczPsVJ6kpPZEFZ0Qtt1MF5RUeUaoGRLXDloF2r0UVb5Wy
    E2UWZV2tV7xqmtHzzWSzDxLTuX8iopYSeIft2SbZ1sKvxvguUnaF71ucVjUOD9jYZr2+j+
    z0yafZPP9ZFNhNJ2GX6DHe/XTayj/J1dMNMDtQHslF8g5Bro/D/9l2FayVa96ZlBJS5cxd
    CRxJUbsHNt/RtGLTkDFvPITmUx0EJ2c8/b2oGubx1eOStgUPYD9aQRfg4e5XqBDzt/8jaB
    JPF7XW4iZyIiVVf2yFyFqxy8ko3TjMNmssLx07RFFRvz2KDtpviXNf02bumVGLX24j2Lce
    zuCxLijnt83A8Jo6AmNeIQdtW+X+zvGHmDe46Tx14/XvoM94kOm8bvYLuZig
X-ME-Proxy: <xmx:LO0Ga1ARWUN5agTCE7kqFr2kBhXivbYonGxsOzHTnRjO-gPtfqS5KQ>
    <xmx:LO0Ga890e7XEDsB1fvGg94ZmaE8j8rtHXH-QeWHpQ9Fhd54XzNQlcA>
    <xmx:LO0GawIE7a-yZYGvtmW3-8ruAKpkzORDqnIFx3JWI32e_NHLfhFhnA>
    <xmx:LO0Ga1iUR8_qcrF7VIo63Fm-f_iLf1wXjOkj8WK4qk4dQptHlMSG8Q>
    <xmx:LO0Ga2eH3wKQNZIGq2B3JN1URpJoKWTUl5sKEdKVRG0Hd7D6pZLp1_RI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 09:14:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 2/4] doc: git-svn: add missing config options to the
 documentation
In-Reply-To: <b6063c41e563697340d000969f61ce23f962d73b.1795556940.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Tue,
 24 Nov 2026
	21:48:58 +0000")
References: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
	<b6063c41e563697340d000969f61ce23f962d73b.1795556940.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 06:14:03 -0800
Message-ID: <xmqqo6bdathw.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>
> The configuration options of git-svn are not treated like the other
> configuration options in the documentation. They are not listed in the
> config.adoc file and they are not documented in a dedicated file.

There is a slight discrepancy between the title (which talks about
adding ones that are not described) and the explanation (which talks
about moving option descriptions to config/svn.adoc).  I guess both "not
documented anywhere so add them" and "documented but not centrally, so
move them" are happening in the patch, in which case we want to say so
in the explanation?

> diff --git a/Documentation/config.adoc b/Documentation/config.adoc
> index aa6360e230..c853578cac 100644
> --- a/Documentation/config.adoc
> +++ b/Documentation/config.adoc
> @@ -610,6 +610,8 @@ include::config/status.adoc[]
>  
>  include::config/submodule.adoc[]
>  
> +include::config/svn.adoc[]
> +

Looking ahead, this is included in the git-svn manual page.  Is the
intention to have all the svn.* related configuration variables in the
svn.adoc file?

> +`svn.findcopiesharder`::
> +`svn.l`::
> +	Pass `--find-copies-harder` and `-l<num>` directly to
> +	linkgit:git-diff-tree[1].  Used with the `dcommit`, `set-tree` and
> +	`commit-diff` commands.

Grouping these two together leaves it unstated in git-config(1) that
svn.findcopiesharder is a boolean while svn.l takes an integer limit.

> +`svn.useSvmProps`::
> +`svn-remote.<name>.useSvmProps`::
> +	Re-map repository URLs and UUIDs from mirrors created using SVN::Mirror
> +	(or svk) for metadata.
> ++
> +If an SVN revision has a property, `svm:headrev`, it is likely
> +that the revision was created by SVN::Mirror (also used by SVK).
> +The property contains a repository UUID and a revision.  We want
> +to make it look like we are mirroring the original URL, so
> +introduce a helper function that returns the original identity
> +URL and UUID, and use it when generating metadata in commit
> +messages.

The final sentence ("so introduce a helper function...") was already in
git-svn.adoc, so it is not an issue you introduced, though exposing it
in git-config(1) is a good excuse to trim it if you reroll.

Looking at read_git_config() in git-svn.perl and perl/Git/SVN.pm, there
are still svn.* and svn-remote.<name>.* keys used in the code that are
absent from config/svn.adoc, such as

 - svn.username (already mentioned under --username in git-svn.adoc)
 - svn.repack
 - svn.repackflags
 - svn.nocheckout
 - svn.quiet
 - svn.logwindowsize
 - svn.localtime
 - svn.copysimilarity
 - svn.configdir
 - svn.noauthcache
 - svn-remote.<name>.url
 - svn-remote.<name>.fetch
 - svn-remote.<name>.branches
 - svn-remote.<name>.tags
 - svn-remote.<name>.preserve-empty-dirs
 - svn-remote.<name>.placeholder-filename
 - svn-remote.<name>.followparent

It may be worth stating in the commit message which scope of config keys
this file aims to cover.  Or are these not yet covered, with the
intention of covering all of them eventually?

> diff --git a/Documentation/git-svn.adoc b/Documentation/git-svn.adoc
> index 597697d42d..ff8a3c2d39 100644
> --- a/Documentation/git-svn.adoc
> +++ b/Documentation/git-svn.adoc
> @@ -756,92 +756,7 @@ config key: `svn.followparent`
>  CONFIG FILE-ONLY OPTIONS
>  ------------------------
>  
> -`svn.noMetadata`::
> ...
> -	option to be "true".
> +include::config/svn.adoc[]

The list of configuration variables is included under the heading
"CONFIG FILE-ONLY OPTIONS" here, but many of those svn.* variables like
svn.addAuthorFrom and svn.authorsfile do have command-line flags
documented earlier in the same manpage.

If config/svn.adoc is meant to serve as the full git-config(1) list
(similar to config/sendemail.adoc or config/fastimport.adoc), it would
fit much better under the CONFIGURATION section of git-svn.adoc, perhaps
with Documentation/includes/cmd-config-section-all.adoc, while keeping
the section header accurate.

Thanks.
