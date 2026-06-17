Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7A38D006
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733814; cv=none; b=nZJ0xkKt79JcnIByqbQDOAlSy6GvE9L5gm2VSrpFjlHCE1ylMOA83HoF5MmDDt+HsJTAfqhe/Pq9Gp1WxbUhTfsMrugILiqLGV+6vbfs3fCs1R+LmUbFsccTWhVXQ7rz/35hxKEBxoHHC5POqS5rOK2vnXZil1yVufiRFa6bL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733814; c=relaxed/simple;
	bh=Wak3lQOMzzSxPG/pkXn9qQYQHZZxK5PTM9c9rjxWmpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UoNjv4bMNEAA9ppLvUFRcWl4L9DyVokNYMbkR6cS///yujRlzbNhzfutavwwc5ZAYT9PLpHQltiP7YC1yw9WnnCycvk2CYf+KUYcyEQ/3fYG14Zo6DqFb03yDQHD7u6pZjSulyfE2ziLJvsLjPBXhrBiiQTURLj41yAjtYn/ndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X9THIc+q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyQC+rBM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X9THIc+q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyQC+rBM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2014B1400023;
	Wed, 17 Jun 2026 18:03:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 17 Jun 2026 18:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1781733812; x=1781820212; bh=KXuK9Xb0nEsxXhu73C0YtnAb+dN0X9+v
	MQCNPN0RPVQ=; b=X9THIc+qptzWrFJoyvs3GkV/ARkLq94gwga5XHG1Wwntb3T9
	TY3z2+HWRyYRYFUsF5g8h2ebLMtolqKBkfkACJNtctmW7F8rKjg7hyFwVtUkpyvS
	6L3wAlfu9qHV9XXrj/yjtjz+VkeumMVqW8+Qi67vI+/iP6cqLaHr/mmSUAxmz73b
	ei/bQ0Ic/hYn+NT/V6urxe03hDO9J0VDPGSt7X2im9eQk9baVQlcMoiJn9DzHOvw
	obctjx3NmfOgR6IyixRTzlf4Ct9xO6SoZpTIN1stD4iXY1fyUNP3EGcXBfBQSNwU
	/91ObqCFrlNF9tn9clIjXSuyVWhNsVGVu2+vOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781733812; x=
	1781820212; bh=KXuK9Xb0nEsxXhu73C0YtnAb+dN0X9+vMQCNPN0RPVQ=; b=d
	yQC+rBMEPpytj1AkFCMmY9IeRxp4xZC3v5CwZ0SUBLmGrZ7GXawkCKy/cZ1XTCl4
	WZRoZXXnfIiHNNDWRDiz1s4Q1O7j9FkNB6If7TTQIw3EA6XF5s2/eJED3JJ196tJ
	ZUyQTEulebhAAIZEmN47A9ZXFwT/OxnkbAwkXxe52A7dkHLEwubfzDax5i3XMWdI
	A7HfK0Jzm6gnCQKGYwO/n0tcl91flFFaW23gEcoXa8re0BB9g5y/a86g1dxTbvWV
	pTCEJUZYoRB5w0RoZ156KDnDEKtIpwKsbsTf6uxAmFRlG4wvIj2+hZamxAP0C5y5
	JU1jWNtrPKnFiq//mZzPg==
X-ME-Sender: <xms:sxkzaiziVIphiicGqwoGDsxFxRQf-Z53RQXBpyCfP_0-ZDhjJBMF4g>
    <xme:sxkzalvMuYN5a81inA7qJiHeI6L8EGSUrdHv9kfsOxU3Bz_QEkpND5BmUQ6IAjljz
    QeeVmfuBtdq85gzZyqq1I_TqhK_agMInoI6s6vtvscN-A5KvaSfGak>
