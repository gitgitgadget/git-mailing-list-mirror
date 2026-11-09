Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207590;
	b=bhV6vtK3hgHcP2uxoQArAkIshAutEMlw/8oobGdF1Udm7luWZMZtHbdzjh1+HR/B5nUG
	 X0nD85c59+hBIGcQUmfFHhikwOMxvkNscMzWzvBvTtXMK7LOW100CNH5qFRJHrv1TylH0
	 iad7L2pGoW+p1mo9SxA1M2VCg21SkyHDyTmdB5QnjEh9dSjjSaUEJSXHbJFle5yy1M11g
	 lBEWPFC0fb9piVSWfCeBbf7zoQRWha6yXRN88+HgNfd1GaLiELYinVsM8IJgQX9mIjHsS
	 qZNoS6LLgjKJmZeR7f8rTkkBJCK9zKMwFaKGKChuhUITyZ+rj42d4inb3ki/9tszITg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207590;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BqYKp+gQR2QuObQv40vHy3rBkmsP7LRD2RijT/sRBzk=;
	b=BaKgKuAgqReizrWV4/CYa3deMye41TtUSf9HgfOpgFiYe7OjoyTvbuObdHNgaTNkTJVg
	 6Xn9SghOHfWncSo92r7c9JanTJQT5kNSKfZA0VCa/TZzC5i3ZOuQQxmFp1nDUNewRTt1V
	 l5Vi/4bvkX6514EuKBX20+59bUNeivpZ9KDeaNWljvEry9TIJhH/EcNAhfbKYxLlLLTm/
	 6AhOCT7UcInn5SAgXuwgIQ9l8G8nsXtYlAmUlcCWKz3OuIOrJHnyUHquJwj+8k918kt5v
	 9YWwYODkkhJ9fTBmX9Z0zMydboM3FILN2PSR5RhDDsCuNfjC2wKfgZpJSF9k4dbw+6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=D47IsfH6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hdMNnqNI;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971A606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 06:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4971A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=D47IsfH6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hdMNnqNI
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF6867A0141
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 01:59:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 01:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794207589; x=1794293989; bh=BqYKp+gQR2
	QuObQv40vHy3rBkmsP7LRD2RijT/sRBzk=; b=D47IsfH6PsVZJ86e30a7F99A82
	jPe5eacnMgv1kxuVZcT4/c8x8Pd93iVI4WLzfJbBudKw8AuesVmkzGukpuzXfRlL
	7uElL9jH964lqXZYje+yS5Yhhf+IlsoZdMEEzIRfDtGTW9P8b5X8kHslqlz8quu5
	ryp/xVcxXWya8PcngfnWRLc3Y1G2cQnymQ+1ZoG+SOlTMxzOchPEy/c/lGc5tdKE
	8wuqUP17S5A0uADw5eKN/2YeHCPyAeWTEMklmKfm1a2Vvrr0mDDPK1NFIaQdi7Fa
	la2ZEi2B++TMfbTAg6MZ15FAGMSYzYnX3BFZbqQQe+nauqQGZ4EDiFVUoavg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794207589; x=1794293989; bh=BqYKp+gQR2QuObQv40vHy3rBkmsP7LRD2Ri
	jT/sRBzk=; b=hdMNnqNI/m+4JjVXnWNb+rFHXBOFY/+H1utRuW1ZxRBLQzU1Lu7
	oQ6y2CKVZydYbqwTBx+KrfH1VWIDbhb5Tu3SUj573O330UaktxCdhjCAq+Y0wYHN
	Q96dER38Lw9FiQpbGp1MirvQ+yFqBRlc3LeBoYJJHcmF6VXVMKy5ntczL/4LbVm/
	0Nh3p8v3gC2y8wucGiHW03KyEpZ5MwWtL5zUAVg4WB4s82y1YE5sFkm9Z3Ac5Mul
	uffHGH8+RN7m6JZOH8Sa5AKpDQBHCOV8l4JVLPAx3SQiOfIUmt3pWclSZwug2Nhg
	OGiuUptaFeZpy0BKcLSVSWuFnblfntlqPDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794207589; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:r7LGyZA8QeaBlJF769Q3YKHQyosAhkxnivt8q7OEFZurxuz
	S6/b/1dAFa2Wpd9wMJwMbcomfsXpO/YCMlDw/QWqEUZMmplAVf9PJZbi0BemlJZl
	J4fh9jNioDA7/I/dU+Szk/4vaDnwbbiIhMdIK7Y0m5X2+CMCWFdcHrdfJG7Yp/cn
	S7e8k0yFrhQZXAMeciy/tP93ubxBpGPk8A3qDHKQAIDXOUopDLj6I7Vne6h7h8yP
	PPxiqtEygRO5Mt0GZ2e2CiasTrtp7uqxMGD29tCS2q4qoqaE8dFIP5AirZ7uVhE3
	jjbp4cNGHkelC3jdmc9hElGeQiqxVoH31/SC/pA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uvxAOLi6E2x64bmgrtPZcA6Yc7GJoZiBsVgeQBMeyjk=:TLr7pTduZrfoomdqxYARHARsqnepaTgECNuf5oW/6So=;
