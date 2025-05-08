Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93022A7E8
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712354; cv=fail; b=uYGINaxcfLreWQRelo10uuFhPY7w66n1tt5nlA0g8gWxRkvlRM5cErN3j3lF1tMEKmPZcHvGVaQ3ViRIIvBZaKVvUL1GaqJz1glQB9ytGIThXsM42clVQfgP0yX1q4i3E5j5UD8qyUh3+wwk4tQ6jQ7/0LYUGT8NYqXoW2TXE50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712354; c=relaxed/simple;
	bh=duT6ztSLK9zbNoKf4fVZac9ngbgO/S3m3hKcKi8wBW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=al2qPZIPC3Xlmc9oKTobXKLjmcwtzcjWk4tuSQeqz5JPju1mo+pDQUBCf2iqw18+LnBPQT+4pnUoltZ8zc4sY+Ph9lg2sT3g5IoMcROwm5TGk27f/3XQYShGnaU2ARpQaTVjkFKPeihoxxq7cTqEZ1ZLsdL4A72S/toeg4ZS7iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=K/RAy841; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="K/RAy841"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd/DyQowBNuvoQZVx/lpHUMzjOj7vgz2oQ2hcq6dxzE8V4P5C56V7pwp+tKwWxjXvEMmNue1rwBOR24JhBS2Pj3yR8i/FS8ApLiUQJllUbmHJUY64syys5A2bwXSvs8keK/ohRhKy8slUAY4TSF3duEDuic6U69h7plfW58FeHE1zdtAz4rxN4mZTI/NWLssZJQlEwoKC1TGYI7Dt4m8/poOq+CkorfBdyRxGwc74r/1w5WvOxGN43VJ6TdX8WaSqFWCahH9jytxGQWc2r3D1Dvakd4gBIRu8QKFJENvmxjCuhg6+3fdrX6YjyLYhDy5NTRHYpB2L5lv3GLjeJ0uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duT6ztSLK9zbNoKf4fVZac9ngbgO/S3m3hKcKi8wBW8=;
 b=fjdkw3f1zFhk/0KJqFzoJ4k8qKjY6mmfQAWQqmygdxojjhSLpZzAFrF4xSu+iOBEBrD6RV9E2DNfH+ahnOpooih2BNUeKBGWRPdriRsXfRMHPTTg+cQujpstNHEwdW52sADGfJQ2mu2euzJhZTpWTr7sUvXTkP2HfO0bxJsoyg79Twk158WKXARm9tJbikvJ5IdTJwFOJ1EoVcqP5PA81aUos+G8yAtqzG8obQfg3U4SqZvBSNY3yzgf8pEoOIIoApSmIGbSIcxiTvCz3ltUstKP40qFtPwdEOb8Y1SKF4Yj7OcCRLC7ky3FKd3WccLZscqKYaA6Z7G75AWvz0QMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duT6ztSLK9zbNoKf4fVZac9ngbgO/S3m3hKcKi8wBW8=;
 b=K/RAy841zETwsMxNl5LD3ic75RsD4IYM+uVj3HjWXjGlvozyTJUQGRbGiivDm9PTeYO4mfYghQoBa51ZqNM8bFyd5j1xhCSVo/A3aPHM4QM2U0oyhahDmYbE4+edkQCeQKahDrtPc9GjbvauyL5iDBUV/ekpktz5ZOlfm8Lz5XhVtHmHS2XKAJZsPjZ8OzsOvPwPVOwgJTD+K89zHxqIh0fOP1SkVtokiOhXKXvEMxYzMs7oeEgxTAlxEjcDsrPwLb42d43BgVPJCcS/WaG05Qj3EjywWOnEPsMy0U7/qDnN3l2e1mvdbuxY1Kzlp+BZXRL2sqAN93Hql+CYWwcVoQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB6756.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 13:52:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 13:52:26 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Topic: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Index: AQHbv0zFVjfsAuRfzESA3EiZEdhM8rPHvkVHgABWFBmAAKjMt4AABR0D
Date: Thu, 8 May 2025 13:52:26 +0000
Message-ID:
 <PN3PR01MB95972BB022C2297D3E52DE78B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xicawp4.fsf@gitster.g>
	<PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqwmar8bw9.fsf@gitster.g>
