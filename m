Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887989;
	b=WRDro9viLn2PPDSLSXUe1jH5+7Y8QncwBLZ2UVF/BlRwbPyovQfaKL/rZBX9HuKmLPaP
	 Ju3Nrav/9HcquTeiPYRiDAOkG6BtbiHjYUEN26NdQ77crUgHgFAVWBnJcH2WUaYf0t5rc
	 LoBzOpCNmX8SM+0mrBy9xOxwho5dj4HFJESsJ/v8C/W1c9gdynsta3pACib/20+2xjwMQ
	 UVwwpxmLARdM028pMkTuuv8AFlX0KnjsxzwdZe4cWgaDS6S+ICqndviJrBWO5wrSKUnTB
	 D8XlJHMexbnwcwSbulBR4WfWwwIgbFMW+sDdfYLj+SK8sdJh3ruv+yAkjg087POdZmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887989;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PLOIxbbG8iIzmyqw1OObj/ubC6eFruXC7ivUdmG+KMU=;
	b=OdZsYQ1T5QghQ+5DHoNRH2iL5V860m7f/WBM+wJj8rK6aw8E2UL2d1lUzLhuifyu6l/7
	 WMMHjVeDVnqDbAT6TeepkU+trzyvhNsI2dMXDD89ir2hdLok4Ub9NZquVdVk+yzoLSap0
	 FsquSthA2ldBZ2rPROFQNy7MqgrgTBRNV38CnwUgTPBgSskOOQV6+TMQH03q0Lh/dhz1Z
	 kZhAgD3D/Ipnrixh1QGEL8zBDUbv4VbMm0QWQXlWiXpQeu/2GIV0cbNXYbDkZZeoapr96
	 Ru0Q7uznN/CyKRbyS+jsHn4IyNn7Hv0P+H1i6UiFYlfJ4eykNqSKmuBBAiSHEUpNCmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hrfwiOAm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1ysDJULE;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E25606A334
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E25606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hrfwiOAm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1ysDJULE
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EAB714000C1
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 09:13:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 09:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793887988; x=1793974388; bh=PLOIxbbG8i
	Izmyqw1OObj/ubC6eFruXC7ivUdmG+KMU=; b=hrfwiOAmz1gOgcncK6YyihrYRT
	fPU4CigfUO7q2WHxpf/wSHiCKtv7N2oVLjcrumP/7xOmpWunx0OGmIKQ3+tFmiyB
	AQV4m8PEugZCIEdpCJSrqBLXdItbygqbrr5cuITj96nOcr4mKQK+OJdCK4G5hc+5
	JYEdBcpkodvDafN/YeQIRYCrfY3EaoUQ6hnCXIBGhzKbDFcH5Un5hnsINUKdHknZ
	kQJgWvkNMTh5TWrhJwi58UqqQ3vbB/Ual+0opLaY7hG34TVaHsRkSsYv0DrfrPVt
	DNvi/qgYJ3maWIyHsbeQUS8iBi3N3LE6DOROsbZyCDasw2Kgg9Ty6lqqgHlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793887988; x=1793974388; bh=PLOIxbbG8iIzmyqw1OObj/ubC6eFruXC7iv
	UdmG+KMU=; b=1ysDJULEqTUwaR2KgfrgwdEskOR+CW1GpOfG9Kex6TdmOLx0N/h
	cHM8IFKpZvig1OhoL7ha5qKZ0y0WCjYB8tFvrqJU8+QH8+pcjQfRkq/TeqHwgAbM
	frcVVvUUjLKqQZgf+rppBG/cKbA9TrKEwJHjHmv8unUtE8LJJ6/zhtXsdB4DeRwL
	6nGzPRMPZho+IrJpoSj9mzI7WY++mzYBq7d6MbrcNwkn5RSQ85C5s/4DAqvf3cSD
	YNWrOLLb88H0Bs/50FW782JuedAL5/3C7W/Z2I2B4JIi7AjnKkNbSiHAa6VzrmDY
	HucOY/QVzdUwArHe6nPplpAacK2HwTB1tRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793887988; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:niYYfNXR4cCrrp3D0bd4U1/FLXAD6mzh2NtgDsHjVbADmaP
	sODzCm32muuEBYpK1snNI6Tn1BvkFUGpqa7jyBRma2jY22wo4krIlMu22YW5pEKO
	z49kRbqhQFxVXrWLLYmjgUhkQ4VPxqHG9NkLshYVQh/ywzRrDZdE1/N4PSc5JGni
	EJbAavUT5TMkqFuqA/FQShlQwEiD+nCmO8zPP1+Y8OfaeU0ND/DlWOyFKxFqhZD3
	Qw6N+UehbLsCNvHhytGGxC4PBisnvtvP7mKH3pfG8+jH2FUyQjqUyb9rMQWyk3wI
	CO23JZIThvqgCYC1oAZTfKmHHblwXpQrWGnMloQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Xgu2J9p855FhmeB6krCQyxe/INlrMI1qKgvp1HbEwnA=:WmBqszAVG+Os2Q7nSeuTNPktkxcvP1jBpvWcgYlPWaY=;
