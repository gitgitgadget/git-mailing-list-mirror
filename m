Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011028.outbound.protection.outlook.com [52.103.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2BD433C8
	for <git@vger.kernel.org>; Tue, 13 May 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747160960; cv=fail; b=K37d3fXFjciVN8a6PHXaohtpnjDuLrqUaq6ZFfA90Jq5VVRnfHDpF8zJtyujnqSHOfBDBch7EUGyqyKlVkQJTCQ8EKHQog7gO3J0Jm3+Fl4OXB20oYtUBkyNJx/jgZdHFWxaS20HNbRE7aH1xmzikJOq2MvY5DFAdIpZTMJSZqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747160960; c=relaxed/simple;
	bh=nrJBuQLVop2lhV6OZlBlG2/b4HciC8ljRqohEnvqQYY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rj+GXuJqcpp96NvRbGFAH2a2h8hC9a5lUpVwiG+VACy6kthxTxlJU9C+U6iQ/DN1cIzHrdErYtjpcK1nrYcpEMrOwu6H5/PKMl8WvvDLX7AMKY+uN+2XhBYMA8jZFM+qQl5l4lCXZSZBtCBo2AwPe8v3GmoPwUgPHNF7WKjgnZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=a5+IgGBz; arc=fail smtp.client-ip=52.103.68.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="a5+IgGBz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qE3R2fmCvKlMeCumUS9RPrXn4W4Gw2fyjYkM9FEd1hsrYMI4rrxkbWEwtf9sNG+gP0gB+pOKO7Woo/ClJEMzJ0jwTZo2tJa8N8US7+cTG4X/baTVzeo51TAGksnBppSR9Ubvn3Fmk9bOz5GYhIUv58Cu2Pj7dzRzqEIvYLbuYP+Kj5wBOOXtmGN7iTaOAqLWz9YJkf4E8KC4HE7qnPFvtxcTj+mlRLnOjC2ls3KybRHQH0Zf583pTIdqKwCkOZwxt0YOJik1hGS/KwDy57QFxzeZomyXYy0ZE0wMV8tHLnsiIPQ2ajb0O1EFeNIFUbem4zsR8B92ZsimaV9mORohwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=691k/wuKDXgBC1xdzCKjzKS7Zycavga2SltjtZv5sHI=;
 b=iwXwROb63/Nj9geJUmwalXpiQCh/kLhXpMldChgMoJPwuPeNUF9R+9DoihlIvVIeHbgf76RlRPhNDRWoytEdjQpTQMvP2aBQFtGIj3WGHwB3WVJ+Qr6HIFiAQ8IIdvfHsoGtus39UdPDXbBXOLwu12LIMkC9cqc/TbHjfOHDJeUEIDkitSE8nVN4ODcjCO21z/ObxJxQ3F2mGlK4tAJtNuJWzQJ1Ua2ji1D5zLApBnGoOD0EKqKZzXrrXQDUfwrb3hJpFr12gygaSjCjL8ZYy1rfSgmV11oit8xQpqH7FtGvA84/UgysUnLKCuauXUa4tzp31U2+8zMds9ZwGrfGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=691k/wuKDXgBC1xdzCKjzKS7Zycavga2SltjtZv5sHI=;
 b=a5+IgGBzSb3B/AjzYZyainRHC1CmVh3SoBJeJjJ1+Qj3iB2IN7+F0Qe7+vZWCxdgS2j/BxMcrgexcuqIfzze1foHeRiZ6/FFQek/9PdXQrH4q7sgXOQGcmUyQBkAMGQvGkp/0x7d0l6yPPQsdUsGsj2AZJSNS6XEyG5Y1gIyXFi0Ign9Nsv1s/H3JiJH433jI0j1OKe+nOImvIZ1ugtIFd8LjjIlMPfoe2JmV8JgCLBTy19SubhMXyo4lywjvy2g+EK7ABH4hTky07XOdhTsRKKszXIWLfRJ83ex2cuoQ8x7oT5B9CBRG/7uiAxcPNJbJthdvAhhT7wz+/tQBrgeFw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9168.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 18:29:10 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:29:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	sandals@crustytoothpaste.net
Subject: [PATCH] docs: add instructions to use Yahoo with send-mail
Date: Tue, 13 May 2025 23:58:44 +0530
Message-ID:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250513182844.6963-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b39f4a-1fdc-440c-1908-08dd924c0d46
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5062599005|461199028|12121999007|5072599009|1602099012|440099028|4302099013|3412199025|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z/rZFTJcphgp9v0rkd/nEcDcoIzKRsNDHssnmV4mNlKoafFgBFYSWyawpQWV?=
 =?us-ascii?Q?HW42ZVpj8dZtKQvMdW83fjbGQ9lfGKxyvt9GL4oKYek03q0bj2ovQ106TY2U?=
 =?us-ascii?Q?RVbjttCvAySYSluiupGwIWLrFhZ+J/IJ+UonA/RVtHBM1HbkouoBbsc+i2nx?=
 =?us-ascii?Q?TXfSP+zkzHEDNIsZd5eMkfYSC9K/i+obAzPCxQplUgNjjRfOxs+EEWvA29vr?=
 =?us-ascii?Q?RPEpD2DuZoH6gFG9ogDZwzUYLVtr0EnUWrA+jSkZHvCITBH/IgQvLklSoKWa?=
 =?us-ascii?Q?8e6p+RK3X9S25rSdQqTRq7QFJtGTz1jomrXTJGF5NoSN1t0W1mlbWoDJL2TA?=
 =?us-ascii?Q?x7mcubJhDnrQatLieJQ+q0Xpw08XspLvQgY1Y0+Ofv3lHuI8Yew/7SvMUqBo?=
 =?us-ascii?Q?EYFD8HgnX2H+lDm4AYQKlAj5psRmiojiPp6urP5Z2aQsqG4xTaGyPVNMtSyz?=
 =?us-ascii?Q?UchThfX2nnj0eZWa4mBemVmJzb5MUqSZnrN1jNqRyePetD6zHR+8RwrlkOCb?=
 =?us-ascii?Q?TmZ1cqNcxLTQPYXnNGoIk1f2GO3thyqNv0Xn7lG83/j+qzbt0O6AoTjJDdxj?=
 =?us-ascii?Q?sE7Kz8GelyuaVmAujXyCXURn7NfPLVYc3U/HDXpB1xL8wNGXb41ErGIoGUK6?=
 =?us-ascii?Q?UOtT7HEgFEkxoXZfO4bqn/Qo4d/FKZ6UvG+cEYRiABuWsir6/X8ztnIaOFnY?=
 =?us-ascii?Q?rk26Q6c17Da5HAQtpsbYh0TZVv/kxk8hTL2N0Wrv+rY36F89T/RwdAsHT/Xx?=
 =?us-ascii?Q?ppm9uSHIU9rndTyToJSm9lC+dLRVxgx73ckDmSXpn65iNHcCuqrEBHj6fK6a?=
 =?us-ascii?Q?yiMvYTZx4M1Cp74uILxJ1jTnDhv5q5R5+fyvbKeUFILgWXXWWUCz+89aOkE9?=
 =?us-ascii?Q?sBnCdaw3cMiJRFclyp6K7nSHh7gJCJhQ7BBx3WJw3q0kwvqiLOzCxSdc7b09?=
 =?us-ascii?Q?h2i0R2Bvz4NrqQOJmG8F9bnCTt2LXkP6oszua+SrxNFMvL/aP69KX5KXUPQu?=
 =?us-ascii?Q?ZMGseO67S9+4V8UhmUBR9TxF7z+PjGZOfqjdvyifdjnnXQONyf0D4v8k/3We?=
 =?us-ascii?Q?SoFEXIjadIrw9lSX5uFOHfC3SfYYArknZXKrjcZg2QhQYO90RcRl7e1JK2xd?=
 =?us-ascii?Q?O4tQkpjZgj3OAPpXoox3Pv8pNplsUddlpOl2+hjyp73Va4gKyJNfWA9LQLm0?=
 =?us-ascii?Q?a30BDFrPt3epdHQRHZQftwssXkC2oAHcpEh+hkGbbFtqlGywjllwljSOQ2rk?=
 =?us-ascii?Q?SmIST5rZAZUzHChjxTYIVU/BzmBRlze98I1m/fsmVVZutAJoSou8lZI1jqvu?=
 =?us-ascii?Q?OqBHwaO0f9aNfx5lzG+iBrhqM0Exl33GW5N4uKWujBqebg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VBt3M4jC5wY50+tqZZ+UMNJE5OUe55vE+Y2H2Oq8pci8ZkcFp+lAmE8XuBDw?=
 =?us-ascii?Q?oyLlbVmiKCXRpOmtcd2JX6jQUgrdIkrKpnZg7I6qWtyljGk/rvFeyzvSZghS?=
 =?us-ascii?Q?1bnKnEBx1kiHaKOLL/kr34+sJ59TMAMtjgEo4uz3NXMJOfF1Ft5SCCJvMvvt?=
 =?us-ascii?Q?kyJkYmRdCdR0sfUSvAB5z4OqX2wVyTGtzupaw1s3UHK2ji/tscvwpJa1pdBJ?=
 =?us-ascii?Q?AvRGsutEZSRkWYjSvUr+mAv0WRuU3hdD7i4FuqpvF7pOcH3K/dskkGtVLb1t?=
 =?us-ascii?Q?vyZAbIeuuTmFQ0YyAi5IzJD2JyfhKzuLgH/XmsPNQRfVVzGpEUITNdsGBmKB?=
 =?us-ascii?Q?XPMBk6oy7REiJtpaR8sb2uB0Zk03n/p15z/GKE7v54eLa41O2Kgu6/1TDpaB?=
 =?us-ascii?Q?iV9ur7jT7zBYUmC5Oy/2V5TvxOLaHiP6wy9XYkhcXf/Br/1tQyG9sqjLCZRU?=
 =?us-ascii?Q?S9fdd1pUlxsC4Y3i9sr21oUbIoit3TWZR78UDrSlhSgxNPxuJP6zzGLRiQv+?=
 =?us-ascii?Q?DW2w7D7vIuLT9YCdEGgffTZtgRvmd8yThSL2BSn2IgTJksm84X87mwc+zrti?=
 =?us-ascii?Q?SCaDt+B3tw86d8hMFwTxrwJV9cdeYDiTcWdrT1Dx1Yz87zQI2PYRy+HCrUdn?=
 =?us-ascii?Q?2RR9lkTE9FlFhXiGQK5NUB+sAiLKS5a8xSiNAqyZjwGXWpeQPMOdfz7RKIxv?=
 =?us-ascii?Q?aDYmwkqRUy/VUhKs1xsfrkYU62gBCU7saLO40tUG3PcwDkpeXCU4+Vlj/Mhm?=
 =?us-ascii?Q?Y1jsA1+ufZ8j/vvfMtSzy5E2/ms6WNx6oaGiSpNRgd6n/zwFIckwEz2bHspY?=
 =?us-ascii?Q?zRakPcIqcoZAGLABj6fyRIJQQS1JdsMNeOUN+QCkWm07TEqi/IiR+hKzTAri?=
 =?us-ascii?Q?BdehfRC9SeMmDtq1Az9mQO9f9ON9WqSt+tmxnzl4YMDkjZ7q7RQjVlcQoq35?=
 =?us-ascii?Q?F0wrwjT1N8owewWTtmvfMzh8sLzuwaDLwcQra8P69iMSu3BCLeMoqo6SJXrG?=
 =?us-ascii?Q?duwTCOhtP6f1daVVpL9rqdarTQPVVcqeS9ygH8A/GiAXlgYWdlqhcp3hE6Aw?=
 =?us-ascii?Q?G97+DmX0HoxenUmvBmFZ/WpRXYzBaCnlVjsxJP+s0TROOCwjUpmB7slKQQhx?=
 =?us-ascii?Q?y7O4B45JNwbuble2M3AuLvidgEZ/Yu8eLG3stdLqPJ2eiKJwPuQrGvOUssFW?=
 =?us-ascii?Q?cm/dSZJknkforbJe1hC9txpiwZB6MfyqrJfYjboTprlEQppZTQw2meTTOcsm?=
 =?us-ascii?Q?TORXtp9smgsarspm9dyv2YtdDPKICNrw3LvIPj1xQHs/qqAioSQko7HE4ch5?=
 =?us-ascii?Q?MA8=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b39f4a-1fdc-440c-1908-08dd924c0d46
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:29:09.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9168

Just like Gmail and Outlook, Yahoo is another popular email service
provider. This commit adds instructions for Yahoo users to be able
to use it with `git send-email`. It also adds instructions for
OAauth2.0 authentication for the same, and adds a link for a
credential helper.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 32 +++++++++++++++++++++++++++++++
 Documentation/gitcredentials.adoc |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 26fda63c2f..61a2d03546 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -561,6 +561,35 @@ SMTP server with `git send-email`:
 	smtpAuth = XOAUTH2
 ----
 
+Use Yahoo as the SMTP Server
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Just like Gmail, you can use an app-specific password for Yahoo as well. Visit
+https://help.yahoo.com/kb/SLN15241.html to get instructions for generating
+them. After generating, edit `~/.gitconfig` to specify your account settings
+for Yahoo and use its SMTP server with `git send-email`:
+
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.mail.yahoo.com
+	smtpUser = yourname@yahoo.com
+	smtpServerPort = 587
+----
+
+If you wish to use OAuth2.0 rather than an app-specific password, you can use
+either `OAUTHBEARER` or `XOAUTH2` as the authentication method. As an example,
+if you want to use `OAUTHBEARER`, edit your `~/.gitconfig` file and add
+`smtpAuth = OAUTHBEARER` to your account settings:
+
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.mail.yahoo.com
+	smtpUser = yourname@yahoo.com
+	smtpServerPort = 587
+	smtpAuth = OAUTHBEARER
+----
+
 SENDING PATCHES
 ---------------
 Once your commits are ready to be sent to the mailing list, run the
@@ -588,6 +617,9 @@ are also available:
 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook]
 	  (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
 
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-yahoo]
+	  (cross platform, dedicated helper for authenticating Yahoo accounts)
+
 You can also see linkgit:gitcredentials[7] for more OAuth based authentication
 helpers.
 
diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index b49923db02..0c4fd0e8e7 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -137,6 +137,8 @@ Popular helpers with OAuth support include:
 
     - https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook] (cross platform, dedicated helper to authenticate Microsoft Outlook accounts for linkgit:git-send-email[1])
 
+    - https://github.com/AdityaGarg8/git-credential-email[git-credential-yahoo] (cross platform, dedicated helper to authenticate Yahoo accounts for linkgit:git-send-email[1])
+
 CREDENTIAL CONTEXTS
 -------------------
 
-- 
2.43.0

