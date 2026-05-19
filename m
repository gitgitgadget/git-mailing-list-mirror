Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07AE2C11DE
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208303; cv=fail; b=uddX3M0W76llryz4qyP/2NuKzBZcnBECgSOSOml0iLVCtYVujh7Taz5S7Bvge56CMy/byRdbMByEV/55WUJsMRD5kez3RgDUFcPOyevaZgGksf5PFJe4tRQplyNql6rll/wsNEJnsG14rjy8my1e2l3TTgrIvfD+tl52lWCAotY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208303; c=relaxed/simple;
	bh=AvUDVDJ+SZg+0voh348Ke4e03CbAYpTCWQurJBgvZok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwHdJdxLuNXfLXuVklUk3evcw32sbbwF7DeSGgWXddsK/O8pUT+fI1z3fI6E+ehpjjNa2VA9u/P4EDPS7s4fagk07BeuMSnKd9F+ZfMn0MxcmMnwhL12iQISwR8J84gTmEQny/zeDUfjSvwne981Y2WVLu4ud0nmI2I9o82+Q8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=maRVE9pI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vo2quNj7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="maRVE9pI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vo2quNj7"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JG91GM177948;
	Tue, 19 May 2026 16:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Bd1CjkN9JkMS6ufEM+Ew54p+BSKm1Z1LCDdEEyv+NM0=; b=
	maRVE9pItERDkG28RaI375dLe6uMNcheff+cOmvK7zGlRMFevVEP4dubeADH5z0Z
	E5yzYWe20K1wi8CUWuB3fiEvioD6s8qp6xaF76JumLtAUr8PQZTbRstafKAQLnCm
	+l6tgHqE3r3+2Idww9YGI7u7OFoCX6yPx4O2RIabr4jbRZ0s/CNJLlDMeVbrDZth
	LRmAh3ARqgg6g/6GQa6E9kPTfQFt7Ag7/eWM4UbLINdFZcCu66DIeM8YJdDFXGS9
	Iw8+VeepEXZMFJeBcWNpr8nS9POU0ff4iZ/GqT2kygE+52a5oF51v09mjCAIon/c
	WkfiGEW+Jhy8F3bwwzSujQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h86w4kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGTmYL036597;
	Tue, 19 May 2026 16:31:35 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1b15ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyQSLOTBHqj2dJYUPS7izdSwYwDRRqSZNuFSC6SLX6c0L9C//JHfPk/9Rk6QTtVzo5Aawl6djDoo34lpDe8/nP+rjn1TMGfptQLgpRTE34vTPgrVeSDyRt6cK9RpGja0vYW0ZDMIfqV0VvQIo/q2Wr5ngNtkapzsFZOfKU2Du9F0I4Z1Oy1N8/PypuEEKlwv8ttyoGB5OeQkdQflnUXOaAVOVdpndm6kL+QU2qUz/iotDs6Y1Zmj3Q2oHea12uXlRcCVwmoLnEYnK8DDWhRIOvXaSSSBVl8GAnWMmHunCp+1wpmOiCe8e/W6rjLdxlPnc3Sh1Ev9Bqi78pkjXj10hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd1CjkN9JkMS6ufEM+Ew54p+BSKm1Z1LCDdEEyv+NM0=;
 b=gVw6hW7tCX3ooV3C30bcC5ZGINv3SsMP6S7VCbYHLP344E5PoYn6W/VJJuc0j7qsFjGm2a/7fhJUPmWfqyqF+4CmMrr3QAzHiHE6jG36rk5UYRbrnq5/uUeUjz4KuBHQwtyE8IVhMT14+lpAemKP9s4xj3l5CTLrMr1pBUyMNfAHRDYkmWR6TryUGC8ksjK2MWVSJRNbFlMAIvJk5YoJEpy4gqHmF8liFuT01M2yoFwibAjnBix9s507BVS3NlVcfVkGVcSMoQa9QR+ALqJNimwD+9nhJ9WeFOwpdzBWK4K2dJdCUIZSyRj/hRywoxAM1+6LSuGakpzjKEWgBaM+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd1CjkN9JkMS6ufEM+Ew54p+BSKm1Z1LCDdEEyv+NM0=;
 b=vo2quNj7flCU6Cilh9j/kjic3qhodOyIh1PPWZIY2Va5JHwUz5npg1aO9dRZsAJc6Uz0xdkJxBYp4zRqXNwiTb0zIkxeMMzYrf9w4oYzr8+pMRXVh2pqv+fxP/Uw9KEF6HSinIjquLVWp++OG/Uem6C/m6plszTiKfBPZSZngZM=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Tue, 19 May 2026 16:31:30 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:31:30 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] t: add tests for external notes command
