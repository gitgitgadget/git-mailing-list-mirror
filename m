Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726723E639D
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691377; cv=none; b=YuxQfs6LzMbLYsyZc+zF6ziZAqunkGH3esshqJPJtrnH0P9tub6xywRQZ3N3j9Z56rSH5UVPdsss3y4lDIK8Ki+Zd15l4e84x/We6cXQZ2E33KOGk9iVUfdPIhQguD8X5ynayAy8aDQn/5nNzPWFItqJMddwliFTI5p+bVqwQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691377; c=relaxed/simple;
	bh=2evZpYNQBlRQOqh1Gqpg17+0TKDrUWilStkPBTt82j0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5IQSXE/0APpnEO70+5/gSO4ixYAa+PpspZqSyhFEyNsM9riYnJbZKuJnc8eBibD+x8AQBh9dRICmKCYaNyCl0GPToD3avDZdHmdK1wX+CL6Fd6I3pVdP0PZ3gUWmve+nQEhfXx4m1l69Jsy2rTYJvR/SaWlW1RcYx9O2z/LIOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b9OO9o8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5XN7m53; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b9OO9o8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5XN7m53"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B75DA7A018D;
	Wed, 17 Jun 2026 06:16:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 06:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781691375;
	 x=1781777775; bh=GYdRAyXYWci6N1HNeu3Z8fGKwFL/fKevNLaj+jtrsLo=; b=
	b9OO9o8qg5TWLARvA+dFitPNSR+p/1GsNFFFrJng9bWSe6jMX5C2bxBatpfW324M
	MuLSHX3MzZI25X23S7nin9aDkdwrv9AB7fF7e3Dh3eApMjM1tVIJpniMmHwhmHz7
	4xkuhaec5uLrfJeXhcMQVt2eZ6zdFGWFQfeYs/etgR2pSMWKcuEy40Swk4ZoTTT0
	HVLAg/HsqCoaHzHBQhUgF1BRbSMav1rlfNLE1uig5I/1cxHIi3t8I2Wqdtn14MBs
	S3bwduZOE++5tCvXDEBa0pCtYCFUEqQTKw9B72OuWieq69bJTYu1T6SzJnvqFRKi
	r+wrxh9os7568S+jezmWzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781691375; x=
	1781777775; bh=GYdRAyXYWci6N1HNeu3Z8fGKwFL/fKevNLaj+jtrsLo=; b=d
	5XN7m5345Ibfs8g1yzjS6xLU6Uk1C/y989V/qQDIJOS3OX6/qquOpjZRINqyC1AE
	qzCwD7KjH9DIQS3CbmKxVOvbjJX1txp2T69HR71wNuVXQVxnLf+cxaK+Y9txM+GX
	fHyZFrJWj/rIJp/6ohXZSLFfQC+1JFiXXzK9iew0Fj817InunvPdiurMRa0+DQsc
	GBbSdnzgifn9O82CiQXwGvXWnlg7GXWWKcjD10q27Mrx3Wkbh3rgJppuNQFf75Qj
	CEKlsVkq6m5lT5YDTT+w/UVSppO0pJV1nsXKw6AKMP+I4G/C7Pm7zZgeUQ5Gbjoe
	lJqG2dh8ac2BL6CgCjg8w==
X-ME-Sender: <xms:73MyajY4413F0zXO_1rH2dyqi2ah_mnUqx8HaursDBvzM49zrQABWg>
    <xme:73MyaoYSm5y5WUzSWgEXgaUVILMzPO6cJ10nF_Kxr0DZOFsFhhCBekeGbTNqZTEU1
    Gkd8NxFQJZk1YRX6Y9LHEnmfED8Vlm-1IoGIuSi12OtK-QXZ7WA>
