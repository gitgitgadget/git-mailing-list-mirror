Received: from mx0a-000e4101.pphosted.com (mx0a-000e4101.pphosted.com [67.231.144.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49A2D9EF9
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.144.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121547; cv=fail; b=am7XsbNc2CKcZSdsA1cIApZ+MZQdrLRGAJ9/ubE/Sg1AJRc+Z+8r1nboaO1ycl4e1hzbPb7DizccmJOpFD8PXcRNgIrSTKgeROOQuahnNNuXJvsdHfKVwRFFli143UAIy+qLZHetGP/JFY8rQ4CgzCyomMwzI4Q3fcDZUWfDBcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121547; c=relaxed/simple;
	bh=z0PyBFKZTfInvgwuHtuydG+Cq2M//sYJzKWkcJT6MJA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hAqNslQTJxkYglimbABf/gRdMbSoDcBdWlk005LbMM1H8701TTGHh3p9otFgJvgOdg7JSaznjf57fLI2yYm8qTRDMds6QiZfBLEamWWqSPmxNPtJFgiik3KMcbrIyWCDgUgdD4a4Ajolb/v51HvRT/4KgCJWUONLbnrSpRZq2LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=JohnDeere.com; spf=pass smtp.mailfrom=johndeere.com; dkim=pass (2048-bit key) header.d=johndeere.com header.i=@johndeere.com header.b=bHlZxaEf; arc=fail smtp.client-ip=67.231.144.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=JohnDeere.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johndeere.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johndeere.com header.i=@johndeere.com header.b="bHlZxaEf"
Received: from pps.filterd (m0040767.ppops.net [127.0.0.1])
	by mx0a-000e4101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEW2HO002294
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johndeere.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1-Feb19; bh=BmUDjc8odFVOQfuslxxSkkD
	Eo/+hBT2QOX/S6oB4fps=; b=bHlZxaEfKQr8n4wLe21PzfbhQRBCZvLaob8Ahxh
	JDrVWvy1cQboubeHJj3oahMnzEMXrcQ31w9SbwXgSqCAETtQrxa6IVyC1/enK5Xl
	mYZ8WTtRLsK9MJyin1QNTu6L1/uC0AjUo0msjYxrSPh1X/pIAWCnOCznTc9KmJ9i
	f7WN9ERRarSxntZcDArH+Q41Jk+tvHhFRaDe0x5JrMQonAtzHD5gSBRmskbsJQHi
	jEM9u4OdBcYn4PKdHJEemo9zo+4IJ7gNnvmw4xapoRWhPlezPvw/tIsfhA34UIg7
	8z6F/rT1fUHh8hib6bUA+C1kOoJZ4h2Zl90jbeW8rq2Gm1Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	by mx0a-000e4101.pphosted.com (PPS) with ESMTPS id 497xu584xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:44:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVYiuQ+kcMt3YF1tr7qy55yfYWeA9znwx8/H9Wz4wArZBxzNpwozxeqFlU2EmxBNApGOyFpoZfvMSIMfspj/bFbWjO2jWug+mMJxfMhjdIezX3TsLgm/B+BODS9f7l4hqwLn22pEAyNHZ0DgFlL6WlIJWhdv7b21z4ogVCk5zhU3E+yCRpsgXNsyHqpvxQqSL4Pg393vgTy72gtdNA4QItYlE9Ll9g/rjGfMaxt94dpcQftWCRm9m+z6Fo3bLHTjEYCczDH+yTfRTfa7KXj3zEU16cqIfrbJC9xKjZWZygdc3PF+pITFvSv5PTHDgwvSUvrIkd+mZAExC2Pb628Cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmUDjc8odFVOQfuslxxSkkDEo/+hBT2QOX/S6oB4fps=;
 b=xcFzuYhcsxThxBcxsOpa8dPGKoDMrjOgSfJ0dBNqlDgTABOB/SYUmI6N5ulG+w/HVNhVZxg1HIkIhBRNmc1sTKCgpnLZ9QfMphi7EFN+DI4XDjhUpD3hBS0kbH2HZcWMYcP4izjNceMnyqkWPcyywllvRYL21uqgIwyF326TLS5gG0+a6/NL/ZjLC89XVJErfFaGETOvtujbCF1ZU4CuOgtCHmmtp8eOaKPCRLrrmhujrkRyApf/8mu/P1/yLbHW+NNU6ToxeR10+AcQA/zj4ytTzNBfF/gy+euzLBcVpM2h32Sg4j6ddxrLS3RIlQSZSm0hLggLL3Z/6KT7zRKsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=johndeere.com; dmarc=pass action=none
 header.from=johndeere.com; dkim=pass header.d=johndeere.com; arc=none
Received: from CY8PR05MB10011.namprd05.prod.outlook.com (2603:10b6:930:75::17)
 by CO6PR05MB7585.namprd05.prod.outlook.com (2603:10b6:5:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 14:44:01 +0000
Received: from CY8PR05MB10011.namprd05.prod.outlook.com
 ([fe80::3a97:45ef:ba86:2182]) by CY8PR05MB10011.namprd05.prod.outlook.com
 ([fe80::3a97:45ef:ba86:2182%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:44:01 +0000
From: Kevin Puetz <PuetzKevinA@JohnDeere.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Bug] git fetch --dry-run --filter makes changes to .git/config
Thread-Topic: [Bug] git fetch --dry-run --filter makes changes to .git/config
Thread-Index: Adwn4L+L8mwJ2RsSTrSupH686MDnlw==
Date: Wed, 17 Sep 2025 14:44:00 +0000
Message-ID:
 <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Enabled=True;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_SiteId=39b03722-b836-496a-85ec-850f0957ca6b;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_SetDate=2025-09-17T14:43:56.0000000Z;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Name=Public;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_ContentBits=3;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR05MB10011:EE_|CO6PR05MB7585:EE_
x-ms-office365-filtering-correlation-id: 384da013-37b3-4a37-bb49-08ddf5f8a416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZvM0UJyF+QYJpTyPelLnti75WXE2cvRPj131D8h7AJxqDqDvCAYehjdipjxa?=
 =?us-ascii?Q?q7MRq/At4DdsUZndK2f83NoLhVcIIg18kDbbjhpCx+Bg1E4uczbr1hug0/k1?=
 =?us-ascii?Q?GF8XAo6LgBIXW4+glwVlAie0iVCZjlDK1NsdsZb2F8QthEqdY+SOowdoSh5z?=
 =?us-ascii?Q?2No6VVAhe7wTntrngW2NIN/hQQwpXsYH/VWH4JKPHJAtUZy1lK7lB1gWzpNH?=
 =?us-ascii?Q?v8Zr4tsYdlZTx5fMqILDoeJmLU1gIe5zZDOK99wDyTZlsN0B6z3QosPOr3BM?=
 =?us-ascii?Q?7ZQxqTVDPh3F62OrElyEFVfc8cYq7vpUi03QeRcQTgzhSz0apZu2j/IDdgK+?=
 =?us-ascii?Q?DCptPba5FEY+oN96QcTKi4EILVJgaFpnuASyELGGfLZaVNUkI2mpyqluFtFP?=
 =?us-ascii?Q?lHK4ncXwJ1ncExxyoPQn2vBlippkZSFKihO80gzHIWXEYNx6heZCSlPRdiK2?=
 =?us-ascii?Q?NdW7QioCOtHV/HHwx2Z+zs/s5/3ss4/MgTBcjwLQLV+Sqlj5JAiJhcQheKl1?=
 =?us-ascii?Q?WYORE5p6gm0zgbr3gKIXv1JhzP5ir6M8Pf1mlex/FenS9N+RV/DVDwVg2YFe?=
 =?us-ascii?Q?ObI9Jd5tKBR2pE11B7QEdEvykGySkBjvwb9n0jp4BnxnfGpvYFYSvShXa2na?=
 =?us-ascii?Q?6EIa3kQ/qS3mutCd1vtJNJx6WeFmTR8wcOz6wDuhrWgNZRkYTdp2Esv4ZCcM?=
 =?us-ascii?Q?qFasCcU8E8Oth5vkK11couuL8m8UTLN2fi9FPdde7CZdUazdPI4951wd9Gfs?=
 =?us-ascii?Q?kzWnpzmMH59Bzx/nayLx33KEnEG9QvsUGJ/NiqKet4GsVQHNf/2gkwxiu9mc?=
 =?us-ascii?Q?potvojsyRHQUntInb09sOHbEE9n71qeoEUKCoFh1fINcQOtTHjaJe8o9Li4l?=
 =?us-ascii?Q?e3k+jmEnUibngYFFaFpA3E8yB7G+LwSWtV149vWnJi4lyvjFSg/nYgDZcdf8?=
 =?us-ascii?Q?gNpTzbfwuN0XmqWx8dv+NC//osJ0w8n05Il+0oABTFFab+LYBUk/FAmDqef/?=
 =?us-ascii?Q?BgT/qO4fc04Y9pA4q1xvsotJ/pKZpQvAcZ0LUnvpdoqwWkXntwcGmY8twpFf?=
 =?us-ascii?Q?HpPRXjqXuBMICDxjWracEBh17FGkEwOzdiS021aFqYSIDPZBPVGPUnf5nxNV?=
 =?us-ascii?Q?q0ehK23kPEfWNGC2N0bJT1cx7e1nby9fiBG8zots0Me7bxK1gzQy0+akH//m?=
 =?us-ascii?Q?Sdyj1Z+NO6eIRe96X4kxCX7em4xPTgyE5XrwVR4aJVo/oEf7NTMDVjgW4JE+?=
 =?us-ascii?Q?Zu5GYdzh3d1BTEYMk0TS2tSeFWfwnjlRGgy6GTdr5qiI4+3LVuZhITzos0Ki?=
 =?us-ascii?Q?zFCHGP1QC+JfCkEqcw/ZmcelrZNf25a9QamIe/USxtmpQm4IBVKgzPA2pEdp?=
 =?us-ascii?Q?dmZJq2I8p+hqIE44+qnhR85isKLi1qfnu2PdjovhrCzOs8rjkq6Fb0OCTexB?=
 =?us-ascii?Q?+Y0ZNYde530NZ5SsnceTCEfcB3VW69Awznq8Sq317y8nkLocfZTUQUjnBFWL?=
 =?us-ascii?Q?s4KtY57Ye0OrAyI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR05MB10011.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YINR7qnblK92l72VTYxl0PY7c7yRcb5cfgQeraJpLnLoB7sRkEJkY+X3uiUP?=
 =?us-ascii?Q?jIa83RlYgDRe737Quh3UgAyIeoFK2dbh2FRXjehyAR0q7J0gN8EjerQG7Lac?=
 =?us-ascii?Q?5hUz0Tgh/LT8Qzp7Jc9xpds09M+vRx1GA9sb69rNWvlTagsTy7NOnLLythzG?=
 =?us-ascii?Q?VQSr5X+TXwUUVO3bIsl+yOgvh493v1uHzDVcWeAXhLKdf/5WwW8lvJL1aG31?=
 =?us-ascii?Q?RrQlz91GmqEhBkEHDM3Sf3u81+L/pHXyWtfdg20eG4zTk1jQ45ZeZ1kNqWiP?=
 =?us-ascii?Q?FLzHfcILicDsC44KshGwU47eYxQbIybsruUCPRzBqFL6RdZA8mDnqXqOEkTL?=
 =?us-ascii?Q?dbJxlbd8GOf8ANOfP6QCyxCIvBfnhz4p3NahhEHY2X40u6fbIaHQHYGTnxf7?=
 =?us-ascii?Q?vnmlF2E2lgO1oY5cvr1BB7q4AaPYsfvEwIoQ8XNvJtBt+IsoksZ8i89HH/u1?=
 =?us-ascii?Q?9r2Zqd1x5XmhitOJKcGEmQF2yd6r0i5OND22C3hlEsHb1gxbx6vBbVpC24/D?=
 =?us-ascii?Q?8lKr3+Yv4Rli8C+AJsW/PGVqfWB3TP0V89PQhKV69D82wi2r9CItmugoRJ20?=
 =?us-ascii?Q?xrukHdbNb14U8AUONMjUZVrC4xVE57+Yd/aQfc/Bc/F0s6kLVoprR5V4wSmE?=
 =?us-ascii?Q?lOcXmc3IUhcWMZ5tyr4U7g5eCfUD14ZDvOGUDoxZFWdoIzIXXEFbIzFzzgsA?=
 =?us-ascii?Q?2wBURubq1A1UQMjGY6q8QrWn+SN9dW2GiW5KTRi5PvtOZpk+Vl8rNGbCj3pU?=
 =?us-ascii?Q?x8wb90uo0HqYRDEElgOvBgK4XD4UAx2YCcM3kOvv8MUJ04VVGdOyuzjacppB?=
 =?us-ascii?Q?R3MybtcT6l876Opg4eLYBxx0+xpMHUTnkGJKS/8MLRbt1iPYQLUDjJu39Ymi?=
 =?us-ascii?Q?QyI1TaflYwWSN+hd72iomTcP4c/V9X5V8eocF8SN54GUFYG7rYkc/1LUptnr?=
 =?us-ascii?Q?9EHDVwILR9qCQzyrNNDPxsUN0a/hkMlyOnzXyHPJASjqXDnKxl38k7uoGCtc?=
 =?us-ascii?Q?Uy1U3h+aPHvAxSz+pcSFMkIcZBqtvqgLMVArdQ/qsxFjlPCBU80GoOD9l0rS?=
 =?us-ascii?Q?Y1kGt4sNzm6b9JLI/ZJlh4/Zn371OXN2uCWdfFst1m4NU74tNgRw52k5mltY?=
 =?us-ascii?Q?3LJpZSaXLW+8muqMY+whe0IcA89Raof9Ork1JeUOB9lKZPiVGAKdVtCztQPV?=
 =?us-ascii?Q?mnm2SzrzNikls4NXQC7ywPivzN7E4sOoplJH0oEmD/Zckgc/OcgxX0FaeM8r?=
 =?us-ascii?Q?5fgQ1BnS/IoOym7mwNEAtQ4Zh1AwFs2Mh1PnPM1nhW3unV3ogBbXFwrtvS1/?=
 =?us-ascii?Q?qYdUAYMn64jbeYRGuSXm+g5I/VpVrYm8rDnNQSWt9TBynRP0Rl2nJUCdfOad?=
 =?us-ascii?Q?EncNHaPdMphk9kDk3u6AAh8ZZyhV/L5ASCZyZsTSxi0iKga+Xw9uRgYKdWp8?=
 =?us-ascii?Q?ZzCJyeebXpbS0irhnQ0/hCAdb3kxG6bgwfmOaQMsSISkZjUW6ci2E7yihqLY?=
 =?us-ascii?Q?vQe0PrDLKDfbh+mu9LDN1QtlJI9XcjYjDmZzbrVlmbnc1Vt1HSygmqg5hF00?=
 =?us-ascii?Q?mucj8u81XCx/WhEPCm6twuQnPiLYh1ENfi5pQz3X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: johndeere.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR05MB10011.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384da013-37b3-4a37-bb49-08ddf5f8a416
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 14:44:01.0048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 39b03722-b836-496a-85ec-850f0957ca6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0Gx9qsT17p6IivZGj1VuDmTo34sAad+FIp5ny30AQrl+43Fsm0pzWW0fuwKr5n+6skagVozj1amG42A+BbcnQnpZOpbTvmiJFskwC/l5XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7585
X-Proofpoint-ORIG-GUID: hoY_1LPxuzYAiTUruYzTTyHOhLVUNioA
X-Authority-Analysis: v=2.4 cv=ZKTXmW7b c=1 sm=1 tr=0 ts=68cac934 cx=c_pps a=fQjKmEXVym7+EbnoMZdWAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=LH76ztD93J3rOAR0M3kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: hoY_1LPxuzYAiTUruYzTTyHOhLVUNioA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE0MSBTYWx0ZWRfX1cvvh10M+ZUS ls9acdsE4Jyl/PdQ9IntU3MJfyCfYR/EMoc4VHwmy29F5G4WtCUXiDjGSiQpkaMFdnYWCuP6Yqp qzJ96RDK/1GjPsaisxcTYXgt8psDGFtmoMtCsdoeZhggyHODHwuITF9WqxXD01ncMO7w7HjrfQn
 l/Ppbxsu1ELVftnGvPlMqlO1LWcndgQgFI5FDO76mfLwqrRhrqqQXvlEgWs8UMoGQPzKypjj1Hf V9xyTpUJi81VWSvxETJGd2ydpMR1IxxtY/4FuHoHIdJ5LKBKVCB0kvmqHwuwzk0m8huvjZJjfDW y/RYIhfKUw9JdxztnitsG9Ub/RvsqnDk65WjFZ9JfArSnT9HaqgCsEVa2cX71bRJUjJy8t7M1Ju QBJuu+Ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170141

What did you do before the bug happened? (Steps to reproduce your issue)

    `git fetch origin --refetch --dry-run {commit} --depth=3D1 --filter=3Dt=
ree:0 --no-auto-gc`

What did you expect to happen? (Expected behavior)

    I expected it to fetch just the one commit object (no blobs, no trees, =
no history),
    as a means of checking whether that commit is actually known to the rem=
ote.

What happened instead? (Actual behavior)

    the .git/config file was modified, adding

    [remote "origin"]
        promisor =3D true
        partialclonefilter =3D tree:0

What's different between what you expected and what actually happened?

    I did not expect any changes to the local clone (due to the use of --dr=
y-run)

Anything else you want to add:

    Context is https://github.com/conan-io/conan/issues/18949


    trying to avoid a full-re-download in the process of checking
    whether the HEAD commit hash exists in a remote.
    The command was expected to either be a no-op success, or fail

    > fatal: remote error: upload-pack: not our ref {commit}"

[System Info]
git version:
git version 2.51.0.windows.1
cpu: x86_64
built from commit: 4d21a77b98af5cf479d8b6f863c2aa94257cd4e1
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.15.0
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26100
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e

[Enabled Hooks]

Public
