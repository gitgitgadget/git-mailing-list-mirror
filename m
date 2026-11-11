Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394084;
	b=0fViOrB+jOG/NFTyHOGhqieTZxOUEqYxPWTRfV3KkZwoDmKq5IJRDjUSPOjWAS3cKOJ+
	 QMrG3WL9ecSex4plmK0SiQndSVlOVNlyZQSkC05tVoOvEBSwK6Ge2YYS/8Mcut34/ZITO
	 /Q75XpkYRP+Y7G8OpEkmPbX0ypuDJCIYfnGwOB6gypE6Calv873wMq3QP5XHnZu4TBSt1
	 x/lwpq3WsxeFmZwvJe4LQOxnqMOfuglcrk+Irq/KjJM87BeeJff1dOPuZtvMDFR8w+CrT
	 KckNU0KepSisAEP0aN6Zkedkrd3JfVJHaiEqWd6lFSKY13iURrQ+oUx/kLjwd13y56w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394084;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer;
	bh=yfKU+L8LSj+6OWMJzn/BtkO1Y4kqUIQ7LNry6Kul0Go=;
	b=1Mhjh7kPVhVQE3GEtxVKQmzJhHGdHW2fMRhjNFJj2oIIef0dvL53yCp71DFQM/KdcXqm
	 LM8BhXDKCiPZDRAFGVuyf/ZhzVEwOOJQ/hZRcCshPJH+jnCTor8YQiC45Vn/ugEPCVsAE
	 zvYVXFWSGWdkbE5craGQW1XykmkPV+il3wqdXyRzcipCGCKS64d1qUUugEP7FxzcvSZvG
	 fgT5nYZ2cLt6RP7etsKiE6kiOPUtGKM7L72T0Et+EJ/wttBKKz3OpQEpjxjF/IgJflq+3
	 Yj26LUqK4pyYlS6cZQBxT+/3vfmZWTBWSSCweH6OQuNGwBKQUfzWS6bDUjfahx2hV1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QpCBJoKQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0p+CMDdd;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D8606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 914D8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QpCBJoKQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0p+CMDdd
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C3DE7EC088A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:48:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 05:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394082;
	 x=1794480482; bh=yfKU+L8LSj+6OWMJzn/BtkO1Y4kqUIQ7LNry6Kul0Go=; b=
	QpCBJoKQtK+S0xudz4wbr1xwPxwtLos+d+mnJW48YS92cO/x2qWIubaY0ddtHSyO
	3rpaD0qltTH98FpV2AFD/ZAvvTKYBD0F8DLAUW/9Bv2KfM9toy/Ml0qfpUJx/88Z
	JtG1tNFnZa9vJmv2ZQEYukQecZGFpqucIsR5VO8xb1WUp+1dAsrNeBZwiQTlbqom
	VaeslSZ4s0TsxWsCcPr4e2VM8nG59a/UAoKYhvM30tO1M+s9iMs1FQCYyBQHJVAN
	oMxEhuW/vEz7OU2ZlMdUU0NndgNlmXBdeikw5TAqncdlVaVFoT1TD747cMKdiwt5
	7qj/J5IxpxbEW41Giwrg0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394082; x=
	1794480482; bh=yfKU+L8LSj+6OWMJzn/BtkO1Y4kqUIQ7LNry6Kul0Go=; b=0
	p+CMDddJOrDMW0UE8k1Q2AumVPPIFs6z9XPLzAErEnsJoXUf0LqlZ/toPJHwISH/
	6VDv9UJr7fawqKNN4W8i050fKSpyuSzUHnKPmmt+f2iuupfjlDqiAo1RwIgXkYEO
	7FBIMwR8DfuVT5oEM50Df3EFwmnbyOxGHGHGUA63edvOai0rwWdC8SyfvIw0NEZV
	4o208oCrI5ZJ+gNpUHR8zl0Bs4Yo43r2b2Nc3SGQWnNI4fhWGUXwQQ/qXMs7N76B
	Cs582ADHVrXhAKEI++BNAQGohj7yVcDgJldpeeOYm8B/DGUAXk9YlwzqsYG3Qhf1
	FeCKu1++6esljTLn8IxPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394082; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:BS7J91IvmyRTpROyKTKfabwjquJfMLGRjBsnJkoE8WkDTtL
	8uzMvt+3OpmEuTgpXUVqoU4oTXikOzazeEiD73juLlVlRL295OSZkEX1qvIvVtKT
	TTPjFwSe6d1ZKD95b8JcYpfEi2I9wSkplUhecN1Z+r/LGV/27eTiEdiSvLvOMBWd
	qrkfCzvvfvBpqwoEBm12DkswHY2hQemkRv1XeH3VsNB4o+8n6eqS01P+K9HgHtx1
	YG03YeNsw9QhD+5cdmwgoVC5OJQaFctNvLowOZVLsNcYqMZveFYJ+RK2F5PK8J8m
	gOXWy7rIyat3yj/xahuetaQ7m+K+yez7WYf9gyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gMhf9EXczYOQlVTGeqCsLZtK/m1CIQUrMZeJvLbpzk8=:ygLZNO5aX3Pbd//Vs14FFVUoSpdNxVi5XZEHotjvk00=;
