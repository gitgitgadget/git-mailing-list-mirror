Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609A212B3A
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483768; cv=fail; b=RCrwSXnT0lp4ZqPvliezlhzV05xJ95lJx9OE6LHezjGZHVvm69unKkz9h3KO8+NuDRtRLqzXpMr+2Z8UA7zLlO0x3/lTQ5UlQP6QwyocxRwOIwYAeHUTF2I2NkNXfVKmoGKR2zsRO7wb9LqYpCKkA45o5AS4BbS7OO8waOPiwMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483768; c=relaxed/simple;
	bh=uJy0Mm2JqWtt3h92uBT0rgDLzPPlGVgwNj2POggmBOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNV/y6NboIWzO34gYopdYPGlH31QZVyuDzutCW0ckRqne7Sy9scYV6c89S0HlfmKVugLcDcAozmb2lmOzD0Sz2UQvhUL4zBAVhfTmRIn5cHdYms+UrXCH6jMQDQWGwU8/QiJ5ja5rCw5xkOlnh6mfrLE17StiXNEOVeLu5/FAtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=vTGACBh2; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="vTGACBh2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrmp7EjXGkmVyyULVInw0fy/XZ5bNY0irsTtajS3KqVSw5FnQ5xAXRwButLkmvkuWBNPm3S9wDS7WtL8BAqHajvAnRJ458orJQ3wHOi93IqeJdMsnrcCrdvJ7qblIgqvmEshDeyfc1asQMRPOLKrsddoqM5Fb5pzeC+P+7UQRYS3gsi+nsieUJqenWj2EOHAcqeBZV3lQCgo8vCquOR2q5Z9/uHI4nBl59tX0gYXVI8jLda6fg0tt6kDfXmJCgwKqp2Y5xrbOExQIjLZeAErZ9STYasz+Bmp40eD0bePsON1jruHBZ1aY5wMPKIBuTjWhy+Q+T1ybQRN74lNnX+I9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6+cAifY/AbD9VbqSDg0viYIcX6kHIwqQgsTVJZteBM=;
 b=mo8I854co4BH3A54+DrB572CxiA8VhhWIHk0M98acTkMVwIORvmM8v0XP40TtntRfTB3lVGt1CEAznzimttMzr1aAoWLyeKKR6sk+xZ4S9vNF8SlOpwBfCPBSG6ws4L8FyWmzAM96IU+OrJrs5p2qswC5vHDD8I9Vj8SDhfnuqiupG6ghMKXG6AJddhSq6kyUKXvWvXxzhFWL9GMSdK3+kzKRm49lzYtwzJ5bfiSsHKStn2/oW2m0HqdPUmIKXtAsl9qHFMRj6iyOPX1wtf/rh2DjB7eGpyyelrtCVcIyUWZyHqTqS14zpBfiPlNvroDzLCBbwXjNY0jVqMMuXXR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6+cAifY/AbD9VbqSDg0viYIcX6kHIwqQgsTVJZteBM=;
 b=vTGACBh2YJlafyvbHU5SxZ7jbzBy1LMRgX6JudAxxM4M8iHOMHHuaXzCrCyqZYhCq+n85hDaFvjcrEyzqhoDRbygjB6q6VVDuSDTpR3jC7orhMTDNV8lcwnnGHnRSa1/Oj5TQPngogDjhlej6rOgG1C64BFJuyyfk8f70JsDdOIqkxoYmqJ3o/42lmuyn0nKNwUP9s47LpI7W6fK2yP2EkiLh7yUSjOR6CnN8zEtRkzAUAj0Rmt63AiW6yhE7vVGIhTy/HcVhXs6IxHp8xdsFBdz0zb9YmpcG+IYpHSlfOxmZNAc5sK8zWs+210OZz7e8qYr1pI02alcgSrLo1QtNw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:39 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:39 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 04/10] imap-send: add support for OAuth2.0 authentication
