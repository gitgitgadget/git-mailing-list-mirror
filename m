Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A111730
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="OqWM7A/P"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2095.outbound.protection.outlook.com [40.107.116.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51D710C6
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwp9yiqF7EuG00JwPizwqKOduic3WBIhjR3R0+983VSJYDBulRc5F9w1XyzQMybCoELKHeMMN2mrmLGopyTnaW4Gkdeil3ZcT2H84TpL/TFeOSLB+PD88dPLhs+4/4oqhoCw7+noa3fYI8jL6pnsjo/TPVu2q2HUb3TRihn2lfe/KCfPwSbxqnWTD9ZjfHMqOrD3mjhsTwItVWJYpyC08uNu1mOddSPRqPjVG9TWi2uOQKech7UEyDj/+UxBwwU6stNGgNXqBTJzl/Q5CEw8pU8Kny+ry4YmgKFLqaamvPHbWoDGMGZN5UYOO+Vxzj5AYGE71w4h1rOUPqkWDCpVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTt/Bl+xiCILH6UMCLwG5I9Uig/+16ELAppz+NZ+ONE=;
 b=buv0JrwOfvCFMCZbaHyEm5uzSmOWeqWA8OOQG9o/zUvEmuNHm33W/uPNgZhsgdme5FC02qVdsTp+BnrPxUaJy9+hbWeM9vODGLxUt5x3fUAmKFTsfpSB6EYuUcp2cGav88Uvm8+duvlgX+Kgb/jV73RJSqfU37BzpD2QHSbu4VNoFWmtiIx3eiWnDuwuvKAoqberyx/IvNGYBMO3ls5Kpwn6gPkO2eUJaa1Sm+VrBMhY7oW/XrOAvickpuoago0jWqO0PhyEguNjbznR3nLM10PrNw6NUdqt5mqh9wJ3lEcwTU9sPa2nbTwmkuUah9ojQ8lMMtpvj+3Ed4jFmBrX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTt/Bl+xiCILH6UMCLwG5I9Uig/+16ELAppz+NZ+ONE=;
 b=OqWM7A/PPJpVX6+L0QVuSAbNZY0hhhiS0QeGDgEpJfHdv5p4HYoTf5toQSpo7gioabFof0+IJd1JYQ8x28etRDpCVU8xd/SfkPpytw5EXSh0J4/XJDGjq4m9FBbdn4tjj8PlJgaIhn5nvnVe0z4kfxUgm+SxsZkK/YmenjMxV5uRfPbklmoxjNWvtZ89Q/4yV45cSXn/fSyAGT/OKPRSvFa6Llvwe7GPq0qB6enzyUWdK4SoJ1fGbvcsLox3pOYbedy2UOII0iWAysF8MG7jBW5aywO8Vg7+eKGmQzz8uCvu5ZMiDXivZ23vb02fwhVQR6kDHyh4j9Tn5+UkLbBw8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YT3PR01MB5570.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:64::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:01:08 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::855e:3a6d:d436:2903]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::855e:3a6d:d436:2903%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 14:01:08 +0000
