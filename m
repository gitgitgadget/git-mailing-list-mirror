Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=193.56.114.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795449411;
	b=pY0suAO+hlq8tKGBvHKGYzI3QEHYMxkVNhlSSWQLLAsFn6SO1hwEA7cTh+iYLcVChjKr
	 +y/80675R8hxvefNNL+Dmkw+W8uPsF67JgyUzn/MFnrJYdBUflTV4wMxZLV401VEb5DA/
	 syjWyuSM9pdKEXOA50HuqGGEY6op76jaGNDwYYHhI9NwmLnFN2jGh8VsOxF5iI7CcZFbO
	 R/MV2zO0yxmyGCOjuQ9OiTk/SeUqMjlohJYgajKHaUtxpTEBkbL+oAMV165GJqQXFRHSG
	 ke3Ut0geBYU5N2Ps6TNnbGsfqHPIoKBQewSKF1528dshPs33+AHRa5sNbYztzWSVwyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449411;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-MGA-submission:Received:DKIM-Signature:Received:
	 Received:From:To:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QMvSaB6BY1EI7AwWAhioiqEg7V6DQdxmx8S4jB0nhWI=;
	b=Agxi26y0SDrERmqqnwoC9YLE5ZcORCM/MeXoBLQtzacZB0Her/grO0W9AkUHZQzepWlZ
	 8PKNSjAZVG4x8W92W608C8jsMG7qQ/USDdy3bxf6LcCxA01DkD0GE+PdcLT7Jip4rf/Tq
	 NdDsa0Lq3j77xE/O3jdigSCBogF/ZHM7veG17FDLQynxaxuWcRi9icmasbB/X4xcb185p
	 7umygomAgrw3kf1Z8FzVh7TcbdeDd+PdkcRoaW1ccaul78QCWiQ9gV8K3DbaWg2rfXXoN
	 eclQOuZSCcmI+xW7lRgfuqJ8lk3xl0k4dgajiFKoZhp2hSMJpF3YE53fVjt6d7LAyLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=atos.ai;
	spf=pass smtp.mailfrom=atos.ai;
	dkim=pass header.d=atos.ai header.i=@atos.ai header.a=rsa-sha256 header.s=mail header.b="cY/JuMtZ";
	dkim=pass header.d=Atos.ai header.i=@Atos.ai header.a=rsa-sha256 header.s=selector1 header.b=IrgXgq8L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=193.56.114.176
