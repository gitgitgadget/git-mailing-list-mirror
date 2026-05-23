Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468275CDF1
	for <git@vger.kernel.org>; Sat, 23 May 2026 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532799; cv=fail; b=DGkrDG8nZ/p/ZtVsQ0fq8PTfboxnddoKzDpMCPxQ4E5Bh5Wtu5kjrQ+BAIuIgBXmNmIiLFkXbnWccJn7Tqf0TRtvY6ohOfkzIxwqXodVDV8ajXYfR2/58eeIOFBfpbgkZkwd0C+/crQnKf+mGSR8gz37k8D5unQfkRJgnT4S8+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532799; c=relaxed/simple;
	bh=BmMe8CI4BTpX2idpc41NQ77yknCfnWIK6LQEXGj5yyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KnKXaanGcTOIOwOS6hQNhagn52jXllh9iyQGyOGCV9iZU4OFSrX1KK64ijJlR1GQJFJBMxzhFclv8OKmkc3t7hsOKiNnp+xGeJ/XTaedKywhM1FpDhyH1voC6DLuaqvfi7wOp/gTcDcAC95tetZJ7D4cuG62hq8i0nwcAPl6Gls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZBKlfIgm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PQfX75TO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZBKlfIgm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PQfX75TO"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N8ng3n3384640;
	Sat, 23 May 2026 10:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=; b=
	ZBKlfIgm3UYv6wUT+U4SdCUznbKJygJeLkwZbWPGIjJV0Deq1jw3DDd6uLcAHeE6
	8foGi4Qymqyr6sQ9lopm0z6D/SdajLi4Ft3iU0pMzE9Z4MFsLG2uETIL6RBLyZzn
	VwPefbmoBes9mpbwZ9l4TvlTnbkMQRyThOgUe7YblT0a9tgskyHBB4p28MioH6dt
	oN01rFVnQcxmF5WFC8VIIgY8Vm7vyaBqD9TvaIcHq7e5VqqkrR6qIPB6C7Y5aRk9
	feze5dRjT38fGmhj/v2F2fcbtmgW3tCphNwlR/fKmaDR9NtLPZX/ZvLM2yDPJAOJ
	6Rv5aJOgYZ+v5s92dTlXiQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb48c06ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64NAdjZR000638;
	Sat, 23 May 2026 10:39:46 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2p6rnad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfxZ71Om19G/PJ1jDb92k6N0+TgdvNH9VzB6I0yYzPT0e+lfzAajoabtpyZox0v1yvJSrGDb9q1BpN2NKR6XDZe+VRN1vj+Scc197LQaOEk7JDdgB2ZSb30uDFB0v1UXlBLE+U+qqmyIuSukbdNIohzOdRb3MZsL3/hP6gFQYPXbOPvp6McjXWmKMqouh/YPxzDadvmN1Gm+I4ew7Oz5ba3DhCjbPN6VKPTJQnanGgIFYwqgwlUglG7L+xOziFILBbrghSUCwpk2ndRDiC5ogNn8aZBa+meeNqtp0HcxiW4yAdawLevw32FhNlFIp4ar260RQwOsbhCDBUw+qd9PfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=;
 b=NR9WNmTy39fJuvCrechkLroXEdcTD1wsw0h9r1FENsXgGYexJhiIcW0IcpBnxJKWlP6UkQ9mhvUAKiC1P0frd/7lI0SKKANGobhTNlCkgABMQvJbhcz8J8d3OGmlf73j1eTeTwgSjLBZkUIdWXfJvR7w+vT7Y+HdMUY+VpQL/1UJNzBdlmqG2/DXe08lAEYqAo6dP7rZjmrfzS+gvkomiTd4TsBlbskYSx7flA770UpXMICTQpxigyfU0ikQNpsL60TjKBWirgl0qDmGnxBuj94Qhi0PkPz1w38p76FTM5v0sQ6GFXaqzBhBMBEc253LczIFSRe4NQYDPTu8w9v2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=;
 b=PQfX75TO+JxSz5JJnvtNYSH5exLKqjBubJmSdEuPRzN89HkMTcN1DZgi6WERnZucAUy4/6mniIiQMo6dlrs9WxGVB6y3P76Xs4h1Yc/W7/KUhq3tPGvzS2PpmNbI0GJ2fKYCEd/FDAhAhIFgc1e+pvtb+WuoSr3vTktTa3QSCO8=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 10:39:21 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 10:39:21 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 3/4] t3301: cover generic displayed notes behavior
