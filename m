Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010004.outbound.protection.outlook.com [52.103.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D5266576
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933236; cv=fail; b=EP0dNi7SySpRiL2YQnxgbHhXvEYKI7Rf7/zhpeA2KwDTRj4bO9eUpZxIlVWiV7TpE6SjULN4BMLl3gdHPjsU04VJL8niK7JXiUtMPkI1tCV6u+iSi5S38dmvTn0V4S2EK7OYp6WhMtQit418Cv0KsbAllNz8nZEZAKLL1P+j7M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933236; c=relaxed/simple;
	bh=BITBx7MDNUrGd/54LEVfYGRx6QBozVRn9coY3vXDNpg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BXNZXkhQR0tUwM0yOXVjGhofCe1Ow+NdfvvA+ZTtGaQfMEZKR1EtD3AYJUb13D+zCtNOPofEnH9E1DmZvoSHJIbOxt7f/1PMPZOJGecBx12EjFazWiDSTJDscPecP0KZ6k7eO7E7nLwT53flUlknt5R+36PuScxwDy9hS9d/pqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=jz9NgLmw; arc=fail smtp.client-ip=52.103.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="jz9NgLmw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ1z34Y6Y7PmV/cjaEboYZbLjpYlfDt6VyZUpsN4jHw3U8PXvFzdmw5J84mkf+qFF5FAo/yYO1n2RkJLT65K6z3QuQ+MT1kTlklqkpWP0H7S/nt+tawcqWgRExqaM2zuMjEpi5uaIwquCTAbL/J6sd3PugTmICW1d1zP+XNMG09/pNQPrF8DcLBb9IiXs42tQSPF/gSmFRjhP43YLqL3wQXP6ikfxgMr29iaFO/1VcXwQFWME5kaRHHQocFvR8vYQp+lLsS1B4T2z+KI/yTitV/+qLLbg0dtYctiNiFDZUBSXKJalqCG7gSKSbidkGP2g8rB11zgzFplEg/b8uXm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BITBx7MDNUrGd/54LEVfYGRx6QBozVRn9coY3vXDNpg=;
 b=RaPWROdBxOt5ailA60158drFZREboHWzwMJK7jdzpttFkTMpvqOV5Qmdv7Xg7n4LRQH2/PGwQ1zKoH9jVTHgH+JCRdN1p5dr0PLBFPaCB0We6uGCroAXfJ4d5z1bDc4cEVvL1EDAlQ9uugm7sqJfMW0PXNmDmVIQ+c4VCWEiQx3vdSp+3T4A8n6Nkeiy6blloDtkdw9CNwUsAeFtJmvx9aqMZJfu96aZvi26fyID07t7+R9THdtQAyF72djYEb0AAeXnhknADQN7bgzbsQjavQpPkL1Yp246Q5gQKcvrbIovTcGc30bYhr1FsO5omTXSgUanmbZ6iigsqULYRQAFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BITBx7MDNUrGd/54LEVfYGRx6QBozVRn9coY3vXDNpg=;
 b=jz9NgLmwKgneovNJh0RIjzAwEeGdJbxaiCBtdlKEB7bHJ2mbJ+2Q7BX/7034B8VYhaNZU1Xvje9NpoOcVSklzHNCDrd9AF3dzD1pBSGolqKS5Y1T4qZQfZtwdgY03vg9i9/tAH/7OXjDT7X1W5r9+rmCW6YBcfiZ8R3EN9ZayVcVHJVtLPQ7sssDEHEmEYkhYWqfFPs+wteGBFDG/0UiKLz+huoUtb46dD8vvL2s35oxOmgxmkRG2IaIeFyFSUCnB0EivAdZ04cb2WeXPX3LjEv8XIp086Nds2KhZOa3Ex8QAmkxLOOC/oe05VA6WBYy0jnb8NUkP3eu5+d4feJqwA==
Received: from GV2P251MB0993.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:ad::10)
 by GVXP251MB1056.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Wed, 8 Oct
 2025 14:20:32 +0000
