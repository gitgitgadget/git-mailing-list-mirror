Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE8224B0C
	for <git@vger.kernel.org>; Fri, 23 May 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003012; cv=fail; b=ZpT4HBh7zpBZ9sFfOQqZlrbBbpzuSuW0p2p9bvfK4md5bLqQN/nJ+++x53IBpr8e5VgPeyz0Tn1dAjB6mvv7q7NC8Ix+1j06SlI1iZ6odqGacKlW5BqiPHtop9ni7878VMQQ+5L3pFoJF9wtBwV10yvzfzXa23gh2d0vxPe29jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003012; c=relaxed/simple;
	bh=TFfDlEZvAeYasS1ybw8nvQabjvXacDOdU6OJ6UkzbP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+8rQozJXxRhvqlmqlXeCOMXfKAGZcoCPUBsLtD+qaGNk2X/tAMLaoaNIfLsulZ4sd1dUu3wCrGfXwHyEGzHiA196aKoXuGw8yAXae/nupw/pn2bxuXl0y3FyBU2I1d8pJ0Gm1Prk8wxpf5yJZaNP/HMnkTt6BgIMLSc7nsVOoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=tGT+XRpt; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="tGT+XRpt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs/t2M3DUTiK1/MLw8UOD0ugQOJv+OU+s/z6exxGqwK8T3oqGshx7Lip7zCB5zIrbYJmifdnK/OpckRFNYbde3Ofi1F3v4nzl/DfEH6Ttlogvh2utz0zIWEHJGm9Q3RPEahT383z6KgadQTAFR3mNbwMfOf88WExUAVsvoK/Vb2+dP56sjkH87C7SWK73bM7i4wI1xx4gTICs5t1Xp4tMZUwLxVEREvSAxmMmIZny+dbW9/R6CZVKPbp7jv03xUS6xCC3qwz8IhJkP1PHIyFCwuva7bAo/vYV7BUrM1hix9EWrn7FrnMD2KT3/1wiGzJxjIkGhAptCiAmNMtlz6p/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AcMS5ljEk4YoGBqBzc3wYnwRgY4j9wHR290cD0coWY=;
 b=fLH/q+Qzl6ouLGp/aWODc78hpJ6J19dYSUWzcOPhOCzr9v4AdMTxvAHDF8crxQgy/UaaWhGnwfmBle+stTRY3zTTzZVkfAHLgflhCryf5Dl58ocNdRDfniaICnd418ekIAXUu4rcPt3NhU5sQMwusiAv5PzQ1hKA3LapxHo4j5G4uywKNFmJkP69l4j0NkwzMFN7bq2hfzLWVZ+6A8DjV/lvCkyUYn+b1UcjJ+nBRrl8e3NtllvH7WQF9+YRYu7aP9Q3PiwDILl1L7xpoxe01BAjuC4+xXvNeYguIsdllsg4PpRPe5k1cWucFi7SUE+6S+9bnxILg6KFX8x3k9Czww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AcMS5ljEk4YoGBqBzc3wYnwRgY4j9wHR290cD0coWY=;
 b=tGT+XRptobMfug8XnIT7uyhjlX03zyv4uH6VpXgUURcV1kPnFoZnl7kJt+Jf5uxl4YU5Uf/hNkHyU0awathE273UffbTNWuxwNzGkfVG6xgMAezuE92UPYdKLZV758RfWBiw+YE5bWNofaLazKPfvhIQsSYZvdZJtGdhJ+XiVscZN7OiYb5am56AXFWWmg9TX+OA0KtZVlkJOktimTUjYe6zSjkjyiy3BD5emvb322GS/EfL+EW/BZiu4GtXDpiYPtW2E06iMbp2s2zfxGk8WZP4xUeEzSVqrJfxmAjDQtl+lDjMDAM60V6UZSjfBKaOjXTQhbNRev/9O/ZP4ga8lA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6603.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 12:23:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 12:23:25 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 2/4] imap-send: add support for OAuth2.0 authentication
