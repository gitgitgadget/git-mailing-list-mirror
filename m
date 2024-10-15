Received: from DXZP273CU001.outbound.protection.outlook.com (mail-uaenorthazon11011037.outbound.protection.outlook.com [40.107.54.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619D1F131C
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.54.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994704; cv=fail; b=lI9EJOzfUZ3JswJezC473De4ZhPn/oRCvEGz7CVOzl+Pn37HF2i9z81UCza7DreU1Y6MLSICsYSoGBmtVYqZpaowxA+xRpIUh/z64SRj8G1Nv2znukdKncU/19BZ7wnf0l2gndOsvdcrX25RiH/IMP6pGUsCMnlflYeQZowj6nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994704; c=relaxed/simple;
	bh=AaWiRPDwwu8+rIOWqDjCKOTVSq0J82OB0MRILkhg1UM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5WEoUjBZ2j/8vdxUg8hnf8DZ8kDhIU/0EhKbx4LmiadaKlmhiOPTL3d4boObps3p1CKwkx5laeAtSfoegYI/6DPbHxs4TmFqlLqp1l2mCNF8DFRX0y/dMoL6f04fwmMFyzIXEsELCsuHQrWFMnTlNYdF3itvziTsQGeae4QpU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cnsonline.net; spf=pass smtp.mailfrom=cnsonline.net; dkim=pass (1024-bit key) header.d=dpworld.onmicrosoft.com header.i=@dpworld.onmicrosoft.com header.b=LWScVf9I; arc=fail smtp.client-ip=40.107.54.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cnsonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cnsonline.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dpworld.onmicrosoft.com header.i=@dpworld.onmicrosoft.com header.b="LWScVf9I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAMYSXpvPsIJ9QK3aVuJfSQdr9p4oK4IKB5K4P6FDxIFnCfKZO08rdwVS9cd1FZ4UTI+PbQSxhyPz3lda8/UChuSY5HRXfYIH7OyFjTiD4TnsgxAUxECnhNM1/6J9W5r6pMjg1Da5GGVqzs6E7zRGwbO5r7j/wVwWAYIkFrfRxkflscsuQ94Yfm4tDA0meqaf9A8KyCMKLtJEIq7xgCxrIc4GZsae2Aasw3ioY/qKgTsVwLVoVEaaT8PRU+X1t5Q1qv/oUnzwoRDD38w4xdo5hVjD5VBZOc0nfHKX/gCWM9up5oG52CcuMvHtxBDa05bYG2X8akzrxd9UX6rlG+wUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaWiRPDwwu8+rIOWqDjCKOTVSq0J82OB0MRILkhg1UM=;
 b=xn6aW/B1JuChXQm9rReEDP/F/MifvBzVoB01J3+ZiYOeNlTLgASweN2rdJvnwETSwU257xC6PXUBfyDR5PjZLIUY8TLBH4Oa9cIhngZnT5RipvoEz/AIOqFM8ZeDr9G6T2AcmoNLZz0GpRd8U3SeF9NuTWZmpUku5tkewCBi8uxGch6FFfrcuCFqjk4c6QHIwyxYeCekQFfehdpnsGNH6U1q27GmqnD/dD7asM+co+7Hx1s/zdKKGKBXIpyGN3wKFOrZjpCQA1awtGuyFdKPARyiM2pC/dr6XyBJg0jAtyuEfM7SYZEpOpIGrAJRDLssoclVhvDUH33hb3LMbhb2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.74.131.131) smtp.rcpttodomain=ttaylorr.com smtp.mailfrom=cnsonline.net;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cnsonline.net;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dpworld.onmicrosoft.com; s=selector2-dpworld-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaWiRPDwwu8+rIOWqDjCKOTVSq0J82OB0MRILkhg1UM=;
 b=LWScVf9IxaR+5/YbuO4nBXzM28hs3O0bEZo91K1Ia8FoLjTsJlxvtkDrA56k4XKtICssbJ/W+8HDT+TLL3U8500nPXJaDmClkzYIogxJWh3MC1X4MH+3kuiTcP526ciRKUUgVemgqUPWRf65vTEVOg9QMyIq0A5+UFrEpR9KGWs=
Received: from AS8P189CA0043.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:458::24)
 by DX1P273MB1624.AREP273.PROD.OUTLOOK.COM (2603:1086:300:88::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 12:18:15 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:20b:458:cafe::a) by AS8P189CA0043.outlook.office365.com
 (2603:10a6:20b:458::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 12:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.74.131.131)
 smtp.mailfrom=cnsonline.net; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cnsonline.net;
