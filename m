Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644853;
	b=oiBnq3bFwZTMfkAYI0NzgP6n1sD6lnEPPdWiO1CwF7GB0LixeK6N6ENMX5Zs6MXxvMRF
	 X/Th8yG9hqWjvBP8KgJUEu1vytjnSxCd8H5N70MgTYxYULLAeKfogQ04ieH8eHSTwF0rx
	 zClKs0walzklgaPkMDEQ29z7UHv0zz16b1YaAqilvZQFPm4coJNTcYVk1dVfE7kdIDXDS
	 aAyHo448OVJj91DuWfLe5LKnPUW6cu1BgJEKCOMVfkmSIbzjv5NoWBxTcnf0puALuAa4V
	 uGwi+RnvPygZA3OXKTST7jFzVhu3wSkverLT5N8Nm04WcC/rrO7m0whNeolui6ilOSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644853;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=8yjwPROhlQO5n0mhRps59yQEdb2TDgF3fyvv+DF6l/I=;
	b=OJ0DMvl8h79EattRayIMSYCAhlPZCcPqogjQN1ndvfZZGeLTpa9jRw8o3TFP04EROBqi
	 xdfYkO7LTaAbcdp/e/OqUc+ztGN43WSgdx9jQ4wJ2TOEkdl+wwGxk+rvi7BeuOen7YkJm
	 04UDSZ95lU21Bl0p99V8s7V8mWxvLIje/Ccoo5EuYCDEJAk57KamN+PdMSwqRcHQqvrBh
	 DnDuYm9PEaw7NscE2Jimh8HHJIm0PdqF1MlkbGkr8A8lQxnTIkRdJC2z5BkaqfuwCXYWa
	 VYcznd/iTqrjuomCfDPXz8YntxroT0EL3+jMQfmjY3Zf5tV4/IvUpUU9T2yYT7kKfng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=QMe19Lcz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LpMEdMtp;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FE606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0FE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=QMe19Lcz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LpMEdMtp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAFDE7A00E0
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 13:40:52 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 02 Nov 2026 13:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793644851;
	 x=1793731251; bh=8yjwPROhlQO5n0mhRps59yQEdb2TDgF3fyvv+DF6l/I=; b=
	QMe19LczlkycKE8HFAar1Y8dRF1r4NCUG8Pj3aYKxQT83MwGd1H0XRRnLgepaD5J
	YYrvvujMGAKb0swg/D/J95Gj/53vRvU7Dr2MGquda3/o+qbBDY0eQahnfBP8pZzt
	xZSAReIJmXaV4+RAD48W0qmr32XdFahlRVpSzxHd6eilRbgwal1gBkpq7fwJU63E
	D/wb/rvtvHpLz0tpac+Id6AbHBOu1599ibyuQJS+JJnu+Clk9TwqMldwm6pixmC/
	3x51HivbgPGdchX2xky7BTbS1lQjUeBRCvevK5++RKdYT604F1e2do4HfesmoIMr
	j/WT9pMWq/U2ID4UxH2p/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793644851; x=
	1793731251; bh=8yjwPROhlQO5n0mhRps59yQEdb2TDgF3fyvv+DF6l/I=; b=L
	pMEdMtp6ngKA1T0TMJcgYyFuKNphGs9DyI/GJZpUTm2D2KEqoL91GNq6eT8egRkh
	6mY4g/LM89C/iK6qe6q38Sbl+GAeLT4FTgPZMBJm9Xp1lU/O8nJAZhllly0oCRmK
	fHshkSw3xcq5EIORZEY5eKGKeaVfrTUpD7pUzhiTPgX5iXY9vvzpO93cnNsS3WJ3
	5Q/c/su7sRpGlM9gwPHS5JCcUQrUaOtgDcVZGNFFwcYoLmNhnPFImzX8ibazWcCC
	U5+fSzrS5MkBQovtsPo0MJM5ooGpM8oUBjzj7ozX1hFWk/u4DFiuJkYQy6W9MQWs
	EakaaK9CkYC2JBqVo4Ciw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793644851; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iZgcU1QlEb/QrDzqjd/rxeghJh/30ltCZCf/c8jHzL3esFi
	uxLqeMlZ/CZmKbX1zVR5bi2BogBv2IbxD8nmrWNq7EwHki9o0BjlIad8Uzm4l1K/
	NNIJg4u0qZallGhmuv+1LURpttjk5gi2gVIxj9JqpIHk895Imxf5jZ0NfzJe7pZx
	9x+OUDUg5N6lFQpa7DhLpqCuiBTYz8BXNRCxgsAU148Hk9yC5CtbKHwrnl0gBo/8
	AA960EtHlw5tFCQVrTM6JSP3jTzzS75MvzeQPtdGxRs6wG70Y+0U2W2ZM68OYjlh
	xEbDCP9J83qQ69PYDQvfL28zTSvovc7AhxfR/+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:m5LsJ6US7jVeRHaIoO9Kgsz2tii60Exfx9xjzcpEU78=:tg0vFdYKj/EwqWDoQFRpFsQBX2YfdGdSygmtX/zMx7A=;
