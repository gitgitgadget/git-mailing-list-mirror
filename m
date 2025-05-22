Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75088193436
	for <git@vger.kernel.org>; Thu, 22 May 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934957; cv=fail; b=Mh9N7LCb+xXVDpkhrh9lmLe1YtNCUm5Gak7W2mNX3zE0ustSwYs6dyvu3q60oOanQ+CWS07IozLllgRx1N6arcdu3l+pIyacPb45uiPYU1tKbG3D9AmPFbeOWPNe4adeAV5ZNSSQJwrAep5q+fwrdyzc0Ko3CDXN890ezJOiLx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934957; c=relaxed/simple;
	bh=z0nsZ2kPu+fcQEaCPCmhSJsE7xBgtBaSMyYidT1U5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bt4wZaLAw6FGePlhi/jZ4iaLSWve8QOFY+2iUbSUn/bYVWztw3qHUFyPR5qMfQkqk76exuHmxl55WPqHedv2E1kE1VJdIjdHwEhlH5+jXDLqFRZKs9RUkTL0G2b4U0YtwODJYGTC85xLvGDQV97LKcY+Gox1mqct5AMapwXM8Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=S98sZbx/; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="S98sZbx/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ1sIsMXh5XcLdJLYcG3522T21jcCLHwb2d35WoyuX41MBpv457Cxw/QpviIcg/zbGP+oArdFTmWR7DTn/GZmnbfsvMndqvqKrF9NVEDz91GEvfy+a3t/XN9vD7CVTzYfuegQr9r2GdwgIEJMrkSCp22asoWgIF0GJK7IDZsO6A/FrCN6Fof95+qKrL0LFUdq1j985tkkk1e9fGXd1RzLbjjreltdEMWW2nYJQEuVRIW3jOl5zM+JP6NrzVT9N2GjJU9RIus1YzDxmKq6TqIxfxK8rMavxAw/MmCEGrGM7iCAw5rc4XUqmQF728lbIam2UZzCi6Inna0FSDOvZWNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rou6eswbaNwvTDv3Mr5UASgPdE1iKyiRbPoTxYbkpY=;
 b=wSQQv91SbcnYBLknVmTEgVzN4HuTq/LQ0zZaet4MPAPBlbzbB6WRsbHSnLXNLu7vNlfcO6f/fntY9ng1TeHI2yGAuzIjANZ1ylNJwQPS6lgjZXt/MXPScaL25dXMD+huy2XQ8OeB5TTkFH96yF/fPLlSMB4pwdZ2soSXIz+dkJJmbWXimlXmcmTS3zlS3MKOqWB5ymV/J8UDbI7kUMngMQy5qOVcKlEU1Y7bhDLbw1nmW8WDQ8doyE9f8tIfCl/71WEsSEEX1QFW2q8MYqcn1BKzNEbOuYXrRDYGY8kWwKnKTItHL7ygjitGAaSV53FKyaeVjCNCvL7jYdIX/caXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rou6eswbaNwvTDv3Mr5UASgPdE1iKyiRbPoTxYbkpY=;
 b=S98sZbx/tKr+76ej+b/IbfBs/f3hrAIJSaWBeOFH8O8VygVw1KhNptrMlUVTVG/vK9iWVgtiOLWiKvbUdDS1TCL5+ZVdOlkTHKyqA2zAJm8bcqMV1I/KBX2MmVH5qv8elT1yMcpv/rii8RcqGxrEFjticRezQNhfUuG43w3pFQUKTFuI3WvXnoRwInMQFCfYi4Xv/woMDM7N+seu2PPEq7I20OInp8GUqt6Pm3ZsPueswwa0ssBVU96JdE2yQIoHOoMHSansfbxZAsdwLkXrFlzzbuqv7IfFZqzsu31Vm8i3SVjtQrdNgOsxHExplkGkCxLs2OsWOmGX7ve+2uw42w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6547.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 17:29:10 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 17:29:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Shengyu Qu <wiagn233@outlook.com>,
	Zi Yao <ziyao@disroot.org>
