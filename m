Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343205;
	b=wwwXirphma5HoX/YzSMtB5sXRDuXhSdCABcu7N+rEfiAk7zM57ZBXzEdkxYqo43HjurQ
	 LA/5QJ9AX5yhcK8wXJBr2dfdUURpLRRWgGCkaxH+lsbS/u1csHZWuVa23uIpUkAbYDuJQ
	 +tAsmJVmKBDZ2B91bmwiWAPmQFnCL5PAzg4ILQqO6Bd8j7t48FGdJaOgChWUqOzj6Z4E/
	 Wp9Z4sIRO33BNskKrFI83MplCQSqg0Uym5kKo/vUbZhz9ea3j8JrBEFwppdYvY8nMzfbW
	 I/n16Rf3wglJxlwmtMy23lzkH8acFzr78IwT5Cs5PE/p5jZUQjwN54U1gpmYM1wRa3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343205;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+yawOZ8iST6xV8N5RcktPVBWPnhrltOPZ/Rlg1ugMGg=;
	b=IP25PTjPHHOQ11fzg8OXjSbjQJM3SMUbOpsBJqPd+0tKQsX6aZ+KqZAO8Hgm9lDlBpwq
	 2rjx0up4JncPMGIecLcaMFaQ46X9vGC3iiCyIZ+3yt0FpCnOJOqFj8Q8ZJd7Jn9Xzo5/j
	 vZXIRJNUDpqnWfwumEprjbw/ipxU0VP2PE0R1s56H1qPNFwQPVoSEijqifPQ4h664L/x2
	 Pyzxtmomp3/BYJ4rlVhHu8E2Q0ISDE1a0YDaSAhQx6cAvnvbF51iAE++Kn1t8yGODdx8E
	 5Km9a7jShf09AJNQiixSpmQVsfeiouLnRytZqWVyUhO9leKhUpPwBCuUwE+F+NKD5lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="a/DE0Pp+";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5WFQPvc0;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D6606A333
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E77D6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=a/DE0Pp+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5WFQPvc0
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 426607A0231
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:40:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 15:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794343203; x=1794429603; bh=+yawOZ8iST
	6xV8N5RcktPVBWPnhrltOPZ/Rlg1ugMGg=; b=a/DE0Pp+zSdA057NsaBpj0Hl3M
	EKNJtc40B5izg1MhV5gsVNcrlS+664OZPpNQ+73156nek8c5wu6n0VoUPvgXRGcP
	nCljgtL36a797bj0KRhxfAYWqSRgZuyfIpR4X9Gbwv9G7YxPTpf4cuMt8/zoBgMu
	tS8Hk6gKlDdrz7S0EdiEBMmBvTvHjR72vymAuVlYyJdiVXd+TFYOFqGoMoGsE35K
	O2NSolSrQlVBBJg9gU98JZuY+YDOnKxiNdRufYXvxaxdsWWUn4QPXSB+vcnejUZ7
	zYxX4Yd8HzFb2+hatvMYN+rM+VM7S25ZU/2+pP7dQuxRVRM2FImGGheqa0BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794343203; x=1794429603; bh=+yawOZ8iST6xV8N5RcktPVBWPnhrltOPZ/R
	lg1ugMGg=; b=5WFQPvc0WInoEBI1N7RnbpJLAVRpsi8wJJVWh3Kxw3eT1K1C0Xe
	B2X74zFWY2SM0K3O2w1IFjdl0k86CHx/pEhsZxEcqLvPKxKOKLAp57VroeZeChlf
	CDtFrpF8eR8OCG0rdkGP9CXQ9WSuQ4NvacSjfOfxN4yGduyBFGIJi78Oah5ByUHE
	s6jTCF7qRoLKlHHjFRE7csK+vrtdQlMfbCDW9Wam/AoEy32AUAYBylSbPCzuX0Iu
	40RSXjr+u1H1fNe1gtVOIMxGNe3D0Mh2b6KN32FC/KLlxtV9W/clsmMkXSX8YUrl
	b1CToCNvWDvwXXDeSLWjJo56j12Zt31z6ew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794343203; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZgDwHjBeL7S27+ZNs4lZbWxT70ruZ4O7qTyX1l2WzETtrhy
	rmZ/GUeFfgQW3OLwOkjxWySy+M4VOfUruiLYTwh5plrzhDT2ZFt64htgK907Md+I
	X0bkAsJOMTZGwjwcOq+y0Ypd9l3iGbbJS2if75Ue6q64ZNhAtzM+6TIC2x5v12jm
	EBAsG2bJ+/QnnL6VrcflexWcrAYwMpFotJTbR5NhbYXCvxRKQpJoFHxY4ZK+OUOL
	y1S8evJhqKaxHw7NldDQnrOMhFexy26c9oOOX9n//GSXLcnQLLKVmQpk39124PDC
	JL5saZaVkD8YIT4ZgckTLyqj654FRKWXfkJWp3A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sViax8FcbVRnF0l+8a8anpSxy+OuGwZIU64WYmjzQfc=:lTni+IdgmH2DhYr84tTgw2TMvDkdy1joFezFyXHaBDU=;
