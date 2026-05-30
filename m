Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87402BD0B
	for <git@vger.kernel.org>; Sat, 30 May 2026 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780179524; cv=none; b=QvuWXiy5eYoz6YOegI4CRX02vQb1Pp89wSPcyjA7bDvNnpjgGj4p4pQmUi3klhZ2pVqDzOYdku/mUHPZHozgOpH6JDlH3ntFDmO74SZ9NiUJvhW6lFBCOM60gQPz09ZAfLIiKgSyEpS7b78uut+hSeBY7lYFneo9zgPUv6tbeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780179524; c=relaxed/simple;
	bh=0qGh2VyLebZv+//0zweEaiOhYBt1juXe0MS1OeOszys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mlVBusjKEYX12SzPWrRG0huNziBDD1nY2i18kp1XxNGIlI6TiuK+bI6Mc/tNwhoCHH8RYdNM9ayYQjAEEQ3JXO8+qksplbdfNQtS2fVg2ujqL2IER05Sdvp56v6DjFOjPTNyn7EB7hZWGGFMbOIV3Z7REA0oLuBviZ1bBl1XLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fogo0E6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HI1IMVnn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fogo0E6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HI1IMVnn"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DB417A0097;
	Sat, 30 May 2026 18:18:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 30 May 2026 18:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780179522; x=1780265922; bh=g7OLPYs47o
	3Bxgm8NKFaryawYs29uPB0uYMxVH8s3MI=; b=Fogo0E6Vqt432JxqgCkeJwgB0N
	Xu2SNJdccCcXIGIcxNuEzHKoDTneXMKUQiCDLlljmUoUXQVd2bvl8IP/L165GPUf
	38k6wdTJEdyauxhOqE1RVCNr/8bFa/4ozbjgg0dBFaZdL2IaKBjBgBlfDaMZcCJM
	tvHXqlddgvbMmJZnjyFmhwaBNmOyoWmy1DGQeP9SufJBlw5Y/q+IRf2G+QThn+2r
	rJoYG2cwd9CNPSidJs82Cy0w26ScShw+ouKW9TJR5ZWvnqzNugSS6zw9xivrlBFk
	pVoSS65xqJ9rZZMe3gqu9nx2+ItHO9aqmt8Cz+/CB+L2gPNHTZoF2Syg3Sww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780179522; x=1780265922; bh=g7OLPYs47o3Bxgm8NKFaryawYs29uPB0uYM
	xVH8s3MI=; b=HI1IMVnn98707yqJUy4z88oNovLktnVsxzMCGo6xfvxFJ4gz0FP
	jT0yhfJwSXz4cJ8GHDrhwAM7cmN/j32ogMGtOtMMPbtIzxl5dVjJwZM4IzvDry9C
	uvVgUpe4Dn4aVzA/k8C3hp7BGOhTak5L2BP28zly3YoYJno//lKwL1rI2wYtcgUE
	wFWtpLVpsEEEH+8G3ehtueqdN491g6gvdwtWLdppT1sjCHQbgdZ7coNulTSZR8YW
	0ku5QW7rXKhyH7y67Rz2BjyW0fQagFob6dSEtp+ZVgHuksoHBgjxPYIHN0yjhjmN
	OWeYvlQjVm09DVO77xj/DEhvj2+hKKevShA==
X-ME-Sender: <xms:QmIbahwe1fc95_wHEXm7I79EUF6XPc9iMBygj7AanFOFPQJ7SRlQqg>
    <xme:QmIbaoLgxyOXMFlm1X0v2_h514gvuNX27FxMAV7jJkjkU3bEF37xMDARgSgZEANMt
    liBttRg-hF9z_fT_xi5O3gSN05_SDU4itxpMZpw7Cn9oyugfLsJo88>
