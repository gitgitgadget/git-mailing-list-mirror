Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2119.outbound.protection.outlook.com [40.107.115.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A5A947
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036301; cv=fail; b=SsFxA5F/n0ViHrW1+TQ/KwszLUBXcZkW0ogCCCrvEk6vBM9Jl1LqsNtCzXSKMG41nOKT9CBlRwRT01Sg4kCq8Ypzq5KkSJf8p0hqnvN5CN1eY5pbXuGjIxGqwIRMWMSAXLKHG8/gI1q6+z2OcXjh5winZmWdLMGiv36VzpdMSA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036301; c=relaxed/simple;
	bh=1Yo/yZ2qhk5gyR0czhp8F5eq6jt8Iq9NGK0NUzY712E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pn0Dk1jqGoD5XwjdIF+U9A1hPxk7bEL6tSKBuinWkzLvJgmE9uK0dRk+VKdMcyLzk1jXS3XWZo9WhV8LHy/Pya8cmEqOYWIqjluna2hmAnl+G3hqeVFISCYnNp1tc0JG05Mb7OBojV6GIjEGAdJSElv9QKKoexbPtllUfVAqlS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (1024-bit key) header.d=xiplink.onmicrosoft.com header.i=@xiplink.onmicrosoft.com header.b=GukU93C9; arc=fail smtp.client-ip=40.107.115.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiplink.onmicrosoft.com header.i=@xiplink.onmicrosoft.com header.b="GukU93C9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idkaSNQNYyXcF176QOlfRz9yJ6kImoiUITd3GchHcljwgt0++KQxzinSRmSoP2R9uOUhuxDB8+M9+HqKf8Ygsc2JGrjw6ywRUamjeUGMDpW4TfaZqtqhUn41tGL9wd0hxnijA5qx3Y2O6I5xyEttKkFJshmv0n236fz9wAL9fr/f2Qu/qyygBj1DNo8yyZHat6C7z3NWPflBHUJc7XVm6qoP4BYoxuriFx7/IdmhuG9pG1I698I1w2ogEUy9RRWh7p5mTIIh3ev50cGV3OvgmmtNWu7NDPk0VyM9E3z409vnWoFftKilembYEG3kW1ztIfzhY6N1nixn5rCoMLZNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+XV+ExeZbeYtK3pKCVKDrTXQ6lcKtK2fvNYWizTXTU=;
 b=iErTQrXkuZpiDXeom5kGpNOEFa0MMnHZphf3NuBmpwHtdP7KY1R6TaKOPwsX1Wq5LAsZscxKtCuv7Nm2rgTPr0J5aw18H3QrHHQTBkyFP0QZ1RGTJSdKf3Sv5Kp20LILIsODUtmy7ic86mTWP+I1xWxrNmuJxdR0S/uhNjFrXdvxhQq1PzxvhaBfrcik7ktYpy45uFRgdNKPLoZeCy1xp41hFN6dtdl+fTAxVBNzYUuWe3bFqvIblpWvij105KPnoGg5dOcqDc2wAdeqWNYLkaZd8eI7P5YUUQcSyoY+DoHWAVVddqbfqhvxPWj8l/yCFYCJIrJQ71VJCpoHrCx3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xiplink.onmicrosoft.com; s=selector1-xiplink-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+XV+ExeZbeYtK3pKCVKDrTXQ6lcKtK2fvNYWizTXTU=;
 b=GukU93C9SCr2WhXALS1PCiVYpR6OamQMtVaDnaQ9AbusxKX1oHBlyofVWpyOmVRxhl3EjtZujsfBU0t7cMbWTNMAeYfn8WnUa6oBbb9Vab+kdxtn2MzF/bXWxcWZZwQSCArLx3TVgUQfgTrwa7cSwl6BSpHnqbX5hxCifEkcJj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT3PR01MB6488.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Thu, 21 Mar
 2024 15:51:36 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c6dc:38bd:5001:264a]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c6dc:38bd:5001:264a%5]) with mapi id 15.20.7409.023; Thu, 21 Mar 2024
 15:51:35 +0000
