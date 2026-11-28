Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795837142;
	b=wqIa9DFMFOfOIPCMhlKblP8XEKRWCBXznFrjtIBh2bDe6eYVyuomVcok0rQJGbNCNgZn
	 60mzdUfbYc/xGejx51+ra3VCxDaWlrlW2dYALU1KTGRRYiDKlKggXK69b/OuP8oHnq5Vy
	 hVnmpIUKSgGeDOFQu6OCEraN6Fs+o9LxzJRkOwePSZl+nHJC+qvrzJcnnoIQZld7AyELo
	 aFC+nW1i9aKYqt5hBCIGM1su5TX6Fw0dGLDCwfERkL2oaddJvoWXiPiaIt9wK/u9MZFN3
	 xywrwdZrzgfbioVbxpDDtelqzMB7INdyXfSVRoY7qqmkeR4E0Hbc17mHTcG86ZOq48Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795837142;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZBMmbtYkrk7ne4Bu1VuqnaszOCkri655hTpkbKHALuE=;
	b=hULcp/WIfHG/AWOIjzkDX2eJIAO6tloUtqryS7z7kAQciZDINfbdBfu1hsaxJG+nkLMV
	 Yd3h28dPE6KRZuhZjIx9BwQM7A34kS6jvXp0jO5UklEW5I7N3UpL2+tUYlbKmle7iPxIO
	 a8kKyd2uIkeEUZd5ZBeBJBMMxVOuSRBPMnPY2R3iivp+v1m2qn1BSW0lCtbMXIKztiBJX
	 eweTy+2kSxhKR4flG7Ae/N5ZkHjxds644bsuIiUdCQimr2LnRPFaa2aSMLPSS+QdjNcg/
	 cWeNuO3FfY7wxeB4C51wEldeu5g9zeMOXgWi52F3GaCa8LiwLUB64yp1WTXlRI5U/aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="O/AuK7Up";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lyZq5W3y;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC6606A31F
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 03:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66AC6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=O/AuK7Up;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lyZq5W3y
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C678D7A0496
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:39:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Nov 2026 22:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795837141;
	 x=1795923541; bh=ZBMmbtYkrk7ne4Bu1VuqnaszOCkri655hTpkbKHALuE=; b=
	O/AuK7UpqFy+b17uD5Y0BeoFAe+YK+7TBr4dcK6f7vc4xf075Z7jW4+6ExCRCzRa
	Wc6NWafayxMu68E7SjU9n9g3eSlSCdVyf7CvWDD+R7hgtfJNkmtaPxJfxN7a09TH
	R6Z4BEVN9toJS+LQX2KNJ4w85Dzba9eKhwElOSRWXsEcXRoTjaE3ztfiKLTNQUe1
	A4NGwoCFX47lKlkRMDh8MWugxjuHkG7tY/evDAl520ZTKVGEKfCMeI2fOpjcpwFV
	3SLSimeApR/d8LLEbS+tDjCK8GTsx0dw1VcBmaboygax16w5nmGjBJ4a7rPKlSds
	53gYEas3e4FrSRXj42JqDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795837141; x=
	1795923541; bh=ZBMmbtYkrk7ne4Bu1VuqnaszOCkri655hTpkbKHALuE=; b=l
	yZq5W3yleNp1krQLkNDkAHUYzAdMu+vN2MtL6lJUda0xl3E5lNt9v3QyuLuBrvOD
	GIo7zc/N+nvpK1WaWiIRmB23XQ9uOTU6qAstvXH8chGM7d3Enmuygl+XO+p/r/7e
	PFLNn/0FEz79xpOxNx2EsbfoKH8VKmr7H25iRyWdDJNBFr3NVoltfwQpv1BAED3s
	uR4ZXohw9lDDgkfKRGTz8hGLsjH6uCt2TOGo3qE3YslQTva2puSBGeMLHGfixuhr
	wKkwNMrLQuofgqhvOaidBSH0mzKHFTpxTwySGr4ZhDTDRgxYFgwFnfbJ4/fbedn6
	X0ezCWNg2GpwFhILirDWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795837141; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cc42z0YW8kyNgbbMMZmujpeNpYqmd8lDMTX7B++r6rT7lvC
	TIa43ww5b+7WaS/Zf02NyDqC4OQ12FXVZNUJW2jyybdsi5nrgvSD7PvaShLy6J5Q
	5yP0jxAikVmR5cfrJXzz/8egTDW/u0ZxDyojPnFVMSwV0gw3KikL5Z5UKTF1CY15
	HVx1k/O2WZ30E2hXH016wRnuVpo7sOmnTKbKZlSpCw0kAI54/QzB1aKom7khk+Hm
	2VJCYxE4K8xJCHv8AlTFPLLxKWGlaazLD9CdruVq8kdFlzoxjvDO8+Siwn3o+fOP
	Yk2KxoTQuiIXqGU/MGMDpUv6qUzlzSIIhV4Akew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:C9UUD2qQiNKe3Gu2phfdoHr6+7dcw1ibVFw6rbXEBik=:YVYmM9WyQ3/C9ZteawoOBiZgpJpjouqSIYpWfsGwNws=;