X-ME-Received: <xmr:73Myajk9fHyc2eZusGq3WxchIYdxLQusTWrJOK69EmZScqPQqp-XXSHGgv2KRDClPwTQRSpddHAysrvnMUI2p8VfIb3J17KApbQUoW8>
X-ME-Proxy-Cause: dmFkZTGYzi+m86FQk2DQwqFzBehG1fRSk41ZWKJRb9rgteJj65ae+gY5yjRePyX8Xx6lqy
    WpIssYxpPvNFGS3oYXPOIv3d6UcfFZlUbFy4gJEq0rkI/Y1pl32pqFGZxDJfmrrtM4ScQE
    eknsL03/Gqod8O5hg9M2XnifZNYisyunvBY3S7HvVOPD8lVP6Mavd5F1OhYT0ojCmvHoEr
    qqrGQrbhp01iLfArgiR5pC7cPTTr8BFs41lHlbnpYx9OWdnXsT6R/bKUmJ9DLfg/DKavhJ
    clDDrHfGMiHAjiRZWRQ1M8+FwzQq3C6Z0UiFOm74M/2oWCIk0yJOtJg/7bzSyHlSV2AEid
    jX0S+FcX0DJJvAWqFViLaXVbQ6MeZTGwu2E5gRQejwmhzqJ/3J7WuTo7VqgPcB9a6gilMC
    zT6VMjFNoO8lWME4giK7jI+RbySxyddUVoBXKk/8hRW55SiHiqvmsS7SKQvbh6hl1rxD1e
    o8QeEhI0BQmoV3vPCJQDrrdvccFYEqzJYvGWitOIxD8GyXWT0gQH90tPh3p4Ia36xMvlWP
    jm4dBcfgQlEW/6Tj6xR465asteLSGLMiPZ4ZZVwihxLoN2ESBFcWCVn5xpj39DJnWhZtmv
    FYvktM8sUT0Seqy3BTnrNi/V3mJ9tQEBAVzy+8ttRYgcaE8UdLPk1BN/9l7Q
X-ME-Proxy: <xmx:73MyakyQTaaJavTkCZTmYN1LxK1pik_yjUFSWB6qAaKr1ioekYR9iw>
    <xmx:73MyahM2gVYVqn3dCTF3IEfGDn3NuDOkIMcY_QIP6R00pf37Yahu2Q>
    <xmx:73MyaoQDtdwjNi0NSRbu-IwFAnOylqaimXItead1tW9uOvmj2CGxGw>
    <xmx:73MyavbJfytBshq8gb-_wHXrkCQt5nKXW_NiSuci8wAPQ8DZen9hFQ>
    <xmx:73MyamyZNlyJRPYNTW2KBBqhj5OIeBGLq7MbGk37NdYw7X1ESoD7q6Tp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 06:16:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 38dbd9b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 10:16:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 12:15:58 +0200
Subject: [PATCH v2 1/5] builtin/refs: drop `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-refs-writing-subcommands-v2-1-07f3d18336f9@pks.im>
References: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
In-Reply-To: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

We still have a couple of uses of `the_repository` in "builtin/refs.c".
All of those are trivial to convert though as the command always
requires a repository to exist.

Convert them to use the passed-in repository and drop
`USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/refs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index e3125bc61b..f0faabf45a 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
@@ -23,7 +22,7 @@
 	N_("git refs optimize " PACK_REFS_OPTS)
 
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
-			    struct repository *repo UNUSED)
+			    struct repository *repo)
 {
 	const char * const migrate_usage[] = {
 		REFS_MIGRATE_USAGE,
@@ -59,13 +58,13 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 		goto out;
 	}
 
-	if (the_repository->ref_storage_format == format) {
+	if (repo->ref_storage_format == format) {
 		err = error(_("repository already uses '%s' format"),
 			    ref_storage_format_to_name(format));
 		goto out;
 	}
 
-	if (repo_migrate_ref_storage_format(the_repository, format, flags, &errbuf) < 0) {
+	if (repo_migrate_ref_storage_format(repo, format, flags, &errbuf) < 0) {
 		err = error("%s", errbuf.buf);
 		goto out;
 	}
@@ -99,8 +98,8 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	if (argc)
 		usage(_("'git refs verify' takes no arguments"));
 
-	repo_config(the_repository, git_fsck_config, &fsck_refs_options);
-	prepare_repo_settings(the_repository);
+	repo_config(repo, git_fsck_config, &fsck_refs_options);
+	prepare_repo_settings(repo);
 
 	worktrees = get_worktrees_without_reading_head();
 	for (size_t i = 0; worktrees[i]; i++)
@@ -124,7 +123,7 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
 }
 
 static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
-			   struct repository *repo UNUSED)
+			   struct repository *repo)
 {
 	struct strbuf unused_referent = STRBUF_INIT;
 	struct object_id unused_oid;
@@ -145,7 +144,7 @@ static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
 		die(_("'git refs exists' requires a reference"));
 
 	ref = *argv++;
-	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
+	if (refs_read_raw_ref(get_main_ref_store(repo), ref,
 			      &unused_oid, &unused_referent, &unused_type,
 			      &failure_errno)) {
 		if (failure_errno == ENOENT || failure_errno == EISDIR) {

-- 
2.55.0.rc0.786.g65d90a0328.dirty

