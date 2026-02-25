Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797438F220
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012454; cv=none; b=lCfJTUpJeDfP+K5h4aL8fc+cedAkh2fPimK7O0yMlR5wJmrZZZrOitR48rwY4IYwn8mnh7TI0UPa7TG0SHM5RaM1t/ouh8jCoGALgHrVDaz2nvl6xENRSmecJG9mU16mtNEN0HsUoQXXTyU4j5IMi7t3wbRtpEHNKYKyYMwMh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012454; c=relaxed/simple;
	bh=ORde0fdTcyXggqTNNk6zNTCVEag2mH6gRCQ9/9wuTjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NddHbJk9ipJ6aPP8n5aEAp6YNb97TPxomqir58UMyXYnEeZN1B9Ul7ZlHEbE0vbIEFernf+h0LmlmFkMb9IhoidxPF9FddhcbixEaXljXC6vlHaJCd/5Z1toYrfwKGtOHVN1ffpxDfrpRizOqn0aoUhN8y2iPATcMBBA9LxR1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJgiD7Ra; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJgiD7Ra"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so79600195e9.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 01:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012451; x=1772617251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpB7gxHYv1RCrBGJEiZQU1GK/+eaWL5POIje2U5zOks=;
        b=NJgiD7RarGI43KV0W9dlXW6P/nDu0L3otVR1JelYBfIRbWSeD1y0Dc7Fy2FGDml+wz
         yGttfZ3vUC6v7dpMU8B6/oZGAaRdv/Qc5uBsAi/tf9lbb2N/f9uYAOqgwdlYpnr1QroB
         uAMH24MJZW+0QFx32qtwGGgAQ5bIaTfTeldztWxuf2v+EQMDh8wASDv71a2/vVDshm6s
         8gqW3ckO2+bP+Pj2JfygGeFOM8sbMFIFpdsKGX7YVoSxoNMsVr3sG9h4Sa60xHu1uqb6
         PeG63/ryZFfTMOX1j82HGYY9s7diE0vvGzk+sCdZD2QXp9/RZnyphXruNvcI0HkvIz37
         AFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012451; x=1772617251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HpB7gxHYv1RCrBGJEiZQU1GK/+eaWL5POIje2U5zOks=;
        b=sXFuXTwi9s+JOd0re30y7gJF0ABPyjwH1Ty4U6x4Ql6LV6YZyq6yBBLqjvGGlvEiRE
         vw+WLKZfbLb8zPNFlMZ3urAazqW6DqPxwT+ibkD/AqnlZ/bEBGiXp1PgR1gvAEmceBrB
         MBLtMtiB3sW/7sF/5fDtbm20fjIsZf2DMLGac3k/WzUxXd6vkiFAkjk70M4ICmQfAteD
         veksQACX63mVxkqJA9pnSl8f1OWyQmPBpc3k3Yu/RH0mp3gQU5V+LGzAodXUxAVBN1Gk
         3VvYo/e2xMQFHI1U7FIAUNNks+viWhh5vms0rTeDfqwahRB7HvSSMt7Fp/26IQxdDDA3
         5cnA==
X-Gm-Message-State: AOJu0YynGLJeF1bgk7TAk2MX4jQzGnNpi2RU3s1O6/Klr7kqctE5IBzp
	DkjaOb9uJ8pxfLfC+YfrudMPVuYkCWgF/dMaJyFOW5Ia1A/V0MDHwXU1
X-Gm-Gg: ATEYQzxirOsDcnWt7IKrU1H6Ebrup0fl9/AALLX2cnyk5rmzor5dnUl8tPp3PAoHrlW
	Hnm4/kyBLClMeFwRKuUwlzYxv4k1ixV+uG1JyBhX4pxFbqNXq3rhYQoj19CbYatJigJ/ZLcAPb9
	3rqpHET6OfPj67WdMyCyqTkRIxgiP/Gzz+PPsc3YUc2ux8LP7/S/w8Ii8s8Sm6hKJKmcPBqQyvc
	hRmcc7IQ7UIaTEGCcza71DC94foxthYsMOEtfMI5n9y8jY9rk1/SYzA7dN2gFa2YiWl74yJ9ZbN
	zNP5Z8P8rg1HriDD1IhX+hifSoL/JbBJshvNJDB712Mrk83VZIkjefhX1wv1tCAzZ5oOuccmx4P
	wILkgBOK2ItBwUfa+T4yjF4sP+p1OwMH0YyDswCPv/Z8NVUw7f7sQ88Sxi+ZuEO78jzE8wAGhAy
	EH7/v7HqZj4c3Z21meY7fSBOBL6ppzOVE=
X-Received: by 2002:a05:600c:45cc:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-483a95f554amr251079925e9.23.1772012451166;
        Wed, 25 Feb 2026 01:40:51 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d32e:ae2b:c73c:65c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm12956025e9.2.2026.02.25.01.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:40:50 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Feb 2026 10:40:43 +0100
