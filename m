Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012008.outbound.protection.outlook.com [52.103.23.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025223EF658
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106719; cv=fail; b=HU+TE2XWnCs3musUzO+oYks1vpMtKNdBVwDtNMcDgsFF5zpPfxLWzNuJOnWmTS4iaHJTDppkZ+n0am/Pf2ffNWNk796Ov3uAc6jof94N8yNgMAfDqdTvf0L7Iw8t97Tq2b6gIbmBW2TnjEFq++qwY0yct0LDEtXeXNNqvsEcl7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106719; c=relaxed/simple;
	bh=0kJHC5s73PZd/bmo0H+zfmN58KBj5jAdJCOEbRbZBq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sV/NbAzrfPBYLZHjxZtIvC2h59r3LgR5OVGSvRsRkxlnjWqv2NRZkKx5T37yOAmsJJkLBPg5EvCgnUw11IgYWEXkEhZFx/v+BW66Z+b+NnHuAMRJ/u3wntoGHFlUi3Tr9rns4uk3jtPJVco7kUfC8HwVmJFPJDz+cqYydj1MQlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=shrqtBr7; arc=fail smtp.client-ip=52.103.23.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="shrqtBr7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjxxDaKSRkJbBwhl7s4PEQLRVetLO0Pt8APKZS3cBZtmV58XJn7xKs9R6bLH0aCKYlx/iF4e2fnJuWAAEK3O8QZ187j/ZI/5BUOhoaoUSvzIcoSeAUFxMI1oScSfhPmT9dLDeUK0A8gxkgt4h4Yi8dEX02hoXlaT/MYAUeuWq+r6/slDIEzw4fT+Omio4C5zWPQJFWNYC5Nuo9tx0HeJN6RP6wgFmDrmgEKHIxdaOWqgbc2Ah2geZcQ749+WfOlxz3ZjUBctskZhHP4nqpqLHm28wX80zx1596Ary7r13dbtnhCmQGvjwtDFFxXBA5297sxGU2C8L5DGHqv+YII6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGXV49vElgXK9oZcGPp1b++LP9St0A6/Oe5xyYb20YQ=;
 b=ZOGD6TUPS2gY2snMQYGWjfxb4/Qj2qrFFGN8z1cE+JEu9tY1rnjlhC+/9KqUnu5uxswB1/TOPuIk3r2EMFayfy2+9s/lanRfkywKCa2d7rMk2iVuTtNrv5S69uCFV3XBTSyTZ4UTkNpGmtFoEAFZd011GFQ1lCvzhEo+N5i3t5NFvso2XiSAKzq4e1iOsowalZk0a3sobmAPaTKtAgXmo/vWEEBld5w4ApuUEftA+/3iH1dvyCXl+vwgF95KPEbVe5nz1245uJLHEmHqr3FjSbeqpT5np9FJsVgtZUrfA6vhSrise2SiTf6OEfOiQOmYna83QaMk+gaqlpO5W1dMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGXV49vElgXK9oZcGPp1b++LP9St0A6/Oe5xyYb20YQ=;
 b=shrqtBr7okysE3TFd7yHIi5rx5BuF/I2IPDhSIp1pUJ5g5KC5ceY9DlQdAYs2EIwUNc4wkZ7xCIu1jPBSYz1w4+DUgvSyFAlsjJnP1Wd10ru31TePKUSoWy+q7JOjhduOuN8Bjk3cOW042AsIZcMYGALYcPOHV9AWSZRdoasxbG9jKvtKCXHvxskDm0ZnM2DipDatsW+vk32pvN0qKEMkCzfRY7kghdXSoclaPLMNbKu4mGetZ6HjyjeLhCd6wXU9Qam6quCnp5DDQTO1V25SzgA0Uk9q+ACxMA7IJE1iSwIucEV8f5DeNjgNGoLW3nXVQHrh/bXKe+D5ixhAuePuQ==
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9) by BN0PR10MB5160.namprd10.prod.outlook.com
 (2603:10b6:408:115::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 09:11:52 +0000
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f]) by SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f%6]) with mapi id 15.21.0181.017; Wed, 15 Jul 2026
 09:11:52 +0000
