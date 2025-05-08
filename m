Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB027FB2B
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716723; cv=fail; b=BeZASlTKmPBui8zFCNLGK/yDCkUwh9+VCroo234nkwaNbBykkK4WBahTLca0Ig15QaIVmiZO+S1nf29/1MUD2aFdvngWIzj37bpR/yCCw/9C17FYFS7pmGK3DsaKN/vxCemTRJ5XzeAuZeVnmnkAE8zZ6WM3QmfWm4SnJCdjxBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716723; c=relaxed/simple;
	bh=sp/yWHkQGAxBwJF2CoVb7NJe75++Ra9TfyXRiDygY0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N0flnrxuwCrkdawtFejrshSODQjiOAM98swm47i6U8udqj802tSk2kSqPtktxB20iOASxqRVlpOWg+2ohXeL3kEQAcrIPiFCspeSqXHQsULGsRksRcgLqDkmYVwM6L1Oa4hPGucmNZzh8yCnfAVVG73y3hR35QXIsl/YDkkAaB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=OEuwMqGR; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="OEuwMqGR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6VzlQpPJSEQ8MpCutBbRjSnpDyPT5WBGcmj1BUOoja52rxsgNU4sQ2UULZu+XO0TacBXmLywxE8+K6/lY20iVYxy10coyJvvaxkvJu0PWiHk1zhyALe09FZS1v+3sV/QQXuWHF0d3Cw2guC4GFRtwKUuYWRH5jq+TOX0HkCX/CJucZhbdTBazPLNC7K/a9rA3QmHOUNRVRYyBQSFXhwmxAj8nS4QaBCdDpyctUyRQD+7Kmg0Jz1iU5rQSjRpmWKweiG8XVWJbTZrIGZtlVg0ookd1X5JlFO42amDZ2ctEHG+RlHGnBQIpppbdXc2XTeVI84GFx/9hr9UBDK/lvmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp/yWHkQGAxBwJF2CoVb7NJe75++Ra9TfyXRiDygY0U=;
 b=i9o0irbvmVzf0rvBxxMAeKM3YJ4J2DIqqxKuiPI3JF9zkV2++z6w7snBSK6d6UR3N3F2bFzShaQQfmfv27CnbAGrTtwYNKrrS+a9MLyB7v/uQKGOQvUNDrK5VOZM1WAF3GWiaPfoYVoxqoQ8R82eAsAXuWN9hXONePXtaHynZ7CUTXP6tzGtbmId8vciypAqcGhVI7FhI93hwgAHexqkbuJ/4Z/7V6uz3tIRWxlOIGDD37EWCyQyi4kbB01kXhuyLt1GC3zZDOGPTy8SvaW/ub4DOOYDMVHy0bztpVlM5I+kYSIhPrd9PAHHUL5EDL2PyFZnyslhwjqB5CTtAfDC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp/yWHkQGAxBwJF2CoVb7NJe75++Ra9TfyXRiDygY0U=;
 b=OEuwMqGRLNj8gAO8Vt6iOGpVUeiJGm039L4inmMT74idhQ9pQse+pvjupAdnDRFkOmW3rupajnBqSnJHY2ggqKKT+y2xTqV8BWXob5HSAUTMmewqt1abvQV5N7YxqPfxVg7Hnv4zJLHnnT3UA6DMH2sf18IM3QYtQXHhs58Wq+xjCUoI/oigZlfM/T0HQgNJJUlQblO0oQi/IupSot08vAb4j+E1ZyI6tpACN7hdPNAorDTtJfMdeLe9vKNZeShvq0CaRGEsbpqzYegc83wI/I0YRnoSIn1F3QhKYiD3HezdvxXw56z2KuwL3bqXMbyOm63sONGqqun/CQmdjnH3cA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9010.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 15:05:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 15:05:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Topic: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Index: AQHbv0zFVjfsAuRfzESA3EiZEdhM8rPHvkVHgABWFBmAAKjMt4AAFhK3gAADX9w=
