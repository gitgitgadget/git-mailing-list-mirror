Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399559;
	b=ulQTtiRriJ2EI8TVXDGeo94xMPAzbjAN7+BGBIbceaR0GB5TSdcKUH+OEHrJwpqs02HC
	 TPZUUTtmcQuTIPYU6xkgPG5uITUJrezmEQoIhyI6B+airqBZXeE73t2X8OHMFPqgPAtj7
	 UMqn8VYfwtZ3XmsiY+EE/ZV7gY3dVg15KquQkrhToJPwdj0h+updjLeIi/0isuEZh3oF1
	 5ccuHjoDwbKk5C+IbKlcsJXm5RVBGuXXAMRc7p7PyDoo9ffUs9+SqykN3+wCQuz+hx+Y1
	 ibYrfV5tToFRKTAo19Cqy6rQKoqIF/pa98sKTqwxrkDqKCR3x0Djd/Pvjv5QhhJQ1kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399559;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=7DHB3wiyBrjlqmjAa5AcvSQgsWkcPOhYlmcjgXKlUiY=;
	b=DPjAdZ6N7y9gOP+OAapUYWM62MIJGkUEPkJGbI4lXt3oZiNCagIPplnLhbJ6swspGGWg
	 PIlhQ3GHIYNnTGFbkcxIVLk7yflvPGJWaIaVRC2wiFwqZUx9WQ3uRu5yqdkGeRzPydWcm
	 bjGw0pr1zHIanjbGULGxJ0e5DOjdcanz7+lM2cttHs0cqkqKRCew46/bY2te9VL7/KKX6
	 JEQC/rTCYuRakvN66tBorlLqpzsT4nc1eRevHNJljfncF0mf3VmcZLtxrfXD/eAkZFBkH
	 H2Hfn5heB9IBa/ei/OQKCI5+e5u5elQ/eg7yQkW3Kvr2R6QunjK23jWhv7wLIXunmug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=l0yQ65Mn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A0plZej1;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC4606A88B
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00CC4606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=l0yQ65Mn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A0plZej1
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B0FE1D0013C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:19:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 07:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399557;
	 x=1794485957; bh=7DHB3wiyBrjlqmjAa5AcvSQgsWkcPOhYlmcjgXKlUiY=; b=
	l0yQ65MnbhfvPIROarp1ZjVMju8F2Q+wITHxrusbWY2FJe6JpG/HbHhqd2yVd6bI
	soQCCwTKG4YE5T4lTUHMy4qJPWIp5NRQ6UuH7sRP3saJgBZJYOYj3vfw31rOx50Y
	JhzPC9zYEUBSHqZoL7Vd0zOS2m+wh+0Cl3yBNezFcDN0Kg64HzfzwnKjOfpg0Nyq
	VrbJsfD+c38WZAPfp/hwXfRZ+bXHI1RwFD58sS0pdrQgtmgHBhK00NrgOSpRGfIi
	S6yGq4MzZAt7YBTAx3rKhaiVWxTO4+ypMqLU1vz26Y9ybdg+scTWQlYn7gV3GLB9
	j0p+aX71Qt25WkwlwDlWvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399557; x=
	1794485957; bh=7DHB3wiyBrjlqmjAa5AcvSQgsWkcPOhYlmcjgXKlUiY=; b=A
	0plZej1RXjU14ayQgsk8PTUwRL0rBriGuhs2ZpTXbho438MmrEHkUzU65HvAkWm+
	LwCisGYiW5qIUJfSj/wy38jU8S9Ak3ceEJ95B9v+fpqBxt58NvIT7hnwKnueKivG
	D5wuYBw9ZuSneZ54K2dh8376C+IOywqrXVPnTKNWU6mAPCCSM2uwdtZQ3qnhymPn
	svgJah4v86NhGNbwAJ67VA9d1NqSyaoF6ka0mujID/UETct9WMr8bz95yYzKjPMt
	gbNIwoWnUegRD3VHypRzguFG50vlssts7FbfnUE94lq9gWS+mRwtVwof6wizZ7eV
	Exk3nDEJx9JTVY8I+2t7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399557; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:RakpH1AHyesUTz8IEBywypUpGdXJuKt1PQafnlX8c6hVBma
	rOddx1SJLfQKC+amOWUIyw8K5EJL4N1pk1amrCfLX1p8X+a09kOuPtf3TXbPDMAU
	PdPoE70yWGukRVFf5IVPuW4DWR1VRR0hmjcxn8k3X2CD9o8JWcvg8LIhM3T9HH46
	RKRYwkMDZO4VdF26268stDQaStHjO3NCAeO3YFaMdfDjqCV+Ls0gQZCvgObxvj/Z
	CKpxzhpOUTULyRpOJsSYbOlLkwRoY/QZUeTWGgGGA+6uYH2+usdh9hOk0XHJJ43I
	swlCIjSm/Qd3StdPwrtYrrdyMLEbxny7nBy7PmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Rjp3/BUaKN8416MIXEjhJbEdujr2JHwWA51hZLNMSPc=:TtHdwNV55IHHd0joy2WzKJAZNTCv4cktx5abQdTJ5JY=;
