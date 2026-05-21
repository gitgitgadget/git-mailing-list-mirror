Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8E23E330
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337180; cv=fail; b=ahsACOA0/zKIUhs4utzWExoWuzUxIQPg8ItiuUQ1EHtRwC79uF64w8wRyACnRs98MHKscFKyuL+PGfNw1QA7O5+jjh6IVuY0Xw2/fL2tf/H4kmXZX58pz455DCB7KfKm3J3EN9kzfws2qbS6Cy0VTonBDoWX/ZhCMMxvyo7rSh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337180; c=relaxed/simple;
	bh=MNOuN1ANsll1vgHjuIEwcmd5KGWxI/opT2sEYNfmR9A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E2zzlowdyOT3g1mE5w1TtLptpCv25vWjNPe67gjVUTU/O53+E3yOQyKXOlm2GLEljg/fEnEPm1URo9llQqcNcX4oVuxfISe2SIMnkfRBvGzkCKop/8PzFIV80IzE+ZAFbTHOkthqcSeOiGu6aZYP/XyeIADRHnKGqy+/bLwlJTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vyltp6Y5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IANfaMJ1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vyltp6Y5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IANfaMJ1"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1Nrm84095422;
	Thu, 21 May 2026 04:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=mI7b/VZUGJFpXR0G
	s3sW9CQQgqwXflf5o5QJ6zwX3G4=; b=Vyltp6Y5uUqvAWXTP8u9fS5OHdxReQyu
	3t9cFK87eXFXpDVfeCMWmiG/eI+6/vubpK9B4dj395nNke8mOiPCoj9CWM4EV3so
	+0P8MYdp0OsGH3hBI/mAdvg7iB8tBQ5r9zCtxw6bZIwRXgPV18+0omkk0iQOieEn
	nc996itHBPZIODTEvDLAoBxbamsX3Yhs2EjF65WDJFJeYz1fZW2f4yhlf8qWzBYv
	EOtFzPP3gHVlwEBY0pmy72U7UTSLZU8HsxXHnoTzx05rX49qkfAew8PMXmkhGn6S
	QBY6rMSV38uANTS2n2+QNfKgHyQCOWrPZFsBsgTTnyIJeMdaqifGeQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1t0mu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 04:19:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L44o42002564;
	Thu, 21 May 2026 04:19:20 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1j4mck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 04:19:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv/Z9OZGFLosw3BB9XEypo5V5dysNYhe/ukRxSgbnFnyys6RcbLvHIa+eVGybIw3jNRcpqh3Wq9Xq6objgYBHQW6EHYd+r0OeTMuAKMMJyCZ2q1uPv3GgXGF1QXLx0BQ8G1NDtBMI6zdGvECqb5FZmaNvBqvYGy23mL1BOMNxHj9FtsDsN73gSH8PIIsvyFCbXpbzvDBTrWxEncvwJ61RB2LjnJpJp7Wnw8F6pEcbrCSK3xPEZsjDR/f6U1Zb1rbEDg8Rj+w4feKPMKIDM7oweafYLu/UlQCilOlZWwXJLbgC3jxdVhcGTgTICWIwhiakQOzeLsVFoaOFlwQK+/V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI7b/VZUGJFpXR0Gs3sW9CQQgqwXflf5o5QJ6zwX3G4=;
 b=ogRtEcj3OIXh2qSj74bbDkswny0yOVi/7wka21Mlj004EUHfrnoX3fCkvUxjMEjzA9TFyzibkiYilRvcTSWzwV+KXJNj7+4plIAaKeI+7KGExJfwAuh/FmgRmBvaogjKGGPgooBobmfr2TCNMwMVrd3wgwR9ehVVLr+br7Dtv2bCm7MKGL4xorPTXbCf9JfRkzUiXOFvlz1EvJ45VvZx+MS30HwbR5d936/6pa9IJeWgzznrNbca5t+AIxn9YFMxs5/IF69/3PwEMBqY7ZRsWJfq6BLs4wV2jkue0K2d4DTtBJvc6NedmXGPaoxLfhUcXlkp06T551CCuDIKBSLiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI7b/VZUGJFpXR0Gs3sW9CQQgqwXflf5o5QJ6zwX3G4=;
 b=IANfaMJ1zovhltZSxebYsEPJHwmHhPsOJzS++SI9fkK4eSTdGG2jUtq5bPYLnSgxE2U42hZ9HAEn1Lzws4aq7w0yWjBZwmP36eEycGUbFuMqp0grcvWyDux88M6lg/bIczIicSOBHy21UXqH6ZEwzlqTii5dTzIcN0aAnNg1PwY=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS0PR10MB6032.namprd10.prod.outlook.com (2603:10b6:8:cc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 04:19:16 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 04:19:16 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] Documentation/git-range-diff: add missing notes options in synopsis
