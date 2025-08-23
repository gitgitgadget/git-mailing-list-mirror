Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011030.outbound.protection.outlook.com [52.103.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D56214807
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931535; cv=fail; b=VtoKt0UyGovSU5VyhnjWRTNSOQlUJVFuIV/sVTjj37fC7elMVySjpWTPfnuJgWzFEIr09QBRVQ9gOs6+w0KbSlSMFvq5PWQDIfJh9Dlh7oJ8j+8WFLcubq/ygKHf8xQXKw/hk2nXV836engTwy+tNwd5tLVGarjhVHZ3G4DHF+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931535; c=relaxed/simple;
	bh=VunvTWYnHzC2JyNu0hihEos7JowwmYDxHovvZzlZUtM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=psS0BNg98d0uAjQT9FiiP3byc8Mnn6/fPCroNM/wCVv0J5NPW8fWSZto+LPJDR9Ej6UHTBagkKP5E09Kn1Szhv332RHr7ktK4eTPem+Iik3vu/Ix007OczjkVnGbJ8NkEnqn5ScT2DjzKOPracNQECnPXrHaK0knsmDi+92AgIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au; spf=pass smtp.mailfrom=live.com.au; dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b=RGbfXcs0; arc=fail smtp.client-ip=52.103.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b="RGbfXcs0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoplOsSS0YLp20T1jGB7nSoLR08ofP+3oNiuoeOgg8ZOKjUIhSlsMk1mXMdDdk39Ny01hL6FlIAPHOukQVnLE1mq3AhzIskoy9nj8SIe7xtn/5lxiFpif44NiDREIyeOcDQ93dISqKTeVysPME+VE4UfTad29AbWOUD2PeQRpWhviB8Bdu+VAx7b/5hTpUg0VfUB3NFKiS89Z+cVzitEhuwCBOV9+hcOeLEd1N2KuauWDowqltFy9KjDuo4Ji8goq6DVTSU7XXNZocRCaue4pavS6GZLxFkWtfley05VlesONzeiU84Z7ytKb7PlSz5mjVYebQ5v/jDGdzOywjoPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VunvTWYnHzC2JyNu0hihEos7JowwmYDxHovvZzlZUtM=;
 b=ksicJWE16Ju0aPhX3ruWi5SSXB6pGbWi0vg5lwiPHXFVNtPCv5kLIsuf+LFU7S82gKZ0T/npwieC5jJLct7x9z5ngytqUOo+28rGLhgoPKzTemEhvaXClGhpUOKQvwdnb/Fuz5yQQPt05QR2EsWD7qPBpLXsHBHhPeJPTYieSo9kUv1Xf5qwzZCeB7sg6cDM9VgYnMr+5rFebhgUZwUuIUA9rHy3RaO53gNiK7gZYoPNwO0K6b4t4mshkkWDsBFYXmM+PD7OS3899ErcswBzWwvHFItaMIBXouC9DxKFzvxgzrpZHRddvPljJhP3JeLwqyD2oQe6Qn+lveH7doAlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VunvTWYnHzC2JyNu0hihEos7JowwmYDxHovvZzlZUtM=;
 b=RGbfXcs0y623mH4VHX9ho6Kvvm/8SwQyq9VI4Oi4gD6r8H/VGW9FXW2FTD4aLwNKYNzY7Sz18lqAWsqEAz496m2S5tl/R8dlPprq/sjsKCHZJBFg3Mfn8htBNCRxz5CJ6NTWMaovyrJtvej/wWOMDWd9eCIXoek3LJUp7+jqGB5dqL/hK96H27MYRZ3orcLIN1pnFAj3unH/fWdhTTERLPW8osxgAAH+xKOE5+7+Dw/t8s3GKZFU/CBCySO5/IMkGRKXd7umrNnOUU7xpmOZPhnzVFigRx/7xzmrHHYHlcPxTeuDYamVT/89AIa1vtfEaQ2UkjxXStAMcpSHgOKBlQ==
Received: from SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:156::6) by
 SYYP282MB1117.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:74::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.19; Sat, 23 Aug 2025 06:45:30 +0000
