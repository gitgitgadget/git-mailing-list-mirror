Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDC366DB9
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781419053; cv=none; b=LRIIGhB6qeCk6oc6wFPecwO7ueonWSJAOrMuIXbPvbV3Gp/QXlxU3xqmKAidQNQRgxM/68ETE3byvvzUYyp0J8y5QIXb9Ka53nTtZGNllx0Rr6oXxTtR1Cr7A7ZOrZryvJ6cNIVasgYQ7NxwTAf81kDK5NtFTeybp1bznpBq9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781419053; c=relaxed/simple;
	bh=uRu/HwDpj4olZ+bPJIEn3RUHx5YA7NlmqBwqwxVxnzw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JqcAwRnHfTq+XkSnr72yZ5y6qzrI8gpI8FCLDIAiYbpMgfcXSqysZG7+Mzfhv2XyAHGpGR7JxRwfjFd5TbULAsrAkavUgLBqcLFpnr4nyFgmElGlXZqI/wA5tuobiOraYYGu2tYZddEqx27OKO5Jc66xBW44yJroiGrYlyXMXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNkzPjnq; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNkzPjnq"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175cb5946dso17292701cf.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781419051; x=1782023851; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAAQ7++/6lp9xIOrtYBM5qIN0/9r3ow2xkgKmf3fLJ4=;
        b=rNkzPjnqMPDr2U6S4r/aNIdZZ8SyHCMPzCg9y/HrNnyG2oEcDcemi3Ql09qqjtUWqR
         pQBpb3NzLrNvYF5a00MSXJ9egdAWxulGMOX20vmaRPNtZHcHV5dmCME1yOfXC0twfAj1
         ekYJIBn/4wpmK/RhJnzzEpkBtD7SvUlqmlzFuso+JyG3Abdby4ow1cIHxd41Nz5LMSPg
         UeRdXlAXW26FtKkl68/moeA1kD4428qhSZdUJZn3oPhOnS2bmhCMZTtT9iz1P40Gc9XE
         fZ0XKL50eiu1oxJ7iti1vvedHbnw9RJceTBuuh3Cl4nEgUfwZ+k4kKsVWZ4IXQL05FAc
         5ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781419051; x=1782023851;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAAQ7++/6lp9xIOrtYBM5qIN0/9r3ow2xkgKmf3fLJ4=;
        b=j3V4zvZ77rUrQPqSQ/4CQRmb9rJVgwsQ9WVcNBz1RfWN4akCLcIbsqniUDlbLY4HAa
         6FXckv6cqV+Mp7F86yU47sRDLYlx04oM/4xJXVV65oKw0aOWy65j9kZq9TqDeIk0kc0r
         JFv3Bz1svee5YARxZrGyxxccTBloukZnyeiw96OCfxlpkknrYzqWo6uk4XESPngMPJNN
         OEuIz0WZlt+HkiqD5P0RrlngKsWfSp8jOtaGtzz9mKRPL5LQLH1vUGWkCllhDQmAZAFv
         /5oEeaF+E7e39VzlOcspXU4/4QMA7345Qt+wWinyxpICYuYzAJnyEaEQH7CcM3lfoTYD
         UtQg==
X-Gm-Message-State: AOJu0YxHpuLBlxynHHM5Ao8OFLlonRizEQuNomoRdelhRtbasQl9GBgR
	mF3TGfNiwWNNIHZpUNXj82TWZPpRiMj8i4p102nAgLv5m1w+Qz73YuhPLr5fKQ==
X-Gm-Gg: Acq92OFHgsF1wt1S1UYlj8WoU8ooCg12ZzgjQ2p9QqJ0a+s88tXXg5viTvgOHw/hETa
	Mq8OI9rKpSE1IejeV2eTw5QEm2GV1LgWWcjhGx4y41iBp9qfrZVmkTbkrG3T995HDvKiyGSDDHy
	VRFl7G/NWx9Jm+IlaHRWVSrR9y4LeSqYmoVn5BwFQNXOwO/Babm687VOimFSUYrJGAUbumOY1Nt
	r8wZxFLekKVaKxVTc+FXY3EJKYb7LUhEo5ihKgYvIzKLDK44X38P7qOuq3xyTcrDfXeLD4LOYSW
	fis4CGjo5UyQObmeFGdN85J6b+Ivj5I6CQcO0ZZzqC6GrL7VJeuCvAQjZW3THyq0U+RgCHheEsI
	hYij5XZaA68kWY3MkEzxIQ0gD8fpUelxPiM14Dg0VNRoJSefbCoCxnVTHyrdXCM+L+MPWBl+SzH
	KX95NGIjAr4jKWSL5DSzFV4A==
X-Received: by 2002:a05:622a:550f:b0:517:69d9:d2c with SMTP id d75a77b69052e-517fe5ba35dmr133632121cf.28.1781419050735;
        Sat, 13 Jun 2026 23:37:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb83db58sm65767021cf.27.2026.06.13.23.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 23:37:29 -0700 (PDT)
Message-Id: <dc0f596f31635515cc96160bbb8bdc5b773e2ba6.1781419047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 06:37:22 +0000
Subject: [PATCH v2 1/5] merge-ort: propagate callback errors from
 traverse_trees_wrapper()
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
    Christian Couder <christian.couder@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

traverse_trees_wrapper() saves entries from a first pass through
traverse_trees() and then replays them through the real callback
(collect_merge_info_callback).  However, the replay loop silently
discards the callback return value.  This is not a deferred error;
it is an ignored error.

Today the only originator of a negative return in this entire call
graph is traverse_trees()'s "exceeded maximum allowed tree depth"
check; everything else (collect_merge_info_callback,
traverse_trees_wrapper, the inner traverse_trees recursion) only
relays that.  So in current Git, the visible effect of dropping the
replay callback's return value is narrow but bad: a tree nested past
core.maxTreeDepth has its -1 swallowed, the subtree below the limit
is silently pruned, and the merge completes as if that were the
correct result.

A later patch in this series will teach collect_merge_info_callback()
to return -1 on an additional path -- detecting duplicate
entries in malformed trees -- which is similarly handled today by
just ignoring the problem (resulting in mostly a "last one wins" rule,
though the non-last entry can mutate various state flags).

Capture the return value, stop the loop on negative returns, and
propagate the error to the caller.  The callback returns a positive mask
value on success, so normalize non-negative returns to
0 for the caller.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 00923ce3cd..4b8e32209d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1008,18 +1008,20 @@ static int traverse_trees_wrapper(struct index_state *istate,
 	info->traverse_path = renames->callback_data_traverse_path;
 	info->fn = old_fn;
 	for (i = old_offset; i < renames->callback_data_nr; ++i) {
-		info->fn(n,
-			 renames->callback_data[i].mask,
-			 renames->callback_data[i].dirmask,
-			 renames->callback_data[i].names,
-			 info);
+		ret = info->fn(n,
+			       renames->callback_data[i].mask,
+			       renames->callback_data[i].dirmask,
+			       renames->callback_data[i].names,
+			       info);
+		if (ret < 0)
+			break;
 	}
 
 	renames->callback_data_nr = old_offset;
 	free(renames->callback_data_traverse_path);
 	renames->callback_data_traverse_path = old_callback_data_traverse_path;
 	info->traverse_path = NULL;
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 static void setup_path_info(struct merge_options *opt,
-- 
gitgitgadget

