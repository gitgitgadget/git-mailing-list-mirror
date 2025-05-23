Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F9143C69
	for <git@vger.kernel.org>; Fri, 23 May 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748037373; cv=fail; b=cw240GxxrcqeXaCjoU4cN8MrFU6gz/tFXoxlzjjpzLgbR9Kw5fq77gUc8ZWIKTQH2veAJ5Q2WvcaZxx8JBgV4TIbm5tiIYj1kg4SR5Q0gwk2vn1by7N8hZ+h2Bl4WrAFKmdafKich6cYDVuzjqU+OR3fsewQx87SIC2QWQlb9ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748037373; c=relaxed/simple;
	bh=5qXHPktrWVn3pt67gy9uFzlVCetXc7Z3V4JQNCAM0UI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JE/ku/jnxMlU+E3eG5sM84uDfzF4hoGC5ztV82J0/yvIu641s35srFvlhP0kIQtrXebYLgxuRz3JTIE+YqbRBuHsfHzPUM2SCRR93zYPGz/J9/MKk9CdrBKbyO4kKDFoeo2JfZ/QBf5ZqKh6JYhbuk8fYFLLtf9+hRQEmEbjBC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=aQwl1xVx; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="aQwl1xVx"
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NGgcKk008500;
	Fri, 23 May 2025 15:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=V
	tiK7+8Vc1zWpb4BWlwMUDgKx79D75jGbiXguyqUK/I=; b=aQwl1xVxNUjRDoG2q
	9pdqSSus7znFnakfefnQKfxpaIky4Tka2GZHYYJvSql63QKmCIXguW6joMGKlEmI
	e2l6iQdDfYR1FoG6WLBTKssVfmLSLrzq7Onf4218F+szFvd7Nt5KPeQei7AsGDfM
	CeQQIUdkAFhTSY0i7aeoOos76BGd5dF9jaUxDWXc2cA0s6zA+oX6QoD1KJoYZaOC
	+b7Il7qC+0LUKFnaNxXZE30ct29i3zVL4Ya8PiFdrfc4ENNsYZODj6HThq3YzZER
	fGgKPXMWFKbs5+Hq7reF39mUs6QQaNQkGvBqT6HwOEnPO0B76S0uGeGrnnggbOM2
	7lg5w==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 46rwfs48rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 15:36:39 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NJV6J8038097;
	Fri, 23 May 2025 15:36:38 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 46twhcsnk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 15:36:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhCe4jFDxEd6wEwebmT0oInMRxoTUN+MOy4ZCEwS2HHYWTxBMYliHml7ybTYrdLxj1uuGce1Sj3HH6qDjiS5doQfUyW/0YuxdiEYskuyL3Jkshwpv+VrMN+AhU1HiuqRaQjtcRplTT7qmjE4wwdC0NmuMNKfHw/qsYMfqrr+QA0fuEg9fEvPOOW7ArmePisSQaUYZbWOLfHu+GirePDnmRng5s1dCECxDbdZVxKdDtDWJxRjuovbehFXhaoC8ShzXXleBOGYxtFCAbMWVZt28BuTGfoeTxIoYwHNlEHtcWHy//lJz5OKoJp57OSgpHiGAbuy1HG8nfv+HWv9/k/waQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtiK7+8Vc1zWpb4BWlwMUDgKx79D75jGbiXguyqUK/I=;
 b=U+NGJdTLHvawGH6WNlVd7wf6CvAGpVznpC/NGNuPSZVp8P7qU8/d+9ekj6d5XYBqJNbp8ymuZwgQp+TYeCgNcMqVEn3L9KG3c30rg+Bn3awy6Em/rhm0Nit+rW9tmiuPP7LOzHW2HUAo8/7AbiIyuQ7IsTN2GfXsN1PYZGenX/o14YOeFRI8nHIpeWwTHG2mahyQjeZ01Yx517J3SRS5S7FItUg4dh9bMnQIPx6Z//dZ94po6jkTCu3gVw3836+TBfBrmRWO3FoCvoIKjlIF1Rhxmt3GnkQFX5WlQ2qKxrnVcGB7ZDSKhYoMzH/qZpcMVB9BWQgnYHsmcODNJOuZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from IA1PR19MB8885.namprd19.prod.outlook.com (2603:10b6:208:599::5)
 by CY8PR19MB7155.namprd19.prod.outlook.com (2603:10b6:930:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Fri, 23 May
 2025 19:36:34 +0000
Received: from IA1PR19MB8885.namprd19.prod.outlook.com
 ([fe80::d126:d275:aeaf:8b8]) by IA1PR19MB8885.namprd19.prod.outlook.com
 ([fe80::d126:d275:aeaf:8b8%7]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 19:36:34 +0000
From: "Bell, Bob (ISG)" <Robert.Bell@dell.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug Report: git show unnecessarily requires parent tree
Thread-Topic: Bug Report: git show unnecessarily requires parent tree
Thread-Index: AdvLqXsNxcn7lihQRvC1cQomkc5ZcQAXShhAAAOOM5A=
Date: Fri, 23 May 2025 19:36:34 +0000
Message-ID:
 <IA1PR19MB8885A50B6FBCDB442E6BFD338198A@IA1PR19MB8885.namprd19.prod.outlook.com>
References:
 <IA1PR19MB88859FF5C7E547010E555E7F8198A@IA1PR19MB8885.namprd19.prod.outlook.com>
 <xmqqldqnxn3w.fsf@gitster.g>
In-Reply-To: <xmqqldqnxn3w.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=656fe199-a1d0-4bbc-8f7d-1e0ce3b07646;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-05-23T18:59:50Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR19MB8885:EE_|CY8PR19MB7155:EE_
x-ms-office365-filtering-correlation-id: c1c273b3-99eb-476e-5fd0-08dd9a312093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?evGi7x3RMIreUJRjidxPzlVEed49Eu6ONGVJrCwBok1OhAnMMjRyG1NQp5Kw?=
 =?us-ascii?Q?9M4pTNVAzSW0lp/A+vMu8ASndxsAm5fGACHSPPaMX3MjfqXXwf4RhuJ1SKuL?=
 =?us-ascii?Q?g8uN6Uj748uJJ4NOZcIsJEd+53/3ynkOoKon5FpkFNhLSIGXprbMAuH+Vs3k?=
 =?us-ascii?Q?4+bz73voKJLDWAqSmWWCnWep8FUqsInXpJ0tDj7dZst73zb87j703qk3Ll2k?=
 =?us-ascii?Q?tVIqRhCeLt7NYgIxGoaOeiwmZNQFmaLpZddaHUfCCWpoZLUnxSrdGb7CFRIc?=
 =?us-ascii?Q?DRhFFdwK82w5FRao67fQ7AF4Uxbq0kyY96Kqb64qhS9GVtFFVg646eXqZWD/?=
 =?us-ascii?Q?50tXhohQDGGpuUGKiDySIhUZIuwoHKyMqZw8xqjNhbrz94W4XJ4bRYW00Nlf?=
 =?us-ascii?Q?0fkszr6E1mY4BxIvsk3hoabT8fX7br+Fq0neEdeLImD26VWrUTeYVu10M+Ig?=
 =?us-ascii?Q?eSdkyz4EZoKSF4YOhSkorzqDfLsnmdGB52YpcdMWGW6AA55TDAwzY+S4F6j6?=
 =?us-ascii?Q?l5RyaESzRlTxkwnoi7Q8B4UMPMVBKmc5GNQvcBOiZ4FZbvDxLswZCkaO7O57?=
 =?us-ascii?Q?qmyRfGb7EL35yMuNdResEzbvP98uuDvx3qnpc08bZjKAztJVKCjaHDp3QcgW?=
 =?us-ascii?Q?ATfUpCeJALJWMaB+nYyLRYp64WaL65/SBV/GMqmodHo9Y/FSeCDXcS7ewD7z?=
 =?us-ascii?Q?H33KLCFbZwgQMtA5YY0+X6L8vZ4tYqI77XV9H8lxGfMsVrfO3nuAMN+0oD7k?=
 =?us-ascii?Q?zFQNcWVzA8jRBcPrWEtm9Xr8D182ShTEFbMmwxdVE/JX+eBm4cuTj59COAoO?=
 =?us-ascii?Q?kFlkgS2On+MDj3NC8a2ym0/zLhVFCHRK5MRuqQ/eHCUW3ZUmgio2/xfjsX7s?=
 =?us-ascii?Q?AFNLn9yhbI8ycoySl2HQtbBmmK9O9wvpNaNPthxJ/qCmikZmZVeQqrHuaXeQ?=
 =?us-ascii?Q?b3NfLg4hXh7Oh040rAVl8K8lyfmPsZ/JP2LQJYydO5RExKqro7UlZtiybl6x?=
 =?us-ascii?Q?0vetetc6tAAvBVcLxqljgv6MAQJyaBVcUGuXjyfhkaAWq3qwxbdGf7u+D1sX?=
 =?us-ascii?Q?Wa8eh69RwOutgSNWjVw5VRRSvqB7+yi7k4XgsCLKWdoiTfOA8JfKUU550ji+?=
 =?us-ascii?Q?J4f1mHmj4mb9jZkfvV/bobzV+KYVNzh5cP4wGUySg5s2XFn1LmLe99yNUO2g?=
 =?us-ascii?Q?XqI0Yu7XMgY7I4txdw806u1uye/cXwfttB4VqJqm+4KKS/M0+CYHW/pY/1xo?=
 =?us-ascii?Q?8NMXRblSNhsVg3HF4kGtVOAYG9kgdTzOvmNCS6E5jptFwnDzEM+/66u4jfdY?=
 =?us-ascii?Q?FC96O1pxpcc57ZajMtDhI1lul4bmM0rh/G6Uze/srGYecmbgvvdMieYOufgM?=
 =?us-ascii?Q?bPAW7e2ZtonjIvm/nBVlnbr08b5CJK4REh9kieg6MpoTFS3Ev/S9vl0Jzy+1?=
 =?us-ascii?Q?0XhCiqiqF8gnHk55QXYw+T8csexnDDVIMItN9GbW6NkUf9uCiTFqVQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR19MB8885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZF8Aw/bPdOu/JtapuZ/ReTcLuhApjfxf6ATwQcNIbDQFN9z59eFlGwVU6Tc4?=
 =?us-ascii?Q?8sfMokyUtoucM58dWVlPa1dEofH+9ycnpDnC9X21hwbrHpJYp4aB4+kTh+kR?=
 =?us-ascii?Q?iRjIOUQtTeqcL/tibtR1ROWFM8EIs7rraFMY0FBXAsBcIpl77wHCaxRwUnv7?=
 =?us-ascii?Q?VZvYg2NuUxLoeE8NGD1cR8qFm+VjIx1LrMmPbJVWLHNXfTS1ZWoBYQ1vTYz6?=
 =?us-ascii?Q?8DfkykDVVsiCA2C3kJqflgWNzWX4y8cguxOpqYV5uH+tDKeGVpqUCuku7P3H?=
 =?us-ascii?Q?1urPnGgveQNxQ2Si8ftGEuR71p386gCXM7F6FzNgsqwW/QSY1pG1vleDaFB7?=
 =?us-ascii?Q?VryYQwBcUG6yM6HFTXKLN6Rzl5XkYdNtH742bsJhq+Dkn+jO/dOdjcwr4MTI?=
 =?us-ascii?Q?SFRltR+pYk06VL2iRecjQQAfOpCK6UcFJfKFbN9GooaypfNfzz9Ps4o5VsiF?=
 =?us-ascii?Q?QYXdA2om9K+zP40NkhgdlCgY05I2ncx5AYvmfBgToskpYobrEa5z+C9QWgOa?=
 =?us-ascii?Q?2mBF5GD6iuWZMs4VG/Oew0aTudGbkQCkUVcBn/4/aTnIaREux5jNla+jr4JQ?=
 =?us-ascii?Q?iSi42mORMlmcXWm77HsdPelgMzziEn+qx+bQvbFQ48/oDW1HF2+vnN/Kj3Nb?=
 =?us-ascii?Q?wgKNYObkACVfggmDvGHv+HITp5XlYIWI1ON94wqJx5e4nFr3quBzXpABeMuQ?=
 =?us-ascii?Q?qW0MkFIX57DPq22635Ogj3A/FHMB2JwBjhOmXaWGSnnKPlGtJj+n8hw2yC8j?=
 =?us-ascii?Q?P+E/SRWQU78JvOt+y11AL/fFd76EZsOoS7CtYB64jGlwqv/eP8BEQJ1oj9dx?=
 =?us-ascii?Q?R6dGxri6IMwDfd9tUngCeSEYusvWT0//cFIk/2fS5lvjAMQLwkWX3nnVyYqn?=
 =?us-ascii?Q?197LoV2KLeS5PDCUejB3XPbPQA65JzRvFxOdbd0fmhfj/nN6IFxCI2lUeQNM?=
 =?us-ascii?Q?QqqbcSgOyhAoMI9tbhoVHP7qi5Dt5eyvVU6mAA5E3l+Gmwscl0PRvnhW0uYY?=
 =?us-ascii?Q?nH2YVaVCU+/o2ymOKXV5SH9D2+DmCAIzgbERmPEkvdtEDODTb4Z2E1H+Gt2+?=
 =?us-ascii?Q?ZhUosxUJgRU+e2bJMnDSMwUcLDuiYtEn+BnZcEKdW/XrZ52vs4wnntYSOUGY?=
 =?us-ascii?Q?6WaDHQVehB1z9trcw4rUXBf0xQBPBEwIWUKM85R5/mLbrtIvoVehjYSFp49D?=
 =?us-ascii?Q?qYBYmMVjYxCVxVF7HQiU3ZsitreQEZfRez0EhOZdHQun7d5mnOez0vA8iTjz?=
 =?us-ascii?Q?/1jcEKpVIedHntWwPRhng4CPxMFy1ML6BdAlpd51rv2sAh9+JA4Muu8W+IKJ?=
 =?us-ascii?Q?Lon1V0uvJR/eqSUsxqK/HIWZ9Ry6uMtsxvGe/fK2ABC60PCuOmwp6WJOI/Mb?=
 =?us-ascii?Q?Zp2bfnLbPQDximolXSGFpZWzauVJcPdPkfWNnsO/8mY/A1LHBfG9HVz1v5Kd?=
 =?us-ascii?Q?TBDdTrpSUlrp1xG92jOaisz2nogEjYkYKX7xc0tiiDjobRzK6aZaXMNivaCO?=
 =?us-ascii?Q?agneYrzx9XcMYeDcXGROEKC1B6uOrbr7OXaBat2Mw5X+YhhDBU4lN04mwcIV?=
 =?us-ascii?Q?3jd9RlXbTZVTDetGSQBRJoDWgHULfIeKNZZfP65m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR19MB8885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c273b3-99eb-476e-5fd0-08dd9a312093
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 19:36:34.6750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zi5lexzpx2iD4xsoIqRdId5uoKs+B8hMAZ6JfRDTmY9jNhUveQhLegGFV44+BHm9pyChO1ArLjanhx1GRjarWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230179
X-Authority-Analysis: v=2.4 cv=Hc8UTjE8 c=1 sm=1 tr=0 ts=6830ce47 cx=c_pps a=j0++y401J6f/BxNAf5EDow==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=NbHq4juM12Voka3tbBoA:9 a=CjuIK1q_8ugA:10 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE3OSBTYWx0ZWRfXz5lCR2ogYwVq ttDxzurbgHETMLehpiW1H4Q83OjaO2KYYRV+nni41YByW+kZzG8b9KHz330jqEBHIozbpZ5QQR8 iAguk3riG8CMcyRxjLMQQ1qxn2DYr8uEfoawhvyswHM8lYRB88s9G3fRPYP3ahwQG8AJVji4bhH
 xvBIqtD8LIi/ZIkqkNZN4WMbPaneCkP/IloRJkpPaNTs9cjrLH3aH6LBZoIIc7RpX5akvuam284 ZP4DxsGHIHzQlre1PgWftYOVW7ag0CrQF5jAMcoznF/VnPa/8bEttnWnNwcBeQOzkY92Ttgudmc rRnrI4vuRN7FBgj040hKTHzw0/zVRItrOvgasA/5lxHfVMUU8GHX4ydLKBza4e9yFUnADaf8iwN
 ELXZIi8NDW38EMHDm1hAsDlBkYSCmEQ2plZ0JDiS7y949BptWsBqWU8d+lz3O/XH5WBD3Q+4
X-Proofpoint-GUID: _dHgxB5LD8yORVPTZwTs2n848Lld3Syl
X-Proofpoint-ORIG-GUID: _dHgxB5LD8yORVPTZwTs2n848Lld3Syl
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230179

> I do agree with you that "git show -s", without any other options like --=
diff-
> filter that affects the commit selection [*], should not have to look int=
o its tree.
> Unlike "git log -p", it should not have to see the tree of the commit is =
the same
> or different from the tree of the parent commit in order to decide if the
> commit should be shown.

And indeed, as noted, "git log" *without* "-p" functions fine, whereas "git
show -s" reads the tree object in regardless.  I suppose maybe that has
something to do with their respective "default states".  I believe my curre=
nt
workaround will involve using "git log" (or just downloading the trees and =
not
the blobs with "blob:none" instead).

> The fact that it gave an error "attempting to read the tree" is your own =
making
> by corrupting your repository ;-), but it is done as an easy way to demon=
strate
> the underlying issue, which is that it is suboptimal for it to try to acc=
ess the
> tree of the commit in a case where it should not have to.

Thanks.  I could have indeed kept the promisor and positioned it as "git
fetches objects it doesn't really need to fetch", but I thought displaying =
an
error was clearer.  Thanks for seeing through it to the core issue.  Indeed=
,
what I'm really wanting to do is optimize what is retrieved as much as
possible, so that I can operate at scale with minimal overhead (both locall=
y in
execution time, and load generated on our internal server).  This is really
just part of the path getting there, and it seemed worth reporting for
consideration.  I'll push past it and lurk in the background in case you de=
cide
to implement any changes. :-)

[ Apologies for any rough issues in email formatting -- I'm utilizing Outlo=
ok
from a corporate setting that isn't regularly configured for mailing lists,=
 and
doing the best with what I have right now ]

-- Bob

Internal Use - Confidential