Date: Thu, 21 May 2026 09:49:08 +0530
Message-ID: <20260521041908.41055-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::22) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS0PR10MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 163406ea-bf14-40dc-66cd-08deb6f01f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HmL1er47wLtKTRbENp3wVlniOHRwgthA8MkMTvT6c1hBWeYUrporI6FVjEIEyH1YOTPoxLf3wxwIadcLSZ+RtgALsxIAOSTxo7SKXwSZsSADrVtDv/r+E4j4f3R86H38jV83VKE0DihhnMVKvag1h1ltR9+0HNg21Xq2kO/10exagmev+Nivh4BESmGQR0DDfzh/38SHkvDv4550RrRQZPwnm2bFytHB8xXEFop8idVUQ0bTbY0DG6vivw4hU2TXjK+eltBuLVX1yB7sopf+DWrpFOId/wVw3qlrLYD5WebsEWkbai7Ore3r2L6G585MtlqmqMvniMOQv8LfVoW11Fi81OwCVV41TID7gXw2FMELnwGL6tAUSV+Fod82T3qSfVg4arycdz2g2TccTK6rwtxJ2HZlb+P9xHzp8QI4ykc7I0wnsfj9NzXCMGaQZK1NyxtyTPZ2nYvP1KxVrlGMmT0JkRFT4PalRqDLisOwzNgkiiFyxkSVFMFy7eJP5pSqDGeRzZ0cvnUZUUHoAJvlT3leKWZ0U2csub9Yi0STc26M1T6BY3lO3xSvB/MnamfenSQMB80C/nJkYwn2gMnOTz/bJK1bCtsUrmWzflnDQFbn0sql2iUhNVFciasGgFnm08+PJ9ftAsgf2/j2veLPNXCvq1m5BJeH5YaTpYDK5OTj5f1pqpdvAYfY2eWQ+NEG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2AElDyednvs/LUZLPK2fJ36QOKzsNKPkzqjubsxgpzIH9HsXY63lil5/WKS2?=
 =?us-ascii?Q?D3E5Cv5ocHMkadh40+pR74h0Db4ZiLLWGldPjA1Q3Ye5lml5P4i4LCzxpqQj?=
 =?us-ascii?Q?4GOxnmhLAGQEPhKugb+rzvG0GbXRF5x/6P8niIBI14WsdL/s5lX9AKJddduc?=
 =?us-ascii?Q?OC57AonqQyf5OIp4wezGocskPcNHGsw648zqGIpQ2qbvaIq62NjAGOrLcbRu?=
 =?us-ascii?Q?LkPyAjTNQbZP4+wBV9NzioGLth9eJLvxWGoN0lb7/wyO5dA+jiDAj6tz2qpr?=
 =?us-ascii?Q?QwVrRUzyyjOJ6LNRbwUh2e/m9YXuqGiHYx10pWVuiIK/HkxahHYNrJFLt7e3?=
 =?us-ascii?Q?Rf2VWorwA7cpxNWvBjF27THfzUFCCVjaHrD51iPODDUExW4dECIH3e8ez7zq?=
 =?us-ascii?Q?H2GYCpy83K0mzIFv2wjYHYgjEn4RuC0N5wLZPVzEI2ydU8Rj10zEInZanWfE?=
 =?us-ascii?Q?B8CgSaiyveoDh+ar1V06S5+PKB3jLUzdGlWrSvE1dwXEaLN+1JGApdBggFdJ?=
 =?us-ascii?Q?cgRio5LtGskZtn4xBSIprtq+6wGq6hpHRqmHifLdBq5PilMn4AVZmhExXoVB?=
 =?us-ascii?Q?/fwdqivc7ugouGwws2ItOcBEQl+wVegy55FhVh1MrfAx+ZEMIKATl2OVimQ/?=
 =?us-ascii?Q?KbqixI2CzNCScyiynu65F0XeFwvEu5dPAWJkAKjcDcIpEXk7JdJm2XJV/r+t?=
 =?us-ascii?Q?tAVTkT7Vj6h2TMFaak98proetV5Cs2CYQCk282WkSaSm+OGSXeP0ckwQdvql?=
 =?us-ascii?Q?WKy0YTXMJlfNrskQqYynR1MAP/DvogAOgOv+C+yuzf0AMtKTMGmwLJjweXVe?=
 =?us-ascii?Q?GnAfCyylJh3qiqDnNheqtV+Izrhn16pTmYJu3sWWelVwuTOu/cjwMsB6M/xc?=
 =?us-ascii?Q?LW8cYXu61i3euGdIn7w6Tcl4Kuxu+awm2Lyrg0h5agKoNQgQcsuaP0CyPQ68?=
 =?us-ascii?Q?L2niuBjp3X5j3kuWpzDmd3/kY6n3Tl1My/3Hjj2JlUoFbO88WavO2Eo3FSu/?=
 =?us-ascii?Q?0srIDE6IB9n7kYAm5FbSSSOZbI8F1N+8DfzB8MqJMhASYH4ODtOnk3ex/qdK?=
 =?us-ascii?Q?P5vtNYOc6w9GGKNuV5oHvLWl5Ma96G2vcIDv0C5wy1g0MEHRsJhLl2uU1yPA?=
 =?us-ascii?Q?UCdPTuiyRtzCvBOoDiWm3CmhH2gsMghKEr7RP89j2ItCGGywmJhhssX0vxYS?=
 =?us-ascii?Q?ifHugXH1dqd6gruG5RQs3RD/uGGNbtk5aigRKyzl1Ain5vsVXPrjf+ve99Or?=
 =?us-ascii?Q?VNBdI0XtJPIk4eb0fEQQgWkNvxcfaQJxfeBnps7iYjYhcEBNcI3O9hBDFesL?=
 =?us-ascii?Q?dMt6T85i30Gw84ucHGWyDNaRb3xEFMsr7TvGfJLQX3gpwtBLGLPHe6Klh3lJ?=
 =?us-ascii?Q?wq2O5ODfMhuHr8W+kTEy67J8OsQ/oeJDfwAShTY9jPAI+2k5GNdteIGb+C99?=
 =?us-ascii?Q?SDs/kU8CvdwB1ZFl0JsEb+VhdZAiVaW5ufBiMtcRjSmIBHeZxPUxob/IEan7?=
 =?us-ascii?Q?VcraPFYDAJhWEQkCPG/YBBL+sz1NLLKAY2j2aKQ/xeA0KqT5fsbYsl2hP4zY?=
 =?us-ascii?Q?1zS6sLqe+PuUv9LVcKaXETq/WPG7uWqIlwFfZEAYSWpTZlqrd7V2retmatZ3?=
 =?us-ascii?Q?RGFTjmZiPU8wUeZ1+G6zESSJc8BeAPAAKlhv5TFz9m58aUC5KKUzMQiRIkMk?=
 =?us-ascii?Q?gfuqdxJbqX8QMhKYbx+o7jkEZs6NeRmWTYw4DsH/1P+qpBpHDR3+mw2QH3sr?=
 =?us-ascii?Q?GcpQJ3fiXm1Cokf/CjMLD1I/oaYwf7QD3Qd3YXC2dBHmh4lZjs76l8vOJPPW?=
