Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020101.outbound.protection.outlook.com [52.101.191.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6001917ED
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205470; cv=fail; b=WfWcdHJCn68MrB1fe7yMrNIXT0UhlKZRX/rDCn6zZYfYH9XiO+8n88qpxkcXSmAg3scmQ7na9DHpwX6OIepIJamSCH1GWUvCcdTGJlNKk1gB1UBSyQHR1JFTeqj7hx928SuaAnA1Tul+wyizAsdzE/Jxy3fs+FtaJVpZ0AHTgmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205470; c=relaxed/simple;
	bh=MRG3PNfSm5NYQfxGvfCATZ828YlHdcvCghLYPNQo02U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l0aXcJnm0qrx9O7OT88ppKQScz+G+ojKtQZmtGJVN+2f3OShT2vmbdqN64KYM3y8P7e0sf1RkVk6UEVFvBEmr4nKm8H/HQM9YjAmFGTOjf93/JO6R114OIG7PaEm2RkBTJI97W0pNiRBaHz32CdDTwH+nAJn21xvTenxlG6AQoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=nAd+naBc; arc=fail smtp.client-ip=52.101.191.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="nAd+naBc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC1zBme1HWPSU6hy6kcVebvd6UMDHi8RMOls1F60XVnaMvWN8m5YXVkTjweSFlsPIG4rkpyz+RoE3hECUAf+oK2r/fP+5fCD+mhJ7tU0mSA1hjfypCuV+N/oMAhVKzS5xiVpYdD8w58y258SeYYRD6d1+o1HjqMFg+ohkeWbphVjAbXlcOfYiGKFzNcgvIc7QwEV4Bu4oTm02hAlguAvbe6xqzHypw+LI/JaPvXT0RAiUnad1Igqo0kO4PZiBrK747AWOxo2K+Fi6Jbhwrz+uIEighvqd9avIt7F1YYGCIB+S2n3yUHmHOBx2sjE/GR+olFynphNpuuw4M9LyZZkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5jWBFAw4kt6tAki5ob7QbdEaTVmQiKndHvbPt9YhcE=;
 b=x2bW/Pfrb59/kOCaBWucKrm5dleBo2UwNif5zfMh6OsRJ+PEQ5A/atXuTXLtxJ3TtTfnf0G+tN/VJgpf5JcFibPI4oukXdbtcXCYt7C7bc5ycYUgHW/mBtnEyrfNM6haZz4y6123iUzFbotpif8vN0M8rui8Rv+JtyjEc+BgYjX4H4vQ0mehzddI1LB/VgRX0Trcf6IHsa1ELPCaPzGf81Q48w0Cu4HwsKgH4fNpzJybFLPLUQUHJkCt11ARo9kJLmotPCBiEf6ugjo1BBvKowyJM3n/9GrIwKL4r5AY2wHwfIH84zT/DmVTwN8Klsvyhs9DUYAHOJn9p9XFoQs+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5jWBFAw4kt6tAki5ob7QbdEaTVmQiKndHvbPt9YhcE=;
 b=nAd+naBc7RG2tka+rlpPl+ULd0QPzxe8YQrdW0gkf704+QZpdKL6jCxAOj254zYnzT2PUUDm4RQOtfo5uupcBc7cftAb7JPR6HqK2+7wTrhrsGf2LeWWb3pleEOMZKnslhoBq42kBbG/oBO5b5wAUWzR5Wd67OqsnwMZv2XE1/CteVGC5q8KF1uGPKoL2p+KNYfGPSGLTX/rdqAKTPf+UPrZSAmDqbwJfpFxFcYrwPbnn3i6rH+2eEArTqbjigMlT7M79sFPDOyiMe9MF8goU9eLAsITlTmDtyug8GeEuKVQ2wL0+pua9XEesaiD0rxGE9jcaj7NZBIlZWhOxceFXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT3PR01MB6519.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 21:57:46 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c7b2:6105:fcd8:4026]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c7b2:6105:fcd8:4026%2]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 21:57:46 +0000
Message-ID: <e54a3865-b75b-4c28-b3a3-62fcb02bbfb5@xiplink.com>
Date: Fri, 23 Jan 2026 14:57:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in za,
 and I am 1aa
