Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810183;
	b=fK1Bnkkn+4hHOSVRGLokUN4FZH9RE252cyaxC+yhYc516nErj1ni+hu6jzLr4LpBZ7zg
	 7kra8vpX/FG8K8WPu9cJZlpTASz8kfk8Hb32M8lXHCiV+K8nOPO+drbX5i1oxlNy6+87k
	 4rAbhFhWPSKMV6Hjmwkes2WTKMZeQG3YIXWcVBQolpTf/+5gN9b88NzwKzEDyUnXp1368
	 w67fJs4T6Gnb82hUQm9dsqbfAabfuM3ZoUQM0yzg8CaB7bK4N0F1bXYuQSyx3uQ31RcpV
	 3WYylG3RWKHjP6Uog4ULZSG7iJ5nW4LFvPi4EEFEh6cVIIpMoqYCwe9AnjsJRF8rPFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810183;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CShcPJQIz7GhZ6R3tH6/I51pxkxGXlgDhe+XUVikVXQ=;
	b=1pr2RBtQ99zawnhqbz4ymhaL4gzNM1yen6HP6j/lN1vNIS5F9S9AHhncjuuVWQD0zAAX
	 3JTqzdLuylV2pMHUSgESd8ya7qn47Zco9sczjWalHVCgA/qFHzTgi0xuNLGQJxIYLIL/d
	 XBMCSwiPcMrksnjUwsXzqB8dH6H+au0/95/BhYGQALgCo1d8kTP3UJGFFxpssUU/ri6fj
	 +DDMu5I+bt5Tu+6PxrhqWtMuNsMjCu+6WZE5NPyudq/jTcsODi/RdrR13ACp9GgTMe4qz
	 4ZinLSMYWBYSsy6q2yXYEp44AsiLDApvUJpSlfwXA+SHr3l2sP0eGceg9LengQ5TPww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hMMIaCXL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5Zh1LFG6;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F6606A329
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 06:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C27F6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hMMIaCXL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5Zh1LFG6
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC7DE7A014F
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 01:23:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Nov 2026 01:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794810181; x=1794896581; bh=CShcPJQIz7
	GhZ6R3tH6/I51pxkxGXlgDhe+XUVikVXQ=; b=hMMIaCXLNedfeeIMh6Y3RX8MnS
	H/xuYwcezgmD4N0WaXH1BIYLI0pTydru5aITF04YxF7DRfYoe9IBoUtbJfpyKX4y
	DMpQVMB+h6VVLG36r8mG2wogudoxIB3apiL9+LmAfUzgK68pnsOG3Bi8bkO3EPbk
	mbiPUIqsVMa+U5i4QO6IpZnwLNrRT1GcUjdJRSeX5kczxZtuuYioH9u6FNyjryJH
	fVT6809kWBD4NxrQ3csIby2IH2SuZGBdhmW3JIiJ84YFC+Ba/Q6xei4zQlmCGQpB
	GtBbBxd+GZewZnvcd92yIA+iGmRy7/Tcp4z1q3HckqKXYRkVCvWkodXlqQYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794810181; x=1794896581; bh=CShcPJQIz7GhZ6R3tH6/I51pxkxGXlgDhe+
	XUVikVXQ=; b=5Zh1LFG6k9ygkISXCn9RnHuFN4c2kajXNTTgd0GzlCjbBMSgQoF
	VGrXMhiq35qe1J2N0JNWsBL2xnzaZYqY41DrUsN10lj5Irq4eVUQEf1vZj12lYLb
	jkW3iiQnFMFDV+EdCKOIdsxeDAOxfCBytshDnCtR/5yIvy6RRike2iwoCfBRXFHG
	TGRnSwxxSYwAh6eEzle4GvT/DLrK3uNcqoHGQ0zOjBuOlKy2H4RK8KjZeMKqo4do
	Lfi8seEZ4SWh7PkAepFMvghfsEoMNt2cusAhxb/7jC41oUp0435SN33xlmI3dHY6
	J1JdgukdHcE+6fDsNT7eeLSuouV2MLl8w+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794810181; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mCMueyxLozV2/hlCmKUWErMl6tycMw5EdQaGXeaJIrHdnHR
	WpxXGn98sQLv3P8kyejIN1Iv/syAbJQR1JZ7ay7zhkWlrO38MD4jnQBQmepgMvhr
	4fOv7oQ+e/K8ENFomDUcR3fcJXKEYm0EqCI8ZzYLrCLilMd93sHPavQ0gZCKvA3R
	et33i96Ph1bvEEDUVHqHGs23Sa8Z59jrMZcMfuVsWPI/hLg4ZuHVrPfAPkdZBg6n
	BrJNAsBYTEtC5mp6N9KpUzhxATEtivoGBW0XoHVTBww6NxL6AuR4GkLAK1OY7uXn
	bpFLlys+QWY7RXW7vXdfalCygmN/L/Hws8uB9xw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VM568KRYXRGzCP2wI7Zp9W0YzUif6eOUERG6TzXLH+s=:uSblG23EUxXOZhaGw8rEYaFcCgXoMHXhHzkIuL7CY7o=;
