Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740380;
	b=LAa8icwisV+H7vhWBu8GazR1bqie6ucyOSCQZlgSxoT/E48gC5W24QLFwvJ7+BoGDIFs
	 DyAYDbr5R/q76/2dqvgMNXBfiptsn9Rtn0ookAkYRAA4KPUR8rCzLgk3WofZtlerVFUIa
	 izMbqYiKOfd9lqpZyBwWE6ZwHNUp9g9zmqUhzUlCkl0qHsvM08qWzWimgjNmsbF2hggmd
	 6FrSZq2FKcT/BUYOpoYNRMS5PEVubuoyxME8DLw9a5PQueKxDS3orbsx6Lsk3xsETw0sX
	 SkTKcvgMYAbc+QfMFZ1lq7vx5+SqwbGOel7CGZNRnbvfFUiTfi1CKBP+TUxjZIwDT5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LaKXgKlAX4rB4OWuX2MaBYflj7I2g5T3//Qd/ASLcXE=;
	b=dx5i2ZrKiXXAn3MudgYQkLeZu4/zSw+demeH0+EsjTttTDWaMKIoQGf3JDRjgST27DU3
	 y79ahxhcBXZQCskDGuz6sC4JJkHGOYkGWvIqw1V6j3jZnif8/sldr/SxqIydQnRoztwmo
	 p3UMqJCrgw1XD4npCoZyN9sJDTlzmixGDIDedy6nmpj9kGPepwV90CiHzilbKKpy6+3L0
	 sHZ9omYCWFpBVei7O3gXFsUM4JtVCkxy83gDMfWDsvQdkRBF5VFNwFvrwOUL6+vfw+Tta
	 gtro13yfXjoogOoWyj3uiQBWfFnRz6UJv0HBxA1Jf4mExlZ8ANDEgoyIm/PZyqjuCLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rVsUyz1f;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002D606A32E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0002D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rVsUyz1f
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afbd2c386so264569f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740378; x=1793345178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LaKXgKlAX4rB4OWuX2MaBYflj7I2g5T3//Qd/ASLcXE=;
        b=rVsUyz1fEpUzIKMS/GE1zCgsvfmE/RJZmJ+0mhiedk9dUMIej/Ano5UKkvkFgqK2QP
         thJVcGSk/qmsJ9+hgu2ZMwQuetpy7KGq9Se/uejR9XUP/fDLFmQFsZMi2ThXjfYcPGsW
         /VbS5efW4yNLztMB7QZLfs8ZCFtfPzaCO4RZVSkjELjvMlsRrWwOQrWPCls5E0NySakN
         cAaJfSHvKGzHJYaiIe58cetaeTq2HMIlEnWxWZLt3IYv+gZlO1b4d5oLD4GQWZjy8ZrV
         Za8tsCq0GTEu5Ra0ImfwDfPCBWfpjftmM9IPOkKThsdEdkxjXx3qRz38EvfPE7iXMkbQ
         cpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740378; x=1793345178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LaKXgKlAX4rB4OWuX2MaBYflj7I2g5T3//Qd/ASLcXE=;
        b=S0m2tkxdYfhu6cJVlT8kpjYv4fcY6y3b/IVuFUCaCSnK4BxIQEOkSAGIMyZfilW+Qi
         fbJ6cuQTbgMvROT70JbyzKVAeeBte3ejF+K7eG+Jbe7iPerZA1mkvXz+8FaLDNt+hLlc
         9DW6qNzgXPdYWyR3o77i/hhmSYNLtLYiOjqnQx+GWY+cCW6ZR6sqGTT17SuM8vptW5DF
         Jeio6//quEMl3kknE90uNa0O20uUm2/Hh8Qrk4a1RB9sh3zMf0TpeePEcAYZ2gOh66LS
         /C1qg9Oz6mLNddmhp1KN+cj3r3CEwAya3QI8gjdlB9zxpPYgJRqkTHIJdk3iPjDsF+vo
         r3OQ==
X-Gm-Message-State: AFq9FYIv1MIs6RXNDZ8szXPHrCHcOGXUoA5qLC7wrz+iR8hHBVLNgt6e
	eM5yoOeI3I1vZkqSCo2PB5zLPy3r1zfdeIBLyAPzBlfoIdgQydPlWq6okpQZjA==
