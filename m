Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9B342524
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984924; cv=fail; b=TfeOKhh6zrIEn0mWZGf9AZ2lR6CIVRxbd/seRGGty+MOg0Q6Y1EneixMg8V9XgYJ5GdDurMnFg4wfDYGdD5+tiZnbEl0ErA/bZDe7EJCWUgE2gfy7yhTv7o3+f+eq4DI1S+4Fr13+waRqMiVxr1IqSu4mPcAx5UyAWrvfGGwA4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984924; c=relaxed/simple;
	bh=2QBFCnRHJX6HqMCRpwPDohTwEBt3Oi/6b0G0Ke4hx/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4E8R1Gy6ZLaC1KIlYfM9/19Kkn18TKiQj6RjxrfLfiwtmTJ1A1+HHqjxeIkkbog2SUvo87e9CUpZ5nzh4SQKHBsnXHAzdFtKzIDPJC5UCcuiGm46c7KkAUnyhQmdRMKs1vC2j0VqI/1lNpqh4/9vBwVB8cHbL8vdqtlzXG6iFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1jx55iol; arc=fail smtp.client-ip=52.101.193.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1jx55iol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwwxGgQPVgaPljo2fkq/ErPBS9BY9aJtTzwK6VjFCGQxhXAMaylZbxNl3bUCVMytAciaQE/9wCIqJe5jqvcTXjrt9yZZc0qVgt4KCJB6aF0kkLcyMH6ta/OPVLZQ1ON1LNH6Fg3Yhe1cSOv9fc85gnOQHhIpesIMxC4LObWTtOvJSBfIgWp8dtj3sKCk28vZwEx+Sha8JvsGkIkzlrbz6yzIgiyhoVDhoeqmQMOwsnhKxz0/T9+7/LvEPZZp8J+NMLyFkSUzdqTqZ8nIHuop0oabGdbGgxyJrHb9K/xyi4w59dZI6Bf5r9WpgRe4QN1gDTHOaBGXalhSy/wY6Ewq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+d3YjdYDMSEmZLc/t/zIQzm716cof+v1uTCSl0sekA=;
 b=OZwtd+OH+//rSBdXl5yQm7c/41S5qrBpi97TEJX3HkAok0HweYcMeUKUVpa3c5Y38gblPyC3wmJ5ufT4q+5+1SIicmwveteWkqJl5HJZAi2bAnbyFzNFIvBRrcT/wGIWIUkZuJl0MtHxL0W+jO2xsNFie1cDwd1FQmD/KgBLmnZWxs59uh1Kgcmq37Nee7RBu7u+R7bPGTDYCuV8mx5VgZwvtltgusval7S66aT8oZEkdsq9drXNwrILUe8HGgXx3tUydVd2OWxULG/MZ5ZG2+4EW4Rs9ZPhCXj6L0+QSUpLSSg9AJHD4OKNyfcnzz0EMMRKCcwufMbHJAvqJ8wXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=peff.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+d3YjdYDMSEmZLc/t/zIQzm716cof+v1uTCSl0sekA=;
 b=1jx55iolxEL8RsV1ScFMGpcK8pHllSITKso/SGhVcqPzMYdtd6l/eT+m5AOwHvQvQ/3GUbs9c0UsFRQBe8/x5S4D26j1hMj3fzFKZll5JQcfQeCA9VVJPtX23E4DmgFgyMrSJvpg1ILMBIMYkuJFMJKl6h/5YJ2jXbWwuLFjRn0=
