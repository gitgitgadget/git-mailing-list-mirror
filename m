Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627661;
	b=WjE07iA78rd0g/piGH5WMMaV6oHmQQTATtVemrq29DZzrNtfWqL+LE2s5o35PPdWQ4Iv
	 Oa+kvOuumHAT3Zs7VD3AvjqlvN3IeX3eDHCOLyh15SANx8+LoHn2InSkQLL40VOJOeVsb
	 6Yh9RWiIG33gFocnhQTq5HlUJxjDDDSe0yPUPKmzI0jbdMlE4dNVF9kLc7jo/Euf7odgS
	 j/1yA28/A3ot+2tvJfUJngESUt6shYRwmq2IJXGvzxW5Eg+3Hujqyrj7iGlMK0PEjMr35
	 o8TOy4YcVXFj6Rrx3M4Kpgeto1iDmZCyC8fptfePqH2m8SPdi4YWIUF6x+U+q0nL/Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627661;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=i1uD+G/uGMbmUsNH3sq0XxxvbPqVjDfPSiutl3eewCM=;
	b=NPkAy8U/aDe0yWciPM6b5pGyexBadVFcw2uxEd3g2aeUZ5vusZdB4yTxBjwDsw+4vNyJ
	 JyB0FdFNxE2pAJid4G43JVNtAf7O5YKfcXI927xNqYUiN7z3C06IgN+fSO1jfpVZNxVk4
	 jLI/Wgovkqu3gi5QyJZM4MMIJ3OZiI8ypdPFeEudPOsvzx8KkIJ/WY3snpDVD54oco3mZ
	 2HC1VCx4Z9RRWzf7IK5Puc2KQOkVNL43sBbYjA90cgmFyLEX3ktZQ2FNuMRjzFGLK1eHY
	 RGbEZB2bRPt2m9w7tjsJGmaFZpUhhjhKsgNxp2Af4n9sEMnovehDyM+sdBQRAD/kiEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="SAQ/tQ/p";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D61p73X3;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5B606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A5B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SAQ/tQ/p;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D61p73X3
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33B4A1400369
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:27:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 25 Nov 2026 12:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795627660; x=1795714060; bh=i1uD+G/uGM
	bmUsNH3sq0XxxvbPqVjDfPSiutl3eewCM=; b=SAQ/tQ/p39j58ZyQ1E+ibjuiuA
	6Fx9k/fQQe8N5VyRQ6Us16hPYLriT+PDaVd93hDLCMES7a4XJwyaQSI2Wc3/1L7n
	ywPSWWnuLdcs1jSH8zNlT10XPT4yPE0vRYTIXFlO+dn7+ClbG0h4IMYRsN6xA84r
	nB85x2OiXBvBVMw6w39qSO3XJS3Z89dcrKP0QiUtsRElwdtiEFBzUBnTFZ77bvG9
	3wD1yvYvH3fnfT5SC2CkPX8NatkdkBr4ri8Pxic5g+woUNvEKDKT1q1gx7ZJPzSM
	e6ljSQNFg1xQhLdNcCq0Wjhu7Js75vLjjwKR8Rk13b5eSugbAySAY8NwYsWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795627660; x=1795714060; bh=i1uD+G/uGMbmUsNH3sq0XxxvbPqVjDfPSiu
	tl3eewCM=; b=D61p73X3UuIHTmBRW1nc93fc6shNoyVLdGzSGrx9Su8aiH9nC8e
	BCeWQ6k7r0WFcKcsQifvrUQSfePodtppXA0yTczoYAESPyxXbFLgQOy5h/cXWS7q
	GOB1yDTg0PKAZC6XTZtq+i553vMXPwx/rcCAoA+Sm1ju2hdZZ5BITwLQTQVvC8yv
	Mv+8wXc4930UuyX3aSQI4Iopn1xAgy7EqHrcxPRRwKoYz0q9Kd1RZNFK5q+xKIAM
	qoixqnMRy487UaAqaFO1/j8tBtmxsretYBrVSa5a6sH7y01sM44SAxeEKAm9YObp
	QGkqkjNSIxGAFnFvNS0fvhrc+PujabKJIJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795627660; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X1WPHFiRFT1Snx9eYigSxMebwzHy52smjA+E+ZY9duFLyfO
	qfT+MbKis5wYryLG6VNAW6OpOdBetYo7anzRjYoelC/1jht0Bd3ZfRQGRmI+WyIt
	InrbrBWAE/daMR17wrrmRfQMfZQQKyXgHqndyfnO1pFAQUTXHmgDhqnKktJ5OJy3
	5CjdhxeCWzhedSJ8PD2FI9A9lMekBZgW14aqR/47GiJR+1or8/7eLUG+gYrF2bwA
	5skReAS4Q6SP1/YSnJpJMvYdVEcftP871D0sBmPWD6+LO/H5PxkflJ7KKLFHHhOK
	PGZroCcA9BOLbNcovmmfxa1bNtzTawnBZTKKjXw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2j9WujlCLOdwnyiLe/8O2FPJsmZSLOekFgiS3x/IlYQ=:fVsM0v3y++WfDgB0C6SzAE3w8Tf6Dr2F4CQ2NTZMGCk=;
