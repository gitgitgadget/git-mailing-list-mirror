Received: from gw9138.fortimail.com (gw9138.fortimail.com [82.98.199.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F49190473
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=82.98.199.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128851; cv=fail; b=kl6thj0LHojm+TDhOX7acV9L/nZGz/PgZPgLQGx1SGsqSuKBcwnEGqwb/xSFhsZVcxMGmWbH01agxQsjUXpSpyuyF2iycIJPzQ28EIcKBNB0eYPsfYQ/gbIyZE2a8p8J484CKgmtNTozaHSZTwND3WWh7dbD7F0CjTN31HrzwXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128851; c=relaxed/simple;
	bh=CtW2aMH47dtt7QFgc4lq2OePjL1x5PRB7HQMQ+oW0Ps=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fOCOBrl79xvNM9xo5xokqawZWo0P/JKq0lttNTCQFJ88JmCfGYi1NpsGC+NgEEAngeYPIOFfF/SPPyTkJbVTtmkeaMuux0nFGliTgCj/G1uTY5yZFcKL2A7INX6cJg/14BHyfztvKX1zu7xDdVyjG81eAyF64pviZWteeXo9IVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tr-advanced.co.jp; spf=none smtp.mailfrom=tr-advanced.co.jp; dkim=pass (1024-bit key) header.d=tokairika.onmicrosoft.com header.i=@tokairika.onmicrosoft.com header.b=d5ig2Xpd; arc=fail smtp.client-ip=82.98.199.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tr-advanced.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tr-advanced.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tokairika.onmicrosoft.com header.i=@tokairika.onmicrosoft.com header.b="d5ig2Xpd"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011032.outbound.protection.outlook.com [52.101.125.32])
	by gw9138.fortimail.com  with ESMTPS id 63E17RWc010281-63E17RWe010281
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 10:07:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0FqnnfM7MAWIDcvzs9iAszG7cTGPy4ULudUPXN/H64fNs3cq+eAh+Ql8NUwGajo9vSYFBL9VWg7ZeJ/LWw83O37QA1qpONOPShMVLxCHHcxCR6BSdipZ3jjLG7Jdjv2mzlRdBsAb7tWr4wxZbAV/1kyggJmN4Us7X3YH4rj6EGtPWueH/GMDia5AejUQ2clPg68tLAnvCYF1+cxo4FwJ/Thu3atBiBNX2MFcINPrbaSfahMaRUDuFP94HuaEkLB9LTSUcQcgV99j5FnLq5dLa376wyxuFY57IXgsnfGz1NbwU5Vs8deJw1Uo/xFGce30xmFWYcBFlCaxw6n//Iqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtW2aMH47dtt7QFgc4lq2OePjL1x5PRB7HQMQ+oW0Ps=;
 b=vDnL7sI2hhRs2JMG9lOPgYwDOyLStKvLFu156IGTnUOIVK2MPuXFtI1bal5xoKIhA/861YpuxAE2Ay0kqDZIFkGovjDC879rEjvg+zlhhv1FQk310DG/dCURyXs2O8AUGgdApDrIol7aM8ktV73lxH6kSro7wl/SZZxBaHKPjajWDmTlVLkV67o7+oh6yTlz8gqfTyXz5hA50vQNxiaZd2h7LxJYvg89J8Yn3tJjFbzuNufGEkBChk9z5Tl7jD/3EufSUDGwuaESB14h/KruEmfiEU2mnLI4NlHCoBe3VW5cWH6CKNtoEmsnFmrs6IIZgITlNzsK2BYuW9XpdOYvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tr-advanced.co.jp; dmarc=pass action=none
 header.from=tr-advanced.co.jp; dkim=pass header.d=tr-advanced.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tokairika.onmicrosoft.com; s=selector2-tokairika-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtW2aMH47dtt7QFgc4lq2OePjL1x5PRB7HQMQ+oW0Ps=;
 b=d5ig2XpdKdJ5p6Eqo9lORElRN42IhGLlCRgM2Z3s6lbkGdrfaaJkGPM3Q1DPgXN18jzKYcoFvb4ihgTeWI69/zZoLZVA/4gawmGCiS8OVsBITRLycCm4AJ7erJdAOuPFJnJiunVnNsbVzI018oaNu4MkJJ4jO25u+QLhLuc3oBY=
Received: from OSCPR01MB13450.jpnprd01.prod.outlook.com
 (2603:1096:604:32e::14) by TYRPR01MB14126.jpnprd01.prod.outlook.com
 (2603:1096:405:223::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 01:07:24 +0000
Received: from OSCPR01MB13450.jpnprd01.prod.outlook.com
 ([fe80::8fd4:6b1d:4f1:4b46]) by OSCPR01MB13450.jpnprd01.prod.outlook.com
 ([fe80::8fd4:6b1d:4f1:4b46%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 01:07:24 +0000
From: <kawai-m@tr-advanced.co.jp>
To: <git@vger.kernel.org>
CC: <hattori-m@tr-advanced.co.jp>
Subject: Subject: Inquiry: Git versions you provide and Windows 11
 compatibility
Thread-Topic: Subject: Inquiry: Git versions you provide and Windows 11
 compatibility
Thread-Index: AdzLqvIiPp8/2/suQwqpKO+g0SPM4w==
Date: Tue, 14 Apr 2026 01:07:24 +0000
Message-ID:
 <OSCPR01MB134507F2EDA90C775EF1DC571EC252@OSCPR01MB13450.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tr-advanced.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13450:EE_|TYRPR01MB14126:EE_
x-ms-office365-filtering-correlation-id: c760ca22-0d6d-445a-1bb0-08de99c23025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|42112799006|366016|1800799024|38070700021|3613699012|18002099003|56012099003;
x-microsoft-antispam-message-info:
 NY2q4y+4iQCzpn5q4QicKhWrfFQ0Jvy6Zeo5cMjZQTWptWiIFCBPKwT1V7EkCQswKGCRVi5Yxt8XqJagRd4PNFk0BIr6Vya0ENA9dYSKJtJF7F0yo0JsL6HdPXphtczjK+cciePiQZtsRyUvycMsTXthGJTGHX9k77Wc/T4vG5u2KYD1OwYwTWFACsPEVSBVVowdkzwPVx+uZj6+ExEV7k/xkBQX+CFbsZJygi+xpkXgaxS34ubHPlE9wcxDWYAX2e6U+XvENLVDZp71FRiWBNOSfWV/ZZPRTff4Hs8Rkmi0aINx54YCel/SzIaPzzV1MI0PLQtJHmVSpz22VYrSSvVxCN4+BOabD93lRwlJYWr55m6jTPOudsEV8iV9RWak6QV5Eh1vEjR1RcjUoXRw982jvfCt5E5ckUNJBmUsA95sogOid3ZrMy1bdjaVfsG5W7TYGe3kdqPszoWlbk9AON0R0RszBN3NGJJ7Z8tr3zQ5v0g8PLWL9la8/0ZcGMLivenWtavRVJ4Yx7+x/9qSTCBJ2JrjapW6niTA2yL6jHlW2lCFtkJUFkf3k9jIoEUSk95n6FyfXf36UKwlcv2nrMdgR1vbzZEXwz8hJXK5EMprDZme9E7sKYAsvlcrVYl0oXdZ1xxjIXeCCFJ73cVeyPYMLsbhyqgRHJCjFxE4n+jikzpxWh4V3HoomX9+BlilG4VkTt+sJ4Vj+bNhAxdwuRDeQe4leFEbSjGIc45g+2blOMM059fhFhkFkIkFy67ulwY0qXaWzm7gTzQMe8f1KA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13450.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(366016)(1800799024)(38070700021)(3613699012)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UDZvWWhvMmtGbmhYZnQ2Z0dVUmZiQmxISDZhOG8rdGxsQVhCNFl2NWs1?=
 =?iso-2022-jp?B?dmZaZVZ4WEttLzcxcWxvVXkybjhGc05qOGYvL0dTaFhyenZ4QUJiZFJX?=
 =?iso-2022-jp?B?NUp2eGx1MmFWQVJscHpFRWRtVmE5TDg0M2dFSERpZDg2amhoMzluNFBV?=
 =?iso-2022-jp?B?UEZpV3V2M3hGSC9CNUVpVVVkT2hwd2kvdlFGRnhES0U3bFZsYWs5RWIx?=
 =?iso-2022-jp?B?MGozY2FHRGNrT3lBalZUTkZSc2JqUTlReVRWVCs2dk9EZXFkVTZzbmxG?=
 =?iso-2022-jp?B?NnJMT0ZLWGRiUmd3UE9aSXRJOTdSZ1VoVjBjSmQwWjhZbER5Z1YvVnY4?=
 =?iso-2022-jp?B?WlFnQ0ZPclFsdisvMUxwRTdTYW5nd1lWeGRBRy9JYTZwcFpiZmNyVHNP?=
 =?iso-2022-jp?B?cWhMVzJwL243Y2svdFd1K2ZDWGU2cXdXNEY5UlFKUlhBOGlSb2pNdFBS?=
 =?iso-2022-jp?B?T2RNcVkvdHBWUGp1ZDd1MGplQ2lPd1IvdHJkZVNyc2JFaytWamZvN3Rj?=
 =?iso-2022-jp?B?SjFNVEJCTTQyM0o1QlBvTVNMU0k5amRWN1I4eGVrc1ZMNlBPekNDbDBM?=
 =?iso-2022-jp?B?MHdMM2xCZmVpakpHc29NY1lrTkwwSUhEVEs3UWd2WHRtblBBTEk5M3ZB?=
 =?iso-2022-jp?B?TlV4MU0vNzV4TVdOQWd2NGhTU0x2ZWxVN21KLzJtWStXdkJZelBaWDU4?=
 =?iso-2022-jp?B?WFd0QUVRckVJY1RURzNabGY4UENSdmt5WEtFZ3psdWhzUURHSVZUVFpX?=
 =?iso-2022-jp?B?TTMwZUl6OXFJZUFNS3RTQWlpMnduOUNqVGJlcWZKSERhK2hmQ1pQWUdm?=
 =?iso-2022-jp?B?YVVBcXQ2VERpUWFFK2M0U2ZWTFVOd2R5aE5WSXpZblJOaHVlK0w4aSt5?=
 =?iso-2022-jp?B?TU42YWwwbXlPbHFTa2FjRzRFMlZqN2JpdVlMSWljWitNc2htcFA4Z1B4?=
 =?iso-2022-jp?B?RTFnbW9HaUVHdysyd25LSlhld2VRWVArSjVXQWQ1K1dkLzV6T213S0FD?=
 =?iso-2022-jp?B?b1pqZ1NSUnc4NXJFTW5iL0liT0RzQmNEL2J0Tmxta01LcWhyZUcrQ2Z3?=
 =?iso-2022-jp?B?RkhPNzM5NGxMN0hCSG83OGRuTGtrZGpqVXFDZVRSdHE0T0I2QTQwdkRn?=
 =?iso-2022-jp?B?aDJTbjg1ZENsd3FZbnBrNFhXek9ZZlZ3K3RyWjRSc1oweHFkRVY5cHFU?=
 =?iso-2022-jp?B?b1duWm81UE5VSmxWQVNXaFlySXJVeW5zYmVzREtuTjRBRUFYWmp3T0E5?=
 =?iso-2022-jp?B?QXEvSlU5alo3NTJpNXVqLzh3K0JFS2g0K1ZQUERUZklJRkFwYUVQb1N3?=
 =?iso-2022-jp?B?VUxBeXpKczZ1WmZOYzQ0NjVwMUZITHlLdjJ2a0hZK1FrQndPd295bUxk?=
 =?iso-2022-jp?B?YjVueENYbnpFclY5eVI3dCt4YXhQakVYNG9JUjVrN3FUcVcwZ0daRlVZ?=
 =?iso-2022-jp?B?U2dURjI0V2lMWEY3ZXd5ckd2YXkzV2hjVlh3bTgvUDJ0SE4vZitGWC9q?=
 =?iso-2022-jp?B?MVhOa2xQQ1lsZFFpcEgwNGVOb25MVVUrQTJNRFJ5enkrQlMrOFhxcVNv?=
 =?iso-2022-jp?B?aThDT1J1S2QyTGpwQUNOVkVmZGtnYU8wRkVYRElJc1lwR29NZmJNMlRw?=
 =?iso-2022-jp?B?bEZ0UW45eGZPbDlQZmZ1YzkybGx2SUtYOStPb2Q0Tm5aNnlRc2R0bVhI?=
 =?iso-2022-jp?B?WVk3aWl2eHo3YUgwYnN1VnhObFE3YU94QUFlUE5uNURndjBEZGZrS2VI?=
 =?iso-2022-jp?B?VE1KZG1WVi8zcWg1clc1aTFvQ0s5UGlwSmlpeDZ0RTNZSjZ3dUlNOCtj?=
 =?iso-2022-jp?B?cWsyTjVWSVZocCtXdzY3OG03c0gwZUtQNjcvNlNUNzROZ3ZEZ1NOUnFT?=
 =?iso-2022-jp?B?U0wwTWNIWEp4NVZzQ3N6akNDbGh4TVVKdXhLdVg5L0lmZ1E4czNTTkZn?=
 =?iso-2022-jp?B?dkFUZ2xpSU1HSnE5QlBlWVBHWjM3WG9JendoOEk4eEcyTzNJcEtlbDdy?=
 =?iso-2022-jp?B?Mjh1SlppbmdmNjNjaVdya2dnQjNZS2NGWnNvWG9BdEV2eGRRNUY3b0Fj?=
 =?iso-2022-jp?B?R09pcnZyZTEwTGlxUW10MC8rbHh2c1pOR0FHb054dE5NSHNJK2VaUmkw?=
 =?iso-2022-jp?B?cmYyb2VHcW81QmYxWUd4R0xHdjFpUk5uQnRxSGpOdU0yek5TejJ5MDZy?=
 =?iso-2022-jp?B?YmE0TUozV1BsOE1SamVuamZUTVJ5bGRuekpCdG5kdlY1R3I2SERHSS9E?=
 =?iso-2022-jp?B?WjlONllXS0hmVnhZRjAxUFFVcG1HTjJDREJVWWxDZjB4VUNCbGpOMkRh?=
 =?iso-2022-jp?B?UW5qMHZvbHUvZE85Vm95RkN5MGNXMWRxWGoxTDYxRFE2d0ZJMmQzcGlQ?=
 =?iso-2022-jp?B?VVhVYS90Nk83bTdXNmg3OXJURW56ZkwrYkxNT01jeHg1OGNDd2c2VWJh?=
 =?iso-2022-jp?B?QkZiZlo3VUZZOTBzSXhEazl6Q2NVdlZKc3RJR0taM3J2S2I2ajBXWlZX?=
 =?iso-2022-jp?B?TkcyYTZOaUs2UmQzMTR6YzYrazNMekhwY1hXQT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gRsjbS9uVwxaz7GMDPVNa+PL2uQ/mkDm3CMH/CoohKYg9iN7W8ptra7N9J7buEhwdzdECf0+m6bKu6iG/z7n3tc1I3Vwmq4FQGcnuvcNi80d4OyHktAfv1pBOzcdyK7vmeOzUKV/EqZ0teCBLSpLn3i2Ryke1iDEwGc6bTFpeQg6/J3PRJy5DDYiJseKh1Nw1wda0V/zQHqbJjf3SJC2iPHw7GDbVXIb3xPxj+iR8A5oiJcGd6oy+MCapn4bfP3KdZsPpzuafEhMXA83ngwqlGRj28vmEGDazhq6zOkCQIpvbYPWqbKTJm6QrgNmP9+l6ykLhOUjTxFGtK/OsLea1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uy5g2bZk38n5e3DJ5fog1LGZgpklduiWCYP+bfJCfZuZMO5Hys2ZDQlItfsaPtAtWxWrZSu7XChTEh46sp00DnDY52uQ0TyHC2S7lrHsdNwzWLe+UjE6oOx03Ep2a9mgTo6CIt2/xbQpzb7UeVtGmlRUH6ZYDVRBlkALnFpcG/PwXitko/uGehNBUmzd4T2T62dq4VOXHoo0fGC5bTnZ8+1XbCvaPnX51fUMTixT26Bn++drCk5Jh5NkRa+b1N0mlaUJsRonz682Maopg3v9+MKvrrFct30Gj+p1Sk7QWRCyUw12f5MKzd0Ey69vThDRttqAJ1DgPQ6XkKW1gSY/hteip7RhSDoGXVzfdTvr1ikrA0TWgxWS3KAANouuBHHzgTHNP56RcUU+sBCc36G1/0r0Gueygk+9oLAo2uh2wIma3Q1noJYJgCg1WYRy6lQ3XZV8iZ4HfUzri4YLTnbGBSA/Q/3+fNvTRCfwuBBH1FNM6oM2MtFqsqQEoFENEhzquFV9rAcTBjY/vrVFZ43PAayyZJYEdKTXKWWj/ODmBQkr3o2UQMiQXn8xsJfyBUF+LGGNUWwrcPbwjB/SHflcNyraGXeHH31B6c32cKVX2bykez8Kzcezhgc2o/YXKtoi
X-OriginatorOrg: tr-advanced.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13450.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c760ca22-0d6d-445a-1bb0-08de99c23025
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 01:07:24.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8d8aae5b-4dc8-477f-966f-70bb2d9eaa30
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcjFPDzeta10VvWwwSqylXAu1TreIOSESRsZohKoFemuBnociznka16Pves6GpcCWoLzzegv3LoAIGjVw7pe+eJtpCMIrVYFiNpNuTmM6L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14126
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lJTslWFhYWlpfW1teSFpdSAMJHwkBRQUoHBpFCQweCQYLDQxGCwdGAhhIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZW0hdWkZZWFlGWVpdRltaSFBIWEhYSFlIWEhYSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hY
X-FEAS-Client-IP: 52.101.125.32
X-FE-Last-Public-Client-IP: 52.101.125.32
X-FE-Policy-ID: 1:3:14:SYSTEM

Dear Git Development Team,

Thank you for your continued support.

My name is Kawai from the Advanced Engineering Department 1 at Tokai Rika A=
dvanced Co., Ltd.

I would like to confirm the following regarding Git. As part of our migrati=
on from Windows 10 to Windows 11, we are investigating whether Git can be u=
sed on Windows 11 in the same way as before the upgrade.

Could you please let us know whether the following software versions can be=
 used on Windows 11 without any restrictions?

Git version 2.51.1
Git version 2.26.0
Git version 2.29.2.2
Git version 2.32.0
Git version 2.32.0.2

We apologize for the inconvenience, but we would appreciate your confirmati=
on.

Sincerely,
Kawai
Advanced Engineering Department 1
Tokai Rika Advanced Co., Ltd.
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



