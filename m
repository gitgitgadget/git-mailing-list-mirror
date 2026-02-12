Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638F2E7167
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890957; cv=none; b=DshvBlEyWSDtR/787y53bRMrJg1rHLzL1B4nCdTLS8hRefhXhWNje3emoEgswKdXDrwJvvF/EcHb/C431IhHeK9MyUNGLdtaeF91s6Gy152zcrtMUfbZKqKi0VU2Xxg7pVAHvtst7K0I6Y6SiYE4VoTWUR+3LJ7bNvV8M3VfaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890957; c=relaxed/simple;
	bh=y8J9g/aZJm9j99kaTFtsivYsne/SL+2etcwqvjaRCHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne0nIKc5cCIQFqjOROqtAXbwNubgofR6aQ3CocsQyZSnobwmD/nCXOg5geRnvgUpgKUTebxV/wulWs5atB5CvQamvh2SXQLVl1xlwi/EdKa4PQF1+x//63necEKGFCoqmynZRZXJl7lf8nyKpX2IpdP9JiJpI3DkGgrC0D/LIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIl9Ti/H; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIl9Ti/H"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359228b7c6so4161758f8f.2
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890953; x=1771495753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJKAnMpSpHx+vU1EYQWdEDD3LRNhWVzTGIKPE3Pgcgw=;
        b=NIl9Ti/HOqvZm3NWXfmGS1RKyoPmCVHpCKb08iv4ySy6n2YKqJFJ9xu5qZecNW1rmA
         3sgxAJ4Ru3MKoW0wZcpwgJxklomtIOlyTs0NWlWuzEAZNX6B1LMS86vD96wcan3O0Y6b
         jihxz+eF5Gk9Rw67QCTiUPv9fExoxSuD+4BKnFtz9b7Jzy7qLfY3BIFu01ArWRyKB9F2
         7Tnu2XtiSQJa3cMzI+3FAJtOjmG0KgeJs8USC56as0IQcxM5BbLTKjlMYQFTF2teyx5M
         qJnepsbt5dnrSOjfPBCqbWbCVAZtVxrI2tueUoyxdrYYmuFqjjGFjZVk4me6Q5r+8ZSA
         ReQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890953; x=1771495753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJKAnMpSpHx+vU1EYQWdEDD3LRNhWVzTGIKPE3Pgcgw=;
        b=SMxsH8pxrI1QTY5vMV+eYO7qvRSVFKFkm/7yBkiW9TOLbdFA3Gr5qeuRO89Xc4es7/
         +s7rJDmkerI7fwjRom9/EPoyiPoP6+z9CEBGcfDKEVzC8ExAMrozTjDV5/WA1G+7YQa2
         CxDjeZoQuFUruQJMEtEoYiHUOA+44HFd1HZLQsh+F2AvMXHQx16863tACiFNQjtnHZ+a
         sSiHgZ0/Fdk4aSXgU/OcuMDQ+zeuu53ui4lN+wa9dHRz4OYy1eccjfA/gVIzWDEB1K7v
         rOi/X3bu39fUWLld73qb1aahbIfi/1MVbkUtc5KyBcOqyRbPqLj/1RYiipvjTkNDr64i
         aUgw==
X-Gm-Message-State: AOJu0Yz7svi6wxn1GOcbcLGjDwNzSoFr39GExFLVNjfxlcjq8ey4HMfg
	30ZOziLD5VO0rH5jKIXIm+0vobDSrKC6p/Vc5q0IkmmQ4UVmcUbOTz1bp9fOYw==
X-Gm-Gg: AZuq6aKdGXsVNE90Uwd4oRZsyki+qHYzaKuyGhbI3ALOPUWOs3FG5Sog1N0s3XTpt8c
	PvKM52UFjkqcCH/wUC6IcfWjBkFKwRdw3SIpLIj6qzbFy5dOd3M1gi2ejTF959dk7mQyfml/vTm
	T+dEqMMcltrZylL8jCIl7MRP/BEwR2Y47itvSQSnLk4vgWqU8a+r4I4ZbP+X4cTkAGKkzxpkMOR
	+yzieKbRiTTrlUzYP/YavY9HBlILNfMwKf2qXqzBEyVV7amFxNs4pPwxUvHfwzthSk+MufHbBpJ
	vaNhq+0D07wx+Vp5aPxPpTvE3nvu0v/wGzLfHiiMimc8mKsIyOsyHkdEGP8jtk5g7CB9A04vsYr
	wFdo8Okb0cb/yz6e7uywTZIcoOEs73+2vEWYwVIe9sPsssYNQqrlyATJUNZKrupZrBKL8LzstW/
	iBMJJhAfmb+6y8OpuqivQ7ABVH6gNC92KFNlIIhFVfeSlfqUUJn4qr4vXDG960VInhuEiA6NdY8
	tn6iAAUTIB7AwLAW/XmZ8wBbZ6XC3y+zVjX1e5131rK2c3xKw==
