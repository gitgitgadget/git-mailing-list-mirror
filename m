Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CF25FA26
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458784; cv=fail; b=Q+gqVhytWhs1X45Uk1sTuISJcvwWMwvMgz6UKMKkvPSKb5tSh8c3BBZ0NY4PeWHlgAWyQ1jYsNJgpRUOI3LF5wA1oEH4NSuY4els7/TQwwrCGoJkYolfrpm6Nhm8WoyffLnQlS0+2jcnk7FpE4ZW3gr7eHWR3yEk95E8TqBnIoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458784; c=relaxed/simple;
	bh=49RA/RSq0bxrrzv4UMS2X1OLcvWo+SsQTSCjSCKokLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEKf3ZJPm06dsPbRbLb8CSLRbAY/WUJY/CFzwjulB2tsSw8D0iiMDUhjLyLmeCYVNSIgceZtYUAsS7XDoit6in3d/h0EIDz1DrQjzXb/fyKtVe6cI5dJKyOz4H43g1OdnuviulPs+KDGob6NVkxRqXQ4PHBiVehb08Xx8H69Zk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uA50lYHD; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uA50lYHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SewVDTuSi42MHp6ARBFQVFd7jhf4R/Z7QJ7/0wBpNQSVc3iV7pf3SD6jc/rN+rRwJnXVk2F4f+Iv7h+UFU+t4fKr1gX0IQPML0WULAFflGJZR/lnElcLe3nN9gVkKSkN7Mn3alQHwS6c1/uctWX8q28L8+O8Io2/HJFfTKNUN3Kw3kIrbO+BJbFWDLfCCpF/SksHU2eBEz8EztZlNEbN0Ydk3c5RpuySW56/1r0177k3vXxHKDR0e1oznTe3ywRvX8/zbI6dhthslsFMjDIFQZphQPPaTE6hjhTVfVIK3ZYqubEWNsA+sZWgPFiuG6gT7zGnFHk4VLQjc0di/dZjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIJ9j0ww2Nlci0P02f4K3jk7PNraCtGIxX1wPat4WDU=;
 b=VoIOyWVz0iWZBSJ2QdiRmj79LiZeKWBzbUAb5pM1N+T7pq7yaRaXlZdWpK413v+kRsRoy1va9LTAOZV/LE7oPO54Gj8saIF4Qj8D8JvnltAGDobtP9KpGaMNNbxJUt46rxxFXx7iP/dvSy4V601GW3ZEj5f2se51biPllvB+sivEoY+0ELtVUz3vSHD9dGNjtxnHiVxTEBlrCjUH3W0sXWB9jJtXAmcxJzqfEj8aXXunPdP+SOF7/K8za5wXAM5r3RF6mbprrfSuwT4Nq8KUlwNQQDe+xn+MqV/cUZYbJgVOLQcZkqa4rZzZLa62YVH4NiDEOkCGHdrJbmtMMAkU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIJ9j0ww2Nlci0P02f4K3jk7PNraCtGIxX1wPat4WDU=;
 b=uA50lYHDmca0RByYQmyRd9JY2v6lpO4H3P++Kzhx1D8ZdvzYGLqpLiMMYcJOeB5+TguVlCs9sR/MeVsgmd/9IYaUYYoWteJJXtHmft67PuRcMYVJoYPa7f46gUKvgBQaXstEI4nAqTbQW3GwRGO5LO8pecrdCW8qTiVPbpexBuJH8fpNgb19IMZUnOkwUKsBTEZbPWmZaXgHN3ML3MNT3WxZTOQy9QzOX7Kq83AS3MEKHAbME3TMjwZgsQXEqFVjAMSnwSegezSVG/2MV0DpPtjsIoXBk1d3uxzqmLv59QCiVRziTi9gKE2uk1fzl4qx3F2OUQKuMmOVrFIvGl39fA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7742.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 5 May
 2025 15:26:10 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 15:26:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 2/3] docs: improve send-email documentation