Date: Sat, 23 May 2026 16:08:11 +0530
Message-ID: <e494bea038262847ea14d223718f6059e52c1f40.1779532562.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779532562.git.siddh.raman.pant@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fd44ce-24f3-4d88-4eed-08deb8b78c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vMv9nXxCzJh8ceXj3gW5J19Sq1ZDjsICauJjS9s0zcrLKJyrmpyGTNwm0SpYhoQM525QmTLFQnCXP+z62nPuAYyl8LnKbNafnV288DfY6Nkhl/k/2QIuPZna9T4XpILZRBeRb/Yhov8XVddJo+c7zuH0xlJ4VwQv++BP9lZskyOapatviIBJspU16XV2v7EYFx3NHMhuz6L2NhmymakhrCeL10B59rPyJXjZs8YLrrVilMD7RfhEZ3xy1ScGzZ1OSwjqQ1SmIgDBPzTnfIyLddOVG1FrjTZ2T70LD+441SS3CB4erhbKdysR3wlLjoK0Pff40UMSl4hS1UxNxMhihmilpqg34uow59bKw6C4pXRZ3QKtXU0dXlrz6Lk9eZHTT5Rcwl+Gtg7KXk9W5SJXVcUhblNTiedU75HAj9sURTNnm3y9bOw0Q+bzsSQ99bhwwtFdRpWLQ7iDk5jrrQs2I3B2Wbps5CKvY53VjxFGlI7pOYoSxlc2oLHUisSfbSYNMQZ23cT1zFqEQORWo54f6NWK4oXfaOT6CcowlrPqKOIjF3yVTzyDRLsUAQcM6L+TmZvEWbYjT/DkXzvVmjjP5U6EGHDiNFLLl1fA2JjZQ4qyB/XBSiQG+m5lk5s+GWakdFh96Z6UeFMHKcXTf2rTgyb29YA4jvSka4S+wZiFl+BfCwX3cu8f3GIvHZEksJMi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vuOvnTD/AtLcfyEX+bHIByVR7IEMft0Yg8DYPDz04e7YwWVBBmDHXXmFv5wl?=
 =?us-ascii?Q?t+4avasEM5jA7ZI4NZPGrd61rDhqbJpQrl3joGCCA9Mwl6IiFJNTBf2yoPUa?=
 =?us-ascii?Q?9swyBJdnxZyG6MQejLgvgeCIPDVGEVper8dN44MhGMQvg5kBdJZc+RUcyNQE?=
 =?us-ascii?Q?LIZT9b39fJ8fLaKl4yFoChaPbam2FBQbna5GYDyS5+bMUIRl8aSuCEC51JUf?=
 =?us-ascii?Q?Ckstp1dzG8wBsfQrQb68osba7pZNgBC1BZYJTbjCghF8JEFXGfczBLVioFb7?=
 =?us-ascii?Q?ca4kdruv2wieTuyQL7XMvrC8NBXrAZiDvkOlgHBtjGnlNaEbQEojtBgV0jUG?=
 =?us-ascii?Q?2DA4O9rKwe6Qb9+78H3f60T9WJc8FiX8EPjf/FOt0K3vp0GWdM/OejxKFgYI?=
 =?us-ascii?Q?4ZwY4OLqspJN9IxnprnUvwOl++FdxQZD6fL1BusMUiKsIKJ9zzP0pK8qFQEc?=
 =?us-ascii?Q?X+SJtHhspFTUTN4rLPtmP9NNBMZvQajryRgYqs9ssO8FxPbihc/d8Gtbu2of?=
 =?us-ascii?Q?tg+QKXnb7m9gNC24ECp6suqnS5UFvl9HHzRRIdtYo8uVaXEN7VZJZWbg4+Il?=
 =?us-ascii?Q?1SRFy2ir8ogXlxbNLuOpVFCVfM7rjRbH07kOLZMSvCJtlvh++Xuj0Q7mLgS2?=
 =?us-ascii?Q?m6rl6Ry3wDk4bsoYavMHqX65Waeh20PYfYsjJJToKzuNHHsKwVrsZThZgpZ8?=
 =?us-ascii?Q?sngnt7a2bVklYYWVYQ/dECW4QpZHNXFXx6qQ8uxFqdIRjzqaQiz/N9x63dg2?=
 =?us-ascii?Q?Eun5RrFDI2AtVakPrXKpl1Tgee0sZW6E8raEOkpXureLRrG42Ptj+26DqYhg?=
 =?us-ascii?Q?epJU3/nMpHl6RCzqB7RsTD4fmuVRzoONvHLs7NTYE13hJurL7vCkb+EnVYc3?=
 =?us-ascii?Q?E2i0nnDZ/TIwHQ+MNBnh/4hmy4Tq+tBLMngngO+Ce+gqCE7FYh5o7H8f7w0U?=
 =?us-ascii?Q?Mr4n/U42fS7o/KIlaY5hE/OphljfiQwiI6KH8RXcZSTte2apTiQpDdGa2Mka?=
 =?us-ascii?Q?VaY4PJyyPz4GLrL6IpZpy6ySJ9KOajWIniLITPQ5k/bhjrMtylgwM/nuO9MG?=
 =?us-ascii?Q?z5Eb2TzKC/xmwMuZAyb+o6XsPqB5itHBucWCiFODp559bjjAM2+k6qYR8xlI?=
 =?us-ascii?Q?MaMTrarVo8xhoqFD+6oxbvvEuwWezDloDgsCifQQ3vxPfH8nu77n3yjBLcja?=
 =?us-ascii?Q?+7cj8Gein/4ABr2CsHhC15ptvsF48JIJkHMv5IaDX3AnplZ04R/H2j3zEoxI?=
 =?us-ascii?Q?DZWZYsNHW199/wACjsXVj9NprlUiEPDsL/j9mNVKDmP31CrHoqhy+HNLsRLd?=
 =?us-ascii?Q?eb60MF5+tePIOXpGi6fhk7C7N1T9UVgaGFHiashU6q1bYxtC0FxMKcK7aSrW?=
 =?us-ascii?Q?gpRYp3u323mdq377jumb47O99XlC5e0vWNFjRLdOupDOkJFDSG8QGCeXY2N8?=
 =?us-ascii?Q?4okaH7FaOPuwiGVO6/AudHmboGmck58b5zGkuhbiazKRroQF5H36rpqpO9NU?=
 =?us-ascii?Q?avGiPfhJXggMxrdvhUfF+Cm+fdcxdA5dlw9WRH9p/A+FvOwg1ilxhiT9Ql4c?=
 =?us-ascii?Q?kd1grlwtN2xvEHPyZ+c6DQpg3qii3tbE80arN9CVkwhpmlFK+PRU0GwzHxZ1?=
 =?us-ascii?Q?JRBDLGWTISVRlB9xhxq29ReqvmIirWtBEw/vtFnvfc4cz0ukTg/39YNUEKZe?=
 =?us-ascii?Q?rxCB2So+6dZKL/1ncPSwMw/4fwoBhdFSTFI0OTd3mUj6rgug9iGMgXLj+gHG?=
 =?us-ascii?Q?U5/jpnCMta3eoyl9F6pq5OFWUqIebudSgFd21D6LqpJjph6pyt3wQ+O+h2aj?=
