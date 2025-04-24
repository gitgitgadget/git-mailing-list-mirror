Received: from esa6.hc2065-58.eu.iphmx.com (esa6.hc2065-58.eu.iphmx.com [194.165.214.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F9146D53
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=194.165.214.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505031; cv=fail; b=P9uo2Eky1YmnqKCd1cu68o5SXk9uTYoJxrzgO55sWZj1eyMLuQpLQNLndV5+m8voCzBf6JbtF1wzZYuDtQi/Sbh8Gi/NmADWzQmjbnGZ28k77Fsb1p54PJh3yEPjE6D0z5k2rzz6Uy3Tl8o0CRkBrz0UArIayAmicyXZkFQNp4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505031; c=relaxed/simple;
	bh=5vsfSfaojMqJUGilx2h6hVwMuuFlMDCHQsEyj4v6Xdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OYZ8GNCgwubUnGKcELXDm1p5ly6n2X9NKZ/oslbxpK7sdoi9rOnYNdAu18/9TIO7qejBH09AN3kcHn/npHXsuPTRoTvdkGNgz1cNsRcyXSZHGkLS3DwVQ9jvjCsAUaw33G5CW6PRRRRiTD9sVEHoZoL5MKjMSpHAOihBQCHZJB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capgemini.com; spf=pass smtp.mailfrom=capgemini.com; dkim=pass (2048-bit key) header.d=capgemini.com header.i=@capgemini.com header.b=SfqxqVCh; arc=fail smtp.client-ip=194.165.214.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capgemini.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capgemini.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=capgemini.com header.i=@capgemini.com header.b="SfqxqVCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=capgemini.com; i=@capgemini.com; q=dns/txt; s=group3;
  t=1745505024; x=1777041024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5vsfSfaojMqJUGilx2h6hVwMuuFlMDCHQsEyj4v6Xdw=;
  b=SfqxqVChLx4LZyZQXM8q8jW7Ll/ms9xw/3fpAOHVSt5tUntDnmVLOq7S
   LtdiU9wnK5lN4ZEVFGnCCxJEDs+zykAOX7xg5SHog0gnq6TjSzhUQZWP+
   lDWCbhpb8Rc6biaR5bULmkZrqG/1M9I9LlYlMzsyZ90P1hq43pSp8j7wY
   KMevIsJPbFOA0NZW87mHhiT1VWaC10ghXmu2+v6FUd3672KEEKIhxEfnm
   xvSfPsLD6alKeAf0nPmPp7UMExs5u1OK81nNhhe3gTW+QU7Wi54Kiz9lx
   27UzlTs+6Y1rfJT7Dv3VSNCXEfMiiGX2atgC6ySjZtjc0pb9FxAgote+m
   g==;
X-CSE-ConnectionGUID: f90TimizTSu7z+AJzxe8Uw==
X-CSE-MsgGUID: bgZSCmpGSmGutzDmzPfHrA==
X-IronPort-AV: E=Sophos;i="6.15,236,1739833200"; 
   d="scan'208";a="17679329"
Received: from spfnldca01.capgemini.com ([80.253.212.216])
  by ob1.hc2065-58.eu.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Apr 2025 16:29:12 +0200
X-CSE-ConnectionGUID: AzlxBMHJReSrUmQARVw5sg==
X-CSE-MsgGUID: bLBYZIsvSoaOZosbV8Grqg==
X-IronPort-AV: E=Sophos;i="6.15,236,1739833200"; 
   d="scan'208";a="327578609"
Received: from intdlp.capgemini.com (HELO gddlppraplv01p.corp.capgemini.com) ([10.247.137.136])
  by IRNLDCA-C695-01-D2-incoming.capgemini.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 16:29:12 +0200
Received: from GDDLPPRAPLV01P.CORP.CAPGEMINI.COM (GDDLPPRAPLV01P.CORP.CAPGEMINI.COM [127.0.0.1])
	by GDDLPPRAPLV01P.CORP.CAPGEMINI.COM (Service) with ESMTP id C398D139B;
	Thu, 24 Apr 2025 16:29:10 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com (unknown [40.93.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by GDDLPPRAPLV01P.CORP.CAPGEMINI.COM (Service) with ESMTPS id 885C7188050;
	Thu, 24 Apr 2025 16:29:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJMWpCul+uycYDLZvjFyf+BjnKXiuEFUMydEseXRttje8nC9v16aUWKKiqW1F9a6yTtdGex2IgEQT1okAPEroh68s/g7Mwya3ngf9qqrY1RpEPl/srjzWOWDp5N9JrLrZEgBJM9reI4jIcs8HgQ5XTCx5BEwYyxbf/gvvpYIj/Y/1EN7T4UBA6HCsHA3HwyDwHdRLrF87ITFcInrOGoCwGggGLLEUVZcg6qjgPTeS18AgGFvq6dF3hcXc2hEA60HULcP+2Mi+06HO03H+frGSBOppeatN7TZEiPEmkYb/dBIHG/0rLgLMsfvzT2iU24P5cyJWpaSihX3xlwurmPqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vsfSfaojMqJUGilx2h6hVwMuuFlMDCHQsEyj4v6Xdw=;
 b=vGex8XF+l6hn10IfcG5kNufemAKguUNs5gFZUHgtsnrQHaRzOmOeoEZ72W7f8HQGY1Gq0u6O1L0c3+jX/HfMzfyCyyF02ff6flbXv3M94fSKi812cQ3bluhlY7a3rUI0wvQ85Hy16L0+p3PL9/fa82haP8rwgI0KotLO5YntMhlKEvJ1rHeTW488Nay66esqD1yIJMYBQroKhCXPBVbowATwXRaDDr73ir8o+saTmSzSu/9llQpIVuZrKUJD55MN+oX4RDssSQYPe0OjoE//zAI0QfHsPdgbxR68kyeCznUqpXE2SMSQy+Cg/6d/TjmeuDNv26zWYDKtVtGih48F1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=capgemini.com; dmarc=pass action=none
 header.from=capgemini.com; dkim=pass header.d=capgemini.com; arc=none
Received: from VI1PR02MB6495.eurprd02.prod.outlook.com (2603:10a6:800:193::8)
 by PAVPR02MB9596.eurprd02.prod.outlook.com (2603:10a6:102:30f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Thu, 24 Apr
 2025 14:29:09 +0000
Received: from VI1PR02MB6495.eurprd02.prod.outlook.com
 ([fe80::1c49:fbf5:fc0f:25b7]) by VI1PR02MB6495.eurprd02.prod.outlook.com
 ([fe80::1c49:fbf5:fc0f:25b7%4]) with mapi id 15.20.8699.008; Thu, 24 Apr 2025
 14:29:09 +0000
From: =?utf-8?B?SG9od2lsbGVyLCBKw7ZyZw==?= <joerg.hohwiller@capgemini.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Windows] Severe problems after upgrading to 2.48.1.windows.1
Thread-Topic: [Windows] Severe problems after upgrading to 2.48.1.windows.1
Thread-Index: AduMRF1FlKoLPIQySq6CTv27PYhTgQW2LrCAAGlPe7AEFfWrAAACuO5g
Date: Thu, 24 Apr 2025 14:29:09 +0000
Message-ID:
 <VI1PR02MB64951BAFB488287E136125AFFB852@VI1PR02MB6495.eurprd02.prod.outlook.com>
References:
 <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com>
 <d3f55106-8f87-b535-1c7c-29d382378342@gmx.de>
 <VI1PR02MB6495A9779866FD337F2F8E1CFBA92@VI1PR02MB6495.eurprd02.prod.outlook.com>
 <a81435f0-f09d-9197-9776-2402457fdef0@gmx.de>
In-Reply-To: <a81435f0-f09d-9197-9776-2402457fdef0@gmx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=capgemini.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB6495:EE_|PAVPR02MB9596:EE_
x-ms-office365-filtering-correlation-id: 9f6680f7-2a4b-4f5e-f03e-08dd833c603a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnYyNHZTdTN1VXphZ1grSGNnY0Nxa0dwWlV4d3FLNGJiK3RHc245bklmd0hJ?=
 =?utf-8?B?eUhPNlRoSjBkT0h2RExWc2MybWxweVJYMlJ4RWxQd1JDWENrRFJFTHBMd21C?=
 =?utf-8?B?SEluMEhnK3BXRHdGRitheFJwMU4vdlRpZXJ4dkg2Yk55d2U2NW5JUmdUWlhw?=
 =?utf-8?B?dW5tcE9VZzk0NEFMeHd1TVljRlRVUGcwcDMweUlkampubmJGWlo1bDVOZW9q?=
 =?utf-8?B?dGlVUUVLdVNvY0VEYm0vOVUyTGd5WWE3ZURIUVRmZVgvQkZhbVBhYWUvUEpX?=
 =?utf-8?B?dUV4SlFpa2R4QnoyY09sRmxUZ3h4elVvTHE1d1ErbGk3SU41cXRoRE1HVEtC?=
 =?utf-8?B?NktMVkprRnB1Z2Q5bE1OMll2Zjh4WVVjRDM4d05vNDhwaWVXanJHdHVxeFQ1?=
 =?utf-8?B?UFlmSjNyRndTb0w1TC9vVFRheWJ4VkE1RDJmdUluWEVrQUZPVXdZMmZiS1h4?=
 =?utf-8?B?MGpuSURHSW9DNWpleVcrbVlWMm4xLzF1d1grQ3VnbnY2SFRMTC9NeG9YVWFX?=
 =?utf-8?B?a3cvcGp1Nm04cEpJUndzUXVDaGxLR3RWSktoOGt0WGJMdk01SFVza1hhVW5v?=
 =?utf-8?B?UzVrMW9EKzU4YW93ZHV5V1JidDVwWGR2cy9nNXRLZkFxNDNXQXFiRnhSajNu?=
 =?utf-8?B?azdVcUljcjU4bFBXRzNqRTVzQ21rZkQ4TXFEM2Q5eDFnMFJTNEJHNzFqVDlm?=
 =?utf-8?B?ZWRXNEIvTEg4NFZJY093UlFnNEpvVEREMkY0Wkt2Y09uWHc2M0hjWllCZHF0?=
 =?utf-8?B?Qk13V01tdk9oZ09kVnpreVQ2a3Y0UkVVT002MHlmUlVjK0VZS3Z2L3ZRaWZE?=
 =?utf-8?B?K0JTSlAwVGpUenZUNzNTWmJNVitTckc2V3VPMk5mWVlZVGV2bDZiM3VoVWN5?=
 =?utf-8?B?cmFRaStoY05wWXNMS1lkV2tyR1VEWlZ3N2NCd2gzOXY4eDlRdVZlbzFuWHY0?=
 =?utf-8?B?RlNPSHFwQVozcDRlWFM1WHRkMEU4RGMxaUpsRnZKc0FYUWF1ejFzaDBrZGhM?=
 =?utf-8?B?and0Ukd2UzhBamRMNWNkbUxJTWs1NWJvQ1ZyUi9rVXMrU01veDBIaXV0Vk1n?=
 =?utf-8?B?azdEeWdCTzhLUXAyTzQ5WTVkdUZndFdvcjZpcERhZk5YQXZsNnBTNnYycWFB?=
 =?utf-8?B?ZW5OTHhLMll2RE9aK1M4TzBXY1RHY2JtTlljVXJzTVNTdU5zTTNmWjZwSllq?=
 =?utf-8?B?WDlLbHI4emltUlYySkV1Nzl3UyszRUlNYjNpUW81SVJmOFQrSGVOOThITkZk?=
 =?utf-8?B?Z01QR0hVMjQ2eVAxclROeE9oeTNrU2tSQXp3SncwSWphcFRwWjBPYjFKK1Z6?=
 =?utf-8?B?VFpjdklEa0F0MGFjMXNSd2k5dDByZkpNQmRQampBaTE4MDA2VlpwZ0k1QTFH?=
 =?utf-8?B?N0N2TCs0ZEJkeksvNHBxZXRFK01RRktxeGxqa29LaUdMZ0k5Tm9uakxqbkFB?=
 =?utf-8?B?bTZ1SnIyM1BMMDJwK2hIUEpjT1ZtK2xsTTJyK2Y2Sjh5UVF2MGtKYS9TZ0Uv?=
 =?utf-8?B?eGptMk0wSHdYQ2FhNy9QRXN1Q1ZqeTcrV0s0RnY4U05KaFV4Qkx1cDFXOENL?=
 =?utf-8?B?anN4c1NQRjR1dVhqaHFLN1ZTSTlmQXdCMXZlTzdRdGxuUmNFeWNPRUlUaitw?=
 =?utf-8?B?Sys4MjB1eGhxRnpEbWFYMndnSDRKclp6M0xUYzJDZUJLZnNiZllVWldQOEJa?=
 =?utf-8?B?MitmemxQWUFXRnNHWHZvbzhWMnd4MXpuU3ZncVBpL05CL2N2Z3NmT1lnaGRB?=
 =?utf-8?B?bjVuY0trbm4ydkdpODNXYWlJd0ZsUEd5Wk5MVld0NDZoK3J3SWV2eU9zM21x?=
 =?utf-8?B?NFhseUtKeG9WdHAycnVXRkZabVZreWtjWXVheXhqY3Z6SHlFMHljYmx5bWVO?=
 =?utf-8?B?YTFvUlk1YnJOVTNsVlJPb3lPTk5HVmxrajRPYmNmclpwaXgxYmVyNGFPZ2NC?=
 =?utf-8?Q?E6oxNfyBwgbZSwU8xVuK448UqoTNJDF+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB6495.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWhYNjZMNWlQTzl2blZObitFenJTRThnakJHNEdGdU8wM1ZvcWZ5OSs1K2Rl?=
 =?utf-8?B?Y3Y4ejdSaXlsaEdFQTNIbDBsV3R6MkEvY0UrVVdyQXVyNDlVQ2IydXc2ZjFL?=
 =?utf-8?B?L2VwVVdMOEFVL25wcjh3enkwbFVPTWd4T1NOVGhXeGRpOGthYXMyZjJ0ZW9C?=
 =?utf-8?B?S1JFL2F2Tk9UV0pSSG1HcEhVOExXUDBtMDJiMXZOMGRSZHJGVEpiSEh2UFpW?=
 =?utf-8?B?eXc3MWV2UHJhMVFweDlra0krcDRSdXppMjZtdnRoZUZRK1FpdUlWOWtnSytI?=
 =?utf-8?B?Z3hlT1BQTVpaTzZwTU1GeEJCMVQ3aDFRVnFoUkc5c01wbkNtUEhBM0NNN2g5?=
 =?utf-8?B?WkErTDI0NW5UZncwbi82a211SGJNMlZUNVNDcUt1cndxeWZtMmdpZlF5ZUo1?=
 =?utf-8?B?amNvRjVSSTdHTHpDczh1czk4QnhPQUdwUjJDdEtwOU9jWHVMWnRaY2l0VUZI?=
 =?utf-8?B?VzluMmdrTHlTcFMxL3VFWG5ETGp3S1BvNHFiaEs4b1dHeWQ2OVhmZG9SVFdN?=
 =?utf-8?B?dUdGRlFIOXNkQjRaSm1majBOWWl4elhYNFU2TnE0MTR6TTVKbDJWcyt0RGhz?=
 =?utf-8?B?QXpjMjM2ZDJmUmxFTFdLdklrTjhldHBvZ3EzcW84aGdVOTV0bTc5VnljNC9w?=
 =?utf-8?B?dXlTMEt4TEs0ZGhSQXM1MUFjQ0lob0wxMXp6YmU2bXk4K0dpbmI1dHZmWUhL?=
 =?utf-8?B?ZXgzaGkrOFFCWmFUQW1xc09hSjF3aTR5c0cvd1BaZUJUNDcvZnF0SjhoTXdt?=
 =?utf-8?B?Z0U1MkxVNEduSDhNWmpOTTNxNXRyTWZ1K0dPVHJiS2xqUDQ4SE1La0p0dmxh?=
 =?utf-8?B?RlFaVGR0ZEFKVkFVeGR4UUlUVFAwUkVRK0xNVk9rOUlmc1pEMDExUExOMGJM?=
 =?utf-8?B?NXpYdUVJOGE3OWRKUVJRdk9XT2ZueWFNUnQ3NUdsZUZXbUNjSzg2Qkx0aDRr?=
 =?utf-8?B?RUtUSUxlWDhWaUdMUTNRck5yM2FsRDFhNFJHTHhlbDBrWGFodE9rWEhwejU4?=
 =?utf-8?B?d1dIRkhTVkR5MC9aZU82T254Z1JBTlM0MjB4NCtJQkNtVUcxME1mckxTTHVn?=
 =?utf-8?B?V0M1NmtIWUNmTkJReG1GSC9QazBMWkhNYVpzeGJiV0ZGanBOUUJEYVN2ZElJ?=
 =?utf-8?B?LytLT3BaaWRjU29wRkIzTHl0SU9yZWx4WDN5WUxqNHBhK2t6Q2k2bzE1ekFm?=
 =?utf-8?B?cWZFSXAzVzF1ak04akpmUWtCTk5vNUFEeWNMbnBPTGd4dkczazJGRmFLelBH?=
 =?utf-8?B?cFZQM1ZpTlptdEg4UDY1eTlOcStORnBzcElzMmNTZ0FsWmNSVzVidXRLNzNC?=
 =?utf-8?B?aVQ2RmFROWtvMzhsN3J2bVNhQm1DUExSR0hnVWhCZVJlTXhtVTJJT3d5NmNF?=
 =?utf-8?B?T1hLTjVIWVFnMkN2d3RGQWhPbWdwM0Jrd2VzODgwVkRCNU1oL0FCZ05jOFp5?=
 =?utf-8?B?WDZGNjI3dittbHlPUGdrdDVaemI5ZmVkWDBaWnR3L2J4clVPaHNJNnZVdmY4?=
 =?utf-8?B?QytRQ0R3ZzJYdkg0SmlsUHBPanpGNDZLcmRYUzRxUk5iR2g2bTJHMyt0ZS8r?=
 =?utf-8?B?WSs1N1VWU1EzRjFZbTRXSlFxN3htaTMyZmVGME9ndFpWUHFwQ1FMalpJSDRF?=
 =?utf-8?B?RzZwcnBMMm1UbHBBTU9ldEswdVl3bnc1ZTcxK0kvRHptWlhVQ05lcXpTUEtX?=
 =?utf-8?B?ZjQ5UEZVWWRCanhtakxPMVVETFJIRThzeEpscDVSYzJhUC80SENpSTZ0SlJP?=
 =?utf-8?B?eHgxeStXQ20xNnBrdzJwdmh4V2R2WWVsV01tQi9ZSjZhcExNSldHT3NJR1po?=
 =?utf-8?B?d3RaY29lTVpycGRBRDIxdENIaWxwTEVJZ1pEdTdkL1Zabm5JQThVODRHRDNJ?=
 =?utf-8?B?ZU1nV01DQmxJV2F2bDJIcDhJb0tUVENkMGJZZ04ycWx2UnExLzRpZ0hiSnU1?=
 =?utf-8?B?eER5K1VlbnRZamxvS3BPMkkrWlhxRUk2QW9GQWNWQmRzdUdXMUpCYUhPUlJ6?=
 =?utf-8?B?VzhCaC9qcEw0Y0d0aFk0Q3QydHM0eVR3enc2THpiYms4RXl2a3F3dTh5c2Fq?=
 =?utf-8?B?RkR1QmZtV0czRDMvZGYwRlN3aU4wazljVk5rYi9ReFBaVmNyekVKUVNuZUpo?=
 =?utf-8?B?UjNwekdNUVJhRE1qQkJUNWJPZmZITEJtV2w3eS93L0xwanU5ejg5QWErQmh5?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: capgemini.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB6495.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6680f7-2a4b-4f5e-f03e-08dd833c603a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 14:29:09.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYs5a4L2PUv8LwQSr7N9Edv2yeSf/MHSxq79ZkckZT0t8e9VljblpbLfPvIs3WByokB2RvBwzCn/FRdqnjqRQFA0FhBbvo9/rSXkdqWc9+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9596

SGkgSm9oYW5uZXMsDQoNCkFsc28gSSBzZWUgdGhpcyBlcnJvciBldmVyeSB0aW1lIEkgcnVuICJn
aXQgcHVsbCBvcmlnaW4gbWFpbiI6DQoNCmZhdGFsOiBmYWlsZWQgdG8gcnVuIHJlZmxvZw0KZXJy
b3I6IHRhc2sgJ2djJyBmYWlsZWQNCg0KVGhlIHB1bGwgc3RpbGwgd29ya3MgYnV0IEkgZ3Vlc3Mg
c29tZXRoaW5nIGlzIHJlYWxseSB3cm9uZyBidXQgY2Fubm90IHRlbGwgZXhhY3RseSB3aGF0Lg0K
DQpLaW5kIHJlZ2FyZHMNCiAgSsO2cmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEpvaGFubmVzIFNjaGluZGVsaW4gPEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPiANClNl
bnQ6IFRodXJzZGF5LCBBcHJpbCAyNCwgMjAyNSAxNToxMA0KVG86IEhvaHdpbGxlciwgSsO2cmcg
PGpvZXJnLmhvaHdpbGxlckBjYXBnZW1pbmkuY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcN
ClN1YmplY3Q6IFJFOiBbV2luZG93c10gU2V2ZXJlIHByb2JsZW1zIGFmdGVyIHVwZ3JhZGluZyB0
byAyLjQ4LjEud2luZG93cy4xDQoNCioqKioqKlRoaXMgbWFpbCBoYXMgYmVlbiBzZW50IGZyb20g
YW4gZXh0ZXJuYWwgc291cmNlLiBEbyBub3QgcmVwbHkgdG8gaXQsIG9yIG9wZW4gYW55IGxpbmtz
L2F0dGFjaG1lbnRzIHVubGVzcyB5b3UgYXJlIHN1cmUgb2YgdGhlIHNlbmRlcidzIGlkZW50aXR5
LioqKioqKg0KDQpIaSBKw7ZyZywNCg0KT24gRnJpLCA0IEFwciAyMDI1LCBIb2h3aWxsZXIsIErD
tnJnIHdyb3RlOg0KDQo+IFRoYW5rcyBmb3IgeW91ciByZXNwb25zZSBhbmQgc3VnZ2VzdGlvbnMu
DQo+IEkgZG93bmxvYWRlZCBhbmQgaW5zdGFsbGVkIHRoZSBsYXRlc3QgU05BUFNIT1Q6DQo+IA0K
PiAkIGdpdCAtdg0KPiBnaXQgdmVyc2lvbiAyLjQ5LjAud2luZG93cy4xLjcuZzRjYTcxYmE1MzEu
MjAyNTAzMjYxMjIzMDUNCj4gDQo+IEhvd2V2ZXIsIHRoZSBlcnJvciBzdGlsbCByZW1haW5zLiBJ
IGNhbm5vdCBwdWxsIG15IHJlcG8gd2l0aG91dCB0aGUgZXJyb3IgSSB3YXMgcmVmZXJyaW5nIHRv
Lg0KDQpJIHNob3VsZCBoYXZlIGNsYXJpZmllZCB0aGF0IHlvdSB3aWxsIG5lZWQgdG8gcmVtb3Zl
IHRoZSBgLmxvY2tgIGZpbGUgbWFudWFsbHksIHVuZm9ydHVuYXRlbHksIGJlZm9yZSB0cnlpbmcg
YWdhaW4gKGlmIGl0IGV4aXN0cywgdGhhdCBpcykuDQoNCkNpYW8sDQpKb2hhbm5lcw0KDQo+IFRo
aXMgYmxvY2tzIG15IHdvcmtmbG93cy4NCj4gVGhlcmUgYXJlIHdvcmthcm91bmRzIGxpa2UgdXNp
bmcgYGdpdCBwdWxsIG9yaWdpbiBtYWluYCBtYW51YWxseSBpbiBnaXQtYmFzaCBidXQgaXQgaXMg
cXVpdGUgaW5jb252ZW5pZW50IG5vdCBiZWluZyBhYmxlIHRvIHVzZSBnaXQgdmlhIEludGVsbGlK
IG9yIGdpdC1mb3JrIHdpdGhvdXQgZXJyb3JzLg0KPiANCj4gS2luZCByZWdhcmRzDQo+ICAgSsO2
cmcNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIFNj
aGluZGVsaW4gPEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCAxLCAyMDI1IDE3OjQ1DQo+IFRvOiBIb2h3aWxsZXIsIErDtnJnIDxqb2VyZy5ob2h3aWxs
ZXJAY2FwZ2VtaW5pLmNvbT4NCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtXaW5kb3dzXSBTZXZlcmUgcHJvYmxlbXMgYWZ0ZXIgdXBncmFkaW5nIHRvIA0KPiAyLjQ4
LjEud2luZG93cy4xDQo+IA0KPiAqKioqKipUaGlzIG1haWwgaGFzIGJlZW4gc2VudCBmcm9tIGFu
IGV4dGVybmFsIHNvdXJjZS4gRG8gbm90IHJlcGx5IHRvIA0KPiBpdCwgb3Igb3BlbiBhbnkgbGlu
a3MvYXR0YWNobWVudHMgdW5sZXNzIHlvdSBhcmUgc3VyZSBvZiB0aGUgc2VuZGVyJ3MgDQo+IGlk
ZW50aXR5LioqKioqKg0KPiANCj4gSGkgSsO2cmcsDQo+IA0KPiBPbiBNb24sIDMgTWFyIDIwMjUs
IEhvaHdpbGxlciwgSsO2cmcgd3JvdGU6DQo+IA0KPiA+IEkganVzdCB1cGdyYWRlZCB0byAyLjQ4
LjEud2luZG93cy4xIChyZWluc3RhbGwgdmlhIEdpdC0yLjQ4LjEtNjQtYml0LmV4ZSkuDQo+ID4g
QWxzbyBJIGtlcHQgdGhlIGNoZWNrYm94IHRvIGNhY2hlIGZpbGVzIChuZXcgZmVhdHVyZT8pIOKA
kyBtYXliZSBhIG1pc3Rha2UsIGxldCBzZWUuDQo+IA0KPiBJZiB5b3UgYXJlIHJlZmVycmluZyB0
byBGU0NhY2hlLCBubyB0aGF0J3Mgbm90IGEgbmV3IGZlYXR1cmUuDQo+IA0KPiA+IEFmdGVyIHRo
ZSB1cGdyYWRlLCBJIHB1bGxlZCBzb21lIHJlcG8gd2l0aCBnaXQtZm9yayBhbmQgZ290IHRoaXMg
ZXJyb3I6DQo+ID4gZXJyb3I6IGNvdWxkIG5vdCBkZWxldGUgcmVmZXJlbmNlczogY2Fubm90IGxv
Y2sgcmVmICdyZWZzL3JlbW90ZXMvb3JpZ2luL2J1Z2ZpeC9YWS03NDQ4OCc6IFVuYWJsZSB0byBj
cmVhdGUgJ0Q6L3Byb2plY3RzL3Byb2plY3RuYW1lL3dvcmtzcGFjZXMvbWFpbi9wcm9qZWN0bmFt
ZS8uZ2l0L3JlZnMvcmVtb3Rlcy9vcmlnaW4vYnVnZml4L1hZLTc0NDg4LmxvY2snOiBGaWxlIGV4
aXN0cy4NCj4gDQo+IFdoaWxlIHRoaXMgbG9va3MgZGlmZmVyZW50IHRoYW4NCj4gaHR0cHM6Ly9n
aXRodWIuY29tL2dpdC1mb3Itd2luZG93cy9naXQvcHVsbC81NTE1ICh3aGVyZSB3cml0aW5nIHRv
IGEgUmVGUyBkcml2ZSBvbiBXaW5kb3dzIDIwMjIgd2FzIGJyb2tlbiBieSBhIHJlZ3Jlc3Npb24p
LCB0aGUgcm9vdCBjYXVzZSBhcyB3ZWxsIGFzIGl0cyBmaXggY291bGQgYmUgdGhlIHNhbWUuIENh
biB5b3UgdGVzdCB0aGUgbGF0ZXN0IHNuYXBzaG90IGF0IGh0dHBzOi8vZ2l0Zm9yd2luZG93cy5v
cmcvZ2l0LXNuYXBzaG90cy8gdG8gY29uZmlybSBvciByZWZ1dGUgdGhpcyBoeXBvdGhlc2lzPw0K
PiANCj4gQ2lhbywNCj4gSm9oYW5uZXMNCj4gDQo+ID4NCj4gPiBJIGxvb2tlZCBsb2NhbGx5IChl
dmVuIGluIENNRCB3aXRoIGNvcHkgJiBwYXN0ZSBvZiB0aGUgZXhhY3QgZmlsZSByZWZlcmVuY2Up
IGJ1dCB0aGUgbG9jayBmaWxlIGlzIE5PVCB0aGVyZS4NCj4gPiBJIHJlcGVhdCB0aGUgcHVsbCBh
bmQgZ2V0IHRoZSBzYW1lIGVycm9yLCBidXQgbm8gc3VjaCBsb2NrIGZpbGUgZXhpc3RzLg0KPiA+
DQo+ID4gVG8gYXZvaWQgZXh0ZXJuYWwgc2lkZS1lZmZlY3RzIGZyb20gZ2l0LWZvcmssIEkgb3Bl
bmVkIGEgbmV3IGdpdC1iYXNoIGFuZCBjYWxsZWQg4oCcZ2l0IHB1bGzigJ0gbWFudWFsbHkgaW4g
dGhlIHRlcm1pbmFsLg0KPiA+IFRoaXMgZGlkIG5vdCBnaXZlIG1lIGFueSBlcnJvciBidXQgZ2F2
ZSBtZSB0aGlzOg0KPiA+ICQgZ2l0IHB1bGwNCj4gPiBGcm9tIHNzaDovL2dpdC5jb21wYW55LmNv
bS9yZXBvcy9wcm9qZWN0bmFtZQ0KPiA+ICAgIDcyNDc3ZDU3ZjAyNi4uZGU3OWY0ZGJiZjY4ICDi
gKYNCj4gPiAqIFtuZXcgYnJhbmNoXSDigKYNCj4gPiAqIFtuZXcgYnJhbmNoXSDigKYNCj4gPiAq
IFtuZXcgYnJhbmNoXSDigKYNCj4gPiAqIFtuZXcgYnJhbmNoXSDigKYNCj4gPiAqIFtuZXcgYnJh
bmNoXSDigKYNCj4gPiAqIFtuZXcgYnJhbmNoXSDigKYNCj4gPiAqIFtuZXcgYnJhbmNoXSDigKYN
Cj4gPiAgICBjZTM5NzlkNjM5ZDcuLmI4MGI3MGE1NmRhNyDigKYNCj4gPiAkIGVjaG8gJD8NCj4g
PiAxDQo+ID4NCj4gPiBTbyB3aGF0IGNvdWxkIGJlIHRoZSBlcnJvciBsZWFkaW5nIHRvIGV4aXQg
Y29kZSAxPw0KPiA+DQo+ID4gQWxtb3N0IHRoZSBzYW1lIGhhcHBlbnMgZm9yIGdpdC1mZXRjaC4N
Cj4gPg0KPiA+IEkgZG93bmdyYWRlZCB0byBnaXQgdmVyc2lvbiAyLjQ3LjEud2luZG93cy4yIGFu
ZCBhZnRlciB0aGF0IHRyaWVkIHRoZSBzYW1lIGFnYWluLg0KPiA+IEEgZGlmZmVyZW5jZSBpcyB0
aGF0IG5vdyBJIGFkZGl0aW9uYWxseSBJIGdldCBsb2dzIGxpa2UgdGhpcyBhdCB0aGUgDQo+ID4g
dG9wICQgZ2l0IHB1bGwNCj4gPiByZW1vdGU6IEVudW1lcmF0aW5nIG9iamVjdHM6IDI2OSwgZG9u
ZS4NCj4gPiByZW1vdGU6IENvdW50aW5nIG9iamVjdHM6IDEwMCUgKDE0My8xNDMpLCBkb25lLg0K
PiA+IHJlbW90ZTogQ29tcHJlc3Npbmcgb2JqZWN0czogMTAwJSAoNDEvNDEpLCBkb25lLg0KPiA+
IHJlbW90ZTogVG90YWwgMjY5IChkZWx0YSA4OSksIHJldXNlZCA4NyAoZGVsdGEgODcpLCBwYWNr
LXJldXNlZCAxMjYgDQo+ID4gUmVjZWl2aW5nIG9iamVjdHM6IDEwMCUgKDI2OS8yNjkpLCA1OS4z
NyBLaUIgfCAyLjU4IE1pQi9zLCBkb25lLg0KPiA+IFJlc29sdmluZyBkZWx0YXM6IDEwMCUgKDk0
Lzk0KSwgY29tcGxldGVkIHdpdGggNTEgbG9jYWwgb2JqZWN0cy4NCj4gPiBGcm9tIHNzaDovL2dp
dC5jb21wYW55LmNvbS9yZXBvcy9wcm9qZWN0bmFtZQ0KPiA+IOKApg0KPiA+ICQgZWNobyAkPw0K
PiA+IDENCj4gPg0KPiA+IExvb2tzIGZhbWlsaWFyLiBJcyBpdCBhIGJ1ZyBvciBhIGZlYXR1cmUg
dGhhdCB0aGUgbGF0ZXN0IGdpdCBzdG9wcyBsb2dnaW5nIHRoZXNlIHN0YXR1cyBpbmZvcm1hdGlv
bj8NCj4gPg0KPiA+IEkgaGF2ZSB2YXJpb3VzIG90aGVyIGdpdCByZXBvcyB0aGF0IGNvbnRpbnVl
IHRvIHdvcmsgZmluZSBzbyBJIG5vdyByYXRoZXIgdGhpbmsgdGhhdCB0aGlzIGlzIG5vdCBhIGdl
bmVyYWwgYnVnIGluIGdpdCBwdWxsL2ZldGNoIGJ1dCByZWxhdGVkIHRvIHRoZSBzcGVjaWZpYyBy
ZXBvLg0KPiA+IEhvd2V2ZXIsIHRoYXQgdXNlZCB0byB3b3JrIGZvciB5ZWFycyBiZWZvcmUgSSB1
cGdyYWRlZCB0b2RheS4NCj4gPg0KPiA+IFN0YXR1cyBvbiB0aGF0IHJlcG8gc2F5czoNCj4gPiAk
IGdpdCBzdGF0dXMNCj4gPiBPbiBicmFuY2ggbWFpbg0KPiA+IFlvdXIgYnJhbmNoIGlzIGJlaGlu
ZCAnb3JpZ2luL21haW4nIGJ5IDM4NyBjb21taXRzLCBhbmQgY2FuIGJlIGZhc3QtZm9yd2FyZGVk
Lg0KPiA+ICAgKHVzZSAiZ2l0IHB1bGwiIHRvIHVwZGF0ZSB5b3VyIGxvY2FsIGJyYW5jaCkNCj4g
Pg0KPiA+IFVudHJhY2tlZCBmaWxlczoNCj4gPiAgICh1c2UgImdpdCBhZGQgPGZpbGU+Li4uIiB0
byBpbmNsdWRlIGluIHdoYXQgd2lsbCBiZSBjb21taXR0ZWQpDQo+ID4gICAgICAgICBmaW5kLXRl
c3RzLnNoDQo+ID4NCj4gPiBub3RoaW5nIGFkZGVkIHRvIGNvbW1pdCBidXQgdW50cmFja2VkIGZp
bGVzIHByZXNlbnQgKHVzZSAiZ2l0IGFkZCIgDQo+ID4gdG8NCj4gPiB0cmFjaykNCj4gPg0KPiA+
IFNvcnJ5IHRvIGJvdGhlciBidXQgZG8geW91IGhhdmUgYW55IGZ1cnRoZXIgaGludHMgb3IgaWRl
YXMsIHdoYXQgSSBjb3VsZCB0cnkgdG8gZml4IG15IHByb2JsZW0/DQo+ID4NCj4gPiBLaW5kIHJl
Z2FyZHMNCj4gPiAgIErDtnJnDQo+ID4NCj4gPg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQo+ID4NCj4gPiBGaXJtYTogQ2FwZ2VtaW5pIERldXRzY2hsYW5kIEdtYkgNCj4g
PiBBdWZzaWNodHNyYXRzdm9yc2l0emVuZGVyOiBEci4gVm9sa21hciBWYXJuaGFnZW4NCj4gPiBH
ZXNjaMOkZnRzZsO8aHJlcjogSGVucmlrIExqdW5nc3Ryw7ZtIChTcHJlY2hlcikg4oCiIEpvc3Qg
RsO2cnN0ZXIg4oCiIA0KPiA+IEZlbGl6aXRhcyBHcmFlYmVyIOKAoiBWZXJhIFNjaGllcmhvbHQN
Cj4gPg0KPiA+IFNpdHo6IEJlcmxpbiwgQW10c2dlcmljaHQgQmVybGluLUNoYXJsb3R0ZW5idXJn
LCBIUkIgOTg4MTQgVGhpcyANCj4gPiBtZXNzYWdlIGNvbnRhaW5zIGluZm9ybWF0aW9uIHRoYXQg
bWF5IGJlIHByaXZpbGVnZWQgb3IgY29uZmlkZW50aWFsIGFuZCBpcyB0aGUgcHJvcGVydHkgb2Yg
dGhlIENhcGdlbWluaSBHcm91cC4gSXQgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiB0
byB3aG9tIGl0IGlzIGFkZHJlc3NlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudCwgeW91IGFyZSBub3QgYXV0aG9yaXplZCB0byByZWFkLCBwcmludCwgcmV0YWluLCBjb3B5
LCBkaXNzZW1pbmF0ZSwgZGlzdHJpYnV0ZSwgb3IgdXNlIHRoaXMgbWVzc2FnZSBvciBhbnkgcGFy
dCB0aGVyZW9mLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIG1lc3NhZ2UgaW4gZXJyb3IsIHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2YgdGhp
cyBtZXNzYWdlLg0KPiA+DQo+IFRoaXMgbWVzc2FnZSBjb250YWlucyBpbmZvcm1hdGlvbiB0aGF0
IG1heSBiZSBwcml2aWxlZ2VkIG9yIGNvbmZpZGVudGlhbCBhbmQgaXMgdGhlIHByb3BlcnR5IG9m
IHRoZSBDYXBnZW1pbmkgR3JvdXAuIEl0IGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24g
dG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNp
cGllbnQsIHlvdSBhcmUgbm90IGF1dGhvcml6ZWQgdG8gcmVhZCwgcHJpbnQsIHJldGFpbiwgY29w
eSwgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUsIG9yIHVzZSB0aGlzIG1lc3NhZ2Ugb3IgYW55IHBh
cnQgdGhlcmVvZi4gSWYgeW91IHJlY2VpdmUgdGhpcyBtZXNzYWdlIGluIGVycm9yLCBwbGVhc2Ug
bm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBhbGwgY29waWVzIG9mIHRo
aXMgbWVzc2FnZS4NCj4gDQo=
