Received: from mx0a-000e4101.pphosted.com (mx0a-000e4101.pphosted.com [67.231.144.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6514023182D
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.144.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295917; cv=fail; b=fzh3NX3mN6Z0kvUHapV9dnfDr1SnZabQ4vDiHqzaL/wtMEU0xuznJy6dLUi3KqwXXQp/uU0qojAG6ZgBI5h5UUq4kYyvE4eb591c2m4HPkVq63YX5XPUiaAB7u5Ja4tO79XSJKOLE5xHJbAJjPKaGA45lzxF5HzAC++QduCw17U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295917; c=relaxed/simple;
	bh=jDJFM9y7zVot2tFb0bTDgiEo3ipx0F0RMchwNkV8dzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E32747Qn6/xD4cQd1LFrTD5HGTBdk8KserBoyybMEJIvaxh7H5VIPzGsANuwfrJTG1cfqu5wtCrDy6snICRNI3QHk902Azde+2yiITBWcqiG3qjXB8OqPbHlZNIK5CVEV8Tjpu9Uf0XWoJIw8HBcA0VysSgf8JIzeQBTIElbHZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=johndeere.com; spf=pass smtp.mailfrom=johndeere.com; dkim=pass (2048-bit key) header.d=johndeere.com header.i=@johndeere.com header.b=MGAExF1g; arc=fail smtp.client-ip=67.231.144.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=johndeere.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johndeere.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johndeere.com header.i=@johndeere.com header.b="MGAExF1g"
Received: from pps.filterd (m0001688.ppops.net [127.0.0.1])
	by mx0a-000e4101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDTsYj032713;
	Fri, 19 Sep 2025 10:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johndeere.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	S1-Feb19; bh=jDJFM9y7zVot2tFb0bTDgiEo3ipx0F0RMchwNkV8dzE=; b=MGA
	ExF1g72ghx2YgL2rL903mPNfOTGGLt0l9qWmVHmEtl5OmoZkU72pRc44Q7KPuM7D
	1emOzmjQB6es59+0AstGOvvu4i6VaEdFyvtAa0KoEFsBkLFb8BHazOc0c1wHm2Y3
	ruJEy3r02+CLLBz/FIiT2U7KZJMPID0Ia4WujHFQakp+h5iBpPGG2cPKexja9mAk
	8KVub+ppr1yRhYe2DfQFy+NFrW3NN51iHOldZupgUnk+CRmZLbAAIwPZ1AV+9M+V
	1LIxeVcTWQRQaVsM/m6zOMB7dk9A1l3YjhVJJ2IlYbIwcHAa5maks6aBMTDtSRsC
	c/FzExuYRw7v+2KP+yg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	by mx0a-000e4101.pphosted.com (PPS) with ESMTPS id 49984212n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:31:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mw5llXZit2kaMk5MhTR7j5eM2jwQhIFuT1VcJKrGD610VlxklRP8PkA6eAuwx2ikDmFlB5eiROx7CTqeJL3LIbnVrQoowZniuNMQUQAJBsGsfyO8MSls06tdA355iEARS6TPjD4Xge/bY73lVcQdlXdGXKl7b3EsNHAIAk5dAXtZxBBu1esaNs4AhF+tT1uP2kcQvvIF5M3OKJrxhmCLYQpNUfU73f+YqDUXdg9bTyMgR+GdVirk4ZBErebn03jir5pzZQ5SEpZEZnsJHl7MrTHn6UtWm3ftGOVEfw0+YKP6eogaZpDEbr2PanY/ievOVzX46G/88XRDv7DjuXwggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDJFM9y7zVot2tFb0bTDgiEo3ipx0F0RMchwNkV8dzE=;
 b=BdRfZ6E44HCdl6lLLIe9OG+6odFkcg/Wwdng+bAtGzvi8uBNIpRJ50iN5JEFgep7OaIOnODII9TOHAYR4aXcbe2WbF3xLzcoEoqnyfbaPSGa1CGhOEEDLGG+sfWLaZUrDu1o6Stz+kwoftn3SXojNOOLUVl4vbbsaJ2E4ZYwhsoyd6bV2Wd9d31bOf9MqE4PGPCdbor7+xr8xWy4QRtuuKPddao3a8Muigolwg0fuYa9uMVJwMTcNzkAvBLtAMwzp5q8pac9qGrPur5hgBYKrm2bvM59wge2AQai9chJuFQoYuPJcqSNBZLd0t+i/AqD6RNkxAldQpktQOF7FdGEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=johndeere.com; dmarc=pass action=none
 header.from=johndeere.com; dkim=pass header.d=johndeere.com; arc=none
Received: from DS0PR05MB10013.namprd05.prod.outlook.com (2603:10b6:8:dc::9) by
 BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.16; Fri, 19 Sep 2025 15:31:36 +0000
Received: from DS0PR05MB10013.namprd05.prod.outlook.com
 ([fe80::9fee:64a0:138c:ac3d]) by DS0PR05MB10013.namprd05.prod.outlook.com
 ([fe80::9fee:64a0:138c:ac3d%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 15:31:36 +0000
From: Kevin Puetz <PuetzKevinA@johndeere.com>
To: "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        'Jeff King'
	<peff@peff.net>
CC: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: RE: [Bug] git fetch --dry-run --filter makes changes to .git/config
Thread-Topic: [Bug] git fetch --dry-run --filter makes changes to .git/config
Thread-Index:
 Adwn4L+L8mwJ2RsSTrSupH686MDnlwAOFSCAAAMzZEAAKtzLgAACOftQAAQSxgAAIum1EA==
Date: Fri, 19 Sep 2025 15:31:36 +0000
Message-ID:
 <DS0PR05MB10013365E4D3BACFF71ACBAACB511A@DS0PR05MB10013.namprd05.prod.outlook.com>
References:
 <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
 <aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
 <DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com>
 <20250918192045.GA1187769@coredump.intra.peff.net>
 <DS0PR05MB10013AC6090CEE7A562B56CBCB516A@DS0PR05MB10013.namprd05.prod.outlook.com>
 <022401dc28ea$8be87d40$a3b977c0$@nexbridge.com>
In-Reply-To: <022401dc28ea$8be87d40$a3b977c0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Enabled=True;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_SiteId=39b03722-b836-496a-85ec-850f0957ca6b;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_SetDate=2025-09-19T15:31:35.0000000Z;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Name=Public;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_ContentBits=3;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR05MB10013:EE_|BY3PR05MB8531:EE_
x-ms-office365-filtering-correlation-id: 67582ac6-03ae-49f7-0143-08ddf7919f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGxpMnRMVlZnK1Q0K2JRSENGUGJKT2x0UnAxVHptVFFTTWhBcGNJbXlyWnlH?=
 =?utf-8?B?TDhUbSttdExweVdxQ1psRjBvZWZxS3hOUnlnWkFRM0ZNU21OT2xDOWpjWXhw?=
 =?utf-8?B?bkRjMmhYazludGxaT3pSaEdIMFRKL3VQamdaejhVNlVaTGtxTnp5YzB5VE5P?=
 =?utf-8?B?em94RFd5dzlHZ1BPS0locFVNNlBHaENJM1duQnhrc0VBLzhNdzVJNkUyKzkv?=
 =?utf-8?B?SWR3QjFsQ1gwOVhhT3hReGhET3RVWVlhaUtFdTNGdUJ4LzlQUmx4alY1WjJD?=
 =?utf-8?B?bUJORkVQbi9pV0hEcFBjSzd5ZVdiN1BLa3Q2aFoxdlJvR0poZXByQWFhZjF3?=
 =?utf-8?B?a1Q2OEx6MG93RjhnellhWmxURTBKYVA1N0t1eUhzbHI3R2FnZUU4SHI1eHF4?=
 =?utf-8?B?b0FJb0ZrUVRpTWdhL01yM2JOU1B0cE1GdXlNQkhpcWoyam1UYmp1REFCMVZl?=
 =?utf-8?B?Z0F6RVY3MUx6a3FoVUJUSlNzcVMxeWRrcmgzbmxVT0pmU0p1YnFid0kwZ1N5?=
 =?utf-8?B?YlNQaUMyQkdSN3J3ZVlTdk1XbmlnVWlhdVZmbUZXK2lDN3MxdStlcHJjemZy?=
 =?utf-8?B?WC9kMDdtNDQzRVJLMHlPS3p4a2xuZTYvc2JnT1VUb3dHKzJ4WlkvOWtSTFly?=
 =?utf-8?B?eHlRejFpdUhML2g0MUhiTDRBMzZpUEJUb3liU2NpWW0zMzVMOGlxYVFiaUVF?=
 =?utf-8?B?ajNoNTVITGk1SHVPUEhvdXBabjFaVHBLa1VSUFRsaDVQUnJmMFBEeW4ybW9k?=
 =?utf-8?B?bjRvNmpzeDB2cFpOdFA5TmxETVQ1S2ZwalcveTVITjVhWVFFR3d3d3FUdUd2?=
 =?utf-8?B?YjNPRjZGeFJtVWQvbCtvTG1yWWUvUnpTM3F3KzR1c0VTN1Ruc3BMTEhxcUFw?=
 =?utf-8?B?ajByZjZKem1KLzFFeGMzajVGbHlYREoyV205UnZ1VmlkSzlkbyt4UFk2M25o?=
 =?utf-8?B?WGt0bVJ6djN2VWZKYnhtKzVQUXE1d0FLUjRmekdGQ3NHVjJvQ2k2ZnJhbndP?=
 =?utf-8?B?ZHpFbHQ4ZUFFMFdUZ0F1MTcvMUhmYkRuRDlNNU91VVpNaXVoS0ptSkwwSHRz?=
 =?utf-8?B?cFBsKzFiUm9wSnJUV0VWRzVmSFN5eUlwV0RkL1VVVW93TmdWeFd6Zm1KSm5M?=
 =?utf-8?B?cVkwcUYxbCt5a1kwY3pjY2lqTCs0b0tPTDMzVGdtcVRUYnJVU0FLaEJ3a3Jh?=
 =?utf-8?B?UmdubHhpd2xzOW5tc2dZdjVoK3RZcC92a3FwNzU5VkVRMndTQUpHU0tDU2ZU?=
 =?utf-8?B?YktsTzhXcjE3YXBuUFNDQUlEck82Slk2TFBvRU5aYmZhYmttQ0lXMCt4K20y?=
 =?utf-8?B?aXVObmpUSjRKYVo1T0haUmpUNXFFQ2o3eWYvYTVwRHdWbmNYN2dTblFDci9k?=
 =?utf-8?B?VTBiREZ2dFd3UlNXaGJ2T2VGZjJYbkF5cm4vNlN6T20wTzFOclRqUUFiY283?=
 =?utf-8?B?emtNeGkzMFNQUTNoQ1IxT1Fma0E0R1g4eGdPUCsxNGl1OXRwWlgxUFllb21V?=
 =?utf-8?B?ZXpZNnYyUFVWRXYyWUZoSHVma2RZaitvOXAzWDRjSEV0MzRoZ3BmbzJZNUQ0?=
 =?utf-8?B?cDJTM1NqeGx3ZkJOUE1jOC9aSlRBRXBkdEc5MDVTSVlHSXlwekdQUW0wUUxn?=
 =?utf-8?B?SHhXK0VlNlJXeFFhUVZSSmp5UWVHV1ExOW5VcXdnb1pTOFM0MVpXVXdQVnRp?=
 =?utf-8?B?ZDFNblBlKzl5TC9SWjNhTkpPVkIzcURNTWpEb1ZrQ0xYUnVyeU0rVDR3Vzlq?=
 =?utf-8?B?UUE4Zy9MOXFyald5WGFHVWhwcWNrczhmMWg0VUhueVUwTmROdGk3SXNPUXVO?=
 =?utf-8?B?U3h5eENjRkZuUmg4Mjd5Mk1pYkxEVTdRTkN1UjBYYlcxTFl6R2lMR240elRS?=
 =?utf-8?B?NE94RW0xOVp3WmZIUGhmbTRtcnZmS2xjWXo5Vmp2a3JjcFROell5OW83c2tj?=
 =?utf-8?B?SkdFRDB4V0YxRXdJVk1Md2ZrdXZuQjlWbGYvS2RBTFBHRFRuYitzODVBdVNv?=
 =?utf-8?Q?IA4xNfn8wc9p5dTWMKx21kpthdfyeo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR05MB10013.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDNJemU2M0hLOWY2TzYyWXB3RG8xSnZDOVdveFBaOUNOSTZOeWxoZkUrSnR1?=
 =?utf-8?B?VE9WaVNad3VLN3N5VURkam9QLzY5OXViU0ZMWDBUOGpYcEdvREp1bWNnak56?=
 =?utf-8?B?OVJyNjA3RE5nV3E3Vi9kWld2YUI2WkVlYjlscEx6Sk16VjQ2R0ttWTZCR3dp?=
 =?utf-8?B?UjlKc092US9mQ3ZPdnRjNnBWaTF5SWFheGthZUZyRDRJYkpjdHM0MHk3bGxr?=
 =?utf-8?B?VE1SOWRPSTZBY2N1Z3FaTUNTdHVLekYvSDNpN3pYK1lHSElZUGNadkxweEpU?=
 =?utf-8?B?MjFtYWJxS2NTSGZVOHZSYXQ1cWZjd0VZSUtnUzRSc1NpejRoZThVWDl2MStt?=
 =?utf-8?B?bU9meEhGNXFJSlRZdnBydlAyN0RGQ1djdWlrN2ZFcHJpR25DQ2tEbTNKb2NB?=
 =?utf-8?B?OEc2S0R0c1ZxN1prY25aazFmRTJqb00rMTVQemRxQjhqY2tIK2xXR0pVY0Ny?=
 =?utf-8?B?aVBKdWdxeFRzRXhtRDZRVGhKUjJpd25IM0ZuK1Z4VFg2dzNlcER0MHB4dVhS?=
 =?utf-8?B?aHVYRjZzWHQvNjg2bVFRb0YrVUhKTSt1cCtnMVJzZG5EWTJDMFNxbmU5QlNw?=
 =?utf-8?B?S1BZM1FGb1htcTFDMlI0OC9aOEZ5dksra3ZtQ2RXaHRJY2dlWUN1RXRWTUpn?=
 =?utf-8?B?T2RubnlPRHpQc08wRjdWUTBFeEVWNjI4c0pCN3B2c3ZnZmhPckZ3Y0d3ZHVv?=
 =?utf-8?B?aEtZQ0h5RUljbzdTVDlPUEVVaWxkOVI1Qjh2akM1QkxHM3c3emdkaHVIcXZY?=
 =?utf-8?B?SnA3QWJJcXhBNFdtd0crdDZ2N1hib0FESWNSd3gvdzZzaEp3UXJ5SCtqSzdP?=
 =?utf-8?B?WWhlaUVoNUZGS1F6c0dNRkNhWEozSXBkUnhGY1A2aStrYWVzSi9SaVVHaEYv?=
 =?utf-8?B?TFdiK2hnTzAweDZzNDE4eUVZV3BpdG1GVG1CdmdDV242VWcyZWJ3YkttY2RX?=
 =?utf-8?B?ekJlc2Evamp6VnBCREtPSUJiWHNIK2N5eERVZzgzVkJETGFUZnNiN2U5dDlv?=
 =?utf-8?B?RjJNa29NYjVDZ3RITGxlN3FWVzRMVW9sVUxscHJZNkRrQ250Y2o1aVFDYktZ?=
 =?utf-8?B?VkpGK3BjZXhYVDVvUEV5QnQ4M2pHODIzQXlwZ2p3WHZZQXdGWnJmcHh1Y0c1?=
 =?utf-8?B?WlRBbkthQndoVFpkMUFQR21TT2M3Q0FUSk5PR1p4SzRRbjBqVnJEVXpHVklq?=
 =?utf-8?B?dCtVbEFnTFcvd1oyQUZKYWdmTkNZZ1lIQStkYU8xWW5RZlRvYzYzYzBEaU5N?=
 =?utf-8?B?MUdhcnpLMzBHVGlqTHM2Y09Pc2UxNnUzNUQwRElHS0FKcVhlb01URG1odndH?=
 =?utf-8?B?K3JqOXJEL1VIejdoWEpaVjZQVUJSbGRFdWh0TG1oNnF2MWtBb0dYb09hOERm?=
 =?utf-8?B?djNqSHpuY0o1ekhtTEVKQkxVYXEwQXErbnBDMWNOcmZGeE1mdXU2ODBtR3pT?=
 =?utf-8?B?VVM2Yy9sS2FEc1crSEFOQWRlLzhVU3ZmRXNHNEJCV3JaY0dkbG9oSHZBT1RW?=
 =?utf-8?B?ZUlNR09EYkpMQS9CT0lhUUl6V2lzYXVBeG5pc2I5azhlQndqMGtWZGVESlBy?=
 =?utf-8?B?TkF1YUtPdDlPdGR1SmJEQitDSjVUWGlNRXY3QmhKdDZ4MlZ4OXMzeERLd3o3?=
 =?utf-8?B?RDh6bnRaSERYb0VCNE5kd0c0MFYrU0xKRTNrMElkcjV6VEp3Zm9IWUIwV3dq?=
 =?utf-8?B?dm1NWG1rUi9MaWJ0OHcvNUdvSWUyMXF0T3NKVlVlYktXbTljWWhoNENzWGdw?=
 =?utf-8?B?djQxcG9BMDExQktLV0pOTlk5aE9GSlQvbUV3K0VNV1pCNVNtVGVZL1hyOUNX?=
 =?utf-8?B?ZGxBaWtCZWxweEx4dVBnc0RXM2FwZFpxeHFKdmtCY2U4blUzdGpwSUpsV0NT?=
 =?utf-8?B?bXJjR3BKd1dnQnIrdnFLem5YeUZvNWhzc0hBTmJldEUvdzcrdjgyTWlvNEtE?=
 =?utf-8?B?VkowNnJOY1JaOVk0d0UvV21ORlYycHFESWdkQ1FITHlEU0I4dXpTK0pLaDBm?=
 =?utf-8?B?bWdnU3pxYkwvYUJQZDFrVWJQd29VZHREWnk4VEtwT1hWNk8yMEdnU1hJdDly?=
 =?utf-8?B?Vlg5RDNlN2tTUGpDVlNYaE85T3RzNGs1bHR5amxOamhkV1IrUEg1QTc2cjlL?=
 =?utf-8?Q?feu/GyI9yU4A+FB22PJ8tnf7P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: johndeere.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR05MB10013.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67582ac6-03ae-49f7-0143-08ddf7919f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 15:31:36.7806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 39b03722-b836-496a-85ec-850f0957ca6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHUySvPnWLVs6+MBgE79ozOuVbhk7Q1z16THXZg/LIGiZLT2FHqwFvD8GW1tN84alMUj3eki5yJuBtQGHm4Ivi8A7UPnFZQDe7Y185Pj+7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8531
X-Proofpoint-GUID: JyeOj01799eG1QOWfyTbnSZNghtzSsWz
X-Authority-Analysis: v=2.4 cv=TsrmhCXh c=1 sm=1 tr=0 ts=68cd775d cx=c_pps a=rDMf0xV6zgmXoNUq+bKLQg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=DuOtGG-n0nsf7xd4UC8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JyeOj01799eG1QOWfyTbnSZNghtzSsWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDEyNSBTYWx0ZWRfX+oLAc5ddHrxI ifQmn3sQICMqxkGPVFE+Yl4T1NanBuu1f8mHGHK9kwYyMwG0eZroUUINhm21GqX8QO3rX6eUkUw s+x20yhkBfLQFm9vy6s9x36ypeKYoQFsQRmrdaiz6/oA7nA+WMSbYi16LMjWc5pasVilPakiKHA
 8OfI67cHervp2BqUo2Vbst3eDGMBoN7elb5pWeCUUfPr7v+IYVyra3YLjwiCpqTLHKZYzRSg2wF NSFlO9KZAw3lMJdMHV/k+mqvTnfH8ZJ9PFr2/LYd+tbP9BJHTkaYYrwTa6Ko1utdKCq+NYF1CGZ iN++D34Rr2YDq73wQoWjLSQqhvrV4z9HzubEK1SdtBwLWQr9583Gn//pMLMjD/skhid8cXo8j/q 3m9SIPCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1011 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509190125

PiBJZiBJIG1pZ2h0IGFzaywgYW5kIEkgcmVhbGl6ZSB0aGlzIGlzIGFuIGVkZ2UtY29uZGl0aW9u
LCBidXQgd2hhdCBpcyB0aGUgaW50ZW50IHdoZW4NCj4gdGhlIGNsb25lIGhhcyBiZWVuIGRvbmUg
d2l0aCBhIC0tZGVwdGg9MSBvciBzaW1pbGFyPyBUaGUgc2luZ2xlIGNvbW1pdCBtYXkgbm90DQo+
IGJlIGtub3duIGxvY2FsbHkgYnV0IG1heSBiZSBpbiB0aGUgaGlzdG9yeSBhcyBmYXIgYXMgdGhl
IHJlbW90ZSBpcyBjb25jZXJuZWQuIEkgYW0NCj4ganVzdCBjdXJpb3VzLg0KDQpEZWZpbml0ZWx5
IGluIHNjb3BlLCBhbmQgbGlrZWx5IGEgY29tbW9uIHNjZW5hcmlvIGZvciBjb25hbi4gSWYgeW91
IGhhdmUgYSBmdWxsIGNsb25lDQp3aXRoIHJlbW90ZS10cmFja2luZyBicmFuY2hlcyBhbmQgc3Vj
aCwgdGhlbiBgZ2l0IGJyYW5jaCAtLXJlbW90ZSAtLWNvbnRhaW5zIC4uLmANCmlzIGVub3VnaCB0
byB0aGluayB0aGUgcmVtb3RlIGhhcyB0aGlzIGNvbW1pdC4gVGhlIGNhc2Ugd2hlcmUgaXQgaGFz
IHRvIGdvIG9ubGluZSBpcw0Kd2hlbiBzb21ldGhpbmcgbGlrZSBDSSBkaWQgYSBgZ2l0IGNsb25l
IC0tc2luZ2xlLWJyYW5jaGAgb3IgYGdpdCBjbG9uZSAtLS0tcmV2aXNpb249YA0KYW5kIHRoZXJl
J3Mgbm90IG5lY2Vzc2FyaWx5IGFueSB0cmFja2luZyBicmFuY2hlcy4NCg0KSWYgdGhlIHJlbW90
ZSBoYXMgdGhlIGNvbW1pdCBpbiBxdWVzdGlvbiwgc2hhbGxvdyBvciBub3QsIHdlJ2Qgc3RpbGwg
d2FudA0KY29uYW4udG9vbHMuR2l0LmNvbW1pdF9pbl9yZW1vdGUgdG8gcmV0dXJuIHRydWUuIEFu
ZCBpdCBsb29rcyBsaWtlIC0tbmVnb3RpYXRlLW9ubHkNCnNob3VsZCB3b3JrIGZpbmUgZm9yIHRo
YXQuIEl0IGxvb2tzIGxpa2UsIGluIGEgc2hhbGxvdyBjbG9uZSwgdGhlIG1haW4gZGlmZmVyZW5j
ZSBpcyB0aGF0DQp0aGUgY2xpZW50IG9ubHkgc2VuZHMgImhhdmUgLi4uIiBsaW5lcyBmb3IgdGhl
IGNvbW1pdHMgYmFjayB0byB0aGUgc2hhbGxvdyBib3VuZGFyeSwNCmFuZCB0aGVuIHRoZSAiMDAw
MCIgZmx1c2guIFdoaWNoIGlzIGNvcnJlY3QgLSBpdCAqZG9lc24ndCogaGF2ZSB0aGUgZWFybGll
ciBwYXJlbnRzLg0KVGhlIHNlcnZlciB0aGVuIHJlc3BvbmRzIHdpdGggQUNLIG9yIE5BSyBhcyBh
cHByb3ByaWF0ZSB0byB0aGUgImhhdmUgLi4uIiBpdCBzYXcuDQoNCk5vdywgdGhhdCBpbmNyZWFz
ZXMgdGhlIG9kZHMgdGhhdCB0aGVyZSBhcmUgbm8gY29tbWl0cyBpbiBjb21tb24gKGlmIHRoZSBy
ZW1vdGUNCmluIHF1ZXN0aW9uIGhhcyBhIG1vcmUtZGlzdGFudCBhbmNlc3RvciwgYmVsb3cgdGhl
IHNoYWxsb3cgY3V0b2ZmLCB0aGUgbmVnb3RpYXRpb24NCndvbid0IGZpZ3VyZSB0aGF0IG91dC4g
QnV0IHRoYXQgZG9lc24ndCBjYXVzZSBhbnkgaGFybSAtIHRoZSBuZWdvdGlhdGlvbiByZXN1bHQg
aXMgTkFLDQooY29ycmVjdCwgd2UgZG9uJ3QgaGF2ZSBhbnl0aGluZyBpbiBjb21tb24pLCBhbmQg
aWYgdGhlIGNsaWVudCBkb2VzIHByb2NlZWQgd2l0aCBhDQpmZXRjaCBpdCBnZXRzIGV2ZXJ5dGhp
bmcgKHdoaWNoIGl0IGRvZXMgbmVlZCwgc2luY2UgaXQgZGlkbid0IGhhdmUgdGhhdCBlYXJseSBo
aXN0b3J5KS4NCg0KU28gaXQgc2VlbXMgZmluZSwgb3RoZXIgdGhhbiAtLW5lZ290aWF0ZS1vbmx5
IHBlcmhhcHMgdHJpZ2dlcmluZyB0aGUgc2FtZQ0KImZhdGFsOiBleHBlY3RlZCAnYWNrbm93bGVk
Z21lbnRzJywgcmVjZWl2ZWQgJ3BhY2tmaWxlJyIgYnVnIHdlIHdlcmUgZGlzY3Vzc2luZw0KZm9y
IGFjdHVhbGx5LXVucmVsYXRlZCBoaXN0b3JpZXMuDQoNCk9yLCBpZiB3ZSByZXZlcnNlIHRoZSBy
b2xlcyBhbmQgbWFrZSB0aGUgc2hhbGxvdyBjb3B5IHRoZSByZW1vdGUsIGUuZy4NCiBgZ2l0IGZl
dGNoIHNoYWxsb3cgLS1uZWdvdGlhdGUtb25seSAtLW5lZ290aWF0aW9uLXRpcHM9SEVBRH4xYCAo
cHJldHR5IHdlaXJkKS4NCndlIGdldCBhIGRpZmZlcmVudCBlcnJvciAiZmF0YWw6IGV4cGVjdGVk
ICdhY2tub3dsZWRnbWVudHMnLCByZWNlaXZlZCAnc2hhbGxvdy1pbmZvJyINCkJ1dCBpdCdzIHN0
aWxsIHRoZSBzYW1lIGJ1ZyAtIHRoZSBjbGllbnQgc2VuZHMgdGhlIHdlaXJkIGVtcHR5IGZldGNo
DQooIndhaXQtZm9yLWRvbmUiLCBubyAiaGF2ZSIsIG5vICJ3YW50Iiwgbm8gImRvbmUiKSwgdGhl
IHNlcnZlciBmYWxscyB0aHJvdWdoIGludG8NCmBjYXNlIFVQTE9BRF9TRU5EX1BBQ0tgIHRoZSBz
YW1lIHdheSwgYnV0IG5vdyBzZW5kX3NoYWxsb3dfaW5mbyB3cml0ZXMNCnRoYXQgYmVmb3JlIHRo
ZSBwYWNraWxlLg0KDQoNClB1YmxpYw0K