X-ME-Sender: <xms:4kf0aqQtODtAa7C84JR4XoDWqLF1zK_-IFERPyiWCyapJPpcR2sB3g>
    <xme:4kf0amyHS17wcRvqvTwhPBQ7kykwqCFgWlu89OUSyr0P1bRmdS4NABm5Qj2dYCXwM
    QmJ8fRA86Rt_lLrldXiGa5XpN_df4lshAs-abiy9HKt1tOQOFrrDQ>
X-ME-Received: <xmr:4kf0as2-Te_TcIgaa7zN8tvjHIcHv_sZUzM-cTAiSn5ppfajdZVIk88a__9KesAuEfGmgw>
X-ME-Proxy-Cause: dmFkZTGfzRTLBkD/y6dbOsiBmbK2TN3bskxPAv5ojjq/CGULuuFfooeXc57/U5rfyJR9gg
    RrKo+F+bmTiu3GYQWAlYWbwnm/kRXSiAqIWlKrZbqU0TzFwdXjCqVbPAaNy532rl4g8SR2
    CBZUeDmayN/usjarA37KMEyTqhKCgA1TJQuwdlMBLKBUcwulK0GeHj0D2sCy0FuCDj9cmA
    8guHAqKOz8kERZ5N0sZ8eOv8vClF12aXf9d9Bxnt7GBqannFSIwqv1oXN6NdMWM1CcZ1/r
    qeWVlpfcRXY+eU4H/badB9543FtcP24b6I1Ki7qzNIqw/ix6s+DSBikTZq5Hldqi6tL6W5
    9r6A151Ha1x60WCdZlkZ2byksBjKc8mXeYqmLNp/Acj+mlbQgr23CxtrnUFWtLCtpTZPDx
    tpRuudgdLZJHVOUbLXJPOy9zB1Bxfp2VaEnzQO1UC3MM8ZqJ82PG2cFbyb4qnR/Ml0gk+U
    fO4iekDbPngCYnHKQLGxKL7Ke/HnA3t1He35sTAiirqDF/WYkjbZWV7+T4lpfJAcXlVExf
    zSlPVzZngBrYTIQXy34VTYIn9rLu99oUUO+tKZXDzBmPw9Z15LMgT7UFGm1f56muz/L4/F
    TUeOmyhCUfOUnaSN+0Bt7VHjA9+DKnR4EpFh0zZHpDG+vtjo8xjOk2J/s+kg
X-ME-Proxy: <xmx:4kf0ak55okFcQgftW0OFEx2SUIznvY8qPceI9NIj7jzyWnL0mYSI_w>
    <xmx:4kf0avXvUhCcAbqaHqe8rrVSj2K7k-Q1n6HHbGWYP_rPNez3ihOrFw>
    <xmx:4kf0ajCXWHGDaunj987UitUxuLvuMH_xvHbIiSqDKKGLxzfCZE-VaQ>
    <xmx:4kf0au6SuGIwz15W1F5ySJT8pZe8lgDDaxH36ZZCdVofG38RvyYpuA>
    <xmx:4kf0amLAgCRxAe3-u5PXhpYUrP1zr_EXNux3GU64xwfwDc2wX3nnlZyB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:48:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 869e9b3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:48:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/7] ci: some speedups for slow tests
Date: Wed, 11 Nov 2026 11:47:51 +0100
Message-Id: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw6CMBQFf8V0bU0fCMWV/2Fc0HKB6wOaFhoN4
 d9tMTFujMtJ5syZiQeH4MlhMxMHAT0OfQS53RDTVX0LFOvIRDCRc85yaq+etjjeKk0NUm8B6sl
 6ykojVcZB80KROLYOGnys4dP5zX7SFzBjqiWjQz8O7rk+B568vyeBU0Z5UzFZZKYQqjhGcYd3k
 h6C+G6UPxsiNvZMKSlyJmqmP41lWV5QEq5BDwEAAA==
