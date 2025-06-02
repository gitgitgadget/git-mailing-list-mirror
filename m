Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011028.outbound.protection.outlook.com [52.103.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43B2C3245
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748835955; cv=fail; b=sFM+0KkJsq2+OtcgJKspBo2zz+xEsMDgW0QZqV52QFT6c7fF0ztmhaCdRPyvIBKCQv4SDZQmLyLlI06yNSk0nDTwpbUtkaoULCVqLK7IPzgUJqDRHgPrS58kWdI8gf2SCiWoKPxgAhCKGNaHCJbATu4mg3ZIoiTB9TcBkzNg9Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748835955; c=relaxed/simple;
	bh=NnqqEsSk7Ei2s9UX9M/go3y93huIN7DmeqXMs7oAmdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t23eUSXjTa46yaaxCsOMXxE84XfA3+TV6uGzCDsmqAD3+15ehcAzVDICgEfylzj3O8znPJeNAOyJDkuRYu4lU+ERwAi01ZZmM1V2hkRTRDiTVk0WH+FdeFcFs2Fyrh4cUTMClYr52/bH1qrJM8s9sBpixzM6m9rpEGY1PRHbOXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=HF/rKUOn; arc=fail smtp.client-ip=52.103.68.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="HF/rKUOn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fenqYA6AhWQQaHDsV/N5dHpySNAL2ebOjQjovovfAd/4h+KB8BjddfE6hgvNNe9GuO5+9wtXPBsZRozCqamJcwo5rdtHVbdslsHoVQiR51fyDnhtXkRnGqhPdgcAD4wynptlbzhNNscTnzHqbmBJHEWXEbAyDiOGicYm4LCCXZg/78WZcMYg7NEfFC/eUEj9PJVLGESIqJGfA7tbJw5e7mLd2YRo4HWeLKCLXCXJXpyxZgKgYBidncZtWKqcXtQbI+AWW0OFVMgfOFdLTk/XYcflFjbECd5gQXeAOTCc7SI1u/675aYX9QWuvpiRYZpHLtWU0RjgIsinWkWmY8F5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnqqEsSk7Ei2s9UX9M/go3y93huIN7DmeqXMs7oAmdA=;
 b=zLc57CwCW7556w32qWLbBi4YsIqNFgalHTASMxxnEzrSTThy3cxybXKucV5izGfvbsG5tOIkWeSo6PBth28JbC1ZN7WIjgNgouuhf4PagNzUCSQpkHi05jxHaKuQz2f3bS+/ktB3QjcdkG5FMXMDHc5Wvi/SN3PpwysnHtc31BrOA/mpuLCgtm5QyougLqV1b1T2S+pHEEuQGSeKqcxti/Z2mRgZWKzTcg8rURtx/wDq1yfE7Tl7x2TWNzP9IhuJPFBno9afFddByDkzmpJzp+rZzBtXSr+UOx9AjHi2Z9Tab/qpC8JljADf9dlKTpfBi8n90lojQiLGNuEgAMREOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnqqEsSk7Ei2s9UX9M/go3y93huIN7DmeqXMs7oAmdA=;
 b=HF/rKUOnXYOiOtAUEVWRGQFqIYc7Un7QwGa3GKEYofaGpxLA0VYGmC3F6bY3FjbgBfQj2Fi/cgDjaHFw/NWrEBvasOhNgz1wDOIwqUaE8v7WgtysqChmyDtC8iQpr9xgP/bu+T3li1qJ0+tz9Z4oq/+5aZ2frdpTdQZLp3sfnD75F4bwXFpxmGvP4XOeTe5YcnjHK1YNyIehvkJtvx6cQyPL7Wg0JaNwoSPDz5Zpr/oNvCU1ohWkbf+k57Jijo8bcRekaBIHSHifbEjshH3i3Z6gXs1IUHzeBDxjze54iEoLMIWjHr4KveYnn0RoXw492FDZwN2nvhf02tZJAA1Dxg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB5518.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 03:45:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 03:45:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v11 5/9] imap-send: enable specifying the folder using the
 command line
Thread-Topic: [PATCH v11 5/9] imap-send: enable specifying the folder using
 the command line
