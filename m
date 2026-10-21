Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571108;
	b=lUEL05AN/m9HXXAod0awk3DnV0HPCHi3heBkUBv8yAJRflV1VarQXMLWVRVEqEljsWUx
	 01o4Qrn2BY1qJ/T7adQw0RIJjuK+Z66sTp+Wn9+RIkxyTGJB+CgZaPDweLDLqSpp/UmaP
	 0GNdWLrz0/nf0EUfhYdXRYhBRoXvZZ3f9R9Qcarq2u/eAHUZ8hTb74VRq+JOK82YloACJ
	 bEfP+S2Nrk7Xl56IkRRCMx69pBMhfU/Tdpm4r8CGk8zaGsM2F84oNdl+BhyQhgzGd0i8k
	 iN/eHo1zoy0pkkR15OS4mJWikxvXPL3PGQwKzSoIIrgOvHsoCJaewtkpG9i8Y7ygSHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571108;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jHmuFeCHClENO46PPrL02mc/rwW7SULAInhLFq0OFEY=;
	b=1HLLxIqZp8kK/kQG15hFhLka7nxIsVnA7QdCj/R9lVyX7werIkNaTfmRdlobuJnqK+K+
	 42A9AJwAKxo4x3AguakA75hWccgMZ/3FTk+0XmhPRxABswWEjCKyUnZKuIxMQkDBkWfCs
	 COzS5FSeOPO/XmJ+CmOBFo3PYJkLZTfy4+1BA3cANGfxU669YvjDlZETR2vyGlC9Oowp3
	 /rXISGWRVB9wxoW20ncQebNurpSHxh+ynfZT+cfy8gZul4ign7eeXoBFSnGv0HuMVbLWr
	 7J6SlhSaXFYwPHEuT4It5WTDgfFYSvn+aYLLVTFgwqXE9mbjezSnpn5SMeVdIQQw+UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=BZ5PFM56;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tWOS9D7z;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445B606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C445B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=BZ5PFM56;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tWOS9D7z
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 097FD1D00093
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:25:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Oct 2026 04:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792571106; x=1792657506; bh=jHmuFeCHCl
	ENO46PPrL02mc/rwW7SULAInhLFq0OFEY=; b=BZ5PFM56uaWDWbMGz36g6U/9nn
	FoUWE6a7jNM+DvcZabPf0iMzNm+56ybzOD08JDKentdCaEZfNW6AJ0NJHkfuWaF3
	SZ6FtWeJaN0S/pHieX01QMo/Hyd3kW3Q+akJG4GPz7vFAr9Syyvjt6YB52bawXUJ
	l34kMKEO7ywQSE7GQdPpI3qMHRXOm5GTCNoYqLu4U3z4FG74oZye6rgxGAmYAODR
	G0BV7rARumSabPHAIMqp0ZXuJBbNILvsKQnx9xUCf7Au4TdZhuVMIFU19wx984Uh
	VW1X/cAoNyGUaTxfPWyl57ttKE/VZPLsP40DK2HezSjxiU5qfuESR1cUfOJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792571106; x=1792657506; bh=jHmuFeCHClENO46PPrL02mc/rwW7SULAInh
	LFq0OFEY=; b=tWOS9D7z4XxFFGfk0IwuGkRt0ZiPXNKjW52UMb6H0+DVJjbyEqD
	BE5XB9OE4nKym1n7ZXfbo4qHW2eerFsw/cB4766ICm4vJhVbIDaWxXztIZTu2s9z
	OeV0ewhzLwGNXiKOIrdhHOur7yqm4X7tFcyo+D1ot/7Vv4CiZa6b00ANhSQ7KH5N
	nulMtloRntW330zUKq+aaYdqBnkmiGdCtx9XjU5QUKrVxkPshtIsY45HtigXqWgH
	/Rxx5ZY2NkKPL0jOnhQAsmFggahoiEqgd6V3g6Bx81Diq3aTXri/C6+dCOYIVpY7
	/owZs4cWHp7j+fWhn6cSgiXuB9BkhvbTMMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792571106; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CN2tHhM9a71N+CCVNvxVc+hDV1xEsTBywNF7tBMBpOBGg/T
	+SO15+Zoidg6Y4PHoy5aPgAswpDFQC+Lak1dm8vL5R4GNz+fM2rgnGtmM76dROrc
	dNTPujIYIGL0yjh0Ys5klYxS2dBAe8YrPFDOV81xkK8IHjVhR0yIQMGvQf5OKLYt
	TbBz0eCz7SqwVYLuPJcJJGL/bltQSWQ9cCQ7D3wa5NfC0TbJnEHR9JGT9bsOIs3y
	S97h5aFQ6zXBgf6Vf1d2gUbyHxHZ3hWW727vHU473d/rPZ9SGiY7Lwuv2DvAZiW3
	vy038MSuFxCqmqB/LtQvMuAOfhl5Fbrb9uss+lA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:V68gg2KeScnHeUCHoKE1b//Ky7rRP12LpknQt7N/sdQ=:wB0AvYV4nhb2ffBPPx7G4NMOwzcOaulmuqotAnYf4Fc=;
