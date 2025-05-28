Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF328E58C
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452717; cv=fail; b=dWLrur3SvyPNkjBrksUel/cz1be5JGKzQBb48En+Z8nSmz/6vCWmTcIGkKlOfvB2kc78pZOgAdbHEUQx3SblZ65GVwwy5gScClr2EMtl59Dn0Sib6mnVHOiV61y9sdUT6kncyFJNMPWLRKwtHqTuG837FQ2HE3U8U4f4pJTP0E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452717; c=relaxed/simple;
	bh=eOWzsq06dwlKHFppv6G+nDdt1uS8CfXG0pfRo/6Fads=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3ODBYvlmXh1fvQsWsDuqi1YX8Ukemi6+2gw3iozV0M5WC0YXNtvezuW68BaxBhpWrEuP3QL78t1RvUN5ILUjUn+YE8+iL2iPmJhBI9DrJtyzoHMNjCglARBYkOi8GPN/NtO/gFjBh1YwP2kLjAKmWaqHehsrztuiVcZi9v6bt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=qJuHwFsG; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qJuHwFsG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeAPbLnE82NzutqBWO8bl94U5oBTd0bvwmOJwPYokmid3kdfA/4EBxRsLeefjMfGVyPQi2VaAfgkgefD3KAR4DR34ueSrk8HzXTTKlC7INI/g+uJWrN4g7diHEbSps11byuq5uQ5TvlRctG8jN+fGdeVzKNB6Up2vdg0bqcOqx8ohJSpKMShL4IbST8ErwWQnqxzbAJPzaDSLlzEfKR+1ZAYpeTJSQCaXQXD6ZUBnkxqJ8By3YWRExSjjwrQRCVFr0BYZ/7pu/pElTZTBgSFWf1rSyLoTq6+162wNmcej0cBsP47IINrXP4XpL8VVBdcJVPGP5I1HEjL8GYHy86CSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZeLf5sUawHvFfiGwLq0KrRSbNgHTM1ksWIu4q/Jfok=;
 b=madSRfv1zlvUkIt+n0RYxpsacOk+PmHbJIpl2TzYITHsscpupUlCvcisCVE1f4oJJ78TtfXpTP3hPnSKVZG01RFQgmx5oRJVZRRc87evF2xcXGHbDPsMl6Oocy0csHMDVzrBP7acGmwSm7SqM4438LiLn10vYITAeL7EicGZBvj6igC22J0iqsa+0A8UaUBWQ45rI9ytpNXDe2oUQy5ipsqQXUZK8kAKrs/jt2qgBxmkkvkTRbSskZedkQZOFY9NxW4KMiDScCrVHSsJq7CD2RZVV7bouryxlNBJaYaRCihm7mMpG33fwbl6gHQwHVjVscdgXWguM4TxlU+0fGN/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZeLf5sUawHvFfiGwLq0KrRSbNgHTM1ksWIu4q/Jfok=;
 b=qJuHwFsGf1AW7rlfWg66oxTLpUBm75ztxA1FunXO+ccyR4MkosLgxik4c7Mu9fGetsgqo7IZiFTdrJbOu27zfEqX9AlErZ9G4C1zZmkIAZ41wNlKX3e7Q4Pkq2b58BIuakIdgr6+fPuW/CFUbKaA06hNb3ZO2Lt1MQJEL/4MIOd1uGUjgfdTZpstA8zMhGw8p5OSt7Oz6r7zmWFuMLiH7wko2hFEVw4zu73+EEjyzTloBgM9PY4/ma1LI/Wmx9qVYqBZ13ZeBL8ZmRTdXJIOOUfa++2rBH03bqdHdtYtFJ/cfIlP23Fj3pWNno33rP4GLqLPhEEYm1/nD/U+5T1WMg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 6/9] imap-send: enable user to choose between libcurl and openssl using the config
