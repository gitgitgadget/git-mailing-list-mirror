Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011033.outbound.protection.outlook.com [52.103.39.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693E1E4A4
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134624; cv=fail; b=pCR+3AIzP79wicTlXu9PIR0m51yzIs5esfSNqnxecIKP6xC7ioY8bw/+732cwY5Y68XTSlpTHhk+JbYok6ohRBfNsSU9AHGQQoPT2MBVMieaZ4NnsHr8yZZbWMJp5lBUxRitPxbFN22Afa+yOhQFbF4y3nXLklXduNYwfxYT99g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134624; c=relaxed/simple;
	bh=pNkJepVeywNrhOOqK291nDreKVVs6uP/pQZW9kwmtDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwvkby7/lt8LokR9b+nRgDoc/ToN9bG8JFchwKotefT+EbqhukalJUpTJr4SHRvBvBqDsovKkEJrr2WaILZtGdXEgcTVzXCjWlP0fP2IPWkXGDaldOjPO3cJZZ8w0iMcRkRZ4VJtcNK4cjVOUyTsw/SokJCD6D7VZPZy+oNrIAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=KbgmuNzE; arc=fail smtp.client-ip=52.103.39.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="KbgmuNzE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxfpL0rA+gv3NUWarF6EEiaU7+HOmZg6bgaUXPf0JY4CzbmfwtfWng8ElJI9HTBJmqGuEuPVkf+0kWr+RA+OU84+jOGiy6b80Bus4VR2IUC2ygiIWua9U3j9is6xrQjsJr40WN1O1+n1EH2Dg4wefA3zdDpK0tNLUWZhuACVETVbQOGFYyNPiHS8tRa7Bb31E61qudiD0MvUcMr74uFU8bK67YN2GEWqor1HvTVXcol3LCSm/az+RyQ4ndfYMJhkKb1UWdvFoDnIVGqinBhQdJi2TDF9W8HuwsWL1I9DJOgk3GXLs59OdbJO3wBBkzmJxdaVOJTLt+36SwehjOArUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ey0ev2mCuQE2vFNkZz18qLv5ZH3ONXMuAk3ZUrM+GY=;
 b=j8vlRKQyhFGbDIKrZanxSvs5Zg4bkPG2/XGz9Jc76m30pAKfSNETHG26SEmMUFSz7qFw4qe9gNfTZAwP7KJhH/Ei/OR8IqGuTciuT2MaP9odAfo2itE6DxoIhNz92sFkIeq85CXXeuoOPCbiBmI4BkbqjWNK6G5PXPWld1/O2fUjt3GVA2YhfaAxwVeYaCAdiT4Dxv6wr8nOXq677dK18ug71BYZu9CWUm+YS0FLCzrlla4cojCZc4IkC7M+wS5+FLKLjWYb3dNpOVDW3JnAfq1HR0g4LOTFra7JW8cQjh8HXFTPRJqd3ezSZzUVm3iLYvR3z1RSeViibTtrW6yzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ey0ev2mCuQE2vFNkZz18qLv5ZH3ONXMuAk3ZUrM+GY=;
 b=KbgmuNzEc/tjgGsyOZuvGw1jb/yzg01FPmW5YTgrsrz7tyJdA9mKNa6bChtMyjLd+GxVVrOJi/fItfMWRCKmZvqWFccf2RMIY9lrfy9RmAin4/Mu1AgqFxKTGnk75rmvXmwJMQt76z6WcggiT+FR05/WtRz08rVjZn0g3/QS7PU7Pjwy5uXpC1lZvUA4LDj9oXUnFFdxgEFYCGpABSR1bIxfV8tm0f72yGRrZbLK2z92sEX3JTFmWUDn8mwaPGgaqhtt6pWtYkYlckALE3PlMG/+Jev/NxHcHkvtDiDD6eoPnAtCSHwBlad0al11ulyRS3qiKJAHesab8jVh2AEcGA==
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com (2603:10a6:803:82::29)
 by PAWPR02MB9200.eurprd02.prod.outlook.com (2603:10a6:102:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Thu, 14 Aug
 2025 01:23:39 +0000
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f]) by VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f%5]) with mapi id 15.20.9009.018; Thu, 14 Aug 2025
 01:23:39 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: tanish desai <tanishdesai37@icloud.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Tanish Desai #TD
	<tanishdesai37@gmail.com>
