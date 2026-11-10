Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296215;
	b=efskAe+WUvVoIGw3cQG6RLcUfQEb3DziW1ow26MYHl3WB5HVXdRUHPP906WdaO+/8wPV
	 VFzeZdFad6ivvGpHxgIoP7JyT15r3UL+/EAEDmXPZEE0l5XN5EuYGtt9zBLub44/+ZVbx
	 dTV65tMIDRWT7+IeT9ZNlCf5wNrvAQTDUs6p4wZH2DMIhgoj1EbON/+048O6D3URihgSJ
	 HN2p9xnvZYj4+44zcdeTubeZbnp0/yaMMJiFhH7uzdYEj0IXKKSojNPwKIXzH8VQIkZUQ
	 ID6u8pGaumWj85n6sUaKXw7YaZMRUEsVkxJ0oVhvGhTwzgiEWUT4xac1U/JaBMf2JWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=j9kiQFtR7ZzXSc2zfV3tHThfWht6wj4IYbR+PtkNKgg=;
	b=RE00iLEJEJnlSMKk/34X5hiPMdiymX//4L1VygVv5OjD7oJzV4oVj5nmA43/jRyWj072
	 ECEGwQ2TZWEKps8v9eE9DlwmJH4R6/r7WzYTbIMOGK4mXB5Ed937TH/BCtGbUqUfkb0K0
	 v5GOxhvPE+El0qjpmYw3oCdRwfc9nKa69TIN5B9AJWFVZzU+hxavIA7EpjIRIl7tgmmUM
	 rQA0FJexXKIVsS3+aO1dUDQ+ihdIObYOiAT59U2DPKu1Yh56scXz3Pif+/8N0fhAjnwv+
	 roe3DlTZVhbh1L0Ti4B296PYji5vUahb3IyLB6Sjb+bjbsnkgHb1rVRQX7oGg5ypOPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8blbjjS;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE060A5BDD
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AAE060A5BDD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8blbjjS
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so1130391fac.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296214; x=1794901014; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j9kiQFtR7ZzXSc2zfV3tHThfWht6wj4IYbR+PtkNKgg=;
        b=p8blbjjSACLQQFM6HxYPMBs5rsyzjDJRcOFpTP2GlZ67ueBuNwsgP4Sixbq2ZT/B9U
         V4/DKfeSAxaFgEhvCDjD2ybf7DKh4vrLat9ZQ4sNlt6d7iGz95+d9DRu4vM8gC9L/YZs
         os+h5FB4cJE4eQ/M+Vb8YkdIuWSfLWWX1/ttOOkfV3jJOmZOfcNCV0nPbL492tf8T/FV
         WZL5RDcFuLhdeWRXaxJaqvXwGH1HVBUGqb6rDRsiPiKYGiei0D6qE5AZsJqLVxXubRZG
         cDiz+pqqpdzIYSzTDSaPiHo2OHAxqTXSsCfYAo6w6pWcZZqtT9pvw30NEJTsgArkmE+A
         SSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296214; x=1794901014;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9kiQFtR7ZzXSc2zfV3tHThfWht6wj4IYbR+PtkNKgg=;
        b=AnYhmtnBGhuT5G3LkG1VtmOI8rVRyhs4sF+7or4g3MmU1EyzeHkEH1Cz/CUOLla1PR
         KnCoiHMRCq7bn8yMQVowpPbHDSwwtMdh96L12JkdRT+vE7RAKVZEJNboPw+K14I5Ty0o
         qZ2Ha9l6mIrt9UbvEStZSdREYMQr70mIS/AjB/r6CIyLSO3b4omuJ7lQHbqABQFEpBq0
         uwnmtbPVSkuUuF8ffbSKK0ozyRBxRqU6wrxWEoQSG+WKfQeXqmTQ8X8GgA9mFa2G/UWE
         j8Ftug+71vikdIYu4m38Z04G1G1w2Ji2MpcB6b+bD1sAEucsvlLnYYA4ArUomfv4vveU
         +xFg==
X-Gm-Message-State: APuU4Z+F8XxKoWJ8OfA0G9fObQo4LSJIXLLkpyVIz6mcL6ivjeK0/nvB
	vFSCRaeWpkZ1rFJhqtQ5wJXnE/CINenMW1NKlJicdzX7eqevm9dF3kR77bfNzBb1
