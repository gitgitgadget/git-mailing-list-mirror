Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795570934;
	b=jOOZsRLBkwbQ6OnF2IUpX/ZY3eQOc3VsgG/h0PgVAL+SkyIG6XG1dleQO8nC69ZpoE5s
	 OS6uOCDbBvwLoia6ocnta8j5bmwam2ShILTPAcYHyMxbxEisqGqS91m1l85UeL6M6ix44
	 6XLUXARcHwqnE2KEtfheHGboqeAb3FKQAhZsnOrsWcNK3SSkxbXka0mwI/CscztG6XYOr
	 1d5bPENQhZ0znYETZ1CZZsksfGvmSUFuaL3QjvN/bCWMSTvJob5YYiheqpp8QCHV90bfK
	 q+L1gH/xg+M+a3Wp7ytSMgP10b9cDWDsGn66WqB9h3uqOpT3N3L9NzjDKhM2pmyHjeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570934;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=v4JDGiyhCzQREmwa1g7qKxbBRiIh9ClbktEg3jFYwWY=;
	b=W1B4ay99+KZq+aJaB2kUn10cJyadM35tjyO7ojqfCaiMg5RimOawicbTql8acQBRR2lS
	 zvOTvTACwUH8x714R+V1GVjn6+7BJSFYpwfZkrSBrNP/tFFYIOaHecGXCYWTTKK32S3HY
	 s+olb7NobjluXFF7CT7M+pKFaSRUG0YAeugLZ123+/CGF1p0J/JcgzXBF3RF9m5qx3y80
	 jngOU62u1LSTkefZYPMjTFQqwNRkrAohhyLS8wZyWW5Sf2fdzadibs/t+084rxysOAntI
	 Li3dA+IiMg6O61315W9a7vHJatavhdToZaKBTsXkKRHbkTbuB188eM5M/xIS5kWtKXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LcTjj60z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.67
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89108606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89108606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LcTjj60z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3hmZS6i3wo8rED+Rdn5otW4JtXCweW+DygUYuOnvgYa4R9Ftv1HwcL/700tPut5wc0fGtalywzv9LILGNG3VIG4GronLSN6Dq3RAKkpL7rRgBdMcIxCrkRbdHx2jA8f/vbXlNHEdMt+vPi1hzZXu4yfP52B7c5GCf1/WucYdx5cMnnQRdzYckq1qvW7pxwL+AmB9oHPHpaUPxk1PsedGQoZ6ydieRP8K0PPmBCAzceNDtGi9kx6rFWHc1byucMbxjZmJXRdzu8hxidvU29wSmcGYv0ejYiSPEBkCt1UCtEQMqcEP4tzx5zSrD/Zr7YA6FyrK3FFU9vP0pOil7oTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4JDGiyhCzQREmwa1g7qKxbBRiIh9ClbktEg3jFYwWY=;
 b=QZZ7WKJ35z58KIm5PPg8DpgZRF2fPS/kIM7iW0Ru1J1R3gRINqqd5FjFoykHfPip7SQKC4TeYnAVq9fuY/K/RuZXzqcBuq2x6JkpFw6atTEGUVGbbKdZ6h+TfYKLxP5mll8Ilyq0S22ZiVDdQlIOF42rDKMqT2rbjQbVpof2/rKnwB+U2HavCxDE8FGOVeWgs7jdTckgEI3o5rrdmft/bm8QB9sy+DpqSXWQDiPGDRTQbdc7Pi74HjuAmplkinY6cr4QhYMeopzPHAg9Su5/smq8FcaePKu0xXcrWN7lypgHmvvvex0802pTvk1w4luijapQEdf0swU112bFGvw5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4JDGiyhCzQREmwa1g7qKxbBRiIh9ClbktEg3jFYwWY=;
 b=LcTjj60zM6cwQ3Bqz7zM7QkAL2IyeRpC6L9IHaBX6KgVqtFfKm/VK611dRGoQMwYYLUdwovbT3lu5GT8G/RRAaygG9auzH2Iund2teab1O0h7a8PLI2O+y/H+ehJbfeFUS2tbyCOCpH6n58tmfuIfaCT5JuE9vdRbZFqugRsUP4xy2U12BWXDf+X0iUSYXOhx5kPsC8QdmxFz3db7B4Mq6NxKnixUcx4VFj+Grq8RbaxaxS79hpEBXcVBLzMpLEiXQgX2TNT6Cn/ohNAy0Swxg47urtSSlnu0ZSDrTH4UY6G/LBBt6tPDNYA7k5hpy5C0d4VHHOSeo2MDnxaL5vnEw==
