Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5D2868AC
	for <git@vger.kernel.org>; Thu,  8 May 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724702; cv=fail; b=l/sj0NX2NlJ0pxipGv2jbu9Vh3htwBDD0hDBL0zKrrdG9XU/sRSP2MrDazblCKLa/6CciAppj1cLl2m+iIoSxtJYWMY+Dov2+MZgKC30eXnBWrfcbk0UMBxSbTFWvU5zkmPKOfMgY90qDwBZciZ27ozyd2/uyXHkI3qzY03ekLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724702; c=relaxed/simple;
	bh=LsMdusoc1MiSaFeRRo3R6FEUu+kkiBhsNvdbYZcT6Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b7nur3EsjT+CvTC7YZQNSVUMxa2uOP6d89rCR75d2shYJwHt+H8Ms6Lw8vW4gon+B6I76VYCENGBNsMGud8lJdBfQF/6obwySGAdYT0VxihRXPnQL6qeEbqHI2um2XmLRStLRcTBqSTgfqK5plHX7BCK3tjaSX5ESFeXpYSaTAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=BFp623LB; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="BFp623LB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZetAlhAb97uWSvzLITC9wQwUge+D2WiBvGM1+QHRWL4Qf+L2mTN/osI77rzb6HNSoimyRBlVsVEiayhUj02U++H5SJUmoekry2zmD9Yrr8p1Ti0IkLSnmm4xaGN/8h/s0VZxYVKHIYnsuzgANheJURwcC63iWU62XkY2ueiV2Eg/0utg6cy4u5gIBfFPm2OfI6tt4rNneC03UqMIQybZmUKIGS2Chd42ymDXzZ5Jk72fDijAtEulD1/NoBKgIgsdkBc5MOMAk3vFTN1p3dackeiONAKnrKw0sHd4TbpI2lKmfAtVZ23FiOEESw3JT47TPCwy1fhZdCyggcZPSxOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6ws7/VyYFrmZTwQ2HCrIFGjUbNIKcAK4N8dHgC2cmw=;
 b=YE74tC0GzgSF0s8JK4OpLMh9T3DKdcojeFLGTNJPOzao2asH4tzFI4Io8OkIPwWcm2r8l81cfUyosSekSGgYVvh4RLkA+q72UPEnXS9/FA3ZwIQVelvWXqrb2TuRCngr8WlBhQ3+Ly7EYqUSGt3+pLVzo0ybeVudDnL30dbRCSVHwA1EGIOOSAZyI4dn94VIQvOzY6a0fRiG76X4WPCsDzv9iHblEUUSYhSnyx/If6z4MuInFGOgvllGoDZ2tSDobLGGSINuFAnBBOn+GNbtlR+LQ+FxLYRkGrUmuwkwzCTHFw25199AGHaVnOsaVXcViZTUgUhKoICCiBvgnrq4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6ws7/VyYFrmZTwQ2HCrIFGjUbNIKcAK4N8dHgC2cmw=;
 b=BFp623LB0x9For6YFBPOukLXIhYOaDmgu0xzd7HqAh9pNabm1nhsjK7XVvVqyYiBnM7nSPeBshCyGQZU9Pfbs/vofVcByuUixge27Aeprl1RiQFlaBGwlthCGd7I/db3wscHk5lhtHioDNzGw8tctCswj8w7PnPi0170Q8ApNEF5wq+S5rVAFdkDBk5eNLstLOit9jo0WvOVjp1fTdijgE3e+iKgJhMeHjRoMoST7qge7Bv8gp9hChHJTH+Pcy0TpB77Z6xpkKcB6z141G9p6u7hq4i7kJsV4vaRlPkbAh8tsJUX3PYnLr9cUr/c/5hmCNyZa3qSS/SZwd+s3OhheQ==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB7253.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 17:18:11 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 17:18:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v7 2/3] docs: improve send-email documentation
