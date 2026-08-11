Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011030.outbound.protection.outlook.com [52.103.39.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2EB233933
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414779; cv=fail; b=Xx9z60cnuapP5dWJBUB9Ab2TomoQQ/QnTZKt8YxU2Hohpv502SmOPDdEa3mNZlNxj3LcXO2G2tK3JI+TqLAx7TxvUcHOMsp0V6m77MllsbMMB7os1js4Yvi94e0QdRyz0vKYyQhUeFqjoNSlWndl4qsr5+RzcVbgoCRjyyKT1AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414779; c=relaxed/simple;
	bh=i0Gc9/IR0B2iW+Mq6UDacKSBx5SfDHE+3ze0MuaBYkY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HvIpxTNdI4TFbJ4LSY9jtkFkYMEiFdEMQ5fEiVbWIw+JpCXaw88YWUJMwheLqncWrU6NAkxpPXFXy9dqWtulMNnyCZ7R+C97h7Cluk6YNjweZ/JxseAo76hZmQs+ilwp90Srt8+niluPPd9WsPqBOPXIMt771dnNPrg6Tmsmei4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=XsVKvbNK; arc=fail smtp.client-ip=52.103.39.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="XsVKvbNK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql0LKkjT/tuIW+eox5TFVVhoK4UXVNhhOGzOt0jTTWWqDskxA+GKN9pv9C9nOMPq7y+/CTodbF7loz/lylBIz5RDgkZhMMX/PNwEI8qeaebV/TF6rxeBpXIZ6k4huJUfVSiLBIvGFaatukkkJKnVvXlJ3YCK/Gus5B+Nh7ESaX7YHC1SrJFH1FFj8aKZfq+I8NicX7peTFMaQlpqjh+YZyvTB0hpB9+14gNVBEKr/HXxQK0azbvpUHdccSnxe39AOgAShsNKKFc5ALOqUQoCvbkVqqSUeWnCodUGkm7cLw9sCUaUeTX2TRc406Q8CzL4LbIg2G5kOL7pArQWQDuc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0Gc9/IR0B2iW+Mq6UDacKSBx5SfDHE+3ze0MuaBYkY=;
 b=kSVdX0sYJy8941dlv4tuFMhQKvVOPpM+Al5wZn/+Jrh+zuKSu80HBGxWhFKOaSGkntBApmYE4xJZyNuoClA3Ne8GfKLCoytVusR1Yy8MbzrgmerVRyvwya8usPKhaawDy8K0uXd2KCYTf6LqR+tCtnuTPV7wP0GwbNG7/SEn0kL3z2SPIykDKZYZqyjsANUn0cfbZDet4vASpdKFoVvnBgl/v7S9DBgDvQDu+pDlB/5MfKAjUphTQqQe2LH5oMLQCejikF6An9yx60cYzTNAJIPQpIqTm1Ud1GGG84VSgoypNNlOexd2C0wj1eOjqZMlqAG5Cbx8bbR7vRi/P54yRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0Gc9/IR0B2iW+Mq6UDacKSBx5SfDHE+3ze0MuaBYkY=;
 b=XsVKvbNKrInYIitUu2fGlLVkWbmD59UA52FVjMEapBR8624Ju5B4aDb9RnWGCmnrRxgWKy9CGjl3NkeDqqasOwDibhl9XWbfOh62tnstht41ijoAwCNRaGtaAZj0xq+PDE8gSm17MueYcOmhnn7hK5exdCiC3+81sbkg3IWBfMV5uS6EUPUHrucEdL6Cg0aUptbGh9/jj3OD6ggNUCHJa+0eBaXsytTJMWL01Ed2HstkS4Ow+K3J6SajehWE2+NBvLwy8dT/KPWOEmtPsmxzMUqUbuqm3rmTCLzvIH5U1FZ482VQKr/D2IzSaW/DaDE4DFqYyYSVZ3eics2/mx0dpw==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by PA6PR02MB10712.eurprd02.prod.outlook.com (2603:10a6:102:3d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 02:19:34 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 02:19:34 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: Git <git@vger.kernel.org>
Subject: Re: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Topic: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Index: AQHdKSpeW10CNT+9OEuLP9VqvpTkMLaYG2wMgAAB2zA=
Date: Tue, 11 Aug 2026 02:19:34 +0000
Message-ID:
 <AM0PR02MB445013B3CDAAAD361FD93A86B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB445096594555DAD1D9EE1505B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To:
 <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|PA6PR02MB10712:EE_
x-ms-office365-filtering-correlation-id: 9d5aece9-29dd-4910-7361-08def74efc65
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|17081999003|13031999006|31061999003|8060799015|8062599012|19110799012|10092599007|15030799006|24021099003|15080799012|51005399006|37011999003|55001999006|25010399006|40105399003|2607281247196008|31101999003|102099032|26104999009|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGFHNjZKN1JTWllDNzFMWm5DRXFITmZaVHNUZG5Fdm16d0V4YkRLMjd4bVZT?=
 =?utf-8?B?N3U1eTFEeWkyUHBrSXhDYkx4ekpaeEVWb1ZaV2I3d1lURzE0dU5Dby84dkcz?=
 =?utf-8?B?T2IrSUdldXJXQlkvRDZ4enRHRTRTVm1GcDZvSTlGYk1KWURkUXdkVDlxUXFh?=
 =?utf-8?B?bnF3S3RDNFh5SHh5Si8vUWJ6SXl4TWlLRjI2NW0yVG0vZWRCL1owYWdpR01z?=
 =?utf-8?B?OGgrYlFwK3NGTHZXU2dmV0w2N1V1WE5Qb3ZnVm91aVZCNTJuSDQ2NW43dUpG?=
 =?utf-8?B?bFNvd3RRWGdqTUNtQ2FLb3ZlUXF1cFJ5KzB3Z2ttemxlc3lFRDd1aTFiMXVh?=
 =?utf-8?B?aEczcDFTRWFZMXRaTlBRZ3h4U3Npb1JtWGpyeTBsc3FUWWxhSWtNR1lDeGR0?=
 =?utf-8?B?TnRMRVdtMUZoMWl2YjBjRkdCUUFPTkdxTTdJNzhLQ3IrVFA4RWhyajZiNHM2?=
 =?utf-8?B?aFYraDc1amxqeUlrRkViMFBIdk5nTEswUk4rNi9RbVdhR1BTeUtRTnN5WVcx?=
 =?utf-8?B?K0lUcXduZjFlZkprOWlMa1BuQmZjNnZBQVU0N2VaNTJWYzNWc0gxdGo3b2xi?=
 =?utf-8?B?bjZkQ3o4UThXUmM5ejI3czBrQjkvUi9kMzhuNjNOSXJKV1crallBbkNVaUpF?=
 =?utf-8?B?cUFQaW5vTkk4MWZVTnVtZkdpM2dJMTlUNTBWZHltZGd6VXJmTlcyeXJDKzF1?=
 =?utf-8?B?cFE3NzZwTFNmT1psQmJzUzZLRUdnRmxiZGdGaXd2MUNvYTNKdklRaUpTY2l5?=
 =?utf-8?B?LytTck5DcWRVVWNRMjBkUmpyWm84NWR5aEkwY2JCNHo5djVWQ2pvZkcvZkxO?=
 =?utf-8?B?U3JjWStKcEVLV28xeVpIYllFckJkbVF5MHQ5NnNmSi9BMXFwSGpyNjFjcVFE?=
 =?utf-8?B?QUtxOGw2eXZRV0V0ZE5qVWttVkVlb1VCQWFtSGx3ZFhEMlRBWVB3VysybFRm?=
 =?utf-8?B?dmlCK2I2WVk1QUdqOFp0VHNSYllIdFNaSmtXdEJmTHZVbng0QlBaQ1pUSnZ6?=
 =?utf-8?B?aFVjU3lIOU00bWVuc2ZCeW1jbHVweWxVZmFFZjRWZjB4bkdHS215NTZmQzNF?=
 =?utf-8?B?emkraG82c1JSVmJINVkyZ3NZNlJvcUltcC9HRldPbjhxaUVKUzZTcXVSaDZZ?=
 =?utf-8?B?dTZ3UDVIT1hCZTQyV05iZUxzQjE5MklKdzBGcDZSSnltdHhEN3hGRWR3QklE?=
 =?utf-8?B?enZoOU16L0xrMENqbUlyaFdOdFBXRFM4TkU5VmFicDQyczJBaVlWUGhGNHVI?=
 =?utf-8?B?aXB4MExTeGorWXNnZmUzTkR5UHdkYVh1bFNLNlJOYjQrT1EwTXVUWlRPMkF4?=
 =?utf-8?B?TTVkd2VKTjhKbGNvZ2NRSEZ1Z2tCV1RXdkNmRkpMNjllaklPUXJZcjZhbXhj?=
 =?utf-8?B?dndDQmc5UlpRWVc1MmpCYkZyRnk5enRRSDNmRDRDVzBIbWJMVVFDcVp6L0Rw?=
 =?utf-8?B?SmNqTTZEWnIxdVFZUGs0eGFNSEoyckdhZkw3R0lqTG9ZaTMzaUNLZitYT2tX?=
 =?utf-8?B?OHJvRWVhbktuQUpoaURVdTRrUjZjeTQzLzJCMVg3ZmY2V0x0MU5sSFEzd0FU?=
 =?utf-8?Q?aZYn/+OJYMksjcw8kW7hG+eP1T3P2RRnRmpcWWFOE522xQ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEFnVGxrdlEzWGdhRWZXTFVyZFZVRjN6M2dxcWFXQnNkRW5vMG1YVGZmSkVT?=
 =?utf-8?B?b3FVcEpFZzRZWW1WcVJpUjZJeG8yaFJlMStsZU14eThPVFBOZnBJR1RFU2Y0?=
 =?utf-8?B?OHp5NCt1YWhLMjhTOWx6L3lqSjdDN0VlWkZTbWszbFlzVXlTMUtUNUxuc2I2?=
 =?utf-8?B?TmhPaDB2bFB5VzMxZ3hRSFdQMkZZOEpnejNKYVJHZXlpM1Y5RzlyeDhQenhQ?=
 =?utf-8?B?akVtaUUvSkpKeDFaK0N6VG1yQnYySjIvSDhCMzlWM1RITHIxUUt3RWROVytK?=
 =?utf-8?B?ZGIzTmRjSERIcHdnR1BRMUx6WjBYeFRlVEh4Q0RBWG5Lbm5MZzdiczVIZjh3?=
 =?utf-8?B?ekJwb0o0WUJkNnB6aEMrVjZpSEdlT3lubVNtNXRxUzFGaE1Bdk9YUEk0K3B0?=
 =?utf-8?B?ME84K052MStxUmp3UWM0aE9jK3ljVWJjc2tqU0JUN2RvTURQY2NqMGU0TlF2?=
 =?utf-8?B?SkdUUVBPVUIwVFR6UllXQmRWbEFKRGZUbGk4Q285L25Zd1ZoeEJJbWxCblBJ?=
 =?utf-8?B?L1FHVFlhRlRKVFVzSzlSS3ppNUt1bGpCTXZRakdOL2ViMHNyOHFrUVhwRnkx?=
 =?utf-8?B?KzFyTUhuVWllcTVoWDhQeUVOaEx2ZXFVMkRVRmZ5cGFrM0IwVXgwOC95OElr?=
 =?utf-8?B?VzBjazRiYTdNT0lDbnFXZFN3bWRWQ1E1c1NETlY4c0ZlbEZyekgyWlV6RmRa?=
 =?utf-8?B?VlVkV1FRUVhmSWt6aEJiMzlmYUhJYjdOUDJxNlVjY1ozQVBvV0xzZjBkOU14?=
 =?utf-8?B?RTlBL1pXS0RtcjR5V3hPNk9pM2gxODRkMFNTY1lMYzh3ZDYzUEpINTR0TGVO?=
 =?utf-8?B?U0RGdEdTTVRCOElDTURLUkJwdUNQZDZIQ2tkS3dLK1RFTzErY1RlMVZZbERM?=
 =?utf-8?B?QzRkM3BvMEpENG11VWttRHlSMWFjQ2EvZEFjVXJiSEtaeC9ad2JuYUZJK0pa?=
 =?utf-8?B?dFZZNStleXB4RjdXR3dGY2hObm9sR0JNSXdSNlpxWW9sSmYrZERDdEZxUWZt?=
 =?utf-8?B?aFlEWVlDTnZweFRkdEdSN2d1dElYZzcxWGNGZ1hQTkJ2cW9QYlZQN3hlUDRQ?=
 =?utf-8?B?bktLeVN0ajRzOHl6TitUQm9YN0NhdW44bzhmRWYzM2NzR1RZcGI3V3NMZSt2?=
 =?utf-8?B?TUt6SDBJc3JoT2owMW9hTDBPcG04R3JjVjB6YXR4anpYQUxWbFl3ZmovQVhV?=
 =?utf-8?B?a0VDR2NPS3lKNFc4TmRIYmFEcXBzN24wZVc1ODhmM3lESlhZRk9tMFFlR0ZE?=
 =?utf-8?B?cG8yTHJidWg0VlA5Y1NaZENBemtsVk1kK0FVNDJLeDRMZzFqSFJ0aEFsQWZt?=
 =?utf-8?B?S1pTL1NFVllhS2dPdnhkY1RjaEZWK2JPL2VrbTBPRFdBMkprTk11TS90YW1o?=
 =?utf-8?B?SjZ6OXVQVU8zdE5PeWlONmZZMUk4bVRhTThXRDhjb1RlY0VNK2dNaFk1N3Za?=
 =?utf-8?B?eHJ4THdhUU1mdzY4OEpCck9xSURNc21lMFcvTmtqb0l6eFoxcS9STVZxdTA3?=
 =?utf-8?B?TFFkT09mZzEyaXRoTjRGOHNlcXJKc1BPMUlXTG5HTVRqYnROWjJ5YzBCbVp1?=
 =?utf-8?B?WVY5Q3k3cjhBZWhBTU5TTE1sbTVOUlFBM0hIRmI3T3FVd2pnWFU1d1l2N2Z4?=
 =?utf-8?B?MFJFaTkyU1NRY3lkeWdEV2JLWWJzY01vblRhRVE4T0JUcnFZNUlJZzhSY0x1?=
 =?utf-8?B?SFZiam1QT0RWUE11V3dmZVpXcEVTQ1Q3NUFnbk5UbFZxNzUzbERNUWk3R0Rn?=
 =?utf-8?B?Z0RQK282SlhtTzQvWVJtZ0tLWURST1J3RXBDOHM1WDdtR3kzMXBFRnpDRmRm?=
 =?utf-8?B?SlZrL3ZiV0pMeGY5d0hCbUVEcklaYjJpM0M5VTl6cGdqU0dhUGRobFBhT1VW?=
 =?utf-8?B?NEszcUg3c1p2MGNSTFRVdCtOREptVGI2Yno1aUpPcnRmT0xoSzZSb09LZ00x?=
 =?utf-8?Q?VrLM/fHCqwUFPYPKiABjL+By2zYFOve4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-9f624.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4450.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5aece9-29dd-4910-7361-08def74efc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 02:19:34.6624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10712

UGVyZmVjdGx5IGNvbmZ1c2luZywgSSB3aWxsIGp1c3QgY29udGludWUgc3BhbW1pbmcgdW50aWwg
dGhlIGZ1Y2tpbmcgQUkgZmlndXJlcyBvdXQsIEkgYW0gbm90IHdhc3Rpbmcgb25lIHNpbmdsZSBi
cmFpbiBjZWxsIGluIHRoaXMgbWVzczoKClRvOiBnaXRAdmdlci5rZXJuZWwub3JnClN1YmplY3Q6
IFdpbmRvd3M6IHRleHRjb252IHBpcGVsaW5lIGNvcnJ1cHRzIGRpZmYgb3V0cHV0IChzZWQgbm90
IGF0IGZhdWx0KQoKRGVhciBHaXQgbWFpbnRhaW5lcnMsCgpJIHdvdWxkIGxpa2UgdG8gcmVwb3J0
IGFuIGV4dHJlbWVseSBjb25mdXNpbmcgYW5kIHRpbWXigJFjb25zdW1pbmcgaXNzdWUgaW52b2x2
aW5nCkdpdOKAmXMgdGV4dGNvbnYgbWVjaGFuaXNtIG9uIFdpbmRvd3MuIFRoZSBwcm9ibGVtIGNh
dXNlcyAqc2lsZW50IGNvcnJ1cHRpb24qIG9mCmRpZmYgb3V0cHV0LCBsZWFkaW5nIHRvIGhvdXJz
IG9mIHdhc3RlZCBkZWJ1Z2dpbmcgYW5kIGZhbHNlIHN1c3BpY2lvbiBvZgpyZXBvc2l0b3J5IGRh
bWFnZS4KClRoaXMgaXMgbm90IGEgc2VkIGJ1Zywgbm90IGEgc2hlbGwgYnVnLCBhbmQgbm90IGEg
dXNlciBlcnJvci4gSXQgaXMgYSBwcm9ibGVtCmluc2lkZSBHaXTigJlzIHRleHRjb252IHBpcGVs
aW5lIG9uIFdpbmRvd3MuCgpFbnZpcm9ubWVudDoKLSBXaW5kb3dzIDEwCi0gR2l0IGZvciBXaW5k
b3dzICgyLngpCi0gc2VkLmV4ZSBmcm9tIEdpdCBmb3IgV2luZG93cyAodXNyL2Jpbi9zZWQuZXhl
KQotIHRleHRjb252IGZpbHRlciBjb25maWd1cmVkIHZpYSAuZ2l0YXR0cmlidXRlcwoKU3ltcHRv
bXM6CldoZW4gZGlmZmluZyBHbyBzb3VyY2UgZmlsZXMsIEdpdCBzaG93cyBjb3JydXB0ZWQgaWRl
bnRpZmllcnMgc3VjaCBhczoKCiAgICBjb21wYXJlQ2FjaGUgIOKGkiBjb21wYWVDYWNoZQogICAg
cmV0dXJuICAgICAgICDihpIgZXR1cm4KICAgIGZvciAgICAgICAgICAg4oaSIGZvCiAgICBjYWNo
ZVJlYWRlciAgIOKGkiBjYWNoZVJlYWRlCgpJbXBvcnRhbnQ6Ci0gVGhlIHJlcG9zaXRvcnkgY29u
dGVudCBpcyBjb3JyZWN0LgotIGBnaXQgZGlmZiAtLW5vLXRleHRjb252YCBzaG93cyBjb3JyZWN0
IG91dHB1dC4KLSBgZ2l0IHNob3cgPGNvbW1pdD46PGZpbGU+YCBzaG93cyBjb3JyZWN0IGNvbnRl
bnQuCi0gVGhlIHdvcmtpbmcgdHJlZSBpcyBjbGVhbi4KLSBSdW5uaW5nIHNlZCBtYW51YWxseSBv
biBXaW5kb3dzIGJlaGF2ZXMgY29ycmVjdGx5IGFuZCBkb2VzIE5PVCBjb3JydXB0IHRleHQuCgpJ
biBvdGhlciB3b3JkczogdGhlIGNvcnJ1cHRpb24gaGFwcGVucyAqb25seSogaW5zaWRlIEdpdOKA
mXMgdGV4dGNvbnYgZXhlY3V0aW9uCnBhdGguCgpSb290IGNhdXNlIChjb25maXJtZWQpOgpHaXTi
gJlzIHRleHRjb252IHBpcGVsaW5lIG9uIFdpbmRvd3MgaXMgYWx0ZXJpbmcgdGhlIG91dHB1dCBv
ZiB0aGUgZmlsdGVyIGluIGEgd2F5CnRoYXQgcmVtb3ZlcyBjaGFyYWN0ZXJzIGZyb20gdGhlIGRp
ZmYuIFRoZSBjb3JydXB0aW9uIGNhbm5vdCBiZSByZXByb2R1Y2VkIGJ5CnJ1bm5pbmcgc2VkLmV4
ZSBkaXJlY3RseSBmcm9tIGNtZC5leGUgb3IgUG93ZXJTaGVsbC4gSXQgb25seSBvY2N1cnMgd2hl
biBHaXQKaW52b2tlcyB0aGUgZmlsdGVyLgoKVGhpcyBtYWtlcyB0aGUgaXNzdWUgZXh0cmVtZWx5
IGRpZmZpY3VsdCB0byBkaWFnbm9zZSwgYmVjYXVzZToKLSBUaGUgZmlsdGVyIGNvbW1hbmQgYXBw
ZWFycyBoYXJtbGVzcy4KLSBUaGUgZXh0ZXJuYWwgdG9vbCBiZWhhdmVzIGNvcnJlY3RseSB3aGVu
IHRlc3RlZCBtYW51YWxseS4KLSBHaXQgZW1pdHMgbm8gd2FybmluZ3MuCi0gVGhlIGNvcnJ1cHRp
b24gaXMgc2lsZW50IGFuZCBtaXNsZWFkaW5nLgoKSW1wYWN0OgpUaGlzIHByb2JsZW0gaXMgaW5j
cmVkaWJseSBmcnVzdHJhdGluZyBmb3IgdXNlcnMuIEl0IGNyZWF0ZXMgdGhlIGlsbHVzaW9uIG9m
CnJlcG9zaXRvcnkgY29ycnVwdGlvbiwgYnJlYWtzIHRydXN0IGluIGRpZmYgb3V0cHV0LCBhbmQg
d2FzdGVzIGhvdXJzIG9mCmRlYnVnZ2luZyB0aW1lLiBJbiBteSBjYXNlLCBJIHNwZW50IGEgbG9u
ZyB0aW1lIGNoYXNpbmcgcGhhbnRvbSBidWdzIGluIEdvIGNvZGUKYmVmb3JlIGRpc2NvdmVyaW5n
IHRoYXQgR2l0IGl0c2VsZiB3YXMgYWx0ZXJpbmcgdGhlIGRpZmYgb3V0cHV0LgoKUmVxdWVzdDoK
SSB3b3VsZCBsaWtlIHRvIGFzayB0aGUgR2l0IGZvciBXaW5kb3dzIG1haW50YWluZXJzIHRvIGlu
dmVzdGlnYXRlIHRoZQp0ZXh0Y29udiBleGVjdXRpb24gcGF0aCwgc3BlY2lmaWNhbGx5IGhvdyBm
aWx0ZXIgb3V0cHV0IGlzIGNhcHR1cmVkIGFuZCBwYXNzZWQKdG8gdGhlIGRpZmYgbWFjaGluZXJ5
LiBTb21ldGhpbmcgaW4gdGhpcyBwaXBlbGluZSBpcyBtb2RpZnlpbmcgdGhlIHRleHQgaW4gYQp3
YXkgdGhhdCBkb2VzIG5vdCBvY2N1ciB3aGVuIHJ1bm5pbmcgdGhlIHNhbWUgY29tbWFuZCBvdXRz
aWRlIEdpdC4KCkV2ZW4gYSBzbWFsbCBkaWFnbm9zdGljIGltcHJvdmVtZW50IHdvdWxkIGhlbHAg
ZW5vcm1vdXNseToKLSBBIGZsYWcgbGlrZSBgLS1kZWJ1Zy10ZXh0Y29udmAgdG8gc2hvdyB0aGUg
ZXhhY3QgYnl0ZXMgR2l0IHJlY2VpdmVzIGZyb20gdGhlCiAgZmlsdGVyLgotIEEgd2FybmluZyB3
aGVuIHRleHRjb252IG91dHB1dCBkaWZmZXJzIGluIHNpemUgZnJvbSB0aGUgb3JpZ2luYWwgZmls
ZS4KLSBEb2N1bWVudGF0aW9uIGNsYXJpZnlpbmcgcGxhdGZvcm3igJFzcGVjaWZpYyBwaXRmYWxs
cyBmb3IgdGV4dGNvbnYgb24gV2luZG93cy4KClRoaXMgaXNzdWUgaXMgc3VidGxlLCBzaWxlbnQs
IGFuZCBleHRyZW1lbHkgaXJyaXRhdGluZyB0byBkZWJ1Zy4gSSBob3BlIHRoaXMKcmVwb3J0IGhl
bHBzIHByZXZlbnQgb3RoZXIgV2luZG93cyB1c2VycyBmcm9tIGxvc2luZyBob3VycyB0byB0aGUg
c2FtZSBwcm9ibGVtLgoKVGhhbmsgeW91IGZvciB5b3VyIHRpbWUuCgpTaW5jZXJlbHksClNreWJ1
Y2sgRmx5aW5nCgpGVUNLIFlPVSBBTEwgVE8gSEVMTC4=
