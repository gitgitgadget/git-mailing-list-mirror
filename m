Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7506220F5C
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401664; cv=fail; b=EG+HSxzK1DDAXg2xvILCfFDNsXhxTPm9bzVz3Ozi+wztYIkOAeqQ25sxqi8ogukBHXJ5uFN0lCIOmotgVIvb82WSr2z+QaYW5TIQchHiSS2C93TGJ5sUjFTFIURuO1ytCg7tvu2oTP6HX0MgUUVwBmYbduDjxk3JdQwMZneJYVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401664; c=relaxed/simple;
	bh=/NnLA8LcY9P4lfH+exazqnLbk2MHZj7Njj6bAzu1Di4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bvmavPNUDdjpchSlsSK+O9/FJezlDiGL1BxHXCGUA7f7skfxd2OAEvwLLll7lu8ZxSDZbZWfNmxH4O9Tby/cpGqBPQ5xqhGwoZq6YRh0tBIqsBrYH1ynqJh+x6t9uPLBbDQdG04i/4uoeXpvjaH/hxYYr8ygWCwXIzEuXbu/c4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Ggd5Pn66; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Ggd5Pn66"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGT8vNHRKkQyiC12nw0CJlev2r9xely9XoXsexigResXqxhLRkfwpVjpTXPxAXSDVlTlww5RsMwRSCuIFjwlLXV8jb/32UGZVFfYwXksHw1PVcwTalQzf6TXv5DIuzR5pVwgcOiJDhcnDoqvJNL3cG3CDY3D/gey7i6yX1VjLcQ+qUfmPyl61pvEJ7pWcB9sYQFEmLpsZqBgmKlkxVyR9JFAbGLsV+uStcMJlm9Auftr9BHC/+ZcrkqrJgOhxD6XUfcS0Yl0yqeWfCg8pg3euOVsD4pPRFsSjLZbBiInbJ4/B4TnBL9o/ofOgTAH6KaMuQ9qbk1NJu350O5uaHn1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTyhd0KkNjqNlkIKPJSYzmb+s9D5pEnNjb4T0UP7BKg=;
 b=Az46/cuR8DbGVCSHajP9moaHZ+ACYiIk4+yorR/CgwJyrKtbrHtYWiw5kYGAuN1QsczslMi79tos1UIUTms1rC48jwVPJC7B6UUGh/FtpCqTQbcdPTjGB7gAqgRfMCv2oIgZZQ7o3YaiwX9MP1UKQZgnN7fJRkfYR99c7P+GC3NEk/FU7wQ9qp5wja2Ci+2inThOyjQPA1bOMAMHku1xWuibGdr7DPyOUuUyrOlzMF3QYdEof4Q8OQBvyHFvJeY9ongthKfBU/xS1mEaH+6nPyB5tVGoyyUDi00HhILs+yptkmZVwcYIUWc2zC9HNuk44Mnz6hydy2ToAdHBeIE5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTyhd0KkNjqNlkIKPJSYzmb+s9D5pEnNjb4T0UP7BKg=;
 b=Ggd5Pn66tZ7RMc9rM23GslHZFKnER1CytyZhXgQGjkTOQOKYVsl8756Db4ujepnbhkxFr3xVPgvJgoLAg1P1cCNopYfsoDaKLCLlAlPLg5+VQxrFcbNNm+HsUYBHPnKfsZb0y5YNAB1iYzMVD/zM3JP7mMa7TksfDXrStg7gLZkXBUZrLFwGTPVm/HyvMwsneosWpZxRYlu+4ePzdxftocwGXnXKQLtSw8ivlid5O3Q4L5aQDlBk0sJRWKnBWD7eXVx6Y0JkCdwB9Y357RW8KpLBrIAuSrlMmDJ8yPOG9v/8IZl110oJtF766v9bGun67wIT50n7bWHF0LesTFqHCQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6749.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 04/10] imap-send: add support for OAuth2.0 authentication
Date: Fri, 20 Jun 2025 12:10:27 +0530
Message-ID:
 <PN3PR01MB95972DF1D2B4E1B74A027F94B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250620064033.15814-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 68672699-8727-4c52-481e-08ddafc56598
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|5072599009|12121999007|15080799009|8060799009|461199028|41001999006|1602099012|3412199025|440099028|4302099013|40105399003|10035399007|19111999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xdcEtCxEAUXZKelgLhJW2UZnUIy3ZrL2fW0oWFPpTLMSWSYNoY074zwMCvhz?=
 =?us-ascii?Q?UhqBlQbl1+0MWyPEu/UK7S8JOM23f+AdUjr5pxw7JdGvV9rZz0MWwtUQpWWC?=
 =?us-ascii?Q?fvLeCCaGKUQDBZRqCmMkGGqQ9NY3ebH3yEpRcJAUJgZQwNvKYWrkTSafCSlM?=
 =?us-ascii?Q?D1gL2iWUsabTkuqqUdfHRXUQwPuwwusmLN9xXRAbcVLeqiPb75am10dnpJm8?=
 =?us-ascii?Q?L6theLZ14rJ+jvciYrQCqRMGmK+DOB5CZhPPPmEqQLmh9Mnvfi3G0OPj5lNt?=
 =?us-ascii?Q?P7JOfJ/OXSFfbfrEdTTNmeDg+qVtJOLKRjqfmVlDBADwtQmd6zeBMqP+72DE?=
 =?us-ascii?Q?vz+uuop0pU8GSrEjN9RDDOARejjY5IMQrFr6NHk+jhUNmJoyWcmFSkww2lTb?=
 =?us-ascii?Q?w6HGdTb3fUcWXGu5rW01NhIAxWJ4w61YM9uulKhZKmmGf6ntvAnB0TR8yZ0l?=
 =?us-ascii?Q?Rf7dkuOOjWuy2s6pxTXkY2n7hSvOqm2U1y23jWVx9TLK5F65JM5hWhCsWkZ7?=
 =?us-ascii?Q?fnAai8RIw1lNwdNPIQXK7eAkoGzuqwGp/uHo0m5OqHsVnzHs68dI3aXiQxCh?=
 =?us-ascii?Q?GuB6mNTs1Iv5K2RYXVzlLxha9Vbrof0U5C12mTOChw7UFUi+w05RyEFz6KOQ?=
 =?us-ascii?Q?r0vc4m86+7SdY61Si9zQNmClowdh6LfzTOmFmF1iULUwOAJLkcanxZ86pqye?=
 =?us-ascii?Q?uUQ7WchcP91JK1/wetvSqh9UknbH4dT5az4Y3GNPI93/jyzRophhsP9+N6qc?=
 =?us-ascii?Q?n/ubkNoouOEIBzTzSqd5UZrAOGS5o6mR8hU0hDg0jWx/se8H9NY0lrZ/bGLj?=
 =?us-ascii?Q?Q9V7cNf0lazUd648qPzkwKjhqQWYyaeZHslEjXTn/c3EokfkLFClVlpLTUIU?=
 =?us-ascii?Q?8zwe6/Iz82E4F8tMunlb5jvZ2ib0VEZLCPpRLVxOt9LgNVkX/S5JntfKUnXr?=
 =?us-ascii?Q?doXqYRPOmdffFT5HAYF0MbDXxDC4CQ3+nhoXHhdkqiiloRng+TxhimVS6W4A?=
 =?us-ascii?Q?fP8osWt7S0VWWbRbb4wcp0jwzwH9InT10yIcgQABRJNqUUsGyRe0OLE7Cfj2?=
 =?us-ascii?Q?aLR332TwqXo7V/untg7vOSrK8mmdFl/i6x5/5rWDIaCmbr85kP3QSkOfP7jt?=
 =?us-ascii?Q?7H/gNmnbpuF08dofinUWffqcPQeWIELvcQbVukEsZ782KE/+NGv16foEG9dO?=
 =?us-ascii?Q?MRPJDAY8083XC1RSUdqwkJZWym3vrCnqjw31xuD7rSEmYydUBb8dQKKg8WH8?=
 =?us-ascii?Q?irXfwtnWE6zYi7XLr6Q4ybM7TOLQDIn8xN69gYUf/zT7ArqnqqgUy3a+DXYn?=
 =?us-ascii?Q?r1PHymS3/rhkE/iveMxnEEIli4GFCCsjao2M7F93Ma3d+7qRwVOWXj7tzZs7?=
 =?us-ascii?Q?b0tkSCY0TL5HU+AN6hW95r8Xln6wRg41v2N/zDX2S9noehrmAQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z08q/xh5qgCyPTUSwAtu2waW2PyIrmP3V7LDibkRj4TFnKFGhPRTkhbgjDBI?=
 =?us-ascii?Q?UQ0q1Oq2j0k3Wud+MHXk+Krb5bMiyDVU4+k+S2vc8vClNKMhNbpfd+BMIo53?=
 =?us-ascii?Q?yen9VkTiUHUhG6dqxTPNiN9UglvP7REcqpsqzaTI/cd9htrEsk50Jyn2NBns?=
 =?us-ascii?Q?uBqOgEMCOOd7OEMcPwO70/EULy291M1ZyMUx62jNNNBVfsjT9zHCBKZHPO4G?=
 =?us-ascii?Q?HXff6I+GfN43jOvYhizkT53ul3U5kCc52LBV6r5MJjTFX3U6UljRvCi0X7nu?=
 =?us-ascii?Q?DOb2vJ/XGcM2NS1r1/j3Rc0boVss1KcXnG1rf6zfU5ZvDnphm1QB1P/nvJXv?=
 =?us-ascii?Q?/XYVZnmerWeNqokip1TbwHOCYcYXS4qCwzhBKbsnTeJDw3BTYAsdAjgLpmQ9?=
 =?us-ascii?Q?qf/S5RgFbvQyAlUXFFs4WxxmODLUBT8XbnbJ3PXDgsOPyKm718zfEeL8qiHm?=
 =?us-ascii?Q?wbPXXIE3bHV1P7pVuzxVl0y08alg11DCSHGRddg8LYxeKFTTLhDX6rxAAEqN?=
 =?us-ascii?Q?V2ZDs02Nw1paIgb11xPzGaiNm+EMj8Wxg/ioX0C8WTn8SRgQ8lGQUyGNy2G8?=
 =?us-ascii?Q?92t+BvJyOVVQng64XkNda40Sw+m7RugTyECztJqLt3J8F87ScoemYMad3ycm?=
 =?us-ascii?Q?ZcUw53OmyESasn1y6pDtQlQB5i1L6KdP5qq/4Sbouy0Yw6JHYy0RJ4hCG77C?=
 =?us-ascii?Q?ss6Z3qf1I/Bratc2dKGdjfS7MVYZtvGPWxqZEH00XS40XvSr/la/YJr2Nt1a?=
 =?us-ascii?Q?nmNJ41ojEX6tGS6a7qzVaOjfMzBjNjt8ySC2e4ZcBfaDb64QZiZMjAg/jBaF?=
 =?us-ascii?Q?JACEiUlwzPTcEnuOym2hLd+r+jQ7gih2dQuMROm7BUwRyaN978f0fJ805dEk?=
 =?us-ascii?Q?g+TNJ803lyV5dMhH7qpojW4jmt/gIfvDY0wrI4YJ0LYg4C+b9wXggkqJZIoe?=
 =?us-ascii?Q?WE7ZeVbhV0U/3KnuGk6Ujk2Y6hebilW8SYxtd6ydnPR60hPds8HPx2GsTusN?=
 =?us-ascii?Q?Jrbr+D2+tj6HE3f5JCISgx4gRtHJ57xaUZcx/2QXENN0hGXQ6n9jYR3mmjv3?=
 =?us-ascii?Q?hIQI4o5xfv91sZf7sePys5J4/2h8WN3Njj1LQS9Ugdxgt99qtnfLep14yfq+?=
 =?us-ascii?Q?JBeIo/UBY4roUu1DwAzgCfJQiqvAP7yp0iP6XWc09Wi0NUC6WUZkAtT1noyi?=
 =?us-ascii?Q?9MN2DWeE6V9dayeSryh0FzwuJxVqd1jgBgdolwDJENKkOwTbRO9oNqER+N3e?=
 =?us-ascii?Q?WN8bdjOJNao9gf3UuYxy7Z5lWYhe7zLHL1RcedQCypAaVf9Z90HNvy8OsiAy?=
 =?us-ascii?Q?oTM=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 68672699-8727-4c52-481e-08ddafc56598
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:51.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6749

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
 imap-send.c                      | 144 +++++++++++++++++++++++++++++--
 3 files changed, 183 insertions(+), 13 deletions(-)

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
index 39013330a7..5a83ea80e1 100644
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
@@ -885,6 +889,64 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int b64_len;
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
+	raw = xstrfmt("n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
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
+	int b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the XOAUTH2 string
+	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
+	 */
+	raw = xstrfmt("user=%s\001auth=Bearer %s\001\001", user, access_token);
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
@@ -903,9 +965,51 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
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
 
@@ -1118,6 +1222,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
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
@@ -1419,7 +1529,16 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
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
@@ -1437,11 +1556,22 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
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
2.49.0.824.gcc76007b2f