X-ME-Received: <xmr:QmIbajr2uSbLoy4C0EjL_bEwCrb2Z4YQ08la8WZe24wjT9Xblndp2cCxtdTSGf6voS0Fx_zReQHHqxPuxOsq9rlYRgZE-Urg1LW9>
X-ME-Proxy-Cause: dmFkZTFN5NRM8Eq7mNJBL80AnfiGGzAqFVfpChnMhNQDSrMotOnu9PYpGMU3eLC/JpPZ7w
    WF020BNM+KT+MyMk+Xqs0xGRc++DqFicMRRdx3sBGotMN4/1w5zj5No/7PEH7pfdgBHA6A
    GKP0kMxM8bi7Byc+Sh68HyPeZ0IZjbTpPJJJJk9oHq8OycAixSyy3OCiHkjsQRA6XWl31n
    /SvsFxCCNMkU25+bXgAiyEezZgjP6kDwkcTmwcTxOtHIJ0lxdpMiyJQv+ogtH7KnqvpyjZ
    9cHLSU5L7SZOC9apvm/jA8ycSjUOVT71Ij2fh/opCG1PeZAXDNsx3S4e72zWN6DWVfR2DA
    9Sif9hst01RDckrMqGUxe2D996Y5sSOIwT/kfsRr0Wm324UCiDS1zaCHCNtYA2Cd+jlmvn
    HS/pZot0vBJdkHFNIaF6tZdkLrVgd3AM9khWHFXP4q+OjbK4RBk0sc1kVE7hgZuL0n8b+P
    3CbOxMymOV3A844bRk8qFIvo9qaH8QmXTbf2aEg1e9ZzrRx6K13qdc53lGNjPMpmcALLMD
    Ph0YPKzZpK8xiNkH19D/80OauBOEQionD+HQc/6adSolx4NPufuGEyg/rVOH6FU2vcDD5t
    UBDCqz5XUxp4CMpeVo+79uL10tFclzfga5NXmVxaQcrEt4YIZp17wWmAuBzg
X-ME-Proxy: <xmx:QmIbavIcf1-JQUrMeiN-A7cmapEBrmLS1klxYKOUKou0-9TWZhlgTg>
    <xmx:QmIbagR8Tp3-WgqsjqcBqfxE2DPwACKc_8RBaAcD0vBM9nzN3nkc9w>
    <xmx:QmIbamu_gk0VPt1l4PoubCKBVFu0PRq52UI7Oz7luQi3C7m4Hxy7IQ>
    <xmx:QmIbapbqgg-5vdNVaPELHUxqRXEyxvnRarwpiZWf4IQM6EqR43IumA>
    <xmx:QmIbaqZhlu3wjhlu9IuB0QWJu6tVCnsLg-HsnCoags7SQpNtS1IvI3ft>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 18:18:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 1/4] doc: link to config for git-replay(1)
In-Reply-To: <doc_replay_link_config.70a@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 21 May 2026
	20:01:58 +0200")
References: <CV_doc_replay_config.709@msgid.xyz>
	<doc_replay_link_config.70a@msgid.xyz>
Date: Sun, 31 May 2026 07:18:41 +0900
Message-ID: <xmqqse78fsn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This config doc was added in 336ac90c (replay: add replay.refAction
> config option, 2025-11-06) but never included anywhere. Include it in
> git-replay(1) and git-config(1).
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/config.adoc     | 2 ++
>  Documentation/git-replay.adoc | 4 ++++
>  2 files changed, 6 insertions(+)

It is always nice to see documentation gaps filled.

The `replay.refAction` configuration variable was indeed left
dangling without a proper link from the main command documentation,
which is embarrassing.  I wonder if we can add simple "doc-lint"
rule or two to prevent similar mistakes from happening again?

> diff --git a/Documentation/config.adoc b/Documentation/config.adoc
> index 62eebe7c545..51fabecb9b0 100644
> --- a/Documentation/config.adoc
> +++ b/Documentation/config.adoc
> @@ -511,6 +511,8 @@ include::config/remotes.adoc[]
>  
>  include::config/repack.adoc[]
>  
> +include::config/replay.adoc[]
> +
>  include::config/rerere.adoc[]
>  
>  include::config/revert.adoc[]

Placing `include::config/replay.adoc[]` in `config.adoc`
alphabetically between `repack` and `rerere` is correct, as the list
is alphabetical.

> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index a32f72aead3..f9ca2db2833 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -209,6 +209,10 @@ This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
>  `refs/heads/mybranch` to point at the result. This can be useful when you want
>  to use bare commit IDs instead of branch names.
>  
> +CONFIGURATION
> +-------------
> +include::config/replay.adoc[]
> +

Adding the `CONFIGURATION` section near the end of `git-replay.adoc`
is also the standard way we expose configuration variables to the
command's manual page.

Looking good.

>  GIT
>  ---
>  Part of the linkgit:git[1] suite
