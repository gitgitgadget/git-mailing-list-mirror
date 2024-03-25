Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021010.outbound.protection.outlook.com [52.101.189.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4641758F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371133; cv=fail; b=pULpTJs0kdi7hnRDIFLQ1oi5K0KZ40MgNTm1xAXfatqj9T/fp9a3D2gF6OkFTPP5I2F72+rjcBx9kQXGIGb7F5dXQ5MQj8SoQHG+QktJfBDsj/GV61XHxe3Il/qKscuwmvT50NookgL673yPff08tiSQn8NpQhv9sK498O4Hnb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371133; c=relaxed/simple;
	bh=JTNdkZA8IPP47onwoQeg4P36qKCgAlZbfPi3T5C+V8w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E7I+EDf82qeET4CjoMx1kmRjwREBayKSTzbDypWTczsVozmldcWXk8Lh6ftSxgdpZD2KYzs6JjEhiBxqbdAplunwTQY4y2jCX7sL1chWThVWAI0iGAtoy+flae+9mmORFWSmGXEaak9B8bncjHCaC+l76pUQ9DnNsNrCVTU+wLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (1024-bit key) header.d=xiplink.onmicrosoft.com header.i=@xiplink.onmicrosoft.com header.b=e6g8/hRB; arc=fail smtp.client-ip=52.101.189.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiplink.onmicrosoft.com header.i=@xiplink.onmicrosoft.com header.b="e6g8/hRB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecCrLmuHCNbcYtp34pEZ42kWA5Yyz7wlagNnAb6t3EcNud0WcUVugkhEm+5rSSnjcxkOMsJDcsnM3KiRJLCFIZazLRhAUswrzcFLXQIVXBE4H2mk0cKMiVJlozUUblaT5B6tcQYBdmRoNrKvxV0hHRWnrouohcaX9rzp9/0/ZrQ9AR4LJID+KOxO38pS1rU9rcm19s0uCD3U7yCyexT0M3Bv1h2rkm4Y1Frg/SGrB3pA1V1svox9CzIWQZQaRRnx3djHFEt7VBDRmI42eXjheDeVFOdow3Im9O4RoVEWkCxNioO1rkjxfzmCBSE7HVrBRotYDwQRumQZ9KtJqyi4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkjSSSvmxgH5CPRv1fhuHR9SXWTdCEcBWeIfOk7gIR8=;
 b=HE9CvnDnUdu7Bi9JRqV/AXqHErkbNKqBuqUCwFKLOq1XIbcqBjVzyXRevXLxBx14I16nJ3LP/5SSt8aoS0O1WCr9GZST9tyZpatAsPR7u3tMOlPqsQ6J0IFYnhPYh9YLGyy3t6eMFfgY9VXigZ5NXWz/6xjTapUCASaLdHvSfhN4cfHSOION7gA33sWiGH1L2l3bBMlOIuC3xDwXKjtrCxjTs3hnJtOcJiD+xEnNRdV1MjvVDdeO9ooQVcy2xfdTu4/n8jHtCDWUr+baEFlDSh5EcvaXRg738a1FChxw6flhN7esG+htR1ESH+zjP4bxGdBT/c27deFFXvQcdVq7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xiplink.onmicrosoft.com; s=selector1-xiplink-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkjSSSvmxgH5CPRv1fhuHR9SXWTdCEcBWeIfOk7gIR8=;
 b=e6g8/hRBizbC1GRYz9wsFNUltI5AlA837i9c858qu9dXi0tRY2u1hvq4fHWonVjZZkysEIVf3TN6KmSDfrYk7fZLpXRhtpyJgs8lLsBckO06+R2hXae+UMjFL0qnOUY56MM71UImUo3Tpgw+z4FJeO8J9+o9xi1cwytD8FMLTcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YQBPR0101MB5688.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 12:52:07 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c6dc:38bd:5001:264a]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c6dc:38bd:5001:264a%5]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 12:52:07 +0000
Message-ID: <742ac151-74cd-46f8-8dfb-3dcdaa513314@xiplink.com>
Date: Mon, 25 Mar 2024 08:52:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: add "Hightlight commit name" menu entry
Content-Language: en-US
To: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>,
 git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Denton Liu <liu.denton@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, Beat Bolli <dev+git@drbeat.li>
