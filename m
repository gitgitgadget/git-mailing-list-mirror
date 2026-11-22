Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356233;
	b=DrYU0jdceu8uOI9WizGH3aCOhDRQHjyA7KXEVVV2K4s3IDfgOycBICwK0FMVV+pTkhs8
	 /sh568LVZDXTKRQAD4+XrgqIUntRcbSM30zSsr4clKRr7CmHT1o70hBdU7d4LGIE1WM4E
	 0Q9m29yFS82t7MHuuzZKQY9Ci2mOlgBK3mmyff4t2OAPiLbASmxtuZPx8FXIazFHufS2H
	 AL45TzJFufoMu37s2smizK5v+owBD36FBT0WMS17mTXkfNuI1oO9PuEWanAcfpmsTUCBP
	 Jj8lZSASfz2AEp51MCofkDfx8e8GE1Hg0Mz+5/h7zRcnZSev7b/u6wFCq+a9Ul2Blnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356233;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=SnP7VcbstiRMZlyj1V9xkLNqZPKPLmZzACFNMsJx79k=;
	b=hCi/yT2ITzhY1+gbNNYFMkEakeEq7/PfXYXIxVQ2A4WSkmwT+KvVda5P4RltAPxkUOJD
	 vwl/kZ5hc/wzMn41AMsuKyFwgRRpbLqI6Z6en3wwqO7A31QjNNWxL4XEtYrLexk7Uhp16
	 15v7LY9XNu7iYZuAP4qNXeU0LiSQYqPhqsm3DKupkW2ospCVE+1Gc/YHwn8012bSl4eC2
	 c0Ia28IrBzb7NCkeU2+G+yodaMgjKDJBRVI6qf6QCCjKAxMjskifnEooEjmJO6bylesII
	 bwNAJB5mmq+L1iBOeb9eplPjO/VjFDdIqbp8GoS1689majsEHyhMsetMyhjctBIvuJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TVJWbVpz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="q79csTD/";
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E4606A330
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D7E4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TVJWbVpz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=q79csTD/
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64A0C1400247
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:03:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 22 Nov 2026 09:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795356232; x=
	1795442632; bh=SnP7VcbstiRMZlyj1V9xkLNqZPKPLmZzACFNMsJx79k=; b=T
	VJWbVpzTHT3850MOS5DjvThcaccaK3rG50cEkFhec+5/9sWjySCh1dpYROAkTLi1
	uYHzHhblhHCX0nTNUgCGbZah6L0bOHN9jYMqUL0JRv/Myfo7upvKD81lxnnAy542
	Cp5GiAVY5DwNv+8IUjX3ibr8gh53kKdYPCJ1cQiELcwSN82Z1+fN6JSnLFkti7wa
	zKdQRAO1hGISBZEmfMXY1mTmKCNuKbOUAV/f2RvrvqrRpwSRZHQoXrfBjUJ7YRva
	v1y89ByoF8o4I06LXbEEwJbuhKT13mNe4ceFNBERdSKL9wIrm1gbgMWyJqtmhj9z
	dCs0DfvFUn0Lksn/KcXfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795356232; x=1795442632; bh=SnP7VcbstiRMZlyj1V9xkLNqZPKP
	LmZzACFNMsJx79k=; b=q79csTD/3TQT2kYsYtt8BVQAMzUwHgWT7HENHn6KWeTH
	/CE6JV8NZjRunyg9dgORHpjfFsLoY6GVaXkOp0zshjt0fJUkOHxLbAaP5LPl7xJq
	uh25UcE0L/5FiBg7/Z50bQ8/44wSm82fkRgrBLaMvLgM2soHEvMZOT0XMd5LYnDM
	jR6FGm1sV4htTc2VwatcG5RyabAvwuFwEvO/OCJFaqpubqVZfNqkaLpM2YkYwbcG
	fJJdZz3EjesIS/R4LylsGa2heDxM419q+0W15nyWr2SHYy+gezTqFMldCuJjsK+5
	QBjy+lECpVNcGrP/5NP04PXr7uK7Rls+3kvaAWVFZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795356232; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:J0ylt232fZwE3aE9Leh/cSR7a5UBOKYrvevcGgyPg0sHExk
	6ayhSf0gZSlGxn21bJIOG3RnVUMFYe9Mj5qxGhd9BQ0J5x0a1LaCfgzSQOfb/Qwf
	Wlraa2hW9vI+kWVo5yHXEBXOWYgAHlXvUS5nxzbJzlwoPJzhJD89CVNAsfvxSLB3
	+5+zQkpTgdcIfa5Ckq/+fJO6SJ5GMIEoA5H1bsAaFVXnCsBFw3zIIAIjbtclt7DC
	RBbvG6LlXdaaU6A5YscO7Ou2YgQ+bVxWUfDglR36fCPI560LruvVzuiMeEmhQZIw
	BIABSaidj2jGIhehFjZrRDVDK/VNjW7KISzue3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CFMR9RHl5yRdc70kPjlHXa2j27kewV0sLBE+6XQAYTs=:BivumUMutwqFc8sAGXD7RezQtIcwxu3pKdxAgyDBft0=;
