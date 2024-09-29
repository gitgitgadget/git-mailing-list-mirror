Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AE2B9BB
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594225; cv=none; b=d//2T8i3IP5DLy0NA1vsgUhMmxoQwZpVIOjtXXqQagJAcfBKDDkK0Rujum/PalcXbRFZtsxkFpaJeCcTUP3sgr9r+M0lQ+JSTX/8mZXA2JKW3XjEGVNJdWVPLSWIgC9pXUBujyfC5KJuhPeMoisy52bnTSIMrzH+70P+IHtBelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594225; c=relaxed/simple;
	bh=f5cCi/MWnCZNhzkbRN4ADpPfkkkFsHvOd2cEbON0c1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWUKUkCRSW87lmgkAiCwbbQ815UbsSjnkRRb3QyxSVjF39RPp74riirR+S+kY/wn4aA6DiKfXpCd3IT5qruvA30jX7ZlQ/V3e4gAUgyOFzAu8raLu7lgiXt4WCGBojpNhIM2gMS2UQl4pu8Gt/cGkyjLhaUrQ6oV+NyP3LdyeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpFkN+7o; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpFkN+7o"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20aff65aa37so28167395ad.1
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594222; x=1728199022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4FKk7fMGVLekQs1kc9jbFG/WsuMnmm1pp+fm9kPZ8M=;
        b=SpFkN+7oces5FC7WtYmKITGyo/Oaysu1FYoVfhDXOkt1h5OR3LsZsAk6RnAPlMmu6H
         p4zHyqofO6jS6GIgDXEOh1AHgi3roz35JZPeIYomIZQMGvXmUVl53wsJUXPwFW8v2oc8
         TQBfuiKVNuqucCO/r1nxxC592rrTTWOw97yKLjwrMJQKgdnCcSRiusHHhLuU8dpacw+Z
         tQupEqNqW0LFdfiSqu1De65nzT/8Ve90cIUbdjeVHImIPf7+GOwuWEzps0H47UNzHcT0
         N7KU8egk8LZrNz04Rgt7NT02HYISGPD3nMNQ8iQWo7OX9njM4lAD61eawPVXcEzQ8JHJ
         TXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594222; x=1728199022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4FKk7fMGVLekQs1kc9jbFG/WsuMnmm1pp+fm9kPZ8M=;
        b=G8zvNbvt6/mtrcfbzAFhyKyoumajG6hQ75cRCEx9oqHfVTLu5tzfm+jXJFoUgdURIh
         Es/pina7Xo1dcB+unwAfETdLb7E7T3YpFwFlmWJQJI5c5ySc2W/crMx2FJjbOyQxjX3s
         3PZ1Hw/1yv4Lg1oTz+NtAmfC6XgFYsSVA8eBc1/hcIMimeCwqNyxwMwFNjRcWoz+IG1g
         WZ650A117QdpWWRt8WBML5CeI0uH2Iowd9lf9IvvP2tNbxcLqkbCnzSShhK18Tj5L53x
         a8DVxeo4SPX85hZAzax3vTbDwEkxp+shduIGbU8f6pa35MpzeZiHJSfu7lAOntlJCz3N
         UBeQ==
X-Gm-Message-State: AOJu0YyDNjGnzpXRuixiQ2Q30Rt3wiZYSycIPMwqa3f0B7gfOudDfM/D
	s9EvSCuufgE9cZamZxGrV0vxicbUfRDhQeD3s+j44YesU6NPSelrPehZiw==
X-Google-Smtp-Source: AGHT+IFNt1oeL1qUv3pdrpJLgXoUduGG0S8CB3fe37+cnhPgBT9aa48qLBlc7eL/lnPtZzoHBGIu/g==
X-Received: by 2002:a17:902:e844:b0:20b:65a8:917c with SMTP id d9443c01a7336-20b65a923c0mr40236945ad.10.1727594222543;
        Sun, 29 Sep 2024 00:17:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b54c6d95fsm20981115ad.222.2024.09.29.00.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:17:02 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:17:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 7/9] ref: enhance escape situation for worktrees
Message-ID: <Zvj-7Rx8ZT_27UpE@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

We do allow users to use "git symbolic-ref" to create symrefs which
point to one of the linked worktrees from the primary worktree or one of
the linked worktrees.

We should not info the user about the escape for above situation. So,
enhance "files_fsck_symref_target" function to check whether the "referent"
starts with the "worktrees/" to make sure that we won't warn the user
when symrefs point to "referent" in the linked worktrees.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     |  5 +++--
 t/t0602-reffiles-fsck.sh | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bd215c8d08..1182bca108 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3520,10 +3520,11 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	orig_last_byte = referent->buf[orig_len - 1];
 	strbuf_rtrim(referent);
 
-	if (!starts_with(referent->buf, "refs/")) {
+	if (!starts_with(referent->buf, "refs/") &&
+	    !starts_with(referent->buf, "worktrees/")) {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_ESCAPE_REFERENT,
-				      "referent '%s' is outside of refs/",
+				      "referent '%s' is outside of refs/ or worktrees/",
 				      referent->buf);
 	}
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 585f562245..936448f780 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -382,10 +382,42 @@ test_expect_success 'textual symref should be checked whether it is escaped' '
 	printf "ref: refs-back/heads/main\n" >$branch_dir_prefix/branch-bad-1 &&
 	git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	warning: refs/heads/branch-bad-1: escapeReferent: referent '\''refs-back/heads/main'\'' is outside of refs/
+	warning: refs/heads/branch-bad-1: escapeReferent: referent '\''refs-back/heads/main'\'' is outside of refs/ or worktrees/
 	EOF
 	rm $branch_dir_prefix/branch-bad-1 &&
 	test_cmp expect err
 '
 
+test_expect_success 'textual symref escape check should work with worktrees' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git branch branch-1 &&
+	git branch branch-2 &&
+	git branch branch-3 &&
+	git worktree add ./worktree-1 branch-2 &&
+	git worktree add ./worktree-2 branch-3 &&
+
+	(
+		cd worktree-1 &&
+		git branch refs/worktree/w1-branch &&
+		git symbolic-ref refs/worktree/branch-4 refs/heads/branch-1 &&
+		git symbolic-ref refs/worktree/branch-5 worktrees/worktree-2/refs/worktree/w2-branch
+	) &&
+	(
+		cd worktree-2 &&
+		git branch refs/worktree/w2-branch &&
+		git symbolic-ref refs/worktree/branch-4 refs/heads/branch-1 &&
+		git symbolic-ref refs/worktree/branch-5 worktrees/worktree-1/refs/worktree/w1-branch
+	) &&
+
+
+	git symbolic-ref refs/heads/branch-5 worktrees/worktree-1/refs/worktree/w1-branch &&
+	git symbolic-ref refs/heads/branch-6 worktrees/worktree-2/refs/worktree/w2-branch &&
+
+	git refs verify 2>err &&
+	test_must_be_empty err
+'
+
 test_done
-- 
2.46.2

