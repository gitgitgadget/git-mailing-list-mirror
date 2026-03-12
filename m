Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2945313520
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318886; cv=fail; b=J2yrhSLs9Wszg9w30NVnAO+4jEDO2kCXhsiJScvuMG2iM7v8fbLKyGmWfLfJcXYD0mKgLTsDnu4RnKlCku3P2kEBewF0mn2Pijoke/K6vI3pHLEOoPGhFWm4eMPVLwUL6dGChWalJJ0LeQ5CAknfnj1J5G6eCZeKEtLSphqWoJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318886; c=relaxed/simple;
	bh=Q6cvUTRVk7tssHueqqY2ZAOBwks2rblW/xk7vGzFLoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SGlPR/97BXJsUWKEYUD0O3HwZ6CNSsQUXjd8t4TL65so4Ab7Px9i3HwI3ywDgQvliKjaeiUFJFmyier/6yguURCSLyvQXKL5UCBbMsDTN0/XJdYWnpvhXqQ2CuR++sAfl3Cgsn1l2V6b6+ezPT0lEmukKIQ6QfWlFqIAJnTOIrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=XSAo962H; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="XSAo962H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5/SnLrJiIJX/xvu6Izkojzyst1NdpO1l6CqR7o2NXfjslRPvlDoe3Rm1jHLHA6nR0MWnhz0LNPDXJNJTUnt8ry0wQz4I6PF48axSW+xKPlRyT2USEI0YNCmt6qswAhzgjtW8kRLhqeWNu1BIIlElw9TGwcNh0d2iWP5SePziYX606wEaZtCZ9th3lldYklDGJ/4w59fHb9hO9FR2O1D4QN05HT2yiHQbnhce65g8Kd9Ow1fCQ8Ai7uSRmHH4/6aUhB2iIHwxUntCkt1OHYvcNnFG1xK3jPSYjIECdoIgn6dbLbLBSI+R1KSifvUNzcPnmjyqhvbX4tR5zdrhsxGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQJs7ZhYpVNSuXLXmcCsx+OO0jdWl7GOgiOcOlBDFTc=;
 b=u92HMzHU3stQwdhVmNognVg8yHM3tKh0Tfb67koz4zjPddkDirhAEHjX1y+PZHeI1wvdqFm6OqahnkwNgnZdS4ypODTXKk0BwFBydrb+lMGaJv4uyb3SjkjGHAcgCYpDFs4Bu57MvbWuI5yL7TSYH8U/IeTobI505mhT9U83E0bHvyzo9hmMjwYjG6c9nprnFvgp5Gt2H2rKp0PopMv8sdYTtNij82f4oLbbm3XQY/GOEOX8+Y4O+8gGHNdBlkAjWF/B4VHwAhQN9kcHTJBMhvKrXjiHwnslbcN2LXBpDI1GVib0GzNjGIZkmr3Z371TIEuDot4WobHgWvAvjpPRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQJs7ZhYpVNSuXLXmcCsx+OO0jdWl7GOgiOcOlBDFTc=;
 b=XSAo962HkxmXuJ/1m8Vbn53fLlaCLwd11hGc4S5IPfHA687heXWM2PewNwmS3WzRMFNk2ff5hLJzvh8k5K4KJ0srsM2ovG2EniRe0HMJvrQ1PAcCiQ8QkSzVBM8DWHw1xx6sBd2Ql4kH7Ik/jLryhKEOr6WUtREnYjMtiazDMKQ29UCyGS5bLHDGHr768esQBmGK+jYgR/8Tvel+OLqzqaCNsQma6jHj7rEPflyOpIb2cwFVAHoDZvb32G+RnUTMvwFBwH9MZJP0CClbjY+qmvpa4Kn7M9v19OBtAQBICpSsLaSz82ydpRo4f+neR13QPCe+Sej25/hVIKq5aEayHw==
