Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83448C001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 05:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjHDFzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 01:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjHDFyk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 01:54:40 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2038.outbound.protection.outlook.com [40.92.59.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF333AAF
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 22:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3gFXxf7lUIw5Kb/sTiD1mO13HFnnFS+Q/wwSXeiOiTufIKNJdfLLAvyGhAuI6XZ/v2eo/bgAET7eXNSEbn5dPDnenHw7IxQ6jXqzODnzHFSZfw/UNJ6y6GGVxYoAVnbXVR9sbdJ8YWT0vB+qsmnbSntZHqZddCYjuMrnG+hGMdLUfyqgpP2GRFIB7swMOFAGt3yqOs/erYQcxpDqp9V94sIUN8c54Uhl1ilWZOI8bTdtNX4vW3Lsp0w3SJPXuBcxn330ZcDag77MuOpSk1SpAMguTd9+bOHvcDXJZbCj6qahn0LyGPVfpjz5Urz/I5uOLGF8ge84YqPiEJeg6/WWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYJuHROHWtIi5H/KpSN93jAMAc+YM2aARXsqehVFprw=;
 b=ldnYbzObzRDG9E2GK1teC65QVcoyKkh2zJ6Unyf4LkGyo5ZbcK56tv1QwVYCJYIHQ1J8gdx/BVRqDmfg5Jj381H4Z6WInZK5ORIDwDDx2p3BBMxlY2aVIFljS1MeNREG8zx3olckXAjd9rLjKqqjZDbfM9BeT03kLj4upyqfWZpXG+QEWa75B2HFIUbNs+NQ6Zs3d7eIAlh81JyMTkSmtXz2YGK1D7oQPes0crmz6+W/YnPW+qN+w448YdoD4+Uo7AMx7g/yckZNBwOUvFsWsTiZV5df1PAjDO8ZOQRJIr1AyhpW2dZhDEVW8hUXV6NCQDduUVXSfldAguoVDgFQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DU2P250MB0302.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 05:54:36 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::e27c:83a6:825:4ef0]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::e27c:83a6:825:4ef0%5]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 05:54:36 +0000
Date:   Fri, 4 Aug 2023 07:54:34 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     =?ISO-8859-15?Q?Matthias_A=DFhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
Subject: Re: [PATCH v2 3/3] docs: update when `git bisect visualize` uses
 `gitk`
