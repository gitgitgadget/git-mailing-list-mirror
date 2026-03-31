Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E23413236
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971276; cv=none; b=B4Fn/D77dQVN1Z/LMfoklITnkgBVK91VIHyNwtDXvjTAMZHJGJxzgWWhRDh9EAACpKYW1wy7o8CPqTRr3QhB3kplovA+HrlC6mGf44I/jgOpuf2596r0rjog7RHgp/ldxjZQyD9qTqttBBOfH5z+3A4aUWFef3qrikwKpusFbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971276; c=relaxed/simple;
	bh=alKJH7uuSUlDhTfpt/usqI7vgKhXSeH2VpmwcUoDu6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pEAQRngLUqPoyJl4t8Sq/lrpTHxQKIlZipb1Al56lE+JhhOxnVLg9ANYuagHrXtAOMpDZ4b0iLQU+ue6roACiR35S2SOJefoPnjGAmWlG/jeAVzgzSwliKN38WUTuJQ2S9TjIQFs9XarWEhMFVkJ8zBMzYD0CvedNEOWdhp19CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwp1ABiO; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwp1ABiO"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cd7ecedf2cso596622785a.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774971270; x=1775576070; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnI+KR9Rvz4nahOId1ffjZfyHv/JW1yvlCrG2cihSTQ=;
        b=gwp1ABiOFqzD4d/azSDWv5IoHyh8fDCVtoYGSlrKyxhWXO049l+pfNm9Ay1iJcDD5T
         kKYd2ZBt7TL3lXLCVvRvshPwFBIW7h1I73xeuRtr/WamBRXaDfNoxo/4Pm11rvFfDXeq
         zt0amClhWYM7rS8SYHXKan9Fl0eunEtfrWEWsiZlJ3CAvCpAemzrbTaH/B9giWPKOYFm
         1MhlVsJtn5koSUO1LhxsjpyZB/azK5/tI9DyHFdhkzxjpBrs/9q+khTPfR25a92rtGEq
         x8QXWmoSUKkFgEr8KlgkyZqQe7hSMN8psiHeMU1mvSfn7av7ths4FjmLRxf2yrxoyhV8
         5CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971270; x=1775576070;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BnI+KR9Rvz4nahOId1ffjZfyHv/JW1yvlCrG2cihSTQ=;
        b=mvGcxwNL8LThlf6hpr9wGk6cru7nUix+vlMt27lLeDVI//44mgDK1crEdjVvpR3Is7
         6xIhN870iOJgFgaiHlQ6n/ifQsYQS0h+ULbT1UA853hbj6UvFuGSg3sNLP0GXO63+NAD
         mcl/rIFmUSBOwwxQkgaGRaV0UcPzj8XsS/sKiysW+J2uBUhYy3iZo3THMoABg7GydK0i
         z1sbNvGk/+DdDuv36TCAE/khzkj/5c5AMYgxuiK194OtfU4yOyExoaRPZpMBKtbV0nGH
         mRhSJUzSiXZRYqrVAAg+ovIscB+0rEcMjtNqzuCJGbFOSfprR4K9uM9oIoejabi1jVvs
         0IAg==
X-Gm-Message-State: AOJu0YzrK4s3u8Qwwp6v/+yQDoWlkG80jyt64dcFNdweafVTWcmdVOmF
	B/VtwxDaP7oQcZAhC8Uu2VNmGAZSqT1nR6x7TiJKds2MTaeN0kjvexgU94Z6mg==
X-Gm-Gg: ATEYQzwHOaoSs6jfvoJK3LIhzHLB0QZEAjZkIaqZssNVq/YNVk+9LTaViXHgxFGTR4v
	o+0WntewHeug8T+iGPJOrMxqVH4Uk1W+v/8vzZOFrZsCMqrLo1W1W5816Bp+T0vtTsFdIMpaUg8
	Ok71RMB8ODs6gS7hg9pIlEVakHqGpEtWC4TGWUauLQicSNM/ND/my/NOd3NIR8WyvTcLyxmLDIa
	XlseXjBpwQAfoLc4aCpPd12IjI4ko50vsYcjziS++Xm/bvF4IDnI42EzYwM8EifXeX4vSTtz5Nj
	iwJgoY0S7oIA7rtmW9RabUcjW4n/FTWFNywVB6y4ByzxeoFq5ojhxqGoxXfg+wFXLmSkCdVBPf6
	SlsP8W/APW3RVrPTK98ovyoTOdSJVM6uZd9p+05qtfsaOzPi1J82FhB/FiwV1ll98c4h87ybiIq
	nq05mA61Uy8Rbz60Edtd2NPv7j+Zo=
X-Received: by 2002:a05:620a:400f:b0:8cf:d565:fcbb with SMTP id af79cd13be357-8d1b5a994b6mr17000085a.11.1774971269702;
        Tue, 31 Mar 2026 08:34:29 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028075135sm898034685a.38.2026.03.31.08.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:34:29 -0700 (PDT)
Message-Id: <f03ea194e34bef7e398a5f1142cee0a439464cc5.1774971267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>
References: <pull.2258.git.git.1774901607564.gitgitgadget@gmail.com>
	<pull.2258.v2.git.git.1774971267.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 15:34:26 +0000
Subject: [PATCH v2 1/2] unpack-trees: use repository from index instead of
 global
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

unpack_trees() currently initializes its repository from the
global 'the_repository', even though a repository instance is
already available via the source index.

Use 'o->src_index->repo' instead of the global variable,
reducing reliance on global repository state.

This is a step towards eliminating global repository usage in
unpack_trees().

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
 unpack-trees.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 998a1e6dc7..191b9d4769 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1780,14 +1780,14 @@ static int clear_ce_flags(struct index_state *istate,
 
 	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
 		  (unsigned long)select_mask, (unsigned long)clear_mask);
-	trace2_region_enter("unpack_trees", label, the_repository);
+	trace2_region_enter("unpack_trees", label, istate->repo);
 	rval = clear_ce_flags_1(istate,
 				istate->cache,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				pl, 0, 0);
-	trace2_region_leave("unpack_trees", label, the_repository);
+	trace2_region_leave("unpack_trees", label, istate->repo);
 
 	stop_progress(&istate->progress);
 	return rval;
@@ -1903,7 +1903,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		BUG("o->df_conflict_entry is an output only field");
 
 	trace_performance_enter();
-	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
+	trace2_region_enter("unpack_trees", "unpack_trees", repo);
 
 	prepare_repo_settings(repo);
 	if (repo->settings.command_requires_full_index) {
@@ -2007,9 +2007,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 
 		trace_performance_enter();
-		trace2_region_enter("unpack_trees", "traverse_trees", the_repository);
+		trace2_region_enter("unpack_trees", "traverse_trees", repo);
 		ret = traverse_trees(o->src_index, len, t, &info);
-		trace2_region_leave("unpack_trees", "traverse_trees", the_repository);
+		trace2_region_leave("unpack_trees", "traverse_trees", repo);
 		trace_performance_leave("traverse_trees");
 		if (ret < 0)
 			goto return_failed;
@@ -2106,7 +2106,7 @@ done:
 		dir_clear(o->internal.dir);
 		o->internal.dir = NULL;
 	}
-	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
+	trace2_region_leave("unpack_trees", "unpack_trees", repo);
 	trace_performance_leave("unpack_trees");
 	return ret;
 
-- 
gitgitgadget

