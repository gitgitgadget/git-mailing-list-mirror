Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E555400E00
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208266; cv=fail; b=LPb3LwbxfRCwmR5yvtcHtGuwIgfYv4PVzUTqZ6KueDs1Sw6SIDkwtglRdqvZVhaz7CObBrruBW+DKcqedhK3w2lVxSB5bqpCI7zfmrG9Ig9LImFpJJejBJULUhPXdfqcP39/rjkqOB5sjmeMxJTH9uPhU8XhCWBKZRM24Gd8lvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208266; c=relaxed/simple;
	bh=SjxLV1ghsLk/lmqepO4HpEQsXlbq3LPO4IBAigy6XPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KA2508wlgM0JQqv7gwvfIZbBaGsZx5XIxoS+Da30vYMCrFkoxS/y//EgmWj5otDgqoxJW2vtcBPP2T4eFbOGZdi7JPEU54GNWsXy6K8DHMJK1dK78Q1X6rY9My+wuUGd81pAmao1NAFruLJqaRbR0CIut+ObAwyR2zthecw1gQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bIxHguHF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V8l5/vIW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bIxHguHF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V8l5/vIW"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JGAWEN565438;
	Tue, 19 May 2026 16:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/4c1lswUoRAow1NTRvXxttFtAu3P6Y5QJ1gkYzT/pZI=; b=
	bIxHguHFdO6nQcb1jg+Jmjz8GcQON9aE8ZgdpTYdVcT6C/wBdGmF7ZWeMPvHn6f1
	rtt1ZqH+D0Go+W7jSwQo3stNAT45WTfhFLulAdnwKly8wAhg5/+gHmuUPC1gkN4C
	T0IJTE5xQHcnWH4f//EnhJWShTjzLPy3HSX1uFXnV1xrRLEIXvjG+KV/KPL1w80T
	q3jFuuYKLgV+d8MKT/g1QPGLcmLg92G1YmaHkFV3/Pym0EXfvzS9W9+dBNj9Lnhr
	uYHAlArg+Vldwq/lGApUhOwg2q+GI40+u8K8sREaRlWbf5hYrbQVYaBOaj1rqSuf
	XGikSZkHDaS48VOlG4QdiQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1sw3bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:30:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGTilh018823;
	Tue, 19 May 2026 16:30:57 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1b0erq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:30:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkeeVuBme/uSFHZRzD6rCmXZK7NB04oFC68KCotBPU9qLcLXQJyafb7xY8chGMj1Vc62311uebOPMXKJru9AX5tMb5zIYkVGbtGjec7TtqecNpzwUiM0e6DcqvI9jY4Ux4rd1hGpmzIBPlSR6yJBHaKGzNeIoqwfirWVd69QBshKSBq7kOe8JGujbC6DkwXzL2S4sjlAp/9A66tefRtDIURpbYihtT7bRRG7BPHdcHd6zvT4HWBSZ8Z6VFe56/cW4fwwMZebHyxLd0BHUJN5bYNBow28EF6tm2YUGg9zd3NLXMzuG3hzOhKpvq0zutB8gp3MylKIshnu6k1a+ccSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4c1lswUoRAow1NTRvXxttFtAu3P6Y5QJ1gkYzT/pZI=;
 b=AxdCutrvq74L5GEgP4+h09iObdBh0BWoDqYjIWPvdmr2YvzeUooT9wtNABEt+xnQOxRzpHyEelC76EDxafaSba6jwCFvlqa1nCD6z+a5YiSBMLbHn2lFYX2xI6eEhOUQVIzfldrMYZgn84IzL/+GSDL6+WKwHjuXWMum28VBT7/UN6onTTyZZqppDXtSW9YneeBINJMPrA8SJuv5qbECDzSp4yNNReM9r+ikqxm7opDFXqeQ9ztGgH20fxpx+DZitsIqSNQVUbyGArZjIgORVJv7np4Dyet/hNVXmXciDVThGaKOWds7LjIr7PtjF7R9P/wZOz+ub8gGhXXxg9DR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4c1lswUoRAow1NTRvXxttFtAu3P6Y5QJ1gkYzT/pZI=;
 b=V8l5/vIW4TVyXSOWnTgCX2gDIyDyLRXD2ShGltbH7tXCAM/IbiqA+NVcM8FoLHSFRz6BWkIP9JA2U2llUQWTq5TG+43O1bMz+cNDIWq4YqO5/3MV1Q8OygxIEBM8C1x9oH7WA032pJfmcGSqMRcjjG/6ojJxoplh1bVMXaUNT3Q=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH5PR10MB997756.namprd10.prod.outlook.com (2603:10b6:510:39e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 16:30:49 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:30:49 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] Documentation/git-range-diff: add missing notes options in synopsis
