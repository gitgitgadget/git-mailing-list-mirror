Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356237;
	b=Le4Sk0P+K7RqF6AU2Ynpd/gNLxN5PDlryjK8cKuuT2dUzYyzsbP3or9HNnv4eZfplVuk
	 fi+apNmWUjqyJ3hCsA+j3bN2sC2zEnt/sD0Lmhk/SHv71wZhpqWvWaj7zZk2t+B1/Ycdi
	 iD1d4MzpDLxNW1+s9V3Ubyo4NdiIclFDhQCCpL1aOThaMw5kHoM3gexdHd6WHItsswIzh
	 qEAFVXRnzova+YdDXhQ9ZPQSlD6i+o0YlDsbKSnz4mlD0IgGzPxpYQ80S6Eexw3WhK0K+
	 j7dSQPAXizYvtLC4/DoDF973H4cRbqwKtb3IcuybH7UbGO2hitS3cFLrDAbBRunv+/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356237;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=boSCFDe/qyDlhYjWkUPJdYDfHIdrq0ukE0AXE2JBCM8=;
	b=UI2E6cjdOHGtLo8sUDRP/+eEQx0qyfOFcO5+omTPpzl+wL99MEWvEZM6cc7d8ZJwbN0h
	 kQm+5Bkzsx6VegQG0MgSetYwAbAqv0WJP2RqPmByGpwTlMk/8WguYgxtwHgulFo6RvUfh
	 E3TqI2QJ9em3DFpKNKYyz85E83I+V98dhrrYDRk4xwWZW0OgKNMQjezwEMZTkhLDaCbKW
	 WGSJE+zxGJHJgg3eMrCd2l7pHaTKIEhPSgbgWvFx3Vzqj95bm6J90r/S0l8iIYXlAU/FH
	 CRdrlxsz1Tmrh9hkhBFYVFlg5wYx389KR29zqhaDyppw5TfS+z6lEoBRUckD4fCyPdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LN+rjP8Z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uKvnfDPk;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59599606A334
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59599606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LN+rjP8Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uKvnfDPk
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8AA3DEC09BD
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:03:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 22 Nov 2026 09:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795356236; x=
	1795442636; bh=boSCFDe/qyDlhYjWkUPJdYDfHIdrq0ukE0AXE2JBCM8=; b=L
	N+rjP8ZDdlkc3T6Pb+WBAaPWbgz3CWbAjvW0ViYrjeXR30iBaHm5mRWa5fDM/fdu
	ao2pNMKOGlL6n9riRhxYUwS1FRj0fvJL3faT/wqlvs7aHjOdY78lHojhK00sSkpy
	X/2s3csD7XQZl+0DNHEr5e/ciPVkPspAxJASSkjs1C60D16iZyLSOyUT3PkRw2Im
	ze+VOgx3yAxqiohi20eEd0QCWu9yn9Qaah5UfcyTQHEvj9PRJrysQyUJGNlG4T+y
	GRu4Ex7UghedB4XJJ+v2jhP3Q6QwBU12yoHI6RcKy7mcedu+dP9gXCK1atBKSdl0
	H01fAYMBqXHzCvykmZrmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795356236; x=1795442636; bh=boSCFDe/qyDlhYjWkUPJdYDfHIdr
	q0ukE0AXE2JBCM8=; b=uKvnfDPkSr2h+DpxZC+g9aE6cuGGWQyflOlgrDX+oS9t
	DA/TRDa/z5Z0f8iDJy2zAogQybpwemgcAWli0sbB8mYpbUNsGZhXVrA+8lg4h/Bo
	9E55YKW1IR7F5pfxBeZetcC5/4WBTM+fONM8uqghINKpEuDOMv9b/wMUBOftqtka
	2Yi0QNO6Pz96ZdZgK7fRHdDbJZeIWo6woSo58cP//XKSGpZGs1/uP6O8RYSwUZpg
	jtjpysTBXJnq1F44IbprLuEE7mVoKJ4DnqltzDiq44zQuzXsFC3C5hNvjep5kZl1
	aF/8FMpNB4PnSCIhkALq+ynpk7JgNsUNdyqDFcTvcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795356236; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jvopRHI2UnIXILbmPLDNAUatsJHIInS490t4sYcLIoDCnMB
	Qr93RM+xlY+KeTnxqXqDnbhYRjcFVNLvsRnVbN1yfxt5cAMoGwEbuXvJrM7a/SL+
	zni9BwaL7+JpX4lXCrg25bC/QmGoYip5vaCJA2U4KYQIOxSJIcEH8Zyi2n5wa/Yr
	SMzru6bGrNhIYMdPZjjq0kYLYWM31nfZZqmtKk/i4kbD9FspVWRlvJHiF0LZTfrN
	KCWoCFdX366IFPNafbT68XypIyrjLf0FZwrG3ZiGBjL5b+JUOzVFlLKOrp/kOyt0
	sQmRdbBR7e7p5n0BTsE1Bk16ALMnwD3derH0JtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MEl8rmKHfoqHkoBYxvPVrIUg8JUIh12sE6fRpK1vq9E=:prDVSCoczHx98dd/jDCAJm2stMa4JOTavFZ/McztQtE=;