Received: from SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
 ([fe80::942e:8672:69d1:38dc]) by SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
 ([fe80::942e:8672:69d1:38dc%5]) with mapi id 15.20.9052.017; Sat, 23 Aug 2025
 06:45:30 +0000
From: Isaac Oscar Gariano <isaacoscar@live.com.au>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [feature request] allow directly committing untracked files
Thread-Topic: [feature request] allow directly committing untracked files
Thread-Index: AQHcE/kNbbM7Wu3xskC1MQQgVOdsKQ==
Date: Sat, 23 Aug 2025 06:45:30 +0000
Message-ID:
 <SYBP282MB2963ABA12BD14594F62E47B08C3CA@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBP282MB2963:EE_|SYYP282MB1117:EE_
x-ms-office365-filtering-correlation-id: 92f7a446-8aec-401f-332d-08dde210a6fd
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|31061999003|15080799012|15030799006|6072599003|461199028|19110799012|102099032|40105399003|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGVBbzhjWlZkNWcxZXhGMzlXeFQ1WituQTJRd1JIMlBodUxPYm9MNFVrMUdt?=
 =?utf-8?B?cEp1U0kvWUJrdlVTNDU2VFFuNHlpVUhYRVdDTkhyRitLYWwvNzRabStYdmdL?=
 =?utf-8?B?bGFrSVJaN0FqaFN6ZnBabWEvN3cvR2ZXRnJaOTJLaGl1cDZSelpQN1JkWGgz?=
 =?utf-8?B?NjlsWVhuNjFPMTA4OStpMUZhQ3JjVDFvZ3B3NUFSMW53amJnVXIzKzFVcHgv?=
 =?utf-8?B?aFFFRHE4azVDR2ZxUDlSd2g2RHZkclFUT3VaaEtYcFZGNGRnWHF6UWlYUjlk?=
 =?utf-8?B?STN2TDBTUVpDemRQYk9nWnVjYjM4cDlWQmFjOFcySVdraWV1ZjBYMFAxSUps?=
 =?utf-8?B?MDFYQUgyaEhMSXFQREtQV3lIcDE2Y1VvNkNmV1pnTW94bFJuc2NCN2hDOGR6?=
 =?utf-8?B?T05EWUNWS0hEM2tkVlQ4dnhJbTZ5emcvd09kL2lMc0tTbWlybTY2RjdxYURH?=
 =?utf-8?B?aWtVSmJYMngxN3NneUNSdzUxdmJ1bW1zQlZDSWI3TWRGQVk3YVZFU0hmZkwr?=
 =?utf-8?B?dXNkaDVZSkNCc1I5Z2QxSC9SRW9YY2k3RDAxblBEbTlmVUE3N1ByekxaTHRt?=
 =?utf-8?B?cWEyM3Y4VGlwWUsyK0hZSnl0eU50RzlsK211eENXUFhkLy9adm5jTnJSVStX?=
 =?utf-8?B?Q29CaTFxclIvN3VDaDRpNTdGT0FaL2FaU0ZWNzFuKzlYTlJFUXBCdWp6Tkor?=
 =?utf-8?B?SGNJNEx3L0g1UjFnQkRoZkFDVUczZzYwd1k0MkVaQ3RxYkM3c0RhdHBzYnh3?=
 =?utf-8?B?MDdpS1ZiUFBrWTRTM2VjYXpRR2JnTmhua083RVdIVnQ4TWgrWnlDSkpiTFl6?=
 =?utf-8?B?ZFd0YXNoQ1YveVhOOTl2MVRvbmZ2WnFwYkI1Rk0xYXVKUnc2WDBFazhOSWRv?=
 =?utf-8?B?UUpXS1NjaEJ2UjJqdUhrek4zdDhVZytiU3NxcVNtTkhXVnlaR3ZxbHI1R1Iv?=
 =?utf-8?B?TUowTThMbi96blpTM2hQOW9OTkt2NFFjVDQxcHBRSU9nV1gzZTdRRjloY09q?=
 =?utf-8?B?eDRRVnk2QW9Da2FHdzJOaU1aZ1pLSzloTmZZVFR6MU8wQVptdUdZVURYcW9Q?=
 =?utf-8?B?YU16ZlVmd1M0eGFBNGszbTl1UW5nWnFOZG1RRnJoOTZQUEJWTVdZMGV0N0Z4?=
 =?utf-8?B?SjBqK0FsZEJXN29admsyT0wvRi82Z3g3U3VidVNMVmwxTGVhbHhWenRWNUpt?=
 =?utf-8?B?VnFvbVZESE1MYkcvRnF3T21hUVNRck5XaGsxcFJFTFlPUGoyOUtRWmhIS1lF?=
 =?utf-8?B?UWRxdnRIRUhLcEU4eUZkUS9WN0JETTFyb2ltTkxrK2hjWlZkZy9PN0VKbDh2?=
 =?utf-8?B?WG9pVlZJa3BSNFUxUVQ4U2R1NmMwNGZJVzZKZjNtbjJpM0hXb2RZQmZpaVRT?=
 =?utf-8?B?OW5zUERyTXFWVGlvWDZYOXVQM2l6a3dLRncrSzlpL0NnUmd5YU0wR2FXUE1z?=
 =?utf-8?B?UWpVSUFrcG5SU2llLzhTa3RSb1FrVFQyanp6em96QmdhK3RFTVRja0FTamVS?=
 =?utf-8?B?TVRjejZabEZkcXFLTW1MdmF3R3ZwQU1rQkd6SHBtdlZUTGVxNVY5RmZjSGxl?=
 =?utf-8?B?RkpVVEZ6Rzk1MVo3TVNaZmdrdzNHZVhkaHlmenVxSTBFYVNEdTVaS2hEMGgx?=
 =?utf-8?B?Ylh4KzNXRUpYUWRPcTYwdDhZTUM3OEE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1EraFRNUFllMTd5L1ZUMWowa0tzY05Pdk51NVo5RS9KNnAyWnRKczlQcERn?=
 =?utf-8?B?SHR5YitQSnlDRkxOMFBjaWsxRm1RbTNlSzRnTG1CNEZvRHZmcmNQWm9CSnFJ?=
 =?utf-8?B?clNGRG96TVp4ejgzeVpoQ3dGcStvY09Lc013YWh6MFlpRG1JMDhQQmxFU0xt?=
 =?utf-8?B?dWdreEhEd2ZuT09jMXg4UXlJL0tMM2g2WUNubXA3enRrZEI1NjNzRk40RlRS?=
 =?utf-8?B?Sm1HdHo3cWkwdk9hbDRWdEIvOGFQdUFxcFhUYzUxb2VjRzJkZ1pjUmlKN3R4?=
 =?utf-8?B?cFNrMHhTaC9SZFJTaXlLeGx3eU0ySWFmUFZxUk1CbE1GczNmNE4zb0Z4S3px?=
 =?utf-8?B?MlJtZzRuTDZscWw2eGp0SlpMN2cwQkR0RGNOMzRZSDFnZHV5eHRGSjAxZ3Zk?=
 =?utf-8?B?Yk5xcUxSbFMwZkZYSDdML3dnQ2hFTE12RE0ra04zMmhpQzFHTTlMbHROVHow?=
 =?utf-8?B?Wis0TVkyVzBHbWl6eHJqVDhIN1MwR2duTkE0OU5TNmlLSzc1N3NTanl4ZTVo?=
 =?utf-8?B?cmxQSUQyNXduOXF0TWNpQkdzL1FzbzNidmJ6bmplZSsyKzVqVVNBVlJaRnRk?=
 =?utf-8?B?ZTZWY09lWXJPdklFMTUvZmJ3VndybStyWFkreG0rQnlIQVZpMUVBT3BWdm1h?=
 =?utf-8?B?dkpaQ1Y4MyswelIzNG4vZVI4RXNpZTNTZEVLTjRMb20xK1FiUms4TUllazFh?=
 =?utf-8?B?OC9aZVhZbnhwY0szODVJZEhtZVRUQ3VRZkdxYjRlNURLSmxOam9UVXZwQzhQ?=
 =?utf-8?B?UkRTTll4R3IrRHpOUFBJVVdsMEhJa1NMRzVvRTc1ZElnaDR5aE4xRVJVcmJ5?=
 =?utf-8?B?cDRBN1ArN3pxaUIwTExIWTlDNnFMd01NS0pZTDlwUVhHUFF2aWtFVDFWbXRC?=
 =?utf-8?B?Vm9qRms0NE5xZDhsYy9NRThYM2VjdVR1RHZCMzdWUlg5czh5dTJWMnFhWGt1?=
 =?utf-8?B?MkErTkxaY0VxaXhDakxUaW0yaDVEbTZGRVVtcm4yYzVPd3pNY1BMcFEyOVY0?=
 =?utf-8?B?b0NvL01ManJXTnM5V2N6ZW50OG5vVnNvc1RDUkZzQ2EwejlQSCtkWFNSd0Nl?=
 =?utf-8?B?dHlBbjhpVUMyNVpnZUtHUGtKczlMdkRrVFJUYW83Ri9QK3o4djFXcytud2kv?=
 =?utf-8?B?MXRVWlp0RE04ZEk5RzBDODlMZ2plUEx5b0wya0Fnbmc3Q045clJNOEhHVDZW?=
 =?utf-8?B?RHIxbUxybVZCYWY1eHBzK1pxUlpSYmVNQnZFMXVXb0pzSDMraFhGR09zT0Nu?=
 =?utf-8?B?Z1dHa24xL3hFQXdUZmdnaC9ZTS9Qb3ZvVlcxT1ZiVURQK0RUb2VJVXVveWhk?=
 =?utf-8?B?NWJLNzdrMWVFN3kyNFRuZTNreC8vOE40UytVaFBkS2FWQVZOZmdIVnhFalU1?=
 =?utf-8?B?RHcweUpoUjhYb2U5ZDQxVGN4clNsNjVjR1prL3JCWForUFE3bHh0MW0yVlRF?=
 =?utf-8?B?WXY2K0xuVHRFN1RTZWJ3OTFBdStObG5yMk1lMTJIWmxDVkc5TGRwM1k2RW9y?=
 =?utf-8?B?Q2E4ZFB3SjduZHk3MkdBZENSQzNLWFhOOE15TktYWVZnM20rT3drSzNHN0JR?=
 =?utf-8?B?dGNCaXFYeUx4aVR3MGF1SXhDdWNaNms4YTFsZkRHU0lqSm9WeXdhVWpyVlVS?=
 =?utf-8?B?V3RudmV2VXIwb3J1aS92NXUranVjSWlOKytaR2pTSHNlNnIxL0N2c0d2OEwr?=
 =?utf-8?B?MGNQeDQ4Nmw1YVBRZ2NOTUQ3ek9iWnZ2RjZZbkh2U3JLMXFEZVVjb0FPOHNP?=
 =?utf-8?Q?CfiwBkjdOk8rUtHDWI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f7a446-8aec-401f-332d-08dde210a6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 06:45:30.5158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1117

