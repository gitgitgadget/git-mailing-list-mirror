Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022084.outbound.protection.outlook.com [40.107.193.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45D2D0274
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869306; cv=fail; b=ktQU6sUW2PDBA4hLksvZw3j+J9UGHYphNGRBEHMOdO0igvWCioi2hf5T8RS3lhXx/f7x1eunMv7CSMSBwHQ2OyUS2uf1bSeTD3Xqis5IH9Z0OKKOzW3wJZQUAPbBl68fUoaQQoo3tVNIDN4Jv1D8SZ03XAN3Qv183myXIijjXD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869306; c=relaxed/simple;
	bh=c10igA+Oe0b3RdFGfdGDSObzv/keiv+qXhbhws3dIHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pgAPbCBIJ2y5arLqhRyf6BWGGhjrMCMGyfONzIyfROm44pbHxfFzCFwBuhI+5nHbGtwyrmq2eP3SqPRiQ0OHsixwL1yRU+3lp1q4bdQ99GhNoXB+eEbGQ4xQ7lRw68hWcSJev0K4CvzOe9+2JNYje6ymlthmZe/DJIyEfE/QQhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=indexexchange.com; spf=fail smtp.mailfrom=indexexchange.com; dkim=pass (1024-bit key) header.d=indexexchange.com header.i=@indexexchange.com header.b=wwcGbeJW; arc=fail smtp.client-ip=40.107.193.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=indexexchange.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=indexexchange.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=indexexchange.com header.i=@indexexchange.com header.b="wwcGbeJW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu8YcVXecYyb2gHpxWwc4F17Qe1KkubVBC+TDMAKq7K1Xpv6RAatgOMxp0hslxpCx4tf+5MCMgxsaWzyOBKF0z86Rh8qC1G8N3eK48ahcEqHPOdl8HPZn2uGPlThpr+R1XdkBMnZ5rgtSVz3+G9RmSxZGwWKi3rS+X50kA0jJOg4wGYbONtcH0AxpnW0wFj5mYWB1GQnMOrR/UzNW+0mZrK5YtvgPjZXtW0kZw6TUfMk0pKRme6WkUYCrqDDh6zMHk3b0m2R051qSGx6PJ9cyZeoOTqL8plm6xKoUoY6huHclpAhxdrDnSpkyYDY+JCMD5VR2yKWD65OTTpUvDAoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMZtH/52gITELbnsBmcHF9cXLU48wqnu1k2NiOQBVBQ=;
 b=sFAnsg/e4EOAq+cptZPcfeazdLM84uUyhzZCoW3IGgDr7SdC69vKFGk7XkiFSYRFVYy7or9B5v8CzHwzn+UHWL9+gIXWskvxy5UlqlclnIP/NAqk7/STOZ5+bBHwU4QfZiSmNw7vWaaayDEjN7eaoVk/g3GadIVX4YFDkeCIWnIiFCYz0U+YolAFGbyVSFLKwEmslaVFGVJe3vH+iiggbZojSxc9J0Q4WMln3fgGYnTWadqlHIVseZnzumeR1m9nP5ss8/Jz8uvlrPDtzCmNl5XefChLzAyrRSysdMrpQBAwAM01Api1e62EY37KINdNhbgEHG7sdKL/hjnShNkl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=indexexchange.com; dmarc=pass action=none
 header.from=indexexchange.com; dkim=pass header.d=indexexchange.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=indexexchange.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMZtH/52gITELbnsBmcHF9cXLU48wqnu1k2NiOQBVBQ=;
 b=wwcGbeJWYb0uDafamWTiVOh5iw2Eg+L4f0EKQnpGJ7g8UKHjo96tRIuIjqeKvPM2wEFsSaXlppkjaLaNcS7FHENqzwtYdd6M2AcJFWVwon0+jQWn4aPu2q2J5Zg+7JCieJ/diS0Tm8nPlKwLCn9tzbEcwrH8B343Bi5Cp/HL2DA=
Received: from YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:47::15)
 by YT2PR01MB10260.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 13:28:21 +0000
Received: from YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ace6:e900:b8e7:dd94]) by YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ace6:e900:b8e7:dd94%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 13:28:20 +0000
From: Joe Drew <joe.drew@indexexchange.com>
To: Jeff King <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "lock file exists" when fetching in bare clone of repository
Thread-Topic: "lock file exists" when fetching in bare clone of repository
Thread-Index: AQHcEhN2fwzTQSiO/EKbIMzzkKWbq7RsD/WAgAKb+tY=
Date: Fri, 22 Aug 2025 13:28:20 +0000
Message-ID:
 <YQXPR01MB3046646D7BF687D5533B41FC9A3DA@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
