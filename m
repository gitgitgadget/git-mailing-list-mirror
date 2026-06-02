Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77F39EF3D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389401; cv=none; b=PcL5oWjuuJSbLi48FigZBUgERqrHKlAat2R4Bahq4q1OhvVuJR9km7+89b/DX/1afA7goRnuNzVU80fDVtcis24GB0UP5Sr1AWsGDu+8gYclKYGDCKNH29Uqdh9Rh1M7IXhPivEvDS9YxkckobCg/7Wo+x7KzAJgEo4whwWyX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389401; c=relaxed/simple;
	bh=tQNeXbqtPCNsNVZJOh4kaDx52CGA88WaKtFgAmxSuns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp6LImIfytSiVlYrnDmW9WyTYMg5TzKBo64mtVotJiKiOkXC+rJ7x2YOT2kUikmZR8FKH1Lu+DtGu4raakI5B4L5pj2X4xPi230NgLtQIQovGauEL+94gYGrmLo9uY1YI6ffV0s7CU5OKGSw857wX97jzz6+Ll2MyzydBkuPnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jtP/SD9R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aJjTRiP9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jtP/SD9R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aJjTRiP9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F4CB7A0085;
	Tue,  2 Jun 2026 04:36:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 02 Jun 2026 04:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780389399; x=1780475799; bh=yHLRlkfsRg
	p9osZFAbXy6qI394i0dvok0XW90AHOQr0=; b=jtP/SD9RlU0KCUdcxRutDmQIfJ
	hjLY7AemgIAlWfc42NVKwr9IhUXl23H8PCcxwoGA8Qt54Ps7QiKf+6Ih1xt7YhoI
	Vry9sdP4Ra7/7P2YJNvvZztf8tIsT6Csj86MRSvlOv92g9I4oMLpegwN8hl0Nr+L
	nky0/qSB9p+EoSi9n3uOz/Wfh7TxLZo9JHRFs6iwEiB8IHY5btBwe9BD2l30YSxH
	tsUYfc4wKKUsnaoW120vRYRR1t3tisH0HUqyjcZS5o7HHXtHAcTpGnCIej98NwAq
	8+g0Bs4AL0+zqVOVTyxSuNAIeN+Lb8P1jAF8dMTTS0UyL5i0vjMZrqQgxqAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780389399; x=1780475799; bh=yHLRlkfsRgp9osZFAbXy6qI394i0dvok0XW
	90AHOQr0=; b=aJjTRiP9DZVv+sf0X8efb2DlJENVp9BzCNH3BLk7Uab27OovNIY
	GbOghIYWuYjPUk0beT/ST5TsRqVNpehX/D3MCEXBCyLVZwHbbR8fscDiCH5t3sZG
	0rPNDS4zcpQ1I4l6QAyyL62BeLNrc0OSDlhi7wzUgZyuk8w3d9R07Kv2qaEm6T+z
	1U7jLheMQAVSABkteolt5EclDzAHjsGosDKxO2b/F3pGgkMzQy3b8fpSVTQlW+Kx
	XX3uQIyTv+5jJ30t9N4+sk6isEs8wuGS+o7iDsy1HOdNj4dZwt4gRbRI4TZN2iK/
	7pq0sB3oxpenq4LjglFESCS1nsQxDYaWEwA==
X-ME-Sender: <xms:FpYeamZSam1kAmu80u-NQU-StpmR6DVKX87nOVAtw4B-ci9_Oj15Kw>
    <xme:FpYeag2xJjgwfV83NX99I_h6uSZ54bssAJwgz3fG6l0c_mHnjwKyE1gQR3bZrUdDX
    tTtZkSEKO12TTmQ_EL4CCW4VyLNDVILjwPlBBhHaDdUSgJ6Cb1Npw>
