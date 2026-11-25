Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565374;
	b=RhuxPMmF2kkTud+ij86rsad6Ejrxg1OqCpTPq3ALW2zSplJEWl8cCLM8A/obNl8OMp8Z
	 pKHLM2EwO2F28Jah3EmFW9DGmOwgDnM3cgJlRvuZ7PCOHFHAR9qjHpvGJJTpMOakUI4TD
	 c0fw7V1x18v4IecwigoTrcwBZgBRVZ8FweZH+c/oypOrt7jqb9jh3S2Vr0J5zSEcwmu3f
	 j4nH7f2YVf6kVcA1mr/JXer4Gwq++er4l86zfoBuGGjzPYWKkYK+HwdEKAtyU56xwZ8P6
	 6RtZhgh2qq56xV+A3wmdiogI8LD0CR1+J0PqubmgfWO9CdmnBoJ3HFisFjqHukQbVAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565374;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=flv9YtcBC5hLo9phIIl8KPjnSNTdbTcy/41R6V3okiE=;
	b=qvaS6cMIUXsQVLNqIKzhdey5p+kVDpnoUL7rflwzpwMUUUt/LgceTZ2PtvJdTOwzj6Yu
	 bvKk5nVlrp+wyA3izS5KDuFoenlfxKtzqjt42j+pZsbmOIj1enoc7vz/Ea2tQOMHe6mrQ
	 0tNMj3cYWOL8DUfXE3hLQC5nHIw+FW6s15AYmKEMrYI5lT6EGQlfIU9tjjnKy42j7SM9C
	 l9clKDch2rtMgwtdqbDo7d8WLBZBS1gXozqNEXScSen5F9GRW9Bm80Dbg87OLrY6CdzeR
	 aP9seKNYCgGmcyaVLt3p7L1xiacCunTkDa8BK/Gtf1NTG/saFH+nSGC7+lAgL0ZpGoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WzTpp+88;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=quUaH21P;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F43606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F43606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WzTpp+88;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=quUaH21P
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 454E71D005A3
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:09:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 19:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795565372; x=1795651772; bh=flv9YtcBC5
	hLo9phIIl8KPjnSNTdbTcy/41R6V3okiE=; b=WzTpp+88ywRi+4JdkPAbb/PoL6
	48XYOMfTIQj91vUTrFyJwAPqLDTGH8eSxRzsBL743Y9tUOKBBH869aMZyriPcHM5
	5V8XGgsXv2L2IRU6Fu9ncd6VbWMiLqHTM4e8CvVhI3n1MVBxf10lUH1PhLE/BIX6
	dRaQbY8/fZMOWzC3hUejggdgy/3ekWg0eVvuD4FYFVNfozkZURZ/ErHptxIjUOsK
	FCNpFNR20Nl92garc+WDaWWbgWzs6c9+kgBWTnQiHB1p4mVrs1FBnk9S4DCCknk7
	/apWnhmuzXzcVxOzPD8zuNmASEgrPlU6TIWZyBmfWsZUdBZwBe7LQi6sFWXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795565372; x=1795651772; bh=flv9YtcBC5hLo9phIIl8KPjnSNTdbTcy/41
	R6V3okiE=; b=quUaH21PTku5gS2qrT7I4iG3Z/NfQZL17UF/q21SHo3ybZiPhg5
	qycwDLT28qbUe5QAhEPeXXbaob1CxKSmSQ2SKvtwdDGKO3vQXJSax+G7qeN4HMBx
	3M8YerYva75qtpyGym0KQJuSKnOwRN69R8TQpwwz5gI2rWC0SpXv5siiBQkKg3VV
	6JwuiClPiK8zezHMKJgmx62GD6Ooai8eyWZIn0dLGtPP7M4KrxApQYOtRj5bp+05
	Fvfo4DIR0O7TL/H6zeG4SfePLD5juWdoT8sIUltamyM4a8lYtmZ8gDcr015lfVU/
	Dn1/2c3/2Y8y88vVIZkwALf0DP83BpWInxQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795565372; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fG6Q7/M6UiQfKA8PSDMymQKFiXF/GyK1ZWlvh4lku+KrWVX
	QGygePbnbbSdLo+Q+xRwR9/z5kzfVlShkOHNx3lQodybLjAIY3+A+oRm7biu7MBz
	3LKRVUDIk9ie+mGnutngbugBGLv86c9C6fQDIUJMjpGyIOTfq8Ru2YS3y2Pv7/wY
	JkzEH5ZFQQWOmDH3bRrGii7HV3L3PhTFIXYp9bs26hcl2AfqZ8Sw/PQhHkvH7Hdo
	VN78cu/MC+PqRBb/LI7Wz0hFHtkvGYOQz/LtifpFcNtp5OucrXegCdyjpRVlH1al
	FBsEGFQXFG86jETKt9UVtG8Ujh5kFoV0yDMKr7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:492Di+DyTn/jdUB7ode0c8MSJzn+ol0FeXq1Bo2WEFc=:iFb57qJOHVI9F2eiUTDYgC+eKeiB2QTK+EYAfmvMD+o=;
