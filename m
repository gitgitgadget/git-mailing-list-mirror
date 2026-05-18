Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5F405C33
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135587; cv=none; b=uaDUC8vc2fqGlll4k9ui4pH2jHVXFUWWP+aBc1Yh2GSrdD41eokHQRR1rLBqk2wvYKZIIHhxzA1X7LmXLC6zSE6p+6pniay6l3w1f8yraWsPRU8KPC8I2ACq1y3meoN5VVLGDoLcu6OuPcbn5ce6c9l8GOwrcvg7NAtsJed+mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135587; c=relaxed/simple;
	bh=ZVp2/Rw/oWHJd1SLVkDFsip/cShtgU+LOoHNXH5SxBg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HUpAaIsbWrJKsca8iBzW6Df6PqG01gCvk8eMUrfBzitDpRmkhdC9DQGQtkWzGj9pLYM7erBkHbduRoYat6/ZzPTFXFSvczNc6nsSAUq0hpSEi8rMsDBCy+tHXkVhRT4oK+nEJUYmtWql6DplxIXmCeKdl2BBd8wq+653/7gT2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNtwb0GQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNtwb0GQ"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b6dd874471so48279096d6.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135584; x=1779740384; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CN4wKvok4Gakc/9RmYfpdKyYsyE4j7fqEjqD/eb3ak=;
        b=jNtwb0GQsXzpyATpUkDcIB52i9lDx5+6yegZHC9DGLsHXKpWKQP1Grw5cJqwDGKYIz
         blqmkU3jOSHSNpcANi3ieWXzxv35OgqrEZDQ81KcpeS4G1sTbSYtrN3tNkDeir1JxuNz
         fnhHso5j1c8Ilxt8ktkSrsf4daiw4hV3nxfsIQFK555NS2+4goudYRFP7jJgW8AN1W30
         fsGYnrOUavGc5fC01U2IVXbZnLaRZk2rmeUWT4CeV6jR8hCE6AWjF0RxD035ZwEFzmH+
         1nyjMaZ+dftUaM8rTOimTG+wWtpuzKy5DS15sxOruKmACtEwjOXpq1RPyolpxuFkDSG6
         Dt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135584; x=1779740384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1CN4wKvok4Gakc/9RmYfpdKyYsyE4j7fqEjqD/eb3ak=;
        b=qe1GCtAO+xSvvoWCJOSI94BgR5LosH5B5lqwfpG20f43x3+xlG/iMVR+cCOQIa9pD4
         4l9s8qY7CGNnfiKT1xnfWib5+Fzz3e5yFFHpgXs36TG4Ng0DXQkOGLlT2vRwJpBEA7tB
         LaqNhOHKUGNQdyrMKxtfVARPgkW6oFMTLx8pWVPA2D1fvv1d3lly4wsdbEB7GJVTuAdh
         /GU6xgmta+qavGl/FjV0R+zpZXNFUlUF3Rt1PwoYcTBdU9mij346r7jsq39dv0Ftz0L6
         aV1WvoBswIumZLlLktIEyz7xF8+jCIYijKGTVktrg0Heagwzy64pkGhj7RP1642qjoyy
         yWkw==
X-Gm-Message-State: AOJu0YzO6aFQaqP9sHbteJ1UeGboSOWhJMd5qT+yxAthj3P+Y2h1XC36
	m6/neEcy9yFqLv9nVPY3WD1PmFw/V6/bJFEjrat6pIHBjI77OevuLTxzVXtE3Q==
X-Gm-Gg: Acq92OHyxbcPxG6STcajkUZyopFP9n4DXePG7TiUgpv3fQWsn1T4miidQcBIWZ1vEyt
	MCRnVUuIFPVQxR7AS10z5bzg/N82zVcFj/d7/TOYnO8191o6Xvwyd9bfy+/MKmCv+8kPj7JNh4A
	IF6obpjpJYC0JNclNQONVp7jc/mAcBFaONR6TdABHTJjKT8pvfh48Mc8UcbXULGBRL/ImRQqMBb
	0qiezmmzC325MtRtejsxc2BEtuVadO9vbNFW65VtpkLjt3Syp4iAj3FWUhr7YiIL1j+M3eRCmo2
	wmKATws8uQqYXz24AgSmdntXujNvV5KqpcD1hZdmTZZ5DSS7I8Oa61jk265f5+7osDcpJzGHupE
	US7v93UJQ/JdxrCMMNYuRPuPDQa8dJ2NZ065PP2OkrIHBr+oXvPPuVN81YM7MyQP3TuWFx4U8qG
	faBmHHXs6rNau7PpuWprC2bGCW
