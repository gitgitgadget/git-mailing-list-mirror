Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C240B6C3
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679869; cv=none; b=YbFw5EFZ4XSFtr7lKjAdgZKIGZTbbXe8tlb2s3RzbgDCoPPQb2O3sniyk5WDahQWcxZSAJSmbwG4yqxNrCucP9IbXghKo5Q5GZYV/jrAyvv8/jBSzeX3gaAZXs+vd8EPvMgzuM64WSSm53V/ngzBgndI0Qzqy8+p/f8BD6ivaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679869; c=relaxed/simple;
	bh=d3O264YOAPhSs3LowgQv+OytQy4Jom6SpOx2HWimA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+zQhxcWhgwHUeKH7eNYN9oYaxSpkpdoKZyk8Khk76GSKWF30D2mcCGlrtTMJArsV1xy4X2e1xD6q5+RtiFjtjRdVP4f6eAWNLQ3rLKkWG0PPQG9ChQGBc4yM6oD/wKQ1A1qdJq/YTUlfUK6v4tCSNDw/MPGNYO7eD82mue+vkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI/MRZd3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI/MRZd3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso509988f8f.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679865; x=1784284665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=AI/MRZd3/iAdvAOOiSxrNk8+TvR4HpArt/MK0DAh6Fywqvz2rFylpsc8da/b5A2TYI
         Oil9HO6R+eSC/OE/os+9yrD9Tw9FcLryp4C4r5qIgB7e739swEm6XeFGugqkrdA0rCNd
         MdOxe6Kt8SXcOkeUzqNA8Sv/Tee25C0EtKVlBVhxauPNA3ZQ1rHp3TbPtER6k1rtgBaR
         F2ces7fnvwlmLTu3Sx6Q0pX3cfA1acYv/UaT965TRDP2FXMaIMgvrWW/nsv6Z7r42k6t
         jwM/LK/QCN8mTFtrQwFjhoXYuZcIYBiWl9JmFm6RhSVSHelUiX1a2sg6OXPH5gQsF60W
         5ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679865; x=1784284665;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=r+5Lgf82ATUmY0M6uOi6RnEO7OlR/B6sVIShBNpw07T6RQ9al6yMc9/+J4VmySoKpe
         qlx01LyyW1J2aDwKzN57DkSR7SIL4gb8jv3LOBqpADZ/rjudsMWSDR5UnUbg1eVbJxU8
         w8eDjC7j8YCg6VDwDkVfaJDY/+Zxaqajof44G3XYaau85N0nJP5YJe/mgalZSrCNYTtW
         jTmOzVMYxCnMr1k2vzbb8ODanrZM1CSga3BLo0ZPmHA4SYdEhS8YDz2bNpbzVYc9hKgS
         7v1FqMuAKPL5975Vp1u5ZimhPp+AxEQcY6co95TbPj3UXPRHNJUZpCjKZWn/EiBXjXNV
         m+LA==
X-Gm-Message-State: AOJu0YxIivs10Zk0cGoN1D5tb6Rn91+90/uMxR32pyMT7XGj6iyzsvSl
	7LbuJLTwF9XLdHWRqNO1BookKv5HcWhSV6CSmSurc3m3OPdp0ysUfyQb78UygwUd
X-Gm-Gg: AfdE7ck+7/btzLH6Ibg2iudUh+3zw81WzcgSxUt+1aV6g9OFCATzFgMZ9S/rmoG9ghF
	S/LVa/xXGBqeZlQxgvTMKxkCJictPbF0WqShDxNgeQ6mjHB8btLm2cG+NIOq6TYN+r6GUNDmzhx
	9VwBwzfpgda+fM03Wu3z8iev8ZZfaR8eLT5EnVenDDg5Oa8V+KsVFnxPH3xMPEiJjQpHEJqenD8
	oAghOvtFxALlYE8ZpSJ9E5+eLgAOhU5ayCR0zUSUJBVy5zM0oZkx1w6YV22mfRNLGv93sUU+x2U
	tw6mLz2ohGHgH01mPiqpUyvInVps8Jb04EKCwI4KxsQhzGJqCTZ18yb8r+J3JE4e1yFstTxv2qu
	aXWWzdzzW54CDxdOF4Nt9O3l4PoqDkg2RBESSX5YQzgo2qcwrUKbd2W/yFizT9f72lkCh4+vgbW
	s2nHqMadyyF5BHnfPnTNbjmD9lB0YI8TfiELerKBU1sG1DibtVSnRtltwdBNIqujFm/djHYIV+O
	71z4590tfYeSnBz6NsEGzmD1qo61B48RxizsSJuSVNDo9WiY/WXsismPlh7YQkELJCG9uyZnSqJ
	aNeNe+wSbVftGS5j5SlFi6mAxoFIY47oXjtytV5qvuwOLM0DdbEPoNKaxNEkTiaTFKTP+IfIfHX
	sn9x/qRCQFQ==
