Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022097.outbound.protection.outlook.com [40.107.209.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D311D5CFE
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759871514; cv=fail; b=bWCesV9YmF763XseujPgWrktB6He9NAwIShaZaXpPp/ONBjt65puJilw2vgB3lk64KAx6BMOnBXDgmJHvteNp5eXWyY1TTvDgENQnhrbe65eax0p6gzNvqgRfMdiKOrztmq+W4ZzV7KinGdck6ODF3PCCU75EzzpVoxpWSLpCfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759871514; c=relaxed/simple;
	bh=oWKzTqSxB7RWjIFwCUD+poet22ZHPau7NPur/4FV/Ps=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OJfiD/ea2CF9bLRf66PoakT6+YkJ354ZRUCUGXyfK0Qp9TuJojuiZswFc2f9w28mHCXmrWKP5T5+MH9ujYjBSVOqjDkOQhtKBTvhBZQoMpWD6k8LZ5dPBYau4Prz1blF+hlWXEULW6luLNNZEKSaT/zE9zGYKw6i/IE6DHOaeBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalquest.com; spf=pass smtp.mailfrom=signalquest.com; dkim=pass (2048-bit key) header.d=signalquest.com header.i=@signalquest.com header.b=Lo6xXPwR; arc=fail smtp.client-ip=40.107.209.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalquest.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=signalquest.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=signalquest.com header.i=@signalquest.com header.b="Lo6xXPwR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2q04pzYJ7v3/F80A+09uTrbdJh9MwF423E7E7jU9Un9UnWyTIyyUcsV/XAxD7Zi3hgnLcdXVSvQcR3B5MY1nEumy8rjneIJx4fq0lutLdyy1e1NY9nxbebbXOPc1Ma0b6+wQ8jaTN1CioeJvJGIqrDk0sHqbvYoAA0CNJzIAsgrZxorh7cVc+lhKPggEYucVxcRnxMRNeRb9dRJJNuOuIH2KWP9OH/cF43wwNYCJVJLUG7mWepACWMj9J9AWZkKqqWIppSqTKkzo1FaNn1Hy5z7rjS9p2xqxenjx4SXhWz3U4rLSKVw2rv/j+4xo2LSXv/YdtVqHccc+3Mj2zqVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWKzTqSxB7RWjIFwCUD+poet22ZHPau7NPur/4FV/Ps=;
 b=n4trYuDblMH+0fj7WJdTIdtoxsGq3d6Y3H6RUK5h68gd7I7xCvakA2t7JqY4TZWgXDty2b3X9CkPQWly8XMC0z4QZdGOFMFzb8LLCOKCkFaoMaSSpEEaD5whuj9y9AOFJAIkySCvxAx2vigdB0XWMJCb62ZrqRP/lex87Zuf7AKYm9G3jXSZOqSvubG+MIsGbAnQTjMfiOjeGIfMOYJxd/TPmEI8yuMadr0JwtAopujxFeX6ddXhn/qI6UTyQHhQYDmnDy209FhxsGBo8qx4uUxBotpQAe8oTuUB0fxwYNpJzOHiVRZ97k/uDmLjRiEo85R7U4k8/37QRtnkCB9Yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=signalquest.com; dmarc=pass action=none
 header.from=signalquest.com; dkim=pass header.d=signalquest.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=signalquest.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWKzTqSxB7RWjIFwCUD+poet22ZHPau7NPur/4FV/Ps=;
 b=Lo6xXPwRMEKGXdJmOYMvsTWx5HJ1VM2IYeKdeJJRgroEr8vsMTtm7CR+vDFpDnSKqP0uNmvVoch3gRG84wxOm/Ctu3hbBXrjzSHF1E2TmH2YQjVvP7f+z1h309afUXYvOaD0UnBbRnOdVVh66TomkkFOlWig4pWdILW3XpYKdCi1PvKnQdx1FA0sWeJOfOT3wLJv0Dy0aj9ON6f6xgcXn1rjI2GRjkFaeSlVSUbjaR2Pbh1gsT9x6VwJdmOyRuPKxNAwlnBt0Sjt6o7sbufl2I3jp8PIvS/v30aPrjl/+kNhylX9y65ybWAMvZPVeOdMHkOa4hHTRpOntn2SWXEOfA==
Received: from BL3PR13MB5209.namprd13.prod.outlook.com (2603:10b6:208:340::14)
 by SA3PR13MB6419.namprd13.prod.outlook.com (2603:10b6:806:3a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 21:11:43 +0000
Received: from BL3PR13MB5209.namprd13.prod.outlook.com
 ([fe80::6519:c778:f655:ccc6]) by BL3PR13MB5209.namprd13.prod.outlook.com
 ([fe80::6519:c778:f655:ccc6%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 21:11:43 +0000
From: Andrew Harmon <aharmon@signalquest.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] git clone from bundle with --all does not fetch all refs
Thread-Topic: [BUG] git clone from bundle with --all does not fetch all refs
Thread-Index: Adw3zvXxbRTGKqPhSiiq+FEJEt0Bag==
Date: Tue, 7 Oct 2025 21:11:43 +0000
Message-ID:
 <BL3PR13MB5209A87037FC19CBB9B2916EBBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=signalquest.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5209:EE_|SA3PR13MB6419:EE_
x-ms-office365-filtering-correlation-id: 3579869e-6bae-4ffc-fa1a-08de05e61db7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O84+/HWs3aTsvnuGLaX8B1W9XSo6JSfH8WWzsPRETPxzkIRIo1UpwNwz/Tyo?=
 =?us-ascii?Q?E3j0fMNOp6HKkqLwZduQR3JHKfY5a7QxIamQmX/mcv23QGPPOzoaUrfbet+P?=
 =?us-ascii?Q?jTXRaCtYNGq7kF/WB5mOfdkWiQCOt0yeHCAg9xu4FR/yAgcjfmePQbG6UaRK?=
 =?us-ascii?Q?MKhNx/tRDu4HLJjwVbi5/P+TR3aVUDLmzo3J46PzZLwUTzH695X5AUDR1KGs?=
 =?us-ascii?Q?c0bAYJBUqt2FG/KhVsdqxd5sKAYGr9zqhQRbgBGFD6IpwR5FkFOZAH8MCqz2?=
 =?us-ascii?Q?goBS7oBpkhq1tc/3z3baz9hgnp40kwgl70VIa804tV31Oq/ew/29hKBI06gi?=
 =?us-ascii?Q?xkmWfJlCwhOAMk/T+vKS0bqdLNCUGzu4eO2FxtqKhQJV/Qfd0QqgQm4b2U/W?=
 =?us-ascii?Q?wofPPKrCDyGihcl6F0EEK/XFkQjY9lfGt/0IxMLH1D74n/tunfL90QClFxIE?=
 =?us-ascii?Q?sGJ2zxFb+6yjqdBYaMiRpwOzxlnDrx+aJL9euK7Km28LrimlfGUslF1UXL7j?=
 =?us-ascii?Q?458IPCSfK+CgXWtpntNo2mE/tcBzIh/BTsJ+tfkAAncFBquQ3NGWLlEAryBD?=
 =?us-ascii?Q?SQF/8OjJW74JT1ci/Vh7UjtLUtSinjCEvHUTUYtRcdOJmBUVGMky2ENtDu3J?=
 =?us-ascii?Q?4sX10YZT0YxHYbnwLpySfcxVeBilSY8PPv5qnWpeuuheurZebwReMgvq79ua?=
 =?us-ascii?Q?rjnT33EIaXQlpzP+iA+dapjV/mdmkjKcvfJ4K76/xSFcFYrg0pkWLmPLLzDE?=
 =?us-ascii?Q?ZNUXKau4y8P7VkAhVIld/EBswQzfXHUwqgipobOHCDATbDGVJze8gSiVRLII?=
 =?us-ascii?Q?TtbnnGmFD4gwzQKAbSgUecpgWItIoKvfx4fj00cfWm7oAcF9P8vjPUnMh7xJ?=
 =?us-ascii?Q?T7zG5OpgecT+iQMCrT2wclrF+a6vTndrH5jiEfXteGeOZ2Xx/FTYEGYOD44e?=
 =?us-ascii?Q?CxA6a7/6q7hiIFV3WGnTekrw32Otd1Q77M0bBcb3mo5916D7iNOSM1Ard36b?=
 =?us-ascii?Q?HYpL7BAjxVTclQJd6sz9fHc2qrqrmSf8NUTYNWq3SPoPYiJ5HB3RZJKUU3i6?=
 =?us-ascii?Q?/cOIx/4Uux+CQMAsiwnw+8DYSTaDn211EyFQIrpCaz3gBVAhNonEjcfjP46m?=
 =?us-ascii?Q?6LAQFwe3R/UpvN+1lw7bJ4YD9/PDSraKAyb4Lpx7qufY9cEH+moYDx/TGAh8?=
 =?us-ascii?Q?8VC1nnqyGNK+I/0+iccjVsozsQmD/6Munr04y4jWqRtNLcPLXkQzaP2znYTW?=
 =?us-ascii?Q?zaNABDEptVE7RK/pI4+ssHG7OjmVKXqHDonFuakZhpEVNKYui7sfdg7oTwZt?=
 =?us-ascii?Q?HGTOAuGWShrdCK0sYuWAjIy90TwQsgJpdLkaixJv3glWcbqQXp3f5+pbl+xK?=
 =?us-ascii?Q?M2RehX9Ek9YuUrji642e16fxzegkXC8W2vM8/qBKHK/0cO6XpgRbWh3CLdcw?=
 =?us-ascii?Q?lnjctfnn89+iBLM2CKR4X/m7qdnfj4uEkJHYS0kEULP9C3OMP1vOZv79DfMJ?=
 =?us-ascii?Q?Zk9GZcs7Y/gA2SQswiN8eeX/86rjhcll2X1Z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5209.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fto7mHos9IAdpbM/tmpamXPMhTLHBq2n3XoI/GcV60b6a7aHI1gDhi3jblel?=
 =?us-ascii?Q?JCyih6wC603aIZG5xViWb0cqlht6/T80ZRqKqksjlg35v/IAtPQdsEGe1CGi?=
 =?us-ascii?Q?S6jV+rdwa2cu7h0eqWwZVi8t2wvJu0vyuqB1iYhj1BX0j/mhBVK4tGmI50xl?=
 =?us-ascii?Q?Tdb/Gbr1Y6MH5d5FjfN3AEgf7u+9eZx/Aq0qXGzYZ7HaCbthZOi7xapQRZb6?=
 =?us-ascii?Q?zv2lWJ/yF35h78R/7lTf0daJq4wjnaXSq0vPK6125sHCcIJuncEVQHKrFjF2?=
 =?us-ascii?Q?D4TDuuKcSoINwPUks1NFVXYyIixYVq2l4pxBXgqWhcYrhc42Seu2CgcELe5P?=
 =?us-ascii?Q?rbH7Je3Ow9Bje441dMAv6CeL3c7x4iLWKj54M+E+/vJfhR6zDqwoAf1OghG9?=
 =?us-ascii?Q?XTikla3JlHwntjr5zVo/nTWE1EBlz5wxzjJ1OfbaeE/XWsgWzVLpak8uciLF?=
 =?us-ascii?Q?5iYMapn0ro+GBu6Lzc2Qy2mGBHMERMpYuDSJO6Igkm6E7NlIrZOYi1jcNAtd?=
 =?us-ascii?Q?eGn9X5Q8fzL1uH75nQj1o7pHihaQe94RitwgO5z9ZMap7JZiFcQVFHMHZyxW?=
 =?us-ascii?Q?oeaIGwDNfxmiT4RhmmdlbRV7vL4OHatUwDiCvJ7s8Ks20NYT91/u4BMI2qBB?=
 =?us-ascii?Q?mPxFb/Jq6kxxnn48hG/34eT8zcl05o0wkvZLalUvlXkS28HceSAw7k3mspvY?=
 =?us-ascii?Q?DuX5qteaKsd4HKpxMeRZ90tjXiXdKUvTy5egaQ9Yw068usbvoIx7ajJzlxBg?=
 =?us-ascii?Q?lBXCQNUWplUiaAVNwhU6J9/9gzA7H//4urfxhY4rpB+BcuictW9YPHgNb31J?=
 =?us-ascii?Q?xPZ0CsW91hstgoRvpN4cw/qI3dqnu9QtKL9XS+nQ6TZvJerh0/UvVlkRebF7?=
 =?us-ascii?Q?2euMPsUNBZI+K91+1exXPxEWfx8xIDZi7ZkPK+BbZ/6kYKsyIKsNWtz4bPNW?=
 =?us-ascii?Q?B/uOoqx0zMT2lPMREtUjIl4U79maoDpNcdP+Uz3+PBaYT0BFW00w0IvCZkMr?=
 =?us-ascii?Q?gd2FK3zrgH0zHjCze8qKWTqULs/+tFglYTnGOo+oC9wiQb1k169sEj4nnpab?=
 =?us-ascii?Q?VH51RggwunDVBQ3ZJZGjgKsAujIrnOLkF6K0XxkZSSo8WRYI/grrh4cQzsDA?=
 =?us-ascii?Q?/R8lwBFePWBxcN/kTFlz2MtkHE8+s6mFroIZjDaOvl/DSNVijBzxXyFPzI/u?=
 =?us-ascii?Q?HyPcxtf0UCzO/9kwBa4v+JEuMuKCiqSvpqQQMuU8QhrXv5aoBEVlq2p1QAyI?=
 =?us-ascii?Q?FMZUePqKof8a48oWrQ7yp0jCMfNXS4Gbd24Lw0KJTWfJD4XXMm2NTdPdrOV3?=
 =?us-ascii?Q?oJSwVQPswQFP+u+Etl07EdZfLbxXBf3kpW/tCB+J429eQrc4+23iMBeGrpcS?=
 =?us-ascii?Q?uJ65NPR+Xukn9V+aMRiLVwV5C1szD2L9TbigIeEU2iewpdRfb5nWw0CmYcJ6?=
 =?us-ascii?Q?FAXDu5dL1dKcJzV7m1RJ6mQ+L6fHdcbEaPaLijrUyTgj3de+dTgKDzUo75EP?=
 =?us-ascii?Q?ZQsS5QyyxiDAndyzPjmb/Orei0k9W42YP5MSHoMx+PVpQVSBiKoUjBrelIco?=
 =?us-ascii?Q?rwUKDd6XFf9Dq0PAp8e0KIo29yfAqoowRfgDdGsV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3579869e-6bae-4ffc-fa1a-08de05e61db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 21:11:43.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8c969d8-33f2-4029-8dce-76d1b998192a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHqybMGD1D1paPkeGm4WYZVbaSuWJDPpkDIHn62gvQ1iA7GTAS+9+WxWa/AdRlo8ZgKaOBcB7P32eHEL8lZLVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6419

# Problem with git bundle --all and git clone for air-gapped transfer to of=
fline environments

## Description

When creating a bundle using `git bundle create --all`, all refs including =
`refs/remotes/origin/*` are included in the bundle. However, when cloning f=
rom this bundle using `git clone`, these remote refs are not automatically =
fetched, making many branches inaccessible.

## Steps to Reproduce

1. In a repository with multiple branches and remote tracking branches (e.g=
., after cloning from GitLab/GitHub)
2. Create a bundle: `git bundle create repo.bundle --all`
3. Verify bundle contents: `git bundle list-heads repo.bundle` (shows both =
`refs/heads/*` and `refs/remotes/origin/*`)
4. Clone from bundle: `git clone repo.bundle cloned-repo`
5. Check available branches: `cd cloned-repo && git branch -a`

## Expected Behavior

All refs included in the bundle (both `refs/heads/*` and `refs/remotes/orig=
in/*`) should be accessible after cloning. Users should be able to see and =
checkout all branches that were in the original repository.

## Actual Behavior

Only refs under `refs/heads/*` in the bundle become remote tracking branche=
s. Refs stored as `refs/remotes/origin/*` in the bundle are not fetched dur=
ing clone, making these branches inaccessible without manual intervention.

## Workaround

After cloning, manually fetch the remote refs:

```bash
git fetch origin 'refs/remotes/origin/*:refs/remotes/origin/*'
```

## Impact

This breaks the expected workflow for distributing complete repository snap=
shots via bundles (e.g., for offline environments). Users expect `git bundl=
e --all` followed by `git clone` to preserve all branches.

The `--all` flag documentation states it includes "all refs", but the cloni=
ng behavior does not match this expectation. This creates a surprising and =
unintuitive user experience when bundles are used for offline repository di=
stribution.

## Environment

[System Info]
git version:
git version 2.45.2.windows.1
cpu: x86_64
built from commit: 91d03cb2e4fbf6ad961ace739b8a646868cb154d
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 26100=20
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e

## Suggested Fix

One of the following approaches could address this issue:

1. **Automatic fetch during clone**: `git clone` should automatically fetch=
 all refs present in a bundle, including `refs/remotes/origin/*`, OR

2. **Bundle creation remapping**: `git bundle create --all` should convert =
`refs/remotes/origin/*` to `refs/heads/*` so they're properly restored duri=
ng clone, OR

3. **Documentation improvement**: Document this behavior clearly in `git-bu=
ndle` and `git-clone` documentation with the workaround, including a note t=
hat `--all` does not guarantee all refs will be available after cloning wit=
hout additional steps.

## Additional Context

This issue was discovered while preparing repository snapshots for develope=
rs working in offline/air-gapped environments. The workflow of `git bundle =
create --all` >> transfer >> `git clone` appears to be a complete solution =
but silently loses access to most branches.


*********************************
Andrew Harmon
aharmon@signalquest.com

SignalQuest - precision microsensors
10 Water Street, Lebanon, NH, 03766
(603)-448-6266
*********************************