X-ME-Sender: <xms:M9noataqYM9pbukmt5vjti9WsDkXzKCjW_29iq9F4YFKjZom-CgpDg>
    <xme:M9noavPUexJLWRApg3lFsNHnYvp3iStcHUXEJokNAUlstjmA8RwjauhNOFXmV5nOM
    RAL7varr8ub8T3mEC5xvTt5TzQSbOgdUwYSa2gesAOiylqTqzEcjIAb>
X-ME-Proxy-Cause: dmFkZTE9rZUl8CmVSlmYZE62dNBRzqM1xdS5hWgnp4cRnKitO9ZPlNjuFXcM3QXuEGHGme
    CWbTyutJKoyEs+Aly6ziAIJ83jcOIh6xY5UbgXcKWoGm5lxAxDCBQX7Zbt+w6QRHeAmVTC
    Xgo9S0aE+9z9cwBNSa1IdMvq0Jx51w1WNEh7n/Gii6h0k/vSVqfJOhogsM08Pj3Fq35CV8
    Ctq07d6WkeXdZ/U6VHG5naXgMNGWm7+A6nQcadmQyasYJXTKPKbCTiHH4kVFN66ovEchzh
    f+NNbKdqS1S7hG6vg+8QXP1h0dd++TWX3E0s3GKSxpS12y6xZeLdLCcggR1qkpPGtBwUs2
    q0at5zltjo5xfA6DwTukL80KJA+/3K+na+ZefI6H7D+apmExrjNpw5xBk1+hRYnAIbfSJt
    6kwIniELSY0SjeOtZaNCIMXGqmnOumrVsR0zdNrM0OyCmPD9XV57v0K+atxDA4s/NlZxT4
    FOjTeAYrjWjMCETXLPOLHyztTwqaxL256mk6Pq0M+4fvDCXzwLoBEVsmHRzDnXp1WcPg5T
    WUuLPWTYPoF0A0ycM5ihJo+uNq2V+IJvBVHPkGV4zSonVqI2irf4Ah1TNmSVq4EB0gHHR+
    urI7EIOf9yMHRVLu41J1p5v2P8k5Q7kTstMhgN7JvOTzFyXO7Xq6G6Pjiviw