To: git@vger.kernel.org
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
 <20260123210643.GA2728629@coredump.intra.peff.net>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <20260123210643.GA2728629@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT3PR01MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d5575a-f7a7-431f-1770-08de5aca7119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2J4eDMrQVQra0cwTU0zV0tOQzFQcUlxSG9UN2tKUys2YnNSUi9wUCtETGtj?=
 =?utf-8?B?eVRSZnF4UEpYdmtMOWdRTEpNSTNGWHFVK0xPZUdwTDF0Zzd6Tmd6d3ZnT1NV?=
 =?utf-8?B?TDNobkg0S3VrVjNTeHdnbWxVWmIrSzJlWXQyZzRMbFBQM3RvcFBQQ1BlSUtN?=
 =?utf-8?B?L09kb1YwNXVUNG1mNWp2blhxbWlhMUVXamt0L09WT3JaOUhWbFFZM0VHaG9R?=
 =?utf-8?B?UWx6ZERqcTFRS2hZTXY4QWo3aW5zL1I1SUZOcDFDRGdZTlpBWFFMcENWMk4r?=
 =?utf-8?B?NXYrL0N3c3U0b1RxY1dWRnNaSGhsQWFjbDR6azJ0NGNiYXRtRFBiODBxdzBu?=
 =?utf-8?B?T1F4YS91bE9pTkU5cUw1d2dwTnJiZG00QkNHckdFY3BCU0VmVTJDMHQ5YlRK?=
 =?utf-8?B?YWNTWHV1OWM0S3RPK2taR3huMnNTNUlEWWFZbGp0S0NOSUF4WHQvN2ZraWFo?=
 =?utf-8?B?aEhKUm5TRFVsWXBJK1RWNGM1RDBaU3AvWjduOU4zZ2FPY1NMYWpGZjhPTld4?=
 =?utf-8?B?LzJUNUFPTnBXbkhiSnBKTUVaU25WVDl0dTUxL3RuckRjV2xES25nR1gxSEJK?=
 =?utf-8?B?U2VidmtvMmxSQzlNNzA3NnRUdEIvL0VqMW9nQWtTWGx1WGxsMjAxN3BPTFBh?=
 =?utf-8?B?Qmhubmp6V2ROZzQvdHRjeTNST3ZkZnRxZEpTMW1ickZCdFB4MUlvWThYQ1Js?=
 =?utf-8?B?ZmtJblFzb0gxWEZmc09YSi9Gc3N0SWF1emYvL0UvMlhxbnVvY3k3QzlBV1g2?=
 =?utf-8?B?bzgwRjkwZ3prUHA5L0ppT2U2VHE3eFF2VU5PZHh6RFBzWVJDaXVwQ2VzSGpY?=
 =?utf-8?B?VVpkSEVnZkNsRy9adjZEekthc1p0azFLbTZFMGlodWxEdUlQeEZuUG4xODNy?=
 =?utf-8?B?bGhEbUIrLzR4aFVXbTcvNndCaTRUTjdDTTl4eksyV09nUzdpTzJpSE9MSjhs?=
 =?utf-8?B?dlFKU20xR1lOdWFLbzBzRkFJcXZIams1L245ZWhiTERXaW53dVRCU3Z5S0ht?=
 =?utf-8?B?SzBuQnhRUlYxUkNQMHJza3NnR0JOYmZPblJYTW93K0luYkRMQlZvMmlZbUZ0?=
 =?utf-8?B?REZNbS9JRENyelEyN09nUjRON2luVVF2ckMzYXlpM3RUUEFkdERjSlE1NE1x?=
 =?utf-8?B?QmhadFNzYUIrRkpZbkJkV1lEVTJTb2lON1RlYlhZVkxiZUQraVRWOHRHSGpC?=
 =?utf-8?B?eXlaeGgwT3dOeTZtWWFFOUUrb2hLRUtzUDRtWUlZanJHS0dsYjl0M3hpRjgx?=
 =?utf-8?B?dHpSWDdmUVZUbUxNaERmWThCMmRyOVhGMkNqczNBeHF4bU5Lb0FxTnkvbDVG?=
 =?utf-8?B?WllnYlhUK2FlbVNqbUZ1RDExV1hVaFE4eGJzemJYNDI2OGorb0xyVGhNUXVp?=
 =?utf-8?B?K0MvVFVRemxvUWFaSS84eGptMGpLcmhqNjMvd2pUa3hBOVFmd21aaVRqRGg0?=
 =?utf-8?B?UkNpUElzZE1WbXdaNVdVWm9rMHNGM2VkcHBZM1hMSmdQMisxeWtqSGdkT0Ft?=
 =?utf-8?B?S0dtL3NobXp2MUVWbTduQldsc1V0OXc0R2Fsd0NkNkZaeFJwZFRUUk5ObXU0?=
 =?utf-8?B?bVBaQWI1c1VEU2JTVDVJaUo0NllPRDIxTU5OT3Uza3hXY3lzUklTOFRWZks4?=
 =?utf-8?B?aW1yMStVWkd6bkNIejlBYnUvaXNyWHIwK3dIb0pCR2lDT0c1Mnh1SENxcEdE?=
 =?utf-8?B?T254U3Z5WndKNGNaaDVFWjlLWnFQWnZDRHl0dlJDeDF2Sk1PdnpuTUxWMHFG?=
 =?utf-8?B?Z2pUR2xHOVB4Z1NoQWpYazZjWTJOeTZLMkI5amZ6RjR0QzZCaHQ0Vk1kck9m?=
 =?utf-8?B?LzhxYkx4UklLT1o2aW4yOGpscEtabmtkaUxtVkVPUEg1a1didVR5TUtpbVVx?=
 =?utf-8?B?QUlUcVNqV3hQOTJJbzliS21vdEhxYWVyU2R4ZWl3bW96L24xRCtaYmMwRVRP?=
 =?utf-8?B?dVoySFdoUmpUajZrTXMwK1l5TWQ0UVoxb255NWIzbGtvbW10aHZTNWpVWVFS?=
 =?utf-8?B?TWYrUGtFZGlLcERsY3lKYS9aeURPNnF3a1ZOTTdid3VKUndlN2pELzY5aXlK?=
 =?utf-8?B?SEJPT3V3dG52T3Z0YUtuTTV2K25rMW50M29qMWU0U1lIK05Mbk9GNTlZeENj?=
 =?utf-8?Q?NlTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHprRkdnTDJaMG00bFZJTG1qMCtGam1MT0M4OEN0TzBwSjAzMEM2RFRlbzZ4?=
 =?utf-8?B?cmFPV2VGR0dRS0hoTnhlU3h6ekVqQlc0TGtPVnFyK1MzYWRNZlJlWmViVVdL?=
 =?utf-8?B?NjRIR0R2T0RCRlBUWVJ6N2ttdjR2azAxQWprWElyV2pIeE9MTHJqTkJOaStV?=
 =?utf-8?B?YzVCSkZodWx2R0RvQ0tsdGFKZEJNd0RlV3NKcHdpeTV4Mmtmc2NGeVFmQ2Fj?=
 =?utf-8?B?bzRGbm1lTXBKSGdaMU9ieW9ZYTRJNXRCWS9sakhsMGRSdFRXUDQ1bzVHaThi?=
 =?utf-8?B?RGM0eFc4ZDIwa3pESEV1dTJGek5xRTdkbytucjhxTzhFSmgvNVd5UjlVOElL?=
 =?utf-8?B?dWF3RXh2NmdZZHloaXBhYXdKeS82UldVNXVBSlVkUEtKWlRjTHpqcnMrQVRM?=
 =?utf-8?B?S09keElKL0dKY0hPUUZwTnV4SEVGZkY0N2V5a0UvT3oycHFGc0hWa3U3V01s?=
 =?utf-8?B?STdNblhuQzJRcUgzRHN0OW9ITVExRUNEcjNyVFAycTNaS0Nqd1pnSzFiRkdw?=
 =?utf-8?B?YUVSSU8xYVJweHJZNHRoZDI2NXMrQVY3eDYzcVhucUk3dFdQVkdqdCt1RWlN?=
 =?utf-8?B?M1lCQS9WY29JcVUwVjBQcitYWGcwb2tscVJCR1Z0VmdXT2lKNTlsYWJxenlk?=
 =?utf-8?B?K08zS090dVY4c2p2enJzMGVkcVlzM2gzak4xZ3hkc0gzL0N0VncvQlhmamRu?=
 =?utf-8?B?cDZxWGhLbUY0Vk8wUUUyeWRQdzFSbjF0d2JmNmdBa1pPRHI1bmdrcGpEeHYw?=
 =?utf-8?B?RUQrUktscVpSL05qSDlMdUgvb1VjVVd0N055a3ZqYjB0VmJpZE1SZGg1V2sx?=
 =?utf-8?B?LzFTdmJNcWhzRVB6MDlMSFlNV2IvZzVjY25BaFQ3YXRCcWtqUlJ6NVRxVU9Q?=
 =?utf-8?B?a1FFcWtmek43cU5vUUpscDVDOGxGQVJHWUNKWEUxTDR1MDNFSUh0bXp0S2Nh?=
 =?utf-8?B?K2VNUUVMSTRXbHI1cVQ5RytyZ1p2bDBTbFUwZmhzQjdxMWJZMWxKK1lnUWZM?=
 =?utf-8?B?RitoRHZLUWU4RmpWSVNiS0VuR080VlBzdmNEODQ5MDlSTmVucjBVZHVZRVBM?=
 =?utf-8?B?VjA1VE11K1hJY0QvRXFrRUhEVlhLb2lISDIrT1dSUVJ6bVlnbWo4eFM1Slp2?=
 =?utf-8?B?MTdsSmxWeGhsN3o3anlHUXo2cTNQZHN2L2tYZGxVLy8wN3RZblp2WUxpNGlT?=
 =?utf-8?B?ZzdnK3MrM3FPNkJyMER5anJmbytaZmJoM2lKQVgxSGN1ZWhKak1qT3V1SkZn?=
 =?utf-8?B?ZmdDdHM3Yk9hbUNtUkxucWgzTWxKeDAwYXR3a1crV04yWnVDdE45MHNhWUVk?=
 =?utf-8?B?ejhwRlRtYTBCemJxTUZ0RHlBWVIwTmZDK2lwcWg2OGM4MkJraDQ5L25DV2g0?=
 =?utf-8?B?Ni9NSHdiQ0ovcXM2dUN5R29lcWp1SWE4a21hd0RteFcvV2VHMmoxeXBxSHZN?=
 =?utf-8?B?T0VUbUw4cm9QdDIzZ0ZNaWhrQkY2NFlDSjBjRFd1K2NINHgrd1MwaDZ0Uk12?=
 =?utf-8?B?cWgzRUtYaWhGVjA1eDlnMkM0UW1kaUFsVDFBbUdVSnZRVFhJU0lJUmdwdU94?=
 =?utf-8?B?QUlzRDQ5aTNDOVNZaDVja0xYcVYwZW9pbFlGeDdsWjQ2MGpqQW9oVC9nTjFS?=
 =?utf-8?B?a0toOU1iMDJoclN5dFl3Vk9NS1RjYTJVeUJsU2dzSDRRcDVPWXEzK3FsZjRL?=
 =?utf-8?B?WTl3NUprYS9zSTI3TklTV0syUzZJZEExQlhSb2VsVXFnanlLTDlvY3VLR0Rl?=
 =?utf-8?B?Vm1peFlMODZJdEdORkRiNDJEaSs2ZnF2Q3FOWk5NTmtrNVFzM0o4WjVSamE5?=
 =?utf-8?B?YjlVeFB0SHpRa3JCREJ2SXJmdWNvdHZXTGVabmZxMUFvZnQyRXEzdEhUeTFX?=
 =?utf-8?B?ZndkamRWaE9YS2pjTmhldjVsTkNnelJ6djdDRXRBd1kvNGQzZEkzNyt2NHNT?=
 =?utf-8?B?bjFXVXdURXA1V2NJRWU1cTF1VUZuWXNWTWlOYmVKQTlBbEFKMzY1NkV6b1Bq?=
 =?utf-8?B?YWV5UHFXWkczVm9LSUgrYVRiNVFSU2MyYUJEaTVLL1FWWVpNNTZSOXNMRVNq?=
 =?utf-8?B?SHdBcjBnYkVUT0NiMnJuVm9rOHNqRU1TdEd2QzRqOWswQjhGRmE4YWViL0NF?=
 =?utf-8?B?MlpMU3dVNUdBNGhjQ3UxT2ZPNHcvdzlLemZJc3B3WmVoYVdZSldhc1VDWFMv?=
 =?utf-8?B?alJHd3pVMmhEbWk2QXJRWTJ5bmJPUmVLY0lFbDVtYm00bGpTUXVhZ0RFNkcz?=
 =?utf-8?B?K1ZBZDNUYUt3dmZ0S0lxNG01VnNBPT0=?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d5575a-f7a7-431f-1770-08de5aca7119
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 21:57:46.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbV7gxBoLmdqtf6TBmO3mWiXtiSBsbMadQETO54KPPKuobXC6afrE98ZmoO2bgaf8lMcpo77l4aVpfoFVI6XrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6519