X-Received: by 2002:a05:6000:420e:b0:475:f0f0:9eed with SMTP id ffacd0b85a97d-47df0776194mr12013917f8f.50.1783679865436;
        Fri, 10 Jul 2026 03:37:45 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f25b23b7esm4222784f8f.18.2026.07.10.03.37.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 03:37:44 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com,
	mroik@delayed.space
Subject: [PATCH v8 2/4] revision: add next_commit_to_show()
Date: Fri, 10 Jul 2026 12:37:05 +0200
Message-ID: <20260710-ps-pre-commit-indent-v8-2-d3b636463bf4@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
References: <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
 <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

get_revision() gets its commits from two sources depending on the mode:

1. Normally it gets the commits from get_revision_internal().

2. --max-count-oldest which was introduced at bb4ce23284 (revision.c:
   implement --max-count-oldest, 2026-05-19) gets the commits by popping
   from a saved list at revs->commits marking SHOWN and CHILD_SHOWN on
   each popped commit.

Extract the choice logic into a helper, next_commit_to_show(), which
returns the next commit regardless of the source it comes from.

This has no change in behavior. The helper is needed in a subsequent
commit that pre-fetches two commits into a buffer for lookahead purposes
and needs to pre-fetch from the same source.

The --reverse branch keeps its own pop loop. Using the helper for
--reverse would additionally set SHOWN and CHILD_SHOWN which is not
desired and a behavior change.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 revision.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/revision.c b/revision.c
index 0c95edef59..288935943f 100644
--- a/revision.c
+++ b/revision.c
@@ -4658,12 +4658,34 @@ static void retrieve_oldest_commits(struct rev_info *revs,
 		commit_list_insert(c, queue);
 }
 
+/*
+ * Returns the next commit that will be shown, regardless of whether it comes
+ * directly from the revision walk or from the list saved by the staged output
+ * of --max-count-oldest.
+ */
+static struct commit *next_commit_to_show(struct rev_info *revs)
+{
+	struct commit *c;
+	struct commit_list *p;
+
+	if (!revs->max_count_stage)
+		return get_revision_internal(revs);
+
+	c = pop_commit(&revs->commits);
+	if (c) {
+		c->object.flags |= SHOWN;
+		if (!(c->object.flags & BOUNDARY))
+			for (p = c->parents; p; p = p->next)
+				p->item->object.flags |= CHILD_SHOWN;
+	}
+	return c;
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c;
 	struct commit_list *reversed;
 	struct commit_list *queue = NULL;
-	struct commit_list *p;
 
 	if (revs->max_count_type == 1 && !revs->max_count_stage) {
 		retrieve_oldest_commits(revs, &queue);
@@ -4693,17 +4715,7 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	if (revs->max_count_stage) {
-		c = pop_commit(&revs->commits);
-		if (c) {
-			c->object.flags |= SHOWN;
-			if (!(c->object.flags & BOUNDARY))
-				for (p = c->parents; p; p = p->next)
-					p->item->object.flags |= CHILD_SHOWN;
-		}
-	} else {
-		c = get_revision_internal(revs);
-	}
+	c = next_commit_to_show(revs);
 
 	if (c && revs->graph)
 		graph_update(revs->graph, c);

-- 
2.54.0
