Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767839;
	b=z7ceUYGw8IauuNptlizsxzKrGRxura7D4EhO4viSQDpNkBaArzej//eEzhw73iWFV5lc
	 8RYvQiIqebkgNw301ISmiCllouKse04HSuVNnD3WCWBQDooxLSE/u19UnBDnsUGLvSj+o
	 Bb0osEV+VYNeTTzFYO5VTzD1DB+2KmLtlAoKckgiAL1iHk8kEZOeE6mbWBoHOIEopjyKF
	 kBTKS0QNy6WslldPQw/cnLtblgCmQ10GXEtloskQeKoDVVLfETXJgskJRZRrR01Nob8Rs
	 /Z8ki4D1kAvR03PN0F1pNw/Dcfw+MqDHG5TQn/ciSnZH9xXGzMCMl/eKxoHF4z3AwTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=agng+AXmF9KMmLsUHVYLKriyyiRhVwmdUIxDbZQKde8=;
	b=p5rqHzSzheaJWOPWR07gkY1UjXfLYx8qiUyPNhF8iGpioSdcDlWG+LoVDQH9O0wZBCM0
	 hKRfRHNpk9g/q7xVRKLuHxQKDXKCvjAb6j+/Smj8ywzZtg8I04v3oLeQOJN3+WE3QvNJB
	 ZuyI+OOco68bWbcnbICdGg5jXR0XtsCYyXad7KctOhBu+Zowm4gU7sleV/u6+HWgejaNO
	 ThILXm1QdwiYwe900vlVv0VD4dIMTIL+K+siiJjrE6Cop42hGNV2Dt9MUc4HhPKrUg9vI
	 /FXAeEFHDsMHF/LXOJi5JJxqPxsEiTiZGBhd2DkSRD9ICT3v7eEeo4f61tseDiT7qUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Xzn4c/2V";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48C606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F48C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xzn4c/2V
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a218ffa23dso3054845e9.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767837; x=1793372637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=agng+AXmF9KMmLsUHVYLKriyyiRhVwmdUIxDbZQKde8=;
        b=Xzn4c/2Vygxe11DUryei/Ob8g2ruMWHYJnbrqCOzFP3I1ctcnYpZI/3EapPX6HT6hY
         WKv66qYTGqpYNsxGKC6oEEncyusQi19O/fqnw2VAepyFnBfb5zYU8OOkCdIMi/na+C+W
         SxTllFWdsCrhrDjQhBuaNJzER1SXm111XPr32UJT3+su6wBQWS+/k6lSaWAl30rjqGpS
         4kHWkejSU3MU/KFuC9BOxpEYytRlOeaPS6M2i41DHx6HKFfth6hXfeBcJ1pXvUwvkIAD
         nwzK2YY2dUy0dcxoYOkXI+a+AL8tfyvYjG7urLZ3YrkEnncwJ7hy9ghox7g2XSpXewMQ
         EDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767837; x=1793372637;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agng+AXmF9KMmLsUHVYLKriyyiRhVwmdUIxDbZQKde8=;
        b=JFMyREoUKp8a7C6pJlJgduqvERXWQoARNXIhfI9vOe/Gm8W9g5H5OO3nk+tm4iY7mq
         zqDDodtKQI4DLQ1Auu2VcDJ5Di4kz0P38EzVqJF/tY+8szrhm6tF4KYMclwPWqpgpv3J
         Z+zp1GYbSNjWf+tIY3ezQRXvnEMWB96jJB67hgfjr646lkGEH2yXXivx6D8uLDQs+rKy
         NJLZKdjK75mcK6KWh+bG0hoUtfFW3CATbNDhPmECxPPrmlINLXKQL/LMdWFRL9deWm6F
         UCuRadsFJWEX4fP9pBwLjQ4azMUTEMlYK27krZJiNJKHmp+fXrZTFS6KLcVJT/BRVjLr
         QCbQ==
X-Gm-Message-State: AFq9FYIeFoFkntVt8bag9ygHnmA8dCf3WqH1JiVDfEE4GSVNusvdoF3w
	a/BMrNOKQbpmtxtqBxxa50buL7TOi7TNts9GFNh/sz81NC5IenDGbBzVLTJ3jw==
X-Gm-Gg: AYBFou2P3T/d2iXW8PkJWOxRYPc3wFAzvF0LMj6xaKnJxOqXnxVcczaBzAmQWkCcFvN
	2Hb9hPA91YUUFjG2CzeG1PjVHDUa7YKejqcKgW+QtJbO/rsI+7w4VxA2xaZWZgebScezp9nZNjF
	PGH7hEcdsC+mACwZeVbkO5THpUrL/b6058wrZaibs6nBY25Nr+BFEZQzk3lg0J2Ai0J/Y2sRPNx
	u2H/vfMYi0lKccFCkukpjq6kaF6411m58jIzXla9nGPynEF3H1O5bd7FghxqIXfcXs+4pB+wm8+
	GUZFsRruesz27DJlqLfCFqGjaqpEeQaORSy1DSuQpL2CMcdsNJ+Xs0Ci/HFdch2TSDgi6cUjj4a
	CT37XsK2ZoXbH6tq2dusTRBW8U0SYEbMeaQgi395IMs0C6gJ+Ibg5X8wNRS7MVRC0jrPk9BcKK0
	idWfVgPH3bxG4PtFC31iNfCKgnZQBmhBxUrP4bp8MsrU7tvrPq9RdKDm/Feea6ezRsSqpGI6m2C
	Kao8rwk+D4mqRRiSD+OPo2pNxYNgEZerNHOT3vN6kDOEVmyc4j/GnWwek4=
X-Received: by 2002:a05:600c:198a:b0:4a3:2f35:38b4 with SMTP id 5b1f17b1804b1-4a32f3539e7mr543885e9.10.1792767836666;
        Fri, 23 Oct 2026 08:03:56 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d427e68sm296326f8f.52.2026.10.23.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:54 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 7/7] stash: simplify reset_tree() function signature
Date: Fri, 23 Oct 2026 16:03:35 +0100
Message-ID: <f61ebbf9a3e1196dea36e5fbcf4294c6addad222.1792767795.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792767794.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792767794.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

There is only one caller and it does not want to update the worktree or
reset the index so remove those unused parameters.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index f97cd4771a5..f0e3053ab49 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -332,7 +332,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix,
 	return do_clear_stash();
 }
 
-static int reset_tree(struct object_id *i_tree, int update, int reset)
+static int reset_tree(struct object_id *i_tree)
 {
 	int nr_trees = 1;
 	struct unpack_trees_options opts;
@@ -358,10 +358,6 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.src_index = the_repository->index;
 	opts.dst_index = the_repository->index;
 	opts.merge = 1;
-	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
-	opts.update = update;
-	if (update)
-		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts))
@@ -738,7 +734,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 	}
 
 	if (has_index) {
-		if (reset_tree(&index_tree, 0, 0))
+		if (reset_tree(&index_tree))
 			ret = -1;
 	} else {
 		unstage_changes_unless_new(&c_tree);
-- 
2.56.0.134.g299a3c16181

