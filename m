Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764306;
	b=ln34dA+7bWJwQWiwFI2WhQGNMc3V+YH/70xQJdZoAJ+dTvyvE8zwNtQfuQamUZKPrGZ4
	 cUXaxVQVLB+SG0FoxyBhb3wFBSCNp0y7V1lcmnTPnY5vG5C869jVHNyVLKpXNwLza7tqy
	 P60qt44aMHSLjX3gPPG2qWZkz9vEVQG8NpWqYcrwz6qa5ss/Y/CU4ySKuOId47mAJSvNR
	 wKyLU3TBw1M1s/udM21okRuFnXfUfCGea3ORr3+neGNpNPuE/j9ddgy1R4NIgIKsnWBPu
	 u7Rrexfku4gfjCqFyPDEajtxij33A3L7gq7f89Zof+X/SwFWVcofC9Lt8mMEJI+xW4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=uVMN4yYvQBwSe22gBPvAn84Cr7GNBJBX2Ji9ZZYVwMo=;
	b=2EY44jPtmxmFWBZuF1HVBE1oz/DvcqvEShdGKhaWlp6PwIUFVjllV0IZ+w0Wc42kt8Tf
	 RjfZs9Kq0k0EA6QsMdOLU2S7dkyM4TbnJEHO1EVmlmMuwSpB6Tz34g2b/PGBr/CnOuvQN
	 JrvWbmhy8dc5Qa1oftO5Mf3V27GBpW0acX/nEwMpPzvo/kI7NnHW1PCqLm0VvE8ueVkMx
	 gxWep9hySCMo30/1PzfD3ghL+IGScrtJt9m0x/anafyUujZfPOrqP9h8ewCBXNIPy6WvR
	 cdQ5seTERwXgDbrtSQJklP2oxIc8pWK0RjUeE6udzy8iFlYm24VrWxUCUNs9oR6fcTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QbOpILbP;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B2606A322
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F5B2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QbOpILbP
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f2493c28bso76076185a.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764304; x=1793369104; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uVMN4yYvQBwSe22gBPvAn84Cr7GNBJBX2Ji9ZZYVwMo=;
        b=QbOpILbPYwJozyBj9/gnGWqr7IJgVMAxY/ZuOsZGtww0Djib8JEgsSEy8xSk4+EwER
         bgCIOY0KzAmjqACDPV/MAfRG+EKsABEF4W05DCK5KkjsZKHt6RLylpm3v3r3wImEOTzz
         bMdWqgA+jSxvJPiFcRdybtYSuHT7Hly9frJc4IZzgmMKhF2DIZc+R2lIEsFFS7QGpTfl
         gURkmuMbXG43UdTDovVUE8fFF3Xdt1YJH1JBCHNQ+8xyTWQSEJdgwTBk6dp+nK9r4JWI
         emMyxq662WL59VC+RWRgCh/ZLEWY68TSHsxuOw0bZZ7quqBi/4yZWYeN6wrVZ+VcntRm
         P8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764304; x=1793369104;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVMN4yYvQBwSe22gBPvAn84Cr7GNBJBX2Ji9ZZYVwMo=;
        b=jsWmpfwvwSg2tHnLMzD5ZJsUUU+iApwa4OPRmIfGMay7phxl6uLlql+MQtEYYztQ1g
         ZjxXztSR+dlyLYAAMXLZvZVm0h5GzXn/I2EjTSV5nScZpP0lk9SK/Wap9zVSycmiVPUa
         O3BMNQZFfa+mv+0yaLT8GbCQNSn+5qGu/xdaZDnVlhwdqquCImTiNd5l6MYu5Mpiol2W
         PB5O6FxtkBJCEch6/wsSRIfT32v8rVb3F07szGoZQtaL8QqGfCbzABWfFINAjKcmw4Z/
         wDJMzFDFIszkyESezx95GAPLYjVfsEeA+5SF+SklC52Mk1KyWQKW3fnQzulKRgP/mXuO
         j+5g==
X-Gm-Message-State: AFq9FYLcWGqCrdoRUwJil6JeQnQcQXCFEQ5nQqaWU6ZGAy45YxKwYKYR
	+DOYIWdXJEKhJjBKPNG4EYNBm4pzieN+tSN7ajlpqGgV4DApu9IDoWO7Jp/8BmBc3cg=
X-Gm-Gg: AYBFou17lqnLxSSNc85xFa6x08/tuXPdqiHEbgwwfYmlGxUxTg8h9Mf+0L9tm2TbT/C
	5O3QN7ByoxDJY9XxHiCHkpAiIGcTwD6QoeUW/BVrZvLitjuaoOIntDpoLV5pa/MOspGyqVzVZhV
	kZJidP12OzBG5IHdf2IMIKsctz45LxcplgzQ3nvrUxfvsQi9PhYbPAI4V6lBTmOavtBxsL2H0al
	Ba5HYJlwm6z4ZlTFHnxiIL8AJNDlsATM41wHCufDH28uycOg/lgCYp2htQ9B2U6NAjX33i66G7n
	mOBC7+rmUZAe4kpb26556IX9y8sW7ax4rX0QOEZdVs9g5YjP58Mw+IwYh16tNBTak3eV4vbByxZ
	+hgYunZ1lZ9rb7/uRfErfFd5nwzg51AFXkriJhN/HO7MntrgDhiqu8ple//tr1i+BQu1dFe/MU8
	PJHF2MpXrNc4UvOgCDj+RZbYtJozJ4rU5cfwvlPu6HPxxwxVZKpYPc9PuyTTPDUvMP9700KJURb
	IjakWFB8AEl2I4MYvOKv8rkxyQP/OJ3CybUgyBJ++myY4cHjKYEdJCkew==
X-Received: by 2002:a05:620a:4397:b0:93a:2bdc:cd57 with SMTP id af79cd13be357-93f6f5856d9mr409073485a.2.1792764303959;
        Fri, 23 Oct 2026 07:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.58])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9404732646csm24958485a.10.2026.10.23.07.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:05:02 -0700 (PDT)
Message-Id: <53083b48a3177b1899757d0682ebdf7167af00f5.1792764293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:04:51 +0000
Subject: [PATCH v4 4/6] doc: git-revert: link to new merge conflicts guide
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-revert.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
index ffba365e63..bb0f859f66 100644
--- a/Documentation/git-revert.adoc
+++ b/Documentation/git-revert.adoc
@@ -31,6 +31,10 @@ both will discard uncommitted changes in your working directory.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
+Reverting a commit may result in a merge conflict.
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a guide to handling merge conflicts.
+
 OPTIONS
 -------
 <commit>...::
@@ -162,6 +166,7 @@ include::config/revert.adoc[]
 SEE ALSO
 --------
 linkgit:git-cherry-pick[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

