Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750E39524D
	for <git@vger.kernel.org>; Tue, 26 May 2026 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779767894; cv=none; b=ZOf7v/DbVe9nQKKEosfKuoCg3AuNXKYK1g6l4+p5i1zuQ/dXWOVpJtPJWvwhrChPITos7MYNHKrrrUHo9ojuWsuJav//B9XsVdIBKwNFkJswA170Owl91cY2Q+3hpe6Bqf0+LjKDvgo+LcfTvL35M6DcizPE6zOXAf1NlvdDV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779767894; c=relaxed/simple;
	bh=NI2gJeKEy+GApXf117hRSU7lWYOZqF2prBjOZ94/Uks=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IkisaPWpOSjAy2K/GeUHj6yaUeCZop+55HTIrGnLISEsPOLbJul0pfayHMWjYpqqwoQrwpNuYVASg84o8XZ3IjrC/t94XgLQt+OOISSeccI/HINVRbiu5bLKgLKv/4eZGOpEI7YvJYqDv5yoPoeB+LjPw8iAuWIBUefMfcB5Gbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itzkCT+K; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itzkCT+K"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so132914076d6.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 20:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779767889; x=1780372689; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1pwgycrbs8ujEE9S32noqUNHYUD94M2jILewYSzDOA=;
        b=itzkCT+KSD3F78Vo9iOiEnL7/LAVz1eIf4FGDgMptKNBN4PZUAQfJanelwS4WdSIrP
         NYF26Kj566DSffQYZ19eP8KlOaQmh3CqrVNNJwizJ2XM3V1skGDqwNOQbnVyYqMdDZwm
         miV5U79lfcC4WvHgnTAPbJpadcNjKxxHsnU0LNQ3kjnXHEvvmMwxKPcLD8q/icWOo5ci
         J7EiplcnoXb+MZKbO0A18DHRIXkqzOE5QY5WIiUQzlGdKKDOe4aCKF6/xk/PzXwkZR9J
         UXx52jHnWMWPW0l5H3m1JNNSZ+Y9W1heJmiTvqrMN51IfSYLz/eJKeawgd6rxq9EEVEm
         jm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779767889; x=1780372689;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1pwgycrbs8ujEE9S32noqUNHYUD94M2jILewYSzDOA=;
        b=VYYZFRFSSjvCOFVHyfV4WF3ayotsyTweeKv6q6hhQ7tO4thFqGgD8FYEH1qlKJUT7U
         DuiKJqiKcG2M9/JdK6DwkIOHv8+mdZB2tdvs5qz6nQc/SDkZW4fm01MwzrbYkh6EcoVd
         TSwxu+aBUl0xowDhrs+iAg0nVNlD2gjQmnnJ5LoT2LUv4dfZu29EOKM0JBAkXVKwR470
         E5/govvNLS6PIF0F2+YIWIRQza6I1832fu40KtirzyZp9Zmhv4yJf/SRPyk4IWuJEZaO
         pG9xzAMqsHRc/33kl47NFI5mpk5TtJPtj5L7t51UypcojDBmpbJ3wrn+kGlGL4UfIowt
         hpCw==
X-Gm-Message-State: AOJu0Yz5XpI383kObQ0LmediCrzD/ZOIXksaPj5buUxEbt8ycGieKYC0
	iDqJJ8DUQU/5HcqcA8FP3B40annsq1eqhceb4tSVLNW0Yg4pvrXG+7KwxTZaxA==
X-Gm-Gg: Acq92OEipU3evCeBkc24SBUGvxa275vI/N4KVU36ZJvVorZY5wvUyIbP7x65O8a+lV0
	J3g2IV4jd4JCYc/EyHbgZeSVBpKYGlgODGC4SnlXj0yw3e3DJhFyik+wJEH8r3McSUIpHO0J5je
	imgOuCC8QH43znhpzQnKbZ3B/C6z/Od+qxWG0CeuHuc0EMdcDwF4KTYAQ804wy6rLZLZC1j13fw
	b3By0yrQPKqsFOEw0WoxV6PS6GeWLkmTxp+QI6jrWjh79cNMlG5GU4f0IpwuJcvvhuPK+jr+NG1
	nKthLUFVrUu/T2GYGh0xYbwlktOyEIVReH7ctzwhEKHIf4JdelWAUYuAsI65SstZBwCcZ8soW1y
	33J4X5jIfiBuFVUb97K/hwjCb25Ie9XN+eYkGg+tZty1nXAtX7GJcLSsz5rTK4/x8rRgjAK21bo
	wOV7fTYD1oJrb/oLDxWGk9ppPnwQ==
