Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686940;
	b=uuotd7obJ8A4+HbsMY67omMpq+DAt8zdfR6FV3sGVfWTk70QAqxzZNC/Dgc+Uo5a2Ee6
	 Euv4h1o08BujVvOM0UJ/lgrsFR7bO56WgiBMuKwM6WsTnWYX6pzi1aROcg1FfiAcsF+Uc
	 GhCwEKbH91qp4hsgYupLGGDBy2dxh1P1Q3si3MWcVV+SgHDg3Bp53WVHgkjVLdJ3Fktgs
	 2MjjRUvEMWlUKpHmVnKJY5G7qY5Zf/T6ll3criPi6H1tzq/rWalla9/uZGoYCE9Gkevak
	 JxoQRjX/FJZM7huGH/WxRcp2S8BNLJCd/sKtkYYzoXPIaRma1HHesA6ZoIrqruluYiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686940;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4U+Lx6Vh638OOxC4RkRxt2thO2c8d45424bGgI5IWIU=;
	b=ohZ63L9Y0/VMOOy0QxF8gdflqzSPzbdkbtdQz9BWo56rhqNWI4sq1IJdfZ0lS4HcS072
	 CtDSTQzdstBF8Xs5FfuJ4YnzOHRyLw8mR2QztMYnMzyGLKa7boxtjUj54OZiG5cUyQWNM
	 u2NKpeLIEzt0B+CoOkhUUBExz1+jq0S+9Qf1ONU+4+0ooDfzOCQW4w+eTa/EYkvElARbj
	 oU1P02HEVuKzdOB9iC9MgTZo1YHiTxdeQvMXI7hKlSHIeked+t3MoiDliUfB9RFnPOzsp
	 cO39kB16zJm1z0a0F6UKBVUCIjcBiBHcJA+F8d6XLiy+p4ZMFCRehMAARvc8U5ixnkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hlEycznG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YmiOUTJZ;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC1606A327
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 20:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ABC1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hlEycznG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YmiOUTJZ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 32F4D1D000EC
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 15:08:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 14 Nov 2026 15:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794686938; x=1794773338; bh=4U+Lx6Vh63
	8OOxC4RkRxt2thO2c8d45424bGgI5IWIU=; b=hlEycznGb7JLk/4grdKg8fUT3+
	jBVKu0QLV6kP+KZzi5D9TLyeGCe5dBNAROuDh9wGG9uwjVQEwqo07WC3XpckU3YF
	JMFBo6AE0RY73NWlReW3SRkjsMiTatSTIxQdp5oujSRgGe0jlAZw3EWvIw/hf/QQ
	YzmFzGk+OsWxE3a/9loSaSg1ejl6EK/Y7x5/bUBIkNaa1JhZRJwOyJ/wfkYAyn2M
	7UFtlVBi8bc2js2IJr2IhQIdH7wNiolo4I58Q3kicoYPeNmB+Ha9gTp3+DEfipPN
	ypAGiCi6U2/XT3R8E7w9pMHXt2iw544k/0lwUDSkiLkQbj2dUFWEyKEKubGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794686938; x=1794773338; bh=4U+Lx6Vh638OOxC4RkRxt2thO2c8d45424b
	GgI5IWIU=; b=YmiOUTJZrvTyFjqNVQJ+7UK3MF+J1I4FzBDzrL5iYeAJesSMSa0
	zTuNYZcMnnWb0L8kW4W98jwIp/i4vuKOSjJIsful2Izejv6VEiF09xzjAZpIF57O
	Ny/EWsZ1Cia79iR3hzxSYQJUh1AosKc6+D8gvGLQ6TbE7Qv+yKtFpWHkDP7ipNp3
	5n5xvzd55lLcQUWh+9pDw195PKJaSxmxJ7TgK+GON1q5GTJXNPd3L28PohmU0b/O
	2yy4C7OSLa1EiMr9yrkHKQG8aljfWq00ucQFeYSzJ+i1ZknVAQ08GTD2w6U1nU01
	cdl0F7Gtbq5cFWCydzWMAAJoXgx7tLYznUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794686938; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O0NoGFj2xzu3lgxkLSfvZsIQY8WM/NTjk9GedO7asWiWonL
	ZGW7KRmctwCgV+RO6/vI877ByaKynHp36jpdFYpvnA0KlJB5jfyh1SK9E2zeITgq
	LGC1k7WnGggK8HTwOOABG6ErTp2l7xeE0fAQl3xZYFBHrBez5liBeAWjbtwILTLr
	U46+9C1Lj8FY2oKj+tXY7GsRfGTG2AJ6wBeQMWo2P9u3jRxSHTQ2wQfRaxtU6Pv6
	ynyUOpfWAoSXkAzCp653PkN+ZoH8bJY15M8SpndbNz6nzCZt41Y2EcD/BHs3gQxa
	AhTuRtb7KUeto4llepLDZDkk0ieI5pVIuBGfJWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:k+pRhLwXOz+YDbmNHCybSmHTh8AtSzV8pJcajA+tY3Q=:wIqOS1FRZ2UDRaNgc6NnGe+fit3bUb1Bq7Zos+WPxgc=;
