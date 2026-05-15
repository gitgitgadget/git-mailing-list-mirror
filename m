Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3653E92B7
	for <git@vger.kernel.org>; Fri, 15 May 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831776; cv=none; b=GkfrqH9Q1ZXyHAC6Q/zef/EBOVju0AurseCbGv9iA625Akm/d6vu5IK9ri2LedHgHVy4Jpjt7auPkAIUey32I+fW9r57Rfkwb9Oct3/absvQgCR2HI48jgSJ3i6tILals9mND4mevkPexzcvAe/irEcy/ancX/0jrkgEapwUVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831776; c=relaxed/simple;
	bh=neAxCn6wkqRUb+PB6qydHNQVIAFjmO/KQKeknuQ+UdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6+9IPKBAWDuJ1IHv29SSAnYqG32peDFyEk6uVA/5dn6tWiO3lfS9qPv7PtLvKeIY3ewd7wYG7OI+enfJrBx3GwmF/8Wm43/w15/Nt52SnNx/stuOh5RJVDzBIm6Y6kPrUsyaFgPQIOI+sTaEI8X3pJqJTr5yHVBBWriUp045Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5Pu6NiF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Pu6NiF"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so1005654e87.0
        for <git@vger.kernel.org>; Fri, 15 May 2026 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778831773; x=1779436573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KyDYo1iDs4jLN/sNdoixYeLDpmWtlXMkh54x2UX8XM=;
        b=J5Pu6NiFP1n9aoy4j23l3V+3k8smmMTtx9DUT0913ysfkrSJ5I6NkcGHk6gVzVWwO4
         3hHLodS7/vNdCxbuPzMv375uYDS3u1JK0nD5eMmpjZIaAvnLisrafroJlUjAsjSEd9rR
         xBnsnXkFGY6EOzB3Vccfh+OdcTs+olZnhmMULr3uX3PxjNo05a81R29ObevWKnZZaCGp
         yMlp7NrjdW3QJCLApUI1g1zLB2hzF7JIjlxSoplb6xrc+EEraCPGuXKMjdsrffpZxQkQ
         Ytl0endAFBUORILSTExB889CAYYhl89IT+pzxvTr2p3eoIfnfZ1mDMs0r5TGaPQrdpkI
         CjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831773; x=1779436573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KyDYo1iDs4jLN/sNdoixYeLDpmWtlXMkh54x2UX8XM=;
        b=Oar53w4yPgDTFcXnQ1StyE9Oz0jiO+QWR8CcsMVN3J7OqKR8cJH5N4kGJ01Qc8uY/I
         CDcPGRoTMLv/6WpuVKsXFG06bkFH+pQhOiOz7XVk5q2XpNE4QW8oAPdCngIltCVffuL2
         w0mj4hYJPw0bosYolGWzVo7yEdH6E7zm3BVLbq1OnPHxzU58LT7Eh9dBjuy4kZPFkqgn
         3y2n2w9OKkuxwgYKfFhTzqfAhyApZn9U2usw2Rd9MdtjtPY3O53ZRkyI5zACmk5xT8UH
         gseU4H6Grf0TUNboCEKaYcBVskcAwfPUnB9rAotFCFCgOcRZ3SSZCjtdhFY2OTtEEbPM
         yuhg==
X-Gm-Message-State: AOJu0Yy4auDrCpGL0Lyj2j3YaIx2b5ggziJUarQ2kJDLyel7gmE7qjmW
	bKZXYXj5mmyssbFohPxE9w6sbThAK5o2sY2Qr64U3umyxTW82uihPoxx
X-Gm-Gg: Acq92OGG+hZ/6LZVivg5tQy15RKpQILLB19QQUKUMVY8nWaBPxkh2R0JXtbGKjcrbyJ
	vvR/2iB8tP0V0+KqtP5dNvGStclJDeXoFRLpXHhSCwNL/CSJq6+Dx4V1Uw7Txv/3EQ/jXe+6Ci0
	oBlcagUC1dHTsW7dewe6HSV6IrBGG6e4aPhRCwXKBMTRGZ5aV5ROX5b9xPvQgKgRP2Q/Qdg8qzV
	CkytCv/VUE+S7LFrSyNOc3HegJsRPrZKbLoH+XXiP4isBmErLOOEKFC89+du7yVSmRTo9OWh5Ve
	WDORJrVPwGeWuQLwq4dqqGRyVlSimDxlrhnime6lRd6p/22v7QdPhTRmNfdBw+sfGVtLNwsUuiD
	DVG6zwdU/5DbPUTPJzv5xkpTiDDIu8jCtGCi+9nMPENNQKUtyawmcIXHQmZ8aDdP3RF7yRq/q9y
	IBFlzEx/kdbH6DAyiGePfE3h98u1bwZYpm9Hipck6Ok08HILrzL6LYw0B5F5LrWO9HO3mnIuUiR
	WCNQQAY3YMd19dO
X-Received: by 2002:a05:6512:3095:b0:5a8:d7d4:4948 with SMTP id 2adb3069b0e04-5aa0e7641e9mr800675e87.33.1778831773161;
        Fri, 15 May 2026 00:56:13 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164c545asm1136944e87.56.2026.05.15.00.56.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 00:56:12 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Email issues
Date: Fri, 15 May 2026 09:56:11 +0200
Message-ID: <20260515075611.59535-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.106.gcfa0dd594b
In-Reply-To: <xmqqecjdea13.fsf@gitster.g>
References: <xmqqecjdea13.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Why do I get the above, which apparently is a response to my review
> for
> 
>     [PATCH] config: suggest the correct form when key contains "="
> 
> under this thread?  Am I dealing with some sort of mechanical slop?

I think the problem here is my email sending process is not good. I edit
all the emails in Sublime text, where I keep the same file for all
different threads.

I have the subject line as the first line of the file and like you notice I
forget to change it sometimes.

I keep each of the topics bookmarked like this, 
https://lore.kernel.org/git/xmqqecjdea13.fsf@gitster.g/, and then utilize
that like to send the email

```
  git send-email \
    --in-reply-to=xmqqecjdea13.fsf@gitster.g \
    --to=gitster@pobox.com \
    --cc=git@vger.kernel.org \
    --cc=gitgitgadget@gmail.com \
    --cc=haraldnordgren@gmail.com \
    /path/to/YOUR_REPLY
```

I tried playing with neomutt and and email client replacement, but that
adds the complexity of downloading a new mbox file for each reply, it
didn't seem easier, but maybe it is.

How do you handle emails?


Harald