References:
 <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net>
In-Reply-To: <20250820213323.GA1667633@coredump.intra.peff.net>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=indexexchange.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQXPR01MB3046:EE_|YT2PR01MB10260:EE_
x-ms-office365-filtering-correlation-id: 5837e7dc-cd04-412d-1eea-08dde17fc318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HD+kPDag5FhRl1Hr/C6s1P0dhcFYgbuCM9TumqdkA+t8/X7XJEatEcXG4P?=
 =?iso-8859-1?Q?UM8BA1Or6HOk5NSXfNJhe0pjaBAm/kFFch9DiTU1g/U6GR0pcqMiUTARK9?=
 =?iso-8859-1?Q?As8gfCRvJwAZVzWGsQyb9wabr8ugUXCqdfu0TUTla+b4j7rfx6gy4PdUFK?=
 =?iso-8859-1?Q?a4Vc+0Jy0H2EcbuZ8aDU/1h1DSOPW4ydxg9o5PZfdq0KRGJ1l91apPqxrQ?=
 =?iso-8859-1?Q?hPENKHSR9f3J9gXLN+v7IYO5MKskIZ97xOLvy1a+b/ckIMYrNhcvgwfe8P?=
 =?iso-8859-1?Q?eCRLIsNtf9kUxZ3VGOLUmGM3eGFZtwRuPWmNY1azJIrBuEJwtsrG71WSw9?=
 =?iso-8859-1?Q?pxcxMaIBbrUoOudf/rj7Fqu2Y8dMxxkW1JhaNs7DX41kELdRK6EYXPvpOO?=
 =?iso-8859-1?Q?zDoIV4zKkwGuR2DEcGMNaZ30fhAFq9VXvNOuKrI+zSY8UNuuW9eOoH7mDn?=
 =?iso-8859-1?Q?I6ph6+smnJlZudsqrqgupI+3cgFRw4E6XnK8SaQdvBeY759W6yt4bqmen/?=
 =?iso-8859-1?Q?h2O3p1ROSYQ1z1thwO4ttmiRvvNtZ7ak9E4Nm5/Yk24+TTqtw2jKBUD/Wl?=
 =?iso-8859-1?Q?p4zyZVIlsBi4vIT3RszCT603MDnx0o6/POzoFZSRvCVDKSR2kuuocvFOeO?=
 =?iso-8859-1?Q?9rQCV+cdB1uBORql4QRbD3T/zVA9kxQTdR10BLhxZiLV8ky33pKQxoXLjl?=
 =?iso-8859-1?Q?uauxkGQDFwiipCNky66o1RQLqXvevah998sdIHBLxM8JGbtLmzIFm+GHJB?=
 =?iso-8859-1?Q?qa3R4nmteyIKtiWfI4ClU5ij+2nvrcwXIWcKXb2Ine2Gn9KX8smorxb2B0?=
 =?iso-8859-1?Q?ChT3QwyLjJrvkoPIdPfPUUT/4eiYWbtLF4bgEoLjJWvP1YBBbE5aU0P28F?=
 =?iso-8859-1?Q?bmA9X0AFZgfY9JpUsp4uRY8l3wMcsDBEIhEghmTwZcOzx/A2N3wBn+1QxJ?=
 =?iso-8859-1?Q?AyJvNl4ZdQJukXWXN2d84cC/MZHkwy66NW9+XN1fsE7/8qEUsMAo/3/xpN?=
 =?iso-8859-1?Q?R2D1oOhPKrvkHMzn5SGARhy4hMfmBiuOIZlaiiDiEGkxDlDDbjuPCQftpr?=
 =?iso-8859-1?Q?srNwZRtkRoH4WpYHWEq/kRujE2F1qNEZPl1o4DXp9ocXDXiiUr/0QGWrpH?=
 =?iso-8859-1?Q?4a4+4sPm0MuJlOSwOlhDUPsb5y5cFu08mmsEi3mgSCJiNYiPEAifLrxFzx?=
 =?iso-8859-1?Q?VS9gPXdZ4DvyzMJArgUj99DLDkisHUl+1kG8lKvbCt9Sq8HR3tbsEwHYkZ?=
 =?iso-8859-1?Q?TwLqB18rkEk0OvuNdzpl7nloAqeB0dLOL/bkF7dYnErxLHMovh7ATnKlCA?=
 =?iso-8859-1?Q?+G/XbFVIJRLnmu/xxtmZ2Ug/soner/PNQpxGsZhnL0MITcjRD8iBqEsb9p?=
 =?iso-8859-1?Q?fXpMLaFdYIpQA7+xr94fBeS/uIrGnqGKkB0ttgQYL7SZDJlMPqZNYzCUiA?=
 =?iso-8859-1?Q?d6jHatj2/5bqim5g/1TlimJ0/fBwiw03SJ0wpFaPRiZBk3SsQUyOzBzvcI?=
 =?iso-8859-1?Q?TuX8HEgk6WWOW1PQM8yeg8e7alN9FKKBRkrjTC5wkfIg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CfdzURz8ycHbvXg2xeWzF8JdXOchNCmxL1PdTRQP3qwSpIlqZ8KJ7P99mN?=
 =?iso-8859-1?Q?YxBK7uVXrl8jnHIMv5XAnHB85y8gMrbB26hxq03sU5yW/rQMB9105L/IWs?=
 =?iso-8859-1?Q?JKKdWM8IGl97io4w8bL8OrU8ZOPymyVjlr0qA7RrYkeM0OLPxzlYO10cNg?=
 =?iso-8859-1?Q?D7xH5uMeUV8T1/9AAXJ8zxJT81DysX+24MH8BoffmkvZWZM5UoQ7wo8D1x?=
 =?iso-8859-1?Q?fs+sT2RDVzlZMCt1Mn0n3V2nn02nMN9gE92urmrZN6AxJhIBfZEP1B2+ot?=
 =?iso-8859-1?Q?BTPMKaH9tgKTQzDsif7KlWTyLswjaUg4k6aslqi8TtRRzDNm+JUODhji/Y?=
 =?iso-8859-1?Q?vnwtfzS0VBaT0E9bYVD/XrbNvcqRE4exKYfbflyNWJZ62n2o5rzFeOqS/q?=
 =?iso-8859-1?Q?s1cV+ivXpPDco0tfxmjH5NUaYv7fNY1m15J7LjzINk03C+1ihocXnMeBh6?=
 =?iso-8859-1?Q?j+4i7Bwwat3ZhU3v42MDSipdbmoVl/bT9AkbSRaoP7Pe+finkQ/Z3Wvckv?=
 =?iso-8859-1?Q?kG1POLUDlH5Xw56x0oghKOZ88yKw4+Al7rv93iMcyGhRfwmFwI2mnyLVGQ?=
 =?iso-8859-1?Q?6jjm4iZiLbvrAF3Ip0Q6aePM8C+YW5yaSKrEGxifahRGEDOHnkKAN3dSqv?=
 =?iso-8859-1?Q?ni3fuxOng7y2Io0KvmToc9UGlQ8xCsjls9ckjOAJxdGPGTDZZI0V5Od4Te?=
 =?iso-8859-1?Q?LZ2evg8/vn7dEy6TrT7m2vbHfZu3RDpXM7felox6XPvgVi1c2T2VECc0UF?=
 =?iso-8859-1?Q?JQDWLAn1d0/vLBGSY9Qm/q22OKWadZszpy8xBf9yHOIi2IaDg/FvVfp8rL?=
 =?iso-8859-1?Q?lkQF0ZqWht0LkzdmuIdVHEq6Is4gV0yU/asZV7hKnD8tLBAsRQfeRNQZmL?=
 =?iso-8859-1?Q?JMW7M0SazWPxneG5bYA8HEgcWv5Wy+dWmeC7K4llOJcHsvDhyAAwp7UyL2?=
 =?iso-8859-1?Q?lq8zXLJ0gX2Ga4jEQelV83Z3njSVs1myFo8xokOWJhbqYJzGw+VpMOQ6Bg?=
 =?iso-8859-1?Q?h8qVFqM9X/rLKX5jUMfZPjcIeqbbZz6hcY2lWT2BIUSrMPVuR1oUFLpv5p?=
 =?iso-8859-1?Q?Qc7ZmVj4e7l8As4+g+EmnWlW3J1yGaHVhxq2IKllooiDHAVOFtNBIZFSkd?=
 =?iso-8859-1?Q?csSRu7P6r0koASycqWimf4lOoFcJIsJtdSebnfawSwr3OMyxFGjmtmWD5j?=
 =?iso-8859-1?Q?mUnHajWIqzQ/iy+f5zyzlyDp3bdas1Tdy6t7VErIr2n/g/hfWk+fPfFmjI?=
 =?iso-8859-1?Q?tA5FbU8e1eo6Qg0KcPIocT2tRGUbbhZfTMLmrD1XhKIw+AEI2AaF/ELXlP?=
 =?iso-8859-1?Q?GHP99LJucyBdhaLTMA8F7PeShlmFJyEX/Mpk/w2/djWvDUHDFaBoGlIsJf?=
 =?iso-8859-1?Q?byZGKG9FPv9VNYDQpCpBsNoyUznubKxM/NDgwQJd0TuP+XXVzdtY5/0ZHb?=
 =?iso-8859-1?Q?dgGfFBSGdDAlrLb6GYsH7cB9R31oTeYLgDzq3CMg7mvoaFV8rQlxgBy1Pi?=
 =?iso-8859-1?Q?uWPRyqRS4rYGI8F43EPC4EzzZtekbp5WJN222he9c9YpFSQJHP4kqb8o6b?=
 =?iso-8859-1?Q?K1cIt6CRS9L8yI8QDtEKUnIOga1lE7cEsM8/VPUJU6AbnvaYBn6gS6ezRG?=
 =?iso-8859-1?Q?2ZhZG1wpFNsh77JYT3r4kY8WAuM0Q3shbk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: indexexchange.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5837e7dc-cd04-412d-1eea-08dde17fc318
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 13:28:20.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b07c0690-22b8-4366-8d8d-7b845d088e18
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sS4n7W9WAOVeHS7ygU4SIq3MOHX5VQUCWjgRXoHKyxVuaBmnSatlx/8tFm+Z5pd+bEUj2Z40IJSefiU+MCF5IS6BcVsVsbMsPfCQyrQunk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10260