References: <20240130085308.5440-1-rgallaispou@gmail.com>
 <27b9c158-5cb1-46bf-851a-88a02448fa2d@xiplink.com>
 <146fbb87-9047-4d96-8d06-76f5710ca9e1@gmail.com>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <146fbb87-9047-4d96-8d06-76f5710ca9e1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::24) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YQBPR0101MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: da72665b-a83c-419a-3471-08dc4cca60be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	84X6gGSt8eU179oCk+wtFLvkR9GXoP8zkpdWswr1joFwDj/QgXnALcmA1/rJ/p1EnV2rTnalRJWLSwNenou6e1cSs/Q/Ji8dnLm8PPT4JQ7RcHJd/7fTi5kkduAt7Po5nt3pp11xXNPw4pf3lfkNtCw0oSZDANZf9pwJAMr/v2zV0Hy3fCfHq9xeeVZPfRtHgyp3kUCOs77r8Yaqi0ArHcH4vZQAY5A3cPRVwCicVOpxLPpF1CLAvFhYFJMb3ETxUfUJKiPRm/qOjOaFJmfA7BRv83De118BXyV8OmQiSdHrvv7A17UrXgZzkE22QGaPPiey2pacR8T+RSasRgFbkwqmJ1Cj0EXY+h/Yfyyoqt508czprpHCy1ZROl5uIVIfkL1CfTxqyub/IzmzhLIstpp07TaXWugMPe5ASBfMIEIcedLS821g6gzzs+Sc59Zfpa85JcA0BTUsAhWFCIDWBTvPOpi+bdUkdAW5+aT7mHudSlQO/+F55E3TNLWw6MlY0qEKoimmZxWKRMOst+YOHxO10vOnhL9P8NvzQzL/zsmQ8e4fz2EFQl8/5JYoX52maNSXirGAbCu2E7jA4N0ZVZm9ESkupFdVfzXlgvzbX7lJ1sn5ICF1ltPPgzI/cmbUb+ilnY0CNFV4t/BBZoKLCNCAz+kehGJL4gj9LhfNufg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWZYdmZ0M0xOU3dpZktEY0dWSXZBTUc0MXBlbDFhc1cza0hpV0hlTWJEU1R1?=
 =?utf-8?B?MnRTZlJRaENBRklzdExqT2YybDVUQ1NVOEFlc2hHTGQvdHZQOTRoRVlEUDMv?=
 =?utf-8?B?WVhmcjdOS05EV3A0Q25EZlZudnA2UUNPcktlcHJBd0pjOE41M003RFBGVGU2?=
 =?utf-8?B?ZVdXVkZwOUNsREFWRXdsaWgxWVFXNzh4TDFqYW4rRG5tZTdOMkxnRTkrL1NX?=
 =?utf-8?B?MFpRV0s0YXdKQUJmdlZia0s2QU5QVXV6TlRmSlA5NW5aR0NkRlpGNmk2cnY0?=
 =?utf-8?B?UDJmSElHeG5TZ2RMR3JWWjN3Ny9EckJ5U1hZOWVHR1czSDJudmg1YmNKU01D?=
 =?utf-8?B?MUhrTkd4Y1d3QXlBekJZaU1ueWEvdWpjK1JkZ3RGUXhHS3ZXWFNodytrcy9E?=
 =?utf-8?B?dWhpTGYwbXUzbWVnNldpMUg2V2VnQVRaV3lQZkhsdzlSUWhzbmR6aUlxNkwv?=
 =?utf-8?B?TGVwYnZFOFFpckEzaXVFMlB2c1lWZDlrcW01cHJPOWtKN1lnNStCQTRqYXNu?=
 =?utf-8?B?TWVhNHlJa3FhTTg1QXpWRUYxdytlNjliZEhWRGFnTldSTnpiZGtFTUw2QlFu?=
 =?utf-8?B?MmNOTmdQeGlsUW1zRVpXU1ZrVHF1Ym9xQy9lQyt0MG0rY2FQUGRKdHZadk9j?=
 =?utf-8?B?T2tWUkNjOGpwZ1czaTFVbGxLZFBXNFNaeHk2TytMaGN1cjVlOWJvbFlaUEpv?=
 =?utf-8?B?SUpXNmd4a0pNZ3A3M05uRE9Cb0VHdE0xR0VPQ2xBcko5K1JqdGNrMmc3REJ2?=
 =?utf-8?B?WS95VzhqaWI0azBUd1VsZ2UveU5ZMEhzb2xqVGZiaXBmUE1WK2QwMk1TcmxZ?=
 =?utf-8?B?OElNa0UrSDQwMXh4eTlWYXFRcUpVY2tIeHI5TE52QjNJamNMVFpYOSsySEtY?=
 =?utf-8?B?RGlteXRtekY5OFN3QzFicVFoTDAzdWNLZjNBUk05V0xXUUJ5RUZPSFNUUk1F?=
 =?utf-8?B?UFJnV1JUaFV3bTVIaWk1M29nek1aVlBQVUEwMnNndUtydSszKzAvWFU3V3JQ?=
 =?utf-8?B?NDZwK3ZWaXV0d1NoQ2lsVk53d1pSSkpaVXlHQVE3UlozcGl4VmpWc3V5K1VU?=
 =?utf-8?B?SHhNSXMvZkpITitEMDN4WllIbnVIVFArZ1hBeUpjakJWbWRBOFloWnJRb0hL?=
 =?utf-8?B?N0liS2lORkI5RmI0Y2hsWFV4a3luR2ZTT1FUWWVjOGZUbVJyL3NnRW5tRjgy?=
 =?utf-8?B?ekIwbGhseFhBb2NoL3pPZWdKL1pmNkZmeHFrcThQWkVpUVBjS0hLZytqVVNL?=
 =?utf-8?B?c0lSb2hzeXpiQnZQbkxVd3FJOWNCckEybzZyNUdjMjFjRHljS2JmVTNwRENY?=
 =?utf-8?B?OFJYeFlrVlZrN3NhWTcveDNZZEVmeDVHcmtUeWZ0VXY3SzkwRTZKY3VqbkMy?=
 =?utf-8?B?RHVBS2pHSnVvT2JjRXU4ZzIxOUpwZ3hXZlplcFZTcEpoQmZLazBqS2RVZFZz?=
 =?utf-8?B?b2owMXZvY055bktsWUFWaHRsUkpVQnh1ZllZSE9CL1hrN2RzNXlvWmlqU0FE?=
 =?utf-8?B?a2ZUYStnQTRIeW11T3h6ZXd4RW5aTSsvNTNtem9GdWpsWlN3ZUJsK21MODdC?=
 =?utf-8?B?ZVpVcjB1YkJoZFZUMUk1TlR5YWcyVEpYaU8wWDRVdm5QM0pNYyt1SnJ2Sy9y?=
 =?utf-8?B?cXorSUFxRy9ycXhEdGhvM2VuajZ3SGhsbnZCZUdjVVVpbXJVeS9EWm5YdkZN?=
 =?utf-8?B?K0xlbU93Vlc3RFVRMHVTUlFlYzlFMkRDbmZuZEExTDNYYWFCbnB2bkc2VnJJ?=
 =?utf-8?B?QjNaZ1U2QVhyRVQ0Vy9VaS9aN0hxNlVoaFJrTnZqTXd6K0Z0Uit1dVVBc1RI?=
 =?utf-8?B?MThMV2R1S1A0NXpqdTJkMm5LdlNCZkc1U1pzeFNyNmtzQnI1WWRuQjJsYk9T?=
 =?utf-8?B?SE54UnpPQ1owQWJmVlNtSXhIZ2dKckRqZnVKVWMyNFgxOUYwak1OUmIyZ2hz?=
 =?utf-8?B?ZkxqejRhOG5mSnMvaGxBbjNGRmdEcGE5a0Zobi9QMXZCSi9MT0Mvd3RPbFZG?=
 =?utf-8?B?UTJ1clFnYXVXSDl6RGtVajlsMWtqczR4b05lR2hWRyt5Yitpa243ZldjT1F0?=
 =?utf-8?B?WnVkOVRFblFTZDVuNktESzJpeFJZQ1FTd0hGdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da72665b-a83c-419a-3471-08dc4cca60be
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 12:52:07.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkpAuUD6IZml4DQLT4QXA18i8bwipVje0mvxEiCoRpT19wngSd4CTpZQoXAtXoMF5DieUfFyMX/pgSsj0/fhaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5688


