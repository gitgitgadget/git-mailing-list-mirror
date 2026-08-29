Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EA353A9B
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787986843; cv=none; b=cgosfLgAfk4YJt+fubMdA3Dz+TxaxgxpAN2z9zzqrSH6KCQi4v6Aje786/rG75FQzD24evKpn/bcg5beIe+kzh+LonLBQEvTFHX0W570Y0nT30887NBpAy/sCaZJ93Ey00mC4VU5X/BMJ4n5/tfUkL3+sjMNzfnuJifldKf2mnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787986843; c=relaxed/simple;
	bh=y7Xd2QRkKexfdLqprlJZvhTfEP1S7P+RadLOG22Hc1g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a9UwEP4V+ORND6oQoJbv4vlViUaDcoRMMjKMMVT9L38r1X+Wo8SpWjGKMfiqUGNDczw3+FUBSnll9OFUH0a+EU5jl5titOoDa2RNz3ak+0ioabdy1K3xd+bXoRol/Bn61NtJR+wVc/X+4gcHfeaO51HRLEAiU42+d32C1xXyw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lobWEb1k; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lobWEb1k"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb61bbeb25so2334457a34.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787986838; x=1788591638; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKY8oUgSl0zYFpTP2jqrH1GyvgrY7187VZjR009U1ek=;
        b=lobWEb1kN+1/OB2s5t4eD7UFcb+KQFpCpKArubD0P48qsW/BEccpCyut674+wVCNW5
         aOwo3wOmzRlx5qIXbqRsUElXnq0YY49yXKe9KOU+7PRm18RGRD1rgPNOZylWVSkNJyo8
         3ONTH4J7KNOK3NNzQJEfQ/DopIYJk07KAGgpYeLyq/RYHQxK/vwvrfjojpyrq3Yt95MG
         t6VBu5JnOyZhFHlGFMxE5+qErF8fHXwCf79EAHuLufSTjcNsHuh1/8M8wXdumSmcUpN3
         7pSYalUj8HhSrb88nBWiNydFEb/Z87c+HDfXGPda95zDgwtE6IFvTx65w2JM45YRPh38
         ZS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787986838; x=1788591638;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKY8oUgSl0zYFpTP2jqrH1GyvgrY7187VZjR009U1ek=;
        b=n83qAOTEX84OLG67639uOVnRiTGaqkVYrmO+vcU3dttqzpeLPWdO1xyJT8Rtit9smF
         KcqdP7gVAkmvqwodwfHlnRiWS0E0mHI6Q3if15WlTpTu9Oj0LSydgDeVFV48M4zjd7fT
         tq0vndOQ7Xc+9bEEqUd/oYvfu2mfkcoSHcuRigijdoix3eBnt3j+7XAUBC3Ed7vkDL8r
         v+bb0Gn9ZDHDCsbF6mXghmoVfqKENBO4l1Qn8Lea/d50emkknFZIQFuEwpbTdOLKcuGv
         685LTdow/a05lsrqv5L6prS4Fozhg4s7CA+KTk7Lp+Df2w2W2Uyc+WSlJEqfKzzITWLq
         U5EQ==
X-Gm-Message-State: AFuF++mWfOLx+9YH9PhFLekmQu0WzGhNXVOYl02xFjhzfd0k1dUd9/Xc
	ntqU9vegtI0GJAe5aw6IGMwMS65Cwd3pGEysiaIoFBlmaK2l0dGz1p9Pi0rCIbE8
X-Gm-Gg: AR+sD10b9MyLYWGP1/KGt+6x0r30cUSORE0IaJh/EFe4ionONHXkWLBiXyN7OdVzUt0
	8kBbZRSrVVvXUZ/y5V5PubCmeYb0X811WD5wt9SLXrQxj6YMF1ZafeDkSZF7AuqbKzrgR6qOmyx
	DI0lhE7/HB61xQgSIrq/I4Ya2BuobA/ZPQsIddTQidrGLFjzBFPypQwFT2+jbj3iE/d1aeCyGaG
	VWt2DVixKTX6bc+XKqCGqh6NT5wS7sXTreqAH0wreXHl2PVf0N6RC352M2ghxChdySfnVkcCWw9
	KpZBLWxoHeoU4W4JZ5SaDSRQQ52+c12rde/DAjr4aPT2M3MuN/xbz5FwfeDYCkoIvCROowxGA8g
	JWUQNIiKIUfy+SHrAdbEUj+P5iesnctYAcBXAyIN1mVy8uy7cyFbY80sJpjrlXT57RJzEsYi93S
	1yNGKRHjJvC1BSACbWcClkMdkjIwPM3UnaHaB2LRBuJ0taZeWxJPkm1W8dV4F+Sw==
X-Received: by 2002:a05:6808:1a14:b0:4b2:c80:e01b with SMTP id 5614622812f47-4b39835ee1amr12409268b6e.14.1787986838314;
        Sat, 29 Aug 2026 00:00:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.5.228])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b3a1995b83sm3118901b6e.12.2026.08.29.00.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 00:00:36 -0700 (PDT)
Message-Id: <3f3b75690eea02960c7edc8d318ce7dff654f1bc.1787986831.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Aug 2026 07:00:29 +0000
Subject: [PATCH v3 2/4] mktree: plug per-tree leak in --batch mode
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
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In --batch mode "git mktree" reuses its entry buffer across trees,
resetting `used` to 0 after writing each tree.  It never frees the
`treeent` structures the previous tree appended, though, so once the
next tree overwrites those slots the earlier allocations are leaked.  A
single-tree invocation hides this, as the entries stay reachable through
the `entries` global until exit.

Free each entry when resetting the buffer, and free the buffer itself
before returning.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/mktree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4084e32476..dc2d293c3d 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -200,8 +200,11 @@ int cmd_mktree(int ac,
 			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
+		for (int i = 0; i < used; i++)
+			free(entries[i]);
 		used=0; /* reset tree entry buffer for re-use in batch mode */
 	}
+	free(entries);
 	strbuf_release(&sb);
 
 	return 0;
-- 
gitgitgadget

