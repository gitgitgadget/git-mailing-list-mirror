Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B41400C
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948875; cv=fail; b=QSYjBKEFICMo9vIwyeEHSLCJpQWM7dMZZz9tbjfv0iSDXNOXTcJV5fillwrm1lDgGjbuSCS4r6HlJCEKlDfJ+ot+IIBX4wGDJ+1/OVQoUkcDfcHizK8Up4ycHOH8DlboizgCloIcPW7PZxl5NLu7qYH9XDWVuPiObeQVnngty6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948875; c=relaxed/simple;
	bh=Y/LzaJfDONAdTZeTKfG7m0RML5M5fvOLmjYUXru57DY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g7VTFej8dax647FzMbjohVMK5YTrvSIXktlRKBrtpmF5U0/pUn0rKuLunHUe3TVrntEAU1Onr3lauXITBbxpYWflx2DPC+x+ACfP52PLbiHoY9Yt+tEqGeMCty2scTQefkT6OibqmiLLkRrVzIRGTv9aB8+N+QNuxFCnUAPORZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HGErkpAb; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HGErkpAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErvSeKzhqUw1z1mYe0lRkiaFv1N12qyOF76t9PoorzJrDf+MqObGwigV7yJpXDtWLRmarT+4twUSnVNi1nA+4lg1mJX4EX1+1DKoaXGSHNf/OqqkK4HVCIiaAm0UsZSrmZHD3K41Fo/hmo71VR7MdrtE4ZfLfjbA3rqba8l3sbnWu0XliJau03g3I59i8Bhcx7FhSRiy0d3K1djgMWpV/Yq1Rqh+gILuHwa6L6ZLOvGe8NJM6xchKuJkhpMj9afy/3L6ojqwaI/Qh0Ft7GDg+u/rPxfOdG92F3VcQGsMxpHgBrSInQqPad/a1/ICfvD2TscXHFKFeOizSUuFkEM74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG7as1nKvpO8MeaEqQ/FuvxiDcYJQWGyOrQwoBoXQf8=;
 b=LYxuGT+B3+PadK3xV8fGL9RgSkctAMvwC8Hv3c767VzK0wJDxySZyiFDZWDF9gvCVwrs+9bDOThrDLrpoKvxraDv5FUQ0TwHhXbn5H5g9EY3jad4ytiBJKXPHG6JWrfOGkoI1M6yIN5sOHeXtIkz+PLFjrzgAVaTT8GKF/q7wH4Dx150gJXFjzSwCwqRDoHfdwOtudHVWuoSCdaKFrnlSgneCkks7E0c/aPYL5h7+xc8l6rZyvDDr8C7GAWpPJctBwm+DBewvWvGlBedgXVXcjWoBv9rAseHRWHEaR0ThBU8mw1c6gq1HRrluZz5LKrXHwv3HWDJ0zhsi/7pRUUqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG7as1nKvpO8MeaEqQ/FuvxiDcYJQWGyOrQwoBoXQf8=;
 b=HGErkpAbCkdP9lUCN8EUirAVIujjQSSfQH3Uohh8VliPDZpHBKv58RYh9pJbyuYh8ID0f/8R2tzkTmKqoOB829EdQDsuKb2ljL2VkoDlzMPb0o0Y0VQfZPYKXt4KPOx7MHagHOeqhjWSaPYz2/zANDNyyjZzTGiWNOGUuGtJKuedNg5Rd5L5mjyzjeLYqdGkQXO+VVoS31XqXAnMn83fRmh7jMrZvN4nl3MQgPCK3qJfps5UaGp71um7WecrqRZezvZkRu3Gbj7o7bLWvhtj7G+UrkTgQyVuubJl5mBlJa3Rz0AAje5hZUxFeWYexh2FLxYhNHaf0gcYq/KfrJWpyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 05:21:10 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 05:21:10 +0000