Date: Tue, 19 May 2026 22:00:30 +0530
Message-ID: <290fe06d81e956253d3a06fc1e16848e0b86b603.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::17) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH5PR10MB997756:EE_
X-MS-Office365-Filtering-Correlation-Id: 34884ec8-7d8e-4b3e-41c5-08deb5c3fc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	F/5jOpYXpuahfwlGaBro7pxIffuEtEfiuG/bZBgx8scVJAHQqxWYc7OAb7Sfukua8zCzd60lZiiMNxtUqfJMtx4BYcMOHMEQ/kLYI9ihzrdNH35lXJPjSbkHEfEhJQPgulprUINyxlxZjd0wzfUuf47+qbB935xzjtkbsc32KvvvppGPlBvHaCYtVHTJy0R4k9nzn2sEuDYGaqXaozzrI2Y0e2yUhW9R+bryPdUfpIT+zG2h3JtgjtweTFQdsmRc6tVLDHxRT76r7sLpO7o7cs83+I7nw+lub1exZMhSR5iG0RIplsaOEiLwQ84S5qjBQZVsfNaeOtx32sgVe0OKiuAXtn07ZyMGrHSqnH9r02nPSZs2Xg4PUpP8ONruWhtIjSwdS21zF5FjZw+QSBfRVmdwFQMWexKC3t9BQauIu0YJcuEerYBV7JugyTf1ynzXlo/AW3Pmg3QCwpk7edg5y4JlodjunO/oCDl/fDw6UW/x1ueg6esQK3hHDIeLVmHKo3EsOVaNtmjOvrK1Z+3TRrPcIO6bAvoUMFTBHxcxeKanxSHFyvAdcAa0tX5yt1LsIiA0nVxOEFlHFJX1p0exoWT9X/VbLO113NvI4Kg6taCiw7IXrZK2dsiPhOksFzJ166JxDQhifJKiaIW1EKX1spf7bFWRXOB7ZTxRWspV4daKZUY0Z67aPy4EosEwioWQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B0Urw2j/ydT3Ze+VKabDLwvC5jQEzDZyDjOQpb6fiGg3e4bDmBFnDJWyqWIL?=
 =?us-ascii?Q?fN4XKUbQ/9wyOAXIFDz1SkorWZF6JLNmLfLkxyNVlMCdlAMgDYqgyjJZuIzd?=
 =?us-ascii?Q?aoUzaUuZJwI3X9qr0OJLijeS46LqhHu/g41LoPJG0fGKFYVrlIsnCXZSUwfW?=
 =?us-ascii?Q?dK0A7sKdxa8mKk0PddUifgq8R18d7LQklz1kAC3K8cCp3sQQAOjAFrSK9vyZ?=
 =?us-ascii?Q?sEJHZpQsZ8vDBw5DlPm9EOayI7z20cHnfI1nsJ6C1J+4Gsah3bnGfFJDH8WS?=
 =?us-ascii?Q?lUu3lppZbu4Rw9mgVmn2fhW5QcQy84ETx56m9fEeNDUPPJldVc1tcPtipdpA?=
 =?us-ascii?Q?aiBbBylg4DgEutVQgV9HhRcWS6NrniP0eunyllSvovweXnP1rR0UbfJ1FVBR?=
 =?us-ascii?Q?Q0dO66cKIt37IqC2ff4g6MOqE1md25xGTI6SXJPlwBnbRTOkSWixXXPD4Ugy?=
 =?us-ascii?Q?g2V4OaEqJqT9wo4hi//suIRc6SSQBUI5eelnfUDq/S6A6MObFie5jlM1VS6w?=
 =?us-ascii?Q?XubuWie4lo6JpB/stXstKoy4EB4+X5V1NHB+/mzO3M4uwrLl6NtGWxKxeOt1?=
 =?us-ascii?Q?5b8jsLUqEi7ZDxIrHe3SiG2Je/Qim1kx27dr+uTlyBxgPYJt7tb2Yhywhahp?=
 =?us-ascii?Q?DUYV0n0BngKAPWyTSQPMDOaLDWvUHzmZIEEYBddVzrYCqCg0KSMRnhAAvltg?=
 =?us-ascii?Q?zH3vsFz5bJmrtzxHAGnMyh7Z9L9g9W9OwzvkhIRYMzmtCzrscJCZrcXTnnlH?=
 =?us-ascii?Q?2e8VngDaAE4UUg3GwMyzRNabNfwrQIdDtb6+7IXPcWIvnLnyWFAQOHSwfuyB?=
 =?us-ascii?Q?tEu6pfU65meaz82WAcdNR4z0YGMnB0ut69sTlYnYfR58ITgJMvAE0KlX73MP?=
 =?us-ascii?Q?dknfDg+fWc3DSP6FnPOgT9lEWTzOnKsDowX8hwr4o9dk4dXocvtpfPKbVQkc?=
 =?us-ascii?Q?7lE3rYIlqg59ZZe2T6vDHpBzwpbCvqfkEDCxg+JXwCQiUmLr8g1966jH3Gya?=
 =?us-ascii?Q?q2/6NGjk+4wYfO5y4Bq9xtC8YarL/75ZBSaxDN+asd8WkwI6LzVRATvLnsbb?=
 =?us-ascii?Q?0VMKUUuWzSQBz9eLSaVeOsmodzOdFzcH8NkBaZOhnyYDupbKlyRKLEFe0KMo?=
 =?us-ascii?Q?2UT5+f5GrQlz9yMqoBXNM04/HzRrlp6o/B9r6DWBywM80MECPuhfd3KfbV8M?=
 =?us-ascii?Q?nbYeS+oMiaue9LnUqkWTHTmVDUY0iIkrrx9aftO3b8M9MslYIUi7FJ0pzcLj?=
 =?us-ascii?Q?ACPke5D+q0O4PG67gppQnWCoFy0bE1e+pnHRl7aN3/FvebO5by2eHGeaGE21?=
 =?us-ascii?Q?XEJwtlpa3Eq20Yq5teWHIKd7647Qe+AfPXu+MgEMc8TD89ENSW2gh3Y59DHw?=
 =?us-ascii?Q?gKClc6/wk5ioLaiO4HcYZnw2gYGSGnpjFt5VU0myLyRwn4ceVYdv5z7P8Myh?=
 =?us-ascii?Q?AX0d0DMpJIq3kCSa+80rVIfX0GLebpvJICV/DdFvKHFZxodv8xf1rmHXqVoO?=
 =?us-ascii?Q?NwPsJhnYvY66dR7FlNnQjqUr+MFXa+ktRJPokmN0rVd6bEU6SlepTbgXuXEg?=
 =?us-ascii?Q?JCpCI0UfkBYz+LGvsCDFcUoZMlOTziI8fucQsV8leABP833RE1UJi1GHThG4?=
 =?us-ascii?Q?NQ4KysKNe1u/xzy7+BFDSB1XF5NLVcnyIagVwpTUPZv/NoqrR+DAGrM4NXwl?=
 =?us-ascii?Q?Z9RZXzgLs9SXQpXZVjx4veW/eQeZq/VFjsTkfXgXvzRIAkLYY2YXtBqi8N1X?=
 =?us-ascii?Q?5cbgUD4SEC/E8F1nWQXtDyYkD0Tt9lyhH/VIoxBiQwI6rJ5GMgcrgaSCemfM?=
