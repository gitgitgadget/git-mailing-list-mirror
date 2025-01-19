Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2017.outbound.protection.outlook.com [40.92.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21863D561
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737266172; cv=fail; b=O+swDEdROEHt6AI6nsrIh4UXkZOiE+CpoxP2eK9RaR7i8Bn71wAZpAXLeLr0u4f7sSRNB0HO/jsMurCI/Y2HRC7tbPkf5DNi3FAeX98a6rQ5VTjlmeF8ACdLgV7b1ihs9Y6xheGwPYPC8gFxPodqkCEuHLRe3JwtGuiDkvlBHFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737266172; c=relaxed/simple;
	bh=liQMlhDyUTMsU3I9CGVbVvy3vdxdXyXLjVrBVWsjU5c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bOK2AQoWuzuGyBwtWUHgHoKKxdbHnhURvRBWCbk940++zcO5KchQXsL807sVsLGTaaz35DWCDI0Xcu5XaMP9gX8JAkFJTlFQdd5Yn23WPNu9E4YrM5OsH0//OCuR9y6QHpbboY76bXGz8gJSIGtIfxxnFKT+ghNfhoiSWx2kNE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=ebqkocQ8; arc=fail smtp.client-ip=40.92.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="ebqkocQ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqh59RjZOXMC9CN/P2XOuocGg6BB1kuvB7fo4aT7AnKnJHFsX8vNa7Q8Saq+A9dSTH8nq1om0nQ9Lsr67JS+E7Ssx8Dx4aVQvZmh9J3EuyQoopiU/ELKlj/IHWH03TMt7mvE9IiX/qfhwXfs02eqWWJGirdR3/wyehCKa6ecUKXL3MprYiZeDIkiugu1RIdldAlnRkjlbujZZuaFVgxR0E+ymcH+HB6ONL3whyQtxGJXCG+7KVq6WMSnCVX82KLcChReCKzdo/6TL4sITePBoP9XMux5kIAY0/vb2F+5gRgwE7Aa/9qInwVNAAbUOFoY0RW99k/gqhWAA1XvM7Ba6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liQMlhDyUTMsU3I9CGVbVvy3vdxdXyXLjVrBVWsjU5c=;
 b=miE+cx1mgJGSxoNwURUhkUtTng/3CV0xxP+rvWEYx68SHDNYaLJq0RKXg6B4cMOTc6GzfoEAa4uUxShVXqruk08/aD08Yg+NJ40h0ZPwFnrrBq8ZGLFi7MUbHh8YGDG02Q9yFPZpKczTZzxUWxO6DLjnddoFgWijvLGVM2XQsMESmPqEnJX+oXpUNJU/8ousz15prtWJcM2WTf3GR0uQa4PL0LcgVV126+vDE+qOW/QQeNyY07/8sBOvRfuTbABgU9FAC1Usbm2NFV8NFs93F7laY0AaueVtKISfYW84s7GPJayyqeQC8KqPoV7h06mkVBjMI8ZFLQKUyLexINHJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liQMlhDyUTMsU3I9CGVbVvy3vdxdXyXLjVrBVWsjU5c=;
 b=ebqkocQ878zVAkxs7k+fXSFkTLI0EX5MiMzcUPp+Fu+bJ+14PvWemxwn/yP7m1Ie+4Byr8slir6t+DU8crls1W4SZkTnkLk7czXw56n7Hnxc7u9kCaplcmX0whO7VlLBDLGWOdyIThjbKpZ/IFoj6fptMoSdLVbPcjhWNj7yjYXQ1wOanyEa9ERAehXnD/mmC7cd8POzoSho9zc1xPCQkrqcCRfSsvuCAZbYjYMcplZSLsegyCYoe20ejZyA+BQZniHyTOUidpazF7QlSm4AKltV0H16FbKaZZB2/SVKgezIgueYH1JAnufm9fp0oUT6xqDeyhepFIlTuoEdd80LTw==
Received: from DB9P189MB1626.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2af::17)
 by AM7P189MB0599.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Sun, 19 Jan
 2025 05:56:07 +0000
Received: from DB9P189MB1626.EURP189.PROD.OUTLOOK.COM
 ([fe80::fee0:f77f:59de:8d75]) by DB9P189MB1626.EURP189.PROD.OUTLOOK.COM
 ([fe80::fee0:f77f:59de:8d75%4]) with mapi id 15.20.8356.017; Sun, 19 Jan 2025
 05:56:07 +0000