X-ME-Sender: <xms:TPYCa09x7I-m5h2ck7XFBb5Tz69OShHjCWlNnFMY7oiVIn7xhNdJpA>
    <xme:TPYCayvY4IQ_hUs0V-iO7hv_KHsZzXwnBrBiuRrcIlYpcPmidrDokLw4ZoMgUjlgk
    z6SPriKElDOCC3T6aba8lg1CjdT1ORJxSZFdEfhq_QKZ7j4OZ2Gow>
X-ME-Received: <xmr:TPYCa3qi31s4eL6n09Seufhw8M5xkWwwvvcn3-tu2HrkpNc9x202s_YZ0l6nq7mWGax_ZymRB6eH_II2mpdOZpk1K2HgQgG1CNtjpP8>
X-ME-Proxy-Cause: dmFkZTEEfhghC7UIHFAvtnexDM+6PUjQt12sDqIrkr22qfROelV7GAL/pRsKWq/hlEVkq3
    xfZy6OOgLSRYXINfNnmUrF9J8XPDqU+fINI70NBZJVFQjUYWsBMuICN5LADN4jpNO+W4ZN
    eQKNUwGU8K56RoBf95qHiDGAq/LSwrRLkb4gmQVY+R4Uymu3SWSJNTNQdcu4SycPJv8So6
    qipCWn3kaoKlHwv2eQ3uVX0expqCWD7IBxpjO9hBN7THRCnJy9CYzlVKKIwWYXAmWjJXPN
    O7Rh4Q3DI7Vk0S8oTqalKcwIaFNoTcbszrC2qxFyv4hrEdTWys0R3derTSOVbma8kTIAqC
    Ia647DxMGl8g9cyNERFeiN63qAPRRqQoq+R+XKrG5oTlUI6oykDefSbcmU50kUyAid1r1+
    FMquizKr1DnM2qJPErbbMTAE16g8vvAy/Gcp8oSMRC9HBypRDSbbRySvzyFz+AFkCHuOcD
    nSXRm2fAEjB9TW+5fq4mwdlmpC+1yD4LRa7a3E7Xx8F3nfNoqsIbgPe6avZso2qQQwesMB
    hMwL55cp6HARQX/R2foYt4uEfkPVqCkAYsFP2urculGwiFWpzvfQKafr6MJ+oOWRenjCMo
    oGLjU+CP60WloErq7N8FcJHSqD6NwLEJ/gfxISGHKj6K+TEN7mMWftmbb8kQ
X-ME-Proxy: <xmx:TPYCa_kShMZTL31qocMQdC8cYhKjJK1VbObwntr-Ut09iL-BtBUqrw>
    <xmx:TPYCa7xHmoQZx5MZvnH1-PrQwp2ZkcclztFA44wZeXhT2csohEGciQ>
    <xmx:TPYCa3leC9nS2_AcSs7nCj9V5J7rhRflgYAW70bZrWSrGBewbnRkOA>
    <xmx:TPYCa0ei2IHJNOYG9r1iVFV_rAGkfxyyNUC4MDvSRwjnQacXL9NbOw>
    <xmx:TPYCawVTd-GbC2jpIDM6gdsjffvv9EbSEHSo7WacYdn9yzbq27fmOLOe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:03:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 5/6] strbuf_getwholeline(): clear strbuf upon EOF
