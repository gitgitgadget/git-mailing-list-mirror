Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738745;
	b=toWCpRqGE5ShtWAU1a1MvAjUVOlsYEQXqEdoMrJ7fl/lj1qRqBAGJEyA9w3VI5cvYT04
	 gzv4/JXJniljc69m/xq55BCYY97ej9pkyd927t0vfruhpE59DCL6AIn3W5aBkFTyNDLmC
	 zMWFERHrcBILheQ2AD95PiffL6dt4upVl2sbVEzEw6IGWhhs0S/On0kpRnhOyTd30JU7r
	 cAaQWRPz8Pt0oC65dWnUfjI4w6UbulSMU1e8M3uMWSoPUjl56TiILg2cc+lFErHqdcjWQ
	 OoKEBS0krxcfP4ZuipgoYJ4ji7v0a5yxVZht7Sjg6Xg8jBGBc2S/g8TD040IZMcn2cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738745;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=LcgBx6zw8So2gsxeH8SlYuzAwxkwuky1YY3nP4pCFLI=;
	b=fzuiYxJ1WrMni5xlZc6B6ouMNk1s43T2aODhtjVrC0Wq6K4XfqMbHjlsEwjEMyjvcJok
	 KgM3Jxe/RmvO8bHNyg99Pl889Or4OUaStlhByf8vUj3kPYEcSKuImpLpI/nOeL07bqgRE
	 tRwf8CEJh7XsMyyzyMBJf642+kXTubdMXPCVPnjjjn4VcLdN7gowtm72YZp3bl40E1ddP
	 K7SYUJrnP1s9AGOsYlHmkeKm0cJU20ISVOLgvBjAEZTUnuesWU2kXIFJjF7JiAGil578M
	 GQBxRPe6HkBZ9UtN1gvU2XfaQa22bgiARZY5cpRoLheK8HgUKzcvJVfXZOqfXrh/6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=XtyZ1FRe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DGWRyk3P;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B3606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 20:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F03B3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=XtyZ1FRe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DGWRyk3P
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 387211D00152
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:45:44 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 15:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793738743;
	 x=1793825143; bh=LcgBx6zw8So2gsxeH8SlYuzAwxkwuky1YY3nP4pCFLI=; b=
	XtyZ1FReARy4SsioVaQi/6hybxukIIf+PvlcTueiaXydM86Y++st5Isz26nB/aZn
	DKsHPBPJQeU2I2PcrcrgT836BFvuwKuWFIuKs9IYhy0NYSEFftArM6H1Tnv3qPJ9
	6uBXuW2sWPjtOTyXHJk5wuGnMgTI7rMqNGR0Y0EoWUvrmIpH5AW+g03q8CXCIYDR
	kt6WuYeKVo4svSuCNriWiBE2aEKmWooe7dQtqxMnrH7/QW088HIlBAcV50vQNaWA
	hyDxWR3RthcRxJ0q7tEJ+3MwGAlZ4cKAysB6gwe42vLmI+P8qCFogimsATs2uWBy
	Sc9jSzqIwELEkWRnPIgQog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793738743; x=
	1793825143; bh=LcgBx6zw8So2gsxeH8SlYuzAwxkwuky1YY3nP4pCFLI=; b=D
	GWRyk3PANokvYHFN1Qt8garyV+2vjkWUglLR2+XASlb5U9AaawQGE5HUyONVMku4
	qNnwVDe4OGZmnjryQX8LGKCbTZtjLc/BRFn4Ht0U3+FSViALmiPU9SXiSvUWxoNR
	pUTMRHUuhdmZnnMDjq4oKGXaBbJu1CerFPELTpzsDa6BAuAQYm/y85AMTYpozVri
	oBoFfA9D1YXF015frAhBmht2yzkgzOOcL1xNi8p9FaCeHjAEM31ldhjcQkpL7I0y
	Ir1wkAKALeGGdbjUwB0/EvtdHiwhTqxIkWxszpwuvyP+jrpTVXQwNkTVQ2zTJCrG
	LmFBUlHs1f3IL9hw0ztuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793738743; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:hAvd58nQgdqYOsJpuj3GZi/nJgnirLKRldKgeYOaimC526C
	J2QwOZvCepfzOSZWOLUTsOD9PuE8fLE+7cY148aOL6qzWTPvFetsYSV2hGpKrIwW
	Ss/kdZeDILj2R6Y+mL0thTiiVVxaARPbBJtJvyrknC1N64xztbKzPUc793HUl1I8
	KH8CUz6dJLjExwwZiyLoy6xuzrQuB9nh6t17S98lN7wS1AuqxJUJVGH7nDxX4O7W
	72bbFdsJH82ZW71NTl0JuJDdMXiIyKBRfHoaUeKtBOc7Jl98meT/BJcn8KJ9bRnp
	btK6BJkor4Bov3/OnBnwShPX4kiFrWI9o2vRZLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xf/tyvt5FzI9umhY3dM2sHG8ioz9v4deYbPYdHzWC14=:o6uaUT/0Z0RAzqmil+Vo2N8ysbQasV3KzJiLmV2ye7M=;
