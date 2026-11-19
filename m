Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116181;
	b=WLeuIyy0Aey+WAXMlPM8L8L2UKtEoK7Zo8C+TJsmPfh6iRvK0AS2PxVBNet42djSpI1W
	 KGwdz4sBjsvNST4vixIL4m8IKX33fUHnHmeKEAtKCTDzm4tYRK6p3QP0VALTBA724dekD
	 hF2npoDji55wo+PX93//pApbEq27dJO0CGfvQSfJvTsVwHRghFcqnZ0yw5tcCLJO89hfA
	 1c5Cd3GOFu19iOQWY8FO3p8Ll0DUe5bT6KwsMcyPyepiI+htwwPJ7QD/pgCzm9kovrpzT
	 NyTfaoiSBKZVgTq+cfFklFCV/51wXVHVRsPyrMoRk/rBqtPMjbYUcW9eScIOxB8smMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=EG8CzoSos9PRgHTfYc/hZkYbOFOIe8gTlLgsOlNj5FU=;
	b=m/6iBuHKnSihC4mQiGk2QdTU4hyvHngr5cb8VfDW53PelPS/cs/G8BJtPeQhjnN+VGhK
	 +W91ZinJ1oqHxPBXo+PghMY2q7eE/aQ8k0ma7smbf7r+Z6CWCSN8MdEUs1Zxwci7ZZ9F5
	 t0BFhoMdAGYafeFKsAiLdoQ+mOMaAOhOu6p2m2rYQCnVuLH+bJzKOzfa9dPdadh9aL/zu
	 LjO+a4QIslgwwwhXYXvV6JalcvE3Kpn5rrj8Pr37VdZCakcS1V1pBWIdwI8Q9E8kWRJl9
	 Z41ldkH2Vny9RP4T1N6djmqJtS8dnk/JVFHMhPYItUoXk77U5qJn82l2Vm4zoceSVfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LaCSqqqu;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CC606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 169CC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LaCSqqqu
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b7d9eab7ffso65056a12.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116179; x=1795720979; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EG8CzoSos9PRgHTfYc/hZkYbOFOIe8gTlLgsOlNj5FU=;
        b=LaCSqqqu10bbDsaj9RKUtYh92DHsiVlkdZc2nV6Fz5RQ93D3JlWMpoJgZjFPfYKu7B
         JBX0uoaN9o5SRuQupyncZ9FOkzR16RjayOxxXifjYu8TwnDtntl4+eqeGDE9LOhTO0+U
         9utk20+tLAws+2Kvpft93qap07uJ4woceTgJRASpI/mjmAJP6ev+l4UjpkTi0ZgdacJM
         CDDni6c0ZXDLnMkkdcvbeqkscnCrZnvVglwIsocB/iLBomPQCCFuqGwrjHuX7NKjtLwv
         rh1rXPgw/NHnT3qMITO329TT4vrs6uVaiyNjF9mMv4UT8DCzBmrnYwM8AAfG8w6hieWY
         8B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116179; x=1795720979;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EG8CzoSos9PRgHTfYc/hZkYbOFOIe8gTlLgsOlNj5FU=;
        b=c3n1VjC/vsyuITPGC6DILyeGlxT9FG41fzoePs3IHZs7D0A0m9m0fxHnE9dSecFPsV
         3aOrnxdJWBg48Mr1UpWc77WqwFF4rny4zOQ/uJGB/TJGkzNghkM5eNO44xJ5Oifp3bQY
         xuVnsBCBCZLVLkjEU1YyLJm0PeZ2klhxSw9ELnwiKwtnhKdOUuwEQOohzLhtzlW2etn+
         Cv7WK+mnm5z7nXXExHs6JS2Hw47tMvWBmxOly3/XJqgPpwQhUQPAXpXn5+rY1/4VwsTQ
         lbVZgRZf3l8dyU4zlpK6TcPGpc8Bz3J3A/acYLqf41Z4EaSor3yr5ibdHDypq9CtXJTB
         IZ8w==