X-Received: by 2002:a05:6000:200f:b0:435:d859:5cf with SMTP id ffacd0b85a97d-4378ad82962mr4298745f8f.54.1770890953071;
        Thu, 12 Feb 2026 02:09:13 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm12701151f8f.5.2026.02.12.02.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:09:12 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 8/9] promisor-remote: change promisor_remote_reply()'s signature
Date: Thu, 12 Feb 2026 11:08:39 +0100
Message-ID: <20260212100843.883623-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.70.g3d1fd9d397.dirty
In-Reply-To: <20260212100843.883623-1-christian.couder@gmail.com>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `promisor_remote_reply()` function performs two tasks:
1. It uses filter_promisor_remote() to parse the server's
   "promisor-remote" advertisement and to mark accepted remotes in the
   repository configuration.
2. It assembles a reply string containing the accepted remote names to
   send back to the server.

In a following commit, the fetch-pack logic will need to trigger the
side effect (1) to ensure the repository state is correct, but it will
not need to send a reply (2).

To avoid assembling a reply string when it is not needed, let's change
the signature of promisor_remote_reply(). It will now return `void` and
accept a second `char **accepted_out` argument. Only if that argument
is not NULL will a reply string be assembled and returned back to the
caller via that argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 connect.c         |  3 ++-
 promisor-remote.c | 24 +++++++++++++-----------
 promisor-remote.h | 10 +++++-----
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/connect.c b/connect.c
index c6f76e3082..a02583a102 100644
--- a/connect.c
+++ b/connect.c
@@ -505,7 +505,8 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 	}
 	if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
-		char *reply = promisor_remote_reply(promisor_remote_info);
+		char *reply;
+		promisor_remote_reply(promisor_remote_info, &reply);
 		if (reply) {
 			packet_write_fmt(fd_out, "promisor-remote=%s", reply);
 			free(reply);
diff --git a/promisor-remote.c b/promisor-remote.c
index f3bafb7731..96fa215b06 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -920,25 +920,27 @@ static void filter_promisor_remote(struct repository *repo,
 	}
 }
 
-char *promisor_remote_reply(const char *info)
+void promisor_remote_reply(const char *info, char **accepted_out)
 {
 	struct strvec accepted = STRVEC_INIT;
-	struct strbuf reply = STRBUF_INIT;
 
 	filter_promisor_remote(the_repository, &accepted, info);
 
-	if (!accepted.nr)
-		return NULL;
-
-	for (size_t i = 0; i < accepted.nr; i++) {
-		if (i)
-			strbuf_addch(&reply, ';');
-		strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
+	if (accepted_out) {
+		if (accepted.nr) {
+			struct strbuf reply = STRBUF_INIT;
+			for (size_t i = 0; i < accepted.nr; i++) {
+				if (i)
+					strbuf_addch(&reply, ';');
+				strbuf_addstr_urlencode(&reply, accepted.v[i], allow_unsanitized);
+			}
+			*accepted_out = strbuf_detach(&reply, NULL);
+		} else {
+			*accepted_out = NULL;
+		}
 	}
 
 	strvec_clear(&accepted);
-
-	return strbuf_detach(&reply, NULL);
 }
 
 void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes)
diff --git a/promisor-remote.h b/promisor-remote.h
index d227299fd0..3d4d2de018 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -49,12 +49,12 @@ char *promisor_remote_info(struct repository *repo);
 /*
  * Prepare a reply to a "promisor-remote" advertisement from a server.
  * Check the value of "promisor.acceptfromserver" and maybe the
- * configured promisor remotes, if any, to prepare the reply.
- * Return value is NULL if no promisor remote from the server
- * is accepted. Otherwise it contains the names of the accepted promisor
- * remotes separated by ';'. See gitprotocol-v2(5).
+ * configured promisor remotes, if any, to prepare the reply. If the
+ * `accepted_out` argument is not NULL, it is set to either NULL or to
+ * the names of the accepted promisor remotes separated by ';' if
+ * any. See gitprotocol-v2(5).
  */
-char *promisor_remote_reply(const char *info);
+void promisor_remote_reply(const char *info, char **accepted_out);
 
 /*
  * Set the 'accepted' flag for some promisor remotes. Useful on the
-- 
2.53.0.70.g3d1fd9d397.dirty

