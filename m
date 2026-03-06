Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956554654
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775197; cv=none; b=UoNO7CphrIEzEm4CZGLwiG9NymyakXngIzmBn+7Jib0hQ8LIhqBL+nw4aZIfnFIQLt4K/H1RvyTjUh6eZS8IghsGdwisvwe8UdrdTWqeGTzkTbTsm/n0RbDzoF+ICohgzzR5E/fb29akRd1XYw18HpHG22adGllbn1x3YKq9oE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775197; c=relaxed/simple;
	bh=sQ97JZL6Vbv2Ijt6OcN3d++wNnD7E2MlijmCEqrmMRg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lHZZSBNCDJo/EQ5/ycjox5Tb8tcnZ+kBQAqZPu4jpvYVXGOPhxKuMaXOmCIlkD4jVgPJDExB37GvsM9+03Ta/o/SE6blhCdU3efMCYpu7hdjDNaxEK9JkgeVLQ36LzApw0fKW7hhO+aBCDOegPEdfhODKVM4OqVRfiQkrAXqZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=CPhC86k5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s7FfIOzJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="CPhC86k5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s7FfIOzJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E31531400081;
	Fri,  6 Mar 2026 00:33:15 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 00:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772775195; x=1772861595; bh=TkP+OLMuYe
	u+sS7hdLhYB56ksw4QZYed2ohD0DF67sg=; b=CPhC86k5MjgknRkl3hHZ/U8gMP
	krrfFAwLSsGaNgznUSI3Aqg4YDvvjAStSIRmcGptC4HOT3WWnAZb/nyUK2MBxlou
	MFhGme7Ce19KKbckY+uGREijIu9hJTbm2PkvS0Y/AVf0fdfraGNi0YiOTZSQUJ3v
	wTTL2n+JzG/ignDTM1sSWiifnU35qnnlMjh0Fwq+YvKT22g1Ia1c1PkPZ8gcKisW
	sulzcpdYkweLVVqu9o75utIZyzVny48cYGuZZZOEHlG6oEptJ0Eu/aYOqojUV42u
	LXP5Mp9TYr3ed99rPEoH3tGTZk5Jbjef2I3APj9+wCIkJ8hVtJpHaJaEGrJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772775195; x=
	1772861595; bh=TkP+OLMuYeu+sS7hdLhYB56ksw4QZYed2ohD0DF67sg=; b=s
	7FfIOzJ0wFg2HrIUYG/CBZQAUQyXo70pzcFYRLRDlQ8x2um7qU95mgLm2S8LLM8q
	x5asKKRkH1aZzS9x0YKhrE3/zajri4rgBnGntuNF4FRt5rX9e4d3+lxq+vGCcpNL
	3IURTAHJJ5VLitBtXJpghNNYpobr1P2E5KpE3me+cD7zPDdrwL5VI5iSKYB1DQ/8
	KzjQIrAK6lMwRvcRMEVwwwKW56z/USsjuAwRW5HSzj7LIVrL7PJcRB4SE47s2Wxy
	W4Dsf4WVlwpM7C6vZLsiaOmf0UpzOwk1S3pS7fVhU9nNBn1OP/9VW7qP0JfHee7N
	XCqQCTzQO+QdE41S1jQlg==
X-ME-Sender: <xms:G2eqaUwIThtP0GIYQu7Jbk9sCpqeQ1TruB2ZBe3CdiMTQv4eyX_DOQ>
    <xme:G2eqaTGkTCVwhhHgFznRzR5_twyr5o_sab4nPCwg0zRqkyEfitztDa81nm9vZYdbv
    Wtfta-kXvt5zJ-JCRz1HIQW4J4SYQGHg4BcE0PMkyX3xkYETRW_SZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdghohhlfhhgrghnghcuhfgruhhsthdfuceotghonhhtrhhi
    sgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomheqnecuggftrfgrthhtvghrnh
    epleejkedujeeuffetgeevkefgfeegvedtffejhefghfegieettedttdfgtdefvdefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghonhhtrh
    hisgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G2eqaXcam8iq0Wh92C7FZJDiIpTeo-lLzaLsfSx9RKo-3KMQq1x8OQ>
    <xmx:G2eqabJ3X4P8owfkMWDbPrDbHVKcXlnfi6zEvKM7-hd792e1BJ1fJA>
    <xmx:G2eqaYFgDlOEt0Z6cAUVnmI8kjVae5KFzeZEC_Y_pLCsz1j5SHNO2Q>
    <xmx:G2eqaVroVrqIpYJLaPVtqZmVP6sjEsOtf8cV_vbtISiE6smRSgGfIw>
    <xmx:G2eqaTg20PpXTkhpsUtitS6t5cq1QPbLmq6Vq2-kTiCTYtQbMHL3y-e8>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA7792CE0072; Fri,  6 Mar 2026 00:33:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX21AeLsmHX3