Thread-Index: AQHb0tCbH7SAtqyI6k2V3V1h0MtG5bPvCB6+gAAz5/Y=
Date: Mon, 2 Jun 2025 03:45:48 +0000
Message-ID:
 <PN3PR01MB95975D2159C4D6B4D111910AB862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250601083821.2440110-1-gargaditya08@live.com>
	<20250601083821.2440110-6-gargaditya08@live.com> <xmqqfrgjvuw8.fsf@gitster.g>
In-Reply-To: <xmqqfrgjvuw8.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB5518:EE_
x-ms-office365-filtering-correlation-id: 14ea5467-efd2-4126-a7b1-08dda187f68f
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8062599006|8060799009|19110799006|7092599006|15080799009|461199028|440099028|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?V29mSmEwL1hMbDNnVHRWQUdERkFrQ01GZGRqWG1Gb201Z2Q5ZkNOTFUyZ1VV?=
 =?utf-8?B?Y0xhdWt3dnk5aDhHOW1hdUsyTlhPR3p6RE9nc1UraDNUMnkwMDlKTTNrMkxr?=
 =?utf-8?B?Wi9HeTd0SE8xTGRiaFA1SjB1c0xkbjkxUTcrbjBSaUtBK20zWnpaWDMrcmRn?=
 =?utf-8?B?MjgxSkZ5aVl3bURQazBYN25IeWdiMDdXZ1BLUXBuUDgrd1R1NU90cFk2bUhX?=
 =?utf-8?B?cVBraFIrZmNHNnV6ZzVKd2hKaElERGlCaFAxbC9oMkloZ1d5VnlER2tOa0cz?=
 =?utf-8?B?TU1BeHJuQ1N5ZlozejVJSkdHQTVORkx0Y2FRb1NzWnBzY1greGtsUmx6bmZQ?=
 =?utf-8?B?WU4vQTlEdzhsdkJOQTJMVWF6eVh5bHA3MDVlRm5wODk0cE9RT1N4SmVlai9Z?=
 =?utf-8?B?eld2a0drMkFWNitxc0VpWU16MUg1RFVad1h4OWRQSFVUT210YUJrN3ZiOGZX?=
 =?utf-8?B?Z1pBUzhmcHY2aDBRM2V0cWUwd0wyODE4WmRBV280Tk1IeEpEZGxhTkkxdG90?=
 =?utf-8?B?YnRRWGxBVW1nc09RaXdCNFJ0MmpqU25MVnc4bkpBekJGZDl5RmZNZDdKNmFC?=
 =?utf-8?B?aTM5NlZyQjZYb0QzVE1tREpIc2dYajBCMDlQV3lVZ3A2SGJUZnRWcmtvdWE2?=
 =?utf-8?B?NXpDb1kvMlRwenNUa1g0ZExBbkdZTVZkVmZjdy9zaGxNMVBRT2ZmUHlNT2hJ?=
 =?utf-8?B?TlRWb3NVVkF0MHpRcm4ycFZ5NjVrQzhlUG1jS2ltNGM3TEpvM25BU2x5WkM5?=
 =?utf-8?B?UTNFQWhGanBNR3F5UWxVaWVSRzdESENwQkFTRFluRm5hYWFQZjZjYmI1S2sx?=
 =?utf-8?B?cWY3dXpSWVRyeWUwY3pRcGtKV0QyaWw4R3c2RGVQRVpXemF3OER1TlE5RzR2?=
 =?utf-8?B?b1czMEt2U2c4VVc3NlpxaDgxWlJ0TkNHNkRwOU1TU2xBbGk3cy9LQXhDYWsx?=
 =?utf-8?B?R1pBY2grdTBVcTFKcWlQcmkwaVI4Zmw0QmlOdldZOG9CdFpLWnF5S0JzVU14?=
 =?utf-8?B?N1JCSTBPZDBta0EwZzY4MzRhZ1JDNkZTbzAzOEg5Um44UzhOUHJMTW5Cd1Mx?=
 =?utf-8?B?djE1YWNrOTFaLzY5bmtNTDZnSk1wa0lMUlVoZjlweXZpNVRkQ0ErS25MZUZD?=
 =?utf-8?B?VXdWd29YWUJSRWU3WnozYzE2VmsvUCtnVTdlTmNYWnJLVUxYVFdTUDNueXlV?=
 =?utf-8?B?T0JpRUthbFBsOFAydmtTdzFvbHFjY1k3RnRVMUVxbmgwbGY5M25ab3hnVXla?=
 =?utf-8?B?akZ0MlVxalIxL2VnR1Iwclc0T0ovdzBwOElXVERFQStabURTdG9BOVlsZGVX?=
 =?utf-8?B?bUlBbytxQURNTjhyWEhRSE81NGlaOHpybGFXcmczdjRHaEhGWml2U0dSVWlH?=
 =?utf-8?B?dkVkMWZtL1VrcTVEb1ZGRFo5eXU4S1hISlJJbXZUSlVzWjZudFhnbHBRdXFs?=
 =?utf-8?B?bm5od28wLzN6RXppNW5RaGpNN3puSXZ3bWJ5WTlVNkh5Z2RXYXVTWi9QKzVj?=
 =?utf-8?B?SFBQRHJnVWdKd0FUbVROTjBVYlAzNTA0Sy9aWWZGM1BPUnhyai9TSFJmU2Vl?=
 =?utf-8?Q?W4G488d/ErYbnjdWEY4zOibPQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1RSeUNrRDNXMEFRaWFEMXczVTF0R0tBbDVXZ3FLZkdiOHBrVmxQeHE1UXk0?=
 =?utf-8?B?aUpkQk8ya1Z3b21OcFZESk9xck9oNy9xcnlYSDlEZ0MwVHdlV2p0azRFUEt6?=
 =?utf-8?B?aDM4eWlnYWJlNXJybitSdWdHVjF3RGx2L1pXcTFnaHJTTVI1ejZkY3pxeUQr?=
 =?utf-8?B?THVJUUJpeWd5NkQ1alp3bkFCbDVEbWZVRlJxWjhWcDRyMUwzYnU2TW1nNlYz?=
 =?utf-8?B?OU5YcUMydEx0aUx3TzV0VU1sd0VZR0lMK2xwdTR6b3RsTWd0SjBydnFJc1Vj?=
 =?utf-8?B?SW41ZFdhTFNEWTRmRGtxN1F6TEdmQ1Y3VlpPdTVYWWp0K29XQ00yTTJwcUVh?=
 =?utf-8?B?VU1ZYVBLc3gybWNFSnpuWW0wN3prc3BhNURxdlJleURLWlNsazl5QXFabU91?=
 =?utf-8?B?R0RlYTdCa3Njc0t2eDNGRnl5NWRYbm5KOW9yODAvMnFBR0pMcXY1VDd2MFAy?=
 =?utf-8?B?TXcrSVZhczFseVVQT0FRZk5VQXdHV0x0eXJIc3dMd3BNeTZOOXVuTjZSQ3Ir?=
 =?utf-8?B?dktYaXRabys2K0RyNkZSQVpNdk1JSkxteElqdUxvT3F5aSs4aVR2L1ZEQldm?=
 =?utf-8?B?Zy9ZRVFocUJmOTF4dzArcjhYUWRXOXBrdllzWjJVc1VNWnpsd0xDbGJadll0?=
 =?utf-8?B?Qm11SjdsMys2dGQ1blphckxzZTlydnUxQll0MkVLUFhLaHlBN0FWU1Z0RWxk?=
 =?utf-8?B?RGE2d212bE5yUGVzMWZtWVV4UmZiRTBPbFVBVy94dW43U3oxSk9iVmdyZDIv?=
 =?utf-8?B?clhSTGRNWFRnVHgwWE5PbVlYOGZkN0VocHloOHNHVVJHTnZPVEtzR2REbGhK?=
 =?utf-8?B?czdLM3hnMWsvaHQ4ellia3B2a1pkUXNwUXZQWFE1YkhpOHVkR3czNVBZY1Fq?=
 =?utf-8?B?UlZGSXdTejN6RVpyTXB5ekZ5Uk9YMG1tNlV3VXpBMDFRTlFJakY3Ym5WY3BI?=
 =?utf-8?B?SVBHUFRtNHllSGNMUVc5NEVnSEZsWWEyOVJYVEgwanlxYVFnVExJaDBSclRn?=
 =?utf-8?B?eTVyRE9HWHlYb1RFcVZvWG1UM3ZIdk1NQTUwMTlLUWVsTTd2TExhcHlDQTE1?=
 =?utf-8?B?am84WFgvU1VpYUZwZWhPNldVaTVJeW1aQWE4SkRlaG93Z2h6bStXd2JDV1dB?=
 =?utf-8?B?Y2s2alh6cFFiOUo3dk4wMHkxcXpsNVZoMGNXL25wNFhTN3J3L3lqYTM2TGNU?=
 =?utf-8?B?c1R2cVcxa3ltZXY5cGFTS2FYU1VCc2hRV3UyelU1ZDh6T1QrdStENDQxRDB5?=
 =?utf-8?B?Q0FSQ1NZRzlYVzVUUlJaUTFMMjNLN3ZBSTFMODFSZWZLZEZsVDBqSmVEdmQ3?=
 =?utf-8?B?YVh1YVR5RzZNR1ZtTEY3R1l2Wm1qRnFvaGQzUVpibE92WTRPbUNFL0NqUG9q?=
 =?utf-8?B?Zm1qYTVnVEQyaC82M2czM0JidVdrekUrUUs4cStYQldENXJDUnJ6Snl6NXV4?=
 =?utf-8?B?eWNmSHRaZWwxRitLYkIxNEg2ZjQvYlBHUUNKaDFoWGFyMVhmMDFmTlJOMWFV?=
 =?utf-8?B?TCtHWG8zRkpYcVQ3cEhYSmkvRmVLVDhrVVRXcmRuakRLNVllekhTdmVqakNj?=
 =?utf-8?B?TmNoTGhzMUpmeURia3I5RjBxUy9QT3BqZks4NGR1VDV1YVE5V0JxVWEzWmNG?=
 =?utf-8?B?WUVqQUsxNnBORzBGVXFPc095Nm1QS3RYRkZ4dkVaVEdwYUd3enNJUndUVkI1?=
 =?utf-8?B?alYrUU42ZXB4bENxbE1QcDFYZ1UyT1g3NC9UTzJDb2oreHVPZkx6d09GMXV4?=
 =?utf-8?Q?ANcjpSoXpP98JUzxG4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ea5467-efd2-4126-a7b1-08dda187f68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 03:45:48.5340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5518

