Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28C2BF3D4
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943514; cv=fail; b=EewTRbrO8iQH1zIeUP8ixvzbmtrFATAN0ra6MwJYmuJXvfKC4GrOp1qP8rRxTN91yGvbU7ZQjs2KdjlEETky3wlpnq6TldL7rME+LfBAK5H4UjM4bf7QXf3j30bwcU2cOY9kqqtRCeRiG/k3IdsLyqj0CYPObcvQaD3Rehsr8wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943514; c=relaxed/simple;
	bh=d8qY05HaZRAsfkovuMzDq7Kp3qpNlS4/8NPcPpjgLHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/bsQ9cK87CrCnRMgDOZA0Ak0hHqpMt1Vlr7v8Gt7B+IT127y476sKAAgQIpswdSgdvYzT7JBHmcIb6r7TQSFBrSPvvpOzNdhajM2PBYyk0zLpmiOb/SDOS0r/rYhP40bvPsofWX4gjGrl9aOFrhRQODBiY8WRzimpKEiZSUzVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=VWymOGEG; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="VWymOGEG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/0R0VNqrT9Jq2FWG8Z7Jgxy+0g5UT5o/koceuZvOuBry1J2JPzdrVuFQf9LjVPJVaE8j5qJaWyRN6iy3byAXIG89Vov/rZXSiG0nlVmHmaFztuDZNXWtQEw3z/znUi+UedcQJZdEyQ4HeLqzUnQGqRaXar+tm3eSFKskT2adHSVvCaREwZjpMbz4/8FpA+muMV6ZNmGChARlpWQnEWNOW9KlTHB34v1L2s9wylRT01TbeWctB3RIGK2MLNR5EI7FL01QqUb5+57AjBBdWhwgPX4pnN8IctrqsUOWLXiBhn7K2lcJLJo01Ku6E6+XytAQD0x6+mpuHpUtogJ49MqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVGVmFaCqRwHXu6H2YBKFlskWIcuAMU+02NrwyFO58Y=;
 b=d9efWFb/xT4iTHD6Bc5oUEDVzjCqfP+G3i8ALEBWi2HS4a2qUgmmzsvUNUDLcR4ATme/3MLp0e1IjZAc2xYDCj5Itgk92c6cSOi4EcVhplKyyj0Sz5wQlUYal9ol3msFQmm27HEw5/mCDp2w1ZtnQSQGYDyK4ptl+hc9jDdZXeklLPzKBRY9KbbvVhGH7CxK0TxuENQlv7H5k1x8m1FDkcvOmrqf0804xUdhzEzEJ1USk66JaA55PC7LseGrOuGZXBNZEDrQ98WG9dxWxjB8beW+U1p1kpE3bvfFbDYcRiduTsgvRldRNXx6GILQGQSSUWEabyYaQymnqP80EpE5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVGVmFaCqRwHXu6H2YBKFlskWIcuAMU+02NrwyFO58Y=;
 b=VWymOGEGmZ9o20hCuFPnmBgbRK43QCT3E0yakwIbWUruObVFkISMeKx/xDivSYFQtCpP7JFuZ2LRmjhQumM1Q+LaZIE55TtfUpAgmw8qBZngj0DPI9nG62DqLV879MJVjVp9TD0MmTwLeSx/bbSxogHDBtOpjnTWRjvWPhKAC+iqYNyp9gd/ZPoitcfIR75C+63o/YAFY/LfZo22PXjxg/IzxTrbAqzJScjO1ZyzxNIk6a8bFGYVlElvijBbs3ENJbBKTVAXJGiSKqtI7Ur9bLLu+dbHFAnUA1qzOn2IFMFXinEQkvwX8UEVsT1L/uOifEGzfnX0xou84hKrdqhZKQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6385.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 19:51:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:51:45 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] imap-send: add support for OAuth2.0 authentication
