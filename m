Received: from send123.i.mail.ru (send123.i.mail.ru [89.221.237.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E75947F9
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888309; cv=none; b=eHnC5Hlg6rdNirXdRnovPqSKpyWvZFrSXprj5aXY3VBH/PjFdrhKB/+CYZDhyyioMYRB7/MZa2BUmyjnMC+8lsgslnCK0/a8NS4n3g+DXyL1ySRSC0E8++d5acF5a3NkGiI22S18uW8iRZSt5bTyFDqN7cFio6gG9f6bBICJ5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888309; c=relaxed/simple;
	bh=Hcu/1HvMOnwp8X/f4jOhQ3N2+u4xjIO6K3+w3oF4o5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UU15KCllg0W/F69rAiTuQzQWVCmzaAG0/HTEkjyp937S2NbWKWoAidWeAgKdnH3e/SAV7UB3ZOyGBT3Hz9N5+pS+hCkh6vvr7mjqaxCm/ypqQT4qeD9wQm3MPasfhLVYXzQcfwGEavMd6zpy8Zo9XiM9UhBKyydSxVlalf8iykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=cCEANuo6; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=wO6A0uyQ; arc=none smtp.client-ip=89.221.237.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="cCEANuo6";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="wO6A0uyQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=zjqVMUhwb7RlFDC/xJCSU2sEr7eu+oWT36OnEsOUZq8=; t=1788888305; x=1788978305; 
	b=cCEANuo6uRrQQYhCn7+tA2CiiTFG1z2/Je19xLcoWMvMWohOYTsSOHWoFwF/yJKvEPefy/TrWPI
	n+6TdhrJRRw2e64Bl6p6wdh8bz1l1hsUPneEq/uY2cTK9lF6k3Juvng3RfXiTPADUjDoNbM0NirNW
	IfbdbxTcmHs+15Bxi400JyvzQApjO+cKZ8FYwXRtl/3hqrIwDUox/7/oLRNfKr2AdVgM9A1oWjaV7
	ZZ3mweCOLa3EptefzuepRK1xd/+CO+/VrRxue4o8dmPe1ErmSRgNzimy0BMgfCtCzaP+pm+h/u3Mp
	0rO2D0cUCpJIpnmtvQidY5mr/wj/A99kSBGA==;
Received: from [10.113.237.16] (port=34170 helo=send278.i.mail.ru)
	by exim-fallback-679568fb9b-dlnnr with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x3zKU-000000007rr-0BDz
	for git@vger.kernel.org; Tue, 08 Sep 2026 20:09:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=zjqVMUhwb7RlFDC/xJCSU2sEr7eu+oWT36OnEsOUZq8=; t=1788887394; x=1788977394; 
	b=wO6A0uyQlyrgPPO2gv1W4tSVDRJx90RDkg0VSrB96KbCQhDz5dWnuWHDQDTujesCTHV+NUiyHxw
	L4LPut4cgOrzYZWZ43UdXITB9MO/y9XdU6Edpf3+o38w63tGwP6Se6KRj1RBqCsSJ+DFA9AP8mzbA
	unphqrNccHczopoinTyz3Dw/owoJDfXW4nOzMaUPJnY0KV8tB0J5A1K1rMhfy1qWjMAw4yZVUNTiM
	eTrxG92Z2zLMeEtm96p7FEMmawUqd9F5MTaDGdDqVNSYS+ZOnQ2robnZbBZyhajSmk4XwpjOJRLOr
	7sxBvItuSNnQHMinbCU/ZbDQcTyIQx2WaXww==;
Received: by exim-smtp-569b45c49c-m8spm with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x3zKL-000000006H3-2Lj5; Tue, 08 Sep 2026 20:09:45 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 6E7AA9F60D;
	Wed,  9 Sep 2026 00:15:06 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: git@vger.kernel.org
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>
Subject: [PATCH v2] advice: use global config for default branch name
Date: Wed,  9 Sep 2026 00:14:44 +0300
Message-ID: <20260908211445.37516-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD95DFF9E80284F3C708D538A93CD34EE845618487DBDB393B1182A05F5380850400F74C4283752DAC73DE06ABAFEAF67051B22FFBB5570E3281FEFD2BFEC2F43B8CFCBA5A4EB472813
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72E0BB8D059315229EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB5533756682FC6F8CF4E8B7270634FB97FE771952D957BEC7CA7A4026FF22D9797AC837D98EEF46B7454FC60B9742502CCDD46D0DD2DCF9CF1F528DBCF6B57BC7E64490618DEB871D839B73339E8FC8737B5C224901F8F2FECC0250C8CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C04CF195F1528592878941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C08F8EBFF998F60A437B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FB28585415E75ADA91DCA69B2CC609F68B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B7A115A9DF4E0DE7975ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5189D27D96FBF1DB95002B1117B3ED696555E2064CC1540A7FB820E9FE7BD014C823CB91A9FED034534781492E4B8EEAD03B4017E30074F69C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65925A03806DE4F0C6086EC04EF843EB786E2D17BDDDCE2A36D5C411D56886DD4F15AC39BB5DCF55D33B8341EE9D5BE9A0AAF4011BBEC3A917841DCADA172D5B4A77212FCEDD9F176D88CD93680B12512CF4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWO1iinEl90Gfm5/lFOSIJYM=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBD53AF546B95FE0E1B3DE06ABAFEAF67051B22FFBB5570E328A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C775F1C6D245C3DB649C8E7ABFBB5E1020596760E0D5ECCF68F3CF0E9FE49B6969BD46589B4184D1EAFBE6AE79F3F17DC704793532C7E85326F55F637D71EF136A26ED82CAF23018
X-7FA49CB5: 0D63561A33F958A5ACAF10A064E006865002B1117B3ED6962A8E44F41235C1DD4E82D2634811542802ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a1SpzZpj/QBfMXqJwqYkI9I=
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

The advice for configuring the default branch name
suggests disabling it with "git config set
advice.defaultBranchName false". This setting is
useless because it neither affects the current
repository nor newly created repositories.

Suggest using "git config set --global" instead.

To implement this, add a "global_hint" field to the
advice_setting struct and explicitly set it to true
for defaultBranchName to indicate that the advice
should recommend a global configuration. This field
can also be used for other advice settings if needed.

Signed-off-by: Vsevolod Myalitsin <ub4nal@mail.ru>
---
 advice.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index 63bf8b0c5f..c3955eeebe 100644
--- a/advice.c
+++ b/advice.c
@@ -42,6 +42,7 @@ enum advice_level {
 
 static struct {
 	const char *key;
+	bool global_hint;
 	enum advice_level level;
 } advice_setting[] = {
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo" },
@@ -51,7 +52,7 @@ static struct {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
-	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
+	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", true },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
 	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
@@ -96,10 +97,10 @@ static struct {
 
 static const char turn_off_instructions[] =
 N_("\n"
-   "Disable this message with \"git config set advice.%s false\"");
+   "Disable this message with \"git config set%s advice.%s false\"");
 
 static void vadvise(const char *advice, int display_instructions,
-		    const char *key, va_list params)
+		    const char *key, bool global_hint, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *cp, *np;
@@ -107,7 +108,8 @@ static void vadvise(const char *advice, int display_instructions,
 	strbuf_vaddf(&buf, advice, params);
 
 	if (display_instructions)
-		strbuf_addf(&buf, turn_off_instructions, key);
+		strbuf_addf(&buf, turn_off_instructions, global_hint ?
+			" --global" : "", key);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -126,7 +128,7 @@ void advise(const char *advice, ...)
 {
 	va_list params;
 	va_start(params, advice);
-	vadvise(advice, 0, "", params);
+	vadvise(advice, 0, "", false, params);
 	va_end(params);
 }
 
@@ -156,7 +158,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 
 	va_start(params, advice);
 	vadvise(advice, !advice_setting[type].level, advice_setting[type].key,
-		params);
+		advice_setting[type].global_hint, params);
 	va_end(params);
 }
 
-- 
2.50.1

