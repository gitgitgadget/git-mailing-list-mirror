Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7D238143
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455440; cv=none; b=a4q6WcZ2jG6LVYd+PaM2LLjjmS7ZERrJyZ+vrQ2GuEoYUKFjbdXex1LvnA0nsQ9UILg8BF33k9sVKCybdSJHsVll2UqjJ4H9Sj8pqkuRfrZummeM7B72ibArnJqLMBA63w3uHIlllj+qC5IHhIwOu+ev4Xrv7gLhgPU2TX+bX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455440; c=relaxed/simple;
	bh=mAhSRSLyUbRyAL0rL92LfBmKSVhyXLbSNojp3p0ydKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1n0iaO6X3uAhIfMzTpRl7xjU1CUH+i24+bhVxz/YSmWSKo6Xg3fj/lfAbkG3zMFFV8D3VR1XoYi/XhIt+BF68t7j8s+WpAz7cjLzZKPFikIPUycAJsh/jkbk2N5Q0I/Gqk2tjCKNMyS7hasF/lj8Vo2ChlKFm0KvK1MYkRY+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a7+qzKS4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l1/BXU3W; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a7+qzKS4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l1/BXU3W"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F752114010C;
	Fri, 20 Jun 2025 17:37:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 20 Jun 2025 17:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750455437; x=1750541837; bh=0OVjfsOKl5
	0H1yh7g8ET6kdOPCX3Hm0iT/v+FP221hg=; b=a7+qzKS41T73ceGp+Cc8YRtAbY
	621xCiAPaPdm3T1PNUFomENW0RigOz561Hgnus22/CVK2MGyAjzbyIC5DaFe4XAv
	+AvZ19vZqdgvdAffTVPb6MPqCDnlw2JGf/qMlFSekLxDy9IXHt+e4VSsTTBKJIDm
	MbZ8a7kNurThuRDd2+VCMD/HNOtwHHGSv0SvbxwoN0bGnsSQsswjcJlgvHgelzzl
	ss/28Rqi57IlZDS8DD+I8FE/yXrfPS4XzSVzmDoDmnIIjLN7zbCAaVxgRVbpR1kd
	iBqIrWojLc2PO7e7hBGCw+RzzuI+AgPPX8//Pgw8Bo6ue1G7KvoWW4vUCuMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750455437; x=1750541837; bh=0OVjfsOKl50H1yh7g8ET6kdOPCX3Hm0iT/v
	+FP221hg=; b=l1/BXU3WkDhEKB0x3TH+jgfO+xREEMa5oZqk81wyXpPsepmkOEp
	vDSFTti3AoZd5LpJ0XaI5/LFGfX9IAlHOwC3hOPzk9dPBVlR0p+lnIKX/iKY4gi1
	vgZ08Wz7SguyFc50Agf9qtWNnkkclauWk881gXqfvzwJxg9MWRcx64I/rX4xm67a
	CFmlpsRaCm71HCM2JyUgUCZ8FYH5HQft5ZPIO00bsfrSmLkIlVnQGzmoi6xNh+J6
	NbGP+iMoIRfozTaez+73NKmFhuOycGZhmZT7d1NnZB06AmUnsVCnYkCWFn1hh3Nu
	mAxMvCYD+1LlCbv0AwPobdo7N7oKc2uc7pQ==
X-ME-Sender: <xms:jdRVaP6oxO09xtPbJs-vXuE4RGL-0qqs-9Hc5G_YvweWKN2FUyADaA>
    <xme:jdRVaE5ErkIfGX-pWrInSkkjjO_ODaFGVp8mQ7f8n2ZqxJQ2t3Eiz-2pFHo9wT3JX
    hHcVEu6bWnkjRHlwQ>
X-ME-Received: <xmr:jdRVaGeB2YiizIZJCMMfBOkQmuvu32HuiCmXLrqTGUECsIDuJDS7UYnC5PES3EzzlXA5e9uB80frNfWAvCAIJfgjdDLErDRiM6L8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdelhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jdRVaAIPtpDbOVY3IzbtBJgsmw8dxPQfezhR1fcbW1Nvn-gephFmFA>
    <xmx:jdRVaDL0G_1mAl2aYfnMxhePTHNW-hTqUXmRrx9k0NsmwidHkqTgDA>
    <xmx:jdRVaJyBSt1uQwqZX0lVNZK87oTqKHLUQZAlAj8vBUbL3v7kmcqJIw>
    <xmx:jdRVaPLomF8r8Nf3Gb7Afe0y7UUxgVm6t7uiY2TKQuqSyD7grTd18A>
    <xmx:jdRVaHUROWIhDE1cY0AKAE4B9OgEJbmOkDqHYSLrHqCvOjRZoe6IY102>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 17:37:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com
Subject: Re: [GSoC RFC PATCH v2 3/7] repo-info: add plaintext as an output
 format
In-Reply-To: <20250619225751.99699-4-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 19 Jun 2025 19:57:47 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-4-lucasseikioshiro@gmail.com>
Date: Fri, 20 Jun 2025 14:37:15 -0700
Message-ID: <xmqq5xgq14dw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add 'plaintext' as an output format of repo-info. This output format is
> composed zero or more key=value pairs, one per line.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/repo-info.c  | 12 +++++++++++-
>  t/t1900-repo-info.sh |  4 ++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index cbe1475e30..cd7c110f47 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -3,7 +3,8 @@
>  #include "parse-options.h"
>  
>  enum output_format {
> -	FORMAT_JSON
> +	FORMAT_JSON,
> +	FORMAT_PLAINTEXT
>  };

Give a trailing comma after "_PLAINTEXT".

>  struct repo_info {
> @@ -19,10 +20,16 @@ static void repo_info_init(struct repo_info *repo_info,
>  
>  	if (format == NULL || !strcmp(format, "json"))
>  		repo_info->format = FORMAT_JSON;

It is somewhat strange for this helper function deciding/hardcoding
what the default format is.  Would it make it easier to understand
if you lost "if given NULL, use JSON" from here, and instead
initialize the local variable format to "json" in cmd_repo_info()?

> +	else if (!strcmp(format, "plaintext"))
> +		repo_info->format = FORMAT_PLAINTEXT;
>  	else
>  		die("invalid format %s", format);
>  }
>  
> +static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED)
> +{
> +}
> +
>  static void repo_info_print_json(struct repo_info *repo_info UNUSED)
>  {
>  	struct json_writer jw;
> @@ -44,6 +51,9 @@ static void repo_info_print(struct repo_info *repo_info)
>  	case FORMAT_JSON:
>  		repo_info_print_json(repo_info);
>  		break;
> +	case FORMAT_PLAINTEXT:
> +		repo_info_print_plaintext(repo_info);
> +		break;
>  	}
>  }
>  
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index f634e1a285..998c835795 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -18,5 +18,9 @@ test_expect_success PERLJSON 'json: returns empty output with allow-empty' '
>  	git repo-info --format=json >output &&
>  	test_line_count = 2 output
>  '
> +test_expect_success 'plaintext: returns empty output with allow-empty' '

allow-empty?

> +	git repo-info --format=plaintext >output &&
> +	test_line_count = 0 output
> +'

In any case, I do not know if it makes sense to add this test before
you have a single line of repo_info_print_plaintext() implemented.
