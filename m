Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020112.outbound.protection.outlook.com [40.93.198.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B742902C
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170322; cv=fail; b=MVkOk/oAY0iLsVS2v6mwzgkbJJ959L7Ll5UPPyo46i8JNjIoDVD195sqweLiflF7bkmdXn8QZtDokbh2gQnJ/Ggf8ySMyuyVyErI1l36CT8TIoJLJ4hCtcA0WI/fYSvLf2b3x2Lqz48kCV8GVY8e22FuuZ/6gBiBPB8rCf2iGX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170322; c=relaxed/simple;
	bh=sCJ50O2qU/HfATzq+tKncYD9Yuq4AT5paTgIonltXsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qIC9S6KHstRuOk4Br8tLJwgI3wIw9EkvH4mxsCKgoO4/aXTnp6givP+TG4vqxR6braKRxZVSMFwOSqQ7q7NB7aKN5UzE65lcSCKD2JbxoJk5bst1p/6NP3Sxx2GozT583z9t6OHdshEm6a7WohokRgdpHJb6tF2gMbw3lCNpE2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cseasy.com; spf=pass smtp.mailfrom=cseasy.com; arc=fail smtp.client-ip=40.93.198.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cseasy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cseasy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhTP4QlA7s66RqpxRR9CA+gYqFiQRTDwK9koeJkwtw4CjPqwUDkSJVSKKYDpE0ENzM2Cwxo7Ota/I8IiMmhWxf4YHIA40CF8Urf3WhygsLID79clbeByJGtqYGpTU/TNC/eXUfw33LuZxOhY9u/W5mI/7C28yY0FCf3tyj00wgEtEE6exYuYov31MEOSQIHQAyYH51xPXZ0oJF1vYJNxaXmo8n9BJzexz1yozfrvikO7n2eAVhzdIAdhTDu0BzMUmw7xDbK0CHz13UG70PjDPh7ZqzUMYp/Zmfg/qKCMY2cQwgyxxj00cP2cuDxGQnqjxbUQRx0NmC9GlkIAh0KZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNdYytlg8k8YB5kvGRAkxCOZOir34edJv1VE70vaThs=;
 b=Qm6t+Hap77b1myR5ZN/wweOTJ0zwb7NxRoUwWow5sj1SieiYPXHEG/JeLphluGlq84/s7h4rioITF6vhlwXOakboW3Ce02m3ftQsGkuLowYOqJdvZZ0iCcqnD8eRFJzEd+TSWRuIieicGKUUTuOylXqGrTQAasuCb0IYrAIuH3z2RL3zsu/o0WgIWDRLqT6YrgeZAY9sgtVM9W1a2jWpk92Jn3VDJwS0nvcMtNcP2j7ByUseEutUBLlIAtxUG5yZSstCr2BkN6jJsQid4W8uDwt87SQOALYq6qZA77a7SJ0fqw0HoJLgda5WjbvptfodqFszP/NtFD5Ijy1g5vPaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cseasy.com; dmarc=pass action=none header.from=cseasy.com;
 dkim=pass header.d=cseasy.com; arc=none
Received: from BY5PR06MB6548.namprd06.prod.outlook.com (2603:10b6:a03:235::8)
 by CH8PR06MB10782.namprd06.prod.outlook.com (2603:10b6:610:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Mon, 27 Jul
 2026 16:38:32 +0000
Received: from BY5PR06MB6548.namprd06.prod.outlook.com
 ([fe80::a1a6:27d9:74f9:8d2c]) by BY5PR06MB6548.namprd06.prod.outlook.com
 ([fe80::a1a6:27d9:74f9:8d2c%4]) with mapi id 15.21.0270.009; Mon, 27 Jul 2026
 16:38:32 +0000
From: Randy Kroeger <kroegerr@cseasy.com>
To: Weijie Yuan <wy@wyuan.org>
CC: "D. Ben Knoble" <ben.knoble@gmail.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Please provide help with how to fix
Thread-Topic: Please provide help with how to fix
Thread-Index: AQHdFWTyKDAQC6hyGkO8jU2+2+BnirZwtI+AgAEgd7GAAA5rgIAEsZYAgAsL3yw=
Date: Mon, 27 Jul 2026 16:38:32 +0000
Message-ID:
 <BY5PR06MB654890B2980DED47E7EE363BBACC2@BY5PR06MB6548.namprd06.prod.outlook.com>
References:
 <BY5PR06MB6548F18EA532E3EF021AA93DBAC72@BY5PR06MB6548.namprd06.prod.outlook.com>
 <CALnO6CDGkAzu4Xz2o=VaCfwsF1WEcBw2k3-JqmkGqj1+ZpRQyA@mail.gmail.com>
 <BY5PR06MB6548A6BD9BFC90367098FC6EBAC62@BY5PR06MB6548.namprd06.prod.outlook.com>
 <alpUg89NbGWijZCe@wyuan.org>
 <BY5PR06MB6548864CC0DC0E012F4B76B1BAC32@BY5PR06MB6548.namprd06.prod.outlook.com>
In-Reply-To:
 <BY5PR06MB6548864CC0DC0E012F4B76B1BAC32@BY5PR06MB6548.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cseasy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR06MB6548:EE_|CH8PR06MB10782:EE_
x-ms-office365-filtering-correlation-id: 26e2389e-68f1-4575-c786-08deebfd7eda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7055299009|4143699003|56012099006|10067099003|22082099003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 9js3uCgYD85sAYm9xQRKIV+M30qhCMPnyb+WqMvLctg9p4Bc1M+srIR3sai6HehQ9Ck3aI1ksPEgnILbafvC+lG7zSGIlTz20boHBo2zAjwVlimhANKgbXXArKNeSocGl5vtW4VkbKuxiqePhpKtNyMW9Dk7mWFDbmvTCqFO0AyvPVNoZt0Ad7ZftCm67tIUfxoJDItLzlygHdT4EzWLPfQ5rjQaKS6oN0i3VQBY1JAsgAX4BXQlO7XGqKU4R/ssljZiUXHkwS5LCMVD0NTFPWT9jnGLnY7YR3VmmFe8Jzx5E6GmfianBThI7u/a5NciU1cHyKa1WcCzpNZSCj92CKcssWMZDtmb/ZU0pfheqUU/DHif7vsYGox+95phObQn2lfdTMiQN6O16BR6mpBn0RI4i08CulOkDTy86hwXSdQwlNRR2mE8JK/b4C2wnkL100lcdJ54fajR3wYoTO1BsVjRja2eAkgx/729cKbD5jaF6G+Jk/jnjLImWRfilgqO/sR5gT5wQLxsRF0XmahkcSn7kwkSVcatmf0Tfwy88oANtSCL1s9ovvDC4NdSqznTds5XzMEH+cEF8FDrY/BBLRLsPUhFELQOYZuVRA/6+ZRtcB2ioHQ5U8sOwdSsTsmLquPQ7IieSEVqx5gkECAAzlu3k0kfKUKAfKAToI7lde0f50utGgNuF9dvL9nz6LeL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR06MB6548.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7055299009)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?21+iodnbAF6qUmmoWbHZuiQl4VwfRSuBwJPrSNiUt5224CGo1AfwlXmM9k?=
 =?iso-8859-1?Q?UIzYEXzKW2tNTUr99fG7TH3zRD41b4Nm+TPbEsMTTDe7gPR2Ie4ckEw9Dr?=
 =?iso-8859-1?Q?Hq7iDb100w1NVVm/gHIDuwdkMOq0t0uG2p9gpR06ytnVRBHIivH2wqKhfg?=
 =?iso-8859-1?Q?nMSEa7VrZqNbl5uVMtFrUwNRcolJ9wCXfs9rHWhtyISv6I+6V5EvAJ1yF7?=
 =?iso-8859-1?Q?oaypQgg/c2MkRItHeWU82u5YDu+lqEy3AvSObNHhX+/LmsBfqfoLpKDZIv?=
 =?iso-8859-1?Q?Vsf1T2qRqjB/Gzo2Ivdx0PFaEXMuTiIrXW7gUXKJ35yYMs/dyHUfNj2F/P?=
 =?iso-8859-1?Q?6h/DvkVBQtceDQ4Q35RG17no134gCz9DGfAu+JvGlSRX70+fVVoRaTFNXp?=
 =?iso-8859-1?Q?9ROCI6YzFO1LzxljF7/1L654ViPap8pEm9560hUmAWQiRgZsJcT5lkJzK7?=
 =?iso-8859-1?Q?guwCt8j2Q9SAInoGu6/I6LAE6uIJohgTx8YjmI32yeLv+qWpkcY4sV+ZZd?=
 =?iso-8859-1?Q?fPsL/2Ek1aY2YUKS3Av70HgMcvun82DgGtL4nkyKj5XJuI065ZdJdyqGia?=
 =?iso-8859-1?Q?jn2d4ZFO33r3BwldiLAGdByAlGKq5R4AYwXLXJSCVv+MMqEXLV6PLPxGlx?=
 =?iso-8859-1?Q?/XSYmwArPAq7W2m24WTjT7vvEodQ9WovfTtFRL3R8l28WcWvF9319SYumG?=
 =?iso-8859-1?Q?T+eoUNBiNku07wPgIZUNF7NQHe7V8tTKY4WgkggLjXeeR3xCXbC3proKSy?=
 =?iso-8859-1?Q?5r2ar28JfGbwvEvCCa038Ud/Cyh+5jDqxG7XjBmoOszw8Rbbnmj6dTA00A?=
 =?iso-8859-1?Q?UUd1M/fboeiDpoJFlXg3CW+qzmNt2dLUY8/KiJmjjMen5S8o5ZejN03eBL?=
 =?iso-8859-1?Q?8WNnXCJBVDXrEjKVH6mw1VH4s/nQqVrmBEh6jXH7gUaED37PoapXP+VTu3?=
 =?iso-8859-1?Q?sHzA5hriqqcsUPgRbCXCmdbreh7Ab/0TWpi+JTuN4y5lYuAf7j5L2nhJmd?=
 =?iso-8859-1?Q?5Ij/tS8QsMIIGRvvOWY83ZXyRfnad1fHhVqV3vA8zcopX6ooomFUq/Z0jo?=
 =?iso-8859-1?Q?ML2kDQqF+9DJMx48tgVVtC/5IekBrdMSQ1BezC+osPUqOS5plAAN4uKxzb?=
 =?iso-8859-1?Q?stVmE4ozWOOtMPtoqQFrYAbG5dWAIv3/o8/4fYmp+12/SZQyc06wyddKtH?=
 =?iso-8859-1?Q?jLP51KDx7nH3I/qXrFOthbBt3EyIPc9ugEWbjHge3uWwe81SPud8t5/Wrt?=
 =?iso-8859-1?Q?gfsrGbhp08nA9JhdJr1h6vmgEfU59TeKAO9XXqA8A86y+qUdRm02jVdFC5?=
 =?iso-8859-1?Q?72F23jGnAGM80umiQKqhymk6whpw6wOaKqCuo2t0gnzyX14D20uYvctTzO?=
 =?iso-8859-1?Q?H6RBdd8XaKkiYQ1PKdGSCoYPWAWHZUuy3mlEvAB9JPWCIJhpzy6+3HFhKk?=
 =?iso-8859-1?Q?Xa78fOCOzxqQI6fNS5rXCzT86XhzK2JvKyUhiReap2s1DK+BKnNa1qjBeB?=
 =?iso-8859-1?Q?OZ7KxY9MuW/KUiuqauzJwydEqpnpBak7wrQHLQO+JEBx4+6dYebL1wxhhs?=
 =?iso-8859-1?Q?UItIO7VFrZwkH1CYEA+ROBSXwfHnzD/vF/E3pdhiDdkqRn18qcJayWKSF2?=
 =?iso-8859-1?Q?cd/nPiYBS+Vw7ywvNa7J31zJWrkRIb/l6ZkpAsA+84jNQFt0ClLAcGr+Kg?=
 =?iso-8859-1?Q?Q+mzNNeI6qymX90KqU5MF9PXURYT/53Ty4Www6lw0mH90JWf2zOBN66mKs?=
 =?iso-8859-1?Q?yikG6w9uhm+buH5MSKsY1vlYBKeee0br2w5W6IMF7bnizG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cseasy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR06MB6548.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e2389e-68f1-4575-c786-08deebfd7eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 16:38:32.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de9b6050-2664-45a4-9dec-fde78d7e4237
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3bSUGOz/5MISqvl98WGEn1FD+C1LKBsjFbNn9i58Il0S0+Sdgn01/hjEwikXMyTkaWJYFLkk/GF16+G/IxAfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR06MB10782

=0A=
This response regarding text formatted messages has not resolved the proble=
m I am truly having with GIT.=0A=
=0A=
The has a resolution and I was able to include all commits again. =0A=
=0A=
I will be only using GIT as an archival repository in order to simplify its=
 usage due to the lack of using modern technology to handle support questio=
ns. =0A=
=0A=
If you use any kind of a support system, please close this request. =0A=
=0A=
Thank you=0A=
Randy Kroeger=0A=
________________________________=0A=
From: Weijie Yuan <wy@wyuan.org>=0A=
Sent: Friday, July 17, 2026 11:13:26 AM=0A=
To: Randy Kroeger <kroegerr@cseasy.com>=0A=
Cc: D. Ben Knoble <ben.knoble@gmail.com>; git@vger.kernel.org <git@vger.ker=
nel.org>=0A=
Subject: Re: Please provide help with how to fix=0A=
=0A=
On Fri, Jul 17, 2026 at 03:40:56PM +0000, Randy Kroeger wrote:=0A=
> HI Ben,=0A=
>=0A=
> I have been a software developer for 30 years and in the last seven,=0A=
> have been an independent contractor.  Trust me.  You read too much=0A=
> into my intro in giving advice.   However, I can offer advice when it=0A=
> comes to emails in the old fashioned text format, please avoid=0A=
> interleaving your responses.   Depending on the device today, it is as=0A=
> confusing as what you mentioned my diagram being... haha...=0A=
=0A=
Hi Randy,=0A=
=0A=
I highly respect your experience. But interleaving is how Git operates,=0A=
and it surely includes the Linux kernel as well.=0A=
=0A=
There are many online resources explaining this. Here's one, please take=0A=
a look ;-)=0A=
=0A=
  https://useplaintext.email/#etiquette=0A=
=0A=
And by the way, you didn't wrap your text. This is another established=0A=
rule that has become conventional over time.=0A=
=0A=
Thanks.=0A=
=0A=
