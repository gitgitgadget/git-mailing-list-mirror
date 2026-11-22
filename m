Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356232;
	b=0XicO1YgAZwGWxWa3dscuG2kjvDfvJ1cGAmsLN6BJuNtFdaPxNW6pYTAt3MeRkXlrrrK
	 ABtf0SDSiwmSA9f6KLeB+4Uk4h0VxipGs02CFsCfubGtSQDSQR3Zfz3zYSRUaf5kxjfAN
	 52w7kX0N1z0SVB5MJgx5jbqaAdiUfU23ItNtSwrgsbZjDZfbUipckxIgfsU0N2dxRIynj
	 KyJy0IVGpsjrA1IODfIssibXlkB+2gVnXpwqL4b1qro/eY7O382x2K9oamv/o8lS6CHRc
	 TGbbLXrrdgahE98P+wtMRv4bCVaeGScCIONOrvqVZZ1Nvr8mZN3vO+umpznkUc6k4WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356232;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=1wJsaj+hwyIPWHqulNu6EMcWwR5uBJYC6Rc+Jk3Xd/Q=;
	b=hSaKc8NeyNzr2sJ1509faE5Cqqc6EOENW6KIGeYdTCCIJq3rgXVhoRv9UIAMPAEHYK3p
	 977bxIgpeK2gb8zZ5GCnDVHQFUQX3mPboHubgv4g3zcMSJ2zkQTgIomwxhFbBrCo3UL1y
	 KX5yvwYoO1P9UrpKA7CvogAlXPsii1wUF9kOrlhLr0x3lsprcqXMqzQjzEP+dU5dRHwyw
	 d8uVIm7s1eUWb/PgfAVQpz7X7V6VFzTNsmcGES0QNsSn4ZN9bLgBvHWQOT4RVjMb8JlnB
	 twCZXOMo8i8/oZ7H/S8+bPdiUGSorstWd80qPHznrGP6P7idURIo4Lam0o9UNzVy1Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=iskERBDc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tALYYwB4;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCA606A331
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDDCA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=iskERBDc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tALYYwB4
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 00AA11400295
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:03:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 22 Nov 2026 09:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795356230; x=
	1795442630; bh=1wJsaj+hwyIPWHqulNu6EMcWwR5uBJYC6Rc+Jk3Xd/Q=; b=i
	skERBDc0lg76cZ0XeUA38zAa7PI1xtxWviAIkoe80ABA4onwKsEFFzjjaTZOouJp
	dJKMkits45S90Sdj13KZrDJh9+GVeNFyfAANsIM/cYNl8a9m6VSmNKIU84uto5zs
	9R58iAgyAJUD5wE9pza/S6XTqeiClM7bIMXYGDw2L31JbPIplx3apwFSUQNSQARt
	Vio2a65tpNfltlw7NN7uQnKaq9+DAACV5PHa+fKiEPWQ+EvX6b4/zatwACb26/ya
	w96b1ye4PZmNMqZEOlNCqP5SbuuAaB90Lw0avxM5K6Szt/9k5Jv71+9sKeXkBhz+
	9Rk0w8H4A/TiURdZ4ZQhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795356230; x=1795442630; bh=1wJsaj+hwyIPWHqulNu6EMcWwR5u
	BJYC6Rc+Jk3Xd/Q=; b=tALYYwB4/++pvLbKuWY9wfqhmGgB18aucqYHo9ffsLep
	M08TBEHPUyThHZxoUBJRkr+BQ4bWVFPCKE9nMfF/cZFNcJYJwWNjC01qaDgzNdbl
	zDNQTLnM4vGjRDKYcQIBLXbkdhoDhHU9g5KUGuqdgGDSls5A97oxR9WbLTxoxzkY
	3WaAqkwl8ZKcLAOfo34ZVCCkS9EvSc6ie4KSXdUyesEdoIo6fBJuW3mtfL8YWdQP
	Q+ey4TxKJOfEcW+qa0uUkGBa2Mk+We5gHrJYeU4nXeO11JsGbw6eGjGo590hIvAV
	9zq9+vS/qWehxA7fCj/IsYgcixTGeI7dkMSFLOEUeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795356230; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RY7UPOsnDNbR8ewSpGx0Fn7Sxo84iqNDIUKQZ9Di9OTCQUm
	YpN9QgnXphYaNPu7ItN3pAh3rSa5GpWCYLFHFv1awwI8lrahZQ0Org4UJ9paHFY/
	D4wrNhBEjNS0GklSAEktFukAc5i7DNdWwIflzkjVHcyv9Wg2Yrv3/9RtWaDHvXWE
	a/ToL0PsSglkE0khCY6LV+N86oCv+Cp3OqEOdqcU13Q1ByC8Q63hEvzJiHzTuQqw
	qxJgEeGxlE/pu0pwjv9oqpc/n2FVv/DhiTpBMGcgH4u8N86TAwPkoCtwd3DcNKlm
	0ByFNz8QYzrtbQoAieqaPXy9nutcMPg/FjF/4Mw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wiEZlfK64nPoesllR8zzqY5nVEnN+AoIoXWr3BbMXL8=:P/9kwTy9uaXcICDwHmz8V4WbPEaaGGCffujExmWlmyA=;
