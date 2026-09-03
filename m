Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60E1501F35
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459130; cv=none; b=qp+Uji0Szg1QVBrE6i4q5beAHIe5TmB1J0H7HKsh28MMTfmOIxIUpaUDkfC5IqCUAMCOYQMhF5cPJ6NtfQ1hzfEplJs176xmf+M/A7x6hpl4T/0JOOwvZ9athZyYuzNlDouPbP8P8uL55dbBpjifyHqzSAg9qMVSMT+SXk3/0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459130; c=relaxed/simple;
	bh=km+pH6zDUwEZbHCiN/uKuDv60vvupmouapmyKBkNmhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hxIlWL7h0gJlkMFfCLM/9ih/5Tkox71Q1u9wdgqzNYZ/bDrLdIPlDz8pJCSVRmBoqzdUK8wTMSS1crl3ZxR07V8YCkfpzxSD2D7IPhXVlnVJxpyPDFc3adFI0KBrXixnKZ0U9XWcn2vZvAjvkgZiKOKq2+wGxPU0HXoQrzX2G2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IHOhZe7/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLY9AN7s; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IHOhZe7/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLY9AN7s"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 053801D000B8;
	Thu,  3 Sep 2026 14:12:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 03 Sep 2026 14:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788459121; x=1788545521; bh=gyMDSXLNJa
	GEHy6MeaHfasL1pkaJ27ukJ1x5VQ7Sd9Q=; b=IHOhZe7/QEDAEywgdKl8GytXQY
	BaQxcWjTzqhQpGRsxMEr3ehvBrMnueacAbHMfKuFHiP1F33aqGLwAuUPgGIXbtMh
	rmGLL5Z2q4d/mFR9hdzerSE6hg3ds54vkM+nBbiOBdHo0SvWFAVr2olRRmDBNnKe
	kB4GiX4rDoM5Z1xGHOzXyU3q9ZCoqqPbiCCR2HTYipm73M11uUKFcQh9wHBUinfC
	loZo/WfVHlxMFIRkFs/cVcnGS8gXMx/lgmrt+ah+tUwV5vdDDtdVR/qqazkAT5Y6
	tEZOKO/XcVuxtoX88dDr6tT5HfdTsX16yJ1YasPlEef0tm5MGYt5ZBFnfvLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788459121; x=1788545521; bh=gyMDSXLNJaGEHy6MeaHfasL1pkaJ27ukJ1x
	5VQ7Sd9Q=; b=pLY9AN7sh/G25DzGuxnSccMVUPm4G0YMtdCsNO+pVkHbEjQ6ziV
	AthzbnAM91iMrpK6lQn0Kw5m23/JIVV1QpYf7EALGOuiC/NbxxCpS44b8KoAzAvH
	zeEUv301bURCZMJtl0r3kHWuhRnOQCYbchk35mLlLSitR1hHvuiFv/a5RZmsCZLz
	wzeEU1nHHlF10Sd8dSCAtI51Wn1/S1BkoDVNrTpElJidasjxK6llc1h6x+ppnpAJ
	zdBTPJPCYeTgY1A92Y3X97d81ZevvELwIUMQJKhRnAOmOq+D5ydcCJe1VtBYAOrE
	kK+XxJLqBSvYPGLlDcVX2nKqA9rCUmXlFPg==
X-ME-Sender: <xms:cbiZavP077j5Vw2-Zf5Wo4yN7-hRfHEX2Fk5ouvijbMQqFkUf8IAvA>
    <xme:cbiZahaVE5Dx8gvmV_1yFfqYyH4n_N1AX9RznKGiT-6FGJi85-nfKXI9aA7JdMtbY
    8rXiSSpwKwHP_rVhFEKZTyuYT5IeLNTMXrc0Uoc3AyxyKVZxL7IXtM>
X-ME-Received: <xmr:cbiZarpGDqkMs3R0L2e03YUY6sOZZE5HrLueWRPfSxjNJkTidVVSBm0crKy0PK5gejMUJa5gb7ovXFGLIAtpD_vpDvY_IBKF9g>
X-ME-Proxy-Cause: dmFkZTEGUNq2RrpoHL5BbK+g+uFwh4scm/SWkYzvzVmt2u8rHOIjxXVrtNxc/5IKOYVPPa
    barjmzodk2GsFXAl5YqON6V+pbZqkV6oOKSdH3TGZ0Vo15TsjABFvJnxc0RTLiMAZcZMRH
    WDeS4Ym7NvbiGJt4jlSIgF6f6rdIzfeCnZA5D+D7LqLKngYAzgBm4ln5J4anYaCUHHK96Z
    i6mitZn2STCcYPbZ83VvTcLeiWRZ93xZph/2Se+No+JqY8UGmOFLpk63qoCLhagn4sjjxa
    9LMhEV/z9sPpYcSTIUGnnJmvf38I9bkr7yH+fIqduAl2ISen2Eh81++pbq/G3Jt/8pCKGK
    Fiqsqy5Awjd1lkoe0oTg9rsy0WeSR6YHP6u+R8rbLwXhtZ/dngCv/oIGcTNZKKQ8R+QNMy
    t3zDx6NWY0ar/qAYyt4ejrA9r/pu4lYWFnrQhUvfeiIQ/PIbsosGYF7XYADeLWbc4oEqdc
    tmczc88VB0RZLGVxFYydYjWEn4ey0R0y9VVpEsLBMcQwH+4txOj7toC+VwaV989PKGofA5
    R089pgFiPjr2a5mNp/hCZXTrJ//HriEdsTY3FFN+SA9aAbWQv/iVWAxh70mlW5bVe3O93I
    trKkgObh380XnGU1XKANWKj/Z88uouHVSSZdVoEh4rXpKejj4UXgfoxXPutA
X-ME-Proxy: <xmx:cbiZata84TYDpsCGxWndW1RQpvcx5cziyN5fm6Sr8vuqBlvwWmM09g>
    <xmx:cbiZarQmb0GtxQxWR_8s2SZzhBRhbnRT4tq7NPtf721C4afOQmMy0g>
    <xmx:cbiZas6zmolkF58LOGrzQWOC06vUMfMVPvHRMW5bTopdo1q3KeL4Hw>
    <xmx:cbiZaoysJGigP9tSr1fYqdBPKKtxplnc2DhgLMFL4C0QkfTBh_WN3Q>
    <xmx:cbiZakWt6HEIvlssdfhZh7aqdIUGC_yv3-1dAiO5BVN09LD4tK21apkk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 14:12:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dir: find common prefix among non-exclude
 pathspec items
In-Reply-To: <27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de> (Yannik
	Tausch's message of "Thu, 3 Sep 2026 12:04:51 +0200")
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
	<xmqqecfbk2eb.fsf@gitster.g>
	<81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
	<886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
	<27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
Date: Thu, 03 Sep 2026 11:11:59 -0700
Message-ID: <xmqq4ig6cihc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yannik Tausch <dev@ytausch.de> writes:

> +void test_dir__common_prefix_skips_excluded_pathspec_items(void)
> +{
> +	struct pathspec_item items[] = {
> +		{
> +			.match = "unrelated/path",
> +			.magic = PATHSPEC_EXCLUDE,
> +			.nowildcard_len = 14,
> +		},

This unfortunately triggers

t/unit-tests/u-dir.c: In function 'test_dir__common_prefix_skips_excluded_pathspec_items':
t/unit-tests/u-dir.c:53:34: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
   53 |                         .match = "unrelated/path",
      |                                  ^~~~~~~~~~~~~~~~

Other than that, looking good.
