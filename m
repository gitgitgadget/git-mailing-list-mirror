Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EB1C8788
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016112; cv=fail; b=YlQdVfT5s1S2vEixBVPglqV8bIuyVpxnJpzRxymVKhu73fhMnFjEFyk3tzavDDfj0eL2ZoobWjqbghHUVDR1Rqqf1By6vA+Irv0Ac7wh9oTv416TcA1mJmioPF6rqso/9sTfc/HnVmwxEV071hk+tFLQy9hy9wRsPysBrCoNlJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016112; c=relaxed/simple;
	bh=hjZXbmsHbaLrTWowZDXOBNY6HR/SELS1fQNr11rHj4Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n6FhSAGBz7tdS9yuxW2D7dLxF7skP86bRV/2xEQsLPeswDnpHIdplszdx/aWnvng0SV0j021+quqsj9s2PM5Xl2R8usewt+pgsqYi7f4kmc3Hsms8WSvXIu1NdaPlov1/YQ6D39fcPM3RsoPt687PMVUhtuF0eYpMZ/QBT3WgJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A0T2w8UN; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A0T2w8UN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AINMLTr023438
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=hjZXbmsHbaLrTWowZ
	DXOBNY6HR/SELS1fQNr11rHj4Y=; b=A0T2w8UNAa46qjeDd33Mm+lpVpTugWLZX
	6LAcZW+ntVrFEOG6GZlAaLxXAOMpYGhZJoU1ySpslEy/pFQAH0UXYZ2EtIcg8vwX
	FW6DiaDyTy8XXwebCDzBpZE7TDOGXz2cA1VRr5vbautte5vDtHpYRR3jfLzVzsxV
	bZnmxWrruEBlvaRUAXgNms56W/0DbTNh7ecF8WqT5kPKRK6czPO9eH1xIOLA3tEy
	sVMYUl6UyScc1CTzGRUHXmtgjSyYZAotFvN+S+RpFjdgOpQCALwC4sTtTfMm52Di
	ZHngBPDUx+b0k7Bk0y4LFcFEzam65rlwdjI6RAvFztcZ8ZMFLVCQQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjpt4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:35:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mjtm79WlA+MocgmHnIq3GXj8TAtGqjYubZVWtbU1KQI6DARd530fnLKPlOoKyP/kX8gl3+7xE/A8owbzgdk21ovvHg+mQu35G2SSPjdzSy26JtjRyvP9kgD7LkUjHYYTWoobdATNnPUFbNWKbcn1OkltUK3Oo1sRVDRug8t0l5WXlEANhK6vQLDwLHG0r1WNA9+w90IsyRm9st920kCI9hW9wBjqeJiFhdkYBS1SUkShkZhZLXyYdyIq7i/B1rQLyzGzUNctJK3dtPBSxOh0x4+SHC2bzWQbvoAx4LxfgCkPMF3WY0TqyKHSamDxn0MvRqelkHpopnP3P3I4Lv3F1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjZXbmsHbaLrTWowZDXOBNY6HR/SELS1fQNr11rHj4Y=;
 b=VxJCvTKg74/T7XVfBmeq8f4nhoIn6oLt8RSSGArD+lFnCFmDe9iAcZnD9sL6S4vPw6aRgftrLyivlfPczkZ0mql5ORhymPYepUx2kHYk5iZ6fqBrU/PHbEjh7TmovBhOYUU8fKNbA7Ev2ub1LzdziDuQm09Z+vk1QxO3dlACBkW4v8a4wAzQbATxc+vVFoCrJHim8iJhSVKcSkFAMSAJXAkkVdj+NrWQlFm71fc33lSLh9G6A9TOiP7A9z9U4ubRfSs+USXY+DM4Ws8ve0Ba2GZB1gJNHiKDV2s85WxK7Ri83qL9WPzmEmaTPBsHEGygT1XzLnTkPfXVsNapvFFKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5446.namprd15.prod.outlook.com (2603:10b6:8:ca::7) by
 CO1PR15MB4988.namprd15.prod.outlook.com (2603:10b6:303:e7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Tue, 19 Nov 2024 11:35:07 +0000
Received: from DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52]) by DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 11:35:07 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Inquiry on Onboarding a z/OS Machine to Git Community CI/CD Pipeline
Thread-Topic: Inquiry on Onboarding a z/OS Machine to Git Community CI/CD
 Pipeline