Date: Wed, 28 May 2025 22:47:52 +0530
Message-ID:
 <PN3PR01MB9597B56233DA6815FC7CA96EB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 56912f17-82b0-43c9-bb79-08dd9e0ba934
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnft2ZtfjQobv1hr6DgYqseihtsTMsKjVM6Mhj0sGqNviOzMnXA+I02q+mFsNCgSAxPT1/fdrzBfhXvuDboHrxq+3iZQ/WHhikWt8qjNgxF7KGcJGbhQe6Je8gRUbHcDSqpWPG4SPIk01j43RcvuhASfbOL6fw6kmw6/Pl/HS+T5BwgFFrNmO/3upLje9n6bSS7/GqLG5+0dLxbWy1pX4DIf7YRv3plWY8Yp0d4QFZfAOc8H9EHe2A0GZphoYJMHMv2UnwhN5/BmlJ2qkHJXaIdCNrQB3MSICG458yVwPwNyaxwTYyeAtWdjGDUrHUUxMlVT2aw8zhRxS49ek29AwzxEB9Gu/mMPbw2LJ1iFmQxhNs0HvPRmiANMP5/4KKXoZY8SqwtqXv30eEIrWjFZfhyEkeiiqJSd4FGXwHKZPr2RlzSCoUtGSM8jJLKm9HQsXeOa9hlwgkKW6VFBIcBFKw9JYMlVnt1S8Hk34bs6QxPNTlQ13WpwJLmVswSUSCHedyfCSr0P0tXTxp7D2kZUaCnxEuvWE1rELdJeGIi5kTTjqTyHVnpupMBnX1lVgzfUHrDv+mywveEg11+gxfncQnRv+ewKMq+Q806YhezdFqtLvXOfsyOqwnk3nhjp998oOhanrdNkde6SbLnw0zA5AMDUObPbSIPAooc/h/ixfayfHHkePV7eXqp10Jm+hnZ939pP/QVDpLUVBHDsBEJdcWar3NAPogwFeeZH+kt9KCffE=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|41001999006|5072599009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LP/Xyu+4/TICzN1MIsNpAg3b/rco723zS2ZFARr4IzMmDiytsNTuzpgvIhg6?=
 =?us-ascii?Q?vWMa+wJoir+Ms6WC9kHaUt/bQ0ruujQkr/v/BOOrhf87gDUJW/wbnCnRUz8i?=
 =?us-ascii?Q?RpErp0ybVdTw+ZTGF9ebToAhuNEAuObcjocXCH022eJFdhX3Ahy+yhJ5SIbN?=
 =?us-ascii?Q?9nIxrnynhj3IbDqM2RpOxLxysYPFlwALK/5kIiDis4Sll4DEyX2WRtVdqToI?=
 =?us-ascii?Q?VB3Rpgm0fSRzN1eU2gmBOefwN6El18QGIXE6PRC3rhxtuctSv4Aq6IEvblH8?=
 =?us-ascii?Q?CGOwrWawzNBxrk8NIGN0GahIwHDRYfTke8oPsbQWY7jS3d36QRsti32SsPyE?=
 =?us-ascii?Q?FtpjMWHKi4nXys7qHM7MnZMLkiGL3V8lIuY4WnftbAp00CySZHVwTX2aB2L6?=
 =?us-ascii?Q?FI56A6IO1Jw2Ko8yqMQDemjX0ZF4plr7VY/DQvD11CZ8VDL10UqBjh+ZF94n?=
 =?us-ascii?Q?HozfISGYSrJWGg5+fKoc7qG4PxqKsXrSoMWkNSf/3Jp6FJaMm8TwdnUpDU4w?=
 =?us-ascii?Q?5tCcyTjRZLkkWetsMP3xmqc2rhH94Phh9GhotgKqMkw5RiT9+1cgBJ1gtn3N?=
 =?us-ascii?Q?e/Szo+QqFyHiWerl3GpS+RTQD+j35/G9hqOJ/+QyscLDOB8H5jJSA9CA9AbU?=
 =?us-ascii?Q?+L97wIm3iC3uvjRC24wcA7BJ4TWYJpEgmUOCt5N03eu6wwyOszV8JLJOxUtf?=
 =?us-ascii?Q?tplbsY26wJeVkz80r0ouuqLJGbs6PgHkejKjNrCt1+E5Y8sZhbWmYsNC5AYq?=
 =?us-ascii?Q?mYkteDh/mKK4cmlR5oB5HKRcbiJJeq959scX1MJH3iW2gs1arxdXLfozSy5X?=
 =?us-ascii?Q?0rCH+nETulf3KM5iSg4lydbGhhWfEicPnmFDqZo9NDHCyNe6jM4w9uEUFPkl?=
 =?us-ascii?Q?QAiCAivEgQ6HSvkR3glkPYH16iOl9Bq2kxYVptfnOf+/WVPGRXaIwVilSp8S?=
 =?us-ascii?Q?p/NNuh9LHJRXOYqN9AZKIcC7IWdK8wTo5OLINeNzl+j1ifHMXBQVOywdj+EV?=
 =?us-ascii?Q?1vXiEBXBIcEgDUjrdMEAW2pMVwcKtLnlQIbB1rD8cUqsNqWkHqFVLM7/21V5?=
 =?us-ascii?Q?9irxV90gNA0HHuSY4F9RFklCZn0zXjpoXGadsEb96WJRsPU1iybgJBsBioCF?=
 =?us-ascii?Q?hzqEDDHOyflBPxPxhWzLzWw7VtXn4G6ApA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lg+LjaM5rEbyf4JH33kSSIHndt3y0WTZRE5qkRFQQ73sNfIDZZHbytgy0+Gt?=
 =?us-ascii?Q?rkbhEQDQ2IXq1zts486VIlUZHzZ5TqybvW947Ge3tc/tjPGuqMWqMMSclptO?=
 =?us-ascii?Q?t916pN1qpT9crZtALb+UfD8THs7TbfxY8CNjxxN0yecBo88hHkJqqCriNQ5/?=
 =?us-ascii?Q?unz8Hi5bVEpg99xr1Tfi70+KjNH55RFNKe6+UxQ3yw+//coFhDSVkETiXOo3?=
 =?us-ascii?Q?tv+pTJpHXG0J7NxcIE438fBz8JXH6LxhKdFW40NbSzIjIP/I6bPAaGypvWme?=
 =?us-ascii?Q?ywNQE5qqiWRrS3vn0wnYsvjWe3e7tkIdaefy8OD10/WEXsDCU3+wiauR0IAJ?=
 =?us-ascii?Q?T53lEUx+Sfo2rSKB51+q0Mt5a5Hu4B1FHxXQ4rm697uoLQl8kJYwhmA34Iw7?=
 =?us-ascii?Q?28K0aQjhkYxZR37VtHB7KoRh9of3Sj58bKqiwXxsZXwmooquvXkuybIGQ1em?=
 =?us-ascii?Q?KXtikqFlfwRbodn64cPUhwfMS/Dr7Ioy9pkyCi3QVz038sWgecGGpE5ewrOW?=
 =?us-ascii?Q?hVnf6ivE5Hi0xVnxYhg8FAS1q16vn/cXP+9i3VFFmP6Bzce4TQEHuEgUpDVn?=
 =?us-ascii?Q?ZCe42SdvjovbXToVbxLBBAoW6HqibzoBGuxuDEkJdWsaV8zu9ljjgUx3JquL?=
 =?us-ascii?Q?DlQAx8HtSdouYvrRs3H6DKw5eI5SzTgBI8rVz3VoCkfsWy6rIecTyRw/KR0u?=
 =?us-ascii?Q?C/lgqXVQ0WNAD6RZ/h9s+VnbC6Ubnvg5tra/Bj2L4l+UWmjTY6fZFzAxh3ZB?=
 =?us-ascii?Q?mtzw7L+rQ5buFe4oaPaMqUyr5Ts5APpVQiANe5yJd8BBZaEtdWezFeswcXCr?=
 =?us-ascii?Q?XiaYaNinRP6bNCwTDOWEgsgZVNfOFTJxvqDDCwpZ/ramjHBHZm0zbGPEOF3O?=
 =?us-ascii?Q?rljvpWIEgF1VV5AgZQ2rx5lGOkS4fn5gpMpXngtPq7OxZkdMmB9pwbWnEu+n?=
 =?us-ascii?Q?xo9BaakKq+mpVxgCimsnLd4/fORQpK9YhL+3tLkB5pPQOSabDkq8cq/pgi7g?=
 =?us-ascii?Q?H3SJHfEu0Xm/SLv4nRqqUCD8dIGOfA967HGj/aFb8kRImY9Z6s2NqjLLJSd7?=
 =?us-ascii?Q?BBkLxuRmUhoMfTfOaLrgJhbH2EXXvpsKcSahhfwD6eKa/ORmV3IJh9HiHmeC?=
 =?us-ascii?Q?qtN7t0km87Oz9g3R4xzdcY3TrTSYy9JlBhQwB8s6+mRG/+ijA1g4p9T8FsQj?=
 =?us-ascii?Q?Cad9cPFFmnls6HDI+qN2QXc5KvvstC4Q8lz1miZj2ZG6321PiW0YwqMvIEFC?=
 =?us-ascii?Q?jKbEDe7fVVyvt+HBfgOmnv18yKOXlxY5l1tWq/rYAWuIVwYr4mcdvpBsELtU?=
 =?us-ascii?Q?E/e7W8uoHiC8YhYfPAiphP1b?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 56912f17-82b0-43c9-bb79-08dd9e0ba934
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:28.0750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

