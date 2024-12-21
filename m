Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A533FE
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734793560; cv=fail; b=O8Re0Tbw/nwkJS7wfiZKuZ0mKwrb/f6iizay4OCqSqqyXdt79NYSOBDWCaZX4ERQO8mycyLAPTN3PscruJ2w1+nUpAJm6UnLK+1r3McBWyNdfLpVtJecHkwKj/g6ZnClXtDx03L7O7TrYx7ZAN/KZUnwxjaE2ch43W2aGFpgnsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734793560; c=relaxed/simple;
	bh=GCNb0CkL/bWO88Rtl7U58PPi1zNiG24OrFFCD8gxvOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X+bIJcndlN7Rj6sbmlT+k9T+kTZ2YF3ohjj0GAjAR6PiJIuw66m+p/hzEduQOPpFfbPTnPdROaAUwWJhk9lUiKqMo9tBofapx8jPrvFNmg3bbj6jmWxm+XDmxtqrBCiSK25NpoH5bOWLK4lFElELtMJE9UiJZwaV0nV/3EvbZvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=OJ8M9pLD; arc=fail smtp.client-ip=40.107.220.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="OJ8M9pLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdWEaA72pQ/K60bxn4ybGge1VIDht89554kNRXm+UEyz90ZAc+/FHOzbYOrO9VgQAOISuT0UQfJhjmajXWBuvzeEWVjeyb3VW7Z++SP7xfZ1crMsI9Hfno1cIIS6lMw6sMH4skEDYE/EdK10ldIjMCfB6syLB+am9ODDyJ1R59nxFjA63Yx8cOhxNhLLeMP4L4LJ03gDrYHm2zY/vttsro26wXtpuz1rpLGAtHJA+exp4k92niZWFboOEy5yjnmL2vHg0/kIGP/2g4kkefrllFnPsCOcIAOQxBTwhVxlGxXoF/bRaPb2CuYCpSiVx2lSTQP1IFfeOzsxi8rwrGZveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCNb0CkL/bWO88Rtl7U58PPi1zNiG24OrFFCD8gxvOg=;
 b=mM4nPEqHWEZgpyxddX1bDX/r0EhScpcwIgOVV8VBNb6aUkMfU0NNPQFQCdYFgoXRm088FPxQvxOo/PFCUyw1ZlZL5iMig/jPTSbXuSs5KQAvRGBeMehYnLQvl3NLivxhWWRuWdoqvLtk76RDumxKv13eqNIZWJnNt1wq6MjtE5Y70k82xdSXsNsOBN0l3UTORUSMsKjazodt67siMcOGKWaKPqk+uT+AU8y83d9rBtflicWJEFRTAjxlYInyC/CZElf/jTfx2WfUai5nWxK/vjLj1jlLdtQZv/m4s+pX1xtolduS8eiNIbfspHbinEn6g8gT1zyz6GbHyDfs7EapbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCNb0CkL/bWO88Rtl7U58PPi1zNiG24OrFFCD8gxvOg=;
 b=OJ8M9pLDZQqczhgY5W0LX0QJwmnyp3U9BzwyxsH5fW3RRHtQpenjhuYbv8Zxg3hUPUml41ldPx4sRLfyFd6foewVS0pfTrDgt1TVzbcfLC2uUxzmDTKNnJqJWLkCPh7/ZurYAZmPsuoUCM+xJmYrh3kZl2NU1g4rS0VGr+ONQMY=
Received: from BL3PR17MB6020.namprd17.prod.outlook.com (2603:10b6:208:3b3::14)
 by CH4PR17MB7402.namprd17.prod.outlook.com (2603:10b6:610:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Sat, 21 Dec
 2024 15:05:50 +0000
Received: from BL3PR17MB6020.namprd17.prod.outlook.com
 ([fe80::edb:348f:3dbf:153d]) by BL3PR17MB6020.namprd17.prod.outlook.com
 ([fe80::edb:348f:3dbf:153d%5]) with mapi id 15.20.8272.013; Sat, 21 Dec 2024
 15:05:45 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Patrick Steinhardt <ps@pks.im>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH 0/4] reftable: fix out-of-memory errors on NonStop