X-ME-Sender: <xms:90fqavJjFL_2En-3X3PpHrAl4LfisYAmx9FXoteuPaEUJKgIKYHi8Q>
    <xme:90fqat_NIIjxjgJT4f6ubXBrxp0Qs7Rq569RaHdMy2Sx3XKZhKF2s1O5XkgfTK_hu
    FyQZpG1rl_QQeZLHy4veqkpt-kuI25acSu6gUt0ojjzHe2jBmiD1CA>
X-ME-Proxy-Cause: dmFkZTGOr5VLgqg5pvpKW0xScVUtR7K8v6s014G/U8dmsOwjxI/9zQgnSb286WH2Fw1ZgL
    uPo4uv5IFytk9nyO2qXmvgL4cL5rqyj3dlPlHojDk3XBbxoXvbn8jBgG1na2BG+BgLhyyQ
    w9yMSH3NGqb6SXemkb2OCiMHlUvf5gsP5AV5GaBzEQhKp/beUzEE6z1rDLnyElkJwQC8iM
    O9drasDcQ4mopwVypwSE7E4KJN5vxeAr3z0FXqgBHCmVMg/Sm37NUPeZ506mJFhxgolNX+
    wztEDTkFEI8nvL21+ZOZI73hL8L5AuEYPsAc3XcNn4sAueviqiTPizRsi/NyJD2CIviIXI
    kjzYl4gZ36SI2cTjvx+8qOV71ehNtFAGNQQOV0MjljO/LNQRySCLwM9JdLz5hqwjYOgJDR
    adrUa69dIOQmED8rkVs2BBRbjbEOQAFdzD9FrmqON+SuM8uPy6T/HFGkzOiiXa/GI1X5K/
    QqTr3b8k3pP5qSGGtMjZHuRTZzyPdaEdplrK7mcOtAswrNVeiBnJXRUkJf53uqCN9bAtav
    ZIh5WeYcKfewENh3ce1mszf2tsXoqttI9OPZkjWUclOw98xlWTuGjpcXxhnevLVV+0oTJh
    TxRBo5Zy0ZpD2zpv1dCy5pkcrqAVAUysZadyAGi+EWXILiYjavBd4hDNkJUQ
X-ME-Proxy: <xmx:90fqanyPqpm7Ix8JBy7CC27tJOaGbYPPD7n4eySKFVyiidKhKDwj8Q>
    <xmx:90fqatGN-FHy1krnHm0hlQHSm_5BuWfgOJgkB_4kvuIX0u8jLZDXug>
    <xmx:90fqarxdK95CqYA8JlW89oHO00-0S-wB1HOWI6VOzwgnnvN8TkL98w>
    <xmx:90fqauselE4GB0Ibf9KPxvLdWDTS5LeDImdgkmGh6esA70KC9SD4yQ>
    <xmx:90fqap0CrG5sMZ4viMRL9P4FsbBt1Lxmn2Lq5yuf_fFxLXBXVSkV6ELm>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E1C878273C; Tue,  3 Nov 2026 15:45:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AEuMsLfrft43
Date: Tue, 03 Nov 2026 15:45:22 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <ff8c1473-aaf0-4737-9ddc-5275e6ef70a2@app.fastmail.com>
In-Reply-To: <xmqqtslx64em.fsf@gitster.g>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <xmqqbj857l9r.fsf@gitster.g>
 <9a6ae876-78d5-4513-8c75-c4c071c3db6a@app.fastmail.com>
 <xmqqtslx64em.fsf@gitster.g>
Subject: Re: [PATCH] doc: git-diff: rewrite EXAMPLES section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 3, 2026, at 3:33 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>>>> +|Show staged changes
>>>> +|`git diff --staged`
>>>
>>> Do not sneak this change into an unrelated "change the format to use
>>> table to make it readable" topic.  Doing this change to just this
>>> single example would be a severe regression.
>>
>> I can change it back, I didn't realize it would be an issue.
>
> Changing this example alone without checking its fit in the wider
> context is what made it problematic.  I do not personally support
> "cached to staged" because I consider it mostly a meaningless
> churn, but that is different from saying I will veto it.
>
> I just wanted to see a bit more consistency; without changing the
> main text, the change to the example made it look like a very odd
> thing to have there.  You see the option named "--staged" but it
> is explained nowhere other than being a synonym to another option
> that is much more widely explained.
>
>> I dropped it because I wanted to start with just the commands that
>> people said they found useful, and it can be hard to introduce
>> too many "new" commands that aren't well-known already.
>>
>> That said I think `git diff AUTO_MERGE` seems useful and I'm happy
>> to put it back.
>
> FWIW, what is in the current document was added by choosing what
> were found useful.  So you would want to think twice (note: this
> is very different from "do not change") before removing existing
> ones or replacing them with something else.  After spending a
> significant amount of effort on these documentation updates you are
> making, if a new person came and rewrote them again without
> understanding or paying much attention to your reasoning behind how
> you arrived at your version, I would imagine that you would feel
> terrible.  Please give the last person who wrote these documents
> the same courtesy and respect.

It's very hard to understand from the Git history the reasons for
adding examples that were added 20 years ago, for example
in 803f498c03b where these were added, especially since the commit
messages from 20 years ago tend to be a lot more terse.

+Limiting the diff output::
++
+------------
+$ git diff --diff-filter=MRC <1>
+$ git diff --name-status -r <2>
+$ git diff arch/i386 include/asm-i386 <3>

I do hear that AUTO_MERGE was added more recently.
