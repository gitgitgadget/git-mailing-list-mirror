Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0A1CAB3
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361980; cv=fail; b=DR09q1E6a9pX3wMTIwNpbueKG4dcZix5gXgTAvKK7Zdux/qs6zTAtzbiYzlcXhuMR3FJm6jkAEpnb/LT69I++QwZzJGAXGWwGJ2YlQejuTbPZ1o6PJi0uY81L0rHhmy7BVyceTZGARqp5nO4BV23DdSG24o063exKwiLY3GnLOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361980; c=relaxed/simple;
	bh=/PWQ2JRO09sU+GIuc0A75XlkvS/U3O51T2+DXkfQBjM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/Syfcev02rgCnc33TpUX1jzQ0O73lMojZuRBHJjsPjwKKR0MFzmuXkLaUrs7VgYDVRpT1VPlI4xAD6HRfAfD+ulbTVqyIvGA3xH6SGU8Mcj4wTe4N7qNXeU9h1iQC2KtXYA2Wf/YAOM2dgdJ9i/6i4x0LTEYboGU/BjWBroILc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=IRgf5FhQ; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="IRgf5FhQ"
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLticY001665
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=7
	CQ8T9TtMnPV3pRT6uEzj4qdf1PtMT4uPpdTCalLoKQ=; b=IRgf5FhQG1tMpYpVB
	Jbrdnei0K+baaoJh5xal0Wmc5QIQH8SHH0bfWYx7aub42PZuQPlCktJRCwYywhdb
	8nxY3Uy6v34o0n2nibJsCEfsJ+Kku553DkYGIPvdxW75aFkACOyHIBWnrK2oCflo
	EcHzOApjQgVtMB0i4NUU+rCrM1FJP2vapVNUXM36tXt+jdZCsWkncnb0/+OGUh7K
	dlTAoANz0MvZVWBzxZtPm6SZ/kkL1I09Pqb3Z4rm9rHglv/mvQK1Ve7QTXiXC5Kl
	LVdPTuu987YileQsLKeHKd9pT6w6lWXOu9Z/WejoyQYj8YFJ7hDIo0IriAOTfIas
	EYWIg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 48q8taw2q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:03:06 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RNlvZL003762
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:03:06 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 48tc0k0p2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:03:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGQOb8xBIdoJOedzY9QQEK16tyBZHJN8h2T3WMfyyVdKDuEwQbOWX+4E6KjvgcxziCBYrLEeY5kbI+xp3fHI9nnTP3/6/++GPvCrxFfDV+GZXbfcYtM+e5C7E07Ah1SBYdWtCQKVvUHEV4VOO9Fvcfxpkaplj0AmqqymayvbTO9Kshovc8PUEoxBC9StF85US6m0a5Lk/p76yZxmb343FqGMVpAAV0BHP0FADKNS3+nPPwaNq8nGBNkpVFxDLwNlQVUOd/ei+LP6hSBGYZyrdiYs/Ps4vavC2h+sSOPQRYiE2+0wzmk9fs1MCrjffeWOWUnqhR44o8TfYZQtjIfW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CQ8T9TtMnPV3pRT6uEzj4qdf1PtMT4uPpdTCalLoKQ=;
 b=kqxA+4cw565GD4kxc5ZQOh+r6TLbEFbNbQUe6H66eo9bgxo/Og/4hgKiIXeDIzj9Xz3qTxylDQvA8MTGOOuDUbcbpiZsHp8/SVfkaaWUmN9k5xA9ue6o6Gf2iNlj1dSkLow62ggtWB9wDoEztP3IcZvW9tgPjB9eLK8P+Rt22rneUvYGofOD4CUhKyjWcbgrGzioLZQDdVtUMD735Xt7I+r8KzVCRfYvXs560y3aLZSiX51wNqaTOOC+RP5z6hqCLkGPV5teYOljSjJDDXDvGYHQQPfWLDsTMNsQfI45gfplkhX7ld6FFMSxzD6BfR/rGSpc/t/O+rrLma/y4CWqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from PH7PR19MB6591.namprd19.prod.outlook.com (2603:10b6:510:1b2::11)
 by DS7PR19MB6421.namprd19.prod.outlook.com (2603:10b6:8:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 28 Aug
 2025 01:03:00 +0000
Received: from PH7PR19MB6591.namprd19.prod.outlook.com
 ([fe80::90:9624:dcec:ebe3]) by PH7PR19MB6591.namprd19.prod.outlook.com
 ([fe80::90:9624:dcec:ebe3%7]) with mapi id 15.20.9052.021; Thu, 28 Aug 2025
 01:02:59 +0000
From: "Tuttle, James" <James.Tuttle@dell.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git's deprecated "whatchanged"
Thread-Topic: git's deprecated "whatchanged"
Thread-Index: AdwXgNBZQVtYfJT1RjygNHiN1pjYDgANm8FQ
Date: Thu, 28 Aug 2025 01:02:59 +0000
Message-ID:
 <PH7PR19MB659184A1AAA269C4EE3150F0E23BA@PH7PR19MB6591.namprd19.prod.outlook.com>
References:
 <PH7PR19MB6591085AFE5AC1EF22E8F242E238A@PH7PR19MB6591.namprd19.prod.outlook.com>
In-Reply-To:
 <PH7PR19MB6591085AFE5AC1EF22E8F242E238A@PH7PR19MB6591.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-08-27T18:31:08.0000000Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB6591:EE_|DS7PR19MB6421:EE_
x-ms-office365-filtering-correlation-id: 2937d844-adaa-472a-973d-08dde5cea1d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8kSIlZWwfnQG5UYy3shcsE2VjG2qWM3VPX8yPu/dUtQVjWOWaIHB73kWc2?=
 =?iso-8859-1?Q?zFeY00JYlKp7hkWJIUBIwNnHFpXUmgk7uk9Tq32JcCtKN1NJSw7rfqlx9V?=
 =?iso-8859-1?Q?4AvsheHrqx/QVQ9ZNKDxT4YzbwGViDNxz416nt5KETfVdKeHdFuVvsgRRf?=
 =?iso-8859-1?Q?NK6CQ0jzKHRBJCYwl4z1g3OY+GzkIp4KXkOaQ6hC0Ppf7bfUPFTH+fu/yK?=
 =?iso-8859-1?Q?joilXBBXurF65qOy+dtWTsqW2UxnKoFMvoDIcWdHicMX6A4t9DuhzBOohF?=
 =?iso-8859-1?Q?klk1XJCjxnnobaiaCDGJoKhp8bK4WlkoVHhGzmLONcJ2HwOHDyuyK/WqDs?=
 =?iso-8859-1?Q?FPEMsrjTXv16ItqeWlow5di0d4pfULKfBieSCSlz0iVIzKj5i2hxajkDfP?=
 =?iso-8859-1?Q?2HgAxBS+jsUZrXOtzSGY9idRgn8LxoRTr6FjJpUNRlgn8mP+cfey6m6UnE?=
 =?iso-8859-1?Q?kH48FpCX9+bKALpsec/vO2ux/iFA6MoE5y1jhowk4kogHhaTnOC0Zuh8Ee?=
 =?iso-8859-1?Q?nJF8GDuyPfluK+24/Q4R2iVXiNytTKXKo79A8rcZNuIL0qgMcfd8JdJyCa?=
 =?iso-8859-1?Q?jpuBzMW29H+9qIgRgJeIt3Ui7ttlBm8a9LYtxaMn5Qi75rTAxLaoUmMeKL?=
 =?iso-8859-1?Q?DGSM7SCSMkzuFbev2ucLIcP8wtdQDZzmpQp/f1lY6MQr6g7qa9p27MRaru?=
 =?iso-8859-1?Q?m9oVRxMUuv9KpR/Ek140g0aHr3pakVc1uIwPIBnNdcwzBoxHSnr8v88ftn?=
 =?iso-8859-1?Q?WlTtIKlnBwkbR7+b8SPROxXNX68mgw8o5d+Fk01R7ZEV0whMQUZt/ga1B/?=
 =?iso-8859-1?Q?FZ+1fHbyFv+y73xHZ970blFGtAZ8vJCG5ns8MdorXqjDKzfs1rswt6mNzv?=
 =?iso-8859-1?Q?erJnqSbiA4zvSPjPbY+W+F8eIaQLin/L/94UqUXdQanLUn3418dctFagEl?=
 =?iso-8859-1?Q?co1iowSg8ZT2AlTt3nOIMnFBATbbB996U9sC9/QapE2UULF+80W5cTqbMV?=
 =?iso-8859-1?Q?IBaJP1YQ04GsFUui91yPK6+vefjnQu9avBH3/nwyectyelu5uKTKawrcXz?=
 =?iso-8859-1?Q?GsTcApG9w0t8W80PcpYNUH253b6B0l2YWjCjGrJTAsfj0QEz/u2DfpoY8S?=
 =?iso-8859-1?Q?bPXJAEycvqciEfUvdYNoFy9k7QzYksb1i6RuDmicYCA7Kv/ag12zbsZrE7?=
 =?iso-8859-1?Q?cjdzPZQb9U9DZzikKUP4Nfkj9PKVLYj3RwkPhLIYWGcSnmLEb5BIMvxWak?=
 =?iso-8859-1?Q?794p6KZRvNR5NhOTRP7gWbHv330xvHrkTpuADhJvKAulI2oUjGEHN6Qlqs?=
 =?iso-8859-1?Q?sqjzbnnu05wWKGGpCFIJ94YKHAXCVvrG2bbGMmqSmatdcBBXpm8l/JRd0W?=
 =?iso-8859-1?Q?kPI0ZXgKUaD7C58aCbVJB8i4CUogANvjwHH6NR7c+HrsEhitADrkZBzOWZ?=
 =?iso-8859-1?Q?kSQ8kBB9bH8pzd9SQqVeLkc/+7gWlYNrER54ZZMdUI7sJNKGMwMVRl8B+0?=
 =?iso-8859-1?Q?g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB6591.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HWOXhPSn1Y/zR6p32cXfGlLiPbszxN94ibp4RyZz1Z7MtWzoFXOhimrHwp?=
 =?iso-8859-1?Q?4Y3uzNzzNn0EEO3svMRWZw/Q07F3I7w8xJrv4EITAjAVSKBec8boav6XN4?=
 =?iso-8859-1?Q?xPhbwErADdiljH27PSbgI3xj969gjRMiO+nFT0cRcdydJ6mRUw8SEUUKmZ?=
 =?iso-8859-1?Q?bWbYOXTqUM2tfEog3s8nT9ZN5ItBvxTPKTD23HXR84rmzzLM032MBlDLHp?=
 =?iso-8859-1?Q?hcQ1dgCQ4R99hpfDUCoC3bw1/u2e60HQGKhC0cxnAOMXsFUywlw1hU9SSC?=
 =?iso-8859-1?Q?WeS1mNsg7SIUlXCFEzNtM+4FUSEZMRp31r2ZVqnGJmshUnlq4pGFA4OvyO?=
 =?iso-8859-1?Q?lsyEsug8huLFG4R+qM8BpizL5SaUyXsLqodYzeQeEVD3I41JvfjYCvvwUI?=
 =?iso-8859-1?Q?vOCERvvqHDIFjBSsMJ8yxjTl0mKdOZggDIJLs9HcZ0C0rFJewJtVcda08l?=
 =?iso-8859-1?Q?73Q2LYZPTM1BryE+Nr1orWW+rd4Hhy773/c5jQdy9UtZS8wq6/5bW+n8j5?=
 =?iso-8859-1?Q?5LmGxSBP8/zlIX84GkhU44Hd8WvY1qkS6oegPTnnr7P6QzWZELUVYl2yQO?=
 =?iso-8859-1?Q?LkCy+E5o09m+NHg8SLqY3wsCNNrWoGO9rmpIbu7j1+3jpUU/AGE4HAxfj/?=
 =?iso-8859-1?Q?4JILcEuLeTI2hKPwhyc5vM+hgq2BiAWxX0E0pl1ajE8id/008h5VJ0v4TJ?=
 =?iso-8859-1?Q?TvhuzbsB5OImbTVDPHywBYY3rAMzx5RkobHbYEf9CAZwMPGCLx+C+qoizp?=
 =?iso-8859-1?Q?4ARFiZfd6RUMzUBM8yTFsNT1aKhzegOhvtgqV+EAyF1IbKgujM9OBKwUjG?=
 =?iso-8859-1?Q?f2viNOAIt4ItbnZop0UQr5mZeInt6fXOtphhKmt+F4vXjhSYGuvIgb7jcZ?=
 =?iso-8859-1?Q?UCuKzjA64DOxHPCSC2W3L65sh+HWRosRhS6KggBUXNckiZm34mBV6KWw3Q?=
 =?iso-8859-1?Q?yuPXl3lEZ69tusKh082kb+sHRIQeqBCmZP1Jolv42U8+e9PdyOcDtnPTPG?=
 =?iso-8859-1?Q?1EBTtMb67sUC8hBdJRUPt7uZ76GkgJvrVBnTPoPjdLT9yxxPAEzcAXwZiZ?=
 =?iso-8859-1?Q?Zalx3g/6SE4lhjaZ4GDZEq+z3FHesl78R4egzW/Fct1uwAaMlaVD7msWvy?=
 =?iso-8859-1?Q?cuh7lDT3eYtUCchz3TVrQvv+e8fJenplHMQaie329xKp1EALkOj9esmE9A?=
 =?iso-8859-1?Q?VIeVUJXGPAqmPLFuV+PZnEFVkBVIEZcDT4VeW8/z0Y6H8XhGwX9O3NxiQn?=
 =?iso-8859-1?Q?tTXQ4hm7Ra1mBETVsE3eFSTbBS0cO2WbrBmolknrNHDGEqx9e48Z9oUJxW?=
 =?iso-8859-1?Q?lnAlYaPu6u4qxEnyq693ZszTPqQILacHYuMDkN0/Pcc8CCGcP8lPryuARZ?=
 =?iso-8859-1?Q?3krO9o+PKTXA80Ljzia4T9QedXNvW8fgfDWi8pCh+7/ETVR6wEQfuvJRVc?=
 =?iso-8859-1?Q?6Vfru7DNHrunIvQ1BFN5tyyu2UtPAP9BRkXTByHhzVlGL3gk7gL5VHhRYS?=
 =?iso-8859-1?Q?kQrh6KXsTdlLhE6BxdSCXyICWBVyXeBW71mrGe3EyPlpNEXKwtVUkXIPwj?=
 =?iso-8859-1?Q?Qx7DIBnVflnmA+LyJp+1Pi31jPsia9OmXKkwxnAUtuCcGrdtjqGjQXPUUK?=
 =?iso-8859-1?Q?tEv5JIqAvt+xzXVDrTpzPR9CY5W0haHZew?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6591.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2937d844-adaa-472a-973d-08dde5cea1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 01:02:59.7463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUaGRDQbovxlbgdnBM9iVsqogCPK766yDue9+0r5lf3fXvMGlWn0tnXl/MtlH30+AnvoZ7Avl2u4amiISl6ftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270203
X-Proofpoint-GUID: Qi6u0P4NEE_62wXhfRBA45yBexM3GdNN
X-Proofpoint-ORIG-GUID: Qi6u0P4NEE_62wXhfRBA45yBexM3GdNN
X-Authority-Analysis: v=2.4 cv=A5BsP7WG c=1 sm=1 tr=0 ts=68afaaca cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=yNOCVISOAAAA:8 a=VwQbUJbxAAAA:8 a=DDZAw9DPrN8ighyKwD4A:9
 a=wPNLvfGTeEIA:10 a=gbU3OgOOxF9bX48Letew:22 a=ex6F9IZXtSSSYc4M0WQF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDIwMiBTYWx0ZWRfX2T9F2wOAkB3P
 VlF0s0JRTRtvjr+/MzViMJTVyUMS8xit8NvZMhwzeZDR7udMAEK9Vux6wn6mgMAYgA0uCPWShbw
 62/4pSTy04clUosWmqBiQwpfr3bdb1K5ISfIuimd4CoDkiNzY/KYqF6PyF0T1pQaArnWIPjsHWr
 bVCewZYavfLuexLPQsB4PS+pZ3606zQ9qZ2JSL/wnIbNcRm2rG+fi9+N1ZFmNfdCLyv1/cB8t04
 iJncoI4HvjtkjFutMj+R3p6lZFSXy5X9j6yRpTrcDNqm/EV7WHAVocxtrxobTnWk9gRWUZ8NFwd
 lkonxFqSRuWktEP94B4fWONsTL3JnLM2FY1zEHx5qvC3OxbcCvX5QtRA9YfA4azC5pDvITs+rr6
 Aevu2uw8
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260202

All of my Jenkins pipelines on build nodes with git version "2.51.0.windows=
.1" are running into this error.  Please consider restoring this functional=
ity.  This is apparently fixed in https://issues.jenkins.io/browse/JENKINS-=
76017 but we can't upgrade that Git client plugin yet.



2025-08-27 14:28:57   > git rev-list --no-walk fc8ec6fba03810f0cd26ea762d3b=
17931d82bca9 # timeout=3D10
2025-08-27 14:28:57  'git whatchanged' is nominated for removal.
2025-08-27 14:28:57  If you still use this command, please add an extra
2025-08-27 14:28:57  option, '--i-still-use-this', on the command line
2025-08-27 14:28:57  and let us know you still use it by sending an e-mail
2025-08-27 14:28:57  to <mailto:git@vger.kernel.org>.  Thanks.
2025-08-27 14:28:57  fatal: refusing to run without --i-still-use-this
2025-08-27 14:28:57  ERROR: Unable to retrieve changeset



Internal Use - Confidential
