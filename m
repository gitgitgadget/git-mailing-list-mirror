Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2109.outbound.protection.outlook.com [40.107.121.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC712BF20
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050204; cv=fail; b=FLZBV7vdC1B64NbVUnAtwVeCcmNN8d3lpH4B9ThXL0Axq4hnoQ7eebK5llZPMLW3aMCGIEaraaWK18VcK02e5v+rtJ5osSHaU81z/dXtTAYrx6pMse3ykv/nyIMpo0siTqi2yjjSdvO3srqwYWbSPZJJGeMyiW1OIEXX3WKZM+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050204; c=relaxed/simple;
	bh=jVK4hRHb56TBpAr9uDBtXmbUhr+7xVUwmIqizhWbeeQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Aos+1SG3UQO9MmtW6PjgSlilpSk/BXrj7aJw1ozrVhhGT8sNVTJsJC/q6jWTjGnvQa/5XmtmRshY+8LFKWuoqpWur1bOh7Dk3qQZWODWkOVUUqpgjO9SdH+iwIi2RY/xa5kdi0tDT+lRneMdBknDPFXHETYLfvYxDg+m0cRgPZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=getstoryteller.com; spf=pass smtp.mailfrom=getstoryteller.com; dkim=pass (2048-bit key) header.d=getstoryteller.com header.i=@getstoryteller.com header.b=UKBYAsy3; arc=fail smtp.client-ip=40.107.121.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=getstoryteller.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstoryteller.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstoryteller.com header.i=@getstoryteller.com header.b="UKBYAsy3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJdUeFEvYeZSeeUMfa1+iuRA9iIPD0o6FILqbhLSavHCQNHdtWVcySDvyahVSh3TqmQSVR6kDqnOFcWQNo5NfvwjpmDEQg5rjfIdjXjYVimjHggZF24hOW06p0htsaQduXkA93Bx8hXPX+X+1zgHJ9KqDdq119WkZtycLS81pDfmuy4kq2okmKWbqgr1B6d/YFp5zQgQLUxT1lHia1ww4XXdg4BdnaCC02xUVFHBfEmje65KwYBXsO8tymYO444fIv6oWdW2XpjE+zGoaaZX1Nzg1ZXbuhQNQMp5mE9t4AGKl6ARchlLcJMFvZAlSKeuW6A0ivxff7KQxSSpWEpr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVK4hRHb56TBpAr9uDBtXmbUhr+7xVUwmIqizhWbeeQ=;
 b=QqPONyyVOUzP1Yea+c1AieeDboXOy0aNeBHuyGmQjwcdECKxVTbuWRn/KHrm/Z7YSQYqEluO80sS7VLJKgvbGY8THB4GnsHUrI7oujsPmzqvK9ouO1fVRKY+WiwyyIaScbQuEOS7cFnFDQzJ89bpgjY44KrCeJ16fzIoAt203Gx0vl5Z8FzaCQBUUt7MQ5C+yKeSvg9zCGZOWlEAymQz2/G9dUOtF4gqWuFtIztgLrj89Ms328h4B6NkFFGw2zsn/0XeQt8XJR/mJG2C1QP1GDOI6wejomMi6ZDP8mh1ZI7IWDSBZNEoiOC1kifH35e9GBd81g48YwHtCHI9hMC6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=getstoryteller.com; dmarc=pass action=none
 header.from=getstoryteller.com; dkim=pass header.d=getstoryteller.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstoryteller.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVK4hRHb56TBpAr9uDBtXmbUhr+7xVUwmIqizhWbeeQ=;
 b=UKBYAsy35RxWJcgTsrGwWEMmvSJVH+1VjGK6X2rIz6yiaSe9mP6pU+L0YQeweeovK1pGa/GZjhTfEt+U4GPOjYwDq7NpdJl9aCP8110nQo1+k5apdEOojpBki8LljOnWmJXq0PWZGPL/Uq6oNp48eAmL9X55PF9vpDXlDHJQbdralLDktn5QTG4rr7fqiOneldfUOgyVikTWT/MnIeTqF6Y36pTCZ2MDKUHTmLHECDti8d6+DufO2/W8dVZH71TR/4N+RyDBnCLbThO+U4WvEMxwVMMqKDzKsShaoSAsFSRWCKRmYz/M9X3wgnFD8MJhuwSm7isbMx0DI1luMxckjg==
Received: from CWLP265MB2657.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a7::5) by
 LO0P265MB5543.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:240::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.24; Thu, 25 Apr 2024 13:00:52 +0000
