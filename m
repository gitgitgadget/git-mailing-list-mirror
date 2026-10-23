Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792132;
	b=ByCj3as57AtHoJtCIm5o25RNjJ5vpC/sCulBfy1aHo59twU8eT74Lt/xWyLfuvgumTwj
	 v3QM6LjtJKl44Bj4hoUuZD0sq1X3cd++3NQcbErBmd1/jJHy9939LGC/FymTV4EsV7uTs
	 o+9wb3BmemQ8za5ITNXn0SS7S/aZgvXWfaxNuVlFzS4WvXIbJiVsCnzP9Qr7C1BRNi/Xu
	 9SVIo4No55xKt6KjSB1tCmCnKeaS/HbX6rGh5GSoBp9JKZ15lDfz9eOUvwS6pUukGc+lp
	 2f8shjGRNuUNiSaaTmSI8KMf4f8xAS5yO5fOAFnM87Dl/oZRKfm1/nDO19IS3ULmwXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792132;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EMMHSZcFBgoVjp6fg+oiUfuSWBqr86csuN5fRE+GOLc=;
	b=VGPKZ0K16XTft2pyeEGeGn2frOzeJEzmUNqoAdx89FyLyWV2pvA7Cu6NWf85usZ+AjLn
	 loJCfS1+6kEiA7lrZf74M7U4Smo38XSKoMEtr+A1G3FFaf0LwnGViiSW99xZYzTFCm3AG
	 J8nR2S2VbThEs++GZhZC/TJPz6y45bwYjjeSyYKyyR9GoPbxTYLpmzXRJBcyrq47UqdbE
	 H5PatdZEbDQHelqMjEwsAMoVoj2g/snoDsjMNkGsS+fXeN0jEjAlTJJg80FJ7ft+asSkL
	 LpsGmOX2VpxPG69hs7saFCLx1EP29TAdJBR2qVxvZFwTK7+t8AeDiUcAcU0CHYBDizQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=k9X+jo0P;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="W0j+hrL/";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF91606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=k9X+jo0P;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=W0j+hrL/
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF0C07A013E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:48:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 17:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792792130; x=1792878530; bh=EMMHSZcFBg
	oVjp6fg+oiUfuSWBqr86csuN5fRE+GOLc=; b=k9X+jo0P0Lf2SkGUvBjsvUKdtw
	P+ab2iBdWNxwmiIDV6/FV7e1N6Y0pPOoxspAKYgmAJNc3WN3IMK9gPA/xxbgzmoF
	nvfkbUVkIr2fUI3AiR0saZUxMBNKrsdYQ3yfeTaWSSWQ/QFXKKmZmllZwg4lTiuc
	lVeDOAmOtcvS7hJI91ISPLgpc3QywF7nUMrB34Q5ioVVEL4RIe+8RmZJJXF+WVCB
	MRKOTX0qrgx8KYVHWz9fQyGGnyWSRmxhn1SaWu461eo1lmHdpPgkyJZX16sxsLtU
	TcsRRvMn8OGqdwdqfrKONnj5amOvH3825z7ke2ieC4k5Lc8Oi8lmebi/SnjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792792130; x=1792878530; bh=EMMHSZcFBgoVjp6fg+oiUfuSWBqr86csuN5
	fRE+GOLc=; b=W0j+hrL/+RoF9HanQrHokpEcLMAZCMfbV5p9PNIUqWSIXocsn9U
	6DoPu2u0MShhiIzzeuWFqN+winDMVpTQv5BnvOvOrzW+z3jmKA1nb2pjBcVUbcyR
	gVufZ1dgIjrQKbqpc0hUlDTn6C01M2su1sAhV6f2x9s1Vvxs9YKfWoMYWxc1OA1T
	T4lvstXgze7SSa3OT7v1tXP2sikRr3IGVSLTXDoeXTTfDWMZ1AaM8i4N57dnvp6A
	VYr4U4JutE1cOdf/s5DV2i1lhdJpnUIiYp+fO66enNVW9qq/A+Dyxggqnh6X/Pu1
	ijyHaaR+5Lh0Ut2bnBmG1SxVz4c5QOywflQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792792130; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LmG2mQtFhEXf1Hse0Sb8k8LCje3NNjashn1VS+L+HP7AYJ7
	mZxxOxSFRdXv631N/57UmDKZ6KHWUQG/g+hcEZRj6OuRYnbIMQS+Of1DqV55luig
	avAi9m8KJBq0unWwozJ0JhB5X4cBzunoBmElaAJDdNG5yXcTGkua+bJUSOoR8+VX
	uzG0eePw7KM1B6AtsZuUB0RnMeKajtpQE86rbDNdighz7LEqr9QduxUeCTvAFO/V
	fP34nLEEXKC/8Uw1gyAQs5AO3mQE0SuEnXRb5LnOr9xGCM46UEKRi1wtTVKKmx2z
	/MMAvxbWDUlb+M7vyaNa1Pi/0UY9FlhUMI9L3Zw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:d+ENdqRl1sMefSM+76CbLv1+fRyzlrg15cxmdjLnzJY=:hIxPd0rjhjlTFwsdtsGC9dBlawBHODraVQoZrgQVTHs=;
