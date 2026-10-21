Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590915;
	b=MtDRBRC7z7H10ludd0NaBDcDqF5Slz6efmJ/PKW+LPMFYrTaztjm2PYFyuvysybt1Ry1
	 GZOpg6VkALfTl8dvdj8bY4o0pRm8jLgBXHnzbmM+7mSzbvHRwI6hF+JvsIqIDYaE/DEhX
	 TgWoSRJiXgk71ioR71RaC2ICLWXbDKTkpWV8Al3Nrms7TqeQXfvuTiEJ1CfMBmU9MVUKt
	 oIjrJ96GcDptDmSRI94yRQVegCPGId1u1jFf2WsMXHfQtismMRyO+ia/vVVdO+U5vN2a+
	 KyoZOdJdEcszB7oJyHFGdqJbIorAYv3oVoDd1e9HKMecI68l+xYLJRlMBDsQo+cekyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590915;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6SzBSmuXDxaNfY9rXN3A/XqY7ruePvKsCRc4aIttZvI=;
	b=hwrLTQN+LfbaDohACm4BG5O5N46UTwgMVyllaRdnEefesdbtzNdTsvNfW0X/wjKdZ/g2
	 SNjojINt4uuNgGJc6ceF6I16+7qGO83C9/TOFQ/g4R9/MabPkD4iXrgz4t+aBV8JpoXIu
	 TGao7T7DYbM9wQy1dbg4CV/EDKd146VUqrcDDe6NbN+g9azHB6xFzVGh1vW8bHLvY8PJX
	 RVvqNJ4VFkUqSMUh77jZb73IbbHsX8O7WFepnYbVsSHzIElbwlvPkLJi4hhU6iuftu5Uq
	 ctbf0wroAl21R3KbRryVL0dtkuwwWgw7xP8K1U3eeFbxcceAv7N9hcnIUi5aV3XJShg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=GqNP31dx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bc5rSv0U;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12071606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12071606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=GqNP31dx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bc5rSv0U
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75CAE7A0084
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 09:55:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Oct 2026 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1792590914; x=1792677314; bh=6S
	zBSmuXDxaNfY9rXN3A/XqY7ruePvKsCRc4aIttZvI=; b=GqNP31dxZiMEHgDsEt
	H3pc/QZ5MWAA1JLmS4V/jW/h2ZNxQMiQv+zDKxF6mE6FD1pvbCviOdxUJjisCHWk
	ITtU0/pd+AoCAY30c2fr5/b1p2mRMVygMF+5gizLi8bqebYbHaYbYJj+6pEKL+tZ
	UO8HvnQKL5+H0opwjW1ZLLgVWRApI+PUK3VBuHyEJkfvFJXpuRi1r8a6c83bb2rc
	wnDCijcUhspXQwMNUswkTM0Asr98WXNi5h+DtblG5PyrGFHEK3h2/ATGCdbylTrR
	utRNqmpxYSCsjNWIEXeJ9YVahxJWr07wuchWMMVUtnI49ersr1NCOe9N5VtJt/ek
	yrng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792590914; x=1792677314; bh=6SzBSmuXDxaNfY9rXN3A/XqY7rue
	PvKsCRc4aIttZvI=; b=bc5rSv0UuNHj3tRvDIRBjFoNAydEmqRPYrkNgVB2w4XN
	ifYK9H0wdEshhkZj9SAZVoez4+crP4GAxoGt3O+c1MuQOvYQISpxq4ADLiEM8GJ8
	I4As2+FYVLAq1dPTfIhHd0aI7eZhgt5Rl0ZZNBxNB8bQcdqZw4l0xt8O/nEBnn3v
	t6yW4oOL9WJJiktZjg+hOfXSyk8BMgNna982ADXFrZ/hNux7hmWBdQFAt9vjMZI+
	849RsrKxbWSK1JgtLko9g3VcWIQzBT+RB3EcvkjCLMo7jN10My8HkKDu91D5UENx
	SA2sPMBgAeYocjhID43PFXWQcWg+qCe/kQ7KvHb0mQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792590914; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LMLEwOGBW0hWCwxRp+J1O6q5sr24dhL1tt2nznPNT4ZJvyr
	qwqc5VIdvJQfCzn6DGU9ATXMiMhwRtcJ+k2nr9OSkUnnLt8brdrZWXMxNw8xOly6
	s1FXrLwzE8KH7eOalK3fOIrzDqAvcRCM3I/4lCjRMOAQRrIr+N5FVkuMWsCrHKFy
	+2lSlygjoZ3orDID40MKcAGl7DShclObwQueHAAGieCxvktdQh7sz5jvF6xmwits
	gBxClFK17uJ77GbH01MT7uTdaEANowGSVCCzEbOx92EQqtBj5gCtvlLZp0GBOnlJ
	zKB3FTqGsf3TstyYaHjVC883Okc6CUyADlsbAHw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:Z0colc7Pp6JEc7yrcvTsZ3vfgN61ITqrmvgt2uqBsZI=:oeu4g6wJiAC19EkMBh60Plj4JUUJu3+WwyseHyl9Fh8=;
