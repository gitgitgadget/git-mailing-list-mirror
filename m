Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2E352C51
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051153; cv=fail; b=Aha+iwXQwN7YP+2dJ2BYzdKknhbqtIoeSvI0Nrz/zai0mowGMQ6djLoMg1TErI/YtaZmJUENJ0AJumBm4xfjuR8/fQE6Dnkk1K/xG+wolJecsbd2zrhsQouCySBk6RZMHzLBBh1/J3zzUXC8ynQvN2/KAHUezyR4jtPwcpY7s/8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051153; c=relaxed/simple;
	bh=1ZfD53LxF8UFTo2EtL/07PziX/CorzBnF7IAZnFnpM0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A5W/RE4SeWuL9iBTnL/eVcskUunczGLPVykh4IXhqruQrB4RZ+I5D0fBw7yo9NYdJPeI92/20VYe8M6EtT4Pb/JPPWVhICsCrrsaOFkrGBXVJm4tTqMXVmudhvy4ZEgqZU1Jc6yG0MxrmPos8VBY7k8HgipszRu+YYb7feW378c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BeZc1Gbm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BeZc1Gbm; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BeZc1Gbm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BeZc1Gbm"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dlv+YtgRatvkPCF0rj3e/j4wcvKlOxePcMlivV32N7vkIoU38RXtiWMEngTJjHDl75HVP7s1ZV+AQiJICScB5jmkN2pgWz6QQjjjk+Tp8jDjz4w0y0eYnAoNkkJthQhQFbcdtt56xe4TKT9oNfDtR2QjeuhFIpqFo86dDwbDEr8HadOzVGx8PMWd8f6pQW4TGYavK0gulHn1/uzIZq8f6w1VwScXrSf+xLSMC40BxXuJUipKXgkYzvNx8ZfWlTBjmVyBy5mY+S6J/Kjiz7Arw40JxJUJwFUzk4doMlb6iumy6qpTq/AhNBw7sDa5kvX9yAKUvNBFmqvFZRv3d38VVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcjg4RN34bpZdZc4EYspD+g+09yxvbQ177NkswHyVTE=;
 b=apwYhKT3b9q4yJoEKjbmzs6rm1AaBubJ+qtY0xuHZRUxZ+fEfw+TaoV793velLaKiN646nMGRP/DfFrnupxpDW1ZoqcTjXy8OJNEDY/Q3CEo9QoEmNVGVUUNf+k/tY01tmLWHXQwO2o2JlNA3kY1FbLQbEvCtYBlvjpKzdyRdAUKoHFt5k/RQ6jzI6zUjcIF2LDdBjCgbdD77EYsa0gxcUWPMvBicfsE0Zu7Ex0qyuffxP9HpFYX2UEYa8zKwobnE8VieTP6hV64OMaDIQ+hjKWLdDkcxrWrL/4zxxGEww/zUrtEr7a5oH0ySHB8WZDDUsOiVFvITxTb8FyHpmiX7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=fastmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcjg4RN34bpZdZc4EYspD+g+09yxvbQ177NkswHyVTE=;
 b=BeZc1Gbm/qMRkTZmQONaNUEvq7OIwMrnM3KX8GBekZNZXhuL5NztfDd5bBlo5IwvBW1D492NB9C2HYMtDiVnMT5izzsOETy+Td/dBhNjxZl2BYXE6NCNC6hKalFutZqjS2Gl1kywvmSC7EdqPs0/Kz/yx9by95cv3uKicz9hunM=
