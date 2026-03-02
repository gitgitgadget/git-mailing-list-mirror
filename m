Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C971D0DEE
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435874; cv=none; b=gQkMnpgNnB3uFT4AcB+mhCCWy4/+rknplZZguzVwTQE14qfh5f/ndoiBm2sFM/cJGx0EyfAC8FbIxgVjeohEfv/iBnsyyWKhSceK3+w14pIauT4B4Y5uEFl/eY2LyIc96dTTk3ZmkEPfQblHDqBSt/YSl5z2msLofcJkLisQlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435874; c=relaxed/simple;
	bh=FBAFZIZTZaJDpKd9KxBpB9EJlTh6oJhPbMBicwjxdyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vk1PMF+WZfxTeSE4T9UDrRc+5DcpmsxqXXtuE96SutV4ptE/U0ycLSNgkLLngIcXtCLjIoWs/YeX+kLlN/LJgC37/TUVbGs+aOmzjOZG2DYrCMcdTVoP8l+jv7pG/G5AhdOuW/QZ2VSkCfVSCm0ji1q/b9WxfIMFTaaSJHrz1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O+nRF28V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fnt/U+SG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O+nRF28V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fnt/U+SG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F860EC0562;
	Mon,  2 Mar 2026 02:17:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 02 Mar 2026 02:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1772435871; x=1772522271; bh=fJ8SfNAPyI
	08dzVuIDys6QVvlB/RaJqGy+26M5MOL5o=; b=O+nRF28VC0ppuvap4TliZHrJbc
	9b6djEnG/hoMn6IXz6nL90WkIqNxUUPdUQwXJQoXM9dPTNiPxYEY1YcWT+wMTx3a
	r1ID2/Aa0vtoJtXNpxBEbJR524xwhdVhtX/Jh9109C/zG77HtB7rtrds1CXtTnPQ
	U4qvBwvCrEE8Hvjm9pGpGY0aY+MuxPOyfcPJl8NBiofHPgASoQvtnGTMrgo3tJXO
	QXjhxe9AE7rElWz+HpTbD5BZNVyWFRw3Iyupg7r4In7OLbhPmQohLwYNHPBqxTk/
	e0kBBh4Tw9bzJO4KAtFn0tnX8iexgqFIv5WHfW0nKyKH/8WKLfHB8Bd8thSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772435871; x=1772522271; bh=fJ8SfNAPyI08dzVuIDys6QVvlB/R
	aJqGy+26M5MOL5o=; b=Fnt/U+SGGMJ8suSMcADWMntzfkndOgg+6f57jkihfd1+
	JHuCgb7hH57RH+ttYl5n5A/zQNa6e7Vsu/VOoIjgs7+lt8SZGBtqyX9ecVxsaFdU
	N38gCud2PVLPpc+HeYyR3eSttBJndFYPzT3/YiEZlXGxunL40hl5+tF97Z4XrRYG
	s5hSAzXNWPa2jn7mfrleMAbPWRGU14A2dCjJPPaE7lzXKCxZNc57E658eCuZpI5o
	cuuhCRooj1CLEsafa+E3QcC+jfEGv6HwamdwwwfcFaatitCXC0KPDbj2qb9Z9LZz
	+km8mAxETyg4X11k0o4TqtUBSUwfbo8wXk8vPslNWw==
X-ME-Sender: <xms:nzmladEONMmeGj3F88UP_h0EGsr2b2xxFouZnOVVJ6MZUgy2mKfSUA>
    <xme:nzmlaYW0uS8AuGmHsMId2X3PdawtZkJ1Nf5_4XxufeNR94JzAs6bX5ANw7H0KXY65
    -T8CS_tx3lnDEXa_1AWSjkvMVkrUU2_iy6qJthRtj5wVV8ryflLCQ>
X-ME-Received: <xmr:nzmlacxQJh9df8x9znX-Ep5auuP4q-jewPhIHbGW-c3r-qT9iwvvU-Hg_p94cY43F4yukiToRATK1oxx1sT0CH5wtR7D8sa9Y8e1z_kSLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkgggtugfgsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhtdetieehtdegjefggeelleefkeevffekgffhjeejieevvdelgedtkedutedufeenucff
    ohhmrghinhepsggvnhgthhgvrhdruggvvhdpghhithhlrggsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggurh
    hirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nzmlaeP30TsFy6g6I8YOo_lE9E4DF1nMEpbcRwHULV1dyuKcLoztAw>
    <xmx:nzmlaV77JmYH2xKKNLZDCE_gBmtngTY_iYmXwZvhfzQxgPd1JJ6zoQ>
    <xmx:nzmlaXNmr2BPuFzUMUsUF0DyvVJA7YFDbUw6Od55TKiarbtSb0v7gw>
    <xmx:nzmlabmjUshxk9ZL4HXwTQ7YPpJSxxBvVTS1KS7mqBQf6AKRlQxHjA>
    <xmx:nzmlaVZhsRSidvCN8cZORvOHUEO4jY4t_oThbEhoPTA9q3RbLH_zKVIU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 02:17:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc548e77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 07:17:48 +0000 (UTC)
