Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012011.outbound.protection.outlook.com [52.103.23.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CB43BB9FE
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295745; cv=fail; b=YlFG2t4kWBgvPi/axUkoZJPTDiMvWsoHZ3QDFD087hKPIkdLQecMaA+Qmm5KwDd0uOz/QcDiaxKS3WfpFH07IH9dtD+gyUS3dmpx9yoM1k/rTDr4jLSC2CWYMM3cHYKNtezWd79ZMAhpqWhOa2dnj46OFWLzbO6kLecmm84KiWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295745; c=relaxed/simple;
	bh=WVtYJgYy2j6U3Bd332Fn4/VFet78lYWBWN+dWGEiAoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kcAm08moaJnYkKJMNKbo3ofFiQ0Lk7SK+9yurGw98dMFoj9JwjKnteLRbmdVg1FeSWgJXS5RPHbvlrrK6bg7axJ/5P5Rn+2GqdTWW5OiWWpwoemVG9MFUwMImBJctmVQLPEv1N/HDbknBPJqMowOsvizVB5XfXZfmqwD1FVMBR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BIdw/M9H; arc=fail smtp.client-ip=52.103.23.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BIdw/M9H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1WRckY66s7l62r3hPJmL4GW3czdUCLE+BxN8HAZdMidZdqpQm6Tck2L5UTiXEEbOf0qSsNn/4p5L2TVA1Bv58VaZdM4AUKi4r5NQVCou64vPuEjm+uIS8+XeB8JWa5YQ5f29wECpACN+o0Hj5kkkQDa6VEz3JF/fimpCd04TfjzAMbgzTum6v4LeeD6HqrMxOe8fixwj3uI9S0cGCrCvm1AMgy9vcc61uJbHHaBjglHIgQ1+q/bcDrQaeIDw2fDDR8pZK4YACcMcfLFahUhIbWO3zKHrbFfPvzsiIFKaxmRUdEHRS50gTtT5SgsJEf8urVYtoKHFQKGh1iQNaEdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVtYJgYy2j6U3Bd332Fn4/VFet78lYWBWN+dWGEiAoA=;
 b=fTFGmd2zqpKqh3PiFKl3Pkp/pAPmIdW93xFjvRnfePj46Eg3UcrzE+T7UApJzBdJNZ9YSDdjaFM9UK69zppuRiaI3gHhorC7Hph3JWYGC/GfOZpNMn3ajzQ++e13ZUzeuoBmKKLswSz3K1/IbJXFat+L2EOrrCIfn+RlVDWxpffTzlD3t5bCIPXtTl2IYro+mv4zNtBd5IhZ0rOfwpWwnOXHYTD0Oryd0mSdwl9aJeyfwSNQINoS4Y3EG0AtZsXKx0hfEFr5SacuPUdbrLqgz/ThZH6UzfuTb55EEqS4zBQjJGoUdUn7g6LXiKdJKrr5ISWLQT6x91FdvOJJmEim1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVtYJgYy2j6U3Bd332Fn4/VFet78lYWBWN+dWGEiAoA=;
 b=BIdw/M9Hq7aNHvehxWZgCTmyPRzVU1MJCRfbiGTGmuRfLvubN2Nzkixr+vfEaAY2kHoXxILc5RAb17AN7T1JALaTU/i4oN54TalvEFGsJlEPYYhzgi9Ch5xs2lthbBt6/RO5TGp8wN8YvK7hs9kyqHSJwqCkzpwGDy/trEEnQikc3HcNag0X6gW3bd0tUvH9unGurETKqt11b8lvLgLkfNvRxkQqumrU7XRnri+gW7/khHQr1AcdK9biKQHRxnUoT8Z3B7RU5OHNhwb+Y/LfFhsiVKBWlx6ed2DZbcmGswTn4Gg9uN39U7l9jHSv5ilLlJSHzv9q4jOBEFz0EvlwuA==
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9) by MW4PR10MB5864.namprd10.prod.outlook.com
 (2603:10b6:303:18f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 13:42:19 +0000
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f]) by SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:42:19 +0000
From: Travor Liu <travor_lzh@outlook.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t9502: test gitweb index hash formatting with modes
Thread-Topic: [PATCH 2/2] t9502: test gitweb index hash formatting with modes
Thread-Index: AQHdFDn5KQU+olHpPUChmMyVgf//drZxN9aLgAEJt4A=
Date: Fri, 17 Jul 2026 13:42:19 +0000
Message-ID: <77524BE6-107A-40FB-ABD3-E5B391E7A0AF@outlook.com>
References:
 <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
 <SA1PR10MB9977159B51766C2D9FFE98FD37F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
 <xmqqjyqu6u7i.fsf@gitster.g>
