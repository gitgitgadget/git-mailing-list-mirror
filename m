Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD030F7F3
	for <git@vger.kernel.org>; Mon,  4 May 2026 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882845; cv=fail; b=Q9d+CBcSyJ8DsHFxPnMV8iWBaZ/SNQ/lRYrzZb+/4Uj0Jfx5h0NpPhpHdsvQFPIk+/6hYQ16Ae+oPcfdE1apl7v1W1WMbms4XJ7cpJVIie5Udr299Cdp3mrUQo0QGgIxzmbM7cW3zkOTs7MwcBPJdTctJNZPVg35uNub8VdKi04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882845; c=relaxed/simple;
	bh=VvqqK1SFA+xIGBD1A0xqbMTowa8fB4oQzUXCHziVeWw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iGSv1Yv3PLDMIPZmb4Avbt35uJ5Cch0KGxNH49kjUxvHYggGTcHax+sCMgY0xx+F+5fqxqynjKk9GiVxQn/rTkb3G6wyymUJn6fJWP0vlSNqdp4R3BosDcv2YEb4OV27ll/bFcqla0x9o0fVEEHI54BJqEipVAyebcAi29ePJ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=cQ+DD/ML; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="cQ+DD/ML"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNyLB4g8auz8EU2cOBcXZ0iFeGwXRG5HHaEK+OUglwyNQrGqsmd/awDtTddvOICSoYkfYWApYPuoEFzdrgR3RDKI2zIWSWOi9k5AiumQVckR7nlfJfav+XRhtHoUE4Xq8pZ10xHoZSlpjH/zcUKEbRWpRAKDJCUNdjOwtldhstCUGfgFDVc0pU5b/47mlxcTF2VtKZUWuUnKlT4k1aomMvFOCqRRUChJYOjtPHAimE6D2UtYQcv8dXOsH4HvdJKLf0lSDPBoHh6PVWzCDDo3OqeEnyhQZnucW573ks95t0HwpcWQ/k4of16C238MbncMR+oP4SfL8kqCCvOzuTLB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miCp7VTUmYeD5Hq903bNkSJhynnphXXVXd51FKGYoWs=;
 b=TDtd28Bqj+xDMavDwbVALacpmETmR1TV3xS5GwhWx+/ru8rrApLiMmaJnE0+gMvbLYMd3UoBfQj2iT1znzlPENL2EUcf4aTS2btjHuVR61xEiuNxfUlkQTMsnBSuYD+EC59gzg2yjeOJckrwce3gqdU9x0hzhqmZwbdUE+t2IQoNLfo0zMBCHW/7ps4hKb3EXuuNGs74ndzxTmj87fO8AIiNzX9Z8gcDarRqK8iCKeRr2LMl3FWsWiGqDkWYCX/6cBMK9wO6qTUMUxYp64H4DQEOfoFdnoJaW4Bn88My/9yYXGRW2hm42Ph6fZ/L36dONxrMnum3xCmKshongMAwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miCp7VTUmYeD5Hq903bNkSJhynnphXXVXd51FKGYoWs=;
 b=cQ+DD/MLKLygTcRuAZnEGqV45g9Ls3yXWay9aP7UsAoW23eFnNZJ625qG964lPocXtZmhBaUDfQto2WmuzXt0hF5wmfmGNy3rpwAbbvHfUtqnJsdR1vzJ+V67Nm+Uw0wQ9YMd887f8qptR7LxXSYgnlCarzI3NMJcdJjxj3h5XA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:328::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:20:36 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:20:35 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: git@vger.kernel.org
