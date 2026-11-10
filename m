Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339080;
	b=GIIFPnIMvWHkUIfXxZlntiB8kFa00cs/MrQOAr1OXMICBG/LvGTnme9xTayPCwNX8WIO
	 NNzSQddnNnvLI4M4ckLMEFLFDZvW1EVdNKmCSD82woItPDsOpzr8fq6/d2VhJD9bi+9fN
	 pN5j3EfnJRMnZviqrFKtWZHAcGyD5YbztDsDB652RBkN89dGj3sbpHTJHgxrcG6cfPCmk
	 ykjTkTSBhzz2aTKHcjAja4uEZKcqeMOjdSp09SW8Yx4iR9VD99SKnRryzhgG6dRxGWqPo
	 G/eUM7vX1T4VlpvHh9aqQMyWx4/DUgJAnSwdiYi756+UGG48lN8iO4wg23x/YncAnFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339080;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=73CWF1JcajFI2adAokRErRjxAFdVfv+DlBgDtn8A5Vs=;
	b=vW6NtpH2ffbs033fxDkXFH4/ymJpqITAN4VqOS95r1oPBgYLTnlHnMXsna7IijLI0Iai
	 qGASjb7S5CtXsY5o8zJoYYxmBqUJIsECY7SAEnF4GNqNWfXQTfCjAr6LiRUuruuWN4zcm
	 Z2V9Hb1ns9+CLSNLNYBcGi2NeAGIORgRAua+eOwGY5sB0RsEctvW3v69w9YEyhkEYgT3b
	 4lcDDQN6yOPD7vExBGtxqsZA4QSrrUpf63tyZ22P/6DgeIordHORlN2SXr+HHdKh8ERN8
	 z5wzDumvX4L8Im1vk5CczgYfsFflStWq2fhSUExEcgkbJDfnpXWSro6DB22y7xaGU7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=B8aeqRB3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ygRN28iq;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B77606A33A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B77606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=B8aeqRB3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ygRN28iq
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id F3ACF1D00251
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:31:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 10 Nov 2026 14:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794339078; x=1794425478; bh=73CWF1Jcaj
	FI2adAokRErRjxAFdVfv+DlBgDtn8A5Vs=; b=B8aeqRB3Sm6V84DqNCtxD0B0tm
	Wy8MKc6XBqNBM3elFQxdMNnnVtLUjiQb7Qn+tf5gSTh/V9LiTwIqv7+T9mZ/8Ah5
	57oCGsA1QTYXl2JWHK41WsNbHxaF1U3KiFHyZ8jnq23tg+hMGybbs7TdpF2zs7eG
	4zFxTHfiXKFcMd9DKkF4ESg4BF7prz5iFXQ3qPXgRZ0iMkz7SRUKnthfmSKltI80
	HHHY58OylcYjFdMTaT4KopHUADZEKv1AaQKvkZNPtpVwIlzaksdhTmu0tyO/RvNm
	YV7wWSDAQ87nVf0hXRm+lPfFrpOrsXK+E0+DoxXBI9mpr/jmVRz0v0upaJHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794339078; x=1794425478; bh=73CWF1JcajFI2adAokRErRjxAFdVfv+DlBg
	Dtn8A5Vs=; b=ygRN28iqKf09kI+R4F8AStjZBL/YwATN9JFLy6t+NxFABZKK478
	pUSnhwgiToADBhP45SJz8YAWTIFs0MAv7t0hPpwqRdyAxCWT/oAsCHUibWOZzDLQ
	V9cHD6GCTnYB3+s0Rv0II3mNxVePH3EFvITys/+hPZVIfUmoT1jOsiTjzRHz46o0
	TbTZOW8cKtfNn5umPCFeYtpM/qDPsugWm3rUQKAzJ6sydoRlsKYIVWhYH7GqDsvI
	pr6Mvoys/rXJkzdKq0i4xxHALOl6FWJdDnDBWmd6I5z27j0Hm3kenbRB6x1lm7dA
	rKhWaHiJmWvV8lxn6qXQyrcKv9O2xsYiLMw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794339078; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PEda+pO4NbUk1aVF0guD33XbXs+yfrmTD84tY4ZK3m38lv3
	NG13Pytcm7ikqi34tBVX9z+PJNBpOLtt1kpXaAucIylJCbnyBZro+iZKVSP8vcQn
	7YAo4mHeKVPEJ/wym+FXIx/iatB7x/zJ6f2s1yxUfvbEMcqJELky6YWoUQx6AJUY
	7eZwk2AhlDFUhvAFvPohST6JddwT/3n1Esx3a7OBeVI/uUa88wj2/Et28dhuWmdm
	XxVNlFrmNLXGUnLvjXh0M/9sdYoKwPiD/33lnn+yuHgltt93bM2vI4eaco/7c/Ga
	X7h2ST4Z9TQf4V4lw8f/GbdsD/Wi7rhKTJE6MQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0bIDK6NpeRTCL4OrPs+UHaPJJqi+WAYGZiLvzYG5Jfw=:Ec6R1fZEHuPACVIS6wWLbVGUKrA+IdswpCweYlPyfEE=;