Date: Thu, 8 May 2025 15:05:11 +0000
Message-ID:
 <PN3PR01MB959761BC7EF27EE2CFB1134BB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xicawp4.fsf@gitster.g>
	<PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqwmar8bw9.fsf@gitster.g> <xmqqcycj888l.fsf@gitster.g>
In-Reply-To: <xmqqcycj888l.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9010:EE_
x-ms-office365-filtering-correlation-id: 161ff01f-5f56-4f6c-3084-08dd8e41bb0e
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CNu8Yb5bKtMVTEAn392ZEKafIP42lE1xphx9OeT/F0QLhqpZifPa0KP1IUKfR8ZLxmhSix5b1jta1lVeG+65btS2n6Zq5Va5CzmQsz7nBaQyxzJG6p6XV46pVflfDCvER2xkkmssLyVGwmndco2Wk7bzN7KbFCENk818nplbvFi3oNTYEy3IBMBXrb5S+I+drJTtrFC4qkbwr/fPZ5d1bZoOgwWZbaJm00XMc6HExeftWl/wAG2PLbiQ2qenW6cPKEXOKb3WuBl4Z2IRBvYC2kBRrS0vws5oSz4EsAha9luuadoEvDFQI0fmizdAH1AIMf6c8aYlRQi3jCefNd/wA7w1aiiLhAtlcsNB/5h+JPB67WzVL/TiwsUHAFM+CneQZ2Jg28jTvLhbYZVxfhRU73wFhlyTMQzRC3KNveA7VzLw7nTJeOZRjGSLtTgVT1qpid+nDcXq/iAFDBmRilj7e+t9qDqJOzQOjm+3QZHXEVTag0YY8Qt4a43TAhaGknmLN6KZbWFFTqny1N5SFwc0CYe+WCUYWymzR6+McbJP8ZvY75uGd4qfpPKpMg7dq2rdsIFknelIhPfHXPbP/cnlZa+oBCGjNvWJWp9cpwtfwNYLnuFzSCB3JaeiAFLHycSWDYq07O0mWM7sk/7OSbBKh/ARcEKv26zJi3VCSZWrgOAedyPfc/1TNXV1xTQpwJMVXnFqNsZYQal4YOtYo1o1ylJslmhUaYm18
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8062599006|7092599006|8060799009|15080799009|19110799006|461199028|102099032|440099028|3412199025|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZG93a3pzZ3ZOb3gzRXkyQkxPT2NreENIVnkzWWMrTnVsU29DekFLNFYxMCtH?=
 =?utf-8?B?amVuUzd0ZmhMOTZyV25vU1NTUG9MTTZDZFRlbGg3dEFGQVBxaURpdHZ1MFky?=
 =?utf-8?B?aWpKcXZmdnJUVlNHbEsyZUVBZ2RMY3dzenBDS3JQY0FabHZFMjc3OEJPQmlU?=
 =?utf-8?B?OXZ3T2VianNpTDREVDdWOVpSUmd4ZDB5UGp0S2FKR0JvNW50eGJ0UFo1MUwr?=
 =?utf-8?B?eHMxV1RZaHB1dW11V2t4NllmaHRhTy9DNmdOS3VmRmNneWd6QmFUdWw4VnVI?=
 =?utf-8?B?aEVPNmttRFpWMWNqY0k5anhqTFd5WldtY3NDcE9HL0lSMjhYdmVGRXZIK09P?=
 =?utf-8?B?MDBZVXEyeGREODEwU0FFMDh2OC94bkJrTVlOV3pPbW1OT1RORUl6K1RBRzB4?=
 =?utf-8?B?ZzlPREVMZlh6NW1qSk1CZ1NnNWZ6SlB5UFpZeGh1aXpYWXgrakhvbm5JNkFa?=
 =?utf-8?B?eVR3djdaQ3NiWHdOY2w1ZnViWTRQUTU3Tjl6RWFZd3VjWGpHV09UUGp2amhK?=
 =?utf-8?B?ckY2aFIrZmt6MWtCRzd3MFVycGVkS1oyRVN1Szd1RkpWUWJaYkZvK01jTFEy?=
 =?utf-8?B?MXlDd091cDN5c2Fra3ZzYmZOc1QrbUZJVmlNa1hLVVJrMTZDQmRsQmI3YUZQ?=
 =?utf-8?B?ZVV3aExLckIvZGVrMC9wZEcxajhBRlZFdXZoY2tWQTRvdUN4eEdJNTNIdnZV?=
 =?utf-8?B?MVFJVnkrNFMvVjAvQlVMUGt4VXBrajdGVE5jRU05bS9OSytGNnRPSzRwVTVN?=
 =?utf-8?B?KzM3cWtkZ2NaTFJHekFzWHBKUjNEc3MrdC94dVhZZ0R6SUZ3Y25RcW9FSjc3?=
 =?utf-8?B?emVaSWlyN0F5a0w5aU5pSVFvaHc0SUhteVZVelVVVDJCL2Rabkd3TzZGS1U2?=
 =?utf-8?B?VnI5WXZPQVFrbGJmLy9kekh0aEpiVmlwMldRQW15UnRJajEveVJWT21rRVhH?=
 =?utf-8?B?TkNTS3FOR01Zb3FoeEhnZEZtWmtGOUlMWjdwZHd0RGt4c2NjWnk0WWpxb0la?=
 =?utf-8?B?a2ZjOHNFUjVxeTVuNTZndm9MdjVIZUpHREZac1VLbGhkM1VKRGNKZWlUWHgy?=
 =?utf-8?B?UE9Ec2JlSklKVzV5T0xxcVZEaU9zaUFVUVUwRzI3a1NJVlRYcnRFd2dQR1M1?=
 =?utf-8?B?dVZ5VkUwcjFRUjNiNmFYMllxdUtNV2gvQmFXUXk2cnA1ZzFyWXNob095REs0?=
 =?utf-8?B?eW1uVGZWN2NSZW9tMUVnU0xrdmJyZVp6OXo2SVkzU2hQcy8xazlGMTlENmJr?=
 =?utf-8?B?eW1qMDU5SEora1JkYWNYYWh0U1RzTnhYVWhmNi9GMVF0Y1lJRXh4dlZkMUZr?=
 =?utf-8?B?NVhwVFE3MFg3dFFUK3A1Y3NseEx4bHJacXRtOE0rT3Q0dEs4YmJ1NzVCQkZz?=
 =?utf-8?B?aXpHRkp2WkRUTzRUVktXS05ZMWZmQzNMV3NhY0FDbUV0Rm9pOGVGWVB5TkEv?=
 =?utf-8?B?enJHWnBSM1dnamJ6NCtpNHU4c0huWnFaa2tpRzlJZk10S3RRU0Y4enJTMklt?=
 =?utf-8?B?SG1Zb2grQlJoYllGOUFlc1ZSYjBObVFsTkdZb0dmYzI0VWJiNFZuVmtQNVdy?=
 =?utf-8?Q?nmRtzMF6pMDdVRzZa++xvwp4zgKQ0tio2A8v9pM84fk8LO?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHQ2NDVqYi94R2RIdkNMVXVzV2MvcWc0eE1JTUM0YnlTVGk0amJoQUQwUFc5?=
 =?utf-8?B?Wmd5dFk5WTlQZFlycDR6R3R3T3lUcENXdnMxQ1VCWDNhZkpTNEpEb2tpMy9Z?=
 =?utf-8?B?OFg1VXo1TXVwd0NGU1ZEZ1BFMlo2blkvOG42bWV2ODBhU0F6WkpyWGdzZHVF?=
 =?utf-8?B?SVg3TDYxbWRtS29EWmsrajQ0U1BmVzgxTktHc0c5VC9nWTNNcEZSY0R5Nmxl?=
 =?utf-8?B?V2ZIK3QvdlVJK01RQ2puYnJwTUR5c1VJaFVMaXNvZVRNNUdYUCt0NUhlZ0tM?=
 =?utf-8?B?TE5JbWFvU3FZWmxRUkpPNmhoRjYzaFRjNmNlaDh5M1NTSlRIUncxYzQxZGd6?=
 =?utf-8?B?SVM5WHZ1dkpiWjBHQWlVWWFuY3MvaTBVeEk5UVVPZG1RL2J6OWNiR0lDblBz?=
 =?utf-8?B?VDdqWWRJR2JKUDZCc0N1NWZpc3hLSzhSZ3JqRkt1TEQwZGd2ak83KzZYZUtC?=
 =?utf-8?B?TjFvRXRqc3M5NmVOZUgrNlUzT0E1YnFtZkNXQktPbVluRFRyc21TNTE4LzBm?=
 =?utf-8?B?WkxZeFVIQmtQUVR6dWZqaHNMaVV6NlF0Y0ZESC9kY0t5c1h0NzRFeCsvcXJC?=
 =?utf-8?B?c2VkZXpaUysxa2NtZVlVKzRWVmZET3J0REh6eXBodHZJNUpsZ3BnK2h0QVov?=
 =?utf-8?B?aFc3NGIwWEI1MUFRc256N3Z1eHFITEtMek5nY01CZGJZSm05TGtLREFncXBM?=
 =?utf-8?B?dTVocFU0OHczR1A2RlNsZEFZbXEyOVBzZE91MmU1Z1hIRDVNMHJTVnRtZXh2?=
 =?utf-8?B?TXRBSkJGWmJRbU83bUNNdHFRUFhHYkJNZ3hRMzRVY3ZNNi9xRnlCVEhjaWxm?=
 =?utf-8?B?VzJRak12dDE0akJJZjlsZ3lrK2oxdXBVbElJcEtzbSt6bXpPUXFWNFJNeGw5?=
 =?utf-8?B?bi8yTE5MOE9obThFdm5pbEtXZTdZdlBaang3RSt0VGw3MHdnemdENzJJT1JO?=
 =?utf-8?B?VE9LRmttOUhYQzkrOWNyUDU1VjZmeTZ0dFFlRTc0ZVVCNXVWNG8xMXB1anBx?=
 =?utf-8?B?ak9oeTVoWkJaK2pqOXZYcEw2aHVJckZwdjYrM0owRHZVSjRST2NCRmxEUEE3?=
 =?utf-8?B?KzlmMStFK0h2RGQ2U0RvWjdKeHpOOGN3SnU5L0ZxK28vODNuZXNqdWlPK1lZ?=
 =?utf-8?B?T3NuTXJtQi9lMmtrSVQzaUV1RHgwREhyeTk1eFBGYzdJTEttUW5NeE1nUDNx?=
 =?utf-8?B?NmpITXpQNWFYWnRuMUN5Q0VXaFJHWFVQdFY0Y3QxbHZ1cGk1T2hKVU1OdjBp?=
 =?utf-8?B?UWl5TjZ4aHdES0ZUSFZmNFQyL2pEZENrencyNElRemtLaVJEZ3Y5WDEyWHFU?=
 =?utf-8?B?blRDcXZmalBBeEhNd3JzSWhKUElvOTVqbHo3bklFaTBYU09SeUY4VHFlQXk0?=
 =?utf-8?B?UmVNMzRJSFFGTlJpSXV2bkxKYlNZZktQUmlEZzJ6ZExYSVdBV1I4c1NNT1l6?=
 =?utf-8?B?ZEhSMElHTUdCMG5paFliYmpHNS9iYXg1RVczUVJLdEVuTFltUGo5L3JHaUdE?=
 =?utf-8?B?bVcyUUxLeTBjS1pmZWhaWWNCUVdad0hoTFR4MHlwVDF2SnRpU0pyY2VsU2U1?=
 =?utf-8?B?OSsyS0NQYlI1dG1wVzBoT0xZQjRtWWNuSnZnNEZ1aXRtTjRIcFp2RlY0NlRJ?=
 =?utf-8?B?YU9KbmQzRWZ4UUdJWWZhMUZNdU9JOHR3WGhyWlFaUUdPZ2hrZ3NadjY5Vlla?=
 =?utf-8?B?SmszK2ptdEpucWk0dHVOVUFFdmJEYm50RVp4K3RVQkpWTHVFQ0h0YU5HZENR?=
 =?utf-8?Q?nSkC9VB5YAR7/+TBHU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 161ff01f-5f56-4f6c-3084-08dd8e41bb0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 15:05:11.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9010

