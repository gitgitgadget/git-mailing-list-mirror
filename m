Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7D143881
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907707; cv=none; b=nHFyfAt4UEZuMjG4wzTTBpanlwDlm3HHuIoOWFsbKjGrQ8N1GapSyhfXObV7tV5fqeGriUUajbKB6nJie5DalNXCQety4LUnJsZSlWc0EPjxDmUiylrM7+yK6Dke41HxCT0f6xON6yOmztUVQIz/Gku+cWBfDOhE+yxnL+e1cDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907707; c=relaxed/simple;
	bh=w4pqoQmkFvDucu77CL+TWFf6zJwyuHSUQhx/CRY89NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxNCRVFXo+x97qjubrf0iDh2T5VZOoaWkTKrdh5XvYDoaYnlzxoD+6oLfJBnUqyY1JVNO/1vXZvLtyHXoytsw7oUdfvBzg52LCb/03SOTVBAiepnWC++TyMkZWoLxIbJLtEr9N4RuNJ+qScUEAINUOd6yBnfNYAUafSh/SEZ1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5cPgxIe; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5cPgxIe"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5883518135so121225166b.3
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907704; x=1714512504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy+xrnGgkhMGybj2Hd78neFd9IvH29GqM7hPGHzaINw=;
        b=d5cPgxIeaignKY61irV+fztPrXXJLeM/BbhkXQhNnT1OX7RzoYgl0ZkUOivbzOAxOF
         5aGM4EkllNS4eehvMQ4Xy7D9GX37sUOpM+Q/VvMFJY/UznnC/Ff0hDCnqvhrlIIRfA+R
         HT5BtWsT22GthWIEwyKmB639+6BKyxa2GpEG5pqN9Hj1vFc1slbvdSpGxg20PjN8ieG5
         1iHUt3S6U+3DTJ1WNAvI+HnLyWT2xHk1bLz8fbOP29R0gU9dILQr1P+xRku4qnAOnkZM
         Qc3oVOuY7rbnVeKUu+XHJMsQTIITwm91mRYKxhfYmCWwUI+h7xDxZUDO72dEC1Grhedd
         tQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907704; x=1714512504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hy+xrnGgkhMGybj2Hd78neFd9IvH29GqM7hPGHzaINw=;
        b=j5fh1+UFE6jgG23SeoLGvee89OACXWamjkx5PtAKkwBrf/p1sr0+V/vBWBEg+KEU1u
         c7cCbgI5RrpeVIFt55M8PLMSIOub8L2JRaHPDkmpgWssPw5FUrC+H3rcmfoudimFzxtv
         aLHY45lRXjzMpEtDy1C5hA1XikiragVJlqdAepPGSZJX+2FxnEqQ/58HL6ghTpCS1dsS
         OZqedTcaCQj0GgH+9mXjhjQ27/XVSZ82fnMkpfOuE+3I8lAB4pB7eBcfclUsJ+4unIWQ
         INWvigoqDNppZDtycxFd29AZo+pduaUJ3B4EMQPwUi8Z4A33oedFvtDNUP6VDDLka+jy
         nDeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJuDLCJwUA6WsejU3LhvIf3+M91O+S8pOM+H4ObVfWcCahJ102oaZmTlr42ruy0X0ODcR5EhX522H4aSxRmnv43pNE
X-Gm-Message-State: AOJu0Yz7ADhTJo2P25dmH2be+nPegnSmsKn1Q138FLIKzEUNVc9aacke
	rk+Yly182H1X9TXzPO6/uVGw6/J9+KGyiopViHDXFZLFgIOeR52Y
X-Google-Smtp-Source: AGHT+IGzzw0mp8IVassIWnA6sHejJhC7RUZ2cE+3FS0tHOJH+t+ifY6omDB2vx1AcLTCkXeSGqUZXw==
X-Received: by 2002:a17:906:aace:b0:a55:5a28:cd53 with SMTP id kt14-20020a170906aace00b00a555a28cd53mr382102ejb.8.1713907703457;
        Tue, 23 Apr 2024 14:28:23 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:23ba:342:e06:b489])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090660d100b00a587236e646sm1864275ejk.174.2024.04.23.14.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:28:23 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 2/8] update-ref: support parsing ref targets in `parse_next_oid`
Date: Tue, 23 Apr 2024 23:28:12 +0200
Message-ID: <20240423212818.574123-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423212818.574123-1-knayak@gitlab.com>
References: <20240412095908.1134387-1-knayak@gitlab.com>
 <20240423212818.574123-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `parse_next_oid` is used for parsing the next oid present in the
input buffer. Extend this function to also parse refnames in the form
`ref:<ref_target>`. This will be used in the upcoming commits to add
symref support to the existing update-ref commands.

Since `parse_next_oid` now also parses refs apart from oids, we rename
the function to a more apt name `parse_next_arg`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 58 ++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 21fdbf6ac8..98ec356394 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -88,6 +88,11 @@ static char *parse_refname(const char **next)
  */
 #define PARSE_SHA1_ALLOW_EMPTY 0x02
 
