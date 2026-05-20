Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F52FFDE3
	for <git@vger.kernel.org>; Wed, 20 May 2026 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260435; cv=fail; b=MCQKZD8FmR+NCwkLVaMc6qljNIimF7uThR2Te0pZWMPLJat2F0CiXJ1P8tFA1kawGC221OBMNPi4prQtTNXMFwmj7Se1hv3f+Go/mPym3acU5XlTq9m+bKnVsNaEfncxw/olQfn53ScnqNW9LGRcNRY/j5pHbqdygxr1VM8QolM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260435; c=relaxed/simple;
	bh=yGlIapkyRGKETvvz2YKRz0m0HxrXu22kNQmksEJGJXU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bf8OfUpe3cX8V/rjRPUaX7s/YyBBR3kYfABZEmGjXWikqMim/3HOIlm42LO4h5Pkd26szSGgYfpVxg5gDtjcfBpS3jotU8jd6YiCUTTuk9tSBq5VRLGAfCgq1XKNzuo+3FMNwnnqL0B/WncC7+ExD8lWzUqSmgJY8zsDxb/a7us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lqsKufbD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q0GdfIWP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqsKufbD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q0GdfIWP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JKeIeG1130981;
	Wed, 20 May 2026 07:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yGlIapkyRGKETvvz2Y
	KRz0m0HxrXu22kNQmksEJGJXU=; b=lqsKufbDGvGAsUzfOgS07l8B32lVsDem7b
	EsNkrJhvKkykPH/lTHNZP2lSIYafS5XoKLqpRjYRfGKH9tW6hYFN9wPjvsHJE6/G
	zJ7Tj0ajmIpFIMU4N9PbPHgcQrFpQGotky2PQHQitukhCMdWWDovJ1YtMLHpVx6/
	VsdqtPq0QRJGxiEGfzVzisKJxzxj188q3sF4TFizNwPTL0pImC9DvfX++F6pLRfS
	BbEySVy91SYqapE4oDNCFX1zgJQvtvDecYwPqp5e0tzlbsi17GgWTIH1WyRUT/j9
	9f8Go8hljGF+7DEkWamemHViLvNGFiJt+cx0eYLhAaq1QIG+OHJQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gxwxa0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 07:00:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64K6xxV8006349;
	Wed, 20 May 2026 07:00:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e84ed9fkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 07:00:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHxn6DqnelZdb52i71jPWQk8KnFMvfW+7QX42qKZM6mp2MwFqoe7QSV1GqoRYwwvA9y0sMFeQABe3Qi+RrMMqCW5Ugj7RVCSTSzSVQlBLUaIULLL+TIBfa/pqcH6viwDMKnC1b8CbqqRr12lnzPLnSIEnzIajhvJDDbOkix4ykokXSuS31oI64+5mfR9aYj+j2J3AwoBNSoDCZGWpeQEO7u++TeIfT8u7gSlOnCjm7nYhcEWZQy8DXUUllLAScSLdNa4gZjfh6ONnvxUY1E7vV2yU95E4eH4SyN2H8YlEtIAUwfMwKJgBW4V24ssgL1UMoXAAYD6CXEg8kNltPd0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGlIapkyRGKETvvz2YKRz0m0HxrXu22kNQmksEJGJXU=;
 b=P68s6+hU9L7qlN2/HrFvW6S96/m/NfDU1yTH1TAzuMcUkVaGKplq9bCqR74IFIfayZ3+pd4JlrOde/1InhsyPZY1SKm3TwIk6Hm4SlT+oh0zsAitBi+JuCJ49LTKaoXqCnJYstszZQV8jmwVMO6y7Ors0cQVQiXT0UTdlCJ8jItSfA2fOGJyHI3LPEj33NAGp1kA0+P31tMEt0ffzDkZNMOSdgjbqxviVfvj0oxXKRMTrYoJBN4QCbRyhYvkmhOvyavma7eYnijT4sVpeblz+vXN/ONL6EwkitK2+VdefGcBLCNqiUTaDbYnITeWdTWSkDmRFwy0uldJJMfRg15f5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGlIapkyRGKETvvz2YKRz0m0HxrXu22kNQmksEJGJXU=;
 b=Q0GdfIWPREs8Sxjz/DpZKZWQtnEvKC9ZZJY/iC1utd23jH5sgRgoibS8JaTNiI4ENV/ka9hxhUOupqFzf1swk36Uy9pUhQapKQ/78tZqkUHNaC5gNL/kc7wpP3sCeluOl74Zg7xiRu7A41+vJIe0h4YQ+k+0ahP+n1YN8HOMQfY=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 IA3PR10MB8348.namprd10.prod.outlook.com (2603:10b6:208:581::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.21; Wed, 20 May 2026 07:00:24 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:00:24 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gitster@pobox.com" <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com"
	<newren@gmail.com>, "ps@pks.im" <ps@pks.im>,
        "code@khaugsbakk.name"
	<code@khaugsbakk.name>
Subject: Re: [PATCH 1/9] Documentation/git-range-diff: add missing notes
 options in synopsis
Thread-Topic: [PATCH 1/9] Documentation/git-range-diff: add missing notes
 options in synopsis
Thread-Index: AQHc6CZUSzCioMry7UOB0k0HI4vulg==
Date: Wed, 20 May 2026 07:00:24 +0000
Message-ID: <b3958381907244ca06a39e2fc116eec113a6bc85.camel@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
		<290fe06d81e956253d3a06fc1e16848e0b86b603.1779207350.git.siddh.raman.pant@oracle.com>
	 <87v7cjq7vc.fsf@gitster.g>
In-Reply-To: <87v7cjq7vc.fsf@gitster.g>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|IA3PR10MB8348:EE_
x-ms-office365-filtering-correlation-id: cc72edec-0dd4-4f44-30ac-08deb63d7771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|6049299003|1800799024|38070700021|4053099003|18002099003|22082099003|56012099003|4143699003|5023799004;
x-microsoft-antispam-message-info:
 AerNMKcV+EMlD7PqJt5l+3PvIa8P9IIesuCu/Wvv6w2aB+xxsysSWzMvsqTazc3sqcmqm3nH1ZD6ISuvZ1ft+O6DQeaTpIL59jWJ0QsEW20BwSezG3g2/TzwO/rXQBCFM+J2TL+fHAtahuw3imCPW9hcZAeMPht5b19PUPjC+THDT0iYdi2bmB4SwAx+Tb50B9zxE1i5fLbmvVJU+EMlPSIS8sveE8356RGOEQXuepLiPAp2btmk0A2DcmeoBu9b54BDkDqZIqF2MiCiaNUsjD9qYaPSvHz/VV6x6BvAS8bgf6wApNkwbJxk9wylVKSDzGKcYtdszXAbsdQtSjSq/b04TvXoWZWZKkSqFwrjM7BbLd8DMuOpzc+oPEzj+j922IGomtelpyfARJooCcCla8LJGR3B7eCVyqqmOYjQFqK8aWvASCXisEXS68yJoJZashYBrBfcmtIq4XtNxK4MueGPfdPwXd3zRbjJNd++3GzaocUQdT9JEdNoqOotCwKcEeHnVFGs9LlHxl/1d83nBu71H9iO73V6cQTrgw5+j1H5cptZsMpFJiriaMGvMsYwu0sfdbyktjXkN09DTUzEO2xuarct57Z6J+wFq6t/TqpX8qu9ENzhCMxVPNPEl/GN1biJsapNJpiQOJ633zGQIp3vcGV+ji0xjeW2ctcrDtIbTuUFdmVRD3FCel5AXvGvRf18VzE3IU8WmMrEbQjye90r/PJ1WYBr0dIFh29AE8Nctq3ljRyHPuyQ8R/YYA0Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(6049299003)(1800799024)(38070700021)(4053099003)(18002099003)(22082099003)(56012099003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjZMWXdKcUJtRkliVFNtdEQ5QjV1VXZZaTBRNHV1S3VCWk9KZHIwTGladElK?=
 =?utf-8?B?aHd5Q010K0dBZHBoTjF6YzFCR1hxUytUMFBmU3ZGcGFxSGtLNzVjc2dKb3FI?=
 =?utf-8?B?SFBldStrNjNjWWNmOEwybGFFT0JLSWxCeWU2Z2hMM1R1VlNRNk1qVDZKakxM?=
 =?utf-8?B?WGhKMG5paHhHQW1vRVJxem5rOEE5RnEzWHZ6VVNwam9haDV1d1lHanI2Y2ZN?=
 =?utf-8?B?bjhodXJHd0Q4dmt3dHpVcm9CWktoQ3BKdWtBOGZGbi9vMi9BbXF6dkNHM09E?=
 =?utf-8?B?UWdkOVZZeWNUSHplY1dna1c4V1VNMk1TeHJTbGw0Z3ZOMWk5QXhOczQ3RTJC?=
 =?utf-8?B?Z0xlRDN4aVVKVm42VzdHV0F2UkxUa2J5YUZDWE82ODJYbng3L0Vja2FZT1Qy?=
 =?utf-8?B?U09PWXkzNkZCVGhYM296Q0padUdrcEh1ajR6NGlBN0NvamRyYVRKNHN5c2V4?=
 =?utf-8?B?NFBYbTdMclhpRkMxbG1LWFRQZHNsV3VNN1o1S0JERlNTZ3ZCZnh0ZTRtYi81?=
 =?utf-8?B?ZGNUUGxYV1laZHlWSmF4VW53UG5iSkJ5SzdnRlpFZHJRL1JoeWVKbGRwMG90?=
 =?utf-8?B?bExrd2ZUbkxoRGRpQkwxQlVzd0s2bGVmZ0FNaCtVM09zeEpoei9DUFB2U2g4?=
 =?utf-8?B?TnJvQng0QlR3KzJtRWJ5bmdiSjRyeGFiRVZuRXl0b05zRTBnL2NhQlNqaUNQ?=
 =?utf-8?B?WW9oS25rSXp1ektKWDNxUHNNVFUwYTFOTVN3b0VodjV1Snc5eGNIZlpvUDNn?=
 =?utf-8?B?cjVzQm5KU3ZQMyswYkJBQzBsQWJvT1JsWUw4MnJFdFcvQy9tWkZhYUdIZEdy?=
 =?utf-8?B?YnY2Q0ZyRkovQmo4Y1pDdlJJenlvNTdJV0ZqMEJ0YnJvN0NVcXZ4WmM2UlJ4?=
 =?utf-8?B?cmZBUWxCYnk3d2dUVWFnakNyeFBaSnJKMEdiNmlpWTVxaGZWL0dFK3JzZktK?=
 =?utf-8?B?K25neUxlWUFoZXhMUlVyMDhCQUtuZmZ4WGRkeUxCdzVRTkJWZ3V1V1VBaTVt?=
 =?utf-8?B?WGlKMzVZK1drVzQ2eVBpM244MmRJZ1p2ckFBZU9vNWhhbGlzOU9CdnhsczE5?=
 =?utf-8?B?RThNRFFtcnU1UTkraHlEcWo3eVNTTCtoV3dTcCt6TUd4WmlHYU1RWms3Qng1?=
 =?utf-8?B?b2hieHhkenZvVk9WVG1EcGRjUHVVeHQ5YS9kRURTWU9aUjIzcmJBMjd6dDlp?=
 =?utf-8?B?cUxENVd1N2RaRUNpK1N2ZUpyWEtlMUFpSEV0dERrZ2E0YTFscDQzWDJMRm5R?=
 =?utf-8?B?OTJvMTNXbUlKVGo1SUtKQlIyZFFMdVh6ZXdhSlBkeXI2UUNVOE5qdUJXRVEv?=
 =?utf-8?B?eVlxWUFVakpnb0ZLQmxoMDE3L1o3MTR6V1lhdVI4cVBtSDRxejNPSVc2d0hs?=
 =?utf-8?B?RU82Q3RENzdDaHdkbjZIbU5JZTZieFBHakZpa2ZRTmV0RVVCQXphbmtuSVMx?=
 =?utf-8?B?NHlYRVpVK2tQOEJGTlppQitJQjZQL3FKWG1BNDgzQytHbkJpZTRQRGxaU1dS?=
 =?utf-8?B?Z3NMa3U3SXIrZUFqSVJsYStyZmY0TVI3S0h4VllxNXp6SGhMR29iTmxhUmUv?=
 =?utf-8?B?ZHorWjYrQWdDVWR3NU5OSDMrNDEraXlaSFdaVVMxYVNDMDdpaEdaTUJCeGM1?=
 =?utf-8?B?T1NhVDdnZTVENlgwZXdWTGczZnFxNWV5ajlTQ1drZHEra3VaNFpJWi81TE0v?=
 =?utf-8?B?cjRVc3UxVXA4R1lTRjBWYm5yQjczQW56Q2cxU1VOVCtEWjNTWWFXd2FSYVBF?=
 =?utf-8?B?QXprTGUzeDd3VWVWVTVjdlZFQ2YzeElXVWZXWDlZc3RHNU14WVVoN1NaTUN5?=
 =?utf-8?B?R1d5bjY2ZURuRXFOMXh0N3YzY2NiZzV1V1dMc29MdFo2NTk2dmZ1andlR1pm?=
 =?utf-8?B?RlErekZoZkc1WjhpdnNWZ3BGUDlCUTRNd2t0bGtROUtkUTg5bnQxQXkyUTRz?=
 =?utf-8?B?cW1qdVlIamFmaTN2Y29UTjQyVFkrTy9BMEZyeW9sK2VsZUkvajZ1NTdWbnoy?=
 =?utf-8?B?b1IvaG9RVnZNNG84dk5PbWwyWW8yRjlWY3FLeFhBVU5lZEdmOEVsRUFpOTJt?=
 =?utf-8?B?WXZ1NEZaRWdDKzU0OTFvZHUrcFpPUUNXQmJ1WXJiZEt0ZDZKUnhMbUxkWktl?=
 =?utf-8?B?S1ZHTVh0K1RHd0Nyekg2d2grcVZnT2d6RnBoVTM5bTVJajdoVkFwTWFJQXY3?=
 =?utf-8?B?SlIzRm1xTDVJaVBFak1TUXFSSUNycXhybkdHU0VBUzNILzdRaThTVm5kRWhN?=
 =?utf-8?B?cENUVnZYR2s1Y203SGRtM0piZ1g3YzcrUmFTalhhcmVaTCtyVEpOeEZzMUpR?=
 =?utf-8?B?djZNYm1rZytvNCtURitLS1JSMFlwMXpxUXRBWnJxdWo1OUdINVZlbnU0a1hK?=
 =?utf-8?Q?yB1Z8jLaFLZI9q8WIYaRfCFobN4xb4A9h0gg773jIhjZ6?=
x-ms-exchange-antispam-messagedata-1: WmH6mav6/ivWYbMVN5Eaen8XwR6CreQgJp4=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-fzLsGmHtC/zyipySNMB0"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	M8M9MAvKmzm3Lt0wPhmYdqnRArXhgOJBT37pZbIIajth0m6MW9X3iUkaK5G1Olu9GrygUlR9jZmhHWY1J9YiAua83xLCW21X7UIQysErvgoNm7KePeK4bzDeLPbMRxDPyzlP15bY6duh7d1w/t79BVWjww8NrXShagnCz6gVVBEB9VCcSuUrA5LQAIa2QkDPYhy2133xp10eT8jhE9UA40HHcc8FLXB9CgVzL1yUZ6Cug0vtMBrlOC2fTMgcvBC6woHjEXf0SBIKxGAUkPbChpn4bN0DOwRWPMmpna4ZPaSzhIbwDUczqxx8Lvf82IQvKuX3dfvBj4F2WB8e0Mj1LQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pchs/F9SqMf+CJFtXHyCKWoLm38LFGOlW25IoVezlBGcLBPs9Fl43sOXCqIPGlVy6c6dtGrF0xgubmaQrizyCvGKdy7hvJzwcIFPnw47//8BE9Slj7TD57xbt73t+xWsjK9yQw9+L8eLPmPH1cg4NE6WbcwsoMt1ESEFHfvu+/OiV6myeg+3+lgPw5zAzVPlkKZuT9z7fycxIqqEanUWSb+hdfdFDwgI9BcWTAvb/AyT2a29Avrgt4JBLDAHDd1Dswe+moY2RbdHnj5V8MpHPHgx7UdSRwl1+NTWhocadCTenFCdkLX+JEhxEN9hb3nGO/uVGfY3CGdpcUMul1I2J5Xqdg7021llxo6XV4zS02wFB9rn8obQnhGDHMsI2ZIsginHbWtqBlz/WlqhQ5OV9LN4EI1f2KPpQ869dxtoB++RBcz+uKc2J/xWx0J7shqesDfC0q2miI3Ez97HTVXQuzFMxqWa1aT96cvaA0l0cK4SjxpuQeFKLSosWofgTTj/W6dk8pvbRaP/UKnfwNPbhHkgNokr67NDIikF22vuABjL8kigkkdSX4myhLERevG7GGR0aijQqpR8IRJOtnp604D7+cxkCotG1R4rJm3Oo9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc72edec-0dd4-4f44-30ac-08deb63d7771
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 07:00:24.6065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Quj+YTACTyEnOFy/IlTIwfiD0tCt+PWWJ7UyDnwjESVUD5YMVhVVRIIdaitpohTEJUc/3pfMSWLN/bkeUZuuE+f48amcAdK3wfhDx5zpvGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605200066
X-Authority-Analysis: v=2.4 cv=UOjt2ify c=1 sm=1 tr=0 ts=6a0d5c0d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=0qRgU2gH0vvi6B5XrMsA:9 a=QEXdDO2ut3YA:10 a=u88raNGhP0IA:10
 a=t6_P5sEEAPgOVo4s6TwA:9 a=FfaGCDsud1wA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Proofpoint-ORIG-GUID: woc7kJd1AqkeAA9hOGHUZtyCgiogWqp8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NSBTYWx0ZWRfX3rfBN7mTT/bO
 gqtCesJP2e+mlDUKQenOxH6djcjIVpHpxQ6kzpfST1kQo/usaCAdKQYC2nhJH4kDBY+t/e+1grK
 mXVk+4yfCXX92PalEh7Cbs4NaQ4kxSyv68tjva+1UpsbbmYc3fbULTAT4eH3RWT5cf8ftfLUsHD
 e0dcqHyOfAlwVnZGCnirwfuwQkRS0p47vjx1Ab4XGE2X2uno4txoXffWAVPtms58oKwvmWKZbHf
 by7e3HX2AsqHEbQatdHRo3dzFDdyHfCPNnxwHfcC9Jd7xXZ5JG+0X/wBOpkM3aU37DiseWWQpH/
 f6kSFk+KigREHddKm42BbC+6xcBPU0+cgRk/xOUJPUPmmIBEn/uCMozrrbgnUrkAfPloxVH/ZGC
 xWbVjUiAWCcouCWKh2Lk2t1YBgE58W7lFEdFTa3qTl/8KTgjZ3Y88zGoIYW2MzdF6r3fmDLyCz3
 cjq0NSW1HyygEPtp9OCXfkIWGY1MQJBa6hDJDzaA=
X-Proofpoint-GUID: woc7kJd1AqkeAA9hOGHUZtyCgiogWqp8

--=-fzLsGmHtC/zyipySNMB0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20 2026 at 05:17:51 +0530, Junio C Hamano wrote:
> This has nothing to do with "external notes" topic, no?

Yeah, but since I added the command line flag I found it doesn't
mention the existing flags.

Fixing it in the "external notes" commit would be bad, so I put it
before that, since it also then provides a logical place to add new
flags.

Thanks,
Siddh

--=-fzLsGmHtC/zyipySNMB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoNW/4ACgkQBwq/MEwk
8iq6nQ/8CFRfleg4fRv+/ynK7xamZRlGojz1iGgXnkjWxRHHUsRELfSeMlnGJdoh
lE8jnMOJXckVyWy9nClhMZ+smXBhVExwpblt+UuPkForzh+O5Sy6dobkSrS6Em/7
4S9Xm9pYSzPcdbm8O2IOPfsaAimq/9kHarzultjGe0N/WBA9yKZK0qB94yMadRwN
wzU26jqiXGWjmvnd4nL47XclNvFBSwmLIQjyC42/iC+E2Wf84W09Y0yZ1qpRwabf
n3Zn/Q5vD2mO8PJzuLxUJt4FdXZcS0Jc02COGP1WBoYeHNTgqirz0vZWNFukH5nR
oBm9lZf5On3L4us4rJGzWO080hcGPGoNvIHVR78DYkqzM0istX+y3sGcCtgO47m5
Z2XXob9uNpKbrFoQ2xPZuqgUe2bFFa1SWTqiLK0URiZhPmGjBH5wXkFbRmOLbmZP
9pbm7JFFTWqGnPWG7jERcUTVbo2G2EVD6mrJDlHGM/GhQRxKQjU+FaunehnLAiNO
Tba3CnccTqubMdk9482VGgoupAc+BeMdLNbZUHCFvnoy5Sawa6g6u7gCnYTK2I+k
LNuJ8tR5ZQXCZF06W8mJynFVQR3qf4otg2NkeAqxz8MzhQ4KLyyRc90e8ejxAoQR
MVQG/sOPXUXG8baz67IU4fUu8+sdUTK8xUDiEKLF2Pcy3Ww0Gi0=
=O15k
-----END PGP SIGNATURE-----

--=-fzLsGmHtC/zyipySNMB0--