Subject: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to NULL
Date: Thu, 22 May 2025 17:27:15 +0000
Message-ID:
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0079.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::15) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250522172854.43999-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 697f4069-bfc9-45d5-abfe-08dd995628ec
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|41001999006|8060799009|15080799009|5072599009|461199028|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ETCrvIaZOiysCcP8eizNzkevH0J3Jm4G0jG+3/xAZEzBWMmHtr/lJLMn3djy?=
 =?us-ascii?Q?gbBmeyaI043HWc9ha998mAcXQJxHFI9JtHdFf7Cqbp0qW8RqdBRyZWqcXy2Y?=
 =?us-ascii?Q?dd7bloddd5pv/ugixii00UGkiF882OQIOvL7uhkPdqBkEyRIavhh6/tvX2TS?=
 =?us-ascii?Q?Bw6ttKinANVc6kYkM/06K+x7ZRUlEEpa8WnnFsWfG37L5/hW9dfJUXjsPO9y?=
 =?us-ascii?Q?Yq88QRHWFBRjBfKVcdA8NIQBQpAqUIzEGI1HIdmhXRrazpc5QJfkPpaqhnRf?=
 =?us-ascii?Q?vOtf0TFr7MK/mMkmHIx21KgMO1ugZzgodm8UIXpXYvvmN0WQNzO0L0nUbUYb?=
 =?us-ascii?Q?n6+JRFuDNhV7XRioope4Cic9vCVlddjos/Y27LlN/pGowD6N3g6oXRuzNpdD?=
 =?us-ascii?Q?LkpMFE7I4ZjuWGNOnR3SHmSD03u0QIooaaqvXJUWXfU6CGkdN4b1Pqr8gR1O?=
 =?us-ascii?Q?nh76Qd6HUK0VjSnv5oIg4Re1d+bC8EQ9rHcKgnESF9pG0vm/TA+P8O3tL68/?=
 =?us-ascii?Q?fgo+2YXjHR1ZuVE6I7J8lrpJJyTqTGD/Zx7APeZk3DT+2hA9sEqEzNR2SI5G?=
 =?us-ascii?Q?m+d5vSQuQje5FrhYBglr9auENM4QuSu5l/OM+5Non+HBfflo2CCkWzG4cb7S?=
 =?us-ascii?Q?M0SMIORhVq22PYFdTX0kKsDBD5JxHwF6dwGFhJPJxYRhJ3WxpRhHp84ySXV0?=
 =?us-ascii?Q?6iyQtVvQWzyTal0RVEgdTZqOHK/+dvXa9I4LQOIuylk3IeIhqvXQKYoJtW83?=
 =?us-ascii?Q?sDw0Q3MQ3Nssq0fEt7CB8shoTgf2UkzJMpt95/tsjjJEZb6wjDLikpnN0prk?=
 =?us-ascii?Q?XpfDBHo3C0EEWgROnzITWNw4gCHrk8C6fvFvNuXoAeYGDaqndjiFD2K6nyJr?=
 =?us-ascii?Q?AWfjY0SN/L9cyfzudrv9u3FBfShz3PQ1vQTcEJPHhUil5JYtaQPPaP9HuxPn?=
 =?us-ascii?Q?QFYify87SpMDE42MHk/fwtWYICydafK3SwMXB8Zl/Vr13qXQt1XQT24pbqym?=
 =?us-ascii?Q?AcoIAZxHAL8NAFmovsCGhbsKG3s+SvlDfOQVELV7weT2GmFptZt6VJaFCk7x?=
 =?us-ascii?Q?KS088GHV3D8Bm2rReelcJ4eSqjUk40kPDx/eN6kZ6hrTwrJ/Q7/egAYQ2EF3?=
 =?us-ascii?Q?3+4DXNu+NXV36hBa/zC223fTyb26nkENvE6A71WtosWmc1otg8LuBAE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2mSsgJEUlOgI5LeTcNntTCIaILVW8sRdmTeolHzMArgkS8V7hA0CvdasAp0S?=
 =?us-ascii?Q?4nJVI9BnBC3WnibrzlrOdwRf3xXXfqyqxi/esL+3CNftaZ8Krfm0ZTtDICf/?=
 =?us-ascii?Q?c99MtPRTxd6iCUdT5ZThgnGsVJykgJK00yd2Lm3cBXHMlk3f7IFkFO/lGCNC?=
 =?us-ascii?Q?7c3h3tZupGTPrwzB7kRf6tWClufN+rDj3r1qx4D3/xB+JRTiMVVXCTJwFhzn?=
 =?us-ascii?Q?mCpXq3jueq8caKYfMB8Q1WHxdt4Vs/4Nr08Tes3E1ml3yxFwDUTi7JyNat7i?=
 =?us-ascii?Q?2r2QSmS3lcOnrrf2mYlR8hMRmH/1IZgqlieR/7fGUUUGeWLai29SAXY5rtpO?=
 =?us-ascii?Q?pLkyNYThgkmWKf1LViVK6q5MjdhuWOtJcyPcKsyP94BstpQ3kT7IFY34cPnx?=
 =?us-ascii?Q?QVhkdphEM42ejguJP2jwTTadgMJrxiQi0j9GPa4tJTZ5khkoWWc7MFBKkJBv?=
 =?us-ascii?Q?STwZltndfhrjwaLShsOKDuMnotahB97581RrZkOuXaG1vKYzsueq6UqHkUcE?=
 =?us-ascii?Q?FVI2PrLND+XRD2R/+zIpNvB2bUeHtxiMlSsAj4ofK5NvZBbnsdLIarNxMZMa?=
 =?us-ascii?Q?Sjey0v1WDfOQ6FDevJ8qNiIKBM9pGjz0pC/PIRKJhLEtIPXxAM0/98WXU+U2?=
 =?us-ascii?Q?rffVOqjcZhWPHXJ2jcoXulX36upHumDaCB+H4OMpLt7NEzREY1QSPQhm4L4k?=
 =?us-ascii?Q?9VEFZqUrVW60wqauxuQG4O/v9x7bvPPxXxCPnJkEi9j1myzCVbs3ObGIC9bD?=
 =?us-ascii?Q?DA5h7/mSrhF6ZjJqf5yMaes6kn74CqdMyEb8mwbPr3rNqtGeUWWyl2vj18Qc?=
 =?us-ascii?Q?eEe2LPAb1vM+yix8wBASWf+4u3Azjt2LFhUZFF97ZvCvfDwG+QcpSG1jdYIl?=
 =?us-ascii?Q?9Iuk4XpzSgJEC88o6QRybHZxTnM3tRPSAgm0KRZCIA64kM5n3s+dWxYrjrbX?=
 =?us-ascii?Q?7gQeFM0l4plYdt7oJWUmwx2H3luJ3c9mtXXzYiMMWfqXiw0jtWMEWFeFurvc?=
 =?us-ascii?Q?mop+bNEkocykYD6JxuBvuexKxSZCnWAv57VmfmMyWRE7lmrpB/ncsE4Wge30?=
 =?us-ascii?Q?4hV7eWzCMtKK+FV9ALGkAqb+FvnOFM2X9eVxLZdM6xlQk3Za1uLNKCRz0R34?=
 =?us-ascii?Q?yEX3o7Ki8WGt2oTnFu/qA6Sc/vBla+QV7RpNm94IZVyRx0X7ogJetA7L1WJW?=
 =?us-ascii?Q?FWt6qgfDdslN8f7pbr5W8aiJfuVh5me0Sep/gfpNKeDf1i8VlS5fPxHcie0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 697f4069-bfc9-45d5-abfe-08dd995628ec
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 17:29:09.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6547

Upon setting up imap-send config file, I encountered the very first bug.
An error showing "no imap store specified" was being displayed on the
terminal. Upon investigating further, in static int git_imap_config,
cfg->folder was being incorrectly set to NULL in case imap.user, imap.pass,
imap.tunnel and imap.authmethod were defined, and the values that these configs
intended to set were not being set at all. Because of this, git imap-send was
basically not usable at all. The bug seems to be there for quite a while, and
has not yet been detected, likely due to better options like git send-email
being available.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..37f94a37e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const char *val,
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
 	} else if (!strcmp("imap.user", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->user);
 		return git_config_string(&cfg->user, var, val);
 	} else if (!strcmp("imap.pass", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->pass);
 		return git_config_string(&cfg->pass, var, val);
 	} else if (!strcmp("imap.tunnel", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->tunnel);
 		return git_config_string(&cfg->tunnel, var, val);
 	} else if (!strcmp("imap.authmethod", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->auth_method);
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port = git_config_int(var, val, ctx->kvi);
-- 
2.49.0

