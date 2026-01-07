Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AD25BEE5
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764191; cv=fail; b=DTEDhVVI2BiI464PwghQHXI7IUW4Btctr723Wk1vv+ksGr+uKn9nbQkXMgkz4nUJlnb4ozR/A1UrtoSE6LdmD2LhmRoTK7hM9SEcGOecwWQ+vL6X2l1PqGWtKnHXuYU6pcQAbdil0y/PymawUg0HGCDDOpSl1qiIOKXrRBnrVsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764191; c=relaxed/simple;
	bh=ETjl11AylSN0ZOzUDIghnEsP6rqglCq+heLPXuXZBbo=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=gkClTzPWMnE3ZqHM5UVuA8scZ2G3TGqf0RA7n8KS8vvyGn+1CEovB0Rzb5XBtTBc9L3vp6R8gkxiXkimtkvaAUeWB6jqmXxzyq8+aFJTczenAzPs5xewihYAVydV+hbZ5ppXnGyie4UVrRe+4KZrUrtd/osUWWGvel7s6+qoH1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=qTuJSe0L; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="qTuJSe0L"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6074iHdT1036152
	for <git@vger.kernel.org>; Tue, 6 Jan 2026 21:36:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=h+5MfxTR3Ze0yYG3ZO9C
	DaLPcdo63ztQ4KwWoeNKdpo=; b=qTuJSe0L4+VRpuC0vA9YUQYnOF+9QC4wLlgV
	Wtip84lS/aE30DMQq6SBwbX2Nw2fJe3QZcNR69yUzmTeSazE+exV0geRYDuZ4NUp
	KX5VLsWNuYn5C3m8i7KjQog3giT50CeFVY7q1PG/qXURUYpgxUF5aaJMep+TpEAr
	9l7ADqX6b5gy1z9NNZBbWODur2DWXJozuSaA9pPFUfn/MbnKDSkV48bGdtn/NPv2
	gixM1Z0BMHM9uPRAEglWRbZTfpRwOxOKSFkFSs1nFyNCDg1kWuRU0AyJG55/t2ha
	1b+VwzJvhJ4D3B74lqPi8xhhIpgI9zD2VYIHtOXXiuXjrI6o+Q==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bey923gh5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 06 Jan 2026 21:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSNr+AuLqzRNvp+i8Gz9sFq1+/2/hsQXGxrsV6f+GC7OuIRNffXj7G8fRVsdxzmcaNxq7g1/3hBJffld/x+DS39mBL+9JEzjVV78/bK6GYBNgZhXDO+HqFOF++c4Fur2BI1Ymh+jdmSyI++whJ0++bmaLVuLwmNMFNIWMCLNCvu7WFwJs04v/+ZVdEZKTtwLDmtA94CIc+kPjiw9g8xG2EUsU194v5U3zRE9IDXkmVjsYxZCW56jSu8L9POGgVFDdOuszonynARtF72SNXlce3OFLqvX5EwK6ueveFnk0pQpm6+7RqtPmIehmgv+4o2tmVHGezXMKeWMOFaC8w8DLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+5MfxTR3Ze0yYG3ZO9CDaLPcdo63ztQ4KwWoeNKdpo=;
 b=EKaqBIrx91djuTumsn/ITK8U3PxQfbvY8YcKXzp9NR4STJQdEWB550VRQCtaarvbvaW4LrL35L/7WZxDgUosU2FDhYFmVd8iy5EMHrvFn2YuZSrwIwYctTuB4FoDcy3dDVxT/NbMm54VqwMv8GHV+Jxd6aKpawN/oHqS4pin+hbvlBsZP0W5Pd4pNEjQuYicSFY8SqueKg5TmlIKs6eMfRugJ+/b7Eta7Qh//Xrn1KO77EYBt3kQ+MLpWi5lXEUM+giTtEXk11rgNSN8sAi+FOsB4oHDIXI97xUUUNTZPs3gWHIJnv+UE3h2BYlnE1UPCcn0NwIffpcobqf11edBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5533.namprd11.prod.outlook.com (2603:10b6:5:38a::7) by
 SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Wed, 7 Jan 2026 05:36:25 +0000
