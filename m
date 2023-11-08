Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF528E2B
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jHSuHt6e"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93B210E
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 12:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHLi2/mhxJ51YBz6mCApfDnUBaM+frBnkwlFArao+td7a3goOXmn4L136QIV0+O7Uiw8+CqXF1UP8PztjPKNMPDxsY3UAhvXDoNLCYAXXqJu47owpHA+r/7OOGD2l1oKna6zoshXOB/GgFftmZE4wnMKjyUoRCpaT0K3DTyVAuzMuTF6EnSD9pdjKXiWEQQ4vpRsvG+EFmODpjjIFfVxCbO9xIutuVs3Oc6Xpt7i8PRY6CTLh6lvpDrOPgJGYt0ZxjQXIwZkZkjxhuccA/CWsEcgoCNHQKdGC2jtHYkGm0F9jb/qyGGR0zzRshEvF6/dxdNdnLl9EY0tnPSzdBf3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AneXQebD/PRn8BM87DRZRPktO5CZ11CRn9CYv04XSGk=;
 b=O9oGM8/RNyzJ8XKfjXGfL6MMAz3R6pqwoJ57WAAdipIitljJaIgSC5nK5h2qnXpE0tU0edhpOSrZ1nA9+xx7XVInOXZjodbcO6gZBWbpDt8A0US6G0c0hhGrErnIQsdObf632uS3h636Tfk0AvSAAArgElP5pOeufyo6uF5qXf2L6Rnarsb8kHCb6fH8fhJrj0aEQkRfCbZKhs51B3n44KhDGOq2qACphbPchxQaKctMsoVCW7yDrxVh490U/sg9tvRXO+IjH5ftcTpBiQID72Ef+aBf+Ti4bYHcnEmH2Jt+fBTMZ5gDk/mqkM8YEAQL44j4MHV3Io/QgNJ/c7jAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AneXQebD/PRn8BM87DRZRPktO5CZ11CRn9CYv04XSGk=;
 b=jHSuHt6e+fvfgJIYi9+8VXstWfgeVL4SO0eG8HZj+h5jYj8dcei41WUtSSI20GVO3Z5Dg4H9UDmuR8SLicZ2pti7c9MESZ1PPzJH5vrjWkZmCrJbPBIQy2jLFrBeIm8ug9lTqs3C8N2YUZCkzL9Id2HzfzociChoVzURjrN7SrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Wed, 8 Nov 2023 20:39:22 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::a0be:f6a8:2c72:ae90]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::a0be:f6a8:2c72:ae90%7]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 20:39:22 +0000
Message-ID: <c1e81faa-9253-4009-8077-805f4a6b071b@amd.com>
Date: Wed, 8 Nov 2023 15:39:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: git send-email Message-Id: numbering doesn't start at
 1 any more
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Douglas Anderson <dianders@chromium.org>, git@vger.kernel.org,
 entwicklung@pengutronix.de
