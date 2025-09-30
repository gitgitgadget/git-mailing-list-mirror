Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938326980E
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262320; cv=none; b=VNIhC5t3j6/HUaxlpf02KVv/PtxMfcL9CU88qAgdsMIvyZH6BIZ/yZoCiXoxRTNypzKgrBbzHDJte8ZR1XJo1GWtRzupUTBazqKJhDOxrGk36pAVky+Y5e8+RsFSJ6gNIilD8GfpP2chKNkZSv8PDIRgDxWv20OGayvAsxI4dIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262320; c=relaxed/simple;
	bh=55DJASOpaSeo5tHatmGd/+jQ4xh4WwrvINnecJgKjKg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G7Kb68+vFxOwTrKsR2TSIOTcS+J6Hq5fP69l6s/AzWqfxgNuyVkSbwQIgJycwyjB50qvnSTecf13Mn0pamybTtYWatRSvu7phu1qw8Qaj26vXUu/rM2NuVxmv8gMmtUmlYK5aUPd5HFroaYZ7b6hwnqT+BAj/LpJ4HccPwUMcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G395OX0c; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G395OX0c"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b57bffc0248so219415a12.0
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262318; x=1759867118; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGdIcmZns6U85XDYnW+k/aIiGwf4itNWqcFr9Jns37k=;
        b=G395OX0c9zHceK2f9akh01tDEIPEtu4tQM/xaVuvJpo75zjnNgyGuh9WsfLSx54jD5
         ZifGLDNrGSxIOATr3r9HhmdtV+WNa9twO8o2SMwubsqMOSa4zOqPPWc9h/lMEmZCvg+p
         YS6YYDeMasYLNsg/tTXpb50TPKbYCWNnnSVYxRu5lCi2zojWDGyes2B356ZVW5pZY0WU
         CKV1yOg+Mnd9GcnfmZCrb2CN9Q82Qn85BN2c7RDAAQwLiNbF+0M1xr4wTBwD4K+fFnMw
         W9m4PduSYi3JX5D1VnxueWG+P7Z0qNdh2jkmiooehzVvOPjWuc3OXVmKYPCT+UqJqqce
         elCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262318; x=1759867118;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGdIcmZns6U85XDYnW+k/aIiGwf4itNWqcFr9Jns37k=;
        b=ChjU3tv4DjVkrYMxZGz5rBd52tmALzAFI5fYi9agD1t6lDC6i4tEBgsmpKfzgDW/Ru
         Sxki+8RknU/ZJ+U/FXeeEl2OE9L3FP8l30170CLeez/ehPy2MRNABxT57CF3JHgzLdKh
         xliLuNEVN+rd+dV2iDcNEn05i/A9Ev4hGzPoL22qqWy2ffNdh60OVrdZ5H7HUdIXC0qH
         W1L6SCM0RCBztz9SPj3DjaCBjKvt7MWJwReFt/kBCHXbDxRyDS91n3oYHuHNZw49G8BF
         ICzX2pyRXnZyYb8X7+fS7Fxo/LpaDelxsN517XzPGpmXeiv+TxXCE10QPm9bw8a4tFCB
         rJtQ==
X-Gm-Message-State: AOJu0YyK2CuFayih66syGufIz+LEIdGEmggLK8Q6DIyUAokZKNUxjHJo
	HMkb7hj9cc+eSSlpvWx4hvi4Ger1LFRZsl8M0v3De/KWsl1t0lkhcvcSdf8hLg==
X-Gm-Gg: ASbGncsJlGAs6PgMg7V+dyuCFNUp9V1VCgYeDHEKSHw/WANYCenJ+BiTnmmsW8Ign17
	CgZ4vdYgbm74Z+Lpmoi8IBMMu3HD4gry1WQZRj8y6ANRUu1FxwN0OxgWawZUmnORNLOeKaiNyHz
	IcnLuRjCog8Jmu7mb/LbSCCXDmk2dKGfjrGaHueSL2i7f2+HEuCu/QLo6BPv0kNEAK5MGDmh59F
	b6EVFTCKKBMyPzaVMCs6/Gkc5rUI5JN/di0YK+c64qfjJG0BMUyYylZWbpWmw0XYtQaMf2X/n4K
	IIu9ju1ADdqF08yzfpdkWkUB2r5J43m5+TgG581Jy/PtQpw9QotWNxqwkPQxlB2NHph4gehFKW/
	JK3wqWuS4+TVF+tJTyYUMpk6YmMGRePn94coao+e9Tbt26qYboQ==
X-Google-Smtp-Source: AGHT+IFJPzwxpFTwHAv4pfxE9JUnYRAIYQFY5Ga8Xrpw6Q1oZoy/59ltY/Lj7VD0cJR+/Xm7veNp+Q==
X-Received: by 2002:a17:90b:3905:b0:32e:ca60:6bd7 with SMTP id 98e67ed59e1d1-3383abb456emr6652915a91.11.1759262317613;
        Tue, 30 Sep 2025 12:58:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.210.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ec12fdsm388071a91.10.2025.09.30.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:58:37 -0700 (PDT)
Message-Id: <d3160fb0af036c4e5f536c34da831a0ca705d535.1759262314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 19:58:30 +0000
Subject: [PATCH v4 1/5] doc: git-push: clarify intro
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback, 5 users are unsure what "ref" and/or "objects" means
in this context. 3 users said they don't know what "complete the refs"
means.

Many users also commented that receive hooks do not seem like the most
important thing to know about `git push`, and that this information
should not be the second sentence in the man page.

Use more familiar language to make it more accessible to users who do
not know what a "ref" is and move the "hooks" comment to the end.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d6..25d972f248 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -19,12 +19,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Updates remote refs using local refs, while sending objects
-necessary to complete the given refs.
-
-You can make interesting things happen to a repository
-every time you push into it, by setting up 'hooks' there.  See
-documentation for linkgit:git-receive-pack[1].
+Updates one or more branches, tags, or other references in a remote
+repository from your local repository, and sends all necessary data
+that isn't already on the remote.
 
 When the command line does not specify where to push with the
 `<repository>` argument, `branch.*.remote` configuration for the
@@ -44,6 +41,10 @@ corresponding upstream branch, but as a safety measure, the push is
 aborted if the upstream branch does not have the same name as the
 local one.
 
+You can make interesting things happen to a repository
+every time you push into it, by setting up 'hooks' there.  See
+documentation for linkgit:git-receive-pack[1].
+
 
 OPTIONS[[OPTIONS]]
 ------------------
-- 
gitgitgadget