Received: from DM4PR11MB5533.namprd11.prod.outlook.com
 ([fe80::8ce3:74f6:33ca:3dfd]) by DM4PR11MB5533.namprd11.prod.outlook.com
 ([fe80::8ce3:74f6:33ca:3dfd%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 05:36:25 +0000
Message-ID: <44c4e575-bf5c-45a4-8035-ad4007e95fe3@windriver.com>
Date: Wed, 7 Jan 2026 13:36:20 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Jinfeng Wang <jinfeng.wang.cn@windriver.com>
Subject: question about affected version of CVE-2025-48385
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0159.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::10) To DM4PR11MB5533.namprd11.prod.outlook.com
 (2603:10b6:5:38a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5533:EE_|SJ2PR11MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a49ddb1-efca-470c-b3f8-08de4daeb273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2E5bjdKWmQ4RWpUK2IvdUhYS2VicXE2RXpMZkdkSHNjajd0bWZNdTB1a2Zl?=
 =?utf-8?B?VCtRMlo2Uk81Y3dTamVSRFZrNWI1NzlFd0tyTm9FVHQxVlNvUlJWM1ltcXQr?=
 =?utf-8?B?WUllSWZUU3dqbnRwZ0Y5UmQrcVRRWkFET0xyWnptMjlIRWtBM000TWtFaEVr?=
 =?utf-8?B?Yi9qMDhUdW1TbFhMNzdoUEFycDdDWEprSDdpU3hLS0Y3V2N3RThrei9GcVpY?=
 =?utf-8?B?SWtCaTlYSVZXZkx3U3ZseitPSzFrZkNtemRabW9PZktKcWZpd0oraVg5eHli?=
 =?utf-8?B?OWNSRVAwd1RwdXN1aGRMRU02a2J4YWU5cVlGNDdwN1YwZ3hVN0FiNUpQVmlD?=
 =?utf-8?B?MzhZNVFVeFA1Yzh4eFZSZEZweXhjQisyOVY2QWpSYlJ1RmVJbXB5NElhUSto?=
 =?utf-8?B?ZVd4L05ySy9ucFJ6OEJiS3BETVljREc4b2RkYUM3STBXRlZuRm9EQTBTbXlr?=
 =?utf-8?B?Qm5zWUV0NUZ2WkU3MEV5dUdPZnZWMEVlQytHdHl5WThJb2Y1dktZcEs3THJV?=
 =?utf-8?B?WDVCbGtuNEg0Q0FLTmczZm4rT1Nua2VRc0NLaDZEaUN4OGx1bzZtZEFQS0Z1?=
 =?utf-8?B?OTYyWnI4VDAvMTlOQk56MXVrZ0Z2Qm45Mnc4anNCWlRmWnhMM2NzM005NmRU?=
 =?utf-8?B?bmdHV3RtRFFpT0wvTzFoMk1aSmxNLy8yTHFqTHMrRGpXeG01WWV2ZnpPTmRQ?=
 =?utf-8?B?WExJOXFpMGxTNzFPWGFMaE8wTmYyN3lnb2F0dzdKZVFyVmJlZUFYODVSbW54?=
 =?utf-8?B?TEE2VE1TS2VKaHg2eTE3WmVCL2pHc3d1M2tBTWZwZkMvbnhra2tqVng1NTUz?=
 =?utf-8?B?TElaZnZoNmtrcmhaWmJUNE9uOFNMWk5oUDdLV1ZBTmJSc0VQbjFGT3kwQ2VB?=
 =?utf-8?B?cmpnZWtUVldIZm1TYzJQVUV1L0xacnFlcG1hZU5CYnRDQUFXSFVvRVYrcTNX?=
 =?utf-8?B?V3RTNW1sdGplQzdKOFdJZXRqczVLZnpIN0pyM09ram1LTjhuWVR0VGRJOVVT?=
 =?utf-8?B?OWZoSHN4dHBkN3V0c2xzdFJjb0tSSmRLVGt6dWpKRHVKSWRmaEppL1YyLzlJ?=
 =?utf-8?B?THNYMWUzUWJCWmJhRjVBUzJoQUFnaUN3UWNkZmk4OVVDbnhkUFZtUU40MEJT?=
 =?utf-8?B?TzhjdGx2SEc3S2NiR2NDNFFCMjN6ejErSTNiN1dYZWdSR0FGQ0tHYzI2cWVL?=
 =?utf-8?B?T1FjSEcwTTQ4WDA0RTBoK3A5Z3JnbzdXRy9FU1Q5V0RqYkdUQmpEQm9OelZI?=
 =?utf-8?B?Qk1adTdXZnBZQTNrbUl0MFJtS0RKeDZNRmFiR0gvUzhmckQ2c3JnQ0hCYmEw?=
 =?utf-8?B?UmtVU2FpckI5d2RseVlzNTAvcUNVUndoOGpyQWJsQnl6d2JmTlZQMGF2cnVn?=
 =?utf-8?B?NVo1SkhMbkZuRHUreE56dDJlSFZKQzFWclczUmVxd1dYNjUzSFhOVDM3M1p5?=
 =?utf-8?B?TDhFR2RoV3BpVTU4cDBtdThvRndOOFBYMHV2VG9PdmFRVGlhL2pNT1RWYkVM?=
 =?utf-8?B?R0xkQ2ZDdElpTUx4WmhTYjhOclNEUkpNbjY2S01tSnVXTE5mRE9sQUZwdXQ5?=
 =?utf-8?B?VE5lVkdPZG9GdjJiUUtpZDY2VXNDelVNeWVwcGU0eWh0dXZvZG9ITEtOL0xV?=
 =?utf-8?B?cTVGUDYyWWZ3MURxdWd1WDI5NXFCV29YM2UvZG0xNDRjNmhiOUpUbVY1cTZp?=
 =?utf-8?B?WUtEUGQyaDRiVEowL1YrZUtPeFdsS3hqaTJZTGZLSGRDRWwzOXQycHJtaEpX?=
 =?utf-8?B?TXJJUTdaMEpRbzFWYXErMEliVVNybUhKeDBVQmlneWEwcHFLQ3NaeTYyU012?=
 =?utf-8?B?Vi96eTJ4cUZHL2FvRUxpZXd2YXIyYnBHaEEwaWJ5OGs3SW85dmtGaDZJdjBa?=
 =?utf-8?B?eXYwZkg4NFp2dGx6ckJCZDNjNGcvbFVpTlpibG90OTVCU1lIRU9CVXljaVNP?=
 =?utf-8?B?dEZGSGorRHdFZVNWR0lvUnMwam51cVFKVmZUOVZ0L0lsQmI5RlFEN2xtbTF2?=
 =?utf-8?B?bzZEVnJBKy9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5533.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFk0Z3ZnQWhoaTV2L2lDUFBBSkkrblBwN1U3a0pFdkVmVHdrNklJU0gxekdm?=
 =?utf-8?B?TnJKazNVYy9pVGhtR3dpRTdSdXVETTlRbnB4a01ZaSsxM2lUaUxsMXhlcnhZ?=
 =?utf-8?B?UkM0eEloTnR5M1cvc2FpL1g3UXpJS3dUTTI2VXVLWkYvd21yS0tvaE1GMElT?=
 =?utf-8?B?NXFiYk5JZzc2Ky9SQUM5enE4L2RSYThTTXA0UHF2OENtYjc1M2ZLNVdTZ2NN?=
 =?utf-8?B?Z3VCdVNQUUIybVdic1ZPcHJEQlZZVFZhb2w5WmdSaElkbnBXaXZuWmdKZXhO?=
 =?utf-8?B?Zk9KQ2c0dFlHTGF2QTZiT1lkUlhodUdrYnBRYUJrQ2J0bU42L3NZN2YwTk04?=
 =?utf-8?B?Y0gzTGxYZytCb2RGdi9XU1VrT0dpdDdHdEJEOUlyYm8rcWpBM3NGajB0Rll6?=
 =?utf-8?B?ZlFtU0IrVXRiSll6YnVKVXpXMU4xWnhKMlFZK2pZc0k5bGpxUWZLRjU2OHQ0?=
 =?utf-8?B?VDlLcC9hcVYrZi85UktINk9XYm5lMGI0UzVUcVBIbCtkNVl1blJ2dmFsQ3l6?=
 =?utf-8?B?T1EvK3p3M0Y1S0xmaHRJaEtId2tPZFI0ZDdWeHBhYWIvMTFJSmI2cHViSEYx?=
 =?utf-8?B?MXBYeHBoa1RDbFN4NGxycWVrVWtWVktva3BrOEtYWHRTTUZIYlFMR1R4a1l1?=
 =?utf-8?B?dWt2R0hOYUhqQVYyb0hTQ1l0djVPZXRqOVI4Z1gwT05TTHE1VEg2VnQ5cm1x?=
 =?utf-8?B?Z3Nzd0NkMkl6UlA1T29vZW9BU09RbHpObWprZU53aURkUnRMdzVCTHdiN28w?=
 =?utf-8?B?WDZYVVBMUmcwTWxkRjFEYlNzQVJBRjNleFkzVU5sQ3B0YXFPNDRWVjVGSndh?=
 =?utf-8?B?azBwa3Yybk9SbzZITERJYUpCaVJnYWtzQ2pid2pEUHVCNjRtTGdGL1djWEE2?=
 =?utf-8?B?SXV3Y3RRS3RqNWZvR3ZubDF4QkJwSWFlcGxTb2VTWnl2dVQxM2JRcVUwbEhC?=
 =?utf-8?B?cWtiWnJWQlEzMWVtKzBQQmVJY3pxN2FhdFlNZmlWVzQweEI2NEl1Qnk1RHFj?=
 =?utf-8?B?cVJMWGxNZ2VtUEpuWUV6TW9FUmllS080TEpnSGU0UTdIdzVOdnZNbkczNGlQ?=
 =?utf-8?B?bUNtUEtUbFpyWkJhN1BaOFlOVW9rcTQyUitUeHlzVkhUY3BiMEZvYkN4SldU?=
 =?utf-8?B?SjVucnRsQVNLNzJ6aE5wQjNxSTVhd01kdFZLS0Rtem5RN2J3NkxwdHAreXBK?=
 =?utf-8?B?RVpFQ2lMdjM4dlhGakJOaDh1c0hsckxRSzEzNDlVWXMxUjdyekxZVUhjOUZh?=
 =?utf-8?B?RCs4clh2OU1Bbk1ER01mN2htSVNVeDJZZGVKZysycllmS3NVNlM1Z2RKTnVX?=
 =?utf-8?B?QlFaS1gzVmNHR0FMY0FLQW5uNkRLSC9SbVBzcUU1ZG5heDVCeTRBS2lQTS9Z?=
 =?utf-8?B?ckF5a2RmY0tDcElvOExJZnFIQnNMQlpIR3AxWnFiZXR0cFIvbFQrNGNCMkMx?=
 =?utf-8?B?ei9uME4rYm5nMTloaGt3TVVqWVh3bE51eXpreThQR3hrWjdwOE9TaXZ0K0Rp?=
 =?utf-8?B?OWY5UnJOWnpBOFdlZzFoak5WSW1zajNaazM2YlZ4S1ZDQ056Z09pRnZjcGpG?=
 =?utf-8?B?NDc5MXI2KzBib1g2empidjMwSFZqV0ZYYngwWGx3Vmhib0I0YmR1bDlDdzQ4?=
 =?utf-8?B?QnJHZDRjL2UwdWF5eU5heGNEbDhUSFFiaDRDRDh2QmdkMGV2VTNWWisyTTQx?=
 =?utf-8?B?OVBxNGZYbnZCVmg4Qy91MjJXRGlWaG9qK1RIN2lQQ2ZpaE5GMFU3Ump2bHl1?=
 =?utf-8?B?a2thS1dJVVZmK0E5QUErc0xid0tpNkZ2VzF0S1gyVnQ2NnVwaVhpQmpuWnk2?=
 =?utf-8?B?cHdBV0U2czJtWjhiWXgxNE9DdHNrU1ZGNGl3YjRWU0plN2xHaXliY3pBMWhR?=
 =?utf-8?B?OEVGNGxkcXRYM05pQXZZNkF1RE9LQXAxVitna3RvSytTVlVYbm5zNFBlbUZx?=
 =?utf-8?B?TERzQVA1Si83QUdIY3NBTWFmSWhkZTRzRXNpaUxEd09vc00zbjBWWU1JNS8x?=
 =?utf-8?B?aUZlWWZVN2hONWR3SjhhMzBrd2tMcjQxc04vbG9jdlNFUUlTMnFWaW1YbHJ3?=
 =?utf-8?B?N2ZKcFl4ampXdTJFQ3pZZGZhZFdsZ1N5YXJMbE1NNnRQaEppL2pDOHI5RjF3?=
 =?utf-8?B?bnZvaExRZ3BYRU8wdkltaGFsQzl4ZXB1eW9qZUFrSXh5RmxDNUZhVkVpMXRK?=
 =?utf-8?B?c2ZHZUNueHR2YmhVYVRNUmY3RW9kWjBVdDNwbEgzcVZFT2F0UW5CVnZ0Tm10?=
 =?utf-8?B?bzJlL3dWK0YrV053OG1JQ2s4R2NOemFxVTVPenoxZ05CVENuSTZTQzZ2QUds?=
 =?utf-8?B?OStvTkkrdGMwb1BPOEl6enJzcHdGNVNFOXhvb2NBQWdTODJlaGc4cklhelha?=
 =?utf-8?Q?+roLpRcLS8QpHZ9A=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a49ddb1-efca-470c-b3f8-08de4daeb273
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5533.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 05:36:24.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPPtIZ7dGgstgZ5SBbqvTZjhBrypHBE3GACvNUFIk80KvCwhX7oTcpW1Qc06RIJTxSMwCVZ42z4sdGaXFjtARjeGyp+AJEkkgCDBVrZCmB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-Proofpoint-ORIG-GUID: MpiwJVDejZbQvWNleT0sT6mYF5c0-Ftd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA0MyBTYWx0ZWRfX/BSnaeHnMdQL
 r2aoScCPEQ5e9RJ8uTfDMBZRt5LZ7OOpgWfNojI0PbbUFhJx1uI9aMZ6LJNHODsuoL2Si27dGVz
 on9YOC8Nbuxt28n1rcC+cQna88IT3SoFx1BqAGL1yEiTvMzRcgC2q3xPRcE+67Pq6iMj7HdzlTh
 LdNRXxz4c2foMvIRpR2uqXXvkXVMXoRL0NFP8BMsCyCbr4LlM74SeQiAR4KcPR41qQVVFlKELIl
 BJrFqI713CmoshY0uwnmhg7cobkJFZtM2G0SCH9pfJcIDCI9tHp1AkK6MydCg5ycZEBqk8d5m+3
 liHFTrCsckBpcQzZfeosIP9Nb0k9gy6jCIol9JPt/Zkt3x7+DHZigcMdDv46emld8pQZfOiR09I
 uP1R9gzflW43RZEWu7QwHcVCEcsj3ztlhKprf13yjPHykIAvKBqajKEqWqgj40vSCVUMsYKdqjq
 gGKBiCqIO3S+3FqTYLg==
X-Authority-Analysis: v=2.4 cv=HtZ72kTS c=1 sm=1 tr=0 ts=695df0db cx=c_pps
 a=HW5a8e7WWDX24nvVw4Uo9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PYnjg3YJAAAA:8 a=NEAV23lmAAAA:8 a=3nsOOYR-AAAA:8
 a=txAjmsy88ExDcVkon18A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=X8_4EP2Luv2hi8NvPz5g:22
X-Proofpoint-GUID: MpiwJVDejZbQvWNleT0sT6mYF5c0-Ftd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1031
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070043

Hi all,

For this CVE https://nvd.nist.gov/vuln/detail/CVE-2025-48385,

Affected vesion listed in 
https://github.com/git/git/security/advisories/GHSA-m98c-vgpc-9655:
Affected versions
v2.50.0, v2.49.0, v2.48.0-v2.48.1, v2.47.0–v2.47.2, v2.46.0–v2.46.3, 
v2.45.0-v2.45.3, v2.44.0–v2.44.3, v2.43.6 and prior

But I see the fix is for bundle-uri:

git log --grep="CVE-2025-48385"
commit d2bc61fcabd6cfa582d286bed1ce20d5d7c58d52
Merge: d61cfed2c2 35cb1bb0b9
Author: Taylor Blau <me@ttaylorr.com>
Date:   Wed May 28 12:53:52 2025 -0400

     Merge branch 'ps/bundle-uri-arbitrary-writes' into maint-2.43

     This merges in the fix for CVE-2025-48385.

     * ps/bundle-uri-arbitrary-writes:
       bundle-uri: fix arbitrary file writes via parameter injection

But bundle-uri is added in v2.38.0, so the version before v2.38.0 is not 
affected. Is that right?


Regards,

Jinfeng