X-Gm-Gg: AYBFou13MNd2XYuxWJYkdeePZai1bBrQpvXOx63o8Sr0rQAOHNOSygVMPUby7IjZ5gD
	enrZzuoLPBJ1iH4J67SwDVqdpCzepRhHe3V6wZqlyP0xb7r6x7YO9IRNWxuAdx/NRzE6DmoXhoy
	qV7K9pwkeftedXD5uExOHQyk+AjxzI0gRkGwGKUP1yz7s+61KzLLDPRdnv8bdM46mhjy8RDY9iN
	NxrCZP/Dvv3dXJF50AniqXFpE+w4WC/ste7R8oNg9+nHITmkf4g98U10oHWK6hv0gnFHV9779q3
	vkPIxD5POFcJs9nOYOTWSB0hXk/KL/Uw6FCtqs9lOhvdDPEVjqyQ40AhGCLAatxeYXs9K6bzXyB
	L5UPYMYJRxN4RzH3oTxokWxzljtoPieconaJ219yBg61XCYz06QyC7FSKvLp7+Vn0cwA+q3gL7T
	j9u9DhRNogFGvTCYGuZ91NKBPHKMWIwLBts1UuND9LMYg7ibqC3/4l7nsAXU2Tgj17Flmm4cHTv
	neIVcla7accqKaJ0ESEr6soj4jkyLDfI/1w0Xth5WEOgocXnd2HibEXd3p4HLp+BwrrWZVCLk9+
	NXWSpAUfRS2gIETCtAKptHvDAqLLImPsNT8=
X-Received: by 2002:a05:6870:b30f:b0:46a:d10b:bcc2 with SMTP id 586e51a60fabf-4ae22594f41mr1072965fac.9.1794296214112;
        Mon, 09 Nov 2026 23:36:54 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fc0d08sm1071377fac.8.2026.11.09.23.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:36:52 -0800 (PST)
Message-Id: <9170c4162f1902d99f480686f99e09fb82001879.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:32 +0000
Subject: [PATCH v2 02/15] odb: handle NULL values for core.alternateRefs*
 config
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

A core.alternateRefsCommand or core.alternateRefsPrefixes without a
value makes "git fetch", "git receive-pack" and
"git rev-list --alternate-refs" segfault in a repository that borrows
objects from an alternate: fill_alternate_refs_command() passes the
NULL value to strvec_push() or strvec_split().

Both settings take a string. Read them with
repo_config_get_string_tmp(), which rejects a missing value with
config_error_nonbool(), as the previous commit does for
rebase.missingCommitsCheck.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 odb.c                     | 4 ++--
 t/t5618-alternate-refs.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/odb.c b/odb.c
index 865c404910..ea086be8b3 100644
--- a/odb.c
+++ b/odb.c
@@ -161,7 +161,7 @@ static void fill_alternate_refs_command(struct repository *repo,
 {
 	const char *value;
 
-	if (!repo_config_get_value(repo, "core.alternateRefsCommand", &value)) {
+	if (!repo_config_get_string_tmp(repo, "core.alternateRefsCommand", &value)) {
 		cmd->use_shell = 1;
 
 		strvec_push(&cmd->args, value);
@@ -173,7 +173,7 @@ static void fill_alternate_refs_command(struct repository *repo,
 		strvec_push(&cmd->args, "for-each-ref");
 		strvec_push(&cmd->args, "--format=%(objectname)");
 
-		if (!repo_config_get_value(repo, "core.alternateRefsPrefixes", &value)) {
+		if (!repo_config_get_string_tmp(repo, "core.alternateRefsPrefixes", &value)) {
 			strvec_push(&cmd->args, "--");
 			strvec_split(&cmd->args, value);
 		}
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 68139a1b3e..422da6dde7 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -83,4 +83,13 @@ test_expect_success 'refs of a shallow alternate are ignored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'alternateRefsCommand and alternateRefsPrefixes need a value' '
+	test_must_fail git -c core.alternateRefsCommand \
+		rev-list --alternate-refs 2>err &&
+	test_grep "missing value for .core.alternateRefsCommand." err &&
+	test_must_fail git -c core.alternateRefsPrefixes \
+		rev-list --alternate-refs 2>err &&
+	test_grep "missing value for .core.alternateRefsPrefixes." err
+'
+
 test_done
-- 
gitgitgadget

