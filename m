Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE33197A76
	for <git@vger.kernel.org>; Sun,  4 May 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746372394; cv=fail; b=H0+tS/EVU32FmLTFdzaK71fiJN9eGb86MCqnh/EKmrer+CrXAubd2Ds/b6HMnei8sjx+c4+z0I13eT/dVFKtnWaJNbmI6m0VQylRYYT+JguEw9YcyEeYd+GW79Xikq3u7QmuM3gv2Db8E25euCbdPu2I5n7fBgVVsooKsI8Cr7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746372394; c=relaxed/simple;
	bh=9SF5Cyf+gdLGhW5ztaoeVlZqKZBAFEb293IVuahkWAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUbENl+t/D656vAD5FwZrx0Rjpzvv6jGATICETyGMjgrFcU54lvEpIL1wLF7gpRYvQDtXtdcBwXo53/Bm7JDqmmq/7GcAGJtVklKxm757S0s78JGaCtz7q1trPpAPITklgGZHsPKHBvZCuP+wAxqSl7S+ApO1BhpwcsFTm70F2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IOYvf7Cs; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IOYvf7Cs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXRWgWKcoUDee15eGYJyJ8/GcK0jGUfEltncOYgcciUVsfbOF/hYQtXemb0Yllr3yiJ/u4r5I/G3jEgYlxbh6bPwcq6SX/EvXvkQqTDjAsmmvEcA1KrfiKn03xgYIdxASJ9rNR7kz8Lcs08N802n/17OnWMM8gOMU4yjH7oDyOav6C/gZrItyuZvZV9sWLUYRvguMHuf2f0xLPx1+Xf3bV/bL9v8ISTOdoqTyrevVxx3cANlpLgU7TX75SSm186BH+Fs79D8ZhZgbVigCVCWrAUO/rkQKsFNGSJC5p2X8Xa39HNphdjF6zKh3ilaUwG6+QPVBXBIN9qPXa634R9EBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SF5Cyf+gdLGhW5ztaoeVlZqKZBAFEb293IVuahkWAU=;
 b=q7m6JJtsU7AuMtxOEja3zg3e9OFZ6t5Sg0Ql5lrEuR/Z238+rQ3Axb59wkhfAUkixM6I14Tcs/EBMVw7xQFECbMXOMNPUDibcn0gyFWUHwBc2gN1F6MP3qqnYY9ggNNkwjOfTIJ1Pb8LtlEzn8xxS3GJhbaizgwfe5jKIpC7JDLJjFf8DJxxZwUE6gbGTV+sxeVPDVMOXp1bZCdi2hkimwEfLsuhDYvfYFiJVIsyrPUJ4R8X8xHYepyLj8VRycokeLKznztBCAVpm5L0a43Afinf6HODUTgyGiEPsUnNFxYtrg8NYDT1OVfEM+C5JJ9Dk4IACxuqv4y1TjIqtDcWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SF5Cyf+gdLGhW5ztaoeVlZqKZBAFEb293IVuahkWAU=;
 b=IOYvf7CsZsjMxTJNuXrlCvAmJRqTwvfBh2dyFLwDllqC/bVHZrvdZToiGE6N9Syltk9YHZyDl1DJQCCcxnvtH36vvXenwI4eX83cNCDEu1ELI84xSmIGBTi1RY8iVQyh4ul8SBChqKcfcGX8CU0C2pG8B2mPlXxoQfXfXkn6JgQp0gs4iqvRXdFQoRaRcdH9cxxNW1xx04BMWD7Fi6qTkhGOujiRd2Y2B7hPLSdlJrW4uJLTYlDLNWjPlZGKPCIvUxd2Usi+zwkoJDILyAqL1/eEAncj+fTXKPJ1HAfpm7xkFEPi+S4aT0mBVQNpWMNns8X0xpsUOc87z2osJvqjeg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB4382.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Sun, 4 May
 2025 15:26:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Sun, 4 May 2025
 15:26:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
CC: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, M Hickford <mirth.hickford@gmail.com>, "brian m.
 carlson" <sandals@crustytoothpaste.net>, Julian Swagemakers
	<julian@swagemakers.org>
Subject: Re: [PATCH 1/3] send-mail: improve checks for valid_fqdn
Thread-Topic: [PATCH 1/3] send-mail: improve checks for valid_fqdn
Thread-Index: AQHbvPycd8beOZFF3kqVQTGGtOiv7bPChfkAgAAR250=
Date: Sun, 4 May 2025 15:26:27 +0000
Message-ID:
 <PN3PR01MB95976EC68E23CDB5A77AE741B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975D45B072101812714C72B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <a2ceea8b-8354-4316-88ec-54111fb98d69@app.fastmail.com>
