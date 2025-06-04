Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88391E5B65
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029951; cv=fail; b=NF8x7Nk1DvHnOBXI2R0r8DQQDdvynjnOtlgYVAhnobGZ3rwYYMKQ1n3SHasw77UQUgcstBGUzl6fgNioTeyNY6RSxC51NASBaimomRRRIPzNw30oOZImF2xpKFgZLuhD28WfYtp2jM63LB1Wl9hzgyERtscUtsMuNHe6z4DkhwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029951; c=relaxed/simple;
	bh=DmQxlr4AgIKj4WJ2Nie4MA+Zr/n7HXCum1MliCJuLlQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ucKlhLpAVEfxsXbRyvqPtddO0hnUuUPbOvVjhKp2T1DNN7Cm/zeuXTrR6+d0JusFu19NRU4+NAEtGp0vvg6kuMlJ5DsDtasRds4s5lscnfKFSKYl3Qo68oFrho8Xk2iUR8qRrGCbYoejumKEFvLCTeG35xYrPjRryqjYJU+sVeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZDccFebo; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZDccFebo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5543sBo4027909
	for <git@vger.kernel.org>; Wed, 4 Jun 2025 09:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=DmQxlr4AgIKj4WJ2N
	ie4MA+Zr/n7HXCum1MliCJuLlQ=; b=ZDccFeboEcSNYuGwiLbJ1DwvNNQ5HrL7V
	8DjBCucUhWDjtcOTqqhduhfCBbntOR2+6laJ+wVScjCcDFWMx9CGPYm1T1Y+h0zU
	PT9SNiXEdH7VQsWYo6JX1xlYodKynBsuLDCofAUhheLWeOnkUoT/Evz4eeAwBPLV
	5d0veWuj3y544Pu7dV0vwiH/bw7W5TTm6wPPQhhVkSFhybPOgV0MeMDyj0byg8B3
	uJw2kERoljI2X28WKvkQa/C+p8NLzpNkl0RCT+/MDQX9aRx/1hKjwDE5Px/5wiHc
	P0BpuPtym1UOHEFJlHTXiOhwvBmjDba2+tbw9kuyYFTEGf2ov6Gfw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gey9ps1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 04 Jun 2025 09:39:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJMaWuVXBZdxXZwW3MOFOdbBZstX24PUzE2/0p0b91p4b92JvQTgrtFlhEnP6NB2LClme0Pc3xdWDjAPDpSU/iuOfWvfs3JNfXJEERNvPlG9oiiI+i8QLZEjc0bTrKS8YLfQIoskjx70EWAdZMB+S7EMva59HIpvQYdyP5/occOBD+iDPL9j6YsfieI0mFvWHAVrxfZN5deNju+7eN11j5wnO/bJds+4JVd6i0ZEJ51XV6kPvEc22ZRAPo4SSQ66ZJmFX+k1D7lsgi5yJFZyS/YZkDxocU24UVRys4u+JzZ4c2g7Bw3RsP6WAHZyknIHAmzU8IcXEBjlb2EJpw/lMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmQxlr4AgIKj4WJ2Nie4MA+Zr/n7HXCum1MliCJuLlQ=;
 b=BPWKqgaeR2oC9iVxlttnpp8MvPmC4XuKgUNugCAcsfOkkDEmrh/SMZWLygnGyN2dJqiER1nd/E24e/fNoABPiWZK2Y5v9b9PgqQEXqyhoGPpE+hzEaOXBxgH6BQgkChEJGIWk7rn6Ts1A7rP9eXCYhKKPp9ZK2ljF5OTq/19MbHtFe10HE/rVMffVqYIEEui4rvwwAilHchyv5nBiT/ZjM4t195KMF1FhyPD/ukxx+Z6PbFWD2w3zYz+2v4uox9XCn+Gqby0oJQZRr4EmBRJIEL1Uei9nJSoyWJR8+QEGH3Ww9XzckV4v+MwWEAmEG1fbJZUniZsq7L3nzBChh+CXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from MN6PR15MB6342.namprd15.prod.outlook.com (2603:10b6:208:475::6)
 by SA6PR15MB6691.namprd15.prod.outlook.com (2603:10b6:806:41a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Wed, 4 Jun
 2025 09:39:06 +0000
Received: from MN6PR15MB6342.namprd15.prod.outlook.com
 ([fe80::b046:edc4:5c0c:1832]) by MN6PR15MB6342.namprd15.prod.outlook.com
 ([fe80::b046:edc4:5c0c:1832%4]) with mapi id 15.20.8769.031; Wed, 4 Jun 2025
 09:39:06 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Clarification on GPG preference update prompts during Git test suite
 execution
Thread-Topic: Clarification on GPG preference update prompts during Git test
 suite execution
Thread-Index: AQHb1TSD5/udMCowt0qJQBgbI6/04w==
Date: Wed, 4 Jun 2025 09:39:06 +0000
Message-ID: <3B3EF793-F2B0-4D77-98D7-900E5273D498@ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR15MB6342:EE_|SA6PR15MB6691:EE_
x-ms-office365-filtering-correlation-id: a1b005d3-5399-4dbf-ffcc-08dda34ba640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WU01c0REQmxaK1kzMkRYS3ZBQ1ZyaDJmdkt2SjUvdHpiUkYzS2JpM3ZhNUN2?=
 =?utf-8?B?RG9WcUQza3BsOGVCSlB6T2NpRGlsK25VVDN4REJqMzVINTloS25JSXRETEh6?=
 =?utf-8?B?bGo0K1ZWYkxzUHFuN1Y4VnA2RElsVVVORnozRUpDUjdtRHpNaUdydDd2R1JC?=
 =?utf-8?B?RGdLbGpBY0xaRnlhekRqcEh5VlBLSmkvMExRQlpESEhpY1F1UnphU2xvRkdZ?=
 =?utf-8?B?bGhtV2FPaWh4WlBVWkpETlcrSzBaeGZXVGt4VGFTaCtaVmZsdnRQZjhEMm13?=
 =?utf-8?B?U29pUTByTlRkY214cGtHVWdQUllkR0hXVkNtdWNpYmZqTzNqMEM3aXUyZ2pN?=
 =?utf-8?B?eHZzOFVBZ044WUtlbDNoY0c1MUJUSDh4OGhqMXh0NUR1ejFrVVNqQm02amJv?=
 =?utf-8?B?cnlzZjdaQU9uWVpPSmVoVWhjS25mV2tiVU5VWVhLS3A5TmxyUFVzL1Awb3Qv?=
 =?utf-8?B?dGpwc1hqSkg3SmFPTEN2dGRIQ05XbkpFQ1RzWXhIZ1J3cnZ5cm9rYUdrVzFy?=
 =?utf-8?B?UlN1TmpuQm9CQmtqOU5ZYzlVakZsd1JjaExlWGlnUFVpM0JnL2RnakRPWTlP?=
 =?utf-8?B?M0hwVjZldzQvd0dEMlpka2N0MlphMWwzVjdWcTE5THV6aHZjQVA1T3JqZXB3?=
 =?utf-8?B?YXJVOXNSekZyZXFrNmp2NW1TMmRhTXR5Y2hvdkJUOWtNSFNScGtZbG5VOHl4?=
 =?utf-8?B?QmNDMkoweXY1anpCS1FmWmVwM3ZlU0ZiRGN6Um1pME44d3NrNGg5MWc5VEF0?=
 =?utf-8?B?a1RQRXBMY3RzTk9XY1NGTDYwZ1lEVk8rOXFtQ2xRUUdvc3hZTkNDSHpRcG1o?=
 =?utf-8?B?K1N6eTJUK3dVa1VPamMybjZQRlo5Z3JWNDhaakxJTkZyKzkzMGV4UlowQUx5?=
 =?utf-8?B?VXdYSXpLOUsrNElmQ1FDMEhZUXAybWdjZFNVT2tQZ2ZQTEdSWEdjWEpycnVB?=
 =?utf-8?B?bmRkdlVZRjVaS1NwNVJmdEh5RjNBOGMzNUxqU1ZET0I4SkI5WklHOFEyallh?=
 =?utf-8?B?aTYvSlk2VTZQUjRQVVpSbVU4UGp3WTdSL2Rkb2FaNHJFRjVnK3VHTWpRR0Qw?=
 =?utf-8?B?N1VlS043MDdKTG1iUXFadStYV1dYdE9WY1BQYXVwRm8rV0FnWkhLWDBuR204?=
 =?utf-8?B?VStyVHFGL3NRaitFdmMxbmFETDl5RWZua3hIN0dXbkNQcHYrVE1BQ3NZZWc0?=
 =?utf-8?B?QkVibDJkeXZUTXlTKy9aYmZnR1Q1aUpXYUFwVzN1cTFuSitjQ043anRFTENv?=
 =?utf-8?B?ZFZmVjJ4QVZyYzVvV3UybERHQ1lKOGpqbkR6dTVWdktaTTVIcDRINHcxZkhE?=
 =?utf-8?B?Z0FVcFhseG1YdytWaUg0aXk0RER1Q3h2WVRtcG85VlJrRnlXS1BKRkxjZG8w?=
 =?utf-8?B?TXRqT1pzOXJWV3B5ZGQ5b3V0dThhNGUvc1lBK0orbXE2azJrMktJSFVWbXlS?=
 =?utf-8?B?WWQ1d1NnSElLaWVIVnJCRTF5eVhIWmxIZmFTUEZlT1J4RFdCUmNab25vdVJj?=
 =?utf-8?B?MCtwMURvdjRRZlFKOGdicEJQcURJczc1UitubGxPeVFaMnhMZklBYmt0KzFI?=
 =?utf-8?B?YWxHVHRpWk80cGxOZll4VzE2Und4eTM5OWROVGppcjE2M3F0S1dHNDRudjlh?=
 =?utf-8?B?OW5tVHRRSXZMbDkxOWhISTRRaC9JNnN3Ri9lZXZoaUU1ZWlTNjFKenM3cG1W?=
 =?utf-8?B?NWdPelZTVEVhVVVpUzJuQnRFS3ZXUG5hZFVHblhyd0xjTXFvRGdXNDFQS29X?=
 =?utf-8?B?WFB3ajJFS2hhQTFnNWpYQllrbGM2KytLVzFGV1BUYytrV1BOYmc0ZkZrMm8z?=
 =?utf-8?B?aEtoQnptRHpRVnFUMHJnejB1SUNsSFZuakVacFJQZXMrUWtKdnAyN0lpQXhN?=
 =?utf-8?B?OExmRUloZEd5U3M0NWVmdi94bzVTOWhiSUQ3WkxYQ055ZDg1d24rNGV5c1J0?=
 =?utf-8?B?SWt0dUlIK2loV3ZBczhNcmk2Ymx6UTRVdUVPSmtCOE14YUNiam5FdC9la2kv?=
 =?utf-8?B?bFJoTDMrdUNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR15MB6342.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UklLOEU4MWxaNFA0eFNNS1c3bFVROFlUamRlczhWYUQwcUM4MmdFMEVWMjA3?=
 =?utf-8?B?Mm5wYWs4b3pMN2lSTUUwV2FldzRySXQrSTFHWUFEUW5uM3luQUE1K2JOa2gy?=
 =?utf-8?B?MTJvM0xsUWNZNHozUklMZjdKdWV4MVZXT2c3SkIwc0dOeUpBYzh1M0RYZHM4?=
 =?utf-8?B?Mk1hSEpFbmNNTVRSYWFrSE9adkgrOFhoalRTVFVaSUVKQ2p1MTMyUCt1MDJp?=
 =?utf-8?B?UHZaZktGbUNINVRzb3BDL09lbDlvaHhBWFlNemVuaEFIU0dvaGpGbDcwdlBy?=
 =?utf-8?B?b0xMYXJLSnFHYU9QRlVJU1B0amlJdDlTalR4UVBmTkVFclNFNHJQY2xaTVh4?=
 =?utf-8?B?RjlxRUZoNkZTTHIya2JIdTJ4ekZhRlQzZU1GWHBnakdqaFJuQ0V4QjhCNVFY?=
 =?utf-8?B?RmZzemwxYkdZb085TGZZeXlGSXN2Q2w2Ukx0cUg5NmRKdE5rNzFYNHpvYjJZ?=
 =?utf-8?B?bVNySmQySlAzMEVSWnRxbnRKeHlFRk9HdVBUT2lZTjlUNE40MTdHNmlZUk0r?=
 =?utf-8?B?WTRVeHNVaExqZVBNNVFmM3ZaM2tPTUMyWkxKcWJJd2hpNVpQYVE1SGRBV0JF?=
 =?utf-8?B?Z3JNQXkvOURKcmZFUW1SbUcveEcvekxCcnEzaXZMQ1BPWmJYU0VEbHB4c0U3?=
 =?utf-8?B?QnJpZXcrcmpIb3NlK2d6bWxrdFdBeXA1N3Y0UVdHanAxbW85ZEdJMzdJY1g5?=
 =?utf-8?B?dE5SS09zNnBtdVhQSHFoR3ZHTThEZGtSUzh5TjhBM3hQdkV6S2JwUG1sbnpF?=
 =?utf-8?B?VzMrb2FMRi9FM2VQWm9xcytua0hxRWhDeHBWcngwZkFsZFhZeUZMUHFnNHRk?=
 =?utf-8?B?enhmdk5jNzVwVnZMZUdNZkM0TmxBWDk3QnZQQVdHcnBod25LNGdTMHhqWHhF?=
 =?utf-8?B?K0Q0RThuc0dBb3FmOERJTHZEVWJRd3FSTmt2UjlydFl6alFZTzRMWHppTGp2?=
 =?utf-8?B?d0YwSE42OEJzRXJYTnhhU2Fqd3pGTzFvRUk5cDRXNHcrYWJZN1o5K3IwWFN5?=
 =?utf-8?B?R25LS212MUNHS0JtdjJjT2tYcTdrVjhjWVNiczc1VVM3QXhUdUE3dWtOamFI?=
 =?utf-8?B?Si92MXBPckM2YWM5QktQUDdwOCsyTFhvM0QxWFBENUZqUytDRWlCYlVSVjBS?=
 =?utf-8?B?T05NanJuYzhKNHpYT3hUbmJWOENRd1BzYXhlNHRmeHhOaEhVZlFGSHNMRzR4?=
 =?utf-8?B?MFpmWENsckVrRU1uajJIejFaczIwdnAvTEcxVWFmVVVpMGtNVDltSzNUUFFP?=
 =?utf-8?B?SnNJMUJrSTNNem1EbDcyVkRDSG1NVVB2NjFwRDh5SWNNYkF0ejQwcXhlN2FS?=
 =?utf-8?B?a0FMYkNWd0FvMG11dW85azFKOWh4NEJLaFZhSDB4RnRZY1dLMC9ZV25kVlJS?=
 =?utf-8?B?TlNJaXN6Nk5nbWNSVWgyVkRCTmdtcGV0TEVaOGRFdE9xbTdnOVQzR0VzTklI?=
 =?utf-8?B?UlQ1QStjU0lQL2tucDc5bk9oV1I4T09OR1hGd1RQbjBtRU9VMG8rTytka0Vy?=
 =?utf-8?B?dy90N3NHTUlQblg4Qkg2UTE4Lzk4cU13cFBaVFRiUld4a1JFdmp3ek9zdjRa?=
 =?utf-8?B?alFWTWRocTE2aHFBLzN6WGo1MC9zYmdZRWZKcUllODFROTNUNUhSR3pmS0gw?=
 =?utf-8?B?c3ZweDdhRjFEOVo5RzNxOGlEZERxMUNrYjB0RWhyRGkyZXo4OWNEQ3V4ejFx?=
 =?utf-8?B?aUwyN0ZPT0JkVHVDYWZmcGt0aVlOYzVHc3htRXp3ZUhTYVpRdzArMnMwY2Z0?=
 =?utf-8?B?b0lMdy90Q1RkUDZSTGpXeWEwQjRMQlNZdEtnLy9ORWVzV1YySUJ1RnRPMU55?=
 =?utf-8?B?dzZVSGZ6cGJ0U3RsTlNoN2oxcDhGbFVVZWN5ZlNqTXFDRXQ5TXYrajJuNWxB?=
 =?utf-8?B?MitzKzU0Y2RIQytLVHhXQ21lRW5IWjJrMEdHL09aR25YZXAyN25FQkRWL3Bu?=
 =?utf-8?B?a1Y4Y0hyYTVNcDd4SXhIQTdRVlA4UlhCdEdhSW9UbHIzcDZtci90bS9IRVdI?=
 =?utf-8?B?WmpVNkJKbjlQL3VTNldZRXkxZ3lscWp5RkRnakhzLytNakVXODZmbGNMV20y?=
 =?utf-8?B?QzFsL0tlQzJDdnZBdWhSaVcva1dDaEZhWElWTEVhODZOcis1bFNyS1k2SVlD?=
 =?utf-8?B?TnBQOHYyVkpqTHZNd1BWSVJzRWZTYldKa1dqQVBnY25yTjZKTDBhK0tpSC9V?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7B455CBE86C104D96CB46514C12BCD5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR15MB6342.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b005d3-5399-4dbf-ffcc-08dda34ba640
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 09:39:06.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QygYdGCpYecqZa0maxl/jV8cAT/JEhf3/ZVIfGAXrcAuhkgJ4EnsA83j+yZrKPShKcnNsUOeoBydh1NP+BPsbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6691
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=6840143c cx=c_pps a=Dff2arrQVR4xu3ccdyRu6Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=uYL-aa7Nip93HaespCgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: NHlUgcdA8WX8GKyM1pc1_Y6_fs0bqzQs
X-Proofpoint-ORIG-GUID: NHlUgcdA8WX8GKyM1pc1_Y6_fs0bqzQs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA3MSBTYWx0ZWRfX6FfBDRoFMEb5 qgHAtUmBLAtILyd+1Vo8/lYmNbI6ziT8CwbPj0PC/6aPs6y/dK7OBKNiPjKBe6NYPyWj9GEtXU0 LS9lWy1iiF3IygYEPnCdCbIhiP2ihoALAvoxMjmJw2+sWU2VfONFyKO2pSFzizl1f/9A3/sgdHw
 CuB15uBfWUYQiUx1ZtQKdtFe2O6dTbc2ZDe5pbJcHDxR1N9OKkd9Yh81QdU0XmtfH8ig2Uhe6rR OkQJysHRbHc3gows4SMmU6UUPainbY8UwyxkPaDjQ/vGAarL2dbH2YrJePXFpEIvMPnGTtraVHC F9rbpY6Fb1WSuVP3uiUzET1WzgFz4E0v73LF/ZYCpSgbwpnmFMyJjRoRT2LxbRRkEjqrJCN8Ll1
 Hr0Hr5BX8Nl1gMHS7WaCzwgLbKfRWQ5miWduS7PzXC9KVU2+cO16azjfyyJ82QQssFl4atbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040071

SGkgVGVhbSwNCg0KSSB3YW50ZWQgaGVscCByZWdhcmRpbmcgdGhlIGJlbG93IHNjZW5hcmlvOg0K
DQpXaGlsZSBydW5uaW5nIHRoZSB0ZXN0IHN1aXRlIGZvciB0aGUgbGF0ZXN0IEdpdCB2ZXJzaW9u
LCBJIG9ic2VydmVkIHRoYXQgc29tZSB0ZXN0IGNhc2Vz4oCUcGFydGljdWxhcmx5IHQ1NTczLXB1
bGwtdmVyaWZ5LXNpZ25hdHVyZXMuc2jigJRwcm9tcHQgZm9yIGlucHV0IHdpdGggdGhlIG1lc3Nh
Z2U6DQoNClJlYWxseSB1cGRhdGUgdGhlIHByZWZlcmVuY2VzPyAoeS9OKQ0KDQpJIGF0dGVtcHRl
ZCB0byB3b3JrIGFyb3VuZCB0aGlzIGJ5IHBpcGluZyB5ZXMgbiwgYnV0IHRoZSBwcm9tcHQgc3Rp
bGwgYXBwZWFycywgY2F1c2luZyB0aGUgdGVzdHMgdG8gd2FpdCBmb3IgdXNlciBpbnB1dC4NCg0K
SSBub3RpY2VkIHRoYXQgdGhlIGNpL3J1bi1idWlsZC1hbmQtdGVzdHMuc2ggc2NyaXB0IGluIHRo
ZSBHaXQgcmVwbyBkb2VzIG5vdCBzZWVtIHRvIGV4cGxpY2l0bHkgaGFuZGxlIHRoaXMgc2NlbmFy
aW8gKGUuZy4sIG5vIC0tYmF0Y2gsIC0teWVzLCBvciBvdGhlciBmbGFncyByZWxhdGVkIHRvIEdQ
RykuIEnigJltIGN1cmlvdXPigJRob3cgZG9lcyBHaXQncyBDSS9DRCBwaXBlbGluZSBhdm9pZCBv
ciBzdXBwcmVzcyB0aGVzZSBHUEcgaW50ZXJhY3RpdmUgcHJvbXB0cyBkdXJpbmcgdGVzdCBleGVj
dXRpb24/DQoNCkFueSBpbnNpZ2h0cyBvbiBob3cgdGhpcyBpcyBtYW5hZ2VkIG9yIGJlc3QgcHJh
Y3RpY2VzIHRvIGhhbmRsZSBzdWNoIGNhc2VzIGluIGF1dG9tYXRlZCBlbnZpcm9ubWVudHMgd291
bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZC4NCg0KVGhhbmtzICYgcmVnYXJkcw0KSGFyaXRoYQ0K
DQoNCg==