X-ME-Received: <xmr:sxkzahvNF4auOEcARYZvmA05WuqG9X7G7Cz75MWvu1PFFxpn8pbDA8F4qZOxgOxZaWBIqxtbWaPdCRRoJ3UJLSpZ6jQS41gJUCg6svIosToBLnTCmW_ypB0>
X-ME-Proxy-Cause: dmFkZTErvVmiVCOrHaypA7drOJFzrg+653d9QHK++aJlBRpPe2E9AHy0C2euwaLpzfg0Qy
    HQLpuce+lr3ieRyzjd+RVYHAIy5ezCiQKdekgytaM8rS1D+PHSwuCdRs02dFMlVYOvMKY5
    BRj36Scp05+xArjt3lgkmIGT2b8dD4P+3ao8IZj4Tc/zZfRIuGkh6n9ka+hkQ/SsECwr1O
    mx98ZWsYVUjoSk1keWGe1Jgxn6TcTjK+unQySq1JKmRSACcIMuYJbsAjX6hS5t1BF21eWU
    ZMlTlZyptbrIP2OvsXKcGjCqDwdARV63NPx1xw9/Rdu+LboQyo/0qYaaFf97M18nGM6TJq
    8186NJChx5YdWp7sMgzHPgyHK2fU866DKKh8UzGoIWwxQSvCtxeDyE5x1/Oe8tzXB4J+l7
    TdsokjyMlMhF8HM/VEX/Cl5VH3a1EuayagyI5/Plv3ZKvebwmPYvWCuz4Aa6uCFdRllcgj
    efs5iPE+s+Sv18dHwEIn7Q4V5VgQiA6e84vEt2RaCqFUL5b4rAK24S0wIr0ChWu+VNjXxQ
    oWXWN4HYNjgGNWmHcjqSL6RcJdUfCC45bmpDSOdj7VVm1BjxSd0EwjEbBjHNibGpsaz469
    jsT6f0ETbTPNsObnFTizNKNf1mnDEwRmQ8KTDYEnwI9EXj7DYsWke+cbTReg
X-ME-Proxy: <xmx:sxkzaiMaF-LHrjnnmPjonjnVG98HRvkYrtPYFTf4k1qk5FdQ9q1_uw>
    <xmx:sxkzan0O9-HcYZhq0RsNVrMtudJf1jy0PmoB8N1iNPiHANJSM4fH2A>
    <xmx:sxkzamP6AvmJRqJ0PQUFcb65qypmml9rUIyvYOngmjHns-1_3b86nw>
    <xmx:sxkzav2XUM4q0dV4MqqMalCotecW7MP4mAhhCwKYYdthCT_OWiLTFQ>
    <xmx:tBkzala0nH6FZOfB9imDDZeCG6lhSaODWbNfZYlSZD_-SAl1F-dxKXwy>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 18:03:31 -0400 (EDT)
Date: Wed, 17 Jun 2026 18:03:30 -0400
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Subject: git-2.55.0-rc1 t4216 broken TAP failures on non-x86 arch
Message-ID: <20260617220330.n6byiFQr@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Building git-2.55.0-rc1 today, all non-x86 architectures
failed with:

    Test Summary Report
    -------------------
    t4216-log-bloom.sh                               (Wstat: 0 Tests: 167 Failed: 0)
      Parse errors: Unknown TAP token: "--- highbit1/expect 2026-06-17 19:44:07.555797743 +0000"
		    Unknown TAP token: "+++ highbit1/actual 2026-06-17 19:44:07.563651478 +0000"
		    Unknown TAP token: "@@ -1 +1 @@"
		    Unknown TAP token: "-52a9"
		    Unknown TAP token: "+c01f"
    Files=1047, Tests=34680, 1072 wallclock secs ( 7.61 usr  1.61 sys + 395.73 cusr 586.23 csys = 991.18 CPU)
    Result: FAIL

The test output is:

    ok 148 - setup check value of version 1 changed-path
    --- highbit1/expect     2026-06-17 19:44:07.555797743 +0000
    +++ highbit1/actual     2026-06-17 19:44:07.563651478 +0000
    @@ -1 +1 @@
    -52a9
    +c01f
    ok 149 # SKIP check value of version 1 changed-path (missing SIGNED_CHAR_BY_DEFAULT)

This looks like it comes from the following chunk of code in
the test:

    # expect will not match actual if char is unsigned by default. Write the test
    # in this way, so that a user running this test script can still see if the two
    # files match. (It will appear as an ordinary success if they match, and a skip
    # if not.)
    if test_cmp highbit1/expect highbit1/actual
    then
	    test_set_prereq SIGNED_CHAR_BY_DEFAULT
    fi
    test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
	    # Only the prereq matters for this test.
	    true
    '

It seems like we could (and perhaps should) redirect the
output from test_cmp to a file (or /dev/null).

But... are we expecting these tests to not pass the test_cmp
on any non-x86 arch in the first place?  Or is this exposing
something broken in the test setup (test-tool read-graph
bloom-filters) or elsewhere?

Looking at some older builds for non-x86 architectures, they
are indeed failing to set the SIGNED_CHAR_BY_DEFAULT prereq.

-- 
Todd