Date: Mon,  9 Jun 2025 15:41:23 +0000
Message-ID:
 <PN3PR01MB959774BAFEE6933B8FD9A607B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b646b6-f5e2-4efa-1abd-08dda76c3fca
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999007|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|41001999006|10035399007|4302099013|3412199025|440099028|19111999003|12091999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qDoHacvOQGHDEe5HDFQrMxiFaZXa6V5xfR7xTr92ZkhImM4x3+CfylIQJsAq?=
 =?us-ascii?Q?wNXmkfnz+fN0BbIp+CqPWV1szYKhEWPO7zgFhPiKBJQcZqoyBt5O4XvUCMpr?=
 =?us-ascii?Q?DpbTma2l/VUfkc6C1CcUIUl0aEMiKHQ7COZ2UTNTCu5J3cdRs8RkEwShuAay?=
 =?us-ascii?Q?0ScopK7mTf2A5zBm4ZvqY/GysB4/hQ3hn1WcfP1tWcOld7YDZyH6bO1Vpic4?=
 =?us-ascii?Q?ipN5QGGgUS7AAXTjyaR8PyMEBZ1uJeEAHrml7bYxJK1s5w2E3d7kfAlEkEyz?=
 =?us-ascii?Q?lrJRBwxO95e6Sppw5SpflFX6dk3Gz9Qu7TB+qtWOFmKzPwXO7XxcaZM0xBJI?=
 =?us-ascii?Q?E26DUvuUj1/srzF+TWHoDGrr43PBjAgV9CGK38IrMhjkJLjUCtk9o0Pdrgmt?=
 =?us-ascii?Q?B99YLilnQ6wmRfn5vKqxFtTYdCH0vh9RrNb7z0pA44Bna9wH2iHmdh+cl0pt?=
 =?us-ascii?Q?Aqrd6NLq9x8uEystDHc+vWd8fdvh42qFBBpPkPGi+VeX7jrq7qIDkpOqmT0N?=
 =?us-ascii?Q?8PLdoZYS5d4LnOz32OmRSbOGwyDaHdc6/VoJeiB/ZKnf6HVYjnrAf7TtDHWQ?=
 =?us-ascii?Q?C5i3uT26smhTjcvGtLuR0yYP9KJm8vAxAiS2UOpjklnLvlgJkwAKL+ZoPJlw?=
 =?us-ascii?Q?nUwVMGlpHyEJiK3/vqCqOnGujFy/jGhcLZRYVxlqq09gSuDm0pgMMp0U33pz?=
 =?us-ascii?Q?AlPZR3gtco9Qy+WNJmVlXWcuBjucYHCisIbfpLXqvBrshJWE20qwTTKu7EOG?=
 =?us-ascii?Q?jGnajdrKRVEpR6DuCDOFBds/Mu2dFuXb41wsdBdpAEEv07tr2m3CzC3WRWUt?=
 =?us-ascii?Q?7fHpt0tCaCazfyxFJ9V8NE6WEh8TswT/AR5ZPce24p2kA8UNksj4jo+EBlJY?=
 =?us-ascii?Q?VRufGu6rItkX0H3UqDYbws8CIzBDj/VRxK+YOjr4tqIBM2KQZWkcc3/Hm2MQ?=
 =?us-ascii?Q?McuGlOVKTZk0RvU0GJ7x3rVZDZtlSAbyIITYijKVMh1FX2LTDlhtdyxF4e6A?=
 =?us-ascii?Q?tufQTYymZ7xYbgmQHP/1T+xM0ltNuJ7fkR6C2IkYAlncuK0UGYlwevskAJhv?=
 =?us-ascii?Q?GomPgsl3A3E9M/BSI13J5F0d95Gyv1/uWGWTqB89s95uHkwvvFZPXZSSfTDi?=
 =?us-ascii?Q?Z0X+9wNLwqH5eZ/YiIs0uXsdU+a3r6e2u2D3YQFlo0GjaExqSWAJrEl9I6a5?=
 =?us-ascii?Q?fs6fiTc0GFu6BXUzbMUiJok3SMMHM1nAYBjCUB1GKg47qD5sJWZHOeTqCoSX?=
 =?us-ascii?Q?19E5H9OOH6oBTDRreXmDEG/U+pEsleLvAXhDZ9owsjf9FpiEMUKYQqY/N+H7?=
 =?us-ascii?Q?n/eZrPQ0TA5nYMREM1mBeOixgemMq1uW3NVDoDk0rC7IhmykO8lIuhe0TW2x?=
 =?us-ascii?Q?qWR5uBMO9Kfov6k7zzh2ttk3WtivGUPxxknX+Fct2TUfabuhvA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QAXRCas3YWD5uV9OfvK2YrNls6ca6uJ1ceNmg087RVF0dCw+22rQIx84FKWD?=
 =?us-ascii?Q?wQ/OIOOsO3QeAcTUdmpvGXySFsIyhut8jsMPOL7kxyZ25vasyiFEW2w4FAiv?=
 =?us-ascii?Q?B/kGFvo9090aXs6N+pkuXgmElok52PKkJ0igYYk6DDSIITCw76wCBaYw79Bo?=
 =?us-ascii?Q?wolXjrHLqJSQIOqdhEgynwCVUT/C4ctd28xMJUWgbfkBGaWvEdk02yN7JYTG?=
 =?us-ascii?Q?osiZLqcH5UlirXg/iTIMfhAemK2MFf92wuK6dvvhrwH4fc2tXqPby9vYJvmR?=
 =?us-ascii?Q?GynRjw0Yo5ilBk1O6CL0uX4eXEAY9KMpa6vPX3dprLSQfi9tHQ1J0pxol8/N?=
 =?us-ascii?Q?5SPnb020hcpIxAjO9+P42wJu5BkdLYNAypbqB/GXZUC7YUpR1yLKKugHfS4A?=
 =?us-ascii?Q?3Cnmbph3TZKj5Bz07b2C90zBl0ga9IWJ4WTaeXD9+J8267BKy//F8EuQp8hy?=
 =?us-ascii?Q?r0ZXDCCuuzUHmaD+38uO0MqpIRXm39QBL8WNofkEiL9uao70ch+Yww4Efa3z?=
 =?us-ascii?Q?VzK2cCY0ebKcThezM5Zs9VgDpJLiddGFLTv4li4WsjwEn+lGEDJTgLcEHLiT?=
 =?us-ascii?Q?YMaetHPIkhnDHoptdMXoH+NBIbKdQ3QKHXNZMw77P6z5SFTt+pSTk7m5pscW?=
 =?us-ascii?Q?+WF9MpwppcgP+Zm/VjIGbgwuGquaDn19yDaZkYDBGZTRXD9XaDjvjwMo3/V0?=
 =?us-ascii?Q?bTVmgzSCfjjtFq+DQ731rjQigzLD03W7tTZhGquMzA/fFPXH9Y+2zRTu2DPM?=
 =?us-ascii?Q?E0B0BN5WLmAfjFIih91ZW1mlBbaCEn24gSNTTc+Pk02w8+7PzWalfdVECnCL?=
 =?us-ascii?Q?47k5onhJAtTC/dyaHpF84Vi4e9wyTWR2qxl+hj2MjhnqSq1431SdFrHxWgh7?=
 =?us-ascii?Q?vGyZmIzaNeMUcGSXRy2cYVCKnTS5PzL460KpfFEtsLPxhMKP36jWNqz9P7ji?=
 =?us-ascii?Q?/BcS9UGmjIaDZDWSoesMMJptVDeH1VEmDf/9EDb7K982qot8SognwT/DbVcD?=
 =?us-ascii?Q?Xv1zZJc5SLlTuzRwrLonU0u9Rzu5SCWXHK+qKxdPD6Uu9VRpckTTyd3E8U7m?=
 =?us-ascii?Q?Y8hmeAurXF4eqI7ZHYYZCLGYf5OPS0gszgSx31Q6o4sRCRsGvJb9XRGsEXPS?=
 =?us-ascii?Q?5mAZn2G7sA7arqHeYnAzmnCFR6wNoy+L0IsoVepmWgebfWbaUnKbJ3xT4NBW?=
 =?us-ascii?Q?KYrNRX5ksltbxhnTRpDnhCru5zi90J8KZlTMrXo6fPAiHj229Ge1KxBu7jw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b646b6-f5e2-4efa-1abd-08dda76c3fca
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:32.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

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
 Documentation/git-imap-send.adoc |  47 +++++++++-
 imap-send.c                      | 148 +++++++++++++++++++++++++++++--
 3 files changed, 187 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..29b998d5ff 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
