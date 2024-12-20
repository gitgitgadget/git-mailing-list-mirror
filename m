Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020131.outbound.protection.outlook.com [52.101.188.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF7216E1F
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705768; cv=fail; b=lo+lNGhlpcP6Z+9BW6UlZgpcKzwc8U7AfwjerRxdDYYQUNuNGE4vGWTjfdh8aK4MOjilSiqXFX2sadf2b4LC6BGUdSBy8fRnM2w2tRkCu4kVc8wpOxJTdO/jpJFD0X7QVbjSr9ggmYx211ehCCpWjvJ9pShxs2+RWjBkeLov0tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705768; c=relaxed/simple;
	bh=7p4IdFgFC2BU7HVneV9zVpoKSa9y5mvTYh+giGEYW2c=;
	h=Content-Type:Message-ID:Date:Subject:To:References:From:Cc:
	 In-Reply-To:MIME-Version; b=qZ5g6E9Qv1bcddZClz4m3rrD1povHiE8JUfsVIqsL9rt6yG9dPuEdduyRNh3J7BwUG7NEsfbcIX63v3vsWzuYF99fFWnT5nZQJXWFgwymjIjnkUYa3iZIoBQBftVVi3oGbG7zwfpSgu+YykV41jn3XB84yigpAmoKfSwZp2ex9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch; spf=pass smtp.mailfrom=psi.ch; dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b=ynJ5QX1B; arc=fail smtp.client-ip=52.101.188.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psi.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b="ynJ5QX1B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6bhDLeXB88UA3oPdU9QFuy5ucRjeaJAeIJCCJfAFk1TFvNKn7pwfywW8PldLjH3BkwXjrsGCjau/6SdUiZGA3p/cUIch2bA7O3rtykricOiMlWEGYTZFOTbbfi7PtCZqTn1uzk7UAI0g8Fw7La0Y9wkocAkgDHLEQe2+dPN/bibYngXdqlCS6UIQiwvy7Ubgpe5dp6uho8sGHhvzosD3mtHk7mzeelFb4ftiCy7EC/RN4N/UZeB58WYIOlgYh8hcpAAL/GYYCiiz92F9y0vbgb//PzS/LjKR+DRSbRnQPIylNGsK4UsvowQOH7qFg8zy9vUNm24VH3OXklOhgcUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE0IjzDBLIiDLnRFdeTV7CfKi6AMf83gcwbWqvk0lCs=;
 b=Oe/FPuAEGK73ZxYYdFZbl01FAbB/LPubgZN/iRHJh8ZTS44eoKfPOGXWe532j//TCllDkTi53fG3eme50ySMCBK75g+0z8ovT4NrQWbcopnzOOOMidokuu4Ph1WTPA7dcxim7PvMi7G8l7jM/Dq+qwvGvtL86FpY1kPSVgCnOrHCrudNwksrAs45knr35u26ybSPOytnFroEENKNg33si5GvztksAyDiIKr6PsE9M7T+tESeb4Tbf3xRwa4Nh54HsNyZ5bpL7DS4rMDnoPy3D5KuruXuGNH8pj850rp22DEyOqkmIu1SXZrcth2HQvbh0F58cXCtmZDu6iEcTUiCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.250.76.7) smtp.rcpttodomain=crustytoothpaste.net smtp.mailfrom=psi.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=psi.ch; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psi.ch; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE0IjzDBLIiDLnRFdeTV7CfKi6AMf83gcwbWqvk0lCs=;
 b=ynJ5QX1B4ZcQ0ocaCNxyoZfXYPp+Z49JO+UFAwFZBnRUa1s5iiX9pIkqk52Dc6bDTZoY+ABzwWyHBRVEi/Az/kfzfXXluakUSKHg1/ooFpMn7JxbuEdtSuc9zU+NMWCxjrN8Q2OaHVyY/D5HdVIlScm0H9jXkSti62ZensJ+YAVUJUHkm2VUOearitqEYJM4WOOuuivkDwLu+pYTeJhLJv3MhcoFiNiuomPx1TzHRZPWqcD33rhMZJ6Fpf1stvztSVDspz9RUIGEP3Jrqv+Pzg64WJuo3JpIBT9MglhUMuiaHzOJqaoNGHnl4U4tBdQzfnqyIhJfw9MK/G7N7CTxRw==
Received: from ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::9) by
 GV0P278MB1605.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.16; Fri, 20 Dec 2024 14:42:40 +0000
