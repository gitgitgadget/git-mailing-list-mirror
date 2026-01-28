Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0B2264A9
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769578790; cv=none; b=ulqPnJhfK54wiKSlRR9XhKSRRtKulQChLttGpoWJskbh+y/Wht1xCppEUNk7d16xJNGQmP/M3GtWp8SNsRtGmql4fg5g3iOaHNC1wVqSh52sETw8nBlgt27VwseEdHMdM0E97XtQQlMA4qs16nQNEtvgSrwe2sVsmB7XrGD4NTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769578790; c=relaxed/simple;
	bh=zzLa+2OeiOzymppPPLFFg1Pry1JwYo2T/7LzpDBrvUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IXm0qCJu+u44eQKf9ZmYH6KrM/jAXZlljW3GMRs5TjYxGoxz0ehaNM34vKQDeT5rzx+hvQM0zic3HtB1g6ZdJOovr2iQYL+dZZ06N4cSi1kEiMaOS2Y//PauCe3Ky3vI53Zeei38VgqgO0aJBbFiLOHDjIeaaIVjxP6lj+WJgTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtZfjw0P; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtZfjw0P"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-894770e34afso106010816d6.0
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 21:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769578787; x=1770183587; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/Psu++vvZgvJp3FMORh2bmneX9C3hfFtExAQQyv2b4=;
        b=jtZfjw0PmAcLVrFDMRUR3BoG067VbuVNuzbjdY0JOP+Tr2VaiBAaPR2PP5HyAnq60Q
         AvB8+SLHxWIkOdeZ/L4MujU6Y7xoONnfL0BmhmjIlTmugMYku8c8dMY9cP4PH5tiwbuE
         ohNNQr+C/sdnDZtSOWTHoJSzO1+vPL5MFjFf6pL5/dE1lPklaw1KTAsd5rrJtTjyRWS5
         VJfgJFvIFw619UDfWGHxYK1rd4Cim4Nb4MSO9gfmJhpIRMTIQ53JH0zVRI6z/Ymt2yLH
         LB2kd2yVgh6eRyqG5B8rtK+aXaax0pXPjltXM0HMWHlzn2eA2sc8My7HSYA1u7+YGdFX
         2Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769578787; x=1770183587;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/Psu++vvZgvJp3FMORh2bmneX9C3hfFtExAQQyv2b4=;
        b=pBOPklS/Knguvs5Bqj9hCdxRuBzwST2kmu31Bk8bttK8h982dJXCes1wECe9Lrikdq
         XUdt4wg/6TfrAwddtfDYBtx8Dj/4TNdqIBzJtyejE58TUpNXXs16Rrxa1zavUv1vKZx4
         rRW5I2lQr3XtfYHUGVT/Ur6DTTJTx7jNP0Nrotn1O6WrbaHgA/vAcevHr67iSz6KdWnA
         CjmzmY3el8qEhQizaGubWeP3f0b3AmS8lucplXOKgFQtOUsHG5kfpRQiOnDBdwsr05An
         U4ESoqYIRVM8+Zb49l6cBwIMkhK2JiwtjIw/NAgs8Z5igaYNlxDz4/h8yua4NjKoir4Q
         m9IQ==
X-Gm-Message-State: AOJu0YxDLmIV+uD2f6GQf7BrF6qbsjz1Dc2xcVbEC48jPjRIlBhXI78w
	aqSScflNqyluljjgQXN87nbr2Xll6UvxpYFqsD83sxpnu5iefLTX4ZnHWj6sVw==
X-Gm-Gg: AZuq6aI4S1IaIMRy8hT+sRamVM+mAoH4RBhHI/xxww+XpM049j/2JNqiFEcnvnsxS/h
	QxsylJ86oJF6OPtMCtS28EOg+EWbEpd3Y0a4PJqVU839fDk1WRV1mzM6yiEtVwK1MlbycjN6W7h
	3E6pyvMxWaMJExrOndTpZI9/CMVpefAoXhf734fFK4uoI/uj81ZFuzzWeS0PT8nQUaC+9PpXrLY
	2UVkxWhiILRqkAwlOj8Im3+Pgz6F201jLrz0dgt5tN4aEd+SoK508Iu+aCqjSGxrSdmR1KH09xS
	VAw2ZlD8B1UXasJxisFLqNcSolYMV9+vKXg9j3OFxEXWgPKw3NMai/fXhwsYyaJROXrddSWx+p4
	Dh1opvGwk/rdCBgIFFlcFE+2IA/ztdjtXHIeUecgeuvOFiruzmYXdtcEL9+UrLph7r+PnvDmo9E
	ceFkIkrTvIcqd2GO2b4QGrpgr/
X-Received: by 2002:a05:6214:e61:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-894cc8fc097mr58380186d6.41.1769578786605;
        Tue, 27 Jan 2026 21:39:46 -0800 (PST)