X-ME-Sender: <xms:RV30aqncRC-KcBb1wVmsyl5EfjAxdTgk9OJj6TUff6VP2t7olSTLqw>
    <xme:RV30ao2KjFtfUjacZGqDBY43Zn5zClQAP5JQREuMHUeav4XFYq9c6unk9fToB-Chi
    tI26_LWpFY8PJ50vpPB7WJTlWRZgEZ6UYxMTRfYtSa9K3PMVIdErIg>
X-ME-Received: <xmr:RV30atq5N63AE--LYepFzVi4fYdlQSGSN4_hbeDr-z8iXbHRn4oL2gKkfrbPgVSklHuzZQ>
X-ME-Proxy-Cause: dmFkZTGdZu0OHkc54HoZDmr9b3NxOlgCqZBctRJQZMfk7DJbDV62eAl+snpvBV+aasw4ke
    cRfjgWnkA1RYVq9pr9U7mNe0m830kjwHiJ/U8VkBTWRc5NIqRc4oIBBk68ZITpIoCt4V1W
    eDRBkqLNVjMmbSL5OGfCvBcUORdcG5SLfdoX2+/gDSV94jTo0m1XbQ73tn8rOrm7KmM0rc
    TsEuZXDfh7oxQ/WCwUkvZP7ZjU4y88oBSElT5zCcsOtBcJS9mUffnKoLP8Nmx8LFPqHeJY
    pfrCgnvKab/zHSSp6LWmVkkpP7OAeNDrtQ+e2lwSz18D/3K0+rAlnUhVKd8ktSXLPLzZOI
    Mml3ncFY1jFF2hDCF/50TMS3DelxtFfpp+VulUmU9N8P8uyUUlzfU02CXmSyltl+CvyVdA
    iTYWMM6L1gIIpPJvjmf/zIq8YgK7ys8RcWHnviFcE5lk8GHV04iaODyzqO49O7c3xL5V7u
    EMo9Eegg8PW0pAAYvJT1fc8Mmu2vlC7eX2giON8mHf8AG8nfXoP3QY82xSwUvn9GThDOIp
    jELiqLF7kJL3XfCuIVrVo2YcdWf7meEiwkFDlnRyJVtmNfScxK5ht6WbK3IYxg+sG22Qjq
    /U4IE3+d8fX7MnjVo9ZGqhINTX77+fO2K1AgvP/qgyjYip43qooVW5q92zOQ
X-ME-Proxy: <xmx:RV30atcLzAuLB54DiTYpFdIypK4p7cZgRDI3FUcT1AhyX03r84RwaQ>
    <xmx:RV30akpq-WGTpxuStk4Og9B-Ex6MIuAK3dzOQUHzAARalsTf3rSKsA>
    <xmx:RV30amELf0P_UOFuVT9EJhdPW8dy2fVhkvp8mKSzQWNv3pxbGekUgg>
    <xmx:RV30assRqAR0E-6JLd0DRGVZD5aUDB8d_pkPhy4d6LtPb5951jELzg>
    <xmx:RV30amHM-PCNuUerm0Uo2okeUCY_UCuqQFn-F-JIImHRgo2XXqUO6n_1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:19:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 306b9161 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:19:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:46 +0100
