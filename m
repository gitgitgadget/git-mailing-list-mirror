Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ABB1E2602
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071743; cv=fail; b=AE9lXBdHf+SwVkaZgJnkhZJ+JDD8/tUtFwKLWSjfi1UJOU4R9pYDSeuiWL+CIBz2Sag8SuDLQU6EMkW/xxTb1fmLzjulcNpCzI78gNYOkTK16nRRD/lqoYvZQsciz0c0SWnb6LvgKlfqImJdFyw0TLBmzoD91L4ZDUbOCCEfp0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071743; c=relaxed/simple;
	bh=emHAhdOl7e8FcMQPaQjQL+8m8C3TeUXmHG7WhwjsUeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L3gW/L3809ICowSvYjUsTu4KHd4xEGddNrMgdaJyZyfLuXZiqJYqK8gtTjIbRUfcs90e25lMgGlo+oNEUdQOQ0FH/+xG2XrGnENbHGJx8gLjmNg053nKKzvUa4T8CIsVnShfw2xLkdbf1+LmdeUoOQ3dUzT2tikxJr9+aSlTFww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TW9tc1L/; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TW9tc1L/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRG/VThWi25rHxRg9jjWAFs4q0GTwiqK/dqsTjwymzC9Cec+7yJ+xA4TkBUDDNW9uC8JQS+a3i9bdL0bvp6LjCFxWeP6zPDz5bmpizvHbWe/ZkdpqiUbzE0DrLCqgwvbwfwugTiDhSGm0s7HYZsUiggyv5lqXICCqtcVi116YOCoG7kIXftWcpcwUe09UlHdFu4eS4U8PjbGS7ThpDDw9DlcrZxprH3beMctBjCwqMF7PDEH8ZdyB05xxTbwP7gDBZVinEvDmaxFVDjGaldoADV2V/CvFOKX6sQreg8i96SU9z4HfMijjO0ag7NLbOhOOjIKTj+zs2d4wfiXZJLObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emHAhdOl7e8FcMQPaQjQL+8m8C3TeUXmHG7WhwjsUeM=;
 b=WMmXg9ETQgjbh9nfVy1ezp651yES3NBfWZbkdWbaJCEsr9XPYieRog2aQz6OWJikjbRWv9baUTQvRiSfclsmsKKYf2+RXj8uXZIRrWWzB9CNNrIH1JDQnrBTGFJCEYHitYWmWImUIGwVGq4t8LsSPnCY5SfC04TCyB38nN/oxnMJuGL2thR5PPkk/oh2aTEszfHLOIeh9R4kxq9CgFuQCkPTBmWRVMKPRAqEeQSPM2chlC+/6ragHYI+rvxU40KMwvgzxENOdz3v7o1/FviYSMffRcj4vpxeO0RHlqb72bZNUd1KcpU35GOXjnWHSfi/z/OimXaBlV+iUMo5QiYHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emHAhdOl7e8FcMQPaQjQL+8m8C3TeUXmHG7WhwjsUeM=;
 b=TW9tc1L/fzxY1LUpHnH+YwW2uI6aiMm2jlYQKBba/osj7mMoZ0lJefq1iE9ANadpl0ot4koIT7PQrd4Hl+2wGEdCXQmJjWzdcsVD8EHDDyBovp/zMrBmRZf2kO104Kg67QXznIwmbKlHfKXt0O3wFTL4yFSURXquBzV/Fom6TQC/zojNAO3YTa+Uk7mtPnL/r5QNpyVQiKqiPXdhrMhPuyNS2cuVFzwm6q4+tBEyydlFxrTIKCqmLGFFUq3q6EXktkXUqdHYOEKA/jOiVnFqDKm14e/nYz0P0axItWEJHXSGQ0DOCyF8cGcQDZNABDZQ0LJxezFhBr7Q7VkNhc24MQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PR01MB4420.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 17:42:16 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 17:42:15 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname --fqdn
 on Linux and macOS
Thread-Topic: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
Thread-Index: AQHbwX6JzjtAxyUkKkmtcSJbF/t7h7POoNeAgACV0XWAAAE4sIAADYacgAAB4YA=
Date: Mon, 12 May 2025 17:42:15 +0000
Message-ID:
 <PN3PR01MB9597413F0653AE9DDBC282B9B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <xmqq5xi5u401.fsf@gitster.g>
