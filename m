Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850EC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 08:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF6A61BFD
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 08:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKOIP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 03:15:26 -0500
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:49198
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230115AbhKOIPG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 03:15:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXBI1LFT42UII7dplaq37xGuqBC1s/a4XcLNkkKTeqgOKoHPO5HWeXsb/PLMeH/DReGz+cF8mZ/otV+TtB1SJlBQ+NbszzdmhlI5RxCp0l9rwiJBnbLWB25Ur/jvC/bcIrvP2Z9AesckHKuBeEaiLUNOmGt/V1CDJYv29qzUa6JshBl918AlyAs2iDqgcE2L/occyx+Q5qrCBgyesCvIPZwHn6MjRbL35MWxWB/e4aNJGE+tShlL4PCNEE1QzCKcIYHlZSfo5CjoaPWcSu2aXgUH+Utr7CxlaSxL16/07Wt54UNgy8C03dMtcOHfMdz1uEtLB1+1bNYtx8ohnqjy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI6DxyMttRmWaDPzaNqKU5qM0dR2SyglBZkanvrWAz4=;
 b=Yx07o3Tj3BooQUboShc3Zmn1QORxIJCdJHsd4hf3aLXwwJzYpvvJOQUBcIaRjOXcEI0xh1xVfkOBx1oXeTNDGLX+9Sb7fr9F/GHhm9+fgZFrJeYThouNBR/qgK42IfDWPW30bxE7XKnpyY+PY0P41agVQixaDwhHcO3z7XM2cCBXVSp/5sDFvUWTeLnz6XqjY1VehpX4l5e9wKZUR2eapFj+jOMgkrFVxR7RMmbcP4byJt6lfvUj8cnUJcLeyB4yjbqwSA3NwvZaPr+cj8N6hhfctZof0PMI5i8XYCqrNsRyoyoV0MLovo+8TB2lZOKdJ7qtbKafp2D29bT26Eo62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI6DxyMttRmWaDPzaNqKU5qM0dR2SyglBZkanvrWAz4=;
 b=kYw6+tXVGRTpX6vCI2SWQgFl+5rY10qFquZDHUncrKgkdTaO99TTCmK5lwQ8aeMITXDUJuktCYqTzhAuk6D6mgrh9jCu5rXi2g5bw4ZlXmx1FBahbU59ZbXv+Xd9mnQsTSP1hMkMAUcUxXGAl1Peu6ysVPap+s4CAoTrdgjTHD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 08:12:08 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.022; Mon, 15 Nov 2021
 08:12:08 +0000
