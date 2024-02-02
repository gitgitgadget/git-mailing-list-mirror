Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2095.outbound.protection.outlook.com [40.92.91.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F678B6D
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870885; cv=fail; b=r7rAbuG1z1o4bljX7jds263d45gzz3o4OdYck3LShCo3wjZuBcBGiN1pzkmRAjg6xpbG+iWT5bnRR2eqd3E7k3/4UB+aQXOtVsm39UF/3acypzyoDfUeaZZhNIkDpO4K/VzRwzwxLzTWpqe/ksMXocleJsqiVIHNNJXvbEJy9lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870885; c=relaxed/simple;
	bh=3lOlZCTLovBlxBrCQfriLOwxkNHZDqyT2H8XRB9UR1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QsnGnbExT398NZyiVbHXKFCmkkb5uBv51yTGi7FdpYTQq9LyEQsIX8d7mrb5VO5wla6qsO6PxF/yXmiBq0hTylSgiVMcLMEFqyValwGs4CiT+JL6u0ng3l5OzJFB3bpx0FoKOOLilMFbEM+6eNbQK2xIORKMkYQW8JZEhr3BQjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Jgq4q5Pl; arc=fail smtp.client-ip=40.92.91.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Jgq4q5Pl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWSL5mqLL7dNwKFT1y2kUYAh5w6KWproKKCgIc8o6LP7HYVfi0zYRRHI4W7Hs0GmBiUhlrSuGbwgsi4KryHMeCz7VPspDz6ZB7MOryVKB1BLk82c/gkfuMUrKMiPVoH6/7gNrGj1zszT3tVYDq2vUpuH/FkwyBGWA8+g5Rq3f1zCDYeqkWxxKuPTps6/m6YkK0Cd4mkJSx3koSRr2X6co9/liDFII7mMw4cM4S2EOeFNTZ20Ipf2vxzat+ahBhy9x6fnSSExahM/qHxeT9ANoTU8gmWkUoG+fzX14OG6q5G+OhwJpZAfr3Qq9bXznisj++r5poYP4iPr2FB7CMstdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lOlZCTLovBlxBrCQfriLOwxkNHZDqyT2H8XRB9UR1k=;
 b=Guj9OBNgeam7cI0vqpp3cHX1ALtWJZu9i3Tctcf2VOI6HKO/5jsKKOy9Eoan0D1TWPbTYMBPEEjrwV2HfGUNvwbN58Nfw43mkuLOer9LLjc+gnzT3J/Xh9y7y06u649Jw4T36uYM23ZIn4BxLztjhHSJb9f2Gr/NY1Z5B+jp5awuK55Oh/iRYXM7nze71I3VBg3XfbNB6ofiupjuKvrxq4d4QUqvI06qvDTnZqL0BBSFjDngFYxS7ZYbqW/GSUlvyKhUuhRTXom7rL1pU4ivClixC3zpBmpRXpTANQQRy9xsFfAhHuYI/lIy7X53xnKfvj+sk1RdYZfXi06CgvIwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lOlZCTLovBlxBrCQfriLOwxkNHZDqyT2H8XRB9UR1k=;
 b=Jgq4q5PlWxdfAUmj5pLW3Y3ELmfLjV/HohXXHrN5V7zkG/NxwOuov9JwDJ+NMJVJulvDUdJi4O3jTsyAU2K+9BLIldN21kg29jn2sB0Gz6QEiYBRLsWIKypgVyyt8/Z+JELjTWU45QIgZw29mD/ONXNzZ+/RjI39e3ve6xcr7opNW54TNkost5krbbWyp3zruBEetLYlfoQG6jNh2qiPnIna1lUJscmfhFvQPrWDtZDPq1dltJyIcGmTA9wnHISjcM0brbh3hZt+DqO6EbUJP8SeuzmxknBQVmdvEyU+SPIkKQQLLRMh9fUK5FR873QwBKcY65ofNO6QYc/BeFMBlA==
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d9::18)
 by DB8P195MB0630.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 10:48:01 +0000
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10]) by DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10%7]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 10:48:01 +0000
From: Hans Meiser <brille1@hotmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: Dragan Simic <dsimic@manjaro.org>, Konstantin Ryabitsev
	<konstantin@linuxfoundation.org>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index:
 AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcXgAA6fwCAABmD9oAACw8AgAAGJuWAAH5PgIAAkvjQgAAEw08=