In-Reply-To: <xmqqwmar8bw9.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB6756:EE_
x-ms-office365-filtering-correlation-id: 589a4d8d-ee3a-44d5-7d46-08dd8e379126
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CoK2gWfPPgC1xI5BeF0Gzox/W8FrMxS/4+XiJ4Y3VSdy5F9anTxihlp4TeQmKr7croBnhosn+uRyItYS8mmtdVOMlw8r5cAU3Hur1HYtiwsdhlGKeIjVZT5bEoA5nDIZ1D+fJfD49Qcm5BHUxddue0XnO5vSgBVTbap5MghyJlOJYWjKTMnyEeVG7eNUiJpfnVFeMrMwxobQjmRYfSHb9tvo3upoSDGVgKyU/ywaNwTXSYlAXJXQDlRAkl9OvQkS/MzH0PfdeTaZokULWrZBdCnrV76BQw9br5kHwdTe5bXgd12479adjvXtCwivKcbI7KUvOE2NMNrHWfZOAW418BTAHcjqT+IL68j7ImjlvtSw+DoD4TByjTAb1ZxbqZn01WuoiVk0zd1qeb6VXM192zAqA4CtL2WBJ71CR9y8gF/7V5xBf7EhqbJBoVu/YLyZeOBCtWc7XXpsBCNnzHB3cHxwvrsOUFhvrnNHm1sebZj8/7VLebimOxcH1RDa9FBNGcOxXlza2yAQnVike8asIaZ1VkEknzCyBpNgrkPBEdFN/aPl6NVciYwbdYFrJBuJjCw23H1krmLYY4n3Y7DdTojLjePSXWp/A38DSE2F7U6noR/3RuC8Oa2YdA4EmnOU/r0TNV9E81KHufyiXhZF5drk5pXf2KaJMamb50PgfNwNkLhuVZdFqHpfcv7tFOugDpAzn2z6hw12EctINLeJkaGbGcLYbXgEo
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8062599006|7092599006|12121999007|8060799009|15080799009|19110799006|461199028|102099032|440099028|3412199025|19111999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWY1bTZOSWhESXd5T1NzNGgzenVicXhNUzYzeFpNMG1MRjZWelBmaExyOWl1?=
 =?utf-8?B?bUNvcnNtRmRZeFR3MmhKc0hoK3doVEM5OXpQTkVzSDdWaXZzYVhzQXNVSFdx?=
 =?utf-8?B?bURGK2VXYTdKd0lMM2l0Ym9aK0VtemwwblgrSmd3SWp4YTZIYmUzVVZ3cU9Y?=
 =?utf-8?B?VkU4ZzhFdkVqVTFlMHQwajMvc1ZVR1FtWWpLZ3BTWTRrazhWWnZmTkdXa2Jq?=
 =?utf-8?B?QzcyVEVZR1BTaW1hOE11Rk1TQ3pITWNtYWFoWTZ4citLQ1A5dE5wSnRUeGUv?=
 =?utf-8?B?UXE2TUU0NkFpL01YUnRMNFFrbkhsSnN1ME1vZXB2bm45U3l5NTRpVDNaV282?=
 =?utf-8?B?WHF1WHlCSHA1b0pLak1aZ0tGUmQwRFJHczVueTVmd3pzUjN4K2EzWERZaTNZ?=
 =?utf-8?B?M2lLZ3VZalNJdVM3OGU1RDh5dGYydzM2QjFtVjYxUE1pZVB5VDV4Wm5QNXFq?=
 =?utf-8?B?c2trTHd2UWJrZ0w1Y1hsM282YVpWNWM0eVhlUVVLVEFidUZvVVgyd3hFZDI4?=
 =?utf-8?B?ZFE1bCtTK09JcTBnQ1J5NDc5Tzh3cnprZ253V1FibWkwanQ0bzY0bnRMUmdD?=
 =?utf-8?B?Z0UxaUVRenJDdVQ3L0JxbWc5cklxNU1IcFpDZ0dvbjkya013bU1KTmU0ZVN2?=
 =?utf-8?B?RCtDcUdDeWZtWW1PaDZHOXE4YU9lSlNNN3E5bnY1VVFmdVlNZ215QlNabjBy?=
 =?utf-8?B?TjVpbTVMVTNUSDNHeVh3QmhDYkw0cnNPSUh4Ri9WWUIwR3JvN0ZENHNRQjg5?=
 =?utf-8?B?d0VRM1FrK2REdFZhNDNVMzl0Umo5YUI4WlFOb2FLMWtQM3YvT0pLclNURHl6?=
 =?utf-8?B?ODZjblROTWk2V0ZQeFJtVXhqWjNad2o1R010RUlpbER0Y3NyZzVheGxHdW00?=
 =?utf-8?B?dnJvTUJpRGtackZpenhPUjZrOElHd2xFczBiNllwSXRPakdjTW9tQURHaXZS?=
 =?utf-8?B?WGFqbjA2YmNuNjdiakhYeTdDYXpuZitGd3lkNFg2bEovMnNGbGNjRVV1NEFT?=
 =?utf-8?B?eXJPQUM5SDZ4UC9icklHMHJkUWxHY1V4VXI0OWVVcXkzTVpDaUNrT2ZxV3Ur?=
 =?utf-8?B?KzZ4MWJnd2dkNCtRaWVsRGxaVnJyWmdYQWZ3WDl4aGxCbm1Cdk4xUk91a2ZM?=
 =?utf-8?B?WkNYZEdqc2xnNzk0YXNaZUFKMkdibWpGK2lPdGp1aGxrMUw5VjR0ZWpEVHhV?=
 =?utf-8?B?T0ZWd2ZaUXd4Q0s4dlpsazc0NFBYSCs0cUpuVk53RWNvOVQxdUZFOWxuV2Yz?=
 =?utf-8?B?ZTE2SVJCYitQVDBGRElwd2pZSURrN1NIT2M0UTFidlJZU3VNVHAwVk9nSHBE?=
 =?utf-8?B?WHBiSTVxMWZJQXBHTVFGK1pmM2RDQW1nSnhtdmJrQmVxTVMwUysvMCtSaWUy?=
 =?utf-8?B?TEZzT2NnNmdQRGpuSm9HVFF5SjZtM0dXQXEwSG9JejZPKzF1U25QZTBGM25W?=
 =?utf-8?B?KzU2U0gydHRjRFBKQWljcm1wS252OW55TnQ5WURhR3NWN3prWE1lQmpkU3Vz?=
 =?utf-8?B?RXQrM3JWYVRTeVBpdjc2MlViWi9WZ2tIUjZaRGQzWHk4d0ZJeDlKSjdXTzMy?=
 =?utf-8?B?VDJQaEk5VnNFUVJVM1RZRWVoQXExUC82YU5QRldNMjI3S3R6eklnN2xhamdr?=
 =?utf-8?B?S2FEbUNOa3RONmwxaUhEKzUyK29qM0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rk80bC9pR2JHSERwNldHZGdoSnBuSldZend6dVBUU0puUXRFbkJGT0F2WXN1?=
 =?utf-8?B?K0JHNGZ1aGNTOWFEOHlGbUttR1M0OU4ycWhpbHhneXFtWnZwc2k1VUhRMG1u?=
 =?utf-8?B?U1JMdXlVaXhzTzdxdy9QSDhqa2ZHMndweDFNNTF1OFdRLzFUWUdPYXFWcUIr?=
 =?utf-8?B?ZzdrNzNQbTV3cFRKc01zUTcrQ1c5YjdZa0dzczNvK2xIRHRTdVc1Q0k2UzJC?=
 =?utf-8?B?NDJFb1E1YmJhaEpiUjZPaW94aEpaM1JwUUlITWVnbUNJTE94SG5SQWRVK1gv?=
 =?utf-8?B?QlI3SkNDVTdxdUxMeCtGZFhubWRRQXdWdWxibUF3dUptWVJIWUNjM0RSMkNB?=
 =?utf-8?B?eThZSnorSVVRU0YwR1QybUo3bHo5bEJsYlkrT0JUR05UdkhHQ2p5QnZWVTBY?=
 =?utf-8?B?b0tDUEIxSy9kYVNIbzhLK3pnL05zZDBDQVNoWWhybEZCZUlhdEpCRndQbURG?=
 =?utf-8?B?ak81Z0hWYkxJN2pKQjJnNXVnK0hBTXY0L0tUSVJlbE5ZNE9XbGpydzVGUnNX?=
 =?utf-8?B?d3BxUVVtSGRwNmZaWTdBWlRrVnJKV1BpeWRmRXFtVml6K0xVWElzVFR3V2tK?=
 =?utf-8?B?aURaZjYwMnhHM0NOZkVBVmZabTBiQTlrMnI2SEJIOGU3Z1p4b1JOZDVIVERk?=
 =?utf-8?B?ZTF0Y3gzY0ZSS1pNZjdJTVJaUFptb0cxWGN0Mnk1NVRsZUpUdXpSVjljRHFw?=
 =?utf-8?B?ODVRMERWa3owSGIzMktjNlY4cEdzM3FESXZtYVJ1L1VNM2MrbVRLdFdBMGZh?=
 =?utf-8?B?ZnpGTGlxNWcya2Y3MnQ3bEVMSWtFNjZrMHNOWTd5R0hwMC9Gc0JybjhaZW9C?=
 =?utf-8?B?M3pPZG84U2dMREk4bEZ4b0xTcE16ay9sQ1dDam10cEJWNFFxMVZ1TkZHQ3l2?=
 =?utf-8?B?L0tIeTJNRjVGeVhiaklZUnpkOWlCSmRRU0dQbW1EZU9BR1ZYYm1WWDVvU3E2?=
 =?utf-8?B?UW5CYWVUNUFVVGFJbWZMTndXOWtwL2g0VVlmM2xaaGx2cm9qRmF0MlA1MVJI?=
 =?utf-8?B?MkxaazVMd1QvRXVnQmFGMHAwazJTdmZjVGJBU2duYTVlR3JhWit2dzZvdFZy?=
 =?utf-8?B?Q012MzE0SjV6dWM1SzhpQm5xdnZSV01kOXNnRVdyem9NenZHN3VxREQ1N1p4?=
 =?utf-8?B?cENhRW56TkgyaURrWXFuWDRQRnZOWFJlU2pxSjZhTGtvUjZCWXZxSEIxNGRt?=
 =?utf-8?B?R3NDZFZ3UjgvZFF1VGZLeXJEMGhoUzdpNEE2Mkl1aTAxSWYyOVdJeHBOY1pa?=
 =?utf-8?B?Vm9rUnNuZEIyT0FMTzVWbnF5dTAyRm5vNVgrQVFJV0hWR2FZaHBnY2s0M2FZ?=
 =?utf-8?B?ZnV0aUcvZ0dkU3VkZ2Y3S2xUV05QZzlpNzZENkpjc2RObWJPR09RMnpvQTNJ?=
 =?utf-8?B?cTkydlZvREpRSTJlbEYzMlRWbzU2TnZCeFpKcTAyRWsvSXBhRWRrUGkxMUR6?=
 =?utf-8?B?RWMzVGpxb2Q1azJsN1UvTFY4S0thM0pjdGEwM3B6VnYzLzlYamRtcExXeWYy?=
 =?utf-8?B?aVhwUTBFYTRTdDlFcjJyOTdsMTl5SEo0K2lmbUlBcVYvam1kcTk5eDh4NXZR?=
 =?utf-8?B?amgzeWt6eTh0NThJQmJqMkJGa05HT283ZkVKS0ZCWnEyVlM0RWljQkh4MUh4?=
 =?utf-8?B?cS9XaWtZM1J3dmFDLy9Ld09ocEIwL1d4MkdwVWVEeUhvUGdkRkdKTHdESXFX?=
 =?utf-8?B?OFk4eDM1MzhzbExFVXJKMFJFWTlIZXQycE9jdjFNZVZBZGNRQUlwdUJZc3pq?=
 =?utf-8?Q?zPtkzBG3laE5bB8zS8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 589a4d8d-ee3a-44d5-7d46-08dd8e379126
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 13:52:26.5914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6756

