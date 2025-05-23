Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BD221FB6
	for <git@vger.kernel.org>; Fri, 23 May 2025 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747973056; cv=fail; b=BGBMXYeuyT7y7qetKo9SPBKY8QLxpkRPGVM1NWWx5psmYzCKZ6Y3puCyrhpHeBJx6TdFLU6+JDJQW+KWXzhtx6T34Yb7unrIt7BGOZSxJno1Bo1jRsZLKa/hbNfmNwEqfbbM77rXx9KLF49/wn0HzYSd7kSUJIZ0UiNnd2K4VeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747973056; c=relaxed/simple;
	bh=r4BmhGfUaQ2xJTO/k7/lFX6OQbMke60V6KFQJ4he+xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgwzAmVnqovhfF0jOx54BjqmAEsguZOUe+HFRduQmJn9ccQZCRdrirUlYzxVbtcnB7DyP94QggNj1YL1BYkfu1VBElhF9+F2jlwuSqwrcF/d4fGNGgHHaHTTjy5ObyNYnMgqT2Ymj9XiuR3PZ9BSxTrqzrr4ABxF8W5gp9A5qm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mIgCX1HJ; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mIgCX1HJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BouD2vLUABVL1e3IZOAVmJqF9un6PIztaYnFDeAluIEqunI7GUfpaWkxotGcjevFznBCSdMdd+VM9hfCEM5duF+RoZh2hGVli9ix49NskjaOKO3aV9Z+RCStzxfq67ctqS9yrVdzdK4a1vDtfeWtf3ZjoV4x03hRHfAAtMHpCT7nJUhhkxzEk/wHZYaGcBH2jZmQakp6XMdEYuurl+mBXjmJZTfkx/t1gog+ioJqilONzdkMJ6y03hdGS7QPBuL1Ej6Q0TZPrtP9ZoFQBnFz0ABhfC4TbDJ82W9AzyGDTddl1RNeoX3aWZOXaRVheeSd1sTEAy3hafIsAC4sKZevZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z3GOxBh9HhbOuDAiNMGZYQDVxqlkr+yQxfzkncajPs=;
 b=h4QfRNISPiIYMDt86g7ys3+DbGRQow0mo+3Q4be3GBRVJMy07DP6F749qxMq2C2SfX+jDlmQCSqHk8i86H+IblHwwDdxqfHs/J7UZDk95sumputpR6FAh+RGbSRHEjE+ga/uX+/vEi/sH3TKzr43SruegoYZ/zjlDqQJkFZ2jcQbSoSjU8vuNkj4nF6/bQKgxDGuOHG/5mfozmiBBAmwe2CFV5QHGuGhaizQLhCHqE1vSimbKwM5QGPp5aQaDyULnMnGK+WJK3yFHnIz82UnMMu9OG4vj1KL8xLVS0LsSX+TdhJAwLsFJwip8lOhvrj+ZauEFIT9e1ZZnlP+voIFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z3GOxBh9HhbOuDAiNMGZYQDVxqlkr+yQxfzkncajPs=;
 b=mIgCX1HJyT89yYqCaAvTl36cRXyA1pc4LQsEbiiFwR+/Yx6AM9zVgY/2mswzlpSy/AL3QpzkB1/K2NHcjnvB2stkQSSANnfSekpdKd+kZnUbGroV3/VO6TbuV64q+oDyZfVgLbKfLdX33dPutCAgB4j37CvV4qcfBLWCxtfbrxVWaoIzm2QhssnC8Sv+tezgeb9sx34TTU2KXC8cbAPMrJCkA1wTI7pAl5Mvi6NBw6Zs2/d/n+7rk8BV2wVaw7psFE6Sm2LODvgYI5HcN+YvYhdvxdHXf0gbiFORBN0Gm/maYemklRswLRqzIElsnFwyHLgue1CUqLB313FlBReIlQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10178.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 04:04:06 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 04:04:06 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/3] imap-send: add support for OAuth2.0 authentication
