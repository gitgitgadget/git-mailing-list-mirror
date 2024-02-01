Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2032.outbound.protection.outlook.com [40.92.90.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711012FB0E
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812615; cv=fail; b=sXohTEr3MLsbP1UnJTOuep4LG6yUeNO+UhmhCsOuAOcMfyUghFuJI2U9/8r0YnkWiF/TTEL+GEXjL0R8KZfHFX392cGmh6C2g49QDo3MqObFYpImxSXGh8Lml6dA39+bICHYy+vTEGssv781nvSXB+xm5JBjTO4Wms2ZEhcefKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812615; c=relaxed/simple;
	bh=x63wUMahDuIYvvVbLuzK4s6PutCyGZynlIy3teuAqMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hqvvkn8xGMkBZd3MwY0HQxe14Fkm1rUykMzLdEjygmfhuHKs643FoBdviaxh8+gOrXpk70/wVlLgtarf0WjrowUEFTZd7mrs2mTdKa8c6cTjXVqL7kX5On9r6Aljc6aAZOHkC89ZS9+S0kQPwMwtK3dkE583b7EXWnnxSBzmIFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=QN6QlBoZ; arc=fail smtp.client-ip=40.92.90.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="QN6QlBoZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZnBqJhHHp4LwouEjocY2pnjv81XCW6i2S4lZmYI4WZ1l7hyuhAU7Gl0BanmOuxyH6IeUnlaDoOSvzm2ITVVjmi8P6xsBWcjQZHd7fHYXikcCU91lH76fCFV1TtLvMF6N/iekeyV7xXX9IhDWDQ8YistosMj5O+99BtMURG1RpnqE4/l1SqmUdHRGlQVH9IMJmmIsyrt5TsfqAOy28y5pWGZ5VtbJsgETv9rCNHbhYh6rsK9mwCH43O+o1agR3VX3bJMmGzJeCM2tPgRlEQj7DMUQalrvscFZeMGe6fQ2LCZxDy5vf+WiMLY1blkkJbVSW88Q0033djc2gxV0xJyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x63wUMahDuIYvvVbLuzK4s6PutCyGZynlIy3teuAqMI=;
 b=jnZOxjMxqMEYT5XrmNMAnMr3IkuaAP8T8QKwF4s56VXzlROwTQPyjXGrF6lcxVpclJUaj6JYwa6x+saBb86T40krlegRUlkAE9JfW2A2raJxMm1S1Jcv7z1oGJxNI8XklgEdvOaY/aCY6fDYMUdNaMRxnLcA5bSTCPekCw8So+v6tfvWzhTMuZqGgVLS8L4eb5n/91lqEypXAgaAkaEcDNDB0rUcOJinfNd1nbpheWWg3NVm8ISVpw107Zw/F8aWH8mXPM5Hu1IpVMBP50eDuR3rmnoVZqnntYA1Bk10Fu4W5epdoSm5dcRIKfSS4rVJVTlh7Ko5TX+RBrH583Yd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x63wUMahDuIYvvVbLuzK4s6PutCyGZynlIy3teuAqMI=;
 b=QN6QlBoZQoHRMkzI8Kc4z1c4q6DJOoKMINS99AWKbsQl5AhCJW4KmJDLdZMmIBO7yWOrJy2UGh9Huc8UaCRRiJQVKys7Lqd8G3+RZlVINFkDbZO7VoClimzIq3ETtDYb3KEokigsuCT3ewreSt1BKZnDHV2jZp0rhJBwixSYIajz2Xkynjku5F/rN9wJii0h+5rl/wCiXTbEKT/TCD+U0nDsQb0OuDL6akrBRUK6CSuMgNlJO0uPz0pPspd12sxPnVhOpRc72JEiOO5xP3fZcnMA0GR4tBEh/Tmyq0TW2CNa522kpz64HH9RT38bHqV1980OIHV9zEpqILy2rDTbPA==
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d9::18)
 by DB5P195MB2472.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:48c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 18:36:48 +0000
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10]) by DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10%7]) with mapi id 15.20.7270.010; Thu, 1 Feb 2024
 18:36:48 +0000