References: <20231106153214.s5abourejkuiwk64@pengutronix.de>
 <xmqqwmuucwi9.fsf@gitster.g> <20231107070632.spe3cappk5b5jg3q@pengutronix.de>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <20231107070632.spe3cappk5b5jg3q@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0851.namprd03.prod.outlook.com
 (2603:10b6:408:13d::16) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0b530d-3fff-450b-d84c-08dbe09aca47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oXQD//WvRiCJkJ7c/lzcrktYFWRU0vUG92YbS4U61QmjKKifd5OnnImR8j3maT8ynawPwbwAz+NCESFJG+MgN/hgwXLfcVvNEYlz8Gp3vnE1FElkJsiwc15Q8hbY3/x9n4sqTiOivq2cm4tUOsy3QfLKbSY6OJ7/VgKPdRsogj5h+wXO3ufSIFloDtuYZ41ui3PM6Ugda2EsfnVXDUCuuZmFjs/Fw4R1pCHMc2m3evnwBFQySRrARpMPn70nhfJXozbmgMzyA4vPQUoXcxbG6UdH6VmTwZf6RyPnQKHFwU284A7dGI671aPDGG8dJZ5jvDKvq3wrvqMAZFXG7b/napJBEXj2iLEr7fycFSqaT2+Tlnd0SgDaO4epG9m5j9RfSo5A+351Ty6GoGiAr5Nvx1qVsCsCfVMKBH/OKU95xZWysu7rSOaX65hxSWs+TCg6cjAgsWKl/oxn7VFhJBmWmoqu3ZupTmLQFYxKM9dSCB1Dxx2JF2a4deVElNcre66TEuUbKsDDukJOcRhy33jFiWYFppkUkcfymKTIIOYUw+htY57w9RIcAQwAqPE9g5yHpa8gS3jpLg62Q2I/nd5CcZCicmFxS1PPD5+zjosXj281sch4EKZ5FWT25B/WgNA++5OitIFZM4oBMQGjOJ0RWmiPsCJ3pcVp3WdAo3ir7SCNJkXsEVxE+9Bvc4HAP/1R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(41300700001)(31686004)(6512007)(53546011)(6506007)(6486002)(478600001)(2616005)(6666004)(15650500001)(38100700002)(36756003)(86362001)(31696002)(66946007)(26005)(44832011)(66556008)(5660300002)(110136005)(66574015)(2906002)(83380400001)(316002)(66476007)(8936002)(4326008)(8676002)(750200012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3J1UFVaTUNXcnFnVlRjU0FwRTdDK055OVdCMlhWQmRZdmJPeUVsTWIzeTgz?=
 =?utf-8?B?dTV4WGJRL2ZyM21FNHNCL3l5R3c4THNlb1RWZEpTK0RMV0RvdFVlZllaelFu?=
 =?utf-8?B?VFYxSnpNbC9ZVjVjUnkzeXNnQjNWNXNWeWpYWnFxemxERjhxRFRQaGVTbm9F?=
 =?utf-8?B?eE9FdVE2Nytud1lta1M3Vmgxa2pSSEVaSmN5cmE0RXIxOVV4d3pDY2g3Mitt?=
 =?utf-8?B?Z25reHgycnk4VWVxNS8xM2ZjYmtZMWFCVENoQnZia2F0Z0NlZ3VINi9lTURO?=
 =?utf-8?B?U3EwQUY3UTBzU2I5TFhoblRTclBsUFNtazFTMmZPUzFqN1I3Q2VnRnJuVkkr?=
 =?utf-8?B?OHBFUFRndlJUdUNXRjFjRUcyK2ZoK2cxeEpqbDNXaHU3K2dqT3U1RWZIdVZx?=
 =?utf-8?B?QlJRM3dEZzhEOTV0ZWU1bFV5UkRhbisyK2huMW95RmtEcFNVMXZvNU05MDBn?=
 =?utf-8?B?MnBQRFI0UGxxK3ArUmM3T3ZWMDRQSUtzZ211S2xQbXF6UDVPOHFsYmw2dHJK?=
 =?utf-8?B?YWl3WUJLcm0wWWZSNlRCclg3a0R4Um8vZlZSc24yR00xM0pSMTJNeGZDZ1NJ?=
 =?utf-8?B?Y1dyNTRrTjhmeGdob0JyNWJnd1U0ekRjWnNRaDIzbjRiZ2x0cVcrem92YVA4?=
 =?utf-8?B?Vkg2amV4LzNtRjY5dUtTbjV6ZnRoNXFnQkFSUkxsS1MxUlRDWG1uZ2pTSitL?=
 =?utf-8?B?ckllVFA4NlVaaXBqWktSV1FpemVUZW9SbW82eS95clgxNmdjeDJTNUhTNVlr?=
 =?utf-8?B?VklXcmh6azgzdkVZYldOSVhEV0lpU2lvMWRnVTlGZWJiODI5Q2dHVFhqdlR2?=
 =?utf-8?B?ZytGbEFVMTRaZnV6SEorYyt2b0pLVTVrVURyVVRsSVBRWUt5RkVFSVNKQjFX?=
 =?utf-8?B?TlV6RjZVSXJpajl4aXRKYkwzUEZDcElQMjZEenVuM1RZNnBqdjFubS9hY0M0?=
 =?utf-8?B?L1A4cFl6cGc0aGgwWkRtNW9QRnBZS0h5UVBIRHVjRVQ1SVlXVVloOU1OZWIr?=
 =?utf-8?B?cS9XcWdlMlJ0QzJkOGhsTytrbEVob1VxWjJaa0NETlo4YjNQcVVNRTN1SXhS?=
 =?utf-8?B?SE5MRGVKeENIUjlqZmJ4Z2xxb0VzM0t5YktsMG5TWlhUeUFzeFBxNXhDell1?=
 =?utf-8?B?NzZQSlMzdVRKcXYzbWkzOTRraldaQzlkOGFwK0MwZXFNdnYrRWUrc0c0OHc2?=
 =?utf-8?B?TVZ2ZWsrR2lvNzFwWFpOcmJ4TGdPc3Zob0V3VkxtVmE3eHpoNDF6TytRYmxo?=
 =?utf-8?B?Vml4aVZMcXYvWTNMbTBKMSt1RGpNU0g3aEtoa0xKZWNidkNDVFdOMDZyaUVo?=
 =?utf-8?B?UW1KQ2tsWHU1T3NWeXBiUkZRSUszQ2dsd2xoeFhxb0lhQVlPUnVYSytEeTY3?=
 =?utf-8?B?S3ZtbndpQlRwTmg3TmZyVGt0MVZlOTlpUDNWaDRkQmRwOVBGYk1OaHRVSDVC?=
 =?utf-8?B?cGtZS2s4QS9HRlh2L1BxemlZazJvWGduZUdLVUJXb2xrZVRLR2VMeDNwbW9L?=
 =?utf-8?B?dUdlTllWbkN3VU0zWUhCVVBHZ29JZDFPNCtsa3JlZkIxVS9QdEkyTHBzRTI5?=
 =?utf-8?B?OXBPS0RvelM4YlcrUm42U1pqa2lMOGdtdVZYdGFnZml1T0RqUStPNS8xcytv?=
 =?utf-8?B?cEdrQ05NZldyUjZJNHhHRG9tRXRoV2hGbm5SVGR3MGt0Tk1uN1dGMHRDQ0E1?=
 =?utf-8?B?eU0vdGxRd1VDTkREenlRNk1SQzdyaHZBdWh6cEdTYllsbmZlQmthVHAzRlV4?=
 =?utf-8?B?NDZWY2E1Q2tkY1kxWGVGNEwxelBwUGxtWUVmbk50U0laSHJxUUpsVUYrdGRB?=
 =?utf-8?B?NU16OGM0eGMzUDhNWSs5ZTJ3S1pnS1lxRjFmOVhqOXlKR2hEM1VHNUk2OUJ5?=
 =?utf-8?B?SHZNcTdWOUZjWXhPNk9DdzFyZE1uT3ZSdUFleTFmKzF1SmNLeDNKalJ3eDBJ?=
 =?utf-8?B?cVRHWjZxeWhHOFVJalVmRDNkbG1sV3Vpc1FBUTQvelhWZ0FBZFZ4MXFPbHpV?=
 =?utf-8?B?NnZwdGdUQlg4UXpUWisrcXFRNDQ5UVg2SWE3ZzQxcFVwVFJEVmw0QTFyUloz?=
 =?utf-8?B?N2dZVzRGbS80NEhkcGVHQWZZc21RZXpMU3kzRHlDRDllZ1RxMU10bG4zcWhi?=
 =?utf-8?Q?hmv9InddBHumaXXNRxm81n7a0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0b530d-3fff-450b-d84c-08dbe09aca47
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 20:39:22.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnFfLlckql58tI2yzPVRPqsLdj/JPoqQg6qV6xqgC8oUjAgC5RdAWdC8rqQSMglIWWSijzJTl+giQy37Uo7gQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870



