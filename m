Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A394223DED
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401669; cv=fail; b=uvKD6VYtfK7QJSRpdcxeKGgAIJ6i9sQ5cp1lTngxcp72lWee+A4pRy3ZpzS4dK/yEKuOojrBhpwNDXST/KR0qzAo96Sle3KciFNDI4gkdWHDuhl0Dlkimb8qx3lO861oTIC7b2jwvn4kTFwKjFPqJ4wNi+f2uVLw8H07YdbS1lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401669; c=relaxed/simple;
	bh=OifduXe9nvjcxYPv1DOlE9wufd1CPF+dsEjbG9YwP8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PV/y50/kS9e8O4uT8AkhlInYmqlsYiCaQ7Pu1tlTYNggDaCXPtFvFkXjLzyewd6UdclllYm233IMOMFfXoTtwwtM7tqHcFW9mTN7l7kBw4djZQ4WxXI6tp8Dyqz/xVP+YEkuqBnEmhempE81RSENz2rrnZbBy3U/FPwAGC7ezqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=OKCtTAVa; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="OKCtTAVa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfICrN/85j3xfuD5n73YaQTPUbGzYjNnEMtrAlMYknGdJ62eRl/7TmOsJ0Td1Qe8nSU6+84tlOKdEPEKxNAuXM302cSaumL7kKpB7tAgbf6OprHPen8hWfDgwLCuSn/xTvmkJ5mzRmz1ZK6ihR36nFH6xucNVdzr5WTGxAi7BTtM3wYWPLfHcepWivAADOcUcazOtRRzuwL99P4C82XIXrjo3EFXOyDkRo/lpMeTvAURRml3ydmMc8izhHoUBtQvlZ/SArngxycCmmnkaT/cl7kWxdraQyKoqrfXuLQeWtJV3fw2DvQaRxaq+uDHelRaIW1jeXNvpg6rWobCThQ2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXTDUxgz3ofwRL9A6LjZOnl9bp/q8cquZ+ry3v1xgnM=;
 b=Ot8dW4zlb6mpqhIkoej1/60iPRWVGX543aPxA0O6/t7Z4I6h+2dTFA+iE52+MejMrsH7tfslMA9Iga+qDs9ZIP79lA1nfCVvJigOOHgXGS055lcg3FdSPao3eKVzeArtBQmGZVMAwJDsAiWwaHOK/ejAf3MgMtpcQGFdl+QuvbwqyakmPjrIt7jmYugdNf9JTDEvqXH4WOnkYbytui2gC+FPnWmhx4X+aJVqAC429QsVFw9KDa/wa8FW4HVMaz3B18IyT907TcQpOEOreMHTIx1Bd591MOXamITDYp0lG/jRf15kWnJ+KwCjsi3VfioQ34tY/xToWh+Kgzq+G3ft5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXTDUxgz3ofwRL9A6LjZOnl9bp/q8cquZ+ry3v1xgnM=;
 b=OKCtTAVaqedmBHITqN7D0U1BVInsM85GUf1aiKoU7WrJxMcBe9D8rkxdtuLVSHuWyTB4l82GMHusLIRT7l0ohJXn5R2JAbRrEukCnSTWZooYKVEj6B4GNF/00Et+M7+S2WFiHdhU4792TR/0Zawv1ml7P/xSfKbyJ6ZeYrwqnU9L5HdZs6QMHMUauznOzAZrfry6afuT7R5b83/iWR6e3PoYM8QKouP+b1GT7gq+OXXcjq6SFEYTqm7h4DaSj1tr9Kz4U33Nw0pLEKB5l0vNHQnlGtBFCMW3zHb8rfhWVl4JAGwYx3yVBy+lKivGpCAMkGaMCtj8cSyTJEsrxsYDZw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8150.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:57 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:57 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 08/10] imap-send: display port alongwith host when git credential is invoked