SSBvZnRlbiB1c2UgJ2dpdCBjb21taXQgc29tZS1maWxlIC1tICdzb21lIG1lc3NhZ2UnIiB0byBx
dWlja2x5IG1ha2UgYSBjb21taXQsIGJ1dCB0aGlzIGlzIGFubm95aW5nIGFzIGl0IGRvZXNuJ3Qg
d29yayBpZiBzb21lLWZpbGUgaXMgdW50cmFja2VkLCB5b3UgZmlyc3QgaGF2ZSB0byBkbyAnZ2l0
IGFkZCBzb21lLWZpbGUnLgpJdCB3b3VsZCBhbHNvIGJlIG5pY2UgdG8gZG8gdGhpcyB3aXRoIHRo
ZSBgLWFgIG9wdGlvbiBhcyB3ZWxsLgpJcyB0aGVyZSBhbnkgcmVhc29uIHdoeSBnaXQgZG9lcyBu
b3QgbGV0IHlvdSBkbyB0aGlzPwpXb3VsZCBwZW9wbGUgYmUgb3BlbiB0byBtZSBtYWtpbmcgYSBw
YXRjaCB0aGF0IGFkcyB0aGlzPyBXb3VsZCBpdCBuZWVkIHRvIGJlIGJlaGluZCBhbiBvcHRpb24g
Zm9yIGJhY2t3YXJkcy1jb21wYXRpYmlsaXR5PwoK4oCUIElzYWFjIE9zY2FyIEdhcmlhbm/igIsK
Cgo=
