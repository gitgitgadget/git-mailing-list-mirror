Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357911;
	b=ltTM4zKF4C+T0+T9hfBm5+TgH1r8kY/+PmobokttK4w/Phx9Y0d5dbuVCI+kyZ6BjZZq
	 XEl5t0fb69mPKHq4KLf78ihtvNT5dIRdCvxjzE4wSDatsCNssDBcRimmCkdQBAkp08hDr
	 NiQyuVUbypnWK/lrU3J3r/zPbuV6b0vXof8dNhqVCOfiqENc5r2K4bygsEnlIcQBnp3yC
	 G4ccYhxKJ+shwM+Z4figA4yiOADGlF9uW3e9Yyp6yStMhOPy23AAagJd/FKSoQMungN9N
	 LtklVwUoC1pS5lvJKmQorXmEuIwiA+VXbdZFbQU6trXhAjKgFUAP8qAt8aJjgRO3mMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hF/lLJMqqzREKWNSlzumurXYlryR7oMCogNRABs1bO4=;
	b=s1cCoyqOG8tzZijIwHIoFS8oXUUZpOEpADMyagHgiL89JrUxMPdvNuZ4QwfldSDqfNLQ
	 RCeGOm1DKRUZyPDymIcc++J58Uy5MgHoIjxhibYguhBGtpyUtLHal7ENetla5BFCeSbx9
	 QWBePQlny1MCv4b8B4XRt54kVVXnDqq1tgXCns3a/TP70Cbmu6imk8zNEKvIFxDNLHnyW
	 0lF7rpbu7wKi3E5OlAPPLzXPSRKz8JIeb6ot8vOiWs0uEbvnWSKyN/xIIDnUYlk+rxuHc
	 HdiSKeoGHyTYi1Bx2/lApsdXbD6VoF8r/WDL0uZD+8eL1MVBdqdwL1MDxPKhX1LoWsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hu4oyYoa;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCA606B97F
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BCA606B97F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hu4oyYoa
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0728so136500f8f.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357909; x=1793962709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hF/lLJMqqzREKWNSlzumurXYlryR7oMCogNRABs1bO4=;
        b=Hu4oyYoaZ7dsfCTF1riYphLnbX5UMeFBfQz7QCGwXma0DXtbHZT7M/dv44+Ec7x8E/
         xhlZbkK5nJr9CBcyoQM3Azge6ESnUk/MwCM+uLfl+vlEtXgYJ1r8TTsGh8l3lGHbqK/S
         W728zPWwAghJvc3ZsHYmpdFBcjoiQV0utDmChPRUvXQanA3ZF3Ve71VyiuAKY2HP2Bex
         vbN+cD0N4rWQGFuMgfdleTta+TJioNr+MS6TZ9hf+kuHB3l/PQG4aoC5VcVGkI7NGHbJ
         h8VjTQ73wTPcBwjT31Dtmny7vdb7yYt7CcHf1A1G5MmgIPgmSWLHKSv3rDe1cubHUWvt
         1Yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357909; x=1793962709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hF/lLJMqqzREKWNSlzumurXYlryR7oMCogNRABs1bO4=;
        b=o+a5kw8uuDuTtYYuZIBKQzxNBHyHMA1YREB5lEfwvg7BsE07gnHczYkr6zEakEhE47
         2+w+i86ITww4YLvjC5/CtlMx34wjCoV5gXX932Jl/W6AX5JQ7opcDLIuYLjE6u7LqfJY
         hhEir3b12ehw6y+sRJfypUu8DjrjuZk5NDcigBcFArsBaHFttEQ2PGYhHxfjNqXML0O7
         VYNyiKsOVh/2aXtl136lICEEsrhHQWU/gCmrZttX076Q+YAvp7/gWjo9ecWGH4N5dn0q
         gozyPHQmuOrR3LoNW5KSEjIFGVvIzMxI6WvC07NlM/EDMkSy0gNK/r/1SAOL7gWMFzfl
         PQPg==
X-Gm-Message-State: AFq9FYLN6nzQ4Pi8MdEjL7CUYVM6kBA9ZbBrA2oKMw44P3ihyGn3inyT
	EckfLA6JtKKDiNBRV8G5mN20YCnNBe/eYuMU574kQ1oPn7kxeIqmkcJnoftFYA==
X-Gm-Gg: AYBFou3qjacZRKle7uYIFm/heK28keoRddw6bvbaUYqHvlJsPzpvXTr83kO1DSbhlhE
	Ngol6Pt35gaIyqQXG8+AMaky+ZJi7hgilVABG7FUVw1E9B6ucy3DPwwuY7eLZWFgAc3MudkWWDr
	U3GIV4xfpwJtowBINZP1Sldwvg0nHtyfCyym32cyV1Ke/3WWq8FvawSkYwEd2JldFF/eb/Ynzw8
	ql7GXeavsC0hTMt5IxqqD2cnAZ5j3d55N1YxO0ynqefhWNejQ7Kkc+stD2q46gKcEFWITfcCMdw
	010f6doW0JBmnLaDuuTa/xjOH5k/uyQpkFobfAFZjhEM/OikICofAH2l6OORWgPX4HRuIMUlJF7
	cKl3USOENw6NFkI/Xm/iY5St6NwKCCgwuSyM/V5bLGEpEQ3L2jyC5/W4HNyCpdllfY4/lHFf/OT
	jSAnQk4/mDH3n65DvgTzvf83yKm7cc6b/RgI5jyzjos020mIPxCvE63AvvLH+Ep7rrStKQJs++a
	mKpddzq+Xx6uYDarsgxie7N9Ul4m69E26w/Dp3zyzo5Zpsq1V418cK90n5WVEKIWEFPBn9Zil7d
	mPrWy8q1Jw8MnV0jDIUfF2X/QyWkRKgtRfOUONfegdXuem7lJQ==
