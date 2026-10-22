Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668635;
	b=bcV4fTeQ2QDQtqygKkTGVgrz0Qk0cenRxhCog+AeLvrYeq8CBUDHQFVf46PDgjchxQ3k
	 Ei71mr50Ewwvb6bQNqcqOo0hIV5InrR5kL4kAkqu7rix8SQyZXoEmb2I8ZanftU9oTTYK
	 8EruypiRnCQYWysz9AbJfy0AR/KvEANjBdDK4qOz3rxok1K3+LmyEs807/LUk+r3giRgx
	 D6KsdTjyn6C0W/p26WHJHQXHxUjI0PYbmAziFPjnJ696aq8B3klEyi6wWF8ZOwqxo9xll
	 IL12n56Qn+iL3AHVYd83GS+T99KVzD6dZvlAYmmgitU+qh+wN23OCg4Ay7wy1l0D0Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668635;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=92POT2KJL1P4TBw8oon42eV9ZkdvRUoXbRR+EooPI4c=;
	b=Oe22ZR9E5kMefZR6E0wf/+B5Zbrvdp1KwLZKytrRtTAKP6ACA8zz7V9nx34C7HY96W0s
	 +eQ+XGbPsEYjdDr987FIwv8d+7HS2mMdSWCNtq3t5G95JTCuFDjllPPpdym9r4xDLsrzE
	 CHGVHPXQhFG8AwUKzHu1P0Iw3uJ3vODb4+KMQJ95FRzmkm0RJyWUcBmiNkjFXP0OYmoXL
	 uL2F49Yl+quyTTDk09x/Ru/dz/JerhSvkDGJkv9fJFQRfa0Mhq2LA3FFCZApFu4L+i9q0
	 3UBZETmq4TPE9Qn7N15njwKEGob5kHBIAczlCkCw+pqjmjZ4dpCu+TV8GzAeAz5SFJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=b0s8j5Zz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=inJnm2CH;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1B606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F1B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=b0s8j5Zz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=inJnm2CH
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6FAE21D0016C
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:30:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 22 Oct 2026 07:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792668633; x=1792755033; bh=92POT2KJL1
	P4TBw8oon42eV9ZkdvRUoXbRR+EooPI4c=; b=b0s8j5ZzCfi6qJYJh+4YgCJ+2O
	X1VUYFXymfK8ZGrYcSaLZWiEivk09cdc5+RkZrWJw8KnT+NKvP/Jh1awaB6a33O6
	vbizAC3mFQUni7K6lAq0nrjcdKPfN4A3t3y55dXHcsVoUFB75aoWWGs6YdvauDAX
	7VXCgzAysWFhaEPR67vJWYXBK6UtVAaheGfZAyVJNX1j2/51bOQ1G6YSshqmfHbE
	HQFh6QlLdLMwryrlsySn58MUlH+OGJ+JrN6AtVElPn7B0AClAhSgDeSqIW2MU9uf
	snvL7fXb99GA0qD6c0VjNTNZyrsHiy9doSPc8UcXwTKJR0Kg+uOfKDCiCPLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792668633; x=1792755033; bh=92POT2KJL1P4TBw8oon42eV9ZkdvRUoXbRR
	+EooPI4c=; b=inJnm2CHoP4TwVZ/sEFYQtkpzyZ4fKMYqhQGEdKNz2MaIz0Sv0c
	h8dnc9Uv4a6VNt4i6rH870L43NBss4qPIu1q8qvNSXfBlocQMdyCKEc9hCaR7Dz+
	VEYsSSVQdcRSLGYlW25q3sFRylHedatwV0p7WfpNV1jTcoQs9T9MUz4JXb27sD9L
	IFcws40fzNZMfM/sJP6se0VA9K0C9Pg6OPJIKafhuLnNrVPuh3N026Mb2UTNk2S9
	M2Tgi5i6Z51TzE3AbDm0NBsv2SnUT6698VJevh6LaxO/rGoN+W/2wG1G//OrBIj0
	zOFVHYrq1B4W7khvTE65tZ1W+UQXgufcpQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792668633; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BuKifZJIVgVUF6Bel5tiWYcJHk1pFBftD0EhpqVIngBJ2hu
	iB7nig5pmsS7XOlQyXrK+wvWxtYu1zyrtZrKvfHxU8VZ11APtq5AaeIztVPNJM7k
	/73nE1fh6fhelRbZVrrDiMmjFA3eLlBKc/cF5UdWm9smZtqAPugIuEVYVyW5dL6W
	x1lGauB1yFTIjOjR1nQuINKeC2vPPU4IIA+dq9T/kstQBVxmlxQsr1RxGqPL2Nvu
	5yMUWbc3/3NjFXUzDuorjUlRclYpsM+EGva6c6nKbZGgrl8+DQ+nC76giKP6XjF7
	jLlqQNcrg/BVACyRAb44eldDzIq4PTDOszNYNkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ryEZT4d9mAhAATeC0wyR4ItRzxy+1+1nDM2E/JlxK44=:ve2ie6OZAQwzuAqMCAb6kNBi93p8pCLyT9vbAepnMqs=;