X-ME-Sender: <xms:SPYCa1lnTXb_VdTN41h11heDx4ecDay27m1gdeIWep3adMOu4aobow>
    <xme:SPYCa22WbjaOU-DIzWHtnUJzQvMvX7Rt4s7sg-8cfc3G-zxLYcpHoLfsgmm4eWx6Q
    li3lWxhgrw49xcpxqk-hsimUTt-UtxfKYxLc4tmislQBjoIaddsUQ>
X-ME-Received: <xmr:SPYCa5TwAO_7aAT_M4yIA8MJU7DMUF2LnstKXcmSYQYMJpY3gpy5p0jb9GqPT93esvWVwsBdRB8Cdn-Ol4DRweO0joChnwCJ3wgyauk>
X-ME-Proxy-Cause: dmFkZTEEfhghC7UIHFAvtnexDM+6PUjQt12sDqIrkr22qfROelV7GAL/pRsKWq/hlEVkq3
    xfZy6OOgLSRYXINfNnmUrF9J8XPDqU+fINI70NBZJVFQjUYWsBMuICN5LADN4jpNO+W4ZN
    eQKNUwGU8K56RoBf95qHiDGAq/LSwrRLkb4gmQVY+R4Uymu3SWSJNTNQdcu4SycPJv8So6
    qipCWn3kaoKlHwv2eQ3uVX0expqCWD7IBxpjO9hBN7THRCnJy9CYzlVKKIwWYXAmWjJXPN
    O7Rh4Q3DI7Vk0S8oTqalKcwIaFNoTcbszrC2qxFyv4hrEdTWys0R3derTSOVbma8kTIAIW
    cLMmDSue/GlTXxlGFPVc/zjnxmD/KvGJnNmiolraZPIHjVbvd4E/6EK45J4ThtakKFkFwH
    EBdkzkDGWeccNyw1V1+6iYR/8Wp2lR8t3gTU/LEsgzPS4V7AMoSe3QNbZy92CcDRyuDU8y
    /+VGQb+tTiVcntELgSb9vPRplWyjOXzmQnSuFQptsrq0ZNh/z3TFEVEbO8BtsbwmFgfCk9
    tD5+8DbQV5B4ZBSiAtnUgs/rKHJB7bDoyHTQNVZ7jfZfCyc3MYPE4BaRPxQDeOLAJVLM5y
    kAvwTDnifOjavMJgsuW3CMbEOyMYUEMASGZmPEzmXm9H6ngCUY4KhMZo2tjQ
