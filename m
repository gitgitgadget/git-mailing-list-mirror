Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78A1C4A0B
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016083; cv=fail; b=ab9KrK6ADg0HLgBsaI2WqF9dz8uJW93D7pq+mkwIm4EEa1sXPZcO9Pcol7lorQZXLHWOu9qH64KAtdp+6vPsAICa6kb0Lg2TvevPq+rrPvHYdIsvLmwfogZvdY6No2F1WI2gnsAmqkrRSSXQXi0eAHYjSsBL7essd/uQM5hOGVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016083; c=relaxed/simple;
	bh=hjZXbmsHbaLrTWowZDXOBNY6HR/SELS1fQNr11rHj4Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T7/I1eSm5T+xSP3IdHZ+YojqZnKfILCYv08MVRwEsteg22C62yL4kpCP+lmP1igwAlVvGaslKoNwJ4xneu+LCHnQP2ZB/yRBY0XMkhLRNcsmazvCKBO/vYYQaDGm1IKRXMh1Rv3RrSZNU8qRfAWvpDD1eaL8Jzv2peZGdgVqkMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tnm90zjA; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tnm90zjA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ9p2an002773
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=hjZXbmsHbaLrTWowZ
	DXOBNY6HR/SELS1fQNr11rHj4Y=; b=tnm90zjA6OKrJmBSRy44kNM6HeDK1Tcf5
	yOy++LYsZkMG2Wh3Lav+zLTQQoKZiY5/r09IGQ9rNV/Vmcuc6lA1wDa5kwEtQuqz
	vk7nDioLaMe3eXEOvqdUEpmqe8X5+1itkBS1fcA24tV1XHisviBkbmOSkibkH5O+
	dBfQ/atht7PCjQHoDQDNGZo4syyE7AaqvNbLAMDAOOoMaLqBmuQFwN8jAJ5oZRYL
	Frl16yLj5PLWRMG1gDMO+jV0btXMEu0601JdERHxOR2q1+YN9CohBpziEXJzuHhE
	HDtXa94nL7igDlbo6RBeRqKCPxjchBQgeZ2lZ8IQyW3LtAdKRGFeA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjpt39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:34:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI3BqYnheVadSOsCRCBov/ngV0L7rZO1gluCiqs7dGk3UdA7CPOaylk9I2xXUIRCM2nLaE1vVfXIYolj5qwUcK6Qba+itzvvAvJQPrde1EHmnjQpUip17+/qRzZPXqbUL1WOwc74nMO0A6wICaq6itvbXlgwUuOieqfLcbXOX9Cw6eAbwwzwCZC+Mp24IWMPMqfxz4uRSJvkGKvs4e6amSPM6IrCtXJy7nxu33cWCqpVgC+ND5QFc2f2tp3NMg2B9xxDzWhj/v4PRAmAtAEvoknn+PC5M4fi3h7KfiUPZEBgTC9TRPL8z4OKyB85LiVoZqaculk5sIcuxQLDeICEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjZXbmsHbaLrTWowZDXOBNY6HR/SELS1fQNr11rHj4Y=;
 b=JZFu0V34jXqgcKWrLxupRBdoiJWiAkr4TdDjcnXNGFqbu+EdxcOy54eAr+cPSuVVKEtttaBhhf9RO/u2CmLnS+AN/x/vPeRDop4DISkKpLna112XIv6P1tkGi50Y9ZWzzwRTKHJEYIdic7/FjxYFKPfq6y+WckJ5Y02I589DdmX3dwqamV5Wx5mPwt7rgoqyn3MGvOr05RYK68sM0zyDdyj6KQiCXDARGJMejEF77GYGbGz7EjCUWq8gclGV2U3v+jJV7+L2valiQGHV5oE2ES28zoLqDEGnuoyuIh/3VbOJ4xM3hwbkABTT5Y3GMoPRghWpLzTvNNfZutybv4a4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5446.namprd15.prod.outlook.com (2603:10b6:8:ca::7) by
 CO1PR15MB4988.namprd15.prod.outlook.com (2603:10b6:303:e7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 11:34:36 +0000
Received: from DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52]) by DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 11:34:36 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Inquiry on Onboarding a z/OS Machine to Git Community CI/CD Pipeline
Thread-Topic: Inquiry on Onboarding a z/OS Machine to Git Community CI/CD
 Pipeline
