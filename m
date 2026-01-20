Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26A33A704
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768882308; cv=fail; b=qV/xCVZ7A7srBrBf+Z1HXYwU+jB9taWGuunnYjY6LGkfHPSGFywqiTwha1eyJ8G7F54J2wiFOH82UiMdGiDVWWrmUKTIJJBxx6hqy/dEpTlh8dNvJuozUgKNqI92v+63oMah+U/fxUVP2ZTHU5FTaw8gmcmm/5jkp8dsrrRB3XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768882308; c=relaxed/simple;
	bh=AYsulnTBr+aY2Basncf3aK/4VGxbY5k6LHmqYOc2EP0=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s23eL5jIolCadeI4hC8VOfy5feKlqsLJn9rhIjylelDC2X/b+BVVSDzvfNbRxtKkivQvfATx66QMpghL2jMx2zmWScKlIWiqbnixX1C1xumo+2xH0wdqq6CkQk5QUMy+2OCNbeXWYc7wadaavmimQ/dwNsdGnLEOhAkLhgEB0JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QLFgDQIu; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QLFgDQIu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEXRchq0KFd0mV+0q0dGwBc8UYM3FpeoI6oDNolyySxv7RFWXrE9520AUE5xHuUztJSs0eirEhh7iDRrgHi0rvwXTBgFn7hBR1x4l/Fm2w3KKD6BY/5Du0CJtJvy5vWpYSUdGj5PoiI71tutW0E31rIQRp5UeE50P19QhOY2RvPjrdXErODWkxGpa9J8ABplhK4yqb7dVQ9drT9hYskh1+H1iswtR/a5rWrhHhMuiz4sR/dg0KegcYpdVTB4zIEIv5B6ttdib/d0q2dbmf0Wgj8nlZfL9ewFG5RCDamsdc030I4dXkXc3/pa/72wH7/1EiDphpB97wMxoT1hNj5elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=550f0xQhQHMcgm7HZSsNKaCKWra+KixB4W9T3yp2dDI=;
 b=Q3Stop/yyjQDrvT0c+7ZeAWTxSyDzXraOcXIQPCoMkhS3HhS/zXeTzpWitoFg4ZN3Ulz0jf1JNlZWydQmV3nZbiFGwFTQbCfIg8ende2kcEBZ3UM8rSmGBUWB/A13SsB4/uioW1pxjS4+KTHFTDgMmxDVFymh0FOb4Q1owYqGwHm8H3UiotREcDXZ+ojopezOSbWj9/0p25GMCqdeqt1J0CTL5t6ntZgftO5n7XObvlThSPzToTyQiTiQHP4LFeU3FO/DqWf62O60jZBI9K8KUnTg0ZalRSOteWwAznTkfJ/t6aQnKrbPPGrRrU8b+Ajg2eAOGliEd7LMKaRdBFfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=550f0xQhQHMcgm7HZSsNKaCKWra+KixB4W9T3yp2dDI=;
 b=QLFgDQIu11We4GsQ58cv+GNFv333BBHPIggy4gD7J55/2WULlLMadtILPl6JSuVhn0qTYmBtE71I9gcTf0AU6H/ZP0icdcZLtXpIMe90SaPiaJ0N1ZUN7CXMy9YWnfOBpc55ibpSGJonfNol+Cyb8Szc8SgznjaPAFzMh4ZAZqsN7L2rYb09CsVVRXoMMD4GhMfNXkCCn8Ow1ZUlXUqBtnMbX1m+UrhIDIZU8lUOlVsVlF5HlCOFOXGAO+C9+t+3lwnxvnV9rn79E8lCcXSOmiX+T4xuNGrJ1XckmsRCDhYCJkrQGBQgPOxTqSANVTp1h0JUOJum+i6p3BnWXCd+rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 04:11:43 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 04:11:43 +0000
