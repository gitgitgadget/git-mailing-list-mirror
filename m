Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020105.outbound.protection.outlook.com [52.101.171.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4212DF144
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802683; cv=fail; b=TNR5D+mzkDbBc5UPVwF2fo8sf/zUrBJYT4VROYOOMmFI4/Cxxl1ZYD1N2bKf3hshZH86QAX+K2bCwnPIVXRc0HIUlH4/OLPt4qpuLzJ75mn19GhP9xytwg7ckOUfIJQrV4v06VQZqf+XWfE0d0kdaPFnxVgaODr4J9D9zoG7ocw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802683; c=relaxed/simple;
	bh=SRv/jDdgn2tFg+TbD13u3ztC2np+TEPenIewlamezeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fOz/uMKSa+oRASRoe7Y4qllbTLLcKWwX+xbXFhP3QcgQgROz28k2YFAKsmvfuIdliO2/0M97pCBmdA8bU7tDcso/Ptgw9uh6CHLco+E1sYau1t8JCWqltJe4jSlTArWRhluwpJGgGTjYJOBBUU8hrhKtnZR4lhKjok+g+/eIZVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jansen-preisler.de; spf=pass smtp.mailfrom=jansen-preisler.de; arc=fail smtp.client-ip=52.101.171.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jansen-preisler.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jansen-preisler.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgBDkk0Q0cwa0X7BOa0QNRcOZj6Z6pLsuz037on9vn/u06zciJBU8PD+4gGH1OVTJ7leQ784G4QtaJFZ1RKQGKT2KJ4UXUZuqqlXp/W6qDn5scZlFJULhs4Ae8Lj3K6w26Lc5fj6QjB++9baFrJJFpWxxf3WpDSN54qmsC+nMW1FzdWOiFhqmxZl2qAOpeXUKInMZ9JesIbA6CIjQL9PBdCK3he83GS+MPfxn3bF4EClKmpRy26+SnB013w4Yx36L1un1UpRUu4ARg4+WGq5EByPnyJeSd7y+IBbB/7HVSPDWMv+JLcIHQpmug0VWfv+zBfo8Jo7END9Z1SlXeO+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRv/jDdgn2tFg+TbD13u3ztC2np+TEPenIewlamezeA=;
 b=mn8nrulsfEMAD9b/ycpFDgf813ynlQ7aQycUmxEDy+XmByH//3bu7QYJ2jtaN1oQisF1m37Ue1SNpdUw9vMHiGKQcGsU7GW4VHeuAgxLfYZrRJiMVpYCdaPxXIiT0V6Y1VnYHXqdy7owHYHsPmgTeVZV0NuIlqgjrjtafwAgPKbnGMbgpQm2GCuMgK4HXXueGG8p464UqjCXQRiTe/v2/gyMHGiyA3LOYkebIcs94FSnbcxYlsaowmziv4hy6ewXjUAnggVoLOti24QOCYPTwfdxN4EWdqR219LgELNfCbQUce8GvEeFUBxadSpB6XwBEOv5SNFt9uw0eHnXLsc6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jansen-preisler.de; dmarc=pass action=none
 header.from=jansen-preisler.de; dkim=pass header.d=jansen-preisler.de;
 arc=none
Received: from BE1PPFA37683A28.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::67f)
 by BE1PPFAA9F3EB8C.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::688) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 08:44:36 +0000
Received: from BE1PPFA37683A28.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1b4b:e3f3:ad3:f3e4]) by BE1PPFA37683A28.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1b4b:e3f3:ad3:f3e4%2]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:44:36 +0000
From: "mja@jansen-preisler.de" <mja@jansen-preisler.de>
To: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	=?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, Taylor Blau
	<me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, Eric
 Sunshine <sunshine@sunshineco.com>, Bryan Lee <hi@looping.me>, Lidong Yan
	<yldhome2d2@gmail.com>, Seyi Chamber <kuforiji98@gmail.com>, Johannes Sixt
	<j6t@kdbg.org>, Ben Knoble <ben.knoble@gmail.com>, Lucas Seiki Oshiro
	<lucasseikioshiro@gmail.com>
Subject: Re: Draft of Git Rev News edition 126
Thread-Topic: Draft of Git Rev News edition 126
Thread-Index: AQHcGsatsl/VkH3JNkS8fmE4AQJId7R/lhCA
Date: Tue, 2 Sep 2025 08:44:35 +0000
Message-ID:
 <417d5e7725eac11750468f064e1e4f8ca06155c7.camel@jansen-preisler.de>
References:
 <CAP8UFD0Lh8caRsMV0nUB5Oge_hwLO_WWMAqxTqd8eY7mqwA-9Q@mail.gmail.com>
