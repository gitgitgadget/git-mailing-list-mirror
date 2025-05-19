Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84327587C
	for <git@vger.kernel.org>; Mon, 19 May 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659087; cv=fail; b=IHisvBN2jnwnPdoxYrFwIXd0+Xs3QpyJ85840PYReOGkFtc4hFtQv06Xk1u45aJSfzhGTVJmK3710gTOQywiOqZgleDg3zGoFJB/gX0bCVs+Bk5xwvc48jKs7HDIwWyOSFd8ty5bLkgAW//SuOFbbTqNN0uhEHeGpJFzWrv0cPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659087; c=relaxed/simple;
	bh=6MPLZle/9+5tcKt9loMdKO8ktEQeXLrAFdP/Jef4cVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTtX+nNpl1yQNUx90m8VYRQj+Wuv8fkMPwo0oTh86emGDUVVaA8NkgBnqRFguE17TF3YH8+s15qm2HglCyG85UagB4FXrFKi0ohJ0F/sdmFVAXXUhOOjYSPfiAwV28HS6sqeZjwIFT6Q5q+C6uGrc68HAFbwvvI5qBliS5M2Rv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=U7YwuKcv; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="U7YwuKcv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKUsSW6dFaHp52JiED3uBi+tzxfU9O/W1AoeAPkM1Ri8YjiowqupvPu9+ZlMT9uiJM8qTNYOzef7KsPyxhbNlLqPk4jhvNtoyc5hdlGB3qLPrryfuC1EFk9ozMrVlFvFfywKEDxQZA9SjiN8VqtJymC1TaQRmloMd9qBzn1amhJoGpOlC7IZF78sJ/wEMbcAQuFlzGbCTIFzrThixzFiCqTmuq48mlUWQXBovJRx+RrABtNrNCsIEeArN9DqfSAQtGLun4MVwXzlcDTY+hSud6P7XjeRpfWv43jsnPSs089hgMGkIze2j5BNF4r8GS6NaCRCgEFDpRGPKwfNC+BUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DYpA7+bwoECPPSf9M1fqsgWj8GE5vN6gYPJ5dfPBWg=;
 b=cO1G4UdTJBCFfR5CHZsRoHvcdg3GxYEv5tKnlihIb1SO7fLhYKbvMtmgZD3DLE/M3RU2n2xdLEA5tWNclQZqep6cqwGUVTOWE9PjwstyzT0aAaJxVdy/i585Vtc+BocKTyrtr4CsNNLo8L5zxHuvYRuMxN9ngRmCUfocPOzb2r5MAykLaCgH3TDtmjm1HiO1RuWGAQswD15hNnKh2m/EGvFS4W6rWSvlJYur+rVhYid0VVb1I/+psIh+42b7OLJkz6P1Le6CIGAi81oE9Xl1pjfrErj0GTKYh5VKrG7Mj7viZJ5M17icU7qSfVuODvTZnLYIgKiA8mpUu7XCmeJR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DYpA7+bwoECPPSf9M1fqsgWj8GE5vN6gYPJ5dfPBWg=;
 b=U7YwuKcvvXAJgqHJEhkNPCUFLfndJ5vEXdbw5HWKP9rzd7hvwivPNNb8Uhbxk8BG0Kb9KDwJtFQ0vH0wze6yKfQ03btW1tQIldLna+pvL+eh1UyNnDjygzVmV1haRztqcud+Pb1gEHPzhndpV8VN6X1Pvx4bCPTMajZSUCqCFkS8IN1aCIdHu68zb3Z15HVls7l5saAqd2EkTMm4PCXTDmfpSM6LNCLKD27NgUqka7oahIUsyKuqA/pmS2zVsepx8lLcikEeNfw9rX28daHT1FXShetbdEaLQp/obTj04Y3xPj/p70jnotozV5wCENeA78skJndiPlrFkuLWuQQVxQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6332.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 12:51:19 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 12:51:19 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v4 0/3] docs: update email credential helpers and improve
 formatting