Thread-Topic: [PATCH 0/4] reftable: fix out-of-memory errors on NonStop
Thread-Index: AQHbU56RgoFbzrHyTU6GcSODvsiFUrLwy7yA
Date: Sat, 21 Dec 2024 15:05:44 +0000
Message-ID:
 <BL3PR17MB6020D6CB8712F2C6F36FC8CFF4002@BL3PR17MB6020.namprd17.prod.outlook.com>
References:
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
In-Reply-To:
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR17MB6020:EE_|CH4PR17MB7402:EE_
x-ms-office365-filtering-correlation-id: 10dc922e-cbf3-490f-677d-08dd21d0f1c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmF5N2NhOGVRUW1BclpzVmNwcFkyWUdQMzBVVG5xcE1KeHdmbDYvSmRyVU5O?=
 =?utf-8?B?VXhFOGVFajlLRXdrQzJpT1JibG5jRlB3N0IzTFlCOWthRE1ZdS9VcjRCL3lC?=
 =?utf-8?B?RG8xOHhLZmpkYTNuZkh3NWovcVBaSktlTkZUUi9uUDNkM2RIYktTdjZBYk4w?=
 =?utf-8?B?VjVnNmN4RFN3MjFzQWoxemJycGZYNTJHRHNzUXMwbnlJRFRhckF2UVcrRkNV?=
 =?utf-8?B?RmdLWG52NjFiSWJYcHZaQVNLZUZISHpsdEZ6REdaL2pmajlKVlE3MnZtSStT?=
 =?utf-8?B?bGdzeTF2R1dIUGpXWEJwSElMcVQxM3NlVlVWbWFpbVpWMkFra0pZK21ka3VY?=
 =?utf-8?B?UndIZXdDbFZ6L0tKVmZ2Z3RvT3YwUzNlcmx4TGpyRnJLSHpUTFNvOXlSYUc2?=
 =?utf-8?B?cVFWNHkyZkZ2Wlo4UVhFbGoxSTRGZTc3MFZXS3RLYjVHVjM0Q1lOWTBPOHRC?=
 =?utf-8?B?aUQvNmJ4Q3JwZDFBakxjdmJRcXVreEVvR2oxU2l0czBqanNsbXlrSGpJZVhB?=
 =?utf-8?B?UnNUTTJMTE1KSVZTUXNxSENCVXVBQkhlS3N0Zy9TUVBQTEI5c3llVHlzcEJZ?=
 =?utf-8?B?b3k3NHltajM3ZDdwZ3hMZnlYNHdyV09Ea2RqZmJkajRnMnM4OWxsTS9KZE9G?=
 =?utf-8?B?VDBJditOSEtLM0FDOTRWODlHMjR0RWVlVlE2S3BQTjR1STJNOEpVcmJKOXFa?=
 =?utf-8?B?ZTJXOHNnMmRBRHkyRitNcURuTE9LQ3p1MlJ0MVdjaGdoNjJHNlNhNWs0Mm9p?=
 =?utf-8?B?YWtMN21aNmhqODB5Qjc2NUR6bXFYcVVPWUhSNlduUmpWc3J4WmlPY1ZpUmRk?=
 =?utf-8?B?NDFsYTgzSXFLRU1rVy9EZW1ObW1IK1VaVVZxN1RSby93S1F0NElWcnp1ZmRI?=
 =?utf-8?B?cXc3VHJaQUNON1QwOFlYZ0Q4aHN4TThBckRnTnRkL1hVWWFkc01xWXR4YU5R?=
 =?utf-8?B?eVdHLzFmLzlrOGh6OXFpWTltY1REZGdEcDNST1huVkxzY29EM1g2OWJZTG5v?=
 =?utf-8?B?OU9KeWM2UnBMNzA2UHhMUTZsQmMwU1gza3l6aWQ2ZVp1U0FkQ2lCaWVIOG5z?=
 =?utf-8?B?T1UyUmpNQkxRU0M5TFZZdHdzamVKalZJQU5lUFcveUZ4Z2kzaE9HNFduYUtz?=
 =?utf-8?B?a0JpeWpVVEJzWmJvZE1ja1pyR09JazRvWUIzTGFEL1RJaHN5MGlrMXJRajVN?=
 =?utf-8?B?UnZBOTEyRTdOMVpQUkgwdVhFaVdkbGRmdnVsZytlNDRNTUg2VkdLaWd6UWts?=
 =?utf-8?B?M1hwd3hZYmUrZGFId0tGR1E0OVlSdVZWZWVFdzF2anF6eEhMTDNURkh0cGJm?=
 =?utf-8?B?NmNPWkdjMU5yMkxSTExIVHB4TmRvTHZlbUZERWNmSklFaDU4S0pLVGpEcU1r?=
 =?utf-8?B?Wk9lRmNDWE9LWVlkK2gvdXAzSUZyekwyVFo1R0RMaVBKa0U3b0hhTnYzUmpX?=
 =?utf-8?B?QVFNMWxvaHc2c01hV1FmZS94N3E4TDQvU0lFbEE5YlJ6SFFyUTcvcTlTL3Yr?=
 =?utf-8?B?emFheU9mbDZRWEpRcmp0WE9iRThWSXpFUG91MitwUnJPa2xlekVtV21Kb2JU?=
 =?utf-8?B?Q0RsclJvQkU2N3Y1VGZlcGZOd2dkU3g5QXFqWDgwMFp6WkNBZXpSOWhhZzgz?=
 =?utf-8?B?MVF6aGpuQUJkUzl0M2RsQ1l3N3VUTjA1bWtnYTRrNHJ3M2FmSGh5LzhONGJz?=
 =?utf-8?B?UWdkTWZ2b0IvSGtIZzNhN1ZUT045ZCs0VURNRE1Zdm12SjNhcnBhM3NNRlgv?=
 =?utf-8?B?NjdXcDhnZjBFMFhQaEo1S0dtaFlFUWx4c3Iyd1NCeFM2R1VyNnMwbisxOUI2?=
 =?utf-8?B?bnVqNXZ3MFBQU2w4Umg1ZXJsYy96dHVhbXVQMmJUYTBUTlRpN3B5QXU0bkJT?=
 =?utf-8?B?UnRoTUJLNmZzbzJ5ekNJb2Z3MWNsVUlDNHo5UTN2S2pkbmF6TWlXcklZOHBX?=
 =?utf-8?Q?M2D1vaM7JdzomegjJfXBFci+zg+fKzod?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR17MB6020.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnVhck9OVm9EeFR0VzZGeHdOQkdmbTVxS2UzeG9GbTJxTzVMM09VeGhNbHZY?=
 =?utf-8?B?MXV2WExHbHg4YzB3a1JJV0kwamlFYlRBMFNEVUo0Ui9CK3VBZDRSM2J3cEVO?=
 =?utf-8?B?b25US3V6TDNzYXlyRVlmT2pPenFjZEk5YlhWWUZZa29QVGV1TWpZZ0YwZEM1?=
 =?utf-8?B?T3I1MklsYkd2cE8yV0pLaEgvN3phWFpXbTBvYjFQUWVUK3RiS3BVb0FZaUox?=
 =?utf-8?B?ejRRSEdlU2ZNNDhPakNkYVk2ZktvNHhsSGl3UHNxRFhpeW9TajJLV2JLZHZv?=
 =?utf-8?B?dVQvcSt0V1RqdjZrY05UNHV6aklUMDNWcUhzeGpkL21oUFVtQ3VwK1VUaXJm?=
 =?utf-8?B?WnFtU20yaDB5YVRFbWJQMXozS3RSZCsvWWJqbzBOZEdXdlU5d0ZHSFRMZVNH?=
 =?utf-8?B?NmRBOU82ZFNYbFU4eENicFNHdTBVSkRqN2lKaVl0QTdIdlIyeWtHblZxQWhR?=
 =?utf-8?B?Z21JcXFvc01sR2NMV0hNNUhvYVlJRTA3c0Zhc2tqcDNyY1hiYlZYdi9LSk03?=
 =?utf-8?B?UkRYZUdoYVAvV1BoejlFeksyK2x4bGUya2NKL0VvZFc2MDd4UFl1dXZHTzgz?=
 =?utf-8?B?N2tBR3MwM3E2YVlaSzI4U0NPc3JPcHpsMlR3YkNMaTh2b1g1WEdydTU3QmZr?=
 =?utf-8?B?SUVFQnFxWGFiSDFGbWh6ZXc5LzZVK0xJazNoanBEVUlUakVQQWV1NTlZbTNM?=
 =?utf-8?B?QThqeTB5QXh3Y0tpVnRJdi9KV3pTYmJITlJUa1lOWEs3Sy9nQUlwVGMyb0p2?=
 =?utf-8?B?K2x3R1dCVVA0YVRpUUVEZGdIZjhpaFBBWUs4K2dRTFlWS3FqQUVhMWM4QW9L?=
 =?utf-8?B?SC9IRlVSL2M4ZmVzdm0xL2pQUlRmdWYxYVlScks0OFQrSTdEby9hNXBmTjJK?=
 =?utf-8?B?b2JIN1RRN08vbTJ4NXZabVdpa3hZazgwZy9mRFRBNnZSNjdBNXhTWWc3eHhW?=
 =?utf-8?B?OVp6ZVZQam1jdXdTWkRwR3hrV0FFKzJtemM3SEdyZ3RxVDd5YnBRNEVlNndF?=
 =?utf-8?B?YTlZYkFJdjJ0VW1mQXAvRXQ3U3RVMVNzN01lclFhRlNTUmRWOWMrQzk0OTU5?=
 =?utf-8?B?bzczT3hPZXBYWDhYNGdxSUxJOXh4QVdXU1RhR3lYbU9nZlJQUjdYRy9GQXJE?=
 =?utf-8?B?eEdGcW43bGRjVmRvbEZXVUJqM210SmJhRy8yNE9wWGVzRHRPMUtKanhPMnIx?=
 =?utf-8?B?TFNEck5MYmFNM0EzbW9nOEtRMzRYenpGTUVzZjdMZHdvazZaV3B2a2QxT3Vx?=
 =?utf-8?B?dzVpOHBoa09uUmdsTUt6VlpIVzYwWXgxakZsb0pSakZRNi9Oc25tNmNkTUw2?=
 =?utf-8?B?Ujhqb2EwYTlXM1ZGeWFTdXY1WVFjYTFyYlU5S2Nzc2gyZ0VkVXozY3o1d2My?=
 =?utf-8?B?QWhUR1VrS2xqS1RLUk1lZ2Z0U0o1NTVIRjdodTlXTk1FR1VUekt5QktmMlpG?=
 =?utf-8?B?ejNPbThZR3h2UjBQSU51ZGZ0WGF3a2pjWmV5UlVhbjZ2Qy9JMElDZTVKRTFE?=
 =?utf-8?B?Q2NXU21LVnp2ZjAwUk1Ia3hub1Vwb2ZibVlBeG5BYUp0UGhTSElYc01QTzk2?=
 =?utf-8?B?U3B0cWZnMVVzSG1wV1ZRTzdpYUVkdXc0cDgzWm5RTnRHU1BKUHFYdHYzQlNR?=
 =?utf-8?B?c0ZRRjd4UkcwWVB5WFgwaUxEUkdwR1VrQXY5eURLOUI4TlVzYXZqbFE4ZDZJ?=
 =?utf-8?B?N0huTENxSzgxdXhSOTFrVENtWXQ2OUh5UnhPYlhra2VxUW1HUnM3WFlmYkRt?=
 =?utf-8?B?V3RTYTdoMllkUTRoa3dXUHkvWmF3dkFyYnBnWENvVnRVWGhNaWJ6cTh6YVZk?=
 =?utf-8?B?ckIxU0o4WHgvMlFEUllqUTM4bkhjK1ZPbVl5MFJVd1Z2Rk82cnZTbVBBTmZC?=
 =?utf-8?B?SGpoaWF0NVVoSzBBNzl1d2ZHMTlCdGh6Z1JGenAvM1B6WS9abTNjendtSjRZ?=
 =?utf-8?B?K2hVUTBZd1JsTEx5V0JFeHJaTmNMc3MxZE9WTGNFeEdzQytaMlJpMDNPU25O?=
 =?utf-8?B?L3k4aERWNzBBTitycEdLSlNKRVZiWW1HVGRiUGZEMS94N2NBaEVIY1NyUlRR?=
 =?utf-8?B?aFJ2dmw1d3dVSjdIbkpJMCtwU2RFV2YvSWhkZDBka1lLNm1vcnJ1SUs5emN2?=
 =?utf-8?B?aWhPYlA0VXB2Vzh1dy9USVNxYy9yeTBWejBmTDFVb0M0U2k1ZDlwRG80a0Rt?=
 =?utf-8?B?cEVaYnF1cUFWOGE2UmhQZmxETEZZMkJBa3ovUTZZaExJQ2pxem1zSHNlNElz?=
 =?utf-8?B?UDNNTi9iNmtNbkQ5NndTT3RzNGdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR17MB6020.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dc922e-cbf3-490f-677d-08dd21d0f1c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2024 15:05:44.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6fLgCJ0Qez7y+x1nB7bO8e9TD1S/97QDXeBxOs4vSr08MsOO99pLIjuWkuj+i+ky2Nuw10HpJL2ap2V+gdbjbRAl8ohWnpK+/IW/cdqz6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR17MB7402

