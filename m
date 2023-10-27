Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2D1EB30
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="BtnORXMm"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2095.outbound.protection.outlook.com [40.107.116.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B831BE
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 05:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6SRwkAmvxZ4hmJyarY4uRMTa72/s66sqZeLuOBeYbaoSc3nzOLw+fmXud1pIZTlhTQzezsBWVOi0GIEmTkIdy1vksGqnc0EdGNrUuhd/73roxtfsrNIb/hug4LP1BNJG+V3AVUZZ0h4pSLabddNiPwmylJpH+hOiutoAn+uZLLiKot2EaUXOhu7cVwr9szmHlSi5jUjfR4zOVIFEJYXljmpNbX83aeNzv0hRj8Jtm+3soiM9o4forXPqj3KIbilad3QXXdFjN0LWdYYZ6gftAK/6ZXk1Qys21pTgB7JH9/VPKXvn6tCIIYvF6aTeZ5V1c3ot0VGpRUzM+4/IvOqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6ItTgp2rBFcDZuDbSUyaJMWXEW0uMOgNhMSocXsxOI=;
 b=QPDMApNju2DCkvKi5UB9km5Ef4prQp4dKMq2Mh51Byi2fSAFOy2mpC7AZs/+whfU8wutBW2K2lxb5D0RtyfSw+Mo1kBBsYzrK36GPWAAfniCMNBrPQEzwpkvwsYF0YM6xFEtYI/VvoxZ0ZhTmAkwKKo+zzQO3qGE4ak0eJCgE/0tTXYI4dHrfELjmYH4+qVX9MDJN/TqRmb5ecQsd03qhlyiv4px1jCLyFKNo27yvTEIBS1I0BkAl8M9T5MaL5S+AMz1YellcoutCPEzDMFNUQ01q76JIGgQyGqX+OZEoYdMZTv6+j4bNZ/vlKFtMF7Y3QNgNy0DOBJx5iNjTc6rCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6ItTgp2rBFcDZuDbSUyaJMWXEW0uMOgNhMSocXsxOI=;
 b=BtnORXMmeUem6/4KElTz+5rULqa1fmRAmFrgpVCp7Fnq4G04EcGdXe4wclrzKUlWDNsUTEZqSPdrxf+TU4Z01EwucIzZ8peJknqn24xdT0y4K3A/WCcOLvX3vuy1a/By38YjnUPEKpVQPHCP0fgCRZhPdDS6iSAe3bpK76jAf/5OAXzIv3O0nQYVO616EwXBWG99HmeVc8vEtReJxSSVbDritCJK1k3WA+jNCCOzb2WopNl2bL1Pq8aaMxXL6X0uVRlKCT+SNrcLr7HRihEsqaHjjzvoxE5Hs9d0aqe5zPHpqL/IwkNhWMR2rYd/S8XrA4L1nCd9Esixp/6S3hmgiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YT1PR01MB9517.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 12:34:42 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:34:42 +0000
Message-ID: <70b8d4d8-f4b5-4cd7-b73a-1d7393d84266@xiplink.com>
Date: Fri, 27 Oct 2023 08:34:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: using oldest date when squashing commits
Content-Language: en-US
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <YjXRM5HiRizZ035p@ugly>
 <9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
 <a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com> <ZTeZ3KEQLIVU/sq2@ugly>
 <138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com> <xmqqpm143p46.fsf@gitster.g>
 <59731c05-c3f6-4815-8411-783bb1c2aac4@kdbg.org>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <59731c05-c3f6-4815-8411-783bb1c2aac4@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::42) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 24cb3b10-ef57-4e5d-d55e-08dbd6e917fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gSNBwBKqkIetKu2zLfHtQgaADKcRmjEd6xAcmzmECmEqkUhxAYYhVDjpAOL/ABpK032k2Cd99S77Zn3Es6bEqOcd4jpLCmOAeVIXvEiFFvQG/+Hzvf9bneYgj++3mO924i9b8qB6krdWBcF9DoQMsA+P+civLrKnVWKNuL4IW87WF+oqbqk4XS2mUH5avxHOhNLOuRfe/3JhDiO/r6rDhOSRs3CVcFwN0COPuvTuryERShNcvl59l+YqvqUjy1CI7CQY5fWPCKzbZv3AbM2/UTxcE13V9jgU7t3qlXVLKjExHzyGHYEUwg6zlANNPRqlcbyhdkwt6DKNxtQ5LswWZD7HUerbwyM88IWcrX7EHCYxCwzGK/453mhQgX77a4V2HUU70kACJMyk+SzZT4XTP/K7Obo1NY8g0Piuh+ZUSQ4C/eNiMjSdUOlgm/kmATR8NE5wM873q92tnlim7zaRYqoL/uhDk8QVvzYBLDziQ+6J2qaUeeLZmVb/xVF4tmoDLs74MHTjbmVCCQl8wUHphDS8ay5wG+kRdOzVAkPYsaokpETLJWSfrarkAeMUfhsnf7OUFACfyyh1K6NsqJ/GOKDhPd+1D6o1aXq1VWlYXcCVnK0QK7jr31Lbv976VCmt7jZBs/VExBiu0nJYJs7RXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(4001150100001)(6486002)(110136005)(31696002)(66476007)(38100700002)(316002)(66946007)(66556008)(53546011)(2616005)(6506007)(6512007)(478600001)(83380400001)(26005)(41300700001)(5660300002)(36756003)(86362001)(8676002)(4326008)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmdIVzY3ejdBZFVSWjRNV0JxbHBpcUdsblIrWUl4bFpGYlhSOFZBUWtnSGNj?=
 =?utf-8?B?cWtQY3ExSjRSSU13OXVyZzJqNk9XUllOdTk4RlZLSzJTYVovaEF0T2Nwb0pL?=
 =?utf-8?B?MlNBeFV4ZE1pWVROTTNZWGR2OGRxdkkrNFpUbnZSTTAraTdScTJtTndncVJH?=
 =?utf-8?B?d3EzaGo1ZTE1RG8zOXlkYVJnaUhOUHpqS3I5ZkpWellCRk9HbEtWNTY2VFNa?=
 =?utf-8?B?OE9kZ05aVnF3dlVEY1JvTzNuU01ZcENKemVVcnA1WGlTOUtUOG5wcXV3U1Fv?=
 =?utf-8?B?cmJocFpzdXJ5NFNZS0pkNUJTc1htVXFCZitNdFhVV3UvZFIvOUJ3amRTU3VC?=
 =?utf-8?B?YzZBWUFjUnJyQmdxcFZ3TWhRekwwbXgxWEtMOWhnTlRMUjRlbW5pcGlkMjJs?=
 =?utf-8?B?aEs2TXIwRHdPcFhSRW90NUJadFhHZTlRRjYyWlVVeXprUCs4bDlod2J0VDI2?=
 =?utf-8?B?YWVIRDR5aS9wMmdXYTNKYlUzeklvclpuQ1FyNFdiWHk5ZDRIOWpZU2ZpK0x1?=
 =?utf-8?B?K09ZWmZ5aGlEYWlzSk84MjVxMDAwd0pMeEo4cFVBeHkwcXVLNTRVUXZkc2pK?=
 =?utf-8?B?Y01aalc1VDNocWRxRThRK1lMR1ZZamQ0OEtQZjRWditsN2o3azF5UjRxdlFZ?=
 =?utf-8?B?VHpLaFp3N1RaNHpUaU5HUGFYYk16TDc5NVZiUEZwT2dpcU16d2l2WEptR3g3?=
 =?utf-8?B?eS9qUmFHWDBVV1RxR094Z2hJQ2VKOFRnMlNXTjhMbXpnNnBjR0VyZmxpS2l6?=
 =?utf-8?B?cHpmTkxqcTRVdHIyRkJ2cG1pMTlzQUEzNDloMmhjTGF0NURCaVBNd1FFbzk5?=
 =?utf-8?B?QlYwcjIrQllnYzV1QzJ4U215NGx6THkvdnBuY01ZZDlaR2hGa1Z0ZEoyZHRx?=
 =?utf-8?B?cWdKTHZVZXQzdEtMaVF2KzVwOVU1eTUrSFFnd1p2eVZ1cE1OakNFQ2tmbnBM?=
 =?utf-8?B?aVJaT2d6MSticFQxd3dVT1l5Z3U1YTJvSm5Pd2dzbzJzNEZiKzJzYStzYmY0?=
 =?utf-8?B?VENJT0hFS2pQZ2F4QlNCWkVnUURTZUt2UkZ5KzFrandYaW55WnpVajQxUGg2?=
 =?utf-8?B?NERiRHllMlNNWlhMMytjUE84NjdUdWlycGVOOU4yTEdOUWZya2w4Q3N0UC9w?=
 =?utf-8?B?TDlqU21mZTdGeUc1alJZN2VqOEp2RXRBU0NITzVlay9UN1RTbG1mNzVXNVBP?=
 =?utf-8?B?UnBsYmlRbVpYOHJWdGtwRVcyUkJrZDBUMmJoNnIwdVZkUkw2c3ZBOUFwLzU4?=
 =?utf-8?B?Q2JCRXJ5dnUzT2RLNlFtQ0lGeWJ3b296VWN5ek9GQkZSTE11UG15cWFlbkoy?=
 =?utf-8?B?L0FlcnBCL210Zlp5MmU5ME5mb1ZrMlZIVGsrQjRRYzlBTzdZU210ZWE3a2Jt?=
 =?utf-8?B?L3BCUGtzbjIxZUN4UVptaEwvTkI4YVJ5QU8xY1Q2U2tSVGFoVUtiZlAvSlpD?=
 =?utf-8?B?MlkvZUtNREg2cGhoajdodVRPcnZqWEdSL29BblpTc3FFWXR0ZlJOc2lpc2dU?=
 =?utf-8?B?OHRLOUpHNEJLWGJwVzVzSTBRQnZ4d0VrWC82aTEzVEFKanNuNjhlWkttVTg5?=
 =?utf-8?B?NDZYMitjamROQU5lT1hJYTI4ZG5UZndEcitHdmJ5VFR4NTNXRFhVR3FySnNx?=
 =?utf-8?B?c28rRjhOK3ZpYnA4dHBsOXJISXdEWjhMdmZoRnoxQkRacVV2ZFVIekNJVkt3?=
 =?utf-8?B?eTFXZmhNcW5IUDdNV3oxeXc0R1NwbDBxY2llSDFnZTVpSVZjbnhNUkNBQWpa?=
 =?utf-8?B?VWp5V2pwNDNIRndVNTc0QkNxRGtiMWtNRW9OWDNERXdhSWh0ZngyYWVFOWJl?=
 =?utf-8?B?c2JPS3BiTlVBMmJRVGV5WnllUmRBLzZKUkdldnZLTGpmZWFSOEZwQUJQMkhP?=
 =?utf-8?B?K1RvVUtKUlVTR0hjZzY2djY5MGx0aDdZczRMNVhyWHlUMFI2ZUZPaTVYNGpE?=
 =?utf-8?B?VGxyWWdpbFZLb1VLUFFhUWh2STlVS2dXdUxHbi9OVEswenBqMUMybi9JT0Rs?=
 =?utf-8?B?UDNqRXA5UllHMUtwY0NzbGxtdjZlRGRuS2RqcDE3Vk9UOU1WU2t1R2VOVks2?=
 =?utf-8?B?Y1JPZUZrRXFoc2dBY1FVdnJOdHFwWEN0SUdhZz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cb3b10-ef57-4e5d-d55e-08dbd6e917fe
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:34:42.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyxgbSa/OYyovEumZUD/Pwqp1X5peSylsV0CZBG4zCM/r6P63329KRGP5SOhFrXuTHMzIEv9w8tFQYjaAEhIXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9517


