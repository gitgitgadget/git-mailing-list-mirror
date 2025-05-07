Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530CD280305
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621450; cv=fail; b=Kcu/W1tGRSpR9hU+MYuQ/wEWbf83gcxLM9vXWjpFtoMXbiuV6Sl3/yyqoUs1i/JAU0Az8M/n4KpelITYmGiTjKYeWRTKP9GgCKZgA7GYee8Hq4Z4WVNSN8UX1lGkAh+MIH4mTmC78sCgwSEH7nWiieqC24Nx2T7d8KmDSbr0jR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621450; c=relaxed/simple;
	bh=44MuOcUpFodMjvo1T+UT6Lz5OPYW2y2qAG6sNcKWz7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTcldGnlX14Dw0z5jSHIoZWuv497i3ER8jykRRiERJfEqegNVlliVkWNsn/GA3JoQhEsOXkpWCNTMriCva9HDB0NPpS5Pxj5nLC471u0DnMwVSl1TRW5GCb2/r+wMLbfFPZ4ABb0PdvZTrbx8gsB2R++K9jv+HyJ0FWSP5mt95U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bJDmfCw7; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bJDmfCw7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLD11ddHIn8wUs+8nEGdtXMxwPQihpkKMS7pIedhaJ5aHuTfYiFbDy93uu40DpBQI5Bzs/tCEhymynIX/IH4NgWk1b4vIRNjThUlDLH+SeQBYX27kC/xSq9USjGQlQnvJhlmHXMibyFqtYq5nQBQKXk19IGcjTEFJXnfmFs/vDurwuChMVn6zSELc8fhB2+04pyfx1z3jPKx8Is2l26i9BSl7LrwtjrbmtogkoLdgbSMkvrBKgR8mPFHl390+nq3UZ88OqBmosrbQQjyxUR5Z4vaA5kUwnVlwQbpiWzhy+m/mCdSz9ZHKzubhT+tS6xzaQhQZ0fwpjwa/9cdroE1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+XTpwQlhcvw9gT6qcomZ4GPaBGL2kgwT4ywkA554E8=;
 b=M+AqkYw12cyPKoIbT8irUzGdfVP3X/ReL9MJ0QV4YLwb5KTqD7WMLh4kC1kfQCVLv4bm44QGrahGmnWSnlduyEGT7YttxQcSOIdJ+93gZj+5ApNMH1V8Gg2/Udp8auhqI+AfwmLbNGcgMuMjsvPwKT6coxfcweYDU5K+PYD9R5928wA8UukOoAvSWeVHF6mAINf/QyW5paeO0/5OCeCVRWGwm3+eZ/tyKNSkIq0dv7y0O3Ywn9+YT08EPpCO1Q6A38VGja7Sl+WaOtMcJNr1fpTCpaSidU54LtCtNlFTmR9RvBm2jATcr0t2/MchxWQvxtWGKdLYDunE1sjJaITxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+XTpwQlhcvw9gT6qcomZ4GPaBGL2kgwT4ywkA554E8=;
 b=bJDmfCw7sM0VvLytnsjnlNsK8zz1OrwhO2apOZtgSTHqeBhplFklsfVWVu03VVSfDpIiXcbusJfMAup9Xtz1Xu11MLlo8s7TyJ3YI4X8nzSd4Skh/eDVjSycQk2RWCWloY52CeOaNUhcxpCar5/tHhPQbVLi04UljYyVgBMrMvvMjnOgbFuke1NrZ0r6pd27WB1WxsucvxJcKTvebzrQLrp7ChoFSQLcz/EsW1x3msCeitkrJVmR/WXYvmEZOSRcsScoNkddyY9u23Ati/2SNYCB320YuEATdpzrKEE6qYzh3pcfDfuvpWVab6Oyu1D3ZINcwv4ubM5ZPwOqO+I9MA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9910.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:128::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 12:37:20 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Wed, 7 May 2025
 12:37:20 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4 2/3] docs: improve send-email documentation