Subject: [PATCH v4 10/12] builtin/rerere: turn "gc" into a proper
 subcommand
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-pks-rerere-subcommands-v4-10-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

As explained in a preceding commit, a subsequent commit will introduce
proper subcommands as supported by our parse-options subsystem. Refactor
the "gc" subcommand to use parse-options as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c  | 43 ++++++++++++++++++++++++++++++-------------
 t/t4200-rerere.sh |  5 -----
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 40bae5cb9cc..3162b074ec6 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -128,6 +128,30 @@ static int cmd_rerere_forget(int argc,
 	return ret;
 }
 
+static int cmd_rerere_gc(int argc,
+			 const char **argv,
+			 const char *prefix,
+			 struct repository *repo)
+{
+	int skip_locked = 0;
+	struct option options[] = {
+		OPT_HIDDEN_BOOL(0, "skip-locked", &skip_locked,
+				N_("skip gc while another process holds the lock")),
+		OPT_END(),
+	};
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	rerere_gc(repo, &merge_rr,
+		  skip_locked ? RERERE_NOWAIT : 0);
+
+	string_list_clear(&merge_rr, 1);
+	return 0;
+}
+
 static int cmd_rerere_remaining(int argc,
 				const char **argv,
 				const char *prefix,
@@ -187,21 +211,16 @@ int cmd_rerere(int argc,
 	       const char *prefix,
 	       struct repository *repo)
 {
-	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int autoupdate = -1, skip_locked = 0, flags = 0;
+	int autoupdate = -1, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
 			N_("register clean resolutions in index"), 1),
-		OPT_HIDDEN_BOOL(0, "skip-locked", &skip_locked,
-			N_("skip gc while another process holds the lock")),
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
-
-	if (skip_locked && (argc < 1 || strcmp(argv[0], "gc")))
-		die(_("the option '%s' requires '%s'"), "--skip-locked", "gc");
+	argc = parse_options(argc, argv, prefix, options, rerere_usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	repo_config(repo, git_xmerge_config, NULL);
 
@@ -215,11 +234,10 @@ int cmd_rerere(int argc,
 
 	if (!strcmp(argv[0], "forget"))
 		return cmd_rerere_forget(argc, argv, prefix, repo);
-	else if (!strcmp(argv[0], "clear")) {
+	else if (!strcmp(argv[0], "clear"))
 		return cmd_rerere_clear(argc, argv, prefix, repo);
-	} else if (!strcmp(argv[0], "gc"))
-		rerere_gc(repo, &merge_rr,
-			  skip_locked ? RERERE_NOWAIT : 0);
+	else if (!strcmp(argv[0], "gc"))
+		return cmd_rerere_gc(argc, argv, prefix, repo);
 	else if (!strcmp(argv[0], "status"))
 		return cmd_rerere_status(argc, argv, prefix, repo);
 	else if (!strcmp(argv[0], "remaining"))
@@ -229,6 +247,5 @@ int cmd_rerere(int argc,
 	else
 		usage_with_options(rerere_usage, options);
 
-	string_list_clear(&merge_rr, 1);
 	return 0;
 }
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index ab412ecc6e8..0d4cbf5114a 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -263,11 +263,6 @@ test_expect_success 'gc --skip-locked prunes while MERGE_RR is not locked' '
 	test_path_is_missing $rr2/preimage
 '
 
-test_expect_success '--skip-locked is only accepted by gc' '
-	test_must_fail git rerere --skip-locked clear 2>err &&
-	test_grep "option .--skip-locked. requires .gc." err
-'
-
 test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
 	git reset --hard &&
 	rm -rf $rr &&

-- 
2.56.0.611.g1030f0b940.dirty

