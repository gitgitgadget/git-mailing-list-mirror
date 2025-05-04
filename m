Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0A1C6FF6
	for <git@vger.kernel.org>; Sun,  4 May 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746367120; cv=fail; b=NKS3X7jdPPAeRD6GjUbpe80rMa8FR8oEB7ZtBDZ1XpWU7rtOOvRbVH1qJdvkHKiLIS6rUk3YCJUbTZTbMIgwO0p9HABubo38ZWIp7pNVpehir6DYGsIlTylsW2/yrQoH6taYCdUzQBPXedQm2bNC9I0N6Rs2iPxSc3rHllsihvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746367120; c=relaxed/simple;
	bh=cER2DPxh0VGkMSln8db6s/tU3ViIZUuXvzsxiUgWaU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUn6UBD2mO/9VDqUXuEjiZDEoU6dDzAC2TQ7H0AiGi0egshiCLefmwol5j9IkLOMyheLmd2FX2NYoQI6/3sVKn3wP1b1hWbWyMNBF97Vi1RqSqICb8tgyxvVBYiN0M1GkDJKZ6jxUU9xoX3+MEO1jJg8hCxpPDfWOse7duUrKe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=OVkc2wII; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="OVkc2wII"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfWqsactjbpXH0e8a3MGTCHJSUOBq8PWfB6x5AAMKl10SMD0rJvIkOXQHI0TE25zYpmLvaHLo8n3f3Fa8pGHMzGE7Yzy7RWoIL0N/N29hKJdz+y4xBlfSGjVVzDJhdZcfN+GFbNIGRl4jclwcjzKSH2mewrrxQBR1tEJogJU37nLm1ZglNXqwBR0bYrfsVtHMK2wKb46KOFm6H21jkYY0ZiJbfrR3xNkYHwW5+E5V+SGJfeZ+rdCULZ8W1B3GJp4+l+7RZrRVC/nJCKAjx2CGT5rMlocR7Nmr9u2asn8u8nXiXylVU7idm3PnHKXBHZRMRqTWJrLBdCCUnEtD5PIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdVXrNMxKzBNBzDECHONJ8cvDRbC5sJJusUa35iUFX8=;
 b=C6/ipw1lq6BJuqqpCubDuZOFYUsdY8qGt5vHkpQcbRlIiSFKIBVPODzIBgywYmrytfSytO2LdHKPhnbp159Z2ikq/+a1KyhgyYzBbrWDbj2+Hrusn3HjpE8tqL13XIEP/El9FXWLyUSIy4d4rKtMuyM+4My+7XnFK+U6LSERDXHffhIhkeKmN5Qilx7p0NXe7k3PLHM8INjl2gYuo9Tfw0qVd3WrorI0H06pe/B6DWCZcBafak25xqCY6dyvKJNJvElHBKOe2goyfoFHnnsLwf6jtd+BROQBQTNpHKc2X2p4C+SsbfjoLJDv5N5CZjt42kpTtruBgJRAxq7+3W4MIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdVXrNMxKzBNBzDECHONJ8cvDRbC5sJJusUa35iUFX8=;
 b=OVkc2wII8qD4yatRusY3A1zGDAVfxpb5/ARMEU7wPzLoy2ReIdEun3N1mmSrkTXQ+s7/rwLDwHwMyOq8ftJ+Bs8TSZpebcBjg+qaXY6IBn5y0+07bEooxpfnFfECwO06ImDpSHI5zNMtw152667qH9C0InbCyJgTe400IEso5YXzWxV/M1Z2Dqn9V5a1jzjzghIT8viyxacyTEf3+MF0UYmTo6HXszVMA2W2gP2h+mZ4t2+a6AS6qFw82FlNfA2jUB4ySQt11xRxcYpNqV/RlzzlOlsUrmz5j8mybv/CfAxebmtyLzpvpjs3soqBh68s4NK5kAqOylqsDgUJAfFTVQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB8169.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Sun, 4 May
 2025 13:58:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Sun, 4 May 2025
 13:58:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>
