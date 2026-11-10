Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296233;
	b=zllOs0OKMqubHhN+7TQSfLZ+wKVrn8Ra6rqh2QHiU0P/KDckDrN9BzWkuVmCp0/9p2+J
	 dt8eoEzCrAX2mxdl3O7jF0Yt6Ubt4m5pGFgMZv52BMmGIU+bQ9QOS8m+FfcJ7UsFHCDkL
	 n27P3+wvvegb7Q/r8j0nv+QI83Gs0bToPMbNauhl/yE/80JFO7z5MNEj6y3MT4rtf/pBD
	 IaDhsKHmr3aIAmCQSBqNBWqEiR2P80dDqMDF6hTNuO3jdRt4rQ3uv5+IPJNgpKRboMVWt
	 xI3ibF4zJODa3JLOvNCkYUnb2HZscKUTNsMjW8Vda5Uv/mBmBLzCEGkj4/6Dg9m9dZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Sr7PRbGt+POzTiaTDT7dunWPR4zR71rJcbwXUrzx3C4=;
	b=XU5X+3pDVzF11CnMkpxRk6LvCNhASKgbnITujzRR6GLqE7T/tsKWoDfA9pZSRLIQZ74p
	 QVfcx8NwmxNxXUAm+sFRXRbJpSGhn30DPdQq8Vr1M39kJPvY4V5AWQ+/J914HQDrRcl4b
	 jaB15CZhUhwvZ1I/7Zh31S+9wLP53KPlBp25M/0zS7jk9Jo1IsO9S2yfn4xDRYCM/l1m6
	 R3WFymAflbIz66HuQqgo2K/xViE7ciXVAzN/RD1f2NCPX2hdFrjdTimENkP9KOmXcV7mD
	 FXaQW4fA261gYFpA/NEoe9RZWOc8vyskiXbJV2vbDRg4ab4WalwtibXvI6rQ1zMytJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oIKdeBcT;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3D60A2605
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C3D60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oIKdeBcT
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-85a5455bd3cso938125a34.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296232; x=1794901032; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sr7PRbGt+POzTiaTDT7dunWPR4zR71rJcbwXUrzx3C4=;
        b=oIKdeBcTCOV3sswinS+46BURtXR8itg3vRJzpSolTvzmvhgXN22b4nf/MgalAXneTC
         Jj1ofgrB1SxTkWZdk6ZeuiMkIK6tv11Ec6ELzTpPPyh3T9WgqoIujHlB0Q/8kSC0S7il
         k0Inbtpd58gB3DSJ5jMiGyfjxNoj6hQjuzZuBRpmzNXclkSXNIQ4y19xV+3Oy0uSklZN
         EYhgO7vaEwqCyluvoGhnP8fdo+Zxbq2yLgTnhNC9++FeUC+47mZuZlkznbQcRW8UwZI7
         5zrPOAplKfelRKxfMzAiBnKTgdxUAV61cyhnYYgci5XWntJgFg7GiAEc017xDBCLML6z
         +TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296232; x=1794901032;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sr7PRbGt+POzTiaTDT7dunWPR4zR71rJcbwXUrzx3C4=;
        b=eOsq28mnsMbP8quJK3GbXEe8FfxGDwR3a5bLcJC4uARWSWisJzLGoYZ5ywsuhEYU/j
         S5Boex265Zq/RDM441zT4Nfp7SKk2cR5EOt40cvgHH0bhZRDS5Zm8OLK0bgBdLR9uafi
         p2Q0/XebT1JGWYR5yKfAB0AK9NrzTXqPmSKaAToxHE4ZN3ewtafaFLIR0uaMlHNY3+nS
         R9uoxZmmlVAW9/3gWeh/CPEHJ5kHho4t40PLuY7AnhYapgK7REHaAenl4OINp5nD8qh/
         pDVeo9qDMCmzhirfaxzH3J8pyEesfNndW03hfZWc3N+qbjrUkXGqU+WWnxeie4+3TfAC
         BQwg==