Date: Thu, 22 May 2025 19:49:53 +0000
Message-ID:
 <PN3PR01MB95977871E1B86560E5F30296B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597EC279126820B74D2D6A5B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597EC279126820B74D2D6A5B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250522195133.9170-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 331fd1fa-3199-42eb-addb-08dd996a1474
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|15080799009|12121999007|19110799006|41001999006|8060799009|5072599009|461199028|4302099013|3412199025|440099028|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AwQ6/l2IW7KJClqdgKChU8oPm78caUKDeT2YVmXwq0Vg8vqpUbAKBYSmh78?=
 =?us-ascii?Q?cCm4j16OsYEUSVcFx89V1F/LToT2nkUFG+4La3/80VR04AnuxSXz62OpEOLL?=
 =?us-ascii?Q?mohv0hKjUr+EHcpkhIisuTSB1q+eykW4zjm1i3MFFHvVNGjawBX36J5ItFr4?=
 =?us-ascii?Q?+wpZAaHze5k174jV0VALQmJTL0i4xq94SPW27jjh+u5MS2jcBCdNemrVLhr5?=
 =?us-ascii?Q?YtW70WE0D3l1cXTcoIU6x/19eSiArpiw+naBtX/zTepiwT4HEqhYg53cOTHJ?=
 =?us-ascii?Q?5PWKc340P/nWu2qTwfJUAQYoNU6ACnoGt9yU6r3Zxvv+q6ffp8LhG1r2xufL?=
 =?us-ascii?Q?87ylkvQq2QVWEuXSaGD/zNFhyK/r1SQtxdfxVqdUGsptvKMvtEVJBO1XitYS?=
 =?us-ascii?Q?PBqRaIpJMwyXEjnS4+gjSHSzfjiQp5AMXXUySZKjj6pzftaMrNJBjpnBKc3A?=
 =?us-ascii?Q?8v/jeGnvlnOPfmme+9a8GUUY1bWkNgnYAARG3aihsvoj34L44JK75vx+Ko6Y?=
 =?us-ascii?Q?RE9rdGlXouDStu1J+Wetk/7qxCVjn44zCGRi30BP/IgDlVhO1cvGDXB8l1rp?=
 =?us-ascii?Q?hO4HzQd/EqUeYD12yWCS+klHmI+hiNZz588yPCPJJoQQRQk21WRnCEU5E9IU?=
 =?us-ascii?Q?jBYhuE2zbG7BSsgWExeHsXvnQzx+l0N1AIxH4BaERg332qjZcMvdt8Jge7P0?=
 =?us-ascii?Q?DGrp1ShBp5J+TzrWiYf6JnF4vWz+3yKf4AeJLbKZtLjMxyGN0acoRz/OZSpL?=
 =?us-ascii?Q?VxZVRCJIdB8tx3TS0EcHPbQwweayQIgH99uwBipttqgfPHnb5AIS+URKTi9t?=
 =?us-ascii?Q?JjhOOTcFn9FybQ8aHEpeDzwOl9pR6406mBr0vBfNL8IfiWzBzKbDaEU5Qnoi?=
 =?us-ascii?Q?WaE4OGeXK34E+d/OdSCZTWpOhvCj5rquWkejQxaAIKRU2n3Bb1juJx+yiI3f?=
 =?us-ascii?Q?2oe2WoWymtv5EGgbEu8Eo1Boqe+huN7bIp1CF3NOpT0d7XoV8mBDqkXKKcD7?=
 =?us-ascii?Q?uhdQYdsCy4b2da1agS1O9IN5qg6Snki358Yta2UfrzjWzn1gVYkVIfglyjz6?=
 =?us-ascii?Q?uQrEaCqT93x9P6AYF7kZel9s0w7XFnZb6HpfKoNO9oxJtgr896T2PuuQOvO+?=
 =?us-ascii?Q?MDsTW8+UIXfcUQr0Nr9gIGhxDH93pxgxyx6jWtJIOKGLdqFSBfrso7UNCqy2?=
 =?us-ascii?Q?HohiV/nn1fVpndD3GanYpxZXGTCQ/oUXehzV5PqRYUIfuSVmRhx9QIM3Qf6Y?=
 =?us-ascii?Q?JfqIEQy3QUD1h7W05CtqJ8mT6XZhJSVIUHYRg9p6bxCOj9cXG76VLc4Gs1Wd?=
 =?us-ascii?Q?EQkSwHx7sPq/yZcaBvyR8IaGjQC6QSqRWqqdB2BzRkTZHw7wmUUBN+/fVF9W?=
 =?us-ascii?Q?bojch6Q=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DGG4DQK3oUrAdKmSR2kZM7ebk9fQg7h49UQiAYFaIQu6rxGhlhGGv4lJmOvQ?=
 =?us-ascii?Q?G/bipRu8OYs0lQmtIM0f0edtTYEBtTymibso48+TaITZYhrxCx9mzFueaL4o?=
 =?us-ascii?Q?v8VNEa1krprBwGsB7a9a5FXR2egzYJ0Gn+1LZipD7Vm5naVmuqeMKovURDI6?=
 =?us-ascii?Q?R/PH1iAzVlt9+HeoqKH4vbl8CPlmQ0gg5DBKCxfH0Lc8YMyMpxEnRJY+2dq2?=
 =?us-ascii?Q?QLaE8i55i37J9Ab3QuEiv/WOFx1sGCSUIr5b5KuPlEhQysKPFR9Iza8d22fE?=
 =?us-ascii?Q?I4qZLXeQIBCwf4h9/AZp75ZqD0+Cx0VlF5kxCxnSnodsEMrZbdj4IUeJ6msT?=
 =?us-ascii?Q?Z+E7tBB+m9ShWdPO/XCxVryGXrf4hUGZxqc+eSC1D2krzRRhtaVn41YmedWa?=
 =?us-ascii?Q?PaYRTcY9wcFGTrhO/E8JUPVP2uGg2lt4Nm0mOZqCvfrHumxPfFrKANBcND2k?=
 =?us-ascii?Q?xooL6JIPCisMRvMwM/rjXggONHUX3Rr3GztKBZtc7ZBbljNXkuIWUl9FZi0N?=
 =?us-ascii?Q?h3iNLy02vRux0PwfrIRqUQNfxOa1ZnH6fJngEGy+AHIpExahO4winK6RIDaJ?=
 =?us-ascii?Q?q4/0PixbWKIW2tV0ppNNGObj5W9P7ag1mtWCzrKbFxh4iQV7bP/P0LG8ODkM?=
 =?us-ascii?Q?oAIw54BLX3s4axtFNDVraMjQDd0trOw/IbKbe0cmQ+7XinqckhbZchjzFlFB?=
 =?us-ascii?Q?Ay8dE+vRPL/4lzfJA591y0KldN0QhMc39MktQK062osShu66PEU62mrftJpH?=
 =?us-ascii?Q?UjFXlqzjsrvO/3a2VHoJ2Wd+KKIm5+cNTlmt56xV42GifcgHyhcez9+rusFK?=
 =?us-ascii?Q?iNWmkCMkpNnBPirLYFdSXpL5igxFqm3VnbP02zCJ2r4+TrctVGmLoTet+RZJ?=
 =?us-ascii?Q?sTjRFvN3rfKDCsmdUSHfHAdIIDyTG+Duby457BxhPwrJPi1VEeXOhSaHzlBN?=
 =?us-ascii?Q?axQM6OfXk9mhedhOfXXagOAUrQ5v0Mn0mmvMzyTafpSCsk0I2O9eYCavLRpC?=
 =?us-ascii?Q?o5vTNVl2oj7EvWFxcoLuAXfgNIDKlMfSygCT9EPTcnzttaDDu6pG9CsGeQSS?=
 =?us-ascii?Q?Aue2NFVz6IVxdoxfNFUFmOk6B9viVg3yaKB+uNPGylDGNIzxYzDr7HQvNkg5?=
 =?us-ascii?Q?dsLpBt7uL2HV9u7YyGTgDluz9iajbHV9zAKTutcQDXvGEMv4PjSi/a7ef8Qn?=
 =?us-ascii?Q?aghePwQyAJ9oTs4sR2/dSlTGeNeZ6doq4sh1r9AtkP2qWISa1X115W94+/4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 331fd1fa-3199-42eb-addb-08dd996a1474
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:51:44.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6385

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
 Documentation/git-imap-send.adoc |  43 +++++++-
 imap-send.c                      | 176 +++++++++++++++++++++++++++++--
 3 files changed, 211 insertions(+), 13 deletions(-)

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
index 26ccf4e433..8b73599d5e 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,16 @@ Using Gmail's IMAP interface:
 
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
 
+If you have multi-factor authentication set up on your Gmail account, you can generate
+an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create it.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +120,33 @@ that the "Folder doesn't exist".
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
@@ -124,6 +155,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
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
index 37f94a37e8..7616496cba 100644
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
+	die("If you want to use OAUTHBEARER authenticate method, "
+	    "you have to build git-imap-send with OpenSSL library.");
+}
+
+static char *xoauth2_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("If you want to use XOAUTH2 authenticate method, "
+	    "you have to build git-imap-send with OpenSSL library.");
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