X-ME-Proxy: <xmx:SPYCawuw1eNSrMRiGGwUtOnDZdy8r58cVuLZ0X9HYK5UK4xSGPOdwg>
    <xmx:SPYCa2ZUELyGDN6CibxACAedbd8uB32nnggWH2cUak2MXTLU-hOQFA>
    <xmx:SPYCa9t-Z54ksgRLoM5rBQMdyG2QFjbLKytOnbfkhUSq1uBVkPX4iA>
    <xmx:SPYCawF4giV1HGo823yp97XO2kVj7h80VRbIZY4bz1zWwu94FuEOEw>
    <xmx:SPYCaw8WzjYh5kcp7tN_lLiSQVfhkp0e73fpHisn60MrHAao7TqY5WWC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:03:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/6] t4201: demonstrate shortlog reusing stale buffer on EOF
Date: Sun, 22 Nov 2026 06:03:43 -0800
Message-ID: <20261122140347.41990-3-gitster@pobox.com>
X-Mailer: git-send-email 2.56.1-766-g80003c9184
In-Reply-To: <20261122140347.41990-1-gitster@pobox.com>
References: <20261122140347.41990-1-gitster@pobox.com>
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

When builtin/shortlog.c:read_from_stdin() reads from the standard input,
it skips the header lines until it finds the header (either "author" or
"committer") we are interested in, parses what is on the line, skips all
the remaining header lines, and then skips the blank lines that follow,
to find the commit subject line.

But this assumes that strbuf_getline_lf() clears the buffer when
returning EOF.  If the input ends on an incomplete line, that is not
true.  Stale contents in 'oneline' cause the command to produce wrong
output.

Here are step-by-step walkthroughs for the two failure modes in this
code path.

 * If an incomplete "Author:" line at EOF follows an earlier commit, the
   earlier commit leaves its subject in 'oneline'.  The outer loop reads
   the next "Author:" line into 'ident', sets feof(stdin) while scanning
   for LF, and returns 0.  We successfully read the author of this
   second commit, and then the two inner loops to skip other headers and
   blank lines call strbuf_getline_lf() on 'oneline', which sees
   feof(stdin) and returns EOF without resetting 'oneline'.  The strbuf
   still has the subject of the previous commit, and that is what is
   given to insert_one_record().

 * If an incomplete header line (such as "Date:") appears at EOF, after
   matching "Author:", the first inner loop reads the "Date:" line into
   'oneline', sets feof(stdin), and returns 0.  Because '.len' is
   non-zero, the loop runs again; both that iteration and the second
   inner loop see feof(stdin) and return EOF without resetting
   'oneline'.  insert_one_record() therefore records the discarded
   "Date:" header as the commit's subject.

Add two test_expect_failure tests to t4201-shortlog.sh illustrating
these issues.

Once strbuf_getwholeline() is changed to reset the buffer before
returning on feof(), the first EOF read into 'oneline' empties it in
both cases, so insert_one_record() records an empty subject, matching
the behavior when the final line is LF-terminated.  Because there are
other code paths that will be "fixed" by such a change to
strbuf_getwholeline(), we will not fix it in this commit (yet), and stop
at documenting the issue in the form of test_expect_failure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4201-shortlog.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 10c43e6e75..dc1b175653 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -447,4 +447,33 @@ test_expect_success 'unknown revision options are reported correctly' '
 	test_grep "unknown option .*--no-such-option" err
 '
 
+test_expect_failure 'shortlog from stdin with incomplete Author line at EOF' '
+	test_write_lines \
+		"Author: A U Thor <author@example.com>" \
+		"" \
+		"    First commit" >in &&
+	printf "%s" "Author: B U Thor <b@example.com>" >>in &&
+	test_write_lines \
+		"A U Thor (1):" \
+		"      First commit" \
+		"" \
+		"B U Thor (1):" \
+		"      " \
+		"" >expect &&
+	git shortlog <in >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'shortlog from stdin with incomplete header line at EOF' '
+	printf "%s\n%s" \
+		"Author: A U Thor <author@example.com>" \
+		"Date:   Mon Jan 1 00:00:00 2024 +0000" >in &&
+	test_write_lines \
+		"A U Thor (1):" \
+		"      " \
+		"" >expect &&
+	git shortlog <in >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.1-766-g80003c9184

