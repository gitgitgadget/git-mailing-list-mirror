Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10451ABEAF
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627595; cv=fail; b=nIqLIA7dLU3KGymEcbjvS5qXXFxPS9LoDfhGktr/YyPMKJklA5gl6Wtpyx+YvLXb3MsgF7MOVLa7F+qICh6KxXEnu1JPQ2nrC61AYhbLrKbmUprMxtNtThdcSQ/0q+IG0Xn9omA3uShyTrychSO1AbeEQPqf9CMSbc5qJ5/c/wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627595; c=relaxed/simple;
	bh=lQAgTe3F+Ey9PFe7druLgSciw41o+tIIi+837ssQZWM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C1ryXipJc7TPQv7IiLvUFM8vUUy+7I40MSGTJeriAO0pz4HeJ5eqD0JTZ/E68bPL9iSLMC8aDls5fOx2gfbLCcWUxyXBszA26w/i+DxAXjLojd6VbKr32kIyCych2pLK02oUWwsgT10x3SYFq07ot0zy16LTfIlzE1A4jyEjWGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=fail (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=LCZ0tbBn reason="signature verification failed"; arc=fail smtp.client-ip=40.107.244.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="LCZ0tbBn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypReC8F6oT5yzcaIOqk8bJwJdGGRTV/0VzLf8X/HecFDfDCdqtcdkaO3sg1Dyi1S2MesqkXLjd7WlfQhC0fg4r6ZTOIE2nOnPV5zkUoimOlijXXc6vvQt6NgodVG89KEkn1Hc5+yUX8Y2abUry9YWXpr6TG6P2/YNgPYAvNqcgg6jl8zkGfTrkf48b5I26q3nZysEPd77KQN1Mz5jhyVlYTuT5w7Zw//aI3/m0NdDLUVWqI8RQEqNEGvSb5GkDpMR3ADNgANRmPYq9hg8QPa8iygEWS/GSUHbd8r83cUvcqo779M0JNMTD8kImS1vh7qnbtuTVaGdej/LjKSoDOkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjQ+eWvpZWCjtewvP2Fd90plVjeK8wrrQTNzLFV9wGY=;
 b=gOU3iOYepWrBRyWY5+bmIOOB15GmPoCWwaptvuvtQVs+FseZNybblJQ+5Fkug3fJupKOtEFitGV6pMasjsFMazhfe9HHNxprxHQPNnvcK2KS1sBB4I3zibV2V96mQ9CUykNn2CGhQqtbQB+Om6fH1KC+IMJV+HDSd6LUjVSMD8iGQEUO+5Db4NF0/4kItoz2231aga1vcDWJyi4LmCMluW64wY1eB9ixjQDFbPLztjg8PeE2hcGl8IocZxSLfx4LKn0mR2aAUdARjD7Mi7y7NFrl+ZCq7UUJScX1NpfwhnnoDcVsJQWNzjUyje9cHcTt2V12iNZNTwM7FDJvdItXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=peff.net smtp.mailfrom=alum.mit.edu; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=alum.mit.edu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjQ+eWvpZWCjtewvP2Fd90plVjeK8wrrQTNzLFV9wGY=;
 b=LCZ0tbBnHb0y0qebQob7OpAg+ULY520TzG5GW/QrKe84edc0AGWBxzBiRHeEle9/YhmNiV/5NWfFg4wIug2O+26YsDSkt8DGzEHeQUPO+gDbjBb95o5y9h389aYYyaCiezr5tTRUsGpUoq5/Z9w/f7Y8B8ghNiC8/c/hdoIIrlU=
Received: from SA9PR10CA0027.namprd10.prod.outlook.com (2603:10b6:806:a7::32)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 19:39:52 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::15) by SA9PR10CA0027.outlook.office365.com
 (2603:10b6:806:a7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Fri, 2 Aug 2024 19:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 19:39:51 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 472Jdm7K003794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 15:39:49 -0400
Date: Fri, 2 Aug 2024 15:39:48 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <xmqqh6c2d8qt.fsf@gitster.g>
Message-ID: <30733887-33d8-4049-7dc9-8bc9d0b106da@alum.mit.edu>
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com> <pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com> <xmqq7ccygbx6.fsf@gitster.g> <2ba77de5-f103-c2f0-c009-71700c8a020d@alum.mit.edu> <xmqqv80idf52.fsf@gitster.g>
 <a0b916a4-8941-4c06-263d-0ae92dcaf29e@alum.mit.edu> <xmqqh6c2d8qt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323584-1765464460-1722627589=:560477"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: c535df3c-51be-4e8d-0af1-08dcb32ae07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|41320700013|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-7?Q?tI6rUeo2BO00d2RrWrO7f+7sOi2dGpw35oq0pLsCI4BQgAQrB9QT/bivjW?=
 =?iso-8859-7?Q?zNvBw/VR71L/bloWGTLQ+9hNQ+L4RkhntzpzrI3B/mla0EnHoczKis7JT3?=
 =?iso-8859-7?Q?oLPwp3S2S7k8e2LMFxYPTjJs/1yGAH4rezm+NEHwm1KtJ1WTwOy0boj34Z?=
 =?iso-8859-7?Q?/280B+qRlfi1nCI5eweiXj6TNJZydgrxuRuk1gszYA25Z1O5Uj6rsvnpEH?=
 =?iso-8859-7?Q?3cD6BNS/HxiYmR14EzyvPKkG0dHK3PCtkGvYawYQVKRNt9LMDptTndLxa6?=
 =?iso-8859-7?Q?z5LDjnqfz+zxa26lM3EPUr3NmQbJ/5ZFc5aO25IHt3A3dyeWSgsTQB3i3e?=
 =?iso-8859-7?Q?uOJhHkQxMpJS9RoTofHcohMVqP/hD+VgTmjH5jXZ+SySL/DCq48MNNmRWc?=
 =?iso-8859-7?Q?ybTBiS/SaFwlyWlvnfbpUdVXlH+JT2u5k4OUu6eASnnE1fmEWBj6eGQ7Kj?=
 =?iso-8859-7?Q?5K957EFwlTdqxKy6ElpYS+wyBc7qjtXLYqt7kqgHy7HWpv4kNFSfYTlg3M?=
 =?iso-8859-7?Q?FDezlFBvGB0SGG2jfC9bSFVVIRMehJP2Gt8rUCFwqaRUPmMd3JBincF1sc?=
 =?iso-8859-7?Q?jPmhJ0BUL4Y6Dfd3W2a3v0yKYZe8GmrXAVvt+V0ftqOB2lUPogwiRqE7dM?=
 =?iso-8859-7?Q?YaLYh7+IssEQICB5XSL2P+ovRVKuai2JWUrzjfUH6EzOyWs/WVf3fo7H5d?=
 =?iso-8859-7?Q?t6/u5/HHTvXvnZ5bCNlcXdyhp9C7Lczw0++EgNKnGIgRmB87vMDOrUNLYa?=
 =?iso-8859-7?Q?ZOMmAuSYvSSH7NQLIOXvarzWJKOlXFYLjmTsUndNCXsP7oje7nNnleFse0?=
 =?iso-8859-7?Q?A4uuLzs3dgdIwZrl5OdYbQ780ApWWKt2OGK6EM864VxHY6bUoKW91SxrAo?=
 =?iso-8859-7?Q?y37iu9MoUm8sKR1/3ZPkq61W8QHUVg3wA67WYCu5eNuidqnn/U640hqM5e?=
 =?iso-8859-7?Q?TRbktg2u5miI7gIfEu33x9o6yKCiPt5kBe+o8r0RPhkbGu7Q3qmDW+SmLa?=
 =?iso-8859-7?Q?Vi+s20YwGy+97gDVdWJZXjwdyz1ojNylZIJ/x97HAxC7jvQaP3VHEVM6p1?=
 =?iso-8859-7?Q?rDlr2sNoEwRQgbcHsfahwQdL7alFeDtX/NxMOdqXrsTvodLT0FCCfqw7kx?=
 =?iso-8859-7?Q?A1Wxi8UH93Q50PUAVSDQvJaHlw4m+rq62VNU97Vqrvkx6TvF8iQ9Fc99vX?=
 =?iso-8859-7?Q?eD4eONJsFiTj2JHssobaJOHKkzvL7lkICt991d1hKDbBKXQkOF6u8LLzFS?=
 =?iso-8859-7?Q?P6LR/x1sFM8c8nGokTN1L0Qud4CI5NESw2xKPgA64WLua5zEt9Dz/SS5Zd?=
 =?iso-8859-7?Q?aIhfynYYnibmvlOaDfPdGPH4CCFGgGtJiGGSr+qd76dOrKVsRqtlyAMUW9?=
 =?iso-8859-7?Q?A/+F17MldGEd4ItX32cuqhB+gS1k52LXcjvU9V2XRmFoIAELU77/pX6hO7?=
 =?iso-8859-7?Q?s/XR0puC/0n3UfiUDBCWAtAquqdsv9wNpmcoLIv5rExHDiITFEB9JYzbLT?=
 =?iso-8859-7?Q?n1NQHEQTURq7wM49rEMo5C?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 19:39:51.1188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c535df3c-51be-4e8d-0af1-08dcb32ae07f
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1765464460-1722627589=:560477
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

At 2024-08-02 12:28-0700, Junio C Hamano <gitster@pobox.com> sent:

>>>> Is this blocking feedback? This strikes me as speculative
>>>> over-engineering
>>>
>>> No, it is loosening a pattern that is overly tight and as a side
>>> effect shortening the line to more readable length ;-).
>>
>> Blocking or not?
>
> If we are updating anyway, that question is irrelevant, no?  This
> version may hit 'seen' but until the next version comes it will not
> advance to 'next'.

I can't figure out what you mean by this so I am going to proceed as if 
you had simply said ¡non-blocking¢.

R
--8323584-1765464460-1722627589=:560477--
