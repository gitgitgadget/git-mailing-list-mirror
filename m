Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650462;
	b=mSSZAoXkHglQ3hr32MRpwHzI+yT8uPUr+ubXX93oYoYDkOrnl9GNrXzbTzr18iYGSbxA
	 8qeg/nSj1xAbNNCFv7PKo03uuoTuYR3VW2GNKF4acodRu4SucWSj/jj7UK34WKvDGiEX1
	 Hhw7imh1ghPnYdaSqeShxJsO78fvy4XMmtp6EU2d1yySED0/I0IgxOfDuyfO8CpDWrI07
	 3eqENUMn3iLxxAMS+Ek/U0So+UpZlhgp2u/3QtQMwF2nEPtwZLhcEv6xoXMoMOEG0DIZ1
	 VIbunkgat7muQ6jvo5QGh0NXegxEI/jufOjvn/dK4DtsLcbd03xkX0y6bX1ZktI7z3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650462;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=128MaErZ0i5UozUCv5XzaUjtUtWu7v86gaZVcs6Wq5E=;
	b=knmSEyNgFjVXzKy94xYUHzbqU38UCXEw0cx7ux53bRNfkmwjvGxOj78XhqaN+uMNgcPu
	 RA1tsztULM+Ek8eHLtEh4Jr6HM1cAeZEqsH/vRBRO6fn/Sbu2sz4gnfcOEQKvu2EcwZAx
	 DYMTLs8rN6Dm4PXNmES/awMrZfu6b9w/fZBzbNTiFPw0X3kX3tJScnHm0PPeeI4fJO17+
	 fOeByNaFHA8gd2mizhFdI8QDdk/2+T77ps2u4hWfjq8szmgGcRyql8jRy1cx+ZRbeyFQj
	 bLEYlfqBeHI2pW5xkFylbJWs5e9Crsq14Eh57uzrkLWg3sbYii+ruWP3uFeuWmCMOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="c/XWf1MT";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=42InDH7g;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5CC606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 23:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D5CC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=c/XWf1MT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=42InDH7g
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52D2F140036D
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:47:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 25 Nov 2026 18:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795650460; x=1795736860; bh=128MaErZ0i
	5UozUCv5XzaUjtUtWu7v86gaZVcs6Wq5E=; b=c/XWf1MTYoVQH3dySFwvKBknv7
	BD8lbzo5/Vcvusul3N5eXa4Y52JYC2iFzgDCZuimZ43GqGshI5VMQuuOE1voo39x
	rBxKfwRXd1bxvlUbiPZ5/1qojXopXBgIRlFIY0C91Bgmlp6WecIs1wDr0Mx///Yw
	rB0iyBCISOYxXsu92mHbbX11kGT1ujacRbffos0E/wl+hYc58e0EwhNWL/ry78wd
	RWaTP71SHujqF8THIchrDBVQ6j7PDV4fTFz/u2XSnwjWH4mXCSeJxS087YwOnhbX
	PfFzZMA36fuo7mT6AVat0oSyoZbP1SjLQ1uP9tb5TMGIdeEaRVCXsndfgmmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795650460; x=1795736860; bh=128MaErZ0i5UozUCv5XzaUjtUtWu7v86gaZ
	Vcs6Wq5E=; b=42InDH7g6IRKseh2zMZ9uxCD4Is76gAF3WU8Ohu2jD1a7acvGum
	VmxBLhN09elacsZyxABqWNPU5L12pfzGK0OGglckoKSG0Z3pq0Dovjplbl+Qf4Ge
	kgM90OYHP727qcTUTi35COCHqPc6VqQXyNbk5G5xIJ0WkUy0T0PtscFJMJDJ0PxT
	Ty+jnwBeOuTXSS0Ga8serlVREnwhBdxnjl9saVSMSq7zcf8e9Y+7qiu+D1j2eMG/
	/ujO7LJ3/PExMlkxCTq+353VTzA+1nfcypN8BGKgE3LSgrToTWo5sy55w0AlVIQs
	W+EMvGeLr88aE/qAYgvvK/fwLPSvoQikmNw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795650460; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X3X/8s8fAJCs489QAOFzSxXOL5zDbJPhW8vOmUeCsQCptb0
	T2VnHNs6Pvy+/NlOicgNv0s+KvHkLD+aQCeS/36KKid8E/V3z2RW55+1OkDdooYt
	ZNkh13FCq6MmcKgM1QblsjSiSxOtnscmAhmg7a3sVZM9NIieG55olw8WYmR2NL88
	Iu1gctY1okI8buBpC0LZjc704ALGg8Q9ADMqMZb5LVINwU5JNwrOoRbvsTsQUJ9P
	jcZNNxha3uIUL6UKf7COBJ2fbB2QPgo2iAjtKj6t0lI3yRZKHNmvxObzM4GeR/mI
	8u/EAB9L9kGluIWeELOf7iIZZ8RrsTMlwPx7JSQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CzUDy+rTxi0qCYFAv59i3L1iFWO52sf/3l6tHqnwubA=:AfOkSIaFZCQw/92EotCcraj5zaBGRWjF8LQZWp3Pg6o=;
X-ME-Sender: <xms:m3MHa1kLOb88JbIQ0HQ8UwGLGE7MU7lhUjzeXTZJuyaKltId9FoXLw>
    <xme:m3MHa_7F8N0FENC8MmeY8PkoMX2fHxwVViehe4mS2jDOQ29A0_s64WVurt2UTqxCL
    DlLDPVKpGSlSgvjnxL6KaZ1qzxU90TIFbPFyTNIHkrTPb0IXWV6nMU>
