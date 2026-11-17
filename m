Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878496;
	b=Z0/8L3ey20yWwQQSZrs0CVhOyQOensvARCBPihQQpYU8U2TfmKKd03gHYrmvArOLSp6r
	 rN00sqvnZMcY8MtBj+CABAGtZCxtUV2qKZooRHvtohP6DjeN9hrr6Pne6OD8tSNctWoLK
	 ylOAK2o9wT4grXlzdQ9SWi2Vj+QPFiUby6BiuV8JGvzb9FiaNJYBboOXllJhvL4Wjuvyp
	 eyFsBR9eq+J9Zsy2rB6TRcyjXxAefJekwMmlTw3frfDVQf5Vxlr1jPVQLdjt3JReUUVFL
	 ZKvNm0jGgw2xuaN546RZmoOFkQto1WmygwDpr6LeFvSepxkPvQyD0i5CmCi5d/RrnqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878496;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=QTvExuAYO4J2B3MlNp+aEUnZiwCSEMHUBY4+D3CI5Yw=;
	b=qnT8E6Vm6WvSZuJO10rAip7oYET8T6dqG0bI5XoVdRb8ayJz51v7jDBvMzdQAtvyNd60
	 jKlV+m+MGTNgXrxlZ5zfTkGkwkzW2HiwkFfwre5rgGRvLc4uw4WCcGEAqhqZO/d0+ZCv0
	 ndl5Mt9Zw836dLC5BE1SyqSMFumOXvh2bT5s9Jhp+BvLlHh10t/eTSVKnceCucoFKB8hn
	 CtQ49I2yeXF+dsl5RJ+OMyyCT7U/iP7XDslSr7pbX9oGvaCRRyTqFi8+rDaEgG0HTf1kc
	 1DZRn6yK86f0ycj2+F/7htPTqprpFcsRJYYJZc5ZZv0Mlx79xd6HxwFMAzI87SDffYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fU961GZL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xIw5yZE1;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFC606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 01:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FDFC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fU961GZL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xIw5yZE1
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AE7DE1D0018F
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 20:21:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 20:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794878494; x=1794964894; bh=QTvExuAYO4
	J2B3MlNp+aEUnZiwCSEMHUBY4+D3CI5Yw=; b=fU961GZLhwYelsLhWO2UiCS/i3
	k1kBJZhnapE7SUb1d/aNViYdt6L1F4qPm7Tc8L8aFmYRvd7ah+3fI2Wsws8tAHim
	oS5nb1z1xDMhKswPSwubp6p844jkvSBxs8w+z/V4p+Fecm8rnF0E4ijkcX6CkE3b
	OHumZ8b782yCLlCetD6nXf8Jajitf4CagURaj6Flm1l439+NCKq+QDtBh3JA4bss
	/CQKMoEmdYFpd+FZx4HiSLq4k5K1aSnV1ymSDmyDE+oVqPYa1HXfEj1MiZM/idZe
	lX7kWBk1ejxcnDPqoYUxVRGwDUIaBnbxRhe93HsGTkBz1Cy9sjqRMzZdhxrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794878494; x=1794964894; bh=QTvExuAYO4J2B3MlNp+aEUnZiwCSEMHUBY4
	+D3CI5Yw=; b=xIw5yZE1Wb71gFOeIkEN5rUznSUqXRGx2Ln9TEAZVMVPzfIApug
	NzA+wGHTYYzLEBXQc4joC6Em9a1D+zRAeBnZEeAbBO9ZXr3jJur1nEF4tAiPoIw9
	O6QQRdSNScjXJavzk+f4TH5NloR4J6sXoLfqg7ecm71UQG4J6Fi5QaQcrXEGf2es
	QL8+w7OIycG7gC3ugfSQe6L2LQuuFB3Bu1x+O9Xbv9YSH8GvG01jJ178vy+PpJnE
	setQ3UmZ3pd/fv91rzxEQms5nS/RL18jqXXluJ9cIrmvyy2w5RS7O4zfHKn+cLNj
	/pwJan40ZrG5ALZyLOwl6CWKYiydVZK4Dog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794878494; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dCz3a9Tjif13YXcYf5+dRPOUQB3IJdYX25Rj8Kb3I2ui+/Q
	SNvl/aXRGT1cRWuLN8n2hXoNx8vjgv8pM30qdQAM+5UgAIce7+Js+LrlDXwISWrO
	Y4a3hfT4iUd1mXzCbrMn1Ka0XfsBHi0uF0KQ5SYS5MyypNd/iBx+UzMKVsLmZ+td
	W+K+JSeAyEDExnRjIomjUTaGfxUmniCiA26NUq8Tja50k3Aj9Les5eBA5G2BezM9
	l19Vc8ULQksKrkkdLByScvAU0YsD/s6pLNfVmIWG9wazePUMzSHEAC4zcZr/tJRA
	/XOlLRaMPFEILSeH9ZY2zZjvVoA3bN/9AWPRlEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lpT2Hz4AeEUAkgo+rfzhfSH5JSi5k6fkYfCEXCEE5pA=:DS0Jlb8je37+1HBjDoTcPCKZIKCNh+GmQZAqIvqzzsk=;