Message-ID: <27b9c158-5cb1-46bf-851a-88a02448fa2d@xiplink.com>
Date: Thu, 21 Mar 2024 11:51:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: add "Hightlight commit name" menu entry
Content-Language: en-US
To: Raphael Gallais-Pou <rgallaispou@gmail.com>, git@vger.kernel.org,
 David Aguilar <davvid@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Denton Liu <liu.denton@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 Beat Bolli <dev+git@drbeat.li>
References: <20240130085308.5440-1-rgallaispou@gmail.com>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <20240130085308.5440-1-rgallaispou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::23) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT3PR01MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: f00c739c-e1fa-4fa9-ddf5-08dc49bec915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e8EhXDU/EgsWEHXpMmPxCdCsKaQJFv5uiAXQSWOvw/tl7VayulcDVzZe9eG2fRTXTJ/xgF1sr3Am4l+1xP2qLOnNzhV9O9opA8krP3ikmR01EAogO1EbUWgsEXqCA6C+YtPbIvom53NG+uEMxn5J41MllipewItOvIZPjYOITvGLqbyxh1za8lrFz1FqjcLscJ5Y1tf1M3XUY+306vS5wQXqjmANSXKARf2QwavGXVtXFOBKwnf9h9IpRqbcBJv3xg6RkNML+oRIE120yW+eLI0OAfWx78AdPemWSz+LgTjIuEilVGEWc0/rf7jije31qdAI/GW2qQE1ERS7XbjtNzNgIMtv1vn57lB27Xn0R0Is7XivKSFaTwD7atRvvENVyWNUL0T7XThnAbG1Z8evrEgfJwZsea/OreL5mZDuBGoGUg0hWwW6VIwwtJ5as2zw2wewRRAYfvEiwzG2qeY20aTyNt3hgf+ltJ+5LSVBmxKRR2/N5bmFwPDb0tjejlfVlyjoIau2rWnZOcUSNSlCtGQvVVdtxSOkLmO8GACdgnn/Q8uVhEVh8702gpupX2TAi2HSv5wxNDNpT9MavriedRZgnwAyk9PaGEu7psDamB4qSwo5TMyAeSTVs3QR0UXzct/32LQS6FHPQFnTcdfDrgfM18iWu+/Z/Y2rCat7AXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFibm54ZUtMSVBKdmppVmtONGZNbzIzVERCNklaQUw0Zks0NzRJUDJReVdy?=
 =?utf-8?B?MXVyNGttUjk0Q0lpM2p6dk5EUGlHdG9YZTh1UDdFWlNZR0pXSUFVVUtSM3dG?=
 =?utf-8?B?SDRZc2Z3a1Z1SUY4RXVpT2wzcE5ac0VKbFdwU1RLejVsblh3ek9sSFROTHZi?=
 =?utf-8?B?WnE4dXNtaWhENnFVMVBETndyemhhdGtNTC93a3ZGbjVoSHJPNlovd1EzcG1V?=
 =?utf-8?B?UzZ3T3FUSjl2emNXVE5ibDZuc3ZZT3g3NzRJWklJWTdFU2NGdGJqSElFQWp0?=
 =?utf-8?B?czdRdjJ6anpkNS83akxxbkM1U3FPaldpNlRPb0t6WS9GdjhkUmQwcW5pSFdB?=
 =?utf-8?B?Rlp5MDVGR2Y3YXI5a3ZPYU1meW1IaHUwZk5lOW9VeGg0dXNSLzh4dlRRdTkr?=
 =?utf-8?B?UmpLN1BjMFBVZ25WZHB4a0l0U1JrYnV5YkkxSHdaYzBHTGx4cUZWOXJtUm14?=
 =?utf-8?B?YThLZUV1eG9lMWhKYlU3ZjBjZjFFYlM5SDJ5aHFNR2JpOC9sTHlNZ1JCTmUy?=
 =?utf-8?B?WThsampUUFJyT0lBaDJrVThzODFNa0dON3Zsb0VHRlQzWklLN2gzbzUwWFV1?=
 =?utf-8?B?dndtZUdpZTZ3U0RBQk8xUXZCZzVZbXd3eEVuQUd3S3ZuRW9pTWtEcXRnelha?=
 =?utf-8?B?eURlM1lLOElpdVdNNFFtUjlyUnNuVlZ5SjFwT1lZOHZ6Sm1meGZJV3BHVWhC?=
 =?utf-8?B?ckovdzVCVEd1eXFWemlrYXhKZDJrVVhJd0pkOFRNTC9wRVNvL2NPYjg5Y3pN?=
 =?utf-8?B?ejZFQWFYdXlWNFgwUk1nVGJnMStoaXlidURkUDV6emZqV2cxVS93eWtoTHdF?=
 =?utf-8?B?MlMvRFk1Rm9ERHBySW1Lb3ZVV1NkcjhLUTJCL1ZzQ1JMWVBlY1FHcmU1TTVU?=
 =?utf-8?B?TzJTYjJzN3h5dnN3aURpbXZkZm56UHVrS2w2R0ZMb2dIMDNMdmZEZUcyMjJC?=
 =?utf-8?B?K2Q4akxiTVJtdkU0emoybmMwZU1OKzBSL0x2dnp4VjR6cTg1MFdDMmVHZUEz?=
 =?utf-8?B?UHN0UWtXc1A1aS8yRUJIVWU3ZmtBeXY3TS9mRlc3MmZ2M3JTWXNlRm5XSDJn?=
 =?utf-8?B?UXl6RVlVZnZIZ0xrVVI1MFFnbmlmMFBwNW5VY0YyMnNTYkx4QkJzSWQxK255?=
 =?utf-8?B?L29EWEhUTE43eFVscWtvaEcrZGpmNTh4ZThvRHNNOXFrV3Z4QkljRGRXZkdW?=
 =?utf-8?B?MVFSRmp1SDFYempHblFUUmphZTNhekZwS3RNVTVySjhwUFVabzFOTzc4RnB2?=
 =?utf-8?B?RmJ2KzlQYkdja3lCRTNKd0tWL25GZlFOU1UwbTd4MVhWNnI2cEpCa052Zm9O?=
 =?utf-8?B?MTRCZi9reGt6YXR5RDZqYjJzbUM0L09HQ1VZQWpaeHJRRXA4aUV3MmdIN3o2?=
 =?utf-8?B?bmtIYjNpVXhlbHVDdG9WdDdtbGNOWENoUVY3bmhKQmh5RHFwaCs3cjhMYnVP?=
 =?utf-8?B?OE0xM1Jka201MW5kbHR2aldYdjBXdVpEc1JhSTgyVStSaG9Xc3JKSkYxclYw?=
 =?utf-8?B?OU5EV2x3YTZxR1lNNFE2TW0xUWVHckxmc1Z5SFNUQkhuVk00Y1lwS294azNr?=
 =?utf-8?B?YUtJcmo4VXZ6M25vWHkxNVhlTkkyQlF5cC9JSDU2UGNUN3A0bUtRVFdYTWlW?=
 =?utf-8?B?UHhCWUN1eThYS2c5M1A2UDI3aVVMQ0I5RU13TkVMQ1BUb2lJSm1VTEsydFY3?=
 =?utf-8?B?c3g0TkZzTFQyM1dsdHZ0Vmkxam5TeUFDS2FiM2NUVi9sTVZsbUZBek9wS0Fv?=
 =?utf-8?B?RGNlRThTWWQva1Q4MFhSQXMwK3pESUlrVVZPQ2N1RHhUamQzSXozQ2VtWkR1?=
 =?utf-8?B?SFFXdGJWdDVtc2FjNU93d2tWS2NNbS83Z0VqeVFLVm5RMHlBT2dRTWs2YVBz?=
 =?utf-8?B?NTl0YmR0d014NEp2empUaWZDMmNlc0FrbERDdDBpeXlNRkRzd0RkZ1VyQnhi?=
 =?utf-8?B?dExGNW04R2k4d052a2crOEVmdE1zblBjRXRlc1E1cGRWb0RtajZtUVZsT2xP?=
 =?utf-8?B?U0RLVDVaVDh0Yi84YmV4aFQ2UUFnbTdiVWlDSGhWK05xazJaQ1FUbHZZU2Nt?=
 =?utf-8?B?dmwrZXRGVHhJd0JSRUNUYjFnNThISW9YelpVdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00c739c-e1fa-4fa9-ddf5-08dc49bec915
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 15:51:35.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXO2kQ8pUs2iDYFkfoGwYObqCN5Io8ql0C5ZKZKyVKXpqa1uMHadJsIrV2kpNJLPNzUrRezKtiW8gld6qmh66g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6488


