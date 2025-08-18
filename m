Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010000.outbound.protection.outlook.com [52.103.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39710957
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549971; cv=fail; b=MnA1LQjLOOmqYf2XyQfaKuJf33X0vlLylVCOn0vUkBdEaOxwHDWmz7xPgEuEEQqkncej8CFhAc2F7pVb+rxLkJ0V+Q+zhS8sTwKQfwJOJcuzQIspZPfJOtDrnJJgv7pnOLad/CVhBY0ZlofGENBhrGxBGrnLDM6XAmbqcR8uhIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549971; c=relaxed/simple;
	bh=ARrY2Ocxrcqo/9Z26xyglQjCuN2Twzyg0sosLNUranY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkIhjxL4V1Vg6zZlEzOtnHzvSGuASDEL80Buyx714Vqb+9xMuX+hYEOuVnnMpXyz0ABP96ofm4PBP4x4C2lHEno1PoAVuorWvkndWoNDXT0dyKU8BIDZV8GD1yUacGU8XGICaEWkX0708u+Nmlpz/RldHeRq0dNkpINVI9d2iJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au; spf=pass smtp.mailfrom=live.com.au; dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b=HyU0tlll; arc=fail smtp.client-ip=52.103.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b="HyU0tlll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED8ZbU2t/tL9uCKd3rR0pQp7Q/2x8lTkCB6RQgVGeUixycnVaTxSXt1Ysk8GVxhEAlpYKuYYTa1QDeFD/sp86XcgXG+FtEv3E5O4SnMp01fHsfPss/18a2OWdwfRlzakkEyVcP7QsEanuH2OiPA7w6BKUst0NeuQsxfcCx53cmxZ9Zbarti0Z2KrrBWFfO83vfUUSYu1wU2CSJH4+w0K0k/a8fF2G3NOXoa6O4cyI28/HYVa8Y1N8Vm2MFRu1b8i2bdU1+BLNQFu0XWypKRakfdwTH6D9fhYaKHqgCfxtUsAv5TEszmIYHGpngMH1LGQucrpqjv8fkymXY0ZADYxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARrY2Ocxrcqo/9Z26xyglQjCuN2Twzyg0sosLNUranY=;
 b=TP1U7iriVfsq2jgDRk4+RYkVsSgVEnyLtPEbZz4VxsegSuU8mpxqitsUG9tt3hsufgGdNH2Xp161ApyN3Xltz6/y3odb5v3CM/b/IrJdfjD9sylgpcK0crxdEUlfW515mUTdk0x9w/DCN1QZAIP+guMAO827BjjadFdD3+ZJVc9t34TdLj8o/nPMP6+r4575cSDcmZHtqqjmZ+UOTAKXPUHwP0Gg3KJLamZ6B3JiwCjJki4TrqgRu3ITZkoaOnjETzb3yUnG79ne/BhX5967R4NGjt0Zt97KtGZAR7V4zhcgbfzX4o5ocBcvgvFqlp6M1E3ihoqcC0DJsoLYZMhTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARrY2Ocxrcqo/9Z26xyglQjCuN2Twzyg0sosLNUranY=;
 b=HyU0tlll1baLYDBs1uOgWsHgIINDmHgqD6ijCumzWqlMHJ0v5m9MXTTQx+3/0dZoUls8AiiydnNJlFwuHWN0grzgZqBFPnDmz53BgjxLy7BfAXxK+LECyu+w3VT09BZHQ1sEYby69jgpnqj7fDBpd+CfzxWMjVmehjw7WzGSa2ebkAkGHK2e146fpTHI1tyJWstItf1UGrVXjPmEDy0y6pyEDldBRzq2x8hqoZ1b2/tjql26QndXUI6ZnqrPjTGZCBkcidWJWz1oeCknH9Nqmfha31Ut4OLcKJJZeWsVszeU0kIx7cMxCe1kJN5UWwf0j5k488H8rp1h8neWdqBJIQ==
Received: from SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:156::6) by
 SY0P282MB5015.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2a6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 20:46:06 +0000
