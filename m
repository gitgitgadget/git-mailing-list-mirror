Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010001.outbound.protection.outlook.com [52.103.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A01F462F
	for <git@vger.kernel.org>; Thu,  8 May 2025 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722343; cv=fail; b=E0Uys7WMGB/zW8kWmHUsw/3RRdGzztQEut0i+Wu2TLEgOxrMygSxFr9ZUSLAUqfwGoOh4hOCGKCWIZSdHnhpgPDsWJKcpjmHF9jA0p4j7ZjPsEFacNQx8lhFgvD+hyzhEmUa8qGC0j8QeeD9PzTGG02XPlX0sp27t44tfda3h9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722343; c=relaxed/simple;
	bh=2ax19lwcmxlmwdQo1MRmY2IcgzpjWoD9ixVrb4fXCUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WyHHZUlghl30aQ4qd6t5CFntWNMjlmJRtFPkNOSIKLfQR7R65q5KTgsD0KRabdbY8f14oK+LwW9thJyGTDhC8BDvwEPutfU+SOEMkLwzxusSeXEvessnVkzWi6k/dTiPmBpatvThswENHa2sVlyhQjwVBIBN7H+UhOmPL7PKpi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=huoNg3fb; arc=fail smtp.client-ip=52.103.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="huoNg3fb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeXjdWpTx3FeO63EarCm6OnzsCmn8YwuFhsWpoVhmkFjbyNe+IqW4r8iYwNeqwKqE03hPLQkxPOiW/dQQBX+MlAJ5L5Z2c5UX2DvI0B0T3ZhuRQnFhODSM0+O3q+eNmH97h/X9/MLM3mdl0S+G7KXe8b7B5auw58WuBrwIR2ClVCgLdaZEMqiNVtAS9LP9sjBRW3uSFYb4MRmqE4++uox/LzuF65n9pXgeDe99WHTDdVmGpQSjtlwMNSDvi8ppPWf25+5Ekn+SoCKd+CpEU5kbvAzuOEdUOBCPYvfoI7t3LvmU+dqca/UE6EyYP7j1jKzlcr4HFV3aOX56S5WEzHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ax19lwcmxlmwdQo1MRmY2IcgzpjWoD9ixVrb4fXCUg=;
 b=iXgk4LiyKNdaVhioN6VsXb4GSaz6JOwX5mOW8Zy86VKTRAkCQUAMhmX56qG0uUsxc7Z1DLD4Nc9ZmtkFTyqlZVkWDNPaqkv17sVJq6UiHhQ33BO6PoVkSqj7K1FDPb0J1GtwcY3rhzt9ISPvKZR/P1GuYMNLq++XefNnV0wHRzRpe+dLG5cexHnZ4QC5D1QqqSAFGFJ3quH0fGciwqOSNipR/ljAHjqxGQBC5ogOfmWe8HkXJ3JhSOXyhRr+soN04BCtWlI6GJLbAu1BhJdXQgYc4h82fZZ71MQ6tiUFJ1ERyvPf3+YCRcva8xbgWNDe7laGeEznFNSt+Y2le+2ILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ax19lwcmxlmwdQo1MRmY2IcgzpjWoD9ixVrb4fXCUg=;
 b=huoNg3fbSZT+uKMXU+svkCSzO+VDbZ6w7vkl53zbaOgQBIfDB3JTIhdFAlJpjatjSyS6ZaBq83zEwXTtcfBiUZOMM6ZJNrprFd8zHD//rjczK1zZolPpEwHzRRNac7zVKoS9qWGJjRaI1OrEYfBrUZHWeYKpDtQ0yPZBZlLX4kFTLL2RVn1D7iBEmO/4fG1AV2DZ4xY0omAHStmSV0nCiK2dgwo3QGEcw8TDAr4EutHXn8j5R5POkRVZP/rBeE0MUzVC8MvFqDZ5IH+s17kkDjsfqwWJ2NG5WWiStez56VOzvGcMRq/q/0ve8P+cZXOyYDbRArY/ks9JLvGEwOu4pg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7265.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:31::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 16:38:55 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 16:38:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Topic: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Index:
 AQHbv0zFVjfsAuRfzESA3EiZEdhM8rPHvkVHgABWFBmAAKjMt4AABR0DgAAqORmAAARKaw==
Date: Thu, 8 May 2025 16:38:55 +0000
Message-ID:
 <PN0PR01MB9588D6EE5C0719810B836463B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xicawp4.fsf@gitster.g>
	<PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqwmar8bw9.fsf@gitster.g>
	<PN3PR01MB95972BB022C2297D3E52DE78B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq7c2r6phg.fsf@gitster.g>
In-Reply-To: <xmqq7c2r6phg.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|MA0PR01MB7265:EE_
x-ms-office365-filtering-correlation-id: b6650caf-ba7d-4a0b-9727-08dd8e4ed2c8
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CoK2gWfPPgC1Jc+gPBRW6q3vzVm+YwUUPAQ0q9XhCj5C8rCIO74ysqKZ411yHCCKAJiAMFBaG2+hMFwoQzu2JeXqm1XVb1B1XyM0TIUPBuKpvaDCHNijhYH3P1agFmVqNPWFSBvJWEzAvWi2gWo8T9aTHD368KTOdQTecKWSJ4d+LI5NUQroV+3E3NtvK8bN6glszpWBCClIjRgFDEdg9b9a64266ofc4qZB7a3ANc3ONuyyPunsd7CIE+ZOcKFl/tl+GgQcez3n3QGuWMf6fU2D9cUCni4L/ThkxeC3wFE4tfsXiCk/yzcpMDxgqiVQ5IKOBJZCKTPjEDfxq4gouZlLopu/BKCLdyXkpmUijo9IvrI2uY1R/o+ESMZckeUZ+g2Zge1mNT+3XwL70ngpb5I+yxAC9pWMqD58HWYaWEusdTJ4G+lL7Z5prAFEo8x34J1eM5xa/wO+w/f0Ai4gq86aXr6Vk62/r85pJpY4GfLdEJFIQuT5j0O4rU6cxCWrkl6ImTMhQdlaCajK1WCOGzCxL0QycYhvPybaGlum85s2vhHP85Lfx94aMfY09agjLXVWE+C9zJcfe+eUi7NJPyfM3VbS1+4GilxeSyd4ewrzevqCuewyWTglJVJOhcdRX/s3yxLCH/+VE1P1/2r/TC1SAVh0VxJFWBRrp465iBcC5KbjEV9TZR2Jr9FVDRZ5gVl2bGh5RTggCkG8tRzmlPE1VZkTPbcg8
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|6072599003|8062599006|8060799009|15080799009|19110799006|12121999007|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXJkNTJYMmRQSnNCR2JCcFp5M2xwM2l4a0dET3ZmREx2YU9BZUJ2dmdXQ01W?=
 =?utf-8?B?Q0U4TkEySDhnRm8xYUpnV2RldVd2NGlHb0RuSC9oL2RXVW9mcmNJdHJZZ0VZ?=
 =?utf-8?B?NEZISFhEdW1lOTVueWQzZmYvbTI1QXNDZ1FxR2V5M2kyQlErdUJNa1l3K2FY?=
 =?utf-8?B?VUVURFBFMS9ZNndtZHlMazd6bWlkc3lJUklsNXRESzBpRDY1Z2tRYVJUTWpD?=
 =?utf-8?B?bWJTMTU2NnE0YkZlMkZzbEtkQUJNdjc0QllQRVg3aDk1YzdpNDFmY3A1aXYv?=
 =?utf-8?B?NDRoQ09nc0t6dFhDMGljd2tSMTJJWkk1b2RmWHgrUU9QQTVqclM2Z3YyTE4x?=
 =?utf-8?B?Y2RHSHhIWGlYQ2ZLSUlzcWhzUUp5WEMxMzNUbGExVk1UQSs1YnBqVktid1dT?=
 =?utf-8?B?eCtudDl5d05aREVnMjZEME5Kd3RGRmxCQVNiUzZiVkZMc3FNTlpFaXN0a0I4?=
 =?utf-8?B?bHpFdFdoSEdTS2lYMm9tUGxNa25qUUVMWXJXckJRY2JXL05WUGF1aUc1dTVq?=
 =?utf-8?B?OHNicG16M2tML1hNUjBpN3ZpSHUvdDRvUFVyQVFnT0JndlJ5YjJLMU1KaDc3?=
 =?utf-8?B?SHBQd0lIbWdYNzYrd3FXSTN4YVpjTkVUR2J1Wjd4Slhrd3FIVUtUSFNETHNM?=
 =?utf-8?B?WVB1cm5RemlkaW9TWnZUdm1EZWgvaUxITGIwMFpFV2I0Yk0wL0Vlc1Q1VEZG?=
 =?utf-8?B?cnlRaWZMZVA2NGFqaXJ0OUE2bTZodnBFMDc5TENCNGZKMW1aS0labElkeEdu?=
 =?utf-8?B?c0JMTWZBNzI3NE9kd28vaDkvWUhIQzRnWHZ0RXRudHk2ZXRTRnRGeExUalY3?=
 =?utf-8?B?RTJpQzFLTUo5dCt0ZUR1RExXQnV0QTEyK01hRXpyU2pzN0wvbVJnZGZPODRI?=
 =?utf-8?B?SmpqMWhNZER1MGl5cVZuRllRYjY3QiszSkZmc2dOdWNLQVBrZ3NOM044M0o3?=
 =?utf-8?B?QXY3azdMSUV0V3lodUNHK2szVlNQWis2MVRsdmNML1dtSHNzUG1uYnBSdE4r?=
 =?utf-8?B?QVZhYzFhY2cyWUNBS0xueWUwWFMrNEVtQVRwVDFybExEdXpZK0RFNVMrdm5z?=
 =?utf-8?B?TFZZZkdnM2tycWpicm50SDAwTkRMYWloSVEyRDNXNXpLUGc0WWE2YUhWMlNi?=
 =?utf-8?B?SFI3ZmU5ZXZRcE9mSmdaTkdaNEFzVm9xcVZUYjBaQkVCVDZuQVpzSzg2bk82?=
 =?utf-8?B?M2VGMTRjY3RLNjJEYVJJTm0xM2VFdHVLb2FOOG9jU1YyVWdFWXB2QlhIL1J3?=
 =?utf-8?B?dVRCTW5LeEg3K05PZnNPdmdjRU9WNThtbFlYK3lGMnRXQ2UwTXRTRjRUOHhs?=
 =?utf-8?B?SnlTK2JJakM5dzJKb24rN1UzWVozMG8vTkx1eWtySnFZd1NvQXFhbk9Zc2RY?=
 =?utf-8?B?ZHdzK3R4MzRLSnpMcjlZRFRMMEVhZkVoUzRLaG9UUjFHOU9rMjM1ZHNaTE5a?=
 =?utf-8?B?ekNTUVhIbEVSc1hyb1J4RzN3Mm1LNkYxMi9LQkR2U3lobGpiMW5pdHRDYmsv?=
 =?utf-8?B?OGRqcDRNUDRnUjVxZm1iRG1yU0REQ200NUphdkNWcTZWdVRZVUtmTnZuRFF4?=
 =?utf-8?Q?M6Aw3pAL+d6f/OUg3ultvseIQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUswL080d2VvbzBGaDlMT21iNzhQYVBKTCttMjA1VWkwNjNldXBOZ0M5T0Ir?=
 =?utf-8?B?UC9RTXc4SWdRbUNSbDRVa3R2RUpjWlNZSUtZOHFjSTE4RG9ya0dBRE4xL0Er?=
 =?utf-8?B?b1ArTndMTTA5TytJc3RRRjZqeGFkYmpUUjRvZlU0VjFySTk3NG5hbzlXbjRl?=
 =?utf-8?B?VmFCSXUvK0dNVlJURVFIWllxYTl5OXNOdWNGU3lkTTFqNlJORWczdnUrb2ZQ?=
 =?utf-8?B?cTdPVnhITzBaZmdMekltRjdEUW8xYjZyZHB6akEyQm1yMkVpTldoOWxVTmti?=
 =?utf-8?B?MktvemFLMUNlQ1BNSXc3RWlmV0lXUXE1blJLaW16SXZycmh4N2VYQjF0dk91?=
 =?utf-8?B?Y0dBSDdiM3JneS9iR1o3UnZoQ1pzYmh2S1F1b0p4QkgwQ2ZMTTU1WEJqNGJL?=
 =?utf-8?B?bFBaNWE1U05MY1NoR0xDLzZmTGN3a05VZkVadlVFMDBEdFZOLzFhU1g0aVpt?=
 =?utf-8?B?MnhmbVpBMFk5ak9zQ05RNWVlanVoYzd6M3grUWQ5S2tlcWwrRGF5TVJjNkwy?=
 =?utf-8?B?N1htWFFEUVlMNWR4WEF5cDdkOVQrWlJOakZ1THdUUFZrOTlUUW9OZ2FBRllP?=
 =?utf-8?B?dk01MFRhK29LNllOSVRnWDFzYUtpNlNiOUdDZzhmTUIvRnJzQ0NsQURidFBv?=
 =?utf-8?B?MnNoRWZ3clpER0VoUU4rRWxTT2xjL2ZHT1dKNXZhTVdXczlsNzdWZGNHaDcx?=
 =?utf-8?B?U3lWUWduYVJyMldVa281QmxNTExBZmhqRmxyVlB5MmloYUsvRDNYTTBhU1Fq?=
 =?utf-8?B?dEZ0RVBSUEl0QWd2eHQ4ci82WG0rSXFzdC9HTU01THZieHJEazRQUTVsMk5p?=
 =?utf-8?B?SW5yUURsaUlDTHZTMERVQkhCbzRlR3J2bmlwYjZvWlpGSTQ3UVFZdUUwZCti?=
 =?utf-8?B?NUV4UmQ5UHdrbm12dFZzTitKNGc2c1FhbWZQbWVEN0RPWXBSNGdGS1A0UGtt?=
 =?utf-8?B?VHlMUmk0UkZWOThrVVhUSVJpZ2h3djh6RTg0VHlrWlZrc3hIL0o1cmF5ZFEr?=
 =?utf-8?B?b0xlNlJaeHhRTzVLMWZ6WUkrV3ZCYmZMeUQrR0xKVDU2cHFYUU9OWjZlNFlY?=
 =?utf-8?B?bDUwUUhqaHJtOU4rZHBvM3NQTmpGUUNKdzYvdDBWcnFNTEtHMzZPR0NHaHc1?=
 =?utf-8?B?K1lBTkJnYXNjZkJScWJhN2VLT0VTUWtUamxqYlRBWDgzNllIVzZ6Vno3QkRx?=
 =?utf-8?B?N1dFcTRWcWxJWWxGQzM2bS9CSmhZNXE1Y0k0cUd6Z0JCTHMwbkZVZTR5N05w?=
 =?utf-8?B?R1Nnd3paTXAxRFpyRVNWTUZIQlVGekRuNTcwVjd1Z09IK0o2anRMeHdKQ0hY?=
 =?utf-8?B?dDlsYUpCaHZ6YUNXamtTQ2MvWmM3WFVqMTJSSnYyekZQMFdqK3c1cWJaM3hh?=
 =?utf-8?B?b1JRNEd4WkhSelJNcm5zc3hUN1RBTzVuYUdXdm9kdEtScktjd29ERjAzbXpa?=
 =?utf-8?B?eUQ2Vk5nZHh1ZGh3bEdXdFFkWVg2VG1ocDRaQlpGNmlYcEN2NFFYV3BPTERO?=
 =?utf-8?B?M3dsVG54UFlYVnV5dG5TU2p1RFBGYS9SVCs1RUhvS2Nvd3llajRpaGo4bGFX?=
 =?utf-8?B?azlNcVg0bFpmTzJkeWRteCthNDR3U2laSUlST0xBK1laRWgwQW5JU0xMT3pJ?=
 =?utf-8?B?dFBJQUJ1NXl2V2FYdHZBN1AvV20za2xvS1grREhQZWNVNWYxSlB1Y3BzR0xS?=
 =?utf-8?B?WHl0Q2w4UEwxUGIrNXlORkt5SFNlbWdiYi9HdFNaN3hTRmtvUUpjQzIvWlor?=
 =?utf-8?Q?fzJXsSYLedybSyhEU0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b6650caf-ba7d-4a0b-9727-08dd8e4ed2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 16:38:55.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7265

DQoNCj4gT24gOCBNYXkgMjAyNSwgYXQgOTo1M+KAr1BNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+PiAiSXMgdGhpcyBzb21ldGhpbmcgdGhlIGVuZC11c2Vy
IHdvdWxkIHR5cGUgdmVyYmF0aW0/IiBpcyB0aGUgY3JpdGVyaWEsDQo+PiANCj4+IFNvIHRoZSBl
bmQgdXNlciB3b24ndCB0eXBlIGl0LiBJdCdzIGp1c3QgYSBwYXRoIG9mIGEgZmlsZSB0byBiZSBl
ZGl0ZWQuDQo+PiBJZiB5b3Ugc3RpbGwgd2FudCB0byBjaGFuZ2UgaXQgdG8gYmFja3RpY2tzLCBJ
J2xsIGNoYW5nZSBpdC4gRG8gY29uZmlybSB0aGUgc2FtZSBidHcuDQo+PiANCj4+PiBub3QgIklz
IHRoaXMgYSBjb21tYW5kIG5hbWU/Ii4NCj4gDQo+IFRoZW4gcGVyaGFwcyAndHlwZScgLT4gJ3Vz
ZSc7IHRoZSBpZGVhIGlzIHRoZSBzYW1lLiAgQXJlIHdlIHNob3dpbmcNCj4gdGhlIGV4YWN0IGNv
bmNyZXRlIHRoaW5nIChlLmcuICJmaWxlIGF0IHRoaXMgcGF0aCwgd2hpY2ggeW91IHdvdWxkDQo+
IHNwZWxsIGBsaWtlIHNvYCIpIG9yIGEgY29uY2VwdCAoZS5nLiAicGVyLXVzZXIgY29uZmlndXJh
dGlvbiBmaWxlIik/DQo+IFRoZSBgbGl0ZXJhbGAgbWFyay11cCBpcyBmb3IgdGhlIGZvcm1lci4N
Cj4gDQo+PiBnaXQgc2VuZCBlbWFpbCBjYW4gdXNlIGFueSBzbXRwQXV0aCBtZXRob2QgdGhhdCBp
cyBzdXBwb3J0ZWQgYnkgQXV0aGVuOjpTQVNMDQo+PiBhbmQgdGhlIHNlcnZlci4gU28gdXNpbmcg
WE9BVVRIMiB3aXRoIGdtYWlsIHdpbGwgYWxzbyB3b3JrIGp1c3QgZmluZS4NCj4gDQo+IE9LLg0K
PiANCj4+IEFzIGZhciBhcyBnaXZpbmcgaW5mb3JtYXRpb24gYWJvdXQgc3VwcG9ydGVkIGF1dGhl
bnRpY2F0aW9uIG1ldGhvZHMgaXMgY29uY2VybmVkLA0KPj4gd2UgYXJlIHdyaXRpbmcgYW4gZXhh
bXBsZSwgbm90IGdpdmluZyBhIGRldGFpbGVkIGd1aWRlIHdpdGggdGhlIHByb3ZpZGVycyBkb2Nz
Lg0KPiANCj4gWWVzLCBidXQgZ2l2aW5nIGEgcGFzc2luZyBtZW50aW9uLCBsaWtlDQo+IA0KPiAg
ICBZb3UgY2FuIGFsc28gdXNlIE9BdXRoMi4wIGF1dGhlbnRpY2F0aW9uIHdpdGggR21haWwuICBF
ZGl0DQo+ICAgIGB+Ly5naXRjb25maWdgIGFuZCBzZXQgYHNlbmRlbWFpbC5zbXRwQXV0aCA9IE9B
VVRIQkVBUkVSYA0KPiAgICB0aGVyZSAodGhleSBzdXBwb3J0IGJvdGggWE9BVVRIMiBhbmQgT0FV
VEhCRUFSRVIsIGJ1dCB0aGUNCj4gICAgbGF0dGVyIGlzIG1vcmUgcmVjZW50IGFuZCBpbiB0aGUg
c3RhbmRhcmQpOg0KPiANCj4gICAgLS0tDQo+ICAgIC4uLiBleGFtcGxlIGhlcmUgLi4uDQo+ICAg
IC0tLSAgICANCj4gDQo+IHdvdWxkIG1ha2UgaXQgZWFzaWVyIHRvIHNlZSB0byB0aG9zZSB3aG8g
bGVhcm4gZnJvbSBlbHNld2hlcmUgdGhhdA0KPiB0aGV5IGNhbiB1c2UgdGhlaXIgZS1tYWlsIGNs
aWVudCAobm90IGBnaXQgc2VuZC1lbWFpbGApIHdpdGggR21haWwNCj4gd2l0aCBPQXV0aCwgY29t
ZSBoZXJlIGJlY2F1c2UgdGhleSB3YW50IHRvIHVzZSB0aGUgc2FtZSBhY2NvdW50IHdpdGgNCj4g
YGdpdCBzZW5kLWVtYWlsYCB0b28uICBJZiB0aGF0ICdlbHNld2hlcmUnIG9ubHkgbWVudGlvbmVk
IFhPQVVUSDIsDQo+IHdyaXRpbmcgc29tZXRoaW5nIGxpa2UgdGhlIGFib3ZlIHdvdWxkIGJlIG1v
cmUgaGVscGZ1bCB0aGFuIHVzaW5nDQo+IE9BVVRIQkVBUkVSIHdpdGhvdXQgbWVudGlvbmluZyBY
T0FVVEgyIGF0IGFsbCwgbm8/DQo+IA0KPj4gQWxzbywgYnkgdGhpcyBsb2dpYywgR21haWwgYWxz
byBzdXBwb3J0cyBzbXRwQXV0aD1MT0dJTiB3aXRoIGFwcCBwYXNzd29yZHMuDQo+IA0KPiBCdXQg
dGhlIHF1ZXN0aW9uIHdlIG5lZWQgdG8gYW5zd2VyIGlzOiBkb2VzIHRhbGtpbmcgYWJvdXQgaXQg
aGVscA0KPiB3aGVuIHBlb3BsZSB3YW50IHRvIGxlYXJuIGhvdyB0byB1c2UgT0F1dGgyLjAgaW5z
dGVhZCBvZiBwbGFpbg0KPiB2YW5pbGxhIHBhc3N3b3JkIGxvZ2luPyAgSSB0aGluayB0YWxraW5n
IGFib3V0IHNtdHBBdXRoPU9BVVRIQkVBUkVSDQo+IGFuZCBzbXRwQXV0aD1YT0FVVEgyIGRvZXMg
aGVscDsgZG9lcyB0YWxraW5nIGFib3V0IHNtdHBBdXRoPUxPR0lODQo+IGhlbHA/DQo+IA0KPiBT
bywgbm8sIExPR0lOIGlzIGlycmVsZXZhbnQsIGFuZCBJIGRvIG5vdCBxdWl0ZSBzZWUgdGhlIGFi
b3ZlIGFzDQo+IG1ha2luZyBhIG1lYW5pbmdmdWwgYW5hbG9neSAiYnkgdGhpcyBsb2dpYyIuDQo+
IA0KPj4gUGx1cywgYW55b25lIHJlYWRpbmcgdGhpcyBndWlkZSB3b3VsZCBtb3N0IGxpa2VseSBi
ZSBhIG5ld2JpZSwgd2hvIHdpbGwgYmUgbW9yZQ0KPj4gaW50ZXJlc3RlZCBpbiAiaG93IHRvIGdl
dCB0aGlzIHRoaW5nIHdvcmtpbmciIHRoYW4ga25vd2luZyAib2gsIEkgY2FuIHVzZSBYT0FVVEgy
DQo+PiBhcyB3ZWxsIGluIGdtYWlsIi4NCj4gDQo+IEkgYW0gc3VnZ2V0aW5nIHRoYXQgeW91IGNh
biBjYXRlciB0byBib3RoIG9mIHRoZW0gd2l0aCBtaW5pbXVtDQo+IGVmZm9ydC4gIEEgbmV3Ymll
IGNhbiBmYWxsIGludG8gdGhlIGxhdHRlciBjbGFzczsgdGhvc2Ugd2hvIHVzZWQNCj4gWE9BVVRI
MiB3aGVuIHNldHRpbmcgdXAgb3RoZXIgc29mdHdhcmUgKGhlbmNlIHRoZXkga25vdyBYT0FVVEgy
DQo+IHdvcmtzIHdpdGggR21haWwpIGJ1dCBkaWQgbm90IGtub3cgdGhhdCBPQVVUSEJFQVJFUiBh
bHNvIHdvcmtlZCBhcw0KPiB3ZWxsLg0KPiANCj4gVGhhbmtzLg0KDQoNCkFscmlnaHQuIEknbGwg
anVzdCBhZGQgc29tZSBkb2NzIHJlZ2FyZGluZyB0aGlzIHRoZW4=