Received: from DS1PR12MB999187.namprd12.prod.outlook.com (2603:10b6:8:495::8)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 01:42:07 +0000
Received: from DS1PR12MB999187.namprd12.prod.outlook.com
 ([fe80::1c54:d255:c450:3f22]) by DS1PR12MB999187.namprd12.prod.outlook.com
 ([fe80::1c54:d255:c450:3f22%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 01:42:07 +0000
From: Adithya Chakilam <achakilam@nvidia.com>
To: Junio C Hamano <gitster@pobox.com>, Adithya Chakilam via GitGitGadget
	<gitgitgadget@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Martin Fick
	<mfick@nvidia.com>, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] repack: add --filter-to-loose to write filtered-out
 objects as loose objects
Thread-Topic: [PATCH 1/2] repack: add --filter-to-loose to write filtered-out
 objects as loose objects
Thread-Index: AQHdc7wEtFM01ce7F0y+4If7EIOG6rcuAIe8gBANnSE=
Date: Wed, 25 Nov 2026 01:42:07 +0000
Message-ID:
 <DS1PR12MB99918707F05716CE2A1F5A72DCC1432@DS1PR12MB999187.namprd12.prod.outlook.com>
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
	<4488a1534ebe7def72055ab5530d4f03177fbe52.1794607911.git.gitgitgadget@gmail.com>
 <xmqqmrrbnpk6.fsf@gitster.g>
In-Reply-To: <xmqqmrrbnpk6.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR12MB999187:EE_|MW5PR12MB5684:EE_
x-ms-office365-filtering-correlation-id: 1841db6b-00a2-491c-3e36-08df4a9550b8
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 Uu9oYlaaS8oxe7wMN0Bagh3A9Oadjbjn7AAadAZqxehNHQLIiKtJrgr3hy1UzqUA5BHMfwBM9mHPiRUeCFQYd20ZqcJlfKURSnlgEJRTT+4mY0KsZy9zskdD/hWQdXAKFXtpchDZQFPfZ27+oytP8WFqXgiDK/hBRldaI73oEL92obeipAPsIOc9uQ5p7NB7AHQ170pgCxf5OSyEixACJm/akXl6f7jUPEPbMjlVV7I4EWIMgTkP6NVrflJH19uimbTOA6pbOFEX4NvsA33oIgk6KxGJcTZGyE51lE/gyiUbRdlalm9QGD2qBUPaOHCaUr/0CH7or/5UVVIwuJ73lrh+BhUbdeuZA0mu6gd0bdn+8Vnh30AxgJzr4+CgYJG1olho3AAWS3LhIukjFcCbBpsv4GsdttGELVyX2B8EKWPs1yxuFTWF91yB++gLC7PQe0H5BcE2LaJC7OyhrB5eyIzFYZXq7SQjezZ3uvK3nePyudSRNRorOjm0ieCB4xdrcCCO3Nn6gPY+4AQ5R/0OWOB6gtbzsKuNL0WWEinCVbQ8iyiRk6cX2IgpmlzWq1BPk5ENmkxJN2PgEB71rJD5AfrumSxTDhQ3cjccgv4bn9RUwEG5f3NA5STYiXK5T68Um2iyKu56bpajwUr8ilvYDY9TzF+cxrtMGf4jUT40XIN3KTj0+EDggoGsIvcPzPZO0FGK7LPl50IIK4VMVvibssRVjjVsXQ/QMvYwPEz1TzA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR12MB999187.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?n1zz6+pJFLIEW4posYNFwABCAT0C19yvrx/iVQwtf+ap03T2+xZc2kRHjb?=
 =?iso-8859-1?Q?DBCevbNOwW5AcRViYd1+ZmkchG+BRw9g8v9hwKrG9mSVZRAUJdOjqtbfEp?=
 =?iso-8859-1?Q?EGpvEMM16k2+ht5b5tVqAxQJGxhkibRBTY504QOQSYolkw0+GXXjmiUNYN?=
 =?iso-8859-1?Q?xrlBrelgD7gr+z+uARJ4IzqyupuzaeOywbbTQ3kcasyd7SxjrCWPD1uEIF?=
 =?iso-8859-1?Q?QUe+njVLme9G2IAJQPS9kn3THAJ/NzxxgVmU79a2F/qRvEnbtayFzXXzt4?=
 =?iso-8859-1?Q?Yc6T5lAjcwtPSsj9tOn9K1HNI9foqnjgdIFWyphEuUasvjuuhcBFpyRAOe?=
 =?iso-8859-1?Q?S1PW+aGOuvcJa2Vcu3ib5ryfWrqYHmeXDIPT5yr1c+CB7TuQ1vgZRO+21z?=
 =?iso-8859-1?Q?ntj0xsJWQ81aWnP91jKriBEKXjc6guB077ea0MkcKEGp3ykPs3vAQ29pYW?=
 =?iso-8859-1?Q?RP/JZQIfIi1lnuJCEEL0cyFrLtTeZP/nFnktmiKbEVx/J9/BNLoxCuAAGe?=
 =?iso-8859-1?Q?2lRionx2daGKTyaVpDoM2ykXFWuk4ssB6EE6+Rc7nQvykXlJfXILGdGdD+?=
 =?iso-8859-1?Q?vQeQ2aHFNJa+jqJ/GYKL+u+9p6YSI6xNYP6pg6F+8PHuSvU99xMUmcX9wP?=
 =?iso-8859-1?Q?EYAFEoSPtVUaCQgQWt3FzSmj/bgXvzevte508sHOlclyjqo2JMvKzStN3R?=
 =?iso-8859-1?Q?Q92ix0bgdEg4c8OxMYQTKmmNSss/xPCb8y25R5AJGyKU5hKRZuHn1QIEUN?=
 =?iso-8859-1?Q?W6RDBGZe8gC/fYuGMEXuK1K4/8dsyFiiSlqfPqIk2xtZTup8gOH+5F02Z1?=
 =?iso-8859-1?Q?zwImDG0wdsReHF0dsZe+8SKmubXlidh2SXRuhjWiCCn+q93GcZkRYit454?=
 =?iso-8859-1?Q?Lfa8nX4aSflzL177Csq4/Vkqrv+oNoqErIRT3g0KVT0lmKiaFciwF5stsq?=
 =?iso-8859-1?Q?imtmoqjgowezIzliHRCY7EJgySpp7jvdYYTEble6ZUykFp/pQuJBxs/pEW?=
 =?iso-8859-1?Q?lIpuOpQHAkmJWX7z3Luk3bv4578OumLNuFrYsO+yFnm8pGs3X5eULQdTPl?=
 =?iso-8859-1?Q?dOOSCA7ZtRJsNoaKFQRmD1aaiwJXe7cfjG8TGMqSKx2WOrmQEXoo9biE8U?=
 =?iso-8859-1?Q?S6tDQRY194NW9Mdm87xjYFEo76AqeJi51Cqb7D87MKJUSk9BLyHrLDs5IR?=
 =?iso-8859-1?Q?I/ZE9ISuHAvqfdwR1KXJyNHe7v9IAyrPBRogB/BE18tArL1xOYFDijF9jG?=
 =?iso-8859-1?Q?A8ozZG3VJ4HgGi2WX6OvrwU/VpIvTbjJFAcbuC9rSshPnp0orEfRWq8bxX?=
 =?iso-8859-1?Q?1oloLB5huH3WM9z3JMw+B5yrnShz86ZoJo9gIKiRZBxJGYldjVNj1R/hqv?=
 =?iso-8859-1?Q?LN6YnSx3uiUfXCNbjbGB96Bmg1tV9zhSTLzd+a5rXVpit+kZUuoguklDar?=
 =?iso-8859-1?Q?PtBRmjbOlneMfvgIlrc8JT7M3jwMB/VKdya03K2qgyTmu8sjxY8NeOBAxZ?=
 =?iso-8859-1?Q?u72Lqlkitk4/32+6/Ler7VjlSoZyyNaqywcqo7KCv9wVAIgtB9Wk9hjvil?=
 =?iso-8859-1?Q?0sg7QiUAuNxdoU36J9lGaprJL7ADc3GvXR6y8U31yH4BOqJaTpUmUBhtmw?=
 =?iso-8859-1?Q?evdY/TDkpM8trzlYHHt7K/w16p9qZkE0s2XhjH17OPVaCzhZDEmG3zni9F?=
 =?iso-8859-1?Q?3TiJDcBml7E6C5hmJXScZpRwKuq6XRRG1K4Te3rqchpIYZWYvK4K+Udun8?=
 =?iso-8859-1?Q?7ILz3hPHnQZEIKEL3ZrlrZMg7EiOTn1SaO5ZtCxpYzihtw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR12MB999187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1841db6b-00a2-491c-3e36-08df4a9550b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 01:42:07.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhiYZXo/MLWRkjK5ASkdCH6u/OtK9O3AY/k7cJEgO6rFPO7VXNhncfU1AyR8ibr3vceomiHrbg7Fa+FZYtJgGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

=0A=
> > From: Adithya Chakilam <achakilam@nvidia.com>=0A=
> >=0A=
> > Some external object stores (like key-value) manage and retrieve git=0A=
> > objects individually. Although repack's --filter-to option can separate=
=0A=
> > objects from the main object store, it writes them into packs. Using=0A=
> > those objects individually then requires an additional unpacking step.=
=0A=
> >=0A=
> > Add --filter-to-loose=3D<dir> to write filtered-out objects directly as=
=0A=
> > loose objects into <dir>, treating it as an object directory. Stream=0A=
> > the filtered pack into unpack-objects instead of writing an intermediat=
e=0A=
> > pack file to disk.=0A=
> >=0A=
> > The filtered pack is built with --stdin-packs, so this initially handle=
s=0A=
> > only objects already stored in packs. Loose objects in the source=0A=
> > repository are left in place.=0A=
> =0A=
> I haven't decided whether this new feature makes sense or not, so I=0A=
> won't comment on that aspect.  Take the following review comments=0A=
> with that in mind (i.e., pretend as if I said "if we assume doing=0A=
> this makes sense, then..." before every sentence).=0A=
=0A=
Sure. To add more context, this allows large objects to be offloaded=0A=
to other repositories (possibly accessed via alternates) and not packed=0A=
to avoid the delta searching overhead incurred when packing objects.=0A=
It also makes it easier to upload individual objects to a large-object=0A=
promisor that does not implement the Git protocol, supporting=0A=
the offloading workflow described in section II.4 of the=0A=
large-object-promisors document.=0A=
=0A=
> > +--filter-to-loose=3D<dir>::=0A=
> > +     Like `--filter-to`, but treat `<dir>` as an object directory=0A=
> > +     and write the filtered out objects there as loose objects=0A=
> > +     instead of as a pack. Cannot be combined with `--filter-to`=0A=
> > +     or `--max-pack-size`. Objects already present in `<dir>` are=0A=
> > +     not rewritten. All objects are written before any existing=0A=
> > +     pack is removed.=0A=
> =0A=
> We talk about "already present in ...", so presumably we require the=0A=
> directory to exist before we run.  Have a test that ensures that=0A=
> passing a non-existing directory will make the command error out=0A=
> before doing any real work.=0A=
=0A=
Added a check and a test.=0A=
=0A=
> > diff --git a/builtin/repack.c b/builtin/repack.c=0A=
> > index 21835453c6..140a992f1b 100644=0A=
> > --- a/builtin/repack.c=0A=
> > +++ b/builtin/repack.c=0A=
> > @@ -41,7 +41,7 @@ static const char *const git_repack_usage[] =3D {=0A=
> >       N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\=
n"=0A=
> >          "[--window=3D<n>] [--depth=3D<n>] [--threads=3D<n>] [--keep-pa=
ck=3D<pack-name>]\n"=0A=
> >          "[--write-midx[=3D<mode>]] [--name-hash-version=3D<n>] [--path=
-walk]\n"=0A=
> > -        "[--filter=3D<filter-spec>] [--drop-filtered [--dry-run]]"),=
=0A=
> > +        "[--filter=3D<filter-spec> [--filter-to-loose=3D<dir>]] [--dro=
p-filtered [--dry-run]]"),=0A=
> =0A=
> The above documentation and help text consistently tell us that the=0A=
> value passed is a directory (do we use the abbreviated <dir> so=0A=
> commonly?  If not, it would make sense to spell it out, i.e.,=0A=
> <directory>, for clarity).=0A=
> =0A=
> > +             OPT_STRING(0, "filter-to-loose", &filter_to_loose, N_("di=
r"),=0A=
> > +                        N_("object directory to write filtered out obj=
ects into as loose objects")),=0A=
> =0A=
> Here, too.=0A=
=0A=
Changed it to consistently use directory.=0A=
=0A=
=0A=
> This should use OPT_FILENAME so that a "git repack" started from a=0A=
> subdirectory with a relative path to the external loose object store=0A=
> will find the directory at the correct place, I think.  Have a test=0A=
> to validate the combination to see that such a repack that was given=0A=
> a relative path to a directory find ...=0A=
> =0A=
>         mkdir extra-loose-objects &&=0A=
>         mkdir sub/dir &&=0A=
>         (=0A=
>                 cd sub/dir &&=0A=
>                 git repack --filter-to-loose=3D../../extra-loose-objects =
...=0A=
>         )=0A=
> =0A=
> the directory correct at the right place.=0A=
=0A=
Modified to use OPT_FILENAME and added a test as said.=0A=
=0A=
> > diff --git a/repack-filtered.c b/repack-filtered.c=0A=
> > index 869b9fc6e3..51c9dfeb13 100644=0A=
> > --- a/repack-filtered.c=0A=
> > +++ b/repack-filtered.c=0A=
> > @@ -29,10 +50,18 @@ int write_filtered_pack(const struct write_pack_opt=
s *opts,=0A=
> >               strvec_pushf(&cmd.args, "--keep-pack=3D%s", item->string)=
;=0A=
> >=0A=
> >       cmd.in =3D -1;=0A=
> > +     if (opts->loose)=0A=
> > +             cmd.out =3D unpack.in;=0A=
> >=0A=
> >       ret =3D start_command(&cmd);=0A=
> > -     if (ret)=0A=
> > +     if (ret) {=0A=
> > +             if (opts->loose) {=0A=
> > +                     close(unpack.in);=0A=
> =0A=
> Please double check that this is not closing the same thing twice.=0A=
> IIRC, a failing start_command() would close all file descriptors=0A=
> associated with cmd so you may have already closed unpack.in when=0A=
> start_command() gave us a failure, which presumably closed cmd.out.=0A=
=0A=
start_command did close. Thanks!=
