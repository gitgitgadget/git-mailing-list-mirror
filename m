Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C3221DB3
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712280; cv=none; b=s32lL46RLd0XpdrR0DSl2gEwxUx0RYfLR78P+mBa8INP1ltqXIZ7i26BkOvOSHoi+JDLVcko8rEbtjR57ehWTNdsvibSEaipDLN13ngWgqTWQQjJCvAgi3mpxJ+XAGen89Vi9+5nma5SvG+fyepzOm/U0F6hAl5gEr07u0eIxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712280; c=relaxed/simple;
	bh=C5G2gEeey+e0nzhm1Zq8OkScHr3PEFkA/pHyjKmkGB4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cKDuydH2P/MDmfXhDoda42ZXD/UAxVJrF7rDqjt14Fy0c6ARc2GCQMtNk4HQalkdwX1XHJ2w78n7XORgC6KlJz8iYaqqlTbYr6kC6p5C7yYjelWjo3iyjV1fF7hlZ/z9cSs623tAjciNcskYE/ShNdcb2ZStgqeP+ya6rMI5srg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRMRCQNy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRMRCQNy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0ba0b6b76so577695f8f.1
        for <git@vger.kernel.org>; Thu, 08 May 2025 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746712276; x=1747317076; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=idjWRsvKEfJrzP7ryc79Yo6h/fzqTfD9pUrRj/+GvDQ=;
        b=JRMRCQNyj3XeyTgawGf0HEH/P7FdgzugUBDYImNUmm8B/KrIFz1lPyoejhzCBZIgXd
         z4+G2v+IHrNuxfTQFqTZ16Jc7T/cbbf2vGUg8stE6CxEBAZiMys4d1hpje3vImiuxU4Z
         u2lpxz7oSk6/sTDoktsBJzvve1NGdW4Hrfi+NLkHH9eua5z3kg1jBPMbUAvG2Ps11oOT
         U11twKD8gk0ms4dZ/6yuoAsMLi94dmtFK00DlkC0xEWq1hbbcyUuoA75Q+csyn0Dq1eU
         +hmlZmMG2dwfPcGEoNlYnydhjv0wA9mmz1EyLtCesU2dca1LrnTQsj+Rzub0QNtQNPXA
         1V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746712277; x=1747317077;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idjWRsvKEfJrzP7ryc79Yo6h/fzqTfD9pUrRj/+GvDQ=;
        b=Ew+X+a687Ecv+dMTSJFDFAyC6Yz/tFHTf8Jw7lyXCKCIJCcNUVYse40k9Nsl8sSSWv
         ChoIRUTdCXsu5uH3+dCfG9Os1iE7peXZyL0Lr3WR2UdNfYrBvzlqRt8lgzfzMAg6zlfB
         pHcRdzJ+n1v0zSOrUxgtwZveJz0UisnTGMqrcsDOwVPTRAruL9NmPhvFynWJugmnmvJO
         AWuXerT2o87AUlfydE6xJ/cBzZh1ol9DdtDIztY+AFqmfH8wtrNtlrmzRxjvdTo7TxHc
         HG3LVmfepTibl25T1OIuY4L8MmgEWV4ku1QUi3pppVwzLhTQyzqHrG7VeZxv9aWy3zsO
         Ud8w==
X-Gm-Message-State: AOJu0Yx+F97Tc7wRMteUpB8zNBK0NJ9QG63ELq1oAjOulxML7jxrxUqw
	tg9od4G/C7cyALAGmV3gi2ttQmai4YzP1JnXlXaCGc1K6V89y3c6LtR/Fw==
X-Gm-Gg: ASbGncurtIAPmZ/TqxU9GrLpaCq3YG4vn3R/fH+kaKTPEFN6q2Cs9v23Z4hX73Dkmw4
	Nc/s/UzxX9pWMRw8duzSflylwYiBx7Ku2HQJtAL2vYKijDzW354qMI663WP8Fwjj/7kyXVIA+UB
	2GOjwJuq5GVQFOSpOFgZgHM/oYEFWVP0sYjPzJW5mdohF2xN6086DOrTudG6lreSIjnMQYwhBb7
	Jr/IRywwcrrc/XS7SFT2rWG4Mu7IA2//uBPbLC0pNiPnaTsUzgNrdebLQFFxadi6564oNUU0B8o
	rFkz7+3Q/QOxCc4Cd6Ic3jv245CC/gsSkDuvXa5PVg==
X-Google-Smtp-Source: AGHT+IFne4YZoN0k08Nh2JGrP6dJS6BffM2VCWGYwPapsbRLhrvzf67PwC5IpYfwcm+I3zCtkc9l8w==
X-Received: by 2002:a05:6000:310d:b0:39e:cbde:8889 with SMTP id ffacd0b85a97d-3a0b4a05ddbmr6309271f8f.6.1746712276468;
        Thu, 08 May 2025 06:51:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddd53sm45816f8f.1.2025.05.08.06.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:51:16 -0700 (PDT)
Message-Id: <pull.1957.git.git.1746712275566.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 May 2025 13:51:15 +0000
Subject: [PATCH] fill_oids_from_packs: fix memory leak when
 fill_oids_from_packs failed
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In commit-graph.c line 1930, if open_pack_index failed, memory allocated
in line 1925 by add_packed_git will leak. Simply add close_pack and
free(p) will solve this problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    fill_oids_from_packs: fix memory leak when fill_oids_from_packs failed
    
    In commit-graph.c line 1930, if open_pack_index failed, memory allocated
    in line 1925 by add_packed_git will leak. Simply add close_pack and
    free(p) will solve this problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1957%2Fbrandb97%2Ffix-commit-graph-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1957/brandb97/fix-commit-graph-leak-v1
Pull-Request: https://github.com/git/git/pull/1957

 commit-graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 6394752b0b0..93d867770b0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1929,6 +1929,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		}
 		if (open_pack_index(p)) {
 			ret = error(_("error opening index for %s"), packname.buf);
+			close_pack(p);
+			free(p);
 			goto cleanup;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
