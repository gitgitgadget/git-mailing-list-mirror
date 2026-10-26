Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998819;
	b=eKo6Iw+gkpRYYDi/1VPzSO9H7SFPcyuFqgoanWA/3BUTJaSuUjTOio28tWCylW1F4xlL
	 7Dub58HiAvlLrKH8eUdZbQYwNJ7uNPkOI1Mf5uKrn7UtBA7pwS+y1oOcdC3lTHP+11k16
	 s3lVOwHmLkNKp/SUNvmhjYHhE1VEUQPIQELxmnN9UnLJGjooIzmLgPkOrIhKl9AQZ2HJt
	 zId6kU33xEr2eWg8sCp6lOYipIoTrGnrgmFthIScWyUB4XMc/KJtyJ1E0LnhVzLpxgj/L
	 t7ccJB/7IWtrW+jaxlpiINWWoKKzpI8VpF1UeLABDN+BoLoWY8rzG+QrjuUd79gtLAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998819;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HBJyAMSFLWN9cIaMBD/S5zS0soi8ZRHCPZ7w+cxXk/Y=;
	b=KriZck/r3p93ALOFk9J3oxg2GNbsMoNc4OGhyIjBIwuPAoUmLLTvCxlXontxNVEtQ76d
	 frWRnZ5Hymz7dm5S+GJoCDYv1jejU/dPMA1clMKlfFUzotGH5YaNno9vD30m5N8wBtZMe
	 5S9OdQh2x9d5n+P4VURJaZo6xdp5hpCkh/ckjOHFRAanpJRlIgnPGlBTl93+Ni2klv0mS
	 KgpNqJ8+EWANbBbt0GoKDyG61/SEKnXQNtuLD2UxSTNYz3EUDE3R7pFWtPVeBPqoyY1Oo
	 IDx5aciRiczMeWGYW0najNxF4Dt8WsCtxNxDHdNl9WmoM9eFelnM3+DqbhYmzfmiJIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uz5Tv0J9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LBhBK5Kq;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C5606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF3C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uz5Tv0J9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LBhBK5Kq
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 098081D00224
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:13:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 26 Oct 2026 03:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792998817; x=1793085217; bh=HBJyAMSFLW
	N9cIaMBD/S5zS0soi8ZRHCPZ7w+cxXk/Y=; b=uz5Tv0J9Gb3NekuOGohl0yKn+1
	YULAjbEQygEOrTYt7gEto8lStzeXp8NUkXsy9oZBAK/andOi2d7WygQ1PVXKo3gh
	2TeOCYSglWmgjtJa6g0H7MnSLtYg3O2lPPDX2EgtuTdjiCF+uqA/BsH7srsYkx+I
	dG72R7VMZuvUZJC/cWAcA5kvcOqkBaLxG2CXol/VBc5bOQyWsJ2iFcdv3FKA10uD
	xGMKqWFll3lDmLIU0HKcjPaLMt/tp9pThMb4LbT8RFhGqYcTv8NFp6yBC2sb/AJM
	6Sjc5Spgurt4LFrey/KjmDQw+G8c+6o9TszJlXroWjx5l/NPUxlxloz6HDUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792998817; x=1793085217; bh=HBJyAMSFLWN9cIaMBD/S5zS0soi8ZRHCPZ7
	w+cxXk/Y=; b=LBhBK5KqpbVcQfpg9SiejBGCHy6AI1hmpJpr1m/umx9sGwJ8xy3
	+Lcx/Ve5hMuRJg653FUIu7mGFwesp+K6t/c3wsRKMXZ+UHL4NcS2dm630b+4KJ9t
	lrfYP6IWJPDYibRpovan5ITE5uqBxpPH5nc3LWQN6FG3TWgm4BoU5T4FuUn7J4kh
	2N1SZhgPudELG9MEnur5eRqey7Us+4QMCchTdrn3+t7ppqew9ogdgDxzrBGK7lxZ
	WLBO0E2oizWCT8TLtHGxLP9bDleEdWIbpUoWMWvMGFgmu5JmyNMp27a/ns5HgMBk
	J8+PO7A7cKozXlwzsGz7fDgk37iu3FQQloA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792998817; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tCfQeoiXMwTItP3ZIS8aodwbEE24vrLMIYiM7rSnI2UYyVN
	o8mm7Mds4VCT6UWT1D5+S0HnYG1PLQCTyj/3Py4+N9qJjfe8X6q2UzguBaK8u3z5
	eMy7OGdoO80AG1hWCYJ/+VH3uHHBSI/0ff/0gCkKA4fIqpmw3HPoeYv/ihHRgspS
	Dd3KKVL84OyRJpY4AY2o4vZyUtVvZWsf7Mg0s7l0MgGpq6+8I25LfaWkpN59WhiN
	rPJF2JuGY7wmliFpNMxqJiBdFn9grVfB+3U2aNATT5oulhIDbp2iqZSxEYZXdw5+
	+G9c4KjJA1xCI7MSS+z33Vt7y9iRRFJD6twfzlQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PwAYRBRned6YPnS2fYKJ1ucDvCc8hOeHV7uftJ2YjHI=:gjT1SkJ1sLHXIr+M4VabV9egzA6Lm0CORZxtYQlR/p0=;
