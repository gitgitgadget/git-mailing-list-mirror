Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644499;
	b=cTGwTY8NnCb9+D7cuP5C7GYRjYpBZbYTvYDBijxwFGaomlxHCncJp0vKUbqoXuy0U6Cs
	 bYdabKQHeLtT/Brb5WaSDpJIDh2X041Z9SieqwT+MGzMVaNGbTJM1j9Qj9E5CHPIFcBlN
	 2b7uqlIcgvcfPTLlXteuSVjGOmoc+fic07urzWYbOGC6t2+MW1wX5KM+jMDSlTBuaxCxl
	 AORpmNv6XT72GxTPzahkzDlx18QnB4KTBCaRLYutPXCCUZlwvSBbPo79b9LBySzM6J2uz
	 0gp3zE9rZj2zHMnhRT7xZEND9/AItuh0Hn2jPXEGdmm4xZqOaVnOLiTjQqjHn26w7qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644499;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=kr4oJ4VBVmcQpyYZLsu+zayhHv6a/UTrahM2ArbMkgQ=;
	b=WAEdh12u0Jtd7sY6JZM2/uUBPS1l23II3kqPGx+b4nN6Q0vee+PO2zhi7+OrFe/xEJJI
	 f3jWgNLjqQ/lgQOUUiRTrIAgVuzd88JTYk/UsVbsKsMQt+eFKkyFtuOwteIkS7D5ZvydV
	 vn72lLibBBVk56ceNJK8keFIgy65xIPG6WS/4O8NVok4LbdsfPVHN+ZzpKLKsz745+F/y
	 1PvnV2tpUZcsoU/KivQ7eZ3/0AVnTdmUrM1JYChxMe/i3KR0KVSo0VA4IcgONLzbnuqeD
	 1c71lN6kyCWhqPiMt+nlTcHdxO+iqY0XzxPkleZRQELc24baLfIB2sJfhh/J55ZsL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Wn2+QI8a;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rPGG4Fgx;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DC606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E57DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Wn2+QI8a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rPGG4Fgx
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E911AEC0B6E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:08:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 25 Nov 2026 17:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795644497; x=1795730897; bh=kr4oJ4VBVm
	cQpyYZLsu+zayhHv6a/UTrahM2ArbMkgQ=; b=Wn2+QI8aLib0nTV94ryzzfVF1X
	ZVtcNvHDlNBmr2RW3Nvg6uJ7WnZ0kYUAh8FKgszokWW7Em3fipNP+lAXNn2/aDyk
	knvV6Fq3jqx0x7EBwcMwxotfF1tFu3wHqTei0VzDmAS676rkNyLDK9rir7h0gskc
	K/oXbmZUQKYQ40HJ8HOmbYtDDToy4EklN8wjSI0bZhj8pk22O0K9LfFU8LmA5XRv
	KdeZXg+mO6KkwNOoPqN0J8qd35MzlfrE4dZbZa7LqbLHLMROOu/GEDiwzxQuC/mm
	eK4ltBwQEU45mRQ20KnTLZs+/sA87oDcROuqJ7f3cN4xUv6eWIuZmYf6pUgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795644497; x=1795730897; bh=kr4oJ4VBVmcQpyYZLsu+zayhHv6a/UTrahM
	2ArbMkgQ=; b=rPGG4FgxXM1vMRl9ZHXjhBfZ3Y/9VJPjsASw4QqoPi3TtIlwBJF
	9aRiiS9mnTnc1JG0IbUo4C9wmgWxt/QYNJIo6/A9plEoUASLA1Et2tXwpCa2ViZw
	ZntLTpU1+Y4pw65+VmDq4wsFheUzqGOy0rnWfzEZCcSoknodQiWh9a7730bZPbyi
	nTgcYDZvUldD5mnAfekn8jQORgr6idN0Q8oBLWjTR9e92AzntL4ugX41p2wjel/w
	jE9Ztlysis0Ez0rPV6YYGyYnILJmePEhlJbWEP7rvq9sc2pYJI/jy+5w18VdNDjy
	V6Y8oYTb/Z1hO3bEcKENkXOKRVJ3NdnZHew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795644497; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NQAUnOU49gqhhYdbLhDd+pPexoASdOC9nnklz3/RtofpjXX
	Y3BhbDa/xw4yn14z5r75zLDNneN2hLglZ3RvQeL1ixCeQq/cgSAxSUTTNeZwfQx+
	moGDBJMdmkS71YlISFvEoQpwZhdzB9QO1BKJRXTn8kAzU405U6X/0EDciAJ0TZ4B
	XJ3i6p1Qsi8/wuLxbMwDG5np5FN3rJFekT2BLtcGhM7itfgjCIEEFkMVzVqW4M/B
	94I4iURmLfifbIgqosXAQlEZPnlk3ty+3gQ2w92pJleC2xKgzQr1/9JzxATI46IQ
	b3l7olRQxF69+XtrsAW6ez+TF1lFmiG0MtipyMQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NJ6bSN4Zf3ppxdTyFgBYRDwI2faJAkxKuR2SM17rdYs=:KaXwI9Sh5zoA9LxjoCgs8mXQNLzqrD4OSeJohwx8y+8=;