Received: from CWLP265MB2657.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ed47:daf5:3d20:df07]) by CWLP265MB2657.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ed47:daf5:3d20:df07%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 13:00:52 +0000
From: Sergiu Todirascu <Sergiu@getstoryteller.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Issue related to git submodules, tracking branches and custom remote
 names
Thread-Topic: Issue related to git submodules, tracking branches and custom
 remote names
Thread-Index: AQHalxCa/gg5fGoGX02rwhvN/FbIZw==
Date: Thu, 25 Apr 2024 13:00:52 +0000
Message-ID: <A46E73E9-2718-4243-8835-B69AB1DA39D1@getstoryteller.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=getstoryteller.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB2657:EE_|LO0P265MB5543:EE_
x-ms-office365-filtering-correlation-id: 81da1f10-1633-4069-99cd-08dc6527bcb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VbPUbHnbdKzav/5S0U3kAAc1PMQio39H8wesmHkY2WWZMoaLNmdY6GmcL9eS?=
 =?us-ascii?Q?GmXfUCVgtm2AOH9SzevuF61ViDt93qfNqHhrZCmhxnwVe24oVH1eZPJh+enL?=
 =?us-ascii?Q?5+XY/HreDpT6GN7lsSKPd92Pn5RyR6KoX3Pry1KxRE3nVK4Az405dYpAaSqV?=
 =?us-ascii?Q?U23xY+E6aMvOORia4wPUpn7utPkFwhWZntEVC44+2vmIiIv7Cfvw4Lu95nZz?=
 =?us-ascii?Q?5cRpgbwXzNTFPaiU5kMBPbjR3NW4m6boA377yIk6xX5U1UjFKGsH04Q7Bzb8?=
 =?us-ascii?Q?EefaZ7C71OmCb51pqOEVnF7jecsKTd+rXJsdIloYLHAIaHHb5VBmThQnRlkG?=
 =?us-ascii?Q?W7dLfa6GL171Tt8xBO9aIRW391q6rGM2KSxkymjit0zRxzcKPllIB1pa3xOA?=
 =?us-ascii?Q?StBNWwGLM9+rBxx6RJJyvgcINKHMxcBcu0pM1jJLLYCBXnbfFJBsyeQwjBbF?=
 =?us-ascii?Q?qWuk1fjpAv/ZElV8IIZUKd+ZjbzVCrfmpa1lnGrDbmybVcKsANDI2imr00md?=
 =?us-ascii?Q?n/052yYTnMtof2Ju+FGBmy/4gr3M89v8O+0URyphGxm+V1RbSdusfh7GNPLL?=
 =?us-ascii?Q?nb9mis5XkDvI9gA3rLMbmT3AXevDZPI0UWH8y59eL8ch3dwmI66ZVpKsaRvO?=
 =?us-ascii?Q?thGDmyehvPTWoStPMgTeKH8k99mya9KmqSbA3sAyPOZLc8CP/GoFM2Tch+MZ?=
 =?us-ascii?Q?TJoK4kfKonoffPnSWvdMx3iuo+tCdJAKbFfmhoBNtpaN7C9SDRRUd78Zvh/d?=
 =?us-ascii?Q?E+evCkCCwhASfqDQ8VnoJa4UZJqdt+Ux2fyncIDvIMGNt/HUQytQLhcyBlGl?=
 =?us-ascii?Q?/FCYfsOQ8KGgfgofP67Gp5pXqr+8m+Qw9z4964Fbd+xzsLlXst17+tWrcxWx?=
 =?us-ascii?Q?hCOJ2197FSp4m+1e0siRHxTFEZm6ggUsBV7kfmbYSbwUJKFP5UAL9eHtmEdG?=
 =?us-ascii?Q?ojdl/Jyo/Oj7yHfDSWG5RhxrUO4WvaE5HxM6VDIT3cdBwMYTs1owA3/hGxWB?=
 =?us-ascii?Q?cYfAmSPtACcSwecY8l6qYj7gDBJIGXA5POltBzqqMX3OhsAPR3PazSE1L/FA?=
 =?us-ascii?Q?uH9WDjLmJluYmJHsoiveoOkJpVZgFEsUUb1EpW9BQ0edQag2lQsxjKA1GiKm?=
 =?us-ascii?Q?T1WdAhzog+j5j0zORNRO/TFqRTRwkE81EPgGjI8NVc8Fn2TIP/5UAy7AVqhg?=
 =?us-ascii?Q?780k1/Spq52aIF2Xfda4QJUxYraHPa+PVbTEbec2qF8V6vBEIP86ECWpN1/v?=
 =?us-ascii?Q?Q5vS012oAuFI4p8P0x5LcpS2wSDF/XHICQg8NxJQBQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB2657.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r/mUo1NdDlnYlUd5MCd1doVzea/PivInO3ozPw+cV+uEOKrbGlmDmKk4IVg0?=
 =?us-ascii?Q?r8ghlEjIP3PR8U+wwTAAIlShylO0Yar6GMU8KlwyuYj2NoDrni9FXWjOM90B?=
 =?us-ascii?Q?a925u7PlQ5yCTxQlnEyN8GyunUAVJdZDjXzDzfAy1F5nHC0ZF0sJhFdmteaH?=
 =?us-ascii?Q?w7pWstvhZv5lUFkFSP/6lRk2YyrEf1OjCHAlhuKgYGns6QueC3Eqrfpj1aHY?=
 =?us-ascii?Q?R5NxCPb6ItGUABmXA/1pPxjoyMhs+xBcfsmCexzKBTw18ItLAXRMFEY/oXkE?=
 =?us-ascii?Q?jISGgKsfD/zBwj8EdHML/WeWPs8cG+nsn3dHoIwoODdgBp3uTsVgmpXmrvE1?=
 =?us-ascii?Q?0kz3RZKQrGAxtpGc3ZA5Q2D8nklQlGwP3t9QZiZxgrZ6u6N4N8wy0T6u9Njw?=
 =?us-ascii?Q?SVep1+MEBLlWiQ2mc1AiGU4W6zwqYE3gkqz769XPHWTg9PrDWApmB7U3K02/?=
 =?us-ascii?Q?IiqrxxKHcXVDOKu5pPczRHOxfKmK8T2MbkTufXy0Zy2rrWQGMXd6JgkslAAo?=
 =?us-ascii?Q?7bvL7KLSqyF9obJZr5J5TjeN8piUH+gfIfHxSkysPzU7m0HkslciBqI8fBXe?=
 =?us-ascii?Q?GoMkveiAMmzrLbZ/aBtcidHwz7WyCgyMGdbtNG12clO1PEoU1w+OfzT/Jlx9?=
 =?us-ascii?Q?SiRbOpmYkq/uyAF4WeCnQ6YwWOwOQ38gOd9fjeVyYF+yU6SoI2jhphFo14Bl?=
 =?us-ascii?Q?5nKmCCliCzRJaWj2PXLNqjouQ6cp1shSsJsIzbHXdx07CI5Fz2Ms8KuMkUWw?=
 =?us-ascii?Q?ZlWvss11LNbM9/s7n0vWF3R71k7P9jxmcjMG0nm6EAfZtNDT2fU6+RfH2wGm?=
 =?us-ascii?Q?jVsmD1QuRbjWTMpDexilZeI2Hq5P4C1D+yJIkDVUtOA1q/6rtC/YtiodRtCk?=
 =?us-ascii?Q?DHlsPVPUNovaunJrrAZhjntdCQIPO5Lm+bu/VsOCml2K2WzqBEe8fEILc311?=
 =?us-ascii?Q?sFFJteVrorHpom5AujGl84+IPjCkQPhtOLpveDRl+142JT0oTtHvbba8m2vI?=
 =?us-ascii?Q?iv4ewQDH0nOS2VThpA0PbheDG4YWHxGSQud5012n63pTLY+aQDMn01KDmmd2?=
 =?us-ascii?Q?Oc6d0TMJm2+kxDVvYEb29aoFSIx6RN60FcUyTEHUVF0+iVtZ/komABm072sk?=
 =?us-ascii?Q?BDxyPO6URXXxudLUGivgNu/N1aYNEdNlSObqJaywLfxZI+XWkP8EFpJOOsFq?=
 =?us-ascii?Q?LEw9rxTvHqUW3JEsaH2L0LPzxdpYmPL2qsLHCNVawZxj+LYLbuS2OCbxbC1G?=
 =?us-ascii?Q?Uf7tq/pIlZtRxs0ZgKnL3MkncDR6aKRsL/hz36mq87qiAOWy95/mELR1B7Z2?=
 =?us-ascii?Q?Q0GPpl7Ap2fCi9ku/czOnMPLp75nsoQL9ptkNrx8wn6y3kBgyFqFLS6n5B7X?=
 =?us-ascii?Q?LxI9NztlSnLcjI8WeSkYacknz54SSJMR18YwWPQmTND2NWWbTA//AD31YmhT?=
 =?us-ascii?Q?nIujP3qJonprHVKpWC3qa8Nq5oLMelvR6Orvt3yzj5uNQPQCXctp7Rq54KxA?=
 =?us-ascii?Q?izDSe9KaelE5bcdK+z+Mu9mFvUrn83sT9LKYoH8nsW6fOusvjImi7L0C3ukq?=
 =?us-ascii?Q?1WXHwhBd5AWRaVaFXrZoZmi8JvmQAEtLmp8dBfRdGoYTC0ccpU1iYb7Q7F0x?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD9C4BE7724D5B4ABB3F2B142750C24C@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: getstoryteller.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB2657.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 81da1f10-1633-4069-99cd-08dc6527bcb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 13:00:52.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d1d939ba-fa57-49b5-a592-80c791e77937
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jIhA1TsZ0fzsjaQlnYn97rL5bT6DAoiLPzUv65hoUzfzYIa4AJ34+hnnZs+bW0mCeQX4qvBY7WGLjy/yOf0p9v6sMCMJOUzcklr2xVz52U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5543

