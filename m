Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970493;
	b=u+ZYkTk7sukmCwmtGnU/t4SmbQUy9F7gF0MPEONIiHd/YW5MgmszQDoYYVQ0C0DT2Gxt
	 xR/wmrOP8qqmcTlfigJsjpnNTR9crpeyp6OGP0kiTyFnlXWUON1Wv/9hlUiJEH3ASK9Px
	 2alAgOgByOqsbIPtdxdNvex1g91PAI9kJhsHIJTmjtFucVbQUWNt5Jdx2U6+5NW/8YUcU
	 Y+0FXV2Wpaoi0lmYXh6pdZhafq4cg1ChtkCSv3anqawR1Ct6e3H1g6kjgbaQnd811XGgM
	 UNhAJgUop3sfg/NyodB6UwS5exsvMnPvKuyfPC03zvtBlVzIvRhWyXmcobXF6sG5Llg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970493;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eK57uIFaVPLOTemr4SPtfYOVOjmbpxEKCuNtPrlbxpg=;
	b=O3/4fO7x/E8Mentk3kb/Wc/BtlQ1RQurtV9F465baghdPQFNuW9eMmqELF7WOq/edkKp
	 nFkO86yrfOAUUapBLI7sV5omG6YO2ijfBrqOY4wD+jMBvwCRS0X2hgx1AEuzgXoPHi8Kw
	 pIcpj5OmL16IpFyrnyL7lyihuOZufBaStX5tkS72eWEOM3E/7ipIasFt3u6av/o0Jwspl
	 +w1oj5AncCUNNT/jsT0o0VQN+c4mqZvSNQw7v/Lm8cXGIFHDQ6m1HVxYx2q9fiftMdKjN
	 9mjwAcPYxQhG5ETurLxyJd37g4BWljlhWRnShlcOLXW0NzJ16XLojii4+ireAaKLctQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aOJg8yRM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hpzzWdg4;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89D606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E89D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aOJg8yRM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hpzzWdg4
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 47C721D00100
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 08:08:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 08:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793970491; x=1794056891; bh=eK57uIFaVP
	LOTemr4SPtfYOVOjmbpxEKCuNtPrlbxpg=; b=aOJg8yRM+AAWaEx6hv3GDG+T/0
	jgvLVvC51OWbXtoK6KNVKEf9kV2wq8ckfolKA2l/SCTy3ctSy9gZhGxBS3uz7BAm
	GqEKZsST8roDimHuT0QGol2VPCNVThFdlxah5JQaCrrSd+EPAe9Bp6rwqgKiwl9O
	zP9ezid2vVDWbO+GgTlyfGitA7MwpSOMsllDUFLHqmukH3+b7Ul+b2zCBb+owzof
	H0nf53/59PLhFYCVFNGKTq8GJ5t6l6WZIGRYRTyC7ZPnOx1+IFmX+uFN11XXz/q9
	2gieE9nDtOFAYu1emp02WBzxjvFoeCgjlMa/8CNkD2j5puusHx/NXXtOxE9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793970491; x=1794056891; bh=eK57uIFaVPLOTemr4SPtfYOVOjmbpxEKCuN
	tPrlbxpg=; b=hpzzWdg4bw65uyteanKjVbKJS/H7ykxx2Q+LF5NRbqnE8DYdouA
	H6VTW3txS0yMkJ3UD+8hH/jlRiQ3a59Mn8u6Cktahwd071sZMukWIdJ5fP0i3MWe
	r3J5pYS2r2xDVmN1kAYgO5HAXGgGixVOgQ+xMm/I5cb1wIn/y2qiL+J7j5Qn2bEC
	IE6ua+Ad2+Qhx+A3ZC6v9TEYhahCs6TFRLVTU/XDLMkJeyGx5hHiWB31LJDcofdp
	NfT9lUnfUYITXfnXHGfW3E5TIyDFXS0qhey+tMrIpOdLlO4SpEr30B7MUwQbLYHF
	ATWSIbL6OAiKEjEIfISBgxCCJqb8kjuG9kQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793970491; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Oc4W0hTwtTvxcnx8vL7n8r2wG5gX3921ncRXfQ+sWG+PtV2
	uSqueTBpOR30eA3LW5sR8Ghk39+ka156NQ3Di8lcrLUue6laFqEvaN+ETxRSpHiE
	KPZGPiAxlltTekUn7bLmUk10Rh22ZFGj6s6aHu3P3qbHVUYY0Ijj5Qg0feRbsFMf
	J0R+KyFVXyWWrWkdit/p8OkdPIadZKIWxMjFB78NSTYfXL2z2f1XbgpylSJ7JLZU
	TGoHGW2+x4IXUjjkoVC3YmvcgO3i62akoiAYsyQ1SvyuteTcnay2JBdtl6wZhZ0a
	bxpBOKdIi/8IsXVvfYBWwN82tIDw0Mx0AcorBgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vkAeLpVIwPHJknRq9VolOdAHZnhRy5qvrJFX67FLU4c=:a89M32XRzYk8SyxeSqX1F0sx2OhXwwrYxoC5tX1/2yo=;
X-ME-Sender: <xms:O9Htan07Pze8x_y6ODQBPLiULtCVrYgx7NZqzuOiw5IfheeOrZNVHA>
    <xme:O9HtakUoE_VsSj8_CG9uzL177-SMfZrYkQCcF3yG9jSiOawB9zXzKPhCCVgFTupft
    QfaDQhiJQfkHCtRxBg23GXU-7M25EvStDPhOmQiMgV0RnabH-ea9TU>
