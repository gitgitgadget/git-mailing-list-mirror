Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2063.outbound.protection.outlook.com [40.92.64.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DE7E576
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869129; cv=fail; b=Cv1/F1hdK5HSf2B97B07JO2pCdvRKu/0iuWVcaFk5zHHjNe3t2+Y0iQFDrag8TcsdG5MFJfEWbU4pEjvDlcqHztOrKTLfLaAhOmHfT8uzPRgenUfzS+NrVJGJpsHRPvPbgcynqa70SuNjTGJMyzJbBMP7N6moktz1OwRUvhn86s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869129; c=relaxed/simple;
	bh=6agI0QN7XOwmtJWeqyNaAGTNdqJFt9+73fa9biO4ULo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OltLJIJTTr4HwCEVQKtkpWAklW/PnEEPdla/FzMxDg98GFbpPK/cgOvETNT0wyTU2VyWf9q+Fx74rWH2t7z251j+2aQUD1/7h5jVzjemOU4DZO+oF97mGWvb7BIiJbsH8v9LeDl8G53fM0aPlsCn8fnXL7L+PX5JhtfGWtWf21A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Ki0f1kx0; arc=fail smtp.client-ip=40.92.64.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Ki0f1kx0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw5GpodRA4Ii6Mrho+gx5iQ6SOEf86QRYqK9RmQ7MDqPMz0yGe3sdrFzrmowNhrNLGd3fIKWXxW0eZBcZXI0E45CqoubdPUCi1lk7H40swq/Dg8/PMAuZaBEj6ZLeR4r95+0m3vQnj/0xpyUmfgPZkaYL0AY6+aozWBIATe5vB17c8LWyqgXcS9MYMvBP2Dh8/TUFKyJOhuJUtlLpA+A2W+WsjmRKt6L/wS0Yn+UKKY50buE1PsX77dgSKEhFPjkxzNty69HzDzaOnBzkr/FULfl18J6femEaCe6426q0jhlf5Zu6P/RNFMpC4HYLlARf6JkbUr0s3XZ9R6Hfdtb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9dA6DLbYNyL8iUVv8d/vIwvA01FkM3ElTGmKlkFMTc=;
 b=JgWoS2+72OjvqN/EPD3NBhEtB9aB0u4a7b48DE+csgpID/AhzmVascMX8ipnNEL2yNqJDrr7faWPbbREsTE8pVLhG8MXWAitq0B2OPzDpkvq4QKcY35dzS3BT+B5k12BA1MU4iAf+XklpvCvMKDvWAR4c+uxx5n3p5gYb9HG9bZLd0n9gcEMd883vou5vH4c6YFGuSzhT5XcStkGTN5QdwMpXrOfiTtD4Uo2MFTp1RZ0g2eH1yeqSxgS2Z3U1Jo98Q4qCVBwXYIg0VK0yZPqRu4XX66L9Xtx70lwabYZpMYAiA4+x6gQ3iTEvx0hTN5oKdtzTPk/WIUWdrEA4FH+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9dA6DLbYNyL8iUVv8d/vIwvA01FkM3ElTGmKlkFMTc=;
 b=Ki0f1kx00TIDQX+ghl0IgyxYOMTKbKXCvrnk0ySkRnWqJC8Wqq1ZoGVG0Dgv3fXf3Q0EH7DaXHKZf1I7l4Q5KURtulr2qiJKmePnfgsE8chjA1n3/f/bPo5vUqg38NRXOV39YuuvXO0YsDCFkb329B3xnJimak3Jzvgl6j2MvepAOVwxSeFzuEz4eMT1nsOz5sd8w0G3vAEYjPMSDqhcdBSzsALubaFr86P6pNfdZOhqjAy3sLWQ+6yJfD6vq2GonlsB5lCW2tqmH/Xmx166RxcoTdHFhInHn/a07gtU3L2h8Za/Obj9HglYpvseNMMn+LbFsHcPRot4e3+c2Nm3eg==
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d9::18)
 by DU0P195MB2004.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Fri, 2 Feb
 2024 10:18:45 +0000
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10]) by DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10%7]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 10:18:45 +0000
From: Hans Meiser <brille1@hotmail.com>
To: Dragan Simic <dsimic@manjaro.org>
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index:
 AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcXgAA6fwCAABmD9oAACw8AgAAGJuWAAA1uAIAA/McM
