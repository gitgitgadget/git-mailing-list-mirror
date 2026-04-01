Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023090.outbound.protection.outlook.com [40.107.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65137E2EC
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057724; cv=fail; b=VK1bm3nrMY0mOgFG+3wQ7drV6RkjbzN74W3yM5ejX5m0Ea+QwkHlxetztbGkNl67QeebPqrPUVFjB6qizD4JZqchwbXfm4nglbNW7j6iAZMLnOx9a+b0eF9cKY+KFCMb5ezu59LlZFoB2oZUknyTEyrqzwaYeg6Utwly3nCQ6xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057724; c=relaxed/simple;
	bh=94RUGWJa0myJJfLRIwLE2osSossUIq1Rep++5qf/LPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZ8vB6rDZ0gdVnAukHUmd8wYuTYvk9wObUyZr18PL8wDwLqSCryqww0T760dxuJd3QD51u2gQS1GgIq9bf/E2x+LaiUIIgLY03xm+IQ7Dz0aK9+1iH1IY/X2MzZFSZCZ78LPDq2TVCuUaoV4lEYag0SZ9lb2g+HWxm5+NXYvBhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bentco.biz; spf=pass smtp.mailfrom=bentco.biz; dkim=pass (1024-bit key) header.d=bentco.onmicrosoft.com header.i=@bentco.onmicrosoft.com header.b=pJuT6y9v; arc=fail smtp.client-ip=40.107.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bentco.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bentco.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bentco.onmicrosoft.com header.i=@bentco.onmicrosoft.com header.b="pJuT6y9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHzbS9IczHDufe2NQXCaIc9VhGOIxxfbs1YmHkds8Rspl1t9cHVZQd1IihmxEGTS3ix+Qp2FE3NpXkftgk/WbUU6XXkaUo5qarX0GfB74yJlAYXhiILHWZ8datUXN5xcDxzAGwkR/rVDI8oOaPsppMMRl4rVKsBGOwf52BKQquO8MmB8kniReNMLvT9HVk2eevFpfzx2b4XD4vP7aiBqmlxK6GNKGsP3UtiBkGbpzM5KavMYgyqEDlptilMBQfXtCrp3QMppil2t+czfeB60WPNNW+AJwGqYBKwW9TvKwwFtpAhCf3rTPwqvOPfHeHU1n0kQ5ysOih5Zkiaya3QK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94RUGWJa0myJJfLRIwLE2osSossUIq1Rep++5qf/LPo=;
 b=tUdT4cjF54iht3dzWLpdizZcoLZbPYumz5lRF2TZk8ZnPqMIx3GF6vu7XnNTctCvermVg4P4vH0Ji8vXKyWE+A7nX37clfhGntpi3JyVBeXRoA30Au/53VsVDw74JsPqx6fchCUaFqKRWAKu8cy4HndRyUuzcP5PGa74oFdXCaHV8HvOAtaGrmIw1AjPztyd3/eOGfGBFBWniut1Eeth3VGPfF15BeTHHP4dP32HkIMvCelic2LzXCRJFkInvazSTW2oTvfNvSQLv9DwmG/oN/6MR+wZVxG0zfvxUU9ix9qmnsfI2c0YneLJY3newZjXXXl4M0y7Yes5F0dFa//FEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bentco.biz; dmarc=pass action=none header.from=bentco.biz;
 dkim=pass header.d=bentco.biz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bentco.onmicrosoft.com; s=selector2-bentco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94RUGWJa0myJJfLRIwLE2osSossUIq1Rep++5qf/LPo=;
 b=pJuT6y9vow/Ye8WrGOv8rFpN0ONjK8CCz6Cfb0dQt94ZgkdCc9LCnHbMFfMuF9BpNW9spMdaRxP5cxV0QziL/L2BKnZT6SHcCsTki3mlEk6gPc8rx2pHhxzmP77gjAhjwz0PICJVkS6Kgcu5K5NMUcn8r2uM14gH3t2jIUG5tKg=
Received: from DB4PR03MB10106.eurprd03.prod.outlook.com (2603:10a6:10:3fe::10)
 by PA6PR03MB10434.eurprd03.prod.outlook.com (2603:10a6:102:3cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:35:17 +0000
Received: from DB4PR03MB10106.eurprd03.prod.outlook.com
 ([fe80::2f17:89b0:cc2a:6c9d]) by DB4PR03MB10106.eurprd03.prod.outlook.com
 ([fe80::2f17:89b0:cc2a:6c9d%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 15:35:17 +0000
From: Miljan Mitrovic <mmitrovic@bentco.biz>
To: Patrick Steinhardt <ps@pks.im>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Cloning an empty SHA256 remote creates a local SHA1 repo
Thread-Topic: Cloning an empty SHA256 remote creates a local SHA1 repo
Thread-Index: AdzBxYyt/MZwr5NiRMKl5YunO17DDAAD784AAAXnO/A=
Date: Wed, 1 Apr 2026 15:35:17 +0000
Message-ID:
 <DB4PR03MB101065ECA4EC20732CDD56747C850A@DB4PR03MB10106.eurprd03.prod.outlook.com>
References:
 <DB4PR03MB101069CF70418ABE11AAC1CF3C850A@DB4PR03MB10106.eurprd03.prod.outlook.com>
 <ac0TNM2l1r_cgwYj@pks.im>
In-Reply-To: <ac0TNM2l1r_cgwYj@pks.im>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bentco.biz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB4PR03MB10106:EE_|PA6PR03MB10434:EE_
x-ms-office365-filtering-correlation-id: 1313bcef-f35a-402c-9bef-08de9004468f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7055299006|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 iydGA5n0cX0AkI49i76JEY9D1szEees0AhLXEw4rUbH57/T8mNFPksp9VDrf/GSm5gcBB6HXF7YY5AUJd2/76H53UWjrE7cR8CpLbbQ3RVH/GPOfOC2r0OmCHkv/ai2rYKdRBshXxV2lGHH3FM7akheIhx/bVpKwzT7CCtb/MkXKiffMw3MCxTKHsJDpTuNXLHfU/gh4ZUr089dwcKlmrhFthZEOFadO/HMMldf2DnuUp7o3k/e1ewm1pQeVXU932oO1ZpqxS6Bo9lqbxr3hgYQn8r+ZA9X2kCpWgxFBXZBt3mC541IzX4H6HMhzcL8KyGH2OmR2RaVnMWlewliuty8QmFYPjhHr1Qs0ki7unVd9ZBjCYPBpT7b12nnI8Yg9If6sx3QBFNSyd6SiS9svAI1s7cst/+NN8GAhfyOoNn9iFYP2Y9V2eLnunVLb7u2FvgrlcKVnNgBedlEylvN5YCzUMw/kG2rrulixRX0CSErFPNTSU/nKig5ciP1sgnOthet08ZUcy9QLRf68qi4ycTJr/zp1W1wvbQ26OFoCojGkQnz70MYHg2+UfTApHu2erYc1qXMOYqXlKeCHYeSKai28RxtjxRVf6FCDY7m/vchnl0gAVCnMQP+uX5lK+syWXuRyZNUMvqDvj6+5LuCPdJFzPM13XQyUk6qrN71mu4/X+bn6HvjBGudxyfpvYtsibhGMWzKB0KpuuKpZPMnZE+tsRGJ16uNZmlw85U9dZdq0/eMLVtEczHIR+MQATgNxLjJnbSnZD/EYSprPfU5UtBMWFj5nhfU5oKZ1nvK9HqKgSofYCLjxIhqB1I7DLKp0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR03MB10106.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7055299006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RFwnCDEPG7yRaax347z23Q1v4NOIL2uft3VGs1eoLVTXuo0ntFGA2NvsGimo?=
 =?us-ascii?Q?YPEvOWXoWYjjoR9OyIjMZa72t/moSUjZRM8JMsDSylnGI8W7zZKjjV5AgHk+?=
 =?us-ascii?Q?ANj6SZG/xGhDXAbHdthwr1EApPzPyuL3o0XyxeDmgsffijkvWUJaWGRiucEk?=
 =?us-ascii?Q?+3DZdP/cQ89+2NK1mVa6vNCamPLmGg9BJ3cdZ6F3mU7rzehMxaArvIggMuzy?=
 =?us-ascii?Q?/nyahHRSWjZOvhdI3senczzRVD81F/lwXtwLSrXXt754oG/ZjCpW+4M6DDII?=
 =?us-ascii?Q?v7eumo70zIzDxYpMBBgj+Q5vEfScDNOPfS43F1WWu/j2WjXpaacHxR5ZjnrP?=
 =?us-ascii?Q?fmo1D0cHTCxSFcdASMgPIDGfHbpyHJx4CUzMQqVLSWdMAL4koKpHW4dFVzwl?=
 =?us-ascii?Q?h3TqRghYjPM5cK7jEkVhNA22gKjdkg7/bAAfdz+7NPQasBS6z38VEvmiG/h+?=
 =?us-ascii?Q?KoYmLzFy2t1BJGbEORVIUUtkeTfFkwgdSuPW1HeQFBGqkpyUt6/Rd6jnp0jA?=
 =?us-ascii?Q?Na/5rHFV/PY7CXnja9ERL6YKY0otSLLiIWPof1S2bYA/wzND22Rlw4zwR8GQ?=
 =?us-ascii?Q?R93M/aPNVTLpHz8XFGkzgvdmSyilBr4lmzkDfMkKd5iwrjaS35JTq9lMFJwu?=
 =?us-ascii?Q?+/FOJ+w/4JzUu8ZpNPMUFN7B6qGBw6dsD2n0D1s3TM2q/zwsLqsbeR0H1bM8?=
 =?us-ascii?Q?OSSfhDPq1lRjhbZuD7CJEGRXFxWohigOP9Dwa31KIM4fEWNkp8LFQDWFobll?=
 =?us-ascii?Q?VC6GBKhc/oarE0Oyfinx6e6flhxs19eomLvkEsv+byfj/ok2I/Ni5266iQO5?=
 =?us-ascii?Q?u3INIjBEm2e9WLlII+2tNXcWufTSqYEOEZu6GFU9n/gOOiCDQX3m+dKt44N1?=
 =?us-ascii?Q?liHHstt0n45nYj7gH3U90lW5FuE4Cnh5TXw1wr2l1alLX3yEAUKY2KyiJgkT?=
 =?us-ascii?Q?lhvMAFHKG9KMBACY6PwuFmEPjX2A8SP3Ms0Uv/sbzE2dOH1t7Uucy8Zga5vy?=
 =?us-ascii?Q?Xbt7EW4PIQmvLYLvgsxf5zz63onuvHrL69OJsjuciqmghXhYID4D2Jm0CGYh?=
 =?us-ascii?Q?XMI72Up/Q1ekbyxwFCjvkp8h8Pn6oi6G2jnL7wwaAFWRW6yL2I5G6x2aBh5q?=
 =?us-ascii?Q?vHpmGrLp9jDw27CiDz/pWUOeqlQZ1clsj1ye4VcUJdqKjuls4cz5b0QrctEn?=
 =?us-ascii?Q?d5akgvca6Yhi2S0StXKmmQ0RYNHgJVb/iARIjpZyNAaJPr0XKcxuLI+aT4Jn?=
 =?us-ascii?Q?EAo8aY5/c3xU/mdRe5mVIRS1ctG+pkvVdT2lYkwOVlfNR2JBDJ6CFBqTGMy2?=
 =?us-ascii?Q?ev65biZNNuKtVpn7uU420ozAulW2+a9Z/ip3r7YERfbtYhyFtDpmG/9w1uXp?=
 =?us-ascii?Q?kCzthHICFNggoUDJzYfb3yjNmoex88j3F0+3JuvjejSDT4byMbzk+OJYyFY1?=
 =?us-ascii?Q?y7GCisrADUMT90JpBibHcwg9ne2PFLRSZorjBsdwNxSubvxgIRHEu2GFn/1R?=
 =?us-ascii?Q?9ZAHCIhhLAIX/ZGuij/DNCxd9UxrtLUccKQPGCh/OBw+QvnmoIXWSiTGWdLd?=
 =?us-ascii?Q?ysL29wAiIM+2FEwfy1UxarbvVnCpefKL6FiJvq6czXTcboynHLwoogl2xvml?=
 =?us-ascii?Q?KrudCjdHvpJb8cXSVScKw61pl/iEdLaNMUd7VSYtJZyF59AzVtQN+Pgh6eeX?=
 =?us-ascii?Q?O2eaBMt5z0Yjn6jq6r1DuxWZgvJ7QNkdBqy5XSkbVkxMztzU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bentco.biz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB4PR03MB10106.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1313bcef-f35a-402c-9bef-08de9004468f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 15:35:17.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 74d7b2bd-6b03-42f3-b139-4dfb5adfdbd8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xLWqtpqLI4VC3dP/YwK6IBCGxQfjLjWd57AHULHyQK+aCgQraluwcJAi2Ng22vP8EaFUd8czTI3EZWzTJNyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10434

Ah gotcha. I just see that the client has not been auto-upgraded.=20

I moved to 2.53 and now it works ok.=20

Thank you and apologies for the false alarm.=20

/m

-----Original Message-----
From: Patrick Steinhardt <ps@pks.im>=20
Sent: Wednesday, April 1, 2026 2:45 PM
To: Miljan Mitrovic <mmitrovic@bentco.biz>
Cc: git@vger.kernel.org
Subject: Re: Cloning an empty SHA256 remote creates a local SHA1 repo

> This was a known bug indeed, but we eventually fixed this by announcing a=
n "object-format" capability that tells the client about the repository's o=
bject format, even if it's empty.

The fixes required for this have been released as part of Git v2.41. So onc=
e you and your server run at least that version it should work as expected.

Thanks!

Patrick