Received: from SJ0PR13CA0128.namprd13.prod.outlook.com (2603:10b6:a03:2c6::13)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 22:55:20 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::da) by SJ0PR13CA0128.outlook.office365.com
 (2603:10b6:a03:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 22:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 22:55:18 +0000
Received: from msdn-mgrossfe-2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 17:55:18 -0500
From: Michael Grossfeld <Michael.Grossfeld@amd.com>
To: <peff@peff.net>
CC: <Michael.Grossfeld@amd.com>, <git@vger.kernel.org>, <jonatan@jontes.page>
Subject: Re: Bug: Hierarchical Aliases no longer work in 2.54.0
Date: Thu, 23 Apr 2026 18:55:11 -0400
Message-ID: <20260423225511.924-1-Michael.Grossfeld@amd.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260423211237.GA1906241@coredump.intra.peff.net>
References: <20260423211237.GA1906241@coredump.intra.peff.net>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: d1211b41-95cf-4935-4305-08dea18b6432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6/F0kFgdsiL3HX+VW9a5gndgD0rq5sDaelvo7woAciNbfe58oWWX7kUcnFI8PDKYBD70H2bPEoKaf73rQSq9Bh/8FZl0L3l4ifO0FSakbmqw/MjfFHx7q2Dl27A5cVS73vrYyhZh7rz54o0dLTD2TYx5bzJLYUK//UMWBH6++fiXf1tmN26NWd2vUxokFBJlwJfM2tSYsW6Cv3xUlV5+1A+u7QVw/8T0kxFCOaF/W00z7Ue9IB49HXa/+wxFQ2uQch4K8j5BAIbRbSPe19Z4EibZUEtiqZlKajFjPdcS2TyARcTiQykDfirWaV9gx7cnNLwJLMzNoWZmabdTy0BsPtDdafVbOfSlAyaGuxVCS/L7Kv2GcSf5Le0pIJgg7nQqW+U/axALUKY1jOsfoFeL++V7RGIEYIJ3lMLrvGjmMYfPB9DZjBycDpZEgMBBBpITEKkYlQVYBWK1zEF5/F042qWRY6dIeRT1G2VYhBGaLdSyT+XXEgWkbsJiFJtnKM9XeA3v7n/N9p+VE6v+nw6wQAJ1ijkeR3rbqIHD5vubcJ8bH/kXuZq9soGhjThmLhMaG811LyEondU+xty1/WI6PNYtsDCMBIjhrZSm6b6TykPADlW0V82tO+9yZCYkIRcmnFY5UF1FxfScDIKs1iWNzEXZlIOBqyAwAVDtDXz4PCPm8BaaFp/VZ78nrha5TGwZCuuPNs2S3JJ/xG0rvj+p4+5heRyA/rwKdkQzrczm8o+ZEaIHVprzSSN3qr5KcITHRHud4a11yUbag4hRufy2rg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Ivcnl212LM530NPbT2T3avx/JqrMu/LnqleuUejNd4AmOeJPSjdYlbGq+SUR7EF3dh18ChwELemyCVcP0c45uWNhGDP9ko3DuEebf8nBVipy7106ejr8lEkUVWoBZWTCfANXqc/RR4CZrYAYYxsNH86Gj1N0hUUZ6G2BR7fqWafzzQxrjURo4irbDOCgLgbgx22IjHBGBWsaIUqOllo7wyoIqQtgSSglxIjMQOYMldmjEesORBnqQ7/5+UsN+1V4y5Pp9ByKo/Cesdhr28v1gYvpDf8+1hCdmffq36URzROxKC3laFY7a3SfvahhlIsUSFVGpJeOVCQO6kUWwUAffxap78lFEAgxbMAYlvFssE/gyEObTXd165CAFcxhsd0xe2FOb9t5to4hG8cPz8NpQ1WJGCYQxDk6yYK/rwtvhJ99TixlZEvdXWuFFWDjaaY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 22:55:18.5900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1211b41-95cf-4935-4305-08dea18b6432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

> In the short-term, you can work around it by using the new syntax:
>
>  [alias "pull.sub"]
>  command = ...whatever...

Sounds good. I'll likely write a script for my team to convert their
existing aliases depending on their git version.

> That does still break a historical alias if you happened to call it
> "foo.command". I'm not sure if we want to try to be even more thorough
> and fall back on that case, or if we're getting now into unlikely
> hypotheticals.

For my purposes, this would be fine and work for me. As the hierarchical
aliases are already unlikely, I imagine "foo.command" existing is even more
unlikely.
