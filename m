Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450446;
	b=blg3Xo9ac5Yy58CIP7ruJBgG9sUVSg7Ujlg0p2Cwq1dNUCoXfcchYFkuq1wfYrKimUbG
	 tvK7uJzB+Bku7Byboe+VDxnYniXi75kBPfjL1mY+dUpWqcJh11bQJxfYXXkAv36FZ9hya
	 DMN1ai/vddtQbNol7qFUyJ0egy4VJPKukMRlgqFaUJJYyBEBsYkVWvqoCfJ6Op46Xuodu
	 CSB9H9wgJWGiISM6uSiAZ7r89SQN3sBt6HDJXUidTKOszMfUgxUa9AXYCr4PXEKtdquMA
	 rbskXZmNJDZda4M7M36NAUIcgh7vqMaj7zRpYsVf4VAkwiDR/gdliitSONhMF4SsxmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=H/bCdi/xbltorGknJfNQJbNeu/WQeUe7F4lhwHIRG3I=;
	b=CjnbMNY+OMtRBGybkB5xP6DQs5yj3BHN3a1Z2JsYQlNIi/mfAYe5UDI9aczU5N+2gAu3
	 iAp6qIVjkUvJKUNDbIun3AYpInjhYnM8PEmtPCSn2Qak1N8Jmf7HL80n/+Hs6QtsO2vUk
	 D3C+wRYjLIKR4v95a946wVHc7dh6SQ1fcRU64Lz0SiZLIqGTP+R8VZFqHKC+FXqgYIvWC
	 rRg09jYbGM4Rjm0SJ0GI0xjtEZhvS8l3nyVclLRRSE0yXH4JYwu/kFzmXFJekmMCXoreB
	 rTqxjnIvlmnZj6j792OSNxGjPQ/091r2PU772OkT+ASZsIhXjz05JI0gvJrkJo6yMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="C3kT6FZ/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V0dlCQYp;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06ED606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C06ED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C3kT6FZ/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V0dlCQYp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E2E26EC0C5C
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:14:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 23 Nov 2026 11:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795450444; x=1795536844; bh=H/bCdi/xbl
	torGknJfNQJbNeu/WQeUe7F4lhwHIRG3I=; b=C3kT6FZ/GAxgpzGru27MJnMX2y
	Rn/xuiMbhpaV4sZ0gVmvFh/xOHvxTeXqC1tsKGf/d6Q/M2zXiboALf9/d7/DDutA
	zXLHgNjUwTfwgXX4JNshcGYJTsl+RNVCDmNXvFqhq3ExPkIMQOY3n2Zt91chLBit
	JBRJnaZ1F26Nb9Aezs1lo4/IUUsno8p9/zWC3Thg107ML5XMOw0vVuJk0ZmWbEzL
	m+LY+BUbdUqpbrLKKNBrQhgK1B+e0nJJoUPTsn+gANi0RnjiV7/oeM132jVQiDXz
	nNTJbXZ+/v2rQALQP4jlE8GoAlRgCSWN/qVQH7KrSCq8aP7x8kbmA5gMbizw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795450444; x=1795536844; bh=H/bCdi/xbltorGknJfNQJbNeu/WQeUe7F4l
	hwHIRG3I=; b=V0dlCQYp1JGWFQJnPrpQfd0+gV5jdTitw+zJW2WmPwcR8IW/xk7
	cn+MT3hUDK0LUazDr0ukMe0ZmN9ybwOpccKcUEfnciX9UxYS13pA6TUCaFMeSHST
	tl0DPBo0kjSN+4vQp0LCFzShmEh3Pl+nYeYbAazV4kZ+nCHDjU8D5B6fnNW2IjdI
	g/D1gxWqwDMJhBsJlkk20AbfUwYISDb9vY0SGrOfUdbeOCWFQtFgKO8DPInirXsT
	29ilJbR3dcrcVt0Uq6ynx6xRUsX23vC5W1TlGWDbZnU1s04NIxCbcthrES/HGdKW
	9FAb846VELIKSoU18rbPN/TA6br/2t03rpg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795450444; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:II8OgAbZ9xCEJ9nhUhV6dVo/PnTcqFHdk7k8zaNlbeqNDmA
	lBd6Qz6fZKI83B6qSiX3k4ooccyk7wsTauwfbI8MkSlFiuDSVyj0kKukfOeIcveM
	zqZt/BplNYPR+IdJBEVl5W81aysrPH5Mi12FN39lDtrxEFSzZEEP0t4gqtUpWstR
	OEoGe62q96WYBJQD+NnEqerHZGfcyXXG6MLxX6nja2yJwmDQ2jg7CD8RV5N3B5xO
	SspS5Rt+bJqkZluNus3OkGjyUsRwqnrVLfbpksjcm6EfUPuCNHq/uZcHFyfvkKKr
	beG0uK9NOtqJ4mA8f7+8id0kCvnZSrj9k8VdjLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8h21L3ajbutpBQMPh2XRLpCJ0oUm27icjpUZMOCF8UA=:hsjdwvf6kBLRobmsjVVHECwi8vpSqyyyybh3/KKCktY=;
