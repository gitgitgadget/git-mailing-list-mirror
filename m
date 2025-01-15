Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DF1EBFE8
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929411; cv=fail; b=LnoBQLgGPyfqD02IBe6UyOaOf2tbqgEneJCEAyjfHRpxUX/SMv/mrAWZh3V0kL4MfugVbWLg7ZkkTWe/sZ4GsTcfVnRtnltgs3TAXVg+OIcX2b8q8SyQrxu3oge6gC/S0c9Q9rtsuLIchHRSvjczwPbzC5cNM462aEzBT4Up2z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929411; c=relaxed/simple;
	bh=Cw970Yh/iquMrtEbfmDcOvXkvXIgrXKygRk8fh//b+s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JSjHldqU6glV+B5UXmMsiVXqbE35FKFHPU3MrcrRai9fh+AuneYQ5103bJB/ue5XIlS9/QPe1dY8tFJEBUT0iEp/2cwXloUh985mUrl6p8n5QlVYjBNAmQemki7kKqsE19wM/FNoayaR0afpnaDsHLctp+UIilrk8MZ9sekWwQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=vastaitech.com; spf=pass smtp.mailfrom=vastaitech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=vastaitech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastaitech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjVXjAAzMpF4l0+fRrz0RnUSPN2JPKF0TpZ/8tW+yN6yd6TqBG8+AJKS+QOVAtFZ+2oKmrxPpVXx33AdWkxMc6HELrTgQm6i/xfsHIDnL3l96dtDbU60VqgfevPnMXI4WUacaOqYE469igK5zo0Um1peBWBpxMAOlVKMqoyqhOArzLYeIw3hKMmH+B+D8HfnyF8n12xXBug6geOjkWI3bDZOAYAhW5/gNEnL/KnJZWlhjc4zXypW2IurHHhVpATxPLPaRFToW0dfSPW5MchQSOGnNHdyUzQAQNc+jaGe/l/Dcl3zDvtquWnSM58lfjKBYXfyzJ3NTDm6Lg5vBYYXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw970Yh/iquMrtEbfmDcOvXkvXIgrXKygRk8fh//b+s=;
 b=djeG93AbCKAfH3go8+2rZC4EsKwJJQXP259s7pnLxRrV4lNMoyGQ1Y6SCyZoO9jWAo6D4QouPUNeAN/4gejYjEPf14XB/lQMOhyG2EAyYjKBAOZjtu3Oa6s9leYhnPBlbRQvl4ZIaSEpsQ0hT1+42IgEZRw8fxllMqYawCJUMf6+aQVSMzvK3FSgS7KqYMQILgSDXyVjuGputylnb0Yx3FD9ym6xwVhoAWHGgfGsI7gOk+G1Y8B+/PrEfga+LQ2vvojN6bxJKhA9oYMZgldHfc0uf9tIy9xceaj2uvNO8WhQs2u88Nz+nd7ZsFESI+ltSEE1+UUywfgJfCC7OrcwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vastaitech.com; dmarc=pass action=none
 header.from=vastaitech.com; dkim=pass header.d=vastaitech.com; arc=none
Received: from NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::6) by NTZPR01MB0972.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Wed, 15 Jan
 2025 08:07:30 +0000
Received: from NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn
 ([fe80::8127:f68c:b055:d103]) by
 NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn ([fe80::8127:f68c:b055:d103%4])
 with mapi id 15.20.8335.011; Wed, 15 Jan 2025 08:07:30 +0000
From: =?gb2312?B?R2luZ2VyIEx1byDC3r2t?= <jiang.luo@vastaitech.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: large repository clone failure in git for windows
Thread-Topic: large repository clone failure in git for windows
Thread-Index: AdtnJIKuQ38RkYJ1QZS8qWFnOriwNA==
Date: Wed, 15 Jan 2025 08:07:30 +0000
Message-ID:
 <NTZPR01MB11138218E5A5F2EB6AD848518419A@NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vastaitech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB1113:EE_|NTZPR01MB0972:EE_
