Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795837140;
	b=IAebykQB9zBMIM1ldjTSixsNWAOvSph1qRv0WY6fjrqOrydwYILGQcxJ1bzsiDWigtL/
	 6Dwnnd9ZxGXLlumdHWPa90vkWhp0Vj2HruTHF9j6AnWDF6wmWMnkRJFMM6QK/r9CnYF7O
	 mOp8DsgvBL5d/YjOSqlKX//oHRIOaD+iMZDBP8aoWN8s3nYMHKo9yqUR9zpmRod9Plv0v
	 /BucETtGM4GVt2TnIhEqwAvpuvuH/Eah7sq7HwA7vyWVfkDY8mbiWZLcoW3c4iJFKjLxN
	 0bUeWUt01DvShzcxTHWSG1n9kuEvqaJslVF1f6iTmTP8tbSkE3glQKsrDk1LrfXBgUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795837140;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=MDb1R2kKhLJFezZ90wEviD8C8sF6xjlFtSY+TkxZe2k=;
	b=ixwZZwOC9/0szZb+BpS8Vz6XxfmrB6pdba3CgxmQPCKhEfvLx7sd3JOmkxR7zqZYZGwF
	 f2jmiSUc7TPFYSntr6JO0dyZ+s1CDq/7/iY6BWcxwFWGCvAuMG1j07sCuXFsNLTR6UpeE
	 PK1hTH5FgmhRM/h+BYd4+HibmgqBfOm1O+MACNiWfTLLZLMwhiGe58AgTVFBW/4zDmfen
	 gA/8wmClUgvc31rC8tLmEXRaWXm0Abro3gB/DFHPxuWiE4Y/OvWdIh/uvORBc8vhGOTt1
	 VdaeT5M/sGJDul1jqRmhWiMen19HWunKziN8BGleZ7iqBnGzAhsyUxjlQpVSfjWnLFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AUKEMvo3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B1kfMFSs;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8595606A31E
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 03:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8595606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AUKEMvo3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B1kfMFSs
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5346F7A039B
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:38:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 27 Nov 2026 22:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795837139; x=1795923539; bh=MDb1R2kKhL
	JFezZ90wEviD8C8sF6xjlFtSY+TkxZe2k=; b=AUKEMvo3yIx9A9aJ3W9BnSk1Ub
	VHIeC03X3oF91ebkXe3xSeq8gKpjZdpk0Tjn6Ccm/5nBgpLsiM7TmgrO/7Vqx7iq
	RexQ+7hIDhAJtTChVo0fmMrtkslVW5xT9k9pL26y1Pgs5cJK/AgATeyddwBwZDRW
	Ef+3zBIzr08I1nbeb4ni4Q7aoJDcLoG99AaX+dAl/TIldc8Fl0iQYd4Ha8Ks0yfY
	hG1/9cvK4igE3Xumo+2kHaEBzpk58vCIVp+Z4L6QwvZtCGEBLz4gNTEc8c9D8rdc
	Vs4pzO17jKf9a8+kn3/YoEDSdTsJmdicmvW1ud/MH403Cw2exZqdUoWnU9zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795837139; x=1795923539; bh=MDb1R2kKhLJFezZ90wEviD8C8sF6xjlFtSY
	+TkxZe2k=; b=B1kfMFSs3StyX/iq8CHBqx134b4tdRflIUK4YfyVrDlBOEpFIHx
	zfibzJczr71M0Bhen/o0SKLOOVCFv4jpJvsLRZyhTU+TdkFS3487Jg0mV7Qhz9x5
	KDNdCHAHhrImCLN0mmIPc2Ede05pQZjVGSf7NuoPYBz4JlZHMjHhu1toijsIqhy8
	7eZD13MEvNwivRyxzU5BGI9eyZntPs9JkCZohtgQVwHyYoW5tG9cb02pj5drCMHs
	sldHZ/GFeEMh5rOuaPkMCxgag+zOyBrS01DAVXCn+OfkMitD6hXRiDjuuYhyG3Dn
	8vvb8BW+1a5Y5ijxl2IiS2bcr6N9QKmMu3g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795837139; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SqjvbAByZx/wYTKxLTfBjhHQhrNRvYmu8bX2nbGJhRxG4EM
	Ar6nyE4+H1nKDDxnqq9SUQ+uiRp7DlXCuMeOFwVn+qVtibWGOoXHDVRxNrwZmHoF
	W0nv59U4fX5pI2Q7E6NkxhdEtp/jbnwdNS91GC0qeBni9p6zY4hDQxqGtrx+i9xU
	RzEUrf5IjgY+GHRNVnE2eiOFCwy2I/ZmRs6wZR0ugS/Sohg7tEValwhAfAD1H1jC
	Muxo58LFGS91gjRxkE/GdmfEADJSrmLSoMn5SI69jLeb3RcA6tAXLilFrMvqsOZS
	hLf5IEKHbhSTLyZHFstciSAZb2WS3If8dMJU85w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:exFwPRZSiu+/6kG8ciUy0EyIj22IK3Y9q3P0nHlmqt8=:ChAT0jQfwNCgyOZrWMba7UJcWNhGYrNAB2nzsL8OJ/U=;