X-MS-Exchange-AntiSpam-MessageData-1: v2pUqXE/nAGgSiMNv542ZfoUZpU66iRoiP0=
X-Exchange-RoutingPolicyChecked:
	rJcGayjjLH5QGhTIilyYZIwfNqNdOm57C/6awOaLUkbz6QbAE0ExQkE+quZLoKhIPeC5nUhSa0es44KJJRQnjjyNY0Ou+EE6hYUy8hgFVr1dkQNAcDixYF7iLY9ireRYnI7ezBXSbJW8xlDMjOv/uoLlC3okj14GV0qFSWQJeZQov5R04EM8gbcIb5xf/duxRZU8Jq1d2OYGbuO8gFpX9gqDzVQ+cwr7rYqdKt1dfHsiM/V6aMlW94Tz3Zr9mrs9tcp+/FiHYzNXMy3pq9+AtygU070Fv48x1IVim3uI2F5jAgVJAsQ8r4glBlnao/mAZkX2pyy2KnfnqQc0c1eM4Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0qKp09fNnhxRvC+05NJOh2VvKaOEors8WTk97rznhrs4BEw5RNB9Z26Iv6vMW/w18ohUHccLruecN0tLpgl3TdT6SasCoMtWhLxyefuZfBNpc7Q4TtBFkan42XGDonSO/M0BfM06+Jqp50FC15zygwCnXNfREjdcbL7t93A5g3V5H9JOuoZLX0zAbOXEFUMIVrDq6x5ICcx5PYO/nUZXzDZxg4p6z5Np3ebhRs774TtgDY/4Gws2JHrNDzMQh5gNIiFOh2Dp5ShXNec2QwZRbgjyhNZJVIvxHpoRiL1RQb0IHWi2A12ZlBA2iKYqGJ0utophjuqTiygi7dOiZbIihIEs79GWwkWOoGTNhyzQ6jp3kUlipE8va/nk0zmqaPKw2Pa5PkpM2yeeNJ5asPCTqzZ3yneb+ozsI5G4Td6huvf1UQaXSYaIHmrjFzJAYznE5PvaK7FCS1gUWp9wM34MVQvAj7M62GKt268fPxocxX+nZt7qdzVFYboR/ACU6j0Fg3B4mn1LWTqjbkPx78J+cD3kEbuov2UkkSUxvR3riqStZrdc50uTp1MM1XwTLYsZlDJm7qov0ehgfPpMEs4KZDYYh+xJ6M77FC9rjqEbELU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163406ea-bf14-40dc-66cd-08deb6f01f23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:19:16.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AsJACG+JVj2O095bo7e/XfCX0BOFzXNzZNWpL2lDwXKUFDCkxlgLUMpktoRozbFAtXaO40Ba0lmXyG3jtMoC1j2A5RYGWJtvL1ZCyLOslk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6032
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605210036
X-Proofpoint-GUID: pJdMFetMrIAyNWRGVZ_FLbs3CnteesUG
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=6a0e87c9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=qdcGDM-7Fkr9Ez0Dw4QA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12299
X-Proofpoint-ORIG-GUID: pJdMFetMrIAyNWRGVZ_FLbs3CnteesUG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzOCBTYWx0ZWRfXzSLfj5U2GgPH
 VhX/wgA/I4AH59MeM/KHZrtsC+sEa1ijf5ovZ45yfWaW2AsdtOzXNGnhNgfAJp4cbUcfExcKELr
 HroZ4HOea7faZ47lCN6gpPwZ5ApjLdwxQ4XAOnZIB3Lw3IhLBSZAaEtoq1dzil+gofz0DDDXMXa
 PKku0sPCsWUmEcuVHGUOgi7zzjki1apaynmhxMyi3AkY7dJHavPxpm3KuHOhytKYhTPb5XIgm6a
 5Pi6dULmRDFBx6HgFdCq0rj84MqVnFB4xPEUBsd/0JRtlzKKZ0bE0TiFVjt8Dns2SbEUbC/6Bo8
 3+NrFu/XMscU2bRZsHDpjR1qo3b4qKZn/c0tAlQThbV5UUDPcfKUDm28Y5F0TRTAp36fV/HMgPW
 0Pi4cbVnRrSsZVvESZtWGIYGhKnWHqt+wwv/tzIu0Mz+zfSuGPN1ABRaftogUNbOYbaeAZzsLqd
 UGNRjd/cRlW8rUH3c2u/Fnao8zEFBP7tX5owgNHE=

git-range-diff supports note options which are also mentioned later in
the help, but they are missing from synopis. Let's fix that.

Fixes: bd3619188682 ("range-diff: pass through --notes to `git log`")
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