DQoNCj4gT24gOCBNYXkgMjAyNSwgYXQgNzowNOKAr1BNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+Pj4gLVRvIHVzZSAnZ2l0IHNlbmQtZW1haWwnIHRvIHNl
bmQgeW91ciBwYXRjaGVzIHRocm91Z2ggdGhlIEdNYWlsIFNNVFAgc2VydmVyLA0KPj4+PiAtZWRp
dCB+Ly5naXRjb25maWcgdG8gc3BlY2lmeSB5b3VyIGFjY291bnQgc2V0dGluZ3M6DQo+Pj4+ICtU
byB1c2UgJ2dpdCBzZW5kLWVtYWlsJyB0byBzZW5kIHlvdXIgcGF0Y2hlcyB0aHJvdWdoIHRoZSBH
bWFpbCBTTVRQIHNlcnZlciwNCj4+Pj4gK2VkaXQgJ34vLmdpdGNvbmZpZycgdG8gc3BlY2lmeSB5
b3VyIGFjY291bnQgc2V0dGluZ3M6DQo+Pj4gDQo+Pj4gVGhlIGZvdXIgc2luZ2xlIHF1b3RlcyBh
Ym92ZSBzaG91bGQgcHJvYmFibHkgYmUgY2hhbmdlZCB0byBiYWNrDQo+Pj4gcXVvdGVzLCB0byBt
YXRjaCB0aGUgIllvdSBjYW4gYWxzbyB1c2UgT0F1dGgyLjAuLi4iIGJlbG93Lg0KPj4gDQo+PiBJ
IHRoaW5rIH4vLmdpdGNvbmZpZyBzaG91bGQgYmUgaW4gc2luZ2xlIHF1b3RlcywgaXRzIG5vdCBh
IGNvbW1hbmQuDQo+IA0KPiAiSXMgdGhpcyBzb21ldGhpbmcgdGhlIGVuZC11c2VyIHdvdWxkIHR5
cGUgdmVyYmF0aW0/IiBpcyB0aGUgY3JpdGVyaWEsDQoNClNvIHRoZSBlbmQgdXNlciB3b24ndCB0
eXBlIGl0LiBJdCdzIGp1c3QgYSBwYXRoIG9mIGEgZmlsZSB0byBiZSBlZGl0ZWQuDQpJZiB5b3Ug
c3RpbGwgd2FudCB0byBjaGFuZ2UgaXQgdG8gYmFja3RpY2tzLCBJJ2xsIGNoYW5nZSBpdC4gRG8g
Y29uZmlybSB0aGUgc2FtZSBidHcuDQoNCj4gbm90ICJJcyB0aGlzIGEgY29tbWFuZCBuYW1lPyIu
DQo+IA0KPj4gR21haWwgc3VwcG9ydHMgZm9yIE9BVVRIQkVBUkVSIGFuZCBYT0FVVEgyLiBJIGFk
ZGVkIE9BVVRIQkVBUkVSDQo+PiBqdXN0IGZvciB0aGUgc2FrZSBvZiBhIGRpZmZlcmVudCBleGFt
cGxlLiBJIHRoaW5rIGFkZGluZyBhIGNob2ljZQ0KPj4gYmV0d2VlbiB0d28gd2lsbCBqdXN0IGNh
dXNlIGNvbmZ1c2lvbiBhbW9uZyBwZW9wbGUuDQo+PiANCj4+IE91dGxvb2sgc3VwcG9ydHMgb25s
eSBYT0FVVEgyICh3aGljaCBpcyBzdXJwcmlzaW5nIHNpbmNlIE9BVVRIQkVBUkVSDQo+PiBpcyBk
ZXNjcmliZWQgaW4gUkZDLCBhbmQgWE9BVVRIMiBpcyBHb29nbGUncykuDQo+IA0KPiBZb3VyIGV4
YW1wbGVzIHRoYXQgc2hvdyB0aGF0IHNtdHBBdXRoIGNhbiB0YWtlIHRoZXNlIGRpZmZlcmVudA0K
PiB2YWx1ZXMgYXJlIGNlcnRhaW5seSBnb29kLiAgQXMgd2Uga25vdyB3aGF0IHRoZXNlIHR3byBz
ZXJ2aWNlcw0KPiBzdXBwb3J0LCBpdCBpcyB3b3J0aCBzYXlpbmcsIG5vPyAgVW5sZXNzIGl0IGlz
IGxpa2UgR21haWwgc3VwcG9ydHMNCj4gYm90aCBidXQgZ2l0LXNlbmQtZW1haWwgZm9yIHdoYXRl
dmVyIHJlYXNvbiBjYW4gdXNlIG9ubHkgb25lIG9mIHRoZW0NCj4gdG8gdGFsayB0byBHbWFpbCwg
dGhhdCBpcy4NCg0KZ2l0IHNlbmQgZW1haWwgY2FuIHVzZSBhbnkgc210cEF1dGggbWV0aG9kIHRo
YXQgaXMgc3VwcG9ydGVkIGJ5IEF1dGhlbjo6U0FTTA0KYW5kIHRoZSBzZXJ2ZXIuIFNvIHVzaW5n
IFhPQVVUSDIgd2l0aCBnbWFpbCB3aWxsIGFsc28gd29yayBqdXN0IGZpbmUuDQoNCkFzIGZhciBh
cyBnaXZpbmcgaW5mb3JtYXRpb24gYWJvdXQgc3VwcG9ydGVkIGF1dGhlbnRpY2F0aW9uIG1ldGhv
ZHMgaXMgY29uY2VybmVkLA0Kd2UgYXJlIHdyaXRpbmcgYW4gZXhhbXBsZSwgbm90IGdpdmluZyBh
IGRldGFpbGVkIGd1aWRlIHdpdGggdGhlIHByb3ZpZGVycyBkb2NzLg0KQWxzbywgYnkgdGhpcyBs
b2dpYywgR21haWwgYWxzbyBzdXBwb3J0cyBzbXRwQXV0aD1MT0dJTiB3aXRoIGFwcCBwYXNzd29y
ZHMuDQpQbHVzLCBhbnlvbmUgcmVhZGluZyB0aGlzIGd1aWRlIHdvdWxkIG1vc3QgbGlrZWx5IGJl
IGEgbmV3YmllLCB3aG8gd2lsbCBiZSBtb3JlDQppbnRlcmVzdGVkIGluICJob3cgdG8gZ2V0IHRo
aXMgdGhpbmcgd29ya2luZyIgdGhhbiBrbm93aW5nICJvaCwgSSBjYW4gdXNlIFhPQVVUSDINCmFz
IHdlbGwgaW4gZ21haWwiLiBJbmZhY3QgbWVudGlvbmluZyBib3RoIG9wdGlvbnMgd2lsbCBqdXN0
IG1ha2UgaGltIHdvbmRlciBvbg0Kd2hhdCBvcHRpb24gaXMgYmV0dGVyLCBYT0FVVEgyIG9yIE9B
VVRIQkVBUkVSLCB3aGljaCBwcmFjdGljYWxseSBhcmUgdGhlIHNhbWUNCmluIHRlcm1zIG9mIGFj
Y2VzcyB0b2tlbnMgYW5kIG90aGVyIHN0dWZmLiBUaGUgb25seSBkaWZmZXJlbmNlIGlzICJob3cg
aXMgdGhlIGFjY2Vzcw0KdG9rZW4gZm9ybWF0dGVkIGFuZCBzZW50IHRvIHRoZSBzZXJ2ZXIiLCB3
aGljaCBpcyBkb25lIGF0IGEgbG93ZXIgbGV2ZWwgYnkNCkF1dGhlbjo6U0FTTCwgYW5kIGlzbid0
IHJlYWxseSBhIGNvbmNlcm4gZm9yIHVzZXJzLiBJbiBzaG9ydCwgdGhlIHNhbWUgYWNjZXNzIHRv
a2VuDQp3b3JrcyBmb3IgYm90aCBYT0FVVEgyIGFuZCBPQVVUSEJFQVJFUi4gQXMgZmFyIGFzICJ3
aGF0IGFjdHVhbGx5IGlzIHN1cHBvcnRlZA0KYnkgbXkgZW1haWwgcHJvdmlkZXIiLCBpcyBjb25j
ZXJuZWQsIGp1c3QgY29uc3VsdCB0aGVpciBkb2NzLiBUaGF0J3Mgd2hhdCBhIGN1cmlvdXMNCmFk
dmFuY2VkIHVzZXIgd291bGQgd2FudCB0byBrbm93IGFuZCBJIGJlbGl2ZSBoZSBpcyB2ZXJ5IGNh
cGFibGUgdG8gZmlndXJlIHRoYXQNCm91dC4=