Received: from [127.0.0.1] ([135.232.200.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740e62sm10963736d6.26.2026.01.27.21.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 21:39:46 -0800 (PST)
Message-Id: <pull.2135.v3.git.git.1769578785381.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
References: <pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Jan 2026 05:39:45 +0000
Subject: [PATCH v3] worktree: clarify that --expire only affects missing
 worktrees
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Sam Bostock <sam.bostock@shopify.com>,
    Sam Bostock <sam.bostock@shopify.com>

From: Sam Bostock <sam.bostock@shopify.com>

The --expire option for "git worktree list" and "git worktree prune"
only affects worktrees whose working directory path no longer exists.
The help text did not make this clear, and the documentation
inconsistently used "unused" for prune but "missing" for list.

Update the help text and documentation to consistently describe these
as "missing worktrees", and use "prune" instead of "expire" when
describing the effect on missing worktrees since the terminology is
clearer.

While at it, expand the description of the "prune" subcommand itself
to better explain what it does and when to use it, as suggested by
Junio.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
    worktree: clarify --expire applies to missing worktrees
    
    Changes from v2:
    
     * Squash into a single commit
     * Expand the prune subcommand description per Junio's suggestion
    
    Changes from v1:
    
     * Use "prune" instead of "expire" in help text

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2135%2Fsambostock%2Fexpire-missing-worktrees-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2135/sambostock/expire-missing-worktrees-v3
Pull-Request: https://github.com/git/git/pull/2135

Range-diff vs v2:

 1:  ddd4191ecb ! 1:  a4483d9a20 worktree: clarify --expire applies to missing worktrees
     @@ Metadata
      Author: Sam Bostock <sam.bostock@shopify.com>
      
       ## Commit message ##
     -    worktree: clarify --expire applies to missing worktrees
     +    worktree: clarify that --expire only affects missing worktrees
      
     -    The `--expire` option for `git worktree list` and `git worktree prune`
     +    The --expire option for "git worktree list" and "git worktree prune"
          only affects worktrees whose working directory path no longer exists.
          The help text did not make this clear, and the documentation
          inconsistently used "unused" for prune but "missing" for list.
      
     -    This updates the help text and documentation to consistently describe
     -    these as "missing worktrees".
     +    Update the help text and documentation to consistently describe these
     +    as "missing worktrees", and use "prune" instead of "expire" when
     +    describing the effect on missing worktrees since the terminology is
     +    clearer.
      
     +    While at it, expand the description of the "prune" subcommand itself
     +    to better explain what it does and when to use it, as suggested by
     +    Junio.
     +
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Sam Bostock <sam@sambostock.ca>
      
       ## Documentation/git-worktree.adoc ##
     +@@ Documentation/git-worktree.adoc: with linked worktrees if you move the main worktree manually.)
     + 
     + `prune`::
     + 
     +-Prune worktree information in `$GIT_DIR/worktrees`.
     ++Remove worktree information in `$GIT_DIR/worktrees` for worktrees
     ++whose working trees are missing.  Useful after manually removing
     ++a working tree that is no longer needed (but use "git worktree
     ++remove" next time you want to do so).  Also, if you _moved_ a
     ++working tree elsewhere causing the worktree information to become
     ++dangling, see "git worktree repair" to reconnect the worktree to
     ++the new working tree location.
     + 
     + `remove`::
     + 
      @@ Documentation/git-worktree.adoc: mismatch, even if the links are correct.
       With `list`, output additional information about worktrees (see below).
       
       `--expire <time>`::
      -	With `prune`, only expire unused worktrees older than _<time>_.
     -+	With `prune`, only expire missing worktrees older than _<time>_.
     ++	With `prune`, only prune missing worktrees if older than _<time>_.
       +
       With `list`, annotate missing worktrees as prunable if they are older than
       _<time>_.
     @@ builtin/worktree.c: static int prune(int ac, const char **av, const char *prefix
       		OPT__VERBOSE(&verbose, N_("report pruned working trees")),
       		OPT_EXPIRY_DATE(0, "expire", &expire,
      -				N_("expire working trees older than <time>")),
     -+				N_("expire missing working trees older than <time>")),
     ++				N_("prune missing working trees older than <time>")),
       		OPT_END()
       	};
       
 2:  ff4732b72a < -:  ---------- worktree: use 'prune' instead of 'expire' in help text


 Documentation/git-worktree.adoc | 10 ++++++++--
 builtin/worktree.c              |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index f272f79783..22ef37ec02 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -131,7 +131,13 @@ with linked worktrees if you move the main worktree manually.)
 
 `prune`::
 
-Prune worktree information in `$GIT_DIR/worktrees`.
+Remove worktree information in `$GIT_DIR/worktrees` for worktrees
+whose working trees are missing.  Useful after manually removing
+a working tree that is no longer needed (but use "git worktree
+remove" next time you want to do so).  Also, if you _moved_ a
+working tree elsewhere causing the worktree information to become
+dangling, see "git worktree repair" to reconnect the worktree to
+the new working tree location.
 
 `remove`::
 
@@ -271,7 +277,7 @@ mismatch, even if the links are correct.
 With `list`, output additional information about worktrees (see below).
 
 `--expire <time>`::
-	With `prune`, only expire unused worktrees older than _<time>_.
+	With `prune`, only prune missing worktrees if older than _<time>_.
 +
 With `list`, annotate missing worktrees as prunable if they are older than
 _<time>_.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..3d6547c23b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -252,7 +252,7 @@ static int prune(int ac, const char **av, const char *prefix,
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned working trees")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
-				N_("expire working trees older than <time>")),
+				N_("prune missing working trees older than <time>")),
 		OPT_END()
 	};
 
@@ -1070,7 +1070,7 @@ static int list(int ac, const char **av, const char *prefix,
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
 		OPT__VERBOSE(&verbose, N_("show extended annotations and reasons, if available")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
-				N_("add 'prunable' annotation to worktrees older than <time>")),
+				N_("add 'prunable' annotation to missing worktrees older than <time>")),
 		OPT_SET_INT('z', NULL, &line_terminator,
 			    N_("terminate records with a NUL character"), '\0'),
 		OPT_END()

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