Received: from GV1PEPF000006FB.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40:cafe::f9) by ZR0P278CA0130.outlook.office365.com
 (2603:10a6:910:40::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 14:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.250.76.7)
 smtp.mailfrom=psi.ch; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=psi.ch;
Received-SPF: Pass (protection.outlook.com: domain of psi.ch designates
 20.250.76.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.250.76.7; helo=seppmail1.psi.ch; pr=C
Received: from seppmail1.psi.ch (20.250.76.7) by
 GV1PEPF000006FB.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 14:42:39 +0000
Received: from seppmail1 (localhost [127.0.0.1])
	by seppmail1.psi.ch (Postfix) with SMTP id 4YF9B75xMCz9xK;
	Fri, 20 Dec 2024 15:42:39 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010004.outbound.protection.outlook.com [40.93.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by seppmail1.psi.ch (Postfix) with ESMTPS;
	Fri, 20 Dec 2024 15:42:38 +0100 (CET)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psi.ch;
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::13)
 by ZR0P278MB1073.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 14:42:37 +0000
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288]) by GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:42:37 +0000
Content-Type: multipart/mixed; boundary="------------8pxn2E8yB7367q8xy0RJ7s0u"
Message-ID: <c287fbd7-eb08-45f1-953b-5afd4fe41f9f@psi.ch>
Date: Fri, 20 Dec 2024 15:42:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: chmod failure on GVFS mounted CIFS share
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
 <Z1us2FpyObVpJlsM@tapette.crustytoothpaste.net>
 <c22a7d5e-cbfe-48a9-bdf5-e73f21ac648f@psi.ch>
 <Z19Ymnnvt9jOixPB@tapette.crustytoothpaste.net>