> This is a wild guess, but: are there any case collisions with that
> branch name (e.g., PTV-2164 or something) in the upstream repo?

Yes, actually! The only difference is in case (ptv-2164 vs PTV-2164).

> If that is the case, you can try using the reftables backend in v2.51.0.
> It doesn't use the filesystem for its ref storage or locking. Something
> like:
>
>  git init --bare --ref-format=3Dreftable

Reftable does, in fact, solve this!

>> This error _does not_ happen in the Apple-supplied version of git:
>> `git version 2.39.5 (Apple Git-154)`, but does in 2.51.0, which I
>> installed with homebrew. (If this is a packaging error, I'll happily
>> report to homebrew.)
>
> That is definitely weird, and not something I'd expect if it's just a
> case collision. Is it possible for you to build Git from source? If so,
> and the problem happens with your build of 2.51.0 but not v2.39.5, it
> would be very enlightening to see the results of "git bisect". We can
> provide more guidance if you need with that process.

I bisected (git 2.39.5 built from source _also_ doesn't have this issue), a=
nd found the first bad commit:

0e358de64a9e014575d11ef884bfc9beb931e37f is the first bad commit
commit 0e358de64a9e014575d11ef884bfc9beb931e37f
Author: Karthik Nayak <karthik.188@gmail.com>
Date:   Mon May 19 11:58:07 2025 +0200

    fetch: use batched reference updates

    The reference updates performed as a part of 'git-fetch(1)', take place
    one at a time. For each reference update, a new transaction is created
    and committed. This is necessary to ensure we can allow individual
    updates to fail without failing the entire command. The command also
    supports an '--atomic' mode, which uses a single transaction to update
    all of the references. But this mode has an all-or-nothing approach,
    where if a single update fails, all updates would fail.

CONFIDENTIALITY NOTICE AND DISCLAIMER : This telecommunication, including a=
ny and all attachments, contains confidential information intended only for=
 the person(s) to whom it is addressed. Any dissemination, distribution, co=
pying or disclosure is strictly prohibited and is not a waiver of confident=
iality. If you have received this telecommunication in error, please notify=
 the sender immediately by return electronic mail and delete the message fr=
om your inbox and deleted items folders. This telecommunication does not co=
nstitute an express or implied agreement to conduct transactions by electro=
nic means, nor does it constitute a contract offer, a contract amendment or=
 an acceptance of a contract offer. Contract terms contained in this teleco=
mmunication are subject to legal review and the completion of formal docume=
ntation and are not binding until same is confirmed in writing and has been=
 signed by an authorized signatory.
