Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16698258A
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626379; cv=fail; b=M99vsV2m1zzUfzcIysF8TW+paZ3wbA++WAIZrXNBA/Sttk4nHiE5sz4FWWYhwG1ANItdGH6J8UL6wzOOmCiGPdUdGCR9hlFpfAzCBKAtHKZeoGRqacBynwlenKDjkLAF8Ok1UsQbq4/3FWFIc2APh6KtdNyTnPWJplxI5LiqSUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626379; c=relaxed/simple;
	bh=a9wCBqvynQn4C8eTBg+yVjPnw0YmyzPBO7yw3utFkQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mFzRystQsIXJSw9wPBjjMguQWPIfMBMviXP3DY/aApapy+25k+Hjr3HMrVs/aTCxk3mJpyswzR+ypS6KORhp7Viwkv64vVqfe7ZP9bs2ayn1rRBhLDu925BrVTgaGXURpqKi29mKq48rvhv3/cC4SBlDsMdMvZKZg0S2XGxZnCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hks4pxTg; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hks4pxTg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0L8y9Y1tvcEC0UegotaPhFgo/S9TVXVyXnFIjWRFO+iStr2Fcxtpv0lxZVRSgvTLIUpPrWtrIC6Cw8v37PKAoDBvkGD7ttpphyA/85mbQCifbKFXwLsGUhosuFPOSDBDhXPNIHffYhWa1V+0wGSSS722F8ElAZvw/AUG7h6LFfbOd3b/N0XQ3yIMiNDxD8ibCS+O0EnNV00oXpAG0oZaIIkUzIb0xsX34PS5Bka06eq7Qc4uRx5DCQeFHDKdnPXJbfCtXZRFYILRJ00SrFkMskW8WiuAK/ccF7DrVVMt+YDG+1NseVuRDs9JtzivOT0mRKZB3a9TJdsyDQ/37DU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KsI7k9vcSjyQtfeh7MireMnwclZFRX1dJsjC9rVT4k=;
 b=SuO+eQY6x0QGMpNzSh1APZ3isvnAckpeKrOqzwK5PmioAoF8guVeiP/H5HaLD8L5D4YMHQj520vlk0TmGGnyo2D4ZGhnr9CHA1nLuDzNc4JHZpoZt1zzIlmTZhjqm3ptR/zNhfbHQYocrDyfupGQ48hFUt5Ok5jt2rvWzuMzZyl2n1hbQSjFWemRKGjig5Kvv2qX78RF083o5mPMcXeGkNpr3LKWHP/vMlQ4i3+gmTnAO/cJRjNtQ8SKgBdg8RinDMBw3bPyY/aVjMTpnYMRAnFjhSfy0QWC6XeIgbC6BRmxBxA7mwEU5DNifMxHAXITRcuCASKvg1UUSjxe5rkfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KsI7k9vcSjyQtfeh7MireMnwclZFRX1dJsjC9rVT4k=;
 b=hks4pxTgIw2vy7aKQOM4X1aRPv2lsHQjOdEGjog+nkZT/q3f5WOXzUkNhcZIPq9FpLp8sIncdYrJIaSY6LV9AhNIHqxTA3GvAayDogqO3AxQnXu7zpUaCf+1EpHkejpvXGJxNSOiBXtGq1Y6yKRI0ubpRyVSaYGso8MlDWlkLdgB8IMtpfzCpgUPwa2hKlRTPtnMfcVQ1Om3+EQrIANZ9BkLZ/1oJW+sNe+BXLa8VFObI30cSkKcz+jR30EeRMCqDm9GkA8baUfjo0da2emhbiVqXEzzI1Cs4aRv/DBdyJ+s5EDeoF10nukdL32Sf1hJhjBIO3R4h61rqHmLNhIBZA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:44 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:44 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 2/9] imap-send: add support for OAuth2.0 authentication
Date: Fri, 30 May 2025 23:02:15 +0530
Message-ID:
 <PN3PR01MB9597BD09F7A450C6CA26B421B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g6f2668de07