Content-Language: en-US
From: "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>
Cc: gitster@pobox.com, ps@pks.im
In-Reply-To: <Z19Ymnnvt9jOixPB@tapette.crustytoothpaste.net>
X-ClientProxiedBy: ZR2P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::6) To GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0504:EE_|ZR0P278MB1073:EE_|GV1PEPF000006FB:EE_|GV0P278MB1605:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f19b81-43e3-40cf-5b6c-08dd21048dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?t3GJ2VHpnPBjA277ZvaunJnbo5o+HUsrUfjI4B+HB+sHg26gXNnSpmsTlLmA?=
 =?us-ascii?Q?i5sf4ozJgUE/r97LUPpR75Iqdva0NGfbRiPmQanYBiLmG1e6nH239VZ50E8X?=
 =?us-ascii?Q?PuE0yq9CGk4tnJsfaxTJHSA5w64r2rBJx1OHXmCm/aGsh4Sd0DxRX4JNhx0U?=
 =?us-ascii?Q?fNAYJiYR6wfBFN4dN722Po0xQaIuNiMfZ0Niz0RPNGCvAQR6bg1KIlB9qdC7?=
 =?us-ascii?Q?zlmqsyYgPR7aZguY1Db1SjgnJldVhww+WeOlH2XPlyak/lLHqnnBL21f0kI0?=
 =?us-ascii?Q?9XgzH06wHHRS1ugPvnjK7MXxWf+lms6YR/dFeE1Geyie3vKlk3EfF2uHdOY6?=
 =?us-ascii?Q?KIXo5tQ6VQvs33CtkEKCmtObRQMQX2sQZY/phn8xr8fX/6a7Ank9zcy6OGo6?=
 =?us-ascii?Q?BPpim72N4di2zS18eLqPU/S43CRRZxTMjBzCml1fcOAuMMvAnxsioZ9F863E?=
 =?us-ascii?Q?rwqf5NPiX79TwAeTUjko1AsydDqsajh9FlYiUzGBeTlVzP5bqRv245DNIS1t?=
 =?us-ascii?Q?0vpMQFyKFNtFMN59mJjUrSGW3/DFgLPZmJl2++Da3lTUHpJ4anXU6/plfOPh?=
 =?us-ascii?Q?L3bTE3D372Hpg9NmpcHYSK0mMVydKGAbfogR3gSJogEMkKneYny0RN7IXb0G?=
 =?us-ascii?Q?OpD70ACRgyjkkcv4HNFtOZjRk7wyqyBFOeZ2bCmNZFoqrhRG5ctLaJ/zOHif?=
 =?us-ascii?Q?Zys86ug/+xNXbBJtBjHLA41GIltrlorYvDhx9FLgnNwF4B75tFu+6yCfQIFF?=
 =?us-ascii?Q?gNYZFAR2FuVxhxS4Rl1Ggpi3yv2ThzwCQviVcuLV7HuhTYZtE24BRztcsmks?=
 =?us-ascii?Q?Xb/9BbhMLqzwvnYpnLLAMqeOobRB3nNATYl9bOBrhZkEZPttwaMeh2qzHj6B?=
 =?us-ascii?Q?UXP/ZVuK7ViOkppW+jBA9Q07R6MT0CVkTsnJJSK8ofXCwmbCUYBN+qGM2lQJ?=
 =?us-ascii?Q?xw2+5RwiGUx7BcAOr7t2ufCaOPlDma1B/T3bHA8xc2lBDTcAaojydDd/IGFA?=
 =?us-ascii?Q?8+mPz33xCKYUqsZtkKLUQ3QR7rOCs1PPwKQxHSRVKf6IPI7qP8Ovj3dfivWn?=
 =?us-ascii?Q?GsTvQ3FPZdLDAIGxpBvb/b1JCOhmfRObak7HnQOjy2iNRnnIh3F5DprWmdAV?=
 =?us-ascii?Q?807MA/sPz6AL21hqgkxRHjXkX/C72XN1bS/guN842coDBR1nZX3Wk4F0PAnU?=
 =?us-ascii?Q?lzzRTWfmZgB0ZBtMqPRzSNVJCQKaXXCYcFQeXbpQvh7lb6li5Jpi0snt8u5r?=
 =?us-ascii?Q?xrN3cevGtcjh7jHoGkoj5/1uT/NEasNpA5Epz6hUiRKrzXpJoMRz6PW+oPXH?=
 =?us-ascii?Q?NgBP1JMC4M/W2fleF0kKNNCrEB+q0joHw36yendhCQJSTKxsvwGAn7GkTnkc?=
 =?us-ascii?Q?ET+mXZWgIRBm/6XeQSYfLHpUs1Hh?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1073
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 GV1PEPF000006FB.CHEP278.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d0e4c551-0539-413f-94fe-08dd21048c19
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|82310400026|14060799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0FGbW5zSERWNlV6T2lyQjhOWGRKU1RqQzFqY1JTSmRjUUJ6a3hjQU4yQjdL?=
 =?utf-8?B?M1cwRE05VmZjODJKNUNEU0pobDl0NHdTR2JKb1RKQkVIMS95b0xBWjFLR0R5?=
 =?utf-8?B?QkdaMFViRGlrZ2RRVlZxUEZoSCtQaExlUWRwcW1tODg5clBzbDdsRzZKcis4?=
 =?utf-8?B?Zm05TWlnMWhmVlYwaFd4SnEvRTYwMnE1NXdBekw4ODM1OHExVVZpN1Q2VURX?=
 =?utf-8?B?OTd1VmRMaGZ5eG5vMzFHRDlKcmRkUFpRRURvSUxqcWdzSHdiVFZmQkQ4M09t?=
 =?utf-8?B?a0FLZk8xelh4UkpIc0ZiU2Jka2NzTHlDWS9CbDllakI5OGJKWFBteHFhcmh3?=
 =?utf-8?B?bzByczNScWM1L1VWUTdBZi85TUxnOWxFSXRMeWVBUTFENDhJaTlUc1ZnTU9r?=
 =?utf-8?B?Q3VSS3lRN01KZVZEanhJS1VJcERSVjNvclkrYVJEV1ljYzRlSWNURm5GczNX?=
 =?utf-8?B?alVucitQRVN6NCtFc1J1eGpOam1HYXZ0STBPbVVYSUVwbDdtYmRHSTRjMk1t?=
 =?utf-8?B?TkRHVEIzNTJVSWVyM21Tc2xjTXFHY0FYcmZPRlRhR2p6ZXNTM2FaekdtWUdZ?=
 =?utf-8?B?RlNybEg2MGlwYVdaQmNQUGtnM2xkamV2enVJL2pQZDdoeGNjYUhGaDFpbldT?=
 =?utf-8?B?VzgzRnhUOGhJUEttN0xibGlQT1BtRTRPWFZpYWNuaUdaZTAxYXJFUGUwNVlo?=
 =?utf-8?B?Zkd1cDlmRzNmQi94dGU5WWFpUjFkTlFlb2FvNE0yQ1RZRWt4ZktWKytiRWxD?=
 =?utf-8?B?QVZnK0lwQXpDTExNNHZDdzFWaFlxNWI5NXpTWUt3cTJDWTJFWWZGMS95Z3Yx?=
 =?utf-8?B?MWNaQ05iLzJWenJhZTZBK0FzemI4UmlNdVZBTjJlT3ArdTd2Zm5JNlFYb2Ry?=
 =?utf-8?B?Sm94TzV2TC9HZlErNVFNZWZlK1FtbFBZMjhpcjlXcUhBdlB0dWswaEFQVXk0?=
 =?utf-8?B?N0dCeHJUTnpraHViMVRrOUxiUWFqbFZwaHh5QkhSbERWTzdFUi9UejBiQVlo?=
 =?utf-8?B?WEtqZ1IzTERaZnBCMXNCdDhyZXB3T2MwbkV5T0lKVXhEbGRzbWcxNVlXOU9W?=
 =?utf-8?B?blE5Sk40TlMxOWovWVdIYk5XRmJjTWpnNnBqOHdIMllORER2c0xOK0NabGNs?=
 =?utf-8?B?Zml6Zk1EdWVIZ3F3c3FBLzhQTjR0Y2N2TnhzRDU1WERKR1NkZi9SeVRwR2JQ?=
 =?utf-8?B?cy9WSEZaVU45YWxtUHZNMklQeiswUUtDRC81emZGRHAwZDIvSGVROTVRSVpU?=
 =?utf-8?B?WGR1N2RJS0hZaThrMjUxYnh6U2VwWEs0bmVqSWNBaXhERmZqcDB0bzhUeFoz?=
 =?utf-8?B?TzRWdzBvMmdIUHo1anNraHBuWHRjdnI2d0dUT3dyTmVqYk01WTlvVWVPTHda?=
 =?utf-8?B?NDU5SnpGblJwb2M0UURvQmpSZlBUVXYwVEpvSFdJcnJRY1ljTnA2SzhEaUdi?=
 =?utf-8?B?SXBERnBEZW9acWdxVytiSjd0RzBKcTBHWTg3YWdnT1pibHZTWGl1dWVTK3kr?=
 =?utf-8?B?ZXNqdkJnSWRsY3JYZnIwU0YyT1VsSVZtYXYxR2trNGVoYjFpWlNNcE1pdHUy?=
 =?utf-8?B?M0ZCNzBLb29BNithNGU1bW8xKytsbUFjZGJMdGZHMGV2VzQrcVZiVm5DSnlY?=
 =?utf-8?B?ck5malNDRWhsckZJWXEwcm00di9GNnlNTW9ONGNCdUtEZG1QYVdOM0daRVNH?=
 =?utf-8?B?c3Z3Z2NEd0hwWkdKdW9Pbk1JSTJsbjREY3BBdzhxTnlZL285TGxmSFI5Y2Z3?=
 =?utf-8?B?ZGF0cy8wRnFsZVdJcDRJb3FMMTVpMG1RWndTRWdqZ1EvUm1RTS9veUVMSSts?=
 =?utf-8?B?a2pVUndXVHZLdk5jMy9VcmtObENXblRmR2NIZVdkNzNMN2ZLUjN0RnF4ekti?=
 =?utf-8?B?bTllSm9ralBwTEdXeFMrempETS80RGI2WE56cGQzMW1RaHBubHpoc0NrcTRp?=
 =?utf-8?B?Yk9Ua2FzZEwwTnVKT2lIYm8xSkg0ajdibEVodUszbENpRC9nWERJbjU5Zlow?=
 =?utf-8?Q?MuPxMj/k4ipNfxsUZKgjQKnHHsDVPA=3D?=