Received-SPF: Pass (protection.outlook.com: domain of cnsonline.net designates
 20.74.131.131 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.74.131.131;
 helo=email-signature-server-deployment-84dc76766b-mtd45; pr=C
Received: from email-signature-server-deployment-84dc76766b-mtd45
 (20.74.131.131) by AMS0EPF00000192.mail.protection.outlook.com
 (10.167.16.218) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13 via Frontend Transport; Tue,
 15 Oct 2024 12:18:13 +0000
Received: from AUXP273MB0503.AREP273.PROD.OUTLOOK.COM (2603:1086:200:25::13)
 by AU1P273MB1951.AREP273.PROD.OUTLOOK.COM (2603:1086:200:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 12:18:06 +0000
Received: from AUXP273MB0503.AREP273.PROD.OUTLOOK.COM
 ([fe80::ff54:5a6f:439c:6504]) by AUXP273MB0503.AREP273.PROD.OUTLOOK.COM
 ([fe80::ff54:5a6f:439c:6504%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 12:18:06 +0000
From: Jordi Balcells-Smith <Jsmith@cnsonline.net>
To: Taylor Blau <me@ttaylorr.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, James Wrigley
	<jwrigley@cnsonline.net>, Kieron Clifford <kclifford@cnsonline.net>
Subject: RE: Git bug report - CNS - Shared repository permissions issues under
 RedHat 9
Thread-Topic: Git bug report - CNS - Shared repository permissions issues
 under RedHat 9
Thread-Index: AdseMbCJ7WEm6Ip9QeCqErzSBzroIwAaAOsAABhP9QA=
Date: Tue, 15 Oct 2024 12:18:05 +0000
Message-ID:
 <AUXP273MB0503E37C64D153D4C76A87D2DB452@AUXP273MB0503.AREP273.PROD.OUTLOOK.COM>
References:
 <AUXP273MB050333B19CCE93899FE9F26DDB442@AUXP273MB0503.AREP273.PROD.OUTLOOK.COM>
 <Zw24GJnLlqTuCOsM@nand.local>
In-Reply-To: <Zw24GJnLlqTuCOsM@nand.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_ActionId=e07693ee-c5a0-4d50-b1a4-423b6c99cd43;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_ContentBits=0;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_Enabled=true;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_Method=Standard;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_Name=DPW
 Internal;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_SetDate=2024-10-15T12:08:32Z;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_SiteId=2bd16c9b-7e21-4274-9c06-7919f7647bbb;
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cnsonline.net;
x-ms-traffictypediagnostic:
	AUXP273MB0503:EE_|AU1P273MB1951:EE_|AMS0EPF00000192:EE_|DX1P273MB1624:EE_
X-MS-Office365-Filtering-Correlation-Id: 5928d57e-4037-4ddd-dd68-08dced13711c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bUdqWk1RTGJRbmxMeEEwUVNtTkgzekNuTEhUaUszSWhtczB0c0ZlM254ZVRp?=
 =?utf-8?B?MW9vbHdZcWtSeW1DWHFEbUF6ZUFVdnI2SU1zL24rTUw1Y2U5T3RMU0tRNVIy?=
 =?utf-8?B?ZFlDQWJyanlDcnFnQUF1TEpXS1g3dDhlNk5wRHRHa2Jmb0JlT2w4KytkMllJ?=
 =?utf-8?B?ZjN5KzBobWlUZEtyRlhjd0Y4d0M0TjFZbUxRS2hoRS9yZkl5OXJYWmc5bS9V?=
 =?utf-8?B?UGNrRkhSczN4d3pwbEFZSEdqQ0hCdHpqVnN6U2hnNVRnV0lVY2xWK0hUOU9K?=
 =?utf-8?B?dTdNazd6NlBlV3JxSFNyNjVIMm1pUmswREo3SGxrdlBGTndFK3h3YXBEbmto?=
 =?utf-8?B?VVk4T3A3ZlMyWVd0MFNCc1Voa2YvQTR6OE5WcUJ2dUJsY3JXZE5kQmx2VENl?=
 =?utf-8?B?V3pqeVQ3Ti9PRkQ1a1lqZVRXRDhibnMxWjAzSWl6a0VxTzdOVUl5MjRwOXBM?=
 =?utf-8?B?RnNOcTl1dUU2Q1oyMEMxTFQyOW1vTHo2cnNnclNHQWY4dkRtRFNsczdPTWJI?=
 =?utf-8?B?eHVsVWw1THVPMUpuSHg4ZGtRUG9EK1ZsN1NaWVVuVUptOVVuNGFPZ0VCVFIy?=
 =?utf-8?B?WTlLYUhESnkxc3c3VkphN2JGTEhpVjQ4OGZHTm83OXFxQ2tvNXp6b0VPZEFY?=
 =?utf-8?B?dytzcURxNm9yV0xrdXFFUVN6YkxDWENoQWkzc0x1aUhPOUlHbUxjaTR6Rk91?=
 =?utf-8?B?U3dHMDBKUmVwODZUQW51SXdjeG1JUTBDeWg2L2VNbEVhVDlvSVdxenQxaWdL?=
 =?utf-8?B?WFZWRXQwK2Y5a3VqanBCRk1qazY4SThxbTk2UG51TkFqUGV6QnI4R29lOHdD?=
 =?utf-8?B?SG93cjMvMnhKcVkwd0ZwYTZNai9tWmhkeCtVTzlFUFJKcDJrWlgzNUZYYmRw?=
 =?utf-8?B?V2xldjJzdHpGaHBPeFhHY0xLdjJqOVB4eUVlNzM1dUt0TE9ZWGdhRUhaR1FB?=
 =?utf-8?B?VlJxeWdMU1Rzd0hxNlN1UHVzbVpScW5XMXZodUErNi9vVnNLZlk4SkFzRWcy?=
 =?utf-8?B?QWZMbE01Tkh5ck1iZDlmY1Rja1ZJRjh1dlBwbDdkQlhUMkZLU0VUdFc5Qm5F?=
 =?utf-8?B?ODlKVTB6VmhoVEoxZG54WVA0K25USlBFbmE0RU13c2JVM2FCYWEzdVNmaWlF?=
 =?utf-8?B?cjN2MDQyYnhUNXZvb1ZxeWdReDNPVjI4R042SW0rQmFDY080aDM2cHF6YWg5?=
 =?utf-8?B?SEtISVBKbGp0OW1zWEdYdFVlZ2FPb1gwckl4djhKempmVjFQczR0dzI5YUwy?=
 =?utf-8?B?bDJraFdCcFB5RHgxbFlOdE8wMXlXUk9wbldzdU4xV0NMcnFEbnJwYmxuaUUx?=
 =?utf-8?B?Z3Y1T2pzbWFkWlZUQnBVMkl6Q05iN3FqUEFnL3VaeVZyL2xaMU9lT0tTMWdu?=
 =?utf-8?B?UUNVRWN3WDFMZWtHN01DcnlIMjBJeTJBK3EwaHFib084akZ2eVpsL3dwZ1c1?=
 =?utf-8?B?RkJ1MGNPY2NLTjF5VDU3bXBqdFpQdGlxUlZlMkY2RnhhZkM1S09WQTVOOEZ5?=
 =?utf-8?B?OXlEb1VFUFpLZUlxQXMxbnlENlhKazZjMUgvY3JsRmtETERBWU51RlpweUVT?=
 =?utf-8?B?eHh2QW52d1drck9xc2VPVjl6eU9KeFppMGlxYWV0TDNoQ3ZNR0tNQ0ZOd0pL?=
 =?utf-8?B?VnVWMFlQVWdNbmlBbWdvNmM4bldpd0JFTy9XS0pUWkxudXFlb1JIaHgrdmYy?=
 =?utf-8?B?UXVaalRFekt6bDdQN00wZ2xldjU3YmI5OU10cG9rakhqQ3hlb29CVHlPcXZ4?=
 =?utf-8?B?cTRVTHpMY0lqK2VRcGxhbmNPaXltM3V6N0xLU3VuKzlURDFzRTlTVkoySHgw?=
 =?utf-8?B?WDU1TTVBNVZvOThKSGRXUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AUXP273MB0503.AREP273.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AU1P273MB1951
Templafy-EmailSignatureServer-Processed: true
Templafy-EmailSignatureServer-Version: 0.2.4.2957
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0d747505-f185-4b29-4181-08dced136c71
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmxYWkYwc1NCVTRKdUVzMVh2b0ZKUUZuTWd5SkQ5K1l4UGxFaWJieDUvckxL?=
 =?utf-8?B?K2w4RlR2Z3lnTmh4TGQ0ZDlQNzU0cmVLSGVRSnBPQThUUHByMS9jdCsxaWg1?=
 =?utf-8?B?SSsyVVdsUDE0OUZ4Vy9zUTd0SGsrdUlkZStMQnFPZ2NxR200TExWblMvbXhZ?=
 =?utf-8?B?bHkxSDN1NGlHY3p5eWVoQk54aExLUDZGVmRwTkhYb3JDZG5FTkRRWEpKZlll?=
 =?utf-8?B?SldXRkhPK1RwbXV3a1NOUGNxRWdCNUNhOE4rS1ZyVkpyMmk0dS9LWTBpbEw5?=
 =?utf-8?B?YnBoZWNQSTdPc0xHeUJWQUIyTXV3QXdYTkhITVpMVi9nSHZmdWtQdjl6ODlo?=
 =?utf-8?B?Y3JlQ0VXOWh5Q2NJZmhMYk0rdWh1VE5TV3BUTnVmYXBEUHcxZEQyY29zZjYr?=
 =?utf-8?B?aitta21meXdhQWxXR3hQSjhYV1k1NWRiTHdiYk5MSmdOdzJlZFo3U0NhTTB4?=
 =?utf-8?B?QVZuYm42cm4rUUJ2dlhySGZkZlp6ckc4VVNOM3NzL1ZBUEdZbHRjRjk3dEda?=
 =?utf-8?B?dk43YXRZU1VkbytMK3I1NjBzc1dQZzdlbHJjcEE3UUtPNzAzbm9UcEdnNlJJ?=
 =?utf-8?B?U0VWVTh6TEdjRlVCbmhLZFJvcnhjRlpuWURPUC9NeFk2eXpDQUNmeW9jaG1l?=
 =?utf-8?B?Ni9BL0VaTFhzb0ZDRkZlNkNrU1Z2aG02d3o5d2tlQmZjOUlTZktQbkpuYXRv?=
 =?utf-8?B?VHZzL3RMSDZndXhRQWRVNVFHMWRIZ2dyS0tTdklKTE9NZ2FvcDE5NVRWUnpQ?=
 =?utf-8?B?NlVYaEFhTEJLTmdBaHYrRWR4Sm5TT2F0ekFvdkNvbEhESlUwME9DME4wdksx?=
 =?utf-8?B?R1lWMmRRUWhkRDBiMnZOcGNNN1cwN29uNlR5c0tzUklmcHNjOVNPejJEanVp?=
 =?utf-8?B?cGpqZlNGcnNTN3pwY2lxZG4zRlJJQjZVR0lSWUNMeUxzdERaUy80eDhIQTVn?=
 =?utf-8?B?czJtLzJOYkVMalRkdld1SWFBK0hUalYxRHU0U0tDUWRlZXVxZThBVjRTU3dT?=
 =?utf-8?B?WldBdlVQYStyaGtLYjhnZDh3MWw0Umt3eDlhdWphcXQyL0pMV3BuYmo4K0Zz?=
 =?utf-8?B?WWRYaU9RcENhRlQxNGF3aUp2MlVSNTRkemFMa21teGxGdUEvUUR5Y09hTkY1?=
 =?utf-8?B?dnNhOFFnalR3ckRLVnI0QWpsdDJDbG1EUHNwK1VwalB5WFdia1pHSG9XdVdN?=
 =?utf-8?B?Zi9HdVhxRGg0Z0lsYmpvTjA3ckRCVndiMWJPakpKYWNISVhScjY1ci9iUXdD?=
 =?utf-8?B?OXlKTjd3M20ydXVTc0F4R2kxb2NPcWp4b0ZKeFE3V2I0UTlyTEQ0TkcxVVdM?=
 =?utf-8?B?dUw5NUhQanpBalNWbUJ4YXZsZmhnYlB5cFhiNDNuN01LVlhGWHVGVDVTcDVN?=
 =?utf-8?B?OGY5NHRRNGppQjN3TkwyY3B6akxFdi93NDdXSHpBQWZOZzFySHYwMlkzcURn?=
 =?utf-8?B?ZUFJdXNMd2dBWUxzcFk2QWJPWTMxNW9WRytkcjZYajhsK3F0U3lwcDZoaWdE?=
 =?utf-8?B?emJTRnRJZUZYMzY2dXNQOUhVUnBQOWUxWEYxWHhvcG45VWdqYUY3Uk9EQjY4?=
 =?utf-8?B?bmxGbnZZQi9FeWs5YXJKeGVoeVpCTS9sb2pjdkltTGhEN0VPc1ltM0pTVFhF?=
 =?utf-8?B?T3QwbVdVaUpFY0pLNTR2bTg3d1d5dXJtY2ZLMnB1aFBGNmJaN0JJL2NLQnZz?=
 =?utf-8?B?QlZvUG9BVXlLN1RHVHVIbnE5UmdHcStDVnlsVVU1WTJSS29RN1ZLK01XRjk2?=
 =?utf-8?B?VlozQ21lUXBrYjhOeFlmOGhENTB2KzNJM3ozaHJKOFltYnltVmpjZ3BBek5N?=
 =?utf-8?B?REt2QXVERGk5aVlmL2NCQkViVmtWVFdiRkgzcHptaFlTVnEzT3FGWmFpbzF2?=
 =?utf-8?Q?iMQBRJ9Y0Aw5U?=
X-Forefront-Antispam-Report:
	CIP:20.74.131.131;CTRY:AE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:email-signature-server-deployment-84dc76766b-mtd45;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: cnsonline.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 12:18:13.2490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5928d57e-4037-4ddd-dd68-08dced13711c
X-MS-Exchange-CrossTenant-Id: 2bd16c9b-7e21-4274-9c06-7919f7647bbb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2bd16c9b-7e21-4274-9c06-7919f7647bbb;Ip=[20.74.131.131];Helo=[email-signature-server-deployment-84dc76766b-mtd45]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DX1P273MB1624

SGkgVGF5bG9yLA0KDQpUaGFua3MgZm9yIHlvdXIgcHJvbXB0IHJlcGx5LiBBcG9sb2dpZXMgZm9y
IHRoaXMgYmVpbmcgYSBzdXBwb3J0IGVucXVpcnkgcmF0aGVyIHRoYW4gYnVnIHJlcG9ydC4NCg0K
WWVhaCwgaXQgd2FzIHF1aXRlIGEgbGVhcCBhY3R1YWxseSEgSSBnb3QgY29uZnVzZWQgYmV0d2Vl
biB0aGUgY29yZS5zaGFyZWRSZXBvc2l0b3J5IGFuZCBzYWZlLmRpcmVjdG9yeSBzZXR0aW5ncy4N
Cg0KU2V0dGluZyB0aGUgbGF0dGVyIGluIHRoZSBzZXJ2ZXIgbWFkZSBpdC4gSSBwcmVzdW1lIHRo
ZSBpbnRlbnQgb2Ygc2FmZS5kaXJlY3RvcnkgaXMgdG8gaGF2ZSBhIG1vcmUgZ3JhbnVsYXIgY29u
dHJvbCBpbiBzaGFyZWQgcmVwb3MuDQoNClRoYW5rLXlvdSB2ZXJ5IG11Y2gsDQoNCkpvcmRpIEJh
bGNlbGxzLVNtaXRoDQpTZXJ2aWNlIHN1cHBvcnQgc3BlY2lhbGlzdCAtIElUIG9wZXJhdGlvbnMN
CkNvbW11bml0eSBOZXR3b3JrIFNlcnZpY2VzDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogVGF5bG9yIEJsYXUgPG1lQHR0YXlsb3JyLmNvbT4gDQpTZW50OiBUdWVzZGF5
LCBPY3RvYmVyIDE1LCAyMDI0IDE6MzIgQU0NClRvOiBKb3JkaSBCYWxjZWxscy1TbWl0aCA8SnNt
aXRoQGNuc29ubGluZS5uZXQ+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6
IEdpdCBidWcgcmVwb3J0IC0gQ05TIC0gU2hhcmVkIHJlcG9zaXRvcnkgcGVybWlzc2lvbnMgaXNz
dWVzIHVuZGVyIFJlZEhhdCA5DQoNCk9uIE1vbiwgT2N0IDE0LCAyMDI0IGF0IDEyOjA3OjA3UE0g
KzAwMDAsIEpvcmRpIEJhbGNlbGxzLVNtaXRoIHdyb3RlOg0KPiBXZSB1cGdyYWRlZCB0aGUgb3Bl
cmF0aW5nIHN5c3RlbSBmcm9tIFJlZEhhdCBFbnRlcnByaXNlIExpbnV4IDcgdG8gOS4NCj4gVGhp
cyB1cGdyYWRlIHB1bGxlZCB0aGUgdmVyc2lvbiBvZiBHaXQgZnJvbSAxLjguMy4xIHRvIDIuNDMu
NS4NCg0KR2l2ZW4gdGhhdCAxLjguMy4xIHdhcyB0YWdnZWQgc29tZXRpbWUgaW4gSnVuZSwgMjAx
MywgSSdkIHNheSB0aGF0IGlzIHF1aXRlIHRoZSBqdW1wIDstKS4NCj4NCj4gYzpcdG1wXGdpdHRl
c3Q+Z2l0IGNsb25lIA0KPiBzc2g6Ly8xMC4xNTAuODAuNTMvZGF0YS9naXQvY25zL3JlcG8tcGFy
ZW50L3JlcG8uZ2l0DQo+IENsb25pbmcgaW50byAncmVwbycuLi4NCj4gZmF0YWw6IGRldGVjdGVk
IGR1YmlvdXMgb3duZXJzaGlwIGluIHJlcG9zaXRvcnkgYXQgJy9kYXRhL2dpdC9jbnMvcmVwby1w
YXJlbnQvcmVwby5naXQnDQo+IFRvIGFkZCBhbiBleGNlcHRpb24gZm9yIHRoaXMgZGlyZWN0b3J5
LCBjYWxsOg0KPg0KPiAgICAgICAgIGdpdCBjb25maWcgLS1nbG9iYWwgLS1hZGQgc2FmZS5kaXJl
Y3RvcnkgDQo+IC9kYXRhL2dpdC9jbnMvcmVwby1wYXJlbnQvcmVwby5naXQNCj4gZmF0YWw6IENv
dWxkIG5vdCByZWFkIGZyb20gcmVtb3RlIHJlcG9zaXRvcnkuDQo+DQo+IFBsZWFzZSBtYWtlIHN1
cmUgeW91IGhhdmUgdGhlIGNvcnJlY3QgYWNjZXNzIHJpZ2h0cyBhbmQgdGhlIHJlcG9zaXRvcnkg
DQo+IGV4aXN0cw0KDQpUaGlzIGlzIGludGVudGlvbmFsLiBQbGVhc2Ugc2VlIHRoZSBkb2N1bWVu
dGF0aW9uIGluIGdpdC1jb25maWcoMSkgb24gc2FmZS5kaXJlY3RvcnkgZm9yIG1vcmUgaW5mb3Jt
YXRpb24gYWJvdXQgd2hhdCB0aGlzIGNoZWNrIGRvZXMgYW5kIGhvdyB0byBkaXNhYmxlIGl0IChp
ZiB5b3UgZGVzaXJlKS4NCg0KVGhhbmtzLA0KVGF5bG9yDQo=
