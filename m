Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D60261596
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837968; cv=none; b=E92smr/uYqNT+2L/GK5JkUBmsCyjbENoDpiJutuYLScvtoZptQXBh/3D1nkCeIgoBRHhZWN60o2X21d8R3SI+0cVEcHY1AJ4DmMdIuec0lBuZ+kf9Z2Ehglw1AzlLe4IFxYztMMOQKfuuDn4YyCtLyWJzcfhl2Rfh+SKExhYnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837968; c=relaxed/simple;
	bh=emMEiYC0THPDPwx0h7GdxmNCbQBW/tyfyUi3otpT+7A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o+0qiUMohqqp3HAsZqhE6EDia2DlVcJyTeGxAuvyN1o8kJ48O0cbzXZgfb5T1VvSvDbgAaucKMwNaEvCAi4m6q5u6Br4wkmTYo5wmzGb09T1ExT/LBLR7FYMfj4Olga+7i36ARjfssb68tp2kIE5x8SyxNlDNIyghmvMbwzeP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=geh5eROA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="geh5eROA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745837958; x=1746442758;
	i=johannes.schindelin@gmx.de;
	bh=UK/E2+XeSYPdwoecuK8DZy0q3rVJgXE10CYLjiL1M0Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=geh5eROA3IqNnlE3YKZXRiSpzmfBkhUimj0cZCr7q5IHDeNpklW32Ma0/exOw17p
	 zT1lLHGj/nmW3id94mOpyWhGQJ5ujrUXXoB+PD/pBaXIQojHxvbxb2p1Asz1nH0yx
	 UJoC2J+hIMRmgmbEN1sSxC6jA7qqR68ao2XKh7xrLkp0U2yrVFWovA5xQRuAjAOi0
	 DkLQF+8ssdq0NEuQP83L8PAs/HN+KbjXtVEJDrEqoVILQHLVJQxidoNQysU5OMaIt
	 bt/VeXnX6QSONG1aZ6EdUdWx32lAIDRlvW1f13cgaJ1EsobyXn+qD4pN7SEYaXi1X
	 QXWbXcRsFkNgaxfy7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1v6qcg2280-00vFSl; Mon, 28
 Apr 2025 12:59:18 +0200
Date: Mon, 28 Apr 2025 12:59:17 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitlab-ci: always run MSVC-based Meson job
In-Reply-To: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
Message-ID: <56a0f8fd-7568-b579-1ff3-e0b088b53345@gmx.de>
References: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AnPGeyDrd8ZLfsO6pQSI/ZCEVrq8RnWDFssOiFfITjzFViTtVL+
 dnWd5MbwE8Kmqcib3XJdsKsZv2QgBUc6TN+pYpve2Jwz8MrfHw47c2ZRH9JBI4samFzydUK
 ycJedTmxJWwjFkmCeq9usJlN7ozzxo4EaK0AtO3/KYVEq2BLYHhg2PyABSIBS9JBa/8zdBG
 KLJKnbYyTuTVn5FOsB18Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K09OP1gCCMA=;XdyWuwB6r9o5iY8J1pcVKVkdBab
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 28 Apr 2025, Patrick Steinhardt wrote:

> With 7304bd2bc39 (ci: wire up Visual Studio build with Meson,
> 2025-01-22) we have introduced a CI job that builds and tests Git with
> Microsoft Visual Studio via Meson. This job is only being executed by
> default on GitHub Workflows though -- on GitLab CI it is marked as a
> "manual" job, so the developer has to actively trigger these jobs.
>=20
> The consequence of this split is that any breakage specific to this job
> is only noticed by developers who mainly work with GitHub. Let's improve
> this situation by also running the job by default on GitLab CI.

The rationale makes sense to me, even if the added runtime (and
consumption of resources) is quite contrary to what I would like. From my
point of view, Git is spending way more compute than is warranted. The way
Git's CI builds are set up, in many cases a single regression will cause
many tests/jobs to fail, and that indicates to me that Git's CI definition
(and even Git's test suite) contains too many redundant parts.

Having said that, with the rationale provided in the commit message, this
patch looks good to me.

Ciao,
Johannes

>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> As proposed in [1]. A test run of this pipeline can be found at [2].
> Thanks!
>=20
> Patrick
>=20
> [1]: <aA8ymUzWM2t0QkFP@pks.im>
> [2]: https://gitlab.com/gitlab-org/git/-/merge_requests/349
> ---
>  .gitlab-ci.yml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 4798b283745..bb6d5b976cd 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -173,7 +173,6 @@ build:msvc-meson:
>  test:msvc-meson:
>    extends: .msvc-meson
>    stage: test
> -  when: manual
>    timeout: 6h
>    needs:
>      - job: "build:msvc-meson"
>=20
> ---
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
> change-id: 20250428-pks-gitlab-ci-execute-win-meson-e54998fa7081
>=20
>=20