Date: Wed,  7 May 2025 12:33:06 +0000
Message-ID:
 <PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001AE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::a) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250507123704.18348-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccc7206-fe00-4689-9adf-08dd8d63e80d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|8060799009|19110799006|12121999007|461199028|7092599006|5072599009|440099028|3412199025|34005399003|19111999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i7QoLmDFzgSDmGahwvicKFR0EV7e0AyvVdvBPyThdB8XmcFFWV58kS5A8Swu?=
 =?us-ascii?Q?GU8D+6Ff4rObW5Fa4NI+Ml9uVHmdabG5bmTkIZ//SciI+sGu2yluFvlwWQVy?=
 =?us-ascii?Q?5S3qWQztwUnJF4UA0bBSDD5jPfKcIRtC1gI8XUlykHlFNXNqoh9o1/rR8mLc?=
 =?us-ascii?Q?xkvDApZU0eRcmD6jErWxEl3DXLGB2AvOWjNH/pc/fqquRrOnHQS2llz92s+N?=
 =?us-ascii?Q?Nd7vdG/CCC8vmBXqIitp7z5Px3ZfLSk65Na1UPJWcIA7clpf4FvJihYhddo7?=
 =?us-ascii?Q?HM9oQwh878XwI9XaafemjdQyzKAubvsu3TiXkcdzNOdc8RWxPQg9kMC1jpXx?=
 =?us-ascii?Q?lcy6GDUfsVhugZg9BPcOuLrVbCNmp/i93TonVI6J0iA+tg+YfmJ+dticquX3?=
 =?us-ascii?Q?W4IZWaBuSTxAqDkKPTRq1ZtxcSHnm391ep8u9gR+MsHROSJqE62onlZDPU+/?=
 =?us-ascii?Q?NOw/e2zZTSM0krhzyKKd/Xz0iIODxSWy8f8WXb+ooO2YPOBgX6ObKHNZMwym?=
 =?us-ascii?Q?6SGyElNxVJlEuGFx2BWx7sc3H0VYgo24D41F3CEk6Ui23piYxX5KOHvmwgYs?=
 =?us-ascii?Q?vHgFJIiRx52zg7p/h9Tb96v21uwbN9811U0kXsqEAm7PSNnKDl+kPXk7CZjp?=
 =?us-ascii?Q?Q0Pbjn9dCkJBQ+IY+Pn7bFfJZP5Vwm4bhYvqSKof6xc7zFJ50K9thcMJMZpv?=
 =?us-ascii?Q?RKPP7RCAAhh04ITXeJrvCEnWVzf/rlmrLXzsDNwUxVizyY0R9Q9ouA09Op4L?=
 =?us-ascii?Q?LkR6xypor40OktfqaVmNUN7Mtv1CQ+zHy1Wa97p0SSOgK4LaknbFm6tfA4qT?=
 =?us-ascii?Q?arItRYwzPciEO7LYuqg2ZEf51RLBYTKQiKp/49E32WvKXl6N/PPr5m125Ho0?=
 =?us-ascii?Q?XilufJiy9RzVKFOrJ8yS10a+7mYI4jLr+7iz+AlIVDMtsmFJVsj44Q4lMFtx?=
 =?us-ascii?Q?lTyPV5csgAzkXEGz4Q6DVT+jpdV9Dst1imeDEMBkrPtzJCeSDhfgY2Iv+JLK?=
 =?us-ascii?Q?Q1wxIhU1m8mWFad4oN017lBRM3/nxCWx8HhehHaIDe7Iy5FyU4EeSKCRF9rW?=
 =?us-ascii?Q?ZwH6D7LnqisaoPpKanSotJZm8Xwk3UwShTbpvN1Km3exwkAIECA2o458J3pb?=
 =?us-ascii?Q?/JB8RMxa8ZvRESFI/2RIQD1ts57HxHAa7SEVSgKcy0XK0afhcgM9A7jQ4jvP?=
 =?us-ascii?Q?yDHD+zQKlBv0WMMKBg8twQTc5W7gjB0zCSg1Z4bi5AweFYRhO1Owy5/S6L3g?=
 =?us-ascii?Q?lhCGQpAvQMZpZ90/4pFJiWf3KJubx/nOosC+AvyD/w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5vpUy3Uek3FcMzP2KVWZUzaY+oZFBNsAEYGWbuBXnNQyl+46l/84Z2I3qya?=
 =?us-ascii?Q?i2JAxjdmgEgZtzYE8jAScVBYYzLyh03LB3+/SvqN2QTpiu44haiu6TktU42m?=
 =?us-ascii?Q?cQO322zlUL9oLGCq8doohtoCWfoRq4GOx8Mym9w7xvN0VnOKYersJwALol3U?=
 =?us-ascii?Q?IHZ2LEzjJ6Wzb6AbuIufQPqsl8beKkRtUIBh2jmDhQfE5GQdBBbbeNbHBHn1?=
 =?us-ascii?Q?w7gKFYjBNj2smfoTqoBkEQwWmstk4JL/Ldkvmn65UdEsLpfxfwKR+AcLB1/4?=
 =?us-ascii?Q?tBSdVWbrM3IELdF3Pcfl/OnSXliFlaDmjuMiyi4rOPnHZi/2Py/im3Q3lmwa?=
 =?us-ascii?Q?nwsFiMNY9HXfDK0fqFERbDLB9hB2n0WO8tmcCH5gr/E8EMJkGSSsPp4tkRuE?=
 =?us-ascii?Q?+sVkShtMFLCTyvgsZ2l2LhMMYMbF4CxnjWdkrx7wHOGkJoE91CMsx7Zf0NAK?=
 =?us-ascii?Q?ZmzLBSkuwU5+gzdmYzprF0gWA6AaSzwza3kN7c9eDB12F/YE+fK9zSQi5Vnq?=
 =?us-ascii?Q?kW9LTY4J4t7PMO7a8FHkOwpoofq/3Qad09/gFKqw13yHdz5AKCyOAwfBVDHB?=
 =?us-ascii?Q?7sRlGoHSpPQwTbaz+4pKN3t1rV3tEtErAK05Hh8skukpJZATXumKlTX0Zf+t?=
 =?us-ascii?Q?eFvoGcIkE/qyVcxyGERT6DU5oc82bfzIQ+3S0xIHEjdN/XfqJeKvutNgSoz/?=
 =?us-ascii?Q?Nrsw2D8exsazXth7xhRI0VRyW8sTSfLdyjoSP8wZSuHkZnYnvF2P4pHvkejs?=
 =?us-ascii?Q?p3ZaxdT+vhvr5pth9K76huAs2WRtLh2HBV+NqImYTwEDc0F8+QnO+QmBWHN+?=
 =?us-ascii?Q?YmVNFo9xyjjoQ4wrJ8dx6U7WxpBNmT/riY3I3aL8nYgBXG50RHp/0cwaWoOp?=
 =?us-ascii?Q?PYN8YmZdbml6ZmaG/lbGSiBPAYZqKu56McRqqxkBww2Wtjmhy5r/ccFkatV+?=
 =?us-ascii?Q?JoHDstKORcdtKpc8/d4EqtUTRoXIKpKVdl2lr6j2KpEdvAwBbuqlTxrYLxDG?=
 =?us-ascii?Q?YQqz8zY/dNrQBx7ulbE/PEjEsEFWVO5coqAW+mp7Wg5dfq3sFMjg/FnNN+Ha?=
 =?us-ascii?Q?wOW15CzdFxzL75Rnh3ocOJDa00rSIDwEbWNFBKspco2LjXuVY3XYkBafSZm4?=
 =?us-ascii?Q?n/c/CQ6+A8HSH+gLPY/akJTQ8hfwCc/euXg3lF0KIZA09JPAoBUJyKZKrkV4?=
 =?us-ascii?Q?R8ofPhSAtTlbThll5vz4SAspszh8RIbCAglf9q/aIgeXZLjSgBiIPcdJWFU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccc7206-fe00-4689-9adf-08dd8d63e80d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:37:19.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9910

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
 Documentation/git-send-email.adoc | 61 +++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 92389036fa..26df6514c1 100644
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
@@ -528,6 +528,37 @@ If you have multi-factor authentication set up on your Gmail account, you can
 generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
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
 Once your commits are ready to be sent to the mailing list, run the
 following commands:
 
@@ -536,9 +567,23 @@ following commands:
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