Date: Thu,  8 May 2025 17:14:28 +0000
Message-ID:
 <PN0PR01MB958890D936BE35C2D7AF1C85B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::6) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250508171758.19119-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PR01MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e568d36-d3db-4c8f-0085-08dd8e544ebc
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZlTCb19IcwxWRBJYK03wWzGLNKCZYezGU/BuXYfF9vCcQnKKgBJZoVGVOZUoQD2nwg/6BwKhZcxCsknuiOVstiYGxpg7WN2oeSg/BZQa5Puygy+gaF6T0CKFDdFzBvCGHrSjN3F+7NcxcSIDQrEygmn5NWCGXegxxgPS9NXjewW70BFWP2eVYxvn8it0q8OPGoIkaN+6uU6K1FnoFCkpG7mIOL1ZHfMMzTQz5Nk+SZ5QLiqY3KVdMdfQwQlzcBjUiLmlmTF8We+BG01l5mOfXpT97AqDi/5fPe3GZG0agl78Yq4jMQYGq2oy2O+zIW4Lgb8l767azUUjTIum6mNmUla6mykLjah3ZizudM+eBxAm+qbVIRnc4HIC11n5PWPRU5zmVp97BhLJV1DyZAPQlS+OoNe6xXtm9iNBNFCasA9r0IxZFs85R7RKW7FnAYlm5p4EQ2MUDYKb+4k2qxP4++THQ0ocuDCX3b+ZJgPhPA15fxYUjX8K9P7hKFvXJC5FTSEHtbxs+wIK7eDw0gB0kZFsQM2A3crvSOPBfUWlkdn02k5A070eTvBYOFKc5SkbJzf0upCeImEfaG5B9GnKyOS6sHp563GeYyER/nUH0zMQf5h6TLP7lfBrhnWhtB21QikTT8CMnEOcnlMBH/f318ZXDMsOC7eNoOQCSKBMiyu58RQg2tvmHkG2k3pJABXPaLVfm7VyVT/81uTLOotuwxVTQDppPO8eTJNFnpOb2sDcL/Epm2k6SzDYZqEl7ffhLDV4+MM0/5BqeECy0JdnHEEpXA/06M0TwEU9q2EUmn8CLY30Poyf5DQ
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|15080799009|12121999007|5072599009|8060799009|7092599006|461199028|3412199025|440099028|34005399003|10035399007|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x5dR8hZkVUChxYTPqIsFh52DsLzNfWdOjsBZUKnsJSTpT5gwuZBRXkrzZ2t/?=
 =?us-ascii?Q?VVyvUzGIFdUXsNrKr8QJSTMjNbnVfdfaORJIq+uX2DWdG72oHPerp5zL0VgU?=
 =?us-ascii?Q?b9l2YJobJ8plhsItfXWgmDZ9yob4w6+B5a2zW7ZaC+FQkpISv6nnVO8HqNcC?=
 =?us-ascii?Q?qk/Az0J8t6R31BSYPqVXSyWt8nTZzxFj5a9IG7F2QCt7Y7qOJKChOXioy3I8?=
 =?us-ascii?Q?pyvN0Hgnuz5rEH96s5AOF1DfhN2FOwnEsdRq5o5BN5m7pu+sy9uQEaWvD1Ap?=
 =?us-ascii?Q?V01mHcG4GVdmJl1OVJaYIvtKoSo0FiT79dyG7oMX2RYY998APHlHEjlIWL4q?=
 =?us-ascii?Q?dG0jnYPrUcJTwEA/lP8BSEYJRz5v9gvRwiPJ7CiK9O52K1OdOrxABNbwgVts?=
 =?us-ascii?Q?QlQb/xQQIb3/w1jUN4yynDuAYHDTQ0lXkr8Yk06UF9G5UkCD1bUxsV7ZtUt2?=
 =?us-ascii?Q?ZQLHaR83te+bnB5heHtT7u0oFSaBDlYM87c+yEW2ZdCQ/sKho/ERBwUtK94E?=
 =?us-ascii?Q?vONvIA4SmvRBXSELKYu/PA3SGXGQ0+Fi9KqziW4mrcdzfg9FiIKwSfi7POSg?=
 =?us-ascii?Q?UoGd0dU0K/Chxeqgx8dE3yoKAS7g4fSoHsqQniXOtILrz47rp+8aPCNYaEl+?=
 =?us-ascii?Q?jijBmVCRJ5FpLsVzYWZ7G/0RM4p3nS7LtzUeuMQ4GKApyw0YknzhlzNtSGbP?=
 =?us-ascii?Q?+JestgQYRpYLm2FUkZH+4kKPffr5+duiEJBl3weVs4tnuUrBtyt65EE+B1AG?=
 =?us-ascii?Q?R4ZUjfZRV5+sf/84rm6TkQSc9v1Jn2wYJi9FV9MbywVdb2xknl4zteVoExJy?=
 =?us-ascii?Q?mCBAIhC6ZALJ5k1/sPUcvUjRm4Zobs2DuwTc/tRHKlIXHG21IxrT/GsuLrIS?=
 =?us-ascii?Q?ncVVl7lJ7KQSBwDPKh2bzFbYwkdprSYKoTHVn0h+Sa/bnjN+hZhiSKPV05+L?=
 =?us-ascii?Q?cX0oDSrgK8CxiinO9smQEcbdRqQPooKI3SdMAj0LEof9djPgU5in4cCtdqj9?=
 =?us-ascii?Q?RxOKTZ2lf00PKaRTRdCX104StbfYqlvve29Gmqu75UrrxOo6V6nQTuf0cJUu?=
 =?us-ascii?Q?2UvCZc1NrVUmcfqn7ID55pasDGTXPP9z05FdkGWQo1gZiGeu/hcm8ZbljpKe?=
 =?us-ascii?Q?sZVP0g1jxHcx7XLGHtIhcNWgclXvOIvG4Y7xe3WONXwbLLYFCH1Xq1vH7IOz?=
 =?us-ascii?Q?oSQkADg/XmfDv7knhaCpEKcoyjJoEKYzhswN/1pYGAhlNMg2FfulG0JJT9hi?=
 =?us-ascii?Q?Oy0Jy1Z6fzBZVvGn+W/E17N0rwjIiaiNuR4PNHGnpg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?30NfoWCryjPpTXcXY9k4QIzQHcxIVkRPGEV9/DH8boFFKEZiDm5OvAwq4j+G?=
 =?us-ascii?Q?LiJOmYBW61jXxyR9XY3mgXVYRzi2+bWdItj1k86TUmupOlmKxj1YcvScZxC3?=
 =?us-ascii?Q?R/c+6aK/GYr8xhE9gPK6i6yIpTOCErsxzKimKaA4cNETbZuYMGkUHno4bx21?=
 =?us-ascii?Q?gABBC+nkrASFS27ItBSmUlQu+VUYRc2yOK9hjF9NWquivr58HJ8ToQheZvWH?=
 =?us-ascii?Q?73buvkecOEzYo3Z33bR7UK/NgCoJpxvrtGK6J6zW7G/hW5x7eI76Sps0RG0U?=
 =?us-ascii?Q?TBlVGOhrwXV7BEHLzKlXlidk3D6ZWx4/G9llt5lYOrnKpm6X8sUFYtixIN9Y?=
 =?us-ascii?Q?QB/Wbv8Z/uNdTxLoOz5sjo9m1HqgKRy2GB+OqKC2jAIE4JHKOXpSLr2lshg+?=
 =?us-ascii?Q?V1kkDdUhXbLroVkqXQMtRz56/6KnyR/n/Hx7torywubvmjB2X6m7l+BA0dXh?=
 =?us-ascii?Q?fuqlIGzc8D7XGVSyspsDjEyn+E5iSKZ7xsoXM+qvbGD3OxmPJVGxStdHWcdZ?=
 =?us-ascii?Q?V9h8tf6t87itvXDTL0M90tzb9mldej99NmUS+wF7trFeKlqzLK8MynzZFGa1?=
 =?us-ascii?Q?MkmEzqHNeGdPbbF3KwtNtn1Y3i/qJGnVmUUyHkct/gOpxoq4Klj4ipH6Em9o?=
 =?us-ascii?Q?OzJRJqjOirWGnekGtbT9cMYfqxMg+sogc4s2YZC6T1rZlSccsb9iXU3q/02j?=
 =?us-ascii?Q?y6+CxfFcuarddZR2Qr2P7U+MMlYqWJ+PfIlsARRJS+WJ8uTPSNzMkjsIrOlS?=
 =?us-ascii?Q?q35kV8YBrh5bPV2MG6c8jKBT0uEuw/sdwt19bGqThKabjjcBShBl++bieBHt?=
 =?us-ascii?Q?QHBod9Zh/rG/weapnHj9ykBLUCuAwSGM9IyuzW30y9JkcU+EucvJ0qfyvPrp?=
 =?us-ascii?Q?fvfN/T855nGbzOTch9zIgbbpkoJ4BksqLDz4HE33eP4Z/yHMO2i2el/PMeqb?=
 =?us-ascii?Q?z8pKKasUAlqClSGXh4sjAZhth/GvB8IYTuhkyCB2Gvp4ZY5EXVqSHGySAofw?=
 =?us-ascii?Q?3MOM1COr6jcrptMSQTP05/IitikpNoTIS9fhXLTq5CgwEgOVZbV3rRwPWrv/?=
 =?us-ascii?Q?wcGidatNatOjcItjJ6ZSJpGHrwqhXmH6XDM89/g8DB0r5XN6zsOdEQ8EN2Oq?=
 =?us-ascii?Q?3wjt5n5sIXZbshygcfW9XN8JQT8vnYHzM6xj8v0aF6Qf99EoWxnEeJebMNhc?=
 =?us-ascii?Q?FtkbMbOa8RC9Cj3sL0s0BMbVSbbFgyWoz/tZ922pIsX30BV1D011gekH0Zc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e568d36-d3db-4c8f-0085-08dd8e544ebc
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:18:10.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7253

