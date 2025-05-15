Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA312980AA
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305256; cv=fail; b=BU/GhcynBm2HMehGLGi02JGD96rBY1y5JFv+t7cG5Q0Pe4GdkDBUgH3zt2lSn/0VOxV+hOnD7ln4/TUDDhy9Yw/notC788mKwzBi50aIBBcfhEBDmhGvups9U5ELBFacVZo+b0h/hOlNjv5nhOCuysAJPwq2dYzZx24iXrZvMSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305256; c=relaxed/simple;
	bh=QsNT++MRhfikv+TcdB1iwUnh5R1wO3+2LT2RL6GWw9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F25AnHetlTh9Ffj+Nf9k83nK86pBpgCyvLmDzGy/V2FUpOJm2SYeevdGsGvaXwwWWz5pEDI/uatqY3hKxSU8ZWH69y8Djj1eDevVhV5LehF8sLn5rTP+JA4Iy/igpCAVS6ZvMSurztQJ19OpczyfXcOfW9XqC0yu1+/8VwXuKuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=U0A7gZmy; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="U0A7gZmy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGTcY0osCHblxnPufRrFJsLS6UvlfXnFq2QJzWbAYfCBA8oxCagwGNZFEVNE8DpJQBqw8wZao83jIaoQMSZe+PY0QGA/P8IwnxnWpezfzqAoGAZKAZg+k9gxs8sexiUblfB3Cs2mpkRA4ICVD9bnyyPib0eg37fnN7TwpgXWLWIaZCvP9tYJ4wmxM4Yw6tBs1xpLKsob7odQJqwjNZALuG9n6A+TrRDjzZOiV8q2T+SkI7aYLnANHY3n/iivBiNF8roEJ1hu6rOSXiQxce4cepCFY6oDHlbYG6t6p+1bN6n/Dzkk3CMtnkh384JIgoYiur4Fx4Tr8It7zPFZj38tCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suFM3qt/gOqn5pRhJ+DqMQeZXzg+UJyXHqZXkRlqsCk=;
 b=F8BR4j/7UyBTn9iu+SjGbzR8yDB0/I+wu9Rpmi2l9vE5OibCzlV68wltl7NHA8PfnRdt7WsbnzeODH7Ab0t/NEHGRYlYj7Ll3J2YfeY4I6HNWATEBiqlDohrbJge5DItERnpsb55VU/LYJQNABQRJpaEn6KBhma863sH7K7oV/eAhBT67M5Hd6Vmvgp2/7KHjUumYBbA/gwQHm6mv184oieBerHweJQa21EKuhQCTD+aLCdIMQ5Zet+z9PAaVj57KE9L4kUdQKT1StQDefYGRNP+78K+nc/LTDxG558H2Kf2t6WMsN3Vgr9Ym1E4trcMGi6DvmkSvzNPxZSMN6aIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suFM3qt/gOqn5pRhJ+DqMQeZXzg+UJyXHqZXkRlqsCk=;
 b=U0A7gZmyIoxknPHHs0ibElf/3mzmhIvfqgbL+u3RtLdyGxiJ7LvnVmuarhWGN2B4NnUXT9dxAHJHFuGvsNShBmB3RXM5tMPUF1gGW+aGhDIgSiHTR2yTTXZ3HmEuTEBek5rcdzkPg1toz4dh6j+WQgI9iV4JK1BnYH0PslfiGgTGVJ+IBFOYCzHtCNL252VcjyBWqWLp1PlltZf/iHNpJkPGEuvtL4JSq8rgiRBZYSE7ySq3hgtNzD2gNuNNPedpTSMDDBZmC9Ldx3+Bxsw2H3zQO1x1NXEFTGRtSUmBVifIG/i0/ALgLlkkKV623iSo7y1HDwmV2t1Tozq0Gasxpw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9257.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 10:34:07 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 10:34:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	sandals@crustytoothpaste.net
