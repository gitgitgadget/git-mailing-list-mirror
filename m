Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011036.outbound.protection.outlook.com [52.103.68.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA98633F
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749409755; cv=fail; b=T9lzgEIccye+WxZX4Rem4JUkMnpOpJocSUmAhVALETmZMLOBAFCWwuST2Kch/0tCmIvnMXQAg2IUaQ/EmvzZzeYbG1Z8Y3z1X8T0pnPrETmBmXJJ/5Z7TGvbm9pF4IEdLTdDvqzTDaTJ92Ag6T8uHYbL120hnWYIEg3FOqppGzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749409755; c=relaxed/simple;
	bh=owGbw5OhUZJOmLxXGGY5+moaKPq12A6sFMGGpDos2Es=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=eAab+F5ZyS0M4TbF/tOXfqAbzyNDyatvda9gY9tY9D2+aaZXBQfwIjV1EfzxDeQay/QhoRLZh22J/bJOycbZUGj04XlxoFI6l1snOvh70Ndt0toUn6RGoUBSLodm3TXbtZOdAYSPsZcdCsIKtoIyC4oUAmNON+sZHnSQQa0qu2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IIt7oVD8; arc=fail smtp.client-ip=52.103.68.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IIt7oVD8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQWLVIAnZiz2cZ66FMQYxLiwJ0SW465P3h7GwOQmCDI84l/eDdDLwuJxVYQdQ/R3gaBjMEDnl74wQvC0yOUSm5wJd83TtPpK3yxXz63MbAFrYZmBiqA05zi5JzvIiaLo+p4WmPcwhvDPYPGIvJrReQPZiT/f1YUv3768Zw5taFAuwFoWOXliJWZzC35TlAg/tQhnc6ulH+gtUXTyDlc/Hl1BTtubCKNKeiqvFpGfecm812Uqvb38z/fhehxuJZ+E9E1hsRJk3L2fm7IYkFOk4d9HOyNxnWOx4s0lrIsVZ5njOzap4r1t6OgwxpanjeaJmLbSz2wWMTb3GVF8oSBQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Is6/DyMoJAACHSuptn9odrQQwPwoEIFFvrQ3Yjh2Qyc=;
 b=so5ZmvP7/6qJ6CFcJTLHVw2IAwaqtxGoCx4TUSeSw3dcQbb56NFrYZaO295oF55tdQ2ZZSsDvjZum7iYH+uIu5N1+w3V399Ma82Oiv2wIXhJm0kNw0GvQi7LHrBQcDyLXf+SlsxUkiaLs6e+xGodCqpie3BZhlDzteqBIb4XJjpFtUAfZz5TbX2zD1ljxAtzyMq3uUiLfj/2vdGI5oNGMy0NViossoK837nUKlUjiIA8HzHnk5MQ4MVrdDKj04BkGe/h8o6SBKd0zPnEx1MXdsZaOT+EHYhxPeLgA+fSmg+jiyHs8Mn/hBj5quggITT0ekveg2AQGq6WEpOG+QocVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is6/DyMoJAACHSuptn9odrQQwPwoEIFFvrQ3Yjh2Qyc=;
 b=IIt7oVD8SN8gyN+1IoeIOg01vMMr98d/jNH2aiuz/7hkReMt6KSrYu6tm8iMaZZzoDvXOd2Kxmiv+O39cAGGOaCQLBYd7VlQ5lX+rIbawUWopZHawIFsaCSRl4d+w4hW6S9+oQDpI4geO2OtpMbsB5k+BdKYcr3SCQ0w9xQOQ6isu2HQq6pXClfPEYc5obYLU4IjEwi3hO+i3x9sxpZ/nRHcoJJCI0TwuqCcohuLOjr4XV9okRcuWZ8evL5PzOwJ3xEK5OD1PRkDTxxK0scqSyX++uzSeTsiOpORqV7hwq1tFcrHo3EFxDcQ0MLcgPZaG/Wf5ykg+f+M1SGZgWwJVw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9400.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Sun, 8 Jun
 2025 19:09:08 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 19:09:08 +0000
Date: Mon, 09 Jun 2025 00:39:04 +0530
From: Aditya Garg <gargaditya08@live.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_Question=3A_is_there_a_short_way_to_mer?=
 =?US-ASCII?Q?ge_the_last_commit_to_the_second_last_one=3F?=
User-Agent: Thunderbird for Android
In-Reply-To: <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net>
References: <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net>
Message-ID:
 <PN3PR01MB95970605EE2877BC40096188B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MAXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::13) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <B584284B-EC98-46D6-9ED0-C1E556C128C4@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c6193f-9d01-4241-4161-08dda6bff170
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|6090799003|8060799009|7092599006|15080799009|19110799006|4302099013|3412199025|440099028|34005399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0dBdUE3WUh5cU01NjByc3ZZNWtNZGNoZlc4Q0lvTWhTT0gzUlJpeWtTT2ti?=
 =?utf-8?B?ZFVYTU9pQlFiamFuaVZEeWNyTzc2VUtVUDZadGVoYnlEM2FvODB4ZTB4ampy?=
 =?utf-8?B?TFVkTnkzNXcyRUNWTjU4QVVQTVNnRHhYR2U2Z3lhTnFzK3VuR1J6ajcyRlkr?=
 =?utf-8?B?aU9udXZRN0hTN0VNaVlpc2FPSDhjeWJ4b1EvSGwxL3pUVjI2cmtBc2tEdVdL?=
 =?utf-8?B?MUlJUkJjTnVuK04yNWdOVVlOd0J6SWsyM2c3dkNDNTdXWThLQ0o4OXNlSG03?=
 =?utf-8?B?N0hvek1kV0hpemRwRTVhM2hjL1VuNmdNVEVNKzAxWU9rb0ZCSS9nTmtrRk96?=
 =?utf-8?B?OWZ6NHQvMkJpTFRQdGVKUTIyTU1OYnBmeVlUc2txR2NtSFpnYi82SDhQUlU5?=
 =?utf-8?B?UUViVjBFNUdONEdHaGp1R1ZOZHB4VzBwTXZFUGFZSmFNL0Z4c3o1RURBTHZM?=
 =?utf-8?B?eWRvZDlZU0pyVnVJT3NHNjlPY3NpWDF5S1pWZWZkQ0JvMlNHTHB2MHcyTWNw?=
 =?utf-8?B?ZU5rL0t6UUtKa3BzSkF3Lzg4YXJGZTZITjV4M2hRK1NLQ2FoQjJEMi9WQUJG?=
 =?utf-8?B?ZTYxRHNLVjVBMnBYOEZENXF4eFdRVi9uSEhBM1Q0bnNveGZSUDd2NVVON1Rq?=
 =?utf-8?B?RTdwZnFXNitxUnd3RXBKWTFXSURmUEwwaEZsUnpnNmg0aFNlR0JleDBsdTkv?=
 =?utf-8?B?VERJRURRamNsRDlVRUdzSlZuV3k1OUI4VkNpWVZGZmh2bFlRd002ckVhWFhO?=
 =?utf-8?B?b3FnWTEyNkNxcGd0ZWJJV0ovUXV5V0ZPS1hCZnZWbkwyV2FaUmRsMlVyQ3Nr?=
 =?utf-8?B?Nnc3RUVNWGNaeWlTOGdTUDlDTjNwSTJJdW1EOWJUV3pnNGh0RTZhL1ZmYjZZ?=
 =?utf-8?B?cXZJRDlsNkkxaEtmRnNTWFFoVUxXYk1xYmFZMTFiYmcyVGRGY1djSktXT0RY?=
 =?utf-8?B?MnBrZDhIa3J6VkJnNnc0VXZmVU12WGlXa1QvSCtvRHNZNE1SUk1VT0FWZ1Jy?=
 =?utf-8?B?Ylk1WFBSTVBJTDlDbDBjV2ZjbVRLSWlDSDlZazBQcm5rM2tNcUtkZDdHTmRV?=
 =?utf-8?B?eERQVU1sblRHd3d4T1RKMnBxSUNBeWtyQndnM2p0cUVLUWhtdnc0dEJGMWtG?=
 =?utf-8?B?NCtvMlFid2RRT1BJeW1acWdSektvUWptdHd6SUg0SkJBWEVRc0U0Sk9pUWx6?=
 =?utf-8?B?VzNZeHprVDV6MitCemlBc3RxcUJjbnVvNjUxd1Q4TEFCRG1pd3J4aFhjNDBi?=
 =?utf-8?B?Zk96SXpZNEdLbmlMajd4VXBmTlhEQURqUnUvakE3cm8vT2Juem83SzVjQXJ6?=
 =?utf-8?B?amlZZFZ1bjJCUVJ1eHhJTldueHlzNFlaeEVzTUNZclNSQTU2anhYYUFyNkh5?=
 =?utf-8?B?a2ptR3ZIWHdSUDRCSjA5c2luZkhuOVBjc1hKTUY3alVIMnNWOE9tT0lHY0s5?=
 =?utf-8?B?eStRdms0Y1ZDWVBxQk5tY1VqL2lCZ3YxRm9uQVFITndEQ0J5VHlWekt1R3B2?=
 =?utf-8?B?amRqSzBmaUppYVFJekxWNytYY2dIekJ4cU92dTAxU3ZGNGVTUis4UkI3eEd4?=
 =?utf-8?B?ODlubjkrK1VDYktGQWR3SndvYkdyRFQvRjZLU2VGTEtCc0FWSXMxbVVXaGdm?=
 =?utf-8?B?U0M4NXRrbURFTmRnSXhhZG1iWUMrdWdrUUpXTGI5N1UrVWpMak9hTWUrTXd1?=
 =?utf-8?B?ZzlLMU1SM29YNlVjc1VVOUpwNkM5R3FiN0NyNmw1anBoWFFmejc4VERnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1YvWVNrNVIzZyt1eEU5Tit0ZjlObjdTUWdETWh2V3Y4VmFJT21rZTE5dFM2?=
 =?utf-8?B?Nmk2eURVYUk4MnhaMlcwZlF2djcvbGV2Qkk0KzBXZXdsMVU5aFFmcDlNTFIw?=
 =?utf-8?B?aU1aWDVnME04R1pGNGRpTjVMOXhkdkdkVDh0V0trb0NwY0U3Zm1ScUcxS05R?=
 =?utf-8?B?MFNXdUhicWhqSnJPWW1xNjRuT082STZWUVkwN0cwM2swUy9IRW5MRXRnTTBS?=
 =?utf-8?B?Zkt0UWFQd01VN2hJL2JUM3hMS3laWFRXMnRIRDUvQnIvcmRXZERZeTA3NVVR?=
 =?utf-8?B?MXRTZ1dSL2hXOEdCZ3I5dUVTanVjU3ZVRFg1QU94WEZLRXh1dTJvZWdrRlFl?=
 =?utf-8?B?WUV4QS8xLzNUcTE0Y0x1clA0Y25rOWVoVGVnbS82NGVlK3BUdTgvendOS01B?=
 =?utf-8?B?Zi9rbmFzRDBkV0c3K1FaOHlPVkhHLzhpVEVWUjBIMVE3SGlxNnpRSWxWMzNs?=
 =?utf-8?B?SUFOc0RvSUwrY0djVkh3Q3l6SzBMd3VBT1gzMGNQUkxUYUtTWnhHSHZHWTJn?=
 =?utf-8?B?WDdyTTMwZU5xRGt5V2FFVTFWY1lBSDZvVUZBOGdndllEdUwrTy9BZE1JVDhM?=
 =?utf-8?B?TUF6UVg4SERWUVFna1VuN3hLU1FXc3grcCtEajRrRW5kUVVlSmxQL3pSWk9G?=
 =?utf-8?B?d3hzQ0dBbmJpU0FCNERoSE92bmY4VUdTSXhDV3diRzFSOW5icW4rdHlNTUF6?=
 =?utf-8?B?MUxOTFNtbUFRNlU1Z3NBdFpjTWQwcFNrdTdyZndCRU9UY1N1N1pqaTlzaXcw?=
 =?utf-8?B?T1MwelhBeXQ1ajViZ2Z3TjhRZU8vcU0zVkxzQURmMFJYbERlVFM2Vk45eWF1?=
 =?utf-8?B?NHEyRUc0bGhNNldsVkljS0tZVzd2V0xJeVRONFFrVUdCWjZ3NHVUYVhBY1Ir?=
 =?utf-8?B?TnJHMjNMNWJ6QllsMWd2NUYwZk8vazd5ckdVNjMza2NSYjNWeE5YcjFXdXhI?=
 =?utf-8?B?ZnNRR001N0RaSHVDaGV4RUUrTFFaWktHWWkvNDgrZGhTRFpIenRQZEZPNDM5?=
 =?utf-8?B?UStWb0d2a0d0RnUyd282emg3OTRtMVB2UllhTk02MVd5T0Z6TEYxWlBVVDJ4?=
 =?utf-8?B?WHRZeG1aaHNpWkZSeWp5RjRQZDFaNXd3NWp6bk1lU0NpaXExaTF4R0IxaXZY?=
 =?utf-8?B?MW41TkszYUYzZHNrZ0xldVBYenVGZFNWWVk3UmJ4RWtydnhTN3pkdnM1Nkx5?=
 =?utf-8?B?cFU2d1V6ZnpLTWNSbVN4Q0QyRGR6aVpDQnJnVjlJUGY5MXEyOUNTMGIzREtV?=
 =?utf-8?B?NXMzb3VSYkVoK05kbjRMS3oxb0hjemxyZFd0QjEzck5BckxWWlQxd1FBbllt?=
 =?utf-8?B?eGlJaGlIeTFBNDAwMzVFeE9NQzJoRm1ISGpSdVhDS2JscUo4bDlLc0I1WE9r?=
 =?utf-8?B?bVowSWxMZ2dyM28xam11bWtreGdIVFJ3cjlYeElsdnZEay8wWUlNY2poMnZJ?=
 =?utf-8?B?bXdmRE85VWJDVHBrYklueTR2TXc5b2JiWTJnYUZUR1E3bUREaUE4YVhkTE1J?=
 =?utf-8?B?M1hsREdycmttRi84YmZxcTlkQ1RIZmQzaE5tSjRISlI3aW1mUXNNOWJzT01Q?=
 =?utf-8?B?WkFYcWNvaFMxZkh5bHFVOE5BQWsxZC90VnVrd3BsQ0hKbzhhajV4cWxhcFVX?=
 =?utf-8?B?Q2J1SDdiN1BlL3ZpSXRNYkVyM1M2RUZiNGVHSzVyYURsMmhjSktLdEMydHRW?=
 =?utf-8?B?T3ZqS1RzRVBnUEsvcSt1cVhnaDRWR2ZzRnlPM2llOXdOMGxDWDd2OU1NK1B5?=
 =?utf-8?Q?EHm4qXLxI7yYHKW4oo=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c6193f-9d01-4241-4161-08dda6bff170
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 19:09:08.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9400