X-ME-Sender: <xms:RvYCa8Q33LYaf309ECfdLUG7RjE64ivT165ASjkOnGQvH3fjNFPcxw>
    <xme:RvYCa_x1Ie_YmneofqmIZVco3aHgO6DthIIsZSLOed5gwEOxFsUVy6irv5EUaaTQS
    Rp2aYPUig11ZysApsM0sQqg0Kg8Kmjphqm8rdj1pKk667vJRF7PikU>
X-ME-Received: <xmr:RvYCa3ea2GE2nsQqy7uSSp9I0Ltjr_ve0aeaVa8Ugm3Gzs7JH1f0PLjFmwjugFacg2Z7Fr6izrGZ35dp4hRJK_LVefxisa0D64BQZAA>
X-ME-Proxy-Cause: dmFkZTEEfhghC7UIHFAvtnexDM+6PUjQt12sDqIrkr22qfROelV7GAL/pRsKWq/hlEVkq3
    xfZy6OOgLSRYXINfNnmUrF9J8XPDqU+fINI70NBZJVFQjUYWsBMuICN5LADN4jpNO+W4ZN
    eQKNUwGU8K56RoBf95qHiDGAq/LSwrRLkb4gmQVY+R4Uymu3SWSJNTNQdcu4SycPJv8So6
    qipCWn3kaoKlHwv2eQ3uVX0expqCWD7IBxpjO9hBN7THRCnJy9CYzlVKKIwWYXAmWjJXPN
    O7Rh4Q3DI7Vk0S8oTqalKcwIaFNoTcbszrC2qxFyv4hrEdTWys0R3derTSOVbma8kTIALY
    PVtiiP5wIyPJ1HzqNU51fWV3alk4olZ8t0S44d6jjCqTiCS0z2ePWJzH4FNY+ySHVmq1bn
    LDIKBOYOYVHJyt8BTCQceYGm/LLUVqDHv73H0zmrBr7aUL4q6NQ7RaVqQOnh4Sj8POdpYx
    iHDBCPMM0cSk5chDXZV9RhtG3hEziSH+sVE3HsNUnhBB+9kLVmLqQ/2RHdvItEqb/QT2d1
    F/yA8vVwYTu/7/bbiBiaMc+1iWL5b3oRtBY/K2/Li9dDPxMxE6EeUB6DLUSJ3jcaO1Vm9W
    AwEH8FAvUJcwUQfULBzmRyxZdQX/fEzfFtdUgnStZU7kcRg9QVEcuZqmWbww
X-ME-Proxy: <xmx:RvYCa7L3jgN_g1lvw46ynTVdlK5x-1VwyNFAj9fAvhYpP_CkJlO39Q>
    <xmx:RvYCa4HgR5Ri4IOim73sI6onT3q36_lDmIjYs-0EuJYYKmoIBrQbvA>
    <xmx:RvYCa1po0ijF_983XwWN8fY4HI19XXkGjQZTQDvQf6bfgjU-NQIQvQ>
    <xmx:RvYCaxT944UDEMnKP5EyyMWufVyR1eiA2A17FZNlK0Qq7c0J0xRTzw>
    <xmx:RvYCa_p3HEiQDeGn12mnaaodKCghqG5A16o9To3M-CCWGXTtdsbqNrhK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:03:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/6] mailinfo: do not call handle_body() when headers end at EOF
