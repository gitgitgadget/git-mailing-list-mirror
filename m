Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9F1EB4A
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="L46hZ5iH"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2094.outbound.protection.outlook.com [40.107.116.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D78C0
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 05:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btcjw5rv6LpHipAXaf+Tnd+qz40EYI26ib2UkhnaiZYpRs/DV2ollOACbMX7uqCIcbXsVKlIEirTMEz6ACu49QzdG4dFWg9x2us31oHmCMhppbF21TDMZ72PohKR408Qw+BZYccs4Yxge4YLvTduT9OWbhXT+RjYFSwY1uhF0Btyh2Rxc5u+D0BLiZ/gWimk+cMvT00URpXsZTPclLZre12LlS9JsS3IqS33hA5OMHmzpW1KgE1BAdNal0S/1Fyh0EyFyC1n/BQJ4rRXLgJbn4liSUp5skaTB2jjaeoxqHKd+m3TJnEItJXa9ZDF6EC0DGLph5IXDgeHoV+4jkhpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NEqFft5MTEzMs9UJORtDeGc3u14rHccl9uDEgzzINg=;
 b=OegYKkUvQu8ZQ0rX+5AfNntQ4IEzxUobxr0ytOXYZ3RQyVj+JXppZ2LgYFkFUjPbwJF61fekFjQLkWfREElX4GJyCVH2MNyXezOLoidWISQbZxjosbkraMvZRyDT96rD2qUQOPfoebIQOUzOalIWmvlUNEdlqOKsSZbclCtObsRVoP2AIcQapoWn5ifFPEzifx3KiJ41y2f0JuT7B3sqEvYl/7Af3wDxpqMv2d1inUMJcR1lj3noufFIMRfSHtPb6gUrv/PMZPQubOWSIOd6o1dPJRhQbqGRCifzrgkIhfL2C1l96wjaYEUdijGot/S1+LIvQNj4MiTppFFsml6hyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NEqFft5MTEzMs9UJORtDeGc3u14rHccl9uDEgzzINg=;
 b=L46hZ5iHSVCV5rYY7arGSsPTwgLzGk7vC/kg7Jcx0k1bUcIZ/b3n1NHJdAVZjPSKmo2KryPhO7DWDkJNpJAqmFig9g7edcSQDRCbWZTaCLORJoHTjS0cHsHB10opjv3IdOZWY5mR4lnewumfUoFdT+cUZDzMLU+1rWB1G4B8EEgdX+ykj4DNJREDnm3dLbj3Z4Wc1jUfJWHlbCCCwEjUhcbn/gtI6OHtuh/hTGHjBDZzC0BBIZbM13MtwqrffyrFId7RCfUG2y8L2QRzbys01Vbbf0Xkzz5PLu/8CNtKSBpPHPRLgqVwCK7pRx8EPK0+TtHeTAuwFpkUnz02PbSWcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YT1PR01MB9517.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 12:39:04 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:39:04 +0000
Message-ID: <b71d066b-104a-4c60-9319-b3c635be6efc@xiplink.com>
Date: Fri, 27 Oct 2023 08:39:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <e33f919d-1b6a-4944-ab5d-93ad0d323b68@xiplink.com> <ZTg0zXkvSQ6L+4Oj@ugly>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <ZTg0zXkvSQ6L+4Oj@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::26) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YT1PR01MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 951878fc-4c1f-4581-05e9-08dbd6e9b437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ziftYHmp/wkC5onIh0ePO3mdE3y+6rg5Vd9/xtPKDsNCMvMdLVGnsBvTIsuV9FD+zhur3GTAOX9jMjhGDWsjLbTOaslpD3bGlrX7/zD+PJ6+fiJ6yg3I7mHNEpWqVfVYtQ+GX6uDv2gRQHP+ars00fhcXqXf0iRtZ19yikl2EJWtSNgZzontOOsJPI2/S7BRtQwGcuPV2BjlVPBqRqWyZ5OdQPNohy3tfbwtYnZMPSfLdElz85L9DudbldTUSw+04uzf1OoGg9QA/sgZ+7V940jFDfp9upLMpQqj3XeJTxT2fagwjjZWoIdNXneBQOoU9H6sJ22QD3XuTy3WgizITlv9kstB81GD26onFBUO2jJ/ylm41wV1m6EHr2Blk2B9O1M/3K5dF7Wb5/6xXW7Ky5zFKh65Q195opfp0x544vG7MeiZ5yl+mKS7rmqtafFu5oBOoYufdUSScTGIlpuwmtWkBXINc03izG0RnhpoZlJsa7aee2/DQ3m6CRle8EZhPdVheoZJ9pJsIVOEUSzwoSVctfGqiFoueHuFi/jmHkqRLBJp3dnIb/aCb42vExYHd6M45zOQ+/Umhs6H3NRZUTHegjpurJRdccyJVfaFVO1Hq6X05l81ZQIA0OXTGmd3u4V5MQPHQmvf0TkUAojriA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(4001150100001)(6486002)(4744005)(31696002)(66476007)(38100700002)(54906003)(316002)(66946007)(66556008)(53546011)(6916009)(2616005)(6506007)(6512007)(478600001)(83380400001)(26005)(41300700001)(5660300002)(36756003)(86362001)(8676002)(4326008)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1JKdnJ1eG1la0JVZ0Nua0p3UjlTRmpSMjBJWUlHZHJ2NjdhOXZNbFFwTkFY?=
 =?utf-8?B?S00yOC9tWE0rZGk0cDdWNzNPaG9leGltd2l1NzZsZ01lZW9aYThrcWRuUkZQ?=
 =?utf-8?B?a09Ea3JiUFpBL0xlTDhHdkM3N2E4WmlzMXltYW0zYkI3ZTk1QlJGUWM2bzdq?=
 =?utf-8?B?VDBlZXVoRTRKWHh2OEwwbjhtS1BCYU02SVBnTFdIdldxQWppM0s0cE9hTUdH?=
 =?utf-8?B?SkNPdW5QNE8rcUJCckc3UmNuOWl2S1BaS21RY3dmZzNnWFhySFdXSGg2T1Zm?=
 =?utf-8?B?Wng2ODVuNnlOQXIyV3cyeXJic1BoK2YvblNkazVMOW9ZZjZGekliOXFxYjVP?=
 =?utf-8?B?bjRKR2d0YWVUbm9QYzZPYWZmSDJpM0w2MW4vSUdUVUJ3R0lVbzB1Nk9EY1Fa?=
 =?utf-8?B?VnhaNHE5VWZOQ2xMalJJMFlXZ29heU80cFI1TXR0dUhSWFlCRTY1MTZ6NmpY?=
 =?utf-8?B?a3ovbERjeC9Hd2cwNXFsaHlueE8zZk9WVXdTcnoyNUdxZ0dmN0E3akNvTVlB?=
 =?utf-8?B?YUNoelNXd2s0SXBuU0UyM3poRStsRmJDYWUzOHlBUHVDM1R3ZGk1K2tOM3Zi?=
 =?utf-8?B?N01nOHl5MkgyaEtkMUQvd05QanYvZmJlZEd5RlNWSjZ1Vy8rRDZsREU3VUVu?=
 =?utf-8?B?NG1iclhSOVUwa0xwaXVoZnlPRS9WT2VyK1psM0xlZ0dSM3hvL05KWEpNZWVm?=
 =?utf-8?B?T0NRNjhlOHBhbjRveHFXMndCN0ZYdUpRT0xaS0hhM2tzTFgwWjZUU3dTcE8x?=
 =?utf-8?B?MFhaZ1pRZy9FdTVFMWdEc1ZIL3kxQlpJNXRtTWdnQzZmWDA1bVQyMXBLVGpn?=
 =?utf-8?B?ZzFIVEhTWU52NGIrbnRkMXJJajJobTVHZ2lsSVhjaklsWm1UZ0U3WUxFSlpt?=
 =?utf-8?B?NmZ6RlVLZmRMaktqa2t4dWRqWTNwaHR1NmlFZkNOcUdOL2xaNEx1UkphMkhy?=
 =?utf-8?B?a1d2U09vRUt3YTBTQzk2QXo5bTU4TUdCQlNlM1NLQUlycThSMHFrZWJuTXll?=
 =?utf-8?B?WEV1N0VlWU9tU1dIT0VkN29PeWhlNEJqZkEyYm1uS2x0YUpWNHZRb2xtZ3Yw?=
 =?utf-8?B?c0oxQUdzOUJubGlyR3Z5Qm02bzVCdEszYkx5NkxDdzJaSmhqK1Vua0R5eVF3?=
 =?utf-8?B?WjArazd5WmRKTzZnZmtPcnRPSlJoMWo1WUZnRHNZYTcvSDd2Vnp1QkdGaEFs?=
 =?utf-8?B?NHJKTmtXQ0ljQkRuRXhjUTJIeG9MNFZnRWlxb0hxS0haNVBWQ1dwL3pOUjlx?=
 =?utf-8?B?clFjeFlBSTFVci85SlZxOXRLcGZpMGl1N0JNWUdUbFg0OTAwengrRVo0VFhY?=
 =?utf-8?B?YlNtVEtlRUwyaG1FMzk2MFR2Unk5WTdWQVB0NDlkbGI1MkZkRHAyVUp4L2Jl?=
 =?utf-8?B?L1NLYVRsSzJQbGlBdUMrN1hXVW1GeHdYczlKWjRGazR0bjA4UnFqMWMyVkl2?=
 =?utf-8?B?eGdPd1BKQTNZSzh1Q044VjNlbjFRcHFRNXdmeVpiSDVIanVyU2c0aURWT0lI?=
 =?utf-8?B?QWZKdDltRCtUTG02ZnpYU1R0aHNvam9zUVVTSURJMmdGcU5maXhnenRTWUZJ?=
 =?utf-8?B?bnNOSkZ2bVhtblBacGd6UmFlQWJrbHhBWElta2ptcFRrSDBZQ1h4c3A4enBT?=
 =?utf-8?B?YUZVY1lRSStvc1lJL0NxbURnM3NTa3VBbi85dE94Zm1URVE2Z2lUUXFwK2pi?=
 =?utf-8?B?VGRaNGMxTlpjK2hpeUpmWVFtVU14TUk1V1hMRUR0aXEzMUZnUEJyZGJ4NzU4?=
 =?utf-8?B?dVhpbE81N2VUZUdBSlBWUDdLcXBlNEh3aXBpV1BDQkRzQ3h1VUJ2TDA5bDla?=
 =?utf-8?B?WC92QWJOaUVrNURSR0NESU9vdUg5KzhFdXc5MEE4djNxVCthcW5pRW1rRzhj?=
 =?utf-8?B?K2pPOWFmUnd3OHdKS2hWSWFzYWtZTlYrYlJCTkI5SkpDMGV2UHFFMjVPMGJE?=
 =?utf-8?B?S2JNaG1oSGhHMG5yd2ozVlVEbko3TEN0cmtyNXhhdHV2TVJEN2s4cWhIVE1s?=
 =?utf-8?B?VkROcWRGQ3JuWlhSbjBoRmJIT3RIcURoUmt6MUNBVkdtYWtiUm95dXo4SHRs?=
 =?utf-8?B?WkF4WTI3ZE5OMjZvQUNneGJUVGRGem1SbHFGQT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951878fc-4c1f-4581-05e9-08dbd6e9b437
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:39:04.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+tR4UBTy7KVAAPHAUBEEiD2t0Bz3k1xeYLX2TGaAHyVmAf5Q5ctIUyQz7W7PfQTvIAJVoNJbVUY4kMjhBnnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9517


On 2023-10-24 17:19, Oswald Buddenhagen wrote:
> 
>>> +The commit message for the folded commit is the concatenation of the
>>> +message of the first commit with those of commits identified by 
>>> "squash"
>>
>> s/message of the first commit/picked commit's message/
>>
> that does indeed sound better, but i think it's more confusing (and 
> potentially even more so when translated directly). i guess one could 
> use "pick'd commit's", but that's kind of ugly again.

Let the translators worry about how to phrase it in other languages.  In 
English "picked" is the right choice.  You should not presume that other 
languages will want to use the word "pick" verbatim.

		M.
