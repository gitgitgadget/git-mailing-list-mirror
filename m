Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6713AA5D
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738208966; cv=fail; b=R+mhBV5UyBoWW1D5+JAxLd2ZSXn5pe5iXThclHaN8e/cS3T91PMLzoKT/zPKCwN6J8UanpX6FwpDHBMVFdtouz/LEQ7klxlcWYzOX3Sh6S0S3+iFBlywNFHBw5vGDEDq9Obj2oeoLGMSUrxMc8uZMJGOlgzk3zoX+T5jPdBk9ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738208966; c=relaxed/simple;
	bh=7FkABqr3rMUxb2Nkz/bY83ACEclnxw8tKQf9/Ik1QUA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ev+b/v3TuqMs0Fo/JLNVzjutskqgmKQSTQF3Tru0l4j+tzYNCOFZgwyRWL0NX0NCQm84hP4RddZmEzmrKHtTRWYqJ5MggEGtexCuQ76tLIOjJzOEHDcsh2EMMrXUZ9zCxXhFuVhExK8mcAdHDK/lOMgjyRMqc9H6oqC7ixuAF58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ca.ibm.com; spf=pass smtp.mailfrom=ca.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F4WizQMb; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ca.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ca.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F4WizQMb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFdaPo008590
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 03:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=7FkABqr3rMUxb2Nkz
	/bY83ACEclnxw8tKQf9/Ik1QUA=; b=F4WizQMbYIyQlj7EpwYSNA4zXm+xjKNhv
	OAsj7Jdm+3w694E9xWFU6elc1cm/5/DYNQmkZ11UUCZi4m1UoLjTJelpLMqb7Ji4
	IEpvgs1Id0WROvGZFDZnVBI2MGAZNG/sY757nTkM2QfJGbzmfMDwp1yxeTvvYK62
	taP0iAToC1RKx+e/zCW857+yeH2jIoppFhENbxmbGid4hPHkMBeNdlelyAtMEEkb
	l1VHIQPVpWUZ/k7Rmpo22etUiNsO2yIMvCJ4JSTcVEfxNtmH5a3zE02REq4/+uD/
	t9eTxivuzRP8ERBCv+o5OHqfiGpufyfJeaKmiEJiVfPid1gAWZmbQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fq5ttx7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 03:49:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9uFv42S519cte9DV1RlkRznB3NGx/KIJUF60itkn+oQUQGciygGIZ/Bch4PimGLzMzHp1zP/C3BZptQfhROJV4kt4LYyuatIFMSVkgP15mHMXxFphibnebMW5Hdfevq6tFW3wvEwBsCYrWxy8W2WFIgxK2VO8qfdEodVVg+h2KhpHDCIWvN37YVMLyqfIlMehf2wOgpfnHlCMuOVTtFknAcs8VNJYyPbJQFVu1oqql1RTBysRm2Li7thKjJXA9mRofNiMCP05hp9J1SMMfU6cB+9ImCMME+V4rnDDs2V54FpgF7jFEhdZJXvQ+KipIMnzsvFbXRApQDCK5VkDC47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FkABqr3rMUxb2Nkz/bY83ACEclnxw8tKQf9/Ik1QUA=;
 b=QtNS4OYvEIZijlNajM5EwJDYI4MVovZsIcw4pvk7GIUmxR7zscpdCfOItORiBmR9x7DyMu138zWSadAL91Tn6EUJvbMUIDtXg5OESgO17Z9rYWfqZXYVTvEvuAmRg3GexGueXVmwXG7JkCg484bjZwZx7r8hHXRE8q3nEwdr/7pJHLGE9FPUnE6TOiCd+/cvvSFiiRpPkwA+lwW3K9XZAy9rRkQuGT0K9gEfdoBY4VSSnWj/45pQRftBCfHumvhwJrQlWdqhs7MNhBwI9YuyObLV2lKMwq7DRzQz4DzPDf1W7+dNeEkX4iigj+Nkv3q2y2rUFZzp4GXkV5XRcWjSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ca.ibm.com; dmarc=pass action=none header.from=ca.ibm.com;
 dkim=pass header.d=ca.ibm.com; arc=none