Date: Fri, 20 Jun 2025 12:10:31 +0530
Message-ID:
 <PN3PR01MB959780281881514C0A6FCB55B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250620064033.15814-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: ce69a8df-552c-43db-6c9c-08ddafc567cb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|5072599009|8060799009|7092599006|15080799009|461199028|41001999006|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?67MY7n4wiV8boQ2rr1SBkuln7RvgjNj0A3MJALZwzTXtvc3TYwatgUbNueOt?=
 =?us-ascii?Q?+vh16x9IEGNy1iHzliVP+YujsBZUG1z7h6V2E47zJUCKBz7xr8xf7dFj4ED+?=
 =?us-ascii?Q?tNrJIlDKWYOC/V+OLiB+/BShvEVwdDzrnKfHzCLswyPN3vw3M2xdmnhCbodw?=
 =?us-ascii?Q?iZwD3/F6ljmpHmBBaWdETdWUK+04ZIC5uSEMtR4aL1+x3J2d7I2V6BoQfGRI?=
 =?us-ascii?Q?fcqgUVtuuQ6Q3KNTa9bA8W+lsDHoBFCWSHPVJ0GIx5xNsfsJd81gWTBBZs7Q?=
 =?us-ascii?Q?HdhfOj/vjWXdQyPKMcusv+GFwCeInbGakkYVHk+kBAPPiMnISwbllfSdZqMh?=
 =?us-ascii?Q?wFFzN2pkuSmDDXSRzrGUnMWYVPIv+v59coEdbiQjafyhbZ8Eg52E9JVfL/S9?=
 =?us-ascii?Q?6DhOhEqKFkTl1wx1+gMHKDhcsaJFmEVsswCk2liyRzAXtCurIQDiakonRNHZ?=
 =?us-ascii?Q?BeO/xxIZx5N/7l2OFIS1GOVRW/WuHT4grBm65tcspgQYQHye3Cgeq2vaeOaK?=
 =?us-ascii?Q?9hX8WZOss/D8PgKRYMzSHGxLqHu5jDSFGd7flpuMNIDmiOADHhrXNDC7TzOL?=
 =?us-ascii?Q?eRGzbT+G3SXy94yZGcqrmAq4A8YZkspiZoFjaNSus4IR5ZR7lISSu/lxXkLK?=
 =?us-ascii?Q?JWeFNW3pOIL/yWZLfSoq0coZXa2G0EQG1ehRrvACR1B12/moNmWz/C5fHRel?=
 =?us-ascii?Q?z3/+TLQNeuCkayMFBOKd2v84N+i//6qwvt4Vuz7sz5HkwkUHWmWutKz+vXD8?=
 =?us-ascii?Q?jQlAOSnUDOYD9W4KCiG5kNe8C1OGqpM1VVv5UXs/kYZc/uI7LyawbuEqy+QA?=
 =?us-ascii?Q?GvTfNDGlYfqzxfBDXgBIlZESK9DpV7YJDleNyLeyPomXrEID+3+R9GdxwMJn?=
 =?us-ascii?Q?ctXjbZmcOret59nPIoYcAoyjWYXyK7T+Bsq7Uvex5iRgBzrjXVuUACtyixWW?=
 =?us-ascii?Q?gnY8aUjU9ar4uOkHMPneLxxJta7foGTi4z7fEy05VigLgY4luIbDNX6j5LJF?=
 =?us-ascii?Q?6mMydOh7tNpKibhgpjm4R0wT9quou02Em9Vn6QvVe4HYgAQ9hNZPP8fhdJAl?=
 =?us-ascii?Q?qpWHKyTKWRdySWMAky/Rt3ekvpA97Juxh6Y5MFiHeLPtgpaPfas6jizvf/sP?=
 =?us-ascii?Q?WHLMQeYWWDI7MQNKxALXcAnNvbOMVIA3HCTj+vV3chjrKmGpqgTNLCY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KvZOfLK3XqW7+3z730atcsy+4npdzqj2N7SCH5haGVw9SYCB1ZChd40puGao?=
 =?us-ascii?Q?tZMGVdUnJK3P8gT0JIRg6nwHgwkPz6Z0bsvAieOHdXxkGBhTpcmwYLAHf/tG?=
 =?us-ascii?Q?7wttRA0e/4uUa3nqGyiVhw+AiQOO7A5kk+FHlvzWItTbLj9L7TNHiY1O87px?=
 =?us-ascii?Q?InBCZclznUXb1olv/6lqVX1GHtV9DD9TNXr2kG7xQLLBnjrXvfMA2Aw1vJ47?=
 =?us-ascii?Q?yv40LKagjR9AZbiVqjCgVmYLnao6++Mr6d4+IHYQolJ4dlvTMOMRYhd9hFrr?=
 =?us-ascii?Q?sDsjTYS0/0+K9l+F50INcaht27vvpnqUFCSqcEd56zdaCbgJTOSGNpAK0wON?=
 =?us-ascii?Q?5i69JEmb2gcePc4JvSebxQqp54C3cnXGzffwmOvTBXcVXZW8kXa78Tr7apwZ?=
 =?us-ascii?Q?1AoLP4ceoDJcwUpV7ZkDRSrUUNPAcrkmUQQ46dwqLS1qGmokvM7St9VA5RoN?=
 =?us-ascii?Q?r204D0lvcPQj9TWW+drxnpbgaCEnt734bdtmWuqXwcaE8oep5VigZv7vuq6M?=
 =?us-ascii?Q?gKerfIGnLj0es+TosLgp1iccX236fs+lgSVJdkTzxNXPxfX48cwxoBBhQ9tR?=
 =?us-ascii?Q?Ivod5CyP3++8lB7KX+QEqV5dmoZUya0N1QjlbF9ZF4/8l9tfYT9Anqa9d4AY?=
 =?us-ascii?Q?PuNGLcG4WEC7xiKmHPZK+Rr539z3KwDV/LMa+GvK9g4VRUWEIVtS/FRHDabl?=
 =?us-ascii?Q?pxOxAI+M2inS3QpxrJn5e7/e9w4DbRHRx+efUb2sOmWyJzbhgr3yvB/RUpHX?=
 =?us-ascii?Q?LZJcjJ8BMn1ea+DvG5m7dTqq/DOOy5n9Xq446PJeJ++JherBIUVwVCadlhlZ?=
 =?us-ascii?Q?HW+hmDx8lwern0CytklXp2V+RMZa3d5rNRAOq3xzxqulcQVFY6TPWIaAkTv+?=
 =?us-ascii?Q?BbdPE+Kk5EvCBngNHh3CG01UVjN+9lwvg/KLOn794/wV+BCb77acekZtDbIF?=
 =?us-ascii?Q?kk4V859mtlIaAymrraWhd/1FG5iCefX5Y6WB0Q6Z5L4txhHGuOcoedG5QqyZ?=
 =?us-ascii?Q?q8QEXIwYFQF7UUDk1CHxBHzjscMVHRfF5+YCN5C5wWOKDmdug2SC8IqLZW4I?=
 =?us-ascii?Q?rG+T2mAPHQHwb3regWSbECft+wOHJ+hR+C87DXV9miuxoeS1NFwTWEkWiUss?=
 =?us-ascii?Q?Id5i0ER7WS0yqcZ07N2bJcuHbpcITvXoT+8ZXIyTMEoSmJfTbqMHa/6L/3mR?=
 =?us-ascii?Q?218XQFy57kNTK5r1ZfybF9V3+GUx7aGt2YPVSHsgYCduK5aeOUSI1pbLDmcJ?=
 =?us-ascii?Q?R0WdpfINih6OnAp9XoDnDG2UI1HhmbXPE42C51gac1SU/l7k+KFh9gacB748?=
 =?us-ascii?Q?vOM=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ce69a8df-552c-43db-6c9c-08ddafc567cb
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:54.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8150

When requesting for passsword, git credential helper used to display
only the host name. For example:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com':

Now, it will display the port along with the host name:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com:993':

This has been done to make credential helpers more specific for ports.
Also, this behaviour will also mimic git send-email, which displays
the port along with the host name when requesting for a password.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index b1dddaff3e..ef5cf0a395 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1082,7 +1082,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0.824.gcc76007b2f