X-ME-Sender: <xms:ZW_xak48b2IRPBwm3EercOfB1Ar4QxA9SYv6kwqC-a8mUuP9_AzkIQ>
    <xme:ZW_xagfPXIM9Jgzd4_MSNOjX0CRV3N941MlSPVdXaGff0o1U5pyu_Y2Y9c5xYc3kZ
    1ondtmwktj7-9dvEL4zAan16Zq_RGWG3QSgibcsJ7u2s8lVHXTdFaQ>
X-ME-Received: <xmr:ZW_xagB-GBaioB1-QZN3QpduyQDLjmpvAoPPPjtFFgEQ3B6teEvxcT_5jDjM4XbM_zpJA2A>
X-ME-Proxy-Cause: dmFkZTGS7h8cHAEouDd6dX/rNwTemc/IsYJfO3KtcysGNUvlswf5VCoeP7o0pIokynRWgv
    OMAPjlz7Nqp4Ntrgruw2RTyUHJsAXivV9p7cxSsBKNm5KJrZQ6OuGJ4eHFUaWcngzsEOjm
    8IKTWhzYyus0Qx0Dbo5Nx4/mJUr2MqJm2aUMuTjt9hoDzqGRFMALPCOKCQB5540oC3CI9Q
    UqX694j4yJtE954vKZVBEu+qvWK/Xk1qKJ2/HpUi6q6AJVZ7RAUzU0pUTZdJ2f4QjN3woD
    F1GZ1T4QNqc7LNk0lQbVTlN0RzTKAv3rycAXH3Y7jmbui/MOgvjV9F0pzm2bAS5XMM70ko
    MoOFOMYTxgJmkiGWI1QJOBmEoRwlzV1I06quTxzWH0HHRm4dB7tSY+ohJR2Rlg2TBSvURF
    AuDGEpsV30p9ssUrU8nI/r3QSQSQMapImEiDDtPe1hhLdf244xfeGz4/DvX6Y9CZMoK0gl
    VlCeb93HvYHAlRLHtKa1B8q8kBwBhS03314bFunyRlQzC10qoqh13ak7SeeW+nCmSh1MaK
    eQWmgKvzdEyfUbLO4PqT1lnz6nH3+EuDOpZqexeoUvOhrrtFmZTg151fKVsp4eW6wzCZKb
    M6sml6QmAWMrtCBbWp9d+yOoGHbPWzWLeQHylPWjkGfOAE54TSmqRGB+6lmg
X-ME-Proxy: <xmx:ZW_xar_b4j5LR8xF2rwSIyX0XCP1VwiDAOSpNKJVcJGNnUIKmlk9YQ>
    <xmx:ZW_xajJ4rxxIMAKkXhHAYEaWLFmM4i5_iHXuDkQ5bsKxElMPfKZ3yw>
    <xmx:ZW_xasgsto76oRyhMQPGr33heKvJIiOSQBwLSjNbhPMywB0pSQWObw>
    <xmx:ZW_xar6nWUMF5k-SeTU9u2bqrXn2Ez3rtWmeuB1IhExTCw3ro_5k1A>
    <xmx:ZW_xapRe_K2H8Ru_wvlnCfcNnS6wrApybWIdrz3or87jDc3tkuqnodgc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 01:59:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07868e23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 06:59:47 +0000 (UTC)