X-ME-Sender: <xms:2r_4aiiQz_EWwt0_bPFGeXNke-7k5WJwWS7mQF3SzXlZ5KPLecol4A>
    <xme:2r_4amuSNf36jLlU2Z_HnC3jFc0ig4J42dUxDjMb_qpTptajsI5pwIbscnwqHq8AD
    j0XHboax8euWkdntc1sXhVRvCol6wYy81bg8eixepIBBQEq3X_kH8I>
X-ME-Received: <xmr:2r_4aj7Uwv4sqnzdDAka7sqLcQq9DFP5f0GXgXKsScvgbYiqlfLxgvBSyoALuh_hZ4SklkyJWsHmPR1pQRA9_XOMcfk0xlR1b-HW>
X-ME-Proxy-Cause: dmFkZTFPncen2W2eYecYqQTKvfAP5ybua+NIegCOBCNacrJKCBW8NdgCleoS+NgCaosgv7
    y5SNC744snVFXwV6pfbIJoV/0wqQ66TGnQ19n/lszJzIPRgkbF7zAV8+4hITlwF7uwBRNm
    r7zjyF2H0iuCULAEdMMCLhl89YvjQKG8+PgXlRYcjG5Y2w1p6VcDPSgE97EZb22J94xa7b
    tAVMD6hDXknIczfQOHzFdCbdP0VnzN3UvHHEQSSvwld5yl3FDc2DkSw08c9rrkQWhTdcFn
    EqixLDxOKvBDJV3i4UfK7ekaC5r3Hg+JpzHJIsGvkYavSKEwy14C4qI3upuk7Cab59rUBc
    6NOmUsMtqUueRXVrbIDCzICszowgt75F+QIbX7le9/uZ3581tVwMwjk5LKqbD0Tvr/RPTM
    ZnHiVwD8Dx5LDFX6nGdtOEA1hHjupE1JMCEIYVFvyWQ7/WZSX4IGA2kNRTYkw9QqHJtDFE
    XzTwkbAgsvFke/T86N/Aj6z7XBXAldAPX2WopBdq7LvdyxEhPbicaiKXqKnYNKYlOSDeGI
    4yZx2bl4SZQGOS8WcShkNWTu/Cb5RQctPRDl3C+4MY7snXdKr3+N4RNljn14woSk06eiX5
    fY2pHNLN9PEroy7YjwrMEqKTqOvpPLnOP6td9KwetNRq8vT4r7paw7CgDyMQ
X-ME-Proxy: <xmx:2r_4aiOCudQBo0MxeaBC3qdl5sX18eFX3RHIqHiBNRGLBi90OlpQ2A>
    <xmx:2r_4ahuqofZdefCVlGgqJOMlmds2O5nXezDIHPJ3CmhfRvXviGsPsQ>
    <xmx:2r_4albOvQuMreeABsif8g2NvL5HPiEUCkJu2Ei9eSJ8ckGtpSLTIQ>
    <xmx:2r_4ajyVgmAdj5in-_j8pSTnzaqUwjmjSK6PQ10t7AyZCHTp0Jx4rw>
    <xmx:2r_4aj3ewOhUXKwftflfwDQuJWE3KgC2hkb0_AyAYPafabHdwjgJjUQZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 15:08:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Martin Fick <mfick@nvidia.com>,  Christian Couder
 <christian.couder@gmail.com>,  Adithya Chakilam <achakilam@nvidia.com>
