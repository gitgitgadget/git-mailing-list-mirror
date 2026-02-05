Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9D20DD75
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286556; cv=none; b=p0JS62OzOncGqo0DvicQp7HjKeqQbrEjk2iRNQxtRkmwWB0u+d+H7WzqCaRaPxPOgCnbDHrh4GVmEIcQhHyz3JzLo9/LXiusDtr1xp90legbE+K9Z6OMkTABdolJp4735c8fekW6BHOSa/Z7cB1GGAqIXXCc8FhCUORVZ/Nwzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286556; c=relaxed/simple;
	bh=zWkHQ8vSCEV5Y5Q5TTCt5n1mvaHd0SUtJreER7NM3qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+50aoay88yU80sunR8HOdj23jICdVH3Rgsm3a4jNy92WaZv5hMB/vw+D/VFKceDlrVZhBnd9ObPdWSmp6Y9bZV8XpfKUGw0DbS+wkvZV+WfPGW1N8zLiwUasgtxyOzp9x89mxVu48Pq0KpBZmTKlxZH+yf6qW2oOXI9nDq1ic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaN2fldQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaN2fldQ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35456fcb79cso482034a91.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770286556; x=1770891356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/76DzzvMj286W/l4XPl2OfRuII2ugH9OpHuOyIfshXs=;
        b=PaN2fldQMKtq3f7gp7314MttWgfxi7AUDCGs7EwLnF+lKKe0H9aaG8OS8CluH4lC/A
         uwpBJm4Eo/B7CIVoHy6i77nV+D2opA4CggFaajpuJsmWyfKN9P59+Odd328f5oy2sCia
         ZFthq04VpfeIOnsONgOS3U+2rnYBLmtc/53hjHKeqsiMARLd+Ce5hGjCUjPTa8VGwmw/
         aCs6bbZw7ugdBHf7mPpi71zGxKJHBamxUc7Ufb9JEmFsitQI+59kjNdmWRhfDsU5pGZA
         pSd6+x5e34gxSN3qdFJs/jQVJ4ED3kR1QCPOY4NLaHZq5MPmZe+scDtpWG+DDBBXKrU2
         UIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770286556; x=1770891356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/76DzzvMj286W/l4XPl2OfRuII2ugH9OpHuOyIfshXs=;
        b=w5Z0HntgeQpkS18tJtlwIVCD7tGyLXTdUlVZZrFgVQ8k/7vh49yern2ZSue7LQu7Q/
         vDSG7KGnvhj83TuyRcX20RP2qlzO2FbzKXbhDQF3dJucYQGrETBCZgCjxVJzQh3EkB+/
         OLK4pyqo8xL9MUVxokYGIXPA43BnTcZw/jd75TO6uy2c6EKIbG1QpliF4XgBbHkLvLiw
         u9bhuTmw62ixp3J6VYMR3LJiPr9yhG3/SCXg80orutJhp+Ni4xTm9ijDT5eIybc8G/k2
         0f5fH1GNJe85Zt6Almh4mBEqHCOSn/oxAtF7F8lYLwboz4fyUKcp1NtLKPosr1I9h8pC
         58Eg==
X-Gm-Message-State: AOJu0YwYSAUjTCve3l60KRVuHVavUt8ae9z1Oq8p3mVYEJ/2tMkgwyK4
	GmwQLq9pJpWa7vlShoudDY0Q+Wlm3e4Nrkg8BejmJ3CwlFf+QgVY8RO1tf48EA==
X-Gm-Gg: AZuq6aLXSKU7BJcWIkdDN7pDVBZksvR8N3r9CEb0+8aoL431/9F6vmJc1ixR2RLuhu0
	MT2/SUeuc0p3iVG0yjo4zaHzKoIchP+HGiqooceD+81PYnwE3MyXvpC551Xofn4SjZ5hjm9KzT9
	UeReDadShjZDoZ8mkFS3L6EljjbaWfSH+DW237qTvjBGkFTqYf7OJFU3xwuO9em7O+INEJm9Seu
	jqKUAfNqKulLrejZBKaTU1Cki9lX/pAcdo1hEnpZg/gixj+0V6MMMsZb+YhcmGfjGmnlRIfgRIl
	KeP1NCRG4KG972tCLUgG/iP6c1Q5Npfuo13vQ6YJj6oDWjcd80gwG1/rcVun0z1wsvbKMoAT8kK
	XvG58BpDlzbEvYGU/YdW0glT6FDNeuaX6pF5KleXOapjrFD/tMtEC5A0fyxoo2MEJ6QsDppLxBc
	XriIPis4n2MXtoGvfuqxvpQxG6ZUP72RbXoXxwTd6PmQVh/g==
X-Received: by 2002:a17:90b:28c4:b0:354:a1bc:f99b with SMTP id 98e67ed59e1d1-354a1bcfb4fmr1546152a91.37.1770286555787;
        Thu, 05 Feb 2026 02:15:55 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:1078:b5ff:8b66:3ef8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c09ff2fsm2071223a91.2.2026.02.05.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:15:55 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH V2 3/3] wt-status: use hash_algo from local repository instead of global the_hash_algo
Date: Thu,  5 Feb 2026 15:43:13 +0530
Message-ID: <20260205101524.125452-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt-status.c still uses the global the_hash_algo even though a repository
instance is already available via struct wt_status.

Replace uses of the_hash_algo with the hash algorithm stored in the
associated repository (s->repo->hash_algo or r->hash_algo).

This removes another dependency on global state and keeps wt-status
consistent with local repository usage.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b008682043..52dfd87919 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1816,10 +1816,10 @@ void wt_status_get_state(struct repository *r,
 	if (!sequencer_get_last_command(r, &action)) {
 		if (action == REPLAY_PICK && !state->cherry_pick_in_progress) {
 			state->cherry_pick_in_progress = 1;
-			oidcpy(&state->cherry_pick_head_oid, null_oid(the_hash_algo));
+			oidcpy(&state->cherry_pick_head_oid, null_oid(r->hash_algo));
 		} else if (action == REPLAY_REVERT && !state->revert_in_progress) {
 			state->revert_in_progress = 1;
-			oidcpy(&state->revert_head_oid, null_oid(the_hash_algo));
+			oidcpy(&state->revert_head_oid, null_oid(r->hash_algo));
 		}
 	}
 	if (get_detached_from)
@@ -2631,7 +2631,7 @@ int has_uncommitted_changes(struct repository *r,
 		 * We have no head (or it's corrupt); use the empty tree,
 		 * which will complain if the index is non-empty.
 		 */
-		struct tree *tree = lookup_tree(r, the_hash_algo->empty_tree);
+		struct tree *tree = lookup_tree(r, r->hash_algo->empty_tree);
 		add_pending_object(&rev_info, &tree->object, "");
 	}
 
-- 
2.52.0