Currently, imap-send allows the user to choose between libcurl and
openssl in case Git is compiled with both libraries only using the
command line, and no option to set a default using the config is
available. Add support for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   | 7 +++++++
 Documentation/git-imap-send.adoc | 4 ++--
 imap-send.c                      | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 829d9e0bac..608c0be7ab 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -25,6 +25,13 @@ imap.port::
 	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
 	Ignored when imap.tunnel is set.
 
+imap.usecurl::
+	A boolean to choose whether to use libcurl or not to communicate
+	with the IMAP server.
+	Ignored if Git was built without `USE_CURL_FOR_IMAP_SEND` option
+	or with `NO_OPENSSL` option set.
+	`--[no]-curl` argument will override this option.
+
 imap.sslverify::
 	A boolean to enable/disable verification of the server certificate
 	used by the SSL/TLS connection. Default is `true`. Ignored when
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index a35f278baf..cbbe534ec2 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -46,12 +46,12 @@ OPTIONS
 
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
-	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
+	into it.  Ignored if Git was built without the `USE_CURL_FOR_IMAP_SEND`
 	option set.
 
 --no-curl::
 	Talk to the IMAP server using git's own IMAP routines instead of
-	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
+	using libcurl.  Ignored if Git was built with the `NO_OPENSSL` option
 	set.
 
 
diff --git a/imap-send.c b/imap-send.c
index 337f1049ca..b08ec0e1d5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1559,6 +1559,8 @@ static int git_imap_config(const char *var, const char *val,
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port = git_config_int(var, val, ctx->kvi);
+	} else if (!strcmp("imap.usecurl", var)) {
+		use_curl = git_config_bool(var, val);
 	} else if (!strcmp("imap.host", var)) {
 		if (!val) {
 			return config_error_nonbool(var);
-- 
2.49.0.638.g5db5b64a3b.dirty