On 2024-01-30 03:53, Raphael Gallais-Pou wrote:
> When working with diverged branches, some patches can appear several times
> on different branches without having the need to merge those branches.
> On the other hand you may have to port a specific patch on another
> branch you are working on. The search with a SHA1 cannot be applied here
> since they would differ.
> 
> This patch adds an entry in the main context menu to highlight every
> instance of a commit.

Thanks for working on gitk!

Unfortunately, I don't understand the description of your new option. 
How is this different from the existing "Find containing:" feature? 
Gitk can already highlights commits that match a specified string. 
Please explain what gitk does when this new option is selected.

Also, please explain how your code identifies "every instance" of a 
commit.  When I think of a "commit instance" I think of the
"git patch-id" command, which I don't see here.

(It looks to me like this is basically a shortcut to auto-fill gitk's 
"containing:" field with the subject line of the selected commit?)

> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>   gitk-git/gitk | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 7a087f123d..4b15230a16 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2672,6 +2672,7 @@ proc makewindow {} {
>           {mc "Make patch" command mkpatch}
>           {mc "Create tag" command mktag}
>           {mc "Copy commit reference" command copyreference}
> +	{mc "Highlight commit name" command highlightcommitname}

This line is indented with a tab, but it should use spaces.

>           {mc "Write commit to file" command writecommit}
>           {mc "Create new branch" command mkbranch}
>           {mc "Cherry-pick this commit" command cherrypick}
> @@ -9002,13 +9003,13 @@ proc rowmenu {x y id} {
>       if {$id ne $nullid && $id ne $nullid2} {
>           set menu $rowctxmenu
>           if {$mainhead ne {}} {
> -            $menu entryconfigure 8 -label [mc "Reset %s branch to here" $mainhead] -state normal
> +            $menu entryconfigure 9 -label [mc "Reset %s branch to here" $mainhead] -state normal
>           } else {
> -            $menu entryconfigure 8 -label [mc "Detached head: can't reset" $mainhead] -state disabled
> +            $menu entryconfigure 9 -label [mc "Detached head: can't reset" $mainhead] -state disabled
>           }
> -        $menu entryconfigure 10 -state $mstate
>           $menu entryconfigure 11 -state $mstate
>           $menu entryconfigure 12 -state $mstate
> +        $menu entryconfigure 13 -state $mstate
>       } else {
>           set menu $fakerowmenu
>       }
> @@ -9481,6 +9482,22 @@ proc copyreference {} {
>       clipboard append $reference
>   }
>   
> +proc highlightcommitname {} {
> +    global rowmenuid autosellen findstring gdttype
> +
> +    set format "%s"
> +    set cmd [list git show -s --pretty=format:$format --date=short]

Why bother with the $format variable here?  Couldn't you just quote the 
--pretty part?
	"--pretty=format:%s"
(FYI, I am not a TCL/TK coder.)

		M.

> +    if {$autosellen < 40} {
> +        lappend cmd --abbrev=$autosellen
> +    }
> +    set reference [eval exec $cmd $rowmenuid]
> +    set findstring $reference
> +    set gdttype [mc "containing:"]
> +
> +    clipboard clear
> +    clipboard append $reference
> +}
> +
>   proc writecommit {} {
>       global rowmenuid wrcomtop commitinfo wrcomcmd NS
>   
