Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11010038.outbound.protection.outlook.com [52.101.150.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADE213E8A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527079; cv=fail; b=mCLPO20Vug7U7psyBT3glJQHrrCplWkGKuVEFAPzNpwPXyj4fGny8ePsbmwr1/bawTOBrxRQFIWjZMfgTsqIyB/tCqVOAHco9X1GyKZze94ZqbKe4XhQ9TjXjLcXwsObsMpGKpP4zpbjpU1S2G9nJ8lgu+thl5oGVB0vtsjJGNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527079; c=relaxed/simple;
	bh=/FLkQkvajc7qAhBglQIMP0MrRWCEiCUthkmx7yuoRv8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hgfhxho/hV4O/Ae6NTi4yib3hKL3C9+MvrWLeHI/zDpbA5B/Zx/YeTS5PDIm3XHmRKck5pKC9uDVPcgGw/nynxxCvDi71adah1w0fHwyxaVZYsUMqSEO8W4dZLwGcU5bTjrUHmr50Ceg4hHdMveiG1EqbCaWqUzERrXWCL+k8eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wisetechglobal.com; spf=pass smtp.mailfrom=wisetechglobal.com; dkim=pass (2048-bit key) header.d=wisetechglobal.com header.i=@wisetechglobal.com header.b=RwJ8Gtqb; arc=fail smtp.client-ip=52.101.150.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wisetechglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wisetechglobal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wisetechglobal.com header.i=@wisetechglobal.com header.b="RwJ8Gtqb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOsi08Al4g5WL0WspHisZVrRvT3c6h3CjMeXTaARqFGXIgAzMI4/fMyA2fzo2BSaLJhnnXIyYCdhOZ9i4Pdv/rTgCK9Soet5ea0yNAtxgrN0C+E9JeI/lBT9qCE+0aAaUdTuSfsi1dJ2cG4rkltx+quOGvMPaMb7fUH6j9/JaVdlqxzJ7UjRqO6TQ8Ggs4gG0kaTIL79Ks+GB5H2WU0ZpvtMDz3AwnZo/yqXWcuc+PHQCmrQCYRJ+rnWKUP2vQ3VUIG4977a57R+O23LJVluYG4q/DfP6DiIpdLhBhTYqMHbqQtGOkG6Wi2yf876Tnio3mBS5zqqijIv2G7fKz9thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d7R/JytZqKkV9UFp0KkhAO6CaxExT1pKLOQgEgg/M0=;
 b=DTjR/Rqh36FjY+cCNexLyebaGYozgv5zcl+6/GCEv0EDdjqyancVp12MMXEA9Sb5T5muG2fk4/af/bHWuzrpv0MiwehnRKCFj4NsG30A7HabJD63uEqH0mnxOaAbgJdhNzsTioLt5scrtXggsHuDVPhiohSTZLIBO+mkav9q8F+DxxyxxyqceZhGhjmJEQk2Uh7jmHu6xwOxjFwpSxsyl1Fm8mFV9PkN8K5m9eKKqAh72zHeXgXREPJGOhBf2HGquRtja7w/PBD2fN0/sVKkByaKJpD9SARktBvK0IZ3k/LHrH7AhEdRrobUtW3VRFemqN405B2yub51hbjbRUxjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wisetechglobal.com; dmarc=pass action=none
 header.from=wisetechglobal.com; dkim=pass header.d=wisetechglobal.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisetechglobal.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d7R/JytZqKkV9UFp0KkhAO6CaxExT1pKLOQgEgg/M0=;
 b=RwJ8GtqbQEfQa8iRed25GQ3r7RKrupoLCpcxBlBYVPgNk8uKOiZ6SW8Iv+0DMe+D0BdU6yRDQ3P1/bfk9vl/WHgY/KE0ZmdwFehhfwhABAOd0MQGXz+VSLNX1tZakSPPLL5MB64dDCpXqwTk0sMa9oAsh7RD4XWUYACTihY6VlMTo2M+QRWK7+Kzz4FenWwTOmY4rknueM60v3EwJ3VrEfa6uyBwSbAhLPa8C5WwZZs5my5FB9z2zsiKCDHGh5CTvhBOGAFnymM6123SCVi+Biy2gS3+uW9tH31Cfkpdj7pajlH9qAXv0jKUKcMysG4JbzUYQfFBVMvzI420UWmNQg==
Received: from SYBPR01MB5792.ausprd01.prod.outlook.com (2603:10c6:10:e7::14)
 by MEYPR01MB7901.ausprd01.prod.outlook.com (2603:10c6:220:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Tue, 25 Feb
 2025 23:44:33 +0000
Received: from SYBPR01MB5792.ausprd01.prod.outlook.com
 ([fe80::fea4:d61e:7f88:72f7]) by SYBPR01MB5792.ausprd01.prod.outlook.com
 ([fe80::fea4:d61e:7f88:72f7%3]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 23:44:33 +0000
From: Yaakov Smith <Yaakov.Smith@wisetechglobal.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: \b character escapes in CLI usage
Thread-Topic: \b character escapes in CLI usage
Thread-Index: AduH3ojW1clJmNsARN+7+f+7NEr22A==
Date: Tue, 25 Feb 2025 23:44:33 +0000
Message-ID:
 <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wisetechglobal.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB5792:EE_|MEYPR01MB7901:EE_
x-ms-office365-filtering-correlation-id: dcf08ba3-8292-4240-bc3a-08dd55f65af0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?z3H/vC0Pfa/+ll+8S8+BQD9sCj7SU+0xWrFqmZJ2XGzIhI63MEjz+QC2er?=
 =?iso-8859-1?Q?SIqv6otQbps3sZS/OoxKgxQG3N0k7lq3MBShV+OTDNA9M1YDS1h3rAlNnl?=
 =?iso-8859-1?Q?DMxr97/nQA8mVNRWWR3dw1tS3/NwIHguo8lumr+U81xkhEXKe241VvjB92?=
 =?iso-8859-1?Q?EdSnDL64RjorKJ/VKh1+qP35eslrebseBcHoaSrgGLaheXG7v7GJqP+e9m?=
 =?iso-8859-1?Q?2zIVvD89PU/0kg8J/WyvNocfutpMuQa4dwD5X48XDU8/IeqQ55XakAJ6SZ?=
 =?iso-8859-1?Q?9I0tl/GGOBqjbAAcjFB62XcASrjC/AWAor2qTXpAvepsAPINIKLUIHJ6Sg?=
 =?iso-8859-1?Q?30SEw7IQ+VEWa3PGELabnGGo6KC5QrFkJta1e1qldxKjISWmYp15jj6QAQ?=
 =?iso-8859-1?Q?YqWOnfwO7E67nmzRUIMwUJc80ppqWNz8d+Wh3hWyoIFP9MxVynWwkCbvSy?=
 =?iso-8859-1?Q?Vq4MWm7INGHgWYfjA2LvVXGlkUrBDBDfQz0pf0eg1fZXVjjh799LM5hOSs?=
 =?iso-8859-1?Q?85s+QXV9RNkEwBJTwkfwQydPR0SSCkmh0kIjmtZkrMAw4JhRCsxRYqvbzQ?=
 =?iso-8859-1?Q?C/jJWOHXYwFGWfOrtNjC73h1+Xqv5kLCVROi5xP6brDaIPfeu7LO6Vh/tD?=
 =?iso-8859-1?Q?Il8nOtNbsyCVjNrhDHFOu+GRtdkBxiOkjZl1c/j7OiGQSUEJVNtOGmzmRt?=
 =?iso-8859-1?Q?8cJYMQxHc1dfdodS/8lHjyQ8NEZ8LYQhVMecNVOgwqn6EQZsRuNmm96mNC?=
 =?iso-8859-1?Q?aYYwgeddiv1VZPHMvx3k+ofamXEnE0xxt5dMQVML25bOlNL6X4nroqTkgh?=
 =?iso-8859-1?Q?z0rTECgBr5JQ0XB74EQC9+T8NPmPFGALLbuRvBg42sfu2L3Ow4pEnBinSd?=
 =?iso-8859-1?Q?RgWVbi19DpfJ16UWH4LITK6g0+UmvaERHZNL2m6VplydV16Id3+LdHOmxS?=
 =?iso-8859-1?Q?uMD/h0NNh5ejUfz+D/+4ToDfl6DrDe8xZitb6GnJk/83s+SHEnw68LVbiH?=
 =?iso-8859-1?Q?hlUpLZvUyAHdXgIouLZrLIbOv8cOrrzO4P0Q6iM0fuUMTSdjb8gGdrzo7N?=
 =?iso-8859-1?Q?E5YOBXc5I+wzO+qlku6M8YOxbBfV+sJV3k36ZffC7MZJ0IWxIj00kg2Fks?=
 =?iso-8859-1?Q?Jf9nj9IYTwWqFBLcJRXT0XeDQJ8quAJXAHK4r8gAmAqc3RFrRk7MehWOdC?=
 =?iso-8859-1?Q?HXyaLXF2VlwTgE31kO59iOdABMvmkJwMqHgW8T5QEtrmmMhlPH+wt9/Ff6?=
 =?iso-8859-1?Q?ea/TWiMRmsIz7bEUjYhXniwRWu/UwklT/6fmUae3e6er3Il6xWy+iFe3E5?=
 =?iso-8859-1?Q?JqQP1scXtxMHDOOaqhs3zO6TmsCHfhcs/TgER9QVtqf2ZlDypVgCzkTzgU?=
 =?iso-8859-1?Q?Ilv5Npl+FE6DWHsIREMxlcbZ+1IMFJScNJrBWytqqc5I6wjEiiRMTKmZBC?=
 =?iso-8859-1?Q?8BYN1YMJtIWCQlbRtAZaz8b/VXqwYc+4NENXnCG2dZvdTNiOPXNl1wBxBu?=
 =?iso-8859-1?Q?X71kWw/23aWUZEfUeYINoV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB5792.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9va3KNmAniBkHr1zAn7Gu5WrkP4L8BB/OD/UfG5wMmQKJb8J8h++GBzca3?=
 =?iso-8859-1?Q?PM/ZXzE55NW+rsMv1p8kog/RJyyOx7FyiIrFFItz4uj5oJtsWVi9pEEGyN?=
 =?iso-8859-1?Q?TR9X+WeBFifgwe+bLSr6tumytxoxUc32Pl9vnNYGlP4ESCLsU/teZRjl6e?=
 =?iso-8859-1?Q?pKMw/4zH0Ng5zUoRv/i0g1fuCJ6AylcJoHyuxAfT2EuMecyTVbBBlB++eS?=
 =?iso-8859-1?Q?B48nmY/uRbsUK4HTm3QN3BIcOsdQ/ZjMmXQvZMo3oJT/Jhp6F2BN7BY4ZM?=
 =?iso-8859-1?Q?1VdZ/fTbMhJFa+4ujOv1F6HL4mtZwzqSUxTkarEeZmg1h2ul8SKfYssf9V?=
 =?iso-8859-1?Q?e7waN8E4qgjNQ+ef1Eyk1sCV93QHhESPMkJ0AOgcc9SRzxZFkkCx4dcBen?=
 =?iso-8859-1?Q?jj8IdstQkeCarjIrm2pj+g4IUKu1SCgtwY3oGDV+Qe7JMWBDVLba6pIg84?=
 =?iso-8859-1?Q?PF6FkTyNbi12gjyT+S0OSQSMJHPKazrUAQW2R8TtBD0j3noEmVMCEaA2hf?=
 =?iso-8859-1?Q?2/gMLrPJnFWnlN9E4pNHYgyoLZNaLrzkSQ7il7GIiOP/YZK2gwsaV/ttF+?=
 =?iso-8859-1?Q?mTQZlNVcZe/bFChDqs+oJloRPXCNArZtKVKPtnjmk9xl3qfjlu1tLZdlR9?=
 =?iso-8859-1?Q?IZA4BJv+shWCUOZvvW88npxgi4WgEd7g8hhLqRrBNqu27PNoA74cAMB/Ju?=
 =?iso-8859-1?Q?0i74Lu8zrBXmBjaQBRM5LD5RFTLiK87VNOKbwQAS4/24DEYwTq2Po2SXqH?=
 =?iso-8859-1?Q?WoE2L5h9ojf85vsdIzjoWSV6MHEnuTijVRsyGnupReZu+MPEwjSppwIINx?=
 =?iso-8859-1?Q?KC6wxfacxpxH0rlfTHRCUl0Am42roVG1Qw7u/OoCHUWTWjkO37OyNw/A6/?=
 =?iso-8859-1?Q?UFpYFewAte5E57EjpTUAtBFX/AuqvA44eYIfe+GXTE2LI3oRrZdKLmTaIi?=
 =?iso-8859-1?Q?3t2Bh13ta21vbtYcDoezQp0CP/OLBNYw/FPdZ1TOrhlbaciln/1aDnzdNp?=
 =?iso-8859-1?Q?naioANgHUG24IgYpiEMcZd4uBWLXXzjUScdXft/P4TA1iH17UETD9dLUgj?=
 =?iso-8859-1?Q?sQrbzRz7ZHJgcFk+we96wXY8VBeeVxM2TBgVPkQ71CguQ8dAKEOz3E4EY7?=
 =?iso-8859-1?Q?VARG8RqvqQhvdhFYZ3vDTlgrOTC7jkAnIMIta3VYIgmt6b9CHIRDqR65ao?=
 =?iso-8859-1?Q?/e59fBdgqNQUeo2g+nAR6835H5CCp/vBER3Vd38rh4EjhjqleFmfqtGvc0?=
 =?iso-8859-1?Q?uP0wuMi3vhAi10neWc8D5ziueL4TlIqNh87nW8wtBsJ9svZ3HCgLKffXWB?=
 =?iso-8859-1?Q?J4svO1HnCgFE634JCCuYNOEbzt1V8KIhCtF/b5j0HXO3mZ+Ew+mQzJ10Ud?=
 =?iso-8859-1?Q?AgC2HSdlN0DpdEPlnJBnjiscOQpAPw8D71ejb6dLR/b8Q4KaQGT7WzLeom?=
 =?iso-8859-1?Q?tT/yw935VckBDSkmJP+RViZJ4C/6TkyVD7Q3dO52KkNBoQDlRTo7wqf5C5?=
 =?iso-8859-1?Q?42ZJ2w5yBO3Wg1ZpUN20Ryp2JQr7sG+6Kz62+jrFY1e3lyp/ob9MCzeVwy?=
 =?iso-8859-1?Q?xxMUSwsfygWMOZ8T3kcSEAZhLu3gjeSLR8quUUPQDuJrG4ez46Vup0hgeh?=
 =?iso-8859-1?Q?N6wTPfGwrXLsgDtZJ+csBKRWe2Rq4ewUbhhLGsGtISCoBus3BKZ0vMOQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wisetechglobal.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB5792.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf08ba3-8292-4240-bc3a-08dd55f65af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 23:44:33.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b493985-e1b4-4b95-ade6-98acafdbdb01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IggZeJZ/QvQM39GS5lmV0NgfllN8yDsfRiypccu5rH0KT1elCyIFdD//vrkI8aRpyLA2Vxh+m7UR8L57JYwJpZzv/uTSpNl9F0/e+Xln5DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB7901

Hi all,

I'm not sure if this is a bug, but it definitely feels like a bug.

A colleague of mine was going through the documentation for the git configu=
ration file format and noticed that \b is a permitted escape.

In some places, such as trying to fetch a remote with this in the URL, git =
will render the character differently.

[remote "backslashb"]
        url =3D "\b"
        fetch =3D +refs/heads/*:refs/remotes/backslashb/*

$ git fetch backslashb
fatal: '?' does not appear to be a git repository
fatal: Could not read from remote repository.

When using "git config --list" however, this is emitted in its raw format, =
and can be used to mask or hide an actual (probably invalid) value:

$ cat .git/config
[core]
        somevalue =3D "true\b\b\b\bfalse"
$ git config --local --list
core.somevalue=3Dfalse

Should "git config" be smarter here and print something other than a litera=
l backspace to the terminal, like "git fetch" does?

[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.102.1-microsoft-standard-WSL2 #1 SMP Wed Mar 2 00:30:59 U=
TC 2022 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash

Kind regards,
Yaakov Smith
Principal Software Engineer
Pronouns: he/him=A0
e   yaakov.smith@wisetechglobal.com
t=A0=A0=A0=A0+61 (2) 8001 2200
d=A0=A0=A0+61 (2) 8986 2753
wisetechglobal.com=A0

Enabling and empowering the world's supply chains.=A0
This email is subject to our=A0Confidentiality Statement=A0

