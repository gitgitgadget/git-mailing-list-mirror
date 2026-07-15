Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8784480DED
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128944; cv=none; b=ZXiHkipLvqFs+rDNTcX04pUoN/bU5stZjTRWdBAxQ01so3PaxVCq6Bwv4PntkW42HI2mVXdpMAagUtGYIOsdfjUOnQ0BXWCTtP54b8gTmdja+9MDI4wgqMdYg7QNtLONNtPRnWd4WbNKqsl5igwuwu0iCpp/JvO+XsL3jtEGtD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128944; c=relaxed/simple;
	bh=GQVDveUlBuIyPPYiyJDIvuJeGdmDWSlrSLVvHIX3yTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GS6plYjIg8skYrbO/sOxOxtHE1QcT+2vFNvw5QZ/J1sjWjMhvl/67QopxCA1XoY88MI3p+gMluCmP6bOvdP/1o7aHDOiVS/9qqazA1+wr/DyJTlK4MEFJNo4A4QFJ6limicNRtybJsMY4tmTPiC7zv3EaNG5GshebRgXQJvpN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX8GnR2+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX8GnR2+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b779003fso24276945e9.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128941; x=1784733741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ojf+QdLqPPWEpUjqH9f9zplWcWiaFP+DWqvQdBdqRkQ=;
        b=QX8GnR2+4fFV8FgMgUZa0WVC2u0GQe2pbxlwi5K6HA/dtc1krgXkUr2G4AvsI3LNnL
         6TNA+1Kt/tlrkp+IORvUc99LkX9Mzz8lfsX0hmSQGrHNsZexUedD9TP7aKkTL6F3Ff7F
         kVpJhdbtjyyr2gTtowyhlYWj1/uigJC6vX5TyFm2m3N6Bgg4kXNY91ycZths4LwnEZIL
         VvFm+rh8ZBqkOAVemfTMWuUPS4cNJtSDNs+ifiV0TLKoyDAkZtBapx5jQp3F7wG2ctLS
         c+loejDzLa1qHlLbepa8Kc5jipSjII5SXHrvP+gX40XlhcSQLYQmsdCgFj4OnLEkSqmX
         fh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128941; x=1784733741;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ojf+QdLqPPWEpUjqH9f9zplWcWiaFP+DWqvQdBdqRkQ=;
        b=KasUwhJEL4K0iF8pjB39gcvmJxQa6t4ZVW1nFxwCuu2sCmy622BOUGhS9dA/SdDXgw
         v8FQp1iLj41xZ7hSUzzYYMBW6ntKhaT+d6vLT0Ft30Ik/s7wBnd18pe7eTiMivajRy9i
         T5XVGJHgbV02D5XSz71OEiUK0ssZquVFqRxRaxx3asNVS1GL7Qov45A5b1o7ENhbjgju
         VW2OLTRy63Xn5P4VU0w8RdD6/IqJG4PL3zU5BA7SdpmqV4UG/QzzknY7YZWhof2nrtGU
         nMb5Y8L2mm0O9VhtBZr+R5Jx8PxIGOA8TzSJcPa/yehcFr0yIbkiVY+SMBMSQdvMOWFV
         1gBg==
X-Gm-Message-State: AOJu0YwwOKNI86G0M12QzHCTStLHPB+H6Dne7qzKQVKFnEt+gu9mt3zs
	YaBcNxisshAmb+AsQwqocXMy6JViWs2/hCcvuYSFs22dMYH87yJynP8niAvyIA==
X-Gm-Gg: AfdE7ckHT/gIdBVU4OnyQbjmLnHrem5OVWroaLUjcZ0ipG5eZkeKikeA2fwZciI9udC
	VGE5FnsFc2qWgDV6ovRXR3QOKb/tn6hO6BtVjTgjpj1Txwo0dHFEvfzIz8myYoqX39cwbgls5pV
	XEa6drNASdEIcJmaG2gevKA9bhrXhmnozBQNMB2oTBz++Wgr+vkw1/JOCjz3R2J47cMaasZqirz
	h4IQe+rIT3mk05qttz4IrP8M51vh7+UPLWTnmeeCQuEgxu6th+CjqG3LydqV/ltQ9hZTZe6ABjQ
	fUzIfHhZ8ohscNh5/bckkUTTnuaA4HbkfLFU47EeS10q8eFa7JzjE9Z1mfrQwi6hC2DWLexdKyw
	dtHs734ZAnnq3NIeMWIWDIqhK0nAcXBu6jt/RqH//Cv5idxsmtaEYEf7ejSxU1DN2prDwaoRxCe
	DnxKgWnw54Q9EV1gFDsn8jKZd1t/c=
X-Received: by 2002:a05:600d:108:20b0:495:401d:9f4f with SMTP id 5b1f17b1804b1-495401da1a5mr10332025e9.25.1784128941026;
        Wed, 15 Jul 2026 08:22:21 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953df0fc6esm51043395e9.9.2026.07.15.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:22:20 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Andrei Rybak <rybak.a.v@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 3/9] sequencer: never reschedule on failed commit
Date: Wed, 15 Jul 2026 16:21:57 +0100
Message-ID: <bff5f319e91b2b5ea13a32906d0d76bd688183fa.1784128921.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784128921.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1784128921.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If "git commit" fails to run then run_git_commit() returns -1 which
causes the current command to be rescheduled. This is incorrect as
we have successfully picked the commit and have written all the state
files we need to successfully commit when the user continues. Fix this
by converting -1 to 1 which matches what do_merge() does.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index eaffa8ebb84..1db844100ad 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2542,6 +2542,12 @@ static int do_pick_commit(struct repository *r,
 			res = run_git_commit(NULL, reflog_action, opts, flags);
 			*check_todo = 1;
 		}
+		/*
+		 * If "git commit" failed to run then res == -1, but we don't
+		 * want reschedule the last command because the picking the
+		 * commit was successful.
+		 */
+		res = !!res;
 	}
 
 
-- 
2.54.0.200.gfd8d68259e3

