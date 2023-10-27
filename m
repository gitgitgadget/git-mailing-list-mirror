Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28C1A738
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="D4Ab0YiA"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2116.outbound.protection.outlook.com [40.107.116.116])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316EC2
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvukBgQDRJu1e0kn6TLfKe8lQHBnS3RPET0BsjrnVGcp73a8InYgY/RHENTUd3UieIe6cOt7snK/5/N+OmCqQDOGaI5WWLx2V3nEmvUDi06lL3b6WzFbl+zJY/v8BbKmYQMmo5rJKdpkxlmPuk6JWHTg+/t4gDVms3aniqvVP3jXM1ddVTonHARfn6xA/xHjTc/lgfgPirXldVdLDqpMhutVtUyW/FLYDWRaV9vneDeknZH5pyRrNSCGt2F15kUl3IdwIWs/HB4LatwDZkmdTCr+DaQwLPisG8yeVD9RCsSGGqSbERDPmnvKgcjqfPtOeCaoi/ocr1dn0uhEoZ1PCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rItCX5XXB/vVHHgiIeBq8SmsOsBlydJ/4htg4VeQj4g=;
 b=ZdQN4N0F8C1VDgcpaJSIM8DUZS+seWPIQetvCTg56MoNIETrIASugAu8HiINDBAokIeMlSAufZY9xPp7A/tBp+sSiu8F/Vmuo5l6pD3cwnRL2Du1w9Ac6NGFz88DhWTOjpVLR8Q4jt0d8+ZRYpMjAx4VByi3alc5392mEvuGXI/JDh682bLvN9v2Q06HOZvylWDyD8X7TEfImbU6WONMysYxtg5j1U6UPvRUgC0mqUqH+tln0ypiX4tf5Q9LL5Hm7NrT+2lyu1ZzuFf3cYk9lJKQXuu1HhxRglbUb38q7loMor461dMHQYTokSYehnik/cp6cm6HaJCnbevw9d23qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rItCX5XXB/vVHHgiIeBq8SmsOsBlydJ/4htg4VeQj4g=;
 b=D4Ab0YiA/hJi8HNwaBZnKjTYbuRV2NAuvTy+QArUZC6j/EsZu6Id7waDompOjmwsYXfI2OdLNFDGezRXsOSCc7586scrnwrWV+dN4oO479638vdvOcVp3zJ0PxSwkHmPa0urpAF3RkG9WaIBGuElqqTbiZ2z2EWQ9bWAJBTAqbDsf7Cc2KhPJmCyRUA84//IqOQerwWVqPxpQQZCbeYdyRp6nv+AsDAqJyx+tLinHYumKZzIcus5jCUC+oZccNI8rB7XPllTSxXWA09x3gDf6gK0eNAIzHOKzwEH/nq/eg2xOJf8nZaGhyc8LLLgWGV3e+3rXQ+ThWIMTQyyGZNaKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YT2PR01MB10790.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 13:20:05 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 13:20:05 +0000
