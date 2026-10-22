Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689846;
	b=zp782BPKT4JBIxotZbWfuQBljAomTbHXXEQd5ZENAyGaVPNyessGM6T+t1zuABfMHm3b
	 M6jg/1ln1khY5kZI21aFG9v78yn5pW5Ko3ak+DRrcEWgadpGgEeZlZYbKJgJs5yBmKgOj
	 6f8hb9GznQ9Ym+PaxT/yL2D6z+KiH+j6+S3th0QgbjKwb43hZEkyU31Irxw6UK4Wg/hxn
	 NKrXy0RS9PEMFPbFs6jQ27pR9OLfLO9Y/LPp1VggTaR7+FVO4E0E+c+liyfW8lxQAx6HS
	 /Jot1xHRNijZ0Z2EGeLt8ghk1viMC0HuEDjYSdnwDCmA+xE+ivK7vZSLqYyHZUufNkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=H3XJwg4snmvAH3GSDDJsqgCFJst8VyaQUhKfAv/Vq5A=;
	b=mVQTTNq2ZUNCs5FrHOTr0fMgIQ4emrXdSRVvmz287euI2pmxog5ChtLMBr5wKG22CLQP
	 Up6BGdn1Kt2+LNdV+0zvk1o2sWESJ57e89OJq4o9KYzmk+tC/NbH+7YBjZNPUP+F1rJel
	 v27WvJp3WdZgQoaHiokWCl5zcKURST4QNWPkHXrnKM5IFqFAiVYdupBgA3bHuwZ3unNmG
	 +cGfO+d6FpecXzBgXayeFAILqyh5n/btQvjhwG8PvlH5I9FFpFvsmutTwf/3yDq8n1y14
	 oJQF/RJWR6a5NzU4AX40PMlsK/j0SjGTJEOU5x5TyW0O2ay41/M76TPD/2w+rM5khiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cAqnrMzj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dcFAidvs;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F4606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 555F4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cAqnrMzj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dcFAidvs
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B98BD1D001C1
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:24:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 22 Oct 2026 13:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792689845; x=1792776245; bh=H3XJwg4snm
	vAH3GSDDJsqgCFJst8VyaQUhKfAv/Vq5A=; b=cAqnrMzjV4CDk4X2O6/mI0dxam
	vLojBx6sMnVg/KTkmqQ6+A2AEN26+Ybp4isBsbqTgssoOeDkT97VlQG5JstCyA98
	rkIgspRaLO9iqyA6MMaK+E1eKXnoI+M68Oj72lGKDakVzt2cGI0+4osvM1OEo19j
	LtA29da/LPa6WIjOh6a+h7JiOjY8jD9UQFProxAyxYJ/QmTzYrp04y95DICAwfoo
	irttnTybHAvg+ShHTn5VR+mZR1vUTCYyC8kaMMMsk8ICoqJnWB4PmJLjRTtd4koS
	yLn9vpb/UmD9UZ5AAKb+QXKdKfc7nUSuB18VRDJBneQS6OcTbccTMjzrorcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792689845; x=1792776245; bh=H3XJwg4snmvAH3GSDDJsqgCFJst8VyaQUhK
	fAv/Vq5A=; b=dcFAidvsiCGCphwcoSYvqTIiMUtcmA0meOBrS7VX15tQcmSMTba
	OLeLriPiXVsIBgJFOg56XRzaRZD5cerRJYPzV+T+G/XhXCT1zvvFmmxOC/BcRVW5
	yEmQTvGTGDAfcwat4eAJuHdzzKSLibdBfs/CUP0RtI2LujmhyN7A2R48O7b+Igm7
	X5ofbKFItesoVF5O4VrASM2Adpz+MpkOjvZSttUTQ+Z71TUnS42y+1kXUCa0i06K
	Q5lNHcK/HJR9se5eDuAvrPdq5N+sb1Ey8MI07JDjSE0ZeiD4U+EY7W1Z04R0ey6v
	w/5lbdSScuaIoTT8ZPbivTmmcax5PXvEBlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792689845; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EqnV92UQElYb5bEZkWkyS53sQtE66D4Fq4u6eRE6H7Ep+3J
	qjq4OjKXd8aWdY8HBhrpy0sebxF/Z06z+/lihNSNh+Ay1jP4YrbLRbOo6LEOg2gW
	K1HsEzfq3YHU91NopGkMwKcnRl/DJAD/S9Rrjuw7IoEhmcaahaAuuDIdH7BYCkvx
	TSBftkGvDN+9xYA1M1jAFz7Lg/5JHZCGPiPUv0Nq08cyyfPx4TEaTSkN4RC9NNsH
	c9TKQQrtq5brB0kYeW3NCLuc7OfjnTBQ3iIiRgxL0hNphJB+e96uwu6a8oSO9+AB
	NDMJoQyaI865IO6pvIHUpyB9PugvF8Bgvs8/EzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mNbxFavoWw+WHtzliD2GhgO4ZUNCQR1UktmHIBwD0ME=:Kgn9ccrcuTJlYfF62Fk4uj8lgwID6UKe/CJG2ikF03Y=;
