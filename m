Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFBC1885B8
	for <git@vger.kernel.org>; Tue, 13 May 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139334; cv=fail; b=AJt5L1LW5YwiHm2VTNGl2oM9RqLQ3I/yuo1r3ZMCYR/CNx/SHZnCLPZKubyXJ1gm6Pam6euW5ro75saTixx/OhP4YT+ZNoS6NYymr2gcrZ5Tkj12JHjzkU+VuHteHPpCHBrEK4yfyrT8dJT5J6zIMdD9wg6XHKiQbyujHx1dv7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139334; c=relaxed/simple;
	bh=w1tEi/sEPN+iaw6ErTY7MDaCqvKoJSg5/XIEt9M9PSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhnu6Y6hcYw6UtgGyVhH9KFwP9+v8ZypG/WerxBLK5xwnh7hLe9cdz3M5AJeyO5C3f1KVo9khdcZEOGZqQrUrply/o+LbIEIjVcgs0cEvc7u+dpTkVqam2U6Z9EguBT8JKx8Ln0BBEMI2C6lmn/CV6FeO3pAYh9S5PjLU769ye4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=gfuT2oLA; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gfuT2oLA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0kcFR5jTikr/SdPIV9mW+xG7lEXNhjZB52d140/oHRubV2WtoKBRB7T/B+6A/3Np4dNRvE5H9dWNkQGBNZ0NGtDQWhFpBIKC/NMV8NrZ9Hzh9zZ7CaLRBc27i0WOL+9VbHgs8pRIwQ+Mf1SUOxXxSwFAA/gk4sgeD1OHJpmfBMhzjg+nDGxulgbuRqv2Q+sf6rFT6uJEYx9XmGTkm5aLc0CkKgKtMqKTm+qOKBMn3QbWXqb4oaJ1GDgXdwFZIOKz1x0Jm/13Zf+ufbLP6GbunQa6exH7umWnceLQh4bv3CgdqBHQQeh21mRpL0Qt3Ck6g+u4MI7uWhWnVvl5DvhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1tEi/sEPN+iaw6ErTY7MDaCqvKoJSg5/XIEt9M9PSU=;
 b=Plei13r4vsa0YHqE8n+EVcrv0LDsquBlFyioncZZ7YRmCVkjS8e2I3hF3toSlpdx0L90s/6zuZ5YV0sn496+eTiiL2+4M+QfI6QeAljVGlgEc1bAXPGH+8qjUNPZ4QpGSWTzDuZUBVYkuYP4n1yMMnZir7gxwllREeOhsma1OekDveUFxPtUAMCJZqcygDAlzv3gNr+G/T5GyJI3mx0tiKa0aTcx9//HUwB5xdiBo0nzsxLYDlS+dOvkVKO8xCi7SK14q/EtRHMoolEQdIB0T6AyI8geimt6p7P8JF+qiaoPahl28JnIXyMwukgXGYr9L/YMISXTEhcv6nRMPyqPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1tEi/sEPN+iaw6ErTY7MDaCqvKoJSg5/XIEt9M9PSU=;
 b=gfuT2oLAQUeohqIBKivhOdXOMLd1GJrk74fgf8zZXJeXIt1ddzeKAVayBL6kHLGY1xFV9ec5WCclxICRKN//TKUebCwBsHlelKt1bvqvdFfavo6MM+VInQlOgV3ZWDdeg69X2GI4NyA5zAeULecNI7fRYY3zG2WvaB5llNOabVpB5oVDpbWK+Q7XLiElTYOoITMvsyxmNHJQJjbZyyLesOtI5rS7itdMv51edqAW7Dz2URMadjX+k7ouTzpLYQOZdeptiIPZCfvI/2SoTLiq1MAj7jopjDY6cyPIHVG07WkZtMHeX3Qm32IwBXRWju27g0UBMVPBzedpUxGTb8tf0g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB5636.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:63::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 12:28:46 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 12:28:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Julian Swagemakers
	<julian@swagemakers.org>, "git@vger.kernel.org" <git@vger.kernel.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname --fqdn
 on Linux and macOS
Thread-Topic: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
Thread-Index:
 AQHbwX6JzjtAxyUkKkmtcSJbF/t7h7POoNeAgACV0XWAAAE4sIAADYacgAAZTYCAABOMoIABD+eM
Date: Tue, 13 May 2025 12:28:46 +0000
Message-ID:
 <PN3PR01MB9597CC4D8DB6946BEE9B0FB4B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org>	<xmqqa57hvl0f.fsf@gitster.g>
	<PN3PR01MB9597D7CAABB0EEE93A5CC490B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xi5u401.fsf@gitster.g>
	<CAPig+cQCpWhJoouuzZu9HPy7Fj-T5RcNnAqryxQ=ATn37Os49Q@mail.gmail.com>
 <xmqq1pstsi02.fsf@gitster.g>
