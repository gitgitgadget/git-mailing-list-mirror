Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2074.outbound.protection.outlook.com [40.92.90.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66C15D5AF
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789416; cv=fail; b=q9Ri4P+gGqDa1JaYlMcos6FQqM2UfMr5MuJgPBDLEZCgd7Sv9+pAID0RioxwlmqcSU8G4uBveat2XXW+c9IAo8OPN/5ecyKzmdZXFzXRpbEEBlZ4ogIpSHyG25DpM/ZjgEYXledTnmEBjyFGHs58PbHF7Dp2for+nsmeu6xoYno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789416; c=relaxed/simple;
	bh=s5r6ZZw7cYmbb1pEMcymCyqYaybD+BBOsNx0si4VDVY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p8b9+VhZnzdlAjVuEoiMY8eMvIX6RNC0LVNk8awukq8V8COeP2FC4co7bFljnKIO/MHYyX/bU8swZN67gwChKgMM7ZhiQzhCAi6WlmUf4oZgr3zSdYKg6n+VRDj/SezKXsgWTwZqt8fD9XiZajD+oc43mhD2wygRLbSxBfqvQ5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Edgd3QSA; arc=fail smtp.client-ip=40.92.90.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Edgd3QSA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J221TjyCdR0qDUrF/drcYbbIHCixhQchVs57c1pM3lzodTnQBoZRlFJYJ8eWNQ0G6MYE6uBYSESkOoWmPJSbAipMGg3EFC82obkyYZkWIeiHTkse5vohkPtbm0hoWaO5474944gLuyR397pt1j20MekJrpmQyqdJHGhzjqcuHASJ2nAQa/Og9b9FwP2INwKb6m6e9dHeeIFgh/Nw19piHozCC5+6tWVnKwmi1NCUVkE74qeiEDF0RifrrtLUOWjwddIK8WrkAZk824cFd1icIobW6kWJhzvVa8y3cj7lt4LzU+vz/Iz7ejnOA0chokDU/1GB0HjPJUU9ZLU7Q+i+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5r6ZZw7cYmbb1pEMcymCyqYaybD+BBOsNx0si4VDVY=;
 b=L3Q0IVPyD0yRykyTBBelz27KYSHo/qfJb3tDtN1O52Q3BYC/MWMirhXl5JOp0aJz4d7okK9qg6+VKVZydBk4dPe3FWNXvh9bLPlAR6IkQFE00Zp7zXM3I8A0jasGkrpbeNXmS8nraYNNx4hsz1Wgec+Mk0r+MH2ExMK9I+IUNe2+ynZu0bF5oP4oVipFoprxZFou3XVE+PNWkHpDpQKtCkZS6ntS9Z3drcmfIVRc6hPIEHLcM4V59bvGQJlp6qt2ZiutnxuSVF6zB9FS+WheUzPDqrM2yXqKDvpL5/OrhvTZPFsihLMvu98fax/7qMZctbC9lqWK4kfSwqAuP+b4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5r6ZZw7cYmbb1pEMcymCyqYaybD+BBOsNx0si4VDVY=;
 b=Edgd3QSAXRj7LS35Udm8GI3a/Z69AePjWZ+fXKp2Wl/y+iNilSdR4hGe3TxQiJ1Afj04sEnFsND6ulQc8Yn+WP7NHS+kFve6+bg3tLQAZ0Z7MwXzd5p7Ml9o5Otkfcr7nBopxMf1a9fusIPG+lalbXvQl+CHFMpay0GhEgk4Eg4QNM6E0j67YuBBXl4emwLTW5guVlw1i45OUuq3mPlhYBfFK38s0nO2jiZYecDTgfODcIg4O8tLYBLny8OsgFX0Vk0t3vQ6JdPDHzgTdb6ltC3dxCrsuo+4C2cluMPJgyvkAS6QvG4ag4qibRqvxnK5zdhG22ScKF8J0L+xwTHcBw==
Received: from AS2P195MB2135.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:547::6)
 by AM9P195MB1046.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 12:10:12 +0000
