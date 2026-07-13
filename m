Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FD3DBD43
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939502; cv=none; b=JRFznXpq2sibqX5YWRVOIJz4uO5pI0SdDHkKjksictgFmxbzuH8MldyNRJzdiQr9Vm4ly1/ROyP9GqpG/ZgLEWc6Qf6UXfAlcspXKbRLGPB6th4+GzO6q+BDO+rA114fd0q0k+JtEwR2F7HpyZa0n9x+hQJqRY9Adw6GnMItt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939502; c=relaxed/simple;
	bh=d3O264YOAPhSs3LowgQv+OytQy4Jom6SpOx2HWimA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3451Do9oZzgOVo7rCTLvnZr4W1N0peUnqdYiNKx5VQmmM/04N7gWVu8j237YpxW+PgTCWpPu0HeAorQBiCwfjvBaU+nfwGIjAc58OLZ/+1+pqgMbMxUvqyr0C3AkyEv8HI7Dp/+YiAxmNbDY0XsVfhtSvCerds5OECcGR71BH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTAFi3mO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTAFi3mO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493e497643fso17899945e9.0
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783939499; x=1784544299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=JTAFi3mOp+PuW38nehHmDh7LHEKsL7aUO9rxASZYwt9QzNizqq6bX3Veb/U0UtKaz0
         rS/VeyXI/Z2OohaIBxpEh66CcTX9N8awYW2a7Sp9uLfpr/8vQ757azZmo+EyzvrJos0S
         5v0Kqqu5Ex92NJrBtDuFiQNe9CQr97SOcU8rRDp8IyGXnLpBsmcb0j/dMWk+c7Kt0P9m
         dtR6lvQ1cD/rYCvkM0f+NG+SR4sJwHYdt2Q4l+f2OFfigggpgZ71YbGe9ULUcbOsXKJr
         XXo47qkQT4fmeduNqssYK9ZK37mSFUiD7Uqvp2Pd2r+PYsZldUMMXOVPrEMuXtwYU0lP
         MLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939499; x=1784544299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=LaHWYftpyYm3SBgrisIesm962jF5KLV5XFPwfJ6zNci2oOyhLU9C+8UscZxNVifoRH
         kXXFgHdQDHbO9kvl0rzmK+9uEBRjBkcarw2PNie4UT+jffS9ImhpvcTQf+9RdAf0X3pY
         mdWnFGNdtXfTX939dQuT/CkHXXqMM/eIBHBA7dYPlm/W9zRr25UW03jNuuuGBEKJMOKu
         Aole9XaQ5WTjNKCAWPTgfC2uuUHZiz712VhnFRMEovx9ZCkS8onyvDouam41Fhhlp+bP
         fPQwj4y8bTpz6fvQlR45ObvkvVSMnvXQVlM13+gxvh3qnW5u5/dzkYbh+B5on8RjTOBw
         zD2g==
X-Gm-Message-State: AOJu0Yxvn2IcZRR48X5wJCKIKCFp6xVjszn5LA1f1BaHLmjJOFk0+FeV
	XIzavAJwlS7lw9BZw2lU7XWu+anjJMUWh0FH8Um151vHYcJQhCnRiwk01TUBTOLG
X-Gm-Gg: AfdE7cmxZubV8vaNz+5rmQIIU0peG/zw9YiZsrHWQOX50vu6jY9OUnNc1gsLhUn/6fb
	eN1W/GM9FidpA48chBMyY4GC8f/2jSnehWm5BKp01BvuzQ824vNvpSmjzTs5qges93tfJ02yJZU
	x8fsphKUE2bWvF8Pogi78zlq95JyBsHySfzJYzeM2wFMvDOTgEbgVfwgxwG7NhcY7onmDR06xaw
	kDduKNzL1gSmMViC/xhy82VMIC/Dt8wETFxWhvzmWW/U2NRs3Fs3FkHm5OUduhuvk3X4B75w46k
	Hb8CycA5DpquWsjEXRNJONeRUyV7efLdU0zLWJF1gqtOdDWBxdEZq8AXcQ6u0+vCTfoIs+1loAn
	psnDqR7UTSims1EY5FmtN9he6Y+Tuaud+aUjTzL21V2wEAopGmEVF1Y/MBU/qsn9SAq2MkFro3M
	fvsJyVDObuvSsJngCUzJt0Xob2u18y0CVQqu6KhCwyuz01JU7VwePtApE41IW2ZRAwMKrp1uzzY
	LS8TRIsJ4tPKYzgozXAQ9mRBhtiTIVT5qm925kZgCpnheIA/v8yyqceADsOSen9vnk8vFZGH9B/
	8PglzpvpB6HbsQrROyllsoweBplZNKCOsZ4vyErKbtEwBuu+ShqD76wtOcJQ1M9wkI/CSdDi46u
	p9aqb37adLg==
X-Received: by 2002:a7b:c8c2:0:b0:492:7084:32af with SMTP id 5b1f17b1804b1-493f881d21amr60301075e9.23.1783939498695;
        Mon, 13 Jul 2026 03:44:58 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm318564645e9.9.2026.07.13.03.44.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 03:44:58 -0700 (PDT)
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
Subject: [PATCH v10 2/7] revision: add next_commit_to_show()
Date: Mon, 13 Jul 2026 12:44:37 +0200
Message-ID: <20260713-ps-pre-commit-indent-v10-2-82ddab26bc96@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
References: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
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
