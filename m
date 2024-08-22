Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2013.outbound.protection.outlook.com [40.92.89.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4717DE16
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323223; cv=fail; b=hjndSZ6Z8Ga9pvyNX7ZX0P0Fh5w1ldzCbOLtVQpfqyzULQPQqyZiHPaAc/2eRGjA5Iu7zbKyAv6hxYxXy5NV/o76smFB+2sVG6fYM76IOqq6cYZHCP7lnQ+NHqCjgk7NMkKMGgYXXjOpFvZHtKubi+NzGCZHGw1GXSqIwm+kUSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323223; c=relaxed/simple;
	bh=tpeuWg/hJzOQw1iRPhijro3nBSDnJw1+v0L8N8PhklA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cFJyZE5qKMZRyfAqqWbQABJzk5al9jhdj7b+Q+jnqUorQNMfQPdnWIBsXSUmkAAcXEKBnOgiSwyytjO15+WOgPg+uxC9B4vALBG12Jz7tcVcWFFtIwdtsuK5go+4p0U83NRNyC+EByOMBuKkECLrAv0669DC/BVsOibmOMPljx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=JQaeqF3B; arc=fail smtp.client-ip=40.92.89.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="JQaeqF3B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGF5ZiaftUnW4P/FseXSU/6NVY/TJHDo1Dz7qut1IHWTaf/9/23/o3bSAXRSQcjiyDJFI605bvxPh3VtYohbyVxhawMCVx0t9c5VDVs0R6ibfDkg2DzWT7CRuvV3P1T10AChEDpH5LzrCQWDi3lXH7lKOfIBtZzeqNJg6hvfhgVcuMtKcDewP63fNffe9Bz+YyX3PjNNhcvdlytfJo7JJUfBxYt57/kiciOdOUgrTAsXAgSPT4+/1QvktAU84YSeC3wso+GlQI+bS0UPsdiNQhVjyZ/fWBgnj499wFFJ6sl5Jgbq1uduRfr+zLz5YPsQlaj9ECBIe8cQbK799FyyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf96aJwQHkdTanP27zFqqh5i3orFQ5YHU2SaADNKNEs=;
 b=D4ApaqGfXTH3QumRsmPPQxlx6qpD6bG5k7mLOPE3S2FaYHl9R/+U8vJFqnaBMsjrrtMgT5CtP6AIrT57pGn3eTukxm88CjPyZ4LHuFOxvoHmcs9s1R9qDevkd8SQZX9GQR+WTlCvlpodPhNTzecHUbB3t9UDBFoo03LDIXeoT/i1Gp+zNbidpfpQykWnWdL4hmFCkHIT1Xl30fYyFkbacfPd9tSJOXxYSF0cdAutATE5UP2Tw1bIYfmWCqDBGVhKYrtxNqVs2N5mu1c9SVfu2pTnBw6T9AV+qda9u1i0Yxg5VY6J/lJ1EhNYFWMcuhem4RvtfyJyUkM4Fg1+ZpphqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf96aJwQHkdTanP27zFqqh5i3orFQ5YHU2SaADNKNEs=;
 b=JQaeqF3BK3GCINKkTOBzhjtxtWDns4WXSeY2Uop6k8XYxh5npLT2GZzsnDkkEpCjt8lqiFs/sFbOb+LvXORpFTB8Jb1FRrJsQTlEaQgJ4A6IEVjU3d3LQg0DRa1dgJIQKIYrCFn2jJJZqJo1CDsHQfdeyfn0w/FeJJWrYizwx6d8awArZAhzrwjRjIsKF+ljFT66wsWUx8BdEFzWJ67imWwHOqZGD7UdJ1hOmceyeNQ+iSd2S7tYff24Ccrm5qvZr3d0fRPNgcjzfoVHy5RMyipgdJx1mVcRa2D6Ux0Nj7BKgZnR4CImKntyNxsN1nNiv84z+CRniT9uXvqmthyAPw==
Received: from DB8P194MB0870.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:165::11)
 by PR3P194MB0731.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:41::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 10:40:17 +0000