X-ME-Sender: <xms:UVwHaxIA8h06uVTL2Bzr6PytHbUMSfX2VHIbbjxbarBR0Xe7Y-1hqw>
    <xme:UVwHa8MuG2cg55C2xDXX5oEU9tQARH7FqoiK63AGXJePtKuB8onk1kzWfw7KoB3mO
    R8Ni6pkhm4p3ECSVWB8MUFC3_SpOhTk8D0d5uPGQa3EuVnMiYaJiuE>
X-ME-Received: <xmr:UVwHa_7Y5ht8CIyJ0SLSt9P8NrWwz9ROMnrEmrMw-ZxIG8voW3KTu19sga7vXO8YJojOHpGJZ41ve2dFD5GAUw2v2MitahpCnX4UYt4>
X-ME-Proxy-Cause: dmFkZTEZQGAZw18FM+TJSDgc0y6Exsa52VTk3uzixm9o/Rm5zohDjZGiU/Y2lWc9saMXd4
    tCyrEhserFaP6u9ubHMgQF2UPPFjbE/ceR9Ma70yRpthKtu65CAGUbo1Ao1SqkBExfUu8V
    /b7sDAl44ZjNSD13me+vs9Jj84cuEF22zlJtpogXtuoAk/5MfiLLxvN998SHSyS9jm3yyz
    6BxPOCi+NNImmOJi5l9jVTtxLredzwlujBeT79GH3/u/T44rHLzh5pfmkBdnPpodk3wYGf
    XGO749BvEu3u/Hl75qC59wPb7ecbpg9yyrlatu3z8rkp1QqRjkoeCGXedHhMlib59yQVcc
    o8y6foJkdxkFeMdc0fuA4ILubDQCfPNIz477+oMfDV4h0IDG6zoLb8/jzvOymjJ7Ogd0Kb
    qOF3QiqwFyze3RcKP9Kneo75eTtQYRLvT+Q45Q374QYq0ue9Q3vVmkt3IKkDP8AuYKttub
    BsFNvcr81HNkZM4+mIs4p39v/kD2YwkZxbzDsn1SyNWnqHYIOLh0APGSz8OkXzri0rf4by
    V3G8whbUGS5h5h/6I77b6Ec+mtH957HwIr6Ho5OeCKIemw9PTShGLJqY+1bXyjaEOf1cYo
    7OBniYCht97qFXHNEan8boTmtl53BBTef7yDbIH5Qd1TbWAh+x76Zttc2OCQ
X-ME-Proxy: <xmx:UVwHa-61TwsLCu1v0tMMS73C2fzbs3r17xX4MWkwJ-2egIaRFiVxKQ>
    <xmx:UVwHa9HYCrIjBhNduMHsK5ryUKIcuUpMlVqpi7gHWK2z1rdI_r_Fig>
    <xmx:UVwHa-UUzozvhcIh8K4YiasEt94s1K7TzUc8IAc7VdOlpcnnPub9hg>
    <xmx:UVwHaxX0Y3ar0W-1sZ2Zt2eZan0rB1Ldt9e9Uii9iDe3q1dFhTCsMQ>
    <xmx:UVwHa2czXvEBp7b0fDACScKcIJFx6lSxFcHD3cUhD6shXavkv6P3ixzg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 17:08:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Harald Nordgren <haraldnordgren@gmail.com>,
  Simon Richter <Simon.Richter@hogyros.de>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 5/5] date: avoid overflow in approxidate
 relative-time multiplication
In-Reply-To: <23ec6cf8f08ec63efe7b868d78745940e8475ed6.1795640149.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 25 Nov 2026
	20:55:49 +0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
	<23ec6cf8f08ec63efe7b868d78745940e8475ed6.1795640149.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 14:08:15 -0800
Message-ID: <xmqqpkvsy374.fsf@gitster.g>
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

> diff --git a/date.c b/date.c
> index c50f45d310..3cbfe20b37 100644
> --- a/date.c
> +++ b/date.c
> @@ -1307,7 +1307,14 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>  	while (tl->type) {
>  		size_t len = strlen(tl->type);
>  		if (match_string(date, tl->type) >= len-1) {
> -			update_tm(tm, now, tl->length * *num);
> +			uintmax_t length = tl->length, num_t = *num, seconds;
> +
> +			if (unsigned_mult_overflows(length, num_t))
> +				return NULL;
> +			seconds = length * num_t;
> +			if (date_overflows(seconds))
> +				return NULL;
> +			update_tm(tm, now, (time_t)seconds);
>  			*num = 0;
>  			*touched = 1;
>  			return end;

This looks pedanticly paranoid ;-)

Doesn't a similar issue exist, however, immediately after this tl->type
loop, where we handle weekday names?

	for (i = 0; i < 7; i++) {
		int match = match_string(date, weekday_names[i]);
		if (match >= 3) {
			int diff, n = *num -1;
			*num = 0;

			diff = tm->tm_wday - i;
			if (diff <= 0)
				n++;
			diff += 7*n;

			update_tm(tm, now, diff * 24 * 60 * 60);
			*touched = 1;
			return end;
		}
	}

Like "40000 Mondays" gives *num == 40000, diff becomes 280000,
multiplied by 86000 would exceed 24 billion, overflowing 32-bit signed
int.  I guess you can use the same uintmax_t overflow check used in the
previous block?

Thanks.