Message-ID: <9a318697-4bf5-4ac9-ab9f-f9851da7c54f@nvidia.com>
Date: Tue, 16 Dec 2025 21:20:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Dec 2025, #03)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
References: <xmqq4ipwc7y2.fsf@gitster.g>
 <93afac3c-c532-4183-a1fd-7e2322ee912f@nvidia.com>
 <xmqqecot3dm1.fsf@gitster.g>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqecot3dm1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: e7523605-3d22-4494-693e-08de3d2c16b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2hyZkpnbm5UblJPMUxoRnB3NUQwK05LRFBraGY1M2pwL3gwWHo5Qm90YlNv?=
 =?utf-8?B?R1p3K0pBWTlKalBIQU0rZzk1d0NDWWFDQ3ovRURwN3lOS1dFa0c5SGpxR3Ji?=
 =?utf-8?B?ZmRZVm5CcCtIbWN1M091b2F0VTg2TzF2RWVuWEt6TGhuR3J2Rm40dXNQb0pT?=
 =?utf-8?B?UENYemZ4S3ZMTVdjYkV3ZzlFMXZSdkduYXFYOHgzeFNTdmxkT1JUTHFjYVAy?=
 =?utf-8?B?T2piL3ZUeVlYL09GT3dwTS95ZlJrRzZqeDFzRDBiUjUxVE1MMmk4d1BvSWYx?=
 =?utf-8?B?Nk1DZzNhazE3elkvZGZMQXdTdkpmT051OFE5czhZb3BCUUhsSTg0S2tFaUJn?=
 =?utf-8?B?ckJaTkt3Mm5PUGJOV0JteElhZ0F0c0FGN0o2enVPUFBlV3VhQVYrZ2xXQ0hq?=
 =?utf-8?B?cWVFWGVBeU5ialBTRTgybmRFUkNWcE4zaU1DeXNzN2FNa2RjSmVucHZ5a1pW?=
 =?utf-8?B?TldZdGlSeHVBTmU3NTZRV3A1ZzcwWVI2NHRjQzVJQ0tWSUpPUTJpNHNjZVBt?=
 =?utf-8?B?aVN4clBLTVNPT2NJVHl5aUVvYkFJWkNRVGx3djE4aXRQSm43b2VjQmpsZnBX?=
 =?utf-8?B?N2hTT2lBVTRSUElPSnh2YUxYK09qbjcwNzdza0FuaUFaSG9RWjRvb0xYQTRP?=
 =?utf-8?B?QWtPd3dlekxTR1B6d2FIY2xlQmdKQjIvaVlCb3duSnd4enhmMTJ4TnR6cFVT?=
 =?utf-8?B?RW1CdVlNQ2hzenBkUmZLMzBRTitpWWgwTVJlaGZzWlRaQmJsMGwrSWk4WDdC?=
 =?utf-8?B?ditwV1A3aGpNcjI3em13a3pWdDNzL1l3azNiMDNJc0pQcFZ6SHBMWERqU2Ex?=
 =?utf-8?B?V2ViOHhtTVVuenJoM1Y1dkhrQ1ZRRFhCMDdmdkE4dzdmbjlsS1BtRERBUkZU?=
 =?utf-8?B?WktETXpMdTFQb3dlSTdTV2x4NnR2Q0Y3VEtaSjFxU0pNS2NwRkdkNmNablFa?=
 =?utf-8?B?UnBEVGZZM0diOW92MGc3aU1tejB0YzNibTl3cnh1Rk1YNUZ1YmZYWWRYVnNq?=
 =?utf-8?B?RGlneU1oTEtBdHJ6eXhaVEpMVVErOUl0cUc2TUhVem5ReEg5UDBoSXJJaGh3?=
 =?utf-8?B?dnBwdExVR25qWGh1dEdkR05EVjRCQWNYamt0eEp5NVZQVElNc3JGaTBjM1BI?=
 =?utf-8?B?NzhMenhPQkVlUENvdC85MitRSmd4WldKUmk5ZVNqZnJmcWxaTHZzMkdlaUFV?=
 =?utf-8?B?Z2x0ZWhCc0FrR3hXRmVyc3U2UGFrQlRwWFBSbjFuT0djYXRyYXlMcXZ2ZE1F?=
 =?utf-8?B?dG5mLy9RWGc4RnVjLzNmNTNJbnZ1dVVjaFkraitONmlPRWpKOXBKNDdkRVJM?=
 =?utf-8?B?bW4veHdDQ2tWekdhM1B2OXJiTnNsNDdPMHNYREo1WTNwdmlGaGorTlYzRmMy?=
 =?utf-8?B?cUZvQVhtTkJSUWxMa2l5Z3NIWS84WmcyTk8yNktRQXFPQVZUcWpKM0xPMGly?=
 =?utf-8?B?bVNVdE5PaFlpRFB6R2VFaVRCZmxBd2I2bFVlL1hmREV3YUVzcFFQbHRXSHl1?=
 =?utf-8?B?WEV5dlhPVU1RbEZGQUsyb3gvNWFxS1J2R0ZiMzcraHRxSDc5UC9Va2hEd0tn?=
 =?utf-8?B?YmZ0dzRQS1c0VG5KRmdoNkl5TDNTdkF0RjJBQWg4dGJZNDFWV21FMi9yZXNC?=
 =?utf-8?B?K1Q3UVNkVkFxTjQ2NXRsNTJSWFQwR0svY1NUZTJ1WENWcXpBMFJyK3pURFhO?=
 =?utf-8?B?WkpZVTNraURwdThrL0xDK2V0bmVzWEpHSzJCdDd1bzZabmFTWkV5K29FZzN2?=
 =?utf-8?B?SEhEWEROVEtMalVVS3B1cnFsU0ZRMXNFR0dzcWhiYm91NS92c0ROTSt1eG94?=
 =?utf-8?B?Q2k1cGpNamFSVlRLdFdraTZsVXRNTVhJZUFWRUpZWFVWbFo2NnFBUDJNVGxL?=
 =?utf-8?B?L0luNkJheWZvWGNJRm9xVnJKVE5lQ1hiOU9QZlEvMWdhc1dKekZnNEx5bW9x?=
 =?utf-8?B?aFlISmVYZXEwTSt6L2paRXkwdmtmZ0lEcXl6aTNwL09jdC9YRDlCMmlNRWZt?=
 =?utf-8?B?MCtYTTFabGxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2RtTTNLMDJsMFhrRWx5TEU1TEJsZzZ0aUJUWU9jcGI2c0tZUDNtOFliTkNx?=
 =?utf-8?B?V0pSQ3lGNU1obnV3N25VVW5pNmFvVERLY2VrRVBva3RPdFZDdDVrVVVWTDAx?=
 =?utf-8?B?ZXd5dHR1MFR2SkhWeXo5MGxBTFFjRlV0SG4zZEZoN2NoUXVTZFZvc2Irb0dw?=
 =?utf-8?B?dE0vZytZZzk4b1lyOHpTdG5vTTMzOWIvNm5OYXdudnRwTzFUWjhaQnhmQXdw?=
 =?utf-8?B?OXY0WURYZHNLVWpCV2FGYkdvSk82Yk05NFM2TVZ4dDUvcVk2U2ZCbzJaTkRM?=
 =?utf-8?B?WnhXcW1hcEhZOXNPRW1SRTlsc0YydmEyVnZYRTdvcndmNWdMRFFWQ2tScnRX?=
 =?utf-8?B?OUdlS1lDQzcvR3V6TmpLeDMvdGgzL3gwcUIvUWZVS0lYb1JWTTduSVpnRE5y?=
 =?utf-8?B?eG9FRWVFOW13NXNiR251Vk5iZjErWE91Um9zL2JQN00yNFNFRWpjcSs4NFBx?=
 =?utf-8?B?K3NpMDYySGhybW9qYzNSSDJyTHdEMmYxVkRmemNOYnh1TUYzWllwMEZrQ0ll?=
 =?utf-8?B?QzhyNjc3WmZsZ2NZMTVCTHBIUktLN2E3akFJWUFyMU8xLzUrR3JOSXh1ODhi?=
 =?utf-8?B?WGRDNDUyQ0F5cGE0ZnRzbXUzb2JtV0NDWWZGbE9lMGVMa1JVY3ltVnFhS3RQ?=
 =?utf-8?B?Vms4aE1saGl4MXhmWmNPL3luenY1d044SlVVNlJxM1VHWTJ3VHl4ak5NUVYw?=
 =?utf-8?B?M2VDYjRmY0tFTnh3aXZHdmVyeE1IcTJHcWpmOU9oUFlGS2dTcHdHNjQvZU1w?=
 =?utf-8?B?VzB5aVNyNDhBdFlXYjJldTVtTGxjOExiUzZXTUZjKy9zcXdod3RoM3d6UlBL?=
 =?utf-8?B?amRmV3pBMlo4UWtqd3lFcENBdkhVelBSNkVRMHdKUGVFYnYzcitUNFpDUitk?=
 =?utf-8?B?VklUZmNHOHlnWnY5dlhYK0d5bldzUUtocmkzblpwMFdEMTdJTHUrVXVHT0N0?=
 =?utf-8?B?N0NlTjBEVlgvWCtKQ3JBR09yTktCVlpMZ1pXZ01iYStxd0xWVzJUNGZZeC9z?=
 =?utf-8?B?U0x4Vnl2eW1nUlFqSWQwL2JwWkh5T2hSMlZFNEVBVVBPR3hoRjg3djFScGUw?=
 =?utf-8?B?S25Qajhna2FUbGNRbXhKMGRlQWFMNThPZVA0UUpNMlgwbXJaZGE2QllGQ0c4?=
 =?utf-8?B?ZU5MbjQ0K1MvdXlXK2tSTW40TzNnblJxL0lKRlh0RjZxQW1YSjFyQ3p6VnlL?=
 =?utf-8?B?QUVOMmZScFpNTGM4eHFlK05vaXhoNlRRL0NRQk5ZdGxWejkyS1E4a0QvbSsw?=
 =?utf-8?B?SUFiWDMveDI4Z3JIY2ZpK0gzdEJJeDJCZWsxYWpnanplalBxcFUxR3UvR2J0?=
 =?utf-8?B?bnFqQ0t6RGJaQ1ZIY3Y5a1FpSmVUeWluN1p5anZXN1JzL2lxZnoyRjFjVm41?=
 =?utf-8?B?RmhqSUh0WjB2SUpnTDdjNVh5UmI3NkRiWmY1SEVoZkI2ejVkd1A5RDRFaHVS?=
 =?utf-8?B?QjFGL1NqbHkvWnJybWVSODYzeVBQaVQ4ZjVHNUJuOFZ1Z0Y1OVBad0o2L2w4?=
 =?utf-8?B?YVNsbnQ5c3dwd0U1WnFDYmUza2tZdFQ2bXhmaVlHQ3ZIRmRGQU1Kb2N1UktU?=
 =?utf-8?B?bWZuWTA1cG1HTXZnU1FXK2lhQmNrNUxsTytZTE9UMjBPY0twMUlmbzk5b0g4?=
 =?utf-8?B?Wlc3RndjZTJMRUsrazRNeVk3UW9sOWZTSStsVDB4UGgvaEtFdVBqejkvdnFh?=
 =?utf-8?B?cFY4aU1MNG5YSWE1bVBoVWZxcWpwYXRuQW9SOUJkVTM2aUFVMzhNRUtwSHdO?=
 =?utf-8?B?bHlTMExrQk5KUGFmdHFldERQRUxoNnVEM2QzZThFRSs3eHNWL3FvU0tHQUw1?=
 =?utf-8?B?bmxtb2YrM1JKWDRNaUs3dVZOVk1TSnlsOENmQTUydGtGM0p5RWo4Nk9jMk5h?=
 =?utf-8?B?Zi81ZmJiVGJDNzBhdk94N1JQYXZsOVEzUXdyZTF1ZGNTV29NR012ZHBZOGly?=
 =?utf-8?B?bnVHUjhuM0JwZUZWV1QvdnlKOHdTSk9WYThRWFZMdFJ5dXF0UCtlU2Z3MWNl?=
 =?utf-8?B?aE96aHFhUG80VTRwMDJKUzJxR0tSbEd3eFpsa1MwUml0aWhHdzdTYW9pR3Ro?=
 =?utf-8?B?S0FtM2E5dHJVekMraDVPdmllSHNLVXp4ZDZBendIWFNPcUpZY21tYUZNU2Vy?=
 =?utf-8?B?OUIrVmpzUUZHZGlPbEM5U1luT3RGWklQeXgySEhOdXNGc0dGcGtmdUI0WVF1?=
 =?utf-8?Q?P/uen6+/sl71B8H9GJxsif8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7523605-3d22-4494-693e-08de3d2c16b8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 05:21:10.4294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7jU4xtIT6OVXXiGZD9FiX9lTc0MhTP+Fovy24rsrFSY0h4g0kncmtJjBqm7FjVpHqiks7Yao68RLtUxfC/+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779