From: Travor Liu <travor_lzh@outlook.com
To: git@vger.kernel.org
Cc: Travor Liu <travor_lzh@outlook.com>
Subject: [PATCH 2/2] t9502: test gitweb index hash formatting with modes
Date: Wed, 15 Jul 2026 17:11:30 +0800
Message-ID:
 <SA1PR10MB9977159B51766C2D9FFE98FD37F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
References: <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0080.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::16) To SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9)
X-Microsoft-Original-Message-ID:
 <20260715091130.83934-3-travor_lzh@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB997715:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4935c4-9185-417a-bff8-08dee2511bbe
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRxvIF0HYi2KlobIe7Jcq3pgKOfUYZi5hlZilrXcIiD1sPsFrd4ue98GXuPzLxkDhtDB5KWXRZOZ2tai1+LDz2ou2ZMVf1QQtcISIl47NwL19bsUC4UHBlZUET00PRueyCZ+QgTnwcgbd8HSg7rH2gTBt3g3ISHuA18wnAKE1RjW53lXIs6JwlkRy79J4TKOiQBMbyAt+vzz8D+lwTKh6U5OJgSzlrYUjEKCeGVTxvPPK/XePqhc7ZwSzaJZwZqtG9/0rq3r2lXulg2aDGzPAJ6DNbHZHBLXH9YQbptw8HV2i7Gks4rWH89ZWZsFAOmm772diKYaxaziKzcur+KnIH+v9cViizZ9rrqv7lWPYEeBu6oZqy1DxcHSvivmpfpOE0Io8ckcp0VVIOV6+k+FRH6yArIkrKhfta4Pkv3fHoxIDXtBmwkvtN3RkTIcumSlzCTMNUVTEiObXdJdDDBh3WFbo924UR0q5Vvy2Yimtsecg6z1oTBrggjOEqyz/pQAvwORyoT38YHhQ2GhqxPqF9vfakRGJqZFzh+1ExjNvlDikw/+cfC2CjgL7NJKQzb7xidxzEe9TwWhmZOc4SF61+43uK6SZi21Ekdlx91ALYAJ1C3nr3DOhyJnZ25f+TSxPctsWLFfURv6j3b+NbwU0yNBYiFc/lbW9jpDPlQ8pQ6TBeMZsxm7pafGdYQqTwuty+Zg3kAIUG/ZlelDq2Y9+1nWjfeoShOYI3l/yrO1vLMOs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|25010399006|24021099003|25031999004|23021999003|5072599009|51005399006|8060799015|19110799012|15080799012|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJLe3FwQfZpcVPvyfWCzxAEnDf42VFXoDQSnEzuVxTSbyH9d2mSM9LYSPyXv?=
 =?us-ascii?Q?yiQfeN0W4tCL+ICpJVsiJyRksDfbBJrKNFT7bZQKWbkvEcZXk4D6OVQ6IlTA?=
 =?us-ascii?Q?9R7uxsB3EkkJgu+P8MAAoFWxyOrohJUircmxu4zCtZOzPb2RrA12KXuSFrsf?=
 =?us-ascii?Q?o3FCIZ7mX7x4IrDYSlKOWHUTt2y29QvDgi0gQZ3q1ZVFMp2MWmHs7hRCj6B+?=
 =?us-ascii?Q?HEoX6m5cd7UKHsYUGihiJVwn5D9OcCggmH7SJk6hofRVIdFMTnbXOXzwGaWO?=
 =?us-ascii?Q?IlfvKpDL01aG0QBodp29ZLGll4F01LzNs8Y9aNDOucgB3TP2QjzBshNhCeBm?=
 =?us-ascii?Q?LBa1ahuU9ZyY9A+0XOBYI80MhzT/Pw9kpQy0iGaKFQbHppN3cHqpEaXJ29SN?=
 =?us-ascii?Q?ZqIIATJs8HVR6hvz0qgLakqtrs6RjUeUIOmocnhdxGOGfVbZWIFW8bvAmNgU?=
 =?us-ascii?Q?Wy/ouSVCNz+HXBZQNrIJPlZcrQkFsuUWVVcT/CmIDp7xt6ZtocfgwomFcg5R?=
 =?us-ascii?Q?EcopArr9PbGXdSh4LPxiRNYCi8xSndjXaL6BoMB6HkeDyVPbINZ4ufs7npEI?=
 =?us-ascii?Q?+X7yO1oWqwJKvtPu4s94UW7HKfOUcAXeO4oF/lSF8fpjS9grFP/9jexH1pgb?=
 =?us-ascii?Q?/ZS3Ud3y2RTP01x2WQPlt4vpzmcMXExB72++zku/bZLIIXNmw5vD5WSCJEi6?=
 =?us-ascii?Q?Oq3KcsNI+naSAVLhs0DOEGQ8WCX0iZXsFaPesmrIeVzTaAa5bFeK7DBhfowM?=
 =?us-ascii?Q?ATUXTJ8smBu/QSqm13ens+OR16l+hxcXrdaAp32vpAmxmoD5Y8pS8oHmfyCd?=
 =?us-ascii?Q?lKT5WklqRXL/TVN+JNkZLow8rPMks5udBEC/XNzcCbuefSUPUWe1RBAys+u7?=
 =?us-ascii?Q?8cfmKKyM9D4HxKccAYTL+P93AWQGLph+M41egYHaePK/QZDjRamr/toYNsDE?=
 =?us-ascii?Q?BhE6+LZ6ef+EvXFIZZqbkhrj+eQT/bdq6PXH2gAe6gPxnmHP2PRIJFxT99jl?=
 =?us-ascii?Q?mvMC?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0qY13DEyLXkAhH+F2n8yG/WA1v0PA1C26tbgPU/004ORovjWpxKFdSFDKU9P?=
 =?us-ascii?Q?bDUKF5UlpOkmlfWr2YdPnYUmeCgJSB5RuPtOu0lxfwsifa6UoTzDG15nDfT0?=
 =?us-ascii?Q?PDfoE5TQnTom4XVkbbwkm7V4BuUisnCYugoNXfOMELdCZJS3zSHbfer0EYtA?=
 =?us-ascii?Q?oy5ts7PyCleC/MW22/OQg5SodH4zJRuLymjxC2GDtQsKnVy3PJG9aPXlNmrx?=
 =?us-ascii?Q?Ln6Dfjn73V5rvuapAKT0L72v99R+7H93D+qiDRlWQ29F2A72CZLtErsfeOsU?=
 =?us-ascii?Q?RL/gTUck5OuIfEzjQW8GzqaaVLWrghnBaulv0klVBE3NmPJs/A/Sqj2ZBfx8?=
 =?us-ascii?Q?B76Rc51495V+XEZ2YqZrMgKucJocX6UyorSrsBBR1Ihnesb3iOScuK8VX428?=
 =?us-ascii?Q?k0/L6i4rrxggEQmkbpbM3CwgCwbR7El9sNoLlix6kUfHk8PMq5HymXYn/Tbw?=
 =?us-ascii?Q?TSwsub+2Md7fWQH0U4vRc+a0kvjH0bfIA0DweoGPwiQbS/JOWZtPvfUBDUbl?=
 =?us-ascii?Q?UXcuTw1Ko29pEg+xTB3kRQ44lsCAYgxwkpwyAGsmv/IoW31esXkeMPvN02Tz?=
 =?us-ascii?Q?CadYB7ZNEKFPH4d/eKcEnXUAD8zdhEDMkbCNMAn5YX9pvTdspkglFkalP/pQ?=
 =?us-ascii?Q?im5Py0qiUmv7K9CQxGco3PmVsogWQgD0u5wykda/0OrruPo234BhYZ1UsjXu?=
 =?us-ascii?Q?0ZBKaqOw6+fnmRz9/7qCKzblq5Xlj25ozZT47iuXID/dpZO7kgjesncDU4DD?=
 =?us-ascii?Q?oMBmVPKk+gK0IjB5MfmtnTv3zGz2DafJ5dTj1wXz3l0zBYUiXk+XL3nwVvwD?=
 =?us-ascii?Q?zhBx3bYkp+LVG2oTSt2ZbzpUo/+uP/w4ui3twBnAFaCzqPZT2JDFRsF6TdjC?=
 =?us-ascii?Q?3OXDqzFlupBDj+QSsOsJ9K6eJBV9bZ0hoV2jlUHCJtSEJsFeKGzv3s3CXPfX?=
 =?us-ascii?Q?XCnTnG6B/a1pBq/NMueD3ihTgNOUlZBkCKCZo1NNLsEi5UXHm0mhQ8JskcRj?=
 =?us-ascii?Q?6838ZGhMiaW8WmTCBZNAqNwD7PFq9Cy2MOo799ZEM00Z9HYpu1/UioSYY4k7?=
 =?us-ascii?Q?BFQ1S0H+WWF4iJ/13yAMIvUA0Y/9QDyHYhY4AFQxZdPyRv8SSBHlSD0in+gX?=
 =?us-ascii?Q?kWxMw6UVWnkatry+8CmGc5uLC54hOZMOqBVOOFuSj5HNxHIMjLnjjjKAIsen?=
 =?us-ascii?Q?axIQ5w7joPSFAbiVBjt7FlFhjX38KiH72JPAomVUtucXW5AX3k+bSdUs9Zck?=
 =?us-ascii?Q?lFCfquROi4j1/tP/s2BtKMXMvUJzIm+ExwobnphaE5di0XwrLVZAKTbrfPus?=
 =?us-ascii?Q?65u+tA3wol+47Ntf8vJ+XrxRTp1OXdbtPq6gYCAv9+PZ1Wib4a6QIJPAyJrA?=
 =?us-ascii?Q?9nhUbWOAoVAkUzaNS448G8PZ5eRd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4935c4-9185-417a-bff8-08dee2511bbe
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB997715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:11:52.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160

