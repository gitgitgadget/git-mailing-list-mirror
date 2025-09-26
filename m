Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021103.outbound.protection.outlook.com [40.107.167.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8A27C869
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876411; cv=fail; b=PCt5foYZZ27C0Rd9CcMaROtFujCKn9fEhMkUasPF6o0XJoTW4IWh4xyH/y9zh9rkuiwsI+Jidjx0Wws92jPS8s3DTQjJot2Mqgd0Vqju1b7bpJ9+O3mz4SQi2O43knrYuXdx+rCbl1oFn8sQPvUiQOGVPOgrUBWAd7m/mx83h4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876411; c=relaxed/simple;
	bh=NX0Nn9Qmw4n8zm+JZn8uwWScURiOGifWmW6N5dupk+g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nU59OEYjWwTyMRTPsYlDFAAhxC+jRPx+52ITVnqYAYSzGlw44GwKKF59Ta5BpwAXxhl45V0zSZ4d5PrujPhLjpVbeGUySU3GNPJt6AcQgFvNe24bOIIgDV+FpUEYCBoPwi2ZAyQyHcc3bUwc30NqKL03wQ8z6RDDJfgvhcHAR7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=enclustra.com; spf=pass smtp.mailfrom=enclustra.com; dkim=pass (2048-bit key) header.d=enclustra.com header.i=@enclustra.com header.b=QqSutlZB; arc=fail smtp.client-ip=40.107.167.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=enclustra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enclustra.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enclustra.com header.i=@enclustra.com header.b="QqSutlZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igSHNVsNxkgNs2oS2aUCBTzzciNt5U5FRY19BaPwRNk6j8LGYh141f14LUv0QqDIbHRDm969RtQrzsY127YWi0v/LJ5P2lKVNICDg6aezheSE57ybbc3NXJI88JVE8BZFdnCwuAmCrqdOwJq8wMWMaalAw48l0BKFPvgC81QDMxBVgpbz/U3FaoNkCYIqrfURdSpcgq4x8UDo+iOS55iU9NAvaouZhBApyXk5KkeDB8J15bzrWJSLmLkhQcLtqSfLfKGWVcypt9lVvPBitCqU2Rzhu3mcdk9dcsWZsi6DO70yKgM5HUBmyHJbn5+7qKs1jj2sGVSaICq9fqPx8SAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX0Nn9Qmw4n8zm+JZn8uwWScURiOGifWmW6N5dupk+g=;
 b=VaFlZqQMOVics2JPGC4pBkSsQdGTzNW2lNLnw2hNrHQHrf+tBeoV8G1mhs5wcG6ch01Jvnt7otZqAgxrp9zPBW8u2PQPikU1s80VuP3EnDdFsxBgc/Cg6rf014fFPidXyu0jkwRUE1++zMqr8rXYGTgwCKSTFkeD0Ykw8rEdx3Aq4xhFBL705Eo7ka2/dDpKwpQM1SX4nt6+NAFKqfY1hQTrctL2zkp9K4TnaS+oskz8Gwipz42pL7s3l7qgMaly+MHPMEzjMVsMWaTp4oMgB3/j+fqwB98/Snz9oNg9qmTRk2eeiDrfKPsucAveRqyd98VURSHMU6dIZqSt4l+Izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=enclustra.com; dmarc=pass action=none
 header.from=enclustra.com; dkim=pass header.d=enclustra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=enclustra.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX0Nn9Qmw4n8zm+JZn8uwWScURiOGifWmW6N5dupk+g=;
 b=QqSutlZBBevl2mi2iw+7fN1oGosRNwSvgOdsNjDn93wc4j5fyWcciQuaqzRBEXoUUKFGTtKPLdnykv0GaPqXzwRl/s3fIYEfzZyQhjoGmC6ThkQu75kTqzv3vLWwVGgDPAKHA5DfWQXSXrCYb7Ta+acUxrNJxBWIWEy+URs2q4joMtj0SokYkxP8BxoBxj73abEFz/0y9VsTR0b83T5ytGLAZlA3wYr1xIcVp+vmcYdOLczfwKr7rOrgAXOBsf4yZP07ds9GzbmszLz0Tu+JaPDMcTQJuYX726NbDfMNDGjDQEtrDh7jOsdRL3EFyzYgO56nGXDIr6Fh8tXXPujacQ==
Received: from GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:49::9) by
 GV1PPF84DEB8E9B.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::21d) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Fri, 26 Sep 2025 08:46:43 +0000
