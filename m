Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C047B429
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523205; cv=none; b=UmnMtBUW/BybJilhnDmx5e9g/oaDsc0U7l+WL9IgS0BswO9sc4kXtiYUh4JHnzJZhiiDmKGjpCHasa3M1JarCZfPWPNVpihAFP8loBPhvc92HdePZBAeSAZRqM+BQjWHrZP7jkRu3ih8NW82+Y553qop24nHxGVZuIBlz99DAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523205; c=relaxed/simple;
	bh=5l9fni4eWntDwBQQKos+7yGh1XzNJDUg6XYjUJDAVaE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pacsicADdlfnkYVZI/O3f9hXmnuwTD8LDulC92EFqggGCHENEKU+dF96neOua7zBMY7xzqV5+1eYvLzoD5AExFGQxQKijZY3oo2SdxKb1MY5bhT6EA0+NaGYinexps+9sWHQbhfVshapUKy7miSpDxMUv5QR7XCZtIQR8IXYUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipBNKY/f; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipBNKY/f"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c477a3278so4665941d50.3
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523199; x=1779127999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHlbXSV5guyXqb3DlkoRBp7CU9x3abawZ5QTJ9dGiWI=;
        b=ipBNKY/fLIHrZECXHfqlnu3tQYjHRWfpPWHA9z7M66R3ajrzsSPNWamwP3TkS7U74F
         5aS2Xe6uE8/NmrfnJFmxF2SCFkHKyDld7x9Od7zqCD8ak87y4KR2KA8oggP3yZMTK5g3
         pS248ypaI4a2596qIgGFhXs0t4CwY6wmO74jCYANBbMqEZWfx53t4LKWbz2XAC84mp5s
         BD2+JnWKFt5RhzxsIRgnmCe3H4xYR2zIOKEP/r7K+v9N5G499EGdmCxSGEQPw4bilnaI
         uR18DKQ+kxqx7hOHqWFHp7x+zySoUn2HgtQwygXVFtbnUdv1m1DThPXzisvmPSwoknEr
         VGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523199; x=1779127999;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHlbXSV5guyXqb3DlkoRBp7CU9x3abawZ5QTJ9dGiWI=;
        b=UjRwnflB5FhusoDZZpTWGQMlRfqdLIJMS1Q5W2taRwXFu7MJXqM5CQesV1VTP8FLEr
         L+gNBflQC8wbDPv4SbowfOorq6evZVx0WTFdwh3+LdPdp4HUVI4L8l6kB3cSFnm+iKvn
         eVTgbJNQiVh/wFsNEOZgZ6LDIWGTq1/DUDKSv4XBh3pNz7aGWcDVbTVIybdh0XqTDI8T
         XpMn3ieFOhQ/ecP2fzyN2m7vOGBSgw+aHNeUn3hB4MPjDrLKavk8gXNrK3BsAgpOtTBh
         KM6DC5Gb84ED+/cXbjv95bSRt46a59JBPTMXULLRLBpjxpxLltX/VfeWF/pqVWniaWud
         VQ9Q==
X-Gm-Message-State: AOJu0YwlcV8uubluiNHPwnd21xm8NeX/TUBoLQKnElf7Mtu3m94tXN8E
	AK4tr2mTat3stEZLa7R8mNd7glVfvRaDkYHjGl6Z49ow8TMP/tRsfCD6/tG0Pw==
X-Gm-Gg: Acq92OHG3ugNey32OZOhNFiqKkSS2mzn0Wyz9D6zgbb3+xYz/hW/150PQ7WD1pyOUTi
	o/agBwdlwE/ikFl2nL3PoUiNYnooiPLwah5kwcdi5XPnzvpPgvGKvlZpw0QsdZSmBD6ZrAV2GOO
	a6If0/uTs8kgtYcvSyhZRiWjdvlsA/+WXrv5DGkjbuy6eprjXcyV6vFu2lBfTEyAcr+4U8IPwvc
	YEX1Tw4J/EWCmcxx7osYgne/NQfIPqqxqRvb9JK4fVOvKdRb1GB3PG0yl6+xjAOf8/6TDvPjsie
	Q4kAokDKwx6DeJLx0VlNRlVDcwzbbJlp53tgVwC4HVuRrkxnSWevq/nwSHIHcDrmy7XUQF7qoZa
	Cz6MzI/cPe9c+JGwkcv79Mh/g6hL4HWJl5DgA7dN0I1imeA+MbxIFeEQOT/PmFzJgmW93ZdhQel
	h7+eCy56VXKHzd36+02u27pyR3VQ==
X-Received: by 2002:a05:690e:a4e:b0:65d:bc2f:ab6e with SMTP id 956f58d0204a3-65dbc2fb2c4mr6720509d50.21.1778523199323;
        Mon, 11 May 2026 11:13:19 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96bf418bsm5729991d50.17.2026.05.11.11.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:18 -0700 (PDT)
Message-Id: <da191e29e68bd46a56adea35ba1e7a41ff2a15c5.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:13:03 +0000
Subject: [PATCH v3 06/12] backfill: die on incompatible filter options
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git backfill' command uses the path-walk API in a critical way: it
uses the objects output from the command to find the batches of missing
objects that should be requested from the server. Unlike 'git
pack-objects', we cannot fall back to another mechanism.

The previous change added the path_walk_filter_compatible() method that
we can reuse here. Use it during argument validation in cmd_backfill().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/backfill.c  | 5 ++---
 t/t5620-backfill.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 7ffab2ea74..b80f9ebe69 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -96,9 +96,8 @@ static void reject_unsupported_rev_list_options(struct rev_info *revs)
 	if (revs->explicit_diff_merges)
 		die(_("'%s' cannot be used with 'git backfill'"),
 		    "--diff-merges");
-	if (revs->filter.choice)
-		die(_("'%s' cannot be used with 'git backfill'"),
-		    "--filter");
+	if (!path_walk_filter_compatible(&revs->filter))
+		die(_("cannot backfill with these filter options"));
 }
 
 static int do_backfill(struct backfill_context *ctx)
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 94f35ce190..ede89f8c33 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -15,6 +15,14 @@ test_expect_success 'backfill rejects unexpected arguments' '
 	test_grep "unrecognized argument: --unexpected-arg" err
 '
 
+test_expect_success 'backfill rejects incompatible filter options' '
+	test_must_fail git backfill --objects --filter=tree:1 2>err &&
+	test_grep "cannot backfill with these filter options" err &&
+
+	test_must_fail git backfill --objects --filter=blob:limit=10m 2>err &&
+	test_grep "cannot backfill with these filter options" err
+'
+
 # We create objects in the 'src' repo.
 test_expect_success 'setup repo for object creation' '
 	echo "{print \$1}" >print_1.awk &&
-- 
gitgitgadget