Subject: [PATCH v2 1/2] docs: add credential helper for yahoo and link Google's sendgmail tool
Date: Thu, 15 May 2025 10:29:23 +0000
Message-ID:
 <PN3PR01MB9597F04CF39B1B95CA5AACE0B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:261::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250515103355.37250-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c9163f-d69d-49e1-e8e8-08dd939c04cc
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnp9Nt1fOmOdeH4+bSyX1No+1kRcURRlqWMu6cejzoTT/H169IY6N2YbS1XwV1+agXG5j1wUN+/Fo/44UgaOO+SMmzkyPyrfj/nC8NHKew5h5A1q8kuGYW79plX3g3/EmKeasvht7kgt05cZtNUyW6GaOJEIqM/Hd3qFkbpVC+A9T/m0gSUV8drnBVcfrCb3/kWVCwn4ECNUbSUMVwQxg+2rbDAVsIEs9vd17MxQWFjO19zRXPiIXWsVGnWhyQr9mqWQQjXlzMJvw46gybaaw/cMWiQ5UfQFP6SA9C5m9BUh56YQ3Ku9fSJBSISGwN+S9G1fgu6narPcngvFCebCKDDEUypYxXnaSRY2b75zZZjwveOVwdEygZgdhh3Mtbt8nNCBSmDgw3VNEsQ+nycA9amN3+qRm1NEz2stopx6JzctfJjMRGDOIM4n20O5SFEvewsJm5zcMfEbIOW/AYOY+EvEhS4tzFF3vZS66TfjhXRhnoT+zF+bh0AXvKjoE6Fg7Y/3V1df0ghBB+wB9gfXCJztFrddyogrJJ0oe+dakOhB7lT5H8JDx39kumPWqB9bRQyV1c1JY9Lqzq1XkbH69NzgvGh+EiSWpNt8BQ5cTuSFcu1e2Xm2qBS+kxgKjDKwxNXsaVL9AJOJ+dARm0LtbuiULFU/mNkBLVx70n4PAlrtUYEIfluL5eYQ0OgGGZuFBx+sxNpMy6dxydMbRHpQLut/Gig1yv7ZD+ZOTkmXUVjUw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|461199028|5072599009|3412199025|440099028|34005399003|10035399007|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/wk1+5YxwVCpZ84UFpJIyQxRvPbHo88xY9Dqwngf+obAjBAY0FLRbNOopAxx?=
 =?us-ascii?Q?SjPjv70bVWAt57OjLsGpdVZvk6/6WHfS8YVoh/NpaqRL1JV1AS201p4wJKeH?=
 =?us-ascii?Q?FAM4yZObLc+waDBhusG67tdUkoybFDTRaE71PXUR73tjoz9jaCfzGz6iopd2?=
 =?us-ascii?Q?cEcle3sZoe31FCmsNkUMb+9QcuJLXMxGK2SDIU5ktGHPhCiBlazpyGEx24ae?=
 =?us-ascii?Q?zWyA60+HKZv03iePy6lGTtvDHZ6MnshZb70e2gf6TzkUmjbQubZG22VHRX3w?=
 =?us-ascii?Q?d5Su6QQBT1A32JV/7MIWAHi4ByvGW9sBl3HvK3J5m38ZufVQV8P5kGG10iO0?=
 =?us-ascii?Q?yY53xb7o1VICPUKKL9EMknB6JEw666GKswGXbuAR4hkfysKJzwY7ub/70qNd?=
 =?us-ascii?Q?ymUtHaC43exQSToOgDBoWnXILYoEwqma4Znh8mAuG1V9x2PMgWilgXSoMOgr?=
 =?us-ascii?Q?BcUz0Xu52iYA4CK6hbBEI+VP6b9X0J9VhBPtpEvZi4yb/WOfr3gfnGyF8aqq?=
 =?us-ascii?Q?sy9ftyEVjE2zSMnDCkRCNYcPAGgtgeV/4kFmt5XNtz4GjMajaFsy/QKuwvll?=
 =?us-ascii?Q?xQrcgrtSy1PXdX5RsBoCjpYkhnE9IErnEcUXBMQ6QE0Kg/og8qH+/gdPFBrF?=
 =?us-ascii?Q?7mYCCgEjUThaSYDHXWEQi3kgZLeRCKnwMkx/SiRPnYljHAPvKJ+hH/jfz0Yl?=
 =?us-ascii?Q?2XF1w+ghJYZMTlE0PMabuPgNgtPUrlfqCBR52y6uq3CJ3scfeU0z/ELLqKCX?=
 =?us-ascii?Q?4ywLEzFwLp9lmFxr1z6Eg0j2j8JD/V1bKw8fC1EvegDWXsY7HjOkniwrPQEO?=
 =?us-ascii?Q?TKwsraDLPBbh+EzX7UYKCwprdwm318rAS4tqMTChZOU4UDC0zbPwygAz4pWT?=
 =?us-ascii?Q?qJWgyuPqHQgJ6UW9K7xS0XrRRd4BxnH2ZB1/fCKS8oUXR7bYOUovq1VcrhDF?=
 =?us-ascii?Q?G6ZsuMBeWcEeXBX0rYzjk2m1pl6jI9ajB1BSkpSUsJEA2JiXD57xtR8NhFZy?=
 =?us-ascii?Q?YQ1aF/FfEhDydpiOFQhSpRcWwklPjGKsb8YDH0CxcEz0LVKyuOrBEJHJxlLo?=
 =?us-ascii?Q?LVU13y6rgmmA4GxJhehQWXOnip1kPZYtkknWDeS/ziIctjHIVkSvVef1O4sB?=
 =?us-ascii?Q?gCLf5M0CVWS/yyQqtf0nhPdmMF7ZAmDJpb3c0aQG5qaGUS/3PIeVrAbqZGX5?=
 =?us-ascii?Q?xifVXrqoKH/oXuTr0qcvrRuyV6MzFSi6feBGOLkTaT2feOZ7HxyTxusNsC8?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j+eMpC6uksoC5YHPFEzOg1Ke2lctLnvqURbFGeR3L+yRBE6cEC1gautnN7UM?=
 =?us-ascii?Q?bAlPMsFEDg2zTy9hb2Ai65NQHhFJKSasT3kyuuyM9bayjwvRr1Pah4LfZoqX?=
 =?us-ascii?Q?/kWCnslHz044QkG45X28Ma+JZw5KoXdj1PRnDSbH8/3ESP309iILWgqTCud/?=
 =?us-ascii?Q?jBzzdmwNO36SOoiMoWo5Xb/zLtwkjHapUreQXRYg2O+H+Cs/Ey97oCvOTYLV?=
 =?us-ascii?Q?TKrV6bA5Z8texXsmcgF8dpXjfnEwqP+qMb8f6ZXJK1PdtgF3BqoVtuKw+GY9?=
 =?us-ascii?Q?X4BidR8QG3fc5esrL55RMsjmo8Uw58PrdB2lmDlaPMdysBao7m9nuztdAMpp?=
 =?us-ascii?Q?iYFbBRApNw3eUlIqZnXs6KyvxFkSX5BEuQDX1mfquj683cZeeFYkJ2xwVpp2?=
 =?us-ascii?Q?SrdEs2UbSFMdDFX1AUQSmDeNCpPelZOwkPLLOO7NFz+UAXBEFLO8IQ6cknFX?=
 =?us-ascii?Q?6OL4Cn2G9PpTUraJzHrz2CRq2/QgRFj69FoEgh0lOfeQbzWU71/FtTFmHEHj?=
 =?us-ascii?Q?dcmGGsoVjvkZhWnkp66eCasBUf8RS97J+p9DUjaJi3K8awdHSoTkNbjKUBlN?=
 =?us-ascii?Q?pVoa1kNERR0RgNL28EsoiKGtADTqsLS5UbV9od6VV3S0UkXm83RJ6SUy3BsO?=
 =?us-ascii?Q?2Sm6zXzekBQOeYj98vkVBHHBFCPtMsUQC19edLJ+kBb1P5tv8iLl3IxZwDyE?=
 =?us-ascii?Q?6FQ8BRySYkQZI1m5mMngxVmYRRyTYynLswCklWJ6UepWtY593mAoDi0iITOg?=
 =?us-ascii?Q?GBCBtCzzGaS/VjDev5b1IAeq1bCv/g9sBW8+Wi9sEiM14SyW+Ny0gGpTceFM?=
 =?us-ascii?Q?iBk5ZhQFxl7aIc5Jh6Inji5IRFy7f2CtCdYKP897P02/r8nsYpZMPMJmkqS1?=
 =?us-ascii?Q?o/dmRCruD5Z9TOlQl/HGQH4igsPb6elm0o/ZyY+VuXFbfgTmSpUNGPyJoFV+?=
 =?us-ascii?Q?CvMt30m8DnOZAO4tkU8eqk50QAJOfOs9cRhADtF7pA14dkZLbZK/UfXD3yZ1?=
 =?us-ascii?Q?y1OpsT7rNnHbR0WEl42G/FqobcKzztzHyGUe0/3H4dGGHMri9/3POh55gptZ?=
 =?us-ascii?Q?IUEzokhwOL+3C1N0xtmFpdbvYut1N1pUp7jNie4rSOh7IsbJwQLtZyTB/ZuL?=
 =?us-ascii?Q?L2EkBs9xAE5gfdpDHbS1EeaL5uu3U/iOUTcTeFKO4owPW54TOe0yvUcxLKRG?=
 =?us-ascii?Q?TALqYtT/8l3jfpOBYqVRM3/Yh+Fp06m3Grq9nExx1V/jhhRPSvgRHqd6SWc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c9163f-d69d-49e1-e8e8-08dd939c04cc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 10:34:06.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9257