In-Reply-To: <a2ceea8b-8354-4316-88ec-54111fb98d69@app.fastmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNZPR01MB4382:EE_
x-ms-office365-filtering-correlation-id: f27b9956-bf62-43a1-b05d-08dd8b200a09
x-ms-exchange-slblob-mailprops:
 gMiuAN0LASIScjX/aS/OnauL17RJFM5Ja++JyBTu1M59yZ6g8iXFG4EfJsWCCFGLCWsB9o46dP2MORAvvOMlFHX5z+uvyhmsWhbxk78FQ8BHa630zRP6GlzLn698TBU2rxuzrD9bUowrbaZ8mRjBWaX10w2KDJl4tG18ZEdSPgdAnHyMpZzUof/jS9suZjy0N7kV2ZPiFP34V9HHzuKA4NLlNnpAGjYM4h4kTVmEajInb8psT8Iw5exPCcdGNKb/inToB8jkdbJm2A89H959VVefJ+SnQUM/G0+UdzR8IHcl13g/fzplSkKVrk2atgWqLYQSqT+S7+LYAK3Bd+3aW/V4Ep99wtjojo4xuVLZZT2Uyekirj9Yg19hi974jcpxl8OKguS1UDx/jwxzIKx4iu2BWyEU69VF3VUQx09uUt6/mmMouhZb2JAJ8rCmlS6oqX6wZD93mlKpojGXhJ0w5+ClaY2Z52ex83heaGMVRQgxWrVXPT5+FLXKjh+wlDWnPM9/cOPb2/EklGenw4yizXmV2nMlRYllXzQN8QQ1KdU0+zG8odocz9q23+inhONMdUMbgZJAtAQ1J4E3nzN1ktSv1zi9AKxA7+O40TvLeEa6Bi7r/olVr+MLmYH+t5BoJZYs20SBwmzyezP1M/BrB6jY+xXa38596yPRqN/PgiinZCLC903RDspCkfluvPN/XpWBkDG9iGvku92JxA4Yuw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|8062599003|15080799006|7092599003|6072599003|10035399004|3412199025|4302099013|440099028|102099032|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlU2OTZmSmZURDM2eURiditHM0lzMzRJM2NURnlPMHlwbEdQaTJLdlAxTnpa?=
 =?utf-8?B?eHpNVFZDNXR1dVNHOW4zLzF0YjMxc2RpelB3OW01eTBpWEQ0UWdOVXVNTXdF?=
 =?utf-8?B?N0lwRDhXeXpRN05WcGdkZlBSbDlHVkRQejN0UitUK2FaQy95N0FxQkpJbEt6?=
 =?utf-8?B?cGNDV2Z0VnBXbnpuSmNHTFBNTXkwamdueXlXc3hSajZpcUwzcy8vbWhyb1RL?=
 =?utf-8?B?ZERlRHJhd0NKYWdSUlY0c2xmZGt3MHI2WkFwZDZ5Q2VMdWkva3A4MWhwSkJq?=
 =?utf-8?B?WFpjZis1VG9rdERJNWNGNUFUZC84dlZyUUpzNHRHM0hjZUVUTDN6cFp3a0pa?=
 =?utf-8?B?RDMyazJWRmFNcXhqNk1hSjNHY2dMam8ybVJ2WmhvUnRoR1VWSkRIRXAva1N5?=
 =?utf-8?B?MFFxL1c0K1JJTkdVSlRrM3pidUNhdEFrczdhYUU2NFJjRVlQR1ZBamt5QTRy?=
 =?utf-8?B?Z29ZbGNKdWE3QkFBdU1ndHBLWXJUSE9icFUvRXRrbzBWRkd4WHdxZ2lwR21S?=
 =?utf-8?B?Y1FDY2N4TVdxanZ3UnZwSXp6TGVMUURNTThxUUVTWnNKYU5MUWZKMXQ2a1Nz?=
 =?utf-8?B?TmM2WU1jRHRRbzdDeFRTalk4dDMyaE1QWm1uRVZVaG9vOVdDT1VtWFdyTDNS?=
 =?utf-8?B?bXZUOGZpblF2dE8wMUlrU1pMMCt4WndxNk8vYllSR2x3TWJFNjhUbVZNUGQr?=
 =?utf-8?B?N0JXeWRmMmJWREhmNStPeDQ3S1I0T1MrcmhyTDB1eDNxckhIbGc5a3pSRk93?=
 =?utf-8?B?RWp0RVQ4L0k3S0xUUnViZjlyaEI1eWoyNDJsczlFV1E2VXpQZ1lCMVpKbDFh?=
 =?utf-8?B?R3hFSVFLVEZuOVlrZzNhb1lRTkJ5aFRZZXlzN0c1V0I1aFFITFUyWGpNVjRp?=
 =?utf-8?B?OGpBZG1KeTJtcFJOOU9YU0p6R2ZzWmwvTlZMUjNZZGxtM1JEZmJvWVBobkUy?=
 =?utf-8?B?UUZBdzBYR3lsZGMzNlBDem5XOGZCYWkvM0JpZ21QeCtsdEdLdzVuZHhrdlFP?=
 =?utf-8?B?ajNXU3k1S0JyNTczbFlrWHlvOEcwUldibVcxRlpoUkNLNlJHV0JKYTlzVE1K?=
 =?utf-8?B?ajNKVHd2TVcvbklhVmRVYUt1NXZaRXlsTWJDcGpzamxuejF2dkduTVJYTkU4?=
 =?utf-8?B?NGNOSWVYVHVFVW5KL3pYM2VGQUhzWG5vNVhwazhyQjFPVE9nZ2ZKa2lmMXdD?=
 =?utf-8?B?czRNdzB5eWZUemVyMGF0K3RTbzRSa0tHTXNkYWthUnNDZEY1eHV1T2duVTln?=
 =?utf-8?B?R3lyK0QzUE5TMFpvZURPYXRnNVlEOFlSZHNvRkJIN01RT0M5MWNDeUFNcUZn?=
 =?utf-8?B?bWRCM3VYV0dwMjlVOG1MbFVYYUJDT21LNUU2TkJnMU9OaGpCT2cra0NkbTA4?=
 =?utf-8?B?dDlGMFBlSHVQWWpYSVJiSzZ6VFR6blVpclNzbzhBUGFsc0hSd20wVWNSTUht?=
 =?utf-8?B?V3JHZGc1YWZ4Z09hZWJtMk9BZVgvbkZsQUJ4UU9lOGI0dEZPUUNpU0h1L2FR?=
 =?utf-8?B?d3dlVXlrZ2hyWWZZb3JYc0JBeitWWDlkS2c0VXR0MVNhV0l1MWp6V1ZkTWtK?=
 =?utf-8?B?ZmtDT1p1QmxNT0t5alFyUEhKa0F4RTFuQjh4bVd4WDh5MEI4OVczSUk2clZG?=
 =?utf-8?B?QTZvcnlmYWsyanBjWm9IdHdodTJGVVRJbVVWeHRxTVVnaU4vcUluMWlGV0ZO?=
 =?utf-8?B?L2l5V1lIWm1KTnJWNlV5VXZHWHB5N3R4V3JOZlRJQlVNQkZTWXZkT0VTM3Zn?=
 =?utf-8?Q?KgUxC9fVc8vCRjlwJE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXh6MmVBcHJhcm40VnVHQVhtcUk0U3pBUldwWHl2dG13d25OeUo2dFlwK2dD?=
 =?utf-8?B?N3pXMXVNazNIYk5CZVhSZUVsQk1DYlVJRHVXdkNOSXlwaVc4RWpFcXFOSVli?=
 =?utf-8?B?c1EvQWVPVFpDbVVrQ3BsQ3V6cm1kbGxLc3cvSnNUVkg4Wm1qalVDa0paNFZ4?=
 =?utf-8?B?c29iVzNKaGZJa1lYVkk3MmUzeklYaGs1cEc4L0xLbldhNWFIZ3gxbnlUckpJ?=
 =?utf-8?B?eHd5SEl1a3NZTFV0eHFwajR3RG5KVldqK3dDeTJqMzdUNVZqOWlQNUlBd1Jo?=
 =?utf-8?B?dWhqeDh6cXd1YjhzTldpcm1sK05WYlFOM2d0MFZ6M1UzckVKbHRnODVrTnNO?=
 =?utf-8?B?Tm5lUVd5ak5Ic254eVBCYTNiTlU2QmxvZ3lIaTRYQkhoR1cySDdhV2lpZUpq?=
 =?utf-8?B?S0ttZ1djRHQ3Nm1KQjFMNGgvamdjcWFWbGZXWGhjMWRuWElUdDh4bVZWUEE5?=
 =?utf-8?B?TDBiMFhkc2NmUG11bWhrV1lYUS9ieEs5cHdsYkVuOVRsU1VReE5qc2F2VzVx?=
 =?utf-8?B?WmZxVEdTT1Z4bXEwN1o3cjJiZnQ4NFh4Nk1BUDdzQ3lqQVB5WnpWTC9CRHRx?=
 =?utf-8?B?ckxsMWhvY3dyYktWRmVPekY0L3VlaWNIcTZIWWZwcXUraW02Z1dFTG5XbDJ3?=
 =?utf-8?B?bGNHY2ZLM1prM2psbEtqN0ROY0swUjVFaUowQjZtRnU3MmEzZEU5QTQ0QVd5?=
 =?utf-8?B?bUh6eUFtZjkxK2lnS0Y5YVdQcjNXVlpRNnJzZnFFUm9xNXZ1dW9kUDEyd3hm?=
 =?utf-8?B?WGVXMkh5N2tGTWdaWkovdzZkRlJZNWxjc25MOEkyRDBlb3NaZ3NpYU1COExi?=
 =?utf-8?B?ZEhodTRZanYrWHA0ZXZNRllmeGZOVFhyeEJrT1dmS1BPTFREb3ZOY2tmYWFv?=
 =?utf-8?B?QUNDTWMvYkduSnJoaVJweldtM2dBaGdBQTMrUEhjOG11MXFzWWlUanZPVjBp?=
 =?utf-8?B?d2tvTjdWU2hMTWV4QXJWSjBKbkJNR2NsSVZBTXh4Q1k5emVJdkFWUjZjU3U5?=
 =?utf-8?B?c05GK1Z1dGcydTVYYy90RERpTkM4WEg3SllpWk1MMUFqWFVERG5xaE85bUsz?=
 =?utf-8?B?UitxcUZLQm5JRVR4U0ZTT3pFMEw1NXg3OUpEOUJuTDZac3EwQ0RnSlVROXgw?=
 =?utf-8?B?TGtVUlpkd20wQlR2SkZOR3dKaHlRRWFwb21TTHhzNVNuRUtWN3ZxdEx1ek1Q?=
 =?utf-8?B?OTFiNzl0a0ZZNHljTC91blpIRVFyaDJWc28rUXdmN0FHc2hXWmQ1UVRKRXR1?=
 =?utf-8?B?MUJ1blk3RWxKMlhORkxiQjE2b1duSnE4S09GZFEzc0MweWdMejZWek9sek9O?=
 =?utf-8?B?dURGZlNSUDNsTGREQmNWUkZ0aWtpMC90bTlxaU1DVWlsQjRsREE0cWZzZ1By?=
 =?utf-8?B?TzZTTW1SZGdtanJtYmdSWEdTaWowdGh3RGlJQUc0V2dmOHJBa1ZKZEZ4Wlc2?=
 =?utf-8?B?TDdOcmZpVEYydGpjN2wrNXp2ekpRcHpZU01JOW04VW45ZlhBbkNEUm9GZ0tN?=
 =?utf-8?B?b0Q3cEg4RjNnZ2dVZ0gvcERiUlZxVW45dFN6VUcySnZwaDQ3NTVTNHYxVmU5?=
 =?utf-8?B?UERRc0QycWxCNDNHQWJOOStnQ0NEb0hjZmFTdHJQZTZNVHFuQ1l0R21IY1ZH?=
 =?utf-8?Q?juBpaExmZTMQe3nJ5ns1ByAIqhoX9Qp9RC7yUPDgRqVc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f27b9956-bf62-43a1-b05d-08dd8b200a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2025 15:26:27.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4382

