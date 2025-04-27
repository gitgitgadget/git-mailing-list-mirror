Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE1198A2F
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745783054; cv=fail; b=glT5Kad/SY+7CQ6/5dclaOWJoIKnOW2iVj6XvRUMf+W4ClLXBlkh8LwDaMkFShLPlS37PUtST8QLjIiaRSyPhCDu6Uz3tCbf+/FFqrpbQ8tkLHJtLw/7sZwGvTRNfbVjCr1GFeqAWOSp2vvO5u6C5SpGbcR5qaDwA12+KXr1QSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745783054; c=relaxed/simple;
	bh=+Smda8FNbEhCyErLT/CfdbsABPf1nW16c+SwYaeXjTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDnuHuMtm87vpZC1UYRkP2kaa4Yd+D6VrA8185FnlAZ/giNl18dqVHmgfE3qwJqWpuoDHVPkd42m3PNpWKc8Fh3GBOZS7hLBYKN4viooMma1BZ9NDJnUdzZ1+DU/JnkfmDQ8ud5/em4utJqf84/YvEowVlLpsxMu83q5z7msc8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZmZ9ZjkQ; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZmZ9ZjkQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu4Yj+cK+9gHd9XfziIUaaUR6ATE/bt1R0yPiZzyPzZOMznERumbudwMlDQldMnzM08MZIDJYu4CW8+GeLURxY26kHYQedgT/xXRnk/N8cevFN6bB4N0YCUVgHozeN0ZZAKQRC8QEOmEnrZU+4bDQiXWOZ60IkasfclLBZ5MXU82Iu6xdvTy6/+wOFDGAgSOqYKcPNKYjpBrf3dShNQrcXdqi53JJmZYZpVfBQ/URlOH/bfMD+bC/oC8mvRDNxzsQ5pcvOejOwlPRniqIW/87FT7Dj1oBV578gLPua/6vPvLkAhss+LI24wkoxEQmEP1VTMOtxTb/083DNcElPOyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOUe/RKDd1oeMv5ZCOI59qVZ3jtRYPGm1MnBQN/Onu8=;
 b=pi0Cj4HQuSzDxnBSb9ER1pVyjJPS9e7vqmbBKbhiFdAymxZqv4501GCJ0EGNOKV0YP8bNO4dp6lwpWAuHHig4fYneV4Zo4VYADEiveRK1Xho7Ph6ZLNR3nuwausILI0iVG+9crzOxi3eqsLH1rNipRoSHVWZnF14hVdJkgw2aMSTeqav5RRbt4oyryVyf68zgbq4PEIBUJ6Lep/+dbOXd/WMAeWjbg3M9N3wi2u843dR3DgEuCXpzBzjf19BumZef3jHkNDB+Q4JwBpc5Z9ipAHINSs+P6wd0uDDzasAyHzmBKMhzaVcEWLW7xYH5I8O0WOkPSOhRkrQcKSouRkq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOUe/RKDd1oeMv5ZCOI59qVZ3jtRYPGm1MnBQN/Onu8=;
 b=ZmZ9ZjkQ9aorVnXxAl96Rfe8H/D5LVsBiNhXzekao6GVTGbFJNeTTBXjIJkit4zjt6NPWWSBRXy/A/+X98vhWRJETmlFpWdFd8FPZ9UO2h8hK/ICAljaU8O0JfGBsG3nYpJ+4pGRHHtMf9oPUk/W89Plw+7nsg8PPsTCKKGlwTdsHw/3YYvJZWRLAZbT0wsCLu9qDwsuuzlc+/vUbwo6kNKsCsHHE5jArxvDgZNxwiG+6+6Y7AwqBBn9608d6c8oJa7gI3neLbpfz11vqlxlkzyZV542Njc5acOWuBwiLaJM08UcLV3080Ery/aPe+nO8/TI5hkdzZEqxGsDpDQCVw==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN1PPFFF5422585.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::433) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sun, 27 Apr
 2025 19:44:01 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%6]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 19:44:01 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, M Hickford
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Shengyu Qu <wiagn233@outlook.com>, Erik
 Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v5 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Thread-Topic: [PATCH v5 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Thread-Index: AQHbtO6OPlbF3trl9k2S0ZHXA4TXuw==
Date: Sun, 27 Apr 2025 19:44:01 +0000
Message-ID: <9EB1E1C8-D538-44E2-9868-4024099C3AA4@live.com>
References:
 <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB9588861EB2B9589C8BA6A8EBB8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <2025042437-photo-header-2d0d@gregkh>
In-Reply-To: <2025042437-photo-header-2d0d@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|PN1PPFFF5422585:EE_
x-ms-office365-filtering-correlation-id: 3739e16f-e50b-4a4b-8a7e-08dd85c3dc55
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|461199028|8060799006|8022599003|15080799006|7092599003|10035399004|4302099013|440099028|3412199025|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3pq8t5i5JN4n2K39c6HTP9JX/iF9MexvNIVsRLlUuCiCT7CWBDaTI7AXqUH0?=
 =?us-ascii?Q?sibfdsc6VoRjlZ36nNZC/0ECJKQWQJezQWcCckbPL4NzKoTmocxkHm0bWMKo?=
 =?us-ascii?Q?eR8M2LsSbjG7mnweGJ4c4TnJ6tIaWTA9n6VvyXu+8wChpMc4PR2FWHQ1UMxs?=
 =?us-ascii?Q?cIqy6bmejWKRqCzK5VN+U+b4p5plO27Ogk7QYA/hVBx/c8ND4Qje2bZOfntp?=
 =?us-ascii?Q?BFNwkAZIHtcfkIsqiraKA2P2bo+I/dFxOAOP7DusRXL286RzClV8ZYLvQxY8?=
 =?us-ascii?Q?MW6/yjJbDLbf08zAWKKpM7uXNQa2sg00O+z6F9FBQ7rvnQSG1ilVjxoOzrwE?=
 =?us-ascii?Q?/QJqsMmSZdlSzBloIY/26EdCSYzXCb5wuUNSJ4xCF1wHElps2B+nJWLLy5jW?=
 =?us-ascii?Q?3BYKMx02GNdNpT6HUYHSFCSy9ZTpNC0d030iVvKk96w6MtxKh6ifw2a0jEia?=
 =?us-ascii?Q?M/U9xRGpSiBf9lWtPkY2HZmYon8Rd1/Mba4s5Wt8/Pzzs3u3KOSKbc9fuaAc?=
 =?us-ascii?Q?lMVorGWhMQ41OeJ+VP8wPk1C7GliHw+K3EuYFLqTVqqqerD54WOogiJ16VRC?=
 =?us-ascii?Q?mCXtAlsfPllVd8yXPUF8OpE9FYwLLZyCnshkaeE8epWIeXTyuxDOz2hTqm9M?=
 =?us-ascii?Q?hZ8kk51scPj1Gu0a0QRV7ktsbExn1OZvHt6Fss2nmPa2gXpnCIt3k6pCtjjV?=
 =?us-ascii?Q?mFL211burOMStqQgaN6ZEDKh0/P21VWe6fj1TuhSoeoFMB17gwDy1Tw9g5Xz?=
 =?us-ascii?Q?f/sIp+3CfHXTGCnzEJujkmp4qUzA1D4Oo+xynqI9DZSY8duQv23PeYDOigCU?=
 =?us-ascii?Q?IoyGF40k2pMlg9lZ66tn3TQ6eV5iNQmfZko4GzoB4ci2ToSeABZVdtpUrUlc?=
 =?us-ascii?Q?UohgbX9kMDDZ/ADrJZXsHEhH+9XoMM3UiOBHjAgoXJItO0f2/59u1sVOdkQk?=
 =?us-ascii?Q?ZjctsgYPglESRPYOLKXlnftb3NY0NjNTJzQRfdqNq02BkAB7h7yKMZnofp/x?=
 =?us-ascii?Q?zGSVkZYHAfkDpcBL8BLzD7AkAhKyt3EvK0D2K6pAWSd3W7HhrPtgYhnyWewC?=
 =?us-ascii?Q?uWn8shHH2p7w36Ui4KF32BNZdG0VPbCGUAIILXWWNhZcAMAkPQ0uePm77dC5?=
 =?us-ascii?Q?CDkuJShoxyVAMRI9pU1b7f66d9DHrDaIKVoXv8fBpAi4ETGVgqSUPQZ3JGV9?=
 =?us-ascii?Q?/eoK4PYVjVPG2lxSpuo9PxL7+IYbtIUlUoeAO3hj9IqHPXmOWynvflOOmO39?=
 =?us-ascii?Q?x8eacUCJYSt+CTW9VNsLMCu6FskZkq3XvsQDOkg1OLdhe0HY5Z0M4LA8OYyg?=
 =?us-ascii?Q?LrU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V6slXMuKJW+Csr1/jeM8znsj9664AYKL/8dy4dSzTqbVCwsvIktjHjrfu00Z?=
 =?us-ascii?Q?UAP/wbznSVYW/L86GAutBaOSFOgjldtKeQBmTHR0LymcgmxcfPJ1YtqUB+Bm?=
 =?us-ascii?Q?Yn2dHbU5krJ0FxxGHLblb7bLLmABvqrsE0qBaTrDmtE7T+mz4x6+gu9jUnf2?=
 =?us-ascii?Q?BRsnsLedpnmvQt7BEy9EDjA9Dp+Z4hOEuDyRRC0wOxx5wHVfa8vrKNfmvaeS?=
 =?us-ascii?Q?xjm9Ow15ZsrOnxBTKr/3/W6JEepUGyMsB+RRqt5BkiHc7XJVPmJHtEwydJCx?=
 =?us-ascii?Q?H6eqeNCeqQ0dSiLOI7t5BBWKBEq9OWC8tTt23/6SVp+FDZKOj+Tqk8S4pUIA?=
 =?us-ascii?Q?ip8laop3npDMdMYrFkutzL5Afj7XhV1g/QFuJZLmZZmSIBwOnAaTp71VlhW2?=
 =?us-ascii?Q?rX4VEfUsvNKQ8gF1ntibMYlBCvLKieTvdE8MReZtYpk9KmukY3+iREF2JmSy?=
 =?us-ascii?Q?w6J2tNumIBhq6rFL9LxMnoOsOLLxUhXPcjZIV3Pj0i3/b1Gpw1Frt+HakT7e?=
 =?us-ascii?Q?Q+beyNY3i5WgZ2RUf0OjxXIrHBTPwL6FfpNKNlGep5oSGPqg/sE16ZOY14qL?=
 =?us-ascii?Q?+Ja3pux777MlYSBGkO197OYnSCvxlefN47Sc33ORrfeeRjT1bWV+jythxRAB?=
 =?us-ascii?Q?En6DQCtoB0ZaYj5AknruLpmfBRVzJSy7db3Eu+1vzGneTHkSU/tItCsAhur/?=
 =?us-ascii?Q?ttewkGJXiU3qL2ycuXovzePfELr27aDkphZG8y5SL7wxtAfvNnn5pIGa8E9l?=
 =?us-ascii?Q?XqWEElPQd8RAPs7auAvdxsb8f9OsD0dbR1uo/dYINxNcCx19qX5ZeHnIkZfB?=
 =?us-ascii?Q?4xSa/Bhy17689tzKggGd0aMjeAAFl6jDzQn8tNsegQVod94B4qldGN+O7wg6?=
 =?us-ascii?Q?hTweiLIl74nJrSY9DD/0T3nTqIsUWgxNFVFrc8bdcO9mRxR+uq61Lx/pjDga?=
 =?us-ascii?Q?AT2co1K1qBXAm2g3Yz8BwhrG28tVbSguohh78jimJ2SsMj3XUKPtTEKRmmRP?=
 =?us-ascii?Q?F90dC31atSMo2J9A26GIJbw5RWeSQny97296pXdAxKOttCYC4ZVRDpa5rMot?=
 =?us-ascii?Q?AtR7NN1y8Fr13wehCgs9Q8s8/jORsDJIInLtHLEkWhBeg1Gcuiw8xlEyoqXz?=
 =?us-ascii?Q?6AsVDLt5KLzmsWH1gNTSRnjOcN0EmTr/glm0gLtheW5U1n5E/wwgvfSFH2Uz?=
 =?us-ascii?Q?cTBwi3UhGNHDo4FMwgRdM2/nYkt6Qzk2hYHXzZ6xFUL9+b+GvKR/gGuMtN+N?=
 =?us-ascii?Q?A7xH4hC3/e7NywD/qnsKqwBolGFwAlIq8CBWWAqunt8k7D+wC5D+jxFjbjqs?=
 =?us-ascii?Q?dBIHZ8niWewIv8Pn3TFmD1bR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C26C3CCDD020D042B0BF80BC628F827A@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3739e16f-e50b-4a4b-8a7e-08dd85c3dc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 19:44:01.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PPFFF5422585

Hi Greg

Sorry for the late reply. For some reason this mail didn't even reach my in=
box :(.=20
>=20
> No real objection here, but what about all of the company-hosted outlook
> server systems out there?  Do they need this same type of "flag"?  And
> if so, why not make it a config variable?

I have proposed a patch for the same here:

https://lore.kernel.org/git/PN3PR01MB95973B932F4961FFFA9786CBB8872@PN3PR01M=
B9597.INDPRD01.PROD.OUTLOOK.COM/

Thanks
Aditya=
