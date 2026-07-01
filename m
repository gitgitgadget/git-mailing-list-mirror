Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334CC35AC07
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889477; cv=none; b=V11+4b1OOhcpOPWJ9UcEGpi/8xefx2oy79h/Bb7nP8k6Jc14btEi7a9xXsfSQ063K72Dco8vBF7CmMDK28p8KsRgxVol3V6Ic3Xf0eCSDgWZ31iUq2ZrnKSxcK9FiH2yFiWhslQFv8r5lkqBkF9f3+R5SAHm8FTWVuKu5X6wDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889477; c=relaxed/simple;
	bh=P+bjag/mhRgmWdbtGWOi4RJlM3qLMDz+CvvsCmP0SkM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LLzqF2fh0fD/MhyefGAbLUOr3RPedE7ZlyyYXvoKvWaRer+534569crgGffmuOqZ0zs6DZwm2xyB6TPr3+T5IL41d/mewIK8YhoOcvUwjzfd3K69gxsVzdBASNrbieJ0QuuAteeZkxm8avhBPKJjdcE99duVt3TAXqkZ4L8mISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4fj9CkP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4fj9CkP"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bf2479349so1712841cf.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889475; x=1783494275; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOdH+Ry15tn6NWLVPRfBqmo9rYLjeg7cJjN/xpWWwog=;
        b=b4fj9CkPRnca0Sr7RALirVepLeouU2mkviLtZ5gLQ66d5w1DGiARZUzNKIvuziW0fy
         oJQWuKU/xJP4x3wN2N57W3+91YN5qXzOEeXmTxfsjBUcu6mJFs3FGRX3mjfLSohb04Y5
         JeftO4p4BXnWDM13S56FF8GrJg28HDH3gPmIuaMzjKsWMTYmBlLuH9UrOioSDYcen/cd
         FJO/hE2T4lT/xH948Ap13LBsGzM/GoUG7Gu2e5pqoGAKKVyQU0ZHAIPwDjA9rvo2ABdK
         7Lruz7bYv7QtYoSiFn/ZQwU6lfTmaeGwBEJcpSyodxkesmJKy62dpT4iPbj9PQ9Oz+YL
         xb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889475; x=1783494275;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VOdH+Ry15tn6NWLVPRfBqmo9rYLjeg7cJjN/xpWWwog=;
        b=MYs2iw6E8FZCV85p2FKhxxpynCZdhXKidpa5Nnpef2LCgtIvVXd6LH+1/0xdZcdtn0
         HmBAPtYolxOQc8IQEApE9lnOJ1/NwrOBUMrsoEfzAghPlRL7KALNicnSCE4E+fwGK03H
         LRWkmvn9/KB0KuLWuNt5l+SnYVcwAe523ZDDT8ZZoeGWcp02u7wzKP6HQjkkdNISyywt
         iKGvC2Vb2xXSpZg69tLuVLjvZImMV1UE//lC2cur1HPbOJ6kR/Oue8g2ZIh432UbxwT7
         FNkidEf9gfumHSPuHUNXG4mkv/T5T5iHH83J0AVE46IwnIk9hRjtroysXgZGODSMBgvB
         w91w==
X-Gm-Message-State: AOJu0Yyt+uJSijrCu4pL4FH9KfHqCi4sXz0yIkZQIdGpdjk5vQx6GflH
	kAhPkrXtwxZkKpXCxtK+YTcmYmr/s5LE/KeRkdKpjfcTCaxyghLlpIkKyw1PBQ==
X-Gm-Gg: AfdE7ck1pW4LK1vqLc9ngxvfkBvDlnCI1q0EiRchpV2l1YMgWGIa9nlmCBBDIvhSiC+
	HPK/6eb92JYo+jZEafxG7h3OU2U+87JXXJr85XPVqSBBcZTfnIBRj6RmVESSnZz8YQSLR0jFdeE
	j42lUtaxRzzKukkRSd737lXTwMUPXkIHt4zf4Ndf9WZwLUk9da+qYmG+pgV8cH6AVKeY5fWPK1Z
	bV1VbKLVDFgDL9TlgEhqgKqZqniZBuQkvWu/LL+5NYKxZ2s6j6qJpCHh4Fw3NaIjZ41pjBha5Eq
	uu08/manz7RTBv3u/iLlgiSKnzF54fnreM4nS1ZfR7YbIyN7gOzJdvvJ0WwwwG+WQyncG7bR8OS
	QOb+SzsDXjWrH9NPWEmnVy9L2oFyyJfg+32cL5SS6FrZmF5amOwa46ivxQalMbBCPOTL4KvWvb0
	OloZWnIWGiKCY6G3pV
X-Received: by 2002:a05:622a:5a1b:b0:51c:1a17:eb92 with SMTP id d75a77b69052e-51c26b3f4c6mr6101141cf.63.1782889474990;
        Wed, 01 Jul 2026 00:04:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3611dedfbsm13623856d6.24.2026.07.01.00.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:34 -0700 (PDT)
Message-Id: <17242c249f0beb387fd30634663f13ce42d34f79.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:19 +0000
Subject: [PATCH 01/13] load_one_loose_object_map(): fix resource leak
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Pointed out by Coverity.

While at it, reduce near-duplicate clean-up code at the end of the
function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 loose.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/loose.c b/loose.c
index 0b626c1b85..47b7f5ec38 100644
--- a/loose.c
+++ b/loose.c
@@ -65,6 +65,7 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 {
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
+	int ret = -1;
 
 	if (!loose->map)
 		loose_object_map_init(&loose->map);
@@ -98,13 +99,12 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 		insert_loose_map(loose, &oid, &compat_oid);
 	}
 
-	strbuf_release(&buf);
-	strbuf_release(&path);
-	return errno ? -1 : 0;
+	ret = 0;
 err:
+	fclose(fp);
 	strbuf_release(&buf);
 	strbuf_release(&path);
-	return -1;
+	return ret;
 }
 
 int repo_read_loose_object_map(struct repository *repo)
-- 
gitgitgadget