X-Forefront-Antispam-Report:
	CIP:20.250.76.7;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:seppmail1.psi.ch;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(82310400026)(14060799003)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: psi.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:42:39.9916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f19b81-43e3-40cf-5b6c-08dd21048dea
X-MS-Exchange-CrossTenant-Id: 50f89ee2-f910-47c5-9913-a6ea08928f11
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=50f89ee2-f910-47c5-9913-a6ea08928f11;Ip=[20.250.76.7];Helo=[seppmail1.psi.ch]
X-MS-Exchange-CrossTenant-AuthSource: GV1PEPF000006FB.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1605

--------------8pxn2E8yB7367q8xy0RJ7s0u
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have another idea: there is no need for a chmod if both the config 
file and the lock file already have he same mode. Which is the case if 
the filesystem has no proper chmod support.

Attached patch implements this and I could successfully initialize a new 
git repo on a CIFS share accessed over FUSE.

What do you think?

On 15.12.24 23:30, brian m. carlson wrote:
> On 2024-12-13 at 10:32:22, Konrad Bucheli (PSI) wrote:
>> My suggestion is not to silently ignore all chmod errors, only ENOTSUP for
>> config.lock which basically tells that it is not a suitable location for
>> that operation and thus also not required.
>> Would that be acceptable?
> 
> That solves your particular problem, but the WSL situation gets
> EPERM[0], so it would not solve the general problem.  We definitely
> don't want to blindly ignore EPERM in general for `config.lock` because
> it could indicate a real permissions problem or a race condition with
> other software.
> 
> [0] https://askubuntu.com/questions/1115564/wsl-ubuntu-distro-how-to-solve-operation-not-permitted-on-cloning-repository