X-ME-Sender: <xms:4nbYaiNeu0bv1w_9BOvTF7pWhDxRy-svXSOYNVmQLyAm9_s4ihNSAw>
    <xme:4nbYaoZ-cEgqDXbeioiTNe1DqHrS5wEed_jRawGLSj9qeNgqUzCGZlNrXoY_-453U
    nzJNQf2ILyZrLLqZqRI1pcowAzjNmlhe0kNdKARp2B4iQ6RZi8n7do>
X-ME-Received: <xmr:4nbYampLmPU0fBv23x7RKXw7Kye86sdw0AxLXLh-mUni-WjbbIoMmA>
X-ME-Proxy-Cause: dmFkZTFGK+BmQVMyww2oT3g1c8x3w58A2sfpOD9BgiqaYkdPlIfFQQvvCX6H/aKWgNwe1a
    2G7YBhKH8W4h67bdgULip6+GJPbaK1vGJ0uDt4eIi7O77UsQMXj5VoYXqE2PrAzkIoe5cU
    3KwWrVtoj18lmB3CUgNVa3b8h34GUT/OaW7MXVq37deak8x8TwoRRmEuIRdpxNIvmwAvsS
    reL1NZoXUonjAFkwHMjtWy9nFycXVZtm31p4ucssuIceq6XXItDXLbyh4wTLNLAN/By1ml
    +MmRdft+hXKGtYpx/e0XbbJQmmD4BFoPBdCSP/BVC9VY8afbBMvwcKsSZ6CVByLHtdDHGl
    1GFi8AurUM2alBtsbRa/YpXGu73MqFTX+EzXPss3aHGnUwtqF6cazOMnCXlK2v9kXLVquH
    VW9svfXmZb0bHKyAJOr4zt9/S0TBm4m0RkFJqwqMyQMIlX1c4p1XFGoeyz2OIX3Gh+p3/t
    3o6ZvL19jZ35rFlfViEKTw2kR55xpeXUG0vVk2ae5L7byVf/9TlMH5OqhXCNTFaXWXSXoC
    K3ETT19r6BwAIQr99mJEdLUqIrX9U7kIf7v6S8AGXR7jyMDOKMUnv1iQJ6O3bqXoIrK9Qk
    Vw6cE+X7GjOnfStyNqBDHpwZoj2Xkr4QLnB71+1joc+oC56WrHTv0gS1UgDg
X-ME-Proxy: <xmx:4nbYasbbG8C524y7-GQeAayEEvxErbu1Kc2I-jcAKwbkCBTU3GEMUQ>
    <xmx:4nbYauTyOYyB6AmKgqdG03tOdUbEXI7c1NroYxnPHirAmBf8r0txkA>
    <xmx:4nbYaj7EpnH15ZLxSGQTtB07brHzrJPwjmWVtnjRKP8gtSm-JhRzbw>
    <xmx:4nbYajxMTFPJeFp9pgApMKVeX1G3BJ1LB0aqaqTJgyrEd-nU2vxk4A>
    <xmx:4nbYai1PNpl0ge-z60Epl0N65hZDeCwwEVs6pdUUq0IXqQRXrlmNgVft>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:25:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28d229ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 08:25:05 +0000 (UTC)