X-ME-Sender: <xms:Hqz7aiKzJB4SdZ7BgM0HCXuC-RXVk_ZDGJpoqcRLw0rVgcpfwdhMfA>
    <xme:Hqz7ahC4FYkpfOWjgA1z2lTC7bnZB3yEH21aBQvWkk9hIWnx3HU6w5jUKPOM3HuwA
    Qto1xPSgkz5B2nDjGsYnB-Ma1z7akEBmHc8l4A2UklStQaYMLHavw>
X-ME-Received: <xmr:Hqz7arBRcBNGFfbTplctMPhQc1pTfScP4btGuw7yb9bAy8RaMviFX6qdZu75Xir3P99ZC5uXNJHRw1fPDKIqf7LdRE4avG826SDL>
X-ME-Proxy-Cause: dmFkZTFR009RvcCY2WjSaoNmQyUfYck2vgOJpnjAWM6mfTY7RxA2ROBBggP3/SBa0cuEFB
    amGKw8sbrgTREOwAiv9JzBEMhIKC2blX8GNfhG1IZRwZtiejObuTU++y/JZjH+KiVcsZ3j
    HRl7nMPsj4vdQZRODsLbIPBEYGyI6xtP+TGZOXIa5i6iXA6GI126zzUBJ8RMX5j6KjUhjI
    tR1IS1jyLGGgFmkHpcFV6yhRGGwTXcEWG2YuQSesMDumiKO5ty6yUTIjLgX1AXYpYFe/yR
    dbMGMoLtF8UqCFMpHVYC9BCf9J+48RxNL6SWkdjHtUSgyC8gi0pd5naq87MX8mdvK2cGC2
    5Qw6fPK46nShdwnQdSxbf4oMvSvwnX6GNQzaKCDv623rqjeiRPVgHJOKOTYf9eguLvP5nw
    D5IUKxYBNZrwYXST5gZ2+wij4Dvd9jEl46Sfv50xHsNyRCvChgbQ2vkLsnsx58duLzaIiO
    PgeZSbvyP7ljao9y/+7tu0fQgxISNQ2mzV6I376FVQyC+E3iQX+hZFTziYhTR3Idohd7vn
    qupnqOrKHXmv5Ez2UN986AX35O+N2bzkkQv23TY+qXwYF6DIasen8iS/6e5PEelAHfOBZw
    BMvyH7H4V7selrAwIFYeXyiOZXG1Vns98vl9KAY8axcxT7JRAwUzVcfJW2EA
X-ME-Proxy: <xmx:Hqz7ajASGKQFnhH4Y07LgGgDhUn0yZ6tL7XKN8XvlSO36Lo_B7LVYg>
    <xmx:Hqz7amqb7BfPvy4_ofVaPJpXq4bdA5YkHWlqjMTD37HhV7DnpqCpxg>
    <xmx:Hqz7atnBE_mzMfe-nYugzI5R8suVHJKzbtLJVJ-vEsxg4W8X_hE6gg>
    <xmx:Hqz7amzH1wVtIFSzy-QUd8kAPZVE7aCk0zoGVEWr5UXGCe8sf3L3Iw>
    <xmx:Hqz7amQQAZe1vxG6Nuqlm7iDSeRPu4VPJEcBqtnca5dPXRfqGNPqB-ej>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 20:21:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 10/12] builtin/rerere: turn "gc" into a proper
 subcommand
In-Reply-To: <20261111-pks-rerere-subcommands-v4-10-df0c8bf79e16@pks.im>
	(Patrick Steinhardt's message of "Wed, 11 Nov 2026 13:18:46 +0100")
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<20261111-pks-rerere-subcommands-v4-10-df0c8bf79e16@pks.im>
Date: Mon, 16 Nov 2026 17:21:32 -0800
Message-ID: <xmqq33t0i76r.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> As explained in a preceding commit, a subsequent commit will introduce
> proper subcommands as supported by our parse-options subsystem. Refactor
> the "gc" subcommand to use parse-options as a preparatory step.

Even though the cover letter may have mentioned it, this should also
describe the deliberate UI regression to help future readers of "git
log".  When they see a bug report on the mailing list and bisect
leads to this commit, it makes a huge difference if you tell them
that the change in behavior was deliberate, with a clear reason
explained in the log message.  Otherwise they would say "the UI
regressed with this commit without explaining why it was thought to
be a good idea.  The commit unceremoniously drops a test that points
out this exact regression".



> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/rerere.c  | 43 ++++++++++++++++++++++++++++++-------------
>  t/t4200-rerere.sh |  5 -----
>  2 files changed, 30 insertions(+), 18 deletions(-)

> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index ab412ecc6e8..0d4cbf5114a 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -263,11 +263,6 @@ test_expect_success 'gc --skip-locked prunes while MERGE_RR is not locked' '
>  	test_path_is_missing $rr2/preimage
>  '
>  
> -test_expect_success '--skip-locked is only accepted by gc' '
> -	test_must_fail git rerere --skip-locked clear 2>err &&
> -	test_grep "option .--skip-locked. requires .gc." err
> -'
> -
>  test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
>  	git reset --hard &&
>  	rm -rf $rr &&