In-Reply-To: <CAPig+cTE__6B3RNbew8sHQQC3ELi9YAArYX5ofXRpMPBzZfmrw@mail.gmail.com>
Message-ID: <DB9P250MB06922EB40B40F07DBAA1441EA509A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com> <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com> <042271990895c4cfdedb20c3aed3d4141df610bd.1691122124.git.gitgitgadget@gmail.com>
 <CAPig+cTE__6B3RNbew8sHQQC3ELi9YAArYX5ofXRpMPBzZfmrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN:  [+omOMA+X2tBqYg135iw5ga/HxOLaUhB3]
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID: <2eedc8d5-8bc9-9feb-dc79-42211888760e@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DU2P250MB0302:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a005b73-9a6f-41e0-80ca-08db94af4886
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G22ER9IDjWELfzbu2ixzDOGyapQZtf++LJ3zklujR9Np/dJCobj8j0M1FSH5Zq4cgiI1m166oGFjPFW6chYmelULi6NBOg04C6o2qsyHrxUZK/Cwc5M5mLN8dBvSPOVl2qtXcQRsSVlEbhxmpoJEGUEfivnhl82U5Mi6OMhPD2ZXB+siNshwr5N2FGcf8NVj+g9MjgFOfrNkKgRnOavYKNUINnhByUxGbKrDFWix+a08y0Ur1a6OikmLB8mAWSszhh9E/uvvOdf0Hq712Krx3kO0FfJWLdowsEzWScEjVhjPszdbwgN/4BdMf89jaIngyxaQId9TFdM+uv++geVb06KhTCPCexcQCx/wU1Wz40Mv8X82zLednbc0qErxJR/B00eTO2XYiWaPsQePMC397i/kEtqpiKPzil/GqelV224UjGDxCw32qcG1HaLpItKdpAZhIlFDiPtE3DY/SZtkXtLJ0JGOFFljK3bwSLwlCh9aJI8OaA5Cn9uoh3DNgTOVu945Jw236QIXQyI8zA0EAKSUZXv8hLCmchtpWTu2uNVTHA7ARaffkgFz+1OBOtpknMNABusJju1TtbiEHNuaxGPKB+rEVlij/2lkDLEmfP8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFY4dFhsNU5uc2M2UTRCbCtIUkxJYjIrMnFrUEU5QmI3NzdtSlRXV01ZWm9q?=
 =?utf-8?B?UFZRdDh6WlVoVVFVRWdaYnJldFFFOHQ2emk4N0VNRW02T0pWR295TkhXRHpy?=
 =?utf-8?B?Wno0QzAzc3FOZ2gyTlY1UDR0RTI1QnVRUS9pdDRsTkkweEg1a2lrb2dBU0FC?=
 =?utf-8?B?aGpmMmlIVTVKQkw1dW5oZWF4WE4zcnpsWXFEZnNNWnhiY1FOOFFKMWVaN1dL?=
 =?utf-8?B?VzFqSXNOa1BKK29uckQwZmpyc29vdExtY3lYWkUwUC9uR21jZEs3cW1CVnNl?=
 =?utf-8?B?K1Z4MmRQdEhLQ2RyeEZiQXBTSUlhWlo2U3JLT0c1S2hFWERCb2NmaGtBRU55?=
 =?utf-8?B?WlI0SVFHZHR6NnRKZURaZlA1cENBMDBFMXh5NWFTRmhDUjliUU1GMFRIaHJx?=
 =?utf-8?B?SmErcXp5N3pyM1ZVMFdGWE92Y0tSb095bEVXa2x0bUVoSm1iczBlcm5ZbUYw?=
 =?utf-8?B?SldXTXJOWXh6TlVFcFFVMmtNdlBFdUhLWkNwRFhrM0NkWnBzT1lEY3l6di9z?=
 =?utf-8?B?dDJKYU8zUmxIS1BmUldHb01RT2tkMXZyRnM3MTdNK0FMNzVPT2JqUFVab29h?=
 =?utf-8?B?ZTluUDhXc0JqeFF0Tm1Vd0R6WWlnT3Z1RE5ud091RW5nQVNLVVNGY1NlTGxX?=
 =?utf-8?B?K0phL09OZ29NY1hzbnc4Nk9ZNE5nZGx1aGZEZ2d1WDc3N0IzbTlYdFpYZWRu?=
 =?utf-8?B?c3dyMzFRS0NvS2pRbS9jNFA4WUF5cEp5cDVlT2lRbFVOT0xJVnBMSmxrUnFa?=
 =?utf-8?B?dkRja3h0TzA2VmcrODZReFp5VkhPZWdwaE9CdmM4WkRxZGN4Nlc2MjZTVkU5?=
 =?utf-8?B?V3BZd3VsQWh6UndZeEN6a1F6Q3pEZUxGNjZ2TXdwc0lFcXh5djVtWThLUnJS?=
 =?utf-8?B?SEc4Vit6Y1RNbnFpbzdnSFRMck1iTWw1RXRDU1RQZFlHNXVHaXp5ZmlxVEdM?=
 =?utf-8?B?aUIwUGo0UGNKbEY4Ti8rdDNlSDl6Q0xjS2REWStXOVZ2VFROOEJZUzVYYmlv?=
 =?utf-8?B?S0ZDTUZoN0JiaFlnY25VU05MeWx4Z1I5L09SWWVDOGltbUpuZ3Iyd0ZoN0Z6?=
 =?utf-8?B?RWhFTzJ6VTlwaEVYRkVJbUNHa1VDMnhUamw2K0Fod0Vhb2ZNWUhmaXVxV0s4?=
 =?utf-8?B?SHJSSFk5K3IxZUswT2djbTBYWFZTNHI3Q2pDQXNtUGx4dmJjNUlqMDhVRkt4?=
 =?utf-8?B?S0UyeUg3Y2g3dUloazhZcTFrTlhjZDhuOWYxYVMwek5Tb3dlZ09rY2Q5Z0dM?=
 =?utf-8?B?QWk1V2VSMW4vT2tLQmFkTDBQUit3dHN5blVTemI1b3FFbC9aaWc3NDJoZnpN?=
 =?utf-8?B?ZGhlYmxCUnh5dmM2aUtLWmdnb2JPV3hiN0ZYRkRUbDIxU3NGaWp3YVI0ZW81?=
 =?utf-8?B?RUpYQjNJV3kwNkxZL0lNcmFyUktJMGNpM2RZNTBTcERnakJOSFIva3Y3eEpL?=
 =?utf-8?B?Y1F2ZC9VeU90K2pmWlNxcjFpeE0wVHprK1hZZWJFendIcE1OWG0yYTBTQmhB?=
 =?utf-8?B?eEcyVlRxd3R5MTRJRkk0S0djeXJUczBCbGNyMXRHak15bVZPeWdsK0k4alRR?=
 =?utf-8?B?M0VocHQvSitiQUlyc0crQWRKODlmVkJwQlExU3pjczFsbEZpQmdTMG5zd2kz?=
 =?utf-8?B?cmdiK1ExcU5LbVRBWlpuTzcrUEptZUE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e3d53.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a005b73-9a6f-41e0-80ca-08db94af4886
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 05:54:36.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P250MB0302
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Fri, 4 Aug 2023, Eric Sunshine wrote:

> On Fri, Aug 4, 2023 at 1:22 AM Matthias Aßhauer via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> This check has involved more environment variables than just `DISPLAY` since
>> 508e84a790 (bisect view: check for MinGW32 and MacOSX in addition to X11,
>> 2008-02-14), so let's update the documentation accordingly.
>>
>> Signed-off-by: Matthias Aßhauer <mha1993@live.de>
>> ---
>> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
>> @@ -204,9 +204,14 @@ as an alternative to `visualize`):
>> -If the `DISPLAY` environment variable is not set, 'git log' is used
>> -instead.  You can also give command-line options such as `-p` and
>> -`--stat`.
>> +Git detects a graphical environment through various environment variables:
>> +`DISPLAY`, which is set in X Window System environments on Unix systems.
>> +`SESSIONNAME`, which is set under Cygwin in interactive desktop sessions.
>> +`MSYSTEM`, which is set under Msys2 and Git for Windows.
>> +`SECURITYSESSIONID`, which is set on macOS in interactive desktop sessions.
>
> Micronit: SECURITYSESSIONID is not universal on macOS[1]; some people
> report its presence in iTerm2 and HyperTerm, and perhaps even Apple's
> own Terminal (although it's not defined for me in Terminal on High
> Sierra). Perhaps just say "may be set on macOS".

I've just checked in Terminal on Ventura and it isn't set for me either.
I'll reword it.

> Probably not worth a reroll.
>
> [1]: https://github.com/vercel/hyper/issues/482
>