On 9 June 2025 12:27:44=E2=80=AFam IST, "brian m. carlson" <sandals@crustyt=
oothpaste.net> wrote:
>On 2025-06-08 at 18:30:30, Aditya Garg wrote:
>> Hi all
>
>Hi,
>
>> This is something I usually come across. Sometimes I make a mistake in
>> a commit, and then I create a new commit with a correction. After that
>> I git rebase -i and use the fixup option to make the fixup commit a
>> part of the main commit.
>>=20
>> I was wondering if there is a command, like git fixup or something
>> that could make this process easier? I know about git squash but I
>> prefer doing fixup.
>
>You are hardly the only person to have this problem.  It happens to me
>and lots of other people very frequently and so we do have a couple ways
>to fix that.
>
>If the mistake you want to fix is in the most recent commit, instead of
>making a new commit, you can do `git commit --amend`.  That updates the
>last commit with the changes you've staged via `git add` and `git rm`.
>It also allows you to edit the message; if you don't want that, you can
>pass the `--no-edit` option.
>

This is what was searching for!

>The other situation is that the mistake is in an older commit.  Here, we
>have a special variant of `git commit` that will mark the commit to be
>automatically fixed up.  You could say something like `git commit
>--fixup HEAD^` (or whatever revision you like instead of `HEAD^`). Then,
>when you do `git rebase -i --autosquash`, it will automatically be moved
>to the proper location and marked for fixup.
>
>If you want to change the commit message as well, you can replace
>`--fixup` with `--squash` and you'll get prompted for something you can
>put in the commit message.  When you squash it, then you'll be prompted
>to merge the two commit messages (the old and new).
>
>If your goal is to just do the fixups and squash and not anything else
>interactive, then you can do this:
>
>    GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash
>
>in a POSIX shell (that is, on macOS or Linux or under Git Bash, but not
>under Powershell or CMD).
>
>The `GIT_SEQUENCE_EDITOR=3Dtrue` tells Git not to edit the sequence list
>(also known as the todo list, which contains the pick, fixup, and squash
>commands) and just perform the rebase.  You can see an alias for doing
>this at [0], which may be helpful as well.
>
>[0] https://github.com/bk2204/dotfiles/blob/5e74a513ae133ec30b20992fb4c2f9=
67fa6f047b/git/gitconfig#L41

Thanks a lot brian, your reply was perfect!