Thread-Topic: [PATCH v4 0/3] docs: update email credential helpers and improve
 formatting
Thread-Index: AQHbyLy3iugmEp/y9EOZLc+cMuPpQg==
Date: Mon, 19 May 2025 12:51:19 +0000
Message-ID: <A84F634C-3423-48E2-B648-068A75423037@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6332:EE_
x-ms-office365-filtering-correlation-id: 77efb996-cec5-4894-58b7-08dd96d3da05
x-ms-exchange-slblob-mailprops:
 F3kBGFPBgzZx5fYXqP7epOz858UK+BQTBmOpPZDACZNrrEY+vlPWFsLOjWrrNbx1Inxpv2EPEhth89AI1MvmBBCHuciDFKLBcy39Tu/JUMAE6byEvfHuSSEX6OY7YxFd13bswq5eJEWvFH/HZbC1oQak4C/mjOyr40VWasVUws4sHD4l+dpWtj1b4cmoL9gAN7KSLopWdNJOifm19QOSLSRe5ZupxKWoKL5U+l0ez9T5NZF9HCk196IXJRiTOIbVz6vBb8wSRHoVLG/t1CWofHzqHDjoYwP7VKOLZ8MAvq59mNNj5C9MgXrkTHfNQdy1/CREoWEXYBpixXm405JtNvL4cZVMA+QiL3HeQCYW13hmXSZc2cLa6CRMH1EFwVSppV/WP4rYfiGnzGtwy7nsEvxLqnJOpgSi5ZKFiEgqjWaSMAVe5D/XVDyEkKZGENNbrylgJwP3my/+YnRyItUG36ckv+EJIiX9B6XoZrKvaC6YVguq8sqb1rQivvA3yrXdiIOyRbpJKE10dPyDmTkAgeUnkBwfTYbj8cdnO0/xuI8R6yBzfa4pVrqEn9zykBzj+VvXa+AraBFhQZ466G/HncetjSXc8CPgZv0HyQkVaiNdaFjA1bgRYkuhh0acXGfyxHz8Z5T1tgr2oE5HnVyLBNN6mn9/4vzsLl2epiVuSYqKN8wdzs8DgWkeGcUKNM2fy7zchUQritni9SbnR5juOI+ZGMT2u9nmBVUe95U4O7k0TMMB8vbgO19VrjSDVWxVb8D006mqGSvoSZZChHRaJd/mHkLaufpM
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799009|21061999006|8062599006|41001999006|19110799006|15080799009|7092599006|3412199025|440099028|34005399003|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?a32BjPzpTACmDIMtclY3duUOHwM67sdc+OmVrAJTmEihpebFs4jGjY2Raq5J?=
 =?us-ascii?Q?LE9A8qN4Dimz1dvWMVzNtDl1k2806FrAy8ete5s4EPxEHyqkWZMci5xKwnaH?=
 =?us-ascii?Q?Vy5Uh7+S1gUXBH6gYPdaJs/adlYv4KMJlolpzb1XJLyitBntqKOGOc394moI?=
 =?us-ascii?Q?vPVzzoNUAwg2THTHsC4iEaxIlyfqK+sDD10I9cN80vqGjAvARwrD/kV0PCve?=
 =?us-ascii?Q?HOAp3B7CZ/XAqYVn8YMTrC2wfa2pbKsNHjsKVLkS3jk8DKK3DGkMkcEQ0sYc?=
 =?us-ascii?Q?Jh9b8ckJCQcmqMvgOtqxBmpniU8xFad4qJvOL+kVXsYt7AEEVzOyelHOPWZg?=
 =?us-ascii?Q?PC7DODGePQQK0u1HiptI7r3aFTCSxqbOFgcRsnHYdwMA//Dga4tRn1Plkoth?=
 =?us-ascii?Q?u0OiqnTE4kepbzPl3iTWSzp7MQp6kkfCKm2+Jnyx2fjKEf7efwi2BUdCoReT?=
 =?us-ascii?Q?WsJ8Z7WZpxatr9++3AYzmXzkd2LGY6AjiuEvC9er090ELWB4q/VLYpDyuH+s?=
 =?us-ascii?Q?04wR692Nh1FB4zH0/5eThW+vHbdj9q8GFix1D2tVYLW5g/LnRMPNy5C+IXDd?=
 =?us-ascii?Q?klnXogWpaLf6XYHRucoNaLI78fru4as7ci7zSsdoplbBrX2sSMP9N2mNNv8d?=
 =?us-ascii?Q?pgTkr9DrAaG+PFynKXHvMr0ujATD+CG2euJHmoyGxXZmCuLwFYH9QM15zVZd?=
 =?us-ascii?Q?Ta2f2DHvAC8JGrtzFN7kMYYo2d7sU9ihnwHwgxWUXmvI5zN8MFqQDtsCPYk2?=
 =?us-ascii?Q?UX3zscz88+vl1MOwLUeakBcaRbufHTNzuaQ+tLl8KnQHaPIFASYuf7DjCjWO?=
 =?us-ascii?Q?lDDItsweug5h7hSs+YV/4dz/CnAEppnq9b6Sg4aHcYQGDf6is7s7I6lShy3w?=
 =?us-ascii?Q?BAlMMJa65134bXXKhwaWGoxaO4iC+ujxY/N/wss34jDTWMCILM1W7NoBCG29?=
 =?us-ascii?Q?Cxa/GlJdAm1dKIkHMYvaTJ9PwL7xRPhRxnVTVeGeaguQMHKuzIAUY1C+eVET?=
 =?us-ascii?Q?iSsW2g07Vkzua/3C3NXKBvjFfcLBPVSXHXChokSFjnVwlj72Sdg5blbEVzsY?=
 =?us-ascii?Q?VNBq5nB/IM5qfYdhoLf2EmZtzvtFzUrZt+pVFO7rhyKovIFKULrQOfhnm2bf?=
 =?us-ascii?Q?72m/zoM290blcZVTfl7bFGjxWqSHde6qvHQwKagU74BEPOJK6HTkM3A0sx3T?=
 =?us-ascii?Q?WHjT3DGymsmkF/5JFzEgz6FE6GNHJPcYrP7oMtRoOmQBaoyG3i0WFze1SrBw?=
 =?us-ascii?Q?D4+j899QrwH20s6TpNT2?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7PzTGL9ra2tNpb8YwDz9HWSTuZamwcBi/0xt9Q1SN/IcbNwAd7kcNnEQ/Xsh?=
 =?us-ascii?Q?up95QywFttz8Z2B9Y1coT2nitk2Z/g8W5CKWYt63NJIPWU6qHHV6BcMfcjFH?=
 =?us-ascii?Q?GY0gOxwUxngQkkHefNAOT/iarv7Vwu2NUzOAXG5vV5Lbg5RAAp9Yzuk09tiZ?=
 =?us-ascii?Q?j00dyw+KF0iRDvzbHiuJndv7JcX4lfsYX1m/bGMKDBfwgSq07hkeWmH0YSoD?=
 =?us-ascii?Q?DqLvqmjb/u+2kFdtSw7DOX0IO3urETV1Wxy8aMcVrwztY/MD7VgLGxyIu+Jt?=
 =?us-ascii?Q?DGU2elc1yrSvgAq4drqwebt2unFcgCpYcbgbDHPZt/Pv8Cdfz9k2I4Nuxz/L?=
 =?us-ascii?Q?Sj6EwXBGTZY9FZLXBYxt/W1DhUHInhkIoCQ2CohVJhYgdKDty0yf/Ex5lxpH?=
 =?us-ascii?Q?TxSXoOTZJV7kKGZgG+nQmebgMmAHFKLYeA2ZSClP9jlqjbQ8mKKE9/DzeSv9?=
 =?us-ascii?Q?XrgFe9nZnLlBwDRMfcgRUvmX6ZAD42+mOmJDto0IxOajBmTkZJDsMSW9mibN?=
 =?us-ascii?Q?I/Dg+G+JHWhE6+uexcxV8uir5FPy75JCNIS1ox3n/hgFtSucEqBd2WFfW43P?=
 =?us-ascii?Q?Sc+PuwYjcdw0pVEtC4CaCQNwsg/gkt+++lBkB+cjqRKM1iaa9qxLs321V5L2?=
 =?us-ascii?Q?oRe1Lfoq63hbE0yKdKg4pEyVmaRhgD7NOpABF351LkX3qMAqrh/l5rmwMfcw?=
 =?us-ascii?Q?mbnvt6yanvhmaLqspbYPG4IsHKMC9WP4fHtNgVk2/TykKhopr3e6Ki9d3ou2?=
 =?us-ascii?Q?YYHSH0vhUtqEJgR1/eYPp01atXlUnB5IGKbWaUjsmvZLiu4pELTp02zKXh6S?=
 =?us-ascii?Q?GZFrfXCeOEo4Fgph1q7lNNtvTXzAZks+rAdeWfdWYOsRegjSmX72b3tZggPX?=
 =?us-ascii?Q?dtr4OWHqd8XPPACQCoeqXCpZZsXXngtcI/f9HJdZBRggU61+YN+Ldjn2vPf3?=
 =?us-ascii?Q?Wpm5Q6em1KIpKMAOUd1cQaDNA6tdoH+RZIcCC6yX6Ue3m7ohBMbLXpUaDgat?=
 =?us-ascii?Q?XZoAK7tWUBMDp2mS9UgoJtgTtgDvE04WbUlncE/fIUvRlxKdJDcFwnyZgOFk?=
 =?us-ascii?Q?7e2k5dL/lsWZrZnasZ6xl+DkikcPEln6vH3n5Mmn+mOSllMaM1hFUFAEBYKA?=
 =?us-ascii?Q?Xi75lXdTPfN1nhV8D4nT7NfkaPO+h2kJrCGYeo2obPcP9s84MFde+LeTMMgZ?=
 =?us-ascii?Q?T8rRIwsK+l5BTGyJbgozTRoB+6Hb7+EamuD4B4r2yNBn+tQRCtp5Ltr+gb03?=
 =?us-ascii?Q?ZIYVFmdkMBwMQpZkVA43rB4aXhAKXdaPyVWAwUeOz1vvOag5jGj+Yk9Frzo3?=
 =?us-ascii?Q?lXJr2rjWwzonksTMsB9uFTaS?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D3FFCDF089DB34F96195584F9692960@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 77efb996-cec5-4894-58b7-08dd96d3da05
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 12:51:19.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6332