Date: Sun, 22 Nov 2026 06:03:42 -0800
Message-ID: <20261122140347.41990-2-gitster@pobox.com>
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

mailinfo() calls read_one_header_line() in a loop until it returns 0.
When the function returns 0, it assumes that a blank or non-header line
was just read into 'line', and then unconditionally passes it to
handle_body().

If the input had only header lines, however, a call to fgetc() in
read_one_header_line(), made to look ahead for header-folding, would
have hit EOF already.  strbuf_getline_lf(), which is called by
read_one_header_line(), sees feof(), and returns EOF early without
resetting 'line', and then read_one_header_line() returns 0.

mailinfo() now feeds that stale last header to handle_body(), leaking
headers like Content-Type into the commit log.

Make read_one_header_line() return -1 on EOF, so that we can tell it and
an empty-line case (i.e., a proper end of header lines) apart, and never
call handle_body() if we see an EOF.

By the way, checking feof() in mailinfo() would not work, as an
incomplete non-header line (with no preceding blank line) also sets EOF
while leaving valid data in 'line'.

An additional 'len &&' guard for the trailing LF check in
handle_filter_flowed() is not strictly necessary (the code will never
see an empty line there), but is there for symmetry with the nearby
check for CR, which does need it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailinfo.c          | 18 ++++++++++++------
 t/t5100-mailinfo.sh | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 13949ff31e..2879761017 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -895,13 +895,18 @@ static int is_rfc2822_header(const struct strbuf *line)
 	return 0;
 }
 
+/*
+ * Read one header line (including continuations) into `line`.
+ * Returns 1 if a header was read, 0 if a blank or non-header line was read
+ * into `line` (with '\n' restored), or -1 on EOF/error.
+ */
 static int read_one_header_line(struct strbuf *line, FILE *in)
 {
 	struct strbuf continuation = STRBUF_INIT;
 
 	/* Get the first part of the line. */
 	if (strbuf_getline_lf(line, in))
-		return 0;
+		return -1;
 
 	/*
 	 * Is it an empty line or not a valid rfc2822 header?
@@ -986,7 +991,7 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 	strbuf_reset(&mi->charset);
 
 	/* slurp in this section's info */
-	while (read_one_header_line(line, mi->input))
+	while (read_one_header_line(line, mi->input) > 0)
 		check_header(mi, line, mi->p_hdr_data, 0);
 
 	strbuf_release(&newline);
@@ -1018,7 +1023,7 @@ static void handle_filter_flowed(struct mailinfo *mi, struct strbuf *line,
 		return;
 	}
 
-	if (line->buf[len - 1] == '\n') {
+	if (len && line->buf[len - 1] == '\n') {
 		len--;
 		if (len && line->buf[len - 1] == '\r')
 			len--;
@@ -1195,7 +1200,7 @@ static void handle_info(struct mailinfo *mi)
 int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 {
 	FILE *cmitmsg;
-	int peek;
+	int peek, ret;
 	struct strbuf line = STRBUF_INIT;
 
 	cmitmsg = fopen(msg, "w");
@@ -1223,10 +1228,11 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 	ungetc(peek, mi->input);
 
 	/* process the email header */
-	while (read_one_header_line(&line, mi->input))
+	while ((ret = read_one_header_line(&line, mi->input)) > 0)
 		check_header(mi, &line, mi->p_hdr_data, 1);
 
-	handle_body(mi, &line);
+	if (!ret)
+		handle_body(mi, &line);
 	fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
 	fclose(cmitmsg);
 	fclose(mi->patchfile);
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e01078abe7..ecaa39dd1d 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -300,4 +300,22 @@ test_expect_success 'from line with unterminated comment' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mailinfo on header-only message does not leak header into body' '
+	cat >in <<-\EOF &&
+	From: A U Thor <author@example.com>
+	Subject: header-only message
+	Content-Type: text/plain; format=flowed
+	EOF
+	cat >expect <<-\EOF &&
+	Author: A U Thor
+	Email: author@example.com
+	Subject: header-only message
+
+	EOF
+	git mailinfo msg patch <in >actual &&
+	test_cmp expect actual &&
+	test_must_be_empty msg &&
+	test_must_be_empty patch
+'
+
 test_done
-- 
2.56.1-766-g80003c9184