Date: Fri, 23 May 2025 03:58:33 +0000
Message-ID:
 <PN3PR01MB95974F17913FB881DB8CF2B3B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597F89DF32B700ABB8AEE11B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F89DF32B700ABB8AEE11B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0033.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250523040347.25483-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e91b14-48e4-4aac-fc86-08dd99aedc68
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|41001999006|8060799009|12121999007|19110799006|15080799009|7092599006|8022599003|461199028|440099028|4302099013|3412199025|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YU1YTd3EKFuW47WjNoFKMYiszcsns0EoreG635L4fU4bkIdViF+a9u+dEtYF?=
 =?us-ascii?Q?OO9pPthfEgEmlvnyIkQ2QTw22yJv/aWuKm2JZM+qJc7SAAoYRPnrFgMlSUro?=
 =?us-ascii?Q?+3X6vx+b07aaXuWWzaOr2grFD2ERmgKCIxowS6H0nrCuWiqk3kaVQDEdPsks?=
 =?us-ascii?Q?Sgt853EpjnigOpuAoknKtZUWtbCyC6Z+ULpEO3Z26XoMNxVnd/o/SXci8PQO?=
 =?us-ascii?Q?gm5HPkJ/ew1plYVioFCUDh54+VT0EzsnR+oEvvvMgk+sYbmUYUN2wVwz+jNs?=
 =?us-ascii?Q?efXeEL864wPhZhydZ41KZUlrQqZ++3DZsnhI6UJ0sPuJIhZd8OT1X/iEw76/?=
 =?us-ascii?Q?mS+RwGrTxXK1pRFhcTY1gAeH8PIpngnCGsTmQ9MTDhk3+xh3fZCTdd+n5C0E?=
 =?us-ascii?Q?g8JbR9HCHtkX9HseDZ13s8n9SXE6bvmcsXCrZz7Wqxkb+dvKoA9CzQrd9fqH?=
 =?us-ascii?Q?BegzHDyi8C7vduA9jZTB4y47iht5eBnt1GxnARTApkuGcc9WLy5S6D4M9F/d?=
 =?us-ascii?Q?dWr01BoHIQjD9X57gWv+vKedeQI6ELAimRVY97sIa5w/VbaJi3eeCi+IBXrl?=
 =?us-ascii?Q?ttQ6xcFZeEEF+wjQ9hdoYlTS2QzrcjevCHEmYgUZTmjRVaH6jA33dP+2CnRx?=
 =?us-ascii?Q?VaKwtysdMVYgZXEbBfWDIM4xikv2PjMywJyps/KdT7QImxNTTu6C63kXIWul?=
 =?us-ascii?Q?8PkYOHBFrw/grSi1FKl3b1r7kn36FM5gH+Amij09rhnub4oiaRjCq6j0Q7GH?=
 =?us-ascii?Q?jkGbeUHK5g4u2tVOzeKpwqgFNVbh1CvCDy5pRAK7+nRG5u0tD/ggeeZt36vU?=
 =?us-ascii?Q?JXGLHtauKVR/SAh4ts6Ar6UBqzUt0qiyClDkt7FTgPFXtXiLG9cmH+lT7yGF?=
 =?us-ascii?Q?+ablgkyGOvTiOd9KiWWIXyRjVZgEPfubYuTWO4a8pRsY+a6pwoE5BohGURLt?=
 =?us-ascii?Q?8qlwkDZFb+dUJtq3Zw84FyJzoGmE43HHR7mukwOdqNvxtZII+fAw1NkVNQ+J?=
 =?us-ascii?Q?poJofT2ilMHiCFIzP20NhMM/gxWp1y51qkq/Ppz0GXaX8OAyDPOoSQv3gZzl?=
 =?us-ascii?Q?qqVA8+usGEWpjJn2+Btv65nTmSyiU5Vez8JfYN9lZPFkrcJeaCxyTqezyHC9?=
 =?us-ascii?Q?gsxxJElKVx/rK/IbILXdZHJH4OVWSilxtulqEtPL0No/cU0kMZ5NkDnkKgeC?=
 =?us-ascii?Q?HxuXTffygQXP/66mEHNp87L5s+mqlyoN/7J0cspxYb/LjAn62UgOLN5yHsat?=
 =?us-ascii?Q?XpN3fNUsi136qBb3ur5ev8NEwTfh1cqS2rp18n4QqPzJj47ypj+7bIy32PBE?=
 =?us-ascii?Q?TaKVZbGEj+EWupqYg9zl3Q/g3FXYEypvrXLVZmdW2kuq/KiTJf0ZHaz8qVJz?=
 =?us-ascii?Q?iGCwQNA+EvGdEXLXEwVXgQAIipPMGFY4ugBrb35pn+0fA6GqFw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JArsdhr/z3g9FqxERZltDbN6/MbEicqjEh2mfE/b+OSLzNPyndD4lpbVhwmQ?=
 =?us-ascii?Q?GOa3cJlbb80UqHdHctFoG7nb6Vg0B4H9lBtCNbPqajPAuXbJxsOfwp6DPB1e?=
 =?us-ascii?Q?rDCHcfP61sdRZw6+mg4UE1MzXlOGYdeLJBx0Cd9yqKfvXrL5lx1EjoU1/ZfX?=
 =?us-ascii?Q?1epYmLk1J+UqN53e7klU9TerYrwciYZdH7/j9GyX3+eID2ZWkJylyGAtAsKU?=
 =?us-ascii?Q?OQBo9y/v4x/weeDIaQRTe+X6vYx65YQT8PCB4yi7JH+1koQ/Djp4UhqUd47T?=
 =?us-ascii?Q?yBDnagxezIivc/Aj1+q0EksOPkrMUCqtfZhdSAXQk1zt1rc8u/9CW3S3hiZC?=
 =?us-ascii?Q?MArTumB9ad/M+t8gWalokOtW+5lvrfXjmFwLtDGRqTx4Mfr5NR94aRYhZzC8?=
 =?us-ascii?Q?i/P74MlH4HBlDFM7rl4WtraBluOnBdw2ln5kZpOFDNb0MDfn6PPfjkMF/oDS?=
 =?us-ascii?Q?DqAN3/vG6edsm3V1K014JsoUMALW+rLIkBpnYvReuwimKuW4069UdUZ0lfWo?=
 =?us-ascii?Q?I0/TLBfZtSzExQ1+EsXPRfQ0f3PgIqJQ5W2OlfwMes2Sn48DSH9lm9hlqWdj?=
 =?us-ascii?Q?PH83lNVC05aW8ZP68tvktXIkr0aIlO4Cw3cBhyQz/m5eFSLrAlQb6WGrFEGd?=
 =?us-ascii?Q?i64kNIcJdUiTj8/pnofOgREEZywAQo70GteZfadXpIolps70LRdP6MzfQJcR?=
 =?us-ascii?Q?SK5DZkkxMGJchBjgNMevqqjR9o6r9Knizh1+oor/E1BpDNMyadiZXhZxqDNt?=
 =?us-ascii?Q?46OxZv6VKalE/4i9QvY/+7Vh9PNWXTsHz20gwm16fmpOYOTUsI0ZTxqnHHKD?=
 =?us-ascii?Q?4ctspliQ7myqwsYZaZF8Swmuf3Os+JblUGp8nmLDZ0qc1q9CNKpFeQNfgoAg?=
 =?us-ascii?Q?eXjNCZDCmaKqyRQChY7x6iGPA3xso5rMurhfOt4Z09HyIUaPDNzK4JhOHZ7p?=
 =?us-ascii?Q?lMgshuxfWkMX7vRcL0g/35a+TheWqGby+S1DqLa/WhqtDdlTDeU915joBWDT?=
 =?us-ascii?Q?5VnDD1EiAvdc6bbHuQK+kw9+TVCLRin1Bnq8vf5ZCBRzXEbL2J1Xs1bJM0/e?=
 =?us-ascii?Q?wozbOCKEsnZmnHfsG/qw/xe01td9v0fMq6FTlZSQPIX+URZ15lXFnWt5sKrf?=
 =?us-ascii?Q?qifEnYOPjVvdyPzDDGisquFZyEa4F/ihTEqpBIoX0R0V93Y+tQX+bVePtyoF?=
 =?us-ascii?Q?Rscj8AuVNnHvuXjqsuLkTrGoe/SqAqhZMjabtXmlmcrS5IoGdTdCn+PsLr4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e91b14-48e4-4aac-fc86-08dd99aedc68
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 04:04:06.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10178