Subject: [PATCH 2/3] docs: improve send-email documentation
Date: Sun,  4 May 2025 13:54:57 +0000
Message-ID:
 <PN3PR01MB95977D3ACA96D04442960136B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::20) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250504135816.6575-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNZPR01MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0bd454-d9d6-436e-a227-08dd8b13bee2
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCokkZT/LZchcSYGADQr+mUcSAhiRJWoo/O046Rz7jfCgsc+lytpBlOopTIJNtB81YaZOISxmvgA6A8DMMFGlGqbDhATHcp9TgVpNrrHIDgQUp7dyheLpxI2oad8jOyE/0MJgRLg1SNhNZJXIIQ169YtyLYoM/wxNx5fgJa4ctyMXI6yZFAeOf1UoQaf6fclGLsCV+Uv8mzrhsHZ4jneKDI80x1oHRwUYYNrk1DdUrU5wS8zPJ9qzzC/6RYMq2pOVcpCKHJEvxYKanw0nQeHjD7mvczfyfXK4BeAPycf9v4L0mame3iPqzrft9i2p+xa7t4dQlqueBLtpB8vncZUMJAFYJ1uHbgF5UySgRBG4BGnRPqmmvaoVNPKyIXReQ8H7k+2jD8pltaW8CA8/e2lKwDaTKduTZ99Zkvy6XClGzRCR2Qjp8KORd0z0KI/miKIywmYbmsRf8STYTmlASt3XJ3plr+oMgaP8PomFDD8HgLgkZ++ZOiTM76ix3YyA63hIYz11gH+PX3s16iKM/TfLjvBba/zib4U/bIDeSBtij0KgrlH+du0phO1b/s4oZTiHtqi6CEj7kd8QITEr0VN12IvaVYOpPgF+hdtcGABoa74RxynnkYKU6/Us4D64KdZyQ4gVqRftdBmoPJIMyeTqxpq2i83QaNunXOxD+nkyF9QWFYng8HkzBICAvEAt1C9yutKe+dw/LZNYeGHj7cJpTAzepoFdVPd7AOQtWaY7tfNUhSYthCF3DQpkVGr85D5T+
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|15080799006|12121999004|7092599003|461199028|10035399004|4302099013|3412199025|440099028|19111999003|34005399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ujvvNESWZexE4Dl0hq0fVTEuzomITKFaxP5PkxCB3TGaa7K8Nnvr1ZM5TU3p?=
 =?us-ascii?Q?e3Bv624bGQPO3BVoyw/cSWwJAGsTMI3B6vX1Toh2K/KnOB90GmCeOk7x8GAl?=
 =?us-ascii?Q?O4Vq8ifvus5K3Jx8o5ejMu99WropCegCcjF5G0Dix3sWLbal8s9VNVkjIm9p?=
 =?us-ascii?Q?DDK3mLVNcPJR2tzZZYfRAt3K6ARcb81n8Wy3iTpOobnASu/v+VevvEa2Uk3/?=
 =?us-ascii?Q?yx66reAJFPeY0I1HuM10v3Zz8E283a4HRaxIdg5Yg4On3cdECBiX7ln84FS8?=
 =?us-ascii?Q?RSgqRvjNQGU+Izrkly4gM9tJH9Y4G1/qcJlxW/fb1+wKRQL4EgT/D0/OEnkt?=
 =?us-ascii?Q?2UFC3pk5hp2wDWx0oHaZybEjdGhfBuVHx90zv7Oq1tHRRYk94ItVdbqnoC8d?=
 =?us-ascii?Q?n4G16uNIGjFkNUWC/d5yZINYuSfI/zk6l+Xzf3fuBFdDp8BuO/kyodw3X4CP?=
 =?us-ascii?Q?lWoVvCPyaUfiNA8Sn6qx0amRYz5Psq3dsYV4LGrkkLwlVHKR2Wv96ZeFSD9Z?=
 =?us-ascii?Q?Wc2U8u5dxal4SPkBHr98eTnx6Itn3Aq/Kti6oh4XqwHm6V9UEq8SbFrZIKjV?=
 =?us-ascii?Q?UB4+XykZWg0EiF2tYkRfbtWCP/qZOEGmv0NTMWlSv0fnRtT/M/hdZRbnZl/B?=
 =?us-ascii?Q?E0NqzgVbklml6bv4o9wAhU4hwGJs4nDXbHyAH6mxExdXeGrXnwmpjE98Ccr0?=
 =?us-ascii?Q?7Ti7+HzLAxWPeKsPza6o6MnNwB5T+2nGBdaYDrv6l51RkGntnenJ2gtXk7VV?=
 =?us-ascii?Q?DZkE/ypsc7qpPx14GGha8u7UFlZJG3bsr9dzEXM8D+0kadeFQWxEX2FO0AZw?=
 =?us-ascii?Q?ZJEe91SrmzCPEGWH5hnVjeSPqCodG0sODt6v4vwwLc2+rT1Cmkgyuke+rz0B?=
 =?us-ascii?Q?fmknwm0kwIqH00vEtCLokHtCYPoWXnZioUpoopg9yLiYHGiQU7f7gfu+m2s+?=
 =?us-ascii?Q?yQbSrf3pEswsmxTP6E0hbmXrxUlB+EsoFE8NNDXcU6I6zuSzYWIU8GB8THON?=
 =?us-ascii?Q?w1XnWR8PXufjAnwbjoIhIHK9fxrpYO8YHQYtZJZTopDP9rDbD9KsXs1Pvl11?=
 =?us-ascii?Q?8xPWQoaZq3QjvePxHemVoQS/C3OIrV0JZG6Lqg9SYGij50t2knoZxN2aW71j?=
 =?us-ascii?Q?KM+H+ZdlplPb5Igl0uvEXMvfBs5j6dAYMRNRxSlQ1DANIZLgEDnR08g+wUI0?=
 =?us-ascii?Q?KSpMUcY0qtWKIXljzzgioHDedU6oRFFrCGETDZwlSt48yQNKvF82fwpMnsBQ?=
 =?us-ascii?Q?yoSB3WM6eH0hWLGW/aCXni0cwcbfA/zYvEkFqjE8PBimGpEpeiiHrtbpl+9E?=
 =?us-ascii?Q?9E/KeW/b/k4rK2qabtEBzWw7?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lDKuM0oysJ8yW7m0QnPUPoMKIP7sQyeNg1PrL9Jv3+oKp4zeGWUVdp2kvRNe?=
 =?us-ascii?Q?srG/lPHAzL+LfWtmiDQz6B/Z8B/iLFgubaRaFJBj2Cm3FvEbwzlr2xGTcLsl?=
 =?us-ascii?Q?VCFenyMUK6ASXGVopYEw6SJOOEEMdS93BmSzZvp9L+VaAvD3YGxk43Wt0Urb?=
 =?us-ascii?Q?BOJIbgHVnhbQnrbLr2D4i7gIPS/FhZjc3HWPs2j011SCtv71KYJqdCK9A5bF?=
 =?us-ascii?Q?FVdlZMfEqYJt2ibZgUWRC0P7OiNgL7BgdVsfWUZlza3qZyE9cGalFiv8fMiM?=
 =?us-ascii?Q?uoVXgqhBuTORxjj9YQL7uuUNzwAKQb9hhbG8iLRcJ1BcnfH1WQMXtUSkNvSy?=
 =?us-ascii?Q?yTko14iuE+WfWeK7s/6kwv/4R9WkOJxQKTtxFkLNgDwVPKBMKMcnH/Nm8EQr?=
 =?us-ascii?Q?gcHwGb7am/PgrJ99FRlKLE1sVKod5udfmZbTdKvI+RHMeD2tRJ4vG8BWpIZY?=
 =?us-ascii?Q?TJlHkav+Pn89YKPYR+UcmhDMGu0G30PqH9DSW8KM/h+AzucguwbiYKoz8zII?=
 =?us-ascii?Q?2MgdZpKRQrZIyc+jqi8RTA/r1En0FIw7P4POYeB50FfCoMlvbFcVNONEZxN8?=
 =?us-ascii?Q?HfvIv+qPhKCewfnYixTUAEMddN7e+Ujcp22pxq8LO9YJkBNODv/ziSBfP632?=
 =?us-ascii?Q?6bP+HCgpyaPvqpk5NTs70d3PB1hW+pIZ3R6MHD6ygEwqWy/q31j19AJ+PEHj?=
 =?us-ascii?Q?Ef14mcro+JWP0d1lpKBPtMXaa8NJUChOls2NCWqH5NDe84/PjJMwu9s5Htit?=
 =?us-ascii?Q?UNPfFOYiaw2nuBJkN39xKZ+WUNvMOHDT0pmGMS6bR0bZp4yOSzKicJ39GAH7?=
 =?us-ascii?Q?p4sxXgd/qQ/uLFzLdCSI61iTzRXvIv6edt6fuOFjjjbUD2AM2SMoDZpSUhH1?=
 =?us-ascii?Q?bnc/LPggNQMSicbj5v7Wrw5upG7VMvW2zRqhaqrhMbH33DgrF1UDn9bZDK1z?=
 =?us-ascii?Q?/v+W+sGf88U8QST6q85QGMpkHQJ95bWOSkhZmq8QwLw16uv7VHz/A2ZkZQUi?=
 =?us-ascii?Q?wYf2l8QWkTW72pZS1zTj0dC3bRx6Na4Nn4fyEFXlHdomGXKTtDEyQFgSJ1Bv?=
 =?us-ascii?Q?WCqh10LZMbw8QkZR0rWtyQnqPyk58RvwEotZvDu7GQitUKr8dkMrCGmsBiYb?=
 =?us-ascii?Q?cFPEqMZRH+SdUvxUURLUw6OecrzjPX4qMgFY4ZrZGkVQoOenQNpFCE1UjGhO?=
 =?us-ascii?Q?CJXCXJdw95DalSokOgOciw1Zc04HbRAfFnHnOY9Cz6H/GoRuL6fvMH//KAM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0bd454-d9d6-436e-a227-08dd8b13bee2
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 13:58:28.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB8169