X-MS-Exchange-AntiSpam-MessageData-1: K+QKQxbplGMr5veE5UNdkXwXhQFEIOV40gQ=
X-Exchange-RoutingPolicyChecked:
	VdI7HYrYmRLec57VbX39cTvgbrdqyejwaQzOjh0jSHt6VPLyzwg7GOBk2AYQn4e34QRj+YjDbhOsY4JS7+6UsfSaYMAy+Mo+j/BsDzJQEYSHAXRTEfhld9EVHWf7YJ/hRW51aBUWPnjWqd5qJv9ZhRzrH0SvQv8u+hX7+Mfrq9zDheI4vlS3wVQMGp5o6hgKf8AdDw0VuBV7vHditwhy1xoT4WLz+Ns8nGitAFHr0cVoSVIRBv8ulcdr6fkh3V0LjADFpQ/4fPOh3Gk9G2FI1pRGH14DhONodtiqImtDpuOms2kkV5QxCg/JhRCXQ6RfgjpBDV4yOQ7foMrBSX1UBQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YvtCwyXGh39BXQM+3takQuHkGJzB5NzJMY/c1y4aiKN+e0XmYYUlAy1F+3V5KZnoNx3X6gxVTruhBHTBI2JJn/yV4aW6dc+J+P76I7t4upm5k3uzHKqvUGYncsq69svT5vOdfr+9KI5uPma6Fgo0QLOZnNHWTCP2LeIy5XtnjHnlR3av6Nd7J/hZ9NNKFwNBPfdDcGSHteFU53oaodRVxBCNq8BVcHI9H2q0eFKV+w3Rx5i1p4q7WLrMbEHgvVSyYLwql5AyrZPjpR3+d+Y7/zUWCMN8GQl+9mzCINLltrYkocssNuw42hFYYTH4R39Mggc1jvpumwMjXwicC4zXRqWeYWRqHc1qzeOXfTmk5zkygz29yC+I1PTInZFg/SFmOT9Pjq3x5Xsx4XECyAEQqBM2VECoBhkQFJ2TPskg2aMwa/vcNULPcnBrfZ6aMQ7O1Zciik62a+303k/sHY/7nQAGsjo1Jf1LtB5mynijopRxpio8wLTfSWj8cQhsF6+nFCApGA7ZwS7zK+De5t4tGD0WVdYHLw4Atjuc44y7xLK0B0l7s7/4CRSGG14noJcFX0FQMOFbgR8mKm5uGe2yV0KDtB7Ii8NlcMRETds5V/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fd44ce-24f3-4d88-4eed-08deb8b78c37
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 10:39:20.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Uy/cd8QA5L6NWsncdD1maHGyGjlnOqcC+og+KVBthUtU6mc44vYpRtDUuHMWs/htZslH7JvAgdUxrVC6DPegUyEFFAAFDPZLzG7tas+CiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605230108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDEwOCBTYWx0ZWRfXyCnbS+qUv7Od
 gvGMBnFmYJAT3OSSDetykPJUfl6goKzMcYcFpkEvVrqTLCIZ0Uyb+En+RbOsWOHoR34kaE2bv3M
 ddp07FV4mlSVopcmdNg3wVxebKGzGAhSyNWF66E4Avkv9MM4g9du2s1jgGJXcaswohAYxyjL3kE
 kZmn5h9WAFXAF5+b6FeKfJMEf8GkFbl7AnzVhLEDK7xxYfwLPuS8NrqT7WAzdaifXHSLUS/BnHX
 P0xs1/tbyxgexqSr6BnMffMEAQgWZPigVKMZcFlYZnOFuEXnAav0WYoHvNqKYXIPKQqtUWcefpW
 vn8ySWy51AQYXu/CXYOBCFEAKMZ5kfPsaE0c5aMm2kRJUreTwVsj2J2A+yeOWCpg4BR1AIZoYVH
 0rdXiYculJTfWtXuVvZtkYHfCkSdlkQ2/0VnM/sy2q7OXkhwirIiVyBqIfnBOkmbBI25+qqXMRR
 +W2DXufUE8fQkV3gMhw==
