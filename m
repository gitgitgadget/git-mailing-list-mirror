Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013087.outbound.protection.outlook.com [52.103.35.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF0635
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679008; cv=fail; b=oQQnp/yEVEgAY4Hs2VMe1Y8Eb7GhmDHKnnTmSz3pMdWJMPrU2RheomqblcUVRtaR7QwYRwa9yilPkKVu/FbJJdvNpuacsGk91VkGyf/2nvALk+ezcMrudAA8q81O+T6/oZZwAanazsKNIWqYdkvExYiYH73KIGNPE7G4MGSVXjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679008; c=relaxed/simple;
	bh=gLlvXH7cGXZJcjNj673WuZTSqNI3XUqkfi3BAGHE8jI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fi4k/WMGHHInRkbc+dUDtkJuZm4Zj7I4aGIRhSBR+eODlb7SAOnFO3xWhZ5o+2nXnCHGmBbp89NeWLVuNtKL5QDxSkdRZLS9bm5o7oYmZAsfH1E7Uj1ehzPA33D1ofOjz75SiIl93g+Q2Y822sMl/cyrIFOJPGUbrIzTbzl+Ank=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gWhvDodG; arc=fail smtp.client-ip=52.103.35.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gWhvDodG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiY9HT22muQEVBbZjB7iJKk4Chvxjhp+249XPS3MVlwK3QW3r3LjDMmLxIorAvOd9BjEq1MliYtKW6a0IxZowdteBA9o0oTtxDp4QpkKd9xm7g+XUNAjxQ/PX0GRLNdX7vMkGOMojIh/MwhnwPCLrE0PkSLqkf2WxAF/ZlyD01PI90yAbWTgFITGzeXFMnzUozjnVbqZoLp3bhprPNNGp1/s2Mpea1h7fnlLf5tNOlcrq4zYT4yKyEtNs3OChpf2GozzIvwRKHsJBZbzakS2f7ynVPaMqGDaqzNwdNegwSC99Y+cTb4x8fXziVtt2hAcX+nf6cd7jkX3W+7268/rYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO4G3Lw+/2oH9sJIj1BSc9PBfQqNJ0UY1hwh4bJqN3A=;
 b=YptjK6xDovqmBmdsL1N0tigYXAM4GwNJutQ1CRbi4ZU0CDET/5+cMOXGDEWjrrn1hqX3P4qRcO42HypbYTvXRFF2MeMis6VDeIXlxUcbD9JU4eg9mrl5OiTLeopivosZw9+Sel17HJlruP5eeS6/oVpIpkALS2sWnK9U3h7LXOcc93GmSzE1TSKEa+qZGo4iS5RyQ7/kvzjmPeiLbpnKWP3NhHyl0gHI0bsKTBcLnf1e2RjNpb/FAO+RgCQvNXY2tnNrDdEGN2x1pqDcD26iiuq7or0zuo6504udZ/0e4A4kPdB0iyPq99/tMJeqJA7xyOBgqBwCs1GqxIYz+JNo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO4G3Lw+/2oH9sJIj1BSc9PBfQqNJ0UY1hwh4bJqN3A=;
 b=gWhvDodGRlWxn/O1oi7x7gIwCorvaVXhCqwN4hQITk7ny6H5l4FggXPrUVf8+zUYqeNDaFeWj1zRBJWH+g/Tg/ir/jPoniNPHjYRMChjrfsolC72f/LMnX1v34JVulxi1u1nFSb9jxji2yFwERRY5XuUpnspkU7j0yQ1csXmD0jCKlMRq2pgA95Mug2z7T4GIBGC7WRTJgn6aEnXOlFKjElPG4n1JG5m8VmNdDB2JDCqGqLpnfb4H1l0RYXsg+Q2u7/l8l4JrfVoIP0bHNgxdaG4He+2f+ebh4J990q5dP6iE1/9fpjObR6GWUPSev/ml73asAubbmyWnMz2u6TKnA==
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com (2603:10a6:803:82::29)
 by GV4PR02MB11443.eurprd02.prod.outlook.com (2603:10a6:150:298::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 22:23:23 +0000
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f]) by VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f%6]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 22:23:23 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Topic: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Index: AQHcGR0afBR4UVFtH0y7jlWzQ0OEhLR6DyAsgAM/ILKAAAsx7g==
Date: Sun, 31 Aug 2025 22:23:23 +0000
Message-ID:
 <VI1PR02MB42719712F08357E634920D33B304A@VI1PR02MB4271.eurprd02.prod.outlook.com>
References:
 <DB7PR02MB4265BF28A39C7BD3DB097E1CB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265499C1103242CB482B407B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265CDBD131FB755B0799B2FB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB42655790BB6E1EF589B7D173B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265DDA928244F526CF1EF4AB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265527016FB04A500FBE321B35BA@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <VI1PR02MB42713B3BBD5802512B5FC9FBB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <VI1PR02MB4271CE7B8F32225C98A2DCBEB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <VI1PR02MB42710CA61134BF19214F855AB304A@VI1PR02MB4271.eurprd02.prod.outlook.com>
