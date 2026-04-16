Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306F37D12E
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379700; cv=none; b=nNq4GW+zHonXXwklNueXcc/CQkHkKc3ilNMEExtHo1WYmH3Wk0TLRO2ihDVVdLn3dy3wM9qkGPElGcGZEld9+/5xT1yXKVhILqEDxSKz2bdwDIXGt/qCg76nRtFW/VniPXsjbNDfVNdJfc5bI4rox6OGMliWRptySvrG+hK37b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379700; c=relaxed/simple;
	bh=lGmaA7HQpL4fc921lV+KimhO650Cr4sQocwTfRp2N1A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SWc8XmghKrt5mU+KtWx9OTSpFTN97qsNw+m/Vp7j2oyfshSQsO05/NuiOs5tk9e/YSrmVlATWVDT4RciS37s5TsIYw2pLk2PExENprfZWuleiPOrRbFZolZdgq3SrlGbKguWZWdMYoUfCu9nr9PyQ6D9ZqmTeG2inK4OHFhM64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKyZa3z4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKyZa3z4"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfc5941028so8581585a.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776379698; x=1776984498; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwAcFLxBMUqEyAsFL9q41zuA9nhWvwzTk+WOQ6O1RbI=;
        b=KKyZa3z44HExAa34mQktuf0SwIx+xd65uWlF5/lhJG3HVexF8gm1WIIExfLOpxdIbA
         L2wI3TwXhtW66qQZQLuxEmCMxH+8IbKE2lu+N7QUWP7RIggt9iaKte17dF0sP4oFtpUC
         fcUGfvu6JAYUqvjIkl/WyHDn5OWXDH/SicjQvPq0BwrF2OzgXHWL3MNcR5N1P50f/fjD
         CywnfiqkjiuuGMx8w/Se5Tk2z7+madf/KS6AvIx0ehnmRf3xNkL31Fys3VTGSW427zfZ
         MdeZVFt4ZSoWkF6elt8dIjY0JUsvutXZ6EdoINw3oHUs0LjNkWFz+vjd+tGHzQDLVzMz
         QqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776379698; x=1776984498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwAcFLxBMUqEyAsFL9q41zuA9nhWvwzTk+WOQ6O1RbI=;
        b=aMayxMOjNDEaTu+jTVuI8Tgm+eVUdS8xUe/qumPr9pwAA3RJRHRQ/ibEGoHiNXkTxm
         dIX0UJrv27dQh1vTFMm60Dmxd6upXE8c3MwILyzFAF2gxkBTRz6S5cve+vmwAqkviRUr
         dAu4yBEiWu1yrV83Il0L+5P5HET0xcYziZRyACcOQqnMNtep20aSaWGPmVqxQt+D06JA
         /2hxOIR+RIL9riDyNDyMYZrF/SbhuYdE51xXEPkhmKEpr+dWYmdoEM+hPIoalD71Ujj+
         Wmff/dRSC9v/yb4eLEwrJ5GOmroM4S0KVh/dWNpSgRUWgfOe3/duFYFEsgev8vH3O5AS
         6imA==
X-Gm-Message-State: AOJu0Ywhi5HZ3lGa7Jvep6syGfMRm1d3YX1iNgvsAQQJN59WAGb7aN2F
	5WIzhr4IKTxkGJbNBhHshFXbtYvRK8Ux0oSc9Bl7+4H5KaU1vSH3UGUDJtXInV2m
X-Gm-Gg: AeBDietHZvFt7c5SYvKMrzwTUZEnf+pv7HQWu44j2y6ARLHqHW/Gc44kz3h2tYAO2hy
	0+AaRobTVo6p8GGJNnT598SmHGKKHD8JKjwAKc2hVqB95F+xNY0TBHJ+kTEwL/viBcLPUt0ft3B
	iL3UCHOwjUeathoelU5iicp2+vmnws+bofLcFUJRBtz/NTpqac25CTDJsSCpE9JMpih3iuWrkpT
	cdnLLB1poK9e4tSYd0BF4ph0nQV8dQeOly+SbtDt7VTlISjHW4Bf4Rqtxe7OQI/KI6uFrHvR7/M
	eL6qSQC1O3un7PRXPTXDVfrQ1JDvt+1YkH4NwbOjJo+SwhtBXebV+n4CjZ49MwHJfxjVZkHy0fa
	YrqUzVcYVVAkQVJdKylADm4OEleea4SYaI0+TkAz791Z3e4YyqQP5qvuLcvjI2DAJW7Nnju1uD3
	gjVF9t9fI1CqXpIRYxNUdGnMFqS83SNfxoQBZV+Q==
X-Received: by 2002:a05:620a:4626:b0:8b6:1877:3689 with SMTP id af79cd13be357-8e7913c1f07mr49309985a.35.1776379697990;
        Thu, 16 Apr 2026 15:48:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.213.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33bf71sm469632485a.11.2026.04.16.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:48:17 -0700 (PDT)
Message-Id: <7f5ac5942ebfccf2787d582040185245902056f7.1776379694.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 22:48:12 +0000
Subject: [PATCH 1/3] patch-ids.h: add missing trailing parenthesis in
 documentation comment
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 patch-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patch-ids.h b/patch-ids.h
index 490d739371..57534ee722 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -37,7 +37,7 @@ int has_commit_patch_id(struct commit *commit, struct patch_ids *);
  *   struct patch_id *cur;
  *   for (cur = patch_id_iter_first(commit, ids);
  *        cur;
- *        cur = patch_id_iter_next(cur, ids) {
+ *        cur = patch_id_iter_next(cur, ids)) {
  *           ... look at cur->commit
  *   }
  */
-- 
gitgitgadget