Date: Thu, 05 Mar 2026 21:32:54 -0800
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <5d9f0b07-c81f-42be-9d91-9deeb209ae1e@app.fastmail.com>
In-Reply-To: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
Subject: [PATCH 4/4] scalar: remove obsolete gui.GCWarning setting
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The git-gui tool now uses automatic maintenance and no longer uses this
config to prompt the user for manual garbage collection, so scalar no
longer needs to maintain this value.

The tests appear to have selected this setting as a sentinel, so change
them to use the similar gc.auto setting instead.

Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
---
I assume this one needs to be CC'ed to the scalar maintainers, but I'll
do that once the rest of the series settles.

 Documentation/scalar.adoc |  6 ------
 scalar.c                  |  1 -
 t/t9210-scalar.sh         | 20 ++++++++++----------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index 5252fb134a..4dbe976b65 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -285,12 +285,6 @@ gc.auto=0::
 	This disables automatic garbage collection, since Scalar uses background
 	maintenance to keep the repository data in good shape.
 
-gui.GCWarning=false::
-	Since Scalar disables garbage collection by setting `gc.auto=0`, the
-	`git-gui` tool may start to warn about this setting. Disable this
-	warning as Scalar's background maintenance configuration makes the
-	warning irrelevant.
-
 index.skipHash=true::
 	Disable computing the hash of the index contents as it is being written.
 	This assists with performance, especially for large index files.
diff --git a/scalar.c b/scalar.c
index 4efb6ac36d..0a6359ec6d 100644
--- a/scalar.c
+++ b/scalar.c
@@ -150,7 +150,6 @@ static int set_recommended_config(int reconfigure)
 		{ "fetch.unpackLimit", "1" },
 		{ "fetch.writeCommitGraph", "false" },
 		{ "gc.auto", "0" },
-		{ "gui.GCWarning", "false" },
 		{ "index.skipHash", "true", 1 /* Fix previous setting. */ },
 		{ "index.threads", "true"},
 		{ "index.version", "4" },
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 009437a5f3..55f73939bb 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -202,15 +202,15 @@ test_expect_success 'scalar clone --no-... opts' '
 test_expect_success 'scalar reconfigure' '
 	git init one/src &&
 	scalar register one &&
-	git -C one/src config unset gui.gcwarning &&
+	git -C one/src config unset gc.auto &&
 	scalar reconfigure one &&
-	test false = "$(git -C one/src config gui.gcwarning)" &&
-	git -C one/src config unset gui.gcwarning &&
+	test 0 = "$(git -C one/src config gc.auto)" &&
+	git -C one/src config unset gc.auto &&
 	rm one/src/cron.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/reconfigure" scalar reconfigure -a &&
 	test_path_is_file one/src/cron.txt &&
-	test false = "$(git -C one/src config gui.gcwarning)" &&
-	test_grep "GCWarning = false # set by scalar" one/src/.git/config &&
+	test 0 = "$(git -C one/src config gc.auto)" &&
+	test_grep "auto = 0 # set by scalar" one/src/.git/config &&
 	test_grep "excludeDecoration = refs/prefetch/\* # set by scalar" one/src/.git/config &&
 
 	test_subcommand git maintenance start <reconfigure &&
@@ -234,14 +234,14 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 		git init $num/src &&
 		scalar register $num/src &&
 		git -C $num/src config includeif."onbranch:foo".path something &&
-		git -C $num/src config unset gui.gcwarning || return 1
+		git -C $num/src config unset gc.auto || return 1
 	done &&
 
 	scalar reconfigure --all &&
 
 	for num in $repos
 	do
-		test false = "$(git -C $num/src config gui.gcwarning)" || return 1
+		test 0 = "$(git -C $num/src config gc.auto)" || return 1
 	done
 '
 
@@ -256,7 +256,7 @@ test_expect_success 'scalar reconfigure --all with detached HEADs' '
 		rm -rf $num/src &&
 		git init $num/src &&
 		scalar register $num/src &&
-		git -C $num/src config unset gui.gcwarning &&
+		git -C $num/src config unset gc.auto &&
 		test_commit -C $num/src initial &&
 		git -C $num/src switch --detach HEAD || return 1
 	done &&
@@ -265,7 +265,7 @@ test_expect_success 'scalar reconfigure --all with detached HEADs' '
 
 	for num in $repos
 	do
-		test false = "$(git -C $num/src config gui.gcwarning)" || return 1
+		test 0 = "$(git -C $num/src config gc.auto)" || return 1
 	done
 '
 
@@ -297,7 +297,7 @@ test_expect_success 'scalar supports -c/-C' '
 	git init sub &&
 	scalar -C sub -c status.aheadBehind=bogus register &&
 	test -z "$(git -C sub config --local status.aheadBehind)" &&
-	test false = "$(git -C sub config gui.gcwarning)"
+	test 0 = "$(git -C sub config gc.auto)"
 '
 
 test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
-- 
2.52.0