Received: from SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
 ([fe80::942e:8672:69d1:38dc]) by SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
 ([fe80::942e:8672:69d1:38dc%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 20:46:06 +0000
From: Isaac Oscar Gariano <IsaacOscar@live.com.au>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] allow git rebase while already rebasing
Thread-Topic: [Feature request] allow git rebase while already rebasing
Thread-Index: AQHcEGhGq/X2rE8Q80WKJjnBKrqDX7Ro1ksAgAALC+I=
Date: Mon, 18 Aug 2025 20:46:05 +0000
Message-ID:
 <SYBP282MB2963C3EEE09AE697793529AF8C31A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
References:
 <SYBP282MB29631756F18E53B16F2550848C31A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
 <aKOHuOYFbvHpONaN@nubble.lan>
In-Reply-To: <aKOHuOYFbvHpONaN@nubble.lan>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBP282MB2963:EE_|SY0P282MB5015:EE_
x-ms-office365-filtering-correlation-id: 63920d70-462c-4ac5-e252-08ddde9840ce
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15030799006|15080799012|461199028|8062599012|19110799012|8060799015|6072599003|102099032|1602099012|40105399003|440099028|4302099013|3412199025|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWExSWlZKzJTaXF3WVVSWnVqQ0cvd0lsS1ZtNE5QNmd0R2o2RE94R1QzZXQ3?=
 =?utf-8?B?M3VXb3JDa0UzNTUwSEErUDV4RE16a2NCcnZVVlNhMlBLNGZJOG5kOWFqTHhN?=
 =?utf-8?B?bzNnL1FQQlJtK3VqWGdwY1RtSFNqUE5sUEtDakRqVFJ4dEd6TzZSYnljTk1x?=
 =?utf-8?B?UGFib1BhUjY5U3d5UEFsbFY0blA1REFjbTU3Q21yWTN4ZWU2QkJVUFJXMVds?=
 =?utf-8?B?eCtHMUZWOThreklNTUJCS25xSTU3WFZla0ZCSmcyUHNSWkU4RUpaeUduUUUx?=
 =?utf-8?B?cnRxRlY3Q0FYT004ME5xRDhFSktpYnI4RWpOR0Q2emNHMmZVNWxXTVpSaVR3?=
 =?utf-8?B?bXhYK0MvaG9PcEdOTk9kcjBLYi9QY0ZwM2dQa1JwdnhSWWtWVU4wWnV4ZEsr?=
 =?utf-8?B?d3hzQmIzOHV6cTB1TlIxVXZJUTRIL2ttUDlDTUtscDRZWGtIU3ZlSUNzRGFp?=
 =?utf-8?B?MWtQbnFZMy9TNWxlZXhNM2JhWS95NTVYNDZ0RE11ZzJ2VWQvcU55c0N2YXBC?=
 =?utf-8?B?dWhRLytHNE5QSSsyVmZaZE1Db3FxZU0wYkVLZnlQOXplRUxVWEk4MkxuZVJa?=
 =?utf-8?B?RFE5L2hKNkRUSDU2NnJ1UHkxS2xsai9sbUVTd2lKWEk5OVdBZmRRTWw4NzJt?=
 =?utf-8?B?TDF5d0xnczJXdldDRGNCbE45YjAreHp0Mkc1RHhmRkdia2swaWtOZThUdFpH?=
 =?utf-8?B?bm1IaVh5S3BmUXFWTkR5Q1BMd0t3djR0U2JwTFd4M01SSnJKdWpUT1RCbkd5?=
 =?utf-8?B?Q0tFTEFHVFo3azhHTEx5eFg4VHBTaUxsci9SL1JSWEovb1IrSnJ5dDV6MklK?=
 =?utf-8?B?UHFhd0RGZFA5YytHaUlVV0dKUUhyQU5Xb1JkTEp6bk91R2tnZW11UFdQM3Jn?=
 =?utf-8?B?U0labG90NjR3NnlGRzlBcmU1RjduZzNsQnNwZit3a29OMFFRSmlGWXUvRGxK?=
 =?utf-8?B?aFhOZFRkeHYrS1hLZkRBZXJYRFlZT3dYQTNVdytsOFhNZjVpL1FNUEVsK2RB?=
 =?utf-8?B?OS9MK1VjaTNRd1hnYnBzaGhEbStRenRUa3JCbFdrcTU3b2c3QlVYTWtnYkdy?=
 =?utf-8?B?SC9WRzJTc0ZxeHNZTE5nbnd1dXpoWU9TcS9VM1R1Nm9vbDR6djhoaHZ6bGlR?=
 =?utf-8?B?RzdMaWRJRXhpU0UxTlZFS2wxdXZuaGo2WW5hWWRyVzV4NXZJam1tLzVuNjBy?=
 =?utf-8?B?OUgyTGtObVZjK1BlbndycUZneldZN1FxenlWOWxIL3lhcXk1RHFUbFdsb1VV?=
 =?utf-8?B?MDMvSC9BRnYvOVRSWE9CREZZUmUxbW1FMTJpVXhqSjMrcG1rWVFHYkQ5MmMx?=
 =?utf-8?B?cWduQUp3Mit4NGh6a2F5N1V2NnZEQ2czSWFWTW4xa3hoMUw5TGEvck9iWEZ2?=
 =?utf-8?B?eCtROUNmOC91RU00elY1MUhCa0o5dUN4UTdtUkprVlo1Q0lyRSt5SzN6Qlpo?=
 =?utf-8?B?R2NMWkN4bTNDT3RhalVteGR2cnJrL1BPRlVSVmZzbHpiVHFzQ0VPV2wwaVV0?=
 =?utf-8?B?QzRZSHM3MUN3QWxvN2tMU1ZhU3hDTFJTYUNVTUFEVjg4c3FOSG9VZ3JRN3Qw?=
 =?utf-8?B?cWQzcWxmV3RqTG9rejhrTDBKWEZJa0FCM2E4aE1jWFhSUWhXMCtnT0plT0V3?=
 =?utf-8?B?TzZMUU1VS0taaTVRbUV1STlEeFFUWE5LNWc0Sm50QUF6M3Q1Unh3NUFYaGNE?=
 =?utf-8?B?SEkzMUgvVlc1NElGckhQMWVWaWtlekVXRmNBMFBPZFVjdG1VZDl6cHBiaDZX?=
 =?utf-8?Q?A9GFZ0bA2eVW/5ft2Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnNrV2tBb3kzWTR2OEdwM29KNk1yL0JrbzZpOE5QZFlUaFdNL3B1aE56MEMz?=
 =?utf-8?B?K3k5YmphUDFCTW81SHlxTHBTVUV6bjdoMGNrSEtvNjV3R0V1MVpvVko2NXhm?=
 =?utf-8?B?RXdXR2hZOFRHaVI1OWRocktKM01jOGxyOU15YXg5di9PNmxPL0RiL2Y0VTVR?=
 =?utf-8?B?a3NmRkxKZ1FyK0EvTldNaEdNaVFMN3V5dnpYMjRkbEkrRlVacWQrbnhJeVRO?=
 =?utf-8?B?M0ptZDlkdEd0TTB1YTBpUmczditVaFpTTWpWV1NEWmdYU1IrTlF1amhsZEdz?=
 =?utf-8?B?MlJOWnFkVGdGZnRUM01GUHpVaVZxSktVckdVN0FlTlExbXl0eWRmemhseXpS?=
 =?utf-8?B?VXI4SzNDanpyYzllanZsengzZWFZTHBCNVdHc1piTnlJR2NtdXRCaXk5Q0gz?=
 =?utf-8?B?QWNYeWlYdTVWU3d1T0t1N3VLeSt4c0NLRWhqT0JDcElZM3ZiRk1mVUFhNUJ6?=
 =?utf-8?B?Y0Flb1VPSHBFY2w1T0pVcFU1TzdnTUMvNEJGTGFVejNOOXdueVFpczdkYnBY?=
 =?utf-8?B?SFp6Y0NUcWs0ajRjd0xJdW1LR2U1TlZHSUxFcEtNM0JGR3B2NHFKcmp0UWtN?=
 =?utf-8?B?cVhhQk45c2phcWVLQUYwaWxJYnpXZGFJcVpCL1VkUGVpU1NLSnloenRNOWFS?=
 =?utf-8?B?TDh4SktGWmhRRDhuRTJEc2VoN1dEYW1iN1NiSm1BbVFCc3U1NUk4bSsxa2Vx?=
 =?utf-8?B?UVc5Y0YyazJyMFU1Q0dDSkkvODR6cHF2L2IrVlRXcWZOc2h1aXR5eVR6REhr?=
 =?utf-8?B?TUdBR3llWUE2RldRWk91ZDJ4cnB4Smx3UzN5TkZIN1Zob3hvNURWbWJqVHFo?=
 =?utf-8?B?enE3T0kzN2dyU253Qm1JUnEzcGJsOFFKbzdpTmhoQ3ZSVHkrM0J5SzdPRkJM?=
 =?utf-8?B?cHEvVmpkS1EyRmtQRlh5ODlTZHBOZ1hBKzRoOUdacURVQnl6UzF5Z3ZhemVY?=
 =?utf-8?B?YlBmZ2tpb1hja1hveWRQZXY2UGd4TitZdXMvSlAyeDh4REJIMlNKb0VGSWwr?=
 =?utf-8?B?S2RUSFBOZzdZNGMydWU4TG8zUVIvZlVQSzdUdUVjTGtqTVpsbnNMbk42aTIx?=
 =?utf-8?B?Uk03QXQ4Qk54aTN2Ly9LakdaT2JsSHFQeDRSTDJ4MFlUaWFYeHh6cnRaQUFi?=
 =?utf-8?B?RWo1aXNxcHhWd3VYVm42TjZ6Uk02UEc2SDlOZ2JzYW5oblRSak8ySFl5VXJu?=
 =?utf-8?B?MnIxUDdXY0M2K2hhOWthWUlFaVJhaThaVktFUVgyMHdTZlJVTGEwQ3VKV0Fu?=
 =?utf-8?B?THNmdHlLbUxFT1JwYVlYemIvTFM1RURVTVhOeTVjUmRBMjA5WUdTZnlKTkFV?=
 =?utf-8?B?WGVBMERwRHNjYkh3dGF6V1JiaUJEdFViVjZEQjlyWlEvbDl5NExUS3lCSUVK?=
 =?utf-8?B?NHNtQmtLeHplQ2lxVjRMMEhPVW5pclNlOVh2b2U1eE9CVkpxOGIwUWtGWkM2?=
 =?utf-8?B?ek00ZDBZNXlZTzMrczNUTC9kVFJyK0UzMjYrYTJ0aFY2RVkwTVh2eEgrRTNV?=
 =?utf-8?B?NFUvR25yZ3gwUHdESTdoNDUvNUUxSUgvZko3VzFNY0VVMzdFVnFrbWRDbkxq?=
 =?utf-8?B?Q3I0cG1pN1BPQ2VFOXMraVNobWQzRUpmUXNuaHdRWUUrdlp3RThCcnJVTFlV?=
 =?utf-8?B?emxxMVk3Q0FhU213elZjQm5ES3pEaXdqTDcwN1djRjBaVmNIbEl4SjFQOE9H?=
 =?utf-8?B?TmtrSGxTZGUrbkU0RTFFZHBoRU5rMzNwYnRZQWp5eWtHOTdTQmQxckFWdm5z?=
 =?utf-8?Q?iZJryBtKBCrYvhCabk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-26b36.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 63920d70-462c-4ac5-e252-08ddde9840ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 20:46:05.9548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P282MB5015

T2ggY29vbCwgSSdsbCB0YWtlIGEgbG9vayBhdCB0aGF0IQoKKFRoYW5rcyBmb3IgdGhlIHF1aWNr
IHJlcGx5LCBuYXR1cmFsIEkgbmV2ZXIgdGhvdWdoIHRvIHNlYXJjaCAicmV3aW5kIikuCgrigJQg
SXNhYWMgT3NjYXIgR2FyaWFub+KAiwoKCgrigJQgSXNhYWMgT3NjYXIgR2FyaWFub+KAiwoKCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpGcm9tOsKgT3N3YWxkIEJ1
ZGRlbmhhZ2VuIDxvc3dhbGQuYnVkZGVuaGFnZW5AZ214LmRlPgpTZW50OsKgVHVlc2RheSwgMTkg
QXVndXN0IDIwMjUgNjowNiBBTQpUbzrCoElzYWFjIE9zY2FyIEdhcmlhbm8gPGlzYWFjb3NjYXJA
bGl2ZS5jb20uYXU+CkNjOsKgZ2l0QHZnZXIua2VybmVsLm9yZyA8Z2l0QHZnZXIua2VybmVsLm9y
Zz4KU3ViamVjdDrCoFJlOiBbRmVhdHVyZSByZXF1ZXN0XSBhbGxvdyBnaXQgcmViYXNlIHdoaWxl
IGFscmVhZHkgcmViYXNpbmcKwqAKT24gTW9uLCBBdWcgMTgsIDIwMjUgYXQgMDc6Mjk6NDVQTSAr
MDAwMCwgSXNhYWMgT3NjYXIgR2FyaWFubyB3cm90ZToKPkkgc3VnZ2VzdCByZW1vdmluZyB0aGlz
IGxpbWl0YXRpb24sIGJhc2ljYWxseSB0aGUgaWRlYSBpcyB0aGF0IGlmIHlvdSBkbyAiZ2l0IHJl
YmFzZSIgd2hpbGUgeW91IGFyZSBhbHJlYWR5IHJlYmFzaW5nLCBpdCBwZXJmb3JtcyB0aGUgZm9s
bG93aW5nOgo+KiBpdCBjb21wdXRlcyBhIG5ldyB0b2RvIGxpc3QgYXMgbm9ybWFsLCBhbmQgdGhl
biBwcmVwZW5kcyBpdCB0byB0aGUgY3VycmVudCB0b2RvIGxpc3QKPiogaXQgZG9lcyBhICdnaXQg
cmVzZXQgLS1oYXJkIDxzdGFydCBwb2ludD4nIGxpa2Ugbm9ybWFsCj4KPklmIGFueW9uZSBrbm93
cyBvZiBhbnkgdG9vbHMgdGhhdCBsZXQgeW91IGRvIHRoaXMsIGl0IHdvdWxkIGJlIGdyZWF0Lgo+
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC8zOTBlNmEyNS03MmRiLThhOWUtOTdhZi03Yjlk
ODAzY2ZiMmRAZ21haWwuY29tL1QvI3UKb24gdG9wIG9mCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2dpdC9hNmUzMWViOS04MWU3LTRkN2YtMjhjYy03M2I1ZTQ2NTI1YTRAZ21haWwuY29tL1QvI3I4
OTBjZTllZDY4OTQyMmRiOWZjNDBkMmJjMmNiYTM2ZjdiMTgzZWMzCgooaSdtIGtlZXBpbmcgcmVi
YXNpbmcgdGhpcyBzZXJpZXMsIGJ1dCBpdCdzIHN0aWxsIG5vdCByZWFkeS4gaWYgeW91IHdhbnQK
dG8gd29yayBvbiBpdCwgaSBjYW4gcG9zdCB0aGUgY3VycmVudCBwYXRjaGVzLikK
