Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795312673;
	b=EkP7ztfza50mkDcMW8PzDDmg213xVVJDWptUU9tBeOj4mXKRgpV6iNiwy7+HSiQe+KAY
	 eFo4oNj1981cd+LFR9gHcDSpVBRwVDStm3m9ndcDbFVp9rX6DSgYa7dwOSK7y2TIKcqDe
	 7P1+NcBg3qj41A1Z1Mk3IdSvGFTBUIbD/vzLv6ps/4Vd+81YYBazfGor6PLY9G2fNClRP
	 +5FG0ftQFk4XfJEqjPAjkTtMqVk5pVUSxJnv2wnP4nqeGpzXT+TmpBY+BnpRATmlcIyQi
	 gfOHOVFfdDWMRxAQqWwfccy0aelNS2CyPbNZc+0axs+jinX8b6fWKhl8RTEqCaYb+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795312673;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=PiEy0IviqC4N8JWqwwFVR2lrvMxkyUUMJXzQi6kfLko=;
	b=gN3+otr2OxqSvPK4w910LppaJI0tSlqmorNF7bYOMt6mNjuBmjif9Vb5uSjMkg7oQn1c
	 +rt8tHBldn3UWNIpO/YqU7MJYSz8SXthCTSQ0C3YnQ3rMezeyJBEOV95zSl0JaN3+YaZY
	 sN/tw4cvUx3Lod50GrKcpFn7EF275N+yZxR6C5VLC7I0Z+YceDhk//HZ03Q7GcGMcTJmW
	 6mvaE+KD3sxP7SgkQOBD8wj5Fq3X+z1ZAI/rIY0dE6TTl0Tog1dpozf80qUqVLKDMcUfc
	 r4NDiQQpdtqS8qkhMddf7Awfp+3I8PxxlDxDEBlXrBhgFVLWfd8xwVIGJ7CzlfpaGRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OkGJbdHP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="CA/GUbj+";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E94606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 01:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E94606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OkGJbdHP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CA/GUbj+
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7754314002DC
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:57:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 21 Nov 2026 20:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1795312671; x=1795399071; bh=PiEy0IviqC4N8JWqwwFVR2lrvMxkyUUM
	JXzQi6kfLko=; b=OkGJbdHPRSL4N1uicQ2J4qL1wBjvhjFhgZF2BqEImu7zPoXg
	zSlXP8mu6d2DnrbDMtn/6yV9TUBr6wkuo7QlKU8uTr/nBAsxt14CX771JH8ptvT+
	h+IN+FeCzbFsJ41icKc3YbESsgGLxvhtGoj0EXU7LxqB44GXWtB2BNxHCDSP/4YB
	csJ0a/e3iBCfUqL6tnNfMfAKvJzF2rGrsmo4iIZPlH0i32TNg0kdFXO+ifF1bTvw
	HR6qL/2KxncqIsZ1xkYoyNQEPCJ0a0LzDoM5DiUipe7h033T//Xr8ZPRx8677W7f
	U+MN5vaybGpkkoYqp8/PdotwR0UcY2phq1xUnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795312671; x=
	1795399071; bh=PiEy0IviqC4N8JWqwwFVR2lrvMxkyUUMJXzQi6kfLko=; b=C
	A/GUbj+7WGtZQFKiOgc5ugl9zpp/Z1uhey87GOfMKZ70eKk/DbJAx7WEzWVIEIix
	1+sOqxv7TBfiFb0nyNGEqeiHg2X5RHJkN4DeVXfA/YszRCp6XzxUhm5DOdcqu6me
	3zTBJ7tPh83TipPXrltGKL09Rjvy6GXxyKe5qAJ04cFplNscGBK6YZL8/0Qdub1z
	WHImDOHUiW/g4jm6pk/0s+WAUCjxK4U63AKHmZSI3VVU82glPAVnzjZaMYkpppMK
	s9hG4I/fL2w00EdKMfeo4DlNsQooJBod96WGY2JKYf74VkqVn0aSE+Z2pJEPip8d
	Nylns8PI3Pg27zRYZ3sWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795312671; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DYpOQq7LJj2Jk5ZZkMJJbuev1asuh+9Cr3YHaTbLb545iur
	P+hbhU/a0KIB1G5UdxSj6Q8QDbkLs2e4mLteJQ59YDh/xt3h0aznk3aF+4dSSQHG
	u5/FGwdHKe2EZbrW+y9YMuRWEBj5fh4gDPq8Fa8PlYrD4zgs1aLuGz7G7Mp2c115
	GHkBYz+XbhDSImxy09PR5OjCCtf3VHK7LFzeQF29GV4DJadb9jKv+aqBaMf/r5fO
	gGNwBzBn2ue+y/dTkuEO1Y2x18BwEua4j5YMYjh1XRvunM7NpMAqQMESrlUyV8tn
	KRXVo9RYPbkPY7cXeOWuou2buJGIHW5BINPnHnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:6dtB7FnlMARP4syxl0dpNe1EJ4J7GUc56+lEM9PnL6k=:kXt59nub4/9We5EaCR6NOzmM40LVD5SLynBfwaF5zEE=;
