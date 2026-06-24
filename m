Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAA3AC0FB
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289414; cv=none; b=t+TaHi91zxZcCUXp8jrrMkdLG7JYt1YMTJLGRhrj5Rpz2C4g1GGb+rhUJ3tAigRlJCug9VSUt7fXKfzyk9nKl2CFrg0fumgZ+4FU0urr5vONxZFib2HGoPQsqnWNeDkzHr7UIqfVn4lKG8V6f2cPgVjcfK7m+JMr0bKekj2QGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289414; c=relaxed/simple;
	bh=XUDW3d1v9xe/eghtNsH78k7k0lTw42ogvYQiSVt88Mg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HCM2sg2HrXy1QkzIdV+68siPWXRfubnMLmo0S7rnGs3rF2S6j5220MtiseggvXtiHwRvyiVQysrrlrjut0NtpajOsWbj+aXV7asqiv6haqJTZCG3KSo4YnKv5LaAs83crT5IApgB+uhHar7d/BFZzXGLbKGNeyYeyRs8gXAiSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R/A3Ml17; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFwdjPwB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R/A3Ml17";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFwdjPwB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 211A17A01D1;
	Wed, 24 Jun 2026 04:23:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 04:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1782289410; x=1782375810; bh=vQNJReovQL
	YfpPqSpBAb5YB3JA8bi5Pvm/YJau5amtw=; b=R/A3Ml17bZ10p5TO7rom+g89ip
	pHbV+rWCBgfDoDzCoTTdskSsMKSCe/nzg6es+mrPquqM7cBdst2S9m/OIuPHhMaq
	cfQ4x1wVn4YdhDGTDYqfwU6zU853cPlCa1bQP5ezw9dcuEf9NpZ7SAaiEBG/kqjF
	sb3B3Y2jJDn0D9DFuoyn9x71WuemvBpNmd5K3e31AjVWfczBlzMCOPny0FKbCSlM
	0+W5LTQ2VP9hQk7oq+CHKkisbxqDmr14Qn/aZ9hHlnzGlEsGtxfwuU8YjBMykuyj
	1E4tgRiRDW0EeO8fRpOK4igvpRPRKv/euiTFYGDocy+nuEygHp7799sHJbUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782289410; x=1782375810; bh=vQNJReovQLYfpPqSpBAb5YB3JA8b
	i5Pvm/YJau5amtw=; b=XFwdjPwBv4E3z1ubLGaPa3ti9a1hrK4eXcRlisE+brKj
	fRq5JLAVhlNL11N6fRjxMlBP0FNK22mVR1ZfVnPNXXZIzyt9gBdVry0khLYxhyKu
	80/M5gHf+DCNYGwOeygiiIvUegx/SedPVpY9End17/HswEHjdmSc1e0TrzDzxUVC
	XJcCNcO+4VSpP6avMO0aNQgbeYI22bE5llGG46W68n8qXZ06OP5KjtxjMWWnSUaS
	MKgPlB3Qvrqkuk55yIkorv6FBKjvK3bd29Ojw0Syaduiu2Q9AXV5sREKYImHHDkd
	EqcLgfi9/kYgY41QgKx/+KDMeBIsPFCKrKCe0V28Tg==
X-ME-Sender: <xms:ApQ7anrrWPyFFsOlsKHVl2Mj4qaHtAyyiQ3yp7ARPDu2jm3sbVgCzw>
    <xme:ApQ7anp-dw7LbKDganekulEq4jSJuruMMkA6EhdJK8pIjr5L1C1xoAnQzfdurQXM4
    d0XJmXckGv8dMI6A_QjO4Hgiepkw8NRodWThRfANipy65FgBwnlJA>
X-ME-Received: <xmr:ApQ7ah1sQx34NF9xrxxI3X8OlEY1DmEjQoDPHYBKc3iJnaS5iccqYkrZRPnQAuH-ofkXs_qJdGdNKNxXCUtHWiviY8sEjvjcvLkfXE4Q>
X-ME-Proxy-Cause: dmFkZTFSmcwe+fA7ecqzdsMeVoo2yXS8muZRUjG92SgfRfsi1GbJK2uH/oEGODtkFlsLiB
    rUe2Po5V+y7TonQEGjeaHJ2tnt9ll0Ql6jXEa507NWC9cX323Afv09EfovpwjyPQn76DM2
    OKBQhwyVT0ZRrUwlZ7c+qEzz4+J6r89wbLm91OuuQMHA6vmeAXe9iVRhvpLynIl3u+QMNu
    8qsfuXKdZbrSOG8kuwPCaTSMXby6VvjxCMQnb/ag5IcrD6naFgJuPz0soWZVoNUF+1+FHc
    aXJBpyru4a90o4QQSb24aiGv0Al6TyRdIxtIp+BfTrBRYNuyAezixIsoqgv4YzOKdGtKFP
    wWakEkpjIrequTnvpKSolzz382kWgSUhRv3cWeUUo2gqqNaf3sB9pUYWl220aTHwOHQnbN
    gOZLHGp3wazwMtKpzTArL3LpEzMsHcr5he+t50SZKxVCWa+vuToQA7WEcUmwo0WMgUM+W5
    EaBrT3u6QdzvGpOAt5oqaWggUdt7ytQlk5HEJve14xUSvLt9XmDm6O166BxZNpywzi4ml8
    iCN/pq6I1MbrgD0tRcBBTyYKkz7p2iFdhouPe+mZR/4+TLaepYSGvqkz3FUPG19SOhviqR
    3EqEemqoPFfjv4liSnA5MgjE/I7qG0wVDxlyzSxVEjt1D3sACar+me4T+VXw
