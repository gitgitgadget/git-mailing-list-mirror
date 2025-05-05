Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60518DB2F
	for <git@vger.kernel.org>; Mon,  5 May 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453615; cv=none; b=I4LG/22nBH+yqE84s2zCzCDgh7YjCd4zH6Af81iqmpzTZ1kXibQBX6diXKGPQhz+rbu12oD+y4yZWRkmQyGNAt71yisOq/tJF1lzMLsrzLdND9Bdn1y6pNFW0ObVRGyq2pYS+aL0i8B/AAZMGjg4n9IBoVEIuTVxBzqlLSbMXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453615; c=relaxed/simple;
	bh=TCUwmzxruSw40iZ7cHBv6ZE4IJ5Oz9xxQmdRTZHNuZE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FWbY4r7rgoQd6k5KBMcyyKJt3eO5LNoOatWpLZfWnuSwfyplOhI8jLPObdebH9fX/AVriS/yQGUmRH0k4jx6oc6VZswARyy46A+fUrqmwQFsYMQmVJZkviavZKkoTEVhVT+2125N7k128E0f/cABUhO/ziUpt2p3vgSBBZVFbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PYb3fRA5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PYb3fRA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746453607; x=1747058407;
	i=johannes.schindelin@gmx.de;
	bh=rcOlKeNPXK3AsFtVE40aUc7fOxpICCkJBtkPqgZZ7EA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PYb3fRA5JM46K/o1++9yUAN0vyEvz5GK9+TcH1tiAa8rd2RKW7zCVi4PILxmnXus
	 m3rrzTD2fDi9tXjbGUEU//CdnrXjyibPzo6r9k+glrXhBD+g1IQGAaJuV8Exak/DI
	 TaVv8aLu6eVr4cPXsqZM6zdayt6hcAf2vbJwiBFTku0gdI8+4GLBSXfe5B7siIYtk
	 mHN+tBFGfvUf8V3AK88bxrxqnOtWgInwjtAEmYyr+V7jo7jjO9Nwq8Wjp33TJ5eaA
	 R911BNZdbd486MEBY+WLY6vaYPCDSj92ob853qR9PSbIvyxFkRGo1VkxjN1R6oIY7
	 UKVSYdi0ioD6oInuvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.189]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1ufWUV2RLg-00qOmY; Mon, 05
 May 2025 16:00:07 +0200
Date: Mon, 5 May 2025 16:00:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: fix aggregation of test results with Meson
In-Reply-To: <20250505-b4-pks-meson-aggregate-results-v1-1-f38899a0a2cc@pks.im>
Message-ID: <b98d128e-0c16-aa50-e5d5-1717a611b7f6@gmx.de>
References: <20250505-b4-pks-meson-aggregate-results-v1-1-f38899a0a2cc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mQ9Chk7L/ycta44OhSMFNx+bdnMJL+1wER/7xmZFLHrokOut1vE
 2UP6qhZGqyCSMcOOJ6voR3gjSEa7GfcLRnOskyB3hXU5nG7jVzTqjrnucq2s6On47HutDCw
 nXJUpzhjEtHoyjq3ka1Fb+my7vbNBomB6Ait7FX6O+sKEfKsNy+zQCtJzHA3/LyKXIsNKWK
 ctnIUFy/qjNz4oj0U4X5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6r+5K5zSsIU=;DOdH66YltxV1hxOe4SBJ4e98OTw
 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
 JRRzz2kl+kwj8=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 5 May 2025, Patrick Steinhardt wrote:

> Our CI needs to be aware of the location of the test output directory so
> that it knows where to find test results. Some of our CI jobs achieve
> this by setting the `TEST_OUTPUT_DIRECTORY` environment variable, which
> ensures that the output will be written to that directory. Other jobs,
> especially on GitHub Workflows, don't set that environment variable and
> instead expect test results to be located in the source directory in
> "t/".
>=20
> The latter logic does not work with Meson though, as the test results
> are not written into the source directory by default, but instead into
> the build directory. As such, any job that uses Meson without setting
> the environment variable will be unable to locate and aggregate results.
>=20
> Fix this by explicitly setting the test output directory when we set up
> the Meson build directory. Like this, we can easily default to "t/" in
> the source directory when the value hasn't been set explicitly.
>=20
> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>=20
> Johannes reported to me off-list that aggregation of test results
> doesn't work on GitHub Workflow when using Meson, as can be seen e.g. in
> [1].
>=20
> As it turns out, the issue is that we don't set `TEST_OUTPUT_DIRECTORY`
> for many of the GitHub Workflows jobs. And because Meson by default puts
> test results into the build instead of into the source directory our
> assumption that the results can be found in "t/" is broken. This isn't=
=20
>=20
> I never noticed this failure myself because in GitLab we always set the
> above environment variable there. In any case, this patch fixes it as
> can be seen at [2].
>=20
> Thanks!

Thank _you_!
Johannes

>=20
> Patrick
>=20
> [1]: https://github.com/git-for-windows/git/actions/runs/14806194960/job=
/41574766327#step:9:2125
> [2]: https://github.com/git/git/actions/runs/14833082023/job/41638408968
> ---
>  ci/run-build-and-tests.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index f99b7db2ee8..bd300a05db8 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -56,6 +56,7 @@ case "$jobname" in
>  		--warnlevel 2 --werror \
>  		--wrap-mode nofallback \
>  		-Dfuzzers=3Dtrue \
> +		-Dtest_output_directory=3D"${TEST_OUTPUT_DIRECTORY:-$(pwd)/t}" \
>  		$MESONFLAGS
>  	group "Build" meson compile -C build --
>  	if test -n "$run_tests"
>=20
> ---
> base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
> change-id: 20250505-b4-pks-meson-aggregate-results-60ef175dd424
>=20
>=20