Hi all,

This patch series included three patches:

1. The first patch adds a link to the `git-credential-yahoo` helper for
   Yahoo accounts and links Google's `sendgmail` tool as an alternative
   method for sending emails through Gmail.

2. The second patch improves the formatting of the `git-send-email`
   documentation, making it more readable and consistent.

3. The third patch removed the email credential helper links from the
   `gitcredentials` page. The links are still available in the
   `git-send-email` documentation, which is the right place for them.

Detailed explanation of the changes has been done in individual patch.

v2: Removed instructions for Yahoo SMTP server since I've realised that
    Yahoo *was* a popular email service. Also, the instructions were
    just making the docs more crowded. I've also added a link to
    Google's `sendgmail` tool in the first patch. The second patch has been
    added to address the issues that came up here:
    https://github.com/git/git-scm.com/pull/2005

v3: Added a patch to improve the formatting of the `git-send-email`
    documentation.

v4: Added cpan links of the perl modules requires for `git-send-email`
    to work.

Aditya Garg (3):
  docs: add credential helper for yahoo and link Google's sendgmail tool
  docs: improve formatting in git-send-email documentation
  docs: remove credential helper links for emails from gitcredentials

 Documentation/config/sendemail.adoc |   8 +-
 Documentation/git-send-email.adoc   | 191 +++++++++++++++-------------
 Documentation/gitcredentials.adoc   |   4 -
 3 files changed, 106 insertions(+), 97 deletions(-)

--=20
2.49.0

