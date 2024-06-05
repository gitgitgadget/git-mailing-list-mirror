Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAD3211
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605939; cv=fail; b=fXv1i77VdR/DEZ2B/uIDivCdgm3keN+MlcpqPQW0zUZdSt7ty7vM1H+R2aCjhy7ww2GBYXJtXu2FpEcZYUVCIsw8oG2R6o7xfc02Ze39JTPjr/KBma9990WF2dBcWTj/oebd8Mpp/FwByo5JpdfeLcMmr77pOBY2cXG4ObV1/sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605939; c=relaxed/simple;
	bh=j9z1rMZM7lLi5ggoy9oFQ9yO77A9zHIV15XJL6K3J6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c0kbYt0UHduvHJejZ958w5OfqAsAPHwdTiH9iYIw6QFU+EpPsIenjv7Em+Vs2HGYLpZLp/pN+mCbYP0G7gS0GOlmCXYeyWTTs486wu77D380SEHtfYW6xHF8QLgvrlT7ZLcFdZc3+Z8DnQP0wmPJ+s6UbhV3P1bPtyqLlMcPawg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8b1Dx0+; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8b1Dx0+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsWOi8n9t/y5VCFf1bVHmhgxIzjER3cN1+L1QymYZejoLszaGVEAF3h75e6NBT0bmKikt8yWXUxeVlsub4P5SOrtnZYqinUOYP/cBeET1gdI5DriaIw3rMTqcQNuoxTjmoHiHYGhptXrEWIp8vAKCs+dNBbSole9k0jR/3iQ+FydrmbqLujlbvF4uhSNVADWRpj22spaCjXmX0J19mHbG7r1IeqjUBUlKYS1ycFntgbPdKcnIfSaIG3Grvn2ryt1tBlCNYXhOUqIsi5efyBdPrKZOyW25/FGgGIjZ6uZq+U+pvlPxokwH+tPzJMljLcWbCaanfxKzUbgc1ZrSh2Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Pa/uOzRMXOU/Y5mzM6vRWd3JyCg69Cu6e+vnLTFCHk=;
 b=b+odrwLxTnpq5bRJElY/XAqHioX2nQASBf//g/cER+bXnkp3igtJsrHxoOd/QPVjM6I9DY6CruIoOkwFEOvqwln2W/OaAMg08UIGuV0OugpAd0otAM0165ua+v/7DhUs29xFK0B07OXMdQ1KYuYNVvdkGLu46vsOsdEIIMWZ6UyEI/917Kb+uyMbdDWLipiSf3upUtxOjTiCDukbaoySBXuUtCsrTD9jFdXan2oazl/FTxBGYrfsgb393RGTNN6byooO/8K09Fo6W8yORAv8oHAIC5umS8NfVJZeTZ77c30mMNaRjyekVaKwVmPO4zl1xVYx9K1PJR0+Wuf/Kl96aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Pa/uOzRMXOU/Y5mzM6vRWd3JyCg69Cu6e+vnLTFCHk=;
 b=M8b1Dx0+bUVbvrPLEiGszLiX6yDlVTm9an8Cc/utlQtDyP6f8teALuMPZc4ld2TWr91Bv8W2ub69vMgrzU+gpDYSRNVd63LofPXkydiIhHCrN5XEBMLtFammlMoB0vTsm2xy9viJmVZI8qy9ksLSam0TRn41CX81e6BrW39BLQZL+6oz7sxYKI37YOouSO45UsVShVxooNbDGCBvH0S8QUxN5H/6JpIuZrRsklczPNrVF3Itw3SksY3pv7xtOjgxQ0Z0cr8auVXi7AfjgUy9GJA1a5u5SQVzs/j00gAI2y8KqjyJftTabcILnsR4HysyJo6+A7z0T9T4NSUEoBCaiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 16:45:34 +0000