Subject: Re: [PATCH 1/2] repack: add --filter-to-loose to write filtered-out
 objects as loose objects
In-Reply-To: <4488a1534ebe7def72055ab5530d4f03177fbe52.1794607911.git.gitgitgadget@gmail.com>
	(Adithya Chakilam via GitGitGadget's message of "Fri, 13 Nov 2026
	22:11:50 +0000")
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
	<4488a1534ebe7def72055ab5530d4f03177fbe52.1794607911.git.gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 12:08:57 -0800
Message-ID: <xmqqmrrbnpk6.fsf@gitster.g>
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

"Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adithya Chakilam <achakilam@nvidia.com>
>
> Some external object stores (like key-value) manage and retrieve git
> objects individually. Although repack's --filter-to option can separate
> objects from the main object store, it writes them into packs. Using
> those objects individually then requires an additional unpacking step.
>
> Add --filter-to-loose=<dir> to write filtered-out objects directly as
> loose objects into <dir>, treating it as an object directory. Stream
> the filtered pack into unpack-objects instead of writing an intermediate
> pack file to disk.
>
> The filtered pack is built with --stdin-packs, so this initially handles
> only objects already stored in packs. Loose objects in the source
> repository are left in place.

I haven't decided whether this new feature makes sense or not, so I
won't comment on that aspect.  Take the following review comments
with that in mind (i.e., pretend as if I said "if we assume doing
this makes sense, then..." before every sentence).

> +--filter-to-loose=<dir>::
> +	Like `--filter-to`, but treat `<dir>` as an object directory
> +	and write the filtered out objects there as loose objects
> +	instead of as a pack. Cannot be combined with `--filter-to`
> +	or `--max-pack-size`. Objects already present in `<dir>` are
> +	not rewritten. All objects are written before any existing
> +	pack is removed.

We talk about "already present in ...", so presumably we require the
directory to exist before we run.  Have a test that ensures that
passing a non-existing directory will make the command error out
before doing any real work.

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 21835453c6..140a992f1b 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -41,7 +41,7 @@ static const char *const git_repack_usage[] = {
>  	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
>  	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
>  	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]\n"
> -	   "[--filter=<filter-spec>] [--drop-filtered [--dry-run]]"),
> +	   "[--filter=<filter-spec> [--filter-to-loose=<dir>]] [--drop-filtered [--dry-run]]"),

The above documentation and help text consistently tell us that the
value passed is a directory (do we use the abbreviated <dir> so
commonly?  If not, it would make sense to spell it out, i.e.,
<directory>, for clarity).

> +		OPT_STRING(0, "filter-to-loose", &filter_to_loose, N_("dir"),
> +			   N_("object directory to write filtered out objects into as loose objects")),

Here, too.  

This should use OPT_FILENAME so that a "git repack" started from a
subdirectory with a relative path to the external loose object store
will find the directory at the correct place, I think.  Have a test
to validate the combination to see that such a repack that was given
a relative path to a directory find ...

	mkdir extra-loose-objects &&
	mkdir sub/dir &&
	(
		cd sub/dir &&
		git repack --filter-to-loose=../../extra-loose-objects ...
	)

the directory correct at the right place.

> diff --git a/repack-filtered.c b/repack-filtered.c
> index 869b9fc6e3..51c9dfeb13 100644
> --- a/repack-filtered.c
> +++ b/repack-filtered.c
> @@ -29,10 +50,18 @@ int write_filtered_pack(const struct write_pack_opts *opts,
>  		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
>  
>  	cmd.in = -1;
> +	if (opts->loose)
> +		cmd.out = unpack.in;
>  
>  	ret = start_command(&cmd);
> -	if (ret)
> +	if (ret) {
> +		if (opts->loose) {
> +			close(unpack.in);

Please double check that this is not closing the same thing twice.
IIRC, a failing start_command() would close all file descriptors
associated with cmd so you may have already closed unpack.in when
start_command() gave us a failure, which presumably closed cmd.out.

