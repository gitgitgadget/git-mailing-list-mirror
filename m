Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011012.outbound.protection.outlook.com [52.103.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18D342C80
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667957; cv=fail; b=XBVS24IvDPQzsYK9d2GZaVBSVaeO55sfTmLS3HAtR9lLEGLRqy7YV6WHHdr8DFVro6zne00kl0UYph+FKfZ6IoY+RZ9gYq+oEYhQTP7ZHlTn5jCFtlG6bGhnnyfMBdZBgkKCbwT41Q6ylldNI5pEK26n4rF+RxVsxj9684gkgf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667957; c=relaxed/simple;
	bh=taetqnRolm003hkTaZmJ9nXK0CDu0gQly1V0w6jEcn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPcICJI8XMgP+aOsBaDoxFNPMt3KgWu4nnUbmBBFvpa/PxHGjqzaeGAgCQqhsNE1GiXZpIrgOhYTweytIX34+LS6mR2wYHzE5AXXghj9Ko39S1w8Dh+rDq2Fq14qGm3B4mwBhQ5qfUtjvLnxcDkTpQDlkiO2bQYLP/yWgkpXjF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P5fpRqYm; arc=fail smtp.client-ip=52.103.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P5fpRqYm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNHfWH1RAkQwyjrcsdp8zPeDxwey1jiIAFHRn+cn50Y+/bjasrBIgHB45hJtLlXPCxolBjWAak4wsEnWk6f3zmO/kWqPhe1o7Yxp1GjWQ64Q+KMMuT3jb3qK6iOhkMH8xDtjftko/3YlRf+fPgE2xCue0uX20Rb0IShTyDcUOYfsOLxDFyrfb4/IiL5LnYQc/Ji9tTqM1KZiV9SpyycRhC3AnI4KhQvDbjnhPaMAwL87tFf9+IzWZF2nGnDMmxNGRXoFUJUwjiEk4f2e+/yWuhLGoJt6pfZmx/ib75Idj1GrbXt7UdYIA5iP8gbl+eq55qCVa3qoHuZa41C5wq9yEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taetqnRolm003hkTaZmJ9nXK0CDu0gQly1V0w6jEcn0=;
 b=SnEYRp9MNj9++LndgabnXSQGVeEV4UcrmyiBh40AjMF6EjRPIwzq66PMJ6r4Tbtrcq6E+wvJ+AXytyP0ZrlCyR6+DlPp57vNhGQ9xzJJw9cIiVsbqOm8CmJgMjRNePQ6FbEYASTM8vBaO0zCmMGZQEvTht2Xnz3l+vSwGqjsshyxwQ7XeuCM/UkXQoFTTE1bfqc4AZG6ZQA1NAZzm+26lGPIOKu4X+LnMTN7ZxFcOL00S6Rr/g4J8RgMfFxOyqwfwlNzxWbdfghGmT3GHoOeAmQQKPkwRL3RrxsiaQ+c4/fUeZ5c+pfLlLAu8DTBKZOPcZJEHf2QMWT18pAVWmk6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taetqnRolm003hkTaZmJ9nXK0CDu0gQly1V0w6jEcn0=;
 b=P5fpRqYmljbfFjLXl+alY1hfWcc1Tuj5/noR9aT7TGoP06D78ylo1BkpY5hWMAn6YzODQ8RzhPz8fgfjl2YncUBhNf54yKvTuloT9/T7z1AQ1VNk7MUkCdlOgHXO7ZwYlXDzV57RM2it33XmTCS8h3SXvDC3EmL2xHy2R8I6o92vhyCQXg5VlokFX1SRtk1AKzllX3viXscHyRk+EXWHwdP5yAD810CtLKkB+kCHIWVJZZtKQLCrWZ8+Bc2mcoXvEi5p2yvV1bG7ei8yNKdcx8g67gqq/FglzN+9ZdHlaRkfJF8lmSH5qOzRnLuazxpihg1y9H77NG1wMqbwvauRVw==
Received: from SN6PR03MB4285.namprd03.prod.outlook.com (2603:10b6:805:c1::17)
 by SA1PR03MB6609.namprd03.prod.outlook.com (2603:10b6:806:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 16:12:33 +0000
Received: from SN6PR03MB4285.namprd03.prod.outlook.com
 ([fe80::c791:d115:d795:c7b]) by SN6PR03MB4285.namprd03.prod.outlook.com
 ([fe80::c791:d115:d795:c7b%6]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 16:12:33 +0000
From: Guo Tingsheng <CoriCraft16@outlook.com>
To: Elijah Newren <newren@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW0JVR10gZ2l0IG1lcmdlIHNvbWV0aW1lcyBsb3NlcyBjaGFuZ2Vz?=
 =?gb2312?Q?_from_one_branch?=
Thread-Topic: [BUG] git merge sometimes loses changes from one branch
Thread-Index: AQHcI+qvMP+t4sCqq0moMyiXAY3GTLSQKTyAgEfXr3E=
Date: Tue, 28 Oct 2025 16:12:33 +0000
Message-ID:
 <SN6PR03MB4285533B67E31D36172A4C34AEFDA@SN6PR03MB4285.namprd03.prod.outlook.com>
References:
 <SN6PR03MB4285CA9885AE7952EEF762E1AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
 <CABPp-BGeZ6no5LdBGKjykQLqUHRjFis7ZtGdEwnzg0gy_CkLqA@mail.gmail.com>
In-Reply-To:
 <CABPp-BGeZ6no5LdBGKjykQLqUHRjFis7ZtGdEwnzg0gy_CkLqA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4285:EE_|SA1PR03MB6609:EE_
x-ms-office365-filtering-correlation-id: 2fdb3c48-099b-49c4-06f9-08de163ccd51
x-microsoft-antispam:
 BCL:0;ARA:14566002|7042599007|31061999003|461199028|8062599012|8060799015|15080799012|15030799006|19110799012|10035399007|440099028|3412199025|4302099013|40105399003|102099032|3430499032|1602099012;
x-microsoft-antispam-message-info:
 =?gb2312?B?RkJxVjJZKzFQdnh1UWc1NW12QzVzRXBtU2JHSHJhVTE0cGRNSDI3RmhxNzVi?=
 =?gb2312?B?aFBXcEZwRkRya05WUG56RldMaWUxU3FRQlRnK24xS0l5WHo5cU80WmFmanFQ?=
 =?gb2312?B?Qk1TQXhpbndLZHh0dW5XUGxDNVRoUm54NVNUNUY3ZXNMejA5dm5sa3AwWjly?=
 =?gb2312?B?SUV3UUg4Z0E4WGJzNWptZFI4NU1tS09HaEZ5SkxWcUZEcFVkOWR0OHpyVCtl?=
 =?gb2312?B?dlJadmtnS2orSGwvNVpubGZXd2hTSVRQYTkveDNDT0FYcHc1d2UwVVVtbHJp?=
 =?gb2312?B?TTdkYlBiU28rcUpJbEhBK0FnMWo4UFBabWt2dGJKamJHUjJvakZVWUxEdVM0?=
 =?gb2312?B?UWpCQmFVR1ZlY2FNWFN0L0ZFSzVHcndVNzJYRDFOQ0FwdVRoNjB2eEwxcWtJ?=
 =?gb2312?B?c2d2bm9KSlp0bzJYdkgwaHhYZXVScXJoOXV4SUZsMkpudkkyL2FqMkJqMVd6?=
 =?gb2312?B?WGhnVjFUaG83NlVaYWtjNjdxNk9Xem55bHJXaUhsL2FjRm9udHRQVDlpVXJR?=
 =?gb2312?B?ejdPWE9oWXcySFhFZmJ4bkp2QVBIWlJqekF6RE0yNWpiVytROExNdGdpL05j?=
 =?gb2312?B?UThCQ0plZzVtdTZrNXBNcnZLWmI4V25aNTFKdkw4dFRlRVovRWVYVlRpeXhq?=
 =?gb2312?B?MkVZZ3c3OThSKzI2Sk9mSEh3TUY5cTE4L0VGc0pJOVFvNHZZek5XMHN1OVRK?=
 =?gb2312?B?TXJkcFN2SG1Pc25qcHd5S0x3QUpGdUt1SklTSFUvTnM0MXNtVXE4SnQ3NytM?=
 =?gb2312?B?WmkySHhEbUs3QzlTQTRlb0V0NkVYaUVFUTFuR2VOTHBtb05RUWprbGwvSHJn?=
 =?gb2312?B?NFVXblBoZnlXR3JWS0phVHB5K28ybGFZbDhWVHQ0aWlJUEh5KzBkS28zZm1a?=
 =?gb2312?B?R21qVHczWFZUT3JQUWJhang4NXc2cE93c0NRcU52NWlYcm96TFlQUC9zaVVR?=
 =?gb2312?B?c2dSbXR1QkZ4RjNzNzFGQVVpL0hPSXIxR1V5SEs0M3dVcDBIQ2QwQU1UQUJZ?=
 =?gb2312?B?OEh5RC9QNEI4Z051cGhSbmV4T29TK3U3bGVXQWwxWExxK2JrcDllYU1HTXZX?=
 =?gb2312?B?SnhsQkdyQ21qUmE3Qnp4SGNCODZoL2pUaTk1cVdkV1FjVDlmRFg1NXhlN2g2?=
 =?gb2312?B?U1RoQmZkd2ZjM1ZBRkJsZUJTOEZhWTFqTkFIVWN3QU1yU2xIZ1R5Um1rNnRw?=
 =?gb2312?B?cklSdWRXMW1HNFpYUHZEaVVPLzlJaHFPYVprVkZUcjQ5UjQ2VlROWGM4cUZT?=
 =?gb2312?B?WFZKNU5sa29IT01oNEdBOVRJQWROZEtVRVBYU1ZwME1rajA0d1RxZGRCc3hz?=
 =?gb2312?B?TXh1S0pRYkl0ZFQyWmppM0lZWHFXSy9PS2RaVE81SlRoU3VJWC9aU241Y1g5?=
 =?gb2312?B?SG1CTWk2WlBaTi9ITmdHc2pjeUNmN20rYWNwV1BkbjdCcWlLY2RneXBBcjZB?=
 =?gb2312?B?YldvRUdnbCtJaGl3Y1B5UjUvN2Q3MFBlK2xBb2UxMm9XUHp4QjFlS0g5bkZH?=
 =?gb2312?B?WGJEaHlodGxZQ21jckFFUmRKbHN6N1FUckRHajZrRGRpWGwwQ0t0N3piKzZK?=
 =?gb2312?B?aytkc2pLRzJramczM2ZNaHhEVmE1U2VrZWJ4S1VmRXBqRnFKNjdvZytac003?=
 =?gb2312?B?dG4rc2pqM3hLd0M2VmxHeTZCYkwwUWJhd3NwT0ViVTYzS04vVnA3a1RVVnpy?=
 =?gb2312?B?MEVTcGJkR2pnR0Z6L0xZcnhVdmNPU3FUcHVkMzVKOFVRMlFMdFhTU0VxcTZr?=
 =?gb2312?B?R2VnZGxzWWUyRkxkKzZzdUZKcHRPQStNV3dMVlRHSEI1UXp2TVZOZE13UWY2?=
 =?gb2312?B?c0F1TElmZTRnY005QVM4dz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?d25aR2EvdGpXdGIrV0FGZ014bjFvdU5IQVRPeDZjZ0Z1aGpHMElXNnJSRWRh?=
 =?gb2312?B?T2dNWi9SNTl4Yml0K2ZUajN1c0FMZWxSb0p5R2pla1VndUJYVWl5NjladUgx?=
 =?gb2312?B?Y3NKaG4zRGVuamlwdEd1bkUyeXVXUkNTSkE3K095d1NrcTlETytKSm5NdUFY?=
 =?gb2312?B?MjNZODFWT1pZRHRUdm9WR2IvNVU3M210M3NEUi95cUhHWldPeENiTG5IZE1V?=
 =?gb2312?B?SjRLeTZNSzRiNkRYRmZ2eFRTWHFJR2FjNCtrcjd1ZjRVREphRy8yQ3FGUGFq?=
 =?gb2312?B?ME9zaWlmbDdqK3E5d0QzOHFJK1BITzVyTHJQcG1iZGdnajJPM2I0b1hCM1Bm?=
 =?gb2312?B?RTZYc01Wb1NwWU5obE5CVnhtYUVGRnpPUUtrOERYL2V1RFdFSTFQN1Bka0Rz?=
 =?gb2312?B?MEZDeCtLWjZJS2FqWGgyTDdRZ29NQ05xTC9mcnhiTEsralc2emJPUE9zcE9H?=
 =?gb2312?B?Y2FJL0tsd3pDaE0wSzVyMGVQSVhEMGN5UFFHSVNQU2hoZFhrS05DK2VWSmph?=
 =?gb2312?B?dTVMQjJhM2tRdjI5bDMvTzJTeVc4aXUydHIrMkllaGcvSmVRV2Jyd0w5U0tO?=
 =?gb2312?B?U3ZUZVhLc2hFTDZyR3BpUFh5QzVxL21lR01WWElUdWxodktRODF3SkFneEF5?=
 =?gb2312?B?RXVsU2pLU2wzLzVSbjhHMDVqTHU3ZFNSSkQ1Y0hLWGhMcW5pM2RGNTdxNzRW?=
 =?gb2312?B?ZGN2OHZNUzFFTHprL1VsZ1orVHVvMFJXN0E4WkppN0Myc0FQWFl1TFd0anhI?=
 =?gb2312?B?SW4zaHNtNml6T3FkbXo1VnpWSzZiUC9BYWk0N3NmMjlpVm8xbmMxcm9Cdkxt?=
 =?gb2312?B?aHV6TUlaeWZiT2dObnBuUGZYQ2dWTWdCZStNNFNmV3VDQzVvYVRiUVduQkpT?=
 =?gb2312?B?Q21jSGMxbnJJUVdPUnRGZ3FpWGNSVUE1SldwdUpSTmM5ekhWamRnYWxEVWZk?=
 =?gb2312?B?YW5ERzYwNVgwLzlVRTF4WlBtYUI4SlFiUGY2ZjdtaCt2NmlRYWQ0c0tPZTA0?=
 =?gb2312?B?WHNLajJCZWlCdUdGKys4SHd5Mnp6SWZkTmd0QjFrRWpQaG93Nzg1eW1KOFo2?=
 =?gb2312?B?SGVWSWc3bVd1VVJLeGJ0K09DeXpIbUM3b2hmd0wyVnErZHZGdGhoWXEwdm9U?=
 =?gb2312?B?aDgxZjhMMm5JOUlGT3Bac00ycC9sVzRtQTBVeWx2aFBOblc2S1c1UkRHSStj?=
 =?gb2312?B?c1lEMFJuVmtMK0h3NnlqSGpJNjZuK1diaWE5TlBQSjVqY0R3WnV3V2JKN243?=
 =?gb2312?B?MjhCaXZTdWEyRU1XeW9WTVhHQVdqdlFRNVdFdjdzc0E5MUJwS2p6YzNaVVly?=
 =?gb2312?B?TTErQVlzcTZQb1lGenFZS2ZrMXB2UC9kejNBbmhGcTVodHVXcVlHaXpremlp?=
 =?gb2312?B?ZUVoUC9PM054RS9ZYUVtWWVoVGE3Sk05Qy9CSG11cG9RdE5LVEFMRWRkbTR2?=
 =?gb2312?B?UUlsZmc2VDA0cnRaTS9yWmIvZEpTRE9nUUtZb1Fza24yRFk2TFJteFZkSHRy?=
 =?gb2312?B?VnY5Q2tZMVRCR25mQ1pidWRIbDZ6Y0tTcmdFellkd2o2LzhPK1JyVEhnbHZt?=
 =?gb2312?B?aWUwZnNPek5neVk5UkZGSFB0ajJGZWRxSmFTVE1mMkM0c1ljcTZHcUdNcDNH?=
 =?gb2312?Q?LeR7OUm8KMusvOARWSDBcdOVo7IwzjR1NJHRQ8tXVEfY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4285.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdb3c48-099b-49c4-06f9-08de163ccd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 16:12:33.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6609

SGVsbG8gR2l0IGRldmVsb3BlcnMsCgpJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IGEgcG90ZW50aWFs
IGlzc3VlIGluIEdpdKGvcyBtZXJnZSBiZWhhdmlvciwgd2hlcmUKY2hhbmdlcyBmcm9tIG9uZSBi
cmFuY2ggbWF5IGJlIGxvc3QgZXZlbiB3aGVuIHRoZSBvdGhlciBicmFuY2ggZG9lcyBub3QKbW9k
aWZ5IHRoZSBzYW1lIGxvY2F0aW9uLgoKVG8gbWFrZSBpdCBlYXNpZXIgdG8gcmVwcm9kdWNlLCBJ
IGhhdmUgb3Blbi1zb3VyY2VkIHRoaXMgZXhhbXBsZSBpbiBhIHB1YmxpYyByZXBvc2l0b3J5OgpS
ZXBvc2l0b3J5OiBodHRwczovL2dpdGh1Yi5jb20vQ29yaVdvcmsvYnVnLXJlcGxheS5naXQKCllv
dSBjYW4gY2xvbmUgdGhlIHJlcG9zaXRvcnkgYW5kIGZvbGxvdyB0aGUgUkVBRE1FLm1kIHRvIHJl
cGxheSB0aGUgYnVnIQoKLS0tCgpFbnZpcm9ubWVudDoKLSBHaXQgdmVyc2lvbjogMi40My4wCi0g
T1M6IFVidW50dSAyNC4wNCBMVFMKCi0tLQoKU3RlcHMgdG8gcmVwcm9kdWNlOgoxLiBPbiBicmFu
Y2ggQiwgbW9kaWZ5IGEgZmlsZSBhdCBhIGNlcnRhaW4gbG9jYXRpb246CgpAQCAtMTA2OCw5ICsx
MDI2LDcgQEAgcHVibGljIGZpbmFsIGNsYXNzIEF1dG9CdWlsZGVyQ29tcGlsYXRpb25UZXN0IHsK
ICAgICAgICAgICAgICIgIH0iLAogICAgICAgICAgICAgIn0iKTsKICAgICBDb21waWxhdGlvbiBj
b21waWxhdGlvbiA9Ci0gICAgICAgIGphdmFjKCkKLSAgICAgICAgICAgIC53aXRoUHJvY2Vzc29y
cyhuZXcgQXV0b0J1aWxkZXJQcm9jZXNzb3IoKSkKLSAgICAgICAgICAgIC5jb21waWxlKGphdmFG
aWxlT2JqZWN0KTsKKyAgICAgICAgamF2YWMoKS53aXRoUHJvY2Vzc29ycyhuZXcgQXV0b0J1aWxk
ZXJQcm9jZXNzb3IoKSkuY29tcGlsZShqYXZhRmlsZU9iamVjdCk7CiAgICAgYXNzZXJ0VGhhdChj
b21waWxhdGlvbikuZmFpbGVkKCk7CiAgICAgYXNzZXJ0VGhhdChjb21waWxhdGlvbikKICAgICAg
ICAgLmhhZEVycm9yQ29udGFpbmluZygKCjIuIE9uIGJyYW5jaCBBLCBtYWtlIG5vIGNoYW5nZXMg
dG8gdGhpcyBsb2NhdGlvbi4KCjMuIE1lcmdlIGJyYW5jaCBBIGFuZCBicmFuY2ggQi4KCi0tLQoK
RXhwZWN0ZWQgcmVzdWx0OgpUaGUgbWVyZ2Ugc2hvdWxkIHJldGFpbiB0aGUgY2hhbmdlIG1hZGUg
aW4gYnJhbmNoIEI6CgpAQCAtMTA2OCw5ICsxMDI2LDcgQEAgcHVibGljIGZpbmFsIGNsYXNzIEF1
dG9CdWlsZGVyQ29tcGlsYXRpb25UZXN0IHsKICAgICAgICAgICAgICIgIH0iLAogICAgICAgICAg
ICAgIn0iKTsKICAgICBDb21waWxhdGlvbiBjb21waWxhdGlvbiA9Ci0gICAgICAgIGphdmFjKCkK
LSAgICAgICAgICAgIC53aXRoUHJvY2Vzc29ycyhuZXcgQXV0b0J1aWxkZXJQcm9jZXNzb3IoKSkK
LSAgICAgICAgICAgIC5jb21waWxlKGphdmFGaWxlT2JqZWN0KTsKKyAgICAgICAgamF2YWMoKS53
aXRoUHJvY2Vzc29ycyhuZXcgQXV0b0J1aWxkZXJQcm9jZXNzb3IoKSkuY29tcGlsZShqYXZhRmls
ZU9iamVjdCk7CiAgICAgYXNzZXJ0VGhhdChjb21waWxhdGlvbikuZmFpbGVkKCk7CiAgICAgYXNz
ZXJ0VGhhdChjb21waWxhdGlvbikKICAgICAgICAgLmhhZEVycm9yQ29udGFpbmluZygKCkFjdHVh
bCByZXN1bHQ6CkdpdCBzb21ldGltZXMgcHJvZHVjZXMgYSBtZXJnZWQgcmVzdWx0IHdoZXJlIHRo
ZSBtb2RpZmljYXRpb24gZnJvbSBicmFuY2ggQQppcyBsb3N0LCB5aWVsZGluZzoKCiAgIEBAIC0x
MDI2LDcgKzEwMjgsOSBAQAogICBwdWJsaWMgZmluYWwgY2xhc3MgQXV0b0J1aWxkZXJDb21waWxh
dGlvblRlc3QgewogICAgICAgICAgICAgICAgIiAgfSIsCiAgICAgICAgICAgICAgICAifSIpOwog
ICAgICAgQ29tcGlsYXRpb24gY29tcGlsYXRpb24gPQogICAgICAgICAgIGphdmFjKCkKICAgICAg
ICAgICAgLndpdGhQcm9jZXNzb3JzKG5ldyBBdXRvQnVpbGRlclByb2Nlc3NvcigpKQogICAgICAg
ICAgICAuY29tcGlsZShqYXZhRmlsZU9iamVjdCk7CgotLS0KCkFkZGl0aW9uYWwgaW5mb3JtYXRp
b246Ci0gVGhpcyBpc3N1ZSBvY2N1cnMgZXZlbiB3aGVuIGJyYW5jaCBCIGRvZXMgbm90IG1vZGlm
eSB0aGUgc2FtZSBsb2NhdGlvbi4KLSBJdCBhcHBlYXJzIHRvIGhhcHBlbiBkZXRlcm1pbmlzdGlj
YWxseSB1bmRlciBhIHNwZWNpZmljIGNvbnN0cnVjdGlvbiB0aGF0CiAgc3BsaXRzIG9uZSBwYXRj
aCBpbnRvIHR3byBkaXNqb2ludCBzZXRzIG9mIGh1bmtzLCBhcHBsaWVzIHRoZW0gc2VwYXJhdGVs
eQogIHRvIGNyZWF0ZSB0d28gYnJhbmNoZXMsIGFuZCB0aGVuIG1lcmdlcyB0aGVtIGJhY2suCi0g
VGhlIG1lcmdlZCByZXN1bHQgY2FuIGRpZmZlciBmcm9tIHRoZSBleHBlY3RlZCBjb250ZW50IG9m
IHRoZSBvcmlnaW5hbCBjb21taXQuCgpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgeW91ciB3
b3JrIG1haW50YWluaW5nIEdpdC4KCkJlc3QgcmVnYXJkcywgIApHdW8gVGluZ3NoZW5nICAKPCBD
b3JpQ3JhZnQxNkBvdXRsb29rLmNvbSA+Cg==