X-ME-Sender: <xms:I4HzanTCBgBfkpaCsnv9mSuGTcHitg5XsVHUt-fyArd4R8tZBF110g>
    <xme:I4HzavzDs1NBQi6H_wzhiOF4y2hwGB6l_EqA_I2QsPXawh5Zul2Utxy9gckuQK4yQ
    _Ug60mRgY_vTZYIub5cs3hOq9n2x1ihp4r6uRWoH9YIWYr3Q8eH6A>
X-ME-Received: <xmr:I4Hzah3o2McMI-mbAjPIst3gfZZvke-WvXNxbFHzfitXwY4-MSZe58wtMNZFwQRvQZ2PptKaJZXxA5QTsu0fkI3rj_huBdJNJfIm>
X-ME-Proxy-Cause: dmFkZTEwEu3+PhAsmz2UXbBNibCMFAiO8VhmgPe6r77fMf2TTr/RCznfoyfwoyG3ZczHLB
    di5vBDFX/3g92izcm1W8ZiQvBu6McMyjQb6Zyp3temQSpqseR91/M4nkTHR9T1EKVXs6ev
    fkFdb6aSM1AI6K6qCgHCWmZdvw7lePmGiR2z8J4yJo8qXYQGwCyStRFoJ+gSEENvXmx3to
    SkzTpj3ir1xfnLpLp556xy87baIOaGUwPRyV0Q5XlrRsHO/FXMu64l4y/2tW9uVYuoCKhC
    KQzDwPWIIKl6p7HdOeCJJgqFUnsT5FYKgC8qNQzh2kRkBSQSQL4B4qXjDnYXxdh85Yd4n1
    HMKw+y49SaNQV4R0JcEHSa9v1dVjx7HwxOThzEX0eCvfAxtteHykN1SbSwxk/W2D/tdaxx
    XvgkaaCqZJKfZQvRJ05ZOrbwFFrvihRPwS+f6E9bHy7w9Dz334oKYjMlXezFwZYIgztmeA
    /NoRqnemQyVIhbzQq4vzRgYABJyGOqxbKjzg9MIPdESpgSulr3BfrGfFD/22HAkuqMULSq
    o/6UT8UV2351OTU/CarXH2CB2yAO99kNukdGLESet/+FQEgXIYWRx5UJOoIXLU7QNspCTS
    IM8hgEHf+vc5JmJrhBWeM7P4kSbqymdomCL0h5wDUGv4+60dVSHz7y2rZAqw