In-Reply-To: <xmqq1pstsi02.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB5636:EE_
x-ms-office365-filtering-correlation-id: f8f9b645-d53e-4ed8-491e-08dd9219b51f
x-ms-exchange-slblob-mailprops:
 AlkLxVwsndlmbqnVVkeM2BobHaL9Maaav5ozjO+CI+DX9lZDnvEFD7eMWTH9tyV8hmZgEYoW65Fg+FiO0GCDES9xtcRbwEMrGqbbC6wIkvEuXaLOp4xVZt/mvj564oVK6KitmR6uesPP87dWY7qTBOyv4M0cT+RZI8q6KGjHrogM/7ERwqofQw7buGlQlNu8n4p6t/bLh9OW2SXAouyLMI86Ls0u0e8CdcXZW8KuZMzN8P24b8uLHX45sIdSD7N8ksDwfDzVIBJXoGnoWjhF7LGxO3vvD8MS8IPwtW8uEQ83bQGAP+vQBYGIKCG/U8zibuzKX+cPwHxdBCGTypdLtouQSUdC1rn8qGTs2Xyzd20tgNURiZluR1uhu3WhQYV1k8ekLkLM9xFv5184rMR0PH+AZK1eMagpj1qceUD1zXpyfGB7X5RYyMRqbtdtAFJ7a6vZ2+9hRk7ViahnuMwFksy4niJd3mDQCaX6J3PgegsKq+UTHrNOkFypTQt4C4uZC79tsOfDaBNee5nqxx9L2jz6JMHN0dqCqGWi8ZvzOynnuoeLEqsKQ0tSLPGM/cVxyeKAzuhjfJq9pMyooEmnT07E9fZaqna6JehHIZEvtFZo03SicdslPUPuTpvNnTiYh0fVizALEvFp5a0N/433jv9Nj68XcJkSpOl7C8Vz7ZG3L+lccnjd3BDfvmlFCTPLmVzIrA++6vhLjW3VhOKLDEu2TBSs9Hqhzz92V78DZwPPvbtyDmM1YzHya6NM11EBaq91tpXh0t9MQgbAfqdIZz00gIrOsx3A
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|6072599003|15080799009|8060799009|7092599006|19110799006|8062599006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2Z2K3dnUStJeDQ3emdUci90K2loYWpxMmxuckkvL2dJOFFORXZSVm1vek9B?=
 =?utf-8?B?OHZ2c2xoTTZEUXM0b3hnQm04akYzNTJTRHNXdk5LZE81aGowdWZaZkRhR1hI?=
 =?utf-8?B?Y0RnZDhnZnlMOHNCS3RKdEk4VVU0eGNGTlRZVy9YU0c3U1g3SnY3Wmc3Ym9a?=
 =?utf-8?B?T2t5QmgrOXQ0dm85cjdHMjhaWDlldmEzZnBKemhuRERGY1FzaDl3NTd0Tmcy?=
 =?utf-8?B?SVlTeXJDZkZxVnU3ZEp4T3BxMTIzM2NoSVhhVE9LT0J1dVF6ZjBCdmN4VU02?=
 =?utf-8?B?MHpUQ3ppaDBBRkhRTWN4Rm52Y2N6a1Ezak9EaXhoVU9iUzZkeGlXbkRRU2Vs?=
 =?utf-8?B?bG5oUnRDaEVITHE1RHR4YmlzODRIdVpwdXQvb3B2NE85K1dDcUxzVVVtcmhW?=
 =?utf-8?B?NDN0OHFibG5nRE53a1B0OUtBbWl0RWg0QUxXRngwVFNCZ3paKzhWODM3dVVk?=
 =?utf-8?B?UVc1OGNTNUxDUjVNUEFtcTd3b20zWm5IaE1VOVdDekNSTEE2Rnl2Wmp5WFhR?=
 =?utf-8?B?M2NTNnpIRk9wSW5HQzNiaWM3WmNpVmhoeXNta2h0Z0daM2dmWlBhTExEUER6?=
 =?utf-8?B?TUxiOXpFbXdoWWJHZEtvVUlSeGtYUFVjMkh2ZUJpNk5zVSs0cWE0S1l5WmpX?=
 =?utf-8?B?YUh1TjlKNkE3OVQ0WjluM1hzZXhpQzlsSlhaNXordTc3bE5xTE03c04relFK?=
 =?utf-8?B?SUlURTg0Sy9qRW1ta2tENzFmRC84S291Q3ZDdk02bVNVbkhYZkdYVDhid1Q3?=
 =?utf-8?B?aitXKzFVUk9zTHpBeGtYazloQitld0loeG9yYUtuZVljUGxFY01uMWNmMG5r?=
 =?utf-8?B?cDliRWFIbjRYYVFtbHpGZloxNXF1ckp0NnVZRGhiSnI2dVM4dTBUY3JBcVRP?=
 =?utf-8?B?NzUyd2VFN2VvNE1IQ1pFZVRvbGRHU1VneDdHZ3RMVVkvNUJPWmN1Rm00YWNm?=
 =?utf-8?B?SWJ2YUVHbXFFMGNwcE4zYmZDS2NQc003ZHl6cnEycDYvWU5SNlF4WGJUZlQ4?=
 =?utf-8?B?c29kWEYranlLbzRJSU1KbmJhSEU2VDFGQmRqSkpidi9DdnpZajIyK040MDVC?=
 =?utf-8?B?U1VPazM0Nk9EaXBsUTVGODhwenM4RzF4dmE1UThKU3NrK3ptN2RxZTlCQ2tF?=
 =?utf-8?B?U0JPRmgwbXB4MTdhOVk5Mis3VGRpTWtoMlltekZlNnBYZ0hZKysyQWVudGwz?=
 =?utf-8?B?cmQwbWtJN3Q3aHBEcjdoM0JDOGN5cnkwWE5MbEFmcitmZER4c3pmNHc3eTZT?=
 =?utf-8?B?Yi9ldytsUU5hZDBveWFDOWFsSnF1RXhlYzhkbUhMcWxBWnp2dDcwUkNJSGEw?=
 =?utf-8?B?b25ZS29OdVhlSVp0ZDJuYm5wbkNIZTgrMEx5UUkxYzV2b0NkS0VMRWlQWFBq?=
 =?utf-8?B?Skl1cDhRbWhtVjZiZS84YVBXaHBRVjNXZmt6cm1iWksxSUpGMG1zWjd3MzN5?=
 =?utf-8?B?d24xeXZRbldLdjl3eGIrZnk5ZS9GcjNRV2Y2SXdDL3d0bEJiK0x4UGVCVVNN?=
 =?utf-8?B?bG81d1F6UTZ3bjJGU3NpU2VsL1k1YlRvTVljM2xSV1FrU3lkYklZbEFvL0xL?=
 =?utf-8?B?TGxOQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STA5NzViTHVNR3hiV0VrdjFYT2dLaCtDNTk1UE90K04rMkQ0STRaRFg5TjNE?=
 =?utf-8?B?aHRFNGlVb283MDVhTVNtblZ0SmhObmErNjd5c01BTnFCeTh5TUY4RW5EZVFF?=
 =?utf-8?B?ODhReW9FRTZ3V3d2cnRUMHI3R2EvbjM5TGVJZjg3bkJZSUI5blhWQ1VPTkZm?=
 =?utf-8?B?Mk1rWlZUSnUvMFF5ZlJPUVNoQ20zcGJFV3NNazdvUit1b3gzZUUxSVlMWTVv?=
 =?utf-8?B?N2M4T3RqM2RFSEJ6Tm94dDNoeDkzcXBDM3hVY2VxRTlCWEErVS91Z3FkL2tU?=
 =?utf-8?B?ZjI4TDZOT1pGT29mUXpDSnpwNmJCcUZDUFVPeXNrdzZjZ2xBS2kvTCs2N1Rk?=
 =?utf-8?B?d0w5cm12amgvNG10WUd6UVppcGpidStyVnRKN1h5bW1KNXdsV0ZZVzFaTXBu?=
 =?utf-8?B?RVJ2Y2J6WmJVVS9rYmpvQUFXZEcxQlBId2RncW55QWxtamptU2hXSTZ4NkpC?=
 =?utf-8?B?ZHVnbEQxQ2VhM2NiWUh5WmhQSERGZUptb1Q1ZmM5b3J2cGlEVCs3NW91NlR4?=
 =?utf-8?B?OTBBWkhLcGJnV1VtVmdPUWcwS1RSRmpySnBiSW52bjJQN3dQcWxWdW1Nb0tz?=
 =?utf-8?B?ZHhJbTdHMzMvOUFjempPYUlMVEZXWTlWQ2NweEFhTWxuSW4wdTUzRXFDa3ZU?=
 =?utf-8?B?RWlHN1lHQ3VsNHVZMUxwS3QyMVowWEZFR2FGUDc5ZEZEVWxuUzFKT0M2MWNo?=
 =?utf-8?B?ZkQ5TVBIbXJKb0JRbitETkRmdFB2TDY0SlhHVnByNVA1SDdZNVZqV2grM3Z0?=
 =?utf-8?B?MC9oT29zUWQ0T0h5aFl2czE0NTFPcC8vbnhsUDExa2J0eFRpNSt4aU9QaFZN?=
 =?utf-8?B?T0V5dEtjSXJXdHZQRUZ3WTBId0xMMThZcEcvYmR4ck1FL2JQZnhxTkp0bFNS?=
 =?utf-8?B?dG50ZFhCYWhlQjlGL1U3WThuQ2t1TTFCbnBMUFVmc1luWjFSMzNWaHVsMFln?=
 =?utf-8?B?N2Y2cFpxb2t6dVl6NlVSdWZBaFNRZS91U1M4VzYrV2gyVzVheTQ2bjZvWWhR?=
 =?utf-8?B?OE1QQ3ZiSHdZWmlLYUJ5SDdxU0F4NXlMU01yTnFrS3k5MWllaHNiRHBQbVlP?=
 =?utf-8?B?ZlZDcE9oZWMySm45K1czWUxWV1Z6YldhMEZRalJrUkZTN0w2NkFYeCtjc0xo?=
 =?utf-8?B?QTlwRUxWdG5ocXd5Wnc0dXRMQXdUMzJTUUViY1Q1eU1RMlZnRGRnRnQyU0Qw?=
 =?utf-8?B?OVRGOGUxajlGTkYvaEdlYk0vcjRpUlo2Nk9pUjdSNFV6a2ttSWRkb281dXNF?=
 =?utf-8?B?Rm9nWDNWSkpqUHR2a2QvNTNpdFJ0TVIyZExtY0t0RE53cXB3NFdXb0JNZUVI?=
 =?utf-8?B?bzJ3MnFYTU5LM3l6WE1zblQ4cHZvU2lZL2hOQ0JrNWNPY3NlZ2Y4TWZWbzFY?=
 =?utf-8?B?bUVITVBXZGZJWFJRMWpGaFE2SEsvQm1idmU2Yi9UblAwUGthZjVzVWlwQ3hK?=
 =?utf-8?B?b0NOZCtsbnhRaU43UVRpSHhNelJhSjNEdHdlQjBodWR3RG1Ib1ZkYlUxMWps?=
 =?utf-8?B?aFBvY0MyaUtiVzkvWUxPRWFEOGNlOWEvVU1jSUVLWkNmV3hXcHpFZmZDMFNU?=
 =?utf-8?B?bmZoNEpIOUIyY3dGaTBob1lTQkR3QUtQZGZxOEd2Y3lEOW4wOHBmZE1FcmZL?=
 =?utf-8?Q?XdPLBzC4bmiwp5hyKUh0p7uysE/tHllK2EAENZ+nUlHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f9b645-d53e-4ed8-491e-08dd9219b51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 12:28:46.6440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5636