Hi,=20
I think there's an unexpected behaviour related to git submodules, tracking=
 branches and custom remote names.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Inside any git repo add a submodule via `git submodule add -b <branch> <=
repo-url>`
2. git submodule update --init
3. cd <submodule-repo> && git remote rename origin internal
3. git submodule update --remote

What did you expect to happen? (Expected behavior)

Command should be successful with: `Submodule path '<submodule>': checked o=
ut 'commit-hash'`

What happened instead? (Actual behavior)

`fatal: Unable to find refs/remotes/origin/branch revision in submodule pat=
h '<submodule>'`

What's different between what you expected and what actually happened?

As you can see in the error message, it's looking for the branch in the `or=
igin` remote, which was renamed to `internal`.

Anything else you want to add:

I'd expect for git to either properly detect the changed remote or be able =
to specify it somewhere. I've looked into the https://git-scm.com/docs/gitm=
odules reference and couldn't find a setting for setting a custom remote th=
ere.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.3 (Apple Git-145)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.4.0 Darwin Kernel Version 23.4.0: Fri Mar 15 00:10:42 PDT =
2024; root:xnu-10063.101.17~1/RELEASE_ARM64_T6000 arm64
compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
commit-msg
post-commit
pre-merge-commit

Thanks for looking into it,
Sergiu

