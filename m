Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67902204F65
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508727; cv=none; b=mdpCYMdyUGCbss95zqGCOruHsVuEY+nIrXh9qbU3HFwdesTkQSk9NNrek85JOK3v+5mUCbZHx4TOApGTClT5NlH9XVGSeO4vGA9vByDaKoorqTq/UZffKbsV1PemhIRKXTjExMUH0z5jVsyvYU9e/mlaED/5YNW0YS7jgYjKWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508727; c=relaxed/simple;
	bh=ZN7OMJlvSyTzMrEamV9HtvuqN/8+XBdEBZLmcM4Ft9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUTaGSWQve7vE61twiHJ3jXd0KQQHCoc+84DnmxPwE/k02WASofxtYZzIuHe0cKrGgu3PmCmtDs4GRRYbwUmsrLZH9vUcYAET6W5BPcIsfxxfBXOGhfu/5CxSznJYWiXiMyvruDYi3YWymo5b8V83Fd/BcMH/kSWc4/EmXnpaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LCA9p8ZN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lfKLLWOp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LCA9p8ZN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfKLLWOp"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A75D1380C90;
	Fri, 10 Jan 2025 06:32:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 10 Jan 2025 06:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508724;
	 x=1736595124; bh=MRlUeqXI/wsHvganAP+iFz/f0m7NV3cNdqeL9Cb+cuA=; b=
	LCA9p8ZN5I2I++MDPys8VRNuKvZR+xq+YpYEj4fy1gYM/3yfiXHNfF8EF4YosCtd
	Vwp0kvGKzH8DSuMvDvphTQcEc4nA7d5UN+n5sTr3LhYZi3iDNgO3EYLxSJNMX1A+
	xOx56iDzFI3VqelGRHwP5zRtVVh4kxV8z7qDgxcuanYdZzvNH9mOKSQC0ZBHXzf1
	ELVq1+LzHLZRe7ZIGVNsU4z4MwvLoMdnqREhfjRw3tfXfvB3StaM4tcL3XLAURhL
	aLBKem05CFczGNo52eiLYRx9OMm+zDI0AR75IvZyPZojrcZuZ0JMWvhCczhQNTlM
	j/6df7IfEW7y/U0iOXLXVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508724; x=
	1736595124; bh=MRlUeqXI/wsHvganAP+iFz/f0m7NV3cNdqeL9Cb+cuA=; b=l
	fKLLWOpwZZWa6LTTDgDFev3XzSdQosqOy45Kqjr7pjgXZPZDQ2tCAazMbpqw7vQ4
	HxT6oTZfBkyDUIf+2A2FGJvIORUS9FS5/Y/rDD1lgQPlPLk9vxoMEfIeaAwxIlCK
	b2ZdPY7T5m36FsF5dpxdhOLNPX/y0r0G4Y+xnOYlmZta2gntWQNdPMKdZNMKUdvM
	Amal0vSrepjoggAnbyM4GC5s60Ryd59eCuDXzYXyN3T75Iym8+1vrrtLPCCyI6Xi
	NYhw4tnBEa75ny7od628kxmQl9BgkVDnJNBXuj1UJSC20cHbTmYUL+gkrapASeC4
	DlFNx2kreNzWzghrO1Zow==
X-ME-Sender: <xms:MwWBZ5SkfCf-4rd1wo9Q1QbJ9nQFu6GSRaFwRge4v0_Vw4KeEgK9Wg>
    <xme:MwWBZywnVSTZPTsPCML4YS8A6X4b3xVvfGMxnaLORKMgtF2ybzw5jodb9TQDb6C7K
    __P8I-Dp98WtpnUjQ>
X-ME-Received: <xmr:MwWBZ-2NYzVODLgDkqcvsmeQ7IHHYEAhqdIA34yPE4oKD-7mRQcZOaR0OcbsJWZhg_wTbr7ePgv_uWEgaoevU5V-ZmKCG_bcrCE04GEh1vIGpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MwWBZxDIRc7lNJi7nEChL9iZeGXsvNwM13dRsj2QIu6wRrMscQy5lA>
    <xmx:MwWBZyhTeBCuErmxMqP8LnYy96Lp1EygJ9FCFDTTmdMAd6GiFdSMIg>
    <xmx:MwWBZ1r0t_dYmkE0uJFzswEDGwJCtHXB-lCGqtkFq96B7yyrzDuwhg>
    <xmx:MwWBZ9h3cYCmM_chiyCVeX41Biz6yXDLH0shh6O_vHAtJrcnoQtgIg>
    <xmx:NAWBZ6cpOdfKs8jefm9nVLZosgnga1a4CH9MC_OvuS_4YXIE095gPt5F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b998b8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:31:58 +0100