DQoNCj4gT24gNCBNYXkgMjAyNSwgYXQgNzo1M+KAr1BNLCBLcmlzdG9mZmVyIEhhdWdzYmFrayA8
a3Jpc3RvZmZlcmhhdWdzYmFra0BmYXN0bWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gU3Vu
LCBNYXkgNCwgMjAyNSwgYXQgMTU6NTQsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gWzFdOiBodHRw
czovL2RhdGF0cmFja2VyLmlldGYub3JnL2RvYy9odG1sL3JmYzEwMzUNCj4+IFNpZ25lZC1vZmYt
Ynk6IEFkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+DQo+IA0KPiBGaW5kaW5nIHRo
ZSBzLW8tYiBoZXJlIHdvcmtzIGZpbmUgc2luY2Ugb25seSAyNSUgb2YgdGhlIHRyYWlsZXIgYmxv
Y2sNCj4gbXVzdCBiZSB2YWxpZCB0cmFpbGVycywgYnV0IGl04oCZcyBwcm9iYWJseSBiZXN0IGlu
IGdlbmVyYWwgdG8gc2VwYXJhdGUNCj4gZm9vdG5vdGVzIGFuZCB0aGUgdHJhaWxlciBibG9jayB3
aXRoIGEgYmxhbmsgbGluZS4NCg0KU3VyZS4gSSdsbCB3YWl0IGZvciBzb21lIG1vcmUgcmV2aWV3
cyBhbmQgc2VuZCBhIHYyIHRvbW9ycm93Lg0K
