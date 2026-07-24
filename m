Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30767429CE8
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890483; cv=none; b=FwYs1ANZlf43wFV5MPNanF3WPjsvCiYR4jsO71SJwVPM+xLX3GjlOf2kTmHnYlHKuwkngeopMDgEou2KEFr/Fq3LWcfyhJar7lqcV8IiW3M6kVnbGZE4TCMlUhRLtG5ZhTGVbhpE4ur9tpOGe5KAmUT44f55ENrDuzXWZ9HoYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890483; c=relaxed/simple;
	bh=GnUJXHZE790eQnLxUVyhpOxXpxrPVS0DpL9MT6Xb1Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gysQEIx/sUGprXn/ekH53QXkvgZjIcPq1zDHDmACqLIGlObRW+IzCknMydhJyZkhuCSgjQXx4Lv9ZM1aOP+36fHcvEm2DlNagreNVpqvTw1cBhMkZMOPM/6GzrgnTb91I/C0NYU/U+iWTS35KQ3X24LAlTHxtUgoXE6Tnnp/3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqcmvJes; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqcmvJes"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso1979295e9.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890478; x=1785495278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6wXA3r8XOJMXVM4IQaZkcMiiWJEnDFhSXXWQcDmyLH0=;
        b=RqcmvJes87t9DqpIzSXeNegeKS6Ob+svJrNFcSx14MACP1F7kXqIIs9tKwO0fVdaVu
         cb8XcBlArZzPUchp/dtGdULuiRfKHv6QwS+clUVVZI/wgAOgipQRHiVCLPnQrEpcud0r
         wvZ6CFhyu51/o9ak5Rl//PXsnbHtuK/22UQVn6EUVoDgSofkrFwHb5ZgK4w9v0okLh4Z
         auD68Wducbs/K0oExusXnIrQ8P8fEQLwSwFqr3igi5YCK71YvG7S0pXuhRNR0LkznjaF
         g5xXmC+cwbLMAj+mXMXaaSbw0wSmYek0+YW4v3XwoXiTnNqLlMUXmHHBFm+b5t0Xpi05
         OrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890478; x=1785495278;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6wXA3r8XOJMXVM4IQaZkcMiiWJEnDFhSXXWQcDmyLH0=;
        b=HH40mb1czC3tEs0/adZaJszTmjUHh3Ng+p3MFyfa/a31iV6Fcgu9RT9ohyMdpzzKvj
         SBhRhFAZhxwMXoBaKdTLNm85ZBjMcQF2sQU/25/QThQcnfl6xBXNlDGGJzvyh2xLgokq
         YXATJ2hQfTtOFfdqnuPfnZ75QMmkd6lCyCghrPgagPA7xPnHzhBh0q3qV0B8qxy8OvCg
         NQAa6rXIKY/QaMDGBiFwMg6LJYOve8AyU+040YveIJ+IBNERUmf5iEywp7XoENgvT7N5
         Ee7xw8HlDDXN08aCg4wky4bgDFc3pis4OF3/6dDWtDq/2mzcoFawftom0lJL+FlPXn2T
         ocPw==
X-Gm-Message-State: AOJu0YzMXnvaDO+FJ46XtdGivrjeBhoD4CT/aa6Wzqr5Tt4PbmmqeXZb
	oc073Qnq6q1w4UlMQfrwiOYUrEpi9uEn+n2nCbnG0k7rcdr314VTsGQ7m06lZs9S
X-Gm-Gg: AR+sD13ox/dMphx5jA1z52ZGXywxjySmlO6qMVVPqaEwm0BcoizM2Ed042ewi1DJJ2i
	ju3mNFhYuoZCZhWKHXxsN+PIFchTvtZ7Trnve94zLIwwINA1dXTt/EZR2ulP2Ts5DvOFZHwvTy9
	1MU6Mh4VNeZcrnyHZxxRsIdnVJWdR5/qyGJX5GQEBm8FvRr2G8Y1iQy5AbqTfHwVPmsdfsnWUY7
	06DtMLblaVv5Lknjq0T0zR8ZRfgZpbKnrexKS1yO/l4pdB5KUdPzCHlruPVayAzEPfYzIuXxSVs
	dUTdE32zOCtd+ZePi/3HWkOZyYfjiq0uE8aDyJI6WTwmlhYG52gdTUbykjE/gzLI/stHodq7wkQ
	9UyH51AP/Bes7nh3QOnEHQfT8zhy6lrTjGP9I2g3zeRAZxyXo0CQoUrhdc8T27qH4yHKwV4HYwH
	GLF630Zulxrh3LMPi+jYS6LfBTAQZmz+1NDxHMS7QdBBqo2sTDCr4QSCEYYSZyi/MLIJmBSyg6N
	bFsbLGnm52i09ULAjzV4fAO9r2GEGBDxvwt9qbzjLBdoBQz339KQQoSgLpXgqHTzqXvqkRc793r
	AjJqrJpsQt7m1oye+/oH1+tHc8ge2M8HxjmN
X-Received: by 2002:a05:600c:5843:b0:495:4a34:16e1 with SMTP id 5b1f17b1804b1-49573cf660amr55976295e9.23.1784890478270;
        Fri, 24 Jul 2026 03:54:38 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:37 -0700 (PDT)
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
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 08/13] fetch-pack: move fetch initialization
Date: Fri, 24 Jul 2026 12:54:19 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-8-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
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