On 12/16/25 9:02 PM, Junio C Hamano wrote:
> Aaron Plattner <aplattner@nvidia.com> writes:
> 
>> On 12/12/25 2:26 AM, Junio C Hamano wrote:
>>> * ap/packfile-promisor-object-optim (2025-12-08) 2 commits
>>>    - packfile: skip hash checks in add_promisor_object()
>>>    - object: apply skip_hash and discard_tree optimizations to unknown blobs too
>>>
>>>    The code path that enumerates promisor objects have been optimized
>>>    to skip pointlessly parsing blob objects.
>>>
>>>    Comments?
>>>    source: <20251209014900.402637-1-aplattner@nvidia.com>
>> Jeff King said v2 of the patch looked good to him but recommended
>> splitting it into two changes. I don't know if he wanted to review v3 or
>> if he was okay with it based on his comments on v2. The only differences
>> in v3 are the commit count and descriptions.
> 
> v3 did not have links back to previous iterations, and
> 
> https://lore.kernel.org/git/?q=s%3A%22improve+--exclude-promisor-objects+performance%22
> 
> does not even show v1 or v2 (understandable if the topic was
> retitled, which is not a bad thing, but makes it harder to find the
> previous discussions in a case like this).  So as far as whoever
> wrote the entry in the "What's cooking" report you quoted was
> concerned, what [*] showed
> 
>   * https://lore.kernel.org/git/20251209014900.402637-1-aplattner@nvidia.com/
> 
> was everything known about the topic, which unfortunately had no
> supporting comments.
> 
> Is this
> 
>    https://lore.kernel.org/git/20251206002014.2066644-1-aplattner@nvidia.com/
> 
> which I found in
> 
>    https://lore.kernel.org/git/?q=f%3Aaplattner%40nvidia.com
> 
> the v2 discussion?  We are lucky that you are not as prolific as
> some contributors, for whom an author-name search would have found
> way too many messages ;-)

I'm sorry, I should have looked more closely at the format of other 
v(n>1) messages on the list and noticed the links to the previous 
discussions. In retrospect, that should have been an obvious requirement...

For completeness, here's all of the discussion:

v1: 
https://lore.kernel.org/git/4bd18399-26b3-44cd-93a7-8d2d32bef709@nvidia.com/T/
v2: 
https://lore.kernel.org/git/20251206002014.2066644-1-aplattner@nvidia.com/T/
v3: 
https://lore.kernel.org/git/20251209014900.402637-1-aplattner@nvidia.com/T/

> I can see that the end result of applying the v3 patches match what
> was in v2, and v3 separates along the lines Peff suggested in his
> 
>    https://lore.kernel.org/git/20251208202812.GC216526@coredump.intra.peff.net/
> 
> so that's an endorsement enough, I guess ;-).
> 
> Let's mark the topic for 'next', then.  Thanks.

Thank you, I appreciate it!

-- Aaron