X-ME-Sender: <xms:ixoHa7pUGQ83ccWpOvJTavBBqzm7pU1WL06HOnKuMqYLx5rlZXMG5g>
    <xme:ixoHa6nk7KQV-a-tn7K5ORluzgKu9NL5zD_Dxzp_-bVQ-h2pOMfwMVFDEUI4sCvgO
    M-zHXmKSvxREGhrfsabdNAQv6pVM3son0VAT2VtyzzJ75VApSsJng>
X-ME-Received: <xmr:ixoHa8dhmenIZe462xO7u7QRNaf_uCIB38t66c3sW5Lv2ln4V1WUYV1qPLaAkhvKd8-NXi37B_6Q5bdCAtjM1p-xy2WAFN3Un3cRLrc>
X-ME-Proxy-Cause: dmFkZTGNMNQFsNNQXss6u5LJaR2TBDUraPWGsW4PsxicJNHMBJxPMw+jvY0MvjlvxeeGyZ
    B7M0tztfiyfBll70GpYEYsEhJ/nQC8ZeUhJoSUCUyGpstx+bznW+rmDTHJYcDzJSEkWD9I
    eGKL1yMsFJUdE4UpPNfP0msfQUbgdGVI6/GQ/+dQM28rDvwQsfQyQ4hFiFrRaSWZAJvLKe
    oTtCR0NZ2538zKrf2KvRca9lx7IpTmz3HuLyRphyYIAMyyw1HEbNOvJmd7+LWxwq+8//4X
    cipi9YCyW6B3zUeHCyRWc/bMm4hYX0IaXAXpPx8aOemvv/bzcSt5Ie7Jee58eh+wZu6QMu
    mG0nkkX2PnDotoTn2/Q2cqGuYnQjN4jJZBA7PKtWfXT/56dWwyOJnmG5Ig7K+eY7A3G/Ai
    DJO/VnnXFJ3nO4tvJO5ipuITu7cKgPry9Q1XRjjdrFl/k79UDC3TCg92sCT+1MHehruvi8
    JG5BiAeUrNjmG8lJXxStP3Uo6yG9uxILG2skut2qspAeX8g09VehNxt0pmgO/lPh2v9djL
    CCEuHWoXzhCgbBy93MgyrQ1ajqRKxjej4R8NjYJp1urWwmuRu4PVzLnKOyFpxTGeYcfO3M
    8bwadiwFR7KXaESwsmpAaJI6ncqHSg9pS5Y1XfXvQSHyN+wnszmq3tdPQmSg
X-ME-Proxy: <xmx:ixoHa-ohPQvOl1AqAaZdz_d74Q83Scc5ZLkiF8XjiAVCFr4cjTH01Q>
    <xmx:ixoHa-OoPq4yOimVpNfJ4lA7h7QbSy0nXN_h8uTOW9ZdzNg_-1NOKQ>
    <xmx:ixoHa5jBeX-zTKKH5rGY0IQXAv1YOGrr6i9FBtXGxPl-ZnhJb3jGDw>
    <xmx:ixoHa5s2jGYofQAveFvAk9RwkyNol2UVaOTQ-htXcYUThaoBTouLIw>
    <xmx:jBoHa2v1xcbXUONGntmtFlW0xqaiBWPOXky-BTxSV9vhpMW8_UIM--Vm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 12:27:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  siddharthasthana31@gmail.com,
  phillip.wood@dunelm.org.uk,  jackrawlings2011@gmail.com,
  christian.couder@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v4 1/2] apply: reject an empty "diff --git"
 header