Thread-Index: AQHbOncDEzt2tIdPXku6dfb55NeDsA==
Date: Tue, 19 Nov 2024 11:34:36 +0000
Message-ID: <898B3E90-1703-419D-A5FA-8BE9557744E5@ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5446:EE_|CO1PR15MB4988:EE_
x-ms-office365-filtering-correlation-id: cfe64e99-3890-4cef-7944-08dd088e25a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUlsNncxblVBWWFrMlo5R0Znam9LZU5RbHB6VStxaGNoY3ZtNnQyZEN0clFk?=
 =?utf-8?B?ZTV0Zm84c1FBYXpQdzVMU2lKblVBQUxuVGFlMHlUQ0hQdDdjbk1xdG9USUdn?=
 =?utf-8?B?U0V6WHpHckp0RDJiWjVENkh1ZmFvdFZTdkF0dytaaWEraWszS3hUUXljVGQ4?=
 =?utf-8?B?ZndQWkdWS1ZaSjBQOS9qVWRyVkZ4ejlBTUtsbTFPNzlodzZyVFc2UGNLemNG?=
 =?utf-8?B?clU3eE44a2dEWkJyOXNkSit0U1dsT0ZMTmhOMjlLRjZRbDc2aVh1OG44dExJ?=
 =?utf-8?B?WTQzTlRTTEszb3hRVTZvMjBacFFsYVg4NTgyUVI4K2JwVVVueFc0WGxqbmYv?=
 =?utf-8?B?cFNkRTk5Z0JRazUyakpJTXdwOG80QWlReWdydzI0cFVPY1VaUEpxamRYN0Zu?=
 =?utf-8?B?NDhYZ3JmV2ZCYmxtVzhvcUxtOFBGVmFUTDR6YWJVSkRpTEQ4M0J0RlBMOFRK?=
 =?utf-8?B?SUJwa0g4a3M1UStjYW9UMHQ4bHR5UTNuRjFsdVJUMzczS3hYbkhZUHlVS2NE?=
 =?utf-8?B?WGp5V1h6VzNlQjByaWRWR0R5cmt4YVdibi9uRW5qbDdkYVhpM0hwcm9oeXlJ?=
 =?utf-8?B?Z3YweHltS0VpbHN1VGtBODJvNkZuTm1YYWlyWTZidTN1WlNtSGZRNlNaQS9R?=
 =?utf-8?B?OXJpeVdZYnpHeG04RXNYLzJVV3ZSYzB6ZUpLWGpHU2U5UUhuOWhYVFc5U0Qx?=
 =?utf-8?B?NmpNb1V6RnpXTE1xS2YzTW9RcjlVbk5NeWMyNm9yMDRLQktJRU5TbkZWdVZN?=
 =?utf-8?B?Zi84eXQwVnpiZUkzdWVYWWUzM0Qyc09MNzcrdzNUbzRkaitQYzh5OXVlRS9a?=
 =?utf-8?B?OXc5dXNsbXBYak8yeVlYMmd6U1VzQ0sxU0hUN1lzM1hJLzRrV0NUMkNSbUNp?=
 =?utf-8?B?QnJpUWtUTlBmSnNCNUtMczBJZlFrOVhQTVpHWk0rY25XMUZKRzRyQkFObTUv?=
 =?utf-8?B?RjV2Q29udkFDd245RXVhWWFGMU9nM0VYdmh5Uk13d3o2ZTZBdTB3V0JhZHN0?=
 =?utf-8?B?cUtFRi9oR25ZcWxabEp5RHEwWWtKdXBWckh0SzZsV3ZTV2pMWEpFTUtVQU1J?=
 =?utf-8?B?QjQ1bTRrQXNDZ1hpbVkzem1OSEt3R3luUnhFNU9HUlV0RDY5Z2tTVklSVWpV?=
 =?utf-8?B?MzcyNVN4MlNOUTBZZjhUV2lzSStJT0VuVmdIM2dpQkFKbFNsaTc4NTZWR2V1?=
 =?utf-8?B?SlFrbFZLZER6Um9GZVNBWWdSOXJ2TmlmdllhN00yUU9GOFRJRjFSV2laM1l1?=
 =?utf-8?B?b3hYalFwZEQ1RHhQQnJ4VUd2azRhOWkvRzFXakRlaW85QTNlak1kbStnY0Y4?=
 =?utf-8?B?YUFmL3NBUHgyNDhRa3BFc01rSUFLbE1aTDlXa29OdDNIY3hWTlBmRDcyems2?=
 =?utf-8?B?dTNkclpnZWVOcG1CTUdTaHBGUmhvRENBd3QrdlhRSnhlL09mWVRmaGI0a2tj?=
 =?utf-8?B?TXFEeTNrU3ZNSFFpUmxmQTkzY2k3QzVkU1dzdTNrRnltV2t2bEVadWs0VnRL?=
 =?utf-8?B?VndDMkNtTzRzMVA3MCtQT2U4RkRDbmRQZTk0R0lwM1FPR2xzTkY2UEM0cnI1?=
 =?utf-8?B?NVBiY0VIT1VqUENoQzBvSWpCUXFqRHA2eENTbER0NEtPWG96QXhuSkpraUN0?=
 =?utf-8?B?ZFNQWWhKTWk3NTFseXZNTTd3WU1oK1QzNXJhbzB5WWRKZnpXR2d6cExNUVQw?=
 =?utf-8?B?ZFZqVG5PVG9YV2tIcGF0cVdmNmxGMUJEc2R0dkVmcFFUdWhCNmEzdnpqYlky?=
 =?utf-8?B?cFhzWkJHYUt3REIzU2gzeStEVVJsemU3WHh3YXZ3V3RxU21WYmVwbWZFaGk5?=
 =?utf-8?B?VFIzZ3lEa3NObUJMOUh6VG9MaTE1VEdLY3hzelpHVDhkR01EUUt0VEdaMW8z?=
 =?utf-8?B?VllybTFVckg4bWp3VkJsaEt2ZG1FUWpuWURTNlNvczRCREE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5446.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1dISFFPaGlNK1R0UFZQM1lvbGRRY2QvSmRKelZtWFZFUXc5WWxpbVNhTXU2?=
 =?utf-8?B?RmhRUUpKSlA2Y3F2bEZ0TUI4SGVwWGs3djk4Vlhpcmt3aktMbk1HSERLZENu?=
 =?utf-8?B?WDdKcjlPNkI0STROMGxhcjNCdWxEZlBVOVlBR3I2MFl5VVh2eVhpdWc3VzFq?=
 =?utf-8?B?YmRTYzQyYkxGR1ZOQnF0dVMrcE1HdTBJY29FZXhZSjQxMmM1TVRYU3YzNDVX?=
 =?utf-8?B?NHJSSjhhQytGZlVrWnNLYTFDbkk4dllhb1c3MEFtMlpnUHArdHo3VkY1eFpk?=
 =?utf-8?B?WlZxMGR5MnJHYlpJeDBrdTd1cnBQTGF2Vjk2bjhHQ1ZTK2Jmek5LSGdFc1o5?=
 =?utf-8?B?UW1VU0tLZVhaK3dpUXNqT1pjUFdSVkVWZm9oLzljOHNvV0dwMnN3bUE4UFNm?=
 =?utf-8?B?aW0xMm0zRmkxcTV5NkpHQkNFNXBDZ2g2RmFSL1ByckJHeHNXMkNTQXlwcG4z?=
 =?utf-8?B?RXVoRm9oZDJqOEpKWFJZeGFPYysxR0xrMlJWSzVHR1FHRHhqd3JiaElqMys4?=
 =?utf-8?B?SFlHUGtONzFsUVozL1hKV1hVOHZVZEJZS0RkWlJSbm9BNEp3TkF1Y1M3UGN4?=
 =?utf-8?B?UUMzTzVzR2VGSEJYbE9tYjFYeTZITnIvTHpQSUU5bjFKekhRKzlTQ050bHpz?=
 =?utf-8?B?bFZxM0JCaVRIT1BxbXVlTlFOL1BieFJlS0FHSmU1TVVEbTNMcUQ2dTFhSXJO?=
 =?utf-8?B?K3ZxYURlZlFRQ0ZBcEFyWVZBbjJndHZXbmoraEcydnA3NnNvdUszeEphVGQv?=
 =?utf-8?B?QTJUQllYSUFUZWQvYmsvMExQelZYd2xOYWFzamUwMTluazFRem5kYVkvdllZ?=
 =?utf-8?B?K2ZsbXZ3aWtBVG0wak4vbDhXWmVDdWpoK3RjYlFsUjF1U20wTmNjZTNJdmNK?=
 =?utf-8?B?eDR4aTlydmV4R2lhQ1hCVU12eVk2YW1sV2lEU0NZZzJkOWNHZEdUVkJ0N3Fo?=
 =?utf-8?B?UG05RzBnczFaWnNzaXFSbnE2eFRCWU1jN0ZIMlgxcWlwTmhJQVNWYlh3T21J?=
 =?utf-8?B?TUNpRmptZHBoRGJqamNoek9GeEFkOWxVYkRqZ2RzbCtNem9sNzUvTzNZeCtR?=
 =?utf-8?B?YWJzVE0wVWFiMVNyZEJYQWc5eEQvcG9YemdTYTMzU3BZbUM4V2Z3VVo5amZJ?=
 =?utf-8?B?NkJCb1VNb0pnSnFqd3M4NVlGK1hwQTVoT1ljMzJJUWtqMVRlck1Fa2ExK2xx?=
 =?utf-8?B?aFNIZExNMUlkU1UwZ29SSi9vcXN2SzVzU2NKaUVRTktYUFk2Q1ZsL3BYbjZF?=
 =?utf-8?B?SjBvd2NUcllma1RHU20xbjdzc2E2V0wrUWtTM2JPOTJnZjU0c1ZFYWQ3Tk1K?=
 =?utf-8?B?Rm9mZEIyRHNDVWQ1M2JYd0R4Zy9QWGFXQkJ4VmxyOVA0SFVvOEVQeUdZbFIv?=
 =?utf-8?B?Qkt6ajRaQTVmajUxaitxL3RNVms4MzlWVUF0aUxydzJjK2F2aDdpZEFqWG1D?=
 =?utf-8?B?azRFejhyelkxUW1vQmVyRjVLVmYyTDF1ZStpSDVmSW5qY0I3OWM0TWdnZVBF?=
 =?utf-8?B?NTYxckFua0lFek0yRzlRZkFkUTAvWHpFRW04UnlCOGJNTGh0Yk5qdDhnZU0x?=
 =?utf-8?B?N1FDS05NUmd6WG5EVG1VOEJJTnVadmkvM29jeHUwa2ZaQjY2SHVidmpmUjd4?=
 =?utf-8?B?S2VraG1ia0JiaG1mTVJnSG9HYlEzV21Ec0pDdmczZmpYaWlVamRrVFlyQzh0?=
 =?utf-8?B?a3ZQTU1yd0N1QmZXdWlhNVFXWmF6eWF5UFlBaE55R2V3Y1RPM1JsZTQ2QlZy?=
 =?utf-8?B?Y2dXcWg0bGFHVEI1ZG51Q1o2b1o1eTYweDdycjBrd04rUWQzRFhSdmN0aTBa?=
 =?utf-8?B?aU5iNWZnWmFpd2lhdjUxNU9FWXVLNEVaWDFselphZjg3SERNM0ZMSER6VS9I?=
 =?utf-8?B?b3BkNEVHcU5MenpJSDBCck96NjRIZlhiQ1lyVWdxV2Zmbzl0c0J6MndjLzQ1?=
 =?utf-8?B?SHZNaUJPakhOOVBnUTVCalJad3o1N1FldXZlTEdJNGFuVVB3UUVxU0EyVnRL?=
 =?utf-8?B?Z3JJZFdHVEs2SDl6WThsVlBMdVpYN05WNzhHbWNDVzlxV1llVWIwRXlRSllI?=
 =?utf-8?B?MHFFWjd4elQ0UElIVzBCbFNuUG16L2ZDT2RIZHhsSTlNaWpCVXF4OUV3bEtj?=
 =?utf-8?Q?ufjOicLm6fCp6erUZPaPe2l7J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A822BE186B05148A5FB849D52D505D7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5446.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe64e99-3890-4cef-7944-08dd088e25a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 11:34:36.5948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQOhWxU4KGDqgeM/Ka32Ep9+b5cDjj49rwSBAFzv5Al0nixRGsuRvo4SAMNJQ//5lr/VN/1jr6mUZlegvHoZbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4988