X-Received: by 2002:a05:6214:21e8:b0:8cc:3546:262b with SMTP id 6a1803df08f44-8cc7b65a93amr257802256d6.24.1779767889505;
        Mon, 25 May 2026 20:58:09 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ded529sm130301346d6.16.2026.05.25.20.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 20:58:09 -0700 (PDT)
Message-Id: <pull.2115.v2.git.1779767888508.gitgitgadget@gmail.com>
In-Reply-To: <pull.2115.git.1779433093971.gitgitgadget@gmail.com>
References: <pull.2115.git.1779433093971.gitgitgadget@gmail.com>
From: "Ivan Baluta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 03:58:07 +0000
Subject: [PATCH v2] doc: clarify push.default=simple behavior
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
Cc: Ivan Baluta <ivanbaluta.dev@gmail.com>,
    Ivan Baluta <ivanbaluta.dev@gmail.com>

From: Ivan Baluta <ivanbaluta.dev@gmail.com>

The documentation for the 'simple' push mode currently singles out
the centralized workflow, which can cause confusion about its
behavior in other scenarios, such as triangular workflows.

Clarify that 'simple' always pushes the current branch to a branch
of the same name, but only enforces the strict upstream tracking
requirement when pushing back to the same remote being pulled from.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ivan Baluta <ivanbaluta.dev@gmail.com>
---
    doc: clarify push.default=simple in triangular workflows

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2115%2Fivanbaluta%2Fdoc-push-simple-triangular-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2115/ivanbaluta/doc-push-simple-triangular-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2115

Range-diff vs v1:

 1:  37ff842622 ! 1:  3deb7f5b0c doc: clarify push.default=simple in triangular workflows
     @@
       ## Metadata ##
     -Author: ivanbaluta <ivanbaluta.dev@gmail.com>
     +Author: Ivan Baluta <ivanbaluta.dev@gmail.com>
      
       ## Commit message ##
     -    doc: clarify push.default=simple in triangular workflows
     +    doc: clarify push.default=simple behavior
      
     -    The documentation for 'simple' push mode currently focuses on the
     -    centralized workflow. However, the implementation in builtin/push.c
     -    falls back to 'current' behavior when pushing to a remote different
     -    from the upstream (a triangular workflow).
     +    The documentation for the 'simple' push mode currently singles out
     +    the centralized workflow, which can cause confusion about its
     +    behavior in other scenarios, such as triangular workflows.
      
     -    Clarify this in the manual to align the documentation with the
     -    long-standing implementation and prevent user confusion.
     +    Clarify that 'simple' always pushes the current branch to a branch
     +    of the same name, but only enforces the strict upstream tracking
     +    requirement when pushing back to the same remote being pulled from.
      
     -    Signed-off-by: ivanbaluta <ivanbaluta.dev@gmail.com>
     +    Suggested-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: Ivan Baluta <ivanbaluta.dev@gmail.com>
      
       ## Documentation/config/push.adoc ##
     -@@ Documentation/config/push.adoc: If you are working on a centralized workflow (pushing to the same repository you
     - pull from, which is typically `origin`), then you need to configure an upstream
     - branch with the same name.
     +@@ Documentation/config/push.adoc: this is a deprecated synonym for `upstream`.
     + `simple`;;
     + push the current branch with the same name on the remote.
     + +
     +-If you are working on a centralized workflow (pushing to the same repository you
     +-pull from, which is typically `origin`), then you need to configure an upstream
     +-branch with the same name.
     ++This mode requires that the remote repository to be pushed to is
     ++known.  When pushing back to the same remote you pull from, the
     ++current branch must also have an upstream tracking branch with the
     ++same name.
       +
     -+In a triangular workflow (pushing to a remote different from the upstream),
     -+`simple` behaves like `current`.
     -++
       This mode is the default since Git 2.0, and is the safest option suited for
       beginners.
     - 


 Documentation/config/push.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index d9112b2260..28132eedfe 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -41,9 +41,10 @@ this is a deprecated synonym for `upstream`.
 `simple`;;
 push the current branch with the same name on the remote.
 +
-If you are working on a centralized workflow (pushing to the same repository you
-pull from, which is typically `origin`), then you need to configure an upstream
-branch with the same name.
+This mode requires that the remote repository to be pushed to is
+known.  When pushing back to the same remote you pull from, the
+current branch must also have an upstream tracking branch with the
+same name.
 +
 This mode is the default since Git 2.0, and is the safest option suited for
 beginners.

base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
-- 
gitgitgadget