X-ME-Sender: <xms:0kwKa2YcnIl0Cf7SMHjxDvUEepjkO42nbZtIdD-YIm2cVgzaUGy7UA>
    <xme:0kwKawZ8Mt6U_L6LvaLM21HvbjobVY4QcFkMp9lfy41yD6gGGYACxu7cJ1upF5S5E
    o2EEAMp3dFYcJBHZlhhamGpa846qKxG-Xl4ADDp_LSNT-o5mKsC9tw>
X-ME-Received: <xmr:0kwKa19AXu4AUmh9AKoUWC_Pcg7iP1IZUoUAEsB-7vXHuk7UWTDl-kXPJO_8rNJbf6HwKunxxzn9NhjXIp12PXv32nmkjdZVqI5NNp0>
X-ME-Proxy-Cause: dmFkZTEaNRI0tVG8Q13cs4IeYeLW5M/Jvah6UkyT6AG8JrjfrHWV8qs+pOk1XWONEfYWnZ
    ZeVm+dBkzTVTRKN6oZLmIsnMfaCwQcZqOoe0lAddf2difjsHN2K2ZOQH2F8dbvHNeuSsTl
    Ycwsv9BQZoPK2Q8GI9SuwdsLDESlqE82vRKdJMrIeXXdWlXFpieM5vIfYPDjG8X9WOsKNp
    JUqIfi1BswMpyHIsXU49Jh0glf+pr2AtY5moH+YfSiXT9JfkP8qJfReFCoUI9E4nh7oaoO
    tVok9Qbzpe8kK+nNqnejHRMKcEW1wPQYVCmSzh/3Wl/rl8MYMTVw2cNNdRyuhYJtpv6GfB
    lkFKigkzVAsej6HxUt0fYQuc9csJMQsK99Lkt5BAIQTVToh84uQQTNaNjGgvxgjxeuo4Gt
    hOh2cdWhundEa2U9dnrPfIHSX54Km4ez0rpZjQa4gG9gd9l88VJjE3FBRW7fdti95EASA5
    TiGbUQRZ4DCw2xcLWxjhNctbgumS5jshe2N38lxrn/mHpoYDVn+3BvE3tQBPA8530av877
    tQjkxHtOmyrmnUkA+Dt0ShOtVKFon2hn6L5dcBY93Mf8owIDRkmzshUvtPHRQwqVRn0a7W
    Q+IQ3nclV9iF7uBR5vN4tKTeexUZc2gR4/cRIKknImNHgjgLgxo5AGawNcLw
