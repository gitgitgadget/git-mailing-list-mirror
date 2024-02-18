Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC36F060
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286383; cv=none; b=uTh/4MH65uOm28vplINRy8QAXjk4PGaXQ3dUVRszQwsdQ+586tWqi/OKF9bGiePi/LSzRrymEG/GCd4H94GP7XJtyids6JB2yNHCKVWlvp2goD81iCEPb7luUUmRg4j0nMRcUzjgx8ACmsD3PSEiGrodjXnivIldyI3SsiyUHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286383; c=relaxed/simple;
	bh=q4HNwjHQbuFVx7YiOirFuLKlK6Gfrn8yRqp7V3DdQmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4zgPZBlmuCtnl7AvhfoFjIbL116oXeo5RYGpXEeZbDciTIg++Plj5lMgn7HdF1HjfIVWPWcZvEZgM8ONygqsxoMV6chEVdfJzuBmz+QBRQ3WDlRoiFsEGsUWyyesZFusKGDa3O8dTEw4l62B3KjLCZ75ZNSmawnmSFVtidC+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uaun69lK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uaun69lK"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso62412866b.2
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286380; x=1708891180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WMkDZAUmARPHaKnkyRvSfhcVpNQuiWa75v8pxHdkxU=;
        b=Uaun69lKl9a133MWk0+Fss+E2DZC69I5lOCWfPltW5ntdXL6au0DUsSdvz1629xFPB
         fWxDdghKp+RC88DpFfyrE7yT4UDCpW3aY4ZReegBU5PNj0jgQN1JGmjlG6M0DOJ1YxPT
         W32pWYKBChO0SgZh8iJs/piJtFqLUQg6K2oDED2zGutLhjcFNAoCmF1RPH/Rb9UIYbhO
         2zAvria6cRs+tmYS5fBjiRydmZWXCln5fYclbU18dT3RgPDS4o1R8Vx3Fwx1hQIRdowD
         X/z3cdpPqk23FdGlq9WIljrEoni83Vt1lUTittfzQk/cjefrb7SgFc9h+Dmi6QLT6ngC
         PfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286380; x=1708891180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WMkDZAUmARPHaKnkyRvSfhcVpNQuiWa75v8pxHdkxU=;
        b=W3pIa2I0xv4Z3Pn7RSBeIBWvs3kvuHKDuu4zA0YW+b3ehCe1JbKvsI9B94VXJJJAgt
         2uxanFk6sH7030L0vAqAsL/1H406dZm+vtqGPRRyleICGX9K/7+2Waoj8QzMo9QV5Lmo
         VuMD0rGtF6gzr98kOfgVmNe5iPAdk63WKKcTM5riPC70qoQ50D9WFIjj5VM4gWnn4gs2
         LhW5+SHIpkKf4QpMINFw6cAiRzIH1P93fF/JR2oqv0VmXnlHDLIx98eWTGCuO6ORN3qA
         XtYCsBvJX10URBDSP3GWyOj7ST/euAfja4QIRTO5q2bJyIeObQXYz1oFIOVyXrrLZRlZ
         kd8A==
X-Gm-Message-State: AOJu0Yyv0IRmGCjGRb0wDyHfzQ9I5M5DbUS0bAl0Y+w5r0PD4hQ3MF+z
	nO3/b7TCw1AF16lvGmV7rdL7JzaWIV1M2YuRnVpMlud7jz3J+qDI8JI2AIrj
X-Google-Smtp-Source: AGHT+IHycKNZ225WhWd2kD0W+dVrhO81xSYTMX8T0QXUG4zWVZ3hPV5gRWZlwj5UTaYSQ4Ww6xdj9w==
X-Received: by 2002:a17:906:af09:b0:a3d:3aef:2311 with SMTP id lx9-20020a170906af0900b00a3d3aef2311mr7856927ejb.35.1708286380357;
        Sun, 18 Feb 2024 11:59:40 -0800 (PST)
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170907728e00b00a3cbbaf5981sm2206999ejc.51.2024.02.18.11.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:59:40 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH v2 3/5] notes: use existing function stream_blob_to_fd
Date: Sun, 18 Feb 2024 20:59:36 +0100
Message-Id: <20240218195938.6253-4-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240218195938.6253-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-1-maarten.bosmans@vortech.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maarten Bosmans <mkbosmans@gmail.com>

From: Maarten Bosmans <maarten.bosmans@vortech.nl>

Use functionality from streaming.c and remove the copy_obj_to_fd()
function local to notes.c.

Streaming the blob to stdout instead of copying through an
intermediate buffer might also be more efficient, but at the
size a typical note is, this is unlikely to matter a lot.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 builtin/notes.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 2a31da6c97..184a92d0c1 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -22,6 +22,7 @@
 #include "refs.h"
 #include "pager.h"
 #include "log.h"
+#include "streaming.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "string-list.h"
@@ -149,18 +150,6 @@ static int list_each_note(const struct object_id *object_oid,
 	return 0;
 }
 
-static void copy_obj_to_fd(int fd, const struct object_id *oid)
-{
-	unsigned long size;
-	enum object_type type;
-	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
-	if (buf) {
-		if (size)
-			write_or_die(fd, buf, size);
-		free(buf);
-	}
-}
-
 static void write_commented_object(int fd, const struct object_id *object)
 {
 	struct child_process show = CHILD_PROCESS_INIT;
@@ -205,7 +194,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 		if (d->given)
 			write_or_die(fd, d->buf.buf, d->buf.len);
 		else if (old_note)
-			copy_obj_to_fd(fd, old_note);
+			stream_blob_to_fd(fd, old_note, NULL, 0);
 
 		strbuf_addch(&buf, '\n');
 		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
-- 
2.35.3

