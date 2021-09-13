Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD9BC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384A5606A5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbhIMLsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:48:01 -0400
Received: from mail-oln040092064099.outbound.protection.outlook.com ([40.92.64.99]:10785
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239186AbhIMLsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFB3zpCasCz/NljrFEZIM8ScDDHAIogpfnTZ3KIC0+zIuACqS2lHJLHfLKK9FWHWL/JSwR2XmF6gGWVN/egmIwA7ZhxIAenntZ+im0ezkVCALY63BHjJIsk+B759YBpSz7Q6KLlAk94z8axsPpFtClwN5H9AHJ0g9cIhEuiedFKUMmsQ41lyRlXFTbZBwIkzHb+3n6ag/05CIUoMEsniue4IgFsLrI66E7Wb01EBriDnLh46rXxHx0F9t87C8UkOv1mgSlYoosLDNMKa1laTkzyTwg9PLdJ9ufhqaSeTaK1rP3CEYUIHUQbN174v/O4XYtKdKu5I129ghV66RJcxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RYkMiC/JLQIQp+j32inY7r1aI8Uq7vL1WgtaEoSrIqU=;
 b=A9VnRgESxwjP7w0hjZXTNNSoSxleh0BDEMx17j7g8TIQ7RkuwrO9p9v9Mn1f3G6wl+0py/JpMDLaCJTMXWGncpLlAPhl8TAUZdMvtqkcf2GnkNI07lvscuTMK/ZEPzU1cmzfUga3PXDRXeuuyVByD1No8Fb5jSq9yH9hOQrhdTicUKMNMP1f6H1DpGByHVIXhOXi6MYSriJ50KmO0ehYo8FvVFZdqQmxm4/I4Fk8EHf2l8lbE7QIdawG+swVGnjmSMkDjPKRQFMczGhINHDGyLnPKEC1XzD45fBzCY+LoL/ASKwO7YOdClVJ4L3aZxDBMgnQp72QCGs+mbvy70kzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com (2603:10a6:208:141::13)
 by AM0PR04MB6737.eurprd04.prod.outlook.com (2603:10a6:208:176::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 11:46:43 +0000
Received: from AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::88f1:d597:1caa:2a31]) by AM0PR04MB6019.eurprd04.prod.outlook.com
 ([fe80::88f1:d597:1caa:2a31%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 11:46:43 +0000
Date:   Mon, 13 Sep 2021 13:46:42 +0200 (CEST)
From:   =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     =?ISO-8859-15?Q?Matthias_A=DFhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
Subject: Re: [PATCH 2/2] documentation: add documentation for 'git version'
In-Reply-To: <87r1ds4t3w.fsf@evledraar.gmail.com>
Message-ID: <AM0PR04MB6019DD0BBD77BEA85771B9E9A5D99@AM0PR04MB6019.eurprd04.prod.outlook.com>
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com> <d3635cbfd6ef0d47ebf28c516476dcd0b718afd4.1631531219.git.gitgitgadget@gmail.com> <87r1ds4t3w.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TMN:  [HHGehqlcBOyKwcIztvQJr34NlfDdEslmwXqCY+89/Keu9b0T/J48MpMMdnVPRGNh]
X-ClientProxiedBy: AM0PR02CA0016.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::29) To AM0PR04MB6019.eurprd04.prod.outlook.com
 (2603:10a6:208:141::13)
X-Microsoft-Original-Message-ID: <79a7804-eb96-539d-ef9c-a5e895531612@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from p200300d3bf2b1700454aa355d13d3d86.dip0.t-ipconnect.de (2003:d3:bf2b:1700:454a:a355:d13d:3d86) by AM0PR02CA0016.eurprd02.prod.outlook.com (2603:10a6:208:3e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 11:46:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8373bb22-568a-49a5-3968-08d976ac2823
X-MS-TrafficTypeDiagnostic: AM0PR04MB6737:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkKCaqPGgLF1HwWPUh/GfuFjQXTdckNwbCkv6asJyOWza3I9wTGk0n5RzQUJgc38UF1/q44OJ0wxmTbMbm/cHbBRW3KmGUKD0G7c7vBgYjR/Cf/vrGq951EEvMn27DONKCVdVkDPaPUvxSUJvEmdgCY27YOQii8BeyW0357YeXqrYqZyvuHJNtCiyiQqg5ciK4RtCq0neaoGc4SY92k50xqbb9RfnGbw8b6FxWUz4+Z7+QvJv9HhH19+AZ9VB5NLhjwX4VlhTXT9gwnIucHVeJ7erOQEOtEqJAWQiQiQPxvBe622KTUjr1UjxHntNIbVdvT/Qt7Q6YjRp3+1KW+e87Uu6nL6u9K0blVt9Oh2C1/XknGGwqJb+1+cSMUo3pMbxZnc9iK//P96WuNFh+g+uStSoXj7EzEEJ0iEQ3k8Db7VdKuQy9VcJ9j+lO4r8N/y
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nlGqOqFnzTD6hmqPnVs2OnNvY9PzbzuMVgJzCtCcebhio7ZNiVjnX7pYX5/O8MQr/lDXdxwRB4Pyj10m5f71E5Khd8H9T0/HgHr34BTK0IIBPWd0DG5hhoEtyk3JdZwg91RC1A9IyLCoch7qEIfY/B6Bcr05ibmztU2YB9k3Zws8JYE9RqTxMX3jBhkAxhgjKSvJJB+nSmuyxoxlgC2oww==
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-adf9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8373bb22-568a-49a5-3968-08d976ac2823
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 11:46:43.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6737
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, 13 Sep 2021, Ævar Arnfjörð Bjarmason wrote:

>
> On Mon, Sep 13 2021, Matthias Aßhauer via GitGitGadget wrote:
>
>> From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
>>
>> While 'git version' is probably the least complex git command,
>> it is a non-experimental user-facing builtin command. As such
>> it should have a help page.
>
> This looks good
>
>> Signed-off-by: Matthias Aßhauer <mha1993@live.de>
>> ---
>>  Documentation/git-version.txt | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 Documentation/git-version.txt
>>
>> diff --git a/Documentation/git-version.txt b/Documentation/git-version.txt
>> new file mode 100644
>> index 00000000000..c7d6b496c8d
>> --- /dev/null
>> +++ b/Documentation/git-version.txt
>> @@ -0,0 +1,35 @@
>> +git-version(1)
>> +==============
>> +
>> +NAME
>> +----
>> +git-version - Display version information about Git
>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git version' [--build-options]
>>
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +With no options given, the version of 'git' is printed
>> +on the standard output.
>
> Good
>
>> +
>> +If the option `--build-options` is given, information about how git was built is
>> +printed on the standard output in addition to the version number.
>
> Let's just cover this in the OPTIONS section you added...

Ok, I can absolutely do that.

>
>> +Note that `git --version` is identical to `git version` because the
>> +former is internally converted into the latter.
>
> Probably better to just have a new section:
>
> SEE ALSO
> --------
>
> linkgit:git[1]'s `--version` option, which dispatches to this command.
>
>

I've closely based this on git-help.txt, since `--help` and `--version` 
both are options that get internally converted to the corresponding command.

>> +OPTIONS
>> +-------
>> +--build-options::
>> +	Prints out additional information about how git was built for diagnostic
>> +	purposes.
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
>
>
> It would also be good to update git.txt, which now says:
>
>    Prints the Git suite version that the git program came from
>
> To say e.g. "Dispatches to linkgit:git-version[1], prints the git
> program version".
>
> Or something like that, i.e. to cross-link the two.

That makes sense. Should we do the same for '--help'?

Best regards

Matthias