X-ME-Sender: <xms:TGYEa3MtcScLtGDUwJX5UgAlgNH_aWu4DmL7O68HROZeRgAWh2XZBQ>
    <xme:TGYEa42SNjXWU3XskfkUCqppX22u1C2XcbTl1DYVdgwFCJAlXU6y_AFzrtBG8Z3Wh
    ZmpeI140GBam-1nImAKLxfshNFkYH9WgMWxDBJFmV_AvVjRqDtwTCJH>
X-ME-Received: <xmr:TGYEa-mm9bJcy_63vQBdaah8KADHKsgzM4MsvVPF6fADGCu2OFtMn1Mxg6ibtK9gSTpQACcinE62kpcdjd8wadB3Qn5n5M0BxiV4b5A>
X-ME-Proxy-Cause: dmFkZTGiG/uSaPriyBuSrzPknUg6BA65vmx2vQmjYhEOvt1dxgqKmNu7NxdqVQrdFNpidE
    dzKFVOZcMPMgSpulBmHKT2Ha982/W9BWtU6zKVS2v75Zm0htHrnNB7Ojzbb6EeIpCjmAwJ
    UwqlSBG1+l2HEQllbFfxfGp+h0Eynv2TjDVTrWFKIelvnMGORYQ2uN2bcQ1W7GzlsXNJB8
    0IrtVFsjBahqEHucQLNc3vgHCt3NHKjKX2+Um/poOiudeWXapcyi2iABP3DINBrh9AeVvC
    xQUdMD9yaTULe1vE7/nADqa6l67bAwOtlMUmc55k8mt2TRIjOpEH4vOf9PrShZlibnX/MC
    6rB0qKq4CjR0ZhGfB7+bM3Sxr/aZ7MgjsbuF6ms2fuLxu86qjeBJsXQ/VqgipF4fcVQX74
    7iir3US05wnPrgNADG1dxz8koNnBkZVQBIwdm7xlR+ofomON3x0y39wpN0J3/Z4ro+kHOI
    6SaIa3RZhM4lzEugU8Y40SaN799aC1MEM0KXobhFu475VsOIGKa1eHOwT+QN0Q634HOitW
    bjSY+tUdkBAoAywis1JGmFMbgRm7o/Nd3FapA41x7xrnFz8M3to3VgccwQ3mJ8hZv1neIt
    lJV5NONNbNu1U+8ccxzQBfjSN59GSDZKiTO/xH8/cz6twLnyBS0Xtyw0Snnw
X-ME-Proxy: <xmx:TGYEa3WR-lhxV0KD0PDKCRDI_mNQHiGI5OvQCjg-FQMLrqBLqOmQVg>
    <xmx:TGYEa8vJUMRrh1mXffkK0fRKK89OiGX6yyfRh-Zz-ztpb5i_Mefs_A>
    <xmx:TGYEayan0kCxG4dxdUFgyJ7nKzCKH8YF7bD7xD5W9a-VPRBYpm_kjQ>
    <xmx:TGYEazWXHj1IxeHmI6a4Vg_XwpGz5kybsLo-_PB5tIK-X0ltHHxmTw>
    <xmx:TGYEa6HXF5KtJVXG63qKr4Yx7Bo9InVuzxpWZ-_ngtaagR8jJ3IrUXXG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 11:14:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <adam@dinwoodie.org>