In-Reply-To: <20261125011002.589285-2-tangajoris@gmail.com> (Tanga Joris's
	message of "Wed, 25 Nov 2026 04:10:01 +0300")
References: <20261117004348.806694-1-tangajoris@gmail.com>
	<20261125011002.589285-1-tangajoris@gmail.com>
	<20261125011002.589285-2-tangajoris@gmail.com>
Date: Wed, 25 Nov 2026 09:27:38 -0800
Message-ID: <xmqqo6bc7red.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

> When 206de27efa was written, Git printed the "diff --git" line before
> running diff, so a path with nothing really changed could end up
> with just that line. ec1fcc16af (Show original and resulting blob
> object info in diff output, 2005-10-07) added the "index" line, and a
> pure rename or mode change has its own header lines. So today's Git
> does not write an empty "diff --git" header, and one in a patch means
> the patch is corrupt. Report it as an error, instead of skipping it.

This explains nicely why we no longer need to ignore empty 'diff --git'
headers specifically and rather we should actively diagnose them as
errors.

> diff --git a/apply.c b/apply.c
> index 677c01dc02..b28c1401f4 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1645,6 +1645,7 @@ static int find_header(struct apply_state *state,
>  		 * or mode change, so we handle that specially
>  		 */
>  		if (!memcmp("diff --git ", line, 11)) {
> +			int linenr = state->linenr;
>  			int git_hdr_len = parse_git_diff_header(&state->root,
>  								state->patch_input_file,
>  								&state->linenr,
> @@ -1652,8 +1653,11 @@ static int find_header(struct apply_state *state,
>  								size, patch);
>  			if (git_hdr_len < 0)
>  				return -128;
> -			if (git_hdr_len <= len)
> -				continue;
> +			if (git_hdr_len <= len) {
> +				error(_("corrupt patch: empty \"diff --git\" header at %s:%d"),
> +				      state->patch_input_file, linenr);
> +				return -128;
> +			}
>  			*hdrsize = git_hdr_len;
>  			return offset;
>  		}

Saving linenr before calling parse_git_diff_header() makes sure the
diagnostic points at the "diff --git" line itself rather than the
unrecognized line that terminated header parsing.  In apply_patch(),
'.patch_input_file' is always initialized (to the filename or "<stdin>")
before parse_chunk() calls find_header(), and returning -128 from here
causes apply_patch() to clean up via free_patch() without leaking
'.def_name', '.old_name', or '.new_name'.

One small pre-existing edge case worth noting is that the earlier "if
(size < len + 6) break;" check in find_header() still runs before the
"diff --git " check, so a trailing bare "diff --git" line at EOF with
fewer than six bytes after it will still hit EOF without this error.

Not something this patch necessarily needs to fix #leftoverbits.

> diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
> index 3cab1038cf..73d3bc4e08 100755
> --- a/t/t4133-apply-filenames.sh
> +++ b/t/t4133-apply-filenames.sh
> @@ -60,4 +60,108 @@ test_expect_success 'apply diff with old filename missing from headers' '
>  	test_grep "lacks filename information" err
>  '
>  
> +reject_empty_git_header () {
> +	file=$1 &&
> +	line=$2 &&
> +	shift 2 &&
> +	test_must_fail git apply --check "$@" "$file" 2>err &&
> +	test_grep "corrupt patch: empty \"diff --git\" header at $file:$line" err
> +}
> +
> +test_expect_success 'reject a new file with a blank line after "diff --git"' '
> ...

The new helper and tests in t/t4133-apply-filenames.sh cover creation,
deletion (both forward and with -R), modification with mode lines, non-1
line numbers, and consecutive "diff --git" lines cleanly.

Looking good.
