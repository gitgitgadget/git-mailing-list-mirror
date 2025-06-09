Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5F221562
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500620; cv=fail; b=stUo0T4B9liHbsKfHLZzfDFbVuKlaGUhQiFqVxgik0DKRJx5yYMDHyFfzy9yt40Gmj1V0QodVAoG+pEp1Gvd1KhhhQL+ifmlglWABHgLscRFQuVWuSUuCNjAEjAuCal9KJ3Ep9huG7O+yupyHPcjgW8wEiPJzLyp/iK7jc0Q1rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500620; c=relaxed/simple;
	bh=DHG9eIv0kqiwUs2MknVnXzjo+LLWON5TR5PZpSUWn0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o547spOINuRFmIVsDF8HmvcVJixeJ0l7HJofBOhYO4/vEFi9MzeYB0KLXjR0a0gDZrDDZudiQHXS8Zqa0CH7FH++IUapoy6jKN0K6rml7/Jhjr7OZtZE2jbCh0hdVXGTi9hZXFkBZoJyOQHA69eE+ZFwaMqpPIF8Yz6Nmq5C4jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=vFmyoWrb; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="vFmyoWrb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo0ZuU/Wvg+ZB/sBcAt7UKjEQrdOTBSx1GuNIh6ZUBG/420RBSxFgR6508EdGGxZqxBz0r6PVlT/2SPxddsoWKvbhmAO3CEvkOIRw4goBSIQ8QRnvHI2kGshGmc6LRt/Yl8F5OPIEsYrie8OrF3d4wP2U9wqCE+5pGwi2FO4/klynSPq738rQ8ZmRrxZjp9YCzvNZ+q7MwEMZTIzyK+zsRpyGM9VTAOMlnjruP+pUcjYMJBNC7Kt8YIpEa3DlEwjWHk8x5joSJV9w8t00MXM3THwh+NAHHIK7YoIWXMPuT0po3aEVCZw+elHnmAkFHPIHsyZNhiLVdarVVZvzUTElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9heQIJJVysJkXJd+GaAjjS/rs0Lvh7TT//lwXf3fGHg=;
 b=GDzxTdkILMalu2C3n5AjW60jYJ4utSj4npgsP5KeqdoOyDeEjXzWFbdTWJ0pFmtPjQFlYVAhElJI6V+BHAUEAVl/TmribENWjhOARS/c/b1J6jYy9HKT1foQN5yPh2rXFGYsq+sxILoraFdAHh0ivmWWngh9iJg1V+TBJWhJEVlllXhr6JOa3aYOPt4L0UvVlA8oy8stohsbsG34nKhiOjsMXlL9fQW2J+WAs+MbgxTNAtE1BZm1o6pIF4HJrNxNZkArUMiTz9ApPXh23+0J53IbBsTRDUzj3JL41oxNrqi0q4X9voxDTwWgmsKtvDPq2Lf9ULkA+zn8bSUcV0jk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9heQIJJVysJkXJd+GaAjjS/rs0Lvh7TT//lwXf3fGHg=;
 b=vFmyoWrbOXSAoU6Fzw5FC3emAODINOeGTQqrDq20Vrh9DgdewpNPNJdGF4ChvJrkKT2CHb35kbbSPQPtvqfbkCMPdkizhEOC68FxEbsd9bsJR73LoQ4AeV0DWx1f9joR2qcVlauvGtJ5voaRh7z/3Qtj5a64/KSehQvcel4Lh5u2M5yRLYbyHkVK1uv6NZxjHfL6Z6Qhz1eI1HMJUCsB2/JpMpG8M0KRLGQhUxRdCEh1VJvagY2SBjrfosLWxWLq7eDp9YDxlQMVCLCEW7F3e3zj9QX47KgO+ndQ8i08TvzhuF/iecVaU9UcyZ7jm/joWrAv97TNZKIaLzxstn60Fw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:26 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 02/10] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Mon,  9 Jun 2025 20:22:47 +0000
