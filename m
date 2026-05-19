Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F04A138C
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208285; cv=fail; b=dULZ27szStb93iikU31ol4xERat4vU5Mzs17bkHXfKoqzT/RGDKAphXRkXFWPmU2rVP6tcvH1gs5LNdAMSatAQmOT3VDnRNb4tkzRHPsn5MRbJ7JDEQ081G5l2UTMP2S5MsLqnkMqlJ4rD0hwM2kEOSrF2y+XC1RITX3yHSpW7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208285; c=relaxed/simple;
	bh=BmMe8CI4BTpX2idpc41NQ77yknCfnWIK6LQEXGj5yyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QeRsimAjnOOttAryFNmbWDYyPnIZ+3skJn35rwqv7W96XJlS6PNwX5mjLtVzP2UD8zVpHxS5AJpYggXvqurfj90jDbvRfKf17DyWM/AfCSTHfc30/mPrWjOO8mrx0/mDxwsvntouiGqxPKu1PucFAoxa/CZKNei6BGl0IZr20sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SuH/LsZL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aDaltKT4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SuH/LsZL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aDaltKT4"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JFianC910074;
	Tue, 19 May 2026 16:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=; b=
	SuH/LsZL6wXZCqU1PvkJpE2ixZLWsHsLO3CIl1/QaEo6ckhtNu1uWnihKZA+AZLW
	THutcSreAIxlhCK5KFGW+1M0LyhPDnMm/v6GHOauH6BMu0T32VNG/j2CiZ7dGbsI
	FCAKlpxFkrAIQD4EnkIfaL5XCySQ9rZKoADsYr8M3Mp7bYWv8MOFvE43yTSidpC2
	7ZgyWd5UPojPfHBGbA/AJuaQo9JD2j85n/Hz3SQ99LCX6VwQP83uVC8W+dGSd+Dk
	Q4tue+t9LChaN2i9R++cAFeJZts7Raj0Lg2a6YC9l/T0XkvyfHLLWRVQP149jgTF
	JmMVPr2z+QMXV86xOm6Hqg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gyx54ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGOlb7000781;
	Tue, 19 May 2026 16:31:18 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e84ech061-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Am9680eGu38J3TWJ1F62LKVIKugrC6sTdDnTtZO7nsspqqh55AhUBwrnJPXEfuG3xEgMItWdPnkX/XXXQm7rKapM9980HIHCOOlt51QtNyVkmdE9sj+Ec9jCVHmoVnf7a0Z2msVK3t0LThopwFftTMxDa+Ke0iQif1TLrUT4G+eQwxxnaDoN05Sl5Y11VVxOyPNGTnCszW+2dQXEw2SEj+eXk+P6w/IWC4BWoBnXgZDp5oXaUu77TEJoNGra2s5jZFkfciq2hp/Lc1YAv5TBcp0ebXYNLrfpTJYfuSeF5SAncjmQL3CvcYlVm2OWEDcRvGG+FDuk9RRZKpPZGoNLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=;
 b=tZ4Q/izyFzPS3H6EeIHabSuq6G6wGZ82c1oCA6Z5lrl1G6GLDNfOwkCdO+AVuNhy4mT+zJdZPrtAKunXoT1X/2Z6YfRfTQ93Bnr/bbkRdQwLWHIcFoSUCH04m3HfCVbvWKWww2fncNRqRckK/k3O5Py6DjPOdI9M/FQUujYADwsIG/r1D3X2BLji/tfvp+VxPninmrAgYR0P4EK9QHH7eSA6UtvYI3SGEi78p467U9jzWtl/j/gSSWtghS02X3sySykHBlbEakJFGeU/uyZUgt4yhPRfgF/a6DsxO8rvZ6U1g/cIdm6j7LIjhwMJyfa8VZosW/i85l9KabM6zvo0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2bokitCHtXjUmgEhLeD+ZUarxk/bZ9yeCOOwTYRiwk=;
 b=aDaltKT4cJ/pvq3ImEud1hfrykinHHeOL+XtcVuUjs3PNtbB93shddOVv+G/RsOxEUwNSjg8POjZ6Yfg8OcCSUMc0m7oo+l6TBvS2c8l2ii2mlXSLdR922db5OGDOWxQtwetK2+ryrWLZ2uPTMAuwmFk0Zqte8b1GSWkzgeAA5w=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 16:31:15 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:31:15 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] t3301: cover generic displayed notes behavior