+	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext `LOGIN` command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..8adf0e5aac 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,18 @@ Using Gmail's IMAP interface:
 
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
 
+Gmail does not allow using your regular password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you
+can generate an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create
+it. Alternatively, use OAuth2.0 authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +122,35 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify
+`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
+than using app-specific passwords, and also does not enforce the need of
+having multi-factor authentication. You will have to use an OAuth2.0
+access token in place of your password when using this authentication.
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
@@ -124,6 +159,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
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
index 39013330a7..24eab86a1a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2,
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
@@ -885,6 +889,68 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the OAUTHBEARER string
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
+	/*
+	 * Compose the XOAUTH2 string
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
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -903,9 +969,51 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
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
 #else
 
 #define auth_cram_md5 NULL
+#define auth_oauthbearer NULL
+#define auth_xoauth2 NULL
 
 #endif
 
@@ -1118,6 +1226,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
 					goto bail;
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
+					goto bail;
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
+					goto bail;
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1419,7 +1533,16 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	/*
+	 * Use CURLOPT_PASSWORD irrespective of whether there is
+	 * an auth method specified or not, unless it's OAuth2.0,
+	 * where we use CURLOPT_XOAUTH2_BEARER.
+	 */
+	if (!srvc->auth_method ||
+	    (strcmp(srvc->auth_method, "XOAUTH2") &&
+	    strcmp(srvc->auth_method, "OAUTHBEARER")))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1437,11 +1560,22 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
 
 	if (srvc->auth_method) {
-		struct strbuf auth = STRBUF_INIT;
-		strbuf_addstr(&auth, "AUTH=");
-		strbuf_addstr(&auth, srvc->auth_method);
-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
-		strbuf_release(&auth);
+		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
+		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
+
+			/*
+			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
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
2.49.0.824.geaff4db692

