Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B41491582
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816802; cv=none; b=tcmLt2s85Wywh6DVITkljc3IrfqP9ZhIhVqTOU7RrmspVEnhjOb2TdNhIR3OYV1wDgbELkrDt8t9s7+Ke1hCidpGAsiKKhF88ZgkRBaYpGzb3fsEH25F2irGidEjY/DPbsCL7E0V2M0FE/tly+1snlnbge2bnJ7eVZrO1F8IgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816802; c=relaxed/simple;
	bh=C6JX9wsLLRNOqiqJP/NAqPm+0X0+uzt4nKcGu+4WlNs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lIymZfo7aUpssTYSe1ee2zMSnS6OktVp0datzD0PS75H9vsW34yjh1tiqpd+eeGAXpB1df0WDY5mN5hCVHkdCoR6fbtLVd3VK4F0h3N5F7UOBCL2UwPTankGkvs3F3yCV2EN22VuLgMgQR7itCrwHOXMXwKKloWWRO9FI9BzgAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXwyt2gf; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXwyt2gf"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-530e75d1ba1so20713891cf.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816799; x=1792421599; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=OXwyt2gfOJJqJsEjgAEfcKH0Uwv9AdNc3V70qIOkcuZ8INrpqW9Qu5xSJ9QFI28L8G
         56GLrykf35awSrDa8GKNVW1Ew6X+txw8PlEWDHJ+t15778QysqNco+eBVwbpDp6V9lWf
         DZRZZUz8exjAB22OFSq47mZqheEx82qG/XdMbKR6vAnApKTzJ0kf/HxYBTWoJW8ZjC2v
         DJM9INGRh0PaPIu8JqRHHVcs5OWnqq5MGvCfoG3UeoXgFzDfaI1slAXq6kq0UuCDKUTg
         /aDWWsoYCf0I+77ZUzfoO7Rb5TyewvNii9Dm3Y4KCpuQsAvWzH62P7SCzmExpOAooZMb
         0s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816799; x=1792421599;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=Ax4qWQz6yesAMSzFoZMUR599U7qfjBWnoceXyAkliExPTdxViFbcqI3yaS3gYRojaO
         Lt47CyTDV1gRxl4JGUgzzv/glDy3dPG9Ow3oewXkFBdjz+7Jhc0nvKrZQmVRcjBi2Upf
         SSb8/pO6HOqGvhJGLidYKiy02muVIQ92OsbL2su4goF+RqxXYlFbSTXY/zCK65FjTtz3
         lfSUB7mszZeQt3m9Q4azKS6pmA+mXe8zNDau+ClOILUXgGHfciBYlDIdrU1sK5fFghdD
         /oARIycHHJTRo1kHLjZrhLc9DZfwbbTzkLygOe24VTEgEVI/ZShdAYR7BjvPpWZvOWMr
         CPkg==
X-Gm-Message-State: AFq9FYKT9yhvHoVUj0v6vMcTky8UEbD49MS4IIyDrqaShuB+Gcqs+zwK
	hjKZ5Er4K4nt+MucUGza/x4kQe/FVPCLQ9kigcdr3cjCRcgltlPfYUHwAE6Og1x1
X-Gm-Gg: AYBFou3iRxAqE1GiA30UNh6KX2q/FbVa87mQwy24hv0DRxKLenojhtDf0Fy/qI17eIp
	QKqWXq0mX+p2TYDhq7Z0m3I8cSHrWPnAEtdxP2cxpeCv6P1n5piXbduDWeeMwrcWHxeMw2hD/r/
	x+zYP5j00vrc1FUyR/PKj1Li/c3vtinIVAOqjkhAkTyMOkvWSLkjOVBDEKv9jMPjG48+e/426iK
	GcNgJgDofUoDsB1SYYwVfpTm8RGW/bWQkwLO9yvnGABjYBJnM0mgG/86eJCqLQNdtwP6DGjtcQ3
	2G6UoMYWZa9Z5kWr0ZyG9CHKDpmP+3YjhRWxe0Ont8Q5JYfbWml9R46wjVZt+IHYatnI67m1+YI
	Td+VXg0hTg7DW04Y/pd4A4zBE/29cbtozLty8o7Z5QlwkEWgAWUi2VbnoGXzqqt3pmoQPmieUbh
	IWjeqcLoyXU77+UX58pJ9RRHCzQs6VR1XiHjLvfuZgR7Se0dZ6hw2qhMTZ0vmtrpE/Bd/1Yi0cC
	W6k1D0FhCw=
X-Received: by 2002:a05:620a:bce:b0:93c:8881:8df3 with SMTP id af79cd13be357-93ebd278728mr1649983285a.46.1791816799371;
        Mon, 12 Oct 2026 07:53:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.84.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5504de42sm97253456d6.24.2026.10.12.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:53:18 -0700 (PDT)
Message-Id: <34ba85fcad8744a8448a8862e1ea760b99d304c9.1791816795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 14:53:12 +0000
Subject: [PATCH v3 3/6] doc: git-rebase: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove some of the detail about how to handle a merge conflict, since
it's explained in detail in the new guide, and there probably isn't
enough detail anyway.

Leave the steps since rebase is special and has a `--skip` option which
the other commands which cause merge conflicts don't have.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..da70aff498 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -46,10 +46,7 @@ If there is a merge conflict during this process, `git rebase` will stop at the
 first problematic commit and leave conflict markers. If this happens, you can do
 one of these things:
 
-1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
-   and make edits to resolve the conflict. For each file you edit, you need to
-   tell Git that the conflict has been resolved. You can mark the conflict as
-   resolved with  `git add <filename>`. After resolving all of the conflicts,
+1. Resolve the conflict. After resolving all of the conflicts,
    you can continue the rebasing process with
 
    git rebase --continue
@@ -62,6 +59,9 @@ one of these things:
 
    git rebase --skip
 
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a full guide to handling merge conflicts.
+
 If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
@@ -1284,6 +1284,11 @@ include::includes/cmd-config-section-all.adoc[]
 include::config/rebase.adoc[]
 include::config/sequencer.adoc[]
 
+SEE ALSO
+--------
+
+linkgit:gitmergeconflicts[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget

