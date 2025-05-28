Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA02459E1
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417935; cv=fail; b=c2Ex0p588eXeONByxrsi+1m7LSSVT5o1PswWmsgA+fozzONJJO85O0KKcdKPAIqThlqrwhsrQhaWttLOGjUJCJYf21HIx2qk/mccrcTN0z2hg/2+ivp79PUWrGDvpyYOwZoOwxz9luqljSA4XvhKj77F8vbyVNCG20+FgmcBQFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417935; c=relaxed/simple;
	bh=TFfDlEZvAeYasS1ybw8nvQabjvXacDOdU6OJ6UkzbP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6gaLdnOeB8jEKHd8kdK9TnyolT7IoIKx7L/FTqARpE7mwxIyLEzj0i55+X12lZUgXcwITTx2u4W5IfUtwy09VV4aCOdiOn//JHrbT2ZzxgG8S8Q22xKgsPBqOavqvlAGOKNGA0kIee+dMpX0YGNgUYbW+mN8basaBxy+gSsQOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=itCGAJjE; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="itCGAJjE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeZILWP1KGK3IGlKJGcT5iRQozMXYoVg4d3A/9C89M0Paf2LJWOe+fB15lwkRuq7IFt9m8C7H5eM/Y9JFvbjaK9js5PSOBwu/0I3RUqUN4Jf5hCDe4676YsRR6Yf//DEkijWN3DQ6Wv8P8Fswni7mQa6ETDK+wZzKuhbtEUkRoPhfOzsy78Z73SoAJUWL2NkTjytnwt306P+AAmjaYtFY0+jBMpWlRbRdNq2tau+SFY9+OT8VA0ridX+LNe0FWyXQUBq8yd+8A6wwtmk3fDw5vjzpT4iGZFBf6lEeuG6MnVC2KkL2PwoMaxhunVOoJNgNhLfx09DqWlvYcZeLd8zDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AcMS5ljEk4YoGBqBzc3wYnwRgY4j9wHR290cD0coWY=;
 b=C3NHCeUXysT2oHYafCVWsKAOmD4JGgCdDI4lEVn//IOPWlfpW0xGygnaIa94lS10Erf7w+l1jDVThyQtYVZU2X7cZTKAalzE3wCYvp6RSfoFEGhXonETl77ZRpcCPaiP4plswapG0UUg1NB9ndbSrvQhetVuAvYK9lmlmDgzrJWsu586Dm3yNKQZDiQgyv7fcq0IVGo7OgJZWWhVSIEflT8COQ9ZAtwktaqUSADLB877oEKJ/LE6KD6gvYMnl9M4PDcxiOWtZ2QOZ/4r+IguYxaOt3DHMrYMEzFU2WUUv+0b8sshG7JElpR+oozvJ5KrkUJVJm9MsMN4KsjpMxfuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AcMS5ljEk4YoGBqBzc3wYnwRgY4j9wHR290cD0coWY=;
 b=itCGAJjEcFcKPl68lvX7+SDcKfIiUhdkLPXj6c42ieGt2RftWXO1ycbwGkXvFxsbp0QTIXf2mlouE+avE/+FMvaQj5OP0GtRN+n5w5Q2BraXHN+yK5pelSzGuPIKYhPTp71Ty4Dhul2YeN4IvlweVM5lYdswI1PAE+V6pMNA6BxeoyHuS1qtAPvwcz00ORaXd5U9YPq9xYZvsGti4/p2P24zgAkcFzWECAMSFwgiHLPM9QWRsiZmJIinUOKnHx4MN4BgyTeqsKYkk9x1JqyWw+zmi8Gc1Gap9n1fEVgvjgseOoDk1ZSgNtKJUwxj5ZgEZTfrHkVrB4pz1aea28LLkg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7904.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:38:44 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:38:44 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v6 2/6] imap-send: add support for OAuth2.0 authentication
Date: Wed, 28 May 2025 13:08:10 +0530
Message-ID:
 <PN3PR01MB959766A045625C06EAC0B9D1B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g4769924781
