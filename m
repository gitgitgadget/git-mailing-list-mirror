Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2071.outbound.protection.outlook.com [40.92.50.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2C13049E
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730655210; cv=fail; b=Qd9m+qCkUJ13eFZYbp4kR3mrhwBz30rkDpon+QkBPfHAI1Nidgnpdv1ZxHyojhD++sc9iqBvec8o79AcgE0gIFxGujUeR++dc4CbmhbR0PBsCVPdyuyHOuO/ycT74hTG2EJMjiw6G7ZDut5bzVt/DCcPzeLO5yeHRZ0U0gqZeh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730655210; c=relaxed/simple;
	bh=haoC+cbICJw6AEE/HLKbX0Eq1lVMu1BYzVk4akr9u5o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mi+oFEdm3CdNen3VHz4aDbLxaRMJYFbOvmPiwK0ywkGmYgtYt+NRpOP/MK0AxHiyBCXfAMwXMSFRU+gFBJL0chHJ5cm4H+NbucnYn7ge+pwHMVQIenomwNW836zw05WgUMqv2I7LvT/CVN+WTjvpb/dY9g8Yd3c0otoPdj8zrGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=lGutP7KK; arc=fail smtp.client-ip=40.92.50.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="lGutP7KK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLd4RB975PRU9BnGEI98+QlQNnttLoANqTGkvuqQurVOnZ8FtSw/yoAvRie0YXufRJxCNQoJ3Oe+LJ4nXM1ihu5KRFfQGBjFEZduyhkVc4pJQvPiTi0olwrvrFeUSKt6YcJnsy5OJ/rOoRXVVd2wgP7uIkA/CA4gwFEqURUYBEHZAwmkoKTDRWQ6EGc8WXxIsskEMlMDxQeF7DAJenW8bqVuy6A434KWcLDEqc27//pQxVC2lHHPYcLlbZHFS8EpgOB6dg32G51PrNT/gLNk75HV1jEbnisy4L6UgJZiAfH5qHRNuJp4SZEpyekJaCTP/FU0C1FtJOEbF0zttcvslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haoC+cbICJw6AEE/HLKbX0Eq1lVMu1BYzVk4akr9u5o=;
 b=aCyCwoucZwani1DaAeiOevBRjydUE5ILqRSUwzZiLHbV0kk/KU72XTHz7SIOYr9x60Ppj9Hcf09fzoflgksYMRNUzGdc3st21Sij8y8twxru7Vg16kdOXJ9r0tXX5s6pBUIyl8ZDwcu+lRGnhGaFE8AywsjUw2qz5ycJ+k0xfc+zU9gf3x3BrWlzr6urrOl3u7EODh9NFGige+JwcHGNsMK7eE0T1nRulEzKtKXuQalTWr043co9bvqgeHCM2qLDld3JuK0XMeUXm1IpDRk8DKOC+LnqDgxrAaD6B4a2Oyr2FU6dd/S8aibCIdo/Lcg+Mp+aUJ5LV6oXHVB6j/bTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haoC+cbICJw6AEE/HLKbX0Eq1lVMu1BYzVk4akr9u5o=;
 b=lGutP7KKPVXRA91VVdcrrTlPUolD7/MGvtYLt5ml8xAP0kw+wMk9p67VQNJufZVK7bJhnjVy5aYLJgK8MBZr6wwlwU+2WUVYz1/w8R6cR1X6DwNVhSyOA3rvvg7Is3/KjgyIf0YE9nWHcgAiQIbTyZKwNHMf3zQmsvk6ANyoYmtLBkWkejMTGs6FGi4f1NKQG1QQQ5TyE+3AKFmbq2Ub7VX+9isq4n8qWqdUo1YfA+k0r+tDvdPKOGPGx29Gcwwx4q+a8MFa2qWZwcHRye4ZqOjVOBoSDUD73baHx65eXKS/XJM1FjX72pYCGRvId/I2RgjuNUOR38g0Vsp8SVlf3w==
Received: from VI1PR02MB4991.eurprd02.prod.outlook.com (2603:10a6:803:c3::13)
 by DU0PR02MB8016.eurprd02.prod.outlook.com (2603:10a6:10:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Sun, 3 Nov
 2024 17:33:24 +0000
Received: from VI1PR02MB4991.eurprd02.prod.outlook.com
 ([fe80::8485:dcea:9af2:54bb]) by VI1PR02MB4991.eurprd02.prod.outlook.com
 ([fe80::8485:dcea:9af2:54bb%4]) with mapi id 15.20.8114.028; Sun, 3 Nov 2024
 17:33:18 +0000
From: Marco Stephan <marc.stephan96@hotmail.de>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: Git revert cannot be aborted if the repository directory has been
 copied
Thread-Topic: Git revert cannot be aborted if the repository directory has
 been copied
Thread-Index: AQHbLYr3V59uWnSviEq/qZGwhvgUwrKlqrMAgAAkElk=
Date: Sun, 3 Nov 2024 17:33:17 +0000
Message-ID:
 <VI1PR02MB4991FD152D121E6775195774E6502@VI1PR02MB4991.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
 <89796e97-e5e1-4668-8b81-692579547bbf@app.fastmail.com>
In-Reply-To: <89796e97-e5e1-4668-8b81-692579547bbf@app.fastmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB4991:EE_|DU0PR02MB8016:EE_
x-ms-office365-filtering-correlation-id: 91deb54a-14c2-441b-0619-08dcfc2d9ab7
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15030799003|461199028|15080799006|19110799003|7092599003|8060799006|440099028|3412199025|102099032|56899033;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?VQ5kyGhKECCI2xZSPgXC0mRYzPgEExR8MOOhQnvv7jRlrjtsOGbtmuTW?=
 =?Windows-1252?Q?U+B50FqsbOqwkemPzlsmQ7ILkGxSukpxNB3aV3fc294QQXh3RqJD/lwP?=
 =?Windows-1252?Q?tFBk1EeeE5RCmJ9al1DNJ4r7TBKUQqrylv8C6fw2A8Ej7OKc++hliHp3?=
 =?Windows-1252?Q?VxIIAnGCW8IqQf46N8kt86fkSEzdJpW4ydk52Ccpa1mAW78Gw595ETJ+?=
 =?Windows-1252?Q?NpOchfCy29wi7z2RIEq2B+4binF8N9s7mecFAJU5ZXmc/GqCk065qh3c?=
 =?Windows-1252?Q?P/ufgludLiLDrUxlDd3wegA0biWn54ehuZy0ioNayZmabltRCrTWdroI?=
 =?Windows-1252?Q?ybEzZV4AYRc2J6kjrRF5+V+d3cFjTqcSHWVVj08FIpD6sehcMKfvk0Mz?=
 =?Windows-1252?Q?MtYWeBNZnPRw94Bg/4MRmjY0FNu0jaKUQsXWJCm+un3SYt982QOy5Gyd?=
 =?Windows-1252?Q?BuwUhdj2atUvkNmVx455J4dwEl+rXo8UijvzAL2DcZ30kkVN5dSKckHr?=
 =?Windows-1252?Q?JUN0t4lYR6Psco/Ptuz0g7SF+r01U/nLVNXXTfbCSek/H0nJ1Rh9AzCs?=
 =?Windows-1252?Q?s0VjZOrwq8BcRkHqtDDTCvBg/8wKaxy7U08skSZG2Z/9eWnlRJjMjn25?=
 =?Windows-1252?Q?4FQzWPU5qpj+QBguhYPcazOBOHU4IojnvFCOedpajjnuE6fclX9RGID5?=
 =?Windows-1252?Q?5KDEdhhWqmXN9tREBZCM8tumMUoNTSxK6KrFI+6vtsUX6gtMBer7Fk6X?=
 =?Windows-1252?Q?i+2CIA7fh6XrdtFD8w1hJLU+JFpk87ZE18Jf1R7VRTIUFwqUuHl/La/5?=
 =?Windows-1252?Q?hRQlpTRVLZv+WClycxNjupVHkxQ+coQBeJzgPII/b81jnk48xLuaeUsf?=
 =?Windows-1252?Q?GulhrRkAmiMcHvrsIfjYCnIFC27RgsDoXFQPp8BPqPNDmwmlTsHXoqAj?=
 =?Windows-1252?Q?9gHY19OzQNNYtdTv6QSdM7ooXGfSqgX1p7HZDxu4XdGTaiplRIRQFf+v?=
 =?Windows-1252?Q?56bQiwgOnR4eT22/hfRxrctXcvIFftqh8IcNCFOOdMFtcaF4n8lKW+oj?=
 =?Windows-1252?Q?ed5ZXqwZamrEY4XfIL/BaYDkRHluCulotcZI2bH1zmPPjYXb1sjPnkAP?=
 =?Windows-1252?Q?kJb9V5WKefv+Q7az8PE5Vlf4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Q2MF0M4I3cCGMpuaLFsgdbJDkcvM/QLvwQiAJaLmp0lLYDqGTuXBrjJQ?=
 =?Windows-1252?Q?5NUWZgAPNAoYUQUzSvogXBStAW58K+ah/x9YHZXp2fLyAzPXb5L6B3Ow?=
 =?Windows-1252?Q?6v26cewBg1x03I5lbEtKehe5dgl0OBoo494fjYIZTfZ8/nlrPA3G5jB6?=
 =?Windows-1252?Q?UYoxQRVbpIIpfKsOP4DhT3JAowi4Bum1aCS3twut1qTz5rXu588P94YK?=
 =?Windows-1252?Q?Ajk21c3qWE11tqfze1kbd58dEmwuF66qSunaSG7MTDFGPMsSd0QBq82V?=
 =?Windows-1252?Q?wrUpFsB0VenunahOjbGeqRsJ1T47Dv+IMnlgFFW+J0icog/wyW7SamyN?=
 =?Windows-1252?Q?cjJ8sTc0mBsJ2ykJGwxzxztxtqAvt6Wq0BODrqdIBRYXPTglbpB0r9de?=
 =?Windows-1252?Q?UbzQfRcojJ14/pAQNw7/fkENPUBEHr6BiAB6TFM3x7D+VzRexSYPNDAC?=
 =?Windows-1252?Q?xHMrzgc0/J26tUNdQk4xISpDfq2uZIaDsRVBTEzpPrzVC6bcp/CsaTt/?=
 =?Windows-1252?Q?nA4H25LCzZD7RkLENlnpMPij5PiwaH11di85eWbFbrb07g5fCaicSDhm?=
 =?Windows-1252?Q?5dvpsFPWsr/CZ1kNEEvY2/T2N//691hblllLU3qHKLTSydMVcjJ6Anbp?=
 =?Windows-1252?Q?1bm4JPIlz9erowcwLXzF3jpVdgQji9b8HVXMn2xS/5ydKv3oSLl3byrx?=
 =?Windows-1252?Q?83bBfP0hJidZl44vPZ/DqamwBzNnyxU87uR3/z/rk35LrppC8E6R/rnR?=
 =?Windows-1252?Q?druFtUt8NPnZW0Y8oLwDSQmiyb13QkMNWEq9+9TIRaiNSfy8euRS+VrD?=
 =?Windows-1252?Q?G0k11nosDONv96tTmIe7hAAU+sIZmtl21EeUU7r5E9GelnRQWySGSvnC?=
 =?Windows-1252?Q?jlmg4KSxhYJ7qy/5HF9GBDUYuCD6oFvjEad2nxVRNp9YgUy0Ot7kllFZ?=
 =?Windows-1252?Q?MvpWcL2MF3SMAfy56k9D8vq1lacJQhO89BmvV9xcFupANx5XiazWUqHO?=
 =?Windows-1252?Q?Wg77saB2Fcx/U8dK5bhjBflrQNWNckNF51xOX7sbt/4pqAJHmkRnRGg9?=
 =?Windows-1252?Q?Efy6+5tTM7mNzYqoBdzL1HROVmwNfbOWQ6vlIwA2/Rcs1OGhRnkx6irV?=
 =?Windows-1252?Q?eVrNkVRB7LftA6YLkeQrg634GSW1uFGL8MBdSfPytn3egsg9iJLpifCU?=
 =?Windows-1252?Q?kbjjlzrEUwksOXJBcWvJCK0MugRhjJ5EZTMCaIm4RfAClS5eIMawjxdM?=
 =?Windows-1252?Q?Cx6p8AYj46T0/176qrtPu7+htO+vg6MD6eZqxCHDSX/RCFzXjHl+x39l?=
 =?Windows-1252?Q?7Pf3Me9xSCfgZQ2wICgzqa9O2HgmaRmaCCY5QpQhr9loSYg4OB6/wcXY?=
 =?Windows-1252?Q?Cr3vxQoVsgPt+FSUpAC0NT2J4o0JODVPRYg=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4991.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 91deb54a-14c2-441b-0619-08dcfc2d9ab7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2024 17:33:17.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8016

On Sun, Nov 3, 2024, at 16:13, Kristoffer Haugsbakk wrote:=0A=
> Okay, I missed that `git update-index --really-refresh` previously.=0A=
> =0A=
> I=92m not a technical expert but is there a use-case here?=A0 Or did you=
=0A=
> find this by accident while doing something else?=0A=
=0A=
I stumbled upon this behavior while working on some Git scripts. For these,=
 I've prepared template repositories which I then copy and run the scripts =
on. This specific scenario in which I want to abort a revert in progress is=
, so far, the only scenario where this copying causes problems. All other G=
it commands I've used seem to simply ignore it or "refresh the index" on th=
eir own. For example, "git cherry-pick --abort" does not run into this prob=
lems for me.=