Date: Mon,  5 May 2025 15:23:04 +0000
Message-ID:
 <PN3PR01MB95971776178BED3516DA03DCB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250505152557.4937-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d89bdc-bf11-4fbc-4351-08dd8be9298c
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCIrg7Fom3fEx13vdUJ0IZEn5xYUs6H1LqCNkm5sbtD8CU/LpfBfrXXfh5Q4CSxdHbaOLjM8WCEr00amCiKz5U8iklgcIIykHbHOeaLsxaQUhu0iH6Yb4UXf+WAXcVC2mq4XjuU7i+Ipw+3zRgBeE08ynLn3ZwYd17RLmVtt4nfnX98BQwAcCfIZCPr7BYQt5bossC9jcSTJnF3g6eqfi4Lbp10WrMJFkpVb2CshD8eMpkYr+Qk445J/afKE8tiFdJ4U4aa86VlDBOQJHZpEU92uDahyJgTXcZ+kg2X+tF/OS/nQf/Sjq+5bcqpOZCTHbd9Ac3sM57SkThI20e/plC8jmTbp1gX4Xo6KNOaG4dUHfPNtZ2LibL+exhwOuS9OeVlQ0caNdVF/+TPiOQlYWXr7lRF5IF+LzmEaI3B41BoKxP+vbw4v6S6Rqnf+GX2YYKJlZnLGpp7q3TfrA+1MH0FMvxH2mKP0mg2xxz/6A1fAIfPFvfXKMtoHuzDry4DxdcMb/e5Q/OcvzuuMPtXdd4CSIDVnep8TnStkbDfGtw5KYT/Hc2dDAjlr8oHYX0onSXeEfR0Dz5mF2CazQ5zTQiElyOitzgP5wFDkD+lD5VJtpZc40mgAxas6If29tp4pSEV/ftBPt2t11iNMT7YMWYz2FQ0wpMrJDwgokgSh4g9dOyHqVjs3dgVkqWS1AEdkcNqbAEStIt2SwKtvjVUlKAGhc7P51bbBgeah6X7rDdYcSqENobFDWrlcoXH9OCmR8Q
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|7092599003|19110799003|461199028|12121999004|8060799006|10035399004|440099028|3412199025|34005399003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbBz7OHgyJzhQPoox6Vi7A/tNFSdUXtNvXacFYhhmMdzx682f9SMMr2kOACG?=
 =?us-ascii?Q?sFb7G9ZIZ+KQvtLWppXeLB27IE/cEbpUb61TFhk4cp/g4NDuBpkiy1LFPht4?=
 =?us-ascii?Q?Y+gWMMRi4mB8rWZN0SIrnwnJG+7Dvl6+MhE7la54zArQptjNkRe06XeaOCCi?=
 =?us-ascii?Q?U8LuzSGz62CrkevmssOJHSEtIi7Tqa9/SFZdNO8AVzKqLYw6t6cic7aQ9jph?=
 =?us-ascii?Q?9rAQSj3O2B4gjYmH6+BNyDZFwEGeaFqsZxg6alLLCzbc7ofu0xR29S/K/x6l?=
 =?us-ascii?Q?mwnOD/W5wwaWGNxdkC8lJxxu8WqEmpuqXFtNynU8T6oeOr5C/4GElLHds/Tp?=
 =?us-ascii?Q?sGgsrOm7YJDz/ItXMTQbm9GiWRigbkbR2FvwN5U9gboYHkEmun6q2KQXy5A6?=
 =?us-ascii?Q?3qK0oLUZVoketf15HuutVnrTRLVHMDIchJHrfuOAoFh4HeiboFHcKjwqDyHe?=
 =?us-ascii?Q?LRjd+Wby4bxelLziAITaEyIMtxsU/a4VMXTqEvNP8uIWQhyP3SabVBVMVf0p?=
 =?us-ascii?Q?kN6wsOhqqo6n2f0rGSjNRXWJO4835oeNSd7uGJNiWmBxXb3QuWHP3hcroCwG?=
 =?us-ascii?Q?HGkzmdGRsAH4emwWn4+wTtSSjrxjZhztMvu3c8CqPmLEU18N8q7lUJwuW+cZ?=
 =?us-ascii?Q?eQLNoyqNlSXHlWX9YYCban6j8oSvLVIBJUJa+rC6cOSERnht1iHNx5xn20m+?=
 =?us-ascii?Q?0NVvlFhuuv5J3grTv7mxNYx665Sj8KBj9He/GJgzIOU23DujM2Y6yW8Z6z50?=
 =?us-ascii?Q?ESdlgc/YtAm3kyMdeS5F7y8lDxX+g+VJhz340EGcJCkpxLoLIJWRa7jS0XIg?=
 =?us-ascii?Q?4zZRHwbmn1HxOzLrPSECRPBS3bIDZOpEL6BUcI0AIh7kDcCfHCD2fJXXZY4y?=
 =?us-ascii?Q?yZRRQ1nCN8zl+UMJ1ytQiFyhBm04MExSWAm8MFA1wVWYRAuHeTPBs5K/eLeQ?=
 =?us-ascii?Q?JPvikQbrengbMjm+vah6fZie/NQNXQ7VdUf0PvR6WvCXJGEZi54RR8eYjDaA?=
 =?us-ascii?Q?WTM3DsL9N6FGOpYhMVFmIxrWFwpULjDID67QlxPEUkPSdseYbPmiuO8R3SvK?=
 =?us-ascii?Q?jYFybd09e76zo9IsYJjDIhk23YHIQ/hiFb267/Kahmvj1ZAcTlGD9R9/fWLt?=
 =?us-ascii?Q?IwdpdH1vl5Uq3V+QJWSO0S0kCWvTrVZWSUilqkMqKNLWnT04lUT4dP/590KN?=
 =?us-ascii?Q?FB3oB0DplHdaEFwXhx4cTms7sMvEBkp3qzPJeqIMPWXkmhDCAuMnNDFzU9b6?=
 =?us-ascii?Q?ED0Rva0H8w5UY9T6CgZf?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EwaIr4YaVzFWjWbw0d/ZkUVlRm1vNzxr2gGfm/8GJQcpEztF8aWVDLBZ6s8T?=
 =?us-ascii?Q?sS6MyQXitY3YzFcuvcQINkB8GL44H+u95YkUT2r07Mmoe2PkUOyIMm2KJ/7b?=
 =?us-ascii?Q?+4bTvEprBtobjyC7HAzcPnysOjVtCEcYeBjwm+l1c4cwxb8ER4tNzLR8ldfk?=
 =?us-ascii?Q?GokXpyIwG2XX6u5cW/viNoc9i87gbcj7aWQ8oRKFZ1kA5PTblqG6uAQMVDr7?=
 =?us-ascii?Q?2Ab7G/rmW+YQJhLgBjhfI88b6A7d1xPWBJqSpYjftiKyzjjaufPXs32RMQDP?=
 =?us-ascii?Q?WGPC3RXzFNVAguRWdqKNzWKSHefPfooTw9vftjKWLyUgKJAsAo6jzDgLOFaD?=
 =?us-ascii?Q?PLgAqDkRTb+tCT1Z774nsrrVI/LQjkHI6XczBpyGzlCtvlN/fTF3yDpNHTPU?=
 =?us-ascii?Q?+lgbbXE4o49VtL0lZYMt+CyHHbrRPC+A/eTnan5y7fX/ytHhwSfN2BqWhaRf?=
 =?us-ascii?Q?h1w3yyxn50YaEBTT6c4l8OV5jwtIx/y6TMyPnJVtM32iVbET+Fy+VsPEAU1f?=
 =?us-ascii?Q?E5tQB5UqmvTNO65m+adpW5AaHbTxbIFkZIYBtjV64+694RUJZ0TAhsATVcHx?=
 =?us-ascii?Q?1P5wtoAvGamN/QpafjGd+BBxAif3QA3fGpI1Cd5VkvKS+3/WIHOrGk8kSAtb?=
 =?us-ascii?Q?sFQeS2CiEiIm176bUW/vuIWdoCWcN5CJ95J2PDAN+rGz4IU5Cr7zkHfq91Bv?=
 =?us-ascii?Q?uPSdp3NsTSMxTIjNY72YnuqO/Y1LY/mYtVnDI8v7ydAOOEw+RNPkSZ1aW741?=
 =?us-ascii?Q?q6f1pu7mPhBwITCsTnH1ljFukhZZuhN5RBgRzIyXISeVWfBDgCml9zYyutVK?=
 =?us-ascii?Q?Y1nWa+Z10GxtwCnLUiuKR2C2TCP54X/Lkqr/50dKTL/kJjkQFs6Dv0GUan3X?=
 =?us-ascii?Q?K9LGLXd8G5ak4qQqF2hmH9fCeQEiw1sR1g9rf0GFw8jOi0EasMTwy7u4NOhy?=
 =?us-ascii?Q?R9ktMBFbM75mwinbH6isT+2EzqHX+XoU5G1MuT3TzSZjFULm6K8D/MpadJ2h?=
 =?us-ascii?Q?JoKJA4PyB3IOHP0KuF1uKhNRXpO3Edc2iMuhb9q8LPqVzpe+207otQGpBXe7?=
 =?us-ascii?Q?uI3wFsS2hNKaSg8v8hbiJm04ja5VZmN99+/j+fYreMva/bTd61gCudApuPO9?=
 =?us-ascii?Q?5alZZTkPlTYC5eqF8XBccHiCVm9k/B9rExWDe2aDxNp+nfklHoeVDVJYv/ho?=
 =?us-ascii?Q?kSZTPZJyHa0eDasHRvCk6uMNX6M8YHpn0aRZgebrEEim3xOdnXJwcjMd7/E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d89bdc-bf11-4fbc-4351-08dd8be9298c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:26:09.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7742

