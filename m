Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018417;
	b=JPwsIDGobyiQnxPYnquMC0KHZaCdFY3Gr1vXaVc2Cn5by9lRmxRWdyh3LFtWjn/l3/Wr
	 vEd88CPE5ZONBgnbpnEvlbB98c0uz+mLX4q8GPa3ei1qWzT0Jy1PT1BAsj4nFisWTtncW
	 LDLkv4Pr3e1Db5hSJGygRRrBfrceaZF1LBxb7VujIMSY2OQbhwLhvwNIk/84bMvvOB9JD
	 6w3u24K0ghKKCrWebCffNhW4xQFXOy92WqQBlNZFGBM1NwITdfJJwPISkiF872C9BdyuS
	 wNW3FK7c0wtlvDsxJBPvcA82LUse+Cc2wvlF4eMQsgmBe55rr2tVI9Fkbd2PafsHA1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
	b=QdUht5hep0M5T0v0q18YYNODDzQoMPT3LCPVR3jzSvSt3RRfVvmyZ3UWz5usDvawWWgJ
	 3uhhvNsD0+L2ibWBkXqeJt5Bm61wPOZKyKFx/s+T4RwzOqRGm3zHopGAGHdvACx7Zcs3O
	 oMYvA7IItePxGwf365XFpZ/3gbYWhSN1SgTH0/9Wn/jEMOyjymMysce99tB8137aTS3Pj
	 SSbVF6YDTkAsLRBYJvxcRc8Jyqf4Gglz5LNDP/P0gbq4CunhkQxSX4ZmdHSYa3YxBwpzQ
	 QjSucDM5pucN+wS2JivU27Fx7k4dQj9e+1b3TtXlE//W8JAKU0bsUhQ1Juj/noVaR+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fophmm8z;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4D60A2601
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83E4D60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fophmm8z
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so17295825e9.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018416; x=1793623216; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=Fophmm8zvgba+n5yg315wg5B5q8YhUikPZ4+n/JWUZ/LDdl2Df1jtc5A0AbvbJj/lY
         LRfLHwvG+VrgrItnAGTwGSAmOZ5FmXv/ZeKQgf2Z7Ggu/ZKKC11pWq1uICHhSI7n3+c1
         bAsp6pog/JCuGs9/LK4r0mtGwSgKcetqq4ee/Fm+U+sAKqQGzwxda3f6sgXaR8K5df3E
         +X+/3SYatL1VHxEhGSYJ5D0Y1zElGS7nxSbAwQSn0VXc1QwXketz2d30PA7jcN/kFjb8
         HhQlo72AC8LsJb8ed+unMRCpFcOuFqdtYWo4flFqEvT+z2SwjzFO6mzMh8AP0HwyRUAZ
         UZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018416; x=1793623216;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhWscAJgZvhgRG2lewsH6tQniR5MqRwB4EK7tBzorM8=;
        b=GRz51BdaFap1TbBt92sEk7/ndQAQN29gJKCtECmsEAV4GeZA9nq8Z6YubDvzzuvJm4
         7Ky7mGY2bAcjVtBLKYfsg9CytXeGreWeIDwlHHMqGiD0Scbo1P5Qc6NSt6qkKrQNio0x
         hdBuPaGgeSK0PGysj+2enZSJXRylMN3iJdyHewqR1MNpZjXa4YV64CRydyQXlmVd/l8j
         lI1w/Z7blnfkbkIy26E5jm0WuOY/+lv5uH1dnAw5+sThjLKHm7jLYNkpxLVrwmMn3f8s
         m7vReHkZF3suZsYcUBXIxb0/GwHhm8jlxXE0E4Sw1VtdmX8NoBNNURGd7JhPt/BogjXA
         gPhA==
X-Gm-Message-State: AFq9FYI4R+2mHITx4FPb/IbFxryTJyVPzvfelukIq/rFgLqBsaqVSEmH
	OWgOMPk9oN3RrGZhLVptn/35ZsDSJJFCn3eiK8c4W6SB5DJ7TCJcl6qtiIh5BFv+UqE=
X-Gm-Gg: AYBFou03XXPv7pHhg8FQSTx9Br3sObdJX1lMOzG2eHLuc7gPinZiJeunXozFgM0lnFb
	zxGK8pQS4AiXF7LO+evEYWFUqp0KSJsdaVybnC8MO9oI3Wy8+SIw5kiEjVf4v38cusp4CM8Ybce
	KvwdOGlialvqLJcbqRY/oChdAh05iH6kVxi0RjQP//u7EIFkDRVy9aM5woe4ShRb8azife6FCiB
	t7b01i4jP9tGVQV7gVSbHYfgHRkkOsWwqMs43VnCncpF5lFx/ipLnDzGVSuXTdMXiaJhsL9Lo+C
	gBOIEV3AEuyQt9Fsfn2VV04HwQQElQAwnV90qI3oGdA8NZK79hDfhIWYxYKPR6soMRm5HxzuSSU
	UJh0j5u47fnjPtt1c0BtgNDL37AiWHTg76ze3MdEI2NNcG7lUlLuRYgr3oiF0jrruZXyJ8Fgt/C
	B/dUZtHPKBy4+c9mCbAeJ5s9+ZxrFy2b9DopyIwGW2rK5s8RfK6U+rPaifVm6MlxjduWZTIHqVf
	mvrEpwWIkkaQOaNhAmHwTJ5ROu9Joow47kzewnlRzn7FcGAnrjl8wNcIRau
X-Received: by 2002:a05:600c:3b19:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4a35acc7696mr123746155e9.18.1793018415640;
        Mon, 26 Oct 2026 05:40:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.191.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5698f1sm192840255e9.8.2026.10.26.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:40:14 -0700 (PDT)
Message-Id: <4f434f5acdd55775c6ddcaced073e5a0e3ff732e.1793018405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 12:40:05 +0000
Subject: [PATCH v5 6/6] doc: git-pull: link to new merge conflicts guide
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
 Documentation/git-pull.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 88f4fd3926..73f6d460bb 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -38,7 +38,8 @@ or `pull.ff` with your preferred behaviour.
 
 If there's a merge conflict during the merge or rebase that you don't
 want to handle, you can safely abort it with `git merge --abort` or
-`git rebase --abort`.
+`git rebase --abort`. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
 
 OPTIONS
 -------
-- 
gitgitgadget