X-ME-Sender: <xms:1UwKa2fK8jZXNS8IV8lp7m3N-E7ne-Qs7Z5oXXxcLWRm8Obz44qlXw>
    <xme:1UwKa3N4W9MUls8v4q4qI23InkzNISncyQhxFDB6R7Jzm-sL68UUMe8y87V79cVZx
    c6YmaSGU6Ye-8cgpqPIYZQA7ICit-TNWVWbu5JgwT8_pebZjEyfnw>
X-ME-Received: <xmr:1UwKa8ioF15jDD3d4yArRzD1oNkWGUdAdlnpQEqQN8KzQxL-Ej-O6n21IMuYNvxsbOMI4_gI5a9WmcLz9z7W3q7G_9sD0i3NmtU7lOU>
X-ME-Proxy-Cause: dmFkZTEy6cDsg/2tiKdkEqfcfvtu4P9ZNmRKbbesOJBKqTFGPy0IDeKyHM8s7M2e4shxwR
    TAFDq2R8SyyzXNj/VoQbmsJqG8L2ne5Uepf5wGg3euUBAmAZhc2XZWHJ3B7YS+Xd3NwV2C
    ztj5GxKMi9MStHaBrbnbuhu5/5gywHoqMqJdQxEX2d9h3nL/+TZS/Z8limX13JFWthocUz
    RkQ9i4QvUGNhT4CN1WRDtlXgEmgbpIWVe0P86H0F+tlYNg+iHBvX//hUlCcxE4tt/WRryh
    gCO7rCcW0zSnRlsdSCDS0mecSbHG0FcqZf8lpCMkcHGAjdw1nnmUukKSNlz2rIWYRWhzEJ
    tmMe54ANwf84KHhjjNAeUrjzHB9jZUabW3s6EtFdgqdaz8q3+dF08/KVbfnj/l8H92px2N
    iWNZAdAmydPUussBteE04emKA4JqSuDy4d5CdsqiMcUAAWfAt8o2aFEIG7IV6i1swbOYTa
    viaHP/giB5IZQ4oWgFEiY0RkJJPFjyAoK1+4o4A/JwnTGxU0/Md5gxS+lbSTx5lyjbkTR2
    iYkjeI8Cdv9H7yCyLBXRA4IB7aqbyAJqJ/jmayTWUiPTrva2E8w7lS1fw/3bnBZCZYCKqu
    U13kZLUgyBYFgBSi7DDnf5lZXz/8ffErqrb1hgLLO4ksz9/i6ZBgMbetKayQ
X-ME-Proxy: <xmx:1UwKay2bNjPCkPKoW5PorvrOKJUerwOYhArDU-k2wACD19pTEmuMgQ>
    <xmx:1UwKa-i1Z579irGd3xnPxWPtnY6t692VMe6jZ1lk00olx7ctsQjXoQ>
    <xmx:1UwKa6cxDdC5Lj5gWn2AF5XS4O_3XsgIWkq2Dwo6TlujB66_EbSfhA>
    <xmx:1UwKa5lBGZC2Mngc1KWghYP58snRJeUO785hrk6LG9-TIqF1VeEjpQ>
    <xmx:1UwKawgf7yFm4TUkwKSK9DoXWvGSiqbxKVo3HnT3WM_jTxgxeSqtKzzm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 22:39:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  curtis.allen.smith@gmail.com
Subject: Re: [PATCH/RESEND v6 2/2] read-cache: optimize file size change
 when conversion is active
In-Reply-To: <20261127194245.10104-1-tboegi@web.de> (tboegi@web.de's message
	of "Fri, 27 Nov 2026 20:42:45 +0100")
