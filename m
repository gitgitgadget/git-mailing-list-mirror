Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348938D419
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735256; cv=none; b=KaN25SW5CGjuAf/e5wL8YwFl6LJxoxQJgXybvPjkWbPiLVt8ECYKe+tU9xBBsHAW1oHj4I2Ew89I7UO/7to56s4OafIhiWaLrojdlJ5rbbzeyb0TsD8fR+m0ARctQ5X+oXqVjtdduufjO/noXbvn4ZyfiHz7IccR06geJ/vuRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735256; c=relaxed/simple;
	bh=PkPsH32QXGBRuE0Imyu24nRWZDjiy7+HMshwIGGX3I8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NHihT32Uv34+TP7nHeGzUhDPJDh0Vq1RsABPXUYhuiHmGi3147x1ce17QkwaJvm8E+DjtkhO9gDu/CXKkuT2Vsj8D5FyLu1S3gUbjkbDBV4sheGtOSGhHSr70wtQ2bQ8IpqRLFE0kEXcPxS8QBkmc5td04d0bHVqKHU3je8dVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L7mVCXoA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ku0Qnn9U; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L7mVCXoA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ku0Qnn9U"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8429D14000BB;
	Fri, 14 Aug 2026 15:20:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 15:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786735252; x=1786821652; bh=Rm0R2Y7j+I
	FKNj2zpL/G5TMcF1S74TRHwb4j/qaY9Tc=; b=L7mVCXoAoByU7UZ2mcwGnLpLOj
	FB0eMIx8qpPw69rP5MQIAT8E0cDtF5t8MF1zU5D/0cFgBzvkD3gPOLsnZZIiikd2
	JGm294ONNxishQB3+0TRIGdZo/ZgwJL9DYdz47PUpyFu7L1iQyA+IfHnb0i6E33c
	Rj5cVkwI4ieNwisOV5ZjtReUVtbbItjennwc/18OCD5IFxATfzi4BJogYtVbecDJ
	LStv4DyDjKCBopceXvKgWZqN9GfPVxjo2Pa5il4hOFRqNmP890h2/EePFY6JSMOB
	/Wz+a7YebJ6gqaiBgfVGFTA+ZWdIYmATewON+gHDKkKvWrhvOQ987LDsBKcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786735252; x=1786821652; bh=Rm0R2Y7j+IFKNj2zpL/G5TMcF1S74TRHwb4
	j/qaY9Tc=; b=Ku0Qnn9UzlRQSLD9+tw2QbWzwIGzqNZ4f1tf6RVCY2FLhzbCxg/
	UnCb78odYlhWv8uqPzWoDOnlTjAvgsaBVxB3MxfWp/FS7XnjdsXHFjALmhv4pp78
	LVwgnc0V3UJxc5Ijco1WXEiyvSn1jIqpF/UlVWgeTUiPjLG4ylr+Vcr8yNtCUtj6
	piYYaq64p4Qjaa62p3yqfryp+fPndeJy2LIreP83MgVKASG1fjcWwncAAlKh8kv+
	nZ6We0jajj4OXZQ+jRxfw9zHT5NKR9ylS0wmS0pYLrEHqqMktYmbobmVCFdRqDRd
	moFOOY6b9Kffs+u61EJui1knxMnb3P6W6aA==
X-ME-Sender: <xms:lGp_apQZnHm4YMC9nU6cZvUmAY2ayFYtrpCnOpgKVSXB6V3bBfdzxg>
    <xme:lGp_apycEFZwASC9TFM0dStp9d7Wddagp111nBE-zL0mKZhr5n-Vu5B4cRaa1dgTH
    r4AHYFXM2XIoaveupKq2IiUgLMN1qvKHH_ZUhgk8WY6KOCmzxxA>
