Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013081.outbound.protection.outlook.com [52.103.46.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127971D31B9
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390230; cv=fail; b=OTFHo/LRWMDjbkMZsY1wyQjbR1ZAPv52FBRDdCskTHXmQMMfF6rJA/W1CBBK7YgCGdkZOL+rpZdMuWTnURgIcNVQTgIC0eVIOB2+20W4tlzseSUtryx8Lddyz/QaWneTGp+3dvEfL7pJDqGHI0rMR8UWDeluHnuCXnTG3ZH6UPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390230; c=relaxed/simple;
	bh=KxbVGYF9P5EuIqT5DhYwXxssgvDW9SUqe3lDmKXrglk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LWOFeghYrvMoSZx4xaMXCGjz8VL5NzCCYjlGhdz8LQ0DWnWBxH72yd4/zhlDbZ/H9VuZCO560pMpBa37bE4LeiuvTlqCitUjMEH2KEPeKYfspl5MAoVtYDcXgh3nhzDyv8ST5EBXJHBLtZIiAc5lPmHRZC74pNYPkPneofFEI+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=G45nwRzW; arc=fail smtp.client-ip=52.103.46.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="G45nwRzW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJdGoVaTfnHOSvPmuVkvMt+NzSfAx8q24hZXXYq/4dAaw2Dxu9AtDEgKzymUIO34qXZdVmXvNISJAT9iQUpWuBxe9X+/dg07QsQkwXC7pEDM7Y0xMQFju5xpo0FcROrqOanOlPdSYxIRL59EP1TvZ77Sh5F+6/wINsKtpfRERBj/S3lxHmcq8DiaMb+jBmXfPnAHnRbDeuJrenKQ3E0d2MNh9FXPFW/OEnHRa7g9VXpbV3G+qx0APSsGoRayfsoiPqUez8oGYgTjQlUUtvWa4gRxKE+zu9s32KdTtljZSTderSo574U/xk0lIzE8cLxgQ+2Uf370wAATjw1vD9H9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxbVGYF9P5EuIqT5DhYwXxssgvDW9SUqe3lDmKXrglk=;
 b=FAsgE+nOXzR42l+0zZHb0BJv23sySYi+8Jb+C4j/6YFL08EmOW2Q8R16fsQbgGMDDBAQwniwrDkbR7RdesTwWCu5LSirLAPqa4pf+rKD8oj7yoh6zsYrH+dLhtjj0KNInjXESEAbRtHyj9bFrUnMqHIakHfmeeSH+W8caHKARiBiHyy1J1uV2lRkcUFf3Yl7q6iE1kmgTYglFtl12m6r7gjDGiO7eEayphzQBkpzEuLk1lCT9xJrdWCKfJaxjfUqSuJxBSxoZRTefbEvrza8OSeqgWq+DsN6nuLu02xCxRtkzkpTao5ocdXHbqAWN6A8O/keIdo8B6hbXqC/saHWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxbVGYF9P5EuIqT5DhYwXxssgvDW9SUqe3lDmKXrglk=;
 b=G45nwRzWaJdmLNrNvI77jN81QGW81X9C/RXwU3+hUCXcnAg5n871HWUrRqhYbHycF+iA3w4iLGEqh1nFvCwWiQvpb+4Gz4GZVYq7rZUnL0+KcvINAK7eGbLd+67Hz2cA6bNSWCRiy2FqxPsdQWf5XAVUiuIvIsVx3MMPjcMRTHa+06dcMogMD31ktxNAz19dztJlU6ufa/LBP5ECraxahz3HV8X05Ny23xMJEU9bBwMDSpo+T27ygl9aTRR6R4NiCjVp2KEPclD2HQltrFOvYFmHNAf5SfqKaJEpR1qVt1meHGPz9tK2g0rybBD/w6uKZOkQKyjc9XHZ8kBfAQwetg==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by AS5PR02MB11367.eurprd02.prod.outlook.com (2603:10a6:20b:6c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 14:37:01 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 14:37:01 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Topic: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Index: AQHcGR0afBR4UVFtH0y7jlWzQ0OEhLR6DyAsgAM/ILKAAAsx7oB6ESxrgAACJ1s=
Date: Mon, 17 Nov 2025 14:37:01 +0000
Message-ID:
 <AM0PR02MB44504D0184E8EEFB7A80B98DB3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
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
 <VI1PR02MB42719712F08357E634920D33B304A@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <AM0PR02MB4450BE9364544EE7ECE2CE13B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To:
 <AM0PR02MB4450BE9364544EE7ECE2CE13B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|AS5PR02MB11367:EE_
x-ms-office365-filtering-correlation-id: 2f87551b-140b-4786-c6c8-08de25e6c568
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|19110799012|15080799012|15030799006|8060799015|8062599012|51005399006|3412199025|440099028|4302099013|10035399007|13041999003|40105399003|26104999006|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yMLnCIBqQFfYe85j6Fdho5ALuVUyZWPAFIZxsi3a1k6XLDgocE66iwF2V5?=
 =?iso-8859-1?Q?gN9j8Ufk96EnIhhohJluEOzUvZ0hk3cjKDXq9u6367XS5CVlSHGH3sE0tE?=
 =?iso-8859-1?Q?3UwRm3uAaSokUsdZij8Tx0gegElVYcIs7FNXHYUIorKXevniAnP8936I8A?=
 =?iso-8859-1?Q?aPOXKBHUfRccda9wE0TI71nuhuzQxrcyWKdtsTk/M0EBEeuiofnbDzMXKK?=
 =?iso-8859-1?Q?Mwde/0jIY8+P/afOGRxBUGtwgdadqfMKOz5gJsqg5mP3O/RRUPn79/UOlA?=
 =?iso-8859-1?Q?N0e/hZWd5rgQfpeI7zC5bhn+xifCeVMa4An9AqzlEIleljcW9zwvP+P2mO?=
 =?iso-8859-1?Q?j4EditDsoHlzCY8tKEdqMhacuYOa4/Pkf2Ng7pbZ5U8QK0EvXe7cXrHa+S?=
 =?iso-8859-1?Q?2coN1IJrREVp5wTziDLsU/KUJ0e47fODgKHrJGOw4x+HlyU583KSXDPA+M?=
 =?iso-8859-1?Q?qpajsg9K6ZICm2iGLn5QJuRocPWaIOTcygIV/m1YlR+/pAABQbUJKkP1iT?=
 =?iso-8859-1?Q?dDJF1cicjyr9zlIA++jCnU0Uk+S38VZ/n6H3NrZDveyrcuzdfbuzgt4wYO?=
 =?iso-8859-1?Q?XhUNVk10/cb19PBg/uwR+/srXbvELMXL9s5Lk7GrMAoHK51vXUJLatRI5f?=
 =?iso-8859-1?Q?k9l+GPMOn1kmzjx/rlOPq2JhP13aZUnZk/MsZ0i3Z8A6w2yBnKDw2QVSgG?=
 =?iso-8859-1?Q?Etuz926YxS2liFAqwB05FWSH52OrGtMM7xVd5QpSZc+ZAm18L819Qt6I4C?=
 =?iso-8859-1?Q?cKQ/+Cln0NP0GOXOM5+kIZThVsB335ccRbaRRsCxX8ZugAiSywWyrOyQjb?=
 =?iso-8859-1?Q?mMEPaXJq49OwYIR6eujD2zeyyq6bRncB+CJja1DkaPeRf0/ja3j0UtcBH5?=
 =?iso-8859-1?Q?7nea6HJuG4V5VSCRYCU8WOAyt+2//8NeWVLaNOtWg76fru+K0Pdb50M/6a?=
 =?iso-8859-1?Q?TYALDAH4dU9l0jWZFz8UT65tHKNV7IGMBfEoFwY2cwfLJKf9ZBx8wOKDx8?=
 =?iso-8859-1?Q?Nn2MI9X0XhBUF6xlB80dRJufoA/HwtPHATGb+3iIvn5oOw5led0Vewp+n1?=
 =?iso-8859-1?Q?TpkJ7pGbhxYWTSYZ/yOS5n7+RtwILExZoyr52RsMPAz0mdjacLitW8KfU/?=
 =?iso-8859-1?Q?khKPVORd6RssdlVga0VJpxV6eZ5FY27RfVkTQhEkElflH/zTNlc0803/LT?=
 =?iso-8859-1?Q?IeRN6VwGYUVKcymcCge4E+waMp9jaVAb9CDuPR9SFOXm7JaUuEr1HwLuTO?=
 =?iso-8859-1?Q?LsHcQTsvCCgqxKj2SGv8nSYA8Q7ZsASZo+tJNPrUAqZc7oLKquQJlCedo5?=
 =?iso-8859-1?Q?Nvyr2PfFEsqJVbdYIclgfQVcjWFdRyqEYZzbVQz6pyNdiKw3VebfUAqJ5n?=
 =?iso-8859-1?Q?EQ6PN2h6W65hNda36+lpxfxTT3GY2dN+00ipHL0jtvuc+Q17d4J+s=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?73lHZz8DezRge7y0SUDO1TjXhz6EyPnrSurrlqAMn6nC9aJU7OAXE6ruml?=
 =?iso-8859-1?Q?srpAEleIzuUV1U+9FA/6K9YkF/1F4Y6jNG5ZJwW1s24M5z4FxRG0Ba1ejy?=
 =?iso-8859-1?Q?6CIG5XRpu7AGIfOnYjVLDS2vFfWkNX9Ji6tMNd9PpFxrv+undZGu3hF9ET?=
 =?iso-8859-1?Q?NjykEOymm+ca+clbO/Q2kada+d3Ptc8zw+RHIrUN207FnIkmB4vZngm5Ro?=
 =?iso-8859-1?Q?go7ZVvZyzUzxwelVZTmZampMP4sBY3InWsu3s5xAkX23wv8GqL7DpGDv7h?=
 =?iso-8859-1?Q?A+Brjf23uee9byFKxqEW4jFZnPbKyN/h4JpzXqrHGhmxwr4KrSEz9spHJ6?=
 =?iso-8859-1?Q?RYWariXXH7TrWbvHmLqtGOOzRJRGv/04uLtuRJAZKJGZYr534kubjG8okn?=
 =?iso-8859-1?Q?o/FFAt8MC6mJ2IzAGs+VWuDQMPVfCuKFCzBx748nvwr6kfpvPdiAsg9iul?=
 =?iso-8859-1?Q?DuK+2qwzmhoVTHbkht1IcQ9gmqNB8SQaQekxbbGDU8WLys2TXiaeEDkVNk?=
 =?iso-8859-1?Q?mVRI0ZBlBD99TX7sHLEitE6DXdXBC+B+4R3bEZP1w41TB2WyMw4Bby2rly?=
 =?iso-8859-1?Q?r1qUO9LQyPAXxcKLIFk9QgsCc7+mmHuIes4UricnQUNW+mpYK/VqovE2sc?=
 =?iso-8859-1?Q?cOXmkdxyad/bcaKZa6jZWBqCyDNL5A48RN658RqnwN3N+/31RlREiHCdOn?=
 =?iso-8859-1?Q?89tR4bAza7ps26ptsesHFgBISGDn0QKVoAwq4J3rQtBDFsD8H8ElTyeECO?=
 =?iso-8859-1?Q?my9xtPD70HNvUcd8K/fmvWs74qy1ylM8beP0c73xnOcNuiL0oTEF7ZEoNX?=
 =?iso-8859-1?Q?MFX4+a/3EXJjjHewFy+ntUNFZzabUgUbMVLF4RGeK5XvbiQcvQl3NVXhWL?=
 =?iso-8859-1?Q?VWQYMahLAIkgGqEdBmAnJhMZgzq7ujL+CeFG2w7W0ZB+AfrsCE9n5k5O+V?=
 =?iso-8859-1?Q?iwfDycD7Q8zXN8BSUS9Hb61nMYqb9q7WoYEsnJlHyypgat8bE8Rbrdg4r3?=
 =?iso-8859-1?Q?cmMholwg/uWFNwdxjdhcZ2p+Ln7sqN1USkw3qeEOwgrWHVkEn0OMe5D21H?=
 =?iso-8859-1?Q?chZtom57bXD5WQgEWG8N405u7Uh1zUX417ixxaWkn1QvdbaW7hN6FOTkaA?=
 =?iso-8859-1?Q?QbcHUn5vc/c9K6CNam0XQ0JrItFT+cl7tq57keVwnNKFtUKse5OooaEgxi?=
 =?iso-8859-1?Q?LyosZM+WGI26J2+t2Erc7NuXRxRUhxaSJ5rWGD+y9KbxlI3XiGNExKHeQ/?=
 =?iso-8859-1?Q?Cg6jDBEZ2vDR1RaDz7bZtZf4rvebGBn34vBo6FOpkQiUiGWkHyjOX5rH/B?=
 =?iso-8859-1?Q?dBFm/5olF1tzjwLwQtKuXJaEhhV1+i7OUoYsHRvd6chqoes=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4450.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f87551b-140b-4786-c6c8-08de25e6c568
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 14:37:01.7279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR02MB11367

Skybuck's GitFlow V5 has finally been released:=0A=
=0A=
https://github.com/SkybuckFlying/Skybuck-s-Gitflow=0A=
=0A=
https://github.com/SkybuckFlying/Skybuck-s-Gitflow/releases/tag/release-ver=
sion-0.11=0A=
=0A=
This newer version allows the remote repository to be specified so it's no =
longer limited to just "origin".=0A=
=0A=
(I consider developing a new versioning system which is similar to this one=
, but where each commit is automatically versioned, this would make it even=
 easier to re-use existing branch names which would fit git better).=0A=
=0A=
I already posted a new topic about this. Something with opt-in versioning..=
. RFC...=0A=
=0A=
Exact title is this:=0A=
[RFC] Adding a native, opt-in versioning system to Git (distinct from tags =
and branch names)=0A=
=0A=
https://public-inbox.org/git/AM0PR02MB44504C65BDF6C7D4B70652ECB3C9A@AM0PR02=
MB4450.eurprd02.prod.outlook.com/T/#t=0A=
=0A=
I am considering modifieing the GIT source code via AI to build in this fea=
ture. Another idea could be to=A0 create external tools for git, as done fo=
r Skybuck's GitFlow.=0A=
=0A=
Which path is followed depends on feasibility of external tools versus the =
need to build it into git itself.=0A=
=0A=
I think I would prefer it build into git itself to solve this versioning pr=
oblem once and for all and it makes more sense to re-use branch names.=0A=
=0A=
Plus perhaps branch visualizer update so it respects time flow as well. Per=
haps git can already do this with parameters, not sure.=0A=
=0A=
Further notice:=0A=
=0A=
This version/release 0.11 was done on 27 september(month 9) 2025, I just di=
dn't have the time/energy to update the git repo etc.=0A=
=0A=
Also version 0.11 was never properly tested but I did my best to give it a =
high chance of working.=0A=
=0A=
I have also not yet had the chance to use it, struggling with gitflow/git i=
tself, but getting close to a solution ;) plus BF6 major distraction too ! =
LOL XD=0A=
=0A=
Bye for now,=0A=
=A0 Skybuck.=