X-Proofpoint-GUID: 6SR1Vd7Z9kGAT7vbl5BGtoAOWzQIFHNH
X-Proofpoint-ORIG-GUID: 6SR1Vd7Z9kGAT7vbl5BGtoAOWzQIFHNH
X-Authority-Analysis: v=2.4 cv=XfG5Co55 c=1 sm=1 tr=0 ts=6a1183f3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=zp6zO9qf0PI-K8SJbKMA:9

Displayed notes already participate in common log behavior.
Add explicit coverage for raw notes formatting, --no-notes
suppression, explicit notes refs, and --grep matching before
teaching external notes to feed the same display path.

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 t/t3301-notes.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d6c50460d086..27439010dfbc 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -885,6 +885,30 @@ test_expect_success '--show-notes=ref accumulates' '
 	test_cmp expect-both-reversed actual
 '
 
+test_expect_success 'displayed notes honor raw notes formatting' '
+	git show -s --format=%N >actual &&
+	test_grep "^order test$" actual &&
+	! grep "Notes" actual
+'
+
+test_expect_success 'displayed notes are suppressed by --no-notes' '
+	git log --no-notes -1 >actual &&
+	test_cmp expect-not-other actual
+'
+
+test_expect_success 'explicit notes ref replaces default displayed notes' '
+	git log --notes=other -1 >actual &&
+	test_cmp expect-other actual
+'
+
+test_expect_success 'displayed notes are used for grep matching' '
+	commit=$(git rev-parse HEAD) &&
+	git log --grep="order test" -1 >actual &&
+	test_grep "^commit $commit$" actual &&
+	git log --no-notes --grep="order test" -1 >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	test_config core.notesRef refs/notes/other &&
 	echo "Note on a tree" >expect &&
-- 
2.53.0

