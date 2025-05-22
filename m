Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36567482
	for <git@vger.kernel.org>; Thu, 22 May 2025 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747883909; cv=fail; b=qfpBQpH1RdunipaYP5ygF+RQX7VuknBGd72+MO6lKKqm89i9hyTe0cfXgSuUWQfSlQMn8dMlN9RjFCNTCjrzKbGliNSJaZw3XP6PTXo2+hJEzAP5h1/g4s5ngsHzqhZQ/dyy6BE2KoBWs3I/76SXNC9mG4a9neLwYhN4kO1CnQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747883909; c=relaxed/simple;
	bh=FrSzLFCnNj2Mz7CrTrCol/mMGYtQayeTRTX3qihyisY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HTU42X42nbw1UBNVqXQQl466JrPr8OpfsAvGFwJKdLwjycIfh2tAe7KCpCBZ/YNxsXt50KU5QlFug6ktTNk06Wa2jDT8AhIGxUgUgRS1FkZtVWOhzGQXiKUkAf6/Mp6teZxRwHidYgoi2RU+5Bys/r+vdYjqyylB7JtTa1Zg1bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=A2UFBxiG; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="A2UFBxiG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcBpc8UwMLRDvxESDFl1vaN6l02khMuIAlOkLOd9FLrk1CCbweTbyb41xRwUZKhR+Wt5Ga/e/kPxULx9i87CAocbWIj4tK8NxUnFX/hkMH5PkS5nBwEiaT/sheaYj4P96M9NUAlcbR9LG5jr3EwcSqrAL9ZR/YisVoz6wDuTNDr0HBMOVChUhgWQjtHfOeJbQ5Hs5DF0jRnlBwPFYBa4Jpn9BauLrCdIIfSz+6fo7KmySTMoFR+5ZgO+bMvGoUKdjmO+2YdnL4i5QfQe+ChSq3Iq92VgJNvWwo73iw0NoQsUJTZoMRTyGW29UTVmg1R3ZITJvRvJUFIHeOKDBRxEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrSzLFCnNj2Mz7CrTrCol/mMGYtQayeTRTX3qihyisY=;
 b=er4ty6/KEMLEb12lJXts4TCOqkVFu11Iza64QYZW+ht0j/2OVYjGTcFLDo7rmO7PYNHtTf1NNq7bubKGvkWPWIZb4/QQlHlXRjCWVKJPTeLdjhv/U+8eZV78HU4vgnYPvFuFQDUh3UJ9tINqgbYlTWbK9LrHgmYSZzVzU5J65Gm5BXnLZp9MA0J3rEK65lryhcbPsvSEVn3wTvHct/HewTdd+y8SEikkpiskyBK+Oy4pgkQqJHAWyWQRjlUddffr93QJxtj5+sqhTNTsxdcyV5ZxqftEzvU09xqWz88VfDDxXWu5OHngVBXJxNHOxahIk6TuBoTyNgpS2z1KLDg9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrSzLFCnNj2Mz7CrTrCol/mMGYtQayeTRTX3qihyisY=;
 b=A2UFBxiGArOFLxs7+Az9/vJ4onXqgocbZfjdRaK6yER/zx9IzVuIYC38ns3HX8QF8OfJor8KRW6nTXhLlTo6fCSOWwmwkMudwdyNrhjRrUkbtPSU50qsjs90mPJg81XZxcqKb19iXbNPanWby6m2L3MnSuYKAjqMOxLT7sueB63ZYwPMKce6CdRJ8GbNdruIqdSGNeUKXbC8CScPHjFt7tWsDgnJQAKDSwfE0UdlVku3pQkq6LjCZF7csToVIwzCXISkBtdOJQ9zc5Ox6I8qp5KLv1J+tttkwv2HxYc1v6/Qd+jBIrRLJy0/Qrza5oN4EaVJL7Puw4rpz3VNtiwUbA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB9390.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 03:18:23 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 03:18:23 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] help: inform about 'git update-git-for-windows' on
 Windows
Thread-Topic: [PATCH] help: inform about 'git update-git-for-windows' on
 Windows
Thread-Index: AQHbylvTlLuDO4ZN7UeY+IyrVP1KmLPdoecAgAAHYyeAAApjgIAAR/PE
Date: Thu, 22 May 2025 03:18:23 +0000
Message-ID:
 <PN3PR01MB9597B771CBDF19569B89AD1DB899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FDF30B7CE529985DE546B89FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597AFD63B750703E90AD18BB89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aC5MOl66YuIK1eyU@tapette.crustytoothpaste.net> <xmqq5xht8uxm.fsf@gitster.g>
 <aC5bI_Y9-ZQPXJ4t@tapette.crustytoothpaste.net>
