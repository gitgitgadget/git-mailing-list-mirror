Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38618872A
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610948; cv=none; b=Cgtzm8Hmz8/2psqhNc+x6NHzkDbTaMzhMNoyVX0cHECbWM7ZxRlt7nAnWiZ07j8AZzowzQyj6rvKXkuYG/RIIdvMUYbjlu9hUu49gLVYd2q6la+QWkIyYYBlnFlKTr+WbgGe5Mm9zU3N2G2E0YhOFwlWQHaf5qVePUAIaUhByJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610948; c=relaxed/simple;
	bh=fO9sX89X9eyw6b592raYmx1Djt0TlZ+EVgZU5eKpINg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVs9zylhn4f3TJE0/6o+VbdDuUg3gGZ+e03UcQCFI+3OftrUlbehdEnCFMpe0VVYQWEenyOem25Wt5keeNSriItxhkHZBnqa6aA3bihw3QXuYj6TVabYajafoxtOBD0DOWZraU+sqsH+GipKaOOYpoz9kmGShFkf1Vev0HYb09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fwzl+Y0o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVrMb71+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fwzl+Y0o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVrMb71+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89DCC7A0066;
	Thu, 13 Aug 2026 04:49:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 04:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786610945; x=1786697345; bh=nW7be1i30E
	E3Xss33vxc3mtQlS5x0sBvRxvB7Z+7GGI=; b=fwzl+Y0oU0weOOz+lshukU1qAx
	IjAj3BoDsmZ97YUVklirp2mLw3AceMJA75mwwcm5+Se/sRbURPex3HxvlUvr8Gi/
	hDhGjlRHxQLQpOBgWz+9l0RBu7E1fudvM3aH9g0m1Bo+Om8kG1jwejPnwCKj3EO3
	XhiVZu1hlh3Tn0oc4rN+WQBYtf4AHkG/dyLCeyOa1mdTb62g592hRMqVHP+e8ZNt
	d8sfa1Tlao6VGBDNhfTlxcKOwJ4jymeyD48jGG66R06EeEKmctuqvSWkso6DKyLu
	iML3R8W7c7swHnvuGossORl1X3a0w70+P6ILyo5pqEhhc6YWbn2sa+9S8o4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786610945; x=1786697345; bh=nW7be1i30EE3Xss33vxc3mtQlS5x0sBvRxv
	B7Z+7GGI=; b=ZVrMb71+Cd4CS7VXH3LuqMoZFMn6Kk1kDrNUs9MUSMvI8Ne1X0Y
	sAAVFuxmoRE2bDa8b0ABLEdxnc0MFwEhPxvq96IRzDG8unU2DWO/Kjj8WVVRC4Sv
	bX7PfaMw4aDHXOp6YRWxcJnH41GdDtdRrvS9da/+dsIpU8ajJiMhNX8ixs5F7wgZ
	dMX5xyYjxBWVQWE6ZJI8zOS1AN+S1vt+ysMH7qjwemfTCUfI/1z8fqZZbAS0ZUYT
	5Lb5JgO6gDBWXGwhF+0O0MgJPcUA7p/AeLvkpqjTSMOp38XpPNK9gdVl+Zv7G3Cb
	afjSlEzAgeD2OgncqKbthCv3ZDDYi131wZQ==
X-ME-Sender: <xms:AYV9aoYuRsje8IUMqgnvMSjTMz5OqbFTeoZe-iXg7HYsXv2WTlT5Rw>
    <xme:AYV9anF0p2KhjE818JXm-O6qscbMqIIKp4BJQcl6ffXev7nZad6kDuPCUCYOaww02
    Ct9oBk8mlg1BqBBeoYpUa3xEeElwY-nXvOZks7qUOy5zzeKQI2NTYo>
X-ME-Received: <xmr:AYV9asx02RIMasTW7oPp9FWAVseJGnY80GOnZEhdU-MrzOIqWb68Eq360HmzxGV1dXfYdULL-ijlmUF81126G9Ugn9Y_jsd14mTRXbmmvQVY>
X-ME-Proxy-Cause: dmFkZTGD5AWXFrQiFHWeHRWnpy+LownMaGCjod0S/XfDsWQ4+HI18NoZwkQigqrQb/ilGF
    yG+CdUTDchQZCxxRoO+EK1Q6czHchb6LVEWqtwOulU2bm3b/e7VYcnoLuhh0LSP5CFBI05
    rz6CVTkkMZEG9Kw0fAJtRpLhrxkMez/U9apq8v5VzfHrkaGFn3ErPZvDFHrdkywgnpHgjk
    Iy+kPBWZpRXjuyCJJuPoNzMiQVR0YDUptdmz3k6wUYrMfzOOO4mjTmknbd2Iny8Q5f6ua4
    SvrbEuVD/4wm5CgwFwi/llQgoVE4AvIUxIP7cgz7unggMkwSbLXH96pJNgcAAKy0NsshIv
    lAnpvmhWB6twh1i+oYZD/Ub9dZIz3tfABvJ8Q+1SJVZ7Xs0nzt/QtYrC0LqJSomuIcQjV+
    DNt6hTpi950eMmvSgk0JHBmWF7BuzAkT/uDXTatkHVEG16cO++6YPbd+VRVxGExJOiUgNW
    zCtuwsNHFbvunipoljHG3leWGOZBx7Rji/nAsPOHY97jLzKpmO4B4CIm3tmzvTJb6zk/O8
    LkAr13Z4ljTLn/Qlulwf6NIuT9TvUf+L4z9pTAvrG80+C8NvXagw92wokUOkpauadH0JiD
    ZUKJvkfVGxl3wkJOfSIzilfih1gDZgzHcs1/LE/lmBhSj6MTEfAxjr5wg3PA