In-Reply-To: <xmqqjyqu6u7i.fsf@gitster.g>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB997715:EE_|MW4PR10MB5864:EE_
x-ms-office365-filtering-correlation-id: e3250e57-91f1-48b2-f625-08dee40938cd
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|15080799012|25031999004|24021099003|19110799012|8062599012|8060799015|51005399006|6072599003|25010399006|31061999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmlMaE5NSkFWek1BYUVYa3JNbElKNzVUZEpibGVaYWhMNVhOMFRwbmgwMHdx?=
 =?utf-8?B?Vkd6eWNmMGZhOW56YTkzbTg5YmM4bjBRNGo3RVVMeDZzMlJIRnd0ekI4SSsv?=
 =?utf-8?B?dS8zUTVOaVBUUFRjMmplN3A0ZXpYT21PK0JKcjBJamxVckpGdmR1OFRXWS9w?=
 =?utf-8?B?ZS9YZjJXcGRZWWhNam9IaFVUUmFXL29CbkV5d0E1TktDZ2xDeHYzUHdjSFdk?=
 =?utf-8?B?MHFRWmEyYVV2N3VNNnIxeGhFVTRSaHNPN3FDQ010QWpvSGdEU1JnNHlTK2Zl?=
 =?utf-8?B?NFFCdUZyM3pzeTdzK3ovem1wLzZoZFdMdHMxcXhBSkF0bzlIakYrK1pxY3lI?=
 =?utf-8?B?TVl5NUtLcFVkaTFyL1F1MkhZcWVBdjFRYy9GZ1JjVk5FR3ZaNG9lZnJDamNM?=
 =?utf-8?B?RUxLa2gzVWpLa0p5bzFCQzNJd0pIZ1hWWVFmSElta3czZGUwTkdudEZ2SnAw?=
 =?utf-8?B?L1l1UndpWkp6dE9WOXcrMHg2ODVXS2VmamxJbWoweDZTbDJWemNyR1FmMDVr?=
 =?utf-8?B?Nm9lWlF6VHBjelZsc0NTTjV0OGdpTTNpbXVjWGVDam1DTjBzbnF3bXJNVkox?=
 =?utf-8?B?cThvWlR4LzRTMGlEZml2cGI0bFRhVWMyZXFYbHAzR3FpNGxyVWpUUWlHVEMr?=
 =?utf-8?B?M0VCalJTUkFpcm1XU1QzaUZ0S3gxM1RSVlJKODVaWjF4QXVnejVFUjl3K1Nq?=
 =?utf-8?B?TzFNU2dhd0twY3VtaGROYzBMdDJxaDlPWEVQVm9wMHlkamt6cG1sNUU3dE9J?=
 =?utf-8?B?UnVRdkt3TUVScnJub0VWZDJ5eE9UbHd1VndIVWx0RUpWUDB6cVVCMDBHbUJw?=
 =?utf-8?B?dHRSUTYzeEVBRjJZVEIxOTBkYlFUVUJKNmNvY0VWTTBPSG1HN3RRZTQyeDUw?=
 =?utf-8?B?a2J1cjg3VUlRM0pheVBWUzNDQSs1bkpzc3VXSlp6MjJudDVmNWVxdlNwMkdT?=
 =?utf-8?B?MjE1cXlLdjJnWUtBT2ROV3ZZRUcycDBuVU5kYjNSSk50RytwS0hnVGgrK3pC?=
 =?utf-8?B?SDA2TzNRbURrazZlQmFOVTN5S0l5NUFuckJvRElMcEJGeE9WVG5WSm8rVDBU?=
 =?utf-8?B?M1ZBa0d3eUdZZGs0QWpwaWJpL2NuYXhaeWZWME1wRUVrTWNFR0k4VjllNVkx?=
 =?utf-8?B?L3FJZUdjOU82RE0zVkNkQWVXNFRBWkJuQlZJUmROR0I5SjFQVVNxT1JSZjQ4?=
 =?utf-8?B?YkQyenhESnpiMWJUazhwb1ZnNEtYVXlwNVRuM0ZBSkhzQTZUMStVNlA2MXNS?=
 =?utf-8?B?eHF1RTl2MWVFZlpHV2pkVzVVWHhzbVJuQXc2SDExMzl5bTRtSkxERHFQVTNl?=
 =?utf-8?B?QU5PYVI4NUh0SVpseG5BbEhxaDV4VlJkL3R0bzNZZytGMWZ1RHNETDJxRmZr?=
 =?utf-8?Q?GzPlwknDrbDD4AtQGae1ye3JqvySH+q8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnB3REt3aUxPZE1vK2tYc0FNUUNXcTZtYVJ5aDRuMjlTRDFsNkV5TFRZSVUr?=
 =?utf-8?B?SXpsRDJpVTMrc2svMUlLamI4cmJDQjdTNlk1c2hyNktOYlZYODM3MndXNjFk?=
 =?utf-8?B?WHJ5bTlqMnRXbURjSktSK2d4MGNtd2xIR0VQb2pCSjNseHM2Nm1aUVcvc0RI?=
 =?utf-8?B?V0ZMMjhZeklPZjQyUnBHZzlGaUtvNnJraGhFR3NoMDl4WkdkeHB1eCtFaGdv?=
 =?utf-8?B?OFMweDg1M3VzaDM0YkF0NjVDbXhoM3JzSUtCS0xRd1cvWG1KVS80VEtpUTdo?=
 =?utf-8?B?ckVmSE1Lb0h3SGZSSDg4MW9QWmNYOTdyTVVRYVFUMURYZzlTSXZsc2NiYkd1?=
 =?utf-8?B?WlJWckt5UVRnYVZ0YjFZaTBSUnZrMDMyR01XNnA4bVY5cFZVb0FyTXFYQmFE?=
 =?utf-8?B?T3l6QVc1MDhiU29OQ092M3poTEd5YnVrL25aWUpjaXJPOC8rZzNxdGUrZ3Zk?=
 =?utf-8?B?SHZOTS9QRENKbXRtZk5XY3lVc000cmd0d3JYcjRJMG85a1pheWlRYTdBK3Zi?=
 =?utf-8?B?WTVkbFZXOXFTQUNvWDRYS2grMUFMM0tXNzllWllXQnR1TW1aeUZlcUJNREdk?=
 =?utf-8?B?VGkzTlYwazRadzMreEhFZWVDYmQxbitEVldXT1h4WmlUaHp1akpNT28rR2py?=
 =?utf-8?B?eTRiN1dSTDQ1VTZUaVo2bHQwd2tCWEt5djQxSVdvTHdZaVo1RWRXa21PdjRa?=
 =?utf-8?B?YnFDN1d0VVV3bUR6dS9aZDBsZDliOU9mTGFTclozNjBVekhEUjRFU2pSakV4?=
 =?utf-8?B?WTFLd2FNZnd5RExKTXBzZVhlMWJ4d2kyNm5CL0JteC9RSzI2QXpMTzdSaDVn?=
 =?utf-8?B?SnN0cldjZmJoM0kycWFaSUl4dHk1U0R1MmRlUmw3bFJOaklJZkcyRmhHMXJi?=
 =?utf-8?B?THdiWlpDZ3hZcktremFiMlpxbldLSTdtZk5qVWxRM08vWEpaSXpmbmFzdkRo?=
 =?utf-8?B?U0RwMHlkTjNZV0ROVktvWXRGRFR1K1pFRUlnWGJQdTlXTmZtejRQb0xKSTRa?=
 =?utf-8?B?U2V5R0NZR1dMbGIrZlQwb0xqVjkyVGJKVFd1Wld0Mm5vZ09weDFpc29HZTk1?=
 =?utf-8?B?b2V6L3g2S0VIZ3A2T1U2L3ZxY2dnOVh5NGR2VzVmUXR1RVo4N3NjVDQ0eVcz?=
 =?utf-8?B?QUMwdHlpMUVOdXErSU5PMk5IVHFBWHZpN1BVNllIanRaSTJ6RWVqaStnUmxo?=
 =?utf-8?B?TUtnNGlTZXlDSWRrUzI4UDZ6RGlkWElHcHhCeWJISEt6eXQyNmc0MktPRUZa?=
 =?utf-8?B?dlJyRVJmL0JRZEhJSzI4REpQQ2IyWlNUNi9PaGFpVUpPT1BaNkF6ZmVYcWtL?=
 =?utf-8?B?NEk1cHU0N0g2VmljSDJGNUxndVBydm5OWTFQN3VXczMxeEtXYVJSUFRONW5S?=
 =?utf-8?B?QmZnWVVwWU4rbjQ3ZEJoT3MrVXhvd1dDek1xdE9RcERJYnlJSHFwVnFFL2lL?=
 =?utf-8?B?UDlIcEtTKzllRlJFc21sMXAyQWExWVVVRlpOQnVtd3RHUTF2dXJva2hDK21l?=
 =?utf-8?B?ZFJScjcyaU5PZ3NFbHpaa3ZiNUo3blJORFYxT21XY09yc3JUV2N1SExqbkdj?=
 =?utf-8?B?VmNkdU1wT1NBWGt5aVppdENhTWduWXR5MkhaU1JSaVpFcXIrd2hXcGY2OWt5?=
 =?utf-8?B?NDl3cGNlUzVBUEJ4ZWFFUnkxNThaTTdOZCsxQmpiVG9nbm95ZWEvMWFwb3Bw?=
 =?utf-8?B?Y0htY3JEMHZWK3kzdzVva0huUmJiQ0JpT0hJMjVyeEZMK3hwaHJmUzdMZ2V5?=
 =?utf-8?B?RmxCZlN4bXpmbjNOcitLUTBVbU45QlZmVUxnelR6L2VrYTc5Ly9MZkUyMHZa?=
 =?utf-8?B?MVd0Q0V1aDg4aUE1dVNrQjZvR0dmWDJldlBxa3ljbzBqNDA0eWVZWUQ0RUx0?=
 =?utf-8?Q?bOpVfdu2ZTToK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A71CFBCEF1C2FA4995DEB23EEF067E62@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB997715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e3250e57-91f1-48b2-f625-08dee40938cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 13:42:19.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