X-Gm-Message-State: APuU4Z9jQ3cxIs+5hjFPT470hugNKCoqZr2KBR2KwYVSAqML6o7PA9H5
	rmLgJrCy1l0GBSwu2ghZvJz2lLrECtobEjafoLFV3j4loQ8J1Sz42yxIYW/ZOwfX
X-Gm-Gg: AYBFou31WNPcSs8W8hA9YhLoSqV6GibKPYLiPtanigVcgzm2TbZnthQR6+QSDHMQZ5H
	h1QdoZpu6U5foep/Sz8bjRkrJggS+5dgCPdX3DFzUcWN4ZFFuVAV43aQ7XBiQRtWMoGYoD/Znzt
	m9GhcV2QDGPvvJD8UqTTe6icEmVX4fIHgofMtxXxOqx+cYAYbPwzpCJMkmbwb0U7CCtthvIo+hY
	bsamc2QLcTtgHNkn8BX1Am6vee2l9sE/c2y7/o7/vgQi4wgdLzzZzHRYtbQuXDLh1yHFLOFyWae
	DhIJWQrPJFPdjV/U9GNlwhTIlloPwye7gGssvJNHvD057CoQ4o0RQ7RTm9o2RfEtX/zVA2yO+HW
	7XQqMRlyuKBXuCPWOZ7Cds5QD+e2A0in8DeNWH2K+8v6lj3bFNbe0C1VZ/rm5HoZLZgxVWhT+n+
	7NpH+iqYsiD4Uc/gyqYBbMISqttuhoUZWOw1U+Y0HsJhUey1aXDB7AVOY3XWxGMtqFpTIBbFm1+
	7RAIfys+n5+Du0JQyOWRM2na8eUONunrHpFMNMEmuqlqo1xJsxKS2Vjsvqc+i5dEk1qJxUtTZOh
	nY+n7MEdT9shL0pu+6T/a23TuYphV8mgFAp4
X-Received: by 2002:a05:6830:314f:b0:845:3cfe:5f1 with SMTP id 46e09a7af769-860dc70cd52mr1573600a34.5.1794296232053;
        Mon, 09 Nov 2026 23:37:12 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb5f847sm1335544a34.8.2026.11.09.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:10 -0800 (PST)
Message-Id: <51f8eba073941b8cff0de4b88cae6aed1ca8f81f.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:39 +0000
Subject: [PATCH v2 09/15] remote: handle NULL value for remotes.<group>
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A remotes.<group> without a value makes "git fetch <group>" and
"git push <group>" segfault: get_remote_group() dereferences the NULL
value as it splits the list of remotes.

Reject a missing value with config_error_nonbool(), and keep the
whole key for its message by skipping the "remotes." prefix into a
separate variable.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 remote.c                 | 5 ++++-
 t/t5506-remote-groups.sh | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 0db29d6dda..fd7a31cdcf 100644
--- a/remote.c
+++ b/remote.c
@@ -2198,8 +2198,11 @@ int get_remote_group(const char *key, const char *value,
 			    void *priv)
 {
 	struct remote_group_data *g = priv;
+	const char *group;
 
-	if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
+	if (skip_prefix(key, "remotes.", &group) && !strcmp(group, g->name)) {
+		if (!value)
+			return config_error_nonbool(key);
 		/* split list by white space */
 		while (*value) {
 			size_t wordlen = strcspn(value, " \t\n");
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 16e9a1bc2f..f11eb8511e 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -54,6 +54,11 @@ test_expect_success 'nonexistent group produces error' '
 	! repo_fetched two
 '
 
+test_expect_success 'remotes.<group> without a value is rejected' '
+	test_must_fail git -c remotes.valueless fetch valueless 2>err &&
+	test_grep "missing value for .remotes.valueless." err
+'
+
 test_expect_success 'updating group updates all members (remote update)' '
 	mark group-all &&
 	update_repos &&
-- 
gitgitgadget