Subject: Re: Discussion: Future-Proofing Git for Massive AI Parallelism
Thread-Topic: Discussion: Future-Proofing Git for Massive AI Parallelism
Thread-Index: AQHb+XNlVSr7t5kXDkyrjhZY1EgLb7RIm3EAgAW+2TqACjf/gIAI6+6j
Date: Thu, 14 Aug 2025 01:23:39 +0000
Message-ID:
 <VI1PR02MB427142ED036197AC552D0865B335A@VI1PR02MB4271.eurprd02.prod.outlook.com>
References:
 <VI1PR02MB4271E311313F60FB07359BB0B352A@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <32989B0A-2DB0-4787-8A08-BDED46258C7D@icloud.com>
 <DB7PR02MB4265771098F7314E47D9F2C0B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <6C289832-28F7-4173-8C65-A95EEAB333B6@icloud.com>
In-Reply-To: <6C289832-28F7-4173-8C65-A95EEAB333B6@icloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB4271:EE_|PAWPR02MB9200:EE_
x-ms-office365-filtering-correlation-id: 7233adf8-db11-4874-899b-08dddad13306
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|461199028|8062599012|8060799015|15080799012|31061999003|19110799012|56899033|19061999003|52005399003|3412199025|40105399003|440099028|102099032|18061999006|12091999003|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4Ja3j1tCiSnmS9ef1vCULlexmEoz5olkFcJ6f3kFvS6fUDnAl4o5zM1ij6?=
 =?iso-8859-1?Q?tRhudMzuURYBfE37/7NMhsgb/FE7B9nSgoGMLeag/itI9tq1w0FCyuUO3c?=
 =?iso-8859-1?Q?PVb80D++fOtZJo6QGj/E0t22814SvlbUNx2N6Lf7nNLR6YVda/idIMwHkI?=
 =?iso-8859-1?Q?JIlpcCPY1Qf3Bia0Jb/FodxXpE0sCw8KPZYMxNJqD6cwg5ZKG0vH9baF0N?=
 =?iso-8859-1?Q?PXsYLf4QL4WyrVuUSaDv0qIGq7n2atfNNrWIHW3d0dw4320qQhlDKPQS4F?=
 =?iso-8859-1?Q?gA7j1kzjfZNkj7LoNsbjpr289R89iE5ULInWC/iSYxMDKeV8GTujGxcdMV?=
 =?iso-8859-1?Q?XfZOQ7AcQlSVWViORE6j9JUqn77fREFyzfjaEv1DOcFkLzgNKZC2VZxq3a?=
 =?iso-8859-1?Q?eXxSCs6BExmxn3Qop9BYAQZQoPmlCmowcY4v7Oy8ghO383LTDiQ6BNkiKu?=
 =?iso-8859-1?Q?+sVCkVD4pbL2VzMPkPLJlRkOR+OAH6Z8dW7DYPvyhVLjC32Q0Z2/39BFHS?=
 =?iso-8859-1?Q?UibgvqmdORyvCydL+V2Jdrt9gESrQ/ZT/S6m73YYoFB16YZkBkVbD3i3sW?=
 =?iso-8859-1?Q?yBnv5/cstVsbfOcTrI5TL7LTQQa65HHZBYdvFPIn2Bs252PAgzw/1uc7GS?=
 =?iso-8859-1?Q?OXtEHXHZQuJnsxh6eQguvOe0KaYtyiragkrlVDmU3OQLmNzwujN5QkSO6O?=
 =?iso-8859-1?Q?nkYGYBOP2clSNxMzZoeLJffRIu103aFPuHmglV9HREr8pNUaer3KcNXlgi?=
 =?iso-8859-1?Q?6aVbCy4/sw09TBAbafT69M8Mf2gz/bZV//IuKRT+3TNvDzOJcp54rJ7mcm?=
 =?iso-8859-1?Q?yzDTtMxfXdzJHDDOFSR+7GJTkHxZLHPF3NP9Kr6gJ4unmHBe++txbte07P?=
 =?iso-8859-1?Q?YthbLUcNHs/RtQnAWayGd9Vt7O0WScTEbbZ/iPdVIub53Apxin76d+rwFg?=
 =?iso-8859-1?Q?MzqvG6Swc+5bDM26xTFHqPpvl+ieZ16hnrbX8I105HwNE+mM9CZpVC1Y1n?=
 =?iso-8859-1?Q?iEXI1X/ZhHBnIDZMiAUwL/Ude4fnCi90iHk3MhOQ556XMQpRpE5Y25vTNb?=
 =?iso-8859-1?Q?ggIaLni9toy94LpE3jHhVJQFFvMsuuaVaaAHLISl+AE+Xo2UluHf+LTUF6?=
 =?iso-8859-1?Q?panqWPGmJci6r1JTunxWisbAe4xG9vi5BSlmlTkU91+df8hgCHZ3HX//cx?=
 =?iso-8859-1?Q?RA4OUb0qbcOMEeuQHmykZXqz4j2euVGVyQMcWhYJSuTGpwMX7Z3pia1Zhp?=
 =?iso-8859-1?Q?flM95Hqy5SuFZ8eE6rAdalIplj+Np+SlfDBCz6qKv1X1UwaTzUCt1fPPsJ?=
 =?iso-8859-1?Q?zHAtNxoUCojuLagRhS0rkvhFE9jom6z5C0eCjBdiGz6JoT9eyFu0YYypHt?=
 =?iso-8859-1?Q?1wpYthPZ44to3SWqbT4qITNRoDthYWng=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?36qEiiZE20NiQx3u0zaYGssCwuG6iBiq+FKYNrpdOZ1AU9Q99LtgSuEZss?=
 =?iso-8859-1?Q?XXCKGtabjRP1Wo/GjH6PbA93zEtM3mBhNKShjoohvfvcD7xnvwwEwBNnWl?=
 =?iso-8859-1?Q?HDaZ8WRVQ83Vn2gyQeUN71XkmCwB3vqMs+yxPj4Mw9s6jGW3zQPHQ6Ug23?=
 =?iso-8859-1?Q?fOygxJ6Yp0ioW6raKFGdoFzCIGa45a4EoSAzp+JCJmGdpCzIBHWepA9Xy5?=
 =?iso-8859-1?Q?sVImz3ssQKQ7n1yFtuzPp2MrUbCwZ1mivOkCiaXvBaQfOIzq32/v+NAoob?=
 =?iso-8859-1?Q?1BlllN1T+0LW92BTv9Ln9At0bgrJx9lRfMXkafe9c5uc8sqvbpH8/rWl+N?=
 =?iso-8859-1?Q?Jt4xrRbAsO4ruQEJuVNGm5FmuVkxLKvm0ehgRGjG2P3F/WkoFksTDTKdw3?=
 =?iso-8859-1?Q?dvGMhNf2RZ7fhEk+xcMnaPlBeVhCeo6OiaHL7YqGg9/mTmpvdTsIvXPK01?=
 =?iso-8859-1?Q?KJykV1m95bqRuSzk0pVJvCF0WfYj8ZYLtv6SQ5/9jpcJwm1XAugk7Lwv+b?=
 =?iso-8859-1?Q?XjZ6oIb9yhvWyxl5hKDTpJ/fnA9KZcLv9LBGwv4Ojlz/zmRLG+N1ZS7CjH?=
 =?iso-8859-1?Q?xoayyna0FRhEdhGxQO/4YUbUFVyu6swZ3aBOEsH9JlRtnm8dqHG3Xi88dK?=
 =?iso-8859-1?Q?i2KNgIjXR0mDIUiZlX+K7D2f2RC2JAQA7nj62X1+pNpDAHUHjJ58reRkDK?=
 =?iso-8859-1?Q?V2TqGB/S12Y1ogVi8nEr0xDIjOCE4tS1PpokAsoJ0tWja+zvsSemn9Ksp0?=
 =?iso-8859-1?Q?MYu13dCAEs61P15MXUWN8uXLOXNNsWmbOru27tKdKuddCwgf2qd8LGPaWx?=
 =?iso-8859-1?Q?OqElf7l/qJGUIIKt2DQj5TE1nH0kweruC45rbQMOF0kUCY1Ddh5CTqY7PO?=
 =?iso-8859-1?Q?FxDdvFR9EMEsU6hRTgMtrF0a1hGAnj+/+JE1Tbf0o3QOGbaceD4cXTe5ot?=
 =?iso-8859-1?Q?tDVzRdjWUqZG/1jXdXUCuw6Df36UlPbl0710HlYuG7BGUVj+OHpm/T2tvS?=
 =?iso-8859-1?Q?D3qB7wxjS1ai5Bu9iYGaLPFyX2NNU135KkO4wwF6rEoqk5hWDjc9cOSfA9?=
 =?iso-8859-1?Q?H+GKtn4K++nopfsomb8bA8nMfKgofy5ar/p2CrQRaMlY+Y1OfSy8pvskJA?=
 =?iso-8859-1?Q?rQwNnD2DIkagpu2Zx4ay4oZ+Gra57rzmCtCcTSrXAlftSkqlrfi2RpaW0/?=
 =?iso-8859-1?Q?Gj+/ZO00BUNaATdajyER7uu8GNNIzCnQi1GFPBQKxixpKmFF+Tl7Me5O0t?=
 =?iso-8859-1?Q?G08hnvjMI1eaClgsY4ZLHOtz0DuUltg3cndZ/4ruSnqOhErkdR6ZVkxnr8?=
 =?iso-8859-1?Q?9bG43G92jBkYvjNJR3TcJbzxudisoamFh9wM/eDSFgawYZA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4271.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7233adf8-db11-4874-899b-08dddad13306
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 01:23:39.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9200

