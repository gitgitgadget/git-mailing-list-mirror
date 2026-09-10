Received: from send78.i.mail.ru (send78.i.mail.ru [89.221.237.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB5364029
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031512; cv=none; b=QGeL0lUacazmFyc5Njsn3Spejew3uMeEYjDmSCci7qJyVPYFv+IAzWNYGd5gyaDI0juCNuT03zeOkLOQMMg7NW1kDXWuN+Y0jAsyHiJTwHY7G1e0kPDY93fypECDKnOxGq3TFBxXaeOXwahTbw+CQzzB+xsYLHopPkrpVO1YrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031512; c=relaxed/simple;
	bh=tiYtPnTrq79E9snEyx8KN/ltHDgwm4hX5/BD0oqJjWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBpqkRFvjIfpqm27DWpK1SKreTX7ynFqi+kxrA30rosWRPMUH08DroPwm9BcOhrzuvn4W4bB5Ng2kY/lpSA3FPRhwiDm6+4IBKGTC4qzaViJGluaroyoVlO0yHKvE6UHkxMk0A85zsksN0QbKHqxZVFuuYPtnsBCSfvpEAmZPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=fEBTKQlV; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=b60S8h8k; arc=none smtp.client-ip=89.221.237.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="fEBTKQlV";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="b60S8h8k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=I9ocqiYssPiaDeeN/Mg4Z3ZjJcotWZxuMy4J5HjYEjQ=; t=1789031507; x=1789121507; 
	b=fEBTKQlVuyaDvHlhrb+GhsiLHkEBNbjI8qXKXFXWyV4ZhpvEUUPsBBuV7X6FqnZ+S85QbCf/ZdY
	+0TOcSvLgVfIDmuSR2It7NOHRMlwNC3rxq30BOrgLh54aU5VJQkiu7SGObZqNQRxREuW7r5UJk7SX
	MOWC6BejVmBSJaxZUcViBOm+Pc/q9H10/DKCk3aG4aCFXqencfOI/XCCYnWXWV9+JJP7P9Nvgkqb8
	DaMo9FHjX9iYk2OGdO0sYcfbpJbMvNFxXzR33+RSc9qUAQ2neiS4F4Y6i1+Ms/Zf43jimgadnqhl5
	9ByOis6zSy+oKveNvdyMtlwDho6JSkhKCtiA==;
Received: from [10.113.196.132] (port=50968 helo=send241.i.mail.ru)
	by exim-fallback-679568fb9b-rzgpk with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x4aZ2-000000004aO-3rQH; Thu, 10 Sep 2026 11:55:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=I9ocqiYssPiaDeeN/Mg4Z3ZjJcotWZxuMy4J5HjYEjQ=; t=1789030524; x=1789120524; 
	b=b60S8h8kotvak1EPjfsLfeu81tYMzwnsxNkLZ3ODiGR8oAKLiEJE6YXos7bK9079gGcCB8YZSKN
	PkZQ0ZlR1hU3zxMLV78zv5/qJDhPt83Ew1yGeDjeNIv1Lyd9OijPBxjEErmjjyg47yJrQv/HW7U42
	Q2MasKA4P18bPDt3Nl3+sUSkLLy8sd9ovomwDdcOCXYB1DeuOl5lbJEFZJmMI7E0eEHxkgqV2EbIK
	VJ9cMXtQgociz187n2tjyNQCWuy7HVWVCTfnUmkF6+xht87+cdK/J/leFcun/gg3R6Oox62ryttGs
	YvMSB2lZhjNlKdKgviIgIkekmchq8Hg+rlfA==;
Received: by exim-smtp-569b45c49c-ljfgv with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x4aXj-000000006ih-3QtV; Thu, 10 Sep 2026 11:54:04 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 21BD09F635;
	Thu, 10 Sep 2026 11:54:03 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: git@vger.kernel.org
Cc: ub4nal@mail.ru,
	ben.knoble@gmail.org,
	gitster@pobox.me,
	peff@peff.net
Subject: [PATCH v4 1/3] advice: pass the entire advice_setting to vadvise()
Date: Thu, 10 Sep 2026 11:53:51 +0300
Message-ID: <20260910085353.109373-2-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260910085353.109373-1-ub4nal@mail.ru>
References: <20270829004959.90983-1-ub4nal@mail.ru>
 <20260910085353.109373-1-ub4nal@mail.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD95F11291660A1073BBCC05EDF39260590CA9602E3119BD3DD182A05F53808504082D47F3CC21017D53DE06ABAFEAF6705C7313055ED5917121964E60332344D732D7423A3730B9AE4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7ACC115E2004B0725EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A08549CA5D964761940B9444F0852FF8EB05B0A5CB07BC6DB3913755700F928C8EEF46B7454FC60B9742502CCDD46D0DBC0ADEB1C81BB362F6B57BC7E64490618DEB871D839B73339E8FC8737B5C224901F8F2FECC0250C8CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C091DAD9F922AA71188941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0B967CDC049C115457B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FB28585415E75ADA97B089FF177BE8049B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BFF4145385FF5C95075ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5EADA052FCFED2F1E5002B1117B3ED69672CEEF6180E4D53E5B6221DB6D7A72AD823CB91A9FED034534781492E4B8EEADBC0994F947283B77C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34CAB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659BD82F700F7571B15DBB2197D46F306D9D35898E96567DB082DED23776CD2B6F73A8F070C29706AF9B8341EE9D5BE9A0AF8724212F5ADC6595514C866012B919D822905350362F750C7CEAA0681F5848F4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWFpuP5d0Zh5atEW4g7DlDWI=
X-Mailru-Sender: 288943BA7BCC8BBA2C509D5366AED3E5B676C78F813EF3620841F56765D88C409E42483D52CC511804F188836FDCF4DE3B7E521F6A5800A996940349D467AF430D26F6DE3BAD3FFE4DFFA654C60F801316CD019DBEDFC45331DC91172AC7F52EF91D4A7208CD43CE3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B9BFAEC4A56250D1B872770CF5EF485635D435BD64EBA55E049FFFDB7839CE9E0464E60879317AFEE385CDF2A6E004CCEB3C5A60A84FCF0B87FAC0662F809A7D83B5F9A865CA8C0C
X-7FA49CB5: 0D63561A33F958A5C72D638D6AD0E07E5002B1117B3ED6962C947F510960AC58AD864E5BE48A9E5E02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a/mge5WbOvyyRHpOXlb3+Yw=
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

Currently, vadvise() takes the advice level and configuration key as
separate arguments. Pass the entire advice_setting structure instead.

This keeps the advice configuration together and makes it possible for
vadvise() to access additional properties of an advice setting without
changing its interface again.

Signed-off-by: Vsevolod Myalitsin <ub4nal@mail.ru>
---
 advice.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/advice.c b/advice.c
index 63bf8b0c5f..b556c8b38e 100644
--- a/advice.c
+++ b/advice.c
@@ -40,10 +40,12 @@ enum advice_level {
 	ADVICE_LEVEL_ENABLED,
 };
 
-static struct {
+struct advice_setting {
 	const char *key;
 	enum advice_level level;
-} advice_setting[] = {
+};
+
+static struct advice_setting advice_setting[] = {
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo" },
 	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec" },
 	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile" },
@@ -98,16 +100,17 @@ static const char turn_off_instructions[] =
 N_("\n"
    "Disable this message with \"git config set advice.%s false\"");
 
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
+	if (setting && setting->level == ADVICE_LEVEL_NONE) {
+		strbuf_addf(&buf, turn_off_instructions,
+					setting->key);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -126,7 +129,7 @@ void advise(const char *advice, ...)
 {
 	va_list params;
 	va_start(params, advice);
-	vadvise(advice, 0, "", params);
+	vadvise(advice, NULL, params);
 	va_end(params);
 }
 
@@ -155,8 +158,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 		return;
 
 	va_start(params, advice);
-	vadvise(advice, !advice_setting[type].level, advice_setting[type].key,
-		params);
+	vadvise(advice, &advice_setting[type], params);
 	va_end(params);
 }
 
-- 
2.50.1