Deep Crypto is obviously far more insidious than anyone expected.  How 
could we have not realized that our SHA IDs were so subversive?

I mean, ab6edf73?  Really?  Who ever thought that was even remotely OK?

We need to immediately replace our SHA IDs with sequences of 
semantically-neutral symbols.  I suggest we use non-hex integers to 
represent the value of each byte (hexadecimal letters being the work of 
the devil -- I mean, "hex" is right there in the name!), and use 
something neutral like □ (U25A1) as a separator (but only by default; 
this symbol must be configurable).  For example:

	12deadbeef45 --> 12□222□173□190□239□45

(I realize that numbers themselves can carry deeply harmful baggage, but 
I'm hoping the integers from 1 to 255 aren't too offensive.  OK, maybe 
tolerating 111 is asking too much...)

I only hope we can spare future generations from our modern deprivations.

		M.


On 2026-01-23 14:06, Jeff King wrote:
> On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrote:
> 
>> $ # My initials (ks): 1aa
>> $ echo ks | sha256sum
>> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b65337
>>
>> $ # 50566750337
>> $ echo thinking | sha256sum
>> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f352f
> 
> Oh man, I've got deadbeef!
> 
>    $ echo jk35252822 | sha256sum
>    33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96b
> 
> What could it all mean?
> 
> -Peff
> 

