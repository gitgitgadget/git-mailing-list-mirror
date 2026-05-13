Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C9E429831
	for <git@vger.kernel.org>; Wed, 13 May 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686965; cv=none; b=Z5tfkmXd1xwlBbVGZOEoVOyytsPcCm0PTb3eTbOTGgW9OeWXMZ2tBw5unWBjakQ5txDR5iWHMtI5P2jO4hyucwX6PxIWsngR1TyLXmQm2KVB0E6FUbSYiRejmBbs0+eNJNhvjrK64ntC8xc9PBgdIhz95Rpts6qMAfKNIdk4hXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686965; c=relaxed/simple;
	bh=baVPgDk+lID4MFPivQVaiCgHynG9KDtqRKTkf0HYPPU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tK9vWAo0XPak8nwjfyDCx6RqD1z9IVZUc/An/Tz3jHn9cn/G3ywgKnA0AuVl6Fi0btw8YpBx6pAL7MmGjkQzKFptkQmTJ4wvXVIj6pxO6RIrho263pm9KblaEa54Y8gvQtpaUtfRO9f0v4fnyyEyzBjRjxQG8ksy7jLYvHG5os4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQgjGH77; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQgjGH77"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b5232009a6so70391996d6.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686963; x=1779291763; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QCxOqAzuh4WYXNsf7ioxoLpDViP25Bl47TRH2lnai5M=;
        b=hQgjGH77cy7rvdzz6VsmidKOcerby7JZ0N9knME1PdvoxNLA/lcw+/EgeiiWjVNXKQ
         Tvx+ujIX9RexVTpfx1SlANohRS9dNL5zoCkadmv4p2WUG47D14w/jmxzKqnqod9RD+xr
         Lk+k3piFIwpUMy4IpC9I7v7i4Dr1YPoYDwBjoLHLFvqaVS3umWBs0NeChx766kRY75+Z
         clivcUJwoUm091lGNApIf93YiURG+j44ggQ/2kzUyfoXgERTkrBLnYhLyvk2f5v6SMN9
         +y4lhKukOzYoVOmwuqoDWRfa3nn3X0ucFe1LOTC/eTzl3RyPljoJWRRqD/eCCmjllRJ9
         OvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686963; x=1779291763;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCxOqAzuh4WYXNsf7ioxoLpDViP25Bl47TRH2lnai5M=;
        b=FCt2FfGf914DoMJSrZZJyZzig14a6K3wBlvwbOxVRDdoPhTj99J2yY5L2KuK4Lf2PE
         0FBKIeqQm/5dWo/d8e/X/7HwkFDzlpnAuzes7pjAf9Ou8r9zwMWX/HQuZGM6J4NSlkbY
         D4Ij8dN179/mtrueDJqHI5sKeQUe/kkf2nJN6iCQGOmCOA2+UJOPOEvyGfgiTb5xFJIy
         VMjLf0dVL9k+F3ZmmBp+IkJBGuSX8Kre2q6SGxv3DVoxnfIPzJ8y32vgUU5EhRzkLnaJ
         ApKdI+DJ0jV67hR9Pkx+Dg63Ge2ogo0b79tCJ4p2mGBVYwUm3bnzFNIh+exw53FiFy2E
         jkoA==
X-Gm-Message-State: AOJu0YzrzAbAsXSHpXh8+JPp7efmZb/eXUr6BvAnvZFxOgrkAD07816R
	mj5Ereltm3b5Fz3hnnytIy3kMyPe53Sw+HYk6jxcwDZLjGAl4hzuYSwD4GI8ZA==
X-Gm-Gg: Acq92OEpbUgXGEQ5HC7Z3M81m99+juHFV/EOjhQR9m35SKmaHt2JmRxeKzaYc3hfMmr
	wkjWEqKSeE245loA0DSvWhVyXdnfpQ4URb/Jv9TmZzw4By1f+sZHNYIP84sN+bG04Onz/egdP8n
	hMd2s0bTOyUg7lI8enwifVL8CmywDsQyNaOTrdMCeZEklHpV/32x1SqCey1hVeUVXBD1eRcZURq
	b83dlYkZkc6eBMyj2yKNvt5DY9fg89v8ILz+3dzeUHvh+9UfemMhq6AprjBv7L/0uxfAw3wa4b5
	7Ys7JdS5eKBmO6HtvWVKRvywnISiIcKFKgoWw8PEDfW36iVbkH53xU7vORKwbkDBiIqhzecX1rK
	WBjJ7J+JTtq4sJJGFyi47oygOXNFaFT2G9IRe8v9cz5bzZAQamR/8oOt6oDNR3gLhqlsMzAhp7c
	0DdJjr6dFVKntBWIK28aYLEnpyxA==
X-Received: by 2002:a05:6214:300c:b0:89c:d50e:b57 with SMTP id 6a1803df08f44-8c7dd6dbe2cmr51690216d6.15.1778686957797;
        Wed, 13 May 2026 08:42:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.179.93.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a33fab4sm156325966d6.23.2026.05.13.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:42:37 -0700 (PDT)
Message-Id: <pull.2113.git.1778686956622.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 15:42:36 +0000
Subject: [PATCH] doc: clarify that --word-diff operates on line-level hunks
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The --word-diff documentation describes the output modes and
word-regex mechanics but does not explain that word-diff operates
within the hunks produced by the line-level diff rather than
performing an independent word-stream comparison.  This can
surprise users when the line-level alignment causes word-level
changes to appear even though the words in both files are
identical.

Add a short note explaining the two-stage relationship.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
    doc: clarify that --word-diff operates on line-level hunks
    
    CC: Vincent Lefevre vincent@vinc17.net, Johannes Sixt j6t@kdbg.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2113%2Fmmontalbo%2Fmm%2Fdoc-word-diff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2113/mmontalbo/mm/doc-word-diff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2113

 Documentation/diff-options.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 8a63b5e164..665473e61a 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -457,6 +457,11 @@ endif::git-diff[]
 +
 Note that despite the name of the first mode, color is used to
 highlight the changed parts in all modes if enabled.
++
+Word diff works by finding word-level changes within each hunk of
+the line-level diff.  The line-level alignment determines which
+changed lines are compared to each other, which can affect the
+word-level output.
 
 `--word-diff-regex=<regex>`::
 	Use _<regex>_ to decide what a word is, instead of considering

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