X-ME-Sender: <xms:847savOKcFbd8FfKqLdxxj_lEds4BuD73kovzf7OKglAYhwXFeYVeA>
    <xme:847sasN_k7s4h0iiZhFyn8-d-wyL8dnoRGtRBgwJcKFOQIGo1bffMPn31R5ssR-Vv
    QJsjQnbcVOOl8K6SLUN2zfYHIMTYWW6cyp9BCzJMfRCkn4Bvw-22RI>
X-ME-Received: <xmr:847sagh0ni8FMTuEuf8uNZjpkxO0if_hYrCJB8_yQLPW9BtILEY90w>
X-ME-Proxy-Cause: dmFkZTES/wWb4/l59t9nVPKEtZvBeBELwZkjbfctyVvjUQO2Sf3XSrVI2zTllxJXtjj6KF
    q9H6mpxoziwsijNOxbwUfmqRhicg1wC3h6AX6VzXj0LcmUDdSjOYi1SQb7BAOMvOPzKdSr
    NcK1YsM5r5kwo0oL7aC75mKSxDLJ8QWngmoITblRjYL0RDbTOAtAdFjU/cdMS5zsLzUidd
    ZFMl3tuYB0sjpadzkADYp/vyy6qhZtGHwhkV/O+zIpb8JGxI8Lf6aRKqyZ5PW4CVVffQxG
    qcXb++RvEcruL+MGmM9zDROJlfiM2lZKF/WjF+gjFG36yjQLpvAjoDFN9xSHPWC1FQLTXm
    zaD3OjdW64aea3Qp2Cq6RuHGU+wdW5jOQlCrP2/5GbV4A3Nv1HbmQyi2DP/iURiYO2ZmiR
    RIY6tpezQY3g9agc4nfMf5U0DTlXk1VpwB7wVJA99XHNMXq0gB17xO/8i1H+Hl5g73DtGj
    YtYlGWf/l5gQvWVepkeuWpGHlt5O0SKpOBU2gD9nPqvP5I4PUBHUzgB95XqPT+OWwyaM64
    9eYpxQpt1FkCbPmGv9cI7EukbRzSXcT3T8pZ9TMPPb8rqZtYhvEjNGiAdaeQ06qAQxtzPD
    gArLo8wbRt5w0fWbpIxoeYEdDrTKeWFEhUX2YYQpuGascghlBKFzOHIJFsGA
X-ME-Proxy: <xmx:847sapsFxhh9ZtvE0dXBm-OB7zEJgzObejul-B-AujD4te3YTo4orQ>
    <xmx:847samR58lFaJxjN3V_qvw3RuvujXEJvVylhSIvPmsROhv3Wb0Gguw>
    <xmx:847sal3nyq9OI3pvurfL1uo87Kbiv5yo1kXXpQ3xFuziF3P11Ex7-Q>
    <xmx:847sajts2Ihu4EW6rs_QVMFqYehhOqM-hyz9jJqiL_DE1B0BuVSmYA>
    <xmx:9I7sao_Jx9eXuOGV6IgBBLRY6Am3XOCfuNf-Kf73ZPvLDgnurlKmEHoc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 09:13:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ccf2f92f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 14:13:05 +0000 (UTC)
Date: Thu, 5 Nov 2026 15:13:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] ls-remote: add --show-object-format
Message-ID: <auyO7lmLKD2OSwnD@pks.im>
References: <20261105104541.790881-1-adrian.ratiu@collabora.com>
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
In-Reply-To: <20261105104541.790881-1-adrian.ratiu@collabora.com>

