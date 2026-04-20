Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D0393DD1
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679952; cv=none; b=eRHGSoaBw8mRhLdwwLNqWQRs7xB+RV7mENSw5JG9usSFoAmyaL7Szgf7umPk1mAXvrYvi1OJmsw8r2rNS3UQyGjf6OfhG2+BQLKOPy40kp/B+zQFRcbUnqrli8sFJHPNvM8Rkw/hppSjnjLMzixb6j9CWDky1PpmV/UI1C0YgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679952; c=relaxed/simple;
	bh=qqPpm1SADd0UnoJC3zPFrFzqeEzEkyCfhHgj6FK8P9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7EhrTzOPJb9e9CWfHYq50HIfyrmaj8nkbEEtlsSAZGFWmsgPiNMj6nGT/B4OfMLKf34q9yoSmtfWl4S8PYUbSIEpjHhS/SHUGKL7QfKTkfV8IgqRFaa/yoj9yCgINNhSL/eizmK7o/a5sowWce/kP/6rMU3V8m+3jJYYoAFASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j68M7Kb3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j68M7Kb3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe608cb92so1854095f8f.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679948; x=1777284748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGmogaiyEimk+IlP3uwETZ1dl0EsqinnN/89rNTa3RI=;
        b=j68M7Kb3OCf5NnLtdq3g0fzX3cn08q8Jt3/bEsmenp1iIWy479fKhkaw2VgMhynvQo
         DnnfSjnrDAnnM92ygUtvc8a2yqf8aYJRwS0heUM2RbfTz0YFuBNR5zHYBhj+wA5acWDP
         hrGE096xtjrxY0po0xtFJ0PwF+6o5xv5AyhZykBzhhv5J1Ctn/vOt4HRPO/6dexdwD2f
         VeplNk7SMb+j4S7g6UoJsbpvKSHZKC1ajbq+SiQLx96LcZfPNUI51oZr5DCaIYu9ipcW
         1dqmNz2U5YsZZ5S08c+V1kLokWWd4J5OcNPhf9hnpRcwAARmYdGhA2JHOMgc3Ly2Q228
         in+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679948; x=1777284748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGmogaiyEimk+IlP3uwETZ1dl0EsqinnN/89rNTa3RI=;
        b=o3GM3/U2hLhcYuIseoWVZ03tBLpPrwrr4wZyy3PBzZpDz3kV/qNzADW8lMBWxHXB3+
         Y2tMtSJ4vBTOjehOC7eYhfDhECPD6BRtACyvSjutdttWvaJetw0NxcZc8bj39SCkaqed
         crW3re85KIMpac51gJWQ1j1EY1YTa9oTtMKbHj2HytLL0a8/Si0jGoVpIrxYkL3o6Qre
         J0kLw0/GzeAM9rnCwBatzZaAyTg72IznZqVEloSFAxoUYzPSQcI/VDihaOZp+YmFkJw9
         O5Vz5czSMMPyX+fnRKLdfqCtPTReEfzEzsS2qy5nJ9CU+F96jstsZ7kEAytV9hxvI1jQ
         NKjw==
X-Gm-Message-State: AOJu0Yw9viTfgZY65hqVYqMFJJ1KmUolwkzozIWxKboyeJISM9o/hDQS
	hqhXlqMiT3x7oljslVOw8ylW1WxABEK6ZQ5yhuT18P99F1YNsV3LOyb3r7ZXOA==
X-Gm-Gg: AeBDieuY8ABIUkCIk8OTirdQ6Eh/aXF8ciVAB8Ya2W3Pd+phB+QRmMrFZsg/5xthma0
	+X/e34XaOogAFNL+Pv8y9ZqYr0w+7F3d4PR6cnR465jINxGNaPL02rOB/bstLHJxwanYinphwCF
	Fj42jAdWEhmbJU5yCcyghY9Y6ReoZzvaXOq02dy86bKcvotN05ot0wbpvrN5CbFQWh/7JIcEXpF
	3JSYm52V527/dEAhC3/FvjiBiyX4LQ7O36mikceODxnA8CO/R6TiPNebeAjU+ZZvoDLEuS9gcLR
	f8AeuIctBP7gCQVeNJwHL8gq/b87hIhtk0v+HsPk9LFLl6KB9S1Cx6JRbMxRnPe2S28UiTUpKuy
	jRX9E/IACbJ5TeBTCxvBeqzxsATmY2+WDcjwmR6JvxTcl58F9xWgrfx76K79GBjd693YISA1wIL
	wRPcfkZsd8RKKVmozq4LcFBj0wE8Y/xiqwQsdAH6I=
