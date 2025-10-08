Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020143.outbound.protection.outlook.com [52.101.85.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66220010A
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947438; cv=fail; b=HNmABQklr55JemcpBO88dfPFvRWT6/nSMql1W0YXEuVYOSXyvRiEJL7BzQrPYkmAW4eInXQBzt3pwj7BEx1OFTLQWWuW2PxSZJM0uOEkQCucdUj0+GtrLb09iQWoFTRTPFcN8uQAH0kZOnP9vIaWOaymjC0nwIkH7v9JzgpgwPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947438; c=relaxed/simple;
	bh=UbLPyN7T5U1ZkgDzlzEj9dgPox7/Rxkx5imqMeU6acc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XyXAWBwaVQx3enw0GxMpvmKh1BqIfFPg2Uo0IeFTwj/HrtgXXzU+MEEZix9ltGbGpXCeh4Sonj0VKq5Iepc3+Pkj1BI1YPpPz90sBZ3Q4fhvJoOgknzy3w7HkKIcLQXd1E1QfigsvHjTKBW/UXW9Cxx2prg3fY5Fv/S8BacaOII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalquest.com; spf=pass smtp.mailfrom=signalquest.com; dkim=pass (2048-bit key) header.d=signalquest.com header.i=@signalquest.com header.b=qu9Q2WoQ; arc=fail smtp.client-ip=52.101.85.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalquest.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=signalquest.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=signalquest.com header.i=@signalquest.com header.b="qu9Q2WoQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gg0zawEJED9g/4mj6rbWBx3ETUWBhBADiHlioKtlQVCjtlM51bMFA5lwPYK0ireuajIVqZ4s09Xf3A4rGjAqp8konJwZXkUioJNUeYGxYqKaQL2KvjfqfYQHTIMWCx1KSh/rinI/qmXtsmZzv7GEDWFAXIrj4dLA2R8lSiLq6k/pkwiC6S92ty5Lf2gixkuSEHEHiHTBPGA01+IdIpY8xW58P3MUDbAWKbs9efLPVlnSunf9IHryjSgSkQgVSsTbIhJ6tp1LEzqWx+q42QiEooZMEj9RPJbmOX93zKqCgweulQnkY9XzR6h4mODgltDmH/8Zoj9TKOS/kxzEAe3KGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd3ZCp5PuB6gea1tsvGjpPNXNB8Bb1qMyHpGDlHAtn0=;
 b=VynNiUqwuaCkTIiUCNDmO/LIbJDiIeBof+K4kePe5I1ks5wY9oijVcCvEi5X8zcFmsUq7qz4z28O4T15462eJezA2SWS0cyQQ1uZyXmFpbdzbPGZSfWCv8JQQjOEdPI9/jrvDWcZabuuzDch9s7FFPnbyWYuVnX8j0wjyw3UQ4Tif+ijDFnrnh/YSVnnFeAq+KqnUWnkiP4fgh8pnUXff2C//GOJ8FytlJLDGHwxaozplv2UilXF4+UgA3rGnhvAw6YdipfOvRWHBrWal2hQf2eSq46mpapFXzYzNYhPvAg/DG77V4vxUohF2Dyn3sM+u+y+etBcaL+NOW6yeSbNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=signalquest.com; dmarc=pass action=none
 header.from=signalquest.com; dkim=pass header.d=signalquest.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=signalquest.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd3ZCp5PuB6gea1tsvGjpPNXNB8Bb1qMyHpGDlHAtn0=;
 b=qu9Q2WoQ7xTIudm4xvNArD1AccOX1GGZIc2tEhsKBAUawyi7+3V/LaGk/5YQsC8yO22DTPXf9juXVkyYz3RfkQmy8Gs6EokRTdU5n9OMt3UikE0wrA+VSF95wIr2mid1/08WMQFAUb5Kho9diFnIQqPxyoJdrBTRBhs9aPLDTeRIcLEYEwGw0wv1qiNqCvWIpgOGwgEeZ45EtQ3a/stJ3Z7Y9fjtZZY8Jbpq6SbNrmPMpXjJLWN42U+ulMNQyZrksB9wDxNDdEAZKvUMhPLPnrUHWm5M0cS5kc9JayrYxa0LnA3lVSWJGBy8h5rw783b0VytvE7xUCQGOtOVqSZ32A==
Received: from BN0PR13MB5216.namprd13.prod.outlook.com (2603:10b6:408:158::15)
 by BN0PR13MB4741.namprd13.prod.outlook.com (2603:10b6:408:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:17:14 +0000
Received: from BN0PR13MB5216.namprd13.prod.outlook.com
 ([fe80::46e4:e2f5:eef7:5deb]) by BN0PR13MB5216.namprd13.prod.outlook.com
 ([fe80::46e4:e2f5:eef7:5deb%3]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 18:17:14 +0000
From: Andrew Harmon <aharmon@signalquest.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [BUG] git clone from bundle with --all does not fetch all refs
Thread-Topic: [BUG] git clone from bundle with --all does not fetch all refs
Thread-Index: Adw3zvXxbRTGKqPhSiiq+FEJEt0BagACOg2wAAHn6tAAJjSTVgABcN1g
Date: Wed, 8 Oct 2025 18:17:14 +0000
Message-ID:
 <BN0PR13MB5216EC49DD37699C766B8DD6BBE1A@BN0PR13MB5216.namprd13.prod.outlook.com>
References:
 <BL3PR13MB5209A87037FC19CBB9B2916EBBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
	<xmqqa522icjy.fsf@gitster.g>
	<BL3PR13MB520981A726145113DCA8B910BBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
 <xmqqo6qhfgtb.fsf@gitster.g>
In-Reply-To: <xmqqo6qhfgtb.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=signalquest.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR13MB5216:EE_|BN0PR13MB4741:EE_
x-ms-office365-filtering-correlation-id: 3c9d8557-9828-4338-2aab-08de0696e813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Kp4pz4CtaXPCglhYzH9ZVNYzStbSIplCiDEQSZIC4xOqCsvpb8I+f8ybEZdx?=
 =?us-ascii?Q?YpvQuNbsf3AjCBPQhaPIZkI+lDn+A4sD0hP/UkLtWnmRh3S5zkf63u/zybCF?=
 =?us-ascii?Q?KASImclteniDKjHuDjcM/q724VVtRO3mEHVyPaLOkCnlR6XPlRGU+b72oA3L?=
 =?us-ascii?Q?t2mxkUSQVN+wjBiJjbFQKsi8eguNerSG6xwF/e9ZuUe6P8QDk96rek45gcnv?=
 =?us-ascii?Q?T5LF4pTlFLiBYgRlBjS67APERuEZATyc15Sxt994Skv/d0DzzeuMqrdUe/xr?=
 =?us-ascii?Q?qTH7yhUsbhGtWEAppNbYYVOLKFHB7zF6se4qQC5OI3BWCZO6eyPVxD1wJkq8?=
 =?us-ascii?Q?kzCTVuZSiYbmKJNMI69Ev5xyatQvpNTwsuourEFi0DrG6VbDvoSFjUhxXCB9?=
 =?us-ascii?Q?RyyhpzIcJJoMLfvYVPV+n+D1EpNrWkIlhrQk8bkO7+5Aw2qLe7cBfK+3ApiS?=
 =?us-ascii?Q?hmresJ0ht+MIqBhdbSfdMA/molngNelFLAqQ+r970fK83GXqsv+47wtPEynp?=
 =?us-ascii?Q?vuM/Vu9qMzONFB1eaPM/xqTwReQA53qUEJgXrI8x046w2H/o4F2daAI2W/sD?=
 =?us-ascii?Q?mNDHRtgmZK5ENbkhxNk0GFzxjVAfmAiqS46kUF/YBQjuWm6qq4adwwcNsBa6?=
 =?us-ascii?Q?dFAExLpIhKZFHu+M6+4f4kMbwtIHZrItpPqJeBZyAvfV1gsk9wwAXnN1o/Wo?=
 =?us-ascii?Q?2jpZQvqINYcTW4GQi3Kv1Mw6anDtbu7VpEMfS2KlVo+KbFGPFRMgQrOvqdYS?=
 =?us-ascii?Q?jb0MKUt7OUmVM57pZBYkevDAM+xQKq3W+eAqk80M5IubJZ4TKc6cq0gxt9WK?=
 =?us-ascii?Q?LOqL8HkVBsaLzK3CCaaAUQuQrHd0gcX7L+FWULVasqEEfiSL+dn1SKYTNnm1?=
 =?us-ascii?Q?6E+YCjkO0na1ynl180Q40tpSqbznt2SGPqUYN6/+grQ+9AgqtlTXjhMtTXO5?=
 =?us-ascii?Q?z7B9nyqzdMxd2DtpXsusrcXNH2308NRMOG/AzCstfyhxp+tkGJDW+aWdhggZ?=
 =?us-ascii?Q?oVXNkJp35qwA1Swf1cv7nwaTkc2E1ysqB02Q7j8LYIzswe6Pp0uW1yFobH3J?=
 =?us-ascii?Q?rnyt+yUEe5IuHruqDIQXLTu1uBTlVoUaFrRxGWGTXStGlXH3SfAH70pKbkhF?=
 =?us-ascii?Q?XwqVpOyshPVu6YGfGr7s4682Yk+cq9w519zidydSgFsPwL9Jf2LriomjD0gp?=
 =?us-ascii?Q?sQw0IL+UTCLXnTw6V++EMIswADyzhDXhqQPQ/fP1naoPYlUMmuStieQ58PcW?=
 =?us-ascii?Q?3qjjjVpvJTngudr0sJb5LMuIUYbtU7SXBKY5OOL/oMtTp58dPWQePWyD5aBh?=
 =?us-ascii?Q?+TB3hzmo+ouB1vtRawSeopgGQh5kSsU7D85CR4XP4JzWHKN2a41gJZM1rEU1?=
 =?us-ascii?Q?4PmQNb2O9n++VVNR1R4xYKYchwDObH30NEhejFegUwVCnmgdiEwCKkNA6OeA?=
 =?us-ascii?Q?RbJMd7hoJxc80alo36gzEPuUl0EXxZy/oNKArf6IXIRLVv0jm58Dh1gk8Gx9?=
 =?us-ascii?Q?g6/G7qGVtTnfN9l1bvLJaybknQaXNGqLM743?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB5216.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8Y4pC0bjFnagtzY8JDqlpoFC51Lc7ipug2ExLCHxJ3RZA+HGFwD64pTxinza?=
 =?us-ascii?Q?eVDWLFwU679NurR2t5oPx+XMLVeckuq5xnA1uZjQZZGy9bQHKDUd1MqH9QH/?=
 =?us-ascii?Q?VAGLPppt+J3MTDKGqOck+BLjtBjDxXfgpP1op7w6WojHnW0PFiF/a0eT8Y1a?=
 =?us-ascii?Q?p0QmwumGQT8FVcmsiFpA1PKVAVD2UhF4B1T9Tza/nhpiJi2DQkCw9iZpZmAC?=
 =?us-ascii?Q?JySMMe8mOSS1JAF8LP3c4DFhIniDiKj0s6VjlQeAoLShiAe/vFYlMKrYZaQI?=
 =?us-ascii?Q?zw16tshkOh+TsKhEJwrLXikh1cXSkrYXBsGX2Z/ORHqz6Rk1H4oKOe5ZJSoe?=
 =?us-ascii?Q?W4KAcwUWJQq4k4fv9UgelSXmd3vG74gTFqRSU0tlYzOoOVIZvBQXVMFW9cTO?=
 =?us-ascii?Q?xqljGMIAYsGhFy4LzQ0oS9gJpgPz6/XpS1bRzGHMh5AZG/Y9PLtGtDkHprpp?=
 =?us-ascii?Q?caJUP3SKLm5MuK3sAGz0sV4aem4GlDaKKigpygpc3Ixubx6nMZ8o5U4yto9q?=
 =?us-ascii?Q?+x3hT+YVSLk+S5iT9Fi5Qtl5+1dy+dY3RseNvkPgt0jYpXS6ad1kV/pPgI9a?=
 =?us-ascii?Q?Psg1x2/WT6xcAYNRsB3wNLlYhwHz4Dc4xZeb1er4X0xkhMd274tl3EOP0s4T?=
 =?us-ascii?Q?AfffIn/CgNTlU1dnoLsNXh7KnsLn71DE0UqU7eGVy8eyHhWX0pw8F/O+I3M9?=
 =?us-ascii?Q?pQ0JxG9gm9Bf4WChid3o8wtbO24FGh56uZVmiql6hmC/XGeN1QfO5TzyDc4m?=
 =?us-ascii?Q?bL8CmcyVSsPZc3XVJr8ru9e0WsCbMjGuSQOVanG4+XoXiazdYz3AWBz8fVkm?=
 =?us-ascii?Q?NI9S0KpVEjOolfUS4rXjPeO7/NSx9tHuAzEyydvUDPtG+Roy0uVyzHFoOdSs?=
 =?us-ascii?Q?2Mc7px+g47VueOkiuJdQNBQXdreS9If/+WuON95IjMOs5hbc3YpdR03TpNTa?=
 =?us-ascii?Q?Zg1fxhpJN/793UPSN17yH6dea8M/sE80EfIbV8WzVDT0wV2EkSHEmeanYaza?=
 =?us-ascii?Q?3FFjeMHV24T2uuCF1tRIaiBGuQRv7InnQN4WR6R28C3P+zkNoQcjmMnWlZtY?=
 =?us-ascii?Q?+FyGyZ8rWQ4Xf9uV840EsO0fiA+n+qJQVL51bO4/3PRadyb48PisVQgG5vYp?=
 =?us-ascii?Q?aNjQZMVAD4+hqf4xc1u8uXePlTnW9ofhP1OivFW9nHGQuVRE9zaarTbpxl/B?=
 =?us-ascii?Q?3Shavlx540301mlKwwRr6miyPpCoU4fODed7OwrnqQCKrnsOavhryiuRdhQC?=
 =?us-ascii?Q?9cboWDDUh7sxcZJwSZIsByEPfMtdC0FtRaObOcmM+5jbI9c604RTg99cg5lJ?=
 =?us-ascii?Q?0VDr1J6gTTnOSsuh74LcxqDYTl5kPZIbdyFymV/n/I2pYlpX3g4+xNhrwVRX?=
 =?us-ascii?Q?Zg4or5GIU5f9erISXJ9OmtkWCGfv+mzQ0/u2y+0S0pAhjmhK/GXU1rsjIna8?=
 =?us-ascii?Q?eMCuxwLXsKIV6SKTgvkupogihA6uSMBNS/I3RamW8lbxeGFl7OJcUuCUqjpw?=
 =?us-ascii?Q?omKqzYI+mn4LhhQrkUeLcnmp52lDo7yroPyOnhvf1QZEFbUmZEXQgY0yuMRU?=
 =?us-ascii?Q?0LxetWFmJ8blEO1mBWqAxlxW536l/qkpQGTeI6Gz?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB5216.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9d8557-9828-4338-2aab-08de0696e813
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 18:17:14.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8c969d8-33f2-4029-8dce-76d1b998192a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQD2ZXOk49DOthyHUIN4GwJJmaxUr0Vs9mKFei1kQS8hXnUky9c6ftJhrx+Fwgk5zxZAPvPxVZokFKWNAvEp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4741

> The primary and only use case "git bundle" was designed to cater to was t=
his.
> The user has a repository on this machine that they want to be cloned to
> another machine, but for whatever reason, it cannot be done over the netw=
ork
> by typing "git clone ..." on that other machine against this machine.  So=
 the
> user makes a bundle out of the repository on this machine, copy that file=
 on a
> USB stick, bring it over there, and then the user says "git clone ..." ag=
ainst
> the bundle file as if they are cloning from the original.

This is exactly my use case. I found that I also needed to do:
git fetch origin 'refs/remotes/origin/*:refs/remotes/origin/*'

As an end user, I found this very surprising. I was expecting to call:
git clone <repo-bundle>
and have this behave just like:
git clone <ssh-or-https-target>

Maybe we are talking past each other? Following the documentation, I didn't=
 think that anything beyond "git clone <repo-bundle>" was required to unpac=
k the bundle.


FILE: bundle-demo.sh

#!/bin/bash

set -e

# cleanup from last run
rm -rf matrice_sq*

echo ""
echo "Clone the repo via SSH"
git clone git@UBUBEAR:external_sources/matrice_sq.git matrice_sq

echo ""
echo "View available remote branches"
(cd matrice_sq && git branch -r)

echo ""
echo "Pack the bundle for offline distribution"
(cd matrice_sq && git bundle create ../matrice_sq.bundle --all)
(cd matrice_sq && git bundle verify ../matrice_sq.bundle)

echo ""
echo "Unpack the bundle on new machine"
git clone matrice_sq.bundle matrice_sq.new
(cd matrice_sq.new && git branch -r)

echo ""
echo "Manually fetch refs from refs/remotes/origin/*"
(cd matrice_sq.new && git fetch origin 'refs/remotes/origin/*:refs/remotes/=
origin/*')
(cd matrice_sq.new && git branch -r)



-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: Wednesday, October 8, 2025 13:24
To: Andrew Harmon <aharmon@signalquest.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] git clone from bundle with --all does not fetch all refs

Andrew Harmon <aharmon@signalquest.com> writes:

> The experience of "cloning from bundle should be just like cloning=20
> from github" did not happen for me. Maybe I created the bundle wrong?

I did not say "github", though ;-)

> See the workflow, below. Is the problem that refs are put in the=20
> bundle at refs/remotes/origin/* instead of refs/heads/*?

Everything looks as expected, including how you prepared a bundle file.  Pe=
rhaps your expectation of what a bundle file is for is different from what =
bundle files are designed for?  By that, I mean that you may have a use cas=
e the designers of "git bundle" feature never anticipated.

The primary and only use case "git bundle" was designed to cater to was thi=
s.  The user has a repository on this machine that they want to be cloned t=
o another machine, but for whatever reason, it cannot be done over the netw=
ork by typing "git clone ..." on that other machine against this machine.  =
So the user makes a bundle out of the repository on this machine, copy that=
 file on a USB stick, bring it over there, and then the user says "git clon=
e ..." against the bundle file as if they are cloning from the original.

For that to work, refs/heads/master in the original repository is stored as=
 refs/heads/master in the bundle.  The remote-tracking branches may by defa=
ult not copied into the bundle, but you can by instructing "git bundle" com=
mand.

And if you want to copy the remote-tracking branches via "git clone"
or "git fetch" over the network, you'd specifically ask for them, as "clone=
" would by default prepare fetch refspecs for their local branches to be co=
pied to your remote-tracking branches, and their refs/tags/ copied to your =
refs/tags/. and nothing else.  As a bundle file wants to imitate end-user e=
xperience of cloning or fetching over the network from the original reposit=
ory for sneaker-net operation, the need for specifically asking is the same=
 if you want to grab (their) remote-tracking branches out of a bundle file.

Stepping back a bit, how would you make a more-or-less exact copy of an exi=
sting repository over the network?  "git clone --mirror"
is probably the mechanism where their refs/heads/master becomes the refs/he=
ads/master in the resulting repository and the remote-tracking branches the=
y have in their refs/remotes/origin/* would become the remote-tracking bran=
ches refs/remotes/origin/* in the resulting repository.  So perhaps doing t=
hat against the bundle file would do what you wanted to do?  If that is the=
 case, then perhaps your use case was covered by the original design of the=
 "git bundle" feature after all---to allow you to clone or fetch from the f=
ile as if you are cloning or fetching from the original repository.

HTH.