On Thu, Nov 05, 2026 at 12:45:41PM +0200, Adrian Ratiu wrote:
> While working on JJ sha256 remote support (it uses Git for networking),
> I noticed there is no way to get the object format of a repo without
> cloning it. [1]
> 
> Git clone learns the remote format during the protocol handshake, but
> it is not shown anywhere else. For example, when creating an empty repo
> and running "git fetch":
> 
> 1. If the remote has references, fetch can fail with a mismatch error
> and "git ls-remote" shows the format indirectly through the length
> of the object IDs. Not ideal, but the it can be figured out eventually.

s/the it/then it/

Also, this is a somewhat imperfect way to detect the hash algorithm as
it assumes that we don't ever add a third hash that has the same length
as either of the existing ones. So it works now, but it may not work in
the future anymore.

> 2. If the remote is empty, "git ls-remote" prints nothing and fetch
> succeeds, so the new local repo can silently get the wrong format,
> which only shows up later, on the first push.
> 
> To fill this gap, add a ls-remote --show-object-format option which
> prints the object format learned from the remote on a line of its own,
> before the references.

Seems sensible.

> diff --git a/Documentation/git-ls-remote.adoc b/Documentation/git-ls-remote.adoc
> index d71c4ab3e2..1abf7b60b7 100644
> --- a/Documentation/git-ls-remote.adoc
> +++ b/Documentation/git-ls-remote.adoc
> @@ -64,6 +65,13 @@ OPTIONS
>  	upload-pack only shows the symref HEAD, so it will be the only
>  	one shown by ls-remote.
>  
> +--show-object-format::
> +	Show the object format (hash algorithm, e.g. `sha1` or `sha256`) used
> +	by the remote repository before printing the references, on a line of
> +	its own. This also works for a remote repo without any refs, which is
> +	useful to find out which object format to use for a local repository,

A bit curious that you first say "repo" and then "repository". I'd just
drop "repo".

> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index fe77829557..6d961f9961 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -150,6 +154,8 @@ int cmd_ls_remote(int argc,
>  
>  	if (!dest && !quiet)
>  		fprintf(stderr, "From %s\n", remote->url.v[0]);
> +	if (show_object_format)
> +		printf("%s\n", transport_get_hash_algo(transport)->name);

Should we maybe make this a tiny bit more extensible by not printing the
object format without any kind of prefix? We could for example instead
print "object-format: %s", which would allow us to add more fields in
the future without the need to make parsers be order-dependent.

Also, one more question I had is whether we know that the hash algo will
always be populated here. I would assume so, as we have this logic a
couple lines further up:

	ref = transport_get_remote_refs(transport, &transport_options);
	if (ref) {
		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
		repo_set_hash_algo(the_repository, hash_algo);
	}

But in theory, this logic would also work alright if the hash was NULL.

> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 2e1d4f7586..7e82154fe4 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -332,6 +332,52 @@ test_expect_success 'indicate no refs in v0 standards-compliant empty remote' '
>  	test_expect_code 2 git ls-remote --exit-code --upload-pack=./cat-input .
>  '
>  
> +# Run "ls-remote --show-object-format" with the given arguments over
> +# protocol v0 and v2, and compare its output with "expect".
> +test_show_object_format () {
> +	for version in 0 2
> +	do
> +		git -c protocol.version=$version \
> +			ls-remote --show-object-format "$@" >actual &&
> +		test_cmp expect actual || return 1

It's a bit weird that we expect the caller to already have written
`expect`. A better interface would be to have them call the expected
object format as another parameter.

> +	done
> +}
> +
> +test_expect_success 'ls-remote --show-object-format with empty sha1 remote' '
> +	git init --bare --object-format=sha1 empty-sha1.git &&
> +	echo sha1 >expect &&
> +	test_show_object_format empty-sha1.git
> +'
> +
> +test_expect_success 'ls-remote --show-object-format with empty sha256 remote' '
> +	git init --bare --object-format=sha256 empty-sha256.git &&
> +	echo sha256 >expect &&
> +	test_show_object_format empty-sha256.git
> +'

We could easily deduplicate these tests by looping around `for hash in
sha1 sha256`.

Thanks!

Patrick