X-Received: by 2002:a05:6000:2209:b0:48d:ee0d:8b3d with SMTP id ffacd0b85a97d-48e6e2f6d6fmr4763914f8f.28.1793357908898;
        Fri, 30 Oct 2026 03:58:28 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b727c6sm2677980f8f.16.2026.10.30.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:58:28 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 1/2] tree-walk: use size_t for the size of tree buffers
Date: Fri, 30 Oct 2026 11:58:22 +0100
Message-ID: <908bcf7a607195d7f5215f191a85f25ab0059e8a.1793357680.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793357680.git.gitter.spiros@gmail.com>
References: <cover.1793357680.git.gitter.spiros@gmail.com>
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

struct tree_desc keeps the number of bytes left in the tree buffer in
an "unsigned int", and init_tree_desc(), init_tree_desc_gently() and
decode_tree_entry() take the size as an "unsigned long". The size
comes from odb_read_object() as a size_t, so for a tree object of
4GiB or more it is truncated. As the field is an "unsigned int", this
happens on all platforms, not only those where "long" is 32 bits.

The walk then sees only the first "size mod 2^32" bytes of the
buffer. decode_tree_entry() still checks that the NUL ending the last
entry is within that size, so we never read past the buffer. But when
the cut falls between two entries, the rest of the tree silently
disappears: "git ls-tree" lists fewer entries and exits with 0, and
fsck_tree() only checks the entries it sees, so its checks for ".git",
".gitmodules" and the like never look at the others. When the cut
falls inside an entry, we die with "too-short tree" instead.

Use size_t for the size in struct tree_desc, in the functions that set
it up and advance it, and in the struct dir_state used by
get_tree_entry_follow_symlinks().

There is no test, as it would need a tree larger than 4GiB in memory.
Truncating the size to 16 bits instead, in init_tree_desc_internal()
and update_tree_entry_internal(), makes "git ls-tree" list 10 of the
2058 entries of a 65856-byte tree created with "git mktree", without
any error.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 tree-walk.c | 14 +++++++-------
 tree-walk.h |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index a67f06b9eb..aaac1fd48d 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -14,7 +14,7 @@
 #include "environment.h"
 #include "read-cache-ll.h"
 
-static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
+static int decode_tree_entry(struct tree_desc *desc, const char *buf, size_t size, struct strbuf *err)
 {
 	const char *path;
 	unsigned int len;
@@ -49,7 +49,7 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 
 static int init_tree_desc_internal(struct tree_desc *desc,
 				   const struct object_id *oid,
-				   const void *buffer, unsigned long size,
+				   const void *buffer, size_t size,
 				   struct strbuf *err,
 				   enum tree_desc_flags flags)
 {
@@ -63,7 +63,7 @@ static int init_tree_desc_internal(struct tree_desc *desc,
 }
 
 void init_tree_desc(struct tree_desc *desc, const struct object_id *tree_oid,
-		    const void *buffer, unsigned long size)
+		    const void *buffer, size_t size)
 {
 	struct strbuf err = STRBUF_INIT;
 	if (init_tree_desc_internal(desc, tree_oid, buffer, size, &err, 0))
@@ -72,7 +72,7 @@ void init_tree_desc(struct tree_desc *desc, const struct object_id *tree_oid,
 }
 
 int init_tree_desc_gently(struct tree_desc *desc, const struct object_id *oid,
-			  const void *buffer, unsigned long size,
+			  const void *buffer, size_t size,
 			  enum tree_desc_flags flags)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -113,8 +113,8 @@ static int update_tree_entry_internal(struct tree_desc *desc, struct strbuf *err
 {
 	const void *buf = desc->buffer;
 	const unsigned char *end = (const unsigned char *)desc->entry.path + desc->entry.pathlen + 1 + desc->algo->rawsz;
-	unsigned long size = desc->size;
-	unsigned long len = end - (const unsigned char *)buf;
+	size_t size = desc->size;
+	size_t len = end - (const unsigned char *)buf;
 
 	if (size < len)
 		die(_("too-short tree file"));
@@ -561,7 +561,7 @@ int traverse_trees(struct index_state *istate,
 
 struct dir_state {
 	void *tree;
-	unsigned long size;
+	size_t size;
 	struct object_id oid;
 };
 
diff --git a/tree-walk.h b/tree-walk.h
index 9646c47ac5..5ccd4a9361 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -35,7 +35,7 @@ struct tree_desc {
 	struct name_entry entry;
 
 	/* counts the number of bytes left in the `buffer`. */
-	unsigned int size;
+	size_t size;
 
 	/* option flags passed via init_tree_desc_gently() */
 	enum tree_desc_flags {
@@ -85,10 +85,10 @@ int update_tree_entry_gently(struct tree_desc *);
  * members of `struct tree`.
  */
 void init_tree_desc(struct tree_desc *desc, const struct object_id *tree_oid,
-		    const void *buf, unsigned long size);
+		    const void *buf, size_t size);
 
 int init_tree_desc_gently(struct tree_desc *desc, const struct object_id *oid,
-			  const void *buf, unsigned long size,
+			  const void *buf, size_t size,
 			  enum tree_desc_flags flags);
 
 /*
-- 
2.53.0

