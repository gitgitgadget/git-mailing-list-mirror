Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012015.outbound.protection.outlook.com [52.103.14.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9133E9589
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106706; cv=fail; b=Yv2GwpTLjhi7jFSarf+IaECUU7itaW3fscYMGPq/5Vkxjl0YgTMBtvP7VRX4add4UbdLt17+XVEBQrx05eyBk91MBYKlWlEjPkTNwoWskYoiAH9NtiyPz2ZHczlIF8XhAFg/2a4e4qH9fg0EQv03d45A0mMbhIKyM2FPw8Tj/9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106706; c=relaxed/simple;
	bh=ZhxoW//ydwK01JAB7KsKH0QM0GbicE2k+eJyzav6Ry0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pAb8ZFzJ18RSTJiyISn+6lMiOjppzd64q4lTwVm0HRzPUQfFMdBPV/hj62w86h81nsgvVfpVePIDZX/3PtGh6YK0Xj0lHBBE+aNHwFHHQLTeWZt6Vo2tQdsLl8GvaUTQ8+FuXNS0o5B9vhFRAG1Pw4zS1rf5VLOEA4UYtBTxevc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SvhLOUea; arc=fail smtp.client-ip=52.103.14.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SvhLOUea"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzGxshuSiLFwRSwcL2fWExsylAt/cjCbxHfn8p4Ih9SWjHe1voN7XMcB44EyLOvpcxqBGI3zhVUhcA0TSey8ld+pj0yuxU8pueCZwmKNzgF5a/C5gLNluK/jtze+XXHNwQf6fBwBr/aXU4GhSU2KKhngZXtDlMmwhc+vJFO3oZ3JQIkfMba+OhkqTIduwOVAFlDVY8CzXuu28tsCdqtjwBOKbrd2mjwVUGFsckLWgyoUd2C6cgh89uHuGSZZf6csw5pQNbTjM1ioUGIouL2L9jqwn0ArnBU2+kj1P4gEov1dI7uPU9QhfMYGj/HJzBIXiCzi1DcshE7r3hxn7swikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szfsZHIo8abGsVk5IzjAhSdzEGsn48AUkDMFkLooe+w=;
 b=wJcqGd0bU8jWzkYtuerc89EO66p10K2PCUK6aGvOFj++MT6C8f5eZLeK49kXi+/uJvHJMUpiYxrmsF2C9VaBKCvWXwEAccm69A2Sz5tDc+KLzAkLbMky+9tVZmfDpSXnzx6S29WAHogvwqcQioXP/Wpk9AggYy9I8QDKz1dZ+mJDtuLKhtGwy6MdZ8y2uLKAU0kYzMJZrot3RYKp0qjUhGDsniGX+mzKPc2NKNwCiPDX06HbwvhDv8cweurR/XN9IOzPpRnKdxEt7V6foE+SXaz1Ck1b7NvFrr+9KgGKyi/mx9YoEYaMFe/1X/coo+IwOM2w0yqfYL6oTN4rb4y2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szfsZHIo8abGsVk5IzjAhSdzEGsn48AUkDMFkLooe+w=;
 b=SvhLOUeadyHzpPl+f4q+CZnsPbyoZWF9BGUorV77h7RgwCo+Tki8IHmPt6m14QMuNbJRexDrl6vr6BtJzQH8y/JbahNBU3V6FbpfmrHudaeD00LTIXfKJTsWr9o7LVM7c+9ZrEAZ+keHkFlxC3NNEf5QJtXn2HKCi3lkcxlEjR3PqX5HkrXabO/cA9Twx5yY4+yHpn1a6HmiRYSeA6TpAiSdONoSTOLkCvCiXiiNS8b0LAToqg9DA+NhYlKiigUijmIW4WVPvAGDFGMVWl146m0lU86HR0W/4ElL4u1vDVC6rZ3PON3ViTGozDTuCIYnUTrQLGXUtA7dR1JrdVnlSw==
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9) by CO1PR10MB4658.namprd10.prod.outlook.com
 (2603:10b6:303:91::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 09:11:43 +0000
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f]) by SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f%6]) with mapi id 15.21.0181.017; Wed, 15 Jul 2026
 09:11:42 +0000
From: Travor Liu <travor_lzh@outlook.com
To: git@vger.kernel.org
Cc: Travor Liu <travor_lzh@outlook.com>
Subject: [PATCH 0/2] gitweb: shorten commitdiff index hashes with file modes
Date: Wed, 15 Jul 2026 17:11:28 +0800
Message-ID:
 <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0080.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::16) To SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9)
