Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013079.outbound.protection.outlook.com [52.103.35.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D2800
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756676607; cv=fail; b=erWrjIuTF9nMsbClWSwvb/Fei4yiG4jNCHhJTni/FTpT/+9PBOdUKiGn1LU6dGb77qVYKGJfoPyRc2llbqSK9sny/vbMIoNxSsHrW0djTOGU2PqOjZR2fOIGrG8MpXhZkNrwRb7OQLvd65bGIDK/vg0SAzcw/pWuNA8dBbH3PQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756676607; c=relaxed/simple;
	bh=D+W3UXqPSCHjxfHYWaqkqSs1hd2Skvfr3uJblsWppPs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMv7JeRdE6XaAKjoPqsvEj4CvHt+eLWBEzdb9zU9FXErPYWjzdvJYejuxKm/yd7ZncfjIImbSgSakF2FrSN+yq0OMGQWnj6qupP1N5sDQ4/NE9r5jc87szMRJdjqcrWHkFJxSoQ1/bFNGnTuzeuBO6ldJ6+87/Pe/ljKF2c7VM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=mmauwK4+; arc=fail smtp.client-ip=52.103.35.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="mmauwK4+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yenF4OQgt6fARbzxQ4oqOE3HVS5pliC5IWPUjZcvs+XnFS9j/9CbucqPUiyQI67I/gkVejA5UDmWqUf21c4kSgOsjpGbPnkWb8tJ+HHSdsxTtNK8Pk3J74M0xKtBWWiExKTnDxYBIVcx8SL+iG8/K4JsGQfVeOFcnVLXCfQfFfJRhX9tBuGKUyE7FmFCM2ZO4iErdGBIIZIElkzQ9FBo3hVJkZzXephOWHP6rxxkHM/ZX9ARzkcJ57jUwELo3s6EMTUqodSgykTqScdEJOtFgKrwzol3RN5cosyDKcVuuTCrJSthF25tl8BdjQ2kiVUPhCAy/Q9UIoTGEtBi1ySDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+W3UXqPSCHjxfHYWaqkqSs1hd2Skvfr3uJblsWppPs=;
 b=OUU0q5Vh4vhvrFGxx9+Dh++GzrAeKbK0kPRvA8WDunDU7F57x+eGt3u15AB0jS6G+8H/n9O3+omUyM2bmF4L04jH0tvyeMhO+YD9srwcKH0h/N40wH9A7U0uh/SJ5oo1NTw6FPIV5Sgk84g7fmh8WIEOQ+35Qobr7qbKqNQ8pkRiniH3/C3ryQPhWktLWjFbDbenKimN/OR5W5RhXvg6NyDlWN21OSoedVPH7OPIIMt/45EQEeVSK2Qft7tq1g3/ltmEPTU4cjxPWFfQjatV4PvY2kH+dH9uxCCufNc/kJGuzj6FvDEvBGEIf3PCb93hyYdmqTjztST5qHlTfmvPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+W3UXqPSCHjxfHYWaqkqSs1hd2Skvfr3uJblsWppPs=;
 b=mmauwK4+XPQJWNrH6mJ2HJa4X4R8Jh/7G9NIbRGGTsIGbOnvMKrsQKFKZWBRZSebuYK4l8+nyJOkY0dmOzEYWvRSpfGBfKJjPEDlmby6xLG/K84e6B8QcnB0sNoLQs08fPVq8bckKToyZBgJHh+9en2iy6iyx3/W87eBMkjcWbt971ASXQ20EY8s/ZaalB8z1aqsIzHJvFLQ9IZGI6PbBtCpBmOpaDuRZ0WBuTJ/Ks5AOUBt7T6UxfgSCsJe/M8sq/fCRPjY/nps3eIvtpJuOOQWXsTcxyb4R8GsD/pAttCpMtqlJEsKbBeftHhhV51IhA82VPTMSdU3Dhy6lsiJeA==
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com (2603:10a6:803:82::29)
 by AS2PR02MB9488.eurprd02.prod.outlook.com (2603:10a6:20b:598::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 21:43:23 +0000
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f]) by VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f%6]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 21:43:23 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Topic: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Index: AQHcGR0afBR4UVFtH0y7jlWzQ0OEhLR6DyAsgAM/ILI=
Date: Sun, 31 Aug 2025 21:43:23 +0000
Message-ID:
 <VI1PR02MB42710CA61134BF19214F855AB304A@VI1PR02MB4271.eurprd02.prod.outlook.com>