In-Reply-To:
 <VI1PR02MB42710CA61134BF19214F855AB304A@VI1PR02MB4271.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB4271:EE_|GV4PR02MB11443:EE_
x-ms-office365-filtering-correlation-id: af18c61e-b237-4035-0f03-08dde8dcff66
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|31061999003|461199028|15030799006|15080799012|8060799015|8062599012|1602099012|13041999003|4302099013|40105399003|440099028|3412199025|10035399007|102099032|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?phvZ8oiR7hlkpg3aQ/XCc1a8E1nEQ6ktZO64ZCUDPPDCD1YnfqfEuRaskn?=
 =?iso-8859-1?Q?dOaOTQnBH1dKkpOCSwWFUaRcxGZsy4vb0Y+1/ZuJdGkmL2LGOm45jx539Y?=
 =?iso-8859-1?Q?ZK6nTDIIbRPeZDtSkRMFOsjr07I6ERj6H8knl+AXllm2coXQJyS2mFX0nu?=
 =?iso-8859-1?Q?1jR1t2zFUNPt/3agFPgvB1AXjRlWeXCJi2BJ35Nkpm0O0bRlInE31pPoah?=
 =?iso-8859-1?Q?ZEVYTAWhhAE1mtQmqNEzwtWW5SeXkRRdBPCFCPcPQAHRMgSP0cVRJ3Ut4M?=
 =?iso-8859-1?Q?vURp3jfkpCepCGHP2JdW2XIJ36445i5ktf8EV2EszNrF5pjbc335uCXpjn?=
 =?iso-8859-1?Q?D97a7+V8nUVF1naw7uxKI05s1LiYosqE4WtDrBgjgfmRNDp0e3+khOFjp5?=
 =?iso-8859-1?Q?ysk/7b2K/N/pHEgaU+RwMbacd957uxvphmJtvu9O7AfV5W0qD+fCen9MsN?=
 =?iso-8859-1?Q?jjBLk+1NBK/2JtwViTd2eutwtKGXt54Ue+FPxDmSf1BwBJrX3e2XQBXeQ7?=
 =?iso-8859-1?Q?blGPeWJcXzarj3thgLsmC6qQ725nGNlmPaYjtj9ACXUUges2MorPVXzEse?=
 =?iso-8859-1?Q?Yt3Pa7mDmjc5+rO1sQDYgfFqvUacEw2LR5gXBB5rkuO0BxeevZNNRW7UeY?=
 =?iso-8859-1?Q?tm5yO8di+xAvQQ4yUN483b/aqXQtsc+sPOh7zcmAmPhuJ3v0qEL89q+znn?=
 =?iso-8859-1?Q?1TSmFRPgZh7ZFIpIYGa0F4RZKnmGvTCI7ixoXIWyGThvbA5rK18I7SDFrU?=
 =?iso-8859-1?Q?nrQaS8+bkWAJZEqMw945YYT8RIsS5EXM+kgUBW13r525a+fqUqTigP7csk?=
 =?iso-8859-1?Q?8YtNAaxdSycHCU+Yxrluk88gGVgw0I+6sja4s/H3bHTQ3n1KXgZT3V0WLW?=
 =?iso-8859-1?Q?OBeLtCYTGmDZiCd3HctpbUhdyQDON48G1VADidWEK3ly0RRX5+N2GhDcvI?=
 =?iso-8859-1?Q?+bEHIGATVozPF9lmr9BqysKy3W0QUVZ2Je1iw0DMlBQ/dN+if/ylgSKx3e?=
 =?iso-8859-1?Q?de8OS2NLOANd5rfw1r5gIeGCZcIhGL20uTOtJ0gw+zyjWNSpIMoelgyeqt?=
 =?iso-8859-1?Q?4UMuS0vZaany+LMr8VPzeqOcykRfwQ/lCQ6qINqke9RScuETWMfkpzuKbw?=
 =?iso-8859-1?Q?0P3S2ZjQ8ccGjN76UWHuYN+RJ9h7yMofniijj73wXxe480eJhA9sIrXZUB?=
 =?iso-8859-1?Q?YVdfYPp1wMZ2i4IOtjseUGHm3t8oz7jnE+A57KV6/5v9fGMgpHM5xe6+Wb?=
 =?iso-8859-1?Q?1kTPKjYuCWyd1xCR/RLe2oKbxy5z6aIYQhb/ipJm5yuuyCloUZPkZ2xGLn?=
 =?iso-8859-1?Q?ZdqyORd7Ok41pn7NLM7FzNqI2eGqOzrTJ+moQ/RJPmsoiqgKrdpsTOJuJV?=
 =?iso-8859-1?Q?LifXT0c9QV821VxXApo+mcOr4RYOizIjCadtHYA5HWb9KRzAnoorI24hJy?=
 =?iso-8859-1?Q?mNpsfkUKEJzWRlbd?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oMJ7EO2zZ2zR9WBsv2T6ge6VTX+76e2+Ij7AxmJmB9rms2zn0zmhS0sXcp?=
 =?iso-8859-1?Q?YIxr2KG23L3hJpBBtOi8LJuOEBFoiVA0rcp4sBvzAig6ALH0tAYoP+psFf?=
 =?iso-8859-1?Q?0lulVNbm1t+K8683K1YWO1K5KfWCKTncr1VY0Ih+e3iG2WGGRV/i+ZB28m?=
 =?iso-8859-1?Q?PTPnG9KgEBWiMfIl/E59lM1J0fBBOuzooc0QkvrO5ux6sa/yEAcwSWOXbk?=
 =?iso-8859-1?Q?gH/JPTWvikawqk5E0eRbzvOm3lQiMvgcUEHb4SDB0X4kCxiFGLpbpVQVgy?=
 =?iso-8859-1?Q?aFuKr5HZl6Sn7A6D7HoBhs97rpCH5MvMqGxBn+EkuGsMuoobIfvF0m9ULK?=
 =?iso-8859-1?Q?TGAAlQZ7rSqU3kvoYyIa4GLh4CE+TRso0BLF6GSQciWWyp8pz610+LQkW3?=
 =?iso-8859-1?Q?pxDGU1bjgIbx5FRg2ng7VGyzxlfIpORuzs3xnV2EixCnNbnJiIVOihjuTa?=
 =?iso-8859-1?Q?lmgQRiMrqtiCJq04C+yeDA4gKoGCBXvTtPJ5gfIMas8xr9N2UWYIMAXXJs?=
 =?iso-8859-1?Q?3xI1s+GfPJsj7QW/NV4gdf1ir1hq1utvzsY+yFCRpV8iBB4RIfN/MD8Zux?=
 =?iso-8859-1?Q?O2okzSBf1UT7rJEpNQ+u3oWyJHg513JQ1B4JOsG7Ju/3N6sN6Yr69dqbaO?=
 =?iso-8859-1?Q?ACWEBrzHOzCOULy9Z03GyfoePjFqAsZZItouv3pYVESsiSxfLGPLwNkOeU?=
 =?iso-8859-1?Q?1Ih0ltvc5kLcKOa4qQw+v7HS52CKveQciJOZQG+kelh3Y6AlY3XhdOH4D4?=
 =?iso-8859-1?Q?XgvSYnM+S1SLKpK1CY7KQFVcy2OSHUj3x5paoqQ2CQJV/QBr1u1nUzfcbh?=
 =?iso-8859-1?Q?8Bq44mSpNibOzGcKWr5qyQick1XUJ/dnC8o79svH2RE89gJq36HVj/J7ow?=
 =?iso-8859-1?Q?Volz81/Q3DE/7XjysvNAr5/yIjKWb3O9HP7Q4M/SQJyXtJuWd7B4bWdjye?=
 =?iso-8859-1?Q?M9emZ4e97yZ9kfr6xxj5X9O3nFJ5vXmrwc/HoG65DNmarMvIZDKl1+BNd1?=
 =?iso-8859-1?Q?i5io0tnSOskRqBUAAsCZQop4zU5eAT2mg6/t5u7yt/sNk4s7QyjdkZvDwO?=
 =?iso-8859-1?Q?kxGmYSkGtMLcADYfJeEnYGfRnSGN7lQXMiHy24LbAKUtKLwhMk0A5xe60u?=
 =?iso-8859-1?Q?AejJJn69gDKAa7Ir9mV8ccOyJyc9gIqrpehxMw4rO6mBb66N0au0fvrC4M?=
 =?iso-8859-1?Q?9zGfOZ6ExjtkizMGsFyQmHvVzFlHWPqZM7Ktjh+Gt6lSHIB9Gdx8KuV08A?=
 =?iso-8859-1?Q?Xr3O+4FbAfETAUlv4Iug3NUOc+doGD1nLWsMikcLz6iddeavLT8pIpCjo0?=
 =?iso-8859-1?Q?1ILmnFAoZsvjemIWugLYjfEtgAjEmi8ekLg+C7/qd2/1MQY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af18c61e-b237-4035-0f03-08dde8dcff66
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2025 22:23:23.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR02MB11443

GitHub repo created to make it a little bit easier to get the source code a=
nd also some win32 binaries:=0A=
=0A=
https://github.com/SkybuckFlying/Skybuck-s-Gitflow=0A=
=0A=
It also contains some Skybuck's Gitflow v4 text and same text in README.md =
updated to use git-command-etc.exe so AI can understand it better.=0A=
=0A=
Bye for now,=0A=
  Skybuck.=0A=