X-ME-Proxy: <xmx:0kwKa3jQqr6zyUbGwkgtYfof_fGm-vhPZUL3G_m2r5EKkcX9GmCn4Q>
    <xmx:0kwKa9fI55F9uK9uISaGF1F1XTP4NVQnYEPHDkHXd81_c3oKIOpWBw>
    <xmx:0kwKa2r760Q4Rp7I0pwDVzltpf49oPdrmhcvKVagKohCU7wRFtOVxA>
    <xmx:0kwKa6Bb_pXtlnp8U-67B9HHaJ5mnH6RoWKs-hCBSMzAEUVr-kdf5w>
    <xmx:00wKa68ZD9LSvVQaSxdIxpZhTFQd9r7lX3E4lnhnkTBx8EbnVFITLcGD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 22:38:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alessio Attilio <attilio.alessio@protonmail.com>
Subject: Re: [PATCH v3 1/2] submodule: prepare URL helpers for reuse
In-Reply-To: <fc300295ffaef49b592307a90ac3e58bb803b7ca.1795814853.git.gitgitgadget@gmail.com>
	(Alessio Attilio via GitGitGadget's message of "Fri, 27 Nov 2026
	21:27:32 +0000")
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
	<pull.2509.v3.git.git.1795814853.gitgitgadget@gmail.com>
	<fc300295ffaef49b592307a90ac3e58bb803b7ca.1795814853.git.gitgitgadget@gmail.com>
Date: Fri, 27 Nov 2026 19:38:57 -0800
Message-ID: <xmqq4id1zktq.fsf@gitster.g>
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

"Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alessio Attilio <attilio.alessio@protonmail.com>
>
> Move the relative submodule URL resolver and the helper that computes
> the path back to the superproject from builtin/submodule--helper.c to
> submodule.c so they can be shared with git status.
>
> Pass the repository explicitly to the resolver instead of relying on
> the_repository, and update existing callers to use the shared helpers.

This preparatory extraction may make the next patch easier to read.

Removing the get_default_remote() wrapper that has only one caller, and
calling repo_default_remote(repo) directly is safe too, because
repo_default_remote() returns a pointer owned by repo->remote_state (or
a static "origin" string) and repo_config_get_string() does not
invalidate remote_state before relative_url() runs.

> Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
> ---
>  builtin/submodule--helper.c | 63 ++++++-------------------------------
>  submodule.c                 | 41 ++++++++++++++++++++++++
>  submodule.h                 |  3 ++
>  3 files changed, 54 insertions(+), 53 deletions(-)

While this takes 'repo', the fallback when remote.<remote>.url is unset
still calls xgetcwd().  For current callers ('submodule--helper' and
'git status' under RUN_SETUP | NEED_WORK_TREE), the working directory is
already the superproject worktree root, so behavior is preserved.

Still, if a future caller passes a 'struct repository *' for another
worktree or subrepository, xgetcwd() will resolve relative URLs against
the process working directory instead of repo->worktree.

Using

    remoteurl = repo->worktree ? xstrdup(repo->worktree) : xgetcwd();

may make the helper genuinely repository-aware, perhaps?

In any case, the "repository-aware" change should be a separate step,
outside the "move code around" step, right?

> diff --git a/submodule.h b/submodule.h
> index 1a465a1208..2028f272c4 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -62,6 +62,9 @@ int is_tree_submodule_active(struct repository *repo,
>  			     const struct object_id *treeish_name,
>  			     const char *path);
>  int is_submodule_active(struct repository *repo, const char *path);
> +char *resolve_submodule_url(struct repository *repo, const char *url,
> +			    const char *up_path, int quiet);
> +char *get_submodule_up_path(const char *path);

The header names the second parameter 'url', while the definition in
submodule.c names it 'rel_url'.

It would help to add comments above the declarations of these two
functions and to document that callers free the returned string, that
'up_path' may be NULL, and that get_submodule_up_path() expects a
non-empty 'path' (because it indexes path[strlen(path) - 1]).  It would
match the surrounding declarations in this header file.
