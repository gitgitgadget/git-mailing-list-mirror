Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAB22B8C3
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562359; cv=fail; b=renYYws+KiN1LzbKaHNyKQ8BQRzMylyS+0djE+KHrb/Fup/bbrvEifSxvwQuXqS2qlRRppzHH2i9GNJUKgZnBLzxdRw8IguNGTWLXD1n6oRRXQwzTmekS5XXKR6gLFnaMwgq8MOhGQhK7RbWqwm81/LpN9zyXiCljc1vM9BF5XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562359; c=relaxed/simple;
	bh=bRSvsR0k2tKw72vomcDkAg9jU0Mb1nzjRk3jilo4rwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gCE2UT5d4OkCgvXPbxuxk6m+Sk8TNce6ok+oVfSq1nuK7yNIFYFc+9SrzEvcY6n7BY648ZAizHgS3pTZru3FGvLp72/Zc1pG+IltTNbulhjm3I3aRdSjSbbaJKiJaqd4SUuWBgj+ZI/6W5bZsr5DitgHJ441x1/Jayl3cA49ptE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kmKIth+v; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kmKIth+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eScnz4ZloauX5N2cBGyoDh+l3Tt6bzfLvrON6iCMbd2BrkNuq7uzbQK8JnWuoe30oP/XTDB4cBLP6DA96o4uoTUMEu7gu7ABDzGgNNrNzvmbkTvUqJhHDYSsvkkQP/3pj3hLA7hijbzHORwzEM4wuAu8o9vwD7Na8DaFfYbLJZNQgqLQtcALwTVJF+n2gOop50F35p2UNdM5C0SJl+hQqw1uy/IonEnM/vG6QQA0TM4ZBOKmDZNJJYyd+rVrgQfak8j828txJJrjLzY4YMr/59bgLpz4KMG0ghLD+tWNSNiwvTywNgL7ikJPO7ZaHOgq0G1Tp2yp5zN7KVK4eaoWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRSvsR0k2tKw72vomcDkAg9jU0Mb1nzjRk3jilo4rwM=;
 b=BkCNUIIcOWu3ZCECRpF80oQJQwYZ7x1RkvGrsXJk2udgjt/dyR02Q6sAZ54t01MfZwldK7RBLSyx5PJbgX8DZeuBMEceUVr+glr0NrnoA/cg1oZGcz4gdHc/gYAF34BI8PdwHHRw57ANFbTW3QRrd27jC00I4dd3a7trHfpBYCSWTZOCofHyrpzu43j4aJ1VKUi9v+2oWca/k0ZUSBlntaaCetzE/y5gbj2PFJeHWf3+SfKhYKMCCrLKUC0TKbys4zz56xj0ZnYNhtxSKLdhTIPr0yQyW/kHoqoaWA60T4NQTaJ8Q5Qg7OP+Ekq4WFu5N/KG2sjNbF/NtLvQykzq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRSvsR0k2tKw72vomcDkAg9jU0Mb1nzjRk3jilo4rwM=;
 b=kmKIth+vKrgFEv+o6PzMA34TwuIkdgon013QwVhGRGoRRxPTCHTIGeOkLMIiY3Ti9f9aKlaCegrPegMEQwF71fnKJyvcTpv++OvATQS8vE1pJv+uKkxSeNBHA8kfjHDOqZSXD0S639/ygmDnlWbZlPWIsTOSaX1SFlBmmUHyNVjUlN0OiZQlKqWmEvuBEbythfR0yM1GLh1GE5ue/8WntxPz2ElfyYcS3EkFbZbT3xUhm2N3JYGblV8EPC4PwAFXOvKkK2RcKGs9trE7I89jjBydU5G+RCTyfDyWx6W/66tqDYYiSwakfHqiJonhbP3GQ4JIEOLFtbuZT3zzboPisQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PR01MB4385.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 06:25:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 06:25:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>