On 11/7/23 02:06, Uwe Kleine-König wrote:
> Hello Junio,
> 
> On Tue, Nov 07, 2023 at 08:06:22AM +0900, Junio C Hamano wrote:
>> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
>>
>>> Hello,
>>>
>>> Since commit 3ece9bf0f9e24909b090cf348d89e8920bd4f82f I experience that
>>> the generated Message-Ids don't start at ....-1-... any more. I have:
>>>
>>> $ git send-email w/*
>>> ...
>>> Subject: [PATCH 0/5] watchdog: Drop platform_driver_probe() and convert to platform remove callback returning void (part II)
>>> Date: Mon,  6 Nov 2023 16:10:04 +0100
>>> Message-ID: <20231106151003.3844134-7-u.kleine-koenig@pengutronix.de>
>>> ...
>>>
>>> So the cover letter is sent with Message-Id: ...-7-...
>>
>> The above is consistent with the fact that a 5-patch series with a
>> cover letter consists of 6 messages.  Dry-run uses message numbers
>> 1-6 and forgets to reset the counter, so the next message becomes 7.
>> As you identified, the fix in 3ece9bf0 (send-email: clear the
>> $message_id after validation, 2023-05-17) for the fallout from an
>> even earlier change to process each message twice still had left an
>> observable side effect subject to the Hyrum's law, it seems.
>>
>>> +my ($message_id_stamp, $message_id_serial);
>>>  if ($validate) {
>>>  	# FIFOs can only be read once, exclude them from validation.
>>>  	my @real_files = ();
>>> @@ -821,6 +822,7 @@ sub is_format_patch_arg {
>>>  	}
>>>  	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
>>>  	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
>>> +	$message_id_serial = 0;
>>>  }
>>
>> This fix looks quite logical to me, but even with this, the side
>> effects of the earlier "read message twice" persists in end-user
>> observable form, don't they?  IIRC, when sending out an N message
>> series, we start from the timestamp as of N seconds ago and give
>> each message the Date: header that increments by 1 second, which
>> would mean the validator will see Date: that is different from what
>> will actually be sent out, and more importantly, the messages sent
>> out for real will have timestamps from the future, negating the
>> point of starting from N seconds ago in the first place.
> 
> The series I used as an example here was finally sent out with
> git-send-email patched with my suggested change.
> 
> The Message-Ids involved are:
> 
> 	20231106154807.3866712-1-u.kleine-koenig@pengutronix.de
> 	20231106154807.3866712-2-u.kleine-koenig@pengutronix.de
> 	20231106154807.3866712-3-u.kleine-koenig@pengutronix.de
> 	20231106154807.3866712-4-u.kleine-koenig@pengutronix.de
> 	20231106154807.3866712-5-u.kleine-koenig@pengutronix.de
> 	20231106154807.3866712-6-u.kleine-koenig@pengutronix.de
> 
> So the Ids are are identical apart from the number this report is about.
> 
>> Your script may not have been paying attention to it and only noticed
>> the difference in id_serial, but somebody else would complain the
>> difference coming from calling gen_header more than once for each
>> messages since a8022c5f (send-email: expose header information to
>> git-send-email's sendemail-validate hook, 2023-04-19).
>>
>> So, I dunno.  Michael, what do you think?  It appears to me that a
>> more fundamental fix to the fallout from a8022c5f might be needed
>> (e.g., we still let gen_header run while validating, but once
>> validation is done, save the headers that validator saw and use them
>> without calling gen_header again when we send the messages out, or
>> something), if we truly want to be regression free.
> 
> That sounds sane.

I agree that a more fundamental fix would be optimal.  Saving the header
information after generating it and using that in both validation and
sending would be great.  That would probably need to be paired with
cleaning up all the random code in between the function declarations
so that we can get a good look at all the variables.  Right now the
control flow is hard to follow.  I can't guarantee any specific timeline
on those patches.  It would likely be fairly large changes.  If anyone
else wants to take a crack at it, feel free.  Otherwise I may tinker
and post when I have a chance.
> 
>> By the way, out of curiosity, earlier you said your script looks at
>> the Message-IDs and counts the number of messages.  How does it do
>> that?  Does it read the output of send-email and pass the messages
>> to MTA for sending out for real?
> 
> The output of git send-email dumps the messages it sends out and then I
> pick the message-id of the last mail by cut-n-paste and call my script
> with that as a parameter. It then adds notes to the $commitcount topmost
> commits such that I have something like this on the sent out commits:
> 
> 	Notes:
> 	    Forwarded: id:20231106154807.3866712-2-u.kleine-koenig@pengutronix.de (v1)
> 
> This is very convenient to find the thread to ping if a patch doesn't
> make it into the next release.
> 
> (By the way, one difficulty in my script is that depending on the series
> having a cover letter or not I have to apply the id:....-1-... marker or
> not. Would be great if git send-email started with ...-0-... for a
> series with a cover letter. Detecting that reliably isn't trivial I
> guess.)
> 
> Best regards
> Uwe
> 