Date: Wed, 21 Oct 2026 10:25:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 2/2] imap-send: accept messages with Subject before
 Date
Message-ID: <ath23vYy0n8UFLUB@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com>
 <c42827a1225e49db2e0855638e4e76a06f7d9eba.1792566469.git.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c42827a1225e49db2e0855638e4e76a06f7d9eba.1792566469.git.gitgitgadget@gmail.com>

On Wed, Oct 21, 2026 at 07:07:49AM +0000, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Patches sent with git send-email cannot be fed back into git imap-send
> after fetching them from the mailing list archive, for example with
> 
>     b4 mbox --single-message -o - <url> | git imap-send
> 
> which fails with "no messages found to send". imap-send only counts a
> message when its From, Date and Subject headers come in that order,
> and git send-email writes Subject before Date.
> 
> Accept the three headers in any order within the header block of each
> message, and match their names case insensitively as RFC 5322
> specifies. The copy that git send-email --imap-sent-folder pipes to
> imap-send then passes the same check, so the special case added for it
> in 04133f5bc4 (send-email: add ability to send a copy of sent emails to
> an IMAP folder, 2025-08-12) is no longer needed.

Aren't you fixing two different issues at once? I'd argue that this
should be done in separate commits.

> diff --git a/imap-send.c b/imap-send.c
> index 6f76bade35..7ae2eeddc9 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1453,32 +1453,29 @@ static void wrap_in_html(struct strbuf *msg)
>  	*msg = buf;
>  }
>  
> +static bool has_required_headers(const char *line)
> +{
> +	bool from = false, date = false, subject = false;
> +
> +	while ((line = strchr(line, '\n')) && *++line != '\n') {
> +		if (istarts_with(line, "From: "))
> +			from = true;
> +		else if (istarts_with(line, "Date: "))
> +			date = true;
> +		else if (istarts_with(line, "Subject: "))
> +			subject = true;
> +	}
> +
> +	return from && date && subject;
> +}
> +
>  static int count_messages(struct strbuf *all_msgs)
>  {
>  	int count = 0;
>  	char *p = all_msgs->buf;
>  
>  	while (1) {
> -		if (starts_with(p, "From ")) {
> -			if (starts_with(p, "From git-send-email")) {
> -				p = strstr(p+5, "\nFrom: ");
> -				if (!p) break;
> -				p += 7;
> -				p = strstr(p, "\nTo: ");
> -				if (!p) break;
> -				p += 5;
> -				count++;
> -			} else {
> -				p = strstr(p+5, "\nFrom: ");
> -				if (!p) break;
> -				p = strstr(p+7, "\nDate: ");
> -				if (!p) break;
> -				p = strstr(p+7, "\nSubject: ");
> -				if (!p) break;
> -				p += 10;
> -				count++;
> -			}
> -		}
> +		if (starts_with(p, "From ") && has_required_headers(p))
> +			count++;

In the preimage we special-cased when the line starts with "From
git-send-email", and in that case we didn't recognize "Subject:" lines.
So you're not only changing that we now accept the headers in any
arbitrary order, but you also make us accept "Subject:" lines when we
saw "From git-send-email". You don't really explain why that change is
okay to do though.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index d1393ef197..1f77c14315 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2863,4 +2863,39 @@ test_expect_success $PREREQ '--compose handles to headers' '
>  	test_cmp expect msgtxt2.to
>  '
>  
> +test_expect_success $PREREQ 'imap-send accepts a sent patch from the list archive' '

Quite weird that every single test carries this prerequisite. Makes me
wonder why we don't just skip all tests at once.

Patrick