Message-ID: <c54848f2-f389-4eec-953b-c44c3532deaf@nvidia.com>
Date: Mon, 19 Jan 2026 20:11:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jan 2026, #05)
To: Junio C Hamano <gitster@pobox.com>
References: <xmqqldhybtqs.fsf@gitster.g>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqqldhybtqs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfcc716-5ec3-4c19-57be-08de57da04df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WERzT2FsN1pObU9aTFNVbCtlTnBrc1J6RS9ISzJVZjJXOGQvTHVhODd4U1kz?=
 =?utf-8?B?UGU1L0VDY1RPUzc1c29XRG84V1FnbVMza3RwQyt1UWwwMmRSRDVGVlN4aDhp?=
 =?utf-8?B?Vm5teUpIczNuelI0UVZ2OG1lL3ErQ0lhbHg5OFdwUmczUnhVWkd5Nk50WjhH?=
 =?utf-8?B?TjNZN0piRVhNWUR5WC8rTElobWF5OHlDRDN1TUdEMXRrRG0rZlFGVGhMQVlE?=
 =?utf-8?B?NmJEYXNmNWt6TENacUo3SDVweGJnVWNRVzg5QU1jSEJiWmdibnRnbmo2NEp0?=
 =?utf-8?B?Ri8xc0ZLaGwvWTNKb05BbTdQUDRpb2E0aW5JRHJuK2Q1SjNmUWs2SVg0aXlo?=
 =?utf-8?B?MDZ4WU0zMVYwb1EzRTdacHNJbG9XTlhEVTdQUFNYTFVSNmhZZmZHaVV6Vlo0?=
 =?utf-8?B?d25qYVVodU9oME9DTy9KOTRLM2p6NnY5RnMyVUlJWFVrWVRkWStYY3loaXJU?=
 =?utf-8?B?Z3VWVE0zeVc1UE4xVm5GSlpuNFVON2FRaFA1ajYrSlBpb0djN3JHaVllZ25B?=
 =?utf-8?B?S2gyMWdCcGNUTFNxTk1rN2lpZ3FTMU0yb3NFRXFuZ2RScXZ2WVhadGQwYjlt?=
 =?utf-8?B?SU45MHJHV0xpZkJvMjF2VkhCY0QvNHU5NDd3YjBOd1pSNnpGNW9LMEYxSStC?=
 =?utf-8?B?bVlhblZacWpsU3AwK3Q0TUs0MHNTcHZsa0s3eEFISTNaT01FSUNDMjBWc09Z?=
 =?utf-8?B?ZE51YXVRSDZqTU54dWFqeVhKQ1NhYmVwanFNYTFKaFIwTm1DS0dtcERnVmVw?=
 =?utf-8?B?V1c4QytuS2QxZys3RXgrOHlGcFZRRmF0Nnk0MkJIcXZ1YkpYSEdrMmo3WFhE?=
 =?utf-8?B?cnlKMHUzWjYzSWdOOGhlYnFrS0xPT3g3ejAyNGRQYWlnbkdLU1hxL1pDcGcy?=
 =?utf-8?B?YzYzNEgyR3BsbHYvd3BZT1hnQVIyOTY5WHkzZzhKR0pSQmhuQjVLM3Zrdm5L?=
 =?utf-8?B?dUVCbjRjcjVVREc1QzNlaGpLNVhrTmlKZzBjTlNTcUNucnk0WnpoK2ZhSUgx?=
 =?utf-8?B?ZTBWSVZSOTJQNmpQWVN2Mko4RmZES1hEbUQ1U3J1amZLb254SGVqdnI5RnhH?=
 =?utf-8?B?YmtvSVV4Uk9FaTJpdGdNVmdjUWd3WVZYb2RVcDNZMngyN2JDM1o0ZzVpaEUx?=
 =?utf-8?B?TEpjZC83NHl6TG0rRnFJOGpXTGJLNW1EYnJ6bWNDZndVNTBxMVNjb2NCc1Mw?=
 =?utf-8?B?UzJkb3B1bXFuSFJnTFRtZlhqQjRMTEtBcFhGVDZGMjYrZ0dlT2xraCtZYnVP?=
 =?utf-8?B?SCtXZnVmdGE3VnBPdTNQZ2k0RzBQU0NVMExSZFNpYnBYSDdGdmk4MDNQa1hX?=
 =?utf-8?B?UlNuQ0JxN1RPVWlnRjlEVlJQcW1SZFhrRGlZWVNOVTRpRTZOemIxbnZvTEJJ?=
 =?utf-8?B?Y0FJdEhsRkJXL3NxNUJOenl1UGNObG5MNEZSK0pMQWpvbDNPMEZLN3h3ZHdK?=
 =?utf-8?B?cTUraytxd1BJeUtoRW9Jai9sbmgyaU5wNXB5UStXM2taQWJyeTdaVm9idHJT?=
 =?utf-8?B?YjJzY1BVSDUvM2RnSUs0RVdpVk9pTVpmY0JaNTVReWY3bkY0Y0ZSN2pLMXMy?=
 =?utf-8?B?eHZqN1JUOXdYWlB0Zk5BZ2VTVThiaGhhenN6aE5aMHl3Qm5CL1Vic1JCTlhT?=
 =?utf-8?B?OE1YaThwcUdVRDY5WmdjT0pRRnhhMS9NWEJMazJuZC8vdVhJaUZ1b0NrMG96?=
 =?utf-8?B?UWxMbktDbVErMU51d0hpZjNDSFRQbXNqWWVOSHZ5UDdRbndZTVpySlpPMkd5?=
 =?utf-8?B?ZFJpUWcyVzF1L2taSFhxY29jRzZxeUhsa3hoclkvc1VqeENCVDdyTFRRYWZp?=
 =?utf-8?B?WnhUU2g3LzhoWjQ4WW1lQ0hvdCs5c2Y2d2ZaTXNWSFlaR21uUFl2TDFFRzA2?=
 =?utf-8?B?L1hpY1dIL2Z2OXpJaEgvWXFwSFFLalVzNkpOTUZkb2J1ZGp1eDNQeWRSdVZw?=
 =?utf-8?B?aHNMRHhxcU00ekhaSjVLNTBRYkg5MExtdzVnQ1d3NDlYam5tMDN5amJuV3JW?=
 =?utf-8?B?SWNDR0RxejRTU0NUWFpmdGJjSU82N3VFbVoramxIQWRkWStpcGRqaGxZdDhN?=
 =?utf-8?B?cEx4dmJFVTRNRTM0eGRkMnZHZXl1VEJxTTMzdnYyN3NKa2hGclVsaVRBWHZV?=
 =?utf-8?Q?CiVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0tXekdZT1JZbkNlMThSaDhjT2JJdFBLODlZUHFoWSthTnZOYkpxSDRZN2Z2?=
 =?utf-8?B?ZUZucjNoQTRuUlpvOTZxRGpxZ3dKQWt2dW1Ka2ZZeWlZOU96TEtFZWNCNkN2?=
 =?utf-8?B?eEVnbFJPSTlUL05tc2t5TzRoNGY0dHNGRGYxVUxEdmtQZnowSGhYQ082bTlw?=
 =?utf-8?B?RVh2YVZIY2taa0VTcEhLRWtJdFExTkZkdWt6eGt0YVdVTi9IN0luc2s4Y0VI?=
 =?utf-8?B?dVJQczMwQXZSNi9qaVFoeEF5MC9PemdDRVlpV0srdDY4aHlhY05lNGZsell1?=
 =?utf-8?B?a1RTaUxWakY1Q21vM05tQ0JmeEE2aTBIVzQ1VlJKbE5IRmR1SkUxUTVqVS9k?=
 =?utf-8?B?STlwRlhvdklPVDFvKytjQ3lRVjh0Zm1INnJ6c2FxTGxQM0N0NlNXNXJQVnVw?=
 =?utf-8?B?QWs3THF3SG5ySlpodjFsS3NVMGlWcWYvQVEwcEVGOE05R3hmYk9xVFZ0TUha?=
 =?utf-8?B?K0JXZCtFNlY0RTFveTc2dnV0WGtoYkMxd3pITHA2WDkxejJWWS8zQWs5Q1hI?=
 =?utf-8?B?U3JKMisrL2ZLNnpVdzNkYXNTMGJGSCt1akdGSVNQcDZVRU1oQ2dHejN6UEda?=
 =?utf-8?B?WkFZMXh5VEtsMXhRaEdjWDUvYWJmeW55eU9rdGlDSWlIU2k1Y1FRbFFDUVZi?=
 =?utf-8?B?WGRwMWtnSGRjdW44VWdObjFoYXhUYjQ1QXZZdlNSTWR2UFVoZWRNb1JKcnhN?=
 =?utf-8?B?QU13UGFEMllWZVRNSThBL25lMDRrZHBUSGhXMk9FUDNNZU91a09HNWc3QUtw?=
 =?utf-8?B?NGlRQWc4WHRTelJRUVRNK2R6MnAzYjczUERHTDJUWHpiNk1hZXpmV3QvaXJM?=
 =?utf-8?B?cDR4aE5GT0EwcytHVHRibWlYV002SVVUdSszcGF5aG1uaEFuMi9MVTlFU3hV?=
 =?utf-8?B?dGtEV3g2RlRzSzk1ODJMQWU0dk1EMVM0NHJhRkwrVC9vZWlwT3VwcGNWUEpZ?=
 =?utf-8?B?WGVwdmpmUzMwUWw0elBlOEgrc2lYZWc1RmxwU0VBY25yemhFMjQ5MXg3T3dK?=
 =?utf-8?B?aEtOaFlDeC9aNitaNi9FOHVkZWNpazVIS3p5dndIQ0N4Tm1JS25STVc0dTFG?=
 =?utf-8?B?Z3lvNHpjb21FbDJibWdWME5OMXhJOS9sb1NoYWNaYVczeHlXeHRndFR4eTlI?=
 =?utf-8?B?aHhNVUY2RnhEQTM4OXZmc0wxRFRpaWhKRlJUQm01anJLZlNYaHNrenFBK1Na?=
 =?utf-8?B?alFZamQzTDV4QWR2Rmx0TmdtVTIyVlBkc0M5Qm1EUDlMNm8yT1psZnBVeGtw?=
 =?utf-8?B?clViWlRIQTBXQzFianJGZ2M4NGV6U0MwVjBlaFBQNHhwa0xDTCtOTzBUMUJl?=
 =?utf-8?B?NmNTMkxWc25DYW8zWXNOWkpxM0VGVkJ3ZDYydGVhTlBURENhZzBvSGIxcXJh?=
 =?utf-8?B?ZVZpYjhUMk5lb3ZuUFYzNko5Q044cWR3cGs3dGxpOTVTSDJPSUJ5WWVTTS9M?=
 =?utf-8?B?dnZJMmJsQXB1UnloVmRsckRUNkZjalZsSFFmRU5mVXNmeHZna0EzY3lCY3hW?=
 =?utf-8?B?UjZPYkorS0UzbUFRSGQrY0tqSTBPTDdwSHBwT1RYYk5lRnA3dWhNRDFybjQ2?=
 =?utf-8?B?RlNFd0JMUVJIc0loalVsWHl3N0tyVnJWd3NTZGN0R0NGT3NOL3VabHBWRXMy?=
 =?utf-8?B?RHlESEpVVVV3bS85UnFEUTBSR3FVd0M4VHh2aXBCKzNCaGFSeDJ1dEFKcU5Q?=
 =?utf-8?B?YVo2dUJiM1VOMHRYa1pQRUN0dXNKY29WS2ZWQnlhM2h1d2d4eVBFZ2NCY3Qv?=
 =?utf-8?B?TUs3T040aHhFMjk0UTRyQUpYTUVlbDF2b2VTbmorazJSRjlOaExwand3bE9s?=
 =?utf-8?B?Qm5tajUwS3NJWmliWkRQT1Bna09ORWlPdmh4OFhHVEVGSUorQ1VlcEtVVDNV?=
 =?utf-8?B?MngySlNId2FZVWxPTUVobjY4MldnUVJ3T2VKMHlLc3FaVWRwWjlqZUZ1TDhG?=
 =?utf-8?B?WFNwTmNWdFd4dUtKTVNBem9QK2VPenh0WHZEeEhzTSt0REdYZXNvZEN6QlFN?=
 =?utf-8?B?cC9xMlZUOFErWnY1aFBqbld5MHV6TDJiUXNWVFBXWWRaTFlwMjI1TlprdElp?=
 =?utf-8?B?dTRKK3BBdG5NSlU1b1hxa01xQTBLRjByMFFqVjh6blU0bytyV3p4dzI3aE5J?=
 =?utf-8?B?a0wwVWFxUUpPK1VIaWljdC9zOXkvRnNCMTROMVFmVVBUeVZuNlZZRXE4KzU0?=
 =?utf-8?B?cnB5Z3ZzVGNFV1BmOFhZQVJBQnMyU0JHenNLbHdISzBkM3VyVUQ2R09KWkJz?=
 =?utf-8?B?bHVJcFFldkFIRDYrazNCMFdsQytJTi9Ncm1yL21LcE5IbklKRW1NUzFEc0tW?=
 =?utf-8?B?RjY1WlhTSlJmZ3BscWs5bEZCZzdMY0M4elIxWnh5dkVXTGpscHVTVjdZSmpp?=
 =?utf-8?Q?lQr0gZDKpg3nJOQQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfcc716-5ec3-4c19-57be-08de57da04df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 04:11:43.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCccbBoNEUW+7y70za7kPuiudx+SS/wue8OXERxvlN59r4C/WG1yejGNlJKZ6KgxAsyEK0SxO0AiLxthLM6v+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

On 1/15/26 10:44 AM, Junio C Hamano wrote:
> * ap/http-probe-rpc-use-auth (2026-01-14) 1 commit
>   - remote-curl: use auth for probe_rpc() requests too
> 
>   HTTP transport failed to authenticate in some code pahts, which has
>   been corrected.
> 
>   Will merge to 'next'?
>   source: <20260114163619.614297-2-aplattner@nvidia.com>

Yes please.