CC: Erik Huelsmann <ehuels@gmail.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, M Hickford
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Shengyu Qu <wiagn233@outlook.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
Thread-Topic: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
Thread-Index: AQHbtO6OuPJSwyhjvkapqu3HgGmPa7OzHjUAgAADuYCAAMg4AIAAAcVS
Date: Fri, 25 Apr 2025 06:25:52 +0000
Message-ID:
 <PN3PR01MB95978F0006C7F99AC4560973B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <CACOoB6jE=DgpYYaudhqTVDRd2SCz++aog7QYwTQs6-MAD8dBuw@mail.gmail.com>
 <PN3PR01MB9597922F495805CA728A0B31B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <D9FI2S0NSC40.28VZMYOR6M8DO@swagemakers.org>
In-Reply-To: <D9FI2S0NSC40.28VZMYOR6M8DO@swagemakers.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PR01MB4385:EE_
x-ms-office365-filtering-correlation-id: 863f8047-1b05-4eda-19ec-08dd83c2073a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|15080799006|8062599003|7092599003|19110799003|6072599003|440099028|3412199025|41001999003|19111999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?enhtRXo4TjV3eFF1MFZZMkhSUWhqay84TlQwWllMemkwaEVWdmhOcEhBUUFE?=
 =?utf-8?B?LzVoRTdSaVlmTlVzbDArYnF0NUZXQ3kreE94cEF4cXhjQlFKMWd1clFpWHFD?=
 =?utf-8?B?OERhNlhKV3UzeVhtNHBkUHpGeDBNSEg4UWcxUGZYSCtET1Fxb3J1cTdMQ3Bm?=
 =?utf-8?B?OVlHS3ZHNVNrN2QyTUNTMVBrT3h3MmQxaDRMSTgvY3dWQStrQmg3ZFpUZUNn?=
 =?utf-8?B?Sy9FSnAxUmY4VFFJVGI3L09nelNuWXpSNVdzcGpQM3EyYVdtSlVoU0krUEU2?=
 =?utf-8?B?SjNNNVdyYS9SMWdjVU5md0kvMWZNSGpaaENaTUJNa2NleDZCaXFTWmtLT2Jw?=
 =?utf-8?B?ekV2aEh6T3VOYnEvSUR0RmpuZVZXK3k4NGtCR210K2YxWGFWQUhFVDkzcnkw?=
 =?utf-8?B?SU1UOGVMQmJHUlltWSttRkpDRW16UVVmSVNwUDZjQUtITWdpNzhaVjVQVUFW?=
 =?utf-8?B?RUlqZkZhK3hZSHJ0Z1Z1bFJnSVBwVmJSeTJZazVxbk9ZYnRJdkRrTW8yNDFn?=
 =?utf-8?B?aDhCaW5uUzlLcnY5VzYxSVdsZk8xcHFPYmFvNE4xVGFHYWgrd0tPZHZwU01W?=
 =?utf-8?B?NDRoZ3VDOU9GeDE3WlI4Q25aTGNOSXFyY285aytsYmNhM2c0UFVmY0RRaDNC?=
 =?utf-8?B?RkdldGlPOTNIY3pYWmFGUjBDVDBDbXlxWXVxNnhoYVVoRmU0MTBFajBEZTVQ?=
 =?utf-8?B?WDIxVzZ1WjlUSVhNMHdmQzFuZHFRVlVKSHdySmVFbFRmbUdMWm5Ka2pyZG1u?=
 =?utf-8?B?WEZWV09MMHlhbWhUM1l0ZU11NmRFbUViYWJnR25qU3YyNlRMUG1Ba1hua3Fs?=
 =?utf-8?B?Y2R4V2UyRzdBMTFkeEZrak01ZnU5amJCMjAvY3czWEZlNG9ibG9wMy81Qnlt?=
 =?utf-8?B?L2tZbVdYOWJRbUtpeHFTQjdJWTZJc3RBN0h6MUtMRWFrOFpZVmFpaTM4M3JW?=
 =?utf-8?B?MFVpOWdCVm9xL2E2UVZMZFVrMSsxWG1uUEZGRmcrUHFGLzQ4QUlPcUNrblY2?=
 =?utf-8?B?eWhaY2JZZUlQV05OTVdkcUZEWFVpejVwT0ZXOG83dkpIZnN4d1JsWjlvWUF3?=
 =?utf-8?B?b0FRZDVSTWxJeUF2UHBObTBJUHJ4ZmZDL0pMUDVQSC9Ga2FOZG1CdE9KWWFq?=
 =?utf-8?B?OGxnSS9KZXNrMERMSlMweit0cXRGRVhjWVdURUFFL3h3MEJ2bTNKU0FOVUZs?=
 =?utf-8?B?UEFHUmtVTE9LUjhMelR6OUs5TjRrelV5RnRFbGZwdGtPSmRNTHBEc3FoOU1k?=
 =?utf-8?B?ZkRzR0NTeXFiS3IrVnVIazdCSjJxZXVlUmtFTEhvQ1gzaWxHSjNkajlPWmhv?=
 =?utf-8?B?SVNaTGg0NFRVQjRFVkdpcU56WS9QNis4T0VLOEdranpTNW85d2VpY1lTcGxu?=
 =?utf-8?B?cE4vbS9mbVFPbUlTbnJLOWdmNDE3eE1qOVB4NXFYVk1ENlF3U1pHcWtIdUxD?=
 =?utf-8?B?anZ5UGRxZnd0QlBvMDhyd2VtVGRjLzVvZ3ZLZ3RrbWRRSDFwTU95b3gxaUh6?=
 =?utf-8?B?bnZRWUJEajZ0c3pOcW9NWldwMnYyRjg3dUdqVjA1dk5SWklYd0ZCcDlNcTE3?=
 =?utf-8?B?M2FiNml2TnVPTzZjamtBL21jRXpQK1VDRGZ3eEQ2cmo2RzFTNkVkK3Q3WGpr?=
 =?utf-8?B?MVJkUWRBeGlVVWF0ZGg1d0JmREJpU0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXEwTmFRYWhJVFJhOU9TSzZLMWJ1S05hend3V2Z5TzZLWVNoTTZyMzBsQlZN?=
 =?utf-8?B?SkFsTWZ5bVJoNWpDdHpqY3VIYnNmNzNrYmZNQnlKR3pGQVAycnZTNUhhbDJX?=
 =?utf-8?B?Y25CbDJlSXovTVJnbW12dlZ0QlVVbXYreHIzRlBvRkh5V0l0aUtyN3hEQkJP?=
 =?utf-8?B?ZkxPQnpxamFDT1RSSnBlbkVyZTRXYU95dENqY282NTdiaTBXTzNKQUhNRXVR?=
 =?utf-8?B?NlNyMzhJemVWbWExYzJFdGowL3lFRUcyb1Z4OW5TMUs1ODAvb0kweGh1SU56?=
 =?utf-8?B?UE1kc0l1bjVwc3JLMnJKbjNIWld4UlY2dXNuczBrcTRLSEdyVFdPaXZLSXRX?=
 =?utf-8?B?RW8vVHNtRFRIN0ZOUHFEV0t0eVZZeTVnWGlHNnVyOWxZbDZtV2syVmE0WWFU?=
 =?utf-8?B?MzBaTzBXOXhZS3l5cENhL3ZQRGlnRW1nWVRkS2NLcG1EbDBiSXh1OWxMQ3ZV?=
 =?utf-8?B?Yzd6RTRMWjIyL2dwYmxlbHJFcWJNR0VNaGZMOXpVTllQQVZ5bzM4WVhFK0Vp?=
 =?utf-8?B?UWd6OEFOVW9XYzR5bEVoOTNxUVAxQWM1T0VJazliMksvcHdWdmxmMlorWmhr?=
 =?utf-8?B?eXRCemhiNHNnQm9YYkZPYmZYMi85SXhQUVl5UTlDTld2dXlSMG41a0NzYnh0?=
 =?utf-8?B?cWltUGtoRkU4eFdGMEtIbVFXU25KOUlBK0FFRWd0SFp3M0dSUVc5UXozRW91?=
 =?utf-8?B?bGFDRmRLUWkvZ01mbEJZK2hSa3hNVWZPR1JVTVRUTFovcjJYN3QwU3h3TWt6?=
 =?utf-8?B?M3ZnL0IxOVBqUGVQQ0hsREFMSXNqZFpIZjBpMjdFWG9Wa3dHZTBVODRHbzI5?=
 =?utf-8?B?NC8rQldDZW56ZGhGczVXb2l3U2JtNDBuU2JyZ0R2UEhrSjNiVnV5clZ2VjAv?=
 =?utf-8?B?NzlSblQ5WDBPUUtsaytGTnFDam5ZaHh3aDBoOXJWNmozNGp4STJMMlNsYjhO?=
 =?utf-8?B?SlhKclc0ek43K3ZQRlpRZFdiVW5Ca2U5bnZEQXdRcnluUzJWR0FJaDBUdjhk?=
 =?utf-8?B?VTFPTlVUaEdWTnZ2cmwzUkU5NEZYay9iZUlVM2R0Q1JoeE5ab0pSdVhMN2lP?=
 =?utf-8?B?bHlmNDJlTnkyMnZnSmJsY0dtejB5TFhtbFlsWkE2eHRRUndROUtMc1ZpSnU5?=
 =?utf-8?B?RWJKSnpRZ2pYQmpGbG44cmtCalZDMEVGMjl1U2tiamt5Z0d1ZDBGeHYrK1VL?=
 =?utf-8?B?bkRZS1NvTldEd2VsRkt3bjFnM0dLak51NHFPRWxyTGJaVWRmOXdOSDBmRnlN?=
 =?utf-8?B?OGZ3YjJPYmR0dWRwbXllR21RaHBqU2lTR0FSdGlNTXAwNExNdzN5SHl5RG1t?=
 =?utf-8?B?cXRYVm5LRDBScGdKMWd6djRtN2thNEVMcmdCZEU2ak9NU09YdStUS3NJUDlo?=
 =?utf-8?B?QzF5ejRjRStYUUZaTy9vYTlXTE9MZnFkalV2MlNvZG9TNDFkUTlvMUsyaWtN?=
 =?utf-8?B?QVBOSk0vUEdUVHc0R1ZKdXpDQ0wvaGR1YTRhS2F4OHBvUkZaRlZ6Lzd1NmUy?=
 =?utf-8?B?dDM3NkZFNHN5OWRPc09UNEFtZDZtSklDRUkzSTgzYUN4cUppTmJ2OFlBSkdO?=
 =?utf-8?B?Y2FTemFzQUQ5UmoxNkp2azRScEphdHVuOUdsZExXc0dxZDNvUEppais2ajNP?=
 =?utf-8?Q?oRGa4I1nScY/L9LLfF2QSjxU7clTU4KwlQlNLo7a7fag=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 863f8047-1b05-4eda-19ec-08dd83c2073a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 06:25:52.4083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4385