X-ME-Sender: <xms:BnHzap768p8tFccWw_Q8P-rpfbyX3dUqfV1BIR6Tce2SbjPq73mnFQ>
    <xme:BnHzapKtFHTl0xaKq1_W4TZH6UBFSYZzf-tRQcNowxKKOyaFmFa9EHPWT5Caftv2u
    ut3TLw-AqU5Z3ZtMWPRMfI51PyPbbujFVabXuKfRm_Vunht1wnpsHc>
X-ME-Received: <xmr:BnHzaivvmopmFgqLDBIunaLeKL_57pE43Yxeutybm1oeHbZZ6VVU-MZeE_qsXhAiy7CzFkrcGTuju89GFz97UKOK4ucFSi0EKlBh>
X-ME-Proxy-Cause: dmFkZTGbcvHl5S1II7mMDlTcXCeLaCV8sytW3kOY/DlPi+P2VfQzWwdtOMm40g+rFPqOKk
    19OfLvNcFv8DFco0IdmMre4jpeMXLwoj6mnhQn4685hd5XkITPXKShIJD1v1TZRwFMRQTw
    69Y074vF4zKQQlKtaDTkiV9OqZu7maX55HB3WSInFE7EXfJobmSwq0ZjMUC3ffcxIiIibp
    LxrrmAsMH700rAfqTyOM1jlCqfw/uTKARrmsf7bDr8BwHlm/+dgb9949Y3q1KO7R2Wx72N
    lwfyVqYU6SFlprLrMhbduh0GfeoV/Vow+5W6ZxXD/jbYsqV3EGxVwVGv9S8oZvnkTY68XB
    7+Tnpb/QfJ0t6PImEoQHH9Rjo4YW1g6In76uXxiMy9/ML4MapfJzVnO0dJr0XVPVxxB34m
    CnvQz/tzDTBs7wsjIZVsvjcjfKNC90OlA2NHEizQSO0p4KEl4BIEL/D19NXukCucvMpUDG
    YmMu7TXJd93HCWi+Tv2E6YwCKGSSVYHlwTyxEDXTGmOvrNqjnP27vRu7R4JIydud9H/2jV
    zKtRDIVtFARx2Z73cTwZ22M7+PaLTXMt2w0uSvj8cAcgISytfX4JvjnLdyuCaykzbQS/jk
    5a+SHOPqX41Fx3JOFkjI16eHKIT2YxNaN4y4eH9u7a30UVlU1xijmhKDPQMg