Received: from PA7P264CA0082.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:349::16)
 by AMDPR08MB11334.eurprd08.prod.outlook.com (2603:10a6:20b:717::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.8; Thu, 15 Oct
 2026 07:59:07 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:102:349:cafe::82) by PA7P264CA0082.outlook.office365.com
 (2603:10a6:102:349::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 07:59:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Thu, 15 Oct 2026 07:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoedG7LOA/rDu5Y9fjVqRGfkaoafGrCKP20ZcUFdpIpTu2PyK/H5mnOPxPvmLy37ld9Ag7dN6pc16bTfJbKN9TsdrFi6sxk5okatRZIWjmcD+sQjAe378ox+ZFuYHuoBBuEdqcL/SKNMjdAUE6smUdT7YLUtlCIZNyJxB23/EkrpxDb18XddCHrf3K+kvEd9K2xDK1NIpcblJW0ul6nUiOFytYsrixWZua+XEHQWV8nCPM+whhkyTNc+CGJdIMLcLZ/o9zKPnIvhRQ6hhDrJL+AL4b7QhTJ524cD6YkFvWg1xlIILSKKAIslQF/dCzWvYRYIskMXtzOFPftHJRuYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rcjg4RN34bpZdZc4EYspD+g+09yxvbQ177NkswHyVTE=;
 b=b036BtDfyWdJAAD1IQVU7GZcH6KExbwiHCw1dqMhKyOQlyGKt/hAwg/3fOOY3O79VRQbs2mdE4XemfWYgN/kgwNtOGb3F/pNxe2y4/Yzq2pAEBgkaKiLXGYgnyJAQv4yzhsm23w5NzbgojkP7e2xUGVmrmtwIVWG++efPhQLOmYn5gMvk0TIRs18j5VIku+8BUD6/DHBswroafu+4SohhFKDucsyHGSwIieqBsnFg4VM7EACNOCxwBA51Uw7Mv7St627oOezMu9aZDmPtOAqw2Udsk2pvAMwSMZIno5Z9oM4eTcQ/NFbuOQxOySIOGNAlh1DjH52n+9MzZtIm7RRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rcjg4RN34bpZdZc4EYspD+g+09yxvbQ177NkswHyVTE=;
 b=BeZc1Gbm/qMRkTZmQONaNUEvq7OIwMrnM3KX8GBekZNZXhuL5NztfDd5bBlo5IwvBW1D492NB9C2HYMtDiVnMT5izzsOETy+Td/dBhNjxZl2BYXE6NCNC6hKalFutZqjS2Gl1kywvmSC7EdqPs0/Kz/yx9by95cv3uKicz9hunM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by BR2PR08MB999934.eurprd08.prod.outlook.com
 (2603:10a6:2c8:19::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.8; Thu, 15 Oct
 2026 07:58:33 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%5]) with mapi id 15.21.0546.006; Thu, 15 Oct 2026
 07:58:33 +0000
Message-ID: <fc3de093-a051-415c-b40e-f9df5c914704@arm.com>
Date: Thu, 15 Oct 2026 09:58:31 +0200
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence.csokas@arm.com>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
 <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
 <958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
 <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
