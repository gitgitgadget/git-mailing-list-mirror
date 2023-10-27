Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD44420
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="OOVgfJ43"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2101.outbound.protection.outlook.com [40.107.115.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158DBC4
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX93zaUBp5JHwj48i57qj4VWNdGwst1S0x/lBo8zQ+9kg3hQYTrOjKrET1JTLAn/pgnfgPo6EC4mreQxTpRNjUmK46rnPHMFBXYxHcLG2xKoAUGVpL3cUsZ/cLxvSHqOLRCwQO8gdSlM3b/0S9wdObGtA7SYZR4grGdiNWaxKklfE0n9qJGINe+lZkauqA09hMpDcv2sfoiS3lXpwCIgAea0gkkk4gmoO+sEQLoskWISiU1mtNvj6gkVgSmN+Xqa1c234m5VRSncFyySdafnVmrB71craDP2FEElbdkzFvIz5+Msl3jaNksQu4FsPdVrrcuOSzKzQaHnjX8hfwp5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fPt94mLdA9dgG2ib+HFXgMN5FRpI+zbKzO04RIxTgQ=;
 b=gfiHzuIxajSnMQpJOt9taruPPXFnE1lRgFTBonNrF/gzJz2owahCka1SR/t8T95bWbxt1XtYEB8xphHj+0PiS8ymWzJU8pJHJQKwE13A9nJS2K4WcF9X+je1EEyTn0VQZfsslP8gcBR9h2ytAeZR0kz91YX01oJU9R8KapSC52DxIvslZP54DAyvhE/QR6alNwC/WU1GedtlArM9GLjzc2tJ+kzMCEvxp1LWf5NY680pT49h7dHed7EdDwt6hZTIY7qoSrIfQ9Q+gcb0jY2frcwi50Ne+PRUaFctQ/H59ctSDL4mVKaBV4LFlBCxUssR1usxUQRw8zUw+IusNrdzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fPt94mLdA9dgG2ib+HFXgMN5FRpI+zbKzO04RIxTgQ=;
 b=OOVgfJ4316y20fWXHgYjyBmOY1MBvBoH+uuIO2dI7T3b2UgKXRx4oTY5OqcTR+rj5EQ4+xf2Q5tAs3M+QpmIJITTg77sKpRX7jEum5GV/geDKVyeCAHwBCxcH3c9Ve8DR3AiTnZPNHQl25lBNU6+fwo0abokzry4/7m82GICQeu6+eZ6oxmTxUas7HDwww+U4w5lieZ2Vg31QtHM+2Oc+PkrMRCDNfw8Pbkx2ZR1JTtsfharWjDsP1TeLlKGnOf9rrW7HxPP4aC86bMhG/GfLwmQPcOHSAr0moOJik7CDN/Lmt9wWS8cpqfaxLcaC7v6kaV6Z0eHJl3Hhb+AeBWg9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YT3PR01MB8323.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 13:14:44 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b888:ac1d:f4b9:93ea%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 13:14:44 +0000
Message-ID: <56e3e974-a027-439f-871d-c7fbae65a04e@xiplink.com>
Date: Fri, 27 Oct 2023 09:14:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] git-rebase.txt: rewrite docu for fixup/squash (again)
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <20231025102932.1202299-1-oswald.buddenhagen@gmx.de>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <20231025102932.1202299-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::10) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YT3PR01MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: e9abdd3b-7102-405e-2cb3-08dbd6eeaf7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LrYT2juhxpRu0RwFIFSdKDQKScmkcLuQMl+arTnwjyRBi7cVq9bFJ3xKSwhBdA0rQEyi6bX09GF6OThCwKpOfrlQnkykpDvhZNFiNpf/VBEoSAvk230tR+AtsXNYKK12991Jrkz2i0E/rZNLrhma5yDsadas/KOcWYUP56CjrJLyL1W3BFxp35iFHs7s0avXHguq2Wa3oWnCXS5rjs7LE6h72EgjuJ6V+Nmat/Xa9Dr+DJSitSYE+5iQOOgWmpgi6q0uL24IgdkBa2/ujvF0m7tyR0b0Z3XNHzKXv5Li/HGA53aEZRmdUlt4dEQ9MdLKSvgJePM5MIO7JFsp+vtCye+elJCL7IWFXU+pb03zOkke8w5XgfypO1UtE7ZH42Z/iZsOKk0gVk8ds9/njW3YAIGPdNYcNhwqLZQS3Af1Y7LrTXBibx7WLNsnIOtUKX/oBn+9j3sKLk80LZbQzTA98pI2tE9zy52XKS43IhMSBmoXL1h2p5hxe8OLXLOOyTxP7JdxtvnJB2c1cKSuKzZVugneP05h61nIDS0Yl6kAT9xjFLSMzIcR+uZb0mkk+G4oBzVJVP2dKOqpcAepdi2sK1qnottC4zzRTmeXCoe9rFGAQjX63Xyu1fnYD7qffWYIrQXWGzRyZOZyX7/AOuTt+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39840400004)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(26005)(53546011)(6512007)(2616005)(86362001)(31696002)(36756003)(38100700002)(83380400001)(2906002)(4001150100001)(478600001)(6506007)(6486002)(4326008)(8936002)(54906003)(8676002)(316002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1Y5dlF3akZXOCs5b1o0K3EwcVY2MnBZdmpWOFkzelhwY2gwRyszZkpoamJ5?=
 =?utf-8?B?QmNuM08wNFNIS1dCeVVQYTZrT1pCOTU3YlpuQUVBNTZzOEV3VzdZNC9pelRI?=
 =?utf-8?B?a3dSdlhvQUkvS3cvdFdkcnY1VEFaTU5xcXZ2c1BRWElXa05KRnRwWEtDaXpL?=
 =?utf-8?B?NWYrM0xQNENBdnpuckRaNGNNTDZ4NVZzSjkrSzhFNjJxeTlmRnpOSmN6VGNt?=
 =?utf-8?B?d2RyQ2ZPTWljQkVFMDZtVk9SMHowQ1pNL3FNbjM1aWdHUEVUaFEvbEJsY1Zh?=
 =?utf-8?B?czI5TUJqVnZqV2lZMG5tdHNSUGczZVJSaGlCRzlEeVpVT2pGemxOSGw0Q0VT?=
 =?utf-8?B?aEVVWmJVK1dxMDdmMEdJTVFKczdwWXdQTnRXdmxOMERIczZNVDFoUTZ5Y1Y5?=
 =?utf-8?B?KzljQmNNa1E1ZEwxSlpQOUFPN2diRlh5VHhoN0trSGR4QncvcTZZV0JhbXEr?=
 =?utf-8?B?THpFVUFJbUs3R3lCT3JoaCtDandnNWRZZUlrclFyVTJsbHZzNmpRS2haT3pV?=
 =?utf-8?B?dndhdU91anNUOWw2WUxwQU50R1RXREF5Q05OWjAxNXowNmE0cW5teWdkeVE0?=
 =?utf-8?B?NmJaVUpXUE9aR2lBQ09WblJRUjFxTkc0MFNyR0VKZ1g5Z2Y2L1ZVOUZ5R2VQ?=
 =?utf-8?B?NkNEUEJrRVpPK0pwWmdXWU92dDBHdDJ3R1VBSXJWNkdPVmJkUGlHYzVVM0NL?=
 =?utf-8?B?NU90QTNYZU1PdDFXdEFwbnFHZU9KcExyWUswMVl0a25DZ3lPTU4wL216OHJr?=
 =?utf-8?B?ajBzRTBVSFRKM2hXOEx1a1RDZk9SZlE1a1gvd3dEVk50YzZRc0hFZVh1TENn?=
 =?utf-8?B?cXl0bFlUTjRva2cvbEVSQXBjaHdXMkFTRllwb2FyUDN1NTVQS2pXNEJhTGs4?=
 =?utf-8?B?ZytaZlJLaHlhc0xWbTJhb0ZFUldKRzg0U0lGK0RDalR1aGgyS3dCckJtUUlZ?=
 =?utf-8?B?YUY5bXNDK1lrT0ptTkw3aXJmaXhnYmlmWmcxTmhuQUphVVRRcEhPRTRCUmg5?=
 =?utf-8?B?dHVEUERkNU9jWkR1MXdtMVdEdThPbUM2US9vTnB2d3pPK1pZamlybXdNbHM3?=
 =?utf-8?B?S1lyUUhkdS9kNG0vLys2QUhGWDkwK3dWZ2xyWnphZzkyV3I3LytmUkI5UStE?=
 =?utf-8?B?RUFrMldFN2N4VE1XUnVJaVhtU2FIdWUxaVIyODdqZGlMa0syMXNTN1RyempK?=
 =?utf-8?B?RG05TzM2WDNoNk90ZGtVS2kzWVRVd1JhbC9TK3FUUFpydUxoQlAyZVNveXdv?=
 =?utf-8?B?djNqM0NMdG9aQ1JtalNoZGRTQjZtQmVyYXBvc0trWU1sUnFVbVhKMDkveXZC?=
 =?utf-8?B?d1EyaHpTaHdLZnNERGgwOE0zTTdzTW15SmkxQ1BwSjBVcFpsUWxxUFBGUEZk?=
 =?utf-8?B?N0VBT0lKNTRvZFA1c2ZySS9wT1NIWEd0Yk1LR0dlem5iWFA4OHhMS2tlK1VK?=
 =?utf-8?B?RDk2UVJGNFZQblphUm03Q0hPRHFJK0xhUGg0SE90VTkwak5KcUNtQ3RabFpR?=
 =?utf-8?B?NlVXRW52dGE3Zk5KTkVTWXBsdmlhSkRXdFAySi9mcnNWanRodHN2azIwbDdy?=
 =?utf-8?B?bjhnMHo0VHFHemI4UnREQXFsL1AvWk9mdE1BRDE3dGUrZzA4aHU5NkpOaFYv?=
 =?utf-8?B?NldtNlVZWG9ydGZtRUFxU0dtNEUweDAvdGJoLzVodnpLVjl1dlVvbUxiMHVX?=
 =?utf-8?B?Mk5tMkdNQVFWN0EzSytmaFpETjdxMlVPYTQ2Q2hTOWRYUmJyUkROMGY2eVps?=
 =?utf-8?B?bjAzOEhGMU8zOHc2dVFQaWxhdW9LTGF5Wk83NURqdmFFZTZ3WS9UNVFPS1l3?=
 =?utf-8?B?c1hsYTNnZzdadUQ2V1paQ0FSMlljYTIxY0pIU0dQclZqRFZoS0dCUi81SFJv?=
 =?utf-8?B?WDVoVStmZmJVOXFmdmdHaHNCckg4cG4yZ2ZkVjFDZGdMUzg5ei9TaUQ5Mm9C?=
 =?utf-8?B?aXF5dUpUdDZncGF2THY5dFdleDAyY2xrUm15SzRWeHR3UjhoRTFwQStoVm9n?=
 =?utf-8?B?elgzSUpBVm1KMndrNS9vZCtkejJnajVtQVNSaXF2cU1BUHlWY3BUSHI1RWJy?=
 =?utf-8?B?d0ZrSjhQZGJIRE1UbWx2d2RiS2tkMDVxQ3VHUT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9abdd3b-7102-405e-2cb3-08dbd6eeaf7d
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:14:44.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jz40Xq0k4cu6HQ7IM+Iz2oY5i2jVoPDvCkFbLOmcw66zPvMzVHCRI+hBCkektzFZ6/Kl2N0TlEgX7/+cOwu8MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8323


On 2023-10-25 06:29, Oswald Buddenhagen wrote:
> Create a clear top-down structure which makes it hopefully unambiguous
> what happens when.
> 
> The behavior in the presence of multiple "fixup -c" is somewhat
> questionable, as arguably it would be better to complain about it rather
> than letting the last instance win. But for the time being we document
> the status quo, with a note that it is not guaranteed. Note that
> actually changing it would require --autosquash eliding the superseded
> uses.

I do not think this kind of editorializing belongs in the commit's 
message, but this likely isn't the first commit message that expresses 
an opinion.

> Also emphasize that the author info of the first commit is preserved
> even in the presence of "fixup -c", as this diverges from "git commit
> -c"'s behavior. New options matching the latter should be introduced for
> completeness.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> ---
> v3:
> - adjust to reality, and elaborate in the commit message why it's
>    arguably somewhat suboptimal
> 
> i deliberated the 'command "pick"' word order swap suggested by marc,
> but while it improves things locally, it somehow doesn't flow with the
> "redundancy-reduced" last part of the sentence.
> 
> v2:
> - slight adjustments inspired by marc. however, i left most things
>    unchanged or even went in the opposite direction, because i assume the
>    readers to be sufficiently context-sensitive, and the objective is
>    merely to be not actively confusing. adding redundancy in the name of
>    clarity would just make the text stylistically inferior and arguably
>    harder to read.
> 
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> Cc: Taylor Blau <me@ttaylorr.com>
> Cc: Christian Couder <christian.couder@gmail.com>
> Cc: Charvi Mendiratta <charvi077@gmail.com>
> Cc: Marc Branchaud <marcnarc@xiplink.com>
> ---
>   Documentation/git-rebase.txt | 30 ++++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e7b39ad244..578d1d34a6 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -890,20 +890,22 @@ command "pick" with the command "reword".
>   To drop a commit, replace the command "pick" with "drop", or just
>   delete the matching line.
>   
> -If you want to fold two or more commits into one, replace the command
> -"pick" for the second and subsequent commits with "squash" or "fixup".
> -If the commits had different authors, the folded commit will be
> -attributed to the author of the first commit.  The suggested commit
> -message for the folded commit is the concatenation of the first
> -commit's message with those identified by "squash" commands, omitting the
> -messages of commits identified by "fixup" commands, unless "fixup -c"
> -is used.  In that case the suggested commit message is only the message
> -of the "fixup -c" commit, and an editor is opened allowing you to edit
> -the message.  The contents (patch) of the "fixup -c" commit are still
> -incorporated into the folded commit. If there is more than one "fixup -c"
> -commit, the message from the final one is used.  You can also use
> -"fixup -C" to get the same behavior as "fixup -c" except without opening
> -an editor.
> +If you want to fold two or more commits into one (that is, to combine
> +their contents/patches), replace the command "pick" for the second and
> +subsequent commits with "squash" or "fixup".
> +The commit message for the folded commit is the concatenation of the
> +message of the first commit with those of commits identified by "squash"
> +commands, omitting those of commits identified by "fixup" commands,
> +unless "fixup -c" is used. In the latter case, the message is obtained
> +only from the "fixup -c" commit (if multiple are present, the last one
> +takes precedence, but this should not be relied upon).

I like the overall phrasing here.

But I think you should remove the "but this should not be relied upon" 
phrase.  This reads as if Git's current behaviour is undefined, which 
most definitely is not true.

Even changing this to something like "but this might change in the 
future" is unhelpful.  Everything in Git is subject to change over a 
long-enough time span, so the same could be said about every aspect of Git.

Until the behaviour actually changes, it's perfectly fine for people to 
use multiple "fixup -c" commands.  There's no reason to scare them off 
of it.

> +If the resulting commit message is a concatenation of multiple messages,
> +an editor is opened allowing you to edit it. This is also the case for a
> +message obtained via "fixup -c", while using "fixup -C" instead skips
> +the editor; this is analogous to the behavior of `git commit`.
> +The author information (including date/timestamp) always comes from
> +the first commit; this is the case even if "fixup -c/-C" is used,
> +contrary to what `git commit` does.

This phrasing is much better.

Thanks for putting up with my pedantry!

		M.