OAuth2.0 is a new authentication method that is being used by many email
providers, including Outlook and Gmail. Recently, the Authen::SASL perl
module has been updated to support OAuth2.0 authentication, thus making
the git-send-email script be able to use this authentication method as
well. So lets improve the documentation to reflect this change.

I also had a hard time finding a reliable OAuth2.0 access token
generator for Outlook and Gmail. So I added a link to the such
generators which I developed myself after seaching through lots of code
and API documentation to make things easier for others.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 67 +++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 92389036fa..26fda63c2f 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -509,12 +509,12 @@ include::includes/cmd-config-section-all.adoc[]
 
 include::config/sendemail.adoc[]
 
-EXAMPLES
---------
-Use gmail as the smtp server
+EXAMPLES OF SMTP SERVERS
+------------------------
+Use Gmail as the SMTP Server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-To use 'git send-email' to send your patches through the GMail SMTP server,
-edit ~/.gitconfig to specify your account settings:
+To use `git send-email` to send your patches through the Gmail SMTP server,
+edit `~/.gitconfig` to specify your account settings:
 
 ----
 [sendemail]
@@ -528,6 +528,41 @@ If you have multi-factor authentication set up on your Gmail account, you can
 generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
+You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
+`XOAUTH2` are common methods used for this type of authentication. Gmail
+supports both of them. As an example, if you want to use `OAUTHBEARER`, edit
+your `~/.gitconfig` file and add `smtpAuth = OAUTHBEARER` to your account
+settings:
+
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.gmail.com
+	smtpUser = yourname@gmail.com
+	smtpServerPort = 587
+	smtpAuth = OAUTHBEARER
+----
+
+Use Microsoft Outlook as the SMTP Server
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
+Therefore, OAuth2.0 authentication must be used for Outlook. Also, it only
+supports `XOAUTH2` authentication method.
+
+Edit `~/.gitconfig` to specify your account settings for Outlook and use its
+SMTP server with `git send-email`:
+
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.office365.com
+	smtpUser = yourname@outlook.com
+	smtpServerPort = 587
+	smtpAuth = XOAUTH2
+----
+
+SENDING PATCHES
+---------------
 Once your commits are ready to be sent to the mailing list, run the
 following commands:
 
@@ -536,9 +571,25 @@ following commands:
 	$ git send-email outgoing/*
 
 The first time you run it, you will be prompted for your credentials.  Enter the
-app-specific or your regular password as appropriate.  If you have credential
-helper configured (see linkgit:git-credential[1]), the password will be saved in
-the credential store so you won't have to type it the next time.
+app-specific or your regular password as appropriate.
+
+If you have a credential helper configured (see linkgit:git-credential[1]), the
+password will be saved in the credential store so you won't have to type it the
+next time.
+
+If you are using OAuth2.0 authentication, you need to use an access token in
+place of a password when prompted. Various OAuth2.0 token generators are
+available online. Community maintained credential helpers for Gmail and Outlook
+are also available:
+
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail]
+	  (cross platform, dedicated helper for authenticating Gmail accounts)
+
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook]
+	  (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
+
+You can also see linkgit:gitcredentials[7] for more OAuth based authentication
+helpers.
 
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-- 
2.49.0