Date: Fri, 23 May 2025 17:44:28 +0530
Message-ID:
 <PN3PR01MB95978DC78F56DD0994BD65D6B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250523122236.22593-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d5bfe5-7748-46f7-25a1-08dd99f49d6b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|12121999007|8060799009|7092599006|19110799006|15080799009|461199028|5072599009|440099028|3412199025|4302099013|12091999003|19111999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8hxnMpP1woTYhBBDLEDTBvOCediKzMoidtoiZqAhPw8XQ6LH3wG77WkOp5V/?=
 =?us-ascii?Q?cZxiJJMAprwDfqHtfnTdciHahWQNcAPONn0G/8czuTjDAxS1aZXY+OUX0/Lz?=
 =?us-ascii?Q?DdvX0xM28Is6pc4d7L0Qb6q5OqQaaE9MxwgU8gkNTysOH6Qp9Q/X59N/jsdT?=
 =?us-ascii?Q?xLSQPvxo2T+5IPrR+I2K1zqh044dsyCgqqaR6vQ1pK27NeSt1Q19pi7wTf/g?=
 =?us-ascii?Q?z5KU4oFPLgnMJfC+N097EhI0WZ3WcaC9cO//f02X7r22VNikUFvYSM6MauRK?=
 =?us-ascii?Q?BrDjRe8N1+FCXWBw+xkIPfyxsJIXH9ddBgGAZXJH04NV/bopvR/UiNxFI8ak?=
 =?us-ascii?Q?Siulx0a9rt+TUHBJ3tmbzvKOEMhIa1FtN9xZByfY8erX8HayO5doafLSNS0v?=
 =?us-ascii?Q?+i3336I/J8VuBZ0A11nl744Uoqre45G1oKE26KXQuXwstJOilEftHldHGMdS?=
 =?us-ascii?Q?uNAbCPieRklzP4+NJRpIAOBlZSYnVg+dViF3pIGusu6nZ5+6VNF4on+wP6Hu?=
 =?us-ascii?Q?UnPQTMjtvPT3HL2ksCnA8jZ/hNZD28AZ+vtFKpt4rvpLN9GN1v4vA0fnRw3T?=
 =?us-ascii?Q?3OVABUHEFDpJR61VNOZOSouhzrwHsDZjYcYzcWhiqOmNV9UcsyA1X1qjWRKV?=
 =?us-ascii?Q?qkL6+pbqOSlcO0bpfQhpgFy8yNt/5q5ryasNPi846SYX9zlxorVJ8iMTFZoS?=
 =?us-ascii?Q?GxuPbi+eLrs0OQe8/S+U5AQ8vKjWElH88c+S2i4MLcF0TSos2IOeGz805Jc5?=
 =?us-ascii?Q?Ln0stjc3z0H5Slmf+sWOKa2QcfkhfZM3QshB2Y9Z6BrodLN3jcAcK8L7VRwk?=
 =?us-ascii?Q?nabeV1/RSHUQBH3j7nFUPemus4NuLcci0N5Z+mYZkraasnjGm058oEBmQV64?=
 =?us-ascii?Q?67Fm6HqUYmp1cMxMKHTQcOxCX6O/Kdr0+WH8wHTDWrgP1GriQNot/ByV8ig9?=
 =?us-ascii?Q?lOfOXbx1MLxYLgOoAIT4HOD9OjM0ZiFe0f3hWm4BZhZm3zAkJd+XkkQuMTjE?=
 =?us-ascii?Q?wrRWBctT2VkYO6C7RsqEPmrsd5FH/3lmAGYNi417v9X2lApKbBbm1BWF2wHr?=
 =?us-ascii?Q?bj8Xtx44a+Thf1k7pnV3fRgx9mqR5OYVwy3msQCnBab0mgwmBnf+I3vDcqJc?=
 =?us-ascii?Q?c386fsVuuQITBJNQgHi7JmzaHQccOr695SaphbDQRBCOz6XL6Xlums2KiEQe?=
 =?us-ascii?Q?3HM3g0JigH/6IQ/Xn/w/eGIPhnpV6/eKD/+cKNR1HNnq9c89G7PRWc8CWXff?=
 =?us-ascii?Q?xz7t23GoqylX/8ZQesvYxkuw0KDk13SKkFXTlg1BZ+7sw/kYbIkwSY53WuLb?=
 =?us-ascii?Q?Bb5tIY+ztuzUBsfF4XGD1J3VNvxJGB4lqA2azDu2Ghb0aDMLFuEVjqOaFkvY?=
 =?us-ascii?Q?i7H72UI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tWt4jqsYnaymoXZc8yiShrOU/nPenxI5mIVvBz9R7F05Bv5HDJf26WT9IMdp?=
 =?us-ascii?Q?LHewKR4/G2KBgLsJHXzYykDPRn7m2Kn9UiDGcewjuKjJ/31wOP81AVvwjdw+?=
 =?us-ascii?Q?cX11KOpyQqmRhXNEavWohv6GYYQmBbWnkUdAtzCM+ts9EI/Axu7iCamVaq4L?=
 =?us-ascii?Q?U8/GSEzsa2PovFP/io/+NfXTZAR9D6/JsqeyX0I9JpJuX3Am8bURpJA0PEN9?=
 =?us-ascii?Q?GpYWv/Qgj61NkcnSDlm4IQVd+Yjq4KtgP0o2lB8GGKC3Q98AfHvNVeNqws/c?=
 =?us-ascii?Q?lxWvs2KYf+jeODgNOGGilyH+GSjDRmTPAHVcf2fsXKVqB66BL001o5gZgRcb?=
 =?us-ascii?Q?bBDuQEqYBFiXf0uUUgKEa2nyYlrEXHKh4WQN47zW7LN+37/kgE+rNdAiUjQp?=
 =?us-ascii?Q?XFGLq9QQ5MypdW3QQcePmtv3QJxDqrVWTGBF0vn4TIZXM7kQK7LNIhWaQNXh?=
 =?us-ascii?Q?X5jh6rK0T4OUmqYNfD3n4COVT0rC1RKir8S8CHGiCAB1/U6K250Y7AwgbjKy?=
 =?us-ascii?Q?aO9RjuXDNNTpW0Kf/BLzkHcHOgNtq/Dx50rMbNUCFh1YObY/Pjj1x1+bS5V+?=
 =?us-ascii?Q?1W+AnNW49vVS41sJ1bNT6R1mFHi30yS/IS45WrpTW08KaQ8CpgDTcXM3FyHL?=
 =?us-ascii?Q?Lbl9Ta7+tTH8FHrGVbaFBn9E4I8o/XzWYI6MBnCk4jCLrCwd6WXlfT1eRAC8?=
 =?us-ascii?Q?6CdmEAWszPI3iOhGdbDwyhjWH/us2mFljVKvb3cre/jUS1JyFo7bqE3MgF9e?=
 =?us-ascii?Q?AXtZNxPtGtLwurIyIguLpL1tuy7aLCH5ttxsWarh+r8FG2IbvGLtqEZdGPKI?=
 =?us-ascii?Q?z5NPIYq/wEYrY4fps+VFosAgsbGJv0nEPvXL68vCXt/qX3xiTQevRAgFHaqk?=
 =?us-ascii?Q?xljX4TANYcztjMFk6duHySTn1zjPbY1vz+NMQrb8O7HwfeWoNhLC482iYn77?=
 =?us-ascii?Q?niCOxCqPcpzdT5p4TwZMU9MthKCTu4Gdo/cq6Dh9OjzbX8b1qlVexwhkg+hs?=
 =?us-ascii?Q?d/SrP6+2qK58GQcghQuNQ6G6XFY829iP1V1pZaWp/VgUsTiZ4/gc10YseKRX?=
 =?us-ascii?Q?U1KrWtrss9TQ6q0p5HHQvgGUPa+kNLpK17WgyH1hcJq1TjNoZPUUQbB1shkq?=
 =?us-ascii?Q?H0hRlsmPYVVHt/dyS8SFNTOB3KVbj9nzTAI8pN7H0lwgU/7jPncXfHcbicUu?=
 =?us-ascii?Q?lHOJvlpwInxxOlRkK4J0TWglkgQPNHaez+gWN8WcywPwgeB67UGkPFZm2eXu?=
 =?us-ascii?Q?Pv5avNTTEL1Ix7jWLyeQfB2iEr+haWTbErdGiIJuHm5c97bo4ZO2G/F6y+pm?=
 =?us-ascii?Q?wgE=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d5bfe5-7748-46f7-25a1-08dd99f49d6b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 12:23:25.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6603

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
2.43.0

