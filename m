Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001771;
	b=CvTv53wfB1Z63TJjAI5U6S+qfLRMLGmINytAAZgR2DF6LI6j6EWPLFC1T+marrMv8MOB
	 u5/BaChUeuzNYN5tkrTfYH3BwfJZlSsm819KP5XwhE28X3AJJ32hfGXxYzy3C7eRQrwEi
	 ZjQx94CnotTbeH9j79umGGgnmL0QYMvgAgwb/cBpfhOMxbbvbE9cT5KS9E2N0PUvBLbvF
	 KcdPZM4rRyTN/ENLhKhNNQP4bZg8O2oDqQGHTcQk4l+HlaCfzusls0A1xWIc3144mkVH6
	 zmxRiW8Iw1h9FblBQtixmM+6X9KokugL7V6MRUH2IIVBr1huEja7JxwJhx3Ln+Ie8KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001771;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=auP/b7Pd0gXtdRf95DxjGvoIqXGdPL7GoAXlfTe71B8=;
	b=JzNESinfg9ZEAUb4ZkD832sVAWtSou4VPZNb0+XsQ2L2idmlf1IVOCl46yyxnZ+N8Jkw
	 QzIrltSpdWGHMOYHUT2Lp1RIudFdQjizVWMF5Vpj8YGnlteC5Wx6LrM8GFbnpYqNRtQMq
	 qeeL9PE+Z3W0OnqbGpEt+B1HVczoWhHOOC3enPY91+0cK9U3SP2URIO1Lsdvrren3nTRT
	 H/pDzabdLIomy0BZVDwdMgyD1Z6gMsvhKYYp13mIs8CtfwBrtKjpL5VCNKGjEZ1AjieT6
	 t9AR9wX+Xt4wwNeUHgs+wVz/rYObqzfNv7NyBw/qrMlD6PNAJU5eWwul6GMVbqaMl5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=jWe+WdM+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Hn75XViM;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85822606A327
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85822606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=jWe+WdM+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Hn75XViM
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 99DBA1D0023A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:02:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 04:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793001769; x=1793088169; bh=auP/b7Pd0g
	XtdRf95DxjGvoIqXGdPL7GoAXlfTe71B8=; b=jWe+WdM+Jn+GuMv3b0q25/VMhk
	r840DqDhgn1SXiSRMb4UvC2UfrF91BQeHIHnITjdVLOze8yLKe+/T4a4VBjUndJa
	shX9DU0KvyaiszOkbsvzC2kHbI/S3U+kXVwLVbgWifAryYzVfpOTXUxVO9FjPOLw
	4ar+tBVnEfHtAJsXVRTydv8vVwLZs+simRa5N9ZL+bdzncy4lGjO2Ed+zXgG+aOA
	177C7dQY27YW14WOknVypuC0cKS7ZF2PA5mB6RdCsq5cAfYdDTwbbjajCj+Gzs2o
	zPRqm/K5bL1H9J96CSk04JBlI6YknZbQbCdZ3Rbrq+1Au2Nny6KWJLaYkpMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793001769; x=1793088169; bh=auP/b7Pd0gXtdRf95DxjGvoIqXGdPL7GoAX
	lfTe71B8=; b=Hn75XViM1vcyLKTntCHn0Wl0lzNfhujIB/3KGP2JjzkjOfI6EA4
	9hXrTQ/w0zpSnCiZ+yzOMcaNhIkJqRXdqSYSGm91S5kbEuC33NHnkhL2KYPbx8o/
	/30GgfDUvCTKHfBLKgpwnYrfmYiO4eYyeZQ6GG3+qgwlKjYQ6Iae6Rlr7WrDPmDl
	pFzPKJeiqnnNRP8plslgip8MD8wUOt838eYCvXE/9We9x4K90mDV/+RTjKes2UUQ
	zl3ZZBxm8Bo4qct8uPBeuIIGg47weNkfVVxmrroh9UmhC3U01WgpXeHE6C4qKAr5
	6ipk1FJyn0vcpIiRMr+M4SM8vi6X8Vf2eDQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793001769; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R8VvtEAko2I0bE9VO76CkhU4BwMXoIJ9T62wQBcGAq9PDEc
	SQRBDdUjt4gg0+B/z/MUPpM9Qc9V16mkWsDJP3oefavJ9gyAYAXmKoT+6UtLSczD
	xxl4ccIgxeow8xbzNQDIFrrw7FXN6+kditWnGGDzgMdJco98kLamiZi+8sB6eo39
	stkcYrPyBwLw7BjGXNbnbuyaX/S5VmoBFvYKHfctl0QjIMUINkTmc+XDrujZB8YM
	bYF9upzWQqQj7KQNuv86rIYOJ9jWRTIlgmV2JRx7gqWiTe4b64uaTQJ6pWnAHG71
	Kr7aw48GWmawJNf45MScWpB9i/MUSMFYgi0isAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:n5jtTKqJ0eUm3zpYViHxqsBS6WJihNxoWtu/9NVk9uY=:oJCb5ckD8xW9WPpOjbBhweMlSzirRsr3pgAjZpjC4eg=;