Date:   Mon, 15 Nov 2021 09:12:07 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     tqfx su <sutqfx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-subtree
Message-ID: <20211115081207.vpef4i3rdfr7gljy@fs>
References: <CAH6-BcyoEy29-NPCqivWTPoqM0e8=Pp1ahrCaZpBko8cSyv-6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAH6-BcyoEy29-NPCqivWTPoqM0e8=Pp1ahrCaZpBko8cSyv-6Q@mail.gmail.com>
X-ClientProxiedBy: AS8PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::28) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AS8PR04CA0053.eurprd04.prod.outlook.com (2603:10a6:20b:312::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 08:12:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c10d1b-17e7-48e3-da79-08d9a80f9e65
X-MS-TrafficTypeDiagnostic: PR3PR10MB4192:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4192BC2C723042E24DCC35A3B6989@PR3PR10MB4192.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79sBjkh6l6/JsElfsXo863pm1eELZ5lw6dMibVq9y1j0OV035fdumtpdk7ExQ3V7wov7u5M8pFP6bburAQX2D4eiCQJJHL7S//hZOHVJlMYUE3TqQ6vAHfVbmRGx25vSlFpJArA4ohyCWQAY68CBTswRI74xdhVncD80DGVGhFV6jAzVpFuZceTyUwSZCEisk37Ks7oQASqs5Eiz/n0CfP1oeHX5l5fVLLI/t9l7C+q2qwQcxlJIjcyxyAp/k9yKx1DgGUWJKK3OMcWJbqlW9gag4mOCvTcmGsAnZXgdCjK6yViLm0312PGKLQkFZEnu/M8C4rrzTo1e8caXIDdNQnvYVCgO7LD/gi2WI5myhWm+KLMIRr/JKb2cSx5g+qde0I3uLj7FJZfYeZCug9jXOjm7wY7xab3VlSxkoM2YzLBrUgBGkyu+CBnPITF4HagqkT9zEf8kXAKvXkhUPrBL6WBzzLwvkn2X1nlKrdK1xfpROglhDpI3vHO2QvzRlu1alQVtYCXoPL7yU7npBYN1K5X2tIaWZhY52pMUsk1mvTUYOKRg7a0DBNm95df7Tkzmm9K8sQ19K/0rgG88w5O8M5FuPxtJ5jcPcNl2jBC0s0tcOfozba3tG0wzfdxRMiB3/z3NE4I+zflb0kc1USby5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(136003)(366004)(39830400003)(376002)(396003)(186003)(4326008)(53546011)(5660300002)(8676002)(2906002)(83380400001)(52116002)(6486002)(6496006)(508600001)(33716001)(38100700002)(4744005)(3480700007)(9686003)(8936002)(1076003)(66946007)(316002)(66476007)(86362001)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm1zSnVqNVJPR3RFdDNwYkE5VnZZVmd6ejRmdHpXaFJpVHU4RUFhSXNSdGtI?=
 =?utf-8?B?d3JBOThCSTU3ZlRTMDJBQWlwYlZKM0ZlcU1mM3lQaHpSUkZqeDVFOGp1MnBZ?=
 =?utf-8?B?TmNuUGE0dEJqamU0ZGdnMnNlV0hwejYxZkZEa3Bra1ZBbmgvck5KS2FKeUdU?=
 =?utf-8?B?QXE0UjA0TldyM2RZZVFjd28rU2ZRTk45NW5SUTR3Wm1tVDlDOHUrUXlORm56?=
 =?utf-8?B?bmM4SENVa2N4VGdTMlJLcFFlMEFJR3B2dGNKZVNOU1F3Tmp6NTk3eE16RER2?=
 =?utf-8?B?ck9WUHQzZmNPV2tISE5xWFBUeXhESTlxeFdpZ2o5L0Q2T3h2dk9yZjB0ck9a?=
 =?utf-8?B?RHlUVlZISEZyT0FhZ2xKenFkalcvcFFhd0FmMlRDb25qUG9VUGpkUVdLQVdO?=
 =?utf-8?B?RDlhVXhwZmtMTmxaRzcycmVKeTJ2WENVeXF2M3plQWRpTzFHTUcvbTJQMktU?=
 =?utf-8?B?YW1Xb1F3Sk5MNjhJU1FERE5CUFJWa2NVL0xqNWl1a0R4NzRTOGFYMUVMUmNO?=
 =?utf-8?B?eUQwRmpCYzZabGUzalRFYlhnZXhXN3U2cjZqU05OTnFnSURpZVNKY20zWmtP?=
 =?utf-8?B?akM4Qm4rUVFOK1lmRGVZcHVidzBiajhhUWdyK3Nybm1xcnMvSDFGUVNJdEF6?=
 =?utf-8?B?TURVR0pyc3ZXYnhYRVNOVzV1RVJVQVhScy85ZXdWa3dWVzUwNTcrL0Q2MzNp?=
 =?utf-8?B?SUg1UW5GS0FVRWF1dVZHb28zVVExTmJIQUFmM2dkSWpGSS9Wa0MyVXM1WVlq?=
 =?utf-8?B?NEpGYzQ3K1ZQNEpqSDVCOEkrQjdoaE9uYTNINWNXK1o0clQ3dHk3aUk5aHh1?=
 =?utf-8?B?OVllTVVhT2ZFaWZmdjNGcEZCd0ZOaGhhdnhsSHRwdG1oMkFkQU56WDJVeXR1?=
 =?utf-8?B?eDRIODllZEx1RUNLT3M0djBmV25MSTFzVXlNaHhZcCtVM245cytlSGpEakE3?=
 =?utf-8?B?MXVBR2UvYVJIaW5od0FDcWkrbkVNUnVDNWloZ2pCWkpKRTArLzliSEgwSGVI?=
 =?utf-8?B?dWx1bld4STJtN25KRTBjZ1NsSFRjWEN4azYxTTBEb3FSRitLNnBySGR2UStB?=
 =?utf-8?B?UTBTWklYK1d0cFRjUUNveCtKbHhvZmlJUEJEK3Bramt2eGVUWWRGMFlKV1M1?=
 =?utf-8?B?M0xKempYWVpMajlGVHlMUHJiakJGZXNFbCswK2xDeDhpZFQzWXRCaGVPU1lR?=
 =?utf-8?B?VTYxWjRhTEs4a2crRzc0bHJsM0xkbWQ4ZFBJQTBFVWhLbEhPRE81ekZGbnhW?=
 =?utf-8?B?WE9QS3hzMWxyMThaanl3WnlGZ1U5WHA1MjdIbGNnM1k3cjN5ZytpMVF4WGU3?=
 =?utf-8?B?cmlDZjVScXVzN3JlWFZQKzRQeU9Wa2ZIMmhTOGhVU1RNcE5aUUZYT1Yya0Zu?=
 =?utf-8?B?c2FmUS9MRjJrOHV3eGQrSUtiRHJqdGorMUxYd3h1cTFlV2pObktZNG5rL1pE?=
 =?utf-8?B?NURnUG41RllKSmQybUQ5a0FFdU9jbFNsSjFienFmRDVEYVRhTFdObFNYMFpV?=
 =?utf-8?B?Q3oyZ3lOK0JuMlVKMVBjeWQvbmovZFp2azRrUmVVcUFpcWVUMkRBSS96UlI5?=
 =?utf-8?B?QWhRVzR2bmJyWDkrY1h1TjNsdVBHUVB3QWRiYkRaMmM5ZVpXajJTRU43cEpa?=
 =?utf-8?B?MzFCT0c1b09lTU54ekY3Z2xCV3hDTjRkUWpiaDFpYUdEdll0VFRBSzlrbXUx?=
 =?utf-8?B?QUVMMjB5Q3ZXUXdnUXZXWXpmcU94d0NrNm4ySWMwVUdVVnNaalBRYmtvTjE4?=
 =?utf-8?B?WnhNTXY2T0Mvd0pEY1hGMXNIN3VOb2NWS3FkNzdXdmJIZDdRMDNGUjlSTUVT?=
 =?utf-8?B?SEZFbFE3U3JMeml4QkJRMHk4am1FbWZNaTVtZXE2aW5jOWFlSVloeFJRSXha?=
 =?utf-8?B?c25QOVJubUJ0ZmpOeWlMamtId0htL1VTSTBzdEl1WXZDTENRTEpqaDZRQ241?=
 =?utf-8?B?SmxKNVRxOW9iUjVKcW9nL2NIV3JYYWZLTldyQVJQRDRqRnNHRFhldzZROFBH?=
 =?utf-8?B?V1VUclB5cTBvUmthZHB2UmZOdEdPam9KZDFNcU4ycmRCM3NvNE0xY1BDVEFl?=
 =?utf-8?B?dVB2aTdiQjQwRk92dlpuempOWnFCSjhnZm9tdHV6ODcrL3g3VXZ6Ymw1V1J4?=
 =?utf-8?B?bDNhVDRHMWZPcERPMTkyL3JZdlRtNU44dGt1OG5Fc2RhUVRhZkVKSTErVnRF?=
 =?utf-8?B?SzVMSUVNdjBVUERtbWZHSlBsbDRvNk5ENkxNOUxESDNPOWJjNHVuTjdGb2h5?=
 =?utf-8?B?YTZpVzE0b21vWmtHa3JCd2VKekdNK0d5Wk1nOFNVb2FiVkRhYVpTS01UWmF3?=
 =?utf-8?B?V2xGak10OWZ5cWZlSmw4VXVSbnJReHVvRHk5ZDU4bUJibnQvTkZ2Zz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c10d1b-17e7-48e3-da79-08d9a80f9e65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 08:12:08.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cfj6MEJDQthhVJmfvJtnoffHMk0NERRsomn6vfgSC8mY7dhZ3a3eFKeVst5oa79fZZ8JFWT3ofK8spSntKHNlPwoDomv+kL3Hsm52Znrwlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4192
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.11.2021 18:11, tqfx su wrote:
>git maintainers,
>  Can you add a GPG signature option to git-subtree?
>  I do hope you can take the above suggestions into consideration and
>thanks in advance.

Hi,
i suspect you'd like the squash & merge commits the subtree commands
create to be signed? If so you can try simply enabling commit.gpgsign in
your config before doing a subtree operation. This will cause all
commits to be signed. If this works as you expect we could make subtree
pass a "-s" flag for signing on to the commit calls.
