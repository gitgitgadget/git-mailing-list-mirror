Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC949405C48
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566870; cv=none; b=fvaa/a1mUQ+SQGJ4iLVAVbVuRV9sSeECrsPfegegzaKRbpoJEzSpVQ37T3wyry1X5ojdzL8U1rDfauWujV2icYWcYXRm0Rfwsa5Lsv74Dxt3bLyfkJF4/AY+AQNOlHZghsKPNVi8xxFEnRvWy5fYJmoUKF074QlP1t3PKPdVZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566870; c=relaxed/simple;
	bh=B3SN1ATBJKX3LmJdjOWVjgZEUDVqoHrUxRmQ64Qoiy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rqon+E00Uo/moiBUBUs65MzSpZxbtMfQfzmMLaE90AOrISKe2HeMu+a2D/ro/kkXvDGMwE92I0uXRDzknQHp+XuZ4qr8yu0GoA7VweClw0hx8qTh0n2Y2p9bSIoTiJoU1P5CaGZ3NJvqfQW+BzGILUSQUynwmbQ9/Z72PDp6Afw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYUKiTf3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYUKiTf3"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c247f6687dcso367754466b.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566867; x=1788171667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NT7FFAMbwOQgFc1vopNGO2ONJTF4p93UwimeTPLGLgI=;
        b=eYUKiTf3KQWCGgu9Qd9tOU67VXff4L/0nfOrsFBiOntnTQars0BUei03fbn3O3S+2u
         w0KNeiCwJTGQqjK2bFwkYb0Yj8OZCHVh8LPlilJvvFwRf0H2oZnEUhe5xLPEM4SDYLPx
         J3lh3PQ0RHQTSSnet6eZi4tKdOkJs7m6FBQmHHx+uVe4G8t/EZKuhR0pFts4JMp6lOC4
         4zy+JB2JKQV9myBQVOl0Q10RfEyCHjrH0kI6watRAFuCpzvcc8zjQtw6xLFMo2seFnLU
         u7KkN0zAN6a5uiEM+lSkj0OcRv90xAwKKa1HZYqkSXa9Ex/dcLX+1tF3ztnHUrTi86M7
         u7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566867; x=1788171667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NT7FFAMbwOQgFc1vopNGO2ONJTF4p93UwimeTPLGLgI=;
        b=ng40+VQaw52mTdiPvuRBS643YnFdYAFhmKQgnUrdG54wxPAS4x8b+baIl48eKvKmSY
         zbOAACS5XHZMl1T1qSgAUb7ecfQ4TtRIvFIpyDsEE8ermk41haQE07XmpqtsRm0BCBaO
         lcNMp2JIhPFWIK5+JaoW010xQMDcgQdjvsqWp6NQ+QUDuF8ysDTLGiMNiKBxjEAYCohk
         ylFOKOyBYtgwZqaO25FuQYOJFZU8nOC7t36xrX0ezQS9QJIV2mkcg2i6E/FZ/i2SKe1G
         3fLeH1SwES+ZzcOpnPO+jXbGnAFt7QKYsyUctwoiuKIlYgrl7XEtZa7qtHsmZc/6bAGc
         cAOA==
X-Gm-Message-State: AFuF++nu5bopAP3rBchW5rXxdgY6Zhi1wOMA6TAnWotXrOYHUhBDwbN1
	XJlxL7V6f8+G0tckL+h160OFbDvC+0/X9PhMTBVHLUgqjY51DmZE3s5E
X-Gm-Gg: AR+sD10vQovNc9tfySgQTgpRIvAqb6C5ZzSwX9KiFK9nQD/Us43M6y/YHdKcMyrtvQq
	eWf6BHg3T6HUW7XmDE93MfbTYGwKto3uK4FIRBBLfuxcRxsmnhbhXJhkUbdJdXnSBXIpPL0Jb5M
	F0paORXdgJBkg6+aMSI7CEUurfBuNd3otF9amqdDTqbBIZyyzsh8d/2iOzeCfforOzC0g4FVd/4
	Bk04+jEUwq57Z8oG60XMryHLHRKyHYlhkMVRpO5aNr/1TZWlutB3Y0HxeEfDrhIAfldLnjKBKop
	WFu6XaAKgTQHeQI7iUheIU9eCNxkk0MbKcTSxHb18prcJ9xLhJt0H09DhXDuGJzxybJfaYv9b9y
	Hkza26b75U/4CIvpmDWfNDjT/KA6lkNT/Rl7D9VALdWm/MKRQvLNIPh5nuuCIK9cEyfxIzaUr4d
	Nbmc+qQ6bUbhPQqWNJkLj0bVWDKlVZJ1QHZbagnwNobhmX10994WJ4nnZkH05KdSXkNCNL0VIYz
	uIXUG6PcsC4Pag9ZzF8484t67U=
X-Received: by 2002:a17:907:da16:b0:c21:34a3:4df9 with SMTP id a640c23a62f3a-c246a2cf648mr2871094866b.3.1787566866719;
        Mon, 24 Aug 2026 03:21:06 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d6d5:360a:4ee9:3f53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1327677066b.25.2026.08.24.03.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:21:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 24 Aug 2026 12:21:00 +0200