X-ME-Received: <xmr:lGp_aj3kgKfdMByFSZEQ7ZpQ4wAzwKMP1hgB5AjAkKEtqp4ADVUK9uSzwVwNbvFTJfmP4F2yAehuaVuri_cMSFtS9LoLVXImIQ>
X-ME-Proxy-Cause: dmFkZTEpeGefvzVRQ/SxX2dhJCbNs3oR7JC6Ja6dxCGx2HWrGwvyrqST2RHVYvh16kAtk0
    8vL6WOuUAm/sWogczpFBw3i1VxKUMO4umtcDGlOZRa72yf3dWfmaE/5GE+afixT1Rd54W5
    hTDrAU813QM7faZPYGeuQmyRQY7KSM0l0Qb2tVCPL/UcT1fN7SLn5c0YipaxkC9KSf0CB2
    wm460s2th+x7zj512x3M1ouXJtiUPHu+U1d4/VE1qjKdg+aZbFb03VIP8mT6kGV/awZ7y5
    iBB/tHidaDjgXbgvabTzbiSmjgwfuV4nT8JpMTFzqNv6wXypaPhS4eAYPEmAE2vqchW4Bh
    3qy1YDeBpL/QJLWjz19fL2z5qoh8QqTz88vr0OC9hplpCbxjG4EYNZ1fXaTbHV/bZKfnjF
    MmwgOrFoypDhoPX1O5zRiDdxEg9uRIhxT///lI12hirCrBrwzJHCC25CMuuDnDIv7aY3YT
    ytVPBaUObKPEIevQtskWFBYaHF9J1MDtUltbjcbYFN3+tQS7nF2jUOwmSD7NbwsKTfHko3
    qQvWdmv9T9TlEnjPwIbbJn0g4LGwLgP4ZmmVnsQI7cpNNh3cDOvIIPCJoktg7uABghqADB
    EN6RPiMPAlv9ao1Mh8brtttCSQr0ijEc5233tOTrMG+FrVYj5F+3xrCHuiCw
X-ME-Proxy: <xmx:lGp_av4JTEaV4Vn-g0N2aZtFJB59dzBZhKXmNIqkMCDJKKI2dVM7rw>
    <xmx:lGp_auWqw2buY2abXjehSygPdYw1V8OIopiNvmsAipWLuKgG3iaT6Q>
    <xmx:lGp_amDPi_wD0P1T3UVhZT_rhOjJ5Daa210QYBIC0zKepG2a8Fzeaw>
    <xmx:lGp_al6fQhg0mDxz-Zz1guH2vd98d_N5Mo1rXZIYvnTO0z1xgOFjyA>
    <xmx:lGp_arXYNzK0yCWTDpZgu8lnrqFfgb-3ANBBpqxAiXYFzC3QuiKyttCl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 15:20:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Swapnil Saste | INDIA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Swapnil Saste | INDIA <theswapnilsaste@gmail.Com>
Subject: Re: [PATCH] doc: fix typo in submitting patches
In-Reply-To: <pull.2383.git.git.1786733219160.gitgitgadget@gmail.com> (Swapnil
	Saste's message of "Fri, 14 Aug 2026 18:46:59 +0000")
References: <pull.2383.git.git.1786733219160.gitgitgadget@gmail.com>
Date: Fri, 14 Aug 2026 12:20:50 -0700
Message-ID: <xmqq7blsmru5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Swapnil Saste | INDIA via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Swapnil Saste | INDIA <theswapnilsaste@gmail.Com>
>
> Remove the article "an" before "incremental updates".

Thanks, will apply.


>
> Signed-off-by: Swapnil Saste | INDIA <theswapnilsaste@gmail.Com>
> ---
>     doc: fix typo in submitting patches
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2383%2FtheSwapnilSaste%2Ffix-typo-in-SubmittingPatches-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2383/theSwapnilSaste/fix-typo-in-SubmittingPatches-v1
> Pull-Request: https://github.com/git/git/pull/2383
>
>  Documentation/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c269e474e3..c60855f706 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -117,7 +117,7 @@ of review.
>    can still continue to further improve them by adding more patches on
>    top, but by the time a topic gets merged to 'next', it is expected
>    that everybody agrees that the scope and the basic direction of the
> -  topic are appropriate, so such an incremental updates are limited to
> +  topic are appropriate, so such incremental updates are limited to
>    small corrections and polishing.  After a topic cooks for some time
>    (like 7 calendar days) in 'next' without needing further tweaks on
>    top, it gets merged to the 'master' branch and waits to become part
>
> base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
