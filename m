Received: from DS0PR09CU002.outbound.protection.outlook.com (mail-centralusazlp17012017.outbound.protection.outlook.com [40.93.13.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847A145FE0
	for <git@vger.kernel.org>; Thu, 16 May 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.13.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865666; cv=fail; b=ai+7nss0dA5cmS+YW4IsS1Dmr+Qq6I0HXcXn7pcda6UVJNtuLXkLLCyAXaNqdJTuMrBSBdFnO3cIYCItYygH7tg187ZjDdjqg023/FN63B4GWSKQHRs7nOyZdPgjMdQG2qFfDi8Qziiwhlx41/qO/JGZTt9THzBJINA/9Axjf74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865666; c=relaxed/simple;
	bh=gATcrWc9kp+KyltzJ+clT3RKZaa/xrj2hKd+/85v0Qo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rRqx2JF4okB/aCWW0lWHfbH4skjyLHswbYZMXCpsmkjIWMRaUWLiN6mcd/7ao943kE5+Kuw7EOEivavmOx4aY25OObQJd3lWDSTqTYQXWTiFdq6bgxVg4ylxhYKmLA6NGSCdr/ayrsrauiv2SCVxpKOu+zs3YRYGOtA0d93vYSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nasa.gov; spf=pass smtp.mailfrom=nasa.gov; dkim=pass (1024-bit key) header.d=nasa.gov header.i=@nasa.gov header.b=EFoH39eK; arc=fail smtp.client-ip=40.93.13.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nasa.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nasa.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nasa.gov header.i=@nasa.gov header.b="EFoH39eK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+r6dov4wYtMrVOjIA9kcEMBiMpfLCh7OvJ2QWshlW6YOzNIO9T+FuF4g/KKAouJ6grLKyr7DAzYHugarlUwDU4kYPzvoUsjw1npmxIeZUfCorYX5tYSx6vVcWY5EPSgu4cFIoouEzEjyP7PhiP/IjfObp02jbvtw70OfJkGYVAX0PybEG/1MrdLsWc3Sh8/NtGRjT6wfQFUcNhrQkq4lFoyxMY4GJKY3AFhpwvg0et9gT+lE9a45s/G/P5VOtsPV+jq0vdgIOe8SKmYil3VfvvXPoA3CcfxFS9WNMcIRGMJvPCbUXDfHIsEfWePHI2xdxIHwr2h1k0y/9Dc8lZFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/HCnKkW61oBR7O48Jj3sSwiNP5BW1G0yeS2WEvKoYs=;
 b=UBIIRYu1F0QR3uffUt2dlg86s0w+neF1zufZTSqIW7qqh1w4a82epOhYVtG8fbWD5+fukt9BmHr6MUuUttWN85HJiNldzIY7KTdEsfvgZF2c+Ql4OnBKyu4RJrIDgRhe8mlZFB1Dsm4loGCM2zLir/W5CnyHzkiTqPIJsuCAR82Dd542Axcm7N2R+soDBC4ew8IwYr4IAmOKrrGEdaDPp+ty6KlgsRRaPtqX5vt+x0rTQGpkHka9M5Y61Czj631cBMhGZAp9lPKhEqIhtni2PT7xPQtnU9pEfpdp/mCFfaa5VuoimIGx0QVPrSBFQZmc8sFXnRPH8/rpsjd70DU7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/HCnKkW61oBR7O48Jj3sSwiNP5BW1G0yeS2WEvKoYs=;
 b=EFoH39eKpiidpxfOE/ShXGl85ARIOhsBbBV1/JS+RiIwrR75fITfWMZw3Hx2iAnGb2jdczEoOtFRGDpLa8A7uAPYhg5M5xh4Isq3s0PseIg27H2sgwt60yAvJ6MSqyI50vsE7wnXY0eeaNL4c7ziL2gs37lfTMXnS0do2OgEhBs=
Received: from BLAPR09MB7075.namprd09.prod.outlook.com (2603:10b6:208:2a5::9)
 by SA0PR09MB7289.namprd09.prod.outlook.com (2603:10b6:806:7c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 13:20:58 +0000
Received: from BLAPR09MB7075.namprd09.prod.outlook.com
 ([fe80::5360:ced0:c823:bd33]) by BLAPR09MB7075.namprd09.prod.outlook.com
 ([fe80::5360:ced0:c823:bd33%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:20:58 +0000
From: "Sterling, Brett A. (JSC-EG411)[Odyssey Space Research L.L.C.]"
	<brett.a.sterling@nasa.gov>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Cloning a clone with (relative) submodules
Thread-Topic: Cloning a clone with (relative) submodules
Thread-Index: Adqnk8OKv7cE4t/YS7W0K3BzOHMTWg==
Date: Thu, 16 May 2024 13:20:58 +0000
Message-ID:
 <BLAPR09MB707587D4900A66FC8C405793BFED2@BLAPR09MB7075.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nasa.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR09MB7075:EE_|SA0PR09MB7289:EE_
x-ms-office365-filtering-correlation-id: 335788d3-47d6-4b81-5cdd-08dc75ab062b
x-agency-banner-exclusion: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6Yb4ZpxkMDo5Fnrbpr0Db0jryp1PXHUVCIkC/rQ6Yvs1dod5RPVH59sZe+m5?=
 =?us-ascii?Q?Fc0gdiK5ypjW2nVtBnVK96ccFbTv3R7WvgzNyJ0WbL8ph+NYKyrQK5e045+a?=
 =?us-ascii?Q?rJyOYXEiID5fHlR2AFxccqzdp1oQE2ArfpHPYQL5pmmp5VYvgI5H+S+D2g8c?=
 =?us-ascii?Q?/EsUaU9npn1roBoQyrzPQm74wwwYTLunko708CZWJAB7FhUO+pXlkzQj49zY?=
 =?us-ascii?Q?BcAlfRPgCPRrLrjyD9K0ab7PilT63Gpnfrhju72OGv09k4ZJhtP8QFjjHpoe?=
 =?us-ascii?Q?RugsPVD2kQpYOsLliJOczQmzDAMyjjUvQCO1eH+xQaTd44t/k99pLLhmIeIh?=
 =?us-ascii?Q?bJ5qAwpYEmfhqELJDo7A80zDFP8p2ik/6dkUzVHQaTLmBhBx2hBoX0crwQ2v?=
 =?us-ascii?Q?jucY7hBs83zmCzidlo+fV2/eut9cR2aWVNRtw6JPVDPQpaCgAfIDSVTleo58?=
 =?us-ascii?Q?sFTUxFuRJMM+qklzBGw/Y0Jx1i/X4z7jj7U+Ss2hAGmG9tBWUV3zZu7DPpp9?=
 =?us-ascii?Q?sNLW3ChxrpwTB27NArEkWLTYOUQaJB67bM/Wvj5CNAWg6XAlrC2yt/JiljS7?=
 =?us-ascii?Q?xXujAe7I3X4G3ql0aQmZ/FOJTPx7+kBrHRRe1vqSNcEl+LZHG5xzgAZucCTC?=
 =?us-ascii?Q?/IRtbhQrAwzWNf7XWSbRUczWQd9zTkdP7c/4CAi1UuKxsNUSYGHbvkHjCBYc?=
 =?us-ascii?Q?GPPb1+/T8uXYqH2l+bQadLY4VMVbsia7dxgr9OFaSauNEqe8E6hPqG+Iba1M?=
 =?us-ascii?Q?VaZIJzS9mlJvrVO71jAkCGqca5fLfrxZrGBE1kbTJ8bAepvaYKyBx195glbF?=
 =?us-ascii?Q?GkP7aceH8THNGLq3lwkzKw8qpXO8fg21fboV7eb2fS/p9jZQi5g9sI99HAFg?=
 =?us-ascii?Q?RxjC1pReCdWIvOXXnOc3y+LGOUecHE+2QkSzFPzdFYZVBYOmWASxpcpKl7AV?=
 =?us-ascii?Q?Nyyq+1qpENUK0+DSxbUVyRSCp7FDb8zZxXuXNfVmaX5BjuAKsbuBvDz+olCL?=
 =?us-ascii?Q?EO78lvioZXGkrj8Ix6CjlBedBVSaRpVSyxl1OEm4XffwMJWeIiGrecxC60or?=
 =?us-ascii?Q?5P1/fErjc0hmkNa4DE/jlId3PCVPnvBpSJT9hjuEk1/D2W0B5gmvWM/cM6el?=
 =?us-ascii?Q?IUxOGjeAly8/Mh9N6P409YsfbiVogHN+m1kmX6cl+AxkJy0r99ybo2XDD1Ns?=
 =?us-ascii?Q?YOjLAjkLdZPfkleuWmnCutFXLFE3hg6N3wKdhoI3RfejBxtLyguPKL9Bqc8t?=
 =?us-ascii?Q?NbUXCSE5M2XxkiW52Q8qLBuLNieYkfqNXmMc7IBe+qgSFWS+s+OegdpqMUZx?=
 =?us-ascii?Q?zEBcX7Ue8ipmCAeMxb2tVTC0KFsWUIo9ZKdn1YHg5nc7wQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR09MB7075.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7HvsXzg1tny7dE8ZgjlJeZr9xS0lEnCK97Nze8Luvwtfh+WBrn9hBPF0JwJV?=
 =?us-ascii?Q?0huvMUaHtj1/uW5gHdQloxctDiMbkB9NwUxWUHHF+tVDHnWqsWynHbNZlOC0?=
 =?us-ascii?Q?OM+6OAS1pWOsAKamNuAaT4XyYYP2Ey25+TATAXFAgzKISsq3UYsM5PL25WVs?=
 =?us-ascii?Q?LIkIqmO1PA9rQe2Bmg8dkz3MY7hXWfayN+4Al+SZlGo5qLUWvw/xxgdZI6bH?=
 =?us-ascii?Q?eTb4ektVXoT5hv/EbMw0dEWmvcmRh8NphwJHJu7YYjhyAmcyhS+IjI4r1VuT?=
 =?us-ascii?Q?OguybBBKroAuRF2Oxk89d5IOaVoePuVzU+/3X3ibc3s9d8SYhY8MeQzpZJuI?=
 =?us-ascii?Q?d1RJttH1N+ox06sImZ8/485G9IIRZGb1WRlWpBNH71WVF4FyzT1QBAGAqLIo?=
 =?us-ascii?Q?XkoD6JxtJcbZzmJuhHRsH9zcBaFascHcW3ZnydlIiGUGF/s70l5zu/shqmdv?=
 =?us-ascii?Q?DhYH4OMdK7h9Hv548JK3cfuXuhKyYj/g49yMGbTMMRZQadPkExPA1UKEVK3e?=
 =?us-ascii?Q?g+Yq0vUtHIUw+KmD0PjwfytLkRfbWs+vUBsza1V4UJ4COTqlHhxQ9iIlu5R8?=
 =?us-ascii?Q?GEicbhs4T75kiAMNTnN4NBFVU2rOWGcmligoETlxCf+Yr3Y5cArGLpn7dE/f?=
 =?us-ascii?Q?sBP+0eSngmZxjVwRG0DiZFUgzerKBJYawhbc9zZgY173ZNU7j1A3AFmTRHsC?=
 =?us-ascii?Q?kKiz4824xROc9WU67x9ZG4IB0IXVh1PiJ4Peoemt+oXWQUK76LSsI6dUFvdk?=
 =?us-ascii?Q?TuMuDsZ4BE0HNhF+lrF3T3+1ASLWzERcescBOlJUjQ3PAqwPB4DwTS2mXEkO?=
 =?us-ascii?Q?/WW5Tx2Lg75heGGNK4VyREvC8KdRELhUanPiD/dot01cOLuZCBvwBUIFH93r?=
 =?us-ascii?Q?I6PWK37c81YGrO2frR/JGKywSm7hm2hvoD9f508D499oPJUnh3HnPwCqjMbN?=
 =?us-ascii?Q?zUmKKjoUCYpIHx1rjO2gbKOfKzHUpSOSIbuxDChte0rd3huhec9pJRr4Iwua?=
 =?us-ascii?Q?n6FA8QPLXBWJRoLGQky309Q4j2rGP618wGazOVfL41VgUFG/NbV5/kD/AMdd?=
 =?us-ascii?Q?c8KO4hGXLIAAyDF3L6sazb2gGavsX8HMwhSvpYCEW8O9kLNLAUapMFQsQamV?=
 =?us-ascii?Q?H9VlSvcEihQ8kWWGJSHalBbrzzoKWrinlEzresbJe7ySqEnWVGxqjAQnk3FV?=
 =?us-ascii?Q?8VCO8BO4wLZfBcalUX/cpJzEBkN95+PC31G8F3I41O4NqpwzGbTJ7qFJ3loe?=
 =?us-ascii?Q?LW3ZmEAxbPNjpAdx2Emi/3lKm9a3XOt0KEiTspXoDgiRZMQDde+UD25tJGFz?=
 =?us-ascii?Q?t4tsR7P8Pj/osjiv9XcfF1x3jGJhsiv8qiklgMu1E8L4uqEJfvBYj7RXbguo?=
 =?us-ascii?Q?t0x812gZhmqDrEaJcV5ezoY2zvSPRm5SY3HfUXzoo7AATdmYYFZzxlBfxvd1?=
 =?us-ascii?Q?/qh8mIpB+DkPY6Jxm0A0Vh2v+MC8h0KJ6WXCM9Xyh8o0CpMnf2Eb3UuzE4Z/?=
 =?us-ascii?Q?22IZJYsKibiVgtCaQYl9QP/pO3TvpIdxX6O0N9qU2YREPgkp3wD3BFTCu9Do?=
 =?us-ascii?Q?WGFsLlhHip3P40NV9yecgk71T+A/ZwJIzNI9mEHA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uvKYWgNNPU+ZhWuNWUJGLUxFjhhrAK67dipsJS+tm/QOqCDv9gf7h8OeiDpby6kWqK+P1JSS1N05foO9PvMw/h1yoSIkiIKxOr4WFEFxeE9qKuiFAu8hoVq09X7hAmvjTsPdvNo0BOCZQW/FazTIi2G9E2yKMi0DOkYm2QehdTxHhlAa1cP1ajPwGXzNYf8/Rgln82uOUmK+XfolcEEBr9rh7OQjg7yn7GfVme463Dzos1A7mPZ9n3NqqWJDh1UrR5eO24pZ9rN3fi5LFQsBoWfOO9Ubycf/8EIB+nlpvEk8j9jye2e7cK5/lYLZQqBf1+l/iyfPpJYJJNvv8IFXLYsOZY/SrlDBqRHbstrlR5o1F9AbtdU7sXLgpbi3PaKedDn2W7Fhfc37VSfj4xK6hVxKqV+mqnb7lIvWFhDQ/Dn/OszqwtUdc5/PVvrctZfLdaWx3c9/zckrKdt6EhW9mv4P7mCwYMNW5/XAdSY/xE5TY8WtjlbZYZxbscYuwEo87Cg5aOrMmvpRg8jBs+2OSklQSbu1lYdzFKuIh2Y2b8cWuZANmTlG6lWlrchx/0Tl3bAX9+58vr5QzCB/jaRnTn0+FTvy1FtVLwxSYl+BXU0=
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR09MB7075.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335788d3-47d6-4b81-5cdd-08dc75ab062b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 13:20:58.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR09MB7289

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Created <ssh_repo_addr> including a submodule that is specified (in .gitmod=
ules) as a relative path
git clone <ssh_repo_addr> origClone
git clone clone testClone

What did you expect to happen? (Expected behavior)

I expected 'testClone' to be a valid clone of origClone.  However, because =
the submodules are specified as a relative path, this no longer works.

What happened instead? (Actual behavior)

fatal: repository '<local_path>' does not exist
fatal: clone of '<local_path_to_relative_submodule_director>' into submodul=
e path '<local_path_to_submodule_in_testClone>' failed


What's different between what you expected and what actually happened?

See the error message above


Anything else you want to add:

The issue is that when a clone is made with submoodules that contain a rela=
tive path, the relative path is maintained verbatim.  What I believe _shoul=
d_ happen is that when cloning with submodules, any submodule path should b=
e replaced with a path relative to what is being cloned.  This would mainta=
in the idea that the new clone reflects the first clone as the origin.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.3
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.18.0-513.24.1.el8_9.x86_64 #1 SMP Thu Mar 14 14:20:09 EDT 20=
24 x86_64
compiler info: gnuc: 8.5
libc info: glibc: 2.28
$SHELL (typically, interactive shell): /bin/tcsh


[Enabled Hooks]