X-ME-Sender: <xms:Qtbbaqip_BQrMAV3gfowuLY9H0JphxyvLhRWs6D6y-g95hVbDwp2bA>
    <xme:Qtbbah4TDiK1AXtI-cco5E2yCT6buyP9VMYgyC65sT59jl4CTRQItmW-RDxWfpBpS
    dvNcZs8rAg79b7NIAebR5q7I_s6FPqEOTbR14A9EVBx7kD8UetJ78FR>
X-ME-Received: <xmr:Qtbbaqaq5Wszs3G_4l_IbdOcS_omIvmu_wvKrzHCLQ6wJrzLXLaFnZgx1xaB6VOMz8f7pSzh-k1_xzNWvskIkGLvUlzjLZOV-5Ge>
X-ME-Proxy-Cause: dmFkZTFlmJh7PBmC8rfTn9CpmY+EVb5mGS4GEhT5FoR4b59Z0MVNuSVMhaV9OwDxVX4yPU
    UPkiC3h4ub7cyTk6FbkhbcFFTYKBsrwtNyyaYa/ipCUYFe1KgMwTW6fmpH1ear1M3EJmon
    qwX3vOTxV/2/e5BWeijVGT6wZ6keNP8KN1edp5CNnv8x7n4cMj8n2wJNoIZyyWFxCsUzIA
    C/r1UpFy/rvZD/nnI37yvcIOF2Tej7Qz0zxZZbksAWqhGg6c1XCa8fxToao9yfJav4+s0r
    zB1GFddz2f+YUxIVZo0DXrzGF3tEowxSS+qQWUnyquzqSmnGjIvgJ8VLFVknkJDXRNiPiP
    Mxsr+klOwGrumVvg9ctUnIhzM2dKyoLvVxbt6HbSgBFJs2uBbWYa9uh+zK0MJxw0tXxGsM
    B1PR1zINXy/NkwrBCS4lu9CylhszSeyZzNcPZ9Gz9aMBcaCI9U7i+dST3Fgf7aCD/9dggB
    iK+EgYLamrwR4+ynZc/vbE5QYTThayeWGcnOWHu322ixydUR074YncVZdlXILRFdImrxcx
    X+qZKNa5Mit6VEpVduE+PUTPw8TJmaMK9nHE4LDFTgZRD3rtjU6qaUIHZvYVVutbqm/D7E
    kLOiQnbPSHXuQMEeca51W4AAnh6MwZESGVc2LIpxz2AAOVHU0Ixy19eKlD5w
X-ME-Proxy: <xmx:Qtbbau72wxL2BA3sMYrDQPWQHYanYrsdlYJ_AKoBmZ0D_KcQL9s1qg>
    <xmx:QtbbalC0x0mm1km2HjE2otP-vzy4NwBPKjdBmbkTrQhz-pqrD1YjnQ>
    <xmx:Qtbbasf_w3OXoAlY1bEkPW46PPx9_sqgAo_swg_dSTcVK0wFtM90rA>
    <xmx:QtbbasL57RXvKLfh4QfLXO7diV-PGXKuWg6OE3XjEgC7Sp8IWyuLMw>
    <xmx:QtbbaqIONQYmDYEl2FHcBnvnld_A_sJc3bUs31zNJSrbcMnen1lhhLjv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 17:48:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit
 fail to install
In-Reply-To: <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 23 Oct 2026
	16:50:49 +0000")
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
	<pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:48:48 -0700
Message-ID: <xmqqa4o43x6n.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A failed install of perforce, git-lfs, or JGit was silently
> tolerated. The corresponding tests would just skip and the build
> stayed green, so a broken download could go unnoticed indefinitely.
>
> Fail the build immediately instead on the platforms that install
> these tools. The presence checks and warnings at the end of the
> script are gone too, since we already know by then that everything
> installed or the build wouldn't have gotten this far.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
> ...
>  ci/install-dependencies.sh | 59 +++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 33 deletions(-)
>
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

We used to attempt cleaning after ourselves before giving up (and
continuing), but now we explicitly die and there is no need to
remove the half-installed stuff, which makes sense.  The same
comment for lfs and jgit (omitted from quotes).

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
>  	rm helix-core-server.tgz

The earlier one tried to make them executable, and failed when it
cannot. I wonder you want to move "|| { ... fail ... }" below the
xattr line for consistency, but the command line says "we do not
care if we cannot remove the attribute and will keep going", so it
cannot be done without dropping "|| true" there.  Hmm...

> +	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> +	p4d -V
> +	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> +	p4 -V
>  
>  	case "$jobname" in
>  	osx-meson)
> @@ -171,30 +190,4 @@ Documentation)
>  	;;
>  esac
>  
> -if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
> -then
> ...
> -	jgit version
> -else
> -	echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
> -fi
> -

And it is very nice to see these all go, as we have done the
reporting all very close to where they are installed.

>  end_group "Install dependencies"
>
> base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