Subject: Re: [PATCH v4] setup: fix hash algorithm detection
In-Reply-To: <20261123011403.720209-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 23 Nov 2026 01:14:03 +0000")
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<20261123011403.720209-1-sandals@crustytoothpaste.net>
Date: Mon, 23 Nov 2026 08:14:02 -0800
Message-ID: <xmqqmrqzbk51.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our current hash algorithm selection code has a few different problems.

> First, we do not actually default to GIT_HASH_DEFAULT because, due to a
> bug, our code has never considered GIT_HASH_DEFAULT as a default for git
> init and if an algorithm is not specified in the config file, we assume
> that the repository is SHA-1.

REPOSITORY_FORMAT_INIT does set .hash_algo to GIT_HASH_DEFAULT, but
create_repository() calls read_repository_format() early, and that
overwrites .hash_algo to GIT_HASH_SHA1_LEGACY when version is -1 (e.g.,
a new repository).  So indeed, DEFAULT is not honoured in the code path.

> diff --git a/setup.c b/setup.c
> index cedc031c54..c2a56b997a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2888,24 +2888,29 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
>  
>  	/*
> -	 * If we already have an initialized repo, don't allow the user to
> -	 * specify a different algorithm, as that could cause corruption.
> -	 * Otherwise, if the user has specified one on the command line, use it.
> +	 * If the user specified a hash algorithm on the command line, then use
> +	 * that.  Otherwise, if the repository exists, use that algorithm; if
> +	 * not, choose the environment variable or config option in that order,
> +	 * and then fall back to the default.
> +	 *
> +	 * If the repository is already initialized and we pick a different
> +	 * algorithm than the current one, we will reject that below.
>  	 */
>  	env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
> -	if (repo_fmt->version >= 0 && hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
> -		die(_("attempt to reinitialize repository with different hash"));
> -	else if (hash != GIT_HASH_UNKNOWN)
> -		repo_fmt->hash_algo = hash;
> -	else if (env) {
> +	if (hash != GIT_HASH_UNKNOWN) {
> +		/* nothing to do */
> +	} else if (repo_fmt->version >= 0 &&
> +		   repo_fmt->hash_algo != GIT_HASH_UNKNOWN) {
> +		hash = repo_fmt->hash_algo;

I was comparing what is done to hash (here), ref-format (below), and
obj-format (further down), and noticed that the latter two only check
"else if (repo_fmt->version >= 0)" at the corresponding place.  I was
confused by the extra check to ensure '.hash_algo' here is not
UNKNOWN.

I know the proposed commit log message did say "should not occur", but
the code makes readers wonder why the impossible case is sitting
there, and it will be even more so after the code becomes part of our
history and somebody is reading this code in a few months.  They do
not always go back to the log message.

Before control reaches here, create_repository() would have called
read_and_verify_repository_format(), which in turn would have called
read_repository_format(), which in turn uses check_repo_format().

check_repo_format() is the only place core.repositoryformatversion is
read and the '.version' member is set to a value to give us
"repo_fmt->version >= 0" (after REPOSITORY_FORMAT_INIT initializes the
member to -1).  The function also parses "extensions." and calls
handle_extension().  It rejects GIT_HASH_UNKNOWN, so the '.hash_algo'
member cannot be set to GIT_HASH_UNKNOWN by it.  Again, aside from the
initialization done in read_repository_format() to
GIT_HASH_SHA1_LEGACY, this is the only place the '.hash_algo' member
is assigned to.

Therefore, if the '.version' member is >= 0, the '.hash_algo' member
can never be GIT_HASH_UNKNOWN, so I think it is pointless (and
confusing) to have the check to ensure '.hash_algo' is not UNKNOWN
here.  Simplifying the condition to

     } else if (repo_fmt->version >= 0) {

may save readers from the confusion I had.  And that is what the
ref_storage_format and object_storage_format sides of the code do in
the same function, I think.

> +	} else if (env) {
>  		int env_algo = hash_algo_by_name(env);
>  		if (env_algo == GIT_HASH_UNKNOWN)
>  			die(_("unknown hash algorithm '%s'"), env);
> -		if (repo_fmt->version < 0 ||
> -		    repo_fmt->hash_algo == GIT_HASH_UNKNOWN)
> -			repo_fmt->hash_algo = env_algo;
> +		hash = env_algo;
>  	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
> -		repo_fmt->hash_algo = cfg.hash;
> +		hash = cfg.hash;
> +	} else {
> +		hash = GIT_HASH_DEFAULT;
>  	}
