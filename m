Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8410432316
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896670; cv=fail; b=GmMhUf3p8+FskGVwEcPYTpRYWECW78107HMqSKEqCZkYJFjUiK9UWPODQXKA7LXATp69beXvmJJ/BsR2SRiwSUTXGrFMUFPKCrG0Y1WSXlgTjWlipb9ZJNPKnEFOxSWkgzyn2xBYOPQA/Popt2b37m1X8O6nkpLEHj9/PFkpyRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896670; c=relaxed/simple;
	bh=m3h9tjXaD+yrpK50NofX6nir/ce3NmEzJfD/5TjkaX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rsi9ZhvMvr/0SiKL4ulRGzNKEU8C3nXYpiPhPyMRTfBQG2SkrUQKhf9/aAjH5VoF+V5M1ejMZF7jnuGQHd4QnVYxGSv6hTR/uIiml2y63E5s3gvG/OYKMfkGvSA/HTLntHd/IGof0DqTAdtCT+9slTN1uRLS4LyT/YMWyb2pGlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=M52l8lkY; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="M52l8lkY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJXIqrB7lVOHAXvqjvxsS1qdOVyIKhL8LMsaxAL7YXCG1IisQ0o/SQLV5llNqxj+2I+bkw4ydSq7AjjCeF3oQB3IGipXskmm4KjChklJHfB4anAAgvxto8x2g9wCL9SaXCRpDCPLBHffLu9Yhm+bNAQNXw6eLBtsCgV3wdOILqrTNhldfyMOEh1nVYpXste8WrHMlN6lUTXonmmgx9mHYdnv0QEM3TJcGvejLJWaaF2GaHaXIvnqGPGl9miNYrjDB5w7+aj6BGJAnZB6PSw+5pt4hDyE8sYGvhEYvGFPjWErDCx2NwtfKwoS71TV1RWS6bXzAHQoCp5HPJEyBng36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5gw2+SHNRsqLZc37utati2kiOAe1r77Nx8Fsr1Bl54=;
 b=YaVqTLdjUIHCbus+heNTeL+gccveZx5eN/lj/Mar4ftUoPF7zD2084gt9kMaxPo6g5o3SWqR0UMQj59jj/sHSeMjJiOg4K5e+t0rqa2z4XIgfm+jtA0s98yREEj2sz5ucPJ1pdqe6uqCFZAaPqo7JoGrn5dDJZvBOJkhdFo/MWnXs4IGJ0jJ+dHgGwh8jCL16oJ5VlsAxWss13UiH9IqgUWbwC+Hi3ChVCB5abV11XRpJvKFTc4y7+Xwp/1UxLm2CMqY23264irFnY9wJoGfvdAWHn3NOMUdeP2iAOULEJd/WVIUqJ0LAlgV6jtwEeKZ4W+EUUhEe+rfjn8x8x5bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5gw2+SHNRsqLZc37utati2kiOAe1r77Nx8Fsr1Bl54=;
 b=M52l8lkYipq2JmielnxNx/IjHztVIRz4MccRaVeIjcxejNndVEEFYg5I7f4VfF9RdqxwPsD6madxuVNJELIPchytsVUHEfaftt9dAvMEJbj8opODp6vUHeweILwxUuyRMkSGDUmstMPY6Z8nPRraJWvcLB0SWOmrL4hG83qd0Y2LEdYGVifeODCBpVeuxk57vmk5ndLphVM03DWnGwmdvOAPEqT8UoiiTyFH3EUT6mCIWJYYS8HjL5SOhVczAkgvwepIcEp+iOIczZ3qKaLqf7aVJjeJfy/pKMhHTPNUG3DGJrLO/zjOJI3kQaaUcOeVT9fH9LOsiABqkM49AwFh+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU0PR03MB10187.eurprd03.prod.outlook.com (2603:10a6:10:479::19)
 by AS8PR03MB9909.eurprd03.prod.outlook.com (2603:10a6:20b:635::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 12:37:41 +0000
Received: from DU0PR03MB10187.eurprd03.prod.outlook.com
 ([fe80::764a:3e10:9b21:5671]) by DU0PR03MB10187.eurprd03.prod.outlook.com
 ([fe80::764a:3e10:9b21:5671%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 12:37:41 +0000
From: Adrian Friedli <adrian.friedli@mt.com>
To: gitster@pobox.com
Cc: adrian.friedli@mt.com,
	git@vger.kernel.org
Subject: Re: [PATCH resend] builtin/clone: fix segfault when using --revision on some servers
Date: Fri, 24 Jul 2026 14:37:35 +0200
Message-ID: <20260724123735.666021-1-adrian.friedli@mt.com>
X-Mailer: git-send-email 2.55.0.379.g6d629a7221
In-Reply-To: <xmqqfr19lmau.fsf@gitster.g>
References: <xmqqfr19lmau.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0153.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::20) To DU0PR03MB10187.eurprd03.prod.outlook.com
 (2603:10a6:10:479::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR03MB10187:EE_|AS8PR03MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: a094058c-b569-484c-f9c9-08dee9805a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|10067099003|6133799003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iDh2wp0dC794T0nNUaJhRlyJV7zPe5DS5mkZ65+jICrLnDEonSlzL93ZjB65X0ZHLCyC24nMOFn5ceVR0ehqBzt2L5Cd/zNnE5TG0kLhPN5G9o6M7DTZ9hl8mO049fStS1frFuPvGyrQgtdcaLU12Ig1/zhjjBcKeYXNTgaiOyfxfHj49cfbUp+/zha+kHCCqNrYwlzRJCA6vAkkxTcyvgVekUGcKSu87b1BwWLEWt6zJYOJL7ixQhACWVLC5oRXD4147DWEoWlQVyEZJ2OHoRKjNJXR7IZETp81OvsJBZGNm38TGmVtPeYpWU4mNhmjpoLQRFs+U1xnHyHb+6SBRxm1nZBOKgylR/ay+VO+yVlusMdb5L8iOQWJia4eWLlafMqLVxgAp7HVmmSb2pJqWyICjmMw1HCY2C2FQf/qNgBHwN/2QCTmM9qjYPsWEPdes7lN3Uo8PvP+aETHmgXPE3N2GYK+Qi8ICWKYgC/H28OgVhzQDbwrpB7Os0hP4YNa/oc6k3vEIby7SbbGR/Li4PaBQPHoFi7k+QRyxwlkwqt5tGB8+DqqM61dC7gKO/ezgxx8CSjrwunEXAOUgiForf6fcHYNCRiDi8goqoEkOCUm/uO34g1Em2eA+G89hZXUGE/CZfu+taMH+os70mx3AB6cQ7NqRZpXyPNa2KPW8jc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR03MB10187.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(10067099003)(6133799003)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I6ORwwjP8MKAAvPXqcCK6/Yvde3CTrCC+qE2cyMa1z8NYjgY96DgVY/loMCQ?=
 =?us-ascii?Q?vnbImmjdxHmHP/wLdEbYd6McFkqSd9RvyvLropoJq6I4OXAF1fmWQM1zNLM4?=
 =?us-ascii?Q?FNdxRatKcV1n2+nnx2o6ed3d6wzNEjqqvCOGZ3ah5bJaEgT5pim3rXYFAWWm?=
 =?us-ascii?Q?LM1lm/ToTj5jt6KWcNCx3z64zWap0Seebg4aFvZc8sFcWnVZVe1y6UAxFQ6A?=
 =?us-ascii?Q?7ZQ6FbgSzktbXaXxA4y2xswAssCT8VvPjFWf2qXVCsob5X7323TsC5bMCufk?=
 =?us-ascii?Q?OqhW0agQD6XpUqM+MU0sJXakN0JP4dYeodYgODpZX/JpoO0ajWjWyYYyxgZF?=
 =?us-ascii?Q?XIUVwgmSAl5QhP9i9Ir2M5D9/hAeuVniCpZpMsjZJ2yriLetIXjPMA4JfKMn?=
 =?us-ascii?Q?6wgF0XSW8bx574bxe5fD281oRb8O1zoBwTJT4JBlT9uyMGVU32L9XCKjuZFj?=
 =?us-ascii?Q?GY++ud6wHTKfNK1hzzWD3IcUH5eqf5GCWU+iIrcvgEVHXQNoBpN0sxToEzBs?=
 =?us-ascii?Q?ozh50teNKyj8auk1Ez32ni24foC46aPmoyWWlU6mJHwRQRlvjED9c4ZHQPLZ?=
 =?us-ascii?Q?FnHdymsYaa2/urxlSpvW6l3Ke8Ai0fPh9KDpUY2EksRhDHTuHIbE2ytumUQF?=
 =?us-ascii?Q?gC5jquuUSXr8+ltitkSewHn81EvOlkaIwD4TBik5RdkfWDADpK88R9O21PDQ?=
 =?us-ascii?Q?OPjKZBT5/B/1CEU7qk9/HVbZc5gNHRC3xT87tqYRlPDr9FaeuYe2m5mFukjy?=
 =?us-ascii?Q?JTQbiBse+i6L7XG6rBBiWd4VZnWpRRx9k0X7b85lARAr/ti4H+8VODqsUdIO?=
 =?us-ascii?Q?sUcIjWTgEygCp6ksA47jIPMZYXzvtKjVuenY9ATq+Hc2PnC/F1UuJOjd4Ls3?=
 =?us-ascii?Q?KutfSG5xmCdUUaDKWmf9fwsOvT7X0QmFOLXfkthjLVCqvG/ewng5a3NbuOa0?=
 =?us-ascii?Q?QP0x7c6HFyDciD8y4eOk+YBxbmkbVzRWP2y+jj2N8pc2ef4ZLVfbgD8U+JJw?=
 =?us-ascii?Q?7TeduFRWcv7nVUH3aN7iSmVuTtLkxYClTegkyUNRnXJhyk2c12h6x7+6oGOe?=
 =?us-ascii?Q?1DEoAfYTF4QP2MOXIFHzYSa/EGLjUQjtgjfICefzAAVV9aRrDpWr+yzfSabE?=
 =?us-ascii?Q?SnsH91tijALB+mMuTHjxBC0DnRgwrE4K5JtiCs+uAJkD5ec9p0rCgC9D6O6l?=
 =?us-ascii?Q?L382bbYJLbelhIgvlOc4jI6zsYl9qRAYZXFsd7bnLg9nLGhc9QbhjnE5cUYg?=
 =?us-ascii?Q?exRhhhNagle4QSsys2s7sbBIjCoX8fSQ3o2VJ/6eaDRnV/MQwZ8R9FpGA1s/?=
 =?us-ascii?Q?MXNYIku5sJfe2Mx31uVEhhvmjqrwpCiopk9ytadT9iFawiuDrCcdeO3pDtsS?=
 =?us-ascii?Q?swlUwZ99MGBOFQ4T1cg9m6SiKDUfbm6k6j+VEuJ074U2KbjmIHsHjbVORuw9?=
 =?us-ascii?Q?vR/8uiNXV52T6IwZIacOCMfMwZUb31oI6hlXjTEt9XwwtXbEhVEQNAeSKiOr?=
 =?us-ascii?Q?cdzWrQ5cjOR0Kg5RbA+HPLe2q4KyOtYUUBXL2cEpGr3PXQ/F7OK2ratWD0X0?=
 =?us-ascii?Q?6L975LpzSOKL2MXYUyJTapQg9cpqegVElPWg5TMT2nHJGoC8DxB6hEY6i/cX?=
 =?us-ascii?Q?kegWe3orcwFQE3GM32VFeYLze112Hw7TBam0l8wZ30kO3b5Eatg8HM5cUe6B?=
 =?us-ascii?Q?c/kvIh8ARCJRcolqp3oBesvEIblZBe9+AMpdK1kDOm1uaghyoB1kqGbPFy7E?=
 =?us-ascii?Q?AWcKTBIAxA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a094058c-b569-484c-f9c9-08dee9805a41
X-MS-Exchange-CrossTenant-AuthSource: DU0PR03MB10187.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:37:41.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMGiMkYvxcfFcB2XqusZGZF2aI+9TdornyKxQeQxYIr9vxw3cSubvXs9ozNICTBbLpLj8dybPxJwOMxib52fPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9909

Junio C Hamano <gitster@pobox.com> writes:

> So this patch fixes the issue in the right place.  It would still be
> nice to have a new test to prevent future regressions, though.

Thanks for your review.

While implementing the test I discovered it is protocol version 0 which
triggers that behavior. I updated the log message and implemented a test.

Kind regards,
Adrian