Received: from DB8P194MB0870.EURP194.PROD.OUTLOOK.COM
 ([fe80::c9c7:d977:f2ad:5306]) by DB8P194MB0870.EURP194.PROD.OUTLOOK.COM
 ([fe80::c9c7:d977:f2ad:5306%4]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 10:40:16 +0000
From: Marlon Regenhardt <marlon.r@hotmail.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Wrong error message when cloning from http gitlab (and everything
 still works anyway)
Thread-Topic: Wrong error message when cloning from http gitlab (and
 everything still works anyway)
Thread-Index: AQHa9HyIP8RoebiGKkWAP7d2bHFevrIzFfqw
Date: Thu, 22 Aug 2024 10:40:15 +0000
Message-ID:
 <DB8P194MB0870877CBCB0576CCCB520C0E08F2@DB8P194MB0870.EURP194.PROD.OUTLOOK.COM>
References:
 <DB8P194MB08704DAF8B33C67FCCE43EBDE08F2@DB8P194MB0870.EURP194.PROD.OUTLOOK.COM>
In-Reply-To:
 <DB8P194MB08704DAF8B33C67FCCE43EBDE08F2@DB8P194MB0870.EURP194.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [RMqTjBeZx8g/3di7ucx/A0nPhiX9GKEb]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P194MB0870:EE_|PR3P194MB0731:EE_
x-ms-office365-filtering-correlation-id: cd4a9568-dea5-46d9-c0de-08dcc296cf64
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|15030799003|15080799003|4302099013|3412199025|440099028|102099032|1602099012;
x-microsoft-antispam-message-info:
 Vb1ryYHdVOXsL5qon/l1AmqDVLLoMp43SPQL5qcOGHV566m91VA7rrWIGdXgralK3jkWnbPf6yekO/eEtbrCdvAWKb4dYqO0aHKggCGCuRJ3tPu8EN3geZ/Q/f6pgQ/BMRzYwxTybr6o/Xs6mDZCM58ErkMRjst7x5zlyLWoZuYRQoAw4wpZXAJhZCvvkFCtU/IekTWahZuECb7mHsvMGaI1JKshhGL353fIj3zpD+c0Yhu+ziDEN7oI2jLlAGcQ0xkGpt09tSCP8PrHfCpZfmoJ4opacDDf6jyDhupIVbH1r1HvISgXRCXCZ27wqjfUZgsJi3ydCcj/d21Am7TrRm2HXxH5PVtuoHcPaWvCXPZfQjbMI96wvWdw9o/Th4kT9ssJa2r8ZDJesqKAFlXZSCk1E3RTxinbaqPUezAhqncicVtyfvBea0Vv23olBn1qI/foNdggU3OWGsZQoNzpDYA+T6wVODp1Scrx0nfXAc+oofDFTynjKbkHrtfvFZH9J8aof/DxWXuS6+Ayvv33IHabLCRRvKMnKpm5pvSt3fZeE5V8oH5JPj19cF94E0g4MVYMHI6ybm1wRZnGrZQ1M57wYNk9ArSVL8TwzwCYjaNMfkrGRZ2F1EBFqg5DlRXREdPhiGJLFC3RX3DVYTupNq9bFkX95bQgtAIP0BGo//NKTGUOO95+RCfGTl7WS9a4lKa/2gCeIOfo7hPBkyh7d2KfDSP9JeHPSldcqV5pOM47wmwfBS9q8BMNyct4HJCAUIacopH6JafYPb8Puf3skngN7NUSWZ/2zn0E4QVM+ntWhaIzQz24HMh74y9VO5fP
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NnT9KY4U3pIAKJygUI5Sjf7rAxqgmIeD3wpovuGpNOy3Zkthg/YP7GOHjZ?=
 =?iso-8859-1?Q?+6H/g9C4ROE2h3jN0hzQefglDbk5bGmUjSRbNUW9IUrxn7q7SxVtfqGzgJ?=
 =?iso-8859-1?Q?fi73G5kvyMaiAB50wzmBEAa4NtD0t+lDj5VlmWv3yKwma25MjhT/NZcEcN?=
 =?iso-8859-1?Q?TFg7ib/6cLLql8Re11vyYP2kdmiV27iDl3yLwuRdewyb/8IvfrbNYMy274?=
 =?iso-8859-1?Q?HCPfzPa5316Hxb4fLqFfWLFMOHhXlClN5p5kFLIpg2JSLTDjziWyNgarRL?=
 =?iso-8859-1?Q?UKik9z+qpvyBjtJBbMYeeQCSuhgfOlggCg5u/MYzcM9IfOqESS/usESnB5?=
 =?iso-8859-1?Q?iIQCl5BlFtZ9sYeWv9VQ+hTSml6OU9LBHBqUwtKcHkKnKQFNDELMRi034X?=
 =?iso-8859-1?Q?QwaR7hcSiRBynvWcETUfIO8EGAy266+M6XuuNNxwXc68J8xDMTyIKow+RM?=
 =?iso-8859-1?Q?Y8wBYDqD7GQhFVxnQmmNy08YRAGNCZCEd6oW94WpUyXXCVeE7lB+P426FC?=
 =?iso-8859-1?Q?7oA58nZq3sYzbsLuianqEiXsk3NCK8ie50GINYROmuD4rczvZLFEVnxjSh?=
 =?iso-8859-1?Q?31iIL6pWAAX/tl9mxOGqXgE6aFCeknR29SZWjzu8bPP5jf9cPC5VliqKIA?=
 =?iso-8859-1?Q?qTOlBSlAelYXKsuvi/4q53AgwxuXGTghg4yovqp18H0ee4WHgaMfmKLzZF?=
 =?iso-8859-1?Q?A4Nu/gA/ESqBZ2zS6xw0Kd64Wi5JWoz4k8Mqs4n8gbqEJRBI6eJKzcrxcP?=
 =?iso-8859-1?Q?IqGZGpp8epAMeL98z23BPKuK43Ir+w0moY6bxfb1iCJhRaK8NeSX5pNLGx?=
 =?iso-8859-1?Q?Vuv121vT67rEdpOeYimliqWnphJn9ES7US1ZFzH8L4+XyQhZs6+7khwAsB?=
 =?iso-8859-1?Q?kxLckuOScXtL3gj3WdX4xd4T7Y4CHkJXz861ZE5AjEAXESdN07xLgMIp9E?=
 =?iso-8859-1?Q?Ft3jbE6jhL3rMAF+EkPD3JAhPybUfDTF/tho1C9yH6NekKqtoQF9y1tF8I?=
 =?iso-8859-1?Q?w7fStSSxw3ec/uZGaMsLjuXqewTXw3J6SZnJjpQ8rx58TTIXC1XSpNa02c?=
 =?iso-8859-1?Q?ZB/ntf5xXBr0MfsraU4LkRLCBP9dhBE5z3QBlI2GAKFOG/jocLvrPdH8o1?=
 =?iso-8859-1?Q?6JEcCMvf0hSPiCzhCLzrH/gGDZGvPOcVGeYOqNTwQQJHhOatL7vT3gNat6?=
 =?iso-8859-1?Q?/an/qoA68+fhp7TAKe7kKV9oVeJK+RTg5DtU0nx/DUgl6x1/PLqagA/K7m?=
 =?iso-8859-1?Q?dCs3KFN65m2RUgOnxOzg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-43ca8.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P194MB0870.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4a9568-dea5-46d9-c0de-08dcc296cf64
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 10:40:15.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB0731

Hi,=0A=
=0A=
I'm currently setting up my new work PC (now Windows 11) and got a weird er=
ror message when cloning our repository:=0A=
=0A=
 - run git clone on an http GitLab instance, in my case I ran `git clone ht=
tp://gitlab.company-local-domain.de/group/project=A0LocalRepo-Name`=0A=
   Note:=0A=
    - http, not https=0A=
    - GitLab=0A=
 - Get the following error message:=0A=
   fatal: Unencrypted HTTP is not supported for GitHub. Ensure the reposito=
ry remote URL is using HTTPS.=0A=
 - Get prompted for and enter credentials=0A=
 - Get warning about redirecting to .git URL=0A=
 - Cloning commences and finishes successfully=0A=
=0A=
Our GitLab is only reachable from the internal network, so adding https has=
n't been a priority for our admins.=0A=
There is no GitHub involved at all, not sure where that comes from.=0A=
Except for the error message, everything works fine.=0A=
The message only appeared the first time I cloned something from this domai=
n. From the second time, everything appeared as expected again.=0A=
git version shows 2.46.0.windows.1=0A=
=0A=
Best regards=0A=
Marlon Regenhardt=