Date: Mon, 2 Mar 2026 08:17:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Performance regression in "update" hooks
Message-ID: <aaU5lZwEuR4OrxCl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

Bencher has alerted me that there's been two performance regressions in
git-receive-pack(1) [1] and git-fetch(1) [2].

The first one is quite easy to reproduce with the benchmarks at [3] and
bisects to fc148b146a (receive-pack: convert update hooks to new API,
2026-01-28):

  $ cd receive-refs
  $ ./run --revisions /path/to/your/git/repo \
      fc148b146ad41be71a7852c4867f0773cbfe1ff9~,fc148b146ad41be71a7852c4867f0773cbfe1ff9 \
      --parameter-list refformat reftable \
      --parameter-list refcount 10000

  Benchmark 1: receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9~)
    Time (mean ± σ):     182.0 ms ±   2.7 ms    [User: 91.5 ms, System: 89.3 ms]
    Range (min … max):   175.8 ms … 185.0 ms    15 runs

  Benchmark 2: receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9)
    Time (mean ± σ):     484.6 ms ±  27.6 ms    [User: 176.2 ms, System: 376.1 ms]
    Range (min … max):   406.2 ms … 495.1 ms    10 runs

  Summary
    receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9~) ran
      2.66 ± 0.16 times faster than receive: many refs (refformat = reftable, refcount = 10000, revision = fc148b146ad41be71a7852c4867f0773cbfe1ff9)

I've Cc'd Adrian.

The other performance regression seems to be present in both
git-receive-pack(1) and git-fetch(1) and happens between e6e9f13364
(Sync with 'master', 2026-02-25) and ebd1da8b75 (Merge branch
'cx/fetch-display-ubfix' into next, 2026-02-26). It took me a while to
reproduce as my local Git configuration was hiding the regression, but I
have been able to bisect this to 452b12c2e0 (builtin/maintenance: use
"geometric" strategy by default, 2026-02-24).

The problem here is rather simple though. The benchmark fetches 10,000
refs into the repository, and before the commit we didn't do anything
about them. But after the commit we now have per-data-structure tasks,
and the result is that we thus end up packing refs. That's also why the
regression isn't present in the reftable backend, as it wouldn't need
any optimization.

So I'd consider this to be a bug in the benchmarking infrastructure
itself that I'll fix by disabling auto-maintenance.

Thanks!

Patrick

[1]: https://bencher.dev/perf/git?lower_value=false&upper_value=false&lower_boundary=false&upper_boundary=false&x_axis=date_time&branches=595859eb-071c-48e9-97cf-195e0a3d6ed1&testbeds=02dcb8ad-6873-494c-aabc-9a6237601308&benchmarks=e3553193-aefc-40a4-8816-9c1bdc1838a4%2Ccd00a2a1-0fd1-416a-9812-cfd3e9b4fdb8&measures=63dafffb-98c4-4c27-ba43-7112cae627fc&start_time=1765177145759&end_time=1772434745759&tab=plots&plot=6887f804-2bbc-4219-8211-55b6440fd5c0&plots_search=6887f804-2bbc-4219-8211-55b6440fd5c0&key=true&reports_per_page=4&branches_per_page=8&testbeds_per_page=8&benchmarks_per_page=8&plots_per_page=8&reports_page=1&branches_page=1&testbeds_page=1&benchmarks_page=1&plots_page=1
[2]: https://bencher.dev/perf/git?lower_value=false&upper_value=false&lower_boundary=false&upper_boundary=false&x_axis=date_time&branches=595859eb-071c-48e9-97cf-195e0a3d6ed1&testbeds=02dcb8ad-6873-494c-aabc-9a6237601308&benchmarks=196480c8-64d1-4768-a3e2-ac3c5f75a26e%2Cb422ed57-2b09-474b-a85f-2d71ba7ca46b&measures=63dafffb-98c4-4c27-ba43-7112cae627fc&start_time=1765177141331&end_time=1772434741331&tab=plots&plot=4134acc8-9194-454c-9d71-f41b44ab969d&plots_search=4134acc8-9194-454c-9d71-f41b44ab969d&key=true&reports_per_page=4&branches_per_page=8&testbeds_per_page=8&benchmarks_per_page=8&plots_per_page=8&reports_page=1&branches_page=1&testbeds_page=1&benchmarks_page=1&plots_page=1
[3]: https://gitlab.com/gitlab-org/data-access/git/benchmarks
