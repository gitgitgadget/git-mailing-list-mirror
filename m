Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012009.outbound.protection.outlook.com [52.103.32.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55321CC68
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386498; cv=fail; b=ntEWiT5nL6PcCszRUuTf6E/u/ita1DLUcVfz08ISeTa1ioP22erSJTaj/2/RibJ4HZpzs/UPekpjmP7m+mIY5fZ14EmCkCx2bCjwIIDYyJCALDbuUy/5L8IbCbeT4q+87W8jKmitHCTxHoldn4uRyA8yILDaJN+cvSYL1egY53A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386498; c=relaxed/simple;
	bh=r2UvVSa78f9nQNiAkwXdPXUC0UZwr+MpBz7fKpzD1C8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cd4W3lmEg5a+DUh06+ubAQFbNi9FP2zgvEZCq7Mc+RW25dAwuKvAETc32UfTSuXFDiq9dZdgKa3HxRW9QSWeohSg+ZEjcCT4TKo+wHwSrsMjEej6ubRXN9T6JqYCMngCd0UAFfwL6kvU8ocpVTjG6PeCXL7ABQsy7UoPP1ayRKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=mnE7lAGV; arc=fail smtp.client-ip=52.103.32.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="mnE7lAGV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqBbW8htxsyEievejQJrRN+sY63S0GSo5sNe8PVtlROvzmDUdbzhRpsRJ/cvnS775GWOkq5JCBDiAxYyD2bTEbEI4A+cLzG1pEXM+mUFmI/t1C55PZ0ZQjrmCPyaLQ6Aoym/LP+InU5EKE567dnJhN6zB8gyKZNnC7uVulQKSqJF9478rRAr8UMvcQA0kno0qq/vZr8cyEol82T8cctNydDTqr/i/tkf3mwg/cgImGXZAn60fMEmQKnYa1CNqif6scfB+iadfcJ1rlBJHrR9XcFhd0IEAwiNcYnPakz6leGHn6stmbwg0JOk1zpxmi1EIcWKe38ocbUbBqUzI8XwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2UvVSa78f9nQNiAkwXdPXUC0UZwr+MpBz7fKpzD1C8=;
 b=d0jrLlpsSAWKuFTfUiuCAEtJ9ea8PiZEK1BA9VNm4FIZXZ6r5qjTJxCwt9bBhdn5kXUgf8CFSXOGAEa5rH1ZsV/tJUfT/JNJnEYoV8iQNKo4ZN6B2R/Xotf1ED8L2V6q8j642ZFVBIAbkiMM6GNvBRoRD0y1CdZZ+Jjev+AYcvuAruLutOvv6CDyomqNjPk6W22iTzvk7o0lGE90OJuETKp9UrKJMP9OgkFQhwTxJ4Fe6e/uuNtm/foUwcxDixvHxlhwzNlpYMXjmeQArXNQmFJ7sEV4TjThJ4pLsMxFxLz8oH2Nk/aQRfWvgKmRI6G0tRDzPWm47GuPqqLZJQXPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2UvVSa78f9nQNiAkwXdPXUC0UZwr+MpBz7fKpzD1C8=;
 b=mnE7lAGVVoulaSk86LXAh1PLiNZBRxZw1LB0BXtgAy2fIpegmNZIDn2z+WbSUxRjPJs1A2+nL635DmcT0eZMPiPvkQwCb6s82G+sAx9QTd6NV+UOrSmqzftI2fJctlpwWPu/vQw61tMjsb6yYYa+iNvv4u0taH9J0wHKx8O8VKjWJbSAZaVzyGntcYfG8esezkKya52hOBQ+HQy+LmHJ4sq/mWuUjrs6Y0A+u5NnB8IJKxijalzR+VoWGMvn3/CANiYY6SfsQWt+FIBzRdHdq+87/meXfjPGghoik8XaHXWur6otg4n5B24d9lIPvDPMYYVGyf8a4pqSINzze1p4Gw==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by DU0PR02MB10368.eurprd02.prod.outlook.com (2603:10a6:10:408::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 13:34:54 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 13:34:54 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] Adding a native, opt-in versioning system to Git (distinct
 from tags and branch names)
Thread-Topic: [RFC] Adding a native, opt-in versioning system to Git (distinct
 from tags and branch names)
Thread-Index: AQHcV8S3ldW4ZJAz1Uu0pvK/B7r5trT22/wDgAACFW8=
Date: Mon, 17 Nov 2025 13:34:54 +0000
Message-ID:
 <AM0PR02MB44504C65BDF6C7D4B70652ECB3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB4450D1D8A6B6BB9B8AEC5BD7B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB4450024F0F7380A5DE6B2006B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To:
 <AM0PR02MB4450024F0F7380A5DE6B2006B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|DU0PR02MB10368:EE_
x-ms-office365-filtering-correlation-id: 306eef13-6495-4435-79a6-08de25de1798
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|8062599012|8060799015|19110799012|15080799012|51005399006|15030799006|440099028|3412199025|40105399003|26104999006|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTVrL1dzSVlQM1Uza0FTOFVtSHdRdnk3NGdlNDhVVm9XZStrM3NFc0M3VUtV?=
 =?utf-8?B?eFJmQVdsMFp0M2ZYZXREQVJHeG9FOXRwTm5FREEyMlZBelNmTkw5YmtuUTZj?=
 =?utf-8?B?cnBxamdHOXVacjV5K2oyT2tISjg3THRWaXNZbmRGYUczRGU4VG1NZEZpU0Nl?=
 =?utf-8?B?eG9KQTFDYW1hRXZSa0dXTFduNlg5NjI5OXNqWFh1ZXRLVi84ZGhhM0Z6WFo0?=
 =?utf-8?B?bmNtZVg1Y2U0US9SY2h1d29jenIvaHR2Ym92MW1GbXgzSHFRWDVObmNUaS9W?=
 =?utf-8?B?N1k3NHJQUFJ4WWowMzZYWk1Yb1lJSnlLelYzY0g5dXN1WmdXbkFhNk9KM2F6?=
 =?utf-8?B?MlhvbHBXcHBMQ1JwZ3pRK1pqbTFkKzFwRzFGMmk0VFJSOW9rWEVBcHFZU29m?=
 =?utf-8?B?M3lMSDJxNG1veUdjcHZ5eXJmNW5ZL2VyOTh3OFNuV0hnbmdFWlUvY0hONFNT?=
 =?utf-8?B?Nm5yWWJjc1FXWEVCUEVJd3ZoOExWTmZ4YzdsRlBaMmU0WlQ2QzU3YjVVdm4x?=
 =?utf-8?B?emd4RFVRM05aVFFrKzF6SDNBMUgwYW43TW41UmhaQ3hkN3VKd01Nd2FaeVlX?=
 =?utf-8?B?eVdCZloycWozTDM5YlFLTFJsdldTTDVVV25wRHhWUERORCtNMnFac2lBbnhp?=
 =?utf-8?B?dzFrUVJTV25mNWQ0STJ1MkMrMmJZVmZ3cWJTdlZ4Rm5oak5GY1ozMkJFNUhs?=
 =?utf-8?B?TkVyZnVDcXJDSE5QQlhUaGdZWHdJcTRnSDZmZURQVGdQTmRjMXJXWENBMnBu?=
 =?utf-8?B?eXhpQkZnVFFHK3RuYTZkNHVxUTZaSG52dkJWL3g0WEQyYXZvRjJmZ3AxMDdy?=
 =?utf-8?B?eW1IVmdTSk9IRVBjTERLaHo3ZEFCWFpIamhuajlZbTVyZVFuLzdNOXR5dVln?=
 =?utf-8?B?bUk1cDNwWWQrODZuSXRZVGJMLzQ5b2phUXpnYVNhdXVncVVqYzJBU0x1WGpO?=
 =?utf-8?B?Q2FLTUl0WHlteDZ4T0RiYkRtWm00eFFJSkhHMkhPcUp4bjRmQ3hMRmFSczE4?=
 =?utf-8?B?dWE2aHpoOHltWVk0Sk1XWEV3SGoxY3d3RTczQklNWnNJbm9Telh2dkx4cEdt?=
 =?utf-8?B?Q1BjK2xjUnRRQUVjRjVoS2MzT1JNaEVraHhSMVZjWjlveUdHUnlaeTZZMUJp?=
 =?utf-8?B?U3NJZVJxdWVhZ1V6Rm5sSVhuQ2RVUVRrV1pKeElxSDREdnR0VXd0M3V2VW1v?=
 =?utf-8?B?YjhUUUtjZ3hBZFBCUXRzejNVbnMvVlFVclFwdFhJelVicXFDSTgrZUdPT1Jq?=
 =?utf-8?B?aU1oc05RVW16VGRpc3RmUWFJRjJUd2JHempadzJqWW0wK0s5VXAxbTFLWEZE?=
 =?utf-8?B?VTJ5Rk9CV1NNdm1LTGo4cE5HUWdXK0pmMmtvYnV3NGxUTEZPMTlkMGZpbzRY?=
 =?utf-8?B?Y1lGNGZUb3ExOHBRMUFreVBJMDlNK3hVc3lVSHIvRVllRXBIMmNUdGZVNjdL?=
 =?utf-8?B?N1AyZXlha3NDOE9GYSs2Z1VhSlY1MmhTT0JkaHY5OExHQzdrVCt0aW1McGxE?=
 =?utf-8?B?amo4TW9PQmF6WmVjU2JyZysyMUg5UmxJWDQzRll3TWRtSE9mdGRKK1RZYnhj?=
 =?utf-8?B?WlBSOVZ0M1AxWVdZbmJGRmp0dGt0cHppSDZNcWlYUlNmbGxyeG8ySlZEVmdo?=
 =?utf-8?B?dGJHV0JPRzkvaHcxaHdCSzM1SkhSU09WeTNueC9FOC96VmIwR0oxeVJFTkRS?=
 =?utf-8?Q?tldSvqc8XCMrmCzWY3l9?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eElLYTFsbExnWE05V1ZNVGtBanNOdzVjcm0wMUszclBzV3JhUWVXbWIyUjdG?=
 =?utf-8?B?OTkyUzM2UEh4aysrd2ZIemFEVTlSaGdSR1pIVnNmajJEanRwTEk5d2E2MmtV?=
 =?utf-8?B?ZlllRGNUbFNqN1JPemhGR0xQN005dDBzVEdWWFhJTHo0Y2R3RjkxWWEyTE9o?=
 =?utf-8?B?alFaa001YUdwKy91d29zb0hvZzBwZm9ZOE1OaXdhMzBjTDdBL3Y3TDJnN0di?=
 =?utf-8?B?aDh5S0NtWk14OUpSdXVmSUhmcHJ4d0lBN1V4aGh2Q3VrMG5yQjFnaDh0OWpt?=
 =?utf-8?B?UTFZcWpodnhiSlVaYlZLcEJGRFZZYUNwdDBIUnpjdnJINUpwYXB4TkREZytQ?=
 =?utf-8?B?TWlWYmhDZG1NWEFGdFM0Um4rZHZKN1VDNEt2cmR3OGxuM2V4SjlNLzRkc0NO?=
 =?utf-8?B?R2wvWUpZcUc4dHdWQUZEZGJvaW1vYnlmbGxpTFVZSjRTOEFaQWYzWHJKMFBo?=
 =?utf-8?B?Q3lyUWJmcDZERlVJdk96aHBTZTFjSEVDQnhVL3lUWVpBd3VSRkM4Q2x3WTRD?=
 =?utf-8?B?V0dvZGpyQTI5Mld5eVk2ZHV5dXRaOTc5ZFVDRnVyRElTanZIZFd6SzVuaWVh?=
 =?utf-8?B?TktsQitnajVZNnQ3UEpUbTJkaTJIbk5rVytScDRJY1UxbFpGbFFEZGx0TTZR?=
 =?utf-8?B?R3FTeWNkYkI2QWZPQTZYTVZZMjV1aElacEVWOHFZNjhGUVlBYWlsV0pWSk9m?=
 =?utf-8?B?TWV0NDRGaC9ERmUwU2tpeGNBUC9vamRqWVNlQ3M4YXVBUUtDUVJXeWpSUW9y?=
 =?utf-8?B?MkVQNmpiRnNFSmxjYU12bS9GdWM3NHRQdTlTeXVpdU1BYWFCcmgzVUVGanE2?=
 =?utf-8?B?dSt6TTNobVhMeExqQll2aG1LcFdGYklObjR6eHRXbmVKMXMyVkJRMGdYNXlu?=
 =?utf-8?B?cDlmYjM3VFR2Z29NTTJyWU5uckd2V0pBRjFwb1FMY1NMeEZHTENmZFRhQldG?=
 =?utf-8?B?dWcxWUJlSWFmVW80a2JmaHpYWVlrbzRIQVBLUzFpUTVsanZJMHA2VjJzcmsx?=
 =?utf-8?B?QVNhclE2N3kyc3ozVDRHeCtvTXhrbFpLazdYOFdScmZES1d2bEErNmI0S2NL?=
 =?utf-8?B?L1RUamRHV3VWaUQvR1ozMVhwakk3NnppYUdDbzFlSDRoK1JSM0QrQVNEQ3ly?=
 =?utf-8?B?RktzNHBIc2gzam1CT0JzY0xoWFI4QXk0TXQyK3VtOEt2NWhzek8rbm1TMTBr?=
 =?utf-8?B?dEhjUEllQkkxUWJISkpVbEtyL0c4VWtxc29jMjNIZEx4NXRLT2RUL0JYY0I4?=
 =?utf-8?B?U1RlRTFoZkR6Q20zb0pBN01pUDVSUVh4MUV6bFhhb1lZb1JBT0NZdk1ZSTQv?=
 =?utf-8?B?cGlqVk02SVJ1MnZtOGd1ZXdXUTRHN2FUdk94aVNjZzhlbmRUVmNvclRZUS9r?=
 =?utf-8?B?djdvOFFZanFBak5XN1U2Rys1bFltM2pEOENhK1dEazVqczJ4bmJOZFVEZk4y?=
 =?utf-8?B?dTZHTnJBK2hWZ0xFNDYxbDV2WkdyZ2pKSllUM0ZpWWdoOVVON2hJYVhsQjhw?=
 =?utf-8?B?ZmVwR1RNOWl0eWdqNFExU0s5SlI2RGlPWFNWZnV5ZXhVdHFGUU9EKzh2YlNt?=
 =?utf-8?B?SzFPa01vUmY0WmV6VjRUaDJmMFg4RGo1WnlxMGkrRFNoa1hHNUpEN1ZtcTdS?=
 =?utf-8?B?dDJrd1kzZGRaa2xzb3MyOG9SRGpMMmxndytoSk1JY2s2Y2wxTWFmeVpOSzda?=
 =?utf-8?B?S2l6RmlaVlViSnlXempNVHNXRFNNcnB3ZTExTGpUUXFHM2lTL1BWQlk1YXIr?=
 =?utf-8?Q?rm3g6SQrdthNutr7I0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4450.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 306eef13-6495-4435-79a6-08de25de1798
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 13:34:54.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10368

IyMjIFN1YmplY3Q6IFByb3Bvc2FsOiBFeHBsaWNpdCBWZXJzaW9uIE51bWJlcmluZyBhbmQgVmlz
dWFsaXphdGlvbiBJbXByb3ZlbWVudHMgZm9yIEdpdAoKSGVsbG8gYWxsLAoKVGhpcyB0ZXh0IGJl
dHRlciByZXByZXNlbnRzIHRoZSBvcmlnaW5hbCBvYnNlcnZhdGlvbnMvcHJvYmxlbXMgYW5kIGlk
ZWFzL3NvbHV0aW9uczoKCi0tLQoKIyMjIyBQcm9ibGVtcyB3aXRoIEdpdCBUb2RheQoKMS4gKipO
byBleHBsaWNpdCB2ZXJzaW9uaW5nKiogwqAKwqAgwqBHaXQgcmVsaWVzIG9uIGNvbW1pdCBoYXNo
ZXMsIHdoaWNoIGFyZSBjcnlwdG9ncmFwaGljYWxseSBzdHJvbmcgYnV0IG5vdCBodW1hbuKAkWZy
aWVuZGx5LiBUaGV5IGRvbuKAmXQgcHJvdmlkZSBzZXF1ZW50aWFsIG9yZGVyIG9yIHJlYWRhYmls
aXR5LCBtYWtpbmcgaXQgZGlmZmljdWx0IHRvIHRyYWNrIHByb2dyZXNzLgoKMi4gKipCcmFuY2gg
Y29tcGxleGl0eSoqIMKgCsKgIMKgQnJhbmNoZXMgb2Z0ZW4gYmVjb21lIG91dGRhdGVkLCBsZWFk
aW5nIHRvIHJlYmFzZS9tZXJnZS9kZWxldGUgY3ljbGVzIGFuZCBjb25mdXNpbmcgbmFtaW5nIGNv
bnZlbnRpb25zLiBEZXZlbG9wZXJzIGVuZCB1cCBpbnZlbnRpbmcgYXdrd2FyZCBicmFuY2ggbmFt
ZXMgdG8gYXZvaWQgY29sbGlzaW9ucy4KCjMuICoqUmVkdW5kYW5jeSBjb25jZXJucyoqIMKgCsKg
IMKgQSBzaW5nbGUgYml0IGVycm9yIGluIGEgYC5naXRgIGRhdGFiYXNlIGNhbiBjb3JydXB0IHRo
ZSByZXBvc2l0b3J5LiBXaGlsZSBjbG9uaW5nIHByb3ZpZGVzIHNvbWUgcHJvdGVjdGlvbiwgR2l0
IGxhY2tzIGFuIGludGVybmFsIHJlZHVuZGFuY3kgcG9pbnRlciBzeXN0ZW0gdG8gdHJhY2sgdGhl
IOKAnGxhdGVzdCB2YWxpZCBjb3B5LuKAnQoKNC4gKipWaXN1YWxpemF0aW9uIGlzc3VlcyoqIMKg
CsKgIMKgR2l0IGxvZyBncmFwaHMgYXJlIG5vdCBzdHJpY3RseSBjaHJvbm9sb2dpY2FsLiBDb21t
aXRzIGNhbiBhcHBlYXIgYWJvdmUgbmV3ZXIgb25lcywgYnJhbmNoZXMgc3ByYXdsIHZlcnRpY2Fs
bHksIGFuZCBzaGFyZWQgYnJhbmNoIG5hbWVzIGRvbuKAmXQgYWxpZ24uIFRoaXMgd2FzdGVzIHRp
bWUgYW5kIG1ha2VzIGhpc3RvcnkgaGFyZCB0byBmb2xsb3cuCgotLS0KCiMjIyMgUHJvcG9zZWQg
U29sdXRpb246IFVsdGltYXRlIEdpdGZsb3cKClRoZSBjb3JlIGlkZWEgaXMgKipleHBsaWNpdCB2
ZXJzaW9uIG51bWJlcmluZyBmb3IgZXZlcnkgY29tbWl0IGFuZCBicmFuY2gqKiwgY29tYmluZWQg
d2l0aCBhdXRob3IgYWNjb3VudGFiaWxpdHkgYW5kIGltcHJvdmVkIHZpc3VhbGl6YXRpb24uCgot
ICoqU2VxdWVudGlhbCB2ZXJzaW9uIG51bWJlcnMgb24gbWFzdGVyKiogwqAKwqAgRXhhbXBsZTog
wqAKwqAgYGBgCsKgIDAuMDAwMS1TS1lCVUNLLU1BU1RFUgrCoCAwLjAwMDItU0tZQlVDSy1NQVNU
RVIKwqAgMC4wMDAzLVNLWUJVQ0stTUFTVEVSCsKgIGBgYAoKLSAqKlZlcnNpb25lZCBzdWLigJFi
cmFuY2hlcyoqIMKgCsKgIEJyYW5jaGVzIGluaGVyaXQgdGhlIG1hc3RlciB2ZXJzaW9uIG51bWJl
ciBhbmQgYWRkIHRoZWlyIG93biBzZXF1ZW5jZTogwqAKwqAgYGBgCsKgIDAuMDAwNC1TS1lCVUNL
LU1BU1RFUi0wLjAwMS1TS1lCVUNLLUZFQVRVUkUKwqAgYGBgCgotICoqUmVjdXJzaXZlIGNvbXBh
Y3Qgbm90YXRpb24qKiDCoArCoCBGb3IgZGVlcGx5IG5lc3RlZCBicmFuY2hlczogwqAKwqAgYGBg
CsKgIDAuMDAwNC0wLjAwMS0wLjAwMS0wLjAwMQrCoCBgYGAKCi0gKipBdXRob3IgdGFnZ2luZyoq
IMKgCsKgIEVhY2ggY29tbWl0IGluY2x1ZGVzIHRoZSBhdXRob3IgbmFtZSBpbiB0aGUgdmVyc2lv
biBzdHJpbmcsIGVuc3VyaW5nIGFjY291bnRhYmlsaXR5IGFuZCB0cmFjZWFiaWxpdHkuCgotICoq
VmlzdWFsaXphdGlvbiBhbGlnbmVkIHRvIHZlcnNpb24gaGllcmFyY2h5KiogwqAKwqAgQnJhbmNo
ZXMgd2l0aCB0aGUgc2FtZSBuYW1lIHNob3VsZCBhbGlnbiBob3Jpem9udGFsbHkgKOKAnHJhaWxy
b2FkIHRyYWNr4oCdIHN0eWxlKSwgcmVkdWNpbmcgdmVydGljYWwgY2x1dHRlciBhbmQgbWFraW5n
IHRpbWVsaW5lcyBjbGVhcmVyLgoKLS0tCgojIyMjIEJlbmVmaXRzCgotICoqSHVtYW4gcmVhZGFi
aWxpdHkqKjogTnVtYmVycyBhbmQgbmFtZXMgYXJlIGVhc2llciB0byBzY2FuIHRoYW4gaGFzaGVz
LiDCoAotICoqQWNjb3VudGFiaWxpdHkqKjogQXV0aG9yIHRhZ3Mgc2hvdyB3aG8gY29udHJpYnV0
ZWQgd2hhdC4gwqAKLSAqKkJyYW5jaCByZXVzZSoqOiBWZXJzaW9uZWQgbmFtZXMgYXZvaWQgY29s
bGlzaW9ucyBhbmQgc3RhbGUgcmVmZXJlbmNlcy4gwqAKLSAqKkF1ZGl0YWJpbGl0eSoqOiBDbGVh
ciBsaW5lYWdlIG9mIGNvbW1pdHMgYW5kIGJyYW5jaGVzLCB1c2VmdWwgZm9yIHNlY3VyaXR54oCR
Y29uc2Npb3VzIHByb2plY3RzLiDCoAotICoqRmxleGliaWxpdHkqKjogRGV2ZWxvcGVycyBjYW4g
ZGVmaW5lIHdoYXQgY291bnRzIGFzIGEg4oCcbWFqb3LigJ0gY2hhbmdlLCByYXRoZXIgdGhhbiBi
ZWluZyBjb25zdHJhaW5lZCBieSBzZW1hbnRpYyB2ZXJzaW9uaW5nIHJ1bGVzLgoKLS0tCgojIyMj
IEltcGxlbWVudGF0aW9uIFBhdGgKCi0gR2l0IGhvb2tzIG9yIHdyYXBwZXIgc2NyaXB0cyB0byBl
bmZvcmNlIG51bWJlcmluZyBhbmQgdGFnZ2luZy4gwqAKLSBBIGN1c3RvbSB2aXN1YWxpemF0aW9u
IHRvb2wgdGhhdCBwYXJzZXMgY29tbWl0IG1lc3NhZ2VzL3RhZ3MgYW5kIHJlbmRlcnMgYnJhbmNo
ZXMgYXMgYWxpZ25lZCB0cmFja3MuIMKgCi0gQSByZWR1bmRhbmN5IGxheWVyIHRoYXQgc25hcHNo
b3RzIHJlcG9zaXRvcmllcyBhbmQgbWFpbnRhaW5zIGEgcG9pbnRlciB0byB0aGUgbGF0ZXN0IHZh
bGlkIGNvcHkuIMKgCi0gRG9jdW1lbnRhdGlvbiBvZiB2ZXJzaW9uaW5nIHBoaWxvc29waHksIGFs
bG93aW5nIGRldmVsb3BlcnMgdG8gYnVtcCBtYWpvciBudW1iZXJzIGZvciBicmVha3Rocm91Z2hz
IChwZXJmb3JtYW5jZSwgcm9idXN0bmVzcywgZWZmaWNpZW5jeSksIG5vdCBqdXN0IGNvbXBhdGli
aWxpdHkuCgotLS0KCiMjIyMgQ2xvc2luZyBUaG91Z2h0cwoKR2l04oCZcyBmbGV4aWJpbGl0eSBp
cyBwb3dlcmZ1bCwgYnV0IGl0IG9mdGVuIGxlYWRzIHRvIGNoYW9zIGluIGxhcmdlciBwcm9qZWN0
cy4gQnkgbGF5ZXJpbmcgZXhwbGljaXQgdmVyc2lvbiBudW1iZXJpbmcsIGF1dGhvciBhY2NvdW50
YWJpbGl0eSwgYW5kIGJldHRlciB2aXN1YWxpemF0aW9uIG9uIHRvcCBvZiBHaXQsIHdlIGNhbiBt
YWtlIGhpc3RvcnkgY2xlYXJlciwgYnJhbmNoZXMgcmV1c2FibGUsIGFuZCByZXBvc2l0b3JpZXMg
bW9yZSByZXNpbGllbnQuCgpJ4oCZZCBiZSBpbnRlcmVzdGVkIGluIGhlYXJpbmcgZmVlZGJhY2sg
ZnJvbSB0aGUgY29tbXVuaXR5IG9uIHdoZXRoZXIgdGhpcyBhcHByb2FjaCBjb3VsZCBiZSBmb3Jt
YWxpemVkIGludG8gdG9vbGluZyBvciBleHRlbnNpb25zIGFyb3VuZCBHaXQuCgpCZXN0IHJlZ2Fy
ZHMsIMKgClNreWJ1Y2sgRmx5aW5nIMKgCjE3IE5vdmVtYmVyIDIwMjUgwqAKCgo=
