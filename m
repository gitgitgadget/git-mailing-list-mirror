Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4B348C64
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304419; cv=none; b=YUN2r2Mtm5dHmMVnuf4WpQKRbiTpPxbtUF2u9f3/rueVrzoRXpsVVPfD49bH5Hrp7LYCDQi/ifLPRMfSKaQG+x2XrOYKGy/tiUYq3pqkEMx7Dz49Qku9y8nc/kd35yzx3aIyp76qnrIkJFcfiu0y+9CTp34uwKP/yKv71pHELhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304419; c=relaxed/simple;
	bh=RljIVgv1oggaCmx9lTY6Z4DfF324Rz6YbjXqNaqW08k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6QfJMsMe+iJXpslqN9I6V/uaNy4hQXZjllQmuVTESssQQkAspbUPlq9ztuxLzGZWJNtzslKMomi7NM0ywjt+JwQjWAysDxqW1OQeJKU0qrhJd7boSrZWUZ0GVjfUEpEStkba5EMThZ2Z67Nm9cEZXQcarfV+acw2TOIhiN1h6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRm/xn6n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRm/xn6n"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-470174001a0so2495606f8f.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784304416; x=1784909216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SmGI7iN24cbF3wJMLK0S5kilt4QHQAY4+SXdak7SxLw=;
        b=nRm/xn6no4q7GQbv7NI6YiUnRptG8DFl5tOnsGDCimOizGJ0FsTxJLddt6NGqsXiLS
         2yKEmI3w5CV8iMNysomEgQc/zwEIJVg6vtekLzQ1CH6bpDlFUvoJF9ht486DPo+Ogsi/
         b12RpSeTuqNxViKFjsr+Ued+35y6LCGqevDdQMOAS+YAssBauc4OViV29vol9/0/sfb6
         vSx+YDkCTlfGJGY3R9INBItVyDH7YXDlubbPyHR9jz9JhEQFm5vk6IwwlEY7GUVphQta
         gaYbLfumSCmaJfvBN6vx4BXvz/LembSX4tGAoU6MAIhgl2sre70uV23jjx0Pv/y5HfbO
         5fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784304416; x=1784909216;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmGI7iN24cbF3wJMLK0S5kilt4QHQAY4+SXdak7SxLw=;
        b=JFcDb+QcNamYN5odAPh00VSbv3x67OfazY3UCE47IMscQI8kU2awqnnhmuyCrB6lHQ
         VcjBw+HGY2rAWhmYvRVcbTvtFShiFXC91rahdoIghTvPOHyYoKGhq0zvW/Ir+bCzIvrN
         ipoPg30X13Wnmy2C2yVt9EVwSj2+UBHaibnCfzoj8BUjGIYBcvuavXPsQAdNvJTUWR4l
         v0CLWirCCRy+eWaEHDirZ2JVaPJL8VlIMyujrZsoRGv1vrmiNbNGuX6Iq4K3ltijcu2A
         PgHjqO+H6905PUEuyf+NVnM7Aztg1IwjrlJPhBFUUX4R/x4hLG69pzRo2UF6Q05E5L95
         3B2w==
X-Gm-Message-State: AOJu0Ywmvv5cguWNb7ftgcVulYQSvB6EuIQrIwwdNSD/a4cujrBXeSel
	on1UIOnBXYgeNqLhVhF7kVddnb9NfzAo1EmOyji8gh82tLllHZMalJnQbsJxfA==
X-Gm-Gg: AfdE7cl+V+P+qKfKIDRKJovceWmz/ShUYCy24DWlMAvSMKuW5VBsgJu0Pd8LHHhjoMA
	uJ7GEW8K7cIxAuHLY4xigHqKC200As9jR5bgpIqjXoyHUNwquj2SaNxKjUitFFGmurP797/Nq6N
	Q0dBtwsTf/9dVDqHiReqJutuTcYqTjDmuAbVPOzTjiWw6PbWDWw03EoVWc9l+ePwAPqcZrIXRGd
	ybv0l2NMwlt/rPDJXoJcXob/tnfugGD4XIfiZCgBDmhAougO8SfxI92CCKA3F5P8QlAcPiD7n12
	/SkZ0eKDwYVecjpXcievK7r1iSAn3/ctBVc+Ts6vrgVj6wp5zTZ8fIzVH/3yNmn9nX6Pwiso7Rw
	612516Q0HExfQsfFC//xM9UFwA+LlYl2hypukRUa/B6xkdLmAUv2EvkNCnyJiIg1iG+eJOI4vOv
	kKMClS+A==
