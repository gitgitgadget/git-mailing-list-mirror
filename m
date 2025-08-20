Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2099.outbound.protection.outlook.com [40.107.116.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF32DEA76
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723284; cv=fail; b=Iu3eo09TRt+OZ2hMiWSW43jbpla2DQLDaQCEO1wiGnxMxAxqJXkRI8xUCBdXTjMgzeU54lrCwW3zaWR/LDVPTbFi5lgeJ2R2qf22Pc4jNJPIPH8Icht+aIE1ZpF2c5nXs5iDeES8x/rdr9D5+T+Iiws9FkSNHrC3aLlh2iys7vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723284; c=relaxed/simple;
	bh=ytFTNkJTARDwPE/5FdJpNyhf1VcwRWvqjkjuFdmcPew=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P/YG26IRsKxt6ncK13xzAAqXkwx5bmxNJC3UVoZg9+dwAWARHogqDUl+l/Ij34h0zZrVcqI4Nax9ZxY5OXd0xbHzmNiehmls7d9GuRQZGsBIY/wiMPxUV0HSsbgwOJl6DphomgscHheIbNsp/hAEnWlvpFfa145nrB910MvRqig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=indexexchange.com; spf=fail smtp.mailfrom=indexexchange.com; dkim=pass (1024-bit key) header.d=indexexchange.com header.i=@indexexchange.com header.b=EVa6ysT0; arc=fail smtp.client-ip=40.107.116.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=indexexchange.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=indexexchange.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=indexexchange.com header.i=@indexexchange.com header.b="EVa6ysT0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3F4NOwVGs8Impd7gCGFIgKH2069QX7Rk+kNO8ULmsgxcmr2I166CCEqgQHylwu/cw/X6TQwb90Mn6/P7COk5UsHss+nXveEnpFEoI9uoeVp8tjgXZWdIPb4e4Pk2nhPIe9CGecMWl/k6TvrvLxNjn2Y5N+i/q76soHyqULrsTrkL9yfo+s+EAKNvMKCcWJqiW8NGkMuPK//NQQq61k97uXKtyfV54HVC/A8HyjN2YRZbwEDvFNaclPYMQXg6n8exYHDr36uPUwVhkw7IWZU3LBeZ+ydgn3wldAWSGUPOWjXkqMtGIO02fjAjV3S98JMYVvC5EMJ9bBBOthg5VIndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbHQCZKoy+2o3ihiI8b5tevsqkuwLpAWACyT36cWSCc=;
 b=TRbYkmnq8TumxlVk8t6Mx7n6IZdx/MMU09tT8Ji+Ghx6ZevMRUx4BfbSYzqld6DD6qPeV8CdLzNyoOx94fTn/3vZlzcMd+FHtCPTNE/xCxQtWpIIPUsAFLEgOjnqPVMHnBMAFfiJ60kbfxPHmAuo4DSJ48pnJjVvKfFaMPoD8tcSlSPe6FCxs2DuFtYm6W0/hRK5lbuXLhNkTiGF4HnslphUHFjBovdkf3prJcaojaPlzguXdMY0W1/LYaFxiWS3J5OJgjTUaZ1jAbynnCBb7S3Ap7/7goeVBJrv7UwHKXudqdGUWt1ZbgFhButQORsj1HGYFQ5cMEPzpuZ36SlD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=indexexchange.com; dmarc=pass action=none
 header.from=indexexchange.com; dkim=pass header.d=indexexchange.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=indexexchange.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbHQCZKoy+2o3ihiI8b5tevsqkuwLpAWACyT36cWSCc=;
 b=EVa6ysT0b2qyzG5NBaIoGGVqozqMGBeKGFnagmrsb+JsTTIpY2KZyTGt9cwwTnH4eb/Tz5zwYT1udR3uGnpacWW7NwsaufOs/SAtnlWcWXyL5a6LT0aqQj6tq+CGa1IPGq638jTZvnTPDxRn0tAI9g0oE/GVXvZJ0SX0IIcDCN8=
Received: from YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:47::15)
 by YT2PR01MB9509.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 20:54:38 +0000
