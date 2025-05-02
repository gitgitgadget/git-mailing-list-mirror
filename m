Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80AE3A1DB
	for <git@vger.kernel.org>; Fri,  2 May 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194370; cv=fail; b=AFZqsAJxeieAbLttEorjVsPuMOmcalReDxyLvA1eLVChhPmN1ePDxcEAwII28bHjA2ZTsOwtaRJxnrYnOtfdYgb5b8IVk7JimOR7jDGAuYxMiNozD5+816Dsf1SrQR7N+tOfZThgZDqHhxldsa38NFnEoADTlpFhZ5RdZc1+wVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194370; c=relaxed/simple;
	bh=cyEOMD/DHHm+bBJOwh7l8h3cnXWmipQeiFc8b/jFQ/U=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uXhULXk0wZfsRPGR9Pg5p1WnmlW+YPtPgpUW1R3OyJbYsHviPsBmXHY8DknmwA2OCMZN6feUDpqUnz0qgMldrJdp2JgoK+p3micQvWtc6p2Ka11txJw5kDeBYuurNhEB0LfeOZf3L6x4F1PynwMlbK+RVsRYvlpC1hX/9Vgkuj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soprasteria.com; spf=pass smtp.mailfrom=soprasteria.com; dkim=pass (1024-bit key) header.d=soprasteria.com header.i=@soprasteria.com header.b=VIXmsrhr; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soprasteria.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soprasteria.com header.i=@soprasteria.com header.b="VIXmsrhr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAOUBQ/dK1SvXRqcBqL8gSM0CUivdW/F9lDB5hjaxDVDKt9teIAS7ryWPQ7Q9ReWj7A3pMLIrNRGnD4+no3Ebv1yJJIqopDq1jyySEWuMFXX6H7M9zDsCx/HHSCuQiVz7B/pmxbqeiDS9/xjezpK77b0PjP1nn3OmDlg8iEMDQt9u3xQxb9Ui5FaoytuKTuBcfLhgC0rQlRg9LMwHYHXxyG+95tVYUuhHjVqSI39X5050NXDhy90WR1cKTLGNNycCSpM4Un2O3d6AIOynmvcNdF3PRk+6cnbLjPiPE1qrrAkL7K74OmiwP2U/4k8igJIoYNJzTpragifhx8ZNoW7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyEOMD/DHHm+bBJOwh7l8h3cnXWmipQeiFc8b/jFQ/U=;
 b=qSlvv50fZ9drkpimwQl2dLrRTkIzkMUAdVGG4i7aWdpBdbxJp0zZ7hdtaB8mkRjlxW+HrSBum2+S2Ms1KAtOypzcBfjSJZA6jFNOLcyQ8XheTiBx4+HkkK8eNubNjSPIOv4ruxr9qvdgMNtvbwjGKqVwZRkc4gI2P0MOGfAwsYrrnf0HY3uhcc8C+y2x2qkhcEtkDAOCoOPB4olQW4YWMKr4UWW8r2imxRveNL/2lnsbehFt86jLJczTAaoC9/hOyU3uDT0o9uXZxPmMVs5Qu6C/YapQjUEGrhnwICML910emasEMM2FWL6tCJXno3DLj9C+hF3kCb4IPbfUr0ZlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=soprasteria.com; dmarc=pass action=none
 header.from=soprasteria.com; dkim=pass header.d=soprasteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyEOMD/DHHm+bBJOwh7l8h3cnXWmipQeiFc8b/jFQ/U=;
 b=VIXmsrhrhTlN3i30JzqvdOEtPg5EnvkURBv5+j/KfPvDk2GarMhXobwx0VD3uv/lLzx2O8DAybGpkPh/BbQaVh4Fk+kbknBU1nxCQ3M12DKUbeqxAjZPUNUU7Iq0oUHmYFbBbzQDHU9UKmPaqsu53+rcz4XdM5nx220r49HDWuk=