x-ms-office365-filtering-correlation-id: 9c296fb4-cbd2-4ff6-6c39-08dd353ba872
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|38070700018;
x-microsoft-antispam-message-info:
 LVQrhlJ+6cvbb3pWkFMpntz4mtMwkUD6qZCACY2uPQASVwpYuvv7FOWJ5YRaKwxo+911P5FOdkBc5Bzk8Y//FXR6AX+1shYXNKq0b9zYB7G8D8KfD+BHwqLOSaDH45V0Rl9JlBT94aThYcTMH67pQ79nSkClCU6ALDvnjKwSGQTe3tHw8I0TQiIewTgn8d3O97Uw5RKe20XqI34C4LGcEcSN85mqMkOf375ejKarwecBj0uEGtdqovRG07HRHVXdx+suHo/T3lv83opz2ZgE3rDc37SN4YdqQYL9hk0xk6Si2BdxOHIJA2XDSFyfAoKiuqxiNJ6D0tDdiNgTNMIyZruvGFZhdRFH0Ap3GFFHUZFHR+r/QMiYkg64uNMw7IbEGaHgopHhQF2cyB0KwigD7gESHg4I5jyfmRgjYFVPchmFaLKjajS9roAgCdIsXCp8VQYcJiva8rjZYgEvjSMgK+z200x3MCQ+kERBJrMjFkTeYQBbXv/1GeRTUcoW4el1RNRC8SDR+nYtlobFY+25Z1K+IvwmhLtpzNyfLDdqPsr5fqfAYQRHbMwoZIeJSFQrF2O+GW6vRLmvaitRb+5p3DwNoY4M69vlospCwCR43WQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QXV2eS8rM1VGb2JPNG55MUJmeFFycGlrblZBL05NcFo2TVpMbGh3eERNbzVw?=
 =?gb2312?B?elh2OGRJdmVqYzhyK2N4M2M2VlJiZEI0d3pWMWxBcUYySnRuNzZFVlJKRHBz?=
 =?gb2312?B?ZWNEcjZ3Y2VNMkEzbWVpZy9rVDlxdzlvMk05L2xJMDUyZDRMVDYxcXNuUjFP?=
 =?gb2312?B?L0t1VXRrOC93cktQV1dMaFd6MkVla0FlUFQwejZkVGdPVDQ0eUtKWjhHTElV?=
 =?gb2312?B?NXNXT0x0NzRQSzVEbVlTN3BFZXZDYjBDZEpjZ3l1NFpQTGhNSTBhSm0zT3k5?=
 =?gb2312?B?Ti9rTFViRDJVVTB5ZjU1R3djTUEydlRic3NUWTE3ZDJ4M3k2VWFxMGdwZkZV?=
 =?gb2312?B?Z0hXdmk0YkVITVRicWsvcmcrbnB6cHFyMnppSklRaWhqb3ZwSXh3SWFWVG5U?=
 =?gb2312?B?NHVIRkw3OGg4MTFlaklBWFEwcWtyQWVCcHpVMzdCblNKVTZRN2EzK2hGbTM1?=
 =?gb2312?B?Z2o5MjlJWVdhNG4rWmovdWIzaXY5Y0pCZSt3SHVPSkwzanRvRzFVdVUxSDlF?=
 =?gb2312?B?K2h5bHlNMVc4MHhKa2xZUlArL09namdXODRsM1hSOHhNLy9wcEpLcnBWUlBE?=
 =?gb2312?B?MW1qTE1iNERKY2dId0xPOFZwdTVPOVVWWDhBOFo1MmszV0x4elB6cDl5RTY4?=
 =?gb2312?B?YUVVMDlHeUp4azEzYXZtMjdSUE93TCswK0tnTDNmQmhMS3BCTDFOTWlESmxG?=
 =?gb2312?B?U3JtSFdVaklDUDZtYzZqNVFrZHRnUlZEZ2ZyWnBhRmhobjVVallVdkhPM3V3?=
 =?gb2312?B?VERHM25JSjZCeENBRU53aENVYU91K0RqRXVqRzlyL0FUVjNzb28zMEhuR05N?=
 =?gb2312?B?MmtwOXZSaHJHTGl2Mk5icGFabExSU0lsbzlEekM3RFJWL0V0QldzZ1ZkMlFo?=
 =?gb2312?B?YkdZN3gwTmhoT2RvRnE0Mm5wMVoxY1R4b2c5OGlxem5BdjJnZFpUUTRqaXB6?=
 =?gb2312?B?eFBkNjNOeFU0UVA2TzRKOWI3MURKaTFvRFhWZ3RrUFR5STNJUjVNTXpkYkI3?=
 =?gb2312?B?ZzZNTG5xcnhuSUl1bXcreGZZUFhvMDgyaVMzSWcrYXNiL2FhMHlaUm5ic2Y0?=
 =?gb2312?B?UllRcjhrMHR2VnVkU2oyYzZQVGJUdThoMVRLZmgvOXhaL3hhZW1kRVZCUXdK?=
 =?gb2312?B?UExoSFVOT3lObklJU1JtclViZDVJaGRXemc4UTIzVlJCdWFzY0lnVUpma2U0?=
 =?gb2312?B?SVhmdVhGNkVGVUNVVG5Na09ZRi9MU041L3A3S1JnbXZNeUwzZU5QK0VVZlFn?=
 =?gb2312?B?UDE5STdjRXd6NENBK3FuU0NhZWFaUG15V0ZXSjNPLzkyQjVYYkUwTDRZYlpn?=
 =?gb2312?B?WS9CNnRxenZ6cDdxdU5NRnZTczBpUmRsbzRNR1NQUFpRTEJWQ3VveklSQ0dC?=
 =?gb2312?B?Y2lxYXFPT1pIdmxNYmgzYVZ6UkY0dHpwd0xtVVUySU84K0dvZTZaRmpkRnQ3?=
 =?gb2312?B?MTZURHQ1WjN5SFF5M01MVEZ5czdEL3NvY1F0dmVtUnFsRExEVWs4NU95ZUZ4?=
 =?gb2312?B?ZVorTlM4WlBoNHJnQ2ltcHFrYnhqV3JENUlTSUZuU05GODBOZEd6SGhxQnlo?=
 =?gb2312?B?dWxQTitBUmVUK0psUm5FUUJxdTEzRFM3NWp5dlJoOUl3UEcySVdycUloazBY?=
 =?gb2312?B?alIxeFZ2d1BMQjlJYzJYellDY3BlYkVnOWhmeFp0bTEwZ1JaQVZLY01heCti?=
 =?gb2312?B?K3JBZkNabFRwQjBqaDlWTExFR3Jsck1xRmdxZE0zS1VvaENFTTc5eDRNVXph?=
 =?gb2312?B?WDhWSjFlNU5DMWJpUEVmQi9UTHcwQTlJT1FGODFYcFNzU0pLL3B5a0JxN0VJ?=
 =?gb2312?B?T2RUUU1LTTBtV0JXNjFmT0tjLzBGcWF4dVRwSXZmVjMxTkdsR0xJNUtFMU1U?=
 =?gb2312?B?SnprSkRpTjdyZmZPWmZaR1Rjb21sa3Q0Zitmc3ZvMHFwQ1ZlQzN6dXhlMEFn?=
 =?gb2312?B?ak43VFJJMnE4RlF2bHlyUVhJa2tHbGUxSTNJaGF2RmE5ZnF5eVNnYU5Nb1hB?=
 =?gb2312?B?cTYrUWJ0UFVMeW8wNWRaUUE3N3pNQUEzQUZRMVRZWFp4eWtuVmRoUTMwZGFC?=
 =?gb2312?B?NlV6NHl2RmUzbnBtazNOb1BZbTdoQTVwaG01d0hSdUNzdXRIMURKZmZ2VEx3?=
 =?gb2312?Q?xsmVT74EdvocCmePSLFPwVXTd?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vastaitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c296fb4-cbd2-4ff6-6c39-08dd353ba872
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 08:07:30.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 814242ee-9aa7-47aa-8534-66d29e8050c2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUT/PICkmdMKCo1suVkuHgnMTn2HSqYVAOGXMefyf6tvDO5SLJMLJvfFmN7wJFBdraRb0oa8tcHs066saBNxVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0972

