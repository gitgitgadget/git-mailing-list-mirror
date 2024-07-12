Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3334D108
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720824624; cv=none; b=Ee4T+4UmbfXqmiVZDIzBFvZLIt6pqEeAYtXYyyIRtmhFs4h89vHODd1MAPIZqwdr2Oi17ytDNkNdzMfT9bmZexi/k27dx5qzheyJ+qAFcSRRLkQfCMslHrBKi9z96v6jwkd4zDO/GPW2RkaIqyXV931a2jPmWHmnACxMWd2RiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720824624; c=relaxed/simple;
	bh=KwEZXOyhpUkI0o+TGv8GIcSueORLGyZFJywdpJWDPwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJyY0Mx7biAYkF8q+LRiLNEINaUwbC+6pUUSZaRlx8xlIchjbCc/jZO5LMembdIwVuxOKHksc61NDfgujn7f5GXN8WiFahv9xrGeiv1MCIs1zlVoeN9oPN6HGOtfPobzRIYP9VMb7ih3Om4T5pm0UVs9LVkIQD12jbT5rqU5kHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8PvZD9r; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8PvZD9r"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7035e281970so1441090a34.0
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720824622; x=1721429422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyBwyyVwhvYmvTRmpP0L//oP9KVirE2Y+Zli6kdQ9yg=;
        b=H8PvZD9rD565FtaWd6+CF7aOx8vFOXybDK+HGo3SCxLflD6Phu4/gBePbILmpgGzKE
         j0nc/tZPSVWTtTz0pTdpvI+zeTnRQ50UfHVNplA1GkIAzfc52z+TnSAw30ujUYfYwbE2
         y8ieXDIQzi5mAzEUrLh6dfJ/tVFHodLEyYedx9c7N8uSYJPH7NzaGKTyqz47xodlMR/l
         SabH5dCfA4ovtxBBsulQdOorurz7u+sYiHH5qqSITrxNj0J+Xnzmit86yNHeFv3crgBq
         7+MqAhIS85T8dEG5i4/GLImyDA0Za8F/fDxMgl62roQc1BQo4pYsX+LxKNz5rdYP4yVf
         UgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720824622; x=1721429422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyBwyyVwhvYmvTRmpP0L//oP9KVirE2Y+Zli6kdQ9yg=;
        b=j1oJtrvlFUSsWsVRr5G+44y8i8jibcJ8mmHL0vNBonO4m3gCHVVpHA0ebRiGwDtppe
         ozDvTXcnyOgq+9+jlwIBJ3xrOtVpj64fZI24tPKd/zwh04kpw83dpKFrOr9MeSXbgrxA
         V1wuYjXAOkCo5pPZUp0YexW9/ua5WqBk4AypEtg7cNbSJzV31FLMBP3jBP5z2NtzKfB2
         8WzGfnn7Uwd67vVtS7vH68h9kaTo3nh1CT+pJWADNguLUVtVWuk7y+UTVDr7x4ecuB9i
         EyZ+5T9laYgTO8TsDg+bQh16tMHOsMsuVA2dBUpN2x5J55v9fqHFlieFfGireA+4CoRZ
         D2Lw==
X-Gm-Message-State: AOJu0Yy8taBGvl8Nm0m62OVEkX/dOEWkBjWiOgHY7/lpniUySLru1lUP
	0Vh/Zcux/CPzLw8lVoQghVUn88Vlx1rptBv9V8w2StB3BWo5vS194PTGfA==
X-Google-Smtp-Source: AGHT+IE031//8MT/KV5KRMm1hPwnXiZA5AqWB307LzMyuCc5jIg1DnjgIAI88gvh+E3DzYkwe639yw==
X-Received: by 2002:a05:6808:212a:b0:3d9:25ec:d9ff with SMTP id 5614622812f47-3daa9710217mr1974997b6e.20.1720824621846;
        Fri, 12 Jul 2024 15:50:21 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d9e09061b3sm923582b6e.58.2024.07.12.15.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 15:50:21 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] doc: clarify post-receive hook behavior
Date: Fri, 12 Jul 2024 17:47:48 -0500
Message-ID: <20240712224748.56843-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `githooks` documentation mentions that the post-receive hook
executes once after git-receive-pack(1) updates all references and that
it also receives the same information as the pre-receive hook on
standard input. This is misleading though because the hook only
executes once if at least one of the attempted reference updates is
successful. Also, while each line provided on standard input is in the
same format as the pre-receive hook, the information received only
includes the set of references that were successfully updated.

Update the documentation to clarify these points and also provide a
reference to the post-receive hook section of the `git-receive-pack`
documentation which has additional information.

Signed-off-by: Justin Tobler <jltobler@gmail.com>

---

Greetings all,

I was recently looking into post-receive hooks and found some of its
documentation[1] a bit misleading. With this patch, the `githooks`
documentation is updated to better align with the hooks documentation
for `git-receive-pack`[2]. Thanks for taking a look!

-Justin

1: https://git-scm.com/docs/githooks#post-receive
2: https://git-scm.com/docs/git-receive-pack#_post_receive_hook
---
 Documentation/githooks.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 06e997131b..f9eb396a79 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -415,13 +415,13 @@ post-receive
 
 This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
 `git push` and updates reference(s) in its repository.
-It executes on the remote repository once after all the refs have
-been updated.
+It executes on the remote repository once if any of the attempted ref
+updates are successful.
 
-This hook executes once for the receive operation.  It takes no
-arguments, but gets the same information as the
-<<pre-receive,'pre-receive'>>
-hook does on its standard input.
+For a receive operation, this hook executes a single time at most.  It
+takes no arguments, but for each ref successfully updated, it receives a
+line on standard input that follows the same format as the
+<<pre-receive,'pre-receive'>> hook.
 
 This hook does not affect the outcome of `git receive-pack`, as it
 is called after the real work is done.
@@ -448,6 +448,9 @@ environment variables will not be set. If the client selects
 to use push options, but doesn't transmit any, the count variable
 will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 
+See the link:git-receive-pack.html#_post_receive_hook[post-receive hook]
+section in linkgit:git-receive-pack[1] for additional details.
+
 [[post-update]]
 post-update
 ~~~~~~~~~~~

base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
-- 
2.45.2