X-ME-Sender: <xms:PCcGa8HO4xeZwIP9pGAoGLKFBDuv1bkHceyivkU2DPRQVSe1BlRIPA>
    <xme:PCcGa8NU2epeQWHppe9yD9tNU8TMhH5MGpM0Bl6ktusYq0B4XGFZBvy11MdZx5IkC
    GikWxGr8cW68lHq9G_sYkoKFk8G-aC0uj1bJ31GFGokxHaZVykLEy4>
X-ME-Received: <xmr:PCcGa-fbhiEsCvQh0S-e_SbmqrM0q0T46p6SrDF4cDbXEZkFkybGpobqH1eGbaZyZuUQXECTe_GAeKrGzupkSvTMrLZAjtoYUyYREQA>
X-ME-Proxy-Cause: dmFkZTGXUuQEJZge3/iTQ2+QOwA1TqzZXxzG8WrUo3CLfa4XIySNEpkh2eJrauFE5DcyD5
    nMTAfJlq6IyX0FeFhHeCKAre9CHK2IyHtglQE6i70erJFcjiHzRZxaRYM0aJLVlG5M+nzK
    uSDb7c8QCLlfpdLOEfJsbpDgMWdOueqxxV2ndbT3boOso3CBatlEgHnV47AuiZmej2ZZAs
    VKo/eBOL94SyPqCOEDscCj04FxVVjzo3KholAwCbrTndlGH1wiMBhlYlRNFIek6QgjN1PJ
    a7O14oRHQSbnSNQWRih7L0ty/OrTHolKbFKE6F7OfQcsm2LaX65cUWN6pdpx9AIXC2pikF
    E3+zDC2xr2VYZtKI5E08ApC8m/+fIEPwp6QtT9e7Gkbfrpd4Kf1G4k55qs30+MPsR2MKvF
    V3q5ibxZr3ffiiM3FcD+xNcnnfh+eLdj009MNzGtJvotT2JnuLeg9sw7CUfbbebLQsoFdL
    Uay/DQkgPNeyHQq0eapwag6KWLu1G0MMJNMqG1ny6288hLCzTQuBjruaE7NIYE2ZUeJVBp
    SSMh9UlWT5IRrRBwLf+DhBcNms8p5O0WNyZkIQqPgs0xrSkbXqg9uqEatVwkMBNO3OZepe
    k+51q/PsVaN2RDJP19bG3fiqOGmtzCfYvqwvOIH5t+Lq3g4R6vb+y85jiWmQ
X-ME-Proxy: <xmx:PCcGa5tVkgA5-jROCW_5s_PVLIBvgvuu1hrSUjjXs2LuwcsBfVqB7g>
    <xmx:PCcGa_lxMUGrKWnUgqNLmGTo6LW1gH4GY1EITH3rDwsLXL38UCwvGQ>
    <xmx:PCcGa7yW-zF65Ffd0EPwI5BC-QO_EXwZN9C3Ykk_d38id0YY0tT4RQ>
    <xmx:PCcGaxNeFaWmW_pbxlJTHGYlFEe8-cawA0xgXJ6_wH8oo4V2sK7m1w>
    <xmx:PCcGawqdxUItnJPyNHsTrrlu6VqFUdsOYjWcrATC0Y18lp4GeNzEmkae>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:09:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
  dmnk+artist@google.com