X-Received: by 2002:a05:6000:612:b0:476:a715:1a with SMTP id ffacd0b85a97d-47f62334b35mr4625406f8f.41.1784304415594;
        Fri, 17 Jul 2026 09:06:55 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm5177588f8f.10.2026.07.17.09.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:06:55 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/2] rebase: remember fixup -c after skipping fixup/squash
Date: Fri, 17 Jul 2026 17:06:37 +0100
Message-ID: <7c8075ff2675976821a1ee979f86c7c46a35bd15.1784304378.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the final command in a chain of "fixup" and "squash" commands
is skipped, we should prompt the user to edit the commit message
if the chain contains a "fixup -c" command that was not skipped.
Unfortunately, commit_staged_changes() only looks for completed "squash"
commands and so does not prompt the user to edit the message. Fix
this by recording whether a fixup command has the "-c" flag set and
then checking whether we have seen either a "fixup -c" or a "squash"
command. Add regression tests for skipping a command in the middle
of the chain (which currently works but has no test coverage), and
for skipping the final command (which is fixed by this patch).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                     | 20 +++++++++++---
 t/t3437-rebase-fixup-options.sh | 47 +++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index af3d2c72616..25ef076216c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1924,6 +1924,13 @@ static int seen_squash(struct replay_ctx *ctx)
 {
 	return starts_with(ctx->current_fixups.buf, "squash") ||
 		strstr(ctx->current_fixups.buf, "\nsquash");
+}
+
+/* Does the current fixup chain contain a "fixup -c" command? */
+static int seen_fixup_edit_msg(struct replay_ctx *ctx)
+{
+	return starts_with(ctx->current_fixups.buf, "fixup -c") ||
+		strstr(ctx->current_fixups.buf, "\nfixup -c");
 }
 
 static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
@@ -2148,9 +2155,14 @@ static int update_squash_messages(struct repository *r,
 	strbuf_release(&buf);
 
 	if (!res) {
-		strbuf_addf(&ctx->current_fixups, "%s%s %s",
+		const char *fixup_flag = "";
+
+		if (is_fixup_flag(command, flag) && (flag & TODO_EDIT_FIXUP_MSG))
+			fixup_flag = " -c";
+
+		strbuf_addf(&ctx->current_fixups, "%s%s%s %s",
 			    ctx->current_fixups.len ? "\n" : "",
-			    command_to_string(command),
+			    command_to_string(command), fixup_flag,
 			    oid_to_hex(&commit->object.oid));
 		res = write_message(ctx->current_fixups.buf,
 				    ctx->current_fixups.len,
@@ -5391,8 +5403,8 @@ static int commit_staged_changes(struct repository *r,
 				 * message, no need to bother the user with
 				 * opening the commit message in the editor.
 				 */
-				if (!starts_with(p, "squash ") &&
-				    !strstr(p, "\nsquash "))
+				if (!seen_squash(ctx) &&
+				    !seen_fixup_edit_msg(ctx))
 					flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
 			} else if (is_fixup(peek_command(todo_list, 0))) {
 				/*
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 5d306a47692..a4b2a631654 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -184,6 +184,53 @@ test_expect_success 'multiple fixup -c opens editor once' '
 	get_author HEAD >actual-author &&
 	test_cmp expected-author actual-author &&
 	test_commit_message HEAD expected-message
+'
+
+test_expect_success 'fixup -c is remembered after skipping final fixup' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	cat >todo <<-\EOF &&
+	pick B
+	fixup -c A1
+	fixup A3
+	EOF
+	(
+		set_fake_editor &&
+		set_replace_editor todo &&
+		test_must_fail git rebase -i A A &&
+		git show && cat .git/rebase-merge/message-squash &&
+		FAKE_COMMIT_AMEND=edited git rebase --skip
+	) &&
+	test_commit_message HEAD <<-\EOF
+	new subject
+
+	new
+	body
+
+	edited
+	EOF
+'
+test_expect_success 'fixup -c is remembered after skipping later fixup' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	cat >todo <<-\EOF &&
+	pick B
+	fixup -c A1
+	fixup A3
+	fixup A2
+	EOF
+	(
+		set_fake_editor &&
+		set_replace_editor todo &&
+		test_must_fail git rebase -i A A &&
+		FAKE_COMMIT_AMEND=edited git rebase --skip
+	) &&
+	test_commit_message HEAD <<-\EOF
+	new subject
+
+	new
+	body
+
+	edited
+	EOF
 '
 
 test_expect_success 'sequence squash, fixup & fixup -c gives combined message' '
-- 
2.54.0.200.gfd8d68259e3