X-ME-Proxy: <xmx:AYV9aplyg93HKFxTbuk2hZSILDsl1nP-k4FJ36k9xS9GiT3IzIZsig>
    <xmx:AYV9alkQbyOEw0XN0zSh2qL_sV0h_Ha22IYLEGmHEfkV_aXDbXOnjQ>
    <xmx:AYV9arwKNq6cAeiFyqnmu3DbMF4iXJpx0V3PK3rQmVO4uavXGUd0zw>
    <xmx:AYV9aqrw_7XQVuZ-hENcQun4GuuCy4kZRLi8SubnxB73d69SlgE56w>
    <xmx:AYV9aj3cvbem-CsMQuW5kAshNuT7EtTQ7WPyJxLtbazLfdL46h57la6n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 04:49:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 750e462a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 08:49:03 +0000 (UTC)
Date: Thu, 13 Aug 2026 10:49:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/3] midx: pass custom '--base' through incremental writes
Message-ID: <an2E_F_1DC4cPKG3@pks.im>
References: <cover.1781294771.git.me@ttaylorr.com>
 <4115ee0a9a09351e47d557a1283fc6ec4d633304.1781294771.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4115ee0a9a09351e47d557a1283fc6ec4d633304.1781294771.git.me@ttaylorr.com>

On Fri, Jun 12, 2026 at 04:07:11PM -0400, Taylor Blau wrote:
> The 'multi-pack-index' builtin parses '--base' for incremental writes,
> but the normal write path does not pass that value through to
> `write_midx_file()`.
> 
> As a result, something like:
> 
>     $ git multi-pack-index write --incremental --base=<base>
> 
> behaves as if no custom base had been given (unless the caller used the
> '--stdin-packs' path).

I'm a bit confused. Is the "normal" write path the one that generates a
completely new, full MIDX? I assume not, and that you use "normal" to
discern between whether or not we pass "--stdin-packs"? I think that
could be made a bit more explicit.

*goes looking into the code* Yeah, seems like the distinction indeed is
whether "--stdin-packs" was passed in the first place.

> Thread the parsed base through `write_midx_file()`, and update the
> repack caller to pass NULL for the new argument where no custom base
> selection is needed.
> 
> This exposes a pre-existing problem in incremental writes with custom
> bases: the writer skips packs from the full existing MIDX chain, even
> when the caller selected an older base or no base at all.

So as the "normal" write path didn't honor this option at all, I assume
this bug here then refers to "--stdin-packs" being broken?

> The affected t5334 cases fail while trying to write MIDX bitmaps. The
> detached layer omits packs above the selected base, and thus the
> resulting MIDX does not have a reachability closure, making it
> impossible to generate reachability bitmaps.
> 
> Mark those tests as expected failures accordingly. The following commit
> will fix the broken behavior and restore these tests.

Okay.

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 00ffb36394d..949bfa796b2 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -224,7 +224,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
>  	}
>  
>  	ret = write_midx_file(source, opts.preferred_pack,
> -			      opts.refs_snapshot, opts.flags);
> +			      opts.refs_snapshot, opts.incremental_base,
> +			      opts.flags);
>  
>  	free(opts.refs_snapshot);
>  	return ret;

Previously we only passed the base to `write_midx_file_only()`, which is
what we use with "--stdin-packs". Here we now update the normal write
path to use the incremental base, too.

> diff --git a/midx-write.c b/midx-write.c
> index 561e9eedc0e..aa438775ebd 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1850,12 +1850,14 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  int write_midx_file(struct odb_source *source,
>  		    const char *preferred_pack_name,
>  		    const char *refs_snapshot,
> +		    const char *incremental_base,
>  		    unsigned flags)
>  {
>  	struct write_midx_opts opts = {
>  		.source = source,
>  		.preferred_pack_name = preferred_pack_name,
>  		.refs_snapshot = refs_snapshot,
> +		.incremental_base = incremental_base,
>  		.flags = flags,
>  	};

I was wondering whether there needs to be error checking somewhere so
that we only accept an incremental base in case MIDX_WRITE_INCREMENTAL
is set. I couldn't find any.

> diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
> index 68a103d13d2..69e96bf8d93 100755
> --- a/t/t5334-incremental-multi-pack-index.sh
> +++ b/t/t5334-incremental-multi-pack-index.sh
> @@ -119,7 +119,7 @@ test_expect_success 'write MIDX layer with --base without --no-write-chain-file'
>  	test_grep "cannot use --base without --no-write-chain-file" err
>  '
>  
> -test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
> +test_expect_failure 'write MIDX layer with --base=none and --no-write-chain-file' '
>  	test_commit base-none &&
>  	git repack -d &&
>  

Okay. If I understand correctly, the expectation here would be that we
generate a complete MIDX as we don't select any base at all. But we
don't, and instead we base our incremental MIDX on top of the newest
layer by accident.

> @@ -128,19 +128,33 @@ test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file
>  		--no-write-chain-file --base=none)" &&
>  
>  	test_cmp "$midx_chain.bak" "$midx_chain" &&
> -	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
> +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx" &&
> +
> +	echo "$layer" >"$midx_chain" &&
> +	test-tool read-midx --show-objects "$objdir" "$layer" >midx.objects &&
> +	test_grep "^$(git rev-parse 2.2) " midx.objects &&
> +	cp "$midx_chain.bak" "$midx_chain"
>  '

Would it make sense to also test for an object from the first MIDX layer
to be included? Otherwise we don't really assert that all layers are
included in the new MIDX.

Patrick