Message-ID:
 <PN3PR01MB9597FAE32CD2C5EFFFE02F52B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c049e4c-76a7-4417-bd1b-08dda7937d6e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2aeALiPqMLOQEhLhTAVuNDBL2VJr3xEtv802t95v8qqpQwh6JKuAtHq9c56L?=
 =?us-ascii?Q?p8TG3pRM6HUUspSbfEzuwplGfBuPcKeJXvQnT5Z46ArWCvQCsqDQDDzPI7tH?=
 =?us-ascii?Q?19O5NNgWVc4KoBEGaJ4atztAqcaBbn7A3a2iV0lPWqpgyYR7QjhfYSKokzpk?=
 =?us-ascii?Q?u8wftkpnbUzgkgV51MbIwsmBdu+DI8qQpFipbDSak7KvMzeFrgHzVaqZ18BC?=
 =?us-ascii?Q?57YooX1DXr0Q+KvPZOnPPB3bb9sAPmk8OSGPMgXPFUyPDg1vlI8x4gWGQEZJ?=
 =?us-ascii?Q?BJVuI2ioJgkLyDuG0ijbrL5gkGCrGzN6+3V4bzVwT7raCK2LMsDN81C2aOHs?=
 =?us-ascii?Q?GMslBRg4rwAV06UUo5SFXGlaNcPjwzC0ncWexx6/75u081iqrJIQlgFx0h27?=
 =?us-ascii?Q?6Q+eOXxlhvkVxjsH+TpBcLtCdAd4oJDapYYKv07HGRWf0aBsgjfTL8ESSGNE?=
 =?us-ascii?Q?XtWk15gyqFrWQqZ8wjH0/Fx7Rt7u5n7AWAMqBcTsHwBWh/Vj0jeCtdTQM8jj?=
 =?us-ascii?Q?4sBD+5JPNy5vJ4KJyEVC0bjj4EcfTDGroISdwzhFnLP8GRNYjumPUhm8DwJ7?=
 =?us-ascii?Q?TRzCl8aOgxa/KtZojK41WzFkWk6sUPHUWQx9MZtRlEWTnVN2gMFkw5LLLv9i?=
 =?us-ascii?Q?YOcuCa4tEZbhRgvg3CYfPIUFIg4rmtX2PQcS/F0Hz/8FSWokoeSg2FwkwTPy?=
 =?us-ascii?Q?Z/704+6mXbn7YxxPZmS/492YmbILA7OaboUHJso2u0cdFviOo/cq52s2M0qr?=
 =?us-ascii?Q?IDyeWA25XR+3NfGjHn8swILne5du9XurY5mLWjgq4QeyBXcljib4jdoUfbIb?=
 =?us-ascii?Q?1XKxFdDmiJYwyJTNTObBz3BXx92HNTNg7bf/TfxgsyFLFPHImUl5eZ+IvOjl?=
 =?us-ascii?Q?zaPaxhI/PCj4Z6UZzkb1DuBJ+ZN65Qey9qElkNvx3JTHrmW6qDymT4Ifnjd8?=
 =?us-ascii?Q?csoLtLTHmO+XkYVKmhMSmTThhshOA+UHJqwv6excvBUTmDl0cT/n4Y+8TuCU?=
 =?us-ascii?Q?8Xsqdu3RQCTsyGGW+SbLUhHW7lCKpt7LWczLgeOrvQBZTl2AuaqG48+GfeNP?=
 =?us-ascii?Q?zig/ylmWC9JqQbC9lmx85SGbZyq4fJ/CUlJQjxcHCGCxd+re+a//xCyZNnic?=
 =?us-ascii?Q?ZxJ93m+tK5SF0KAx2Hw2iUwQACrVyc5GknNwU90FD6b3phxHPxKBce3S+tmY?=
 =?us-ascii?Q?epYw2eu7L+/tDCCBeR5BCFh4nnvwYQS4stg5eQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTiKoGWv4NAXn5dUqWa3bKzZY7OLohJ8xfJUSBaCSS7z76IhsyS9IIXr8OYp?=
 =?us-ascii?Q?lNCjGjs8GZhntpY8o2Vg0h0Bx1cVWBU0TOO5N97jqAR6xOn8vXy7GmgO+0Nm?=
 =?us-ascii?Q?4/tXTxrxsRHH7REGytaIPKWC5PJgnLsSXOCcAUuIZEfJLmRdqEFZNwqti/Kn?=
 =?us-ascii?Q?7R25x5CzZmoOelvVkRXARSAfIHX8qOOr99Bl+isVH+XmqcsEJl5dZqv0agvi?=
 =?us-ascii?Q?03oLpAFfvSNhVSIsx3vKNyO3D1CRsOxdoWGQ/PLb+phNKd34rcVv1tjOzMrD?=
 =?us-ascii?Q?5jrQorY6TTSj7soYCkkimwDkP5d5nUC2LicLkmsQWgjTAaKlFK9dBve6vlry?=
 =?us-ascii?Q?Nf74Q3xxRegdupI2RaUmhF4P4QjK6bmAt7AQ8wgtxS4mCf5Iykne1t+mevkN?=
 =?us-ascii?Q?v+G7NZ/5dJP/IHYs8durtfTMZotOEdnK+gMc6Ns1YL0gH1jxQ0irmQfTVfeG?=
 =?us-ascii?Q?VDvfhBhrMlI/4N7Rs5V6Nv6RbEprEG2lj5+j1uvADARsMs8ZTPQbvUCoEmCO?=
 =?us-ascii?Q?HKhFCIWoBTZahrKI9hVc7LHFYABMoQokSMRblZghKwn2pSpAqc1YeTURly5e?=
 =?us-ascii?Q?cP8f5Ok9lDH14TuaXub85MoYfL1fWRE+mNIkGoZYIYMJJB+f4hrlN8R1efaJ?=
 =?us-ascii?Q?FDnnUiaJFXt2IWjMw7vQXV8aGmoSI1IGzY618+/cp5/e5VhQ0CJUlIabYhgU?=
 =?us-ascii?Q?9oUJ9XGIGeoI0ZEjSknBaIN42zsWOp+72Gw8B31BZLm3U28Qq3voonLkz/3a?=
 =?us-ascii?Q?+lFJR9nJdjWGXFCc8xqzbj50Uk3+c4ShaCWmn8Dji8pESChyfvocrwe7BjBM?=
 =?us-ascii?Q?sUB8ARDMvvWPRDLv2EaRCrJD1Ajilk6O9XDZ4j1CouLdEzj5ii4LL1cL4MwB?=
 =?us-ascii?Q?mNVkaX63RhOFKBIaykwerjglbtAzo0h85EiZYwgRL7wQOidGbKNneTzMa+kw?=
 =?us-ascii?Q?vRXwfgX3Bc1B6YjeDS3rCJIhrxzoTDOtSkGaCk3q28eDPTUYi4NqguPtla6Z?=
 =?us-ascii?Q?R32ZISLXU1iajHyG6K3A1RMHN5vFQe2cCgEtIekcrcN/S3S6frJ9t8QoifX1?=
 =?us-ascii?Q?KPk9vZiY0YaDV6QS15MHau6w1KEf804opHLxkQn+OQIsygMlQ5uFjlsm4D0v?=
 =?us-ascii?Q?BdjrWrpVcgzTWjJ0qmEGTubAtqMegF7/I6WU2hVxR1WQRpLMMtvgmzjBRi6U?=
 =?us-ascii?Q?dZYqeI306pzgw5DhzUQ74iq+74+A0+un9/a8E74nFtG4FuAr3k4OsokUPmA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c049e4c-76a7-4417-bd1b-08dda7937d6e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:26.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 3eed2360fd..cee8f5690d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -905,8 +905,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response))
+	if (ret != strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
 
 	free(response);
 
-- 
2.49.0