In-Reply-To: <aC5bI_Y9-ZQPXJ4t@tapette.crustytoothpaste.net>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB9390:EE_
x-ms-office365-filtering-correlation-id: 425cde12-ece0-473a-6a7d-08dd98df4f4e
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799006|6072599003|21061999006|15080799009|7092599006|8062599006|8060799009|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnZnTTZaVUNVeTBYSTc5TEZ2RS9qemE3Y0xhdGs0cWhIZk9lT0tvRUM5T0JN?=
 =?utf-8?B?NXdwYWlBUm0rWVA2TXR6cU1DYWJ5QUxMakZMUXN2WmE0WDBxWTZ3eGgrZ0xN?=
 =?utf-8?B?TDkxQU5sakxxbXd0eWZZb1EwY0FtM1RzTm9KNkZFR2VSQUJSb0Q3MUNCZjJk?=
 =?utf-8?B?clhZc2ZXRnlnOWh2aXBzL3BQby84MytTR3FHMHlucWxLYWsrUGVvejNnVHR5?=
 =?utf-8?B?bkRwRHJpNGRKdjJQOEl0RkcyeHJiWms1eHlhWkI0Wkhlb2xGNUxLUFJuTlZk?=
 =?utf-8?B?NldSeUhlZTR2L3BwdTFtVjRjRmwyVnlkcmxvT1FMeTBWWERGOVZacEw2ZmJQ?=
 =?utf-8?B?VG5jb2NpQ0NRRXBvVWpIbktuWHFCd2hPaHdKVnEzMEt1T3ViMnF0aFVIQzlm?=
 =?utf-8?B?cXlLWTJ4M1JNRnVOaGZBZDFyTmN5UjBxNDlWd0dCK0lCVEI3R2hWbTFwVE4w?=
 =?utf-8?B?cGl5SW5GdGw0L01JbXl5b0RFZVU2eVIvYTNwT3N1TERwVm8rSEd3QXJ6em5F?=
 =?utf-8?B?ZkFPTlJnOHQ5RjJxdG5TN0lmK2FLeGZ1R1YvcEcrMlhjOURBNkZHZ0dTSDY1?=
 =?utf-8?B?NXJvbTFpakpkbnNyN0d1YThkelJOTEpuditQV2tGdHYwZVd0US82RmdCcmIr?=
 =?utf-8?B?Z3FkLy9jTUM0S0w0ZVZwUVdoYndocG5ubXJOZnBvYVR3c3RjSGd1cTJVZnpD?=
 =?utf-8?B?cXVKcDY1aDNnaU9GUmZFVU1aTE54M3pUOE9qbnY1M1Z0cEN6Qm40L3pCWWxC?=
 =?utf-8?B?YjR6L2ZMZEQ3SVRwTFJ5b0xWTUMydFJyN01hVEpOU0xLNXpDQ2dSREhDc01Y?=
 =?utf-8?B?VHZac0RRTWp6MnJUaUhla2RIbzd4Ulp2UTV6V2hpUkk1Q0ZRWDJHOG5ZYUda?=
 =?utf-8?B?YzN5dFFkTEoxK2lweklwWlF3Ny9EeEFJSzBJWW16SW5IQUlaMVVEbm1XSGZk?=
 =?utf-8?B?dkxpWkFUVkRUd2p2MkhBTjV2ZlFlTGdrZWJQSlhKNEZ1OForS0VHZWVHenFP?=
 =?utf-8?B?MW8yWEhwZEVDQXdXZmNTWnVwUFNSU0JQeXpCNmZ6NE9VVi9zMjJZK2NRdWNW?=
 =?utf-8?B?aDdzTThQbVpNM2JBVTg4cGl4QnF5M2JrTG5zc2cySDR1dGRBc21XRDk0bWF5?=
 =?utf-8?B?YlJxVGgwdUdvRk9WY0dKV002RFB0ZkI2MmpmbTNOY1IxM0lqRDZyTEc3eFkr?=
 =?utf-8?B?TCticWJjTXJQR1I4MnZUWVVJZ0JWdDE1eFhheFJJKzlGQTJxL0haQmZ4L25O?=
 =?utf-8?B?bk1Ib0Eyb3RGSTZTejlPVzJGKzY5aXZUWnJhSUw3TWhwajVTczBlaVJxc1dB?=
 =?utf-8?B?cWh0WWZxTVZhY0NEbGRQTGx0UFlyYUZGK1IweGR0K1JMaXl1bE10b3B2Zm1z?=
 =?utf-8?B?MnBraWFQWXZWTXUyS1RaMEZPZ0cwWkxyZGhzOTZBenp0eUdVZ0xvaWQrNXZa?=
 =?utf-8?B?dGVsZ0hIamM3YnhLNmhzaXhLY3FOUFI3NGlJZmZGTXk1djcwd01DSDFOM080?=
 =?utf-8?B?WEN5cnlKcnhBYkJPb21tWWx5N2xENDdHbW5qdnRZOEtBUFFZZ3VrSmlHeGRL?=
 =?utf-8?B?SXVQN1M3KzdLL2Q0VlNWNVdWR1BsQlQvN01lcERxd0hFR21NWHcwUVhRd0FS?=
 =?utf-8?B?Y25vc2hRam53OTYra3Exak13Yzg3SVE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnFBMWVId1U4KzB3REMwRTFXSVlxWFdYSmYzdzBSOW1ob2dndFJyd3RTd20r?=
 =?utf-8?B?ZzV6ajl4WXdPVFdaQWhkYnFNbDFVNzc2UzZ3OXlZbGpocVhtKzRmbWZhaDZD?=
 =?utf-8?B?Zkdmai9IS0FGSitvNUJhc3dkSGs0WmxvK3FkckxWT1ljWll1T1E1Zk5VWmti?=
 =?utf-8?B?OEVYZjhKamNwZHFraXFCa1N6NXEwOGpRTkg4WkpORXJVSk1wbEZiOTRhWXI3?=
 =?utf-8?B?ak41WENwOHlkejN5aWhiZVNIWmcyVlZKNkQ5OURCd2ZqVXFuNjhQeXBDcnVS?=
 =?utf-8?B?WjdKMHB6ZFU2Q0Myd2M3T3hCVWh2TnVjOUVOWll3aXl3RFVMK2NCdHpLM1dM?=
 =?utf-8?B?cEpZMi84OC9BZnZ2N0dtSWU5K05wZHFFZXdsdHEveUYzTTE0c2JtR3JOZTdL?=
 =?utf-8?B?TmJmRTZMTnhPOWpka3FGR0RLeEpHbTU4UXVaTmFXSXdkK3dCck9xUmVFckZq?=
 =?utf-8?B?VFcwZ2huU01LUW9mcTdiZU1ON01FM3czeDF0WUh2K2s2OVNHMnBvamJsL25o?=
 =?utf-8?B?SlZFM3o1UWdMdUZudnQ4NENseDRHV3J0eWtjV0doK3BMVlhiakppOTNydXBq?=
 =?utf-8?B?bitVVzBKOHNZVUpUelFYUDBkTDJ1MXFsZmVldXhFbS9wd2lKQ2REWHR0cFNw?=
 =?utf-8?B?eTNYcW1LM2dSQUlINjZiTHo0U1NzNzc3Y1ZxTG9uaitNbVZGQUQ3VHFIc2V0?=
 =?utf-8?B?akRuUzFOakhyZTFsQitDN0pTbkpHeFVuYWJwWUdWeU03OFNIdk02WGJQOXV5?=
 =?utf-8?B?dU1ra2pFNFRCNVBzM0EvaWhuQlMvbXhvKy94cjJUcnYrWnB0RDhVbzlPdUxB?=
 =?utf-8?B?cng3ZXE1QW1YamxabkNjS1QyRUtPZlNKZ0lZY2JOaDBFdG1odjNEdGJRY3pj?=
 =?utf-8?B?allNNG5pcHNkb1RpVUlEZklXaUJoMzBHNHhTd2JDQVM2UEJ3bTZrTEV0L0FH?=
 =?utf-8?B?TTQvTHNFWTFKOGNvck5PbUdyMm4zdzhTcTFEWmlMczlLTDVNQllMZ0pvVU9V?=
 =?utf-8?B?bHZYL1hPVzBZUFNxWVlkN1ppUXozMlNldWUvU1hXMytCUG91QXRWdGxTUVRw?=
 =?utf-8?B?R3pOWmpVWUcway9EcTZ3SWtFQng0cm9Tc2ZoZ0ZqNkxlZFdCeTdDUGVnOXpU?=
 =?utf-8?B?eXlsTHc3ZTlPOStFMVJPNXJMaGhES1hNVjQrRTNSZHBTcnFZUFE4dnN3OXZR?=
 =?utf-8?B?T04zQWZvZEthV0dRcHFrbGx1MEM3VWE1NzJIRTVVVzAyN3FybzdtQUcraUps?=
 =?utf-8?B?cUtVclA3VXVZSzJUVnRGSVhLeHgyYUpveU1odUVkTXNYbCtKMFp2YS82RnU3?=
 =?utf-8?B?ZEFEd2pVclRzeXlvbFpNNkRxM3dLbmRSTGtkN2xQQjVmVFVBOUdNd0p6T3VB?=
 =?utf-8?B?aytoazh3NFJZaVVQT0lYTDJoNmVLZHNpS1lqb25sYjJYM2JqVHl3Uy9aWmpa?=
 =?utf-8?B?K1JXQlRMQWN4TDQwVEJEOTdnbVM5RDBuRGhya09vLzNYblU0NFA3ekpWY2V5?=
 =?utf-8?B?YWxKTHFHdUUyNEQ3VkhmVFBtWVdZWUxCdTlCbUhPTEFlUlkrZFh0ak1qMjhT?=
 =?utf-8?B?bWRjaEUzTjBmL0U2V1VsblJYQzl6TXV1MVdGd3R5aWI5SHV6bGg5YXZZcXlT?=
 =?utf-8?B?cGlBTWhRUnRZb0hpQ2hvYmN2RytwTjZxSnBiNjhlSjhuZlM5ZWJaM2IyOXdY?=
 =?utf-8?B?YWVveHZFS3JkWWFDajZoZ01sQ05ERWN4NEN4ZXFna3p0OEdwWTBIVmNJN3M1?=
 =?utf-8?Q?Jqer/Z56U7Z5n6XqzQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 425cde12-ece0-473a-6a7d-08dd98df4f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:18:23.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9390