X-ME-Sender: <xms:tUbaasOrds3VfhW3TBabbIia2iqgoGKa4IXBriqY_iIObzE_ivkVYQ>
    <xme:tUbaap06yaZ0LSYsyu6AIghYAAC9ORsCIrWpIA_D2B7M2uQ268sAv4HeMv0o4FjIK
    NMyIVFm7WHLr7YJXKZzceOmHjrxZTgCW0aFh7U1fa1pvExsIwTzYQ>
X-ME-Received: <xmr:tUbaarmVJaAXAj1KJ5aF_Ga0xJqtotI6NlZWTicwwgqz_P7tKb6nxiIqVz-hPDW6L9vZYsv-CkI_KrMPPBckrDSSs51X8iMjHUo1>
X-ME-Proxy-Cause: dmFkZTGueLBKaajp+DphdUv1CeOaJOIb/v6qo1OR7s3rNI1tiaY8K4ppHcvgDmnkr655Ys
    m2XDsA1NNtplt2v0CNVOYHzWcIJY/OSIQ+IyvSVbwVk4vnKES8Dr7aaThe8q937+yuJ36w
    zkmvTZEzUoDe0J7cZyTJDkF5gtYIAkkxfhlPnYAbaWguG/9pwkMOUzwdIZ1w4LAfPwp6Ol
    FzZFdeQPGnlZRDABYl3HEFCaBFTYhogif4UAfg2GKsaLC5vV3lav+UPQeK+CZRtV3ihqgs
    Ii3DQEnn6uE1pz530gIAL6Cj4C6aiN84TToEi6DVsxHvW/NFGDca3qlEVbiq5lBpmXdKFZ
    aXRkxB0vvPd76ptS34qan7xI2dclPs3J6UBoivtueAJ2sAKt5bVgdodn5DPRdijy/La83L
    58UqgiWSWNUvbPFYoCz5AtwNOHDll2sC55bbNzRy0zLtGHb21G0/N6nXGEh/zpFYhAMHL1
    8ESnUd6NWPfapLO8WsczcTW2/8g1nTIjyjcnb6SsRIaC517LjNSq470hzDT83XdywHKqPW
    EnRINc5N4Pm9RrqbR/mQUuWYBAMGPO3FiUXl2iF753IVEDh8fdvfkL886V/lfwh4YuOzMB
    SpcRehkjTYHO/sTcora0GmE5NFVBRJfSenzxw3oK5HFGiw2HVAyQvdTPsh5Q
X-ME-Proxy: <xmx:tUbaagUgsu4c5rUgygjW1pqGofIfTI8srdNYTPmzySx9Ho5BBMke7A>
    <xmx:tUbaahvdTbpds586l5orKZH5yms8Cje7YfxsU4zYV1bw4RbZ39ElMg>
    <xmx:tUbaajbArYoe8DvZADC8hcURi_UKLRNGh0d_WT6MD9T3eXemv5qA8g>
    <xmx:tUbaagWjrIJ8KCFabzFHg6n4cP0EINvvyRS9qFZ3Mp5gGSUM1uJCEA>
    <xmx:tUbaannakSSeAzBQ0F4073LgA1l4Uc_0fDEcKpqmclWuwaWrAzzdZkJR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 13:24:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Usman Akinyemi <usmanakinyemi202@gmail.com>,
  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v2] [Outreachy PATCH] t0001: avoid pipes in test scripts
In-Reply-To: <pull.2260.v2.git.1792666211685.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Thu, 22 Oct 2026 10:50:11
	+0000")
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
	<pull.2260.v2.git.1792666211685.gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 10:24:03 -0700
Message-ID: <xmqqbj8lhcng.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Srujith Poojary <poojarysrujith@gmail.com>
>
> Avoid piping output from git version directly into sed to ensure
>
> that any command failure is properly caught by test scripts.
>
> Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
> ---

You do not want a blank line in the middle of a sentence.

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f271..02217a9bf8 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
>  		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
>  		git init refformat
>  	) &&
> -	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
> +	git version --build-options >build-options &&
> +		sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&

Unnecessary indentation.  The only reason why you thought it was
needed was because the original was (wrongly) expressed as a single
pipeline.  Once that glitch is gone, anybody reading the resulting
code has no reason to think that this "sed" is associated stronger
to the previous "git version" than with the next "git rev-parse"
line.

>  	git -C refformat rev-parse --show-ref-storage-format >actual &&
>  	test_cmp expect actual
>  '
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