Message-ID: <20260717134219.9R4nKeptTGT88IO-rEwMQn_fmm5QhzAvUEM77-FsdAs@z>

VGhhbmtzIGZvciB0aGUgY29tbWVudHMuIEkgd2lsbCBzcXVhc2ggdGhlIGNoYW5nZXMgaW50byBv
bmUgcGF0Y2ggYW5kIHVzZSB0ZXN0X2dyZXAgaW4gdjIuDQoNCkJlc3QsDQpUcmF2b3INCg0K77u/
T24gMjAyNi83LzE3LCAxOjUwIFBNLCAiSnVuaW8gQyBIYW1hbm8iIDxnaXRzdGVyQHBvYm94LmNv
bSA8bWFpbHRvOmdpdHN0ZXJAcG9ib3guY29tPj4gd3JvdGU6DQoNCg0KVHJhdm9yQHdlYi5jb2Rl
YXVyb3JhLm9yZyA8bWFpbHRvOlRyYXZvckB3ZWIuY29kZWF1cm9yYS5vcmc+LCAiTGl1IDx0cmF2
b3JfbHpoIkBvdXRsb29rLmNvbSB3cml0ZXM6DQoNCg0KPiBGcm9tOiBUcmF2b3IgTGl1IDx0cmF2
b3JfbHpoQG91dGxvb2suY29tIDxtYWlsdG86dHJhdm9yX2x6aEBvdXRsb29rLmNvbT4+DQo+DQo+
IGdpdHdlYiBzaG91bGQgc2hvcnRlbiBhbmQgbGluayB0aGUgb2JqZWN0IElEcyBpbiBjb21taXRk
aWZmIGluZGV4IGxpbmVzDQo+IGV2ZW4gd2hlbiBHaXQgaW5jbHVkZXMgdGhlIHRyYWlsaW5nIGZp
bGUgbW9kZToNCj4NCj4gaW5kZXggPG9sZD4uLjxuZXc+IDEwMDY0NA0KPg0KPiBBZGQgY292ZXJh
Z2UgZm9yIHRoYXQgY29tbW9uIGZvcm0gYnkgcmVuZGVyaW5nIGEgY29tbWl0ZGlmZiBmb3IgYQ0K
PiByZWd1bGFyIGZpbGUgbW9kaWZpY2F0aW9uLiBDaGVjayB0aGF0IHRoZSB2aXNpYmxlIGluZGV4
IGxpbmUgY29udGFpbnMNCj4gbGlua2VkIHNob3J0IGJsb2IgSURzIGZvbGxvd2VkIGJ5IHRoZSBt
b2RlIGFuZCBmaWxlLXR5cGUgYW5ub3RhdGlvbiwNCj4gYW5kIHRoYXQgdGhlIGZ1bGwgdW5saW5r
ZWQgZm9ybSBpcyBub3QgZW1pdHRlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVHJhdm9yIExpdSA8
dHJhdm9yX2x6aEBvdXRsb29rLmNvbSA8bWFpbHRvOnRyYXZvcl9semhAb3V0bG9vay5jb20+Pg0K
PiAtLS0NCj4gdC90OTUwMi1naXR3ZWItc3RhbmRhbG9uZS1wYXJzZS1vdXRwdXQuc2ggfCAxNCAr
KysrKysrKysrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KDQoNCklm
IHRoZSBuZXcgdGVzdCBhZGRlZCBieSB0aGlzIHBhdGNoIHZhbGlkYXRlcyB0aGUgImZpeCIgaW4N
CltQQVRDSCAxLzJdLCByZXZpZXdpbmcgdGhlIGNoYW5nZSBtaWdodCBiZSBlYXNpZXIgaWYgdGhl
IHR3bw0Kd2VyZSBzcXVhc2hlZCBpbnRvIGEgc2luZ2xlIHBhdGNoLg0KDQoNCj4gZGlmZiAtLWdp
dCBhL3QvdDk1MDItZ2l0d2ViLXN0YW5kYWxvbmUtcGFyc2Utb3V0cHV0LnNoIGIvdC90OTUwMi1n
aXR3ZWItc3RhbmRhbG9uZS1wYXJzZS1vdXRwdXQuc2gNCj4gaW5kZXggODFkNTYyNS4uN2YzN2Uy
NiAxMDA3NTUNCj4gLS0tIGEvdC90OTUwMi1naXR3ZWItc3RhbmRhbG9uZS1wYXJzZS1vdXRwdXQu
c2gNCj4gKysrIGIvdC90OTUwMi1naXR3ZWItc3RhbmRhbG9uZS1wYXJzZS1vdXRwdXQuc2gNCj4g
QEAgLTExNSw2ICsxMTUsMjAgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAnc25hcHNob3Q6IGhpZXJh
cmNoaWNhbCBicmFuY2ggbmFtZSAoeHgvdGVzdCknICcNCj4gJw0KPiB0ZXN0X2RlYnVnICdjYXQg
Z2l0d2ViLmhlYWRlcnMnDQo+IA0KPiArdGVzdF9leHBlY3Rfc3VjY2VzcyAnY29tbWl0ZGlmZjog
aW5kZXggbGluZSBzaG9ydGVucyBoYXNoZXMgd2l0aCBtb2RlJyAnDQo+ICsgb2xkX2Jsb2I9JChn
aXQgcmV2LXBhcnNlIEhFQUQ6Zm9vKSAmJg0KPiArIG9sZF9zaG9ydD0kKGdpdCByZXYtcGFyc2Ug
LS1zaG9ydD03IEhFQUQ6Zm9vKSAmJg0KPiArIGVjaG8gY2hhbmdlZCA+Zm9vICYmDQo+ICsgZ2l0
IGNvbW1pdCAtYW0gImNoYW5nZSBmb28iICYmDQo+ICsgbmV3X2Jsb2I9JChnaXQgcmV2LXBhcnNl
IEhFQUQ6Zm9vKSAmJg0KPiArIG5ld19zaG9ydD0kKGdpdCByZXYtcGFyc2UgLS1zaG9ydD03IEhF
QUQ6Zm9vKSAmJg0KPiArIGdpdHdlYl9ydW4gInA9LmdpdDthPWNvbW1pdGRpZmY7aD1IRUFEIiAm
Jg0KPiArIGdyZXAgIj4ke29sZF9zaG9ydH08L2E+XFwuXFwuPGEgW14+XSo+JHtuZXdfc2hvcnR9
PC9hPiAxMDA2NDQiIFwNCj4gKyBnaXR3ZWIuYm9keSA+aW5kZXhfbGluZSAmJg0KPiArIGdyZXAg
IjxzcGFuIGNsYXNzPVwiaW5mb1wiPiAoZmlsZSk8L3NwYW4+IiBpbmRleF9saW5lICYmDQo+ICsg
ISBncmVwICJpbmRleCAke29sZF9ibG9ifVxcLlxcLiR7bmV3X2Jsb2J9IDEwMDY0NCIgZ2l0d2Vi
LmJvZHkNCj4gKycNCg0KDQpDYW4gd2UgdXNlICJ0ZXN0X2dyZXAiIChmb3IgcG9zaXRpdmUgInRo
aXMgc3RyaW5nIG11c3QgYmUgdGhlcmUiKSBhbmQNCiJ0ZXN0X2dyZXAgISIgKGZvciBuZWdhdGl2
ZSAiaXQgaXMgYW4gZXJyb3IgaWYgdGhpcyBzdHJpbmcgYXBwZWFycyINCihub3RlIHRoYXQgZXhj
bGFtYXRpb24gcG9pbnQgY29tZXMgYWZ0ZXIgdGVzdF9ncmVwKSk/IEl0IHdvdWxkIG1ha2UNCml0
IGVhc2llciB0byBkaWFnbm9zZSBhIGZhaWxpbmcgdGVzdC4NCg0KDQpBbHNvLCB0aGVyZSBpcyBh
IHRvcGljIGluIGZsaWdodCB0aGF0IGVuZm9yY2VzIHRoZSB1c2Ugb2YgdGVzdF9ncmVwIGluDQp0
aGVzZSB0ZXN0IHNjcmlwdHMsIGFuZCB1c2Ugb2YgcmF3IGdyZXAgbGlrZSB0aGUgYWJvdmUgd291
bGQgYnJlYWsNCnVuZGVyIHRob3NlIHN0cmljdGVyIHJ1bGVzLg0KDQoNClRoYW5rcy4NCg0KDQoN
Cg0KDQo=