X-Proofpoint-ORIG-GUID: 7Qj1lX2g7H--Jdd_tzzTC8Sre43lz8ep
X-Proofpoint-GUID: 7Qj1lX2g7H--Jdd_tzzTC8Sre43lz8ep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=710
 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190083

SGkgVGVhbSwNCg0KQXMgd2UgYXJlIHdvcmtpbmcgb24gZW5hYmxpbmcgR2l0IG9uIHRoZSB6L09T
IHBsYXRmb3JtLCBhbmQgd2UgYmVsaWV2ZSBpbnRlZ3JhdGluZyBhIHovT1MgbWFjaGluZSBpbnRv
IHRoZSBHaXQgY29tbXVuaXR5J3MgQ0kvQ0QgcGlwZWxpbmUgY291bGQgYmUgdmFsdWFibGUgZm9y
IHRlc3RpbmcgYW5kIHZhbGlkYXRpb24uDQoNCkNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBndWlk
YW5jZSBvbiBob3cgdG8gcHJvY2VlZCB3aXRoIG9uYm9hcmRpbmcgYSB6L09TIHN5c3RlbSBhcyBw
YXJ0IG9mIHRoZSBjb21tdW5pdHkncyBDSS9DRCBwaXBlbGluZT8gV2Ugd291bGQgYXBwcmVjaWF0
ZSBhbnkgaW5mb3JtYXRpb24gb24gdGhlIHRlY2huaWNhbCByZXF1aXJlbWVudHMgYW5kIG5lY2Vz
c2FyeSBzdGVwcyBmb3IgdGhpcyBpbnRlZ3JhdGlvbi4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGFz
c2lzdGFuY2UuDQoNCkJlc3QgcmVnYXJkcywNCkhhcml0aGENCg0KDQo=