X-Gm-Message-State: APuU4Z9QHFqIY6L7VXcn0BhMza5yd/Bza5VXp0SlNg7Z1//2jm+HWnai
	t0hNcBziQCi3VjB7HAp78E8Pyxs2akyMa66p3waEoE7A5qVLjSdtradmb1U3vBx8dggNXsYHMnU
	A+eg89m0TuBbFeIgtWQOkFHGloqx1OYA6AcO3K9DrYYreW856A6m5lA/EVEdo7plAqCFzwVEOz3
	Pf1T9SH0zGMbyw/xvZfVnECQ==
X-Received: from edcns3-n2.prod.google.com ([2002:a05:6402:c6c3:20b0:6b8:9a3c:9b74])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:42cd:b0:6b7:b872:27c0
 with SMTP id 4fb4d7f45d1cf-6ba37ebff16mr287579a12.44.1795116178996; Thu, 19
 Nov 2026 11:22:58 -0800 (PST)
Date: Thu, 19 Nov 2026 20:22:57 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192257.2679418-1-dmnk@google.com>
Subject: [PATCH] connect: clear v2 server capabilities on handshake
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Ivan Frade <ifrade@google.com>, 
	Xing Xin <xingxin.xx@bytedance.com>, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

process_capabilities_v2() appends capability lines onto the file-static
server_capabilities_v2 vector without clearing entries recorded during
earlier handshakes in the same process. Because server_feature_v2() and
server_supports_feature() return the first matching entry in
server_capabilities_v2, capabilities advertised by an earlier remote
bleed into subsequent connections (including v0/v1 handshakes that skip
process_capabilities_v2() before callers such as get_bundle_uri() query
server_supports_v2("bundle-uri")).

For example, running "git remote show r1 r2" when r1 uses SHA-256 and r2
uses SHA-1 causes the second handshake to read r1's stale
"object-format=sha256" capability and fail with "mismatched object
format", and a stale "session-id" from r1 is logged again for r2 even
when r2 disables transfer.advertiseSID.

Clear server_capabilities_v2 in discover_version() and
process_capabilities_v2().

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 connect.c              |  3 +++
 t/t5702-protocol-v2.sh | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/connect.c b/connect.c
index 87d2e8bccd..b620cf2286 100644
--- a/connect.c
+++ b/connect.c
@@ -133,6 +133,7 @@ int server_supports_feature(const char *c, const char *feature,
 
 static void process_capabilities_v2(struct packet_reader *reader)
 {
+	strvec_clear(&server_capabilities_v2);
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL)
 		strvec_push(&server_capabilities_v2, reader->line);
 
@@ -144,6 +145,8 @@ enum protocol_version discover_version(struct packet_reader *reader)
 {
 	enum protocol_version version = protocol_unknown_version;
 
+	strvec_clear(&server_capabilities_v2);
+
 	/*
 	 * Peek the first line of the server's response to
 	 * determine the protocol version the server is speaking.
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index e5e73eb407..3716e43bb1 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -548,6 +548,29 @@ test_expect_success 'invalid server-option configuration' '
 	test_grep "error: missing value for '\''remote.origin.serveroption'\''" err
 '
 
+test_expect_success 'v2 server capabilities do not bleed across in-process handshakes' '
+	test_when_finished "rm -rf cap_r1 cap_r2 cap_client trace2_caps" &&
+	git init --object-format=sha256 cap_r1 &&
+	test_commit -C cap_r1 one &&
+	git -C cap_r1 config transfer.advertiseSID true &&
+
+	git init --object-format=sha1 cap_r2 &&
+	test_commit -C cap_r2 two &&
+	git -C cap_r2 config transfer.advertiseSID false &&
+
+	git init --object-format=sha1 cap_client &&
+	git -C cap_client remote add r1 "file://$(pwd)/cap_r1" &&
+	git -C cap_client remote add r2 "file://$(pwd)/cap_r2" &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace2_caps" \
+		git -C cap_client -c protocol.version=2 -c transfer.advertiseSID=true \
+		remote show r1 r2 >out &&
+	test_grep "\* remote r2" out &&
+	grep "\"category\":\"transfer\",\"key\":\"server-sid\"" trace2_caps >sids &&
+	# Only r1 advertised session-id; r2 must not inherit it
+	test_line_count = 1 sids
+'
+
 test_expect_success 'upload-pack respects config using protocol v2' '
 	git init server &&
 	write_script server/.git/hook <<-\EOF &&
-- 
2.56.1.750.gf70dc682cf-goog