X-ME-Sender: <xms:QsTYanTuO9cijbcVZRSNwILv6OSQEvGPUy6DE3brD3e-adcKNNRd8w>
    <xme:QsTYauxeRMAIuu_Sed7ldo6luooUyMef30EZS9l1Y0OtcCqyY4FYj700M5LgIvS_H
    djS1JKz6-BQfTiajtpGVd26E1FVcwAnYU82Ij77dV6ZQZOgIqCJWMfz>
X-ME-Received: <xmr:QsTYaqdoPaigl5IjuWqFk3U8xFRv9szs2YZ_ItZetmvF1G__6PRg16DLgBbpLrpefmU9oNYHjT9gwkWL1vg3ObwKhBVf>
X-ME-Proxy-Cause: dmFkZTE+g0yXbCwZXQ6WP/efPQNHSyXIMxPirWqMMIwK3eKRZBmkgbvNt/JvsVyQ+a4lnI
    BQc+ttHSdsO90jgDyxc9TKAE8sSngDPh/CjyZos34NumEVE28hNsCT2U2/dkybh7eBmpUO
    TY7LF6W/4BuqMaPPdp6XdGugrux9l/b5gPoXhlwJRu4Q/MFGLZCQH1g1EW7RxB1JH02Lao
    RKHmNbNpbjHsmFJjBn0dwEEBoOGycjKMq3WvqkMg/WoEFekt1FcVMJ5mjDgJDx/8f7Mgal
    kIOmnfJcVCH4lDy7D1DgzO+v4ePTkRv6KoVf9GX8DSUBtEkhN57dp8YLtPgRYnTwCtP0U1
    nksObLjKhEZd6XPSh5PZTLiEb+G1JtkMFZf9zdLKksYN815VOQ/dimzTvAvkC91ykZ/coE
    jyNdzBVMEXrNZnc+25wq3VaOheVqGV7FO7Xyvlv2YyYrK7tuLyXJ2B0wTjLnPsBvUn1GYR
    j326h0g9krNjQ0MeVeT3AtlP2nR3glLBEhBbqObZs8a5QsGp8jCYUUFGSh5bP8Mdacm1pb
    pcFVdZhFe15NL1FqlD5m/deMa9EEiMffjsrSKtke50H+FvpkbvU7dU62rJYi2sssL/wfwL
    47k65UXNjFRZHb42/vTyTcD8U/ebN9FFEcOB9VLV6XVkF7IPS84qJ/m8Cx8Q