Message-ID: <e33f919d-1b6a-4944-ab5d-93ad0d323b68@xiplink.com>
Date: Tue, 24 Oct 2023 10:01:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Charvi Mendiratta <charvi077@gmail.com>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::29) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YT3PR01MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 5368dbc8-5112-457e-c814-08dbd499ac28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uV3Z1iHNpGouDLd4nxRdF7pYrpHgVF8eZqWgrKe9cHJHEroHoQSpBaXd65wkk8hetbvVkIL03yAowmM508OZ5df6EcVQILCsr3Ujr4rD35v1ZsNLDPiUeA8BT4vAGSlE7ENqrNyiCm6QaoGcF2Qyqzwwg97zLeHTEWDQ333YFRAWPzR98HC7as/56sgnfouLbnsVoqFZPR1TWmfaeDhhkzmR7W/h1AUsfVKZ+ezs4Vvc2B3dHhfjbM65y0UC3Pq4cFF1Xwwqo0SY1wNyU+1Uyl1kA/2IlCrOF7maK2ns2ILM+5FkTsxWIfapmX89CjKRIoBZHWqVI7Ls7zMfL+lXc6obxvLQdQgeUylLr1TZUUhxdzdGcZF/R9/XKJgPEufb+PaOFxiqUixBgx1u/Qo2VVcQmFC7dIqtXo/2zYiisGHqeFSWfbCrMMT/tR26sMLL29vyXe9XKoLwU3Z2y8x1wX1NnCwbEiB2VN3RhkFnuF41qHjxhPU4D2ca7lLFtXINVJ9nbAQmoAwgK1sZ+fMDbnV4uEWMiNrIi5Dr7tdWTOH4VNUu6qkgjL27Pyiado05ha4ixZXwHqS7Z6KIp/BlCRs0qP9EU5Aejy7tL631wwCqvgkQJC9Z+miOxg1I4Nf6kD0KJdrj+3Q+TWFnCvcDwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39840400004)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(4001150100001)(38100700002)(2906002)(36756003)(41300700001)(31696002)(5660300002)(86362001)(4326008)(8936002)(8676002)(6506007)(478600001)(26005)(66946007)(54906003)(316002)(2616005)(66476007)(66556008)(83380400001)(6512007)(6486002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ektuMGk4SzJ2Sng5ZnZoRkVBSFI4WGhpZ0twb3JBNEg5WFpWL3JhdWVLRVR4?=
 =?utf-8?B?L003TlVlY0xYd2Z3elJFVzFYUTRUNWgwTDcrc1FuYVlMYzVhZ0hrUGhodWNW?=
 =?utf-8?B?TDRhTFFkSEdjRzJxdTdFb0ZKZFd3dkZWU1JIZE9GQUxzdjlxWmtDTTc1MDhF?=
 =?utf-8?B?VHdqZjAvMkJJc0N0ZlhFWTVMdXdpSDF3T2NkT05UK3M1MXJnQWpMcUNDUS9N?=
 =?utf-8?B?NFA3eXVlNGMwRWVyOGE2UlNydkV4UVBqTzk0Yjg1UVE1ZDExTkJmQk9yNHI2?=
 =?utf-8?B?TjhHVnFBdnBzdCtWeERaeWlLYzV1YXBhUFZNZU5ybVN3TFllRm84bm5CMFMy?=
 =?utf-8?B?MDJDaUdNdGxIYlJIbmttb0Rad2pDZk1iV2xoN2Y1OGpROCtlZTQ5Wld2SXVn?=
 =?utf-8?B?VmsxK2JDWDQ2VFQ4QVFZNjFJallPMmwwV3IwOHlWOWtiNzJjYktHang5L05p?=
 =?utf-8?B?MFdIQjBnRVBqOEtrRnlQanFFajJKK0JueDliU3VSR1FSUDdxeERBVzVDNDV3?=
 =?utf-8?B?NUliMmNEOHcyV0E4YWs3MlUrQWVvSHBMekdreThObzNncXlTZGdvcVJySTFV?=
 =?utf-8?B?WWErYm43ME1QL2FsS1dvUGp5Um5hU2Z4NUFRc2MvUFRQellSdUlEY0VrMW9D?=
 =?utf-8?B?K3pZWUNMWm5teHVYb3pzUmtvOUVhZW9tQVF3djFpZ2xoa2N3WS9PaTNtMGpK?=
 =?utf-8?B?cklXMkt3ZFRkaEFnMEU0YWZoVWJnWEJESjBpd21SRTAzNFZVRGs0ODFyRUdU?=
 =?utf-8?B?RWY2Rjlmb2QvemtEUDRDNjM2Ykhna1ZGWUJrK0NYS2l0RmlNNVNmb0cyR04v?=
 =?utf-8?B?SmFpU29BQUt5enN5RVNGU3RWMkQ3bWhNZjlQZmQ0d2lPQVNMSDZnbnFsZWJP?=
 =?utf-8?B?RDdJNVV4Yk9iOWd3bGY5MWVGNTdrSXo1Mkk3MG1teDcvSzJHNnhYNXlFYzUy?=
 =?utf-8?B?RSt2ZEJkY3JRSHBoWVlLZGVBUkVCbkNocUorbHF2RTN4MHRMaEJtdUdwemFH?=
 =?utf-8?B?TVduZ2pWRWlMOWc3VzRad3NRaWlGMndrY1MxVmlOQ1pDeHIvcytESk9uNVRV?=
 =?utf-8?B?aS9VNFo4cnNXbjFMYWlycjhyVGs0NmZta1FxUnA2N0VjblZWNHh0NGoyaTRY?=
 =?utf-8?B?akp5R1ArYldJbG5sN3E0YVNxaG5XS0VTZWtlZVJ0V1d1MW9oV3FGMXBkZVpq?=
 =?utf-8?B?R3BLWWJvZUluVEd0ZXZIMFBIdUc5Yno3ZFJUdUVESWhuclI0dTA1eHFmb2po?=
 =?utf-8?B?S09LTm8yRTJQRVdUTzZDRHhkUGRJU0lLdWczN1g5TDhDekNOS3dubktoRXYr?=
 =?utf-8?B?OGJ3LzFkVHo3WVVJVUhOU2Q4dHFDMVpWTExXRFZkcGpwQWdId1dHTkhJWk9D?=
 =?utf-8?B?cTVYZm5oM2hwUm93ZmVqY09ReWVpMmxETzRIYWU3T0VvUXVhTkxnU0VsaUVI?=
 =?utf-8?B?Mjh5K0h1WUVpQlNJczFwRVVQQ0tLV3ExY1BMSFRPR2JMWHBvMWt5TTNMOU1p?=
 =?utf-8?B?S1ZBUlRyMUVQMGdNeWtvVThUTVZtNVJDSVVtMXg3R0ZoeDg3eVhXMUU2SmMv?=
 =?utf-8?B?dmRtMGdKc2dCdm9IdDNrM1h5M3REd0FNYnhIK0lIVzE3NE5tR2ZaZlJGL2FQ?=
 =?utf-8?B?UXhxTDlqdjV3QXFWeHZkUHd4NnVIaGJEWmJ4aUNwMkJvZGI3aVRpSTNCSTcy?=
 =?utf-8?B?WHRPMElTVzZTTGloNzZyM0ZMdlk1eU94VWRBTmRMVjNxbEIxSm04SUtodzk1?=
 =?utf-8?B?MWtwNnJicDZDckhRb0lZeWhFUGw4NmVMY2V5MkUyanRMODNHbDJqWW1ML1V4?=
 =?utf-8?B?MWd6L09odzZqK21lU0JqRW9DS3BPdkx4TTJYVjEyQ0lmZTJKdkhGWTZCRzly?=
 =?utf-8?B?WW9xNmN3NHFlWGwxU0dOQlpmL0RoOFRDM2N5d3Z6dGhXSUF3SlVNNGtvQ1ZF?=
 =?utf-8?B?SDdiZGdWMVVCQUp1cWNla2xvSWRqdXBFYlhNNE5DWmgxWWRxU3ZLaEFYNHZz?=
 =?utf-8?B?SDN4OEJNRGNBZUFia3VGNS8ySEl1OWFKVm9UT1ozanBsMG9aOEdSeWJkcFRQ?=
 =?utf-8?B?ZHg5SXlaUG1RVTl1cmwxRDV0YVpybUtFVEpDZz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5368dbc8-5112-457e-c814-08dbd499ac28
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:01:08.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVVTPSAA5OESLJeVOHbkOfgGKoZEyYiGkSdL5Uef/PstJzw2ydng005dkuLQTog3HwJ3M8k101J3gM5S+PWBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5570


On 2023-10-23 09:00, Oswald Buddenhagen wrote:
> Create a clear top-down structure which makes it hopefully unambiguous
> what happens when.
> 
> Also mention the timestamp along with the author - this is primarily
> meant to include the keywords somebody might be searching for, like I
> did a year ago.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> ---
> v2:
> - slight adjustments inspired by marc. however, i left most things
>    unchanged or even went in the opposite direction, because i assume the
>    readers to be sufficiently context-sensitive, and the objective is
>    merely to be not actively confusing. adding redundancy in the name of
>    clarity would just make the text stylistically inferior and arguably
>    harder to read.

I disagree with this on many levels, but your tone seems to brook no 
discussion and I do not want to get into a protracted debate here.

I will only say that, I personally don't read man pages from 
start-to-end like a novel.  I jump to the part that explains the thing I 
need to learn about.  So I think your assumptions about what context a 
reader might have in mind when they see this text are invalid.

Since we have very different notions about who is reading this, I think 
we'll never agree on the final wording.  I'll continue to make my 
suggestions, but I won't stand in the way of these changes if I'm the 
only one who thinks they could be better.

> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> Cc: Christian Couder <christian.couder@gmail.com>
> Cc: Charvi Mendiratta <charvi077@gmail.com>
> Cc: Marc Branchaud <marcnarc@xiplink.com>
> ---
>   Documentation/git-rebase.txt | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e7b39ad244..337df9ef2f 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -890,20 +890,21 @@ command "pick" with the command "reword".
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

s/the command "pick"/the "pick" command/

> +The commit message for the folded commit is the concatenation of the
> +message of the first commit with those of commits identified by "squash"

s/message of the first commit/picked commit's message/

> +commands, omitting those of commits identified by "fixup" commands,
> +unless "fixup -c" is used. In the latter case, the message is obtained
> +only from the "fixup -c" commit (having more than one of these is
> +incorrect).

As Phillip said, this is wrong.  I agree with Phillip that the 
documentation should reflect the actual implementation, not what we hope 
the implementation might be some day.

> +If the resulting commit message is a concatenation of multiple messages,
> +an editor is opened allowing you to edit it. This is also the case for a
> +message obtained via "fixup -c", while using "fixup -C" instead skips
> +the editor; this is analogous to the behavior of `git commit`.
> +The first commit which contributes to the suggested commit message also

s/suggested/folded/ -- with "fixup -C" there is no "suggested" message.


Thanks,

		M.