Date: Sun, 22 Nov 2026 06:03:46 -0800
Message-ID: <20261122140347.41990-6-gitster@pobox.com>
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

strbuf_getwholeline(), and its frontends like strbuf_getline_lf(), has
an early return upon seeing that the stream has reached EOF; curiously,
it does not touch the strbuf when it takes this early return code path.

And indeed, a few callers of these functions make a false assumption
that their buffer will be cleared when the function returns EOF, and due
to that assumption, they are buggy, as we saw in the previous commits.

Teach strbuf_getwholeline() to clear the buffer when taking the fast EOF
return path.  By doing so, we fix all of these code paths, so we can
turn the test_expect_failure tests we added into test_expect_success.

This would break existing callers that expect that strbuf_getwholeline()
or its frontends do not clear the buffer upon EOF, but such callers are
unlikely.  If you call strbuf_getline(&buf), the normal thing to expect
is to lose what you originally had in buf.  Expecting that the original
contents can be read back again when the call returns EOF is not really
sensible.  There is indeed nobody that relies on the fact that the
original contents are still available to read.

If strbuf_getwholeline() is "fixed" to clear the buffer upon EOF, "git
mailinfo" would call handle_body() with an empty 'line' upon feof(), but
if this were a header-only message that was sent as "format=flowed"
type, handle_filter_flowed() would get called and access .buf[len - 1]
for this empty line whose len == 0, reading out of bounds.  This issue
has been addressed in an earlier patch to teach the code to never call
handle_body() after EOF with an empty line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.c                     | 6 ++++--
 t/t4201-shortlog.sh          | 4 ++--
 t/t7301-clean-interactive.sh | 2 +-
 t/t9300-fast-import.sh       | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index c3baa47b3f..62abf01bfa 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -643,8 +643,10 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	ssize_t r;
 
-	if (feof(fp))
+	if (feof(fp)) {
+		strbuf_reset(sb);
 		return EOF;
+	}
 
 	/* Translate slopbuf to NULL, as we cannot call realloc on it */
 	if (!sb->alloc)
@@ -688,10 +690,10 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	int ch;
 
+	strbuf_reset(sb);
 	if (feof(fp))
 		return EOF;
 
-	strbuf_reset(sb);
 	flockfile(fp);
 	while ((ch = getc_unlocked(fp)) != EOF) {
 		if (!strbuf_avail(sb))
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index dc1b175653..fc731da0d3 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -447,7 +447,7 @@ test_expect_success 'unknown revision options are reported correctly' '
 	test_grep "unknown option .*--no-such-option" err
 '
 
-test_expect_failure 'shortlog from stdin with incomplete Author line at EOF' '
+test_expect_success 'shortlog from stdin with incomplete Author line at EOF' '
 	test_write_lines \
 		"Author: A U Thor <author@example.com>" \
 		"" \
@@ -464,7 +464,7 @@ test_expect_failure 'shortlog from stdin with incomplete Author line at EOF' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'shortlog from stdin with incomplete header line at EOF' '
+test_expect_success 'shortlog from stdin with incomplete header line at EOF' '
 	printf "%s\n%s" \
 		"Author: A U Thor <author@example.com>" \
 		"Date:   Mon Jan 1 00:00:00 2024 +0000" >in &&
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index 73e923d212..c7a32fd7f0 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -381,7 +381,7 @@ test_expect_success 'git clean -id (ask)' '
 
 '
 
-test_expect_failure 'git clean -id (ask - EOF without trailing LF)' '
+test_expect_success 'git clean -id (ask - EOF without trailing LF)' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 		docs/manual.txt obj.o build/lib.so &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 22d697ff9a..576fb820b3 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4087,7 +4087,7 @@ test_expect_success 'Y: rewrite submodules via stdin' '
 	)
 '
 
-test_expect_failure 'fast-import: heredoc terminator at EOF is not re-parsed as command' '
+test_expect_success 'fast-import: heredoc terminator at EOF is not re-parsed as command' '
 	test_when_finished "rm -rf eof-deleteall" &&
 	git init eof-deleteall &&
 	(
-- 
2.56.1-766-g80003c9184