X-ME-Sender: <xms:2fPZatTvB2ZItRYyTfKOafoNm8M6iJQl0Y7WNmz4ojCzM6AwgDvYoQ>
    <xme:2fPZaqfWunlEoQin2aY4gMogqswVEq2XZzmKX2lC9tk9_og39NKgxC1DgYz-fWS31
    OklXZSxQAaXTkhxBfOC58LVY0qPPDdw-rxB9pamRcoTZlQaDhj2qPw>
X-ME-Received: <xmr:2fPZasrJHq6EtN8TTj3GY9CsMdEaLmP-UqLQ6RVENHDlml7s-XAmOxep7fzwHzyPN7b1pg>
X-ME-Proxy-Cause: dmFkZTF7ZNMLAxTrm4715lgAP2AYnuHOnZV4kXOZVF/JmoC4k6rfakykEvw6KhPXarT3xl
    Kwh9NyU4GNsXYfZyfN/Hn4dj5oIF0EujdIaRzJ3+f0YXQ3Dc97haGFmIiBTTVbQ14ZzuN7
    n3MIovqbOH6jY36j5z+W4G3PEA4HL3+U+sOGcUJESZUp3jhLibit8dsvcjxo0JTMIW6bBw
    0ZOErzhB08cNl9IOo5EkKFYA7CaldFgQz820bvdNtiZVC6NmxVBrUJf+OPIa1/31WqLu7C
    H84bNEzX8rQCLlVn3d5BVgxCZHAI86Z/LjgHKuuEqA/Fu5brASQ5n4/oYb6Pdj2t0eFFll
    lYhz26VKjZ68KDr4dnomGPbx2K+9SOsF1VodjrCiQt2sJs85aiCpQbzKLkI6h7EhEJgQlK
    tX0RxY3nZFBMLYdqvC07N8bv+lV9qjnTMD07TmCXy1JwHkBLTmEHaDfRo6v3SAmnwSFO7L
    nyE8DNtkkiymnMwbeFfL/0Pv3s/fLfWMqvFXBdCNcKrC2LMcQT2sDBsj5i/pDPwHRJ7igY
    ClVtqrja30OR04vHm79tIGtFdCJaq3OA0FUcL8lslM3FbXYnmIjriYCTu6vuB3PzOtJ9nO
    K2g8mebbbrVUgWEH01DEDNXk1QdWIAfpfR5FbJXrOhTAqhVGmzDKivXeIuQw