In-Reply-To:
 <CAP8UFD0Lh8caRsMV0nUB5Oge_hwLO_WWMAqxTqd8eY7mqwA-9Q@mail.gmail.com>
Reply-To: "mja@jansen-preisler.de" <mja@jansen-preisler.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jansen-preisler.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1PPFA37683A28:EE_|BE1PPFAA9F3EB8C:EE_
x-ms-office365-filtering-correlation-id: 7f76ccbc-49f3-4d31-0125-08dde9fcf21b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RW1DZ3VHWmIwR1JEVk5HM1V1T2JyQUZDVzRCWFZnVlBzZ2FSbzE3RVZ3cFAv?=
 =?utf-8?B?cG1KR0NFT092eDdaZnRpLzZQcURWVUlaNVRoSEtsSjd4c1NxU1k3NlMwdDg3?=
 =?utf-8?B?N3ROclBqWlJPV3ByMTJlb2VsanZLVUtndjVuaExVK05JMzRRTi9EOWVleUZn?=
 =?utf-8?B?OTV5MitzZXZzb1hRTEQ2YTkvTmFBRDNNWFB3eWdKNXdPaUMvV2FuaDh2R2hN?=
 =?utf-8?B?VjdEZk9LWldVblZJVG5mWVJhQTNsaFlSbHZKaEZWY09CS2RsbzJ0TGJIOTM4?=
 =?utf-8?B?bWdFdnhWalpvOXRzbC9nSU9iS2l3TXhPRG9VVWxRM05xazE0M2o0Y1phTGIz?=
 =?utf-8?B?YzBHTTBySUFmYU1qeDdHc2ZLc05JaDViRGVjQUkxRmhVWWZIc002S1VCU2ZJ?=
 =?utf-8?B?UDVYMlV4VjRKNFpPL0RLVFVJcTNpRTNTRjRFSDFEakpBNmI3Y2lCWnFwTTFQ?=
 =?utf-8?B?cVgwMnF2VVI3V0llMElOYWNoR01VK00yNmo3VXBCN1dvMjczaWl5TktJVU5T?=
 =?utf-8?B?d2JZNEE1b24rK29PV2lmUklteFJWcFlCNlpyMHZJWUo3K0NJdWY2YTJZZk1D?=
 =?utf-8?B?SlZIOHhqQ0N5NG0xQloxME1Jc0s4OFNPc0daZ2tsRWt6RUZoY3BEZmJ2QU96?=
 =?utf-8?B?YVRwMEpnend2d09YODFxQkw3UnV1bXZyTGlrUHVIRFNGaE5sKzhmTmtHS3pG?=
 =?utf-8?B?YUx6cElaZXZISEhWeWFPRWpyd1h5MzBTdXBPc1RxbENOL0htTEREZjViWlN3?=
 =?utf-8?B?Tkw0VUtWS29JdWx3YTdMQkRtblRyT0xtTDl2RGI5TTkvZW84SlNOU2NKWnJ3?=
 =?utf-8?B?ajZNYjBnSnFFbVZVSS9wWVdVbFRyMkdVVFZGMEVrL0VndkFFVktxQlVRVFo4?=
 =?utf-8?B?WEh3RVFhZjc0NEc1WWFtUXIwRXJrc0dDajN5Z1M5cTFyeUhKaVorR2MzcTNI?=
 =?utf-8?B?MzBLTXgxbS9icEZCRS9Nb2hqQlkyVXRsbnhPQ1ovek4wOStIU1VDV3l2akFT?=
 =?utf-8?B?T1pYZ2JkUGgzWUt5L3dSNS9jZnVlRS9kVFpPWWQ3cElPRTUrQzMxVUtkQmlx?=
 =?utf-8?B?a1dkOWxjUHR3S0JBUU1mUmlCSEU0dVk1bldLUHBmQ0t6Q1JhZW5qVDlkSnE3?=
 =?utf-8?B?UHpGMWphZU1rUGFRNWhOZWd5Wm9aVFZFcVdia1BzczRwOE5CN0FGME1NcVVI?=
 =?utf-8?B?TXpGWGxxRjZnTjc4RzlEWmxqMm9zTGI0ckhVSzlWZVVaNlJ6VlA2dVVHbkRH?=
 =?utf-8?B?ZzhZR05HYVlEaGlyQjVqTUpCK3RibGNKd0JsL2lVenhQVi8va0NrNFI5eWQz?=
 =?utf-8?B?MzFEak1yQ3l4S1VLUWhac3RnQUt1L1MzTUVjMWJnTGJZR1lHWTNSNmFhcFll?=
 =?utf-8?B?TE04OUgwL1RuVDBQa1VQZ3pnQmlEaWN3bzFLR2JzcUxFMGVxU0srV1c0U0pW?=
 =?utf-8?B?QXlCUldGRWZ6RjBsV0IvZitGK1JkUzZrZCs2WmEyVmtxYXZPYjdrb2grZ3Vm?=
 =?utf-8?B?TTNDU1A4eWU2TjdNN08rWUp1QWpwdkh2bEtwQzFQdkl2VXVOSUxMRVRkZ2RU?=
 =?utf-8?B?Y0ZBS2lDMGFLa3l5R1g3UkMzR2NlQlQ5RDRYSEVuR0xTTjA1NWJzNmpTWG8v?=
 =?utf-8?B?MmVjMEdJeVZNWFhpMmp2akdReXdRZVJJMVpwSElJWmlFdFpQRTFtdXhEN01h?=
 =?utf-8?B?cDE1K0VvVnRpVzdmZFkrZ3d0ZkErTnExZ1BkaS9Ja0VQZEQxcE1UdzNSZ05S?=
 =?utf-8?B?RDdoMzY4VzN1VE14bGdBOUFIZWdrTzBhMXhkbFJQQi90WVkzSXNrdFkrbC96?=
 =?utf-8?B?NDJOOFM4dTZkRWNGRktyLzFBalRHZ2czWU9iaDM5cDJOL3NxSXFTNyswb3I3?=
 =?utf-8?B?TUsrbXFoWVJsSkVpU0Znc1gzWU11ZE5CaGNKaGRpcFRLNGJwS0J6OThSVzZk?=
 =?utf-8?B?dEMzZ3R2SVRRU2tlQmxWU0hKU0FBVC90TTRoMnloTFRRV2ZHbE5Jd1A4Vy9w?=
 =?utf-8?B?NldQbkltMThnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1PPFA37683A28.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0JrMDN2WnFlY3dHaUNrRlV0ckZnZDhkSWNMNkh5bnZ2SXhHdTExSTMvMGRI?=
 =?utf-8?B?NERHTVRmeFpVenFTZzlOV2RFT0p1V1EzbGpXb09sd012ZGx4ekpJWW8vTlIx?=
 =?utf-8?B?ZDE0SnRnOGFYNTFKSzBTekVOdldKOTJGQ1FDZCt5WGNEQldOYjRvdk1pU0sw?=
 =?utf-8?B?RVJ4MERmR1VocVI0aHliR0lNTnYvMXFTQmNWbTkyck1YcE5kRVhrUVhWRUhB?=
 =?utf-8?B?ZjBqa3F4b2d2WnZ5dFN2Nnk0VjB6bUJUUlhSNVg1Vm5tY283dTVlSWRxQUlt?=
 =?utf-8?B?ZS9ZVmFLU0M5VUpCTXd5TW9rUlI3cDZmTGpQWld5aXVuQ1JubDRtUHhMN0t2?=
 =?utf-8?B?S2RsY1hUN1J0WTdVb1hubHBETmoxOXF2WVVlZG5tUldCUmIzNFpOWkZmYXRn?=
 =?utf-8?B?M2tsRVNrZW5Pang5czlJYVZRT01adkVQMUFhdTlYdHpHS1QrREJDTUdEeGJr?=
 =?utf-8?B?SlN1TlpoR2IwK3lDcEZnbDV1YmZlVEMwZEJtYUE2MnExTFl3Q0preEwvemtl?=
 =?utf-8?B?dVFubXVDRlVzSWYyOWFzM3h6aG9ldnJOZHhGU2U0VGdheFVadlRlTm9WWkhG?=
 =?utf-8?B?Yzd4TkgvRkloS0kvdWVRcUhJRWFvMHB4ZDcxdnQ1MTdlYWE2QjFFMHBwVENU?=
 =?utf-8?B?WHRWTGVEekxlZU42YXFWYVdaOTlVQWVhU2lwK3hLSHlDVVY0Vzc3SFJkNUNS?=
 =?utf-8?B?YUF0c0RCNC9BMHFlYmJVcHg0QXBzYWJBYU5ONHF5UDZmZ2F0MXExeEFaNjdG?=
 =?utf-8?B?Mm1wdkY5WmRUNktKd1kzUTJyWjEyazU0S3Y0NVZVdjJFVmVMdWxWTUF6NXZr?=
 =?utf-8?B?amZsbFpDa3NNb3phUU1tbytVMDJtSGNjVHkveDR1V2tMWVlxc3MySlhCN3Bq?=
 =?utf-8?B?aTBwcEp5N3dITjloOXBkSjJrU3FJYkU3QkRKTjNiTU9CKzJTb0hRTmdWZGpJ?=
 =?utf-8?B?MDhrcjVKU2JIRmZhYVc5bnZuM2ljTmsxalRsV0tnLzNVMnNxZFo1M0RPYnlE?=
 =?utf-8?B?Y250TURFdndsMGxjMW5jUkJhUml0dmIyWG5wcTBXZy9iZ0txcjgxZ1VRd3BJ?=
 =?utf-8?B?MnFtZUhua3gzUVhCK3VzYmZXK1NETnZRRG4xQkVobExObDdML1hEaWdYT2Iv?=
 =?utf-8?B?RUxNOGk4aHNtdi80dTg2OUt4NDgwVUcwS1pGSXo5R2xOUzFFWmdaaHZEMGJr?=
 =?utf-8?B?LzY3U3BQU1grUHk3UXdaM0x3MzV6a21pczkrSm10V3hpU2QxOWw3NXdXN0Y3?=
 =?utf-8?B?TDJ3ZU1CQ0FUYjNQVlp5TmdjQXUvRUhYNW9PNTV1SmtJRXJrVmdMZzVNNHph?=
 =?utf-8?B?Mjd3MlU1aVNscFJaNnFXN1dJWi92VHV6UkFSdUFONXMxdFFRWkMwK1Q0WEtH?=
 =?utf-8?B?WWRreWdId2RtRkwwbTVMRzlpeHp6eVVTNjdxMGhzVUs5Y2FMR1lXVGJsM2lv?=
 =?utf-8?B?TG81Nk1YNlYxc2xKaERyNDRKbzBpUjNrL0U4dzFLU09XaEhaKy9odEliTE96?=
 =?utf-8?B?blVONldkRi9VS3htRlVpS3BVblpVQXY5aVFYdy9leHkzSzI2QzZqeHFvbDhN?=
 =?utf-8?B?NTlPa0dobDhlb0pjZ0JrT3F4eEpHdmQxQVlKdHE4TWtUN3JtTlBnTDQ3ZStZ?=
 =?utf-8?B?OUxPZUN6Y0YzOVR4OTkxNmx6eW8xUFRtNGZ0N3MrMkhjSTV5NDgyQVpWcW1H?=
 =?utf-8?B?dGxFa3BtcnU5VitpZDNGNXNiaktvOUoxRmNTTXpwbG9nb245d2xUTnRXVndM?=
 =?utf-8?B?empXbkl2SEdiS05vdzJ3NkFhZjk5b0ppaGNwTHBzYjJCV1JGMDdyOHN1VzZo?=
 =?utf-8?B?K0tJNysvZktsTlFDSVBwOG1ZQmFnTXRQSTExallSSlRxS3padGlGMHF5aG9u?=
 =?utf-8?B?U3FhaHJHUEZ0RnBKK0p2TVF1Q1lYTnhlQUhna1VvTklJVGQ3dzVzN2cwR0li?=
 =?utf-8?B?K1BUOS92MDhoWFBQWHlQOHYrcEdOazRodkVDOFk0REhPZStOWWxYWi9BclFB?=
 =?utf-8?B?VnhrWjhSU052dzhBbHBpa3RUUjArR3VmSzFtK2VCaE1WZ0kxMHA0Njh3OWZM?=
 =?utf-8?B?eVRsdE9YeDFBSFczVTJRT1QzUGJuekFLcnRXUUw0TmpQRlIvekljNzFIb2x6?=
 =?utf-8?Q?6bRghQo8RZy6QlJ6+YW8gJJYT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FCA0D20C0B55E43AC192AA1BF863507@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jansen-preisler.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1PPFA37683A28.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f76ccbc-49f3-4d31-0125-08dde9fcf21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 08:44:35.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb24b2e4-d1d1-4e9e-a276-0d90427a6a9e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rkDqPkUzThfLAJdV296pAtT9zK/ud6OCa+ynovWxRKUnhvYn22jROhM8qp6bSCkUHPk1dQEmDGundAhWdgtvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPFAA9F3EB8C

U3VwcGxpZWQgc29tZSBmaXhlcyBhbmQgcmVwaHJhc2luZ3MgcGx1cyBCcnVubyBCcml0bydzIFBS
ICM3OTQgaW4KNDA4YTIxNi4KU29ycnkgZm9yIHRoZSBsYXRlIGNvbnRyaWJ1dGlvbiAtIGFzIGFs
d2F5cywgcGxlYXNlIHNjcnV0aW5pemUuIAo=