Received: from GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7eef:20a7:6291:fd06]) by GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7eef:20a7:6291:fd06%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 08:46:42 +0000
From: Tiago Gomes <tiago.gomes@enclustra.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] Git Bash no longer detaches GUI processes with & in version
 2.51.0
Thread-Topic: [BUG] Git Bash no longer detaches GUI processes with & in
 version 2.51.0
Thread-Index: AdwuwhQSMxRSk1AbRzmK/cj0GVZBKQ==
Date: Fri, 26 Sep 2025 08:46:41 +0000
Message-ID:
 <GVAP278MB0582C91C40BC818FD57C59F6F91EA@GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=enclustra.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0582:EE_|GV1PPF84DEB8E9B:EE_
x-ms-office365-filtering-correlation-id: ca4aaa2c-6959-4097-96ab-08ddfcd9371e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RW9HNUR5akVKcEU1YjllUzA1SXdvNDJiZFJPV2JOZ3hrb3dTTkRERWwyQkFY?=
 =?utf-8?B?WTBFdzFMNTVmT1diUzViYlVYOE1sT3N3MmloSVV6SXRKMzQwY00yeFNkT0lG?=
 =?utf-8?B?SDh5ZHZQL094ajhLL2k5aHpHSm1TOUE4N0tubTl5Vk5MVTN5bE5ocU1SSktF?=
 =?utf-8?B?b3Nwd1czQ0tWN1l1Q1RXd0lXNW92cFdSQ2IwRXNkdmUvNkx6dW5YSjNocDUx?=
 =?utf-8?B?RWMvbXNWSTlEYjBWa3BTMmp4cTBSMHIxYTkxRiszdkFuaVJZZGZ3RGJIaHVZ?=
 =?utf-8?B?eVM0VTAwTTZjd01aY0piZmdNS09JTFFFZjBxVVE2ZGZjZG5DS2FGSTg2cHRX?=
 =?utf-8?B?R0lFeEZVdmptcmJxWThNQ09oZWFLU0JJOUNmZVYrbEMvYXgzcytQTWtYZVZz?=
 =?utf-8?B?aUlvSWIzMHBncDVZaExNbFRkeWwwbzRNbkVibjA3K2s0aStvSVhSby9mNldu?=
 =?utf-8?B?NURkTThQQXZJaExGQno3dnRrRlc3OEdtVVpuVUZZZDlxdXJCWEZvL3FOQUN4?=
 =?utf-8?B?eTVTKzU1UFd6R2Z2dGJ5YU5jeDllMnh4N0lyYjVHY05WMjRLQlo5MzBndzZa?=
 =?utf-8?B?b1RSbTF1bkE3bFNmK2h6NXBYTCtxRFZKRUllV3BOQ1VHR09jdThQSlU1Z2dJ?=
 =?utf-8?B?RkFteW8rS0dXTDB6Rk9FZjVSR3RZU21HVWhiL1lhNWZoY3BhVllONDdiU09w?=
 =?utf-8?B?SlJEeUwyTUtRRGxpRlJNL0V5VUtQVm1JNFJ1RFF0VE5xMWl0WjZld0FkbmUv?=
 =?utf-8?B?b2czTzBNQ3lxbHRXQjRkdlRPTUNRbjZjVDlINjhvdWxRKytlaDlCbE1jNUhV?=
 =?utf-8?B?MVQ4anlJcEkyVW9RcnlQOUwvUU1YSkViV2R1K2g1U3lLVjdhQ3ZaTUtVaFZ2?=
 =?utf-8?B?NHcremZkWWtnT0x3NTYyMDJxSXE2dGpjSEJ6b1ZXSDg1Q0swSkpYcmJ0OXBw?=
 =?utf-8?B?bkJnRjgva0s3TGRiM2l2d1hiMmlGQlFtNDlKSlRwUit4NWVBSkwra2FzVktp?=
 =?utf-8?B?R3k3V3lZQ3l3VlRKQXZmNW42QWN4QjNLcHZIa1VGUzNPa1JJSVFadERQZGZT?=
 =?utf-8?B?Mmc5V3JtU2VyQ3QraStnWjhrR2kyWTNWajRkOEF0WEtqVnBDS1RjVEY4alBn?=
 =?utf-8?B?bDF3YUVsM1hqS1Faa2FFL3MvSUVVTjQzTnBoZU55cHBEZXFJMCtldnJjN29r?=
 =?utf-8?B?d1JrWVM5VDRaU1Yrdys4c2kwbCtxUlFST2k4WGhIVUs2VGszNnBaOW9VT2xs?=
 =?utf-8?B?cDBhWUxpL1lYRFNCNDBJM09MMWsweSszeVUyWmdGa3FEM3ZEK0NrUlU3bk9a?=
 =?utf-8?B?a3I4MkE4cHRYdDhXcWJabkZDUTkzL1lQNzVvUHhLUW8yUjBhNnZhbFhLcTlD?=
 =?utf-8?B?RHZqZDAxdkFrRjFnTjdLNnpEUGNZTFY1L1B5U21YdEdjdFI2TG40L3N3T0R1?=
 =?utf-8?B?S21SZ3JMc2xGTy9tSEpBUzQ2YTBEK1ZtV2hMMEVvbHdVeFJkRUdQNEtUYS8x?=
 =?utf-8?B?Z1FyRnJkR3hHUDhPYVN3a2RYbHFnMGtJa2ttWHBtZDByRW5NNmU3REluRnpK?=
 =?utf-8?B?eERNR0xETFRTdTU4bFV3S3RPMHFXY1AyeDhIS0puc0ZZTTY1SERaci9PdUZY?=
 =?utf-8?B?Ujh0RDMzNHlQeDMzeS9jdlBJM01MY29TbkdJK29kdDlkbFNpd3RqVy9DQTZr?=
 =?utf-8?B?SUNOc0ovVjdncG5OUGtqK0RlR0lqV3VwcW83VlR6WXNFVW9EaVN4VUQrTU9E?=
 =?utf-8?B?c2wwVnFIZlpvUHRCRDR2Mk1FVlVJYTE2QldoMStvRU9oL1lMZ1oxcGh6Vklm?=
 =?utf-8?B?L1NVRXVSTyt2WGxvS0xSeXFyVXJSU2R4ZmQxVTlhRG0vQ1VmNnBjZDZXcTBa?=
 =?utf-8?B?NGpDcnJyS1ZhNWhGOTFndVcyYlpPdldmUWpsNXBaU0NmSXFUVTFVMjU2ZjZ4?=
 =?utf-8?B?dXhhcWN3WEpqcHBSN2tKTmo1clBxS1FqMjBSc2JYdS9DTnViYThNSmpnNHVM?=
 =?utf-8?B?NGNpV2lWcDBRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3I0RmZKeXNuQWQyMEpXWFJLZzQwUlNwM0IyQ0o4ME5PWU1YNGUzUEVQT0Jq?=
 =?utf-8?B?Y3hQbDdhbjY1d3Z4UEpabVBSVDl1VEFDZFgwWlpJeGN0QkR2MnEzSDB5djdk?=
 =?utf-8?B?R3paY1o1TmdzMmo0MzJCOHR4cVJrUTZqOUxwUFNBdXc1Tk1OYS85elkrZDd2?=
 =?utf-8?B?eDFlZWhFUFhjUHNia0VaRzhKRW05RUROSEZKaGpWN2hNS0NCSExGanlMOEd5?=
 =?utf-8?B?ZStEQW8zKy8xRVdzcnovSHZLQWthVVhFTkJ6bXY4c0xFQkxER1NFZ1o4RTgr?=
 =?utf-8?B?S1hrUDRmM3pQTnF6SnhsUStvU3p2Uk5XcXEyTHpBczVsWTZuSzhWdmhvNmZU?=
 =?utf-8?B?V3h2TmpqRThYVkV4NVI5Ky9WeFpQZVFJbGI5a0Y5K055K0VTdlp2OFljUGlZ?=
 =?utf-8?B?TGV0ZWxmamZrVFFnTkZFM0NyS2Q0VjlYMWZSUmpGOHVyV0I5Mis3OVB2NzJJ?=
 =?utf-8?B?aVcySDFkbFBZc2Q5Y2lmaDZPZFgzblNtVFlKNExnalpHOWp5a3NyM1BVd04v?=
 =?utf-8?B?ZnQzNHM3ZG1ULzJUeTF3Tkg0THZvaDJuTzdMemNiYXdmU3dzeVd2ZHh1NEZr?=
 =?utf-8?B?UGxRS3QyVnJXNXl2TllJa2xURHY0bTRTUFhaRlFHeXhBeXhkS1Zva0NCNWhM?=
 =?utf-8?B?YUh4VjVaSVM3Z01aOThQMGE3bEtIa3dqZHVUYThyK0NZMVVESkVmK0JjSkxP?=
 =?utf-8?B?Y3RFdjRFMzVySHVuNDRQZ0I5cndCQjJaTlUxZVM5UzgxUzZKRDFYVDFTYjZV?=
 =?utf-8?B?Z0k2amdSRlJsRjdVMHNBc1hURmxYemFTaEh3YnRyblFwYlZtM2QyNDFTbnZI?=
 =?utf-8?B?aEVKYTB3OWplVVJFeDV2QS9Kb0VWTEROR2phTGZZN3ZsbTN5NmtmSUdKOC9C?=
 =?utf-8?B?SXNBVm90R0ZyczdDM2tKVVBVd2ZQVDlDR2w3dmRteEdaM0Y3aGl0M29LUUhR?=
 =?utf-8?B?Z2p3RzNyODViUUFsUWdSOHRxL1BPMkxxQStNNXUvQ3Y5VDJ6dnBrb2JLMlBS?=
 =?utf-8?B?Wk9jSS84WWtHSnlEeFhndThhbE43K0pHTUVOcFVtVjVRd0twcXN2eG5JL1RL?=
 =?utf-8?B?aG4yZHE3VElRK3RaV1ZKc1l3bnkxL0YzcVo3R051ZW9HazV1RWtlR2lXUTZD?=
 =?utf-8?B?ZUdsS0Z3c2hIdGMzT1JlVW42c3lCcjhIQnQzT3J3bzRhbkNkcWxiM09vbTVi?=
 =?utf-8?B?c0dxN0pUREQ0a1M1clRXWkVmUEF6eTdiNkt5VVJueWdaN0tJcDFlSGNIeTd3?=
 =?utf-8?B?OXIvR2x6OExsNG9UbFhwb3pDMDlGWWt5U0VJaVJ0cHRrUE8wQlo3RUg3OWFv?=
 =?utf-8?B?cUk3RE0xTldKODlBaTd1OG51aVlGSlVMc3E2RnhKL3JVY3FCbkZWVENEN0JI?=
 =?utf-8?B?eDdDdDFXTFpERjFEQ3BlNjNoT3ljNUErSzZsR1crbjRwYkxNc3pRUG5WSnpM?=
 =?utf-8?B?Y3Q2aDQ0MFQ1bkw3ZVhMV0loSGNkRVVSSGhkRWRDSm0vWWRsbkt5OFZrOEdF?=
 =?utf-8?B?Y0xwR1NlTUY5UjIvQ2JlYnN1QUNpZkhQZUcrcUU2RTZGMDNQSFpyc0JuYmRM?=
 =?utf-8?B?eXpnYUFhNjhaTTdNTXRHOHU2akRNdm1LOGppV0swTEMzMTU0WXB3M09IRVlw?=
 =?utf-8?B?SHJVSkxwbEp4RGlBYXhyalhDS2NtVnZGakJKMW1VN1YzV1J5N3pxcGtOZi9n?=
 =?utf-8?B?dGJCVkJXNmE1RG1GSXp2VjZKenBBcVVxWTgrOEo5VXhEZFZocDh0ZGdJWHhX?=
 =?utf-8?B?eHYrcDRvVzEzYk9jQ1o3SHAvbGhDS1FGYUhXeGF2NDhySkV2cjhQelBUU3Fn?=
 =?utf-8?B?OFV5VmRLblJ0OFFuTjRER21NTzMzaDBlMFRmMG8wU3RtbDV1WER3RE4vMjdJ?=
 =?utf-8?B?UG5RQUtsR1RaMC9NRlNiK3hLcGppT2ZQOUZiR1BJRStrT204M2t1Q09tZ0NQ?=
 =?utf-8?B?M25hL0I1WTVmMnpXbWhuV01SeFdYNGNIMjZaOTM2NHJ5Q2UwOGFpejY0Rnpm?=
 =?utf-8?B?YTFwb1k0eUQ3VHE3NFQ4RGNIYXpqVHN6bTg4SXYyVk1NeXNrYXcrM3lUcTl0?=
 =?utf-8?B?S1ZTeGh4dXJieHhjUkpzVWhQTG5VcG9MbnBvU2Q1cGNJRWtGaG9Pd2d4Y1A1?=
 =?utf-8?Q?utqmGbl+45kq8LHDt3T4ev1D6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: enclustra.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4aaa2c-6959-4097-96ab-08ddfcd9371e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 08:46:41.9206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8316e432-9d32-499b-abdf-06a868d8a248
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdty0qeO1biQlf5ypsvz8e+93YpsTG+VFp2u+z/TmISrJ79cZ8PHCXmWgyo14wUNwwqNKbwQDBifX8Yx5XW04A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPF84DEB8E9B

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQpJIGluc3RhbGxlZCB0aGUgdmVyc2lvbiBHaXQtMi41MS4w
LTY0LWJpdC5leGUuDQoNCldoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQg
YmVoYXZpb3IpDQpJIGV4cGVjdGVkIHRoZSBzYW1lIGJlaGF2aW9yIGFzIHdpdGggR2l0LTIuNDUu
Mi02NC1iaXQuZXhlLiBJbiB0aGF0IHZlcnNpb24sIEkgY291bGQgdXNlIEdpdCBCYXNoIHRvIHJ1
biBNYWtlZmlsZSB0YXJnZXRzIHRoYXQgbGF1bmNoIEdVSSBhcHBsaWNhdGlvbnMgKGxpa2UgVml2
YWRvKSB1c2luZyB0aGUgY29tbWFuZCBjaGFpbmluZyBvciBiYWNrZ3JvdW5kaW5nIG9wZXJhdG9y
ICgmKS4gVGhpcyBhbGxvd2VkIHRoZSBHVUkgdG9vbCB0byBvcGVuIHdoaWxlIHRoZSBHaXQgQmFz
aCBjb25zb2xlIHJlbWFpbmVkIHJlc3BvbnNpdmUuIEkgY291bGQgY29udGludWUgdHlwaW5nIGNv
bW1hbmRzIGV2ZW4gd2l0aCB0aGUgR1VJIHN0aWxsIHJ1bm5pbmcuDQoNCldoYXQgaGFwcGVuZWQg
aW5zdGVhZD8gKEFjdHVhbCBiZWhhdmlvcikNCldpdGggdmVyc2lvbiAyLjUxLjAsIHRoaXMgYmVo
YXZpb3Igbm8gbG9uZ2VyIHdvcmtzLiBXaGVuIGEgR1VJIHRvb2wgaXMgbGF1bmNoZWQgdXNpbmcg
JiwgdGhlIEdpdCBCYXNoIGNvbnNvbGUgYmVjb21lcyBibG9ja2VkIGFuZCBkb2VzIG5vdCBhY2Nl
cHQgZnVydGhlciBpbnB1dCB1bnRpbCB0aGUgR1VJIGFwcGxpY2F0aW9uIGlzIGNsb3NlZC4NCg0K
V2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVh
bGx5IGhhcHBlbmVkPw0KUHJldmlvdXNseSwgdXNpbmcgJiB0byBsYXVuY2ggYSBHVUkgYXBwbGlj
YXRpb24gd291bGQgZGV0YWNoIGl0IGZyb20gdGhlIHNoZWxsLCBhbGxvd2luZyB0aGUgY29uc29s
ZSB0byByZW1haW4gaW50ZXJhY3RpdmUuIEluIEdpdCAyLjUxLjAsIHRoZSBzaGVsbCByZW1haW5z
IGJsb2NrZWQgdW50aWwgdGhlIEdVSSBwcm9jZXNzIGV4aXRzLCB3aGljaCBicmVha3Mgd29ya2Zs
b3dzIHRoYXQgcmVseSBvbiBub24tYmxvY2tpbmcgR1VJIGxhdW5jaGVzLg0KDQpBbnl0aGluZyBl
bHNlIHlvdSB3YW50IHRvIGFkZDoNCg0KUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVn
IHJlcG9ydCBiZWxvdy4NCllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0
byBzaGFyZS4NCg0KDQpbU3lzdGVtIEluZm9dDQpnaXQgdmVyc2lvbjoNCmdpdCB2ZXJzaW9uIDIu
NDUuMi53aW5kb3dzLjENCmNwdTogeDg2XzY0DQpidWlsdCBmcm9tIGNvbW1pdDogOTFkMDNjYjJl
NGZiZjZhZDk2MWFjZTczOWI4YTY0Njg2OGNiMTU0ZA0Kc2l6ZW9mLWxvbmc6IDQNCnNpemVvZi1z
aXplX3Q6IDgNCnNoZWxsLXBhdGg6IC9iaW4vc2gNCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9u
DQp1bmFtZTogV2luZG93cyAxMC4wIDE5MDQ1DQpjb21waWxlciBpbmZvOiBnbnVjOiAxNC4xDQps
aWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlDQokU0hFTEwgKHR5cGljYWxs
eSwgaW50ZXJhY3RpdmUgc2hlbGwpOiBDOlxQcm9ncmFtIEZpbGVzXEdpdFx1c3JcYmluXGJhc2gu
ZXhlDQoNCg0KW0VuYWJsZWQgSG9va3NdDQpUaGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMg
YXJlIGludGVuZGVkIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIG5hbWVkIHJlY2lwaWVudChzKQ0K
YW5kIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHByb3ByaWV0
YXJ5LCBwcml2aWxlZ2VkIG9yIGNvcHlyaWdodGVkIHVuZGVyIGFwcGxpY2FibGUgbGF3Lg0KSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2Vu
ZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95IGFsbCBjb3BpZXMuDQpUaGlzIGVtYWlsIGluY2x1
ZGluZyBpdHMgYXR0YWNobWVudHMgZG9lcyBub3QgY29uc3RpdHV0ZSBhIGJpbmRpbmcgb2ZmZXIg
YW5kIGFueSBwcmljZXMgYW5kIGRhdGVzIHN0YXRlZCBpbiB0aGlzIGVtYWlsIGFyZSBub24tYmlu
ZGluZyBpbmRpY2F0aW9ucy4NCg==