DQoNCj4gT24gMjIgTWF5IDIwMjUsIGF0IDQ6MzHigK9BTSwgYnJpYW4gbS4gY2FybHNvbiA8c2Fu
ZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gd3JvdGU6DQo+IA0KPiDvu79PbiAyMDI1LTA1LTIx
IGF0IDIyOjIzOjMzLCBKdW5pbyBDIEhhbWFubyB3cm90ZToNCj4+ICJicmlhbiBtLiBjYXJsc29u
IiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gd3JpdGVzOg0KPj4+IEkgZG9uJ3QgdGhp
bmsgdGhpcyBiZWxvbmdzIGluIG91ciBjb2RlYmFzZS4gIEl0IHNob3VsZCBpbnN0ZWFkIGJlDQo+
Pj4gY2FycmllZCBhcyBhIHBhdGNoIGluIEdpdCBmb3IgV2luZG93cy4gIFRoZSByZWFzb24gaXMg
dGhhdCB0aGVyZSBhcmUgYQ0KPj4+IHZhcmlldHkgb2YgcG9zc2libGUgcHJvamVjdHMgdGhhdCBj
b21waWxlIGZvciBXaW5kb3dz4oCUR2l0IGZvciBXaW5kb3dzLA0KPj4+IEN5Z3dpbiwgTUlOR1cs
IGV0Yy7igJRhbmQgb25seSBvbmUgb2YgdGhlbSBzaGlwcyB0aGlzIGJpbmFyeS4gIEl0IGlzIGV2
ZW4NCj4+PiBwb3NzaWJsZSBmb3IgdXNlcnMgdG8gY29tcGlsZSB0aGVpciBvd24gV2luZG93cyBi
aW5hcmllcywgd2hpY2ggSSBrbm93DQo+Pj4gaXMgYXQgbGVhc3QgZG9uZSBieSBNaWNyb3NvZnQg
YXMgd2VsbCBhcyBzb21lIEdpdCBjb250cmlidXRvcnMgb24NCj4+PiBXaW5kb3dzLg0KPj4+IA0K
Pj4+IFRoaXMgY2hhbmdlIG1pZ2h0IGJlIG1pc2xlYWRpbmcgb3IgaW5jb3JyZWN0IGFzIGl0IG1p
Z2h0IHRlbGwgdXNlcnMgdG8NCj4+PiBpbnZva2UgYSBiaW5hcnkgd2hpY2ggaXMgbm90IHByZXNl
bnQgb3IgdG8gdXBkYXRlIHNvZnR3YXJlIGluIGEgd2F5DQo+Pj4gd2hpY2ggaXMgbm90IHZpYSB0
aGUgbm9ybWFsIHBhY2thZ2UgbWVjaGFuaXNtLiAgRm9yIGluc3RhbmNlLCB0ZWxsaW5nIGENCj4+
PiBNSU5HVyBvciBDeWd3aW4gdXNlciB0byBydW4gdGhhdCBjb21tYW5kIHdvdWxkIG5vdCByZXN1
bHQgaW4gYW55dGhpbmcNCj4+PiB1c2VmdWwgb3IgZGVzaXJlZCBoYXBwZW5pbmcuDQo+PiANCj4+
IERvIHlvdSBtZWFuIHRoYXQgdGhpcyBpcyBPSyBpZiB0aGUgI2lmZGVmIHdlcmUgbW9yZSBzcGVj
aWZpYyB0bw0KPj4gR2l0LWZvci1XaW5kb3dzPyAgSnVzdCBiZWluZyBjdXJpb3VzLg0KPiANCj4g
SSBkb24ndCB0aGluayB0aGF0IHdvdWxkIGJlIGEgZ29vZCBpZGVhLCBlaXRoZXIuICBUaGVyZSdz
IG5vIHN1Y2ggI2lmZGVmDQo+IHRvIG15IGtub3dsZWRnZSBhbmQgd2UgaGF2ZSBsb3RzIG9mIHdh
eXMgZm9yIHBlb3BsZSB0byB1cGRhdGUgc29mdHdhcmUuDQo+IFdlIGRvbid0IHRlbGwgcGVvcGxl
IHRvIHJ1biBjb21tYW5kcyB0byB1cGRhdGUgdG8gYSBuZXdlciB2ZXJzaW9uIG9mDQo+IHRoZWly
IERlYmlhbiBwYWNrYWdlIGJlY2F1c2UgdGhhdCdzIGEgcmVzcG9uc2liaWxpdHkgb2YgdGhlIHBh
Y2thZ2VyIG9yDQo+IGRpc3RyaWJ1dG9yLCBhbmQgc28gdGhlIHNhbWUgcG9saWN5IGFwcGxpZXMg
aGVyZS4gIElmIERlYmlhbiB3YW50cyB0aGF0DQo+IG1lc3NhZ2UgdG8gYmUgaW5jbHVkZWQsIHRo
ZW4gdGhleSBjYW4gYXBwbHkgYSBwYXRjaCBhbmQgcmVjZWl2ZSBhbnkgYnVnDQo+IHJlcG9ydHMg
b3Igb3RoZXIgZmVlZGJhY2sgcmVsYXRlZCB0byB0aGF0IG1lc3NhZ2U7IHNhbWUgZ29lcyBmb3Ig
R2l0IGZvcg0KPiBXaW5kb3dzLg0KPiANCj4gSSBhbHNvIGhhcHBlbiB0byBrbm93IHRoYXQgaW4g
c29tZSBjb3Jwb3JhdGUgZW52aXJvbm1lbnRzIHByb3h5IHByb2JsZW1zDQo+IGNhdXNlIHRoZSB1
cGRhdGVyIHRvIGJyZWFrICh3aGljaCBpcyBub3QgaW4gYW55IHdheSBhIHN1cnByaXNlKSBhbmQN
Cj4gdGhlcmUgYXJlIGFsc28gY2FzZXMgd2hlcmUgYW50aXZpcnVzIGZhbHNlIHBvc2l0aXZlcyBm
bGFnIHRoZSB1cGRhdGVyIG9yDQo+IG90aGVyIHRvb2xzLiAgV2UgZG8gbm90IGluIGFueSB3YXkg
d2FudCB0byByZWNlaXZlIHJlcG9ydHMgYWJvdXQgdGhvc2UNCj4gcHJvYmxlbXMgb3IgdGhlIHVw
ZGF0ZXIgYW5kIGlmIHdlIGF2b2lkIHJlY29tbWVuZGluZyBpdCwgdGhlbiB3ZSBhcmVuJ3QNCj4g
cmVzcG9uc2libGUgZm9yIGl0LiAgT3RoZXJ3aXNlLCB3ZSdsbCBpbmV2aXRhYmx5IGdldCBhIHJl
cXVlc3QgdG8gYWxsb3cNCj4gcGVvcGxlIHRvIGNvbmZpZ3VyZSB0aGF0IG1lc3NhZ2UgYmVjYXVz
ZSBpdCBkb2Vzbid0IHdvcmsgaW4gdGhlaXIgdmVyeQ0KPiBzcGVjaWFsIGNvcnBvcmF0ZSBlbnZp
cm9ubWVudCBhbmQgdGhleSBkb24ndCB3YW50IHRvIGNvbmZ1c2UgdGhlaXINCj4gdXNlcnMuDQoN
Ck1ha2VzIHNlbnNlLCBsZXQncyBqdXN0IGRyb3AgdGhpcyBwYXRjaCB0aGVuLg0K