X-ME-Sender: <xms:H0wCa_fQ2QQb-SAuzzg9Ig3e4L4n6bfJuROXuBE6Lr4RoI2tNsaKFA>
    <xme:H0wCa7OCw3DqQiMdex3-jFWzwD-2N3CxZapO3DkY5SO91k7aVxnK_PUgZgv8jSg3M
    ffCjqtTr_vpjfZzi0yU3eLUZPB1WHZts3YaYzPq_DS2DQxVo-2_YA>
X-ME-Received: <xmr:H0wCa2Ju-JUwi9gE0Ou1ansH1JWGiAPBQ4RgqYsi3kXiAOErVVoG0Q5KdOzgnzArmycpt1xdUWM-k3dSW3TSmNb0YJZyaptO43SI>
X-ME-Proxy-Cause: dmFkZTEGxJy3CtTfiWgkoxpG4te4xvtVM0G1xKRgf1tjZT/rePItQwEJuZ60F8mxHl5iFb
    c4LhcStVzVwJez0RQTY3Uy8aVjPBeM6SX9a94Dfhx00tvGYy0BHdF7zaR50UvaT/xcl+Rk
    o69w1vDHQmzg+THuVVkK5tiEfVqxL5buFkz/EDY4KsY5tQsnaJKPDX7gXaPd9vxvIJMnlt
    sZXjZxykzRYMzDx6K9qyx7kc8ifz/MiIDGy5N1FpBhZ9BbE89WFsnSgDpZJY0JietqKP6H
    +E7PQAspR2fSmHxjBTbgih+mnxfGXd2o3fowhDINiKGM45hYkjur/m7gZAdKYLJxdlD/K1
    j9Xm1+2ysREyFRhBFy3FcLIRbZXFURBsiYhNFORepeDILBk1ad4g/XcRk2ONR7itIRIVky
    fO3xp7yLZKQdPQyHJJ7dwT5o3vAiUBc5F7VuIlu1fxXPvfEV3DFdoIFSs7kkdDIoW3iUqd
    jaYSAZj01jCaoMYP30WVgHVQ6sll4Xysl+d8dMcRCoQ3KKRSWGx13+wcX9yndZGWcXrQpe
    2MBqPqsLNXaleYJ4xsZqobL9v5Bp28OP5LE/xx7A8LeS+knjXzPuxkHXXT/zhLacAq1b4t
    JfD50J13uFJwAPLpKmOnO9FAR5hTjlZtsLtTcTc/Hiz7a99x1srXACr9U4BA
X-ME-Proxy: <xmx:H0wCa8FUJfTkeb4Wwefvmi7Oii6WA4rMMRErJTnJu2vlmTWGQqPBOg>
    <xmx:H0wCa-T5vOfK5un5vOaTBzeVH8c7Y-MwSCnfYqdVsxKFvNhLZ7nnCw>
    <xmx:H0wCa4EpwScGHQBPqArAYaRK-MrPsq95kVskgvFCcwvA_XTxHrtRFg>
    <xmx:H0wCa69ECXW1mfwFrWl4sVjziAO-R6pwujCbI2-IyPUB3XNR63brXw>
    <xmx:H0wCa62mFXdYy4mDeG_Ee8n9Xqq21GXpdUkOXpZt_yeyqHmPII1S-Mm1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Nov 2026 20:57:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] mailinfo: do not call handle_body() when headers end at EOF
Date: Sat, 21 Nov 2026 17:57:49 -0800
Message-ID: <xmqqtsl9k4pu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

mailinfo() calls read_one_header_line() in a loop until it returns 0,
assuming a blank or non-header line was just read into 'line', and
then unconditionally passes 'line' to handle_body().

On a header-only input, however, the lookahead fgetc() for header
folding hits EOF on the last header.  In the next iteration,
strbuf_getline_lf() sees feof() and returns EOF early without
resetting 'line', and read_one_header_line() returns 0.  mailinfo()
then feeds that stale last header to handle_body(), leaking headers
like Content-Type into the commit log.

Make read_one_header_line() return -1 on EOF, and call handle_body()
only when it returns 0.  Checking feof() in mailinfo() would be
wrong, as an incomplete non-header line (with no preceding blank
line) also sets EOF while leaving valid data in 'line'.

An additional 'len &&' guard for the trailing LF check in
handle_filter_flowed() is not strictly necessary (the code will
never see an empty line there), but is there for symmetry with the
nearby check for CR, which does need it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Something I noticed while playing with an unrelated area.

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