X-ME-Received: <xmr:FpYeauUYBV7hlCOab0Qa6c0-qCIMncgF_Wvmu_gyIJnkOVu56cbCgvu6Ob0sXbyDiRE_JNDzFm-tGSRmVHY0Hhddc9ATRixo9Iw40EZoIw>
X-ME-Proxy-Cause: dmFkZTFyERyjTruNwF04BYK36VDEpw1ctizK9zvAYHXwN7KeRTEe8ky5rnDLT76QXe5wJh
    2nRbLNsq0sdpdqIt6z3y6FooGx4vG6T3P7ztnkHbhVXTm/BAyxK4BNvZe1FsdIb2nEgPkb
    M0u2cNQ1KQONhZp9i8r4lUQrGSQ4HQSyiD7olBPhOcnjKVQfl24DMsnT6cDbpBBJjHQhSG
    G2k/D1sdXvxBlHXco4lLRS/kEgFMYMAQRh1JviED+chxyQPk8nC76xrEjn4gVFc/06pfgd
    uFxbuMuNkWWJNQ/yOIRzkaA/j/V6T8HqXGTJQRRrK9MdzU+JNulPoaWuFB3+myUPu2S3JL
    +2ufeo/96nO1/pgzQ38ILrCbjtyHxWQsZYkmxTKLQkeCIaw484csyG2Ufd/06zZCsHfGl7
    P8YYG6K75zt+C0B+ux6T/+q/IcxsHJoWY/yAfgwKwoWlv5bYGffNqvdGP56e880ZkMdobW
    2/pzKupoMUEni16OC7iRxCPFaRffgKoO2RAWCxLi4ViUMHCtqkap7tRtT+OBAhXzXoeIYZ
    7fHgaOpgetIcSph7BEjW2TIOZ0vgAJwrvOss8kA6hp+z/Ot068L16DtH2utmqmOYOcAidU
    JKZK/ohLWlQc6Iq1mNULixGqN7tpY8whlvOhstt6OdDPEHDvHQIQ2qQgE0Ng
X-ME-Proxy: <xmx:FpYeaiXbbw6rCcctaoFntptqIGE1BAYbhk8EB9WhTaL7BmfUG9dunA>
    <xmx:F5YealcIAStT3iDWvY3ErLKL96wHXxVt_gsso_o4aOCdkpYKGy9sDQ>
    <xmx:F5YeajU4tGnNCI_mgwcmZt4cZgSzH4B1JHg4YW5c9ltzER_NeBu_sg>
    <xmx:F5YeameW6iBoEPANVwDjlBCvZZNJmKKPM3OTr6YG79ySMlUsDfHCzQ>
    <xmx:F5Yeau5LnrH6cx72sv7CcD3_FJ11mbb9iGSNGRe7TDLQTirSHjieA4XY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 04:36:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 184356d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 08:36:36 +0000 (UTC)
Date: Tue, 2 Jun 2026 10:36:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH] read_gitfile_gently(): return non-repo path on error
Message-ID: <ah6WEtk2pXyViEQA@pks.im>
References: <20260602061159.GA693928@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602061159.GA693928@coredump.intra.peff.net>

On Tue, Jun 02, 2026 at 02:11:59AM -0400, Jeff King wrote:
[snip]
> Two other points of interest.
> 
> One, I'm not sure how useful printing the pointed-to directory is. We
> _could_ just say:
> 
>   fatal: gitfile does not point to a valid repository: /path/to/.git
> 
> which is enough for somebody to investigate themselves. That would
> certainly make the patch smaller.

I have to agree that the patch is somewhat gross, and I myself don't
really see much of an issue to move to an error message like the above
if it ends up simplifying the logic.

> And two, I ran into this running doc-diff:
> 
>   $ ./doc-diff HEAD^ HEAD
>   fatal: not a git repository: (null)
> 
> The correct output (which this patch produces) is:
> 
>   fatal: not a git repository: /home/peff/compile/git/.git/worktrees/worktree3
> 
> And indeed, that path is missing. But why? I feel like I've run into
> this same problem occasionally over the last year or so, but never
> before. Did we get more aggressive about removing worktrees at some
> point? I haven't been able to reproduce whatever is killing off the
> worktree directory, and by the time I see the error it is long gone.

Both git-gc(1) and git-maintenance(1) prune orphaned worktrees that are
older than three months by default, which can be configured via
"gc.worktreePruneExpire". That logic has changed in 4dda60c9df (Merge
branch 'ps/maintenance-missing-tasks', 2025-05-15), which would kind of
match your timeline.

But rereading that patch series I cannot really see how it could result
in more aggressive pruning of worktrees. We used `git worktree prune
--expire <expiry>` before that series, and we still use that logic now.

Hum.

> diff --git a/setup.c b/setup.c
> index 075bf89fa9..2df6fbf595 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1641,9 +1650,11 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  					return GIT_DIR_INVALID_GITFILE;
>  			default:
>  				if (die_on_error)
> -					read_gitfile_error_die(error_code, dir->buf, NULL);
> -				else
> +					read_gitfile_error_die(error_code, dir->buf, error_dst);
> +				else {
> +					free(error_dst);
>  					return GIT_DIR_INVALID_GITFILE;
> +				}

The `if` branch should also gain some curly braces here.

Patrick
