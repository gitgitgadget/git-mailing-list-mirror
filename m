Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EA4A1A
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798161; cv=fail; b=atiapTq5zm8Rxgr/1EXYtos4uP8xAFk8WypNFyo79fsQf47yASk/GIXgyI7pQVD0F73bYVo3W3+l/Fi8WXtbB4jA4LfdLBrzuGnNaKCZgxxsu+VBI0/Wa72OErG59yHoZ/JP1RCldPOteUQHvG31KP+6yuXeQVANH8GMyadcFwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798161; c=relaxed/simple;
	bh=Jb9OS8r4MB9360h0sF7/WyX74d0etaGuc029WGU8BBQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X+MzS6I9oo1RszbvVvjnOIO7XJwJNoEk4L4h1E6CVuF0Hm4bkJLY0KhwvzI+lER7OYAJSHu5+H+kQrx4Cp+/o1GgVi1TKu7XGc08icIgYSexU32o8clCGNTcf+06aEBxMmc4rwo7nJ9Po/AxFQhC2loMIq3f40/L/z2Ebr01Vjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=muoeidfY; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="muoeidfY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O4cfFI029276
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:subject:date:message-id:content-type:content-id
	:content-transfer-encoding:mime-version; s=pp1; bh=Jb9OS8r4MB936
	0h0sF7/WyX74d0etaGuc029WGU8BBQ=; b=muoeidfYmhWED3EMJ9Y9FLGKk+wXE
	WRfjJrZBHIx6Rb4w27X7zjf6mf/AtVfndiYkZak6+i3bRMy94r/YgBGGWQPSgL33
	/gH0Hsl5OBZ/YVgG8NeE3eIhKHgmlKh8I5MUrzhCJ/2RQ4fqMeDKIdLxAAo++OZP
	R554PNWDr6XcrDreXbkpCCWfxH8W6cizuf38e1cGuEsCrt5Sf+KR2rCgdLInNRIU
	i2HXNX3vWQbl33nJPp4pH28v5Pje7s4uzn3GZl9RR6NkxbOBm/AQ74y5Mnghw73b
	sLK+cm3HffjnlKrZ/E6qTHCJALRP/Bu/3jes0uI6BC33GykngXmyDJ7EQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jq3ngeaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 05:15:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixtQ0HG1X8vkO1cAb9g8Um0QfWiERsrqQ7i3nFsfZa4GOoepKFDuE9nUTuT3LPrD9c34n6edQIlSVIEhWbnubCw+5cCOsPiM7/tmvPbkmW64kj661SvsAYN4h0wDs3Apyrtlj+77TObNSP5UwK90IEvZ0LuqUSkTltI53qeqlRe9UmM5I0HdHqR3Fv+h/I6x2XEk16B6kHorGJ/F3ShbXDqJPIsOpsWLvV4tKqaV5rn05oTwZGtEm0lri7n55asIjRRa1yEkSUsWIYvD34A55cvErQOwENl3xO6aJRucdy3DfZ9QNAh4K0tWgr8aosQr1FaM5uSQOE8MTTjCau95Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb9OS8r4MB9360h0sF7/WyX74d0etaGuc029WGU8BBQ=;
 b=SqZ2iT3osaVtLeSeqQrKu05F1c0joqlh6Nke511LtbhdMmiPvKJle+rqEYQSwlXysilEOfb8uTksaQD5VJs28nGRnj/+4GTy67A1GYmQ9To6IFu7qt3jPo5aKLdTTDubwdKxj3HfQxPXtjrA6qtBD+zwI3CkYtM20j4zvA2nfUHQXqc7by6eI60MFx/FRptEPrFcXRYOyLZp5t6drgZc95Mdxcy5lVHeMUpPVKESUrOpf/C28xVUs8M+FRtXte4UBVlZ46ewh/QgLi1z2pzkzoIw2BkQQ2ztdoWDFO+69HkFvYbXjaYmTL5HN6WY/fJ5h6G0MnikKz7e0YvG56SJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from DS0PR15MB5446.namprd15.prod.outlook.com (2603:10b6:8:ca::7) by
 SJ2PR15MB5718.namprd15.prod.outlook.com (2603:10b6:a03:4c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Wed, 24 Jul 2024 05:15:55 +0000
Received: from DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52]) by DS0PR15MB5446.namprd15.prod.outlook.com
 ([fe80::ec1a:c9b6:44dc:bf52%5]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 05:15:55 +0000
From: Haritha D <Harithamma.D@ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Build: support - Fix to avoid high memory footprint
Thread-Topic: Build: support - Fix to avoid high memory footprint
Thread-Index: AQHa3YiPz6A9PWPqc0Wbjk9P7rvM6g==
Date: Wed, 24 Jul 2024 05:15:55 +0000
Message-ID: <194BFBB9-FCF0-43F7-BFC2-B055351B5376@ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5446:EE_|SJ2PR15MB5718:EE_
x-ms-office365-filtering-correlation-id: b648a08a-956e-4f69-7d6f-08dcab9fb1e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dU8rYzRwa1p2YitmVjk4aWJIQUgzRzEyeFFyZVVtNU9Va045Y2YyOTl2THBv?=
 =?utf-8?B?d2FPalA0dHA2ZTJPQTVlUUd6Yy9wTHZYNTFVNWI1QkJzSWw0SndkbUdRNGpO?=
 =?utf-8?B?enF5dTFYRUtGRjh4SkVLRmYySllwMzgzbXZYRFM1b1ZzRjVZMUtnZmtPL1R4?=
 =?utf-8?B?R1h3VXJGV0UwZlVwYWE4TjFyeVFjOXlVMjhDUEk1QVFtYjFpRXZtV1FubXBW?=
 =?utf-8?B?elM2WUdtdldlbWcwWm51K2ZxNTBmUEF0TjJZT3FmNVR1ZWEwNCtoSXNXL2tV?=
 =?utf-8?B?RjdGc1A5Mjl4bVliQUV0YVRWa3lHL2ZLTVRkK0RadXBMYmttdlllaXhnbjJu?=
 =?utf-8?B?QTh1WnY3aDBxR3htZUxHRGpVMXVvSFJpUklCeGt2VVJjSXB0ZHd2QXY5RXlD?=
 =?utf-8?B?UEg2V3NhWDJxQWpXd3dPSTJGTHNNMEpjRzFYQU9DaURYUHB2NUdDZjZDbXRr?=
 =?utf-8?B?dVdpVWFsNXpKbTZsZUMxT0VEdUE0a2FUU3FHTmpJMnpDVTJPZk5wc3lvcnBC?=
 =?utf-8?B?UWVpZDJSdmp2dkR4WUNZcnVrY002YUVVMHZmbGVJdktQNjZVVUFpQXJaY0Ew?=
 =?utf-8?B?M1BlYyswNnQ5WDZVSWZscXFFWGVoVWlHM3pYVTdkeURPMG0zWGxpc0YrZkYv?=
 =?utf-8?B?aXVDd05keVZmV0NQSXQ0UWI1N3A1Y3hBNjlQdVZvWjV1S1lVMnN1UVh6eFo2?=
 =?utf-8?B?MzJtcThNYWprRzhTQkZUQk1oUGRGeTRHdWRVUjlaMkJVbDFoRmF1NnMvcEhv?=
 =?utf-8?B?MTVjdTcwMFFiSGJTL0p2d2pqTnU0VHFLVEs5bStsNUMzWnlhTXZHSWcweFFM?=
 =?utf-8?B?ZE9SNDVzN1QwTVdvc0g2UUN1TVhkTlNYSHFHY0NjT05qUkRtNzhHU2d6dTRh?=
 =?utf-8?B?TEU1QTA5YjB0RG1FT1VVQjR5U2NQUVdyZmRwUjhyVGVkL29kSFZtU0hvcEpR?=
 =?utf-8?B?MTV3UFlUalJ6V0Vsdk41cHY5Z0t2VktNYk9pWWljaWRLYktJSE9pV3c2bG9T?=
 =?utf-8?B?WlRHdk1WY1ZOUWU3eDlEaFQ5QmJmUTZpOE9IZkFoSE1hTlRLeFhaOGtpTkZa?=
 =?utf-8?B?MCt4bFgxZ0N6SzZvbUcybW9ZaW5xWGhTUjBlY2o1a3pFdytRTHYwaFdZZThG?=
 =?utf-8?B?ZklVTGZXWTRuZGJtRVVIYWZhUlphYjloQURUVnFwRzQ4ZkJDb0QzczJvekg5?=
 =?utf-8?B?TWN2Y2VSZDU5Yi9OMXRyWCtJdzJiRlViemZJazNoUEVPVkdVeG45aVpKcWtx?=
 =?utf-8?B?djdHOCt5NmxEblBuc2tuaDBMUDhCZzk5b3N0ekoydmRsUElrVGE5czU4T2la?=
 =?utf-8?B?Vlp2bmJDMXlPQko3WGJGM2t6YTg4d1ZFQTFPMmhyQmhITUtiZlpzb2xuaXdi?=
 =?utf-8?B?VVVHVjMxWnhHZ0g1VjJ0SnhpNmJmUnN1b29XRjhQNWFMUUN2WWpSemlzZFYz?=
 =?utf-8?B?MjlCanRRUjZ3aTZGR0NSNmlEdmJpTlJLY0FIYjgyMlNzRFh4Q0E1VjVwejFZ?=
 =?utf-8?B?M3pzZHM1Q08veFprRzVUb2lVQ0tWc0xROGVlc3hLWWhlRXZvZTFRVXpSUm1l?=
 =?utf-8?B?MXBtaDN6cURONUM2ZEdzWTlJOURHbEx6NnJkejlWa25IQ1c5NitjSjFPcHBx?=
 =?utf-8?B?a3BsaFlFMUJDaGxobjBEaGpoZmJUQ202STk5UjhqL0pWdWJwbUE2MVI5RHpD?=
 =?utf-8?B?ekZLUXZDZzUrVDNHS0JTaCtqamNnWTZMWkhyVlFxYUtyRXN1UmRBVFdpYy90?=
 =?utf-8?B?RTNJV1gxSjVVbE5ma2RBWXNZUDZNOEtuRmlqMW81SWxmUVltSTNCUm9yUDlt?=
 =?utf-8?Q?qtW2jpDrQX6BfKIKoQVtWlnaciG5w1H4qM75E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5446.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDhPNnBCQUtuYjVSNklYV3dnOTBhb0lwRDRCTFBKVDl4eUphRWV3aU1KbSs4?=
 =?utf-8?B?Ky9qUFk1WkhhY0RBb0FkbWYzRWgyQUZEc3JrdHJ5aVRLQVJ0SFJnc2VuY3pm?=
 =?utf-8?B?OFdpVmFObCtTVXp4a2E0MEt4Tm4xbEhDNE55MUc5eGdORGlkZ2FDbmdFd1cv?=
 =?utf-8?B?UmlFOEZRUEROVGNhYXNhUDlLT21lVkV1cSs5dVJMTGl5Uzc3WkxSQ2k0SldP?=
 =?utf-8?B?eFIzQW9teHRGalRyY0pES0pITXd3WnczY1lRcmxXUjZOK3poYW9WMHpDWjZX?=
 =?utf-8?B?ejlCQjByazdBbTVSWlZLOTRWSndhblNNRHFLSE56eHZ1RTNzWXpVYWc3akMv?=
 =?utf-8?B?VFdOUTlKdCtrbGlRcm52YkpBTUNZV2tZVnZTTkRrZDZOcUNxREJpVlQvZjNq?=
 =?utf-8?B?d05Gc1Z3YW5UY2x3OTdxQ3NEU1QxZndibHZiNEZIZkg2VklaNEhnOHJMeW54?=
 =?utf-8?B?MmI5SFpDeXk0My9WQ0FjemZzcHY0YkVvM3FsZFJRcDVBL3JBWHdaMXlON0ZT?=
 =?utf-8?B?WmhEckVHUVA3bjBlNTZTRlBOMTExRW0yaUc3WFI1K0ZFWXlaSWJiVXk2eEVi?=
 =?utf-8?B?QzZXYm0rUEJoZm9HZlAyUUlCQVZUVzhHcFhGaHplSkRsUm4rclovT0cvc2M2?=
 =?utf-8?B?eFNQdGdPeE9wOW54QytVOTJUWXU4OUtXZUdvNklGQjlvK0NiOEd2aG1FUUJQ?=
 =?utf-8?B?S3hTWDJ3M3ZGeEtYV2NpdE5SWHVzclhyRGF6enNsYlgzMmpRNzc4WW1qRmJY?=
 =?utf-8?B?N0ZDVWJURzFjaC9PZU1HZ3NRTVB0YVRLVlV5OHhjT2k5N0ZtSEtLTy9Tc09L?=
 =?utf-8?B?VjFsQ1QyTk9MTTQwK0Q5NXBES0NkZFNPMnN6TXAxbnZmQ2NOTHpURHlwb1RU?=
 =?utf-8?B?M3BKTXNRVHBjNUhIUURjT0FOdlA1TlNYcmtxN2NMTWJ1NktrNjdMZ2ZDclRY?=
 =?utf-8?B?djl5S3NpMjJMWGEzNDRDazhMSjl4OVdrTldoSjI5elNRVzNNMUpidURENFky?=
 =?utf-8?B?dVBwMCtENWVtcENsUlVoZUhJQ1lmanVNejk0M2M2dmxEQXQ4b2gxVlI0RWhN?=
 =?utf-8?B?ZTJUOU1LeVdleDVVd3ZpUlJPRWVKZWdUOTRTZTlqOWZwbHVaTWppSGFSQmdr?=
 =?utf-8?B?VndhUjdVbERHckh4bG1nMS92NEd3OWF5YXNBcjBnTldYT3JlWTVsSHBOc1ZU?=
 =?utf-8?B?ZzlWTS9vQnZ4Z1VQZFIxTktpMVNXdU9XbVB0QTFETTNYbGpXUUFSZ29SOHZ1?=
 =?utf-8?B?UEg2N0ljRjZob1cwQXJpbHBiWnhvVFViYjNoeW5xSHJObE1jamxrKzM4bm1O?=
 =?utf-8?B?ay9JV0s5NEZ4dkN2Wldmb0w4bFpORVlSMTVrMlFSS0ZlOGNvWU12MTB5MEhG?=
 =?utf-8?B?WGJNOHF3Q05ndXE0aUpIejZzbE14eFBKWEg2ckxabkpOdCtRNTZnTGE5WnF3?=
 =?utf-8?B?U0ZYbkZyUG9HVFhWR1laYVJwUUxHcnhRNHp2elllaEpVQUF4QmlDeEZQTkly?=
 =?utf-8?B?Lzdib2ZBOGcrMmhwYWp1VlArcGY2SUMvemJPYWdrVmllZjRkZVF4NG5qTTNv?=
 =?utf-8?B?SW5JUGxZeEpkU2VrTDI4UzQwVWdsMlo1R05pYW95dm9Hdk5hYlFyNWFYVCtE?=
 =?utf-8?B?ZHFCamV0ZGUzc3gycnFNam8zVVlKUzc4NlFPb25PR3dMcWx4R25WeHlXaGhU?=
 =?utf-8?B?bXJWQ3ZOWWpFUjIyMEkwU3U0ZGRjbHpTeHBzZEhXNHQ1eWhxYVVleVBpV1Vj?=
 =?utf-8?B?UjhvL2RMN2E0V2wvU1B5OGprMDM3M2MxM093bzFIN054WHUrQTZhS0FhakFl?=
 =?utf-8?B?MlMzZWdUUnZ5WFBRN1pkdHBwc1RNckxBSVRmUUxueXpJWGc3c1Q4ZkZVVk5s?=
 =?utf-8?B?WlRPMmNGdFkyazZtNkRhblIxbEYxNDA3bTJocmNNM0xMN2R5eHgvSjlPUmNR?=
 =?utf-8?B?SDNYczNCT2lUSnlXaUZPKzNnSFZQc1FnNmxtaktpMi96UmV1RlB0V1IvVWkz?=
 =?utf-8?B?OERJd0VUd0paOGhvaXhmY0Z2MjVQWG5oYUl6VjFjam8rMWthOXJiV01XRHls?=
 =?utf-8?B?VW1XREo4anU3TkRFaU1FSS9MeExVeTZzOEtValJoZTdqc2d0cExuRkpoV3FW?=
 =?utf-8?B?VDBrMlhUVWJtSFVNOGJFYnh3UVQxMG81VlRML25qQ0ZWcEY0QmRqaXdBZkUw?=
 =?utf-8?Q?y2zhadjhIn6+nbncUGBpg58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B808B2C8CA043418FDAA648FE3F3E7F@namprd15.prod.outlook.com>
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5446.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b648a08a-956e-4f69-7d6f-08dcab9fb1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 05:15:55.1640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gioryoqnhkZztoZ8QpRl5lvsbG5RdeC55V9LbY/ew9KGGYG+DwpnAy46V+30FLJmJGL+RzXqO8xtCqYwu1E+hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5718
X-Proofpoint-GUID: nKFCDnDhqOHCaoKoULF0JO86rIOfNgEs
X-Proofpoint-ORIG-GUID: nKFCDnDhqOHCaoKoULF0JO86rIOfNgEs
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_02,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=692 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240034
Message-ID: <20240724051555.2BXj0dxdzdLO8PSqRo9r9v5hBSzlV6x3dFpr1ODIKBA@z>

SGkgVGVhbSwNCiANCkkgaGF2ZSByYWlzZWQgaHR0cHM6Ly9naXRodWIuY29tL2dpdC9naXQvcHVs
bC8xNzQ0Lg0KVGhlIHdpbiB0ZXN0KDUpIHRlc3QgY2FzZSBmYWlsZWQgc3RhdGluZyB0aGUgcmVh
c29uIGFzICJUaGUgT3BlcmF0aW9uIGNhbmNlbGxlZCIuIEkgc2F3IHRoYXQgaXQgZmFpbGVkIGFm
dGVyIDUgaG91cnMgNTkgbWludXRlcyBvZiBydW5uaW5nIHRoZSB0ZXN0IGNhc2VzKGJ1aWxkKS4g
SG93IGRvIEkgaGFuZGxlIHRoaXM/DQogDQpQbGVhc2Ugc3VnZ2VzdC4NCiANCkJlc3QgcmVnYXJk
cw0KSGFyaXRoYQ0KDQo=
