Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356231;
	b=Kxym8cQhisBDL/fuTwkfZqsgqH8m95BKPFJ2lDv3ns67v89g/31BtwGv4yzhbEoQ/kJc
	 xr24c4JNkJKQ29/NxU+gvWQC6h+D9g48xW5NyTJgzKjH1E8VRTwPoWNNwUfhrrQxROaoZ
	 C/rKN2ndcCBmJjF4UAt+RXBWkAFWk4n+DjS4/nEQnM0Xvr5DS8xjeHJM1B0n1rrxs5USC
	 Z4Yq76BOuXiLf56vLil1wroKlvzSBFY3wV1DM6dahNuHOJRud9e8wSgzFJrIoSPTm4qqb
	 DUchODOqYREqBsfU8x3i8y7qWK1uq67RSlwl2lp3zBA0bH3MvDPmFEDyucmAd8Fpjjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356231;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=arrrYtOakUIDUD5PQplM8OOBFcjyegn9kR+9IsdblTk=;
	b=lzI5sGhnVzzsJL9DtGT/8ILAEguABHbffVb4HzXsuXczlTVkdeWFssu1gswKfNuAbfLh
	 Xf7yfrOlX18+MrGEXyWLbPwz2IB2Ueb/DPxrM7l0ipOMuHZRVqlJ4ZF4CZH3hvMc6HhKI
	 cwKRZAVicWuaql50ySAvjwqYAVZi8TQDSXi8hzw5cjY8c/YLjAUVnBfBnjhsgMTFYKBXA
	 ZVL4+8tsPM7GE7k0KtbCfsT4FMh7ozIRZUvYs6qEkmEEbQ1qmOIqALiWYi9ZBCjvj5Fn3
	 1e7yZpGFsUoqME5byxbVNzBQN0k5AthBgOne1vaMFQf3Idz1K7wnOIaURsLfpKNvm5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XoQfYbct;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lUvGlTLK;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB8606A32A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAAB8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XoQfYbct;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lUvGlTLK
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A04E31400247
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:03:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 22 Nov 2026 09:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1795356229; x=1795442629; bh=arrrYtOakUIDUD5PQplM8
	OOBFcjyegn9kR+9IsdblTk=; b=XoQfYbctKOnV5fKzXMSyRpW2OkASUDlyVPAsv
	mbo919aFkatWuxvkjKwTgICsZPGIHJg5AJLlynGbhK1J8xyXcToT4I1QcWYJjBV+
	WJ3rsbLWBYFCe/i173fwpU+jCiw9BiySSmRF5D5r5uW3OcloHUj/CF92v2i5cHw3
	F6c8Nj6NDs+Q80jk3RA5mihvwT8hDNcUoPSo1w9egeT1jWKL89/UFwD+yGeMakB2
	qP3QLPG+apy4k87AJna5knlYQcBWLbshJxOqFU+o3eEmxWq+KZxmSLPrXeS2PUPP
	88Iv30KSyXD/XhjgR/4rg/LoCrAA1IRZZJbS6rXtCiiToV+Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795356229; x=1795442629; bh=arrrYtOakUIDUD5PQplM8OOBFcjyegn9kR+
	9IsdblTk=; b=lUvGlTLKWbz1coc9ejXJP6TZcRJbJGU+XwqDxOlYRsy1/E8Zsw1
	Zc4AMIcMTOYcCtwtNco3uD2I1hP9iOtsL/VUTnSu1ELf7Qntvl6t1M5dI7xvlY7p
	4qkTfSSX7n3w5kTZsSXrZ6VzA/rwKk3ACWO0QYL23NFG12kXepO9PjsCmZH759TI
	G86ACi7wiXuqwsEf8LvD3D7XVvER711lmp0fQudiS+qYZ/0q4ZJYPRt3KyvPNgDY
	wjyrqNUkA0SRavfnbUWdezaJHt4Bc37CyxOoPxH/emVlMd17k3pwIFr4SkJyzYID
	st1G+6YLKx/83QQ++/qlUdHm+9swVjbodPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795356229; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ju83m2DSWtJEIy5iSO72RLG/puS3ZGZW2Z1A+8Qt/FMwJFz
	UlglVoAIbv6Yo4Ew/gZacTUXP2x9qozNkmE26Hr3HPIG+A94rXgwhaXlSJgsUArd
	JyRiOIuG+EvBPtOdbD9YkcsSfm12ApmAKXuHSeyPB3xfLPrf5DLOdQ4PRbYrHyAd
	dLMMn7dRv7+Qwkak4GF4LkmS7oZdRYK9BriecUx6Lj7JoAn44DzCq/fZ8wKhWXRr
	PI294Og5IMLzbttMzSkfJCnfxoAcVuCzMsop8deABIXuAwz0NM7GEb8uPiS9fZMB
	iGeae7a+d+1MEmJuG0kEF2c50v7GbEow9IOtAkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=8;
	hn=content-transfer-encoding,date,feedback-id,from,message-id,
	mime-version,subject,to;
Message-Instance: m=1; h=sha256:sH8oapzkHBNXa2YRKoK5kIWqacgN0Bei4otRiYfZI68=:y1K3xtN4Yq9t/s099wggyWRJ0gZ/vwxMNozpSL5A90g=;
X-ME-Sender: <xms:RfYCa7lT1fz-K761aHVXsv0ylnR9Rwe1l6efvKt3cwjCnhg0FX01yw>
    <xme:RfYCa017LMUwn6rNDkPDefKPbd7BLSPy-BlIZH5gud2T9u3xWixBsh8uDFJxcOHCY
    xG77Q-ViWdySU_Gcwgo4io9H94BgNWjbu17G5neSywqlXQAToH_OIY>