X-Microsoft-Original-Message-ID:
 <20260715091130.83934-1-travor_lzh@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB997715:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a004f6-bb43-476e-62e5-08dee2511613
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CIJq7oBwWymKSudZqa4Tdg4OAix8WgUFO3kVKTJd1i/K5jNZxozNvo3/GZ2Y9LNIsxh3IhJFY3CsjG/WABD8mQcxh9BpKDlnQWgAjnLDGz2KTZfA0E9nvn6ki68JBADKFhKOk6IU5OqxCZPNWudif45OVqAxxLpc8qziVniyOc6w0KR+jAIjBWJTMmQsu0xGKt/3PItVDK+Z8hJgOT+GRQjYY//8N/MDDVvGrjVYhHpAYNVRXBqoTcqggxzB1wBT+Q2J7sB652qJdYCb5iL72yv/BpsjnCeeh9hPZ57HH7Avz5GUmoNoyf625rALTnxGguAMWB/28FPHH7zK8MQ8YGaAoFUlOnh8dota4rmvyaVlClLsrkKe8Bp9BvY+CrGtFy3RqtlzxC17ycWBH3U9YxJ8z4Ct3UpZxdZCQaM6Qtp9kXVBl77OOkl65NyhsUQJmA1xIabgz13Szpz8Qn9LXlpreNuvxoDzlNCj4/5nmlNDT3/00BXZ4inbXvn8Urx9FlT5CrmaTB1mE0X/Zp0YkyKlWgu7HsEJp7q0OBy2QSRfr2I3N/9WmFfuF6Rb8aM18GShMkbBaLI2tt1lKLvr6+hXtB+pv471ymnPVs0r1VkoQWxZjvUXQR+/cn5rFx66KGpSswudHTc/favxitA/nUmWXDL6DawNNpBDrVJdkLaV2nuLNq2f0mU53T0Oc2+KMGP/yb/X2E8kVHl5FMj6j1qtBgwk87WXU5viQ7Wil+iRU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|19110799012|8060799015|24021099003|4140399003|25010399006|23021999003|25031999004|15080799012|5072599009|52005399003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zypb8yV2rGelXqza5dQ9pNFtSDKUi6IbINbtzn1BOChdTTtm3Gxcw/g4sGCS?=
 =?us-ascii?Q?zK8x3u5NlrFR6ifcpOxHyIE43uywUL1szbdSxUcz5j439L0isgYO0DSk3MF8?=
 =?us-ascii?Q?Awyc9eV1+D07pP9pYuDi4Tau1svGSvfNiw7RuCElC5b8dkAKc7v5Yg9FZHLb?=
 =?us-ascii?Q?B9tA6uk/rRbVKbRzzSKZjOXQTBCK7eNLXLdxajv5SKpaOXusw1zBRBG6RJyk?=
 =?us-ascii?Q?hsRfSutl+K8NNEklFvm83M/np5G+yiYxpIhZ5HDyOihs27M+jvbnd2xbh9+P?=
 =?us-ascii?Q?aKmcYD0BF2b3cSMXYS0BCllhlz3TdGWzNmPHzcwMDF2HtXi1vI1fW+3u1PmW?=
 =?us-ascii?Q?CFt+ir8b/enHPBN7uBhgyynW7oOkY6VREi6O1D11CSoAwrtKNA9zzy0PG/Vy?=
 =?us-ascii?Q?GxM+joUGlanb2yw0hNUWCOP7agjuGTLBZ39LZhnXlciK4nsWTukP7rLuTIwe?=
 =?us-ascii?Q?kd/CgN10KkpUCTAtJmnYQMulDxwGx27GcWWWB1Yp7vxQ5drLxvAyQxJGufDp?=
 =?us-ascii?Q?/EmW/hsL88TtXR/OEFPgn4ktZcBjs6+Viz1s6YNf/42G/4pdJtNzaHVhzpe3?=
 =?us-ascii?Q?Ee0MoQ4sgqENFF4cCjkQ6llnBNjDuCVAJWMupD6KFmVgzd2/B1M4lHhlOa1U?=
 =?us-ascii?Q?s1Nh2Qkb5tq/GAYZkfl+1IKGW9//Nq0faVkTJvrlO2qD40AdcHFZTCUoJ5nw?=
 =?us-ascii?Q?foOdhpKWK4uokY3aDCrGqgMZK4ERTkiijvRHPlUKY3K6WfLb751fS5yfmQCc?=
 =?us-ascii?Q?rRFnDAreKMLIigirNhLriBi5niR66fXIeKaNG8k6fGCUpXI3FFz6Rsmq0eiS?=
 =?us-ascii?Q?E9MoRFWdq2btUgBTlKbSd9kDUHgE3bPzfKGa6Nf1ir5/p7H4uhXTc/sZdOwb?=
 =?us-ascii?Q?5jPMIGBTQhuAOSOoBdvdXZCZ5KWjr/WN1zemcNPU35iSZhlKmymmZDU9UBGq?=
 =?us-ascii?Q?KrAtDKR8qolq/afCE9nKCRWidzX2r397+dyDKTRHDvtevQAf/99DoRfX0073?=
 =?us-ascii?Q?lH0W?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?elU6uuPLrXtKexdDNc/LgREnMOi0kNzKu6z2b2H5OFh3kZELpDUV+KPzOUA5?=
 =?us-ascii?Q?Tuw45rfSHJwDu2dwfd/Ekq1ZSUOUP3SoUZEb6yuFpapqISGhHEVGpZLB3WrQ?=
 =?us-ascii?Q?ZGPeNlBraiCr8ga2NxKYVOBELwT/TE9VqSspp+zNl2hj9YHuUSVU9uhkN214?=
 =?us-ascii?Q?RIZzIsiBbYP9u59xdii0iUuuHwwfAZfVxiB7/DEsHIqbh+O8pJtK3H7akDK7?=
 =?us-ascii?Q?9kbLEdxZvHQI36J7vHUygi9StU38cnMSI7YCK1kI/sYDhAhPX360I0vIJ6/N?=
 =?us-ascii?Q?3amQHopEWqM5vcLUg+awbq5Ldy6h6gGvTIiyZFy5Bs+GMJ618ILKrkb6La5Y?=
 =?us-ascii?Q?o+yKsxGXEKD+f9+Y4lPnE0H772dXXc7qudYNypxAHpTqwa7uXJKJT0AnpmXR?=
 =?us-ascii?Q?bTs11fnYJL7O4xcNzzv4SGBc2KCnT7r3i4ssOw+SJGVZRIfTvCzh4tCBlyul?=
 =?us-ascii?Q?zcTf9zPPoKvk/5qIVxI497v3yKydm+iF54fpqKSCXGzn27w6F2WHsht5+Gaf?=
 =?us-ascii?Q?VDIlSliRfpc7pj3JPHLhEYSEOpCl0wZ5AJL7mgFH5g1XBcf3A2QTeuDF3PDF?=
 =?us-ascii?Q?1Erp82OaW8MRlc0q4TtTdFQReSaRAm17dg5cYlSAdJqVEIuafD97gX3TJzoo?=
 =?us-ascii?Q?7a5ukJMJSvp8f6nGcb/CW6ZJvIg2OjrZgf+yU1bUZBjPDhuQ56nNxDmCn17q?=
 =?us-ascii?Q?aTXJM9gUDiqie2oQzo5NC8Ov+4RBf37i5C1yewAn9Oo6h/X89Ze5E5ke1U6D?=
 =?us-ascii?Q?U1xRNFqcSbXb5NmVjwJd8yKcgoFIOoLkb22rDW2NBJZv3iAc30HoN5CGfBlx?=
 =?us-ascii?Q?TvCd+xUOphK6LWjr8O0FDITlC8rChsGcjgLhNjFc5qFd9nBoJJlgpltkPGii?=
 =?us-ascii?Q?pmZN1LWX9IKrlBxjV2ldqtW3rAImK+SOtQbVxDdkRHp2yC7iTAbvBLIYbDGp?=
 =?us-ascii?Q?/2/WSAb5u7JvIkOLeV+z5jVflUtIYWxNawUvQmyr+YFL1Xo5DBJZApLd4nhz?=
 =?us-ascii?Q?8I6jjke5iBlrXiOdH5qXNompy4vCccNOErwUDDWHTk9Et61psIF3/h1gcky6?=
 =?us-ascii?Q?f0bFkvaFqa5bTgzvQXXeZwAtVOJMHqmLj65me5jTrkLVcCNeQgMvu/VU31ku?=
 =?us-ascii?Q?i1G4hoYZN9+7tWPhOQRZmDpLBx9fI134mxkyHLUwCe2D/SvAHdRW5mDEUztg?=
 =?us-ascii?Q?mRXTXg6wx2Rr4jybq+fM4Uzc25FIqXrqFUVnBL9oBFJVCLNewzjqMlUOR9OT?=
 =?us-ascii?Q?50+tnkNPBZkJF+rVCSqOEfPQ7rW9J/gozVS1PLHRb5uZo/IRgDdAXTw2ta5E?=
 =?us-ascii?Q?rHYjVwQKGILJL6ns4/Jw3vbn8rcCWae4xXusL9ZELiX6f6dKzGbRPCGYiUqe?=
 =?us-ascii?Q?JNH1nV9gXPC4R1Ocs78bByHqV8+D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a004f6-bb43-476e-62e5-08dee2511613
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB997715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:11:42.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658

From: Travor Liu <travor_lzh@outlook.com>

This series fixes gitweb rendering of commitdiff index lines that carry
a trailing file mode, such as:

    index <old>..<new> 100644

gitweb currently recognizes the mode before matching the object IDs,
which appends the file-type annotation first.  The later object-ID
matcher expects the ID range to end the line, so these common index
lines keep two full, unlinked object IDs.

Patch 1 moves the mode handling so the index object IDs can still be
shortened and linked.

Patch 2 adds a gitweb regression test for the common
"index <old>..<new> 100644" form.

Tested with:

    make NO_RUST=YesPlease
    cd t && prove -v t9502-gitweb-standalone-parse-output.sh

Travor Liu (2):
  gitweb: shorten index hashes with trailing file modes
  t9502: test gitweb index hash formatting with modes

 gitweb/gitweb.perl                        | 18 +++++++++++++-----
 t/t9502-gitweb-standalone-parse-output.sh | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.52.0

