Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F73D69
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 05:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969381; cv=fail; b=A+hrXKeCRHtnzZiFU9ZEWx3RGqpwp8+3Fjod5R/l7Uvo+tt19lhEyagZDVx/GS/xa15I397142pz1FZMdb1Ajma6y65JHDiRZTJAqZ4MvG+9y93DniBKG4Fx4oAvsmayUPUf8dmbcZjJrnZLQ4L6oRbGqIhHrPPKL5Ptr3m67eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969381; c=relaxed/simple;
	bh=eBkLFTrU0iFbjSpr/Wzp9UFAbyYlTCFAPFXgNzFhUto=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bZ/6vhfOB5o0PUPZW9jB4Kgv1PvCcQ4Ledacel0w+2ZCHfiqxeUbNURN4+6UcZ50bWOCr/jduvmk1GkfJBSXdEEup8HbSmKJ0+h58CC2nZgk+XYAZZMdGM6jKkxt4QnXZq4YaAs5F6PepNxgt9QkwwDe186wQ+LPBvDMrINmMGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finastra.com; spf=pass smtp.mailfrom=finastra.com; dkim=pass (1024-bit key) header.d=finastra.com header.i=@finastra.com header.b=yVXfTt7I; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finastra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finastra.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=finastra.com header.i=@finastra.com header.b="yVXfTt7I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbLy/7Hd/p4kXyKCRnVKgA8MbKE9sDbi9jxdumxwc+r1ZtHRp+1QFZhzovfVJZQhSJBjrmunULzS2sxmD9b6VnFV0t1B6l4RojWzxxXBaYcFNgz1CvAdYRmFTJxHWllaPS1Ymbsgpw1GH0IWyMyde7Z00UGIDKhgwpvG9zfZU7ILn0K1pNKteD6Clx3i4gDibq7ZcVhw3/avC6+q5WKwv1Jz0bOwcLxJ4u5PGblNaw4mZ41njVxv9wN6HW5D2/DKYTs3aThmc8A6F116gVc+E9yjIE+sSwC7xIL0GFzBegc2jGr1ypV9N1dPDATfg5Co2ubFE7HNwXxaCnC18469nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBkLFTrU0iFbjSpr/Wzp9UFAbyYlTCFAPFXgNzFhUto=;
 b=q6RKnQJGDRqXYkyrdMozDNRUCdRs3HELGdscjQXdQdbsC7wSY7noQtU9zSRFzpq6NET1WJkGsQB1CShHqqB5hZjSem3+1cxWb04yZAxKixhaQRyq+OrB3bpXR3uT60dk8SKO5vGzT+57tKxeRw/y7zUeiApcdv84MARcikr66seM0gsjBoefr0JAw5aEoap/XAFQJ98Ar+TX24se08lWfT4fGBNtlGDJb3cp4FkjFJtRcmTK7sSDuqc4rNWe1bnSKtXl2ncJ1rBbB4ltPZiLaRxGOI8D0pw8SuCbCjGNM5qtePafphih94Zu2j9Rw+NZFF3dCzBCK6Nbg1TLM5FMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=finastra.com; dmarc=pass action=none header.from=finastra.com;
 dkim=pass header.d=finastra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finastra.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBkLFTrU0iFbjSpr/Wzp9UFAbyYlTCFAPFXgNzFhUto=;
 b=yVXfTt7IAsJq+RPHjCR2MqC9eVGuljpiaVyEqu+yInvbuqQRLWTWaVjx3emvsUjjwzwI48H3nJJ6tci4x+je68fBIJ04Y58XJ+r+gTaKEnDv1nW+Dc++v60WHTvZuZI0A0Sr8dDH7zY+FarU3+YpalwMaZr658+wtQFwgnawZFU=
