Received: from send124.i.mail.ru (send124.i.mail.ru [89.221.237.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BD3CF670
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983904; cv=none; b=XQdZfd3uK99FBibk6NRxNHruMbGEgn0O9OwlH2D4/Y6k3xB0aQApWUzlDUt7WAcf4KhyyxhSVUVbCFbVQXrWusAHafyHH8hiz0b0AzPt9B3JZ8DQIUtKl9kQZU2pVsycqGkrIx/1AI6CsE1CZSmjW34F055XUzJIiAZF3YISbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983904; c=relaxed/simple;
	bh=mJVn/8tKRTv+U5UIA1m3sxn4W/Yp4Q/khJ9L/mQtJVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxUUJBn5vDvk1zyy+Wlwxb8x7QCzcofm6GyqDQSyxGkoBCVroaaMqCybPVnwGE/cLzuf41ukeHZx3/1370SCG2yQx+2Er0VnryDxaQI3dtdd/yMiTraGBDEUkH0IHy38Ze+YsaALnCjYXoe41SFe3ZZ5p1bdtRKE3CM7qcPcgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=QaeFy7zd; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=YPJCYr4E; arc=none smtp.client-ip=89.221.237.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="QaeFy7zd";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="YPJCYr4E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=oJuElj8l6lsrbaWPVCLLOQznJklK+ta7vWdaMs80Ib0=; t=1788983899; x=1789073899; 
	b=QaeFy7zdspJFLs4Iegzil/9emf74oDfSHeEzbb8yw5+qU3+tLQJ20UWhrGnbk0Fm4TMG0C519dk
	ii5FcaIN13uPV9cbPTYoVOpm9OCsECNJhf5t/xVXxanngtgtKtnotCzdyJDgVl2QZWIMXDFJ4M5/5
	gLsgG+Orb1+nlp0TY9T6LthRxOfl4ssKsiwqi1Aiv/TtzJ+3SyUvSFTv7w9s7oncRMkGKkAikN86P
	PLNYsnBIwM7BwdbR9IlaEN4PGsKZ8ThKcRyBt9s417qxUaNiPCz9nVrcq1m3mNs+CIa0gFMhDE0el
	TPUUFTbvHUx3fw019tmzkLRfNuyMRGTJLlVQ==;
Received: from [10.113.12.93] (port=35500 helo=send37.i.mail.ru)
	by exim-fallback-679568fb9b-xvm9c with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x4OBA-000000002kG-0oJH; Wed, 09 Sep 2026 22:41:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=oJuElj8l6lsrbaWPVCLLOQznJklK+ta7vWdaMs80Ib0=; t=1788982916; x=1789072916; 
	b=YPJCYr4EUgY67pTZRNaONZO8bCJVagspxG+t1AiT2BsfleY0mGdi+CEkofOvPvRZfpdKaLUZ52W
	0YUDjztubrsJc6HvKW1rWys5iyJVYIsJxeERLfmA+pAvTgX3jrzxVDI4xbUmp9YPRWbfboDznRRrt
	byFuLU/qt71+1xOy9SPIlhz6KMolJgPSo8E75cOZLL6UY4KK5ct0yOgf5KcH2vcBl70TS+g/IDt7j
	yv/n6jjPH2kNVspRK/ixvJAbunu32BZnnWy3eSKRbSBFIdmM0BRDqT+eNOMIbyy4stHRAKhceXY/g
	2FduR96tbV19WSXYCjtKHHxIRgH5d3z1xDDg==;
Received: by exim-smtp-569b45c49c-nkwlt with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4O9r-00000000AqO-1424; Wed, 09 Sep 2026 22:40:35 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 1A98B9F60D;
	Sun, 29 Aug 2027 03:50:12 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: git@vger.kernel.org
Cc: gitster@pobox.me,
	peff@peff.net,
	ben.knoble@gmail.org,
	Vsevolod Myalitsin <ub4nal@mail.ru>
Subject: [PATCH v3] advice: use global config for default branch name
Date: Sun, 29 Aug 2027 03:49:58 +0300
Message-ID: <20270829004959.90983-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95F11291660A1073B7AF24265EE4178F06C30090CCB8B5916182A05F538085040A5A50C0DF6894B3E3DE06ABAFEAF6705FB9251AA2C4FEB35888D1C7389238799C9EA2F84C7A7946D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74162CA13069782AFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A08549CA5D96476170319D84CE2F8D05246E03843717285D807A54CF4E104E728EEF46B7454FC60B9742502CCDD46D0D17119E5299B287EEF6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249E5E764EB5D94DBD4CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0B27420F9988F54058941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0044B9F2C9FBC7C0D7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FB28585415E75ADA9B341D7040ADD27A2B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BA6406A2B830B443475ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A55DCDA160B90AAA5A5002B1117B3ED69652955CE2A914CE11E41E333F9D1358D5823CB91A9FED034534781492E4B8EEAD3B90412627F530F9A71A35648BE338CE9510FB958DCE06DB58C12E6D310A6D53A16EC4B4EECACEB3
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65919D82E49830F7FECC72D428EB2F9ACE9F53B69AE25BEF83509B5EE181C4BF70257415EBCCB08A9A6B8341EE9D5BE9A0A1F783264D2E74DAF3021115D26BAC9179C63C3E71EA499E9C7CEAA0681F5848F4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4ZrlAo0bq3TDyw6dS7By1zzJxM3ejrN8iyKs=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBDED65FD724B436ECD3DE06ABAFEAF6705FB9251AA2C4FEB35A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B9BFAEC4A56250D1B872770CF5EF485635D435BD64EBA55E049FFFDB7839CE9E0464E60879317AFE4B503EDA59F73504B761E6C9E562721CF9C76D8178499CDDE6CBB6816E7A0911
X-7FA49CB5: 0D63561A33F958A5EF4DDCE8F949D9745002B1117B3ED69609BB42F150D1B1DBAD864E5BE48A9E5E02ED4CEA229C1FA827C277FBC8AE2E8B2175EB29DFC26EF8
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a5rszphlXEJ8m72ZXg2e5u4=
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

Some advice messages suggest disabling the advice with
"git config set advice.<name> false", even when the
corresponding configuration should be set at a different scope.

Add a scope hint to advice settings so that the suggested
command uses the appropriate config scope.

Pass the advice setting itself to vadvise() instead of passing
its fields separately. Use NULL for advise() calls that are not
associated with an advice setting.

Signed-off-by: Vsevolod Myalitsin <ub4nal@mail.ru>
---
 advice.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/advice.c b/advice.c
index 63bf8b0c5f..80cc388215 100644
--- a/advice.c
+++ b/advice.c
@@ -40,10 +40,19 @@ enum advice_level {
 	ADVICE_LEVEL_ENABLED,
 };
 
-static struct {
+enum advice_scope {
+	ADVICE_SCOPE_LOCAL = 0,
+	ADVICE_SCOPE_GLOBAL,
+	ADVICE_SCOPE_SYSTEM,
+};
+
+struct advice_setting {
 	const char *key;
+	enum advice_scope scope_hint;
 	enum advice_level level;
-} advice_setting[] = {
+};
+
+static struct advice_setting advice_setting[] = {
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo" },
 	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec" },
 	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile" },
@@ -51,7 +60,7 @@ static struct {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
-	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
+	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", ADVICE_SCOPE_GLOBAL },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
 	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
@@ -96,18 +105,31 @@ static struct {
 
 static const char turn_off_instructions[] =
 N_("\n"
-   "Disable this message with \"git config set advice.%s false\"");
+   "Disable this message with \"git config set%s advice.%s false\"");
 
-static void vadvise(const char *advice, int display_instructions,
-		    const char *key, va_list params)
+static void vadvise(const char *advice,
+	const struct advice_setting *setting, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *cp, *np;
 
 	strbuf_vaddf(&buf, advice, params);
 
-	if (display_instructions)
-		strbuf_addf(&buf, turn_off_instructions, key);
+	if (setting && setting->level == 0) {
+		const char *scope = "";
+		switch (setting->scope_hint) {
+			case ADVICE_SCOPE_LOCAL:
+				break;
+			case ADVICE_SCOPE_GLOBAL:
+				scope = " --global";
+				break;
+			case ADVICE_SCOPE_SYSTEM:
+				scope = " --system";
+				break;
+		}
+		strbuf_addf(&buf, turn_off_instructions,
+				scope, setting->key);
+	}
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -126,7 +148,7 @@ void advise(const char *advice, ...)
 {
 	va_list params;
 	va_start(params, advice);
-	vadvise(advice, 0, "", params);
+	vadvise(advice, NULL, params);
 	va_end(params);
 }
 
@@ -155,8 +177,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 		return;
 
 	va_start(params, advice);
-	vadvise(advice, !advice_setting[type].level, advice_setting[type].key,
-		params);
+	vadvise(advice, &advice_setting[type], params);
 	va_end(params);
 }
 
-- 
2.50.1