T24gRGVjZW1iZXIgMjEsIDIwMjQgNjo1MCBBTSwgUGF0cmljayBTdGVpbmhhcmR0IHdyb3RlOg0K
PnRoaXMgc21hbGwgcGF0Y2ggc2VyaWVzIGZpeGVzIG91dC1vZi1tZW1vcnkgZXJyb3JzIG9uIE5v
blN0b3Agd2l0aCB0aGUgcmVmdGFibGUNCj5iYWNrZW5kLiBUaGVzZSBlcnJvcnMgYXJlIGNhdXNl
ZCBieSB6ZXJvLXNpemVkIGFsbG9jYXRpb25zLCB3aGljaCByZXR1cm4gYE5VTExgDQo+cG9pbnRl
cnMgb24gTm9uU3RvcC4NCj4NCj5UaGFua3MhDQo+DQo+UGF0cmljaw0KPg0KPi0tLQ0KPlBhdHJp
Y2sgU3RlaW5oYXJkdCAoNCk6DQo+ICAgICAgcmVmdGFibGUvc3RhY2s6IGRvbid0IHBlcmZvcm0g
YXV0by1jb21wYWN0aW9uIHdpdGggbGVzcyB0aGFuIHR3byB0YWJsZXMNCj4gICAgICByZWZ0YWJs
ZS9tZXJnZWQ6IGZpeCB6ZXJvLXNpemVkIGFsbG9jYXRpb24gd2hlbiB0aGVyZSBhcmUgbm8gcmVh
ZGVycw0KPiAgICAgIHJlZnRhYmxlL3N0YWNrOiBmaXggemVyby1zaXplZCBhbGxvY2F0aW9uIHdo
ZW4gdGhlcmUgYXJlIG5vIHJlYWRlcnMNCj4gICAgICByZWZ0YWJsZS9iYXNpY3M6IHJldHVybiBO
VUxMIG9uIHplcm8tc2l6ZWQgYWxsb2NhdGlvbnMNCj4NCj4gcmVmdGFibGUvYmFzaWNzLmMgfCAg
NyArKysrKysrDQo+IHJlZnRhYmxlL21lcmdlZC5jIHwgMTIgKysrKysrKy0tLS0tDQo+IHJlZnRh
YmxlL3N0YWNrLmMgIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gMyBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlv
bnMoLSkNCj4NCj4NCj4tLS0NCj5iYXNlLWNvbW1pdDogZmY3OTVhNWM1ZWQyZTJkMDdjNjg4YzIx
N2E2MTVkODllM2Y1NzMzYg0KPmNoYW5nZS1pZDogMjAyNDEyMjAtYjQtcGtzLXJlZnRhYmxlLW9v
bS1maXgtd2l0aG91dC1yZWFkZXJzLWM3ZDhmZGEwNjk0ZA0KDQpGcm9tIHRoZSBtYWxsb2MgbWFu
IHBhZ2U6DQoiSWYgc2l6ZSBpcyAwLCB0aGVuIG1hbGxvYygpIHJldHVybnMgZWl0aGVyIE5VTEws
IG9yIGEgdW5pcXVlIHBvaW50ZXIgdmFsdWUgdGhhdCBjYW4gbGF0ZXIgYmUgc3VjY2Vzc2Z1bGx5
IHBhc3NlZCB0byBmcmVlKCkuIg0KDQpUaGFuayB5b3UgZm9yIHRoaXMgc2VyaWVzLiBJIHRoaW5r
IHRoZSBwcm9ibGVtIG1heSBub3QgYmUgbGltaXRlZCBvbmx5IHRvIE5vblN0b3AgYmFzZWQgb24g
dGhlIGRvY3VtZW50ZWQgYW1iaWd1b3VzIGJlaGF2aW91ciBvZiBtYWxsb2MuDQoNCi0tUmFuZGFs
bA0K
