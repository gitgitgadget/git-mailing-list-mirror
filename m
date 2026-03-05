Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF838839C
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712397; cv=fail; b=tNM087ghFDsbHx0PWja7cXVYBs2/gkutQijqgxnaY19ORq8h0ZRovSe0VTnIKqe8yh+Mw68j9Q8ogwGJp7J9DemBXj7mEzsfwWSjtvaatwk9sR7avSE+C75REFGMdvT7xm8AEn7ZCZyGnhSgDbjg4I0FNSH9xOV8c6Opq74RKYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712397; c=relaxed/simple;
	bh=fx+q8QNVXvb7OO6Beif5O/lFL5e0jzdYJ0RijcfJcEw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=trNr1TK7PD3nIeVTxR0stftLi52TTQ7rAHLCUYtj2gjuuB/pZaeSQN0PoWB3awc5tfuSrNhrTWgMdkKDpVQcGVhFHM5wz8ztCwRyiGHLcV5wHop3RuNlUGyqHp2XzR1bf2VGSM08dFtwLB72iwOB1810SrYK2lTsLGPL9f3vb9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oCdvAwzj; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oCdvAwzj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn6/Aja9ikyfswhp+aQGGlbmP6SJuLg2p0q4Hya6FGcDmCNO/ldekpqcFdPy4PVFvTQOGrai7pHZ6UNy1CfEHw0z27lLZAHHc9UVHk4BHJ+QuB+M2+V4WF2L/4hVfJ3DlNYAL5Zv/Oh2GXHExYiPbPz9ZDVADi6tSu6NWyYGHYpU4p05IPKxScpsq3IXZ5+qu8s3AjjE6tNyZOR64GKVGZKvTm/aB3dt4DW+w8UUV0cHsfup9cHEUDi/P9W6tSqfNTAtrWwH4mVbJHIytu/9v7/OVYlcmFTKjs9PjmA8i/sjWAycaBLwz2TrlvuOPH9MHN7bSj3Z7M12CnruBILuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24okU2f0mNewvk5ks7UzVivQUlDMJ+SqgRfNhKzsyOY=;
 b=kNcrfwzAOde2+7UMZpzeHHa6HACJkicrko9ypYS3TlPUbIh/WzP54JiXllBl2JpY+aKdeVZAopUCBYtHhbSnPwDO/ZYHo3zvjjhA6fUYtVx+v4Qv/caoegkpOnSyTpd2AJ72WuC0IhN6rbqSflE0ij5SBY+Hrcov2hXUL6/1ElJC5c+Dv50fXsjaw+Xc1qKNnG6DaTpT2WYmFve7YPThM6ftYZhxotwXC7vWbmK6Bwf+ZUlUA0zJQKqWeeUKPyEKdv0rAgh5VpJF2jmTdoBM52Y5wAL4F4lg2ZzKhM8JHIDn1e7dBjVxemiyaM2iCbNSCgxQlJ44bYBiRN+x9Rie1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24okU2f0mNewvk5ks7UzVivQUlDMJ+SqgRfNhKzsyOY=;
 b=oCdvAwzjn3KwLpZdLrEjXc7pr9puG55/9zOcHgPjPvmUdqHkHI+cww4F6B/woAYMG3GbWyIubPQepJ4sPDdhXsbge+446ApRjmIETEuXC/iZSO/p+cC2rKSOy9I95TK2Ji44Yh47fYHmu7D5qnhsclDLoggq5DAmBB/rX85QoqvK5o2e1JZ8eDYvMvLCDegOPKvE0MyBhq6WoN1pDlrtwZch3+aV0CY6VHGQOh7BvFh9MUeLSkstNaWuce+NVT1mv0xN0Dr9jJNVmCX3qTzqbqYTJpuyeZLDrrdmhkT5gG0YtqBCXg4maaxpI0RVCfHHikVuWFdQ5TI/Wlgg1IMh9A==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA0PR01MB7818.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:2c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 12:06:33 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 12:06:33 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH] send-email: pass smtp hostname and port to Authen::SASL