X-ME-Proxy: <xmx:BnHzaoLlK4tSdnGYCQENJA3hSKacF5rrcS_QPsG8u6eW9Bov6_bdNQ>
    <xmx:BnHzar9YcEnbXZNKZlfKIwi9j7NZGoYn6_3bA_htZG8pvIoHIZQnzA>
    <xmx:BnHzahzD8vhH9UKAij55hucWuPW9dgGluj-7Jh2-I6UGq9PLlXyrSQ>
    <xmx:BnHzao6WUrTBkauxA7eD-Hk9WH5rbvnI3JZoJG5KIz2Avldi-pWInQ>
    <xmx:BnHzaqv1lthDx0qcSFqSWFlntxJxpUbZCQ7-Q4147UsD2ry-syI1aXEv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:31:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes Sixt
 <j6t@kdbg.org>,  Kristofer Karlsson <krka@spotify.com>,  Collin Funk
 <collin.funk1@gmail.com>
Subject: Re: [PATCH v3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
In-Reply-To: <pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Tue, 10 Nov 2026
	18:26:08 +0000")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 11:31:16 -0800
Message-ID: <xmqqo6bwqy9n.fsf@gitster.g>
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


>      * test-genzeros.c is no longer renamed, and "genbytes" lives next to
>        "genzeros" in the same file. Since "genzeros" stays, the current file
>        name is still valid and not worth churning.

Yes, it is a great realization that the file will have both genbytes
and genzeros in it in the end, and there is no strong reason why it
needs to be renamed.

> diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
> index b895436a32..e8d83d5012 100644
> --- a/t/helper/test-genzeros.c
> +++ b/t/helper/test-genzeros.c
> @@ -2,30 +2,28 @@
>  
>  #include "test-tool.h"
>  #include "git-compat-util.h"
> +#include "parse.h"
>  
> +/*
> + * Write "count" copies of "byte" to stdout, or an endless stream of them if
> + * "count" is negative.
> + */
> +static int generate_bytes(unsigned char byte, intmax_t count)
>  {
> +	static char buf[256 * 1024];
>  	ssize_t n;
>  
> +	memset(buf, byte, sizeof(buf));
>  
> +	/* Writing out individual bytes is slow... */
>  	while (count < 0)
> +		if (xwrite(1, buf, ARRAY_SIZE(buf)) < 0)
>  			die_errno("write error");

A curious infinite loop but that is OK.

>  	while (count > 0) {
> +		n = xwrite(1, buf,
> +			   count < ARRAY_SIZE(buf)
> +			   ? count : ARRAY_SIZE(buf));
>  
>  		if (n < 0)
>  			die_errno("write error");
> @@ -35,3 +33,29 @@ int cmd__genzeros(int argc, const char **argv)
>  
>  	return 0;
>  }

> +int cmd__genbytes(int argc, const char **argv)
> +{
> +	intmax_t count = -1;
> +
> +	if (argc < 2 || argc > 3 || strlen(argv[1]) != 1 ||
> +	    (argc == 3 && !git_parse_signed(argv[2], &count, INTMAX_MAX))) {
> +		fprintf(stderr, "usage: %s <char> [<count>]\n", argv[0]);
> +		return 1;
> +	}
> +
> +	return generate_bytes(argv[1][0], count);
> +}
> +
> +int cmd__genzeros(int argc, const char **argv)
> +{
> +	intmax_t count = -1;
> +
> +	if (argc > 2 ||
> +	    (argc == 2 && !git_parse_signed(argv[1], &count, INTMAX_MAX))) {
> +		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
> +		return 1;
> +	}
> +
> +	return generate_bytes('\0', count);
> +}

The callers are so straight-forward.

> diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh

All conversions of these consumers are so trivially correct.

> diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
> index 27cc49bbd1..d56edebda7 100755
> --- a/t/t9850-shell.sh
> +++ b/t/t9850-shell.sh
> @@ -30,7 +30,7 @@ test_expect_success 'shell allows interactive command' '
>  '
>  
>  test_expect_success 'shell complains of overlong commands' '
> -	test-tool genzeros | tr "\000" "a" |
> +	test-tool genbytes a |
>  	test_must_fail git shell 2>err &&
>  	test_grep "too long" err
>  '

OK, so that's how an infinitely long sequence of characters is used.

Looking good.  Let's mark the topic as ready for 'next'.