DQoNCj4gT24gOCBNYXkgMjAyNSwgYXQgODoyM+KAr1BNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/SnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9i
b3guY29tPiB3cml0ZXM6DQo+IA0KPj4+IEkgdGhpbmsgfi8uZ2l0Y29uZmlnIHNob3VsZCBiZSBp
biBzaW5nbGUgcXVvdGVzLCBpdHMgbm90IGEgY29tbWFuZC4NCj4+IA0KPj4gIklzIHRoaXMgc29t
ZXRoaW5nIHRoZSBlbmQtdXNlciB3b3VsZCB0eXBlIHZlcmJhdGltPyIgaXMgdGhlIGNyaXRlcmlh
LA0KPj4gbm90ICJJcyB0aGlzIGEgY29tbWFuZCBuYW1lPyIuDQo+IA0KPiBMb29raW5nIGZvciAi
Xk1hcmt1cDoiIGluIERvY3VtZW50YXRpb24vQ29kaW5nR3VpZGVsaW5lcywgd2UgZmluZCBhDQo+
IGJldHRlciBkZXNjcmlwdGlvbi4NCj4gDQo+IExpdGVyYWwgcGFydHMgKGUuZy4gdXNlIG9mIGNv
bW1hbmQtbGluZSBvcHRpb25zLCBjb21tYW5kIG5hbWVzLA0KPiBicmFuY2ggbmFtZXMsIFVSTHMs
IHBhdGhuYW1lcyAoZmlsZXMgYW5kIGRpcmVjdG9yaWVzKSwgY29uZmlndXJhdGlvbiBhbmQNCj4g
ZW52aXJvbm1lbnQgdmFyaWFibGVzKSBtdXN0IGJlIHR5cGVzZXQgYXMgdmVyYmF0aW0gKGkuZS4g
d3JhcHBlZCB3aXRoDQo+IGJhY2t0aWNrcyk6DQo+ICAgYC0tcHJldHR5PW9uZWxpbmVgDQo+ICAg
YGdpdCByZXYtbGlzdGANCj4gICBgcmVtb3RlLnB1c2hEZWZhdWx0YA0KPiAgIGBodHRwOi8vZ2l0
LmV4YW1wbGUuY29tYA0KPiAgIGAuZ2l0L2NvbmZpZ2ANCj4gICBgR0lUX0RJUmANCj4gICBgSEVB
RGANCj4gICBgdW1hc2tgKDIpDQo+IA0KDQpJIHNlZS4gU2luY2UgeW91IGhhdmUgYWxyZWFkeSBx
dWV1ZWQgdGhlIHY1LCBjYW4geW91IGRvIHRoaXMgY2hhbmdlIG9uIHlvdXIgZW5kLA0Kb3Igc2hv
dWxkIEkgc2VuZCBhIHY2Pw0KDQpBbHNvLCBpZiB0aGlzIGlzIHRydWUsIHRoZSBkb2NzIG5lZWQg
YSByZXZpZXcgc2luY2UgSSd2ZSBmb3VuZCBpbmNvbnNpc3RlbmN5IGFjcm9zcw0KbWFueSBwbGFj
ZXMu
