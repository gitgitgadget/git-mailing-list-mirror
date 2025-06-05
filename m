Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010001.outbound.protection.outlook.com [52.103.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F0221278
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140258; cv=fail; b=jasQCtleceJvvwbzf0T0H75UBYaVFfGXfpeTAiTYJKpiaLASfQB75GsRcl0EcEFtX9mq+UzlZ+Rk7hchnlRfnCMwWVFoLF0UqsD9b+BtETHRyY1B8vbaU0JGy7+F0A0sFm3MCQsbAdtD1OLqlN7lUbfYg3gFPHHWpxAJa6NOTP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140258; c=relaxed/simple;
	bh=xE3XRZIcbtMmi2rR751JNEGQmblJxWTd0DKGadoRq74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pINBUqaqTmQ1Yl0l8OWoKzQ8Y7GeovJvl4pbd675XBslhGqUWFQF6X6PMfYp4hiskJnvnQjPv0vSrkHHW9A54GYwAB+Lj9kImMeNSqrCNEl8peVJMg8VFHtw1wM1EmAfxxjKkkYDWF70B8GkPnVGYuYyKK0Q107fA4n3cmHyRos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MbNtmvxA; arc=fail smtp.client-ip=52.103.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MbNtmvxA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSP7U8SJJ1uz+c/nEy00r4JTbAFBuB+68PrqnBq/DbUdAOaqGmWPug7a9f+l7ahk5pJvtH8lG2LwSw0U5BnCqvH2WuM7gqggFEBRgreQIquXNfDivig6QwHVcEq6ljwb9r8LeDJC8ZhOQCZG2BwxtB3BTs0eBvVkTH+U8Z3Ykpepej4GYs/fS11omziVvjcfDPHaf5eav8ErIBz7JJhFUVYJ/1VIHD/Q2EGzbePvl7ekGcPOFtEWROGO/In0Wq98T/Qvvce0RykDNWdY3I2O7OU6zTlQGbMMkf1/RfXKf09ck0+cfmQx/cwA4Nb8u/rUreVnIo7du/ddlJzsUwe10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE3XRZIcbtMmi2rR751JNEGQmblJxWTd0DKGadoRq74=;
 b=tUXtuplFog5B+yW6mnFudoTy82wK1+a1Dtc3iRVqGQZ/W2fpjs8v+63TPE4nofAHx6fKMpH4g/Rk3aq6+UQdpCWkvf/y7LBfCd8jHTpKGlcNvDhsIWOPPhiW8lhwRj2JckVyUw1VMMyPwYadllgGjUdfht55YtpPPEzIK7euqBFrcAwP4vpj7EqceW4wFDePzqcWQk/hSO+45/ELA7Do4HjyMzNo7tkbqzCEM4AgXTOFCp6VEP10SQVEbFat3nMn9y5l5cssujGEx2X1HbB8nBBCdj0SbsytfbZ3H75J95vmMY466UVWBdCM/j7TMqtiVpnWFZ7wrOTC57cBIEkwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE3XRZIcbtMmi2rR751JNEGQmblJxWTd0DKGadoRq74=;
 b=MbNtmvxAb20Bgbw0i7ahgvW9peWZW1nTuEw+33lLdzmITuJ7E8xUpFu7P2K9PSHN/kbHXCJz1B5ToCBd4A1sUE96H+i3vLHqfYagYkQ7SAqYl0NM3erfv7cwBVdYpwXSEvH6rrK4LP7eu1jgc/BotMGU+zaIigq9WicVRZJnCf7Bk5LlPVdZ3zk7r9RtJl5k8w0tkjlJ+JICDMN1XSCVOF9RStFx3+s/g/nBKI+SsxwTndW2VoBz2N1u5k97wGzpQkxb19fOtmsQvu1bsjASuKTb3FfZbO7n+rUWIvJsPAHcF2BuyjStnrvACi+IusuW5dJuSG00jLuj9U/h1Vx8VQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN1PPFF5E7FD5B9.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::331) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 16:17:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 16:17:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Jeff King <peff@peff.net>, "git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m
 carlson <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v12 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Topic: [PATCH v12 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb062L/UXncuPtA0+SwhNYd5wiKrP0OFMAgAADlt6AAITvaoAAAnkb
Date: Thu, 5 Jun 2025 16:17:31 +0000
Message-ID:
 <PN3PR01MB9597690D45F0E539C35FF4F8B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D1C148578224A02B9773B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250605080002.GA2998537@coredump.intra.peff.net>
	<PN3PR01MB9597EA7301052F34B6FE3E48B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq7c1q9nnm.fsf@gitster.g>
In-Reply-To: <xmqq7c1q9nnm.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN1PPFF5E7FD5B9:EE_
x-ms-office365-filtering-correlation-id: 6e4de7ca-82c5-49ff-7077-08dda44c78ff
x-ms-exchange-slblob-mailprops:
 7qh87CJt6y2tH9BY0XRwiamIXkV3jL/pcQVVUylVahR8bl5ivhr229oCd9MLZF7gqJp+kNAlSrkkMhV8aUsFECXv3fxVqVpMzyXE996itcJ2yqfGIG6yP8Km844DbRq3i04WuQ7YOcjtYKNi1FYDdBtt9saZg9jJnIWcRVYyY5bccdFjVtf9IWJbLNS1YxiVGlLyjZwLoni4zpkIWajHGwTakIMMfkSAzZ6oWSVlBDOz09rKGmKjqR6vgGAXfOnpUHtNTEWUUrrlOluGcMuZVV+bBbHtyLt42+MG9W1Vdr+y33RjZ+FnmhbH00j73wr5bpBEn06b8jG0VPTxXNc+oV0jl4atEbXagjAOs5ugqJY7FHfNKlYsz2EY3TXarY8MnfVTt+A3sJNeJvitYaDy0Dvsol7z8JmuFCZ5mr2JFBibtayIQadFKEdhRPoEorOQrc9lE9JfXZd3EFxZlbyuXgyUZX7FbAQJSEhydkvN/bV3OIT7kaOQfFWmErc7taek7Q6hwQ7SvfLJjyRa9SnR3E2722XjYHqoqJBQcGYqZicerN+ElwwPxQuOqNSctN6bakAZykMK3dyqQ0xPNq778DCiYcnJbNIXHtcur8usyTklBKQzhTTMIJjeyQiP0SP0AHkYVOm5fAwmtda2F/Q9FBX4nPGZTB1jVKlbfnd9V0nWIBdMXu2PaLBkKzOa42Z/CXh2JPQziAv+9yjWj7t6PRydM5HpX8TTO0s4/x6s2VOu1KDQzR64i5WHrT0ep3gZ
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|41001999006|12121999007|6072599003|19110799006|7092599006|15080799009|8062599006|8060799009|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk8rdjlGbk1sQkZiaGVvNGRKQnVWdzFmWUJBTUkwa2w1YlFST2NRRkRhOWpU?=
 =?utf-8?B?NWlDNTJnNXByaGJMSzV6am1wSTRmamJDVnI4UDdobllBV0JhUHAza0g3em41?=
 =?utf-8?B?dDdGMUJQdTlvQUQxM2lqWDJkY0VqUFV3by8vZWdxMHNoekdGQjIzUWsxd0dB?=
 =?utf-8?B?YVRqOGljRFN0Y1hCOGkvdlFxVHFSMXVlZUFQQ3Bwc3pieVVrYTdnMDBkRDJv?=
 =?utf-8?B?NjVNMDY4RTBnb081VjFpeGhVdHZSbEQrWEpMcXN4QVFkWE5NcnhJdXNZbnh3?=
 =?utf-8?B?d0VxalZUVWtvcmw2T2tZemNsNnF3YWE2Z1lrMDJHOG9ZWW9UcDVJWEdtb0JD?=
 =?utf-8?B?WUl4U1J4QzY2RGxFZFNnUHZkT1JzODIyWmhKNnJRdmZVV0JYWmJwWStxMmJz?=
 =?utf-8?B?UW01S21Cd1NGZGQrUWFOeWg2YTdpVTRNeGdubm9oSTUrT3RPVkdjOVJ6aFZJ?=
 =?utf-8?B?Nk02d3RDSnNUZU11eXpLaTVLd0hobXRjRjJpQkEzYW5HVVRKY09zUXZ0TXN2?=
 =?utf-8?B?QXgwNmh3eUQ2OWViTWhxblNwMGdWc2kxQ3NsaHVkQm8vQ1Y5Sk1KTlRLcjF5?=
 =?utf-8?B?M3VEWERwQ1UzeVl2T09yL0hZZGZ2bXk0RThoU2VleFBmZ01RTHAzVEdsai9X?=
 =?utf-8?B?bzIrYUtXVVR1WHhWZVdUMWlnMHhudm5ldWh4VVlqMnNwWXNsbXBpRzd2ZDhm?=
 =?utf-8?B?UTErZVIxL0xmdG9BL2hUM2hBZEhHWGJ3b2psMFdHNDNLQmFTc0d0R0l1Ty8x?=
 =?utf-8?B?L1JtUFBBb3VGQlhsQmdTU25kNHFVUmZSeHpibnRZbFZtamc3NmZtalJsQlJH?=
 =?utf-8?B?TFE3NHozeEd2eEFvQWlFS0lOTlQ3bXNUbU9XRGV6UStWVUVYSmlIeVNaVXRV?=
 =?utf-8?B?NWtaUUkzV3NxZ1F4Y0VkR080dUJWNVBvN054SklHTUZrbTVHWXk1UE0xNEg4?=
 =?utf-8?B?MnVvU3k4UGxXeVZRWU9LMmZYSXdrOGQ5dGxrYVNIUUpydFBNLzVJSVBUakVY?=
 =?utf-8?B?dkdJU0puek9TT1YyT3FiWGpHQUdmSzY0UmRDTnNuc3BpdUhMY0g0UklmcTNF?=
 =?utf-8?B?Vm9mRTJMcmlNZThZM3h3czBTR3dkQVR0dlkyeHJlejlaMnpCY0sySjJxUjRL?=
 =?utf-8?B?OUdTZitzSGYwa3FnaDc2b1RoYVN4QVhxTW5DUWxvVklNRjEwanZYbXR3SVRj?=
 =?utf-8?B?V3NlUUtnTEI5UWpHTHh0WE96d05LU3VOUUxHSGxDWTZFNzJTL1RHUmNPZlJy?=
 =?utf-8?B?MW5WVVZreWZ3Z2s0ZkQ4eGMwNks0NklKT0E5eWJpQTcwN0V3OTJOSXJpRG9J?=
 =?utf-8?B?Q0pvVjBra1Z3aHoxUkQza0JyM0N6ZHhHQmVvS3N0Y0p1ZTlqSDBpQlRCeGdX?=
 =?utf-8?B?ZWU4eVFMZlZyMGxwand5RGtsNFpoWC9wcTRkMFVRWjBLUmt2Wm1yOHhYVFho?=
 =?utf-8?B?TE8yWjVRNHA3NWFxa2VsY2Y1dkhPRzlBQisrKzdBb3BsTjBZMHEzdGxnbUpV?=
 =?utf-8?B?T1NydW1LN3NwcEZyaWFrU2o0bW85T213eDdGendjTUJrZDhRSXFSa1dkRXh5?=
 =?utf-8?Q?Cll7btbmMegjd/Ymx4LyE3a28Jst+S8LXPSsxMT4CIKGeN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rko5cWp0N0YwcDdoeDFJL0xua09Sb2NLWnF0NXlDaEhHbnlhT0l0bUhiWHNu?=
 =?utf-8?B?UlhOWDh6eXFTQnYyL1F1a2dzKzBaQWlWZWx4ZjA4U3dySDY0b3dMQ0J0amVW?=
 =?utf-8?B?cVNobENIVVVWQmZGR0l6dEdDR2RyZFRWV0pNLytMdW5RU283SnROOGM5NlNp?=
 =?utf-8?B?WFJQTjd3VjhMOCtsSUg4bG1UbUswK3ZLODNCOHY0dzNHdnlYV1pESjhRaXhz?=
 =?utf-8?B?SVpWZERhT3ZEckNjQURGSnVFRzkybFU2YjVJdWtOYjljdTB4Zjd1RVpvQWFo?=
 =?utf-8?B?OTJGbWRtd2h6clFIZlJRclZjT0xGYXZMbDVJeE51cG1tRmlwZkFtZVdpeCtO?=
 =?utf-8?B?Z04zVWlnVG1jVjdsa0FsV3E0VTFBMnlpV0Z6QVNpeE5TUEV3YWlGZFpNTEIr?=
 =?utf-8?B?QTZOck9YRGZtazVmT08rbmU1WVUxVHEyY1kraUdMOUFlSTFNZUZOSVcycjQr?=
 =?utf-8?B?N1ZlZ1FXN2Y3R0Y4TW1RTlE2TVUxM1ZIWmM0UDZRTE13WGhzNWxqWXBBNlNT?=
 =?utf-8?B?NkJMREJDQnNGQWhEOWlnOEpWaTVUN1k4ajRnS1BTdnhYRnUzYXZRSGhmWkRJ?=
 =?utf-8?B?ZUp0cml5dFgxRG9VVU85d1BzbHp0QURJMERIL1YvZUZadjdjVnd3cnpVT3BE?=
 =?utf-8?B?STd6QW5BSU9ncFhmSWdSQnNQa01FdWNBYkh4M3NGcDRvQUhVRXlZWmkzU1pR?=
 =?utf-8?B?T2dpQVVUVVVjMXMzbmFkQkFFZ29OSGZRQUZyeTVrcjMwNVRXbFN1Zk5qMUFx?=
 =?utf-8?B?c2lDR2tPWTU2UTZ2ZzhGMW14cE9GRHIyY29MZVN6Vk5EYnpxamxBM3hVdU9Z?=
 =?utf-8?B?NGN1UjlCMUViVGJzSGJZM1dzR3Vmb2piM3hzT0pUWW0rUXVESE1XUWp0YnlT?=
 =?utf-8?B?dVZMNG5FNWlFWjQ1UHlibTlFaGZXNWQwT3VOWXpmbVFRRmQ3d2g2KzNuQ2VJ?=
 =?utf-8?B?RERCRnpieEF1c2MzNEJjanA4MDlhWVVKNEM5cFRZMU9Fa0tTbDJxbnp4R3pK?=
 =?utf-8?B?Vy9OM2lHcHROLzc5M0ljajhPK0xyYWlKMUt5N3BOTklrUVRnMHBHWGhPcjVH?=
 =?utf-8?B?RHhmbUxjb3VONzl0UkdVRXlwZXpyN3dkcHJKTlByRTBhZ09UUDVzc3JlVlRB?=
 =?utf-8?B?TmVlR0d0Vlh4K2VXeUlkTE1CTkxRcEJXYkdCR3ppOXhZWjZ4cEM3cmt0Vm9u?=
 =?utf-8?B?U0R4ZlJpenBLQkF1amk4L0l6SFZCUWhxSlJ4bGJNVTBEYXlweDB0TmNkTWE0?=
 =?utf-8?B?cEg4VFljelVjQjU0dGZmTVo0UmdZT2JPWjZsalc5b0l6a2dJNTg2aUpSYnBh?=
 =?utf-8?B?UDlCdUtSZS9QUFR4M3RTNVF0WEd5S3pkTHIxZGJtSUorU1RMaDc4WU9wSTE4?=
 =?utf-8?B?ZHFwdWxhU21BUmRReE5vN3VSR1VHMVptUWoxZUVpazBWT1I4QTBvY2hGb1lR?=
 =?utf-8?B?bzZweTc5dDlSak1XNmR4bngxaU1ZRDBzdzhrRzNsc29vRVRneE1XcFJDN1B1?=
 =?utf-8?B?bEFYa1BTMVB6NVpJcTAyb3ZmblJPaXBUZFlqSU5ZcDZZUEdmTlFROXBDVFZB?=
 =?utf-8?B?bm1RTVpzWERVVEpLb1lJRXA3bDZYbmt5SE1UQi9Mb1U1Nm1ETFJGVnFZcFhY?=
 =?utf-8?B?MGRTbThMQnZ2Y0FqMmhrRC9BdlpIWGgzb3JCS3BmbFlkVE4wN3FmcVlIRHhx?=
 =?utf-8?B?UFNVZ010M1cxaGZjdnFNWlpDa01LVGdUZ2lSaDVwZFRXTnl2aXNTWU1Ld09k?=
 =?utf-8?Q?BUoBY60/IRwc/XNdSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4de7ca-82c5-49ff-7077-08dda44c78ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 16:17:31.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PPFF5E7FD5B9

DQoNCj4gT24gNSBKdW4gMjAyNSwgYXQgOTozOOKAr1BNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+Pj4gT24gNSBKdW4gMjAyNSwgYXQgMTozMOKAr1BNLCBK
ZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+IHdyb3RlOg0KPj4+IA0KPj4+IO+7v09uIE1vbiwgSnVu
IDAyLCAyMDI1IGF0IDA0OjI5OjMzUE0gKzA1MzAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+IA0K
Pj4+PiBAQCAtMTQwNSw3ICsxNTU4LDExIEBAIHN0YXRpYyBDVVJMICpzZXR1cF9jdXJsKHN0cnVj
dCBpbWFwX3NlcnZlcl9jb25mICpzcnZjLCBzdHJ1Y3QgY3JlZGVudGlhbCAqY3JlZCkNCj4+Pj4g
DQo+Pj4+ICAgc2VydmVyX2ZpbGxfY3JlZGVudGlhbChzcnZjLCBjcmVkKTsNCj4+Pj4gICBjdXJs
X2Vhc3lfc2V0b3B0KGN1cmwsIENVUkxPUFRfVVNFUk5BTUUsIHNydmMtPnVzZXIpOw0KPj4+PiAt
ICAgIGN1cmxfZWFzeV9zZXRvcHQoY3VybCwgQ1VSTE9QVF9QQVNTV09SRCwgc3J2Yy0+cGFzcyk7
DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIXNydmMtPmF1dGhfbWV0aG9kIHx8DQo+Pj4+ICsgICAg
ICAgIHN0cmNtcChzcnZjLT5hdXRoX21ldGhvZCwgIlhPQVVUSDIiKSB8fA0KPj4+PiArICAgICAg
ICBzdHJjbXAoc3J2Yy0+YXV0aF9tZXRob2QsICJPQVVUSEJFQVJFUiIpKQ0KPj4+PiArICAgICAg
ICBjdXJsX2Vhc3lfc2V0b3B0KGN1cmwsIENVUkxPUFRfUEFTU1dPUkQsIHNydmMtPnBhc3MpOw0K
Pj4+IA0KPj4+IENvdmVyaXR5IGNvbXBsYWlucyB0aGF0IHRoaXMgImlmIiB3aWxsIGFsd2F5cyBi
ZSB0cnVlLCBzaW5jZSBvbmUgb2YgdGhlDQo+Pj4gc3RyY21wKCkgY2FsbHMgbXVzdCByZXR1cm4g
bm9uLXplcm8gKHNydmMtPmF1dGhfbWV0aG9kIGNhbm5vdCBtYXRjaCBib3RoDQo+Pj4gc3RyaW5n
cyEpLg0KPj4+IA0KPj4+IEknbSBub3Qgc3VyZSB3aGF0IHRoZSBsb2dpYyBpcyBzdXBwb3NlZCB0
byBiZSBoZXJlLiBJZiB3ZSBhcmUgbWF0Y2hpbmcNCj4+PiBlaXRoZXIgc3RyaW5nLCBpdCBzaG91
bGQgYmUgIXN0cmNtcCgpIGZvciBib3RoLiBJZiB3ZSB3YW50IHRvIG1hdGNoDQo+Pj4gbmVpdGhl
ciwgdGhlbiBpdCBzaG91bGQgYmUgJiYsIG5vdCB8fC4NCj4+IA0KPj4gR29vZCBjYXRjaC4gVGhl
IGFpbSB3YXMgdG8gbm90IGV4ZWN1dGUgdGhhdCBzdGF0ZW1lbnQgaWYgYXV0aGVudGljYXRpb24g
aXMNCj4+IFhPQVVUSDIgb3IgT0FVVEhCRUFSRVIuIEknbGwgZml4IHRoaXMgbG9naWMuDQo+IA0K
PiBZdXAuICBJJ2xsIHJlZnJhaW4gZnJvbSBtZXJnaW5nIGl0IGRvd24gYmVmb3JlIHRoZSByZXJv
bGwuDQoNCkFscmVhZHkgc2VudCBhIHYxMyA6KQ0K