This commit links `git-credential-yahoo` as a credential helper for
Yahoo accounts. Also, Google's `sendgmail` tool has been linked as an
alternative method for sending emails through Gmail.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 26fda63c2f..81f8cbc6f3 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -543,6 +543,10 @@ settings:
 	smtpAuth = OAUTHBEARER
 ----
 
+Alternatively, you can use a tool developed by Google known as
+https://github.com/google/gmail-oauth2-tools/tree/master/go/sendgmail[sendgmail]
+to send emails using `git send-email`.
+
 Use Microsoft Outlook as the SMTP Server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
@@ -579,8 +583,7 @@ next time.
 
 If you are using OAuth2.0 authentication, you need to use an access token in
 place of a password when prompted. Various OAuth2.0 token generators are
-available online. Community maintained credential helpers for Gmail and Outlook
-are also available:
+available online. Community maintained credential helpers are also available:
 
 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail]
 	  (cross platform, dedicated helper for authenticating Gmail accounts)
@@ -588,6 +591,9 @@ are also available:
 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook]
 	  (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
 
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-yahoo]
+	  (cross platform, dedicated helper for authenticating Yahoo accounts)
+
 You can also see linkgit:gitcredentials[7] for more OAuth based authentication
 helpers.
 
-- 
2.49.0