Thread-Index: AQHbOncVptGUB9QRA0SyoZHAWTDWlA==
Date: Tue, 19 Nov 2024 11:35:07 +0000
Message-ID: <898B3E90-1703-419D-A5FA-8BE9557744E5@ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5446:EE_|CO1PR15MB4988:EE_
x-ms-office365-filtering-correlation-id: bc3fe392-2cd5-4976-a5d8-08dd088e37d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGdIUFNndGlyemRNOHRkTEQrb0tGMGxhOHB4clh2bkNHSk1BNVZjaXZVT2RM?=
 =?utf-8?B?Qkl0UFRZS3BOaFRDRXgyRGdFbFE4ckd4bmtoRk9VVDB5Q2lpSWdtbFJpNUYz?=
 =?utf-8?B?U25zSHMzZ0s4bVkwS0R5UFlQQXFqY29xb3ZiWHNEYTQvV2RtRnlzZ3dDZXBs?=
 =?utf-8?B?OWRFZmtvOUQwSUJDd1lvdlFNbThCSklVUGRJc0QwZzhNa2p4NGpLenppOFIz?=
 =?utf-8?B?allzQUJheFlmZDVTZmMwYWJIMzFOQlhrdmx0L1dIcVFNbXhES0VKdzlEMUJW?=
 =?utf-8?B?YXFyKzUwdHk2cUIvSnk0M3g1MDMrb1EycTBMdk5aS0w0d3lEUFZBOTJFanUv?=
 =?utf-8?B?aW1od09JQlc5OE5leXdzUDhQektNaTM5ek0wb3ByNU1sVzdGYzVFN2Y2K2ty?=
 =?utf-8?B?TmkzRkdsZlQ5VlBpUjdwendRR3JSR3g3V2ZvdXJtRTE2TXM2MnJheGhaTmtT?=
 =?utf-8?B?WWIrRXhVK1lZUkJYSWgxdkI1bEJ2aFF5cytMZml4bUFzdnoxNFpQZUV1YVFh?=
 =?utf-8?B?TjdQbmk2ak1ZSlhQUnE3RmluMUJSNys3d2RSK2dDUVlCaHk4dWhEVnJtRWV0?=
 =?utf-8?B?aDkzc0s4K2lSY3pDK1QzdjJwRjlaMnZvdGRhNmdNTlhCanFJSVNLbWN4MlRG?=
 =?utf-8?B?eFVmK2txUXRRSlM5YmgxWGxhdnNqbWlRNFpvbDB1YVZtaXRCci9WRVpudUZr?=
 =?utf-8?B?QjlKZ0ZVamdFL1RqNEFxc2RzdXpyZGV4bDBjU1RyTDdWOUE0SFA1bndFdHVC?=
 =?utf-8?B?eWhlZE9WZkpLdlJmc2lRUXNrcWI1Z3Vyay9hVmo4YTd5WWUwbmlIMlVaYTgx?=
 =?utf-8?B?MlBaNGQ3UzdUcEllL3N3MjI1Q0ZEVU9TQjY3V2gxY3U0dkhVTzZuby9BUG5I?=
 =?utf-8?B?WUZWV2pFaXBhMjRwTEJESFdJY3JEVVl6Yk5CY1g1T0h2WFJ4V1VBbzZONFNE?=
 =?utf-8?B?aHd2a29qbHVkUzA0YzBjT08zOEdqVlc3TVhlWEgzUmlDdEpPblplcGMyWDNx?=
 =?utf-8?B?SW0vdVBEWWZyK0Z5dnJYZC9xMHVCdm9MV3hDMlgwR1JESWJ1c0R1TEFsQlpw?=
 =?utf-8?B?RUJYd0x4U2RuNkp5NXNTTEFiU0puVmhmZlloU1RHU0V4c1NkRWxrN2N6cDFH?=
 =?utf-8?B?NFRwaU9wNDR3WFZBM3Y1aXhkVE1mbW9keHFadFFjTkgxTFIxRStGbUh5MG8r?=
 =?utf-8?B?UDhKdFBCUTlQWHF5Rk5wS0N2d1NBeFhOVS9YUVB0WDIxMnFjY0x2REd1Yk16?=
 =?utf-8?B?bXUxUjQveWwzeVUvd1FYanRaWVcvSnVVYzBHVlZ0TkU2R3ArTXUrQTZSQUw0?=
 =?utf-8?B?enlIdzJmZGJudFBkemZhRWsxODFodHNiQmJpTHdZV3JmODBuQmk4Sk1IY1Qr?=
 =?utf-8?B?NmsyVUhla1J6Rm5RZ2RTQU5OWXZNRWNpTXNqNnA3Z09YWHZOcjBlOFRZK0FK?=
 =?utf-8?B?OG9WMWsxNzVlbTVka0R3ODdxK1pXMUR0RmcvUTZKanBBK0N3QzNRcFVhM3ZN?=
 =?utf-8?B?V2lEMkl6YWdvd29NN21JODlyT3RBZm5KanZWdm9scGhBQmFrM3dHOEI5YmNr?=
 =?utf-8?B?YzYwaFplMFVHTms4L2k5dUdVcUt0WHdZbVlEU3lhNHNNNTU2WVVHUkhwUGZ0?=
 =?utf-8?B?ZFVVM0tKNDBkbVNLblRwNVphdW4wSG5WOEgzN0c5TGtVNmdRSG5LUFZwcE5q?=
 =?utf-8?B?YmQwZVBVSU82M0VDb0pzcmk5NWEwTXRLSGlRUXNEcUIyVmNBSm9iS2RkSUNT?=
 =?utf-8?B?QUVXL2dtQzZJekR2eWRUVU5Xa2ZhUmw0ZHpyemNlQnBEOXBHcWZQL1did0Z6?=
 =?utf-8?B?RUNUT1d6MWgzTno3amVVeklUc1JFNVVNT1JmZDBCOStwNFhoTFpkVzQ4Ymxz?=
 =?utf-8?B?K0tScUR5MXRja29QcnBRQjJHRlpaekFHUzlwdktvTkxIQWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5446.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHVLRDE0OFBzam9IUDZEWG5UNjdiQTFUOGRrc3Vhd0FDeVR4ZER2QTA3MEtF?=
 =?utf-8?B?MyttTElVc3V3MzVQZ3BEYk5wWlpYdzdCUWRmQmQrbmJqZitsK1RKbDFrUEg4?=
 =?utf-8?B?ZENQcXdjYTNEN2RncDN4Q2tXYzhzd2oyY1dCU1BtZjFWaW5tTWk3eTFUSlVh?=
 =?utf-8?B?Qng4YjNvNmN1UG41OUlkOXNBNWZ5V1pWaHczeGhvTFFnRlJDSjVZeG9zSGRq?=
 =?utf-8?B?RzN2c2UvY2hlRDZjRFh0TmZzbWpnVUNQT3NNdmV6MFVBVXNaWGtNMEdnemxO?=
 =?utf-8?B?YTJRZEVBQXptSzZIUW9CSGpLc0pBdUJvSXBLbDROUVhwUGpRUGFnakNOa2ls?=
 =?utf-8?B?ZW9KT1JHUTJjUHZaN3VuckVPeUNSZG9JYXIzTnIvNjhsdjhPVE5DN3lsd3dj?=
 =?utf-8?B?UlpEdDNUT3oxZHVNLzVIckRFWlQrd29jV25ONlNkQzR0T0tLMkpxUjVCNGhp?=
 =?utf-8?B?dkl6Sk1nVmExdEtWVFZiK1lnRE5jRG5OQktmYVpWc0lWSEVpTFJSUDI0bDdC?=
 =?utf-8?B?blNYRlRPSlVMUU5MZ1FleXh1eFcxbnFWNDI0eCtTbExHMTJFRGdpdENTMlJv?=
 =?utf-8?B?ZnJJZGpuSVdpVmM5MCtNT1NNUzNZdHN0cHNYVloydGMvbkVsbk9lUk9TRE9H?=
 =?utf-8?B?NHdKeVpFTE1JMDFzWXRKUEpjeG9CRytkVHRlVE5YVFZjVEgwN1pKZ1JDbktt?=
 =?utf-8?B?cHY2bnc2dFUrV1pNbE5UMlhlUUJsV2JHTExrMFFDWnRYQUV3NXdReHYyZWpo?=
 =?utf-8?B?MjVSOVlCNHN2VWljVkI3RVZueERZeGVVaFRIZDZQVVNaK0xGdjV2anBrN3NW?=
 =?utf-8?B?U3d4NGVjZmk2T1RiUTQ2NndHS3ZyRk1qYmdJNkVtSkFxbmlvZHV6QU10S1Nv?=
 =?utf-8?B?UVdVWDlGNldqbWIwRzdrcjlTZk0wYm9OaCtObTJCek5tZ05GSU94TERpQVJJ?=
 =?utf-8?B?RVVkM3M4R2kvYzlxdm9HWDdRa2JaVmtOMVF0ZzN0dndNcE9mdjg2L2plOVZO?=
 =?utf-8?B?U0d6MFlicTNYWnVOTlVoMDRRdFMvUXd6Sm9yVXZDRCtyZ1dQaHRmRElWLzJm?=
 =?utf-8?B?UEJiaFArL3MwVlpVcllpQVdyQytRUFNJUmpxYVhrdWZzRjFOVUpiN1d5SXlF?=
 =?utf-8?B?RlZjaFhGbEZIUWZlNEc5TjNFODNJNXQ1SThLRmdYSmthZm5RUjYzWEtmaDlM?=
 =?utf-8?B?ZmVHNG54Y0szblRad3Erd1FHNUFyZWNIQ2o4MFdxQXF5aDFCQzhvM3dJTThB?=
 =?utf-8?B?Y1RVeEpmb0JFUkJsWVprTzJEc2ViN29haFRuVzJRdjRLemZKbzRMejJmZDlU?=
 =?utf-8?B?bmd3ejRMVXRFY0RHWElRN2l1YVRlS05wcHlxWGJsekZ6NHZsUGt6NVhSZTIx?=
 =?utf-8?B?eVRZd3BCTEpueTJZUFhQdUQ1a08wQU1NK3ZkakQ1MUNJbmY3WDJhbUNTTDIw?=
 =?utf-8?B?Tm8zRUVXN0RuOE1oSjQ4Y3FDN2NVY1pqZHNYdlRmb2grcGV0RlVJRmtqM1RL?=
 =?utf-8?B?Zm4reGNncVR6MDRmdFI4d2hwc01TT1lJZVpxSGJkRFAxZldFNTBzV1FsTUZ6?=
 =?utf-8?B?NFZwWlloRDhwUDFTMXcyZXNDK2lkTDBiaURZYUR6S2VxcEZLRU81aWZrcVl4?=
 =?utf-8?B?YkppeVc0ODB0UUdnRWZkQ25yemJ6QnE5UU1xZzdCZDFPblM5WGYyZithOUtJ?=
 =?utf-8?B?SE9aYU1YR2NGT2lBR2R2NDhnY1dUSTN1R0VsRk5MRExnaEU3OHl6bCtXNURL?=
 =?utf-8?B?eXNZTGw3THZjZkg3cmZqZHRpWllXdU83dm9pa0lUT0FBRmJ5L0Rrd2l3cks3?=
 =?utf-8?B?amU4YTJWM2VOZlJNNDc2QUkvT0c0djJ1MXI5SWw1OGZtQ2tGd2kraG1SVytM?=
 =?utf-8?B?OUFJZENOdkU3dlVqajVaR1FpMk12dUlucndCTHZVcmExeGU5bmpqRmkxbkJO?=
 =?utf-8?B?Qy9FOFpNY0JQUFJFczVFanJZV0RIUTc4dEpMd2gxanFMQ1VpcjdyT3pDTnJ3?=
 =?utf-8?B?TUordTBLY3pmeE4vU2I3Y1p3dkNmYWhub0x5WDJKQ25TVUkwczRZR0g0TkRX?=
 =?utf-8?B?b3FPK1lxSTdaczJ2TmJiKzNOLy8vZ01LbHZOTHB1dmM0RGtvM1l3SUdET2d6?=
 =?utf-8?B?QzhzMGpLY1IrZW5IcnFvQXFkQWgrWXo3N0p4SUVwR1ZuTWw1cHRlNk5YcDNu?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFBC9AB8DC5B464788B85BA463005867@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5446.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3fe392-2cd5-4976-a5d8-08dd088e37d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 11:35:07.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvakjgV01w02yPlV/bIeghvLMeHVUp4m3HxxWeMQsTL73T7TLV/87Uuz7u/92iyLSN55T20cNDq2+sysWBVKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4988