DQoNCj4gT24gMiBKdW4gMjAyNSwgYXQgNjoxMOKAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+IFNvbWUgdXNlcnMgbWF5IHZlcnkgb2Z0ZW4gd2FudCB0
byBpbWFwLXNlbmQgbWVzc2FnZXMgdG8gYSBmb2xkZXINCj4+IG90aGVyIHRoYW4gdGhlIGRlZmF1
bHQgc2V0IGluIHRoZSBjb25maWcuIEFkZCBhIGNvbW1hbmQgbGluZQ0KPj4gYXJndW1lbnQgZm9y
IHRoZSBzYW1lLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5
YTA4QGxpdmUuY29tPg0KPj4gLS0tDQo+PiBEb2N1bWVudGF0aW9uL2NvbmZpZy9pbWFwLmFkb2Mg
ICB8ICA1ICsrKy0tDQo+PiBEb2N1bWVudGF0aW9uL2dpdC1pbWFwLXNlbmQuYWRvYyB8IDE1ICsr
KysrKysrKysrLS0tLQ0KPj4gaW1hcC1zZW5kLmMgICAgICAgICAgICAgICAgICAgICAgfCAgOSAr
KysrKysrKy0NCj4+IDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vY29uZmlnL2ltYXAuYWRv
YyBiL0RvY3VtZW50YXRpb24vY29uZmlnL2ltYXAuYWRvYw0KPj4gaW5kZXggMjRlODgyMjhkMC4u
ODI5ZDllMGJhYyAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vY29uZmlnL2ltYXAuYWRv
Yw0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9jb25maWcvaW1hcC5hZG9jDQo+PiBAQCAtMSw3ICsx
LDggQEANCj4+IGltYXAuZm9sZGVyOjoNCj4+ICAgIFRoZSBmb2xkZXIgdG8gZHJvcCB0aGUgbWFp
bHMgaW50bywgd2hpY2ggaXMgdHlwaWNhbGx5IHRoZSBEcmFmdHMNCj4+IC0gICAgZm9sZGVyLiBG
b3IgZXhhbXBsZTogIklOQk9YLkRyYWZ0cyIsICJJTkJPWC9EcmFmdHMiIG9yDQo+PiAtICAgICJb
R21haWxdL0RyYWZ0cyIuIFJlcXVpcmVkLg0KPj4gKyAgICBmb2xkZXIuIEZvciBleGFtcGxlOiAn
SU5CT1guRHJhZnRzJywgJ0lOQk9YL0RyYWZ0cycgb3INCj4+ICsgICAgJ1tHbWFpbF0vRHJhZnRz
Jy4gUmVxdWlyZWQgaWYgYC0tZm9sZGVyYCBhcmd1bWVudCBpcyBub3QgdXNlZC4gSWYNCj4+ICsg
ICAgc2V0IGFuZCBgLS1mb2xkZXJgIGlzIGFsc28gdXNlZCwgYC0tZm9sZGVyYCB3aWxsIGJlIHBy
ZWZlcnJlZC4NCj4gDQo+IFNob3VsZG4ndCB0aGVzZSBsaXRlcmFscyBiZSBgdHlwZXNldCBsaWtl
IHRoaXNgIHdpdGggYmFja3F1b3Rlcz8NCj4gDQo+IE1vcmUgaW1wb3J0YW50bHksIHdoZW4gd2Ug
bWVudGlvbiB0aGF0IHRoZSBjb21tYW5kIGxpbmUgb3B0aW9uDQo+IHRydW1wcyB0aGUgY29ycmVz
cG9uZGluZyBjb25maWd1cmF0aW9uIHZhcmlhYmxlLCB0aGUgbW9yZSBjb21tb24NCj4gdmVyYiB3
ZSB1c2UgdGhhbiAicHJlZmVyIiBpcyAib3ZlcnJpZGUiLiAgQmVjYXVzZSBpdCBpcyBhIGdlbmVy
YWwNCj4gcnVsZSB0aGF0IHRoZSBjb25maWd1cmF0aW9uIHZhcmlhYmxlIGlzIHVzZWQgYXMgYSBi
YWNrLXVwIGluIGNhc2UNCj4gdGhlcmUgaXMgbm8gY29tbWFuZCBsaW5lIG9wdGlvbiBpcyBnaXZl
biwgaXQgaXMgbGVzcyBjb25mdXNpbmcgaWYNCj4geW91IG9taXR0ZWQgdGhlIGxhc3Qgc2VudGVu
Y2UuICBQZXJoYXBzIHJld3JpdGUgdGhlIGxhc3QgdHdvDQo+IHNlbnRlbmNlIHdpdGggc29tZXRo
aW5nIGxpa2UgdGhpcz8NCj4gDQo+ICAgIFRoZSBJTUFQIGZvbGRlciB0byBpbnRlcmFjdCB3aXRo
IE1VU1QgYmUgc3BlY2lmaWVkOyB0aGUNCj4gICAgdmFsdWUgb2YgdGhpcyBjb25maWd1cmF0aW9u
IHZhcmlhYmxlIGlzIHVzZWQgYXMgdGhlIGZhbGxiYWNrDQo+ICAgIGRlZmF1bHQgdmFsdWUgd2hl
biB0aGUgYC0tZm9sZGVyYCBvcHRpb24gaXMgbm90IGdpdmVuLg0KDQpPaw0KPiANCj4gSSBkdW5u
by4NCj4gDQo+PiBAQCAtMzcsNiArMzksMTEgQEAgT1BUSU9OUw0KPj4gLS1xdWlldDo6DQo+PiAg
ICBCZSBxdWlldC4NCj4+IA0KPj4gKy1mIDxmb2xkZXI+OjoNCj4+ICstLWZvbGRlcj08Zm9sZGVy
Pjo6DQo+PiArICAgIFNwZWNpZnkgdGhlIGZvbGRlciBpbiB3aGljaCB0aGUgZW1haWxzIGhhdmUg
dG8gc2F2ZWQuDQo+PiArICAgIEZvciBleGFtcGxlOiBgLS1mb2xkZXI9W0dtYWlsXS9EcmFmdHNg
IG9yIGAtZiBJTkJPWC9EcmFmdHNgLg0KPj4gKw0KPj4gLS1jdXJsOjoNCj4+ICAgIFVzZSBsaWJj
dXJsIHRvIGNvbW11bmljYXRlIHdpdGggdGhlIElNQVAgc2VydmVyLCB1bmxlc3MgdHVubmVsaW5n
DQo+PiAgICBpbnRvIGl0LiAgSWdub3JlZCBpZiBHaXQgd2FzIGJ1aWx0IHdpdGhvdXQgdGhlIFVT
RV9DVVJMX0ZPUl9JTUFQX1NFTkQNCj4gDQo+IFRoZXJlIGFyZSBmb3VyIGV4aXN0aW5nIG9wdGlv
bnMgYW5kIHRoaXMgYWRkcyBhbm90aGVyLiAgSSBhbQ0KPiBkZWJhdGluZyBteXNlbGYgaWYgdGhp
cyBkZXNlcnZlcyBhIHByZWxpbWluYXJ5IGNsZWFuLXVwIHBhdGNoIHNvDQo+IHRoYXQgdGhlIGVu
dW1lcmF0ZWQgb3B0aW9ucyBhcmUgbW9yZSBsaWtlDQo+IA0KPiAgICBgLXZgOjoNCj4gICAgYC0t
dmVyYm9zZWA6Og0KPiAgICAgICAgQmUgdmVyYm9zZS4NCj4gDQo+IElmIHdlIGRpZCBzbywgdGhp
cyBwYXRjaCBjYW4gYWRkDQo+IA0KPiAgICBgLWZgIF88Zm9sZGVyPl86Og0KPiAgICBgLS1mb2xk
ZXI9PGZvbGRlcj5gOjoNCj4gICAgICAgIFNwZWNpZnkgdGhlIGZvbGRlciB0byBzYXZlIHRoZSBl
LW1haWxzIGluLg0KPiAgICAgICAgUmVxdWlyZWQuICBEZWZhdWx0cyB0byB0aGUgdmFsdWUgb2Yg
dGhlIGBpbWFwLmZvbGRlcmANCj4gICAgICAgIGNvbmZpZ3VyYXRpb24gdmFyaWFibGUNCj4gDQo+
IHdpdGhvdXQgd29ycnlpbmcgYWJvdXQgaXQgbm90IGZvbGxvd2luZyB0aGUgcHJldmFpbGluZyAo
YW5kIHN0YWxlKQ0KPiBzdHlsZS4NCj4gDQo+IElmIHdlIGFyZSBub3QgZG9pbmcgYSBwcmVsaW1p
bmFyeSBjbGVhbi11cCBwYXRjaCwgd2hhdCB5b3Ugc2VudCBpcw0KPiBtb3JlIGluIGxpbmUuICBX
ZSdsbCBsZWF2ZSB0aGUgY2xlYW4tdXAgdG8gc29tZWJvZHkgZWxzZSBhbmQgYWRkaW5nDQo+IG9u
ZSBuZXcgb3B0aW9uIGluIGEgc3RhbGUgc3R5bGUgdG8gNCBleGlzdGluZyBvbmVzIG1heSBub3Qg
YmUgdG9vDQo+IGJhZC4gIEF0IGxlYXN0IHN1Y2ggYW4gaW50ZXJtZWRpYXRlIHN0YXRlIGlzIGxv
Y2FsbHkgY29uc2lzdGVudC4NCg0KTGV0J3Mga2VlcCB0aGlzIHN0eWxlIGNoYW5nZSBmb3Igc29t
ZSBvdGhlciBwYXRjaCBzZXJpZXMsIHNpbmNlIG1hbnkNCm90aGVyIGRvY3MgYWxzbyB3b3VsZCBu
ZWVkIHRoaXMgY2hhbmdlLg0KDQo=