X-ME-Received: <xmr:RfYCa_Sj_I8NEW_Hm_QMHiOIR7id9Jo08p2tCVzToUYR4_a3L3XMIuTdV7CtQjpMgaih5dtjPxKIvmEiRoj4RHTJ9BiOxX1eXZN_VeE>
X-ME-Proxy-Cause: dmFkZTEHVJkYiriZab3BDUKw6bldqP8x0RwUuAkq6HTvSqV6EJyqVJkCJkDB0xCrvZFVob
    cWWOBhze+Nztl//XWAeVODL2B4tesUH2tNE6QlUhDJ1m+PPOwA40CCIBi+5DXtuMANxIGo
    vdW73yl0MTrms1k/fYJf52GtsYiEXN1N5kIWpk+a8VqADYo06QbO6ybM8QXoLaqUn1jxZz
    OJnszSR+7d+hWNQlkRsBCWuF/I70TeMXY1NBetUJcojCoTANeeY4831mSSvpk3qtC6sjxm
    tYRsvi7wKCUhMgjg1kpS15BFFwVdzYGw3V6EIhyWQ4+Nn+ZSSLKNsXofMn7gFNeH0NuaRZ
    wppdoZ8LYs2T740PeyMtczfofeX/robOvUK4/c1O0ozHE+mJcpiI2mzSsIgIjm+ngC+FCU
    Nx+jdS3IUR3BIDQx1caeBk9hypTUfV9RJeuRvO5BI2ieaAcTsFb/LXAaNKVr+Q8IMPbLZv
    J4Owr+P+rtC/KszJnhqm6JAF2/GTObdxKs604w/uwiIKI5tHa8LJJuwWp5vbZgeiLIFSt6
    DEKTlrb/+Jd2mXe6S8HHpBbIzxxpEv6B6MRBLu5beqVOQhwyTPWjC8hwjjiUPfmSBP6Gak
    A+SGUfM0SXSGxSQQPPn/9pFy7/A8T2JsNrAJ7o/BmcwBrB1ggTeL112grLyQ
X-ME-Proxy: <xmx:RfYCa-tPqS4CpA_A0sUNWu7dsyA5P0eLXvGYEbiHseaT_2m5YoBZcQ>
    <xmx:RfYCa8amTlyI-CSj4AzkIQ9CDoi-7VBtJBOc2g88dkJy4P3MaF2ggw>
    <xmx:RfYCa7vRcgcFL-xFejnObnCUrZCNwimRPkOwtYF3FAY7T1OSWYg1xw>
    <xmx:RfYCa2EBSrI3bYcrKVHXqt877NLUsnpBJJwBy1A-fuvJsmYZARGDnw>
    <xmx:RfYCa2-yozTBEZi-SRj1m2PSOp9BD0zi9fDLjXiAQr3l2LBFFjFhYpjn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:03:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/6] getwholeline should clear the buffer upon EOF
Date: Sun, 22 Nov 2026 06:03:41 -0800
Message-ID: <20261122140347.41990-1-gitster@pobox.com>
X-Mailer: git-send-email 2.56.1-766-g80003c9184
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series, which is structured in a somewhat unusual way, addresses
various issues that are caused by a long-standing API bug that the
strbuf_getwholeline() family of functions shared for quite some time.

When they see feof() on their input stream, they immediately return
EOF without reading anything (which is good), but they do not clear
the output buffer.  It is not strictly *wrong* per se, but it proved
to be a rather error-prone API contract, as we see in the early part
of this series.

Patches 2 (shortlog), 3 (clean -i), and 4 (fast-import) explain the
existing bugs in various commands and add test(s) to trigger the bugs,
but the fix is left for patch 5, and the fix happens in code far away
from where these bugs exist.  The usual "describe the fix and
demonstrate it with new test_expect_success" pattern is deliberately not
followed.  This is because doing the usual thing would force reviewers
to understand the details of three unrelated commands illustrated in
patches 2, 3, and 4, as well as the solution in patch 5 at the same
time.  Because the code that caused the existing bugs does not appear in
any of these steps, the log messages of patches 2-4 instead give
detailed walkthroughs and are rather long, which is another reason why
the nature of this series discourages following the usual pattern and
doing everything in one step.

Then there is a bonus patch 6, which illustrates two additional
issues in "clean" and "fast-import" that cannot have
test_expect_failure tests that are safe to include before the problem
is fixed, because these breakages are infinite loops.

Patch 1, by the way, is what I posted elsewhere already.  This is a
caller that implicitly relied on strbuf_getwholeline() not clearing
the buffer upon feof(), and it is fixed in such a way that it does
not matter if strbuf_getwholeline() clears or leaves the buffer upon
feof() so "mailinfo" keeps working before or after patch 5 of this
series.

 1/6: mailinfo: do not call handle_body() when headers end at EOF
 2/6: t4201: demonstrate shortlog reusing stale buffer on EOF
 3/6: t7301: demonstrate "clean -i" ask mode deleting past EOF
 4/6: t9300: demonstrate fast-import re-parsing heredoc delimiter at EOF
 5/6: strbuf_getwholeline(): clear strbuf upon EOF
 6/6: t7301, t9300: test EOF loops fixed by clearing strbuf upon EOF

 mailinfo.c                   | 18 +++++++----
 strbuf.c                     |  6 ++--
 t/t4201-shortlog.sh          | 29 +++++++++++++++++
 t/t5100-mailinfo.sh          | 18 +++++++++++
 t/t7301-clean-interactive.sh | 31 +++++++++++++++++++
 t/t9300-fast-import.sh       | 60 ++++++++++++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 8 deletions(-)

-- 
2.56.1-766-g80003c9184

