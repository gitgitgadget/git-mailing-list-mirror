Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE3284883
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817829; cv=fail; b=go2xVa13zJ2pfSJKZRTuMZk01lK9eawaU094qtgfMiO2oQMYPZAXuQ+7Tbu8J5+7aapUdDPYtqgYEOH6M4T1zos1GBSTNAh7NxbRhRTtpe9EGC4SqIn0x601XDt4VKu+KBNr0xkeU0+BxwDxM9a+h1fvbXuZ8lAdKjwxvpuJnDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817829; c=relaxed/simple;
	bh=y4owwUkMhbjAKZSMONAXyDcPZNeVM93XAjrNCbhpk5k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VKd+D7VxQI5dpXhVEGcNwT3NSa/ep0U5fPXoq59T5p/y92XDLc0UWu4ojXRkMpUL/lMKzg6mtEqeLAajyBD36imUJpBuYwcV73IO/Im3OY/Fn4G3SSprMq1iBfn8wYtsg138LOwMFOSWHOuFA8cgcalrCW3pNDq9AKcXyJLEJek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=Bk47Tmfx; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="Bk47Tmfx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBgFAMGwU1OwnclBDQMOY1g9qJDsp8dpU2GQBhB/uBgO7vYoykNxQ+0/HHlyFTJMJCv7DkR5DYc/gZzT6mMdUxAUizX4fK9iZGxw7y3yuCEqgzrVuEiVpGOuOm5m4hvNhBxjHrSJ8+af1qslrPdlvERsVqXbFMclJLlPSm8XqWUbFb+C+Uw11/4fiJs6/DDBDHXOu7j6CAd15HsZJIAAJW1WUnqeRNAaTxrKAsqDyTRETWxUilq7L7e8kXfRvifZZpLf2bMb97EdjbhpeVRwbbTl1sGO7S4qRgqgkPuS7Fy40zqbqZtXo2w7ExwK8Ye3H0yx+o4q2uGyK7qxyDU6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o20fXSy17hOFz6g4iqg262scirMOFNnKsvqDL5WuoI8=;
 b=DkeM7KPBx9RDke6SzQVUg16St1/XXZLpJUVeSP7fpzcrdBrRCRLanie+c039Yr7GvipQdJXhQFtIliwPiDl+Z4JC8TP//7L1uLazQriS2F600N34qi3r3+pu6zo9USOE9cJXKYFtuPVP1br5ZJeGKrD0vLgF1YnXB+GOguywS05RNa9SwhjA4aXkSkWB5Ey/Fk5EMecGc043ffQciEzvCWSzp6Hpa2PeGJ0TquYMrn8qZJtRsfM5QCCzDWEZFQwtgc9LU2mmC3JB31OIva2hbyCsuc4bAW0Xi8wtFWqsbWj8F965QuUUDVOTbArY2GW/SG7hNEHIjueQtuX3q5cE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o20fXSy17hOFz6g4iqg262scirMOFNnKsvqDL5WuoI8=;
 b=Bk47TmfxeiWRFb1jB7gOZ/MZozorp4jUfnaggfbO5psm3fA/zvmvpZOm4Hn7KDydWjQZJBbaQnFOUzWvsH0+sDy09RQb2sfHO3TC4PxD0QfCK6Xm1pREMcyOKHoolvsGxQE7SGo7hM9kmIIey6Za5VQseq9gEUYp3F2tJ2ZfdoDEjuAU8M3CWRPcG4YduPOWF44Yz1FNxa/PHf9i5v3pn5UW5y07StBSmfVbTE6236ZK8EQ0NmIeOk1UqxIEtFKxHaPvVlXAJNsz4p5ayzy5QS3vdMxswwBWOBjEs3zefvuQY5THYqMUprLRuVhmFg594t4Mc4yf3Cqhs177iN9PhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU0PR03MB10187.eurprd03.prod.outlook.com (2603:10a6:10:479::19)
 by PAXPR03MB7888.eurprd03.prod.outlook.com (2603:10a6:102:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 14:43:42 +0000
Received: from DU0PR03MB10187.eurprd03.prod.outlook.com
 ([fe80::764a:3e10:9b21:5671]) by DU0PR03MB10187.eurprd03.prod.outlook.com
 ([fe80::764a:3e10:9b21:5671%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 14:43:42 +0000
From: Adrian Friedli <adrian.friedli@mt.com>
To: git@vger.kernel.org
Cc: Adrian Friedli <adrian.friedli@mt.com>
Subject: [PATCH resend] builtin/clone: fix segfault when using --revision on some servers
Date: Thu, 23 Jul 2026 16:43:18 +0200
Message-ID: <20260723144318.69007-1-adrian.friedli@mt.com>
X-Mailer: git-send-email 2.55.0.379.g54b6532b97
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077B6.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::432) To DU0PR03MB10187.eurprd03.prod.outlook.com
 (2603:10a6:10:479::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR03MB10187:EE_|PAXPR03MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ebbe30-a2c3-4380-cd1a-08dee8c8ca6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|376014|1800799024|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dH/Wn5uQl08VpknkCYgAm4ukhSy0vETdfRvrbVypqzcCXKsEyrpvLRii0V88jS9V2aJk/szL02aNnERVn7ZVVX6JoRjfUChj+vf8hUKyh2rQ/0LZAJXFb+Xp0zNSZtbBtqWYVVWJ2eWEjJBZQkwt8F8u8KScFAGN2i8qEJAvZGgCANtIpcVK1ajDrJPVN0iXeH3Iug62yTujVgijtS0Wf7/LWTeaI8ltUJm2qzmyvmIlbeZvPC8saJ335la6uHcTYyF+T0mxsLS58hHUOgPjsuwKPOjcEsGfkr9+P7PQ0R8WD7ySw9ieHIM+eacr6wR5SbAv2QidVV+57tIsr0O2QbRJMjxX4x95ATtc6ke2qkn1a+sGf+aFNIz49Q2627gkQwuA6V829nVNQAHoVQMI2DsNjjd/Ofmuz8r2I2cTGxrvX4IaEXRTVCb5EfeRoNmK++wcERN8c/pHb8/B4j89/7QEADTQJAG7/P+BpZ4vb7nRLKOXp03Pf2OvV5ZqTM196nXtWDZlPNKTLrQ7SwbTwOv5mxMqurRp4ND5gFLWE/h+/ES7nE0XX1Ti4pzSnxvHn8mJ89/8StfvQ/09315yLq1jctkGiKp3Rs8Ri6BvGAu0R0NeAhwi+Wal4euXUm3Ehet4WsKy8oZg3mv2TatSXyw8CzIw2J//7SKTu7jdRwA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR03MB10187.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6JMwDxhBDnBq4Tl+KlQ50UFjlw3NbR+BkmgWYpRyuJ1pfR+Prh/ZF+KW+B/j?=
 =?us-ascii?Q?MF26OoKksKczEhzdoloM80ZAWgrHpXB9tbx391FgNHEWJwX+pEUgKCWwbBfN?=
 =?us-ascii?Q?LV/BEYNPl+gm4pG1F5oU6/Z+9OWw/+u5m9YFTseZjpJOyMS/YR9kH499+lWM?=
 =?us-ascii?Q?gOJMXyQwNB1kYFBr2lJRXh6c3Y1KLk39yfnblkatAmZCgqwMZMYymUS6ThQC?=
 =?us-ascii?Q?0l1QVX3LaMIIk1KpFpCXsGQw0QRbhy4uUqDZzBdN9h9IkVILAW/uH4leXm5z?=
 =?us-ascii?Q?zDNbzXbC1DsfdfXs5e06sRJwd3L8AbwiLKn24xzHgAI34OJGJs9ChFJZKQaH?=
 =?us-ascii?Q?4Ey3XOAKyf3P+D3xQtfVfWTGpqw6+aEW1V1QIT9IEJuGeDi2zymHBgT++E5O?=
 =?us-ascii?Q?7K+n93ykPg06YJriXZMyziaPTysA9WEY083kxZUEbwBYa0Edj2c6D62YE++t?=
 =?us-ascii?Q?5TBrrJZYxb0X8MzWEzozV3u5IlEuT6mER1TKIC4QP3Xn7tvG0L5TKC6Xm7xd?=
 =?us-ascii?Q?7s7VqVoYFE6wewtP57pzSF40g5Vym3CAs9E+uTjcTBaWVIeHZ2+3kUVjonta?=
 =?us-ascii?Q?OcEJ+6/pENmAitw9boTM3i3JinSZqe9wgxvYTv996aqW7a2apBuqieiJKR/H?=
 =?us-ascii?Q?EUKXJDQN+8QFI5+IH8t+DjFGSZBJnmGA86KSCJlBdruh/CnjrnNe7VP09dc4?=
 =?us-ascii?Q?i1I8lbUK9Vtii4IezAG4elBXl7Ig+ayCSFjUCaFNtnCxSUqiqkUEBHZkmtqV?=
 =?us-ascii?Q?+KE0HYraE5i7bPJvVNLk0Ll7zOsGnhXWJM+M8umwxTVcYUPRJ3aZ6S/u1R7u?=
 =?us-ascii?Q?IduQDya+pQt0su9khvw7bBKtCG+1Jps5PaUczk4JkzqbTdnAZjI99s+PjVZT?=
 =?us-ascii?Q?xvS+QxTYhjjhDCiPl4ZUHookxef9aM0FQLVVP6wDczmkrzXgn7EX8wBGdbd4?=
 =?us-ascii?Q?CNcbEJBH642WgQexmjfPTPKLEMjZxOxAm9YNfALDF/3CmNDsbZqD2kMQP1XJ?=
 =?us-ascii?Q?8h/PhWWL4svIrtN3GYFMzzq46OwOcfg5OfqNdhaLW6Q3btrSynh8gXnAHU5F?=
 =?us-ascii?Q?87PtkPcDFi6T1Jd2knaYSTqY1kQ+raJL8U5zQ7EUD5bZYn8T1U8APM6F9q3J?=
 =?us-ascii?Q?QkEOXB7oAuX/sf3BQTHqGeFh5oGs0r9qfZKvDPkXfF6t2Cxs/zMnWsxQFkQU?=
 =?us-ascii?Q?R0bcozHlQxE+DTx0kxr0wDanlsKNFW15MTLOZsIrV24O6KMswIpawHsaOiBV?=
 =?us-ascii?Q?ZAvlwwpS3jq+cIhihjx2DjVfuNsZTYRqgddCsNvqyVQ048Ep07VlovKnmHa7?=
 =?us-ascii?Q?vLVMuJA7jA2z78Nd4KTQGgjv1eZhU42W1wcxi4JiOzc/Lph3P66hYhdOv5P8?=
 =?us-ascii?Q?xUb7KjYQa5MgAe/tvM6vPyI1J1b9x0X5p3SXaiK4Ik2dyLNI3+780jBmbDK5?=
 =?us-ascii?Q?m3PUyIYayO7Kp+xMK4EJgHA1kQdGbMp1UOhz5/4MoDn1urGxn9R8fm86pR97?=
 =?us-ascii?Q?m2nXgwcbWJ6EMeNNolBPv6sQduXALR1sIwBmzJuPdCMKhI146rwqKhBYWUDt?=
 =?us-ascii?Q?JZcGDM6FWCGuY01SleWKFr9WMTUfifpUmLwb2+tMApYCszsByXNoQVvho5tR?=
 =?us-ascii?Q?Em7OPyww8NjBBnz+KjTav+q0hnmPFvRr3sCngrdEMd3NRiDbNaxgWMNNSGJW?=
 =?us-ascii?Q?A75AOCjRluh9ZSxeS9HmxYWG5ZNJe0WhRJ48x/Mip8B0fcHnetWtuM1N5cZ5?=
 =?us-ascii?Q?zLHuYWgm+g=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ebbe30-a2c3-4380-cd1a-08dee8c8ca6a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR03MB10187.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:43:42.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9feBHdIMLqYUf7nyJZh7z5m/ZjkMqvmhA5TOFgu+o/3J+rjV1QCFHvRH2uhIqHZ4CVXfxrgu/RuMeis4/SIQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7888

Fix a segfault when a server advertises more refs than requested when
using the --revision argument.

Signed-off-by: Adrian Friedli <adrian.friedli@mt.com>
---
The segfault can be reproduced by e.g.

git clone --revision=refs/heads/main \
https://dev.azure.com/public-git/sample/_git/sample

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

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9d08cd8722..bd0c6f5d56 100644
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
2.55.0.379.g54b6532b97