X-Gm-Gg: AYBFou09WERzJuT6wIqhDAjCET9r8wEOxmW4Vv/wuIywadWlB8hN6KbmF7FRt7LljHs
	Q33yz6qBFM9ATPnj7dL1hs7GbSVoAlP+fe5X/UOtlEsgAXEtJNiiIslDFvQdAh9L1HqJuXVz5K5
	YqCOpnvqvH5gX5i2JCHc9PxMRRuP/9V9bTxNPKXQGpyJtdeUDoofHYVA9uqWLJyd4JvptwOXYLF
	/2OemJGWeDP3It/TGuZn+GaOPVwwnDtvjs4ijklFGNRmB5seNLtbzagAcW5KnfDuCCJF/BFfDLk
	d/7FufqkBu081nSLwSBOmAyO5PsAxqUTkONEUpNsteGjY5tyBmihABtMI3x9KIi4o4DkDTvjH0H
	/hGxL7ajcob7vaDckUR8GBstvlfZ0623JJVhOHON0uowlmBjsQtFiSv4rIg8u01M7erP7BLVcj+
	qvUgWiWwqjOzXHLdYPK3pAeMKJC7kyXx+tBQPSzMa7PlM2tEMPhfXrqrkpbAOIAfqM6DNXevf7r
	ar0iabwQD1e5RCHsC8I6O8q5kFiq5aVBsxTLD+WqRbXktuy2zyKOjvHkitdVs+A3cI0NQjsW3MZ
	WTPqqWQqRee6SOy+RnoGFQf59WmP5NkXPsjdWUsLbzlVSzGiPo1+kWYjRi9/2Z49CiSiP32vbK6
	v2u+B/kY08EhWQVpmoC+b4Lgs7EEzFBNrFA2FQ5jg3DQ4gLnma5bWiSVOvFFyMnNdUx1V0diY3M
	IlfUDW390z1pE=
X-Received: by 2002:a05:6000:607:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-48e385467d9mr2158325f8f.4.1792740378230;
        Fri, 23 Oct 2026 00:26:18 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 02/13] loose: rename repo_add_loose_object_map
Date: Fri, 23 Oct 2026 09:25:47 +0200
Message-ID: <20261023072559.3204273-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <sandals@crustytoothpaste.net>

The pointer it takes is not a struct repository, but a struct
odb_source_loose.  Let's rename this and we'll use it in our object
database abstraction in a future commit.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 loose.c            | 6 +++---
 loose.h            | 6 +++---
 odb/source-loose.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/loose.c b/loose.c
index fe8f540979..8d7ea27448 100644
--- a/loose.c
+++ b/loose.c
@@ -210,9 +210,9 @@ static int write_one_object(struct odb_source_loose *loose,
 	return -1;
 }
 
-int repo_add_loose_object_map(struct odb_source_loose *loose,
-			      const struct object_id *oid,
-			      const struct object_id *compat_oid)
+int source_add_loose_object_map(struct odb_source_loose *loose,
+				const struct object_id *oid,
+				const struct object_id *compat_oid)
 {
 	int inserted = 0;
 
diff --git a/loose.h b/loose.h
index f3b1e47363..6f0c8554ca 100644
--- a/loose.h
+++ b/loose.h
@@ -18,9 +18,6 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct object_id *src,
 			      const struct git_hash_algo *dest_algo,
 			      struct object_id *dest);
-int repo_add_loose_object_map(struct odb_source_loose *loose,
-			      const struct object_id *oid,
-			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
 int repo_write_loose_object_map(struct repository *repo);
 
@@ -28,5 +25,8 @@ int source_loose_object_map_oid(struct odb_source_loose *loose,
 				const struct object_id *src,
 				const struct git_hash_algo *to,
 				struct object_id *dest);
+int source_add_loose_object_map(struct odb_source_loose *loose,
+				const struct object_id *oid,
+				const struct object_id *compat_oid);
 
 #endif
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 0664634938..3c0c85f3e3 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -848,7 +848,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 		return -1;
 
 	if (compat_oid)
-		return repo_add_loose_object_map(loose, oid, compat_oid);
+		return source_add_loose_object_map(loose, oid, compat_oid);
 
 	return 0;
 }
@@ -970,7 +970,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = repo_add_loose_object_map(loose, oid, &compat_oid);
+		err = source_add_loose_object_map(loose, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
-- 
2.56.0.215.g47fdf2208c

