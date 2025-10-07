Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020076.outbound.protection.outlook.com [52.101.61.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAC1DE4FB
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878686; cv=fail; b=PuYM1fOIHQm+5RVKYq6hxOxTYbSJ+W2Dkkr2bAtRU3lM7LjhMJzW5L6VkjXJGqLwu6JyuqztYwHwC99OsaOVUHov0iT0f0kC8CXm+ZJhaUbfmuniU1tFa/A1kPkjGXlYnP3klXdIW2jRrGbaoHcD5pQscTxkeEchglQaRpsz0is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878686; c=relaxed/simple;
	bh=lUgUDPU4yhSv/b+69750K8A6pN1kCqr3XCp/BqifjyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hzTtW+04aOt80uYj/QLn2d01HMT/I8oKYn8yjHpYK1vXF8hM7xLLjWMMKhnwKRoXTtL1c+BhGMmngYRPx2OTbHsq842OgEl6v484pLtshRfOX6Zy6B8RllLA8e4a2YzwGxls6AaCy0Akk9OZ2D5n9h3MvDyR+iZjhAy2mGblmSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalquest.com; spf=pass smtp.mailfrom=signalquest.com; dkim=pass (2048-bit key) header.d=signalquest.com header.i=@signalquest.com header.b=rv2D2rFd; arc=fail smtp.client-ip=52.101.61.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalquest.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=signalquest.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=signalquest.com header.i=@signalquest.com header.b="rv2D2rFd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5VswW7WJiNn4dfAsdZsBsXjP4WZB71V9FQNlMMPjpp44+eN/gT7DYH1qjQDJkP/A/FRbeQ44DyBjgbZi22qjtF5e9Bh6sWA+zI7OC86vMI+3AFiVUa7B69RoXyEp/KvHQFkKwbmLHHzQaB+C+lGdhwAJhaOwWybhPwaNFwVQYR+2bF5JGqaWsjUhheXQQjAlru4e7w9Y69nxdbM2h8NbmYsWUrt95sKao4uG8ppfsnDQ8pZr0iWawXD1xsJmJFfYWj/oQlpic9eXB5ss7es489GfLsqZLMOJybFH+4JLF+puRLCsiSHDlAC2Rg0QKWbTkcJPyorMq4IVbmjU6uTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjmvRLtti6gq0jIV4hDFi/1IEA6zEOzLqlJ0qypIiOo=;
 b=l4KVSGuHLA0gmgelzrqs4cQ/Y7eAmHI697MBvTC6hubR4a5XopqR/5jIpFwZkX9vzY83Ka1BKASytOwLlb3Gq+kPGCJiuQSqMd/G2qFAMuNa76J/C28+IB+NvdFvYg2e5iSIlMDFQJguXn053XVUpCpdhmpOLZm8p/vog9/EadXiZorSgl3ZlWu5ZuwbHZS4DCakpV8jmmQk5MjaUJG1LGgxwhVxdYY85e0ySkEQ7CbAj/YWz1/Ga9EQbROdVTT8tM5ditNNnN+TzyAuv3EUfnoI39XHYWpIHE3qEW3AkH4YtRWYl6vM6Dhi7EhAUAJutPsHo9Ps7wAR4EQ2GInO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=signalquest.com; dmarc=pass action=none
 header.from=signalquest.com; dkim=pass header.d=signalquest.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=signalquest.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjmvRLtti6gq0jIV4hDFi/1IEA6zEOzLqlJ0qypIiOo=;
 b=rv2D2rFduuKnXvHvuX19dumhi8H1YjCC6nBfHNia8AIO3TuXuUNQAjAYKYfpDWr4scM24m+XNq8ryMHNnaXjLOhJmi9+neP9mfYQyC/Nk0+SCnec3+odGrzHAQEFHogtZcjSjL3lW/D6vUxTsQnQ+n3RIpAujx0PXp3Xi9D4iruP9jQZL011x4nSXkk2NqJDj0Ar5dliYzINetrVqXGszh/zVOO5lbp3FSma41WkXGjZRD0QZHksL23bR6hmg6ZZvwY8J64zviZNZ3xvnEtzLKd6WyYeaDJVKnqWhXQghzIzrYrzH3cnHxU2+Z6L5fd+M+dx77XlnbRJV10FZi0Log==
Received: from BL3PR13MB5209.namprd13.prod.outlook.com (2603:10b6:208:340::14)
 by DM4PR13MB5883.namprd13.prod.outlook.com (2603:10b6:8:4e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Tue, 7 Oct 2025 23:11:16 +0000
Received: from BL3PR13MB5209.namprd13.prod.outlook.com
 ([fe80::6519:c778:f655:ccc6]) by BL3PR13MB5209.namprd13.prod.outlook.com
 ([fe80::6519:c778:f655:ccc6%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 23:11:16 +0000
From: Andrew Harmon <aharmon@signalquest.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [BUG] git clone from bundle with --all does not fetch all refs
Thread-Topic: [BUG] git clone from bundle with --all does not fetch all refs
Thread-Index: Adw3zvXxbRTGKqPhSiiq+FEJEt0BagACOg2wAAHn6tA=
Date: Tue, 7 Oct 2025 23:11:16 +0000
Message-ID:
 <BL3PR13MB520981A726145113DCA8B910BBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
References:
 <BL3PR13MB5209A87037FC19CBB9B2916EBBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
 <xmqqa522icjy.fsf@gitster.g>
In-Reply-To: <xmqqa522icjy.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=signalquest.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5209:EE_|DM4PR13MB5883:EE_
x-ms-office365-filtering-correlation-id: 4ed094a4-f7cd-45f5-6fef-08de05f6d13f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kX9ntJ2xaSidJreR69IqZjFRD/WfMG9SkLXSSnzaZl+hNopg/q4eHRbwP0Em?=
 =?us-ascii?Q?Nds0LU5T1UZvQiz5Hr21vUwDeVo+0DXOLwRkMAUd7qO588YKiEJioRlMfFiM?=
 =?us-ascii?Q?M40HuYPRJqrfSpwzxwCihUJbUSuVwUtC9g805P+jUp0i3oXmXWs0MxQJ2y80?=
 =?us-ascii?Q?nN9FdN3nOi8YLPzwQIrWn8yWOgLK+4Ebdl1jbs1k8p/4XrVYndJhwFx7GnYf?=
 =?us-ascii?Q?mLgc5RtS4hOBgSVT8B1BoqUyfTXQmpbPYwtpG6NlGCVOYHkjdM5dorvHECU7?=
 =?us-ascii?Q?khCAQPJE8UuJlGDGaDnfKjyeuTov9ljpIVDdWnboka0V1WAfwCjqF9sOtzRw?=
 =?us-ascii?Q?E67N+OaX5b5BBQs9Zap08McYHFBqSS2MXvSn/AGVJAF1Q+zqs0W+qLMVeY6F?=
 =?us-ascii?Q?EpkZFXzCrh4SG7Pullt0Tct0pAha3SsrQQgDQT2taBm9MKaEgOeRDv021yca?=
 =?us-ascii?Q?5pX37yU9qxe4+qwPZvS77mKexNlCQzUCq6CfpNMpRm9q0cLf0dPYQsC4L6dF?=
 =?us-ascii?Q?U+MVA1yTfdmrBsb8A5ABCJetDpjJvUcLWKBgXHwfj2ZuvFnh58XWeeoPDwZa?=
 =?us-ascii?Q?T5GoscCNUlFgfsYzaNhImVZIBFulgLucODJNskeYDAV2EYKYTQ0adxLc5v2S?=
 =?us-ascii?Q?LeSe9IB8aIvAMJ6ZKpK644ZUxTsHgSSrabhvKN4heG3m3ayiNIdh6lfbU+UM?=
 =?us-ascii?Q?PVaYm8ZjkE+LsHNmyNJJcQ1znClaRJhzLntMCExbRBcqPNKO8aFrV5rqvDOE?=
 =?us-ascii?Q?wud0LvRo1gPECgYKgpAQxPh8OzysXvsYYEAZmBjzQFzIQJzpyB+2lcMt2gqA?=
 =?us-ascii?Q?RLkhF+O6CCi1gmGDjdIiOD1z5fJVXIWZx/nAm+xqzshC+XTmJpkH4M/MSntF?=
 =?us-ascii?Q?Pka7KSqkFRkCq5YvLPc4anKQM+kY3DwqsSke8Yvhgop+XzDE6ROaO8o0VpLA?=
 =?us-ascii?Q?4vqydIAejkUQax9uIGsiLvFCMvQc+2dlmxXnm4JHXWN0MwxTWSTDOnIsC1Sq?=
 =?us-ascii?Q?o1g6zOomSaQkjij59K8z/+x7D3JQdNY97Cr2h3E1pcz7YWocXyV+pEnI4M/G?=
 =?us-ascii?Q?49yHKcuoMYhbUMEeSDwlBYyFoGtakOowoEkb/7NXxvB5qB6c2QitCONW4A6l?=
 =?us-ascii?Q?rlxpJBeXuxQGtKF0aGxCaMIRt+1H+7vdtkL917+pCp6ZKm2PbDr4NaT35v6U?=
 =?us-ascii?Q?ELDyMVYSRKxshihYI7XP04WN96OX55wWtAvnGI+jkDX+hKJCcfjGFE4k3JwX?=
 =?us-ascii?Q?8eboSI93GDzzW6IRbcmWLV0CNnq9KmKLUtFsLYgEstDMB0t27FSbRbbKpb1f?=
 =?us-ascii?Q?MJREgfwWt5fuP+ElZ6DzdaHk/exhccoyK+pQVREylWAIq+4zhV3v+9gUboTT?=
 =?us-ascii?Q?uty2wdwFmcrYIzVNSEyTAoSA3XAmZ5Y3fCCziPJ6DRheqHpM5lcauZD4knl3?=
 =?us-ascii?Q?WEsI2L3dzFhinqFpSnUTHV9/NyddMgNlRVcK3lwbnwV4Hz5FEsAW3V33dhOS?=
 =?us-ascii?Q?eA0bgWCjHUzSIr0c6NS6D00tP2+GQsSrzQKD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5209.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BEcftY9/hVOYJqp5psNdjFC6qTN10R5mswBrUQO0fL2ViGQn8XPZs0cEwmEW?=
 =?us-ascii?Q?wP8iYBIhI1mrBLDD/4gt/n9ffpnvOQoNLuz4Hdg5WMbCJ52BK1CoQNXZ1NLi?=
 =?us-ascii?Q?3HhjBB7syElJKWqWdv97A1JR6V6ByJNzN3TvDY94LhleNsc3Uk+0NxcsAYjz?=
 =?us-ascii?Q?Vh2bcpHkSvc7YyXoNrhCqHnqZqnp2jT+eyj8TNsaErGCtABcwxBU9ljURvmc?=
 =?us-ascii?Q?SmdVrPie9h+BNS9Prc1KKHIPCn465LB0xGhVoMOnso3bbOJQatKHFj1oqTQ7?=
 =?us-ascii?Q?YfhVbo1Is1CPzIZ19EZTEqC7VB28vkrWiXXEPCDmSthzSYkayf7o+4MtIoj5?=
 =?us-ascii?Q?wkri9gf8jG834fUq5CQV2quWcAp+KJcBIQ1aNzC1Qv88pJJk7qxJqpN7NT7F?=
 =?us-ascii?Q?YiSOGmqkAJkcpD5/jVoFn3K5IAvjk6W0PMDqqh2WA9UsVJnSGdxkVjjIZIsL?=
 =?us-ascii?Q?OkYM2TyJs/6/Q5j6b5wNBJcN8zquMhBBGNYUSV2ILjsS/BHRZ5IJ+2YwPNZ5?=
 =?us-ascii?Q?+StxiMLgZuEXsh//hr9xnBHmG/KKoJqP536pLEJhjEtErn7Jd+3AJGw+mU+t?=
 =?us-ascii?Q?GamQLed3P352nmeEOskaPNNjiONZ22lIHKFtuKZeZhmDQ0DE64UkOQmZhKRX?=
 =?us-ascii?Q?btKGTcfUBpl1S7mBKPxqcGT9/2YIGH7KZqOrmtW3a1YluU6rbjZvTezDVP18?=
 =?us-ascii?Q?a+8+Xdn2tW9yndNkOALBF52ssY0Tx4O2UGlom9TPdKeUiFUR3q0VulhIRPRT?=
 =?us-ascii?Q?cbGUcYlFQA/VXS4avEF7DaGmv8l6yfKN56/WAO9mucfB9wVFJqp6nKHEM50e?=
 =?us-ascii?Q?TRCPVY2V5vc3dXIFlx3G/ZGbFF1jyEdNU20mIDERAkF5zfQqJySmGy/ctPbq?=
 =?us-ascii?Q?maQpdSpixxRoAMpKONkHgHuQFvrMJeiASXZJ6bPYn5zryYLj/4ZZqW2jQ/XI?=
 =?us-ascii?Q?BzxgGQxoUkqgqreVFh9gMOvTrNP0mCPvHPon0a+NkTXriEXh9zFg65up5dQ/?=
 =?us-ascii?Q?NaFx34yxdSWvhwuw7o4LlQ6Y+hyWNhHe+/5ZQBimNgPvAUEMtu3A7fl473IF?=
 =?us-ascii?Q?ludFdyGmJxgHUCk07wl1WSFORvqw7oONBKTMOB5Dwg7TcHJ8X0tTJlcKeYQh?=
 =?us-ascii?Q?W6JderGJ9VmUqyZ7xv6NRuZ3g8QLP5EXsipDLnc+FlDgETwUzmqPfVy8M52h?=
 =?us-ascii?Q?3Hs/1QeT1zFhwAitJABXLN7JwIOIdU4oy58jB1R+z4zgZDQw0fC+a0ovfCAE?=
 =?us-ascii?Q?zezCBKFCbfXxJJtG1BFVvUU1ECy5aWkF4GqYqeX5/c5YQ5hwMYltNvVSyMnI?=
 =?us-ascii?Q?URnMDHKAomNoKrjBFAzVLG/i26XFfpMd5FmZds28xhKIx63aTi70d7iwpDX8?=
 =?us-ascii?Q?xy0kUvBCaMXfM67S86E1QO4SIe5QiZDA3qgxI1o0RlJK2kek4utPOC8Jj9Ld?=
 =?us-ascii?Q?gSpAtWoDnrKGXGRJR82zQgWSVyQIM0S2C2ML4ZsgQliVrv4cPYj75/PmYbAv?=
 =?us-ascii?Q?ItllsuNzl3r5xuLj/8O8lC28+2W9m3L5EpRwcTXjPB1EkeP0aSmFIvq0eYLT?=
 =?us-ascii?Q?PPCQF+cLQ8hvdaFHcjbzxo26WtrcsNX1UVl6SZJW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: signalquest.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5209.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed094a4-f7cd-45f5-6fef-08de05f6d13f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 23:11:16.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8c969d8-33f2-4029-8dce-76d1b998192a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2v66xlLa5uYou8yhpmJWNhadIZbJS45VCU0G+KqbjzxRjThrtyANYCSeOeeYI2S1szXlhAXoP7SoVAgyjE6jUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR13MB5883

Hi Junio,

Thanks for the reply. I'm a bit out of my depth but tried to write a good b=
ug report.

The experience of "cloning from bundle should be just like cloning from git=
hub" did not happen for me. Maybe I created the bundle wrong?

See the workflow, below. Is the problem that refs are put in the bundle at =
refs/remotes/origin/* instead of refs/heads/*?

user@machine MINGW64 ~
$ mkdir tmp

user@machine MINGW64 ~
$ cd tmp

user@machine MINGW64 ~/tmp
$ git clone git@GITLAB_HOST:external_sources/matrice_sq.git
Cloning into 'matrice_sq'...
remote: Enumerating objects: 1512, done.
remote: Counting objects: 100% (139/139), done.
remote: Compressing objects: 100% (137/137), done.
remote: Total 1512 (delta 79), reused 0 (delta 0), pack-reused 1373 (from 1=
)
Receiving objects: 100% (1512/1512), 537.88 KiB | 4.68 MiB/s, done.
Resolving deltas: 100% (1070/1070), done.

user@machine MINGW64 ~/tmp
$ cd matrice_sq

user@machine MINGW64 ~/tmp/matrice_sq (develop)
$ git branch -r
  origin/21-Add-benchmark-application
  origin/51-inlining-config-matrix-base
  origin/Add_readme
  origin/DspCortexM4
  origin/HEAD -> origin/develop
  origin/develop
  origin/master
  origin/wip-develop-no-inline
  origin/wip-expression-templates
  origin/wip-inlining-config
  origin/wip-kf-imu-gm-states
  origin/wip-nested-submatrix-tests
  origin/wip-sqinav-initial-version
  origin/wip/matrix-base-public-operators
  origin/wip_ins_resource_investigation

user@machine MINGW64 ~/tmp/matrice_sq (develop)
$ git bundle create ../matrice_sq.bundle --all
Enumerating objects: 1512, done.
Counting objects: 100% (1512/1512), done.
Delta compression using up to 16 threads
Compressing objects: 100% (435/435), done.
Writing objects: 100% (1512/1512), 537.83 KiB | 76.83 MiB/s, done.
Total 1512 (delta 1070), reused 1512 (delta 1070), pack-reused 0 (from 0)

user@machine MINGW64 ~/tmp/matrice_sq (develop)
$ git bundle verify ../matrice_sq.bundle
The bundle contains these 18 refs:
1b32e892e571c11c764e8d79e7970afe89378327 refs/heads/develop
06881c8a501f166b41d71c8a7a025daa5bf768ea refs/remotes/origin/21-Add-benchma=
rk-application
b09e56be3d6ae35774544590c1dc8ae88b4d87f9 refs/remotes/origin/51-inlining-co=
nfig-matrix-base
093d3bff0316e7281ba0b094f7d79e3d16793b15 refs/remotes/origin/Add_readme
241e5d6f6116f8bfae399c766c92d9b2013e61ab refs/remotes/origin/DspCortexM4
1b32e892e571c11c764e8d79e7970afe89378327 refs/remotes/origin/HEAD
1b32e892e571c11c764e8d79e7970afe89378327 refs/remotes/origin/develop
0c6d1fce26af62c104a0c0297b693d9c0f164bdc refs/remotes/origin/master
e9afacb6d77e888b29e9ece12863fb13bc8df3ad refs/remotes/origin/wip-develop-no=
-inline
47004f08fc09bf97f9a12e81726edc05f7390409 refs/remotes/origin/wip-expression=
-templates
8047b97041ce82d2e6b4e193332ddb1d8337fd84 refs/remotes/origin/wip-inlining-c=
onfig
ed8238c5ab80ec3039a29c65dcec574fca6e7017 refs/remotes/origin/wip-kf-imu-gm-=
states
4c20baac85dfce2077f9e997f2c5ea4f25392b46 refs/remotes/origin/wip-nested-sub=
matrix-tests
e909df72e6e52ece8b7fed9362578e1d4a89fb45 refs/remotes/origin/wip-sqinav-ini=
tial-version
9a8ab3d9bcb4a2c2384d0c545634d45e0daf60ed refs/remotes/origin/wip/matrix-bas=
e-public-operators
8720c64e04aeeef02f54a611665f9b0777e8572c refs/remotes/origin/wip_ins_resour=
ce_investigation
0c6d1fce26af62c104a0c0297b693d9c0f164bdc refs/tags/Matrice-SQ-v1.0.0
1b32e892e571c11c764e8d79e7970afe89378327 HEAD
The bundle records a complete history.
The bundle uses this hash algorithm: sha1
../matrice_sq.bundle is okay

user@machine MINGW64 ~/tmp/matrice_sq (develop)
$ cd ..

user@machine MINGW64 ~/tmp
$ git clone matrice_sq.bundle matrice_copy
Cloning into 'matrice_copy'...
Receiving objects: 100% (1512/1512), 537.83 KiB | 11.69 MiB/s, done.
Resolving deltas: 100% (1070/1070), done.

user@machine MINGW64 ~/tmp
$ cd matrice_copy

user@machine MINGW64 ~/tmp/matrice_copy (develop)
$ git branch -r
  origin/HEAD -> origin/develop
  origin/develop

>>>>> At this point, I would expect to see everything from origin that I no=
rmally get when cloning from gitlab, but I don't.



-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: Tuesday, October 7, 2025 18:15
To: Andrew Harmon <aharmon@signalquest.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] git clone from bundle with --all does not fetch all refs

Andrew Harmon <aharmon@signalquest.com> writes:

> # Problem with git bundle --all and git clone for air-gapped transfer=20
> to offline environments
>
> ## Description
>
> When creating a bundle using `git bundle create --all`, all refs=20
> including `refs/remotes/origin/*` are included in the bundle. However,=20
> when cloning from this bundle using `git clone`, these remote refs are=20
> not automatically fetched, making many branches inaccessible.
>
> ## Steps to Reproduce
>
> 1. In a repository with multiple branches and remote tracking branches=20
> (e.g., after cloning from GitLab/GitHub) 2. Create a bundle: `git=20
> bundle create repo.bundle --all` 3. Verify bundle contents: `git=20
> bundle list-heads repo.bundle` (shows both `refs/heads/*` and=20
> `refs/remotes/origin/*`) 4. Clone from bundle: `git clone repo.bundle=20
> cloned-repo` 5. Check available branches: `cd cloned-repo && git=20
> branch -a`

> ## Expected Behavior
>
> All refs included in the bundle (both `refs/heads/*` and `refs/remotes/or=
igin/*`) should be accessible after cloning. Users should be able to see an=
d checkout all branches that were in the original repository.

If I am not misreading the scenario presented, then this expectation is wro=
ng.

> ## Actual Behavior
>
> Only refs under `refs/heads/*` in the bundle become remote tracking branc=
hes. Refs stored as `refs/remotes/origin/*` in the bundle are not fetched d=
uring clone, making these branches inaccessible without manual intervention=
.

This is totally expected.  Think of cloning from a bundle is just like clon=
ing from the original remote (limited to the refs included in the bundle, o=
f course).  Local branches of the remote (i.e. the ones that corresponds to=
 refs/heads/* you saw in your bundle) become your remote-tracking branches.=
  Their remote-tracking branches are not even visible, unless you explicitl=
y ask "clone" to.  Which means ...

> ## Workaround
>
> After cloning, manually fetch the remote refs:
>
> ```bash
> git fetch origin 'refs/remotes/origin/*:refs/remotes/origin/*'
> ```

... this is not even a workaround, but how you would ask for their remote-t=
racking branches.

Or

    $ git init && git fetch repo.bndl "refs/*:refs/*"

which is like doing a mirror clone ("git clone --mirror").