Received: from DB8SPR01MB0009.eurprd03.prod.outlook.com (2603:10a6:10:b6::14)
 by AS8PR03MB8926.eurprd03.prod.outlook.com (2603:10a6:20b:5c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 12:34:38 +0000
Received: from DB8SPR01MB0009.eurprd03.prod.outlook.com
 ([fe80::71cc:95b0:e234:77d2]) by DB8SPR01MB0009.eurprd03.prod.outlook.com
 ([fe80::71cc:95b0:e234:77d2%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 12:34:38 +0000
From: Friedli Adrian LCPF-CH <adrian.friedli@mt.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/clone: fix segfault when using --revision on some
 servers
Thread-Topic: [PATCH] builtin/clone: fix segfault when using --revision on
 some servers
Thread-Index: AQHcshyXIfUSXbXjTkWm/T1b7zGyOA==
Date: Thu, 12 Mar 2026 12:34:38 +0000
Message-ID:
 <DB8SPR01MB0009F61C462C819CDFF80ED7EA44A@DB8SPR01MB0009.eurprd03.prod.outlook.com>
References: <20260306111001.261916-1-adrian.friedli@mt.com>
 <xmqqwlzozqgb.fsf@gitster.g>
In-Reply-To: <xmqqwlzozqgb.fsf@gitster.g>
Accept-Language: en-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ActionId=057d00bd-1686-4c5d-b12d-86b3ac46162f;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=true;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2026-03-12T11:22:23Z;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8SPR01MB0009:EE_|AS8PR03MB8926:EE_
x-ms-office365-filtering-correlation-id: 7511d90f-7c9a-4c15-5d51-08de8033b9da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 bVSCzrwMBVeAdXjxpLaF/W6jJOLzMdnHnpL/nY34NyNZ9x4h0m9/EkiYiGCo7P4T0uhV1EBNbP8TzISlkd8SEHcdygFreGlA8+ISJEn6D6bgnbpCls1Wmys1P4XsWcbgg5EtY1X0dNX/7m1htvamRAfP6yZjLEYN49GEUXX5Jh9XcvEkj2KJNarM0ElNbBiDOkiRMjTKrZ9jcHO6Pt8TsdqbwRpNs104bBlY4/WRZDlDehalCNb32VinEikCjx9+nOeORXrFf0QpEBzE52WhFaZieEJ0SUPEfwtsi2KEYe4EJ4Kl/fIYUsaa4lSdKFSvz16PbP/ReH5StLnmsuwgUw9vCWh6z3PpvNUmEtD0Vu7jHUiLfQPhi7kKPFPcf7Biqj/4sOqvqWqh75pdgiwU13kVIOTAwAGyaQEI77leq9ClOrT8oeNN7BMeQlfa2iaRaE3wkp8Rxz8aNW0gr28yEAF46gqcSTl50nZoIaWwktr5l6ghX9JLvwtaJXhbpdl6Mq4l1YGjST0Jhv3OAXOQ3n9Xk+i1R1c0ZMGOXYZW+aB2jsQUg3wejcL1DKPfifSdGA34fxwP4pLwVdTPgttTZhJRDVNSFNc81ZQWa0lB9g8POrn8/bqjBXSqD8ysBtNllPdrbnlyYWYoYM8WTYTOlInFQhgNtSFknBnLftXs1h2Y1et8qhE1t7E/xOJ0Y17q5RgCSP3X6daE+BIuVOERy++jAXho2pZJsBEU9ilYgYeEx6rKT6BHYqSpAZ6O14eVRSl8rJMnDmxFANZiikN6r61rYFINy/i7fK1FgdBj708=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8SPR01MB0009.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aOMEQq10a5idtz5r6cnTIstcJolGAigNHZsJtuJezQ4/I7OF7f0Ocb4bi/73?=
 =?us-ascii?Q?jJZPxUVEeaNni/fUP8At7fzF+C0R1gh2JpQQgAtmunPKpfI9+Z0R64fHDfzJ?=
 =?us-ascii?Q?lYjVWxTD7P0O5CKILcvmxUZizNDXzVptwyM5J4HmZ7Zq8HkKABfOUz11Fx18?=
 =?us-ascii?Q?TK42xC3ArBxXPpOTxpOxnAcPT04LSjKPkIEcJQqYm+6FrqBnmfZGTnhSRf8l?=
 =?us-ascii?Q?e6vnV6EXjgEnM3s6/DlJqzx0LHDMqW5wLrIa44DNRW3/goro9KAsPYCqXwOI?=
 =?us-ascii?Q?tSqj78mImceA4skJHs9vdkyR0GKt7gMV9iusiOSIDcZydhxaSw6mofIsAQIX?=
 =?us-ascii?Q?8ezW9iaXHIkg7Rmv1b6j06vjdCMR3SPtj+8O620T107xu+CNV+mB4bF7FhH5?=
 =?us-ascii?Q?ONoui3RGyUj3B83foycIoLWw3vqbuNsvsut/uylv9bMKBBRNMioAdmEcJcXm?=
 =?us-ascii?Q?j9K82kWb+IxlugAt0c36446xGZARqfpKrlbogG1Jv2J5OX/RBIcmc7EG5C/a?=
 =?us-ascii?Q?a157Apqwl9PrESVxJwrS5DisF/tMXw5zuKZv3I0GO1XNH782P4Wz7GRHe+Aa?=
 =?us-ascii?Q?TvJ1l0liprt3ui7Um6cy4aPApiVzBtoSwnl8kxabGaGZC3MVxJl0EfDRBzyK?=
 =?us-ascii?Q?WOL3wP0xUR01v08W9yf8EtyRImVQletOGzxm6FIL72GNqWrq3Lpst/LLreWF?=
 =?us-ascii?Q?aG62oM/gbmwrUiTZFyi2hP2ZYhi4cOOjZhRoTu1eqxX2XtWlOVRUBHpcSBql?=
 =?us-ascii?Q?GHvWiBcBoOtiE49eZ5v8NUMlmchehHl+eMc4n30YuuOjUOozSk/sfSjFacTc?=
 =?us-ascii?Q?EAJRgcPfVqiTPaKo2CsmpGylBnzNaEdhu6v9FvMRUtSbKVwXWM9Y4u77tfo3?=
 =?us-ascii?Q?x0nIPNoslbI8GB7UnupTVRiaJY87F0HDdScgY94ykjGsu6fQEwdE6UUZR1rA?=
 =?us-ascii?Q?uGnEo3yDaviap4KIIayPpeKyRzheVdFx/6u9QLnQjepUZPj8PUXWjyLQSvCp?=
 =?us-ascii?Q?y0WU2jzhcQW9Qp3mUOQHjT2UIpB/wfvgqa8UjMGckI2YTRmx3HuO0wP5jdBs?=
 =?us-ascii?Q?VEwvyknAaJVCznXZ+Mg6hpsaD+mypChQKRODvSt8YAJsUFMzjzhxt7ZjZGMY?=
 =?us-ascii?Q?0K1Z/z26bqfzr3mbahi/2eGwRcIWWbN338SnX7aYJ/sM3I/ukdLSDPqDHrRf?=
 =?us-ascii?Q?AE0j9AAbP8qv/vV5kcPtpKfP6WJwLtA4Q02mOdOTxdvXXmtvtT4ulNCMR9f0?=
 =?us-ascii?Q?LtwgidmjX1zYOQ+TdYXe8473iKfvB2B5ejqr1Yqa/AH/mK7v4NcQyC4QlXcs?=
 =?us-ascii?Q?Zaiyh3O3Y8G4+JsJj/nQVrTCYKNwN8/VN3cw5xawOtkU++VBrYFmk2ttKX92?=
 =?us-ascii?Q?+uTBqNWhDnNw/iXkPxBmVylCpoG70y5MPKFzlkJKBaVRdlw0OiAAERApzAVs?=
 =?us-ascii?Q?OwR3WQdc3UPcrKs8OZ7aeRF5P/Eays2rQBskjTg0evCQiYQIoZ9Bz5e+E0xm?=
 =?us-ascii?Q?FuMMB2Xgcqu0ppb6oK+1UztZVHfWj2kyW9iTLgug7pdwxOqXdqCVtryBQvCE?=
 =?us-ascii?Q?Tx6l8uColYdIXrWWt1LQd6vXgplg4W9kvm39UCn9YfzoAhas5KHaCV6CjgmX?=
 =?us-ascii?Q?1DukGvVbj5+Vanc6BrhZU4Ux+wYwQa6bPsk2z8zGpQfBmQyND3tlRCVnbCMK?=
 =?us-ascii?Q?XPurA0dt1kYgwOQGSjPvqD93pJ1t1f+A071tUOxvNmBb1Yaf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8SPR01MB0009.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7511d90f-7c9a-4c15-5d51-08de8033b9da
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 12:34:38.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkR3rT7HBdU4JqwYm/e0q4O+wRyTp77pbctlAjZwoelueTKAaldEcjkgOQzGUvAvK8f01EFEC1Z8GdDLbg496w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8926

Hi

Thanks for your response.

> > In the bad case the server ignores
> > `transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the
> > linked list `refs` returned by `transport_get_remote_refs()` contains
> > many items, amongst others "HEAD". `remote_head` returned by
> > `find_ref_by_name()` is not NULL and `remote_head_points_at` returned
> > by `guess_remote_head()` is not NULL but its field `peer_ref` is NULL.
> > Because `remote_head_points_at` is not NULL the guard in
> > `update_remote_refs()` does not skip the affected code and
> > `remote_head_points_at->peer_ref->name` is accessed, which causes a
> > segfault later on.
>=20
> The description makes it sound more like this code is perfectly fine, and=
 the
> problem is in guess_remote_head() that reads the refs list and includes s=
uch a
> bogus thing with no peer_ref in the result of its guessing.  There are 4 =
direct
> callers to guess_remote_head() including this one---wouldn't they also ob=
tain
> a list with such a ref entry?

I traced the 3 other callers to guess_remote_head() and none of them has a
problem if peer_ref is NULL. In get_expanded_map() there is even a conditio=
n
`if (cpy->peer_ref)`, which indicates peer_ref is allowed to be NULL.

> Or is guess_remote_head() correct in that some uses of its result do not =
mind
> such a ref with no peer_ref, but only this code path wants to see a ref w=
ith
> peer_ref?  If that is the case, then shouldn't the code this patch touche=
s be
> looping over remote_head_points_at to see if there is one with a peer_ref=
 and
> use that?  The original is assuming that remote_head_points_at that is no=
t
> NULL has a valid and usable entry at the beginning of the list, but if th=
at
> assumption does not hold and we are getting multiple hits, wouldn't it be
> possible that a good entry is hidden behind a bad one in the list of refs=
?

In this path, guess_remote_head() is called without the
REMOTE_GUESS_HEAD_ALL flag, which makes it return only the most likely ref.

Kind regards,
Adrian