OAuth2.0 is a new way of authentication supported by various email providers
these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
XOAUTH2 is Google's proprietary mechanism (See [3]).

[1]: https://datatracker.ietf.org/doc/html/rfc5801
[2]: https://datatracker.ietf.org/doc/html/rfc7628
[3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  46 +++++++-
 imap-send.c                      | 176 +++++++++++++++++++++++++++++--
 3 files changed, 214 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..fef6487293 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
+	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext LOGIN command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..c3a46070ac 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,19 @@ Using Gmail's IMAP interface:
 
 ---------
 [imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	port = 993
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
 ---------
 
+Gmail does not allow using your account password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you can generate
+an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create it.
+If you do not want to enable multi-factor authentication, you can use OAuth2.0
+authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +123,33 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
+or `XOAUTH2` mechanism in your config. In such a case you will have to use an
+OAuth2.0 access token in place of your password.
+
+---------
+[imap]
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
+    authmethod = OAUTHBEARER
+---------
+
+Using Outlook's IMAP interface:
+
+Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
+supports only `XOAUTH2` as the mechanism.
+
+---------
+[imap]
+    folder = "Drafts"
+    host = imaps://outlook.office365.com
+    user = user@outlook.com
+    port = 993
+    authmethod = XOAUTH2
+---------
+
 Once the commits are ready to be sent, run the following command:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
@@ -124,6 +158,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
 IMAP client).
 
+In case you are using OAuth2.0 authentication, it is easier to use credential
+helpers to generate tokens. Credential helpers suggested in
+linkgit:git-send-email[1] can be used for `git imap-send` as well.
+
 CAUTION
 -------
 It is still your responsibility to make sure that the email message
diff --git a/imap-send.c b/imap-send.c
index 37f94a37e8..04b507fc14 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2
 };
 
 static const char *cap_list[] = {
@@ -149,6 +151,8 @@ static const char *cap_list[] = {
 	"NAMESPACE",
 	"STARTTLS",
 	"AUTH=CRAM-MD5",
+	"AUTH=OAUTHBEARER",
+	"AUTH=XOAUTH2",
 };
 
 #define RESP_OK    0
@@ -885,6 +889,66 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/* Compose the OAUTHBEARER string
+	 *
+	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	 *
+	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	 * * gs2-cb-flag `n` -> client does not support CB
+	 * * gs2-authzid `a=" {User} "`
+	 *
+	 * The second part are key value pairs containing host, port and auth as
+	 * described in RFC7628.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc5801
+	 * https://datatracker.ietf.org/doc/html/rfc7628
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static char *xoauth2_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/* Compose the XOAUTH2 string
+	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 #else
 
 static char *cram(const char *challenge_64 UNUSED,
@@ -895,6 +959,20 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
 
+static char *oauthbearer_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use OAUTHBEARER authenticate method "
+	    "with OpenSSL library, but it's support has not been compiled in.");
+}
+
+static char *xoauth2_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use XOAUTH2 authenticate method "
+	    "with OpenSSL library, but it's support has not been compiled in.");
+}
+
 #endif
 
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -913,6 +991,46 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	return 0;
 }
 
+static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("OAUTHBEARER: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending OAUTHBEARER response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
+static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("XOAUTH2: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending XOAUTH2 response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -1104,6 +1222,36 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
 					goto bail;
 				}
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (!CAP(AUTH_OAUTHBEARER)) {
+					fprintf(stderr, "You specified "
+						"OAUTHBEARER as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* OAUTHBEARER */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_oauthbearer;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (!CAP(AUTH_XOAUTH2)) {
+					fprintf(stderr, "You specified "
+						"XOAUTH2 as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* XOAUTH2 */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_xoauth2;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
+					goto bail;
+				}
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1405,7 +1553,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	if (!srvc->auth_method ||
+	    strcmp(srvc->auth_method, "XOAUTH2") ||
+	    strcmp(srvc->auth_method, "OAUTHBEARER"))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1423,11 +1575,21 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
 
 	if (srvc->auth_method) {
-		struct strbuf auth = STRBUF_INIT;
-		strbuf_addstr(&auth, "AUTH=");
-		strbuf_addstr(&auth, srvc->auth_method);
-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
-		strbuf_release(&auth);
+		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
+		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
+
+			/* While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
+			 * upon debugging, it has been found that it is capable of detecting
+			 * the best option out of OAUTHBEARER and XOAUTH2.
+			 */
+			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
+		} else {
+			struct strbuf auth = STRBUF_INIT;
+			strbuf_addstr(&auth, "AUTH=");
+			strbuf_addstr(&auth, srvc->auth_method);
+			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+			strbuf_release(&auth);
+		}
 	}
 
 	if (!srvc->use_ssl)
-- 
2.49.0