Subject: [PATCH v3 2/3] receive-pack: move message generation to separate
 function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-758-introduce-hook-v3-2-499526f0a062@gmail.com>
References: <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
In-Reply-To: <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 jltobler@gmail.com, kristofferhaugsbakk@fastmail.com, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4163; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=B3SN1ATBJKX3LmJdjOWVjgZEUDVqoHrUxRmQ64Qoiy8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqMGw4dGrLGR2VzjlfX+BhBufLz4UYN3tEmM
 fvaZoPclL50OokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjBsOAAoJED7VnySO
 Rox/jUML/iet4ovkuO9rnxR6EWsKx39eyb6ALAh9bGTYay4n8NdVNYShXrb9Jk0IyFjKADAdslu
 5ZT1cQ5cEPmczcDSql5RXILuhybhlTjTn7OtEW5Msljb4549gWtLM7vqHnaggkS8+gMOUkjsXQX
 Bs6Cu2oZzaoqy9rRuBj+egG1z7097LS6mtJlsaJnhd+iCfJ45r0uHtWfH8YgC5TQh2LaiRQO5ni
 ETu6aTmjyF7jacMKvNnt3mAE5YaF0oi6pseonugbuFRJy1f+vM0ibYHtcE8UN9SHsPZguK4EzOY
 o1+F/fBZgsw6fndgcfoxvd2HWAhFROGLk3trlwn9ZF9SG66Ll5Fx9saPms761f3FHKtxu+rVUF+
 AeNeBWXOGLf/615q7IWVYB6/eZuxztKb81lxKWAEE/i0f/vVvmmAKa8WdWxmOKqphMt/AKfzJ2Y
 ssIojqRmqzTFvhq+LlJgJKhhstF0znNIPmHHwcL9KabA77GUeriz1YMBJXZ45lvZFhsuu8P9296
 zs=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Post the reference transaction, both `report()` and `report_v2()`
generate the message to be sent to the client. In v2, we also add
reports for each reference if available. Since they share common code,
move them to a common function. This will also help the following
commit, where we will need to regenerate the message during hook
failure.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 84 ++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..70a686c142 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2530,67 +2530,71 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const char *unpack_status)
+/*
+ * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
+ * For v2 protocol, set `add_reports` to true, which will also add additional
+ * report per reference update.
+ */
+static void generate_response(struct strbuf *buf, struct command *commands,
+			      const char *unpack_status, bool add_reports)
 {
 	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
 
-	packet_buf_write(&buf, "unpack %s\n",
+	packet_buf_write(buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
-	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string)
-			packet_buf_write(&buf, "ok %s\n",
-					 cmd->ref_name);
-		else
-			packet_buf_write(&buf, "ng %s %s\n",
-					 cmd->ref_name, cmd->error_string);
-	}
-	packet_buf_flush(&buf);
-
-	if (use_sideband)
-		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
-	else
-		write_or_die(1, buf.buf, buf.len);
-	strbuf_release(&buf);
-}
-
-static void report_v2(struct command *commands, const char *unpack_status)
-{
-	struct command *cmd;
-	struct strbuf buf = STRBUF_INIT;
-	struct ref_push_report *report;
 
-	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
+		struct ref_push_report *report;
 		int count = 0;
 
-		if (cmd->error_string) {
-			packet_buf_write(&buf, "ng %s %s\n",
-					 cmd->ref_name,
-					 cmd->error_string);
+		if (cmd->error_string)
+			packet_buf_write(buf, "ng %s %s\n",
+					 cmd->ref_name, cmd->error_string);
+		else
+			packet_buf_write(buf, "ok %s\n", cmd->ref_name);
+
+		if (!add_reports || cmd->error_string)
 			continue;
-		}
-		packet_buf_write(&buf, "ok %s\n",
-				 cmd->ref_name);
+
 		for (report = cmd->report; report; report = report->next) {
 			if (count++ > 0)
-				packet_buf_write(&buf, "ok %s\n",
+				packet_buf_write(buf, "ok %s\n",
 						 cmd->ref_name);
 			if (report->ref_name)
-				packet_buf_write(&buf, "option refname %s\n",
+				packet_buf_write(buf, "option refname %s\n",
 						 report->ref_name);
 			if (report->old_oid)
-				packet_buf_write(&buf, "option old-oid %s\n",
+				packet_buf_write(buf, "option old-oid %s\n",
 						 oid_to_hex(report->old_oid));
 			if (report->new_oid)
-				packet_buf_write(&buf, "option new-oid %s\n",
+				packet_buf_write(buf, "option new-oid %s\n",
 						 oid_to_hex(report->new_oid));
 			if (report->forced_update)
-				packet_buf_write(&buf, "option forced-update\n");
+				packet_buf_write(buf, "option forced-update\n");
 		}
 	}
-	packet_buf_flush(&buf);
+
+	packet_buf_flush(buf);
+}
+
+static void report(struct command *commands, const char *unpack_status)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	generate_response(&buf, commands, unpack_status, false);
+
+	if (use_sideband)
+		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
+	else
+		write_or_die(1, buf.buf, buf.len);
+	strbuf_release(&buf);
+}
+
+static void report_v2(struct command *commands, const char *unpack_status)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	generate_response(&buf, commands, unpack_status, true);
 
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);

-- 
2.55.GIT