X-ME-Sender: <xms:KQnfaoUlPS5tMwKO-vLl5WQQx0iBDqQkb3_oioH4R8fVNdhsgGXJaQ>
    <xme:KQnfakBvLD7nv-6v8gGIp5ILmJK7sA0oNsrjxm8W2K_-ZONfqlgN_oAzomPUFfhWy
    nMHsKT-ELpjqjXLZN7Zm7kY8nD59PPboYmLx7TqhARZ0VClVDAfVw>
X-ME-Received: <xmr:KQnfapzmXKjdHLEefJRqK8CWZwAZvLmntwY75h7c425uiULMFi2jTA>
X-ME-Proxy-Cause: dmFkZTG35GjhJRiQvMR8f+sDTOezIOfbM2fnFLK7WNLW2kFvUByhWB3YLiUZB/k6dVEia2
    N48WQFd4GAW4f+odTw3y4ZZSHe2U5oxi3DR02lemq/GOLM8yBR7KzpTkyKqjGUQCAn70Dt
    ghKaFGZujr4uIv1c6Z+FioXaW1u7ji6pHhqVwCq4rTTF+L2zDtXQtjVX7jsF8HVsI6zP2D
    gbo/tzLILwd6EWcyadoy2PxbKIDZT68snVFsndIxn6B4N/8+peYvvEDqg9ScKvho0t9Vhh
    FSfQoOwtuVdX0VYJCyveC0lDqJLIdZiihxdFgpwnniIj6aP395pVSgpnQsZETLhNSGtTMd
    af9gM7bgUaANNoiF21baqnX198MTpJhzuGXIu+SX5mf/QZqxFGpxTInr5MkpmgdiaFcWa4
    HpIod6fW+n/Ja4/C1mYE89OrPk4D5Cdwc+chH+pE9LjOT6M7H0W90jU0srulynQEdci5hP
    K/KqW4uYh5dsRnauCnPmIlxZkx2z4CT+D1PMEDIQBUMK7VtvzoEb8UtgPBD1HIw8cnrW9v
    Q1r9y4X5/6KifmSA7OSBdIwrX46CzqfA37GIyAF8gJp9S4Qn3PY0wHT9dtkdZJawejST8d
    +wdRqRzu1EIAkJU7tAbNjPbjnNiXKVLVmNkbZ7Z4YgVMAk37XYPYzAdnxJLg
X-ME-Proxy: <xmx:KQnfahDcWO-usMhDVgTpgRZP8858uUtKfVrlwMBw0nlsYHLu_Mcy7A>
    <xmx:KQnfamaOred4EzZ3IjIzzUEDf2rzBljce6fimvLAYkSG6g57nX9cdA>
    <xmx:KQnfapjGbldLsEEWlRXEox7OodNVqqGWKcCZdzO7tBUaJDaDVodGjA>
    <xmx:KQnfao4oihLKCRXbhJJ09UVPA_cdP4kw97f79xatsB0iRUJoApScoQ>
    <xmx:KQnfaoc7QejXXXM29lrH-DICZDKByftk1ac6SlM4481xUZmgKfsq_9RL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:02:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 04007a5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:02:46 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:02:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] ci: drop no-op gettext link on macOS
Message-ID: <at8JI1QRE4bjGHp0@pks.im>
References: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
 <pull.2402.v2.git.git.1789369749450.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2402.v2.git.git.1789369749450.gitgitgadget@gmail.com>

On Mon, Sep 14, 2026 at 07:09:09AM +0000, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Homebrew's gettext formula used to be keg-only, meaning brew would
> install it into the Cellar without linking its headers, libraries, or
> utilities like msgfmt anywhere on the default search paths, to avoid
> clashing with software that already ships its own gettext. `brew link
> --force gettext` overrode that restriction so the keg-only install
> became visible on the paths git's build and tests rely on.
> 
> Homebrew dropped gettext's keg-only status in 2020
> (https://github.com/Homebrew/homebrew-core/pull/53489), so a fresh
> install now links into the prefix by itself. `brew link --force`
> against an already-linked keg has nothing left to override, and only
> produces a spurious "Already linked" warning in every macOS job's
> log.

Thanks, that's useful context to have and explains why it's fine to
remove this now.

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 2f61fbb07c..2903c39fab 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -117,7 +117,6 @@ macos-*)
>  	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time
> -	brew link --force gettext

Okay. Your [1] verifies that this works on the GitHub side. I've also
created a pipeline on the GitLab side in [2], and that pipeline passes,
as well.

So overall this change looks reasonable to me, thanks!

Patrick

[1]: https://github.com/git/git/pull/2402 
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/713