X-ME-Proxy: <xmx:I4Hzal7wwPE1LsTr7EGuUrdFjFkFfVLHOdwQ_QUTAKIub6g3fJ_iSg>
    <xmx:I4HzasUBBA8jGQBNaNVq0oYbBUgcfs8JoZfutY_C-wmER4lEzC9qtw>
    <xmx:I4HzasAMfsSprSEEGvz43_z46rG-qx5ePC_W6DFxbbcJ1A3TdNZloQ>
    <xmx:I4Hzaj4BC7Jj-gC8fqYkKYLyLwBaUF1aGyYv7YT7-TJnGI1AGfTQ8g>
    <xmx:I4HzapV0Z__ICR49fRcwmVLbKUDjtB5WWfW-vhl5oI_0--7iYhDOHffm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 15:40:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v3 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
In-Reply-To: <398b54f00a1278f22fef456384c6c4ebd1a1f576.1794335969.git.gitgitgadget@gmail.com>
	(Srujith A. Poojary via GitGitGadget's message of "Tue, 10 Nov 2026
	18:39:29 +0000")
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<pull.2305.v3.git.1794335969.gitgitgadget@gmail.com>
	<398b54f00a1278f22fef456384c6c4ebd1a1f576.1794335969.git.gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 12:40:00 -0800
Message-ID: <xmqqse18pgin.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> Refactor archive-tar.c, archive-zip.c, archive.c, and supporting files
> to clean up archiver initialization functions and header dependencies.
>
> Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> ---
>  archive-tar.c     | 5 ++---
>  builtin/archive.c | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)

Where is the change to archive-zip.c the proposed log message
advertises?

The proposed log message claims that it refactors and cleans up, but
the patch looks like a totally incoherent and unexplained mess.  All
the places I note "What is this change about?" are unexplained
changes whose value is dubious.

> diff --git a/archive-tar.c b/archive-tar.c
> index a1c66024d4..642a3ddfc3 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -3,7 +3,6 @@
>   */
>  
>  #define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "config.h"
>  #include "gettext.h"

What is this change about?

> @@ -337,7 +336,7 @@ static void write_global_extended_header(struct archiver_args *args)
>  	if (oid)
>  		strbuf_append_ext_header(&ext_header, "comment",
>  					 oid_to_hex(oid),
> -					 the_hash_algo->hexsz);
> +					 args->repo->hash_algo->hexsz);
>  	if (args->time > USTAR_MAX_MTIME) {
>  		strbuf_append_ext_header_uint(&ext_header, "mtime",
>  					      args->time);

Here, the args->repo which was relayed by archive.c:write_archive()
is used.  This function, when called by builtin/archive.c, passes
the repo it obtained from git.c's dispatcher; when it is called by
builtin/upload-archive.c, it uses the_repository (which is fine).

This hunk looks like a good change.

> @@ -529,13 +528,13 @@ static struct archiver tar_archiver = {
>  void init_tar_archiver(void)
>  {
>  	int i;
> +	repo_config(the_repository, git_tar_config, NULL);
>  	register_archiver(&tar_archiver);
>  
>  	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
>  	tar_filter_config("tar.tgz.remote", "true", NULL);
>  	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
>  	tar_filter_config("tar.tar.gz.remote", "true", NULL);
> -	repo_config(the_repository, git_tar_config, NULL);
>  	for (i = 0; i < nr_tar_filters; i++) {
>  		/* omit any filters that never had a command configured */
>  		if (tar_filters[i]->filter_command)

What is this change about?  Earlier, we first declared the built-in
default configurations and then read from the configuration files.
Now you read the configuration files, and then overwrite the values
the configuration files specified with our built-in default?

> diff --git a/builtin/archive.c b/builtin/archive.c
> index 3c1288a123..8b7d56f8cb 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -2,6 +2,7 @@
>   * Copyright (c) 2006 Franck Bui-Huu
>   * Copyright (c) 2006 Rene Scharfe
>   */
> +#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "archive.h"
>  #include "gettext.h"

What is this change about?