--------------8pxn2E8yB7367q8xy0RJ7s0u
Content-Type: text/x-patch; charset=UTF-8; name="config_with_less_chmod.patch"
Content-Disposition: attachment; filename="config_with_less_chmod.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2NvbmZpZy5jIGIvY29uZmlnLmMKaW5kZXggYTExYmI4NWRhMy4uMzQ2NmYy
Y2E0YyAxMDA2NDQKLS0tIGEvY29uZmlnLmMKKysrIGIvY29uZmlnLmMKQEAgLTMyNTYsNyArMzI1
Niw3IEBAIGludCByZXBvX2NvbmZpZ19zZXRfbXVsdGl2YXJfaW5fZmlsZV9nZW50bHkoc3RydWN0
IHJlcG9zaXRvcnkgKnIsCiAJCSAgICB3cml0ZV9wYWlyKGZkLCBrZXksIHZhbHVlLCBjb21tZW50
LCAmc3RvcmUpIDwgMCkKIAkJCWdvdG8gd3JpdGVfZXJyX291dDsKIAl9IGVsc2UgewotCQlzdHJ1
Y3Qgc3RhdCBzdDsKKwkJc3RydWN0IHN0YXQgc3QsIHN0X2xvY2s7CiAJCXNpemVfdCBjb3B5X2Jl
Z2luLCBjb3B5X2VuZDsKIAkJaW50IGksIG5ld19saW5lID0gMDsKIAkJc3RydWN0IGNvbmZpZ19v
cHRpb25zIG9wdHM7CkBAIC0zMzM2LDEyICszMzM2LDIwIEBAIGludCByZXBvX2NvbmZpZ19zZXRf
bXVsdGl2YXJfaW5fZmlsZV9nZW50bHkoc3RydWN0IHJlcG9zaXRvcnkgKnIsCiAJCWNsb3NlKGlu
X2ZkKTsKIAkJaW5fZmQgPSAtMTsKIAotCQlpZiAoY2htb2QoZ2V0X2xvY2tfZmlsZV9wYXRoKCZs
b2NrKSwgc3Quc3RfbW9kZSAmIDA3Nzc3KSA8IDApIHsKLQkJCWVycm9yX2Vycm5vKF8oImNobW9k
IG9uICVzIGZhaWxlZCIpLCBnZXRfbG9ja19maWxlX3BhdGgoJmxvY2spKTsKKwkJaWYgKHN0YXQo
Z2V0X2xvY2tfZmlsZV9wYXRoKCZsb2NrKSwgJnN0X2xvY2spID09IC0xKSB7CisJCQllcnJvcl9l
cnJubyhfKCJzdGF0IG9uICVzIGZhaWxlZCIpLCBnZXRfbG9ja19maWxlX3BhdGgoJmxvY2spKTsK
IAkJCXJldCA9IENPTkZJR19OT19XUklURTsKIAkJCWdvdG8gb3V0X2ZyZWU7CiAJCX0KIAorCQlp
ZiAoKHN0LnN0X21vZGUgJiAwNzc3NykgIT0gKHN0X2xvY2suc3RfbW9kZSAmIDA3Nzc3KSkgewor
CQkJaWYgKGNobW9kKGdldF9sb2NrX2ZpbGVfcGF0aCgmbG9jayksIHN0LnN0X21vZGUgJiAwNzc3
NykgPCAwKSB7CisJCQkJZXJyb3JfZXJybm8oXygiY2htb2Qgb24gJXMgZmFpbGVkIiksIGdldF9s
b2NrX2ZpbGVfcGF0aCgmbG9jaykpOworCQkJCXJldCA9IENPTkZJR19OT19XUklURTsKKwkJCQln
b3RvIG91dF9mcmVlOworCQkJfQorCQl9CisKIAkJaWYgKHN0b3JlLnNlZW5fbnIgPT0gMCkgewog
CQkJaWYgKCFzdG9yZS5zZWVuX2FsbG9jKSB7CiAJCQkJLyogRGlkIG5vdCBzZWUga2V5IG5vciBz
ZWN0aW9uICovCg==

--------------8pxn2E8yB7367q8xy0RJ7s0u--
