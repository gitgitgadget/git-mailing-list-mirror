Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA05115A85A
	for <git@vger.kernel.org>; Fri, 23 May 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017246; cv=none; b=mGL+tJiH0YnpwMLKGpeF6pTCEFs4R5xbJVGnNMmZMhgysvjJWGZfar6lXuLpglcdm2T7l1bZLFNsbPWMtLfOPzL7ofwGVUwit30ZGlgU5ZMNh3pustqW3yQ7WsDdDjQkNyXu9G5GOJx+X1O/62jvjjwD+CVXSbHdcqo+wjgwRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017246; c=relaxed/simple;
	bh=10cJHPvAeVjwn/t3P8Dxyf2Z2+MhhEDhG9mYnJtA4ko=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZI/d2DUK3RsscQ327xa9VdXZLWyIkDKzrpxxykxF/bVWMs1745A7W2qafBZRIW5OIo8NCAPRtWPVouP8Hg+raN+lY9IeggvRKM0IoZVcYoWDGKdyxrtlyeclQmlZQdWarlSApJ0mQ2lROluh/NzHQcu8WIMGeRMonAcKlxbGar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H34gblUR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H34gblUR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-44a57d08bbfso16496445e9.2
        for <git@vger.kernel.org>; Fri, 23 May 2025 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748017242; x=1748622042; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T9MVPxAbRfA0/40zoPvTVimakbzlXZXWesvI1TX6lwQ=;
        b=H34gblURxYsFssW/p+62v6PUDJt8dMF6AeX81v24wP9CIm17giC8qz7jsNNgK92UtH
         Ej8dSLPTT60IU/Bfo9RjLsAQ2KjpB+wV/QeuGzOuhfYvZ7EkK6r5olVPk1urXLQmpEeL
         CbpnB2xjLX2z3gUFhuj+yRNh37NlTn7/fFIF29AFAUwlAeQgwnMr0wgpceG1Sv6tTpLc
         Q0mDldWRHG2BJccK+I0ve9mj1uLajW2RDoFB5MPhEo/6hJwkjYDx/g1FVRe4tSijL/sH
         VHdUKiQIZC/Bo+OMosilJaGMKhnPqvRzg9P+r7azA7ZZ5my/ywZmQa28thK9uBchmWnZ
         y4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748017242; x=1748622042;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9MVPxAbRfA0/40zoPvTVimakbzlXZXWesvI1TX6lwQ=;
        b=BG2MP5GO8d3bhN2t4SXapdaarue7O+5J3nVB5A7cKoi0iRi4qKquhEoMWLrTeM0Ku5
         hkx/Uq0HRDD25WBNIWBfAL54VeUS6TwJmq37plp5jRUmsOlcIn4yL4WD1Hd17dceRAwL
         11FEmb015aOSkMVOv24ZAq1Jt4s42LeTbOGcpVITek/g2K1tZbgauOwdIN6SlAPgNNvz
         GO0M4XQuGZaHxCJhfwxkRWKCKjwWXTfP9zyvpd63GDkrh0rxaYXdyLjUtaInuGwxZEOq
         KDi71nGTurJ9raNP9+TYP/sxatc1yhOYKgJhCgScct1fKoD/QD+LR3/Bww47Ps/jdggc
         ajoA==
X-Gm-Message-State: AOJu0YwGd9kE38rDh0mazT2+faC6BgHYfKl0tBCo+ciQU5VHyGwgyiab
	sKKnSvdB+0EXVLCqAwVYFGBpzockb3QLZ35UVCQlZPspONKPQmowpTE/VCqJCA==
X-Gm-Gg: ASbGncvxhWgI8Msd62xwJGjqIaLaVJ9Yspev4/dPmr08S7FV4lFYZfMfTkgn+57ZWEC
	AIjDvNJwWcNVp8VZAdtm1avLFslr4pUfOE/84UpKpQaREFtt8jg1QCN4SNkMZpKml8bdfzhSy6F
	V1h1KfqwNfHQZnmVRouaRkaohRNcQ7Y820B2Xa768cLELOp+30aNBQny5FRZYYDTjtHlyRV8eZ6
	S8fKtqiRewKnSNtwEq1Kkt/ShvJ0H8rSWZOvlMGiBbdhnAqvbpjb7jHowkjvvjbt6+nSF/YGOXz
	ojg08RPVbQgcG9kQjbJHRvlyFkfMyYIjG3R0jWDFnL/lprZu7dzY
X-Google-Smtp-Source: AGHT+IH1iySWcgGp25bfY8Wry7UbtuCHthUPfrV4GgaUemHzSEfWAN8JbFlg49rNYFrRHZAfTiD23g==
X-Received: by 2002:a05:600c:37cf:b0:442:f485:6fa4 with SMTP id 5b1f17b1804b1-442ff03c45amr332430685e9.31.1748017241924;
        Fri, 23 May 2025 09:20:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7d975f4sm144543295e9.39.2025.05.23.09.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:20:39 -0700 (PDT)
Message-Id: <pull.1975.git.git.1748017238130.gitgitgadget@gmail.com>
From: "Alex via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 May 2025 16:20:37 +0000
Subject: [PATCH] Add a check to prevent max_children from being 0.
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
Cc: Alex <alexguo1023@gmail.com>,
    jinyaoguo <guo846@purdue.edu>

From: jinyaoguo <guo846@purdue.edu>

In function fetch_multiple and fetch_submodules, `multiple` is
stored in `opt.process` and later used as a divisor in function
`pp_collect_finished`, creating a potential divide-by-zero if it
remains zero.

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
    Add a check to prevent max_children from being 0, which may cause
    potential divide-by-zero.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1975%2Fmugitya03%2Fint2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1975/mugitya03/int2-v1
Pull-Request: https://github.com/git/git/pull/1975

 builtin/fetch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index cda6eaf1fd6..b668187627a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2591,7 +2591,7 @@ int cmd_fetch(int argc,
 			die(_("--stdin can only be used when fetching "
 			      "from one remote"));
 
-		if (max_children < 0)
+		if (max_children <= 0)
 			max_children = config.parallel;
 
 		/* TODO should this also die if we have a previous partial-clone? */
@@ -2613,9 +2613,9 @@ int cmd_fetch(int argc,
 		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
 
-		if (max_children < 0)
+		if (max_children <= 0)
 			max_children = config.submodule_fetch_jobs;
-		if (max_children < 0)
+		if (max_children <= 0)
 			max_children = config.parallel;
 
 		add_options_to_argv(&options, &config);

base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
-- 
gitgitgadget