Received: from smarthost3.atos.net (smtppost.atos.net [193.56.114.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11753606A332
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11753606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atos.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atos.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=atos.ai header.i=@atos.ai header.a=rsa-sha256 header.s=mail header.b=cY/JuMtZ;
	dkim=pass (2048-bit key, unprotected) header.d=Atos.ai header.i=@Atos.ai header.a=rsa-sha256 header.s=selector1 header.b=IrgXgq8L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.ai; i=@atos.ai; q=dns/txt; s=mail;
  t=1795449409; x=1826985409;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QMvSaB6BY1EI7AwWAhioiqEg7V6DQdxmx8S4jB0nhWI=;
  b=cY/JuMtZcmNur8NI2wfBG+gHGp7UCc2RwvjN5ONjP6BqI4wWGPm7cRw9
   SVYZAAXcLo375i7EERFDpvLeeWZXCjKVc9oxv526elrMv+VCw5wBG6ntx
   CZclqPbEfUCbeX1orcf+DPtxhz10BoQuaQuay4W1FVWwQWRqrpqlZoqxk
   Tw7IR1mx2lWix2+ZdMZRQ3O1WgnGzvwVqA/Oa3TJ67P1cP82Eyci1wXjA
   NI3NwGDMJSUrKeCzfaD9l4XoLzC1p/vBMfCR8CvvVAUwlerVIiIWgcqA5
   6s0/TGxr0oJxXtEgtFyqsI+t7ezD8CVT7i0Ztb+D0AQnnDHByIjyVR3s+
   A==;
X-CSE-ConnectionGUID: UpQZ4Rd5TTOMZS6M1KJMRA==
X-CSE-MsgGUID: mlc4RXKdQ3Ci0CzPejOvmw==
X-IronPort-AV: E=Sophos;i="6.27,229,1787004000"; 
   d="scan'208";a="882922293"
X-MGA-submission: =?us-ascii?q?MDEpkuEKQR0Ups9SFnWwz77FKWk0D5bRkgD8k/?=
 =?us-ascii?q?V5rnsOfbhhfNr01dGzQbIuKQbQUXLF3btCXcBXcnFnHpM3eS1dA3Spy/?=
 =?us-ascii?q?2PPIkfw5Y9FEno7Er/tm3elFnYee/pp0hF6qu95lq9NUPYt1faL0pJhH?=
 =?us-ascii?q?s9?=
Received: from mail-gv1pr07cu00100.outbound.protection.outlook.com (HELO GV1PR07CU001.outbound.protection.outlook.com) ([40.93.214.96])
  by smarthost3.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Nov 2026 16:56:41 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWb+nL4kNEiOOc5YVVPxogwPhI/mHFBypqP/TqnQf8im5DWeY9uI4jjcgylV5ffMAfql08cKXRG1BQvJSQ2QbiklTjhdcGNJ+3Mn+ADiPIe/G5Fk1k/V4KojK1atdeQ8LthVRrDK0QaY0ZtLf89Af541+ivzsKNyy9fco4HTOYr4MZU3iaAVmGPPDP3mu8q61YHlo8t+0nYnjefhZ+7nqfwr17xxOZIuS663rcID1RYi2KMvSx9rxnZVqIhUlD4HutfJYKG7emUS6qSXWbDdkG3s+/lqf6mCX84WhBTOEYc3Jqvgcxe4LcTdiy4K9rpX7pB90uPSn53ibDd5mirsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMvSaB6BY1EI7AwWAhioiqEg7V6DQdxmx8S4jB0nhWI=;
 b=elRk3R4IU8w4KriO14OrpTYJQduYG5HaJx+XMCvRnEwtVQLIjajPUd28Q4EcC8foDkfCp9lQwKC9BK62KlJODtaBDLyI4LZvruYPlC/Zn9GEP2cfWmpfiF4j6pgHNME1xkCZTfLwHUq7qq/UwxIwykpKPZnhg1QGfN864j8V4MgoYtsLK5nsq2VvdJY8Zgqvmr7Q97Xt7+gxYh7oZL7/UdpsCG11MUILFeUvEtNqOCwTxsxR79XGDkQCg6Y7gFIb3kOgr0dNYVa52WF9MFNBrSOOApQHvGWVolYmZ7peoWyozePVA826I4Aqi+nwkmShobfbBZWFLniRIlDUI947UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.ai; dmarc=pass action=none header.from=atos.ai; dkim=pass
 header.d=atos.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Atos.ai; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMvSaB6BY1EI7AwWAhioiqEg7V6DQdxmx8S4jB0nhWI=;
 b=IrgXgq8LnWouT95N2ncpMtvVKD9bPSyBMcpNbU871SvCjD4sqmI1keXDxED/0ZSlSUtcgreQM+ttpxRGPU06e1/8PTZ/SjwTueBAuPTZ6A2pFVPTNJ7NVoYeo4RCINRvuOH3BWyk2p3BWCwQ+pWC3Zh235lJ+Ue5vIMzrQLPiU/QLKAf60gmJYkW9jHUf46GHeqDdLHPWMpqNeKrdl7GSIHXw6Q20SeDVfmXP3vjZwZ/JCxPpoUEsKZMj/65XwXKFaRWmuf9j7gUhmJhGzLcK6nRr1hPXjPUsFHuQfhZcMrF6XaBE02E1WIOQLlQ/ZH1eBsB4Zv/CVgGy7DjLcu5Ow==
Received: from AS4PR02MB8336.eurprd02.prod.outlook.com (2603:10a6:20b:517::6)
 by AM7PR02MB5864.eurprd02.prod.outlook.com (2603:10a6:20b:109::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 15:56:36 +0000
Received: from AS4PR02MB8336.eurprd02.prod.outlook.com
 ([fe80::b6b2:4b44:41b3:f6ef]) by AS4PR02MB8336.eurprd02.prod.outlook.com
 ([fe80::b6b2:4b44:41b3:f6ef%5]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 15:56:36 +0000
From: Richard Kerry <richard.kerry@atos.ai>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] doc: update-index: Format options correctly
Thread-Topic: [PATCH] doc: update-index: Format options correctly
Thread-Index: AQHdepXBCSI+IW55P0iWCctqWkUQ/Lc6iHFzgAFCCwCAAAYpoA==
Date: Mon, 23 Nov 2026 15:56:36 +0000
Message-ID:
 <AS4PR02MB8336DCFEB4C0076DCE45F950EB452@AS4PR02MB8336.eurprd02.prod.outlook.com>
References: <20261122152538.107580-1-omri.sarig13@gmail.com>
 <xmqqfqwsk4a6.fsf@gitster.g> <6954cd53-43c8-48ca-82da-35c673dee260@gmail.com>
In-Reply-To: <6954cd53-43c8-48ca-82da-35c673dee260@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=1b748818-1d5e-41ec-bd03-1e345d75b858;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All
 Employees_2;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2026-11-23T15:54:22Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atos.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR02MB8336:EE_|AM7PR02MB5864:EE_
x-ms-office365-filtering-correlation-id: 4ebf723f-3ba4-4a42-2135-08df497a5a94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|261009223027099003|4143699003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|261022115727099003|261022075727099003|261022105027099003|261021135927099003|261021121427099003|261021123027099003|261022113327099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 +9Ndj/BxqTpHd0jww+j62/XbVW4j9wwdTHB6ig4Bg9SE8H7gf26Ygp77eLhpaeH1lawISn7jz/rNUGacroBPJUBk+aOj1ZtdxvbefzKAi2W+N48xOTy46cy+rqz6eyhJUUNeJFevkx8NIRl1HOI0mrW8BrrRz7/coxtusLY7ufSmbJr1p3O1AX1awKd7s7LoxBkfdKCGtr00gTJklVWa1hzBNlRvy6abZ+xJ9Xjoj06N+KX1hBMgJXGvz603W9WAXB1g0s/hAtbhR7FQnQvfg4NmpyDVK5Pe4Icfs0846FPDrPmrQ8/OAZBLocfKzeDEdhbKUCZWVmIu8Fj5xQv5bXc3cCGI5qhfrja4HZ0Z73QdADmgJADhY6DdfDUPrHSDasw6Ymvc0IGCUXEeN9Js9u1M+MR9UXcxi5xI8xUkiW/wnVSUeYufbCCFhJnXFXrpy/QxzlQXnVa/vtXpit4petHj7oUmuRt/jk1xxfSD/ul8bXvF93xP1Wc9GG+yUU0UYRmjgI/mgvOgK8wzKtFD24xKxDsrp4nXFx185WxY7mP3BHjp27DgWfmyDo2kj5fJohoUanQXsrJDNc+/WT0XeMz1D2lrte09sw+fqNVnMzaDwGmhCiWfHYun61ovGEQcIJBXhO+NVLkve+9j0mnNeVaiZFrLPqoHF1hzK2YCkZiuyOV4GjJuzKYKkRg54GWaiKCcxICg7rMGCq4sGL8Kd4lcy+8vz1JD7/FdM/D/kAY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB8336.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(261009223027099003)(4143699003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(261022115727099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022113327099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVBFbGozdDQzVy8rdzd0cklJRUhJMFVhLzBKTDJjUlNKOUkwendTM2g1Z2JD?=
 =?utf-8?B?dGhEd0RCc2FtajdmU3BLTWhXckRDR3I0Q0k3dnE5QjhqNHptaC9aeGZiUldp?=
 =?utf-8?B?bk5ZZStzTDhHNzBYa0ViK295QmRPTzRmc0d4a0pTM1A0aElFWDl3eFJEbW5x?=
 =?utf-8?B?QmYwTnVualBETURXaTdaQ2RPQ2lNeVh4bzhEbjgvMGdvbzNrTWpBcUVLZW0z?=
 =?utf-8?B?ZG4yb3VaMUx5TjV2VVhacy9mMWlzQWhwQkhMOFg2TjFzdTRjSWZQVzRWdXpO?=
 =?utf-8?B?d2hBMlQ0bjQyNzd5WkE2SGVvaHBueU1yRmczV1JWSUlEQVVNb29Sd05YSGlz?=
 =?utf-8?B?aUMwZTMveHZkcWsvTEUxT2dPOUZmbzgwVlN3eW5XS3BrM3lMYVBoVjhkN1Yy?=
 =?utf-8?B?YUZ1RXBzL01DUXNuWVczU0RmN1hWSGtIdjBmbURYdndaNHI3bFpJemh1ODRY?=
 =?utf-8?B?eG1YVnd3NUZ0UnI5Y2ZpSGd3RWQxWGdkYmVaZEhkaTRoN2ZnZEhZZDl0elFa?=
 =?utf-8?B?aGdvbzhhcmwxS0FXVWxnamd4bHJ0OGNHT1c4QkZwOUY0Q25EOFA2R3Fubms2?=
 =?utf-8?B?WnltR08rdC9iTlN0VDJoZkFDdXA4OEkrY1FtOXB1SHhFaXVEUXV4RC9LVGVk?=
 =?utf-8?B?QmVIWUNhdVJ6NHRKaXVMUzRSUGg5WWJkWGF1cUhSYm1LeHB2bkxpcjYxeWo0?=
 =?utf-8?B?eWs5RTFybndJMU95L1BLVGRTZ2twcndvRDByeEJzSHBIcE15S0pDL2dJTHQz?=
 =?utf-8?B?MnREUHBIVC9hanQ5Y09LWkMvUVBwWHlSZjBKWlpPaGpLMmQ0WHQ0KzVQRTFn?=
 =?utf-8?B?eUFWM0lqeXEzbUFqNWdER1I1R2k3TnBMcVJWb29KamF6cjMzTnBsaFBuK2RH?=
 =?utf-8?B?aTJQQUhqV3BEdkxXcS9uU1BTeHovWFhXTFRURGY1U2NlTnVjZ2Jyd085azQv?=
 =?utf-8?B?V3NGVHVuanBQZTVadUxzM3poNm45MmxiTVkzMTRIbkI1a05zOEFoNTY5TFdx?=
 =?utf-8?B?VWRON00yTTRHYm9KMHdRNDlaNVRqT3VmMjB2RzF2QUcxblBQY2JJdjQreUJB?=
 =?utf-8?B?MHpsVVdadGtFWG5BTGtrQmYyN0EyM0hyYnZIVlR5UitWVExTWWNXcGlCbElH?=
 =?utf-8?B?MUgzVGNKSGFRd3ZsNDBMOUZJODVrZ0dNR0hTRzNiQVF4NTRibTVFVHBzODZs?=
 =?utf-8?B?SjZkMEZqMkdnc1BNMExzVWgvTGdyTERTZW94QWVFMmd6TE9VVElYM2t4NUcy?=
 =?utf-8?B?WS94THowTEQ0OEdTbTV5aTVHYXZWMHMxZEdVMlBiNTRyT1R4alB6ZUtiNGJS?=
 =?utf-8?B?TFp0eXQrT1FzS0dJMG9QYVA0ZGpZU3VlS0tua2gveTRxWklXcitTMkNFcGRr?=
 =?utf-8?B?RTZ6cEtWQitJSzAxWkg5OHg0b1hxMEt3WUp4aDI0NXJVYUVTdWVzZDc2ejAv?=
 =?utf-8?B?ajRleUZaZUF6QjVyeWRUbDcrd2hDZFBKbDJyck5NSkQ0dm5nNkp0M2NweHF2?=
 =?utf-8?B?ZnRrQ3FHcEpaalllU2RSREUwZEwrN0I0RnhaTlBIVnVqeno4YllSRmZ2RG1r?=
 =?utf-8?B?SVNVSzJUNXN4OThFM2hoUmg2bmZvMEpSWnRUeElxdVhSN2tZVVNvdzArZSt3?=
 =?utf-8?B?SHhhZEM2aVZIdFJvbDNuTGhOTW5lQTVjMENiV2FBcmk1MmhQNG1HWUZmRElF?=
 =?utf-8?B?NWNlMGs1UlJ0NWtYVGZWdlRqTUlobzdhMlRIZkNnSkZBcWI5WkRCTk1UcEpF?=
 =?utf-8?B?eUZraGJFa0h5MWxPQVBiRnpEVmdFQk5Lc3p5d2w5QVRUOXd4ZnYzanhvd21N?=
 =?utf-8?B?eWdvdHhPMkdPU0dCbkNrYWplYTB0QlBYcnIvMGkrSEFHYW1JUVlNYlFLL2ZD?=
 =?utf-8?B?U043NXUyaU1SOG1jTCs4eVRpVmRleURQU0dwU2lKeDVGNWYxc1UxMHNlZDFX?=
 =?utf-8?B?V1J2b3dzWjlwcTJvTWd4WEs4akJLVnVIRXZvWE9rUUNLeTErWU51eS9KSUs2?=
 =?utf-8?B?UFRrT1lJWGhWRW1xL0hPQmtjN2lOREJRYjJHTnlJNGpnMGdnNmx2Y2JxT1pG?=
 =?utf-8?B?Q3Q5TzJmZTZMUW5PdG16K0h6LzdlVHJSNUNnT0QzbGthQVVvWllQaU1vVUQ3?=
 =?utf-8?B?UEJBeUloOVUvckdnSzJwRGRJZmdxUE5TQ0xhQ3diYWZvTzV5UlRxQTdGMnVv?=
 =?utf-8?B?SUFDN1MwbitwczQySnJITnM5T2pXUmdBVC9HTDVHc0JTeUtjVjRWQTVRYXAr?=
 =?utf-8?B?dVEyRDlMUDk5cm5jVkpyMFNXM01RazJ1SmJhNTN2cXlRUzNvazYvS2doeDFI?=
 =?utf-8?B?SVRFUks3Mk9OajJVQlpWZ3F0RWpKb2NBNkM0TWNZTlh2UFBQWnZTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	JobfGLh6QSS87h1vF1GPH/yDnj1HUtVfrR0kmQ3BMjrXq4nFG29IlGASs6O+x3mAVFM5/O+/8B6akp0fEHkqCEjXapXTeWTlwht8kITcDDknbz0z2j9qMe5vxQw/BaojIYDbR8CoVeh13rPlvAsKIw64cYCbTEvJS5k38exPPiFKHZiN6WnLfPqUXl0r6OzQyz6nzZ6FBM2BJoeOpLRJZT2CwWEgMx7Uw6UPB0f7gc6d7+sGv77H5mlCpSYrvYuGFoZO7dOjq0qU4HRD8CrLRIQC/K3lhYAuyZQ8o40qCTslsoY2vXxf2F8ndqW8CndeBFg0keaNQ07aE5BB2EQQgQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0snqy+r1/Aw4V+qA5Jpi5zep7PMe+7GitIVqs3MgtNNN1KQDbZQalC3gCWOUyF25v7CBaXAsuTnOlpqSrTkrqgUTW7bSePESGKmsbF8ZTJ5fVZZTMVPq/b3Nj00V2oRU8A7eQGajRVSaDI3T3NNEmec4geyvmLr2v4RYBbF+yj5gCMhhoYi9XgYVWuq0aNI6/k9fayYRJM4mmSjQkQF1fEjScmQHVt4U/wxgEFqcsE6LqL1WjQklJHpW2QYOpyowJxc4VxYOK/0YQ7tHKPndGgWuBxJYYhi0SAmHGBFWBFDYJMCBOggjQYZK5t0Y/6Zg8Cv5glXy595xi1et62QQOfM08CJbkokyfbJDhTlS+GPAmEKz1OxZx70Mlx7Vj2G1nbxhmy3SXQUC0zkXEDOeC9dbPQ5G4I0hPeKrYJQCoK8Xj4+Lg1gX9myhq3Z3Lrus6sQtibAQWi7v4RmURIYyc4alvgHM2VcIPIZJXXpEC16IBUP4fd84hLj9XdA071EGBqh2Z7R9UbDhyD1+/z6t0i+dyDYA3ndsiNOmGcX/rhAcZTpRPCfcK7eXTGGd0NCKSGduf3I6HIM+WJoULXFS65SPqv7lZtjJiPiuiaBdyW2ZPLXTfp7Ui87ojUyAU3bEl6K3Pdpib76ZP1UU+y6ID8+xGHx0kTaSXXu8Qo/BLUYcfqgVfiM+t5fwhUL+zMC4
X-OriginatorOrg: Atos.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB8336.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebf723f-3ba4-4a42-2135-08df497a5a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 15:56:36.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjauwLyOkX9pjtn5TYbg6JSnZ/fLgqZwdznCaTO2hUc0CqrqG45aWIzRqaz6J0SBwqHvxSevoxF2NLMZei+X8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5864

DQpIbW1tbS4uLi4NCg0KV2UndmUganVzdCBoYWQgc29tZSBkaXNjdXNzaW9uIG9uIHRoaXMuDQpT
cG90IHRoZSBsaW5lIHRoYXQgaXNuJ3QgcGFydCBvZiB0aGUgcmVwbHk/DQpBbmQgdGhhdCBpcyBu
b3Qgc3Vycm91bmRlZCBieSBibGFua3MuDQpTbyBpcyBub3QgdmlzaWJsZS4NCg0KPiBObywgSSBh
bSBub3Qgc3VnZ2VzdGluZyAidGFsa2VkIGFib3V0IiBpcyBiZXR0ZXIuICAiaGFzIHJlZmVyZW5j
ZXMgdG8iDQo+IChvciAicmVmZXJzIHRvIikgaXMgcGVyZmVjdGx5IGZpbmUgb25jZSBpdCBpcyB3
cml0dGVuIGluIHRoZSBwcmVzZW50DQo+IHRlbnNlLCBhcyB0aGUgZWFybHkgcGFydCBvZiBhIHBy
b3Bvc2VkIGxvZyBtZXNzYWdlIGlzIHN1cHBvc2VkIHRvIGdpdmUNCj4gYW4gb2JzZXJ2YXRpb24g
b2YgdGhlIGN1cnJlbnQgc3RhdGUuDQpVbmRlcnN0b29kLCBJJ2xsIHVwZGF0ZS4NCj4+IG1pc3Np
bmcgdGhlIHJlbGV2YW50IG1hcmtlcnMsIGNhdXNpbmcgdGhlbSB0byBiZSBmb3JtYXR0ZWQgYXMg
dGV4dA0KPj4gaW5zdGVhZCBvZiBhcyByZWZlcmVuY2VzLg0KPiBCdXQgdGhlbiAiYXMgdGV4dCBp
bnN0ZWFkIG9mIGFzIHJlZmVyZW5jZXMiIHNvbWV3aGF0IG1pc3NlcyB0aGUgbWFyay4NCg0KS2lu
ZCByZWdhcmRzLA0KDQpSaWNoYXJkIEtlcnJ5DQpCTkNTIEVuZ2luZWVyIOKAkyBNZWRpYSBDb21w
ZXRlbmN5IENlbnRyZQ0KTWlkQ2l0eSBQbGFjZSwgNzEgSGlnaCBIb2xib3JuIOKAkyBMb25kb24g
V0MxViA2RUEg4oCTIFVLDQphdG9zLmFpDQoNCg0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBPbXJpIFNhcmlnIDxvbXJpLnNhcmlnMTNAZ21haWwuY29tPg0KPiBT
ZW50OiAyMyBOb3ZlbWJlciAyMDI2IDE1OjMyDQo+IFRvOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+DQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRvYzogdXBkYXRlLWluZGV4OiBGb3JtYXQgb3B0aW9ucyBjb3JyZWN0bHkNCj4NCj4g
Q2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNr
IGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbA0KPiBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFu
ZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyMi8xMS8yMDI2IDIx
LjE5LCBKdW5pbyBDIEhhbWFubyB3cm90ZToNCj4gPiBPbXJpIFNhcmlnIDxvbXJpLnNhcmlnMTNA
Z21haWwuY29tPiB3cml0ZXM6DQo+ID4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZG9jOiB1
cGRhdGUtaW5kZXg6IEZvcm1hdCBvcHRpb25zIGNvcnJlY3RseQ0KPiA+IEknZCBkb3duY2FzZSAi
Rm9ybWF0IiAtPiAiZm9ybWF0Ii4NCj4gU29ycnksIHN3aXRjaGluZyBiZXR3ZWVuIGRpZmZlcmVu
dCBjb252ZW50aW9ucyBib3VuZCB0byBnZXQgbWUgY29uZnVzZWQNCj4gc29tZXRpbWVzLg0KPiBJ
J3ZlIGFscmVhZHkgdXBkYXRlZCBpbiBWMiwgYW5kIEknbGwgbWFrZSBzdXJlIGFsbCBmdXR1cmUg
cGF0Y2hzZXRzIGhhdmUgdGhlIGNvcnJlY3QNCj4gY2FzaW5nLg0KPiA+PiBUaGUgdXBkYXRlLWlu
ZGV4IG1hbiBwYWdlIGhhZCByZWZlcmVuY2VzIHRvIHNldmVyYWwgb3B0aW9ucywgd2hpY2gNCj4g
Pj4gd2VyZQ0KPiA+IEkgdGFrZSAiaGFkIHJlZmVyZW5jZSB0byIgdG8gbWVhbiAidGFsa2VkIGFi
b3V0IiBoZXJlLg0KPiA+DQo+ID4gTm8sIEkgYW0gbm90IHN1Z2dlc3RpbmcgInRhbGtlZCBhYm91
dCIgaXMgYmV0dGVyLiAgImhhcyByZWZlcmVuY2VzIHRvIg0KPiA+IChvciAicmVmZXJzIHRvIikg
aXMgcGVyZmVjdGx5IGZpbmUgb25jZSBpdCBpcyB3cml0dGVuIGluIHRoZSBwcmVzZW50DQo+ID4g
dGVuc2UsIGFzIHRoZSBlYXJseSBwYXJ0IG9mIGEgcHJvcG9zZWQgbG9nIG1lc3NhZ2UgaXMgc3Vw
cG9zZWQgdG8gZ2l2ZQ0KPiA+IGFuIG9ic2VydmF0aW9uIG9mIHRoZSBjdXJyZW50IHN0YXRlLg0K
PiBVbmRlcnN0b29kLCBJJ2xsIHVwZGF0ZS4NCj4gPj4gbWlzc2luZyB0aGUgcmVsZXZhbnQgbWFy
a2VycywgY2F1c2luZyB0aGVtIHRvIGJlIGZvcm1hdHRlZCBhcyB0ZXh0DQo+ID4+IGluc3RlYWQg
b2YgYXMgcmVmZXJlbmNlcy4NCj4gPiBCdXQgdGhlbiAiYXMgdGV4dCBpbnN0ZWFkIG9mIGFzIHJl
ZmVyZW5jZXMiIHNvbWV3aGF0IG1pc3NlcyB0aGUgbWFyay4NCj4gPiBUaGVzZSBwYXJ0cyBvZiB0
ZXh0IHN0aWxsIHJlZmVyIHRvIG9wdGlvbiBuYW1lcy4NCj4gPg0KPiA+IFRoZXkgc2hvdWxkIGJl
IHR5cGVzZXQgaW4gYG1vbm9zcGFjZWRgLCB3aGljaCBpcyB0aGUgY29udmVudGlvbiBpbiBvdXIN
Cj4gPiBtYW51YWwgcGFnZXMuICBBbmQgdGhhdCBpcyB0aGUgaXNzdWUgeW91IGFyZSBhZGRyZXNz
aW5nLg0KPiA+DQo+ID4gVGhlc2UgY2hhbmdlcyBkbyBub3QgbWFrZSB0aGluZ3Mgd29yc2UsIGJ1
dCBJJ2QgcHJlZmVyIG5vdCB0byBzZWUgdG9vDQo+ID4gbWFueSBsb3ctcmlzayAmIGxvdy12YWx1
ZSBwYXRjaGVzIHRoYXQgYWRkcmVzcyBvdmVybHkgbmFycm93IGlzc3Vlcy4NCj4gPiBJZiB3ZSBj
b21wYXJlIHRoZSByZXN1bHRpbmcgdGV4dCBhZnRlciB0aGlzIHBhdGNoLCBlLmcuLA0KPiBVbmRl
cnN0b29kLiBNeSB0aG91Z2h0IHByb2Nlc3MgaXMgdGhhdCBieSBpbnRyb2R1Y2luZyB0aGVzZSBz
bWFsbCBjaGFuZ2VzLCB3ZSdyZQ0KPiBhYmxlIHRvIG1ha2Ugc21hbGwgaW1wcm92ZW1lbnRzLCB3
aXRob3V0IHB1dHRpbmcgdG9vIGJpZyBvZiBhIGJ1cmRlbiBvbiB0aGUNCj4gcmV2aWV3IHRpbWUu
DQo+DQo+IEknbSBpbiB0aGUgcHJvY2VzcyBvZiByZWFkaW5nIHRocm91Z2ggbXVjaCBvZiB0aGUg
ZG9jdW1lbnRhdGlvbiwgYW5kIGFsb25nIHRoZQ0KPiB3YXksIEkgdHJ5IHRvIG5vdGUgdGhlc2Ug
c21hbGwgaXNzdWVzIHRoYXQgY2FuIGJlIGZpeGVkIGVhc2lseS4NCj4gV291bGQgeW91IHJhdGhl
ciB0aGF0IGluIHRoZSBmdXR1cmUgSSAxKSBtYWtlIGJpZ2dlciByZS13b3JrcyBhcyBwYXJ0IG9m
IHBhdGNoZXMsDQo+IG9yIDIpIG5vdCBzZW5kIHRoZXNlIHBhdGNoZXMgYWx0b2dldGhlcj8NCj4N
Cj4gSWYgaXQncyBlYXNpZXIsIEknbSBhbHNvIGNvbXBsZXRlbHkgZmluZSB3aXRoIGRyb3BwaW5n
IHRoaXMgcGF0Y2hzZXQuDQo+IEFzIHlvdSB3cm90ZSwgaXQgaXMgYSBsb3ctdmFsdWUgcGF0Y2gu
DQo+ID4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dpdC11cGRhdGUtaW5kZXguYWRvYw0K
PiA+PiBiL0RvY3VtZW50YXRpb24vZ2l0LXVwZGF0ZS1pbmRleC5hZG9jDQo+ID4+IGluZGV4IDli
ZWE5ZmFiOWEuLjliOTU2MjE2ZDIgMTAwNjQ0DQo+ID4+IC0tLSBhL0RvY3VtZW50YXRpb24vZ2l0
LXVwZGF0ZS1pbmRleC5hZG9jDQo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vZ2l0LXVwZGF0ZS1p
bmRleC5hZG9jDQo+ID4+IEBAIC01NywyMSArNTcsMjEgQEAgT1BUSU9OUw0KPiA+PiAgICAgIHVw
ZGF0ZXMgYXJlIG5lZWRlZCBieSBjaGVja2luZyBzdGF0KCkgaW5mb3JtYXRpb24uDQo+ID4+DQo+
ID4+ICAgLXE6Og0KPiA+PiAtICAgICAgICBRdWlldC4gIElmIC0tcmVmcmVzaCBmaW5kcyB0aGF0
IHRoZSBpbmRleCBuZWVkcyBhbiB1cGRhdGUsIHRoZQ0KPiA+PiArICAgICAgICBRdWlldC4gIElm
IGAtLXJlZnJlc2hgIGZpbmRzIHRoYXQgdGhlIGluZGV4IG5lZWRzIGFuIHVwZGF0ZSwNCj4gPj4g
KyB0aGUNCj4gPj4gICAgICAgICAgIGRlZmF1bHQgYmVoYXZpb3IgaXMgdG8gZXJyb3Igb3V0LiAg
VGhpcyBvcHRpb24gbWFrZXMNCj4gPj4gICAgICAnZ2l0IHVwZGF0ZS1pbmRleCcgY29udGludWUg
YW55d2F5Lg0KPiA+IHdpdGggYW5vdGhlciBtYW51YWwgcGFnZSB0aGF0IGhhcyB0aGVzZSBtYXJr
LXVwIGNvcnJlY3RlZCBpbiBKZWFuLU5vw6tsDQo+ID4gQXZpbGEncyBzZXJpZXMgZnJvbSBlYXJs
eSB0aGlzIHllYXIsIGUuZy4sIHdoYXQgZTlhOTllZjJkYQ0KPiA+IChkb2M6IGNvbnZlcnQgZ2l0
LWZvcm1hdC1wYXRjaCBzeW5vcHNpcyBhbmQgb3B0aW9ucyB0byBuZXcgc3R5bGUsDQo+ID4gMjAy
Ni0wNy0yMykgZGlkOg0KPiA+DQo+ID4gICBQcmVwYXJlIGVhY2ggbm9uLW1lcmdlIGNvbW1pdCB3
aXRoIGl0cyAicGF0Y2giIGluDQo+ID4gICBvbmUgIm1lc3NhZ2UiIHBlciBjb21taXQsIGZvcm1h
dHRlZCB0byByZXNlbWJsZSBhIFVOSVggbWFpbGJveC4NCj4gPiAgIFRoZSBvdXRwdXQgb2YgdGhp
cyBjb21tYW5kIGlzIGNvbnZlbmllbnQgZm9yIGUtbWFpbCBzdWJtaXNzaW9uIG9yDQo+ID4gLWZv
ciB1c2Ugd2l0aCAnZ2l0IGFtJy4NCj4gPiArZm9yIHVzZSB3aXRoIGBnaXQgYW1gLg0KPiA+ICAg
Li4uDQo+ID4gLS08bj46Og0KPiA+IC0gICAgICAgUHJlcGFyZSBwYXRjaGVzIGZyb20gdGhlIHRv
cG1vc3QgPG4+IGNvbW1pdHMuDQo+ID4gK2AtPG4+YDo6DQo+ID4gKyAgICAgICBQcmVwYXJlIHBh
dGNoZXMgZnJvbSB0aGUgdG9wbW9zdCBfPG4+XyBjb21taXRzLg0KPiA+DQo+ID4geW91IHdvdWxk
IG5vdGljZSB0aGF0IHdoaWxlIHdlIHR5cGVzZXQgYC0tcmVmcmVzaGAgaW4gbW9ub3NwYWNlIG5v
dw0KPiA+ICh3aGljaCBpcyBhIGdvb2QgdGhpbmcgdG8gZG8pLCB3ZSBzaG91bGQgYWxzbyB1cGRh
dGUgdGhlIGVudW1lcmF0aW9uDQo+ID4gaGVhZGVyICItcTo6IiB0byAiYC1xYDo6IiwgYW5kIGFs
c28gIidnaXQgdXBkYXRlLWluZGV4JyIgaW4gc2luZ2xlDQo+ID4gcXVvdGVzIHRvIHVzZSB0aGUg
c2FtZSBgYmFja3F1b3RlYC4NCj4gPg0KPiA+IEFsc28gdGhlIHdheSB0aGVzZSBjaGFuZ2VzIGFy
ZSBkZXNjcmliZWQgaW4gSmVhbi1Ob8OrbCdzIGxvZyBtZXNzYWdlcw0KPiA+IGlzIHF1aXRlIGdv
b2QuICBZb3Ugd291bGQgd2FudCB0byBpbWl0YXRlIHRoZXNlIG1lc3NhZ2VzLg0KPiBUaGFuayB5
b3UgZm9yIHRoZSByZWZlcmVuY2UuIElmIHlvdSBzdGlsbCB3YW50IG1lIHRvIHVwZGF0ZSB0aGUg
Y3VycmVudCBwYXRjaHNldCwNCj4gSSdsbCB1cGRhdGUgdGhlIGZvcm1hdCBhcyB3YXMgZG9uZSB0
aGVyZS4NCj4gPiBUaGFua3MuDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyENCj4NCg0KQXRv
cyBpcyBhIHRyYWRpbmcgbmFtZSB1c2VkIGJ5IHRoZSBBdG9zIGdyb3VwLiBUaGUgdHJhZGluZyBl
bnRpdHkgaXMgcmVnaXN0ZXJlZCBpbiBFbmdsYW5kIGFuZCBXYWxlczogQXRvcyBJVCBTZXJ2aWNl
cyBVSyBMaW1pdGVkIChyZWdpc3RlcmVkIG51bWJlciAwMTI0NTUzNCkuIFRoZSByZWdpc3RlcmVk
IG9mZmljZSBpcyBsb2NhdGVkIGF0OiBTZWNvbmQgRmxvb3IsIE1pZENpdHkgUGxhY2UsIDcxIEhp
Z2ggSG9sYm9ybiwgTG9uZG9uLCBXQzFWIDZFQS4gVGhlIFZBVCBOby4gaXM6IEdCMjMyMzI3OTgz
LiBUaGlzIGUtbWFpbCBhbmQgdGhlIGRvY3VtZW50cyBhdHRhY2hlZCBhcmUgY29uZmlkZW50aWFs
IGFuZCBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSBhZGRyZXNzZWUgYW5kIG1heSBjb250YWluIGNv
bmZpZGVudGlhbCBvciBwcml2aWxlZ2VkIGluZm9ybWF0aW9uLiBJZiB5b3UgcmVjZWl2ZSB0aGlz
IGUtbWFpbCBpbiBlcnJvciwgeW91IGFyZSBub3QgYXV0aG9yaXNlZCB0byBjb3B5LCBkaXNjbG9z
ZSwgdXNlLCBvciByZXRhaW4gaXQuIFBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVs
eSBhbmQgZGVsZXRlIHRoaXMgZW1haWwgZnJvbSB5b3VyIHN5c3RlbXMuIEFzIGVtYWlscyBtYXkg
YmUgaW50ZXJjZXB0ZWQsIGFtZW5kZWQsIG9yIGxvc3QsIHRoZXkgYXJlIG5vdCBzZWN1cmUuIEF0
b3MgdGhlcmVmb3JlIGNhbiBhY2NlcHQgbm8gbGlhYmlsaXR5IGZvciBhbnkgZXJyb3JzIG9yIHRo
ZWlyIGNvbnRlbnQuIEFsdGhvdWdoIEF0b3MgZW5kZWF2b3VycyB0byBtYWludGFpbiBhIHZpcnVz
LWZyZWUgbmV0d29yaywgd2UgZG8gbm90IHdhcnJhbnQgdGhhdCB0aGlzIHRyYW5zbWlzc2lvbiBp
cyB2aXJ1cy1mcmVlIGFuZCBjYW4gYWNjZXB0IG5vIGxpYWJpbGl0eSBmb3IgYW55IGRhbWFnZXMg
cmVzdWx0aW5nIGZyb20gYW55IHZpcnVzIHRyYW5zbWl0dGVkLiBUaGUgcmlza3MgYXJlIGRlZW1l
ZCB0byBiZSBhY2NlcHRlZCBieSBldmVyeW9uZSB3aG8gY29tbXVuaWNhdGVzIHdpdGggQXRvcyBi
eSBlbWFpbC4NCg==