Received: from DU0PR07MB8465.eurprd07.prod.outlook.com (2603:10a6:10:354::9)
 by GV1PR07MB8976.eurprd07.prod.outlook.com (2603:10a6:150:a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 13:59:24 +0000
Received: from DU0PR07MB8465.eurprd07.prod.outlook.com
 ([fe80::d64c:84d9:c4b9:dd8e]) by DU0PR07MB8465.eurprd07.prod.outlook.com
 ([fe80::d64c:84d9:c4b9:dd8e%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 13:59:23 +0000
From: BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git svn clone failed 
Thread-Topic: git svn clone failed 
Thread-Index: Adu7ad10CyvfCJ+WRum6ywQhrakJyA==
Date: Fri, 2 May 2025 13:59:23 +0000
Message-ID:
 <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_c5e6e129-f928-4a05-ae32-d838f6b21bdd_ActionId=d759b6ee-5de3-478f-9759-a3561761026d;MSIP_Label_c5e6e129-f928-4a05-ae32-d838f6b21bdd_ContentBits=0;MSIP_Label_c5e6e129-f928-4a05-ae32-d838f6b21bdd_Enabled=true;MSIP_Label_c5e6e129-f928-4a05-ae32-d838f6b21bdd_Method=Standard;MSIP_Label_c5e6e129-f928-4a05-ae32-d838f6b21bdd_Name=EN
 Restricted
 use;MSIP_Label_c5e6e129-f928-4a05-ae32-d838f6b21bdd_SetDate=2025-05-02T13:53:30Z;MSIP_Label_c5e6e129-f928-4a05-ae32-d838f6b21bdd_SiteId=8b87af7d-8647-4dc7-8df4-5f69a2011bb5;MSIP_Label_c5e6e129-f928-4a05-ae32-d838f6b21bdd_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8465:EE_|GV1PR07MB8976:EE_
x-ms-office365-filtering-correlation-id: 54b47378-67d8-4e50-7781-08dd89818b3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UUw0L1hVS0x3LzVBWEg4cVFuamRZYnRNbGc5RnFOWURiYzF1OVV2WUxZYzN2?=
 =?utf-8?B?Q0M4Ymt4cEhqT0FieXRXWjR0ZTZmeG9HZkdqbStxZlpTRW5pNnM4dC9YWGdh?=
 =?utf-8?B?OFJ5UlVKU2JONGpzaDl0UkQyOWxmcHlUVWhNZWkwbTBMaHVjM1pNV1Y2Tmdl?=
 =?utf-8?B?STEvSjlkOHpWSmtjZkRrbFhiVHJQK2NrdzR5SFp5VUVndCtuNW5FRHR2bEd4?=
 =?utf-8?B?bC9mcTlUREMzc1ZTeUQrR29pSUxDSk53WFZ6dWtVSkRRMUlJeFhLQ0VabW5P?=
 =?utf-8?B?bVFjS3hUWmorSUEzblJOaXhueEY4S04xVy9yNlRVOVhIakpydXdXS2dtRFJi?=
 =?utf-8?B?bWJlTmFpQTg3ZDN4eVdvd1FaMHZwZzdyZ3BvZDhaL0RxYUxxZkx2OUFCUVZL?=
 =?utf-8?B?S2F3a1AzbmpGbGhnT0p4UFJ2Yis4YUJHUEh3a2MzQk43TnhVODFTcWdvRVJW?=
 =?utf-8?B?T1R0MzkrbVUya3dCZTAwcStHR2hrRCs0ZzJWZlNZNXExSm9yUFkzVEdZWm1m?=
 =?utf-8?B?NERBaXpudVBXQlk1eHlneVV5NzBieVdwRkFObkVnZDZpNTQ1NWYzdEJaakxK?=
 =?utf-8?B?QkpQSTdHU2VmbjlyMGQ5Z3F2KzNTbER0eGtVRFZ4aXhVVERlei96cDMwbjBL?=
 =?utf-8?B?cFNDeUphYUUvY3hEZHFqWi8xNEo5dUx1N1RFRmVsUmdaR1dhUE9TYWxqWmRk?=
 =?utf-8?B?NUdmZ0xlb0UySm0zTTBMNzlEVUpDN05YWlIwZ3ZCNU9WZU9JcmlvdEhDbWJm?=
 =?utf-8?B?SGtBQ0FxdFJTc2gvR05kWXZNcU5nQ3F2TlJlVW1wcU5KdCtaNEViMzBZQWlO?=
 =?utf-8?B?bnJnRkV6aHBQcWNlSlBrbkk2NVA0TC9MWTA2VUN4UTJjVlRtd3N3Q0dBMjFF?=
 =?utf-8?B?MGpoNnhuZmJpSUt2YnlmdXB5bVE1YXF3Vk1EaGZueWN0YzhEVGx6QmhJQ05U?=
 =?utf-8?B?azI1YzFaMUZVZ1JMNXBkNE5sQmpYcHRrR1JxS3duMUFOaGpLNVhxbFRGeFkw?=
 =?utf-8?B?T25xc0JkMFJkOFoyT1pmMjBUTWpUUitOcGpDejludll5b2ZSVDRlZ2p2M0Ux?=
 =?utf-8?B?ZnJSNEZhY3BZbG9ZdGFuQzQ5WEgweE9WRWlobzg2SkViWnd3RXJaZWRrMXVi?=
 =?utf-8?B?T2NYeDE0SkVrRnkyeDFVc2RpRENRdmdONnJQaU9EQVo0a0dzN1ZkdC8vRDRD?=
 =?utf-8?B?YzdQNVNCaHJhUzd2WWY5cy8rRkIyU2ZpN1FyWklWeGJrVEw4NU1LdkNVQ0JI?=
 =?utf-8?B?SVVkQVBQSkhqbkNuNkZXZUhpdnIvWWxZV2VvbXJyMVRlcjVqYnQxalNuL1Vy?=
 =?utf-8?B?QnBtWkZyMDFGUk0rVzVqWHpEcDBmRnZDLzFIOEwrWUFrdFo3OFNrT3QxM3Zt?=
 =?utf-8?B?UWxGZU9QdENtVDg3SmVIczcxMHlJbndNd1cyd0xYTEJhU3h0ajdYZmRVbmNY?=
 =?utf-8?B?OUNJd0oxajdhb21aUGt3S0tTam1JckxQSVZjbGhxNk9NN1FmclFWUnFqbWw3?=
 =?utf-8?B?Y09yMExkb29uNVp0SHcwSVBVTGJKQkJHNTR5UnZCOW10QWNpMHY1LzBWQXpE?=
 =?utf-8?B?cUlkTm43SjNzVWc1ZUZsd21rb3MraFRUd21EdnpzQ0I2QkE0UjdtQ2RaRDNT?=
 =?utf-8?B?RVJ3UEF4YXJFQ0ZHRW03T2FTS0dZKy83aURGRlh6WXdQS2dmTmpFVlRta3hj?=
 =?utf-8?B?R2FrQzBSMVQ1ZWxCRzl4ekVidXhqeEtrZ0Fpbi80aGl3MkU4TTJ4eGVtaXBF?=
 =?utf-8?B?SFJvdDQ0YWRlR1NPUjNLWjVlQzM1YldKMjN2RUFwM1QzNldoQWRnMk12WW15?=
 =?utf-8?B?cEhjTkFRVHZyc2x4VXh0K05KYVpEc284WXUxSHJ4TTl2TlJtS0N5Q3pYUkhi?=
 =?utf-8?B?a213K2J3aEloZHdXTjUvRmxiSmFjeHU3eTNrUlluSUpaSGpmaEVJUEgxa2xk?=
 =?utf-8?B?SVk2UUdQTVFYZlBLcU1wd3RsUGh1bWtINmFJZXVMRzh2R0FwV3Z2UVplTDc5?=
 =?utf-8?B?Zkt5V0xMRzBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR07MB8465.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2kzdVVZNWNCejFsMXU5U2I2ZUt3eTYxZFdJL210VXFRZ0VKTmFVcGZkSUtm?=
 =?utf-8?B?czZzcXRraFRBZW11K3FETm9HdzF4Z1dRNDZORjJncVpycThhUzlGQ0k5aEhH?=
 =?utf-8?B?NkRxTDBHMDRvZXBXMnpuL3JXamVpb2hjQUZoclhqZ3RIRmdHOTFnbk9mVUtp?=
 =?utf-8?B?b1YxaHFMdnBqcUZ5UUtvSTN3dGpodHMwYzlPN0IzU2RGcGIvV1NkZm5uZVMw?=
 =?utf-8?B?Nk92VWFObGlUb3FORER2ZVk5RWhVVHAzdzY3WEdyK2NLTkZvRGdtSDVnWGtR?=
 =?utf-8?B?S3hOWXlIbTZNMnlLaWNlaWw2N3J6VTBRTjdNYzNHT1Y1S282Z1poS0xiMDVL?=
 =?utf-8?B?Uy96VElUMHVhT0JpVmJpSmpTTWhabkhraTdJYzc3TFZ0UHZDbVBGNnZNc2dH?=
 =?utf-8?B?dTByWnc2UTFwOXhNNDNSTEszWmtOaE5paDlRL3FRc2FrQTI2V2pKTFBhajBT?=
 =?utf-8?B?YnFLcHpPQ3FDNzAwNW9BY1RUSWdtbjN2bERHR3Z4SW9lVHcrNlRYTXBQNEVQ?=
 =?utf-8?B?QmhPcTNHVFVUOHJiVDZRenhrclQrcDBtdGJIWWlZcDAyZDdTNG1zWEZWUG95?=
 =?utf-8?B?Qmh2V09GRVFBMHZ1UFBxb3pvWDRPaEpsNWJza1oxZFh1RXBjaGJrMHpQb29z?=
 =?utf-8?B?aENBK0UzcHJJKy9pYzVTZEdXZ1pKdkdlbWtjeXRZN29VQnh2Nk9vMEhRZ2lk?=
 =?utf-8?B?ZGdoUFRMMmJlUFZiQklXaG50dDl1UVdsaXRxSUc5SW1uZXR6RUFjTzZWVUFW?=
 =?utf-8?B?UVlSVmFnM3IwVEZ1ejRTR0RtemtibFlISk05SEZRNkowNGJYeHV3MW1ENWpm?=
 =?utf-8?B?ZXV6bjZVTDdSQm51TU1JbFZxaUhkWVFqWVJHREFkdy9odWgxcjl3RXRqWmVJ?=
 =?utf-8?B?dlAvRzdyU0VRUXlJNkxpZVNFUFpiNElTdzUrc1cyN2l3bFRsUURyNjVLQzFD?=
 =?utf-8?B?YUVKY3dGRStNcW5jNDR5TXRHVGlTVmtWZ015L29tSFhCZk5qeWRWcW5Bck5i?=
 =?utf-8?B?Y281bitPZVdJOUZRNENvK3dpM3FOeVdrT05rVjN5UlFqbXpPRzBXaUFUUkJ4?=
 =?utf-8?B?RTNEb2tUWlBJbGM2WG00UWN6YmV3NFVhS1BNSmxxeEkrUzdCUVo2MzNLcHRS?=
 =?utf-8?B?YnllSFRRR1BtVGlHa3lNMzlOTHVNbnFkZ1g1UDhVZGFEa2c4N0dFTWt0VFo4?=
 =?utf-8?B?THl1L0RoRTA2cVZ1VlZTREZTZFYyN1Z5K2x6dUNGK3RTdDV6bGF1cWlGb0hx?=
 =?utf-8?B?blBVRkNlYXFzVDBoclZadXA1dU10WkZKUWZ4Rll2Tld1RHVyaHo4TWt4L0hD?=
 =?utf-8?B?WTlzZFh4ZFBJMjdYNnZpZTdaeWRSTTJ1ZlJ0QTd2NkIvcngrUW00ZlNWYUdS?=
 =?utf-8?B?Ri82dW9Xd3ZCTDFablRXQWVaMC9FL1Z2UlROMGZDL1laSkQ3VlZqM1ZyMGJY?=
 =?utf-8?B?MkJoY2k5RlhNSmdLTDMzZVgyR0V0Wm9vQWwrVjFyQU1RUklWdng1b0d1TExs?=
 =?utf-8?B?WW5hRHEzWW1ZdTB4Y0lidGFuU1NZZ1BDUXUzZENHUUw5UER0ZUVZOU8rNi9y?=
 =?utf-8?B?a202UkcreDJiTG94REkyTFYwVUtqSFNiaXFGREJGMDA4NDhmb0NvQXkzblBa?=
 =?utf-8?B?TlFYSG10UGlhelhFYXpXc3pEMFBKYWdvb2dVTGwyT3FIOXczZkgwU3BKUEFy?=
 =?utf-8?B?SzYyT1hZU3lPZ29CbmVsZDFnMUFzV0hpRzV2dmN1T0VKRzR2T3Q5Nk16VklU?=
 =?utf-8?B?Q1RNUkg1ZGlmb0FMZ0d1ZHpPbHBiNTFSbDhmbmFUQkhVT0F2K0tMdDYrV0dI?=
 =?utf-8?B?ck5pOXdOY0hoaEh2ZkRSUHZnWnViWDBnbTlxdnpUUWpVeEkrOC8xa1lKOExy?=
 =?utf-8?B?aFlMaTBFeVM1WWQ3bEYvVnJoSTdRL2paYnF0M0c3ZkxiRktYWGtJZUFOdGhE?=
 =?utf-8?B?MHVoV2xaZndrSkN5NDc4WEowMGd5aklOVEF1SDdCQmlia1FFMVFOSFVOZjcx?=
 =?utf-8?B?TG1aTlUrQVArOHM2SWxpbEN5T2Q2MmVDbWJwREVYVDVqM1FmcmxvT2o0K1VM?=
 =?utf-8?B?TXNIZTgrSHVaY25sWnJ0N3Y5eDhkWXFJUG5qeEhNd29NSGpVdUcvTnpidnNx?=
 =?utf-8?B?cy9VK3l1bkpCRmVRNzlJMGUrb1JpVktJazEyNVZpb2Zjb3BOSC9Sb3ZLdzlE?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8465.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b47378-67d8-4e50-7781-08dd89818b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 13:59:23.5844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fc9MCl+knTx7XrWLkslaFKH+/hcPukbOGrvbw/8G6uT/uRaGKllkUODbvLdtARx5zXTC/CtsBlKr/IqZWu07pcm8bqJ9zrvt0EBJ1hsRlQVVU062eLUlBwALt3Jn16l4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB8976
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: DU0PR07MB8465.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 77.173.107.209
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-disclaimer-hash: f22d6526c83b2db075808282e6ed83c117edcec601bc6610ffda2630afb90e32
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: GV1PR07MB8976.eurprd07.prod.outlook.com

DQoNCldoYXQgZGlkIHlvdSBkbyBiZWZvcmUgdGhlIGJ1ZyBoYXBwZW5lZD8gKFN0ZXBzIHRvIHJl
cHJvZHVjZSB5b3VyIGlzc3VlKQ0KDQotIEkgd2FzIG1pZ3JhdGluZyBhbiBTVk4gcmVwb3NpdG9y
eSB0byBHaXQgdXNpbmc6DQpnaXQgc3ZuIGNsb25lIDxteS1zdm4tcmVwbz4gLS1zdGRsYXlvdXQg
LS1hdXRob3JzLWZpbGU9QzpccGF0aFx0b1xteS1hdXRob3JzLWZpbGUudHh0ICAtLXByZXNlcnZl
LWVtcHR5LWRpcnMgLg0KDQoNCldoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0
ZWQgYmVoYXZpb3IpDQoNCi0gSSBleHBlY3QgdGhlIGVudGlyZSBwcm9jZXNzIHRvIHN1Y2NlZWQg
d2l0aG91dCBlcnJvcnMuDQpXaGVuIHVuYXZvaWRhYmxlIGVycm9ycyBkbyBoYXBwZW4sIEkgZXhw
ZWN0IHRoZSBlcnJvciBtZXNzYWdlIHRvIGJlIGhlbHBmdWwsIGdpdmUgYSBjbGVhciBkZXNjcmlw
dGlvbiBvZiB3aGF0IHRoZSB1bmRlcmx5aW5nIHByb2JsZW0gaXMsIGFuZCBob3cgdG8gc29sdmUg
aXQuDQoNCg0KV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KDQotIFRo
ZSBtaWdyYXRpb24gZmFpbGVkIHdpdGggdGhlIGZvbG93d2luZyBlcnJvcjoNCg0KcjI4MTQgPSAx
ZWNmMjBlMmQxNGI0NWVlNTE3YjU2ZjVmNTFiNDA2ODAxZTk4NjliIChyZWZzL3JlbW90ZXMvb3Jp
Z2luL3RydW5rKQ0KRm91bmQgcG9zc2libGUgYnJhbmNoIHBvaW50OiBodHRwczovLzxteS1zdm4t
cmVwbz4gPT4gaHR0cHM6Ly88bXktc3ZuLXJlcG8+L2JyYW5jaGVzLzxteS1icmFuY2gtbmFtZT4s
IDI4MTQNClc6IFJlZnNwZWMgZ2xvYiBjb25mbGljdCAocmVmOiByZWZzL3JlbW90ZXMvb3JpZ2lu
L3RydW5rKToNCmV4cGVjdGVkIHBhdGg6IGJyYW5jaGVzL3RydW5rDQogICAgcmVhbCBwYXRoOiB0
cnVuaw0KQ29udGludWluZyBhaGVhZCB3aXRoIHRydW5rDQpXOiBSZWZzcGVjIGdsb2IgY29uZmxp
Y3QgKHJlZjogcmVmcy9yZW1vdGVzL29yaWdpbi90cnVuayk6DQpleHBlY3RlZCBwYXRoOiBicmFu
Y2hlcy90cnVuaw0KICAgIHJlYWwgcGF0aDogdHJ1bmsNCkNvbnRpbnVpbmcgYWhlYWQgd2l0aCB0
cnVuaw0KSW5pdGlhbGl6aW5nIHBhcmVudDogcmVmcy9yZW1vdGVzL29yaWdpbi88bXktYnJhbmNo
LW5hbWU+QDI4MTQNClVzZSBvZiB1bmluaXRpYWxpemVkIHZhbHVlICRhcmdzWzJdIGluIGpvaW4g
b3Igc3RyaW5nIGF0IEM6L1Byb2dyYW0gRmlsZXMvR2l0L21pbmd3NjQvc2hhcmUvcGVybDUvR2l0
LnBtIGxpbmUgMTY1NS4NClVzZSBvZiB1bmluaXRpYWxpemVkIHZhbHVlICRfWzNdIGluIGV4ZWMg
YXQgQzovUHJvZ3JhbSBGaWxlcy9HaXQvbWluZ3c2NC9zaGFyZS9wZXJsNS9HaXQucG0gbGluZSAx
NjgxLg0KZmF0YWw6IE5vdCBhIHZhbGlkIG9iamVjdCBuYW1lDQpscy10cmVlIC16IC0tbmFtZS1v
bmx5ICBkYXRhL09WSy86IGNvbW1hbmQgcmV0dXJuZWQgZXJyb3I6IDEyOA0KDQoNCg0KDQpXaGF0
J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkg
aGFwcGVuZWQ/DQoNCi0gVGhlIHByb2Nlc3MgZmFpbGVkIGluc3RlYWQgb2Ygc3VjY2VlZGluZywg
YW5kIHRoZSBlcnJvciB3YXMgaW5jcmVkaWJseSB1bmhlbHBmdWwsIGFuZCBzZWVtcyBsaWtlIGEg
YnVnIGluIEdpdC5wbS4NCg0KDQpBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoNCg0KDQpC
ZWZvcmUgdGhpcyBoYXBwZW5lZCwgYW5vdGhlciBlcnJvciBoYXBwZW5lZCBmaXJzdCwgd2hpY2gg
bWF5IG9yIG1heSBub3QgYmUgcmVsYXRlZDoNCg0KcjExMjYgPSA5ZDVmMDczY2ZjYWMwMGI5ZDg1
ODY5MjNkYTRkMDQ1Njk5MjQ0NzQ5IChyZWZzL3JlbW90ZXMvb3JpZ2luL3RydW5rKQ0KRmFpbGVk
IHRvIHN0cmlwIHBhdGggJ3NyYy9MaWpzdGVuLy5naXRpZ25vcmUnICgoP146XnRydW5rKC98JCkp
KQ0KDQpUaGlzIGFsc28gaXMgbm90IGEgdmVyeSBoZWxwZnVsIGVycm9yLCBhcyBpdCBnaXZlcyBu
byBpbmRpY2F0aW9uIG9mICp3aHkqIGl0IGZhaWxlZCB0byAnc3RyaXAgdGhlIHBhdGgnIChzdHJp
cCBpdCBvZiB3aGF0LCBhbnl3YXk/KSwgbm9yIHdoeSBpdCBmYWlsZWQgb24gdGhpcyBwYXJ0aWN1
bGFyIGNvbW1pdC4NCg0KUmVzdGFydGluZyB0aGUgcHJvY2VzcyBieSByZXJ1bm5pbmcgdGhlIHNh
bWUgJ2dpdCBzdm4gY2xvbmUnIGNvbW1hbmQgc2VlbWVkIHRvICdmaXgnIHRoZSBwcm9ibGVtIGJ5
IGp1c3QgY29udGludWluZyB0aGUgcHJvY2VzcyAod2hpY2ggYmVncyB0aGUgcXVlc3Rpb24gd2h5
IHRoZSBwcm9jZXNzIGFib3J0ZWQgaXRzZWxmIGluIHRoZSBmaXJzdCBwbGFjZS4gQ291bGRuJ3Qg
aXQganVzdCBoYXZlIGNvbnRpbnVlZD8pDQoNCg0KDQpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9m
IHRoZSBidWcgcmVwb3J0IGJlbG93Lg0KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24n
dCB3aXNoIHRvIHNoYXJlLg0KDQoNCltTeXN0ZW0gSW5mb10NCmdpdCB2ZXJzaW9uOg0KZ2l0IHZl
cnNpb24gMi40OS4wLndpbmRvd3MuMQ0KY3B1OiB4ODZfNjQNCmJ1aWx0IGZyb20gY29tbWl0OiBj
Y2ExZjM4NzAyNzMwYjM1ZjUyYzI5ZWZkNjI4NjRiODVlODVkZGNjDQpzaXplb2YtbG9uZzogNA0K
c2l6ZW9mLXNpemVfdDogOA0Kc2hlbGwtcGF0aDogRDovZ2l0LXNkay02NC1idWlsZC1pbnN0YWxs
ZXJzL3Vzci9iaW4vc2gNCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uDQpsaWJjdXJsOiA4LjEy
LjENCk9wZW5TU0w6IE9wZW5TU0wgMy4yLjQgMTEgRmViIDIwMjUNCnpsaWI6IDEuMy4xDQp1bmFt
ZTogV2luZG93cyAxMC4wIDIyNjMxDQpjb21waWxlciBpbmZvOiBnbnVjOiAxNC4yDQpsaWJjIGlu
Zm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlDQokU0hFTEwgKHR5cGljYWxseSwgaW50
ZXJhY3RpdmUgc2hlbGwpOiA8dW5zZXQ+DQoNCg0KW0VuYWJsZWQgSG9va3NdDQoNCkMyIC0gUmVz
dHJpY3RlZCB1c2UNCg==
