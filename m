Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B026CE25
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881831; cv=none; b=TgrNB663JQDjyGAv69zHrr6eYq+21rGFTJ1GDbBZoxhO6mo0qTrbkZxejl/TavL6oE7EiL9xJ4JSs8yzZonq51XXEJYgvv1z4erZr8y2PrA8YAlkDdj5zm/ra6ijkt2L4/m9qJJEdROZqvc7SzDaYgQRxj98sGBIOB3YYTirN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881831; c=relaxed/simple;
	bh=3MpvsKdA1RMHCrLtBWDUk1HozMfgyiHcrdfJ+Y5+JYg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=uSw6cqY2pN/xNojwb6tXKFzQE5ULcVEPayW0BqhoSfiS5mF8JF8myjJOLL1QDV7mncep/n750lZ3/vwZEG+bkIeeoeZ8mZdEXxoLUnN4koXf8YCNzDtg0vTkH3KYkJR+TZCbmiyVcJvHXi8gDtKgunOlffcotp5WMpiOd8CUqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzrI53aL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzrI53aL"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-88f8f346c2cso171316385a.0
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 20:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761881826; x=1762486626; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=//hTKFfW4oeXD7XQSoVlDTgh83/8q3tzdO3AcNybuQI=;
        b=VzrI53aLEx1b81j+IsIpfLATSyql4snCL+XXgmtmT4fja8fnbWn8a3F9F5/DpgGxaN
         nJQSC7FcJOiUgh7cg1DkGTaHnaWpd1im6FG7nw/NBD/nCjE7cM1t+F2mq7O8c02uyElw
         7q1HuaZx33Qma+/cyuGcDFzjAgNL7xbPDOzlbeFFRuRN5LC11AoHv0hMiLweeq/ipyu3
         VOUgi65qfi2u5SCI95dH+N8Znm8sUgxMaUq9gI5fAEQbD7J8XudQLo/tjYt76YHF6ibz
         raPACV59z7bMR6FYq0L5vWoQBgG8xAEq0b9yscwBYl2HixmPZ2ale/xJqLPakl28w3z/
         XVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881826; x=1762486626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//hTKFfW4oeXD7XQSoVlDTgh83/8q3tzdO3AcNybuQI=;
        b=V856/e3GkDx+YNVffKnz2VAGaWKoqalldIrVj78MaLdaNLNj91S9L+nJXtep0VaBpF
         k6/VNq0OF9UKZ70sGo1f6j71lN4NrPO/Nee4IE51VSxtWQqfUHTPW81RIR+58wJkQHuH
         N9DJnOilnaNodZL2O2w3Gkj3Ut/gFNVP3hpp9aDdZa6Ut9lv8/5G7I/m4/5GFs7nlXUp
         BPcJilGUU/r/cB2U4g6q7DfZvsiVpsgyHZ9rG37CbxWUQBAcH0BDBehk1My2axEYOJG9
         43wKnWehS94qxJnNbgnW2qXS675NyPDZnyj+O5Qd2YLqGeuQ+r5mUG2tXZJWQz0oeRp2
         mM+g==
X-Gm-Message-State: AOJu0YxqoRnmj03x4PNap+JuE6BiTN+oqXu8NF+UgVIMoWfBpfIy0r7u
	Ebv7vknXmsbQiz4/4V0+xyK/GFvj/6mLh3gTqBw6jOgjVwgfrumkGnplBEAV1g==
X-Gm-Gg: ASbGncu6EgBOusgwxH4/OtHFI4A/AKGGXgksH7M6hui9J4G+XN+KLPaMzPedeVjOkMT
	p1vUeHxJkHSiMDtZIOAH3m5X2eAqyU+ZkifvwnQ92vsPwIKDOSZd0R8YnQllvAiIAcTykgqAZCQ
	Kyfy/Dr7dVSjee49v6OW2qFgvZ9AZ/4lV8pfPaN8wKn6ZcVagUbF3Lf0V7+kDKiq5U5l+OnOD9t
	0JzNhU1A4kZD/lKhpTzOfqrEOBuHwXjlDqQmmAKYgk/sy6pP3GYJp5Eem/gMudoz5bbAKw+qbar
	vUYwEmq1oHSAnKludRs4FYaTQeSZrMe1OfuVym/8euvuL0sSgcnLdX7SWQJSGeJs3oqAAIfBJ47
	g6WVyodb1T7pLuzjOnRTq8Bt1N3l+WtehwE6PqOOqaFujQ5pe+E68pDa57gglJN+J5OUJyZ2HZh
	0gYoQzgmQo0xdM
X-Google-Smtp-Source: AGHT+IGaEOJvASRdDsLSKo5cJz5K8tmTqrIvgbrapvvV4qy61IXfVJfHB3E92WWvg6mom+N8FSxEcQ==
X-Received: by 2002:a05:620a:4589:b0:89e:99b3:2e91 with SMTP id af79cd13be357-8ab9abf89a8mr214945685a.60.1761881826236;
        Thu, 30 Oct 2025 20:37:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.68.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac0387b245sm34001085a.46.2025.10.30.20.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:37:05 -0700 (PDT)
Message-Id: <pull.2089.git.git.1761881825025.gitgitgadget@gmail.com>
From: "Xinyu Ruan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 31 Oct 2025 03:37:05 +0000
Subject: [PATCH] refs: don't clear oid before read_raw_ref in the debug ref
 backend
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
Cc: Xinyu Ruan <r200981113@gmail.com>,
    Xinyu Ruan <r200981113@gmail.com>

From: Xinyu Ruan <r200981113@gmail.com>

The debug_read_raw_ref function clears the oid to null_oid before
calling read_raw_ref, which causes the oid to be lost even when
read_raw_ref successfully reads the reference. This leads to failures
when executing commands like "git branch new_branch <commit_id>" with
GIT_TRACE_REFS=1, as the command cannot find a valid branch point
because the oid is null.

Signed-off-by: Xinyu Ruan <r200981113@gmail.com>
---
    refs: don't clear oid before read_raw_ref in the debug ref backend

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2089%2FRuanXinyu%2Fref-debug-disable-clear-oid-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2089/RuanXinyu/ref-debug-disable-clear-oid-v1
Pull-Request: https://github.com/git/git/pull/2089

 refs/debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/refs/debug.c b/refs/debug.c
index 697adbd0dc..c8dde3558d 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -227,7 +227,6 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = 0;
 
-	oidcpy(oid, null_oid(ref_store->repo->hash_algo));
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
 					    type, failure_errno);
 

base-commit: a99f379adf116d53eb11957af5bab5214915f91d
-- 
gitgitgadget