Date: Fri, 2 Feb 2024 10:18:45 +0000
Message-ID:
 <DB9P195MB2130EB8EB69A8140A31BB432E2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
In-Reply-To: <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [6NRueOJxrBuFX7SwJmPliJ0XO15j3l3g]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB2130:EE_|DU0P195MB2004:EE_
x-ms-office365-filtering-correlation-id: 4013f78c-b657-4825-d84c-08dc23d8567a
x-ms-exchange-slblob-mailprops:
 F3kBGFPBgzYX34cN5wvmE1g/1jaARvbY/Vt6eU1bpiP3T6lfPCf+l7t6t3lnqmnaMl60j004rKg0DAZI/VMtR0EfBNCta7Yum2KMw6CbuHpXlZX3+zK911ImU7SZIA9SQNL7SKeGpxy1UjMagf2baa8oLpBXgFJV7o3OWR0kqNiQZ8YzkQi7e82QmW8iecMLDuKCyu+wKMZF+T9gvqaslAEKJ8wtTnIE+brCR9++vitUlhSX+1GEU+KAe1yZJShGHLI8Rzym/l7w8KwoesnMCtU8HzHt447zpzNw7vchoOnDXuE8eJHDYUH0tmki5qx742OWURrxj9L+SJGXG/JitKBwEuw+4ylphJdBX2SN5T8wx4w7Ol5Zh4aS+X7WzWqO3xqdjx3p7u33a5p3j/asbI9SbsvPPGqkm4pjJH6alYvZ8BlHrg1FzBnjLL1uz7A+kngvaYb/uPZjh4NStdUbzz/ahUZsNyo0yxKcJueJghhIezE5rfG6FNdvgLIbVKkmVzZgCbh++eZ3FgjLTJMstKwDCbl+QjJWJsvGhBBOTultxh/bmrE2v478zYVPg6eXyQBwkEl1qWazOoWGN11E4YC0H3WkjwEI61e22YoqSJeB/x00LJ5QKa7hy8TDVtrvlehlW91IlS9VZ0IsETbFY9ZzuE7olXe7JLKeY1UuZV1IHCMdDK/7M8/lBqo6NeDWhKMBo0c1Pj7n1mGRINF1xdOjNZA7f35BEiauWYb0B8UH0mrStq4PZkRL6VfQx+BDfuAytu9rEbYn4NLXLApfXUFTSz8YRvPa
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Mj9u9xqj/dL3Kaxp0DzsvIwuTtPdqwv0e7EUGVWfqedsxqNgmTm45W07TuhZ+SsIJu+wk3MfAwwEe7zAp/rI9yTJ+XyQ4RCbuiZuNRI5phJ/3pY9zyDdgLcLhXGOi1nfOM/03Fhc4TbSbvqjk2Hj47M86uHLAa/MRprwMZgmkPn032MsccXccug8EMy4633h1H7XSBOqmhI08o+068F7n/o2vJjyqNfIBbBemwfOZu4C8YbC7cJD5VA8FNBj2wJOyNKnnkKg9XiDhGghRZStfGsu0E2tWtsUtkHbTJZkIl9iuXcvolADhzvaOAprCdaoVa/stnSc4PyTebN60v+hs3uh0JrTK60IymKvVKgeMlcK/Ro6g9JkRbXb+fO8nTzUWMO4MoNwGq0NCZWYLLCoitk3HoajaSrkdTduTwTouPCi2n46Fx2Jutv/AVTC7pjRRRMnse7ozUqILofabv5GzK3PmUZwsSYUsHv3e0NzOtTfOX5XHZkhGu+gS+Nz3UBIxy99ZSQxw6ebgCxwXYY4NWYMv3x3WKc3oaLuZR6MvZMLmc64oX5h9zKPWBqfXkD6
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JFAvvVmWbmXbEFIBQld4Zyw2S1AAre+vGaIoxienQ41nFvhiIzPNHjjCi2?=
 =?iso-8859-1?Q?YtWvK9afmoeHWJEISt2MUOikxzvLRgxwmFXd/PsuegC9UYMJpwEGQDl1Q5?=
 =?iso-8859-1?Q?7F1aQDAXzMb1TUN533Md64ugBhd9qbK7Y/3t1VRgoTkZjrPTokROv0SSHG?=
 =?iso-8859-1?Q?+AYDMn6K4T+k5V0CXy4Qw4puRDNcKNysQPv5StpRa2p0msgl+zXlOl6ugi?=
 =?iso-8859-1?Q?A5S6VlMb6HTTj94OliCOmainykYUGFms3dtuIv3cyZudLy8FwX1SPOzM9O?=
 =?iso-8859-1?Q?htSUmQNke/xYCEqrzJuNxxF/MXtQysoDlBuI4coogadIW2pw5NWesl4LJj?=
 =?iso-8859-1?Q?P+bc43TblKMfA0CKTpeKAB4THsEFKn7aFCqkxeGddejdjzyr6JVmvaUviw?=
 =?iso-8859-1?Q?8XlfFd9WSxd++Znx//Dycn0pRFzmzvnKbkgvbimYJ/PM2arfptIHTHwHy7?=
 =?iso-8859-1?Q?uuvoXSQ3Pq4/8DBR8FW9Mh0SUw/GYWos4lX1nbF1IWHzlIguU2rgThHhtY?=
 =?iso-8859-1?Q?2D60sjI7QhqgXJeftwU+qReTNFr3Nttc2xXJmCADHnGeuCKytp7ezeKeS1?=
 =?iso-8859-1?Q?6sKODFRNOJFrQr7+wdbR8RWGg1ag3Jks7zDF8OTPXV1nTtHIa2nQJOpxfr?=
 =?iso-8859-1?Q?uzQaBuyYmFIOFaBp1EegEaSi85Kj4Uh/B87QqcGkOakAuM2XqMwoqVhJQJ?=
 =?iso-8859-1?Q?JMXqDNy1mwfwlmotEAspRdGq6E/nU8HlnIvuDzy8idujAfdKFOzE2ZLNLe?=
 =?iso-8859-1?Q?P9IMB5O4TeJHlUfjNdg7+kJ9hncGoTZ09l8wGw2knXY5obxHtbwd+/vWEK?=
 =?iso-8859-1?Q?uiyhGo24iU4PNSV20RTOu9NeZXQ9gHvLKHdxhYut9CQRdanQxJo7B99wHM?=
 =?iso-8859-1?Q?vjRqkWKhWzXQlaCe3HuuR2WWzyql82CQp8Qwpw1o/KZw5WiFGePww02bb+?=
 =?iso-8859-1?Q?TLZPUsTnKa/QeJ+DCJK/OQi5FiqH28nQAQIlupdyKDJZlR5sAQRRJNOhVJ?=
 =?iso-8859-1?Q?Dkk6pjXcNHU40Z/b/6DKidYrTkNoY27zkucF5qNpLbztKNY5TiymTgbH01?=
 =?iso-8859-1?Q?jEuzrbgoI3IVJBl+azqW5BaL9kPJa6qnf+6m/DP4cDVLbhmc9yUifcM2Or?=
 =?iso-8859-1?Q?RvtVFUKEaulJrAD5vwEYEpUqBTqLmAscVMCPdMjbQRdIKhuJUDBWdkGV9T?=
 =?iso-8859-1?Q?FqSoIN0nvTF1lMawlm8vrBQnp6ULiti/344evrHzJuDQ6kPDYPgviLBO?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4013f78c-b657-4825-d84c-08dc23d8567a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 10:18:45.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB2004

> Please keep in mind that editing the git man pages requires very=0A=
> intimate knowledge of the related git source code.=A0 Many times even=0A=
> small changes to the language style can change the meaning and diverge=0A=
> the man pages from the source code, making the man pages useless.=0A=
=0A=
Sure. Eventually, I'd rather propose to have parts of the man pages be gene=
rated from code comments (XmlDoc, JsDoc or similar), particularly syntax an=
d parameter list. That would keep documentation from deviating from code ri=
ght from the beginning. And it would keep documentation writers from manual=
ly updating obvious parts.=0A=
=0A=
> A git server?=A0 I was under impression that you proposed running an=0A=
> own instance of GitLab or something similar.=0A=
=0A=
Basically, GitLab, GitHub, Azure DevOps are all just Git servers, plus coll=
aboration and automation functionality. I suggested using GitWeb only in ca=
se you wanted to write  (and keep control over) collaboration and automatio=
n functionality yourself. Otherwise you may use one of the existing ones th=
at have already been written (i.e., GitLab, GitHub, Azure DevOps).=