Subject: Re: [PATCH v2 1/2] archive-zip: fix prefix stripping for extra and
 virtual files
In-Reply-To: <72c0d0c0a43cadcc61f0187c86b9bd9361079a42.1795543448.git.dmnk@google.com>
	(Dominik Maier's message of "Tue, 24 Nov 2026 18:05:49 +0000")
References: <20261119192311.2685319-1-dmnk@google.com>
	<cover.1795543448.git.dmnk@google.com>
	<72c0d0c0a43cadcc61f0187c86b9bd9361079a42.1795543448.git.dmnk@google.com>
Date: Tue, 24 Nov 2026 16:09:31 -0800
Message-ID: <xmqqbj7dhiv8.fsf@gitster.g>
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

Dominik Maier <dmnk@google.com> writes:

> write_zip_entry() unconditionally computes path + args->baselen before
> passing path_without_prefix to entry_is_binary(). That matches tracked
> tree entries, which always begin with the final --prefix stored in
> args->base.
>
> Extra files added via --add-file use the per-entry prefix recorded when
> the option was parsed (info->base), and entries from --add-virtual-file
> do not carry --prefix at all. When a later --prefix is longer than the
> extra or virtual file's archive path, path + args->baselen steps past
> the end of path (and for --add-virtual-file, looks up worktree
> gitattributes along an arbitrary virtual path).

Because by default parse_treeish_arg() directs attribute lookups to the
index with GIT_ATTR_INDEX, and only consults worktree attributes when
--worktree-attributes is passed, saying just "gitattributes", not
"worktree gitattributes", would be slightly more accurate, I think.

It does not affect the conclusion, though ;-)

> diff --git a/archive-zip.c b/archive-zip.c
> index 279c3a2d72..db4a96553b 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -271,7 +271,8 @@ static int has_only_ascii(const char *s)
>  static int entry_is_binary(struct index_state *istate, const char *path,
>  			   const void *buffer, size_t size)
>  {
> -	struct userdiff_driver *driver = userdiff_find_by_path(istate, path);
> +	struct userdiff_driver *driver = path ?
> +		userdiff_find_by_path(istate, path) : NULL;

Checking path == NULL case here may make it easy for readers to see what
is going on, but because userdiff_find_by_path() already returns NULL
when path is NULL, the only effect of this change is that we now avoid
the overhead of initializing the static attr_check, when only virtual
files are checked, in userdiff_find_by_path().

As an optimizaiton, swapping the check of !path and one-time
initializing of attr_check in userdiff_find_by_path() may be more
effective.

Either way, falling back to the "default" driver (whose '.binary' is -1
unless configured) correctly drops through to buffer_is_binary().

> @@ -365,6 +367,8 @@ int write_archive_entries(struct archiver_args *args,
>  						  canon_mode(info->stat.st_mode),
>  						  content.buf, content.len);
>  		} else {
> +			args->base = NULL;
> +			args->baselen = 0;
>  			err = write_entry(args, &fake_oid,
>  					  path, strlen(path),
>  					  canon_mode(info->stat.st_mode),

For entries added by '--add-virtual-file', clearing '.base' to NULL
stops write_zip_entry() from doing path + args->baselen or attribute
lookup, and the next '--add-file' iteration restores '.base' and
'.baselen' if needed.

Mutating args->base and args->baselen inside this loop leaves them
pointing at the last extra file's prefix (or NULL) when
write_archive_entries() returns.  None of the current callers in
archive-zip.c, archive-tar.c, or write_archive() inspect them afterward,
and extra_file_info_clear() runs only after write_archive() finishes, so
this is safe as-is, though saving and restoring them around the loop may
avoid surprising any future caller.

Overall, nicely done.