Received: from BYAPR12MB2981.namprd12.prod.outlook.com
 ([fe80::7e8:e993:c7e:656a]) by BYAPR12MB2981.namprd12.prod.outlook.com
 ([fe80::7e8:e993:c7e:656a%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 16:45:34 +0000
Message-ID: <dcbbd00f-1730-41fd-90d3-c7b070c4f17d@nvidia.com>
Date: Wed, 5 Jun 2024 09:45:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify secret
 clearing
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20240604192929.3252626-1-aplattner@nvidia.com>
 <20240605085733.GE2345232@coredump.intra.peff.net>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <20240605085733.GE2345232@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To BYAPR12MB2981.namprd12.prod.outlook.com
 (2603:10b6:a03:de::26)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 92292d41-3248-48d0-9b01-08dc857eeb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVQxUGhZUmlaakNTSEZMY0Q0L0FNZlc3THVtZXZsaDE0aCtVTkc4aDJDZ0Fq?=
 =?utf-8?B?VWlQa084UTlnT3gyUjBtZGJlb0krcCtTSmdQdDF2Nmk0dHZNejM5VEtyTExv?=
 =?utf-8?B?MEJqTWNsRENmWnBzdHZvTDYzRGN0V3o3S3c3eXVhd2lZR1BPRmR4V2lZZk9O?=
 =?utf-8?B?THFnOVRjc21RNDdwZUFSWTJGTTl2cHVWZUgreWI0MEhlclhjdHhkb2Z3bzkr?=
 =?utf-8?B?WTY2NHNYSm04YXg3akxuSzdNenk2LzdQQnNWSzB6c21jalpmdDdVbS9yTWdO?=
 =?utf-8?B?Tzh5OVAwNmQ5NEVFVi9LNy9LVVlvM0cyNkoyWC9DcUx6Um9rdTFxSHBoVkVM?=
 =?utf-8?B?VEtsQzJCZVpLVmNRWS9TL0xEdHE2NjZmeFZ2ZFdkRXI3WGNaV0JoVzJQejF3?=
 =?utf-8?B?SXBpWndBV0huS0NmeGh6QkFGSHNSRkhGSnkvdktON3dpMkN4U1Rma3dRV0xl?=
 =?utf-8?B?SzNNWCs4VFZZUm5uSStFSllkUVltZFhJbTdmenBZUk9KdXFia2x6aWNxWHBq?=
 =?utf-8?B?aEhWQXNUNWhMeHEyUlRXQnhnYlN0QlRGaGpRVVRwdE1nenJlUkNUL2lGMHds?=
 =?utf-8?B?aGF0UUJBN3FIQnAzL0Mzem1Fam14Rm5xUG54NzRBak1aaEMvZFNEUXd1SGw2?=
 =?utf-8?B?U3VHSWtSR3Erb0R4TkxtN3ZiNmRIR2VsR3NxYzcyRlJVSmU4ZXlyOWFIQnhC?=
 =?utf-8?B?cXI0VUtWOTNnL1BOMGkrS29JeVVCOXV6UnpodGhkenVOTWZZVHdrYlRPSmx6?=
 =?utf-8?B?Ulg2NzJNVE81UTB6TzRXc2RpU21zVzFYdVk0aVl2TEw5MUdwdmNXa0ZTRGNt?=
 =?utf-8?B?bGlpelBIS0FFWUJIVk1leGNMTzRGcng1dEE4aDM1WFZkR2hRRmlkUDYwdFJY?=
 =?utf-8?B?WlVUbW1EbFV2M2xUWFV0L1FNaHVSQ2JNTWxMMTZ1ZWhyMlpGTkhzSTVkMElk?=
 =?utf-8?B?d0pvOFBsUDV3ZWxiSGxWUkFseFNadTVwakVuVEpyWDFvWkRJVXpjZ25FU1A5?=
 =?utf-8?B?S1FVZm5nSkkvZ3dVYk01dmZ2QUVlVG1KT2h2VHRpR2dHQXlqR2Z0aTNFMXBy?=
 =?utf-8?B?bHY4SjRvMVpTTHFBWGpwTVVmU1d6K0hQMStGcU5lMDZrQVRiSnJZcXFSaUdG?=
 =?utf-8?B?aTgrYy9rRDVDaFBETXlWbFZOZWNRMG02TWd1aFIwczNtSldwRFpOUnFqSTFB?=
 =?utf-8?B?UkZ5U05DdDRNSm9wUmRGOU9hMURub3RCZnpKQTlwZUd6bjVKdzl0MTRUcGhs?=
 =?utf-8?B?M2N3WWtTcnE1bUUvZVU5Zlo2blkxWmFqTEtDVlV0akNoWExiUUhCYWZ4d1du?=
 =?utf-8?B?b0prQ1pxbDZGL3drQXlVc2doRWVNbnBRb3FiWjE1ZDc2VDFma0k1WUdpbkNq?=
 =?utf-8?B?V0VqeTV0SVBMZ1NaYzcxa21ZVjFnSTlpTHJIWTRYNjZUdzlrbG9kVERQTmJx?=
 =?utf-8?B?bnMvNFJ0ZEhtUWJWeDZnSENYMVErQjBJMnRwNXVVMnZDdHcwSG5GQ0ZzR0Nz?=
 =?utf-8?B?WGo3ZzFzZ1l3Z0d3dWhjQW1maDlCWGxSenlibGxvcUE3SmRMYm1MdjFYN1hu?=
 =?utf-8?B?N29nRDdtMnRsS3dPWGltS0FEYzZLbHpWQVBDV0JzSjdYeHBsR05LTGJZNkRx?=
 =?utf-8?B?SlFHK1JraXFyZFB6dHV1Q09UZVd5OHpBZzBmTXgyZzUwZDRnRmQwRStyWmw0?=
 =?utf-8?B?ZDBjR1J2NVZKcGFhdEp6RGoxTXBxWDBTNzQ2V0tmWEVxNEcvNWxMVFpITVps?=
 =?utf-8?Q?zBhdRXojf2kcCFADVkX2aTK6NpQut2/B4AJUgPG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2981.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU5TWEJEYlAxQW1MUDY5VjFTbFhOcVU5TlZDOW15LzdMNnh5WURjSjVEdlYr?=
 =?utf-8?B?TW9PcWVqVUg1SktDcUtHTW0xN1kyNkYxUmx2TEh4RUR2eHZTdml2Vjc1R3dQ?=
 =?utf-8?B?a3llR3dRRHpkY3lLbUlaUEI3SG1kWGFtUUZRSGp3ZTNacXJnZys3Q29ydU9s?=
 =?utf-8?B?YkFqaWJxQ25KcXpzTzRMWUpycXhiZWpVUkZLWHF6dkRKV2xwZkFkVXpUSjY0?=
 =?utf-8?B?Q1pLZHRnRGJyc2kwRDFiYjNtYU4rQW5ZcHR1ZDQ5d0FWcEttTmNIVGtGMGl4?=
 =?utf-8?B?Zm5LcDdKRUdSOTNXN1AwbHNadkpxUitoMkljZmJhbjJYeElIVEl1bnJkdUFL?=
 =?utf-8?B?elVEUjVKbDY5aU0wNHRJSEJweW9rOE0rT0hqaFJRV0RoYmNhS2RmNWhta294?=
 =?utf-8?B?MFE2bEdGMHR2dVA2VjUreitvbllKYmtuUGxtY0gyang0eHlIU0crRFRTY0FZ?=
 =?utf-8?B?bGdsMGRzYkszeHNZMFJmelpYaHEwSXhWWFVsQytHeTZDOFZMWm5kY2lBM1dy?=
 =?utf-8?B?aXZoT1BEQ0R0ZjJiQUlaOWcwVWdnOGxBMHJscVJtdzRBb253YUZsY1BUTXlS?=
 =?utf-8?B?MWhDaFpWZDNHVGJwZzlhbU82NUc2dVd4ZC9UTm5SeWlYWXpqZWNtUFFGWm05?=
 =?utf-8?B?WGxlcld1RHJBMFRXNUtNd0NFd1NMSzBGeHJZZnVMNFFEUW1HLzdDQlVCV05F?=
 =?utf-8?B?bG1ieTUvaERLNXpsR0RBczRwVDJXaUdFUUhpakQrcmxFaHNCTDlmWW9DbGZQ?=
 =?utf-8?B?NTRDbDh1ck1vQjNINys5Vk5ibmtPeEtLb1pCSm9ZSkRSalppbHVZU1BqQ3RP?=
 =?utf-8?B?QkFRVWNiLzJSa0E0cmdtVFNwR2M4L2VrclR6WnRnM2JaeEZBMXZYMzUyTm5t?=
 =?utf-8?B?cVBod1MvM0l4RzdJS1F4cVJScEg4cXBJTmFzMzZFdjZwMkMvemJSSVVwSnNn?=
 =?utf-8?B?QjFQeFhPTTRQbGJRN3lEUVI3VVphU2V2MkVsSTd3V1o1OVdmYmlqOHQzWFdJ?=
 =?utf-8?B?Q0g2ZzhxSEp6YnZuTFNmMW5HK1NCamRCKzZrRGJUYnV3dUJMRmQ2OE1BbDZU?=
 =?utf-8?B?MCtVSFJwbllvcnRRZkRiWEIzQm1yak01MGd1cnlqZHlKaDZhK1RGVlN4VnNi?=
 =?utf-8?B?TzZ3aHZBd2VGZ2hsbzhPVzRxYTd0dlVaa3EzUDNVTVBXcUZ6Z1B1Sk1YL2RY?=
 =?utf-8?B?c1R0d2FUM01ZZ2t1Smg5UUxlSDZ6eGlyd0duWXRtbUxLbXdLM1ZmelpCMTVw?=
 =?utf-8?B?OVZuVDFpSlo1VmpnTTBoOW1peHJiNk9mMzNOZDZKc0c0QU82eXBTVFgwMGFK?=
 =?utf-8?B?bE52WGdINkFjVXE0VGt4WEdpZzRvZklIVCtMVzJJWXNvMVJaMmh6UlluRmhO?=
 =?utf-8?B?bTdHeUx2b214ZFVFSENwbGFLeWxMeEFhTlpHNVlrN0FuTU4zVnRBUnVUcU9J?=
 =?utf-8?B?OE9IWDNXUGxyb09UT2tUcEhiSXB6MXlrc0M0YkFZbCt2Qi9PaW45dGsyZm9L?=
 =?utf-8?B?THB4WEpMcUhrQnBlWHNwKzF6bUN0b2lVQmFyKys4VnI4TUR6SFlLTHB2Vy96?=
 =?utf-8?B?ZytpOUVUcFJ2Njlqc1F4RXFacmY3bU5FRlNzYXM3RHdkZFhIMXd5V04vMmpi?=
 =?utf-8?B?UFdhaHhBRlpNKzI4NjUwZlV1QytNUHFjclhCMEEyRUNNUW9Ub3NaZ2ZyTmE4?=
 =?utf-8?B?RjlPa05SaGNxSExZaTFIa0ZCaWloSnVQK1BtTWZVcTFPNGFSWFVYVzk0SjFt?=
 =?utf-8?B?TTdmSXU2S3hjWFNSeGFpei9RTUFjZXMrL2JVb3hueHJRMGw1c1BzZHAzR1Jq?=
 =?utf-8?B?TEo3MmhMc2RSejZDOGptWmQ5ajhkZmxpanJES2NwcHNsZkY3a2pxRC9iTzhl?=
 =?utf-8?B?MEJBYXhpT2htWk1GR2o5KzVZa015SFMrVlBVR1hRcWFteTdDUEcxUDJNTVFJ?=
 =?utf-8?B?bGp5UlQ5Q2lQMDJRdXVUQ3ZmWlZuSGtWeXZkeWtUcVhiSmVvaWt3YVk4ZGF6?=
 =?utf-8?B?dklKaUxoR1FuMXVWamVZMEo2VktOTnFsSXZjb2ZGaXI1L1VIbmlhdWxoS2RF?=
 =?utf-8?B?UmcvN0dpSk9UZjN5dW5aWXVXb3YyS2duOVg1QTllTW1icHlxczk2NXBCeTRN?=
 =?utf-8?B?aHQ4SkxDZHA2bUt0QTg3VVl2dnE4VzlCeERCMGZIaUowbTA2dC90ZDJpOFNr?=
 =?utf-8?Q?sRYuvjLPvjPyaNoOdEdiCqY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92292d41-3248-48d0-9b01-08dc857eeb42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2981.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 16:45:34.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEVSZ39WTW8tHwRnCUc1xmbd2FBcONLLnN6uEr4WLHFmMK8NC8sj/e6TCgUbvFvzVCpwRx7Y82O2S9YfSd95FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238

On 6/5/24 1:57 AM, Jeff King wrote:
> On Tue, Jun 04, 2024 at 12:29:28PM -0700, Aaron Plattner wrote:
> 
>> @@ -528,12 +532,7 @@ void credential_reject(struct credential *c)
>>   	for (i = 0; i < c->helpers.nr; i++)
>>   		credential_do(c, c->helpers.items[i].string, "erase");
>>   
>> -	FREE_AND_NULL(c->username);
>> -	FREE_AND_NULL(c->password);
>> -	FREE_AND_NULL(c->credential);
>> -	FREE_AND_NULL(c->oauth_refresh_token);
>> -	c->password_expiry_utc = TIME_MAX;
>> -	c->approved = 0;
>> +	credential_clear(c);
>>   }
> 
> I'm skeptical of this hunk. The caller will usually have filled in parts
> of a credential struct like scheme and host, and then we picked up the
> rest from helpers or by prompting the user. Rejecting the credential
> should certainly clear the bogus password field and other secrets. But
> should it clear the host field?
> 
> I think it may be somewhat academic for now because we'll generally exit
> the program immediately after rejecting the credential. But occasionally
> the topic comes up of retrying auth within a command. So you might have
> a loop like this (or knowing our http code, probably some more baroque
> equivalent spread across multiple functions):
> 
>    credential_from_url(&cred, url);
>    for (int attempt = 0; attempt < 5; attempt++) {
> 	credential_fill(&cred);
> 	switch (do_something(url, &cred)) {
> 	case OK: /* it worked */
> 		return 0;
> 	case AUTH_ERROR:
> 		/* try again */
> 		credential_reject(&cred);
> 	}
>    }
>    return -1; /* too many failures */
> 
> And in that case you really want to retain the "query" parts of the
> credential after the reject. In this toy example you could just move the
> url-to-cred parsing into the loop, but in the real world it's often more
> complicated.
> 
> Arguably even the original code is a bit questionable for this, because
> we don't know if the username came from a helper or from the user, or if
> it was part of the original URL (e.g., "https://user@example.com/"
> should prompt only for the password). But it feels like this hunk is
> making it worse.

The comment above credential_reject() mentions that it is "readying the 
credential for another call to `credential_fill`" which does imply that 
you can use it again right away without having to fill in the protocol / 
host / path fields. So you're probably right that this should remain the 
way it was.

> The rest of the patch made sense to me, though. As would using
> credential_clear_secrets() here to replace the equivalent lines.

That's certainly fine with me. Using credential_clear_secrets() to just 
replace those two lines would definitely keep the original behavior of 
this code.

I'll send a v3 patch to do that.

-- Aaron

> 
> -Peff