Date: Mon, 9 Nov 2026 07:59:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 1/2] t: add "test-tool genbytes" to avoid slow tr(1)
 on macOS
Message-ID: <avFvYD5K4SKlveiI@pks.im>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <pull.2301.v2.git.1794165304.gitgitgadget@gmail.com>
 <54139a3a97127732e11fc5abbc9a3687542669f6.1794165304.git.gitgitgadget@gmail.com>
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
In-Reply-To: <54139a3a97127732e11fc5abbc9a3687542669f6.1794165304.git.gitgitgadget@gmail.com>

On Sun, Nov 08, 2026 at 07:15:03PM +0000, Kristofer Karlsson via GitGitGadget wrote:
[snip]
> This makes t4205 much faster on macOS in CI.  The Linux jobs, shown
> for comparison, only save the few seconds that GNU tr(1) took, which
> is within the usual noise:
> 
>   job                before    after   change
>   osx-gcc            821.1s   243.3s   -70.4%
>   osx-reftable       911.0s   194.0s   -78.7%
>   linux-asan-ubsan   226.7s   222.1s    -2.0%
>   linux-leaks        320.2s   298.8s    -6.7%

Nice improvement.

> diff --git a/t/helper/test-genbytes.c b/t/helper/test-genbytes.c
> new file mode 100644
> index 0000000000..b760326b24
> --- /dev/null
> +++ b/t/helper/test-genbytes.c
> @@ -0,0 +1,61 @@

Okay. The diff is unfortunately quite useless as we do the file rename
plus all the changes in a single step. It might've been helpful to split
this up into:

  1. A rename of the file.

  2. A refactoring of `cmd_genzeros()` to use the write buffer.

  3. A change to introduce `cmd_genbytes()`.

But maybe I'm also overdoing this.

> +#define DISABLE_SIGN_COMPARE_WARNINGS
> +
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +#include "hex-ll.h"
> +
> +/*
> + * Write "count" copies of "byte" to stdout, or an endless stream of them if
> + * "count" is negative.
> + */
> +static int generate_bytes(char byte, intmax_t count)
> +{
> +	char buf[256 * 1024];
> +	ssize_t n;
> +
> +	memset(buf, byte, sizeof(buf));
> +
> +	/* Writing out individual bytes is slow... */
> +	while (count < 0)
> +		if (xwrite(1, buf, ARRAY_SIZE(buf)) < 0)
> +			die_errno("write error");
> +
> +	while (count > 0) {
> +		n = xwrite(1, buf,
> +			   count < ARRAY_SIZE(buf)
> +			   ? count : ARRAY_SIZE(buf));
> +
> +		if (n < 0)
> +			die_errno("write error");
> +
> +		count -= n;
> +	}

Okay. These two loops are a bit ugly if you ask me, but they are carried
over from preexisting code. So this is good enough.

> +	return 0;
> +}
> +
> +static intmax_t parse_count(int argc, const char **argv, int pos)
> +{
> +	return pos < argc ? strtoimax(argv[pos], NULL, 0) : -1;
> +}

We can use `git_parse_signed()` instead.

> diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
> index 0b27d75fe3..b2032a799d 100755
> --- a/t/t0613-reftable-write-options.sh
> +++ b/t/t0613-reftable-write-options.sh
> @@ -146,7 +146,7 @@ test_expect_success 'small block size fails with large reflog message' '
>  	(
>  		cd repo &&
>  		test_commit A &&
> -		test-tool genzeros 500 | tr "\000" "a" >logmsg &&
> +		test-tool genbytes 61 500 >logmsg &&
>  		cat >expect <<-EOF &&
>  		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
>  		EOF

I wonder about the regression in readability though. Maybe that's just
me, but I don't happen to know all ASCII values by heart, so if I were
to read this I would now wonder what's so special about 61. And the next
thing to wonder about is whether this is supposed to encode "=" (decimal
61) or "a" (hexadecimal 61), and without reading the code of genbytes I
would not be able to tell.

So can we maybe make the underpinning logic a bit more intelligent, e.g.
by accepting "\NNN" or "\xNN" syntax instead of two hex characters? That
might also make it more extensible going forward if the next developer
wants to make genbytes take and repeat strings of arbitrary length
as-is.

Patrick