X-ME-Sender: <xms:of3eaqnFKtd99Gn8hM5XVsWx5cDMOwdD95qHy1XG9hEl-DP1aeApKg>
    <xme:of3eapT2aYKhVE3VJUfV86T8098MUCJ8iMmRuVWX9dz4VU6zic3gyAIR35UL2B0gB
    ZtCaT0pdW0Oj3Ikd3JpKXvhndLbzT9rz3VUK8H_BhunJjcGm1WhWA>
X-ME-Received: <xmr:of3eamD9lJfn2eARNagU87j_4Z5rzypEiN3klG8T8IOHn9EZiuKoBA>
X-ME-Proxy-Cause: dmFkZTFtTlrWElm0DS7LGteUtUKrGw9OqyH9kV9t07Z1qodHhFzFvP+WLoqoRH1zo2Jih9
    VxjaOD5Vhh4m9chBHxAJhXptAgijczElZYFp4TAPq74nv8LAtu4oIpN7J2iUEGIvkdX9KG
    wBYwuxHP779YTiKrOmTypFyNDtLCs+nBhZ/g7GN+/c+HbqoP4fS9JL9N4eAWDypFsO1qc/
    8VyoVkdSJCuQSBHeDdQ8MuyzVjg/KbRe+7FlHbcs3z128X3rFsSLvBFPUZI/X4ecpdYHwz
    gvRngMSCuS9Y8gOqHmqnvbcDHz8mwaQEuLxEEKOyl9I4A0R5PTljFee1oYNKlK8Mfu6hJH
    oPtSPU8ffwAiDSyqgJgbnK/KU6mr3QB8daiSfG+i1eM5Y/4FuOknIgB3Fhiu420eWPRXpD
    8H+J3egczwGyWK8OTrd/rmxm4hdrwCVHnLavm7TIa/6/FulJzlSH5O5+g4N6iiMZbadSLu
    yyh/Bp2nvzkfl8gVmDklNsdoG4RgCOj/q8P7gJIXQZAWyom0hAyxoe/CxlJR+LX+A3pFWw
    xIRZNBYp4rxAWI8kLM8hEx4Ggxqv05juj1wTL7Jgw+aQsFnSdov8dXx5nqvzSIHXkgJxME
    mnI+dmdPX2pTJVm5WKSD7FKqlWtDRJvwwVb/z2pPm8Sw1P3w2W1uMufVaemQ
X-ME-Proxy: <xmx:of3eaoSlXiMRosr_ZTuo6agbWc64L6wZPw0QrNUsNAExO2Pep9ONAA>
    <xmx:of3easqMEpAtaleP3-v14xII_WnMS_N-WuqExG3TqhyPrdUs0NuiVA>
    <xmx:of3eaizvLAOWcuG1we2f290bClC4A4BPdDvTYeKTLZuKGP8Tw3FStg>
    <xmx:of3eapJnZsuYpZ3nFOBFXbOxfto3IIF6qjyQza4j__jIWfq58oM4LQ>
    <xmx:of3eahsYfHsxD1T8ky883DNzKWOTn-q6VnG8UKyHzpsxzxhWbrHt3LWp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 03:13:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5caeae2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 07:13:35 +0000 (UTC)
Date: Mon, 26 Oct 2026 08:13:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
Message-ID: <at79nEHLDrcoCgn_@pks.im>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>

On Fri, Oct 23, 2026 at 04:50:49PM +0000, Harald Nordgren via GitGitGadget wrote:
>     Changes in v2:
>     
>      * Perforce, git-lfs, and JGit install failures now fail the build
>        instead of being silently swallowed. Removed the presence checks and
>        warnings at the end of the script, dead code once install failure is
>        fatal.

Thanks for adapting!

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index d57dce5663..dad35db78b 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -95,21 +95,33 @@ ubuntu-*|i386/ubuntu-*|debian-*)
>  			"$P4WHENCE/bin.linux26x86_64/p4d" \
>  			"$P4WHENCE/bin.linux26x86_64/p4" &&
>  		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
> -			rm -f "$CUSTOM_PATH/p4"
> -			rm -f "$CUSTOM_PATH/p4d"
> +			echo >&2 "error: could not install perforce"
> +			exit 1
>  		}
> +		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> +		p4d -V
> +		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> +		p4 -V

Okay. I was wondering whether we'd even see these binaries or whether
we'd have to `"${CUSTOM_PATH}"/p4d -V` instead. But `$CUSTOM_PATH` gets
set up in "ci/lib.sh" already, so there's no need for that.

>  		wget --quiet \
>  		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
>  		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
>  			-C "$CUSTOM_PATH" --strip-components=1 \
>  			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
> -		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
> -		rm -f "$CUSTOM_PATH/git-lfs"
> +		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
> +			echo >&2 "error: could not install git-lfs"
> +			exit 1
> +		}

This could all be a bit less convoluted if we had `set -e` in
"ci/lib.sh". But that certainly is outside the scope of this patch
series, so meanwhile this looks good to me.

> @@ -121,9 +133,16 @@ macos-*)
>  
>  	mkdir -p "$CUSTOM_PATH"
>  	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
> -	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
> +	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d || {
> +		echo >&2 "error: could not install perforce"
> +		exit 1
> +	}
>  	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true

This line is a bit curious, it makes me wonder whether we want to
tighten it as well now. Any reason why we wouldn't?

>  	rm helix-core-server.tgz

Nit: this is inconsistent with git-lfs, where we also have the call to
rm as part of the condition chain.

Thanks!

Patrick
