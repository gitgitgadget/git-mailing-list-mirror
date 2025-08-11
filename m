Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFF2D97AB
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943214; cv=none; b=W6pxd5ow0LDDweaed8JZlsmAapsaThkJ9NXAFkd6t7BtrqkEIgvr/BlDuxmEK3Ul1HgZpI3DyHXhO7G225zX9IGPRnY6Dy7tM4+HFNTDdbpeZd/0wmZYQsRajPFgTmAdvSlFhRWWIREKvd69mjnkzwatQU6x6hCu1nI0/2GPxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943214; c=relaxed/simple;
	bh=pWWO32DC2OdXHwavghtRklqkP5cU1s0V1PhaHswA5G4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kq+kpNG/hKiEHs8Z4c+Wg5cAx/FTtQXKSnYpPg3tAnnK9gOK3I4MgZXTEpbtZNWdAcJShfBzch+EqnLCoeCvFaYEMGVnqGjaL4WY6OTZmYdh9LBwOUgLB5uRgWiaqDyD2Xj7M19WbCytzMU+aPLNYgj3MT3WZ4j9nbF2vqjLG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMBSzJKC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMBSzJKC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459d44d286eso24914855e9.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943210; x=1755548010; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdtxhQhpG4tyiQLf3VKFbCKXqndIkfaF37r/zynhl2w=;
        b=dMBSzJKCgyoFg6Lszeg9p5GWN9dj+eurKWmcx+8YsJDB/pBbQEJ8rUV5lHzK0V81Ng
         v3nSqm1nPL/hj2zJNVDwmAk/ANaLOoD3v8lQhGkfWgYdqkduDXINU39AYxu/B+EQxlSU
         I/kwNU8iuxRe74sJ+AwOo6Fj1E26NQiCYiRet0tGgFFEawvEF2GHWcnVBlMdsKx5uH/R
         5H2Qj9HPdujVgQ4Tdd8GGzw8WmLuRTxJc/bN1agwaNqIkoFP1MIFEL95V67WVsRsSN0m
         dkC+LZ7HbA+eiWNuTiaw5lve5xM3V8mvbbWl2lqt3XC10x0WrTDNSdsUyaxiCevwkk09
         /FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943210; x=1755548010;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdtxhQhpG4tyiQLf3VKFbCKXqndIkfaF37r/zynhl2w=;
        b=V7dIvFoEs0fsLSkyNvRpdbgwzLHtHSuIbzxhtCVQ9LTswtP2Hk2SWcZGST/o5iuiBG
         qYE3IVKokhGzRhUWJAbMCGtU4qkaQhMZNYzCraadI3I4bIk2eZvIbbKxQ5rTfMN+BJqN
         WwqPK8eOvuSpKn4DinrRlLNbCAbeliM38wNz+++7YIduD1JseGRmTMm1/L02K3xeNfLH
         SqXQ9sGZ0UxnUB4AmGGhYenHOGd7OulJSfFFQW6yypp4oBGe/T0rt/gwZQJ/NwPhHXdM
         Pg7zfw6+z1H+ikRy2rBYB1QIFtDp9erHicoYINJ82JRKYHVDRc6zY54uo6CVJ+/zezAS
         hI4Q==
X-Gm-Message-State: AOJu0YxkaKsTIGP8d9JmodrAMjWU++Rou1N0tc97Y6r3cJQaJXeyEK+e
	/tHfcr3NkhpwJjTd8BoexJ+rC/BXBZf6tqadwLOrcdX/0jvBxBbh+OhP608WXg==
X-Gm-Gg: ASbGncsoGSGP/CWnnlAu3Iu7Iy//lZoLFvqfGXULxfQAd6f6uQmDdKqYgUjLZ9yqxCA
	C0U3SjVGHf513upwo+bIYUXq+OY6SyIYSGeGbQ/aYMjVtFVavKSlKxjmIHEp4CPJ0YvjDQGOCoE
	/seltwWTtCb+A4Mobz4LdKnjQD10AsrxIKZupOu5y0BSugqxzdIw4l3O3SylIVi/XBRsgboI268
	LYcwYmxJ6POhPnk10QlkBPVhD/yiwACqkvDP4YZ4ORs1KAFh4HI0Ig6Qa78HAyKsMr66ga9P4fu
	jPxj2Hpyoso07ncovCc2pzFf1vf82kDDoZ7YVOC75d6QKwUG5WPQWpVHy+hq+61/miFpA/MSsIo
	qfI3Gt1ocpMVxl6an2y/WLBOftaAYo3Bsdg==
X-Google-Smtp-Source: AGHT+IEXiIttHr8R24nythfvnI2bkxugfaDwmsqBkhfdLZBoYW8TdRhzMOt+VMj+oFmDhuUs15zv4Q==
X-Received: by 2002:a5d:5f53:0:b0:3b8:de54:6e64 with SMTP id ffacd0b85a97d-3b9111b5fb8mr753713f8f.26.1754943210335;
        Mon, 11 Aug 2025 13:13:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm44043454f8f.49.2025.08.11.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:13:15 -0700 (PDT)
Message-Id: <948c205f1e6c005d008030b06e20a4069cd4c50e.1754943127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
References: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:12:05 +0000
Subject: [PATCH v5 3/5] doc: git rebase: clarify arguments syntax
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove duplicate explanation of `git rebase <upstream> <branch>` which
is already explained above.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 4ba74a8cf9ba..117c3f43719f 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -62,11 +62,7 @@ one of these things:
 
    git rebase --skip
 
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget

