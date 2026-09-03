Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A74BA9E7
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446264; cv=fail; b=XhbVe5Y3cTMqkQCbMPWAhIcYSo8jfo/+D0emJLmms98o8jkKV/cN0qA9G83YKm6btokuq47zUi7u7H70X3A+NBp9KotD1gseEk0DLhkU8ZavrJpiRZnZ74+NFItJlk97aSpwIkhJfj4SFRBh40iMHnGAEu3itpQiUHjt/MOM2oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446264; c=relaxed/simple;
	bh=MpxlOeVIQL/1+nzL6B1Fvmyh/p2AiGllq7oHYFKQGEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIzrl6mIvG8w4um9kZdek3mdxFJJ7OwbPK2EAwC3WyyFfqoih2k/7XrfyhdR5DErlLlTe4vIg4wzsAG4waD8SlI2ylfkkbZ+pS0wnQJxHGBahMLvt8FHw6QgNg6WrdR7HA5gTHAd1fGwKo+xytWTI6ZdrTM7j+IEOIjeOAKccWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uQsvXSr9; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uQsvXSr9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxcZ5GIz1PK9Fkqi7u3+3yQM3MUVr1lD+77Y5SuRczHi57C0XeFscQ11KWoUlMnmuExZprd13kyV3oz5Pad3DI0HuYznt6iF3r9aiehXYryjMr3pgTNlXGr68M7i3ttVjABszilkONeFFimA2oGJLSZNn3EB2a1G3FiARTLiXe0kmYbgOjNwBvDSbSh1bqNEXLFdppoTUpbENwn0fCTgGCKhvr44jBXieyw0r1L2eEiyAGVaFuS8gVRarKpGrO/jgUSz3ocSoBmriQMxymYM+V+9xLVfkSbAcTiPmlDIwAfB2ZHkc/l6nGYbUGICnLu7GK1jK3x+XeFlnMbSXhtqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpxlOeVIQL/1+nzL6B1Fvmyh/p2AiGllq7oHYFKQGEI=;
 b=FBn1K2bhpvz8V+dINfZg2qOD3O+kjzfOTdYQ797KbNk9tIVGcOZX4kf+o9g0ybuCoG0WoY8sHUCKfH+4Sdmd1eRl2enun0shrTQ3WKKchkP+r+M3kRDDahp6yLwJyzINSHpuP3aG0szYj3nY9wtNTm+m/pepa0Lq7sTiA/gM501+Na/f+HQT9uMwTQruTt33fefibKT3rTQI4D1qr0r4lNsTFthRwTIiFKKW4lojHRbetIaZRJpORdDDgnsh5V5b5+x0b+AEWxYbnBehggVVq+LZublV1UhLtVa07Y+6QS+TXnaIqSwEtdxNkNyORdFFdWuxHk+geEOvOBLkbwU+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpxlOeVIQL/1+nzL6B1Fvmyh/p2AiGllq7oHYFKQGEI=;
 b=uQsvXSr9W/yiFyGz/ctz0fPCUaq6UD1sKjAbLqubt8F2mVPcQssBOVkhrfdyMjITrv9zpYb2NvDe7RRHX0WTslIa3hKejPvHxt+ecqZWuR5j6Rms88Mx71kZd9RmIvG4QsMV8oxY7Lm7585HKCqC0kV29Tn6kgYwjijHiMi6Wa0d0UzkoDvYqgJ5+P+1XsXZn26xN1r1ACI+xxPxMoYYEfy8wXf1meRqZVy1Qkx7txkut9KSHfPFH6YuP6ltGmeM6+1B8LcuEGxtUyFsjLOWET1q8er0Uw9h4iDipRyKk3wzlLYQggbFAgGzJReQC8oJNnuEKjdiBjXATObFdSQhUg==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN3PR01MB6205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:80::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 14:37:33 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 14:37:33 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Wolfgang Faust <contrib-git@wolfgangfaust.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: [PATCH] imap-send: add --draft to set IMAP \Draft flag
Thread-Topic: [PATCH] imap-send: add --draft to set IMAP \Draft flag
Thread-Index: AQHdOnANfPSsa15P30WxlynTjDaI47a8WTwAgACGEOGAAA9Vmw==
Date: Thu, 3 Sep 2026 14:37:33 +0000
Message-ID:
 <MAUPR01MB11546486A8DD9C23224D52607B8B62@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <761c3f1b-e280-48b1-a2ad-770b68be3434@slotpi01m90>
	<MAUPR01MB1154649CE9D154B98459B09CEB8B62@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqfqzqfo3a.fsf@gitster.g>
In-Reply-To: <xmqqfqzqfo3a.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PN3PR01MB6205:EE_
x-ms-office365-filtering-correlation-id: ab8d18fc-8ec9-4d75-92d2-08df09c8e429
x-microsoft-antispam:
 BCL:0;ARA:14566002|14091999006|51005399006|31061999003|15080799012|24021099003|55001999006|6072599003|8062599012|8060799015|19110799012|25031999004|25010399006|40105399003|1602099012|10035399007|2607281247196008|102099032|4302099013|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2d0YUNyS3ZscHQ1YnVrVERJWW8xRTdQbWhqbEl1UFRsbzJRajlYVlZDYjdp?=
 =?utf-8?B?ZTZqTFUxejZmYnRVZzg3QVZsSlVmT0E3Zi9DY1JneFNhNlVPZW1oTUFxM3k1?=
 =?utf-8?B?a1FmRnpJT0RENHR0Vys0MXA3ZGg5dkptdDU2clQrSmpnT2t4NXIrTUc4N01I?=
 =?utf-8?B?ZVFLR1NsRnViS3E4Y28rYk1VYkJNNnEvNGc2VDArV2tiRGlLcXUwZDJ6UDRV?=
 =?utf-8?B?K3ZTbXZacDlLVURjRHRBQWRacHhCU3FFMCtLUHl2TSs3dGpwcHdmTkhMMi8r?=
 =?utf-8?B?bUhpV2FCQXpaVWt1NnVzSk5LclRYQUFXTDU5WHlGSGxYWjZvWHJJdVlEQTha?=
 =?utf-8?B?KysrNk5zaHMyNXY0WmkyMWM0VndoNVBPeEJvUDN6QW9oMDB6Ukk2M0Y3MDdr?=
 =?utf-8?B?bzJwQXRuVWlidElOemNQRlZvZGFGQy91Tm5yMTl4UVU5N3JJZnNQZlp6R2Ur?=
 =?utf-8?B?V3pmd2N4dWxKSkl4U0JsdHlMZ05EeDRsYWczdjE5a1JiWFMyZmE2ZXcweHBw?=
 =?utf-8?B?bzFTMzhCZ29hZ0VHcFA2Mk5UbDJkelJyMWhCSFk3d1JENXBVSFZlZ3BYQlQ1?=
 =?utf-8?B?aE53K1BESkw4cmQ0WGRpWDQ5ZXNjczg4TmF6bWFaTVdjSjNPZ1lnTENNVjNz?=
 =?utf-8?B?OCtWTlRTbE4wSmdKWis1a3BKWVFJOGR4VGhBVm9lL1hZd0puMkNWK2xQdE9S?=
 =?utf-8?B?bndjQ2txM3pUSXkxR0JDRWlWdjkyRFh2R0lHMWZQSGE5NDl3ay9CTlJNbnBB?=
 =?utf-8?B?U2NDWjR2dS80VVBHODMwRUo2LzRyaEZDWHltN2t5a2g5QTFvYVpyQTlnQUUv?=
 =?utf-8?B?bS96RUU4SGJ1YXd2K1UxMUFySCtrVVVWczk0MEVSMFdydDBRMlpPNEpVTjdn?=
 =?utf-8?B?L2JTdS9td1F5SlhEcHhNVHRCUFRhT0c0T0QwbEhVNFIyTnZtSHo3UHZxNkRQ?=
 =?utf-8?B?NWdtVFRYdDV5RVRZWmdCWUM0dDdJdG5jd2tCN0wwb0k2eXM4NGpyWnhDUUg1?=
 =?utf-8?B?TlV6MmNIWjNXZFZ1dU5HQjcxZ0t6SEJGV0VjdFdtNk93b2FBaFVMK3lkckEw?=
 =?utf-8?B?dzJmZkZ5NDR5NFhHMkhwT3h1TjMrWWIvR0JHZFZ0RDcvT1BPOXZENHRoWVpN?=
 =?utf-8?B?QkJ0TTl1QU5HTXNXcGl4VlJFd1VWZi96ajYyMW1UcWRrVnV2WGM5SzcwVzBE?=
 =?utf-8?B?ejBIT2ZmRlUwaG9tdFVJK0xiT2FtVWxyNTFDSjhLT0MvczVnbm5MQ09HRDV2?=
 =?utf-8?B?OXByUE02R2thOHdwek5LMXp6TWxQS1gxN09uclpNWldMRjVNRlhZdkp5Qi9H?=
 =?utf-8?B?VEpUdVdJL0YzaWtMNndERlVtRnp5S1JuaTlqR0wzUlM3Sk5uVzFCckgvZVR6?=
 =?utf-8?B?ZlpoMVoyOWc5ait5bFJvTW9VWlpNajVXUHJrdXNZaWtlR0VMTDlrZG9oZVBp?=
 =?utf-8?B?VjBScUdhUTgyZVRDQmZKTWw1a3lxNy8vU3grZnIyR0JISVJZdGUrcXVzV3lH?=
 =?utf-8?B?bzVGYTAxNk1XWXhnaDNYSmRWeklhRlJwV2tTNmkwcFFZYTExVEUyV2pRdmRP?=
 =?utf-8?B?OVNBZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0lHUURIKys4RnRYSXIraWs0SlV4Nm41cU1LalRaWC9leUNtRjl0b09pQnlY?=
 =?utf-8?B?MmxQTmx6bUhKYko2Qlpxc09YSUZETUtuZzRtaGE2Vzc0YUZMZjZaRThKZVpP?=
 =?utf-8?B?NlJua0FVZzMrTWh4L3kyMisxMFlrTDJhSXE4RjJMb2NianNYd2hrZVgwdGZD?=
 =?utf-8?B?TVROY29xejBFNUhZenlwVUpvaW4xS1p2UFVuVlBOUitvazRPNHBOZU05TkJw?=
 =?utf-8?B?WWxyVHBDVldaTHVQY3B3eDUxNUNMVGZQZnFNVHB1WjE4S3IvaThaM1pLdlZM?=
 =?utf-8?B?cnF0bXFnNEZGdDFWdEZtbU0yVkZRR1Q4TXFOclBiTzFOM3RQa0FyVTRmem1r?=
 =?utf-8?B?LzhidzdCc3VCQkF1bGREaFE0SjM0UzBhKzdkWnpYNFRRZzlPQ0poK1BzcXJL?=
 =?utf-8?B?TXhVaTE5KytHNEtWTVloSXVrNmZIa3ZIR3Z5bUtpWTBIUGJvMXo4aWNzeSsx?=
 =?utf-8?B?c2FtbG1pOE5DaGRiNk1nOCthNlZ3cmRjbWpkYmxKWWVURVhEQ1VSck9JYy9l?=
 =?utf-8?B?aTd0MzJrM2NPSmxHckJnb0ttTTlmWUtXV3RYVS9Qa1QyblErY1ZzR3JSYnhj?=
 =?utf-8?B?aGRxS0NJQTV4MGErU0tRWGVrRm5FN0NmdHJvRUIzTnpaaVFBcnBOZ0RTRnZa?=
 =?utf-8?B?NnVmMDQ1Y3dZQ3MvdDVVbWpvakxUTGloeWtnT2d1d05PcDhBdTlPWndKRm9n?=
 =?utf-8?B?NHBjSkorZHVEdVlqcmFLd1U1Y3Y0R1FrZlBYQmRVeVBXdjlucC9sR2NyQjVF?=
 =?utf-8?B?eU1rSDFvWmlmSGZkNmJuMVZlRGFUeG5yRzNOQU1LSjZ0TE5rVFJuczZ6ajVY?=
 =?utf-8?B?VGlQL1F0amFISzVNUDdoRkZuRVRaTjZ4NGRBT0RPQzh0cVIwbUZIa1JxaXlG?=
 =?utf-8?B?eUVXV0Z6WmpPQndzMTlYZlJzbnl1VnMwbXFrNlRjT01sMUFTajZoUWNWVjh0?=
 =?utf-8?B?VEF6UFhrNURYcGh4TlVINmdNdTdCRGtGTWxKSGdJVGJSb2lpbCtNRm5uS1lZ?=
 =?utf-8?B?OC9jdFVwOEtwQ2R2R1U0VjBVQk5Cc1pZeFdjZEppU2c5bEdNa2NTL1NNUzRl?=
 =?utf-8?B?WjFnZUFHQ0tKc0E1TUxVWk50Ukk5ajFKUW5OaHZEc3JTTWlQRCs2STl2MVV2?=
 =?utf-8?B?MXl5akpWWVFSbWUyZ0NzeDZkaFJHTEZBQkV6ejhvNmkwcGRFbGZrZ0JOMEpq?=
 =?utf-8?B?cXVwU0FGK3FqSk5ObDQvOWw5dVNBeDBRTVpwQXVPMXhOOG9zQlh1amhqaldy?=
 =?utf-8?B?bUJxb1Q1NUs0OUNOMEZ5ekFNNHdzcmcrQjhyREpWSGNiRHJzT2RkZEhiZlBH?=
 =?utf-8?B?cWIrZGVXK3N6dXduNmdVQVU3cVdQc1pxaFNxTFhwOTBaRG5tODNTYjBFcDhX?=
 =?utf-8?B?bmU3Z0lvMWhnREZmWXlPelpEQ0xia1MxOHlPakVFdTB1WkRKU3BTSlJUdWNG?=
 =?utf-8?B?T1lLb00xMWI2QXpndHZxVnEwcWdMMFVzM1VjM1FRZ01BLzZmNHNGdjhRZUtv?=
 =?utf-8?B?MmZtUHEwcFVVU0FLVjIrcWVVM2t5akFlYkIzZ2pQSnJpSjBld2FkRHZuMWRj?=
 =?utf-8?B?RXliNGs5R2dCNmgvdUFjWVRhTTZFUG5pUjQweDRCVDh6a3R5em9NUjBuOENR?=
 =?utf-8?B?d3lkTUJwOElHZ1UwSGVFY25za085TDZ3c2hrbTA5RjZnYXhqZFhPVlZKdHZB?=
 =?utf-8?B?ZWhXa3ozRVY4NGZoZWxHUkZRL0hSTkpENmtLN2pFSGIyMGN4VW1HQXFOV0Rq?=
 =?utf-8?B?UUhDREdENHorZ2Jkcmd3V0J1dDVCQXlqYVFJZHJYWHRqbE1XYnZpbjlwWm1o?=
 =?utf-8?B?d0IrYzF5VVNGNkFuSkVMbm10RHc1WFFzYkZFOXg0cUZ4cmpwZm0wSUh0bmRT?=
 =?utf-8?B?R3g4VExDZnVtN3ZEUUhYQ2lBS0pxbkIweHREVnkrU2hHQm5WUDlzVkgwalkw?=
 =?utf-8?Q?y1QVF/bPmXjSurN1RfiASV+IQy0PvnV6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d18fc-8ec9-4d75-92d2-08df09c8e429
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 14:37:33.5891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6205

U28gd2UgY2FuIHN0aWxsIGNvbnNpZGVyIHRoYXQgcGF0Y2ggaWYgSSBhZGQgdmVyc2lvbiBjaGVj
a3MgcmlnaHQ/DQoNCj4gT24gMyBTZXAgMjAyNiwgYXQgNzoxMuKAr1BNLCBKdW5pbyBDIEhhbWFu
byA8Z2l0c3RlckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdh
ZGl0eWEwOEBsaXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+IEknbSBub3Qgc3VyZSBpZiBpdHMgYWNj
ZXB0YWJsZSB0byB1c2UgbmV3ZXIgdmVyc2lvbnMgb2YgY3VybC4NCj4+IA0KPj4gVGhpcyBwYXRj
aCB3YXMgcmVqZWN0ZWQgYmVjYXVzZSBvZiB0aGlzIHJlYXNvbjogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvZ2l0LzcxMDg3NjRmNDM3YTI1MDc5Yzk1YTI1YzIyN2ViNzlmOWY0YWVlNmEuMTc1MzI3
MzU1NC5naXQuZ2FyZ2FkaXR5YTA4QGxpdmUuY29tLw0KPiANCj4gQSBodWdlIGRpZmZlcmVuY2Ug
aXMgdGhhdCB0aGUgcGF0Y2ggaW4gdGhlIHRocmVhZCB5b3UgcG9pbnRlZCBhdCBkaWQNCj4gbm90
IGNvbWUgYW55IHdheSB0byBidWlsZCB3aXRoIG9sZGVyIHZlcnNpb25zLiAgVGhlIHBhdGNoIGlu
IHRoaXMNCj4gdGhyZWFkIGlzIGRpZmZlcmVudCwgaXNuJ3QgaXQ/DQo=
