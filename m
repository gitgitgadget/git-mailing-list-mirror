Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0B4A4842
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438996; cv=fail; b=ZKeGw219eHPAGAObxKlXdaF4rtvrQXRIIwndF9WGjLhZ0Pqpxy6z9/Yp4tU1BArA8GrKCRDTuNEKuHRN07J07fVi3pxbIKrpvRAwlIlh9Q7MtHAwaKcIjRKM2eRTzSDjta6acYQWiLaHeZhcrZY1hkPoYuNXsni+55uIpPxccco=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438996; c=relaxed/simple;
	bh=FRUAao42J2tILXe6Ej/TzA/utD6NhBnrCCEQlT7CpIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjE4LsSJi/kwHxcjHKMh8jmDjh/NtPNQzFcW9uZ9Mh8Uch2kC7JNDmKO0qJURCI2+Z9Y15wHgsLVKDU7/rQu6FB16bJ2VSufPxgvm+NbR0alAjafuyYYV21NEi7J8gXPqM+RpJQPbpYpfY3dQTJLQNtHBIFwGPyuyOGC0+Pkzdc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lZHSU/9G; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lZHSU/9G; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lZHSU/9G";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lZHSU/9G"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yBcJXvA58s6fvvK8M52B78f1CmWlRM9j1tqFJp4ExtpJGYvoW4bS5zLVyqGBrraFbq+B5BszIECmTJdWSxKF2hkJGKhs89+rmDc6r2Glj+1LNfyjBFgvSBD5ULECrED8whAWLI6H3N7Gz9t71Nv+s0BP3edFYostG7PHBW5k/mv4YkY8e8/AzbQcQaIFzOD0Li+9GknlwhP6Y+/mPlxIxPvSet7N764vYj/ABp8yB59gC5jUPjX9AWiDRouVUyUUD9s9s9u7t/bdtUJ8HoGhJgM9lB4wlWcESLH9QzEIWjfXs26vm8qbBhMSJQ3lurhxjpFlffGmJmcxckS/H2becA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1LlF6zo9Zehx8TkpdPIlRbvJ4616c6kVX9goFrPLmo=;
 b=kPwHxI23+Lli2txzPH8JjUh3hvz5RweaGMIkNiUmmsfP96EpTc5C7wlAE6mlWsAiqDLflzZH+FpRqHC456Aw/LNpG6lld/QqdffvZpoOQ1NHl+r8Kci3EhIAdTa6gK1WxRgOg+fCmw5bip7OLSTLrOtDEyiWoIJPUJ7I4crZ9B4V6qvxcKVObB0x6syRTJ5fKpcT2VhDADd+KcpKPa+Q93N+Hr72SLxiCIlG661hbUYKmuuVbudDmcP37Y1xaewW5Mh28iWE9ND7FIUEp/nt7LOurfL6SNVx/ezioedV5Y4Dgqek3Oc1sR+Pe+QZ1FDX5iI8/4BAOyUJqPECQTGnvA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=fastmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1LlF6zo9Zehx8TkpdPIlRbvJ4616c6kVX9goFrPLmo=;
 b=lZHSU/9G4wx2mbNzM8csm0YhLsLSxIbjZQ8F0sBBvLTioM7dVD1YzwcgHvgD1Z37qKfmTAV5caAPv3AzFNginLHNujiRDurxBtYm2JiD75KQs7uINaxE31hHZX+0U3SG15GEgLnyPVwa7eAO78277128wcVXtv+BaWSvWMkHn3E=
