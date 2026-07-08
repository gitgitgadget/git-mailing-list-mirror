Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012063.outbound.protection.outlook.com [52.103.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC5175A7E
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475483; cv=fail; b=XRs3lT5mkZLa96EkNBFQbxROH2xLH26yWXSDvTP8Lc9PYUMSD25Pj3hOVV+JFEmerNsVzNEkZDvPxPhHepPnbq09u8SFJ8fBLItFJcdenc9PZk87LqiBNkmFt1ibumwUlTiI22tZogGRqkfEP0QOxu7vVagKDW+jvQ5ZeEAGAMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475483; c=relaxed/simple;
	bh=wBbf83AAUdkRLNjgyCpPE7v+sbaaMZ6OBjkX/CgfEjI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jMxI9JlccTdNgkWhiF1u8h/kxLGcKL4gXCCZPjtq34uO3yN/dwrfvELu1HaXvJ3fezKO/5Ya2S618ZSWjhKCHnU12iefcXoKAwOI5JVnfuVU97jsHi1f8GhQ5nPdv/QMZob+M6DtnV1iVIQQKuUlgEitnkH8EoURNgtglfDc0Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=diX34MFt; arc=fail smtp.client-ip=52.103.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="diX34MFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxN9QzgodIjHFnADm4Ic2B3MBQQmt3DjbsBFDqQvc0yf2TG9450tgtxRaC8zEn7VUzsxA9RwE8G83XiqSWzdduOkeLQIfXS1H1ZT3H9fj8s2D1F3hQ/XWO1OwkljztZLox/W01GLBcBG9+KczZMttQpW0pp65vex4RsyEJ6j/tt5+5+m6BM1RNEWuD6bW1UGnMeSiLN3uIOQ1nUs6HvZsfYTn+Y/sc1YmUPlJCqugHn/Hc37cexLwCqyFXxny6TUUtxR2SP9aV3LcKkgYnQQQM22IliCcESNRa8R3DGDKKaXgpVaPfmwKeJWCXsYR1MtpWxoBzkf6YRBUF00k8YgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBbf83AAUdkRLNjgyCpPE7v+sbaaMZ6OBjkX/CgfEjI=;
 b=WxIol6UFx3/gfzKb++8WCBADMdwFtI+j6xMr3Ea6sXxkbJU6mxJk6pQ90xJkBUM4OA+Hz8i95oxxnNUg9iN7R9IfWAAgJsZsPjyGylrfG+MXlxkr6/I8y5OBjB8o5Yn0SkuBlSaClDH2wFNzEMfDIxGUdR9FkoYcb5yL6SF7n9bRIyPduE/orwgwAAyOP5CoC2ag17GQ4tdR+VVK6/fooG9Hx1Q7xeIxW/IZP7m3NbXQMlMaQ+fYHOUU8I077piz9Lv2PU1oxZaRn/0fZqLqKIZZkGA+jhAGniazKb3HGmScylXyqbQgp3Pn6OAVnnkjC90A3RTCeQtY6i3DboomvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBbf83AAUdkRLNjgyCpPE7v+sbaaMZ6OBjkX/CgfEjI=;
 b=diX34MFtdYY7p2A1hb8Va+JH7jUW/Dc+ZsDaJT8CmXyGouBNbL33/OXgnSz69epcATyP+oawhMOWB+r2oODTn6ket7Montqt4VeHo+jYpH5gAmWA5cTm3j3c0rrRlkO5809SYnt+EYPc4N8Ob0MonRszbKVgJy5aIo86ZdIH1ItkmU78tj7Lv477geCFONjwIYXsGjgINxuE7PhLr3OiJHJbt1qLWbNoTh39X//ByhRroptR1Iylu0arcYKc5VPOZbfp2DbySCem3S/PAg18FdoTwxDaE+nLrGXsPYYuRAOCbZCCOQ3XjU56H9EkKWz2yRdLUQCqrlf34q9ahy4y+Q==
Received: from SI1PPF1BAF45F0F.apcprd02.prod.outlook.com
 (2603:1096:f:fff6::748) by KL1PR02MB7855.apcprd02.prod.outlook.com
 (2603:1096:820:138::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:51:19 +0000
Received: from SI1PPF1BAF45F0F.apcprd02.prod.outlook.com
 ([fe80::545e:d3ab:c3df:1b6b]) by SI1PPF1BAF45F0F.apcprd02.prod.outlook.com
 ([fe80::545e:d3ab:c3df:1b6b%6]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 01:51:18 +0000
From: Kris Point <KrisPointCSGO@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH] merge --abort: don't delete autostash before reset succeeds
Thread-Topic: [PATCH] merge --abort: don't delete autostash before reset
 succeeds
Thread-Index: AQHdDnwEkwvoW58hwUqUoRdVfynT8g==
Date: Wed, 8 Jul 2026 01:51:18 +0000
Message-ID:
 <SI1PPF1BAF45F0FA46A6EED57B732BB04D7ABFF2@SI1PPF1BAF45F0F.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI1PPF1BAF45F0F:EE_|KL1PR02MB7855:EE_
x-ms-office365-filtering-correlation-id: dd6e4031-3d97-470f-97ce-08dedc936793
x-ms-exchange-slblob-mailprops:
 KW6s2gPZH1dyipT8/XWlB5ovC7kO4cWumk4guOTeR9IxZvgWFKYmE1pDHiLA4PMv01IBc4Wdnxdw93O7qgLldYgW3QvdzCIu5R05KQPhIqQiDE89Z+JS+HN+jJbLxjA0NaJTmJQXsnlOdJbK263tUvSZIS3SMTB8qAWYqkBP7fYFt1UG1W5N2pv+gUspfbPEnHLYhNWbjksGWXb+mxfTcTEf8NleSrc0qbkg5GuyQigsNpk5ddAzk4VP3WnSzaYKDJ0aQeLbF/q3HID/0ruKUnmNRZLy9Vu7z13AEEy6EeC5RAKBCf7wlnUgTU2G2IbV8JjJAa/4ogLvdWXFRqiDvqu6drfUC9HnuMaHb3Qahe3y5QkUpkslzyQ+8v26Tfwh0Q2eWO656PNdD+wGSVCp3dwosMhv0SqSpYvrYYmApxTct3BIAtt6pnYAPBfiKmDnAPbolZ0e7osFSKomPI5aPcQBqQOWfCwyO2Xdsrn5YGFHN+iHSxeVp3OWPILNTlJL4qcD/t8C2lgnWB5rWHBdcmnEgOhH6oLhURAaxUpbKsQlk7M/sgZu3SX+gPM19ieYbaCR4ocZXdX5iUnX/zVCgRFSuXDT0YArRidagyWWg5L4k6u1VI4TLsNGFiDKJ3y0WPaFp14Dmlm/FCK4SA4udMVz1F/hUPzO+tBxotMYwwwOaa+aiP+YpbDKDTIdCd+uMufJRGvnu8TS3+Dj/DE6tia8hdjBHMkWassfRGRtE/4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|21061999006|8062599012|31061999003|19101099003|8060799015|19110799012|15030799006|15080799012|51005399006|5040399003|5062599005|3430499035|40105399003|12091999003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?gb2312?B?MFI1OHZBeE5iUUZiTUFvTWxFbnBVYmtudlBWemJIWW5wQTN3L0lTZURtdlU1?=
 =?gb2312?B?U1VzNVViTFl1azFSVWVoTk1ON1hDNjUzYXJvR1A1UmhqakFyM085QktGYWIv?=
 =?gb2312?B?WlI3M0VzaS9XQVhoa3VCQVBoN3dpVTJhLzNuM0dManVXVEUzRjEvS284aWNP?=
 =?gb2312?B?N29SVDZ6cHRPai9YN3EwUUkrYXBWMVVIdlg4amFONzZSUjh4a0NnV3VPRjBB?=
 =?gb2312?B?K25lN3g0WldPS3ZDWjA2bzMzWmpqRmxicnVHYk1ielZicFFGM0dVeGVoT25L?=
 =?gb2312?B?V1RvekxIYXhlcTBnOHE1bGQ2VHViNUVYTlJHYURMMXdOTmRkakJwSmFDQUls?=
 =?gb2312?B?VXp0MnJoSGJNMmJjYy9nTk9JNTc5S3BxcDFMdHBYei9PcGRTRUZtSW04K3ZC?=
 =?gb2312?B?M1N2ajliaG9QVVdXVms4SXQ3YkVOMndiZUJYQXFYZXpYNkpTcHRUMUMzRjJr?=
 =?gb2312?B?QS8wUkJyNnVHOVhzL1NtSG9ucjBCQjkvZVBCVkVnRkNEZmE5WDJsbUtjcVly?=
 =?gb2312?B?ZlBZQmNYVTZrRDZZZFRBMGRaTjVpQkp3SldvTUp3L1ZKS0E1bzFzTHZIRmND?=
 =?gb2312?B?STZyWSt2bm43dGFIVzRWc1NOd21pam1TRlc0ejMvMWtTMEwvRllaZ0lmcmpn?=
 =?gb2312?B?UGhmMlRrc1hkTVpCZ3lVNWZreHd6dUlVQi83dVVSRDZ2c2IrZEdDQ09kTUdY?=
 =?gb2312?B?MzJoT3hOT3RNdURJK1NqZ3dHODVMZU1MTThWS0RxWW1ibGh2RnFvaW5ua3Ro?=
 =?gb2312?B?aUJtaTNQL3pmcHVBV3RUcTB5djN3bDdLZnkzdlRZWGQ5K1g5VzhuaGo3bG1o?=
 =?gb2312?B?aGo0ZmRTVCtVL1FzTmlMSENFa2JkdWhTalR5VUlsK1dYaWNvS2Q2eW05UWVD?=
 =?gb2312?B?UzVWUUUwaTdtc0U0SXV1RExTSWlENHBVODZ1aktrTWE5dzJMNk81WC9Xenpa?=
 =?gb2312?B?UTJMN2VaUDBVeTErdWRoR1VrTkt3WC84Y29UbDRSZEZTeTQyaGQyK0NIUWJD?=
 =?gb2312?B?cENrT2tnYVE2TVRwRWZBL2d0VXJndEFLR2trYUI2L2Q1eDZCaHBlZEZvWTRI?=
 =?gb2312?B?bWxYZUxtY0tKZVlES3Z1TmhPUzZJNUx3SlhoejNPaEI5Wk1TaXAwanlXblYw?=
 =?gb2312?B?SEZNTHZiWjdjUXd0MThYc0NjL3pCZ3ZYbTJiTDFEZmF5R2owUkRmeXlycUxa?=
 =?gb2312?B?b29iMVU0SUREMFhvVW1rcHl6VUJGaS9jcmd4V1pvdHVPdlZjMmF0NW56a0FG?=
 =?gb2312?B?dUN3UE9sbDgrOFRsdGRvS3lwdlhVVm0zOGF5VGtWcjRBekRIY0w0VzcrR2d4?=
 =?gb2312?B?cG1yTHMvVVhJeTNwQXdNY0V1Y3RvL3dMbE9adFBFdTl0Ui9POWtEQzdXTkxu?=
 =?gb2312?B?VEVkcEFsU2ZVNWg4UXdJU3kxcHk0d2pRTkNRTmVNS1d4azBQM1lKRjMwQXFs?=
 =?gb2312?Q?DdOjLpJX?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aERlTmJHUG1ZQzNqUlgrUVBINXZORnJ0UHpoUUsyUVM1TlluOG5PMW5aVGh2?=
 =?gb2312?B?c1JpRDJaT1d0VTB5SENjeDhGamZKbGpOY1dVcGp6eVU2eXJWZUJGbFY2ajdK?=
 =?gb2312?B?Mk40SDZEM2dPWnJubUJPS1RVOXI4bnpHWG44WmxLS291QTZEWExSeHR3dUxD?=
 =?gb2312?B?KzlSTmFBLzVyWVZIM3dpNHlPdmlQOVY5Y25DOVJxUjV0c0t6RWlhdDFkWEQ2?=
 =?gb2312?B?b0dFdWZKSHdhTTlKNWp5Zk1tRUNwajcwZnFBVFVaaTIybmszVG95VEdnVmNY?=
 =?gb2312?B?MFRGREs2YkpXb0RMWWh2aUovUm8xRHVhU2s3SlZ6OFljSTY4MUh6dkQ1cmJX?=
 =?gb2312?B?TGt4dDhoSHAvRXNEaUFkSEVqcVFMNkRlWkNtdVhHdmtKWmhVdTFoQ093N0Nn?=
 =?gb2312?B?TzNqWS9SajhyU2NSNThzemRTTDc3UFR4bmRxL014NGFFL2p6aEtKNzJzSWxh?=
 =?gb2312?B?d3FQS1BPYVEvL2NrSTVkNDI3WXQ5ZUhsSUZtZUNjM2dMWjY5STZ0S2g0QWJD?=
 =?gb2312?B?aUd0SWUzN0NQcCtzTjVReW5GZXlHNjNJL2FuZUpFUklReTViWGh0M0pqaU5I?=
 =?gb2312?B?WkZ3NmJnVEVHbmttR2lReWVmd1ZweEE4Y0NZaTMxYjFmRTFPRlRiSFhpVVEz?=
 =?gb2312?B?WEJLVVl2VHVLbWI2TnBDR1VEdnUrTzgxYzBzUmFIaTJaUVh3N0R1YjZzM3U2?=
 =?gb2312?B?MnhMMEVXdHdwTVMralBveU9YRmtXY1BZYlhvU1BzUjYrSDV2SmRVb0F4VEMv?=
 =?gb2312?B?ZW40QVFsK1Bua0Q3ZnorR2tXRElCSDdpNktSbmxiS0ZrZWRVOTZhZVk2Nkdl?=
 =?gb2312?B?STBmdlJpV1lLNk1uMStlejlYV25qN1o5S3lqZ0k2TGo0ZE5CSiswZnFGQ28w?=
 =?gb2312?B?MG1DY2FkR0NQcFhLTTlwQk93NWRPOU0wS0R6TEVYUittRGcxQjZIQjlqblZX?=
 =?gb2312?B?TG5scFhIL0lYWlZDRjZOMldaNkp3YXdLYXU5VVE2ZC9yRGtENWVFSjhwNjl1?=
 =?gb2312?B?WkZtQktiaFBWT2Y4UnJjK0JoVGVWTjliYXY3eTQrWi95Zk5FQlZ0MkFpYnZI?=
 =?gb2312?B?dXV1MVpqSmxKbFA0THVML0hFcExJY0MvKzdjVHBoLzBLaFgzZ085NHZCTUhI?=
 =?gb2312?B?M2dmZElRSE1ya2ZhMlR0VE81L3J0czl3Z0grbElvcnVwQW5VdXgwZGVmdnRi?=
 =?gb2312?B?UFlOQXFLS2dHUUNxNE9PbXQvRDc2ekRVYVgyQjJ6WWtmQ2lXYmxCRlNDWCtP?=
 =?gb2312?B?M1FUSnBrRWdiQ0tTU21rV1BGVlVjdjhzV1N2K1NtVW93Vm9taFNZZDhsdGZC?=
 =?gb2312?B?dGYxSFl6VThndThTbTkrTDh3SzZKUTV0bStEVnhOa3BtTWVneHd0VnRsYnA5?=
 =?gb2312?B?emVQblhvdXVzQlRDOHZwNTdmcGpnbWxEb24yVU9JTnRvbzduS0g1YUdIbHEy?=
 =?gb2312?B?R2w4bXNPWkZqdjg3ejVpN0JOOTR1bTBzUSt2QXVUcXNDSFg5RnNpOEx0YnEv?=
 =?gb2312?B?RkFlbVM1ckZPcjJvd1MydmlTeHhkSUpEVUYvL0ZmcUlSUEVPc1pLU1lJb2pE?=
 =?gb2312?B?aitiTmZWMnFsUWk0M0hSb1hzcmtuRWg1SFRKNGxSUTk1Vms4RDhPSm5XZ25u?=
 =?gb2312?B?aURteEFWUG1VcFFCR1FDdnc0ZXNQQS83bzB5cXVsM1FsVnV4NnJHMVpGMWZY?=
 =?gb2312?B?VlA3clZZS1JPdko0NzZ2bm51RThraWJuY25mMXRZcUtIWDVQeEFyd0pheVp3?=
 =?gb2312?B?Y3Y5clg1NUhOaE9xYXY4VUxjbUNIeU1VcDk0Kzh4Q3BGdzRyU0F3eVFMTTJ2?=
 =?gb2312?B?VVk3QjV1cmFPeCtoTFUzd0lvNlNMZkFVZ2hOcllRVm8vWmpOMHJZc3NYbWI2?=
 =?gb2312?Q?flOiE54ixT2IZ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI1PPF1BAF45F0F.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6e4031-3d97-470f-97ce-08dedc936793
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 01:51:18.8753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7855

RnJvbSBiZjRiMTI0MzhhODNkODFmMmM4ZGY2ZTM5ZjYxMTRkZGQ1MDAyNDMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLcmlzUG9pbnRDU0dPIDxLcmlzUG9pbnRDU0dPQG91dGxvb2su
Y29tPgpEYXRlOiBUdWUsIDcgSnVsIDIwMjYgMjA6MTA6MDAgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBtZXJnZSAtLWFib3J0OiBkb24ndCBkZWxldGUgYXV0b3N0YXNoIGJlZm9yZSByZXNldCBzdWNj
ZWVkcwpUbzogZ2l0QHZnZXIua2VybmVsLm9yZwpDYzogZ2l0c3RlckBwb2JveC5jb20KCkluIGNt
ZF9tZXJnZSgpJ3MgLS1hYm9ydCBwYXRoLCBNRVJHRV9BVVRPU1RBU0ggd2FzIGRlbGV0ZWQgYmVm
b3JlCmNtZF9yZXNldCgpIHdhcyBjYWxsZWQuIElmIGNtZF9yZXNldCgpIGZhaWxlZCAoZS5nLiBk
dWUgdG8gYSBsb2NrZWQKaW5kZXgpLCB0aGUgYXV0b3N0YXNoIHdhcyBwZXJtYW5lbnRseSBsb3N0
LgoKSW5zdGVhZCwgcmVhZCB0aGUgTUVSR0VfQVVUT1NUQVNIIE9JRCB3aXRob3V0IGRlbGV0aW5n
IHRoZSByZWYsIHJ1bgpjbWRfcmVzZXQoKSAod2hpY2ggaXRzZWxmIGNhbGxzIHJlbW92ZV9icmFu
Y2hfc3RhdGUoKSAtPgpzYXZlX2F1dG9zdGFzaF9yZWYoKSB0byBwZXJzaXN0IHRoZSBzdGFzaCks
IGFuZCBvbmx5IGFwcGx5IHRoZQphdXRvc3Rhc2ggb24gc3VjY2Vzcy4KClJlcG9ydGVkLWJ5OiBL
cmlzUG9pbnQKU2lnbmVkLW9mZi1ieTogS3Jpc1BvaW50IDxLcmlzUG9pbnRDU0dPQG91dGxvb2su
Y29tPgotLS0KIGJ1aWx0aW4vbWVyZ2UuYyB8IDExICsrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4v
bWVyZ2UuYyBiL2J1aWx0aW4vbWVyZ2UuYwppbmRleCA1YjQ2YTU5NmYwLi41ZDlhMjQyMDI3IDEw
MDY0NAotLS0gYS9idWlsdGluL21lcmdlLmMKKysrIGIvYnVpbHRpbi9tZXJnZS5jCkBAIC0xNDI3
LDE1ICsxNDI3LDE0IEBAIGludCBjbWRfbWVyZ2UoaW50IGFyZ2MsCiAJCWlmICghZmlsZV9leGlz
dHMoZ2l0X3BhdGhfbWVyZ2VfaGVhZCh0aGVfcmVwb3NpdG9yeSkpKQogCQkJZGllKF8oIlRoZXJl
IGlzIG5vIG1lcmdlIHRvIGFib3J0IChNRVJHRV9IRUFEIG1pc3NpbmcpLiIpKTsKIAotCQlpZiAo
IXJlZnNfcmVhZF9yZWYoZ2V0X21haW5fcmVmX3N0b3JlKHRoZV9yZXBvc2l0b3J5KSwgIk1FUkdF
X0FVVE9TVEFTSCIsICZzdGFzaF9vaWQpKQotCQkJcmVmc19kZWxldGVfcmVmKGdldF9tYWluX3Jl
Zl9zdG9yZSh0aGVfcmVwb3NpdG9yeSksCi0JCQkJCSIiLCAiTUVSR0VfQVVUT1NUQVNIIiwgJnN0
YXNoX29pZCwKLQkJCQkJUkVGX05PX0RFUkVGKTsKKwkJcmVmc19yZWFkX3JlZihnZXRfbWFpbl9y
ZWZfc3RvcmUodGhlX3JlcG9zaXRvcnkpLCAiTUVSR0VfQVVUT1NUQVNIIiwgJnN0YXNoX29pZCk7
CiAKLQkJLyogSW52b2tlICdnaXQgcmVzZXQgLS1tZXJnZScgKi8KKwkJLyogSW52b2tlICdnaXQg
cmVzZXQgLS1tZXJnZScgKHdoaWNoIGFsc28gY2xlYW5zIHVwIG1lcmdlIHN0YXRlLAorCQkgKiBp
bmNsdWRpbmcgc2F2aW5nIHRoZSBhdXRvc3Rhc2ggdG8gdGhlIHN0YXNoIGxpc3QpLgorCQkgKi8K
IAkJcmV0ID0gY21kX3Jlc2V0KG5hcmdjLCBuYXJndiwgcHJlZml4LCB0aGVfcmVwb3NpdG9yeSk7
CiAKLQkJaWYgKCFpc19udWxsX29pZCgmc3Rhc2hfb2lkKSkgeworCQlpZiAoIXJldCAmJiAhaXNf
bnVsbF9vaWQoJnN0YXNoX29pZCkpIHsKIAkJCW9pZF90b19oZXhfcihzdGFzaF9vaWRfaGV4LCAm
c3Rhc2hfb2lkKTsKIAkJCWFwcGx5X2F1dG9zdGFzaF9vaWQoc3Rhc2hfb2lkX2hleCk7CiAJCX0K
LS0gCjIuNTMuMAoKSSd2ZSBhbHJlYWR5IGNoYW5nZWQgdGhlIGZvcm1hdCB0byBwbGFpbiB0ZXh0
LiBJIGRvbid0IHRoaW5rIEkgZGlkIGFueXRoaW5nIHdyb25nLg==