X-Received: by 2002:a05:6214:3486:b0:8ca:1d2d:4a3a with SMTP id 6a1803df08f44-8ca1d2d4ed7mr206489546d6.6.1779135584322;
        Mon, 18 May 2026 13:19:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360b4950sm67037396d6.20.2026.05.18.13.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:19:43 -0700 (PDT)
Message-Id: <d423c562835fc3bd3f874937101700360d99b1be.1779135575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
	<pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 20:19:31 +0000
Subject: [PATCH v5 5/8] negotiator: add have_sent() interface
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In a future change, we will introduce a capability to choose specific commit
OIDs as 'have's in fetch negotiation, with the ability to have the
negotiator choose more 'have's to increase coverage beyond that required
core set. The negotiator works to avoid emitting 'have's that can reach each
other, but that logic is hidden beneath the negotiator's iterator function
pointer ('next'). We need a way to communicate to the negotiator that we
have picked a 'have' so it could incorporate that into its logic.

Add a have_sent() method to the fetch_negotiator interface. This is the
signal that allows the negotiator to track the commit as already shown and
can perform the proper bookkeeping to avoid emitting those objects or
anything they can reach.

For our non-trivial negotiators, it is sufficient to mark these commits as
common, so the implementation is quite simple. This logic will be exercised
in the next change.

Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 fetch-negotiator.h    | 9 +++++++++
 negotiator/default.c  | 8 ++++++++
 negotiator/noop.c     | 7 +++++++
 negotiator/skipping.c | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index e348905a1f..6ca422a064 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -47,6 +47,15 @@ struct fetch_negotiator {
 	 */
 	int (*ack)(struct fetch_negotiator *, struct commit *);
 
+	/*
+	 * Inform the negotiator that this commit has already been sent as
+	 * a "have" line outside of the negotiator's control. The negotiator
+	 * should avoid outputting it from next() and may use it to optimize
+	 * further negotiation (e.g., by treating it and its ancestors as
+	 * common).
+	 */
+	void (*have_sent)(struct fetch_negotiator *, struct commit *);
+
 	void (*release)(struct fetch_negotiator *);
 
 	/* internal use */
diff --git a/negotiator/default.c b/negotiator/default.c
index 116dedcf83..05ab616f39 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -175,6 +175,13 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return known_to_be_common;
 }
 
+static void have_sent(struct fetch_negotiator *n, struct commit *c)
+{
+	if (repo_parse_commit(the_repository, c))
+		return;
+	mark_common(n->data, c, 0, 0);
+}
+
 static void release(struct fetch_negotiator *n)
 {
 	clear_prio_queue(&((struct negotiation_state *)n->data)->rev_list);
@@ -188,6 +195,7 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = CALLOC_ARRAY(ns, 1);
 	ns->rev_list.compare = compare_commits_by_commit_date;
diff --git a/negotiator/noop.c b/negotiator/noop.c
index 65e3c20008..edf1b456f3 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -29,6 +29,12 @@ static int ack(struct fetch_negotiator *n UNUSED, struct commit *c UNUSED)
 	return 0;
 }
 
+static void have_sent(struct fetch_negotiator *n UNUSED,
+		      struct commit *c UNUSED)
+{
+	/* nothing to do */
+}
+
 static void release(struct fetch_negotiator *n UNUSED)
 {
 	/* nothing to release */
@@ -40,6 +46,7 @@ void noop_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = NULL;
 }
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 0a272130fb..69472c58e1 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -243,6 +243,13 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return known_to_be_common;
 }
 
+static void have_sent(struct fetch_negotiator *n, struct commit *c)
+{
+	if (repo_parse_commit(the_repository, c))
+		return;
+	mark_common(n->data, c);
+}
+
 static void release(struct fetch_negotiator *n)
 {
 	struct data *data = n->data;
@@ -259,6 +266,7 @@ void skipping_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = CALLOC_ARRAY(data, 1);
 	data->rev_list.compare = compare;
-- 
gitgitgadget