X-ME-Proxy: <xmx:QsTYaiLi-UG84CVQbsOzO4iE6QZWx-riLMZmb5NYnupW6-d2z5iRgw>
    <xmx:QsTYajFSrnVqjiSgraQw8HQCkPfj_0OM1S-wokXMOaQ2gn1joGlSYA>
    <xmx:QsTYakrw1Jk5o4uLQCBRgy8NNpTpKTHavJ1fV8n9v9EIJk3oHW14ag>
    <xmx:QsTYakR-WVvJetfAckjvMiSJHvDOSnKrFjAqLaT_0skhIdelMxhyzQ>
    <xmx:QsTYaqpGjROBE3GKbEGoZLpqTU41rfCkRrNCkga-VA32HqCTxZYOpSyM>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 09:55:14 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH 0/3] repo: add degree-of-concern reporting to structure
Date: Wed, 21 Oct 2026 09:55:04 -0400
Message-Id: <20261021-b4-repo-structure-concern-v1-0-e3010552292c@fastmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ7CMAxA0atUnrGUBIhUroIYqOuAGZLKTiqkq
 ncnwPiG/zcwVmGDy7CB8iomJXf4wwD0vOcHo8zdEFyI3vkRpxMqLwWtaqPalJFKJtaMyc8xxWO
 IbjxD7xflJO/f+3r729r0YqrfIez7Byfk/Xl9AAAA
X-Change-ID: 20261019-b4-repo-structure-concern-f1d6f6326095
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=oeu4g6wJiAC19EkMBh60Plj4JUUJu3+WwyseHyl9Fh8=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJuHLG39ysOyjspfeBUe8E+Dm3Orri/PRoRU1x3Xuudp
 fqzNelMRykLgxgXg6yYIsv/fwKNr1geSPgFvfsEM4eVCWQIAxenAEyk7zIjw5/2jol7TAQ3zI3W
 0J51s/nH6QX/k9U5FQVealZOz926Mo3hvwtn5JaDJy5MODHD56NgZ2S6SnmPw8fPoQcfVl7kOhb
 HwQwA
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE

"git repo structure" computes a set of statistics that are useful for
diagnosing performance issues in a git repository. But for a typical
user who hasn't encountered any issues yet, it can be difficult to
interpret the data - when should a value be considered concerning?

This patchset introduces a feature to "git repo structure" that reports
on how concerning certain measures of storage structure  are for a
repository.  In table mode, concern is displayed as a column containing
a number of stars indicating the degree of concern; in line or nul mode,
concerns are displayed as additional lines with a numeric value.

To select defaults for the thresholds where a value becomes concern,
a (hopefully) representative selection of repositories were analyzed.
Based on empirical exploration of the data, the measurement that seemed
closest to accurately assessing when a repository's structure becomes
concerning was based on the base 2 logarithm of the value. Across all of
the sample repositories, for all of the measurements, the point at which
things become problematic was when a base 2 logarithm of a value was
more than 1 standard deviation from the mean of the log_2 values in
the sample set.  Based on this, the concern threshold was set for each
of the measures.

While this seems like a reasonable approach for setting default
thresholds, it's obviously still very ad-hoc. It's likely that over
time, the default values will evolve; and in the short term, projects
may want to set their own thresholds. So this patchset includes support
for configuring the thresholds on a per-reposiry basis.

Overview of the change:

* The first commit adds the command-line option "--concern", and creates the basic implementation of concern reporting.
* The next commit adds configurability for the concern thresholds.
* The final commit update the documentation for the command and
  configuration options.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
Mark C. Chu-Carroll (3):
      repo: add level of concern reporting
      repo: make concern thresholds configurable
      repo: add documentation for level-of-concern.

 Documentation/config/repo.adoc |  60 ++++++++
 Documentation/git-repo.adoc    |  27 +++-
 builtin/repo.c                 | 335 ++++++++++++++++++++++++++++++++++++++---
 t/t1901-repo-structure.sh      | 134 +++++++++++++++++
 4 files changed, 535 insertions(+), 21 deletions(-)


---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20261019-b4-repo-structure-concern-f1d6f6326095