On 2024-03-23 05:45, Raphaël Gallais-Pou wrote:
> Hi Marc,
> 
> Le 21/03/2024 à 16:51, Marc Branchaud a écrit :
>>
>> On 2024-01-30 03:53, Raphael Gallais-Pou wrote:
>>> When working with diverged branches, some patches can appear several 
>>> times
>>> on different branches without having the need to merge those branches.
>>> On the other hand you may have to port a specific patch on another
>>> branch you are working on. The search with a SHA1 cannot be applied here
>>> since they would differ.
>>>
>>> This patch adds an entry in the main context menu to highlight every
>>> instance of a commit.
>>
>> Thanks for working on gitk!
>>
>> Unfortunately, I don't understand the description of your new option. 
>> How is this different from the existing "Find containing:" feature? 
>> Gitk can already highlights commits that match a specified string. 
>> Please explain what gitk does when this new option is selected.
>>
>> Also, please explain how your code identifies "every instance" of a 
>> commit.  When I think of a "commit instance" I think of the
>> "git patch-id" command, which I don't see here.
> 
> It is based on the name of the commit. I agree that it is not ideal 
> since the name can change between two versions.

Thanks for clarifying that.

(BTW, on this list we pronounce "the name of the commit" as "the commit 
subject (line)".)

> As you stated below it is exactly a shortcut, and now that we are 
> talking about it I think this is not the right right approach to do what 
> I want.
> 
> I was not aware of the 'git patch-id' command, but this it clearly a 
> better idea to base the search of the commit instances on it.
> 
> One thing that I wonder is that 'git patch-id' seems to be based on 
> standard input. This means that in order to highlight every instances of 
> a commit the algorithm would need to parse each and every patch and then 
> proceed to hash them and compare to the one referenced.
> 
> Wouldn't it be a tad long to process ?

Absolutely.  Maybe "git cherry" would be more appropriate?

		M.


>> (It looks to me like this is basically a shortcut to auto-fill gitk's 
>> "containing:" field with the subject line of the selected commit?)
>>
>>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>>> ---
>>>   gitk-git/gitk | 23 ++++++++++++++++++++---
>>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>>> index 7a087f123d..4b15230a16 100755
>>> --- a/gitk-git/gitk
>>> +++ b/gitk-git/gitk
>>> @@ -2672,6 +2672,7 @@ proc makewindow {} {
>>>           {mc "Make patch" command mkpatch}
>>>           {mc "Create tag" command mktag}
>>>           {mc "Copy commit reference" command copyreference}
>>> +    {mc "Highlight commit name" command highlightcommitname}
>>
>> This line is indented with a tab, but it should use spaces.
> 
> I will change my setup to use spaces instead of tabs one this file.
> 
>>
>>>           {mc "Write commit to file" command writecommit}
>>>           {mc "Create new branch" command mkbranch}
>>>           {mc "Cherry-pick this commit" command cherrypick}
>>> @@ -9002,13 +9003,13 @@ proc rowmenu {x y id} {
>>>       if {$id ne $nullid && $id ne $nullid2} {
>>>           set menu $rowctxmenu
>>>           if {$mainhead ne {}} {
>>> -            $menu entryconfigure 8 -label [mc "Reset %s branch to 
>>> here" $mainhead] -state normal
>>> +            $menu entryconfigure 9 -label [mc "Reset %s branch to 
>>> here" $mainhead] -state normal
>>>           } else {
>>> -            $menu entryconfigure 8 -label [mc "Detached head: can't 
>>> reset" $mainhead] -state disabled
>>> +            $menu entryconfigure 9 -label [mc "Detached head: can't 
>>> reset" $mainhead] -state disabled
>>>           }
>>> -        $menu entryconfigure 10 -state $mstate
>>>           $menu entryconfigure 11 -state $mstate
>>>           $menu entryconfigure 12 -state $mstate
>>> +        $menu entryconfigure 13 -state $mstate
>>>       } else {
>>>           set menu $fakerowmenu
>>>       }
>>> @@ -9481,6 +9482,22 @@ proc copyreference {} {
>>>       clipboard append $reference
>>>   }
>>> +proc highlightcommitname {} {
>>> +    global rowmenuid autosellen findstring gdttype
>>> +
>>> +    set format "%s"
>>> +    set cmd [list git show -s --pretty=format:$format --date=short]
>>
>> Why bother with the $format variable here?  Couldn't you just quote 
>> the --pretty part?
>>      "--pretty=format:%s"
>> (FYI, I am not a TCL/TK coder.)
> 
> I also am not a TCL developer. I pretty much duplicated the 
> copyreference{} procedure to get what I wanted.
> 
> Best regards,
> Raphaël
>>
>>          M.
>>
>>> +    if {$autosellen < 40} {
>>> +        lappend cmd --abbrev=$autosellen
>>> +    }
>>> +    set reference [eval exec $cmd $rowmenuid]
>>> +    set findstring $reference
>>> +    set gdttype [mc "containing:"]
>>> +
>>> +    clipboard clear
>>> +    clipboard append $reference
>>> +}
>>> +
>>>   proc writecommit {} {
>>>       global rowmenuid wrcomtop commitinfo wrcomcmd NS