Received: from DU2PR04CA0056.eurprd04.prod.outlook.com (2603:10a6:10:234::31)
 by AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 12:36:29 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::35) by DU2PR04CA0056.outlook.office365.com
 (2603:10a6:10:234::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 12:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 12:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNAfK65ZwgI4o4E7gxN9MhY7DCEcdnsxI5qn8gkhEqa7IkzFipheUTqHJitdKYr3rnTLN3uEPNA8tWo0UUjxVmALomYi/B+cMlpyFu3uPLbv6MxLRlhgMTv8n2JDSSzS82dGy3H4VHM/ynUVPZiR/2GkIUgGGN8/DK4Sxdk4yV5TwsbPEhaQTkII/rYVTc6mu8Tfmj1TA+SHjusVoEvki3dbSZc/VMxtiyHhLUBKW7bKPh3o3N4Rk2q8BmPXLxgRYjM8AZdHzxmUucTPWuAwrKw5CC98ko/DLJOeWt9eNpnNGxLzt/iTdieM4MWHaQwlAbKpmyhB9M34BcHFFZ0/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1LlF6zo9Zehx8TkpdPIlRbvJ4616c6kVX9goFrPLmo=;
 b=RTg+F6R83+5q94bQ7snHhhypci5H7Yl09DakJH7QEaRxl7qZc278JjT82iv6RnaikqMxHwER7X2E/UCfeXym7m+21Iy7otSRvpNhbavZAo+oGLq83zlZGl7r26yQt/bIomJgj3Bh6M55XEMtiMaI2BDgZWCe7w44zzPXzvxoij/ioGhdLc713Y7YloaLYIJxHxCfx3JKoglMXOuas55eTvXVzQ6LWAmWAKfgSO6lhBjguZLr8irlrCRUgfIGL4/QeOSbGAxvGCaaHTJH135um1iucAGdI37ORqguiIXPxG3I1sUOKc9pR8KAKG40Awnf6O6dd9TE2wEU+QIn+z2qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1LlF6zo9Zehx8TkpdPIlRbvJ4616c6kVX9goFrPLmo=;
 b=lZHSU/9G4wx2mbNzM8csm0YhLsLSxIbjZQ8F0sBBvLTioM7dVD1YzwcgHvgD1Z37qKfmTAV5caAPv3AzFNginLHNujiRDurxBtYm2JiD75KQs7uINaxE31hHZX+0U3SG15GEgLnyPVwa7eAO78277128wcVXtv+BaWSvWMkHn3E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by AM9PR08MB6641.eurprd08.prod.outlook.com
 (2603:10a6:20b:306::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 12:35:54 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:35:53 +0000
Message-ID: <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
Date: Thu, 3 Sep 2026 14:35:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] Porcelain allows creation of '@' branch
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
 <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
 <958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence.csokas@arm.com>
In-Reply-To: <958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::18) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10455:EE_|AM9PR08MB6641:EE_|DB1PEPF000509F2:EE_|AM9PR08MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d60009-909e-4a0f-0aac-08df09b7fa99
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 Su9OKnQJniikwHGH9176ClA4JDRHiAvNtM7p3pzIQcfyhZecYQQIzk66RSQ+fz74uercEiW+Qm0WYk1rHikM9R41WHnVxPmQ4VH2dlamxtcaI9Ysz0MoabGH1eKUYldzJfIl24NU6jd2KgCe669qReliWcyKyHZ60qbDSDGmkXLC4WHvXijyjVDYy1+QSO9cC2Nb5gamyWHAQi4H9VDF1Pqhv5dX5WhPKszDHDpa2kFQ8lbdSZJsCBYBTXvH0YeJ2krIrl64VPtP7W6yrdtXKDaKeC3xpL5lIv/Vj6RQXNbhWw8hnrbgTG515JzLfwXK2+PZg9cEeo6zip/61HoDbfFpdzRx6T132pVKjysesvAosqnIRWmPvPx7DwPel0clVXLSFSKbg7GiVVVL8yfEbzEJM31Al+MvhZra6DHMMCHQFQGy8rqwNieDbaS/yFoSOD55ohWl0Pa6zS2Lou0Z9gNOMZexLBiy5NyW7NXOXRvBvJdLgTsnKrL5BqilCR8QVHfa/6REawAnxJGW0/o4Ni8gJyasFVhsmc3c/twFEidyHTJec6j0Usv7HCbU1T0USEp0o/gT6gyVVfxLuEDXz6GQixeukTGRePMwEKeuKgeVGFulN8O0oDdvHuCmUCF9nfpc7f/iuIp4Pivup+G80dEGdz1/Wohw7A4VMbd0tyM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10455.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 o+0xo/OE0U5fd+qkTxjASZ73pEbgdKQ8uG8qcHO+XU3BB3HgYumbkohcYYjm6vFSL5dFw1kEhcR+mW637DKcOpqdBpirPxpN/Jof36VJaFnloplVPYcYLvRiHfMtsT9BBKFJ1KWefzqC/Jd/6Y4JDLo203UDo0rUs+YI5StdLFN91a2J1pbHcKx5R32RhzEqflsdxVlZvNliX88Lajj81hosdZm5KK3TIBS6r62s35acTEbYzjVMfLutR49U0i9eBQYAHGPsDAY1GhB2GaEXoTnBac2oN3Q7QEbiV92m3/RWZiPpgg40c5HOB6COSBKQghe+uDyuu9+5kWYcMpAqRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6641
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2b31c2c3-2610-4d40-bfe2-08df09b7e4f3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|35042699022|1800799024|14060799003|11063799006|56012099006|10067099003|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NviNcxpegWN61DOcYx+KsAWBpdoHSFJjPA40BR7LfUA6vwCZ067bo7PQ+WMlhTpO0qRJwXbX/sufyfMQFmc+R501ZxSOCHVxjH27m8/YQlvnzm8X5xwr7tzM80F+aC4h1rqxhhClyBO3q4YKjDCHW7p/MWB5vvl4gQhAEJhUuJ/RmE3VM6rYVrmADBmuDRCWXc6q4l0z2FTG6d49sxbuOnZn24RKTui6jZZ8hCTuCMvggqDi2OrNis6puHPt0vtk3k68K5IBLbKXsLzw3Bg7RyKduQWTfhzJTL++THRWSfoSsIN+B3Lf14ixdEfd87prbTPX8Yj882S29e7LhqirmYGx6Bo70QFZHuwK/tiobJ07f/QuKShwi1E3jeX/bsA2eEjQnri0y062FJVWuz3OaeNSc1m2tsK5oqkKcJ/zjbqGdXi0YVesxS4rpAEMHsGOXyoyGpvE44W/bBMjAXxaj5Ro5vxm/gfA1Y5emY+xSfOEjy8LfFXBY2A4OA9xy86QYnaOjIo5l5cogezV7ijeNwXFvpujIktcLqS4c2FwcDcNkE1q+f8lZSQuusxA8bkK5AxkTFnqgW34QSeDshXOPlB0NPqlH6u+LWQFWaLHzrON4YtoO2gz9oy03ozN59qiNPNovnBJdPW1tuNXVOYWdGt1wVRiJUMI7bR1Sl0YLLc=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(35042699022)(1800799024)(14060799003)(11063799006)(56012099006)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pcAOcpwzQJGJVeQqKTZ+Ggdk6EgU6rllMQWNPykvVDJnVHXY2Bo09+eOTgH+1mzK3+4ayhWa+xCOauL4wgsgXxpqd8Y6Zu9hMUYNSA/VDES+n6JeMYWb5ZtLPq6oIxCqvJlZ3gQ+P6EE0B7terWx/fSQSZYKnvDOHlGDPrRMIidXR6bZudqUoMkRMDBX0UJQgMfC7cP9T76eZjuWlyhnXKyVoT/3sX68EmiuPUmV6j2AzpNcAudUaL04KP7dVqv8dJMQCgveIFq5vL6XUP1jtkj0pRkX/6u6pvTXvCFTeffhCc1MD1OCRtisoCvxvYALfrFLIlbZqLJ7lfZtQl2kssYEsLcTefAEJfQgToRNfKdklp3+0bj+IxsXIrCMdBMOyVXD4wTd2JUs8kBHuMkDa/rI35iRLskTr8sURfVt/UGuT/jbqPQ9qUWYCzh3DrOM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:36:29.6879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d60009-909e-4a0f-0aac-08df09b7fa99
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6034

On 2026. 09. 03. 10:38, Kristoffer Haugsbakk wrote:
> Not a bug (2024) https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster.g/
>
>      I suspect that it is much more productive to deprecate and remove
>      "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
>      does not act as a synonym for "refs/remotes/origin/HEAD"). [...]
I would not want to see @ removed, I have abandoned using HEAD years
ago, too much typing (especially if you want to express more complex
things, e.g. `git range-diff long-branch-name{^..otherbranch,..@}`, to
pick an example out of my bash-history).

Bence
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
