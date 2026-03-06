Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC532DC35C
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795435; cv=fail; b=jND+huEXeQsuHXN2wulA56iHXKe+yFEPt94ia7GlJiJ9GKjKr1rP42Klfh2TEnz41uz5G4HN68YdBajcpbsHnmuMYv95rR7XM29CaOyjRvicElN1sPGFU+tTrYdmKSmfzin1znH2Zot90AsuWcr/K8DJLU6AkWbRz2uCiay0KA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795435; c=relaxed/simple;
	bh=LijMKHqZD0XtTs5HU2CcFPW3pexy/WFMilZdWAJZJw8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rukDg3req2akTfDCF9aCtBOCZ5TynQNVnrZ6Lb4TRCTqjVsWjpGqhq41Y7mHvBUDH8rzrpSLYt2vCwIyUNQTOTMqPAQqYhybn7VXGdSCmdhsniOiTkJNt9WAJ4D/9691DrJ9kCQPIiU5vdeHWu2AWiL7DyuHO3hNbSczRHZ6wEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=Pte88aJN; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="Pte88aJN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqFFHjZoFCWAWp0Bt6G6vE63PGuVvMEJdw1ZbuqnlhB3wM3xfE142nPSCfR9jEFSpQj4DvqNp9jf04+8I+APGAVw2cUQnM5hTrO7XagLDKTwZJN9306PGxw+r7qdlt03PdcYp8+xY2wEAsEX4/9+AyTD1OqiS+1YoOPOQdpIIofSS5YJ0meZ/Rra+/uXhS97O2qdW7JnJJoE07IxJ4Td/o+Bsw5bwMFipX9aKO23StonISM313gxecyIKeiU32B/tiZWWKbjzVuSBjos+Ef4H3UnpOpElOaMhpcri81GLtdb7yG80wDYNoW3mz9cREesZ7thq/PG7tESLhmE8VQ/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPOkgXqeHU97sd2/GkKbWwFrbA2mPn336ZclCtc2ktU=;
 b=w3Rt0pjtHGLoYoC+0ntRhyAqEr45xu7FYQciu8LBjjh3sh0A8e7hRb8qZjt7jjn9z33zc2iWzHlfmpbBLdCusTswUeK775Rnh1NG/ezNKB37ynN61tA34jwkJRWSPX/qim6L9Nf2PexJivUfAeYQBIPuv70QqpLnRkk8ElNLC5RovAKH3wiACDNYmq4kdA9tGlRwqcBtXo+vOgQASZLR0VY+XkJM1qCAGpiLx7c7FFOd8KPQY3IXyOL+Y699F2keh0xdVYhLgS3rGSD26f1dmxN4supEm7AiFTUAK1w4CrZETckNdImfHWom95+VQFbM4s8msfGmGcZXiy6Wq0P1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPOkgXqeHU97sd2/GkKbWwFrbA2mPn336ZclCtc2ktU=;
 b=Pte88aJNRliKjPel0P4P6WA1/Vd4lNgNSXc6HlG8UEkVbnMgrIrih5M7U3qFccGudxHFtHhQC0JKlQFdiri2JucDkRBJschAf5sB9hzgSRMg0YFiDXsC4oZtpnkLE3Re1rB9EdWS0YNRf5SjvRpmFP953Tp6CUYiJLLDqaSdqK3aggLbZXwAgLx+alx4iXZ2kL4HJpMbanKnvYP3zprikBQ6yW4hylkL6Yc6dzQwdHLi5py7rwFdtqdiE5iGDq6stEUWwx8hcI1GLhONIn4AFhH5meh6dUyW56xeWq8PiJsejOrGLv0II5w4JLPO17rXMHT5Yyr9r4CIhFTvc3gUYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VE1PR03MB5855.eurprd03.prod.outlook.com (2603:10a6:803:115::19)
 by AS8PR03MB7572.eurprd03.prod.outlook.com (2603:10a6:20b:34b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 11:10:29 +0000
Received: from VE1PR03MB5855.eurprd03.prod.outlook.com
 ([fe80::fe74:7ea8:49dc:da3]) by VE1PR03MB5855.eurprd03.prod.outlook.com
 ([fe80::fe74:7ea8:49dc:da3%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 11:10:29 +0000
From: Adrian Friedli <adrian.friedli@mt.com>
To: git@vger.kernel.org
Cc: Adrian Friedli <adrian.friedli@mt.com>
Subject: [PATCH] builtin/clone: fix segfault when using --revision on some servers
Date: Fri,  6 Mar 2026 12:10:01 +0100
Message-ID: <20260306111001.261916-1-adrian.friedli@mt.com>
X-Mailer: git-send-email 2.53.0.394.g500c12b044
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0097.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::12) To VE1PR03MB5855.eurprd03.prod.outlook.com
 (2603:10a6:803:115::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR03MB5855:EE_|AS8PR03MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: f903ddc5-41b5-45ef-e40f-08de7b70fa20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	pAFNX0bWCh86mVldgk729hm1z0j/jgZq2dAQDzFAoqZ7qWyv+5PGm3FvbGRZc35u8CvZU94u94PDZ0nAEaNIgrXYsLowz/e/7QNqf0kJ8MqJk8SoDR2/kNSG6ACR+cOwqTPsZEmzKOYaAp8DF56OD7xECU9ClbKClEEstfG0cu5vFOTupDFaNFXnLjvSEp3xB6MzvCPlImF5SbhOZIngYOenwGM6V+xVHydGiWgQqq0mOV+RZUcB6FwwLW0VUF/wMtDyYfHoAKlJ04ty9WHMHYIULflIeNtAlaVtOh/b955BLiQnhaFWsXpz/uiTi+qSf3iW8m6cT8jBRRZyYa8xRi5+hp6oN1fVMRUCTAij+/gXKHts8rLNJhwde4DSgv72oNlaNRtNeiPhWQLjfrxllkA79V3/w/aEQQzL3omBsvc8RbFqDiPXU/RK+oFJJeTcytJ7bR2MDO5SrTRdtRS1Qp7GDci2FlzNtPMssbx1zA2pOKGMwQSgBmBD59OFeSsf/F6sL7vivMdfSzmhUn7rymEUqw1LvQWEeM+nfTCKWHOS+SiOk+y0HCGoG6Df/Vcah9ED2YZm6PmltK14Ym10rBIu4hk52DFeNbbHLCj+I2d7okxTmi+MxJ5TsqrgMyEk3NXD0bMVt42irs4Gl7it89crkn0hZtutA48a7JxbPOQPjLIYvlJ7TmjFH92S9fmKBEpTGiD1MlehqpfCN74Ot7jkZlywtXgEfC/Zmnz58QE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR03MB5855.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wKaAWn7hGzqrFLgIL1eFpJNyiZxK1Zid5wh7h6FLL0ClwwJhtQLWU4IOjBnB?=
 =?us-ascii?Q?u0pJPERf16d19hpnbSj40FC2MaCW1n/NPda7yQcnbSQRXp3QXSFwPspjMVVZ?=
 =?us-ascii?Q?QjATZID8J/0aVPAL5hFMnaCiggztofL6AArUdJqcEG0xcKQ+JPzqU62tV+Ip?=
 =?us-ascii?Q?RjUvGi2UafBk8TiN0LJBktNYLHEAFzuggrO6kLb79qnJiYRAZMgqjQgfhZBM?=
 =?us-ascii?Q?0Zcm4hexGD98TTA2Zqv2p2hRvuXDc4qvBaNEbB6mkvY51FqVdiIqenbqFPcr?=
 =?us-ascii?Q?y48gx4Dfk01VfWucNdwACoKVgo4bbbUA7/j2R7BeGiIscijf6Pfb2VZwJyNd?=
 =?us-ascii?Q?je+vIyVkycPgKICntqMUnVd3IZuLQX3GgEXs2NJXdVStytFkEBMZMya/TA85?=
 =?us-ascii?Q?G5eB1M10VX+3JZd9QPanl0UnBBLiscb5t2Os8sZ9C3xWPCdnaEKk3l++vx0G?=
 =?us-ascii?Q?ZSo/gjcRSMZD1mNnfgXapnF0WvEe61385FyXXKj+xhhHU+VgTRuo0LzWAJTl?=
 =?us-ascii?Q?XUKlvPuQs5d2OxyqchCm3B7DZ8ncnyvVuLiU5Db//Cbb7sLK4dLGB3+dd+WV?=
 =?us-ascii?Q?CZmVCQuRdUdhoZ33apECFdLWaQ0cgqOtq6YVOzTZFur4oWPy0Y2fjeVHmpkL?=
 =?us-ascii?Q?30bIVO2RtfFR3vGMrkzVKlBA69fAInjVqX4ZyB4nA1ZeRM3Fsii1mkR+1COD?=
 =?us-ascii?Q?Pr/yons8eoXg7l27WnEwXqjDcPEXt2BsKn3L0UXUnxbTPyePcEk1zziY2wer?=
 =?us-ascii?Q?meKqaM6ovSxxlxr+HuFY6+HTpRzQ9/FUfc822rmwHEH3lD2h4F33vodbKLZo?=
 =?us-ascii?Q?u6NXFkPIOLS8J/B89qcoC3l5PeWyzlS0ZdVO2n7wKRTPppuhGmdzazQkivC8?=
 =?us-ascii?Q?Lx+uSOOuhbTLlK/d4YoxUc/ygiardttQjpJlACZRwoa+2BDwMnhJsKRwj7rB?=
 =?us-ascii?Q?bMx9yWiCOQxR+nP+07oJ+PgItgqQZq2ai6rN23TAg6lZf2l7QH4upPsfUgNq?=
 =?us-ascii?Q?0H5X5y69VRsIJ0UHu/RaEvrc+h/vlErI3kNzMqvGvBYaapRw1ghFL1dQLG6K?=
 =?us-ascii?Q?Wbi8fZMQ2Qs8moZFMyxmdlS3hR+SrPQSKc3ob5nosOb9z//u8GA7ORTCbWTE?=
 =?us-ascii?Q?do/j/r9D6gCGNI+EV9Rmq2MbxlID/cD5kcQUTg9m+B1PeaubCop15JHw3TD5?=
 =?us-ascii?Q?T8A5hXd6nVY+3+hfLuvU25433IHL7m77TKgCDZFN0sufdG20uCl76IEPMZ4n?=
 =?us-ascii?Q?cVMaO1LGId9/8MFGlq+Qi1lTbVXZ+MZWlbS6qeT6p61EAhWo2vb6NljBoITO?=
 =?us-ascii?Q?Akp0DoF4SIhJ+tblMa+D+FqWBk66VjXY5ukgNU916UwVIfsls2m4c5lOsWpF?=
 =?us-ascii?Q?fv+ebtv+Ea8/uxDXRqlzxr9WnEMkRZ6J6ntf8uXugepU894xRr8pU+qxNjPY?=
 =?us-ascii?Q?blENFf6O2fQWmajPNv9Pb52jmcAMMAG60DH7S2phXabfcnA54ilxiM7EslDp?=
 =?us-ascii?Q?24aXrkm+/2WRxMAuW4Z1tqWZnZkYodIXk48yOjFyGTcjLMdiysY+cyanzLPk?=
 =?us-ascii?Q?MutKGpO7I8ffPDqPz2xdpwAmtw0fkAXAR5S88T6Jd9pJ4yD9JagnWIXoRNoI?=
 =?us-ascii?Q?fL7G91mf5C1YFyH1eQw815RxEMhhGPCzComFa+DSlxc0rFrI0B89Cm4JCKvF?=
 =?us-ascii?Q?kBNauXDQ9GYWzU2lcXAHd563YZUW0tqIbqqBn6jeR1XCUWy05iPAW7tb2ZWZ?=
 =?us-ascii?Q?KDDT4NogqA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f903ddc5-41b5-45ef-e40f-08de7b70fa20
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5855.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:10:29.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34n9Azg/TrOnt8MAfyI1fvEUlHue42H7viTP9noEGTMSLaH65VpPYP064PDYjeICbW0RlkVq+yXnWx0htUjDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7572

Fix a segfault when a server advertises more refs than requested when
using the --revision argument.

In the good case the server respects
`transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the linked
list `refs` returned by `transport_get_remote_refs()` only contains a
single item, which is the ref requested with the --revision argument.
Both `remote_head` returned by `find_ref_by_name()` and
`remote_head_points_at` returned by `guess_remote_head()` are NULL. The
guard in `update_remote_refs()` skips a the affected code because
`remote_head_points_at` is NULL.

In the bad case the server ignores
`transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the linked
list `refs` returned by `transport_get_remote_refs()` contains many
items, amongst others "HEAD". `remote_head` returned by
`find_ref_by_name()` is not NULL and `remote_head_points_at` returned by
`guess_remote_head()` is not NULL but its field `peer_ref` is NULL.
Because `remote_head_points_at` is not NULL the guard in
`update_remote_refs()` does not skip the affected code and
`remote_head_points_at->peer_ref->name` is accessed, which causes a
segfault later on.

Extend the guard in `update_remote_refs()` to also skip the block of
code if `remote_head_points_at->peer_ref` is NULL.

Signed-off-by: Adrian Friedli <adrian.friedli@mt.com>
---
The segfault can be reproduced by e.g.

git clone --revision=refs/heads/main \
https://dev.azure.com/public-git/sample/_git/sample

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fba3c9c508..09219791da 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -557,7 +557,7 @@ static void update_remote_refs(const struct ref *refs,
 			write_followtags(refs, msg);
 	}
 
-	if (remote_head_points_at && !option_bare) {
+	if (remote_head_points_at && remote_head_points_at->peer_ref && !option_bare) {
 		struct strbuf head_ref = STRBUF_INIT;
 		strbuf_addstr(&head_ref, branch_top);
 		strbuf_addstr(&head_ref, "HEAD");
-- 
2.53.0.394.g500c12b044