X-Received: by 2002:a05:6000:24c7:b0:43d:1cec:4766 with SMTP id ffacd0b85a97d-43fe3dfba40mr20054058f8f.23.1776679948434;
        Mon, 20 Apr 2026 03:12:28 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 12:12:02 +0200
Subject: [PATCH 4/8] update-ref: move `print_rejected_refs()` up
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-move-to-generic-layer-v1-4-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qqPpm1SADd0UnoJC3zPFrFzqeEzEkyCfhHgj6FK8P9o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl/AA/l+4PIG1KkapoB4XfXwqDYZ3n1wzsv
 07pprevJNkOfokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fwAAAoJED7VnySO
 Rox/fHIL/Rj3FpBjgnKacddBkxNLaC0RFpTrtYfHCKbGKeM8TwdN9iUjylgHaDTen/BjQox2pt6
 TJWkT036CaxnWo/Y0lT6snpz7RG8NuBuh1yTIeLw8bWt1fYgodTL4qRTcr0fH9L7KcG+xI3ifFR
 eeWSVkDjabwCsK95rYA5TyrGxyj2tGI1+cnb2TKiT4KZsNYnJqSWsI8PYX/t9J7SJQl695Isdjo
 mGAMOkIPgzgAumcszjzrVc7qM2u2y+Ya0ZpGY5EMysG8vwQFd6LGH8vRIr0EYRBQLGQKcZU1dCq
 +R6EGYF48AJc4NutN/QUgWsw7lF4yzqx6PKTjlRBukJfbQnje4lyVtRJVLsz0FW2m+ZUL+op+iN
 5xJKcFIVLtrnU0tSSMVyiqwkANI/ZLGEE9SJb2yJi2sIfYxi5lecswkEDwGmUQVv6PSeAKXqtvw
 B2goVETDuuf5FyhWzRQHbfr8p3Ka7MDtjh1u3oWbSm3ifunRs0h15gMAq686sbrY1/8bRr0pzU5
 ZA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `print_rejected_refs()` is used to print any rejected refs when
using git-updated-ref(1) with the '--batch-updates' option. In the
following commit, we'll need to use this function in other places, so
move the function up to avoid a separate forward declaration.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d68c40ecb..5259cc7226 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -234,6 +234,28 @@ static int parse_next_oid(const char **next, const char *end,
 	    command, refname);
 }
 
+static void print_rejected_refs(const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *old_target,
+				const char *new_target,
+				enum ref_transaction_error err,
+				const char *details,
+				void *cb_data UNUSED)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (details && *details)
+		error("%s", details);
+
+	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
+		    new_oid ? oid_to_hex(new_oid) : new_target,
+		    old_oid ? oid_to_hex(old_oid) : old_target,
+		    ref_transaction_error_msg(err));
+
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+}
 
 /*
  * The following five parse_cmd_*() functions parse the corresponding
@@ -567,29 +589,6 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 	report_ok("abort");
 }
 
-static void print_rejected_refs(const char *refname,
-				const struct object_id *old_oid,
-				const struct object_id *new_oid,
-				const char *old_target,
-				const char *new_target,
-				enum ref_transaction_error err,
-				const char *details,
-				void *cb_data UNUSED)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	if (details && *details)
-		error("%s", details);
-
-	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
-		    new_oid ? oid_to_hex(new_oid) : new_target,
-		    old_oid ? oid_to_hex(old_oid) : old_target,
-		    ref_transaction_error_msg(err));
-
-	fwrite(sb.buf, sb.len, 1, stdout);
-	strbuf_release(&sb);
-}
-
 static void parse_cmd_commit(struct ref_transaction *transaction,
 			     const char *next, const char *end UNUSED)
 {

-- 
2.53.GIT

