Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2070.outbound.protection.outlook.com [40.92.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA892F3B
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730597118; cv=fail; b=hM05+QzfdHSZz4ODSHKcmFLl2VQkeiE9NHGQO9oSMz3RxnYVuF2bj5evftVV4zpkFwXpN6C9HfN3K6MFQwNJ/gJwJ9boNh1ZHRvOKypWwxdEgWrikYm3pxK6BAQt3T6NZoSobpAWYxn+6jZHeHQ2SxBg/JQqKFXhACczTNv11lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730597118; c=relaxed/simple;
	bh=sSLhpHHrlbNHcKFOhwGYrfWuDIFb7UGhGai8M5q5GQg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U6wJnlVfJ8STfJbFcFZ1pt8HTqIMQzB/V1URdr7jLjM6Di+TDuUCWjutXvUBg0yKsMBMbXG/OZtJ75EmtCe+apJB/49cgUxNlOgB9AD/eCMyPtSvezZ4aYkhKoORPIhwhKybCwDnc5S3rP34hE8wRpXlBkIXNhS1E9rmp/ruSCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=Ftfqo/Q8; arc=fail smtp.client-ip=40.92.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="Ftfqo/Q8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+WEwaxtquD015EQHAaoDxzRGne3ljRk+cVN4WRRVTsH5AyddD+1bCKeGrwgQGcwmDvAmPwaIuPMBvWNsHizLYEXXzcV+BSb8A/CWtUTZtXhVHuwXc4+d9jv9QlBtNDIPZmsUhKPcnsXgQul1RLiXgVcEVfLdycsh8ek4w//maXNw85qiyiQ7C+W1+NnPmWvf2P/Bpze6m1tvNOnw/hMYZ5rw501VlRBQBqiVLY+QrxttsXl8D24PEuuFOFRoy3X453n8YGaYvdA4rOJUNKELWHGv4z5NGBQf90n8DBv0EV0ktD1syXayyAsYyVWJ8zvWaLNtL8Ykj1/w2QK2+tj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSLhpHHrlbNHcKFOhwGYrfWuDIFb7UGhGai8M5q5GQg=;
 b=Wsju/uAyEOR2G9t7Kd58qXlNKjw8RVi2YY5Xxl27Hn5GwfF4+FXs6AzpSjdaHdppYH9EP0HIFcRC8jXMBbvQZnPViK42YxtrFfU5EzvSoEncun7rq1dLDHRpO4H3sqbPoBThd1EHEmIzB21/ufbSPynigKjsJCjDGQ5madZIjbIb6dHHUwTxY0BFMoo/incs0vnhZYHZjrJOiN2Z/3HNkJDJB/I5H+V6g5XW9xa1dqLmPZLHvO2CxPQwE3GfPjdkfyRiYuaL+agIQji9YVMVQUo1oerXXv5zBiT6XhodF9tUUxOCDCBybz0Bc7HInTqU/aE58GyjhLOp7KGQUOC0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSLhpHHrlbNHcKFOhwGYrfWuDIFb7UGhGai8M5q5GQg=;
 b=Ftfqo/Q80dErVz6+R46qpUWZ4f65xsUedx+HRohT1a+0VP6TU7F/AQPizztp8y0BWTujrHbWVy4zZ14wzBnQFaK0v68RL7LZCK3Q30ilweZex2UKI+pNeuPBywB7J61aYQIqDIEC/hAc9lSeMNpNs9WZge8UlW6aSvKCQRgNszfL5sotLIrNphmIBdAH7vhzyZp7hP5ezfMUgXXVchoRJ+tiDdRWwAxgBzb8qr7l5/8pQhKNqNqJNA5VW4Wk8IhF4UmumFNdiUPfllswhznQ6TxXh/zg9+t8bQeysHyYONCTqRXbk9Cys+Pnyce3jbGNpPc+wjj8tB9rgppNTnIOEg==
Received: from AM0PR02MB4980.eurprd02.prod.outlook.com (2603:10a6:208:fe::16)
 by DU0PR02MB8094.eurprd02.prod.outlook.com (2603:10a6:10:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 01:25:14 +0000
Received: from AM0PR02MB4980.eurprd02.prod.outlook.com
 ([fe80::7dc:f782:3659:60f]) by AM0PR02MB4980.eurprd02.prod.outlook.com
 ([fe80::7dc:f782:3659:60f%5]) with mapi id 15.20.8114.028; Sun, 3 Nov 2024
 01:25:13 +0000
From: Marco Stephan <marc.stephan96@hotmail.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git revert cannot be aborted if the repository directory has been
 copied
Thread-Topic: Git revert cannot be aborted if the repository directory has
 been copied
Thread-Index: AQHbLYr3V59uWnSviEq/qZGwhvgUwg==
Date: Sun, 3 Nov 2024 01:25:12 +0000
Message-ID:
 <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4980:EE_|DU0PR02MB8094:EE_
x-ms-office365-filtering-correlation-id: 25d9cdb5-a797-45d1-d450-08dcfba65d2b
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|19110799003|15030799003|461199028|15080799006|7092599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXNiWUpINjlqUUFGVkc4TnI2QjhOSFZrVU45Z0w4VEdSTGVMTGxZMWxHMDZo?=
 =?utf-8?B?OUgwZ3RVSHJ4TGt0RXlVN1p4Um5uMk0zSk1jSm5tNWUydXNIRmp1ckg5cTQr?=
 =?utf-8?B?STlwZkVnUFBpbU80SlhuTkd4bWc5OEhzN2MrSzhibjZxUVo1NHNSd3pKMVJF?=
 =?utf-8?B?TUFFQXR5M2hkbkNPdkhVc2NibmZWYW41M2NaN3hrM2VDdWxuTGpQaTRCa1BW?=
 =?utf-8?B?MVlnYStjZWZON3JOVFZEUDJvSi91N21ZMTZPRE9YNkx1S1M0NlQ2RDhnK2oz?=
 =?utf-8?B?UzJsVktKcS9MVVpCdEgrUlZqeXFMTHRFN3MraDQzRXZ4b0JqaGptVll6aWFx?=
 =?utf-8?B?N0lxdW9ZYW9CSlk5MlVHazZndmhiaGM1UHZkVGJVRnpIbGJsU1RYWGM3V1RB?=
 =?utf-8?B?eHdVQng2R1VXSnBiRHo2Tk05VGw1SzFSUW51aTJiTjlXbk0xVlhVdEtmV09y?=
 =?utf-8?B?WVU4bFdaOUVUZUhIbXVycVd5SlVKQ01FUmNBc0dhbllza3A4aXJ5YmlXYXFE?=
 =?utf-8?B?SUhYUWQ5ZE1Wc3UxU1h0NGt1VTVRa09DYkhrZzRaT0tLTjJqeFVpTU8xYWZr?=
 =?utf-8?B?aTBZVVFSckJGS0d5QjRoblUxZ3RZMjNuaDNYY1BRODRHQklaMFVoZjdGT0hO?=
 =?utf-8?B?RzMwLzUyY1IrUEhnQjk2Y0pINU5kZHk3ZmIydGZxVVptOVhlL2ptR2NONWtS?=
 =?utf-8?B?Z1pzZ2xwQVErcHN5RWU3NkVaTTNOTFhYakR2NVlQYTNvT2thWkc0MTNaTURC?=
 =?utf-8?B?N0NGdGtkeUNXUTE1UnZCaWF1MFdqNVA5RlhFdDVBSTUyTkZWSGNoQWRUQ05t?=
 =?utf-8?B?eVZSbk1vcTVwcW9iYU9zcGRZa3NWenFZZmtOcXJhS1QrNG15eHdTM2lmWDVN?=
 =?utf-8?B?UkhwS0VmZDl1dXdxMUpZckhpK1NvMVJwZ29wbC8yeFVUdC9RUUtRaVF4amNx?=
 =?utf-8?B?SlJZelV1Qk5TZjJ4elQ3cTl4YzNjUXEySUdYcHd1ZThoQjZuUUhhNWVLWDhk?=
 =?utf-8?B?L2pFRitnL1pPWS9sUjRCYnRreFJEUEdtcmJyck9GY09lT2NRRXBRTW1yOHZh?=
 =?utf-8?B?bjlUanViZzZBQlhJRzNDYTdSZEF3WG4wSUdEWW5pb0dHbVN2K0ZBZmhNYS9V?=
 =?utf-8?B?Y3JlV2R4aEJ0c1BmVEptcERtdzUxZkpVaHpKTHRmT2pwT2M5SlJHTW5hMU5M?=
 =?utf-8?B?MTlXeVRXcWtiRGlqTnVjcnhwVW80cVd1bEVYSUJYVEpZUDZaeWIvMjd4eiti?=
 =?utf-8?B?aHFoYTFnbnBRa3IwM3hzMmNLK0FMZ3QzM1pLc3NTNFdUVmFwV3JONFZpRDBS?=
 =?utf-8?B?ME1VdkpXMGZmdlIwUnJUbjhsMnpmZDhWaTFRSGJBbjFaZHovSnA2NEpnSzBa?=
 =?utf-8?B?enNSdG4vbi80SDVRYjVkOVh3VlhEd3haRExvZWQwQVBiUVo0dzZGNjBvZkJF?=
 =?utf-8?Q?a+nTBCaW?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3B6RnpGbHNUZDJwTkk3eW9lcVEwdnE0cHVDNHRFaFJXNjZUYzFEd0FQK2Fj?=
 =?utf-8?B?Z1M5U0QwaTVGNGFjZmhUbzRINjk1ekhvOHh6ZjBEbUtROEx1ZEFmL0VGdWFF?=
 =?utf-8?B?ZVFCekdNZEtGQmRnQjhLRis1TCsxOS96b3JZUnhOaUdKZzlsVUR2V3B0bGRZ?=
 =?utf-8?B?RmhzLzkzTlpraWh5OHE3bVVLaUdrZXpoZTh2ZDg2ZDh5b283dW51SHZYMkx2?=
 =?utf-8?B?S3QrSUNYVk11WlBhQWdlb3VLL2FvWVMwN3FRTnRJS1UxdGtPblYzL05hQkxr?=
 =?utf-8?B?akFCa2dmenorQktIMWo3a0NKdk5zbUwwQVpBTDVNbThqTXpWU2p4R1AwM2VB?=
 =?utf-8?B?R2RaTFJ1YXZOSnd3TDRjWDFnREE5RmtvSVBXWDJXZDUzTEpmWTQxR0U0Y3ZT?=
 =?utf-8?B?TVNuVUNjb05BQXcrUXoyVmFqa01LWUg3Nm9lVkFlSW1wcnE5NGtsVU5zMzIy?=
 =?utf-8?B?YkQ5N0d2aUF4VnRoVzVKUHpQb2RBZXN2VU0yOUwxcEVwQ0RWK0t6VVRSdWNI?=
 =?utf-8?B?dXlEYW0zS0RQdjAyd3psaHZRSjROTnJDUVdVTjVzYUxuUlVOWUFtN09wSGov?=
 =?utf-8?B?d25rWWlvaFFwaVozdlV1YVI2Rm9VK29qMm5ORksyd1JuVzRCQ2lkdzFOQURj?=
 =?utf-8?B?R1pvSUhuV3czRVNNc3RPYjFuRlpFRW9rbnNHNVBWZXBIU3VhMzF4blhzS0Nt?=
 =?utf-8?B?SUYzbTEvcVVJU2s5YmJFeEdKZzRXbCtTOTZzMm9IWGJUc1M3S05rOXFUbXZn?=
 =?utf-8?B?M0N6Wk1Nb2l2MXMvTVJMUWV3LzcrcXJiUmlpUU0ybVVqRjFYS0NPMWFWUk4r?=
 =?utf-8?B?TGZqY3JJM0VrcWtBbFE3YlNTRG1tcitoNUd5M2t0Rkw1QjB1SDIzSWNyQUdh?=
 =?utf-8?B?ZCtLYjhGMDMrTnNIVkN6Y0h5WDVwYzNmMGtjbkNrWlFSQ3R1UzNRL0dYQVNU?=
 =?utf-8?B?MnViRkU0bEEvWjJnYlZXYW9QOEdPZ2E5ZElNUzh4dHJ4WmRsVnM1enU0N3lo?=
 =?utf-8?B?Zm9yQWJIb095QzU1ekdjc2h3bithdWgvWjMzU0ppVkhIMnMvWGp5ZkNqVDhN?=
 =?utf-8?B?czdvdWE1WmRyazJqSXpqVnZjdkgwTzhrT0VhNTZzdzkzMXk3NkhGYm1idmh6?=
 =?utf-8?B?RFJHc0JWMFFLcVVvVk5yOU9YU3B4c0g1NHBRQys3dW9pSFEzZDVaamkwbjM2?=
 =?utf-8?B?aHFodklIZWR0azhtWnBBR2ZsUW9QQTl2NFIrWm45RFh6UXR4OUZ0Zm9EaEZR?=
 =?utf-8?B?TzRXYzd0SU85aW1XSzRkS0x6NGhHenVtTEpkTStyeHdoeXE4eEtSTWhjbmM3?=
 =?utf-8?B?TWpzekJwZmhlZk1nNFlkTUtXZlVuOWtnMTMzOXlFVk45VzAwV2N2NmZZVWVl?=
 =?utf-8?B?OERpMGw1RlMxNGtURWFmbEZkUUd0L0JERzRka2dzN0g5dG5NMjJoMzErM0hX?=
 =?utf-8?B?c28rK3RlRWdDR3JkNTlNK2RVVEY1dTNvSlo0cXU2WWptTUpiOFJzTmhndlV0?=
 =?utf-8?B?QUFYbjNRQUFqbFJnRks3bjEvaEpKbm1pUHZ6K2E1ckJMenB1SGdXMGxLYVJS?=
 =?utf-8?B?WGNqN1p0eU5rTStUOEJib1hDYjZwOWxOc2ljOFhDNEMvenFlWmlld2p5Tm5p?=
 =?utf-8?B?UUlBU2c3eDB3a0FpNmh5cGQ1Nld6MnNPZ2tEWjRlb2M0Kzhxd2NTeHd2UHJQ?=
 =?utf-8?B?cUJUOFd3YTJ3bUlTZzFrR1JOR0lVeVFLVTV1b01JdmZPV1JQbTdnKzU1clFJ?=
 =?utf-8?Q?Z+vD+zJd1n8K8fQlzw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4980.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d9cdb5-a797-45d1-d450-08dcfba65d2b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2024 01:25:12.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8094

SGVsbG8sCgpJIGhhdmUgZW5jb3VudGVyZWQgdGhlIGZvbGxvd2luZyBidWc6CklmIHlvdSBjb3B5
IGEgR2l0IHJlcG9zaXRvcnkgZGlyZWN0b3J5IHRvIGFub3RoZXIgcGF0aCB3aGlsZSB0aGVyZSBp
cyBhIHJldmVydCBpbiBwcm9ncmVzcyBmb3IgdGhlIEdpdCByZXBvc2l0b3J5LCAiZ2l0IHJldmVy
dCAtLWFib3J0IiBkb2VzIG5vdCB3b3JrIGFueW1vcmUgZm9yIHRoZSBjb3BpZWQgcmVwb3NpdG9y
eS4gSW5zdGVhZCwgaXQgd2lsbCByZXBvcnQgYW4gZXJyb3Igb2YgdGhlIGZvbGxvd2luZyBmb3Jt
YXQ6CuKAguKAguKAguKAguKAguKAgmVycm9yOiBFbnRyeSAnLi4uJyBub3QgdXB0b2RhdGUuIENh
bm5vdCBtZXJnZS4K4oCC4oCC4oCC4oCC4oCC4oCCZmF0YWw6IENvdWxkIG5vdCByZXNldCBpbmRl
eCBmaWxlIHRvIHJldmlzaW9uICcuLi4nLgoKSSBjYW4gcmVwcm9kdWNlIHRoZSBidWcgY29uc2lz
dGVudGx5IHdpdGggdGhlIGxhdGVzdCB2ZXJzaW9uIG9mIEdpdCB0aGF0IGlzIGF2YWlsYWJsZSBm
b3IgV2luZG93cyAoZ2l0IHZlcnNpb24gMi40Ny4wLndpbmRvd3MuMikgYnkgcGVyZm9ybWluZyB0
aGUgZm9sbG93aW5nIHN0ZXBzIChhbGwgY29tbWFuZCBsaW5lIGV4Y2VwdCBzdGVwIDEyKToKMS4g
bWtkaXIgdGVzdF9yZXBvCjIuIGNkIHRlc3RfcmVwbwozLiBnaXQgaW5pdAo0LiB0eXBlIG51bCA+
IHRlc3QudHh0CjUuIGdpdCBhZGQgLgo2LiBnaXQgY29tbWl0IC1tICJJbml0aWFsIGNvbW1pdCIK
Ny4gZWNobyB0ZXN0ID4gdGVzdC50eHQKOC4gZ2l0IGFkZCAuCjkuIGdpdCBjb21taXQgLW0gIkNo
YW5nZXMiCjEwLiBnaXQgcmV2ZXJ0IEhFQUQgLS1uby1jb21taXQKMTEuIGNkIC4uCjEyLiBNYW51
YWxseSBjb3B5IHRlc3RfcmVwbyB0byBhIG5ldyBkaXJlY3RvcnkgdGVzdF9yZXBvX2NvcHkgdXNp
bmcgdGhlIGZpbGUgZXhwbG9yZXIgKHVzaW5nIGUuZy4gInJvYm9jb3B5IHRlc3RfcmVwbyB0ZXN0
X3JlcG9fY29weSAvRSIgZG9lcyBub3QgY29ycnVwdCB0aGUgcmVwb3NpdG9yeSkKMTMuIGNkIHRl
c3RfcmVwb19jb3B5CjE0LiBnaXQgcmV2ZXJ0IC0tYWJvcnQKVGhpcyBjb25zaXN0ZW50bHkgcHJv
ZHVjZXMgdGhlIGVycm9yICJlcnJvcjogRW50cnkgJ3Rlc3QudHh0JyBub3QgdXB0b2RhdGUuIENh
bm5vdCBtZXJnZS4iLiBJIHdvdWxkIGV4cGVjdCBzdGVwIDE0IHRvIHdvcmsgcmVnYXJkbGVzcyBv
ZiBob3cgdGhlIHJlcG9zaXRvcnkgZGlyZWN0b3J5IGl0c2VsZiBoYXMgYmVlbiBjcmVhdGVkLiBS
dW5uaW5nICJnaXQgc3RhdHVzIiBvciAiZ2l0IHVwZGF0ZSAtLXJlYWxseS1yZWZyZXNoIiBmaXhl
cyB0aGUgc2VlbWluZ2x5IGNvcnJ1cHQgZGF0YSBhbmQgdGhlIHJldmVydCBpbiBwcm9ncmVzcyBj
YW4gYmUgYWJvcnRlZC4KCkkgaGF2ZSBub3QgdmVyaWZpZWQgaWYgdGhlIGJ1ZyBpcyBwcmVzZW50
IG9uIG90aGVyIG9wZXJhdGlvbiBzeXN0ZW1zLCB0b28uCgpXaXRoIGJlc3QgcmVnYXJkcwpNYXJj
byBTdGVwaGFu