Subject: [PATCH v9 3/6] refs: move out stub modification to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-kn-alternate-ref-dir-v9-3-3fe118e40e28@gmail.com>
References: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
In-Reply-To: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4830; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ORde0fdTcyXggqTNNk6zNTCVEag2mH6gRCQ9/9wuTjo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmew5wSLw8cD2zijvucRVDi8JSbN2+au/uA6
 bLYWTblCwHZvIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnsOcAAoJED7VnySO
 Rox/VYEL/0/ALuHnXZw/J+2UH0QHpQQoLXZvpL5DB+GjgNggN8R5XR89NUTf3m9kpoHoRyE7YIN
 2QbOaCvkhFEzZPQ0hnvQrzD8bhWyYhlRr4Y4S1NKVRYLJQSUR/6XM3jzOa0LzQJMoZQ7Zq2QMQW
 GOmwVYJ+H7E2Bnv1ka5PIfkxShUVlKNXcOhLWLmeIG/Jf6GYXO3JL2mesLmP2h2VT56I7k0FciT
 jpejwFBO0PN2J8qozL2hovpsC5s1htRD4JE2hT0Ki6zQmKcOZhzGOn8OYjltD/LP0+BeU2nriny
 n7L1piUAzo49gJnJrL19EHrq381/Z2qZf8HdL4swGIfgMJEWRiL3viiD5Uud0GO12nMDtbajNAj
 30YcRDCJeStbQPE7gUzdmFgMkFWHdPJYAK/KFyVoBiquaZ2q+qDTMFj9FoEpJHDyVAdcu/5XYE2
 yRFtv0gVeGiUWlML9oR7B8ZRFlge7Ucmwm9aSt1eXD5xyjGUspzzVgxxw+87ouVd00h1Qis7qN4
 20=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When creating the reftable reference backend on disk, we create stubs to
ensure that the directory can be recognized as a Git repository. This is
done by calling `refs_create_refdir_stubs()`. Move this to the generic
layer as this is needed for all backends excluding from the files
backends. In an upcoming commit where we introduce alternate reference
backend locations, we'll have to also create stubs in the $GIT_DIR
irrespective of the backend being used. This commit builds the base to
add that logic.

Similarly, move the logic for deletion of stubs to the generic layer.
The files backend recursively calls the remove function of the
'packed-backend', here skip calling the generic function since that
would try to delete stubs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 refs/files-backend.c    |  6 +++++-
 refs/reftable-backend.c | 27 ---------------------------
 3 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/refs.c b/refs.c
index 77b93d655b..c83af63dc5 100644
--- a/refs.c
+++ b/refs.c
@@ -2189,12 +2189,55 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
 /* backend functions */
 int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
 {
-	return refs->be->create_on_disk(refs, flags, err);
+	int ret = refs->be->create_on_disk(refs, flags, err);
+
+	if (!ret &&
+	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
+		struct strbuf msg = STRBUF_INIT;
+
+		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
+		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
+		strbuf_release(&msg);
+	}
+
+	return ret;
 }
 
 int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
 {
-	return refs->be->remove_on_disk(refs, err);
+	int ret = refs->be->remove_on_disk(refs, err);
+
+	if (!ret &&
+	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_addf(&sb, "%s/HEAD", refs->gitdir);
+		if (unlink(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete stub HEAD: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs/heads", refs->gitdir);
+		if (unlink(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete stub heads: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs", refs->gitdir);
+		if (rmdir(sb.buf) < 0) {
+			strbuf_addf(err, "could not delete refs directory: %s",
+				    strerror(errno));
+			ret = -1;
+		}
+
+		strbuf_release(&sb);
+	}
+
+	return ret;
 }
 
 int repo_resolve_gitlink_ref(struct repository *r,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 240d3c3b26..d3f6423261 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3700,7 +3700,11 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	if (for_each_root_ref(refs, remove_one_root_ref, &data) < 0)
 		ret = -1;
 
-	if (ref_store_remove_on_disk(refs->packed_ref_store, err) < 0)
+	/*
+	 * Directly access the cleanup functions for packed-refs as the generic function
+	 * would try to clear stubs which isn't required for the files backend.
+	 */
+	if (refs->packed_ref_store->be->remove_on_disk(refs->packed_ref_store, err) < 0)
 		ret = -1;
 
 	strbuf_release(&sb);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d8651fe779..6ce7f9bb8e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -491,9 +491,6 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	safe_create_dir(the_repository, sb.buf, 1);
 	strbuf_reset(&sb);
 
-	refs_create_refdir_stubs(the_repository, refs->base.gitdir,
-				 "this repository uses the reftable format");
-
 	strbuf_release(&sb);
 	return 0;
 }
@@ -519,30 +516,6 @@ static int reftable_be_remove_on_disk(struct ref_store *ref_store,
 			    strerror(errno));
 		ret = -1;
 	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
-	if (unlink(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete stub HEAD: %s",
-			    strerror(errno));
-		ret = -1;
-	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
-	if (unlink(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete stub heads: %s",
-			    strerror(errno));
-		ret = -1;
-	}
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
-	if (rmdir(sb.buf) < 0) {
-		strbuf_addf(err, "could not delete refs directory: %s",
-			    strerror(errno));
-		ret = -1;
-	}
 
 	strbuf_release(&sb);
 	return ret;

-- 
2.53.GIT

