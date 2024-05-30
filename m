Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388B14AD25
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057299; cv=none; b=N9r6Aol5rv9vDdVWbcuzHQIYrEmzwvXuIPvGW4iX599Op0/Xqrs1x81jlOF25bZ0kagTxkIT7XoJ5R9odfTzmrFV0kslrvANXPqCthDbOeLs75Gxw+p7c6RNJ5c5sNUy6nAS6zYd/eGyaGE2D8f5MPRp3wjZbN1+FWmkEs5Ud5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057299; c=relaxed/simple;
	bh=XLb5xiWA4dAF2Fx/JHqqeBya6F3OqFt/2QpQOAIOTOo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YZt8s7ENehDmccewF6yiAebWfMJx4xbQxmppGzN/+ijGTV//53SNijumLpGzAa9UcxgEiss++abgUKt4ay/42M0km6wauP04cc9/+yNqx3KmkW8xQEmki5wUJeiJ+6EOfZpQNQkedKyooPjeKbA5wjdTGsOTFiXr2dVbYpaYwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nExw0WkZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nExw0WkZ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ac0c4b62cso627920e87.2
        for <git@vger.kernel.org>; Thu, 30 May 2024 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717057295; x=1717662095; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G968azMSMZxhGCb7WK9dg8PxA15ncjcjODXB2hpkuVM=;
        b=nExw0WkZUV0T3HRy6xmorSpMhfN4YjIEjsNhDm8MHQASVGSH7h/n6emqw34yJBcbl9
         eWSEzanwEvuAASbXF4hSg7bI7IsDyqiXl/1UahzYIQJ46AmJf2pqhryt6JHAmT8wc6eD
         /yYL4qrn9u9i3Jx/BjEcizuxtVH4ZxUgtmjCktsJvCYSOmMdpkfz9cnoK9qE8tH9hx81
         Z741Z5Uqnwh1qE9f8Op5UowjZ7G8pItZ2wwNQEVv92B/uiqJtXv7lDRWxHCX5MYHxnNF
         FdRbmS+3jjn1lpGOzrF2Nt2/gdUVzVvl8nttJYjSxv35vcVNZ1y/IKTDBswpakOI1+xH
         /1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057295; x=1717662095;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G968azMSMZxhGCb7WK9dg8PxA15ncjcjODXB2hpkuVM=;
        b=Ei9gmz8mXqUy+SURvL5d+XR5XYIiVN+bGNF/nBYA4KzQkSrAUgfzOTWQ7oZ9ASjQlH
         ifxJu40+3xhNJqnLNJSHP5wy/+lMGnKZFaxAMlRa1oVH7YoulhXsyKlviIL4mGQK2GRV
         kyuZAxRlG2v56mTcG5sJxWwij7C4vls5VywAd6YDIBILzkXLZ/S4uTnxvm1iwIAGXL68
         nTonK3EFK3FbqqjfvPGs4ysD08YMAdYJbbJzHt082TkpBQcoiO0b8IuoAaxm77KqdBSH
         BJ4sj0OLto8HFWRJtkrCMYV4Wp1ECCRgAZ9ke/hbTJqatwBd//84j2DNpwd1KN52kVoI
         SlOQ==
X-Gm-Message-State: AOJu0Yyt1W3OyNzzScoVdUw+NGzDlEofNHk5WaqcxoFLFCPo1xrbzL3v
	pgx1pHDIpic6R8Mq18sMSrEQrICsn4mrDr3nQBYXcSMES7uWcBSoxJEkag==
X-Google-Smtp-Source: AGHT+IHGVBdqkR9g59JodGPel5lRg2/N3+xZaDA61B8nXkXABg8AfwpX6eTeNt2D+fSu8Qx8zt3tlQ==
X-Received: by 2002:a2e:8ed5:0:b0:2ea:75c4:5621 with SMTP id 38308e7fff4ca-2ea847754f4mr6187621fa.7.1717057294978;
        Thu, 30 May 2024 01:21:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7d88esm16903163f8f.19.2024.05.30.01.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:21:34 -0700 (PDT)
Message-Id: <5ddc894c2c16db109ef96a07d8a2b623b855d95d.1717057290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
	<pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 08:21:29 +0000
Subject: [PATCH v4 3/4] fetch-pack: expose fsckObjects configuration logic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Currently, we can use "transfer.fsckObjects" and the more specific
"fetch.fsckObjects" to control checks for broken objects in received
packs during fetches. However, these configurations were only
acknowledged by `fetch-pack.c:get_pack` and did not take effect in
direct bundle fetches and fetches with _bundle-uri_ enabled.

This commit exposes the fetch-then-transfer configuration logic by
adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. This
new function is used to replace the assignment for `fsck_objects` in
`fetch-pack.c:get_pack`. In the next commit, it will also be used by
`bundle.c:unbundle` to better fit fetching scenarios.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 fetch-pack.c | 17 +++++++++++------
 fetch-pack.h |  5 +++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7d2aef21add..3acff2baf09 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -954,12 +954,7 @@ static int get_pack(struct fetch_pack_args *args,
 		strvec_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (fetch_fsck_objects >= 0
-	    ? fetch_fsck_objects
-	    : transfer_fsck_objects >= 0
-	    ? transfer_fsck_objects
-	    : 0)
-		fsck_objects = 1;
+	fsck_objects = fetch_pack_fsck_objects();
 
 	if (do_keep || args->from_promisor || index_pack_args || fsck_objects) {
 		if (pack_lockfiles || fsck_objects)
@@ -2046,6 +2041,16 @@ static const struct object_id *iterate_ref_map(void *cb_data)
 	return &ref->old_oid;
 }
 
+int fetch_pack_fsck_objects(void)
+{
+	fetch_pack_setup();
+	if (fetch_fsck_objects >= 0)
+		return fetch_fsck_objects;
+	if (transfer_fsck_objects >= 0)
+		return transfer_fsck_objects;
+	return 0;
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[],
 		       const struct ref *ref,
diff --git a/fetch-pack.h b/fetch-pack.h
index 6775d265175..b5c579cdae2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -101,4 +101,9 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
  */
 int report_unmatched_refs(struct ref **sought, int nr_sought);
 
+/*
+ * Return true if checks for broken objects in received pack are required.
+ */
+int fetch_pack_fsck_objects(void);
+
 #endif
-- 
gitgitgadget