Cc: emkan@prevas.dk
Subject: git clone with --dissociate sometimes fails to check out target commit
Date: Mon, 04 May 2026 10:20:32 +0200
Message-ID: <87h5onsi0f.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC18.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::265) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c057ffb-e2eb-47bf-718b-08dea9b60430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	C0WsxT3UeL4r9w8/4Uh3X0FKrS+4dyf3bE98I9bT/fetN7rnAd7Bl3YfqYt1QWLDd306ESirYld3Eg2xJtbIXtQ3W9dogBey24L5aZ7uyMT7tMUnjP0pdlNwE3yvlIT4djEMmdf5aO7CJsSZ013nImQD4m7RIMnAre1mNwdlfdVJUV7njbkXcP50+iYp7U5qKf0GJwN+xErIyV45RsF8jNq5QA7z/LLm1RdaxBiVwqqQUgqihHAlrs4EnL1lI8ouBkdI3qhPofYXu8Jh0L7LDLXTUBXj/+QIjejxgZmD0V6DSHL6maz3wWI+V0uxHurZHiEifYouQq1zPkpx0BZj/b4M1XE5Ywcv6vH2n7yr/zg1Y3TJ1EOKEWehdVJFsRKWtbKz+lHgnhoZQuYlpww/PpFaKqlIIELFqzuKVfZkbE1kamDpyHVOs14Uq6fSMqkxSFKZwMf+ZqoriW4vu4IaV3JnC7PSbUyroqlvXdSbYxCDhtFVSjob8L070qa1Q/rFSbv+tWBq38RH+gafb0xKLhy2SVOJC581aynwItdjvNAmW1U366cTHBiJQxGCVMgw6VaqDBb3LW302aJEUSrXngu0mcut3Vqi7/q390Cy3PelJlA9EfiQzHc4I02y4UEdBf8vbVATUuVrI1l62hEOfac5JK4i83b8GD35LWSrAGlfSJP6aCOMZ6RBlXolkAzamFDk173rb4oTUpLMmxGRDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GkioOCl1ZEdmX+HxWDA9/12oij0y2oTPu3R2v3/26I1uKSElH4eGj9DuKqOw?=
 =?us-ascii?Q?COSHv5rJLVxqRh25FdS9KCKNlWhxEO0cq2Ig4fJJegtRmPxvBikJlXuOETE1?=
 =?us-ascii?Q?49Sa8zo/lf2Wv94jyeF+R6ObWvh43Hqg8tL3zeHNbe/k2f7NSmzRVeBdy/zJ?=
 =?us-ascii?Q?4y8R0O7eGFJyM3AV6/wLELZHMxKfyeuLt54lafsKC4uQBvtsJEOJFHyNICFS?=
 =?us-ascii?Q?cPH1P4WfhcJSXO5+XI8XQ32dpBPd65FUydQnMfPazb8RQfu94KTYuemI0XCh?=
 =?us-ascii?Q?lgPcoXw2rZIamoh8agG1jpu3kMhsWMeimmUTJRj61WhnssxhxJDEEHbylQTg?=
 =?us-ascii?Q?0JpkzEltH/Mg/8qyQCqidR4mXwKqAoiuYkxA1EsCNAembi5sSFLuqnU9y8PY?=
 =?us-ascii?Q?TZzbFFl0yiUIoBcLgoq2N/irSYlz1wEeY2am/d05+mBF/uNJo983Qzz2yOQF?=
 =?us-ascii?Q?aQjpa3s3zkACW9mcJTY0vdg6fBjmtjE+N4+QPWlNfmn+YyY1fng8v5rPkXD5?=
 =?us-ascii?Q?VxzFcZRaZr/D/JGqe+WVPeqqcljoEZ5NYg77W8EVcYL1SepmuBEYWIZiB0t1?=
 =?us-ascii?Q?zYIKXweSKuK0GyyyYVnSuVR6z/s+WxztZdwIJYT+QuSGFQ1i8XgMVh+6pbck?=
 =?us-ascii?Q?BU/QZw68bE+p4w2moJsmQldysylZNq8/4q+7RGeIVRjQp1sHf/Pi+xImKqrB?=
 =?us-ascii?Q?KsslZM6AsDJMuKtOH2NBKiMAajNX2BqCWU4xWnhULQCJ/alh5rgHP5AtXonV?=
 =?us-ascii?Q?jaiWreK3ZFkzYk5jpmJWXGtbkD5PYbV7D8dC60SEzs1UGKaFoOahV722Fj9V?=
 =?us-ascii?Q?YwOg6awTkRl3svRadc3Bnsr+CnTAQlxacdTCs31mvUQtB+XtFSp6PDoqabrd?=
 =?us-ascii?Q?1foLR2qpuvjM5/UkYsA6a5d8+6Nf8PVNe8znEO1YT2N+7BM+UWnxMKkUwboz?=
 =?us-ascii?Q?KMxim5W2J3hPpHIWN9UAfXhQ3u05zareZHZ6zTBzOVa85aYRyd85vg2y+lDO?=
 =?us-ascii?Q?HQAj81HNmWpFy2CRjMOhAP8976tykv9tuXnq5rh6xZCwVZJf9sMiN92IR8tn?=
 =?us-ascii?Q?YQK/lCS9Kiu1ch3zz6Pw/2sFeAsEVcDZ8H+BHN2g5o31NcLUzSB02UAyE7tA?=
 =?us-ascii?Q?t1bgKpYP4Alpiq/ZNX/z236o4tUzDrhZ2lnJToYylA0Ri6aETrqodfwUgqmM?=
 =?us-ascii?Q?nRqWajjRLPOY1yjophdXqF49Rk76A+xAjStxO7NRFENS62mbMLj7jvNQEVri?=
 =?us-ascii?Q?wEFv5mJRwAOYY0GlE8s41LOneQPtJDVM7guuMR9rPSgqt4KsA6+XjXUmMlb+?=
 =?us-ascii?Q?/SSteib56LxlUGjpogxLceBaupV26YLmh4OBqgDEtLY9jiFFM9LRbnvMLBsX?=
 =?us-ascii?Q?xFdkMXJJxvQXGdFYkFQXxOf2/E7f3fnPXAETmB78s9Ad5DRsNVey7+DJ4hRB?=
 =?us-ascii?Q?iEyHAxEAWv71QflUVd8nxvIs2CcRP0IoHSKqKZE608nEwpa4xZ1IU4arXoL5?=
 =?us-ascii?Q?tl63i/LWcv9nbObYl+HnoEZPs7PeuhqGh1zXDAZBHIMds3iTQDVHnu8gWZKQ?=
 =?us-ascii?Q?H/RT/viNTYcBjUfLVxk9BMowQw+CuLD/+Kzj8bzWf/XesrQLG46xKoEbniMj?=
 =?us-ascii?Q?f6lTriwywQJWu8TBxB28PspiDxJzWCKEzhMxBOLEnKg9xsFkV+MWXtrc/M+8?=
 =?us-ascii?Q?BaJtqTpKEbY4KfW1v9Jq8P3eF1C+ccI/oJtBwJ6KaodZNsVNWsLdzYJQ+3Ro?=
 =?us-ascii?Q?9ziKI2iQvRdWaQHJY830q7d/hZuzUqA=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c057ffb-e2eb-47bf-718b-08dea9b60430
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:20:35.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XISmXpEdh+flqeNbCDsg3VVww7WaDH9fQWAPVSuPVmYCdZhP7rJN1naVysa6et1YX8B77jvPAaXrRHNLN7glxc/+YsFEGOTAQu5zeLAUtqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6909

