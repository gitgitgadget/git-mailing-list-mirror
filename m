Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C52417DE
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984439; cv=fail; b=h1lCjNOiRu2OxYZc45FiLy1xTyk2Vo3not0FmULGBV2TYfvGh7KQ6V/xXhA+dCh4INjguGDxrXXAQu2IrW6j65HaLuHqUXz0/DC+yLIsMlliz6DIWBjoZGPPyJNBjGeBuyRkHUIlqIypnsLUXOZ546LyN/jQaw8D8rmlwgFK2jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984439; c=relaxed/simple;
	bh=gs2YeH1IS6N8Ym9V+0rHD4Pi0zQaOC/pIUo5YxnmslM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmM71ITUABEcdwAv0rDJCyWVaK/ATBJNZ34N2ooI5d36JHkZQLq1f0FDMrSFNSqJeSNTM0c5wuGH/Yl1Dq1VlZ7soi2Nt1gz9cIMWuKnIqOSFe/LAjxmEs1ivION50fXqZr/vXb+nV5eoQEcWOheMz1l5z/qOyiCzU4tq0uaP7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x+0Voi90; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x+0Voi90"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ8UoV8XdtJl9llBXLYaHL/nLWk2vdqdvFOtCxCRf/z3Vb92MXgGJwJAZz5gLcrChymffLEudP+Q0LEh6i9cVM3fPcNRO/Td+qaC3Sud8PaVuPzpnkKTzAaQtneZbAIzO/x51uNH4PJaIckVgWOc5nzWudwbH92F/OUw8ukGJMjA8dDVodmHH51YfY8gtoxF4C7gCjofoz2zMh4msy8fKkZIpaZkuthplg4g64DlZPDPPZUVZ+WzEOm63y8c5H080o0zK4DWK0O5cQsNAd8Gj1yzACDhDJXpNwzjiBo1BaKhM8lecCJeurJyunLs4LvInNUdK6fWtaiQMz0zkbNeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gffoHaV+EHZB5cL7+EtRSabCtt+tDdc68TChCFL6cEQ=;
 b=D6mplibWdby4T99mwGSesOvtcK/swxcUDDKeiwLxMI9GLB+2vVSyD7S8K7TlYrE8oL9rzdWPpfTBtDh5959Mcs6Qf8ya1wwYuM+g7oqAJvojmgoIVYh1sdUydKg4eS6ZjrdzBXGq1HWWfVXHBK2r5X8Qx/IpPesLYBquPFq2gJbrVQpjEeEahZEKVHDtISJQd+cCkw6GxlT9iiySHf6Is1EXNLRkKwH1Yr5nuSieLB00wLB+eXsQtp2kg//5QxFp5vlmq9YkTHQSCsj99bVt0Rka8YcXhhgPXfeFxG+thVwZrdkEy0yxYXEZSoM8+oXSieuivu89bu1fWSnfXyR0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=web.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gffoHaV+EHZB5cL7+EtRSabCtt+tDdc68TChCFL6cEQ=;
 b=x+0Voi908yaDDUKusuSc5lQC7AjANRC8T8DbhP2ON8Hu/mTSBOoTKtDLQRkc/bP+8TrkiGDu5P2RWXsoIzZvH8MSqJr32h01XCuQwSMurDzhRsCInzX+GYsPT965OdltHCjrTi3e87dJ1cPzxAjyZnQnV3Hua2Ikk5BQ7acn7ac=
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 22:47:12 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::57) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 22:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Thu, 23 Apr 2026 22:47:12 +0000
Received: from msdn-mgrossfe-2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 17:47:11 -0500
From: Michael Grossfeld <Michael.Grossfeld@amd.com>
To: <l.s.r@web.de>
CC: <Michael.Grossfeld@amd.com>, <git@vger.kernel.org>, <jonatan@jontes.page>
Subject: Re: Bug: Hierarchical Aliases no longer work in 2.54.0
Date: Thu, 23 Apr 2026 18:46:53 -0400
Message-ID: <20260423224653.893-1-Michael.Grossfeld@amd.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <ea07acab-313d-435d-8328-e601fee980c3@web.de>
References: <ea07acab-313d-435d-8328-e601fee980c3@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b11b34-1e80-4cdf-10ad-08dea18a4264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	80mf64ne2VFCX6en+2hH87Lko04Hx3ACrbeH03a9aEntRbFT5/czXHbbbWcHeYoZOgrGvh72AalNKx/VkEVPvXc/vLFaD9VtqzDZ17NYBYhCjEFu81UJrjoYFXjELypIlZy6JmWoHpWyVy1lvw5SVRcd6wBX5Lzm+FKmqvdNnA1+UBitBjrB9Z7ORpFPbs6VsN+cKE/Pq7mdVbZoH8EuheDSAu6mFmXyP77Zos+6PQury3Yv+VSCK+qf+z+Wo1RgzAzPtUfPdxoIE09Bw5rVZ1VJN5s9vXXVtinC/P7wx+K95rtZdwEQEdbSuiM/aABubBfujOdc/P/2Zgp1bHBgCpQybQxgq5tAw5M8jQ6pwYpYQyk0LMFjIWQ4S1hYRywi5T+2nYs/JGb89uAFE+YOJxKvUKZaiXxIvmcHUaTOITH3TQNQF/AgFBqCNpp6lpQbZH3u7c0Nqsq7LU5C46XpFfWMov0ESrBIB5L9wKuesRvso2QzeC4ifHPTAumUpRaYZIzpuvvVHm8XRwsxmITb25aQIt2SxXo67Bc4b50qaZm2o/6Uck2brl69L+f0Xb37v3ovitC7sMiRC5/6zT5wdPlm++1lDjISFDo7DcH6mHfQD9H/1Iw0N8Nk4tdYFty3aXPhnZBvNKvP682XN3OiTLJiYZi5QUdIPklvqObGHZl1t3bBoVoIKR+D+UBX78KGNRup6X6EZtHDhSYUzrdWq9uUkshFN0qPUV4hyLViRwI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eRBil2dMhbz+Dh66ZYdEUshrUkfmKNT+YebHCiATTDQp4MRPAiQ/dNsTnHgiEyrePxyRnaYEsCKN6GyrcdSALgNhKJr7L23pvOIBST5elQ+AnDQBPPnl9ZCbAHzl5yl0nEnspEsZLTPqQF05z5YMWDT3LbSZ5j9U3rsVjfJVZ0tWwt5cIJ5K3FGFFF35dZDR38nB6DEjmBnPiIY8OXi5DxOtQbey33yLD4lNPWrSv/YvLofR/Xec9gIjR0DGj6dOTfOx55QAKZqVfFBGoExvMrlwY4NfJHxcmwZc1hMl0J9SAByLJDpji+d32v1piut3cKKzMte4vBq+e3vs3KxuDikVZWr+QvwBEqwmxBmoTITQOniAEQVqSTaSFRBrVcA226iPDOD3n9LugInvUHKagXzH8tS+GUqknclOZYt927uaS6eeqKFqG7kskociw+ss
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 22:47:12.4200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b11b34-1e80-4cdf-10ad-08dea18a4264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

> Broken by ac1f12a9de4 (alias: support non-alphanumeric names via
> subsection syntax, 2026-02-18).

> Alias sections were not documented before.  How did you discover them?

Sheer dumb luck. I gravitated to it rather than a dash/hyphen based approach when I was creating aliases for my team.

> I think the previous behavior can be brought back while keeping the
> new feature, except for aliases that end in ".command".

That would work for me.

> Which works, right?

Yes, doing 'alias.pull.sub.command' works, but for the users on my team that have the old aliases, they are crashing.