Date: Tue, 19 May 2026 22:00:35 +0530
Message-ID: <70f22e5318ec25acc43fd7818a781391a31e2fd5.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0065.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::14) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7d01ee-a686-41d8-7d7c-08deb5c40bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Dv0FFnMxF/dABGeJDY0rtElICmC2CwCotxfRAEjVKsTfHdtu+ogY1a9Az5DQ7ew/ajq/Fjh367cspE8gFhW4WczIpf7cSNmSLvYZJUpSQUfhf2zb7EYxHTWFQIdZSnKtI6VIoVkon9OSOQMqOqtEXJFLYGBXEHCG1mDAf1vPO/CiDDDb/V9Mw7uJeGy3YpFSxh/PxaoZEMSztxhv8XOcFFf7PxmXIbcRoyCBTgqs1lpJje4YWwKxlItz/AqkkQOIwh40a2FkBokqfUVYTC9uYbftMZvlN/alnYFglitiuMXVdjQfVdFuMK1HlsOrA3JnNnn0oiUwf2b2+AtpU7AtUjCRzrdE3Qw8xPqLYOjWXtRMN2CDJ5m1qLIvdx2N/dmejBYN8wFrHZ8KeIGFIbAWgU/ym8z9/TQIwAWRQdWxJG1VJ7w1usjhHL5hF/ze8M63gKxFAHKDFfiMtNMx8KdyjZGxghmiyMWQXiiCaSBRkKU+X7DQH6TpvysZNOb9Hsx4ym0oHkmx5v+JwadiXzRUsjJAAmy/JVXBvYiXan6mN99Ek12ksJTdbNSJ5bIPvcVqAJpqV10lE9RzELJo0tyzYqN+nydiUcO1Rma7XDuXTP9xAqrXYzSrzOixSpyUSsV+U2A5PV6AqdYpBw3nSbHORIJg+uMJQD/CgLs3inyschMCYAQuRGWTf6vl+mxBPsYS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RcLZ57E31uMciTHhbp4hwEgVlMBYJkQwIhDRcTWhRdlrylWXYXVuiLk8ELo0?=
 =?us-ascii?Q?U+vnwsBsZItvT/b05JBlsSgSYzWhyIPCSvV0WTR8ECxcfvhoiE4AqYfg0XAZ?=
 =?us-ascii?Q?MPBijIlPpeRKI+R8/cQEthb0fYISmCs6NEgGqsSiUaoTe2CNTd/SgIc98XKM?=
 =?us-ascii?Q?zRdd9Aii7B4FxyknzlcNBs0T6YRCfGwYM9+eEME+JbbqVBSy+GkxjYjJmTTS?=
 =?us-ascii?Q?MnNrWnJN5cThIpTdti2s1wX/6GnTfVu97PjOVSBU8N3ub4Hnni74yumBzuCF?=
 =?us-ascii?Q?UtT6kSubxdxi/+F3+6D5EWgPv6263ioEd+pXKX+QxKPq6m7ZZ8vNUV50KuRY?=
 =?us-ascii?Q?JVKCOxPC/0+3+yL9ezRj8VlR4TZA8Bs6SU9M6Y8qn4smTKBVYN6TmzQR2o3c?=
 =?us-ascii?Q?ML2BRmLSCywJEK02IMd4wdja4yBoqZISft+MWHN75lrNB7F91Umhaq5K1Nfw?=
 =?us-ascii?Q?vo47dBJnRnKDADfnv2qE2sP3Jw4HCQUEua8d3E7m93aMkxre31m8d34Vu+K9?=
 =?us-ascii?Q?6S/n/gu1CTg6OyVlPfkeTpYJIi1vvJSktvS2rRoN1vtDh9p4L32HELAQfiQx?=
 =?us-ascii?Q?CEG+cRB2xkSOjk303O/0F66P5gp+jmactuQmvHZz9Fer0WdaIBoxuybhf65D?=
 =?us-ascii?Q?r0SMYlVHEA/mE96KEWEoE2Dohlox6ZKGHznuO28mws4+ccf+EhZ2nllZv3DC?=
 =?us-ascii?Q?9uFciACdQI/vjTU1uRR11siY1QWxeERKt4O1S9K4dIlKNcsTp7nwsWMdB1CF?=
 =?us-ascii?Q?/8kOdE8+Hryo29yHZMUIn4CwyBNQxn9zMhQd4vauW3jdEZaFcvMwHUeYtgbp?=
 =?us-ascii?Q?xMcKO/7PiofeILWrXgDIcmYkj3LBQN2DzzBYdS1STRlzUFL5X49Vqf66lKpF?=
 =?us-ascii?Q?rg4c9sn9L1wh9aQF+guAyjKNBK2th/QjHF3YiIXyVL3aYuGykVd3qvqboLAx?=
 =?us-ascii?Q?HhJozXz9RW165LMDUlOcgDfxaXM2NiYfcgV5n2RiKii4SKtWdcM5bmZF7UBd?=
 =?us-ascii?Q?Q8fHqo5L8jGT2fTmzrg1rDdyTRpbsdv9igS6ODN0lrXIFHVn1aUYpJOuQAUf?=
 =?us-ascii?Q?Rzgd0UBGwacYCXOqVVfALhjGnKgJzaozbhsWduXcCQBAWrKTAQT85P77T8ss?=
 =?us-ascii?Q?NCcQ3w9cP+PvSlVDaPe5Q/nv/3uK1sV6goZT8ylctQVOSwBnIT4ar5RlnuUo?=
 =?us-ascii?Q?Zzmb2lB1IHm8CBwSxCKuEMkxP9+x3AkepsI5s5js5DAGU6v3ZPeR3NrdrlP+?=
 =?us-ascii?Q?wtOoWfLadlDwShXrQxyJOnbhzJnzdjeyz5EA/GXtytQFirMlimthh7NSG+R+?=
 =?us-ascii?Q?QDWFKqHeP8yhD8I9U8xxYRksCYqr4ahB64FC9y3KOqHVWX8d3bb/aYHNqPE8?=
 =?us-ascii?Q?CarBXa9RB6LwLRH2yP6XWySoalYvZjt3WzaSIxA4htfyJ6UMvYqIj7yrg3xp?=
 =?us-ascii?Q?90dNcnhLpKLHTZjM1YI4JNH9mVzIwyTfZ8goC6qm7H9DQo3IBwn48fbvQMaF?=
 =?us-ascii?Q?86FikG5UG482xcRGlxIZGEEKyzP6QwN4Es/S1rJQHjYFIzJir94bGprmMHn5?=
 =?us-ascii?Q?jWzaVUGjUP0Vr1zkALoxnMRzlgxi+O609ws0ghyIHUZnCf2A5crpANoc9mPu?=
 =?us-ascii?Q?lCC4kGd8ZuuHQoWOiF7hBHPSYgo69otfhhMl3n/NgUKIlGNxDY5xIdT8OmnJ?=
 =?us-ascii?Q?IJ+qdSrJd3HLaYJ5c/cmF/+tilM7n/BdvSFqRRIh6Cltr12WPqmtGZIHHkfI?=
 =?us-ascii?Q?us31/2XFPnJjEvZf9Ruo1UddYjzJ9vPlALehi5H0N0RIQY6VrPNHIIXaxCnB?=
