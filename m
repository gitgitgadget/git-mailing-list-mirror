Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010005.outbound.protection.outlook.com [52.103.10.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B81D618A
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743108163; cv=fail; b=o2Q3F0fwEvnRe229iACHTf4CwzHbcZ+oeduK/nrBSumxaq0ArCbq1HjgiXLPR4bUIcDAjFed/mA/0zW3++it+ZyNTAuMJQ89xknKU8thB4buZ7ZjBp8/tkAK33KuOusdr1kkiKtGmg/w/T/e3WPfMNWaRenEo7KjB2Ak3CvmqS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743108163; c=relaxed/simple;
	bh=uAwoemH1mzPZr6DT7xAaDc8pp72gG06j+uNIGhPTIp4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iHVpFCiNpE0DxkOLsA3ifAx++8P0C+N4zQSr948EoJfAvk8YjqiktCkOibRTnrwYo1xe8oQawgY9dkcQ6AWI7+THAGdNbnnRGWijJD+Ns1ZHbVesYiDc2W7h9usaJZ8KtnY0eItb6v1KIsm4nSlYPxQIuI32ybeQrBfyHrYzag0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ay4negO4; arc=fail smtp.client-ip=52.103.10.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ay4negO4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0xhKLxXSyJWd1sD7S5uLv57Pw/dvf5TGukFhcJB5kcVV+OtskMxDjbA8PcSf0AeCf0KqrEjsoUf+NsSTOGEJ8kXp7R23EGo/u2WVojhqS9HAhhL27Dr1AUp6HQq+NJkY0JIzsWnDBK/4yRMhupNfSMH1YAihIlLHLtKM2HnlgSV/tNOAMvk+pLxZ9BKwLUFoxXxhf5INpOhotWJLsQh/KSGpF6PZoMqDM4zoWPN1bsVO3tGPyV2FTRlaIhFuyf5T5GNHny1yrmmhdyAeBJw0f55sKd0IXK5WPcyxV2WkVbhfg5Zt53QZPb8W8jGi0VK0SG0DnUT4/xMCgXL4X1KMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAwoemH1mzPZr6DT7xAaDc8pp72gG06j+uNIGhPTIp4=;
 b=SoMTYbNEHfpcClTpEOZ9siRZv3GZh2owr5MwIJC2E73J9PlEDIq3Rz/J0c47o9fdT3bHhTgTdRPWZ7TBt4e3BINvv3haIvK1y0W0ZwRz/wkg0ogie3XUK6VWEo7YiUrd4HcaREb1KJBgmjf//5kMM6aW45m0bRFizx9wToBfmiczR92AMVDEXLiJb6qMDreDx/P6laV+H/uqMO6cjQSlgaSAAVIVmSj/kqpMDWotu48PdW3cwVKUBltjTv+QGViLJ/E9DXWCSbnOEb51gmAMJiE2/jH/RxkSE+eZjJa2LF1HVgwcHV5GjFYYYB4WVvyfyAzJwmzgMXC0lkjpWKZHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAwoemH1mzPZr6DT7xAaDc8pp72gG06j+uNIGhPTIp4=;
 b=ay4negO4T+dOu/E0r5nQ3Pce/JiA3y4uOlANwAeyd/1Hjaw6UbKZ5dayD1fnsjDl4wOMOInMB0/ai6ZABKoDwsGBK9w3S8xbPwLn6Ue896WtdLnUaSz7i/k0HyET89bgW+vk8w99Upx5fat3fE84QkswTRwErbhTENAb0Vbri/44vaYktm3LpoM50auxBlFLwxjw640XGI2iE8dUD3/x85T/jrSEj/qavwx/KWORlc4xVEL9KgG5JVfsirGuMkKlYNvzVbAf0QImCb0xOcQuz4EuzrCSUAB48G0Qb8YNiy2UM7Zhqy1UkxwMjzTjL3P+D2Y9In2rJOANjdzCFSKOGw==
Received: from CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16)
 by BLAPR10MB4913.namprd10.prod.outlook.com (2603:10b6:208:307::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 20:42:39 +0000
Received: from CYYPR10MB7626.namprd10.prod.outlook.com
 ([fe80::1f45:68c9:6e75:8c]) by CYYPR10MB7626.namprd10.prod.outlook.com
 ([fe80::1f45:68c9:6e75:8c%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 20:42:39 +0000
From: Anna Lewis <anna.industryinsighthub@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Verified ISC West 2025 Attendee Data for Industry Professionals
Thread-Topic: Verified ISC West 2025 Attendee Data for Industry Professionals
Thread-Index: AdufIDHwOpUmSpO5SQWO4jtmyLUfkA==
Date: Thu, 27 Mar 2025 20:42:38 +0000
Message-ID:
 <CYYPR10MB76262D179B6ED318A2C94BBBF1A12@CYYPR10MB7626.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR10MB7626:EE_|BLAPR10MB4913:EE_
x-ms-office365-filtering-correlation-id: 7e74c780-ee9c-4c8b-12a1-08dd6d6fe9f0
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|8062599003|15080799006|461199028|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jZ4wDhLXIbN02/cAW7BRqykhaw+UViIUPVCSz5VZJYQ9yjKvai/GCeF4Um?=
 =?iso-8859-1?Q?3NwFRKqgkapUBqQpb7ziTUDVdrgS65fFLp8SlEd1//9o4aH3e0ZX03U9Ol?=
 =?iso-8859-1?Q?s4ziqDkBUE32c8aLnlRnp1WTg8ZpasWjJzAyppgwizUW5lA3pssgFRlNmX?=
 =?iso-8859-1?Q?ctj0FR5V511aybdw62gZ5LFp1XhsVnz+zAQ6kk6WqHE1oMXfHitfLQqNv0?=
 =?iso-8859-1?Q?Bu/6LGKymWIpUUg1UP/tqNz4i2/hHEuyQKEvaYiy/IqsjCf3LiM92kwYNR?=
 =?iso-8859-1?Q?1PoSBWLmElX1tyyHcRjrqyevdtK7O/VEAHWa0pynO7f07FMLiK9AvaYXTT?=
 =?iso-8859-1?Q?SaYH2HrFEL4HXWE39xhtlyIaL9tfa2sOjfHIbup44kzu5onHp1bhVrcyi/?=
 =?iso-8859-1?Q?t6sU41FzhiVmWyTl/6WQzstfEr8g6OTQaRaefZyVHXJO7PjfRJb7kwxkuu?=
 =?iso-8859-1?Q?IjbHry4WHeB2LrQx+gxiTfYLrP/LgKIiEW5GCgWY8IkkxG5CcmirEEu0bM?=
 =?iso-8859-1?Q?CtsACowXTF2xGDtWzyEFykT/Qfbz1eV6LXYjWRDx0xDGu2nKq7TJ4Wv5Lw?=
 =?iso-8859-1?Q?dpDOiP7TySleF/8QeTBSCzDFjcPKIOJyaWfB3o24VcWBpeodgW+YgnQ3wR?=
 =?iso-8859-1?Q?MKPg+jh1e5q6TX/j16Em7Q+qsgwbVVbmB+v3rEeP7g3DRKZzX7Ozlalb4J?=
 =?iso-8859-1?Q?6RLGjuc4lzBv5JHXK7F0aZ5QNm1SiLt5zIVPVDZGbMfEAUQca4C5pj9sGi?=
 =?iso-8859-1?Q?rJYpFt66WA2oUO0eihczfKr0Xdq6bpETVAP2m3cVAmzN89ZDRrRISxHekt?=
 =?iso-8859-1?Q?VKjCWXRMefhk+V38sezshvPn3A4YRxWrfZwKmnd0FCiFrxE6OoZFpPzmmG?=
 =?iso-8859-1?Q?yQANyTukF3Fv1gUKiJwKILaMnmPBdvBeBRx0fEBiN3tiilVIQAAy1OFE2t?=
 =?iso-8859-1?Q?sG0+ue+OQwI1lIz1UxUR5xJVHWxIJIU3V+GGpeD5DO/e5u18A/0TMoWUZS?=
 =?iso-8859-1?Q?pggbReO7oB1ETSS2HN08+TBkYZNsMRxsyaW5yrfrswXHMvZ8/9f8I1DHS2?=
 =?iso-8859-1?Q?wOhw3iBR6e+6TEEfny8WKsb/jK7IQBCThtI+ZZPBvPLWe3QrabCuryPz5J?=
 =?iso-8859-1?Q?8Zm4O/o4LQuUn++KeEsYAp3IL6gyp2znqyHHe/v7tdeD8OC8q4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VKKMvR9JiLHlH+awLBAO1S4/p6i6X467kPAW6oMcsbzARRdFYogqWp5zcN?=
 =?iso-8859-1?Q?e1q9n7iqysLGq4N6LuY1YKh2sp1obYB4PhNfOIou7HWJTy+nXsBqGieBMk?=
 =?iso-8859-1?Q?8SiKuAhpZFA+AiS6AqtrOaYlUk7Wk6C/Er/GZbrKscMBS2/DTWUCgudk9Y?=
 =?iso-8859-1?Q?r5NRzKME4J04QNYmKFAd2VGkZbqXuCzEVyxZhp3d/AccbTK00I2z5XPWnj?=
 =?iso-8859-1?Q?61WL7kip7SE4qNpkaUcU2Ndal8hKIdWXHuYHObFizxmTee6gcVh1tRVPHR?=
 =?iso-8859-1?Q?2IbCgFoJ1ffE9YuYhoRCzQve4z6JWW882oNryrP300r/y9qL23VPYiC2B7?=
 =?iso-8859-1?Q?ufzk3g/A1XWC7KisBcoXgv0tH9U0jSNN2Xmz6WNmBdQkmRd9qXSi7LKYLb?=
 =?iso-8859-1?Q?/Cz2Mi4OkDbpG749H5Es03fxdqg/3MAlQYreX4dZKT69Pcr4Qx2gFsGPr0?=
 =?iso-8859-1?Q?+n45HYUMuQdQVEK5dEX0iEXXbCnyDu9SBCpWVdC5rvAkzzVy3NZvH/tjgy?=
 =?iso-8859-1?Q?vxdBh1f5652Aqt3ZXuh15TTk/19wdv1EzDIe5VpxQWqGly7TMXlYeHBguO?=
 =?iso-8859-1?Q?hxeZo1CKNTnwqaYV3HJBZ6oHgiHfyaymhXnNuF0SjASobWlLCJTApGREaw?=
 =?iso-8859-1?Q?KII30GQSpUCgbA0IQhF6trBMMLiu3a+5Z4Ji/BTe9fn9qbEpi6E3ZnIs+T?=
 =?iso-8859-1?Q?U7C6SgGgenBAwP/FrOlS7KoBVhLGxnPm8ofl8JX6Hn+xrwEL//5W1Qx1YG?=
 =?iso-8859-1?Q?EDA1Gbp3gqX26a8f426FJUEW6Vi8EA4NFvknECVWgpxJsnAn1NHp8ER0jA?=
 =?iso-8859-1?Q?MyiNhGYco4L0RPK3EcxaUiDKyln2Mo7awZLYpwQJamXcO0Qo0D6getCdSg?=
 =?iso-8859-1?Q?0u17Dp96+cqxX3AOgrna4yy281Fw49pOdRehSET+h8t3Mh2pfU+SODGgq9?=
 =?iso-8859-1?Q?2v5M7nGKRP9Yb+PKKQmhW/UWGpLh/NbCa3N+DVOd6+kxh6xxwLQ4pxLXGK?=
 =?iso-8859-1?Q?BW/Hkj83DL5VsifpHK7DAU1HL0wrEZzUViC2EkRFgUFt15TfWUpRJfJaQy?=
 =?iso-8859-1?Q?DE6MLabQxojBQpqUVATj5lojRbwKHmqpGFr1DuMLiQOvyPMYryM1ERBFqI?=
 =?iso-8859-1?Q?WAuzHZxIu3Q1qrX4oybdYpM8N+1GLMAhvuReW88iaLXsCu5XtlHUoXj3l9?=
 =?iso-8859-1?Q?dihpqnjJg7oaFpHKXO9hXSnNr+Es7lNoP+XEmEuTHPhfpTbLI46KJU3ri2?=
 =?iso-8859-1?Q?gVAhc9XSupPrW7C7Cpo1J9O0EBbOfw85iDoTTXlSIvNRQ23JUSSrXZCkSJ?=
 =?iso-8859-1?Q?jLQQgYkWuF2tyqNZeI1Iu/Cd2ZxilvfPe//z+HeffYnnPlbET/P/lLQRKe?=
 =?iso-8859-1?Q?SsU0kX55v89p9zkTNGxTDd97PLwOs1/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR10MB7626.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e74c780-ee9c-4c8b-12a1-08dd6d6fe9f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 20:42:38.9863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4913

Hi ,
=A0
Are you planning to obtain the ICS West 2025 attendees list?
=A0
Expo Name: =A0International Security Conference & Exposition West 2025
Total Number of records: 23,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.
=A0
Would you like to move forward with buying these leads? I can provide the c=
ost if needed.
=A0
Keen to hear from you
=A0
Regards
Anna
Marketing Manager
Industry Insight Hub.,
=A0
Please reply with REMOVE if you don't wish to receive further emails
