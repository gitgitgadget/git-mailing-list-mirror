Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2115.outbound.protection.outlook.com [40.107.212.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D94C9F
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565050; cv=fail; b=JJon8fJHGaFG19EesWhybDd7k5zme0gAU6sVb5eOu7JlVWGPu8ulEF0qxTIqaOQ+LjFsuOMTNViqFNIovtceOf0e5FTN6+4pTaN98+bfIVbYXxYs/MslcHfwVgFdwefnakpm0Xr9H3r4IbrWQLeAQEPe9XhFBqkB65NRjr9b/5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565050; c=relaxed/simple;
	bh=hBU8evtB/fUEBa++WXke/3aUGyW82KEqdJX9s6YzNYs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BGwsnUmBicfGR13rhUxDAcmsoT8YXp/Om5jh2FkJBAVT6VfxioDJpPvIh6vA6SOMRZmh4Oat5X7XQhnYMVXEhzVZiHpUxbyWkzryluOas0ikuV/8qJ/9stAM/uhi0bEGKNYXH1lbhnv7OW7uV+I7r7zHYBcXb20ay49PVSVo/WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axxess.com; spf=pass smtp.mailfrom=axxess.com; dkim=pass (1024-bit key) header.d=axxessweb.onmicrosoft.com header.i=@axxessweb.onmicrosoft.com header.b=nluncy/K; arc=fail smtp.client-ip=40.107.212.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axxess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axxess.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axxessweb.onmicrosoft.com header.i=@axxessweb.onmicrosoft.com header.b="nluncy/K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4rIiU07qrlvqnxZhwq+KFBytv35JERrRrXkJgfubJfOyDdjgBfo6ql/OtdXEIiYbJhuGF2uK1t8OuiOgV4ajWhu+RqR4b7PCJ/Yqv9/AhsBDrD0AzQmJMgORTv9+HGrQfRqml4XSdV7CQkbikHhxgFMsJAMtFfY9DW3mTDnhwYtgPA4uhXFDfQCNzFaGgbqMOoVc6zs8VkFYQrxv8BDjNV45pVyfXGIXgXYMXaeMDKtV1hNV45PHrYpVDL0xBM65L6KXbC/BecvYszdFoNAanZ7SoBrP2mueJm+wEPrvzYONqeX5yOC03sHSG2D26Y5hjGRGd8t423qErNaXKAaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XApThL9ZBRgzZ0XIAhVKp1CfskOqdTsjHfc058ZtL4g=;
 b=hQSr392MGjq5vNtKUBFddSxeOs0x+x7bapbi8nDF3tuxo40EiQzWBt4/1pJCKfIT4JSKrrXnnQ8MvnY6hoMjAh+KNUVzZZ+tQWKoji2qd2yvu2cz/+aECPwzpZrrLFPysCWFqDTiAY+Ltrs+IwyDXwGwDQ2ZcR4YQ7FCW6UyfS+xiBbNDTgCn0wunon/CD8jZC6HhN8V/M2q44fRyohGHf7bWBB8Kd5xgVTIcD94vW/f5v+TVoipSfjfiJtpOdycFqDl5LVzga/kDE7QcKp46fzzKrq+eqEDg6OeQZdTa4TxhUmukubSqgcN8tTJHM09grs0gmiW7KRyZoic//3hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axxess.com; dmarc=pass action=none header.from=axxess.com;
 dkim=pass header.d=axxess.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axxessweb.onmicrosoft.com; s=selector2-axxessweb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XApThL9ZBRgzZ0XIAhVKp1CfskOqdTsjHfc058ZtL4g=;
 b=nluncy/Kw/Pe8U/JpBIK8PUoWmZaOKUwZQcLjKIskaDeRMtgljqmvG3vqh+T6sxpXiK3WguI9Ua8YBpOpAtopVEdKLhEufnyf/yUbbwlnhIEDiIrBB5v2jxFVHcsgf/swaMXxKiGrdMdRp1yyw2ZuC7VpKpeOP3bvpIEyYuxIGc=
Received: from SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7)
 by SA1PR10MB7709.namprd10.prod.outlook.com (2603:10b6:806:3a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 16:57:26 +0000
Received: from SJ0PR10MB4750.namprd10.prod.outlook.com
 ([fe80::6ded:ceaa:8e23:ca55]) by SJ0PR10MB4750.namprd10.prod.outlook.com
 ([fe80::6ded:ceaa:8e23:ca55%6]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 16:57:25 +0000
From: Michael Cheel <mcheel@axxess.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git Version Confusion
Thread-Topic: Git Version Confusion
Thread-Index: Adts7p3yZ6pAz9KTRIel9H0eJ+LWsQ==
Date: Wed, 22 Jan 2025 16:57:25 +0000
Message-ID:
 <SJ0PR10MB4750C74BF6A4A26AF4730BCFBBE12@SJ0PR10MB4750.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axxess.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4750:EE_|SA1PR10MB7709:EE_
x-ms-office365-filtering-correlation-id: d056822f-0962-4f40-2f8d-08dd3b05d911
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ICiWBTaHPG/aV2VbZ/5g/Fjhki8+M4qHj7qMTAYa4JfYl1LqUeTyTgop71Ol?=
 =?us-ascii?Q?xJA+ditYtyjD6ZxFglrcVQmNJkh/u4AwvXjD9/SdJCdZrYfoYC6Aof5/dIXP?=
 =?us-ascii?Q?mMI9+abocfOvXAvXxt86Pic1bG/QcSfmHWD6LjURuops7qPTtZ4kfPHYeFQu?=
 =?us-ascii?Q?zKjkBg2VMge4+SEBkFKgCf+yryrlVKZMupyxzE7LKZwYJnvlMgNBBavGxI5E?=
 =?us-ascii?Q?mbw8THzEhtszdw6pYqmxuOU2WRTPDYAIqho/fqAui2OQcOyRz3SFREkL0qHw?=
 =?us-ascii?Q?hnpjEf5uTVaJw3DYDhtwJWK64Q5fOj5nzBWyyjS5rYzxdKNWW3H+Hl3/ffN4?=
 =?us-ascii?Q?hVO8/Al1JdH9c6ng+imIRZlsqBxZGSmngYQkQggtecYSt8tXeNh5Gg0JQYdh?=
 =?us-ascii?Q?O0tS7upR0Hj/QtAbQn7VsASwgER9u+X0h8Tf6GIyUUKW6dFs/O6c6Er37XBL?=
 =?us-ascii?Q?ek6BZf0wTfAMh5TF7IKT8pgDk0e3qwGW//M9lCIeOVDDmtwQkk4BnB0RIxvD?=
 =?us-ascii?Q?QyrC3XLoLMouc7leOMYBs2d8Isl29o62mYEz2ny53QtPV9gOC8qWXzoH7TXU?=
 =?us-ascii?Q?nVGPuQrcym9sW1pduPoJIQEwW4ga+nYh6iDNQKoDY/CxEHCSrFpcuQ0Nyyyv?=
 =?us-ascii?Q?OMy146YtUXSVJqEXoRrzaUx3qmA1tf3XJeAuKOKWMTLpmRKa6ZMRRwmAkvUD?=
 =?us-ascii?Q?XZHn/p9YKVG8jRGn3WyLxlALrANKk9r0iQUuq1qywf8UL631h3U/LJbCurRs?=
 =?us-ascii?Q?zq0d2GSFrqIHeMI90ls9Wa0pnoUXmxv5nF3JcxOBb9M226pzQUE05kCXcVPt?=
 =?us-ascii?Q?v2NI4uvzDQWtoXNBD/s7Z3sVUMHNTnOV68NUA17BuMMShH+2LNilG5JDaS+u?=
 =?us-ascii?Q?F1JmooP1feEgzQW2+GHGAA8ExyrKEA6/X+r3VXxfiED2Cj70XiItfL1JBT6o?=
 =?us-ascii?Q?4ddi6flKpVE2GtpHNiBZuxxz3dST+5ZMpGxe/4QlhyrAn9Uyw9OLHdk04obS?=
 =?us-ascii?Q?BOxPpDFsIy3N6Pl5Uo/U/VLgy00yAN2nwjabVsTRgwLwnSA6h99idPJ0eW48?=
 =?us-ascii?Q?PARC++wy17rhZ2QQvNCeSkVSkH7vNa3QQ3kixN9Wv4X9fbQ3ASInwoQTtI1C?=
 =?us-ascii?Q?BRqWp+K2N9nBeajykwy+d1dvg22cVxUbLiDgDggM1T3ruyJq5FX5ZNQMHqHB?=
 =?us-ascii?Q?O7O2sSg435Ql38hUYcUoKXI6lGFIeoIFtBROVObf+ol6u4MqOIJxEWgQcA6R?=
 =?us-ascii?Q?gw+XreRfNAnsa6Jh2XPxFqN7biNjJZkvdHtAQC+YdIA+8+Ax0b2G4Vs9AOIH?=
 =?us-ascii?Q?T1DWsKLMakz0XXBtzUY4xiDlS9koJXfNMs/kBt1r6s7fAZsE1uyor+aKe/3c?=
 =?us-ascii?Q?/lARzPfjYAs3/PfCV+Nt9TuEKMgNvVvfjuwra9js6uslduY76M2YTamBN0WP?=
 =?us-ascii?Q?/9/Nfi6h9Y/Pkfn1G9rFDa96QbqZz6nE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4750.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oYGYh/QlaloppPBdZG43X8AslLveeh6WWY8fR0u5DCoGiQK7m7L0+NOjBFPx?=
 =?us-ascii?Q?45SpSY1R4Ajdv+wLk/K3KyzV/Qpvh+673b80Nx2FLXyR9d4BDj8ZxCUtUtAF?=
 =?us-ascii?Q?oq9P9i4xWkwYSX5Z1PxAmJ0drjfNZvG0POSllQ4GGB+7LCyVROIg+Oo1oKsQ?=
 =?us-ascii?Q?+qrIrYYxrbhhb8p+n0ufQzEa6ApMZOlvdJ+Ho4Da7iz02b0ss77Um+E4q14c?=
 =?us-ascii?Q?0NNvrpK2EhCESI0hT6HT+pSi3sJ6JhqrRH4ME6W3RfUv3kNUeZub03dSybM5?=
 =?us-ascii?Q?e/ldwBARpzOXrUy8DL7I2GUDqmtLdZCJl1SoNH9GpcleyHOZR6epnBajD031?=
 =?us-ascii?Q?ZJvxgppragVo3GyWNFxdYxC7lwf5q2CC3EPpCaHtrkw3b1EIUzAdGltA51rw?=
 =?us-ascii?Q?TyeD1abljGAQOaDmYVw1/U/mzhGI+Clii+IJ2K+yHu43PRT64xgJqoIIUgXI?=
 =?us-ascii?Q?P0wlmpdpsOXU4V259bNp2OJjpb5DWarvutUKm6NKLOkGFU0bBZ/uV44nztk4?=
 =?us-ascii?Q?PGeEWPZRJ/finlepQXS+zWsNkl0Zo33eUowk+1WrzIDfpK3tvAL6O+FPFz2x?=
 =?us-ascii?Q?ypLplX1blcytTEjgJRP9x+du/nDK6JleKUm2eOJpY8suS2vwMGBhJdUAAZn9?=
 =?us-ascii?Q?nCT3Kg21TZObfcQyRFpMNl22IB94/wfZJN8QbwHFj/I6WKj7b8oopupph5IR?=
 =?us-ascii?Q?iVPE2dR06Z5uT4AbV57U7B9ZM83XOmcw577TgQIS6tiSPYnXqM1gwIVxwv1Z?=
 =?us-ascii?Q?mhy563WY+ec6Nx5ASRdlNJWgtQu5oWxcpvFV3kcQD8yLptWlVXzQeLDm8/YC?=
 =?us-ascii?Q?w2QNAa1DPK77sECUVezam2kHs+jcOoi+c/1/8EJGvbDoi6JyRdpoo90QXsWU?=
 =?us-ascii?Q?kX934IkX/cV637CHXA60VM2zRnxAGunq+1pHR3OoNa4ApxtCJV+jjH5zicUw?=
 =?us-ascii?Q?JaKqn7/76xNakC85bihbvKTsvdBnXrpo5BKRUcoa3nTrLBZmYQw7fohHzbQJ?=
 =?us-ascii?Q?OnB6RstAauqh6t8cTghIAwtb0ay/nFzUJ/dZPFvhEfDYzKZb4g6lVPJSpOJH?=
 =?us-ascii?Q?foG8KD4tpSoL8GWZBAYGTmjsrfqO1eGzp7yTDWp/0xNF024L/VJt58o2Nos2?=
 =?us-ascii?Q?CDXr2zwKvfTOQzbRT7ywoNht36Gh32fIx05tmJPOAuLTEJatap+hvvWntOIf?=
 =?us-ascii?Q?k+YATH/rXQNV2PCCqJnJpg7CGT7cIEVa+RWClnFl4wDhJu0oix45Xj5+ZR6R?=
 =?us-ascii?Q?e2KysS3w5kt+6NbzNdVkjkMuwnWNxgIdIJrJZkfXxpjGKu7AXMf7G4g+mN+s?=
 =?us-ascii?Q?w2oiZho84rpF6wrj4aZggXEta/U7Gpct5la5bagOMH96zTErd06Wo8m25c4K?=
 =?us-ascii?Q?Txg+1/AoeOqVcTuYMS6K04b2z47MiEzynPTXPEPJ8UQMNnYHhIigHe554xx3?=
 =?us-ascii?Q?MOYJkgNCi5s7mETlnQwRywbaS61GQEVkkUhJGdiHXmQZUOpPD2OaneWtT6Jq?=
 =?us-ascii?Q?IuYNVfCVUcgilN3P79BSW46muCYXKwvNTH9cW42zrrc0wTNZ4oPI3B7yDv4t?=
 =?us-ascii?Q?d98EnL1CydrvvSNC1Os=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axxess.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4750.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d056822f-0962-4f40-2f8d-08dd3b05d911
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 16:57:25.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6bf28ee-8182-4066-8c27-bce796efa02e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7E04LefEobI/kMy/pPPnUs4LvrDJYCgFpgatzTihKJe1+UqCqYQTrLAmYxaMWcKMcf/SDnSUB6qgtQ35dEQfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7709

Can anyone tell me why the git home page says the latest  version is 2.48.1=
 (released 2025-01-13) but then the download page (for windows) says 2.47.1=
(2) released 2025-01-14? It is a bit confusing to me.