This commit does the following changes to the send email doc:

1. Added examples to use OAuth2.0 with Gmail and Outlook.
2. Improved examples to send patches using git send-email
3. Added links of credential helpers for Gmail and Outlook

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 106 ++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 92389036fa..ada883289a 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -509,12 +509,12 @@ include::includes/cmd-config-section-all.adoc[]
 
 include::config/sendemail.adoc[]
 
-EXAMPLES
---------
-Use gmail as the smtp server
+EXAMPLES OF SMTP SERVERS
+------------------------
+Use Gmail as the SMTP server
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
+You can also use OAuth2.0 authentication with Gmail. For that edit ~/.gitconfig
+and add `smtpAuth = OAUTHBEARER` to your account settings:
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
+Use Microsoft Outlook as the SMTP server
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
+Therefore, we have to use OAuth2.0 authentication for Outlook.
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
+	$ git send-email --to="mailinglist@example.org" --cc="someone@example.com HEAD~1
+
+Multiple `--to` can also be specified:
+
+	$ git send-email --to="list1@example.org" --to="list2@example.com HEAD~1
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
+available online. Community maintained credential helpers with OAuth2.0 support
+for Gmail and Outlook are also available:
+
+	- https://github.com/AdityaGarg8/git-credential-outlook-and-gmail[git-credential-gmail] (cross platform, dedicated helper for authenticating Gmail accounts)
+
+	- https://github.com/AdityaGarg8/git-credential-outlook-and-gmail[git-credential-outlook] (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
+
+You can also see linkgit:gitcredentials[7] for more OAuth based authentication
+helpers.
 
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-- 
2.49.0