SGVsbG8sIEdJVCBndXJ1cw0KDQpJIGhhdmUgYSBsYXJnZSByZXBvc2l0b3J5IHdoaWNoIGlzIG1v
cmUgdGhhbiAzMEdCLCB3aGVuIEkgY2xvbmUgaXQgd2l0aCBnaXQtZm9yLXdpbmRvd3MgKHRyaWVk
IDIuNDcuMSBhbmQgc29tZSBvbGQgdmVyc2lvbnMpLCBpdCBwcm9tcHRlZCBtZSB3aXRoICJmYXRh
bDogcGFjayBoYXMgYmFkIG9iamVjdCBhdCBvZmZzZXQgeHh4eHg6IGluZmxhdGUgcmV0dXJuZWQg
MSIsIHVzdWFsbHkgZGllZCBhdCAicmVjZWl2aW5nIG9iamVjdHMiIHN0YWdlIGF0IGFib3V0IDRH
aUIuDQpMb29rcyBsaWtlIGl0J3Mgc2FtZSBpc3N1ZSBpbiBodHRwczovL2dpdGh1Yi5jb20vZ2l0
LWZvci13aW5kb3dzL2dpdC9wdWxsLzIxNzkgOw0KU2VlbXMgbGlrZSBpdCdzIGEgImxvbmciIHZl
cnN1cyAic2l6ZV90IiBwcm9ibGVtIGFuZCBzaG91bGQgYmUgZml4ZWQgbG9uZyBhZ28sIGJ1dCB3
aHkgaXQncyBzdGlsbCB0aGVyZT8gSSB3YXMgdXNpbmcgNjRiaXQgZ2l0IGFuZCA2NGJpdCB3aW5k
b3dzIHNlcnZlcjsNCg0KVGhhbmtzISENCkcNCg==