From: Hans Meiser <brille1@hotmail.com>
To: Dragan Simic <dsimic@manjaro.org>
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index: AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcXgAA6fwCAABmD9oAACw8AgAAGJuU=
Date: Thu, 1 Feb 2024 18:36:48 +0000
Message-ID:
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
In-Reply-To: <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [O0cNtJ65BOp9iJU89ZtLfTeueLFtDFCT]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB2130:EE_|DB5P195MB2472:EE_
x-ms-office365-filtering-correlation-id: 6abf5aa8-c338-47da-e07e-08dc2354bfb8
x-ms-exchange-slblob-mailprops:
 0HFyhoHfXaQOnnledxMKtuK09J4Ts+W1AhOtT2zm6DnjQXWNxfs/AUOza/U+dyChUodgiUTR/PXDmMH6DKyHe/SEWQMx6adqOPdZPo/TCt2EZfOaBOAptNePi5pTRfQrYCSnnfRDbmxyRhRdCUScvudwA7oH5wmtAgTwRwWC3HiGXsAgzuFGYHuBCqA9uexlehoUATSudBwgo/msdJ+MqtuDWWy/kKKXsAEBnDGx4PmEbLwe9LJ2cSnNMcjO3lAEzNp2eDo13l7Lmh4dvKvWW3QTS1WvE1RGgGT3EQ6WT+Ak/T2FZL/VZv8X19GITKKSKy/+rZf4ha5686p9UFH7rylrTzLfSw5HjzB+Zb60u4CIOdPfx+aUJc1kWgFflH0mDT2sQnrQJNcqLclvD7HSCKbEgEUtEzfy4mWjf4EKPH6RBUC+WbjxS+ztZg4JBNk/eN3aJFImH//ajiLVFCQnyXOH7I0pf2Alw90pnWLCoUAFitRXN2tpJcR+j42g/lxfH5XQs7ZutvuOZiaMzA/hgvYgZfBzlXSkKgtMYOAnJKOnkjMApFetgpO9rx1Adug84VYDTKTyxXsh4Vr9a4PWCGzFY3NUZqpI7NldtTJaRXl5+P+eKE4f6jZm2TuaUBBG/6bM1tkEAGyx8VANpIVSS9zHMowJUZxIx94oLyG1gIl+1oAuMXCOcJzXJcig1NcuqShfbCERzuMczJMXpgwI6qzw9nnSo+mYnZUtdnvBjrufvc6F2CfTFjX6xukssk7opXOEQCx6xEl0pKF3U1hi9gw9ww8ct0/oHwlmiVRpTAvUFcrocKr4P/T0Lb5rqCogwXoTxeDL0915EVkmaYIwdJUJ7I+SpvuRycGABHpQOiyfFiuB+6PO0/agdcEsyZfuhvg/PuXluGQ=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NOTw7rqzIYaLk++JYuvgCUABb7Ch5NmlMAiB/bTiHHAnjbDOdchGu74GhKQCqU8624fPclhWd8a7H+XQ54mW+EZvPMdVOscipAFQqXKlUqrSWSiPyjj+RjRa13GobOoWgparSP77QyxnRPqFI5rHRWorG3RyyWxsKaRt4wF2oFACOmLLUmwh4X/vmeSF5jesZJgxcI7XDA7R+GXF+DlTpY6Cg9h5A3LCvLoRQwtQ1dSoEWKVcF/H7sa84HAvf22mBS9Z6kS4D2HeUNfj5ykX8vRy2SQK1q+MNVsvmdMrPMENo4j11sT62zgpWmS11NKCqpbd6sHJGSmRIWlHN8YtRTkykxwdGJ69OZ1wGpNPusFwgYFyky+56ZRwkCTmS8lk6BKIWREgQxmYZqPPn+EV7SQ1h+CIGy4ZlDNy19+AlsQspgD9FIU7QfgbrFfhAUtuQYNbDGMQRRQKldr5Z0SnYfR3b/DKQvM64Wuh59DcGCPz1PzcgikZbhZzOKxf7RdaT12/Dm0psu5S8vopHHnEdtsd3fMPJ9qwIIvA1SvjHpvJ8rQY4LewrXpGVrDSVZry6fsT1hwvcEoY2u+H3kTJwdIpDmLmqFT7EF9Da2hZzoc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?IcOomIc9FBRCYjzvqvN7XS9+d7YC5E0mM3NGi59xFIfQVjlyIcNp4UB9?=
 =?Windows-1252?Q?CIjYpS+uMkT9Gp89MnVcEWjAzDU+m+NrY/sjcvqKphVkLdo7sCfgE/gK?=
 =?Windows-1252?Q?EUGLGD+JfRMeLjX3JHyIpyp1417E/i0GN8ZDKVgRzcdF50PGVDZeObMq?=
 =?Windows-1252?Q?uSAapL37htFDyPI+ycukCdCG3n+jZwnGWU97d7j7mm2DS0ID3QbNvVS3?=
 =?Windows-1252?Q?xSqQloN8vGK6UVtqivFAw1yId5e79tz70R/Xx991DzDDlMhqTVNnbwzI?=
 =?Windows-1252?Q?Wrmk48XGRxc9v3fTXzN/QNhxdfgUpAp3uXdMsHA36qwWxP7QnRKGknDq?=
 =?Windows-1252?Q?Npft9mZlokOEISrcU5AFW3TJldeORuo9OZ4jWTNkccqtFNnEDaI/ugpC?=
 =?Windows-1252?Q?D07OhQHfFpTGgnHRjKoR5Xs0OKQopp5ESkgJ7UD6g6Xli8+Y1qnMIyr7?=
 =?Windows-1252?Q?46E5tfmTcUcfZVj2l4Y48UKJ9ZATkjvikO3ju/suy0J1NQVab9LRed8k?=
 =?Windows-1252?Q?/RJDkasiU0UeHKMlQZVUFwqL3GkpKJE/oV3e151kwVReW7FoGEVSQJCR?=
 =?Windows-1252?Q?XP+BGqutl9QsMTLLxIc2cE+vT3aC1XQ1GRJ6E5D4aZrHb+D37Bul/axX?=
 =?Windows-1252?Q?DCKl0BRJVpak38vDkppXNcsGKs4ugBHqWOv8zkxDf5WHC+yNxf+/SlMQ?=
 =?Windows-1252?Q?hUiI0r1rexg1mwra/s0l/gqE5GK7RY0xmcvz9j5NVHkicn58ptYQFUVb?=
 =?Windows-1252?Q?yg7m3R8QQwi+W67jymigbzMa+2wAdPkfnvvlCIsQNGL04ob/Q1j1xhgM?=
 =?Windows-1252?Q?7mPxyj/tGMEEmgLf1nMU+0OjquE/+0oDv876yqc/U0UjqE15+zmmN+6f?=
 =?Windows-1252?Q?H4IkNqBMFvqBzcvg1s/FoPDOHx0FkQhcn6XkXMczLUArRx3+2KpE/Wl0?=
 =?Windows-1252?Q?aIw+Agl5dxKZwtBOlmVia09PU1ZQU+nJfgUYCoij2ss4SIkGNQeHvD/s?=
 =?Windows-1252?Q?MxiqjXK5SdB7DLEAjbZ+hXPGUAoxV44ijuYT2KfIhfRkcgjw+Gm//dQ9?=
 =?Windows-1252?Q?rWPVcGymPSgW7ZTvO9DKTsyXtzXugV7YduaL4Mf8XRqCMf+SuO8gdK4W?=
 =?Windows-1252?Q?9A6w2HBMx0oUg9OrF0aLCrUT3SOzwUiWdkpUg1VaLnqxZu0y9zB1KuGv?=
 =?Windows-1252?Q?lf6Ob3mUs1rcs8ck8lsMWVi5VLHf63sbAewlAHGxw+ufoKjX553/LPbw?=
 =?Windows-1252?Q?DZtf6ML/NgzdR2DfTjtiAVBtHRNJJDL6RqTL5K43?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abf5aa8-c338-47da-e07e-08dc2354bfb8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 18:36:48.0237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P195MB2472