(I shall reply to your other replies in one reply):=0A=
=0A=
Late replies: no problemo.=0A=
=0A=
Why no linux: I know Windows well, runs good, don't know much about Linux, =
probably too easy to wreck ;)=0A=
=0A=
Why not git itself:  Git not race condition save ? Is only a client ?=0A=
=0A=
GCP ?: Google Cloud Platform ? This cost money ? or is it free ? Why not gi=
tea ? What does GCP offer that others dont have ? :)=0A=
=0A=
What is Skybuck's Gitflow ?: It's a gitflow technique where before each new=
 work a new branch is created, then work is done on the branch, once work i=
s done the branch is closed and integrated into another branch, like an int=
egration branch or master.=0A=
=0A=
This Skybuck's Gitflow is also describe on this very same mailing list. =0A=
=0A=
Skybuck's Gitflow still under evaluation. The AI liked it though.=0A=
=0A=
Ramdisk Project: No for now it's a fail, but I have not given up yet. The o=
riginal author got involved too. I'm also understanding what gemini and me =
myself included is struggling with in transitioning from AnsiChar to Unicod=
e.=0A=
=0A=
Some small improvements may have been made to the Ramdisk project. However =
for now I believe the ramdisk service might cause windows/the computer to h=
ang on shutdown, more investigation will have to be done. Windows 11 sandbo=
x environment might be usefull.=0A=
=0A=
For now I am fatigued for a few reasons:=0A=
=0A=
1. Little bit fed up with AI and it's struggles ;)=0A=
=0A=
2. Tired from Battlefield 6 multiplayer beta gaming, however in a few hours=
 it will once again commence.=0A=
=0A=
3. Super hot weather in the Netherlands and will continue for at least a we=
ek.=0A=
=0A=
4. Bad sleep I guess.=0A=
=0A=
5. Some real life things to take care of but nothing too serious.=0A=
=0A=
So my mind is kinda gone... bummer.... I hope to recover from it... maybe a=
 week from now, maybe two weeks.=0A=
=0A=
That's a long time unfortunately.=0A=
=0A=
Bye for now,=0A=
  Skybuck.=