Received: from SJ0PR15MB4696.namprd15.prod.outlook.com (2603:10b6:a03:37d::17)
 by LV8PR15MB6510.namprd15.prod.outlook.com (2603:10b6:408:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 03:49:20 +0000
Received: from SJ0PR15MB4696.namprd15.prod.outlook.com
 ([fe80::fa2f:eb54:e340:9574]) by SJ0PR15MB4696.namprd15.prod.outlook.com
 ([fe80::fa2f:eb54:e340:9574%4]) with mapi id 15.20.8377.009; Thu, 30 Jan 2025
 03:49:20 +0000
From: Igor Todorovski <itodorov@ca.ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Tags are no longer fetched when fetching specific commit
Thread-Topic: Tags are no longer fetched when fetching specific commit
Thread-Index: AQHbcsnxzhM1+tmgw0at9LbCwoNItg==
Date: Thu, 30 Jan 2025 03:49:20 +0000
Message-ID: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB4696:EE_|LV8PR15MB6510:EE_
x-ms-office365-filtering-correlation-id: 028ae36b-c560-4b5c-09ee-08dd40e113dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?by9QaXB1bm4xUUhWaWk2UXEwQ1pDbEtPNEVGUjhMci9RN04yaE1CMlUrUHV4?=
 =?utf-8?B?K0pPRWNQNHlNanFnRDYrdkcwNEVndzF5L1NLZlZ6WGR3cGJIWnFVQm13cWds?=
 =?utf-8?B?czZHU2dKd25xS01QWVBNbGt6NmlzNWsxRjZUU3grc2ZhYkJ4dDZSVnA0NXVE?=
 =?utf-8?B?bUVWZjdsRUN2ZUZVT3ozK2Uxem9VZVViaUU5TVhndFdqSkIyY1BxbFRSSHNp?=
 =?utf-8?B?TldVaXhoZkdGTExEZUEvN0dEWk1DeUN1OHE2WjJZRkxLWllOTEdNSzU1S0pQ?=
 =?utf-8?B?Z09ranJndWlHQTVhZWxaVTNFMWRuTkRNNVNEYzRNd3lmSWhmUU51NnBtMVpJ?=
 =?utf-8?B?OU5Kdmd3V1FPMWlQbDhaK2N2b2VkYXhHWGdzamIzdk5Xb2pxcVpsNUNmQWhE?=
 =?utf-8?B?bmJNb2dUMjA0VTVLZzJTbTBmMmdvYWJJbHNkeHZjWlgvQTAyMG1RNVRnMkJx?=
 =?utf-8?B?U2FsWjhkcit3em9qVldSeVd2MVBiUHpFSU5QbVFoYXlwRHVwQktVQ0dWdXdq?=
 =?utf-8?B?eGdUQ2lPc2RNOVFUa2t6YnlvU1IzMWRqRGM0Sm5lZjAvaFlOTjlCcnNsaHhW?=
 =?utf-8?B?c1ZxdTA5UTRPZ28rZy9DMWhpd3hxVVR2ZFBzaGVQY1JmTER0akQ2WVNEYWtK?=
 =?utf-8?B?T2lyejZid21JVWI4bk1HUXdGRWlRMkFIWjFjejNoY2pJbDVtcHpLOStuN2VW?=
 =?utf-8?B?YS9zVTdnR3orZWxMc2VzcThLTWdveDVsQitYK0lPUnUyVU1HcHQ5alVmSCtv?=
 =?utf-8?B?K29EOWlvN1hwaE1ueDRKUUpiWWd0VUFwcnlXditSVTFpS0Jxb25JQjUzU0Nz?=
 =?utf-8?B?Zy9NL1Y0ZUE1OVRaK3Q4cXNiWEFYbUxURFJ3YzIvMWhUaEc3ZndTbkdLWE5n?=
 =?utf-8?B?MmYvdkovVnpra3BJNlBpUGFFMFY5Tm5XNHA5T2pYdlVVancydnkxenp4TXhr?=
 =?utf-8?B?TmsyNytBRTF3VFFiQlVidG5xbmRSZXArS2xlK1VjRnc0Vzh3MUJPOEZwTzVq?=
 =?utf-8?B?OFI0YmFVUGxnZVE3Mjl2REZGbEVnR0QzWTBMcmNnb2tKc2xtTU1KZTFNeUxG?=
 =?utf-8?B?TWs3VTh4NVFqdTJIU0JqRWhjSEljc3FzeEdVbHlHQjZYcStSN2NHcExXQmwv?=
 =?utf-8?B?dVlNVkxZbUV1ckkzVTFiUG9mVzNLVXhPSXdBcFJjTHpHTHJ6aG9JSEZYM2hm?=
 =?utf-8?B?S3Mybm9ZajBBY2U1SFBYODQ4MmpQVVFHSGwzSWJLbU9yOWZKaFBONWhIdnNo?=
 =?utf-8?B?aVJYUTNnOXVhTC92VXAyS2Q0WUJYeitLUXZBN3kvUDVZWmFaeUtZTjY1RzZ2?=
 =?utf-8?B?RUU5MDB3ZWl4QWFGYUcwQTB6M0RTQ1NjeFVVMzlaVkI4aDNhVUIvUHJ4UURm?=
 =?utf-8?B?ZDhZR2ZOdUExS0FXZG9XTnFkbEVyL2c4bUgxU2IycVI5cWFuL29iNDFBNFZk?=
 =?utf-8?B?Ui9lTm9RcS9ONzNrS2pwSE5IbldYOTlTSjlhTE5UODN2clVmWUdGbHhiOG4x?=
 =?utf-8?B?UWFiRllXajlRY0F5aldlenhBM3lTWDY2MSt6MUxaNUxXYXBMQUpUYkRWamUz?=
 =?utf-8?B?YVh4YVlnZDBFUWhXNlFLdFlXd3JzSnNJNVBpZEk0Zm5KSEk0QkUyRmZwSHY5?=
 =?utf-8?B?WlA1aGdSYkIrWFhjUEk3NSszSHdrUWU0cUVTT3hQTTdmWmh1QkdJdjlSRUUz?=
 =?utf-8?B?Z083WHA0Z3BmRGp2TUs3UWRTMW9ZM2QxaEZNRld6UXlYWkZxMGtMYTErcXp6?=
 =?utf-8?B?UFRPVzB5M2NDSXFMemNTeUpGNktkR2w0UmNleXU5KytmczBTaDFObmxRODBP?=
 =?utf-8?B?aFVQZzVnWFU5QU8zeHd2dkMxeVpkOUppaU9XTFlFTzVUUDQxSk43R3VldWwz?=
 =?utf-8?B?V3dzcG1HejErcFg4Y1VISEVFYWR5T01zT2I3S2Z5MUJDZ1pTckNBQ213UEc1?=
 =?utf-8?Q?euA4j4W/DjiCSP4ti8NJw8STY4r1na9k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4696.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlJvaGpyQ2tCTE1VMDZacWp0MGQ4MzNiQmVMaXdZZDdkdVNZYUN4eGR4ZGsv?=
 =?utf-8?B?Q214bHhuUTE2OVJVYTJuZWY4R3c5S2xXZ29DQ2Z3ZjhCMFdBYlpJd25GVnBE?=
 =?utf-8?B?Rm13Z3J5MHBVVUMwNWNYSVRrbDAydnFhRTQ4b3pvb2VWN0FqR3pJNjl2M2d6?=
 =?utf-8?B?UStsbTFlbzYyQWxPZjFuUU5ETCtlYzFWR0hSUElpUlV6RU90clNUam5TV0ZE?=
 =?utf-8?B?UEtyK1JjUHdrbVRxVG02VGxTaEY5MVM3MzFXSlh2cmVXSi9RSTZobDJjUGJm?=
 =?utf-8?B?bDU3Ty9rYk43TGFnT2RPbTJQWmlIVkd2Z0RaUWpNQ1c1SWNPb3U5L0cvK1JG?=
 =?utf-8?B?OHlwS042cFVVQUpmaGhEL2cvc1c1VUErMURpdEs4VG9VMEh5S2VpMnVjYXVV?=
 =?utf-8?B?K1MwOTFSZ3RRSDk5UUJYZlhiemdvMzU5S2wvZ01TMXNPdmpPTVNHRitMcy9F?=
 =?utf-8?B?aFJXTU9WNXRDV1BSQm1sMVE2YlZUa2t1dG44QnR6ZzNhS3BiYlBkMUY2TEtY?=
 =?utf-8?B?T0E4a2VNcVVaa0Z3akhDZ20xTEh2Z2VmY0VMZGluQTU2RjA5Z21HN29TMUY5?=
 =?utf-8?B?TEZNWGJVaU1tZkhoN2JlODFRK0RXS0M1WHRmTXdTRDBzcWhrUThjbXUvSVVV?=
 =?utf-8?B?b3U0eDBGZjdEVVdydHJXazRhRlpOdVhCeHhQZTBqNFM0TEh0b2JaQk9jQWhI?=
 =?utf-8?B?cHFUenIvb1VxRms4UWhwbVpHOS9hQ3p6TCsxU3haL0lKZ09kZzMyZlJwRFpP?=
 =?utf-8?B?ZFppbnZaeDJVWnQzTG9IVWhHSUVaTklmNXhONEt4OEVWN2RHM050Um43enpC?=
 =?utf-8?B?THNGbTZGSkw2WkRHb2ZJVVRCMWtqWVZQMWFPUkRKZDltZnB6enVYQ3dKZStW?=
 =?utf-8?B?RlVlb1RqaitsUS9hTTJzcnRmZEhLdWR6Z3dNbGJ2RFlnbmhRNjllUTdWaE9v?=
 =?utf-8?B?UkFvcjN6bXlaa0thWXN5SjFBelZOMk1MZE9uY01GQzYxbzd6RkZZejZVSk4v?=
 =?utf-8?B?eEVpaFEyQW1sN3MxVitqdm5HMnpCejdkejBDSGJrdTZaTWlJaGVkMlNjZ3FZ?=
 =?utf-8?B?SmRrN1RXRXU4dnorVlg0OUsrcTFzQnRKV3hpVmMyWHJHWUU4UTg3VXdOU0hV?=
 =?utf-8?B?SGdwRUhOd2h5SW5yeHJCL3JZZm1lRWQvYVI3R0x1ZnRjSS8zbmkwM1RDQ0I2?=
 =?utf-8?B?eWVMcUwzdy9CSTN3Ky8yNkZDN0JVcGJYTm82NTdrV21OYUpza0ZwSm5HMmxR?=
 =?utf-8?B?aXRNa2RsbDRpWGl0aktUZGI5N3hSWlBzUitoS0tnaVI2RytsMmVnU0ErQVl4?=
 =?utf-8?B?WC9HUzgwSXhKVDZNM1RRNDAzbWJ6V1hwMFZoUjRGZENaeksvaXZhRXkzQVZX?=
 =?utf-8?B?T3FrYUFiaTBkaUtjNzNrZy9wekJaVnZaQ1o1OE9keWRjOWdpZmdJUGlkNmt4?=
 =?utf-8?B?cjdxZXQ0QVRTd1VHK2g1bVo1L3duR1QzQjZZNXpXT0N5aWdJaGNtQVl1MXVF?=
 =?utf-8?B?WGpaSFZHdjBjK29hTTZYNFFvMjhqWFR2VmxnZ0wrQUlhbUgxMjY0L1BmQVd2?=
 =?utf-8?B?UElaSTVaZTJDVzVjbS85aVFyNnNoalo0S0JGcUcwZFBLWDM5cnRDVjYxMjdF?=
 =?utf-8?B?WEt0bkFqeEdzVFVmNTF5U2V3R0cyMWdJU0pKall2OFJ5UG5QdEQ2dEovcXQ5?=
 =?utf-8?B?eU41aXZ2SUR6SG9jZVpiL1BPcSttZkFPRDRjQUppWmxNejVQY2l3YU1NQjgw?=
 =?utf-8?B?QXhzVVM2K2Z4TDY4aHhsU21FRUxTWjV5Wkh6TXFCRkVGSHlEb1N6cVRpNHdK?=
 =?utf-8?B?KytCNDdka2o1Unh6OCtlRFFjdndpTTlRbTdaT3JicUtpZVZubVo0MDNkM0FR?=
 =?utf-8?B?TFNLMDNGQmlqVlVoK1NWdUdBTTZEQmpLNTMrd09nNUlOdVNVK2R0Y0M1ekI2?=
 =?utf-8?B?L3NkWGptN042WWFWck55cUcrS1J0L3E3ejRwSkxObkRSenZaMEI1ZjR2WDRC?=
 =?utf-8?B?dkdiM2s2cFVsM1RuWUZqZXdQRHVnbU92L3FoWHhVam40ZUNwNDlXU0U0eHMx?=
 =?utf-8?B?bTZYTlRqVlc3dWJuYjNvVkZLa0pObG01V1ViUXNvZ205ZlN3dFVIVmx4cWxI?=
 =?utf-8?Q?coUC1J0XE9DACYy7NMiNetQS8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5208B97AE852394180B692E446728900@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ca.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4696.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028ae36b-c560-4b5c-09ee-08dd40e113dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 03:49:20.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DarfsOgSengHQ+5MfkhrABB++0s41XcwPlcAQhJF71A6uZp3rqh+M25aehl1jfi7cLTljGiTpfx5Xx1kgCwOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6510
X-Proofpoint-GUID: CHoAgMELx6eRbHAKvEXv6hJdICSZbPbA
X-Proofpoint-ORIG-GUID: CHoAgMELx6eRbHAKvEXv6hJdICSZbPbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=902 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300024

SGksIHdlIGhhdmUgbm90aWNlZCBhIGNoYW5nZSBpbiBiZWhhdmlvdXIgd2l0aCBjb21taXQgM2Y3
NjNkZGYyOGQyOGZlNjM5NjM5OTE1MTNjOGRiNDA0NWVhYmFkYy4NCiANCkhlcmXigJlzIHRoZSBz
dGVwcyB0byByZXByb2R1Y2U6DQogDQpta2RpciBnaXQtdGVzdC1kaXINCmNkIGdpdC10ZXN0LWRp
cg0KZ2l0IGluaXQgLS1iYXJlDQpnaXQgcmVtb3RlIGFkZCBvcmlnaW4gLS0gaHR0cHM6Ly9naXRo
dWIuY29tL2dvbGFuZy9nbw0KZ2l0IC1jIHByb3RvY29sLnZlcnNpb249MiBmZXRjaCAtZiAtLWRl
cHRoPTEgb3JpZ2luIDE2YWZhNmE3NDBmYWM3NDQyZTk0ZGNkMmVjNWVhNGE0ODUzZTQ1ZGM6cmVm
cy9kdW1teQ0KZ2l0IC1jIGxvZy5zaG93c2lnbmF0dXJlPWZhbHNlIGxvZyAtLW5vLWRlY29yYXRl
IC1uMSAtLWZvcm1hdD0iZm9ybWF0OiVIICVjdCAlRCIgMTZhZmE2YTc0MGZhYzc0NDJlOTRkY2Qy
ZWM1ZWE0YTQ4NTNlNDVkYyAtLQ0KIA0KIyBFeHBlY3RlZDoNCiMgMTZhZmE2YTc0MGZhYzc0NDJl
OTRkY2QyZWM1ZWE0YTQ4NTNlNDVkYyAxNzM0MTA4NzMwIGdyYWZ0ZWQsIHRhZzogZ28xLjI0cmMx
LCByZWZzL2R1bW15DQogDQojIFRhZ3MgYXJlIG5vdCBmZXRjaCB3aGVuIHVzaW5nIDIuNDguMToN
CiMgMTZhZmE2YTc0MGZhYzc0NDJlOTRkY2QyZWM1ZWE0YTQ4NTNlNDVkYyAxNzM0MTA4NzMwIGdy
YWZ0ZWQNCiANCi0tLQ0KIA0KZ2l0IGJpc2VjdCByZXZlYWxlZCAzZjc2M2RkZjI4ZDI4ZmU2Mzk2
Mzk5MTUxM2M4ZGI0MDQ1ZWFiYWRjIGFzIHRoZSBjdWxwcml0Og0KIA0KY29tbWl0IDNmNzYzZGRm
MjhkMjhmZTYzOTYzOTkxNTEzYzhkYjQwNDVlYWJhZGMNCkF1dGhvcjogQmVuY2UgRmVyZGluYW5k
eQ0KRGF0ZTogICBGcmkgTm92IDIyIDEzOjI4OjUwIDIwMjQgKzAxMDANCiANCiAgICBmZXRjaDog
c2V0IHJlbW90ZS9IRUFEIGlmIGl0IGRvZXMgbm90IGV4aXN0DQogDQogICAgV2hlbiBjbG9uaW5n
IGEgcmVwb3NpdG9yeSByZW1vdGUvSEVBRCBpcyBjcmVhdGVkLCBidXQgd2hlbiB0aGUgdXNlcg0K
ICAgIGNyZWF0ZXMgYSByZXBvc2l0b3J5IHdpdGggZ2l0IGluaXQsIGFuZCBsYXRlciBhZGRzIGEg
cmVtb3RlLCByZW1vdGUvSEVBRA0KICAgIGlzIG9ubHkgY3JlYXRlZCBpZiB0aGUgdXNlciBleHBs
aWNpdGx5IHJ1bnMgYSB2YXJpYW50IG9mICJyZW1vdGUNCiAgICBzZXQtaGVhZCIuIEF0dGVtcHQg
dG8gc2V0IHJlbW90ZS9IRUFEIGR1cmluZyBmZXRjaCwgaWYgdGhlIHVzZXIgZG9lcyBub3QNCiAg
ICBoYXZlIGl0IGFscmVhZHkgc2V0LiBTaWxlbnRseSBpZ25vcmUgYW55IGVycm9ycy4NCiANCiAg
ICBTaWduZWQtb2ZmLWJ5OiBCZW5jZSBGZXJkaW5hbmR5IGJlbmNlQGZlcmRpbmFuZHkuY29tDQog
ICAgU2lnbmVkLW9mZi1ieTogSnVuaW8gQyBIYW1hbm8gZ2l0c3RlckBwb2JveC5jb20NCiANCiAN
CklzIHRoaXMgaW50ZW5kZWQ/DQogDQpUaGlzIHdhcyBpbml0aWFsbHkgcmVwb3J0ZWQgdW5kZXIg
aHR0cHM6Ly9naXRodWIuY29tL3pvcGVuY29tbXVuaXR5L2dpdHBvcnQvaXNzdWVzLzE0Ni4NCg0K
