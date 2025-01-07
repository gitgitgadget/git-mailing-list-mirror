Received: from mx0a-00311301.pphosted.com (mx0a-00311301.pphosted.com [148.163.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751A1F63E6
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267255; cv=fail; b=feWN4rbSjkbLGQytYrKguEU5jcLVrlxBIZt8o5OtSTwGLcUNrIq8PyLmo5B2zGhadAFZYZx5pNk2TpNatcMN8I0efGck7wC2rnCpMNzDaUkcahiHOhge7yHzgOs3aIog3hfl+xbNtrQnS0I/m3WFdDt4TCHdsfQrUITMyDey2yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267255; c=relaxed/simple;
	bh=5bBvgTpZKIMF1OxanCT8SVAZWt2VdyFSRlK56ebO7/A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8crwlUgkDwM+2BWisK2CiSJEHl8Yq+2vq2AGEItUii9XFWsJ9yGmqHWCJLj2NK1IWX/Zumlg3CN+wnGg0TJ6XciqsPoNp/aHspM2TpsiSLQkb1fqEm6Q9vMxsVEqSFJRkqBK5t9Gbm/aq7i9yEl+i0eZ/zofGPpSvznbz7/sXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beyondtrust.com; spf=pass smtp.mailfrom=beyondtrust.com; dkim=pass (2048-bit key) header.d=beyondtrust.com header.i=@beyondtrust.com header.b=dvw2s22a; arc=fail smtp.client-ip=148.163.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beyondtrust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beyondtrust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beyondtrust.com header.i=@beyondtrust.com header.b="dvw2s22a"
Received: from pps.filterd (m0148116.ppops.net [127.0.0.1])
	by mx0a-00311301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5077nhB3005972;
	Tue, 7 Jan 2025 08:07:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beyondtrust.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS; bh=5bBvgT
	pZKIMF1OxanCT8SVAZWt2VdyFSRlK56ebO7/A=; b=dvw2s22aOhWbFmLQ06dgPC
	uOt9mFKoT3yeeZRDuwgK+gpiAdP3PdaSpMGKpx9IjWgE2/QypQcMH6ih9kE8juR8
	/zJ3ek7xq04xbHO0HetrSvrBoZTIZWjxI+QMOEXNWtSvuwAJoGO2rTl0ZIQGcYIV
	Kq1MSPbVw5USSouewIoMAf5rRHH1D7TnqcXiBcbMtmWynSs0Y2qYN1UNVqtJ7OK8
	mbF8+b6UynEx+SQqYYHXMtAzL/MSo9YwTX00mTRy5SWWuOTbl+gn/8ql6Nyb/edw
	LO2HJL1pxzu7J81gtTafStV/HdU8cPknprr4opoGeeqR8Hebn0OelFLbIiTwNwHA
	==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010005.outbound.protection.outlook.com [40.93.1.5])
	by mx0a-00311301.pphosted.com (PPS) with ESMTPS id 43y2yrcy8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 08:07:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijZ6bo+o7mbtzZEThcU2d8rQAnuYDyLW5wLWvKrRtb2yYQyEwBmQ7GDmegzBRkXGCVbBOnVLWIUGgI+jmCtrVzgKYHFge3/VvMNqhga9UUkHIOxGo3EZin1KMsDqdTUfDiq6q4o/Cisa1i/7o46ddhwzsL49/PmdkIPbRNJAv3tx1zzEV1SpMTXdNLxIHHaMCPs1ZY9W6NhHUtZkau6FMQPqP8sHTfPezUs03QlmaKtkiSYz3UC7TsiKTXnK3H/UKQGWPzCc+sF6AkuH1r70iztU/pDqF9LovAPrj62OIagAVsh2wuXBN1BNVtkcpSwfMXJLWom49VYwAYSG9QQnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bBvgTpZKIMF1OxanCT8SVAZWt2VdyFSRlK56ebO7/A=;
 b=wQb7jgBIE4tX5f6fw49brVC3nJRuiaR3lBDcZNYmdD1+F3WUtXJAc2RLfQFy4JUENBg5CwDYqol6U8Op4w4UmgKsX3xThIcFA2Wek3M8KlVuRrPEvBwUO9sgVH5We83T5xjL/JXnepsYTirVGdgMgdMHshyh5eDeiQgYEeumN44PUVEvD92B2p+dR9hv3gDJvjYCL0RRRxpEt11cC2jTI6var6TSqyfYDS9OdjB9N7fdxugp1PJtCBA0UiwFOL2W0y5kzJESe+b//3DFDelzvvVBs+ddnP/aARD8Bza9rIB/U6vlmcQ+NndWY1bMvXmACBnbEPDIWsvcnn5Znb+czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=beyondtrust.com; dmarc=pass action=none
 header.from=beyondtrust.com; dkim=pass header.d=beyondtrust.com; arc=none
Received: from DM8PR02MB7942.namprd02.prod.outlook.com (2603:10b6:8:13::8) by
 LV3PR02MB10175.namprd02.prod.outlook.com (2603:10b6:408:1a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 16:07:46 +0000
Received: from DM8PR02MB7942.namprd02.prod.outlook.com
 ([fe80::443a:e98c:3129:b12]) by DM8PR02MB7942.namprd02.prod.outlook.com
 ([fe80::443a:e98c:3129:b12%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 16:07:45 +0000
From: Keith Mendoza <kmendoza@beyondtrust.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git restore --staged -p on merge conflict causes crash
Thread-Topic: git restore --staged -p on merge conflict causes crash
Thread-Index: AdthEiJJD91DndapTpWQotl3/tqJlQAB3uyAAABvVgA=
Date: Tue, 7 Jan 2025 16:07:45 +0000
Message-ID:
 <DM8PR02MB79428E0A2C6C32EA67D791D1C7112@DM8PR02MB7942.namprd02.prod.outlook.com>
References:
 <DM8PR02MB7942969BE7FEAFB48D9AEDCEC7112@DM8PR02MB7942.namprd02.prod.outlook.com>
 <27ec479b-b116-4fa7-b87c-416a5f7f3b25@app.fastmail.com>
In-Reply-To: <27ec479b-b116-4fa7-b87c-416a5f7f3b25@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-xink-handled: Yes
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB7942:EE_|LV3PR02MB10175:EE_
x-ms-office365-filtering-correlation-id: b1f21dbd-dc46-42ed-5dde-08dd2f356c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1RUVmtjTGpoNno3OE5JazEvbTlxNnFtMGk4cHQ0Q1VQNldlY0V3anVML1d3?=
 =?utf-8?B?eURjWmp4MzFLcTN0eW9ZSHVTN1lkMkVXeUFha2k0c3g2T1JtbnVBQm13RWxU?=
 =?utf-8?B?eVlEQkZuV3M1UFYwWlpyMG03Vk4rTHQvVWRiQ1U2bzc4aUo3UVZxVzZBaFdB?=
 =?utf-8?B?dDVwcURWandmL3JZUCtuOU9ST0RHWkZyaXNoT1hKSHBkOXVUWHlKb0xwSVNv?=
 =?utf-8?B?cVg1QVVtemszTm9QZm9NNDZ3S0FmZlEzbHh5UTlBK3VIdG0rVGRRTnhqMk9s?=
 =?utf-8?B?SXdjdm5vM21keUw3TW04Nk0zZjl0aGJSd01sdWFsUzJXZnJ4Ym5CYncxdDMx?=
 =?utf-8?B?ZGVGck1ZL3psQXlPU0hVZ3I0ZS9qUnk3Rlc2dWN2TDBtOEtIaTlSVTRZVllZ?=
 =?utf-8?B?Unl2UTdDcE1jWlpUVm1ucjVMeENyUG53MkR5VFN5ZnJrRk1taUNNRGZBaHN3?=
 =?utf-8?B?bTYvbjY1aHJVTFBsOFMya20yTit6aW11aHBiSi9iUWZQUmVKY2xnRFJGdjE4?=
 =?utf-8?B?Zloxd1llNm5OeWE3YUNRZzlWRnpPODR2MVZYLzFOUy8rbHhXM20yU0pSOTNu?=
 =?utf-8?B?SzFFWFN2UXkzeDUrQ2NPYkFCa2I3NFUzYjBzK3hQSFVPVW5HSjBTczNFUkZ5?=
 =?utf-8?B?QXAza2Z4ZGhQQ04zK0dkeGNGcVkxamVYOUhxR0duTjNrTThoVEZZVzlwclZv?=
 =?utf-8?B?dVdMRkhnZkJWSnJNUTFNRVJmNUovd3M0cWMwMXU2enVOaFNqR0ZwMzRmTlVC?=
 =?utf-8?B?bHRIclFZamlFdUhscFZCdHl1UHlYV2Q5TlVJWDBId2sxelJPSHAvWDlkOEhN?=
 =?utf-8?B?enBnLytTU2xHSHczZjhIR0RvVWg4d3JmSVBTMkR6UWRWWXBLVWhGWll0bmZh?=
 =?utf-8?B?QlNzM1dXTGliSHA2UGppQlVKaXBQY1NOZ0JER3ZESndvbUttdXA5L0hVMXNI?=
 =?utf-8?B?L0dvVkg4aXZieTdRY05FZjR0Y2NpM2N6NjVXT0QyZlFxSzJTbFduQjFUMVRD?=
 =?utf-8?B?cWU1Ykhyd2N5MzVTZXp2dW1Gd05ESEluZFZETXBGY2VMUTlqRGw5RFVidTVu?=
 =?utf-8?B?VkdzKy91a1JWbFVVd21QTlpaeE5QdTAvSnZTNFZNZWNRUGNVdDVNcURYN3VL?=
 =?utf-8?B?dDhUYXQ3YjBYT25EN3NRaXhVcmg1R0hmbXpSQ1pldXF3RGJZcjlYZFhTRUtC?=
 =?utf-8?B?ckJDRHVjaXdhVUNFUUpnYzF5RDFTeC9DT3U2ckJwUTREWmIrNEF0L0l2R1o0?=
 =?utf-8?B?RUVNWFNQbStjclZhckhIZUZXbWRQQjBUM1JqYmFNVnFnTXZWUFpZNWRPY2xI?=
 =?utf-8?B?NHJxNGFuL3kzdE14ZzNmZUplcmZwR216bUNSL004RUN0SmJJaFRvUGdMQUkw?=
 =?utf-8?B?VGNZMjhMb3huck1yUjZzY1ZlY3lGeHQ5NzlSZTNHVFhrbkhLUk8xdUdzODBO?=
 =?utf-8?B?TW5ZeHloMzgzZVYyRGlrR1ZNSkFkMjVPelBUY05IOHNQZWt5d3lSRjN3aXd4?=
 =?utf-8?B?dmN4aDJIVVova1lveU5kNFJ6ZERJUU9CM21DNjQyRFo2QUg4WTFhZmtoZFRX?=
 =?utf-8?B?WVdLdmRrd1pLckFNVE5jUEgzMHAweVhLZ3BXbWRkM0VyWFYwaWYxVjljeTU4?=
 =?utf-8?B?MlN6RVNlc0VvUUtqS0Z2bm9uV0gzV2FoaXVMVmxnNUYxTm4zckQ0TVNKQnJ4?=
 =?utf-8?B?N1pRSEpDdzhRcUZJaGdrYTRkOTk2dDZmQjhSKzd0bzNJUzRyN3BDdmhSb0ht?=
 =?utf-8?B?b3VWaWRDUnFGenZoUGpvaGJSekhORHNLcFdIRDlNOEhVb215VXFkWVZ1VGds?=
 =?utf-8?B?bG8wU29VbTJSazJxbysvZ2tEdlBTZ21idTJVYm54TFJnWHUwTStrN1hNcXRM?=
 =?utf-8?B?MXM5d0RXYkgva0RkendXNVdVZy9zQTF0dUluS1ZBU1VaMjludGJaS1NIQ1ow?=
 =?utf-8?Q?Qs9FH6bRMA0QcEq6KC5Mzem68ToBCab9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB7942.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2d3RE1kWHk2L2xUVDF0bWJzRFRxdXpSTEFDbFRmNTh5a1JPcmJqcG01V0JS?=
 =?utf-8?B?bVN6b1ZmaDVoOHR0UjZzejdmeGZ5RkF4K2NTWG16dnUzWHgvcytFdGo3bEdj?=
 =?utf-8?B?Mk5JeUJLemR1clBUbzhpM044anNsU2ZjcGtrN3Y2bGJhUGpPWGpEYWpYcXBx?=
 =?utf-8?B?cm1kZW1zd0tubWh6eGNMbXdBaUV4NWJRZU1tQ2JURTF1TFlTWEI4clVTVDMy?=
 =?utf-8?B?citkMUFGODc0WkpqNENBZHVzTDY3S2JlVlZBSkpRMVdwaUFKaTBWb1ZLTWE1?=
 =?utf-8?B?Zm1QRXhFenZ1WEcyYTZWVG1EblZ2aHZQTjFiREY1M3AzYjZIcVZHNVpoczVG?=
 =?utf-8?B?ak9ZWFlGYVZSVGQrZlZkQUFVbHl1TU1IZXc4QkJsVmo2Q0w4SFBNcmtpbmpz?=
 =?utf-8?B?U0hpcUREcDUxSFhSSkRGN0hkUXFjWVIwQytTMmJFenRWL2RuU3N3dm15OVhD?=
 =?utf-8?B?SWtRZmxOZ2ZrSGFPTFN4dFVvS3RHc0dPUzVQS3o1NUhZWi9jWnpOaWc5dTAv?=
 =?utf-8?B?UGdXd2JTeW9EZXBxa0MyMWU1bkNSckoveDZpV1dlS0tQN2ZSUlJoU2k2STVq?=
 =?utf-8?B?Slp6bkR4eTBGaWNNM2FlWDNGVnMzcm0xd3NuRThPQ3FxVGs3cGlhQVVJV0Rq?=
 =?utf-8?B?aU81MFFpOXIvbU80STZhRDBqdlhWSzdMZDRGblBTT24vK0xOaTJXUGplZmZv?=
 =?utf-8?B?M0h2MFloNFF2SlZGblZVb3QzdkZad1RlZjBYVG5aSlZ2MDUrYmx1azFRY2Y1?=
 =?utf-8?B?RjI3NjdMT09POU9jR1FrbDg4REx4TGpyeGd0a0JwQWx3NGxGVEVoL2tmMmhB?=
 =?utf-8?B?Y0FhWEFZL1ZjcUdxdkdaYjlHSkFwaEo3NGt1TEtQOEFjckVnb2xHcGUrQllX?=
 =?utf-8?B?a1c0ZE1JZ21oY1RMU3kxcGREQkNDcW81VlpRQlJsY3ByVG04VFNZcDB4RHlD?=
 =?utf-8?B?T0hnWlozdXczUVhvNEdpVW5qYzl2SVhKRzlxUCt3clp3cjc2a0Z4ZDZ3L1Ur?=
 =?utf-8?B?T3NWTUNRbmNNYWkvQVkzRVNFV013THgwS1U2aHZ5ZldocnlsUzZTM1M3ZVZw?=
 =?utf-8?B?RjdHNTNvTkpqWkZuQ2xNMDhNaWwxK25ieG5JaGN4bUd2R2EzS2VNRVlCMVhF?=
 =?utf-8?B?cDVUeUs1TEJwZWVXZGt2MWJML0kxSXpsZWdiZHhMakdNR2tvRFAxRUlxQnZh?=
 =?utf-8?B?VnJCY25qeGgwUFVNaXVGOXFqb1ZxSFd1VUhUd2V1dlkrL3FlNGVKS0FITmkx?=
 =?utf-8?B?dlRZMHVSSmY3azJOd2prQWZuMmdlb2ZqanZQQnVZbEV4dkdhenFKVnA4TGx2?=
 =?utf-8?B?cXRMTnJRQXJYVS9FekJlKzltYjVZUHBoMC9Tbm9qTEZnRThocU54WmtnNWRQ?=
 =?utf-8?B?MmQ2M0s5L2R3cXU3SENVVDR2UWZSaC81OVh5VUdkaDJuRXBYa2dpYlB1aGZ1?=
 =?utf-8?B?V213SnIyMlgwT1R0a1FYM2JzMm5ZZWhDRmxpZTZkK2gwcHJvUjhsQ0wrVlBy?=
 =?utf-8?B?T0RkejE5REsxVUdCMWJFcVJDV0wxTG55Z3RNWlkyVExIRFRTWFVOQm9UaVZk?=
 =?utf-8?B?VmFvTC90eEtOeXlRR2cyWVpVQmxFdXRCUk5mNmFHM1hoM0FVNG9Lb05vUGRr?=
 =?utf-8?B?REdDRWpNRURNTlQ0c2VVZmk0djh4SSsyaDlWWlluaHB3b3ZUeGFrUU9Tdm56?=
 =?utf-8?B?OFlKcGltWmxncXhSRHRLWnUxLzF6UzJ4ZlljVFVWUXRGWFdJakpqNzR4RWNS?=
 =?utf-8?B?OWQrUnF2cEhDOE1VQldwTTFRdG52dDh0MjdsK2FiY0doZGVJZ0hzbFdnamQz?=
 =?utf-8?B?QmFJRDJvckVaODFiNVk3OHVKM3EzczNHV3lTQndpTDhGT01zWkxrdS8vWmNG?=
 =?utf-8?B?bTUzYVBaa0VEUE01b1BlOW5XUWgwck8wV3hhRGtBcTRMcWp4bjlvN1FEaWhP?=
 =?utf-8?B?TGRKdWtMRTI0M0lpeVY3ZlZrRm9tMmFCSHpxY01vdTQ1blBtWTFEc2JoWU1l?=
 =?utf-8?B?QU5OYVpJQkRsK1ZhWjdFcld2SDV2QmEzZW1aaXYwUklYTnVFUFBPcHJaaEVB?=
 =?utf-8?B?azVUbnBPT2VaU3VZd3ZFRFpDMFEwNmtDcEgyYkdDbkFaNGVWZjhjK3YzdXNU?=
 =?utf-8?Q?hxRRLcScIYaBVrft/0XPOWFCW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: beyondtrust.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB7942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f21dbd-dc46-42ed-5dde-08dd2f356c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 16:07:45.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5683fad6-d462-468d-9daa-809d2d98368e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDn/p1o/me2tn41fiMz9+ud2GOtE4YX+vpz6ueXzja/uTPM8+J8u2DqeEWXNnArkS3UoMgAsiLh5v867BNloVxmOyOOZz2Q7rrvYZgY62ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10175
X-Proofpoint-ORIG-GUID: 8Xtv0EAfaXIV94lvz1APSxzWn7o8_7Li
X-Proofpoint-GUID: 8Xtv0EAfaXIV94lvz1APSxzWn7o8_7Li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2501070134

VGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEtyaXN0b2ZmZXIgSGF1Z3NiYWtrIDxrcmlzdG9mZmVyaGF1Z3NiYWtrQGZhc3Rt
YWlsLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDcsIDIwMjUgNzozNCBBTQ0KVG86IEtl
aXRoIE1lbmRvemEgPGttZW5kb3phQGJleW9uZHRydXN0LmNvbT47IGdpdEB2Z2VyLmtlcm5lbC5v
cmcNClN1YmplY3Q6IFJlOiBnaXQgcmVzdG9yZSAtLXN0YWdlZCAtcCBvbiBtZXJnZSBjb25mbGlj
dCBjYXVzZXMgY3Jhc2gNCg0KVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0
aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUuDQoNCg0KT24gVHVlLCBKYW4gNywgMjAyNSwgYXQgMTU6NDEsIEtlaXRoIE1lbmRvemEgd3Jv
dGU6DQo+IFdoYXQgZGlkIHlvdSBkbyBiZWZvcmUgdGhlIGJ1ZyBoYXBwZW5lZD8gKFN0ZXBzIHRv
IHJlcHJvZHVjZSB5b3VyIGlzc3VlKQ0KPiAxLiBTdGFydCB3aXRoIGEgbWFpbiBicmFuY2gNCj4g
MS4gQWRkIGEgbmV3IGZpbGUgKHRlc3QueWFtbCkNCj4gMS4gZ2l0IGNoZWNrb3V0IC0tbm8tdHJh
Y2sgLWIgYnJhbmNoLTENCj4gMS4gQ29tbWl0IGEgY2hhbmdlIHRvIHRlc3QueWFtbA0KPiAxLiBn
aXQgY2hlY2tvdXQgbWFpbg0KPiAxLiBDb21taXQgYSBjaGFuZ2UgdG8gdGhlIHNhbWUgbGluZXMg
aW4gdGVzdC55YW1sIHRoYXQgd2FzIHVwZGF0ZWQgaW4gYnJhbmNoLTENCj4gMS4gZ2l0IGNoZWNr
b3V0IGJyYW5jaC0xDQo+IDEuIGdpdCBtZXJnZSBtYWluDQo+IDEuIGdpdCByZXN0b3JlIC0tc3Rh
Z2VkIC1wIHRlc3QueWFtbA0KPg0KPiBXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4
cGVjdGVkIGJlaGF2aW9yKQ0KPiBCZSBhYmxlIHRvIHNlbGVjdCB3aGljaCB1cGRhdGVzIHRvIHJl
c3RvcmUNCj4NCj4gV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KPiBU
aGUgZm9sbG93aW5nIGlzIGRpc3BsYXllZCBvbiB0aGUgY29uc29sZQ0KPiBgYGANCj4gQlVHOiBh
ZGQtcGF0Y2guYzo0OTc6IGRpZmYgc3RhcnRzIHdpdGggdW5leHBlY3RlZCBsaW5lOg0KPiAqIFVu
bWVyZ2VkIHBhdGggdGVzdC55YW1sDQo+DQo+IEFib3J0ZWQgKGNvcmUgZHVtcGVkKQ0KPiBgYGAN
Cg0KSXQgbG9va3NbMV0gbGlrZSB0aGlzIHdhcyBmaXhlZCBpbiAyOGQxMTIyZjljYSAoYWRkLXBh
dGNoOiBoYW5kbGUgIioNClVubWVyZ2VkIHBhdGgiIGxpbmVzLCAyMDIzLTAzLTA5KS5bMl0gVGhh
dCBmaXggd2FzIGluY2x1ZGVkIGluIHYyLjQxLjANCmFuZCBsYXRlci4gIFNvIG5vdCBvbiB5b3Vy
IG1haW50ZW5hbmNlIHJlbGVhc2UgKHYyLjM5LjUpLg0KDQpUaGUgYnVnIHdhcyBpbnRyb2R1Y2Vk
IGluIDIuMzcuMDoNCg0KSmVmZiBLaW5nIHdyb3RlOg0KPiBUaGFua3MsIGEgZml4IGlzIGJlbG93
LiBXaGlsZSB0aGUgZXNjYXBlLWhhdGNoIG9mIHRoZSBwZXJsIHZlcnNpb24gaXMNCj4gZ29pbmcg
YXdheSBpbiB2Mi40MCwgcGVvcGxlIGhhdmUgYmVlbiBleHBvc2VkIHRvIHRoZSBidWcgc2luY2Ug
d2UNCj4gZmxpcHBlZCB0aGUgZGVmYXVsdCBpbiB2Mi4zNy4wLg0KDQpBdCBsZWFzdCBJIHdhc27i
gJl0IGFibGUgdG8gcmVwcm9kdWNlIG9uIDIuNDguMC5yYzIgd2l0aCB0aGUgYmVsb3cuDQoNCmBg
YA0KZ2l0IGluaXQgJiYNCnRvdWNoIHRlc3QueWFtbCAmJg0KZ2l0IGFkZCB0ZXN0LnlhbWwgJiYN
CmdpdCBjb21taXQgLW1pbml0ICYmDQpnaXQgY2hlY2tvdXQgLS1uby10cmFjayAtYiBicmFuY2gt
MSAmJg0KZWNobyBzb21ldGhpbmcgPnRlc3QueWFtbCAmJg0KZ2l0IGFkZCB0ZXN0LnlhbWwgJiYN
CmdpdCBjb21taXQgLW1jaGFuZ2UgJiYNCmdpdCBjaGVja291dCBtYWluICYmDQplY2hvICdzb21l
dGhpbmcgZWxzZSAoY29uZmxpY3QpJyA+dGVzdC55YW1sICYmDQpnaXQgYWRkIHRlc3QueWFtbCAm
Jg0KZ2l0IGNvbW1pdCAtbSdjaGFuZ2UgaGVyZSB0b28nICYmDQpnaXQgY2hlY2tvdXQgYnJhbmNo
LTEgJiYNCiMgTWVyZ2UgY29uZmxpY3QNCmdpdCBtZXJnZSBtYWluDQpnaXQgcmVzdG9yZSAtLXN0
YWdlZCAtcCB0ZXN0LnlhbWwNCmBgYA0KDQrigKAgMTogQmFzZWQgb246DQoNCiAgICAgIEJVRzog
YWRkLXBhdGNoLmM6NDk4OiBkaWZmIHN0YXJ0cyB3aXRoIHVuZXhwZWN0ZWQgbGluZToNCg0K8J+U
lyAyOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
Z2l0L1pBbWZxQzlXTWwzWGV5RXJAY29yZWR1bXAuaW50cmEucGVmZi5uZXQvX187ISFHQXV4eDM4
UjZmTGIhSmhfWDlFREt1T2kwN3djTW9XZzY2Vzc5THhfNHQ4RkRUUWV1LWNvYW8xSjFvMWE1MURV
ejhjZTZNT3ZDVk1JVUhxc1AxSWFxVkIwMmRJSVRBdHk1YlA0VzVYNnZWUjBtJA0K