In-Reply-To: <xmqq5xi5u401.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PR01MB4420:EE_
x-ms-office365-filtering-correlation-id: 80383d0c-02db-4c53-2c90-08dd917c55d9
x-ms-exchange-slblob-mailprops:
 laRBL560oLR0Ybdxcp7KTbjbpYD2CblCxnvsJSGRyy1c9eo/hr0xFrr7nwLbPDP/7jFlyQNoVQPgmzOqdzUt6wU8zFCRz4gTunbV0D8lfyOmmFjSh0NGfJ4G3FWEg5OaEEIFeqfQnVvNBfAFDjY6ehcz67dt6Ni0nvMm/yp0po4rwFsTRFdSYbcR4/FThtYPcwrKd2PYZ4iapZCTr1iyPYb7RaFQAexAMlulhuUg6oTGs7BcxsQHdzAJ339TJs52y4N2qHee1NOjkuGVM1pK0kF8bxKrjbP83S3vvLJY9QP+fEh8Ans3U74sAH17bijvsnVcIX5oE60gexRJcag+cJCWOTxEUyzk+UuhTPo8LimSTp6lb+WkO5PtTf6YW/ypW8ErBUQr8uD9cU9GQMXxbBuSq8AzYRzICJeDvpbsMZSV1jYqp3uZFrh6lR9O+E4535c5PbaklbQ7r0/I3cN1AqyZq4BzQFnemATl3v/DgDdZY4UswI/9w4YoSgYoPLUWVJPM86ZQVJjv03+lwY5dnc4kDen/bCfECLoP9hgYUkW030wUVXkvNM7b5iyZlRbjitXbYsP8IDV6GafAwGB50vaoLs2S9gHlpQF8bO8xAX9Gyq4h6CWamwGJ2AmO5ftFZJOokqY8oTqiC6nCzlWtRBxd6hFuFyu2+tbBZclI4cAA8lzDFgkARwgkwWpqNZQNdXks90QX4uOZxUqIye8Xlwmft8LfSrZ47yfbR/7kn1oJEPt+gyD8LzOxKEaRm79805SKZ5XviDQm62wbSCjooaDksKFvbRFE
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|19110799006|15080799009|8062599006|8060799009|461199028|6072599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWRtVlMweENKcUFrcjFodXB1cmxETmVyVmdOK2xsWmJxK2hXV1lhNnJrYUtv?=
 =?utf-8?B?a1p0OHkwYkx2d2F4SmpvbVY1U01hcXJSWEI0cnZVL28vbTBEN2FFdm1zRjFO?=
 =?utf-8?B?OFN3VkhQZGtkU0J2aFJDclhtOFNzd0RFTzFYQy9FZmlpTDlUL1EyUzR4TmZr?=
 =?utf-8?B?MVc0L21pQVMwRld3OUU3eGhJODFIa2djT0lIcnBrc0QrZmFUUWlZNVRSNEo2?=
 =?utf-8?B?cXNEVW9jNS8wcHVLRVZMNGU2UjN2YTY0S3RueUc4RnVrUlcrSXZIWmZleUVF?=
 =?utf-8?B?bTBaSHR5OTJQYVY3bFFhNEsxTHA4cWN5TWJCYUxnSGJLanVJdmZ3dyt1bWdj?=
 =?utf-8?B?RElTN3ltRFZ0QlE5UTFvOW1YcUJ6N3FwTVdsQzArb1JoTTE3RFhYeHd5Z3Vv?=
 =?utf-8?B?Wkg3RldpWUQvV1pEZTV0eHhaNGsvR1FUTGszbjhDOVdTQUp6VWNyNU1UeEF4?=
 =?utf-8?B?MHVLdXdFaUpLbzR1SnFpNHNmUGpsV2FlVU84bStBZHBJc3NYdnU4TTBRQTRr?=
 =?utf-8?B?dkZpQzBwUkFjNXVnWmx5YXRmSEM1RzcrSWFkdW9vNjF4YWIxSWlTcU5lL01H?=
 =?utf-8?B?SFY4NEJ0cEZ1QUQyT25HWW5tSzllaWJLTUVhWUI0Uk5sTmpONUtaN1haenZu?=
 =?utf-8?B?RVpGazlObEdSMGNPN0h5RUc5K1g2ZlIwTm5jM00zM0xXVjRsd2dNRWVTczNm?=
 =?utf-8?B?eHAxL3pkVjBHcDJNMnRCVGZDZjY1a1ZpRUZ6MGxKMzY3RmRYMlhuQ2NYbXdt?=
 =?utf-8?B?TzhhdERIS0pLOURMeEg2NHlYc0ZkN0Z4K3FXTlFYS3ZidnlQL0pYZlpPazgw?=
 =?utf-8?B?cUlIdTV2VHRoeUkvZUhuZVJmOVhjQVdDOWZGYmlkQjduai81TXB3dUhJZTNK?=
 =?utf-8?B?OTNySUJ5bTdITDJYVDBORG5QWmg3Zy9lYXk4TjFGS3d5b0NSejh2OEE1aDV1?=
 =?utf-8?B?TlNBN3FZTktVc2hDOHVEY3NFUjFTamdmQWV4T3RRaHZ3ZHh3YmpEZDJmc05C?=
 =?utf-8?B?MmFkcWNSOUV4U21vdGlIMjVNQTZCNkY3VStNOUk0NjZYZnBmLzZVblc3UmVM?=
 =?utf-8?B?N003dGk4RXdBUnJzN3A5cGh6cERDb3lGU09UNmM0R05VMU9VN241SU11MkMz?=
 =?utf-8?B?UUNSTnNVWUpnc1NJYWhCTWIwNzJXbXJ1eEdzL1N6OWd1T3pJd2tqYkh1QWU4?=
 =?utf-8?B?WlNJSFY5YUxyL2xXRERLcVkvam9iMTJFK0R4NHl4MG50RXJIUm13NDVEcWFj?=
 =?utf-8?B?bldtcUJNVW1PT3QzdWlCZzhVVFBCZ2svNzUxQUF1TTZNeXZLNG10RHZjY1RK?=
 =?utf-8?B?SlRqT1A3YUNkM1cwa3FxWTJuMzRQbmZST3FuRFBoaFVWWUVTaElmdC9ucUVr?=
 =?utf-8?B?SlhIOTdidUhiWTdvYWdKdG1nTU0wcURQbXZCejR0OVVMT2R3N3pGeWNicVN2?=
 =?utf-8?B?UEQvZ0NFZUpGZjJ5ZFBuOUlhcmNsOUxYa1pzM01NdC9TWGk4RG14NXNldlc5?=
 =?utf-8?B?OGVGNHd6c2xFR3dBZ0NVbVdJYlo4VWh1WFVSS3FSTW9vdThneGxob0l6WkRD?=
 =?utf-8?B?N2RLUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0hWYmFzNXZ4SSsramkvUEJ1VmFmRWVTa2pzVDh2cnFiejZjQ2ZBVGx4cGVF?=
 =?utf-8?B?REFMQXJweXR4ZFZtclNhUlAxTkZzQzFqeXRFK0owTXh3bStlemVseW4vSkVT?=
 =?utf-8?B?L2t6aVFRcy9iRDB0akR6L2JWR1M5TUNlUnJSU3JVN3lxMW8xc0J4U2tnWDRj?=
 =?utf-8?B?QmFHNm5SemJPaXkwVmhEUFlpcTJick9tdzdleDgrMFowY0ZidUgwd1JCV3Y5?=
 =?utf-8?B?VVlTR2RpK0dMci9JS3lwVjB5bzEyNzdzNGFkMnExMmsvRTdtdDhSTmNxVFg1?=
 =?utf-8?B?RWZiVTdsT3NUZHpMeVZzMzRnSGJRQkl0L0c3U3QyMU1IMTUzdjdsa0haMmRR?=
 =?utf-8?B?MHppOXJQSlFFN0lGQjRJMEwzc2VCdWN4Q0RtUjZVNklweEorUG5UQ2poY3k0?=
 =?utf-8?B?eEVjSld4UjVUVHoyR1IzQlpSbWZVZ0JmY00xMWZtZSt0ekJmOHB0VWc4L3Qw?=
 =?utf-8?B?TVJjcnJaV3NQNExCY3JRQ3Nvcmt5MGFFR2YwQ3Mwd05uQlgrUkFrUVlvR3ZU?=
 =?utf-8?B?NFJWdTlzdTJnT2NISEJoV0hrOWprK1ErL1h4M0p3Y2RUaGdyTGlHcGhkZVVJ?=
 =?utf-8?B?emMvSGh1V0xwMDlTUHVJS2JPbmlZaGp6M090SWpHTzZVcldEQi92dlJTRi8w?=
 =?utf-8?B?Q2tQek9NdnlwcGgxbktRSnc5aGtTNk0vZEMwQXRjZGpjWTNLZnJrQ0NGNHcy?=
 =?utf-8?B?cVRsODRKVDc4VWlkZmRGOHA0M2JLT09zSURlYi85K0Q3cG01Y3JTdmVReDhE?=
 =?utf-8?B?NlQvK1BmVk00eTl2QVByMkJkM2t6K0p4bmUvck9GSWg3YnMvRmM0RjV5TGJJ?=
 =?utf-8?B?MjlObEYxeWVmUmtpWFNTTm5mQi82TEZHTTZYa0ZqSlpuT0xnOS9EUm5UdG1D?=
 =?utf-8?B?SkhEd3Vycm9qUVFadkJJRm5EMy8wWHZWRWlMcFNyVVlwcTBLcWxjdGpWd2dD?=
 =?utf-8?B?TUxCRWhjdXFSTGVmTlIvekRTYVNrSVh5QTZxU2hiZEhMVEd3RU5tUjRlRGhM?=
 =?utf-8?B?aW5WdTNiVzVtR1poSUxEYmM3NFBwV2pFL3pOQTRuOW9ZWEZwc3FQUFN2a0c3?=
 =?utf-8?B?L3pHQ0s2MlZtUjRXWXM2WncxVlg4YXdUZzlOQU4ycmc0dXR3TkFZWXcyMEc0?=
 =?utf-8?B?SS9pZTlZMUo2ZjlOcm1ncHhxOHNBTndnaHMwcEV3b2FlL3g5cjZOL20wa3lU?=
 =?utf-8?B?UGlUbDRBbkNEd2puUVhjMnBHWlNHNDZNL2phSTZFTzZhMk0wSE50MlRZeGJo?=
 =?utf-8?B?NGxQUVUxTThzMXA4RVl6cmRKZGZMdFowTDZDMGFUSFdDcWh1bWxGQ0NZRVg1?=
 =?utf-8?B?OGZaVE13UUdJaGZaRUhsNFdmcUxiMlUzQ2orYzVwVUU2NytuVXZpNDhUUlMw?=
 =?utf-8?B?eE9rcmRucTBnNGVaVHJzUzM3R0xFM3RWT2w2UHpVeFRRYXZXc1gxRmYyblZN?=
 =?utf-8?B?djd2MW1tci9KQlZKcENYTGNjRS9BbE5acmdBTForeEU1b09oeEpkYkkyR09K?=
 =?utf-8?B?Ym5XMTFXVU1QVko3Y053K2VOWVNLVGJvVkJqVzdXaUxNY0ZVY2k4akE2TkdG?=
 =?utf-8?B?Wmo2RjlYSWVJbENmS2JDOS93Mk9Cdm9qcjBzRCtBTE9xUThtdUU1ZUt1R0Za?=
 =?utf-8?Q?59eiLKbNGxW7yybFFFig+xcNXOXNP01LhBYmMCCIT84Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <DCCE20A0C4B594429425DACDC6EA3E00@sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80383d0c-02db-4c53-2c90-08dd917c55d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 17:42:15.8285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4420

