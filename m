Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B69373BEC
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961052; cv=none; b=LNwkfzsaDEKvllvtUNHwstdTW1J33xNGjHETbNstwN4UMhH48HUOG51PpPeBTYZTlf8nf6sJaeX2m+ubdT96QqlkqicyvUW3k+QNNQ6bYBLkKTWlsOWahGXb6SgJIWlnc8lAweyOIn9Qq7jQosOSzyDJeAMfgKv8NwTLrSpvJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961052; c=relaxed/simple;
	bh=d3O264YOAPhSs3LowgQv+OytQy4Jom6SpOx2HWimA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1hRkINKuSd113Jj/ZUB3DEi+ICcImHF6JJS1FNhZaZgOYB+izS917IGqkeex/dg23trgzsVXt2fMF6LuakMp7VAdeIHeEpyBPUGQ8lXHAK+/muw8gW3qxlRX5TypCG5qg3dxjJxawBmqOBbEvq7RtREy/LeJsTB56b258agP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvat+Nns; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvat+Nns"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so55092f8f.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961050; x=1784565850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=Xvat+NnsTVuXPvigqVZZn0JN5r62qK5AaGs8hPLXA8zyO7qtFZBTiyHytZCfCchHci
         EfXh3nhoPhQgasEsPbmHimoZA/yCb6QW+M9+fkgFcSqKIilIi8MSk1Q6sVdBYyyWEdkN
         yfJom14DaPsuYbcmuVUns26/ZA3zWbFuTXGZfJJ/4dTztIz91PngX9fE78SeIVUZyvFj
         a82Fpe2gJ7ytXJFtHZLPYbxZ+lgmd15H18SMg7sl5FMEp+q8f1cWikKf8nQRbnPIGmUd
         HHVpBeZKq/kz2oU0aEkhWOrI4+76Vh2eFQvE+QjPAwUJQ2Bw180tV/34x6J6mkL1mvU+
         /EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961050; x=1784565850;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=Bi6IjnUzhr5wuJhlFd8iRtvm56DIKkPhKvMidE4eOIlMkUIBuYkOkrcvQ4JJl5Chqr
         O5VIA0ZJ89magq++xs1f2q+4+cBZyeQD/yErvyuaAJQtUZwjzb8C+xamLLkUzO/76t1d
         EyN7G1aSVO9ag4Oiuleh5Ao4XpJBBVHROh/xzEFK+HHfKIvRhWyz/YqW7KPDsE1/ealf
         geZexz8PtaJuknAf2LPIjmZ1KThKXhOg/i0hlVTuk0XT/JhXDO6AxCq96m8MMck4qtcX
         fpGRR2u/VRJXonMJzdB0B9FGhQ5kDjV5g3jEXtZoTCdTAAUttXClQ+hC6vLIXpGeJIuW
         tLrQ==
X-Gm-Message-State: AOJu0Yy+t9Y2d6SgCCIWZRyHbZS/vgXPkkqUONe49ljiyLX9mzNmwo/c
	9K7eHWywsZmolmcuFx7wX312/rkC+mUvhT7893C67gi/bqtagLTzs/MwNLN2EZbh
X-Gm-Gg: AfdE7cmie0PAqir1zLhq9OYztLeVqgDpsjQtRqbeERKBCXTUwEuq/GWZJvCKsPQYL1Q
	t4EUQw85Hf6PC6CJ/JDb4cuhuagJefUFoUgwe6DjFp9ovOs91vzz4/BJVmuUpXa7YTWICVcN3zx
	zdmoKk30pY23/jGsw7ALQszd96YYQefxNGGkFPn4u+NkEZALIOPYQfRpRD/ASIUsFVQltkovvXE
	2tCc9ZBVgcKAg8FjOElRR1FSLq6Zf8dciOh8fpkkGgN5OxFzM7El8gSXVEAxeS3QOH8Afy6QBiS
	CLYUGnoG3RqE49UtRPvxDEs/07eqK+cJAyXFSDCZIhWsZ1gOVkdqPTK1/y87yQoTFHJPT/blXw8
	9+JZkZ/g1GGKPMtecNg9kNOpU2XucpIqb3hCesgiIU5jjMrXSTvV+3tjm8uWErIEYt1gqnAVtWx
	x7BMbMseJISnBpi/MiHdQj8kMKZnsU9ALnw6SVtsWYGgcCQZPh9xvPysbLZuQF9evEYspwe+DSE
	Vdb5cpWdBBQTmiaDRPQtrEKYskuw1vjZp4BmKRhdE8F3yYIlrFuSoBsQm2pP7x9zlVCyb4DNiUy
	Yn3X9ICuYd/xHLdq5yUNQZAbTrfqj+NsRSPVz+t+JHlYB6N8xisOWdO9Rcbw7dK5ZunyG7kEph3
	fq0VNBedc8A==
X-Received: by 2002:a05:6000:290f:b0:479:e2ea:3d51 with SMTP id ffacd0b85a97d-47f2dce228amr11679403f8f.17.1783961049624;
        Mon, 13 Jul 2026 09:44:09 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm653768f8f.24.2026.07.13.09.44.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 09:44:09 -0700 (PDT)
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
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v11 2/7] revision: add next_commit_to_show()
Date: Mon, 13 Jul 2026 18:43:59 +0200
Message-ID: <20260713-ps-pre-commit-indent-v11-2-dcb65bc4ba99@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
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