Date: Tue, 19 May 2026 22:00:38 +0530
Message-ID: <3a470a117d5e0a7e130eff0d203ed7e3700b5d61.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::14) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SA2PR10MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dd7488-590f-40ae-df6c-08deb5c414a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003|3023799003|20052099010;
X-Microsoft-Antispam-Message-Info:
	AgBsLf3RmfzKix8GmBiXk/wZVn/QDhygrbFdGjNKbzvzZBDviYFxYud8VOioNbHQY3E4se5Nwo7q4bEQtYAodABr+HayroueJO8AwXOlRLHCrVy6wMA3Ep4OhLY6e5Nz6cEIOTcihBid+DtGuTWa40/tv4iQkqDOxBfY1JDkh0iJuMmlbqtojlLCHAtTJlsSzhhthqNn6an12ALeSkF5PABikuk+l1s1TTQcau/5ar7XFQu6Nu2pQb2LU8MDNRTm2gIyuTC+WNRLzlWuPq9lNk17ZTev3NoYnx5pr/vCowsk7zU8fgcZIQFAORngrtC7GQM8zj5AA3Q3Io1/YTAzKdjEi2ExiHVw7fI+WQJSPyS2RfuvBm+lliA3DZLsvOYdaTdKotMyQWbGPH39+INch8wIzYusP7BZGt3Ja+UL+GE41SOUsFGUKnLGfdhF1hkA22K1XUhlm+4s7vGiyJBCwdjU5LktQ3qD8uXso00orvIJCpBcnX0Zp00q635PywY34b22YL4ketucyJnVPmmKvwCt5TnRE8bqOgIsernXIU/AUeYm/Fu2fWjMaRO0OZTUYnCttudmAK8+lazL2JNhQIxPcVetMy/9EN8a+b9y6XdiOth2mKkAC+YQxtLuA2gpyztmfjXi2tDinMKdgA0VO7ep/jBy2Hc0FLTz3gd0TFl/eJir1+yA5dMAZWKQ1FCZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003)(3023799003)(20052099010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zb4QOAy7XunYZlBB+0Gtoga/k2JbYDpQGZORnl4ARUK/90+Y/Kdc0dBZfGGZ?=
 =?us-ascii?Q?ABrBm1zM1P84gVooPyK7ehnZDaijSvCqRyGqzQFoQkLr3RSVZ4ijk30QNQ0s?=
 =?us-ascii?Q?mtLbu2Dm0snZ1JseIPVay7/uTcaTPEez3HDJDvvXbIhVXw1y/KYhCfDuFIUI?=
 =?us-ascii?Q?x6OKPNeE7N69T6JVp9J4B8d79g3Fj4bqPx1Q1vcSDhCR32JWZaA/NoNupn4H?=
 =?us-ascii?Q?MpVuE2Lhvt7p4GzxBwlYRPRHboc2KM148v9dZiKtZpxitvdbG88mDjrl6jt5?=
 =?us-ascii?Q?732Q/4duSVlM7dn3bkcDjvI3inC9zXTecOKLEQkRvNkFI7P1QfdVfU1OauAq?=
 =?us-ascii?Q?bLGAs+2kc/LJonNxNyKUJL1rEx7+pD+gvoUi/mO+YuDrm5s3U4IwGYHj8Rfg?=
 =?us-ascii?Q?2izs0FGT+eg7DH/fqdvvmpIwOY13wJC3XJf3LTecU9uAPm2GWY68tDUYsXj4?=
 =?us-ascii?Q?6tjOkHCkvZNDFUQ+J2h2Ege5DsxJanjguujkmaxgqxhhztKB45vfJPkpvMvm?=
 =?us-ascii?Q?ttVcFszaCa1dVx0Vejwvn6cx4gvW8i+t3A43RJZnB6DkWU1m3IfRvSRYW96+?=
 =?us-ascii?Q?LllM3rByPp7hGdksTSIe+27QihpoqNdgjuRaK4jP3qJT8uHzn/qXZx+M+ttP?=
 =?us-ascii?Q?LIMvaAYfKWLmmBi71V31foWbUDl3XRhCr7xT+2p/w6uT4I4+/hmNS2YRt1g5?=
 =?us-ascii?Q?kg/6Ii7XKIUvtXCTh+Nhy3J+D6IbheMbOLSwSmMLNoqMo/B9coxa6pB3sugJ?=
 =?us-ascii?Q?epUpdAlfvRCxg58MkM9iU5dZPF5BwY5cOx9vGBJR38aupo8qiHq7kgmL3MMP?=
 =?us-ascii?Q?UrCSUjvrXBTqcTGRWfh75xMzvWsQ2fb2OvR2tfRVr+txEMTo7CbYOt3O4yhr?=
 =?us-ascii?Q?6e9v5Fnmj8C1vcQFK/EdiW9Jz6S5rXed6am2s+hZ9V2bLm+PaCgAJ76hSpna?=
 =?us-ascii?Q?h8eu5pDaQkGDNMrOLQWuICFX8w7APxDdsbF3HVY3OMFyaG+UwEr8D+WwY646?=
 =?us-ascii?Q?TkJODlfbOQp9vH5fUkoXUaYeegqz5ICgKETf7SeG4gEcwZ9VxSvYOxAXFMV2?=
 =?us-ascii?Q?M8U2AkRb0R5pe7lTuGTyM4W1t2xckE6GL/xYWgj1Fc2DhSbGTeCky+e3ZTpq?=
 =?us-ascii?Q?yNrZHJ2GE3yxOTR+b+2GnEc5MhA/50rjtgKXR9yy5GEIbisNF6o2Mku+w5Pz?=
 =?us-ascii?Q?SKI5X42bTv1+IqEiWuKHsxw4D3aap91YqABBNmS0WY5lzAvw1y7DKnCygeJZ?=
 =?us-ascii?Q?52swXIgxEf7soRY4sI0cHeA9STdFeXWfu0FtnoArwpNd9wgdjIiYazS2fPz1?=
 =?us-ascii?Q?MmjKMr/eSu99snaxt1ZzeRlkGtwa47NwW4pHhPjIsxt36f4b0bweAOhSvGwJ?=
 =?us-ascii?Q?kkfs2Hj/tfzKy/2ewsCAAumv3dvZ4XHOHQOWxYZkT7k4HCuMFh2j+Wc+Ime5?=
 =?us-ascii?Q?QJqlDr6gM9/z4SmSX51sTWlKOv4Nn6qVnmlMrU//yGknF3V2QQzeFj3Tb81J?=
 =?us-ascii?Q?HR0Uy02EKs/NDR+VL0pKbyzNi0pVOgiV0NuNj2b1OQr/z0kclEkX+b7js/VL?=
 =?us-ascii?Q?wBJS8zTF+y8XP+0hYhzJRwTbvlpDdcaYwTnOQ1pmmKfwWTu7K6zokBwHxnVo?=
 =?us-ascii?Q?Bphh4O0d0PG0ZyDiwbLa2JolCeB9iR6e1muCeb9gzzBl2ehDtYy+pNhG7YlA?=
 =?us-ascii?Q?ESvdhryW1C1IZ3wnu/S4m3N7ECYaKHBt437uK+r0xu2DQqvEhXt49k6a9inL?=
 =?us-ascii?Q?ARquLoumqnwiraAJoSFrDGqX9/ZHsRN30yePtv4JYA6TmJWPR8ygOwyOh4JK?=
X-MS-Exchange-AntiSpam-MessageData-1: p5KrGZzzpZDwT1wLVjsVbmzVB9aRdPMFWRA=
X-Exchange-RoutingPolicyChecked:
	I3QOhOrCegtHu5ieYGe9eAcbOfLw32Oejgli2m7u41PETg24/dLJQD61Uqu9wJW+L5F4AtW2uPRo39OKy1XGPeBjYk9JZPZytQb9uoi3Zji0hUei9PGfOugjdcBuy/e/LbFSLRuYoCOfpdNcRk3D7cNGygn2kqcrxKhXEg4lHvMzkgBl8AJJH9Lvan+J5Vvz9eYOHttxw83Tv8+ylp22K+CZrR1snMJOedAvhKA2dJevKeWYReQ2A33BIA540/CRXhkV+gS6gACVxOYsZmZdRaBEeqbehvA0L9R/CGmCB194Tr4gVO7Yg7TglD/8ImavvnZ1vYm2XHFpLakqZe+Zjg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mgfYn7ZvuuhA+lPxlV3yY3o88lRLO+W5AGMEsiZmeoXSX0Px6x5giDDUsockKkzfu9ep4FscoWccH23/RvaCpgLEZyHwpRSZJuQzOXjXnt5zfA8OqQ1Pgbfq4H/WJbimmt0jtpzf5X8Y2nyaIVYPFSxcBI179TDcQ8Cq9Rwrlpklkq6CsgPu5+zdIfOoMzPR1FQjFJnRKY8sEVepIkRWpHntM3fI/CV37D758XKeTWAm4dBaUE8nwQgixg5AWQZUv4DOcCupBgj51qI4NbTus5IUGU7zh3lAjoWjgR97I2nuPLqVRHnepxiTj+rvzvWE11oXh8xiEq2MOiWI9ZSjw0J8Qu2+ycZqOENh3+XcwsXvPAO0GnflxtCXdSabfDGethp1mIUefYU0W4bFMU9PPKCcD5cTLKPJeKDOUmdUUvoSQMJCydBy34Dj9Z0TwVHsANMyYnOvar37vuttA0+G+T+pdzH5VcCapCed84OEpCbywWRhnhX2VN2JmQ41awKrvP7kJi2auMdghQ5QKar7n0amdl/7wliro0MR34As9PVly1PcN1TlX6umWzUw7YTrmRpPI/FDpFXQ3Ud2AFFD1+ZD7Bw/V1LrEyHT0ESrcs0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dd7488-590f-40ae-df6c-08deb5c414a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:31:30.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLptL3nCXGF1J3Z1nQBQcvcMdDtlzYKDsJb51MUjPrx7UTPjSDxHR2Of1WvcOc0btvDU83uyNA47HXda5YUl/mIKTuFNV7jYkIMJsT2ePCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfX9sbh8hPidbos
 Ol7ZIkpWSaCM2weziCpJwkJ4iN8xAWZ8aHDlMRIByoszR7ZNe5/ouwB2VfJjsib5vRfXd82f5LF
 P2+XnpKLpTdIgdSiFVgVeEpL2JuLUPFEqkBuzc562kKLqdpYWUJUAJ6n8QK4ccgQR7MkC5ClDdv
 PzflYfbSeN/2up2blztG4nEbqaIFiG5PgI7TBU0OHZ5JqKx/epRSKJL/8/fcRiEly4Opk87S8FU
 2ZyItq+3jREsQBxppfnnPcD/O2f9ukpy8MoiZLmxvsYdAy1P3tddUFPNgKDBhl+oAG8ie52OhiV
 t0FfITTLQ4hHc0UXJgBNy/EBXU0XWRpzAI5HWB617tNSGJ55Qk8Wbho7dZA3qaA5HlZpuIoRTBs
 pjKXTPTAap/AlksF1ePkITeysp5nq0FWVL7gCOqYH5cOjJtVnEtd4smhpoASfqYBOB/m7LBqQq6
 2pqAhgtzgcCCvFQtbkg==
X-Proofpoint-GUID: tCPwg3dEn-vigeRBr4H42NEmwuhuO03i
X-Proofpoint-ORIG-GUID: tCPwg3dEn-vigeRBr4H42NEmwuhuO03i
X-Authority-Analysis: v=2.4 cv=TLN1jVla c=1 sm=1 tr=0 ts=6a0c9068 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=s0T0KiOntWEaJek3ZQsA:9

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 t/helper/meson.build                        |   1 +
 t/helper/test-external-notes                |  64 +++
 t/helper/test-notes-external-config-reset.c |  20 +
 t/helper/test-tool.c                        |   1 +
 t/helper/test-tool.h                        |   1 +
 t/lib-notes.sh                              |  19 +
 t/t3206-range-diff.sh                       |  68 +++
 t/t3301-notes.sh                            | 437 ++++++++++++++++++++
 t/t6120-describe.sh                         |  17 +
 9 files changed, 628 insertions(+)
 create mode 100755 t/helper/test-external-notes
 create mode 100644 t/helper/test-notes-external-config-reset.c
 create mode 100644 t/lib-notes.sh

diff --git a/t/helper/meson.build b/t/helper/meson.build
index 675e64c0101b..739614b90e78 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -35,6 +35,7 @@ test_tool_sources = [
   'test-mergesort.c',
   'test-mktemp.c',
   'test-name-hash.c',
+  'test-notes-external-config-reset.c',
   'test-online-cpus.c',
   'test-pack-deltas.c',
   'test-pack-mtimes.c',
diff --git a/t/helper/test-external-notes b/t/helper/test-external-notes
new file mode 100755
index 000000000000..5e9dde3977ab
--- /dev/null
+++ b/t/helper/test-external-notes
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+prefix=${TEST_EXTERNAL_NOTES_PREFIX:-external-notes}
+response=${TEST_EXTERNAL_NOTES_RESPONSE:-ok}
+line_ending=${TEST_EXTERNAL_NOTES_LINE_ENDING:-lf}
+exit_after_response=${TEST_EXTERNAL_NOTES_EXIT_AFTER_RESPONSE:-}
+exit_delay=${TEST_EXTERNAL_NOTES_EXIT_DELAY:-}
+delay=${TEST_EXTERNAL_NOTES_DELAY:-}
+char_delay=${TEST_EXTERNAL_NOTES_CHAR_DELAY:-}
+ignore_term=${TEST_EXTERNAL_NOTES_IGNORE_TERM:-}
+
+newline='\n'
+case "$line_ending" in
+crlf)
+	newline='\r\n'
+	;;
+none)
+	newline=
+	;;
+esac
+
+echo start >>"$prefix-starts"
+
+test "$ignore_term" = true && trap '' TERM
+
+emit_output() {
+	if test -n "$char_delay"
+	then
+		LC_ALL=C
+		payload=$(printf "$@"; printf .)
+		payload=${payload%.}
+
+		while test -n "$payload"
+		do
+			char=${payload%"${payload#?}"}
+			printf '%s' "$char" || return 1
+			payload=${payload#?}
+			sleep "$char_delay" || return 1
+		done
+	else
+		printf "$@"
+	fi
+}
+
+while IFS= read -r commit; do
+	if test "${TEST_EXTERNAL_NOTES_BODY+x}" = x
+	then
+		note=$TEST_EXTERNAL_NOTES_BODY
+	else
+		note=$commit
+	fi
+	printf "%s\n" "$commit" >>"$prefix-requests"
+	test -z "$delay" || sleep "$delay"
+	if test "$response" = missing
+	then
+		emit_output "%s missing%b" "$commit" "$newline"
+	else
+		emit_output "%s ok %d%b%s%b" \
+			"$commit" "${#note}" "$newline" "$note" "$newline"
+	fi
+	test "$exit_after_response" = true && break
+done
+
+test -z "$exit_delay" || sleep "$exit_delay"
diff --git a/t/helper/test-notes-external-config-reset.c b/t/helper/test-notes-external-config-reset.c
new file mode 100644
index 000000000000..1c6b26e3b49a
--- /dev/null
+++ b/t/helper/test-notes-external-config-reset.c
@@ -0,0 +1,20 @@
+#include "test-tool.h"
+#include "notes-external.h"
+
+int cmd__notes_external_config_reset(int argc, const char **argv UNUSED)
+{
+	if (argc != 1)
+		die("usage: test-tool notes-external-config-reset");
+
+	set_external_notes_command("helper");
+	set_external_notes_command_name("label");
+	set_external_notes_command_timeout_ms(250);
+	set_external_notes_for_grep(1);
+	reset_external_notes_command();
+
+	printf("configured=%d\n", external_notes_command_configured());
+	printf("name=%s\n", external_notes_command_name());
+	printf("timeout_ms=%d\n", external_notes_command_timeout_ms());
+	printf("grep=%d\n", external_notes_for_grep_enabled());
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a7abc618b388..31bb2d1dca47 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -45,6 +45,7 @@ static struct test_cmd cmds[] = {
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
 	{ "name-hash", cmd__name_hash },
+	{ "notes-external-config-reset", cmd__notes_external_config_reset },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-deltas", cmd__pack_deltas },
 	{ "pack-mtimes", cmd__pack_mtimes },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7f150fa1eb9a..ff25f0a29cf2 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -38,6 +38,7 @@ int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__name_hash(int argc, const char **argv);
+int cmd__notes_external_config_reset(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__pack_deltas(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
diff --git a/t/lib-notes.sh b/t/lib-notes.sh
new file mode 100644
index 000000000000..07422540d58f
--- /dev/null
+++ b/t/lib-notes.sh
@@ -0,0 +1,19 @@
+# Helpers for scripts testing notes behavior.
+
+# notes.externalCommand is run through a shell, so quote the path.
+external_notes_command=$(
+	printf "%s\n" "$TEST_DIRECTORY/helper/test-external-notes" |
+	sed "s/'/'\\\\''/g; s/^/'/; s/$/'/"
+)
+
+# The helper above is a shell script. Few Windows CI tests (3 out of 10
+# in matrix) are spending more than the production default timeout just
+# starting the shell and exchanging the first response, so tests that
+# are not about timeout behavior fail. So let us opt into a wider 1s
+# deadline for Windows instead of 100ms.
+external_notes_command_timeout_config=
+if test_have_prereq MINGW
+then
+	_timeout_config="notes.externalCommandTimeoutMs=1000"
+	external_notes_command_timeout_config="-c $_timeout_config"
+fi
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 1e812df806bb..96adeb9bc4fe 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -6,6 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-notes.sh
 
 # Note that because of the range-diff's heuristics, test_commit does more
 # harm than good.  We need some real history.
@@ -690,6 +691,37 @@ test_expect_success 'range-diff with --notes=custom does not show default notes'
 	grep "## Notes (custom) ##" actual
 '
 
+test_expect_success 'range-diff with --external-notes' '
+	topic_oid=$(git rev-parse topic) &&
+	unmodified_oid=$(git rev-parse unmodified) &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		range-diff --no-color --external-notes \
+		main..topic main..unmodified >actual &&
+	test_grep "## Notes (external) ##" actual &&
+	test_grep "^    -    $topic_oid$" actual &&
+	test_grep "^    +    $unmodified_oid$" actual &&
+	! grep "## Notes ##" actual
+'
+
+test_expect_success 'range-diff with disabled external notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	TEST_EXTERNAL_NOTES_PREFIX=range-diff-external-notes \
+		git -c notes.externalCommand="$external_notes_command" \
+		range-diff --no-color --external-notes --no-external-notes \
+		main..topic main..unmodified >actual &&
+	cat >expect <<-EOF &&
+	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
+	4:  $(test_oid t4) = 4:  $(test_oid u4) s/12/B/
+	EOF
+	test_cmp expect actual &&
+	test_path_is_missing range-diff-external-notes-starts
+'
+
 test_expect_success 'format-patch --range-diff does not compare notes by default' '
 	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
@@ -780,6 +812,42 @@ test_expect_success 'format-patch --range-diff with --notes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch --range-diff with --external-notes' '
+	topic_oid=$(git rev-parse topic) &&
+	unmodified_oid=$(git rev-parse unmodified) &&
+	test_when_finished "rm -f 000?-*" &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		format-patch --external-notes --cover-letter --range-diff=$prev \
+		main..unmodified >actual &&
+	test_line_count = 5 actual &&
+	test_grep "^Range-diff:$" 0000-* &&
+	test_grep "## Notes (external) ##" 0000-* &&
+	test_grep "^    -    $topic_oid$" 0000-* &&
+	test_grep "^    +    $unmodified_oid$" 0000-* &&
+	! grep "## Notes ##" 0000-*
+'
+
+test_expect_success 'format-patch --range-diff with disabled external notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	TEST_EXTERNAL_NOTES_PREFIX=range-diff-external-notes \
+		git -c notes.externalCommand="$external_notes_command" \
+		format-patch --external-notes --no-external-notes \
+		--cover-letter --range-diff=$prev main..unmodified >actual &&
+	test_line_count = 5 actual &&
+	test_grep "^Range-diff:$" 0000-* &&
+	grep "= 1: .* s/5/A" 0000-* &&
+	grep "= 2: .* s/4/A" 0000-* &&
+	grep "= 3: .* s/11/B" 0000-* &&
+	grep "= 4: .* s/12/B" 0000-* &&
+	! grep "Notes" 0000-* &&
+	! grep "note" 0000-* &&
+	test_path_is_missing range-diff-external-notes-starts
+'
+
 test_expect_success 'format-patch --range-diff with format.notes config' '
 	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 27439010dfbc..5a162dff3917 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -6,6 +6,7 @@
 test_description='Test commit notes'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-notes.sh
 
 write_script fake_editor <<\EOF
 echo "$MSG" >"$1"
@@ -16,6 +17,11 @@ export GIT_EDITOR
 
 indent="    "
 
+run_with_limited_time () (
+	{ set +x; } 2>/dev/null
+	"$PERL_PATH" -e 'alarm shift; exec @ARGV' -- "$@"
+)
+
 test_expect_success 'cannot annotate non-existing HEAD' '
 	test_must_fail env MSG=3 git notes add
 '
@@ -909,6 +915,437 @@ test_expect_success 'displayed notes are used for grep matching' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'notes.externalCommand shows external notes from protected config' '
+	commit=$(git rev-parse HEAD) &&
+	parent=$(git rev-parse HEAD^) &&
+	rm -f external-notes-starts external-notes-requests &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log -2 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	{
+		printf "%s\n" "$commit" &&
+		printf "%s\n" "$parent"
+	} >expect-requests &&
+	test_cmp expect-requests external-notes-requests &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	test_grep "^    $parent$" actual
+'
+
+test_expect_success PERL,EXECKEEPSPID 'notes.externalCommand terminates helper during exit cleanup' '
+	commit=$(git rev-parse HEAD) &&
+	test_env TEST_EXTERNAL_NOTES_EXIT_DELAY=10 \
+		run_with_limited_time 2 \
+		git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommandName labels external notes' '
+	commit=$(git rev-parse HEAD) &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		-c notes.externalCommandName=commit-id log -1 >actual &&
+	test_grep "Notes (commit-id):" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommandName is rendered literally' '
+	commit=$(git rev-parse HEAD) &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		-c notes.externalCommandName=refs/notes/commits \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (refs/notes/commits):$" actual &&
+	! grep "^Notes:$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommandTimeoutMs rejects negative values' '
+	test_must_fail git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=-1 log -1 2>err &&
+	test_grep "notes.externalCommandTimeoutMs must be non-negative" err
+'
+
+test_expect_success 'notes.externalCommandTimeoutMs times out delayed response' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_DELAY=1 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=1 \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success 'notes.externalCommandTimeoutMs applies to whole response' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_BODY=x \
+		 TEST_EXTERNAL_NOTES_CHAR_DELAY=0.02 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=50 \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success PERL,EXECKEEPSPID 'notes.externalCommandTimeoutMs terminates timed-out helper' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_DELAY=10 \
+		run_with_limited_time 2 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=1 \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success PERL,EXECKEEPSPID 'notes.externalCommandTimeoutMs force-kills timed-out helper' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_DELAY=10 \
+		 TEST_EXTERNAL_NOTES_IGNORE_TERM=true \
+		run_with_limited_time 2 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=1 \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success 'notes.externalCommandTimeoutMs=0 disables timeout' '
+	commit=$(git rev-parse HEAD) &&
+	test_env TEST_EXTERNAL_NOTES_DELAY=1 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=0 \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommand handles CRLF note bodies' '
+	body=$(printf "A\r\nB") &&
+	test_env TEST_EXTERNAL_NOTES_BODY="$body" \
+		git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    B$" actual
+'
+
+test_expect_success 'notes.externalCommand accepts CRLF missing response' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_RESPONSE=missing \
+		 TEST_EXTERNAL_NOTES_LINE_ENDING=crlf \
+		git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'notes.externalCommand rejects unterminated missing response' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_RESPONSE=missing \
+		 TEST_EXTERNAL_NOTES_LINE_ENDING=none \
+		 TEST_EXTERNAL_NOTES_EXIT_AFTER_RESPONSE=true \
+		git -c notes.externalCommand="$external_notes_command" \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success PERL,EXECKEEPSPID 'notes.externalCommand rejects unterminated live response without deadlock' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_RESPONSE=missing \
+		 TEST_EXTERNAL_NOTES_LINE_ENDING=none \
+		run_with_limited_time 2 \
+		git -c notes.externalCommand="$external_notes_command" \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success 'notes.externalCommand accepts CRLF protocol lines' '
+	commit=$(git rev-parse HEAD) &&
+	test_env TEST_EXTERNAL_NOTES_LINE_ENDING=crlf \
+		git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommand missing response shows no external notes' '
+	write_script external-notes-missing <<-\EOF &&
+	while IFS= read -r commit
+	do
+		printf "%s missing\n" "$commit"
+	done
+	EOF
+	git log -1 >expect &&
+	git -c notes.externalCommand=./external-notes-missing log -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'notes.externalCommand empty note shows no external notes' '
+	write_script external-notes-empty <<-\EOF &&
+	while IFS= read -r commit
+	do
+		printf "%s ok 0\n\n" "$commit"
+	done
+	EOF
+	git log -1 >expect &&
+	git -c notes.externalCommand=./external-notes-empty log -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'notes.externalCommand rejects invalid note lengths' '
+	write_script external-notes-invalid-length <<-\EOF &&
+	while IFS= read -r commit
+	do
+		printf "%s ok %s\n" "$commit" "$1"
+	done
+	EOF
+	git log -2 >expect &&
+	for bad_length in -1 +1 1x x
+	do
+		git -c notes.externalCommand="./external-notes-invalid-length $bad_length" \
+			log -2 >actual 2>err &&
+		test_cmp expect actual &&
+		test_grep "notes.externalCommand failed" err &&
+		test_line_count = 1 err || return 1
+	done
+'
+
+test_expect_success 'notes.externalCommand is suppressed by --no-notes' '
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" log --no-notes -1 >actual &&
+	test_path_is_missing external-notes-starts &&
+	! grep "Notes (external):" actual
+'
+
+test_expect_success 'notes.externalCommand is suppressed by --no-external-notes' '
+	rm -f external-notes-starts &&
+	git log -1 >expect &&
+	git -c notes.externalCommand="$external_notes_command" \
+		log --no-external-notes -1 >actual &&
+	test_cmp expect actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommand combines with explicit notes ref' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --notes=other --external-notes -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (other):" actual &&
+	test_grep "^    other note$" actual &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    order test$" actual
+'
+
+test_expect_success '--show-notes=ref remains additive after --external-notes' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes --show-notes=other -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "^Notes:$" actual &&
+	test_grep "^    order test$" actual &&
+	test_grep "^Notes (other):$" actual &&
+	test_grep "^    other note$" actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommand can be enabled without default notes refs' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    order test$" actual &&
+	! grep "^    other note$" actual
+'
+
+test_expect_success 'notes.externalCommand combines with default notes refs' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes --notes -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes:" actual &&
+	test_grep "^    order test$" actual &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    other note$" actual
+'
+
+test_expect_success 'notes.externalCommand obeys last --external-notes option' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git log --no-notes -1 >expect &&
+	git -c notes.externalCommand="$external_notes_command" \
+		log --external-notes --no-external-notes -1 >actual &&
+	test_cmp expect actual &&
+	test_path_is_missing external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --notes=other --no-external-notes --external-notes -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (other):" actual &&
+	test_grep "^    other note$" actual &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    order test$" actual
+'
+
+test_expect_success 'notes.externalCommand honors raw notes formatting' '
+	commit=$(git rev-parse HEAD) &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		show -s --format=%N >actual &&
+	test_grep "^$commit$" actual &&
+	! grep "Notes (external):" actual
+'
+
+test_expect_success 'format-patch --external-notes includes external notes only' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		format-patch --external-notes -1 --stdout >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "^Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    order test$" actual
+'
+
+test_expect_success 'notes.externalCommand is not used for grep matching' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		log --grep="$commit" >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommandForGrep includes external notes in grep matching' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		-c notes.externalCommandForGrep=true \
+		log --grep="$commit" -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (external):" actual
+'
+
+test_expect_success 'notes.externalCommandForGrep does not search hidden notes' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandForGrep=true \
+		log --oneline --grep="$commit" -1 >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommandForGrep honors --no-external-notes' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandForGrep=true \
+		log --no-external-notes --grep="$commit" -1 >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommandForGrep combines with explicit notes ref' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		-c notes.externalCommandForGrep=true \
+		log --notes=other --external-notes --grep="$commit" -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (external):" actual &&
+	test_grep "Notes (other):" actual &&
+	! grep "^    order test$" actual
+'
+
+test_expect_success 'notes.externalCommandForGrep is ignored from local config' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	test_config notes.externalCommandForGrep true &&
+	git -c notes.externalCommand="$external_notes_command" \
+		log --grep="$commit" >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommand is not used with explicit notes ref' '
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" log --notes=other -1 >actual &&
+	test_path_is_missing external-notes-starts &&
+	! grep "Notes (external):" actual
+'
+
+test_expect_success 'notes.externalCommand is ignored from local config' '
+	rm -f external-notes-starts &&
+	test_config notes.externalCommand "$external_notes_command" &&
+	git log -1 >actual &&
+	test_path_is_missing external-notes-starts &&
+	! grep "Notes (external):" actual
+'
+
+test_expect_success 'notes.externalCommandName is ignored from local config' '
+	test_config notes.externalCommandName local &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log -1 >actual &&
+	test_grep "Notes (external):" actual &&
+	! grep "Notes (local):" actual
+'
+
+test_expect_success 'reset_external_notes_command clears cached helper config' '
+	test-tool notes-external-config-reset >actual &&
+	cat >expect <<-\EOF &&
+	configured=0
+	name=external
+	timeout_ms=100
+	grep=0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'notes.externalCommand warning is shown once' '
+	write_script external-notes-fail <<-\EOF &&
+	while IFS= read -r commit
+	do
+		printf "%s-mismatch missing\n" "$commit"
+	done
+	EOF
+	git -c notes.externalCommand=./external-notes-fail log -2 >actual 2>err &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	test_config core.notesRef refs/notes/other &&
 	echo "Note on a tree" >expect &&
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 8ee3d2c37d02..abbdb42dc9f7 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -15,6 +15,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-notes.sh
 
 check_describe () {
 	indir= &&
@@ -867,6 +868,22 @@ test_expect_success 'format-rev with %N (note)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-rev with %N uses external notes' '
+	commit=$(git -C repo-format rev-parse HEAD) &&
+	rm -f repo-format/format-rev-external-notes-starts \
+		repo-format/format-rev-external-notes-requests &&
+	printf "%s\n" "$commit" >input &&
+	printf "%s\n\n" "$commit" >expect &&
+	TEST_EXTERNAL_NOTES_PREFIX=format-rev-external-notes \
+	git -C repo-format -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		format-rev --stdin-mode=text --format="tformat:%N" \
+		<input >actual &&
+	test_line_count = 1 repo-format/format-rev-external-notes-starts &&
+	test_cmp input repo-format/format-rev-external-notes-requests &&
+	test_cmp expect actual
+'
+
 test_expect_success 'format-rev --notes<ref> (custom notes ref)' '
 	# One custom notes ref
 	test_when_finished "git -C repo-format notes remove" &&
-- 
2.53.0

