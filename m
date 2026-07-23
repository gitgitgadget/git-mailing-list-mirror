Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090E3E63A4
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842405; cv=none; b=ei/zdfRAsL/nyXrRrJ5iuqtGjVpOiAZaTe5dqFVK0hieti6gP9f3X7SzX214ZRXHzcn6/jcGxl63WA7vVHCsbdDlWmtNWjy7RufEkUmeaGysGmMmzURUOFBce3BlBHpZReZn+yoDW8laN0H3Ci/cqmR4kTHkOHVDE+WxRiW5SZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842405; c=relaxed/simple;
	bh=3dJDR29t7fHHlX/3npTJjtovWULXZgPq9EmiQDwhfKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8YBiVHGLCSDiv1reNtIw5Wd/V7XdhhvJYTY6qUd0TUQit6whzUFVUDVfNM6rRL5DYK6FO9R/DjMtDa4sOI3r0OzTHY8oZjNk+BFiNY5d8pBXOZKCNDR6KuNT4w24jboNWsiUBhemCaQQFGaP9uFyyqg0KFLya5tddFa847yRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEfd60vL; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEfd60vL"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-38111ea8a88so761069a91.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784842404; x=1785447204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q5RC8e5zgMOjebY78675rshMWRmhwZw0EQB4cMxDEkg=;
        b=dEfd60vL8M8GKoahDct7tQUoSY0lgfx0P/WLzy7b+yb5BTsquuVPJTUjcD3cklAYqu
         N2tb6LQOjgCRf3VzJq7r2pP7nf23Ip/e/YjZknvZcdDTzBUKsH6Uq3TsHtqyFVKLvkcO
         Kh2RdelwJ5YpAf/vIwAFp0NmH6zDHWW4NlhFG00EJELKx3VOSEzmw5ASWH+PIIsOgok6
         SOtY84Y/7JVIuMzH2flpVOb3vHbWFJBEP7P9caZk2ynk6cbr6PZ/DCJttNRRLSQl+mBP
         Vcarme9FNu06oR7QTJ8rhxvkCdldkKUUMmkhSo8YmisDL6A8erFvLMTBEzyHtu+yOnRw
         I3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842404; x=1785447204;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5RC8e5zgMOjebY78675rshMWRmhwZw0EQB4cMxDEkg=;
        b=QUe3X2JDZINOzfiPAyMmC4yththzHIqgAwkYoILnT6W9hII9MOERWv/SMKPb2PZfxz
         UNnXJxNHrPYJUualN0k6H8eyTSAYEIl9vRlgemYh/ruyQjOkms+pK33zk1Con/K6GNCL
         YbWYgNrs1v5GsvhSF5TlqFUKkTz1WB5kY7/Zxj5wmdcX/kK79MQS7Z4zLBDyqSz1L+qv
         wkKsNBjirzR2uLq33V9A+QfDgn2B2Lycp1yRa0yA9OVM83ACdAg8V6maexB9/oSGI2Jw
         ZetyCfgLaBgbamSu6s2oY5pptmeIUBSOTKf8Q24bo6e9wvPnVaEg3pb+ffhlGEpJB8Jk
         vCJA==
X-Gm-Message-State: AOJu0Yw1YKh2JNel+nNTpA5oApW8H9r7VLO3YKWhwOptmpdlXt+GCpKf
	WwCqBf5XtUcb5zkO+GjS+HfgYio+r3v3FR4VLErYQJBTJiX0eIBHML0s
X-Gm-Gg: AR+sD10gtlZOnxhssyF0zIJ4NJSzbRzAfS3L9o71pZSyZXtWuz8SODmVOku1Rz4rYFF
	+G1AZBaeK4/p6J41TY6qEk8A7Of3PBvK4RCwsSLl8OvgXw6qTUhstm43SaCFCXNSuodGDP3zLh+
	KHlSJ9hOhYzKdRwxT2aMG903RGgdXHbs58WPOSDjJY7WKWnses6nRkC+KIysQ1WPTcZXJTzrCYJ
	KdkO3ujKuOml76KPlI+n/QvRg0lt3b9ljD1LtMa/+2hKnmdHlHxvZyHmQEoTwiOldt9k2qTNysz
	j2b/hO4Mb2Cuno953E24mW6O3tjK91xTPB9Oz5XsSZKE3vjkM0TZ97mLXPdOf+Csgz1p4oKAElc
	VPOOAWJcMYg9NF1yoTP5bdLW0afpuQQ757BYOx8f6Ua7QQA/2LBd0rTpn2ZL01acq/RlPqsnlqK
	EzNpxac3ESK0/XquK4rMNveJHHyg8IKn93Ok2kvJ2u4dIndzk=
X-Received: by 2002:a17:90b:1b01:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-38ec64f272dmr5269033a91.13.1784842403654;
        Thu, 23 Jul 2026 14:33:23 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.215])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130cc5ebsm24734361c88.12.2026.07.23.14.33.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jul 2026 14:33:23 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: Re: [PATCH v10] show-branch: convert per-branch flags to commit-slab
Date: Fri, 24 Jul 2026 03:03:15 +0530
Message-ID: <20260723213316.89081-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqo6fxe8rf.fsf@gitster.g>
References: <xmqqo6fxe8rf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> We are removing this initialization. Why? Have we changed the
> API to make BSS initialization sufficient? Does the updated
> code no longer use this structure? Do we initialize it
> somewhere else now?

The init_commit_name_slab() call was removed by mistake in v7
when I restructured the initialization order. I moved the slab
initialization for rev_flags_slab to after ref collection, and
accidentally dropped the name_slab initialization entirely in
the process. The API has not changed — BSS initialization is
not sufficient because slab_size remains 0, causing division
by zero when commit_to_name() tries to compute which slab page
contains a commit's data using c->index / s->slab_size. The
structure is still used throughout — name_commits(), name_commit(),
name_parent() all call commit_to_name(). It is not initialized
anywhere else. It was a plain mistake that I should have caught
by running ./git show-branch master before sending.

> Firing off a new iteration before there is a rough consensus
> on what it should look like is a total waste of everyone's time.

Understood. I will not send another version until I answer every
question through discussion first.

> If you can resurrect and continue the chat session with the
> AI agent that spawned the v9 patch, ask it why it decided
> to delete that init_commit_name_slab() call.

The deletion happened when I restructured the initialization
block in v7 — moving flags_stride and init_commit_rev_flags_with_stride
to after ref collection. The name_slab init was in the same
block and got dropped in the process. The AI did not flag it
as significant because it was focused on the rev_flags_slab
changes. I did not catch it because I did not run the binary.
Both failures — the AI not flagging it and me not running it —
are my failures to own.

Please ask me any questions you need answered to be satisfied
this is a human-understood patch. I will answer each  and move this patch forward.

Vishweshwar
