Received: from gw9138.fortimail.com (gw9138.fortimail.com [82.98.199.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798712BD11
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=82.98.199.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644368; cv=fail; b=NV6lfhx75uXY5j/sZxYd9A/NV8YUjd+Zplhu21iVk+VkevWQQXIMztcad/iUUvv5+l7Yqvmw4f6RbxEN2kukhBAktEeOpgEvqi43lEqpQP4HBusrfLz4Ri1qHvFmqioIwyL43ia/KZ8Qmeuv06fbdg2aqIXUx63pVHoJ6aMhH3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644368; c=relaxed/simple;
	bh=0kb1F6roUcsKhRxBn5/6Ww9RHsECrHqNAPuth9gdq00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qL8JQcReT4ue7Klmc2yg/7PgsdneiH2eIIEcJ6oz1IeO497NeFKdOLeRxtjFw+NxN00p3pVRTtDReKm1VtiBJWHSorzDxc5JCScq+ESfIwkXdyIlqtq3eOQgCUFupn1YmX6QpAbG7UkW327bBXmbaHUoDavXCrzBDdyL9DBPtLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tr-advanced.co.jp; spf=none smtp.mailfrom=tr-advanced.co.jp; dkim=pass (1024-bit key) header.d=tokairika.onmicrosoft.com header.i=@tokairika.onmicrosoft.com header.b=Dfga+FWi; arc=fail smtp.client-ip=82.98.199.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tr-advanced.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tr-advanced.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tokairika.onmicrosoft.com header.i=@tokairika.onmicrosoft.com header.b="Dfga+FWi"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011032.outbound.protection.outlook.com [40.107.74.32])
	by gw9138.fortimail.com  with ESMTPS id 63K0JEmk031849-63K0JEmm031849
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 09:19:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXhP66Xw9gw3voA4kuDHLK5uJer+OkFe+Fqg4OPmeeeR2GiUec4YPGkajJPeQSqZTk66nDx7PB40MXyS9ZUduB09zH+bGaioqxQQIeTd3rcULutNUfftzoAwq1k8ZDve/e+1bD+fX7a0GY87EuteCwlCAjW39U5xNBtQB+SKgPckL7o5rJLx3KxZrqf+VztkYiPNgUfiejqWR5LOCwDtoMwihI8bdCbFJHu7x1/dYm6+JQi/O+6UFmcPvV2YCFWwnqkTdgKCXgb+NMGMW9ZauMQvMx/kBqGPtTbTvAaMzoxXCyAf9edJ3SyXCk6IPMjUkGWek9yCASqPAR7aF0qzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kb1F6roUcsKhRxBn5/6Ww9RHsECrHqNAPuth9gdq00=;
 b=Ur9zY1op7piXBd7WMnRv1V8PIQj6EfSQM2OD/iW8Gm7dOiPvGIuhGgzJbh25LQ0jshkyegsrvYUmX/G1+Wl+pMY3CIp/cmwF4JcQOISfryH7QPI1AXFaSOKg6SjXlzkF4kmr/umqAvhqrWTYgw9oxX15HoaRE2BAed0OhdmV1YlOiD1pLTF8+k2En/I0n/REqtR7YBrRYHWvuwnuv9GkevnTsOI75oATDFm/ViUNi+yavRLN9iizaAXMegurMaqyhp9K2DdGAqgEKEk53WzO8BA6IN+PMnsk03L1eUZtQ0yjVqojAmoTl+82+GiN4Da/RHhITFJ2k7++6OV8QSKuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tr-advanced.co.jp; dmarc=pass action=none
 header.from=tr-advanced.co.jp; dkim=pass header.d=tr-advanced.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tokairika.onmicrosoft.com; s=selector2-tokairika-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kb1F6roUcsKhRxBn5/6Ww9RHsECrHqNAPuth9gdq00=;
 b=Dfga+FWip9GzSIN80DsgEPCeTTMu+/XMJCK1FqZfZGVZnOgpZu3OnZNlYvU2lBTxOj+3aKCjvOPj3wuVifzhiDnPnk8X4Ce0fd3Z+Db46Z+K6XCCG4hpbo1UJz93O4+jbW1n9JBAiXzyMLTOwOsS/YQiZfVaWtN8B4kz6AksqPc=
Received: from OSCPR01MB13450.jpnprd01.prod.outlook.com
 (2603:1096:604:32e::14) by TYRPR01MB14302.jpnprd01.prod.outlook.com
 (2603:1096:405:21a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 00:19:10 +0000
Received: from OSCPR01MB13450.jpnprd01.prod.outlook.com
 ([fe80::8fd4:6b1d:4f1:4b46]) by OSCPR01MB13450.jpnprd01.prod.outlook.com
 ([fe80::8fd4:6b1d:4f1:4b46%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 00:19:10 +0000
From: <kawai-m@tr-advanced.co.jp>
To: <Johannes.Schindelin@gmx.de>
CC: <git@vger.kernel.org>, <hattori-m@tr-advanced.co.jp>
Subject: RE: Subject: Inquiry: Git versions you provide and Windows 11
 compatibility
Thread-Topic: Subject: Inquiry: Git versions you provide and Windows 11
 compatibility
Thread-Index: AdzLqvIiPp8/2/suQwqpKO+g0SPM4wCWm2SAAJVnozA=
Date: Mon, 20 Apr 2026 00:19:09 +0000
Message-ID:
 <OSCPR01MB13450E9AF83B914D507B77254EC2F2@OSCPR01MB13450.jpnprd01.prod.outlook.com>
References:
 <OSCPR01MB134507F2EDA90C775EF1DC571EC252@OSCPR01MB13450.jpnprd01.prod.outlook.com>
 <57f4f6e7-f1ae-877a-8215-13e7dd5a18f1@gmx.de>
In-Reply-To: <57f4f6e7-f1ae-877a-8215-13e7dd5a18f1@gmx.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tr-advanced.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13450:EE_|TYRPR01MB14302:EE_
x-ms-office365-filtering-correlation-id: 6212a982-f119-4247-0204-08de9e727163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|42112799006|38070700021|56012099003|22082099003|18002099003|3613699012;
x-microsoft-antispam-message-info:
 cKzIXO9tgsF9SA66OWXV1GsnBnN22/IPv/crsiqeGuQWCOY75RZTJpD4GMPIxnUURFZDzr1Dti8plLT5oH1BofXnBGUWdmPBBl8S/E1A+tyjC0wmob3n5pUq6Xhwlh14DJNHrpgZWjnCkmShvJyMJ5irdDOHiv2N65z/aHs+e83wqEVG0RmDw+nDJYiXtDdOS+IvZ6ZCrrDRKa8TxX28YEp9pk48liSZydNE2+rGf2jFCKabfjdDeP3SSZjUY4ggtpmaWQ8ghaptMSBMB+7NBTIZ+hZ8Ug/EO+pXaFrfs8Jjir5JVCTe4OqZc6cKVrk9pP0jGTVzjO5Oucj9xHnnVxARcezy+eLHK6VVBxililHqOepEHPwxUadoK6D4qStUMr4Zl9lwd6A+CitTHgqQ3IJ7X0rSGeB56qANKXv2pBUxHDbPD5Kvx531jYU5n55SmnXQpT+GGzMt9oPa5jKDHTSnpy6UI5fIY+Xg1ljIrYvwsxshdmUG3Gf/KRiPVbGH6lxtp66YqWQX74Z8+dCPsUl3iImWtvVshL7FlTmz9C6+sl2zrDxBMOBB0oHWoU4OSXcqgq4wcZdVL2Q3SX7hLPlgqdDyafkexdrvHLrdTvFgEaCgo0MwFeNbkJ9glM5b4PphKpbpGvu5+si4i8KoWfpMlWKev9LezHg1lPyy0RsYlcaVhmW6Z5h2gxUGv/ldRjEi4B+4NVm/WoDnSXgd86PWCImz7h4106jeyCIQ8zGRjWQH6VPJvGA6yQwe7yoykCGuOekvfKIHpqKgC8Bmiw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13450.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(42112799006)(38070700021)(56012099003)(22082099003)(18002099003)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZU8xbG8wNXdGdXBMWmZTMnFRdkZVVkRPMExJL1MrVG9LRi95QkNvYWxo?=
 =?iso-2022-jp?B?OGRuMjhZbE54MGorRnFKdHc4Q2E2bUpmTG4vd0kvTDF0NS9vSFZvUFY1?=
 =?iso-2022-jp?B?aFRDeGJ6T2JJWDNiSXZHdWRIMDNLMWNzaGRwRzM4ejVUZC8wTG1mOXFw?=
 =?iso-2022-jp?B?S0RCRFpwcDlQclNqdm1ZZDBES2pEZEl4R2NPMDRqZkg0MGhmTW55Z3Y3?=
 =?iso-2022-jp?B?MkJrNmkzOE9pTWJqZEQrRkJLVktEeVAwNVBwZnF1NUZzaDJuS1MvNGdB?=
 =?iso-2022-jp?B?ZW0xL1M2bGZpdEpKRUlxSWdzaW0wNE1QaUJaRDVlTGN4dTVWcklCTzJo?=
 =?iso-2022-jp?B?TmYyeENjUG9HYVRPbmRFYWc0Yzd6UHQydHR5M2x3U2ozSjlvMTd5RHNx?=
 =?iso-2022-jp?B?dnJZOGtkL1J1UGE1cUQwOW53VzQzZUdkNkRITXRlT29LeU93NWpPaHpL?=
 =?iso-2022-jp?B?Z1RrVGRuc2dnQWNKR29HL1UzRXNITEJ3WVlaand1bXcyZHA3dDFoRm15?=
 =?iso-2022-jp?B?UWp5WHZwS2FicFhLY1dBajBicHVFakFMV1BqR284NjZSb0lvYk12TjNX?=
 =?iso-2022-jp?B?MHY0VnZucHhsejJGWVFnaWIvbCtjT2h6UmJ2OENKb0tsbThoUS9pd05O?=
 =?iso-2022-jp?B?c3dNV054VlBVZEgrM2V6MHlhY0MxS2llR2pNT2NSWjdsMGMxaGJHcE9z?=
 =?iso-2022-jp?B?WVZ3NE5lUGs5T09HdHNuT0xqcDNCVks2TXVnQkFpTUR4dlBqZEtaelVp?=
 =?iso-2022-jp?B?WUphc3hPWEdCUE1uUWFpYlJ3eWlPcFJUeWNrQUdDZUxjMUd1UVhBMEdF?=
 =?iso-2022-jp?B?bys1amdPMnQ4Q21MQlJwRzMzUFlIQmI5Z3VBN3pPemsvRk9hRE5lbW9y?=
 =?iso-2022-jp?B?UmhLQ3dnQnB6d0pFS1k3VXp4MlIrRE1hU3FiWlV4ZlNkVFRSVXVaN2xn?=
 =?iso-2022-jp?B?N0IrUnBuYWZzN0xwM3RQQ2FuRi9pRkxSS1RMWDBJWXQ4eGhZclBwMm5E?=
 =?iso-2022-jp?B?M21Od0Z4NXVrWTZnZDE0YnlHQjZKL0VDaU5KMk5jdjZsODAwcjFNb3dD?=
 =?iso-2022-jp?B?VDlMaStnWklBdHpnQ1g0RFVIMWtyV242ZU1rWW1EQldKbWlaOFVYNlJL?=
 =?iso-2022-jp?B?Ym5sa081OVdUZGJSOFljQ2gxRktVbW9DNm1sa1h1YmRIS25WZDJBbXlG?=
 =?iso-2022-jp?B?Yi9aZERuY2FhcjU2TkE4bDYvQ3QyeC9FcEM4SjBleXlJeGcvK0UzSFVx?=
 =?iso-2022-jp?B?QlBFWVo1VGxHdW1jVXI0UHA2Z3l2QldPbWx1bG9USVFRazkrRDdiOFpS?=
 =?iso-2022-jp?B?eGZTbFpZSDA3eitOUXRwcDBnK0dYRXVGU1d2bUpQTDh6Yyt0TmR0M3Bn?=
 =?iso-2022-jp?B?NlA1SENyK013NVZ3RmVkeURGUUd4M2hONE1RQUhGWmV4bzZsWkRoWWll?=
 =?iso-2022-jp?B?UDMycWE3Y3R0UFJGM1JEeCtEQTNURkFjNnhYTk05dXZDTUcwOFllSkd3?=
 =?iso-2022-jp?B?R2VpUi9xSVdQT0xaQmVyaVE1Q214M1kxZ2VpSTI2MllxUmNOanNEanA5?=
 =?iso-2022-jp?B?SXhyYkgrdm9EcUk1VDZZNG9yb1Z5OXBhU2NaQzVsaTQvbEpKUkxkVWY5?=
 =?iso-2022-jp?B?Y21VVWlxdmtMaVExN0FYUzc0cHhYZ0tuUVdMcDBlRFVPaDNaWTBlRlpI?=
 =?iso-2022-jp?B?OFZJaG5WenlpOUxvZTB4NVFxZzdscnFhSWpHYVVOTldsVkh0NUpPQVA1?=
 =?iso-2022-jp?B?UFptWUJQMzJxY2wxajhWejhlRTRDTC9XYm84NVlRWTZoUm9zOW11TjVQ?=
 =?iso-2022-jp?B?OVJNTkptQ1VRMVVzRDBwSnR4YjViKzFjUCtLY0k1dmxDdnF5S0xNaTVz?=
 =?iso-2022-jp?B?ZFQxZlFsY0tic0cxM2ZxTEpJNzJXaXlQeGh0SG1lQ1lxQ3hSOUJNVjBq?=
 =?iso-2022-jp?B?T3U1ekVOYlJPVi9XRVVyalV1cXFUeGtzME1LTmgrRWZKMUhFbEZrV1By?=
 =?iso-2022-jp?B?c0EzbHR4VERheElabWRmdnY1OFVZWHRQZEdFeU1lS0pEWTZuU3JRaFA2?=
 =?iso-2022-jp?B?MjhGdkZCejJKSjFJMGdEUkg5SFFQTUxpR2hqTWwrWU8vbndjNzd0L2lu?=
 =?iso-2022-jp?B?dWRmdDY3djk3ay82T29SZExkZTV2cHRxbGwzUUNBVlliVnJjanNUYUda?=
 =?iso-2022-jp?B?QndsMllEYnowTDZIRVNxd0FEODRHaDdZeE16TTdEaFIrb21ZTEpMd0po?=
 =?iso-2022-jp?B?V2RFajBBVGZMd043L294Y1BlazgvNGFoN3VYLzZTMHY3aHFGem5raENO?=
 =?iso-2022-jp?B?M0RaVlZzTVdKK0VVZW9Bc05ObXpieTNyQldKbURNcUhuTGRwTjhsTk4w?=
 =?iso-2022-jp?B?QkVVbmVYc3BzUDFLUFNqc01aMTBPWDFxYmwydUtoTW9KQ0hGV2orOG40?=
 =?iso-2022-jp?B?ZHNWcGV3UXg5VlZGdmtCeFhuajJtU0kvU2FNdFdnWEJldjQ0Y1N2Wi9W?=
 =?iso-2022-jp?B?TXZNQ05WZlJRQmtvYmk3dVpjdlZlRmIxaVovdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lJ/DVDXp0kGs78gAkaxihJnbNlBU9UTVxUF+k2FtKmMAkBw5/SnUj4I9wZBz/Ghdi/BRPlhu7HG0H5xsC5O3TGYfS3Sqnx79+U0X5w77zdSnpHa7m04M4HPCFYa041U8FyZqeCny+nOD1BgaEOXva2kNW5nu8RbmeGa0MNcAunTCAq1hh15s7PZgKKYadxjlH6fj/l9Gtkgszo+AJQW7xbcpdpSyMKcte/fjM0BUqO6DurIVnxc8jNoi7G2BH+Boc4cHju2P+RMRtdXxWnXU6f6gF/W9xxHwiSKncUOZstHjxwNBVEc8yxmjLlU/UHXQpkEol0Blo/m2DohjnqaGEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dG9EK8P76XfG488Lh/vvwojK4F9N0hx3XE8xU2Ewx9BTxFVz3Nzr+kexmFnVxjT/W/5MWlkFk1bkaEmx3pngR4RNMuyF7O9wxFPIpNv3IBWVLxKIQZnmhOdSkfHTevudM9W+dJuRAG2JbTucOEAx45byH+fs3uZodbqNmq7sWPAptci500uS65nEvV0mopK4noYao3bHqI8/G8KChyaHFL8lWe0d9fcFeV516xVLmuzOfWnsGgHSc1GZixZ9qv+/ER5xJImM7q3rzhxaaYwSF0WW30/BMWCEQcghGYH0PZkMxrrXczl/LEv84hNS3Blxh+g0VJMiruTYnKFaKC5Gaz+syLLmDodvDE9WZJk5csZ4w+tr8Skj78z6aO7cddMno432YF+IiBUcLWzkZQQ1hB10D9x9WY1w4kKOVs93waC41CdQCwiaTkY0hpvELj7jkRH/2MGqLLmPuqU6B0ybcPVJQxtWH823WFyEhHeXysXq12Md+eUeJIGWn7CneeoIvcHAQ5JNG/x7t3AKEbFRW7zCMJzhjQ08Hu6D72Ghc3xpaNOd9Qgj1qlhgqgDJMOiC8uB6c30wqVQpB6vfXjWYnCy0DKORe9icGW4KcTsiBduGDdYyas99HE+qK9ThT0M
X-OriginatorOrg: tr-advanced.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13450.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6212a982-f119-4247-0204-08de9e727163
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 00:19:09.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8d8aae5b-4dc8-477f-966f-70bb2d9eaa30
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfczPDskXWuU2ayentXDUgOBPwc9CcYBtonIrRJvSCq+pv0X/ZreGHTJGmhJoGQIuNpeAo9P3Rq/hQsdGcozqjr4UbtSupelrdMg8wslWXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14302
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lJTslWFhYWlpfW1teSFpdSAMJHwkBRQUoHBpFCQweCQYLDQxGCwdGAhhIWUhaXkgiBwAJBgYNG0Y7CwABBgwNBAEGKA8FEEYMDUhYSFpIWVpIXFhGWVhfRl9cRltaSFBIWEhYSFpIWEhYSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFpeSCIHAAkGBg0bRjsLAAEGDA0EAQYoDwUQRgwNSFg=
X-FEAS-Client-IP: 40.107.74.32
X-FE-Last-Public-Client-IP: 40.107.74.32
X-FE-Policy-ID: 1:3:14:SYSTEM

Hello Johannes,

Thank you for your reply.
I understand that the current version can also run on Windows 11.=20
However, since the latest version (v2.53.0) is guaranteed to be supported,=
=20
I will also consider upgrading to that version.

Sincerely,
Kawai

///////////////////////////////////////////////////////////////////////////=
//////
=1B$BK\%a!<%k!&E:IU;qNA$K5!L);v9`$,4^$^$l$F$$$k>l9g$,$"$j!"<h07$$$K$O=3D=3D=
J,$4G[N84j$$$^$9=1B(B
=1B$B!c%a!<%k%A%'%C%/!d!&!&!&#O#K$J$i!Z!;![!"3:Ev$7$J$$>l9g$O!Z!]![=1B(B
=1B$B!Z!;![5R@h5!L)>pJsO3$($$!JNc!'?77?<VL>!&?7%0%l!<%I!"3+H/F|DxEy!K$N62$l=
$O$J$$$+=1B(B
=1B$B!Z!]![<R3008$GE:IU%U%!%$%k$K5!L)>pJs$r4^$`>l9g!"%Q%9%o!<%I$r@_Dj$7JL%a=
!<%k$GAw?.$7$?$+=1B(B
///////////////////////////////////////////////////////////////////////////=
//////
----------------------------------------------------
=1B$B3t<02q<REl3$M}2=3D%"%I%P%s%9%H!!Bh=1B(B1=1B$B5;=3DQIt=1B(B
=1B$B2O9g!!?.=1B(B
TEL=1B$B!'=1B(B070-8848-1712 (=1B$BFb@~!'=1B(B889-2068)
FAX=1B$B!'=1B(B052-551-8623
=1B$B")=1B(B450-0002
=1B$BL>8E20;TCfB<6hL>1X=1B(B4=1B$BCzL\=1B(B5=1B$BHV=1B(B28=1B$B9f=1B(B =1B$=
B:yDLK-ED%S%k=1B(B4F
e-mail kawai-m@tr-advanced.co.jp
URL http://www.tr-advanced.co.jp/
----------------------------------------------------



-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
Sent: Friday, April 17, 2026 9:59 AM
To: =1B$B2O9g=1B(B =1B$B?.=1B(B <kawai-m@tr-advanced.co.jp>
Cc: git@vger.kernel.org; =1B$BI~It=1B(B =1B$B1W@.=1B(B <hattori-m@tr-advanc=
ed.co.jp>
Subject: Re: Subject: Inquiry: Git versions you provide and Windows 11 comp=
atibility

Hi Kawai,

On Tue, 14 Apr 2026, kawai-m@tr-advanced.co.jp wrote:

> I would like to confirm the following regarding Git. As part of our=20
> migration from Windows 10 to Windows 11, we are investigating whether=20
> Git can be used on Windows 11 in the same way as before the upgrade.
>=20
> Could you please let us know whether the following software versions=20
> can be used on Windows 11 without any restrictions?
>=20
> Git version 2.51.1
> Git version 2.26.0
> Git version 2.29.2.2
> Git version 2.32.0
> Git version 2.32.0.2

All of these are expected to run fine on Windows 10 as well as Windows 11.
Do note, though, that all of the listed versions have known vulnerabilities=
, both Windows-specific and non-Windows-specific.

Ciao,
Johannes