X-ME-Proxy: <xmx:2fPZar_WjOKjLLrzVElK9-mi2ChBbE2bLCjwDomyHySMdWP_W2lLcQ>
    <xmx:2fPZaofYcP_It7exNXXHjnKjQCVHSHmOCzbdLgZcnULgDuSvDvxzAw>
    <xmx:2fPZalKaOWMUp2eJihuWpkXK0Fu7oRazY29keY0Q8eBTvs2BfBjXfw>
    <xmx:2fPZaojXzG0VzLLJA47H1qrIhtdzKLtCQkw2DrK84pVWCqjq9KANdw>
    <xmx:2fPZam3LpD3bmUYxFt9_OAadoE5RPUrw4V4jAqM4MC27P-SVQ2He8yIR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 07:30:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74a98527 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 11:30:31 +0000 (UTC)
Date: Thu, 22 Oct 2026 13:30:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Joy Gundu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	"Kristoffer Haugsbakk@imap.fastmail.com>" <kristofferhaugsbakk@fastmail.com>,
	"Christian Couder>" <christian.couder@gmail.com>,
	"Usman Akinyemi@imap.fastmail.com>" <usmanakinyemi202@gmail.com>,
	Joie Joie <soniqjjj@gmail.com>
Subject: Re: [PATCH v2 1/2] repo: zero-initialize configuration values
Message-ID: <atnz1HFcA8q8IuE_@pks.im>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
 <pull.2271.v2.git.1792662432.gitgitgadget@gmail.com>
 <df93a2a86cae7d342270c0ee67a1c0d41ada202e.1792662432.git.gitgitgadget@gmail.com>
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
In-Reply-To: <df93a2a86cae7d342270c0ee67a1c0d41ada202e.1792662432.git.gitgitgadget@gmail.com>

On Thu, Oct 22, 2026 at 09:47:11AM +0000, Joy Gundu via GitGitGadget wrote:
> From: Joy Gundu <soniqjjj@gmail.com>

Even though the patch speaks for itself, we typically still like to a
sentence or two in the commit message itself. E.g.:

    When initializing `struct repo_config_values` we manually zero out a
    lot of its members, which is tedious. Reduce the boilerplate by first
    zeroing out the whole structure so that we only have to set those
    members that have a non-zero default value.

> Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
> ---
>  environment.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/environment.c b/environment.c
> index c83cf44839..89af09aa40 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -752,34 +752,24 @@ int git_default_config(const char *var, const char *value,
>  
>  void repo_config_values_init(struct repo_config_values *cfg)
>  {
> +	memset(cfg, 0, sizeof(*cfg));
> +
>  	/* section "core" config values */
> -	cfg->attributes_file = NULL;
> -	cfg->excludes_file = NULL;
> -	cfg->editor_program = NULL;
> -	cfg->pager_program = NULL;
> -	cfg->askpass_program = NULL;
> -	cfg->apply_default_whitespace = NULL;
> -	cfg->apply_default_ignorewhitespace = NULL;
>  	cfg->push_default = PUSH_DEFAULT_UNSPECIFIED;
>  	cfg->autorebase = AUTOREBASE_NEVER;
>  	cfg->object_creation_mode = OBJECT_CREATION_MODE;
> -	cfg->apply_sparse_checkout = 0;
>  	cfg->trust_ctime = 1;
>  	cfg->check_stat = 1;
>  	cfg->zlib_compression_level = Z_BEST_SPEED;
>  	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
>  	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
> -	cfg->core_sparse_checkout_cone = 0;
>  	cfg->warn_on_object_refname_ambiguity = 1;
>  	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
>  	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
> -	cfg->ignore_case = 0;
>  	cfg->trust_executable_bit = 1;
>  	cfg->has_symlinks = platform_has_symlinks();
> -	cfg->use_nanosec = 0;
>  
>  	/* section "sparse" config values */
> -	cfg->sparse_expect_files_outside_of_patterns = 0;

We should probably drop this comment together with the code.

>  	/* section "branch" config values */
>  	cfg->branch_track = BRANCH_TRACK_REMOTE;

Other than that this looks good to me.

Patrick