DQoNCj4gT24gMTIgTWF5IDIwMjUsIGF0IDExOjA14oCvUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4+PiBPbiAxMiBNYXkgMjAyNSwgYXQgMTA6MTLigK9Q
TSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToNCj4+PiANCj4+PiDv
u78iSnVsaWFuIFN3YWdlbWFrZXJzIiA8anVsaWFuQHN3YWdlbWFrZXJzLm9yZz4gd3JpdGVzOg0K
Pj4+IA0KPj4+PiBUaGVyZSBhcmUgbXVsdGlwbGUgaW1wbGVtZW50YXRpb25zIG9mIHRoZSBob3N0
bmFtZSBjb21tYW5kLCBhbmQgdGhleQ0KPj4+PiBkb24ndCBhbGwgc3VwcG9ydCBgLS1mcWRuYC4g
Rm9yIGV4YW1wbGUgdGhpcyB3aWxsIG5vdCB3b3JrIG9uIEFscGluZQ0KPj4+PiBMaW51eCBhcyB3
ZWxsIGFzIG1hY09TLg0KPj4+PiAuLi4NCj4+Pj4gQWxsIHNlZW0gdG8gc3VwcG9ydCBgLWZgIHRo
b3VnaCwgbWF5YmUgdGhhdCB3b3VsZCBiZSB0aGUgYmV0dGVyIG9wdGlvbi4NCj4+PiANCj4+PiBX
aGF0IG1ha2VzIG1lIHdvcnJpZWQgYWJvdXQgc3VjaCBhIHByb3Bvc2VkIGNoYW5nZXMgaXMgaWYg
dGhlcmUgYXJlDQo+Pj4gaW1wbGVtZW50YXRpb25zIHRoYXQgdGFrZXMgYC1mYCBidXQgdXNlcyBp
dCB0byBtZWFuIHNvbWV0aGluZw0KPj4+IGNvbXBsZXRlbHkgZGlmZmVyZW50IGZyb20gZnFkbiwg
YW5kIGVtaXRzIHNvbWV0aGluZyB0aGF0IGxvb2tzIGxpa2UNCj4+PiBhIGhvc3RuYW1lIGJ1dCBp
cyBub3QuICBBdCBsZWFzdCBhbiBpbXBsZW1lbnRhdGlvbiB0aGF0IHRha2VzIC0tZnFkbg0KPj4+
IHdpdGhvdXQgZXJyb3Jpbmcgb3V0IHdvdWxkIHRyeSB0byBnaXZlIHdoYXQgdGhpcyBjb2RlIHdh
bnRzIHRvIGZpbmQNCj4+PiBvdXQgKG9yIGl0IGlzIHNpbXBseSBjcmF6eSksIGJ1dCAtZiBkb2Vz
IG5vdCBmZWVsIHNwZWNpZmljIGVub3VnaC4NCj4+IA0KPj4gV2hhdCB3ZSBjYW4gZG8gaXMgdXNl
IGBob3N0bmFtZSAtZmAgZm9yIG1hY09TLCBhZnRlciBhbGwgaXRzIHRoZSBvbmx5IGRhcndpbiBi
YXNlZA0KPj4gT1MgdXNlZCBybiwgYW5kIHVzZSBob3N0bmFtZSAtLWZxZG4gZm9yIExpbnV4Lg0K
Pj4gDQo+PiBBbHRob3VnaCBpdCBzdGlsbCBsZWF2ZXMgb3V0IEFscGluZSBMaW51eC4NCj4gDQo+
IEFzIGxvbmcgYXMgd2UgcmVjb3JkIHRoZSByZWFzb25pbmcgYmVoaW5kIG91ciBkZWNpc2lvbiB0
byB1c2UgYC1mYCwNCj4gd2l0aCBhbiBleHBsYW5hdGlvbiBsaWtlICJ3ZSBjYW4gYWRkIGEgY29u
ZmlndXJhdGlvbiB0byBkaXNhYmxlIHRoaXMNCj4gaWYgYW4gb2RkIHBsYXRmb3JtIGltcGxlbWVu
dGF0aW9uIG9mIGBob3N0bmFtZSAtZmAgdHJ1bHkgbWlzYmVoYXZlcyINCj4gdG8gc3VnZ2VzdCB0
aGF0IHdlIGNhbiwgaWYgbmVlZGVkLCBlYXNpbHkgZ2l2ZSBhbiBlc2NhcGUgaGF0Y2ggaWYNCj4g
dGhpcyBjaGFuZ2UgYnJlYWtzIGV4aXN0aW5nIHVzZXJzLCBJIHRoaW5rIGl0IGlzIE9LIHRvIGp1
c3QgdXNlDQo+IGAtZmAsIHdoaWNoIHdvdWxkIGJlIHRoZSBzaW1wbGVzdCA7LSkNCg0KSSB0aGlu
a3MgaXRzIGJlc3QgdG8gdXNlIC0tZnFkbiBpZiBpdHMgc3VwcG9ydGVkIG9uIG1vc3QgTGludXgg
ZGlzdHJvcyBhbmQNCi1mIG9uIG1hY09TLiBJdCdzIG5vdCByZWFsbHkgcG9zc2libGUgZm9yIG1l
IHRvIGNoZWNrIHRoZSByZXN1bHQgb2YgLWYgb24NCmFsbCBMaW51eCBkaXN0cm9zLiBBbHRob3Vn
aCwgd2Ugc3RpbGwgaGF2ZSB2YWxpZF9mcWRuIGNoZWNrcyBpbiBwbGFjZSB3aGljaA0Kc2hvdWxk
IGNvdmVyIHVwIG1vc3QgZXJyb3JzLCBhbmQgYXMgZmFyIGFzIEkgaGF2ZSBub3RpY2VkLCBkaXN0
cm9zIHN1cHBvcnRpbmcNCg0KLS1mcWRuIHN1cHBvcnQgLWYgYXMgYW4gYWx0ZXJuYXRpdmUuDQoN
ClRiaCwgeW91ciBjYWxsLiBUaGUgdjMgb2YgdGhpcyBwYXRjaCBoYXMgaG9zdG5hbWUgLWYgYW5k
IHY0IGhhcyBob3N0bmFtZSAtLWZxZG4NCmZvciBMaW51eCBhbmQgLWYgZm9yIG1hY09TLg==