X-ME-Received: <xmr:O9HtahNnQHzdtEd-kW54UawCMb09iQ3clYZmJRBImn2loI27QRdosUZ6ZuM15yyEwTEjXVYJt2EiD87itZ3L3Ihyu9ztyzcl3ekD>
X-ME-Proxy-Cause: dmFkZTGMtrHy08g9jUVPFMQ8cHpcZKKD6eB+tqBrkrV6PneCSkDkQaBCXozw6WWzr5Q4vW
    xHhyErLP6d3n5Seue86yi1hxPkPhU0pfaRyboutoyBB11SSOa8gwc/0ZdQg+z8/WlNxdXj
    iL7VzP+CpRHb8MBYjX8Z0jRTAP0WVJa7ha7lXGnnAFMJPRp0KrFJVkMdHBuJz76IjfY1dy
    aIxneVPZNBh2epgz6isTu8S8RAGGYnNgfvUAqXW4W3MPfn8EIP2QAQZ6EDuJj1R4jOm4sy
    +B+we1mBZ8PmnRRU0uxVeMtArjoeJyPxrs710wLWgXSGo69nKky7JRui6y2iVK2WsRcmK7
    qenahVwaED752k75knpb47URh49E9FVVAn7XcB0Xlp8Z/G8r3z1fPg6a0ffbV267wqDdpT
    hNW2tX2XQJ/bXnMt/SEXHr2uz0CYf7xD43T06RB78YDAtCVLVpDVWwQkQ4ZE5Wngkg1OpQ
    xoydgpcWZIy+45FHmX8oJc/mrKXb7fBDgv82RfFCa0IO+3uD/2eCPj5uTo8UD8GNRW34t7
    Yjjc0BZW/wR/rCngVmw5U7v5NysMQkmb+PcAsOBI197ps7jAEdB/O7PV/yvm0BpmYKxCb5
    2PLCT9kiRWYaL2a4hsy+BFfKBejjlK+aLJ0YUpQcmTY+clXtg8pxMt89ZkRw
X-ME-Proxy: <xmx:O9Htav3HbzrTwOOTRul6UxEyNvUVFaA60JXgsqW23s7kNfmzC5META>
    <xmx:O9HtatSPTOJIzpJDwElbD0i18CBmojpmOEPcIfnrpmSvLOpSQx1AKg>
    <xmx:O9Htaikgc1D3JSgBDAu6Ek18adjVpJisXUa0PTu5VNYsge29w-hgCw>
    <xmx:O9HtauPABqxPaQIIUzK5PouZjH1HibkqLA2s_j74lHTD2F2LJZNJGg>
    <xmx:O9HtatPwu2ypkbpMl8Ee0n3yM0LrS3cXDoy7G2puhVJvhOrux-D_knG9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 08:08:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Delilah Ashley
 Wu <delilahwu@microsoft.com>,  Ben Knoble <ben.knoble@gmail.com>,  Nils
 Fahldieck <nils@fahldieck.de>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] t1300: test list with missing global config
In-Reply-To: <20261009-fix-config-list-global-home-and-xdg-v3-1-f936b9c8a0cc@microsoft.com>
	(Delilah Ashley Wu's message of "Fri, 09 Oct 2026 19:51:45 +1100")
References: <20261009-fix-config-list-global-home-and-xdg-v3-0-f936b9c8a0cc@microsoft.com>
	<20261009-fix-config-list-global-home-and-xdg-v3-1-f936b9c8a0cc@microsoft.com>
Date: Fri, 06 Nov 2026 05:08:09 -0800
Message-ID: <xmqqeccym7k6.fsf@gitster.g>
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

Delilah Ashley Wu <delilahwu@linux.microsoft.com> writes:

> From: Delilah Ashley Wu <delilahwu@microsoft.com>
>
> Record behaviour in two new tests: when no global configuration file
> exists, `git config list` succeeds whereas `git config list --global`
> fails. Only check the exit code, as we're not interested in the exact
> error message.
>
> This prevents regressions in the next patch, "config: read global scope
> via config_sequence", which modifies `do_git_config_sequence()` to
> optionally return a failure if no global configuration files were
> successfully read (i.e. when the `--global` flag is specified).
>
> Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
> ---
>  t/t1300-config.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

OK.

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e3f8064889..df8c14da0d 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2425,6 +2425,18 @@ test_expect_success '--show-scope with --default' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'list with nonexistent global config gracefully exits' '
> +	rm -f "$HOME"/.gitconfig "$HOME"/.config/git/config &&
> +	git config ${mode_prefix}list &&
> +	git config ${mode_prefix}list --show-scope
> +'
> +
> +test_expect_success 'list --global with nonexistent global config fails' '
> +	rm -f "$HOME"/.gitconfig "$HOME"/.config/git/config &&
> +	test_must_fail git config ${mode_prefix}list --global &&
> +	test_must_fail git config ${mode_prefix}list --global --show-scope
> +'

Do we know that XDG stuff is always ~/.config/git/config?  Other
tests that deal with XDG config files like t0007 seem to make sure
XDG_CONFIG_HOME is at a place known to the tests by setting and
exporting XDG_CONFIG_HOME; perhaps it does not matter?

>  test_expect_success 'override global and system config' '
>  	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
>  	cat >"$HOME"/.gitconfig <<-EOF &&