Hi

We have now seen this error a couple of times in our CI, and this time I
managed to grab a snapshot of the local mirror for which it fails. The
failing command is

  git clone --verbose --depth=20 --branch=whinlatter --reference-if-able=/yocto/meta-mirrors/core --dissociate https://git.openembedded.org/openembedded-core core
  Cloning into 'core'...
  POST git-upload-pack (388 bytes)
  POST git-upload-pack (986 bytes)
  POST git-upload-pack (gzip 1836 to 958 bytes)
  fatal: unable to parse commit 8751ec83421192fc0f8495fb95798f9eb7be77a0
  warning: Clone succeeded, but checkout failed.
  You can inspect what was checked out with 'git status'
  and retry with 'git restore --source=HEAD :/'

I wrapped up that local copy /yocto/meta-mirrors/core in a tarball, but
it's ~200M, and I don't know another way of reproducing. I also don't
have a better way of sharing such a file than [1], apologies.

Using that repository as both the remote url to clone and the local
reference, I can consistently reproduce the problem. That is:

  cd /tmp
  # fetch that core.tar.gz
  mkdir upstream-core local-core
  tar -xf core.tar.gz -C upstream-core/
  tar -xf core.tar.gz -C local-core/
  git clone --verbose --branch=whinlatter --reference-if-able=/tmp/local-core --dissociate --depth=20 file:///tmp/upstream-core core

fails in the same way, with both git 2.47.3 (Debian trixie) and 2.53.0
(Arch). Removing --depth=20 doesn't change anything, neither does
removing --branch=whinlatter (except of course for the commit it tries
to check out). But dropping --dissociate, the clone works as expected.

It doesn't happen very often, the last time was around January 30, where
it was for another repository
(https://github.com/openembedded/meta-openembedded.git), but exactly the
same symptoms, so about 100 nightly pipelines ago.

Are we using --dissociate wrongly, or are we perhaps not maintaining
those local mirror repos properly? They are essentially just created
with 'git clone --mirror', with 'git remote update' run periodically.

Naively, I'd expect the effects of --dissociate to only happen after
everything else the clone command does has been done, but it seems that
the ties to the reference repo are cut too soon.

Rasmus

[1] https://prevasonline-my.sharepoint.com/:u:/g/personal/rasmus_villemoes_prevas_dk/IQCRaxpwj5NfQYZNQJWc9PJTAY0C33XvXn8CnqPEdPAbpDA?e=zQAfg7
