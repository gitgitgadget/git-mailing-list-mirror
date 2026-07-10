Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844743B3E6
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701696; cv=none; b=PgWwb1BsWOSwDcQpzGlLadNqMj1eNtUUH0QR/4rizQLDgSVYPxUgQrMct4FcvEIJsOZaKooEanU9PuQvXJKoo4Mfa6zc3BowlF3BityuHs0niYHevmJ7bj0jkWGxjJYLsn9KGQzr6jL08v5X8h81RXwzMQAA6ZcgdzbNbH9pD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701696; c=relaxed/simple;
	bh=O3ii94Nu2lk9CzI5RsmaOeG00pEjPXoFFmzPVD1ftEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9KyMM3p/96R6kLFMeEpfTeY2lj9k/etvo3Nw9eyZVmDFz6VXtghZDjlCqTA4uf0NxF4kq4jZ3TTIwLySOQ91HhmnLXm0LphXxouU5Hr6xscIbUrFIR+tCWAiEZVVj/Y2V+DUAc9u8M41czZD5KgaWClqLVxD3odbhw52xEorbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJlOme0L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJlOme0L"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47362928f65so1150705f8f.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701692; x=1784306492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QSZUZBdyy63NgR31jxoFmbTeSHpDPCPd/phSzVEU/7k=;
        b=ZJlOme0LKIjPRGcPq47aVUCCYfc/6rWikD4UzYLYegJMfJSgJrbFfuDR8KJ/li+rvc
         XtlZrAH3zLF5zR5a8XR8rz7heuTnvIJtI2zXqG5AwCpIICl0cgWwNupNtqHgFDqjaM+F
         Jw/ss9T5ajJ2anG4QxpzVxcvuBvzv3/1BsGf/YWHotiBmSuj4McmpjfuQ8Xick2oNTi7
         s5s1OYg7ixf1z5vIAkNguG9H9jNLsOGf8Y+M7EVw7QabjlmuYbFL4+tkSYxJ4a28zMXy
         h9WxA1+osV+I0X2xFIzrJ4No6gt9fUU8HkJ4yiGR0htpQussn4M1X6Cb6712gDUrIMiC
         i3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701692; x=1784306492;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSZUZBdyy63NgR31jxoFmbTeSHpDPCPd/phSzVEU/7k=;
        b=qhn+WP40x18rs/fOCdXikkP6n+ATfrN3iZ68XBHUlvqiNSMswa/VeFpnp6tgzXGLok
         ThnMMZEXmTPbK1lcX4K778eMvMzAbJd6nEEBNm55JDadJ0fq5+ouluZClGqQjkBm0W7s
         6b7k4JzWrvNNLXjB6MbqsxOOZnEi7VZtiZ7j3YvwQFxfaaA7MrXdSOjz4JDJhCioqjhV
         BbxZfcez4iGVxHDF67XJPcTrjcOUVc2zSmOeb2scBWwg2fr6M9Q6SJ+1+znX1l8d8oOs
         tf9C0o21hLUPBAIxAADPEmnu2HOI/mzHR/8XWnMxpAfUlV0SYEaXNv8pGBtAz6TDVL0G
         e+wQ==
X-Gm-Message-State: AOJu0YxwMg/goyVwbvUkPbdKG2giO4j+t4QRQLutyrWHcSOx6OhBrnD3
	yUjIEz3+3YE93PJmI5s+abqM/qQFH5mu7qeHIX67sHo3dNXhxUO5GhchCeC95OJ1
X-Gm-Gg: AfdE7clhLd2+vaxxDC9J8ZvjNFiFyxzl3hj66PmCHoJ7gBtd8xzV/4pQ98dnNyjc+pn
	myaEnJUKFjWsfB0vXGNzmCfXy+hwau2HjQozA/cdxFQSX+UPgeynU7ln71Ay+sswOE1CWuofFoC
	w+K1JmKCJ/YsbLw8bHmRw2fS0GEGsX9uMWXiqT2CQecjy5FCIbpxFsnsxzSDH/re+tpWlSW3h9x
	DgFBq38/mJ9MP1HsiV8dZqHUkfEi0ch1W/Exyj5tDBUTzzIP7s2u+lBkoUw/aa+k7qbICQCZnsz
	xgIP2oLJXo9Ewmu4LD+JlC/oRrNUzsvIr98OqmCihOJPQrKJZ4YlfjvYxXNot739J4VgqI1rxdc
	FrnysR/IlnqIu4gvbclRtpGAdPt/FCAXrugt0HRLkbohXdc4B8PlDEgYM32rSz+vDWq7dkrHDOh
	kak0nh3qHwIYfVGJ3ZKShNJADATrKS8YxYJI36cPXK+FJ0U8hGjfIUHjF/9WXFQSLwFvhlMNSPQ
	QQ6m+KJ/yv0Hai/rSjCoBA0eEix8UM8vq3VCHQyy9RjBCqGAJ6K3/aYvT/7tf00zR+uhhnW8kwB
	kbTx0yaLKEALatERF2O+NKIRZJ0Z4JCsTThnH5cR7cDvJrQdk35j9CNZtzkLGDYB0f5qm2BGkey
	Ntaob9Rnhcg==
X-Received: by 2002:a05:6000:41db:b0:47d:eddb:c11c with SMTP id ffacd0b85a97d-47df076a5efmr14395745f8f.27.1783701692498;
        Fri, 10 Jul 2026 09:41:32 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:31 -0700 (PDT)
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
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v16 08/13] fetch-pack: move fetch initialization
Date: Fri, 10 Jul 2026 18:41:14 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-8-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
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
index 783e3474a6..2ab5ba108b 100644
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