From: Andrew Farrow <awtplumbing_heating@hotmail.co.uk>
To: "junkio@cox.net" <junkio@cox.net>
CC: "ae@op5.se" <ae@op5.se>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Thread-Topic: [PATCH] git-diff: Introduce --index and deprecate --cached.
Thread-Index: AQHbajbV4Ku9D39eCUOUJPZ04THNkQ==
Date: Sun, 19 Jan 2025 05:56:07 +0000
Message-ID:
 <DB9P189MB162676A10E4DB28FF6A469A4D1E42@DB9P189MB1626.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P189MB1626:EE_|AM7P189MB0599:EE_
x-ms-office365-filtering-correlation-id: 235fe6cf-2919-4f8d-9f92-08dd384df7b9
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8062599003|8060799006|7092599003|19110799003|461199028|440099028|3412199025|102099032|4295299021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6eI/Y/nRKTllDICrqK7tbXImNOlsDC1pALX7N4GabUuoZ4u0ZNqjBubfGpw8?=
 =?us-ascii?Q?0tTTXdt7VV5K6Kr5rQzWyF9A/b32VtF5AddEoCPopaFs5t6RvkEAR03asVTK?=
 =?us-ascii?Q?oN2HOhAKqP8clwgxsKna7HkyG2h8T4vEuw+YwyhTuQfIUOZu+RE/QMW2GX6a?=
 =?us-ascii?Q?dB+YAiqEo8TP6tti6qQtjm1VLxyQ7adczQHcZGZHdK2XjIkVtuJrJarL+Evc?=
 =?us-ascii?Q?Kle6yFFOugfNpANF5Y9Sxnco/4IyLrzqPu2RAchX5Zn1jlAhXbSyvv0tmkqD?=
 =?us-ascii?Q?K4vTdLHPHp+N25vtdaWN/lBW++r3qGbtMTOHoHWuS9JrB9S0Kf3Of8B/23Kc?=
 =?us-ascii?Q?BHcaVQ2s+ewRLHERXlBgybZ18tnUdYCu2jpTF7nBJoEPVyAKhnSVeOlIRit+?=
 =?us-ascii?Q?zpw+LeeuZFsg7UOAucWmTg7QZz3VQUlF3mI4nfplHP8vVsnrg01wZi4rPFyd?=
 =?us-ascii?Q?IpfeJMrghBLW49Lv+UwmLjpavzpNT8fA4SnjI0J5ROc9R54U08EOqutD80kU?=
 =?us-ascii?Q?4LzolVCq3Z58F1cTtJShMUeSRVa0XEH/WfDgLAAtCpRqfsb4DA3IZ5D0Cw3X?=
 =?us-ascii?Q?Sszh2ZabuFnjCRo//BFoGqkopvjPyW+zwKvbozRJtc6XfR91cQhSFDHJe0Sl?=
 =?us-ascii?Q?8zgnOyTmZwNJxVF0beBBpA0e28qvec8vn7I4TCOC0Zvf0Z/LSXtnx1GyciWE?=
 =?us-ascii?Q?h5BE3kp7vEUQIVq4pmdjn8+nik5DuAo1l4+1athtEDo+u0PugK0Lb77zTuMo?=
 =?us-ascii?Q?1ncxCQWtu4uoAdtRTYIf9+b2MM8DCvELxcHo10o3SE2u0+Ltl914pNpWnggQ?=
 =?us-ascii?Q?iO3luDN+aOsx0A5OaxOKtHm8Xt1mXVIhmPWE2F76T2CPiGJkHrSfjjIYpnzn?=
 =?us-ascii?Q?N9uFeQRTxH7Ow/IvDwBzNzOEtuPzkIU+JTuZWfcnUwlI8C97zeSCzeFYnkbS?=
 =?us-ascii?Q?oOiflI91IzH+ULX5DTSNkRL1pBPa0Dslc0HI58EiPLdsccvv1UjYbc5PSk3q?=
 =?us-ascii?Q?H0sUTLPs2UxVc+ikn3a4f7ihcn9Q6k7DF6YTZmEB6zeX9KAimGYNgctU//OU?=
 =?us-ascii?Q?kSvlk6ftJ77MK2gc4tOKBHI7eLteGQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5Qc0eZBrdvBEXwMVp0xctTDauRzYEXwxy0xGdpJmAI2QWq/8mNDSqDcvlLzH?=
 =?us-ascii?Q?0Jh0rap1RC60RqW1TqqZszJ73SdpVgLd8NMSvCBqR2SUvmpeFfRTE4a15XGj?=
 =?us-ascii?Q?WKTZoFYCfMGzCtXgs4DTHPTJwy+iGtjSIL0zPSVZNMKFUOFIOHF8SdDjNdhL?=
 =?us-ascii?Q?jKUdnH8Hxzs+v7Vsv2Si0Q36vgunvin+pnvHDulKShZ4zqkj0K7BSA2Liqsq?=
 =?us-ascii?Q?V59bTMaXYSvgZJ1xS6bvaR9b94eg8d5YVH1Ua0tPGvdr9CkKL/WbvuAbsOXy?=
 =?us-ascii?Q?vMluoZWYwK+HFepokdm/8aR7MilCz2v2+ZW0nO4YuZASP5keHPOVZhrNFR/A?=
 =?us-ascii?Q?lqkqe+JU5+R1/kLQNNz7/sCFt0irzggc1kPPuOtZ08/xQhu/3QDdqKw+DJD9?=
 =?us-ascii?Q?DamGv1xUFnCPiuNXTQTmIT6yejLfvbAmjfeUM5Gu6NmIxe1q3O8hSmvY+kzR?=
 =?us-ascii?Q?hEvsytnrlWKV1nndEgKVDD2QVQgSCZF01pWh46proxdHslQEtM/V6dwyLBNz?=
 =?us-ascii?Q?J10NDzqlVWAtHR2bqMG9dT1KcizL7R+R+O2bmw2q8324KJDzmLi6xJPPm1C+?=
 =?us-ascii?Q?y5fPam9JAebImCE1ENdCnQ1dEEGpMyo6bVWcr4MzrYm4PONbL/1xyEn8hsAi?=
 =?us-ascii?Q?Dks9w3K9k5NYBLdKXe9mdCgNsbQ5Ln7Tc42PVlDvzgl5pynfjrcN55jGNM4O?=
 =?us-ascii?Q?dW+uQqcsoa20fwTABJsyLWx85GM74uZ2euB+PR28vUbjZceOi2bs/B/ykN0Z?=
 =?us-ascii?Q?bhYj9jMGg80U7n+ZlIM8xA/MOmt65itYs9/cxFaz61seeUvu3hMMnDgIjv93?=
 =?us-ascii?Q?Lbl+XkRHZHPNpelDSBFWhZJKpz7+rxAS3qCaP+FUvFUOVayCK6c/nqZs6r6X?=
 =?us-ascii?Q?4+B4kIFD51NtsvNMgJo2LtFEjbaI2eiGhgtvvFRSBhcp1ZVx//hT5TfFVz4H?=
 =?us-ascii?Q?hTFeGFD4fMWtEH71GEv2oP3sET4plYBzrELDNZ0a2sC708TS9T4ocExIl36C?=
 =?us-ascii?Q?T5YSdb4l24FkOJQEfTuvKwNtTl5SekJbIt2/2mueENpZ/kAko+UCwpqoDD6N?=
 =?us-ascii?Q?i/OpaVoZMuI0yzqLIfMGSphInhGyKnzwP8M1T78vOSqoVycGD6AAYpWBjQuy?=
 =?us-ascii?Q?OQt7ICVVc2CbUYtB/xrmzH0l+cvnIpVWGL6BRAmME3BrnpndFvABiNvVkT3P?=
 =?us-ascii?Q?60BwMVvlIiy+VnTIBEjzF2Jxt3fxwc0kOJjrx+TfcmHt9JhdsZixxtd4f15Y?=
 =?us-ascii?Q?KHEhlm9VwTZVVkW0q4hnIum4jElEfYKhsUr6aiCggg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID:
 <0B5DC378F4A5394A85658F2E0E7FBAC7@sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1626.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 235fe6cf-2919-4f8d-9f92-08dd384df7b9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2025 05:56:07.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0599


Andrew farrow=20