Date: Thu,  5 Mar 2026 12:06:21 +0000
Message-ID:
 <MAUPR01MB11546AED093D8641767AACEFCB87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0095.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b8::8) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID:
 <20260305120621.20988-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|MA0PR01MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec5c14d-e54b-43f8-8447-08de7aafa46a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|23021999003|461199028|25031999004|51005399006|15080799012|8060799015|19110799012|19061999003|40105399003|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zlALoSmx+xp//6JbDdzKjpBm7DB4U6fKVt3nOPhUCvqp+VGrnNAEIOjhuWdz?=
 =?us-ascii?Q?PS6DX/RbJuXXdVWRm2L/j+RFlN1KiHr8SOV9c4lXGDEG1gtqCK+NCUjFuiY1?=
 =?us-ascii?Q?n9pLlFiAgTro6t/5vnSUYSrE+IV5UbBic4wWFtG48NvihMMoTftgIDLTXA83?=
 =?us-ascii?Q?W8MN4Lb5fdr/Nj+jNkRs8t+FtM+CP8VBRU6riLvUpHf1xSiV9FrEVrXEBEHG?=
 =?us-ascii?Q?hsfRK946N/z4PMkrFhR52rznnJJY8xeA50zlN00gllplSBqOtCkHeKaExZ/U?=
 =?us-ascii?Q?YsePtpkohUS41DIcVaA7pjiEjiXhFfykE35+MAZMVxkxzk4Kmt8nqcctEWos?=
 =?us-ascii?Q?8++TpOzMCSbQUoR/ipt8OGQuDEcVrqWP9AT25QNjvzNNvzbmmDm+GKtNpQoo?=
 =?us-ascii?Q?EPH2GcNQWOftkNfrJ3plEqzAL10oPhDlF014GeGtbwTeg71CnkSRB9C/sOHu?=
 =?us-ascii?Q?fFDJ6ju4nzwVz/L1RpHCWbFi7E32KEcwDMyqAxVzCKSwvZ37IgWJcPTKcteV?=
 =?us-ascii?Q?JCcR2xyhYbgYNPDn1Zby6UNUERXmM9EZOTUEPJHEI6LT6PFu80tKsMQL+gde?=
 =?us-ascii?Q?6cs6UYppTha9x2hi6NXpg638FztRq5Lq0xt4loLCpgu3MBSU4EE96QMBR+mW?=
 =?us-ascii?Q?xk5mtIUGKqY2muCNSFcKInnrIDRIW1QcrBfNib31usiLP/QGs2X7iF1ZGiF5?=
 =?us-ascii?Q?XE+TCM8WtBtrmb/0IMc3YEcPp3Y4qrIf8Vc/IWApTa5fUhfCHCEbEr82AS1W?=
 =?us-ascii?Q?AirnJumXWiYccwdmukPFMIGamokhPhzP5aBlYZcIc9Vn9rCZpnZjyXNT3EyD?=
 =?us-ascii?Q?leWSwKcy5hWWNd0MKsKCTcEBUb+RRb9ohwP2raRwQER0E4fqPmJW260nHezq?=
 =?us-ascii?Q?CLPxgI0hqKQKXNWVbKOonTw7DP3ccNeJsUDHO8C95QTsh+38FfQwbZ2V0Ymp?=
 =?us-ascii?Q?Ced7YvFMCAVWGNdaThViy90QzX3MuxQIGxzAw5+2U5wnZKK+p2YaAuOvwyqo?=
 =?us-ascii?Q?JyeLiMCS+/g1Hg4iYVh8I9i6oQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cyfu2MyJIbpr9vu3lcXlUgHJ+bOhA7WORw1Ml8SanMh+eLJVNfHVVZZtcrhe?=
 =?us-ascii?Q?xWc2a/U61kDo8ICA1zxtzJmRn7INvbbgegDl6/BFtrJBHHLzuc95L1jmw1X2?=
 =?us-ascii?Q?3dKh34HFlKEwy0IlWO9q6sTLVujR/1Jp2iOnOO2oBeYT7U5VNeLPtaf3Nccd?=
 =?us-ascii?Q?SietaWlIeJPX2ZzJKfxqPrDnzHUqcq3dQzyJAsSEQt7NEFT/J+29Fgvg7p5X?=
 =?us-ascii?Q?g4BPNWPNHBXxQ6rS4Vm8qhEtxDQ5bcw9OoVQvmwdLZOIXA1l72ubnk7Sd5jJ?=
 =?us-ascii?Q?gl78kDg8gZ6Yj3e//k/HIg+mu9mUZk6WSxAvnfKDpn947SoMlk9kF8+ONKFu?=
 =?us-ascii?Q?2ipGra9QMWhORsq7nLVgRXNvYGmKBC+w/yIAPFhvfAP56MWZjWpoM4vxf4cj?=
 =?us-ascii?Q?KqzoXPv3+Ep5OB2skcwTB9nmtBwcInPPLKbTCzDLHdFjMDDIo8kdWA8vzA6O?=
 =?us-ascii?Q?yA9GQM+4JMMjzZFGSN155NuPpd9uCUuhHDuX+QyI1auF9x0QKBmlfAM7/Dd+?=
 =?us-ascii?Q?RD6PzaalS9m2VWg89aAA+hy0YSo7VVNzfpPsYYBi12nbSFMHBZjsC5gXCYVA?=
 =?us-ascii?Q?d2Cp5A3k+hluKTwe8HtAVvOSPbxC6+g9KuFJxmH0gOqJpACKZNW2vyBWX8nt?=
 =?us-ascii?Q?XbbDemtbWpPEVI9d/UcQtxZ61iE0Q0Q7bzp5XC70weARGqnhn1d/iGPKewAM?=
 =?us-ascii?Q?J2yxnKXWEg/5HGxulP7yKhfPIbAAGIN7IK5PIvVP9rXqAUzeqrMsfHhwNhOr?=
 =?us-ascii?Q?Wbl+wwFkYpzjMP88Pxb4UEdCVuuZJYsST+ELPsvYc0Zc4urNN+I/9Itnzzna?=
 =?us-ascii?Q?shlzmdZjRZ1trJWVhilvkopEVcN+cpy+zv2Om8bASwuUIgK8jfC8raZBTzya?=
 =?us-ascii?Q?QD9DQWJByRaKf3zKCz8wWWvWeNTCqjZHChGYCyhnBs4rsBoC8oMBldUGo7pO?=
 =?us-ascii?Q?FjvNyp3jfkc/rpdk1NWrZhTNHJlJImga/JPZ9vx1U8CDXzqhJdxm4m5d/Dym?=
 =?us-ascii?Q?+JOh4GnxcZfckyUwQBkSq5IUBZgjJHckeZaAu0lPq54TrQP3d3O2vTA//TqN?=
 =?us-ascii?Q?H9P0lDTSivuIF1j8VQM5EXEALURmFu/EZ315e9Iwb6lf8J5aBwJyQs6O1qvZ?=
 =?us-ascii?Q?doZWz734+MsLSqxNBwt+hyRgtOvnCPZm0aPDi9meg5U4AOYIXYun+NN75W0j?=
 =?us-ascii?Q?GA8kS/1Vw11tgarqnNV+f/Mpw8+RmYLgr5nzC4qAjuLtt6n3k6+VfNO9VBbw?=
 =?us-ascii?Q?E8t/ICnHvO2Eyl931OPW7Pmp/qYMDPjS9afTTA/UdWN5dQojVquuQPqpZEQf?=
 =?us-ascii?Q?+L5P/I0gxbUHG+nD2H3CV1O7lCiB3li5QVar4XYPHhgK2m2Y+Ixlt97wA4AV?=
 =?us-ascii?Q?2Op2E5Dz18vdOOnx9FO8jFj3yJvq?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec5c14d-e54b-43f8-8447-08de7aafa46a
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:06:33.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7818

Starting from version 2.2000, Authen::SASL supports passing the SMTP
server hostname and port to the OAUTHBEARER string passed via SMTP AUTH.
Add support for the same in git-send-email.

Link: https://metacpan.org/pod/Authen::SASL::Perl::OAUTHBEARER

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index eed5420882..0ac4d634e8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1474,6 +1474,8 @@ sub smtp_auth_maybe {
 						user     => $cred->{'username'},
 						pass     => $cred->{'password'},
 						authname => $cred->{'username'},
+						host     => $smtp_server,
+						(defined $smtp_server_port ? (port => $smtp_server_port) : ()),
 					}
 				);
 				$result = $smtp->auth($sasl);
-- 
2.52.0