DQoNCj4gT24gMTMgTWF5IDIwMjUsIGF0IDE6NDXigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0VyaWMgU3Vuc2hpbmUgPHN1bnNoaW5lQHN1
bnNoaW5lY28uY29tPiB3cml0ZXM6DQo+IA0KPj4gVGhlIHByb2JsZW0gaXMgbm90IHJlc3RyaWN0
ZWQgb25seSB0byBtYWNPUyAoYW5kIEFscGluZSksIGJ1dCBtb3JlDQo+PiBnZW5lcmFsbHkgdG8g
YWxsIEJTRC1saW5lYWdlIGBob3N0bmFtZWAgd2hpY2ggZG9lcyBub3QgdW5kZXJzdGFuZA0KPj4g
LS1mcWRuIGJ1dCBkb2VzIHVuZGVyc3RhbmQgLWYuDQo+IA0KPiBUcnVlLCBidXQgdGhlIHByb3Bv
c2VkIHBhdGNoIGxpbWl0cyBpdHNlbGYgdG8NCj4gDQo+ICAgICAgJF5PIGVxICdsaW51eCcgfHwg
JF5PIGVxICdkYXJ3aW4nDQo+IA0KPiBmb3IgdW5mYXRob21hYmxlIHJlYXNvbiwgc28gQlNEJ3Mg
YXJlIHNhZmUgYWxyZWFkeSA7LSkNCg0KRXhhY3RseS4gSSBoYWQgdGVzdGVkIGhvc3RuYW1lIC1m
IG9uIGJvdGggbWFjT1MgYW5kIExpbnV4LCBidXQgd2FzIGxhenkNCmVub3VnaCB0byBub3QgY2hl
Y2sgLS1mcWRuLCB0aHVzIHJlc3VsdGluZyBpbiBhIHdyb25nIHBhdGNoLiB2MyBhbmQgdjQgc2hv
dWxkDQp3b3JrIHByb3Blcmx5LiBJJ2xsIGFsc28gYXZvaWQgbGF6aW5lc3MgaW4gdGhlIGZ1dHVy
ZS4=