X-ME-Sender: <xms:RaH6avzk7J-Tlv9J6HShcWQApvLyOcDAb5uFbdnsxApN8xH6RAWTSw>
    <xme:RaH6auSnFvEubih9pgR6CQn2db29qZg8fCTnB4Ui9ibiEEbCxa5sd7lUCr3qtH7gl
    szSPlddFBJHfRhzhCruI9BB5QUT1aZVB4OCqWWfXJ-BxC4GlR-3GLzO>
X-ME-Received: <xmr:RaH6auVhlu26FjIQEwq-gULE7gAj14-XLeQpjxkVtYh0kiJX_5RFFV7dTfVTHAK3NobhJWc>
X-ME-Proxy-Cause: dmFkZTFnVxmxXi+GUSsbEeDV+lV0mM7tcCEGsTIE9ibDq0mlQMhXdmggJItna/0tBisKw5
    pcrS4rNH10/XM5LzDcTp7cXx3Ft82uYxXWjk+LkIMWrZF75GAJCWJ7jc7tboHnI8M79TEL
    bQ8oD6REjWwVIco+RU6D+TSVzK12KYLk1NIJQkYOJrmIeoj3Nrqhewy9Io/Mrjm1h+/Bub
    av9X24XkRtfow90r4ixMvMbBMqlxi97xn1MkDAQ2FLnS+aLfSAZ8aVGMOgjDNOeLNwJeJN
    cF0bA2PY2xVGq60mGkMtrH2IhQ8Utw2NAgqiIw2uOtnpvkM4ZRYn5iREwekMlTz3Jo+1tK
    PAVSTH9IuGDWjCtTPmFPIFNlpolNZgRM9xyjM9pyqb06CUT/a+dOQfe/8vPwwfMV+Eq7TA
    1eVGRtm2/ZUyVoICjWDZD/RSsmbXdRDdXomoBJxgUW3NocA59opz90Ek46TkuCUen2Mz0c
    m/kXRJZJMhGjfU/PeA74dhgmdof/BAyU8qIOaxFaHnqt2DbFuRrDlrYzK+Nn20c3Dk3bhY
    nHa7WbUokTShB7SBvBhxeiKQue2Ztc1AJZcou53tqrjxM2vdEwJFdjB8lWWzdkEeEi1RH+
    PMW3LE0unaSfsGUVxgYJJOfjqZe1sgT6GtBrlZpxbSMyaarTN72aT56Rd+2g
X-ME-Proxy: <xmx:RaH6aoZ6N_N-GPIMy1f-F6vO3K6K65IHSbYjuXUctNEoLeT6KZFV0g>
    <xmx:RaH6as3EfDuxP0tfb2coB6a1BHEw1rt43OrMIlRMSzCBTCRS8C6n8g>
    <xmx:RaH6aihHgu6ubuSNyFmxYuCsd6yU1EE6jO_-cIl34iCoWy9dXo-2Bg>
    <xmx:RaH6aoZPMWqRX8_6WK_TvbAyq-QUJe6SuJQhyjd2mt2cfUx0j-dueQ>
    <xmx:RaH6ajmpDPuNA7JD9tOjNBgSw5ynhNQyiZxAhYXK2xDo1-vzTVFqIiG0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 01:23:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eec3e507 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 06:22:57 +0000 (UTC)
Date: Mon, 16 Nov 2026 07:22:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v2] setup: fix hash algorithm detection
Message-ID: <avqhPfANDZqeWGmo@pks.im>
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
 <20261113221753.3408862-1-sandals@crustytoothpaste.net>
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
In-Reply-To: <20261113221753.3408862-1-sandals@crustytoothpaste.net>

On Fri, Nov 13, 2026 at 10:17:53PM +0000, brian m. carlson wrote:
> diff --git a/setup.c b/setup.c
> index 61bcdafe82..14c6e1a67d 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2817,19 +2817,20 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  	 * Otherwise, if the user has specified one on the command line, use it.
>  	 */

This comment is now a bit stale, as it talks about re-initializing the
repository with an incompatible hash algorithm. But that only gets
detected further down now. Do we maybe want to update it to have the
same bulleted list of precedence that we also have for the ref and
object storage formats?

The code changes look as expected to me and resemble what we have for
the two storage formats.

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f271..d8244a2dec 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -516,6 +516,22 @@ test_expect_success 're-init from a linked worktree' '
>  	)
>  '
>  
> +test_expect_success 'git init uses default object format' '
> +	test_when_finished "rm -rf repo" &&
> +	(
> +		sane_unset GIT_DEFAULT_HASH &&
> +		git init repo &&
> +		if test_have_prereq WITH_BREAKING_CHANGES
> +		then
> +			echo sha256
> +		else
> +			echo sha1
> +		fi >expect &&

I think we can just use GIT_TEST_BUILTIN_HASH for this, which detects
the hash via `git verson --build-options`.

Thanks!

Patrick