References: <xmqqwm1no29m.fsf@gitster.g>
	<20261127194245.10104-1-tboegi@web.de>
Date: Fri, 27 Nov 2026 19:38:59 -0800
Message-ID: <xmqqzeuty698.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> Commit
> "read-cache: do not trust a size change when conversion is active"
> corrected the case when the file size in the worktree has changed.
> Input filters may convert worktree files with different sizes into the
> same blob.
>
> Optimize the new code:
> The call to would_convert_to_git() can be skipped since the same check
> is done in ce_compare_data()  for regular files, which is called from
> ce_modified_check_fs().

That is a new and unusual way to write a proposed commit log message for
our project.  Is this an LLM experiment gone wrong, or something?

The claim "the same check is done in ce_compare_data(), hence
would_compare_to_git() is unnecessary" seems to be mistaken.  Unless you
meant to name a different function, that is.

> @@ -456,13 +455,12 @@ int ie_modified(struct index_state *istate,
>  		return changed;
>  
>  	/*
> -	 * Immediately after read-tree or update-index --cacheinfo,
> -	 * the length field is zero, as we have never even read the
> -	 * lstat(2) information once, and we cannot trust DATA_CHANGED
> -	 * returned by ie_match_stat() which in turn was returned by
> -	 * ce_match_stat_basic() to signal that the filesize of the
> -	 * blob changed.  We have to actually go to the filesystem to
> -	 * see if the contents match, and if so, should answer "unchanged".
> +	 * When the length field of a regular file is zero or changed,
> +	 * this does not necessarily mean a changed blob in the index.
> +	 * All input filters (CRLF line endings, clean filter..)
> +	 * need to be applied followed by a hash and oideq().
> +	 * This is done in ce_modified_check_fs() below,
> +	 * which calls ce_compare_data().
>  	 *
>  	 * The logic does not apply to gitlinks, as ce_match_stat_basic()
>  	 * already has checked the actual HEAD from the filesystem in the
> @@ -479,10 +477,9 @@ int ie_modified(struct index_state *istate,
>  	     * So let's just special-case symlinks with a target path length
>  	     * (i.e. `sd_size`) of 4096 and force them to be re-checked.
>  	     */
> -	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size != MAX_PATH) &&
> +	    (ce->ce_stat_data.sd_size != MAX_PATH) &&
>  #endif
> -	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0) &&
> -	    !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
> +	    (S_ISGITLINK(ce->ce_mode)))
>  		return changed;

Doesn't this actually have the opposite effect of an optimization?  I
suspect that it also breaks symlink handling.

For a file without conversion active, replacing the check
(ce->ce_stat_data.sd_size != 0) and the would_convert_to_git() check
with S_ISGITLINK(ce->ce_mode) disables the size-mismatch fast path
altogether.

Imagine a repository with 'core.autocrlf' set to false and no attributes
set on a regular file that grows or shrinks on disk.  Because
S_ISGITLINK(ce->ce_mode) is false for regular files, ie_modified() no
longer returns changed early on DATA_CHANGED.  Instead, it falls through
to ce_modified_check_fs(), which calls ce_compare_data() and then
object-file.c:index_fd().

While ce_compare_data() opens the file and passes the file descriptor to
index_fd(), which does call would_convert_to_git(), it does not use that
result to skip reading from the file descriptor or hashing when no
conversion applies.  Rather, index_fd() either reads or maps the file in
index_core() or streams every byte through hash_stream() in order to
compute the object name.  That is in addition to open the file descriptor
for the path that we already know has changed, if we paid attention to
what would_convert_to_git() says.

Wouldn't it be a serious regression to save a cheap gitattributes lookup
on converted files at the cost of reading and hashing every
size-modified non-converted file on disk?

Or am I misreading the code and we actually won't compare the data?

Removing !S_ISLNK(st->st_mode) and (ce->ce_stat_data.sd_size !=
MAX_PATH) makes the conditional false for every symlink on all
platforms, since S_ISGITLINK(ce->ce_mode) is false for symlinks too.
Every size-changed symlink now falls through to ce_compare_link(), which
runs strbuf_readlink() and reads the blob from the object database.

Doesn't it make the GIT_WINDOWS_NATIVE MAX_PATH workaround dead for
symlinks while applying the '.sd_size != MAX_PATH' check to gitlinks
instead?

I think [1/2] alone was probably OK (I am not as familiar with the
details on that part of the code as you are, so my review is not worth
all that much), but I do not know about this step.

Thanks.