> Could you, please, clarify what kind of git documentation are you=0A=
> referring to?=A0 Are you having git man pages in mind?=0A=
=0A=
Yes, these in particular.=0A=
=0A=
From my point of view, many of these are quite unorganized, hard to read an=
d =96 as I believe =96 need a fix-up. Markdown could replace the currently =
used language, so editing them would be more easy, proving support for prev=
iew and lint the documentation.=0A=
=0A=
>Quite frankly, I think you've missed some important points from the=0A=
> Konstantin's message.=A0 To sum it up a bit, not having continuous suppor=
t=0A=
> is simply unacceptable for any kind of a long-term project.=0A=
=0A=
As I wrote, once installed on-premise, no-one will shut down an on-premise =
git server except for yourself. It can run for eternity. You just need some=
one to administer it properly and publish the website.=0A=
=0A=
In the end, it's all just about git. You may create your own git webserver =
(https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb), or just use an e=
xisting one, like the GitLab server: https://about.gitlab.com/install/=0A=
=0A=
In these servers, everything is configurable. Moreover, many plug-ins exist=
 for plumbing extensions to these providers. It's possible to establish you=
r own workflow, rights management and automatic handling. You just need som=
eone who is an expert with the tool of your choice.=0A=
=0A=
Many other great repositories already are using one of those providers; Met=
a, Google, Microsoft for example share their code there =96 just to name a =
few. I wouldn't consider these users as being known for being exceptional r=
isk-takers.=