X-Change-ID: 20261106-pks-gitlab-ci-speedups-09c3841eb178
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

Hi,

I was staring at CI way more often recently, and that got me annoyed
real fast because it's just painstakingly slow. So I decided to have a
look and try do something about it, the result of which is this patch
series.

The series contains a couple of bits that are specific to GitLab, and a
couple of fixes that are generic. Some highlights:

  - Installing the Git for Windows SDK speeds up from 3 minutes to 10
    seconds by using tar(1) instead of Extract-Archive.

  - t0027 speeds up from >10 minutes to 6 minutes on Windows by avoiding
    the overhead of spawning redundant processes.

  - t5551 and t5559 both speed up by a factor of 10 on macOS, going from
    20 minutes each to 2 minutes each by using reftables in a repo with
    100k refs. "osx-meson" and "osx-clang" thus go from 29 minutes to 18
    minutes end-to-end.

  - "fedora-breaking-changes-meson" speeds up by a factor of 2, going
    from 35 minutes to 16 minutes. Turns out our SHA256 implementation
    is quite slow with "-O0".

Unfortunately, our Windows runners at GitLab are still atrociously slow
by themselves. So the critical path only improves by about ~10 minutes,
going from 60-70 minutes to 53 minutes end-to-end. But hey, at least the
other jobs now give feedback a bit faster. And I guess on GitHub it may
be a different story because Windows runners are way better there and
are typically not on the critical path.

A test run can be found at [1].

Changes in v3:
  - Document why Windows' tar version can extract ZIP archives.
  - Clear `paths` variable.
  - Link to v2: https://patch.msgid.link/20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im

Changes in v2:
  - Drop the cache for the GfW SDK again.
  - Drop repetitive paths in t0027.
  - Link to v1: https://patch.msgid.link/20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/734

---
Patrick Steinhardt (7):
      gitlab-ci: speed up installation of Git for Windows SDK
      gitlab-ci: exclude intermediate outputs from Windows artifacts
      ci: build optimized binaries with Meson
      t0027: optimize how we reset repository state
      t0027: cache expected output files
      t1092: set up repositories from templates
      t5551: use reftables for repositories with many refs

 .gitlab-ci.yml                           |  4 +++-
 ci/install-sdk.ps1                       |  6 +++++-
 ci/run-build-and-tests.sh                |  1 +
 t/t0027-auto-crlf.sh                     | 27 ++++++++++++++-----------
 t/t1092-sparse-checkout-compatibility.sh | 34 +++++++++++++++++++-------------
 t/t5551-http-fetch-smart.sh              |  6 ++++--
 6 files changed, 48 insertions(+), 30 deletions(-)

Range-diff versus v2:

1:  41c3a0e8d7d ! 1:  8fabb336df3 gitlab-ci: speed up installation of Git for Windows SDK
    @@ Commit message
         Windows SDK on every run and then extracts it via `Expand-Archive`,
         which is expensive.
     
    -    Improve this by using tar(1) instead of `Expand-Archive`. While at it,
    -    make the script error on failures and suppress progress output.
    +    Improve this by using tar(1) instead of `Expand-Archive`. Note that
    +    we're using it to extract a ZIP archive, which may seem puzzling at
    +    first. But Windows ships bsdtar by default [1], which also supports ZIP
    +    and 7zip files.
    +
    +    While at it, make the script error on failures and suppress progress
    +    output.
    +
    +    [1]: https://learn.microsoft.com/en-us/windows/tar/
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
2:  439c12cb15d = 2:  4a4d1e6f2a8 gitlab-ci: exclude intermediate outputs from Windows artifacts
3:  070bef6fecf = 3:  c23b7a7c58d ci: build optimized binaries with Meson
4:  598a143fc24 ! 4:  942d70be750 t0027: optimize how we reset repository state
    @@ Commit message
     
      ## t/t0027-auto-crlf.sh ##
     @@ t/t0027-auto-crlf.sh: checkout_files () {
    + 		git config core.autocrlf $crlf
    + 	'
      	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
    ++	paths=
      	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
      	do
     -		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
5:  a325efbaddb = 5:  460cd0c88fd t0027: cache expected output files
6:  a2d33441e50 = 6:  44c77717749 t1092: set up repositories from templates
7:  bfc93fdfb4e = 7:  d64a61efec2 t5551: use reftables for repositories with many refs

---
base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
change-id: 20261106-pks-gitlab-ci-speedups-09c3841eb178