+/*
+ * Parse refname targets using the ref:<ref_target> format.
+ */
+#define PARSE_REFNAME_TARGETS 0x04
+
 /*
  * Parse an argument separator followed by the next argument, if any.
  * If there is an argument, convert it to a SHA-1, write it to sha1,
@@ -95,10 +100,13 @@ static char *parse_refname(const char **next)
  * return 0.  If there is no argument at all (not even the empty
  * string), return 1 and leave *next unchanged.  If the value is
  * provided but cannot be converted to a SHA-1, die.  flags can
- * include PARSE_SHA1_OLD and/or PARSE_SHA1_ALLOW_EMPTY.
+ * include PARSE_SHA1_OLD and/or PARSE_SHA1_ALLOW_EMPTY and/or
+ * PARSE_REFNAME_TARGETS. When PARSE_REFNAME_TARGETS is set, parse
+ * the argument as `ref:<refname>` and store the refname into
+ * the target strbuf.
  */
-static int parse_next_oid(const char **next, const char *end,
-			  struct object_id *oid,
+static int parse_next_arg(const char **next, const char *end,
+			  struct object_id *oid, struct strbuf *target,
 			  const char *command, const char *refname,
 			  int flags)
 {
@@ -118,8 +126,17 @@ static int parse_next_oid(const char **next, const char *end,
 		(*next)++;
 		*next = parse_arg(*next, &arg);
 		if (arg.len) {
-			if (repo_get_oid(the_repository, arg.buf, oid))
-				goto invalid;
+			if (repo_get_oid(the_repository, arg.buf, oid)) {
+				const char *value;
+				if (flags & PARSE_REFNAME_TARGETS &&
+				    skip_prefix(arg.buf, "ref:", &value)) {
+					if (check_refname_format(value, REFNAME_ALLOW_ONELEVEL))
+						die("invalid ref format: %s", value);
+					strbuf_addstr(target, value);
+				} else {
+					goto invalid;
+				}
+			}
 		} else {
 			/* Without -z, an empty value means all zeros: */
 			oidclr(oid);
@@ -136,8 +153,17 @@ static int parse_next_oid(const char **next, const char *end,
 		*next += arg.len;
 
 		if (arg.len) {
-			if (repo_get_oid(the_repository, arg.buf, oid))
-				goto invalid;
+			if (repo_get_oid(the_repository, arg.buf, oid)) {
+				const char *value;
+				if (flags & PARSE_REFNAME_TARGETS &&
+				    skip_prefix(arg.buf, "ref:", &value)) {
+					if (check_refname_format(value, REFNAME_ALLOW_ONELEVEL))
+						die("invalid ref format: %s", value);
+					strbuf_addstr(target, value);
+				} else {
+					goto invalid;
+				}
+			}
 		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
 			/* With -z, treat an empty value as all zeros: */
 			warning("%s %s: missing <new-oid>, treating as zero",
@@ -192,12 +218,12 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	if (!refname)
 		die("update: missing <ref>");
 
-	if (parse_next_oid(&next, end, &new_oid, "update", refname,
-			   PARSE_SHA1_ALLOW_EMPTY))
+	if (parse_next_arg(&next, end, &new_oid, NULL,
+			   "update", refname, PARSE_SHA1_ALLOW_EMPTY))
 		die("update %s: missing <new-oid>", refname);
 
-	have_old = !parse_next_oid(&next, end, &old_oid, "update", refname,
-				   PARSE_SHA1_OLD);
+	have_old = !parse_next_arg(&next, end, &old_oid, NULL,
+				   "update", refname, PARSE_SHA1_OLD);
 
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
@@ -225,7 +251,7 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	if (!refname)
 		die("create: missing <ref>");
 
-	if (parse_next_oid(&next, end, &new_oid, "create", refname, 0))
+	if (parse_next_arg(&next, end, &new_oid, NULL, "create", refname, 0))
 		die("create %s: missing <new-oid>", refname);
 
 	if (is_null_oid(&new_oid))
@@ -256,8 +282,8 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 	if (!refname)
 		die("delete: missing <ref>");
 
-	if (parse_next_oid(&next, end, &old_oid, "delete", refname,
-			   PARSE_SHA1_OLD)) {
+	if (parse_next_arg(&next, end, &old_oid, NULL,
+			   "delete", refname, PARSE_SHA1_OLD)) {
 		have_old = 0;
 	} else {
 		if (is_null_oid(&old_oid))
@@ -289,8 +315,8 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 	if (!refname)
 		die("verify: missing <ref>");
 
-	if (parse_next_oid(&next, end, &old_oid, "verify", refname,
-			   PARSE_SHA1_OLD))
+	if (parse_next_arg(&next, end, &old_oid, NULL,
+			   "verify", refname, PARSE_SHA1_OLD))
 		oidclr(&old_oid);
 
 	if (*next != line_termination)
-- 
2.43.GIT