Date: Fri, 2 Feb 2024 10:48:01 +0000
Message-ID:
 <DB9P195MB21306A747B3BEBB53FCBCE5FE2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
 <DB9P195MB21302F96E3E2CD404FDBF9ACE2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
In-Reply-To:
 <DB9P195MB21302F96E3E2CD404FDBF9ACE2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [Gt0ZYGwVK5/PBR+i5QG6OVq0oqt0gSAN]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB2130:EE_|DB8P195MB0630:EE_
x-ms-office365-filtering-correlation-id: b4fe45d5-9531-49d0-3083-08dc23dc6d89
x-ms-exchange-slblob-mailprops:
 F3kBGFPBgzYX34cN5wvmE1g/1jaARvbY/Vt6eU1bpiMsHePsCUf+eMR743ZhFI8GqBL4jkSSG+Pep58yaTtPqdG/02921hP4GO145hUOAA/FkgvuQuQqTdaAEhkC9M3S+aLkfgeoA+Cr58y7CxhW2NzGw5z5xjKs3iEIMC1dFaAowx/vo7m16GSXo/4po3kvRQTrFFqIQJHGs0PQwTrZDcZj2KKEPhRsuXaDaTSD1gKQ/9XP4BcN89lMFOONm3RUPQaeZbtsfLL3JXnLzsMKfd4wUaoRTEQGbOGEi7/2K2TKnrLt6EPFbrGamWq0I66rhXhX/eQc0mRY9PhiJg8FNc/G4wA3GbbWkhig8mLn4L8ZLEq7QBboFmLvZlP5InYRPoJLBNvJZnkjrhaNLIEjt3MAZ6lssg5JcouMJh8Czm8dO87gFOVxX5CcFYrQDW0WQ3LatNjfGnkOVXA/5a65qljlG9Tl7fo1t3eIAXC9EM/9fq5NKVRNd2Qgf7Eo/n+cKLy9C5H1ma1B8cNeILhCJNXczGE5sEE8xY63ZbHd4xxDSCbkBHfhVZTkBJV4/pjgKEO8TbMMMq/55QbfMXxXvcFirbAnf5Hu2AZU/VKIrGnKsDVmdLXY5NhikuKQEmQUEfkYN27UR25QWPl7jpAC9bfPoRVBupjIq0ApJawRi1wONJFgmVW6guBiWJEFVcVXHalarMItyPmC00Z+WWk7ez0hExZadeTglalhW4sCtgs8/pJGANAa+MuvXAyPZTvq0mheXQQlizk6GDTbDFPKffUHcqHo4szL
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4IjTg7fEsZh/vaoZKpXkP7SSB6+bwgdVd3IMiXFLjeCGlhudje6mmi9RRkrlcY3yaAPAIZq2447+R66cvuwIqc109t4l/5K05tMaAloonWWWhn+UmFbJ9E+nJbzdlFqdeUpTA49LE0+MFc0a248rtbE29KRXAhmN8qA5Xie5EjvZfRMfEuyk5EZoX1RTHjEsl21R1H+ZFU+9dPC2SO98eHCNTSoqkLNIsqwvDs4pypMZgqDMISCkufIFngoPrRtfTXKqDSBPfva6uEQqX6gPKutWE1Q7mfijDtLXef8hDMCOJFdan32dR/F7cLq35hezJ3PAQB7tlTxfdxMQQG2fTknYZztUz8lWso8axdoLiVg+Xw3QfTUWROyNYkJJUWQmVAiyEbwWxx267XScMjT9SExF73zDzAEc/DmVh/Vuilow0z4eD8ppGQ61KB8rUdgx0SZZzhWg1ctPfcmrEzAFogPuymfkA50G3loX96mpD+BGYtvUJzYcLk5F5ySmgcGxdNhut7PSK+K8noA1UOKNXOkAimKQKkLQk4RO+Uhny442Xpbg808VsP06m86g5v7ZzQSrj6oEuja8uIszJz/79vlZb6bUyJ9eWw0mDtm1Ebg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GxxBYrei9XxMW4qXyzf+UJNqX6puHrlI5L6Ykwq7MXebloJQphKe82lX9o?=
 =?iso-8859-1?Q?Wh4OqO3hLcMYQNs5yUlsG5QcvplTJcfmcpaXBGxPTgvsM8qvDq6mYzy7u2?=
 =?iso-8859-1?Q?o82zbkw0Q1nXYBPTfvkOW6YFymISKAkk0sddEJ0G1t7JzWgUgvcRyWUKgO?=
 =?iso-8859-1?Q?wXXmt1hd4sM1ygazWqYcYV1mGjvcBdLA+ddMfQCfri5VnIAvY2osltzht/?=
 =?iso-8859-1?Q?wo1p9r6/Be2bOKrrGXQwRGCmFw2OaKGepv28p4FhMOv1GsgAstDzfQ50Ca?=
 =?iso-8859-1?Q?EzjIwNBch1t7gruIb7jhuftXtJUalY2cZMFxuJ12OktNZEo0SoVN4Va6wy?=
 =?iso-8859-1?Q?c0C5DhmVwFigKpdP1LsQ9NVdFkad+EA9wM7+GamQhjvWu/vC9g+Vi4K5Vv?=
 =?iso-8859-1?Q?vlm7q5eteJI2u+GR6X/O2kYUo+vOUZkGp3SYXT4vaH5MejH33djkGAg9qO?=
 =?iso-8859-1?Q?wT1Vhn4c4CZ7Em+rYs38zgBKN6/121pQrfOYSie2rLd68SUNEWVJIzJt+I?=
 =?iso-8859-1?Q?0lnKCgqtHGH6PEr49SfZBrhsqv71G6gkUJg0BdVDEwk9QOgDFpya388aoH?=
 =?iso-8859-1?Q?O3dGQkQBOtUdLaiStOjmYhGGdnI/7lkY91qmgN/FulBJ2h50OZnsGC01Si?=
 =?iso-8859-1?Q?AKxShTcATGHLs6hilKJNkYVsyQ+cpU06ya05pfgOmtQu7oF6f/VnDv7b8+?=
 =?iso-8859-1?Q?GgJzfSwGRLEAC8+suYwSFyVlX4kGBiCdrEvKTp6ty4oEvjLXLgtgjUdnaY?=
 =?iso-8859-1?Q?oXWWppom8VQSwHdjtFot/U6jB5cixuct79+tRmXX89K19tOF/5ukgWVQPH?=
 =?iso-8859-1?Q?wkihVyQVYi4agrnVxPOYcv7dVr9qIh3K4n/bDstM6J5e+IR9HvY3Phx2mr?=
 =?iso-8859-1?Q?otGF/0tYbgbU4FqJwGyYAer+5MeujgDKuVsr8HMPSKFqNEV6SVoe+jOHxG?=
 =?iso-8859-1?Q?NkwYBpQBxwHt214Q2sYG/lp3CjJpFsLEVquOd4GKcADN2g4UXOaU6z9rox?=
 =?iso-8859-1?Q?h9Y1WkMcxG62GtPz9WCp2z5a8LH7/MzDdkTo6QunYjlMMtEwKGT4kExLdg?=
 =?iso-8859-1?Q?G1z38n7xjZF+cAY6DxG2hbWYfPO3+VnHfk+u5+7DNAwT+Owe9g//eekv07?=
 =?iso-8859-1?Q?11RBkgGI/jrSw2HPddomY/hyBeHRp+EbeNOjCsHL6Sxk+zBCLU/iPndmj9?=
 =?iso-8859-1?Q?cm8jniohMyxl9FhemZU/iQR7+QuU7WfQqlh1wSaXYD7IMf4QqtOtQnop?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fe45d5-9531-49d0-3083-08dc23dc6d89
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 10:48:01.6711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0630

> Actually, there a plenty of converters out there converting Markdown to a=
nything.=0A=
=0A=
You may even want to convert Markdown to AsciiDoc:=0A=
https://matthewsetter.com/technical-documentation/asciidoc/convert-markdown=
-to-asciidoc-with-kramdoc/=0A=