Content-Language: en-US
In-Reply-To: <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO3P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::19) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10455:EE_|BR2PR08MB999934:EE_|ZR1PEPF0000E461:EE_|AMDPR08MB11334:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e7a47d-a6f7-4df0-f45f-08df2a922fde
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 vQ/70nJJxC6jr3qtV696lAG9dW/S64w6T+U+5y2040DpOlt28QIsSHMSylPUUeZDkCkXGQMYljfnMXYAKNoTRZYfX8Xy1/egjjtA6Fk+rUNMSZ3g/Z5uFRyf47UlqbdMAvjV7RcGnGmJBNSdP5QVDYi2PuDCu5HZGmyHOYSKUpFqrnTCHMcQ+99VYiTNzvuG75JiiUWiARcLKf2PWHAisT6xvGOtpxGxd2ja3Z0Gp/pdniGm6HEkThNw59ZZ4c5PAGxblYC13gXx0Nvcaa0SryCq0QHxkbVk8PbJ/ll1AnC1R+w31ZWGW488+MiSCHMNNYNSxe93WS8Zbx3DJNhnmy1WicslHRn7U74Ax238CXR0swBwoWe9GE17tQdDtYIN2KCcw92Ht3lF5yd3MhhCa4Lyap/gUIEiijqXYI8LYFpnPe1yToDVghnGj7jBiVHLPPzx6IUgJkXdZImoNWykhr92BtClOlpmPg78jj+8rSKDj+qxfm2X99fwCEdFvv15jhHm0buNArZfFTRD1+flGSn8lu/Zj1w3+5ra4Ydaj8pjMzh5v6qJYOse3an36wtzSUaLcQE0tKnwO/hCP4WcCTFl849NV1xJ3Bqz46qclg8xJQ97Xi7fslfb01rBZQky
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10455.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 5sbnArLkbwMm8QX0OVs7/VIefz/6DyB0L03f7glDcn2eZhtfZfPP0lmkuSs+ogRo2TrWp8+Lv+Y9v4OQbDScdl0YA1gsDkfwZl0MhqvgkkEnrMhY02S0eKGLcDXgjT5O8IzU1a1NcdQUSGaWXDxON2guvQug5TIer3RHTUdfu8/Wnq5WvVLvX3KP302xrpRm20stkfpV1znttI954I/SRarRQFKBR0HT9CqPoKliP46sJxiIw+PfbNHfxj3wZElh/Vki0ISZS2tG4k3+yAyoOGDCEAsaMRWQKdR1IluqR7NVwn0evZmLNb8ONScXvAA+c+152o5XRcRQmJ6OqWjNHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR08MB999934
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b826651e-eb66-41bd-3ce4-08df2a921b93
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|1800799024|14060799003|36860700016|82310400026|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	OPrLeo6ACoggTCCPbizICJe+XwpU0cvdYoUGER895vBBTKB2cVMXJxivtIO5xUmuqtK+CLoNa2U6apaWNd/pojuNfzw0Sg9VM5kpPIhgCDG7x7Rn7/OIbdd+3/2mDAdIbtU4VlTn+qPEu0pbXyA31YlqNaCfSvN2wjlGFNIx2gwEaVBVKZ2a8TdaRfN8sbgGChXqUSVu+2rzhIGZlQcCI5E2kmqfR1fM9p9zABYsCuDzK0mJET4MNsVCTFcTyyx5nyrsyQSVDpYxLmOwngulYBS04kbn6HLELDFEolSvUl7gfzr6ZER1XreFVNuQQipg+z4EMg9vWUcoPv4SlhxwuWL6u8ld5VER3uXj4KzE/HqnluNrYD/z5c/kIi8JdPBg7TFgd0KpP72P7RbOy2htc6RWvzNLdsgYKDkdAOR34O3HPCCkDmgt1KAQBiEf9xcOYExtHhFu6PhPCCUiDcNa41dRwjB55LRwtFUhduIWhdDTAMl4ZeTx6v5UKQdJ+cIqyT52NfvfV4s/etjW19eKAAoywcQELjqYLaUUOPe30rbYxI7NA4Ir8bJl/zLNQeyscjD8qfxGzuNISqtMkymuwhvvEmATUVoXXQeB8UGxPdZrl0u2KSfkV9YXBq1GaWcuOz9YY7Svm+29DXT3fPS7LnAqX5LervVk+Mw+5vfnvyo=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(1800799024)(14060799003)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CuJnuagRLC1KsQ+RfrWvyh7WRVt5zo+qa317dZ0kU6JGAg6XmcV/uZb/jfJ8zXKVbJgp3+0/ovBFjOEuL4rhRmZYw9DX4H0nW+56+rhTCTebQI/y/NJmCCwdidtF2SvvoxIH2Z+AWs0/fzo13WkPcQi+PiKomwxjeAEmtX8Qg9e6C6a/FWuWoBjO+Vzu0V3l6nyR5RIoVNh4YawE+xgMSBvRFIkUBaQTZHWwtRoR6mBfcO3yNjhhA6WoYFGmzzlKRkFEnQmJF/KvRwqJPoO7LJOd+/D7zBMhgxwylc9/cg1CcW8LSbVjpMQaVb1MzMIKYgEfPVL2KrznEoquOsLIhLhvUJNYZiaX8seySqyEfc3tHHvLddKQ6wFYl+VaYfHvy8J98fdQ2ug0nqu8jo20bH9QV+gNIb7nW8yehZA9+HNsUnCK3mrBwPhcaNlTP3GV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:59:06.5120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e7a47d-a6f7-4df0-f45f-08df2a922fde
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11334

On 2026. 09. 03. 14:35, Bence Cs=C3=B3k=C3=A1s wrote:
> On 2026. 09. 03. 10:38, Kristoffer Haugsbakk wrote:
>> Not a bug (2024) https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster.g/
>>
>>      I suspect that it is much more productive to deprecate and remove
>>      "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@=
"
>>      does not act as a synonym for "refs/remotes/origin/HEAD"). [...]
> I would not want to see @ removed, I have abandoned using HEAD years
> ago, too much typing (especially if you want to express more complex
> things, e.g. `git range-diff long-branch-name{^..otherbranch,..@}`, to
> pick an example out of my bash-history).
>
> Bence

P.S.:

$  history | grep 'git .*@' | wc -l
74
$  history | grep HEAD | wc -l
0

;)

Bence
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
