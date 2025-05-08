Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010006.outbound.protection.outlook.com [52.103.68.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08727CCDC
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716889; cv=fail; b=oBzx+WtNdMYjmpiF/V2dvdgw3csukc7EKXIgk46CwLXuVY8A4hn7nbHAiJV4ixMas/S2bXyygY7C4OqWOUnV4RBzvDRCS4z607dihEOs18M64JD7v/c885S2ApTVNGmU7HXpfYS7oXlwDOqDTMrM8mOBaclL6Ni941NirZUH1d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716889; c=relaxed/simple;
	bh=BQL5hkyD4D9nrXRen0HHrBlQUfpUV7OwC6EWHe8pCq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AL7XWpjyZbkdjAC1oepNu+W9ln+q9kIOXbmzgJrGQVGe7dipoJah8wN7+YGd/Y08KaZJmR9a763TTfegk0E3W5bYOAa/M1WKlJblh1bZxNiF6/0w3937BBG3FY9L5dbPxWhQ6uqhtsm+g0WTLrZ5pwJhVNsqyYCBCV6H/rAKixM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=o8DWMTp8; arc=fail smtp.client-ip=52.103.68.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="o8DWMTp8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABpb3P5HlAokW4eJEW9UWxv3xOsBw4alxWFstpUgAGBnPfOlYNffheOOp97ZIAiIcQChZG7tbeKDnHHeUgm1lKD3f9NJRTvbmgkRNEm97VzMP4EIZ/uhBBvyABwQuWOVW8oYYx4nDw9+CHKGz1rzRsQCR8v47BsmeKydBbEai7ZG1VjOuBbGFzIWAFJT/YVsT53eCZ0n9sQBU3Rn9C+H3sUTwRnVBdUostpi2VmX6OtkcKCEkj8PrnOUdiqg+PqgmGVKYaJ64dA9Dpc6iADLlfWZ7y/bfBm44Pn17+up2Wh90uM/2tkpt4T7lJrP3+x7MvYUzKD6xqDt1+JGCqMk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQL5hkyD4D9nrXRen0HHrBlQUfpUV7OwC6EWHe8pCq8=;
 b=WsNyMupzJLM49l3v4JdjMxXHM9EAFydjK9Uzp1/BYCHy0QgRW3bql9lgsWPFtNr2dpJboMumgC8/5RBXoQjF+bngfWQK77QhdRy62OXzpvIuxLgnATDY+4BLpQqJTIUsShuIAA+dj/jRlHHYDHYZEgqDJ9+8eF8fDts5dx6JOcsLW2FaN892+di/Kz3MBXmdXD6+vFeY18sSD4EEq2P6GThCl8x2sbAD+SFQya//XhiPhHrhOd87S53OdNeZTKuLRy2Bol9wp6eGzoBVwR3XtX60bCcKXK/1Gtvvy46PTASVR4ql1KMeLeyYSuQxt809wQ2XMbOKeBevbBCTKMOxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQL5hkyD4D9nrXRen0HHrBlQUfpUV7OwC6EWHe8pCq8=;
 b=o8DWMTp8kTukzDEMD0FDEOLESJ7NLQopFnzwpYqH+z6QttXnlI8/bVQE2jIW8txJhvNpQM12yG1/huE/B+6bCoVcDhqZM0sxbvXyJ26e0+BshIHjCYelwQ+ppjI0Y/gz+ldtWWXDaQ3QRth1DvjUJc+IPLDREPTbzvKUPb/kRofDvGSDO62elMXgsrJGoZJwo5uBPw8/jkz/yoaksuJ/NjvZkZFXQa9RdWjaomuZNJNSh42sTfvvh1sjeLVI1cl4GI39eP/YXYlaohiQK4BAh1GultiMJzePDNWI4+ifMaiS8JqNnRrpWRtDkkPMNRgMukqRloPg4RXGA9MZ8213gg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9010.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 15:08:01 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 15:08:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Topic: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Index:
 AQHbv0zFVjfsAuRfzESA3EiZEdhM8rPHvkVHgABWFBmAAKjMt4AAFhK3gAADX9yAAADJ4w==
Date: Thu, 8 May 2025 15:08:00 +0000
Message-ID:
 <PN3PR01MB9597E7D76464369382B38B53B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xicawp4.fsf@gitster.g>
	<PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqwmar8bw9.fsf@gitster.g> <xmqqcycj888l.fsf@gitster.g>
 <PN3PR01MB959761BC7EF27EE2CFB1134BB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB959761BC7EF27EE2CFB1134BB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9010:EE_
x-ms-office365-filtering-correlation-id: 8cf5c41a-b957-46bc-1cd5-08dd8e421fca
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CNu8Yb5bKtMXD/64tRSUjMJpvbRkaQ3y34cPJo2V32bVxmLHvtLkx+bsEA1rqtQSbD9DRhZIVemxXicEc5UqyKe4KMdFGAoSWmyCkq+WHPAsbcZtV/XiDVoXRR1/xhnc94ReBkD1xKqDGsg9Gs/W6a8FdBvKm2YI3KmvsvX5dQ5v08TZJKGDyRMCkUyS2ePVutI8qm9Hz5bWQihrHnfMgKsi4Kzo13Ze3RAB5+iWrKRDRHqraRs+cl2NWT5vcv1XtJYyxyrgE5ipVZrAhN4vNBearquK55JK5A0VoVc2/+qbT9/kRg97sPcXtgfmFuAEcjplMcl0TjmRtTGOPPxBz9oYENtdfTvXrbeKe7CQgAXEZA7VYWfC37Yyf82xhbDIx8FhnnGLhhkYki5av+KjZOKlcUX8fnSfsmKMywWYhvhVMM3ec4v1Y+2TkUJk/U5sXtZH1Kegwj/zynxxVBQFyl4r8JXi2UzlKun/hKGeIotRQu1RpRaKlqWwuDV9BT6thiGjzANmuY/XhI7MO5SW+BjZ1SvhFI1VNlThytWigeJy9dFLqtUwdOi2QiphHRDtsU2YjzJSkDqTbi7LEUF+RWNCkENICCF6Wj4/b3MMWL2lVRo3bhuO05Km1VaHROJCqHLuLwNgjd42lPyNSCgxgT3xaHeo5HY9MEajHxUmiPlByT1J14aCX89wA01JPkx70XfZCpasDZDMmZCjiRWVH+ArFZSyt5P4f
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8062599006|7092599006|8060799009|15080799009|19110799006|461199028|102099032|440099028|3412199025|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXlMUlBrY1FLRW92d0lqT0NlclZTQjNXeFZzTE0zRExDTkZlbUowQUxNVUoy?=
 =?utf-8?B?bnVaZ2h1c28zSGFSY2dnNVovUyt6Y1d6Y0RjZUtlZHFyY1BmMlYwamx1Mlgy?=
 =?utf-8?B?ZDNrWElHUm83cjkvYlZZdm44M2NWRnE2NEpQUWRjbzFJUGZPVFB1a0FkTnFq?=
 =?utf-8?B?ZUtCdkZySGZFbm8vL0xpMTd2VktHY2NMRkxuTitUaUNtNGhtN25pUjhLR0xR?=
 =?utf-8?B?UStoc0ROcEJSbkJ3azJsMXdrMG0zU1QvMkh0TFdud2tLTTA3bXhBRTR5Uzg2?=
 =?utf-8?B?TDl2azdFaEhPTTF1dzJFdkdacnNmbStSRG15eUp5WnNLcnlFSzVNdnVuTlZa?=
 =?utf-8?B?NFdnNk1pUXlVUWV5b1EyNlFMdEhvSnFpZjhJNVdjL0l3STcvSnlRZ29CZ0Ey?=
 =?utf-8?B?dXhOaG5mK1o4ZHBLRk1qenFQbzZRL2EvaTY5d2ZJaXlRcFpFby9pSk5Eamtj?=
 =?utf-8?B?VWFaWVJFeGpVVWZwOWlXenN2V0IxeTdWellMUkNTTVhoYTZjZnpLN3ZnKzZ6?=
 =?utf-8?B?MWlHVFNhOEhkOUxQOFBOSHUwZWlIazh5cXE2QlRJOTJuem5tNkpNMHZwdkFN?=
 =?utf-8?B?NUZjYTN1WkNpazMrWTlxWXlWZFJJTWJIYTU2R3dtQi9iSzAwbXpHMFpJZnNU?=
 =?utf-8?B?emozYzRWTkw0alpnQ2Z3eVh1T05TYytSNklyUzVxZkxQbWVpbW1iUnZYdDQ4?=
 =?utf-8?B?WFk1YktHR0R6TEFpQW4vRXRTV20raFRNZDFiWjE4MmlRVG5iTTQxczFSVHkz?=
 =?utf-8?B?NkxKc3MyV2pkNE4rczFBQndDV3pka3hHNXp4RGEzNExpNk1ycERCQ2x2bzRK?=
 =?utf-8?B?MGVNQXUzRklvQXRvTEI1Z0VEWnAvNFpIMEJ1R2NMVzNDZnhtQnBtUzJydFBB?=
 =?utf-8?B?d0RQd2FyZml1OGk1SFVwVytJcy9YaGdZVWoxWk53RGp4Q0hvMjIrWURYSGRQ?=
 =?utf-8?B?a3lPNEZhV2x4NHlxNURsbXNCQVlMZk1icFpMbytnTDBsYm9GaFc3ZFowS2Rs?=
 =?utf-8?B?QmlqaVo5TW9VQjB4MnY2TjJZb2pOWGRkMlhhdEl6YW9sT3JwWTNscy9qZFp3?=
 =?utf-8?B?UDUwRHV4TDgxbnk3SkJsbFF0ZlZPeHYvV0NGUG5HOVJ3eFFpMjdWN1E2OXVo?=
 =?utf-8?B?U2NMOGZpTkRCUlhGSXlqL0dmaXl5TEZzRlBjSHM0NkxMd2hXOTh2b1hTWGgv?=
 =?utf-8?B?WkpoaUs1VWY0STMzUHAvSXNqWU5XV2VSWitxU1ZZWGJ6L1hyalRiNzR5T1ph?=
 =?utf-8?B?WGVCR09DUUtlMmhTKy8vcjlHdUszYU0zNVhPeGh5eVY4eC90NWFWNHFEN2JF?=
 =?utf-8?B?V2V3OEg4bVRHSk1kOXBVYnZBalk2VUVuVHFHdVFIQXllVmpQOC9JaFd1ZGYz?=
 =?utf-8?B?OTVvdmN3aXJBZVRvQURaMStQRG9ZQ2l6M09rZUdTVkdvekdHQ2hPYWxOTzlv?=
 =?utf-8?B?SG1lK1VCRVU4d0g3KzFhY1dnQmg0anpoeloveTZQZk5BN3MvT2pJaWNDdDJy?=
 =?utf-8?B?bE51STBoNlhGOEhOWXRKRVluZElxVE1UWFM2amgwSEVQVkRzMlMrenphUlJS?=
 =?utf-8?Q?9NmqmXTC8B+CqgPpxT1QbgGLUa3wnkzg4XH7ay89qbFaxo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm5yTlp3Y2Rmb3FDWFEzVEkzT05reUNKUzZVRUFwZ1U3WHhKZFdrS2hnZGlN?=
 =?utf-8?B?Q3YxUTI5VWxYbnQ2dUkzLyt4TWMydGNNRWpQdlZHc3lJcUw0cFc5OGM1eGJB?=
 =?utf-8?B?Y3ozR2dtODdUTnMvQ2RVMStKQiszVFFBWGVVQVU1RFZqdFRvRnNYV0t4MWd0?=
 =?utf-8?B?QXRxR0swUXJPcFdvaTZ0aytpQjZXSkFJMGNMM0lqZXk1Sk5idVBvTGltbU4z?=
 =?utf-8?B?bTBXOS8wYXBwRy9FVFUvckwyR1lKYjUzWG05UWN6S1UxU1BBYUFXeTlNSG5K?=
 =?utf-8?B?UldWYmpUVzl4NTVNKzgwOXM2Vms1akpWaDFaTlZWVXZYVlp5NXJIR3A1bkVj?=
 =?utf-8?B?OXYwMlB6WVNVVDZQQm1sRStFbU1OTHRFMzF4U1BRc3p5WnhJTVVHNkpJc2No?=
 =?utf-8?B?VlpneStYR2xoLzhHVFo3Q1VneC80d1F5emVCWGRxTlRTMUpyMlFvQ1pYbTh5?=
 =?utf-8?B?cW1NYmJwdXErL3YwRGZDUWRFVk5tUjR0UGw5cWt5cWt2WUFjbUp4dThYWk1i?=
 =?utf-8?B?ZzBOZDNRNUw3R0EveWxCbVRYR1ZCT0xzZmdzSWhjNkkvNnpIWkdEdkpxN2hU?=
 =?utf-8?B?bzhWVVpmcEt5NVkwa1VGeEFnUVJQbG41TktuN3owOHdYWkZseDFuR1JmZWlH?=
 =?utf-8?B?OHdZbTgrZVR3Y0daNm9zMis2SldaRDJTck5sZGdGOVA4WnZ0K2VnazB1T2l2?=
 =?utf-8?B?VnRUd0JnZ1hVMm1oaVRyb05ydHZ1QXFqR0hpMzZkOGxBM3pRMUpNVG5kenli?=
 =?utf-8?B?U004eGQrWXhWaDhUYXR6NytOeVJiZCtFN2MwTFl3RndkWitjOXNCc1BGVldK?=
 =?utf-8?B?YlkvR1drSmV4aGYzSGV2VWt3N0Zwb1BJTkdDN0RNVktjQmk3bEcxYy9hSTlV?=
 =?utf-8?B?QklNcm1QWCtOMWpjWXVHMU16SGFCYllUOXpxWnZuRWxZMm1OeFdpck9nZDJq?=
 =?utf-8?B?QWRjUi82dTRxTEVNNzZwSzFDeXMySjhuZUt5dEZhRlNXQnJjVGRXZVovWlov?=
 =?utf-8?B?Umt6anFTVEJjcTRVeUp3dGx0NWpYM0dSWUNzbHV0TVNYNjNvOUZqYnUxczhG?=
 =?utf-8?B?OGVaWnJvSUdPaWlCZy92RXNneFdocGFLbzVaMHNHS0xKcVZGN2J2eVdCby9N?=
 =?utf-8?B?bHNIMlZPY3Y3bzJIblJYZ2VQM1hoa3ZDT01mTlJORTdGSVRGWXRTVUhiQjlx?=
 =?utf-8?B?RVNvWmkyVXIyWlBDMlp5L2IwY2FJTGxRN3JhZlVKWkRQQndtaFJ0MUgwekJs?=
 =?utf-8?B?emVWT0xVekFDSFpHV0ZJbCtDOVRKUUkra095WGVQMmFxRUV4Qkg0SGJZaFdP?=
 =?utf-8?B?MDJRaTdFVkMrRDlhd2ZuMytaandUU2twaTg3ZVBIRmJUdmlSaHpMeS9GQ2R0?=
 =?utf-8?B?VVhhLy9FbHhCcE1zNFFwbE93OUNISDRDNGtybnFoRVF3Z2dGOSthMGQ4Ny85?=
 =?utf-8?B?VHc0ZGF3d0JEcUNxQWFDNzF6UDNvaWhCSjN4K20rZFkrTGs0eHBPSW1od1g5?=
 =?utf-8?B?SUdVMWdLUHl0Q3RqaWE5VytSU0Y3UFhYb3ZBM09GdU1EQ3MySGp5RkNzbDRO?=
 =?utf-8?B?Qk9EUWxGdmxPaXNvZ0gxVzM5LzVIOGtYZGRCcy85SG4vVTJVN1NERDY1bDVB?=
 =?utf-8?B?NmVTVnNXWk96YllrV0NYZmNsU3A3ZDdETmVObEFBRkI1SStEZ05Xdk9jS1B1?=
 =?utf-8?B?T2dnWXlQMXE5Wk13NXdPL2RoTkNkdVRhOVNZdVdyOUE1ZmUyUDRyTDc4MlpQ?=
 =?utf-8?Q?O2bCqIGLnyuYBbdjdQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf5c41a-b957-46bc-1cd5-08dd8e421fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 15:08:00.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9010

DQoNCj4gT24gOCBNYXkgMjAyNSwgYXQgODozNeKAr1BNLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5
YTA4QGxpdmUuY29tPiB3cm90ZToNCj4gDQo+IO+7vw0KPiANCj4+IE9uIDggTWF5IDIwMjUsIGF0
IDg6MjPigK9QTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToNCj4+
IA0KPj4g77u/SnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cml0ZXM6DQo+PiAN
Cj4+Pj4gSSB0aGluayB+Ly5naXRjb25maWcgc2hvdWxkIGJlIGluIHNpbmdsZSBxdW90ZXMsIGl0
cyBub3QgYSBjb21tYW5kLg0KPj4+IA0KPj4+ICJJcyB0aGlzIHNvbWV0aGluZyB0aGUgZW5kLXVz
ZXIgd291bGQgdHlwZSB2ZXJiYXRpbT8iIGlzIHRoZSBjcml0ZXJpYSwNCj4+PiBub3QgIklzIHRo
aXMgYSBjb21tYW5kIG5hbWU/Ii4NCj4+IA0KPj4gTG9va2luZyBmb3IgIl5NYXJrdXA6IiBpbiBE
b2N1bWVudGF0aW9uL0NvZGluZ0d1aWRlbGluZXMsIHdlIGZpbmQgYQ0KPj4gYmV0dGVyIGRlc2Ny
aXB0aW9uLg0KPj4gDQo+PiBMaXRlcmFsIHBhcnRzIChlLmcuIHVzZSBvZiBjb21tYW5kLWxpbmUg
b3B0aW9ucywgY29tbWFuZCBuYW1lcywNCj4+IGJyYW5jaCBuYW1lcywgVVJMcywgcGF0aG5hbWVz
IChmaWxlcyBhbmQgZGlyZWN0b3JpZXMpLCBjb25maWd1cmF0aW9uIGFuZA0KPj4gZW52aXJvbm1l
bnQgdmFyaWFibGVzKSBtdXN0IGJlIHR5cGVzZXQgYXMgdmVyYmF0aW0gKGkuZS4gd3JhcHBlZCB3
aXRoDQo+PiBiYWNrdGlja3MpOg0KPj4gIGAtLXByZXR0eT1vbmVsaW5lYA0KPj4gIGBnaXQgcmV2
LWxpc3RgDQo+PiAgYHJlbW90ZS5wdXNoRGVmYXVsdGANCj4+ICBgaHR0cDovL2dpdC5leGFtcGxl
LmNvbWANCj4+ICBgLmdpdC9jb25maWdgDQo+PiAgYEdJVF9ESVJgDQo+PiAgYEhFQURgDQo+PiAg
YHVtYXNrYCgyKQ0KPj4gDQo+IA0KPiBJIHNlZS4gU2luY2UgeW91IGhhdmUgYWxyZWFkeSBxdWV1
ZWQgdGhlIHY1LCBjYW4geW91IGRvIHRoaXMgY2hhbmdlIG9uIHlvdXIgZW5kLA0KPiBvciBzaG91
bGQgSSBzZW5kIGEgdjY/DQoNCkd1ZXNzIHdoYXQsIEknbGwganVzdCBzZW5kIGEgdmVyc2lvbiA2
LiBJdHMgbm90IGEgYmlnIGNoYW5nZS4NCg==
