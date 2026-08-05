Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041A3D3D19
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954668; cv=none; b=nY08GsT6U2vnXjh+xd+uRsqDNRBoa5CxtiGZeSMqzlNUBpMIcgKh/u445QRhJDvxzy+h5eb73brsr/C0RGwGdcTeRznUrk0etHjOtxdnPYXNW3b8lQlE4FZXna9dFGtaeGoFlodX7D51iJkctCfu2D0+WQmn9Ysv9sm8A7Eh7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954668; c=relaxed/simple;
	bh=hBcXB4/MZ2qiandxi0tb5lmXZyTUNl0HN3iRN+0u4o8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cFH9TuRlBNEbloz2fe9QrtpwQfOiqg3gsfUaXI7snFtbV1IjbE3RsXB2i9Rt2Tm99LdnKfhoYaJAPiGiP3bavzmliOL6pEu2hKmJ3ND3JW37DHmEIKWSxyGbYBQkK1y4i0sTR6WQgSicLB5iuxUumhXrtxDC5IBxoOG+d99SDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcsQI4NM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcsQI4NM"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1603678a91.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954666; x=1786559466; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1lmKKOy9qNJlPi0r5GCaMfQJVRWGA7FF3QlA6yt/sNw=;
        b=PcsQI4NMqhbQke389tHRYkzeL8xaESzqOlaVtikaA+rGyMAEckrQIaQDuEuemU0vXU
         bvehJIWNP1WVQYgS5/1hdo7k1ovFBUEiRdzzmedwDRroS21sI8c7RXxnFuJ+ByIsWxlK
         8eCrtprqkRiXYbqLVl6PwG95R4+VxNUtRcml0HpJgShAh1jGdPz/hojqokEz6osXXndC
         vs1J0QUSjv8o21PE4mKvXZ8Mam6dIIKQuKCdDamjaEUG05uLmoRwm+U2I+93Qehn4gci
         RSPLnwGdGfxYv/ZKnWkS5jadNmLPW1J26LuGmYvFari/6hcN/OyG55Vi3Vtpmh/DByC3
         GP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954666; x=1786559466;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lmKKOy9qNJlPi0r5GCaMfQJVRWGA7FF3QlA6yt/sNw=;
        b=MUm4OMTo4IQvqcQt56C6vXxeaClzE4oIsq/gW66E0/DD0JzpBUqXCA8qTZYa9sNl9K
         Ls0nTesKgjJO9il1k4J/XIKEYbIbacJEFfYPrsbnn+niPs6P7WQ6IMtCO9uGS7ItEth/
         hwbm0StClvWXzOsFC2UEvit4HbJ6Sgyqu22CGnmH+uVTwCxihA+mTOPREK8Xe3S2BTFw
         ST3/13Uv8zuZcevhRFHioQcCn/hJwi9rdvERfMrBPqAzk1lyG075JbPfPl/lF5Mzq1iU
         pbju6b/+XZNZufNpwZNTTHxY0y2Fk0LDt+Q0ppIIrdAsDQZgA6beMOPpaAZrnD6RrkhA
         KPVg==
X-Gm-Message-State: AOJu0YwBR8Sk26u/D+BaBBcBIPSazzPr4/t1B9Uc0gmV3UonNvw1rK4H
	50fbNGykgdaG5gXfgxhlvozV5K8JCGSEj1f+G1T8tX1m6Dyne7/js9CV8y/yvA==
X-Gm-Gg: AR+sD13q1wSbOLb9lbdyCWa8xyiAcSPVUXqeQfQ2hb7Mz63l+BRUq7SF9uqOdLVOXJ8
	AHbJLZcFzAkJTSL5L66rzW+TnpgNJpmXOZ8asckAi2dxelI1WnWNmhDFxCAutYOxVCcWwDYrgO0
	njXZcN5kanhMB7NuaSWeZtG/uxweTRCUGqhq9bFbXEecEsf0yA3vfSbKK+eOSeBkTU0ml3hnQXj
	uIwstMgPwTVGrso1XkAr02eFPPnVVX39M1wOHtOXbQcrePVpI7yJF6HbGe6bhiCYQhsAJ4qTRBa
	/zaOXAh6q5RQPfGcqVYfSaXJC5W1ap4J3udX3EephwsNypr7XrM3zl71JYs1hykz4Q1x6E4lYJe
	LLx7dpNFSda6iKNAD8DlXewvfGs96Z5oB6UHgIppvUM8uxOgZYu5dCU3/+qEQJCXir+xKTIYIhO
	wJITNt9+eYNUj6AhZY8VDUHyeD2HA7W0wcSrgbpGbyePfNwF52zYSCSxzMYlhuVeApZw==
X-Received: by 2002:a17:90b:4d91:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-3903c559592mr6916690a91.2.1785954666237;
        Wed, 05 Aug 2026 11:31:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d2f9a9fsm2126092a91.1.2026.08.05.11.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:05 -0700 (PDT)
Message-Id: <0692704d45060a62579b50dd7a2f07da04f435c8.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:51 +0000
Subject: [PATCH v2 02/11] config: propagate launch_editor() failure in
 show_editor()
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

show_editor() calls launch_editor() to open the user's editor on
the configuration file, but discards the return value and
unconditionally returns 0 (success). When the editor fails to
launch (e.g., $EDITOR is not found, or the editor exits with a
nonzero status), the caller receives no indication that anything
went wrong.

This affects "git config edit" and "git config --edit": the
command silently succeeds even when the editor could not be
started. In contrast, other editor-launching paths in git (such
as "git commit" and "git rebase --edit-todo") properly propagate
editor failures and exit with an error.

Check the return value and propagate the failure by returning -1.
The two callers (cmd_config_edit at line 1315 and the legacy
cmd_config at line 1478) both propagate this return to
handle_builtin, which translates negative returns into an error
exit.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8d8ec0beea..1307fdb0d6 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1313,7 +1313,10 @@ static int show_editor(struct config_location_options *opts)
 		else if (errno != EEXIST)
 			die_errno(_("cannot create configuration file %s"), config_file);
 	}
-	launch_editor(config_file, NULL, NULL);
+	if (launch_editor(config_file, NULL, NULL)) {
+		free(config_file);
+		return -1;
+	}
 	free(config_file);
 
 	return 0;
-- 
gitgitgadget