DQpIaSBKdWxpYW4NCg0KPiBPbiAyNSBBcHIgMjAyNSwgYXQgMTE6NDnigK9BTSwgSnVsaWFuIFN3
YWdlbWFrZXJzIDxqdWxpYW5Ac3dhZ2VtYWtlcnMub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFRo
dSBBcHIgMjQsIDIwMjUgYXQgODoyMiBQTSBDRVNULCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+IEkg
c2F3IHRoZSBjb2RlIG9mIHBlcmwtYXV0aGVuLXNhc2wgYW5kIEkgbWlzZXJhYmx5IGZhaWxlZCBp
biBwb3J0aW5nDQo+PiB0aGUgbG9naWMgdXNlZCBoZXJlIHRvIHRoZSByZXBvLg0KPj4gDQo+PiBQ
ZXJsIGlzIG5vdCBzb21ldGhpbmcgSSBhbSB2ZXJ5IHN0cm9uZyBhdCwgc28gbm90IHJlYWxseSBm
ZWFzaWJsZSBmb3INCj4+IG1lIHRvIHdvcmsgYWhlYWQuIEkgZG8gd2FzIGFibGUgdG8gcmV0dXJu
IHRoZSBmb3JtYXR0ZWQgYmFzZTY0IGVuY29kZWQNCj4+IHN0cmluZyBhcyBwZXIgdGhlIGxvZ2lj
LCBidXQgc3RpbGwgSSBnb3QgYXV0aGVudGljYXRpb24gaXNzdWVzLg0KPj4gQ3VycmVudGx5IEkg
YWltIHRvIGhhdmUgZ2l0LXNlbmQtZW1haWwgd29ya2luZywgYW5kIGEgcmV2aWV3IGZyb20gYW4N
Cj4+IGV4cGVyaWVuY2VkIHBlcnNvbiBpcyBuZWVkZWQuDQo+PiANCj4+IEkgd291bGQgYmUgaGFw
cHkgdG8gYmUgYWJsZSB0byB0ZXN0IGFueSBwcm9wb3NlZCBwYXRjaCB0aG91Z2guDQo+PiANCj4+
IEp1bGlhbiwgeW91IG1pZ2h0IGJlIGludGVyZXN0ZWQgaGVyZT8NCj4gDQo+IEkgZmVhciBJJ20g
YWxzbyBhIHJvb2tpZSB3aGVuIGl0IGNvbWVzIHRvIHBlcmwsIGJ1dCB3aXRoIHlvdXIgY29kZSBh
bmQNCj4gdGhlIGNvbW1lbnQgZnJvbSBFcmlrIEkgbWFuYWdlZCB0byBnZXQgaXQgd29ya2luZy4g
Y2xpZW50X3N0YXJ0IGFuZA0KPiBjbGllbnRfc3RlcCBoYXZlIHRvIGxvb2sgbGlrZSB0aGlzOg0K
PiANCj4gc3ViIGNsaWVudF9zdGFydCB7DQo+ICAgIG15ICRzZWxmID0gc2hpZnQ7DQo+ICAgICRz
ZWxmLT57c3RhZ2V9ID0gMDsNCj4gICAgIyBHZW5lcmF0ZSB0aGUgWE9BVVRIMiBhdXRoZW50aWNh
dGlvbiBzdHJpbmcNCj4gICAgbXkgJHVzZXJuYW1lID0gJHNlbGYtPl9jYWxsKCd1c2VyJyk7DQo+
ICAgIG15ICR0b2tlbiAgICA9ICRzZWxmLT5fY2FsbCgncGFzcycpOyAjIE9BdXRoIDIuMCBhY2Nl
c3MgdG9rZW4NCj4gICAgbXkgJGF1dGhfc3RyaW5nID0gInVzZXI9JHVzZXJuYW1lXDAwMWF1dGg9
QmVhcmVyICR0b2tlblwwMDFcMDAxIjsNCj4gICAgcmV0dXJuICRhdXRoX3N0cmluZw0KPiB9DQo+
IA0KPiBzdWIgY2xpZW50X3N0ZXAgew0KPiAgICBteSAoJHNlbGYsICRjaGFsbGVuZ2UpID0gQF87
DQo+IA0KPiAgICBteSAkc3RhZ2UgPSArKyRzZWxmLT57c3RhZ2V9Ow0KPiANCj4gICAgaWYgKCRz
dGFnZSA9PSAxKSB7DQo+ICAgICAgICAjIEhhbmRsZSBhdXRoZW50aWNhdGlvbiBmYWlsdXJlIGJ5
IHNlbmRpbmcgYSBkdW1teSByZXF1ZXN0DQo+ICAgICAgICByZXR1cm4gIlwwMDEiDQo+ICAgIH0g
ZWxzZSB7DQo+ICAgICAgICByZXR1cm4gJHNlbGYtPnNldF9lcnJvcigiSW52YWxpZCBzZXF1ZW5j
ZSIpOw0KPiAgICB9DQo+IH0NCj4gDQo+IEFkaXR5YSwgZG8geW91IHdhbnQgdG8gY3JlYXRlIGEg
cHVsbCByZXF1ZXN0IG9uIHBlcmwtYXV0aGVuLXNhc2wsIG9yDQo+IHNob3VsZCBJPw0KDQpJJ2xs
IGRvIHNvbWUgdGVzdHMgb24gbXkgZW5kIHRoZW4gSSBjYW4gb3BlbiBhIFBSLiBJZiBJIGZhY2Ug
aXNzdWVzLCBJJ2xsIHBpbmcgeW91IGFnYWluIQ0KDQpUaGFua3MNCkFkaXR5YQ==
