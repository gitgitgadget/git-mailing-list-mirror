Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F43EBF0F
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300747; cv=none; b=fX/nN/dTS2rccJeMK+vY/BK+kWtIYicD3Wz2TbCuD05CEwIOAOLHXQvi3GLyzcHg0j+G08a/drAMkBR3+oWJiLEow3QVV7HOdokfxOsiqaY3ss6ZZ9lhGbHUaaUf1YjcZirsneuyLBv0Qn3rVzG9zpPCOzo+nJqQ7yejgKnr1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300747; c=relaxed/simple;
	bh=GnUJXHZE790eQnLxUVyhpOxXpxrPVS0DpL9MT6Xb1Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0nsEhnu7Umwd4yZdMGcUeIUnpJcaXDUwxcTe79Ed7DTzsP52rXXPARODQdEx2nMb588THmxcXbZP2jrZtAj5Opq3KMiphMbueRAoMGm8PM4n6MkYJex1m3jKhiwREAxqBIPU/fim5DFSinbQe2KR1BWDL0Ikxg7t8bVbctRbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJgzVDH1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJgzVDH1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so4834485e9.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300738; x=1784905538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6wXA3r8XOJMXVM4IQaZkcMiiWJEnDFhSXXWQcDmyLH0=;
        b=TJgzVDH168sh4uxAROp/GseKVM4HL1DEGU+9yLQ2pohS+pL4+/W4OGaM2SQh72QGlX
         pOCaqW+2muJhU76YLbpZuXJypJkZ+5EeYC4DJ/7lbFHoHuo4Is7chT8rEyBvf/mgQJRf
         Hynh4v4pwO6tcVCFujEndlvQjrXg5AkZxtPPXFkhrHCTPbydb1s5t0sR6F5iEOssej1p
         QrvQLgfN5rFzWJ/xc/BfryuGCIISSwrfy5zyVz2TXqATJIO0j42zuxqQcVT8XxGnnpok
         +RtUfRKJ6qLsW2B/mYIY//wP56q/Q6yz0DDmrjBNT7X24KH8WxM+chScQh1Hl0UeDAWH
         RT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300738; x=1784905538;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6wXA3r8XOJMXVM4IQaZkcMiiWJEnDFhSXXWQcDmyLH0=;
        b=q1i4PLqFGzh1PBnXt2o60iyny+2DB9gJvj5E2yfuCNoL8tZktKvBFYD+GNg4BNHYJN
         YhkJ6fcJ20ZWv9PWf5mFzgR61rYlKK50zW6uYJkvhlC4gZm5+60bpaBlwq4a+PaPtubh
         OIVQSQR/G//orkXlHJMc7b5NKxjCr8BbRFCwt5g8qfd9+BeZ+sHhp3E9GtoA2gxKXpRc
         rBFf2KUbNkcmeiHHbVPdZqG/opbjaMFv4GVGoftlUwV469TGAkrQfKC3OB7BqAW4rNB0
         omIigqPjSpaHq/5MV5MSTTfp0yFQYJ1nIun0k6l5Kl7xO1HKJahHzPUBHN+T6BD6oTWv
         WBPw==
X-Gm-Message-State: AOJu0Yz8/RJcXd9Lv1bpoZAszka2EMeet0P+z3o2yZ+svkMsGkXC7eEa
	ZUV0ijuhcdCZRbPj5SEJilYIasoRVO5pBogH3TsEu25b33ipBgf6qovT8s9AbSe1
X-Gm-Gg: AfdE7cl8vhL9nJEe+fg5Wj8YBaobJuKrFw1tRpcwcZoB40LMvbRJlGpHbSeZR3LFkY+
	CnZ0w8cCpWn3LUHwxTeelyT6bFvkh1jywbXEmhF/UiFmHd+cJ4JFaiprUNjLMv/W25aAlFAGmvH
	56TR1xKjkqiDh9+srP5fs429bI3sI72AargTzvCaBJmrJeceu6xG3PUhM95mxDw+N/9HUkjRnMM
	Ut6pjUWTKriJ05xmCGFWY8hCcEVl/nlsPI5mN+OOcajglhk3/2vIY2bgTY5/V3UeqySIUu42BYt
	nKOK8RjxJFFUyQYWh97scyH2TkpU7XhpddS8mdbu2paymrqDrUa8Z66ZbDUCXFBEp0S46hbhLNO
	OynViYe+TcCNM9dWpd+P9/Z3AeSZ0wpeDDdJ5ezcMJaUkrz/Q4yvE3Yr1LNy16V9MGdOKzhSKlX
	dpjH0kJTt0Ys2UWuUQlv7wnlaCIbbFoSSpAI8x05KxkdiLXv0guhtL+IMnGKciuR269eTmxAlOk
	jUKBpqISc9y9HiSkenop4H0mFZs05vqZScL4aOfXZ0/M0MZlqMn4o2HmuMVmsGgdCugI3BPL+tz
	x5rUBpX80bQDaUUlXZCQaBwkjkWN/nSUKkzWCeWlSdk=
X-Received: by 2002:a05:600c:4f09:b0:495:3b2f:df04 with SMTP id 5b1f17b1804b1-4954a50d66amr36824015e9.34.1784300738464;
        Fri, 17 Jul 2026 08:05:38 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:38 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v19 08/13] fetch-pack: move fetch initialization
Date: Fri, 17 Jul 2026 17:05:18 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-8-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

There are some variables initialized at the start of the
do_fetch_pack_v2() state machine. Currently, they are initialized in
FETCH_CHECK_LOCAL, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables.
Move the initialization to be before the state machine,
so that they are set regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3695059cd5..922a9b2581 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1735,18 +1735,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);

-- 
2.54.0
