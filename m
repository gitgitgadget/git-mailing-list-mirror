Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E401FE467
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576510; cv=none; b=SxCXY5NruKyLKQHfFcDx+lwJQH9KYkmPgDdJz9xk7l8GmZqKXUhvSeeCA5WwmHSTrKhMzhajNiKwpx1y3CPvqBDVnjTNoy3MFP44ZfF277S+r7W5eMkuzNBZVzsrkAZILKTte1PLoTklCpbBmpVZvooWfDxkaeavfFwAkrcyVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576510; c=relaxed/simple;
	bh=326cfWrZf9eLArUYogIigzajw+G2PDm4WZKecsH5Wxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oOg2fd/3N0w5ETjFGXOI/c9PZlROw/YH8odTcQZ7k3zMHAa4Ix2keU5nnf4LcxhYmEM6F3pTrJbCucA2JWUcKalAYI8Eh5/3qg0wUW3QY9Y2F8vtM6P3JfdSE6bqoZ+IFtfDwiVjwvXLB5mCmJNFDxBvCY8pKTNCGsLL8htp5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sOCj9oFx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pgawVG7N; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sOCj9oFx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgawVG7N"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71E8C11400D4;
	Mon,  3 Feb 2025 04:55:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 04:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1738576507; x=1738662907; bh=Jv+Hsq5KO9UfBGxvla8pzb8K6dORoy/I
	oxsYsBJezAo=; b=sOCj9oFx4IY08XxWPwYjA9O7iF34nGdUkHlNERFfCjwHdIN/
	TOwaW7iL0sqlD5bGaS2+tbNG2kypqoBeUaaPSjqUqQ2lIG5bb1r2KVKc65gbWvXy
	MeSJ+sYz2KuzNZAcWpQS+DVgtXEsGPXMFeuyMnYglxoXtL9HDzV0GZZdPJ1h8G2v
	HR/P993OEY7pQQRm5+qXtEROTmQUtC6zMCGUFKFhMwkog9mAQYSZohbP5l3fEkbC
	YhNBEp/7TlspiMNkc3KV9bp3puEWjP2cSIOLmyngmFH7iIyX79HV02Ql0iZaYawP
	FgboYCw+as2iNpRSH5mKwgKYhIUX9AVXB3MRyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738576507; x=
	1738662907; bh=Jv+Hsq5KO9UfBGxvla8pzb8K6dORoy/IoxsYsBJezAo=; b=p
	gawVG7NOGaqtKz/U5crDF3pKgr6agk8rhngLPARujNveo0rjZxTpUbMz8tYcxUGN
	ntcbJJXzxznJstQGm1A0F10t+yMZA+65v6yBss9h82BCCPKZ71O/14StG6N8HlvJ
	itrl1KyOzTNO7/QLz6NlUvWG+pvWQahQlqDZePRZqZDh5B1qvuOxaXR3AcQfPTu8
	GbRT/YVEyrr6JIFHJ5D041Fggn2tBML7Zr4yLHvdcykzNSwqCVty/KPsYhm3EWql
	FDVAYpFaTUgEasss/UpBSEBwWM1xfh/ZCTj0GvqciuyS6Kw+eaUuz/bEhTxmTHCw
	KYyxZ7wZ0A5t60xBfglxw==
X-ME-Sender: <xms:e5KgZwblHELQkFSDNS0j-axdAftiBYIqdgit5qtNYyn93ZFIT8yM-g>
    <xme:e5KgZ7YDj7kMb80mt5iZz0i2njsqzxV36-CM3CZxAaHFbZf4Nj3pjxkaRXzYN4_92
    LcpcUsP4wzl5b4jRg>
X-ME-Received: <xmr:e5KgZ69wYrZhhVUxHgns4Rzt4o8vfepFkZEV9yrlDmnEVd2xkapfHP9MdkyR-W6Bw979_0gWFMLSmDHxnLZIz0ArFTOnJqe6JkWGCeaHWOvpdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdelfeelgfevtd
    eutdeukeeitdevffdtkeeuhfdvkeetvdduleefhfdtjeevkeeunecuffhomhgrihhnpehg
    ihhtlhgrsgdrtghomhdpsggvnhgthhgvrhdruggvvhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrghsrghmuhhffhhinh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:e5KgZ6qgXgHeJHIl2xyRrFOKNHV5mjFbJ1bmAMwiTAZHutbsL_W-Uw>
    <xmx:e5KgZ7ronl6g-CulRmrU0MNUMYv_oYKOWNZVfxwyUveGqt4n6zT4qQ>
    <xmx:e5KgZ4TPHmcvraj6TpjF7pX69FcToTCbRWg1kYzRbTHrsiBrI4DehQ>
    <xmx:e5KgZ7qE3M59VAmBQ6ruKca_XfeMbmexSKEFesa5NVqd08fcwrWz9g>
    <xmx:e5KgZy2TtMo2gEjRMwe9sc-YFCKXgo4jPCxRtkH_Ej3nzb1zrlpoKkMf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 04:55:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28f02917 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 09:55:04 +0000 (UTC)
Date: Mon, 3 Feb 2025 10:54:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>
Subject: Continuous Benchmarking
Message-ID: <Z6CSc_vyGkn-ozUH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

due to a couple performance regressions that we have hit over the last
couple Git releases at GitLab, we have started to set up an effort to
implement continuous benchmarking for the Git project. The intent is to
have regular (daily) benchmarking runs against Git's `master` and `next`
branches to be able to spot any performance regressions before they make
it into the next release.

I have started with a relatively simple setup:

  - I have started collection benchmarks that I myself do regularly [1].
    These benchmarks are built on hyperfine and are thus not part of the
    Git repository itself.

  - GitLab CI runs on a nightly basis, executing a subset of these
    benchmarks [2].

  - Results are uploaded with a hyperfine adaptor to Bencher and are
    summarized in dashboards.

This at least gives us some visibility in severe performance outliers,
whether these are improvements or regressions. Some statistics are
applied on this data to automatically generate alerts when things are
significantly changing.

The setup is of course not perfect. It's built on top of CI jobs, which
are by their very nature not really performing consistent. The scripts
are hosted outside of Git. And I'm the only one running this.

So I wonder whether there is a wider interest in the Git community to
have this infrastructure part of the Git project itself. This may
include steps like the following:

  - Extending our performance tests we have in "t/perf" to cover more
    benchmarks.

  - Writing an adaptor that is able to upload the data generated from
    our perf scripts to Bencher.

  - Setting up proper infrastructure to do the benchmarking. We may for
    now also continue to use GitLab CI, but as said they are quite noisy
    overall. Dedicated servers would help here.

  - Sending alerts to the Git mailing list.

I'm happy to hear your thoughts on this. Any ideas are welcome,
including "we're not interested at all". In that case, we'd simply
continue to maintain the setup ourselves at GitLab.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/data-access/git/benchmarks
[2]: https://gitlab.com/gitlab-org/data-access/git/benchmarks/-/blob/main/.gitlab-ci.yml?ref_type=heads
[3]: https://bencher.dev/console/projects/git/plots