Subject: [PATCH v4 02/10] t7422: fix flaky test caused by buffered stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-2-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

One test in t7422 asserts that `git submodule status --recursive`
properly handles SIGPIPE. This test is flaky though and may sometimes
not see a SIGPIPE at all:

    expecting success of 7422.18 'git submodule status --recursive propagates SIGPIPE':
            { git submodule status --recursive 2>err; echo $?>status; } |
                    grep -q X/S &&
            test_must_be_empty err &&
            test_match_signal 13 "$(cat status)"
    ++ git submodule status --recursive
    ++ grep -q X/S
    ++ echo 0
    ++ test_must_be_empty err
    ++ test 1 -ne 1
    ++ test_path_is_file err
    ++ test 1 -ne 1
    ++ test -f err
    ++ test -s err
    +++ cat status
    ++ test_match_signal 13 0
    ++ test 0 = 141
    ++ test 0 = 269
    ++ return 1
    error: last command exited with $?=1
    not ok 18 - git submodule status --recursive propagates SIGPIPE

The issue is caused by a race between git-submodule(1) and grep(1):

  1. git-submodule(1) (or its child process) writes the first X/S line
     we're trying to match.

  2. grep(1) matches the line.

  3a. grep(1) exits, closing the pipe.

  3b. git-submodule(1) (or its child process) writes the rest of its
  lines.

Steps 3a and 3b happen at the same time without any guarantees. If 3a
happens first, we get SIGPIPE. Otherwise, we don't and the test fails.

Fix the issue by generating a couple thousand nested submodules and
matching on the first nested submodule. This ensures that the recursive
git-submodule(1) process completely fills its stdout buffer, which makes
subsequent writes block until the downstream consumer of the pipe either
reads more or closes it.

To verify that this works as expected one can apply the following patch
to the preimage of this commit, which used to reliably trigger the race:

    diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
    index 3c5177cc30..df6001f8a0 100755
    --- a/t/t7422-submodule-output.sh
    +++ b/t/t7422-submodule-output.sh
    @@ -202,7 +202,7 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
     		cd repo &&
     		GIT_ALLOW_PROTOCOL=file git submodule add "$(pwd)"/../submodule &&
     		{ git submodule status --recursive 2>err; echo $?>status; } |
    -			grep -q recursive-submodule-path-1 &&
    +			{ sleep 1 && grep -q recursive-submodule-path-1 && sleep 1; } &&
     		test_must_be_empty err &&
     		test_match_signal 13 "$(cat status)"
     	)

With the pipe-stuffing workaround the test runs successfully.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7422-submodule-output.sh | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index f21e9203678b94701281d5339ae8bfe53d5de0ed..023a5cbdc44bac2389fca45cf7017750627c4ce9 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -167,10 +167,45 @@ do
 done
 
 test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
-	{ git submodule status --recursive 2>err; echo $?>status; } |
-		grep -q X/S &&
-	test_must_be_empty err &&
-	test_match_signal 13 "$(cat status)"
+	# The test setup is somewhat involved because triggering a SIGPIPE is
+	# racy with buffered pipes. To avoid the raciness we thus need to make
+	# sure that the subprocess in question fills the buffers completely,
+	# which requires a couple thousand submodules in total.
+	test_when_finished "rm -rf submodule repo" &&
+	git init submodule &&
+	(
+		cd submodule &&
+		test_commit initial &&
+
+		COMMIT=$(git rev-parse HEAD) &&
+		for i in $(test_seq 2000)
+		do
+			printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
+			return 1
+		done >gitmodules &&
+		BLOB=$(git hash-object -w --stdin <gitmodules) &&
+
+		printf "100644 blob $BLOB\t.gitmodules\n" >tree &&
+		for i in $(test_seq 2000)
+		do
+			printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" "$i" ||
+			return 1
+		done >>tree &&
+		TREE=$(git mktree <tree) &&
+
+		COMMIT=$(git commit-tree "$TREE") &&
+		git reset --hard "$COMMIT"
+	) &&
+
+	git init repo &&
+	(
+		cd repo &&
+		GIT_ALLOW_PROTOCOL=file git submodule add "$(pwd)"/../submodule &&
+		{ git submodule status --recursive 2>err; echo $?>status; } |
+			grep -q recursive-submodule-path-1 &&
+		test_must_be_empty err &&
+		test_match_signal 13 "$(cat status)"
+	)
 '
 
 test_done

-- 
2.48.0.rc2.279.g1de40edade.dirty