On 2023-10-24 17:19, Johannes Sixt wrote:
> Am 24.10.23 um 19:30 schrieb Junio C Hamano:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> "fixup -c/-C" were conceived as a way to reword a commit message at
>>> the same time as optionally fixing up the commit's content.
>>
>> Yup, it still is a "fix", meaning the identity and the spirit of the
>> commit being fixed are unchanged.
> 
> That's a pitty, because that is not at all what *I* use "fixup -C" for.
> To update the commit message, I use "squash" (or occasionally "reword").
> I use "fixup -C" after the following events:
> 
> 1. Commit unfinished changes for whatever reason. Usually the commit
> message just says "WIP <topic>" because that's what it is.
> 2. Make a fixup commit for an earlier commit because doing the fixup now
> gets it out of the way, and often delaying it until after the completed
> change would cause merge conflicts.
> 3. Complete the WIP including the commit message.
> 
> I would now use "fixup -C" on commit 3, because its metadata reflects
> reality more accurately than that of 1. Commit 3 often comes days after 1.

Speaking of the metadata ...

I never use "fixup -C" (or -c), but I do use squash/fixup a lot.  I find 
that I would prefer it if Git used the most recent Author date from the 
set of commits being combined, rather than preserving the picked 
commit's Author date.  Sometimes it takes quite a while for me to get a 
piece of work sorted out, and I would rather have the Author date in the 
end-result commit reflect the work's completion time than its initiation 
time.

The current behaviour means that when scanning through commits with 
tools like gitk (which shows just the Author date in its list of 
commits) I'll often see what I feel are inaccurate or confusing dates 
there, and I use the Committer date (a bit less convenient in gitk) to 
figure out when the work was actually "done".  (Although the span 
between the Author date from the start of the work and the Committer 
date from the end of the work would roughly reflect how long the work 
took to complete, I don't use Git for that kind of information.)

Anyway, this is a minor itch for me that I've never felt the need to 
scratch.  I just thought I'd mention it since the topic is being discussed.

		M.