X-MS-Exchange-AntiSpam-MessageData-1: q3ZKbXaYQQyfvkjRHK/WxwSza3aI8/TC3QM=
X-Exchange-RoutingPolicyChecked:
	nk5XoIGQmqVeabmvNibIN7KF2qj+ITHQ9y3wg3iMlgUEewLkuySYOKm1ravVZRQj3MdUzpuuZWkeqSoEOCgbM2MyqXrswSFjTeyIxYGQnG3v4bolKBHr7mM40FwKG0EIwTVUJNC0tAvHZnnsh2EiP74JAMA+SDT3mqpQsp+4EGnwIG55bgj3XgDWjPK5FP6+7+2a3tA4fdRc7BuNjU+YlDmCv0TgSE5UDGRSj8nHeyXegAK5IyBHBJMJED5otB5+aWxh0XecrlpUOoLkv73goJE3eIhW7pctZy5Mqy+32XJo39rTBywSW8Qb0ZmQjvJDbLnyqKSyl5ThHt8CsFIpRQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LIPJCUWH5QT5JZdMZe9rwlm1sOAI9nnJonSFkUqwmYdViz56ecb/GAK1NJ4sgsaaWj5rMhpFLk4qOgPCZtZLH1GRQCuBCXj68oOYM6TRCimU1OEa7C6TWCyY69J2MW/q3JDkyRW8w/tI1iECDzoZfctE6TA1EcZasj+9YpZLFjB9yVXWftvnJ8lmsmK+PqfkMELGaybmTRqY4lNFgxFv15HmogqZPp11BMDD4oaXY5u7QvddLcwp+y4qo2PFXhF1jB8sjEKShVtujtld5HKBoxdbYxMqN8QvDzxd4k7z/q2ZhJ4dMOMKPjQmJyE1nOktXTceZkHBwJIbVFCMyZxAoIUqMLihcC14kaHv4xLTsqQQHjRB6RZFHb3HoM4ws+Tqrf+eoEz8xcuN67twyfiSbT9V1F3FIn7zjxT50paonuJBQosARhZW/FsvWA/MOwfDRnWnUE5C/wZrYwZqf27YjK0TVDzpCYPUcmoGgrg1gGlMZip1lBAEZtZ7CJF3HxzWk53uZ4ADd3nDFdVHSYqnoX/zJ9Zy0tB9xWVExFvaXRleyJbkd3XYG9PuowyPnbCqXZ/QvEAi5eBZyenNsFaf3wzduaIxh/0tbS6+IO1iPXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34884ec8-7d8e-4b3e-41c5-08deb5c3fc4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:30:49.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJvGZy/02DzROOTbeNKj7vNCmsuasVSK8d1YUXl7BN0sZJCFjauINHzlY+iZoR9KMWTDZueLCKw4S1vRw/g5Kb5BS68f+Qf51w94Kc/eyVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Proofpoint-GUID: vvSqMKiCmUyVKaBFn36AOhaCl68krT1I
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=6a0c9042 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=qdcGDM-7Fkr9Ez0Dw4QA:9
X-Proofpoint-ORIG-GUID: vvSqMKiCmUyVKaBFn36AOhaCl68krT1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfX/T1OCv7B2LAR
 55XeAG/HAaP01U55pop3bMvzLLhYmTILhw74Fo3qXRZyAhTaJ8VZfdWAsgIOtnHpXI30tCOL/2r
 B9+3XZwok7fwY/dECkSrTjYJE1bo2DrMgzlftB6JnICxINkupeiQsIThwscdaUTPUejiVwZog/V
 BMX864W14DdrZqlJdx4H76rr4nk9JWDXeT4R0e6sPIm19Kc0FqGvSU/KDDR5qjAlbFHiLFPatuA
 9JOAP1nq8RlAuvF13ziFZxRGOWJG/MOuG584gUOoJm8ioiYmDEt/A2f8gRuRK+LTr4Tzg+OhqfS
 jNRYArbG3gXdWzdqKxPU/voWTDJrhc6kTaeJgHncZDW4cNu12iZO4WqBXpIufTzmG2sh2SZ/znr
 v7Hnx3LJ1sHFW7oI107uvQj4KO2JRKqu0lGX3a79n8YZcPCWK35B0TpYK9fubL8FBiSNazfz/hA
 SATOQAUN828vVpJNffw==

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 Documentation/git-range-diff.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index 880557084533..5cc5e2ed5673 100644
--- a/Documentation/git-range-diff.adoc
+++ b/Documentation/git-range-diff.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only] [--diff-merges=<format>]
-	[--remerge-diff]
+	[--remerge-diff] [--no-notes | --notes[=<ref>]]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
 
-- 
2.53.0

