Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012058.outbound.protection.outlook.com [52.103.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2EE2E36EA
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687959; cv=fail; b=PgWOLsXIHjkgYOAomqNeuhkd2NtFPOEhYA5AwGkH9cgkH3+swv+gNBTAXE89+1WBXLZuSlV0KdGkrpplpYQTX9ddXiKQrXbHrBjVLu6z6qHElWFMZB+CFwr5+rN8wpq+xhIGdZjPAIB4uZejr4uNw8Fvsg/p+d1fbpQiJ7Qc9ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687959; c=relaxed/simple;
	bh=bUvmySZfP9FL1vQz/TbWH7hUjMNIdXo1rXZ/4tBc1CE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TvWCnNjYLibwDRy8IIaNORjyU0pnnu2F3ZEBsLvu+pMAnjbddwx30WXlz55xA1+UgsjnOvk6y415uWGptTqQFQiRxTk/UisXXybMNtiP1DGuVRVo1UCQAp2zjmQ5/YzlD7FKULv+iALbDI9+PVMUOpbNrr1O/pQsbuouiEgCUd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au; spf=pass smtp.mailfrom=live.com.au; dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b=ZbljvygQ; arc=fail smtp.client-ip=52.103.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b="ZbljvygQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPeD9JrUN29tSQachXk0MZDsy8ENN8SGPTxF2Cai36HlE4xWu++I2kBOm7o/c34PbT3DUYkRmxm9B6QdBB1xD1PMrhCimvo5SaZhMHiMSmapFLp5vFRUrVaXRcH7lZS7eu0qCzfqvW731N+b8EKkhEpGg71/PApxBZFupxidS0Xtw33LKbLEd/1mVhvskqx66XZ9ggbA0lOs0sV/+ZPiRP7DkZCeWxcDoyBx5i6SCMyHvoEI7BCNSMDFUXGd4FC6z7pK0DTgistpyDjo2Nu5Cm9lekBeZlYct35A+/KsgBHVqs2k/XMSMlXzS9HTZ68r/s8FkR/1EavfX03dQfWkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUvmySZfP9FL1vQz/TbWH7hUjMNIdXo1rXZ/4tBc1CE=;
 b=aejAZ4NQtlvVKy7VJj7km7ieFMazXaOX2a4J10fd1cnoOBRXuDuWy2M+SZu/gpG5oaRNgyZ/Em6VKdh43i7iuenCHT8jfEkUCi6zfRhk4Fra3dEYBT/rDahXmRNfDnkrwo6Tp1x0knzrwI0sPu//X2hbaCvDZ3xGDJhc5cVYZoWw3HAuBgRE0WiJQ4sMDi1oPRNY5+N07j0X3d+jwuer/xNvuP7HwQFEDo0Pc1e/Cb1oIu/Txib3c7Ptgvu5YEjiAJ097GT1v1N9bj0uydIHDmFsaTORmxvVDVsikR2qHPiewUHwsKortlyVUvKmI5u1pI0XsTm98NGYzT+yVGsx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUvmySZfP9FL1vQz/TbWH7hUjMNIdXo1rXZ/4tBc1CE=;
 b=ZbljvygQcifRJRsu0OSpt5w9Ko1wHMTN3zO/rVYnKuHo+n89+nLLCqHN4Jm76KyCpGvGxXGQVirjLDlDtMf0f4XmqD0ciMaJNpq309KxCC9FOTJET7voxoItTyfttjYDHH510fzd4Zr24+xPuqne9Iym0xJJx7clRVQDzlnzMPV9G8jvDY87g6jnEaoaxJNbk1SYeAjuZeVDdTJBQgezvgeWVACXClpYCR+Divp1xHMvJ1VOKWZ58jcsbnrUnFgxaGlnl5hEpF6NxP1PIEK4muPmKBPUforuVZb5b5b9fB8f6yFmxJygnR3vTWBe7UuWwFTNatqjcpIjeYI2x9V1og==
Received: from SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:156::6) by
 ME3P282MB1217.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Wed, 20 Aug 2025 11:05:54 +0000
Received: from SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
 ([fe80::942e:8672:69d1:38dc]) by SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
 ([fe80::942e:8672:69d1:38dc%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 11:05:53 +0000
From: Isaac Oscar Gariano <isaacoscar@live.com.au>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] Some subcommands ignore color.diff and color.ui in --patch mode
Thread-Topic: [BUG] Some subcommands ignore color.diff and color.ui in --patch
 mode
Thread-Index: AQHcEb5ZxYQ0R/oHaEqDs/7wbWpO3A==
Date: Wed, 20 Aug 2025 11:05:53 +0000
Message-ID:
 <SYBP282MB296329544B33E3C16DD99FD28C33A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBP282MB2963:EE_|ME3P282MB1217:EE_
x-ms-office365-filtering-correlation-id: 7838fe47-5076-4b3b-fbf6-08dddfd98800
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|19110799012|6072599003|15030799006|15080799012|31061999003|461199028|3412199025|440099028|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2dUWFB0RDdiN0R3WnNYbFpqV3JaY1lIdmVpNmFuenJVTDVNa1FwRDNZcUd4?=
 =?utf-8?B?ajhPS0ZTUmNZUE5yVzhyVkpCK3pWaWh2Z3NTcFh2aTRDU1ZsQWI5LzlTZkIv?=
 =?utf-8?B?bm44Um9DUTZqdDVmYTFpZWNGVmlWTjNlVytBUzVQNEJqQkdabWZXSUtKTW9s?=
 =?utf-8?B?alR4NlVjZUoydDRLWEFTSDZNUG5TZ3FVYTJSK3lpUHNpeFFHOWZCai9uSmRh?=
 =?utf-8?B?alg3dk16MWo5NXljZkx6VlJZc1Q0cWhwYnR1eHFZRy9CejJ6QVhSMlZlYmRr?=
 =?utf-8?B?dFpJVERrZFJzbkRzUWlYY0tlY0lWMDZYaXFMczVyQm9QZG9Wd3ZsaWlVNUVx?=
 =?utf-8?B?dTR0Yzl6Q2F4NmllemNCSEZHeFVDTUVSR0ZWUlZLaFc3WTZDWUZYc1hOcE9D?=
 =?utf-8?B?Q3diNEJWN1E1TGlSME5XNFJNTXdQUWd3TlpCeHJmeU9TMldLVFNmUW51NGJm?=
 =?utf-8?B?S2ZNR0tuTG8yNWNDZHZpWnZCZHdnaXZvWVBLM3lDVzJxRStOZTVJaUxZQkxM?=
 =?utf-8?B?L3FqMjUzTHA2Ymlwa0h1REwyTmk0UVZYMm1PS2hZZ1JwWDV6KzNHNUViSXdS?=
 =?utf-8?B?R2RKazJHZVl3QTk2NUMwc1ZTN1Bodm5ESEVDa1kyanIycHFFNnpyeEtNdGE3?=
 =?utf-8?B?dGpKVnRBZmVsTWtwRSs1ZVdYTENNRTRiMnZFRSt5NWlhejdPcWlLR3VSWmVl?=
 =?utf-8?B?OXFVSndRWjN1VWpnRnd1VzcwYXorUWVHL2dDWFFkeXdEcEdDRm12VWFYVHRW?=
 =?utf-8?B?MnhXNDNOUGpIQm43amc3SnY3MkpVa0luSjBUSC9qNjdITXhwdWROcGhVczRm?=
 =?utf-8?B?MzB3VWNSaE9Ka1FEVHpmamtOb2xFYk1qMUlQUm9UL1c3WFkzTzRTZmxLbkQz?=
 =?utf-8?B?QnYrWnlzamhaMXdJZlRoL1dTU3dmd1JSS3BrMHcvSzJpZFo4TmgxL2NQcG00?=
 =?utf-8?B?MHdYRTAzMXFJODU4ajk5amV5eWpGcGkzM0dUaEp4RmhNMlluRUhUMnlDTHAz?=
 =?utf-8?B?WHNYYXpUM0x3YVZWSjNyd0graVRBVUd3RmJQbjNkalNNT0lIeDZHSUs0VlZh?=
 =?utf-8?B?SlV3Y2pHVEhFdTFzWUJSdWYvYzNTT1EyVHpOOGVJTTFGTkJVdnZnckVTVmgz?=
 =?utf-8?B?NE1Nc2Q0V25yUlo3RHJuUERkaENoZXEzZlJSVTBVNDUydmNRd3E2Y2l4TlpB?=
 =?utf-8?B?NWpUdEVwUHJ5b1pweDhtYVJUd2Jjd0pybjMxNi90N1RTMEtjT3RXNWoxRFRY?=
 =?utf-8?B?ODdtMU1xQ25Fd0FuWGZaU1VGaXN3S1hqREw3cVJCYllGRWtLNzVQaGlabjZs?=
 =?utf-8?B?VWJReUtIT1VucWttL0U1WDR5ZTBlOGhLMjIrL0lRV1BWVk45WmZQWGpXc2ZJ?=
 =?utf-8?B?L05uMy9QQ1dzMC9BWlRpSEIrdDNjRFU4OFIrNUg4T1A3K1NYeTRsOHJQR3Vy?=
 =?utf-8?B?QXhadXU3bEUrTzYvNnkyRGJoTlZoM3lJUkJyNHA5b2plK0x0ajVYZVZaVm1a?=
 =?utf-8?B?RmZicXRQMllubTZ2N2pQcGdLMVk0dWozcHJjcXA4UnI5dUwreVZZUzlxSHVR?=
 =?utf-8?B?NDh1OC9wcG9JRm04RlcrcWI2N3o5NWR1eCtDZUowMGFnVHpVc0w0cUJ5MFZO?=
 =?utf-8?Q?dtyMwn9bbBgFZb7TI6fk2U/lXN71VOWq1NboDikAB2X0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0FZTXU1aFkyZ1VjbkVNdS9tbWJZRUpVREVjazFEc3REbnVYd2E3MkJiRk4w?=
 =?utf-8?B?MCszV2g0RFdselZ0YW9nM1ZHYURtL2xmemZJYXZPa3dERVNMVHhmWkhpQXM2?=
 =?utf-8?B?cXlKM2tBM0RrWVhwakFhVTlZa0xKcjM3UldpTHdkY3VSZ21pQ0loaEx2eEs4?=
 =?utf-8?B?RG9sOGlyS0h1eVJsSkt3cnZNS084OUtRMFhoWkxSdUt1czdqcUg5T0pWVlFH?=
 =?utf-8?B?R2V3c2NWT2dsaEQvS04zRXRPR3VsYkdtbmk5V2laRmNOeW5kdXdIaG1FU29B?=
 =?utf-8?B?Y3ZxdVp4MlVOVjA2V1VXR24zUjBjQVdiaW94MVB4NWlWM3NQb0RLdEFWamNt?=
 =?utf-8?B?L1NwWEZ0WFI2U0Q0RXF0cWtWREZaM2h4OWhJdUZQRUYwK25vTnpXSVR4QUFK?=
 =?utf-8?B?NXF5MVNZQlZHZzJxYnRnUjIwTU5sZUljWW92WFZEZnpsd2tWeis0eWttUjcw?=
 =?utf-8?B?RXFMY1oxVHVlWUFvQTRBM2ZWTHd3QnRadm5sSi82S0d3OVJqVUJYNGZILzZw?=
 =?utf-8?B?ZzQzYzNHc2psTXBTb1NicXFXR2UwWTNPRmhtOStFTDRUVVZZeURNQ241bVV0?=
 =?utf-8?B?ZXBjdEhFc294alJuMldtLzkyejlwQ0FFQ2Q3bmZvdmZ4cnJydDNZRW0wcmlP?=
 =?utf-8?B?VmR0STBVdUlGM1d2Tm1JWGFUbGFoQjVGUm5GZzV6dGVrZm5INnlJeTVlU3Nx?=
 =?utf-8?B?ejFXWGUvWmVJSGpSSTA3SXhZM3MwaXVwL2h0b0RJYkpUZUlBWjBtSE9JclBI?=
 =?utf-8?B?bmZuenJobURKQUxXcTUyQW9iZ0U0RFFRNnZBQjFYbDhHMEJjcUxYK1lmckJU?=
 =?utf-8?B?WjBIeDhLYUUzVUM4eW1PL1UvT3kzZ3VNRmVEMm1QWFhxN0Vrd3Vsb2JLaXdK?=
 =?utf-8?B?NlF5dDNrV0FoZHpFR2FOSlRPR0M3OUhGclh1aFMzR3VZZktLL3R0UFhXZ1c3?=
 =?utf-8?B?MFhTQkxjQitvQWJ5d2lWSHpJL1oxWDFlcTdJRDZTVG9nb000VEJ2YmE1VUhv?=
 =?utf-8?B?K1BIa01HQldqL01wNTdneExWSkpLb1FOS2Zxd2J5V2diL245dyszOUlwOWtD?=
 =?utf-8?B?OHVsU3BvUTQ1ZmQycHNROXE1ZmFDbnNOTXpHT2tFM2p3Wis3eWVxSklkbFJ1?=
 =?utf-8?B?VXVLbzg1OFRLckIybi8wZEJaWlJ6RWVjZGh1bUNneEJQQ1BudXFyUFpxckJR?=
 =?utf-8?B?SmRyV3dOWHptN3JuOVE0ZDJWN1U5dy9DV3pRL1RrRVZIWEF1MXBLZS9DSVZK?=
 =?utf-8?B?S1loTjBUVFBPbk1TWTFLcUEwK3hacVZXYkMwR01zMVJaRG5PWmMvcGpzMkUz?=
 =?utf-8?B?T1R2WVkvYVNqY3pRcnhuNDJhMDVPMXpHRXRnZkI5elc1TTVTdFBPL1BpaERr?=
 =?utf-8?B?QnFoOFJWbjdzbFZZQ2x1T2oyeStRL0JCUGxCQjZqb1NSNXl5YnpCS2wwU2R1?=
 =?utf-8?B?TXBXZXZiRXgwUExwL1Q4UlVPVStSNnVsY1lySk9yQitNbDdPY1NTdmdMOXcr?=
 =?utf-8?B?OTRYRi92YTV0ZG5wSVFnK1hpckl2YmV3UHpuWlluOXVseGhGOVlQZGxwYjBL?=
 =?utf-8?B?RU5Cdm5OMW5la0dxUlJ0MThDak9EYzVhSWlQS21wUWR0K2h6QXVhbSt3ZWtN?=
 =?utf-8?B?V3dTYVFKTzludHpjZTZuc05nRGFWZVAzK3ZCWXJDMHE4VitFaXJYelFIbENV?=
 =?utf-8?B?NG1ROHpiS3pUcGVwdzc2cm9KU041aDArSWt3Wk1QV2xxU0dKdVJ0TDF3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7838fe47-5076-4b3b-fbf6-08dddfd98800
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 11:05:53.8836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1217

QmFzc2ljYWxseSB0aGUgY29sb3VyaW5nIGJlaGF2aW91ciBvZiB0aGUgaW50ZXJhY3RpdmUgLS1w
YXRjaCBvcHRpb24gdG8gdGhlIHZhcmlvdXMgY29tbWFuZHMgZGlmZmVyLgpJJ2xsIGNhbGwgImNv
bW1pdCwgYWRkLCBhbmTCoHN0YXNoIHRoZSAiZ29vZCBjb21tYW5kcyIgKGFzIHRoZXkgYmVoYXZl
IGFzIEkgZXhwZWN0KSwgYW5kIHN0YXNoIHB1c2gsIHN0YXNoIHNhdmUsIGNoZWNrb3V0LCByZXNl
dCwgYW5kIHJlc3RvcmUgdGhlICJiYWQgY29tbWFuZHMiICh3aGljaCBhcmUgYnVnZ2VkKS4KCkkg
YXNzdW1lIHlvdSBoYXZlIGdpdCB2Mi41MC4xLCBhIGRpcnR5IHdvcmtpbmcgdHJlZSwgYW5kIG5v
IGNvbG91ciByZWxhdGVkIHNldHRpbmdzIGluIGFueSBvZiB0aGUgY29uZmlnIGZpbGVzLCBhbmQg
d2hlcmUgJENNRCBpcyB0aGUgbmFtZSBvZiBhbnkgImJhZCBjb21tYW5kIi4KClRoZSBmb2xsb3dp
bmcgYWxsIHByaW50IGluIGNvbG91ciAoSSBleHBlY3Qgbm8gY29sb3VyKToKwqAgwqAgZ2l0IC1j
IGNvbG9yLmRpZmY9bmV2ZXIgwqAgwqAgwqAgwqAkQ01EIC0tcGF0Y2ggLgrCoCDCoCBnaXQgLWMg
Y29sb3IudWk9bmV2ZXIgwqAgwqAgwqAgwqAgwqAkQ01EIC0tcGF0Y2ggLgoKVGhlIGZvbG93aW5n
IGRvIG5vdCBwcmludCBhbnl0aGluZyBpbiBjb2xvdXIgKEkgZXhwZWN0IGl0IHRvIHdvcmsgdGhl
IHNhbWUgYXMgd2l0aG91dCB0aGUgY2F0KToKwqAgwqAgZ2l0IC1jIGNvbG9yLmRpZmY9YWx3YXlz
IMKgIMKgIMKgIMKgJENNRCAtLXBhdGNoIC4gfCBjYXQKwqAgwqAgZ2l0IC1jIGNvbG9yLnVpPWFs
d2F5cyDCoCDCoCDCoCDCoCDCoCRDTUQgLS1wYXRjaCAuIHwgY2F0CgpOb3cgdGhlIGRvY3VtZW5h
dGlvbiBmb3IgY29sb3IuaW50ZXJhY3RpdmUgc2F5czoKwqAgwqAgV2hlbiBzZXQgdG8gYWx3YXlz
LCBhbHdheXMgdXNlIGNvbG9ycyBmb3IgaW50ZXJhY3RpdmUgcHJvbXB0cyBhbmQgZGlzcGxheXMg
KHN1Y2ggYXMgdGhvc2UgdXNlZCBieSAiZ2l0LWFkZCAtLWludGVyYWN0aXZlIiBhbmQKwqAgwqAg
ImdpdC1jbGVhbiAtLWludGVyYWN0aXZlIikuIFdoZW4gZmFsc2UgKG9yIG5ldmVyKSwgbmV2ZXIu
IFdoZW4gc2V0IHRvIHRydWUgb3IgYXV0bywgdXNlIGNvbG9ycyBvbmx5IHdoZW4gdGhlIG91dHB1
dCBpcyB0byB0aGUKwqAgwqAgdGVybWluYWwuIElmIHVuc2V0LCB0aGVuIHRoZSB2YWx1ZSBvZiBj
b2xvci51aSBpcyB1c2VkIChhdXRvIGJ5IGRlZmF1bHQpLgoKTm93IHRoZSBiYWQgY29tbWFuZHMg
YXJlIHJlc3BlY3RpbmcgdGhlIHNldHRpbmcgb2YgY29sb3IuaW50ZXJhY3RpdmUgY29ycm9lY3Rs
eSAoYW5kIHRoZSBzYW1lIGFzIHRoZSBnb29kIGNvbW1hbmRzKS4KRm9yIGV4YW1wbGUsIHRoaXMg
YWx3YXlzIHByaW50cyBhIGNvbG91cmVkIHByb21wdCAoYnV0IG5vdCBhIGNvbG91cmVkIGRpZmYp
CsKgIMKgIGdpdCAtYyBjb2xvci5pbnRlcmFjdGl2ZT1hbHdheXMgwqAgwqAgwqAgwqAgwqAkQ01E
IC0tcGF0Y2ggLiB8IGNhdAoKQnV0IGFzIG1lbnRpb25lZCBhYm92ZSwgImNvbG9yLnVpPWFsd2F5
cyIgd2lsbCBOT1QgcHJpbnQgdGhlIHByb21wdCBpbiBjb2xvci4KCkFzIGZvciB3aHkgSSBjYXJl
LCBJIHdhcyB0cnlpbmcgdG8gcGlwZSBnaXQgcmVzdG9yZSB0aHJvdWdoIGRpZmYtaGlnaGxpZ2h0
ICh0aGlzIGZ1bmN0aW9uYWxpdHkgc2hvdWxkIHJlYWxseSBiZSBpbmJ1aWx0IGludG8gZ2l0IGRp
ZmYpCgpBIHJlbGF0ZWQgaXNzdWUsIHRoYXQgaXMgcHJvYmFibHkgbm90IGEgJ2J1Zyc6IGFsbCB0
aGUgLS1wYXRjaCBvcHRpb25zIGlnbm9yZSB0aGUgZGlmZiBjb25maWcgb3B0aW9ucyAoZS5nLiBk
aWZmLndvcmRSZWdleCkuCgrigJQgSXNhYWMgT3NjYXIgR2FyaWFub+KAiwo=