In-Reply-To: <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250530173222.20211-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: be9b91cf-1fa6-4e17-4571-08dd9f9ffc5a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|12121999007|41001999006|1602099012|440099028|4302099013|3412199025|19111999003|12091999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xrZ4grwmITO6U275QBhDfo7I0JiYhVXJEbrFzqqDSSDUy8FTjvD9aQnS6jjF?=
 =?us-ascii?Q?5c5FN6hts5x4AUt6OusbIR1abU73USAzWm3YBMuswqxugQBBgHP0fppNxLL/?=
 =?us-ascii?Q?lM0uhL0I70u83DalbD6Ct9gPWRm+iEBOHiUKPDxlmTvx8wMrFk7jnJU78f2V?=
 =?us-ascii?Q?sIbJG68qxUNXsgd+D6f5DWAj5H1V6UJHoIgNEC5SzNy4tUj4X7Skp06J4AI2?=
 =?us-ascii?Q?b52fWl1JNYhgi+OIlx/3JhzlGrdAyhbvCvOynoFX7NqqxtN6GLsN0mRJv4O3?=
 =?us-ascii?Q?Jo0DFwQJ3t8Wge/mO8zUfYPYTMvk6CcfDx6onKHMu9oKHpIdjV8E9NUwDxSg?=
 =?us-ascii?Q?naMfd42+cP6ppfpHLIWRDDC6JiXB4loDxlRgBi2UPM2jg1Nt7Pd3WV0d53nd?=
 =?us-ascii?Q?T8l1QWR2ftQOthjgBtrGqsEijOtDso/M9bkeSuBTzqe9KJ0KtK62JAtZXHwy?=
 =?us-ascii?Q?sW7/dPCY0GBHCvf5MyHQlAzFKyZgIlkyXxFlrdTL9CVKBLaVA/x5tE48as6O?=
 =?us-ascii?Q?k6XraFTFX18j7lO1FDdPRArPC/nXf0VeO6j3YHE6m/iQtamGaY2lsCxWhOnB?=
 =?us-ascii?Q?uBmuL4wLGAqsd2LgLYQnRnjVCxxARc0btkEwcoaP2DsQjbOD1fzimhhoCQCV?=
 =?us-ascii?Q?lpgiVIDxUAOCcNregfWH+Hv1OsBPRIoeMtIIZrw3BJ78OsM5EVBPInKTcICK?=
 =?us-ascii?Q?3Ls1KBRWVGD9xNa3fjBUZsQq1g725eboPWNxUOTrbVVDW4o9qpqYjyNkGFRw?=
 =?us-ascii?Q?13gV2IorY3jSQheEStGAup5gdh5XtQJgAii51a9+ce3RREla422uUFnvujj7?=
 =?us-ascii?Q?sqcdvlZzf4nUHAXFor6KEwDsj23YqB7Q2iA0qQBIhJCQ4Y5GKpKJ2TLJbaSa?=
 =?us-ascii?Q?RCZVpwFEb4bH3w0Hi84Q1WZbS+KBuCoLyfPNlnOpaMuFh3dszNZXIUWfwaKm?=
 =?us-ascii?Q?f6A8gUNOYnJUNXXGsvMLeJGEKRWc4ukv+CQmFj6ACB3Ymq1KOtH6pyqZaGza?=
 =?us-ascii?Q?ksTB41uonBiIvMau8cUSU77ww8JWWanAgjUOr2+s4SAuYz3b+rWtx7LdEij2?=
 =?us-ascii?Q?OLHYvlSbjYuIRsioAJp8ZvqNQeKG9zyPB0rCBnrpyD7Qaf3f+gC7DWRC5uhj?=
 =?us-ascii?Q?mwEQhPGr3Qkox5WV55nYizylDkjFUN2iP/NdPYFKvv/iL9NEYQYOlrsJpdZ+?=
 =?us-ascii?Q?ERvQR/xRto64ZHsC1jV4kluLWfSjU06MsPohy/lFL/QMWze0E7ooHE9JCwQf?=
 =?us-ascii?Q?aSmxMQZ66VJdOtpO2KTdR75QK1/YpJgQjQGBG90XoWDvQxRYc5xAHRq3N8d5?=
 =?us-ascii?Q?tT9DfrG17xlyqlP02gcIDDj1JTFMbYeI2tMpnSF95JNxcc0zpfW7DcAlXYTk?=
 =?us-ascii?Q?32mpGnM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJWpLHzqlhbZHWNQRgB79MoCW+AfCmB2c/QBsdjEWnDUkzsvuMZaYirraqVI?=
 =?us-ascii?Q?8xJ6IBayVWKjiheeQ+N2O18SzZt3VdA/o0FYTgB5pXouW9UzygMNk3y70TJC?=
 =?us-ascii?Q?KUiPj+YMmzcagVIZqu5YpCxVHuOfFufuC+YQgJ1hUgSTX/Lx4Ap/NjAY0vkE?=
 =?us-ascii?Q?obK/qiOBZYJ8G/WGiCATqWrbVLXpxhzzm1ghbEb3bZKcDNLsTVyEQ3vufDlS?=
 =?us-ascii?Q?3/7waAv15hGbJtKJGRJW+onGT7u4trJjzFqowJiUbhFnBgmszcgur3/y6jB0?=
 =?us-ascii?Q?nhcjB7oej51HUd3r1QanlDkzr81lSJTqJ1K0WOVpYHm+F/ndSjmkf9FwyBOs?=
 =?us-ascii?Q?Ml5OZwbOSDhRin/jw9AuZ7FQTNJ4MzCZW5ZgZ2s+jqyUlZq+sN1oYtTZMhlB?=
 =?us-ascii?Q?abxsYLQIKj1pjLLAE8hKOsfbTzENKO+0/ym9O7XJc4lbBfnBzpGSRjBKzftW?=
 =?us-ascii?Q?hYel7oozmJfjo+d9VeRON1KD1QTWq4CpSMtk3gJIQ40Y229S6TYRCmzGfUVx?=
 =?us-ascii?Q?OFW0RryS4Tb3oxPRo0Tpity2HDge/OgMmC+fB3sW+7WtwbZYnAWnltkofX/v?=
 =?us-ascii?Q?XevlIrE6Ghj2UzoGU/LraXioIEY76H1tmLxgdwx1GL7of1UyhPZk67edt82m?=
 =?us-ascii?Q?bR8GqvtCIByDZ/PfNsXcr9nqO1g2L23TCxrwGw6BWrHgGrArPyqPTyitYcr7?=
 =?us-ascii?Q?B+/oipRppVvgxXqAVN5zNj102Dkh0HbIOSl2CWdx+5jYej2wSVhhXhgwhSNm?=
 =?us-ascii?Q?yJOUTFx8qOegef+XBfId8VF0xn9MfSEGKFEaq0gGnSD0cHbXIl83DU8arODn?=
 =?us-ascii?Q?IZz8y4Y7DbVenqRIgsuWoCJHZqZVUQ3W6Uc+TTqOsfIwMPJN2aUwi/ZcdiyR?=
 =?us-ascii?Q?BMSjNthQzHI17ywKRMGM6ScstDliGabbLNWTjViMSz5be3S/WpuGgGPcijCm?=
 =?us-ascii?Q?VseEGtvDSjoP8NTh+sxmlbjjkwGzVUa8X6VFf8xVMSgtBuIu84etLswJAOk4?=
 =?us-ascii?Q?w7scjU8Uly6e7z5F3LglSbUnLYXK2u19RDTwp4CPnutbVkUJXu1nrLtEI2Yx?=
 =?us-ascii?Q?UpeQre42Vd+8kDnccQzPJhSfhPp/1hd8DrEGzD7m4QCX8JjY2Bo+GNdhPtwc?=
 =?us-ascii?Q?0AHOixXG4WFE6egIeeRjE39trVCtxlEIT6JKbSJD4QCUZp6gr/JV+sGplNKi?=
 =?us-ascii?Q?ki2aJJHnaSgNDPmFig+rmGL6pQom6AAOyalUBqo9f6iRUAYUrkV4go0s+MDF?=
 =?us-ascii?Q?eye7g8ifKhaMI+c968J5pk7F3G1SrxsaT/zpZxbG68nMt6pB6SZWRK1KWS+Y?=
 =?us-ascii?Q?npKW/Flk53vrE+HKuw0nD4Jl?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: be9b91cf-1fa6-4e17-4571-08dd9f9ffc5a
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:44.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

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
 Documentation/git-imap-send.adoc |  47 ++++++++-
 imap-send.c                      | 176 +++++++++++++++++++++++++++++--
 3 files changed, 215 insertions(+), 13 deletions(-)

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
index 26ccf4e433..08ecb1e829 100644
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
+If you have multi-factor authentication set up on your Gmail account, you can generate
+an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create it.
+Alternatively, use OAuth2.0 authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +122,35 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
+or `XOAUTH2` mechanism in your config. It is more secure than using app-specific
+passwords, and also does not enforce the need of having multi-factor authentication.
+You will have to use an OAuth2.0 access token in place of your password when using this
+authentication.
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
index 37f94a37e8..0c7844aff2 100644
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
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
+static char *xoauth2_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use XOAUTH2 authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
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
2.49.0.639.ge2dd5d9d81

