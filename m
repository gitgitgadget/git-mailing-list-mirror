Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204853B95EC
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667563; cv=none; b=DkXLny2TWSVy1x1rgc3dfXkCsVGykN3aE8f3AmOXLQY29yQ4BM4UH4pRUsGoqqrJAIsT8XPUA+6fQVUChhczZ6aHMSC5AsKRfzV05qXqhvxHqzQuTvHZuwXkQZcsKLS3GdBrYfka7GG6y+WLj/keWJ9++MiMpbEk7hZBROshPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667563; c=relaxed/simple;
	bh=VpEaKwbdATWyTC0zGLlZygF6TYCMNvvcxe23NtZlOnk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nWwYPBRm4R68bomjWhFLIwTzr5Bos2JcKTTf+NkRJpATJVGXX6KAlYvRba4ulw4e6JZNlBbZE2tXPOP6t+8q1CEfXzGXykCYr67lzYYl7naFwI2C7Wimiv2qO9zkf7WH6DyNCijuepVeaZZbq/Q6KVjauIBqt6U0Ll0P8ThDYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc4OOZmA; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc4OOZmA"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so1038387a91.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667561; x=1790272361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dLsFgExg22xeVYtrN1qybZUao+PfPIFEuTtOTW2KC7U=;
        b=bc4OOZmAPUkTyvTiSz/IOu3cdS5ZwyhOmZrwJpaqIWI8abrd0mPTqaOTgT0qrQUGiq
         iGnBiVLQhoOF4YgkMT4Wj162dptRtjDKfnsrUTufvzV2XyhcWZCrsVpaWbhtCYrH4rnO
         6/zGxJBwpBqYDsOWaJ4Dt5cu73EGjIOwZQxUW0j9q81cXoGtm+CoKXpAIhCKE8I7xS1Z
         G0SWzb0Cvb0UpIdIbT2QvawM69B4QyEyDowCZVvQ5yEPl2j2lZSCRGhT6s6YNOZbMCLO
         eG0Xyyd02vq1C7dcck2nJCVroSLOpZcopq8R+bExdAi/IoglITukaUfx63CQsPafH8by
         w1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667561; x=1790272361;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dLsFgExg22xeVYtrN1qybZUao+PfPIFEuTtOTW2KC7U=;
        b=P92Je0RQlNu46EGD4q0t703snjFsSnKj3qkx9xIpK7PDsDk8EOgvoWHixQtXDuwGHy
         cYusGqIwW6Gz4oafFm1wRs5BNUQjiMvk3g58QbdxGbACdt279RIaNfvvEzVNjUirXtur
         HYrl1QiO2815bWGKVN4F08C29bFSEHc3ifZM92HxYhWdmhqdxmWPZhdipVkeRQ7sLkaq
         kGlNMAQIluTiX7Gzl59xZULWcweSmpKHm2e21Vbsm70UNOSW1aenDIB50dUQPPJpy+12
         FtVuZQd4SY8MEayv4e0tlz32F2Ga1Ylmr60UV3i9NxB4I05tLXSQKKSylkerEphzvR73
         lxLw==
X-Gm-Message-State: AFuF++lz6Erw7Qd/G7xzVVwp/dZzuVWbe6E0x9cWiErEEttjqZusKbig
	vY2wfXug6IqyGwGGZ9vs35oVDOEz11JeTzvDQyR01LrliuY//cO7J4wLoujh6g==
X-Gm-Gg: AYBFou2w4arSJzOeSeKaaWW2+QkXIf0mv2wyMYRaf7Y5/U0g3L+ZxujFHsZ+lqzRZ8E
	B509QlNji3KfkZNGkwRZAF7lLIZo3DaBsitFmt6CpRNBmyXCNtJ4kNrL1YfiKnauH4TlWJr7tvV
	E5Pw+pey5zk/usaSgN8sXc403EfjZTTF1s9WoJ2rYWbVUXp2CfR+oq+A/bzakUAmtDK58BBEvHx
	j9WPgqSPwx+m+CV1qFkagJ/Nv+tj8QFQhVUjYPvZF64lge3nijAb9ptBj+HCmWvrMsDHb+FmfCP
	Fz8ydrsTFxyLcEkTg5ldZApt4iL9mLQSkLljyLRaxKha+HVHFHq6E7p+o1wUbUZJ9VwUx4Mn/f+
	7G+HZuB9kROPS4W2acDpk3zQlXj3ITWJ/Ic5ta2i62IZw4GMxfGfTIdrkerQMoE67ohrQFAQhAY
	cMLA8DZY9dzIMec4vPSqkB0RGhYcnrzzNsIX8w9QPOgZ1gKIO3Wk0f+GqtV7TT6ZOLW+Nej+DL
X-Received: by 2002:a17:90b:4ac6:b0:39e:135e:130e with SMTP id 98e67ed59e1d1-39e1e26599bmr15992136a91.3.1789667561068;
        Thu, 17 Sep 2026 10:52:41 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35b589c2sm6150495a91.0.2026.09.17.10.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:52:40 -0700 (PDT)
Message-Id: <ef08bbae2dec527fe2097c09f9f3187e0f38680d.1789667556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 17:52:30 +0000
Subject: [PATCH 1/7] wrapper: guard writev_in_full() against signed overflow
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

As Git for Windows' Coverity run after merging v2.56.0-rc0 reported,
`writev_in_full()` keeps its cumulative successful output in an
`ssize_t`. Although `xwritev()` limits each individual write to a
syscall-sized amount, repeated successful writes can still exceed
`SSIZE_MAX`. The unchecked accumulation was introduced by d70eb7f3600d
(wrapper: introduce writev(3p) wrappers, 2026-08-07).

Treat an aggregate that would overflow the signed total as an I/O
failure.

Assisted-by: GPT-5.6 Luna
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wrapper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/wrapper.c b/wrapper.c
index 561f9ee9c9..05a9cd369c 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -376,6 +376,10 @@ ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
 			return -1;
 		}
 
+		if (signed_add_overflows(total_written, bytes_written)) {
+			errno = EOVERFLOW;
+			return -1;
+		}
 		total_written += bytes_written;
 
 		/*
-- 
gitgitgadget