Received: from YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ace6:e900:b8e7:dd94]) by YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ace6:e900:b8e7:dd94%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 20:54:37 +0000
From: Joe Drew <joe.drew@indexexchange.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "lock file exists" when fetching in bare clone of repository
Thread-Topic: "lock file exists" when fetching in bare clone of repository
Thread-Index: AQHcEhN2fwzTQSiO/EKbIMzzkKWbqw==
Date: Wed, 20 Aug 2025 20:54:37 +0000
Message-ID:
 <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=indexexchange.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQXPR01MB3046:EE_|YT2PR01MB9509:EE_
x-ms-office365-filtering-correlation-id: 29eea63a-7af2-4a88-1253-08dde02bc6b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?riwAHmwlWLhQNKgMa/+DeRr27QfNBxPMdk3C9h3m9zTwBMnV+jyPjZ3DqA?=
 =?iso-8859-1?Q?5XoCbTI+4KqnUvF5rK2hTdYg6UmA0Ql2QMLomTBZtDxjy43mXSsUd0/oGf?=
 =?iso-8859-1?Q?pPp7mJuh7wjeLgBhvTX2HniYPQWot3RAUSApQar8GRcu0bEcElmNB43CgL?=
 =?iso-8859-1?Q?kEfuorNJmDFgWLlfAIfb+iXfwP5uAysKP7ZfopkC9I0W8T0E+s1BS5JoEl?=
 =?iso-8859-1?Q?8uIFtAoNO+WnRT1IzEtFxdEI9rLlJ69Ph3tMXNY4hTj1hOfxVqTtLoEA/x?=
 =?iso-8859-1?Q?3SOWGQM5uxPbyIxlQzklXWdhOHNgkkQvqOp/OcRydqvbFcOvplfJ2TH+JJ?=
 =?iso-8859-1?Q?Tlta2B8+ZVsFgUEr4OLN946mAKD1p/rtVHkLy2FDVB+YVyIz90C5ROrpy5?=
 =?iso-8859-1?Q?kQ84dT8gJKY+CHkPFLiwYbjYis9CP6n8loRM9C2ft0wy12WGuHcZG3QV7l?=
 =?iso-8859-1?Q?HYkZVpWILAFD+CotpHtcdFmhFLU4Rd45dyMvkgjLPWeH+C7PV/yfhcWln/?=
 =?iso-8859-1?Q?hnxpuQeqfJleUvXnwzm14wa1rYoj+BwcaFKL7clUttvVEubYM/5iQOF2WG?=
 =?iso-8859-1?Q?JCxQU6KJUkMbs04A3iyVEJjYmRSGzAGUwXxBY+m9u52wbwrRjMTueYrgCs?=
 =?iso-8859-1?Q?3s4M7TlAmAi+w1bJPOcgmjrKtjRjUyDW2Yh/BetACkO3K7E6TTO3gawPJI?=
 =?iso-8859-1?Q?XVCIAK3vo7NRo1Q1Y5LDoM2yv0tGayExWxpLcjQwliwGpTl7tNVZvcZAzq?=
 =?iso-8859-1?Q?5lBfx+cA8FbY4/XVtpYsfYkfspS0p4zsyzO4qbD44zc94j1EqUbl6hr7HG?=
 =?iso-8859-1?Q?mklvAwFZ3DatM2qpi9F0fh5sbDpcDJx6WIJXOZokvo0kou+E6oBNfqBjiW?=
 =?iso-8859-1?Q?2yhRzZWeHmq06Uc/X1ZIaRn6XJtXTR/622lsY/qXEqf63kQi/BttW3pMmb?=
 =?iso-8859-1?Q?zEa6hYfV9U9+MHVCuf+oASBiTiyqpxujNLIVAnUkkAbwdzH/4ejAn9PkdR?=
 =?iso-8859-1?Q?2LN5ndDZykz2aROw//4J48GUcgoDJBFA18dMYZraAN8i30ox1KFdxDvBnz?=
 =?iso-8859-1?Q?d0KkRuQuRAgF+hsW23ns+Gi8qEVeLfGJJzR7bSYyTKp1xOJ3gaVOdgJgNA?=
 =?iso-8859-1?Q?g7NfhnZ2o/Shjgq7kYyxMtpbmKdb7g0Y+8n7e3Xk0BGDsSiy20JAwuLMcH?=
 =?iso-8859-1?Q?+rVpJcZLZ31ulO4boKwAac+6LGIEUyUua6/einlXUg7rvDTUEZDX8uEAzs?=
 =?iso-8859-1?Q?NzNZ3FroNp1oM7/iLdHysMqYoFOMf6xDi0W7vj689oRY9ZCXXDDEe95Dmz?=
 =?iso-8859-1?Q?rgVqsJoHwojDiHDM81w0Cq1h45ZI05No2u6iamadDrz4jzmcPKfZXHyQTU?=
 =?iso-8859-1?Q?LuzuKq6R13rLWt543zoaP1AoBUYlUMjzIReY7fMmD/aZRmdhM3jHe4oLu8?=
 =?iso-8859-1?Q?/TNJBunYhndEpWsUCfI4s/atdRUbHtYgifawiVlWyBpI2nS+HxO21azY4O?=
 =?iso-8859-1?Q?0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rnHjTCjhzSOmVkLonT+k7kxYtCHZNwAUrbeaZGyVwb1mt5pOP3yc2Z0QN+?=
 =?iso-8859-1?Q?zRO0MVUoRcyfIrYHVoahFNH3WnO5ggWQxOesYBErBVF+Ebo7D5y3pi3Jic?=
 =?iso-8859-1?Q?hexID8Bzn6Fdr4XHnIf6Jr5pTmzNgH/aEg1yhQxyMyTiYRGJpyprnPMmIN?=
 =?iso-8859-1?Q?SPDblJ6019uByZTT80WTJMQkfL49LcLsR7RM7Bs1jbi1ySzgvnB6HgtaQ1?=
 =?iso-8859-1?Q?vsGls8Jd/TNBR/WeNrNgtJcasQVmGr0OGQ3COKT9eLY76eg9jKiYpdvq/o?=
 =?iso-8859-1?Q?12JJ3rZbVy8JoIey2d+ivIcxHZN8JfOSkfkAoPFOleQGbeUDlUg7JwbulD?=
 =?iso-8859-1?Q?xcXOkBsmGxu59cbRwnrtKYmfDhMQmGE3TH4nARw/uBKNEL5eueME521BBZ?=
 =?iso-8859-1?Q?+L7zEE2Tj/cFGzSf4LfUjKgLGV7KtqIYj1NKKm38UiUNIREpD8I5ofttqS?=
 =?iso-8859-1?Q?VasWA+lc6+f2RbLcUOky/NpO5NRnH3e/vCONeFX5hTubBkK/uMcf+apP2l?=
 =?iso-8859-1?Q?5IABtOTJ2bk9XfYxmDs9/u4r6X+kcxAYFrA4m0g/4AwkRR4Fqepo12zSZb?=
 =?iso-8859-1?Q?nlnKZXnQBgv2iI8TVeUywK+fis1vEI1q7A6WdRc64DS1LhqqKkxZ0S3QZz?=
 =?iso-8859-1?Q?AxSybK2qw/KCuoRuvVsXjmPGQtLckbKklR7EcQMAh8UGof5G78lfsdTbBi?=
 =?iso-8859-1?Q?CM7aqHHqaMMH10b3dzRsPQ/Yf02TijH147lArsCoT4fIW0/T1bPR1wOh9m?=
 =?iso-8859-1?Q?v9IdXJd9nSRMl9N6l5MYiwcBGv5oZ3mVatRL5kZLlZOJ5hSUCFdaSRWiK1?=
 =?iso-8859-1?Q?1zZHw2z6qB/Nor34En2TFxbRgwDV8Sa9mYxAHiJPQ7/1A5Ro2lpsRtyj9h?=
 =?iso-8859-1?Q?sY0fSkCv7NDtUfM95w9dS4n/51k1pqXip5wG/lUWJ+acQWJDHhJ4xlJj9D?=
 =?iso-8859-1?Q?fawNZBzTi0HWE/LkIO1B1u0XC2mOe0PNAGC2KUWK5iBQXWKbAUzWze8Ufa?=
 =?iso-8859-1?Q?MH/nxCGKgAKcGZl4H1eYh/jS8ZO8cDY60bnmVMGyq0XkM6MZEhszoU6JGa?=
 =?iso-8859-1?Q?7rQJ149sG8NqIkS4c5ksyNq3CJ372oNsYZEX2DnwB8oqacNEAN2wnxFOzG?=
 =?iso-8859-1?Q?1AUuKe4Xij8XZ2FQKJdXrbFm84S3QxayfP4C4ABp/Ttqkzdhmgd42BxSHs?=
 =?iso-8859-1?Q?PfCXp/NEigENK6sgL10uLw8vfTy4pGJ0vuW3mqeW1OfwPa44PPCD4TNwvW?=
 =?iso-8859-1?Q?C6khxVUX6J4iObq/9Rh18OpssgkntwDXAWcU60w+/27P/oj/Qe1LbZQohy?=
 =?iso-8859-1?Q?biXV6vrtvUIkBMhlJkbCNRreTTd7EF9Y/ylr2GqExRzl2ZI0bOBYENWwCj?=
 =?iso-8859-1?Q?0lhc223lRA6kmPDPq3bpOY17Pm6wj0cB7b3d3g+YgwH75psgkEhq5IFyKU?=
 =?iso-8859-1?Q?zCAiJfJm10y80SRepJDXqrnNdDTq0eWKyAVSOkAPkoRGYzVHP38wCaA/AT?=
 =?iso-8859-1?Q?7OvTRyPsWTaQtX5nsMikitQ4DgWQlrpMFA1QikuoBOC+evJGgKYIOzXCQi?=
 =?iso-8859-1?Q?mAl5r8Mo/UBqqoxkrLzMQBSWmzgufsdFt5nfW0oPsMKRvwHUfRekvf81nz?=
 =?iso-8859-1?Q?IwBOwvObWhGS4pxOMBM8DunWmAdiAeu/KH?=