X-ME-Proxy: <xmx:M9noalEXqOS6ppO13E9J5mGyBvAIdrxTGyCo8PSJPeQa0tkW8c1uog>
    <xmx:M9noajojHgEURUdg9ifN28GjjwINrTC40sz53Ftb_10VjWtvY8mIFg>
    <xmx:M9noaubqaLlqKN7DbrdX7i52orRGGwqzb1h4AApY5Q2vFd2FgoDVPg>
    <xmx:M9noasXG7sO0dIAnnabagRMAznS0qZDWLjGk54QGrhoF0Mh8I5pUMg>
    <xmx:M9noau1r5sd6rO2ee4NINF2ARqvYrpRhPTI_qHY-7HpEN52PDQlgolTV>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 221FF78273B; Mon,  2 Nov 2026 13:40:51 -0500 (EST)
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
X-ThreadId: ACnQOWVGaDJZ
Date: Mon, 02 Nov 2026 13:39:06 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Tuomas Ahola" <taahol@utu.fi>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>, "Jeff King" <peff@peff.net>
Message-Id: <48aa1e9a-3049-4316-9054-644a8754b0dd@app.fastmail.com>
In-Reply-To: <20261029184834.2273-3-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261029184834.2273-1-taahol@utu.fi> <20261029184834.2273-3-taahol@utu.fi>
Subject: Re: [PATCH v3 2/2] lint-docs: check the guide list in command-list.txt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2026, at 2:48 PM, Tuomas Ahola wrote:
> Since 2135e1ad70 (command-list.txt: add missing 'gitcredentials' and
> 'gitremote-helpers', 2020-08-05) there has been a comment in
> Documentation/Makefile reminding developers to add new guides also to
> command-list.txt.  However, there is no linter script to enforce that.
>
> Adapt Documentation/lint-manpages.sh to fill that role.  Extract
> MAN5_TXT and MAN7_TXT from the Makefile and check command-list.txt
> against them.  Exempt gitweb.conf(5) and gittutorial-2(7) from the
> new linter routine.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  Documentation/Makefile         |  2 ++
>  Documentation/lint-manpages.sh | 11 ++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index f8dea4b395..8e28ac784b 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -67,6 +67,8 @@ MAN7_TXT += gittutorial-2.adoc
>  MAN7_TXT += gittutorial.adoc
>  MAN7_TXT += gitworkflows.adoc
> 
> +MAN_GUIDES = $(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))
> +
>  HOWTO_TXT += $(wildcard howto/*.adoc)
> 
>  DOC_DEP_TXT += $(wildcard *.adoc)
> diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
> index a0ea572382..31ee3cbe72 100755
> --- a/Documentation/lint-manpages.sh
> +++ b/Documentation/lint-manpages.sh
> @@ -1,21 +1,23 @@
>  #!/bin/sh
> 
>  extract_variable () {
> +	file="${2:-../Makefile}"

I think what's happening here is that previously we were
getting the variables from ./Makefile (in the basedir), but now we need
some variables from ./Makefile and some from Documentation/Makefile.

Would it make sense to get all the variables from Documentation/Makefile?

> +	directory="$(dirname "$file")"
>  	(
> -		cat ../Makefile
> +		cat "$file"
>  		cat <<EOF
>  print_variable:
>  	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
>  EOF
>  	) |
> -	make -C .. -f - print_variable 2>/dev/null |
> +	make -C "$directory" -f - print_variable 2>/dev/null |
>  	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
>  }
> 
>  check_missing_docs () (
>  	ret=0
> 
> -	for v in $ALL_COMMANDS
> +	for v in $ALL_COMMANDS $MAN_GUIDES
>  	do
>  		case "$v" in
>  		git-merge-octopus) continue;;
> @@ -29,6 +31,8 @@ check_missing_docs () (
>  		git-stage) continue;;
>  		git-legacy-*) continue;;
>  		git-?*--?* ) continue ;;
> +		gittutorial-2) continue ;;
> +		gitweb.conf) continue ;;
>  		esac
> 
>  		if ! test -f "$v.adoc"
> @@ -87,6 +91,7 @@ check_extraneous_docs () {
>  BUILT_INS="$(extract_variable BUILT_INS)"
>  ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
>  EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
> +MAN_GUIDES="$(extract_variable MAN_GUIDES ./Makefile)"
> 
>  findings=$(
>  	if ! check_missing_docs
> -- 
> ta/command-list-guides-sync-lint