X-Proofpoint-ORIG-GUID: Io_jJbheGXxDBJyAXZFO_lwklQjWpU1a
X-Proofpoint-GUID: Io_jJbheGXxDBJyAXZFO_lwklQjWpU1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=710
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190083
Message-ID: <20241119113507.F5kMTDo0DIDcCmftHHSjjqa_jW8XMMN9LI_htH6fj_4@z>

SGkgVGVhbSwNCg0KQXMgd2UgYXJlIHdvcmtpbmcgb24gZW5hYmxpbmcgR2l0IG9uIHRoZSB6L09T
IHBsYXRmb3JtLCBhbmQgd2UgYmVsaWV2ZSBpbnRlZ3JhdGluZyBhIHovT1MgbWFjaGluZSBpbnRv
IHRoZSBHaXQgY29tbXVuaXR5J3MgQ0kvQ0QgcGlwZWxpbmUgY291bGQgYmUgdmFsdWFibGUgZm9y
IHRlc3RpbmcgYW5kIHZhbGlkYXRpb24uDQoNCkNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBndWlk
YW5jZSBvbiBob3cgdG8gcHJvY2VlZCB3aXRoIG9uYm9hcmRpbmcgYSB6L09TIHN5c3RlbSBhcyBw
YXJ0IG9mIHRoZSBjb21tdW5pdHkncyBDSS9DRCBwaXBlbGluZT8gV2Ugd291bGQgYXBwcmVjaWF0
ZSBhbnkgaW5mb3JtYXRpb24gb24gdGhlIHRlY2huaWNhbCByZXF1aXJlbWVudHMgYW5kIG5lY2Vz
c2FyeSBzdGVwcyBmb3IgdGhpcyBpbnRlZ3JhdGlvbi4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGFz
c2lzdGFuY2UuDQoNCkJlc3QgcmVnYXJkcywNCkhhcml0aGENCg0KDQo=