Content-Type: multipart/mixed;
	boundary="_002_YQXPR01MB3046197EF39296549EE6DD669A33AYQXPR01MB3046CANP_"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: indexexchange.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 29eea63a-7af2-4a88-1253-08dde02bc6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 20:54:37.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b07c0690-22b8-4366-8d8d-7b845d088e18
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32DrSPCi2H66QmRgV+xQo9EoCo+b1Fqhrt44rWDzYDV2kT6baodIHLx8BXoMz6PPP7tP6NW2jY8evvk/ft+Yh5oBLFMgp5xfeO38+bgW0iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9509

--_002_YQXPR01MB3046197EF39296549EE6DD669A33AYQXPR01MB3046CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi there!

I've got what I think is a bug in recent versions of git, at least as packa=
ged for macOS by homebrew.

I'm cloning a fresh copy of a repository into a bare directory:

        $ mkdir tmp
        $ cd tmp
        $ git init --bare
        $ git remote add origin -- <VALID-URL>.git
        $ git fetch -f origin 'refs/heads/*:refs/heads/*' 'refs/tags/*:refs=
/tags/*'

I'm doing this in a sort of roundabout way because this is exactly what `go=
 mod download` does.

The fetch fails, returning status 255, with the below error message:

        remote: Enumerating objects: 18733, done.
        remote: Counting objects: 100% (562/562), done.
        remote: Compressing objects: 100% (448/448), done.
        remote: Total 18733 (delta 399), reused 144 (delta 112), pack-reuse=
d 18171
        Receiving objects: 100% (18733/18733), 25.32 MiB | 7.93 MiB/s, done=
.
        Resolving deltas: 100% (14608/14608), done.
        From <VALID-URL>

        [.... quite a number of branches and tags .....]

        error: cannot lock ref 'refs/heads/ptv-2164': Unable to create '/Us=
ers/joe.drew/tmp/./refs/heads/ptv-2164.lock': File exists.

        Another git process seems to be running in this repository, e.g.
        an editor opened by 'git commit'. Please make sure all processes
        are terminated then try again. If it still fails, a git process
        may have crashed in this repository earlier:
        remove the file manually to continue.

This file doesn't exist; in fact, no such files exist:

        $ ls refs/heads
        $

However, the branch _does_ exist on the remote.

This error _does not_ happen in the Apple-supplied version of git: `git ver=
sion 2.39.5 (Apple Git-154)`, but does in 2.51.0, which I installed with ho=
mebrew. (If this is a packaging error, I'll happily report to homebrew.)

I'd be more than happy to continue debugging this, though I can't share the=
 repository as it's proprietary. I've also attached the git diagnostics, bu=
t they're not particularly helpful, I don't think.

[System Info]
git version:
git version 2.51.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Darwin 24.6.0 Darwin Kernel Version 24.6.0: Mon Jul 14 11:30:40 PDT =
2025; root:xnu-11417.140.69~1/RELEASE_ARM64_T6041 arm64
compiler info: clang: 17.0.0 (clang-1700.0.13.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash


[Enabled Hooks]

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

--_002_YQXPR01MB3046197EF39296549EE6DD669A33AYQXPR01MB3046CANP_
Content-Type: application/zip; name="git-diagnostics-2025-08-20-1637.zip"
Content-Description: git-diagnostics-2025-08-20-1637.zip
Content-Disposition: attachment;
	filename="git-diagnostics-2025-08-20-1637.zip"; size=790;
	creation-date="Wed, 20 Aug 2025 20:49:36 GMT";
	modification-date="Wed, 20 Aug 2025 20:49:36 GMT"
Content-Transfer-Encoding: base64

UEsDBAoAAAAIAKGEFFv/VYJnHQEAAIIBAAAPAAkAZGlhZ25vc3RpY3MubG9nVVQFAAHuMaZoPVDL
TsMwELz7K/bW9hDnQR8ot7ZIIMEJxLlynHW8yPFGttNCvx63EpxmZ3ZWO5ojO4c6kR+gJzV4jok0
kDcsxEAJzhgisYdGbmpZCT3NLagwbtfCM2gex+xRMbImlbCHCyULyVKEbibXi0hXZFM49kMLj3/0
Bqd0Fyw6V0wq2RbKjnwZrTCo0hywBRNH9pQ4FEWvMM/CUafn4PKl3MlaXDNvoZaNrBvx8bIv6hYy
1Ken4502m+1dyHg6vL2KHo2aXSoCmsJwGFXOYMhh/N9YFXOSaFUt3nHiePv+A4E5O5d+dm4l9mdF
TnUOIU5KI+RyFuVnzD2VX4yyD3gp0ziVUVsc1aKFptk87OS6gmc6wHLk2ScwTg0Rqu9qJX4BUEsD
BAoAAAAIAKGEFFtUJBwJawAAAB8BAAAPAAkAcGFja3MtbG9jYWwudHh0VVQFAAHuMaZolc5BCoMw
EIXhvafIBbSZxJkk3XoSnTxBC6ZoKD1+8QIV3/rn4w1lq9jqYcpsukeZVmg9ns171FebRIP4EVaV
AGJLsDmTYhJxEvwcM1uH2O34mKuFPsX+pnvWf1EnLD7RXXfJ36u77JiTND9QSwMECgAAAAAAoYQU
WwAAAAAAAAAAAAAAABEACQBvYmplY3RzLWxvY2FsLnR4dFVUBQAB7jGmaFBLAQIAAAoAAAAIAKGE
FFv/VYJnHQEAAIIBAAAPAAkAAAAAAAEAAAAAAAAAAABkaWFnbm9zdGljcy5sb2dVVAUAAe4xpmhQ
SwECAAAKAAAACAChhBRbVCQcCWsAAAAfAQAADwAJAAAAAAABAAAAAABTAQAAcGFja3MtbG9jYWwu
dHh0VVQFAAHuMaZoUEsBAgAACgAAAAAAoYQUWwAAAAAAAAAAAAAAABEACQAAAAAAAQAAAAAA9AEA
AG9iamVjdHMtbG9jYWwudHh0VVQFAAHuMaZoUEsFBgAAAAADAAMA1AAAACwCAAAAAA==

--_002_YQXPR01MB3046197EF39296549EE6DD669A33AYQXPR01MB3046CANP_--