Received: from AS1PR08MB7514.eurprd08.prod.outlook.com (2603:10a6:20b:481::9)
 by AM8PR08MB6417.eurprd08.prod.outlook.com (2603:10a6:20b:362::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 05:16:16 +0000
Received: from AS1PR08MB7514.eurprd08.prod.outlook.com
 ([fe80::9598:b025:9745:f7ff]) by AS1PR08MB7514.eurprd08.prod.outlook.com
 ([fe80::9598:b025:9745:f7ff%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 05:16:16 +0000
From: "Gibbons, Jason" <Jason.Gibbons@finastra.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: fetch-pack Unexpected disconnect issues in 2.47
Thread-Topic: fetch-pack Unexpected disconnect issues in 2.47
Thread-Index: AdsewVtHrtGI2pffR6W1/MGhqGPodw==
Date: Tue, 15 Oct 2024 05:16:16 +0000
Message-ID:
 <AS1PR08MB7514FB0AE229D34BFE66C4EF8A452@AS1PR08MB7514.eurprd08.prod.outlook.com>
Accept-Language: fr-FR, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=finastra.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR08MB7514:EE_|AM8PR08MB6417:EE_
x-ms-office365-filtering-correlation-id: 6cd6bfbe-31d1-40e5-c21c-08dcecd87ea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s+kifgLsI/P+99C7/uNGrTlRcsxyjYnjLFXqreP9unIxhOInU/Ebu3Vuzo5k?=
 =?us-ascii?Q?XjrvGCBqj0mMM+CPf4y131M4XnERbroaD42aNdSjbhImXyfTcV4wzu9gc4pb?=
 =?us-ascii?Q?gKlu6w3bfTDdyNH3IgBxUvPFnrFVg4pCm7tM2q5MmQRqbifs9TWVk/4jJXQQ?=
 =?us-ascii?Q?9gFTbRzzO4/EfzRK5QO4RrXieTQhNHr5JMoBSkIEA1nL0sNNg6lP+D9Pxe5P?=
 =?us-ascii?Q?4UKr+fb1mvUSXYXt7wZTONjE8eE8Ttcd9TFWxjaO/NJ8N1dJi0noxDYRYVMH?=
 =?us-ascii?Q?iv93/KG/lgq6KE89a/Uur6BzGbJuhUyBp4Fjdl7PRrkPdcT3a5EjVd/YSfpY?=
 =?us-ascii?Q?+w9qEo+v2W6pqmKLC9Uy5tMsixHxZA9nZOtnk390GugiIIPcKKWrYakvR6V1?=
 =?us-ascii?Q?suAgm+lPnYmG7AdZxGzcjhGMhIkoXt870YauugUL0ZW2ovGDDZG1F0of91le?=
 =?us-ascii?Q?pcPBfuz9CmcsiWF4EtuewOcMR/cKGkY/1knNj4csqeVgpmC3CRuTOZ2TrjFX?=
 =?us-ascii?Q?09ISJeMCHIn2qs8FvsUFpez/iGtS417IduXzTtmjVOjVvpPmBQVMZ1FrlXkf?=
 =?us-ascii?Q?D3GSBED98N2yx8dY+I7KRSHHYeoraLX1Ri0xznF1q8w5ghtjtZ4IZcdu9Xsm?=
 =?us-ascii?Q?bz1SExVcYu6KOGoFVmpAcqQMJUwcQlrUS/9HfFSo3OxPAvPnNoLehCxHVKqz?=
 =?us-ascii?Q?P3SC/do8n/hyYWn98Jw1AMUMHhCLeO/yRdENX6ZVVNjTI9Phm9TlYSvCuJo2?=
 =?us-ascii?Q?jJqWvolJIgOd4+jYHCOqaX536khEUfDVOZp0eAFCFbhsXsN1sbPYsgEA4Hbt?=
 =?us-ascii?Q?N3/mKDSI+ym3Cnj0H0DKT3ZCv4F1KKmDmjgaP8GJ+T4U/2nN34cGS7YpqnWM?=
 =?us-ascii?Q?jVOcSjT2lDOCc5p2l2ptrLewJi8+RqowI2mgQjVAGEI33YJEivM0gWFwjOUc?=
 =?us-ascii?Q?3K/hFA/f6jwY/c+iX8JNH8PqiVgZjgxsuvHYZOATddLY0bzEI+xoiO2FsBhx?=
 =?us-ascii?Q?qQoYuS5PC8GeRhK1hwppbIdA06AFWDPBBv52zwj90EYMZJzXl1Wc2/btCZHe?=
 =?us-ascii?Q?x2mgiYdiyN3dn+yPMzVe5VsvmMSTFZAhyVcIYVIi6FgBQoekz/Zjz1yL3Gu/?=
 =?us-ascii?Q?8Yv4mjilsemKR24CkzYvGK4cJU6PkrXq6hXADTOohPpaQs6rLtLwD/1CdY77?=
 =?us-ascii?Q?mBT360vaHiR3i4egTM1sIRY6XKbUaxJB91wiqLi+z3OLsel7cDv6fWmtIQ0i?=
 =?us-ascii?Q?EsUbuLkfLwLd0O1vXPuCE6upuLwG2x81Gi7hL7FuNnONzedjJH0+B7P5osgC?=
 =?us-ascii?Q?R28PLWQvn84KtJS5YPKY7r4ddvuao/M5pOePLRgWgR7JNg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR08MB7514.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r48Bo5AijdTkC1UogMhEZXm6NL+UkDKPg1lhUscxzuF2B7CMIUdWPvUxT+F8?=
 =?us-ascii?Q?oE7fKAdmpXjWhH4luXpbXg1ebfv21EyssWUZAhYNUb2/Fm2DCug95R4Qj5wM?=
 =?us-ascii?Q?XM/PcqT+m0bn7Mnap7Pm1uvvp4WoaffUaaqeQim4hkLOX1V36fk5er/Fqkx1?=
 =?us-ascii?Q?YMv7jw9YjA7YUWuwFqZ3Fg9uiH/dVUYOmCT75q1/09V4c+AVfKvEiripQWBV?=
 =?us-ascii?Q?aB8P4xpHu7vWkTMLajyyYA0iBR44mDl+HkbpJM5n/f/jqNpC1ptS2ehc6Rjj?=
 =?us-ascii?Q?hr1GaI0UXaBhv/uDV95V8E3Wxbt06e9OGHoE0VOnpFVkLGmixubXaMk7mUpS?=
 =?us-ascii?Q?S9ZGiG/xBMLgzEV/mVu7PTLORPONbwUn2Im73A07G07DbD2ZyjjDgpjd4954?=
 =?us-ascii?Q?/vu4T84mCdNfiZqMEbqbnPfVPklU40jxsO9p+mbvoDeY3RDW+/XBWx62XLCW?=
 =?us-ascii?Q?uwYauZQSQfJD1PNEZnYQXLz0jr7qE+XPdbMbgio4Lj6L4WIkEpfCzDO5Dzs5?=
 =?us-ascii?Q?iTpSZGOLyvsHfaUvUdctvwBDqr+CdIx+zAybKK80iih8C8yw4H/Wl0cbE1hb?=
 =?us-ascii?Q?wDnXj/DmPOUMwcdEYfk9xvDd/f4rJJGRh9XTW2nJO544Yi7iPFW8llwvibry?=
 =?us-ascii?Q?HpfMB2L8AA0KvWoPCSzZ/pMPZrGv4rQoy46eXheLSieRve0K7CSfgM78nf5O?=
 =?us-ascii?Q?0TkmlJPUNj+acKgiIHLTUE17IXLjVnzB2J4Xmzzd7KaWHMti+f5Tkl+ZXJuR?=
 =?us-ascii?Q?TjEUUCXLD5ZjEEOcxV6ITIS8Vxa85iqBzoS4Oi9+JfUbpp3bSoJ4fvM6xKJN?=
 =?us-ascii?Q?8X+iTRXJo/byhgCmKDFEz2mQYe47cEYTqPsmS0R2y04/EltAViUJkXJOtN3N?=
 =?us-ascii?Q?LjdS8JuCgl8Pbro/ZZPEtKEvu+qyNC8JqkwoKbngFMdRmipOMJ+QSDOFj8Pt?=
 =?us-ascii?Q?BQV/ATopSTWPpemm+ILtbU0OjkYgr6tAOVmM7E2sHmQluw91S72BDup61F52?=
 =?us-ascii?Q?dXfCmeik25ahnCT2XaNN69EObL8zTYd05nFhQQa6mESgSzZnbmFoDgsmgKg2?=
 =?us-ascii?Q?yeYM18XJERzZdbKjJlt/zC2dwH9EXkWzXllm7EDKpmrJJyDwl6VUg7s9q6ZB?=
 =?us-ascii?Q?hydgSezDlaL4enZD9uKGYC7cBgg23XdIGQ+nEO6k/u0dyNIEw9WdUbbPeR+S?=
 =?us-ascii?Q?RM04nNoZevffRmS5xeePnWNmKbgD/3kcwHDe3/R/i/S//dqmRNWwXZcdJ2py?=
 =?us-ascii?Q?FQksB2R8Tg8HLzDv57GEdgVpKzlw4gPpnVU58GGbnU1Mq4XZb8awF6O+1v0O?=
 =?us-ascii?Q?jnfy9bYpj5fPiJ7UX1oYb8CcGHSgkILoGQe07ipxvrrV7lckFt77ymBnfqzS?=
 =?us-ascii?Q?xWA9L4YV0cSuEcLQ3xzZCtFzTaJqw9OfDAElDvmurGYdi6/8rFyMC3xpbg/C?=
 =?us-ascii?Q?mniI/ft1iAM3CwEsU8ijapvd1E43KlWQUrL1iZx75G2s4wEe2OXebxcItYTR?=
 =?us-ascii?Q?oSYf/t0gKcyWEcUKVHwjGYmTHrOrPjI+9y7oBXx8AFGfWPjn63I/6F1Qdfch?=
 =?us-ascii?Q?Ns2h/NfnjFdRulJdCPBwxBdGW/a6dQ3UDNmSF2sMl/kZiy3+yV1MiOvVVXjF?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: finastra.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR08MB7514.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd6bfbe-31d1-40e5-c21c-08dcecd87ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 05:16:16.1228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b9b90da-3fe1-457a-b340-f1b67e1024fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAZSvezBxXCQsrBT+o/TdK4EbQXQx1BIYEMkhNSFAnsEcG9f1HUCVgENIC5wRntZo0eLQQQq3mtx8v8WWoVqLCy8BIG2qFBAtmM11gsGYb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6417

Hello

Not sure if this has already been reported, but we have noticed that for a =
large github repository with lfs enabled, we are seeing the following error=
s on fetch:

Connection to github.com closed by remote host.

03:42:26 fetch-pack: unexpected disconnect while reading sideband packet
03:42:26 fatal: early EOF
03:42:26 fatal: fetch-pack: invalid index-pack output

When we revert the git client from 2.47 to 2.46 on the fetching host, the p=
roblem vanishes, and this is systematic both across CI build/test infrastru=
cture and development PCs.

For the moment we are just rolling back to 2.46 across our infra, but this =
can be only a short-term solution of course.

Is there perhaps already a fix for this issue on the latest branch we could=
 try out?
"FINASTRA" is the trade name of the FINASTRA group of companies. This email=
 and any attachments have been scanned for known viruses using multiple sca=
nners. This email message is intended for the named recipient only. It may =
be privileged and/or confidential. If you are not the named recipient of th=
is email please notify us immediately and do not copy it or use it for any =
purpose, nor disclose its contents to any other person. This email does not=
 constitute the commencement of legal relations between you and FINASTRA. P=
lease refer to the executed contract between you and the relevant member of=
 the FINASTRA group for the identity of the contracting party with which yo=
u are dealing.