X-ME-Received: <xmr:m3MHax0_Gy9DL8B9uKDtM73sXdIoRsPwdWYGe0Yfy7mW8f3LQtAG0Y84hRMxj5yP4H-_tMKJfJq7igxt4cfKDYFvJD0_C20NIxmUB4o>
X-ME-Proxy-Cause: dmFkZTGbnCk0gMwibSPLcYrvDoZVqRKAs41RD+YY5RZaaQkk/JTnbS4RU9K2rpOn4LuUOX
    T9olROqZTH8BLAb4Nlo/67qoKAXqt0udSIzyh76BIpAiLEhvxsyZSf71tR6UbtSs1A6Vpq
    MVorYXW4yxgdOBJJUlN+uCpyNjY4/UrxYoOryNZ5tK0tHMwArLnmH97ua92rdOPkaOLZgG
    dV1HghZHtzRKtxS/Dk13J5BbrZbnWNUp7QMdMOHONKhH++WuQxEGyfPVcHmQqhCYN6dKuC
    wBzuiyZDaRI38UZ9w8Ets3pBp5m9vYld+dgKN3uVMTKO0Qp+y+JFFr5cgS0zY2k+e5dYGd
    27hZSIJ8wmrbHl2CX5E7axFvPZsnHMRSkBXdbDnha7ElZ3+Q46l24D1i4RNoHiJ6ECuSQO
    3ZOVqeSTaLN9iRGSXhcb/guYYduahYhkqzlkBwOt1KevgiV/ktYo0b9K4PAG2QqN65nPRm
    Mf9xMHbsTBL+JEZ1quJ9P8fJzS/DbjuETV0q2AhIsBQDE3I9HFC1FTLh1Xch8UDGEaptgf
    1TowuCvx3z4AEplicKzVpoxOUAGoCbWNRPQxKqvidAJ4GFTmPtOAR91QpGN9hrRofvYC0q
    YlrqJDYdJy5TOg8Oao2+e3WUueIHamkCwrXNXXKhGsYjdMpx264lUYPZ+ajw
X-ME-Proxy: <xmx:m3MHayEL81IXyzNCOwGOgDum9G7arDpjo11S4oS17yA27KFXN8TW8w>
    <xmx:m3MHa4jxJbboFkLr4Iv9AdKQTWqRBVI32y8oGLtT21HEZqjMuBW8Zg>
    <xmx:m3MHa9AEQB8FXkphWKBCNWgZiSWO-xw0EtCozN1-_sAVjozfOu1DaA>
    <xmx:m3MHayQ9GCXYcNn2s_Y5ReukoXGUQY8aGL0cqh5NRjhaTuMjuwb4eg>
    <xmx:nHMHa36Sl4cDFggbr7I9YtK9apkxkf6I4_6NxinT7MK3vRI0SnzYp3OP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 18:47:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Harald Nordgren <haraldnordgren@gmail.com>,
  Simon Richter <Simon.Richter@hogyros.de>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/5] wrapper: avoid byte-count overflow in
 write_in_full()
In-Reply-To: <f38c7e71337632f2e86ef5716e90c776c491b762.1795640149.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 25 Nov 2026
	20:55:47 +0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
	<f38c7e71337632f2e86ef5716e90c776c491b762.1795640149.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 15:47:38 -0800
Message-ID: <xmqq33sowk11.fsf@gitster.g>
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

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Accumulating the output count in `write_in_full()` can overflow because
> it counts via a `ssize_t` variable which can overflow for valid `size_t`
> sizes passed as input.
>
> Since this function either completes the requested count or fails,
> callers already know how many bytes were written on success. Let's just
> return status instead, so the total transfer size need not fit in
> `ssize_t`.

This is a great simplification.

"git grep write_in_full(" shows quite a lot of hits.

 - Surprising number of them are totally unchecked, calledin the void
   context.

 - Many are in the form:

	if (write_in_full(...) < 0)

   and presumably this update to return -1 on error should be safe on them.

And the rest would need to be audited and updated, like this one:

> diff --git a/imap-send.c b/imap-send.c
> index bf1d2cf74d..dccc2264de 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -392,7 +392,7 @@ static int socket_write(struct imap_socket *sock, const char *buf, int len)
>  		n = SSL_write(sock->ssl, buf, len);
>  	else
>  #endif
> -		n = write_in_full(sock->fd[1], buf, len);
> +		n = write_in_full(sock->fd[1], buf, len) < 0 ? -1 : len;
>  	if (n != len) {

which looks correct.

> diff --git a/notes-merge.c b/notes-merge.c
> index d361e70a48..991490a187 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -319,17 +319,8 @@ static void write_buf_to_worktree(const struct object_id *obj,
>  
>  	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
>  
> -	while (size > 0) {
> -		ssize_t ret = write_in_full(fd, buf, size);
> -		if (ret < 0) {
> -			/* Ignore epipe */
> -			if (errno == EPIPE)
> -				break;
> -			die_errno("notes-merge");
> -		}
> -		size -= ret;
> -		buf += ret;
> -	}
> +	if (write_in_full(fd, buf, size) < 0 && errno != EPIPE)
> +		die_errno("notes-merge");

Hmph, what is going on here.  Did the original not know write_in_full()
would not return until it fails or writes everything?  It comes from
809f38c8ab (git notes merge: Manual conflict resolution, part 1/2,
2010-11-09) that is ancient, and was touched by Peff in 634eb82b1a
(notes-merge: use ssize_t for write_in_full() return value, 2017-09-13)
to correct the type from "long ret" to "ssize_t ret".  I guess nobody
noticed when these two patches was reviewed.

I didn't check what is *not* touched by the patch, trusting your LLM did
the heavylifting for you ;-).

Thanks.