X-ME-Proxy: <xmx:ApQ7amBfbQFRlOlL2gCtI0Yx-TtOBzur-DKAwy9HF3jNQm5iLxsOgQ>
    <xmx:ApQ7apdZiPWlJVwhvjkpJMMLdPkfc60SQ733ZoKrCzOOTUeGs94LqA>
    <xmx:ApQ7ari6VzJzoLTBUNCRDPpQ4w4wpKexYcXMOXFj_1VGP0Uik8KzoQ>
    <xmx:ApQ7ahqDUM403o2xe9eeBB6HrjR8-3LQojRo2A9t2zRpvCHlqsLM3g>
    <xmx:ApQ7aoG-yup9erloVDEIhkSALxskTLPpSXBjET1d3wx7JI8lFs9Bb0S8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7c88a1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/11] reftable: harden against corrupted tables
Date: Wed, 24 Jun 2026 10:23:03 +0200
Message-Id: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOeTO2oC/yXMUQqDMBCE4avIPrtgow20Vyk+RDPRrZJKVktBv
 Ltp+/jBzL+TIgmU7sVOCW9RecWMS1lQP7o4gMVnk6mMraypeZmUE8Lquhk8uuQRJQ4cro2HvQU
 4W1M+L3kjn1/40f6tW/dEv35rdBwn63oo5HoAAAA=
X-Change-ID: 20260623-pks-reftable-hardening-f54de69fea63
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
X-Mailer: b4 0.15.2

Hi,

this patch series addresses a bunch of errors that may happen when
trying to read corrupted tables. These errors include out-of-bounds
writes, out-of-bounds reads and the ability to hit abort(3p) calls.

The out-of-bounds write was originally reported by awo on the security
mailing list. As we never transfer reftables over the protocol it would
require local disk access to create such corrupted reftables, so there
isn't really an easy way to exploit these.

In any case, I took that chance and wrote a fuzzer for parsing the
tables, which surfaced a bunch of issues. At the end of this series
though the fuzzer can now run for an extended amount of time (2hrs+)
without surfacing any new issues.

Thanks!

Patrick

---
Patrick Steinhardt (11):
      meson: support building fuzzers with libFuzzer
      oss-fuzz: add fuzzer for parsing reftables
      reftable/basics: fix OOB read on binary search of empty range
      reftable/record: don't abort when decoding invalid ref value type
      reftable/block: fix OOB write with bogus inflated log size
      reftable/block: fix OOB read with bogus block size
      reftable/block: fix OOB read with bogus restart count
      reftable/block: fix use of uninitialized memory when binsearch fails
      reftable/block: fix OOB read with bogus restart offset
      reftable/table: fix NULL pointer access when seeking to bogus offsets
      reftable/table: fix OOB read on truncated table

 Makefile                            |   1 +
 ci/run-build-and-minimal-fuzzers.sh |   1 +
 meson.build                         |  15 +++
 meson_options.txt                   |   2 +
 oss-fuzz/.gitignore                 |   1 +
 oss-fuzz/fuzz-reftable.c            |  74 ++++++++++++++
 oss-fuzz/meson.build                |   2 +
 reftable/basics.c                   |   3 +
 reftable/block.c                    |  39 +++++++-
 reftable/record.c                   |   6 +-
 reftable/table.c                    |   7 ++
 t/unit-tests/u-reftable-basics.c    |  11 +++
 t/unit-tests/u-reftable-block.c     | 186 ++++++++++++++++++++++++++++++++++++
 t/unit-tests/u-reftable-record.c    |  24 +++++
 t/unit-tests/u-reftable-table.c     |  91 ++++++++++++++++++
 15 files changed, 456 insertions(+), 7 deletions(-)


---
base-commit: ab776a62a78576513ee121424adb19597fbb7613
change-id: 20260623-pks-reftable-hardening-f54de69fea63