X-MS-Exchange-AntiSpam-MessageData-1: vPdAhskjO8OeedVF5Uo2EpJTAh7gy/kZpgw=
X-Exchange-RoutingPolicyChecked:
	DKXDukzB28H9x85Rey17r8gKTVqLHejpp4Hj0R+9BDJzPIChRLzf/Jz2jzHny+t1mF/0dnNFlnwF/eFqaRO74eJpohUF04i5hIAhDuepVx/6FZzWe1QPd/9K8hCgShepPaJeEdAQRD0A4WZJonU4FhomLVIL0qvpstNtznOxYI2aKWYN/6/y53P1U+NNPCZUyA8hrPcHVn+CaEZN12yI55/02vRz4Wqyi2AzsmbnSBb9Kq66oZjtgTBcN26vGZDijkMo9k81QMq2IsbnH1WI4JMUS9Q9rFKehasz3R6cnpQi7/6PmPHDlmz9/dlZxg53G6jMiTFK+RmwJBvaD/2QGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jbO5gkQQ9IEkJ57b+6IUF/zJmLMnFUVIy/jBd7aTrk5XwodPEkvHPeSd+zl7UcfIkEUcMN3fN3CCKRTBhXApS5tPRGF9F8a9zWnkpcFjfaVrjrc4oRM7YmFpYA9DWu6V027WBlaooBXyEvug/r+miBh6i5+9tA3IbAYLg8jQyama9K5jV0gHxd0kuVdUc4z1mzj+MLJVQmdxgqfABxFe0Dh+14JuQUatmQCMLQZXWb4jxzjWbMB7d6ACZ+LWknMrjGgKH8DYXS4ZE9frFRVcXOPU6cZYq3NWLhEwWqrC24tEQuQoMqosvvw7fj2b7Np4pl9TjVVI0SFFAK9v7i3mC3Cea++/7UUqr3MG1q20fetMknVxncnLqlRLyu6+A5DLuB/OGTvGoqmMzJGh13pc3yHSlNnyriS61WKcv42ZAgJWpeFhs4/wlKmUIJyStn13RLG9PBx1vkgB+YX1uHS0eOAc+5qffba+RZKNz5hC1bfsd8YKfkXjntHv7jKYrh1p02ovMfaUeNzAIkuyKciXRn4rcXmfUVotnfCjvBJbI6JxETnipAzAwu7tnvNdF0kSU89BJw+brntQ+cVcFNp+V5EDYZ5t5BlhFeKz2h0Vd5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7d01ee-a686-41d8-7d7c-08deb5c40bd5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:31:15.1329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKt0FD8+phvJJ3l4qR6QAtHeQd/ntk7wxopY8PasE8DwQzkp7vmEokFGzEszpIzEZ/ObBZj0P72XZRhjR1jdt444PGSvviWVHC67jfhrXl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605190164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfX8Ht5FybeEGQo
 tQKEIyMgb8Ioh22eH+TaYV0L1aZRHQxvJcNmZ6mQfxJRHVJpjtnXmmx9OAH/770ed2KHPEqec+T
 jwtKLHASILtVoR/vOZAfqxhrOFuBzbDSOplddz27tSf+BsCXM/hLyPuwCgbAXn0fHFhlTDTZ1Gj
 BlBgx8rozyZl6uOhuafK9qEbt1NnSFRlijCmdfZY9DK1Yv7VlgAMGWfCyiF1XP3Q2gx4dOs+/kY
 5uxNjZyf5jIPyyhsTLNwPtLibg2jjq+TeuPHZxI/KdnA9YCPbgCva7XBusrPb3j9ZrC6lzMI3U7
 hNIQOxvYOWh7q6k13rv7FUJxi8sOMVZ9qPCD0/A36OYcQuhzncUJ4ayW6fMdbJZaXgKfSNrci5p
 k2hkxxU3+cNH5ArkZNVJX7xCv+2ezPpKhZ4ooQ/OISvyDFXHT/A4tDkqJvV0jk3tYZotrsXkodG
 D9p3qfiCF3tN/hz3CvTmUbrvZbxE+59bzjAhtn90=
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a0c9057 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=zp6zO9qf0PI-K8SJbKMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Proofpoint-ORIG-GUID: G4Kp_vT2M3QS8PK_WywDE2rWDWDrAdEb
X-Proofpoint-GUID: G4Kp_vT2M3QS8PK_WywDE2rWDWDrAdEb

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