This commit does the following changes to the send email doc:

1. Added examples to use OAuth2.0 with Gmail and Outlook.
2. Improved examples to send patches using git send-email
3. Added links of credential helpers for Gmail and Outlook

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 106 ++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 92389036fa..f30f573209 100644
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
+To use 'git send-email' to send your patches through the Gmail SMTP server,
+edit '~/.gitconfig' to specify your account settings:
 
 ----
 [sendemail]
@@ -528,17 +528,97 @@ If you have multi-factor authentication set up on your Gmail account, you can
 generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
-Once your commits are ready to be sent to the mailing list, run the
-following commands:
+You can also use OAuth2.0 authentication with Gmail. To do this, edit your
+`~/.gitconfig` file and add `smtpAuth = OAUTHBEARER` to your account settings:
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
+Therefore, OAuth2.0 authentication must be used for Outlook.
+
+Edit '~/.gitconfig' to specify your account settings for Outlook and use its
+SMTP server with 'git send-email':
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
+The following examples can be used to have a basic idea on how to send patches
+to a mailing list:
+
+If you want to send a single patch, run:
+
+	$ git send-email --to="mailinglist@example.org" HEAD~1
+
+You can also add `--annotate` to edit the patches before sending:
+
+	$ git send-email --annotate --to="mailinglist@example.org" HEAD~1
+
+Multiple patches can also be sent. For example, if you want to send the last 3
+commits as patches, run:
+
+	$ git send-email --to="mailinglist@example.org" HEAD~3
+
+You can also add a cover letter. It is useful especially in case of multiple
+patches. Note the use of `--annotate` here since we have to edit the cover letter
+before sending it:
+
+	$ git send-email --annotate --cover-letter --to="mailinglist@example.org" HEAD~3
+
+Versions of a patch series can also be specified. For example to send a version 2:
+
+	$ git send-email --to="mailinglist@example.org" -v2 HEAD~1
+
+You can also specify custom subject prefixes. For example, to have '[PATCH RESEND]'
+as a prefix, run:
+
+	$ git send-email --to="mailinglist@example.org" --subject-prefix='PATCH RESEND' HEAD~1
+
+You can also Cc someone like this:
+
+	$ git send-email --to="mailinglist@example.org" --cc="someone@example.com" HEAD~1
+
+Multiple `--to` can also be specified:
+
+	$ git send-email --to="list1@example.org" --to="list2@example.com" HEAD~1
+
+Similarly you can specify multiple `--cc` as well.
 
-	$ git format-patch --cover-letter -M origin/master -o outgoing/
-	$ edit outgoing/0000-*
-	$ git send-email outgoing/*
 
 The first time you run it, you will be prompted for your credentials.  Enter the
-app-specific or your regular password as appropriate.  If you have credential
-helper configured (see linkgit:git-credential[1]), the password will be saved in
-the credential store so you won't have to type it the next time.
+app-specific or your regular password as appropriate.
+
+If you have credential helper configured (see linkgit:git-credential[1]), the
+password will be saved in the credential store so you won't have to type it the
+next time.
+
+If you are using OAuth2.0 authentication, you need to use an access token in
+place of a password when prompted. Various OAuth2.0 token generators are
+available online. Community maintained credential helpers for Gmail and Outlook
+are also available:
+
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail] (cross platform, dedicated helper for authenticating Gmail accounts)
+
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook] (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
+
+You can also see linkgit:gitcredentials[7] for more OAuth based authentication
+helpers.
 
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-- 
2.49.0