References:
 <DB7PR02MB4265BF28A39C7BD3DB097E1CB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265499C1103242CB482B407B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265CDBD131FB755B0799B2FB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB42655790BB6E1EF589B7D173B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265DDA928244F526CF1EF4AB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265527016FB04A500FBE321B35BA@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <VI1PR02MB42713B3BBD5802512B5FC9FBB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <VI1PR02MB4271CE7B8F32225C98A2DCBEB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
In-Reply-To:
 <VI1PR02MB4271CE7B8F32225C98A2DCBEB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB4271:EE_|AS2PR02MB9488:EE_
x-ms-office365-filtering-correlation-id: 88c9fcad-da2b-4592-f511-08dde8d768f9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|19110799012|461199028|31061999003|15080799012|15030799006|440099028|3412199025|40105399003|13041999003|26104999006|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6UH6OUPIht4DRiJzn0xeWf2M8NLb0gXTXMyAlZD2pCRmeIX9hlS5JVqwUb?=
 =?iso-8859-1?Q?/vLmguRiZth4Y/PgCUQcmKulsFhEpVloxSPY55KkIEEuA2veP6McAFonwK?=
 =?iso-8859-1?Q?IroBBNA291W3S6irINLndI2HxdIyXNYzgc7t6xNvHFHSpgI7daOWkDJhrn?=
 =?iso-8859-1?Q?E+8QfXQ9QUcfNx7XOCk67oA3ijiXn15Ca5zopBSp2U4xWTFKGoklco8LoJ?=
 =?iso-8859-1?Q?8Ne8aIazSSVBt/0/lxw3AIk7Xhn5MZWqXXzATBs9s2ulyNNOFJaiLt7xVr?=
 =?iso-8859-1?Q?gZqlN8baZe6JteBR5vt258FMZZ0lTwSac5QoTlM8zHjoA1Cu9mZi/L4ZT1?=
 =?iso-8859-1?Q?Rfqc7Yce3eqrRJl7+WCXaHyf9TCZVJvxY5xMT/jkRhASzvmRTltH+FNC2z?=
 =?iso-8859-1?Q?/Nc4kU1a8kKIDVVGu4yxykbIO/aD96Mlg7/1dfaj5w0bKZqVL8WTTuvDFE?=
 =?iso-8859-1?Q?S7voUjd+MQzY7CVz3g9nVjNM+Gd7llWJc6YZ9hv19jOkzOH4rJkFI0OZpK?=
 =?iso-8859-1?Q?JeohDMmMYr4LWM2n9AHfVLM011kDTIgVnuJqMg8W83z2/IsiSVkfo2kH/o?=
 =?iso-8859-1?Q?sVKurF9w5d3E5umOBqTPcUJmDCzWGOtGdlgq0e79ftmxX89ZM79msCEl1t?=
 =?iso-8859-1?Q?OPQ61PA+twbF37lZbkm6OF0/JJtj24QNxyWQ9W/uwhAeIVNM45YjOERYIN?=
 =?iso-8859-1?Q?GHyKNjR7un3/8mBe0ub7f4Asn4OAyyUeQ4paKAsaFc08irdUVe99MUbzhu?=
 =?iso-8859-1?Q?g9d7iyvSx67rcGTTiXwe0LW6/bg4EbkrhNXrx8f/ZQV9MeaNbiK8D46y3o?=
 =?iso-8859-1?Q?JZ3H3xtV4Yx6WV6XUoWl94V5TnhBugHGGoNPER9tTIRjev0DjpWKLfTCeO?=
 =?iso-8859-1?Q?GTqrt9WvTJmm8u6RKISEcF4udumE/DjL/9kD2rpJvSw12vym7sTlCZcejX?=
 =?iso-8859-1?Q?TF9Y651lNOanmK0dLeVqFRJG5lyYuU+ygj32ElQZI9AfY3MSq+egGxNQk7?=
 =?iso-8859-1?Q?Nxorb3qrHdLWdeLWWS6eB/3toKQHHUoNgNUGKonZEGgcZqhl6ujDP+1QPI?=
 =?iso-8859-1?Q?SFei1S2VzZGGprOzEVUVnT3P+xastSDsLckszo1YWyPQjd4hTzBDIRzPIw?=
 =?iso-8859-1?Q?m4tVpWIc52TbMfHAOuqtwJBcrLpYotrLwpWuTMNzlNqHRBWDFC15FS5enX?=
 =?iso-8859-1?Q?plfpfDQ1zETeBiDK+28a46pI8qy6QZLlhXqYuMuIt2HLuxsDVwldH517Hw?=
 =?iso-8859-1?Q?zXKqP8w2gVuXRAUKlCmw91Tq9yDq/cWskX6je0N94O/XZW2rqBxJISvAWz?=
 =?iso-8859-1?Q?H9c0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?B7G63hYv4nclfcvRgc/g1bZv84dduWV++IGXUkcDIEMt2iAv2OSq1ZBbUF?=
 =?iso-8859-1?Q?suinDGCZ1+/+OXtMCIA1/juXxA2xbfbbF9xOAXgr9q5qeF8nYRgSlQTZog?=
 =?iso-8859-1?Q?0/vemnZs7MzhHzW8jXTrzF4GAqNEOll4++DtqiDNgtg5iE7UpJvrKmakhj?=
 =?iso-8859-1?Q?kPJXTmUq0UeByVteyeDkRPoazeUvFhfVqI/RZFmqAlqch+t2Y+KSM43wez?=
 =?iso-8859-1?Q?bRl1qa5vp9rPZLwdjRWi4rkMSssMIrCnSNTKjVOZYPEyV2n+8ONREwe1yg?=
 =?iso-8859-1?Q?NAuKM+neniDcUcpSgG63ygIC1MAd3vcws8Glua/kuwjTF/8Fpu5XXeLCaL?=
 =?iso-8859-1?Q?IjXJ0i2Qo38H24eOLqloXo/IicDNut1B13sPuMynEuI1dWs7Vl8XndpBMb?=
 =?iso-8859-1?Q?eLGXmSB9jfzcjk02fLE/Hx2jUvm8MpcHLgdSWvCFx+/gQSJ9LFQSHeauMx?=
 =?iso-8859-1?Q?+RotcRc7czlfcvASB/GtWtC97bR3lvEF8dKOftQ2f/to+ySimz9BEQ28VN?=
 =?iso-8859-1?Q?DkoiATZSsC4FgZNMdWW8+S9RD1eDceQBJ1eZIKQCIxLyP1Qi5mbASKdMis?=
 =?iso-8859-1?Q?o+YUjU3gjw0mwG0YmeDrpy74e2PhNEn8O2aE+vM49f7zlZJZq7E/oTJg2y?=
 =?iso-8859-1?Q?2u0qZvgp/e3hW/VVWqO04WTu/N14tXRIF+iY7Rcvb+LhFaZfJu9Svjrk0B?=
 =?iso-8859-1?Q?pB11rJ1PN0RJxFBpwJaBXyl3qTz6rZHk98ZpKNCvsS6B9EZ8RWi8BWnEu4?=
 =?iso-8859-1?Q?c5zizZq5UqttI0XJSe0eyfkjzjuYquxL4aAqkj30FT1jeqQSZl5VfO4lo2?=
 =?iso-8859-1?Q?MjlpPb8JnTrpp2JBQz1hXHsOdehgIzVWxAqsG0dVELpN63xQlC7Rn2WgxY?=
 =?iso-8859-1?Q?zp4Z6ciymT5JKS4AAJghO/c6Xy/2iimSIluNTV7VsJMObYXciNfwKSqYol?=
 =?iso-8859-1?Q?JhMGAiLfVxKAw3HPPQDwi6IlC4JPPeXc9Z9a9y44tKzL66SjQH41mMl5Zu?=
 =?iso-8859-1?Q?vCZ5gU+Jad+ObLlyLduooevmTrl6zGOpAAcLHd7NcsWzGfzftXvpIcTWQi?=
 =?iso-8859-1?Q?WD8qNJ6qM3rU+Taq+VhDifetN0JFsDDrrxNMoDF8/TVZ8wEkr770GDic54?=
 =?iso-8859-1?Q?lvUNlumd0qfgQOCQeojrPD4y5go9yuxdnjJCXmgS4l2fy1iK0akf3ltlGQ?=
 =?iso-8859-1?Q?H1WJ4uol7nuPJa6oz+w0YfACVG4vLXWgMZVhVfjlApihRJK0IrIV86E/OA?=
 =?iso-8859-1?Q?P/WywPx5vBtCqfVecSVFgQCLbhqyXpejrAxJ9hzMyQ2lzUCmpdJQXvvm2s?=
 =?iso-8859-1?Q?JVCgl6fC8RP4vGG68jPZBiOutHmq9b1Klpb2b6ALvf8vNKo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c9fcad-da2b-4592-f511-08dde8d768f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2025 21:43:23.3144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9488

Little bug fix is possible:=0A=
=0A=
Copy & Paste the procedure GetNextContributionNumber from git-new-contribut=
ion.dpr to git-back-to.dpr to make git-base-to use a correctly incremented =
contribution number.=0A=
=0A=
Bye for now,=0A=
=A0 Skybuck.=