Message-ID: <6d100655-ffd4-4282-87b5-cfdd101dba63@xiplink.com>
Date: Fri, 27 Oct 2023 09:20:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: using oldest date when squashing commits
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com> <ZTeZ3KEQLIVU/sq2@ugly>
 <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com> <xmqqpm143p46.fsf@gitster.g>
 <59731c05-c3f6-4815-8411-783bb1c2aac4@kdbg.org>
 <70b8d4d8-f4b5-4cd7-b73a-1d7393d84266@xiplink.com> <ZTuw7ziOnTunMmML@ugly>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <ZTuw7ziOnTunMmML@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::36) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YT2PR01MB10790:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6c00e6-36da-4673-69a3-08dbd6ef6f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YeL22gpnU/J7Wv2XqTadi7o3AFKqM9iHPDRpt0f49OdPVDgCsnBdfOLrn7/aEFUgkOFfgJjdci1hWgSAYk+dvZOyoRhsCIbRTE3DqPoEth2rWL8URfq4qWBFJ9I7ClII8v7kUFxd1KkCYm1eRx8MEekD/pjQ2vyHMT3WyGvZybO+RvzjfGTryj64QUSb/49aaJUkqZ2L1AKPVoHhBPcJ1eag5lwu7MrsPUmw8V4hqwbJIW5/XYyYDkjdMc0TGSSo18LKE4yei7ciC5zsVOwQQdCgN48o1wVKkQ386ws2PResoph7b7V124dewSg802890DW/kQOpBQA4paI/8FzJF4icsQBH/PUpUdRi+4gY6ri8v37ey/nKX7sMJJUOn8nFJCbQRrMxsiJX9Vh4ZWOg8H6L00lshAAyotKYqHSM72qF5njH0146717Fu+/1eLyMuufCSKZo43TkRmezqZ71uJBfbzMttqPeffxuHLyf0ykuy3T92LOgmOn2AbNNkLq0wbScX1NuzBjs07omeOjXuPdByUgfy9CKHz4eu7XUz3aQc0QchCdGLnh+KtUryOo/EYQJexV/CPQ2krCBDv9MCYvdEuxExpRtpOjXi7F2IptN0UVw7nvIDUyKsNDVCt+JxsohM+pL9mHxFJQogI5Meg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39840400004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(6486002)(86362001)(31696002)(38100700002)(478600001)(36756003)(53546011)(6506007)(316002)(6512007)(66556008)(54906003)(66476007)(6916009)(66946007)(2616005)(26005)(41300700001)(2906002)(4001150100001)(4326008)(8936002)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlV1QktNWHpLNHRKN3BLODc2TVVmTkpZd09iRDhQdE9GZlZwVEFUREp1WXNX?=
 =?utf-8?B?SHNobi9ZeXl5QTFUWDB5UVorTmt2dlkvckxmNk1HZFc3OG84Y0VtVGRoNzlS?=
 =?utf-8?B?V2lJbDdPS2RjWklYYnM3M0JWcWFRSktlMTRQOFdaaXB5MldBdDYvcWZOdUR3?=
 =?utf-8?B?WU9ZRTZ1SlJjRDhjMExKU0FmMC9LVjcwNWFZOFBwZVdYZTEvckpiOXRUY1lq?=
 =?utf-8?B?Vm1mMXpZVU9wYnBKRDB1ZFk1R085d0NETWF5dENjT0RNWnM4SDBVY3l1Unl2?=
 =?utf-8?B?VEJPWDQ2RHdRYjNwbFJEeHNiem9aMWRYckhCTlBPWVN4QmVNZldWaFNUMmFv?=
 =?utf-8?B?RWFGalA4NDFFSG5jbnBXYzY0aGhQVVFyVFJjOGNCY1FHdWE3eXRLcGQ1T3Ev?=
 =?utf-8?B?RGtaMFhRa1ZMdHpFV2cvUFRyRlV6dGE5OVFZM2RnQm9VSGcrZllMRzJzbEdL?=
 =?utf-8?B?SVpYbEFNaU9yaXdteW9aOHMwQU5qM0RIKzFrN3Z5TzNENzkvRWxVRlFjcGJE?=
 =?utf-8?B?d1Y3dDFHbVV4by93WkluRWRKVHB1TzZoVTlqNUxXdWZpNHZRRGduTFJIK3NC?=
 =?utf-8?B?WXd0eFkyUm9pZk15dVZzMGpDTHQ4RmxwdmNMVnc5bThHVnVQUnBDUXBlTzk0?=
 =?utf-8?B?N21oTkQva25YYVZ2Q3NrREN5VXBFYS9RLzVFZjkrbEE3Y05HV2Z3aUo4TXln?=
 =?utf-8?B?Y2Rmc3dPMWV2cys3Nm4xdE1qYnBlZmpaa3g3MkdVL3VNYTFiUUMvZ0lQY1pL?=
 =?utf-8?B?eGk4VHNnWFlkVmN2WngzRWN0R1NrNWZxQ2ovRWpMMzIyZW5rWjZ6aFlhUi8z?=
 =?utf-8?B?WXgyUzZIZnlSWjBGYWptZ1laWnY3eURiNDlneTVLSnBQMWFBQUhpVXJ1VkY0?=
 =?utf-8?B?eHQ1bXZXQnlzVEkyK2t0TXFLMnBUUUdwbzAxck55ZzY0blhWOHVMenViMWZR?=
 =?utf-8?B?YUZWSmxORHhiaTlzUDhTSHhyWU9URnNkaUhJckRJblFvVnpIWGxjcHJwOXdo?=
 =?utf-8?B?MXlydCtENTdXZFVrcEhPYURPNHdVbHVwKzFrSmJNcm96UkIreVhobEI0TExt?=
 =?utf-8?B?V3R6empWTzVGWHpaUlhhc0hoQjdoY0Q1REpxNTFXaSttYVJ5Z2p4UXAwSnBQ?=
 =?utf-8?B?SGpRRFZISGVlL3lPazNlQnJ0aER6My8rSGIveWNOd2V4WFE2S1E4TmRndkU3?=
 =?utf-8?B?OGJLNTJUNDEzYzRRdlpuV1RVWkFIRVVPb2I5S3U5VEpyODZEclVZNVpPRGFr?=
 =?utf-8?B?cVpSQ3lXOUtmNTBTZmFRTDdoeW0ySmJSVEt1RDk3U0VmSGVwbHhUNDZ5b2kr?=
 =?utf-8?B?Z3Z3aFZDSzFQVC91dWJWVFpxcDc4ZmIzSnlOY1VnN1FFSmpEemY1QTIvVmdB?=
 =?utf-8?B?MVhnVXRwbUIvWnlBWitRQzBadWNwQnE1S0t0QkZJbFo0RTF6a0NmUkxlbXBR?=
 =?utf-8?B?TzdJVlJ1N2duOVE2c25QUVdpWkZSTWdwN1VMaTZNZWFXN1gzMzYvMm0vRDJ3?=
 =?utf-8?B?THA0MEdLTFlOWTM5aitTWTE0di8rcFFUR2JDdXlUQUJ5WHFlK3pxelBnanhX?=
 =?utf-8?B?Z2pPcjRybWFFYzdHb3hCV2pvODhPWW1sY3V1QzZuWjBNdGJCT285OGRQeUNo?=
 =?utf-8?B?WFdqd3Z3VGQ4M0k1K1BaU0ZmdFp3Mkpyd0EvTWdOdnQzLys3dmxkYm94R1Nl?=
 =?utf-8?B?czQyNGhySnNYZUY1c2FVUitUVFMwM1p2V25hQWJYMG9JMFE4VlEyYmhMcUEr?=
 =?utf-8?B?THg1TWxLWTZrK3pFQUFDNjR6VmVrUlNqUVZ2YlNYek5FTmRFeXphaGcvWUZS?=
 =?utf-8?B?K2M4TldRVnZhRzM3WW15V0phVjBQdWJIUDkwblNOaDErc2FBZmcwalVYMjEr?=
 =?utf-8?B?Vzlhc2JGWS9VekY1WGx1QkMxVmM1TDYvWG95NG5JcG83RUtoSGpLSDBzTWhM?=
 =?utf-8?B?dkR4OTlhQWlPNDl4aXN3RFhSK2RheFZQMWlxdndxVUpEeHdvS2ROU0tDZFFt?=
 =?utf-8?B?WXFNOSt0N2M0ZHljVE9wS01iL0V4TnU5MU42UnpWK2ovMjBJU0hxaDJWZ1Zo?=
 =?utf-8?B?M1R4S0grdmd5K0duTnVreVJQYW9XZXNsc2hKdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6c00e6-36da-4673-69a3-08dbd6ef6f20
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:20:05.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmyeQJwKVGP9ekXJB9236Dzz+WS3ZGB6fxkVEpB+/CBsrwsh4EfkD2sRK/AIP4U2cTycG7sZSOrgbB/Mqm2fwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10790


On 2023-10-27 08:45, Oswald Buddenhagen wrote:
> On Fri, Oct 27, 2023 at 08:34:40AM -0400, Marc Branchaud wrote:
>> I never use "fixup -C" (or -c), but I do use squash/fixup a lot.  I 
>> find that I would prefer it if Git used the most recent Author date 
>> from the set of commits being combined, rather than preserving the 
>> picked commit's Author date.
>>
> that would be unreliable, as plain amends wouldn't be reflected. that 
> may be rare in your workflow, but still.

I'm not talking about amends, plain or otherwise.  I'm talking about 
fixup/squash.

(Why do you focus so much an making rebase and commit behave 
identically?  There is no reason to do so just because they happen to 
share a couple of parameter names.)

>> Sometimes it takes quite a while for me to get a piece of work sorted 
>> out, and I would rather have the Author date in the end-result commit 
>> reflect the work's completion time than its initiation time.
>>
> afaict, you need to get used to `--amend --reset-author` all commits 
> before you push to achieve this reliably. that can be easily automated 
> by using -x with rebase -i (filter-repo (ex filter-branch) would also 
> work).

Yes, I know how to force my desired author date on commits, thanks.

		M.