Received: from GV2P251MB0993.EURP251.PROD.OUTLOOK.COM
 ([fe80::f112:6ee9:60e8:fccc]) by GV2P251MB0993.EURP251.PROD.OUTLOOK.COM
 ([fe80::f112:6ee9:60e8:fccc%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 14:20:32 +0000
From: Filippo Falezza <filippo.falezza@outlook.it>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git whatchanged
Thread-Topic: Git whatchanged
Thread-Index: AQHcOF60wonNQB0LJkyJnzmJvoK+/w==
Date: Wed, 8 Oct 2025 14:20:32 +0000
Message-ID:
 <GV2P251MB09937AD11689D3148CD342D8F8E1A@GV2P251MB0993.EURP251.PROD.OUTLOOK.COM>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P251MB0993:EE_|GVXP251MB1056:EE_
x-ms-office365-filtering-correlation-id: e30fdb3e-17df-4f3d-9d4f-08de0675d717
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|15030799006|19110799012|8060799015|31061999003|8062599012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qQl+TDZBonJW5M5PtPJa9toLufgkts6xjtf3o+YFIPl1UVPd4ZyWectAdN?=
 =?iso-8859-1?Q?lMLR3gRpzUGW9AXG1XQ/bFSPQl5SMf1VLKkYud9bIa1huW1c0hfZ1WHpb4?=
 =?iso-8859-1?Q?Jls8Zr24HI5k9JBVZuMg6yBsphkKaSyli+ouvHZcJ5uoHn88LdfAgiRAE4?=
 =?iso-8859-1?Q?lW2JU+oUNP2TrJ7ok+5U4LMUDzW2dVY07isHA3BsR7dTPY1/r3n+orqwaJ?=
 =?iso-8859-1?Q?3y2EjYa5ZyzVX4wYifB4DLdIoDRZgoEhMdbNVCihA1qEwV4RGZBFy/rEsQ?=
 =?iso-8859-1?Q?koox93z09DRd3GUYBKqqh6JkipJCSl/irtsl1LSeUgRFG2gukclkx+t0FI?=
 =?iso-8859-1?Q?As8D/QTCVjegw6kP7tqBdKeV+R+oEQv/CUsQA/TnoxrgAQuIu0M+plTnui?=
 =?iso-8859-1?Q?vMxBs0KDne9W51nbXGC8tMjTUiyQlMOg/rFUKbGDFA1+ziZrS5Vk0nFF9f?=
 =?iso-8859-1?Q?epaJZEalPPXlja6kqJVaTGR3m+RdBpjWTZCPTCbYhysKa4ZrcuHHEEPTll?=
 =?iso-8859-1?Q?GaxNrZDfxFYz9hHNuEI4RgdZCsKRhSzVvFujz+MIw0vULc3OB0UGijfNWQ?=
 =?iso-8859-1?Q?gfICjfuhSkZE9l36n2PJJAuM2WE26oTlYnWX2ehm+CXBTBGIS8aH4wYGg1?=
 =?iso-8859-1?Q?8Em7hRoLOqlYfwP3BD3nqfo8bRCJcdkOCmQ6MmA7WmsG6AFGKaRroZD+/p?=
 =?iso-8859-1?Q?1rDwU1fihb6pD+ujJiO6jghgO2GVzp9z8affgC97re8e7R+Zh49d/bbfq+?=
 =?iso-8859-1?Q?pux8MkvKPdvZuHy5Xwb5ilaQOM6QYrhTsAYgeX8GOcVoJVU/kkEQXWWhr1?=
 =?iso-8859-1?Q?zDdWJ62PkBKLbKhTz4jsxjBMffzJiy40nF8f3Cay5gCziyS82+wdNCp8xW?=
 =?iso-8859-1?Q?6OzAQCIc3kHLDujQBe3wEkUmdRhHj0rxLNEf+Vgt6UXIefDWPiakXF4otj?=
 =?iso-8859-1?Q?8uaIeV6ZGO8hYUCqpwijEzNG5qRGGh8F8Ux8PFaCJ8Ku6/GkkMe5PvWyc/?=
 =?iso-8859-1?Q?fxv7T4CO2nEOETLcoOEj73ZO4KfvQAh04nwfKzYpsqriYr85/JMJH1vAQf?=
 =?iso-8859-1?Q?VXbkvkS5hUutSPSvbLlWkGddwf2c7FAilQnQPJanUfq/qJuRrga3n9xYyz?=
 =?iso-8859-1?Q?9hxklEd7Kbc3UA8Jo6D9+HWHJDqfG8bXToD3YNAyfwMDRO7U/+Pemgs+qh?=
 =?iso-8859-1?Q?k56tUxl7sqQ2F42+Z0j5SkPMfUXDdAYXcCo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zsF2ddasKulG5Nm3jeiLbjadR7OzK8FkqWmxySgYs8EoeCJABW4EAaH+dp?=
 =?iso-8859-1?Q?Xr8r2oSJWX0u5nGSWTjfhr2lMI9Mn0CW4FRFzTpa9+qn96CZ67NvrakhzX?=
 =?iso-8859-1?Q?CKvHTP0xiLYWZGjAbB4JwfY0CcLQilana4zMi4Fqa7g9SAOmFrSOGttel2?=
 =?iso-8859-1?Q?MLkWL/RzICcnxVSGgE+iBw30aZWTb5bGheqZW/HN2TXOlpqzU7WV1KAMCE?=
 =?iso-8859-1?Q?EoB63n/XRKphZBp7NbD4E1OgfiuQE/A38wE5zRE/quErB+Tgn3jFEY15//?=
 =?iso-8859-1?Q?mxf2nZTsMekKXzV6FgHIzMF1iCn0/iQhhjykdD2lyZDt+7D66uODlsu5Aw?=
 =?iso-8859-1?Q?qwuNc1ykNmH+BPmUlRFW0R8LQbMTC0LTjMEboQGN92ImZxrBcsUYCHOA2B?=
 =?iso-8859-1?Q?65L25vWXfVBL0VJFLkHMFpCRZiVIrTZrcR18g+dM9dEiJZTuRy3X5Zuq7q?=
 =?iso-8859-1?Q?eGXUSML6rp791c5CRMZquBuIFg0aTFvUw5GHimw7kI+wiOedzrae5NrzT3?=
 =?iso-8859-1?Q?Hap5ayn4EPxnaZNhmwjvxUpELbEKTacvc9/TpWymRrQCerP01exbDoqm/m?=
 =?iso-8859-1?Q?jZUenfTMttwUaWS3ClDTFxnizJzq1zn8xnaYZmlesrjmGyaHJwrezmcEZu?=
 =?iso-8859-1?Q?31RC9xz5W2r/mITcS56MSlk2kZ+/gmYN/pOWOJi0e4RwRPAMMwfyJbM2t9?=
 =?iso-8859-1?Q?0P1bMoYgDtGSomAmHdbtqh+WQtGz8TO0Y7SL569pxQw7uBZrVV6B4NMVWC?=
 =?iso-8859-1?Q?ugKKtIhjvlBnTJjvOqypMYe4OTS+EoY8qF3cLcaBr/TCHCVtcwozLVBhfX?=
 =?iso-8859-1?Q?MpvWbPg7KNuM47w1UYWHheSLNuv2R1YziTmWpPYCLjaXzFbOPtb+smNBYx?=
 =?iso-8859-1?Q?AvBId3h9nBtiCXJIiFAZ7o+WituKti7C72dVulq65ZxOZTQron0TtwbVrc?=
 =?iso-8859-1?Q?JjPt3iyF/HU0Jb76xP5qSFeyH1yNoWzllfVDcDmfGbP9P40vOCH8Un+AHw?=
 =?iso-8859-1?Q?Kmaauh8pDkppPXiPA9xTbxfXW7YijS9i13tfmLUblwCXfD+oZ0sUX0Ipow?=
 =?iso-8859-1?Q?qkqzXeuXwUzDaofFrz/zFSAYAXrlAc2QU5A7yIhFiTfYTPM8C4xkr0j9zZ?=
 =?iso-8859-1?Q?dZ9Gjgd3UEyietihZOC+BdwPBwv3LkZ2SiTEQchSyVBguu76pvpRC0tDam?=
 =?iso-8859-1?Q?9jgpxAAYlSLRq56zRIDWUGiVL9Gx4zOJooiwkjbAsav9IrcF25M6PeJ7X0?=
 =?iso-8859-1?Q?ooopn1Gvtcm/LAb+dI3nuYD2tCf2NpIwlcsZfq7y8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-31-msonline-outlook-8f663.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P251MB0993.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e30fdb3e-17df-4f3d-9d4f-08de0675d717
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 14:20:32.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP251MB1056

To whom it may concern,=0A=
=0A=
I am reaching out as I am still using the whatchanged option in git, which =
is very useful for my coding and handling merges.=0A=
Please keep this option and do not break userspace.=0A=
=0A=
Thank you=0A=
kind regards=0A=
=0A=
____________=0A=
Filippo Falezza=0A=
