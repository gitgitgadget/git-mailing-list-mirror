Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazolkn19011024.outbound.protection.outlook.com [52.103.74.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD618859B
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610714; cv=fail; b=O4hpALo+a24UkjCSE5/PfcFBcwlWBP5P9vPWZYrmn2DX2KTZ4S53lLjxPyOqYgeTrVJ28ZUEqkAEWBDofaM5wdowGc6eecViP/5yZi+v+jEHwv26nU2EjUtmbG1t2WJpdbBPqjt8/qMHCW0SbVfoO+57pKpufunTUaV8Nj74bl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610714; c=relaxed/simple;
	bh=cYRMOi9vk06xJ+mgfAwq1RedZkaxUg8OlsGrxWLsMz0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n7Rl8OG78YpROjFDjKN5c7XXSbLW5R7qK1Vz9J+gIMnsDDlk1cGF5yf0zaWtg04pa1xFzTF3E2jeq/T+xGwU23viIcfVC8XQLQs54mxBC2nCTsrDJLaJUZZfJYJJUr4ENTZtieYDWSC6ayJnGhyvgVVtEoY3/iMlUrNVxV+XldU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f2DSfbyY; arc=fail smtp.client-ip=52.103.74.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f2DSfbyY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1WH1izzc21O5sZBIDvzsh1eDB8hAMrr0FGM4/107ghYJodw6qtHz/CM1/LfadcFhmpggMps/1V9wT5MeR1jGZTDuUUmoc88cFhQgW6af2ECGka+aDfeAt8OHy2BTC5gIeQDUlIM9QVx1/myU82laKZLn8b6vcsA+JGnT99BPHVESD3Q/9U8niqf/KLdoepyG9t2oY7iMzSW+/WW9oSyQwbNmi9LsdLvlmoq2a0M749sXWveMr7fVPFOalnh3RhDA6OUqYjjf+ccRNeaktod283EHnWgh1CkKAeTKy7+2oB1juuNOtsgECg7e4GZS9H/wyLDg+429gGlfuzCf9cwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYRMOi9vk06xJ+mgfAwq1RedZkaxUg8OlsGrxWLsMz0=;
 b=jn2a16SAFTNE1Ab+olneLn5ocUTwmhQcHPOv4Y0Bs/w6IewzgycoyB/rY8K+sxSe1ML0beA2Jm3Jv2H+vQNm2nOI8jHz4P/k/M4CvD/wgltFSfbLTwDJf6nnPoMHsmaQbemIojt3654UwCNbg2RJ3FZhBaf7dQuccxTU9cLjGc55/QWW7Tmhk04Fpe/veYqr5XI4bTj8GcSLQcu/sSYyL70+rve3/vDRkdR2R7t34E9+79HeAYgH2MAkreyArlpXE2oTwC5kk2jWOO8y15vxytm5BzbHDLvt/iKTXOYMC4Ge9X2X1ZY225NlwUsve+YpDKIQUo9pD/X6e5T7U60Q/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYRMOi9vk06xJ+mgfAwq1RedZkaxUg8OlsGrxWLsMz0=;
 b=f2DSfbyYqR6cZNHJnK8j3tWu5jgHpeMeTdrXkgSUiziUG8cxwNQGVhM/tBVeG7Xt8ZbkPL8emmEGLEYmd2v5iuVW4nRXtia/vjRcNk4ul6jCL9G5XUku6ZU4HVm+K6AVtOAw79PAPgZx7OtcfAiKbSne0jqwUSGzN02V28ucqfotuAJmB3FzAyOMGzd8OPoJXS5XNDVrdBno1MjF4BBCMEy/Ck4T4ZexILR1JADfgQPojZoapvtNEkNe3lmwIjYfFTGYeLpCZPxY/4yqVx10HnV6mN39CwztJdnunXgbLvisTluC1tKcrOM1rckfW0kIIOhKNClrpGG2+OszGwoJjg==
Received: from SE1P216MB1319.KORP216.PROD.OUTLOOK.COM (2603:1096:101:b::11) by
 SL2P216MB3045.KORP216.PROD.OUTLOOK.COM (2603:1096:101:27f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Wed, 28 Jan 2026 14:31:50 +0000
Received: from SE1P216MB1319.KORP216.PROD.OUTLOOK.COM
 ([fe80::6717:af0e:30bd:11ee]) by SE1P216MB1319.KORP216.PROD.OUTLOOK.COM
 ([fe80::6717:af0e:30bd:11ee%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 14:31:50 +0000
From: Alexandra Deverick <Alexandra.Swapcard@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: HIMSS 2026 Leads list
Thread-Topic: HIMSS 2026 Leads list
Thread-Index:
 AdyKSvZmpK5JDv4mwUSOgulJL5C95wBYrOFAAAAADRAAAAAUoAAAABkAAAAAGWAAAAAcwAAAABqwAAAAJOAAAAAVcAAAABfQAAAAFjAAAAAW8AAAABYgAAAAGCAAAAAYsAAAABrgAAAAF0AAAAAYMAEs7i8g
Importance: high
X-Priority: 1
Date: Wed, 28 Jan 2026 14:31:37 +0000
Deferred-Delivery: Wed, 28 Jan 2026 14:22:00 +0000
Message-ID:
 <SE1P216MB1319035E7CD5ED9162CA61A29B91A@SE1P216MB1319.KORP216.PROD.OUTLOOK.COM>
References:
 <SE1P216MB131975C1C287B50A8D9DF0C99B97A@SE1P216MB1319.KORP216.PROD.OUTLOOK.COM>
In-Reply-To:
 <SE1P216MB131975C1C287B50A8D9DF0C99B97A@SE1P216MB1319.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1319:EE_|SL2P216MB3045:EE_
x-ms-office365-filtering-correlation-id: dd024395-bc53-4076-1708-08de5e79f9b7
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|39105399006|31061999003|8060799015|20031999003|12121999013|8062599012|19110799012|3412199025|440099028|30101999003|102099032|56899033|40105399003|17031999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0kVw4sXPhgcbQ+aYqdDVBafjWhZrV2jsuOwyEhOyh8Oq+P4BqSAko3daTvKK?=
 =?us-ascii?Q?EdxN7RuT1wISv3iw0FgqB2u4YJCqqb2gz0TM0Ua1nGotqXBNCFAGuLpqeW/K?=
 =?us-ascii?Q?OW30sMgc0msJjNYYmQvDxHF/yzD+oJSL4/RhszOZYLKPV4YikYXLMagp2Fkp?=
 =?us-ascii?Q?Asb5u9uhyMH/S6IUwfY6/CZxGyFKkz4u/I1wD1UMqT1zqJp5jscbAB2Jo3c3?=
 =?us-ascii?Q?PA5z2AUNG69qtbftgSSlHHNN0K16BQwKvOvfXHBaVLz80kTEtXc+qoi7i3LB?=
 =?us-ascii?Q?0QPs7rMrSVp4DpS9POADJy3P+azso6DQhZ+q9fYyP6rozYnHytbWAgYB35vP?=
 =?us-ascii?Q?aoW/ZkEudjI+muR/IJiFDdxRL1ACLHyVohSZjDTbZBbPxuOcIs9j/1xXfQIg?=
 =?us-ascii?Q?XXBCXqhVvqz9LeWxbeOJCBM5udgOfLUIuOdehDfdujjVNvGzr6EzemJwassF?=
 =?us-ascii?Q?SLFE/2cbGpMRa530OAT13dtShLY2bnsh7OEQl2ZOjNKlsuky46hF3ZOIQZQ8?=
 =?us-ascii?Q?DH4iqtLpGAA0HM7aRRVzQUy/bqUTJU8bwo7QFoO56U4V7XFCMWeoYTiAnX3G?=
 =?us-ascii?Q?AHhcW/o/MJnKyIsJ0LShn84EvQ3tOIxqJd1Z0dCCrsIklD4VyCPOvzzPVaoV?=
 =?us-ascii?Q?ONJQb7xQJ4SUI1KSvguju3M1nXKiGpyz8w6y4Eje49wd0acxej/sNHX5sDRo?=
 =?us-ascii?Q?6TgDqvwsKEia63XycSO3+CUJk2EgjHUGz+yS0ERrbLk18iPsbZESIOiSCLVP?=
 =?us-ascii?Q?W8igvMv9151yfoWgOJwL/sOxd8UwnOster4TsjVlfFHxb7LHOpQR1+eLLtB5?=
 =?us-ascii?Q?PYJJzTlyvG2sGUFe+KSPa0ZlFMCOq5G+vErOTKmVzKyLau/zz2XkYbIDO4hz?=
 =?us-ascii?Q?4WhMzRfG49/n+Lz5FJV8pseLFJEoJd+htGTQvpWfJ8Rom986Z+aFTMrGm1/C?=
 =?us-ascii?Q?AohkbzpJ5z4rYQKQ1kRJFTVJ0L+sJlsO+wF9nD+EXz1q3L0cT7+rfHQWyfu5?=
 =?us-ascii?Q?BnjyV8U5TJzb+IQqHpFtq0al6XFUIjXXQFYQtIoUMYJ7qPITAuppQXOIGqQX?=
 =?us-ascii?Q?GMNRoyWpQ3PT1c6+C0TEN7p5lE4t7ovyP7Wc3hSr9eKYMplppZL3YYeAczXc?=
 =?us-ascii?Q?WyYr01IlMzKFNVufBGs26b9ZsaOCX4QCFOs9rUr+UnTmnfNa0Fv3XIfZ/tKT?=
 =?us-ascii?Q?XJdnGCR2boPAYSVHV0FqOUWyqX3qlw/zQyq9HPxfY1mkkiKmdOVNkwnXc3Tx?=
 =?us-ascii?Q?2P82AUvszFOBYtZOCnSteqDACGres7mif9vvQNWgo9m/zIP0xhmIRN+adJ5v?=
 =?us-ascii?Q?Oe1jEJq3DhyvE6ItxGzhblCo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PP20KlUnQH1VQTrBAcrfKTOYREXAfZvrdsM275OVTAstSKtnOZ2UuinngHza?=
 =?us-ascii?Q?8o+3K2TmWBNchiV4zPhYC2+nmHQew8jMlWBeItP01tOg8L9PmHtGczhV5QH3?=
 =?us-ascii?Q?rXC+jyKhe9gURWABYCug1ZHtFhMQf2A+5kK5Om0DADEebS955CT4TSRxrlI6?=
 =?us-ascii?Q?t5TC6M2RKZZil0wjeLyZaVEc4Z0it62zpbD02OTSw0u4X7U5bpH+b5j+hjuf?=
 =?us-ascii?Q?LWDAaW1pVNRJitKTAXEI6LfSrJIt++vwV0V+xqdG/1dA0Lc5yqT5KEp9cLta?=
 =?us-ascii?Q?jFmgOlR+VZhul/8h9pv/1dxpDo+jnjPVKEeAx/sM/2pyQVfkHyl6lLvehfCf?=
 =?us-ascii?Q?E4ir9q9GzonIREy+HlU2UVWpu4nrBY8mtypqHlU5uHSP/zLKym15CsKlSe5f?=
 =?us-ascii?Q?pqL0Rmw4eco9VydMyESVDkBW2+PxwdYZ8xZaMLGXoTvlWbjsMrh2H7H6EZuY?=
 =?us-ascii?Q?Ui3aK760ziWYsA6kPFHTGm4mgzR9Z9L0UuKyB70aI+D1ygrKJ09d4D7Huy6E?=
 =?us-ascii?Q?EcCAiJpNzcbPeBJoDYTu6LuyIEXKJ4+zShsRCv8Dxka3jAW03ZDhgLr18Ilq?=
 =?us-ascii?Q?j+DJ6ZS7iP+dyk7qZxLOrbK/wUgvMFOeglANYAchXAC406iQD/35Vgcfhfag?=
 =?us-ascii?Q?wHEpPdRYm8Z8iHHaWU5EcH+s4s99v210WzY2kJKQzcjH15cmEfTH3RDIpA4e?=
 =?us-ascii?Q?dRBgNlWOkCMTNUy8iA3EkJoDOcMb4oYqcA+5NC4GWrfz6fwPNBUMvrIDoeBZ?=
 =?us-ascii?Q?ZzgaYDHWmueCND60jhQ2qLxzGw+artRYbCrjuOvWo86xl4CTAy8SZjweBjmJ?=
 =?us-ascii?Q?EptbemFWkVQuxrm2kyYU8MAntD+oxC/wtvYUQpugcuUH84WIzEuXm25ponwj?=
 =?us-ascii?Q?GPn4dp0zK1LH1DXRZLS5OAJlSLZ3pYurtATgXAufhSEaiuFIMn3ozrvBtKhf?=
 =?us-ascii?Q?72rem5O5+evoGHcLtNX8G95bbmh4u77a+dy7XLZCkLHW7savvAWS1JKw3uC3?=
 =?us-ascii?Q?LXA0loHX1yBg/YvjAV/68x26Dr8qlt2SAAPiEJ6hld2t3QRq/W8ALpzwI6vl?=
 =?us-ascii?Q?NqK3VcOmFTUYmsYUC3frJpgj3s6CzzoolH2wniB6VelC31IvTx8NCICU4vYC?=
 =?us-ascii?Q?U3taxIAVsIIS25MDsp4Ii93O/SoVc46pDKafMKybsPXC4XN/xYV5gQdNWbFQ?=
 =?us-ascii?Q?OBBYhPPoagXhMMpmWwRfXI7jgGL5PbcIDY/1sEbHajI8We5BBR3RKHpDAaGn?=
 =?us-ascii?Q?WYm9wBNXDkAwyc25hsSoQcJm6XoDT7ZhzuSHtXJ1ZY78Mb0ZJUXvZRik6NNf?=
 =?us-ascii?Q?hOkQnezpsxkzF+HGzt6W1zM8h9pzFImjWMpRmCEotcQiOEZtKBg6RRPQyCk3?=
 =?us-ascii?Q?5pD9Rs377E1cUiKd4vFNuee/iOvqGa5QUkRVtnnTsidCEdUgWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1319.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dd024395-bc53-4076-1708-08de5e79f9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 14:31:39.6553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB3045

Hi,

I wanted to follow up on my previous email regarding the visitors list.

If you need more info, just reply with "Send quote," and I'll be happy to a=
ssist.

Thank you,
Alexandra

-----Original Message-----
From: Alexandra Deverick=20
Sent: Thursday, January 22, 2026 9:46 AM
To: 'git@vger.kernel.org' <git@vger.kernel.org>
Subject: HIMSS 2026 Leads list
Importance: High

Hi there,

I wanted to check in to see if you'd be interested in purchasing the email =
list of attendees for HIMSS 2026 (Healthcare Information & Management Syste=
ms Society) at a discounted rate.

The list includes verified contacts of key attendees such as healthcare IT =
professionals, hospital executives, technology vendors, clinicians, and oth=
er industry leaders.

If this is of interest, simply reply with "Send price", and I'll share the =
details with you.

Thank you,
Alexandra Deverick | Event Manager
