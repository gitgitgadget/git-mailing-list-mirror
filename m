Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467934AEEB
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280514; cv=fail; b=tj5kXD+nG+ObeXWh+FX1HJmbNQm11Y1M/CZkL4TFAWuLr86HUSSh9oggodl1g7wiL2kJiZ/0lsgQ1WiEoFzeVx7EKIYi7TmY4zrtsuec4l+WR76/jbMBHJodlJGOZ5QSdMmUhb5A1xErOQQNxkqzZlGgbVmgYq3dr2q6dvqy5V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280514; c=relaxed/simple;
	bh=3nmVNqS1VqCYq86wSLtrdK6gWFQ5E6TlfPojV1mBY18=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pk+a8lBNKmyHG8N7uVvcOVjImvd5J6HMytWKZ1jByN0+gUsZhr0iyHrYOCi2DPcvU652FRlMES6M1LTLMcG6IbCBZf0jKErK9HIQhQU+ORx36XXX9J+cL6rqg/5Yc0pp1QqrwqS6IT62KXiAE4oTgEAwMUXdw6K4YdcLMamS1Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=WNuv5EBK; arc=fail smtp.client-ip=40.107.93.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="WNuv5EBK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6hsRDrZUz5IzmVJisdGk1Ku9jHaq2WoKK0HifYX8QVwEjk+3bSsWqdaC/MIXkSUIKK6HNohUD7b04B9cvLT79x2fWLuLuy2RXL4IFgZgDpXBUeDunmN+BChzH/PPlQ725Qe9VqKSEGgds/3KMzsyqAQdmaMjbDfSvZozKGQKz4qnpkS3n/YP6n614Nc6Qp5sVk5BrTA7rfc7vQk5/yb+Vz39G4MvGjuN0f36oDNo24UpGlkGy0FDoMJNeGtlQwFurogwVA82p2ciDA4CjuEw2OPJ7dTDI4LVxHbbeYKwEtJ3n0nHfRrPMj9C6DMwSMsUDg9nbpXlBcLChFjqLfxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48UWEj+6xr0plq6d91bfjkDruUpZseVUx2oMdHwJpmw=;
 b=SLH9tZkOS3plQta3/l1B3f4QO2xxc74Pl1bI4DezkAqHsIm6N4ppOfphBt6etzy2/BKLpoUNqwJ96RF6GA8FFRIn2wHqdGuB1+QX6NP2RuBfMMWHwsRseWPtuu2tTgHIb/A5WAFGNjgKIp6b4+OT4DbPpksi6fTTzgNkTEUL8UkjT22sXKih2a7ov7ISueo8eH9kN4XNFBqKmNfHhdco/49dhIbfH6jfwyxIvXGdPCaUienZ7bczrZD4SUhgQEVfvcx1pu6RJgxt04wbSL2v9AoXuaRg7bixh3pkRV+Uq0s2a/uzxpPmC0cJOURO9RCbiVOZP+jsgqh1ftSNVRAhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48UWEj+6xr0plq6d91bfjkDruUpZseVUx2oMdHwJpmw=;
 b=WNuv5EBKmfNIzssmq3K7IBTmQvZhygiOjEPSQEEkYtg16P5gLpyka4a0RuITJmC2qry+4TdVW7xoK0se+6Ez0r0+yEBVYwieeJqB/WHDEPz9X0YQz0uE2KzMd00N8PONiX7vZ8IcDXKGMgIGWtLu264M37pyyWWM7FL2X4yX3mHlfJGUAhNh8DXB7Mn56cPDBgwc98kqhnC85GYRjFFUZBNBilMN5lky04sw5f9r+rm6JeqvVdwZ+c+SVZNnL+xkS3vP3+gEhkUrlKiORjdh2bMen/Xhz2+/UtLRa3If0ukOovR/pIxyO2PIMtDfMdFhSjjkTaIboQLcbQjYNVpXzg==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by SJ0PR14MB4252.namprd14.prod.outlook.com (2603:10b6:a03:2eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 21:55:09 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 21:55:09 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Christopher Lindee <christopher.lindee@webpros.com>
Subject: [PATCH 0/2] Optionally support push options on up-to-date branches
Thread-Topic: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Index: AQHadLHezsdN01rhbUOhmHwkmqTtTQ==
Date: Tue, 12 Mar 2024 21:55:08 +0000
Message-ID:
 <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|SJ0PR14MB4252:EE_
x-ms-office365-filtering-correlation-id: 54a4546d-bb3c-42ad-26ff-08dc42df15ca
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uDPh9JqcVbxs4naWSyejmYiD3oRz5FBvqwrlloLbq2CGyvpa+VPuNOdx2LJ/yyroyAKTqErLhaifgXl4mEI7Trs0eKVDmgrNPnGGiliAn6+jtg9wGMTmHGGCvhTbq63oY5C9zYcQ6JBRMzOlO+tFq9+bv+rgTBggXwhbDJYDaFL1gmlwNqnRjzmFuYkedxrHOV2fDOnMbGtGOi/njhbdGRynlYhNEDFgho6HcVcgVOZXEDKyk01+i92xawR6hrw9luLyjKHPzT1qyC1yz2z6fDqonxqc/l470Q1EiNWjz4tTacfZIK95qF0QSGttnCno+yc2FuWWkmeKOYdR5NZAJyaR2EQktkkflwNqqa0m6ZLG0CfFWCfYCjEAdc9F6TUWuawnkxJBsmE1SBicvJRDU3QrHLRru38px+f7I/WPEwGDH4xMWrad5k2L+x60xjqyHL9/ReB1wGIisch9iQU/TyPXK35Is/fXk4UZz7DyQPs+D8wUhgNZuX9nkX0FC6pJD/Uvmdsu6MrOHyzeswcm29r94uUrtbR47FWommj0F6FyhoMmFpqDHDdsfNMHxiAG+lO72JK8lVDf6lELR4YrwDytiB+ul+UkLAn+dOo3+eY6zx9Fv95NhpPtjiduCcOAXICHP8Z3yMkhDJYhQXgZhBUhA1Y+XOF0IDX/PA5IThdlBBVI05IZc0obF2x5vTb8uvpOTkvSNNg/WNGrU9Q0MzrnqiBuHKU38FGegsxyTkk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8MQrCWmkuK5i2M5YGISccZMWjY01uJY5DLmMtbU6ZLio29lHW/p6Fb7jIc?=
 =?iso-8859-1?Q?IbWPydelkEyvFt4Ni2im2hfCQS3YtJT4CAhTjQBXI+R86WkFzTcqRvIp9v?=
 =?iso-8859-1?Q?svAyYaz0vvdJjehddjamEaJ2sdncVt9R8TQ98puuDOviqrPqtdp6B+rC5+?=
 =?iso-8859-1?Q?cz/Td93QSQVYFoc9neTY5J1qftf7upqcBDX49NXpdmpZw295qspjTJ42z/?=
 =?iso-8859-1?Q?VJot7G3ejz+oZyrlexSF5UZBbxVSli/MBfCh+4v3vbFZBSKs0CcV9a3pJJ?=
 =?iso-8859-1?Q?OatRBTovv3iBIH+KGIZ1+A4h60GmnoDfaGxx7SPgdnX3tN52rBn/Hum1vi?=
 =?iso-8859-1?Q?+ETzV/QskAzxY4z16gpbVO7qHH0nBK+5Ol9X+W8IvsFbj78vntHGcSIy5m?=
 =?iso-8859-1?Q?Vzv4YnBoHPWF/aRkJT0zfNdjsgXCroUieqm32ksVPn6tgAaFEFVn4vG+wZ?=
 =?iso-8859-1?Q?Bh+iVHj/aEIh4z5pdDvdkMUJFbn4ChoUfu44hE6ACQzDTQrr0jsaNYBRik?=
 =?iso-8859-1?Q?D14R/ssUROCmxTKZz8mBmDH+Ielt6BjI0MDocq/cNx+DEMJVLQByxhoTym?=
 =?iso-8859-1?Q?wuFjbpQ6AScm56BOJeXWbBQ2z8raCZYhR/kWY5zskcStcr/WKAUEXbXtrr?=
 =?iso-8859-1?Q?IDwWgIb1/xZxrtLYQZ+/YmXGMP3mf/5g6Fx3IhEvukrtvHmIdZFp6W+yqR?=
 =?iso-8859-1?Q?DyLAHvNliEbNXLVGIMdAQ6Brx+4+J1VPaiAd9z1ZTwkqQsjDPJObLVPVaM?=
 =?iso-8859-1?Q?MD5cU9h1/G1uYB/48+SPywI3de4qUBVhZHfuWtCA5Gv92Mb3LBDEwda8MX?=
 =?iso-8859-1?Q?PUVnntNXV4y4eOhK6Oo7DH4KlM/R+ZCoETT/austhHY3d70fOS/irvxdqy?=
 =?iso-8859-1?Q?UoIUqg3uM6j4WNhH0NR2QpRIYTEPSXzaMo1jXPrOx8UjzFCfbCbZ+cm7tx?=
 =?iso-8859-1?Q?2pfXkBDQq4IoILBt5pSFwwqr0dTuh7psrnGL3Ujp+YD8vOrj2bff5ahkhF?=
 =?iso-8859-1?Q?c4XtpSAM3zCyqMxLsLbFeVDyeOimmiLu1c/urrdv+2QDlYL+2mxNJhP7pY?=
 =?iso-8859-1?Q?sQf9XcMSM63F2JrowQ61VBeWBcGkBrGaF7n1hscFMfDwph7GhyjBsIYYY4?=
 =?iso-8859-1?Q?v9RiALkPdTY42WSDzP8hkSOGFFGZqCGL3hrVqyWwAQbHhI2XzJasxZrHjg?=
 =?iso-8859-1?Q?D3BkPFfjz+9IFV7pejPRNbgZCySGMyMObX6XpeDTRtXbgcO3GlJ+58k82w?=
 =?iso-8859-1?Q?o3gQdXXoVSMolSTxRNOfjEGCYWYP/5fjsQYYK9v4fLzhVtMGLqQ2hmBQAN?=
 =?iso-8859-1?Q?n5RqZ0vS+YxxkdkJGKHcAoD94nJC+jBIazNZDlwF27xZtN0lTb+Az1/goN?=
 =?iso-8859-1?Q?Tv9NIMhWofYAgnmrva156/SiWBUAAKm1so0BiAlgBkJ29eF92FIu5k4+Vy?=
 =?iso-8859-1?Q?S2oA0lYO99mQr/u9J8OaYUXEBuNjhfJRtaGmlXbNfkfZbXsR/1TJJpO3jA?=
 =?iso-8859-1?Q?1X5tSEXVAvVOtSFh+0sNkB4+MzMql1ik5gaW+rj9GJTgT/2cbPkLHiSXMs?=
 =?iso-8859-1?Q?6QyKIQLU5sYB1FEUiNsfy1X1A7FIG3bar2pfASAQkVifhHm5nXU0MiilgQ?=
 =?iso-8859-1?Q?oSMMHaPRo83aj5aCp9UgK7le+5aaieg0YvvtShzOHNgPhmMynfr/M8tg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: webpros.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR14MB4691.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a4546d-bb3c-42ad-26ff-08dc42df15ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 21:55:08.9988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dp9nEFodqbYJDhgmeJNQSp3Eusmhmn6nWR9NJ38MHacGuGZKikc5y8fBxm7S1RfqY5RtU7kQfMDSfZtXOn8dA2NJSW+FTAO1EfaYKNu2Ki0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4252

Some Git servers can take actions on a branch using push options; to do thi=
s,=0A=
the branch ref must be passed along with the push options.  However, if the=
=0A=
branch is up-to-date, then Git submits push options without any refs, so th=
e=0A=
server is not given a branch to act upon and the push options become no-ops=
.=0A=
=0A=
This means a user who does the following=0A=
=0A=
    $ git commit=0A=
    $ git push -o option remote branch  # Performs option=0A=
=0A=
will have a very different experience from a user who does=0A=
=0A=
    $ git commit=0A=
    $ git push remote branch=0A=
    $ git push -o option remote branch  # No-op=0A=
=0A=
The latter could easily happen when a user forgets to add an appropriate op=
tion=0A=
on push, but could also happen intentionally when a user wants to back up t=
heir=0A=
changes to a remote and then later chooses to submit those changes with a p=
ush=0A=
option (e.g. one that creates a pull request) to the same remote.=0A=
=0A=
To work around this issue, the user needs to re-write history between the t=
wo=0A=
push commands in some way, either through force pushing a temporary value t=
o=0A=
the remote or by amending their commit to change the timestamp.  Either can=
=0A=
impact users who pull from the server, as well as automated systems trigger=
ed=0A=
by a post-receive hook.  With these potential side-effects, this workaround=
 can=0A=
be a bad option in some setups.=0A=
=0A=
This changeset proposes to address this issue by adding an option to `push`=
 and=0A=
`send-pack` that, when specified, will send refs where the old-oid and new-=
oid=0A=
are identical - instead of silently skipping these refs.  The first commit=
=0A=
introduces the `--send-up-to-date` option to toggle this behavior, while th=
e=0A=
second commit updates the commands to output an `(up-to-date)` notice for e=
ach=0A=
branch with an identical old-oid and new-oid.=0A=
=0A=
Notably, the `--force` option will not send a ref when the remote is up-to-=
date.=0A=
=0A=
Chris Lindee (2):=0A=
  Teach send-pack & push to --send-up-to-date refs=0A=
  Add transport message for up-to-date references=0A=
=0A=
 Documentation/git-push.txt      | 8 +++++++-=0A=
 Documentation/git-send-pack.txt | 7 +++++++=0A=
 builtin/push.c                  | 1 +=0A=
 builtin/send-pack.c             | 4 ++++=0A=
 send-pack.c                     | 2 +-=0A=
 send-pack.h                     | 3 ++-=0A=
 transport-helper.c              | 7 ++++++-=0A=
 transport.c                     | 3 +++=0A=
 transport.h                     | 1 +=0A=
 9 files changed, 32 insertions(+), 4 deletions(-)=0A=
        =0A=
=0A=
base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0=0A=
-- =0A=
2.38.1=
