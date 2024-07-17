Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021105.outbound.protection.outlook.com [52.101.62.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D54181D08
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249142; cv=fail; b=PdD/odHHwrMAjrjHELkaAodkHqa9dgnEIc3GY6MQe2aU6WAw1hIh/+2220SsCeCdl6ZX1+k9JztMytKRLKesEOT3F3JTn4QMxCN0ZUtqZj14n4TbWChbs4JxKGcSipOCHcRBxXySI2VKfXeVqGaw8QOuKfuu/OG0YwwneBzrXIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249142; c=relaxed/simple;
	bh=3q77Aw0EmVSlDeVuHU3oi7OyvJb3AIoOAY2GhCLaOxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qguuEbtPpIlHa5zi4w6eCjAE84fNIkYGvfDEPAaZl6rZaN3d+7nAm1GrjPvHGIiPToHYS6FcqDKM0CDzayNSZCslZsAUelGvZSxDbLv+ZZsA7NLtbcqT4vphqWlwLhrz4pQb82UHrswLzpz62gbMVcZZkTPB/JwPGCO3lsR6YQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PJA3mWIi; arc=fail smtp.client-ip=52.101.62.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PJA3mWIi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXDiIszgtIjH7rYFZrIioiqL/0Mv//2CKIEpyJj+dCVDXiu9pDpd7tGiQmffN2LgHRHtQ0tG77/K0W0e6qqNpRhbIAzOtGeCYgzLCqL0bPZnwShVCemqywPn5z/JX5ZmNybTtsBw7vvIjSHQ0NJjQT3/x+Qdde+4GshONTgoGtvskDoJL7vvr0FhfSmgl85Q30RNDfyNNxGmuAU0W7fH2PTJsJ4Cs78gMgHWw4FOuAWDfvfbu/83V+BK/pPGrU186BrPI/sHKu734Ij5gy6sQry/QAJiEExH20O3EdPhsiURwkPlHZliJbHZVyFONc07mXYW442XkGW/sqzYHwB6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q77Aw0EmVSlDeVuHU3oi7OyvJb3AIoOAY2GhCLaOxE=;
 b=XN6eoKAqDYatQeNKxKxk4mjITtQE1rS+yYTziThWz8G8G7cGjo9r7mAXXo0hNpwM9cn8/uaawvjmejvJyrnmoxA5O0AH7gVsf4Ex/boaesfIytiYm5QBuKSc0x+lFP08j/S/o+lxm+BY4gdnc/sSlrE96GAWIfIVZi1WJk1xE8Nb+UkVo0wau/IH65YmiBUClxuWd9aV76qQ6NfbDQHmGHO5HJ5mmquj7JQsPgOFQ9g1EX5ZMQm+jBC64hxRzoNqq//FI+knNDrUdXQ8ufeOSGm8EeQLY+QOpsAWSiv/DlYIl5bvwVqkpMx+EBn73PXCfIieDB4PTjyod1E5OjARaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q77Aw0EmVSlDeVuHU3oi7OyvJb3AIoOAY2GhCLaOxE=;
 b=PJA3mWIi37RHfpD1Trz7KzaEhpPguWfaaF5w50NpMKWDCaLHsjhZzaunxlNk660nXiRy25ELe2xE8sMbB9emQB/XqK4XrP9Vf1RtMx3qHpfc7cEB2L5uDO5x1pBPT1FVmKuIKsQGAaaU6yMkzHTV6plI0HHvZC4smQ3D9GX03zg=
Received: from DM4PR21MB3537.namprd21.prod.outlook.com (2603:10b6:8:a3::20) by
 CH3PPFCCB480946.namprd21.prod.outlook.com (2603:10b6:61f:fc00::18f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Wed, 17 Jul
 2024 20:45:27 +0000
Received: from DM4PR21MB3537.namprd21.prod.outlook.com
 ([fe80::b48c:4890:1ddf:d1dd]) by DM4PR21MB3537.namprd21.prod.outlook.com
 ([fe80::b48c:4890:1ddf:d1dd%6]) with mapi id 15.20.7807.005; Wed, 17 Jul 2024
 20:45:27 +0000
From: Jullyana Ramos <jullyana.ramos@microsoft.com>
To: Junio C Hamano <gitster@pobox.com>, peff <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: rev-list does not output commit metadata (nor
 honor --format) when --use-bitmap-index is on
Thread-Topic: [EXTERNAL] Re: rev-list does not output commit metadata (nor
 honor --format) when --use-bitmap-index is on
Thread-Index: AQHa072wM6Y7JBROdUC6cQdtw7wpV7H6ksYAgACGzC+AAE47wA==
Date: Wed, 17 Jul 2024 20:45:26 +0000
Message-ID:
 <DM4PR21MB353707D6B84334AADA816A3B85A32@DM4PR21MB3537.namprd21.prod.outlook.com>
References:
 <DM4PR21MB3537F74639094ECFA909880C85A52@DM4PR21MB3537.namprd21.prod.outlook.com>
	<20240717074418.GI547635@coredump.intra.peff.net>
 <xmqq8qy058dd.fsf@gitster.g>
In-Reply-To: <xmqq8qy058dd.fsf@gitster.g>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-17T20:45:26.756Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3537:EE_|CH3PPFCCB480946:EE_
x-ms-office365-filtering-correlation-id: 339f7852-7c2e-42ab-c9a0-08dca6a1638b
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UgLKM3cuBEEiycMWtyeaE3dngPqq8eQQKpsT/QGg6XL5Kc/OY9LWx7GPc9?=
 =?iso-8859-1?Q?pDAtGuXibw+Yqtjw+z3+X/AumNALqNm0Jnxym9S7FhOfk2uVORc+2aDScf?=
 =?iso-8859-1?Q?752SEhYbcjwg2G1hn8gPP/Q48sEHIVMUMs9DD+vhpbKoV3fIQDgHHLfiNC?=
 =?iso-8859-1?Q?OuDpruXgBNWWP++N4ZLqIjsBuEt/Cf384W49GgEyiwycW0nTm5GSpqug/Z?=
 =?iso-8859-1?Q?H2mptxwNsruDaJN4z0Ya+xi0v1tr1X/nBhy+lm2/pwSu1eU/WfPbJF6qf+?=
 =?iso-8859-1?Q?i/7RN9+pvrmK+3TZc0AvMBrIRjV3X3BsTlo3/Sc40sbsHzBxT2gPE53gsH?=
 =?iso-8859-1?Q?cNiJmuqI79jRr3grcMWJbbCzG7WFOBu0cFfhbpY1BsgWX3I2Lr6oBFsQzC?=
 =?iso-8859-1?Q?Q3oavfHoVjC01DuQaDjHS1M6HqrSYPExn44TLEhZxF5STx/Or6ey9rhv5T?=
 =?iso-8859-1?Q?ErpfFwJOhcZLzzB09QwaIc0wNidfueuGhhg7rgrzyjbm9IDLhtU5+HPNKU?=
 =?iso-8859-1?Q?intgtqAoAmOfUs6Zi+Da29KzezbSQzVQvT4OktirCX4eW65ZxuZ0+ESmV/?=
 =?iso-8859-1?Q?L3Oc6VDLiS0X5Z6cQ7ZD4sVJCWfQVOksbOmE/Qgfknz1EzNrTdudpRF5jl?=
 =?iso-8859-1?Q?lhWf4APMfCHTrVg4/rloKcY02wDitQyKCYPyjpXk25fIqKa+sZzz8VbkJF?=
 =?iso-8859-1?Q?4/4KiwbwC6hJit5mwRexYfksUZJr18408WnD3Mo3rAit9tJMklhHhIgS9K?=
 =?iso-8859-1?Q?UUQMNpEdiHB80KZzzz5Q29eo7mQPWRJTDGjpKt10uqyT14VdHsnaKQRqiM?=
 =?iso-8859-1?Q?lOAgOjQg0LjREwoHBx5l4Z/hcy/KUYRf4RxT+/76QlrBLB2gfT/UNdvae7?=
 =?iso-8859-1?Q?Ngn4TFNeT/Y1AvPrJKWs7rzT7WDshjB60QTmwGkXCrr1WYotkmBXEKm65n?=
 =?iso-8859-1?Q?Xvk3kYqUrSe2ENqg8s0LYuUXpVLCNDbt6dlIwo3L48xyhN6Vtl/SHEj5vo?=
 =?iso-8859-1?Q?JNC8alqGD2fq/GKt/Q6lMaeUCmll/SMFQhqI8IKFacKQQPhsd0BRbEEOV3?=
 =?iso-8859-1?Q?HB1clrOYCnocrwpBqEeUYSDeWb8NKGrvy3fnK+RFiwG8NlGJBFV4YaMGwQ?=
 =?iso-8859-1?Q?R/IBbn92SSfSgq7YYtmuiaJiX5ybWdD3MbsvlEsgTdfLVBTN+W4TkA0nyC?=
 =?iso-8859-1?Q?KheGljGDqzs8hY70JHuhSGXSa/gH6xTd6dhpRbWZehjBzKoBJmMGe2sNUS?=
 =?iso-8859-1?Q?w5A0LmiXXV7i5xbRR7SZ9tG5kYgVN0tzDbuYkqCYWqipaJXN6dHLdiIvDg?=
 =?iso-8859-1?Q?u8Gt7tjVjNU9RVr/maURacGURMT7qqqa8h4V4uRFqTEz4F1ID1DC4fCSbe?=
 =?iso-8859-1?Q?g66csvZ5IWo0omnWoJc6axy6Rule0cjB2+2RqPDjMsEfMCIwQRFLotOsnb?=
 =?iso-8859-1?Q?sQN8mvBLRYrdVOLLnomt4WSroWutRt8g4kFJBw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3537.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?c3ARvKi7N1jubD8b7WXwhFZ+blYrPKdLz/NFvMBlzdllBWq2wturVSt8q3?=
 =?iso-8859-1?Q?H9tRiN5UKoVOmXUfrVeN9iImuiiS/gw+tEkb4KDJDjpIyOlx0FzTjczShL?=
 =?iso-8859-1?Q?OHtfLaw1c5+ukP8XkwKPp/5b8CYIMMvFIMBgNUWB2KjQtf0NaI4aD1fLst?=
 =?iso-8859-1?Q?umIPlzv2rb3w+R8zH6mrN7I0qHdomV8LW4doX4Mi9ZGTi4oHf/MKoTVwpl?=
 =?iso-8859-1?Q?xTdTsXlGotFXDrcZhUiINYu6cGzayZWCPgaMfTM7+g5BokXRtrucylNo/8?=
 =?iso-8859-1?Q?vkbkugS6tvSVcxbI+IMkvrq3oZouyfHaWE25JpQjbiGSX8UjURsMdfBwpz?=
 =?iso-8859-1?Q?8OwqKxjyICevdmwUPL9k5LXOdzijWS9DhAl52yyGr67ou+e9U2oQ9iNw15?=
 =?iso-8859-1?Q?9WUGcanfMSkubc7jzJutTFn99r64p46LSbgLxDDaaOXkhGRjIVE7yOvMzx?=
 =?iso-8859-1?Q?hhejedvSj27B2E3HAK1FZQC5ocBuDkcupEcIfygu0sucypRTduSc2yvRJ7?=
 =?iso-8859-1?Q?NJxM0Rb/6+QgUM71HB3v+oLjNhEnAVPqVHysOV7GKQe1agyV+wfwvCGXKx?=
 =?iso-8859-1?Q?YRNaLLlbatPz6mk3kiyxNvA6kAHRU4PWAwhEzKeiyabz6sXlgn2+NzPuIT?=
 =?iso-8859-1?Q?5awiclVX5vKLc9R6vAgrspqXyUG1Kyc7j76k2HdznZJZJVm7NH7lvQDpFc?=
 =?iso-8859-1?Q?sJyg428eWHe6xqulVgUaVH+4JdOIvNe/KFRG54UWu0fJAESWAwcggsGFGc?=
 =?iso-8859-1?Q?EZokb1AeYU50Chnfz9GGHqyg4SusJ2zf3v6VNtAVQ6i9tbRZPEJKlcuNT1?=
 =?iso-8859-1?Q?+D/om5dBCpuqt4W9EHz5uBgVe002s33Mj4hcrQN/asCUsPGulHFbJv6VvL?=
 =?iso-8859-1?Q?1fwpoMSVfByCFA20Lu2C2bs6JBEd8CNP1vs8LLNaTXw322YEr4V6vNa/fJ?=
 =?iso-8859-1?Q?7Vlzjf0hWtGWMt1VRxr3h2MHzXPxkk6cIcA2Qq6jc+Aoa/dz79NJToRjNL?=
 =?iso-8859-1?Q?ZWZssq4on40sVrv4j9iLxtGUDKW9YdsS9AwKpQ66OV+47EH7BrhOOoAgSz?=
 =?iso-8859-1?Q?CohJ4rSwPdwXpPo9xakYr2PyNDzVu+tngcrJmGD0W5nIy+BIyTOo6eGmat?=
 =?iso-8859-1?Q?HTbrZfx2G93wWV/4Q48xSwqJx8B/xRBNWlO7hShcW+DtUOBHrwibGiftoa?=
 =?iso-8859-1?Q?1i4PyXnGF9DRALsG/yK9psuZRmZ/s0B0K5w7dKkBL/V4kCmcbOc6EQUyVI?=
 =?iso-8859-1?Q?eyFnxmPz2K/fJd2QX+npWBRc2EY62LzB1rNhjGKYOSm6+p9vBi70d8VAVw?=
 =?iso-8859-1?Q?7357NgIfWzB79ZagRI1Br+U2JIywqEcmViYVTJCoesB6vjYhQQLXsIH3KF?=
 =?iso-8859-1?Q?JVIQDcTIdxWBjV2Hivy+Gesv5vEUF4Zm6slPS+V+KV6FPm9eaXLEzQgoUJ?=
 =?iso-8859-1?Q?5VWTHaPSlVWEyB+HhNmWSDkKip7N0QFkL5Obhplqyd5NHHznbcUT1aGiZw?=
 =?iso-8859-1?Q?W9FqvdlpysgjLUjneESuU0Q4jNCCGtMNf2XBsPBaZDsNZKper9nh0kc1+e?=
 =?iso-8859-1?Q?RT+EZLwce3W2AFIQfrTYucGabuAoIj9VQJFUbBnhMAOYzNW8jDqPZUZvdC?=
 =?iso-8859-1?Q?Q22WvYPVb2NRYH24LxGImQKUAWtoo/c4cO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3537.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339f7852-7c2e-42ab-c9a0-08dca6a1638b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 20:45:26.9449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnwzGXua3ythZyc5SLKxhP04DU8JBLXKKT1O46ZmDW/Gm1/zf7lggHGRpDPDcE9Rw3qabM22GinOT3fHsg6IIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PPFCCB480946

I appreciate the context provided by Peff and understand now that bitmap in=
dex is not compatible with my goal.=0A=
=0A=
Experimenting again today, I might have set up the test repository wrong th=
e first time I tried with 2.3.5. Formatting likely never worked with --use-=
bitmap-index. Therefore, I can simply remove its usage from the parser I ha=
ve, as it has been broken from the beginning.=0A=
=0A=
I also agree this is a documentation issue. If rev-list docs mentioned it, =
I wouldn't have filed it as a bug. It would be extra nice if incompatible o=
ptions were better handled as Junio says.=0A=
=0A=
Thank you both for your response.=