From: Travor Liu <travor_lzh@outlook.com>

gitweb should shorten and link the object IDs in commitdiff index lines
even when Git includes the trailing file mode:

    index <old>..<new> 100644

Add coverage for that common form by rendering a commitdiff for a
regular file modification.  Check that the visible index line contains
linked short blob IDs followed by the mode and file-type annotation,
and that the full unlinked form is not emitted.

Signed-off-by: Travor Liu <travor_lzh@outlook.com>
---
 t/t9502-gitweb-standalone-parse-output.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 81d5625..7f37e26 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -115,6 +115,20 @@ test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 '
 test_debug 'cat gitweb.headers'
 
+test_expect_success 'commitdiff: index line shortens hashes with mode' '
+	old_blob=$(git rev-parse HEAD:foo) &&
+	old_short=$(git rev-parse --short=7 HEAD:foo) &&
+	echo changed >foo &&
+	git commit -am "change foo" &&
+	new_blob=$(git rev-parse HEAD:foo) &&
+	new_short=$(git rev-parse --short=7 HEAD:foo) &&
+	gitweb_run "p=.git;a=commitdiff;h=HEAD" &&
+	grep ">${old_short}</a>\\.\\.<a [^>]*>${new_short}</a> 100644" \
+		gitweb.body >index_line &&
+	grep "<span class=\"info\"> (file)</span>" index_line &&
+	! grep "index ${old_blob}\\.\\.${new_blob} 100644" gitweb.body
+'
+
 # ----------------------------------------------------------------------
 # forks of projects
 
-- 
2.52.0