Received: from AS2P195MB2135.EURP195.PROD.OUTLOOK.COM
 ([fe80::256a:da73:54ab:fb77]) by AS2P195MB2135.EURP195.PROD.OUTLOOK.COM
 ([fe80::256a:da73:54ab:fb77%7]) with mapi id 15.20.7228.038; Thu, 1 Feb 2024
 12:10:11 +0000
From: Hans Meiser <brille1@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index: AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcX
Date: Thu, 1 Feb 2024 12:10:11 +0000
Message-ID:
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
In-Reply-To:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [nAkWI9FJtffU1fsrf5walq1n13PLm/bp]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2P195MB2135:EE_|AM9P195MB1046:EE_
x-ms-office365-filtering-correlation-id: c0abb0cf-c863-4778-0204-08dc231ebdc4
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpD13W39oRI9c4QrHrVNXXb3twEOBV6NLQl2BaEJc90so5tpRwpZsr11XgAmN4MGUfpR/KVYv4amce5rsZ0BRB8sLekLJI8rgvzDyQ6FUr0R2pMSraAXadOMqCAoUDmECAf8Q6JdlBYi/6zCZ5QVbTpQhUUUUjjDywB3IBC4bRZ8snM1GKPz935gKKJN45mCVas7lWu1ZHebN3Yp/wD/AQLUAR6+sDhz9maxMShmBKgcB8wmFiF1pUVfI+PVLiJAy4h32bmrHJQ9rRg3fzaYJ9EBs7ZPKOEZt8fzoEe1LnPj80yNIZ4NKkkBaZYk9kLLGvpJJKU1P79OnNRewUzvBUX08jr0A7PrVtm9orhPzPa+dxJYROvQ455TERYOGRlUk7+GUL9k97LGEU0AY8GH7yVdMsHBjpZth3WGp+LaMFeMBvu9lvFejaBFvMbkM3aHCGt9TAb2zhsqWV0hwEAXXEVK0nz9oER05sv77K86sJhCpzu77c1j+I4u2HxoZB3sSVQ1FTcBX4OjX1iiNczm9z+LuRMPugc/agJE60WVSw+Ry7F9DnTo8B/zZru123llO3B5iJJUrIao8Yubf7DyPpk6Ipl/ZRrMpzNkP+zRWahTblf0TQ6gVdyEVA6/BdlhGCwgmdGiNDjlRPLqMe2IY7QfcaRi9Kfjy5tFyINc+ffAx6lQQymg0xxe4uI0x3JpAYfpzfIhR0dy5dDjSmHyK7Ex9Z1mu2MxuppwuGah+YQ/lezOD1y9TU8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xkpdqh07Z6AFA1zZa0okbPzP4y1uHsVfPv+82hwxsAE7A/Eg7E/uuu6nZXuZNdLQ9dDB5pTKh9anGROO8rh/P+3MT6sdRrftv22RSrG1IL6M+lyzORuQY+JaBsOOGDSJGCkNLj8cBr93kQDM8KLw4lL5YlXqH0SG/SSPbGxNlFSwCIS1aN1Jgmq6ZpSUttPx3XzwnWpmK3+PJywXiOr1Q6ceBV6NYBL/Vyqq2sj6qkV3u9FveIV1w7wwuRw5eY/c+QOGzIz7wDBV6C8DvAkS+wNyo0fhSMnBXeWcwBb0eKulAD0gh+VmVMr/4s9s4PXWcpGkeAZ98B/lWZxmCF8yk/eB/u4Hd9KWkEIXU1pZSOvPWkdlFEYOkeN02UPYt8iYCv7jp2KrVgFv4G0hRE/4HsWOn19HvKEhEdsd3D+0XvZDi2h1fjuNPFwGRAvyK9vWtYyRxIs8/KPipS92fDFOjK4/+hhV8GhNPaSgkMLwUYu79+1xsFA5pKaBoMb7Y+gy1j1r8l5pTc71NkUMPAdLGnT9aGm7FxCWClybPkt7nFvtd1l9bdPRsfj8o3U7QRHq
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XQXlDTfK5YtYRwpTJCQau/NALPK/3BdafFR4Td15G+h3+d2MAwfnEAOHKq?=
 =?iso-8859-1?Q?5AgCXOPLRvGBVm9gOTBU+grKXfGxUlO8RdtQm35lLOLbwaS8rP55vyWcSE?=
 =?iso-8859-1?Q?XJC8aaIsUYGIo07h54U4/1xKb9arn25LpyirJRXHWiPQzflKcPkbyr3J0T?=
 =?iso-8859-1?Q?BRw7jlIMYqxlfH0RtrHGVRGZLtZPTmg54Qww0LqtYb+Quj0z3COcIJ+eeE?=
 =?iso-8859-1?Q?h86N1VRN8VUDfhn1eh//lvgPVxjxKLd8oYIcb/WKndDxKJC3vw8km9M/NE?=
 =?iso-8859-1?Q?Qa2HLCVj53Lcky5EVhx917Lhb+VzzNR1DKw/NLaXYY0vyfl8HUcV99vBTg?=
 =?iso-8859-1?Q?N/m2Kff+NdQYsQPQMPnC35PD/ULFLU3S1A/DOA6wIISTfQtER7gFWSN4hE?=
 =?iso-8859-1?Q?nZfuK3I9QYB/lGWNlTlG5uQucAGOdyxH2qof9YmxelqDb8eM+qIb03iu06?=
 =?iso-8859-1?Q?9bqJHNs6meRrj9fsmctooRE+JeplObydlNppRvBOirP3sC7u1Z5u1OtbTB?=
 =?iso-8859-1?Q?z7IlPVvsr+odlH6iJf96/9r4cmFsEe112fKCUn9g/m4kPHdZMXnVwdLuTa?=
 =?iso-8859-1?Q?QSlJ+thwMAA0wEd2UxFr72pqBiTlM8xpUsoRpX3oRCrf7+3UPsstIqOf7t?=
 =?iso-8859-1?Q?EaUfEpGUifNK1/pOm8ZU28X5aG+MKkpoYpF2MDkUdV1/g6ppkjYPfIn/GJ?=
 =?iso-8859-1?Q?gPWMBfH8hCY7OTAEs9fCpR/zuqIGHWVc1DxDqxzLt0AV/kZ8yZZgorrQ9r?=
 =?iso-8859-1?Q?+XQ0zmsSRv5MYzbzz9FpscOLq6Yx0PFOaGvRjdnC+8XTr6jAmsaSP1EvCW?=
 =?iso-8859-1?Q?A1h1ACeTQDzGHNKTnKYvXpOUN1ZCmxEjxtpnLZJQm0oJCyp5KhztRpY4KF?=
 =?iso-8859-1?Q?lZhuzrlaXe3y+ed1uqw7pbRR4lzHIaxZi+n1s+wkye1naEkDhwgQS0ebFl?=
 =?iso-8859-1?Q?PXCAFBjheZBwUe0FOXpQxUbP991u7u00NU2+EQfpRoXEH1CQXofK6hgH6s?=
 =?iso-8859-1?Q?uRjNj+0BoAzN3lxWq4z8YXU7ANTz01hjx/RvkqRlOsMmfJxQe8pGP4eyFf?=
 =?iso-8859-1?Q?OHaCY+An5FZDnFtWz4LJrvArHpiMs3zfVEHMuV6FJju0BhhJKlNiVC+qMS?=
 =?iso-8859-1?Q?A0ScuaukmFN8q3rnoKpZDtsLdOzWRymxEJTPA6KImK+61iqYblSRlOp6SR?=
 =?iso-8859-1?Q?+Se/PE2eSAbmmNldiiMeEu6QXm09gH9e2mZiJqJzKTl8Tqg6fnSOiTz1?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS2P195MB2135.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c0abb0cf-c863-4778-0204-08dc231ebdc4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 12:10:11.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1046

Hi,=0A=
=0A=
is there any current discussion about moving Git development=A0away from us=
ing a mailing list to some modern form of collaboration?=0A=
=0A=
I'd like to be able to follow a structured discussion in issues and to cont=
ribute to the Git documentation, but the mailing list currently just bloats=
 my personal inbox with loads of uninteresting e-mails in an unstructured w=
aterfall of messy discussion that I am not able to follow professionally.=
=0A=
=0A=
Are you consideration for migrating?=0A=
=0A=
Regards,=0A=
Axel Dahmen=
