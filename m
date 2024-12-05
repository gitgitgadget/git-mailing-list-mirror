Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2052.outbound.protection.outlook.com [40.92.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A61773A
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418062; cv=fail; b=N7c531mJCCbkpTOAMrEpfmz4Jsx5dpihussg1tNUJACRabHfh2elOvQz2FU/SmCP8r49daDZ/c3cCWH/ctj8xV6Oe+AojzH5S+XbnmMHYXbLyrCZqQDBs1LRP3BSsxVgHQ2qmTawOyArx+qQml2YUSmiJ+hWgHrSPbabSAp8xX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418062; c=relaxed/simple;
	bh=PcC3l1JWzr7XFicU5i/ha7Ue+VXlMbKNkIjDP6SL5CA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nrHkZe/wJM9F3MPQLN7vzW2M7o2VVgNJ6Gh27gG/MNELmRI66yJDAyNcFLj7QHDNr83cKN6c43LtwYwSffQlGuzNYVoYwMGQSNodwELUMtV2OXUja/vEj/XKONQLbcQayPfmk4KMdiFwmHYHkqR3lknXqNhyYSVJ8Kj9vi9DaQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T2Nz697x; arc=fail smtp.client-ip=40.92.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T2Nz697x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEv3fD2HbpGXs8OhcRH+iA8jkA9VimOBG3nmJtIq1GN1DZVwz2kwR9ZWUsmUN1w8K7ghKWiYUrAUR8+7i2zb/ADAd0s2UWw+4nZTKd5uShovLXZLoN3IM2Er9k0kv/5DLREEQbE2kUf4ruBxaz6CkckHjxNUo5HalHBr79V0nHh4W9Zv0GiVQRrnwQUrJbJ0nlPlnJ/GqcaLmfEoi1fo5PutPlQzDLHTQmVfh5vrsEPjH20rSq0TJvIBRd/9FCHVLNrYrabNPpp+++NcMFKnEZqyDgJgcQHa8V7rVX22fbn/QGpjv/ejVJKbH0mW/dZqBWoKhI4X8TnNSRVvpzEMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5hKXEXUF1gijVBLRoPsgmChhXdpodcIl5GHSJfWnbc=;
 b=rSHXCl7qOZW6euIAhQA/Z3zdERtVY48D0hd32Bcb38fix7kPngIgtG+CuMGBvVSIDZFu6K4QeYI6DxsPymk6zJ8fH5p97J/bWJGfBF9fdsozC/2Af/pz4TVjuLQxDhU2+vXUZkHe+amUhKtMPA//bVoYTnJ+al+7k2fgjyuaYar05c4Ta6lTtgqzrfpIG5Fsn1+fVsQIvOttzAZn98zew1QgG64sZV/jfzNTBkwb1IE6gRkqqT0eR5EZwq/MEte0XBI8J9RAHED//do+A2P8/99LIGq55kh6eG3OwbkYM/tQqUVrPYWzMLoIaYSt5g9rrqn7x2tEKCb5NGvk82xjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5hKXEXUF1gijVBLRoPsgmChhXdpodcIl5GHSJfWnbc=;
 b=T2Nz697x8eYBSy2s+Myq6hT+TdW0EevAjSWqNkgw07i4Ag+HCN8gD+zHiPDEcSMl78pyoTSPHzWY5UpUBsW5dbVF54snuBQViC923dsr/UArYgRCaP2JibJbNV+jp1WdXlqn14jPWQQfaKZhJLOiqHcfWgrIwMxk4yN9ugjQIv+QfistxQ3zXKkQnxKP5vb1oYNe0+QNLYFGusDwrayYNWifxcoxTdKowmv7OxczLL9TMWYBCXbTdd6yIWem8Qi/arh2SmdXfTOWesNoGLitv1pnTrQagNwkopKOO2a5b17yKdqPrPwf3MKfzLR1eZW/vt6r8pfzGQy3IfH0BkDxZQ==
Received: from DM4PR14MB4880.namprd14.prod.outlook.com (2603:10b6:5:390::9) by
 IA0PR14MB6766.namprd14.prod.outlook.com (2603:10b6:208:403::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 17:00:57 +0000
Received: from DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0]) by DM4PR14MB4880.namprd14.prod.outlook.com
 ([fe80::cab3:9377:6fa4:3de0%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 17:00:57 +0000
From: "dangling ." <kasperkantz@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Proposal: Allow Customization of Git Merge Commit Message Template
Thread-Topic: Proposal: Allow Customization of Git Merge Commit Message
 Template
Thread-Index: AQHbRzaT4wyMGQCfz0aUl4wAJ1X1ow==
Date: Thu, 5 Dec 2024 17:00:56 +0000
Message-ID:
 <DM4PR14MB4880061D71993B749F44F2EDA7302@DM4PR14MB4880.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR14MB4880:EE_|IA0PR14MB6766:EE_
x-ms-office365-filtering-correlation-id: 885e3262-d4f2-41ff-840f-08dd154e62f0
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|15080799006|15030799003|19110799003|8060799006|7092599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?qyseRaupsp5PwrWN/1ma5xpnrOe2atLPbWEdMdykIuWI97mpTk5hiYPe?=
 =?Windows-1252?Q?HJ7QrOIygPKS5az/vtVIRBJQRF4K06Qm6ZPi1QOkPPutAN4hAhBi9j60?=
 =?Windows-1252?Q?RXQ+7NhhDK2MKV2oIIpo7aOPybFIFZ3b6PZAdYJW6ShIgY9mKXp79JxS?=
 =?Windows-1252?Q?Z1q0BY4mBTU5ZFZCIq78qkaIiryg+LpyEosBlrbBsq68tNPIJ30jyywt?=
 =?Windows-1252?Q?pO1NcdvztJx+fWKIwus+N6eVtLAA1XKP2WGFq/DRK+ckPtJd5mTW3Qae?=
 =?Windows-1252?Q?wOspg/dW0MMBYg8dfs4jn0ESURJppPuxWoXo2bweHjBoJkh1S073w7BW?=
 =?Windows-1252?Q?ABemTCl6s+38rkChxhbPRZf/C9R5QIm5exhHfxoaRk39ppKT13/qv5CZ?=
 =?Windows-1252?Q?HyFq6fkj1bWNSBdlF7VCG9jtH3YlNParjw67PdL7gOwidJHbKIU6rZM9?=
 =?Windows-1252?Q?bEZSWvlNlURMAD24UrZmERFE+9A96jdew38aSy4ocorn1XMe9AY3bG7f?=
 =?Windows-1252?Q?gBvubxfkrK3snvwf3udxdflmY1SAFMa3aFDiRl64Hy54Gg+RCsjyRArL?=
 =?Windows-1252?Q?O1ONzlgBXjBwJ2eCU1/lD0iIiK0UfLAuanz2KMv7zr3kl7XuoDeAnudn?=
 =?Windows-1252?Q?x0ya3sYtyiHa+MyOemzfDKWs2sbTAveDXKkZovLdDu4mxZaN5zHt77J4?=
 =?Windows-1252?Q?iXXKcUJBxA7KJHJRGYJckvj8sfDjjG5LenMoZ5X/FRbb0mtBIEA64Li8?=
 =?Windows-1252?Q?6EtKeo4ZsRV4UwILSMf5LUDfJCHUWa0KJis7EJkT2brB7PE08M/qEYO/?=
 =?Windows-1252?Q?xfSMhzk5U2XzoQxW0hMmYQ6m5+hvmjfMloV2J8Xyo/cPMbH0csaPCKcU?=
 =?Windows-1252?Q?fL8CNMNCplCFBm+xtr2d/JB9HDQgQZcGnMznQbTyX//CxmnNYNtC2kjz?=
 =?Windows-1252?Q?K69ooc9rBcid+R5S4vxcxGeBwSxDVlwNhUG7kBrTiir5/OJHSb0SeqyX?=
 =?Windows-1252?Q?B+Afq1j4nulO1Uo/UPwhOkHInKxevclVrrPT+aw+RWEmifNdO6cEdwM7?=
 =?Windows-1252?Q?hlVjonwcpkL2YWhe5tc8BeFnp32ga+PdyMWkprT264gUeLVGMFV/O1DQ?=
 =?Windows-1252?Q?1RXPiH4LvJwFQ1hxQ+yJDsoM?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?oUy2GjW1ooJF10jo1nuttVl00KUa2qSQZVG71Xxdkf5YDIFab84oWFmT?=
 =?Windows-1252?Q?CzFKYRl/362BnEkFrWz8zJg8RfzmJUDDK7g8GJfrdJlBAaKjesOOhRSa?=
 =?Windows-1252?Q?Bw+NDgm176W8eeee/Ei7UYgnGDHblPFQmHCNk290SU/2TI65ygFYbKii?=
 =?Windows-1252?Q?3ltxtmJb99Fj3LswDTJeVs7ZFFEHuay1g1BmQeb7UjOPqGvtiAeZPP/R?=
 =?Windows-1252?Q?n2iVoWvkQTaq5e0ryCllulBfPwk8z1Qz+LdJh35LryLKpZm9vY+Lqwzh?=
 =?Windows-1252?Q?ayKYAptpVWOhi3OkGYl7Ihz4HEjqmZTt/IOk0bJ4jzrnvlHqANNqh3Ma?=
 =?Windows-1252?Q?I67sNGm8tQmcMo9X6g3zxtSjRQQP47Tbeq78oFO4wVIR2iE+4h2d5FuP?=
 =?Windows-1252?Q?2TQ7J7X1FtjBVtfRlFJ2dEJ5aKV8zqpC6L1JziR3FuOodr9UMzmQ8OQd?=
 =?Windows-1252?Q?SH5hQzOfdbFituJgsxs6behs13FHfOpL8vE0pBFX5uqqFeRnuktJh15A?=
 =?Windows-1252?Q?O8aBJKF3VTSVqfma/Jweah/fDXaq4CEnn6xj6tke4o5EdtrR75PM5x6S?=
 =?Windows-1252?Q?sVrnsi0dlHp5oOMhDxCR1T79agT/rEhlr01/bwqoDmV0WBV//Tr7jdUO?=
 =?Windows-1252?Q?qoHHyn4YQrF3qUhxTNMwyT3ukamYJvYzH6KRTl8wZU7TJSLuBI20WQ4P?=
 =?Windows-1252?Q?hp4imwnl0igT5UPSVgRVixLtwMbU4T9jlymwMd7sPdJ20OsVVf+rNCRK?=
 =?Windows-1252?Q?UQt7iFc+h3PvkRFrBtqFLzV0siXdeGNmwGbYoY4bKaZxcxPk9qRNiK+L?=
 =?Windows-1252?Q?fA2DMoEwFPFMF1RAygEmb5Dy5h6VvnOgnKfX4ndBovq4UQ4aSG2mrOeI?=
 =?Windows-1252?Q?kwOKBYFFwwr6KMxDf3P9SkgSZ3fXbv7HrNirYsYITdPwTBgodBVXr8f4?=
 =?Windows-1252?Q?/peBZoQlVSqzZFcVTZWRvrOm+Iy160r9r3nE7LIkQbBodObVQfuvqtld?=
 =?Windows-1252?Q?uzcKdO1dmcpfD5KwmxpkDjs+kdK4UcRNadsIXu+cdOF+NbPG3ixiJd1o?=
 =?Windows-1252?Q?/4C8qczKAYUt41B4ONN738WcXyt+WnQNzWbsOS4QD82uI1aM280APjEK?=
 =?Windows-1252?Q?+PQ4eUmBbCPWVHWM6QxM8+nQXVnkYyPozpLv54VD6/km6fGEvzsau/yd?=
 =?Windows-1252?Q?5+RXkWSrtTTe4ZB3tD6X3Qb2sodr6do6JSexsLk0n5njmsEnKUwdcZwR?=
 =?Windows-1252?Q?nNPnvx2EALSLMrwCmwX2u4EkJSWbmXltTcRPsZhK28etgbxZ+n1Nun+R?=
 =?Windows-1252?Q?QuxBvthnFTj7XWB7btzxRt2GrVg=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR14MB4880.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 885e3262-d4f2-41ff-840f-08dd154e62f0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 17:00:56.7576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR14MB6766

Hello Git mailing list,=0A=
=0A=
I=92d like to propose a feature to allow users to modify the default merge =
commit message template generated by `git merge`. Currently, when running:=
=0A=
=0A=
```=0A=
git merge --no-ff upstream/main=0A=
```=0A=
=0A=
Git produces a message like:=0A=
```sh=0A=
Merge remote-tracking branch 'upstream/main' into my-branch=0A=
```=0A=
=0A=
While informative, this message can be verbose and sometimes makes branch n=
ames difficult to fit within the recommended 52-character first line. Perso=
nally, I find a simplified format like this more concise and effective:=0A=
```sh=0A=
Merge upstream/main into my-branch=0A=
```=0A=
=0A=
Proposal:=0A=
Introduce an option (e.g., a configuration setting or CLI flag) that allows=
 users to specify a custom merge commit message template. For example:=0A=
=0A=
- A new configuration option:=0A=
  ```sh=0A=
  [merge]=0A=
      messageTemplate =3D "Merge %s into %s"=0A=
  ```=0A=
  Here, `%s` placeholders could represent the source and destination branch=
es, respectively.=0A=
=0A=
- Alternatively, a command-line flag:=0A=
  ```sh=0A=
  git merge --message-template=3D"Merge %s into %s" upstream/main=0A=
  ```=0A=
=0A=
Looking forward to your thoughts.=0A=
=0A=
/k=