In-Reply-To: <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528073814.29138-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: cf579109-3f65-4a65-ac0b-08dd9dbaac8b
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQkiZspJtoIFtQLkAHok+mOZYYfOnykZMgdGZ7X5mgcMAXILo+TCEdbQ0qfgcOR8Lm+3sDTATp3xUKpO+qiPrzgpcDoZCO7v5REOEQgFE6Hxgl3ruZJLiEnvGPEPuh1pP0zxzISFT90G5zjV1CBlstt05KF/8FrMa6zM7v4ZRKgZEeHZL/rRtwxjrjYrZzDpQknlZ5n0VvGt1Z2MjjsFBfHUA8kU+aFn3mAIRh8DCEyWnzpQKbRa250o/9h8CZTJ5Gec8mgq82Myir4bObpSQruonbrcG1qDMzIkO52Le7WVwXi+2f6QvQg65/wPBZf6kHsnuJ4ByHc5I1wcBrpP0PsrNz9Dz6hFyw1/cUoqgFRd+p/2CX19k3KDOSd1vCmuB+XjlR00PzmrV7BXFl8yW8fqz1ntSddiaXNf7X+dC/NRunJxdTfab8rS76l84uZ9C+1JvrHuPIXJpLEDytKVD/4+HHfWJuddeanquOGloNvNbw245p9Nk5K3QN/QWwsgJsW4YRpm603Ykm9mZ2rhUkLKNfPHggJ5DtFX4Cj0y7gwa3IO/++odx+wCHQxqN1QC3CmcF8V917hVTCVt5nKrMxODp47C8Me2K+GxhpZu78fnMzgp/BuNwdK9q+v9irEweYjMK6QUrOzvtjnQ0J9vT5nDebFKhq6qwducd0SoiJyvzGl1VyrtxSuhRSjFtu59fpbQpnFjS3meQYMY+Irmufu0w0x23uu0cF0l5XpzNJJ1qdvBYyOagUFvkspKlWNbwLOQDbpMPMMXUCMetyJpSMM9IzUXtX0ZEI4nIbtCNwbICklOxBNzURDkMVCpgcUVTGx4XyD/ORP44tsA36MlbaFA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|12121999007|19110799006|41001999006|5072599009|15080799009|461199028|3412199025|440099028|4302099013|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?724H2j7pXq5NZS9vS5Gk8gWRPJ5DZG7nE31pvBUg7t108YH+L0PSUk7L8Fej?=
 =?us-ascii?Q?i0otNsp5xj5YTa3mShaVQcky6baekEsdHtGH4gtrbD/buNlIpjZOnuE8QAqx?=
 =?us-ascii?Q?EzMfAwHsY80zECg0StQlRqE68hAAwN46iWIsDpaE7dpO7VSolywHPTt5wczW?=
 =?us-ascii?Q?5iNVe4X8AUGPh00J79dzsgC1hJEhWVZJWF5864qaxNaBSTMDlRGBuHNK5Ifm?=
 =?us-ascii?Q?rSHqlwft4zkLoJFVaGcyPoXZjhF+pmsbfGczVpq2oC4m5+0kKAFHVV/TRre3?=
 =?us-ascii?Q?vH1zxuIzPrBCOm5/Fkc+/2xHJsGvyboE8ihLGOmWx+ctHNhgZb+EWy4Qtfh4?=
 =?us-ascii?Q?Z+UfK8o4Zxrjo+Bc+p6gCGi0jgZErXJW8AfVl0PqMrnE6sIcLaJleU7pBxPT?=
 =?us-ascii?Q?W54Q9LV9tJq1b5Jy6s9leJ0tPuJ37wrc7Tpmjl14Y3L3EAOtuszV1sW/PBhf?=
 =?us-ascii?Q?tF2svvUF9FFEvxZK670gptdJYD/0cr7zeW3kIj7ShUGoAbMLpkMsCrm2QvTC?=
 =?us-ascii?Q?vlPo9t29g+dwBRPv6W5DlOhMzB0pXDmJs2NdH4FSS7AGk3f1Todxy/kbsxRT?=
 =?us-ascii?Q?9aR26kEpp/iK15IS5VLxMEKJbgsiE2JcmuSf2cO50GIv0v5KboS097w9e/0K?=
 =?us-ascii?Q?Ya8uyiCq24AXa1xkF2ksVK7Mfi0v+o8DBMgrkNMbgtnBTU6s0mQV3cvHAupW?=
 =?us-ascii?Q?WMoeNmU9BQZZzHS8Akh8TOh6/6bmc2vAeC9pyYxwTX0aWz5HE7xCysRzXjce?=
 =?us-ascii?Q?PXvc4PRxvO4Y0SdjBz5RCQ+KfxrIJ8PNXNzK88calFGgQPAUAE++7HPntuj5?=
 =?us-ascii?Q?NMtdIij4XtKEAUCjwtQMOYFi3Y9ZIixL+A1om2IUssiySU9CJaUnwCoQdP6i?=
 =?us-ascii?Q?n7NVM7IAFCJyHWtv1ENMgG6X3SOGiULawniVSnpaj0G8WLzW3MiGHiM8hbHq?=
 =?us-ascii?Q?uWKU73wv1Qbi2lVEzaGM2vMtnkEKusCwugUjvjyutEErVBJ9S0nuRyr6YAut?=
 =?us-ascii?Q?NCxKvKJCOmMhNjWN99/lFPn+iF+c9IP+HFRMpP0A6/vKO1r02pRrQpevcI0Q?=
 =?us-ascii?Q?qNc1uC2dbwQY9/R/L+9Yo97NYIkYGkbjUbgPSiXuz3/X7EgLVXhrAJhv7rTq?=
 =?us-ascii?Q?DCPVn5zTXdjAdcZiKh3XcHxCwNl5+q6Nu73gyZexoNfYiEstJPIfKOxkrU6n?=
 =?us-ascii?Q?y7ULdFFtfSL34HB7LZO/Lw0V3A7vXPUhvoUAXvJPI19mdwxoug9r6VspKEAx?=
 =?us-ascii?Q?ZI7B3zSkFlw0+slQrN3PKL+1m6Efu92JFLwLch2U506XhM8Xi2nCujPzBoeG?=
 =?us-ascii?Q?m55kbW+HWpb0Vik/4e1dm/upkI08S7KG8ixPHuQjzzxCXxEoDuKhtjq6EUlJ?=
 =?us-ascii?Q?hytugN4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvSypbNyGF9N7HHgFLulgZA/8cc81Ncp5O4RwuRMYP+p4F3DIQbvcUSBRizs?=
 =?us-ascii?Q?4Q1+JAvccGv/B5X3oWiX7FFYVi3LheLj4OOGt0IGHTAn2vjRyJalnQAvM4KN?=
 =?us-ascii?Q?fjF7zh3+b+cQepHE14PwB27GCb7VW/lyIutqqFguv5i6O52hP4u1Ac8ctHW1?=
 =?us-ascii?Q?lyjvIPlM+/JVahYvLoEG+n/n4J//Qc8jI2DyAVhYia0kDfsfp0ARNMZRDWoM?=
 =?us-ascii?Q?gp9FmxOJQjx4BjbfmKaUOBfFrjDGG2RsezPOtm3Q3zPnb9NoiRSB6y0XzCXj?=
 =?us-ascii?Q?LhY3LKTGC9eOKoRay2i2SgmoDHK0onycUKAAoQGlgNLv+GTiN09NNyw6pHNU?=
 =?us-ascii?Q?rxXFBEW4JFoEG82BubC1RxlZfh3DdeQlTti2iVbGZJ+Z+sAvM+Vs2wYqBmhf?=
 =?us-ascii?Q?LaA6r53yfN7SDu4i1p/hmUXmDpcdtjiKpxhXzIdEZNByJEvKRY0NOXXIps3G?=
 =?us-ascii?Q?i4e+HABT3ySjzpSwK3gGakupRfq41Tz42YK9LL3LZDkkC39/NHrQ3O7Utb00?=
 =?us-ascii?Q?awWleG/TDLTCF6chuSYYhZusfWkqWrSOjn8oB5FwSXxO8y+OMRNDSB/bTSdl?=
 =?us-ascii?Q?RhvDdhp5SViqVNo42Nj1dphn4KkDQO2WvV6h32oAwOLwXhpdtFuNvH0RQJJZ?=
 =?us-ascii?Q?4Yx6ZG4YCiLb3TKOgrDmcTko8x/hUMjojKUlgmekBMcD6N4Bamn1BHaW3ntK?=
 =?us-ascii?Q?OmIVBubZpx7k9vsi1pzFuwqy+bxi6/gEuQMriwwhzeIEMCvJBt7HI85Xn/Ih?=
 =?us-ascii?Q?zTFwqSDR9r9LS9XCFT1IB3QBee2B28SBF6ZyQCXqnM2eVqX0wK3QPWcOK034?=
 =?us-ascii?Q?Xg1anb/JbyeoeHv5/oLeAAQQt17wOdcUdjTJsjnjvsiN9Ah4ftF3Emy8pQig?=
 =?us-ascii?Q?+nQ83wAqJeFexkVDK9Ww7C5G4SIudhu5vKrKqP1Z5H3zUkCQyaGP1VWhvsnU?=
 =?us-ascii?Q?Y9hU8Vi4kRSnb4R8Cyq7dQnwmnRyvasxaxolQDJhfZrxhi2qNdymDJH7bhHS?=
 =?us-ascii?Q?DgzpZ3mjN85zKooXKLw5a90rPKdTZCJYBQToJWGQkGxLQKhfCVA7i6o5f8GE?=
 =?us-ascii?Q?AdRhy9q76FQO/w/pZ9SaHCCYeUBMk/i3PauqytP8iz+O4UabVjW6Bms6vqcV?=
 =?us-ascii?Q?y80DEb0YS/28tgUiBEH6l4dnhBmxb8N9SaS1cLk2c+oIhSKSXbIrJ0wZiHQS?=
 =?us-ascii?Q?e9vkO4LWi/W8nNq8YwBqiAbKo8cKvxb0R9fXSwOKt0salXVt7WeXxMDCyFD1?=
 =?us-ascii?Q?K7h8wGT57a2VRpJ4IQF1KwrsMQlznyCqDq+9pLYjfFGqUVPzyd23jFWPJRPY?=
 =?us-ascii?Q?6Hw=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cf579109-3f65-4a65-ac0b-08dd9dbaac8b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:38:44.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7904

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

